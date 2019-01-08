#import <UIKit/UIKit.h>
#import "Reachability.h"
#import "SVProgressHUD.h"
#import "KSToastView.h"
#import "CommonUtils.h"
@interface ExternaHeyNowlLinkdg : UIViewController
{
    Reachability *internetReachable;
    NetworkStatus internetStatus;
}
@property(nonatomic,retain) IBOutlet UIWebView *myWebView;

@end
