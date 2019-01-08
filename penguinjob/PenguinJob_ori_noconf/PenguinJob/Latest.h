#import <UIKit/UIKit.h>
#import "VKSideMenu.h"
#import "AFNetworking.h"
#import "CommonUtils.h"
#import "Reachability.h"
#import "UIImageView+WebCache.h"
#import "SVProgressHUD.h"
#import "UIXOverlayController1.h"
#import "DialogContentViewController1.h"
#import "KSToastView.h"
#import "CategoriesHeyJObs.h"
#import "SaveJobsheyJOb.h"
#import "Profile.h"
#import "AboutUsHeyJOb.h"
#import "PrivacyPolicyHey.h"
#import "LoginVC.h"
#import "JobCellHeyJobs.h"
#import "DetailViewController.h"
#import "SearcsaehJobsasd.h"
#import "AddsJobsase.h"
#import "JobProviderCellheyJObs.h"
#import "EditJob.h"
#import "ApplieHeydJobsasdr.h"
//#import <PersonalizedAdConsent/PersonalizedAdConsent.h>
@interface Latest : UIViewController<VKSideMenuDelegate,VKSideMenuDataSource>
{
    Reachability *internetReachable;
    NetworkStatus internetStatus;
    UIXOverlayController1 *overlay1;
}
@property(nonatomic,strong) IBOutlet VKSideMenu *menuLeft;
@property(nonatomic,retain) NSArray *LeftMenuArray,*LeftMenuIconArray;
@property(nonatomic,retain) IBOutlet UICollectionView *myCollectionView;
@property(nonatomic,retain) NSMutableArray *LatestArray,*ApplyArray,*AppDetailArray;
@property(nonatomic,retain) IBOutlet UILabel *lblnodatafound,*lblnojobfound;
@property(nonatomic,retain) NSMutableArray *ProfileArray;
@property(nonatomic,retain) IBOutlet UIButton *btnPlus;
@property(nonatomic,retain) IBOutlet UIButton *btnsearch;
@property(nonatomic,retain) NSMutableArray *JobProviderArray,*DeleteJobArray;
-(IBAction)OnLeftSMenuClickasgn:(id)sender;
-(IBAction)OnSearchClickSpecialShey:(id)sender;
-(IBAction)OnPlusClickAllsd:(id)sender;
@end
