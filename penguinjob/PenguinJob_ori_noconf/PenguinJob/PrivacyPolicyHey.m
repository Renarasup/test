#import "PrivacyPolicyHey.h"
@interface PrivacyPolicyHey ()
@end
@implementation PrivacyPolicyHey
@synthesize myView,txtView;
@synthesize PrivacyArray;
- (void)viewDidLoad
{
    [super viewDidLoad];
    PrivacyArray = [[NSMutableArray alloc] init];
    [self getPrivacyPolicyDatasdhe];
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}
-(void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    self.myView.layer.borderWidth = 0.5;
    self.myView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.myView.layer.cornerRadius = 5.0f;
    self.myView.layer.shadowColor = [UIColor lightGrayColor].CGColor;
    self.myView.layer.shadowOffset = CGSizeMake(0,0);
    self.myView.layer.shadowRadius = 1.0f;
    self.myView.layer.shadowOpacity = 1;
    self.myView.layer.masksToBounds = NO;
    self.myView.layer.shadowPath = [UIBezierPath bezierPathWithRoundedRect:self.myView.bounds cornerRadius:self.myView.layer.cornerRadius].CGPath;
    self.txtView.layer.cornerRadius = 5.0f;
}
-(void)getPrivacyPolicyDatasdhe
{
    [self checkInternetConnection];
    if (internetStatus == 0)
    {
        [SVProgressHUD dismiss];
        [self Networkfailure];
    }
    else
    {
        [self startSpinner];
        NSString *str = [NSString stringWithFormat:@"%@api.php",[CommonUtils getBaseURL]];
        NSString *encodedString = [str stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLFragmentAllowedCharacterSet]];
        NSLog(@"Privacy Policy API URL : %@",encodedString);
        [self getPrivacyPolicyDatasdhe:encodedString];
    }
}
-(void)getPrivacyPolicyDatasdhe:(NSString *)requesturl
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager GET:requesturl parameters:nil progress:nil success:^(NSURLSessionTask *task, id responseObject)
     {
         NSLog(@"Privacy Policy Data Response Data : %@",responseObject);
         NSDictionary *errordict = (NSDictionary *)responseObject;
         NSArray *storeArr = [errordict[@"JOBS_APP"] mutableCopy];
         for (int i=0; i<storeArr.count; i++)
         {
             NSDictionary *storeDict = [storeArr objectAtIndex:i];
             [PrivacyArray addObject:storeDict];
         }
         NSString *htmlingradients1 = [[PrivacyArray valueForKey:@"app_privacy_policy"] componentsJoinedByString:@","];
         NSAttributedString *attributedString1 = [[NSAttributedString alloc] initWithData:[htmlingradients1 dataUsingEncoding:NSUnicodeStringEncoding] options:@{ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType } documentAttributes:nil error:nil];
         NSMutableAttributedString *newString1 = [[NSMutableAttributedString alloc] initWithAttributedString:attributedString1];
         NSRange range1 = (NSRange){0,[newString1 length]};
         [newString1 enumerateAttribute:NSFontAttributeName inRange:range1 options:NSAttributedStringEnumerationLongestEffectiveRangeNotRequired usingBlock:^(id value, NSRange range, BOOL *stop) {
             [newString1 addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"Helvetica neue" size:15.0f] range:range];
             [newString1 addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:range];
         }];
         txtView.attributedText = newString1;
         [self stopSpinner];
     } failure:^(NSURLSessionTask *operation, NSError *error) {
         [KSToastView ks_showToast:[CommonUtils ServerErrorMsg] duration:5.0f];
         [self stopSpinner];
     }];
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
