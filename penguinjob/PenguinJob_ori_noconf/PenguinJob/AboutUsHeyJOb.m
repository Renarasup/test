#import "AboutUsHeyJOb.h"
@interface AboutUsHeyJOb ()
@end
@implementation AboutUsHeyJOb
@synthesize scrollView;
@synthesize myView1,myView2,myView3;
@synthesize AboutArray;
@synthesize imgLogo;
@synthesize lblappname,lblversion;
@synthesize lblcompany,lblemail,lblwebsite,lblcontact;
@synthesize txtView;
- (void)viewDidLoad
{
    [super viewDidLoad];
    AboutArray = [[NSMutableArray alloc] init];
    [self getAboutUsData];
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}
-(void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    self.myView1.layer.borderWidth = 0.5;
    self.myView1.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.myView1.layer.cornerRadius = 5.0f;
    self.myView1.layer.shadowColor = [UIColor lightGrayColor].CGColor;
    self.myView1.layer.shadowOffset = CGSizeMake(0,0);
    self.myView1.layer.shadowRadius = 1.0f;
    self.myView1.layer.shadowOpacity = 1;
    self.myView1.layer.masksToBounds = NO;
    self.myView1.layer.shadowPath = [UIBezierPath bezierPathWithRoundedRect:self.myView1.bounds cornerRadius:self.myView1.layer.cornerRadius].CGPath;
    self.myView2.layer.borderWidth = 0.5;
    self.myView2.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.myView2.layer.cornerRadius = 5.0f;
    self.myView2.layer.shadowColor = [UIColor lightGrayColor].CGColor;
    self.myView2.layer.shadowOffset = CGSizeMake(0,0);
    self.myView2.layer.shadowRadius = 1.0f;
    self.myView2.layer.shadowOpacity = 1;
    self.myView2.layer.masksToBounds = NO;
    self.myView2.layer.shadowPath = [UIBezierPath bezierPathWithRoundedRect:self.myView2.bounds cornerRadius:self.myView2.layer.cornerRadius].CGPath;
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        self.myView3.layer.borderWidth = 0.5;
        self.myView3.layer.borderColor = [UIColor lightGrayColor].CGColor;
        self.myView3.layer.cornerRadius = 5.0f;
        self.myView3.layer.shadowColor = [UIColor whiteColor].CGColor;
        self.myView3.layer.shadowOffset = CGSizeMake(0,0);
        self.myView3.layer.shadowRadius = 1.0f;
        self.myView3.layer.shadowOpacity = 1;
        self.myView3.layer.masksToBounds = NO;
        self.myView3.layer.shadowPath = [UIBezierPath bezierPathWithRoundedRect:self.myView3.bounds cornerRadius:self.myView3.layer.cornerRadius].CGPath;
    } else {
        self.myView3.layer.borderWidth = 0.5;
        self.myView3.layer.borderColor = [UIColor lightGrayColor].CGColor;
        self.myView3.layer.cornerRadius = 5.0f;
        self.myView3.layer.shadowColor = [UIColor lightGrayColor].CGColor;
        self.myView3.layer.shadowOffset = CGSizeMake(0,0);
        self.myView3.layer.shadowRadius = 1.0f;
        self.myView3.layer.shadowOpacity = 1;
        self.myView3.layer.masksToBounds = NO;
        self.myView3.layer.shadowPath = [UIBezierPath bezierPathWithRoundedRect:self.myView3.bounds cornerRadius:self.myView3.layer.cornerRadius].CGPath;
    }
}
-(void)getAboutUsData
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
        NSLog(@"About Us API URL : %@",encodedString);
        [self getAboutUsData:encodedString];
    }
}
-(void)getAboutUsData:(NSString *)requesturl
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager GET:requesturl parameters:nil progress:nil success:^(NSURLSessionTask *task, id responseObject)
     {
         NSLog(@"About Us Data Response Data : %@",responseObject);
         NSDictionary *errordict = (NSDictionary *)responseObject;
         NSArray *storeArr = [errordict[@"JOBS_APP"] mutableCopy];
         for (int i=0; i<storeArr.count; i++)
         {
             NSDictionary *storeDict = [storeArr objectAtIndex:i];
             [AboutArray addObject:storeDict];
         }
         NSString *str = [[AboutArray valueForKey:@"app_logo"] componentsJoinedByString:@","];
         NSString *path = [NSString stringWithFormat:@"%@/images/%@",[CommonUtils getBaseURL],str];
         NSString *encodedString = [path stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLFragmentAllowedCharacterSet]];
         NSURL *ImageUrl = [NSURL URLWithString:encodedString];
         UIImage *imagea = [UIImage imageNamed:@"aboutlogo"];
         [imgLogo sd_setImageWithURL:ImageUrl placeholderImage:imagea];
         lblappname.text = [[AboutArray valueForKey:@"app_name"] componentsJoinedByString:@","];
         lblversion.text = [[AboutArray valueForKey:@"app_version"] componentsJoinedByString:@","];
         lblcompany.text = [[AboutArray valueForKey:@"app_author"] componentsJoinedByString:@","];
         lblemail.text = [[AboutArray valueForKey:@"app_email"] componentsJoinedByString:@","];
         lblwebsite.text = [[AboutArray valueForKey:@"app_website"] componentsJoinedByString:@","];
         lblcontact.text = [[AboutArray valueForKey:@"app_contact"] componentsJoinedByString:@","];
         NSString *htmlingradients1 = [[AboutArray valueForKey:@"app_description"] componentsJoinedByString:@","];
         NSAttributedString *attributedString1 = [[NSAttributedString alloc] initWithData:[htmlingradients1 dataUsingEncoding:NSUnicodeStringEncoding] options:@{ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType } documentAttributes:nil error:nil];
         NSMutableAttributedString *newString1 = [[NSMutableAttributedString alloc] initWithAttributedString:attributedString1];
         NSRange range1 = (NSRange){0,[newString1 length]};
         [newString1 enumerateAttribute:NSFontAttributeName inRange:range1 options:NSAttributedStringEnumerationLongestEffectiveRangeNotRequired usingBlock:^(id value, NSRange range, BOOL *stop) {
             [newString1 addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"Helvetica neue" size:15.0f] range:range];
             [newString1 addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHexString:@"#9C9B99"] range:range];
         }];
         [txtView setScrollEnabled:NO];
         txtView.attributedText = newString1;
         [txtView setScrollEnabled:YES];
         [txtView setUserInteractionEnabled:NO];
         CGRect frame1 = txtView.frame;
         frame1.size.height = txtView.contentSize.height;
         txtView.frame = frame1;
         CGFloat hieght = txtView.frame.size.height;
         if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
             txtView.frame = CGRectMake(5,35,self.myView3.frame.size.width-10,hieght-30);
         } else {
             txtView.frame = CGRectMake(5,35,self.myView3.frame.size.width-10,hieght-30);
         }
         myView3.frame = CGRectMake(10, 390, self.view.frame.size.width-20, hieght+10);
         self.scrollView.contentSize = CGSizeMake(self.scrollView.frame.size.width,410+hieght);
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
