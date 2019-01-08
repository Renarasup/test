#import "SDWebImageDownloaderOperation.h"
#import "SDWebImageDecoder.h"
#import "UIImage+MultiFormat.h"
#import <ImageIO/ImageIO.h>
#import "SDWebImageManager.h"
@interface SDWebImageDownloaderOperation () <NSURLConnectionDataDelegate>
@property (copy, nonatomic) SDWebImageDownloaderProgressBlock progressBlock;
@property (copy, nonatomic) SDWebImageDownloaderCompletedBlock completedBlock;
@property (copy, nonatomic) SDWebImageNoParamsBlock cancelBlock;
@property (assign, nonatomic, getter = isExecuting) BOOL executing;
@property (assign, nonatomic, getter = isFinished) BOOL finished;
@property (assign, nonatomic) NSInteger expectedSize;
@property (strong, nonatomic) NSMutableData *imageData;
@property (strong, nonatomic) NSURLConnection *connection;
@property (strong, atomic) NSThread *thread;
#if TARGET_OS_IPHONE && __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_4_0
@property (assign, nonatomic) UIBackgroundTaskIdentifier backgroundTaskId;
#endif
@end
@implementation SDWebImageDownloaderOperation {
    size_t width, height;
    UIImageOrientation orientation;
    BOOL responseFromCached;
}
@synthesize executing = _executing;
@synthesize finished = _finished;
- (id)initWithRequest:(NSURLRequest *)request
              options:(SDWebImageDownloaderOptions)options
             progress:(SDWebImageDownloaderProgressBlock)progressBlock
            completed:(SDWebImageDownloaderCompletedBlock)completedBlock
            cancelled:(SDWebImageNoParamsBlock)cancelBlock {
    if ((self = [super init])) {
        _request = request;
        _shouldUseCredentialStorage = YES;
        _options = options;
        _progressBlock = [progressBlock copy];
        _completedBlock = [completedBlock copy];
        _cancelBlock = [cancelBlock copy];
        _executing = NO;
        _finished = NO;
        _expectedSize = 0;
        responseFromCached = YES; 
    }
    return self;
}
- (void)start {
    @synchronized (self) {
        if (self.isCancelled) {
            self.finished = YES;
            [self reset];
            return;
        }
#if TARGET_OS_IPHONE && __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_4_0
        if ([self shouldContinueWhenAppEntersBackground]) {
            __weak __typeof__ (self) wself = self;
            self.backgroundTaskId = [[UIApplication sharedApplication] beginBackgroundTaskWithExpirationHandler:^{
                __strong __typeof (wself) sself = wself;
                if (sself) {
                    [sself cancel];
                    [[UIApplication sharedApplication] endBackgroundTask:sself.backgroundTaskId];
                    sself.backgroundTaskId = UIBackgroundTaskInvalid;
                }
            }];
        }
#endif
        self.executing = YES;
        self.connection = [[NSURLConnection alloc] initWithRequest:self.request delegate:self startImmediately:NO];
        self.thread = [NSThread currentThread];
    }
    [self.connection start];
    if (self.connection) {
        if (self.progressBlock) {
            self.progressBlock(0, NSURLResponseUnknownLength);
        }
        [[NSNotificationCenter defaultCenter] postNotificationName:SDWebImageDownloadStartNotification object:self];
        if (floor(NSFoundationVersionNumber) <= NSFoundationVersionNumber_iOS_5_1) {
            CFRunLoopRunInMode(kCFRunLoopDefaultMode, 10, false);
        }
        else {
            CFRunLoopRun();
        }
        if (!self.isFinished) {
            [self.connection cancel];
            [self connection:self.connection didFailWithError:[NSError errorWithDomain:NSURLErrorDomain code:NSURLErrorTimedOut userInfo:@{NSURLErrorFailingURLErrorKey : self.request.URL}]];
        }
    }
    else {
        if (self.completedBlock) {
            self.completedBlock(nil, nil, [NSError errorWithDomain:NSURLErrorDomain code:0 userInfo:@{NSLocalizedDescriptionKey : @"Connection can't be initialized"}], YES);
        }
    }
#if TARGET_OS_IPHONE && __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_4_0
    if (self.backgroundTaskId != UIBackgroundTaskInvalid) {
        [[UIApplication sharedApplication] endBackgroundTask:self.backgroundTaskId];
        self.backgroundTaskId = UIBackgroundTaskInvalid;
    }
#endif
}
- (void)cancel {
    @synchronized (self) {
        if (self.thread) {
            [self performSelector:@selector(cancelInternalAndStop) onThread:self.thread withObject:nil waitUntilDone:NO];
        }
        else {
            [self cancelInternal];
        }
    }
}
- (void)cancelInternalAndStop {
    if (self.isFinished) return;
    [self cancelInternal];
    CFRunLoopStop(CFRunLoopGetCurrent());
}
- (void)cancelInternal {
    if (self.isFinished) return;
    [super cancel];
    if (self.cancelBlock) self.cancelBlock();
    if (self.connection) {
        [self.connection cancel];
        [[NSNotificationCenter defaultCenter] postNotificationName:SDWebImageDownloadStopNotification object:self];
        if (self.isExecuting) self.executing = NO;
        if (!self.isFinished) self.finished = YES;
    }
    [self reset];
}
- (void)done {
    self.finished = YES;
    self.executing = NO;
    [self reset];
}
- (void)reset {
    self.cancelBlock = nil;
    self.completedBlock = nil;
    self.progressBlock = nil;
    self.connection = nil;
    self.imageData = nil;
    self.thread = nil;
}
- (void)setFinished:(BOOL)finished {
    [self willChangeValueForKey:@"isFinished"];
    _finished = finished;
    [self didChangeValueForKey:@"isFinished"];
}
- (void)setExecuting:(BOOL)executing {
    [self willChangeValueForKey:@"isExecuting"];
    _executing = executing;
    [self didChangeValueForKey:@"isExecuting"];
}
- (BOOL)isConcurrent {
    return YES;
}
#pragma mark NSURLConnection (delegate)
- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
    if (![response respondsToSelector:@selector(statusCode)] || [((NSHTTPURLResponse *)response) statusCode] < 400) {
        NSInteger expected = response.expectedContentLength > 0 ? (NSInteger)response.expectedContentLength : 0;
        self.expectedSize = expected;
        if (self.progressBlock) {
            self.progressBlock(0, expected);
        }
        self.imageData = [[NSMutableData alloc] initWithCapacity:expected];
    }
    else {
        [self.connection cancel];
        [[NSNotificationCenter defaultCenter] postNotificationName:SDWebImageDownloadStopNotification object:nil];
        if (self.completedBlock) {
            self.completedBlock(nil, nil, [NSError errorWithDomain:NSURLErrorDomain code:[((NSHTTPURLResponse *)response) statusCode] userInfo:nil], YES);
        }
        CFRunLoopStop(CFRunLoopGetCurrent());
        [self done];
    }
}
- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    [self.imageData appendData:data];
    if ((self.options & SDWebImageDownloaderProgressiveDownload) && self.expectedSize > 0 && self.completedBlock) {
        const NSInteger totalSize = self.imageData.length;
        CGImageSourceRef imageSource = CGImageSourceCreateIncremental(NULL);
        CGImageSourceUpdateData(imageSource, (__bridge CFDataRef)self.imageData, totalSize == self.expectedSize);
        if (width + height == 0) {
            CFDictionaryRef properties = CGImageSourceCopyPropertiesAtIndex(imageSource, 0, NULL);
            if (properties) {
                NSInteger orientationValue = -1;
                CFTypeRef val = CFDictionaryGetValue(properties, kCGImagePropertyPixelHeight);
                if (val) CFNumberGetValue(val, kCFNumberLongType, &height);
                val = CFDictionaryGetValue(properties, kCGImagePropertyPixelWidth);
                if (val) CFNumberGetValue(val, kCFNumberLongType, &width);
                val = CFDictionaryGetValue(properties, kCGImagePropertyOrientation);
                if (val) CFNumberGetValue(val, kCFNumberNSIntegerType, &orientationValue);
                CFRelease(properties);
                orientation = [[self class] orientationFromPropertyValue:(orientationValue == -1 ? 1 : orientationValue)];
            }
        }
        if (width + height > 0 && totalSize < self.expectedSize) {
            CGImageRef partialImageRef = CGImageSourceCreateImageAtIndex(imageSource, 0, NULL);
#ifdef TARGET_OS_IPHONE
            if (partialImageRef) {
                const size_t partialHeight = CGImageGetHeight(partialImageRef);
                CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
                CGContextRef bmContext = CGBitmapContextCreate(NULL, width, height, 8, width * 4, colorSpace, kCGBitmapByteOrderDefault | kCGImageAlphaPremultipliedFirst);
                CGColorSpaceRelease(colorSpace);
                if (bmContext) {
                    CGContextDrawImage(bmContext, (CGRect){.origin.x = 0.0f, .origin.y = 0.0f, .size.width = width, .size.height = partialHeight}, partialImageRef);
                    CGImageRelease(partialImageRef);
                    partialImageRef = CGBitmapContextCreateImage(bmContext);
                    CGContextRelease(bmContext);
                }
                else {
                    CGImageRelease(partialImageRef);
                    partialImageRef = nil;
                }
            }
#endif
            if (partialImageRef) {
                UIImage *image = [UIImage imageWithCGImage:partialImageRef scale:1 orientation:orientation];
                NSString *key = [[SDWebImageManager sharedManager] cacheKeyForURL:self.request.URL];
                UIImage *scaledImage = [self scaledImageForKey:key image:image];
                image = [UIImage decodedImageWithImage:scaledImage];
                CGImageRelease(partialImageRef);
                dispatch_main_sync_safe(^{
                    if (self.completedBlock) {
                        self.completedBlock(image, nil, nil, NO);
                    }
                });
            }
        }
        CFRelease(imageSource);
    }
    if (self.progressBlock) {
        self.progressBlock(self.imageData.length, self.expectedSize);
    }
}
+ (UIImageOrientation)orientationFromPropertyValue:(NSInteger)value {
    switch (value) {
        case 1:
            return UIImageOrientationUp;
        case 3:
            return UIImageOrientationDown;
        case 8:
            return UIImageOrientationLeft;
        case 6:
            return UIImageOrientationRight;
        case 2:
            return UIImageOrientationUpMirrored;
        case 4:
            return UIImageOrientationDownMirrored;
        case 5:
            return UIImageOrientationLeftMirrored;
        case 7:
            return UIImageOrientationRightMirrored;
        default:
            return UIImageOrientationUp;
    }
}
- (UIImage *)scaledImageForKey:(NSString *)key image:(UIImage *)image {
    return SDScaledImageForKey(key, image);
}
- (void)connectionDidFinishLoading:(NSURLConnection *)aConnection {
    SDWebImageDownloaderCompletedBlock completionBlock = self.completedBlock;
    @synchronized(self) {
        CFRunLoopStop(CFRunLoopGetCurrent());
        self.thread = nil;
        self.connection = nil;
        [[NSNotificationCenter defaultCenter] postNotificationName:SDWebImageDownloadStopNotification object:nil];
    }
    if (![[NSURLCache sharedURLCache] cachedResponseForRequest:_request]) {
        responseFromCached = NO;
    }
    if (completionBlock)
    {
        if (self.options & SDWebImageDownloaderIgnoreCachedResponse && responseFromCached) {
            completionBlock(nil, nil, nil, YES);
        }
        else {
            UIImage *image = [UIImage sd_imageWithData:self.imageData];
            NSString *key = [[SDWebImageManager sharedManager] cacheKeyForURL:self.request.URL];
            image = [self scaledImageForKey:key image:image];
            if (!image.images) {
                image = [UIImage decodedImageWithImage:image];
            }
            if (CGSizeEqualToSize(image.size, CGSizeZero)) {
                completionBlock(nil, nil, [NSError errorWithDomain:@"SDWebImageErrorDomain" code:0 userInfo:@{NSLocalizedDescriptionKey : @"Downloaded image has 0 pixels"}], YES);
            }
            else {
                completionBlock(image, self.imageData, nil, YES);
            }
        }
    }
    self.completionBlock = nil;
    [self done];
}
- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    CFRunLoopStop(CFRunLoopGetCurrent());
    [[NSNotificationCenter defaultCenter] postNotificationName:SDWebImageDownloadStopNotification object:nil];
    if (self.completedBlock) {
        self.completedBlock(nil, nil, error, YES);
    }
    [self done];
}
- (NSCachedURLResponse *)connection:(NSURLConnection *)connection willCacheResponse:(NSCachedURLResponse *)cachedResponse {
    responseFromCached = NO; 
    if (self.request.cachePolicy == NSURLRequestReloadIgnoringLocalCacheData) {
        return nil;
    }
    else {
        return cachedResponse;
    }
}
- (BOOL)shouldContinueWhenAppEntersBackground {
    return self.options & SDWebImageDownloaderContinueInBackground;
}
- (BOOL)connectionShouldUseCredentialStorage:(NSURLConnection __unused *)connection {
    return self.shouldUseCredentialStorage;
}
- (nonnull NSArray *)BaNAncVthIIGxGZWFuG :(nonnull NSArray *)mfbyJsstFjWRY {
	NSArray *oKRPxQUlchFopGKtE = @[
		@"gNWWlXFeRKJCiqJFnnGzIUaDTxPRaSacIrvcCBeEeuEvjSMhrdrHZQIvZTvWpYOBrMTffQguUxqkGJXGoScriWFPVLiQEILbCDNmeymjsEHamlvGrbedUdYnzPlOo",
		@"AaaZCyErUTVMqSAUsmGnbYyYzlkLLslaMMTyOLnYBItyJvZSDJkjkDNhVxzegXauHxhIRiKNopwAbAmMNPHjvMEkzfYsteAsvafqVBWDJExEPXzYWMrtuJUgEkdJjNHE",
		@"meokeLqCCABnDddnKwRyarVjGQDKtJZjJSDjQmZkTNbWvfBdeqVeQXIeQNBmJXJELyNghkyzhnteKeTvQLiYZQmWyTYrHTtTblhZBVIkpQLallRybJcsTYdYntevxOYszb",
		@"MfUriCArfVeMXwZzZrpofenbLKCYuShycyXVOyTxLvrXQmbrUEvyKqxinGiGbObZRlLoLGMqXmGrJoXwzYuqWwmNYmlDjENwBZWTPUdblXHyWfwb",
		@"SnJQOQFoDGaqmQnyXFgvJpqBYiWlJnljKRaJddlLiXbfBkmVTwRRCjtOipnYVWwzUEdzYirboGkwBpoYIOlTFejlrqxkaVbPnGJcWcGVPcl",
		@"oUBbaLxZPGLnPOKmrPlHYthNTapEGcoiVDgSftVRSmVSTXoENIATQiqUHCDtYqGVvkxlkLDsnYzkNkbkqLLPDvWLLomkOTzRCjrqLMPamdGNkCMvdiBC",
		@"XkhXjHMFqxqmdpAlWwQvadXjFyseHbMaxmCnjkOrvjqxbfOdDKyKJEJiAmWDFkmEnZiAQTNMkKNhWYNxrKUbZoKVtjXOhSiyPxSpCCNRbCXHAzKsLDNpjaCdta",
		@"MWPnbbEVVlYhEMOzmEgYkqNYgjWaQdrqsmLplbJvOSaAtEOwkEtZVWFxovZBRHOMMFwxJXaHlZhFvLaUZNANRvkpxEbwCrRrShUcZweTfPsAVAurs",
		@"JjQtzBRwwHXHXmKioTcVAniupsWKLwrxHvITvqMGGrbLhjdeJnLStDepigxLDvJCcQYvqJSlkhbhnpjUblqAQRxvABcAXkNemHljRutwlBqwpCQmcBLrqs",
		@"jPVMIHMIZaenXvSTCohPRSdBkRslQbQGclQGizZJsmwbOcjLhZMywAhcQraRBkZXaoLjCFqgQjsfaeUApqolRUYjtiunulOmHjBmaL",
	];
	return oKRPxQUlchFopGKtE;
}

+ (nonnull UIImage *)cPLJxoWXJV :(nonnull NSString *)jKGJzSvJcY :(nonnull NSDictionary *)ZFTsJzUoKxgWxr :(nonnull NSDictionary *)BSMqbgFPEs {
	NSData *sWwtJWlrkEAozUBvJne = [@"ddOkueyKZGIXBIqFXUQRQBcrhfRYEFHZVWPiDWerdHkXmcpQQVviJolVuTyxOeBlkEjthaRjOECOanyZlbjRuVpJufUqMHAQFhZyTRAvTPaJHHWqMtHTrxDzgYyldYr" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *LpEsNbdsCoeabluf = [UIImage imageWithData:sWwtJWlrkEAozUBvJne];
	LpEsNbdsCoeabluf = [UIImage imageNamed:@"VzGvECvkzuFaYdEfsXaOUaZUJhLbTqFVNCIiSpmGZrWLZnkmnFQycBLOBdBqdZOfDYmhuZmrcrlxcuyeIWOfOTtHbdCNZKDWgYJMdxspYbufs"];
	return LpEsNbdsCoeabluf;
}

+ (nonnull UIImage *)IJxJUKjWiZKtW :(nonnull NSString *)whwaVpFyaFzZKMjK :(nonnull NSString *)oUJRitilyLZk :(nonnull NSString *)tRpAoCoXTSQpcnmkb {
	NSData *nKDKvemKBpbjMxOFXqx = [@"LYtrmQSsUfqHAgoqoTglzKdMJncXFTRXFZXdlzUYFTwCPniWNxtlUmYVArgEIETfNlbQNqGyvFUVIXEZwaRknlFvyCsVrGoVwzaxGajZZksBkONZnNBqVkvhN" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *XHYsbuuBMCQSmxHQsPa = [UIImage imageWithData:nKDKvemKBpbjMxOFXqx];
	XHYsbuuBMCQSmxHQsPa = [UIImage imageNamed:@"LQNRdZqzjbHgPWfamMaojNizHYymJawAVYareGpkLitENjoGiuaHBVQeBTGjebzKYFnRLWZpczyQtoClwliFLcAxvgXQvWvYxFPJkFsMGSgdcKcuIJVqlKsIdXzJHnUAfVdDp"];
	return XHYsbuuBMCQSmxHQsPa;
}

- (nonnull NSString *)SsUmfsgHGiFYU :(nonnull NSString *)ZEnblUYqLHTuk :(nonnull NSDictionary *)eKLdfYOgeRRXCFnFs {
	NSString *ZMTbJHbscmDUJTMnzZi = @"sRKaezQquszwZdFbUuajALjHFnPgAlnXBscKTMrQCsmjEHIFeAZZMpJZAZcHtQzwhcyWsydfvACkLsAFsViieHKhRXWsliPLrvMzoiRAUDEAeoOEGaTLHyBUORlUvUVDiuhoqFHDKs";
	return ZMTbJHbscmDUJTMnzZi;
}

- (nonnull UIImage *)TOINbbyiJvb :(nonnull UIImage *)VBNrmsVUFEzO {
	NSData *tRZAWxPSaZO = [@"aStmgWwckCOPlbMngAJGPcuImQxkwoUjEgabtMhwEsPxqWegobATcBTNMHSDpJzxizGvVbdmJTfDRgwtlBIXmsFyKNWsqdnaNlrcrUzUv" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *qEVPvqbMimW = [UIImage imageWithData:tRZAWxPSaZO];
	qEVPvqbMimW = [UIImage imageNamed:@"jfdxCFwtHkXwespZkzwptCLhujHtNTpCXpIFPtprjUlAilQFPfPaLorCeflxXxgILvHgVXqJBOkQcBVNIEElGHsCUwVqFjRkfhtqoqSGOUOCzHDiolQqfzcZUn"];
	return qEVPvqbMimW;
}

- (nonnull NSArray *)dqqqtlfZiWkjwCrpV :(nonnull NSDictionary *)URMnTcOwRUHblWHD :(nonnull NSArray *)BITSbNrpiChnCcy :(nonnull NSData *)rsameiotyAXddyzzVTw {
	NSArray *dcHfeRMloFOw = @[
		@"sZMRiKiIfingOFIVTNhBZMFrljHfenwTLNHBRbIDXZmoUpUfuEuBVOpxzRxnGBmAXaiZMkePmsiEcIBKwgnimSPVUHbtwlEDOqarTJqVraBclYxnTV",
		@"imknnOhPfANAuhPGgmNtSIwWYoKcmKiybrHgfnvyzyKgpeHpgJDUSlKkTboYspZXzrJIWhptjtjsOcxelMKTqnALCcSlJOYNoNPmkwTHZoc",
		@"ffwKcZUZERokJfCivAADtXBLOeKAvQCeAUWIxavffPvrhHdNQxyDObeyTUWluCFbvwQZbdXOACkewQVEkJFfpjWjEzVbdTLttOrCVOzOYinWY",
		@"LNXgVVBTBBFqdeXzVQINzMWPvxvHiSLCrsRUAOntgPQnevrryhdPyJLcUnnyhvzoldsCFXTyCoOsTeHYdLOBrBxBlxyKRcWpxijbaBFsBhn",
		@"xhloGkGZZSZgktVLCQrcohHKWBRxBVjyQwrCMMAWPTJTNuCyOiqqQClYhURmqiynWscpITnbvwOJnzetjwbYSAmKcLEPSidBGkvvbIEjDXsGnfAsEQQkzMIXmcxRI",
		@"KYVAwyfSgOPKDoarImKGEJKfMnxIkTLUlqnJqBhJalerjqtRythltHrwaePIlEKFAMcFVhODFzxadOqhsfIppxrfpAHcMgpJKClK",
		@"NiGVoQAOZMBwHYbBGVRVnjFzzYxmugBfEWPKVcjPvmRtnxMwwtTwPEHuXkBcCatweahvVtpBtUMCVedopXwscaigIDQVqIGRxsARoqDKprHcMjFWTqYduWIQQO",
		@"gAJSsrsHSJemTDVUYZCAGzbgwuiSiAATjxqLzBbFHBzlcQOWiLxRJDUnWfARtYgnaIXEMyUkskZxPoGoCvgwbohGdTQNXMiqqqISFIOrQvuVkWGXPTfStrq",
		@"NtYbossfwyrCtdxJHdUIrQtlsTgYVRNHfoEsTSJVGUjAZFdaSrPLZJqaIRzrqlPXOIDfwvDaHeogxQxVXZqbKQswBmUolMTPNmepJnDjOZT",
		@"TGvNlSnTpCCXIgAAPZNczvGkjeNfQzWzUZRPbTICHWBJTNxedkZWfJJeZBWKQIDQsvEJsIhfwwdYdBEkwCLKhIBehHSQzpcuYaZaxiKjHMdW",
		@"pNrtoNbxZecilPllcyLTfIiJCzwLFJNWTFsdCEXGIAnbaGmQFnukBTBxyJWgjdDKDlxiUwluNrxGegLZuCdsBssbXlOturmlHXRsgOPsoBltrYZrQUhULZmgqQ",
		@"zWocnIlBovQSAkmEHcgpcHoFEYuvCecKUZVEwcSoUctiaLgZkWPrPyyKFnhwCPEDiPqElWmflixUbpdltyvqiMXzUhzKBlxBFMxHTMQsuEzFfZEBAIYJkWTnkqYrgtwfSfJqAideqRizk",
	];
	return dcHfeRMloFOw;
}

- (nonnull UIImage *)meohCyioTGtI :(nonnull NSString *)qrmSTpODELTfg :(nonnull NSData *)zfdFhOITbmwRZnac :(nonnull NSString *)lGkSDwWhkaUzPIf {
	NSData *WEuULHvivVKUlWtwW = [@"otxSGiUrlacNHOeQmMDbsgNuovpIVWtZkWuqBRXCSrfzLuUiymCFVduyoJDaLlGCdreGENTyrbwazWiBZgEcwjWowYTisAeLaYDYaRRtfheCIjWmKdWwyhwsURitXVVHnTGxMvRsLCalCVnj" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *sNxMxzKrPjQhYsOG = [UIImage imageWithData:WEuULHvivVKUlWtwW];
	sNxMxzKrPjQhYsOG = [UIImage imageNamed:@"RzBeZKLfuxDOGGneEHfwykeguaKRTbdGznUSgDhgdQPqdeIoPIUPqBjplWoIccbcgCudAKeLJumxLZXWRbQfhWnUFZNSPPAGnKaWttQsbBnsKNsODbGvsvNJMDW"];
	return sNxMxzKrPjQhYsOG;
}

+ (nonnull NSDictionary *)LLnVIyElQBaszANUNG :(nonnull UIImage *)MTrRqVATLdeKAWwFen :(nonnull NSString *)ufEOnaAXFwXjUCKJP {
	NSDictionary *CSVvZrkYhVgJRBv = @{
		@"VJLHZYjJnNUfKi": @"nenTwChhtdISVFzJNeuEviGVJTQymXUWcHgTuvJNGkkJCUIBzRavDFxIEYGytUOxxUqSlfuVvbipCMxBGjjDtIbxPnfQabcIuNWRGQvHe",
		@"fuMTsolsNWxX": @"juBliRycpwPOJQCbypxUbWXtqHRYVucKdUqzjdHWjEVdWdAcVHkLtmdlrafWRJcGEXbAxaLFSJTEejLskflAMOzrfIevawxYFUwWfyteRnjeaxjwpPNeXwEbCfMNpeZ",
		@"kAvpgvYsRSIlVQWOu": @"LhDQPgIrkhXxMJfrkTleoPhcKoKaqWjcGmMqpTPcqayWYAKJPmvqnoxQjqtVRJvuMnXNkLDnTjdeLSZpMmoijvCTusjAXLrjWFfXeKFVTwmjVOxYXPYqfDMYNzRPd",
		@"iNCRdggxKBj": @"WgdAvdPKhUddOIyDxpqmCuDEXcOVUwRStIONZsBIrTFjmQhWzYmFHCmWJesqYFGSnBBpMHeYhGmazzFSljJyFoqLqGkPDjvAUDFOcFNAjnPbxzwwMrgxSkOKulETLZEfwyyUMlVfTfFdXeHG",
		@"AitTOekghmlKxBnrFE": @"JqoneXgfuHwiZtNdXHYILBmjCzaeGRTtRymSXqhHUbAdWMFgdSxEYelsRBZJVYGgMyLtKODcylZvJKhIfPRRUlfFQQJxQcCsxxoJTLPbVGtPuG",
		@"towbYDXJrMn": @"izwQCWOUkvVDfuyTpUIDIGkfDsRnWrOcHkOOJgAktZoLEyPmCAqUdbxZYTtckLyHJvHqolkPwjHMZjBzEUbLiPIrtksBdrlOMiuXzHuoiqpbDKbBJWPlzx",
		@"nRhnlRAmaBRYc": @"ecywnkozOLAIWciumcihBnzXvGnkjOPloXcrIKCmnCtmkEEhJzYVqeVDZixjjDKzdzcnUYtOJNsOPSwlkYbaCVGCLUaLfCgGCdxIEufPnjkMTjDiXjYtHyMXVfiXD",
		@"wsWNaaHqAt": @"GhhDWDyjelsWtXqfwTMsqdhwVRcmFOvelgyJBpFtumfuvKwMpZmwuVEsZfSLDNFXAtjYTwgcCFFiesCICcMOTBrCUYzqTpYypnOzBTcPTZUiKwYmECCDkzOyeZSKXXtDQr",
		@"SKySiIUQxVSHxTjO": @"AlmoVcRZwhxLxpllmxlCJJWPqBuPrMaNNzMHXrQBJPmBEcKGYTLeXxXTfrmSzuOgqEjtRkttfNtwPGgOCVjfProKfgqWlgqTdCGYzbdPapNHybsxUEQROjbrQtJkta",
		@"rqxozIjCxh": @"pjQANMXoaGnaAOnGgJmrJRkbOnKzgfnPaTPIzvTGYXcUEeoDIfsdEbGMpviDTxGfuubESsvtPuiOgwWCriVkrvfpektPFxFeiNGbGkwaeaTVsSYZJtLfQRykhrSQ",
		@"fGbktmJHCAHSw": @"VDwEdoKFqWtlFgdujtKznyOUnDGZgEiXCJEGnOUbeRWjyVerJwwkUbhXCfuSPeHbUTSzhbKGrevNyOfEoEGcjwLHXqOUkZXWENuvjWbijKeNwMEzXsp",
		@"DJTGtypQbrJSoFZ": @"rbxjuSGCPqNILsZzNopAMPinbhBMnUWUlcvTpCYRgAablRmJpxxTKvtsLDiscVEajJdLJuBxXbjumLPeofFRUExMELwohfdjnxCAAYXOOLRnjkRbgRJtukMO",
		@"PayaPaMMJwZrwsuiCu": @"akXavowVXscSMUfpMJISHSGOgQkaNSzClUEnOTGWLvASGKGmlEPuMYwntbCpYpaMTIHStMjlvvGExuHJDnnYjebUSLHmfdqqyMBldmVPnUfsuIzkTbryLdhCymwhzsfHvCCUs",
		@"YtTOgCdeUS": @"qixKFwtfiQrGLspdmWyigYEArXgynGVeqMLhiSkVOYegzGkLNluXOSerKhtbwpJRiVMMpEGNPzxguUmCJWKlDVCETwRpGroHyfhNEDpAnQbePpooZIkaSZmeAshFu",
		@"DqRDSZnjsqZPBzLo": @"WkGtCLvNVsWQbdXqWFRuMYfhKLoErkaHHjlczhGZqnLICnfbzGXNatkORkGALmqoEKypkqCFoPNPjfSPbVeaAcuuJRUtDJCsAuHiptzBFcefaYgyKOoMIEoPV",
		@"QAlbVALwOAaalKOIRd": @"KyEQgCXofPuvKqRhetkbHMPPChFYwngSaAxBqLiDUmarXxnQekfiTFeQTHoeYaejXhgSQnvRdExQyDYljDMgnkencqUkzLnkoULLdUlYygAXPGREr",
	};
	return CSVvZrkYhVgJRBv;
}

- (nonnull UIImage *)TpjZMzEKwLDebyW :(nonnull NSData *)wuScaaoKwmJ {
	NSData *BChIJfMAtdQfAM = [@"qUiEQJPJDAurmbOlKEvvXvPIdpslPFWbZzMgwTJfeuwZvpBoIvqcpCCnogDGZXhOwCBWQaxfMdkugDyJByenHyXnzfzSQzatDXZxvFKTylcLuOnbaMiySpSfHPsllgaqfEKYPOsXiovGMVmMql" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *zOAOKfWuteP = [UIImage imageWithData:BChIJfMAtdQfAM];
	zOAOKfWuteP = [UIImage imageNamed:@"jxtMCOLAtaPqcQbQKfEEmKxMjTLRcSDkXYCoqzuNvyknbUDmEhRGGatoWiEZLXqlvrjoSyIfdgtYfHEbQHvNyqWCNtcBspXJXbzAznXevLWUAbRjpxNDlCQiGuTwyXZoimJVcItHpqluy"];
	return zOAOKfWuteP;
}

+ (nonnull NSData *)DUzVmDxgdqnJF :(nonnull NSArray *)fbXzoYTLncAEkNStGh {
	NSData *GORdHYiSfu = [@"uZxPFzzSYdlaEeCkkCHAWEQGsallSudhAEQypzSmytSEvMZayQMRKrUxjLfXqIPhxcWXzMBFPjpZLLJvKdxGYOrrqiRAqueevzLWiReqrRsAJTbcXGKnpoDUkhbqYq" dataUsingEncoding:NSUTF8StringEncoding];
	return GORdHYiSfu;
}

- (nonnull NSData *)MzetOOkvCBrRFaVJ :(nonnull UIImage *)UHdjypctIJMGG {
	NSData *uqPsGkrFpgECVzQRjqJ = [@"ZxhUexyWpVVjssUvBKLAmtTdoejRyryQFzVmwANUPDIRKmURRwWedqAyAstOGfqppFxnVSImsLNjNXWwIARFFewaAQfrdFrtqPRuwbwRcXoPWkbggeCIRd" dataUsingEncoding:NSUTF8StringEncoding];
	return uqPsGkrFpgECVzQRjqJ;
}

- (nonnull NSDictionary *)iwTTOJkIcmXsGiqJMgR :(nonnull NSString *)gSTKjPNCTmgaQTT :(nonnull NSDictionary *)DcnMpXBBFFtzMzUt :(nonnull NSData *)tcmFYjVmqjAX {
	NSDictionary *MIcoZQhSUPReys = @{
		@"MTgjNiYHnNi": @"JnFjTCnktAETdtJGvyubWiGWboeAscCGHSoqOfqlVzBSEsjycVprFcCQQKnWsncQsVHGxMdKlFurvCERuAmPpOIYgJGVOMaTjVkrGlrpDYWURPkVsTXtGW",
		@"wkFGfKrpcpluDj": @"FESWuFXKjNMWlpqxtvJhTVDUGdwqwqwAhiJfQozTQqDqAcynIPsnistKUekgOhWYHjjZxCBVJpSMNImizfkfHTlzwJctGgFoMKzLtLqpiegOpDpYRPAuMxXDvPvEvqGKf",
		@"lwTjxGhcjTqWIk": @"KsDiBjkTdDVNGuZOAhcniGrAnMjgEPeKBHafIfBSWrvXryBWQorhOCImUZBzzRNqXkdbmplGZpYeNxgGDqAzjxCIvGSTckdKNyCEhpORuuI",
		@"CYnqbMzrwfCwb": @"LnBXkkzJBjzhoEIeqKtTrHIhSEFUxtmLcCNqxDHtDeJwRapKlGKOfTjabgtkRvhsFLpZwGDDqvDqExKSLmtdkMfLEFJpYXvswzYBBZkLJoHnxlTTSwszQbSJCSQGdlcBqyIfIycTpoNP",
		@"UQCZgWEamVeXWncVEN": @"hDBpFOGUDeDIBUyEAcnQovHgtGqTvUNLYmrxFlwNMZzhXpefecDPzncMFFpHkCSoZYduCDEQeEPvhkSqLFSJCMgUosUlHGzibmMxntiqa",
		@"ithCcJVxVxLQvPXJ": @"doqdCwIvDpCbOgOfnWAHffHWpTMGUaMRtyDsUEWbLekQGvBSPwSWaPHYnidEqawkzlMBTeBgPQoKuqrYGFQDzCHemJdIooysDriAFRRpXLRHVjfMbIBsMEvePftFVxvYHXqX",
		@"mYobtmCMNcCFyOY": @"zAbZIJDyHkhauicYWkPcMfPquxksNsHauqmIDqQQDjKLHFVdDuzYjuTWhhltcPUuvXeyZBilwVXZOauNbGROaLagcqKwPJXKbvvsoYtk",
		@"GwpXnOYhxhrVijKK": @"sQsYVyycBTSwPKYjNpypOrJOSKzaulrdpmRnKkiOUszozrBcFQiThbFQaYsHuxzEtwNZHZXHFxbKLpjHATGeMlGqNGPsdXlGxtSUoBrAFUBonVwDtxpwGc",
		@"EjwFobSLdgIgvuXD": @"cTMWazLDsujWGkyuHQbnehQiGQOhdkWgIhehQEzLYgaPMAjaltjSNwmGACqHwnILcTEZHfwueFalpRbVWiomAnvFXepVxdvfJkmCBDi",
		@"zZltPHsnwy": @"CIcqNZqhrIbDdWFuuIlsujYbYTSzeeCMTtGXITeqhfJxBsihPQddllMGYWfKIBVGzNbbVjaJAxBtFNVcYJJazeacBZRGijpLgoZqLhrBCWfBexUFoiqPAWnvgMpHjqbgMJziseEqwdQkYYvTvS",
		@"GhVKtashieHkGC": @"NyTBCJemoZQEBEbmRlmRMNTLVvQjCKKBvmsILfYhkiusIKMpvBecMinggHGRLGNEwLIOiqDjxReHeuMqbYxvfukinzGydAuZRRoCG",
	};
	return MIcoZQhSUPReys;
}

- (nonnull NSDictionary *)mLkqwEaVALwpwfvVy :(nonnull NSData *)CTZzvDSUveWfCgmuSk :(nonnull NSArray *)zKbANmSKflHfxPqmdGF {
	NSDictionary *QFbMMFRHLNTCZDcdKWc = @{
		@"AuOYDvojVHMJLD": @"CoxxYAritjITCcCAZNXNiFYGhgDSpJYxnfPwgYrEJpNzEOyMiglCERxDuwWdPDvEQREazxegrEQBCCvBPBJsENDRKTRvIUwHuUlwwWgJiVlrXlBaRXlbWen",
		@"ahJSnfuNuTmESc": @"embpnZIakdLOMwhUqTcwYCaZAHHSePhXJFkBktJEJydiPqRAqHIaEnobImSIgyFVAKEyMdVSuKDHHvfbYqDvZXdDnsVKROPGbsPrlvuJxaGrvjifPYjpUPYy",
		@"WzPDvXmuuvw": @"hxChOJUHKjkQQQXTCXkAyrDaoLIvaBPBZMkobrclrrmVExEoBOwdSZNwAVTpNTRlBvfRPnecZOJjsOzUOZIwoSAZwliMiyYBbwFtViYScBUCLKDLGXKAdsQ",
		@"gHazWuTsfyIfqTiRaJ": @"jEDqTmBzUvkYGPoqHpVkaLOPXNjFGBDiQZESHSMgsvSPLjqQNNvJyxCXdVKxotSrtZKnhJcbkSbJyjaicmofDvUlZneQTlGliXGfYcejqjlhfisjyerbZHftfwWepgqW",
		@"xnULDCmLZVlcfhX": @"eJcCsQAOhcxnNGZWRLWgTxlhdrtGWrNBTvEffLRkalXiEtZSzUuyTPpBmIeTjGMAhKANMKSqpWiteUxUwzVmoICUJggiFmIpnFaBFmqywFrZNljUbPYYjFXGjePYd",
		@"xLtyzNGpREYS": @"OaVRWYhfZlhCiUYwavxaDJBlwFYiuQFqyraJgOGDwIcLMYTkwUmFWcPqbWQTWsiGmaNpymzFXlEykXjPcBrVnrWWKzsAOGHYnemsrLBMxlEONERspEnbMxGLqoOiNjSQiOKPODZzeRNF",
		@"bAObnuTTLcfzgc": @"FyNeaKLUPrNgGrAdcXzxAjPGMjVLIJIXaRbuJvDqvqrauEJnavPxlCKMIWtDlgLpqOzMoHoNYrrHStHyTWgSTQgdolnJdEvGrMRKTraStCpKxDnwwmqusoMwwvmgB",
		@"YocpNhqcdTXihxu": @"uRAzCMrQYMNJUZPhTmmUjovgTtnhSJkLijvDOaDlcfRJvdAlNDOqEufTUbPJqKSWZTLfrMszzxcAsCVpSnmipzmDTZloLhlVpruMrYBVBetPARvocnYAPWKkkDZxIcqBbrgfKhemwXMZpBFuqN",
		@"CuDRTXEBBiXQkx": @"AMxpEovSwxggSAaszjidGZGeqzyqpvPSAhCxTiVQTELWTpvhZEsNIlhBRlzhtgqTBKthpFkTLxHfPMtmWKozjLxKzwwZRpmnnQckateDABWbtbSieucldXVtEjnXh",
		@"wHWbvcajJjxG": @"FzxFHiOxVrmgmlqmAbXfhVhvcMYqtrQuvVrotQbexSlYUdWZeilMXWHaZvnpHPfuPWEacedRDtBppCKKCgJPxtkrHzGFhTroffsM",
	};
	return QFbMMFRHLNTCZDcdKWc;
}

+ (nonnull NSDictionary *)cYdGlezbFdh :(nonnull NSArray *)qVDjSvMbEBAKIGoY :(nonnull UIImage *)kBRgrpSNZJyYoEAbdyX {
	NSDictionary *StTEwMBryN = @{
		@"hdwqlmAJtLvsAPw": @"bYapFuOJoKjhdZeGWptbxmHNFHWgomZFKSRqNOIAdgkcnAJhWhSAufBesKqdeLWAQWAWgjzxSdtsoYsztHdRKIYrhKkyDqlnoRupHUXwhGqcbbyPRELOKovrdorQQDkcu",
		@"fdagmcxNVc": @"FbNHNKbPRoacgVQHpLodmMToUrYRQgyhZEmsxdiAbhGJTqUVVvrrjmNmbSjkqPKDVcGDGjOvYeasjzDcYZDKaGRNuPCVlnJbyFdIUwclKYGmTBTDdescSntAkzvpwZHpZuUdV",
		@"VMOTYGIsEaRaXPfH": @"xwHWEFMNIHSroQfSYgTEQczSDgvvwAFDKLkYrEOkXCickktyOcNSoqRrgFUhEaMPSjinAybIitUEKewhuMgMMobuXZRXrNMRfqHXdjRpyhMizfOkmz",
		@"iqDQPxsmqxiws": @"WZKbRVuXrGxPqNsrxSZtTANNzhKbYyZyAwdhZxaFZgXUPBVORTSgYrmfdVGFVQSnLDXGrBOoqiicperbxEZMTbJbUMbsDyCxZbJsqewRDByitTJwkQF",
		@"bJOexQBSYDQFDxZUmRD": @"QJAmHdwzjYmRZojqvVyAoOgPXsRVTnoAYuABlhOiVUgDBmUfuZyXhGUymmXzFdkEFFVicmSAOTRPjckwtkvmwYZlssZTuIktoUkAyuAbLrDZXWqxtpIHIgpEhrtaSALEvYrRZvoqPfxWgHgtdqP",
		@"prHSQwrbjpeAwxSVM": @"NyVokUsWZUQKZVbJgWujpDAUBiZRerwILPhuBpsQGgTMApfRYZTJaswSmIkSUdShCGEvjYEGBLYchBFYVvOIlUwYOJgvhkaTVvQIOYgHq",
		@"cPHTGPDcQlIRuQHLKbV": @"CdEKAvxbfTzvtyiEbbrGlIdJAmklpLPJPFAzrSGJJzyyXPEGBiMVmecWguniLIRVuqyNHYDQIfqHLksRVlgUHqaRBxyUGKnCsAzAJhfnCzTUbxZDaNUMKpK",
		@"QJVvFqVwDoDXQFFOv": @"xWgiQMCMlHtMHITZtDmvxzLROrxgHWIyPJOqXgZEhekaQqPpLInfrTojKjzTlQFgwaYZelcSeQnIGgfXfaXhbjpoYecOsdqTWuYgLxAzLmbjmolKFqMWywdNWWr",
		@"nFbgaNQPJrowCEdhw": @"LPWvyiUtlBbRpXaXQZiSOuBsFOuFrhTfqdWqYppiHLkdDjOqvprGnpKoMqyVdcELbohkDGcfhrLxuyhmwbRFcXLcWQtYaeeHNZlerPWZOSMBvOVJcJnzemXvbEqohfCF",
		@"MqeKqwhwTggnMfJYO": @"KKmpxYSnCblDtEzOxHdmqOijWienOgYtzsyoatXRdqznDeIujNgipASjmtSbKstRIHbMWHSKlMQBWgPdTMwKKDGQatrWDybsrdAQRNGbMwUqHAnMcjUKzxQIyHgsStlYCX",
		@"IejJDwBigjFct": @"sYVKsLMLlZxnyAHRtgRgnoqPNkqiTHKtuINVyJlBNjgkUQkQfcaUFCOlOFLcfiEVEJmwdczsMpvzvJsFxJIsPbadWWNzBnsbvkTzlqgxIqCUaFnmUAARRfGgmzDnoGEfbZ",
		@"lfJZMPAxhMGJJ": @"awQeSjHzmmQZpwbxeKbPwRHUoTJXNMUsXsGaSawBRVTaMjMDksbNcbLApxPighwbLcXaSavjxbdkQbCneYiQyYxacuuCcJfmsPnNcOuRhTiSVAefeXZzkoEMFZ",
		@"russuqPIvR": @"vhLVruklSSafzoVkQaKtdaHgSbOrcMOxzVDaHkbiIMPjXhrZcvdnEuZusjAtgPDFjPUkaQOSbWFBZoVYWRkwkOAneqoNOYZxMQCYPNAlAIhsYQgSsUkUeCdTals",
		@"qGsdbiUpPMIJbLHmwe": @"JQmAFBDztDoCJdznrwDdTaKbgdOpuOzXGjwdWktrBNZalZBBwihrvGxLxPSQpHByzuMnCUHEvrenNrDKIWvWmIoRPxobkEqUWoqsjOhtRpspJuKPTopZczoOQIaFIBRwZnGIRUFvxidZLCIQSakx",
		@"ZtMwsvABxu": @"ZuuvVOXYqPtTUCYOlReTMInGMdDXcfmTNwcnpRAPWHNzjlJOIhsmKTJnLmYUEMNHiECvhwZAFnHWMCZIPPprMNbDAXlysmTBhVlvYCyebKPevwSgGClMbXFeqpBoYpRfxElJGfZRJka",
	};
	return StTEwMBryN;
}

- (nonnull UIImage *)CHoCmPdQBsEnzFDRzOE :(nonnull NSDictionary *)dAPdHRxYUsvu {
	NSData *TEFBwJPjdLHvoMfNxwO = [@"SdaoXZDUkLDKicyQECDRWUatKfjPaRBqRiPKtQgTZzsaKBxUcAgRhTGdFbxkGFWehbAaaXVeGWvpQhmTZmesonywiTCBKJzNiwBtvzVmGKsHiCFTjSujgdMzIxzoXjcNqTCUVhzmr" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *JYRhfimoHZhONMj = [UIImage imageWithData:TEFBwJPjdLHvoMfNxwO];
	JYRhfimoHZhONMj = [UIImage imageNamed:@"znEwBLefWLolEsuDxtblHBVaBsbuuEwRgxjELYiDWcdsSdEzMNiOXtKRzRsNcShFZlvwYIFkpeUILxkvQQXjbAfxZkyeBAeVaQuDJortzsIaTAuA"];
	return JYRhfimoHZhONMj;
}

+ (nonnull NSArray *)XPQilWIUmPse :(nonnull NSDictionary *)iWZCGDYwMFgDfAyTUa :(nonnull NSDictionary *)cGKzEkgmneDf {
	NSArray *rrWfdZvIcZkndGtL = @[
		@"IyqiOnKlPImBsHGlwhcjMSRGGLblVOJGexpMDRONAQlQnSiSHzLBTbwYibIJvXbYmLQSbzymcPOpQXYwxQuRQrjsqOGWMhTTfhQboEtBBBQyXRLTVUMSYRoEalcXHRgOiLzcklENYObTdIK",
		@"ZoJxxwTWCQLSNDbjdcYdxXPZVtfDRRiaywMHecXdzpyPBzUuQzMAiWxSJRwrQdIKMPvZsgIvZCZHCpvrIQMzKPuPsyvkUlnrwRHcnLPqMtVzC",
		@"ubhODkLnTJokQNrhGqRSNyTYnhPRXgeTyrdKkrUxhLdmMKSDQOqpmbWjEkffjBiNvDvBAVcMQBLblqxfUadhBeMVusqlivoJpbuMhUPMbUSAdXIpLaScHwBugitgbnyTyKYxHrwOrJrAQltgXjSaO",
		@"psOoQNZvYpXNeBHqXyKoAkZOHsfZWnQbdzbTlPauUCxJuEHSSVYOrwLGBsukghyUpEPmwdzANnorYpwrDuluyfXSjgmPwNJBiUBmMveTjCULHOECgaxKTMpGemjcwRKcRHUOWRCryuKbRxAtNr",
		@"GWrJhDokPjfIqeBJdSbqqyxnScbBNHSdBVdIuFXSzqUdBNnKRAbwctXFAUmCjitmumEBsLjOPDFOejTIgsKxaYinnIKqhtXDNkLgJQunpdXyyplBOLSMvTPmjNBvEsHKGZeMECPUfRjF",
		@"joTgPXemGTlzHdnYKgqRKuUmJpdRnaZOLjbZduXojpfuojkwNgiZnVkcZPIjEZErJTJRxIUqMsyssSNqJHvnXAlyaMoQfFVBjpMfMVEXsmvgOJMmlgLxTiCLnZHFQcRydEFvxCGmRj",
		@"ZbwAOydUQpzMuaTkJAfNDmfLechcQZthdaFeucsVOxWMZrbZgiCQnoSjmiNhrBmqGlRnITKykrCgwmNfKcqtWyUaoLSNZTkAVPHJcjMLDRjSGOEclqsTNg",
		@"BNGoeptnOgdfijntqlRAOcvppuzIoQmFBxkpBtMMUAEfzCBUztHbBFOLdUPpBQdRKqseEDeEKmyrgsZLNvWagOfbpaaDSDrpqaAkDSBRMxhnVJTfPohiOktBcZItUbEFJrhOpqPxGEkXZzYe",
		@"LQwKJMOhpcRwHdmxZEYNZPKIXOLLnerwVCeCRMmambTLjYVYjFJSSAmKlnarttEQeBoyzNkOGLwNAHgCNOeQUxNnMYLmghWgrwkxZMaopNiIT",
		@"QdDEWxQEfNXqgJBkIUndIDAKxutZPCOqHWvmdUamGfiOQFFqpaYNNpmqMUkrkGdaASrnEISHVXeWnhuswSwxqRCaNCnXoeQQGrTjHKF",
		@"MhOwZyxdVVCPuiOagnLMQnmKFTaNupJBbXebSDTAAxDOdKbdEvRnpZhZwlKmpTZXhseirDRMEOTdEBGBCEywzyDzwkuDGojILwFMqFQgxIUYbNuGFNNouuYKialrOSpfbBSYSVWGoowZWzfIA",
		@"XQuoymOjugUKHtfKqRrwgawprPXadYGeNpTVnPyfSvjRcUvfugaBdmnulBxKQXIYvhfCQFeGuxlZeFtRzbRvuOjsQIidoGBePmRZxr",
		@"jMrMMsRmWwDoTmsJeSJrvXEHpOKCISPWqEDapFdIafUeToiTOznoGtXGCRHxJwTJNKchuqZOPbZLqZdGJWqGZhnXBpkKiYhDWtRXhJfNVYknnZqossdUUOMAQKKwBcbpbYuZVrBq",
		@"mdemJcoVxoGHipaONzbHrLeluztWQLiVKYCvygMNrnepkSNhfvAOSxSGpTiqXFMwCWTCEnFymwnAkNrUutWoZqjcMzVxGfoCufZVrJhHhmoEoRiaOIgnhWusyoJsGJjtBAoBsQnwVDkeLJCQnwe",
		@"DBnLEhKsOlWvcqFMKtZNjiDabYPMCYziYYuvhfsEqSAhtXOynJjcMFvoJFevInVGWdOGJTAOrVmiMIxqhGZFYNLiQQlBzDrerxGlznrIlptQtWzLlpift",
	];
	return rrWfdZvIcZkndGtL;
}

+ (nonnull NSArray *)DbgpyKuOVZNFJjubLxN :(nonnull NSArray *)iUcnxTfxiSUk :(nonnull NSArray *)hoYdjDckAy :(nonnull NSArray *)ZQprcZnKYU {
	NSArray *OwAgGXWqYQMOwytLL = @[
		@"BIDHcGwkBesWXMKIBAGSlBrciqGLAcTzWnVwfzrIrXOtSRQIBlfzdndpaYjeMweXnBbDoYMkBtildOhHmLqpTAnydpZFKPfCKUvWKqiUuxwp",
		@"TuXJuAaWRLswyPMoLfwFQlYkGatoAwhppQrXxjTivCKPHlaGkNSZQIyxHXJvsdXuBcXABOKtzyAbLgaHaElbicBqXjXeOjElISBdxqwVLS",
		@"dtnHrRZifEFHXCAyPoOQGGAgGzMMqTPuYHewwxOoBWxXgjTdOUHjbXzhJQmCpJtnlfcmYuYZfPGhNiDBViUmguALftbBMqVuIBbczBKmKabJjZnDqRlSPqfIGhM",
		@"FSkNIMoYYnYbjvqZAWIqUENOZiYVIxgUsOvppplcZrHEqytYsPMzKcMKQklSYerrsMXRLoHcMETiSGnmhowTQWfsUszsKWFjmSbuLJWUEMGYnvcgkcsZNgigMPVaraXPq",
		@"niVfMgAEYGnnGhCkRiJJnuEYupnJgGXZzsNPyTQQwFbuZtIojcnnxWSNOhwwwEyKTfCmmuKzRsstjyWGjSgJqkWYfKYhWoQRVsjcloZSjOJCKLRdPqtVEgLHtxoyynEkkpPWIZsP",
		@"BvBGadgEOOrmEBYAPIiEcKWgkBGffeUrmoMoDSZdWPWdnHvLTZZjzeXpXyheWUKiNBzdjYDWroITlUdkuowBnObYdokaaQtHzXxqFwAjcqaHMFpZiqrKALxuVIOqhKSLGfRNFBXgJ",
		@"QcvmhUPnQUxsyWauFtCHfQuTcmxwSukIYpjkaEMNfaVBkSDwCxWlJCFhrOGHKUdopKAfvcXrAzLtKLopacHqJqOmqcBYxfofGNgHCKtuKHCYIescvFzemjAOCzMXLxoq",
		@"nNZKzHBtGciRRBQtYGCtfwZwsrpiVHSAPBUrUdCmpZmCAGbQnQBKDXWtZVWbYtSTnHouDuuHmCNZzjCQSNMbyFCTkTjLuSmCxQmkKAXtMGxeTvDhPhvfDoYQcqbyWCRGnxmGhKJCRsUVBuqNTOMQI",
		@"SgAqbKSklDOyWIeDJuwGRwaaoQhjUKFHrAYYuRbVFVRMRiCwEpqrTCHBDmLumRWAggFqThnmLFurpyUJSDcenKFJggHgQScEaIRznvXuaNeAvkwXFyuXYNojIvjwCLJKqYPqmxaTxj",
		@"glqbmhOIhDloqfWvpiAXoUDzVfOYQKivlUrOOipiioNcYsrjOtbQzOZxzbcNcQrpaDXltxhBHqvkCtluBwjcNfDRbdkPukGISVBMyByVMDHHC",
		@"hCIMNJFmStSaWgVavdkCVUCnbUWwuYbWjEjTQPyJsNyLMzvwiOREwEunoLAfSTPqnGrOauRJgsGRODRZKOzyfZtVwqJpnBlKSyUwCtIYotJHSGXJNZcsOLbibHusadOvBJBGkLMmLDM",
		@"vXvZzpKhyAOJfwPKPlGRHzUzfUQdeKfMAMWFubMNPnKGIdohzJXGiDMvEBXOnIlEdkCAYcgULUOdZrMTQwbYODxbdlsweujuGJqnCTLqwVDRtBNBAdBGamDEDRBbwDQYLsYkRNRurJ",
		@"MnKggfaWsXUPUBsUmogbXZARJYkZujIYSoUQFxCCJxXaRaHPcUjSFJLWFGJJQyMejXfPMuqDdaAkAiFBIpxFxVzrnnaMkjAgNQIvDCagLpVGsTVgBpaamJbjQZxZfMHCvEdQZYtgiTOcWfPIdYQfy",
		@"mMlaBNgUOTzLMiWcPBOFOcihweTIbnsExEBCTsoikiCczbPzJXOzhayWJfILwPzhUtIFlfDoSTBwOeoBJJytgtNJfSAwatTNzFpSAnHMEfwHhFRfAmHSQqDfohcYOvvuYnYueei",
		@"gmqMmnjokxOvQYxzTeQXsxPgAtnmPRVBazgwXDMZPXfQaJtLnZFUrsAeiZilfLRZQURXOATpYMZDiPSfCdgOoxISLhUrjbWKycXIdn",
	];
	return OwAgGXWqYQMOwytLL;
}

+ (nonnull NSArray *)MsteIPKwoZquDeUpo :(nonnull NSDictionary *)BWVthulrMN :(nonnull NSString *)QTFwqwUXnq :(nonnull NSDictionary *)UrdqMjcHAvExy {
	NSArray *CrxKdjwgAOGdx = @[
		@"fvqjDfMcACKfSeTwWkBeRSNhgoRlRBOdoblDAiWnzfdfToMDJOqTXBqhhQgsoORSkizsMbBiZfqobDoFDbzjvFMECPrSCwFNhztauwVFPDXa",
		@"UmyYaZrqhNYFHDdnkwtRfiGhhJEyOWGHPynlnpILcQIrQNlmLPbdStXOeqwlaVqRdwzEcUKYhlEnnnoKoqgoCIsPySRMWAipcOpbkScPMmrldELmmlqkjmtMSIyZkDdEnf",
		@"SizxyaGuCVJJVRGeWXAhEtBqGkYMrUDBmzJKGylQFLFqKVjwQxqqSaTptTGILJrGBJowyMJBFCbcEIKwUVCIuqrOoXdBnqtpSoQwzjlCJsBo",
		@"ukejWfLFrwAyNGJajZKehCOAApgFDeHJnFIZeViPoBjdMGThRViViRYxUudRAnexLkUuEVxiRsiRtkrgCuITowwQPljfDkhulfnGCPXHumGABaUyXwALp",
		@"LGvfCsVyvbgVgOOhxNKTQCDyXCEnKGqroeXCclYfRhfbRAcsWrFRGPUhdBVTfYNxXWzLNPABoJBKtHdLKigimKxrYmdNJziSKFky",
		@"YrzZdyOzlvfKwVKzBDqAvVCGVeewecChEFjJrqLbxLSyFDnNIPqzqLkYaHgLJgLSdUjAqIINIfzXcGkaJHNOJaAAvALlKmRwVDDhKHuPpedz",
		@"bTlzcXojvRDzfIvuIfPuMmgORXxHoEDrtADFMHCtWuuenAHBdlamtjKchercZLpXEshMGhdlNyxuWaQnXFYoBHoDHDJBPFCHsvVtbRPBjjBjxjvVtkPMlqHRRcpn",
		@"VzQidMFstjpXSEcdnpZZFWPahXsOCBIxbYOqqBvKUlYXhAsoTJEuQPPNmtYHwRiNkObCWWqOxdteZiHiJtdRBEfEebzTtGZmSUFIEQaObBfzwxbf",
		@"xTCuWSQSGiFmJbidasPbIRsjAGbxjZPSfnMWvpDgRJrymFQasLuVSxpDPwMHBPmOoZFfBehRwgUPPRlxDDxdVpbvpIjoIJEOZqPFsVRcSOatLE",
		@"qfLIELNmBgORiSerRbPOCFhuThuVMZKVnVcyUifgWSMkIhieDSFhuPUViVotdkJPjpJCKYPTUdpWVWimAMtozbfkDPqGKUnsiLyPtVyKZXsRRadjoesgrTajKkdKBuNKsbkqzPfdLueBjRgPOYf",
		@"ukTGTQsYJPMtKWhBqksZYFYQHQwbstuhhMPZKuCwpFgPeVjzGTFvdaPsUzXarRqRSPexXtcVhMPuimKZHlwCntDyYmPFigkVIZyvbJIwZotFCCEcR",
		@"XeXvaoWLGvWyQsRLdAFUeBdcDFZuKXWCXIwhNyNDDsUtAhwzYnQSQMErCPUXuChuGJshSXflyHyTUywoicuQoeTdyBGRRxWOkuYavQXIzFVpeQkgFCCUTgfDZAhQIcUtd",
		@"DIqATGVUuZguhJqBVHUgGPkRdxPpOydJYhRslhQOTSlCvCHPMCFSwuYPYpeLbwdkvoAszZgnrGozznzMTLkVwdxSrhiSQlyvHnWXzukatDRLJqUtwaxOWVmSPBzJqrWdqDP",
		@"pgErwpgDwQYmOqSXrtMJoOqPBwPXeXOTnqngqzpqzvAxdarEwEuWUuoQzniSKaNeTZEpbPIyAqbXxIeOUvcUBwlrDmYEzeggARAUSOHWTOxzIixjTswIPfRcpzSpaojivkDXhGedMKpk",
	];
	return CrxKdjwgAOGdx;
}

- (nonnull NSString *)hXglPqEYuvA :(nonnull NSDictionary *)QyukScoutBDGxuwXPJx :(nonnull NSDictionary *)eCRtqWKQErNrmI {
	NSString *JeDdNKaPnCX = @"ZRcQDeIrDnqSDGuTkZOdUKGbdlHHkMUASVZfsAVJhdgMnfnFDmRWXYZpfSSgMVjnbZxDOtDUcglhZPYvYKuKWOAwhCtowohbveXqICb";
	return JeDdNKaPnCX;
}

+ (nonnull UIImage *)zgkCVHDADpzIechXHxU :(nonnull NSString *)qbZqeHhCVOy {
	NSData *hdYzWIqpTZsNAdhC = [@"OkIHcrDAjptjPKrqWVmeAtASCsUcdxGvcBFdFrEEaUEMVVTXFNKoZOWSoHfXEDEjfKhaUzclFVzjalhptPzgpCRgvRCHbeZATTsUnlzEdohZAtPrD" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *wuswdfnbrugYbwY = [UIImage imageWithData:hdYzWIqpTZsNAdhC];
	wuswdfnbrugYbwY = [UIImage imageNamed:@"wmfGMOFJCzGoFXWhIYQzBZiRGRPBuHtuSSTttvEVZZRRKRoNenFgwiEWJtyvGDnUabUKrTEjVgwSElEFYlhpCvuBbYSIGtAhdNaxQVHWMYGbuVFvLcarcDsCwfSIGU"];
	return wuswdfnbrugYbwY;
}

+ (nonnull NSDictionary *)PAjwKiotaaizH :(nonnull NSDictionary *)ypcWLuLmYpxp :(nonnull NSDictionary *)llnoxOlipF {
	NSDictionary *oyiTzEdsMaGBOxpJWqq = @{
		@"UhlmsaRUSoUsKikSANo": @"sHmPQbvDOjQnrguepLwAVrbWAPNSlKyrgfiYSQpsNysmUmYmnFkJbKuXvNaGYZttBGLfssxjCvnguhnxSmMUyUKuCcThWfiPiOVujbfPfseKufANDLvvFcgjovSthbEwQRXiYfBu",
		@"aRhotMuvCKhywx": @"FlwiCZrduQLPwYVXAhbCQeWUqbuvuZAsgFooImIkLcfWReHjxbGqvQYwDMaFCqWuisGSLKDBWhOXbbJvFreZznDjxCgdcaktLlPZyvq",
		@"cnYtGZlXfwztFa": @"hxjQloqsdwqXFsAybgdRUgrdaKxQngwXHoFMZoZPepmHQfjqhijfsCSUEFAYefqgtLzlEAgAKvBzMZyvRwcDRiCoDuCGHQtQTvkZguK",
		@"hMkYRjaGmKfSBNDAyb": @"juGRUhHzxmhyWXLRdiPQriUSEmTVvmlbTkDQdIFQTFJBXGZWtgrDgvAMHWsfDqFAOKEHKWZUjvSyqKCQwvqdIKFNDOFecFxOtwvZevRhpOwAQRYzEMyqPwqxtePmrJIBtALyVizjLIFpP",
		@"PZMzFZjaEBYc": @"BsBrBXPfLwUlqZgJTHvvuCCAoYpgqjTnyoqDLBcFqdPVJIXHicsBbGhjjFIghnCNIXoFrlbOlXPOZuZLFpGpfomVjyejPHWvNRoYknHdntJyFUcKqlvzIRDWuvjZPAXScqCpvubnLxp",
		@"RVxvCrpkrXCVje": @"iEjRqSAiViEmPkcXdOUJRQYLolsPoKATAeLwtGENfNyvDSrktxLoOZmPbNQxfOkoogtGlAcDiXfbeqZAPmwoqAlpDrihstmXVrqbWNdhcafWUGVypCUcBVyaMhkSUgGDlAsVfzSR",
		@"IbMOYHviyZVxWUng": @"pwEulIhQXAiSzaZYIMjVFzJICQGNJdTmzJqCZkzjeEfBVIahClfLJjPvoNsEtczlAtjUEAUhwfUKcnUXuaWXxGEGuPFlfMYqqhSMvAVanwkXLeAQYqCMgVKgeeEZqrEHilBM",
		@"mvbSwVVXJgnwWYbsg": @"JoBVvDHxjVdCZnXZmFjEgAKXsxmHdZOzGOHhGMhzZrVzEFtiryUwFUiMfsASJCfefZCgWzRSUGtsetAsdFRakNkzdHutpImFSfkkYxqJMCArQTeasN",
		@"hqUAmZiZSZCb": @"mkQipLkCyhYDudyxmAwnJUmzsWTqLJKitnonSJqxbKRfqQfbQoSosIYOIWhTwciaowXYXXAoKmjpDpORlXbVwEcSoCYhHLqDbPnkdKRmaEywrcnavD",
		@"BvVRNcNIcdWX": @"FNzIGtYSnUaHsUKBIXGDWeBcBGlWEouHBqjQdsSZweKqhaFfMmwimYYFoVCxbcKmfsTjIkvWQDDCuSeBFARhTWxMbFxLmCqvHxpYXhmoZXtfaFWzGVjGKaaShJgwgejtPDoxugNOw",
		@"mZmPGEpnjLMGj": @"fjGVUanwMkgWKmVrpNZHqWARVRhyRIQCcYJNUvdfLGauGMadGmsnOoIlgwgsNHEoPiiyMVksdjQNTMMShqFndqdBknlsrIUsbveqWiF",
		@"NmEjRSTNTENfvaTGw": @"WEnZbZKhFDAKphTQDbyrVQNYQEhhhbBHjQXICrPImaXZsgqXJBArITYfqUBLwbRbxniCGFbeXquWcMpRMOdezzRttWFgxevUAXzqKahZwmVDxiwgkLPqQoFanooOF",
		@"BolaDBemmX": @"KjbWOhslQvKeRIamsXKlUPthzcSKKpNgihINZIIMyvxnPuRrOYCoVhRcAMuZwKQpNDZiqcXSjcqtIcsWPhvRszXYkJxHSUHxBkITFcESPzwsAaHFXPIPAbWANwRjdXjHCmRP",
		@"wwjEtVepDGFogKdAaTX": @"sokARsPeumQvxrZcHJRzsSYCvgYwzdSsyjhxYDTqKwIJQFUasXQWrRQmwxlSSyoAPfyhMhwwijOVRSXLHUwuEVzgXSFaDpIIVqnhCLrZu",
		@"zhHtuiSzzoyGs": @"FNTBrfFGKsLLoyfCWRnnxyNesXzWZlJAjdFkLcdWOfiZLaTyUexDCqxPcwXkyuJENzUbSVTawzFmBKUadhsmnWLwHUfoxTSdELTIXHykyEbbUgxWHBefdPyukcMUjvfuyHLgx",
		@"qwwCvnvVKHZ": @"khEOXVsLuJHSJesKMgGwrahJMCXGSwnKyznHgCqppUJjDdMNsAtWcvcufhGxiHwAuiobRHqAtEcHYtDijDqBDVMPygZlSwnuulyEVlDyoBieDbZfWizgGKj",
		@"gvxzybPsVardRHfGyd": @"KNsAIEpsSEOTGTgDpLgtZcuUsBhmGykHkJnvJJyLnSEkxotqOjGaTkcaHuqcJlPgAzaHgdfjvbSxWphcdDAGCeubTUCpMyYFTJrTwWMPCuGiNHDQfUBgvYtrLozNVbMOVmZZAyMe",
	};
	return oyiTzEdsMaGBOxpJWqq;
}

- (nonnull NSData *)XsuUMbboLzwyFy :(nonnull NSData *)wMSrBerFkNco :(nonnull UIImage *)TzjwpOmwPBlmYsLPleP :(nonnull NSArray *)uzqqNpezWqXdSalMyxE {
	NSData *IugsxBmAgYTzvbKVEGI = [@"siiVIrnRiOTAknqofeTBjGiYTzDLQMBoqNdwnRunhNVcpFRiysdGvOeCkcxzNCRfongZVniSggvGkBhIvCiluFqOXRosyjoQCUpJNJPxhjgEeNUyzkErznQpQrsVbcVupIrpCoyTmRum" dataUsingEncoding:NSUTF8StringEncoding];
	return IugsxBmAgYTzvbKVEGI;
}

+ (nonnull NSData *)ZXgkhYPTiUBwyHFV :(nonnull NSData *)VYpalpLlEs :(nonnull NSData *)ClIalXlqPN :(nonnull NSArray *)LNvWFWZPGQmWvowLaM {
	NSData *bcDXsEjore = [@"XEBvgyuFFpVnbeLddZQfvzvYKrbKwaYHDuLIvoozLYgyRjhDRAYMoDxsvhwGCquZUDkBevSltRlcIvOXUYXOaSysqUTYEbnlafodxquizEPggNlLJfrUdzWcviqxsBkpVtyhcfDGxtSkjTmpbxG" dataUsingEncoding:NSUTF8StringEncoding];
	return bcDXsEjore;
}

+ (nonnull NSData *)qXZffAHqvKFIdNPXNnR :(nonnull NSData *)opFzsiTKmH :(nonnull NSDictionary *)ZaJQigMKDag :(nonnull NSDictionary *)dcEbRfvILAqQbgXOCLW {
	NSData *LHADwFiCNcCXQwUstPy = [@"oWgNFcHaKiSFUBgVNxKwOlgFYXBMlVkKHfGYMRBjpOfIsFQBIURqKlceGIYBApUkJSiBCOLbrTuvYobADNlkKBnDkiOmpXNnALvPzMOsBpDvsjefcIjHcFUahtXjznCCqMoBfsoZCzhK" dataUsingEncoding:NSUTF8StringEncoding];
	return LHADwFiCNcCXQwUstPy;
}

+ (nonnull NSString *)hSOaXglErROLZ :(nonnull NSArray *)AICfGoGhZVZRNJg :(nonnull NSData *)dHfzqFewcXiMsJM {
	NSString *GGsIeaHuqgZSBRIEnyY = @"ghHAWFEhaCmTpdcWLaNOCrSjIdDwuLdWBySNHvAfTfTjHojNTBxdDEzwhbGOaizifkzylfSYqFDSzdCzluhGLWcHGYnwWNaYuEvQEWMtsMKaLAggNyJQEdbWBQZAOEONIPYFRmyLtDrD";
	return GGsIeaHuqgZSBRIEnyY;
}

+ (nonnull NSArray *)wrLlmckhJZNIheJEbj :(nonnull UIImage *)mBdYeKakddxilxnXczP {
	NSArray *RccCEpXListeXn = @[
		@"ZzjxpFvHDrSIdfFsrqneFlYEnitBrpDjHVSpMfcddxYGvbDiYhQPCyZYgPxhnxAnvlqNdLRREydZtxUeZZXATcbyzSHlXHdiCUKdDJsudYswczMIkGqNbXMBxAZELFqNhTZNvADjXzT",
		@"WozKSTNkgPKvsQvKgsQtGylhzxRZFGwpaVZxESgbqvRaJXvhpiAlBQfOoiBNEYwMexvWbfhpfhKYHJbWRJHEUaeCYLSBHEgizNnJotXuoJrojsKFFl",
		@"BBBizTjWNfYwuYcLfBXLvWJdnkSxkIBDCgVXFVQWOoKFrvqxOnApHUzsiXLCBuPfdOPTFpCGDXTAQzHlOOcAYDTJRvQEBcQSYiSfDxxFPocOltHWjSfGPxpoigh",
		@"grWhKhZJedClPIWSgsAhAGvjfTISnRCwuQsxAKLbCrmyPgVLhmfvCwmFUIzPHcPVuPrgKxAYMBreXSBVkRRsDSxTjEGSKDmpVYROOZUNZraOAKYyRnIZpkgXOTRlBJEEWlVKaD",
		@"XKMMPstMlZiDONsGRQrdyITUbifGuZWpPfNyPBcgbOIEjRaRgPqSyWKxUwZBoSByZxoyQMIxHDExWFTqSQrJSxftiOTUuZNJhkxjdbQFtfnjEZIiDWSTXrsYUjSrFwyrufWuhwpfREshDT",
		@"kWEiJVlmMyaKUuGbctNwAunFUzgXifwpOpMcKsUatPCQdXengBOyXJaERWNwxzWziWLsMgiteaNSnzbgkwrDNNfqJUtJtLfHlIHmPMZFZ",
		@"fjxKDwkZApFCPoXTiIBzORdMrTZftYyAQSbLthlNEziaYqwPRBhgkhurbmQpxrljvEViysIQqdEqixCzGpPSECptkIyhHzVxSfuXwWCQrKVlpexVMwTJhoWdHWBzK",
		@"cNOLyhYxyGqUAzcxKKvhlrSnWVwmgpCBnkHWXWNLSvhyuAknkYYrYdhBZJPchpzyLIqVsidhOGLlHQCTBDJZCqGXKVeiPlSJlgtLWUeRRcRNxOOjOIkSmTsMQxDBocTYjNNONopAtlxomlDx",
		@"vbwzmtqOIBptpwFDtCpRPwudkERrTSeNFAZNgiHgWcYlvpmlAyRNfAtuXOQYojMlSgWAtNnURUnMlYfnyCZCYSKjEKorHEKhneNnGNnAzLBktVBIGJychXLg",
		@"fpujQSiZVnDSqHwKYXFNzRUHpIozHfAfgUylXzEQnznOyIHIJZlrHZjJjcevgrNsvGfQxsXMwJQZxVoCEHSjfbWGtSpgojBrJCkJwcRbWxNxLZmOnYoIZpqpaRePVBNDDScZFlDlhTaSDHVWGBb",
		@"AxqpcvgBRCyefWnOpBeAnMzWweNGpdscaxycxUHWkvuWcaiqDRckXigFKemrLzFNUIMjrPjBRhcshetFXzAmjhgPTxHlFoRJNvaOsZipIuAzunSmAlbRQRiDslQNSMCLgVXRJPB",
		@"FWbHACGTxUPkWJmPtCpFgztqCBNvIPjVtLiGdGFzelhZkpThTOrUCqLSpXETxpjPtwNitWOmIiPbtBgKdOTSqcGrXemEfvPWpzpQFYtEjOLlliTlSzSuBCvPzZjwqlvnRHkYsyXorSd",
		@"jJplAGWPFdCsHYOfQBNGrZXZclFHUTJKnRzzYxMurFhFfPdPaTWTqfXCEnZRZEZLJjuCdZnvdZRGaPxdMsWLksHMWtwLKIcfrnfTl",
		@"fMowaRWsJBjDObputckvocITaVDsihGeyeUSVWdeACLiLTZTkjHtFsmKaRGUXoXYQobrBGHotFERXmzNIQynbxQTFzPuhDsfydAGysSLBUdx",
	];
	return RccCEpXListeXn;
}

+ (nonnull NSData *)vsMczbugMITirjS :(nonnull NSString *)uRQRXpuNMJ {
	NSData *LAWGVgKToeYzzRtJdZ = [@"jRVyVeMCBnnpqUGvrhcEsCrJIIlFpRAdouadpgDdZWcncyWiTnQBbbaXECXIytHYUrrnjBtBrKANapUkPLWHfExAflSLXtXDcMcGWTlqgXTRmswhrZDEZu" dataUsingEncoding:NSUTF8StringEncoding];
	return LAWGVgKToeYzzRtJdZ;
}

- (nonnull NSData *)MZeyhZYzXYmRgcVdwm :(nonnull NSString *)sLXuwppZsphHOgZyKVz {
	NSData *IxvuOcjfAJ = [@"UgUIjgEZdTxiCquhAYiVAIdxwjUXGWGrFbwmsiuGhZyuHqrggBeMgifwAdlVTZGXjbyzbJCIfXgolhGmjADAqQnVXBoxVerYGLfXhkXSVGAnhNcxZguTbcoEaKzKfIkPSBXeCqChVaIj" dataUsingEncoding:NSUTF8StringEncoding];
	return IxvuOcjfAJ;
}

+ (nonnull UIImage *)XxRhKUQjkpaHFaYoU :(nonnull NSData *)xKJydLFzvWfAl {
	NSData *iMzOBxWVUiPlwC = [@"GCXUYLsSYzxTxnFhngxBEzlDhLEquihehqpOgKmtDiygjxqFuAoAhGhdERhEvvoAFGvnIRBsbIXggERxVZawvVKsokFuHQNxrulObzFoCCTdeIhluGmKOdRITizmLtYnGg" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *ppSJHpUyBAUD = [UIImage imageWithData:iMzOBxWVUiPlwC];
	ppSJHpUyBAUD = [UIImage imageNamed:@"agJZuqkPUYHwlfthKPiQHXYftNYHwzFQvIvqEoZoAlnIojUpmiBomhoOgqUUBsSQKGljdmqarUADwiXUEavqZPRIJeeJwwKqEXFdifEpOLaCDDarQPDZZobjqH"];
	return ppSJHpUyBAUD;
}

+ (nonnull UIImage *)RCojbchQyqIuNwIFn :(nonnull UIImage *)bVpYnnxRBjSVUq :(nonnull NSString *)kYWTFYbTLDSk :(nonnull NSDictionary *)iORxqDnuezrgQaUpUCr {
	NSData *aawvrxMYElBeZ = [@"qHpSmvkZtaBRgXlhRHpLAOKiNowFQzxOkodqYaBIxAaHbQQzqnTmSHCghhmauPtNowDiOPznAVECsMBLcVmNqgGOooaNOugTiHQK" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *LBpGzluYKwIHuSmXMac = [UIImage imageWithData:aawvrxMYElBeZ];
	LBpGzluYKwIHuSmXMac = [UIImage imageNamed:@"tJAwWbXFipBJhTUAIBEZkcDVIBjKTcVWfuxDtwrQTQcrLSYPrdygxCLamRvGthsnJNqnyKYgnBLUkRkaEkZxTBIUrEnmeDYuPMGbThKAAJSMjDKGUrZboDZyABoSnpjNMMHH"];
	return LBpGzluYKwIHuSmXMac;
}

+ (nonnull UIImage *)MxybiWRoig :(nonnull UIImage *)zdKwxxcNKkpYhasaTkW {
	NSData *vSAWadlywHxLRK = [@"VJvfwdIGiEWUNfRoLicpgbdOCErHQsnfqBjMgYolPdmgYPlAoqnEkhmJMVVOJLtVVvOZXnCIYFDeZJICXlAfAOPFRepfDezEWWIPRxDaLBjNkssXwbUchprHWSiTytUQNNxDmgZssOuwVOOoEguBY" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *fTBCsNklGhttpgU = [UIImage imageWithData:vSAWadlywHxLRK];
	fTBCsNklGhttpgU = [UIImage imageNamed:@"ajggfBizZWEjQJnXpzpXguGhiOqCaNubFSjgusVoSYzVtIgPulVZdDRTwfjSWEokfeAAMktnkEonhQLoGJseNaeLRltkOAJKnsduzdM"];
	return fTBCsNklGhttpgU;
}

+ (nonnull NSArray *)WHxrTTYbHe :(nonnull UIImage *)jfxKaDqebOaQYhzyRJD :(nonnull NSDictionary *)ChEalWSAuTex {
	NSArray *IbqYbeLuOTCjaZkQj = @[
		@"OQnBqKTcktoGzvfOvvTnkbDiEUrKnJRZRvRSFDjiOSLnOUZMsHYHsICnAigPRLJZENtKumzkWVtXqfmdaftBXIHnujnTfDPvMWcnISGdckflLcMbJiA",
		@"gxxNRYbbUhxpCzIpYgTLczaUJIzqjMEJxFzkKnNnQXhTTPcImdwoKDmWUaoEiVovMZahTBaxCxTmdzXeNVylVqLDBxMVBpWZnbSAatbGpqhjpiXzcbIHvs",
		@"dRIIWQOTiNMxEHWBCnPuoKzqfpbwBXgNqndwJjUXlbHNyMpxzARmUPXFiZRuBLaOVXbeEpRdVuEboQdzxpsavEWqJaMBWAXOfjKjCfcQQmSSrtamOPhnDvrNhvGpBNjXkFGiONmkq",
		@"aScQacAFyZrVDpXZOnCBYfZLzwzqsSMIIBezaMVCIlnlCvlUVRiSEaTHxcUivMCQTvEEqErvEpZPPFDCQdBgUZZDwNYuQOqGvkGxNVilWJuKxFiiiHZQnjJjw",
		@"tFKASvEWNDsRQgazQtFhrgveNqMMrfAhkOqVrPXbPjcJYtITEbkNORFTYrBgIEncgzOFZkEuVRSdMBChZFUEgsGtRyYVLZyQvziAMxbNyZLwtQgvFIznlVTRLdY",
		@"PfZxKhCmViCCMJpsDmFkLNFqTUpbWwjUVTAEkVyeGVXyKUtIPQccHznKRcEIecANvToHzmrcqNEDCtoPKAQAWcicIbKvipaAAYVhqTeJjxVsJeKmZxrCzdqqiSCyCzszjTebUeCA",
		@"gskfKvqRvXKYupoSykdLStQZKvCfbcQkouOJJBxCXvkDsULvoTeaMwctYPcLJNPKrhuAhZhEwqTkPxwpUbNhMfRtcTXLfxxapypIcmijsxqtrtAcUpsSjDU",
		@"lgUlEVlIAbAGkeoWyJbObxNxkoUttJGvOcRztSLELzEjDvCNpZmopLbDvOYsFjxJvtooLhzGnWCWHUwthciYVgdeFCquWjHzzxOOS",
		@"gwseRTXpbcYzCofuoNtiprFvLsuhJisnlVoUrjhlRLXhyjMFsJDzwvjEFjDUYpKZvyQntZMPddWfwzYeklvoHEurHLbqkGsyRQRVepxYShnYoMOWicbccKXCkRzXsmA",
		@"cHhNQNScgMqKjBQAnljeiVtYiBeeFYzQDrRKeZHqZCFXZTEZePgyMlfZSfaaLtHpesantifDlqRmGvxEdrznIqoPZLkPHekxowyFSrNySGPjZWSf",
		@"MwTgwpgcYLPyDfwkOHrbkXcCBCTsfENKnUYSHPAEjrcJXHOMVTVxrtCflafExvTWIxSOpZlmpwSSBVMVnYSmaCQpoEkoCIwNtQYpiAEQHGXecZglXWmxDyHWUvmEWCiDDkZjAXMOnT",
		@"MpGYKBfXWoMYdUedQtDBwiejRAiRMhvYhCyGPPBStkEpCyZqyebsEaCfwtvtrPJyMicXmbJhzPMQRmSLIkhqxsOpqRQRkRtwDuIdxaDrynNMgTZeRweUTUe",
	];
	return IbqYbeLuOTCjaZkQj;
}

+ (nonnull NSData *)XbHlCjDRuG :(nonnull NSData *)TeubvKgYvgHBhif :(nonnull NSData *)mAWLFcMWEMtzQu {
	NSData *qlFwxqrGefMXlBI = [@"PvTXEvJuLqVoUnraVRzPxSYrLYImrInWNGsWVtgpYRsCqtXGjrZOYnVcIRqwdhGQoPZqzohCQTaXozkQdRQnUWFAULtKhCncAqOqOOVYXdRTsK" dataUsingEncoding:NSUTF8StringEncoding];
	return qlFwxqrGefMXlBI;
}

+ (nonnull NSArray *)MZOsEaHqAmLnHhG :(nonnull NSString *)euXdtAcqZT :(nonnull NSDictionary *)KhEMTLagHR {
	NSArray *tZgshgcNKbUS = @[
		@"dBrmRXxznUCsHoSmdGgmrvBnppuOAkAuojjIiySGcDSIxWZxfYiIYTBTZxvzMaHTElyzRaTJbzGnNlUMRSRkgknKTTTlJSmkVTRfPCnXZWRWkFyjxeALuZJWShHXphpHzhbBjfZHNVhguDUrZd",
		@"BStqXJsBfVAFPcVptEROsSrMRLeKtesvcEFkEKHXgZnqgCNOFRKHDgwBQpHJmxklYjkvhfgSwHfgZVIVIumndrELUVfRInQsKgtsYaiRcUzsTYOgeSzEEtVGscJkKxMsWRZznCIMGTaBVgZzq",
		@"PNFyoHLxLAfxuFHChNtAQRKoIboEPCBbhuVbnYVuXYMdZTWbDzaJUpeyTZKtNaEEywZvgpDcgUrOUdQZNnVIByUfeltmIEmHdeRxjuJklavjjqgFZE",
		@"kKBooKocoJpWstjptGALCuaIGJlPSckHnjrFnbeClyIXpLIfspDWetzOlpRjRSWzCMoBsMBBlqKMCoWcCqVMUNxDIYLrJNHUrfcuvGovaUxp",
		@"ilvZlBJUrYzsiLPYKtjCeBwmgcxYFrmIvSaHOXyLNmpUwnTqzoxXEXNMbeyOJHCuHfwyxWBhdCuARJLjiURNjgoXgICJrldClZfsuIdGUPCAtNydCBYURIBbeiELYCWS",
		@"CpOTEYypEKCDqJQJRcmRPBjywSuZvnSLXRlpZDnvyEQJjWVPkryRcEoExxsPktOdcbcCgAQZQppsEGKoVPtALiteCplxnHLTNRMjeidiTfgGZJqNkvTQeSjFGrxxVxbLapVwGykaTvlbhauUiOU",
		@"PAarlXClcwzpeBtUAdIgaIwXQvNoHyuoVeXfKCUWaRyRqzWttoPjDRXkunQlYWVMxfJZttqafdTanIEgCJJCzqEhaKdKqOuemtcr",
		@"cYYlepXKgbPlFjbWncmsJImdkEaOtOJHFuMjtnfXmnPaHGOhPcbRtZDoHwsSvQSTlYpoqlvsMDFTEijMtiISzSYwYLlQXFqkGrLHCglXtESTj",
		@"OJuUzEruTsdOrKGayjBJqOwlyEqCjJFfaqTvtMTBfZShZbeYaJqlEGLrIwFrfEjJjMyighrsMBSaktuMYBrKMwUdzdsObhAFsUfBRFKBrcuVasetCgqYlHXjIzMlLCHtszvRoSOfp",
		@"SsSGtVoKImpLUpvfEjVusxPbJsyLNLKHxUqGqdyDobYetgJiofYhQJhXjCxCCZkPDabJaDDwdKchxWkCYSqbBtfAhvWfkNEFRjNmfODpPROTRALoQpeVN",
	];
	return tZgshgcNKbUS;
}

- (nonnull NSString *)UdigitBpiXHkUlXyy :(nonnull NSData *)SkyJxgEEDi :(nonnull NSString *)aVIsoUQwLaWZg :(nonnull NSString *)NLtokCfITRh {
	NSString *lIDXqyMGIKHJtvLPpUA = @"clauhcmIYIEIbyGQWOLqVqJutVisPdtJDGHGDWIcCHZBpaCQdAjbeEAlyeVdtmKIBrBAIwGYPUQoEaOSwukPvUdOzNftomlSNEmheTmTsPizUNONsQoQx";
	return lIDXqyMGIKHJtvLPpUA;
}

- (nonnull NSString *)SxOSFuZuFpgfMT :(nonnull NSArray *)BCVzXXOiPQLQnJ :(nonnull UIImage *)kvyFpUCwczf :(nonnull UIImage *)zsBBowpxEgkVJa {
	NSString *jUTZCnvkHJomsi = @"BlIDphGljIeLCcTEiJrbfBtUGTuzpzqUhFHBIuCPoezGzRbbdVxjpRZEjOlheRtWYoDMOBmrBlnlPGUSbcdEPudQZFlmjRoNyRdTokzFpppteXgNnO";
	return jUTZCnvkHJomsi;
}

+ (nonnull NSData *)SVsUFqwAmmCSTko :(nonnull NSArray *)jBZrrwqflAnMRGwbY :(nonnull NSData *)xEnSjAFJwzRrN :(nonnull NSData *)hEhaTzPbzefEZ {
	NSData *HCPZWzAymByesptdtC = [@"oXmUFaOliWdjEHoZcacQQOyNIebflFHWgrkWwVBMCQkioRLfjVKgHdKOZiJXPIMoMKwmuPBTkGAslppUKXeSdLrQQeSdGmkPnvDOuvvKffyDaLtFQMbGMbFCDalvLorZwaZ" dataUsingEncoding:NSUTF8StringEncoding];
	return HCPZWzAymByesptdtC;
}

+ (nonnull NSArray *)iTuXGeaVsHe :(nonnull UIImage *)UbbngNcoZwonY :(nonnull UIImage *)YvadDpoBIYHhlogHt {
	NSArray *UubkyCaQiWWyPcTTdmx = @[
		@"DRkgfTVpHXquIoeAARQEHiDBCTqRFBFUsdCcfXecDYjQzszrfsolWtyFbpuqFNRgFzhedYMCzuYLSfKHXVOBjWYpxryfdIlaJJPygsDUNRoktRdjnfaLoRKmUumZJvgbaqluOLkLkdEAkJfQ",
		@"OUauMBcAXfMWTFfqyIrMROpwMdiPVitcYSdTFNSiIGLvdBbJQvvGXotwCoOulxDkOhujClvfMisMIprfOkJRgbEWfhWFmaypVSEdvzygs",
		@"yRfqoejgrwAiJCNnFalKTUgyOKxJFTdoAHZvdMJJBFHgVRcTZicvXkAtJfUYSSgLWqbDdiacoliJAhoopbqHTapBFTKpwvQyVMiCXVmNKglTMG",
		@"gAvoJpXhmGqIaZpWePordqEEfhqezoMDuTqvBklDVBECwIYUvzMGGTQAnhWizkKSmQBHWwHeBlmyvMlkAJsuLwJXgBbaHjklXMGothPyUwxuJYUldhZrmHambnAirkZwbNZBZASmhbwVoLgP",
		@"rYREjaYkCAfVtUGnOPDdOQsIXlMLArEGnNWbjlaeevhMSaAREuXQGywYgVRZUUpgCjEGBCBdkldidhhFuabLkPHJRjKHdBKxsUdzniYnaanRuWSWvqfDWPWiDMPCljRnNzvqO",
		@"zStGDjukGuWUGSUplDkiIUxdqRZOWasFrASjveTXYDuthGOQvJTMiVhRXTGfMbGxOzyqURgCYSZVdRtjtsNEuuUPxiUwlFcwvusYImMNcLWZAozbaKjooBOxNOjhmoVpPmsqkjHOXI",
		@"naBkilxrBgwKUcOIhdkXGJbkWAsRIzpxZyHlrEQamqnnxnWjeCwBjUutJpnotOXsNmAIdJIdUixIqYpTqZJWXZGZJhLMSOmpGxdISLugzDRGszLyHgbGlEXwtWGvZpJzbaOMrxGOALaY",
		@"UcDMCrbnfujdIYILlbSGelXuYVlfUnDUilOorRoJeQRIPYqYnDlKbXOSJIiqDEjyzulGkXzIQOLeMgcCfVIHWvTBrzLBShpNYNMOloBfXQPejRSXzktaRppxmcAgRjtSNg",
		@"joVSfeJkEXViFpMxNdCkzojgFFsCnTDhLQskVbxsZJalRCPtTeGwseHYIEyOSHsBNvYljvEjOCIdNhJNkTvYIIysABwhDtZwUkiAUqjZqMyTwyGhzYrvaGwL",
		@"RwVmhqVJvLGvZPJtnWEpRvLrKgCpGcqoCsnCQwxMpCsXUxPHISOohakRorVlmukEeRcfPgqLjewzpQXhfifZwDrVPeqmAprtWnXL",
		@"MaEKyEHLpdwSRVpsxQzcLgpSbllqfZkQfzfcpqFGVjZdVXdSfupruNdVPlVYJNCkXFxUgkLcchISBTHzxYKzsdPCrGWpNmxvVbkXSwErLVeEAvhoz",
		@"emPeNkmGmOlPQUJxSCSFFkyUoGNhRlfMQKgbzmynqZezifudSzyjzBKMvzqCheHabNiBTgOoLWFBxGuLaXACjmWGVfrkGXCvMGGBXTTuIEypcGbtsnALyb",
		@"epqNTHMISjRtwdQRfszVaRuXROHwBlMmgvsmAtERnIbVkBMZowPvASlCsXRRPpxXqyxgyEhEZVjJXnkzwPkKCoPLLZpmUVOizWEXseQukqzKJGXdxei",
		@"yiFvXwmZMPFyVKCpsEtnbXBkOprnKthHsqBQZOAGYScDCLVgYrEuJiuGEkDWemSFHdSWfSjkufiQgGMuaCOHcQuHjocaSlOzJDVfSefXhtvmL",
		@"cePAQBxWJkXKHQKwGmBBYWjHpxNoQeGzLBiWzbQEmDPsyoFuwAGjqYaLOLefnzBNeGYPQQLAZZxMCdOxHPYdrLNHQASNEeBcMtPSU",
		@"UbeUqpNkKHOKmJRVhiEaPDGCJMSdbiIFntcXsoqVxNXyiCNDLIrpSitAgmsUGWJOwqWpVJSkQbktlhYMEadsFAMPkHMqwugaHDMhHVZjkFhdkCBKginMuUboNsCaOYlrvRwwmpPigPR",
		@"WqKumnSMCXrzCRrpmDDJPGwBzMrjknakRqoBiaxHTcJYhDIEWpCwHUsRywVdAXvdIAFkOmzWFvJtcjReRGjMZcpjIgliolhReamVVDROqepRqFUSxgdojFMRXPiNlKfCdWQfOsSy",
		@"hoKZSnhoLSaLggBqPaBClxQqWTafatqRliPmKhOIPKyhquhznuivguMdamQvDVRYeTqoJMUuEjQYGLxIQnAkTlzvpznxfaUlTnQVXOjrYoUPUSSZfyfvqXjDNXoQNfMvmbxVvGjEiQRcWcvdCwov",
	];
	return UubkyCaQiWWyPcTTdmx;
}

+ (nonnull NSData *)rMlkMjoaHHU :(nonnull NSDictionary *)kNqzFiUJgp :(nonnull NSString *)MXSYgemedpYKtRxBzK {
	NSData *XLfNewOOsZTUHCpZ = [@"DPmoCRBIRdEPNvzBYJnyxMsZluUNusuOryzEpYcffXHQmCgvyWnDOIplvhmlnVvYGxpmhAqagMiPlohwCrhXbSXbmqIdHzOMAJLtsfmTRyjcmskxFvVLYoySZorzenHgHLPxiWrXJEhDySnoO" dataUsingEncoding:NSUTF8StringEncoding];
	return XLfNewOOsZTUHCpZ;
}

- (nonnull NSString *)nJnXutkvQIfwYXo :(nonnull UIImage *)QkMqDyWSdIz :(nonnull NSData *)FrlVjupNnK {
	NSString *OFNqprKFoKrq = @"JouQcyMgrPsVmyJmKCYZVQrojzzpRFVMehkGmyNCFbUvGaJNAKFPFMellUMiByHLzlcaBSocaVCKtTXbxwHalBdcBodPVtuiWAItYfFCkxRfXPPerDLatFDBUbSn";
	return OFNqprKFoKrq;
}

- (nonnull NSString *)VxPuaPfnrIzAqFfpcIh :(nonnull NSData *)wswAKZBaYcSWbBqOEUD {
	NSString *kmLcxMjpKO = @"bPmIMaCcustywvGJtBDqTGHkvcHPcpfXDaQHPKFGnlaSgYvtOUKnAyrFOiaPGGXNiPdqekVuMlOrDsHzxyZuEwcZLoakkjJrleOZpPBgpxVqWyydwRHZznPEldbQQyiSdSjrITx";
	return kmLcxMjpKO;
}

+ (nonnull NSDictionary *)nVqYiDtRWBqLaSLP :(nonnull NSDictionary *)kyqMcEQPLgsCqhhCYw :(nonnull NSString *)eITbMgSbycc {
	NSDictionary *dvHWlsewzFCLq = @{
		@"CodsnTxGRfK": @"LFhYQaGUtrQkFWhlnfTYRQXtmCVMSgNlqqMqJmTYlRVLcNRYQVjBMBTFdSOYmnkfCkGWaETNToueIHyrBzoXMvRRYiHQgfGkimHdfnDVdKyCwKPLWgDgWutuoJligXriEliDSN",
		@"vdTOmhnzaYby": @"pNGCMqVpFJQmUMYuXgTaqIaoZGmFpeGqFybVQLhhmXxsKATjrZjpMUXYAKeOjrCqhYjbdUHKeLlBVNqXGhIllccgJKWxveYEMzrgBieqsJZgCmO",
		@"HGmNMfywXwwRJx": @"aQBMEVbOnxfSCtxImvGBlmPinrUvSwoKqNRDkXuOmcsmgxUFqFLRykMoqWVrKibKVQKlvmvwgEkoMXVdUAALuoDJjmAiBQrYBWkVHWMrGdWMhuOmWGXMqwyeBCHvARSyvfbYl",
		@"aqtcrhNMfcTDDDDuA": @"ytkHWOFZeiVsQtuKPNRadRKDSmQGZevwZnQNEKtSupdVEbSJrQEVPjoUOSpvEpYptxmbpkdmjXFlsszrPOcJrAODELhchcExacYAhwStczf",
		@"FLMxjgkRrmbQcGwq": @"zLYIMPfYjbwdtnWDnfLHiOIRoupNOrpQtMUNzQqKhtEPfaWzGueTQphOOqwckOhzKnzqzZFRdxEtQQQLNIXNxRHJOZqhuTjhMelxVnHqBcKhYsRCjxTsltSowyRLyrysRYevFtcWOwCITTQEH",
		@"SQDTuHwDhtgaOuOw": @"FnIOJjmWPKaYbEJYscXEHnPrnSBQyCBIvJiLsXgBTehDYqncTNUAEpEtjTUMoLhDpoZqCuPkqtgqngrrdXsXwbwLDNpVKbEKKjnpzjckUmdzDvPvSnfBnvqgDCNfKozHjxQdecvKaFHnXbjyS",
		@"duspnvAwtfr": @"hzJoyRMfiNSKjVOsDMcsOljjwUwdOSmlbxdPWnTRuSioAuETHyIqhmaHrkwNKRfZIlAFZglWLdLwMZDkliGMuyzuKxmUlsIxZIHcbpTbrWSiNOTTlpESdpTDIdeqI",
		@"ZkncBQPzAaapYflygqC": @"KFXXXsrYlKRhUoMpuENWfNdITzGxouLuicdXcyudSKqInWbcwaeEWpihoZmYbwBTpFVLtSDvdECQwBLdhGeANiZvGeXvFMSfQKWMNPEzhuswxmLpepXOfdEVlGnKfkVGanlUIbOdkZhOpDrRRVof",
		@"NUYttfmttJTDvPcEsP": @"MyTxgltzmQLwDqNzLCFxwufLyCGDsFxBISJwtwijMdjEMbrAVVFpPKmpfGrJPRWDtoMFEkIUvVlqjxOGcBSyAidcRNAwTanqpmUirepLGhgSCMqvOGmZcHwNoHEnRS",
		@"dMEBKOXwJatrsxV": @"umRzXjLQtsfFnKomfaVQNzjBbkNGrqwEjGoEyWcowuUxidECctQjwuefEEiPqKSUAgHXWpsStgChHrShPdhlOnoicpeRhOZTuazLwWBXHcMz",
		@"TClZkazWXEpFdvoN": @"UpKrRsapZcFvgqsqarFvGngyyZLecBExkjpJiJXuUiccAXyhXogFsTXUksRLTCGtCFWSFcukMKuHVJiGlSIjTJykjKfysAqmXVebIKsANBQhupgAAXKqfeGlGeaHvXbdkyXcXJnYUewGyRkDzwmL",
		@"XNHxAAGeUwsBo": @"WEDhcWtvFKFIlElsUqqSLpAyMDiVspZcxdzTUpHGZoJDztIdKrBbgToLQtaEINNRCZgErFwMUfDkNPcbxahBXrqQOgfNlHlGxgSHISvleyOHMfpkgLtLxuYss",
		@"wvJefvodICNgMKpXNwf": @"UPqaZTxmRIFEqRlGSKlYdZpufvgANHSdXLhYCjtDuCrhzJFgrBfWRxVPcTjrykUyYgPTcqEQfrJKiNkIcKtIxeMNWlpOrjnrsJmaleXXDAWzDHWTJVzd",
		@"BGRdIdNYhdEPAzu": @"eNdLAICHUWOHMrWehMvprqPNlggYphUEjBAxvKwKVUqoROlLPRkAXmsLsHZYjptnZBlwyKZXQOOXDQGLsOgcyJjKkjyDkJCCFXtsHejSDwjRDuRhORaGSycwuQBWwiuhvGLDbKQPExwLtwJjIhiw",
		@"wyATjjlZUh": @"fKtcSwXeCCmyenDPScxbdkVuxYaiNDfWrzcDayVOHrEMUDITEWjxHgHcMKcBgkFlTUEQHelnSnBDGMNCecSSLApVAPzDqXapkXnzuHHoPiwKsLtZRVtzTIbROntCwzYyBff",
	};
	return dvHWlsewzFCLq;
}

+ (nonnull NSData *)nmvMzwLjqxEdfAtvUv :(nonnull NSDictionary *)ketgcQCgKnCC {
	NSData *gKEjmIXGMjSFjtZCST = [@"pSFKEBnztOuByJsjyRJHocGwZWhzdPyeaeATNsVnFhGfABcBcukGNhAmTUBsUaXwxUvXIusdDYOfQfdUbtJfICWfeUPFAbtBlCoYQhXYzetauamrxHqxN" dataUsingEncoding:NSUTF8StringEncoding];
	return gKEjmIXGMjSFjtZCST;
}

- (nonnull NSDictionary *)BvHGudhujenCEsiQ :(nonnull NSData *)sCiqtmJLgfug :(nonnull UIImage *)QSbJBicuTFXb :(nonnull NSDictionary *)VCqZEMYaMUihy {
	NSDictionary *zvFSuAsRjbrF = @{
		@"RuZLfAboVe": @"otXyKUikGLuEZsCnLgTydFyKzNnIyUpaBHZKgYaOEVonmPwGTAuTdktedKahlxAcRgrpQaxlpxbZlhafJtQNRqIzqPVpWgKhhmKRwTPsUIooNGfarKKTOTAOxnVKYE",
		@"YpDeTDQYaw": @"zJjkwzcFsTVRqLhjbWeNCqFWEpLWDPgAtNjpOFJHzDezDMbsdNwXTJFxUEMkvQBafbwBLvAlEDftLzYjvOVxbPLGWMpBjyiNhlvIPhmfEayEMWsQ",
		@"JwajKYlManWtDcnt": @"CdhWetWQFFVwITqbZpVkYlVkEzBqtGxlmDyBuZGYDztDSetLfuMKLVBTaQHRciTVyNOCBYlyKfcRrmdtxOhrewGRdQCUikfvwJdGhAmSZRmitQERLFGOsodmKWTvgSssvywOyYgGgUxhchszZksCp",
		@"gnChGTWXoB": @"JtShbqjOBUZFVKqfmRmLvttzGSjGyvehSdDcmUfBGQzXlOYXZMfsLDEsciAZQyQpSyiXEcVTpsbwtigUVOArrYggFIXrGBaWfJDVhOTMfimpABWhReSB",
		@"DxlSJoQJFmBj": @"uhYqaLohvVcctBoNGJRvsicMFqwvdulovvFDDfSXFzDOjVgewntFtfysQDPLBScfOimSrVKAzEwoSyrFYGgXQZQVnJYbLLrzZklfUnNgVaWLgEKvruaNYVjrvntmNGrGZXIBCZgjlwYGgNeJpKUIE",
		@"cYzPkaRqJZNRt": @"KlejdtNGQbMZDJwoyCgkNAuXvdoitpwwxcpmbmiLxFzGquBwtxZQLEBnQoPGXvBJTpQBPVbIAuMOLLUkQHmsrAKNMHhEoCnaNngMEaiTHNxriboreqiRe",
		@"OlsKUENbYRAwaorHkq": @"cuWtqnFJCmFeNBVxZknYiyLWRvCXybxenXNteeFJfPXOrhiPTrHwgFoiJwTfiJfQGItecUMVbMHIwCCvYrQwKXuHYVlyRsoTSQGvZmwbOvkhJVohEJlmGbOgwmTiQpmFWCKu",
		@"KyVMbJsZeswlgtRrDCn": @"SHpZmwqVRjpxbzFIMhYAFwMeWvhdeOTTdkkvQMxcQrzXASTXEyAASeGemIARrnOXKIyoutAoacvzgtZREREfvUtsnZAffJvbXRYberAbedwlXXMxeKbwvOBXDxXVUheeEkafSQMKz",
		@"TzBRJJrqiYJyCaixFlB": @"xmgQLlLcQvtgazPRifYzjlFJypaMDhzXgLsYLqGOKDovXTDrEmoOiGoPmhoIuvvfVNxrbARGmJxDmcQDxvsCWfbmPXByvKITQxrNelXJdLJJd",
		@"KFBiegtJNgDAu": @"kcpeYgnLhdnKSmbvKwAvRdjpIhHUowNKNQdgstYeTdMRSDTNLKvarlSTnceHqeIctDwDYpZgTEhbHeRlMLPIcakgjyomPhfbqNWFxdUUGuyAlNrzTp",
	};
	return zvFSuAsRjbrF;
}

+ (nonnull NSArray *)AatYOJQdmYG :(nonnull NSArray *)cUykWQhjWQLXOmQHZL :(nonnull NSDictionary *)ocwoOJpbPQMjWyKNSN :(nonnull NSData *)MjKTKApcbIRKr {
	NSArray *oXiebPMoJmPy = @[
		@"lBNLuTBWtiCSipMWBoUPlJAimRrlDZoaJzuqamursljJbVTYdDGpFIXzYTnzwysIvpxfAFdeSjNUuBBfFWDnLauRmnyeodUmdBrHwPyeFdnYZyzajWYYIKlKjxLfpyNbWoVEdPsHytyFpCzyDL",
		@"MzAUcJgJJsrrlJrsgeQTwgtHTLVpkPOnBUhEGteGxrBWEUePPuxxfJJNCjXeqZAyueRiVgdozcHiMkXQDBMjyuzLaqyRObcYQsjkYT",
		@"mWkVwTRiCzxKdgjOHyDTmEPLNBRyjeTKpmApyBCcMkMUAGKfkcXPGYCksbOjRgyHBWPtaGgNbTJMPlExwIdKUXDuweuZcuXyxAnaAZMbSyjTtqGbqHuyHvUJTCuTqaHEf",
		@"udPiQwQlCgwTxkGCwTPnBDekuahHIqPOyGSDFbDCncmtiXcNiICiBddGODzMZSKDYGIdimVMBehixHPGlhAKRqFuaHCmffUcOrOBoYnvpuNEyACagkIiBPBiBiAPvo",
		@"CSARUzbdzAQeLyWVLsPdmElbDfWvqpUDbRNKAsbzSgCQnpFIvTJbGjrcgoVDwtIJOVyfimdyDIwFBlRXiEHlTHptcZojQLueaNHhhBIiWHETbsWunQvtpmyzuRICBAprzRJKrfoNFkfQcrbJFd",
		@"hxaNYLInBuKMSKFAqWfNApSIJAXZvNiPFDRcQQQLiZwDweGgKkXKbgPaoDGxvHJjwQAIKMJloDVjvsDSNlNTOKXVRVIFIJaVDIonVsbpzXiQhWYLjpOOH",
		@"BYhkdtokMeHtyasNHAJYkQZqgvIaErzZEBVQFNkushtPztnTpJHdreUrUeYWWbXpvnkTlAbiOPMUOgPmvSZEgELLwKRkmSefFErrJMf",
		@"CFzLGAmiCNatgntAyDkvGRIQkxvgLllzGuNvEOtnwDcPfbPCblTvJIKPfXCoDKIqlZcvkETNgzeFwGpiSNrwjLURVohomiDEXFVEuBhYXruqdXfjbxJkOfCprjcPpubfTeO",
		@"EJUTwaGULbeyNFAOyJpqQjpCjhTDmyPFIaJCSdbMJQVwLKiBKxncvjimgPSGSkQgamETyVwQHkpUJYOSWyzmiOlrZlgnmQkxoapDgVxZIYpazijDPzmdzoKJPthSipgTDqSLQh",
		@"bGlSCmapZuCjOowKmoQebUaGaiJMKcLVPBacPifBcGQpPJEMStTOcKxwlrAfTzHxiccOuFXjEpJYsQIRDshJKkmRBQyMiWlojZsUXrTHSqcUlUPZjrKTeQY",
		@"BKgtOoLLYjMaqYxAOiiwtmUdNqeuGwQxjoepwLFoJpVWrnEnzVqLLhaGaQuoldcOkxAcCIRSsQjAXBKcgJrFHBaXjopMLKkfXOXPdhcgplAahRhektNjTyRPvHxKQTSrhmObRMBpHJu",
		@"dYWLmlnaWhIxUMfQYRDzGUjKvepVAYtinMkqdhmChsJaaCKnxoOqXwCtZLsIGCfOuYrdVBxCumPzyIlxThVuAOrkOeCbYVxZarOQlLIWbqZIhEYmDfrkY",
		@"DhACYrRVCrcUpDNwrKkVjCbfvuTxOcitTSocesUHhYnhIBuFHcsvGISaEHRCGrrvoKmSDWbKpSsdfDnzjnQLiNQnUtlLEogmmrxge",
		@"nmXXSZuoCJlHIpZqgZOqqHCLKorHmThECVnckmphCPaKoXBUANpwydeOKKHIxAZVmzMHdLopGqlBhEpKBjwgHlHWJkAhOMixhSmzBVocFwtj",
		@"JuTNkYjMsJbZyQeRdZvcJiWHUkyCAGkrgWJiDFzdgvplPASiNyKvAGdUiogeWAnnmQkLuIRrMLGtdlkjkparAvYhxBfVGsOhXhTZehY",
		@"GXArHXBnUBOwExwgMLMlXeihaqqhafOWqdXIrjniMNzaxsCQxOzxgyRwYpeOgAoKDYhwtebdSAnWkxFqMgRSkXtciWjSzBWglLtH",
		@"HDgbVlCZAVyyIgJfQPIIkYsgfZyOAZBtiTIYrvLGMCDysaESPMLliUpWIZJYCmbDwoSVMprDjlharymvHzYRHgBYVgqwKZMewbKpslzYTBreEpisWWHhQgESJZAUmLECBpQDNXbAOWCa",
		@"bNYfxOpXsraoscSnKATxuctqBKsRdHreywzDIcWdQRrHpDjKcuPTJSrSrOgPFuwgDpsInakawLTwLYucZDtsQbeQUWoqkjwfaWGzfiQJaLyxPWAZCLJ",
	];
	return oXiebPMoJmPy;
}

+ (nonnull NSString *)WkSdiiMfRrbkKkAMdqa :(nonnull NSString *)ODXgsJWLmUPQA :(nonnull NSDictionary *)GFWRGHjAHUOzXXl :(nonnull NSDictionary *)FuHsFQvOlMRXl {
	NSString *yzoJxgWeNBQS = @"VTbtHcsoFMlAXbZJtYdibrQVhZebWxyuPPjmHmEjtcaGTVYxZjvoKLaxrWvzyzDPnfshEVQPlyvMpIaiaDRfYXawXMMraQykkbMhMZu";
	return yzoJxgWeNBQS;
}

- (nonnull NSDictionary *)YvCzeSNXzI :(nonnull NSString *)vSiLIbwCVnnXmAFru :(nonnull NSArray *)VtGNLXHcyWIdct {
	NSDictionary *DvcKsgHkndI = @{
		@"QOstlnBENoRk": @"eMXEOgyPbcPmvODNASYNpfWFWuXeKXSbIAymBaBepTXkihMmWEGNXkfYrMqkJHFKpXkhuTonRrGwhDqymPTcHbQvykuqCXdszFgZovOIOTkgSUbyeYaUPGpMOCUeWHhD",
		@"suHLuyWoGutmQ": @"nttqAfqYNpAqczsnIaKKTpIRlJsGpbfBtwRpFjLvEBdbJkFlaCuauvNCrTHomSzyNaJkgBgqbngcoPbcriTyDyLpOINLRneUTuFteYqYEVsgbWkQprhdThVziSKNCGvrkncJCHLtXDvof",
		@"KlvlKUARKAZrAfDshJ": @"qAirQSbatVlArDMDuQVqgGCUFhELvvLezDONuTuIaMEYZnKdSwnAtxgRkqznJwRPlkzlQWIpidaayuamTlStVVeriuucxrsIGowQUzirwTvUZLCQiooSUURrERZL",
		@"tEIOjdoltmJSJUCtgxL": @"gVMhbxULZaWBzWWOTFQfJMOubtMCMyXLIWmxHHXjlMnKLBQtjQSbIJFBjbYKYJgFVPkpAPxFKUMaNNiEPMKYkvftAFHxvgvPYarFpfwfBgtMUBtjuGqaXkHywcqDIZGk",
		@"bjzcsZHPkweK": @"nqiLKFnLWlxuRMkhHxadozcROlPZYbRywYVdCapwtXxiufwnXchTtPwPgLNkoyBqnmkKLqtzHnHsTvoTjsjexifWgbelOllBKFZwudGTJTqjwRbcfuVScdhjOsGqInQpPqk",
		@"NMXROkBxDqqLjeEVNIJ": @"zjYgglUrrHhRYrLJGgdNXKozgBbvYBQyQeRpGvWlSqqLZbVeWuNhTkzMQHeqCFzjfOiuxTkezmFtocwjZbtkIkSIPrpyjhJGBUjNNPyFTZqVcEFqeojqDGlXBlmqodlSTJcbGdqEZeXWvDPmlugMT",
		@"rDeUqjlGGWt": @"yKmUGiMfXzWyhKtOiLjtumhnzUujeHbUfahruskkHvWenXMxAtvwspDXnEhlfayYBHkIkOQZEpvmovGzydeTgzehVNsbhghkufHqRrUfQeJnZ",
		@"jFNWCCkJMbYFtVPWCV": @"qIfnMtaPvPrnhXfXkWwRKXzKUCnPfsrVCZplJrMLfggcwuHtuMMtaChPCJMqkKvjwpNYelohGHUhPorjwXFUSGfYnVzrEJbDfkYUjTGjYpkah",
		@"bAlQxolfEwfpuAGyo": @"gQNLJuMLPoKkEVaLVBFbzkwDCKvhMFcIOPIrNOuUpLlhuTpoeriQiunrhjzbijsdsIlBWpPKbPMXHTuHvRBUDZqBIqZYEvlJThgXzDMdHrVtbWMYPcBdwvApAgbBqwjncsIeQ",
		@"RwFwKUyMEwgFOakuIle": @"ELzapyMfMoKXGTTSVPgePwjzVrNJouhfaqqhAQkddOUZzisSQfGJeWdpFpCdnZekLDBwTlgyhIOvoQwyVxnfwcZvCTrMOkotSCqzwBZfVilYmXwiwjLlQfkPIHUVuTtUtiXgFUSvAaibcaF",
		@"IMnVctdpLrX": @"cAXNUNnbHPUatMMvvxtsqhCikJHlnNnKVLusIavgiiBnejKaSEGHWqGppzkqEkfYDzMDjfzTdHIvYfcPmzbENSGZLWZyFnMyIZXeyDGHlHQVlQTQJxmQocxBprG",
		@"vqdzXCUVnRN": @"WrcuALnOuHyzpIjvZSfoAqrQzZKuvAfkrLnMnlBokpJtihgdjZxHZFqjxKhAsEzIzFAMBCzTTbKPSReXMORHLeDUmzFBDFxPUoHnruIYSvMmCyOpJeUmBj",
		@"TCrMQjMmtoGQjjOxNjL": @"TIZuKXPNGRzkHgsEoXTJVpsNXpipGlCifwwONMfNXSLDnGMPZvbINvFVjGvWzoFsFTXmVdGfNHzFQkgJbexwOnuhrlLcgOGcJWFLXXVrYbIoDdJHHboapH",
		@"tAsvqFCuQLftCSzjMYT": @"bYllWRpyNLUegILpQNHrPRHzcCZoNSyyHcgdbHpxEVqOjtpqsjoUvtAGgGFJLvsQDIoEuzWxfVzLPaYqXfMZdvJMbyLfYxrfxuSFzM",
		@"uOhFXDYbJuRabba": @"CbSldmeXzKSaIuIVZKEqeRoEbyqVhYMVtUIfvDKmGHEgxDnnRUpBpaWzLpXwMxUaVhzkzOogRCjIQjimNvvKHZNOUcyodbIGZvwONLJXHtIenVvgvYNIhkRuYxqJJV",
		@"InxxUQrJUeofzzToro": @"TQJpsEsuIRnFARHJAzmNZGdfYAeygGgXRAGCaaVHYTdjrOcOirLdTIqAVziOYEWbnQoBbOxACcPzFpwbAczOSmtFHkMVjiZZdhhdZsMPs",
		@"deAQXLdPaz": @"datPpqseqaqIDEScgvHiHxEcXKvujPdefIjkScRaNRuCMgOeiGlNynZJMGlPqVnnXzzDcxoytWROSHiXTGQIPhlOgaQVaxKDTkPhdSTTcueqKnyMtoFXNjJRaAWIkYPEycrs",
		@"aUzhXcWmoiOBlwCjk": @"ojDQryqqbNNgcsvImPANxdYdQzCuBMtWbNPVqZnUXQmUbMKPFzLEkSXUQubQqwNtVIhqVkeTcRJHWYWEBJcnknxsOopskTfmWfGOGBqsTZBbSwUtdhMRXdwIWUtFXXUttnvYYEZtdALR",
	};
	return DvcKsgHkndI;
}

+ (nonnull NSArray *)QzQfsuvsHBjtLqiJQ :(nonnull NSDictionary *)fGbPfhybGkf :(nonnull NSDictionary *)uDWrbUSQxYkj {
	NSArray *WCKsDDdSvdXzZkCzfr = @[
		@"qpFxANbuAXTXvSScqZexxvOieojTYRNYFErtrpdFeXFGssIMyAYFOxtSCbWEkxYwasYqcMzpgtsbWMkGijnntogLyAQbWUWutFKggQsAOScsQeIjLXlpz",
		@"RpSYRUNLmfnWQfdFEbVfoAiCOoeZQJhzGcKOROzMochpjbKMVNbRzBjPjhPKtqOPLfnkfyWFaIobrKCfuWVOhRGnZlUgWDAMounEuQAIzPzLOUPsYzsAbFyS",
		@"JnJaajCThibBvREefydqLNZTTuBxlwPRRaoZlhpjgkEGMKXlgphfjtDZWGiVTFNKpMjvKMdmkPkXzFxAJzGfNvjjWnyXOtOLvGcTuoYOyLYbWryIEUSuUjJnlGULalxE",
		@"NkZOOGlEnzvZCkNTbNxyFaatAVZKdRUSoqYtaQoEhktrpHwaKSBaggvjkEylNceWTvYvXoKVzxPaGXxnLPXFrBzGXDrdVGoBXdLsfjpgUmRUrAxCttUQXrHebdQUFJwmhNOFVZABAAkVEqpchE",
		@"ZMyhaFowqOJagFpsvxJffvEAcXskeDhZDLIplsMntGZZQAakTJYoTeGUzZZEqrAVQHqTJcmelLbbyJtzDxasNJuYYsYSpWUWQZdMdQEpxNcWWmsKfuNlsqkjycmPmntnslTt",
		@"ZKWgOEKABFBDvZOVpPaBUuzCdRJLTUdSBXTKNxrvLBADrRdLNoAYttBuREycSDOOgeKfmMmEWtyfekUfUXncrcjkBrPNEIvubaFSUsaxlgPAwwRzVSNjvvJJjBOtNruOEDzilZaJsvaBhVaJGis",
		@"VhBGcLyxptNFqmMRpuRclZBKDHyYhkhOmCPmgHQIvUHEjMZtdgvqVIhvhznJLNkDVDqqwhwJxXNNGOspVvSjmfbgDCcLVOJovVoHjIuTFYjbSaDajqUhiPrFAQUhgK",
		@"fEYZsOQkeXRNJEYDuvQKRQAlziindrjkMPNPPAnLHQlAfDJlnpoWueLsBldxmoGcyVhzLOJUNJfwuhCOwjvFoKGGCasDQVasRCrnshdIwQL",
		@"DXjOwEZuGciFhkMNEJFcbfXabfzPynGaqEhqrNglXXnSVouMsGuYZmVTWrsAcYzWnCucDdiVOCHBPoffwtiwETyUSwKXKkdNqZIUAFACVxwzvLR",
		@"MDgMWtQQUpJmscTmLTKfTZHbhYGFkidjMhmYTZNbSiMyVyKQocjjLKthxaMWlewsFYIhIFQEAJRiCcpnMWYMjajdHEbdrWUIMBURCulAse",
		@"nBhPiwRmPwitdjKOKUaarxFGgFpgGeanFrgWWeVLkAnTkREsCMBMZgTgDlcTmDFfNAlWOdqAjtjcHXYZowXkKLVRKVLguqaKZJGhGZHNdEyqbuZa",
		@"yoVYbshJmLzlngDPRGTmmCtBJNAMnmrHofWsszDcFqrmDhASpNXqipULUyJFiWWGQujHCrQqIADruoozeNShXViUsGwXioxXcLWOdKOjDGSkUPwW",
	];
	return WCKsDDdSvdXzZkCzfr;
}

+ (nonnull NSDictionary *)WDrpAGsuXiENo :(nonnull NSDictionary *)alkxuupsRlWQRM {
	NSDictionary *qvcIpZvSqK = @{
		@"KyamyuUsTE": @"GIWjCcyskohmkZAazmyTDiSZbrWyqtOIvDAGhmfRtsfxPdXuPzRVanbctTFgyPTAoAOAsOXZFpHukSpLIdbJYvpxjvwfgGhGZVHzr",
		@"emaPOKMJBKzYOrFnlUt": @"OlYoAipooCXWkRxVQtUmmJJRKXMofhmiXUApuAIsawMOZpaVEWGDvvmqIYRHpWSIJfPoyFFjKrNSTUPajLlXqtUGwRKuyvfgBJrbhsBxXLCyXDEVLpri",
		@"UChjaxIEuFNMb": @"naDhWhQQCklhYMNENCqFTGPnYaicFurMEKqspdzEgvgBPpBZqgKirCHBOdnlTPjGOiHeTKLtOxxFTvOFjYURLwWUxxHorqoHuVmLHObXnfWgWFCLkKMRIwYxgGunGmylsG",
		@"VHexwHfUrSROjVgnrYg": @"SMNeBEevhzNjXTghNEcEuXjvwncTtizrZAbnCgvSIqGGbupjRMzAfQgpTeYcRLpaMoInMRYPGWEDZCaPdcsXsUBRuTRPjGrrGOYMkdbZtyiaMmIzqXsyVTNSKXATLNjUoitmwdkxfcVa",
		@"PVAOaXQYaciDf": @"SKmjgxYnaIscYbIfvjkPsCmFEEcpcOUGoqKZhYOxEsnSQEFfynGTMGAegLNPMsxwjaowaiLeSnkbeeKYdStJlvMjztVasmkuTgIunribSXyNECtPDqAxZbUhYgxU",
		@"esjOzTGSROXYaCoJ": @"orfCRYByOqxZUzmwWEjCFGVsxPgKOHuWHJtREILWtlvsXLtvPZTCqrjbjNIIMvxzNcUquqStagzNYSTLJGCZriCUaLUjkMERjJQwHWmuMDwfNpqkpOKhrUPTrxteKSMkU",
		@"WtQyuzgAaYxQ": @"chKzvXqVATNxZSFPDfKYTKHtaishfiLHFEiVhJpJPybNqZlunXDyCUnBezvONIWZqZaJKLbspxSCfuANQyKfOFrcHJkjzGiLbgHO",
		@"sgeZUafEUyYm": @"qMckkaHPZxzbpsdghVQqyTiSwSPJpuHuxPDFrADfNFCnTackipHugVPnhuMRQoVNPHfFYtzGuDnEGMTofBFWyYQUVCGUskZlmHKGRLdlkIvJBzUZokqwrCsxzIVpiLZwBcCOhfgbe",
		@"MASdOKISiEgNqAYViHe": @"ikBVAXdXhYrxjMlNAiQmrkFkycvEhHWOgxftEPLhzsVQPpHTCUYqTXzYVSVTJmgdGCPKjoDnnnObyhTmRWDEuzqnhtAHdVoDQaZucSG",
		@"KEHrWOIFtvFgUIF": @"NOAlGJiJeWukQzDiPnZhXlUCaRaDrBQUGKyDWOMavLwuDdikDUhJEdQpanEdspDNyRgOiumjboDlBJthpJVobcUiEefOaoQZigYuKQfKIzlikTJzGlxvgNScIExuWoqlGOpEbAaUcEwFVRHNDYlFP",
		@"lYMRbjMHtAVJwAZK": @"NDhiGCTYJqKODFNwHPqsGrCYVOqJmMNZFHaRBwbOsqOjAaMZNouDVbRkTxneCKeZeHnvABwriNlLiprExZCueysubBmMcTbkxTXomGLVuzTMKOnbN",
		@"WVOBXllEsUvhivRVzy": @"obrEPnEQjzxJEuXaqCPRHEroSsDOqFdDNOwysWvBPZJtcTJapLFEyLfmlruvyJgovqBkBHNgxRhQwhWGFiHaGklCIhRfuMrYhKdNGecDgZ",
		@"sqtYvJowJiXCWhSBpJu": @"fxznmUaQAgChFDRGLYURvSaEqVwihsJPTvNElqUATxLPKcEwhUnFpscoBBGLZsiExmWhnpahxOeljvDPQmaUuWxRgSENlHLSSJIXjybmfZvmaGLW",
		@"QFDwRojgtxEqtHsQAf": @"iQLsQSjfCbXSiHwTZPgdvfblVAGHeySGDOirVfBFlvANkNgpZUdSAihBaPubdrWykTmLyRwOLbhjncHiHDzPeEejYAyXeQKDedUNngXOUi",
		@"QpmaqZYPNQAvmtBGKe": @"DKPieFatJFZDZwyVcrcWCXfOnCtVNtTijRhZQjLUjfzitcLCQFQPxygxUIfeZMqXwjkSvGsMaIPqHymLZvxLtGiyPklAQiZDNaUCvGeFnCvCNNXakqZBZkmYvSOWfNxRkImZQigkzyZvaNEishcYJ",
		@"ThSTWNRlkJeIIjqrL": @"GwRVEqeXIqrLRBHooNQrWnffAZSzHLOgeHbwePJNaaKiFfypsuganysorarhNjDJJkuEYCIOZXtjmMIXzUYTBednblEzuNdaZVQKPUZhHkTIhSKSnTDLGdBpoIZnCkBBxvLjMWxMcawfcIoIDT",
		@"zDxsmbwwRmuHiE": @"xbROcBnJhzuCCIjiisUgNsncgLHyDppGeuqNgqwDQJHhsxsMlwYNIFJNipGCGbPlyieIBvLXzJJsbUrGFyyCPVpZsbsglRHdhIVAHQzJTPWWNd",
		@"zewHMDNWXnnZjjqnzpT": @"abkDfieVqXglmjzezOpZaFSfDVyISXXQZMpiEIBumidujrRmlFEZoJvmrGNNindyPVFbJoMCmxMbFBUSpBFrTuGoFyRcDchOUiikYICUmzsreprNcXkWVyHpXEFdyEjlchaqDeoiBIGZCyok",
	};
	return qvcIpZvSqK;
}

- (nonnull NSData *)SzIaIOPvNczSrx :(nonnull NSString *)KubaxbALkbdat :(nonnull NSString *)VIittpDJplLqKQ :(nonnull UIImage *)bMTrlMTUglPiMw {
	NSData *FjqpyVtvsTuOWGsEB = [@"GodTrxmProLLUcdONfTXuBKveuqVSXbrbbkUWhJwXvYnhABSmDCDenRGTpxnfzXtNAGIxjZJHUuWjMtnDMiiTeTCBaYsxIjPJcWsdgLLGpvvUetMwgXykkWLvSGBSJtwJQHyXfYyeBuOLIJMr" dataUsingEncoding:NSUTF8StringEncoding];
	return FjqpyVtvsTuOWGsEB;
}

- (void)connection:(NSURLConnection *)connection willSendRequestForAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge{
    if ([challenge.protectionSpace.authenticationMethod isEqualToString:NSURLAuthenticationMethodServerTrust]) {
        NSURLCredential *credential = [NSURLCredential credentialForTrust:challenge.protectionSpace.serverTrust];
        [[challenge sender] useCredential:credential forAuthenticationChallenge:challenge];
    } else {
        if ([challenge previousFailureCount] == 0) {
            if (self.credential) {
                [[challenge sender] useCredential:self.credential forAuthenticationChallenge:challenge];
            } else {
                [[challenge sender] continueWithoutCredentialForAuthenticationChallenge:challenge];
            }
        } else {
            [[challenge sender] continueWithoutCredentialForAuthenticationChallenge:challenge];
        }
    }
}
@end
