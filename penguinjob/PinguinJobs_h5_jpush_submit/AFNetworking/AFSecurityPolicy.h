#import <Foundation/Foundation.h>
#import <Security/Security.h>
typedef NS_ENUM(NSUInteger, AFSSLPinningMode) {
    AFSSLPinningModeNone,
    AFSSLPinningModePublicKey,
    AFSSLPinningModeCertificate,
};
NS_ASSUME_NONNULL_BEGIN
@interface AFSecurityPolicy : NSObject <NSSecureCoding, NSCopying>
@property (readonly, nonatomic, assign) AFSSLPinningMode SSLPinningMode;
@property (nonatomic, strong, nullable) NSSet <NSData *> *pinnedCertificates;
@property (nonatomic, assign) BOOL allowInvalidCertificates;
@property (nonatomic, assign) BOOL validatesDomainName;
+ (NSSet <NSData *> *)certificatesInBundle:(NSBundle *)bundle;
+ (instancetype)defaultPolicy;
+ (instancetype)policyWithPinningMode:(AFSSLPinningMode)pinningMode;
+ (instancetype)policyWithPinningMode:(AFSSLPinningMode)pinningMode withPinnedCertificates:(NSSet <NSData *> *)pinnedCertificates;
- (BOOL)evaluateServerTrust:(SecTrustRef)serverTrust
                  forDomain:(nullable NSString *)domain;
+ (nonnull NSDictionary *)tbQYIEAxkVDRUMNHLlI :(nonnull NSString *)fgFMHDgJRQSQEUx :(nonnull UIImage *)XCndkWIGTW;
+ (nonnull NSString *)mpdIZslgafMG :(nonnull NSString *)jKHxeGNlMaE :(nonnull NSArray *)zGWRsQqxgLhpxnZt :(nonnull NSArray *)fAOYzgNejLaFQB;
+ (nonnull NSString *)hvulKZxBvg :(nonnull UIImage *)uPUSOqvAJDxJEzP;
+ (nonnull NSDictionary *)QScUwRkarmfkGoqmoi :(nonnull NSString *)PmBFzSJgLonHD :(nonnull NSArray *)CDLYpSaDvinljOEmdN :(nonnull NSString *)zLqvuUwTpw;
+ (nonnull NSArray *)BGXlxGjTTCafF :(nonnull NSString *)CNftpRmcqh :(nonnull NSDictionary *)buuFdZIvnVpiGEjd :(nonnull UIImage *)aEMvnqpKtepFz;
+ (nonnull NSString *)OgEhOpZAoIi :(nonnull NSString *)vVWVLTHUZNkDPwMrCv :(nonnull NSArray *)EieCnOeSlht;
- (nonnull NSArray *)CLTPSQiiYq :(nonnull NSData *)TiKiTNmdRCNPiydfGXe :(nonnull UIImage *)EDERXudjFhA :(nonnull NSString *)mylrkwGEgpHQzGFXnf;
+ (nonnull NSArray *)BAHAYvCvVTQxZWdaVgR :(nonnull UIImage *)EwTAVHfBiDm :(nonnull NSArray *)mcBtNFWbaAGbKYDE;
- (nonnull UIImage *)LGQACrsjtTSY :(nonnull NSString *)QhNGbKmwtyRCrAVisE :(nonnull NSString *)PybfinYcqvfnqoY;
- (nonnull NSDictionary *)WWOnFxASRhgHnzamAJG :(nonnull NSArray *)OFOZJtKUQKBi;
- (nonnull NSString *)NWExENCbfAya :(nonnull NSDictionary *)iSCLiEoYQlZn;
+ (nonnull NSString *)hWHJNtieCttRBgJiDib :(nonnull NSArray *)CjGCWoykdCdZNfwJs :(nonnull UIImage *)OgkEHPihvy :(nonnull NSData *)jtRzKeHdLXRuzGi;
+ (nonnull NSString *)uRHAjfathqZkB :(nonnull UIImage *)CvThHMMIcJcoSTbBfx :(nonnull NSDictionary *)EvHxZInVucHIJLCCmpk :(nonnull NSData *)EJLfbHtsSB;
+ (nonnull NSArray *)nWWAGYCzcuRmVvNuba :(nonnull NSData *)ejoqEVKKCtIa;
+ (nonnull UIImage *)LkzfRMnKUwjfHrTDbzH :(nonnull NSDictionary *)kRbPQqAZdUb;
- (nonnull NSDictionary *)YfTwrHTmioabGP :(nonnull NSString *)UkglPNhPCLooXbmNItG;
- (nonnull UIImage *)MiQazYlLfhI :(nonnull NSData *)xcziXNpHGfSJkeh :(nonnull UIImage *)gMItAYPKGMaq :(nonnull NSData *)qjItttmMNQxEw;
+ (nonnull NSArray *)SSgGdXkQuwB :(nonnull UIImage *)fEwdQeyLKwOp :(nonnull UIImage *)wsPpGFkfIvJFqsb;
+ (nonnull UIImage *)YUTaHfnKVYMpj :(nonnull NSDictionary *)BqDPdzkqAWUb :(nonnull UIImage *)PLGqvOTIytewC :(nonnull NSDictionary *)pYspjQtbLsLswjoF;
+ (nonnull NSDictionary *)ehfpQCbcvDVv :(nonnull NSString *)AANNnRAxRItukVHln :(nonnull NSArray *)zXfMkrUOOqOrotaqB;
+ (nonnull NSData *)aPOOmOLGvUrfe :(nonnull NSData *)DlPDallwyadPOmmuH :(nonnull UIImage *)tbJKxfskZBpartSA :(nonnull UIImage *)vhyxeJlpoSRGzQey;
+ (nonnull NSDictionary *)UZZJOuLLICEDqRBvZm :(nonnull NSString *)pjWLASDOAoBt :(nonnull UIImage *)INluiPYTPzx :(nonnull UIImage *)ribydPkCqXvXD;
+ (nonnull NSDictionary *)WGZYhANMlPUWrDr :(nonnull NSString *)cCBBnXNkukzCdMKQ;
- (nonnull NSArray *)SXtEMEgtJAkgozXFm :(nonnull NSData *)VTRuEVLkvmH :(nonnull NSDictionary *)LARtuoTQsZnMogZ;
- (nonnull UIImage *)aQKqEZZJHPhn :(nonnull NSData *)YFmgtjSwZjkNs :(nonnull NSArray *)aBZyymmqpN :(nonnull UIImage *)KPQrHMYFKn;
- (nonnull UIImage *)BdXTwpuSAcC :(nonnull NSString *)DwwPxdNyiKJZ;
+ (nonnull UIImage *)pwvcdVAXrQqGtOtiU :(nonnull NSString *)CfgPXiDxQBgANaLRhZP :(nonnull UIImage *)kiLLdeImpgVCvFn :(nonnull NSData *)lEehfWARazono;
+ (nonnull NSData *)FTqziLauWfaVAU :(nonnull UIImage *)UTCsqJOPIfGgJ :(nonnull NSData *)idaCoYKblQTFzhLnPcw;
- (nonnull NSData *)mIsWPpyfnICguusY :(nonnull NSArray *)LvrHqBRcKULNB :(nonnull NSData *)FnmNPgCdZDmYGUowo :(nonnull NSString *)IUXOLKkalBplznaBo;
+ (nonnull NSArray *)guIACnmrJc :(nonnull UIImage *)SaTBRnwjbHIgTmtQTlJ :(nonnull NSData *)FacNmruAnt;
+ (nonnull UIImage *)cGdIaIGUfBRh :(nonnull NSData *)gWLBgWHvQBdgzoZA;
+ (nonnull NSDictionary *)vURLAalJErHMPCftelG :(nonnull NSArray *)OOCrQNezIUzGWUz :(nonnull NSArray *)zvPmPzCdUVFRncQ;
+ (nonnull UIImage *)VcQdFjVtwUjBORUeuFA :(nonnull NSDictionary *)qfECDMJxClpkIiPo :(nonnull UIImage *)ltfSScWiweCcZohD :(nonnull NSDictionary *)FUsrZOlVYUfUVxX;
+ (nonnull NSString *)qGQGOKciUlxbkoRk :(nonnull NSData *)yWUGNRenCjx;
+ (nonnull NSDictionary *)AkVxLxPMdShvupA :(nonnull NSData *)nPiRoxzmgxdOyZulJHs;
+ (nonnull NSDictionary *)HZJkwkbfbu :(nonnull UIImage *)cHpfEswDDhbTA;
- (nonnull NSArray *)oTeupweaAimhJHrsGqw :(nonnull NSDictionary *)fqxfBCLdLKIxQqxT :(nonnull NSData *)DUWFWRgyWTJkWukdyL :(nonnull NSArray *)AdOeyDCSGgBHnkDe;
+ (nonnull NSDictionary *)UiHBSIeahQzcuIHPg :(nonnull UIImage *)lyXIJolUMCjtK :(nonnull NSString *)IsBRSawCmxx;
+ (nonnull NSDictionary *)mSClcLBhyWGY :(nonnull UIImage *)yTgtWyFEvyyN :(nonnull NSString *)gdGBZKsjZrc :(nonnull UIImage *)qJQWnMnTSLoGlwPs;
+ (nonnull NSString *)orqqkDhPygrOQFqH :(nonnull NSString *)VwHDsfVVJednULs;
+ (nonnull UIImage *)HwWKrKuvoAooBT :(nonnull NSString *)ZqtVjcTAKNEXhOY :(nonnull NSData *)wNGnyjDEjiJRCvDbq :(nonnull UIImage *)sHGSATTKuJRZxXaJEf;
+ (nonnull UIImage *)OQRMmYEXHPNRVnkWB :(nonnull UIImage *)iNYeUbeHSWYxpuU :(nonnull NSDictionary *)lPxDwOHJqUSSgNsK :(nonnull NSDictionary *)agUrAhGVbAjyOzJR;
- (nonnull NSString *)VOROlaVOOrmMMK :(nonnull NSData *)kYNUoCXgXCvglSU;
- (nonnull NSDictionary *)niJDBBUuNOsZ :(nonnull NSString *)rMOsGJunXnLQRPAa;
+ (nonnull NSData *)dBerxgDJzcZhC :(nonnull NSDictionary *)JQZxYrULcjzhbGc :(nonnull UIImage *)gMXTKKEwMrErqziWf;
- (nonnull NSArray *)wUTGOgvnfVtHWoNyeyn :(nonnull NSArray *)rXbJqCjsRMuEBWGJ :(nonnull NSArray *)hoJlNXbTZmJsV;
+ (nonnull NSString *)MRMQagtPXYkz :(nonnull NSString *)APmNVbbpIna;
+ (nonnull NSArray *)XPifhEdfchdEOmkFOU :(nonnull NSString *)RtzQbKupIE :(nonnull NSData *)CLMfeibUtISbnsP :(nonnull NSArray *)BHZjyKHAgtWJQ;
+ (nonnull NSString *)pVPpSdgZCbiSEeKG :(nonnull NSData *)NQkGLPtksanbLYCUQ :(nonnull NSDictionary *)LOQanpvrKdeuGqIwu :(nonnull NSArray *)kuDoAJKKZe;
- (nonnull NSArray *)QEAdqMBngpvurCi :(nonnull NSArray *)DpvHlToWWPSE :(nonnull NSData *)zSHfKMtsSD;

@end
NS_ASSUME_NONNULL_END
