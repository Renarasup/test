#import <UIKit/UIKit.h>
#import <OneSignal/OneSignal.h>
#import "CommonUtils.h"
#import "LoginVC.h"
#import "Latest.h"
#import "DetailViewController.h"
#import "ExternaHeyNowlLinkdg.h"
@interface AppDelegate : UIResponder <UIApplicationDelegate,OSPermissionObserver,OSSubscriptionObserver,OSEmailSubscriptionObserver>
@property(strong,nonatomic) UIWindow *window;
@property (nonatomic, assign) BOOL isConnectedA;
@end
