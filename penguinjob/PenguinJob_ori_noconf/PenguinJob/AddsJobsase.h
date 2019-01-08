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
@interface AddsJobsase : UIViewController<UINavigationControllerDelegate,UIImagePickerControllerDelegate,IQActionSheetPickerViewDelegate>
{
    Reachability *internetReachable;
    NetworkStatus internetStatus;
}
@property(nonatomic,retain) IBOutlet UIScrollView *scrollView;
@property(nonatomic,retain) IBOutlet UIView *myView;
@property(nonatomic,retain) NSMutableArray *CategoryArray;
@property(nonatomic,retain) IBOutlet UILabel *lblcatname;
@property(nonatomic,retain) NSString *catID;
@property(nonatomic,retain) IBOutlet UITextField *txttitle,*txtdesignation;
@property(nonatomic,retain) IBOutlet UITextView *txtDesc;
@property(nonatomic,retain) IBOutlet UILabel *lblDesc;
@property(nonatomic,retain) IBOutlet UITextField *txtsalary,*txtcompanyname;
@property(nonatomic,retain) IBOutlet UITextField *txtwebsite,*txtphone;
@property(nonatomic,retain) IBOutlet UITextField *txtemail,*txtvacancy;
@property(nonatomic,retain) IBOutlet UITextView *txtAddress;
@property(nonatomic,retain) IBOutlet UILabel *lblAddress;
@property(nonatomic,retain) IBOutlet UITextField *txtqualification,*txtskill;
@property(nonatomic,retain) IBOutlet UIImageView *imgProfile;
@property(nonatomic,retain) IBOutlet UIButton *btnchoose;
@property(nonatomic,retain) IBOutlet UITextField *txtdate;
@property(nonatomic,retain) IBOutlet UIButton *btnsave;
-(IBAction)OnCategoryClickasef:(id)sender;
-(IBAction)OnChoosaseeClickase:(id)sender;
-(IBAction)seOnDsenateClicksase:(id)sender;
-(IBAction)OnSaveClickDataadse:(id)sender;
-(IBAction)OnBackClickDone:(id)sender;
@end
