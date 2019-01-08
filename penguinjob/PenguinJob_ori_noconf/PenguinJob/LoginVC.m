#import "LoginVC.h"
@interface LoginVC()
@end
@implementation LoginVC
@synthesize scrollView;
@synthesize txtemail,txtpassword;
@synthesize btnlogin,btnskip;
@synthesize LoginArray;
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self startToListenNow];
}
-(void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    self.btnlogin.layer.cornerRadius = self.btnlogin.frame.size.height/2;
    self.btnlogin.clipsToBounds = YES;
    self.btnlogin.layer.borderWidth = 1.5f;
    self.btnlogin.layer.borderColor = [UIColor colorWithHexString:@"#FFFFFF" alpha:0.7].CGColor;
    self.btnskip.layer.cornerRadius = self.btnskip.frame.size.height/2;
    self.btnskip.clipsToBounds = YES;
    self.btnskip.layer.borderWidth = 1.5f;
    self.btnskip.layer.borderColor = [UIColor colorWithHexString:@"#FFFFFF" alpha:0.7].CGColor;
}
-(IBAction)OnLoginClickHeyJob:(id)sender
{
    if ([txtemail.text isEqualToString:@""]) {
        [KSToastView ks_showToast:@"Please enter email" duration:3.0f];
    } else if (![CommonUtils validateEmailWithString:txtemail.text]) {
        [KSToastView ks_showToast:@"Please enter valid email" duration:3.0f];
    } else if ([txtpassword.text isEqualToString:@""]) {
        [KSToastView ks_showToast:@"Please enter password" duration:3.0f];
    } else {
        [self getLoginaSE];
    }
}
-(void)getLoginaSE
{
    [self checkInternetConnection];
    if (internetStatus == 0)
    {
        [self startSpinner];
        [self Networkfailure];
    }
    else
    {
        [self startSpinner];
        NSString *str = [NSString stringWithFormat:@"%@user_login_api.php?email=%@&password=%@",[CommonUtils getBaseURL],txtemail.text,txtpassword.text];
        NSString *encodedString = [str stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLFragmentAllowedCharacterSet]];
        NSLog(@"Login API URL : %@",encodedString);
        [self getLoginaSEData:encodedString];
    }
}
-(void)getLoginaSEData:(NSString *)requesturl
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager GET:requesturl parameters:nil progress:nil success:^(NSURLSessionTask *task, id responseObject)
     {
         LoginArray = [[NSMutableArray alloc] init];
         NSLog(@"Login Response Data : %@",responseObject);
         NSDictionary *errordict = (NSDictionary *)responseObject;
         NSArray *storeArr = [errordict[@"JOBS_APP"] mutableCopy];
         for (int i=0; i<storeArr.count; i++)
         {
             NSDictionary *storeDict = [storeArr objectAtIndex:i];
             [LoginArray addObject:storeDict];
         }
         NSLog(@"LoginArray Count : %lu",(unsigned long)LoginArray.count);
         NSString *str = [[LoginArray valueForKey:@"success"] componentsJoinedByString:@","];
         if ([str isEqualToString:@"0"]) {
             [KSToastView ks_showToast:[[LoginArray valueForKey:@"msg"] componentsJoinedByString:@","] duration:3.0f];
         } else {
             [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"LOGIN"];
             [[NSUserDefaults standardUserDefaults] setObject:LoginArray forKey:@"LoginArray"];
             if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
                 Latest *view = [[Latest alloc] initWithNibName:@"Latest_iPad" bundle:nil];
                 [self.navigationController pushViewController:view animated:YES];
             } else {
                 Latest *view = [[Latest alloc] initWithNibName:@"Latest" bundle:nil];
                 [self.navigationController pushViewController:view animated:YES];
             }
             [KSToastView ks_showToast:@"Login Successfully!" duration:3.0f];
         }
         [self stopSpinner];
     } failure:^(NSURLSessionTask *operation, NSError *error) {
         [KSToastView ks_showToast:[CommonUtils ServerErrorMsg] duration:5.0f];
     }];
}
-(IBAction)OnHeySkipClickSe:(id)sender
{
    [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"LOGIN"];
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        Latest *view = [[Latest alloc] initWithNibName:@"Latest_iPad" bundle:nil];
        [self.navigationController pushViewController:view animated:YES];
    } else {
        Latest *view = [[Latest alloc] initWithNibName:@"Latest" bundle:nil];
        [self.navigationController pushViewController:view animated:YES];
    }
}
-(IBAction)OnHEYsaForgotPasswordClick:(id)sender
{
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        ForgotPasswordViewCtlr *view = [[ForgotPasswordViewCtlr alloc] initWithNibName:@"ForgotPasswordViewCtlr_iPad" bundle:nil];
        [self.navigationController pushViewController:view animated:YES];
    } else {
        ForgotPasswordViewCtlr *view = [[ForgotPasswordViewCtlr alloc] initWithNibName:@"ForgotPasswordViewCtlr" bundle:nil];
        [self.navigationController pushViewController:view animated:YES];
    }
}
-(IBAction)OnSignUpHyeClick:(id)sender
{
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        Register *view = [[Register alloc] initWithNibName:@"Register_iPad" bundle:nil];
        [self.navigationController pushViewController:view animated:YES];
    } else {
        Register *view = [[Register alloc] initWithNibName:@"Register" bundle:nil];
        [self.navigationController pushViewController:view animated:YES];
    }
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [txtemail resignFirstResponder];
    [txtpassword resignFirstResponder];
    return YES;
}
-(void)startToListenNow
{
    AFNetworkReachabilityManager *manager = [AFNetworkReachabilityManager sharedManager];
    [manager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        switch (status) {
            case AFNetworkReachabilityStatusReachableViaWWAN:
            case AFNetworkReachabilityStatusReachableViaWiFi:
            {
                NSLog(@"Internet");
            }
                break;
            case AFNetworkReachabilityStatusNotReachable :
            {
                NSLog(@"No Intenret");
                                [self noInternetAlert];
            }
                break;
            case AFNetworkReachabilityStatusUnknown :
            {
                NSLog(@" Intenret uknown");
                                [self noInternetAlert];
            }
                break;
            default:
                break;
        }
    }];
    [manager startMonitoring];
}
- (void)noInternetAlert
{
    UIAlertController * alert = [UIAlertController
                                 alertControllerWithTitle:@"No Internet Connection"
                                 message:@"Please connect to internet to use PenguinJobs"
                                 preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction* yesButton = [UIAlertAction
                                actionWithTitle:@"OK"
                                style:UIAlertActionStyleDefault
                                handler:^(UIAlertAction * action) {
                                }];
    [alert addAction:yesButton];
    [self presentViewController:alert animated:YES completion:nil];
}
-(void)checkInternetConnection
{
    internetReachable = [Reachability reachabilityForInternetConnection];
    internetStatus = [internetReachable currentReachabilityStatus];
}
-(void)Networkfailure
{
    [KSToastView ks_showToast:[CommonUtils InternetConnectionErrorMsg] duration:5.0f];
    [SVProgressHUD dismiss];
    self.view.userInteractionEnabled = YES;
}
-(void)startSpinner
{
    [SVProgressHUD showWithStatus:@"Loading..."];
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
    [SVProgressHUD setDefaultAnimationType:SVProgressHUDAnimationTypeNative];
    self.view.userInteractionEnabled = NO;
}
-(void)stopSpinner
{
    [SVProgressHUD dismiss];
    self.view.userInteractionEnabled = YES;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
@end
