#import <UIKit/UIKit.h>
#import "AFNetworking.h"
#import "CommonUtils.h"
#import "Reachability.h"
#import "UIImageView+WebCache.h"
#import "SVProgressHUD.h"
#import "KSToastView.h"
#import "UIXOverlayController1.h"
#import "DialogContentViewController1.h"
#import "CategoryCellHeyJObs.h"
#import "CategoryListheyJOb.h"
#import "SearcsaehJobsasd.h"
@interface CategoriesHeyJObs : UIViewController
{
    Reachability *internetReachable;
    NetworkStatus internetStatus;
    UIXOverlayController1 *overlay1;
}
@property(nonatomic,retain) IBOutlet UICollectionView *myCollectionView;
@property(nonatomic,retain) NSMutableArray *CategoryArray;
@property(nonatomic,retain) IBOutlet UILabel *lblnodatafound;
@property(nonatomic,retain) IBOutlet UIButton *btnsearch;
-(IBAction)OnSearchClickSpecialShey:(id)sender;
-(IBAction)OnBackClickDone:(id)sender;
@end
