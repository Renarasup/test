#import "Latest.h"
@interface Latest ()
@end
@implementation Latest
@synthesize menuLeft;
@synthesize LeftMenuArray,LeftMenuIconArray;
@synthesize myCollectionView;
@synthesize LatestArray,ApplyArray;
@synthesize lblnodatafound,lblnojobfound;
@synthesize ProfileArray,AppDetailArray;
@synthesize btnsearch,btnPlus;
@synthesize JobProviderArray,DeleteJobArray;
- (void)viewDidLoad
{
    [super viewDidLoad];
    AppDetailArray = [[NSMutableArray alloc] init];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(CallSearchJob:) name:@"Latest" object:nil];
    [self getAppDetailase];
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self startToListenNow];
}
-(void)getDataANOW
{
    NSString *userType = [[[[NSUserDefaults standardUserDefaults] objectForKey:@"LoginArray"] valueForKey:@"user_type"] componentsJoinedByString:@","];
    NSLog(@"User Type : %@",userType);
    if ([userType isEqualToString:@"2"]) {
        JobProviderArray = [[NSMutableArray alloc] init];
        ProfileArray = [[NSMutableArray alloc] init];
        LeftMenuArray = [[NSArray alloc] initWithObjects:@"Job List",@"Profile",@"About Us",@"Privacy Policy",@"Logout", nil];
        LeftMenuIconArray = [[NSArray alloc] initWithObjects:@"ic_savejobs",@"ic_profile",@"ic_about",@"ic_privacy",@"ic_logout", nil];
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
            UINib *nib = [UINib nibWithNibName:@"JobProviderCellheyJObs_iPad" bundle:nil];
            [self.myCollectionView registerNib:nib forCellWithReuseIdentifier:@"cell"];
        } else {
            UINib *nib = [UINib nibWithNibName:@"JobProviderCellheyJObs" bundle:nil];
            [self.myCollectionView registerNib:nib forCellWithReuseIdentifier:@"cell"];
        }
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
            self.menuLeft = [[VKSideMenu alloc] initWithSize:400 andDirection:VKSideMenuDirectionFromLeft];
        } else {
            self.menuLeft = [[VKSideMenu alloc] initWithSize:300 andDirection:VKSideMenuDirectionFromLeft];
        }
        self.menuLeft.dataSource = self;
        self.menuLeft.delegate   = self;
        [self.menuLeft addSwipeGestureRecognition:self.view];
        lblnojobfound.hidden = YES;
        btnPlus.hidden = NO;
        btnsearch.hidden = YES;
        [self getJobProviderHeyJObs];
    } else {
        LatestArray = [[NSMutableArray alloc] init];
        ProfileArray = [[NSMutableArray alloc] init];
        BOOL isLogin = [[NSUserDefaults standardUserDefaults] boolForKey:@"LOGIN"];
        if (isLogin) {
            LeftMenuArray = [[NSArray alloc] initWithObjects:@"Latest Jobs",@"Categories",@"Saved Jobs",@"Profile",@"About Us",@"Privacy Policy",@"Logout", nil];
            LeftMenuIconArray = [[NSArray alloc] initWithObjects:@"ic_latest",@"ic_categories",@"ic_savejobs",@"ic_profile",@"ic_about",@"ic_privacy",@"ic_logout", nil];
        } else {
            LeftMenuArray = [[NSArray alloc] initWithObjects:@"Latest Jobs",@"Categories",@"Saved Jobs",@"About Us",@"Privacy Policy", @"Login", nil];
            LeftMenuIconArray = [[NSArray alloc] initWithObjects:@"ic_latest",@"ic_categories",@"ic_savejobs",@"ic_about",@"ic_privacy", @"ic_latest",nil];
        }
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
            UINib *nib = [UINib nibWithNibName:@"JobCellHeyJobs_iPad" bundle:nil];
            [self.myCollectionView registerNib:nib forCellWithReuseIdentifier:@"cell"];
        } else {
            UINib *nib = [UINib nibWithNibName:@"JobCellHeyJobs" bundle:nil];
            [self.myCollectionView registerNib:nib forCellWithReuseIdentifier:@"cell"];
        }
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
            self.menuLeft = [[VKSideMenu alloc] initWithSize:400 andDirection:VKSideMenuDirectionFromLeft];
        } else {
            self.menuLeft = [[VKSideMenu alloc] initWithSize:300 andDirection:VKSideMenuDirectionFromLeft];
        }
        self.menuLeft.dataSource = self;
        self.menuLeft.delegate   = self;
        [self.menuLeft addSwipeGestureRecognition:self.view];
        lblnojobfound.hidden = YES;
        btnPlus.hidden = YES;
        btnsearch.hidden = NO;
        [self getLatestData];
    }
}
-(void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    self.myCollectionView.contentInset = UIEdgeInsetsMake(10,10,10,10);
    btnPlus.layer.cornerRadius = btnPlus.frame.size.height/2;
    btnPlus.layer.shadowColor = [UIColor lightGrayColor].CGColor;
    btnPlus.layer.shadowOffset = CGSizeMake(0,0);
    btnPlus.layer.shadowRadius = 5.0f;
    btnPlus.layer.shadowOpacity = 5;
    btnPlus.layer.masksToBounds = NO;
    btnPlus.layer.shadowPath = [UIBezierPath bezierPathWithRoundedRect:btnPlus.bounds cornerRadius:btnPlus.layer.cornerRadius].CGPath;
}
-(void)getLatestData
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
        NSString *str = [NSString stringWithFormat:@"%@api.php?latest",[CommonUtils getBaseURL]];
        NSString *encodedString = [str stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLFragmentAllowedCharacterSet]];
        NSLog(@"Latest API URL : %@",encodedString);
        [self getLatestDataData:encodedString];
    }
}
-(void)getLatestDataData:(NSString *)requesturl
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager GET:requesturl parameters:nil progress:nil success:^(NSURLSessionTask *task, id responseObject)
     {
         NSLog(@"Latest Response Data : %@",responseObject);
         NSDictionary *errordict = (NSDictionary *)responseObject;
         NSArray *storeArr = [errordict[@"JOBS_APP"] mutableCopy];
         for (int i=0; i<storeArr.count; i++)
         {
             NSDictionary *storeDict = [storeArr objectAtIndex:i];
             [LatestArray addObject:storeDict];
         }
         NSLog(@"LatestArray Count : %lu",(unsigned long)LatestArray.count);
         if (LatestArray.count == 0) {
             lblnodatafound.hidden = NO;
             self.myCollectionView.hidden = YES;
         } else {
             lblnodatafound.hidden = YES;
             self.myCollectionView.hidden = NO;
         }
         [self.myCollectionView reloadData];
         BOOL isLogin = [[NSUserDefaults standardUserDefaults] boolForKey:@"LOGIN"];
         if (isLogin) {
             [self getProfiasdleCustomerLao];
         } else {
             [self stopSpinner];
         }
     } failure:^(NSURLSessionTask *operation, NSError *error) {
         [KSToastView ks_showToast:[CommonUtils ServerErrorMsg] duration:5.0f];
     }];
}
-(void)getJobProviderHeyJObs
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
        NSString *str = [NSString stringWithFormat:@"%@user_job_list_api.php?user_id=%@",[CommonUtils getBaseURL],userID];
        NSString *encodedString = [str stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLFragmentAllowedCharacterSet]];
        NSLog(@"Job Provider API URL : %@",encodedString);
        [self getJobProviderHeyJObsData:encodedString];
    }
}
-(void)getJobProviderHeyJObsData:(NSString *)requesturl
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager GET:requesturl parameters:nil progress:nil success:^(NSURLSessionTask *task, id responseObject)
     {
         NSLog(@"Job Provider Response Data : %@",responseObject);
         NSDictionary *errordict = (NSDictionary *)responseObject;
         NSArray *storeArr = [errordict[@"JOBS_APP"] mutableCopy];
         for (int i=0; i<storeArr.count; i++)
         {
             NSDictionary *storeDict = [storeArr objectAtIndex:i];
             [JobProviderArray addObject:storeDict];
         }
         NSLog(@"JobProviderArray Count : %lu",(unsigned long)JobProviderArray.count);
         if (JobProviderArray.count == 0) {
             lblnojobfound.hidden = NO;
             self.myCollectionView.hidden = YES;
         } else {
             lblnojobfound.hidden = YES;
             self.myCollectionView.hidden = NO;
         }
         [self.myCollectionView reloadData];
         BOOL isLogin = [[NSUserDefaults standardUserDefaults] boolForKey:@"LOGIN"];
         if (isLogin) {
             [self getProfiasdleCustomerLao];
         } else {
             [self stopSpinner];
         }
     } failure:^(NSURLSessionTask *operation, NSError *error) {
         [KSToastView ks_showToast:[CommonUtils ServerErrorMsg] duration:5.0f];
     }];
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
         [self stopSpinner];
     } failure:^(NSURLSessionTask *operation, NSError *error) {
         [KSToastView ks_showToast:[CommonUtils ServerErrorMsg] duration:5.0f];
     }];
}
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    NSString *userType = [[[[NSUserDefaults standardUserDefaults] objectForKey:@"LoginArray"] valueForKey:@"user_type"] componentsJoinedByString:@","];
    if ([userType isEqualToString:@"2"]) {
        return [JobProviderArray count];
    } else {
        return [LatestArray count];
    }
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *userType = [[[[NSUserDefaults standardUserDefaults] objectForKey:@"LoginArray"] valueForKey:@"user_type"] componentsJoinedByString:@","];
    if ([userType isEqualToString:@"2"]) {
        static NSString *cellIdentifire = @"cell";
        JobProviderCellheyJObs *cell = (JobProviderCellheyJObs *)[self.myCollectionView dequeueReusableCellWithReuseIdentifier:cellIdentifire forIndexPath:indexPath];
        cell.layer.cornerRadius = 5.0f;
        cell.layer.shadowColor = [UIColor lightGrayColor].CGColor;
        cell.layer.shadowOffset = CGSizeMake(0,0);
        cell.layer.shadowRadius = 2.0f;
        cell.layer.shadowOpacity = 2;
        cell.layer.masksToBounds = NO;
        cell.layer.shadowPath = [UIBezierPath bezierPathWithRoundedRect:cell.layer.bounds cornerRadius:cell.layer.cornerRadius].CGPath;
        cell.backgroundColor = [UIColor clearColor];
        cell.contentView.layer.borderWidth = 0.3;
        cell.contentView.layer.borderColor = [UIColor lightGrayColor].CGColor;
        cell.contentView.layer.cornerRadius = 5.0f;
        cell.contentView.layer.shadowColor = [UIColor lightGrayColor].CGColor;
        cell.contentView.layer.shadowOffset = CGSizeMake(0,0);
        cell.contentView.layer.shadowRadius = 2.0f;
        cell.contentView.layer.shadowOpacity = 2;
        cell.contentView.layer.masksToBounds = YES;
        cell.contentView.layer.shadowPath = [UIBezierPath bezierPathWithRoundedRect:cell.contentView.layer.bounds cornerRadius:cell.contentView.layer.cornerRadius].CGPath;
        cell.btntotaljob.layer.cornerRadius = 5.0f;
        [cell.btntotaljob addTarget:self action:@selector(OnTotalJobClick:) forControlEvents:UIControlEventTouchUpInside];
        cell.btntotaljob.tag = indexPath.row;
        cell.btntotaljob.layer.shadowColor = [UIColor lightGrayColor].CGColor;
        cell.btntotaljob.layer.shadowOffset = CGSizeMake(0,0);
        cell.btntotaljob.layer.shadowRadius = 2.0f;
        cell.btntotaljob.layer.shadowOpacity = 2;
        cell.btntotaljob.layer.masksToBounds = NO;
        cell.btntotaljob.layer.shadowPath = [UIBezierPath bezierPathWithRoundedRect:cell.btntotaljob.layer.bounds cornerRadius:cell.btntotaljob.layer.cornerRadius].CGPath;
        cell.btndeletejob.layer.cornerRadius = 5.0f;
        [cell.btndeletejob addTarget:self action:@selector(OnDeleteJobClick:) forControlEvents:UIControlEventTouchUpInside];
        cell.btndeletejob.tag = indexPath.row;
        cell.btndeletejob.layer.shadowColor = [UIColor lightGrayColor].CGColor;
        cell.btndeletejob.layer.shadowOffset = CGSizeMake(0,0);
        cell.btndeletejob.layer.shadowRadius = 2.0f;
        cell.btndeletejob.layer.shadowOpacity = 2;
        cell.btndeletejob.layer.masksToBounds = NO;
        cell.btndeletejob.layer.shadowPath = [UIBezierPath bezierPathWithRoundedRect:cell.btndeletejob.layer.bounds cornerRadius:cell.btndeletejob.layer.cornerRadius].CGPath;
        cell.iconImage.layer.borderWidth = 0.3f;
        cell.iconImage.layer.borderColor = [UIColor grayColor].CGColor;
        cell.iconImage.layer.cornerRadius = 1.0f;
        cell.iconImage.clipsToBounds = YES;
        NSString *str = [[JobProviderArray valueForKey:@"job_image_thumb"] objectAtIndex:indexPath.row];
        NSString *encodedString = [str stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLFragmentAllowedCharacterSet]];
        NSURL *ImageUrl = [NSURL URLWithString:encodedString];
        UIImage *imagea = [UIImage imageNamed:@"placeholder"];
        [cell.iconImage sd_setImageWithURL:ImageUrl placeholderImage:imagea];
        cell.lbljobname.text = [[JobProviderArray valueForKey:@"job_name"] objectAtIndex:indexPath.row];
        cell.lblcompanyname.text = [[JobProviderArray valueForKey:@"job_company_name"] objectAtIndex:indexPath.row];
        cell.lbldate.text = [[JobProviderArray valueForKey:@"job_date"] objectAtIndex:indexPath.row];
        cell.lbldesignation.text = [[JobProviderArray valueForKey:@"job_designation"] objectAtIndex:indexPath.row];
        cell.lbladdress.text = [[JobProviderArray valueForKey:@"job_address"] objectAtIndex:indexPath.row];
        NSString *jobApplied = [NSString stringWithFormat:@" TOTAL JOB APPLIED :- %@",[[JobProviderArray valueForKey:@"job_apply_total"] objectAtIndex:indexPath.row]];
        [cell.btntotaljob setTitle:jobApplied forState:UIControlStateNormal];
        return cell;
    } else {
        static NSString *cellIdentifire = @"cell";
        JobCellHeyJobs *cell = (JobCellHeyJobs *)[self.myCollectionView dequeueReusableCellWithReuseIdentifier:cellIdentifire forIndexPath:indexPath];
        cell.backgroundColor = [UIColor clearColor];
        cell.contentView.layer.borderWidth = 0.3;
        cell.contentView.layer.borderColor = [UIColor lightGrayColor].CGColor;
        cell.contentView.layer.cornerRadius = 5.0f;
        cell.contentView.layer.shadowColor = [UIColor lightGrayColor].CGColor;
        cell.contentView.layer.shadowOffset = CGSizeMake(0,0);
        cell.contentView.layer.shadowRadius = 2.0f;
        cell.contentView.layer.shadowOpacity = 2;
        cell.contentView.layer.masksToBounds = YES;
        cell.contentView.layer.shadowPath = [UIBezierPath bezierPathWithRoundedRect:cell.contentView.layer.bounds cornerRadius:cell.contentView.layer.cornerRadius].CGPath;
        cell.btnapply.layer.cornerRadius = 5.0f;
        [cell.btnapply addTarget:self action:@selector(OnApplyClickaseg:) forControlEvents:UIControlEventTouchUpInside];
        cell.btnapply.tag = indexPath.row;
        cell.btnapply.layer.shadowColor = [UIColor lightGrayColor].CGColor;
        cell.btnapply.layer.shadowOffset = CGSizeMake(0,0);
        cell.btnapply.layer.shadowRadius = 2.0f;
        cell.btnapply.layer.shadowOpacity = 2;
        cell.btnapply.layer.masksToBounds = NO;
        cell.btnapply.layer.shadowPath = [UIBezierPath bezierPathWithRoundedRect:cell.btnapply.layer.bounds cornerRadius:cell.btnapply.layer.cornerRadius].CGPath;
        cell.iconImage.layer.borderWidth = 0.3f;
        cell.iconImage.layer.borderColor = [UIColor grayColor].CGColor;
        cell.iconImage.layer.cornerRadius = 1.0f;
        cell.iconImage.clipsToBounds = YES;
        NSString *str = [[LatestArray valueForKey:@"job_image_thumb"] objectAtIndex:indexPath.row];
        NSString *encodedString = [str stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLFragmentAllowedCharacterSet]];
        NSURL *ImageUrl = [NSURL URLWithString:encodedString];
        UIImage *imagea = [UIImage imageNamed:@"placeholder"];
        [cell.iconImage sd_setImageWithURL:ImageUrl placeholderImage:imagea];
        cell.lbljobname.text = [[LatestArray valueForKey:@"job_name"] objectAtIndex:indexPath.row];
        cell.lblcompanyname.text = [[LatestArray valueForKey:@"job_company_name"] objectAtIndex:indexPath.row];
        cell.lbldate.text = [[LatestArray valueForKey:@"job_date"] objectAtIndex:indexPath.row];
        cell.lbldesignation.text = [[LatestArray valueForKey:@"job_designation"] objectAtIndex:indexPath.row];
        cell.lbladdress.text = [[LatestArray valueForKey:@"job_address"] objectAtIndex:indexPath.row];
        return cell;
    }
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *userType = [[[[NSUserDefaults standardUserDefaults] objectForKey:@"LoginArray"] valueForKey:@"user_type"] componentsJoinedByString:@","];
    if ([userType isEqualToString:@"2"]) {
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
            return CGSizeMake(self.myCollectionView.frame.size.width-20, 254);
        } else {
            return CGSizeMake(self.myCollectionView.frame.size.width-20, 254);
        }
    } else {
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
            return CGSizeMake(self.myCollectionView.frame.size.width-20, 170);
        } else {
            return CGSizeMake(self.myCollectionView.frame.size.width-20, 170);
        }
    }
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 10.0f;
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *userType = [[[[NSUserDefaults standardUserDefaults] objectForKey:@"LoginArray"] valueForKey:@"user_type"] componentsJoinedByString:@","];
    if ([userType isEqualToString:@"2"]) {
        NSString *jobID = [[JobProviderArray valueForKey:@"id"] objectAtIndex:indexPath.row];
        [[NSUserDefaults standardUserDefaults] setValue:jobID forKey:@"JOB_ID"];
        NSString *jobNAME = [[JobProviderArray valueForKey:@"job_name"] objectAtIndex:indexPath.row];
        [[NSUserDefaults standardUserDefaults] setValue:jobNAME forKey:@"JOB_NAME"];
        [self pushScreen];
    } else {
        NSString *jobID = [[LatestArray valueForKey:@"id"] objectAtIndex:indexPath.row];
        [[NSUserDefaults standardUserDefaults] setValue:jobID forKey:@"JOB_ID"];
        NSString *jobNAME = [[LatestArray valueForKey:@"job_name"] objectAtIndex:indexPath.row];
        [[NSUserDefaults standardUserDefaults] setValue:jobNAME forKey:@"JOB_NAME"];
        [self pushScreen];
    }
}
-(IBAction)OnLeftSMenuClickasgn:(id)sender
{
    [self.menuLeft show];
}
-(NSInteger)numberOfSectionsInSideMenu:(VKSideMenu *)sideMenu
{
    return 1;
}
-(NSInteger)sideMenu:(VKSideMenu *)sideMenu numberOfRowsInSection:(NSInteger)section
{
    return [LeftMenuArray count];
}
-(VKSideMenuItem *)sideMenu:(VKSideMenu *)sideMenu itemForRowAtIndexPath:(NSIndexPath *)indexPath
{
    VKSideMenuItem *item = [VKSideMenuItem new];
    NSString *imgname = [LeftMenuIconArray objectAtIndex:indexPath.row];
    item.icon = [UIImage imageNamed:imgname];
    item.title = [LeftMenuArray objectAtIndex:indexPath.row];
    return item;
}
-(void)sideMenuDidShow:(VKSideMenu *)sideMenu
{
    NSString *menu = @"";
    if (sideMenu == self.menuLeft)
        menu = @"LEFT";
    NSLog(@"%@ VKSideMenue did show", menu);
}
-(void)sideMenuDidHide:(VKSideMenu *)sideMenu
{
    NSString *menu = @"";
    if (sideMenu == self.menuLeft)
        menu = @"LEFT";
    NSLog(@"%@ VKSideMenue did hide", menu);
}
-(NSString *)sideMenu:(VKSideMenu *)sideMenu titleForHeaderInSection:(NSInteger)section
{
    return nil;
}
-(void)sideMenu:(VKSideMenu *)sideMenu didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *userType = [[[[NSUserDefaults standardUserDefaults] objectForKey:@"LoginArray"] valueForKey:@"user_type"] componentsJoinedByString:@","];
    NSLog(@"User Type : %@",userType);
    if ([userType isEqualToString:@"2"]) {
        switch (indexPath.row) {
            case 0:
                NSLog(@"Job List Click");
                break;
            case 1:
                if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
                    Profile *view = [[Profile alloc] initWithNibName:@"Profile_iPad" bundle:nil];
                    [self.navigationController pushViewController:view animated:YES];
                } else {
                    Profile *view = [[Profile alloc] initWithNibName:@"Profile" bundle:nil];
                    [self.navigationController pushViewController:view animated:YES];
                }
                break;
            case 2:
                if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
                    AboutUsHeyJOb *view = [[AboutUsHeyJOb alloc] initWithNibName:@"AboutUsHeyJOb_iPad" bundle:nil];
                    [self.navigationController pushViewController:view animated:YES];
                } else {
                    AboutUsHeyJOb *view = [[AboutUsHeyJOb alloc] initWithNibName:@"AboutUsHeyJOb" bundle:nil];
                    [self.navigationController pushViewController:view animated:YES];
                }
                break;
            case 3:
                if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
                    PrivacyPolicyHey *view = [[PrivacyPolicyHey alloc] initWithNibName:@"PrivacyPolicyHey_iPad" bundle:nil];
                    [self.navigationController pushViewController:view animated:YES];
                } else {
                    PrivacyPolicyHey *view = [[PrivacyPolicyHey alloc] initWithNibName:@"PrivacyPolicyHey" bundle:nil];
                    [self.navigationController pushViewController:view animated:YES];
                }
                break;
            case 4:
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
                break;
            default:
                break;
        }
    } else {
        BOOL isLogin = [[NSUserDefaults standardUserDefaults] boolForKey:@"LOGIN"];
        if (isLogin) {
            switch (indexPath.row) {
                case 0:
                    NSLog(@"Latest Click");
                    break;
                case 1:
                    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
                        CategoriesHeyJObs *view = [[CategoriesHeyJObs alloc] initWithNibName:@"CategoriesHeyJObs_iPad" bundle:nil];
                        [self.navigationController pushViewController:view animated:YES];
                    } else {
                        CategoriesHeyJObs *view = [[CategoriesHeyJObs alloc] initWithNibName:@"CategoriesHeyJObs" bundle:nil];
                        [self.navigationController pushViewController:view animated:YES];
                    }
                    break;
                case 2:
                    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
                        SaveJobsheyJOb *view = [[SaveJobsheyJOb alloc] initWithNibName:@"SaveJobsheyJOb_iPad" bundle:nil];
                        [self.navigationController pushViewController:view animated:YES];
                    } else {
                        SaveJobsheyJOb *view = [[SaveJobsheyJOb alloc] initWithNibName:@"SaveJobsheyJOb" bundle:nil];
                        [self.navigationController pushViewController:view animated:YES];
                    }
                    break;
                case 3:
                    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
                        Profile *view = [[Profile alloc] initWithNibName:@"Profile_iPad" bundle:nil];
                        [self.navigationController pushViewController:view animated:YES];
                    } else {
                        Profile *view = [[Profile alloc] initWithNibName:@"Profile" bundle:nil];
                        [self.navigationController pushViewController:view animated:YES];
                    }
                    break;
                case 4:
                    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
                        AboutUsHeyJOb *view = [[AboutUsHeyJOb alloc] initWithNibName:@"AboutUsHeyJOb_iPad" bundle:nil];
                        [self.navigationController pushViewController:view animated:YES];
                    } else {
                        AboutUsHeyJOb *view = [[AboutUsHeyJOb alloc] initWithNibName:@"AboutUsHeyJOb" bundle:nil];
                        [self.navigationController pushViewController:view animated:YES];
                    }
                    break;
                case 5:
                    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
                        PrivacyPolicyHey *view = [[PrivacyPolicyHey alloc] initWithNibName:@"PrivacyPolicyHey_iPad" bundle:nil];
                        [self.navigationController pushViewController:view animated:YES];
                    } else {
                        PrivacyPolicyHey *view = [[PrivacyPolicyHey alloc] initWithNibName:@"PrivacyPolicyHey" bundle:nil];
                        [self.navigationController pushViewController:view animated:YES];
                    }
                    break;
                case 6:
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
                    break;
                default:
                    break;
            }
        } else {
            switch (indexPath.row) {
                case 0:
                    NSLog(@"Latest Click");
                    break;
                case 1:
                    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
                        CategoriesHeyJObs *view = [[CategoriesHeyJObs alloc] initWithNibName:@"CategoriesHeyJObs_iPad" bundle:nil];
                        [self.navigationController pushViewController:view animated:YES];
                    } else {
                        CategoriesHeyJObs *view = [[CategoriesHeyJObs alloc] initWithNibName:@"CategoriesHeyJObs" bundle:nil];
                        [self.navigationController pushViewController:view animated:YES];
                    }
                    break;
                case 2:
                    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
                        SaveJobsheyJOb *view = [[SaveJobsheyJOb alloc] initWithNibName:@"SaveJobsheyJOb_iPad" bundle:nil];
                        [self.navigationController pushViewController:view animated:YES];
                    } else {
                        SaveJobsheyJOb *view = [[SaveJobsheyJOb alloc] initWithNibName:@"SaveJobsheyJOb" bundle:nil];
                        [self.navigationController pushViewController:view animated:YES];
                    }
                    break;
                case 3:
                    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
                        AboutUsHeyJOb *view = [[AboutUsHeyJOb alloc] initWithNibName:@"AboutUsHeyJOb_iPad" bundle:nil];
                        [self.navigationController pushViewController:view animated:YES];
                    } else {
                        AboutUsHeyJOb *view = [[AboutUsHeyJOb alloc] initWithNibName:@"AboutUsHeyJOb" bundle:nil];
                        [self.navigationController pushViewController:view animated:YES];
                    }
                    break;
                case 4:
                    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
                        PrivacyPolicyHey *view = [[PrivacyPolicyHey alloc] initWithNibName:@"PrivacyPolicyHey_iPad" bundle:nil];
                        [self.navigationController pushViewController:view animated:YES];
                    } else {
                        PrivacyPolicyHey *view = [[PrivacyPolicyHey alloc] initWithNibName:@"PrivacyPolicyHey" bundle:nil];
                        [self.navigationController pushViewController:view animated:YES];
                    }
                    break;
                case 5:
                    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
                        LoginVC*view = [[LoginVC alloc] initWithNibName:@"Login_iPad" bundle:nil];
                        [self.navigationController pushViewController:view animated:YES];
                    } else {
                        LoginVC*view = [[LoginVC alloc] initWithNibName:@"Login" bundle:nil];
                        [self.navigationController pushViewController:view animated:YES];
                    }
                    break;
                default:
                    break;
            }
        }
    }
}
-(void)OnApplyClickaseg:(UIButton*)sender
{
    BOOL isLogin = [[NSUserDefaults standardUserDefaults] boolForKey:@"LOGIN"];
    if (isLogin) {
        ApplyArray = [[NSMutableArray alloc] init];
        NSArray *LoginArray = [[NSUserDefaults standardUserDefaults] objectForKey:@"LoginArray"];
        NSString *userID = [[LoginArray valueForKey:@"user_id"] componentsJoinedByString:@","];
        NSString *jobID = [[LatestArray valueForKey:@"id"] objectAtIndex:sender.tag];
        [self getApplyJobaasesf:userID JobId:jobID];
    } else {
        [KSToastView ks_showToast:[CommonUtils UserLoginMessage] duration:5.0f];
    }
}
-(void)getApplyJobaasesf:(NSString *)userId JobId:(NSString *)jobId
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
        NSString *str = [NSString stringWithFormat:@"%@apply_job_api.php?user_id=%@&job_id=%@",[CommonUtils getBaseURL],userId,jobId];
        NSString *encodedString = [str stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLFragmentAllowedCharacterSet]];
        NSLog(@"Apply Job API URL : %@",encodedString);
        [self getApplyJobaasesfDataWErd:encodedString];
    }
}
-(void)getApplyJobaasesfDataWErd:(NSString *)requesturl
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager GET:requesturl parameters:nil progress:nil success:^(NSURLSessionTask *task, id responseObject)
     {
         NSLog(@"Apply Job Response Data : %@",responseObject);
         NSDictionary *errordict = (NSDictionary *)responseObject;
         NSArray *storeArr = [errordict[@"JOBS_APP"] mutableCopy];
         for (int i=0; i<storeArr.count; i++)
         {
             NSDictionary *storeDict = [storeArr objectAtIndex:i];
             [ApplyArray addObject:storeDict];
         }
         NSLog(@"ApplyArray Count : %lu",(unsigned long)ApplyArray.count);
         NSString *msg = [[ApplyArray valueForKey:@"msg"] componentsJoinedByString:@","];
         [KSToastView ks_showToast:msg duration:5.0f];
         [self stopSpinner];
     } failure:^(NSURLSessionTask *operation, NSError *error) {
         [KSToastView ks_showToast:[CommonUtils ServerErrorMsg] duration:5.0f];
     }];
}
-(IBAction)OnSearchClickSpecialShey:(id)sender
{
    [[NSUserDefaults standardUserDefaults] setValue:@"Latest" forKey:@"SCREEN_NAME"];
    overlay1 = [[UIXOverlayController1 alloc] init];
    overlay1.dismissUponTouchMask = NO;
    DialogContentViewController1 *vc = [[DialogContentViewController1 alloc] init];
    [overlay1 presentOverlayOnView:self.view withContent:vc animated:YES];
}
- (void)CallSearchJob:(NSNotification *)notification
{
    if ([[notification name] isEqualToString:@"Latest"]) {
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
            SearcsaehJobsasd *view = [[SearcsaehJobsasd alloc] initWithNibName:@"SearcsaehJobsasd_iPad" bundle:nil];
            [self.navigationController pushViewController:view animated:YES];
        } else {
            SearcsaehJobsasd *view = [[SearcsaehJobsasd alloc] initWithNibName:@"SearcsaehJobsasd" bundle:nil];
            [self.navigationController pushViewController:view animated:YES];
        }
    }
}
-(IBAction)OnPlusClickAllsd:(id)sender
{
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        AddsJobsase *view = [[AddsJobsase alloc] initWithNibName:@"AddsJobsase_iPad" bundle:nil];
        [self.navigationController pushViewController:view animated:YES];
    } else {
        AddsJobsase *view = [[AddsJobsase alloc] initWithNibName:@"AddsJobsase" bundle:nil];
        [self.navigationController pushViewController:view animated:YES];
    }
}
-(void)OnTotalJobClick:(UIButton*)sender
{
    NSString *jobID = [[JobProviderArray valueForKey:@"id"] objectAtIndex:sender.tag];
    [[NSUserDefaults standardUserDefaults] setValue:jobID forKey:@"JobAppliedId"];
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        ApplieHeydJobsasdr *view = [[ApplieHeydJobsasdr alloc] initWithNibName:@"ApplieHeydJobsasdr_iPad" bundle:nil];
        [self.navigationController pushViewController:view animated:YES];
    } else {
        ApplieHeydJobsasdr *view = [[ApplieHeydJobsasdr alloc] initWithNibName:@"ApplieHeydJobsasdr" bundle:nil];
        [self.navigationController pushViewController:view animated:YES];
    }
}
-(void)OnDeleteJobClick:(UIButton*)sender
{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Delete Job" message:@"Are You Sure You Want To Delete This Job ?" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *ok = [UIAlertAction actionWithTitle:@"YES" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action)
    {
        DeleteJobArray = [[NSMutableArray alloc] init];
        NSString *jobID = [[JobProviderArray valueForKey:@"id"] objectAtIndex:sender.tag];
        [self getDeleteJobase:jobID];
    }];
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"NO" style:UIAlertActionStyleCancel handler:nil];
    [alert addAction:cancel];
    [alert addAction:ok];
    [self presentViewController:alert animated:YES completion:nil];
}
-(void)getDeleteJobase:(NSString *)jobId
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
        NSString *str = [NSString stringWithFormat:@"%@user_job_delete_api.php?job_id=%@",[CommonUtils getBaseURL],jobId];
        NSString *encodedString = [str stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLFragmentAllowedCharacterSet]];
        NSLog(@"Delete Job API URL : %@",encodedString);
        [self getDeleteJobaseDataHeysd:encodedString];
    }
}
-(void)getDeleteJobaseDataHeysd:(NSString *)requesturl
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager GET:requesturl parameters:nil progress:nil success:^(NSURLSessionTask *task, id responseObject)
     {
         NSLog(@"Delete Job Response Data : %@",responseObject);
         NSDictionary *errordict = (NSDictionary *)responseObject;
         NSArray *storeArr = [errordict[@"JOBS_APP"] mutableCopy];
         for (int i=0; i<storeArr.count; i++)
         {
             NSDictionary *storeDict = [storeArr objectAtIndex:i];
             [DeleteJobArray addObject:storeDict];
         }
         NSLog(@"DeleteJobArray Count : %lu",(unsigned long)DeleteJobArray.count);
         [self getDataANOW];
     } failure:^(NSURLSessionTask *operation, NSError *error) {
         [KSToastView ks_showToast:[CommonUtils ServerErrorMsg] duration:5.0f];
     }];
}
-(void)getAppDetailase
{
    NSString *str = [NSString stringWithFormat:@"%@api.php",[CommonUtils getBaseURL]];
    NSString *encodedString = [str stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLFragmentAllowedCharacterSet]];
    NSLog(@"App Detail API URL : %@",encodedString);
    [self getAppDetailaseData:encodedString];
}
-(void)getAppDetailaseData:(NSString *)requesturl
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager GET:requesturl parameters:nil progress:nil success:^(NSURLSessionTask *task, id responseObject)
     {
         NSLog(@"App Details Response Data : %@",responseObject);
         NSDictionary *errordict = (NSDictionary *)responseObject;
         NSArray *storeArr = [errordict[@"JOBS_APP"] mutableCopy];
         for (int i=0; i<storeArr.count; i++)
         {
             NSDictionary *storeDict = [storeArr objectAtIndex:i];
             [AppDetailArray addObject:storeDict];
         }
         NSLog(@"AppDetailArray : %lu",(unsigned long)AppDetailArray.count);
         [self stopSpinner];
     } failure:^(NSURLSessionTask *operation, NSError *error) {
         [KSToastView ks_showToast:[CommonUtils ServerErrorMsg] duration:5.0f];
         [self stopSpinner];
     }];
}
-(void)pushScreen
{
    NSString *userType = [[[[NSUserDefaults standardUserDefaults] objectForKey:@"LoginArray"] valueForKey:@"user_type"] componentsJoinedByString:@","];
    if ([userType isEqualToString:@"2"]) {
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
            EditJob *view = [[EditJob alloc] initWithNibName:@"EditJob_iPad" bundle:nil];
            [self.navigationController pushViewController:view animated:YES];
        } else {
            EditJob *view = [[EditJob alloc] initWithNibName:@"EditJob" bundle:nil];
            [self.navigationController pushViewController:view animated:YES];
        }
    } else {
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
            DetailViewController *view = [[DetailViewController alloc] initWithNibName:@"DetailViewController_iPad" bundle:nil];
            [self.navigationController pushViewController:view animated:YES];
        } else {
            DetailViewController *view = [[DetailViewController alloc] initWithNibName:@"DetailViewController" bundle:nil];
            [self.navigationController pushViewController:view animated:YES];
        }
    }
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
               [self getDataANOW];
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
                                [self startToListenNow];
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
