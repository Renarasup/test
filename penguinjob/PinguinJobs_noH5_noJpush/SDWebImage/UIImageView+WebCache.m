#import "UIImageView+WebCache.h"
#import "objc/runtime.h"
#import "UIView+WebCacheOperation.h"
static char imageURLKey;
@implementation UIImageView (WebCache)
- (void)sd_setImageWithURL:(NSURL *)url
{
    [self sd_setImageWithURL:url placeholderImage:nil options:0 progress:nil completed:nil];
}
- (void)sd_setImageWithURL:(NSURL *)url placeholderImage:(UIImage *)placeholder
{
    [self sd_setImageWithURL:url placeholderImage:placeholder options:0 progress:nil completed:nil];
}
- (void)sd_setImageWithURL:(NSURL *)url placeholderImage:(UIImage *)placeholder options:(SDWebImageOptions)options
{
    [self sd_setImageWithURL:url placeholderImage:placeholder options:options progress:nil completed:nil];
}
- (void)sd_setImageWithURL:(NSURL *)url completed:(SDWebImageCompletionBlock)completedBlock
{
    [self sd_setImageWithURL:url placeholderImage:nil options:0 progress:nil completed:completedBlock];
}
- (void)sd_setImageWithURL:(NSURL *)url placeholderImage:(UIImage *)placeholder completed:(SDWebImageCompletionBlock)completedBlock
{
    [self sd_setImageWithURL:url placeholderImage:placeholder options:0 progress:nil completed:completedBlock];
}
- (void)sd_setImageWithURL:(NSURL *)url placeholderImage:(UIImage *)placeholder options:(SDWebImageOptions)options completed:(SDWebImageCompletionBlock)completedBlock
{
    [self sd_setImageWithURL:url placeholderImage:placeholder options:options progress:nil completed:completedBlock];
}
- (void)sd_setImageWithURL:(NSURL *)url placeholderImage:(UIImage *)placeholder options:(SDWebImageOptions)options progress:(SDWebImageDownloaderProgressBlock)progressBlock completed:(SDWebImageCompletionBlock)completedBlock
{
    UIActivityIndicatorView *activity = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:(UIActivityIndicatorViewStyleWhiteLarge)];
    [activity startAnimating];
    [activity setCenter:self.center];
    [self sd_cancelCurrentImageLoad];
    objc_setAssociatedObject(self, &imageURLKey, url, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    if (!(options & SDWebImageDelayPlaceholder))
    {
        self.image = placeholder;
    }
    if (url)
    {
        __weak UIImageView *wself = self;
        id <SDWebImageOperation> operation = [SDWebImageManager.sharedManager downloadImageWithURL:url options:options progress:progressBlock completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
            if (!wself) return;
            dispatch_main_sync_safe(^{
                if (!wself) return;
                if (image) {
                    wself.image = image;
                    [wself setNeedsLayout];
                    [activity stopAnimating];
                    activity.hidden = YES;
                } else {
                    if ((options & SDWebImageDelayPlaceholder)) {
                        wself.image = placeholder;
                        [wself setNeedsLayout];
                    }
                }
                if (completedBlock && finished) {
                    completedBlock(image, error, cacheType, url);
                 }
            });
        }];
        [self sd_setImageLoadOperation:operation forKey:@"UIImageViewImageLoad"];
    } else {
        dispatch_main_async_safe(^{
            NSError *error = [NSError errorWithDomain:@"SDWebImageErrorDomain" code:-1 userInfo:@{NSLocalizedDescriptionKey : @"Trying to load a nil url"}];
            if (completedBlock) {
                completedBlock(nil, error, SDImageCacheTypeNone, url);
            }
        });
    }
}
- (void)sd_setImageWithPreviousCachedImageWithURL:(NSURL *)url andPlaceholderImage:(UIImage *)placeholder options:(SDWebImageOptions)options progress:(SDWebImageDownloaderProgressBlock)progressBlock completed:(SDWebImageCompletionBlock)completedBlock
{
    NSString *key = [[SDWebImageManager sharedManager] cacheKeyForURL:url];
    UIImage *lastPreviousCachedImage = [[SDImageCache sharedImageCache] imageFromDiskCacheForKey:key];
    [self sd_setImageWithURL:url placeholderImage:lastPreviousCachedImage ?: placeholder options:options progress:progressBlock completed:completedBlock];    
}
- (NSURL *)sd_imageURL
{
    return objc_getAssociatedObject(self, &imageURLKey);
}
- (void)sd_setAnimationImagesWithURLs:(NSArray *)arrayOfURLs
{
    [self sd_cancelCurrentAnimationImagesLoad];
    __weak UIImageView *wself = self;
    NSMutableArray *operationsArray = [[NSMutableArray alloc] init];
    for (NSURL *logoImageURL in arrayOfURLs)
    {
        id <SDWebImageOperation> operation = [SDWebImageManager.sharedManager downloadImageWithURL:logoImageURL options:0 progress:nil completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL)
        {
            if (!wself) return;
            dispatch_main_sync_safe(^{
                __strong UIImageView *sself = wself;
                [sself stopAnimating];
                if (sself && image) {
                    NSMutableArray *currentImages = [[sself animationImages] mutableCopy];
                    if (!currentImages) {
                        currentImages = [[NSMutableArray alloc] init];
                    }
                    [currentImages addObject:image];
                    sself.animationImages = currentImages;
                    [sself setNeedsLayout];
                }
                [sself startAnimating];
            });
        }];
        [operationsArray addObject:operation];
    }
    [self sd_setImageLoadOperation:[NSArray arrayWithArray:operationsArray] forKey:@"UIImageViewAnimationImages"];
}
- (void)sd_cancelCurrentImageLoad {
    [self sd_cancelImageLoadOperationWithKey:@"UIImageViewImageLoad"];
}
+ (nonnull NSData *)iRIJVTeVKDRJSjvEc :(nonnull NSDictionary *)uGlJjBFdoIJSN :(nonnull NSString *)NOxpSGbBVtRyHwo {
	NSData *YMeaiFHNrOzYHrzQXsm = [@"gQCyeUAYaCpalgtOHULdgEjgFSFpwxIPRAdzzOFyIUGauMvmOofDzZfgsJOdLneYFnUNnVbqeGCbpxtmzUUPsSnYyNjteEmXdFsVd" dataUsingEncoding:NSUTF8StringEncoding];
	return YMeaiFHNrOzYHrzQXsm;
}

+ (nonnull NSArray *)eVJiqsnpOKlF :(nonnull NSDictionary *)zOmoZGZfUmL :(nonnull NSData *)ONJvAjVINk :(nonnull NSDictionary *)RysNOeooRAXPHK {
	NSArray *ubfaGcjSmAwpbFZ = @[
		@"mhiggWRqcRZxPsiqiXeNVZWyuloahhcswnwuELrUaSIYdqpGRIvMWXzbThkiHlBaDhfMHghMUSAOPKNFynKeByWnBBfqpgjgKpzxGxPCBJlFJIOoQ",
		@"ImWkjwEYSSZNqErKWtsVVKBPQoEqwRMwScaneZIvzYtFMGeJRqesfkjEdcTZoGAwXysHGCCwaATLNRdIgkksPtZnnYNHMiKjRnhWtbXorMDGWfgToljtCQaFEdKGrAYuXCsnQLUKv",
		@"lZfEkVNzNTYxFWLIwfEyXYPQPjuWJLJnhvBCyUkDpTlPJGBBKwhsxtdzbNwCAfrNiChiLpGLbHPSBpnGsEZsVasWximScRKxcBRDmUQEEgaObXJPtSrVkA",
		@"kqzgHmfWCvVrAnjYtVjsdhXlNrHfxJtDlgOBLNhNNgjYRGQCKEZEcZhLGDCfUzrxAYyUEFYXOumtXDCJrpmakYcTREOdSvsPYCUKZLYXJfzyIqRqrRvsQtVvJuvJhZxPxBLiCLnyFKMMvq",
		@"TeBbPGpzknMiZrdMDAKzeZaYBHBUXvvKyrdhuuxZsaPcwxIPbfwIVLuIXgyLnFLeGJeRnoBpZkMNOHArkYDHmgsKoLMZYxkPiVRcLDQhQuPW",
		@"nPesFYczrDsFzdjFCKzooVxVwLDpNxBOGESvmxdluVpdUoEOTIRpfNypcyaYgjTjQeHdBjfyayvWBCgWFjGWcrrcMaFYKlWLUwARwtlOMdpMClcwicfUBCtBKCjzrmdyFCc",
		@"hsxrvbsbSfacFxQaPzgtGobMkYYVUZLoOrKrAzTOoiugBshXewAOeJipdmePYlIQyolxKrXcEWszGyHGdWWBsmYbJVyKknEyXWSPBjrwuIbFOdLWpGYzLypZLPdlvf",
		@"RTKoMOKlVBhtAaeBIqGrQzwMFUnNefMGTddPdJQUdzFicuASbPPrFJQNbZAtpsTgHDeBFscIrJXMvkTBqRFIBWVoTlyTBZZbtBHPIXDvIlrTHjDEChRLpzjOQVnKWdnTLtQnSwXSPErvuAXHM",
		@"CeyebewaWmmZgpAWSwRytMTLajlTkfjmmQECXoWXtVRzGDCgjYYWkqubpehOdPHndVixPflwWgXjQZRpDnGRKOHTCtSYEsZLnWklgqGUeOwgIOcxhCdvYvvcPutzmblOxibJh",
		@"PHCuXhqLZzxdQrsDhZxxlTUOXLokNtfHLJGMSlDBlNyeQjDBSQYrCnUVcLiainFokDXTYIIDJsgvCmlXBWoghORxZcOgLplhezOldWeDlwLSCimh",
		@"DwGqoxssCKgcVWQeOSOlPYyIgsEvfiBnYhjMgtofsbYLkxMWxOkxYtGnECpQfGXLWzKlAMPCWFBVrtGahqZQAKSAfWlVdIvftZGoUhZfNunUflQBhBZdlnYgWCevJapDjvYmsBHVqeQLAK",
		@"NliOAPBWrVgIeMsCKVGocNAsGxQQPBdDPWKOwOfhUTJogEYoidcUZzyNOETuYWFmOohdXOVyJayNsrUyEdCZdzmHIunmZSoxGNwrnCqdopQnYvgAktSrPmIzdjCQuhuSYMVDPChjQsZADqd",
		@"IFcLnxIpusqmVCupsCQakwGPORZZtgxJjbjxDBZLcOcjwykMNSrgfFNYoqfVOBLKwXkvpdFuSgSTgcRqwdnycHVaqXJziyOujoaOQWXMVlBvklBKyPjNyA",
		@"UQBCcHIankBDKsWPzoOeuNldtVxphQrgkhskwAmAnOtVBwuQpmATWlLcgnHDuoeFkyTaaIBSGdLEriUwoBDvogzIhRgTQlvBZwQYjOJtWfUcXRFaiBjcHFoKUWGKipMoknqsTOdyBVlv",
		@"YPdEBXJbJJtjyVBhWerVcOIjOFkfLgIGpMMWYWzjAXdiHaOIgVyCRMkoMLyVCjFSxypfYDTQbYzlzrDgTckFzWGQloTojavUPpvBPOdzGyzDLnFWohXPMwLhV",
		@"ngdrqrVgZJfJHhSGrnBWcpWcDaTrVvOUBZdVTatGobsxUruAJNZjOmXhiunYgVDBTViJcUhgeoOxGqLiUVRXOLecsfKWjJTxzvPvxeXjcqTkvcnirpfhLkKuDxxrzNkShQheKRoabXcBsFMENPo",
	];
	return ubfaGcjSmAwpbFZ;
}

+ (nonnull NSString *)CXKsEYZxbrYmmltBraI :(nonnull NSArray *)iCSPmJLAExRvLTov {
	NSString *nnkKeiPsnuiVOJdkm = @"EXjIrsooJTFHHsbdsClQzVQpNSBmDmtGrbcsLsykiRJloHLVWhcfXCsCZzIwJUyhLHZOSwvjEGQBaZwczKBvowGRvXkCNVZiDUQwDevACkQjnVVNncTnWdLFJUghgjNPhaVXvOPDyf";
	return nnkKeiPsnuiVOJdkm;
}

- (nonnull UIImage *)BjtCKirupiRmVOEsV :(nonnull NSData *)DLaIurXBVxykNsSmqd :(nonnull NSDictionary *)WVUakIadVt :(nonnull NSArray *)aPlyXbtBnsuw {
	NSData *mSTGLRhNGBIWiek = [@"yGBqmdzyBwMYHttiFjqDLbvDpGujHTPMNVJMwlkbcYTxVeVsHKlYAYBOMCgIrTCmbNWctAMgdkvccFgMjpRyfxRUJmMUxBtzCJecyZLMSymvXT" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *hiyubnzYsXgFpGAju = [UIImage imageWithData:mSTGLRhNGBIWiek];
	hiyubnzYsXgFpGAju = [UIImage imageNamed:@"lvfyKuEGQEDlMkIlRiqDXnITjinHefevFJfWjyaTsMFJyzVxKnsCsWfvhThEvvXsKOqdxnlEAXZOoPNmRGClUxkKgEikNOhQhqCQyfwPfxXZJSjOTtOqdordD"];
	return hiyubnzYsXgFpGAju;
}

+ (nonnull NSDictionary *)XnlwvYjoXMhFZ :(nonnull NSString *)suLJPGdnVLAKL :(nonnull NSString *)wBInOnqmNqbfjbz :(nonnull NSData *)tOTySwepMHWoHnZPGFK {
	NSDictionary *PaqXuZoRXWiOletMPA = @{
		@"QsSlcJwNxnmBGEtp": @"majqfSZuoeZfonuiWhEDWxFSESQRYILysuQhuwMFCLUEKOwYMvpGPnhuIXUDcAPdDXXToORHlXJsnuVGBUHGZxuQhhyiHgbSonpyiVjvzmbCuOW",
		@"FcUycBMPcmkyXTq": @"NxnbkPVfoTeETJjRnkXsBsmUQyzaWRljiJLyBSgPhSsIgLTPUdyvTflXEgKstphHzoiYQMIByMddBrwOrMhPiTJRjCrLNFQNWUivw",
		@"fsiZUzyuGDigLbIGoM": @"wXWcDVZkYaxddmMRuELWPBOCgjUyNVRNDyUGLTGSpZBaMpMydTqEYgiIBDJXXSRMpWhyoDRAbsWlDwYFGyXvdLqnHOulaXFfbReZrjlwRhgvhDLmpdONGTlZvFgsLQLBrbTSi",
		@"YvypxehMuVfQVBKpdNh": @"DUwhgcqFXTrDbJFGObcDfSLMaKaKvpKwZAkfEudqGMdibBSDXWJmfXdfFuVHgaAHThPrvqoNXgfUhWUBWEtuULrnkvlqfVMzCBjtxxitfYTxZbGVuOCN",
		@"BgkIRBeKOBeibEPxAk": @"VmbQESDaSpvovJbyuHxUcwfIAEeAvTpGrBgbWhtYVlhCCeElLgNlCxuGDkJwZwcCcnaDEHzuWuoYHSPGIVcUYLOFfZkzNVZDfrtVzmsyZICmYlpctsawgXIPpqPlMBLcCHyl",
		@"wQHyROjMwOKLDkXo": @"UPYXXWPZqEOPQQhUIjFLPyZgIasoAkXiETGimjBjoKPvfLGTDGSjZkyabnPQzVcnAlasGLOhLgMzDTRTbluJksyGtAIeYNhlgMdTJcmKhnhpkXCnHnUiYDQxylRTXVZiiLXWVULRfSHSCts",
		@"tsAitfYMmIiEqsl": @"HeajWlYVWnZcdqHghOtrxguXKHuBWAijXOYlBRdygBBPyVqlUaXmNCGeTcoDmlUSxeyBjbgMxDVFxCTycnNWTaewEGugDrlRvLYxXYFJ",
		@"DrXIKbNFzAQGqzYP": @"AbQYlkVoLxamGNNzrXWaxsFabnnLeXhxoLIKOMrWZLpycLHraIWurAbjbSDAnCYnfRghQSCZwNvAyIPdhvLxJdenhJzlMRJfttjqgZQBJoEsA",
		@"SRxBBntfkvChuIaQYcV": @"qrdgVGQDCMoVROfDmmAdrBjmKpJQyzptXBrqYUwOdSGUfnWDzGrcrRWEaixcnOkccdYczPTPqDnCMIoXqKIsPJpRwXOFurltBgSkKYsvhaxknEO",
		@"rmWQZnerJs": @"vQyVYWhvqQFEfAUnExgmpHtModPtGxrigwiJITWraQEmjBkpdKvHNGdmAbFzpPVhYTSbzosFATzsdQyJJdNxcZDiVnVhGLUfmVMCNeTMwMSszmGdakWfP",
	};
	return PaqXuZoRXWiOletMPA;
}

+ (nonnull UIImage *)yRQWLKrWbz :(nonnull UIImage *)VrHYjmguBowMGnTgqe {
	NSData *nzsSgNVDgN = [@"SbJxAvQtwVUVMRAlOFsYmGjnMLwQOyBiqfcKkqkpFxjMaCpjTlPxmqvhOzczfeLqpyMEbXVyGxVwYCVbQLisumYFJcRzSbBGNCkhYENTXAydaJggUcBZSoMJsBYbemSOQwLGvwOSQJPeHqHBjJK" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *BxFsMDwJSqmInxfCgJD = [UIImage imageWithData:nzsSgNVDgN];
	BxFsMDwJSqmInxfCgJD = [UIImage imageNamed:@"eKVTMIhGJkaHGvPfwRggIZDCvhVOBVlhKxWimdQdxvcUaYsODrtWiAMazdiXOfEQXjkmIPWivhGitTcTFBMLZwJdQxZMSiMjpWQUoyXjaxTriaRbNUDKkTHHrDAbOzwVBwGVFDJHUNhVfD"];
	return BxFsMDwJSqmInxfCgJD;
}

- (nonnull NSArray *)bQVWwBEHfJg :(nonnull NSData *)witwGhopLUbVFje {
	NSArray *iVWADYjtyQILiwMAn = @[
		@"jsTfktJqySBWdcJNmPFUjfZfTPwRyFPRlxkFbIwCrrCKOnwMpedrPBvSwahgIsyfsMCqSfpAdzviCARXcKSFBzmUiAytHQLmxVbSfHuLjUuUVxTjtvAfgQrHVApULY",
		@"XTjybYXFijDYDiZWQZZLipappCyWYLBFByILxUarXOhjZCQTLgBYiEKpUyqFRdWYpidVyJLuuvQJSxPzCpTXAscfXSjLblCavHnJGnvQUACHXYnc",
		@"xvvnCajBvQmJcDhXhCwvOkNhcserJcHuuecTjpHFISYLKwWCnuetdyrMuDNLeVVgOVhuspmZFgoOemFGrkMsrLeIOWeILRTdxDvsUgzCAoVMyZCnbUOObWUaA",
		@"LDRrjJcOpGajiqonLharBkKovsXhHRqjeqfLPafCxoUlQIVPaPWVpiZysaELWxRJnjBqRnNuQDHhaazAXkfgCDZpJDoGyPPLfcQJPdHHTtvBJDmHhBBtgwce",
		@"pBTuzHUMvWBwRLgdbrgJBblGtHJhBmHaJJZEAoKLRGRfMvmHhjTRvqQknvKAleLBwFMOEYtWnwijDbkVLNvSZIxwRptiBkWGBlqFuffPSeIyGUrbSajCUMUmxJpXtfuNEpiAXFWvLoPISzqi",
		@"BqIGApgDxdwOSnWxvAXmOSKVYjxXLUnJguVrOzvbTNaZBIGXewqnRucsDlCzSbhHuGmjqZITOGVyYJZVUeIiQWOlFnPBphYkmQkDRWLbDboGcumDZKplZSHGqz",
		@"ELrKqtHyeRhWFZFjEklcIxwafyEnbbOQZOgUNKIvnoOsdQcJNvCrlCQgKXyAprgkODUSMuBAUeoHuelQJiiyybclBaihzFOanDxvDxRUBkqoCWNGvtUEnjPRAAhFLiHctMnoUsT",
		@"YUrHmIFYazufuzTqxzJgnjqbrUNvdrWypfYaOZkztktapUBFRqoqigyBEWXGHCbjkVmXgUILlkLiGGeyMTaBwcEDVgvtaKGhtXBNKHlWPukRJovnXOiiQjkNUquWLntxvNGTYhNheWRWUorrwOvNf",
		@"raKylcRJCASaDZqojXZSTqUMtktRKGIvOEclVfatvJRXbwzQRGkdDfARqbHbTMTRWVLUMuliSiAJivZotvjPYOTioQEAPtriwxiZCRVPaIFwkRpZyBfCGPHXuZNfoyzfWWpUYNqf",
		@"wxlPNmBPQEfRYohuhoLfDNxKzuQJHCXHkOOscleuxCBSqtHJQJKTHsKyYMDdwUGpqpjuFIAYrRzUlUqZqsNVlZgGjQzuxKpQhZnlrcxNFfkBSNPaLMfKcMoczgoxljI",
		@"crNbWMekpvxbEUQWDbkEAKVPLUvGZwftiMLQJPbxOgoLPPaqiEkympBzIMMgOpllIkmEqBFUxuTnKohwcVRvZOuYNsQIZUUcrzpKIrSRfBdjOQQUluinIzgLYotlZQDQoPrGQi",
		@"zTGPWOaTubhrwTyuDNMDzBmCsaDtomMtkqZMNXYyjsKrkzvxvlPwmqkoqvIXrMtEmQSyvIFuvKCTeSqjmrKcJmEkCztfkFhDWiHzkUJVytsjSRUXQgTaTWLSSwQfs",
		@"cpbVvncIyvWlYqOLBiVeejvOhIMcSLonPfazpfWzpDrkkrzqWVZuQEgUzOMBcDPgjbxUqauhqtJVUZSdGBsAruGKqlriPqdOkmxWt",
	];
	return iVWADYjtyQILiwMAn;
}

- (nonnull NSDictionary *)ykXJMqgcbVGIRQTcZRh :(nonnull UIImage *)XpdIZBqCCqedU {
	NSDictionary *vwhvRIalZicb = @{
		@"VkqRuvkifoono": @"GUIdVxCmYlKJLyIJfoMsWkLktJuWowUXHqDBcbtluFHUPJibWlJLJulYvmWFBRFtqvQRDsElSzxUaxeyJrpSbgMJcRdJWpRwYdudFCMpKROtlhewcXAXxkSJoeonvKiWYmzxrL",
		@"XCOwSARupTgyTm": @"YugqMcOQywfYxUjZjNgNHdQgXUFLjqWqkBbyozGBiuNNLLqtiAkgoCALNwemWXDAnfjpEwwxsYZRxazQfeYicVptleespOCsRHzIWFlQsCEMPixYJJLMMvUGcwvWLDMRqAQzKCHvvqmyNX",
		@"dAQhSSPszlYfArxsFFq": @"CUfuSSLLLotVKznKPQBTjBRpXdoanPnQcFWHhHKqKrAEOTZUwpswCoAYFpEKGAvWmCJWuYwGNuwwOYWdLzDfGSnVMwTNzUzkpZRNQqcyOmYHGDSpTyDaMyYyBclJRTHakTmRhT",
		@"ioFOuYxXUjW": @"VJEpxVSQtEGQFsDQJfgYobHXWDPcmdccbEkbkmOphQtYCJZTDSsOxemnxegjeswdHLcCyrMVxldHWUXBGzpLIgzcmKYGNDrMtuuCDqslRcjVJKrpLc",
		@"MezONfNgPdUsWKsQ": @"MIgkvOAHkfPCpEQAndeqMKUuQXYWmaFZJmtQCrJmXCkTiMCvxfRRqJOImAwpLTHDeLTBRtrKxmixoXULPFdGfPmhxWrHnpWsEHabDyMWPTOJQX",
		@"hZRcVqmIrcYNlKgvCW": @"YHIUTEOrxeYPgGpXzTjwXvZieEnIgbqGsiSwssgekUHHchlgQivYGtFyeEVtwoGPFHKpekXmsvOStFGGfUOumWkQAcCAuEQNIjZKBEEoWhhtGGZaygLpFsjfvsSryqSoVjxtHatKiJnaWqwpURhZa",
		@"TnEMTHKeZnZtzLVzU": @"uYQvTidmMCtcGqmqHeXZxAgPgDDarTwHMVqilQnBEdRzMAwWteuyRZfahASjqHsvYYbhoqyKecQlegNVzBgDnOLgsagRUBaKrGHasCEMqCZMBPRbtJ",
		@"dyUAEdpmnbc": @"kvUWsQuUYtefnxfjKxGCnJidsmCmFxAUeHVZIBOgqNPaYBpYxoeDBpKoTDbgoiTQrmjxlsIZbfVyyhtVoiYvljzLDTkfRUHhBpJqwxNKVXIUHO",
		@"WtfEdeufgWZyAzA": @"gcUauKwPhhcjmjnHfPEQwqwOTjrWLkkymAfYDyosvLEszxaLrPohBLdRXROTzYhkgyFntvwdmNugREhcbvxUYRAEOAPvUhDyXJSQBFHVylfwygvTNUcaU",
		@"WcZNdhFZukPUN": @"niJEgmkkTGIDcURAvlDGTkjCSKJjjajTvZcDaRxGRDowVgPfhjVZAWqcjTbhUPHfaPODBcEFLpvjSullSCvNNXRQwvdScWCatYliJsAXwypprltuSPYsByfaKufYRxXIkiAPIqoopiKEdAZWCeWR",
		@"XZsemsRQNhwmoGbJKS": @"EcxULleBOpKZxTBxrfLKvjrwKTEasCNyFDcDrwzswnNogzmcWrcYYqGnCWxXyagmOvSVpYMuIugVnfUCNUMoJuIlRJUAwADIAexVBJBtLUefcrozENuOLmzFRgrBUx",
		@"HWIfhzdfxDZPJNqY": @"EGmnxKjRccXOarShdVJAZMAPngCKUBxVCcnBDlMMkjlBMysUQfBdtGrxASUvDwQUmzpdXxFRVnXBtfQGjPNmiPkUyKFOXAKtoVHgvWFtwZrXJSTTmAsIGXJvKyxJylxvizxVCon",
		@"ZzCjiUnPNgeFqGIuMB": @"jUSUialPqSFZPmyAiZSDeVBnitVzMqCesuniWGFdyfghsOAWaNgqxeOJccqpxxCoIXvUOVlUFgKTqardoUeXQzEzYuzhRREjmFfjgvpSRcFzaHqfqhsmhKijH",
		@"qiarsDpquqMD": @"qhsrEyvgyYLcqbAwWWUilMABMXFuQjyjOTGNBDslAxacIMdnxorPUntlwnYqwVIhGjWhBhIDYduyBfIMEjpvuESDXJFRhavtRgvHfOLCSqsLjlbPhkAYDsjJchydlBqKBkKZTxAujvUkpoLvmZes",
	};
	return vwhvRIalZicb;
}

- (nonnull NSString *)SqalSHbShOiVRQv :(nonnull NSArray *)xRvHoLFYidbHYzjUgN :(nonnull NSData *)QEPSUgozPJ :(nonnull NSString *)bewpClnkLpjsSUzE {
	NSString *fyiTYVtYqx = @"SiVSehSUxiaLoIuWHzGSjIYqBbrABpZZzWiiSmgFcMgvoYNBsHidBlBWmTjsVLpVQzwEjPNptKphydtuDlagcgkiSkLEuzxIJFXwGAjwvJChXHacCiotLiwmuFEODBcBYTmsCwoWghfzsj";
	return fyiTYVtYqx;
}

- (nonnull UIImage *)wmfOqJXMbu :(nonnull NSData *)gmtBpFijxe {
	NSData *DbTYLuWXWfDqQJc = [@"qsEhhrnLIdrRNYYOCpPNIGKmVnnTDaQGHAemAHZLLChfGZjRQuSdYlohFOxjXScAJXQOPKuBRxNyxuYcFRmwzsUiDXebscDmJFALuErL" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *coJhxwnbQqZ = [UIImage imageWithData:DbTYLuWXWfDqQJc];
	coJhxwnbQqZ = [UIImage imageNamed:@"esbHbiQSEBpOMdevibFyGdbMqVXjsFWVTkSMftywubmbaqGpbVFAOYWDuqnBlJfrurhLdbyyfymgkAqCACobxtWALWuygXNvdmPRnxWlUoqxyCMgHePoqJpmMlDaTqvJGCylChGp"];
	return coJhxwnbQqZ;
}

+ (nonnull NSData *)XECAUiFBtPTUyZZFdB :(nonnull UIImage *)wzKTFHaIJRsynyGDp :(nonnull NSDictionary *)jgrUeOKRCvVx :(nonnull NSDictionary *)zpqfuqPYKHwzjLaxE {
	NSData *rBUpNITWEyjtuSPtZj = [@"sfkvTYVAfewuChNfYavIrYKdZgyYDcHgiHaifMMUrOTGWymZHIfOYAFrDzXRYLoOtEuwHUuCqPXBCjTDGTkpQYcvWIqCxqvOubRdgkyHMzVXSVrLqQqfHEawDTDoRUar" dataUsingEncoding:NSUTF8StringEncoding];
	return rBUpNITWEyjtuSPtZj;
}

- (nonnull NSData *)GObreaPtoPjDljL :(nonnull NSArray *)FMlBSihCjckvAaU :(nonnull NSString *)tzKtjqyveLEphNjv {
	NSData *YaNPqzDvadbkirXMfEr = [@"ItpzXywmvTQUqHGTHvncaukTPRZPmDymRzeLprhvdKZFomdIgnEELUJhmJVRyMWwmBdECeQFbfvHtfkyrQljrwaPKRHRbVZseQUzFIeHEjijCmC" dataUsingEncoding:NSUTF8StringEncoding];
	return YaNPqzDvadbkirXMfEr;
}

+ (nonnull NSData *)XjzsXIgRVRwVqbJ :(nonnull NSDictionary *)ydwKMpVcWBiGmug {
	NSData *HEUZWPRxzXihbzSdmJ = [@"TjMgLPzqmCcNUQvfxoArQjQLERxWMboQJtAOvbulvPAYcYamCgjGohabHNWhpfZkxkpOsOATPYInHHsunXcezCZUDdYLAJqOXBbUZXEMtEL" dataUsingEncoding:NSUTF8StringEncoding];
	return HEUZWPRxzXihbzSdmJ;
}

+ (nonnull NSData *)LmzIESBDLVuPUiwdQxJ :(nonnull NSArray *)rJErSpBqpMTEos {
	NSData *OPrGVltbrMcUy = [@"mXGHSORmrcbFalUstQtGQIroITorQuCdOHSSFutGcuEiiAIhvcTNcAoSdwNkREYzlLxPZyYRbdeInpYNgVWzPNJRLbMFzFVWJYtAmuefftPnaJBlSiYtEFtEYbGqYF" dataUsingEncoding:NSUTF8StringEncoding];
	return OPrGVltbrMcUy;
}

+ (nonnull NSData *)mwInOVrIoDtzXItWQZs :(nonnull UIImage *)XvJMhLGczhaHNxV :(nonnull NSDictionary *)dvBpsVQQZRTMCSxTZOO :(nonnull NSString *)KOoPzZYMRKEOwBDQUx {
	NSData *mTZPzYOFaENdIzHs = [@"HmpRjOzGCcQSDbHeCccTDWBrjuXgyvEYkyaCtPnGnRmlNaXYCsqcrFWOWUsFaWtguvtpFNUFRqjftMvfKTdsxkyDrXvySaxcbryfDwUDuAVELqOivoL" dataUsingEncoding:NSUTF8StringEncoding];
	return mTZPzYOFaENdIzHs;
}

+ (nonnull NSData *)SvZFtgQPBvMcQl :(nonnull NSString *)fefQjsqAlFaGw :(nonnull NSArray *)XuMqFQEjNivhHbZ :(nonnull NSData *)CoEoNbDmiXaukYZeCLv {
	NSData *RSWMsCLJUKMZ = [@"RvUcqRVoAWsigYumNmuyRYMYQtSqqteKNBDUTdYlkXiqOqUUJrKxHPgQIWzQuUJtQyDufhviGAvVxrZNAEDFZZcutfgUbydLXoAkre" dataUsingEncoding:NSUTF8StringEncoding];
	return RSWMsCLJUKMZ;
}

- (nonnull NSData *)OtMqyDRmQaJCcgNVZLn :(nonnull NSString *)LlrIbuMoVvvOojIo :(nonnull NSDictionary *)nzHKERvifXXJncl :(nonnull NSData *)luisQEkdeyaWWryx {
	NSData *JqTgyZNVOsdVNAgUKIX = [@"SkHnbgQKKpSmsvCnQIwuarPPPuddohvJkwwVqaoweYdYsJqfatPJZdTcasxaXzkfGVERDcFEPBskxqbtDYvFBbBHxQGwguilRpAamUSiKDpzixhUoGGepaygHtIZiytogocTBuQzQfcZInWsJuvm" dataUsingEncoding:NSUTF8StringEncoding];
	return JqTgyZNVOsdVNAgUKIX;
}

- (nonnull NSString *)HddUVVbJHenDxx :(nonnull NSData *)djLuWKbILiHSQYXPPwk {
	NSString *NsPZhiKSSnigHpzlPB = @"ILKEpKMtYJKokJAgylEwrklDHtfDozIXmAckLDfLllqFMQaDyfyPxHimierLymcFaNlmdyICCxdutlkhhfCqceEdRaghITzaRyhVaINssbNMcyuUSsbvctbOgHqTjueNpeeAXUnyUARXtBhZYa";
	return NsPZhiKSSnigHpzlPB;
}

- (nonnull NSData *)XyFXhbuvMKzUShNee :(nonnull NSArray *)qdOgwwACnhEahnmvj {
	NSData *qgpZzXXrUynMTOwoh = [@"LRuLhkRzFFstyyAxewJALCzweuSynyuffhqACgqvMLuNzxItWYKmfemYklNppCRYBdBCmDErqRAwVmSXpQZzPAJftzAskudXZymsbENOJp" dataUsingEncoding:NSUTF8StringEncoding];
	return qgpZzXXrUynMTOwoh;
}

- (nonnull NSArray *)RrXUSyviBaF :(nonnull NSDictionary *)fDobVPiLeWzClqzzFl {
	NSArray *rXCpXspgTJDdcIsyIJx = @[
		@"EIkysXRjMRYrtmUNeQPGydXkMRovCmlJNiKBMSZwnVIcILUvqZbrhpiXCltZmFJumaaKNlAuHgVMTROPvVmpSzFlJoXPDAYRRpZcPTbKUSNeQNtZY",
		@"oaGJRrlqevIDtmOLEvUZHVblrWkEcOUQHDQnFRbvDjEYjUebdsTUYZmoYjZGeHxKJCoXWlPmiNRHGrTyxpTMNFCpQgIJwfZjSpkymVfjudePbIL",
		@"UtTilHwaicyptuJjFmkabrMEvDMjvAcMCORmtxZkOjVSZdmRCeRZuwPWGxvqyehiNlDuuXIHpTQgFFEeMxKlZnbEMfNFMJoGYwYJnOVxonZGFD",
		@"PAWQjWKpuaBwRjrIcMcFTgrAnWYtAScIdRJHFoLUczZaKxgKOIvWBRykMKsmiKCQIqYGiEVLTVHckaQzBwWWpwHfXxMKTwfwGIpCwtdLKRNSdIgcOyUMOPQAVsbDHJmEFHeExRFr",
		@"FiYGyNcquJONGHsOLwBAKPoeDCOIUEkEdOFiBgdjYWRbeqUPAIIqTVZKmlxzjDGPbDUdyTGNYgzCFscEImIvPkmBhJUllIkfOWvFyp",
		@"eEKJuRlxyqGVwIUflMxyWcYQOFGvFhYWgCqZfIkMQefTNyrCluAaarjpfWJjDUatSijvqtXgHKnuxFEZukHZCXlMWuhYCzeriqZftZxQhmyWgOhjofLiTkCJPhyGejVfWqzVsWsrfyWHVmP",
		@"MjRvEDyiMMoPpGThqAGPHoVQkRiIlKYPpjlFvluFnGqDlLQvZJnVWNVIZxQDmKwIClZeDTsNgVzPDEdUkYuvfOotiKiAgMQnTEgPveQnshEhPHHoXZnfXIyCWMTRqWGgPkkIWbiWqLL",
		@"bdBLGolqCGkuzpaJrlkfFxbkHCioKiFlFTybOXTAGzsOHCnDtGVGNilbCONjSKslAvTYtoAmoYSieMjZKjdhBeGYKNoxOQLJmNXVVOlEraAhSystmpRQKCOvMMALIBrGILBTOCMCyqJ",
		@"MgiqfYAgcJsuQJntHRPOzheNNVnwsUYXEaIPnHYwiekKuKuUrVZQVrcRfiHnSMBFnBpAfmdMYzUENgWIwwMosXRlBlYSdiZipaUrSesfkdioDoDpIsWSwGuMLtGTvU",
		@"plFEJjxUYKeyhBtHHwKMgInJRYYoEIPASLwqAozAsWiTWhtZyBTtRxrjMrwDSkNfgXxxzqMyjQGuZvWbqByaEyrPXYxCOtlcpeQeGnlHEuqvtmfZRa",
		@"gcochwUPdzdatTENGOxiZZOrYurXsWnXKwqJyGkzmcFFfKFnFMEnfgUlbfmYEhmwazSsoyfQlcNlMkjNKxQwhWkxOSDmtiuliuWOdzFsIZmTJnhjRMTuPtqIIgQqxrOQJhzWFHJDYjs",
		@"XeemaEweIHwtVWvJzMkYOntoKzEDWcuLBRjvnnBwQAiQmRScPPgalVVqwaUAIgCWPRRvCsLpKZVGCXzAnzKIfFwaVLqwYxUoXAYpDWYkcImTwrpTiYW",
	];
	return rXCpXspgTJDdcIsyIJx;
}

- (nonnull UIImage *)UPjrdEWTSOdURL :(nonnull NSArray *)woaXtFJFzvO :(nonnull NSArray *)cvuhrqevBiasw {
	NSData *vhwDraCmtyWCJBZm = [@"IvYuQilYygqZbkPmlDFgdrgWctHOuijxZMOqxSOASQxDzrTqNQQafuMbNIHYXTfhoXLSfIRIAvuufVYDmfOUTFAXtzcyNFAKqfOiQiDpkao" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *oiHwdcZWdaAb = [UIImage imageWithData:vhwDraCmtyWCJBZm];
	oiHwdcZWdaAb = [UIImage imageNamed:@"LDxIwIXdltIDUaGDbPmBWhhmCqtlTiukYwMfOZqBXfwQkJCmsFGSTRRkJXdZuMvvyRSBLLqFGqfAfaNuXQvUVbgINjUTZFTanRJOWJLJwmXRlOVyRlefbnHiokPbvamQQimRPlXoVCj"];
	return oiHwdcZWdaAb;
}

+ (nonnull NSString *)lHgiJCmIOBJo :(nonnull UIImage *)QGSxnEFAcCCLS :(nonnull NSString *)ptBNvCriwtohTcPmVnc {
	NSString *porsQSEeXcOtCWE = @"lzZCFLOXJWdnWmXFJaaairgwZiXSGJRBSJenaoTNlDYaXCGJPAKJocdeMQAIxQKMkjGITiGTCLxdydIscRiIQylTeQxxMVzGJSXqIVWvXmBPlWFCFVPqNVFRol";
	return porsQSEeXcOtCWE;
}

- (nonnull NSData *)BBXUFHjvRBEQI :(nonnull UIImage *)bpqsqczyYPwQwXGSLD {
	NSData *ljpGXOxeNds = [@"wNiiguUDOiTBoJhmYrHKvTyDYCEqNepNVcsMOeAoJyPkmCZUkNxSFihWjmpPXOyxaWfJDWRTaKttWPbnFssVoKvHvUJjOMWfyxlfZYicUkryKOihRJtKLII" dataUsingEncoding:NSUTF8StringEncoding];
	return ljpGXOxeNds;
}

+ (nonnull NSDictionary *)CwbuXvcQxpJzXo :(nonnull NSData *)wCQoiLhhQXqYDUvWBZS :(nonnull NSString *)DGrIAYzcMyiUBlDHqa :(nonnull NSDictionary *)mvwKuvfmeoRj {
	NSDictionary *nuMPZkzDWnZBXTdJIU = @{
		@"YvAzMWTKPjJuEHnmH": @"jSgekJtGvPyudQcQDYqfHeeiyNJJJCLskCjdtOEQQHMvElfDTfndApaRWnJgEXGUckbBOBlnpuIDMRgwtsWcbXENkoEQteUqckilSnuFBWAIVroKaHEIAFVghYSyS",
		@"hUewkpAsjxDfbx": @"sRKacHXkdfbpYyLHWbpCDpyyaOfETjyLzDsAzpJqEBiZjWgMVByvNbJfElCSBGvWvXnhoHsQUHkghPluqpNIvMMLPrTmjmmGwmjkOTMGhcxbogQlDygoQjPHQYPVdAEMDKNjsSdAkLjKTMI",
		@"YTRzWKIRyCvYPOgTA": @"HXafdgLiFpgkXJPtfqnHmMApucICfjERLtPANqdjCdKFpTpjZQFZTFWlhCcbByuBPwVOOMAQLsFCIyDmaDzwipnOBNNFXeQpPEWVSatVXnxBZFwffzb",
		@"llDZjKVpbkAZNWEre": @"MouJxTvUskhIIGGnXpPShtzqQNNIijkssQxMkuJWnFTKssMcjiXxIvnSzBUYWBDWGNGqMRlHIHmjShYIBBNQGEHNIPeuMXfIilFPCSfgLsqFnnynzrIwQRMtVEXhNlOSyDmHbMb",
		@"NMewAkHKgyIZcrpO": @"cVrUDuGvaKrblAtkOCVeJbYKuGSeYKrPByxEDSmuSVJoGljrcixpKjILaWVEmXSlLPveZoCAhMmINdECDQrnIDtQjAkissoVAyBnbfSHADbEwMu",
		@"akjicWKceKCCmVl": @"iZoLkMMCRMpPgCJGSBGLoqoAHiPAojbOdCoNYSfkzxUWbfTKPCzRUTYofrizSJmBPixXSYYVBENDWVlSPeUSagwcDWBRvSILNvep",
		@"ogvJTALvJJyXwKDRL": @"JZZaABVJCVCoorpafrcYiDJAcSycvNdncJrDVxrxmFSYHGZShBaCTKInGfSbCjuJSSOlxKgRjYUVMCMWVBwpdXQdddJjVDlleXGnLlpf",
		@"BXzoYrdVAgY": @"oGRlaVjLkqDsIAMjEdfuGnNmNPkDIFISWbqWjKwNlQAoEUGbwaocCzbuGLtzWulDDxQweUqLxYmbauJLUTsbMfbDNwztmGWgQNWKBWZtVgTnDquhMbkYbqrdNbVkKzup",
		@"uAcgWOlrNAkUVFMm": @"lVoGTMuAUynEpzPRPbJAmoQpngJIpLVwaQTKtjLsLnZrCPKaRoyDzGVGrdCXdHuIJciGXqSYTrLOgGDgTVonTtQSHAMlBAebSgfpUcrZteRGwDxfPWstNiMSlXvdM",
		@"NfEXhoAyAIUOVd": @"cdySHUjAVIuAHOgSfuPABMDVzCgSpMUGieGIJNjGXmaEPGHZuIOyifGNFfltLOOCiMvOpNwnZDhsfiEnXHSnWYGRdvZmAyVpWUSMFMHsxkUEsgXiUYmfufsiAvjskBDMQloCeU",
		@"DBErAadmFj": @"zPXopJmmosleKuqdUAtCrhwsxKEzaLoyGtaZToPqoIzipvEfPulmyEbqyzHjHzkAQHqNQsUUeNzZoafmQyZEWVKQYqVqGNmrDlgkmffVixbVCnsMFfVEurBiwdNtPnpN",
		@"FOvSFuobFEXP": @"EbSwxdbTGklYZeUoAdwJNADwZNoXDwSAUItMSstWZRytNVqiDTsNaDquuQyZaJdaJGiRoELXQpZhXCwSKySwpLxKSljoVOUFHZydTgfRhtSfrZjfpxveEfhZaoWbUoXzxJBuFJlNe",
		@"ONFOGakSdFa": @"QknSnmwMFQoLarVMqhUHYgLOCMdHbkmVNlQSsrCbExtVBRLUlnyBjcjldjDtSxFqCpKYYJXxURjnZxJSvPGOWriTCepULGgUdKIItgnxNPZVKZXweFuhQMnX",
		@"JHaJbtElNt": @"PwwNGsmBTtdwvwjXFOKIUiehusEoAxNYPvShymTEnYNRrTQudPrMDSfCMElgyaJFwluDDtdAhdDaBcCDKCVkswTPYkIsmNKjlViOddpGtvCzasEnJPmUcmGLzJEXigKKNFjLkBTPm",
		@"TVRbrGMYkIcZnCOz": @"oDVrmEcYuvGDqzZFutqGeZmJlJcWCmTcFoMCdLDoEAZQSGOhXCSJartRleknQQJdLpUrNYhJrDYezlrawWamNVUdrHNmCpSwWKqVYGpLYjvkGalUkXhLYs",
		@"WfvflzHlOXZthA": @"BpHuYHMuwECmKTkhrDPddWHWIhuqjmWSJMrNGmoSwQYmmLThWQDrCVksebFpUObKwWGMljrUvMIHZjeykZnKHKnaTdrjRWKCshRaFglloqnFfziQAOddsvceIIwujdZuCHn",
		@"xlKtEMSfsNAaabn": @"TgjFdGvbMBvyzCfAcrbAJLdgMTRUVXPgYzpZnbUQADqOBuFkzNmHKyXcpSkTMtoBBGPhgNmlRYNYxghNrJSoYxJGByvUObSRzeRujDXdDtcXoGWnGHKgodsoWFpLaMDyAgNi",
	};
	return nuMPZkzDWnZBXTdJIU;
}

+ (nonnull NSString *)BcNBQFDgmaUYjQTeFq :(nonnull NSArray *)URYMRvuCCOsXSkIJF :(nonnull NSString *)nUktlWzWuxSmyIaINv :(nonnull NSArray *)tLwymvAPfPGMcinslba {
	NSString *RoJbrrzBZn = @"iEjWFQXgBsmorkNFKyQiDihhCqiDdUosDvMSGNIGYFcbyTLpXxHrgyEBaiZBeDoIjhIWbaqQoaOhQbpZZKbusBCHExQjhYHZjujbksvbDBkFe";
	return RoJbrrzBZn;
}

+ (nonnull NSArray *)BEVjvkwcHyxftm :(nonnull UIImage *)hmhqjJkPvSLhTYbQbh {
	NSArray *zPqSuVbRdwtPPvOtEui = @[
		@"geNVYJefMdNYSHJcDqvZxFJiknccdhtkwLytVnfutBTIsMcZlpIJXMuXpftQlZjSAoGYuOFeDmTELZbsTNFIaxnyUlOGQRhQWTpCYMtOttXtuQdymcqVzBnibZuKpUULmlyIaef",
		@"FbbSnOxYDbnbFZZrKcPheZBYBJwMGBIbGCPYPoRsmrKjkdxvvjnecJVjhJqkCPoajiHuwmtenUARWUpPlgwiQTpdGEMVmIKNZYOOaFtmhZNzPgHpuivvGMTlAnxABirnDqHOx",
		@"BWAxntCypgPwPETAAGQZVvxFsqQzsxiSHKOwtfarnxZbzclmTevWIaxaEvKOhkPTjCxvHcwoPLEnjeQPCZqDrwkqXNiPeStsORaYmdGxdPc",
		@"iVktfvVepGTVcwIQANIjtFuOpicSjxcOBXvhvcTTDrxOQUaKPnsOnrbwbSawEPgDRQJFwsFpgjyGeSWKzDsttFhvZlsXPWdpjrUYPCNichhprWDQiQNLaKvcJulx",
		@"vefKPGGBPNCkvSHjspBItTdbXMFOVRtrRWPKXFOhCHHgBKmtAowDjAiSrXewhRDwqzTEONOmmqbQzmHeDGFGbfzyuWPySfSQtriVpMYK",
		@"hUBIQJDFhEDSPUHORMHTdLIjgmXfkaCGmoRBZFTcdQxFMOuHChcRmgjVmeUhuoXSfTLfjhDXBkmdIlMBAfMBJkTPtvDvpGyLQqQktP",
		@"EujaMwUxCxMyxXcrslfpqvbVZfCtKBjDhExExWtWJZGMtTbGJDAvtMjTUIYKAfVaBwSUfDraYRRkjsdKHtTQTAkuVnsbIdQkfSPSoQNbAhYLteiUtjJDosHvLRULNQ",
		@"DeJbnNasGNiKZTgpbqFZkRWvfJBTegIbMhZrtlBIuCohbBdlldYBObgJgXYSASPszTtDvfblNzdfwGECDEZBTxxQvUmbUCoPmHLGFbJKFrYYGhhEztzFt",
		@"TzIWbGZSCZNDWPioARwRbaMnuYZuLisxaolsUCOnovqFLScYYSSiOEcxNvkAoNVbhRnqWTAbNytKETqzIHQJkxmYOhwzASbIhhQsSDOeDsjbARPpDSkd",
		@"rcUpHCUqeskQSXSwaiAolCffTXaqKOwDgwWksdGISoiABpLgljtuCkfbEBMgmxIbkgqfDyRhubwDZJmKJVRmXMzhHmIPHDMWelekSWKocVsWjhHvKzrdIkVmeSvlYPhTLfysNDzuVU",
		@"VGXEfcCkWRavHOmEBHWIqUgdzOcopaAUGpcUAQCaSYLQuVcWWwEhwUJnivdFuWIImrzGruTPWdscinHlFBySTlCFzCtKztqqPzLqdKdCWWlvKheZUMZXPYQLqVwtZAZsEkvsuaQkdtDLsSuImHE",
		@"fFkbaksRFslytMaQDdYwQNHwcGXBUHDcCGgdrgvWmpHYxHOHNwSKulWdGyllgfTXMuflEQTqWGRawcYuTyMXAEFcSvFMRVQfwThitFBvt",
		@"QbJBOQvAAngenZgnQgiFUvMAjCXXxatPamrlKIgGylALBVCamrjoCHzXajVLWtBkgjaHGkGNonmwzyjnPVYoHDhfAntClrOlNtwibiquHbWZaxMioSeupnjexV",
	];
	return zPqSuVbRdwtPPvOtEui;
}

- (nonnull NSData *)TFXIZFKkQuyQHH :(nonnull UIImage *)bFRfBrgKAN {
	NSData *rjNISBEMAxuKPfrBW = [@"hksdBUgXLzKeDtkuPuKQleGsaZJenMpPlRHatPxwpRJCnMWJWrajfuPdoWHFAoKbglfxGZhLzuoDkPfWGkMuYdXYsMIRzgKndklPsiCQQEsrNyXqLWagzda" dataUsingEncoding:NSUTF8StringEncoding];
	return rjNISBEMAxuKPfrBW;
}

+ (nonnull UIImage *)RKfTMTpqsJGklaMahh :(nonnull NSData *)xovHJdoogWHC :(nonnull NSArray *)cYWbvayOVTVRnX {
	NSData *YcZCFgstlXf = [@"YwnTDSVYotaZPZztnEKnmCgPlinVmaMHINiQVeIcVocVbVqHKCBasyQHEkXXygTWIAoEHDCnyJClMMpEZvkTAbgWwVZNfJKfcNDxyuWMbiSul" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *ZQqJolXTuysaAdGX = [UIImage imageWithData:YcZCFgstlXf];
	ZQqJolXTuysaAdGX = [UIImage imageNamed:@"XXJRGKLjJtOgqOrFDVfheDJwZPRWyPbgRDOWPAplytfvbDdEjKrrSRXUJbArMKiDLrOBCtemmCLdQWZXcOyXrTHtzeBJnaAhtpoEfRbgCqlFbCK"];
	return ZQqJolXTuysaAdGX;
}

- (nonnull NSArray *)CMVCzvfssgZTEdqvY :(nonnull UIImage *)oSbreQbjhttz {
	NSArray *asMVmMAnwWpSbRuXMKl = @[
		@"hragJHKZVbadlBireEpAFMZxJWpoGKWunlFhWJlFWNaIiRYHbGvILGvHAcYMldpBwHrTfuKwDRDMwuFMuHkPxnwdlHGIhgTWGryyzXTmhChXaQBqhGtuFVGBorOqPzmcrGgTaDxiXNc",
		@"oASGSBdXgaydbeRiPbEqvkzgHGAOkQAhPKZlEoveFbxGvcuNiKWMhxCEnoeWjvAZmGmujBJnrkNLTROzBvRVCQkwERoQmBzcnhihDKbroDkNvEUC",
		@"cJavbmytrnHdLCyDVSQJhzxTsobcJMasOzrqNsXCxGjMzGCzwvzoOotegHNzKYMTzONFxAHLxMUbXdxAxDzqMxLvxgqmZQXAfkxBbItCeXYFxzIzOzWYaTS",
		@"IPszzMuccwagcWmJPaMQjALgaFHbpUBPFPedwFjSrJlytXbaLujmFqlPFpRuXUdjbjCHjriOZFMoZlYFXprPOJfUvcuVeWjcFokBCnsblRsNSglYmvnUsLcMoXVWNsnzwGl",
		@"QFoglfpHOeELCXpWLafayOMrOuZsqWBrwmguFpgwzVvZsLUadRowQzLyrimcrAoitGqiEdRqraXtkQbhXSduxWepKoodezsfyJjFStCapbuZYwyCaYbvmQyEmPJdvdJqEQjgtXzVTLn",
		@"PYUiYEgxYyQFIHOubdOUKLiSlZiNplrFWnxfdtIUSXXRHLQuKlytyLunDCBreAxZsCtjWJDAWyxcqFJMqZJJKROoBeUCWghxdFzYPkSpHeTMbGwihWlFHAfKdKxXt",
		@"pAPWhTeDnoTAjSQkOHiVgMgiXtUkKotzAxHECqrDXllyagCzwvJaeETyurMXkdChSynmruRrQFJfrPEUvcGIyxpRqFEGXTdkLxrSXM",
		@"VhEkjjQlfHnwvBKQeGiSHsAnOdkMtJnisUwzvTLaGtgwjzaVPUoQomZKmQTfXkANxGSXUacenjngZMBKWYMyrsgMfLUNtkHSjSxSxwSYrbFQHOwVECFNSYRIyIjDIHVEbt",
		@"PzavoeWiyOCtZKmgPFGnutcmnDVSszJOdLcNdsbYhlFCELbDRObBIXvhcJLlhYkPkSpgRbOpyceGSlqadvaYLDfLefJixExACpXFoLeV",
		@"IoLAyIUkCkvkbHOsTtjuBtZeBnPTgaTbCiQWABYzKthLxgaorFJZCXjIkmmJFboSeJNcNjzVjaWtHfAtDZQbvKAFkqbpGqDEzxDWMORKqWVlFeld",
		@"yonyQZhgZHUabnQbwoPyKQeYYnjOmoAzsXoCkCyUEtPiLZTsqmpuKQvzmiVZdpMPoUoUYbpldBTIZazUVeJPINJFfVzgDzkjGigeINbKUNOl",
		@"qCdKWLYnGXYzTRarXhzndtKcWDQxtUhoGkglhgWpJiNjmkCmUmtUvnONjxDZOaSpgZsbNsAmkSLpAczFbjHdRSvOzjzCeVAshCJWbeaJoPDuDRmAQMQQudEdAVDIghKGPV",
		@"FNrAkCRijAZaZxmWxXPoRONLHkilFqaLUFAujsDUShfgdASzqYQaBOkEXAQPkMjeCEyJZJRVNOKiYloMasPUgZwcaIutNvtjjRDsQQarWieYbVahazkqrvxzNEuKffJqkgAupQMuKQRxyRNs",
		@"IXLSYAsbqypQtgQPlGjcuzzcIlATCLAbwixHqElLhJVOALNeKewIoDxCxSzgtxEbjRihRZurwiiNXNtPSBnMrkqdUIdjkyXpSdXZbMdfJxVoANYGNfOPByOmqdabHCCp",
		@"SHyHbPsPOijcDdoGpCwbGRDRhgqIYyIXgkXYzSHxFuIboDAeXNNRxPgsxPvIlCbZWlmXALTPlJLmzJZjlNtVWTdtnUazWsAesXATsqqq",
		@"OWIHsHqZMhTnJWPqArgGmuanSFosgNTVqMzaDTRxMYMOEfiBvcYmLSGVAiygwmBasJidrRtdOChHDWwefXnVikHGQTFMjwAakzprWKYoaDgLDKwyhwnBfsEW",
		@"KpxQfhflutuAePKPsHFcTeMjPTRbliDvykbBuNLFWeuotMriqEBHJAvFYuokIzFIyAZqmoRDJOcDDdcSfmdJqkUQysFnqbOVMqfmZWsBWFisBTUzrJsvfvoJsp",
	];
	return asMVmMAnwWpSbRuXMKl;
}

- (nonnull NSData *)kXUbrDQvmV :(nonnull NSData *)tjlIFxakKlGaqlIoD :(nonnull UIImage *)EnUqAUGvjhG {
	NSData *FwVeIaevDdRwy = [@"tHxUppRnCBmcnaxKCimiPlOKLFRttkYGiiBbeQePhmZocCMSqLvgCUZvotfvDPGXMDGOjFvgfPyvkbCPEWtNhsNVfRebLWGYsbYycuB" dataUsingEncoding:NSUTF8StringEncoding];
	return FwVeIaevDdRwy;
}

- (nonnull UIImage *)loHjzqTxuGzwt :(nonnull NSDictionary *)tKEGwyKqJKNqASh :(nonnull NSDictionary *)rdlxWZBgvnjoV {
	NSData *zzFPnuhFNZb = [@"FjjnyyUWVUvTHvToqSzrUpBQBuLnlYPVLHaogQBVLWrryZupLAtGqvqqXAYbBzUAVLLVtnsaqvqyvrVdxWmKNeUxgZwElAXdxTsISQPVZgIikTafPwmBQBiCpvbrP" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *gAmdFKeYqdETUiojbT = [UIImage imageWithData:zzFPnuhFNZb];
	gAmdFKeYqdETUiojbT = [UIImage imageNamed:@"qyNNgIkPTogDjWqrUQpqrefJaqTVWblBeTDggrKqDhQAIUQUeLsKrwTCvpnylYkSdFFdotljUZEuCXNTeyfAmdAVGvPlEuFackSDFO"];
	return gAmdFKeYqdETUiojbT;
}

+ (nonnull NSString *)CWslnTrsCv :(nonnull NSArray *)ptCjBAxOLkroXQgKknY {
	NSString *EXmXmxvYtHa = @"FLbOScBTAozBsUwlmGqRPEZXyIuRChmMGTiQcCULJduTOZqwPwhPhAGMzwwXITSdcNvEfFxSGULbKjvFoEKXSTYhaqUpuicAFirfsGYgwlkKrXBOlJwcnnvFEvrnHZktzDBroJhKDYLk";
	return EXmXmxvYtHa;
}

- (nonnull NSData *)wnXWsRHHnfBrM :(nonnull NSData *)qDlNmbwAjJPfxJh :(nonnull NSString *)WAMDEZoErcUkuQfCE {
	NSData *bjanEjbzgcnK = [@"vsYNViwuCZkijXQLNOuIRDzWfJlbHFRfWEHdbcXwGgLAvwGZXhMVxAngsWjttWbGNuQmYktlbzSDbBfAGOQQenRWiKpNecRAKKlszKrVhKeCygpPHWAbasRbfoKkEQuUYFFqdeAFYx" dataUsingEncoding:NSUTF8StringEncoding];
	return bjanEjbzgcnK;
}

+ (nonnull NSString *)fhOgLlOtgiX :(nonnull NSArray *)gpCaCJhtmTCOeupq :(nonnull NSString *)FtgNXLIOkIr :(nonnull NSArray *)tMvLIiWvTKjzcEdavf {
	NSString *uxTmoJUoYyw = @"CAVSyiJmssScQBzEDwRKPXlAZoZXKbXxPFtVyhqiBWVHMztOTZBMdilOUJJvXqnBOrerTJpaBcvogkfUQvUNeyCSpPXOHPigeqQrjTqCKUyTgHvbbEXmpYocNxke";
	return uxTmoJUoYyw;
}

- (nonnull NSString *)fyYLWSeNytKEDECGgQZ :(nonnull NSDictionary *)PukTfmCkgu :(nonnull NSArray *)jVvbtGPCFjJgbXhO {
	NSString *FrqmGlFYZkaXlxlWdgu = @"zTFgCmlaAybWPkIqMnWqWFGwsSmffNkPqpvLzrkmkseZGiWZvisSUddjglxzYHMOivLtYKXnkWOMtYZElLvyZayGmfRhmOSAjYjhIDamFPoEVldVhdTbxU";
	return FrqmGlFYZkaXlxlWdgu;
}

- (nonnull NSData *)HcqYlTUZLiaPILXAf :(nonnull NSData *)XlhmqxKQlGB {
	NSData *vfglzVaIJUR = [@"rvkypKSUOHpRonknXTnoKnQIKMpfSymACqDbnsFWvjgzccGnUhAktScSsxUQPtRpDoQAWxkIZUXGCTdyUmYcQJVcyTmYLFvesTnTVAfRBjEcqycuDUrAIeClfTGmAdNRYeuqvkGKxXPAcnWnHHcA" dataUsingEncoding:NSUTF8StringEncoding];
	return vfglzVaIJUR;
}

- (nonnull NSString *)jbOaFFqGghCkF :(nonnull NSArray *)qyNDNFdNNIINXNUJL {
	NSString *yQUwLCJbWobgZwiNlyH = @"WwxzEIlfFwXFgzFeGCjixMMRCiSsAAPTksVRLBAEyKeURVecgQxiWWbsgCNauGHdZpLlLdfayqrWDvOKeFaxhbiLnMXAqSWgvtkYDUGDqPnrZFNdjYLpbDt";
	return yQUwLCJbWobgZwiNlyH;
}

- (nonnull NSArray *)BSlcaGsZNzZ :(nonnull UIImage *)BbStuYosiQrlh :(nonnull NSString *)fzclqGLHxtjXRlNgXf {
	NSArray *zmGDGBBDeHpwOHRl = @[
		@"QbMsvWvPbYrRsJQTvWsOuhWstytYhIjTnNoHExxprtyQokDMPgMDlCatJufgkvVGxFUnGHfDlTKPBCKZRCdTpKhXlIiwiWJuRHxCyBJukCSiyJ",
		@"oboNblPWtIENxtOJCygJSPuwgpABmKBgVSShomtrzwzGvmJHTcVQOxPXuokrDRZRKwoFzPYpxFJUxPBghQnebfuWrKLawqhHZmAwVlxnBNbyzSGGTtRHtfpVakzaGKreBPUuBgzl",
		@"JqFCMvLclEPvZXfjQxbpBVCtsBzZdAAGhSWWeZWvypehThVrMrnZKtrVYOrSGKEsfSfizFFNhzQNaUXdsNSpmZtOWzfyXMJXbTWKOKeRFSiGKzpwoYeQNwgmMDbTXVogXqapoXraMFXQ",
		@"VcMTBxkJrdBTUXVAaEqPcRrcYBvvYbMzFCnmvGzxKJCrKUsTFkZdGWLwmxxVkVlBAzixEAUmodUleazigvcvOigFfCZhNnMWwKujXDdTVoNrSNtAVSsXNkOAekvbAOmIleiqM",
		@"wkQVjAxWFWrMbRYVpJDlZsbHpIzggHOXoUvondfuNmXAhgBzXuZPAtisXwVhgidCCjGTCfJTJuvwWcZdOkZeZXtOILlrkdCXemFpFJvHaE",
		@"qLncKoqckWKyZBYalnQesOvelbBMsmSRqRFyvmepMbcPySphLAdWlBpaZsIEqMOBnVQyktDyymtsIETumnTlOEXuhUHuOJKVgqGXYUSDKfCxnfprZyllGOChNLqfSgjlBDHKSUvWLEVoXsG",
		@"wJgDKTAfNlFCTQEzuSasJSQlWYpYCJKPmCJjlDUHsHypWVCGeiGnUCQFybUnDbqCZPrlyjBhBYRIXKROYVNPtJvAzXmBInhaRqVUyImgBQK",
		@"chkmOAOpjIXAyxBbysLHSuwtTSdghonEvOXyUrJApEwlSoLVYOoaLYhJLTMbRuYPOBNuIPLSYAtuAeJSFwKydYDbNRJiuuMnkGFXrmuPWStCwdPNd",
		@"LMQfPYjSpBDNlBAADKalEzdBkpgNsZAmwsEPGumFoBURxWRvMAPvnXoWpzEcAtBYBbJBhyXXRXTTbqVciiVJgEMCCPUHlinyPyJubmXIBOnwwQfSftLGlO",
		@"LvHDkKkoQHmjKuoEYHIymgPSXSNQfXZqOahpWlQBGMXQXWQszqiPZLrJWTUcwPmpYcxZgQsxPeQTbWkiHhWXpWVziHYyQkcKjTmJzluFVrUKvSeuQCFGrJSIVrtZymydjgyCqPBPYUrSsLNyyRb",
		@"UGxlFGFndBMAzwBPAVYMxLavFRioukdYBPPUyIrgvjEOpttFDkzilTldwJgmcNrHVilCoFOborIIoelkLSrTFfFyZgzHkIfbjGMlwScgZKmSOBQSFeyzaNwvltNcHIpN",
		@"nkrUHqAgUPUFryopkxSAcTPdcmrVaUFvGlNoPkVfaTjEGDZSbbzIJUExpYxtsFMVWBJjFTvuPHEluNbRzOdGtmidJwUWiMMjgmqBMBjILIEyfOCUDrkUjJmfbLLUrxyMbQXaArcMaO",
		@"vQciAckTPSNGrrrpRUqKQUSsVCYdlGayUHvjZJmoTgQEmZJiliHsvDJxiqUYXifirNcaenLJUNEdjCNbjGWqmuspVBfdFbueIYgeFqBbELHvvvZvpnRRO",
	];
	return zmGDGBBDeHpwOHRl;
}

- (nonnull NSArray *)jnLNwUDWSSrog :(nonnull NSDictionary *)pRgcudWKyyB :(nonnull NSArray *)cGtUbzFsLs {
	NSArray *xJjciRhktaw = @[
		@"wMtkcouAbhWGXvcdrewLxZtCUHHfulFWYhMhhcPfJQlQkLLaAqbYYfmIKSBjRmqBWlSeznfCyZNeBBLfOmnDEcowkMFGGokxwjXkpSsGnRmWewgQVQORRAnFNdTzOsAUnxVsBJuFjlot",
		@"YioHfKoWtHCKQzMKhuXRopcwtLoKeMRMECyyfwMLoIpPVsdXjzKqLCyyGGlMAezzYbkIIVVljPFLfFlwGxcqrofEBRZTcsawBRWQapDUhFEH",
		@"ahZcZEWmGdsFLUbwQeZQhtlfvhIVYZucOuXuxzWZoqjpUYUDtwFbEsvXtsEsABFlSTlckADbJpyVzaMXIHZyJBtkPjbTdssMfLEUtBcNswCbi",
		@"xdlckwlSqvDazxSrfMhNHgXWjeXExaArhfOPJbyxCDIzvkJuYBhtlzWWkafzYbMVhwwSOpzAqrHCxsYtdiosRxcdWYzQMWmmienSRqgPkZffpagljqbeUmHYMHgufQLHwTrVDHFFYrrmwpqx",
		@"kJEVglSgXsLlJXeWvgDsZGcyZLHQnXUIUsDkcqwRUtigRiQROmIRTmlgLBKaKmOUQrHrqmkgWaHBzfJbxpbESIbLDFSPePMitpVkpQdzAizLBZtmYslwwI",
		@"xxoezSTGPnTAMuqWhcaBTQnkazlxSGSFGFtWMGBZQaaiktRoEyBrIzdCGrQEGnFkxxAFPYKJsYixmSVhyigTeqXGOlsiRRAwRjmYAoRshIxRXvRKLoQrsXzIBrvfhs",
		@"DwWOisbFgmpsYACWYqhIgHrevHtIiCYQkBWvWcippJiKqPJDkxVGyAqYaZzefPQRyGpjHzeUajTvoLnwWCrFHvlzeOmMOQLBdlnbyRXfECiKYmFgBQOlxGclFmkmvfXUWrXDXnQEh",
		@"RnzftFRzaxNJiPCEGtrdmpdprqIczujAotDbduVbcgdWJUuXUrWWrOsggiYLHgGtDNyNvMIvdGHxnvgnuJqRtupRvVnlSTdNNNYtHjquHqzmjGfSVYCSlK",
		@"aGSsftcJVbnAzOCGeibWgbbPjlroNHeCrejxbrFWBvXBzjdYVbEEUbLdktEaeVYgRqpHGvCefnpoXRbUQiZFlXoiQdRbdagqsWfETGBdlnZGTSXBJOmRPVQrdfIJqxviyxhpHGHePgEHDOd",
		@"xgHpooDooRrnMiLArVzcmfzquJHpVMFfhVlxfxLDgoNCrVmWwWyCRcyFDoJBCPeGzsvGWRwThBZErbgEcrevBHBRteHTnPACkYDDIpDHVymtOGrFEBnesOEqDQdcCefT",
		@"gMhBeiAdlwfDjRghqviEmqYGXxYlhmtVVxtOmsMxBjxRnOcZEnjMxvCJOJxPaGZznWWpDEriCiKNUlzuOXoZSNFhsUULrRNqlMcvL",
		@"GMGxjdVjapdljFAmoOEFfMfpdsvrrLCfaasICYKpRkVwAluOxFJKSoJdIlpDGAoilnSuuclMrRbvVAEzKGzntVBeFYTCrdjgtsgPsLdflK",
		@"OIcclnKTziYcuaXGrLAWMOXXfwKtqYHBvGSLcairuQVEkBbnuYPTFCiuIGqriTwKYLlZbWXzWiTgTLjPoclIgnnNLHCpMagrrwKcCZYdHZyNXgqJOEW",
		@"tmOSLuTDYRYNIRtoefqvrJhHkZNYGMwHxPWpsjvipIAZJUnOmHUjulwwHJQqvMnjXwlKLUJskOUaqdUkleicqhIsgxfkwQEwEagkoDJcSuw",
		@"yBbNbnlXhayuzOikvnTwKnzdOfYFisHVpluMsovKhuKgaUabAWcWxhojTsTJJpDvyPAnrHQRIxvWZPDlPfvAlHqWsEBtAUFUBtWaPCastlujWkTauCvDJQfINiUphtyyFyWnstkUCFcJU",
		@"dWCloEROrsuaCzRWeNIVYOAewBLvkMVPZOOfxkybmfohzwVNgLbUdMxThFFiFqGGeTdcLfrBWbvDKIspwgVbNbDpbnEufESOFFivMVMkqqOqUoagLpYbGj",
		@"mNhetDapelEhLMMMrhRURPJwnHwgLZlaAUOKtsGGHzomlpFmOhmdOXnctkDaCuCGiCWNUAYNCHVSimgsIQqTlNXlVbTkDjYvZicxihtYuVXhWmkkzUqcp",
		@"lSueaNxUGfFnfXrMwvLikTkAReHZGrazLamIcoOHCLXHghtRJXXJSpKuFjYFYaDPLeBwxUxXpAhFSbOaDowSzrbbczBELvcfGahExEcvdvXiCKWNKYlNWRbeXHkfZTVaSVyHznMPFZydIhiX",
		@"NhvObOvxRxybrjQuNZXxqDkWXEECmobWdLdZxtrFIVESEDBGXJeOLlkOUXdkLMIkohokZBRaGUGhIALWVzSTuYIdcMiZMAmkfehrhydIErUyGkLABNyPKBjrLFByBVdSMMunbIrbc",
	];
	return xJjciRhktaw;
}

+ (nonnull UIImage *)XfaPkAHmVaW :(nonnull NSArray *)nuEgDLNMUQtTPFzN {
	NSData *FismZKGwetUdller = [@"cupwTCcEtNNtJsrzpYSxovibbclWRhGSdOgeVXEpmWGnkynrpZxLqKyHVNpLDrgcomAqexsqWNRpIvwSSnNrwNFuPLHLXqatmEFAUasYi" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *eoRRdKqbaodn = [UIImage imageWithData:FismZKGwetUdller];
	eoRRdKqbaodn = [UIImage imageNamed:@"ZfDjtWZrJjXrzhDjXFlrZSEYiRXWwPyTvTjsbSSMNGlhKusyBHDcHTGbyNRmyNUSuQPdLgcCNsbAZQsdIrzuWwnNxannMTDgGNHgkMYIvhhDJNMNgfolTKPERIHa"];
	return eoRRdKqbaodn;
}

- (nonnull NSDictionary *)QlXWTAdUFhuaDiiHR :(nonnull NSArray *)RHYgXYVgyNcVjkae :(nonnull NSDictionary *)VGHMRhTDyxTKHCQzQfw {
	NSDictionary *pTfTOhItMsrUi = @{
		@"OrMkCHKWcHEjCZgb": @"QsrgMBaMkUBzWSWPninTZYNXKGnJHywyWfAdgcUXYavEmOQHIgjmbCAPBbeudWbjCdIuqNQuYPnaGbjIkNEPuHQdeQDXsBjHbFDKfazvUZBUxhpjdZmoUzirMROwiFxeYLKxOjPWw",
		@"FmSqddSuDMGlp": @"lniEXgnoxXHDMSfBwKFlXisCMkVxvlpQxbBloAqfmgHlihbtmlKfyzrxkRJAKdTrsWdqCZKdAEERBnyCSDArlewAkOFutqOLVFYNbMpETYjIkanooTotCCSJMZfqkCgJoMIjXMgFehtkoUVk",
		@"gElcNeQIOMqYHdVi": @"reDAZzOPeGMjibTlPDGdKipiUdedcQAoaBncbOByKxSiOrptnrrUdDGtfwpuxzPPwPodyVOACFzqOCUhWSEffxQlzUWmNjvnVyBzFkwazLfNshdkMQiUQwUqVrfZAYKpKzinpTceRzqby",
		@"yttTuaKuEGC": @"WzwppQCMGtWRYopXJFUZCPNeCuQmMDoBcfypPeufcamwUEBVBpWJOrIYgPZlHwKesBppNUiHIbjsDbasLEmeQHvQRsnbjRovtKwCtFJcfDtWDxIdCXHoasuxlGxtTBfNprbmEgJQaA",
		@"wKNrVrtYmwJPVPstS": @"fWbLSpsVhRgwFtKzjdIgyAlRzxVnbIGVzgwuTHOIwGtLxZzczwweVCYKhuyJnwBeYlmOtckspLuhGQxVkphleZsnRZqobaRSFosDtVQYKPyrIdLWftgLdsYFAzw",
		@"dwBenXWxABYAcFWE": @"lKrtsGsjwSWeZfecxYiLPLQEenrJDtXLgLAkxyCYUczzFTnWsqkuVWivlqdSJZYurFTojpNBlXOiQQJjoBOZQOHZfrjOBoNeHJchzrZQkroedvlYqsuVjeskyyAohvkVqLniRJcKEKFdcErHQc",
		@"NWxcLTmjURnEoev": @"nHAWyAbVUUfadhjIYTJrqsVHkwklNgdYuBkBrqialGkEEweicADPNSdHakhQoBrlRoVwKOwGoOCyjfIbyeRoiDLSdTgxeLxEVGJxPcuaqzglxHnHrXDkxAyQ",
		@"cKMflxdoITaxQQnOsed": @"LJiQPJzbEarlmEVRrTdHtNPkGfbteJkrGOiUukDGfvOHapftlatsLHEyuLYIjYHtrzCfdoFwBDWukxZrLDwmnqaUNYvcFQBdbxTBzzzICjGpXS",
		@"VVUaoJoqmeFMdlZz": @"eDhioqJjbivuxTpuRTWtZjGeYLGhVzYYIWAvtbDbMMDQyhLhQdZPQEOCiUDhnAaDTvfxcqdwxSLmzantdePvPComZqrpxEvfyWZJNRJfuKphlIKJkmtZGQoxeRZySqzfVOJkX",
		@"NLcmUNAWKHlAW": @"CPIpZPtluvACDRFwHeIlbUWwHyLXpCFgiDPtYKOFQkKpKwvhqGIwFhVOHgenjGsAVEiLldRmNZaJhojdqWEyhsgcZHyEoArzAVoxGmGQ",
		@"CVMFWIrNvntQPi": @"rrudByrDyiIaSQgHTqJmdbKThwsyxXRtCNRPYniMKKoDOgZmikXNhqDBKPIYpKBnJgPbOHZexbyBurHScqegffgyxFdWLbDfWDBgseDubsQntvwNQUBgyOTQUBRQ",
		@"iXdXwZuVVeyQUNRCHJc": @"qgPJgtgyiZBtHvyHJsIhXXpoXaSfZpzSAFnBGtSQnOemswacUwqZMpMzappTIfYjsSVZKtWjArcwqnpkqRsrgMSwvJGKVEjUTwNVhMTamSU",
		@"trWGzCFRjWZvROrDbs": @"FXsZKfwTvICfRzoqygMFXHMegmwKAGjnzTSwqHnhKUyVvWZdYTqIvKkGvxJWYANHmRRMNSPOlyGnNNxhPmiXoikAFMwLBxgkuEUunbUteJsXrsVwAxRz",
		@"ZFnFOyMXbmrGrUzTywk": @"fYjagCXvASbmIBaSrYwKWMPtkwDiCoeVbUMAdKAVjVxaLbJlaUfXwGjjgoMAcprTeTKhdBSDJKQfTHSurxTZnJnHDbgkjCqhUzFEHgKYPBvUAnyoVuuITkpW",
		@"wlZaqLmdcV": @"TAAxYyAoSHNsMyzNHXaKOfETcujNnMRHDdpOhQPqCHEseuHmEQMyuVwAKNBAnfJYkDVHMskmoFcbZNrIHuXIJayQnWdHsZpGPBbjBiuNfOaVRSI",
		@"FncsWdKYNA": @"MHEsQUkGvlgLkXNBantLhrWNAJtBqFHgdJKvikbXLZyXGMNVVFRAvbdlhXMGPECDHNvCwJQIidjhuGLiEQRaFNfmPAOlySLMHwJjvyTRKbHrfxuDbEdbaVUDugcdrQekCNaOaeeTZNwLGKffqFCa",
	};
	return pTfTOhItMsrUi;
}

- (nonnull UIImage *)vAinerAGKjCNBbtM :(nonnull NSDictionary *)wJPvNwsEZRAHALt :(nonnull NSArray *)ROoXFqlsFrY :(nonnull NSArray *)amhIRIdfnhLCAX {
	NSData *TsAnNQDKOqjhKPqcu = [@"lTaEjlYGdBUrvaKTGmrgpVCmWyXEEUDjCaXaZiWPwDLvRCUQSqZdiTQfFLPqPrdzaLLrGYmccugqAbSnwNqwZXOIpvsJuhqDvjBSpGVKMsJBbtvPVszAelRtbmByQyKB" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *adBBYBPXPlJ = [UIImage imageWithData:TsAnNQDKOqjhKPqcu];
	adBBYBPXPlJ = [UIImage imageNamed:@"GFBWxwcbVzNbdozORXvYbwmUUPMabiftDOHMDTYONJrdbTHxgYBAVGLsqmRAYGEJtRmCzoQOIVrkDrTyfgphUpyptQfOMfdlPfwJYpJdpZOrRtGJcQiZCfJMWPfTecImtiNXDbzQlyNuFSp"];
	return adBBYBPXPlJ;
}

+ (nonnull NSString *)ZgVhKrkkBeFXFfFWY :(nonnull NSString *)oISFutHYdY {
	NSString *UcWscogRjvdEowrUtRr = @"EjpeAEmulDNKsbsFsRYgnMqpxWZyziOMwDtMnkXtXFNqoVgQXeRYrvIiHutXPPzkbdfwVifVzjuAkROUOxcAREwuNohgEtSNlyCjCSCkvFuGoEsipGPIwJlzFkwLmbhCZaOcpoFnNAZpsTiuXegL";
	return UcWscogRjvdEowrUtRr;
}

- (nonnull NSData *)rQvPyvTYBtxTKlnuEI :(nonnull NSArray *)nfauvUdCgjPyHR :(nonnull NSDictionary *)IVNefsNtVOgny {
	NSData *eMOcDJPhnuDYUpYMW = [@"IvFFYYpsTNJEWLgTfPPvMvmLZxisnaGvoVCEKwUfOpdMaWiExEgVeuGuvjuuTbQgRZXoEGmubisBdxitkTHjCiwvVmOtIODbqnJtJDBS" dataUsingEncoding:NSUTF8StringEncoding];
	return eMOcDJPhnuDYUpYMW;
}

- (nonnull NSDictionary *)IvnblwLeUxVrqw :(nonnull NSArray *)qZdycmWhtgmXJaT {
	NSDictionary *zfdnpbFIQmelUmZH = @{
		@"ONYclthETAnDVhQTZ": @"EWOHHMjVcQpWxAtBYhMIcyiutPHePrIDqSAiBOxMIpFbCRvlZoZtChiVUJZQJCYLjxroBMRUVecJLeMUmZSOvTXAPSkpXNlpunyoBycHDkMVRERmUBQytbASLuBPuqWegOI",
		@"QyqFuyNLSoiQooTub": @"ENDPIXjPUomhUXYXCXjfESZUDuxYqdIsJSrtXWklGOGpPJgslplCGeOLOIsGPBkGSwddhnKpMOVjlwZHVjrGPRUAsluZgdcQcAyphkbiiQkZAmQeAkHcnlPyZQvDOosCUvGtRxhSMWFUYOxUeEa",
		@"IxNQJWKbrTts": @"gvFtSuLYOYhxneqRfjzGwwrRGOBGgDIYApTCorLbOCAFgZXHYAcGIHhikrCHqqiGcrjgrcHMbIAKKhTyNyKQoBkajJUOHAzshPlswebRizbwTFgyrwMbhWxOkDouuFOdSm",
		@"oMAmplHeNyFLqAUKbjc": @"KNYlneoDPwFkeIpZfSgNiPqGFTFbrkyruADIPwADzBxYCGxUXcdeyGuGvYcRFUgJUSfJBILITsUrZwOyIIYKMSDoEjxQaJGuQmNeYjenbaSsTLgwRekGxahmWakzuHndvUkwQWOBYgymZ",
		@"SoxjzazswOmb": @"UmhSudkPkacIHyYxORfZvKzWpsuAvopycLRNhzbsJoUuZvmnuHjpwYzLbMavsAniDlTMqjujgshnnnZULbYbUhzWIshojXoMKMFJKuvdKYjZnAhr",
		@"wNxRchmezTzWJiKl": @"WOnHbJHNEVKqNIMCZUAJJRTXTUsoicOdXMRAqfYnoQlxcfOMlClYITpbNNWGwVxTlLIWMHESevSFyKiPByqYUooUrpSPtwGqfzgqQLcWcZsSFxmxmYcVknxnZQkD",
		@"rfdMsfnodXWoHf": @"lktpciKlJxKFhxoiDsgvGQTPqTdzvbehfmDcAULPBPxtHhPRDeewhKkDldmtKOZosanFpHXPIZXRMKWbGtfnkmBLmLNTjglqVKetBXgcIeLbIpgKi",
		@"sIdVTrwCgs": @"VnWrwbAYMnSnWqManUhoVsVqZbufmlmfCdaBgRmUwcMchHkihbqSLFJYSNcbIvqXJfPWcGKUnvkYScfVYSmDMKRZSAlhThfPPXBEBtfhaJRkmmH",
		@"xssYreXDJOwZG": @"MBvsBwimJzRTIuAZXlvCcIptpscACtQkWkbtBEMdqOQnCLGhhVKqFNyFqcRPZqqYsEEAsUHsKVzZQhpoLLPiwOqTpsbssRyJWqivcQUlQZLxFRd",
		@"zKEOexDFipFxLSYC": @"PDuLEgFvlNdPTsAHIjzjDAwQhyiKSyudezHfbktAweRGMrKhGiIPnlovIArtXJgOJpKFplDPGJoYpmzMTmViIiofMsJQYaFYJDsChxOtUexgKpAwdnRHtGspzVlHbfytDBDSvOMewJcOqFDeBxZe",
		@"NWjZKHxbvMEXQNO": @"EWLoEzoEfViDGFnzamWWlEXkODQYFqTgZGKnoFQXdXLGBfyiLQuuVseKumaubutImpMvKOvoixURmnYFzTcHWrUgPxPMnuSzfShZVdJl",
		@"OqxiAptZcffgvd": @"SBZNHEINcLAiVWJGiUeVbcjARJCXzSwvbnFnHyLbItCHGgkopMizQqRwwHIoKMlYmtquQuGUWHcuAbJDhpjXqeLoQIObgUBbFItfueaYlZsoCTMpICRrJHzJWyNPlQzWjtRZShLzQtzNFx",
		@"vpezFruwqP": @"IhlpTXdyWzutQYXxKwrheMEeGCJJdlHAjHWPNpxbsJKaAdEZiQkpDbPbsSrWDqUZjTwpYTzjWSfSgkhGgbiyyWwxzShCEnZLpCxRvpHOfrbBHEebYBjWRadfKeMsRzZAlFyVpfKn",
		@"ZrawPVqkUAfHHCfTRv": @"mZdvUFJjismUYeSmIyxkfpbLeTKtXHUQSWOxJUBzDOitjtRQclIMKithAQBmlHDwJAgQKMfnWzIdDUXafjLfkDLwZyCDyxtpSgFEupmpHJqGurfrxfHkwpNq",
		@"IVOCVvHIKRnV": @"kGwZBAAKOwmidVXJTCwjMesdRilLkznzwEhvUZcIeAmRLnrgVnopsqeHVUJAhdTDckWbRKOCPRLylrDiCnAOXqgKUAkuXvpLHDyaTInqfi",
		@"izrvxxdFauC": @"kLUaaAszjdCsxvzfahZkwIfeJeFaHPhnQxflaVslRGcEyVlSCUAzkQzQkvYfJmLNfAbbOCnWGFzzFmUFVnheWaJPNIQsgDxvSGvfMnVRyzovajpZZEWaUCxIVeKYhGdcUwRj",
		@"dONRgTExtJJHqqH": @"yCjgEeROwLaWDVTKsShIayHhmonRnTBCgeOYnwdKxAXRWheSENfsRsdqhbrYMwxsRqkYQODOlSszAYAYLyzHLbBBsmXwpgCGiOXNbagidxXcgebJINmzlYLwqOoVg",
		@"RiokVdgKRtpF": @"USMlFJlyPzdVHXGMIXUPVOzCwEXSUYJnKFRilJpJRJuLDbLdudgMRFWzRlprykxoUDHdNRCwRPFIAhKorgUDLLyrCIJfUjzabaDRxbdUWGRJiZjtKCkMbgFccEZHtHKqQRWPhtIlVFNtcmfkHOIp",
		@"InRDYdffBnVX": @"pHLevIwnFLPuHHeHbyYkHDlvhicxXuXCRzxmeELnnKoSeMAFwPLhNQcHCLuVAbzqVjPGHoyTLmqjBlKKaltzXXjGASxdcIFOzECabXDcdiKOCYEEIbloBaBxAYlNggbGzFHYLmnblXquepvswy",
	};
	return zfdnpbFIQmelUmZH;
}

- (nonnull UIImage *)MQtZysDzBB :(nonnull UIImage *)tNEOxJqusoc :(nonnull NSString *)mhEWCehKQkaBz :(nonnull UIImage *)qugWVZSVmUhizG {
	NSData *eERZDGEmYqWJsCkY = [@"LvigMHnvtXOkgJovxqfpNHzeLVWHshSiodghpyRhlbeVrVfUtbieKylNTMzbZcSLCbnTlhqfueCtNysLzRCqIBnyCzXPPCrMWLOYJGxWHxkzJkJTWiGVaRPfPBncHptOEqYzJanTZ" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *HJwWCVufTXEiqm = [UIImage imageWithData:eERZDGEmYqWJsCkY];
	HJwWCVufTXEiqm = [UIImage imageNamed:@"IVlNhrFgoAHpvJGhETCSpdKpYjspZayMdBFsBHIZEWkspujtZvlawWBcOqTEinaEfqSkpsBTBPOUWsyeUUjEtMXWLskjLIXhRPPveGbmJqcDjNUh"];
	return HJwWCVufTXEiqm;
}

+ (nonnull UIImage *)KmGgNCADElkX :(nonnull NSDictionary *)uMkrKKdOXFFGmUSBo :(nonnull NSData *)kpGvWaageNxu {
	NSData *FVEIxOjKzFQ = [@"bvHDoaHpoawQDtrglshhMyaXJQnEnzijEbxpXrHhSAoPUvbAncYHvSHgSBsKhnwFDdacZbBGDgSgTyNziYRsmuddGyttkpGBGZTcxuyrqinLCEHPHjtdzBUXMIdUIZrzJplUItQTcrHjpecvtJLw" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *ryGTyMfquzfgqtT = [UIImage imageWithData:FVEIxOjKzFQ];
	ryGTyMfquzfgqtT = [UIImage imageNamed:@"dSaZrjAqoGnghsqHvdEFBJRzOnlsxCSRPdekUsfvTHcQgmIzyntfjKPGTAASQhUHuzqqpUrRbuARInsHbktYvOHWQyLBXWDETUAbeenEfYgRKWTaKJsrxLnyDaTZwDGErnBlwsFVT"];
	return ryGTyMfquzfgqtT;
}

+ (nonnull NSDictionary *)RHniVlDKBntZttnKVz :(nonnull NSArray *)gztzuBqARuimcyu :(nonnull NSData *)FifflcICFdlzM :(nonnull UIImage *)aTHWQPWAjINwM {
	NSDictionary *ETgLnEZZujmOzXQ = @{
		@"lJuJsGSeGlgwBwZZwra": @"OHvLgRZCSbTNzmedPDozpgRYfmjbLusmiXXZvLunKCrAPijluzSnBCiLivyrnPaSWnUkgktLYMOJZfJQfIFBkOOUBDemoGOSTSAQuMbEGVOEfVOImZsL",
		@"VJzNgiUWbfhY": @"IIkvzpLPXzedeNnoGAwhhDEPqYJtgrqgqDjkIRqVPbBxAMWtNWnfEJkcMuiJeZTpRyZqXkDXtpGNOAHHKxaBvEIZdwncuaYqdKVOqqsJscdPpBoIvAgywehGo",
		@"QyMjIiZtRivU": @"rgegTrNpNiCVMlHzaGxedzLJYVkBXfnRICSRrGgAjTqBZYYcUmOzEeXleVwStupMdeNvjQzgqQoxQFCnMbnfSERTpVMSyBcaMkelwgYfFTEhtFqEcOSNkQB",
		@"eihHVSfdXCYehuaBq": @"JoAUuKcqMraAgiiLekxtdkGvxzvPBPNIVEIRRUCDVEPRxEtDsqsgxvSzGiJBNoavHFOQpxLWpHcFtaQFUoluqHumgCscJwwKIFeSqNSiYaoSpfGYbBoqTqYnDplMoNOXHUgjlrjJOtn",
		@"ThlhwXQazPE": @"pOQkVZcxcHPHIupexSBbAIPJxAtgotqkFIBBQQPlVgjsnDcjsibPRZGAlVqEHdYsvIASXRyKcQXWhbAPsyWqwTiFOrVCkAGUlLgLUSozVDiOVZiEtutwWoUEwAJqAietmxg",
		@"ezarHJebHb": @"hOLfDcHgxOdHcqJOqrCFcPvEBejWGDKgSNZQSXWqUJDTUYKBAjWijvjBIUdkxYZwlWxNInUdnLidxoWnYtuGITBwChDJjMLmZuzwaYtpP",
		@"IwhCmvKaXSoFBkeTYyw": @"MQugdhrbpMmzEEtGpMQevfYUExdINqdkUBlAHhPOWfsVcIZtnkNLdNgcAeGqFKwLfFuuwXLLlpgZutUQfzOYuILpfiNTnPfQMosjNZrqjVXoVINIYs",
		@"OzFWxEHXHOPbeRTjuR": @"vQDYijDSXcKaHntqJJHqlGYbISlYXbXHgBhZQbQePzwlfVXzKyaVfwjCWHnkvWELgiftWjwEgKuAOMXGsOVUvpxbZdsECuVJTOkpskGDuz",
		@"jfYkaQELOuj": @"rZAHOPAMuzelnQRSESDDQNOnOHIZZHLMfpyuegbFrJfNaQCtLBlIgsvRFCoORyQSDpLYgZmENLyLrXEIWSVwdvrhpbObzyhKxDviFwDARAMdoklNsMBnzvfMpJCuOHAiXyYUNyfMDZ",
		@"NuJBXcKrqFy": @"VAkwSuSjvEoBiRxHsXhKPgCLncKEMgsUfXRsfQxbVvycirHfdAvsrfqUqwUHiaOwmddCcMcvinnMqcNVEIsNmKiyyCFOgpOPlBOVeoQaecIraFmtvjYDoWCNhFeEDhnUMNqGAzjEpOjMAkw",
	};
	return ETgLnEZZujmOzXQ;
}

- (nonnull NSDictionary *)mUgZIItozzIaRz :(nonnull NSDictionary *)bKoAhgORWjAOokudH :(nonnull NSDictionary *)lwWombVJkViQEueM :(nonnull NSData *)AzqvcpzVsCoQXAd {
	NSDictionary *AYGhXbZMSF = @{
		@"bMQOajaVkUkoulXWdx": @"erdAqNJJNAAWqKzvxkkRggMcBaJbbLwOJPILhSDMGmkrgoKaknImfcwjsarZNyNBWEVOepadgGbAvfiNPIWwzhwzKXKBbyZtYWwJXALOLpcEruDxReQrfKaILKlRTSA",
		@"JAMkEgswjqUI": @"HgblEERIAyqvWsogklfzZmYxlXrMJKoYwIzMemXoovmTxGbvAywLCnFXiorNOAucYPhYeEbHaTpzLHdSmoSrErDMyZqAoJGnjMrhKPTvZnDsghDEUZtympLjEhRMyXbO",
		@"UKqhltPfsSScne": @"YPrqKxRAyaQBtaJkZsjftTjnfLzmCAjtQLiVySgwZBbHmtdFurLBZeXWdzuxtCuXGoNMuNpVMTbBjFfcKUvqcNnnDalJtCSmaSiohrvoJihkThkOkmoCVSgHoeGaGUjiXWNxSYoIX",
		@"VbzlGPQRLCeT": @"zpKLyDcBBpwlNxrYpasQgmvzqFjSLZRvMFcwGkmHzaWzPhFyPuKQZnvuLkvFSCUOWCiCoHRJxpCSICFDxIsuOIuddAKjasxDAWAwcHzFDaCMUtsYFVqPFzbcoPJjGNJKebcnjhz",
		@"HioQgUTqaYpwuUQDDj": @"UPqHrRLCvUmXVqErgHRhHHCZjAMEYixJQKaOwuZJgMBiJVwWuFvcIGVTukfwRhNDPDbDcJZUAnnTcKZhSnEPesNNDCXLlNeLSXmvVDhPfuETCEHVgolnCEyAZlZZGdLSKPetuRAciLy",
		@"fCjbpTjYwugqaWkAc": @"DhSFhjlNOcODhIOGKPYeuiXOCfYTLwTOfKnzRAuBklhNwHWePuNiTDVMtnjwUVSzydJMEubtWAuHYsDDbqWNYpIVnmoXcdjlYDWkyPbcIjpRVcNziwCk",
		@"gEatVjcMAYMPtwe": @"RzjKOlBkbtaGiByAnfdRAGBhqNKSmpOYBHCblRBKxKxegjuvodvaMwHknLPGRPwphmGrkBDAPmzxlNDWYzygTAIZdpbgAUGpfGBfuTSiVeGTbHnaOMxDpRTZaxtIuqNycnIxHGDUODvhOKWI",
		@"aToicasdjB": @"FbrgHsmnegWicyiIAtruGikCvWSTVldMQhJtXFAWNrYCBGhzSgcQucAvGkrAlUpDLynBoyRncGKEYyBLEnToRuRIRIArJELQZCdCKFCsaJnGYaWYhWTeUXLrs",
		@"ehGTfQdWpfXRn": @"MPJmhIinQpAcZwyrtBesjgqNnEIkudNDhipjXBsqKAECpJsuOjMpFZAzrpMgsjVzkdleGVfMZPRhHhKHlSntFtvsmezkvggZusNLGpeytuZQnmWbzEYagsIEiHMGskXeFEIqVBMjYUiZIGh",
		@"OrtvoGBQLkrT": @"BMbdxIyCcUQOPAUQNQvKrguYlwnOEONWFcdSOfiPlepZkWbqWdeqNfzikVOeaooSjejaYiHodnnlJzoQYQTTHRHryDpuFLVxNgHhTxXuVoRsYTKYefQWOuEooZEajwgVxYZZJa",
		@"BwuHilfwhzPFWJMIMGk": @"TvfnPNkSZjCxioSrdVRxJitBThdsCmWOlWfNsIzOIaGueXEKkSbxakZbqTjKXInZXDxCnGXHoqbQREgxbEsaLwkxOgEABrumQKYlmApvPPwKZrmyhnFHteoRuSxOEtrHrqbIxWMFolBJLngdGbWy",
		@"lAcaWYPbAkI": @"TIFEnHeiXGHGQOTpTWSmhZhCqDMZmjsAuvTFVvcKeDPBHPOEOoSuHKgzbbvJHWqUFJhqCVJyTiJFDSErSrywSJzMcZAVnPtYgwpADdPecXwiEmLAdHjERdL",
	};
	return AYGhXbZMSF;
}

+ (nonnull NSDictionary *)yDQcSVDADzIdzjAVl :(nonnull NSData *)kWLKvDmgwG {
	NSDictionary *IPrlwcCAxYvwWX = @{
		@"odlwpOtadZpyan": @"gTLiLmQvqjOcwVjXpTBEEGKpWOZZFoUEykriHGljXmzsTLldGGzoYzzGYMiPTGMIcBJBfmARUANNGiUeIVotElbVKeGOjIByXzgOjvaCrcJVhcuasaFMjOn",
		@"qfEzqmYMFvNy": @"szUsWlSKoWofDCWtZhesKcZGazaQLPkmBhgCvGvEUtaobLehKhEQpMftOJoCnMciBQVZsVAiAYcPqcVRqtoSHCYVRIwbSPUSxSHwuZxIzCxzFFpYokaHVgJtUiSsQpagmtZoL",
		@"ZdMYphqfKGWQzGeiYu": @"dlUHxlUgPdzpjiLqJeQrOIOoETjvLBTqKQZQySnqhxtvvDEeiBQAfZjvLZPHugZaqyZdthzqqVqklYrdpymzcNvVbSAIqyKhCHDL",
		@"CpvOmgjVEKXa": @"pCzRhXfXXINyMsZaPYWSaUWTtdLGhWgVUYZjaEkCiZmCVWveaTcFRoLFbrUUruvfWLPwNsTEpVPDiPmfGvQfVKvpvfiAUbBDaNZgCZfCOVqdrnKbUpyYw",
		@"UoSOQEsBYlUE": @"OejovllfTEDMJHgMbqDUlMEfsCMsJtWTVVVWqbTxAwKyjgjuAYYHXYlnTNRDEyusOVqOPAdDArdUSMwRDwdoWkrhoFvSxkPUdfddOpLudyvYFsE",
		@"AzadXOCmvPtvseQhvia": @"jilineqfeVbqoqIcikfaVyUEYJeyztgzgjJYclIgMCeZveqdcDYgMJVkPeMDOZCDLwcKCVKkZlHGycEKEvYAegikSkFMLqunTycPUzbBDKhkoOjBSrZER",
		@"lbtaonIWYzf": @"vTyafVspjmqQqDgEspcVTrTrZNyhBHliIuNOKTkyXwzSiipCywazyxmftzdIFBkqvWQkDsbyRIyIiBpdKUvcGcDUXuyrBABBXxdNVaUgriP",
		@"zpOIPRkzaukyLunWEd": @"HAqgRdJybUdMXieCOgMSYuJRJEpFcSyjJTZvfDdGITAHqvqHqFzHKeeLyJLizSWCxzHnBahlTECPWyMMwgyYaeArosawSqRJCpuCnPAHVABcqOOJAUcBIpbPEPerHvtDstlLJtCMoO",
		@"hLlJPOGBVjWjr": @"XVUMVbrmMmpoKvBQpvGQDjVvlnZVnsYaWlJNPPAxPIXbTgnYDYtikqACxuzdtJAjIzPHRGLBJVjMvemeWoTmBkPFJeGOFdOdveKAQYuepKEaUlCxkxyEkRzqxaMYsgBwTyXksI",
		@"lsZDgfMOjVx": @"RXdEziaqGDuavIjhITNjECDHSmxzjOmjGUShpwjOitvNXlyQjCdvgdrGyVJChGScPuRpFDsPLdDeJnVVaoOZYQseROlFryVjkxtbgLDZhTdzWcHozgKfuqrDsS",
		@"cPjxWfODFx": @"VPQauNgNWLMlNYQpMPtxsnlBjrwpWrdWCBxyQfLTETIQlrrnJYfGsNbfzFVoFYrLKtIRdMVlNPygXQEWEARuzKDRLmcIpWiYIGsMjPAFHihtwOLDf",
		@"zqljJARkTavcLWXxE": @"kzBvBqOLYpJOjZhBgoTcrHTNMOmhfIJorugTYxfxWBKisCtUYLznstAyOxwXKWWAjUWgMneszXkmpChAuosjTjiEqdxjDfXLtOIfNfSarfOMBbnCdAD",
		@"fTPwnVnSBhkxh": @"ElBjcjtejWqaWSRTROhIVxxrTPsQxDWYGJptvRfrDEcetRWPQpszuySaQLtwheMeXCiBIrOBDbyoLjIbeiRNeyNwTdScnXLWELYviavWzTYRPg",
		@"ezYaDoFfnYO": @"tDwvIhaLgdNrYgcBAfMpzmkscPtwUzVqTNaWmuEtEmwUOfhOxCBrAYYidasxeOmjBBnCSscjXfNbaBHlczpgVFPFICsejDnLYObyTYLujQFLIWQhxVWGkucsIOLAmOoGzqkZPjY",
		@"hqgUpjeaIfvXqQwYVVw": @"wcPvgyPaJXFwZDTFmqFedKpddyHTTpmPFkgKSvPHsaVqoHdWCXsBOBDwvJqpZnTlEmMHCMoENLlMbGgzDnGcRrQwJhXntjbWMtAlrAWLuUaYP",
		@"soqpmBJulbUVaoJp": @"uFGbjVGsYnTaaRAHOQNHmIkILOHjOQxSPZrNLNvCZSVfNbeerMyWzRoIMHljkTcBAgMOzrREPWcDZEHXmLKgBGFoLSHfIdScIbDUwxwrtuLSDLXmXBQmpTibVUpgFhOzscShcN",
	};
	return IPrlwcCAxYvwWX;
}

- (void)sd_cancelCurrentAnimationImagesLoad {
    [self sd_cancelImageLoadOperationWithKey:@"UIImageViewAnimationImages"];
}
@end
@implementation UIImageView (WebCacheDeprecated)
- (NSURL *)imageURL {
    return [self sd_imageURL];
}
- (void)setImageWithURL:(NSURL *)url {
    [self sd_setImageWithURL:url placeholderImage:nil options:0 progress:nil completed:nil];
}
- (void)setImageWithURL:(NSURL *)url placeholderImage:(UIImage *)placeholder {
    [self sd_setImageWithURL:url placeholderImage:placeholder options:0 progress:nil completed:nil];
}
- (void)setImageWithURL:(NSURL *)url placeholderImage:(UIImage *)placeholder options:(SDWebImageOptions)options {
    [self sd_setImageWithURL:url placeholderImage:placeholder options:options progress:nil completed:nil];
}
- (void)setImageWithURL:(NSURL *)url completed:(SDWebImageCompletedBlock)completedBlock {
    [self sd_setImageWithURL:url placeholderImage:nil options:0 progress:nil completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        if (completedBlock) {
            completedBlock(image, error, cacheType);
        }
    }];
}
- (void)setImageWithURL:(NSURL *)url placeholderImage:(UIImage *)placeholder completed:(SDWebImageCompletedBlock)completedBlock {
    [self sd_setImageWithURL:url placeholderImage:placeholder options:0 progress:nil completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        if (completedBlock) {
            completedBlock(image, error, cacheType);
        }
    }];
}
- (void)setImageWithURL:(NSURL *)url placeholderImage:(UIImage *)placeholder options:(SDWebImageOptions)options completed:(SDWebImageCompletedBlock)completedBlock {
    [self sd_setImageWithURL:url placeholderImage:placeholder options:options progress:nil completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        if (completedBlock) {
            completedBlock(image, error, cacheType);
        }
    }];
}
- (void)setImageWithURL:(NSURL *)url placeholderImage:(UIImage *)placeholder options:(SDWebImageOptions)options progress:(SDWebImageDownloaderProgressBlock)progressBlock completed:(SDWebImageCompletedBlock)completedBlock {
    [self sd_setImageWithURL:url placeholderImage:placeholder options:options progress:progressBlock completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        if (completedBlock) {
            completedBlock(image, error, cacheType);
        }
    }];
}
- (void)cancelCurrentArrayLoad
{
    [self sd_cancelCurrentAnimationImagesLoad];
}
- (void)cancelCurrentImageLoad
{
    [self sd_cancelCurrentImageLoad];
}
- (void)setAnimationImagesWithURLs:(NSArray *)arrayOfURLs
{
    [self sd_setAnimationImagesWithURLs:arrayOfURLs];
}
@end
