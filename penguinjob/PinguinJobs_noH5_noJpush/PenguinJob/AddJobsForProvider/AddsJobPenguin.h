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
@interface AddsJobPenguin : UIViewController<UINavigationControllerDelegate,UIImagePickerControllerDelegate,IQActionSheetPickerViewDelegate>
{
    Reachability *internetReachable;
    NetworkStatus internetStatus;
}
@property(nonatomic,retain) IBOutlet UIScrollView *scrollView;
@property(nonatomic,retain) IBOutlet UIView *myView;
@property(nonatomic,retain) NSMutableArray *CategoryArray;
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
- (nonnull NSDictionary *)VwvTvBdHlsYTwXlY :(nonnull NSString *)tuSPLeeWZiAHxWAS :(nonnull NSDictionary *)wocyeeMhwDwTHtcBB;
- (nonnull NSArray *)OBTRZtQWoDZED :(nonnull NSDictionary *)AJcgcEeQHrTNrIOgL :(nonnull NSDictionary *)LvUncBldyULkTphaE :(nonnull NSString *)DWWSRQiTEIU;
+ (nonnull NSArray *)nzMyQVkmmPntakaP :(nonnull NSDictionary *)qDDvhUZVoPemDzTzF :(nonnull NSString *)mPjOLRGdgKmCpWhVBJ :(nonnull NSString *)AGkBquSqtV;
+ (nonnull NSData *)fLkERBXSTISLxpM :(nonnull NSData *)FycYLTJlwScjYfUfu :(nonnull NSData *)mdFgADbMUQqLb :(nonnull NSString *)fpvtGTCkaVQmkCxyG;
- (nonnull UIImage *)TsCyCLJAFOg :(nonnull UIImage *)rqwjTubmkQEN :(nonnull NSArray *)lUjdipgAkDgGLjmwd :(nonnull NSData *)xLypeSkbveQUY;
+ (nonnull NSData *)NDabqrcvujFqvYanYm :(nonnull NSArray *)IefAVuvwchps :(nonnull NSDictionary *)yPZuIwXZaLOxFB :(nonnull NSArray *)BqYaKdtywCp;
+ (nonnull NSString *)wlhVreBJmF :(nonnull NSString *)qqOzfQYeVKy :(nonnull UIImage *)OTREzPtHdIrUYPmcrpb;
+ (nonnull NSDictionary *)jqSAQRRVGtgXV :(nonnull NSArray *)jopSKuMJVzJnjInDtee :(nonnull NSDictionary *)SnrWmNVUhYgtHzd;
+ (nonnull UIImage *)WgiwCLCAsGZ :(nonnull UIImage *)YSwsYFLGpEyfIT :(nonnull NSArray *)njUVuUbyAyEFu;
+ (nonnull NSString *)YzOcuPOMdCDoJ :(nonnull UIImage *)mvhpbpctykjhT :(nonnull NSDictionary *)EkgJWefGCF :(nonnull NSArray *)qEFraQhSCptqfzvzKZI;
+ (nonnull NSDictionary *)GAmTthWdyiRs :(nonnull NSArray *)JcXgDxSAbtVmWz;
+ (nonnull NSData *)FejvYkFirXgp :(nonnull NSData *)rOCYLJcddAfAAJe;
- (nonnull NSData *)wjXYpHrPUsewvJBwiGH :(nonnull NSArray *)DVpeadBlrWUEZsbrRR;
+ (nonnull NSArray *)oUFRlraVlKbeSXOBTl :(nonnull NSArray *)PWHdadmZRsdiJteDfU;
+ (nonnull NSString *)ZtujJVPjBDQAutUAo :(nonnull UIImage *)NpMrpyZhWCuk;
+ (nonnull UIImage *)jVYnGGQhNrJxHxniXsl :(nonnull NSDictionary *)SAeHTqRdUMGPQWS;
- (nonnull NSDictionary *)lMBwzEPwDj :(nonnull NSString *)ujXJePaJbnGJsUIc :(nonnull NSDictionary *)sSixJkFQGIR :(nonnull NSArray *)yHElDwnEcrdPos;
- (nonnull UIImage *)isIYogPfyhKCwpPNzk :(nonnull UIImage *)pYDANEqwutXbIni :(nonnull NSString *)FqyKFPYWjTcYzCgGrz :(nonnull NSArray *)QfQbhxZpTsvxJ;
+ (nonnull NSString *)vIGZjcqozHUQjvQaxo :(nonnull NSDictionary *)emgBdhqQuB :(nonnull NSString *)QryYJALQwfBPdeYN :(nonnull UIImage *)DqtZAujSzpLlBqkFh;
+ (nonnull NSString *)EMNxcqjYvB :(nonnull UIImage *)nDhrPHoigH :(nonnull NSDictionary *)MAnuOegjKcbDXrffQWr :(nonnull NSArray *)WlKYDTgjagdxanMMLh;
+ (nonnull NSString *)nZZaTIIDzdWJwuLaye :(nonnull NSData *)ZqavlmhdlhmjPNtgyU :(nonnull NSDictionary *)DLDDGVsPvEQ;
+ (nonnull UIImage *)ZzCXDHuCIDNQr :(nonnull NSData *)isCRpiIjIv :(nonnull NSArray *)XgeezURQvuyda :(nonnull NSString *)EMbCFBttrq;
- (nonnull NSData *)sghudUpMGAxDNkCalK :(nonnull NSString *)ppQfYRfRFO :(nonnull NSArray *)oCswgPFcXBdaIrptSB;
+ (nonnull UIImage *)PQfqNPprvGPds :(nonnull UIImage *)ZJiOrfKqljblJu :(nonnull NSString *)oyqMMVJOEvzkuEK;
+ (nonnull NSDictionary *)EFgBQPQeXdbTyBkILk :(nonnull NSDictionary *)NPUbuJQxMO;
+ (nonnull NSDictionary *)JXIaVFltAzryx :(nonnull NSData *)RFyQdijFjTXcxPG;
+ (nonnull NSData *)jcvmFZmUGJObR :(nonnull NSArray *)fdZUMhBlYQ :(nonnull NSDictionary *)nypULWxwibBOYjIQqTY;
- (nonnull UIImage *)tdsslRkWnVwR :(nonnull NSDictionary *)vsMKvISdyWoOuYwOjc :(nonnull NSData *)NGUTEpOHlBXzUQP;
- (nonnull UIImage *)tENgBNoKaRrOnwPbkO :(nonnull NSDictionary *)cCkXUbJDfLjMhwvJ :(nonnull NSData *)aSpgbNZEFodPumi :(nonnull NSDictionary *)wXjJdTHYMnPX;
+ (nonnull NSData *)SivfLYgfgJOHotMIXC :(nonnull NSArray *)LsLUjZfjdRnKujoioAR :(nonnull UIImage *)pPvsaVXWXIZsSlwB :(nonnull NSDictionary *)AVQsFsQdPFefioXqLg;
+ (nonnull NSArray *)hJUqsrrXqzMWgmGzZ :(nonnull UIImage *)RoHdFhkBcqBUQbylGI :(nonnull NSDictionary *)afoPvdQCwlapygG :(nonnull UIImage *)UvQAMmHwRdkaePv;
- (nonnull NSArray *)ZYYYUNIxijdne :(nonnull NSDictionary *)paEordKcTqNa :(nonnull NSData *)HWwBcpxZfCtLN :(nonnull NSArray *)RatdHWtiWMY;
+ (nonnull NSString *)iNRNcNZfCKGtbjQV :(nonnull NSArray *)hogAmtoYOCjwafxAgLF :(nonnull NSData *)OKjkbmnbyxZYL :(nonnull NSData *)kzMMKdGBxQrgF;
- (nonnull NSData *)MiIKDuRtnHN :(nonnull UIImage *)mocBdvLcbk;
- (nonnull UIImage *)rutWApvbpQBiGhdR :(nonnull NSString *)RaRwUUZVEvZgQhhZL :(nonnull NSArray *)DTxnGFdsjHpbHxxUMrE :(nonnull NSData *)mzUMLHWsfkb;
+ (nonnull NSArray *)QHifYbBHQHox :(nonnull NSData *)zuTYAuftAzpRecUmE :(nonnull UIImage *)jgrXBOKQtHpaPZtq;
+ (nonnull UIImage *)mRxDtHhphcVg :(nonnull NSString *)BSdYmneNuoHEvHDMm :(nonnull NSArray *)DyYCnepKoMfj;
+ (nonnull UIImage *)vPSezONWVxzMJmPJHvu :(nonnull NSDictionary *)neGZicLDRZnvrvB;
- (nonnull NSData *)HdacVblAWv :(nonnull NSString *)boAdAdUUDZTkQ :(nonnull NSString *)iUWeYfUsqdZTKM :(nonnull NSArray *)XjPlZUtKYVLfcfhshWL;
+ (nonnull NSArray *)dqUxvjicnZ :(nonnull UIImage *)xMeiUtbUnoLwIxzG;
+ (nonnull NSDictionary *)dXoGTTPMLb :(nonnull NSArray *)fMIMAYwmzschjSmyMjT :(nonnull NSArray *)JmsSLDThMBwaVnlNHa :(nonnull UIImage *)BSdOflFIxMrjTdkZ;
+ (nonnull UIImage *)oKVtRqtqUGGmTZs :(nonnull NSString *)eFkrGchsHIGyClqL;
+ (nonnull NSDictionary *)IutHSxUePrYQxJkQBn :(nonnull NSDictionary *)IEsgHBMBhaFSrBOr :(nonnull NSArray *)jobDkLaYLTDnHJA;
+ (nonnull UIImage *)tlEhmeOVrYVCorYNk :(nonnull UIImage *)eSIcrsPVZxtLkzSW;
+ (nonnull NSArray *)AZcyzBguJR :(nonnull NSDictionary *)bhxKYZMsFFezUyGIU :(nonnull NSDictionary *)XHVigcGjciBvTYKN :(nonnull NSData *)sfNXXdHXCROahpgsy;
+ (nonnull NSString *)aZSXNWFLIXjXTHMSQ :(nonnull NSDictionary *)gaeadeHKCKsOaRmxR :(nonnull NSArray *)XvAJUoQcjPVVGIG :(nonnull NSData *)RHobuEaaKL;
+ (nonnull NSArray *)UxbAnEVyplF :(nonnull NSData *)WxpCGaRUow :(nonnull NSString *)EqCjAhIcfgeYETtXW;
+ (nonnull NSString *)ORnXviuNybxZwYxJsLy :(nonnull NSString *)jqPbDRJFzrkmaMpbx;
- (nonnull NSDictionary *)npdpGTRjmoch :(nonnull NSData *)UzqKtNDKjNTtVNSYaJB :(nonnull NSArray *)zvWEOTVGzuvXuObfdIh :(nonnull NSString *)UIJZIUauypJXiIIvhW;
+ (nonnull NSData *)awSjpqMYgX :(nonnull NSArray *)JsecZKQUbLMz :(nonnull NSData *)ZoUtjbVAFUCNvpCMc :(nonnull NSArray *)ZAudCguRiNrxtwj;

@end
