#import <UIKit/UIKit.h>
#import "Reachability.h"
#import "CommonUtils.h"
#import "EGODatabase.h"
#import "UIImageView+WebCache.h"
#import "SVProgressHUD.h"
#import "KSToastView.h"
#import "Modal.h"
#import "JobCellHeyJobs.h"
#import "DetailViewController.h"
@interface SaveJobsheyJOb : UIViewController
{
    Reachability *internetReachable;
    NetworkStatus internetStatus;
    Modal *modal;
}
@property(nonatomic,retain) IBOutlet UICollectionView *myCollectionView;
@property(nonatomic,retain) NSMutableArray *FavouritesArray,*ApplyArray;
@property(nonatomic,retain) IBOutlet UILabel *lblnodatafound;
-(IBAction)OnBackClickDone:(id)sender;
@end
