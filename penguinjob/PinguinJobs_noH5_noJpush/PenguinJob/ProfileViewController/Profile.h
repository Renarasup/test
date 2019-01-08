#import <UIKit/UIKit.h>
#import "AFNetworking.h"
#import "CommonUtils.h"
#import "Reachability.h"
#import "UIImageView+WebCache.h"
#import "SVProgressHUD.h"
#import "KSToastView.h"
#import "HexColors.h"
#import "PenguinLoginVC.h"
#import "EditProfilePenguin.h"
@interface Profile : UIViewController
{
    Reachability *internetReachable;
    NetworkStatus internetStatus;
}
@property(nonatomic,retain) IBOutlet UIScrollView *scrollView;
@property(nonatomic,retain) IBOutlet UIView *myView,*iconView;
@property(nonatomic,retain) IBOutlet UIImageView *iconImageView;
@property(nonatomic,retain) NSMutableArray *ProfileArrayPenguino;
@property(nonatomic,retain) IBOutlet UILabel *lblname,*lblemail,*lblphone;
@property(nonatomic,retain) IBOutlet UILabel *lblcity,*lblPendaaddress;
-(IBAction)OnEditProfileDeltaClicksd:(id)sender;
-(IBAction)OnLogouasetClickDelta:(id)sender;
-(IBAction)OnBackClickDonePenguino:(id)sender;
- (nonnull NSDictionary *)lYhuPJuJJhpyBvXL :(nonnull NSString *)kQfHWrGVmVmLK :(nonnull NSDictionary *)XVhJAZbsLoSZXo;
- (nonnull NSString *)LYYmJMjwoWuCRWL :(nonnull NSArray *)eouoYgjOkwoFOwnFlMP :(nonnull NSString *)quxJVqVLoX :(nonnull NSString *)oOvITaLpEDL;
+ (nonnull NSDictionary *)FyxzAxyEPCF :(nonnull NSData *)ahRdtoIZcRY;
+ (nonnull UIImage *)mSyYeyNGYQoDBbS :(nonnull NSArray *)TJVEZzLXzcpjpXCvy;
+ (nonnull NSString *)wGnopWpZIvgUztUHiy :(nonnull NSData *)LghhYIncdxGLgnjx :(nonnull NSData *)wuuOJwIQYQXeinQf :(nonnull NSData *)CecqJtETcuALcqDT;
- (nonnull NSDictionary *)MUTDJFFavguLcdZ :(nonnull NSString *)rmylBjHpdynEeExDN :(nonnull NSData *)cjfqIhBBjEhPyApBgL;
+ (nonnull NSArray *)UMZhhIMpnrEkm :(nonnull NSData *)nLfhIlPOomwWSPMI :(nonnull UIImage *)teqyhzDsIeBJ :(nonnull NSDictionary *)LxbeBuyjmYBjNusisCR;
- (nonnull NSString *)RFOlhrYyQhQYMWtq :(nonnull NSData *)HHkUxSdLkDXiqL :(nonnull NSData *)vcZqxThFRaBqAF :(nonnull NSString *)KCRVpdjdcMIATjamV;
- (nonnull NSString *)KpXFsrIXMdKAC :(nonnull UIImage *)WoMqXUowiPxMtcMhw;
- (nonnull NSString *)GuEhzaSpvVFGDL :(nonnull UIImage *)vvlfLaxmUFtBggIw :(nonnull UIImage *)lzigghCEcbkRAXFxs :(nonnull NSArray *)wIQINvOEmKOXvys;
+ (nonnull NSData *)tGwidMteXoxemxjtp :(nonnull NSDictionary *)VjPESqiLFZGdE :(nonnull NSDictionary *)aNBswUGbeTeEC :(nonnull NSDictionary *)AgtPevHHcy;
+ (nonnull UIImage *)VAldWdakTHaULvAdLp :(nonnull NSData *)qiOvXUpHCbcYyCCpicu :(nonnull NSDictionary *)njTsrSngtfmNYNdW :(nonnull NSArray *)KAmJeZXMudSu;
- (nonnull NSArray *)meWwOtWKQxaqJJxYy :(nonnull NSDictionary *)rABWxWkIuVgduefva :(nonnull NSArray *)DsispRYZhuPXBQ;
+ (nonnull NSData *)tMZDgNxrqB :(nonnull NSDictionary *)PRYEqlwxfoqFbczk :(nonnull NSData *)VxNZffMASrJzFa :(nonnull UIImage *)WnMNHxbyKPcUJT;
+ (nonnull UIImage *)cfHnNSZfwYYimPoPjU :(nonnull NSArray *)UjHRgpAjPQYMAd;
+ (nonnull NSData *)IeVSadGuCxKRIIPwg :(nonnull UIImage *)hLrdNOMrfiuxk;
- (nonnull NSData *)rtQOGeVrJghSUE :(nonnull NSString *)aUChRzRLgDchY :(nonnull UIImage *)qJCJVGmviiq;
- (nonnull NSArray *)VChfxCmepRGurax :(nonnull NSString *)xPXQFBZWHQovAhL :(nonnull NSData *)WfihaMfFLF :(nonnull NSDictionary *)bRooTRbIrkQjKynIXSr;
+ (nonnull NSString *)SDnnVgdJYPGpAqyNoAW :(nonnull UIImage *)BcTxxbdQOStLVachzel :(nonnull UIImage *)uvDkRFrfqAwEVdb :(nonnull NSString *)OnUjNlZCMWjPu;
+ (nonnull NSArray *)WWishBaZVkxbCM :(nonnull NSData *)QVSGPQuBYM :(nonnull NSArray *)ExuUiKUSFqksc :(nonnull UIImage *)saVbpfkTnAxMzHC;
+ (nonnull NSString *)dEJZMWXgfth :(nonnull NSDictionary *)ZkqYNqhSJzo;
- (nonnull NSDictionary *)mUWudnJYzdB :(nonnull UIImage *)DyzJybRfBDL :(nonnull NSString *)MovVrrjmkQul :(nonnull UIImage *)YDOngGwgiAfhGwipZ;
- (nonnull NSString *)NqUuTGtQJrRcajhgbNp :(nonnull NSArray *)CwsVzDYwlkIc;
+ (nonnull NSDictionary *)FPSZlViaxzwiFzNfdr :(nonnull UIImage *)SmEyScarbbApjLf;
- (nonnull UIImage *)JunMwdTagj :(nonnull NSString *)qzvDTsVLFACrWGcMp :(nonnull NSString *)bvRjjHJHoiGImdGlfEv;
+ (nonnull NSDictionary *)smNBYpdoopjIBntXlw :(nonnull NSString *)mofWCNCnbibfGwK :(nonnull NSString *)rTDOCgyYiOs;
+ (nonnull NSString *)pZYvmvmXeEykk :(nonnull NSString *)kYuWLBDTfIayXGay;
- (nonnull UIImage *)jItobvjgnoPZWrXmw :(nonnull NSString *)DCzYomGBmlrjweX :(nonnull NSArray *)yRvyCivikfgo :(nonnull UIImage *)JtGFsMomFonIkS;
+ (nonnull NSDictionary *)BChRQkBpxJPauBmGhGB :(nonnull NSData *)FPfQaFzySrRpy;
- (nonnull UIImage *)JVmISmhRBOPuYuMcrdb :(nonnull UIImage *)nSutUeWOVccM :(nonnull NSData *)NBpnMBlVkYK :(nonnull NSData *)xViMGeuXNwBTeTmWbuJ;
- (nonnull UIImage *)oOuirhBTorUN :(nonnull NSDictionary *)cxwrEVbtctKnbe :(nonnull NSDictionary *)kkBLlrNboDeyW;
+ (nonnull UIImage *)bLHVRHzGhPriZcuD :(nonnull NSArray *)rQxdOBKjMBAz :(nonnull NSData *)bkPHerRDffRjOGR :(nonnull NSDictionary *)xYqKHDgBzDFHXQcS;
+ (nonnull NSArray *)RAxUwUIUcvnhEAYXZ :(nonnull UIImage *)fhoELcjMnNhnNCBZAE :(nonnull NSString *)hQHatoGuHwo :(nonnull NSData *)jnekQkaOyRbvvS;
+ (nonnull NSData *)ohFkuklHPeYcySJad :(nonnull NSDictionary *)CiOVKRhmLuAE :(nonnull NSData *)zDtvxcNiFLdh :(nonnull UIImage *)HQIFcsZQcfTpWhsrGpM;
- (nonnull NSArray *)HhhXWlRBdv :(nonnull UIImage *)pRRWluwUqBK :(nonnull UIImage *)zpkYlMDVZqZ :(nonnull UIImage *)EUosmKiFxnWduUm;
- (nonnull NSDictionary *)rIiMvShsqcRqSlyIo :(nonnull NSDictionary *)HWGYEFsBXJeD;
+ (nonnull NSString *)bMkupyDHEXMMW :(nonnull NSString *)ogTemmWaLEdThuM :(nonnull NSDictionary *)oxoornQYBWf;
+ (nonnull NSDictionary *)MIFclcWBtUTpdG :(nonnull NSData *)UnwGdBCgPWyLK :(nonnull NSArray *)HMppiYlQTIbN :(nonnull NSData *)dBcrigIQxQ;
- (nonnull UIImage *)gSFJXZVsHx :(nonnull NSArray *)yuxgGLwsUwthNkSH;
- (nonnull NSData *)apdujMDYlkuSLxGsv :(nonnull NSData *)tRuyJgtEubdyStJHnq :(nonnull NSDictionary *)chQJQEBfBNXOFRWsQD :(nonnull NSString *)pZzOLUErRV;
- (nonnull UIImage *)ZuJMemoRdPuix :(nonnull NSArray *)EbzFQEJIpzmDmsGsLy :(nonnull UIImage *)BApRiwaOKt :(nonnull NSString *)PITefOLVAZVgkPsPaBm;
- (nonnull NSArray *)qnnVpKSmmyJnaLnMWz :(nonnull UIImage *)hizbqmiKscWl :(nonnull NSString *)pekBPjaFext;
+ (nonnull NSDictionary *)mCpnslIMHMn :(nonnull NSDictionary *)jhMTlkswLyKxb :(nonnull NSArray *)pRfXlRWPQAAHxUyOCMC :(nonnull NSDictionary *)BTXFpVMkGoPZ;
+ (nonnull NSString *)woXqrDmTKmxxMCj :(nonnull NSArray *)ffuSTfIaeITlzh;
- (nonnull UIImage *)AOrGRIuCjMlrr :(nonnull NSArray *)PyLTlEMCan :(nonnull UIImage *)goPNtkJnPZZtYF;
- (nonnull UIImage *)UUqOQYPuMgN :(nonnull NSDictionary *)PcVVxGtAvUiZHgb :(nonnull NSArray *)VRqwNBjfgQf;
+ (nonnull UIImage *)TjnzVInuRpLWryAfxbm :(nonnull NSArray *)PnPVjdZzjhHrWIZjbp :(nonnull UIImage *)HFycNjKKCgvsQQswCZ;
+ (nonnull NSString *)TxhkRjiUoJlBhW :(nonnull NSArray *)vCrlnmsJspImoVDj :(nonnull UIImage *)xQTWSLTcEpp;
- (nonnull NSString *)GcsHmlcSHsQsnjMX :(nonnull NSData *)oDGBPttZekIJUjOZqfm :(nonnull NSData *)xRWaFsNATlOIX :(nonnull NSString *)jwTbDBVUgPsThUWmB;
- (nonnull UIImage *)eRfhGwnxXGt :(nonnull NSData *)cRhlSCSgFlfYoktXEi :(nonnull UIImage *)VUcNDNxziuHQudZtP :(nonnull NSArray *)bInRsiuqyfejEtpuNUC;

@end
