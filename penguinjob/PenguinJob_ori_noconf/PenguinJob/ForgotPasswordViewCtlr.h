#import <UIKit/UIKit.h>
#import "HexColors.h"
#import "CommonUtils.h"
#import "KSToastView.h"
#import "Reachability.h"
#import "AFNetworking.h"
#import "SVProgressHUD.h"
@interface ForgotPasswordViewCtlr : UIViewController
{
    Reachability *internetReachable;
    NetworkStatus internetStatus;
}
@property(nonatomic,retain) IBOutlet UITextField *txtemail;
@property(nonatomic,retain) IBOutlet UIButton *btnsubmit;
@property(nonatomic,retain) NSMutableArray *ForgotArray;
-(IBAction)OnSubmitClick:(id)sender;
-(IBAction)OnBackClickDone:(id)sender;
@end
