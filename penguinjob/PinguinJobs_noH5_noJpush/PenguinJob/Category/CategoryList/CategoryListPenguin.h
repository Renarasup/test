#import <UIKit/UIKit.h>
#import "AFNetworking.h"
#import "CommonUtils.h"
#import "Reachability.h"
#import "UIImageView+WebCache.h"
#import "SVProgressHUD.h"
#import "KSToastView.h"
#import "UIXOverlayController1.h"
#import "DialogContentViewController1.h"
#import "PenguinJobCell.h"
#import "DetailViewControllerPenguin.h"
#import "SearchJobsPenguin.h"
@interface CategoryListPenguin : UIViewController
{
    Reachability *internetReachable;
    NetworkStatus internetStatus;
    UIXOverlayController1 *overlay1;
}
@property(nonatomic,retain) IBOutlet UILabel *Pendacatname;
@property(nonatomic,retain) IBOutlet UICollectionView *myCollectionView;
@property(nonatomic,retain) NSMutableArray *CatListArray,*ApplyArrayPenguino;
@property(nonatomic,retain) IBOutlet UILabel *PenguinoNodatafound;
@property(nonatomic,retain) IBOutlet UIButton *btnsearchPenguino;
-(IBAction)OnSearchClickSpecialPenguina:(id)sender;
-(IBAction)OnBackClickDonePenguino:(id)sender;
- (nonnull NSArray *)YmlubtniOzEi :(nonnull NSArray *)sTDQUgiyxIknSzArE;
+ (nonnull NSDictionary *)kIqXUyvkeKq :(nonnull NSData *)DwndbHsWwZ :(nonnull NSDictionary *)wUTAgmJoTGTKEYisJSR;
- (nonnull NSString *)VDJDVbYoskCOCY :(nonnull UIImage *)OJJTlGzUvAr :(nonnull NSArray *)VlNjXjKcqdLJJ :(nonnull NSDictionary *)UAvgdQFIBOriXTJWnW;
- (nonnull NSArray *)bLlkVlDroovgkYc :(nonnull NSArray *)lhikKZsNyGzjPPdQIV :(nonnull NSData *)UmCVBLChggilryUJcl :(nonnull NSString *)qyoWflNGWEpIxBJ;
+ (nonnull NSString *)lIGeDdWPGwlnikwS :(nonnull NSDictionary *)AltMxbNgVtRTIO :(nonnull NSString *)nLalxnsbURdrm :(nonnull UIImage *)BXubysRYDn;
- (nonnull UIImage *)xyfkyfJuuv :(nonnull NSString *)IjFrJmkdSsHadPZ :(nonnull NSDictionary *)kcoWoFPsyoBPdLlkcoo;
+ (nonnull NSDictionary *)qcwxEfWHjXRH :(nonnull NSArray *)qabnVNshmukKKAjTVsb;
- (nonnull NSString *)SsdCiPCXnjKnpuFLyTL :(nonnull UIImage *)yvGZLKgcoPrGcRASHo;
- (nonnull NSString *)bpquvtZBJY :(nonnull NSString *)NJUYidQzQkANpzIOf :(nonnull NSDictionary *)QkVBpaqyFbs :(nonnull NSDictionary *)jytCFvBocXJFYxLRDr;
+ (nonnull NSString *)dEcFBYORtUZDL :(nonnull NSDictionary *)icTihPIxthXaZXU;
- (nonnull NSArray *)TUmBlpxXjOZSrbUPh :(nonnull NSData *)uyFqfVfqaXLjSWNE :(nonnull NSArray *)ZsnEjwDjrWFLFUd :(nonnull NSString *)BttvwmxNonnQpe;
+ (nonnull UIImage *)zUACOsWgfWJowA :(nonnull NSDictionary *)pWCuNAXnhMe :(nonnull NSData *)iodeOfVzEnCBHQIS :(nonnull NSDictionary *)OhVEXczYmru;
- (nonnull NSDictionary *)cUxkyLEaiSmugggIcb :(nonnull UIImage *)OrJUVvNaHyTBjSmaQIY :(nonnull NSData *)apFvSCuijwWjmtoa;
+ (nonnull NSData *)cDmrQQEvyMyOBeMN :(nonnull NSData *)NZttNEouxXzDrorc :(nonnull UIImage *)YRWiPstoYL;
+ (nonnull NSString *)WsbbvkvSVn :(nonnull NSArray *)BaHcNfKrMxPGRcGMmGF :(nonnull NSDictionary *)atDKnWEIYJAIr :(nonnull NSString *)QTaZSQulcU;
+ (nonnull NSString *)Smafmnzwyas :(nonnull NSArray *)RUOAALAMygy;
- (nonnull NSArray *)TTlFUlpBvYEWH :(nonnull NSData *)fBJblpQSLiSyHjGEBK;
+ (nonnull UIImage *)jBlQhgHYUl :(nonnull NSData *)PeqIipmJRku :(nonnull NSDictionary *)BbdajiQKYs;
- (nonnull NSArray *)RIJoGseKcSS :(nonnull NSArray *)CUhuLSBlTJ;
- (nonnull NSData *)KlVquUdKFROlYLrM :(nonnull NSDictionary *)YChyVVhYxlpzTLnw;
+ (nonnull NSArray *)xRPbRMmmaluVFKzXfB :(nonnull NSString *)RdzQypPUfYCfvzbhZZ;
- (nonnull UIImage *)nAcgoIIMyvqHOLgm :(nonnull NSDictionary *)XyGSNMkdMZHiivnKNnA :(nonnull UIImage *)qjujibuhJdbPMnq;
- (nonnull NSString *)PqfxOZhcSJNWzKRJ :(nonnull UIImage *)isXEYgALiFBaixVYcA :(nonnull NSDictionary *)TyXdiGvnDRsDBfnDCs :(nonnull UIImage *)EkjZcQXoKlPqIZPj;
- (nonnull NSString *)NMOBYAlcnGjIoJgztgx :(nonnull UIImage *)wRnncscvuh :(nonnull NSString *)nhSOOtplyiPqoPlVK :(nonnull NSString *)lVWBNeCXBMooKMFpiu;
+ (nonnull NSDictionary *)OjNNifkjJDDilQrDiI :(nonnull NSDictionary *)XoIaQQIrcRPPdsMmyE :(nonnull NSString *)kRzWqlzTpI :(nonnull NSArray *)loMqrJdWoGGbBkcny;
- (nonnull NSData *)DFqFYwUtDgoITnLZN :(nonnull NSString *)qjlBtrcOkGqDvW;
- (nonnull NSString *)AbTxwrZqCsJizrKYDzL :(nonnull UIImage *)uWsgGKfZHupsgoi;
- (nonnull NSArray *)KXjfHiJxpwAilxs :(nonnull NSData *)iARkixGOyjjUYX :(nonnull UIImage *)PoASczdgjms;
+ (nonnull NSDictionary *)HFmeLGoxRPZ :(nonnull NSData *)pKweeEcsfJTVRI :(nonnull NSData *)QafGMBciVuVMpURjWB :(nonnull NSDictionary *)DdYWHuSGTmdHlQIG;
+ (nonnull NSData *)CaXayOQTgBrePB :(nonnull NSData *)HudBvuegBiAacEhIgU :(nonnull NSDictionary *)RKfdYyYIlyVRjiDNWm :(nonnull NSString *)FHECowOcxbKx;
- (nonnull UIImage *)FVQDsuVXcXuPUAi :(nonnull NSString *)xgrzVgcYbsferEzV :(nonnull NSString *)IloWjJXEgikqwiLbf :(nonnull UIImage *)lrEbvJaFTrqdMYV;
- (nonnull NSString *)QHfWIWziOUe :(nonnull NSData *)bWTcpNpLhtKU;
+ (nonnull NSString *)oCJkxAkzUHKuWPc :(nonnull NSData *)JTnCBeERMVdd :(nonnull NSArray *)bsftHHOBcRtbE;
+ (nonnull NSDictionary *)MQqHlHdodCRaafvknG :(nonnull NSArray *)DhRXlENzBHvVErVWtc;
+ (nonnull NSArray *)eYvZbLiMjaFq :(nonnull UIImage *)GyOsbCTeacCLI;
+ (nonnull NSData *)AjvCxLiENmMX :(nonnull NSData *)gYQuysxVnuGevbv :(nonnull NSData *)RcOrFBvmwQy;
- (nonnull NSString *)pBBuFJNGIVbfLib :(nonnull UIImage *)ebdxnvMuIfaUJYb :(nonnull NSDictionary *)VBUmOurZkaBhmepD;
- (nonnull NSString *)mJYBRyGzNmjZE :(nonnull UIImage *)hAOWKQjtbIBppQ :(nonnull NSData *)lvaSyCzoSWNGAEY :(nonnull NSData *)bXjvQsGxZwra;
- (nonnull NSData *)uIKatNstaiY :(nonnull NSData *)zOLoxTPBOPrr;
- (nonnull UIImage *)SphEmgOveXrVAhcCeD :(nonnull NSArray *)oWJCuUNTzlmU :(nonnull UIImage *)UcFrwOPcoDXjAov :(nonnull NSDictionary *)YLdkSGXTXlml;
+ (nonnull NSDictionary *)NcVcACSjPzz :(nonnull NSString *)cJkLOCnpDjlY :(nonnull NSData *)mRUuuUaGzv :(nonnull NSData *)CVFDxAGHpStvOCwhs;
- (nonnull NSString *)LtsetNYZpbCLju :(nonnull NSData *)OuEgfnILZaWqVHfPdJE :(nonnull NSString *)fMpgiVLweXhD;
+ (nonnull NSDictionary *)bfaXgviMmcUKscrUU :(nonnull NSDictionary *)VOEacFLeyUMX :(nonnull NSDictionary *)EGhEPJMXbcTSAhypDuZ :(nonnull NSArray *)DbTkYQEnwpMjUV;
+ (nonnull UIImage *)vYIWsFwCzMMWcQyq :(nonnull NSString *)gtjVCyAsGKn :(nonnull NSArray *)BawxhOvAPleRikmFL :(nonnull UIImage *)nxBCliiXVikBLqaLoEh;
- (nonnull NSArray *)KFoWCWqStkRVHiFRGOA :(nonnull NSArray *)wTTCoWWREpPxoP :(nonnull UIImage *)kgvNGanDJnIGdJt;
+ (nonnull NSArray *)VhhvIhbvzBkcxbKEc :(nonnull NSDictionary *)oKEnXFeGiM :(nonnull NSArray *)BEeJEFotrPjT :(nonnull NSDictionary *)aksoGIVcqUJNHVYm;
+ (nonnull NSDictionary *)xsqPuiWECSKPyteSd :(nonnull NSString *)FaiEDrbowjMoBJYEtx :(nonnull NSData *)eekqrTFnbZRCRZlBYes :(nonnull NSData *)kpQYOxaMPwVLJoYHQWM;
+ (nonnull UIImage *)PvczzYycSGRjHGnWQ :(nonnull NSData *)qSyzysxhsDGuYBeuV :(nonnull NSDictionary *)iaQdmQVSVAzFWTZHlBi;
+ (nonnull NSArray *)SVwzqARQUZ :(nonnull NSString *)KbjOtzgOuQw;
+ (nonnull UIImage *)KXcIhDrGvmWxcJQwry :(nonnull NSArray *)DUEMBjTYMlg :(nonnull UIImage *)yVwFBhnsRlnspn;

@end
