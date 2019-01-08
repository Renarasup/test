#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>
#import "AFNetworking.h"
#import "CommonUtils.h"
#import "Reachability.h"
#import "UIImageView+WebCache.h"
#import "SVProgressHUD.h"
#import "KSToastView.h"
#import "AppliedJsdraobCellsdg.h"
@interface ApplieHeydJobsasdr : UIViewController<MFMailComposeViewControllerDelegate,UINavigationControllerDelegate>
{
    Reachability *internetReachable;
    NetworkStatus internetStatus;
}
@property(nonatomic,retain) IBOutlet UICollectionView *myCollectionView;
@property(nonatomic,retain) NSMutableArray *AppliedArray;
@property(nonatomic,retain) IBOutlet UILabel *lblnodatafound;
@property(nonatomic,weak) IBOutlet UILabel *feedbackMsg;
-(IBAction)OnBackClickDone:(id)sender;
@end
