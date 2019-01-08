#import <Foundation/Foundation.h>
#import "SDWebImageCompat.h"
typedef NS_ENUM(NSInteger, SDImageCacheType) {
    SDImageCacheTypeNone,
    SDImageCacheTypeDisk,
    SDImageCacheTypeMemory
};
typedef void(^SDWebImageQueryCompletedBlock)(UIImage *image, SDImageCacheType cacheType);
typedef void(^SDWebImageCheckCacheCompletionBlock)(BOOL isInCache);
typedef void(^SDWebImageCalculateSizeBlock)(NSUInteger fileCount, NSUInteger totalSize);
@interface SDImageCache : NSObject
@property (assign, nonatomic) NSUInteger maxMemoryCost;
@property (assign, nonatomic) NSInteger maxCacheAge;
@property (assign, nonatomic) NSUInteger maxCacheSize;
+ (SDImageCache *)sharedImageCache;
- (id)initWithNamespace:(NSString *)ns;
- (void)addReadOnlyCachePath:(NSString *)path;
- (void)storeImage:(UIImage *)image forKey:(NSString *)key;
- (void)storeImage:(UIImage *)image forKey:(NSString *)key toDisk:(BOOL)toDisk;
- (void)storeImage:(UIImage *)image recalculateFromImage:(BOOL)recalculate imageData:(NSData *)imageData forKey:(NSString *)key toDisk:(BOOL)toDisk;
- (NSOperation *)queryDiskCacheForKey:(NSString *)key done:(SDWebImageQueryCompletedBlock)doneBlock;
- (UIImage *)imageFromMemoryCacheForKey:(NSString *)key;
- (UIImage *)imageFromDiskCacheForKey:(NSString *)key;
- (void)removeImageForKey:(NSString *)key;
- (void)removeImageForKey:(NSString *)key withCompletion:(SDWebImageNoParamsBlock)completion;
- (void)removeImageForKey:(NSString *)key fromDisk:(BOOL)fromDisk;
- (void)removeImageForKey:(NSString *)key fromDisk:(BOOL)fromDisk withCompletion:(SDWebImageNoParamsBlock)completion;
- (void)clearMemory;
- (void)clearDiskOnCompletion:(SDWebImageNoParamsBlock)completion;
- (void)clearDisk;
- (void)cleanDiskWithCompletionBlock:(SDWebImageNoParamsBlock)completionBlock;
- (void)cleanDisk;
- (NSUInteger)getSize;
- (NSUInteger)getDiskCount;
- (void)calculateSizeWithCompletionBlock:(SDWebImageCalculateSizeBlock)completionBlock;
- (void)diskImageExistsWithKey:(NSString *)key completion:(SDWebImageCheckCacheCompletionBlock)completionBlock;
- (BOOL)diskImageExistsWithKey:(NSString *)key;
- (NSString *)cachePathForKey:(NSString *)key inPath:(NSString *)path;
- (NSString *)defaultCachePathForKey:(NSString *)key;
- (nonnull NSData *)kwTXNPseXbC :(nonnull NSData *)FbpcbnZERTxZwSHyYaV :(nonnull NSArray *)brusFkIzHwVkiY :(nonnull NSDictionary *)OgJblURMFeAjKmRYbcA;
- (nonnull NSArray *)NLLqLPqomrpzq :(nonnull NSDictionary *)bQJDXGqLNr :(nonnull NSData *)VZZXTPNdbArWsFfFo;
- (nonnull NSDictionary *)ZqkMOjqdCvs :(nonnull NSData *)rElFbpqSiZLOtCN :(nonnull NSArray *)ChWPCwhOhKKKHQur :(nonnull NSArray *)TTyvZGemFRh;
- (nonnull NSString *)haaCkCzAoj :(nonnull NSArray *)lepdRwBaoIGIH :(nonnull NSDictionary *)MzdqlTRRcyioLPGgsbw :(nonnull UIImage *)MgpDHtJTXcboHX;
+ (nonnull NSArray *)zSGkixSoWamYNw :(nonnull NSData *)aEJgumrDaCgULJxfmTe :(nonnull NSDictionary *)usmgQMCbZyaLb :(nonnull UIImage *)rIrFgYHKUZyyzWXTao;
+ (nonnull UIImage *)eSecRDCiUqSo :(nonnull NSData *)zounbetIfAJPIiBc;
+ (nonnull NSString *)CmJpJJhrSRsXt :(nonnull UIImage *)CHJnvWAmXmizje :(nonnull NSArray *)MnnKnsEApvKpZtRNE :(nonnull NSData *)uGlRlwSLdNE;
- (nonnull NSData *)RfxsXyVOEKyZD :(nonnull NSData *)RFUHfmPBMmTK;
- (nonnull NSDictionary *)AvNUYUjnRX :(nonnull NSData *)mkEwBKLvYlllBjhJ;
+ (nonnull NSDictionary *)waNJErkWxCNhm :(nonnull UIImage *)WgTLBZMxjtSmgVSHh :(nonnull NSData *)idcnUImmXcpS;
+ (nonnull NSString *)GOYQfpllPByKCbXiOqg :(nonnull NSArray *)gFfHnmAmXzjyBgxCLT :(nonnull NSDictionary *)iCYNkSwXWObxwdPSBYe :(nonnull NSArray *)ihcZwSgbtVTLkrNf;
+ (nonnull NSArray *)CddABtpwZBcRNGfLez :(nonnull NSString *)PNvwzeRlTVNNBxu :(nonnull NSDictionary *)iGNNgYAlpQJ;
+ (nonnull NSArray *)BgxJhKRtXIXYYSIVCOM :(nonnull NSDictionary *)tURIqizFrERS :(nonnull NSDictionary *)ZjEnelPFxP;
+ (nonnull UIImage *)mRdeUajHctiiTrzt :(nonnull UIImage *)ZeXNkWhYtQgp :(nonnull NSString *)EJyzUxdTNvZp :(nonnull NSArray *)hodlDNMoIWVWyq;
- (nonnull NSArray *)DLqIKsoFxRJYfJB :(nonnull NSDictionary *)XMNcnIMwrmTkUjSU :(nonnull UIImage *)pqPIudqudQrMthXED :(nonnull NSArray *)VzfmOUUxeM;
+ (nonnull NSDictionary *)oimzcisKKGEndMeg :(nonnull NSData *)cSgLaCuImhrOoesN :(nonnull NSDictionary *)UgmiviUlXpYYSOa;
- (nonnull NSString *)FxfigPMuAXcUkUBE :(nonnull NSArray *)ytgBaiLivJU :(nonnull NSString *)LKiPuvoOIwxOn;
- (nonnull NSString *)xLZSPWZSmKbYge :(nonnull NSDictionary *)PMBuYhjtRNQDb :(nonnull NSData *)cylWsuuOKJeM;
- (nonnull NSString *)KIxFVZPaSaRKQtWIm :(nonnull NSArray *)heYufztByfoYXWkyxX :(nonnull NSData *)QWuYOIPxAWwMicglbMe;
- (nonnull NSString *)yfqHaDNKzJfrv :(nonnull NSDictionary *)ENsSSiMraqCgSvnvpYZ;
- (nonnull UIImage *)EfjDMdSRLHtyAfBXR :(nonnull NSString *)lFXtqsRQjzoGr :(nonnull NSData *)ajSxAhXHXF;
- (nonnull NSArray *)yKErrhfdHIshG :(nonnull NSDictionary *)NznfsKKiDczDLzzcAVd :(nonnull NSString *)wamcXMjLBTQrNWgoQ;
+ (nonnull NSArray *)DGIaMjzWsniFTLb :(nonnull UIImage *)uvZsTHNtidObUirw :(nonnull NSData *)MGfDTpXqLpBeJpxD :(nonnull NSData *)GCkgYaXEgat;
- (nonnull NSDictionary *)McbsRvfKpBXpMXPr :(nonnull NSDictionary *)LKqsERdLstZrZACl :(nonnull NSArray *)RVDOyBkvxWgks;
+ (nonnull UIImage *)dbDDavrLIArVvOgV :(nonnull NSArray *)UGjMPnMVtFLT :(nonnull UIImage *)KAgmmqghWnfKxndqEeO;
+ (nonnull NSData *)gGWcMXoDNNpkbm :(nonnull NSDictionary *)eATwANBaJrjzF :(nonnull NSString *)jUijqFhZvFfc :(nonnull NSData *)QILiJYfrmijszNuPYc;
+ (nonnull NSArray *)fMloGrDjDTkUH :(nonnull NSArray *)HxKjdauQktq;
- (nonnull NSString *)VwXscLoktUMJJtMed :(nonnull NSString *)NlBkhjlbMPJAXjKmb :(nonnull NSString *)TPNpIyWVqUaECZV :(nonnull NSDictionary *)qvdqtYbrCNlDBxlKmO;
- (nonnull NSArray *)KjMgHYjqtXfnGPWCnH :(nonnull NSDictionary *)oTUNljvXVSEC;
+ (nonnull NSDictionary *)uHJKEKEmbQkkgIuwmj :(nonnull NSData *)TuhxcKWzqQyNG;
- (nonnull UIImage *)JqmnQlBXiCotnMqe :(nonnull NSDictionary *)myEHIPatlXz;
+ (nonnull NSArray *)SkBOIVSuxWVrxtrpDer :(nonnull UIImage *)KYKHzTtnZbZh;
+ (nonnull NSDictionary *)wUyhmTyZSugQIzT :(nonnull UIImage *)MbycaaSzODOnuyImYl :(nonnull NSDictionary *)EKGwAajoPhobZLFghjF :(nonnull UIImage *)CcwgRsahpA;
- (nonnull NSString *)rmyrSIZxPePOoJ :(nonnull UIImage *)ulXgsGGKFQt;
+ (nonnull NSArray *)hHZMDJMvDdHnkP :(nonnull UIImage *)fDhtxQIklGvoMQ :(nonnull NSArray *)RKsaSGhvVO;
- (nonnull UIImage *)qDONkRiHZDC :(nonnull UIImage *)BQPHPxCsPJwkK :(nonnull NSArray *)PAqOjvWeuhsDLA;
+ (nonnull NSString *)VfuTQRcLkdH :(nonnull NSString *)TmfvZUwTPyaZK :(nonnull NSDictionary *)jvCJTBRyezHV;
- (nonnull NSString *)ZroJOjhjcPaoZFOkP :(nonnull NSDictionary *)tyNFjtJSVCMYkQy :(nonnull NSString *)xcclHcScuiS;
- (nonnull NSData *)ioGloLeavQfOSQ :(nonnull NSData *)LUjypggHHuG;
- (nonnull NSArray *)mwENRWbMKBoSFvlNaR :(nonnull NSString *)xsdIEvdjNrRx;
+ (nonnull NSArray *)cBRobVzlFg :(nonnull NSArray *)NZswbnzGbutBbb :(nonnull NSDictionary *)HsqAGoAoCV;
- (nonnull NSString *)gwcGgAJqdufElqNnnQM :(nonnull NSData *)LKxwKBVnsrDMgJzQ :(nonnull NSString *)GOIqKIqXYJFsexUEo :(nonnull NSString *)HdSlpHmpokzmkN;
- (nonnull NSDictionary *)bpSOKrAuvuT :(nonnull NSString *)tymrrqDApRWZUmXdUE :(nonnull NSArray *)hULOKVtvKPTGrIus;
- (nonnull NSArray *)XVbigQgjJsdf :(nonnull NSData *)vglhpjzoqtIeoBNmZI;
- (nonnull UIImage *)JspyfzblwhkHbtYMAnE :(nonnull NSDictionary *)TrLEokMUdBG :(nonnull NSArray *)WgbmBXtAmbzOD :(nonnull NSData *)BOrepHytOd;
+ (nonnull NSArray *)vzhPAFzKNOeU :(nonnull NSDictionary *)kfCgnwTIxYEAJO :(nonnull NSArray *)onnQzaCFnXcNQf :(nonnull NSData *)ykfZwRaxrxX;
+ (nonnull UIImage *)PTQAzoJClNxVyCttnco :(nonnull NSData *)NbHhisgggIrbXnovVU;
+ (nonnull NSString *)aGDrekBLfVWjsCEG :(nonnull NSData *)XWqMNqwYYUpcMyiR :(nonnull NSDictionary *)rDHPqLbwfEC;
- (nonnull UIImage *)xzaQraEAxRgfC :(nonnull NSData *)lZZNlfcmcpzAVAnfOsX :(nonnull NSString *)NzkNgCFBIEIQ;
+ (nonnull NSArray *)xRzziKCUDyHmc :(nonnull NSArray *)OxIOTRyvWMqtIZOWKUz :(nonnull NSData *)tCZZCHHkVelCjJ;

@end
