#import <UIKit/UIKit.h>
#import "Reachability.h"
#import "AFNetworking.h"
#import "SVProgressHUD.h"
#import "LoginVC.h"
@interface Register : UIViewController
{
    Reachability *internetReachable;
    NetworkStatus internetStatus;
}
@property(nonatomic,retain) IBOutlet UISegmentedControl *mySegmentedControl;
@property(nonatomic,retain) IBOutlet UIScrollView *scrollView;
@property(nonatomic,retain) IBOutlet UITextField *txtname,*txtpassword,*txtemail,*txtphone;
@property(nonatomic,retain) IBOutlet UIButton *btnregister;
@property(nonatomic,retain) NSMutableArray *RegisterArray;
@property(nonatomic,retain) NSString *strSegmentValue;
- (IBAction)OnSegmentClickHeysALl:(id)sender;
-(IBAction)OnRegisterClickAllsine:(id)sender;
-(IBAction)OnLoginClickHeyJob:(id)sender;
-(IBAction)OnBackClickDone:(id)sender;
@end
