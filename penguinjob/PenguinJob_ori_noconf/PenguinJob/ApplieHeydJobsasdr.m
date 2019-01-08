#import "ApplieHeydJobsasdr.h"
@interface ApplieHeydJobsasdr ()
@end
@implementation ApplieHeydJobsasdr
@synthesize myCollectionView;
@synthesize AppliedArray;
@synthesize lblnodatafound;
- (void)viewDidLoad
{
    [super viewDidLoad];
    AppliedArray = [[NSMutableArray alloc] init];
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        UINib *nib = [UINib nibWithNibName:@"AppliedJsdraobCellsdg_iPad" bundle:nil];
        [self.myCollectionView registerNib:nib forCellWithReuseIdentifier:@"cell"];
    } else {
        UINib *nib = [UINib nibWithNibName:@"AppliedJsdraobCellsdg" bundle:nil];
        [self.myCollectionView registerNib:nib forCellWithReuseIdentifier:@"cell"];
    }
    [self geasetAppliedJobsListsdg];
}
-(void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    self.myCollectionView.contentInset = UIEdgeInsetsMake(10,10,10,10);
}
-(void)geasetAppliedJobsListsdg
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
        NSString *jobID = [[NSUserDefaults standardUserDefaults] valueForKey:@"JobAppliedId"];
        NSString *str = [NSString stringWithFormat:@"%@user_job_apply_list_api.php?job_id=%@",[CommonUtils getBaseURL],jobID];
        NSString *encodedString = [str stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLFragmentAllowedCharacterSet]];
        NSLog(@"Applied Jobs List API URL : %@",encodedString);
        [self geasetAppliedJobsListsdgData:encodedString];
    }
}
-(void)geasetAppliedJobsListsdgData:(NSString *)requesturl
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager GET:requesturl parameters:nil progress:nil success:^(NSURLSessionTask *task, id responseObject)
     {
         NSLog(@"ApplieHeydJobsasdrList Response Data : %@",responseObject);
         NSDictionary *errordict = (NSDictionary *)responseObject;
         NSArray *storeArr = [errordict[@"JOBS_APP"] mutableCopy];
         for (int i=0; i<storeArr.count; i++)
         {
             NSDictionary *storeDict = [storeArr objectAtIndex:i];
             [AppliedArray addObject:storeDict];
         }
         NSLog(@"SearchListArray Count : %lu",(unsigned long)AppliedArray.count);
         if (AppliedArray.count == 0) {
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
    return [AppliedArray count];
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifire = @"cell";
    AppliedJsdraobCellsdg *cell = (AppliedJsdraobCellsdg *)[self.myCollectionView dequeueReusableCellWithReuseIdentifier:cellIdentifire forIndexPath:indexPath];
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
    [cell.btnemail addTarget:self action:@selector(OnEmaseilClickChangease:) forControlEvents:UIControlEventTouchUpInside];
    cell.btnemail.tag = indexPath.row;
    [cell.btnphone addTarget:self action:@selector(OnPhoneClicknvcnChangefd:) forControlEvents:UIControlEventTouchUpInside];
    cell.btnphone.tag = indexPath.row;
    cell.btnshowresume.layer.cornerRadius = 5.0f;
    [cell.btnshowresume addTarget:self action:@selector(OnShongwResumeClicksdr:) forControlEvents:UIControlEventTouchUpInside];
    cell.btnshowresume.tag = indexPath.row;
    cell.btnshowresume.layer.shadowColor = [UIColor lightGrayColor].CGColor;
    cell.btnshowresume.layer.shadowOffset = CGSizeMake(0,0);
    cell.btnshowresume.layer.shadowRadius = 2.0f;
    cell.btnshowresume.layer.shadowOpacity = 2;
    cell.btnshowresume.layer.masksToBounds = NO;
    cell.btnshowresume.layer.shadowPath = [UIBezierPath bezierPathWithRoundedRect:cell.btnshowresume.layer.bounds cornerRadius:cell.btnshowresume.layer.cornerRadius].CGPath;
    cell.iconImage.layer.borderWidth = 0.3f;
    cell.iconImage.layer.borderColor = [UIColor grayColor].CGColor;
    cell.iconImage.layer.cornerRadius = cell.iconImage.frame.size.height/2;
    cell.iconImage.clipsToBounds = YES;
    NSString *str = [[AppliedArray valueForKey:@"user_image"] objectAtIndex:indexPath.row];
    NSString *encodedString = [str stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLFragmentAllowedCharacterSet]];
    NSURL *ImageUrl = [NSURL URLWithString:encodedString];
    NSString *placeImage = [NSString stringWithFormat:@"%@images/11129_user.jpg",[CommonUtils getBaseURL]];
    NSString *encodedStringStr = [placeImage stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLFragmentAllowedCharacterSet]];
    NSURL *placeImageUrl = [NSURL URLWithString:encodedStringStr];
    NSData *data = [NSData dataWithContentsOfURL:placeImageUrl];
    UIImage *imagea = [UIImage imageWithData:data];
    [cell.iconImage sd_setImageWithURL:ImageUrl placeholderImage:imagea];
    cell.lblusername.text = [[AppliedArray valueForKey:@"name"] objectAtIndex:indexPath.row];
    cell.lbluseremail.text = [[AppliedArray valueForKey:@"email"] objectAtIndex:indexPath.row];
    cell.lbluserphone.text = [[AppliedArray valueForKey:@"phone"] objectAtIndex:indexPath.row];
    cell.lbluseraddress.text = [[AppliedArray valueForKey:@"city"] objectAtIndex:indexPath.row];
    NSString *isUserResume = [[AppliedArray valueForKey:@"user_resume"] objectAtIndex:indexPath.row];
    if ([isUserResume isEqualToString:@""]) {
        cell.btnshowresume.hidden = YES;
    } else {
        cell.btnshowresume.hidden = NO;
    }
    return cell;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *isUserResume = [[AppliedArray valueForKey:@"user_resume"] objectAtIndex:indexPath.row];
    if ([isUserResume isEqualToString:@""]) {
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
            return CGSizeMake(self.view.frame.size.width-20, 172);
        } else {
            return CGSizeMake(self.view.frame.size.width-20, 172);
        }
    } else {
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
            return CGSizeMake(self.view.frame.size.width-20, 216.0f);
        } else {
            return CGSizeMake(self.view.frame.size.width-20, 216.0f);
        }
    }
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 10.0f;
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
}
-(void)OnEmaseilClickChangease:(UIButton *)sender
{
    NSString *strEmail = [[AppliedArray valueForKey:@"email"] objectAtIndex:sender.tag];
    if ([MFMailComposeViewController canSendMail])
    {
        MFMailComposeViewController *picker = [[MFMailComposeViewController alloc] init];
        picker.mailComposeDelegate = self;
        [picker setSubject:@"PenguinJobs"];
        NSString *stremail = strEmail;
        NSArray *toRecipients = [NSArray arrayWithObject:stremail];
        [picker setToRecipients:toRecipients];
        NSString *emailBody = @"Please write text here...";
        [picker setMessageBody:emailBody isHTML:NO];
        [self presentViewController:picker animated:YES completion:NULL];
    } else {
        self.feedbackMsg.hidden = NO;
        self.feedbackMsg.text = @"Device not configured to send mail.";
    }
}
- (void)mailComposeControllerSend:(MFMailComposeViewController*)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error
{
    self.feedbackMsg.hidden = NO;
    switch (result)
    {
        case MFMailComposeResultCancelled:
            self.feedbackMsg.text = @"Result: Mail sending canceled";
            break;
        case MFMailComposeResultSaved:
            self.feedbackMsg.text = @"Result: Mail saved";
            break;
        case MFMailComposeResultSent:
            self.feedbackMsg.text = @"Result: Mail sent";
            break;
        case MFMailComposeResultFailed:
            self.feedbackMsg.text = @"Result: Mail sending failed";
            break;
        default:
            self.feedbackMsg.text = @"Result: Mail not sent";
            break;
    }
    [self dismissViewControllerAnimated:YES completion:NULL];
}
-(void)OnPhoneClicknvcnChangefd:(UIButton *)sender
{
    NSString *strPhone = [[AppliedArray valueForKey:@"phone"] objectAtIndex:sender.tag];
    NSString *phoneNumber = [@"tel://" stringByAppendingString:strPhone];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:phoneNumber]];
}
-(void)OnShongwResumeClicksdr:(UIButton *)sender
{
    NSString *strResume = [[AppliedArray valueForKey:@"user_resume"] objectAtIndex:sender.tag];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:strResume]];
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
