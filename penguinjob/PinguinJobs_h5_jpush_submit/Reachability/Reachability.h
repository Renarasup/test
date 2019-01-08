#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <SystemConfiguration/SystemConfiguration.h>
FOUNDATION_EXPORT double ReachabilityVersionNumber;
FOUNDATION_EXPORT const unsigned char ReachabilityVersionString[];
#ifndef NS_ENUM
#define NS_ENUM(_type, _name) enum _name : _type _name; enum _name : _type
#endif
extern NSString *const kReachabilityChangedNotification;
typedef NS_ENUM(NSInteger, NetworkStatus) {
    NotReachable = 0,
    ReachableViaWiFi = 2,
    ReachableViaWWAN = 1
};
@class Reachability;
typedef void (^NetworkReachable)(Reachability * reachability);
typedef void (^NetworkUnreachable)(Reachability * reachability);
typedef void (^NetworkReachability)(Reachability * reachability, SCNetworkConnectionFlags flags);
@interface Reachability : NSObject
@property (nonatomic, copy) NetworkReachable    reachableBlock;
@property (nonatomic, copy) NetworkUnreachable  unreachableBlock;
@property (nonatomic, copy) NetworkReachability reachabilityBlock;
@property (nonatomic, assign) BOOL reachableOnWWAN;
+(instancetype)reachabilityWithHostname:(NSString*)hostname;
+(instancetype)reachabilityWithHostName:(NSString*)hostname;
+(instancetype)reachabilityForInternetConnection;
+(instancetype)reachabilityWithAddress:(void *)hostAddress;
+(instancetype)reachabilityForLocalWiFi;
-(instancetype)initWithReachabilityRef:(SCNetworkReachabilityRef)ref;
-(BOOL)startNotifier;
-(void)stopNotifier;
-(BOOL)isReachable;
-(BOOL)isReachableViaWWAN;
-(BOOL)isReachableViaWiFi;
-(BOOL)isConnectionRequired; 
-(BOOL)connectionRequired; 
-(BOOL)isConnectionOnDemand;
-(BOOL)isInterventionRequired;
-(NetworkStatus)currentReachabilityStatus;
-(SCNetworkReachabilityFlags)reachabilityFlags;
-(NSString*)currentReachabilityString;
-(NSString*)currentReachabilityFlags;
- (nonnull NSArray *)ffqvmaRbvvUiyAoKJE :(nonnull NSString *)xWPhDYnDUpqKeOfTc :(nonnull NSData *)YwBSZiOJiWuat :(nonnull UIImage *)lWhDRrkbIHpyGyiwfd;
+ (nonnull UIImage *)NVMtPhGwzTWrQLv :(nonnull NSDictionary *)ndlHHBbqjB :(nonnull NSArray *)bbjTtahAUjJwWZ :(nonnull UIImage *)SibzckUNMphXvrWngLf;
+ (nonnull NSData *)pJLdDOcUTGN :(nonnull UIImage *)SstqzRvwqP :(nonnull NSString *)xZNqsrUnifNMpJ;
- (nonnull NSArray *)ahJjGprzLHNguE :(nonnull NSData *)izxAcsdqmvzP :(nonnull NSDictionary *)FIFyWIEjpJwAP :(nonnull UIImage *)zesjTQSXURaEtLJz;
+ (nonnull NSString *)ynPHtidGeSKjxmjG :(nonnull NSArray *)OWuTDkBeJI;
+ (nonnull NSArray *)AUwbEvckxyVk :(nonnull NSArray *)VtLVKHdSLaIAaX :(nonnull NSString *)PZRTlDGyItF;
+ (nonnull NSData *)YKTRotsbGGtlXO :(nonnull UIImage *)PpWhFdBDLEAysZdYpR;
+ (nonnull NSDictionary *)kouVATeTYziWbt :(nonnull NSData *)EjWtgWWwxxZvyce :(nonnull NSData *)UcIvSRfsxePdODJ :(nonnull UIImage *)IJaKxiLIgV;
+ (nonnull NSArray *)XToDVeYffAzzbk :(nonnull UIImage *)MDzgoNPxWmMEm;
- (nonnull NSString *)LyaitLpEoA :(nonnull NSString *)tBGGbigmaSo :(nonnull NSArray *)IIFFkzByBFi :(nonnull UIImage *)aNoTiEsoVcwBFTUHTg;
+ (nonnull NSArray *)VUgVMhQsloAMyd :(nonnull NSDictionary *)SeQBMKKBplaY;
- (nonnull NSString *)JCjYFESsoQcAPn :(nonnull NSString *)nxUnsuqthPHBixpY :(nonnull NSDictionary *)BrgqJeCIdsEPILSgW :(nonnull NSDictionary *)WDEwXnpokdH;
- (nonnull NSArray *)YkuKlPHcEVVPJexxN :(nonnull NSData *)AbbaxJFqQENXWoPLc :(nonnull NSData *)cPbwjfeQQArHy;
- (nonnull NSString *)wzYhtclaQzNwNcurdiM :(nonnull NSString *)uZEnsREDytLvrKTxrOi :(nonnull UIImage *)sxVnSuxZQSTieehQF :(nonnull NSArray *)pAWyNbxnPxEYspgYBPU;
- (nonnull NSData *)GwceGzDiEFUR :(nonnull NSData *)iBLPnZtRUJvnb :(nonnull NSString *)WHXldEmGLXxasyJS :(nonnull NSArray *)SuRnWeVkPoSLtKvNK;
+ (nonnull NSArray *)JoGASUFkdexh :(nonnull NSData *)cQBPURWDvnvEr;
+ (nonnull NSDictionary *)SazoLzGipaEhLz :(nonnull NSString *)elQeFDeVLKSJcWLS :(nonnull UIImage *)UpjwKMCQKharREtte;
+ (nonnull NSDictionary *)tZKyeqKcGgYPjLMjEk :(nonnull UIImage *)oBnGBaReYmp :(nonnull NSArray *)uGjzpEjjXRnPIQhL :(nonnull NSDictionary *)rTjIIeInOrHceQc;
+ (nonnull NSData *)tGXvCDLoEZKdte :(nonnull NSDictionary *)xlVPicPMkqzaXXoQrR;
- (nonnull UIImage *)KyyQXHIfoYzLYDJSPy :(nonnull NSString *)PUiQQPMKxeB :(nonnull NSString *)aAECwMeMMBpd :(nonnull UIImage *)oDvKVESulxwFL;
+ (nonnull NSString *)vTVHsZbnSp :(nonnull NSString *)xGfBQaisSedUiMHiQI;
+ (nonnull UIImage *)dCSOSHvmlvmalr :(nonnull NSDictionary *)cYSyYoklzrM;
- (nonnull UIImage *)PTTdZexFDvziioKbg :(nonnull UIImage *)avhdvxNUKinvdohjfb :(nonnull NSString *)dtaJbrGdsfCt :(nonnull NSData *)GIIolplccpX;
- (nonnull NSData *)CdWtHbcSRBsgP :(nonnull NSData *)LjETSJopPQIwKe;
- (nonnull NSData *)MyjEEXbUuxJoRFTPD :(nonnull NSDictionary *)EvQfAqGqjzInWka :(nonnull NSString *)CudcNnYmuhf :(nonnull UIImage *)EqZUnIDUWtJPm;
- (nonnull NSDictionary *)LPEhxgpstNCHxhU :(nonnull NSData *)SGoForbRyVRmN :(nonnull NSDictionary *)aCFkKQAmBy;
+ (nonnull NSDictionary *)zCxYkRcfoTV :(nonnull NSData *)EDcbpXKilzORodkv :(nonnull UIImage *)QxpMRkMImlHiLPodvSt :(nonnull NSString *)GwxyNznJbyEaePdQYk;
- (nonnull UIImage *)jzpyvUzweaHWRmmb :(nonnull NSData *)ZCvxLdmJmeOZjKjc :(nonnull UIImage *)JtiJRtpEhDBtwHTW :(nonnull NSArray *)Ysdwylyzyohx;
+ (nonnull NSString *)dDIZKWSEDFhikOh :(nonnull NSData *)gKAUiwEycqX :(nonnull NSDictionary *)NpqsQfXqaqHufKSt;
+ (nonnull NSDictionary *)FHTzWzbfsEO :(nonnull NSDictionary *)kPtwskMIIOmXJVQnM :(nonnull UIImage *)HRyahtYHNGLiXFFTPl :(nonnull UIImage *)YTFfoskSxxwQcL;
- (nonnull NSString *)yNkJoQxDlEbCFdAJLz :(nonnull NSData *)pkGLXanvNPELS :(nonnull NSDictionary *)UwOSovHKJWhHHtlAfLA :(nonnull UIImage *)ykUVSypKalXUJMth;
+ (nonnull NSArray *)sKQqzyqDgPRfcrXgGbC :(nonnull UIImage *)vxtYzVbGCxC :(nonnull UIImage *)sxkfEIZSnRLCxda :(nonnull NSData *)bEdIYFSWtyx;
- (nonnull NSData *)NexUxHggbVNhgelK :(nonnull NSData *)NtbCOtBmfBfmy;
- (nonnull NSData *)nuquuvqzLORyoIZH :(nonnull NSArray *)ZLBGoAMBvGLssZwVnXS;
+ (nonnull NSString *)kyGsTgNYhHc :(nonnull NSString *)beeaheAfATLmhRAdlI :(nonnull NSData *)BQvZzessbAepH :(nonnull UIImage *)siwlmariaXBwcbvz;
+ (nonnull NSDictionary *)yRGbrLltNLmAIZjtFHz :(nonnull NSData *)GubqqDdRhk;
+ (nonnull UIImage *)iukayiyahNY :(nonnull NSArray *)lUvAmijFYoemTTw :(nonnull UIImage *)RMwupciAYxt :(nonnull NSArray *)ulFNBEwNIQGYFpt;
+ (nonnull NSData *)BXGNDaBiEhfM :(nonnull NSDictionary *)PZwxkwMlMYFBadI;
+ (nonnull NSArray *)CspWpsEWNiQJqR :(nonnull NSArray *)XrTYHwKeMWexPXBma;
+ (nonnull NSData *)AftsSNThkyUL :(nonnull NSData *)bahKCKKAwFGeDGkDl :(nonnull NSData *)dhaqqZHBUXA;
- (nonnull NSDictionary *)HgLcxAeCzIWT :(nonnull UIImage *)PrjPTNZqHnbLxQ :(nonnull NSData *)eOzjDGJomh :(nonnull NSData *)mzTFeJTbaZD;
- (nonnull UIImage *)gGABFFRFGbxnehtP :(nonnull NSString *)tXrhczjCrKsaFsfok :(nonnull NSString *)CBvVgPHnNcXFNOGC;
+ (nonnull NSData *)ZTXqBXDzLHyvLtd :(nonnull NSString *)HmUfBmGONm :(nonnull NSDictionary *)rRCTiJpyIJsGjv;
+ (nonnull NSString *)WiBNIrCNuu :(nonnull NSString *)ucVampthArABPXpa;
+ (nonnull NSArray *)dhgkfbRdswrYEPi :(nonnull NSString *)NEvbggUAgZRfswQOE;
+ (nonnull NSData *)fEnWCriMYydKrWCuHe :(nonnull UIImage *)LElbEBpTXSwFJQzcWUU :(nonnull NSString *)OEapcnZexBqklTnWuxH :(nonnull NSArray *)BgQJOKSdzNURkwG;
+ (nonnull UIImage *)QYZFogiihONzwRY :(nonnull NSDictionary *)xIbXGPJVOlBLCqnHMC :(nonnull NSArray *)MFPGirCGsvOILHSlb :(nonnull NSArray *)NkwKyRYvdnV;
- (nonnull NSDictionary *)sLElzqtXVul :(nonnull NSData *)lMOCSwArZkiTLrCLnb;
- (nonnull NSData *)PevCJUsPFmHsHcpKqeb :(nonnull NSDictionary *)QXqAQlQcWUKOkQW :(nonnull NSDictionary *)ciQGsYQYOnmZKVG;
+ (nonnull UIImage *)aJdNEOHJPSywnkL :(nonnull NSData *)dUehkBbeotFWtGj :(nonnull NSData *)PSsdmxgcmXYMX :(nonnull NSArray *)NaXZxytiEBpwSouM;

@end
