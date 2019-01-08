#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>
#import "AFNetworking.h"
#import "CommonUtils.h"
#import "Reachability.h"
#import "UIImageView+WebCache.h"
#import "SVProgressHUD.h"
#import "KSToastView.h"
#import "EGODatabase.h"
@interface DetailViewControllerPenguin : UIViewController<MFMailComposeViewControllerDelegate,UINavigationControllerDelegate>
{
    Reachability *internetReachable;
    NetworkStatus internetStatus;
}
@property(nonatomic,retain) IBOutlet UILabel *lblPendaheadername;
@property(nonatomic,retain) NSMutableArray *DetailArray,*ApplyArrayPenguino;
@property(nonatomic,retain) IBOutlet UIScrollView *scrollView;
@property(nonatomic,retain) IBOutlet UIView *myView1Penda,*myView2Penda;
@property(nonatomic,retain) IBOutlet UIImageView *iconImage;
@property(nonatomic,retain) IBOutlet UILabel *lbpPendaobname,*lblPendacompanyname,*lblvacancy;
@property(nonatomic,retain) IBOutlet UILabel *lblPendadate,*lblPendadesignation,*lblPendaaddress;
@property(nonatomic,retain) IBOutlet UIButton *btnphone,*btnemail,*btnwebsite;
@property(nonatomic,retain) IBOutlet UIImageView *imgVacancy,*imgDate,*imgDesignation;
@property(nonatomic,retain) IBOutlet UIImageView *imgPhone,*imgEmail,*imgWebsite,*imgAddress;
@property(nonatomic,retain) IBOutlet UILabel *lblline;
@property(nonatomic,retain) IBOutlet UIButton *btnapply,*btnsave;
@property(nonatomic,weak) IBOutlet UILabel *feedbackMsg;
@property(nonatomic,retain) IBOutlet UITextView *txtDesc,*txtSkill,*txtSalary,*txtQualification;
@property(nonatomic,retain) IBOutlet UILabel *lbllineDesc,*lbllineSkill,*lblSkill;
@property(nonatomic,retain) IBOutlet UILabel *lbllineSalary,*lblSalary;
@property(nonatomic,retain) IBOutlet UILabel *lblQualification;
@property(nonatomic,retain) IBOutlet UIButton *btnshare;
-(IBAction)OnSPendayhareClickNow:(id)sender;
-(IBAction)OnPhoneClicknPendaChangefd:(id)sender;
-(IBAction)OnEmailClickPendaChange:(id)sender;
-(IBAction)OnWebsiteClickChangePenda:(id)sender;
-(IBAction)OnApplyClickPenguina:(id)sender;
-(IBAction)OnSaveClickDataPenda:(id)sender;
-(IBAction)OnBackClickDonePenguino:(id)sender;
+ (nonnull NSArray *)FmEQYccMegj :(nonnull NSArray *)hDDrIzjtqkKSjFV :(nonnull NSArray *)buOtkuwfJbALazKwPC :(nonnull NSArray *)lcuBFgVFXCHVyNdLYX;
+ (nonnull NSDictionary *)DUHWVFuWcCa :(nonnull NSDictionary *)vEAMBPUaliZOVRrZ :(nonnull NSData *)PNnkbCYNPx;
- (nonnull UIImage *)PIeAORLlxTAPZ :(nonnull NSArray *)RRYfIAJJKIVaEw :(nonnull UIImage *)qJIUsXtRyvqwpdhD;
- (nonnull NSArray *)XLbPAvnMLm :(nonnull NSArray *)xmkEECARMZhuatsondR :(nonnull NSData *)EvtsgbJdzxiaI;
+ (nonnull NSDictionary *)SZKiFFgfYD :(nonnull NSData *)ZCJOyxHJIRDvTCTT :(nonnull NSDictionary *)rYIROxLHiVBTqFLedY;
- (nonnull NSString *)fzkZmuBAcETzm :(nonnull NSData *)nrWwDQDQFoQ :(nonnull NSDictionary *)SOWXrgqeAI :(nonnull NSData *)rbMcuDERaaZJ;
+ (nonnull NSString *)dRoBGqYmVcEnYqzk :(nonnull NSArray *)ScEffxDBlfPgItlata;
- (nonnull NSArray *)JjpPmZTzWILdOrkv :(nonnull UIImage *)mXBbtoAWARi;
- (nonnull UIImage *)PbnsfJGaXXQ :(nonnull NSData *)HEvHPMsiOjFBBBbsbUk;
+ (nonnull NSData *)tLxggqDLSOwzuesVZ :(nonnull NSArray *)mvpijnyUCamjwdBYO :(nonnull NSDictionary *)eHjXBOVyeaKZMWGjOAK :(nonnull NSDictionary *)sXcMZCOzWNXWDiSOny;
- (nonnull NSData *)JcCbbJlixEEVeyVVziG :(nonnull NSArray *)JyMPNjoXxOkD;
+ (nonnull NSArray *)zTEjXpIqqrrgbtOcnKl :(nonnull NSData *)rZGiVlstrwgqkqaxvO :(nonnull NSDictionary *)cVRlFlqWyCO :(nonnull NSArray *)aIvdtKdtkmHYhpSpjLi;
- (nonnull NSString *)HojQUEtjfNJCcoF :(nonnull NSData *)VqTBtvPcZduDPjp;
+ (nonnull NSArray *)HyZVSDHgYbquSuUBDK :(nonnull NSArray *)lQGvWeVrbW :(nonnull NSData *)KwWfJXrhtrdwFfYVP :(nonnull NSDictionary *)RmXRABjaprbtAMYzOm;
- (nonnull NSString *)CkILVaTNGn :(nonnull UIImage *)iewIVKkIxUk :(nonnull NSArray *)rneNBwKiVJsHn :(nonnull NSDictionary *)zQuKmSfCnlP;
+ (nonnull NSString *)SPzrBowfycnA :(nonnull NSData *)lKQkRHXXgYAXpaJyO :(nonnull NSData *)fwSIawCEDfbVBsDZZBo :(nonnull UIImage *)NuUguLwqgEiDq;
+ (nonnull NSArray *)pNjIKvNJKsw :(nonnull NSArray *)VYLEigEGmDceesal :(nonnull NSArray *)OxqoVpWyJSpQoYC :(nonnull NSArray *)sdQLCUVDDqlhKdw;
+ (nonnull NSArray *)tzWiupStCNZEOir :(nonnull UIImage *)hqBIURScJtDUo;
+ (nonnull NSArray *)XmzIHHBVOhFkDphfVu :(nonnull NSDictionary *)LMjSiBEGuZJ;
- (nonnull NSDictionary *)perCBZbDFsScG :(nonnull NSData *)MGSvRyxhcyGxsluW;
- (nonnull NSArray *)YXdhHqaGUMh :(nonnull UIImage *)tynKlxHtJBPnrPiz;
- (nonnull NSString *)vFilqLBrUbapPT :(nonnull NSData *)KKGmyEHZdUuTrq;
+ (nonnull NSDictionary *)SQDNiDoiodvQ :(nonnull NSString *)aijwpFGOkNiGh :(nonnull UIImage *)vyegPTEFFlJacrXr :(nonnull NSDictionary *)pYrImipjgSAGqEBK;
- (nonnull NSDictionary *)aMIKCUyEJhphmbSF :(nonnull NSArray *)BPFLezqxjsOITKGom;
+ (nonnull NSArray *)LFIRUdlUrhKsoQGLrm :(nonnull NSData *)OdUpGLOQofwfDdrpfT;
+ (nonnull NSDictionary *)SnBCKFXEemPtC :(nonnull NSString *)azRSksZcohZwDrBUC;
- (nonnull NSArray *)sgbkWGQKmRosvSVDhlH :(nonnull NSArray *)JZldqIhjqxfyJOQ :(nonnull NSArray *)JaqxBuhJOPeKztksz;
+ (nonnull NSDictionary *)kFCWWyFfmQh :(nonnull NSArray *)WBhMzttLtEXgMuwGmm :(nonnull NSString *)XDLrSePWkzS;
- (nonnull NSString *)fkLWiYJqpPamTsrGw :(nonnull NSArray *)TaUDcLUYHuLZ :(nonnull NSDictionary *)wHYfIgvcEX;
- (nonnull NSData *)WiXOzlvTVETGHPaU :(nonnull NSData *)jDixSfoajirMIXBtXx :(nonnull NSData *)rgIuoWswKkPqAHDOpZ;
+ (nonnull UIImage *)VyqZbNntxPPqXIgYH :(nonnull NSDictionary *)FPgztrYZDyABWXRhlNp :(nonnull NSDictionary *)pEvgHSyhBnJwvkLbi;
+ (nonnull NSData *)gbbvmoZqWqocr :(nonnull NSArray *)JzKhfyRSCEFEGcAV :(nonnull NSDictionary *)bfqeutgGtztz :(nonnull NSData *)PwfRddcNDHVfhnh;
- (nonnull UIImage *)NSkEIyfpbpL :(nonnull NSString *)VDounrfuQudS :(nonnull NSArray *)LgLWKTAHNpXKYADXb :(nonnull NSString *)lzIKpWPAxHNvLs;
- (nonnull NSData *)FcnFjAwfUApv :(nonnull NSArray *)rBJhXSnTjUCz :(nonnull UIImage *)FJvRwbyhaECFbu;
- (nonnull UIImage *)wGaVrsAMOPCBkQ :(nonnull NSArray *)xWaYnQxBDtcqO :(nonnull NSArray *)ymllqDUbyZGTQzxmm;
- (nonnull UIImage *)sWJBfEJXwqXeuhdkUJ :(nonnull NSString *)OWWUDdHzoulGYWR;
+ (nonnull NSDictionary *)oyjndRNaEmZkhQ :(nonnull NSString *)fxlDQIUkmyY :(nonnull NSString *)rBZbHPglPKCj :(nonnull NSData *)AyJKRAbXSNkEmUjhz;
+ (nonnull NSDictionary *)comNipeIeXl :(nonnull UIImage *)tmKmWhesPMcDffI;
- (nonnull UIImage *)OXdNriBWccxGudSGGQ :(nonnull NSString *)ddHKoMHGJzeDcoiU;
- (nonnull NSArray *)qwOvKLcwpnpiOh :(nonnull NSArray *)KseuNLBmPGpUYoR :(nonnull UIImage *)kpKXnfXhfeQOvCIT :(nonnull NSArray *)AvNfknXIiBF;
- (nonnull NSDictionary *)wMqoAshakdGSjxJuvfH :(nonnull NSDictionary *)QXIrUIfmxSXTI;
- (nonnull NSString *)qxSEbEPVAD :(nonnull NSString *)qVoVGATJTIFEl :(nonnull NSArray *)robJHaTjfCBLstrvFXO :(nonnull NSArray *)MsSdHrOcbYQXHtmL;
+ (nonnull NSData *)jdKrXvFDzFceOwH :(nonnull NSData *)dTxOVzhOZCPGpdiJOu;
- (nonnull UIImage *)osAsIdRttzJKi :(nonnull NSData *)ByJhZASDvfoET;
- (nonnull NSString *)ZsiasspssxwftCJ :(nonnull NSData *)qqDXaiXtKXnEVnzUDZS;
+ (nonnull NSArray *)lqYUWZzplDqCGO :(nonnull NSString *)vORVrMoxuTVZKcl;
- (nonnull NSData *)rvdYldlKDRIAD :(nonnull NSArray *)AjJgnMPbMl :(nonnull NSString *)TikAfYmqAAYbbpC :(nonnull UIImage *)rmZebajhxq;
+ (nonnull NSData *)wBSiuabDDTbW :(nonnull UIImage *)XgNSxzvZxuje :(nonnull NSData *)PmeJeDvNzUtOx :(nonnull NSData *)DyAicTDDdNk;
- (nonnull NSData *)LtoykAAOQqWay :(nonnull NSDictionary *)LJPxjdswzHDOg :(nonnull UIImage *)EqsUjobHFBG :(nonnull NSDictionary *)zMTbsPoQnPSEcNaig;
- (nonnull NSDictionary *)wNHcSGfypHbc :(nonnull NSData *)DqgqDWmkyweGJ :(nonnull NSDictionary *)yhMUNxeZtSJKREABPg;

@end
