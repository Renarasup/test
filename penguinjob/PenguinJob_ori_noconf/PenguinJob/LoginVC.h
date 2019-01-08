#import <UIKit/UIKit.h>
#import "HexColors.h"
#import "Register.h"
#import "CommonUtils.h"
#import "KSToastView.h"
#import "ForgotPasswordViewCtlr.h"
#import "Latest.h"
@interface LoginVC: UIViewController
{
    Reachability *internetReachable;
    NetworkStatus internetStatus;
}
@property(nonatomic,retain) IBOutlet UIScrollView *scrollView;
@property(nonatomic,retain) IBOutlet UITextField *txtemail,*txtpassword;
@property(nonatomic,retain) IBOutlet UIButton *btnlogin,*btnskip;
@property(nonatomic,retain) NSMutableArray *LoginArray;
-(IBAction)OnLoginClickHeyJob:(id)sender;
-(IBAction)OnHeySkipClickSe:(id)sender;
-(IBAction)OnHEYsaForgotPasswordClick:(id)sender;
-(IBAction)OnSignUpHyeClick:(id)sender;
@end
