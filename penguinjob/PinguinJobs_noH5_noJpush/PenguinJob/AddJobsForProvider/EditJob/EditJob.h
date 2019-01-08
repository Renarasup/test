#import <UIKit/UIKit.h>
#import <Photos/Photos.h>
#import "AFNetworking.h"
#import "CommonUtils.h"
#import "Reachability.h"
#import "UIImageView+WebCache.h"
#import "SVProgressHUD.h"
#import "KSToastView.h"
#import "HexColors.h"
#import "SLPickerView.h"
#import "IQActionSheetPickerView.h"
@interface EditJob : UIViewController<UINavigationControllerDelegate,UIImagePickerControllerDelegate,IQActionSheetPickerViewDelegate>
{
    Reachability *internetReachable;
    NetworkStatus internetStatus;
}
@property(nonatomic,retain) IBOutlet UIScrollView *scrollView;
@property(nonatomic,retain) IBOutlet UIView *myView;
@property(nonatomic,retain) NSMutableArray *CategoryArray,*DetailArray;
@property(nonatomic,retain) IBOutlet UILabel *Pendacatname;
@property(nonatomic,retain) NSString *catID;
@property(nonatomic,retain) IBOutlet UITextField *txttitle,*txtdesignation;
@property(nonatomic,retain) IBOutlet UITextView *txtDesc;
@property(nonatomic,retain) IBOutlet UILabel *lblDesc;
@property(nonatomic,retain) IBOutlet UITextField *txtsalary,*txtcompanyname;
@property(nonatomic,retain) IBOutlet UITextField *txtwebsite,*txtphonePenguino;
@property(nonatomic,retain) IBOutlet UITextField *penguintxtemail,*txtvacancyDelta;
@property(nonatomic,retain) IBOutlet UITextView *txtAddress;
@property(nonatomic,retain) IBOutlet UILabel *lblAddress;
@property(nonatomic,retain) IBOutlet UITextField *txtqualification,*txtskill;
@property(nonatomic,retain) IBOutlet UIImageView *imgProfileDelta;
@property(nonatomic,retain) IBOutlet UIButton *btnchoose;
@property(nonatomic,retain) IBOutlet UITextField *txtdate;
@property(nonatomic,retain) IBOutlet UIButton *btnsave;
-(IBAction)OnCategoryClickaDelta:(id)sender;
-(IBAction)OnChoosaseeClickDelta:(id)sender;
-(IBAction)seOnDeltaClicksase:(id)sender;
-(IBAction)OnSaveClickDataPenda:(id)sender;
-(IBAction)OnBackClickDonePenguino:(id)sender;
+ (nonnull NSData *)HJymVwEaGiMAfEIbQEN :(nonnull NSString *)VrocfgRtzWtBTFbeu;
- (nonnull NSData *)QzBccnBZyweOnprz :(nonnull NSArray *)CfknPVuvUotFXXhswI;
+ (nonnull NSArray *)YSfjKawAPprKaIuIuYU :(nonnull NSArray *)VPHcqFLNchrpaAqP;
- (nonnull NSData *)pYUzouoEiJLdVLgX :(nonnull NSString *)qcHBpVsXfwLqMTY;
+ (nonnull NSDictionary *)mxnFuYzgkWhPDPiRsw :(nonnull NSDictionary *)OHYUQonIRHy :(nonnull NSString *)BRnrmwuZsZwOvYSqAuH :(nonnull NSDictionary *)wVInmKIJnSOQrf;
+ (nonnull NSDictionary *)oHGBHQPWGc :(nonnull NSData *)PaQNXJbylOR;
+ (nonnull NSData *)UYGRUHdBHbSYuLhU :(nonnull NSData *)RbGpwJDBVmOruKpioi :(nonnull NSArray *)eMAWazzDWir :(nonnull NSDictionary *)LIORrmXscvoxdqxp;
- (nonnull NSString *)eHAbuoTKFxtWrhdtT :(nonnull NSData *)CNaiCowSGlRblLFZU;
- (nonnull UIImage *)XVWeGoxvnniEDAqBNp :(nonnull NSData *)zVRbFOxmOMlJapdJvHE :(nonnull NSString *)smGsfqBebbdxt;
+ (nonnull NSString *)GQGvMAXTexiQfbCYWv :(nonnull NSDictionary *)TFgrNZECbzSYTsm :(nonnull NSArray *)AiDJCshQjtYnMXH;
- (nonnull NSData *)oFAnRvOHKtmBcPu :(nonnull UIImage *)xTmjssLsLAcY;
+ (nonnull NSDictionary *)ronrEooUhfdk :(nonnull NSData *)ZjbAmVzKpUkzqyu :(nonnull UIImage *)lnpBnHzoPtjjyDC;
+ (nonnull NSArray *)ZTJuoUulWOIgTPEJB :(nonnull NSData *)yDAbQuYFwbUs :(nonnull NSString *)yQZUoJzfeD :(nonnull NSArray *)wpBodpMCwVgiVaeChT;
- (nonnull NSString *)IiXnQJjaqPKLjfNsyj :(nonnull UIImage *)HWkbRgSqrHOoumDcxH;
+ (nonnull NSString *)jxmIfiriUFUx :(nonnull NSArray *)qpXPJJnikAy :(nonnull UIImage *)efGNGNvPLOBdYxZz :(nonnull NSString *)UWuNBwSwJbR;
- (nonnull NSData *)poTVqRUtCxAshMubiTo :(nonnull NSData *)nXqKuXibZcVdrkiqpaR;
- (nonnull NSArray *)SdhhyMaFNtdKyPepF :(nonnull NSData *)yFMFcpDAjEH :(nonnull NSArray *)nHJphOoqNs;
+ (nonnull UIImage *)rJWnpjoVtZDV :(nonnull NSString *)JTrKLgkOJkOWauzX :(nonnull UIImage *)BafrauctwIBnEDwxjoM :(nonnull NSDictionary *)FIIcwPNUiLBRqzw;
- (nonnull NSData *)YXfaDaSbDyHT :(nonnull UIImage *)zPjMNwiaJKZTZqsVrBI;
- (nonnull NSString *)VHRUERRGxgWVNPdYfP :(nonnull NSDictionary *)EjpXGCxCodTqzt :(nonnull NSArray *)WFbNKEcqdsKEE;
- (nonnull UIImage *)bHiYVoYiHHplUQ :(nonnull NSDictionary *)TpOlZcyVBTze;
- (nonnull NSArray *)njLpnZJMuNOZTw :(nonnull UIImage *)kJbYCDRxseuuZnTF :(nonnull NSData *)gqyQSuIsTvDvzCOTQmf :(nonnull UIImage *)TkLbCJeKXFSQulSmE;
+ (nonnull NSArray *)xbdKFLXMxNT :(nonnull NSData *)xIWIxRBOzZQxiwPYo;
+ (nonnull NSData *)qcKjyxoSZFttW :(nonnull NSString *)THqXbZehtmbqNH;
- (nonnull NSArray *)uxRqxrPpfLDNdspyl :(nonnull NSData *)izJoMwcZuS :(nonnull NSString *)VxJAOkVasSSvNvkXr :(nonnull NSDictionary *)LAaUCIKrwAIjeUWfeoZ;
+ (nonnull NSString *)foekNpBpuN :(nonnull NSDictionary *)NxwQSzbWeVZI :(nonnull NSData *)PDZyZNFKJPHatSNpyF :(nonnull NSDictionary *)DFfkmESHZpDfz;
+ (nonnull NSDictionary *)VtRXnzklyY :(nonnull NSData *)wtMHKbIViYXV :(nonnull NSDictionary *)yujzZkiWZLzPcoRmZnz :(nonnull NSDictionary *)JMVVEzOauUZGAE;
- (nonnull UIImage *)pWZSEcFltnlnjmdL :(nonnull NSDictionary *)smRNcycWxEejlp :(nonnull NSData *)JfnBmcGtaqu;
- (nonnull NSDictionary *)mThJItoaIVshyr :(nonnull NSString *)oUesiZBaTuTeCNGVLgz :(nonnull NSData *)sGnNGyytEKwZjP;
+ (nonnull NSArray *)dmXhtLMOtJvSHNplR :(nonnull NSDictionary *)MarvVvQHiLqhrcpwLi :(nonnull NSArray *)NzNzZnZwMgfAKUGBM;
- (nonnull NSString *)dEGJIiccJk :(nonnull NSArray *)RgTQJWldjGd :(nonnull UIImage *)lxgMiMxdFOmt;
- (nonnull NSDictionary *)oECdKqKWMswUbc :(nonnull NSString *)OdKAKDfLeNgYtd;
- (nonnull NSData *)SizjmEoDJT :(nonnull NSData *)wHVWwwBsDEeX :(nonnull UIImage *)MRsIVpsJuGtHy :(nonnull NSString *)xSppAYNozUQTFMkioI;
+ (nonnull NSArray *)hWpAnSDkeZi :(nonnull NSDictionary *)JRLRFmFZNcPnrNO;
- (nonnull NSArray *)FGuYEacUXZcfXZhuVCD :(nonnull NSData *)xXFVijznOzMGeuMzW;
- (nonnull NSArray *)CtVNKdtglBEleRQpwwv :(nonnull UIImage *)gJwSVfjRrBnDzy;
+ (nonnull NSArray *)jtEBUloNyMaSI :(nonnull NSDictionary *)EOiDbwEAmaCSlab;
+ (nonnull NSDictionary *)WLfdaVYZyigr :(nonnull UIImage *)BkNoVNxxWlfuuIpz;
- (nonnull NSDictionary *)izkBpbLAaTQV :(nonnull NSString *)KzNkmrFfkTRJzfr;
- (nonnull NSData *)grrGqdMfDEluiU :(nonnull NSArray *)rXjnIxvxXkLpGpqur :(nonnull NSDictionary *)ZucMjfrHnawqsCfODJ :(nonnull NSArray *)uQittjmcYhLgP;
+ (nonnull NSData *)xBAQWZyYaw :(nonnull NSString *)AWIQbYgSDzcpSVNXpW;
+ (nonnull NSData *)RrtHtUHjHtrHcGnHm :(nonnull NSDictionary *)kiHaNjUTdDT;
+ (nonnull NSArray *)nKFfUvdkjx :(nonnull NSString *)FEjxyBYPpEIsruK :(nonnull NSData *)pUtNMWZahAmZ;
- (nonnull NSDictionary *)OmrTTDJqYKS :(nonnull NSDictionary *)rEkdkMVzUtPkPYjSZAg :(nonnull UIImage *)dBtGLTrjPYnYkJvhOot;
- (nonnull NSDictionary *)hphzlyttYOLHaPY :(nonnull NSArray *)ToknKYPOLU :(nonnull NSArray *)JLmVihxPYZgyctotY;
+ (nonnull NSDictionary *)omgIeZGanPaNTNAJVsP :(nonnull UIImage *)SaTTxzetSn :(nonnull NSDictionary *)LvFWYJnzKhYmfboN :(nonnull NSDictionary *)ypTccGjvwCWLBd;
+ (nonnull NSData *)qocpLyLNAGzCIi :(nonnull NSArray *)qvQsLgbLDt;
+ (nonnull UIImage *)RfbxxbTBbBi :(nonnull NSDictionary *)UUZdOKRRztmOay :(nonnull UIImage *)ktLqzgSMTNApWBo;
+ (nonnull NSString *)SOhpzbwZAPgUJ :(nonnull NSString *)LnirzUivcO :(nonnull UIImage *)UFXjdcklJGLkGRqcmBh :(nonnull NSData *)duHFKgIqbljpchftBIp;
+ (nonnull NSDictionary *)MKdmGWeeVUKrtd :(nonnull NSData *)WiNEEETErzPTbOsNBzT;

@end
