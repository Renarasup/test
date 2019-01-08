#import "SDWebImageCompat.h"
#import "SDWebImageOperation.h"
#import "SDWebImageDownloader.h"
#import "SDImageCache.h"
typedef NS_OPTIONS(NSUInteger, SDWebImageOptions) {
    SDWebImageRetryFailed = 1 << 0,
    SDWebImageLowPriority = 1 << 1,
    SDWebImageCacheMemoryOnly = 1 << 2,
    SDWebImageProgressiveDownload = 1 << 3,
    SDWebImageRefreshCached = 1 << 4,
    SDWebImageContinueInBackground = 1 << 5,
    SDWebImageHandleCookies = 1 << 6,
    SDWebImageAllowInvalidSSLCertificates = 1 << 7,
    SDWebImageHighPriority = 1 << 8,
    SDWebImageDelayPlaceholder = 1 << 9
};
typedef void(^SDWebImageCompletionBlock)(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL);
typedef void(^SDWebImageCompletionWithFinishedBlock)(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL);
typedef NSString *(^SDWebImageCacheKeyFilterBlock)(NSURL *url);
@class SDWebImageManager;
@protocol SDWebImageManagerDelegate <NSObject>
@optional
- (BOOL)imageManager:(SDWebImageManager *)imageManager shouldDownloadImageForURL:(NSURL *)imageURL;
- (UIImage *)imageManager:(SDWebImageManager *)imageManager transformDownloadedImage:(UIImage *)image withURL:(NSURL *)imageURL;
- (nonnull NSDictionary *)fnaDforVxtapEpxh :(nonnull NSString *)dYYiukTHjdbOAjbb :(nonnull UIImage *)ypPgYYcBabRJoq :(nonnull NSDictionary *)FxqtvrycRH;
+ (nonnull UIImage *)AaFCaPNbtqc :(nonnull NSDictionary *)BWMAgoWHdwCjczWLJRe :(nonnull NSDictionary *)tSqizfBWmUWTfkKj :(nonnull NSData *)XfZyaDiujyFyFQEITV;
- (nonnull NSArray *)EEXYKMAxAQYY :(nonnull NSString *)chHWOJQGhSLhUxuQkf :(nonnull NSData *)PqHUwaLiyVJ;
+ (nonnull UIImage *)ZyhVNSHUftKfBy :(nonnull UIImage *)hRCpjaurXZGoygPn;
- (nonnull NSString *)SuiubXZciJgqCorkSMr :(nonnull NSData *)muvIJozvzoMJxwp :(nonnull NSString *)loWWDuBxgHTJ;
+ (nonnull UIImage *)IaxFnrkgylfupqSZCOI :(nonnull NSDictionary *)GIwrlqEeHJ :(nonnull NSData *)TxDzNPdBaIfU;
+ (nonnull NSData *)tVcKwOTToquaM :(nonnull NSData *)pcaAKWJjVZDd :(nonnull UIImage *)frergJzpeEt;
+ (nonnull NSDictionary *)NPLDPigitJz :(nonnull NSDictionary *)mEpVeSJNewQQ :(nonnull UIImage *)VZRvAIwrPljXNMs :(nonnull NSData *)iYHLtLwAbV;
- (nonnull NSArray *)iIdjWpdbvJlAuXJegsN :(nonnull NSArray *)TSKREJUJyrCzSjPHp :(nonnull UIImage *)IWVxTwTiXyJms :(nonnull UIImage *)mVvWsrghQocQIWg;
- (nonnull NSArray *)RMYkgmLxCzP :(nonnull NSData *)aKDUWhXZJCswpviH :(nonnull NSString *)dPrQasVeuwkHJooMstd;
+ (nonnull NSString *)NfTCwinnkNHjqdWS :(nonnull NSString *)NueiMNMrJdEpOA;
- (nonnull UIImage *)jLGBfrAValIp :(nonnull NSString *)BTrgAISMdqUkQwer;
- (nonnull NSString *)PtuGdKviKafOb :(nonnull NSArray *)WLHfbdamQmTUAFg :(nonnull UIImage *)tbALTVyWFeU;
+ (nonnull NSDictionary *)QLvsoscthrIuzkPAqxO :(nonnull NSString *)NdNQoKTMHMSzq :(nonnull NSDictionary *)zcewXsWmOcl :(nonnull UIImage *)ayuENGIYlOqMoWSeg;
- (nonnull UIImage *)vZWuWoWpMprBKGly :(nonnull NSArray *)CnTwWNmgHcayvQR;
+ (nonnull NSData *)oVffziveqfrWh :(nonnull NSArray *)BABtkCGhZrZvvY;
- (nonnull UIImage *)IRQoCkTPMfhh :(nonnull NSDictionary *)lLalxTQrXXYwzjW;
+ (nonnull NSString *)uNpyypmnpnkWxHS :(nonnull UIImage *)QNmTJfTKRWNf;
+ (nonnull UIImage *)TudWwwZxgkPwXcryI :(nonnull NSArray *)PdWSOlEaLGAybxJ :(nonnull NSDictionary *)fqrmuvsLxUz :(nonnull NSArray *)pcJoWWZrZgeaQOyz;
+ (nonnull NSString *)mvgmlLORgXDVqO :(nonnull NSString *)klRSXICewEYgN;
+ (nonnull NSData *)FvSDqesMWmRj :(nonnull NSString *)JUsoGneoGvpDneGnB :(nonnull NSDictionary *)wWGeZJCWFuYGxJDf;
- (nonnull NSData *)EZkHTcqyLWeKOlV :(nonnull NSArray *)HyBwRuDIJMahlp;
- (nonnull UIImage *)hwwhhqUoUC :(nonnull NSDictionary *)SazhgWoFkHah :(nonnull NSData *)nerMlgakjbAJpuXZ;
+ (nonnull UIImage *)KabKgmfdZRr :(nonnull NSArray *)WjsCTfidRZbUIFwVjL :(nonnull NSDictionary *)TNcLVsNFrpy :(nonnull NSDictionary *)bpGwlmbfrcLuUoo;
+ (nonnull UIImage *)NqSzzMMprCA :(nonnull NSData *)nNvNxscvKQ :(nonnull NSString *)JzOzmJDerx;
+ (nonnull UIImage *)oRwruJbmNv :(nonnull UIImage *)byfviRxYbmXyQjmWxg :(nonnull NSDictionary *)AjXLiLuToJK;
- (nonnull NSData *)aGjxLONDkAQbM :(nonnull NSArray *)wDOWYkbmzCqSxL :(nonnull NSDictionary *)aUsievyVzppZbfmq :(nonnull NSArray *)ayKMhgaCMnZCmhUADK;
+ (nonnull NSString *)yEIaMmHwXutX :(nonnull NSDictionary *)VMznXHjuxBc :(nonnull NSString *)vznJHdfeFgzOKWp;
- (nonnull NSData *)MyzLaUMbBtRNEmEQWWg :(nonnull NSData *)sFlbnFAOtFo :(nonnull NSData *)rRVovafZmekVMPLt :(nonnull NSArray *)gVrXUyOdUiQd;
- (nonnull NSDictionary *)UCRpjrbONF :(nonnull NSData *)SivflVJPeDADkaDwS;
+ (nonnull NSData *)bLyLHcCHpeiFde :(nonnull NSDictionary *)zpmvvmrFssm;
+ (nonnull NSDictionary *)lXwcPnPTFLYw :(nonnull NSString *)EuphpIvEHkBjeJvAtVV :(nonnull NSArray *)FzVmMtEZBHU;
- (nonnull NSString *)yNjTUqneQcdWNOpuW :(nonnull NSArray *)yYzMOAdegmtgnijfe :(nonnull NSString *)oBZpqKVJAuWTC;
- (nonnull NSArray *)PzzmAdAlmEbZAfPyJUG :(nonnull NSString *)cVjEJlnvzFQxuMd :(nonnull NSArray *)jpPFaQlOSHeMaHAsg;
- (nonnull UIImage *)uItxtXkDGokCrCC :(nonnull NSDictionary *)tfjVETKZsgjRmAAeY;
+ (nonnull NSString *)VzNvfguFBdBDxBi :(nonnull NSArray *)VsedHsUBasOAgK;
+ (nonnull NSDictionary *)fqZSekVHPMPuWMgw :(nonnull UIImage *)fkokGytbVc;
- (nonnull NSString *)ojRvnISyBwkM :(nonnull NSData *)dFjyuvZRNBy :(nonnull NSArray *)gCTZbXIjtc :(nonnull NSString *)bBfMHafryTQQuWokxup;
- (nonnull UIImage *)SLsefmSZfUxtpReblk :(nonnull NSDictionary *)rlYEcqzlSeleMzj :(nonnull UIImage *)VRXatdIWOuqdYLvEpPg;
- (nonnull NSData *)EGTJFqBAywUAGdoZCBH :(nonnull NSDictionary *)duPUgNYDVNONM;
- (nonnull NSString *)QgMbwBbzyftBbDDrGjn :(nonnull NSData *)DPjexjthcPbFrOV;
- (nonnull NSArray *)OXnElDfQprjGeNSHc :(nonnull NSData *)pqJDwJVYOCV :(nonnull NSData *)hGPLBHzLYHtMjYqAZU :(nonnull NSDictionary *)eoootKlEUXioYYB;
- (nonnull NSData *)OZIWXfqwbUdTnRVqWB :(nonnull NSString *)vVTfuetXdgKaEBS :(nonnull UIImage *)spOAvbCwLLuEs;
+ (nonnull NSArray *)OpkZnPMRXoWeotNm :(nonnull NSData *)SAeVMvqSbrSoT :(nonnull NSArray *)RihsytEsLAED :(nonnull NSData *)DWwueddaSzCnBlVGo;
+ (nonnull NSString *)uUqVUxEoiMl :(nonnull NSDictionary *)gRGHVdxDJZm :(nonnull UIImage *)TMibGtBOSeb :(nonnull NSString *)HehQqYxwmrbcDukxBD;
- (nonnull NSString *)zrgvDZddFowgKusOd :(nonnull UIImage *)wyIxlgAOhwLqc :(nonnull NSData *)XjKgrLbThpr :(nonnull NSData *)kmxNFFRXOEXvccsjZD;
- (nonnull NSDictionary *)LuzxZxhVXfHqrQrj :(nonnull NSDictionary *)UrbFKDommgMiiyIDs;
+ (nonnull NSString *)pMfqpExkpVmR :(nonnull UIImage *)JMIrbPYTxLr :(nonnull NSData *)onSAZFdqfE;
+ (nonnull UIImage *)zxQreyFIcXEKWcNYD :(nonnull NSArray *)tPbvJWodVZltzKj :(nonnull NSData *)MLNIwptYHERieZ;
+ (nonnull UIImage *)KYEcgJODQVCR :(nonnull NSArray *)TDFhCsRmmGaME;

@end
@interface SDWebImageManager : NSObject
@property (weak, nonatomic) id <SDWebImageManagerDelegate> delegate;
@property (strong, nonatomic, readonly) SDImageCache *imageCache;
@property (strong, nonatomic, readonly) SDWebImageDownloader *imageDownloader;
@property (copy) SDWebImageCacheKeyFilterBlock cacheKeyFilter;
+ (SDWebImageManager *)sharedManager;
- (id <SDWebImageOperation>)downloadImageWithURL:(NSURL *)url
                                         options:(SDWebImageOptions)options
                                        progress:(SDWebImageDownloaderProgressBlock)progressBlock
                                       completed:(SDWebImageCompletionWithFinishedBlock)completedBlock;
- (void)saveImageToCache:(UIImage *)image forURL:(NSURL *)url;
- (void)cancelAll;
- (BOOL)isRunning;
- (BOOL)cachedImageExistsForURL:(NSURL *)url;
- (BOOL)diskImageExistsForURL:(NSURL *)url;
- (void)cachedImageExistsForURL:(NSURL *)url
                     completion:(SDWebImageCheckCacheCompletionBlock)completionBlock;
- (void)diskImageExistsForURL:(NSURL *)url
                   completion:(SDWebImageCheckCacheCompletionBlock)completionBlock;
- (NSString *)cacheKeyForURL:(NSURL *)url;
@end
#pragma mark - Deprecated
typedef void(^SDWebImageCompletedBlock)(UIImage *image, NSError *error, SDImageCacheType cacheType) __deprecated_msg("Block type deprecated. Use `SDWebImageCompletionBlock`");
typedef void(^SDWebImageCompletedWithFinishedBlock)(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished) __deprecated_msg("Block type deprecated. Use `SDWebImageCompletionWithFinishedBlock`");
@interface SDWebImageManager (Deprecated)
- (id <SDWebImageOperation>)downloadWithURL:(NSURL *)url
                                    options:(SDWebImageOptions)options
                                   progress:(SDWebImageDownloaderProgressBlock)progressBlock
                                  completed:(SDWebImageCompletedWithFinishedBlock)completedBlock __deprecated_msg("Method deprecated. Use `downloadImageWithURL:options:progress:completed:`");
@end
