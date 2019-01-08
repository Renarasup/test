#import <UIKit/UIKit.h>
#import "AFNetworking.h"
#import "CommonUtils.h"
#import "Reachability.h"
#import "UIImageView+WebCache.h"
#import "SVProgressHUD.h"
#import "KSToastView.h"
#import "HexColors.h"
#import "LoginVC.h"
#import "EditProfileasev.h"
@interface Profile : UIViewController
{
    Reachability *internetReachable;
    NetworkStatus internetStatus;
}
@property(nonatomic,retain) IBOutlet UIScrollView *scrollView;
@property(nonatomic,retain) IBOutlet UIView *myView,*iconView;
@property(nonatomic,retain) IBOutlet UIImageView *iconImageView;
@property(nonatomic,retain) NSMutableArray *ProfileArray;
@property(nonatomic,retain) IBOutlet UILabel *lblname,*lblemail,*lblphone;
@property(nonatomic,retain) IBOutlet UILabel *lblcity,*lbladdress;
-(IBAction)OnEditPrasdofileClicksd:(id)sender;
-(IBAction)OnLogouasetClickase:(id)sender;
-(IBAction)OnBackClickDone:(id)sender;
@end
