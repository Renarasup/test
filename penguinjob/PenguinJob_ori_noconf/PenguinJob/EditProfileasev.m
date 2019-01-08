#import "EditProfileasev.h"
@interface EditProfileasev ()
@end
@implementation EditProfileasev
@synthesize scrollView,myView,iconView,iconImageView;
@synthesize EditProfileasevArray,ResponseProfileArray;
@synthesize txtname,txtemail,txtpassword;
@synthesize txtphone,txtcity,txtaddress;
@synthesize imgProfile;
@synthesize btnchoose1,btnchoose2;
@synthesize lblfilename;
@synthesize fileExtension;
@synthesize fileData;
- (void)viewDidLoad
{
    [super viewDidLoad];
    EditProfileasevArray = [[NSMutableArray alloc] init];
    EditProfileasevArray = [[[NSUserDefaults standardUserDefaults] objectForKey:@"ProfileArray"] mutableCopy];
    NSString *str = [[EditProfileasevArray valueForKey:@"user_image"] componentsJoinedByString:@","];
    NSString *encodedString = [str stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLFragmentAllowedCharacterSet]];
    NSURL *ImageUrl = [NSURL URLWithString:encodedString];
    UIImage *imagea = [UIImage imageNamed:@"menulogo"];
    [iconImageView sd_setImageWithURL:ImageUrl placeholderImage:imagea];
    txtname.text = [[EditProfileasevArray valueForKey:@"name"] componentsJoinedByString:@","];
    txtemail.text = [[EditProfileasevArray valueForKey:@"email"] componentsJoinedByString:@","];
    txtphone.text = [[EditProfileasevArray valueForKey:@"phone"] componentsJoinedByString:@","];
    txtcity.text = [[EditProfileasevArray valueForKey:@"city"] componentsJoinedByString:@","];
    txtaddress.text = [[EditProfileasevArray valueForKey:@"address"] componentsJoinedByString:@","];
    NSString *str1 = [[EditProfileasevArray valueForKey:@"user_image"] componentsJoinedByString:@","];
    NSString *encodedString1 = [str1 stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLFragmentAllowedCharacterSet]];
    NSURL *ImageUrl1 = [NSURL URLWithString:encodedString1];
    [imgProfile sd_setImageWithURL:ImageUrl1 placeholderImage:nil];
    lblfilename.text = [[EditProfileasevArray valueForKey:@"user_resume"] componentsJoinedByString:@","];
    NSString *filename = [[EditProfileasevArray valueForKey:@"user_resume"] componentsJoinedByString:@","];
    fileExtension = [filename pathExtension];
    NSString *userResume = [[EditProfileasevArray valueForKey:@"user_resume"] componentsJoinedByString:@","];
    if ([userResume isEqualToString:@""]) {
        [self.scrollView setContentSize:CGSizeMake(self.scrollView.frame.size.width, 760)];
    } else {
        CGSize maximumLabelSize1 = CGSizeMake(FLT_MIN, FLT_MAX);
        CGRect textRect1 = [userResume boundingRectWithSize:maximumLabelSize1
                                                    options:NSStringDrawingUsesLineFragmentOrigin
                                                 attributes:@{NSFontAttributeName:[UIFont fontWithName:@"OpenSans-Semibold" size:14.0f]}
                                                    context:nil];
        CGSize expectedLabelSize1 = textRect1.size;
        CGRect newFrame1 = lblfilename.frame;
        newFrame1.size.height = expectedLabelSize1.height;
        lblfilename.frame = newFrame1;
        lblfilename.numberOfLines = 0;
        lblfilename.text = userResume;
        [lblfilename sizeToFit];
        CGFloat lblresumehieght = [self getLabelHeightForFDisplay:lblfilename];
        NSLog(@"Resume Hieght : %f",lblresumehieght);
        [self.myView setFrame:CGRectMake(10, 10, self.myView.frame.size.width, 675+lblresumehieght)];
        [self.scrollView setContentSize:CGSizeMake(self.scrollView.frame.size.width, 695+lblresumehieght)];
    }
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
    imgProfile.layer.shadowColor = [UIColor lightGrayColor].CGColor;
    imgProfile.layer.shadowOffset = CGSizeMake(0,0);
    imgProfile.layer.shadowRadius = 1.0f;
    imgProfile.layer.shadowOpacity = 1;
    imgProfile.layer.masksToBounds = NO;
    imgProfile.layer.shadowPath = [UIBezierPath bezierPathWithRoundedRect:imgProfile.layer.bounds cornerRadius:imgProfile.layer.cornerRadius].CGPath;
    btnchoose1.layer.cornerRadius = 5.0f;
    btnchoose1.layer.shadowColor = [UIColor lightGrayColor].CGColor;
    btnchoose1.layer.shadowOffset = CGSizeMake(0,0);
    btnchoose1.layer.shadowRadius = 1.0f;
    btnchoose1.layer.shadowOpacity = 1;
    btnchoose1.layer.masksToBounds = NO;
    btnchoose1.layer.shadowPath = [UIBezierPath bezierPathWithRoundedRect:btnchoose1.layer.bounds cornerRadius:btnchoose1.layer.cornerRadius].CGPath;
    btnchoose2.layer.cornerRadius = 5.0f;
    btnchoose2.layer.shadowColor = [UIColor lightGrayColor].CGColor;
    btnchoose2.layer.shadowOffset = CGSizeMake(0,0);
    btnchoose2.layer.shadowRadius = 1.0f;
    btnchoose2.layer.shadowOpacity = 1;
    btnchoose2.layer.masksToBounds = NO;
    btnchoose2.layer.shadowPath = [UIBezierPath bezierPathWithRoundedRect:btnchoose2.layer.bounds cornerRadius:btnchoose2.layer.cornerRadius].CGPath;
}
-(IBAction)OnChoosese1Clickase:(id)sender
{
    [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
        if (status == PHAuthorizationStatusAuthorized){
            UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
            imagePickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            imagePickerController.delegate = self;
            [self presentViewController:imagePickerController animated:YES completion:nil];
        }else if (status == PHAuthorizationStatusAuthorized){
            NSLog(@"denied");
        }
    }];
}
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage *image = [info valueForKey:UIImagePickerControllerOriginalImage];
    imgProfile.image = image;
    [picker dismissViewControllerAnimated:YES completion:nil];
}
-(IBAction)seOnChoose2Clickase:(id)sender
{
    UIDocumentMenuViewController *viewController = [[UIDocumentMenuViewController alloc] initWithDocumentTypes:@[(NSString *)kUTTypeItem] inMode:UIDocumentPickerModeImport];
    viewController.delegate = self;
    viewController.modalPresentationStyle = UIModalPresentationFullScreen;
    [self presentViewController:viewController animated:YES completion:^{
    }];
}
- (void)documentMenu:(UIDocumentMenuViewController *)documentMenu didPickDocumentPicker:(UIDocumentPickerViewController *)documentPicker
{
    documentPicker.delegate = self;
    [self presentViewController:documentPicker animated:YES completion:nil];
}
- (void)documentPicker:(UIDocumentPickerViewController *)controller didPickDocumentAtURL:(NSURL *)url
{
    NSLog(@"picked %@", url);
    NSString *filename = [url lastPathComponent];
    lblfilename.text = filename;
    fileExtension = [filename pathExtension];
    NSLog(@"File Extension : %@",fileExtension);
    fileData = [NSData dataWithContentsOfURL:url];
}
-(void)sendUserProfile
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
        NSString *str = [NSString stringWithFormat:@"%@user_profile_update_api.php",[CommonUtils getBaseURL]];
        NSString *encodedString = [str stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLFragmentAllowedCharacterSet]];
        NSLog(@"Edit User Profile API URL : %@",encodedString);
        [self getEditProasefileDataasf:encodedString];
    }
}
//------------Get Edit Profile Json Data--------------//
-(void)getEditProasefileDataasf:(NSString *)requesturl
{
    //User Profile Update(Post Method-user_id,name,email,password,phone,city,address,user_image,user_resume)
    
    NSString *userID = [[EditProfileasevArray valueForKey:@"user_id"] componentsJoinedByString:@","];
    NSDictionary *parameters = @{@"user_id":userID,@"name":txtname.text,@"email":txtemail.text,@"password":txtpassword.text,@"phone":txtphone.text,@"city":txtcity.text,@"address":txtaddress.text};
    
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc]initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    manager.responseSerializer=[AFJSONResponseSerializer serializer];
    NSString *contentType = [NSString stringWithFormat:@"multipart/form-data"];
    [manager.requestSerializer setValue:contentType forHTTPHeaderField:@"Content-Type"];
    [manager POST:requesturl parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData)
     {
         //1.Profile Image
         if (imgProfile.image != nil) {
             NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
             [formatter setDateFormat:@"dd_MM_yyyy_HH_mm_ss"];
             NSData *imageData = UIImagePNGRepresentation(imgProfile.image);
             [formData appendPartWithFileData:imageData name:@"user_image" fileName:[NSString stringWithFormat:@"%@.png",[formatter stringFromDate:[NSDate date]]] mimeType:@"image/*"];
         }
         
         //2.Resume PDF
         if (fileData != nil) {
             NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
             [formatter setDateFormat:@"dd_MM_yyyy_HH_mm_ss"];
             [formData appendPartWithFileData:fileData name:@"user_resume" fileName:[NSString stringWithFormat:@"%@.pdf", [formatter stringFromDate:[NSDate date]]] mimeType:@"pdf/*"];
             //[formData appendPartWithFileData:fileData name:@"user_resume" fileName:[NSString stringWithFormat:@"%@.pdf", [formatter stringFromDate:[NSDate date]]] mimeType:@"application/pdf"];
         }
     } progress:^(NSProgress * _Nonnull uploadProgress) {
         
     } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
     {
         NSLog(@"response object : %@",responseObject);
         NSDictionary *errordict = (NSDictionary *)responseObject;
         NSArray *storeArr = [errordict[@"JOBS_APP"] mutableCopy];
         for (int i=0; i<storeArr.count; i++)
         {
             NSDictionary *storeDict = [storeArr objectAtIndex:i];
             [ResponseProfileArray addObject:storeDict];
         }
         NSLog(@"ResponseProfileArray Count : %lu",(unsigned long)ResponseProfileArray.count);
         NSString *isSuccess = [[ResponseProfileArray valueForKey:@"success"] componentsJoinedByString:@","];
         if ([isSuccess isEqualToString:@"1"]) {
             [KSToastView ks_showToast:[[ResponseProfileArray valueForKey:@"msg"] componentsJoinedByString:@","] duration:3.0f];
             [self.navigationController popViewControllerAnimated:YES];
         } else {
             [KSToastView ks_showToast:[[ResponseProfileArray valueForKey:@"msg"] componentsJoinedByString:@","] duration:3.0f];
         }
         [self stopSpinner];
     } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
         NSLog(@"error: %@", error.localizedDescription);
         UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Network Error!" message:[error localizedDescription] preferredStyle:UIAlertControllerStyleAlert];
         UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:nil];
         [alert addAction:cancel];
         [self presentViewController:alert animated:YES completion:nil];
         [self stopSpinner];
     }];
}


-(IBAction)OnSaveClickDataadse:(id)sender
{
    if ([txtname.text isEqualToString:@""]) {
        [KSToastView ks_showToast:@"Please enter name" duration:3.0f];
    } else if ([txtemail.text isEqualToString:@""]) {
        [KSToastView ks_showToast:@"Please enter email" duration:3.0f];
    } else if (![CommonUtils validateEmailWithString:txtemail.text]) {
        [KSToastView ks_showToast:@"Please enter valid email" duration:3.0f];
        //    } else if ([txtpassword.text isEqualToString:@""]) {
        //        [KSToastView ks_showToast:@"Please enter password" duration:3.0f];
        //    } else if ([txtphone.text isEqualToString:@""]) {
        //        [KSToastView ks_showToast:@"Please enter phone" duration:3.0f];
        //    } else if ([txtcity.text isEqualToString:@""]) {
        //        [KSToastView ks_showToast:@"Please enter city" duration:3.0f];
        //    } else if ([txtaddress.text isEqualToString:@""]) {
        //        [KSToastView ks_showToast:@"Please enter address" duration:3.0f];
        //    } else if (imgProfile.image == nil) {
        //        [KSToastView ks_showToast:@"Please select profile image" duration:3.0f];
        //    } else if ([lblfilename.text isEqualToString:@""]) {
        //        [KSToastView ks_showToast:@"Please select resume" duration:3.0f];
        //    } else if (![fileExtension isEqualToString:@"pdf"]) {
        //        [KSToastView ks_showToast:@"Please select pdf file" duration:3.0f];
    } else {
        ResponseProfileArray = [[NSMutableArray alloc] init];
        [self sendUserProfile];
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

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [txtname resignFirstResponder];
    [txtemail resignFirstResponder];
    [txtpassword resignFirstResponder];
    [txtphone resignFirstResponder];
    [txtcity resignFirstResponder];
    [txtaddress resignFirstResponder];
    return YES;
}

- (CGFloat)getLabelHeightForFDisplay:(UILabel *)label
{
    CGSize constraint = CGSizeMake(label.frame.size.width, CGFLOAT_MAX);
    CGSize size;
    NSStringDrawingContext *context = [[NSStringDrawingContext alloc] init];
    CGSize boundingBox = [label.text boundingRectWithSize:constraint
                                                  options:NSStringDrawingUsesLineFragmentOrigin
                                               attributes:@{NSFontAttributeName:label.font}
                                                  context:context].size;
    size = CGSizeMake(ceil(boundingBox.width), ceil(boundingBox.height));
    return size.height;
}

//1.Banner
//-(void)setAdmob
//{
//    NSString *banner_ad_id = [[NSUserDefaults standardUserDefaults] valueForKey:@"banner_ad_id_ios"];
//    self.bannerView = [[GADBannerView alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height-50, self.view.frame.size.width-20, 50)];
//    [self addBannerViewToView:self.bannerView];
//    self.bannerView.adUnitID = banner_ad_id;
//    self.bannerView.rootViewController = self;
//    self.bannerView.delegate = self;
//    [self.bannerView loadRequest:[GADRequest request]];
//}
//-(void)adViewDidReceiveAd:(GADBannerView *)adView
//{
//    // We've received an ad so lets show the banner
//    NSLog(@"adViewDidReceiveAd");
//}
//-(void)adView:(GADBannerView *)adView didFailToReceiveAdWithError:(GADRequestError *)error
//{
//    // Failed to receive an ad from AdMob so lets hide the banner
//    NSLog(@"adView:didFailToReceiveAdWithError: %@", [error localizedDescription]);
//}
//- (void)addBannerViewToView:(UIView *)bannerView
//{
//    bannerView.translatesAutoresizingMaskIntoConstraints = NO;
//    [self.view addSubview:bannerView];
//    [self.view addConstraints:@[
//                                [NSLayoutConstraint constraintWithItem:bannerView
//                                                             attribute:NSLayoutAttributeBottom
//                                                             relatedBy:NSLayoutRelationEqual
//                                                                toItem:self.bottomLayoutGuide
//                                                             attribute:NSLayoutAttributeTop
//                                                            multiplier:1
//                                                              constant:0],
//                                [NSLayoutConstraint constraintWithItem:bannerView
//                                                             attribute:NSLayoutAttributeCenterX
//                                                             relatedBy:NSLayoutRelationEqual
//                                                                toItem:self.view
//                                                             attribute:NSLayoutAttributeCenterX
//                                                            multiplier:1
//                                                              constant:0]
//                                ]];
//}

//--------Check Internet Connection--------//
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

//-------Start & Stop Spinner------//
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
    // Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
