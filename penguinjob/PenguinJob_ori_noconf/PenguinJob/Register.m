#import "Register.h"
@interface Register ()
@end
@implementation Register
@synthesize mySegmentedControl;
@synthesize scrollView;
@synthesize txtname,txtemail,txtpassword,txtphone;
@synthesize btnregister;
@synthesize RegisterArray;
@synthesize strSegmentValue;
- (void)viewDidLoad
{
    [super viewDidLoad];
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        CGRect frame= mySegmentedControl.frame;
        [mySegmentedControl setFrame:CGRectMake(frame.origin.x, frame.origin.y, frame.size.width, 30.0f)];
    } else {
        CGRect frame= mySegmentedControl.frame;
        [mySegmentedControl setFrame:CGRectMake(frame.origin.x, frame.origin.y, frame.size.width, 40.0f)];
    }
    UIToolbar* keyboardToolbar = [[UIToolbar alloc] init];
    [keyboardToolbar sizeToFit];
    UIBarButtonItem *flexBarButton = [[UIBarButtonItem alloc]
                                      initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace
                                      target:nil action:nil];
    UIBarButtonItem *doneBarButton = [[UIBarButtonItem alloc]
                                      initWithBarButtonSystemItem:UIBarButtonSystemItemDone
                                      target:self action:@selector(OnKeyboardDoneClickedFinsh:)];
    keyboardToolbar.items = @[flexBarButton,doneBarButton];
    txtphone.inputAccessoryView = keyboardToolbar;
}
-(void)getRegisterSefda
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
        if (strSegmentValue == nil) {
            strSegmentValue = @"1";
        }
        NSString *str = [NSString stringWithFormat:@"%@user_register_api.php?user_type=%@&name=%@&email=%@&password=%@&phone=%@",[CommonUtils getBaseURL],strSegmentValue,txtname.text,txtemail.text,txtpassword.text,txtphone.text];
        NSString *encodedString = [str stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLFragmentAllowedCharacterSet]];
        NSLog(@"Register API URL : %@",encodedString);
        [self getRegisterSefdaData:encodedString];
    }
}
-(void)getRegisterSefdaData:(NSString *)requesturl
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager GET:requesturl parameters:nil progress:nil success:^(NSURLSessionTask *task, id responseObject)
     {
         RegisterArray = [[NSMutableArray alloc] init];
         NSLog(@"Register Response Data : %@",responseObject);
         NSDictionary *errordict = (NSDictionary *)responseObject;
         NSArray *storeArr = [errordict[@"JOBS_APP"] mutableCopy];
         for (int i=0; i<storeArr.count; i++)
         {
             NSDictionary *storeDict = [storeArr objectAtIndex:i];
             [RegisterArray addObject:storeDict];
         }
         NSLog(@"RegisterArray Count : %lu",(unsigned long)RegisterArray.count);
         NSString *str = [[RegisterArray valueForKey:@"success"] componentsJoinedByString:@","];
         if ([str isEqualToString:@"0"]) {
             [KSToastView ks_showToast:[[RegisterArray valueForKey:@"msg"] componentsJoinedByString:@","] duration:5.0f];
         } else {
             [self.navigationController popViewControllerAnimated:YES];
             [KSToastView ks_showToast:[[RegisterArray valueForKey:@"msg"] componentsJoinedByString:@","] duration:5.0f];
         }
         [self stopSpinner];
     } failure:^(NSURLSessionTask *operation, NSError *error) {
         [KSToastView ks_showToast:[CommonUtils ServerErrorMsg] duration:5.0f];
     }];
}
-(void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    self.btnregister.layer.cornerRadius = self.btnregister.frame.size.height/2;
    self.btnregister.clipsToBounds = YES;
    self.btnregister.layer.borderWidth = 1.5f;
    self.btnregister.layer.borderColor = [UIColor colorWithHexString:@"#FFFFFF" alpha:0.7].CGColor;
}
-(IBAction)OnRegisterClickAllsine:(id)sender
{
    if ([txtname.text isEqualToString:@""]) {
        [KSToastView ks_showToast:@"Please enter name" duration:3.0f];
    } else if ([txtemail.text isEqualToString:@""]) {
        [KSToastView ks_showToast:@"Please enter email" duration:3.0f];
    } else if (![CommonUtils validateEmailWithString:txtemail.text]) {
        [KSToastView ks_showToast:@"Please enter valid email" duration:3.0f];
    } else if ([txtpassword.text isEqualToString:@""]) {
        [KSToastView ks_showToast:@"Please enter password" duration:3.0f];
    } else if ([txtpassword.text length] <6) {
        [KSToastView ks_showToast:@"Please enter minimum 6 character password" duration:3.0f];
    } else if ([txtphone.text isEqualToString:@""]) {
        [KSToastView ks_showToast:@"Please enter mobile number" duration:3.0f];
    } else if (![CommonUtils validMobileNumber:txtphone.text]) {
        [KSToastView ks_showToast:@"Please enter valid mobile number" duration:3.0f];
    } else {
        [self getRegisterSefda];
    }
}
-(IBAction)OnLoginClickHeyJob:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    if (textField == txtphone) {
        [self.scrollView setContentOffset:CGPointMake(0, self.scrollView.frame.size.height-460)];
    }
    return YES;
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [txtname resignFirstResponder];
    [txtemail resignFirstResponder];
    [txtpassword resignFirstResponder];
    [txtphone resignFirstResponder];
    return YES;
}
- (IBAction)OnKeyboardDoneClickedFinsh:(id)sender
{
    [self.scrollView setContentOffset:CGPointMake(0,0)];
    [txtphone resignFirstResponder];
}
- (IBAction)OnSegmentClickHeysALl:(id)sender
{
    UISegmentedControl *segmentedControl = (UISegmentedControl *) sender;
    NSInteger selectedSegment = segmentedControl.selectedSegmentIndex;
    if (selectedSegment == 0) {
        strSegmentValue = @"1";
    } else {
        strSegmentValue = @"2";
    }
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
