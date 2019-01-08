#import <UIKit/UIKit.h>
#import "HexColors.h"
#import "CommonUtils.h"
#import "AFNetworking.h"
#import "Reachability.h"
#import "SVProgressHUD.h"
#import "UIImageView+WebCache.h"
#import "KSToastView.h"
#import "UIImageView+WebCache.h"
@interface AboutUsHeyJOb : UIViewController
{
    Reachability *internetReachable;
    NetworkStatus internetStatus;
}
@property(nonatomic,retain) IBOutlet UIScrollView *scrollView;
@property(nonatomic,retain) IBOutlet UIView *myView1,*myView2,*myView3;
@property(nonatomic,retain) NSMutableArray *AboutArray;
@property(nonatomic,retain) IBOutlet UIImageView *imgLogo;
@property(nonatomic,retain) IBOutlet UILabel *lblappname,*lblversion;
@property(nonatomic,retain) IBOutlet UILabel *lblcompany,*lblemail,*lblwebsite,*lblcontact;
@property(nonatomic,retain) IBOutlet UITextView *txtView;
-(IBAction)OnBackClickDone:(id)sender;
@end
