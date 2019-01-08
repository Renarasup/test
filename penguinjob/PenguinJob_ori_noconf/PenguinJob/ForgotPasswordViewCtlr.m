#import "ForgotPasswordViewCtlr.h"
@interface ForgotPasswordViewCtlr ()
@end
@implementation ForgotPasswordViewCtlr
@synthesize txtemail;
@synthesize btnsubmit;
@synthesize ForgotArray;
- (void)viewDidLoad
{
    [super viewDidLoad];
}
-(void)getForgotPassword
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
        NSString *str = [NSString stringWithFormat:@"%@user_forgot_pass_api.php?email=%@",[CommonUtils getBaseURL],txtemail.text];
        NSString *encodedString = [str stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLFragmentAllowedCharacterSet]];
        NSLog(@"Forgot Password API URL : %@",encodedString);
        [self getForgotData:encodedString];
    }
}
-(void)getForgotData:(NSString *)requesturl
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager GET:requesturl parameters:nil progress:nil success:^(NSURLSessionTask *task, id responseObject)
     {
         ForgotArray = [[NSMutableArray alloc] init];
         NSLog(@"Forgot Password Response Data : %@",responseObject);
         NSDictionary *errordict = (NSDictionary *)responseObject;
         NSArray *storeArr = [errordict[@"JOBS_APP"] mutableCopy];
         for (int i=0; i<storeArr.count; i++)
         {
             NSDictionary *storeDict = [storeArr objectAtIndex:i];
             [ForgotArray addObject:storeDict];
         }
         NSLog(@"ForgotArray Count : %lu",(unsigned long)ForgotArray.count);
         NSString *str = [[ForgotArray valueForKey:@"success"] componentsJoinedByString:@","];
         if ([str isEqualToString:@"0"]) {
             [KSToastView ks_showToast:[[ForgotArray valueForKey:@"msg"] componentsJoinedByString:@","] duration:5.0f];
         } else {
             [self.navigationController popViewControllerAnimated:YES];
             [KSToastView ks_showToast:[[ForgotArray valueForKey:@"msg"] componentsJoinedByString:@","] duration:5.0f];
         }
         [self stopSpinner];
     } failure:^(NSURLSessionTask *operation, NSError *error) {
         [KSToastView ks_showToast:[CommonUtils ServerErrorMsg] duration:5.0f];
     }];
}
-(void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    self.btnsubmit.layer.cornerRadius = self.btnsubmit.frame.size.height/2;
    self.btnsubmit.clipsToBounds = YES;
    self.btnsubmit.layer.borderWidth = 1.5f;
    self.btnsubmit.layer.borderColor = [UIColor colorWithHexString:@"#FFFFFF" alpha:0.7].CGColor;
}
-(IBAction)OnSubmitClick:(id)sender
{
    if ([txtemail.text isEqualToString:@""]) {
        [KSToastView ks_showToast:@"Please enter email" duration:3.0f];
    } else if (![CommonUtils validateEmailWithString:txtemail.text]) {
        [KSToastView ks_showToast:@"Please enter valid email" duration:3.0f];
    } else {
        [self getForgotPassword];
    }
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [txtemail resignFirstResponder];
    return YES;
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
-(IBAction)OnBackClickDone:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
@end
