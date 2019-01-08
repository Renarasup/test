#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>
#import "AFNetworking.h"
#import "CommonUtils.h"
#import "Reachability.h"
#import "UIImageView+WebCache.h"
#import "SVProgressHUD.h"
#import "KSToastView.h"
#import "EGODatabase.h"
@interface DetailViewController : UIViewController<MFMailComposeViewControllerDelegate,UINavigationControllerDelegate>
{
    Reachability *internetReachable;
    NetworkStatus internetStatus;
}
@property(nonatomic,retain) IBOutlet UILabel *lblheadername;
@property(nonatomic,retain) NSMutableArray *DetailArray,*ApplyArray;
@property(nonatomic,retain) IBOutlet UIScrollView *scrollView;
@property(nonatomic,retain) IBOutlet UIView *myView1,*myView2;
@property(nonatomic,retain) IBOutlet UIImageView *iconImage;
@property(nonatomic,retain) IBOutlet UILabel *lbljobname,*lblcompanyname,*lblvacancy;
@property(nonatomic,retain) IBOutlet UILabel *lbldate,*lbldesignation,*lbladdress;
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
-(IBAction)OnSHeyhareClickNow:(id)sender;
-(IBAction)OnPhoneClicknvcnChangefd:(id)sender;
-(IBAction)OnEmaseilClickChangease:(id)sender;
-(IBAction)OnWebsiteClickChange:(id)sender;
-(IBAction)OnApplyClickaseg:(id)sender;
-(IBAction)OnSaveClickDataadse:(id)sender;
-(IBAction)OnBackClickDone:(id)sender;
@end
