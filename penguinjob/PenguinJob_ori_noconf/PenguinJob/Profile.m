#import "Profile.h"
@interface Profile ()
@end
@implementation Profile
@synthesize scrollView,myView,iconView;
@synthesize iconImageView;
@synthesize ProfileArray;
@synthesize lblname,lblemail,lblphone;
@synthesize lblcity,lbladdress;
- (void)viewDidLoad
{
    [super viewDidLoad];
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    ProfileArray = [[NSMutableArray alloc] init];
    [self getProfiasdleCustomerLao];
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
    self.iconView.layer.borderWidth = 5.0f;
    self.iconView.layer.borderColor = [UIColor colorWithHexString:@"#C6CACF"].CGColor;
    self.iconView.layer.cornerRadius = self.iconView.frame.size.height/2;
    self.iconView.layer.shadowColor = [UIColor colorWithHexString:@"#C6CACF"].CGColor;
    self.iconView.layer.shadowOffset = CGSizeMake(0,0);
    self.iconView.layer.shadowRadius = 1.0f;
    self.iconView.layer.shadowOpacity = 1;
    self.iconView.layer.masksToBounds = NO;
    self.iconView.layer.shadowPath = [UIBezierPath bezierPathWithRoundedRect:self.iconView.bounds cornerRadius:self.iconView.layer.cornerRadius].CGPath;
    self.iconImageView.layer.cornerRadius = self.iconImageView.frame.size.height/2;
    self.iconImageView.clipsToBounds = YES;
    [self.scrollView setContentSize:CGSizeMake(self.scrollView.frame.size.width, 460)];
}
-(void)getProfiasdleCustomerLao
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
        NSArray *LoginArray = [[NSUserDefaults standardUserDefaults] objectForKey:@"LoginArray"];
        NSString *userID = [[LoginArray valueForKey:@"user_id"] componentsJoinedByString:@","];
        NSString *str = [NSString stringWithFormat:@"%@user_profile_api.php?id=%@",[CommonUtils getBaseURL],userID];
        NSString *encodedString = [str stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLFragmentAllowedCharacterSet]];
        NSLog(@"Profile API URL : %@",encodedString);
        [self getProfiasdleCustomerLaoaseDataadgae:encodedString];
    }
}
-(void)getProfiasdleCustomerLaoaseDataadgae:(NSString *)requesturl
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager GET:requesturl parameters:nil progress:nil success:^(NSURLSessionTask *task, id responseObject)
     {
         NSLog(@"Profile Response Data : %@",responseObject);
         NSDictionary *errordict = (NSDictionary *)responseObject;
         NSArray *storeArr = [errordict[@"JOBS_APP"] mutableCopy];
         for (int i=0; i<storeArr.count; i++)
         {
             NSDictionary *storeDict = [storeArr objectAtIndex:i];
             [ProfileArray addObject:storeDict];
         }
         NSLog(@"ProfileArray Count : %lu",(unsigned long)ProfileArray.count);
         [[NSUserDefaults standardUserDefaults] setObject:ProfileArray forKey:@"ProfileArray"];
         NSString *str = [[ProfileArray valueForKey:@"user_image"] componentsJoinedByString:@","];
         NSString *encodedString = [str stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLFragmentAllowedCharacterSet]];
         NSURL *ImageUrl = [NSURL URLWithString:encodedString];
         UIImage *imagea = [UIImage imageNamed:@"menulogo"];
         [iconImageView sd_setImageWithURL:ImageUrl placeholderImage:imagea];
         lblname.text = [[ProfileArray valueForKey:@"name"] componentsJoinedByString:@","];
         lblemail.text = [[ProfileArray valueForKey:@"email"] componentsJoinedByString:@","];
         lblphone.text = [[ProfileArray valueForKey:@"phone"] componentsJoinedByString:@","];
         if ([[[ProfileArray valueForKey:@"city"] componentsJoinedByString:@","] isEqualToString:@""]) {
             lblcity.text = @"Please Update Your City";
         } else {
             lblcity.text = [[ProfileArray valueForKey:@"city"] componentsJoinedByString:@","];
         }
         if ([[[ProfileArray valueForKey:@"address"] componentsJoinedByString:@","] isEqualToString:@""]) {
             lbladdress.text = @"Please Update Your Address";
         } else {
             lbladdress.text = [[ProfileArray valueForKey:@"address"] componentsJoinedByString:@","];
         }
         [self stopSpinner];
     } failure:^(NSURLSessionTask *operation, NSError *error) {
         [KSToastView ks_showToast:[CommonUtils ServerErrorMsg] duration:5.0f];
     }];
}
-(IBAction)OnEditPrasdofileClicksd:(id)sender
{
    [[NSUserDefaults standardUserDefaults] setObject:ProfileArray forKey:@"ProfileArray"];
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        EditProfileasev *view = [[EditProfileasev alloc] initWithNibName:@"EditProfileasev_iPad" bundle:nil];
        [self.navigationController pushViewController:view animated:YES];
    } else {
        EditProfileasev *view = [[EditProfileasev alloc] initWithNibName:@"EditProfileasev" bundle:nil];
        [self.navigationController pushViewController:view animated:YES];
    }
}
-(IBAction)OnLogouasetClickase:(id)sender
{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Logout" message:@"Are You Sure You Want To Logout ?" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *ok = [UIAlertAction actionWithTitle:@"Logout" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action)
        {
            NSMutableArray *removeOldData = [NSMutableArray new];
            [[NSUserDefaults standardUserDefaults] setObject:removeOldData forKey:@"LoginArray"];
            [[NSUserDefaults standardUserDefaults] setObject:removeOldData forKey:@"ProfileArray"];
            [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"LOGIN"];
            if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
                LoginVC*view = [[LoginVC alloc] initWithNibName:@"Login_iPad" bundle:nil];
                [self.navigationController pushViewController:view animated:YES];
            } else {
                LoginVC*view = [[LoginVC alloc] initWithNibName:@"Login" bundle:nil];
                [self.navigationController pushViewController:view animated:YES];
            }
        }];
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:nil];
    [alert addAction:cancel];
    [alert addAction:ok];
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
-(IBAction)OnBackClickDone:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
@end
