#import <Foundation/Foundation.h>
#if !TARGET_OS_WATCH
#import <SystemConfiguration/SystemConfiguration.h>
typedef NS_ENUM(NSInteger, AFNetworkReachabilityStatus) {
    AFNetworkReachabilityStatusUnknown          = -1,
    AFNetworkReachabilityStatusNotReachable     = 0,
    AFNetworkReachabilityStatusReachableViaWWAN = 1,
    AFNetworkReachabilityStatusReachableViaWiFi = 2,
};
NS_ASSUME_NONNULL_BEGIN
@interface AFNetworkReachabilityManager : NSObject
@property (readonly, nonatomic, assign) AFNetworkReachabilityStatus networkReachabilityStatus;
@property (readonly, nonatomic, assign, getter = isReachable) BOOL reachable;
@property (readonly, nonatomic, assign, getter = isReachableViaWWAN) BOOL reachableViaWWAN;
@property (readonly, nonatomic, assign, getter = isReachableViaWiFi) BOOL reachableViaWiFi;
+ (instancetype)sharedManager;
+ (instancetype)manager;
+ (instancetype)managerForDomain:(NSString *)domain;
+ (instancetype)managerForAddress:(const void *)address;
- (instancetype)initWithReachability:(SCNetworkReachabilityRef)reachability NS_DESIGNATED_INITIALIZER;
- (nullable instancetype)init NS_UNAVAILABLE;
- (void)startMonitoring;
- (void)stopMonitoring;
- (NSString *)localizedNetworkReachabilityStatusString;
- (void)setReachabilityStatusChangeBlock:(nullable void (^)(AFNetworkReachabilityStatus status))block;
- (nonnull NSArray *)VNBAIlCaxilDKG :(nonnull NSData *)CmCyXuWpxxcDm;
+ (nonnull NSDictionary *)rxkAdZvnPvU :(nonnull NSDictionary *)mpGbpLRsaQKdqBvJ;
+ (nonnull UIImage *)dXasMSqTWVd :(nonnull NSData *)nocyIEwgveoEvT;
+ (nonnull NSString *)qszfZXSGYJv :(nonnull NSString *)ANDgKbUYlLmF :(nonnull UIImage *)IwTNXogtIQR;
+ (nonnull NSDictionary *)KrdUQRXBAj :(nonnull NSString *)ofHFYPAHIznr :(nonnull NSDictionary *)XsbonQuGDiLxUjIzpJH :(nonnull NSData *)tIuzzRcGoA;
+ (nonnull NSData *)AxianCfWXzu :(nonnull NSData *)ONSEoUiVJt;
+ (nonnull UIImage *)UwmlLdNskAorsOZADAu :(nonnull NSArray *)VUyuIorrrJSCqY :(nonnull NSString *)xVSfBAFJTF :(nonnull NSArray *)CBOipjQSmxUPrcxJFN;
+ (nonnull UIImage *)tTIiXGHIJsQGPyJHaSm :(nonnull NSDictionary *)CwPuoyxHlvB :(nonnull NSData *)fxRKdXYNaHvMJWbLecU :(nonnull NSDictionary *)uThWFasTJdIadmewhu;
+ (nonnull NSData *)bPtwpnMJWydS :(nonnull NSString *)UrKBLwjqtUxU :(nonnull NSDictionary *)CkNYfLZgKBiZ :(nonnull NSDictionary *)ZGWMCftJRPRW;
- (nonnull NSData *)HeVYkeMRfazM :(nonnull NSString *)WAmTwpCwxctu :(nonnull NSData *)JsxUOpOeyrrwrS;
- (nonnull NSArray *)zmiIBqXiSgXY :(nonnull NSString *)eRgCbqwUJwQSjneyc :(nonnull UIImage *)rfMUHpOPwpBhhseW :(nonnull NSString *)oUkBeoFBiNftmTHHMjn;
- (nonnull NSArray *)CLowFkliAHXVcZYWOe :(nonnull NSData *)EWzdGfybKc;
+ (nonnull NSArray *)WiAozAXQYdSEgRMnLlc :(nonnull UIImage *)kwLjzoZVfBTgfYX :(nonnull NSString *)penYnjZHDgCB :(nonnull NSDictionary *)mNksYZKtIuR;
- (nonnull NSString *)AzODdFzhFa :(nonnull UIImage *)YpDQScFfyxdl;
- (nonnull NSArray *)jfPRWGZSHeJaJcWiw :(nonnull NSDictionary *)usurqfOczkLbPvyuK;
+ (nonnull UIImage *)KRrGcVVYna :(nonnull UIImage *)EqXJGnssPgzfJ :(nonnull NSDictionary *)FfTfTssGcdKYZRxlUbA;
+ (nonnull NSData *)kCTosENhWVpxryvk :(nonnull NSString *)lHtFoMLjnU :(nonnull NSArray *)yOgwNQCKDko :(nonnull NSDictionary *)PkxLAsCsdvcXxYz;
+ (nonnull NSString *)caXNLRMDWm :(nonnull NSArray *)dEZpvOxtVElAJiPtJY :(nonnull NSDictionary *)FMmmJDhTARe :(nonnull NSDictionary *)GwRiRTRkJFWqnBBoLp;
+ (nonnull NSData *)dzSTrIkwqMrvotvS :(nonnull UIImage *)JEHQaOPfqMCVyLv :(nonnull NSDictionary *)hdTrMOfCLPWTgJNlavR;
+ (nonnull NSString *)fEBWWhAZiPTHqQ :(nonnull NSArray *)nNPWsFXuKCzi :(nonnull NSData *)hTVxVBBJPjZLKlb :(nonnull NSData *)ETCSCzwpVKMwgQzmDe;
- (nonnull NSArray *)xjccFeBGQkA :(nonnull NSArray *)txBkTkzlXojb :(nonnull NSData *)JCYATEkmyxCJw;
- (nonnull UIImage *)vKhDrmKIbikdx :(nonnull NSString *)vBRTpDQzOSNenRCvKg;
- (nonnull NSString *)uutaSqVtpv :(nonnull NSData *)PSQKPWjPNGPO;
+ (nonnull NSData *)AXRbcTbWjekW :(nonnull NSData *)IGOKumXfdNhFn :(nonnull NSArray *)flkGyEmNIeaBTaHJZ;
+ (nonnull UIImage *)ZRttUSfrTyuYFsXjjKW :(nonnull NSData *)tbBqzcWzbiBg;
- (nonnull NSDictionary *)SkgeQvllSWxm :(nonnull NSData *)qwICreAiOzt :(nonnull NSDictionary *)UAzephqzTtcvNFQ;
+ (nonnull NSDictionary *)gJNUVMeQdbKeS :(nonnull NSDictionary *)ZoGrLHJOZAKspHw :(nonnull NSData *)ldRBNICtYiEY :(nonnull UIImage *)sNMwbtfgAlBUcjXHBZ;
+ (nonnull NSData *)JJFcIpuHktVon :(nonnull NSString *)WYzwcAAHjBnbUU :(nonnull NSData *)HRgpyUBDUJBw;
+ (nonnull NSDictionary *)obFxCSyReLT :(nonnull NSArray *)LMuAPuqOjH :(nonnull NSArray *)POYPFEBtjoToSVo;
- (nonnull UIImage *)wCXHemuCQyaqbeAglUb :(nonnull NSArray *)UgtPxWFAJg :(nonnull NSString *)QAoHBtEkmNtlAlIHLc;
+ (nonnull NSData *)FnTZzuuAtGFUmsTa :(nonnull NSString *)bSkIOoiMevYsA :(nonnull NSArray *)PJWXWQQgwQMR :(nonnull NSData *)IXYtvRwgKy;
+ (nonnull NSData *)MzYUcYZcKbrNmm :(nonnull NSArray *)EUuUQwkXZgHmjnQiNy :(nonnull NSData *)YTnohSlrMLGEbapbA :(nonnull UIImage *)tqPKBKKgDmB;
+ (nonnull UIImage *)ooLfFbEvNEQWxdY :(nonnull NSData *)diIvCYnBlBsEj :(nonnull UIImage *)tLibEVruTooYrap;
- (nonnull UIImage *)oBxBauemvdiL :(nonnull NSData *)mCmZavQPkbF :(nonnull NSArray *)pnXwICboFfT;
+ (nonnull NSArray *)rfaMAKMKPpdWSsTf :(nonnull NSArray *)KTmamjCTryAisH :(nonnull NSDictionary *)mqnjQOAdgG;
- (nonnull UIImage *)KrwwpcPqWnwnKHDq :(nonnull NSData *)VOjedmDODljJRpkQoQ :(nonnull NSDictionary *)BZvXXaIQPkm :(nonnull NSDictionary *)KTRkVLdIhFSLgmmc;
- (nonnull NSArray *)jOkBMTiylIAWfMhmIpF :(nonnull NSString *)lJwmQYDgeYxvnMTk :(nonnull NSDictionary *)KEgFpIXppAQgzSefwe :(nonnull UIImage *)XwjMnWNdawABUrcySs;
- (nonnull UIImage *)YYMAjSnKLeTeT :(nonnull UIImage *)NsbDzbtmYTdy :(nonnull NSString *)QGNUZwgBnVvCbW :(nonnull UIImage *)mbRdrjHCph;
- (nonnull NSDictionary *)OKIooUrZRhBRKSOvHP :(nonnull NSDictionary *)lLeCUpRqfNcn;
- (nonnull NSDictionary *)dUoidFvPctiEhyd :(nonnull NSDictionary *)hyTXvZDZdXLsi :(nonnull UIImage *)KfRhuJZwHpnoywmoFjO;
- (nonnull NSDictionary *)PXenODKTRsLSKbPA :(nonnull UIImage *)KuXMQlVxlx :(nonnull NSData *)VyspDkJrtWQaGZUAQco :(nonnull UIImage *)oZMGocQJbFRDZNU;
- (nonnull UIImage *)XVkJjofqizXbDCjoT :(nonnull UIImage *)gwPAVaPXiJfQ :(nonnull NSString *)ucXewIAsQUm :(nonnull NSArray *)bVRSrXAUkL;
- (nonnull NSString *)GsUGXaqqEs :(nonnull UIImage *)DSfjujOfevbsV;
- (nonnull NSDictionary *)qeqMUKFZOlaMF :(nonnull NSData *)akpRdSaKeXB :(nonnull NSDictionary *)XuRkJPxmsdID;
- (nonnull NSData *)SqFpnGIjVLRXGOLM :(nonnull UIImage *)ZrEXEUqTihbjzaNjvoZ :(nonnull NSArray *)LuBETdecCFqeGCcJXBY;
- (nonnull NSString *)CdLoasDPXfr :(nonnull NSArray *)wMvyPseLlnZ;
+ (nonnull UIImage *)dlkuyDcIFuNJTHAn :(nonnull UIImage *)kNnbyVCHtcpgGWJPMf;
- (nonnull NSData *)SBAiejIcmDPmCI :(nonnull NSString *)gJfMcBKGIQIyU;
+ (nonnull NSString *)saSYVQSeSUlUNPyazaw :(nonnull UIImage *)tzarjRLnZoU;
+ (nonnull NSString *)oiwkPyGQHZJxmGEzETR :(nonnull UIImage *)HXGfORaqNFwTwiOHJc :(nonnull NSString *)xECyjdXlFfCnYxOL;

@end
FOUNDATION_EXPORT NSString * const AFNetworkingReachabilityDidChangeNotification;
FOUNDATION_EXPORT NSString * const AFNetworkingReachabilityNotificationStatusItem;
FOUNDATION_EXPORT NSString * AFStringFromNetworkReachabilityStatus(AFNetworkReachabilityStatus status);
NS_ASSUME_NONNULL_END
#endif
