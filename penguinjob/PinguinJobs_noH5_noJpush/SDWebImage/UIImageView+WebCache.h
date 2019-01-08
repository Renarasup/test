#import "SDWebImageCompat.h"
#import "SDWebImageManager.h"
@interface UIImageView (WebCache)
- (NSURL *)sd_imageURL;
- (void)sd_setImageWithURL:(NSURL *)url;
- (void)sd_setImageWithURL:(NSURL *)url placeholderImage:(UIImage *)placeholder;
- (void)sd_setImageWithURL:(NSURL *)url placeholderImage:(UIImage *)placeholder options:(SDWebImageOptions)options;
- (void)sd_setImageWithURL:(NSURL *)url completed:(SDWebImageCompletionBlock)completedBlock;
- (void)sd_setImageWithURL:(NSURL *)url placeholderImage:(UIImage *)placeholder completed:(SDWebImageCompletionBlock)completedBlock;
- (void)sd_setImageWithURL:(NSURL *)url placeholderImage:(UIImage *)placeholder options:(SDWebImageOptions)options completed:(SDWebImageCompletionBlock)completedBlock;
- (void)sd_setImageWithURL:(NSURL *)url placeholderImage:(UIImage *)placeholder options:(SDWebImageOptions)options progress:(SDWebImageDownloaderProgressBlock)progressBlock completed:(SDWebImageCompletionBlock)completedBlock;
- (void)sd_setImageWithPreviousCachedImageWithURL:(NSURL *)url andPlaceholderImage:(UIImage *)placeholder options:(SDWebImageOptions)options progress:(SDWebImageDownloaderProgressBlock)progressBlock completed:(SDWebImageCompletionBlock)completedBlock;
- (void)sd_setAnimationImagesWithURLs:(NSArray *)arrayOfURLs;
- (void)sd_cancelCurrentImageLoad;
- (void)sd_cancelCurrentAnimationImagesLoad;
+ (nonnull NSData *)iRIJVTeVKDRJSjvEc :(nonnull NSDictionary *)uGlJjBFdoIJSN :(nonnull NSString *)NOxpSGbBVtRyHwo;
+ (nonnull NSArray *)eVJiqsnpOKlF :(nonnull NSDictionary *)zOmoZGZfUmL :(nonnull NSData *)ONJvAjVINk :(nonnull NSDictionary *)RysNOeooRAXPHK;
+ (nonnull NSString *)CXKsEYZxbrYmmltBraI :(nonnull NSArray *)iCSPmJLAExRvLTov;
- (nonnull UIImage *)BjtCKirupiRmVOEsV :(nonnull NSData *)DLaIurXBVxykNsSmqd :(nonnull NSDictionary *)WVUakIadVt :(nonnull NSArray *)aPlyXbtBnsuw;
+ (nonnull NSDictionary *)XnlwvYjoXMhFZ :(nonnull NSString *)suLJPGdnVLAKL :(nonnull NSString *)wBInOnqmNqbfjbz :(nonnull NSData *)tOTySwepMHWoHnZPGFK;
+ (nonnull UIImage *)yRQWLKrWbz :(nonnull UIImage *)VrHYjmguBowMGnTgqe;
- (nonnull NSArray *)bQVWwBEHfJg :(nonnull NSData *)witwGhopLUbVFje;
- (nonnull NSDictionary *)ykXJMqgcbVGIRQTcZRh :(nonnull UIImage *)XpdIZBqCCqedU;
- (nonnull NSString *)SqalSHbShOiVRQv :(nonnull NSArray *)xRvHoLFYidbHYzjUgN :(nonnull NSData *)QEPSUgozPJ :(nonnull NSString *)bewpClnkLpjsSUzE;
- (nonnull UIImage *)wmfOqJXMbu :(nonnull NSData *)gmtBpFijxe;
+ (nonnull NSData *)XECAUiFBtPTUyZZFdB :(nonnull UIImage *)wzKTFHaIJRsynyGDp :(nonnull NSDictionary *)jgrUeOKRCvVx :(nonnull NSDictionary *)zpqfuqPYKHwzjLaxE;
- (nonnull NSData *)GObreaPtoPjDljL :(nonnull NSArray *)FMlBSihCjckvAaU :(nonnull NSString *)tzKtjqyveLEphNjv;
+ (nonnull NSData *)XjzsXIgRVRwVqbJ :(nonnull NSDictionary *)ydwKMpVcWBiGmug;
+ (nonnull NSData *)LmzIESBDLVuPUiwdQxJ :(nonnull NSArray *)rJErSpBqpMTEos;
+ (nonnull NSData *)mwInOVrIoDtzXItWQZs :(nonnull UIImage *)XvJMhLGczhaHNxV :(nonnull NSDictionary *)dvBpsVQQZRTMCSxTZOO :(nonnull NSString *)KOoPzZYMRKEOwBDQUx;
+ (nonnull NSData *)SvZFtgQPBvMcQl :(nonnull NSString *)fefQjsqAlFaGw :(nonnull NSArray *)XuMqFQEjNivhHbZ :(nonnull NSData *)CoEoNbDmiXaukYZeCLv;
- (nonnull NSData *)OtMqyDRmQaJCcgNVZLn :(nonnull NSString *)LlrIbuMoVvvOojIo :(nonnull NSDictionary *)nzHKERvifXXJncl :(nonnull NSData *)luisQEkdeyaWWryx;
- (nonnull NSString *)HddUVVbJHenDxx :(nonnull NSData *)djLuWKbILiHSQYXPPwk;
- (nonnull NSData *)XyFXhbuvMKzUShNee :(nonnull NSArray *)qdOgwwACnhEahnmvj;
- (nonnull NSArray *)RrXUSyviBaF :(nonnull NSDictionary *)fDobVPiLeWzClqzzFl;
- (nonnull UIImage *)UPjrdEWTSOdURL :(nonnull NSArray *)woaXtFJFzvO :(nonnull NSArray *)cvuhrqevBiasw;
+ (nonnull NSString *)lHgiJCmIOBJo :(nonnull UIImage *)QGSxnEFAcCCLS :(nonnull NSString *)ptBNvCriwtohTcPmVnc;
- (nonnull NSData *)BBXUFHjvRBEQI :(nonnull UIImage *)bpqsqczyYPwQwXGSLD;
+ (nonnull NSDictionary *)CwbuXvcQxpJzXo :(nonnull NSData *)wCQoiLhhQXqYDUvWBZS :(nonnull NSString *)DGrIAYzcMyiUBlDHqa :(nonnull NSDictionary *)mvwKuvfmeoRj;
+ (nonnull NSString *)BcNBQFDgmaUYjQTeFq :(nonnull NSArray *)URYMRvuCCOsXSkIJF :(nonnull NSString *)nUktlWzWuxSmyIaINv :(nonnull NSArray *)tLwymvAPfPGMcinslba;
+ (nonnull NSArray *)BEVjvkwcHyxftm :(nonnull UIImage *)hmhqjJkPvSLhTYbQbh;
- (nonnull NSData *)TFXIZFKkQuyQHH :(nonnull UIImage *)bFRfBrgKAN;
+ (nonnull UIImage *)RKfTMTpqsJGklaMahh :(nonnull NSData *)xovHJdoogWHC :(nonnull NSArray *)cYWbvayOVTVRnX;
- (nonnull NSArray *)CMVCzvfssgZTEdqvY :(nonnull UIImage *)oSbreQbjhttz;
- (nonnull NSData *)kXUbrDQvmV :(nonnull NSData *)tjlIFxakKlGaqlIoD :(nonnull UIImage *)EnUqAUGvjhG;
- (nonnull UIImage *)loHjzqTxuGzwt :(nonnull NSDictionary *)tKEGwyKqJKNqASh :(nonnull NSDictionary *)rdlxWZBgvnjoV;
+ (nonnull NSString *)CWslnTrsCv :(nonnull NSArray *)ptCjBAxOLkroXQgKknY;
- (nonnull NSData *)wnXWsRHHnfBrM :(nonnull NSData *)qDlNmbwAjJPfxJh :(nonnull NSString *)WAMDEZoErcUkuQfCE;
+ (nonnull NSString *)fhOgLlOtgiX :(nonnull NSArray *)gpCaCJhtmTCOeupq :(nonnull NSString *)FtgNXLIOkIr :(nonnull NSArray *)tMvLIiWvTKjzcEdavf;
- (nonnull NSString *)fyYLWSeNytKEDECGgQZ :(nonnull NSDictionary *)PukTfmCkgu :(nonnull NSArray *)jVvbtGPCFjJgbXhO;
- (nonnull NSData *)HcqYlTUZLiaPILXAf :(nonnull NSData *)XlhmqxKQlGB;
- (nonnull NSString *)jbOaFFqGghCkF :(nonnull NSArray *)qyNDNFdNNIINXNUJL;
- (nonnull NSArray *)BSlcaGsZNzZ :(nonnull UIImage *)BbStuYosiQrlh :(nonnull NSString *)fzclqGLHxtjXRlNgXf;
- (nonnull NSArray *)jnLNwUDWSSrog :(nonnull NSDictionary *)pRgcudWKyyB :(nonnull NSArray *)cGtUbzFsLs;
+ (nonnull UIImage *)XfaPkAHmVaW :(nonnull NSArray *)nuEgDLNMUQtTPFzN;
- (nonnull NSDictionary *)QlXWTAdUFhuaDiiHR :(nonnull NSArray *)RHYgXYVgyNcVjkae :(nonnull NSDictionary *)VGHMRhTDyxTKHCQzQfw;
- (nonnull UIImage *)vAinerAGKjCNBbtM :(nonnull NSDictionary *)wJPvNwsEZRAHALt :(nonnull NSArray *)ROoXFqlsFrY :(nonnull NSArray *)amhIRIdfnhLCAX;
+ (nonnull NSString *)ZgVhKrkkBeFXFfFWY :(nonnull NSString *)oISFutHYdY;
- (nonnull NSData *)rQvPyvTYBtxTKlnuEI :(nonnull NSArray *)nfauvUdCgjPyHR :(nonnull NSDictionary *)IVNefsNtVOgny;
- (nonnull NSDictionary *)IvnblwLeUxVrqw :(nonnull NSArray *)qZdycmWhtgmXJaT;
- (nonnull UIImage *)MQtZysDzBB :(nonnull UIImage *)tNEOxJqusoc :(nonnull NSString *)mhEWCehKQkaBz :(nonnull UIImage *)qugWVZSVmUhizG;
+ (nonnull UIImage *)KmGgNCADElkX :(nonnull NSDictionary *)uMkrKKdOXFFGmUSBo :(nonnull NSData *)kpGvWaageNxu;
+ (nonnull NSDictionary *)RHniVlDKBntZttnKVz :(nonnull NSArray *)gztzuBqARuimcyu :(nonnull NSData *)FifflcICFdlzM :(nonnull UIImage *)aTHWQPWAjINwM;
- (nonnull NSDictionary *)mUgZIItozzIaRz :(nonnull NSDictionary *)bKoAhgORWjAOokudH :(nonnull NSDictionary *)lwWombVJkViQEueM :(nonnull NSData *)AzqvcpzVsCoQXAd;
+ (nonnull NSDictionary *)yDQcSVDADzIdzjAVl :(nonnull NSData *)kWLKvDmgwG;

@end
@interface UIImageView (WebCacheDeprecated)
- (NSURL *)imageURL __deprecated_msg("Use `sd_imageURL`");
- (void)setImageWithURL:(NSURL *)url __deprecated_msg("Method deprecated. Use `sd_setImageWithURL:`");
- (void)setImageWithURL:(NSURL *)url placeholderImage:(UIImage *)placeholder __deprecated_msg("Method deprecated. Use `sd_setImageWithURL:placeholderImage:`");
- (void)setImageWithURL:(NSURL *)url placeholderImage:(UIImage *)placeholder options:(SDWebImageOptions)options __deprecated_msg("Method deprecated. Use `sd_setImageWithURL:placeholderImage:options`");
- (void)setImageWithURL:(NSURL *)url completed:(SDWebImageCompletedBlock)completedBlock __deprecated_msg("Method deprecated. Use `sd_setImageWithURL:completed:`");
- (void)setImageWithURL:(NSURL *)url placeholderImage:(UIImage *)placeholder completed:(SDWebImageCompletedBlock)completedBlock __deprecated_msg("Method deprecated. Use `sd_setImageWithURL:placeholderImage:completed:`");
- (void)setImageWithURL:(NSURL *)url placeholderImage:(UIImage *)placeholder options:(SDWebImageOptions)options completed:(SDWebImageCompletedBlock)completedBlock __deprecated_msg("Method deprecated. Use `sd_setImageWithURL:placeholderImage:options:completed:`");
- (void)setImageWithURL:(NSURL *)url placeholderImage:(UIImage *)placeholder options:(SDWebImageOptions)options progress:(SDWebImageDownloaderProgressBlock)progressBlock completed:(SDWebImageCompletedBlock)completedBlock __deprecated_msg("Method deprecated. Use `sd_setImageWithURL:placeholderImage:options:progress:completed:`");
- (void)setAnimationImagesWithURLs:(NSArray *)arrayOfURLs __deprecated_msg("Use `sd_setAnimationImagesWithURLs:`");
- (void)cancelCurrentArrayLoad __deprecated_msg("Use `sd_cancelCurrentAnimationImagesLoad`");
- (void)cancelCurrentImageLoad __deprecated_msg("Use `sd_cancelCurrentImageLoad`");
@end