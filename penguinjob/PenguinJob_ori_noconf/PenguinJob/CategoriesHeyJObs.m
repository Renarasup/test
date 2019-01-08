#import "CategoriesHeyJObs.h"
@interface CategoriesHeyJObs ()
@end
@implementation CategoriesHeyJObs
@synthesize myCollectionView;
@synthesize CategoryArray;
@synthesize lblnodatafound;
@synthesize btnsearch;
- (void)viewDidLoad
{
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(CallSearchJob:) name:@"CategoriesHeyJObs" object:nil];
    CategoryArray = [[NSMutableArray alloc] init];
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        UINib *nib = [UINib nibWithNibName:@"CategoryCellHeyJObs_iPad" bundle:nil];
        [self.myCollectionView registerNib:nib forCellWithReuseIdentifier:@"cell"];
    } else {
        UINib *nib = [UINib nibWithNibName:@"CategoryCellHeyJObs" bundle:nil];
        [self.myCollectionView registerNib:nib forCellWithReuseIdentifier:@"cell"];
    }
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    [flowLayout setItemSize:CGSizeMake(115,125)];
    flowLayout.minimumInteritemSpacing = 0;
    [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
    [self.myCollectionView setCollectionViewLayout:flowLayout];
    [self getCategoriesNowall];
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
-(void)getCategoriesNowall
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
        NSString *str = [NSString stringWithFormat:@"%@api.php?cat_list",[CommonUtils getBaseURL]];
        NSString *encodedString = [str stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLFragmentAllowedCharacterSet]];
        NSLog(@"CategoriesHeyJObs API URL : %@",encodedString);
        [self getCategoriesNowallData:encodedString];
    }
}
-(void)getCategoriesNowallData:(NSString *)requesturl
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager GET:requesturl parameters:nil progress:nil success:^(NSURLSessionTask *task, id responseObject)
     {
         NSLog(@"CategoriesHeyJObs Response Data : %@",responseObject);
         NSDictionary *errordict = (NSDictionary *)responseObject;
         NSArray *storeArr = [errordict[@"JOBS_APP"] mutableCopy];
         for (int i=0; i<storeArr.count; i++)
         {
             NSDictionary *storeDict = [storeArr objectAtIndex:i];
             [CategoryArray addObject:storeDict];
         }
         NSLog(@"CategoryArray Count : %lu",(unsigned long)CategoryArray.count);
         if (CategoryArray.count == 0) {
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
    return [CategoryArray count];
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifire = @"cell";
    CategoryCellHeyJObs *cell = (CategoryCellHeyJObs *)[self.myCollectionView dequeueReusableCellWithReuseIdentifier:cellIdentifire forIndexPath:indexPath];
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
    NSString *str = [[CategoryArray valueForKey:@"category_image_thumb"] objectAtIndex:indexPath.row];
    NSString *encodedString = [str stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLFragmentAllowedCharacterSet]];
    NSURL *ImageUrl = [NSURL URLWithString:encodedString];
    UIImage *imagea = [UIImage imageNamed:@"placeholder"];
    [cell.iconImageView sd_setImageWithURL:ImageUrl placeholderImage:imagea];
    cell.lblcatname.text = [[CategoryArray valueForKey:@"category_name"] objectAtIndex:indexPath.row];
    return cell;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(110,125);
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 5.0f;
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *catID = [[CategoryArray valueForKey:@"cid"] objectAtIndex:indexPath.row];
    [[NSUserDefaults standardUserDefaults] setObject:catID forKey:@"CATEGORY_ID"];
    NSString *catNAME = [[CategoryArray valueForKey:@"category_name"] objectAtIndex:indexPath.row];
    [[NSUserDefaults standardUserDefaults] setObject:catNAME forKey:@"CATEGORY_NAME"];
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        CategoryListheyJOb *view = [[CategoryListheyJOb alloc] initWithNibName:@"CategoryListheyJOb_iPad" bundle:nil];
        [self.navigationController pushViewController:view animated:YES];
    } else {
        CategoryListheyJOb *view = [[CategoryListheyJOb alloc] initWithNibName:@"CategoryListheyJOb" bundle:nil];
        [self.navigationController pushViewController:view animated:YES];
    }
}
-(IBAction)OnSearchClickSpecialShey:(id)sender
{
    [[NSUserDefaults standardUserDefaults] setValue:@"CategoriesHeyJObs" forKey:@"SCREEN_NAME"];
    overlay1 = [[UIXOverlayController1 alloc] init];
    overlay1.dismissUponTouchMask = NO;
    DialogContentViewController1 *vc = [[DialogContentViewController1 alloc] init];
    [overlay1 presentOverlayOnView:self.view withContent:vc animated:YES];
}
- (void)CallSearchJob:(NSNotification *)notification
{
    if ([[notification name] isEqualToString:@"CategoriesHeyJObs"]) {
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
            SearcsaehJobsasd *view = [[SearcsaehJobsasd alloc] initWithNibName:@"SearcsaehJobsasd_iPad" bundle:nil];
            [self.navigationController pushViewController:view animated:YES];
        } else {
            SearcsaehJobsasd *view = [[SearcsaehJobsasd alloc] initWithNibName:@"SearcsaehJobsasd" bundle:nil];
            [self.navigationController pushViewController:view animated:YES];
        }
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
