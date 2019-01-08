#import "UIWindow+Extension.h"
#import "LoginVC.h"
//#import "LaunchScreen.h"
@implementation UIWindow (Extension)
//- (void)launchScreenViewController{
//    self.rootViewController = [[LaunchScreenViewController alloc] init];
//}
- (void)switchRootViewController
{
     self.rootViewController = [[LoginVC alloc]initWithNibName:@"Login" bundle:nil];
}
@end
