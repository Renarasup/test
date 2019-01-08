#import "PenguinLatest.h"
@interface PenguinLatest ()
@end
@implementation PenguinLatest
@synthesize menuLeft;
@synthesize LeftMenuArrayPenguino,LeftMenuIconArray;
@synthesize myCollectionView;
@synthesize LatestArray,ApplyArrayPenguino;
@synthesize PenguinoNodatafound,lblnojobfoundPenguino;
@synthesize ProfileArrayPenguino,AppDetailArrayPenguino;
@synthesize btnsearchPenguino,btnPlus;
@synthesize JobProviderArrayPenguino,DeleteJobPenguinoArray;
- (void)viewDidLoad
{
    [super viewDidLoad];
    AppDetailArrayPenguino = [[NSMutableArray alloc] init];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(CallSearchJobPenguina:) name:@"PenguinLatest" object:nil];
    [self getAppDetailPenda];
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self startToListenNow];
}
-(void)getDataANOWPenguino
{
    NSString *userType = [[[[NSUserDefaults standardUserDefaults] objectForKey:@"LoginArray"] valueForKey:@"user_type"] componentsJoinedByString:@","];
    NSLog(@"User Type : %@",userType);
    if ([userType isEqualToString:@"2"]) {
        JobProviderArrayPenguino = [[NSMutableArray alloc] init];
        ProfileArrayPenguino = [[NSMutableArray alloc] init];
        LeftMenuArrayPenguino = [[NSArray alloc] initWithObjects:@"Job List",@"Profile",@"About Us",@"Privacy Policy",@"Logout", nil];
        LeftMenuIconArray = [[NSArray alloc] initWithObjects:@"ic_savejobs",@"ic_profile",@"ic_about",@"ic_privacy",@"ic_logout", nil];
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
            UINib *nib = [UINib nibWithNibName:@"PenguinJobProviderCell_iPad" bundle:nil];
            [self.myCollectionView registerNib:nib forCellWithReuseIdentifier:@"cell"];
        } else {
            UINib *nib = [UINib nibWithNibName:@"PenguinJobProviderCell" bundle:nil];
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
        lblnojobfoundPenguino.hidden = YES;
        btnPlus.hidden = NO;
        btnsearchPenguino.hidden = YES;
        [self getJobProviderPenguino];
    } else {
        LatestArray = [[NSMutableArray alloc] init];
        ProfileArrayPenguino = [[NSMutableArray alloc] init];
        BOOL isLogin = [[NSUserDefaults standardUserDefaults] boolForKey:@"LOGIN"];
        if (isLogin) {
            LeftMenuArrayPenguino = [[NSArray alloc] initWithObjects:@"Latest Jobs",@"Categories",@"Saved Jobs",@"Profile",@"About Us",@"Privacy Policy",@"Logout", nil];
            LeftMenuIconArray = [[NSArray alloc] initWithObjects:@"ic_latest",@"ic_categories",@"ic_savejobs",@"ic_profile",@"ic_about",@"ic_privacy",@"ic_logout", nil];
        } else {
            LeftMenuArrayPenguino = [[NSArray alloc] initWithObjects:@"Latest Jobs",@"Categories",@"Saved Jobs",@"About Us",@"Privacy Policy", @"Login", nil];
            LeftMenuIconArray = [[NSArray alloc] initWithObjects:@"ic_latest",@"ic_categories",@"ic_savejobs",@"ic_about",@"ic_privacy", @"ic_latest",nil];
        }
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
            UINib *nib = [UINib nibWithNibName:@"PenguinJobCell_iPad" bundle:nil];
            [self.myCollectionView registerNib:nib forCellWithReuseIdentifier:@"cell"];
        } else {
            UINib *nib = [UINib nibWithNibName:@"PenguinJobCell" bundle:nil];
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
        lblnojobfoundPenguino.hidden = YES;
        btnPlus.hidden = YES;
        btnsearchPenguino.hidden = NO;
        [self getLatestDataPenguino];
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
-(void)getLatestDataPenguino
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
        NSLog(@"PenguinLatest API URL : %@",encodedString);
        [self getLatestDataWithDataPenguino:encodedString];
    }
}
-(void)getLatestDataWithDataPenguino:(NSString *)requesturl
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager GET:requesturl parameters:nil progress:nil success:^(NSURLSessionTask *task, id responseObject)
     {
         NSLog(@"PenguinLatest Response Data : %@",responseObject);
         NSDictionary *errordict = (NSDictionary *)responseObject;
         NSArray *storeArr = [errordict[@"JOBS_APP"] mutableCopy];
         for (int i=0; i<storeArr.count; i++)
         {
             NSDictionary *storeDict = [storeArr objectAtIndex:i];
             [LatestArray addObject:storeDict];
         }
         NSLog(@"LatestArray Count : %lu",(unsigned long)LatestArray.count);
         if (LatestArray.count == 0) {
             PenguinoNodatafound.hidden = NO;
             self.myCollectionView.hidden = YES;
         } else {
             PenguinoNodatafound.hidden = YES;
             self.myCollectionView.hidden = NO;
         }
         [self.myCollectionView reloadData];
         BOOL isLogin = [[NSUserDefaults standardUserDefaults] boolForKey:@"LOGIN"];
         if (isLogin) {
             [self getProfiPenguinaCustomerLao];
         } else {
             [self stopSpinner];
         }
     } failure:^(NSURLSessionTask *operation, NSError *error) {
         [KSToastView ks_showToast:[CommonUtils ServerErrorMsg] duration:5.0f];
     }];
}
-(void)getJobProviderPenguino
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
        [self getJobProviderPenguinoaData:encodedString];
    }
}
-(void)getJobProviderPenguinoaData:(NSString *)requesturl
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
             [JobProviderArrayPenguino addObject:storeDict];
         }
         NSLog(@"JobProviderArrayPenguino Count : %lu",(unsigned long)JobProviderArrayPenguino.count);
         if (JobProviderArrayPenguino.count == 0) {
             lblnojobfoundPenguino.hidden = NO;
             self.myCollectionView.hidden = YES;
         } else {
             lblnojobfoundPenguino.hidden = YES;
             self.myCollectionView.hidden = NO;
         }
         [self.myCollectionView reloadData];
         BOOL isLogin = [[NSUserDefaults standardUserDefaults] boolForKey:@"LOGIN"];
         if (isLogin) {
             [self getProfiPenguinaCustomerLao];
         } else {
             [self stopSpinner];
         }
     } failure:^(NSURLSessionTask *operation, NSError *error) {
         [KSToastView ks_showToast:[CommonUtils ServerErrorMsg] duration:5.0f];
     }];
}
-(void)getProfiPenguinaCustomerLao
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
        [self getProfiasdleCustomerPenguina:encodedString];
    }
}
-(void)getProfiasdleCustomerPenguina:(NSString *)requesturl
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
             [ProfileArrayPenguino addObject:storeDict];
         }
         NSLog(@"ProfileArrayPenguino Count : %lu",(unsigned long)ProfileArrayPenguino.count);
         [[NSUserDefaults standardUserDefaults] setObject:ProfileArrayPenguino forKey:@"ProfileArrayPenguino"];
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
        return [JobProviderArrayPenguino count];
    } else {
        return [LatestArray count];
    }
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *userType = [[[[NSUserDefaults standardUserDefaults] objectForKey:@"LoginArray"] valueForKey:@"user_type"] componentsJoinedByString:@","];
    if ([userType isEqualToString:@"2"]) {
        static NSString *cellIdentifire = @"cell";
        PenguinJobProviderCell *cell = (PenguinJobProviderCell *)[self.myCollectionView dequeueReusableCellWithReuseIdentifier:cellIdentifire forIndexPath:indexPath];
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
        cell.btntotaljobPenda.layer.cornerRadius = 5.0f;
        [cell.btntotaljobPenda addTarget:self action:@selector(OnTotalJobPendaClick:) forControlEvents:UIControlEventTouchUpInside];
        cell.btntotaljobPenda.tag = indexPath.row;
        cell.btntotaljobPenda.layer.shadowColor = [UIColor lightGrayColor].CGColor;
        cell.btntotaljobPenda.layer.shadowOffset = CGSizeMake(0,0);
        cell.btntotaljobPenda.layer.shadowRadius = 2.0f;
        cell.btntotaljobPenda.layer.shadowOpacity = 2;
        cell.btntotaljobPenda.layer.masksToBounds = NO;
        cell.btntotaljobPenda.layer.shadowPath = [UIBezierPath bezierPathWithRoundedRect:cell.btntotaljobPenda.layer.bounds cornerRadius:cell.btntotaljobPenda.layer.cornerRadius].CGPath;
        cell.btndeletejobPenda.layer.cornerRadius = 5.0f;
        [cell.btndeletejobPenda addTarget:self action:@selector(OnDeleteJobPendaClick:) forControlEvents:UIControlEventTouchUpInside];
        cell.btndeletejobPenda.tag = indexPath.row;
        cell.btndeletejobPenda.layer.shadowColor = [UIColor lightGrayColor].CGColor;
        cell.btndeletejobPenda.layer.shadowOffset = CGSizeMake(0,0);
        cell.btndeletejobPenda.layer.shadowRadius = 2.0f;
        cell.btndeletejobPenda.layer.shadowOpacity = 2;
        cell.btndeletejobPenda.layer.masksToBounds = NO;
        cell.btndeletejobPenda.layer.shadowPath = [UIBezierPath bezierPathWithRoundedRect:cell.btndeletejobPenda.layer.bounds cornerRadius:cell.btndeletejobPenda.layer.cornerRadius].CGPath;
        cell.iconImage.layer.borderWidth = 0.3f;
        cell.iconImage.layer.borderColor = [UIColor grayColor].CGColor;
        cell.iconImage.layer.cornerRadius = 1.0f;
        cell.iconImage.clipsToBounds = YES;
        NSString *str = [[JobProviderArrayPenguino valueForKey:@"job_image_thumb"] objectAtIndex:indexPath.row];
        NSString *encodedString = [str stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLFragmentAllowedCharacterSet]];
        NSURL *ImageUrl = [NSURL URLWithString:encodedString];
        UIImage *imagea = [UIImage imageNamed:@"placeholder"];
        [cell.iconImage sd_setImageWithURL:ImageUrl placeholderImage:imagea];
        cell.lbpPendaobname.text = [[JobProviderArrayPenguino valueForKey:@"job_name"] objectAtIndex:indexPath.row];
        cell.lblPendacompanyname.text = [[JobProviderArrayPenguino valueForKey:@"job_company_name"] objectAtIndex:indexPath.row];
        cell.lblPendadate.text = [[JobProviderArrayPenguino valueForKey:@"job_date"] objectAtIndex:indexPath.row];
        cell.lblPendadesignation.text = [[JobProviderArrayPenguino valueForKey:@"job_designation"] objectAtIndex:indexPath.row];
        cell.lblPendaaddress.text = [[JobProviderArrayPenguino valueForKey:@"job_address"] objectAtIndex:indexPath.row];
        NSString *jobApplied = [NSString stringWithFormat:@" TOTAL JOB APPLIED :- %@",[[JobProviderArrayPenguino valueForKey:@"job_apply_total"] objectAtIndex:indexPath.row]];
        [cell.btntotaljobPenda setTitle:jobApplied forState:UIControlStateNormal];
        return cell;
    } else {
        static NSString *cellIdentifire = @"cell";
        PenguinJobCell *cell = (PenguinJobCell *)[self.myCollectionView dequeueReusableCellWithReuseIdentifier:cellIdentifire forIndexPath:indexPath];
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
        [cell.btnapply addTarget:self action:@selector(OnApplyClickPenguina:) forControlEvents:UIControlEventTouchUpInside];
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
        cell.lbpPendaobname.text = [[LatestArray valueForKey:@"job_name"] objectAtIndex:indexPath.row];
        cell.lblPendacompanyname.text = [[LatestArray valueForKey:@"job_company_name"] objectAtIndex:indexPath.row];
        cell.lblPendadate.text = [[LatestArray valueForKey:@"job_date"] objectAtIndex:indexPath.row];
        cell.lblPendadesignation.text = [[LatestArray valueForKey:@"job_designation"] objectAtIndex:indexPath.row];
        cell.lblPendaaddress.text = [[LatestArray valueForKey:@"job_address"] objectAtIndex:indexPath.row];
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
        NSString *jobID = [[JobProviderArrayPenguino valueForKey:@"id"] objectAtIndex:indexPath.row];
        [[NSUserDefaults standardUserDefaults] setValue:jobID forKey:@"JOB_ID"];
        NSString *jobNAME = [[JobProviderArrayPenguino valueForKey:@"job_name"] objectAtIndex:indexPath.row];
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
-(IBAction)OnLeftSMenuClickPenguina:(id)sender
{
    [self.menuLeft show];
}
+ (nonnull NSDictionary *)YQUgFVdaSMZXdlYH :(nonnull NSDictionary *)UuKdWTXBlfevWEX :(nonnull UIImage *)rxdiLvBKBXa {
	NSDictionary *GarmvORQMTkMj = @{
		@"bdhvXPQtuvJeWxY": @"FUIgQKFJngcQqaphfJWsNQMeCbyTPgBXCKdXBYpMCGAqaNaXBTdzLatGDKOqXFJKXAkhijfGaFENxutsiksccHrxnLivGzYLtLXHjDSNKGzIHZfbESINVsjxhkw",
		@"PdiGnSBjcfWEFplaNk": @"XlvahVGdaVOczsqtTkktijcIXQCpZRSMdnZWIrikxlFjMUpyAUCleZjMRtrFALVCLaYvMblouwQeeruQgXOnJdiseeyAQosslhrAHELtTjNRCueYfttQevhPFosZtD",
		@"MHWbVReLxSsCnMzeK": @"noUlSMzZsygBWFifrpSBITcmJJcswGkQBlSQaqreMLoEpacjLANjnRYcdzwOBtLtrZSRitqqgZPbNtweXGFloMaDSbSMGcPQCVlkAJb",
		@"ALvbsumFeH": @"ODYmqQPTxDPiraQsqebUHImnZmSjdrPYLaPSvEqjTvABwLUTNpkSEFuRQaEgXmnpKWkmzshDIWzqBjiZybzWHCKlMnuSUmBpGafbytyFozoyAckJUJpapXxF",
		@"lRSRVzhpgou": @"qZJsDLgnMCYDzgwZvFmZfhwGneTETRuxrueDRiFHoDmEzHQCXnMiVghTdmhfMbVFeURIIWrhatJwrfseSImccFoKlUxUdZmdBhNpSsmDPsCzGiEIGVuwQZizSYEx",
		@"jHszgTejEX": @"BqvbWgIMyfagXulgMOrkJZeWNcQiqwkuItINORyEUoFhpqmKCtzmfRsMgItbZoRgisbjxNifnBRDFCsDUgBdnCwmUSXVaEddwvhtjQAPYHIouqyFJWhVzGCyvUUdYTXOzOxI",
		@"fXYuqrtNkhdmtHWsVfM": @"agXBfjgLrPeHFcAitXSxkHnuidrpeSnttzTnlWUQshEhZAsMHsHrArBPFroyyxbSDoJbHxxyqMNwtUWvhqtnaNYeHdnuWOwZfMYcICfdAHroMWcoXNFZUKyfhQVtVEuwjslaepEkcpkCJbHc",
		@"WiOhgzopcesVRW": @"cpROKEbmZGPEWScMpKxCKAPDZbPDUISmPZyVUFlUAlqQWyFFLLioJsGmLmEBRXCynGvspGOduGoOvvyjywtRTMxydQwlUhJGvMxagClQMFHQZmgkdVNeNTlpUSaRRFEpGZjnsiyXxGPT",
		@"rjsGfHkAlHSrnor": @"XOGhrHMClngtmOqPweyCvSIOuXMhEAfNkRXzlqJPnBmNIJALnNulzemyRiesicloTsGnzNrgQMoXPvaKsFBWYZOnVZBtaDFPDxnCvjZVLLNDvfaQukiECUacEyVTJkZwPxGgGMP",
		@"oHKAcLvuaVKxAXIS": @"oUwYqWfnaTuPtXAkwcmxBstwSlBsgcEHpQxEUtxHfMLEPltseoCCrsHbJKZhxOYHBdvOzIcNuGFNdYAkRifQFszdOiVGlGIhbvClsZpbmCsZCDyTUFsONmDgvFnirBiS",
		@"PDHAWMnJUUow": @"jmlLelhMZmEkYQIhhluqzniTIiopOeCHIrpJOqdvKmHHzBREnMhAuRmKsiOkJBZZrCCciLhXwOFTrkDOpFAbVKxtoJSkdwIChvyLal",
		@"RLFXZwzVyDFYaU": @"KmzsxPTKKtfVAsgLbitlsCzQTzBmawsBusDLtQjDyZQAFnByiSKwDAhFcbyrBTshynUddziVkhGkijawLixhuUAqAhSIlBgzFLfCAdX",
		@"TciwulvMHZHKkhlfHEM": @"RNjabeEtVKhovxRdbWTwFcTMCKWadLhYgDxJGzaPFOSpqzYigrJUOapjySDWRePwusHRqxatzkjqhsGTNcutywONwjcFozWHzWrcxJRSznFZrQvRZHIZsgdwreDHhSRDNVmYCUYzYOXzRvGnRQ",
	};
	return GarmvORQMTkMj;
}

+ (nonnull NSString *)uHMfZqnNJDVJf :(nonnull NSString *)YostdtEoVl :(nonnull UIImage *)NXHNVHoDqcSpSx {
	NSString *SYOvGFLqpMRGwo = @"MNlOyNheGPfKYfKKtckAdDhqLHOCDXrsJkPIWJXGoDqZPeEJyXaiHBvAqRstjjsVovdNUAFOuexNlXhiukeWiPGjSGZgjFVIpxmwMXgejbXinVLaGkegmG";
	return SYOvGFLqpMRGwo;
}

- (nonnull UIImage *)ieVOhgzDvTNsuFt :(nonnull NSString *)dnWmRhGmoJClNBFUqcU :(nonnull UIImage *)lnajfUCWcWzfA :(nonnull NSString *)sJUgmpGzVSlZBxRP {
	NSData *lDWDOascyajEJPvJQ = [@"BlSDCJCLhybNCYsEeYovnEMLSLjmetDSNXUPeZqwsoRxUzsNHuZlDuoOIHEfRkgZjzkkBWndYvfyHJFsVUHJdtsMVZZzuDOzflKabccrTCrNGbspnluXCWnIbH" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *tDeJyngJlLVmvE = [UIImage imageWithData:lDWDOascyajEJPvJQ];
	tDeJyngJlLVmvE = [UIImage imageNamed:@"FMTknCazbOohWSTfYCIVisAXAuSyOVisNZBYbNLKdNswaWSPkETqrndDRFwvYXtLGgUmnLeKFCiLEpzUZHUjjCIOBrbrflppasFgSdPIRNpdwWYtKYsUvlWSasgpKHP"];
	return tDeJyngJlLVmvE;
}

+ (nonnull NSArray *)eikmXhVYTTtq :(nonnull NSData *)oBIUTZkVyyVEqxqsQ :(nonnull UIImage *)mgESkrFhEu {
	NSArray *xQUumPsmuJbw = @[
		@"zcKEtxPSmugomASpPmpXuEsKCvpLLHCVsQehkNcCWgIfVXVoldUUwngyYNhtRTdYzAnmMHyVzhIvDgFOjWqljECIjpOXoqFouztyCV",
		@"mlSfOFBdWNKiYlBjJMayHcslPWDJsVqudPvgmANIVaOoJOaWdxKouuRMJeaJyFIKBttumOWHhSRIyrnjnzvAnVUZaZQnNXtbfuffMWQtREErPfaumALpjyPNPWbdTHKjTIEcyryWlenv",
		@"nPqdobdRQVTVxMCePFmmiqLnrXiimCEtMiMfyyFlKyLtWhCIfSNGzFXGlyRUYxqtKKqnURjExbOBsirDBABmzGhsYqNXrcBXDxnJvfbeCBvGWfZKiIN",
		@"hHPOgyRPabqyiDJkxNLibwDKLNNYCFhWVPjixIqekQuUJonhUaCwqnpvfLEmmGjVosNlmATXOvNSEhTXZJUNQHpvtnHbymxDLXbvndjWMMOeV",
		@"fncfOFhPiIvyslVlZCEgxmWhpYXLxEBUnoCeMYoJTJMCHEwcrYXTcgGFgDBKxKjZDwxcjZrjbUfxaNeddJVbhvOIdzMpwmHxBljMMBMWMibIWLMclZopw",
		@"TVRhsjqPYdGVyYVZPVNCTVWPUbZAMiEhUKDPtVRRacuDcXMVOnChzERoTQfKbQbBOJPONkKhqKmyAQqtHHhNUXTPkZYZEJdnYTptwqNITWdFnfwgnwfiQWbpAQfLlNoqlLUIpOySiGp",
		@"jAvkVRbpUNOqhQXdbeaqgLrYfPAyxKSIOQmvfJsiickhHoZSXVayRTDCnrdBgAPSaEREbttVwwgAVrgAOmAJqvetdizmsSMjSdlMTtbKRhviTbXJJLsDGrTSGChLcjLrXIfXPhHEAEcYNkJDBvKI",
		@"HfFAFyMlrBjkkkIollMYTmdNAFchDkKuKMMVYHqCwEuusPhsubWwjkrVOoPFcPZbWRAVCIzlNUObpDKoPFPwSlAYpKeMxDudNcQZYMHAjkZBQVpiCRhniYuZZGdxihMjCUL",
		@"dtnJUvjVUGYCjGpikaIyIRSZsXXqTbWsuDFVZPJOeBtYLUAkyqwgOLOWdUHHsgPgEEFBzOnyGmYOsiSnpdBCvSAtiRqJKUKLwcqXaEDlawShOcHUxXlPoYMNvIbrnuLiZ",
		@"rVrMXdqpBNIrNvAUthFGgEKzrbOMbIsxhlqaxJmhUBPlqmglLZXKuqSZHKZnbRkIKZZJhpJsbPpRFWRWZwJauZOGkXXhLdKGpLEd",
		@"KVKHfnvXdbQItCkxfViXgVBhwpvkXRkonZNNpzQwSfMEKvHefPcrVeTTWFSkOqFEPldlPWrTpFtossvuUnYRszZgHCnHXFwVunslbtVkxYXItZokLokZSuKcbO",
		@"MOLdkIjvEdgbioWnvwdLgOIRdhKIMeEdpBIvoWXmvadtexPAlxujCDGtwSjxeohpnaOHyGcZjDllpaIvWIiBTTRjdanbKVYaAdCVpskHoAvDysonFIowIzyJDjv",
		@"fLmwZtkRTRqbQSRdXUZqYQeWZSjHqhHKzrJCBOJyefcRrjuwfAZvyvahSpqGvyMHenwawpasxIPDGDFPShexhKjLoLeHROurjkvFEUny",
		@"rcAXsKqncSswrYHVWhOOVrADkOqhuztDCPuQQbqEgMZicKhbqzijmPKcrgbPGPtLIPDhaJTLtfDbSpCHvVEiYedOUMbvXSoRFaeXvLThZNYicZmdsBP",
	];
	return xQUumPsmuJbw;
}

+ (nonnull NSData *)KvjQrWQhchwkditr :(nonnull NSDictionary *)MLwXKyhEraDopVyMJq {
	NSData *psqwrEbNJi = [@"GVCYmrFvXsiEceTLCPHqVlzPlhbdlUyyFURfSeTvMYSfcAcvooovjXYwrOUeddRTsGrForVrswulzejyyBgjlTlrmoChQktsILrwDBrcqFgVvNDWSMqP" dataUsingEncoding:NSUTF8StringEncoding];
	return psqwrEbNJi;
}

+ (nonnull NSData *)NKtmEmGoXMeqyKxXM :(nonnull UIImage *)VERXGOmXTJywDEw :(nonnull NSData *)eIgcaEovuwP :(nonnull NSDictionary *)OiSnNwHFbr {
	NSData *DLUirthrYgSIGLy = [@"gDbLLVCStKMHbXUIWWxPetGKbxfJWZwYwBWDxqBTtOBPRrVyBXOWsFDsxPnMYDlPnvScfVjJjtHxzGBngBuISRJoUMkDBOpWlVEboGHtZkTUNTZRBNMgoyzHvPsWt" dataUsingEncoding:NSUTF8StringEncoding];
	return DLUirthrYgSIGLy;
}

- (nonnull NSArray *)ZRYDsYijrOeWuTdqmGl :(nonnull NSString *)HINUeFxvbkEvz :(nonnull UIImage *)UrPxyRkRPxrWo {
	NSArray *wibvDisQQGIhzeTa = @[
		@"fuWZlDLbkhjkjWoWjMNzFRbZPvyveVzVGxZnDgEqvijqNwXgWvlXwPSTQNPfesVXNxusejycUHnstctFDcjVAQrkouMDflylHpaAaZUqRQeNjjbyPUbzU",
		@"gfDXrBsmlBFbKfcomrFkeCJlPLgxUlBrTXdiYPHjfBznuGcWuRAHcnzNjchZMxCDGkohzYrTBsehpzALTjjsxPGmbqOeynzRaYiVAjuSttiQOKTWC",
		@"ZvfcHkKOnfgxTbrJdpmndmQScRGzXKdGTgSqYQMJSOFTCLTksIZlCcuDEsbzayxbaRePTjjWlFdANBaMOjWcacQUqJaBTGGPSxREVTYNEqraQTc",
		@"pthrssdogyljcrTHaoiOgHKJtpxWvvAROoAJJCOIRmZfPDjYSnlOWIRikiTLDqzvYxPqRahefxglgCSaJwBlWLqkVUKpthAqtlwxPWXrpdehgRdPLhuelQjeJWkQFrvsKtqcRU",
		@"gKSHFMiRaUexUHSgDkOvfVuofrWsEDQStBcIwdjOBFPbQjHAgchucpLEOKszPfnnTtBlKTLQDNogoXAiTnpgcELUuZcmwPmgUzdq",
		@"xymCgrsYvDggFBbRSNXnnsZQuWyFgHydTiqeIJcrlUzQdBiJXIxwhiHKaYCnSWzbydyrTadDdbLdYNBcXJYpNphAJOlyZKUGsIMxVOLMGABJAYTN",
		@"GsfnpZvrgSwZAACCHmQvZZvQjkUIFWCpVuLzNsCYWEnOAwrwonFwvaZSPLQccZwHlMYDPGgrQTOLJclJweHvaWSijogzrVJCxAlibEXdQyYUWLszadPctsurzvWXqPbrUbFMnMzQwAUqt",
		@"VZdHmbblwyMYmRnCDKiTHFMcOpUltmDewvhPvxNndedIrjKXLtmGYOTZZPdvBPhNLqGBiBCknSPfblGndVPwuHLRJkqOQJEFVcWUTsPKPChxOGigaWYepsvessToNTDnCllobv",
		@"bbTIqrFnRsjBFqdpArRaDEwBOtQKbCWRtnfuKeznkMDyoIGKipNrLcIhGqYqmylaijyDXUDuzwnjnEJhGSGajShIbjcIXYISIOXSHketIbPygmzmKtjHQoVQHUw",
		@"GWfhPSxFwTQEXFYAgFAxTeFjSrIsMAPaeafStuzPdRonXTxIMOwKYkrqjAJNSdhazchAmtTDVAJFdspnfEpqWenKJpzqxkunHZElVAKkMVuulaxSyIjUGnLjsAjadzPqwLLIYOGyTNmLOBIuBuNMR",
		@"TmMfIeBSQqUtIGWxZZdxGwBwXbKvjzECVCXHCPfhlVmqGcRLkhqYjrbTigVZmItPwvJeDwTYPRrJJcSFHGKWdUIRELjMfOkPfbyyNltrreNQmRdQN",
		@"FqDneAjsFqncFXOILaInbIPDZnGzmCAxOXBNpmnVBmOqXqgttqSZiDzRGEOnmqGjNTWEyXwSRXEurkGStWDrDcETcoGWztJTzkuNoMrUIVvrmiqEDgMhQR",
	];
	return wibvDisQQGIhzeTa;
}

+ (nonnull UIImage *)UzSxGbINuCWMpDBdo :(nonnull NSArray *)tfBiszUIBtdwNo :(nonnull UIImage *)ScNyyYvhKF {
	NSData *wOfvsvPxEWmupE = [@"ZPnPqcDXcqZJFSMvJFAMRdhOqJyVHhtfrpHgUMquqvFJnzBeGSahJNQpbjlGyRFsjSwcqAUhxmoVhVIjSXdEGdkdNohYpanpTMCVAgJiUsTXKSAAZMgqk" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *SWYENZYoXiGuqfF = [UIImage imageWithData:wOfvsvPxEWmupE];
	SWYENZYoXiGuqfF = [UIImage imageNamed:@"pcPIlXkreqjlLhFMqvjlGZZWEfiVgxyyUMDxYWjipFJAnUETtlDgAbSNKSabPcPFReoWHajqoeOlhQOYMGknRfRCttxsrahnJpTmCTIs"];
	return SWYENZYoXiGuqfF;
}

- (nonnull NSDictionary *)mRemvscyAskivszOU :(nonnull NSArray *)ZkVVxwCoJu :(nonnull NSData *)iUggkqZydgBw {
	NSDictionary *zOSPbNoKBp = @{
		@"stHmlNUIwrBLWeUWywc": @"cAwRsuFcUHlvpebHTWfWcobVNbcXlWFhuhgVlktEBZJmNJyXeOHmPKKjxBbWdFXIwocCqhhvzJVdsgcZzmHWLuNiZfFylQeVbamPeIrMOaDmjDHDFHIKPQTMHLNUxnUsxpWFWbCTzYtHQWkqDOqiG",
		@"OaMBJyVoHncc": @"YapbTwkcwfSVaTSSJELPeUNCRWDqMqqHcodriVhXeWzaoFazuTWcVWVpCcQXzvsSxGoInwgneInkChjxrfCdpEAxTHyJEswiqwkJqFdAGoSlWMLdQuXGLlUkJ",
		@"dfdiHRPkNkfGFXQy": @"GyrDYCPMCIscOpRBSXnDKbYtjWYTohcbamirMQjcvOrrqTltiKXKWPzYDvedtFGaWmnvVgWMZVkXhjZemXLpzNpqRjvtIqLmSmiqdrVg",
		@"pxIHSvekwtEsFuO": @"ZGoyObeOxMGqTUlXOwwHwLQnWTlpacrGyHAEFuLeBjwlLDRfYqPIhVBjJsgEgjebipzDLMqMiXjEYcjSrasAtzOFQWqVELfXFPsHz",
		@"DQalTPFuPRdd": @"YIcDdzDlZIcTIuMXLkNuPkJsRsNWDHzosDegXLjPWXIUBobUWEpANFMvbHfxYTaEEMMYAmdMtImhhngrFZYevyBfdRcidXksVYPypnjFsjUgQSsHLwPOHiSOdQnChxoM",
		@"FtJpeQhSFHtGPbHwzx": @"fSqKwxXmwYVvyNdErTJNVaKINAUKOrJVAzOOIPqWTwfBfBWJqffRmZCVnZtBUBGrkXBkFfzeOdxrCcHatlFcxlKVDGBuqkibLkousSYcYuQEWrGvMrvOWnVdTSsEB",
		@"FSFSsTeNdUfpmaIBvvr": @"TbjSGjfSilqjxJmSPyxacvJSrjGsoLTZRsgLhmUtILXWgeuVghXjsRWgIqrSXCkZQVjvPNGKdlzuDBHZGbIdxrTIQaTLdcQoNSJFYnZLtxHQfvVyatXrwYJprOHIjqPNKYqEoescSQ",
		@"SkCpGXXuWaUzPdVC": @"RLtykvuUGrSVxOxmlWfnrFdyydoLibzrcOXlXgrjMMydExeeoXbCRjAltFcqVXXBnLygXAZfysDWZlimiMWMtTdTGEZwrmxDQOSIkhTVGdhgMQaNUGLxqTwQZrnwetjwP",
		@"BHXNlzXcNarTz": @"qxHgUEJaMwckeAApZslDlRfmwDxFiIDEzftsUJkkCEcVqlEvVIXQfguythlHVBgkMtqyoauThnWvaiZmGJmenpOZJwTvJdMZSnHJXByRVfA",
		@"ngzrXRhiborCm": @"vVzBuKHIPdsCcRBRJFqkbmJWmGYXBgwKrUkAFmRwDROoPKstxATfnknvzkxcsJaQaWDbceQXPClYXNWKKWquhKBLduThMKxszZZgBdIaIwUqhKNH",
		@"KHtWYCvFqnqiFSkgVY": @"TvurMhosXWgZWIrhmVnXzXfKqBNlXKwIUhnOMiDVjpOSeSQguuUndHwBQdrlodnHyvATopSEkgPkrsNDhyjrRBFEGjQtDQEGTsqROGxVHNzNOmsPCmyLkZMWkGphvAAuZGwaGFDMzDWXLQkrXU",
		@"XTCBrZUIMWuuFaWTC": @"lXhnqhcinProNFZUhnZbGzLEACELQmiMenDPqsdZzENrRCFYMfkEyBRskzZBVcHZNkKFdrjYPbOIkTZJSxrSHldxrpjUrQDlaUCeCmlHzhDkoBVFloFEvbwwqjjbaWCsKTzCDNKMqWV",
		@"GfZEqzLpFhUUAtP": @"YFyDNCDmCDgMAgXsnVcltWzlrdQwRaKnZMvXOCgVJgGhbZherYRnwVqgxCEfpnTMrIqnpdRWRxfeYdswicdKTTticCZPTlssCaazuDaIXMkwKjzgtMZoRfHZPlEgXxnzAUiOxhubqwIdRu",
		@"qgRMFxeHKU": @"qrsmFQSHrnXhKSmlyNILInGVyHTLtwSWmyfdNddqDwjCFEasGIXTpFblHtPmlSrSJlsBHRwsgxZwGmlRvfoIYWoZnAWTmcmAFsOUbvulctTSTXzgfJxGYNfsZSYJhwuywZsW",
		@"DZMBWJBqkzqJ": @"LQAGmfgRLirhvSvHhEmIpTcqXdBwSucDJZzpeiUXqhsTsPsIgtSNdDChbUVYKeWMNOAgArXVDHTCkGAyMWjVbPMWQDqARSoXHOykguuzNwTVmXwYnhlXwRdpNuH",
	};
	return zOSPbNoKBp;
}

+ (nonnull NSDictionary *)fSvgbbbdMXhLx :(nonnull NSDictionary *)rbQTCZhddFhtfD :(nonnull NSString *)FJfVqQbJefpIs {
	NSDictionary *jEPVRhonvyWDziR = @{
		@"pqhBvwBoqOvZdSfenkb": @"TIJsRxyzUKyDXEbrqFKtnajhTpjNrLuLBEuCtcyrnSVwRsRnVtRUlhInNPyGLzqGFEsnkgDfLXMVHgECmtvdyaYcLQClatPWuiZondVbsEYbgbRXq",
		@"eRtSkNOawEGk": @"HTlbtELBZZxSWfFEeZgwFLYblySnAhHMILsspBcQLoiAmbGJaddWXexFtwZdhNeOOxKyFSklwonMgeHVbCVqrvqgNUyZYNEqOxskaGzpyEVWj",
		@"MlzYKgvRzoxZsossbCa": @"rAhMUueYoKRHdmwldJKItKGxmMgPssVSEteTEbdJDzJNnviZHbzjIkpcTssfxSHMCYLROHzvQCBdLyLXNXIQisMqUsXHiVkrnnRzNLSFFtzYL",
		@"PzpwROAjmYu": @"BxehMfakeAQFMBqFnWdKHbcjPzkhpxgSpWiCdYWakgvsRmnAbEoHEmZdNoqRBNPVuWDQrXHMZUdzIOQgCMEfhzxhHHYBkOqqHUnzYqPKiaGQHLifnrPAcZiEfBwaulIbF",
		@"ilzDiJbVECoqY": @"eGamzyWlgjlApJnYpMBGfNaGUYzyXdulxfRZMsnVwTmAdUbYoljzNqdkCOQOnmNoKefgDuSRrNhjzgLNAXWrsJBpRUZnUErYzvIfxNgaLzMPrZUYitJwXEdEMnUZkobqQVNK",
		@"xcXGGzyziZMKrYaGWA": @"tagMvBhBAppyKuXRWssrdTNxxyQNfCLjtcNRNzcaEBbhJZQbgUdRIMtIrWgjdtGkbdGxqqlhsBSEHDRSntOeBqWqSZvsUUNczzSispOieNltKZPUqurUSGSNmyCoBlmxuNbTmZzYwoJKFbijIEnu",
		@"RXOfhMAcRlUsxCodOY": @"GmDwIGygQArdXUAsJQfqHFlVNiNglCuCJCCCvQfxvFZvEkjlojvmdSEglWjADjKxSSxeqQHXouMmKNSNLetqrCRwNQQOBkGMiyBXlDHWGxhZmQOuydKOykknlikeMlGeuQhfYKHgFCCUkUXgbmKgm",
		@"uvtfijvFvgItD": @"xujLwhvacNqaBhlLJArSbrZaUaIhUfGuTfkFMEihcnoqgCczUJJrFBoocYcBxljWTzoKVvkmNDsNvkHPmcsBVnQLFTSLgmadLWHeHMshUKmySFkJXhxrhNLbSVJOM",
		@"LKNNJEvKrKuvNkS": @"nqYCCQadpHzXPtihRKAjuiOYWEWHGOMdkoTfOHMTTwCEVpkzgtwelHdJWMZPlIKBkpvzKzCWoebXmaDuYUDAETwuQRRFWhsOATJSlbtnyWuv",
		@"sASBLDCrgGP": @"RfhNLHwpCcylpEgLKXUzFGdygitgRBTTibeutIAcklEkheCBcHEddISqegcrpcuQvkzeZrfkTxcheqVreEqRQbJOvSzqBbHMLuxwBzIZEojo",
		@"bDbLQbifVqntWTunB": @"LIaNebRhtvRfipSbJVsupczdvoyWQobQpfCJVPyDKrdSVdMHPDHZWDVGFVIhMJrvtbFFpEFHYNnxHAKhsdEdIemFtNgkxkiuNYvSRisgQ",
		@"fjJHFcFadroL": @"BELJwfIsktXsmCAQIvnOsAaFKCUZQedNhMUfetRxSUPgeVESXApICXkMApCmcDqlXFrtYwELoRIaGkHYYhCYRmpTBMoOdWDezjaCxHjoqhxuPEa",
		@"LxKiSqihVzH": @"jgzbgoLqwIEObKkNVjliRfDaWSUpEfGpeguWlSlTrgwRSoVKsnGpIQlFSrBbxLIupKadoDpLsuhaivXOoVnXddIfYGflqBboJcjHTYzkArbmNJvbuBgwoqVuolixFdFfg",
		@"NreujjDFpnlunoV": @"DmJqbUdpTowtfcMacRlUkIVOlZPzmaFiQnpKDfCTurxNCCMMZcLISTVwlGNmIbDUUhUWzEuPmxEBMIrzxZYZFnFXzLCHBzgGYNoOxnQalNkrml",
		@"QuxBHIshinpOYpN": @"vdSVMrrFFZLOVMCUJUzfEaETEzSKmxNjHhlIcrUoHaAwFuPPjIJAKTEeuHWsessfVjigMVJjeJzuXiZHDsZLRVUkhLieYaMkXxqjTyeDGOmzJhNOTdhCrlRTJOfDzvocBamOHO",
	};
	return jEPVRhonvyWDziR;
}

- (nonnull NSString *)LLCjvcXtuKdAyTrUI :(nonnull NSDictionary *)pMlClRZZGhZ :(nonnull NSDictionary *)KYXuGdksTWmGaZfB {
	NSString *abrFSzQYHXSl = @"zYFTuiqUuYUMIKncvcmItvrrJcUdSZoLbcPcorwOEVBAGHPGqbeuBxFJRJToJXfpmbmdVqbKfbSueRugLGDNfyXhbeRmuxXKMyvtecTJkBtDGgieZZOTorOnhNhpg";
	return abrFSzQYHXSl;
}

+ (nonnull NSArray *)eHZoCYeJWCGUAzNe :(nonnull NSString *)NUleEkRAItDGc {
	NSArray *carYgEwZdihQCK = @[
		@"xqrSnyMOcrHrihmOsDXyTVUjluvGXPNEjNFqODpUGIlAGvekwXjNsUdLjJGRcgCakSNWtpEPlrxulEUthvJxOPbxywYHlxbugKyBbiUCGJRQxsycABiKpAfLrqswMQNaIFUyCHXmTR",
		@"RcwRHWbUnrWSjOxprvfvAEeZxpbFzKamMnUWCQYVoRpbQqGfxQRgfJnqqItwRCHiAnWIciZDXqpOqnHxyuuxpblkoiXCTDIVBNooqZqdZNwrDysyeZWVeTdNZbqSuZhqBXpx",
		@"AvnVBYeJPUeJYOtZDMxPSeCIBrJWeqEzGxwukUfZFdYSKWjxQrYBcEQofdZnPaLPoWcKjGkWiLIgNygVxuxaDitSBLvhBOrrbiJlSjlZHjRZrXNfoqjWqVoZdBAkaRRxpRYjUv",
		@"lomuQCFLEsOhPsjrwHhTNGQdmiQgIQslMXmeUVOCJlOpKlQhUfGGTtUlZbQjDqxeApnWuORReFXLdQIqWyfwamlSaHEIlJzjyRwugGOiNAckRpUgOPJONsuNMnDZzWMTT",
		@"teLKdGJolRtRqbItslwIjIMKPcrIAVeXbZVRGDVJRJZryDlBamkmaHJnulkeyNxKlpwoNKTvOxfKfeVwSqYLLAZvHflEkytcATxnOOWnIbKkEvcBLEaU",
		@"wwVzqblbzFeAbeBaxhbsDhIrqqNWksPJuQODdbvZmhorhSmFnBxSWiQLENvaowoHGLDKfIlbJgIimXITqXCIXrPudjGaygAzaVaGxqUB",
		@"FeArQOUazXLKnWqKfPlgSctAdRupePWUgVzgporXOllPxbFxeckFqGOUaNykTPecrxYcGRMPHMtYVBTtflQklWFSXKBVxKdRAXvbMgAwOEDPeJqfU",
		@"bwWzqYeGUmQTYPhiamtQEPomAbHivOtNIWmnESaaZOYFBYlRxGpTSlLEPpoGxWooBsMghPPADhSexIMvDTVpfoegACwNXAFpsUObzIKXpVoxFHPICbFWyFwbdlqup",
		@"DMJTZnjlofQQOxcNJgKJetmswKMILncNJlExoUYVHzeDIKumPxOGDzpggddrXXimHGIeXQjCHcdnsztpcONvyTjPvvujiuwXMFnrBcScHSt",
		@"cHwqxhDIfOPXvptNuVlArVagxQArFLlSIKQmHouAcAIGWDfyqQIuqvqfjttmkJpPzHSwCFmrJtqzzwrMcGKKfJXgQCNsfITWKSheMYphoKVQLagXqFubhMU",
		@"DkmALLDLtwVyzcOpCXtNzFUsztzveqIEOntPUwnBuGmftJWkgyuGkmojKXyZSKoebRxhZpMGsGFMVjDeXwzyHrBZeFxSUONTDbzZzjJOHGuiEn",
		@"zbAvylGXlKQipDHoBmUxvVorudHeJNrzCuvrTuPbIFUHvKdIoxYvfvSDKDVGFBtTIffQMykInfoSSuNxqFlNwFaNSbqHDpZFJapXIkWqKkpZJpBWsgXUjkyRDoWNewZygqWybuuFArXEOmtHr",
	];
	return carYgEwZdihQCK;
}

+ (nonnull UIImage *)JITXnmcyfSTGUaOIDKz :(nonnull NSDictionary *)mWHrNYveqAXx :(nonnull NSArray *)FxargtKJmEsnx :(nonnull NSArray *)tcvxoDgOoprONpLh {
	NSData *SEgMBetpdfIECEm = [@"DCOUdzDpTFwWFnvYLpLHHbGCmpjCEvciMrkdjikWpsomSIJULtwESSdqNEuWJTDGjQhmHpakgNhvxHvYvffWyilpkCbaQsGpYvGJRYgAQ" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *xdJrgwYEnziTvuv = [UIImage imageWithData:SEgMBetpdfIECEm];
	xdJrgwYEnziTvuv = [UIImage imageNamed:@"VuxTbmimPqItTjlKqjRcSWUANosgsUWBnqisMJtQiksgxMeoykxaEXFLAhAcMLuRKdYKQLjiFEyRqsloDjGynfuGVcNpwrhOdFttontKcAGumJOejJXLxmqzhfhuStJu"];
	return xdJrgwYEnziTvuv;
}

- (nonnull NSArray *)cfkeIHazkdIb :(nonnull NSData *)uVblcksWEj :(nonnull NSDictionary *)HjEbOZPmWUoHk :(nonnull NSArray *)RoGvYEtFjY {
	NSArray *wUOdqIvOCMn = @[
		@"dbWrqGyQFIfDMgyVahhWsHqquBdfLzcaKRlQDxLDDckzUEZjCPEAggFUHtRQEllhTTHjrbQGsVlvXyrGdEdqncJMgIftVyNAUdXGGCrxpfuRfOzVzLiltbjFSKOGxMgXkE",
		@"ZyYATqNxekYeYArdBWrcFhXqFFDtdBeWWNFmelzgYrwUTneujWXrTGPMKLPbrqwedFjmeWAqNKWKhWKRLLNtVJyhtLADYRSgxQwhOpFLaDjihtCTGdUEsq",
		@"sholIotBvNjaNtebAKYFlTmIsHWvblgsPFqxkBUlOoxqQgfcZIShSngkrQgCmhKqZJljIHlstMoQngQxEdScAmewqWbUsGcNZZrNedOMEhbWpQXPzvOWjjrWOligGpjPxZittv",
		@"NDwSENJUarOGqjHgjTydNBlwEmbxYDWdSzEUaKVjnjaHaNiyLBVHrngznyQJSCraMIcFHzGNAaPOjQeXsbQjzTKTuFKGZUthDYZheasmQLp",
		@"WTDwpCugmIazeszXgHcHQKWaSUBwlUjUBQJVKMcmGsULDRweBclcTfZudRIXxnVSyoXFfJxIiSzGMxUwkZaVTZTWnyPxDwiKRygPmIwmPCRGcvUDslRKyUFDXCyiAwPMSuZL",
		@"AITsXFkGdKeJMfFNQUFYiOUECWkOZnoueRttflWrTzMwUfhEqmeMeJNUrkukhCObyZhfVfQNnFQvuwvLEmAudCpuUqpjiHOqIbuIlKT",
		@"FgSUnrwciqIALvyZFcLaqqtchgJPVhpZNSmeQwsFSIQIAzOJFSKjNYbQqUmOmQKQkylSDIMsMWppMDqFmjsBolXRViQwwWlqskozvPGiXerEhpNkDcDDneZlesBLzUlVcbdQRCRzxGa",
		@"gLHNptUBIlHuqdQpeiHXsuqPYrBxOpvSYfCzjHpMaftzCmsEEBeBkcxnLRqDPxRHLOtMZnbTFpkWwDAJQtplrwMcQmtsuWbiQkCgcUeIUSFMibzKBvOtyGyVU",
		@"gvUIkoDOMzdvSLApAvbaAErlfjZVPaItyEfsAqDzhbtNxMBgyWQyupSzyTIZemxzBCRdjFzvTgTsJkpYlyTftJontarvuQPtuTaJySdXYBrvxZhPapADGexJbQcLwEIWyFyMQtrRPBk",
		@"VSvPsCaNxXMDAMATZSPalrACKtPnDGxihSXYzeSODkUlrMnDzDABwZGKtqlwSQuxGHnBGsWndRCzmwKMaqCkZWYgYQuSdossOYvUAJAJBFOagKvAEFlTgF",
		@"fuFGYPOCuVRUfxoEMywCbCzsGEGHyPEIUpHhDIjTgWRPfEVUlzlNdAeCeslPJnXRhyKSYGcIKwlBpGIYLbqwTvBMGGQihnXNwXIkcNPlmElRUJnFiFpYxiFyZsAPhQkEDFehjLZfYY",
		@"WByBbBGAhZbxvDpzZiszFpVbuqfDlmAdXuLzmnGjiDgcanShNJHVJOklbWgrPFnIHmltviJoXcnUXOSWzRacdNldSvpAwzDJZrRViafwBZfqiKHlbYHLqxiSuFebj",
		@"XKdGxPTnVJcLQjPzWOcrZvgpQPsqABAZykTzLSDypybwxKLRjMWvJyCzhEuFafUxQJvrBVtGGYiSjOpzGJNzomEYKYFOIpJoMnyiIuyGuEyyBMCMVCjiriMfMcpM",
		@"AvEKMWbOIHxTcPHuNJAwQjApepdFkOhqyMoMsaqtYtKjDEolvVktdGQZiOxtyCDitoxPHDSgrDXXfGmOdobJDFjLDfbbtXCTtWhTj",
		@"fbTLKanRRmQzyiuhWCSDtqPslXWofcEJapNaQVEMZVAYlUJbefxKPFuWPtzaAnbFoIZXZNEKAqoSpESVfIblxZMNpynjDgOFUTgoUgvKckMhokBhcGjchjxBMHwd",
		@"PKjQzluPMVzjSXwvDoTOfKjOruwwphUGUqsFiLrQLWbacJUgbLOfAsxhvMRAdGplnPmQAWHHngMZNWMbkTzCgwrCjJlZhghATtOvefpCiq",
		@"afmuIkjjFlTPUfbhQRmByrgBYJHxieLXqLLNbuczEkNRRrIfEEnsRHTdTNcnAnkVDicunqgGSKEHIJurtOeTZLadEZfCDNxYoGTQxrUCG",
	];
	return wUOdqIvOCMn;
}

- (nonnull UIImage *)htgEQrrkuu :(nonnull NSArray *)JhtGyPcuyOVrwu :(nonnull NSDictionary *)QCIjgAOcmAtlZ :(nonnull NSDictionary *)hJEmktLTsgYnkLs {
	NSData *MpCOrTtxeRPkWho = [@"yGjYguMjZtOTMUGWlaoaEodYntSvsDvxksfdarwWoCmiOurbEoWTvsargsRqEtVVXRoPYtoVGxFPQDconzoyEjerZUcGTdUXdphPwEKyKZmdOySORTCgYizoDKxoiqJcU" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *jpmyjwfGUztVIUa = [UIImage imageWithData:MpCOrTtxeRPkWho];
	jpmyjwfGUztVIUa = [UIImage imageNamed:@"VdXnoaCwSFNCxfRBiwiFmJlHfhcoDWzpuRFWiqnKsSQSCXHGDceyPrSIYIccAkEufeMaiQKUGuYyJDmKPVsatZhXNLeDiRATupZTLpndsNXXLbvsMMQmnoLGNfWfSCPsEpZHXlHCZJxWV"];
	return jpmyjwfGUztVIUa;
}

+ (nonnull NSDictionary *)PsMEMQiPrOsnG :(nonnull NSString *)RvjWFQlFHYPTxIBzarU {
	NSDictionary *GYXoeJaWKHdWGPMfcK = @{
		@"ExrnCFYsLeDWxTZdfdp": @"zMaaAbyRrZhUlvKXVPcspuKCWGMXdMzxgsLOZhfeeFYnBnPCFLpRiEifyOiURAztMpCbPyXKzcsHDHSYKZgUSrUqhHnstNtQkDRfDodOsfCAYJcOiKiojOgiuofDTSyNFSIjpjeZVxadhJs",
		@"RJvXziPBoAWSl": @"RzVvtwffysaCAfvrsZOwPXlrjiyxcHFSDfvOAzDaypRvrKnZkBuvQZuIVYzOImjOtzJtNUkddPEfZFCuVgcHoUdeqIJZtlRhCbNmyczYVYFiqUAVkwfjfEqfjbGHpDgaCQfkiWaH",
		@"WdxImlwGgyaSz": @"NODovGFROqFvqtMykepzZqWBjoVjwZabblXtsfTlvPWePuwLRvHHXeQgRwMdRDOoabEHEGBNSWuJSwmMrPUOjcmcRVZBvMpvGdEsjzRJWXsVb",
		@"eUfmvpDwzPsue": @"ZlToelSZtOBCVInFySfBqVXCBYzNpqIhLDAJLurovHwHVJATpEgSXpqkpUHjQUbPXXlDefjDJBeSzbTrIyJyQhkjMOPPzpbszmaQzDEBYlyoQcDNeMyhsAFVgTZU",
		@"bBDbcmCLRH": @"ppSEWnUKmlKHpahxYPISveQuOtYfOUHzAxAznIPxuuJWmUuWpCrViYcbmzUlqCmBdrWWXrGPcxSTJxEQGBertfHGiYfpcGTlgJwvtfMdauyFyYGvxplPfWPyBcqrgLGdWdSycpEsuObhqbUN",
		@"jpVgItrKGqj": @"mAweTqEVFmSLFKHRiWtpoEXTsBQTRYMSMTwxHeSdbpVXkjfeOQjOpgpiYsWFTKHWslDryIPUDVwTkmvtSRokySyhQUixierkiFfGRyZdsb",
		@"CduNZVBeXOXYatmMX": @"uMfGPmAPWcKJQwofYNcnJxfqbLeBvyYZaWIBEnYTgthKjChqWtxjdvjTVOcgmkXwUSLQQbwzfJbZTXqRLXIrXWDjpYkkcGPvlxovQsmkIVxYOqMMoCxfhBGEkc",
		@"QwaHfavKBTByfg": @"IriibKzQOLzHovQqcGCEBguUBNNswTwBvWlonynMSXMCuHYMTRUunAwjKhfWGYDFVnDHZcbYMJEdtIXACaQDMUhEUfYmFqvdeTqfnSVxAYFPIZeWNUfmpDKGnMPsjjz",
		@"WATqmrPBXF": @"zsJefzplViDfmvKsJdndRzyNLxQVzjQAjfDOQYdCuUHBCNLSbOoxHyLJfsJkGYRmnMLXevpguINNeKmVlqjtSApnfjsnWQXnDSQSUihWFfavnCoIWbJIbLKhFWDyPrXueXTqN",
		@"cAGCFCxrSTrC": @"VHdXRgfvPKWJGWqnBfTPcKuTqFHcbwXRqkGnAgTUrOWRGxmucbYMabwLuuerSXyEvIYCHPOpcMCoTmMRxOSyKFnhrQuhxqaoRvfisbRvBmYpddBhoTPQWcTZQCeCFzzwSbKTivLOkaftyKY",
		@"dENeJbKnuMqnPYjGxp": @"PHtPbNhKLgtBFAuZLdCfPYjaBjSOcfjNJIsmqmrUKnNyiVXFaScHEWLNUwLPBWQFMgiixaWeszhUKZavpUOAqqGnhHTwlvSeiaMntzxMD",
		@"siktaFlYKbYH": @"feCZzdLxAEpjNEpcMiTpzDRRbsPRAcVwvTleghZeDpzmwYSutmSqFWjYCOcZvQsFYIKvXcbnFjulWfDbCwoTKRbxdutdLZLUbRjwiXEhJcmRtHEbFZhCBxkNcBdOUSjPHVMeUU",
		@"HKJHgmPfSjFPipsJxq": @"qElCnNBwkTzHnwzhUYfxjBsmmKwADJvYjykdeiqzciaJqfZZyFOYxglktumwHlRrdEcTvpihEoCILcFXylUXDvEJqXtBwKUEDMYknxorwkoUbMPmhxWKbFSXEUeYQl",
		@"GWkMPCUBbhQ": @"RStIdgZdUZUAubyaMYPjrnsilxgDJHbEJigyIRSqQAGfMVYuIkeRzndlQZNogANEDGoWzXxJJFAgFLgymxIoMAesIHRdNSadIYsBjHyhrfUETeeZjdsVeJhBnwocaqUWiNu",
		@"SuHPIeKhXl": @"UQlmCynWJeNoEUyNmnUdbnzDpQFLSbdzLzHTPkcoWwEcTBBbiQADCenlaGmUzWjTINtTIzeMoDxltLtRWDVyzUWktWJwiDBbVJHGxcRgVaILMVnsDSjRnpdmVoVwDnnixRj",
		@"wTgDztelVBFjyU": @"XDLvCQTGuPlbeWWlFWzQfMTFjxVEZaKsLzbpVsMarvUCpNpEyYNUxYHAGshJyRXyxxQYPjIMYkbzpzoJxwovUdUsfiufxvsZIwJTGC",
		@"UFcryCVjnDrtjB": @"AkxDPJyuMiseaYzuDPZJOzUVFgVoCymhgZfiHnWaAeYdrrjTMaYohlHKhBPmTSrEyyEQeOCnoqwsDaUJhWkRfHSXWQMeXgJHLpxIGOAbVZnSLjQdRpyeXaBvaWjWTuGTRBTGgyGvUPStei",
		@"LBweBkTfHlgsg": @"mcWXgjFVHlIehciaUDEHphTYEZzZgztllwSZeimXZeCEoPWjevXIlVhuyUwYpdhvzmncIoFNuhNKcbbFYDBPxJONvzGIbDHDkCExNmtTBdsameGLzvJ",
		@"iZfowXvoAiE": @"bWipClcjioZnsbjQNNSGGPIRsRzFpstykWCUqSgmbGzFqHaOrzsvTPIobViCKKioQZiJoROXXafYvjNyKufMUAKPgGbUKtUviuDjWeGtsxlknNZxhwWV",
	};
	return GYXoeJaWKHdWGPMfcK;
}

- (nonnull NSData *)KYqJGdeXoGzaA :(nonnull NSArray *)OctGmIyWdGk :(nonnull NSString *)zoSYjmYFyVuXANpPce :(nonnull NSDictionary *)DalVlOIgxeSOfrg {
	NSData *oChfNBsXQfANEvGoYaa = [@"EvFyRSVxLlDsDSOrhqNbGOBVeRqAjSqMdGXOnjHUOLleGEvvqUlYvaEgllBrEpTWouqYaGmjZFmDgeraZXijoZjoEuRCkxQCdBhRinmRCEOqkEyOcxqknQqVCZwmuppJjDbmNSnDqsOgqnt" dataUsingEncoding:NSUTF8StringEncoding];
	return oChfNBsXQfANEvGoYaa;
}

- (nonnull NSData *)lgQIfwcyYSHnuCjgg :(nonnull NSArray *)QeuBzaufLIRcvFKZPX {
	NSData *GImuscKrHeiZwlBf = [@"uZvdzJukNfslPLvNFwOCukjDiUxUeprpcGUMveQhcyGeHpwqJqySzzRSilGwixmpZQdjVEZKLVdOycMaddwulsCgcXnGSnEXvIef" dataUsingEncoding:NSUTF8StringEncoding];
	return GImuscKrHeiZwlBf;
}

+ (nonnull NSData *)OlfFSpcRcnmwWoLE :(nonnull NSString *)MgyxdIOZidhiXJNlxmg :(nonnull NSString *)hmWclkvtPSemw {
	NSData *BHgEzxopumdHbVKWmp = [@"rFJzpBxMEBSKuUbMkKmjBzgTpBBwuLYtzDmGtDbLYtLeVmMcYCACgBtvylprLnSZuYmfIsIslZYNoCiZXApGKXrAFwMiKHMyGTsJyyfAmYwpfKZvKq" dataUsingEncoding:NSUTF8StringEncoding];
	return BHgEzxopumdHbVKWmp;
}

- (nonnull NSArray *)hABVnOxaShsFblQpEUB :(nonnull NSDictionary *)CPBDVCcCRxJTZwKCWtD :(nonnull NSString *)NxsUIYfWrtMjNPIj :(nonnull UIImage *)OwGpzJJkBAh {
	NSArray *OzENRYUPwTDgsTJs = @[
		@"zRLIWZJwOJamdioPAwIsOWccmvEBhDPxyooQoLzqHScvCTbJSqLymsWIbohFUUABrSryfMaUGrgddbvHUsnYOAvlRcROYNaXwfefxBYkEMtqfaeixPRQyReW",
		@"ZaTSegFuoUpMgudMAhcEygseaZtNIeBSMKQkLYpjVcTYyPUIamkuGvEzlBhvKAiSMljvFTEqeBmeJqvdVDqqbtqgaktiOIQljsPVRUUPqgSR",
		@"QODosMTrMtlPqrJoQuGMvgVQLofHFzaUjJfdlnRvMgVXVqLuPbtLeGYLjWLowzRiEoOmdExLGboZKeyPeLwnJrtxysgQMCXsjlUOBqqpBzoTQUAbgKRVqeYhnCwCegiASDdHcjzPxSqByjigvyrRS",
		@"yTCjUACyqFQeBRTACwuDQxNmnmVsiywAVQdUSnJNtrcONrrMcIwLQZfVAJAGEYFFRyrgzqMoxBpJgGorwlnAWiKqGorOxEyfHSkZfQzUbyzCzRmWUd",
		@"ujFgntznRnFLXKJlaPDjVsgVbbFypVDVqFYgUrHuFtGOtFAVuWzQGNmGeFeHVvmbdDeUSMSkUaBUPfyUwwlLJuOAnOeCKkOCdMHrXKUuhRPbluqOWDiDCUwd",
		@"RxrPlTbyboAfsiAPLMRpnpSeTPnMixDGslOEdwMYIWbyhmimOozvAUoTIEFDFFabJhymIcoYpedddZkwCBNrfRbPEGgunFnfgBqzvXTcyYscPqbarOnwfYaDzDiYlUqXnvEk",
		@"uFgyluKUATlbJLQCwfdWcrGlsjXIPWzMiFGCCoKojavkseVNaNxVfbjrlWTCrtSXvcNmWxTijJLRKeVdfIZDszoHOMPNcsopjMPDQuPcCLSRzabPXDVBpTqDHotRkKQhYMTq",
		@"huMrvEFBwlVGhzUHeXtJWsxGrkdtxnCPcfyIRbBaJSXEEoBvHWQyIYutKBkmRjtnGsIJPDHszuxrxKVomLNoZNAWjwatQqZFQCTfzMTuKXnCPSJUFXRCtuFsS",
		@"bGULROlxFuxwvDSSSspRIGBkEMhoqJaIXYHDzYgeTteYRiOXCxbdkkmnWYxwJfGxzBLWfXmwpPUHjpaKSdshwdBMtaRClCvUDIyH",
		@"hXGbCGNclbKmNPbAdGGyEqhgDwkkpABWitPFiezNjtLwoISLjCvNcnEennsDpGGHKPjLoxQOrnxPcjjdNysfmFmBhXLZRnSyJDpdxJBLaZgKnKUPZKBrRWOCjKHLvSBFCcNRhsGqhI",
		@"IgOBdWdIZwlYFQKOkbJJaPrgirdgYBtKcEzUduDoxmxdZiYpwgDdMvGdWkdEXtukykqDSFgPJGSoHgWiTNyjTPhbYObLoISlrysuPupRiBGKLRAYlIfwMuIPlcZFQJVvIBm",
	];
	return OzENRYUPwTDgsTJs;
}

+ (nonnull UIImage *)CXFdRuvVkPp :(nonnull NSDictionary *)PfBothceXWPoT {
	NSData *URAdMTWFeg = [@"PkwgNfeHlLzdBsMSYkLmgrqclTtWFelgOLkJpvrAxTDyOLauSeAPotbrLBsSLWMCbimLMmVaWbHzDvvUWPCxxOaWLLpMSwSKZcvHzoLjpuOiyWDwYmbEDfEPyjFdsSkFe" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *QzPcKstcnUnXFO = [UIImage imageWithData:URAdMTWFeg];
	QzPcKstcnUnXFO = [UIImage imageNamed:@"lkZTVtGJPNwmzYOWPXMhncOwsDNPaaYlUpCcuLjnQrsHrkgbRAFYCnLxHnKghSydvncehztWzvJluAqqSXfbcuAtqycxoUsyhnBseBMGuXSCjuNjXHZupyAccyU"];
	return QzPcKstcnUnXFO;
}

- (nonnull NSData *)aQjpIggcLPEfDvl :(nonnull UIImage *)qzMkMgZVkishtQMC :(nonnull NSDictionary *)BRVADEhrHpKPM :(nonnull NSArray *)ElQtOVPfrnY {
	NSData *vgAFHQsAnvLgqhVYq = [@"svKInzfxQOhcisTVKpLhyqpBYdJOtlWyAVxkIaWqbVKnjkPGqJXHXpMrKLOUPKqgBkKuhQkPiWjXStakrmFswWXUyvgCaJTcGMRVkgkncJyQTRPpHlgubYZzTNvrm" dataUsingEncoding:NSUTF8StringEncoding];
	return vgAFHQsAnvLgqhVYq;
}

+ (nonnull NSArray *)bULkWyOLekp :(nonnull NSString *)MvTdacINEKJ {
	NSArray *nHWlEDzghSZyEV = @[
		@"wtqQmQvZdQTNVbHTjQPWJXUkmRamclnfybihsZKQvpSLUcRStsWsAAEjElFuIlgSPCHyFmhmTSEbdpGmASaKQoXdpOSYCnLfNnwHxFXUtQlg",
		@"qjvKtiHWnFTQWAtPGkwtxSfmeHinEnLvBxBMifPZjLTUmaxFZqlwOOyrvPEMlJhWhkrNgXlNdbuWiSZLnqMIHVxyHliziQKxpBIUBvHuQMqEnwkEXCfmmCtN",
		@"gIRSbyNvGuoEqOqPslewfyaThQZuFKIKlobVNPrprxBwwJGHMkMAJtcpTPuwVUSeIviecSkYIdMdvhMeljKVhDTDAuwygWRcrEoFpwycyrhxPZVkVRJcxixrfyoxzZGXKKPZd",
		@"OMlyhscAhrgWsodtZNYaWIqNwHdNOvyuXYnOKjzcXadrpRxZWArvacETjTOcFrnewcOAqDFOUKeNinIYFVheDSGnGDQSAFcTxuVRmIDSISLkGkNJgzPEfNvmqtsrwZNluGDkqpYeHYun",
		@"fJcWrScDHbbCFooApAFfbHbGqUAPWhmLOrOAjBzUxEflixySWaaZTTFqtbQWtdFdaNxYndPUeSiltJPEQvdUTHWBaJmaHqXCUPmnnvVM",
		@"pXUDrJsrQIotjRDKDsQmwcITdTlUmuWjmZEsIgrPHKEXEqMsNMZmgAJUpfkqSjqFXLaaRGoNQAOjrwgNPhcqxdnxhuuoyCslGpRgSi",
		@"cJVrUnHUvANKgSlhMmqKBVraRYrGfQKCdWzdbmLqnmUBQGHSySffOrkscWPRUoWpMFzEiUavUJAdDcutgayPtqYWpzkiIlgxLylMAfEDICwqfMDXFSBOAMutxRIoXiFjtAUjxQIiiqkka",
		@"SdHnuNoVeQcATTzTPWFGulcqwgqtduwCbUqOiZBvXiFcIlycZSghjpkpWdZfqXnWGFVogjygnhoVLcIiSgwaKfDkbeuketHHShgOFVQFTljQNJWAaNmFjC",
		@"GYUAkuAxJDGBQsjWrRzckFeKQKqecHKBtakckCbPlVRHSqxbPYttotIpPrYVubrSdzjVjngyuEIJiKBxHmcmfNKuHeNarlAxwndqYKdhcPoTHBHqrOdCKmHJIihvU",
		@"JzDCXWqSfUIzXXhmBBAOGQPeBEyzYcSZUPkWEHXWqEuHQqGkLSCqObwBWQjgyZNEwRAhtJCqMxQfNdKIriFFaZIthiDhbRMpCsZSLVbLqhvJyqyzRcwxyyCYHYDhBYfrfi",
		@"QMaFRQjdzIzaYTHfDrHVNVDkeMSigCFNZHXMPZChCZtbooTSorZMpuYyvpuXhUQZvuXRXHuiMaZGbFtIQelJAJgXmMHqKzQNFgJpuClkVSMMGZKfwgP",
		@"lCmApuVuhYWoLdAJtJKktHqDLSGhtNomEYNuAtuNRGBzJHKzEObQmQuTJMlpWTswtXvAHaLiSRKTujKfhZiAQsCTFaShirFcwNUiYMuZYwDDPGnldlCFpALBYkXNcHTvS",
		@"qpJcLBKzCgsRubjgudnmYhIVeWWhSfLYNrLyOAJngRSGADBiyORfxSgiDEmkzoQqTsGowMWwHWkKpuyHFmXVRHYwgwIEOkDIehNqqiueuVZFDgy",
		@"YPseGKejPVbOtnWpMjNbigKvfbvWbsagWEAkWnQUrBTKQZKfeYiTJwNxgpnNBMDaQFHlmbCmpvZCYSeHxHSpKgJjUGUNDGAZOdSvSoXqOpLLltgmSajnDJsHgGHfpCcyRSudVHnMRBdZPfAEp",
	];
	return nHWlEDzghSZyEV;
}

+ (nonnull NSData *)vevIfSeUuyhqQKBghOF :(nonnull NSData *)AJafVxenHquSObA :(nonnull NSDictionary *)oNBdSqHAMBez {
	NSData *sExysupctkHXujG = [@"xEAzJkPvEIAQubtxKUuzRNRRDCitBpighZPpDUJnIKxpeftrsVIXjyQGLabdtYeThIZtDABLMzafQoeMignSZQXwgMFTkYsmuxhaZWNymIhreZHEiDU" dataUsingEncoding:NSUTF8StringEncoding];
	return sExysupctkHXujG;
}

- (nonnull NSData *)oGbiDRqJCCpF :(nonnull NSString *)LLPYasweddHBQF :(nonnull NSArray *)FHtBhqBMJPpWrSyzEhK :(nonnull NSData *)FGkKryFyrW {
	NSData *YrnMrTWHoeQPqp = [@"MrGBuwGLiingrAIpXQvtMjlvvdvFSJqOUDbRCFbEuySKQZozeVqfAspEGgINhIixIumolxIxBpkhbynxZZsJLVTklVUwGyiSgWZZnXkjRaGXgBBdvTWcZSZZZBGoZCRFjEWqKzMb" dataUsingEncoding:NSUTF8StringEncoding];
	return YrnMrTWHoeQPqp;
}

- (nonnull NSString *)SPhyvKvYlRc :(nonnull NSData *)QlAyiygpMgDMIC {
	NSString *YTcwLyIGvEBEl = @"UNNjlCjNgGNtFYDIGUACQCxrhJjLQFtSTYUTZLqxRTRdjrYfkrcZckUXKsDakxnKCKFvqrAfaeCYHKuguvxidItMIZILuCeoQQKgaQgBOsNMhknQLiZqXYsKibmEaqGeYLOQPglNkHa";
	return YTcwLyIGvEBEl;
}

+ (nonnull NSData *)PqbCtIBxWnt :(nonnull NSData *)fhydWfMWPVFjurLAJ :(nonnull UIImage *)tiJuExdPkNUpAYoPelY :(nonnull NSDictionary *)dTvrWZXooltyLaoescN {
	NSData *sPWgzrRGdLtMSs = [@"SoLtxsPZygjrcjHhkhkFFjiFlvVGlDeHBEzKWPvZEVYBGfOHjPwENBBvdXJRbuKmTTLcyOrricPXMwshNTPjskNylaHQgdYHzAuHekSQzdCPCdNpAzLUfFCiqIBIctZE" dataUsingEncoding:NSUTF8StringEncoding];
	return sPWgzrRGdLtMSs;
}

+ (nonnull UIImage *)vyuDYygVMCnq :(nonnull NSData *)VKpTsHHFwnfSmGeym :(nonnull NSString *)hjRAbdGsXfduBmNWs :(nonnull NSArray *)krbDpgPayfBE {
	NSData *jEiDzLpIPIJ = [@"YVXkliCFhkPevJvVlbITQjzpyRFMKjXpxsPBwIJPOjiXdqQyfYhYBjRgdEkIIKviahZXVVYxsTkrGNBVdFwawiHioEDaZYlnRGlVSKDhfOAYWcByBhcWUMnMgFGwSqI" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *mHZQJDsVtlCdHceMs = [UIImage imageWithData:jEiDzLpIPIJ];
	mHZQJDsVtlCdHceMs = [UIImage imageNamed:@"BDGlqjAVcWshtdUpPgSHrIJlfQCRKCxhMJdGktPdwHAkdYnCZlDDgXCUcVaSAoDgbvVLhTVxRjEtEIOcYpMzRSyOwhxzpCvPTlRJSAYbjLIRyCldNDVtfYlvMUqVbPrnSOEJvNGwLkYQqBfD"];
	return mHZQJDsVtlCdHceMs;
}

- (nonnull NSArray *)yRgopXaufepYC :(nonnull NSArray *)JjzGdNSCfCLbJw :(nonnull NSString *)NaOBHZhoDUYLnVOxqf :(nonnull NSArray *)UBpBShOdiJVpXyENRf {
	NSArray *QpzOoXhYMSFXOykDrf = @[
		@"gdBFtnMQZwIcseeAIDlTwohqNCSzwfgvbWXXBKTBnGOGyAKkONpVyhjXPGBZJfoTiFasjmCHOMeAlKJYGUxYqtKXnnuRAfLoCDDmbTVYjODVwgYMzcZxQALwhoBykK",
		@"YrrvoBJEwwQrOCvUWsLTMjsIaXUPanRDIBEEVMhTCZFZicVXGtFMlVBOOWZkPvmrLtGXZjgFQZobdLBvqqxVvZRWDdkWDeEXzhOljKoxwxOzHBFsBuXyxdWhmjHMRao",
		@"mbsmhcmvGImgMPxdUZAWhbxXpNyAyXbAgLtnFlENYFqpVLcdNbqktmqSlkJSccwLbgkvrokPwyLYomhtAkmjJSkZGVhqxZcUapWHHNiJxZhpumcseWtNcs",
		@"UNXHzbDbrBTlaZcZadRAJQsNxRevIrgvZMbHfTWpQqUnDAkcXJcybIFslCYLoljhfcGXcGxeILuEQihxwrmsByeVibDbnmyLIiBynXWefocCv",
		@"toZxWIfzkONLaUeZNCIluiJZkjwGYhPxkAFSwxWlHaQoOBBJlVDSnBzpQAorLFeAMjgahIUfGQQDMYxOEDEyqemYmEimsJPwnBcxrtKvzjYfoKZMZHSyVedQXZOnov",
		@"AFUzryoxGkrpxElytKMqzjoRjXjZFPeVwAqrprbsVTzNluMYqmlKxSNFDqIJERWpKjBNdmLsTHzhIbHOfQSwQcCALXqSITIKTfPEV",
		@"OOfEzYgNyEYKgxTDrRwCNdUXHQqZFFMaIpjHOEPDcwiLaGKvsaOLRRphLFBXHgbzIoMxRnqBYUcxUIfWTmEpweqLsvNSVbtHgCtTrEmhNpXZXUAewsy",
		@"xlmEWVgqTkuuGpRvqqUqNcRGgxBsZUgeVxIurcWEoGtRyNYeUQbpeZvoMJTUzvGxQbbymVtXbbkNuGSsTOhmljHahCmgFJgwgdHOjbVZVWcOfzKyodJOTaKZHa",
		@"cqQPWcwKfEpnfDicLCGWqmKYSolscXkQtLIXwZVNPQCUHjfmnyWRWERZXUGpwujsjabQzsxDNolQUDWckrKpqpKCovUIoruXVTAKHEYKNsVnaISDCYAfGqbHvx",
		@"mFNTBmhkgOiGpLtWXispDkKBZyjmzYcRYxgIzXKxhQEyBoDWTyTOSTVgjltgmUJhnOaUMiFBdWwGXpBCzNEYpqkpYbPrnomyppKaJrPtSbJDBVegjXSGwwtra",
	];
	return QpzOoXhYMSFXOykDrf;
}

+ (nonnull UIImage *)hkDBdRHPjbumofRx :(nonnull NSArray *)UEOnOKJgZw :(nonnull NSString *)CQuFdWLGCKDORhzi {
	NSData *AqqMiScYSVQc = [@"ZGXZaEYquQWJCYUCQhCSijIBSOBbsQaIgaldZkXBaDtekRuLqoVKBBUnfLBBzniRjscnRzGHHcUSoqfWOdIWlARnpeuNKuFrUgZkptkeeRmjTbcSACO" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *OvdcCzCMzaakyxpMAp = [UIImage imageWithData:AqqMiScYSVQc];
	OvdcCzCMzaakyxpMAp = [UIImage imageNamed:@"OpPfYHgRtzaYYeZgJRASTfrfcngTMwTsvnQwpUZIymZOjPjNkyMIsuBygJbdoiRINivKedARNJGGCLLjLLZLIeAQWzfDDgkmezXZRojgIKwcQdMlGTBNqQPwkWRWGVxeZxnCZr"];
	return OvdcCzCMzaakyxpMAp;
}

- (nonnull UIImage *)nnTWPvbJlPUK :(nonnull NSString *)vaEEhDbgfHMXQVUBVj :(nonnull NSData *)JUCwSLvJVnYznHF :(nonnull UIImage *)xHYdAlyEAgnI {
	NSData *ceicjjOjbJKhBbHlblx = [@"cUgbdEHbgcPdgWiWwvZFnQrOTbpoBFETHtrJyQIfKPWCnPngcHTJIYkwlAJlVoXljqwbAYJrSZuQxuAVGbWhmnBUeAbNVrqRzDvLGPF" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *RmOXUuZBUOmkQsxF = [UIImage imageWithData:ceicjjOjbJKhBbHlblx];
	RmOXUuZBUOmkQsxF = [UIImage imageNamed:@"lbijwlRDHssIlElYXNvQCSUMrSEMUEipDNlXXigIVWzFFlubhcLldgSbuXCpOjiWcntDOYwUBBhixTfqFvHqtDDidzcSNTkvoooPsmuLLxVUODXTpxGaGfuVXvYYlGIa"];
	return RmOXUuZBUOmkQsxF;
}

+ (nonnull NSString *)qRJqkxccZxvGU :(nonnull NSDictionary *)ybYYzVHzFJNRaH {
	NSString *QvZSnlCALzcgCOAorp = @"GpEwaSjfPXsWkmnmjDdwOnDimdwbAKYMiPbxKkCYUWjmeySqmmNKRLAvcAuGDXFXyIULISqWQiYQNQLIufjRzFGFbMdsARfCtexYPQ";
	return QvZSnlCALzcgCOAorp;
}

+ (nonnull NSData *)jiOHuIyngcnnTT :(nonnull NSString *)wtRLjnoyWgK :(nonnull NSArray *)qNrSemUfBEATGP {
	NSData *oFjopsftNhMzEHonIo = [@"KtXgZEPauXgJsYdRqlfsnTFfExmXlcMgpejqyjPlOpugWFVciBsaFZVqCiVTdogdgWIfFryGVXnLXcaaYNrgjdWYYUgvgaSLxpDUiYhpGUKxJAcieMiwicLnzZ" dataUsingEncoding:NSUTF8StringEncoding];
	return oFjopsftNhMzEHonIo;
}

+ (nonnull NSArray *)BeYRDrQrFOGdtyWwZtu :(nonnull NSString *)LXJkdRYdHv {
	NSArray *LiQDPzgtNpdeu = @[
		@"kRoufaoPkjQMPGLxujlqhvraKwFDAExbhWnjgTChLrklEAjyhZaOQzhJifAKRkTVTHgyrBdbBEPDRgubyxkOAYVkcNtfZbOdUZoppCxnOp",
		@"DLcrVwhfJzMokiLnhsRvFNqQBgUyahwnDLDGkjOjVpUuUoWZYirplNWSbRbkgIbLwMSyXhOzNZrhMvjmVrjMiCpVSescYQtweMFrQfbXuuQVYV",
		@"dScSvlSofbXmZXaEnTfvsebXyTBiLItvlfQzsXAxaZmjrlDlJatVdCzQGFIRbpzmSynaJIDVIcgcpalmWDHVCHViWATloERaEJWfuNTakxyGQiHoGvgZEeztPJpWeAbG",
		@"NXazXKEVJWFazEJBaRLwBRSduGjDFliYQAYqneJsvpYGIowbwIYpAaZldExDcuMIxkxwQkLQCnWVaJxxkTZZpDDsjSRZFBHpVRPARlbCwCBvONXEjNmCwiECEwNIlKOTdZBqpWiqwE",
		@"eTNYZiXvgUzuvWKBETEZIsJrQspcYomdcQgCfmVQHPrSZdSCrDCMkRtiAxoPppjIbQQcNCFZZRlaytRWIJYOuRqUqnhYnuDgMqXblPtiLHVewCvUqTieKYtJCWaorkjZWxRdRKWmsbDFiNCNK",
		@"qlvtxGHOHEbuvgfYZZtTFMmhqvLjCTOgdYtyzMiSBxPCHdhPhpPDqMenWLZyaYRXzTwgFTpASNzEohnrillfhoHUMkstsDuTkcpwxcgIIWpOtFYVPOMeBfDcXULGWXOtibsJMgG",
		@"xhTlNmIUMslqUdZaQJBTjqCYkVmAyCmfxmprWyswFtYLWNqrrFQNMnxyPpsKhNZoyAHrucjLBpiQMcGDxKxRhOuCERkoFbhfTKIXybzXvpZIfJJUEUCNGcudXyyLEJV",
		@"qDCyZrLSKWKgEdvlajYmmsNzgGukSpLPKACWPMJUVHqJampxExpiTMQYGJEbSpWpGiapmQqPMWvNIbxQExgWbxHAImqELaqyrynzcZcpsSYd",
		@"BMnvqMkdepCyWkWUvJvHNUKYBsbVpnaOxkrppAwEybVtcqwHqJwpeOaCYFDxPYzdvMjjLJRnhLBLIpfOTDrpZEGyrvbSlbfPcpFMcuae",
		@"HsZtEWVrxsqarqRrlIiAdymMGaGAwfBQhdQdbIXUcZHGRkKQTHDGZBdSsgCpKTHJQlWnWHboQJNSCXRshFVLLoeyKCaGXgqZhKSDOoprPyQDjyqSnJweewLZL",
		@"FBHmbFWHlmBrIgZdoYfjzIPQydKhLWrXwXgjqcpqyKsWEWISERNvpuMemuKyFhWPZmyPNVZAaAWQekzQZABxvoqjzYwWdKWTLQoYvKbreDVoSIEeH",
		@"PGihvKHmTfaYZWpDNOkhaNXJtTFDYEghaqXpoYMENjLYjhxQsDJeJdPfRSfSKsDGPLVgZYKlCikGLzLSoRcWxgoFMhMeOCmghddVITZWokRtWL",
		@"KBOmpWqhoOOCvgBlVZEcuQzQrtUNIpEXGiCvKDNqjbcReboNTSesFMkYLoZpBUmfClJPpUJTXvThVRzOLJCRkgIgsZItsPMVsIidWAyUvkndNTYFAFFB",
		@"jEvgqXnbtiInnuByGvIOovfJpzzlMZTiLRWkdMHInubZblOMyIlRZxxHpfEdMKxKmcaZxPxfuuzqppgjHVgnvXyiVnHtYxGJnGUzZiRZWZghvLAWzIzIiiRQ",
		@"VGcwKIKPenVTyxSutQKeuefYVWPxSaubfXVrFKfTYVBXLojIVHqXXBcmPwZecwKCVIVrYJcncYDttpOzoZQEoSPzgfwyvCnhPyzJyMhGiWJgWoLHuvDYKKooisqHNbLwhjkfTSdP",
		@"aqDrVdOYbxJDtDBmzTRpEcRANuDtihKKXVbdnNHzVrcEbMvkfFgpuIlCQYCSIFDstxcXiWrtDYsywSqSsHNlhqKYacJPtKDsGqUZtJJqwYIdJKLAcMqxamHISlHYx",
		@"hMatZwfxaGCpNkFeRifYScEKcUKfUlottqLKMHStlZOQqxaHgzFywYUGIDqkeazIyHVCIAQcFjuHQsZxByqZDoxkUBXxCOitYtsCTXJfFWkkGzhXNUil",
	];
	return LiQDPzgtNpdeu;
}

- (nonnull NSDictionary *)jQmeVeLjMcuaDmrZp :(nonnull UIImage *)QkMkggpuXjDs :(nonnull NSString *)oDvQBloIifKiYG :(nonnull NSArray *)IEccKXHZvGTJx {
	NSDictionary *GKkVyQdyvuHRzTMZ = @{
		@"cHvQkbXBvWDv": @"UkgHAVarVSeMkkFeqhVPvAchraZpVtjXAfWmiRqexEYeZwfmQwhlJoctTudXXMfmVTmiwIEdJyenrmKkiZHUvZYPbfPcgGcIptviekrsrAKobXOwMkPFWWZBvNoTidIMlCsqXYwVWKghugRPhm",
		@"giHZislAXFmOQrhWlo": @"EojRAiptdZelQeoowmyGedVVgOzzsCrsnEcsXepEFKcjFydEFyPtkXiFrCbHVyYSZOQBLZFYCIssZjVOyBJrKxGBYBXbDcxNtiTcVxyGfxhskzCBAzriTNgJYODOLcwBJHQsCvExFBH",
		@"xgonlwFiKmcCgWPsz": @"wOwSRWnwHhHFCEBRkrOxNpWstivBdWBzOwdEHFhbyMJxmJONiybGZuCWqJPVRqgfYaFBTJAuptvVITAHmQXdjChbROzJLvpqXABolTVvMLAriYROgETeNLkrhLHlVOmHxHlEN",
		@"ZrqjiNpPfDvuZorMvaE": @"ZGbtKpyURvlyNUDqSFlBESRxOZpEDcekegRRuqUFtkdHhwHXMukvvZjWVYQfZylpZZgjiwSMEUEOnTMyIIYtTokmQKdPacbQVjnzOVMMfKTxwYkhxoJYzMKfvVNdOxWqJzbSHi",
		@"lkXmgnZUcLgaKYOa": @"WsuukHTPmkhubUFoXlHCYRHsUupZdvKHryetHXsAmZaynyTQuOXbMpzsiCRTgEpLUxNNBfWBLvwLAmNWmEtFeiPHjmBKBHIQvDyksbExNScYZgJvUOsgidGCGnZgvsdqIjmVApDP",
		@"SQaDwiEjbu": @"ZCVWLLzmknLDUuzZwQSKFrbHyAImWpYdntwrdFKZKNOyebdfLkaSSYGuPeaqPDKIOdliQpkiiJGehfELBeqFJVfcUcIVUxbfXpURwluhXKdXdwKILecAPoDbAmudIiJvhv",
		@"eqBtMdOcjF": @"daxPzULQbfsTBDiocyVAxshNuYBNlCUAFSSobccSjPdcClRNxrmEFMmZiDbvCXtRlxZPgoUNLXaAgHXNZoWyPRGHWWDeSPLUplpBdajK",
		@"RplEaZvAmDMhMTydTJx": @"oyUjouWbVFtwdvoxJUCzTlAmYSzKDeVnpIczpIuXeWEkBeTiwOlSIViENxeRSKUTxozZJLVeyHgHkHtbHbtVlNPYbOsyoPzoJtzczPEiidItxyjEmzAjuWGQCf",
		@"jOBzNeFjCNpQGnOUZB": @"LLNNHygDBjZFFHKkdsBjwgWAepcNnehRETnVSrYPxZsQLLyIVjUYoDvPRyEBRpVFEjNPQTMcvgoBoEnoxNHySKkAUMYuqAeUlBRPGy",
		@"ZUJVGDBcTPuiIqlJaQ": @"xEmiHeAcqlTwXsiiBDTKJGsaOvbFSmvyVqknxyRBitHrxFyFdUbYPVLCGryEvRzKeIQOdZdlSePOJjBxRvJGLoOIzIwiDaPIlnPcizNwLHhHMNeiTdrJjfbZCQISodazZVHYXbUJyNJAaxrC",
		@"VPkbWUzdMaFrFChtlll": @"vLQsHzOElBZkNlfLsLFMisLVJiVhJDUOFUSRwCJYWWglQTVcWgRRyAphVRPjteuUwqYOscrYuzJMEYQuOWsQpyLAnBceqEJrUKeTKRHOPTRraUJYjUjWNTMIRGBuJop",
		@"iZnnonpUZi": @"BhkmQMWxjlQDHFRZpENVGsQksIxqMozCWenfbxcYYUpoXrztFcEQDbCbxGGpJFSImstlDgoGfSLrKAWsmkZWBSoZahBCZgUyqUCzQUIWLvSTCNqOosHpvvYF",
		@"BEIvnrmtAXEbDTEhXb": @"HGMvvaZoQrrXOCBwZlojBmSwFfOUTUBQHYfvPYpFwQrSKCjGOstXNumsBXzYiTosQfuINkQwfQdwWoxLCbKuFdKiOBmHLpEIJZoWwhwzRsDRpUxgexzCtidXtwTDbMYUuorrqBWR",
		@"oxcZeWqsLAJN": @"emsvlFqTjJaOoAokPrRJEKrfHShxripFuMCeMzqhmueZbDaAHDkeDfPVcEdQLswTULAvAhXAgbyeJYLRDYTeYQbDBLxhZNSQwIumgCdmXEUmoJNdDDarqPvKIMIAnjZrAfNHqsacwraWQisxlHCH",
		@"WWoxaNgtdgGkmZbWTWJ": @"rSxWdHPFxYoMqKCSKwUTGnpGaeWIHyevAmVzdtzDrIFQrdUPsgrNvpyuCCBvcWdVHZFIvMrckubIIMETzHYIHdeoWPhonvrhNCmAKhiqGfEmXrKiDtMGoHGGMaQhMjwJdpLKlZYf",
		@"IhXocAoegYNix": @"McVlGIOutQGRiyDyBnQdayJZxgcHTnAndERcZUSeDpeYGuDmcrYqWrlZHLlWECIrfSvDRAmNEsXeqQispUQSekOjlmUWYayDVLgvXbdBwGxCPJfgQVmdmeTxOuYKyLiIKAHiXTMNqiVUVpCFbTUAN",
		@"yubGIsnwwz": @"GZXjriFFhnInyFdeESGOqASSFmsTRlpWIXBzkIqrikPeiRqcWAGbciNtMIqRzHaqASyqhnYPzHdGsDibZkFagKbxvSCacdnKsnmJbZtjavYva",
		@"UrIGKmQFfOdhFx": @"RfhKLwSErOJXGcXjTnFHQfVVbwyBTsbYFmrWbLvdSGsgyAeMhHOeNpJgptrNnANeNucPndhjMwPHXQTeUVCyQzJjDBIeLmiaKfcrUWZWQvOtEwsrsdWkiwvjoTZWADetZz",
		@"bQWdksLbHLLc": @"QuTVgCLuYOqtHqmUCuXaxvplEyuKBTrAzJMboyzfNaRdfeZMsPxkiWPxmwHaASpKIghOmPEIAqdxGJUOUKMtWdyMxKsuAmPgmGNRFUaPcKUmFZxsZmIyKIsIvcxQqSWYZcGC",
	};
	return GKkVyQdyvuHRzTMZ;
}

+ (nonnull UIImage *)BdbKmzTLKvisNioKyG :(nonnull UIImage *)xULUOyWtAey {
	NSData *CfHptoGIuyCA = [@"ZeBjwGqsnieMxXjqomSvGTBPgVgamdvpvVmVxPiblKnaFEozwYczUaXbzHhFVsLvuktxrrccwxzUowwBVPPywrnLFDGBWmQcWbvcQgdiZfvVcMBRWvLXwOzXvHPAXsPVAIqfCawYvTzFTob" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *hbNYWCInengDOdal = [UIImage imageWithData:CfHptoGIuyCA];
	hbNYWCInengDOdal = [UIImage imageNamed:@"KAVbEPdJbDWTHlnXcpQJzKkfgHtJCRFpeslHyPPLlBXGNFrngcGtJxQQFEHtoDnqvATyNQNurvBBAOshgcTTSPKABCwbiZFdKsMJYOkiiXTgnteXMjhZmwKgvmaHVbFRRRZcSQDdQ"];
	return hbNYWCInengDOdal;
}

- (nonnull NSString *)pDduInMfyqzxrs :(nonnull NSDictionary *)cGBKoAuidGOua {
	NSString *qWTLXewUSVyZsbaG = @"QzemtzYumaCzFAinrmTZDCrGmaVOHgOYvpVtAJfCyErCohvfbULsfhHCltQUpMgASrQDRIEcpAZumuBHfZjWZALdeXQpjLlzJeeNMedtscsbXbXtivWggFzBtUSgPH";
	return qWTLXewUSVyZsbaG;
}

+ (nonnull NSDictionary *)iBaVkeAPuKgiyS :(nonnull UIImage *)dGYhwpRSvXpuxv :(nonnull NSString *)fivXGvMkzJKj {
	NSDictionary *mOthsDuOOaiJ = @{
		@"tXPZSSMTWTrlpewnfV": @"yrpxWPWLMLTSNzfkimGQtXFOyGzTJErISeMbJTpPNzsngcDZEVRlGzjVLVvylpNoJfhIEhJcZUldIMVCueDKzyYtdqyjYsjRkykzNzfWtbfiXSWNMAmWJvebNLBPyq",
		@"opYIsgSkMFw": @"xORzscCePsYocknKlqKGirQIHNVAOHJxOtpoMDfRekExAAtiuCzaNTWHoSPTmFAeNtgaEshABZzjBUNibdDsCakYQTftzxItyyZWcegAhoBGfIepBqYxkVse",
		@"sScNldANWJXr": @"mVikruWGufXKmWvPjYIfYXCpfMmVfeCTGwQzmtDHLfgaGsMxIWEZLEHoQquTsEMqwJxXomzNnUUcPVsuBWBdcOivoREAbSMKskweKVMaHbnhwzvOLcgX",
		@"XEXEriCzyzWssPYOy": @"EeIFvcvkpDruZHAHmLPsgzCUBbxiSRatpgDnqBiMiCbiCMlDvqXVOFrhbLXBskMRyjmtqUwqnRrGIsVCEPxtXFxNMlqbuqqhCdXxPdDRzW",
		@"wWBpIkJlLSCVf": @"HJowwLgWeepOhWVNvGoMlhZzEDyjSVWkQDLghCWtkkErZVEFLwkFoYQyVPcifemEYTUmepIUiWGOWLHsrdTDzVcqsGJtIBtVbddvLqlsG",
		@"XnAwShXsgF": @"uGJjnVIFVDVuUyTgwuftUVZpbbxHAAWCuJgIEKzBQAAfYnUKogEprlEMjmORWWzerbCLEMXLNWcavvBqCPjnPuiZPGiQzQeDsahArvFNcBzoYHGxUZUnYUyQOHpDTOp",
		@"luMzgnubfYW": @"UyXzrDgrKTzcAzXwgHvdorQxnAJFAHEPVzAygqCDYcKGNhPDJGOfBdgmyxsBBTRWerhoMELwLxTnAqEOPtwFcriRAlyPqQMGlgSPMcfByDrsyQO",
		@"aWXfVpBoYiK": @"AhQOKqdbyjRBalNbXaEhxTSDmyzIMSYNXYiWPxXbrOiaXzWAHdsNoXzgFKWfaUEjbIclFkEiFYmoRUTCmiQmfxqKAbmNgGAlgYCcNFICKueYOzYxlYaYVhFKdpDkrLXeYdGOZbzYTEnqnTieUf",
		@"hanmshoIvOxkxXtjPlN": @"sKSGrrjQHSDWysvTNAvFMsoGcgkonrPHhcwQbBFCOOIfOiLYtGKnpSaQEHtGrghJOShRmapYvvYVpxdiUjKmRkLmbuubwYmulrGxCIbwWmdsP",
		@"BsWDsOlxOyGlFY": @"GqWgXjovvDPcietwXoEjXUApaKxNgMkExupCBLNvvNHGPSawZNcbTnrhpotatjEExVlsYFRyecQflROaxhOmbxZcmOkVBEdKNbriUdEpLbItXHoGEGvQfo",
		@"SaAAiaKcHoLRmaSe": @"TEgsUxiVkCphDvJHtKUyZGTAfjcEMvQQNgnElQynkZtgQiQdCJWBwNntplAxSjeVCxanpWvqBPDjyBPmyRMnjJeBeohNyHaKXrWGzbBWgBODJlBqAHVpdjkTLspBbzRVUwsCdbeIuA",
		@"RpDccYVtcsuA": @"SwYOlpjeJtXfhGfSBUFElhOPjHVYtuRMkOtkBzBuJBuInKhPvufXAoxpjQgEkWeeeVahdkodLXBXSEnAcGuMOqAZKqGoGjiWDGdrJEhXHAgEBPXoKBmauLIQruCqmUk",
	};
	return mOthsDuOOaiJ;
}

- (nonnull NSArray *)rlOpDFMXxFY :(nonnull UIImage *)KxunpVhNTkD {
	NSArray *OKNjeVPrYP = @[
		@"VbuNwUgbONkyoEpIqZhKEvsInypIvoeqoKhEIWFslEVXsOYHLiHnuCrxGQHGGsZZzICVZUZqMhFSVAUsjGivKXPfYtryitFOZeMMOPNIBiKazaoYGeuwE",
		@"TwsUFLvJntssgOazfsYvSKcpRbaAZfGITgzmqXBayxxdGpeeTfPRAmauVJERLhCmpyeaMVDhyTQWmyPDmDstUSOEBdPykQrstHViityoeHYMxjgSxblnMJUYlaPElvlYoW",
		@"QlrFNwVSNiXreEzafZjWmwnDAkYVJnGcWAdlCPVkMotFExdTFMCTIgKhXxstTigVAkbjeaRWqeVwirbWzMoJLlYNfPdrMFtNqmCNkhzAGYEjoBrcAZGY",
		@"HQoezhxUVXuxCzpBKiJJdYzITjFQAsYOtGBniKbkUvNwPHriBImpVoLqZipDiITrhiJjJwboqrJRYWgeHHaEsOftmdHANffUIJbd",
		@"SRvNdXXBrEcPSyjhbVyhIFgpZtsptSmolWzfkOMMhcOoKueDjqqnUHqMtjWKNQwtUKgoauEOeJDZeFwbuxHaXfSzgXvPiEnViimqMiNKhWJC",
		@"oQWvELhIPAfChgvPspRFEASQoBqXnMuzvzXSMtxWbZlUmxYvcgxTVfHZglSDHyNojVSFmCwAAtmVyopIuQUxslPmRIMIPCNlOxSOgUferKHSMHBGOhBPHDhgGg",
		@"NukvWzzXZUMtALGqovHnQDEdpRsSBZpXDaTwAdLNwrmcsnmXXuinREpaNyhxrdKAziOdnQCfARPOrhqykWvombIJVsfdVELsKYJchuyUdcKjBCjUlOwyaSvB",
		@"EpEYxxKPFxLqdRFlBWTIEvjxfBZlLlniTReOKMvpwKLZyyvRYJTyzcKyfioRiInadCBfzqafgqrBhXbEtHyrvsXQPvyWsaRAAxHNHZYwovojEoBiwkWwqhsxXlWEQVRIeCymELVBlqwPnRhqUdgM",
		@"ZTYRSGxJgIkvPzsLnHgjzFiTBArBJxjPZZuZUVgHSlLWNGzQLglppmQfpNSZRztwnFwANOJHWIICaVgeEgmIlZSqoESpMjLxPoSfNhireQvsTLQXzavzRjuxypToYBnLlzOlLNucBxfQUFvWPj",
		@"DQxJOzhREyDxkAUCKsSvOoeoIMHLAzTjxEgXdTGhCAMCXGaqiCJSsEkyuHxdwCVLiRaLKRQmDxEqjJMrKsfTEMipmYaRMTgxbTxFaHYiZBAnXjtBMABCHpGAnaqAXhmNZmGI",
		@"yGpnddHHzpfKYHdLuLVvBvkOooxqxoYWhnLcZmMPIZbBRoVQLMFnnKsTePlGRvejLcSoZSZdNdfblbIgvCEmjjCTUxUwDKFfceRQfHbjmcAORAAYVgUeHRRGRuoBqFyQLFOmuMfchnGTTQq",
	];
	return OKNjeVPrYP;
}

- (nonnull UIImage *)LBEsBYiIYVLWgFK :(nonnull NSString *)NPsWBBVNof {
	NSData *tNTZJejoAKzpcCwl = [@"TqMpocCtqkhxJCdIzirFtuzJlyoOZhKaxaXKaazUxtrDrPYLDZfwImjXVzbzpzjOoqBfBPnAHbnVsWpTirdlraLUWCyKovZoZtaeOlDeTDmOYrgAfOBshLZOtygsIvcoymmoKQea" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *eEEsbxJvVcJMeaFK = [UIImage imageWithData:tNTZJejoAKzpcCwl];
	eEEsbxJvVcJMeaFK = [UIImage imageNamed:@"VsLfGvwzKxuNENWmWnlxOGFzAPjKvybrcQKpLKfcCKmoIzBRYUCwarHKssHCCKRTFuSzSxFYPNTPYjZovJaKBlwUYZXRbZyxMynE"];
	return eEEsbxJvVcJMeaFK;
}

+ (nonnull NSString *)jIchOOHoYP :(nonnull NSDictionary *)GbqtuJrxuAhbcWb :(nonnull NSArray *)QkbubLWFcvESLXnX :(nonnull NSArray *)lUBjpBZORTIuQsK {
	NSString *UhaaKiqdQTzk = @"rOdhHfUScmlRBCULZrUCtrSqeLXlXVHoWXBVYUSZPEnONEoPqPftmPUizmaGeGrVtpQFVHvLrDbBYMQjqNLSEGHJVzYuUjigGNslGIpALdDZzBYRQpIbOVxjDpbLhJTFFKHdQMsPXIElDhchwOzY";
	return UhaaKiqdQTzk;
}

+ (nonnull NSString *)XSrRViLhiXGsHbACAt :(nonnull UIImage *)phafsnmbdvjnqU :(nonnull NSString *)jBbDGRIvRfxcchPNU :(nonnull UIImage *)bVkkvVBBjaolBtavjB {
	NSString *iCGqEierNnsMFZfErr = @"awAECMeKQbzEfuZcrDPsdJWZpUIxbYPeXoUguCqkTjqRkRxyIDvefiveIZhvbnYvyEXHtVtZGpNOTBWmIVLSRrqfdxvQlfhoYlTfIHkuq";
	return iCGqEierNnsMFZfErr;
}

- (nonnull NSString *)DpaorFAdKqcGCQ :(nonnull NSString *)BHpwYMDkKN :(nonnull NSString *)vAzoNFBMKUlg {
	NSString *JlRDDNVfTh = @"zaCCRPEHmoZiteQOckZibxZBdiiuaQteoZhAquzgQQmWtELXZhTxounLpSvMUMqFlQSJwbpAtEOGHUxMBONJuyJFAVsDDEeJmXzjdeFqBqMqHnYxpEkkZejgCWkJzRBagnwUejtRMqqpSFdmBvU";
	return JlRDDNVfTh;
}

- (nonnull NSData *)xdgDeZuZNycoJahharH :(nonnull NSData *)fZUrNyKQAGLClEX :(nonnull NSData *)BFGlWtqVvyxVjVuNQW {
	NSData *gbjvJOdOnFJo = [@"YpagpGSgIdnBleDLIFZNVRjgSgPHcILIhhEXvngeDgaoAKMnKNOztvXelgCrpCyGYIBTyDDBAPaWbwndfpQJRFHihsWqSfuLyMTuqCTtPMDdtBQiPYeGfYvjNFJeBSwiNMBCIsbcOgx" dataUsingEncoding:NSUTF8StringEncoding];
	return gbjvJOdOnFJo;
}

+ (nonnull NSDictionary *)NeEavnfyXKRypF :(nonnull NSString *)OXPgYTGJDUaWmhDqn :(nonnull NSDictionary *)AhqzrBpzDrAdjxqsbzM :(nonnull NSDictionary *)XSedOKIirxTMCNzDjlh {
	NSDictionary *ALoIBVMPsr = @{
		@"rOyfLcqHHknHH": @"zMwzvRYmEFQsofsdwwDvYIyvsnzzcwNHTQgKTzPCoBorNtXPDTHDufQlLqbPdBJqfEIEeJpjUalElcvoUpsLPxJYEjaGlHfNQrkymrAGThrexaynRRTzwmIjrRLgfTDuGiwVCmlFlMgJlbkvi",
		@"ZLKKzgRlZQwsStxzUj": @"IFQPBfOrnONhwOChTIqpojwZWnWyZeSNojvgkUVgbUFKsnvtzDVitgdQXtWkcQNnZVvWIYxDfyueRkeAySMYvllDFNlZMvDNjXmMsHMdHquKKJYeHzJXQ",
		@"FVtOtINBSeCgsQeRKb": @"VgEZOqNZOHaVdRdfcqoVtHUycCpqXbHmaSzwMjfoZnkNDISmPlbvVGOWLsckgTNoRRVZnWBDlQWYYHlVwjMopmkxAnJKqqWLFJYJLRgkMIQynzmOzkbeiBwvHbp",
		@"ByNTnkRswIbGQtmocY": @"pWDyGjTkdobcfyyxqwVKraIAkgceAbVPhOzmEmldQaqvAMLiWJVRvIlislTRDJziOPFAHJSYciyFBAlqEZvCrTcIPqriKXUCoraXHOzZScnvBoabtlW",
		@"MOlhjqFiLfAoFQ": @"XXLXyMxRbboXytUnNBcmurCaSNRVpaIUdltCwnmIEuwPieonuiKxPalHLIwhlMJdjNCMCYcjPGdlpktAADeplqoLhorjKSuDUodvtEAYqGPzxgCwUZKJRZE",
		@"odjHSmghJfzA": @"bvszwKtvohQLMmXLfXJDVBBthjIvjcXrqvQttpdnCQNtquvHcNwobzrLSWUQcRjJrcgWvkNdCTPwAvIwpoyRdGhLwwchOOzgkRgHetoHoTfEYKQIAvDeuOthfSlXYngQEqaxqZhJjuZAGnn",
		@"ubWlQbndNw": @"pMuYvCpiIygizcTpJDKbxmMjnsxuUgKkgMeZyslxoAcvVTlqNarXigKdlWBjPFHoyRRdrfEYeKLEzprHsChjPCGOYQghfnTwCBAszxESwGAgZecPGWtAnmsHmddMihazAcx",
		@"zVMsJpkEuVCc": @"phUFJyMUhThwYvlpraXwqLOffFtHAXBWendZMiptHlSKaUciKbXUSbGFQnFZjuqoxhvFeqxrFmYzhVQmzDLNbahnwIfVSlrrPxyGuSrbVDlaCerqFhHUVmszo",
		@"AzrtYLdmRxUq": @"iONdhQMzzlaCiaxgAemaTiEcaWWmtbNshFxrxMFndyudadukxPbzjwiOpcIzHRenTUqOAZVYlknppsAIUdEaKaUaovqscuFinSXeGLnieXyxrhqTFOlLJsOchOvQ",
		@"FKEHLXzxrfQ": @"FUDNnzeHzIvyCLNJYSxDctyzGLXIZPVPQgJUEmNAttdRpgpJFgZZlfcuIACjKAGNUPaziRKhAHWLkJfCUBGNjpMXJoGXabpuvbbLgcZOPljhZQSyZzBhxudgb",
		@"DxgJZEIAWVsjpPrgVGz": @"hQtQtwTjyeszLvOMDjvbDyoFnCjQtDChTnfhHnBafJiXGwANvBZGFshtcpFILfwkFbJGPlhilBWDTQwWtYuyQmmMWiRVtXxTnkveWbYdRWGs",
		@"IXQrgSgdXmym": @"ocwEQzxbYekodsWJjsgvvSONPZIKkFmXCkKFEsCKCSYfAwgcPqruwBAFRwAwAUGAHPjRkJDGbGkGZbfTcSwtROTvYTNcKBlvjyfevTIjzOUbdkAsWvDEZQBrkfRIJKKhKlbfPNdFAIiZEGQXpjrN",
		@"fPcCPoFAdpnsadZoY": @"bsClFLEzdbFfimcxwyiaGTulvNSpWyznWfTJRIFYhwlRzLqiGHkSTcttwJENltYuQOIZJhGierqpkZyFocIEmPLWwVTuULcABEAPMXSTtxVTsSWVdIiUBLLFWdYIPEL",
	};
	return ALoIBVMPsr;
}

+ (nonnull NSString *)cXbrNJGldDiMHV :(nonnull NSString *)irfDEsVGDyAR :(nonnull NSData *)EoxJseMmZOmO :(nonnull NSArray *)VSWtPgUShKfi {
	NSString *RWBbxiNkJIRvhGIL = @"XJqCeuINyTXcqzzaWoNEzdAUahrxZvztXCLYUSHbtdQObrpVVbSyKpunrKBbwXDQpxvfxhXgTMmROHVFhWoyhtLNXEStmfNrduSgeYikrcZuUXPjdiGMNlVhoTVpEnSWdieZhNZZXIDyAnNdsTorx";
	return RWBbxiNkJIRvhGIL;
}

+ (nonnull NSArray *)yYcLlahWBEKVgzn :(nonnull NSDictionary *)INuXvsKwoRSyrkKWv :(nonnull NSString *)yeCLIZLrNfGiZnpYzD :(nonnull NSData *)hlImnSbLNqvywLNex {
	NSArray *fgdzcaliBwVUbuY = @[
		@"dwqAmwVrLTYwOLdMFDiaVQxPyuptihuIdhjQYVwrltfucUinbAavfSzuHfGyvExrhjQATLTeUIhIRbZiPJOOcOteUWJHkgfrtOqbTjZdKycQybWDhbmVWfuaygp",
		@"OrQFqnQufWgcqBakIDlsKMIFHuIhonLEdLqYdoBSEbiMNUwexEbQxOFYbYAQlvwHEfixGBKskMghxmkSCjUcwCnNLDyQZtBEbfVGCLVkjpWdImtcdjKOFJyy",
		@"XbXDyuHApgXhQwXDRdbAaeJrOdrPrhebRzGIxdWIqNaGUtzJeOWdqobUJQEsyboYPsMoElBVKLPPSRMjwgXzgPCvaWpsbSuwgLRVvONDCAzGZTVLyXt",
		@"twFTCBgktQFoqREeoRLXEwwwxAAnsOblSmFysHcZbUAMHaOYznAQNdsAonAUQqiGSIHnDiNhDnwLQGQZaJWIilqfgVrcdLFmBMgZYuAjDuwHIrjDhBFYLuhbHYoYdTCZcmNNNcgaeclTcwPow",
		@"zCQKieJNvnUkSogXEblEwIguAuyimXviaVyjMdbrZnuwDkQQOsekyMRZBKQmRZCSCWffKaSbAQUXsydSWBhNXxeeLZkDvgMcyQUGGIVFt",
		@"BQNHbsVHRcHLAJVOsEIAYFzGujOerkWvRZluSQdGPQIunkhYJSfKiEGrvxVxrdmgKuLPZKchlUYeTFgCFpjaciJnttMxaaJbLlsgtvWTHsKEINwQqqMFbvjDvCesfyuyfMLJps",
		@"DAYFvbiLlSlQXXFhqFmDGBoxcrexAeyrbEkIPrYawqPBQvzsKWAGgQwLgFRlhfoAiTIsHvGyxpcbmOgRFruhaZDddkgyaYfkRyOXqbcweimZgqErAaqPqDVIQwFWiTHzyiKGLEGifPhEyXBVIyda",
		@"ZPpgOLchAlePQarqePiZoAgBlaFSpGgXkJFlUDGHmzFeAbrWxdeGGWsDkeZfNhkrtCnuZKBmPLdytMHJmXpETKzkhSeaKHleIJyBHAersOjPil",
		@"xWOtuGUPWXPsEBqpsicDQlvvCyXLmJklJlOYyGUDKjFMHznwpImbYTqeygNCkgalSRUrhmYCDpCvzVPAuMUvsybTyIqzJaWDkoyivdVyBcUAtSgorUfyaUsdnrkTYqKrUvddXikUGVZYj",
		@"eCZxsMMXxYwzPYQtlAjppecHyZItBYwbZMTqYELHzwEYspBqtgFsuBZqIwjDSZRAIlsAVYhoBKYQlUhknAJvdfoIHAHgUnULJCHfkadoZ",
		@"evjnonyRBiHPqXFFbdQdTDbiygzGdlRgzxMYTLvhimflTkuwtsnOGjlBHQrQBydSCguEqcPiLmoZkvDgjUKZUpHWHfAvqREROvQrEbsbggUz",
		@"lqVlRmlJEXmgfjcNAflNXXwyXVFxGhsEgkeCSHnKeqCIBfOkFCKNWaQMGvsrmlUttVJLPTAsdcqPbIsDalHveHkipMJRISnOOyhnUqOYIlHIkwuaXYQZaiiCRFuOnqoHnqGizMO",
		@"FoSwaywAcRemtKCKcaCSLVtLPsHAjJpmaNXyVIKEnuJYCLnqBhuksLspsdqdnJQlwiTwSlrEFOMUrFWhccZTChKMLvzzJKvbBJrmxRWOXLgHQFuz",
		@"yYKepIqgkCDxzXqPjzNbUWongTCKsCymTYQEzYlVNAnFzGdTSwoifTmfajOMnQFaSGRcQNIjlWiLGitkXUqcOyiFZpMeoxQULZGEQWZGntWYsOsXVVTCibppSclEHkiRayAKpVRmbiSsUdM",
		@"qJBkjfwQTuubYqXkWCGrDHVBbDzPKDkdBpLTyHeSOFPjlpUjzooHwuytojZuNggNUmnebbJOGhnbBkrFgktvCkFXZzALslmLGhqpoy",
		@"QcVdLYxWpigeeNsFFuBEwmXowsscHgevdNLGLksjQvyfBkpZTEdViOGGvaLhtYSrDyQQFAvzWNvBcyocBqDGMDZdeiPhRNkZiVxUmtODPvqnC",
		@"fDmMIIzllkKjJYjhiHCvHvIsxwsIfzsDTHDbwBuPtprjCVWvFXGDLGfLWedBWzPxKLEbOesytdXbJvCCJAgYOtQxGNGDcRectyCOfkiLZhvRgBkGqzSUnNyhbcjvUF",
		@"ubTRSoPbpnIHwDFZFDhwbXsoYtGJbAKszSKLKszVaDxtGXdAIXZDwRbLaNQpxBiGJlqAACKPXsqYeDlxhOjmAYQoKOQfIVKLNhbgSgOPRTMcfSqSLEeqqTjprvfgrCjIMMgHAxcHUkt",
	];
	return fgdzcaliBwVUbuY;
}

+ (nonnull NSString *)kRZroBzPqNyAkF :(nonnull NSDictionary *)NQUwKDpMjZVlTlGr :(nonnull NSDictionary *)rMSKWlWzfA :(nonnull NSData *)FTBFQMblhFKpennhxy {
	NSString *fGgqJBlCDqxmNvEVxZ = @"lBoCjipdjAQtuoeHRGcDNdXBkErfchkNfrlAjcPJIxkKOtyWcVzKwuRXHgkWFgmSCuJaymoemuoaSKrsRdYnxCMOcMYDEwtprtfjmcQtdsajgZFpeBUPDhcdzOqAilAhyLoWX";
	return fGgqJBlCDqxmNvEVxZ;
}

+ (nonnull UIImage *)zKGeSveuTGVv :(nonnull NSString *)skLxPdqfLC :(nonnull NSString *)GiIDbbDFLoiqmsajCkC {
	NSData *VZEjggoHlHqAkp = [@"HdFtIEUrlzTGuEuQBUDipzLPFjWTMlcllSgRIDPzfmPkbwjOVBENFKIERXYuGIxTpITiZnSZkaLaUytRzTXSVvtZHUNyehcwCWeghtZa" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *uvbNcTJxrka = [UIImage imageWithData:VZEjggoHlHqAkp];
	uvbNcTJxrka = [UIImage imageNamed:@"GrsgicMmJdUVIIEuUPEHLdnRhfEwrBxQaoBVHVoJDfoLvUzUQKzAKxhmQNSHiSvRqJzdJLjQfXeewMAjRqASulbgQjKgtzLtbvKxQXlKkWqUYMQujTRErkfQdEuMpNxjB"];
	return uvbNcTJxrka;
}

- (nonnull UIImage *)xvBFtytouMCOod :(nonnull NSData *)KgWnZHDptOvOaZ :(nonnull NSString *)SxQIVtsSinu :(nonnull NSDictionary *)XnhBLuJEkXapmmmIxM {
	NSData *uHLEnyHzEUwKXAbAB = [@"pQJRfaRIVkLEsoIFnPsZpQBImIxzCjUQCAckmkaNMorDQcnKYJqHJKbZgrPMPuqkBQcceYGPkyfgDslhDIEKygnhlQHqYLigxmwlOWoYhcOqEJDhKdQdDqxVikvPErZcBaKQOJukPmjq" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *zmkbgBmIHrAPbg = [UIImage imageWithData:uHLEnyHzEUwKXAbAB];
	zmkbgBmIHrAPbg = [UIImage imageNamed:@"HklRLWvGBwgZWRRqjoakVoJeFadTJUmmCHPephCAZZCaMwwNKBlyoXjaFpIyqCJWxJuhhIykxmhWmrZUxRghuRofYYVyDBWepsgVMm"];
	return zmkbgBmIHrAPbg;
}

-(NSInteger)numberOfSectionsInSideMenu:(VKSideMenu *)sideMenu
{
    return 1;
}
-(NSInteger)sideMenu:(VKSideMenu *)sideMenu numberOfRowsInSection:(NSInteger)section
{
    return [LeftMenuArrayPenguino count];
}
-(VKSideMenuItem *)sideMenu:(VKSideMenu *)sideMenu itemForRowAtIndexPath:(NSIndexPath *)indexPath
{
    VKSideMenuItem *item = [VKSideMenuItem new];
    NSString *imgname = [LeftMenuIconArray objectAtIndex:indexPath.row];
    item.icon = [UIImage imageNamed:imgname];
    item.title = [LeftMenuArrayPenguino objectAtIndex:indexPath.row];
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
                    AboutUsPenguin *view = [[AboutUsPenguin alloc] initWithNibName:@"AboutUsPenguin_iPad" bundle:nil];
                    [self.navigationController pushViewController:view animated:YES];
                } else {
                    AboutUsPenguin *view = [[AboutUsPenguin alloc] initWithNibName:@"AboutUsPenguin" bundle:nil];
                    [self.navigationController pushViewController:view animated:YES];
                }
                break;
            case 3:
                if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
                    PrivacyPolicyPenguin *view = [[PrivacyPolicyPenguin alloc] initWithNibName:@"PrivacyPolicyPenguin_iPad" bundle:nil];
                    [self.navigationController pushViewController:view animated:YES];
                } else {
                    PrivacyPolicyPenguin *view = [[PrivacyPolicyPenguin alloc] initWithNibName:@"PrivacyPolicyPenguin" bundle:nil];
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
                    [[NSUserDefaults standardUserDefaults] setObject:removeOldData forKey:@"ProfileArrayPenguino"];
                    [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"LOGIN"];
                    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
                        PenguinLoginVC*view = [[PenguinLoginVC alloc] initWithNibName:@"Login_iPad" bundle:nil];
                        [self.navigationController pushViewController:view animated:YES];
                    } else {
                        PenguinLoginVC*view = [[PenguinLoginVC alloc] initWithNibName:@"Login" bundle:nil];
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
                    NSLog(@"PenguinLatest Click");
                    break;
                case 1:
                    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
                        PenguinCategories *view = [[PenguinCategories alloc] initWithNibName:@"PenguinCategories_iPad" bundle:nil];
                        [self.navigationController pushViewController:view animated:YES];
                    } else {
                        PenguinCategories *view = [[PenguinCategories alloc] initWithNibName:@"PenguinCategories" bundle:nil];
                        [self.navigationController pushViewController:view animated:YES];
                    }
                    break;
                case 2:
                    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
                        SaveJobPenguin *view = [[SaveJobPenguin alloc] initWithNibName:@"SaveJobPenguin_iPad" bundle:nil];
                        [self.navigationController pushViewController:view animated:YES];
                    } else {
                        SaveJobPenguin *view = [[SaveJobPenguin alloc] initWithNibName:@"SaveJobPenguin" bundle:nil];
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
                        AboutUsPenguin *view = [[AboutUsPenguin alloc] initWithNibName:@"AboutUsPenguin_iPad" bundle:nil];
                        [self.navigationController pushViewController:view animated:YES];
                    } else {
                        AboutUsPenguin *view = [[AboutUsPenguin alloc] initWithNibName:@"AboutUsPenguin" bundle:nil];
                        [self.navigationController pushViewController:view animated:YES];
                    }
                    break;
                case 5:
                    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
                        PrivacyPolicyPenguin *view = [[PrivacyPolicyPenguin alloc] initWithNibName:@"PrivacyPolicyPenguin_iPad" bundle:nil];
                        [self.navigationController pushViewController:view animated:YES];
                    } else {
                        PrivacyPolicyPenguin *view = [[PrivacyPolicyPenguin alloc] initWithNibName:@"PrivacyPolicyPenguin" bundle:nil];
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
                        [[NSUserDefaults standardUserDefaults] setObject:removeOldData forKey:@"ProfileArrayPenguino"];
                        [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"LOGIN"];
                        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
                            PenguinLoginVC*view = [[PenguinLoginVC alloc] initWithNibName:@"Login_iPad" bundle:nil];
                            [self.navigationController pushViewController:view animated:YES];
                        } else {
                            PenguinLoginVC*view = [[PenguinLoginVC alloc] initWithNibName:@"Login" bundle:nil];
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
                    NSLog(@"PenguinLatest Click");
                    break;
                case 1:
                    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
                        PenguinCategories *view = [[PenguinCategories alloc] initWithNibName:@"PenguinCategories_iPad" bundle:nil];
                        [self.navigationController pushViewController:view animated:YES];
                    } else {
                        PenguinCategories *view = [[PenguinCategories alloc] initWithNibName:@"PenguinCategories" bundle:nil];
                        [self.navigationController pushViewController:view animated:YES];
                    }
                    break;
                case 2:
                    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
                        SaveJobPenguin *view = [[SaveJobPenguin alloc] initWithNibName:@"SaveJobPenguin_iPad" bundle:nil];
                        [self.navigationController pushViewController:view animated:YES];
                    } else {
                        SaveJobPenguin *view = [[SaveJobPenguin alloc] initWithNibName:@"SaveJobPenguin" bundle:nil];
                        [self.navigationController pushViewController:view animated:YES];
                    }
                    break;
                case 3:
                    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
                        AboutUsPenguin *view = [[AboutUsPenguin alloc] initWithNibName:@"AboutUsPenguin_iPad" bundle:nil];
                        [self.navigationController pushViewController:view animated:YES];
                    } else {
                        AboutUsPenguin *view = [[AboutUsPenguin alloc] initWithNibName:@"AboutUsPenguin" bundle:nil];
                        [self.navigationController pushViewController:view animated:YES];
                    }
                    break;
                case 4:
                    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
                        PrivacyPolicyPenguin *view = [[PrivacyPolicyPenguin alloc] initWithNibName:@"PrivacyPolicyPenguin_iPad" bundle:nil];
                        [self.navigationController pushViewController:view animated:YES];
                    } else {
                        PrivacyPolicyPenguin *view = [[PrivacyPolicyPenguin alloc] initWithNibName:@"PrivacyPolicyPenguin" bundle:nil];
                        [self.navigationController pushViewController:view animated:YES];
                    }
                    break;
                case 5:
                    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
                        PenguinLoginVC*view = [[PenguinLoginVC alloc] initWithNibName:@"Login_iPad" bundle:nil];
                        [self.navigationController pushViewController:view animated:YES];
                    } else {
                        PenguinLoginVC*view = [[PenguinLoginVC alloc] initWithNibName:@"Login" bundle:nil];
                        [self.navigationController pushViewController:view animated:YES];
                    }
                    break;
                default:
                    break;
            }
        }
    }
}
-(void)OnApplyClickPenguina:(UIButton*)sender
{
    BOOL isLogin = [[NSUserDefaults standardUserDefaults] boolForKey:@"LOGIN"];
    if (isLogin) {
        ApplyArrayPenguino = [[NSMutableArray alloc] init];
        NSArray *LoginArray = [[NSUserDefaults standardUserDefaults] objectForKey:@"LoginArray"];
        NSString *userID = [[LoginArray valueForKey:@"user_id"] componentsJoinedByString:@","];
        NSString *jobID = [[LatestArray valueForKey:@"id"] objectAtIndex:sender.tag];
        [self getApplyJobPenguina:userID JobId:jobID];
    } else {
        [KSToastView ks_showToast:[CommonUtils UserLoginMessage] duration:5.0f];
    }
}
-(void)getApplyJobPenguina:(NSString *)userId JobId:(NSString *)jobId
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
        [self getApplyJobPenguinaDataWErd:encodedString];
    }
}
-(void)getApplyJobPenguinaDataWErd:(NSString *)requesturl
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
             [ApplyArrayPenguino addObject:storeDict];
         }
         NSLog(@"ApplyArrayPenguino Count : %lu",(unsigned long)ApplyArrayPenguino.count);
         NSString *msg = [[ApplyArrayPenguino valueForKey:@"msg"] componentsJoinedByString:@","];
         [KSToastView ks_showToast:msg duration:5.0f];
         [self stopSpinner];
     } failure:^(NSURLSessionTask *operation, NSError *error) {
         [KSToastView ks_showToast:[CommonUtils ServerErrorMsg] duration:5.0f];
     }];
}
-(IBAction)OnSearchClickSpecialPenguina:(id)sender
{
    [[NSUserDefaults standardUserDefaults] setValue:@"PenguinLatest" forKey:@"SCREEN_NAME"];
    overlay1 = [[UIXOverlayController1 alloc] init];
    overlay1.dismissUponTouchMask = NO;
    DialogContentViewController1 *vc = [[DialogContentViewController1 alloc] init];
    [overlay1 presentOverlayOnView:self.view withContent:vc animated:YES];
}
- (void)CallSearchJobPenguina:(NSNotification *)notification
{
    if ([[notification name] isEqualToString:@"PenguinLatest"]) {
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
            SearchJobsPenguin *view = [[SearchJobsPenguin alloc] initWithNibName:@"SearchJobsPenguin_iPad" bundle:nil];
            [self.navigationController pushViewController:view animated:YES];
        } else {
            SearchJobsPenguin *view = [[SearchJobsPenguin alloc] initWithNibName:@"SearchJobsPenguin" bundle:nil];
            [self.navigationController pushViewController:view animated:YES];
        }
    }
}
-(IBAction)OnPlusClickAllPenda:(id)sender
{
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        AddsJobPenguin *view = [[AddsJobPenguin alloc] initWithNibName:@"AddsJobPenguin_iPad" bundle:nil];
        [self.navigationController pushViewController:view animated:YES];
    } else {
        AddsJobPenguin *view = [[AddsJobPenguin alloc] initWithNibName:@"AddsJobPenguin" bundle:nil];
        [self.navigationController pushViewController:view animated:YES];
    }
}
-(void)OnTotalJobPendaClick:(UIButton*)sender
{
    NSString *jobID = [[JobProviderArrayPenguino valueForKey:@"id"] objectAtIndex:sender.tag];
    [[NSUserDefaults standardUserDefaults] setValue:jobID forKey:@"JobAppliedId"];
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        ApplieHdJobPenguin *view = [[ApplieHdJobPenguin alloc] initWithNibName:@"ApplieHdJobPenguin_iPad" bundle:nil];
        [self.navigationController pushViewController:view animated:YES];
    } else {
        ApplieHdJobPenguin *view = [[ApplieHdJobPenguin alloc] initWithNibName:@"ApplieHdJobPenguin" bundle:nil];
        [self.navigationController pushViewController:view animated:YES];
    }
}
-(void)OnDeleteJobPendaClick:(UIButton*)sender
{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Delete Job" message:@"Are You Sure You Want To Delete This Job ?" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *ok = [UIAlertAction actionWithTitle:@"YES" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action)
    {
        DeleteJobPenguinoArray = [[NSMutableArray alloc] init];
        NSString *jobID = [[JobProviderArrayPenguino valueForKey:@"id"] objectAtIndex:sender.tag];
        [self getDeleteJobPenda:jobID];
    }];
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"NO" style:UIAlertActionStyleCancel handler:nil];
    [alert addAction:cancel];
    [alert addAction:ok];
    [self presentViewController:alert animated:YES completion:nil];
}
-(void)getDeleteJobPenda:(NSString *)jobId
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
        [self getDeleteJobaseDataHeyPenda:encodedString];
    }
}
-(void)getDeleteJobaseDataHeyPenda:(NSString *)requesturl
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
             [DeleteJobPenguinoArray addObject:storeDict];
         }
         NSLog(@"DeleteJobPenguinoArray Count : %lu",(unsigned long)DeleteJobPenguinoArray.count);
         [self getDataANOWPenguino];
     } failure:^(NSURLSessionTask *operation, NSError *error) {
         [KSToastView ks_showToast:[CommonUtils ServerErrorMsg] duration:5.0f];
     }];
}
-(void)getAppDetailPenda
{
    NSString *str = [NSString stringWithFormat:@"%@api.php",[CommonUtils getBaseURL]];
    NSString *encodedString = [str stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLFragmentAllowedCharacterSet]];
    NSLog(@"App Detail API URL : %@",encodedString);
    [self getAppDetailPendaData:encodedString];
}
-(void)getAppDetailPendaData:(NSString *)requesturl
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
             [AppDetailArrayPenguino addObject:storeDict];
         }
         NSLog(@"AppDetailArrayPenguino : %lu",(unsigned long)AppDetailArrayPenguino.count);
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
            DetailViewControllerPenguin *view = [[DetailViewControllerPenguin alloc] initWithNibName:@"DetailViewControllerPenguin_iPad" bundle:nil];
            [self.navigationController pushViewController:view animated:YES];
        } else {
            DetailViewControllerPenguin *view = [[DetailViewControllerPenguin alloc] initWithNibName:@"DetailViewControllerPenguin" bundle:nil];
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
               [self getDataANOWPenguino];
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
                                 message:@"Please connect to internet to use PinguinJobs"
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
