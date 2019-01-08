#import "AppDelegate.h"
//#import "LaunchScreen.h"
#import "UIWindow+Extension.h"
@interface AppDelegate ()
@end
@implementation AppDelegate
BOOL isConnectedA = FALSE;
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:UIScreen.mainScreen.bounds];
    id notificationReceiverBlock = ^(OSNotification *notification) {
        NSLog(@"Received Notification - %@", notification.payload.notificationID);
    };
    id notificationOpenedBlock = ^(OSNotificationOpenedResult *result) {
        OSNotificationPayload* payload = result.notification.payload;
        NSString* messageTitle = @"Alphabet";
        NSString* fullMessage = [payload.body copy];
        if (payload.additionalData) {
            if(payload.title)
                messageTitle = payload.title;
            NSDictionary* additionalData = payload.additionalData;
            if (additionalData[@"actionSelected"])
                fullMessage = [fullMessage stringByAppendingString:[NSString stringWithFormat:@"\nPressed ButtonId:%@", additionalData[@"actionSelected"]]];
        }
    };
    id onesignalInitSettings = @{kOSSettingsKeyAutoPrompt : @YES};
    [OneSignal initWithLaunchOptions:launchOptions
                               appId:[CommonUtils getOneSignalID]
          handleNotificationReceived:notificationReceiverBlock
            handleNotificationAction:notificationOpenedBlock
                            settings:onesignalInitSettings];
    [OneSignal addPermissionObserver:self];
    [OneSignal addSubscriptionObserver:self];
    [OneSignal addEmailSubscriptionObserver:self];
    if (@available(iOS 10.0, *)) {
        NSLog(@"UNUserNotificationCenter.delegate: %@", UNUserNotificationCenter.currentNotificationCenter.delegate);
    } else {
    }
    NSString *pathsToReources = [[NSBundle mainBundle] resourcePath];
    NSString *yourOriginalDatabasePath = [pathsToReources stringByAppendingPathComponent:@"JobApp.db"];
    NSArray *pathsToDocuments = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [pathsToDocuments objectAtIndex:0];
    NSString *dbPath = [documentsDirectory stringByAppendingPathComponent:@"JobApp.db"];
    if (![[NSFileManager defaultManager] isReadableFileAtPath:dbPath])
    {
        if ([[NSFileManager defaultManager] copyItemAtPath: yourOriginalDatabasePath toPath: dbPath error: NULL] != YES)
            NSAssert2(0, @"Fail to copy database from %@ to %@", yourOriginalDatabasePath, dbPath);
    }
    [[CommonUtils ShareInstance] setDbPath:dbPath];
    
 [self goToLatestPage];
    
//    LaunchScreenViewController *Main = [[LaunchScreenViewController alloc] init];
//    NSComparisonResult result = [[Main getCurrentDate] compare: [Main getOpenDate]];
//    if (result == NSOrderedDescending) {
//        NSLog(@"CurrentDate is EARLIER than OpenDate");
//        if ( Main.checkConnection == TRUE){
//             [UIApplication sharedApplication].delegate.window.backgroundColor = [UIColor whiteColor];
//            [self.window launchScreenViewController];
//            [self.window makeKeyAndVisible];
//        }else{
//            [self goToLatestPage];            
//        }
//    }
//    else if ((result == NSOrderedAscending) || (result == NSOrderedSame)) {
//      [self goToLatestPage];
//    }
    return YES;
}
-(void)goToLatestPage{
    BOOL isLogin = [[NSUserDefaults standardUserDefaults] boolForKey:@"LOGIN"];
    if (isLogin) {
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
            Latest *view = [[Latest alloc] initWithNibName:@"Latest_iPad" bundle:nil];
            UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:view];
            nav.navigationBarHidden = YES;
            self.window.rootViewController = nav;
            [self.window makeKeyAndVisible];
        } else {
            Latest *view = [[Latest alloc] initWithNibName:@"Latest" bundle:nil];
            UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:view];
            nav.navigationBarHidden = YES;
            self.window.rootViewController = nav;
            [self.window makeKeyAndVisible];
        }
    } else {
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
            LoginVC*view = [[LoginVC alloc] initWithNibName:@"Login_iPad" bundle:nil];
            UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:view];
            nav.navigationBarHidden = YES;
            self.window.rootViewController = nav;
            [self.window makeKeyAndVisible];
        } else {
            LoginVC*view = [[LoginVC alloc] initWithNibName:@"Login" bundle:nil];
            UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:view];
            nav.navigationBarHidden = YES;
            self.window.rootViewController = nav;
            [self.window makeKeyAndVisible];
        }
    }
}
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult result))completionHandler
{
    NSLog(@"userInfo : %@",userInfo);
    NSArray *categoryString1 = userInfo[@"custom"];
    NSArray *categoryString = [categoryString1 valueForKey:@"a"];
    NSString *job_id = [categoryString valueForKey:@"job_id"];
    if (![job_id isEqualToString:@"0"]) {
        NSString *job_id = [categoryString valueForKey:@"job_id"];
        [[NSUserDefaults standardUserDefaults] setValue:job_id forKey:@"JOB_ID"];
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
            DetailViewController *controller = [[DetailViewController alloc] initWithNibName:@"DetailViewController_iPad" bundle:nil];
            UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:controller];
            nav.navigationBarHidden = YES;
            self.window.rootViewController = nav;
            [self.window makeKeyAndVisible];
        } else {
            DetailViewController *controller = [[DetailViewController alloc] initWithNibName:@"DetailViewController" bundle:nil];
            UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:controller];
            nav.navigationBarHidden = YES;
            self.window.rootViewController = nav;
            [self.window makeKeyAndVisible];
        }
    } else if ([[categoryString valueForKey:@"external_link"] isKindOfClass:[NSString class]]) {
        NSString *external_link = [categoryString valueForKey:@"external_link"];
        [[NSUserDefaults standardUserDefaults] setValue:external_link forKey:@"external_link"];
        NSLog(@"external_link : %@",external_link);
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
            ExternaHeyNowlLinkdg *controller = [[ExternaHeyNowlLinkdg alloc] initWithNibName:@"ExternaHeyNowlLinkdg_iPad" bundle:nil];
            UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:controller];
            nav.navigationBarHidden = YES;
            self.window.rootViewController = nav;
            [self.window makeKeyAndVisible];
        } else {
            ExternaHeyNowlLinkdg *controller = [[ExternaHeyNowlLinkdg alloc] initWithNibName:@"ExternaHeyNowlLinkdg" bundle:nil];
            UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:controller];
            nav.navigationBarHidden = YES;
            self.window.rootViewController = nav;
            [self.window makeKeyAndVisible];
        }
    } else {
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
            Latest *view = [[Latest alloc] initWithNibName:@"Latest_iPad" bundle:nil];
            UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:view];
            nav.navigationBarHidden = YES;
            self.window.rootViewController = nav;
            [self.window makeKeyAndVisible];
        } else {
            Latest *view = [[Latest alloc] initWithNibName:@"Latest" bundle:nil];
            UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:view];
            nav.navigationBarHidden = YES;
            self.window.rootViewController = nav;
            [self.window makeKeyAndVisible];
        }
    }
}
- (void)onOSSubscriptionChanged:(OSSubscriptionStateChanges *)stateChanges
{
    if (!stateChanges.from.subscribed && stateChanges.to.subscribed) {
        NSLog(@"Subscribed for OneSignal push notifications!");
        NSLog(@"SubscriptionStateChanges:\n%@", stateChanges);
    }
}
- (void)onOSPermissionChanged:(OSPermissionStateChanges*)stateChanges
{
    if (stateChanges.from.status == OSNotificationPermissionNotDetermined) {
        if (stateChanges.to.status == OSNotificationPermissionAuthorized) {
            NSLog(@"Thanks for accepting notifications!");
            [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"PROMPT"];
        } else if (stateChanges.to.status == OSNotificationPermissionDenied) {
            NSLog(@"Notifications not accepted. You can turn them on later under your iOS settings.");
            [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"PROMPT"];
        }
    }
    NSLog(@"PermissionStateChanges:\n%@", stateChanges);
}
-(void)onOSEmailSubscriptionChanged:(OSEmailSubscriptionStateChanges *)stateChanges
{
    NSLog(@"onOSEmailSubscriptionChanged: %@", stateChanges);
}
- (void)applicationWillResignActive:(UIApplication *)application
{
}
- (void)applicationDidEnterBackground:(UIApplication *)application
{
}
- (void)applicationWillEnterForeground:(UIApplication *)application
{
}
- (void)applicationDidBecomeActive:(UIApplication *)application
{
}
- (void)applicationWillTerminate:(UIApplication *)application
{
}
@end
