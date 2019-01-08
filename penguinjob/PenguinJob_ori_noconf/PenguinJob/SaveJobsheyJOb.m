#import "SaveJobsheyJOb.h"
@interface SaveJobsheyJOb ()
@end
@implementation SaveJobsheyJOb
@synthesize myCollectionView;
@synthesize FavouritesArray,ApplyArray;
@synthesize lblnodatafound;
- (void)viewDidLoad
{
    [super viewDidLoad];
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        UINib *nib = [UINib nibWithNibName:@"JobCellHeyJobs_iPad" bundle:nil];
        [self.myCollectionView registerNib:nib forCellWithReuseIdentifier:@"cell"];
    } else {
        UINib *nib = [UINib nibWithNibName:@"JobCellHeyJobs" bundle:nil];
        [self.myCollectionView registerNib:nib forCellWithReuseIdentifier:@"cell"];
    }
    [self getFavouritesMine];
}
-(void)getFavouritesMine
{
    FavouritesArray = [[NSMutableArray alloc] init];
    EGODatabase *db = [EGODatabase databaseWithPath:[[CommonUtils ShareInstance] getDBPath]];
    NSString *selectQuery = [NSString stringWithFormat:@"SELECT * FROM Favourite"];
    EGODatabaseResult *result = [db executeQuery:selectQuery];
    for(EGODatabaseRow *rowContract in result)
    {
        NSString *cat_id = [rowContract stringForColumn:@"cat_id"];
        NSString *category_image = [rowContract stringForColumn:@"category_image"];
        NSString *category_image_thumb = [rowContract stringForColumn:@"category_image_thumb"];
        NSString *category_name = [rowContract stringForColumn:@"category_name"];
        NSString *cid = [rowContract stringForColumn:@"cid"];
        NSString *jobid = [rowContract stringForColumn:@"jobid"];
        NSString *job_address = [rowContract stringForColumn:@"job_address"];
        NSString *job_company_name = [rowContract stringForColumn:@"job_company_name"];
        NSString *job_company_website = [rowContract stringForColumn:@"job_company_website"];
        NSString *job_date = [rowContract stringForColumn:@"job_date"];
        NSString *job_desc = [rowContract stringForColumn:@"job_desc"];
        NSString *job_designation = [rowContract stringForColumn:@"job_designation"];
        NSString *job_image = [rowContract stringForColumn:@"job_image"];
        NSString *job_image_thumb = [rowContract stringForColumn:@"job_image_thumb"];
        NSString *job_mail = [rowContract stringForColumn:@"job_mail"];
        NSString *job_name = [rowContract stringForColumn:@"job_name"];
        NSString *job_phone_number = [rowContract stringForColumn:@"job_phone_number"];
        NSString *job_qualification = [rowContract stringForColumn:@"job_qualification"];
        NSString *job_salary = [rowContract stringForColumn:@"job_salary"];
        NSString *job_skill = [rowContract stringForColumn:@"job_skill"];
        NSString *job_vacancy = [rowContract stringForColumn:@"job_vacancy"];
        NSDictionary *aDic= [NSDictionary dictionaryWithObjectsAndKeys:
                             cat_id, @"cat_id",
                             category_image, @"category_image",
                             category_image_thumb, @"category_image_thumb",
                             category_name, @"category_name",
                             cid, @"cid",
                             jobid, @"id",
                             job_address, @"job_address",
                             job_company_name, @"job_company_name",
                             job_company_website, @"job_company_website",
                             job_date, @"job_date",
                             job_desc, @"job_desc",
                             job_designation, @"job_designation",
                             job_image, @"job_image",
                             job_image_thumb, @"job_image_thumb",
                             job_mail, @"job_mail",
                             job_name, @"job_name",
                             job_phone_number, @"job_phone_number",
                             job_qualification, @"job_qualification",
                             job_salary, @"job_salary",
                             job_skill, @"job_skill",
                             job_vacancy, @"job_vacancy", nil];
        [FavouritesArray addObject:aDic];
    }
    NSLog(@"FavouritesArray Count : %lu",(unsigned long)FavouritesArray.count);
    if (FavouritesArray.count == 0) {
        lblnodatafound.hidden = NO;
        self.myCollectionView.hidden = YES;
    } else {
        lblnodatafound.hidden = YES;
        self.myCollectionView.hidden = NO;
    }
    [self.myCollectionView reloadData];
}
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [FavouritesArray count];
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
    NSString *str = [[FavouritesArray valueForKey:@"job_image_thumb"] objectAtIndex:indexPath.row];
    NSString *encodedString = [str stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLFragmentAllowedCharacterSet]];
    NSURL *ImageUrl = [NSURL URLWithString:encodedString];
    UIImage *imagea = [UIImage imageNamed:@"placeholder"];
    [cell.iconImage sd_setImageWithURL:ImageUrl placeholderImage:imagea];
    cell.lbljobname.text = [[FavouritesArray valueForKey:@"job_name"] objectAtIndex:indexPath.row];
    cell.lblcompanyname.text = [[FavouritesArray valueForKey:@"job_company_name"] objectAtIndex:indexPath.row];
    cell.lbldate.text = [[FavouritesArray valueForKey:@"job_date"] objectAtIndex:indexPath.row];
    cell.lbldesignation.text = [[FavouritesArray valueForKey:@"job_designation"] objectAtIndex:indexPath.row];
    cell.lbladdress.text = [[FavouritesArray valueForKey:@"job_address"] objectAtIndex:indexPath.row];
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
    NSString *jobID = [[FavouritesArray valueForKey:@"id"] objectAtIndex:indexPath.row];
    [[NSUserDefaults standardUserDefaults] setValue:jobID forKey:@"JOB_ID"];
    NSString *jobNAME = [[FavouritesArray valueForKey:@"job_name"] objectAtIndex:indexPath.row];
    [[NSUserDefaults standardUserDefaults] setValue:jobNAME forKey:@"JOB_NAME"];
    [self pushScreen];
}
-(void)OnApplyClickaseg:(UIButton*)sender
{
    BOOL isLogin = [[NSUserDefaults standardUserDefaults] boolForKey:@"LOGIN"];
    if (isLogin) {
        ApplyArray = [[NSMutableArray alloc] init];
        NSArray *LoginArray = [[NSUserDefaults standardUserDefaults] objectForKey:@"LoginArray"];
        NSString *userID = [[LoginArray valueForKey:@"user_id"] componentsJoinedByString:@","];
        NSString *jobID = [[FavouritesArray valueForKey:@"id"] objectAtIndex:sender.tag];
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
