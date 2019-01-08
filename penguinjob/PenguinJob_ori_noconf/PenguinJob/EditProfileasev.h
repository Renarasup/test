#import <UIKit/UIKit.h>
#import <Photos/Photos.h>
#import "AFNetworking.h"
#import "CommonUtils.h"
#import "Reachability.h"
#import "UIImageView+WebCache.h"
#import "SVProgressHUD.h"
#import "KSToastView.h"
#import "HexColors.h"
#import "LoginVC.h"
@interface EditProfileasev : UIViewController<UINavigationControllerDelegate,UIImagePickerControllerDelegate,UIDocumentInteractionControllerDelegate,UIDocumentMenuDelegate,UIDocumentPickerDelegate>
{
    Reachability *internetReachable;
    NetworkStatus internetStatus;
}
@property(nonatomic,retain) IBOutlet UIScrollView *scrollView;
@property(nonatomic,retain) IBOutlet UIView *myView,*iconView;
@property(nonatomic,retain) IBOutlet UIImageView *iconImageView;
@property(nonatomic,retain) NSMutableArray *EditProfileasevArray,*ResponseProfileArray;
@property(nonatomic,retain) IBOutlet UITextField *txtname,*txtemail,*txtphone;
@property(nonatomic,retain) IBOutlet UITextField *txtcity,*txtaddress,*txtpassword;
@property(nonatomic,retain) IBOutlet UIImageView *imgProfile;
@property(nonatomic,retain) IBOutlet UIButton *btnchoose1,*btnchoose2;
@property(nonatomic,retain) IBOutlet UILabel *lblfilename;
@property(nonatomic,retain) NSString *fileExtension;
@property(nonatomic,retain) NSData *fileData;
-(IBAction)OnSaveClickDataadse:(id)sender;
-(IBAction)OnLogouasetClickase:(id)sender;
-(IBAction)OnChoosese1Clickase:(id)sender;
-(IBAction)seOnChoose2Clickase:(id)sender;
-(IBAction)OnBackClickDone:(id)sender;
@end
