#import <UIKit/UIKit.h>
#import "HexColors.h"
#import "CommonUtils.h"
#import "AFNetworking.h"
#import "Reachability.h"
#import "SVProgressHUD.h"
#import "KSToastView.h"
@interface PrivacyPolicyHey : UIViewController
{
    Reachability *internetReachable;
    NetworkStatus internetStatus;
}
@property(nonatomic,retain) IBOutlet UIView *myView;
@property(nonatomic,retain) IBOutlet UITextView *txtView;
@property(nonatomic,retain) NSMutableArray *PrivacyArray;
-(IBAction)OnBackClickDone:(id)sender;
@end
