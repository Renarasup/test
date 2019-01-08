#import <UIKit/UIKit.h>
#import "AFNetworking.h"
#import "CommonUtils.h"
#import "Reachability.h"
#import "UIImageView+WebCache.h"
#import "SVProgressHUD.h"
#import "KSToastView.h"
#import "JobCellHeyJobs.h"
#import "DetailViewController.h"
@interface SearcsaehJobsasd : UIViewController
{
    Reachability *internetReachable;
    NetworkStatus internetStatus;
}
@property(nonatomic,retain) IBOutlet UILabel *lblheader;
@property(nonatomic,retain) IBOutlet UICollectionView *myCollectionView;
@property(nonatomic,retain) NSMutableArray *SearchListArray,*ApplyArray;
@property(nonatomic,retain) IBOutlet UILabel *lblnodatafound;
-(IBAction)OnBackClickDone:(id)sender;
@end
