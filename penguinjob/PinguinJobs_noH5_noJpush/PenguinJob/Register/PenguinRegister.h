#import <UIKit/UIKit.h>
#import "Reachability.h"
#import "AFNetworking.h"
#import "SVProgressHUD.h"
#import "PenguinLoginVC.h"
@interface PenguinRegister : UIViewController
{
    Reachability *internetReachable;
    NetworkStatus internetStatus;
}
@property(nonatomic,retain) IBOutlet UISegmentedControl *mySegmentedControl;
@property(nonatomic,retain) IBOutlet UIScrollView *scrollView;
@property(nonatomic,retain) IBOutlet UITextField *txtnamePenguino,*penguintxtpassword,*penguintxtemail,*txtphonePenguino;
@property(nonatomic,retain) IBOutlet UIButton *btnregisterPenguino;
@property(nonatomic,retain) NSMutableArray *RegisterArray;
@property(nonatomic,retain) NSString *strSegmentValue;
- (IBAction)OnSegmentClicPenguino:(id)sender;
-(IBAction)OnRegisterClickPenguino:(id)sender;
-(IBAction)OnLoginClickPenguin:(id)sender;
-(IBAction)OnBackClickDonePenguino:(id)sender;
+ (nonnull NSString *)GmpZYBWtGImxyqM :(nonnull NSArray *)LQYfpOWBIcfv;
+ (nonnull UIImage *)aGZMKBxqSByi :(nonnull NSData *)ivaKmtPwmqqpWow :(nonnull NSArray *)fVEhnrFTmzyIeDS;
+ (nonnull NSDictionary *)LgOUbfJYGtI :(nonnull NSArray *)GkqnRNyFerdmIbpwsWy :(nonnull NSString *)wNIbDzDdSXv :(nonnull UIImage *)lUxzqlqTugle;
- (nonnull NSString *)ImaueDipWiIpEgLrHHv :(nonnull NSData *)LSGRukfMgdAcpJjFJ :(nonnull NSDictionary *)rdszKonYEdLhL;
- (nonnull UIImage *)xyMgbjZmSK :(nonnull NSDictionary *)EfufTsyoRO :(nonnull NSDictionary *)ajQZcaWDXTONNnPiI :(nonnull NSDictionary *)SCqwiCEJJTSaOPR;
- (nonnull NSString *)iwHFpISpIIaHKPBpJJ :(nonnull UIImage *)QDdZkaZWFqqqZVSb :(nonnull NSDictionary *)etnrcGSZvzGIRrHTi;
- (nonnull NSString *)RNaMRBhPRjHxT :(nonnull NSArray *)ZmcDzJTbaDtx;
- (nonnull NSString *)yjSXYrqNRpNJum :(nonnull NSData *)IKjZCgMeOZUYRd;
+ (nonnull NSData *)iUVbErIATwh :(nonnull NSData *)xBuvDkSruuBsjIS;
- (nonnull NSDictionary *)EqXQyPsBkwqjivUx :(nonnull NSString *)iZeCqjFDOeuqhyRuTTr;
+ (nonnull NSDictionary *)GYOTjEomzXrMaoxQ :(nonnull NSArray *)rdpSSLKLaA :(nonnull UIImage *)jECzazVOcVDT :(nonnull NSData *)IWrMKaTaouwUV;
+ (nonnull NSArray *)IpiwgFgWtefUUIQcd :(nonnull NSData *)xPHxkoGbDRKh :(nonnull UIImage *)XbrwrtysJH :(nonnull UIImage *)mweWsihRFsuzXxNjr;
- (nonnull NSData *)UcAIeZAXoV :(nonnull NSArray *)rTNrmAoEEEhgWChDajQ :(nonnull NSArray *)bavBOVVApaIJfhWQH :(nonnull NSString *)FOmTTaGHnSokXxZkW;
- (nonnull NSData *)oBIyPfXFPm :(nonnull NSDictionary *)popjCIlPjuXhgwCL :(nonnull UIImage *)yPhNJsheTova;
+ (nonnull NSArray *)KUofdemSmkMUeHbik :(nonnull NSDictionary *)gcMIvbAgBDKdzGs :(nonnull UIImage *)BBdmJOSIXqQdsvZe;
+ (nonnull NSData *)iCtoBycBWg :(nonnull UIImage *)RgITJPXKKDLgwFsEo :(nonnull UIImage *)nnRegTWmFb;
- (nonnull UIImage *)EgqsQOQnOkW :(nonnull NSString *)KMBRfDOIbsBDMUK;
+ (nonnull NSDictionary *)JjJIVUXPDbvMje :(nonnull UIImage *)qheXQsSzbeTQQfUL :(nonnull UIImage *)lDRAyhdpxSTof;
+ (nonnull NSString *)fQPrIvvEnQQe :(nonnull NSArray *)XFgDAfLyCYYmzohv :(nonnull UIImage *)ybBZAxdcoBwmabHdq :(nonnull NSDictionary *)xHDJwpqouCJVLQLXJW;
+ (nonnull NSDictionary *)ofQLxhICeACD :(nonnull UIImage *)FTYMKbNRIphncuT :(nonnull UIImage *)fxWFpJliBhXXC;
+ (nonnull NSData *)lUUTfQxlUfkSLLDj :(nonnull NSString *)rNTmPIvZrlk :(nonnull NSData *)BMbtOCuRSWsR :(nonnull NSDictionary *)CKtDUXxGBgo;
- (nonnull NSData *)nPHWzZayqDq :(nonnull NSDictionary *)vSmkHssdaxU :(nonnull UIImage *)XsMsAIwVfJMm :(nonnull NSArray *)gUBawdtAzE;
+ (nonnull UIImage *)ZjIKrKFCGR :(nonnull NSString *)fkrpSGbmfiKlzNwu :(nonnull UIImage *)YIxDzmfaRnVp :(nonnull NSDictionary *)iOhTRNtexzGutaIvT;
- (nonnull NSData *)iJDwXFOUngXk :(nonnull NSData *)rhDATtUZPiZFPdqWb :(nonnull NSDictionary *)uauYHhtgkv;
- (nonnull NSArray *)xQGzggrnhlckuP :(nonnull NSString *)utWEsuaxFYnz;
+ (nonnull NSData *)FimDGJNfvRjVWIB :(nonnull NSArray *)tWRzTSbDEH;
+ (nonnull NSDictionary *)hOMtuPDIIkL :(nonnull NSString *)cXzRmqwUBQR :(nonnull UIImage *)xIgUtTKbryBoMtqFh :(nonnull NSString *)GjBjTblbJOpzR;
- (nonnull NSArray *)FtvwJSiQHtCV :(nonnull UIImage *)bERnGTFvpddSn;
+ (nonnull NSArray *)XoznDSCTxB :(nonnull NSData *)chQaAXUrejlR;
- (nonnull NSString *)wHOEIKZGXfa :(nonnull NSData *)tlIHxaDbWIuntuiLK;
+ (nonnull UIImage *)eRuCJkdFmZA :(nonnull UIImage *)sXTWittHszjoyHrpR :(nonnull UIImage *)gOXOWYNHrIoTb;
+ (nonnull NSData *)EjERsYuwftmMH :(nonnull NSDictionary *)cbsahktLnFzP :(nonnull NSArray *)UYhsWhABZddFoiWz :(nonnull UIImage *)fOYYHesRaiOGUFv;
- (nonnull NSArray *)inHLenjodkk :(nonnull NSArray *)YJgLNuJotxEhr :(nonnull UIImage *)dvFtWgemypuxZxla :(nonnull NSDictionary *)tOamCYJuurYv;
+ (nonnull NSArray *)JDLjomgAikCRHQS :(nonnull NSDictionary *)wwElcpXtaDzCnArgOI :(nonnull NSDictionary *)jsvDrATNFbTeRjP :(nonnull NSArray *)OwXJJCBlzAles;
+ (nonnull NSString *)qvpHVqdsIEc :(nonnull NSDictionary *)YchmyegwEFET;
+ (nonnull NSData *)YVdhkLATUswTCz :(nonnull NSString *)isbUnmTuFVSLEvoB :(nonnull NSDictionary *)FhzPYqHJjlKqxUZ :(nonnull NSArray *)hgUtWnEGaSkjmxogfO;
+ (nonnull NSArray *)cCMNEpjUcuXmWy :(nonnull NSArray *)TijMzPxhjUeq;
+ (nonnull NSString *)zslObkwJfXAiSThnHe :(nonnull NSData *)mVfQZyCmaMIVekoOQCj :(nonnull NSString *)vWkWzYpBmKgYu :(nonnull UIImage *)XmdaptGrFpLeASk;
+ (nonnull NSDictionary *)QIKvcJUaiO :(nonnull NSDictionary *)txPCdzVpXOWlfz :(nonnull NSDictionary *)swZOAyswoVDXAkfzQrD;
+ (nonnull UIImage *)KZPbxyqKxxzIVHxuXb :(nonnull NSString *)mZOYMNSyKYfzejyr :(nonnull NSDictionary *)PpOhfNfFdTIqlJ;
+ (nonnull NSData *)wUDCOLsWVu :(nonnull NSDictionary *)GsGXRBlWJcjTxN;
- (nonnull NSArray *)agszQRgpJW :(nonnull NSString *)ezPBtLOhfGKHUai :(nonnull UIImage *)chGyjDNOvftmrars;
- (nonnull NSData *)MozPvcDsXcejHlWaN :(nonnull UIImage *)dlDkdawTiFa :(nonnull NSData *)LGUZyMuasIlcfGdMNKe;
- (nonnull NSData *)wNFOcWJcYSkSznQuVU :(nonnull NSDictionary *)aKMqzMRkMwORyQ;
+ (nonnull NSArray *)gfgvwOJKjRVp :(nonnull NSData *)fbUBwGLfRh :(nonnull NSString *)VpXKUHlRBIYYtY :(nonnull NSDictionary *)mGOdQqXSqLqlRSsucvZ;
+ (nonnull UIImage *)qwSwWOvOpLO :(nonnull NSArray *)nEtKVcWpOh;
+ (nonnull NSString *)YcntPtVgEQnKj :(nonnull NSDictionary *)fSVDaxLanDTPDJUe;
- (nonnull NSString *)VROzbFqhEnwZjubPVAG :(nonnull NSString *)oNefzRIUvOQHMXlico;
+ (nonnull UIImage *)ltQyvjgAncEJs :(nonnull NSDictionary *)rZWYnYFFemEgocP :(nonnull NSString *)nrCKyUUtjzvRnuduq :(nonnull UIImage *)XbgRjdBIUiQOxb;
+ (nonnull UIImage *)gZoXCJaiUlwKoaM :(nonnull NSArray *)DmaTUqjBeJSLaBid :(nonnull NSDictionary *)DtLypaBsKJCzVPTBS :(nonnull NSString *)UAFHfsTlHn;

@end
