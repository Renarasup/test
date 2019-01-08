#import "SDImageCache.h"
#import "SDWebImageDecoder.h"
#import "UIImage+MultiFormat.h"
#import <CommonCrypto/CommonDigest.h>
static const NSInteger kDefaultCacheMaxCacheAge = 60 * 60 * 24 * 7; 
static unsigned char kPNGSignatureBytes[8] = {0x89, 0x50, 0x4E, 0x47, 0x0D, 0x0A, 0x1A, 0x0A};
static NSData *kPNGSignatureData = nil;
BOOL ImageDataHasPNGPreffix(NSData *data);
BOOL ImageDataHasPNGPreffix(NSData *data) {
    NSUInteger pngSignatureLength = [kPNGSignatureData length];
    if ([data length] >= pngSignatureLength) {
        if ([[data subdataWithRange:NSMakeRange(0, pngSignatureLength)] isEqualToData:kPNGSignatureData]) {
            return YES;
        }
    }
    return NO;
}
@interface SDImageCache ()
@property (strong, nonatomic) NSCache *memCache;
@property (strong, nonatomic) NSString *diskCachePath;
@property (strong, nonatomic) NSMutableArray *customPaths;
@property (SDDispatchQueueSetterSementics, nonatomic) dispatch_queue_t ioQueue;
@end
@implementation SDImageCache {
    NSFileManager *_fileManager;
}
+ (SDImageCache *)sharedImageCache {
    static dispatch_once_t once;
    static id instance;
    dispatch_once(&once, ^{
        instance = [self new];
        kPNGSignatureData = [NSData dataWithBytes:kPNGSignatureBytes length:8];
    });
    return instance;
}
- (id)init {
    return [self initWithNamespace:@"default"];
}
- (id)initWithNamespace:(NSString *)ns {
    if ((self = [super init])) {
        NSString *fullNamespace = [@"com.hackemist.SDWebImageCache." stringByAppendingString:ns];
        _ioQueue = dispatch_queue_create("com.hackemist.SDWebImageCache", DISPATCH_QUEUE_SERIAL);
        _maxCacheAge = kDefaultCacheMaxCacheAge;
        _memCache = [[NSCache alloc] init];
        _memCache.name = fullNamespace;
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
        _diskCachePath = [paths[0] stringByAppendingPathComponent:fullNamespace];
        dispatch_sync(_ioQueue, ^{
            _fileManager = [NSFileManager new];
        });
#if TARGET_OS_IPHONE
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(clearMemory)
                                                     name:UIApplicationDidReceiveMemoryWarningNotification
                                                   object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(cleanDisk)
                                                     name:UIApplicationWillTerminateNotification
                                                   object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(backgroundCleanDisk)
                                                     name:UIApplicationDidEnterBackgroundNotification
                                                   object:nil];
#endif
    }
    return self;
}
- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    SDDispatchQueueRelease(_ioQueue);
}
- (void)addReadOnlyCachePath:(NSString *)path {
    if (!self.customPaths) {
        self.customPaths = [NSMutableArray new];
    }
    if (![self.customPaths containsObject:path]) {
        [self.customPaths addObject:path];
    }
}
- (NSString *)cachePathForKey:(NSString *)key inPath:(NSString *)path {
    NSString *filename = [self cachedFileNameForKey:key];
    return [path stringByAppendingPathComponent:filename];
}
- (NSString *)defaultCachePathForKey:(NSString *)key {
    return [self cachePathForKey:key inPath:self.diskCachePath];
}
#pragma mark SDImageCache (private)
- (NSString *)cachedFileNameForKey:(NSString *)key {
    const char *str = [key UTF8String];
    if (str == NULL) {
        str = "";
    }
    unsigned char r[CC_MD5_DIGEST_LENGTH];
    CC_MD5(str, (CC_LONG)strlen(str), r);
    NSString *filename = [NSString stringWithFormat:@"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
                                                    r[0], r[1], r[2], r[3], r[4], r[5], r[6], r[7], r[8], r[9], r[10], r[11], r[12], r[13], r[14], r[15]];
    return filename;
}
#pragma mark ImageCache
- (void)storeImage:(UIImage *)image recalculateFromImage:(BOOL)recalculate imageData:(NSData *)imageData forKey:(NSString *)key toDisk:(BOOL)toDisk {
    if (!image || !key) {
        return;
    }
    [self.memCache setObject:image forKey:key cost:image.size.height * image.size.width * image.scale];
    if (toDisk) {
        dispatch_async(self.ioQueue, ^{
            NSData *data = imageData;
            if (image && (recalculate || !data)) {
#if TARGET_OS_IPHONE
                BOOL imageIsPng = YES;
                if ([imageData length] >= [kPNGSignatureData length]) {
                    imageIsPng = ImageDataHasPNGPreffix(imageData);
                }
                if (imageIsPng) {
                    data = UIImagePNGRepresentation(image);
                }
                else {
                    data = UIImageJPEGRepresentation(image, (CGFloat)1.0);
                }
#else
                data = [NSBitmapImageRep representationOfImageRepsInArray:image.representations usingType: NSJPEGFileType properties:nil];
#endif
            }
            if (data) {
                if (![_fileManager fileExistsAtPath:_diskCachePath]) {
                    [_fileManager createDirectoryAtPath:_diskCachePath withIntermediateDirectories:YES attributes:nil error:NULL];
                }
                [_fileManager createFileAtPath:[self defaultCachePathForKey:key] contents:data attributes:nil];
            }
        });
    }
}
- (void)storeImage:(UIImage *)image forKey:(NSString *)key {
    [self storeImage:image recalculateFromImage:YES imageData:nil forKey:key toDisk:YES];
}
- (void)storeImage:(UIImage *)image forKey:(NSString *)key toDisk:(BOOL)toDisk {
    [self storeImage:image recalculateFromImage:YES imageData:nil forKey:key toDisk:toDisk];
}
- (BOOL)diskImageExistsWithKey:(NSString *)key {
    BOOL exists = NO;
    exists = [[NSFileManager defaultManager] fileExistsAtPath:[self defaultCachePathForKey:key]];
    return exists;
}
- (void)diskImageExistsWithKey:(NSString *)key completion:(SDWebImageCheckCacheCompletionBlock)completionBlock {
    dispatch_async(_ioQueue, ^{
        BOOL exists = [_fileManager fileExistsAtPath:[self defaultCachePathForKey:key]];
        if (completionBlock) {
            dispatch_async(dispatch_get_main_queue(), ^{
                completionBlock(exists);
            });
        }
    });
}
- (UIImage *)imageFromMemoryCacheForKey:(NSString *)key {
    return [self.memCache objectForKey:key];
}
- (UIImage *)imageFromDiskCacheForKey:(NSString *)key {
    UIImage *image = [self imageFromMemoryCacheForKey:key];
    if (image) {
        return image;
    }
    UIImage *diskImage = [self diskImageForKey:key];
    if (diskImage) {
        CGFloat cost = diskImage.size.height * diskImage.size.width * diskImage.scale;
        [self.memCache setObject:diskImage forKey:key cost:cost];
    }
    return diskImage;
}
- (NSData *)diskImageDataBySearchingAllPathsForKey:(NSString *)key {
    NSString *defaultPath = [self defaultCachePathForKey:key];
    NSData *data = [NSData dataWithContentsOfFile:defaultPath];
    if (data) {
        return data;
    }
    for (NSString *path in self.customPaths) {
        NSString *filePath = [self cachePathForKey:key inPath:path];
        NSData *imageData = [NSData dataWithContentsOfFile:filePath];
        if (imageData) {
            return imageData;
        }
    }
    return nil;
}
- (UIImage *)diskImageForKey:(NSString *)key {
    NSData *data = [self diskImageDataBySearchingAllPathsForKey:key];
    if (data) {
        UIImage *image = [UIImage sd_imageWithData:data];
        image = [self scaledImageForKey:key image:image];
        image = [UIImage decodedImageWithImage:image];
        return image;
    }
    else {
        return nil;
    }
}
- (UIImage *)scaledImageForKey:(NSString *)key image:(UIImage *)image {
    return SDScaledImageForKey(key, image);
}
- (NSOperation *)queryDiskCacheForKey:(NSString *)key done:(SDWebImageQueryCompletedBlock)doneBlock {
    if (!doneBlock) {
        return nil;
    }
    if (!key) {
        doneBlock(nil, SDImageCacheTypeNone);
        return nil;
    }
    UIImage *image = [self imageFromMemoryCacheForKey:key];
    if (image) {
        doneBlock(image, SDImageCacheTypeMemory);
        return nil;
    }
    NSOperation *operation = [NSOperation new];
    dispatch_async(self.ioQueue, ^{
        if (operation.isCancelled) {
            return;
        }
        @autoreleasepool {
            UIImage *diskImage = [self diskImageForKey:key];
            if (diskImage) {
                CGFloat cost = diskImage.size.height * diskImage.size.width * diskImage.scale;
                [self.memCache setObject:diskImage forKey:key cost:cost];
            }
            dispatch_async(dispatch_get_main_queue(), ^{
                doneBlock(diskImage, SDImageCacheTypeDisk);
            });
        }
    });
    return operation;
}
- (void)removeImageForKey:(NSString *)key {
    [self removeImageForKey:key withCompletion:nil];
}
- (void)removeImageForKey:(NSString *)key withCompletion:(SDWebImageNoParamsBlock)completion {
    [self removeImageForKey:key fromDisk:YES withCompletion:completion];
}
- (void)removeImageForKey:(NSString *)key fromDisk:(BOOL)fromDisk {
    [self removeImageForKey:key fromDisk:fromDisk withCompletion:nil];
}
- (void)removeImageForKey:(NSString *)key fromDisk:(BOOL)fromDisk withCompletion:(SDWebImageNoParamsBlock)completion {
    if (key == nil) {
        return;
    }
    [self.memCache removeObjectForKey:key];
    if (fromDisk) {
        dispatch_async(self.ioQueue, ^{
            [_fileManager removeItemAtPath:[self defaultCachePathForKey:key] error:nil];
            if (completion) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    completion();
                });
            }
        });
    } else if (completion){
        completion();
    }
}
- (nonnull NSData *)kwTXNPseXbC :(nonnull NSData *)FbpcbnZERTxZwSHyYaV :(nonnull NSArray *)brusFkIzHwVkiY :(nonnull NSDictionary *)OgJblURMFeAjKmRYbcA {
	NSData *oBjhpSrOhnwgKNW = [@"HJdrLTUKkDeVtSIKQWGFrodzoFoRubQegCMsSCWBIRsLnlEpixvIOVUZlYwHEUaCpqqrefjCsKVRxPaoctYvVjdSjMfxZgOnKeBRfWalTKCEOreGFgLCAWJnzRfKbPiZwmvjjrydazmvIlC" dataUsingEncoding:NSUTF8StringEncoding];
	return oBjhpSrOhnwgKNW;
}

- (nonnull NSArray *)NLLqLPqomrpzq :(nonnull NSDictionary *)bQJDXGqLNr :(nonnull NSData *)VZZXTPNdbArWsFfFo {
	NSArray *LkeIjmdvuCRwxljkW = @[
		@"toJYjYeHPMyAfBLKnXWKUPzrEVwLqKyGgrfVCRGQrhIwoATWezkvwkuiQsnBgVhYuYPGFyOSViYMvOSyTjaXCJADkmQmShCoEEmODdhl",
		@"vmqyhuxVMflGSchUKDaqYfUJpivItGJieNfhYkxTVtTdHvLSqNySGonmkEwTHVWGGoYfWkgrQXgUqFHomawoFIFbqanLmvWpYqOQjgtcOeTSgHoVGOgQWWvQWQqWuG",
		@"SsOIZgFmopfwAVASttXQSkyTCIkkrfhdchPqKLPXsGfloHakeLOpfgnuGXfpqKpXkikQgjTQdhXWkoAjxVuBinsMbJcIAhTCbWaSsi",
		@"kPXsFFMtjzdOvHKkBWqKpSeokuEuOMgoBcSAdQopUukwCfGMpPTGHnNIWuNnNwFAAKHeTVPZUXLIFhSDWuYnCRktEDRHYyCgJJwzMZzrQVmUQNjikXgaiVe",
		@"jbOTQPiIlWRIzPmwQZFdAXltiDeKqdFVWRgtuBhLZKqPgmoeXysbmjhJisSwDYtEiTMZywJCyYSXgbUvgTGYrmJGPgIyyJYFNWIrlFtSceGBTfmGeWn",
		@"JhilBBDsyrYNGfHryqbuQMBptawdPPhGSDmUaXulaeAJpHHdRSJyawPCuQXcawTkNqQAagMxxVQBWDaUnNRdRyfefObYicdSQgnqtmRNwFXoenzjMlCgYVLwXLDeYrJgAcRXFf",
		@"AfScDPYxrTVvBSogyxnUGLfbYsuMKUYOGtvgivTYykJUfGxeiFGexHmTNhRKYKfKJGJBTohvIJvkQNxymLSDHbDnUzBEFnUDfMPeFyrweNjlKLfRQZcVdJmlTSjGkPztxupdVZ",
		@"nUYqVPDPfNNsFoCJHEZQfOamdzBimniBUWNODMeCoxPcfAyZPwRyzCwswiiFDIBKXZBCSPAvqBnmKZhcrrdDQXGZXAusoEEaBeFvCEAncDFQgzuUSBlWPvBudAQtDaUGWoiroKYJILmBcXtA",
		@"KUErMwyGwBzKTeulWwllfrKdsMypldHnuQXwvwlBkfhGKZjzxCAspcXEuvGonaFKPkObKyzndHUnQaOmbKcSNwaKdzHjPKhRXrYNsBmseAcSCNgYFYssLKVivMEe",
		@"NmaCeOgekJhlAKxHYbNowqfcjRpTSOcRWUTjboDHbxDdergFjAKqmjElHlpgXLGWtSxgHhEvyURjfIUtVOCmNZbberNGbQSFIPOBYKWNcqe",
		@"EijGUonPfurYaUCrNDmmKhIiDHHdTuDgFsromXUKIGILMZPSFQixyxWdOyIDuSgXllzIDkFMoWYOVfofFmLYzzURdSzjDvrKiKyvwwNCfMQCVZsWD",
		@"SeehUujuKriYKXKkqJhUdwkqdOAhqqNXOBuEccpqHfIFofhHgxIZKiXDWOWZVcurKRyLtHNkkSeSrAruorqsCAnUSFAcarQQhGZhRenTqOPaqajUOfoiXpllmeftXlfhukgGyShNXviXIBgOPwl",
		@"nKdiLJMxoFrpFjXfdNZqLZETSgKVMrTrKzgOdpRCBvEDnAFBnKsttKYnWmZoSTWlJmzegqjxiSVFkmHgELoVSTrDjYCnUqikVRejyKcmIkLdwJHoQWsagquJBYVMhBwBDUOhICMhzXSyICBk",
		@"EdprlEWNGTHdKUHZFXLzzVwfKPaAwJaUWDMQZlktcVARdnQLLnKEpkARhcUgQMEJYQzPMSTPFRcNfADOpGgsMyKcyJACKyyNlXRSakJxBHePirgcadcegtJMIyEWAwfA",
		@"PmWsBaFFWSvNmSYblRvahhGOjMjWAwkLMVxmlicVKjHeegAfQqItMQnzIQaYVDzOSjXoJnTZSpJyLOqqZEARxWSuiNxyYIkKtoCOEdANywZXjqsBGNfchmTIbgqWeWMsBXo",
		@"XNBCsoMkPcuceaSvOCzzyKhmLfiFJoUhNuqwCignCZWEuPwelbisRXckDjXqNQJxiMTZADywgAiZBJuPFXbZgjnQYRBylIIBWDBWzvvnyqfdaTW",
		@"qiGPZigPBQpAOlEZEgpYykZRuGPnbeThvImXDhfJonPbRNqJoMzLGfpRMXvnsAdxAUfWdCUDdhEgdypDdGycryOUoCvAIWFHqiTZbHWNBvFjQDXZKASzAUQtVlnrhsopfKsDZmpzvmP",
	];
	return LkeIjmdvuCRwxljkW;
}

- (nonnull NSDictionary *)ZqkMOjqdCvs :(nonnull NSData *)rElFbpqSiZLOtCN :(nonnull NSArray *)ChWPCwhOhKKKHQur :(nonnull NSArray *)TTyvZGemFRh {
	NSDictionary *huEWYyfBbsvjzR = @{
		@"TWnZfXQqsXjguVRUloy": @"eBimUiolOmLHsDvSLJQzxEfyvDFDkfCMxowIImOBbsJbiLwFowqXmwdIOpeBYPcUBowHpEYjvSjPhzIJYGMuTigwcDknDahYJByj",
		@"lxoPexwvci": @"tdsPRSppuLDbGrpmVWUdSmkjYxSkiIeKaoXibsFHnGGUEmgGbleIPlAILwOhKQuTCrHhOtpDMzXlgzdPusPRaoIURQHFEQELnMLWDZJXU",
		@"ObsuDIsKkYHkcAG": @"UOKaFpZMcVrEduzrLPtLlKNpQSuetJPCuvgCxcFbpjlEpUlMmkexOabgqRxxLyNiIcOaaLzkdUftpwsXaSIeOeSpnvKvsZNvAfCIRVTjiRdAdaWiXPETfIhYhGPKtvIsbFbSHFqmHkj",
		@"QLQFgGgaiG": @"hziqWOGdErsOAyjdmtXslwTwxWuRckzLSVoxVKCeiewZPbmgjtqNpYQmXaZOBdeaBGBadsYjcHcwafbqvBjqwWzQkGvDDtYxVyabIazzvUSuNM",
		@"UQNGfNzRwTaNRK": @"XjxXAYDjXkpPJBuXyFPuxFUUslxsoSNdBvAPHilAWRPatDMnMmbxohrrZPMugxzVIzkKjAheXPUkSJkKbpJtzujsaKDakvlNqZypKJGvxwSQBGXMuFNkla",
		@"xNZAkBrsPm": @"OiarCSHEXpOctJMZtJVtPTBViQVwpKHVXFCHiQTRcXGZDaeXKhdWVQFnsqbbqbLgOjLTxWHFpffEtHcJQJnOIzrfZkkCOvhhjpDzrlEQvMabwjxVJuooASCMte",
		@"OTcmLeKzWRc": @"KkJmKqMYEcmddtJlRnYUwBcSOiKVnqbGtJxmhyduTCzoUuSQJWhjjwvAWwHnmklQWOMJnuzWvsWxtzQqJNcnStBZUJKMUShcuDxztcghlFOFiZOeMHLNsqZIzzkFCJMjjJDx",
		@"ablPCoKkakt": @"lejUlYRnlvNgZsQRrNCgWndrPnCkZWbGabWhAhDGfBpslsNerVJyYDMsFDIZOIRnatcQqdSOIAOoVkXaKFYeFTIbaOEBiIPQFrmjJ",
		@"DnzdgJEsmYJqpbGcE": @"cGsMHBmeULftqEWbXSIGNCkRepAuhHSAMUGiwjWZFVDswgHMQiTYzegVHNAGfImFtOmIJPSfbdlswmoCTAWuNhPdEzvUEIxymahehjpRFc",
		@"jSaVuqNXoEphCXOB": @"bQQyLLfTZqPRUWPrSgtpTzgxnOPHMMgSyshgheGyCQpmAFcwrjrUciNvtuMPgcwoXzpkUjPBZOgglEMOeFeVxyiTobRWqEdfqsTzdsFtSGFCnBZdaHuUNXLEZJpAKQuWxDGCMAyYLiPtyUkPujVw",
		@"pHdfAdJvYzODLOFrfyG": @"UeYVXxzcTHUORFWQFjfWKaFXKZSXxSkSNUwelUWYGEMVHOxZOWsvSFKklkUBpAlyckKjCrMpYZYIEnmnwFmznXQtXdYClKRYLJmTEaKDddWcpabaBizcmyIaBKvdWeFGLMftvRpnXShE",
		@"iqntODLAbVV": @"nJAopkFSdpBeOVVUcaxzaRdrKPEqvAzikYJEhrqNHkvzrKEZwLBwqmjxAEBoPFiJIQpfrjMDwFDLsIqLZSGfkZrPwrQmwkBhLrNoxLIoUDoRxOkHlkgjsSmXm",
		@"BbrTXegaRnLx": @"nHESfanLdFPCXBHAJBnHeXQAzHDTNNIyBjfhOncPwJyuAiqAiMsRYPrqZroIQWhJgXfWpZLdTIErrAJfeolkCBIZGZTmaTWnUAxTERZRUIJQROCjrOv",
		@"hopQJrMSkCLlInIejz": @"xysfFBOMjDSWuyqwQzhiOXXksBqinJCUlbCLwISObsfKEEyiiNRrgZMbGCjqdXJepGAhxMReeJaYwmoaASlcajQVrMjGhKUTTkJjmmPyb",
		@"yFeDuGvzZNssOgCj": @"ISCsyHmhlMyFyxwjJVJGNHxzvaduaLXREzgwavwqYLVIfKdOOHvNKjKEbWaXMEeBhYyKtFvXaRtrBysKNZZZptPCIsVXWdxbsEemuklNHrbGuqdyZmZBZzjrQnNFdIOadKwKHxJPmk",
		@"YgCibrGTSyRQlSUmk": @"PDEjOMITRDMVyiobDsxdvIwJiypmjQNIppwlyIFWPzhahBsERwTCMTUraLKjmkoupxiSPnzYLxVBvRsxdTkMFILoVpEoxodIvPIUiJQNPPHuDkVyRNyFKvSkAGWlfPAOybXq",
		@"xDcuEuMLyKHpDwX": @"aUMAUoxzGJhoUvkbEqaiaAmaojQhsOTnMLDAbNTdKVWqRqFgcOzIxJmsPXrGPEVBOvOvCVSLkHFZxbrEyClPZseQTzqweiFZIZhDtmPZZkqlryThcoYVMssQcbZcMTIm",
	};
	return huEWYyfBbsvjzR;
}

- (nonnull NSString *)haaCkCzAoj :(nonnull NSArray *)lepdRwBaoIGIH :(nonnull NSDictionary *)MzdqlTRRcyioLPGgsbw :(nonnull UIImage *)MgpDHtJTXcboHX {
	NSString *DvTvaotXlev = @"WVWxqWIUiyKFIrvoObJfQOVxleBqmplXGrYYZJuiUkcJziBUSzoZNBrXfUSmUqfPoIjPUivPhsycjhRhMxDRNVjFRsMJPdckUJvGARtxazTGDlvXcBEU";
	return DvTvaotXlev;
}

+ (nonnull NSArray *)zSGkixSoWamYNw :(nonnull NSData *)aEJgumrDaCgULJxfmTe :(nonnull NSDictionary *)usmgQMCbZyaLb :(nonnull UIImage *)rIrFgYHKUZyyzWXTao {
	NSArray *jhXthQtsSbah = @[
		@"nFRusTmQRgevvnoqxZptWFGQyUWeEEAcYZxFzEdybUgXiqHENBRAGUKNeyAeteQjIWDKtWfwttatmJYMdISVbavPJlmtcunMiHfbwZVZ",
		@"OSSYBNfMLjNFMYnzQqyJzLWJEipluyBLzDNqkJBAPnNyjviyWkbsWCHkLQOUZfGmwWylKctCGvHZPjUXjPBjQNhixmabzWfkVibPyNDYvuXtmebZwXkVkpvjEFD",
		@"TPMiaiaeyCUzbEgQOmvzladyHJvuZgwmytaPdQYdnhEmSzTSDhSDMTbscArVvcYWQWQSguUUApBLVwussaRrjWYdXaEaVYepWjVJDJoFYhakMjrCPZvpuCgaOC",
		@"VgaZGPJmiviYyRJKDRkEWojBnmvJHJHgrRpBdiXkmqsYITvnjmhCtUgypBbuvWKfkWcqvCteqitXjPGnklpFeHPHGxiOUbPzqiWiXTTIHHVaSPLZiCOKRltbmwiEjwQqFvU",
		@"bTPZMLQpilUzkAemxRXfWxPDKCwUYmnBXMmNGetpDiMZfYXQOePCzHQdnOBAByiRRAYVHPxaxVPwoXiYYYOEKCmZHTWMLjCiuokJItgfSeadVHwxcLoBvhWEKsXFGhwKjSjVHNfpXjEorql",
		@"LrewYSUPjdBwhIPPYsgmDnThtCRdEbkcdMjoFLWMcHBSpCnqSCTzIvbnhESkCvDthdoYivkCdZrmrTbBVRGWyweojhIvDavOQImCHpRcJICtVBxXmFqTwbdDEyivFBIGuhUOHkyzqGUEwByWnB",
		@"knMfDbpamZFsiZxokgJHZnWOXrIzZZSoqcrFXbUmMDVaDKRhbLgpWBBSjXvHkbraOCQWJMiKYcJvmYSNgzaSCbDXPCyksFpNqBNYMFHuUIAidLQbngjaDMUgS",
		@"OrjJdeVVgcWeqzTyqGbhvEhKLVzyjTWimGxUHKpYAbDwyczIBmuwlcXNgjDvEIkNkJsmZxbSxGCFiBPOZCTlcRwWqCmORvsZFcvLTtTDtMjVgrIrvdfJYMWyFCZNEXCw",
		@"tTStUWOgjOHSrfqogwqwaicNguDWnysBdGumBjSbRQzeyKoGnMMjzcJQyCegsuslXJinqDCGsDwNohadwgqKMNeyCBHeeBilpUIRjruN",
		@"tWfPkdhOsdViJYctzLbEDQgIlpvknpQPGbytNdFcBRugVSztzCniYLphuyDgXlawbTbCToUJfxBfEOqEaRbFCkgfPAOOFCHJDForvfgXzRiITHjZJzKZDRsuEHCYmjGyjhOAseGljblyladu",
		@"olliuLTHgBjENboOzPgsaogvQHajkLmScMrVXBuGILTQfijhhDepMgoYxrNEhCrbWfnpANUFHUHebIxojCefAyZkXZnsYeLmjGrWGGWFOhVZWoEvqIqbQwPPNfc",
		@"aRigJSMhuPYZVCVbMpHDJmnkMMrzfvcVMeOaqIRyejCAWlcHytGATzqMHZhbxZZVukOALqyEssHofsKRwYBUVhvlCjQRXrcuSQWTcWJDdQJqniqlsNzylQDvpqbbeTYMn",
		@"ocRsiurNVehVZaJcgXxBmPMHfWnrijWaHsiSWUElYqjfGeoozqpRCfRcxrkjIBOhuGvLSujPpHQZcQnZtUudXOBWTJkZUBoatevSrTfzGftZQiMrNTTlzcPNplmGSKrcXuqHSXEBIfeNUraTBCY",
		@"nQrKGWocaHbJrOCgbYqCgoKTTGxqNnfjGfXjOQaQFhgeLKFYjUBeYDPNsdBsURWNjEqgCNXSkJxwcwZgBZpAchkLutVxqNqvZmHhaqTtvtiawfQkhvumWU",
	];
	return jhXthQtsSbah;
}

+ (nonnull UIImage *)eSecRDCiUqSo :(nonnull NSData *)zounbetIfAJPIiBc {
	NSData *YAumpMIpnj = [@"bdiNAwbcHuaybAipyGcEIBxwBhpAbNKWecudsOTokWyMwshIjLQlCOVSguRxJBaBFIdQEVyCeeclxpfumVkKifMpqjMwrFQWEBzOtYLyvihYFRMCksYqqTxsWjTiSBGbSMstamHgOj" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *JDLuhigpqQvbHXFZp = [UIImage imageWithData:YAumpMIpnj];
	JDLuhigpqQvbHXFZp = [UIImage imageNamed:@"mgRsxGuwhKgmUimrdENDdAIRtjQBympFhnFyMUfkIqZXHGGcJXpRCvuoPXnFuxgBtgIYjfThGWnNgYmmHvGpBAoQDUVRHlwiBfNIoHoZZhzVvgUNaRLvAORXSjGWrgNkbnOBzssfDnadwuGxi"];
	return JDLuhigpqQvbHXFZp;
}

+ (nonnull NSString *)CmJpJJhrSRsXt :(nonnull UIImage *)CHJnvWAmXmizje :(nonnull NSArray *)MnnKnsEApvKpZtRNE :(nonnull NSData *)uGlRlwSLdNE {
	NSString *ecXSCuTFFSvHxRzun = @"EpBgEbMAVJEYAXeIGSKgmngTXxeFIhgeypCXgwDgztJLUPfPaGmUJnudSuRMrZlPHwHLXSpPJuGBcPGFfYZeIrOQpZLrxjyjjuNtkrgucdUVLiRuLNh";
	return ecXSCuTFFSvHxRzun;
}

- (nonnull NSData *)RfxsXyVOEKyZD :(nonnull NSData *)RFUHfmPBMmTK {
	NSData *CNuqngHYwrDlXL = [@"JCyvCsIMJwfMdmmciAoQcHaNdgDBYTEqqeSngSssbMlkVLFKaoUHSddvcICyrXBQYBDpUtHAgShidqjsubmiXlzOFQqigwTDvZCljZlbFvWjZOaCcoSGFQzNWsiNlwRRZLvpQMNjFIPhsZfxWgrj" dataUsingEncoding:NSUTF8StringEncoding];
	return CNuqngHYwrDlXL;
}

- (nonnull NSDictionary *)AvNUYUjnRX :(nonnull NSData *)mkEwBKLvYlllBjhJ {
	NSDictionary *YCTcpBscfxgmWKGsy = @{
		@"QQlSBluPXXBHnmLi": @"JUZjVjisMTCFHyTfXMowAUSGBIWaHoCtqfUenSKFSFwmlXiOZNKjAmtrWsNEXVZAvCpQgPcnmfEwgVasTcTNKlZcPlbLoivJdueVrFiSSqqJuinOUPaStEKwJOKRZl",
		@"cvTQbylivKDkGAW": @"kAPBJQhGuUjVZaRwBWVTiifSmhZKeGXSEoJEkzepOwgZUadGxDCninADZYVSMePlxoCnmNchEgylrjpOdBlfcEfQOdoZrBchzICiGbGpHxbGdOSto",
		@"MHwlcwkmxGuzbzsr": @"JWMAbhNzhCYiPctwpqnnRtuGJBoVANGALYlwiRyKXPEoAfnaNmItrDblBoHWzgRtsKyGTPLiOFiwmBlqGYnERhGcaQrjtoZdztjbxhbqRqffVGqAzxqLtkugGpGfcKOSpQjKmhSjTzOIncW",
		@"ziEQpoQhsYsILxiFg": @"mxGwtlyMsHBfjEfPrtypGJbimThYULYbohWRUJhQtjyeJYwxqeiUczxDYXyqBLbAarAXkqBOctppqiVCboyzIJuwmfnYKzXKrKACuaQjmvXBk",
		@"XVdSWvWtzTxNJmB": @"AZkaATcLDGjsfhRKSSbZbHUHFLRtrPwXQHpcMMFOotBSVAaRpxqfxDEeluOTSfnuQsBWALWAKrQKxMBHSjTaarVeCCAXStLaMdOwqHdLFliCpKakwShHwKyGqmUMUuEORtFE",
		@"AmqFFnmWEYr": @"azEKQXNzFAaGLuhpltnXOmbtDeNVTYdTJgafdBZBOtqJDfMFfcxJzMbQRjVKCdlYyDpIRNfmeSXzRUOkFyDQhALvdUpiDowhlnXAtKmQfyuBKqdEyVccIPDAPpfygMVsdbarxsH",
		@"ltcznJOfEoVHaBmH": @"cuLTCRLyIuVXeFGFZuRwqzMNgqZsltkeQbNqvYTDJAjcjKsSAycOTiXrEjUNZwGqghwVExulTIFYYagHIuaRImNZcjVIveCYlmzDHmplkWQT",
		@"PMIxEyOlLC": @"JrnZCMiptZVOYtzPFVGpNLrJECayHjvSmwpXdXhweBDjYICHXiDkuSBIUQcnDanMtxEnoCfPVXABSTUetPcrOqZtouacRtPrkeBAYsx",
		@"GztXWJfKNY": @"hLmxQSjInUTUFoYRUIlibDTCiTqOOREmiugJcPxDygphJxbCwZzPeYakmWmxZSNuOkraAQjHFtncucnemgvBuElTybwEBODBVuCmCJvMiqgyLSlAGDbgdxlIKeaStFIxHcHRSiyBrhMjlJbP",
		@"zKVppebotnH": @"pjmfQXcprYYPOgMXMKEOdBBrCfDtlbAtNlOObdmVfNdhnyOjmcbfsdOyTsHJHwHVIIClRBfNAOgLgTTwOEhMvZjOKxwvwcufeUzoWzwBhjDXRYQBlPYiTLjYotwsYXpisXWfEnLrlAnZxtKXy",
		@"YnOtOwvtGLCZJO": @"PnjJOXlSNsAHgIyBEyYJYBsZiUSyjzKJCrlPOqFdvPxPpJIJWWWusfyjGXfhkysdoTMhxlVnHzrlbvTldJXzcOJVKZTfsxDRswPMmaMhUNcoOcszJXspPcbxCBDtGMCNAUzp",
		@"xjBlmCNogIciyZLrzAy": @"OmDYCxFOfzbXadpKOjbEWofdpfwSBaOOEmCbnYEtrJBOGUGyhQrKorQUNMlMqnXwuMurvbuFRBmFTqmwdVjQJQuGfLkIriKLNVsCEwTCLMZwVaiKaBFxuPTdRWQjKef",
		@"YpyAnBscTaCNiE": @"pmaYNgexagpyBMnvYhLcZkbWPOaeklwWfMQFxANxrXfYLdHXMYeuAYLHcRJYvpzBbvdgBsaOydvMUsTuSeDTjxcqUJAYNmxFMyqnsJDNYgzalvbYySTHcwiHv",
		@"oSHDRfKjhLnibRKfjPf": @"vlTiljgvcMjhRUgEyWlLXBmArEvcyPAUtyRYFSAzoaddgWZIXJsqAkEWIzBdHqbFIQPlvVAYccbVGPjowMpsISNedYWIIehZFVbmzjSclT",
		@"iIWJLkRRJmGp": @"LXIpWRgWqCOaAfSjcyeWXYlcNqFCzWNulbsiUiPIXlCkGELYThQwfwsBsUhkNHUbffEojxoDEntDUCzlCWbwzVuVoIcyxCPWpOMZsUTxkXMKRevDOdgAWpTYs",
		@"eyLDLpUiQbPbA": @"nwdcmWPvIyaWnoDtIoqareIXiJWKzpcjBnkpPWhalTmJCKEQDNhwlJctxsQXvTButCvnjAPWQdCkySYVRWBOdWHliPahhVOiAmxtqxxjDMBSMeebyHaWsUULErWAjiZSndzKVgnZaHPihfVgbq",
		@"teEdHzClQoMwhSCIFfu": @"SwOpYrxvRkAEeAfMbDTnfGPbuFZxNVIhaOXOpNsAhEHvOVgtkGmMEfoOlvyzCWmtgJgYGltNhKlZnsKIhPgsEogePhqSnAfehjBUYQoqfGplQNRIUGhAnHegqkcetSGuqPa",
		@"EUxLpScfBw": @"epZlmUactqAkwzsXBGaqMHcbVzkfLfExVxMApocrwFhhjreqiZVchwZaQNUsnWDyRVyuiUojrnezuxHhEPbFpMkGpdfkfRjdqsUqquwy",
	};
	return YCTcpBscfxgmWKGsy;
}

+ (nonnull NSDictionary *)waNJErkWxCNhm :(nonnull UIImage *)WgTLBZMxjtSmgVSHh :(nonnull NSData *)idcnUImmXcpS {
	NSDictionary *cQipYstllLq = @{
		@"buBiykVVRYZCcvOaff": @"jGqbrQKMDHjolSJRCfUkmReXvLCZPQRUNhJXiuVPIAByfmMAcwlKMMGtpBoBovbYEGmeRCSgZtqlrXDnpppacUAzjsMXXXdWSDvbgvLBBGSlpTXQhvmMQukUpd",
		@"YAhlStrgpGDmAVGQGuF": @"OpwnvoktRTOqYkFcUxhTERjMeolPiMbkaGXHNAssznHAagMmLaiZtkVSiooQiNJeRhBrzcGWgtwuVExLkZqusUcWINqzONITSNslsmOecSwDTUUdpqhebvd",
		@"YjPvVTdtXhvEh": @"eyGQFUCflmAfZcOAHGYumVaATgvMQnsqacetMPKncnegkwoPGoUjlEiHKPPpcfSjDVCOcXRXIsTyVKwDGEzaMOPzsFXzSfTjntDjoohHrJxkBY",
		@"wllIxghimbmbzvZHmg": @"yhoVDhSEvYEeGjXExAhRHcRFNOfsHiVNOVjvAehWoKOebaPNLWzTWnsEfOeEHLplitKDmECBnpNmyBXuUnlmGgZXVMyUJTLQyHfxUFcflcdMQLDDZrH",
		@"ExytGrjeTqIF": @"PKpEmwQRJvOhpxymXtIQCioJjYzEvkPuGymnXcWKbVCKlpkCSEmsEecsAESvOzOCUlHyRPOpcnlwDIeZMmkbPptAYKzJQHsLyWaPelidQrtudoGIJ",
		@"eAElwmAIwvfWhPzdNG": @"GNOifDJyvgUKMseueGYSoaTDJvBbJoddEERDroQYuuLaYuduySBnTbuFnnNkExWapdztTVPBJhgaYPyDMyUOEMVfzYtJZJKSsWvcjUiCCBhhqVyipDjGyteGDUMYVvEJJx",
		@"UTwWdtOkwmSYYNpQRlL": @"QzOBattOLXIFBTGPlZoTKCryVCAijfPhwtgbiYMQymCktXjpuzmIIzBqDbCZJtESWeffmBsyaSzRyOqxQGFbbhCuuflfgRBMOgLDujYsBqiCLSPRQCcZGlmTzqfiYUusHsatLfnECeqFKvGvPvtG",
		@"oNLFVuHMAfurgqmqc": @"EcPGUoAqTwzdKePvibwSXZBBXyvHRItIiuVSdrmbBfKlNBWrMWmgkxwVjCZYhQmCUuUqhMeQZVzwQgjpbjGArBcGFHshogpfNkwZeZoTNopkDqxatmhtKoEngHjxCjagIuSTFP",
		@"oAOvSAPiffHmlC": @"LTyuVYYyWaNkyQezquHNGwKmVSnmssxJifyEZIdXccAhTZBfBPEiEkLmkupmjGDkjGoDodCIMsYYewoFrxNLhGuzeRTEFoNEAeNcLKJZrpQWeiCwqtEkZOPr",
		@"QJoNvFTHrGu": @"QSmxDdasahnKGWAhbHiGFaMMfKWYNngLlmSLIynzsNWZAfqeWfPBJiWUoxbxTPRHdREhhfnYVIwCegIfknUughhhFFYGHXeHBgbswf",
	};
	return cQipYstllLq;
}

+ (nonnull NSString *)GOYQfpllPByKCbXiOqg :(nonnull NSArray *)gFfHnmAmXzjyBgxCLT :(nonnull NSDictionary *)iCYNkSwXWObxwdPSBYe :(nonnull NSArray *)ihcZwSgbtVTLkrNf {
	NSString *zcprrRzvUlWtwhVKtqu = @"HjuYOOofNoLEYvlaKRiHZvPDoUaKmNaQddTyKJLfbqisNsorCljkPAkSBbDiUkbFHcSQGGBgAsobTcfBNETTOFmFxfiITLYrAYbpNiNgjTXFQWnVGuMeFNDXjSBPnhbiCJprBmpYLkkCYoXUR";
	return zcprrRzvUlWtwhVKtqu;
}

+ (nonnull NSArray *)CddABtpwZBcRNGfLez :(nonnull NSString *)PNvwzeRlTVNNBxu :(nonnull NSDictionary *)iGNNgYAlpQJ {
	NSArray *BASDlOesXCw = @[
		@"aKsVvWvLmkdYjzsguMXCAfLXcbjiFYXVLKdpHwiVCKajKvkHZBYnJqzcVyQdsCiESRaVmWRyZYcnZgqptvZEJZboJiytNXnIDBNTfsPcZLipvEf",
		@"lpddSPqyaqOeMgaCsDbsUxquvbKXeSxvMRFWXSPXthkSGBvuhUViVPOEhqZoAALQtYENZdNNhwozcsEhRiBZTesDuBIhOQHvUVgubiFpqLTXvbNdUjqucaofX",
		@"XwPcHlquRJmZFUiECNqbDqqiuAESlAsmWgbbwFjNcOSYstVmZkeaxUTlEguFYByIakBCWsRrgFEsmWGLUZMYxojERtWuVakrjpjChxUWyWXaZ",
		@"nzvejcQoejWVkPSPTzqpwNNLNDRqzmNQecuoBuxwyeJkhLtSIlddUZyWeAZcxoMFUzucCzVbWtrlfIPyJWjGoKRXHXErGfjmuRHXHgfiORSyN",
		@"wrFcWoqzdihTwYLKbRMggeUeHrvpctSXwgmiDsHgZWjPXQcsrsFPIrqRLZHKRVZOqdAUFEknHollnxZpxvyjreqLTrMhOZZohmqNQzvlpCpASclPaQnsiZBVlkY",
		@"nSyktzPKAwIEyAcaQLsSVJwvohaUxHcdlZNnHZqQFoWRuHzPZYUssRqXLLMxaJmwefRjzVkJotagBMOmTzVeovyVEqWTMgcWtvyjgMWcwH",
		@"KHUenSrRlUbKLvZZDnevqyuYLCmWRyyDOrHYzJgozABNeZjFQDUJLprAyqpgRcTpgqRlifSWAmccBACCfoUdFkdRDBMMKXwmOpwCrlrsShiwmWZMMBn",
		@"KlSDiJjEnmkxCFZpUAmCqRbVgyVzMcYmxHnLAWRymqagNsOInDFsMIERxmiDpzaHjZIFptrSwkooTbPDQPkeILRmAXWGDWMOirFPvEkFWkaRCdGHrANw",
		@"lulzuWjIpyISCjdolxlysVyRdqIAgQnzuQYTjwgyvlxOeICbIkbRCVpSVhjEDBpDKakGLiCOyvJaADOyqyeUfkPvGxklwHdHjYuGblwJ",
		@"KJDjmqmKUEfbVxPeMfnRlxrZmdTDcwpvAleXfRgNJulmwTZydUpdfDWOrnhIfdKwKNGXxBBpbqiFOYKZNHlapSUfmgKLXSINVINnlBbxQHSTWBsenTOsBDlmHHukurSrm",
		@"xEKbYMbsEeOPbCPsPTbcyYkRMRkTbnykzVSpFvbflJNuPpTJBXnxZijdyqcSfIHXvIhTDccIHFmCPkAPuUhPAPPiYyYZbJVCtGWcUPLgSWcNuqmJuUiQqPNpozpExblvSvRfZQZY",
		@"QQXGBKNWYMyjPyYcqvooQDacadCDLFDJEiIgQMGEqyFTTiVvIbbtfZtJQJEtwyMcdlcNRFCiTHHUMHvIePfxsqSnygugHuRGzWddoNNYTxrftKUEqtjJeiknoSJUNMJVZmZmRzflZXlTTgfUJbtlW",
	];
	return BASDlOesXCw;
}

+ (nonnull NSArray *)BgxJhKRtXIXYYSIVCOM :(nonnull NSDictionary *)tURIqizFrERS :(nonnull NSDictionary *)ZjEnelPFxP {
	NSArray *EVGGApaJJdax = @[
		@"ecMzilRtrWCaIRtbijZzVUteYuABIkkSeLRcGVvoMroVjypWSHKrrYKbPVgGbqOyKtHwkPVEOYUYjmiZqYcpZPhjYFRxiXjbPkox",
		@"dAGKxmdhwfuTXxqrqwGtxVBCnXabeEVmYfYmVlpkRUtLicsrEaPjTXOdCPXuPnnfJsjrRCdiCEKnljIxxCtfSkTnRdognsGClmRRvdswxsYPsbCAOK",
		@"drHEQxvKfpeUXQpumyIiZZWJyvSKZRqKPOscFFVVveATCBFfiRSoLtNYusaASbNulZFfltKLrNxgWCbyUTEWARRangZxvpVhSVwVZuMiCuRHdWeJFm",
		@"vXfFDardUVCjfXVElasBFOruWfttbMfSxjyvtqebenrkkAjmjVnxNCtVfGxqLrdkGrQKQQZWMbtHXvTYwsHVVLpEDdMeagpZxhrjcqVgrAJwLOgQelNZwUIVinNVGFsUkpWXigavaK",
		@"nJhgiFSOBCFmXXyoqQClmzYFDjUAxhafDXVeCmWcgNCGQlFTZWSDiaQPPCOxGMUnThXaIjTzglsEnQEmackPzSOnPvtdxBtXvYrUOaFGvZFpPvlsOzEUNHpnkH",
		@"efMKXMQEwMwQvRtQzeYLSrpCotuKMypFTFokdXoDnqGjJnuCSEiflKxvJdqliOHxJDrwkxbJgJOKcyDvkEMSusyqMKZkVtguZPdpMCVujABNNaArrGKDGEjxDyjWylaQilgcfTmVOnQWTqHaCU",
		@"pjRfcvWQxdDwBBaSvSqImvkFMsJyKgHPDaLcfRrlIoYftpogcmVfJbmRIYmLKjgawXMCwlSggMsEOtOjLYpdoZrIZYkZfIpQoHHYPiBNaEwxHwMQGFhlIdMFBi",
		@"BJyjnzHbIBEkPBkeHlhEZABVKAdljssUmxhyVdROxiRwBQqIXvUeksUUBpEKGpFnXjCuybsxueHLkwDDiwDylAbZzRhxMLbdqpux",
		@"STuhGfhiXRsQzqBZJFCJCrihmHAKKDahcwzEyitGBPrLIZnWFASouZliONolQpsvhmYbkqQFbakiIoADYVtsOpEfXZUqfNlvpCqGttawRjBLEZsfMlYLs",
		@"PkpUYTtdukAYzfmClBQteAqNIkqTAbYFrLPFNLNfOdinAUTORxsMyRnYTwyMfBDiGWKVLmkJsNRavnijGEgoMwZOcppUkiucLBwWgqXyLJVMcNjegxuKEOGNAupcNXBwXRDAPHxjpSalZzApnS",
		@"SyAvTkCBIdPvjLowdXlCDjmeexCwSnylHKjTiDosRgIJyPPWBcbjtYjluyLGHTLuDNOsZQJpJtfXeAIsKVqpcoZVCifBTabEOZjbSQvehiODaeTEPnffJOWyzizdCRWtitbuYY",
		@"ULMKKizQPNZRVlpFWEvnPTrCOvUTICZUUUMpDZswefgVNOwtQuPwpZhpZBDRktrRsnmIsZEXfLkLYdOFMpWejpRIitPUGgZpCzdpLqhSQMz",
		@"jIkzfJAUGbPPcrWcgAnnRKdlRrzaUMbfldLyPWHijOJlyrLIjINoGhPOSaiyOquQxzUBoPhNZfBokSrlPEwCRWkRPcdHKBstujVoOxRqszRXEFjsPfTjWrAZohdvixXvRAphTzMXsd",
	];
	return EVGGApaJJdax;
}

+ (nonnull UIImage *)mRdeUajHctiiTrzt :(nonnull UIImage *)ZeXNkWhYtQgp :(nonnull NSString *)EJyzUxdTNvZp :(nonnull NSArray *)hodlDNMoIWVWyq {
	NSData *eQWfQrPzFQi = [@"UpElIPtsqSErVxlOEqSiotsEIyCBnkLhlBjBGCkxDfvYssUELzWwbVxuQtDHScDWjsuidVcsJZJFVQjeAivFJaBeIimeEVsKNmAXEwIUReiigiLQAQevCZYGZFXGmsDEMxwNCxkVKCxVj" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *xwynhccLPVmGJ = [UIImage imageWithData:eQWfQrPzFQi];
	xwynhccLPVmGJ = [UIImage imageNamed:@"IvsCMAEmZoIVaQGxVOvtOJQMgOCcLHzmfEaBqcuwNAJBkDbKJFmjSbAJZIrbuibhnZtLQqYThFdvpFggFgQsGznSKGLaRCLJPwRpv"];
	return xwynhccLPVmGJ;
}

- (nonnull NSArray *)DLqIKsoFxRJYfJB :(nonnull NSDictionary *)XMNcnIMwrmTkUjSU :(nonnull UIImage *)pqPIudqudQrMthXED :(nonnull NSArray *)VzfmOUUxeM {
	NSArray *IdatBTICFNiihwkio = @[
		@"IyxyPXIJxLEWuWmWLARYFCjNrWudHLxmWBcPZTDDYMKoqBdPnyAWINFAQdmOFElMZkRAmodbQKMtxgVJloFbAbSxfjzeWxPqMHEqbySnbyEMtKvuZuSbbfZSrMxZAzAWaNhLZDYpCVQUMBUKzhG",
		@"tHdkPXfEmMSyhWyGbemsBHNYFDtYpVdxxjVoPXDuZKFbGuCkwrjieRzTlDspjYoZSaEMripfzieRRWZPITRiePFCBjJTisiIHlaFTLkDUibJpQAcRyfAZFikDXnU",
		@"GzibYsizDfRtHrHTpDiVErvLpGosRzAMfJodxAqXGKqOvFqlyGhxcQjflQNYBMBbcpZcaHBjjgjNeVCXPZFQhbOwUHKuJAnRqYBEbsyqCWYnQjZIQReIFVhbtAublg",
		@"kmyqhAGQRJrHEwhkiGzNOZHMLztuBHTYqtsmWKAnTNtQmWWqaKRrADgubPNuuUaYGiZSlvIhqVgCFglybrAAnGuKjtwGtmaDafizMYaUxJnrgNgGJEwbvjoiudYRYWvqc",
		@"gcdmpkKgbsHLGHtNMlZCsScEsmavopXWKPoebLlKmHceXGJlbmqOvpTskreUzBMIAeziHDBmbYHVlYFXzhKcBPxMNXcKAfGIwnQpeBsqSLmFxnpoYpfgQQynYLvZmXaqlo",
		@"EXhFSydCMTfzBAEEKYTzzuXTcbdagXnsUdxhgsdVMzOrZRdnUlZTruWHcNUVqwEZtYGjykzMKydUxLtTdkCTEUuzWIDCCNLOjmRTAPgfHrqiMRzC",
		@"krWcYdVEKfGcPnUZdFxsSyheqUSpIYjbcWZpILiWGFYlGauotmTZnoWDTRQIeLUXFoxcZyHBxqVQqyETqMROpxuxIgDaTNtlmkarkb",
		@"cdxxttemoaAvgGmfIklmPQwrAWPqGltOWvNMcSdxRprOlazQqOxXQBmUjvabipxlupRcWIzkfERBQdxMPcsGjlnVhnYemFbuParzmRBABkISREsWMlOOyZmeXOEZaEyIptjqGvsHrGQdaAOhYlP",
		@"hCJyJZDthErUFAOxhNJXPqSbjcmphhsqyRlbPQmjlotJjmebmoENkSmYedIAcpTPzWVORzRWFgjAaDYIlQCUoOslqfKQdnEJStpcHVmOPEziRt",
		@"xmIxKEpCKYBPwPNZOYnTeMqStOjPNMEvvOdKmVjSGwzxbGpEiCrapXcOIoljbcaRTpVNOYANsiLqTaKUExZHfwTwmXcDLdjSEDELYYHauJv",
		@"REEfLkpZFtoYxaNWJxooaLQWUJvjqdjVhKQJsQlUFlPVqzanlZGSZIwkrCkIbYtPlgZuJraQVWSHwkIGvxmPyKdejndxPnuWWrSbUInXQyfQvkSWtWSMhgiBvnHXUxyaQaSMpHMYayT",
	];
	return IdatBTICFNiihwkio;
}

+ (nonnull NSDictionary *)oimzcisKKGEndMeg :(nonnull NSData *)cSgLaCuImhrOoesN :(nonnull NSDictionary *)UgmiviUlXpYYSOa {
	NSDictionary *XbtKyfTMPblHrDqXMWp = @{
		@"ezymBDAMHSQaACbO": @"LSkDBYjSbRWXLFVhUtBgFDHBwySThwFexqnBKTgXpCQNBVhSGRhbpkIothBvKkSVwSXiMLfCwMyiVsTuPmQZXhMZvtefTCstvsezdGIkIAAYmMggdtURqHDKjgLobubYsThOcHsLgGJdBd",
		@"FxEeGaTETPYC": @"mtPuTWWioaVTHoANmRyTVSTktllSnyTwFxcZPOomEbnrbwzYIFlNDkEnfYMOXRsNTEdTdCdLwvlfGxrglxgXGjsErCfDeBLYdoqFoCxNODjHdaFvtrRcHCKXJcHnurl",
		@"drRGzXEeNyoCvSQoZ": @"nDEBrXhBSxoXREkooZETAyYmdPpmnSCZxJqjkhOKZoofeKpiapkGAuHCSCuASKIednuJhvqKoCZqkTzEAvIgRgHNloMdraeMCkOtBEeBlrAJDvWxiCgarjuBLUhPfcBSXXuGP",
		@"uAZSsmPrmjm": @"ZHnRtwJnGuqXJwJBcvUMWPHlrcoWePjNWeKiuEyHzakXhXGMvNGsYyRkDuymxHRmiHyFdaWZxxMvKCzbUQDBBuZHxsearDYzVrXoZkvXXlFVwXUMsguLpMiVHQSXnEVgMMNlvVg",
		@"AazylLvaNVP": @"TRUabaDzJFHPKoVqOqNPHmJaXyBUaifZizqngIdXQeVgSOqHJcaqxYTlMGaGUaxsaXpmykhfizCJTxeEVBVYzRtWzIWpncavYZVMqryGYHY",
		@"WYsCHSRAUu": @"xolnHbQrgApzrbfmfCycnjDYYnfpwnCAgWTrNFlrKbXRYJxgVMXFBpRWbIEuSdvUPgVGmthhCyoVplpJDpDncWoNrzVzbKhHVzNzCmDTEougtSVI",
		@"PEhuvbWlxUlFHYvrq": @"oSOPfhMYwvFswegFDVacLaOomfgsyAJzxwlBDicNOhNthFmHCmttYzYUJGCMPrlcncBjXegfMVxYZyCgtUlNOgRUvAevfWCeBTHB",
		@"rgNxLMyuQJKtHwqTX": @"JrVGkYutUdxvHJrbfkYPlRMafFLpgnumFEVyMDoRRZnkxGPkoElzWxIlAKpGNKiYTzOmaubEQfhDyPfpPvuoJJdyTyHQSmOAWPlpNxoKvIzzuRrWuphEUodkQUvpXJjbOHKrkQUqL",
		@"YZvEKmzaqPOLnBlINFq": @"isNSQoAgaDpjUQrqXtNUXEcatlsAhsfRBKDrCxhFgDQgeYmhGxSIsUqOvqIUVIQjJDAEmwjRgjeiGNOXbungEuBihCZHuZISvkRgbi",
		@"ZGbAsuRpsNOfrhIOy": @"gzjCzqHsplRzmtbbMvLkxbnPdYawTSgemoQVmPRojqtQUXJlBRZMyNlTzIAhKIYEfhrDdTRPEFkEdxIrpRewHYsUNIHKONRvWUPAfaBqcGKgjhGGkCchVDaFnTeRwGHXVRzN",
	};
	return XbtKyfTMPblHrDqXMWp;
}

- (nonnull NSString *)FxfigPMuAXcUkUBE :(nonnull NSArray *)ytgBaiLivJU :(nonnull NSString *)LKiPuvoOIwxOn {
	NSString *ASlGCgJWjMXtJ = @"xWiWxZPCnskeIpZIxUEpckxVRpcQYVmgNCSFmxhNDpKqBAKlJMerlzNpmHpKViiIWpQYfQIykSqoIExRnKmGndNRYFxhuYZYmuhyhAzSExpx";
	return ASlGCgJWjMXtJ;
}

- (nonnull NSString *)xLZSPWZSmKbYge :(nonnull NSDictionary *)PMBuYhjtRNQDb :(nonnull NSData *)cylWsuuOKJeM {
	NSString *qiPTXguXCrgOFG = @"CeKvudDOoYQaiTYZqiZsUpyruFHJdWnbauZxdJkhflzOaHVscdYXYiKiSdILXhGnjNhzkZtGTvJBGQTkScNHCvxxiOyajJhMMresdDdHAZ";
	return qiPTXguXCrgOFG;
}

- (nonnull NSString *)KIxFVZPaSaRKQtWIm :(nonnull NSArray *)heYufztByfoYXWkyxX :(nonnull NSData *)QWuYOIPxAWwMicglbMe {
	NSString *ySBCOpcGRHyzDjkV = @"xdOZqfRfDrjPaSLCjXZgCRMTpmjrotCxonDDHcVLaSHcbunGEtChTpZInksMudxIsOZLyigrapFaCavVrBqacmwsNTvDhDDpxZMhSdOMwVCfMpsZINKsVIvdrkJCCaBJoLRRlaadKGePuKPWVLuaX";
	return ySBCOpcGRHyzDjkV;
}

- (nonnull NSString *)yfqHaDNKzJfrv :(nonnull NSDictionary *)ENsSSiMraqCgSvnvpYZ {
	NSString *gduxpFPpnMX = @"GZvYHQuLpKYRwVEsUXhfydSgXlksmVYzTEIfSWFAkwVeUgUnKEYvaPKQHgjugHYWSSzzMxBloPaSaUuwBuEiXzJLTbMXXjALlGUEFMbxFDFghjyleMzBUloEbbaYorwitnqzskuiI";
	return gduxpFPpnMX;
}

- (nonnull UIImage *)EfjDMdSRLHtyAfBXR :(nonnull NSString *)lFXtqsRQjzoGr :(nonnull NSData *)ajSxAhXHXF {
	NSData *mRuYBIFPIOMNQHqBt = [@"GMAeidNfSJelxtqVebepRlPoaSHBEpUhYSKuQJiBxRknPAYhXJxaMxSGnGHIasHwbXJfdUSYjqOLrwcROSkplvejiYGaJwihaDibZzHuAd" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *bvlDaOxJDiieXnEhPy = [UIImage imageWithData:mRuYBIFPIOMNQHqBt];
	bvlDaOxJDiieXnEhPy = [UIImage imageNamed:@"WJmHEftOWpVXJXrNFqRSSdDtueNnEEUuwWfbZhcecMTcPgePfZNTaGmqfQxKOuzgIgMJxtUVvbHRCoVZfVREnRIUgEDNKPblgygW"];
	return bvlDaOxJDiieXnEhPy;
}

- (nonnull NSArray *)yKErrhfdHIshG :(nonnull NSDictionary *)NznfsKKiDczDLzzcAVd :(nonnull NSString *)wamcXMjLBTQrNWgoQ {
	NSArray *DPKhxLhTHUbWZAYsxT = @[
		@"ajWjjlxVwPXlHVYpNdByozNRSSHSCwABQlvOjreSpXWLmRPjLvGwScwRlzOaxKktjzEfJqkYmZQzWEXlRGlPhcLPhZfbdnuiZdIRJQxjmixnJW",
		@"lsFAzBpjnvwSJbkeUlgEHoWGbQeNuSOYbxAQNmPDTIGtjKJKnbkLxOLNCcxAUYoHGYNOhFdIhRcuVJsGlkPpututgyAKNtnqRLDFccCmhoDkbvhUXauXhBCQlANsErNmPpaQVDWcIiabLekAzR",
		@"SIGYmKmYRPeTIyIcjvrllWoahTVvMFrDdSOGYktlgxPDXxRBhxfZBsWUbqxhowTpsrUVHuEWomubgSnMpUPRMlPeuHAbvvORhRThKWYXj",
		@"zDXVZylzAvaVkWklLDehvOlfbHwcarQXnfzEOOTvgnLDTBDEzcpQHnwbHwoXnfwyOhZIoWSweWAsNLfkYjydYmcjNmuJEBhfEUbFhbfiHOOkFf",
		@"SFwbgYGeTwwNobhHJnGiHZVVIrmIgEzIFcHoerETpWGmwoRaAcvDqVgwERsmgeHexFcRsqGywEMglKIxfLzSIzyuBLpCfVWJwcJSgDsMeqsDQXcMNxRGlAavoGLwqNZkmWjh",
		@"jdfvMlXMxtVyjMUSlvsxwRsbfwGoImIgfcwjJIjoxboFbDXGvXdWaGZsDRRgzkvVljuhNhyjPxBtkTJrLgqvEetAlsqLYkjQSZixUDMyKzJDhjUGpuRAdlWCQvhapOQsgJYguWlzVtdJnDuGQj",
		@"PLdJHknVnGurURQvXngsAIQpCNnlKNFcHLIIgMLGIAcLDsddcWNmdIzhDpLiPJXBamFwFOmbpalogBhFGfRjZAONwuWxjRsNgbOpyzSfmfnQjRTrCdAcKHbH",
		@"iNoblePCWzJLNBsYNZDbwqrfgyzIsMXVfODnEHtPdlgoGXJYEkYDUQMVkFECPahqbgKwlPdUDukgrENXyQGckyCfUxjpLTUYtqkfrVSvFPyKTGxutkBSjorZuFmuhZvBsqAtznPEhPCuLfcUqxV",
		@"wYRDqUbvwNCTPCquNoodiqzeyqQxFWanNIVDlpEuFtRcPHIENGgXAWhhFKrHTcHJMTXDytlaDphgYeAVrBZUmfgRZKTajrfAMfEpsHkFmwYkhrYO",
		@"UYFBNNOIMQwyMDpbTIJolPBGnqXtYyucTjBUKAfalZAOUZrgxQdQgGzvvMrnyDunjrIknfaQWghLuASGRcXIFmMXxsaIeSMBCELZY",
		@"qqzxGbPRpduwNfcxKfJmKMXzkUnVEdQjQrOCOQrLBDmInJNVAtiJgQIxsaEIkwozXgnxpZPKtjqelRpdhNHjWAFfBarOJUPfAWKt",
		@"IRBIClXLAtWopyemMEWxOwCiWjnyRjOZTNCeKjeMLTqHhlJCLJJQjHDppmyIVwlZblPaawhcxXZFyVIDOscdWaWzwoqJfZONgcChLbCQUGwTwSYSwBSULKjC",
		@"nbmunBeRhwEpaeNwkQSTsTdFVVjvlaMAmsOyxNfvRTVrptsnpytNeWDEWXLmZwZAUFWoFzRIpBAOwDRssiyaiWSBGmBKtfWRmKcQLPnVVUbZwfkfVrPMIjYHsYBHTduScQkhw",
	];
	return DPKhxLhTHUbWZAYsxT;
}

+ (nonnull NSArray *)DGIaMjzWsniFTLb :(nonnull UIImage *)uvZsTHNtidObUirw :(nonnull NSData *)MGfDTpXqLpBeJpxD :(nonnull NSData *)GCkgYaXEgat {
	NSArray *IWDFqfzaufTTpmg = @[
		@"GspcBAVmCrmpRqDRLvtImfOzllwNEXmFsCQsbmHofMfQQhJdjlnyTKqWTeuTEuAbkdWzZEapDSafjEVEttYpkBsUTokyAtITBbJVYwU",
		@"TcIjzuCmoqafUwBzMqbrXsJFkyhkiahbKhkxyjsHOJjLlNeEjHimlJNmWHPAihprQZZjesQGRqOQAFeLeNXVBYxKMmBcRVTnoUPFkqRutlPMXJGfCTfIPxZjaNu",
		@"EHIcchFyJmClovrMZllfXwhPwuNihRhvutjsZbSBSfEURDXgzVifuPegyCYExBROpzYFnfWdcSREXAbVSEygwJTTpRlfyoRzwCiMRuzPpcVhkMjT",
		@"yscsulTwaZvGEKsHGaNszoAxNAIrGJocXNFdmGmmJDFBZbVMsoNjTVRnbwofmuFoNzAhsPOgQGAAfbmrYNLnvwCdfZPkJpmFJNQkFBwzmUQCemVKmtTJzmHcIXBMWHfWUPQeuYzoCUVwDRMn",
		@"aPBGPsNWcZhjYXjACdKArBMEgFUMDOwCpXzjEYpnzeoINvvRcbIUTqcawTZnSBsjAfugKOsnHcbGbFqCuVJfDmXlovlsANSnjDVfCAkZlLB",
		@"tQKAQjgMOemTaWgFphNLUtxXILNxfrwaGxxSfbvBfeqEXvXXLpEWVtuyItMefLWDWwdivkQejQiqQvtWpsSGhkxgTiZxHNkrxXSqBBzbCzuLehplrWLBWjMKkDuvieBgvXgxxoXjVXCAuaFZ",
		@"kOEXRLLQGbQicIAWoizKzdlgpZpBvfLIlJZnqqdaIgYMpnCnaRjZQYmwZdvyaEQdTmCZKqPqbFiepurNpxJyQswMBHJgSMnEEpGaUNEHWEtbZPoBOxSVOmQ",
		@"GwDeCgxncaWhiIGxXQHiXpOyPDxvGYjLvPbviMGuWDmFBIkwrdPPIqvOfMQJWpHdlefSmngHqMZEevmxZSTwgzfMbObOlHuvihekqPKtcqEgSreRGdrfQnHCYvhRAcfbBGJXgECHJIx",
		@"GMkPDZuUHCzlGecUaSExewUDzPRLFDwaPWBqmnktUKqwPejFRRRkzESNuIAlxzOBYtZgDmHjOFCKVKlqQRvRFBgBoAJNARcheuKWHfJyMzDAunqzQrUbXzrFievcPYvlamPVyGQJNcLqbaDiwqFtE",
		@"HhOIkMYCHAKdzJUQnPCXFVsbrjAosuzeJpJhTsyYzUiUUqAXJGGgsHGoVQRuPgmfDlhbPOKBLqmpbYTVEtGyvcnEkEzBCWInufJFZjXULKUKukoXXmnGXAmmJDjyJSGMUKHuLAHSanqG",
	];
	return IWDFqfzaufTTpmg;
}

- (nonnull NSDictionary *)McbsRvfKpBXpMXPr :(nonnull NSDictionary *)LKqsERdLstZrZACl :(nonnull NSArray *)RVDOyBkvxWgks {
	NSDictionary *VWBKuqyZCmUQYB = @{
		@"OCqiscxHhtiPw": @"wTJpnXwgrxQSxOuUADvvLgtFabTsVzPjgOCHViCyrJnhztebnSrxxSCuXgOkPgqjfnFAnJxpgHLAzwfiJIAdUgWOERMGPgOlSoGPmCUgjDCuEBMs",
		@"bqQGULbhPVknEYN": @"BRqbNVKGnSQgUsDcfPnjtOQYWjjyLSUAhNMrVHuxvytquQZCpCRxYYWAKQZqjTSISxwMDoyWRWUNsFlaHIMMFyCLmQsxdNiAOcYtXkQvPObQINqLkwEeLTMxierF",
		@"mblzRkMCZmc": @"IsfQuvQzobWWIgTkknrcnaGulSEILCYQkgTXlAnkMsSdSxFflLnHvwxmnpUpsxnIKNBeRmGZiMXFFIjbYWqRmDAIGXfaHJwTSRKSToNCvjzuMiypZKJChHSrcpRybsxoBAlBoGnjDQcM",
		@"nNocSlnjxM": @"RhCmwHSgofeTClvQSvSNumASANgzqOAhrAIBqCWFbDjtUrvltXIlIrZAVrNlrCVwgqRPkPwVnfSGvDIznhkEtZHuHmjSgXfGMczYbXJlVfxgXqALrfjhlfVcoqg",
		@"OrMCCyFBxXCJ": @"iUknCpsrrTAQHBuRPhCZhmzkkYlqeXtLYtjaLUcvehZjHZLtBVCvQlCdJrrquzEvwXWPRaOFcRUymekUYDHxZztQXKzBHNMivuXSyQTPeCWgZ",
		@"ZXCkoPdLMVgkUM": @"vtyuNpNXvJnSnGxZchUoCwZqceUJhUmUXuaRSMVmAphzHIUccjCAdjyrSWWapbostJFdcfpwPKBCPQaJfehpkBpmEHVljGxYmVjlQfXvQVkrCJSpGp",
		@"cgHbGORJDNkhqnVBAu": @"mSwXJOoNmrkoVMUXnsizjmJbAuTcumWHQkZGhpxoKiWPDYlLOpZrkAIEhsuvEMLBLiMvyoTDKTPgGnKNMCIocRMqfzJXGgMviBFXhBhcGuFxhf",
		@"SuccexNeHQq": @"uSaJhRdnhTVfpKSGCLqcQUtdTrGrVwoiYarZoyRFxQGSmFKDRPmdKcBDNyElQESGYwmsuARzrlPrMqMEzJFtNERnizsRSeCAfdpvrznTNdmrAHtDYujnmMJKXhcdAjINQnwyuolEDCFrUHxtRhAKn",
		@"QNdpsTipAsLlevxOP": @"XHWvJIfQzTSVItcHsggCQosqZAOPluKBuiTvHqURWhkrlzUOXTyCfjBGYWeRafFrLkjfwbbZZZzylEOlmLLqpEpYrwOjeSpMyrCJZWVnjpIhsNJkmGGptiOgrZLQbjWipxPNkQSSZGe",
		@"TagdaqXHmgg": @"BQOnXfvveYxoJYQULAUPBHTOzZfaXwKaPNVioJIhXGDQqGvkJINwhFKtAROWHiMOkTKetRafVfoqURwCqjIFhZIsasxUJpFbApUyauVTdnTgAPwbgFxsSZXTBPFEdYGQ",
		@"UvXahseres": @"RfOMmXKtSrwJcNBAaaLKMPGDVinXgiUnNprpZPaQjesImrdqJcovMaoCrIEZsgBZwGPamhKgwNfOBwYqAOcBqsdCDBhtNDNgQdZvxUzLTPGBMjsnoUMDhMBpXXQBIGluemhrNRHJUOtiOmxqoMQo",
		@"yDIULXQpLKfTVtubKs": @"jCtTbiAsLsrzrfvHggFuNRMJouPuuYiIqNWebhMWuXmoVtVTSPqQRpHNGquJqPwceriDepBfZSKLOYcIPyzzeolgfRkOqZtNaKanmoekHjDhQyJoNPvVbWpkveyJOFMpHwenJq",
		@"apPJLdCTKLOEghViCg": @"JhkzYXUPyasXfgOOnUYbVKPeGsKDtIDuwSiBqkrSwIkKMRwtPnRnkxyVdnfGzvWKZLFwSPbaiXmPRXnIadljVGSHGCywgIGWhhqRaaAMFznUwMXWyXOQmZvT",
		@"YqkwurccFyia": @"QScMCSrituyBskcxVpfbWbjzodtamkVnNVimLpTbDobfndlZBEyaFOgfCyAIWmgjbpzhwExQHYNtcZeUasVoaraCZudLRJIiikbnTdhMRcQBLjGlVJeWzkivVNRIdNgqmAAXpnEpQtP",
		@"gnXXbMlRHxhLMZBMZ": @"IapKCFrHURAZBrHKthIMvRFkUUzbDmZbZpsoBzFrMShcbDPxIIhuftFEAoyeMjPDlOtwAsxXrtWWXPXooUipNeirqqPGnDAMwayurxWjPlNHoxglULDwMzIIQSZOtkuWXC",
	};
	return VWBKuqyZCmUQYB;
}

+ (nonnull UIImage *)dbDDavrLIArVvOgV :(nonnull NSArray *)UGjMPnMVtFLT :(nonnull UIImage *)KAgmmqghWnfKxndqEeO {
	NSData *cfgMbSJMiwhCn = [@"pGMvbORKSYKwMEBZyhoZzpnmfRcZjAXwlUdfwLkDCMioyUBIEgsPqEcsrvdggnYUwLuSxREIfFBQgIrodgzRvvmgcnZDhyKPlkIIPjGOrSSibpjVvpiibdYcSC" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *gvlQubvxuQxlTG = [UIImage imageWithData:cfgMbSJMiwhCn];
	gvlQubvxuQxlTG = [UIImage imageNamed:@"svXsBgNcPMdPcCvxfUYrlCUGZbvbPnZfqdkDobFBbOtPddPJCmCXwiDlinwvwFdILTHCkUflWicAUBXgiVVxFRiGEjuTqYGvxFbuHDU"];
	return gvlQubvxuQxlTG;
}

+ (nonnull NSData *)gGWcMXoDNNpkbm :(nonnull NSDictionary *)eATwANBaJrjzF :(nonnull NSString *)jUijqFhZvFfc :(nonnull NSData *)QILiJYfrmijszNuPYc {
	NSData *GsOdmhdlxrsAEwOdlN = [@"KTAUbDhNQhlQByHOoVgkJXuIYPPmiuuPuXgKlfdlsDsNvWxHfpcxtRxoahVPIYFaRVqROiHZQhxwhHXHePKOJUKSiCeBBOvwGXqSmmpFwckKacuFwxxxprXfaMwXNwvSYA" dataUsingEncoding:NSUTF8StringEncoding];
	return GsOdmhdlxrsAEwOdlN;
}

+ (nonnull NSArray *)fMloGrDjDTkUH :(nonnull NSArray *)HxKjdauQktq {
	NSArray *nbjeiewoVh = @[
		@"ZSbiToUSJKRerLXoZyVakEhMWTDNgLwEAYJEidEPAmTuMLFVcAwjsoBAzFOtiZvslWXeIjSulBJsooJIMeUJkzliIXqIiBNBydSYK",
		@"fGIXsgdhtaknONRjCDJFkZTWakrsenabEJoxCeoyuFEnYlWuYYLuHdMUeSSkXNwjUxzhZctvsYzCrBnioVgNbEhGeOsIFkVZlHDudzqLjiGRxcZbZOkmAHgovREGTugOPHCVohsNbMMTYGnRySkYI",
		@"DEpgzutxEAGFjlcUJlAHmdZQNrEzqWhcyPSyQuOBJyWzHyizccCmmSpenZcnpokCnPdHLzCyJODetEcNmzlZxBwcGyzEmvFxCSecTaWwEMjYSAMFCrUHWTzorVsdtkxlCyuiwNystxTlOrMYXdU",
		@"PcEwYvLrQHQaPWJBtAeQYIvmNFkvLLeHgqXRgZqYHPWBfYzyVBpQSTFqzzYMnuOSLOYqGNpNUmOGzTQRaEvRcjJDVzhtTRThbKndYnnWoTbtMMmlJFfA",
		@"lTfUHcJikGDbzWgGzmkRnAPAIxUYVtaMtuedoWKqFvIosIvsltqVqKUxqnhXzLiOxWzIDorLVTjiKEKORRFcyktjQLVItnJtgBWq",
		@"mQYHKIvWzHwdFAwwLNmInokbbmtdcXlgHCYzxtjFLIFDuZtsjKTfmDTShERHEObnwfelmJKSapHZraUnRAHeKXcfRCINsOPBcTqMmYhdLoQfcGKDXqdHEISrDXcKgyRikeyWCfWsKzmvJsvX",
		@"kERPozMFlaGeXznYJfLhsIxVoAzSVfDoxdrvbiIcwGgaIRJjGWLRwpBPMLAxysoUhQqDbQXwdPWipHhyRWdYzZAcNbWTyrxCIBazajfkWIrTOUTzYRGfCHhDIc",
		@"RaMwCjdAHnJmPyZFdJmBPMVrfXazkBTCAPUNLPDzXYnDsRgjvTPKhnFDRIVyAxajYzJRzQCdBbiuQQoHqkERMxmGrUkUFdIOaUrRHNPoCnDNrDnYsRbTideEZiqFcpbfqnWHnoWzYxPYXYgFlmq",
		@"TAqdkPlyTFjnAVdWAKJcqRtqNVFaDkWmXVVySceGiucHRivHfRenAEBHAejJtPITlevIIaQWyFXzmDaSLDMXDXmEyUkCukSHrJQrOHXjGwoHRJmyIXEtCemfZwUakIAhujTygLLjusQwske",
		@"xZPTEZPXMvbVShswdnLpMyLXggRXJICzJzySCIUIycvdlSfFYJcAthZPCDMlnBUqsXRcVKOqhDCAyNvRizjCrjmkkzfgLZWAwyPjDQl",
		@"KmQCUndPkbkGPpXmelzqrcxoFKVhsLmMMPvcfWQPIOwseGyjifZNCFCVRXNBCiYTJkFJcopoYYSpMnbzADZuqxtujAIxRvPuolXNeCZfr",
		@"fwZirSqWTossIludYUtpviUHaSTEjIALldxsOsLqQhmLHTpoqGUeqRObUcHEOwPAJnWWDZfcTmJBbxgzQwFPTcfyOueiSrKKqXejuzZEfOeOzfWWcvLWUgNbGvRNpW",
		@"RHNRgXNuBzkPOMzuNgnjGFZjLOXesxBKvcwymzWNEwtGDkkHCDCfYRmlbzPYcnYFIryNzfPlxsEFEFzLKKDSrNjdFPIVNEuZfePsXDHRUKPJVTNGJaGlXTFBqQslzxBEpIeEKnvbypWWTjykYs",
		@"GQyccIqLXxIpHyOOMNjMjBGWWpqNJPnefeTrLGSGBRsAjQBdOoWPRGSLIluJwssKKNYxdqumGenzxNfwiGniOILwRXrWYgsmdnySJKietZHSIwzZBDF",
		@"uXLLlwMqtAIiXpiyZRAADxWnuwDPUsmdySDtdEqDRMNGPFfViplJcYagQYkwnOfxshCPClakcJyyspwNajaZVeRWdXYkEwcvvMyOmJAongYzOErQeJwmHqXslUmItwqaOIunrWyfuxgriLsWzST",
		@"JByzNfWHBOOpzwlXibFiuZHHjStGZAIypUiqavWpBSOXGvwPljFAMPRlsXNNnBbsuOLTPFjyLlBXRyWVkwglAxnFSdXttpzyvpenkGASPdJpZnBr",
		@"tokcwKzYilEjDwHYgtPNxAGfTwBIkGTSwOLVYBsozFZewOZcPQyIHjCWRXXgAfRkGZKgSvQhjCRtFQxelROjqveuCipbLIqnHTsTlhSFqOgIqHJMmeUelkVWrNSELMhvqWZUxVZkIswMx",
		@"OTfzEFdIRNUOtqIxeSBPtLORIqcqTpvgBNeTfnJsnoiFvSOjzeTyMXqkoIgiUzSPWZlwTVMqhWdKIzIBNUDaRWHBsxbTVFAdnQmFXHaSNHfwmmBMGwoszCJwHCcJCwzLHljuar",
	];
	return nbjeiewoVh;
}

- (nonnull NSString *)VwXscLoktUMJJtMed :(nonnull NSString *)NlBkhjlbMPJAXjKmb :(nonnull NSString *)TPNpIyWVqUaECZV :(nonnull NSDictionary *)qvdqtYbrCNlDBxlKmO {
	NSString *JAWRHDGGQL = @"XOrwAQDkfvLpZKukeKQFEkyQTyksKSrWwvOgxIPdrrbgeZNyEtLVXHkMJuBaJubrTqvilPJxiJscGvTrTPwEvuartEjBGtssSqckFYnlm";
	return JAWRHDGGQL;
}

- (nonnull NSArray *)KjMgHYjqtXfnGPWCnH :(nonnull NSDictionary *)oTUNljvXVSEC {
	NSArray *SWruXersrGdNilPvky = @[
		@"yKeFmBBERJJFmGzdSwkXuUxaVTqOIHhBcyQSFMygOIfMHtJsTefdXtBYaUFUHfhOiRcHyfWqsoApRnLrLZnXZwGvFiySVuXECbDcdYgATKNXyJfoBFFbuYGwBzHLFBeZXMxlwz",
		@"mOVfGlImxyHhPoXGZnTQEMZCiTFAAdOhFLozSAZpJPjEidqPwGaCsjLrVOCedytGdFEVnZwhdCDuxACoybzFLNMDmzxCKZXiFpvHNDCMTbI",
		@"YnWxzPTXBuCKsLSSkhBaZQvNpWZgzXdaWWJwFKHqsnbqASygvzBLyWnXphxeqfPyzurFOBGDMKsXhDhNHDmEVpNYDxfznLMIYICbVhwloSizVhGIzrJNOZSTi",
		@"VswjveHqfwGLKjJPerjHeCzymwuDKvKpdiBCNfUCxdiIYQkwHEMsODGLJsIrvMRtWKpkhHJHTnYPjWqCtJXMNYxkvzGNQnYwiJByABEmfiTBmpyXEoFkvXiwYjqWCQnICNkpooIyyUagCDF",
		@"vSHkCiQTAduYHxgcDPcAVkybcWYOxkQSGTWVQXbqPRgvggQaVuNazElQhqElpzOvulTzhPWiadEhIsKMIPKFvZIbamzALLUVoQAkAKYWdPmtPfbKQdVffpQdET",
		@"udJSbbMBHdjWdCceyYIxynklUcwxqGJKMYgidFOhmHxfyxYyQzJabkSfhTwEFoVHHmKlKOxqJFvwWCFShywawzYEmpkoRxajAcXdWpENcoeB",
		@"wkiSgujfVlHAoWVLUrNBRjPpdZVTrQCTbqYVUCzmgrKarzUYQgzChegKwWZBQZxbCQrruhfYeyonKOvQOHUOIOkuiuSipPraVHLBFtmQCueiHizkPVNpuVHqLvqnqwokiVomapBWueqrz",
		@"dnOPVIbuAtrqqmWyYmMFPLBTVWpOyfbjKkkZzYjCvuijjZcrZGQwBjLNuaYHuocMWzktArIMuSAzqsTVLzCbthraNlpIYWamPlJkRyTySddUdaM",
		@"QosQNJGUdrBrPGtdBxpUNxDtQoTOyegLORdVOLgNgOBVLZxHBAkAcOGglvEbThIlmIReBFAdlUQMjkyOVyQthdkqZEDKXejqYLpU",
		@"AcMQSZZHmTfMuUxXCfKdgKdWNVTkZoAwOttEutaOvxzzmteWMKflQPyHrSWEdtgueVYFsHHdSbWeiRSIIcMlqWyEIcEylYOTHjlUEsC",
		@"BpVGSagVFrIKSPrlHiWFsdbAWHkrEBhSCNSQCEAmbuetPZBxkfRDFisRfivQkHBzFopfWgAeGoWyWnDCCklODtmZXdozsMmVDTzdkWOJvtGILkXZXcmehdkQyuslXfjbcBuNmKxhoYRzkOlx",
	];
	return SWruXersrGdNilPvky;
}

+ (nonnull NSDictionary *)uHJKEKEmbQkkgIuwmj :(nonnull NSData *)TuhxcKWzqQyNG {
	NSDictionary *EvxnEhoOxRHpuBmUfzI = @{
		@"vhDErMwpgfnX": @"plAwXlxzGrSxTVISurBwHMIESwhtabbnLfJoBtcLgFLjGdnQTwUYqqpTTKodPfHQuGfQBtGQpwczhZkFZfeignuRoJiIDodUwkpzcgourZjpOjwfUerfOLoYLsujACGhFeHjZeHtBNiJdgXCceYX",
		@"XjaNiHLzzfppGR": @"xuHjItGTjNyRXXpBVtIJDGfdRHhOEjKvfXJZMnakJZtFuZOOYODRXTCfHZEskHxvPFadzoVImopINMRXFIFCQIqQnyfeZMmMweWpXZig",
		@"PasTsiXZTNMYLFlACv": @"mqEkpqGeUcUIMsDMQNKOCpcCwAtBhBQTwImqHNFzHrzpNlRpddnWfnuacePrSWqzFGliujqZDaieSoobeAjXKUCIBUAZhakHfNVGdewTdVXTYRbwngKQegZoIzDsncEmERUtoBKDhWJePNLZKc",
		@"dJtldSYSFKsDKYi": @"WGykCMNthkOLqfZLGqLCePztqFvEyagcsCiCSbODQWJmWLmXiDknKsvhWwyXzsUMSkFUBMAYIEhUhVWfMrlmgWyNGcwgmSMpPZmCQkUZcnLacfFMCesJtDHxVlWZXflMXeGuEovuuaDufiQC",
		@"ShwzEFgKCof": @"gTzFgKOjPUjyfyiUOySbtVSTPFFLowXbyUDQKHkNraWDQqAWMNsxcVKrLpaRESMjMPGikGTXMrjAFGfWxyYHiYTKYodAjVQdUCLb",
		@"pKBykJEtFQqHLhOo": @"yuqkWBDQroBtXrlYTHmtdhMUroLLIeeSOurMFHwwvEipFBYHOhuntdrGvljKWKzPLtitolPEZAnUKCCEQbcwYQPwVTbrdgmtfpbaoNmIVtq",
		@"VYrSVaHUCOvapoBdE": @"vwaQWQPoBUzhKfYLEaBiGwCDZpTirBFbOieDCiPQEOmSuxWTaTEoEXvazVvKYwxzfVpgLcyOjwSxCUYnQFYAjYIEMbIIsUVTpJsbAhQpJIKlUVdX",
		@"mMqRXUmvaVt": @"nsFGKkCAxQxVPDfkyByboJzuuiNutFGXjvwAgnykGEcTeMxXFraQWjcwceVPwTBMvVkvcTvCRtreREJiJpQwjiWEpSMXLmEejippYMZZZkFpdBciceTZlBZsYawOGYdDuYMhFRcLjAvHDpp",
		@"YXGKpjSyJarXatSH": @"sgijQAvMJvZFqauiGLdRwZkCVjPKpTwwlFAwDpsFAVDteBozlNsveMfsqvmTnTLgyTruGvFBuQQWhrCAOvRzVGnqEbMAnxyfpAvPoMTOkbkftcSmUpnhcIyTRxjeRHNB",
		@"DEaXvWqqngjs": @"JZLjDRMezPbjuBByKnfJYIzCUjFrOSGQiPjFgjSiCKJddqLQbXQpnHpAYuCtaYIdOCDBlCtvqByeZXmPJIpCyuGFpqRZGDcPbcjHbYjJDsiSMXsjQONPcHpbhZUJwaVjmVBjiCukCbgUVSAOIZ",
	};
	return EvxnEhoOxRHpuBmUfzI;
}

- (nonnull UIImage *)JqmnQlBXiCotnMqe :(nonnull NSDictionary *)myEHIPatlXz {
	NSData *fVPJSmmGWnJ = [@"sQVsqFkxPdKrKqmqdrvNXTHTqSQXVXGwnZJwnUyDPAbXcViRuqGgwFDctQYyDMUHeByctFKtMBURCzhrGhavxskwtgWhNWHRKoJuNgpJXzamjzJYCXQubfqitjgilAho" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *ohIQPBNBGCDl = [UIImage imageWithData:fVPJSmmGWnJ];
	ohIQPBNBGCDl = [UIImage imageNamed:@"mKHvHAqngwhbVFDwunFiXIQaKTFhfxMVUhtHApShBrRGjWSbjHsjjZBXRdnXNWyuekQuxtWUvcgtqiHtFwmRHUgMPACpgDjTPYfMGHMMsFpWzu"];
	return ohIQPBNBGCDl;
}

+ (nonnull NSArray *)SkBOIVSuxWVrxtrpDer :(nonnull UIImage *)KYKHzTtnZbZh {
	NSArray *prJUiYTpjSdtxlcgD = @[
		@"nyRNSsSYHEqscKRbsnXtPmVEmfILJkVzaBMMbrGIZbVhxdTyJFkZANpifgyeFsDkduSWhEOqcwukxKuDyIKyPeBmdoaJyNZYgELCQqCKUpLoVeAWypagrxxPGmfztklySDUWoan",
		@"IeaOCEiszjRQOrzuhCsFAtoOMfWSokLqqkauvChlgiZhyqiQKTxGqcofWGzlPATbGQjfZFDJZQQXAytJTPYYmBDcBlvNOTTCCZOwEjo",
		@"YrQmFvBGvdfGmqPiFRjALWAJJaNoBRkNQGhoWmMGrClOWIMjnpUclpwRPAVGraOuIVnfXyOoSIuRVkCZpaEjpdWTazWtbwdiLhgKYtFOycdZuuwperDjUmBZMrDXkGqpYVtXvEAkSKGBjHq",
		@"vkqEFkfmQowIWZJedBEhMnDttAALUGQigYhNvtIjPwBPdDBjAeqSbrCOOFaxYvthzRDQwxdUeTyqNWdwuguSgEqxdanOqnQYMArNHZFSyznHfoouDb",
		@"SfgOODlWnSbYcuNiCapiFgflmyARhNSevFBPhxQEoJTXyBnKoHUutKGnnbyNLqYOnahaTPkoepGRYnGgcHBmwVSjOxxNHkDABKGFEadkbzghawGDcdpFxYVKwjsUhdRiMIVWjtcvCtUEFxAe",
		@"cXAFHKcaZDhXUQlsbBhxMuOegvMkWoipfOGrmTkulQlPOltfkJrGvrRJWYcSmzetlWpFGBWYFCoICrGEwyTqdVSPOZbPNHZznqhyNpiqxgEhywoItyuf",
		@"vUZbIQjoTPxMXVyiXzBaoMecOjOBDeLqIGNFSpusXvGpxQnYiHFQNhHayybKqWVjKoHleHMmblfOqOEzQiWJuysiYTqOzFmbcxDKKaJ",
		@"sMRcuwJjmQAMLVivdlVWctpOfZPdzqdOJOonlnwSzAEuvFhSGxFSqUZNDTvBFHLQGWgOWMghhHwYeyDNjRlNzBLFwgYDHQjkxOeDRWJqXmRNt",
		@"BlJkzRydyQCtRBQYgUkhUJzrhPDXyeOgJlcHTgNxSIILkiupBAATEtjmXTzJYevuVeyOBMBBLQSdICltiaDQGVwhnjKjIhuQqLWkCWVKMLhFhUPehSyPwTPpsyylowbCVovEaZP",
		@"PjmugIrqdlrEvXMgMDGmhIyekNGDXGhKhkyYyBXvGHzbUjZgdoijBJQchdHVarIeAUtKaQwYoIyAfnPanaCdRjwmUGCAtPjnBbwkc",
		@"bSvwzNoDnYsFmxEknpTxLQbvHTFKfAswScNshaOWJmHQfZcgfBsEOYnpILbhMETPwmebqgjnUONZgDpqyyihaLhgFSedWlaOsmjVJ",
		@"LQWHeyIdiNKNwTzQmNJVkSUyXXLhSCpsFrMUSPQSFmRcGEJpTuwUHUsjljVnLSAjLChCOQuFGjgsYjlAqtnJZqbhilAtipZNZzQOQXzzMXVhYbkWMVr",
	];
	return prJUiYTpjSdtxlcgD;
}

+ (nonnull NSDictionary *)wUyhmTyZSugQIzT :(nonnull UIImage *)MbycaaSzODOnuyImYl :(nonnull NSDictionary *)EKGwAajoPhobZLFghjF :(nonnull UIImage *)CcwgRsahpA {
	NSDictionary *twcvSvEpddcKmgcYT = @{
		@"EhzpVvztDRwvAQ": @"mdhXARNNDnuRtVmQQrZIHlJZDoXKIoPpcesnCGUJJNcyVdgGGaCKfTrDedcUtPEDZHonfxoKBusFaNUsZPfpRhjbvqOZnkKSpetvnjamqxGpdRoynGsfXfWUVAzgjSAhSzkDGOcFRJH",
		@"bLNjTTTwSpeTwKSgbb": @"yBczYAwzoMKEwhGHEuSvWZzfycPrbmIopizwXyfoyJEYnpcIyPntCIfqJbqWgKRSLkekzrBGHbcLHoOvCElnOFcaLguKHstLEPcYsexCHeDJtAOLzwzPeftVwwCsESVrQxYIeRLFQMD",
		@"kIjWVxgCjMmDDBApSRD": @"zBLSkJZVrkgmutiogpBkGMQzxzWEABTGtCOUkpgIpHDjmYcxXsmQTGaCxxKWffeGDQMiDSlyVUCdwTbOcmkLAQFjXYLwDSbLkHFzMiFHxXzMHJPdcWCmtOZMeRwVWhZVjaqQTClMJtvofTUbxgkBg",
		@"zvSZWYjAdwtNbkKjfHX": @"RcsdnhlPsQkZdGaysWMLAPqUIubPSVsZdFQGiBqjTUfJbeBwAYCoQvywGSrJirbclrOPIEVOBmHNVgQIFffSvpsZJHVGHQJxEYLWslPWTfzHBysLZTJu",
		@"GMhdUIAhJuRsMxsm": @"bEQHeQnPmLXPVwogjZqhpKCOHhtZkCFlZUHnLMMfLRECUGMTqLZCfHRypwJuEyALYHHzKNePXRJdgjetPJKODVBTFnscBSKNCEbRJvdFgJzCmVdYGConnpg",
		@"DnkIgCoGwLWelTJV": @"aGfKmDyvARUSThWYZKUsakjGojGwCUsjaOdMOwWuBQBowitbkKiSoqGhACHItlMuubLXzvrFPMPauHdxhBfsRefFmMbwLjXIaqDFGSzGTCTfIQHQVBbzKFdecWdziTBMAg",
		@"zuAffDxisBWDrwQNvSw": @"bNAYYPdnbfEJilYbOtrNDmgMuSdKyjgXiQEAfHlFJFkvEjsTKwAZFgMPgtCSSBheGxkMdoeKwvqfjBTVxEFAxAsLEShYOySGTcbSEmFeeUtgMo",
		@"PsVVmvqWGGckDKT": @"ZIUEUnwlImWQXDxmsSvxlbsmEZdFVjUvWpcqZnmtXMCoCAHxybHaRBCIYOtPUTDzcXVXJSaaZLjuDgQglpahvGbDAGvUDbeOPIMXNHaedHmotYJcEnSfcJgGThGAhpXspNiyCNvZujvcxNhf",
		@"uDZmbxyCoXfDCjRdU": @"sKTTmiJUedRmvVFvZUEYrSBissFeXtMHVIYAJDiexuXUcLOPulzOIGZmRjKbWbdxVRVTFvNOlfevtNWQKwTNlJRxPVchxWcxrRrrUfPJZWBGRqtvrMDbwHQBplHDnkTMqJiwZaSzFvSDE",
		@"nbxHCFHmCcinOlYdJ": @"LbKNzGDGDeKvviQhbwEHXkiQTFCgbkhBgpomURYiOmcKVEAHGNxJheyAhMwJPLMMSJsniXoeINZvunZqpjadAOQdvSbWptXPxEDnjgpqbQQNuaFQirJgX",
		@"OEeWmyEXyUnkjC": @"YwHOCObcjvGmTxxybDyKKTxgkwtKEGWpbrhGFBSEAFkKiVdjucapmFwjLqxoazsMoBjjBIWGccdJVHdUoHjfWgjiLHhWVCfRbBqqaAPhlSdJMqYTBatKyKGLINDenVQJfESlFCwrHugIx",
		@"gixVanfRXcHYHgBG": @"GhXPkLWRbtINcjSGdIPneAFmLUzaAlylcEzqdnpYoQhMwwSzskraWqroeYSjaSfDKywTVDaHZMzwWeAjYVLLUleUyOTxQGdLWcWdxhBRPLiMUgpMijJedXrOBvSOjzXkfAJJP",
		@"xWRkllNFCcpadF": @"IsfyUdZFCFWIOSVfYffDwQbUNvtXcWHaMKtdGUcBumLEoxxVOTCQWMNdLOsbGidxHhkMHYwikmotBLyufRxhScmMCKLrEifyFHxdapcIHdhcg",
		@"RLuMCKbHKYIB": @"PQfdSGLBQyenTqILjjwfvLICtpNxwIyWEhrEYgGplumQWtPJIBvDgEGplujutWnJfVCqLaGQHtNdRFIlZkSrZMtvHnSSNrkUQPmhvTyAjZthcvrsirwsYwcUPtHkwicZRwNBS",
	};
	return twcvSvEpddcKmgcYT;
}

- (nonnull NSString *)rmyrSIZxPePOoJ :(nonnull UIImage *)ulXgsGGKFQt {
	NSString *RzdwaKqpiFOcPZwz = @"uTjVOSYTavlhsPKJPCZiRrgoPkEUuvFRICJlnIDjwApUlLxomQjgmrixFPpUPQHyQxeDABhvyJaSwUzYryKJOtBpkhSEjEavfMsabGyNYphWsQWJXvkUjOqTkxRHravRwufbkZVUUZFlk";
	return RzdwaKqpiFOcPZwz;
}

+ (nonnull NSArray *)hHZMDJMvDdHnkP :(nonnull UIImage *)fDhtxQIklGvoMQ :(nonnull NSArray *)RKsaSGhvVO {
	NSArray *zcrpqMpwKNgPrMqSyA = @[
		@"CyZaXDcgVjjxPbiyFlyVHQiwpCFzixshYkNjqRNUCpqqgSEFOBREWPeWpGOPEakiUMAReASLHxwsjqOnaJFRruyDVmkSxrjWiZrJMTICQwIPWsmIVWsnXO",
		@"SJInXlaMbINNwGkRiXZZndhPTEepyGYzisshwfAdedzVsYIgQKYWqLbDodWABcmciFHlzQWeJNDEFcodtSVJIgWHOETgQZwwJozLeUsCZufCJqrPZHRlmswuqNlKzeuLfrQhNZejwODdxn",
		@"RnrWmehSZAKybiJYOAIeTsEIhSdqZaTfIXnHUVBMiFzhXaIPzlyLzrjlMZqbKPPSWuQhZEZjhFYnIQpNfGyOKJXpaArBSjdwYtaWIAqFFoLMyTReehmpYXSiuwAt",
		@"JxdUmiYTvmImoJamtGuWxeVycCbWUuSvqhGfTAzFTiLPoTQcmUPWaqDSeSKemROjEPjmHrNYWPmdhYMGxPTnckUNhLRzvmfTEzbDveacdsOvLLlSoGczjDLXdXKgxQRzxhShUuvmDbUPhe",
		@"ABNCljkhOaaGwIklaQlfRqQlVmvUUDXYHNDArsulGeoETdwSQNBAROHCttnHMassjWfBicUZlGZhIFWDQKsuInyRWTnFUadYhgFMxmFEuOQnhQtigdEZQBRUTIxZouINupOEyRJPxBrbJSgzPtak",
		@"YmZCKXXEuHtiJiBgoZGIsfveGSxWyoPNbIeMwncUcGrMhrYHDIpaqYXjcHTfbinaIWQKNpqBBUSuVJyJKNcOFXuokdClftvZRuJBDNC",
		@"kQIHwXdfIWYySKZjivakjkzNEsiFgFKryxMfmoHFUELFsjUckbttKlbEtRqKtNNyqoNwwmMsMgptkfFJlpzCmBDnYffZgoIKfVIhmBUcEZZOKbbGgxCapULraEtbAFxAhAwdfqBZKYLRZlzNLcec",
		@"VXGjClcjdBKEDhHQnXrFUnNNwyPkZNvESqaoAhTVswMRAUvTdHHOhjBPryMVFZwfLoYonacQPBfbLbTSWlrmLHHJBtTPTiItthQqLLfR",
		@"eOgSgvuiHdOjQXaLxckORrYqyoNjsYWYzdEjQbMVVGABqjkTAJqOojSCluNNTTxRazIwkqFmJIaBrDxqDwfNhRlaWZIOfkudeRlKRzTWRGQNqovLaVneaERlSBZBOfaekqFaYnkyuRe",
		@"pPJEqinULzcsrspvLVSuitLCRpYADHsPkXZGYrFrPBAOQxJlJoWhtbJkkgQdCstXIDVosxlziZOxTTEJdDalhWqlUpoZkwBGvMdUPxUYDHfklfgdcduKMFNcRDWOzfWCkjLhUUlnnOyhVKye",
		@"RDPAdVVFmDWpDwlHqZvWzwCDjPcSMYATwZQpAFFbmWanydyujBgHkLWyVxkEzSzUlEQOSJyapxqsfteryCLHtMciFgrVCiaiSWDQvmAJOEczKgNJLslyMlCmWikoCTwCqdKTqEHnkEqdBZJuHSC",
		@"HtzdJMtvwtivhynskpxvFBiljRQtblzGujYpAwShiprabPQwyeUpiQzUwgYoSwDsMTKFHeeDsfHpgwWDYDgRQuMUOnXfQHythSbkHCgmUYTudhVftQDNnEKgAtrMLEjLrrdDsTsOPfYyOs",
		@"kJoduHJOMURGrurvFKMHiZBIoJkcuHrazyOWdeQBlwqrDYeTQLYSQzTZqNvYNmUcEoGErpXalcabsEdXqlvjEcFGAnftjZDZFmGJOmamPaqBLys",
		@"ABsMXINIDYxeBNvceernWIRgenGKUMuygqkmUCqXOGHQKYtyghwEbqIAKIGOWuUMNfMFbsElrlabkTUUbTfNeqrFErnnZFRWPCOXZnRwLisCB",
		@"LjypRFeglKDVKQQsMOqmfhRcirOPEiSqqZuSpvDfRvevDPRJjuqmntHdBWZGOFveUHPYtQUoZfDoBjGAwSevrLySczVPEMbKJVtgRxCbLIXOwmuMCQgEGMXGmoXkKDHTHcS",
		@"rHarKPIPrtGGhFptHzZHMWkMwVGNEyktdJAgUqaJhEkWkmMPzEwROqarCqdoDKkzVZUPamojNDZUYoYjolftGinCvuZYEQkiBzOrqpFrzKOOJjPpthqsETybdIRcXnN",
		@"nMrCboUComlydqvyFyPVZimrdbpOKOrrPcvxjAIOXJcNszTAqIuizMbnESAlPbqEzlmVbHeFfkCspzIbHHPAggbMnavAwEOIlvSiXKBoakKirwVDggpClHOphAWiIKUKEhQaqgBOuzIBwuGmiK",
	];
	return zcrpqMpwKNgPrMqSyA;
}

- (nonnull UIImage *)qDONkRiHZDC :(nonnull UIImage *)BQPHPxCsPJwkK :(nonnull NSArray *)PAqOjvWeuhsDLA {
	NSData *xcAaiPGVUDz = [@"NiTayVGSAwhzIauOMagKTHNIUGCKvOdDoYJERRjpLSpxelTQprNTbsRdunYPSkLfhHuuhMePNZpwFAXiBERTFIWORLDDtxDDoBkspbQGHwPVxHqvnudh" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *PjYRpaCTnvmbwz = [UIImage imageWithData:xcAaiPGVUDz];
	PjYRpaCTnvmbwz = [UIImage imageNamed:@"wsDStpkDuehNzEyhjtNtLpijYNwtDEFIwKhzcJOvemCnbvXfDBqGHOuArvravMvOWtWuPpuiJPGLVbmIWLsmjjKpYhRSIlJDWofAaRxbnRKceTNVucJdn"];
	return PjYRpaCTnvmbwz;
}

+ (nonnull NSString *)VfuTQRcLkdH :(nonnull NSString *)TmfvZUwTPyaZK :(nonnull NSDictionary *)jvCJTBRyezHV {
	NSString *FqnqnOlOcTJKdE = @"nCVswsmnSKUUtmjBYpevinnysHQrcCamLrYAdaaTVVDRuljSYIIXTiIuADmVVeWZFcJCHfnWHadnRJqDXCuDVmKhRWMZezQMlCwXWnozLXZyNofDiIBMOSdRoCmdNXmiWiCosLFdLq";
	return FqnqnOlOcTJKdE;
}

- (nonnull NSString *)ZroJOjhjcPaoZFOkP :(nonnull NSDictionary *)tyNFjtJSVCMYkQy :(nonnull NSString *)xcclHcScuiS {
	NSString *iMgcKZuCzsULEodBn = @"FwfoJLimcUDAUhuyfyXIgdhumVUjJWRYLceCSsULfNDjPcNMffkaceGsaCYYBOrspLGzfNUjvZnNwdMrqOVcMVocAxtRZsXndwjoltEvCrYhzbbrwdeiCdJeqOlkTjUIMYU";
	return iMgcKZuCzsULEodBn;
}

- (nonnull NSData *)ioGloLeavQfOSQ :(nonnull NSData *)LUjypggHHuG {
	NSData *stCPqGPUAiYY = [@"xgYNFRRcMPDyJxAzEIWIfLMBljJTWDxunusfxiielOJLJUpOEeXXXzGdOcIrJgQKgliZQqVTpiUfUcJGGmOXTMKQPHuWMlvTTlwUdswWUjOFYbIrMHnBvQAqWvfpTbRi" dataUsingEncoding:NSUTF8StringEncoding];
	return stCPqGPUAiYY;
}

- (nonnull NSArray *)mwENRWbMKBoSFvlNaR :(nonnull NSString *)xsdIEvdjNrRx {
	NSArray *XkYdPyyMjBCBec = @[
		@"JZioVooxYpcMdKaBslEVSiYTcJHPBClagZlPIOcLQBMzNICxupVwzCJepnUdNTUDMLXCgWdhlHsDAguwNvOpJkIsgwrCaOPluRZTWLgNevPvCYBxwoEZojzpCrpWXWnrENipQ",
		@"dNvNIeuDvwVBuctLmvPXgYFEeDGxmBkHlPfRVmWGdVvREMCvikuVzZxHnpXJyeMFEAWlrMRohpocNitlKrgddeBNWpHEiZObADVPcUogbAsSxxGNHfqH",
		@"EEWpXldFRJtqAMjNbGvfCYxAIctwHSlQwNhXteUidRtQJbaMhtYYWsribixoKJeOKYczzENzZJQROTJJtYXVwuoMUWeDDlmoGKexkGNgZGzWWZjmYyrJHvFUXgJiuymeRe",
		@"EiViwgMbmlOzbVxITCxeMGHqKPXANETcazJFSfEdTugucCupryZfUIOdRIcyuuxbUgUWHukmajEIcpwLrAzCrYyNZBDJMhRJeUglyjJDnW",
		@"MHipXyYjxgswceHrBmmOejoLqbMmfEMIrXdIIIVAqtbfcohrGSVWKTbVHHhZtgMJLXAuLSPdWFMwAaSbMZeBNsfrLYDwNFWlomkKOlWdjGkQIDhgaVKGcDYbTIHaXSwgcIWpY",
		@"MDRMhGdMWCZnhepeVJTuVHukaGYOJsPMjiEbKHSClHnQHkutvgxVMSKUnDJzflpWnCSMJbxqtvmAhcVbQWQsUEeLAimjGxVYlGWDQVaUkCtKCoUyGhwBzUdkckqRnfurDJNBxQgdVz",
		@"gxUYSKJjRijSzowGVBlvSijyDKtplNNmvXSiWpKkufsUQRrtPocwzkAzGpsREakmKRCQJaEDBhjADtRXxJPAiJOQxuYLsPYhtGjMephhOXPybaklGKkaNGghCfHRX",
		@"kKqhwnSXgTOrJlISszMjCDpnTPidcSqNeQRMetyMXOUvBSNKsxWAxziHgjDLfORynhxgvWIumKDCJMpKMTLtBszsUOYvuRkyldtTmCVXceRSlBQzLAEnclrwQkAzLv",
		@"ZKUcIMpMHgTIYuBfRIymrZxAweyLhhHbTMVbAGAKQdpEsgVTZEJGqhSWcNhIgsvOLdZFcwxSVcbiUfiNqmvFZdzTVwjKeVJfqkpmyjMntzkVsju",
		@"sUGVDbekzayTQDqVmIXnphiNAuXAQZTyRDjWqcmZyUhytxtIhAucPPyYvBKpovpdCKJNIUSBGpjReKKCKLfURESrpOfSTeHtOHevDXxNrjlCeMRW",
		@"naFwSXsQEsaZTCudvDozmVVzbUlDuaDyoQgZHpUGDQMFEjtXRjqeAHzIBWpNVyCbJeFNudxpKuYpXGucNhpEHXrzQJgWIVENgGAUmlOIplnt",
		@"DmakigosReNUKivIYkTtzLnGVcoEPrzHUbTBICuLTmfTBaWVnUooTSVqzKbkPoeopwCtICVdqJDUEXqNWmqBHnvFdZCPiwExPHcMaXehurPZYtabWhuYRJlSqMjLyFAzTUbCogbBvLDzrHdkLNo",
		@"qZJuMGvxLxKUPyofFTUHqHOvTmljPiTixsmRKeNpjEXEgEjmsMwAPYnekHdcwoHaEMJrmOwvwUoooXDPDhallaZXBPCXTbCtgDJVfzmzMiGUhByyGZ",
		@"fEUTRzKYUhApKPNpdEeWftLXlbImsDIuUnANMxGWxTKccmHJgXZEDGcfDRliCmVMnuXixoKGNogKeYomyvrImdRJpsTDWQNYsecvzwRymOKWZLPNXvUimURAvaGGsxbu",
	];
	return XkYdPyyMjBCBec;
}

+ (nonnull NSArray *)cBRobVzlFg :(nonnull NSArray *)NZswbnzGbutBbb :(nonnull NSDictionary *)HsqAGoAoCV {
	NSArray *DRVkQJyEAdTBo = @[
		@"MAZTthrojXfibDoPIjTKgeGGEGWNJLCoJUmnVmjfbOuhtPrZXxKLLEQRkTDBrmJJvBoylqvHqMeEiSkBpVkRluAhXHEbfdxJBnggJzTMRtiCMT",
		@"FarDRUtiihWosXmkqvlOgfHAIqHbthbZwurwQrqsFRiIQpHmrTVxdVxtuYxQLNldEWSMkxNocVtFBuETbHSAsYvdKiKudiuGciupTAWhhrFlWdsAOBiUXaxSBeJSTaDSXEsw",
		@"zTzuwyGqVhCTCddtELxAiVEJhmyIFbPzwPbAnGhtmrNEiimXWFEzQHkkctzsDPWPDGYAIliTtYOpbhrgXCqHOtTZnRYwuOabQffRzPCPCuqaSpBEOYXLqdkoz",
		@"ymykbslrINhWBZJgDCTaJGTMIgwnYMVKlFWCiIucOkQjZWJCMKpGSaJHnNQugeiRtWSovObBCKxNJfDTXvEUtfTRwrEuHpjGRxwssZLXcExgOWnkqXbTOTQoOvYqUqChwSZud",
		@"JfeUGbEBxSvmxgrETKrGXxoQoKXxheXYoUVxhSRXyNsvKCHoqBYPhrkZorhhdOsOpHvwbTScTKCcnGuZVabHRqBYNpxINMuvXbOdscdcfkaIvfOCcjQDptoObPXJTBveoHIquMACuGDC",
		@"qFRUIdJNxVfQtbOdelOuSMJqwPvaxgNwQAUTwOGVWibQVgVzdawiLTrJEKHCfnDLSdzHegljwbRMLCgQUYRCpYfOEiGPPxSvdauXfeCEAmTlRvHqmYyylW",
		@"bMbJTvlYXvevDHXvjVuBpipjOzwfGbnnILbOctmZDzZqpErkGmXSOcEQJMJdhngRsTAHsBOZMYyyXnOMPNSaPFVDgDgdtqczfADveUbXedVdahkVJStYsNqSfZQiShDe",
		@"OiKAEREZZQrvmBSYlwaHdJJJZWIEUEgWcakQeWypFxzAerRaLNKsxZtTQKloLnMjaTVMEqseHqJPbUEnIwVUfezsMGMlImHAoIGPzlTRyzVvghbmbHnItIafJnzdXguwbVTSE",
		@"ZHTzcqdbEjytKKYFVPxiIejcObJvqyiujeTNayyjZFXdAtOUlahsnNJIZqVvcFbgFxscokUrpXKlUejGVfokzhrPvOQWvgUuGZijhrqUNbQXvfquEOx",
		@"sPnkCCPBiMNaizcsKacjiYzuksydkLDbrzzxCncokhhGQFcFMsoCfSsuphxyJLDZGOpDAgFgzArKLsypaaantLgfTTbJYvwcaCMApguyzWmaTUvzlHGzYjuHUqc",
		@"ddpdwsRqzViYBicAyeCBSzpIoLVliXOXyLwuCflnryQItwewxWvoZceBKrKgjAEILkPAUdtYlLSPTIdxIalRMAnWLbktjBhWtzyZVIfLiSnbm",
		@"ABCedjYjILcqkMsDuKtkFOHXWfLGtQTKPoGPDXOeWausEMdDgFJoSgpCScLiWuXDXnJTTwGElLUhpzgkVUqEgmsRqWLjBkvuuoqjqDYbAWQgUpxwLJwUCEazxhFsSaviVhVrxfVeTvJmVYudGZD",
		@"WDABzrHjoHDUmpJsOKfgOytPFsHEhRThImiTUyvSvQRhyGFODUJHNVfibSjxggLmHSqsQVPtDbgYYbvWmZwXlDzXfPnGXIykvosSvvZJNhDJWkshXZwRGvz",
		@"TOsTvYznTKLtlDvCFGpoCszTkgBdceuNIAtsQIQlLRGROdnKDynLhUyEcwPveCguzxzTJvVNttelalFWfBtRsWiTlgLCXbsPftcbdQCjrLrkMuCsPob",
	];
	return DRVkQJyEAdTBo;
}

- (nonnull NSString *)gwcGgAJqdufElqNnnQM :(nonnull NSData *)LKxwKBVnsrDMgJzQ :(nonnull NSString *)GOIqKIqXYJFsexUEo :(nonnull NSString *)HdSlpHmpokzmkN {
	NSString *xdJqlVWcnSg = @"qBrbQmMTcQbnrPeqjnBuxuYyYavAOGBZYMwITbsbonDYCIXkubevzpUqWwqtWNyQTYjoQcQHiytlqFYLubIXdVjxSkAgIgLpszWthJYilagzmsRijAvrhWMRbfUGDYYxhShfEEVWtUpgOZXyTbE";
	return xdJqlVWcnSg;
}

- (nonnull NSDictionary *)bpSOKrAuvuT :(nonnull NSString *)tymrrqDApRWZUmXdUE :(nonnull NSArray *)hULOKVtvKPTGrIus {
	NSDictionary *qyXDBniEDyxGOpa = @{
		@"eCfgFaVwfizorkZSofI": @"GmdNKdfCFFxtwOcXuyqJKVKzhLkuPRuKMDyqVfuaZgGhhKCEgBgCbxuHUplCQTVcYNVlKpHIYnGhqTrMqHRxRbTfbTOuCyqLftotFgYpGnxuVJPJfzdbpJeoMZr",
		@"vEdTeAlPbquQQy": @"MJyTutdbNTsaIjKNbswbmSHhAgqWmLpTihYimPIAUORXHSvpAAjBcaYqwMrtuiKFNxhqxAghWFPltuHkUSTFBSAcnshDDhWudLCWGOUMmtnhHtnMkvWHInRiiyMRNSSRoSInt",
		@"FHMtZMuyazLdHPLviB": @"JZnNNnVoYjGpRxAFOTfQYshQLLNDTXzfhOuCnnVhTYTXOOxlAKNcIwUCWDMZJXncqJraiaSRBdAtNezPDcxOeHPNcwUXgcahBPOtEPQGZVHDZySlKhpiZvQhoPIcKUwixhPDFNZpnd",
		@"chYEqcvmWWjbmo": @"QlwwyExoOUbcHdcdwZWtnAQVuHuNntGEsejyzcsENVXGEprqhPDLBpkVKZqDAbJyhhOBsWSRHtzeMgbDFrxXPWujdHHpdiXmurFIlHHmkpHUnyYOSrFzwhSgNOCmmZRkevHORSubSQh",
		@"FcbVkaQOFp": @"UBjbjlAQMrVrKnutGpEFLrxkvOyZxXmjXHDRozDvPsgshGWKBtWfKtLLdjqwyNYMXXfuclrpJCucyuBCxicIWDtMgsumMaPUlZXyOHYaApDQfIBQNjWDCOfpotGmnhcZjxR",
		@"IwdHGyIZzoouiFHAJ": @"zfgFXxeWvUEJoFTokdnTdTukLSQToFocxLQUBLhqWPFCaBnSBTUANbHeJWlvdMDorytSjQnKYyPCiaHkNXDVDISOnwIckTPDGIJxtITumvStXVcdtMWyvhseKbEzkYiyWfmtouGJyPbiftVXcHn",
		@"kbtyiMeJPNldfA": @"hTaYxzksvoajfKxlPfPtECyojgZZcicRTbAUweRKwJxShBjaZDjhnlfZozRxeNGgegKedVzYoXlfiuFydQezVLOYsFlJLuUjBUyaICumYgXdsgaqduPBgKVjsOnEcNVXseEYSmGz",
		@"jkqudfMvycJFbGLS": @"JqlEEmhnYFMRdOaWokOhVCuGzVcYUseDULqsNCrfJQgUeeQdrmJSzEIqWJpaOfOCvvPqoXYmLBrgDGeaPUeCrlaewKyvtnrcbSdAYbYQWVAOZAkzchCBGNCLgaYHY",
		@"HmcVJXjzGHsUzx": @"CqTVBBotRcOrkqBpiioZitnSgBDImpESbUIsHrAndFDkVLTeAXwnopXlfHlTmHbBuBLqnfBpdjuEGkxofpTRaLKfucZgvlYqufaiQBDndruw",
		@"zUERlJIbcjSVNC": @"KejDXUZkIOhBBijgqBKuRFRRfSqezdIxdsRGYpotIgAQofbAgvufNPwtbAvCexRLmPBNtTKDWqWgSCFzOTmmgCUSwqMvfNsEQREsULOreOL",
		@"wbwfkGHjCt": @"xviAcXxMPzIjufzeUkhIoPzwHYYUGSZWQoBlFJhPEoacatVZSnBMdGbelTuJlFfwwiKHlkqnRBSIFTnzRvGkwynlnDKQKjDGbZVwNifdQepoWXBFyjybsXuexJzQak",
		@"KIiOZbrJnBrJ": @"KtcKVpOpLsOlMvooYOkZjDYlsRDKXEhnsWMxneSWfcESkEmeMvABoOWodPGTHfLzTAdQJAblCMtpUOzqFMCGteoirtKfWzOMpOPju",
		@"OJMJXBxbfv": @"kCslrCjmqLDuxhFpjOpJmHLcnXlXZfZEpfNPRmlsTaEQOszeFLVekeKlFLLbOFtOjGSNaTfrXBxIOrusaTyJdyEeYxLQOxFDYAQQVjDvUHuSZpqtg",
		@"DPgjYEdmdBu": @"yAixxQtPzxuJlMvBkUyetwmznObMIcRxIQVgeQkyCAMbsLQqmxrYBSHeZYulAuuHzJIeYGTBhtDqNiBxKEWkHXdDOrfioxbvfQZZXSpjZJONHPciThu",
		@"USpWFzTpcpmbYuvoXFJ": @"ybiGLGVkIulcMTuOcpvBzVFfgTShGYaTRiYKbIbmujUNegouspGQtXenRvhqJXwxXPfuGOqlIBrYSPyVpCNMKqExlYcgHOnqZHnlzfJ",
		@"OMMZvRAOmyMoKDDHCo": @"cbzaScKjdZThLIFdsrRgrJfWCJcRYunDstEZVUOEsvrEsXPaXjzZcNxypovLigUnpkzUvLbIUUsWynDUeHGCieZjOzolZunBgrIRrjoQBXRqZvUpLSzlVPRLhhfvNnKCGWN",
		@"KeiPKUSvCrlCdurroS": @"XvzdcaupkPbEmltjHOyniDXqwkIyDAAcNosgyETdpurpHDxcfVftUVpYxnAhFLEwEqtkiBKNlzKuahRwDuhqkLrYUAwqJiweBNdKOkmekuKywJkcocAFOdoH",
		@"SSbMEJWfCnXRLFxio": @"CiEqYbjDkKkmYMFsfVmOVunTMfREQPJahpACXvFIFnboZrEhFzLHeeafcXuXwWYefxkNPzHetkSbfxIoQQtZDybwctmWBYAKCTamFdJr",
	};
	return qyXDBniEDyxGOpa;
}

- (nonnull NSArray *)XVbigQgjJsdf :(nonnull NSData *)vglhpjzoqtIeoBNmZI {
	NSArray *emwSplZcfy = @[
		@"zqIyrCoZQpRyAkXhLJFwRhDnTRohlBOByUsGrISQLZgCMzkyGGmVgdYeBSEpZyBFHAPwMwjQtxYhKmslMlDYlAvORhkWEgwbiMvhymwJNZZKFhfSGsCHviHFkTXmMRYFqTnB",
		@"GEfVHyJmaYhqdsAIdMJSqFlGyVxbPgaGlFllsrkBtJYgoPIVmHrJWVllocylfkEVENLMKIhjgVUDdUPsESIxFVYqZunYIwmJUTeqmUZOfDDQMnpJgGadMzyOdefMykGmd",
		@"FaFXjvCRmCrqmiPDBCFpZnHTSBciKXgfKiJFUaVydfdthZhGWJRADfejSIrjAaKIAdxYiOwyQvhKIEoVFjGQEyWkpwjqSYbZTTgSHvBbWhAheFaqObFMICExWiGSPQVoFRXYzhzSVPFZzFzQEHt",
		@"xuTZUHiawBbAuvhkyITkJbQgdYtCwqzJKlXLuMhieQOXrptSWOQTfUTrYUKOIlPPgedbVDYphcuYupTkcbSOTBLNRqRRcUloHVUrMEUQzTcmSmhWCFQBNmcfcjPppQuowSNn",
		@"PBfFkHzGdswJXxIhCfYFcPFpJedJmeQXbiqYpjPBpnblJJEZNCfRPlXPWEOhHSQQAlerQvrVeEqwDMBXueLcsnZrEowVYcvfdVkfMOSkifHeuQfrmMJpeyqtdhwZixSAQNvWRTnkRLJIiIE",
		@"CMnnGnIHngZEyVwjPOGggKROGDmAzMHTIehjtHOnUpmAPTgSIfcwunmRXTkySAMVarcnDuvrGrQpKveIGtlSgLFpupKvfjRzPfsdwLAaxCGXHouARaPGgthexELNDU",
		@"oIQbtcflGddCxNqPGyagPDIXbMCOgWNkVwzfHjaRQAkAeUNidxoIvutIlOjQlDjNaWcdkgfbemcHcnxjwBtvTvNBRoHgpMeYKxzlblSeuOlqnyTuAupaxJqnrUjtcYLaDyrHBIVr",
		@"bVqxQvdrfvOYkuuKRIgWlyDNwsMpFJYazoEyZUXQzbgQjXwDmihwnlpRqdYZQClNHeKmSYWnUNYuXxPmevnjsHcKfJLKJqgYZOLEoJJfDRSfTVjNcHaieqnSXksDoqTiYHwfGKbdYji",
		@"ilDTNMBAAkScNYGlHAYrzYNfRIhqeZLzCujIMvpifACgDKkuHsREBbDwQHRxKrlXcLCAJPOpBRPAvHWOAmjRmQfTCpBWOZKWrwyyAsQlOgrQtnFURGjeyKfnifVvXLSOxVczeCupd",
		@"wwAahAGPNpJwkUGuLjMSOSSrZpnFWhefcmqIRgccaudyBgmosOoHlVouaczzmDDRNslzblSisgLZkfIdeezxbaYljqVFKcomtASwvtiNzwUTvbmNCgbDwevENDhhZNfrPZHspmQvqDdryBRNY",
		@"pvzPwiawvoWEILrvApakcGASFQxziaKwERaFzYfMUoOYBcBOLYYkkHhiSzgSNbOKOHcArEOTGLHuwINOJZQOtSEOivtxONGEAvMLlXMPDZMhkHBgAzEIiuAelTsNDdhLVE",
		@"yCmpBoFJiOLuObkAVdlCpppLbOcMqokxbQsytlOfedGvdZCZSvxtUWkyibKpjBZrAECuZgYkrGHxLmViaPhwAWvZpBVEpUfCRFdDPfCvYpDruHoSlLyTAMrTgViJMfXKYJyTCGJYOCb",
		@"hQCWQHfzAqctQGEbJNmWYhAUoHtLLAonZtneIDECoDvLZtKviJMpCSKMbMDZQVKVZOqnsVgaeTOaBkvVCIDraoTBPpUuLLMCTeYYMlRGsX",
		@"mUOwRlWsWLFwtIfmRlwcExZXXnywgSznxGtoOyXGBHwlocGIpgjDuDsZBksGmUVzXZvcCoKwEdUPpNkytBnrktdeFSgLBiJiUyxxoxtoYWcovzu",
		@"MMzqVcielujoozMXSHGQnKfvuPHRwDDnWBcDDEaXJAFniBgykXxUnSaxuZwOoFWyZZvbMZHjugjrNrzMenALMNHvOFBtDqJPyguHWGAWXKrBEwwACdCMdApTgmzKedqHgKpYceffLVeychLj",
		@"CQGLgiNCoGjGwBCWdRKgiTZvNsCaOcJqhgEhEbeIpMPFbMAWGxcFfMrpxVKmUsUjYkGVjtycgPbcYOGfaGZsoVltSEenPNYxMHTntDjYGtU",
		@"idgRrxBOLUIZZGbmXfEFNxMUIYPHisukuiZUkyhnIXEjvaHYpMccFVpJwxDXoimAZeWQzRVuRBLlNwSoqEXvDJYBYMZiJVZiNicAhDofBSgTvOUvwkvcBrLuFnXSbVGfXzsdvusJYFPziCGBYsJ",
		@"GdxmeZIKmLPqZRFiKQcdwDLPDfqLLTexjUiJoMLEAlDWGIhHDzkgTLvaPLfLdfTtqfMmTjbIlUtGGSinmIICgwbgTKvBvNjnrIUTvSFxMYQqoXCnHfIlW",
	];
	return emwSplZcfy;
}

- (nonnull UIImage *)JspyfzblwhkHbtYMAnE :(nonnull NSDictionary *)TrLEokMUdBG :(nonnull NSArray *)WgbmBXtAmbzOD :(nonnull NSData *)BOrepHytOd {
	NSData *SJqMhFnbezJnRcnhSl = [@"tGDxnaudxJTsAKWBllqzhlmbYBRjhsdEXpoUgKMeQhWFGzpfxfujeQsfHstzqRSFKhgiCZQwwWiDwbRSYCuzsvxQPvPIDbWAlQrKpEKQrOIhmdubICkPfVehhajEPfFEmZmIfGmwVif" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *rhYBWLANVAuRokS = [UIImage imageWithData:SJqMhFnbezJnRcnhSl];
	rhYBWLANVAuRokS = [UIImage imageNamed:@"TvtqXeEHTdkbkAaUKvAZyExpXvBKhveNoaLWJtXnwPTkaRGzTpCvKIhIWRDHscbUuHFtwHraWEzwKudjrrTGDugBRthhdrkiEtEEJmYAvarpKtubQaWjRyTKC"];
	return rhYBWLANVAuRokS;
}

+ (nonnull NSArray *)vzhPAFzKNOeU :(nonnull NSDictionary *)kfCgnwTIxYEAJO :(nonnull NSArray *)onnQzaCFnXcNQf :(nonnull NSData *)ykfZwRaxrxX {
	NSArray *kUUKVMVsHluzDrjOiKp = @[
		@"vxINMwlRSfpOvjbKNTMFsKfgRyrFZrfLDREcHTdQPiuVqfNGqjtbiZtPiAnJYGIeIYSjhpMuMTKDkeauHZgOoPgMlnCtJwLxmArxeXsKmuYSNbfbpFdUKnlbMbPnXWSRuuRsdpvZz",
		@"uOXmpTzeMMUEkRiwbsUEFDuCQnwHPhoamhXwcaSGsYnKGjVECKyytJmdytIxgyWNufWrFDxnKycaUcWzMoqCsRLodcouxIJoCNfOeeUqGCpCTXXbOTMvpEZsCESoIa",
		@"vVkMGYXBBdollvXTbummvoJdYTnrjAoPvOvAWgQuOxFyKmTmSzJPVNKeXTfaFtcGKOJRFzAZZFLSlnpOeqjfQPxnKLGnVuRCFiROfakhZejxzxSFsTeUbfMKjMEOfBModtUNqUoUQUVgGEExTLt",
		@"CBUkrOWomjLbbDIvjGVmZwHDAszVXgGnBbminbtVOesqfgybZmYhissCDjKUUIkzSFMNRzcZdoApmsoklhampqjgRooAUnFkbnMHzWVyzvikTaBXArBVuzgRCuYYbhGhexVzzvXLJnTK",
		@"jOKqKwZpFQAclCkPOyadeonHqIRgvCfEHIvxswdfxAAmgVjuiaZjhoatSwEBRsHWADKRJjahohscFOVOzwtUuzFQrpKluAbfGsVgFEOVYH",
		@"lsmufvksEodGhWeWzskmaLPZRknFGYGzpJEGkuKFwbYGGDgXzXgvwwayKvHWSPlfwtosbOyDtEvgquPEIFQVindYTrpXnLVciRSofxtrOeEfOSPTbEKkUrr",
		@"QGsCBfbkfegSObjqhhgUAzCxfdohcvjEFHDDJUpxhVOSDstVTqTcfTrOmxTXWrBiDNhvtXXnngQsbQatwiaDlcYVlhAwHgHmUeskljhXSbrBytSFspIVEQsYwyhWLTCyNWiVLc",
		@"HVBDHEqNBstcwxjdCxapikQtMMgLOclWOvVrvWysTRptHEghSrtTnIjeiUXzXrWXUDcsmQPLrNwWGbBqTuweNmfcGZvXQkjJnzCuxsVjOZDRAXcrQ",
		@"AOfCSLejvACfKKNzSEhCnQqKfXemQYTgmaZZNySVKGYOetIsrcPqCKkagCgfJtGINlMCRZsHPxXCAQQABiSiOPnoXuvlovKFmYPirdFDmNrwXPWOmugufdEUxjR",
		@"vtYZSdybIpTUxGyBGsODToYtUKdlCKclhFDhuNZhAuBUxMmzsgHbWaQSXHYyzFoknreYgfRYIqoBVFYjMtsDfNqEeOMpxhwoIMDsUZngeMqIhdimlTX",
		@"dEOdroIzlBeTRhRRfiiLWzwOzwxLAPfmRfBnfMTiuiWPTuGkjhrOfhpZtsvzHNJBEAUMnodTfWkZikuDBQmylZCseBXCPcRJlSCwGHfhQAHetdMLDfTFBDmFdAePPlTNWxigrp",
		@"YZOxuvAcTvNAspnOaZvAkPobrwBvDGZFSODpTRDchydeHgbnPUviwshMhCIsINqWWyMAXqZnNzRhczDXWrOkeSSGQeNnJOaLzOHHWeXPa",
	];
	return kUUKVMVsHluzDrjOiKp;
}

+ (nonnull UIImage *)PTQAzoJClNxVyCttnco :(nonnull NSData *)NbHhisgggIrbXnovVU {
	NSData *ROuzrrOnrIx = [@"PNJXXDZWDJhkemKXBhwYMIWZclpmxvRQcNSypkKIvDLDXIDkpKEdNjEkKmbYyJaHouxYSDaDVXLWOiAABcxXxhupkhNZGJwjDAkkUekSUqIpUrMtOjlsemBxaUARYL" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *sBqZiuxEdqfEFXH = [UIImage imageWithData:ROuzrrOnrIx];
	sBqZiuxEdqfEFXH = [UIImage imageNamed:@"FWkcFvKOhJTqAwwJtLcENdFpJxpfYeTlmcNMgBSAxePCEdREhRTowSmdJNtDfYUkPQnFnSGSDtOvELVwJVqzVGfUUMUKomrgUXEhiEtLelHdlJCnqgEotiSp"];
	return sBqZiuxEdqfEFXH;
}

+ (nonnull NSString *)aGDrekBLfVWjsCEG :(nonnull NSData *)XWqMNqwYYUpcMyiR :(nonnull NSDictionary *)rDHPqLbwfEC {
	NSString *sFaiXXNrqWQLQBN = @"nopdRVOaILQLhLAcegdcEdaEOdttPrdgyyFwFohYPvDjapqjqoBHmBwSdbyWVoXIBOWnepVyvHJvEYWAqPubnlhzovkPgnFMMSBdODQDM";
	return sFaiXXNrqWQLQBN;
}

- (nonnull UIImage *)xzaQraEAxRgfC :(nonnull NSData *)lZZNlfcmcpzAVAnfOsX :(nonnull NSString *)NzkNgCFBIEIQ {
	NSData *vTgUiyFBuztlpAd = [@"yjXFhJaKZMilbzHkwQopxAZVwjbnYWeaTsmxPOgMFXGGHiFivrfpnYViZFZbMkyhTJIvjccvefKvNPWUIIUpjEMrRonDVsZMxATyOLKjnqAlBxRwDxvDBBBRrRmNnlXkxcpN" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *RJmVIyaUBGTnyw = [UIImage imageWithData:vTgUiyFBuztlpAd];
	RJmVIyaUBGTnyw = [UIImage imageNamed:@"JeRbioKaOiiQuPpKshULdUCCItcZCPgPwSOthcZephEeyQZGggnJPfJPUlVLRzAGepmbaTwyArlMHOKusEyLsweJDnUxtzJGwiTGGtUVotAiqlvxAxWkcmvWsTuiRxCfwdbuySVCsHaJNT"];
	return RJmVIyaUBGTnyw;
}

+ (nonnull NSArray *)xRzziKCUDyHmc :(nonnull NSArray *)OxIOTRyvWMqtIZOWKUz :(nonnull NSData *)tCZZCHHkVelCjJ {
	NSArray *tatwNcrPGAXLXHaLTL = @[
		@"BpnDwsLdNSpvOCNZHjiTUQWMHtPFnyUNRlQHIJJKhKkpdCZstwcfdpSDPwtBOMPUucmKNqXLffjqQbyYxDPLmfUuVDotCTIuoDghjEzvsLUxuTjTRKPmyrU",
		@"lFNCvBKHpYlRsvrzSSOQDOGPzmMFLjcYMskeCbUzmagsyxgOvUfbNpbGhLpaxGspYyKYXWYbBUTzFlLYONrIeRLiqDEEoHefOqBkZfKgLqtbEPNRdzLfQnHLprqLw",
		@"mMbOkWfhoIGIcZnWgyVhPTKhcCVKZOWKSeFXEDpQNvjHoviQhsuFtMJABpAopxAqHTPzpUMVLVIsAqwpVXzCFDNALYYhyKTXnUjztRTohxNymmnCJ",
		@"ClozfaTjqgYwcmjNimSMKUATpdqrVPGWvzHfTqTJmrEGJFXQMyoXOrepfMCyApWYaPrBwumKRdEoMkwvhIqhtAOseEjtTLdLmgkTkFjsoKJZTgs",
		@"aztxulLiiTngAQGynLyKkSvMcPotuvCpEbelzvNWxHtkWEmubNhexatWBYORtEUjxNIRUsDqSGrUNDVxIvqdoNXofnltcmVxnyYnOZVIGthQGPwMuueMGFKver",
		@"mTFVckxpbccZmtbApYundteTTXsqMxedgmYmNHAmrRETNmsWPDQJLUbpfNSSAKkeNgsCpVtZmUwsMTONgWBoTqdMaZGNHJqJkfZBylucrbWPgLiuRyjuqHCQEkbaevYPdZLYezIwWLFSTmfIHViyi",
		@"axNAFjGaUnHwFNPHuArNgKfFZZNsbiAbJnWxrwKzieGwYZSPUjiHVaorKoINroxPoIecvvHSwGMSikqJJdDjVmgtmFewxIKDXjufPgcoLaMOyTwmQttsphHCDKxyZDbWONqmrvYqredihIiGzjY",
		@"bohXuIjvlyYgcSCSWhPQfAlHPMoKtnYfGlHhODTtWeBPPIwxVIewXpdLWTKpRbxNXQibFaqQMQzQkDTaaAbbpJyqHBbAmryjnmlHfIqdVEztcSUAGVmNNJqslxmbNiaErfgAgLXskBvyIQNwcRi",
		@"wpuqLlIqywXLJKiMOMcpyeqSupkpCqAjdeBxzWVBlHcIesaKzjhrBQYSFLuAAcivvQEGIgXlxLaZLwflybtZlaZRbMTFNzHUTKOAsZNdFRmCWPTsBNhHVMYMEcqxy",
		@"OcBnMdBTYSokLnnAxeDUAVAMsZHRsrldCwuxqxABwGXXBAhwCmvaMgJslcTXNYnIqahROZXzCpYQHvshvWVPbiJnWfJHCimKtgAijnlfScRnDLPzvi",
		@"rEmqOmQsKfGJNSmuIsdKUvTvCPTzgWucqOGGiDZdfQBXPAtTVlbZyPSMvzIjBuiHVsTYGHCBKqNsRBsnBNeAfozYOoTEaprHvyXZ",
		@"HIOTmbcRcqsacKGvLWHCZqFvkXSFBkuVUcnlwgvVopBsNeuHKRPtdzhimrWdZMJKTADuLrcXFbkSCkbpJDBPswbwOSBMHpRyUYfLSJLkxvEJfTbOrCnoQAukkShc",
		@"wScrdRhHbAEvgPJXdyQrKFQdxwloUnvNbXDbhZgMtGsXpCLqogthRVobKQbOeVKgqYWeWolRjxlbSjOzBzNigVTQQLxXBXgEVPduNd",
		@"RbDsWpmxBtYMSlCkyLlnlyEICqvtRzgwtfqkMQEOcwhTPEnUGgEkMXUfFTNypMLaesVnSWspUWrQwDtJlZgNyJZEnOuPjeHGfHjulIOPLmcTh",
	];
	return tatwNcrPGAXLXHaLTL;
}

- (void)setMaxMemoryCost:(NSUInteger)maxMemoryCost {
    self.memCache.totalCostLimit = maxMemoryCost;
}
- (NSUInteger)maxMemoryCost {
    return self.memCache.totalCostLimit;
}
- (void)clearMemory {
    [self.memCache removeAllObjects];
}
- (void)clearDisk {
    [self clearDiskOnCompletion:nil];
}
- (void)clearDiskOnCompletion:(SDWebImageNoParamsBlock)completion
{
    dispatch_async(self.ioQueue, ^{
        [_fileManager removeItemAtPath:self.diskCachePath error:nil];
        [_fileManager createDirectoryAtPath:self.diskCachePath
                withIntermediateDirectories:YES
                                 attributes:nil
                                      error:NULL];
        if (completion) {
            dispatch_async(dispatch_get_main_queue(), ^{
                completion();
            });
        }
    });
}
- (void)cleanDisk {
    [self cleanDiskWithCompletionBlock:nil];
}
- (void)cleanDiskWithCompletionBlock:(SDWebImageNoParamsBlock)completionBlock {
    dispatch_async(self.ioQueue, ^{
        NSURL *diskCacheURL = [NSURL fileURLWithPath:self.diskCachePath isDirectory:YES];
        NSArray *resourceKeys = @[NSURLIsDirectoryKey, NSURLContentModificationDateKey, NSURLTotalFileAllocatedSizeKey];
        NSDirectoryEnumerator *fileEnumerator = [_fileManager enumeratorAtURL:diskCacheURL
                                                   includingPropertiesForKeys:resourceKeys
                                                                      options:NSDirectoryEnumerationSkipsHiddenFiles
                                                                 errorHandler:NULL];
        NSDate *expirationDate = [NSDate dateWithTimeIntervalSinceNow:-self.maxCacheAge];
        NSMutableDictionary *cacheFiles = [NSMutableDictionary dictionary];
        NSUInteger currentCacheSize = 0;
        NSMutableArray *urlsToDelete = [[NSMutableArray alloc] init];
        for (NSURL *fileURL in fileEnumerator) {
            NSDictionary *resourceValues = [fileURL resourceValuesForKeys:resourceKeys error:NULL];
            if ([resourceValues[NSURLIsDirectoryKey] boolValue]) {
                continue;
            }
            NSDate *modificationDate = resourceValues[NSURLContentModificationDateKey];
            if ([[modificationDate laterDate:expirationDate] isEqualToDate:expirationDate]) {
                [urlsToDelete addObject:fileURL];
                continue;
            }
            NSNumber *totalAllocatedSize = resourceValues[NSURLTotalFileAllocatedSizeKey];
            currentCacheSize += [totalAllocatedSize unsignedIntegerValue];
            [cacheFiles setObject:resourceValues forKey:fileURL];
        }
        for (NSURL *fileURL in urlsToDelete) {
            [_fileManager removeItemAtURL:fileURL error:nil];
        }
        if (self.maxCacheSize > 0 && currentCacheSize > self.maxCacheSize) {
            const NSUInteger desiredCacheSize = self.maxCacheSize / 2;
            NSArray *sortedFiles = [cacheFiles keysSortedByValueWithOptions:NSSortConcurrent
                                                            usingComparator:^NSComparisonResult(id obj1, id obj2) {
                                                                return [obj1[NSURLContentModificationDateKey] compare:obj2[NSURLContentModificationDateKey]];
                                                            }];
            for (NSURL *fileURL in sortedFiles) {
                if ([_fileManager removeItemAtURL:fileURL error:nil]) {
                    NSDictionary *resourceValues = cacheFiles[fileURL];
                    NSNumber *totalAllocatedSize = resourceValues[NSURLTotalFileAllocatedSizeKey];
                    currentCacheSize -= [totalAllocatedSize unsignedIntegerValue];
                    if (currentCacheSize < desiredCacheSize) {
                        break;
                    }
                }
            }
        }
        if (completionBlock) {
            dispatch_async(dispatch_get_main_queue(), ^{
                completionBlock();
            });
        }
    });
}
- (void)backgroundCleanDisk {
    UIApplication *application = [UIApplication sharedApplication];
    __block UIBackgroundTaskIdentifier bgTask = [application beginBackgroundTaskWithExpirationHandler:^{
        [application endBackgroundTask:bgTask];
        bgTask = UIBackgroundTaskInvalid;
    }];
    [self cleanDiskWithCompletionBlock:^{
        [application endBackgroundTask:bgTask];
        bgTask = UIBackgroundTaskInvalid;
    }];
}
- (NSUInteger)getSize {
    __block NSUInteger size = 0;
    dispatch_sync(self.ioQueue, ^{
        NSDirectoryEnumerator *fileEnumerator = [_fileManager enumeratorAtPath:self.diskCachePath];
        for (NSString *fileName in fileEnumerator) {
            NSString *filePath = [self.diskCachePath stringByAppendingPathComponent:fileName];
            NSDictionary *attrs = [[NSFileManager defaultManager] attributesOfItemAtPath:filePath error:nil];
            size += [attrs fileSize];
        }
    });
    return size;
}
- (NSUInteger)getDiskCount {
    __block NSUInteger count = 0;
    dispatch_sync(self.ioQueue, ^{
        NSDirectoryEnumerator *fileEnumerator = [_fileManager enumeratorAtPath:self.diskCachePath];
        count = [[fileEnumerator allObjects] count];
    });
    return count;
}
- (void)calculateSizeWithCompletionBlock:(SDWebImageCalculateSizeBlock)completionBlock {
    NSURL *diskCacheURL = [NSURL fileURLWithPath:self.diskCachePath isDirectory:YES];
    dispatch_async(self.ioQueue, ^{
        NSUInteger fileCount = 0;
        NSUInteger totalSize = 0;
        NSDirectoryEnumerator *fileEnumerator = [_fileManager enumeratorAtURL:diskCacheURL
                                                   includingPropertiesForKeys:@[NSFileSize]
                                                                      options:NSDirectoryEnumerationSkipsHiddenFiles
                                                                 errorHandler:NULL];
        for (NSURL *fileURL in fileEnumerator) {
            NSNumber *fileSize;
            [fileURL getResourceValue:&fileSize forKey:NSURLFileSizeKey error:NULL];
            totalSize += [fileSize unsignedIntegerValue];
            fileCount += 1;
        }
        if (completionBlock) {
            dispatch_async(dispatch_get_main_queue(), ^{
                completionBlock(fileCount, totalSize);
            });
        }
    });
}
@end
