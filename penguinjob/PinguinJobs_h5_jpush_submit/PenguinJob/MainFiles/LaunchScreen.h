#import <UIKit/UIKit.h>
#import <UIkit/UIWebView.h>
#import <WebKit/WebKit.h>
#import <Firebase/Firebase.h>

@interface LaunchScreenPenguinViewController : UIViewController <UIWebViewDelegate,WKNavigationDelegate,WKUIDelegate>
@property (nonatomic, strong) NSString *url;
@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) UILabel *label;
@property (strong, nonatomic) UIActivityIndicatorView *spinner;
@property (strong, nonatomic) UIViewController *viewController;

//Firebase
@property (strong, nonatomic) FIRDatabaseReference *ref;
@property (assign, nonatomic) int appStatus;


-(void)startToListenNow;
-(void)checkConnection:(void (^)(BOOL response))completionHandlerBlock;
-(NSDate*)getOpenDate;
-(NSDate*)getCurrentDate;
@end
