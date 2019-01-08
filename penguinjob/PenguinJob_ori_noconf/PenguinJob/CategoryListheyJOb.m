#import "CategoryListheyJOb.h"
@interface CategoryListheyJOb ()
@end
@implementation CategoryListheyJOb
@synthesize lblcatname;
@synthesize myCollectionView;
@synthesize CatListArray,ApplyArray;
@synthesize lblnodatafound;
- (void)viewDidLoad
{
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(CallSearchJob:) name:@"CategoryListheyJOb" object:nil];
    lblcatname.text = [[NSUserDefaults standardUserDefaults] valueForKey:@"CATEGORY_NAME"];
    CatListArray = [[NSMutableArray alloc] init];
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        UINib *nib = [UINib nibWithNibName:@"JobCellHeyJobs_iPad" bundle:nil];
        [self.myCollectionView registerNib:nib forCellWithReuseIdentifier:@"cell"];
    } else {
        UINib *nib = [UINib nibWithNibName:@"JobCellHeyJobs" bundle:nil];
        [self.myCollectionView registerNib:nib forCellWithReuseIdentifier:@"cell"];
    }
    [self getCategoriesNowallList];
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}
-(void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    self.myCollectionView.contentInset = UIEdgeInsetsMake(10,10,10,10);
}
-(void)getCategoriesNowallList
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
        NSString *catID = [[NSUserDefaults standardUserDefaults] valueForKey:@"CATEGORY_ID"];
        NSString *str = [NSString stringWithFormat:@"%@api.php?cat_id=%@",[CommonUtils getBaseURL],catID];
        NSString *encodedString = [str stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLFragmentAllowedCharacterSet]];
        NSLog(@"CategoriesHeyJObs List API URL : %@",encodedString);
        [self getCategoriesNowallListDataHeyJOb:encodedString];
    }
}
-(void)getCategoriesNowallListDataHeyJOb:(NSString *)requesturl
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager GET:requesturl parameters:nil progress:nil success:^(NSURLSessionTask *task, id responseObject)
     {
         NSLog(@"CategoriesHeyJObs List Response Data : %@",responseObject);
         NSDictionary *errordict = (NSDictionary *)responseObject;
         NSArray *storeArr = [errordict[@"JOBS_APP"] mutableCopy];
         for (int i=0; i<storeArr.count; i++)
         {
             NSDictionary *storeDict = [storeArr objectAtIndex:i];
             [CatListArray addObject:storeDict];
         }
         NSLog(@"CatListArray Count : %lu",(unsigned long)CatListArray.count);
         if (CatListArray.count == 0) {
             lblnodatafound.hidden = NO;
             self.myCollectionView.hidden = YES;
         } else {
             lblnodatafound.hidden = YES;
             self.myCollectionView.hidden = NO;
         }
         [self.myCollectionView reloadData];
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
    return [CatListArray count];
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
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
    NSString *str = [[CatListArray valueForKey:@"job_image_thumb"] objectAtIndex:indexPath.row];
    NSString *encodedString = [str stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLFragmentAllowedCharacterSet]];
    NSURL *ImageUrl = [NSURL URLWithString:encodedString];
    UIImage *imagea = [UIImage imageNamed:@"placeholder"];
    [cell.iconImage sd_setImageWithURL:ImageUrl placeholderImage:imagea];
    cell.lbljobname.text = [[CatListArray valueForKey:@"job_name"] objectAtIndex:indexPath.row];
    cell.lblcompanyname.text = [[CatListArray valueForKey:@"job_company_name"] objectAtIndex:indexPath.row];
    cell.lbldate.text = [[CatListArray valueForKey:@"job_date"] objectAtIndex:indexPath.row];
    cell.lbldesignation.text = [[CatListArray valueForKey:@"job_designation"] objectAtIndex:indexPath.row];
    cell.lbladdress.text = [[CatListArray valueForKey:@"job_address"] objectAtIndex:indexPath.row];
    return cell;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        return CGSizeMake(self.view.frame.size.width-20, 170);
    } else {
        return CGSizeMake(self.view.frame.size.width-20, 170);
    }
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 10.0f;
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *jobID = [[CatListArray valueForKey:@"id"] objectAtIndex:indexPath.row];
    [[NSUserDefaults standardUserDefaults] setValue:jobID forKey:@"JOB_ID"];
    NSString *jobNAME = [[CatListArray valueForKey:@"job_name"] objectAtIndex:indexPath.row];
    [[NSUserDefaults standardUserDefaults] setValue:jobNAME forKey:@"JOB_NAME"];
    [self pushScreen];
}
-(void)OnApplyClickaseg:(UIButton*)sender
{
    NSLog(@"you clicked on button %ld", (long)sender.tag);
    BOOL isLogin = [[NSUserDefaults standardUserDefaults] boolForKey:@"LOGIN"];
    if (isLogin) {
        ApplyArray = [[NSMutableArray alloc] init];
        NSArray *LoginArray = [[NSUserDefaults standardUserDefaults] objectForKey:@"LoginArray"];
        NSString *userID = [[LoginArray valueForKey:@"user_id"] componentsJoinedByString:@","];
        NSString *jobID = [[CatListArray valueForKey:@"id"] objectAtIndex:sender.tag];
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
    [[NSUserDefaults standardUserDefaults] setValue:@"CategoryListheyJOb" forKey:@"SCREEN_NAME"];
    overlay1 = [[UIXOverlayController1 alloc] init];
    overlay1.dismissUponTouchMask = NO;
    DialogContentViewController1 *vc = [[DialogContentViewController1 alloc] init];
    [overlay1 presentOverlayOnView:self.view withContent:vc animated:YES];
}
- (void)CallSearchJob:(NSNotification *)notification
{
    if ([[notification name] isEqualToString:@"CategoryListheyJOb"]) {
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
            SearcsaehJobsasd *view = [[SearcsaehJobsasd alloc] initWithNibName:@"SearcsaehJobsasd_iPad" bundle:nil];
            [self.navigationController pushViewController:view animated:YES];
        } else {
            SearcsaehJobsasd *view = [[SearcsaehJobsasd alloc] initWithNibName:@"SearcsaehJobsasd" bundle:nil];
            [self.navigationController pushViewController:view animated:YES];
        }
    }
}
-(void)pushScreen
{
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        DetailViewController *view = [[DetailViewController alloc] initWithNibName:@"DetailViewController_iPad" bundle:nil];
        [self.navigationController pushViewController:view animated:YES];
    } else {
        DetailViewController *view = [[DetailViewController alloc] initWithNibName:@"DetailViewController" bundle:nil];
        [self.navigationController pushViewController:view animated:YES];
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
