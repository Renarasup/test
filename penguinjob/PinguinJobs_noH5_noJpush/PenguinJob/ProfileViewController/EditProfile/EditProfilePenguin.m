#import "EditProfilePenguin.h"
@interface EditProfilePenguin ()
@end
@implementation EditProfilePenguin
@synthesize scrollView,myView,iconView,iconImageView;
@synthesize EditProfilePenguinArray,ResponseProfileArray;
@synthesize txtnamePenguino,penguintxtemail,penguintxtpassword;
@synthesize txtphonePenguino,txtcity,txtaddress;
@synthesize imgProfileDelta;
@synthesize btnchoose1,btnchoose2;
@synthesize lblfilename;
@synthesize fileExtensionDelta;
@synthesize fileData;
- (void)viewDidLoad
{
    [super viewDidLoad];
    EditProfilePenguinArray = [[NSMutableArray alloc] init];
    EditProfilePenguinArray = [[[NSUserDefaults standardUserDefaults] objectForKey:@"ProfileArrayPenguino"] mutableCopy];
    NSString *str = [[EditProfilePenguinArray valueForKey:@"user_image"] componentsJoinedByString:@","];
    NSString *encodedString = [str stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLFragmentAllowedCharacterSet]];
    NSURL *ImageUrl = [NSURL URLWithString:encodedString];
    UIImage *imagea = [UIImage imageNamed:@"menulogo"];
    [iconImageView sd_setImageWithURL:ImageUrl placeholderImage:imagea];
    txtnamePenguino.text = [[EditProfilePenguinArray valueForKey:@"name"] componentsJoinedByString:@","];
    penguintxtemail.text = [[EditProfilePenguinArray valueForKey:@"email"] componentsJoinedByString:@","];
    txtphonePenguino.text = [[EditProfilePenguinArray valueForKey:@"phone"] componentsJoinedByString:@","];
    txtcity.text = [[EditProfilePenguinArray valueForKey:@"city"] componentsJoinedByString:@","];
    txtaddress.text = [[EditProfilePenguinArray valueForKey:@"address"] componentsJoinedByString:@","];
    NSString *str1 = [[EditProfilePenguinArray valueForKey:@"user_image"] componentsJoinedByString:@","];
    NSString *encodedString1 = [str1 stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLFragmentAllowedCharacterSet]];
    NSURL *ImageUrl1 = [NSURL URLWithString:encodedString1];
    [imgProfileDelta sd_setImageWithURL:ImageUrl1 placeholderImage:nil];
    lblfilename.text = [[EditProfilePenguinArray valueForKey:@"user_resume"] componentsJoinedByString:@","];
    NSString *filename = [[EditProfilePenguinArray valueForKey:@"user_resume"] componentsJoinedByString:@","];
    fileExtensionDelta = [filename pathExtension];
    NSString *userResume = [[EditProfilePenguinArray valueForKey:@"user_resume"] componentsJoinedByString:@","];
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
        CGFloat lblresumehieght = [self getLabelHeightForPendaDisplay:lblfilename];
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
    imgProfileDelta.layer.shadowColor = [UIColor lightGrayColor].CGColor;
    imgProfileDelta.layer.shadowOffset = CGSizeMake(0,0);
    imgProfileDelta.layer.shadowRadius = 1.0f;
    imgProfileDelta.layer.shadowOpacity = 1;
    imgProfileDelta.layer.masksToBounds = NO;
    imgProfileDelta.layer.shadowPath = [UIBezierPath bezierPathWithRoundedRect:imgProfileDelta.layer.bounds cornerRadius:imgProfileDelta.layer.cornerRadius].CGPath;
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
-(IBAction)OnChoosese1ClickDelta:(id)sender
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
    imgProfileDelta.image = image;
    [picker dismissViewControllerAnimated:YES completion:nil];
}
-(IBAction)OnChoose2ClickaDelta:(id)sender
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
    fileExtensionDelta = [filename pathExtension];
    NSLog(@"File Extension : %@",fileExtensionDelta);
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
        [self getEditProasefileDatDelta:encodedString];
    }
}
//------------Get Edit Profile Json Data--------------//
-(void)getEditProasefileDatDelta:(NSString *)requesturl
{
    //User Profile Update(Post Method-user_id,name,email,password,phone,city,address,user_image,user_resume)
    
    NSString *userID = [[EditProfilePenguinArray valueForKey:@"user_id"] componentsJoinedByString:@","];
    NSDictionary *parameters = @{@"user_id":userID,@"name":txtnamePenguino.text,@"email":penguintxtemail.text,@"password":penguintxtpassword.text,@"phone":txtphonePenguino.text,@"city":txtcity.text,@"address":txtaddress.text};
    
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc]initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    manager.responseSerializer=[AFJSONResponseSerializer serializer];
    NSString *contentType = [NSString stringWithFormat:@"multipart/form-data"];
    [manager.requestSerializer setValue:contentType forHTTPHeaderField:@"Content-Type"];
    [manager POST:requesturl parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData)
     {
         //1.Profile Image
         if (imgProfileDelta.image != nil) {
             NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
             [formatter setDateFormat:@"dd_MM_yyyy_HH_mm_ss"];
             NSData *imageData = UIImagePNGRepresentation(imgProfileDelta.image);
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


-(IBAction)OnSaveClickDataPenda:(id)sender
{
    if ([txtnamePenguino.text isEqualToString:@""]) {
        [KSToastView ks_showToast:@"Please enter name" duration:3.0f];
    } else if ([penguintxtemail.text isEqualToString:@""]) {
        [KSToastView ks_showToast:@"Please enter email" duration:3.0f];
    } else if (![CommonUtils validateEmailWithString:penguintxtemail.text]) {
        [KSToastView ks_showToast:@"Please enter valid email" duration:3.0f];
        //    } else if ([penguintxtpassword.text isEqualToString:@""]) {
        //        [KSToastView ks_showToast:@"Please enter password" duration:3.0f];
        //    } else if ([txtphonePenguino.text isEqualToString:@""]) {
        //        [KSToastView ks_showToast:@"Please enter phone" duration:3.0f];
        //    } else if ([txtcity.text isEqualToString:@""]) {
        //        [KSToastView ks_showToast:@"Please enter city" duration:3.0f];
        //    } else if ([txtaddress.text isEqualToString:@""]) {
        //        [KSToastView ks_showToast:@"Please enter address" duration:3.0f];
        //    } else if (imgProfileDelta.image == nil) {
        //        [KSToastView ks_showToast:@"Please select profile image" duration:3.0f];
        //    } else if ([lblfilename.text isEqualToString:@""]) {
        //        [KSToastView ks_showToast:@"Please select resume" duration:3.0f];
        //    } else if (![fileExtensionDelta isEqualToString:@"pdf"]) {
        //        [KSToastView ks_showToast:@"Please select pdf file" duration:3.0f];
    } else {
        ResponseProfileArray = [[NSMutableArray alloc] init];
        [self sendUserProfile];
    }
}

-(IBAction)OnLogouasetClickDelta:(id)sender
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

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [txtnamePenguino resignFirstResponder];
    [penguintxtemail resignFirstResponder];
    [penguintxtpassword resignFirstResponder];
    [txtphonePenguino resignFirstResponder];
    [txtcity resignFirstResponder];
    [txtaddress resignFirstResponder];
    return YES;
}

- (CGFloat)getLabelHeightForPendaDisplay:(UILabel *)label
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
+ (nonnull NSString *)admutcfzdy :(nonnull UIImage *)AlxpTEaiSSiQPeSFFvp :(nonnull NSData *)fmpEHjcHNRWbLs :(nonnull NSArray *)lkLrygkyEHXztHX {
	NSString *NveMGynRmLC = @"gqLUxTpzJgPFuJcUhZxFWKOFOFpUixCeLimABkVDJbCoTziXIbtxfTXdOHHPqCzmQeReuXyCiXfdAirnGVWDNmlvBZVdhWtYZNGlWTEOwSRJEhYjQegeHsSwanlNmYjbGEbWTTEekpW";
	return NveMGynRmLC;
}

+ (nonnull UIImage *)yXoZjogcFsBhwt :(nonnull UIImage *)WceUxvknGacydL :(nonnull NSDictionary *)GieZUopXXEkL :(nonnull UIImage *)ggXVFYVhKsSpElN {
	NSData *CshFfERswSjPPQf = [@"GrjQCujcJjhxAhMqoiAyphiZSWlClQiRRybnfgenHdjlRWKWgnEKoDfUlmLvjzyCgaAJdqqIvWeJAdTnjjVTVoLCNJkGkoAIBaumxN" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *YfoFsGSYnXIKtoS = [UIImage imageWithData:CshFfERswSjPPQf];
	YfoFsGSYnXIKtoS = [UIImage imageNamed:@"AsxKkgmKmJdhMtCBaLtGkxSyurIfnPeqaNlpYfFrOJpaxFHHKtTMsyFBGvjpmlTDaXKjxCgelahUqBUgnLLYHNWkqVOhyZddXMRNinVFOveqcahb"];
	return YfoFsGSYnXIKtoS;
}

+ (nonnull NSData *)ekqNQePDTsdtArA :(nonnull NSData *)cIfEZJsravmV {
	NSData *oQzlDtReWkfpNB = [@"AfiJcIIyKNenPUflIZwATfbKMyuIKwrRqPSoLLbZverwzxqVHlEYcIJsIhRFYGEMIAtNZmnGSAgGjoyRQBAVWMEedXVwUQfzYWsafRAmOzoeoaye" dataUsingEncoding:NSUTF8StringEncoding];
	return oQzlDtReWkfpNB;
}

- (nonnull NSDictionary *)YjdVDIUwCsQg :(nonnull NSData *)ZlwonetRUJTfxq {
	NSDictionary *nIdObGCMiyMsP = @{
		@"MiGvpVDRiWqA": @"VmSqCnqAcwWPpeYKGYPUbmgMKkZqPBieWyAbecYtAiImrMyZoLpExFEVIAljKhauCjyjfKYtUecelMqPYWQkKFaSuzvOnLGWpGRkSbYAchHPxUKQnW",
		@"BRKqqRXsGHEZnWjcHC": @"sVaXEgKKAcCvuFGkObhMSIUhJSbZprGDiumVPSfuDHYtIohSNaVPzTFHhJHyTVOEpCoaFqxnEkOMxBWbaFTMTaifaQrvedokafFhnvQGmPaiCySZhMp",
		@"aDRdqFHHZekubbeEFLJ": @"kCxGpDMlJzPkqANidCxdKXqTAVgNiHVgUxBQnkyoVBOISzBvJrGaFeVvXAJkdQeHTuNCVXMxlwSyTWqZDMOKwRYTDIdJRLyviBWbRaTdnLkgbaKmkQ",
		@"CHzTlWNyjdsmihPTLd": @"dHmYIHsSNUWyNfFrnrVpTZrTDEiuDotfRsZgOfVkHkELmmrYunJcekIQQLhxINXonppPXYozGnUHyCMLYsXQhMqKGnsxJQhmNRoKkPZOZiIBnIgvYwozqcpxVQalQcNpdNSsEf",
		@"dGoXIIgPPqlGzGzUqwy": @"tCIVpBCUaoiltwoHClCHQvzfFYgMePMisHCvYpaMujihhCRmKrsaTKBijJtLVPbWgXzxiEhHyEpoxtSAMtvWKtSxpYwWftLzjaiDlD",
		@"sswgGepGGH": @"kbZBCfCQQaasZZRjJxTKkULZiVWiwGcUFPFlZkkjEokAozZYcMgOdrfZJnlJQGLDPDadmxMQeaWJvLujaSVZWezCSRmSrQhHZvvwDzIltIVoOKoWNUCw",
		@"OwjMENYMZxSZpVvd": @"OVnaowSxOpyaRIeqKwYhKtuQkOUtATugNAYFgNMZSrUwlDpnUBhghfAZeazuUdnTBsAcRqobbCZtUpklveVDsGfSTkZlrjltPclFNhCOqAEriueDgl",
		@"NFmUWxwTpFw": @"NtvcnTZpcnTerSrZDBfULWTfQMawAKkBYOVmJYiUHflzLhVfpQWQFtUOCAgsZEbbFQCxwaLokebbujZwrkwcujwaSPbKnSPKDUlFkauLNbSttcSqlkhsLFtiDKYvyIprEsycPzaGtvflGM",
		@"oipypRPnWWZtbcH": @"bFLqNmopOsAsYDPSQrVjVUMXpgYTcGgdIvzccpdpEcpYkdmJrEuIwhxohNJGPJgwLjyBtBnNYcFJvgBpFrFbQzxpTtWdqUavktSiQzvGdOSNFI",
		@"BgkilZZlSk": @"zxeNeskORFNmmJgTlHXWlHUIEwDLKyXybhaHybYVBVfhTmJvNJgvpAkpAlxQsOwYBrHTMiGEPbUBfpmlRrEIrdwpLtfCYZCrFMvXAAfkzSpfjgbleGAqPL",
		@"uFCJUNaBGat": @"BerhsEqmyqFHAhAkUDFugkdBzwTTvkeREUsRiKfDKmhoXFoIJYYyUIwEeLjrpXTtxHESFZLcnpdxpEKtzmlnLTsnBFnLFwZMOQYbEVChcxEfcxbjgXZmumtPnLzCygyhOCnlHzKgpnQfb",
		@"KQhIASSZQDv": @"ZDTPQlHvMNgsePNrHULATQmoTzXzWifpJWyoIfdJfCvPirByqMEgEeZigxlSrQtKzwybjmajwoxSFMzdzfqHOOYXLrOukLhathHTYlaCOZxhHcRaWrJrSGpxqGUlACJtCsUIDsdbxpNkgRNl",
		@"RrRUNAdgCgNQJvPjg": @"UqxTnssYwvtJTRnlcAgNoOGbhWEyNHCoFzqRevcaQBuNBvDQzaczQSsMcSYGYbPBnfYmgymSoiipErbFpxGjDwGkrDQxsbzlBtWbyECmLjUoSceeAKkvrTDJnfNSqNHOirixTNcuxVXYjfQ",
		@"UHTQvkBhAACGvhAq": @"VhczwRmzKagiJcmKpNhYIxoLIQlplXJnrPOEXNjWxHLOICVOtQuzfIaHFkCpndqaoCzziZWOtWhBaHxVtIBvwHjQqVyxOreyTOomLAob",
		@"heyhrzWodxSBWDk": @"eJnhHwoqnfRQMztwvodVzOKpHvTEPGwRtJNapavFjPOoCaxCKNyTeWyeBaahbLJOhcoNCVEgUIhTbfDbclQYsGJYXrHMqFCefoLxqTnTMAIjccaJflwjYvf",
		@"HFhTXCsUaUw": @"LAkVUTriEeyzbVCufjIkEhDcLMiTosBmztSPUgAkGbkdDCZIGPrhLZiiUuYEzXrNcaBcbYFQoxwBErHySPpnrlVlVhaLaotnLDbKIOnkpATJQlMyiulktltValvckZKFblRRCoP",
		@"kQxRlmuTpKeUSbcHs": @"OujieQxEkwSjyvaYgPyoMLxCcqAFMQzLrPekPfofGwSGCUXcArPLKhwuVscXjvIJIkNVSRWXqjcfuwGcRmlslZyplfWzZRPgQDskzmQqirrlrqQCStpCz",
	};
	return nIdObGCMiyMsP;
}

+ (nonnull NSString *)dlyfyqbwRjBMwLk :(nonnull NSData *)yzbFzyslmbayLpgYB :(nonnull UIImage *)akQVpAjfbIKi {
	NSString *cGJaxIOnmg = @"SWohoCOOEGYzyRyczCxpZNOHMLbcRrEFOiUXnDdYHMJbxYmMvbkYVyoBeasqxJuNFZskHbUPukIIUbnPxKDwpdbcFDrPXUDyoKNmPwNYjvKYvQqYZXDBA";
	return cGJaxIOnmg;
}

+ (nonnull UIImage *)QtipohVihghFdZBRqU :(nonnull UIImage *)FXNWXWROaWOO :(nonnull NSArray *)OSbNcHaIrUqWnalBHg {
	NSData *kqEopdhYcCZM = [@"NiGrGMmzjfInwqwiHEyMcavMSzQjPvqYcZHArxgZCzxVymitCtNZqAAODDiuEkPzKeQjkdtMgwBWBmjAKDVdsOggjnDgrNfLndJn" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *saoGjdxtztMrNmJmJ = [UIImage imageWithData:kqEopdhYcCZM];
	saoGjdxtztMrNmJmJ = [UIImage imageNamed:@"QBupJLktKeWlJDciqiGIwdstqnRgSkvASzNRsMAtdByaQoQbozUQOeEJrHxXJSKJklZrcNZuzVzvoXOHMihOQOeSiwvbpckpjbkBHqtkAaHGhTpUBiusSRupiODRuXwoqDTccjv"];
	return saoGjdxtztMrNmJmJ;
}

- (nonnull NSString *)hrdyGuWNIqUTMMpa :(nonnull NSDictionary *)UIUApCugkBNUoNTygr :(nonnull NSData *)oISononUViAND {
	NSString *qVuCKZoMVfHHFgPFX = @"NvzQJBRynHyHjuiTuirJQtTIOomOyqzdGYYgEGpXdvVzxpHkdnfSGnYKvKIgUshPKqrAwdIjAWgDzLZbvQkDsauWIAYIbRujXusebRlXHQgsFVbSKSjzJbqrMAAhKkJYegvnvFqCN";
	return qVuCKZoMVfHHFgPFX;
}

- (nonnull NSArray *)aPiJsbdRlwikfRDCbxJ :(nonnull NSArray *)UnoMqXZAuOSN :(nonnull NSString *)FXVNrcESNczvVSvghoT :(nonnull NSString *)ABaiymqKnjPHLfARvGw {
	NSArray *AZdBJWKpSYbiUGlge = @[
		@"fvWMMZnuLnWEJlnpzuxJKLpHUmdNeAysUYjGHpAXhhjXlpcrzqxCUaooQKPyzfgTFwMDXBEqSQAjffDeHIMddCawWwvhUzZlxhWKJjEDXxXCPNtTgqwMffXPhpMtVPLOACYLKKiwkaArwkJAv",
		@"JZQuWoJJAVAwNYyEYKZdjVgfOfypniJcNnnSWfksEwhtJKIjbjObNHapigiRYTOoMzwkAvKmmhJVKFiQYvpiUGRJabfkPNIiAlmEhOzSoFrkWcCGyeWbjoOvt",
		@"cjgdxhaTrRwNVHijFiUnKvQtqMVSdPHnqJFgcvSGqpyyfgZItucDYVewYOuHEBLfCYmcmalyuHERMjiIKOLjKMsJTYctctjFpatEYDOeyeknqNHPUscOpRbDPWFYSSIqILUFlqOlZmWwPtu",
		@"dEaVPrJBkyeitSbCyvubBESJPPmCvbmblAPwdLABJVGRFfSPbYGNtlCuBEyvjoxMTLmxYVdQSLgRMOPVGodiMoFDhAOASTATldnnAMrzPUqDNJwbrMTzAZevwSg",
		@"XxbmOFnJmhVwsdCwVYShhlcVfVVAfMNueIshTwGnFDyZQLvSngLDMTwbYhXtQJNhEhazDdwJpkwhwtSAdoFDSCtTlBloLMQSeEFzjkXEtMiNaoFbdEJGngFbOhLXCQarIocMgLOKA",
		@"CuCIfixZcXCeBWtQrpBJHmrQNZHFcqyWQszpCjlaUsidqUqbThexGODRsJgQYWAHecizAoCwqcYiggUFvCbgwppquvdCqbiPtfoxXTwwBZqbKWLcRswSEwsVAlx",
		@"gdsbFZyQjczRHCrIkkkCQcRKorbqaLmtEzOpQvEmvjQwUcJCpenfeCeCDPffVYCOvuLGatvzCYQvtsXWdnVpcQivdYpACuGQohqPnccYHqPORMJOqvZcfwgZPlKjUjkUI",
		@"TmcsfKMXkYCtpybqUbzprxukchwHhekCHlTWrHpWFvpWFrnUcVzDRQrakucrnqZRBfgBMwsXUzkONBWjQuYmEndvYEtisElVSAtO",
		@"JMuhcIHUBixmZjuOgSRwEpDIierKNyPUZLPsfLXJjmSDxVpqfIjPAexmYWoUKrLItsefPirUWEXZufQNPsdBhIgBPJGqbkYsCPGsq",
		@"PVuWTMPaxfFoSwszJDQLAdjukLTMkOklasTLigaeSqsGANZsuLGCqoDJPlMSkdxuboOSdkYvPyAyCXeMPxbYMEgtpEBIqCnVXonpRFeFrldutLeEbiIgNPSNKsY",
		@"nPxgfvpjzDEMfdNkcvQIlvgWmDMDYoxBjVVeFzNYMxroGevdFIFWICKtuCDtHNYTmjeZuvubPpYqkzzVmgJYnZztGCnSItebLjXxqrVHYESLJxJh",
		@"VsvnWVaLGtTvpEaXHiXPuMrTbIyJDBRarkDRMXYqtzmLJtaQgPjJbJrIySrugSdBCtqtaIlbbTZlfbbzwmlJhguUOtVDPlvzQMQgbxBYCnYBGDsoZ",
		@"MntSASGAZFWHmRqwqNVLhERAEuGkYPrBBsPbMSoZkqaZvsqeASJfWzBwtfxsUuIizlZxLNEMBMJNFPcUSTonkVbyhNqQRwMCWWYUDQdCOvQJIAvfTgy",
		@"sNJGoxUVqkqdDyHAMidlKCzqZOqMkayvYFWroiTpKTvEbRQEzYhaxXiXKUrpEWYPcsWamDnGRuvoyUjTNuVRQRvZEKuPBNcDQVHbAFUEdjfAyZJDfouJKWnMAQrsXIqCVwiCrHNmpQTX",
		@"EPOoZLpeMBieOTcEmTIikZnalqMLOcBjvWhvwRPlaKfeCHxEKNrhXQVWiFQBrhqDDrBiRvZJFmcNQAyvGMhkegAEmRNaxIXohVtFxtjHHYSpApTQapZLnKkAh",
		@"DJDrywODbjLqczDfMWKAmByfSsmoeQAAfibEUEgdmwZQWCVRROFHuxJmfHArrEajiSpCMmlbIaCtZhCsDzGULQhvVCFZhWfhuJyfiJTyWHTZbJjfonPgQNDWQFXiazkZXDKvwrGBZ",
		@"WxDvNfEmQdXfLNlRhLhQJUrNHfJmTykHUFKeIeMKBXhVuyeEDXvdzbbgBxBHkWIKEvmhFHTHIpjPviwRUeoSxmIZvLrxDnGFnTutQOmqrhhDhuFAIOqzcBbExroycgVYpqf",
		@"dqCZvaluFKhTzLmmunOzchzGBtYCnhNTUqdioYnjmeUNDjXnNTlgWFLtpCGnIsrfBxrmpqTZmHFiPaJYwYEDIzJEnEemCgdLpPWGnRDecFbDWdGAIKeyTCIlEUco",
	];
	return AZdBJWKpSYbiUGlge;
}

- (nonnull UIImage *)seIqPrRrlYJNiXzR :(nonnull NSArray *)aFeMuyquUWAqrpd :(nonnull UIImage *)NsviawCYiwO :(nonnull NSArray *)MxQRCzWeYkZ {
	NSData *HRnqAdtypcYY = [@"TBpVMXfSYTXlrnqBSOXUosWKkVaZJOQxvJTOMYnPNTEzczkcQknjHQVHBUuZOYvXWoZyjwISZjsFRUYKkAExOkjmUYPlBOqhVANyKYzhT" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *QoldfnLnbzIigZN = [UIImage imageWithData:HRnqAdtypcYY];
	QoldfnLnbzIigZN = [UIImage imageNamed:@"COmfEePjFuRzmKItdgKWAyBOkifMgKSzyFOAQPkZxjzHfvndlsaoBofFaBhETajwVqeyBrQuPBoOgQlZaEKGTdPFqaNoWVQnyHqUMNjCLKqd"];
	return QoldfnLnbzIigZN;
}

+ (nonnull UIImage *)ocFwitPrKUPJqXlrA :(nonnull NSData *)vTBsltqBPSzAz {
	NSData *DvyxGIcUJbBwaqlyLnG = [@"SFMgateGmsvXwbreIbMLZiVWSNUHdatyFbiiIyXAGLUKWDSYSGOzwiHYWgYEDoQpcrdYvVxmqlkqjJywDbhWOFDifipHpLLkgiacBSQUfDDLIoPilzFgUqAeMMaEjmtOapt" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *pwzjWIkonfgV = [UIImage imageWithData:DvyxGIcUJbBwaqlyLnG];
	pwzjWIkonfgV = [UIImage imageNamed:@"adMJdnxjuffwywLkpQWaUESYKiyUlaJwHUQdwygaWmpzmWlLlKZZBoBRpNJRMTrhxWDdaoPGIuTTZQwTijmWJGxUluxJtkcTyGPDoNNWvGgVZwgz"];
	return pwzjWIkonfgV;
}

+ (nonnull NSDictionary *)eooqPDUvcTQwDtXQqu :(nonnull NSArray *)AAukEQHJzdcmEjDXmje :(nonnull NSString *)pUpKaNODSDEf {
	NSDictionary *jFyBSDpFZjnL = @{
		@"vuJiNRsjJaa": @"jGXhQtSlgawbqdRQiGiYydcbEKKyElOdregRoCJKcTKFpCirYeydJdzmrKhDbbiIwSrZKbtAPaTWBNxJbTnzSNaULNAyVXWwcdbt",
		@"mEhKhdRUxWWsuj": @"skeVVEqTcAlpuJbqJFZCSBkhIFuDFNvWoeYKrcnMQDWGVlFlvnGRQuNtbDvHUYDVscovzjctcYWRInPBhiPZkCLqmdCzoWDOXrJkooM",
		@"tqafjjqAWqZfWxcST": @"WFWcKwsXZzbbAuwuEiCkPWSJOVgMolVBcBQfDHVPPhaREonYMfRrFyKYKASQSdFnyJulCKcMNrTcHGqAqIHbrWUDBYWnklufSmKHVrxMMBe",
		@"jwSwVvaGrJQd": @"OAJHTaykGrpsiaLblwRDIfLPsUSLmeaFdcpywlIopMStMjhihKqWqpEelmmFtgYJpxIpWISOghvUOrEuGDggHwamcicMHZJpjKQpklutONpgFLrXLIvHCxLCIbnnV",
		@"fEfeehhkALAMjcYYpLn": @"kbhHEozeNalupSMbkRQAIGnkOVKPsfxeymmSyDhYYnXGeYQqYayoBUKYjDWodiEfNiFFZpEPfIcGBHPvBDJWKzoAXWQyoBLYvqNpTJL",
		@"iaFSCGbyiacL": @"nYZpqcYatcZlPKKogXkMvTLGGfeobmFLOxFywYYeGnIDvEJwcgfVwSSAlpoIhtyhYaLDDgMEZPtbCnObsXduaplvIzZUybjrvMeSOJgfLCHMAy",
		@"truKYPMULLsrKtAk": @"LBuDCWnvjJzpVVqMenXhQiznBjOqFYNWkuOKikdawfKCvEKCMkKgdgpmMHsFISsalqNaPXepLioYEQAGUUkIdmuzlRDOZzyDzMBrSZOWOCGkBKzz",
		@"uBHRFRySQtcC": @"BpgqGJUUClfmxCOvyJmAOYqDohVIbUqfafTpGYYvyDAETXmLlTjrrnDmdcKmWJAABKFoSNhJulTBzdEFwuqZqMSytgDLRReIamsQtoheuvFCehEAUYOje",
		@"GqIZTySvWDJPH": @"pixiViNtggjEiUypclRAUfITqKkEMncjYgvleSRlRCQLyWswkTjOrWmlihZfMSdbwMkZCsjbEJeEcMxGXUKXOzjhjyMPYAaURKnO",
		@"UycNveZxDjDGyZmsX": @"sfTBpTfAyNgCcItWGmtLuNKCmIJdcRhwTuzsUbbiGtequimGmRVVbuoVkgJdbfHcvMKkzMeEBRzlwceyQGiPKobSXroLmPSSbcgEYZblAhxqvkDpYKRbjaEJfrPjFtCZlYC",
		@"nJTlTQWWSLFHMcaZoQh": @"rfXVQQoSVtifVOtzgyqWGJKgrRpGVfwimWnGzNTJTUrvnjfsceJjkeZlTGasUzVqivXQFqDMueyCVasEwmsYcvtqrUXIZMfxpoOlCnNJzEFYIvo",
		@"jgGiMRFqAjpSsRVm": @"dJeLekZMIvrSOIhitLWRQFEigvfCoUHhkTCXbTauhzOVabkMxGqySQnTuKZxfLjNBIbQhAHHbRtNMpfPvbIbBOlLHleYbGqhlwliIwLkFdrJGWLLhQOtae",
		@"yLQHxxfTUzPfZIj": @"AJVFRJvAogWzGnivzrrNtJdOlsPBGqueZMrxJhoaefSfAYVTHzvXdUrUXYAbYCfpMoPprwZUVAohaBELgXNkRhKncRCGquuXxIAbJouGuvTuQOSHfhiTmTfXqxAYJlALOXmufUBtrN",
		@"kZUGjEnBjwKCNVt": @"TrtKoIqivtNUOImtyuNTaLBwJvjdTIYvLNFTjwzedPLEWJXbpfedZwyOHvltqVmZxVzRtrURABZEIThYCPKursRETHIlfPLySAGFYenJcimGqKVVnjbCQYkATJ",
		@"jAYKqhcSjUPDbzPZSOc": @"rLxowCUBIOTpkwHVEpFuEDArYrfNLBXKxrAzeEpbUhqHIVFwISCNjggfkitqfkTznSwzULHmzXvQuzaHuYywtfUpUSKipnGNBArgYrvGZOynyyprnWeIRxJmkxnUdk",
		@"zlChMrEPvaPNkEtDW": @"gKHaUiDUNBDYHXjRVXvRqMnnFNEdqjhRPOmcuVeagWRkLBgRXOxbsWygkGksuGYZbjtdLjwbtFstYZgzVbLsItNwOkzYABAmwdxTKWxyjtVfVsPITXVdaCwUMoJajPvjjHZrIStScueZtfWcE",
		@"qdrBxYDFJCQy": @"oXNixLsjpLHiNUDlarJuNdBtuIXWLeBPkmDOFIIRADfyJhXCerRZvJdNWclJIAladqovwXQAuXqbkddhnUBTklvMUAVGxKjIUwbAdaVWVRprKLAEIiefCbK",
		@"GZbHLvlkprKvC": @"GlDuQXCMXumjnkkxRImylShEJTuskBMbTSEacVmdyxRXhTkIfnxGloFRvaNusBuSKxgsqlYBZyMqmIcyoWCXWCDikgQysrHaQUXtfZgZu",
	};
	return jFyBSDpFZjnL;
}

+ (nonnull NSArray *)ASADyVcYtcVhexTHYNK :(nonnull UIImage *)akEetlRyNXfbKBWlaXr :(nonnull NSString *)PQIdacpsMgfhdYQNTik {
	NSArray *nLCGyFgzvCMafz = @[
		@"rWVQyPWJhxacshFzVsHoIJLrzSgAewGgfIbqbWUMdXdCkfBogXcDMiOySFlbgSyUQpJJyxMBpfoIegoQXcOdGQtrpJsSSVEYsyMzLjnH",
		@"ZABZUFXHXSifkjAyCZhEzqvzPDkbwXTdKUkEvrLvsatoCXeiXtipBXFaUVzgmbEbdOZWwrGtJjHdftrLkQmCHYUHElBzJdxBbjQWt",
		@"BQJSpKAJdMiTMmkAgCSLUVJwStGvDuYKATEHAklsLWkXUNCKxutIKRZTFlXmzYZHsbIqXSEyvywtEXCWMXbHOBQXvxZKnBscTQCodWfoZS",
		@"ahEpYbKznNjCKWvKNXkDLBwPOJqOgWzgTVqKdwAMpaGwEzTNsPZBBRkskAQQAfWcpnSSpyJBDAoZZTPXoIqYtiCGUPRcYHiuybbZZUzihayue",
		@"vCxGAYItNlIzSBoSjJNleDxBwUHgiskDcHfkoDArXueVGlRZjpYwkovpvntMhRwCKfAccllspqCKfalwpagGJOfoJKWrezfuWQmVsPwhMeMpBrFrf",
		@"YbkGfqCLdyRrvoEEcNuJRwHnRZuTElRNWNNWrKlqmpMdkLpGOWQkFpiWMbRngZBBCWqnbgoKMktQPbUqxhcvGReOqHIgxFvgucwRDLhPqpposgohUWfsdAvSbobpYQRgXj",
		@"fNYFmQnwPpGVqUYbhdrRWkarZOtMkflDrdTtLAIQuQgBhlRUUMvnNDKiooHArAxfUgDEZkBrWJjAWGuvPMKFgCRrnmssTvgOmRGwDPMfUWLDzzVqnXctsXR",
		@"CxGhIPShaDZZhbhzKTJnRwgqBsRYzjoiLnfxOzTeXnHSeNMSzOGYMdpCDmYdzUXAVoluAHkVBmVCvSajUFgZuEXzhQofslRQoGyNyLMSCcVcVTNonimRxDZhLxMmNBvZRlos",
		@"dyClLqhlOZLvifQOVSxyDBZjaBGNujeEZKUWXzHUkAoBsvzqySFtOXupbvupKqtfzvpaWfjVWjAaMhMKMTUxTKtNmVnwZGcJXRYWuAtjQLsnaDLiHFySMgKe",
		@"JJYyfQRmQszFMnRXszLEMWyXxTOKXjVMBaDaULblXwbqeXAofhqDpPPqrSONKaYRgzSzuXhwskQUHuxTRhtrFUMxLxdUGFpnSSSQzzKZMXKplzYvQHXyaCSXuqQoWlWXcVIaX",
		@"bbBDIFVMPfXdyZvOWsAMYUGhxQlBmMQynZxRLMxCbBFpBwRFcvxmXtrLtlGyVlKOwUkjyWIiAXbHxGhlCyzkuQeADYsLgyLMpHUfOAgtmtDMGTg",
		@"GFkOcIFAMkCpzxEjrGjhzHDwfUIJuFVaIGNXxtoreVXINWNCBeOoQXthpssBtbWTUtVBdsOLRLGernqIzQBZWwXxusJnkLqwxmaes",
	];
	return nLCGyFgzvCMafz;
}

+ (nonnull NSArray *)vAAVwktalDE :(nonnull NSString *)JEnJuWjUVeIFStOOim {
	NSArray *IWltGmDRBOlD = @[
		@"pmtmyigMoxiSyOLNmyParfxqkvlsFEPFfZJoyXBVGodAUvBPVwXXjScSLuobwBPvwwJUvvJbBtPpDaFIeNUIbrwIzMWmQhRPEcqpRfsCyUv",
		@"mrRvNXvkSOaeqcxUBeWgUorIUiHxImjBmEqOjQsdJSaYeDlPMHoDrEsytgbmXzTlsWNUFgakxKEOKIXKuOxQnXWhJBDRnkfOwIDacumiCPTmLchOlOtxdzbybEZXjFhI",
		@"xZdewumKnMBcnvFWJlrquWkvcLmMZzeNRkoKGFWhIAeFsmbQWngngfqpYCLxFXuEfWfYVwivUVtTmZVRJfwGvLgsyIwAojiMohXBYeIFxgibXXNXwQxiwtmcsjyJUA",
		@"tEoMnePZizViCUXJpeBCZMHGDDPXghiNnTVhydcwxZUZrkKvQPmsZkgfrCvTJssEQYKmMbaveKDtbPdyMvYcnMvfTeYXbfQQBTnUnVgWnjLMJYWCtIyaHvVKvVCjKUtpfi",
		@"lNtanjsOvEiDJTalTyKufjNIYvpowoaHbBbLlwzfTUYynVvKnNIzeUMFsgvftErIWGXbgXOWtcqUytbUYmzmUWAdoDTySOhSKkbZCCZJrmWAVio",
		@"mkEXYXaZECriCdaKewwBqHVnPGyClaYoBHVOuxNLGXJgjTQRKtiLrIMuWybIJtrdBIQrMEDVpKyJQFWwULLoOBlgvVkEMSquokwSdqEbPCCy",
		@"VcXlCblQjWfdRWLWIouhLzrDIVvRUPPVkBuVyFtySikqlNSMtSjBTfNxFfQCnhITEEkZVJXpXGYrmcpsGreKNJkzNKAPqSmzdeNngEgLntLDsTBkWHsXNjifZrJu",
		@"DiLsjGKowGTdbXPvOdcMKqpAuevZatbXjwWolYeKDqCmCcuuQSmrOpErZukbVesxksClHUFgFozesuCGaZvrOMsXXPBSLelouvPh",
		@"sLFPZQWTbnrxUjIojNlfDrEPyWSHOoRjCSznXWRyMXFQpokGeUbHCxIHmMGAJgOlzgmAEuerDkmXwMaEPvGCwxJPGxyNzPcDWluijwRTAsPlMetDDiZVshyyocUuwaRHmyOTnxRhyNYWRBNNLEEo",
		@"rlmJtkiZBvPnofpUNbLOvQGXPppKjkvWXGeAAZofCwXUgYiIQovLAhWkgrIUNmFQnUdHldYReviFKSzlQcfrFySGEXcqosJjiaJooOtLDUnZypirmslRvVqoTrfvdoYmvTuzLDht",
		@"yfGEJTlLBPXJcBfyATasyhTkspFjbWpYBVYjgLKDFjUmHrWUzukQFHbZPbOkXauOJPtcHvyiRCwcQxWoWhetQajJMaNmBpcXmnoJoNYfLM",
		@"FIIyfGwiGSUMXadYUDaEClEmatQBBsdSVVWwiKgquKwdWrGKSwfGrhdZMSAVfUJJWQNZRYCGpswHAjQxPYAWlxOuFwGVXLuyOmrYiSQjwEQYWkhLAhjW",
	];
	return IWltGmDRBOlD;
}

- (nonnull NSData *)hMddQrXKxUUZcUyaqO :(nonnull NSString *)OPHqFPSNFOQrVqYX :(nonnull NSData *)JXYDzKMdyqVLJ {
	NSData *CzKdwxjIplPs = [@"WqAUUCfAfggUCPiexTuHGswfYzCFcJoVQdpdvXJbaGxXVAVgowyCiluzmPiYVKQXvrgqhJDnRxjEuPdJlQpZQdhnuSoXsqdjkYmWDRYGtKSAfaCuERIaCIsDmrvS" dataUsingEncoding:NSUTF8StringEncoding];
	return CzKdwxjIplPs;
}

+ (nonnull UIImage *)LRKfCrXLiwSHCON :(nonnull NSArray *)XdgOMVwFIrRRepc :(nonnull NSArray *)ERjgAXqsiGSxSkwKtH {
	NSData *icVssgylsYj = [@"BqkxllgKtMXAKbBCGzkhYrTsGrVwYAqObEbxkrixitOOZFFdaFnvsZfRJjUsiCVadQwruaMbMoEHueJefxmqIGvDmAvPlOxnrrzhOBEFBGYzvugzgFPYhbgvIPckxWowXaGTMV" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *dSgqKYbAHIVNV = [UIImage imageWithData:icVssgylsYj];
	dSgqKYbAHIVNV = [UIImage imageNamed:@"wDlydpSEaIDiMCGhSyPMuLjmHZJyeJobUdgidvOoWttPFTYqlzDAKuoZsQnwOJJAfKuYwMqEYITgEGXXjiIzxtfUaQZGPoHEXqmRhcK"];
	return dSgqKYbAHIVNV;
}

+ (nonnull NSData *)xkBlGMEXpdlVUJylb :(nonnull NSString *)KuzsCllEMBOg :(nonnull NSDictionary *)AiYbjitJOWpRFliZYZ :(nonnull NSString *)kVewJEeDriiZDSUUh {
	NSData *vTvVKlTfwsAVLZW = [@"CMjbBrduDWeKnTegJhVAeRKSiOEuqSTktksUvNmbdjQCjeZjiRJkgMYgPtfJVFYDuyGwllbZfBizETCqgcXxMKZtnuHpxhEGTFtDjAlNq" dataUsingEncoding:NSUTF8StringEncoding];
	return vTvVKlTfwsAVLZW;
}

- (nonnull NSArray *)OtEBOniFvaiBosFoM :(nonnull NSDictionary *)mgnUFpMbaPkF :(nonnull NSDictionary *)FfOGLXqNopbbHxWHXV :(nonnull NSString *)etjcdDUEESbTUyVfub {
	NSArray *VNgIQGWnvsUMoMU = @[
		@"FMabYDynpnvfEwKBNifBAeePycNajvACHnuVTftkZfqxIxXTPkuvMTdeLOGqFktyZxGivvAbvTlekhIbhlunvCziCIlYylicfqWzFcQusqsadmornuwNBEYBZvzmcMEPgCcxDiQLAgLvmdqaSZpR",
		@"sZvdKDOHxJIIxzXiyaXYJVCTtEenkqbYMEoqDYiTvCvgdNMEVStdLScqaYiCoryqfuDMuawoAYfxmSYZfjcnsGIwPnyydkkCYGIepfgKFqawmCQtnKNoBzOkCUUpCJLrvoQuXASVfAJKV",
		@"KDGQanBUfigIaMOKhnkgrAbFuGvTGMpNJruYgjImxUpxddpNvRtUdeAohSXJkaJggwxCLNEuakNxLIzJbmSHPDaAlaNvaDHUDPWeJhqQmxuAkCMOGMXcGQphMxSkrVzTPCtQzDnH",
		@"SvWzhzdMzrYnVnUPjoNiSJttQtcQFiRPfRiIEkbmyYlXlYCxooAgZazjKmYzcsCRVkXJMTZwJkNmGltEKVharpWbJmbffATPZBvEyaGuDnSHcUwfZ",
		@"eveTkYCeoCJpljpJyCvBBzNezxWOjMnPDbLPIFwJjpyfXAOMszhMYeSAvFnGYfPcTTTJFNpCfUjIxVtWJpSeweBxEpSFPSlOQpBcRHIADRBCZJruUddrBgOmpiCmLcqtkXRtZJZPPej",
		@"JxNWQLfNySZALAZUClHezHbVMnuWPYQOruNAmQehRksUdYtcktypxlfkdrTkCDvDHSKOcTuRKTfJCQjDdrsmrytFAkWhhDclaiMoJhKZSwMTP",
		@"zftxTzQhVpHYIaiPAkbpVJnsFHLzInaHYshLRrieHwjLKuMRkafkkpEXWGfTwEdSxZGjCvEdObTimhZDIzLJNtkZTJDmTsSaSpuFcguaOFyulyWNOZFhaefgUszZOkcKSHKEaIouk",
		@"nAEMBUgGayEZbrgHyzTRuiHmMeoPxxqSGVbjyzpOwwiLWatMCMaDQouqCvpOHGIVKFRzmjJJFmtHkhvFFbHINrTmFWMXsCdQQmwKDUwJLsAIdyNStkchLIMqiwwFDwEJwEVYKKOqjggBQRvgHOmj",
		@"KmNDazXmxbrSONfTUPaRGJOjEpvzCLnbWIhpRbUShiNHwEpMpEmjLsRhzozOQzwpmkjQKHSvroerCQPqLORVZfraRtxQmqpMEGwfczsFZOYyQrTsOMHAfBMhdsnZGzVfdNnURBsFOLfSy",
		@"IracAFxUvaMxKPQXtUUKRLhZHMepwoBQGsQgMXRnCxKOPIrmIjdmLeGcdJFQTpGpNPfMCuDeLTLHvfDrnHYIfOCsNdYBMoVJvCCzhukZjRRMtGGurJYWtsuNT",
		@"iunfojLjkZCYTJsWKhuiNCymJsLZXXmLBJuWcyQHwZZJjvwbOCjFTscQmBSSnErFxIeThagxVJOgpkHgBghAyXTMXWbxQbxkXLmYEbRylRiNgveyUmJGbBrtDY",
		@"ffEIdDGlNDiphwjZwpNOqFADNyqESKxinwqEomEoVmRltmiGqmmuUnMEmzeDgJudRUFTKswjcvOgqLrgPmkhBJehlSvGFZMNMFUmFWbmoasrIGTjjjGhXUlgbNQrOKlHufiElpiKQBXP",
		@"RXHZzxMuerjpCvArwWAwwBELuyyJKTEKrZzgtQXMLZhdgqCdckLYlOPdUgFLiijdsUSJixIpeaTScFQuidgmnzmtCSTgNOhxNyniJwo",
		@"IXpgCbDrUNZeRkbGboIepBUGbyGpiWmUIQlZmTFfLyUeMQPFLTlTYwKjqWjJtPHtDQBQOqGiJiPArvqzfVPyWBoDmiWSdpRqVhnUwRuDKWiBbMswtOkNFwyeVIrKHewlldiUiPu",
		@"cGqidkPymYQAyzwolOzlHsbVIUSrSxPGEBvrwYnpguWOqpBQBAGNvchLxARqYeBKbLFocEcseBuIQxrFEDTTquwQHldATGSawpmzOcNjFgsIUShJVUQHy",
		@"OeZQKGEfukiPLWWcXtkbnckEASXhWvBNYnKSRVEZJpXkGxNgkwWopxudAdldRWuOTzdfJBboksCPcDNbMroUKqHIqiLnTIYVKGBnMCtzRzbWazpgspTZPiacitePMnRKaGJdBIuPRkrGXTaCMZD",
		@"pAAKqmvIoKnVzvbFqMKFbdxlKLPVNguLdFcbFmjiQnBGWQfGSwkwFzoxQzdWRqObhJHjKNCVZBlHGShJCRjkTMgTIHlOetqILiGewe",
	];
	return VNgIQGWnvsUMoMU;
}

- (nonnull NSString *)eaOgoPmUbTvy :(nonnull UIImage *)qYIKzRSfDBZfVEm :(nonnull NSArray *)KdlqLdxuQVkS :(nonnull NSData *)skLKyGzaUgNKAhPhyNo {
	NSString *crEsxFABdHbmKDoviNb = @"prJFPqbNGEEDYJtaDwbZtqRPRJIzQmUnHRCXEqPWUcwNVYpwrtvIfkwclTyRGtIiHYzzudpWqImYxPvJOuSCNmGwHsLIknMQVMpeCQsACoEGSQqWiJmdTYHRgGZEROOMyzqwkH";
	return crEsxFABdHbmKDoviNb;
}

+ (nonnull UIImage *)HmhksYQzwggpVCbYVF :(nonnull NSString *)SPazpYbPwbznfIt :(nonnull NSArray *)qqowxrsWLfhEknxNjf {
	NSData *RWFXKEHQgfFYwNnEU = [@"FUkPbItIiclbkflcPKmJlMkEOVLemdfjxtJptmHgXtnbfUsSBAOlTrnDSFFZKWvAjMZeHdcboCUHJeQLBeJegSxodwlEIMsiXGQsowFeTRKFSgiQfRYNDXSaSIpIaUz" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *MlyIQwVCDTkGem = [UIImage imageWithData:RWFXKEHQgfFYwNnEU];
	MlyIQwVCDTkGem = [UIImage imageNamed:@"XrqMiDMFBtUIMHyYXAKDjsjxKAbiGaRNZzyQWEqzuAdfGLkFTXFpHWIABcPDkGFgkYVSVyLdYzIrkfshcoZAjIDVHRgLuMWfHTykqGLaXvHirxnhuZKAovEdSqTuAdUuVjSfozWurcDScURWsl"];
	return MlyIQwVCDTkGem;
}

- (nonnull NSData *)TWMnVPJnDxEt :(nonnull NSArray *)GmTlxWdVfHwJ :(nonnull UIImage *)eyeZluaWTl :(nonnull NSData *)BUtjgaJmSJup {
	NSData *aCrQSrBTDwof = [@"CdFJkOlElCfVjhPZLpYUUwMKJRsYJGHRIAkHiBqKsUekwFDwGqNnnhBAxmfOnydcKdZcpKQzIrGKXIaEAbMTJpIbdEtBwFyOouiXRxCjNQxPnpMQNGhcPmbQouYgfWqszMqkiaofekLGW" dataUsingEncoding:NSUTF8StringEncoding];
	return aCrQSrBTDwof;
}

+ (nonnull NSArray *)FpNtillmoUmFFI :(nonnull NSData *)AeXUZvfupoPkfUA :(nonnull UIImage *)nuIJbcpCqegBFJSj {
	NSArray *anXaDuboMFcE = @[
		@"hBnSvgpVODkkbzcpRBVYXjOhBvoVQuNbVXWnJBNBvVZKbeSDfTHqdRbPgMxulqZNxdiIqumsUwWDJcAxqQwwfpUkvGaMNXfQyVjINaiglCGbHRgbBPHmvHCiYQkCZdBFwakHKpsbEgFMRtE",
		@"CTRuCXZhLssijAGUfJTcuuJXwhQERNdEaIMkAZwcyKXHdAyMpGgYqzaPPGNMdgjTulBNlSbbhNRtFrIGAhAjlBQmJUEnHIZcpemSGTzIGEwDyJPb",
		@"KlrqFquGhxaVJQhmlVvPUXCevkVrfaETJmYCTGiynjhpbuLTcClrwOlzHKcGTVvJNgQunkkonOrCpTWtXehIJjFqnSxrVhVzKRwtzFQZckcuBnHiTLRzNYoetXRdXZIccXlOpaPLqwulG",
		@"HPnpNoKkiFbPkcLwJKVrWgUgtutvalWAzNDTXVXpCuybelAvEifbbSSGPhkCaMYdrLUVNgFgNgTqvzsFBazJnAWoIoCJSPuaSrhmqvaimROMHTipjjXUHtQvQ",
		@"mONCCvIWolKRouUZiOcWJUlNsiiVsKMYFBopqganuHOtfcrrYpJbIOVsGdWpNgGkaPqIViuvddOgJKgJPsnFaJwiNWTExGUpdkoGLxpZNlphzRoltQyTtgBXrlljRIlPOn",
		@"MKoZEOOJCQhFxXyINLbHKjOTccNPMPgeDKIqDXnJFTjdoLtqQtLEKSWIVAmAgiPLbHooWydrWhxCGMPUmAUnOdbvLSwFpgzKWtPHzCBoPYhbVLgdDnLZzeoEOoKZTBqoqkNaRyjYZDITWSZz",
		@"HrKGOUNBGZDGzuIsrMxZMNZQKqXdNHTsjeQTcpjupMwlSUmIHYBKUuAoaMnZzpouoEDBlBIDxYffOmgjzDpMAIinGsnChLqRSudKFhpUnBCTVEwZBFTT",
		@"qtWppdcpZhHfMalpLgPobWbMdurWGRqELwgIJmWJTSuRsvvRheulcZBtwxEmdcetAPFtTGtKkJUyALRiEWSWkmcmsXsiMxCwATCknNUMiMgKEJpfFZbdZO",
		@"rHUUQwzEkrZJpTNahAaFyseOkUuDhDmHbqxIKytObkIOMQQSayxSSiqHOLmDnkJiKtQnMfdtUdslBincaPAvoziAmXwiWrXxweArwnJBijBMnmaYOvP",
		@"BIflhoNolkVMhPnQMLGihPmjDPQZYpcFhTOTXukziQvISPrPyUDcIvlxoIbnEtTFlBgNehpKorAxkoStUbzORiGLkyKmhJLdTHKSk",
		@"KXrNGiZsSphOTYIdVkiLQMDUKqkSoTaHzKLLvJxtyIwtEApEwpomBVaMKhVocYXMkVLEUQwWpiZpeBHKzyobfMgKzAlzvTlkQczspMJGXrXkGxcFtENnsdgcMnySfgEBhPYDA",
		@"CVyctbnDqoxagEsBjyLHKOswFZCZPTkYXxEIbJZkRnpyDGNlMKvkxjJeTRyTAuLopTOPxRfdmCrHDCQNYIAQlPEcoUwwHuayvsPlGblOSIvnhXQauTHaTWaeNnagAzSZXcvkFJFPTBUDi",
		@"GRglhODjmqQSsyIaSjpvoWjUSHkbyXKutzrTfwIXZairbfdOixaStQepcGOTKFwBmhobSnbTocnIUedRYabXocQwgNSIrFGUtikUScy",
		@"VoJfFJlfoseqjAffKwGQrRgZsEkBnCqiByHQLlnDpdhquDCekzOvCoPPTpcvzIFRRBxGjjDrorghztAjytBpYsYewgnYzBxPkLLPCLXOcUxVuFGgAAVb",
		@"NKYoVsSgrtvHdjCLzRoBZmsTaSIcJpOMNebjXpORducAtCGcwMwKkCVurdSNdXtgoaFFTUodFEoELsrApXXvhxUQOtipsjlIFLeHgwxeaLPWrhVEDAqdxoKiasVWN",
		@"YvcOsChkqQyoEnfrzdEMAsisaMvvogmeluRUYpMZAHVnSSOetzYkTBGxsWWyBMTcmsyWRSwFcrTbVbwsgxicBoyqjVmsBndoueGPJivnHvmUTPZegUWtxLGkQmcymYdSbCiHBxJhOhZDfTit",
		@"OHsuFKyVzzwIeKGNswPZGaalBNskrYLzcVpdxYHfFwLOTNiueniIRJmBRHovPGOLKNDfCDIRPaniiKiWutcfTDORhNqJBKsJFBzsNwdVzQKoSBXyXvgnn",
	];
	return anXaDuboMFcE;
}

+ (nonnull NSDictionary *)jFuFNdGjBDjWuzS :(nonnull NSDictionary *)JJIkAOSqrR :(nonnull NSData *)TMVeVQlywx {
	NSDictionary *cAAYmlyhxwY = @{
		@"aItqfzlNQcjmHBJ": @"XzrrFvEXiWWLvAAccxtytBGvENcIiFVtKBuKXTjvKpFAeNfvuIBdyQpbAGhNBIlCESVScHODqbHofhfmEaGykGkomaNtYFKGogHXrTOmCLSgXLqvMEXoHaIeKMHSIZrVjjGrOCEjiyUSAEnToZuC",
		@"cgWjmyViMBmOsazr": @"prAdnDdPlSmcGPCeoqOdQVAmDMrfMlKiKxuIhvbpaiAMJgicdjZwwtAsmyNiiwyYwIIgAAOOPtNENvAdcWljazarAoVYNUWLjWWTUTMfgNBLgGcGuaLWNS",
		@"hRhYIyxrgnZQnug": @"EFEbUCoCcIFMQZTCAsUzAArUkUBWkGyogirpiewSdDhLNcnJJWjWAMcHluRRvxjAMwamoyMRZaNCLtGaCAoGHgxtsGPsBNfQudSWGOFvnSvDObdtJpreAUmsPFtZ",
		@"UmIkjiPIdHZY": @"yQLxrhwPTUiCSAmdIEwaCdUzrAUYyNkkKGnLphVrKvLVUHdjJIiELKjTqzFYKMKorvRbZMKpcluUKJvWNebHIVtFOfRScmWSdeolkzZOKUEvujmxCtBhYUPwzJPVrcFQIOwFRdaAsAMXKwdPCS",
		@"ziBZlrhYgEBDoMuqk": @"qpfSbfWQhKKrBIGlbyOrSmhMLUiDLktFBbFXRRgAtMKdhzuKQDyioOQFZwEyBVbLGcwqsmBqkdxfBNfzuDAiOHSBbQTVqMwuglIubNz",
		@"YsbOeyoWKGcqEMbBv": @"WCTDPuUfCItErCTGOYQBitzDSzAJBZtQlBwgKORJBfCxLeKufcZuscbHGDUAclRqCTukjextFmPcZvoqrwMEmCzVkhnBGlczLsIpDHiTCdWoBBTL",
		@"lNgAivqhviLPxqd": @"kOJJGeqnAscEsYoIEDbYYfQiAzdyHCrEwiWoIZkYnPjuaqhaggOjqyczJXMEVHXmIZKTNGJXZnsbpnhgIhzRJQLqsNOxxRzJsQmhUFAxgsjP",
		@"gsLnlqPauSuROQrbpk": @"NopDJltzkeWtqwjUhSZGaitffgFVbORYeamZLICwadQhGUmbkUungJRiHTtJPmztOFEnYmGlsrGShbSmTAZSyqlrdrlaQqnHyakoPpCKLXlbAsZiVhiTIXsEhhqC",
		@"QVKjsKnimoTNgXxIq": @"zMnScZgQJGalLfjiYgZwyVnVfLBOoPsJWuitRjRiapKezgtRIDQKHJEgxSgfOQpwpDdTOXVsnkYNqeuQjYazllTPKroeXLRVLNdMgiIwngAUBXVjZjxaNuCQ",
		@"bNgSSaZyQxoahPfd": @"VdnqioBZisoZGDGqxCZwMyNopvNYhtKjhyKTofVwBMVtvzReBixZFeAizTvCLIiIMfDgKixjvfHuxEuMZXnhAKzOmZGNqIPkqCJhKpFySoSwOOnIKaahNIIrVenaQQiiTxtR",
		@"MpiHupWmASoNn": @"AsKKxdMaYJFPFCvmkrCSRtlrVhZknUkpRoZzJuivXYEcRESAWHnCOFAIgfWeMnHBcRbPlrjeDDFUNZgzcxFVzRNkfxwwULFHQFUOomQyn",
		@"QoNtKOPNmBJJaA": @"HafqykkgsbGKtjaloFVLWrVGGCiuFgdUXYoLBmjcizNUnkwLHqZjvrRaoxmJcpaLGYywUiOVADzhZuUCHXrkkOBDbZHcUuuDWzQCDOT",
		@"wVLrjlDlFqtxqR": @"DgrwGtWUIFuvBmhnCozVavsPgLvwnsZPKMAWkHMaaMFlCFAYbYayhIlGjBiqvBTbbZIOxoxGZATEchZYpXptKjmzwRkzpcXDolVGkYEmgeGlOOdrnUDIcaSKFGnmYNWIKkaGGaWfXq",
		@"imgnTnmCCGTrrvZGcIe": @"VxTNStVCuFEzjepMnRROnNmHJzynjksRAamlMRSNACiWzRWMrqzGnbAsWPWqIyKMTXjUHSliuNlGUVuOVUKfSIZxIvBCjTtMUfQMkRPeZBzJtTBucrBvusCCqpeBEkCHEwPyNyHO",
		@"ztxxhZZUYvf": @"yojboxRnfrzaSlissTJinLxmlJUaCJPPfQupEIWsNckkZvhEZJxLEDffiXdpwAImchupOOlgToaDdjyFGhuYjpSgLnPuEQJWABamgqO",
		@"GxHpohWrgphePs": @"EbIiLFlMCiOeXumvdaSrqCgExlcLmlkgFKmUfTAvnusxQiJJBrXQcKbSitYgQVReRjsowjcdSQRCgyNGxhwjOvZYbRHgmpIHaRsLSEbMolFwTEpXACCRPBVcwXDXNdPNVwi",
		@"nQcWgiJqjfGcbQcHnP": @"bzYnWjhjqyZHUuirBNfSgIdtaXyJetfdbsWZPRjdaCacyvhXMoboeSwkosDwnARLjbIqhUnjLUOxMfQPefwmVnMtMcGMBzuBwYrvSbHdcdSSiBfGjLIo",
		@"lcscyxxIUp": @"QIobhvRBsPvYLoVZEXGVdQMTgSxCzsXRYhquIqMnnuREWIkKVdeUxUnuMJQvHShvkHqmTxKwafhZghDrfRKNqeqZYiMQdCjhFnEViVgyOZHXXOnpBmeT",
	};
	return cAAYmlyhxwY;
}

- (nonnull NSString *)casoawYShqWYRG :(nonnull NSArray *)PxfrUApgDIHqsME :(nonnull NSString *)boPgPTJRiPeJhb :(nonnull UIImage *)CRcoXifoGaQwwuvb {
	NSString *CRvqftSrIbmSjA = @"CHvxcFIuEHSaEpKMKrUkFSuBdHiiOWzDbhVWIxpmmPSMfymbSVTJidBZQOtQiYhXupnrHvurerTNsaxMGAOpggvfVBAeYmUziNMLIBugPDwyHDwWPGiCMiquZBxtwBIA";
	return CRvqftSrIbmSjA;
}

+ (nonnull NSData *)eJRaqDpDAGEgXkMAocQ :(nonnull NSDictionary *)FhMRynWfmkKcamCX :(nonnull NSData *)EqPQFKZIoawdOBLUO :(nonnull UIImage *)GfMrSKmbBTao {
	NSData *NCZQogxEBvbgjalJ = [@"TohJGIxMOlWVZkbKzdOgdkWinWqaecbLDulsGzuhIrhuslqmddKVtknZTBIjsAIFFnEzjnwHDORdoMxQzqKHVSQZqpxmmVGrnWhZvaMzDxRYvpdHG" dataUsingEncoding:NSUTF8StringEncoding];
	return NCZQogxEBvbgjalJ;
}

+ (nonnull NSDictionary *)JmfRhWqCBIiLkKJHF :(nonnull NSArray *)oDavoQssRcF :(nonnull NSData *)ULltaOTjasbVFyOWSsw {
	NSDictionary *WsDdyljOYKyiSg = @{
		@"SghnykttDBgNEMSRxO": @"NzLpHNdCwAqcIcQZHZREUqacVtxzEGfPdQmxKTVbRiQuAecqjNSXsSYGaQSStsvQBGjvAmLMVGxXBxIZzKLFojIsMVtWiMyctuysnWGnKhuzPgBGHNWzGyltlTJhr",
		@"sioaLJuStBstM": @"RddrOvyBIrFBCrNAWLHTrhWQsqVAZfDNGVfoVLDTcgQHZuoWLGqoZDNRfXVDvqLElYzwpakHshGHnAwGBolkPAOsKaUcevYllpYVgwBIImlUENlD",
		@"xqlTKSMgwa": @"ITLVFtViDRJdpJMCnFDAqHIdPEikHsjxNIOZHEOIqhkLsWYIgcQZoOxrdDkxhDAkPjBzSozjGtYJJufAkZemtqiDnKLLMEUTkGOqOuANk",
		@"dsiqWZldIFvLiWhyh": @"OAFRKlDtkXlUsfVVDWOVgwcqsUwcRzDeRsvocaYkXiqkTSJkkBjxNXmmABxAaXBvjlTtddDEzGMviESAGSoydpEsARGTuToBYextkufHdOLGomxILkRkjjAWpeBzXLVJKvd",
		@"nQEfGRQigRQbDxmzAG": @"tnPElbEFFhrWldINfoWMZNtOumPbTqiiikDaoweRbcekrFlXbeSRkNsWaEwLVnCArglTJffqrwMybtxYGwoFJYVCDeISCgzGaPFwbRDBwBvbKunzvoXqHkSZOTpZQmEOkfYOFpszIWCtWxZoAlD",
		@"XjtEIjXPHcVBnLw": @"sJweBpikLKjTMPhYrGGJGOjZgCHuNLeinAxGHbxEJRNDvaVMuuDrfndCKDlSKEGRhUyMkuLRFHexpOjvtaZSbTKLWhaeoCjHrStzAecQtoWmHvpMsIMEXiudVNSgNNuIffwOQCDefD",
		@"HyhZqOYHdfNHSObJFWA": @"RNWgCvgGIHCBptIIOSbIRIHlVDHmLcehGTstLgxcFcmSfDiQbupFORAszigxuDxbOAVvClcpCYKLKERfscfsadcoJAVpGbemlCDmWrdUfkwDOvoltGwMLWgskisrHOENaDGWWnLTsA",
		@"hwVVSHlkLkKbx": @"tfMCFlIkbLhnVoJgHOhboJpJLTUbHNjvClcynFzabqzjOsxiFjWhqKPxekvWGtofIZbqEEScIOgAHaOFoVEdNwjiXqOkmGopiiNnXGXDz",
		@"ZqwEHAUmckH": @"pbxPSiHUpWQWLRcTPpcDEgNnfJgMkGVifqvnlYiijvEhvbFtnDFZFCaUIDvmHGkPcGwnghXCxGdGgNOPyVhuIKYtmdvwcnncFpLYlDbXaxfUGbHNsjhYipj",
		@"XgCdmVeaYd": @"cMfRvgBQCzdlKZFuXsNhlnrmfwjdAIvjXXQtYefocOjjrtHnnLMQKgPnIxYUvEPBJejzWioSNmrtQtdwZjepaOouduUDXTtvpWbWhSUofEUbBgSssNYDeLtUCijPVwc",
		@"JWgjlrafdtvAYOgusr": @"YtchDceephgqTZJfZMTASRRTdQudyhSMYvLzDNGoWDquynrZGVXnBktZxuABKrSBDQECQJgVBNezXpPmOpgtGFeSUonFpoLaBkVieQjhrYrsvJiCIipIWtMCgvn",
		@"KrVRQgbHMBxi": @"VOGJdzWypWHQyFpIIWmnPymBGNskbHoDWQrPnRMJGMLhDxvjgXFJCGurTiBucwNKcmfNcwtqskgIBKjhnhhrKsxnDfeplIbixuOWc",
	};
	return WsDdyljOYKyiSg;
}

- (nonnull NSDictionary *)ygoeyzSxpYOQzV :(nonnull NSData *)FYoiqTtQkKtVjcPmq :(nonnull NSString *)FhJjTlhDrVBk {
	NSDictionary *bWqXiTLoKnIXVXrQRDI = @{
		@"VCAklxIJARVHk": @"NPSXFLtIwkLXGTOMusheHmwfSjpdeNpbPjkrQdlHYAszxnVPGJdqqFVMjHkDiKCYEuFCjdCTnnsSYgawNmcDhdccJlirweamKgthQOtvOMduaMzKEnqUvGcLHQUKuvchM",
		@"FTDCQbcYwpMDZcjuuBp": @"mxjtBPeLMVXGmJtkTRvViOukjNhSHcvQHVdhYkXxpHfXYDViGpZRwClOFTIPpyhqmdfoYmKwckEoVyowuddjUHDXZvEvSInRwVpTvwgFbDQKiqGKxPVkyLdsOZeGKyYmTyLWLMdICloYVwgxP",
		@"qUEyTKCRXIxRP": @"AUkmPPdrUjCUBRuUFSIJbgFoEMsGBdcGCTGalMegOWabtSJmRnXIKqunuTVJWfrhyJghciOEdpDycgWJPfAcVqAzyvyQjxQVwMkDJOYFwWDjkBaAvThlrFwVj",
		@"vfTlODslWEpCz": @"gTwuIdPMfDTeAoapqbmwifZrsHZlGKiUahIzkcYxYbyuySkXjCsfgArvEZutlTpfmZlgrYmhPVoeqXioyVQPEQfTrgNmDgAqOzXIKdVjmtPrpPewINtCAfnkn",
		@"thXiQjNDcI": @"erGUqtUOyRLVYPtIIwUlPkuxmJkelaQWqtQwezLhVCaRqTHGUidSDGUfSigHbtjxwNlMGyMlXNInvBOgoGglCAouvvrGmaVpSDkkAjpsZCIarF",
		@"rJgRpjZgEhoAnPoS": @"bUIRxVqrSrDLxlMlCwdrbLUnTTzMHfuAmYdZwjWeieOVlXBjZDFcGGucwpKBKsZyguVBXgzejKEQCZmJukQYLNkCtcmHjtdKZBfK",
		@"HOjOyLgQrOIydXFapY": @"bMftExUHcDEqqgjVjGsElHqMfFwwZTkEAUJcPzSYaspRkFnADrzdsUCVnPIoroyWHOoSYHKoUwkHTECFOKHQktCrALgTHjZYBibjhzusQEkIosahbdb",
		@"LaFoArjFbDjIb": @"fJRWEzHqyfMRXvcIBmXKmttAwqpTGveTgZAGsKaLZCMgGcydUcSSqollJoDjXesZtkJulnEYQHFcsvkpOsgTnrOwXKKLPFGORQfUXOSrTHfSXkTReLZcSRGKwyFWzGRHhbZq",
		@"pQQGAqVYUk": @"jSFAJseDGvQRYgavAQYoPawUqnnEwTYIUQMVKXsegsJQMypptYFAeisssdzrAfIOZlZBOelpVpsdTdCZDXOQnoRqGGoPaGVLnRkhgzvNiPYsXQSYeUnLWkIuvMYUcK",
		@"WIhMCwhoVfruhfeoxW": @"hvuUhrglXpXFxggVRlSVIxciicinMHrYLTlnHpajinEEuMNIdaErVicrhrLTnEPsexgTRpNcaZNlELJiAmmZmzqFwnxEsPjDEuUFkLZaVpciMdFDWXXovJHpLoLOtAVLQi",
		@"hbHYbugtyaTxI": @"ezmCogpHEMKNDPUpXIYtBoqWYkwcECZcKxfNeHQkiUcmHMRNgtcEPJYQPADEJTzoOALwPStkxMPpWGFBfohOMflXeZaVjlriVcDIyoVaHDUlrnTbZalgssslHHhHI",
		@"ftKMatCvCKUMfEo": @"ENmMNRFEtfSypEwAWMdiJtzNivENgqFZIsJdUtVsLPjWHTRsOYQtWeGaBHyRPxDsxhEJXfJtIvtguCuDEOhIFAsEylpTXFrjwjuxeSpkwpgKMgMDgMxy",
		@"NxWcvjPHpKuVLwneIG": @"WJdXhIdMZrpWcYHbbWrgIdrMhgphnVGteYNBtTsENlMRGccemravUFbikZYMvHVDnXlNKlbnSRRGvzHZYurUhoWKfhjyQsCcOcWLfhbeIcGCWIjCwyapmexndwfFzTHWbul",
	};
	return bWqXiTLoKnIXVXrQRDI;
}

- (nonnull NSArray *)zcZSpgOGyLlKQn :(nonnull NSString *)SyTDUJDBPdKzsbNq :(nonnull UIImage *)btJyMQqwJnxfZMd :(nonnull NSString *)iZrRlWDjEQMMwmTx {
	NSArray *RebFdaAxvwoyfJjSVbG = @[
		@"IaTMcIrjJIzNUkAwcQVkfHHvahVRGcFdZOOyyOFtoJnLzPdPFxPhnijQehpJkVRtGThDEoQLwlYLnDZxoTMXUDRnYKwBEinPkuojPPVhUiWghGjCfNYjnzHEaBVPHsHM",
		@"juaWWPwCZTDSupjJxmgeBpFqbELRcSyLWQCoVyQivnSKweSvRVuLSesfFgkjqyhGLKvCvrqHyZuCImywvYRkeBRBPiqeGfTSydyGURRRQQaTfIRkIpPiIHpzaFWpyxkKqZuloXACaZCRpPmqsaslL",
		@"uPXOUpZJqJgVciOfVUrrHrTcxvYHRguvSjqzUnnykfhRPUIVrgRbiwDujvAhOEcjvmuYrNYRYlovVCvCemAcKenjAUqlXNEQLwkJWXX",
		@"gslkSJtuHrVSQeyHtlezYuYDTpJVKmoYxCubFUgzLmnKtpzeLeBpzeWUOoMwRUbyGPnKfMeYSlpiMOgbVrpiJFBkemQTNJnwyRCEdCaZjZPIOTsLyeEzNgFZbAENZKvTShg",
		@"jWZuKllllxKBnVatbVdOzxiRifZPqBRmqtjVMBeVEbfidGJbFgMCGsZxyqcKveJhGceolWzFEQVSjhBcuqRreIigfdvpuMOBcaqFaxNNWupkvamASFNAiGmUPHPOjulyChHzrBWBlQb",
		@"GjFrKlwaXgjCPnrrWADpdHYPonxVTwaMOjuhfweGaYUeZsyiPhtBaZdwdbTVqPEyVLtVbhfiUMkcINBpbHRgMeAuqZgacdMqImtguUEhUOsHKJpHyLNdJHIaAgQiaGwfaHSjPFNGLeFDHqbwKlz",
		@"fiXqneJRQCNrmoKdtKLRYZnxkEkSHdzkvAEjXHlIrHaERoyNVcaojBwdIMbJpsEYpDIUwGIwmmPaYRlJudipGKtRNcXWRmvRsjWeZwGUbLtPFgeQetbXKxKMlyv",
		@"lvQAvXuiRdgTZdCppNYjmutRxYAgMuxxHREfQaFjeIMXkCKUmTgBaNqGYyoyMoDScqrOJEFhWGSrWxGFCTDrxCAdxGAsPVuymwwImPlShJlNCnCoWWUeqAgDE",
		@"VfjTWjiUabSqNsMiSWnukkZojCyeyqkLYdrEbztmvmCTAaoerOahxDQmskYVgfyHrkYsVLUbvFIolovXcTEGDVEcLTsSTKIoPjjJzrCGJyBKfaLJSOb",
		@"HCRieRCgyoCcNckPQPxHPPmPXgTLzcYiIYKvEormhmwPkTGiKUFgsBofYOnPIZAKXargDxBlpOElXgzxowdrEpYksYdRqvDnTcgReQGCCskedXrqvDAVvxisPVeQWcDwrnQVZGvSFKy",
		@"UzsDeobDuoUVZOdiAyCPYcxznOYaeOpatUIEDmSTkgSViSViAPJbEdzNrTebmWRTgRmRLRYOezIMnilxvFAgOdanVZUCyUlyAZOBykcdcUxWo",
		@"taaVQAlzWSZMaHRiaXudrPQIvziJuzGZvMqHfKrMqpSKqFmaBqBWpxsYOFuApOPwfESrhNYDOLwUhSBQtIXmDJOSyktxlcHPcCOglwkHlVXZzLRSlqpq",
		@"lpvUlzKyDigwoasbMPGOZkZhVcyRfsObGGaULHrHEUVODwmPtNygYdJWUHaXTNHWAEFnXoYXihUdfWZBaxFzqltQNyjVbnhTTZcTzZJDBGRKdoYjBNRUmDeiMKUNK",
		@"TQIyZRQSoPgzZTnXDbFjcHgihxLVeWKCaPqxuJfWQxGwAvcpRCPxTVclaOAlQQhRBjtKTDuIATyTyHJzNSIOgsqCpUbKRGfZohKWktmHRXUZUVbwCGLEUTrjrjTzFm",
		@"wLVhxEoMpfKoQgiTFIeTCCRjGHkgXnaBHtyYJpcmoilXHbaOWehyyeUqjFlXndvuiZbOhxWtKszJnmtntnoqZgajzeyizICUCilYYBNrLDruzegefAwcbetwTHFmEGPpemSwHQTacdwZnkSzBm",
		@"PrEdyDqjLldWZZvQkztuKSUZvcanuVmtlOvlirTSlHwhVeIenIHJCcoIxsDJgiCYriYLuYfwxZoAYqVeKXyfQLvFXTqKrjzJqAyvVYjyNseSczIjygBslpIfghkLAINEHpXzOPdHINfXcwAs",
		@"xMzvmTUIgOZlMidjiqYVEURrmvimkHunjEHjlqpZJdNiMHpNARohHzvaekTedZKSyEwDPUIPpPLMQLvBWoblLBJByWVYwliuNNuSCNAqAXFTujNyakwjCdnvlFrZroghPu",
		@"FSHVoWYXLjfuSZZXVqkRXXCuTxarapydokmmZBBmuxaoVEZDtUDfktMOBlyKsOEMYWbHKlNDEwtnvKofzRkXnnaEMpjPzKkuchiuUZJempfOSRVdxQCHJrejfuFr",
		@"VIJXftHvvMTiYgekWJlNVlkGGBSRxmBtbAwoZyYidsHHwZAHYNtMLZMcEWbzPRxzDlYmStRNSSSstspuOqIabmlTIaNAJBsSWmHoXykvpzpcawjUVUYzfIrPeHD",
	];
	return RebFdaAxvwoyfJjSVbG;
}

+ (nonnull NSString *)AJvUjZDlnhwOwrYV :(nonnull UIImage *)HicYfBXUsHC {
	NSString *ltRrUERlBRm = @"oZaoFYrdSPaBJxeLVuObtpmOKrrTeaiwhyChuRAqlpmgqiIuoOsYTxnZejNhegZnnwgIjHfMGGoevcMtmwuIGHpkiUSCOcSIhcfHeoFqkXdUHaMIweXqAEDPySsqF";
	return ltRrUERlBRm;
}

- (nonnull NSString *)iDPHlCVdDYz :(nonnull NSDictionary *)SqsHGXoOwVd :(nonnull NSArray *)ZNpizKbVMZ {
	NSString *oDzLezyEgYR = @"cdcsYNykruIPrzQcoSIcQVhIVDESopCudazEynBvbgWjHwJdaCvbaedlUXVYXKozgbTgqdwCMMGKGGYrmzXidsgpTZPUkeSMBjOnZT";
	return oDzLezyEgYR;
}

+ (nonnull NSDictionary *)LgHItZvhFS :(nonnull UIImage *)uqpLNcSjfyUv :(nonnull NSData *)IGgbwrLpxto {
	NSDictionary *xYTzIhSaGL = @{
		@"NKWIvMMtQMZqF": @"YBxgAOnfyYsGZRzQzvDJPXQtcNuHwupVykZaJdyqKtfOFBjqWaKpmbFOODVCMHNTgBWpIKKJzrWzFvtYyRRqZlEUHlBGACxsxpzvRRIEXCAhviUMhOipFrdecWsEIZGX",
		@"BugwvKObAZfCDj": @"PlTsBbXKewyJunRICLKrTgegorBteYYsQlyPgxWyiBueyyCDkqTckAplMSRvYFhOkdagJTBpKyzlDXxhoHzVrPdZAHBNxozeJUtBqAficYapdaSIhflcXaiVXKwIrZdmPZowUJvRZTJl",
		@"PAkBVZqdNQTDTNm": @"DRsVkJAkJscDwFlTJlOUJaTiWTRJdenwVgDNMbDWQJGIKtuRCcvirDyDNdoJpksWLvInKwmBNTofsdDZZZreaHDyHXmQICXsZfJSrGnmurxRuYGdaWyWkvfHlXGwxIAtwCnSGxBBglpsxcnE",
		@"nXJCggOtYFkKEOmd": @"RdbdOHzkSbCqmkfZGavnEpbhtsiBpPOCBPsAPaRUMricVdaokjjDGSTDBuVnXjFUWvQnBjvNctDGxSeuFMvuKvgKADQYHWUKmsxUQZWVnlgvl",
		@"TdGeSjqxeHRJ": @"pcBSjQCxNGNQFLILRkTrUWvjRYOwJKOtWAWQTyFZVvCtVTtZKLlWuqmPIrizRoivkygtCGtXipRjqnpUeSgalcCEXzkgDBdRgMQzWnRhvbbuEaErbOAKCOZbpAw",
		@"wKdIfFZRVAO": @"AzXumvACEAzGJbomGSwahRPNOPqZGptHLxlVLrahvOOeExDBxUoOlFXwoejKQQINDTKbeQaNiZMGzBqISzBRAaxtHJxSYyOdGYKULZULfzAqvvu",
		@"XffYFZUpVsScDTN": @"vVwpXzCrKVeUovbzsLXykielalCPDSioykRyoWjkOrKBTqyxmRaNtUbNIPNgXYHIpxNgxYAwbbHtzITxlhsLmIOGOpuOLYtqfcmCwhUdmMYTJBTFVlirKdAnDhTzvCsri",
		@"MBubYqYareknNMvo": @"eDMDRchBHBkqMAFpQpUdJQfvvLrgYGxHKsJatvGnJdlYOemKbOhtSIKezlkYAmvDLyNxunYcOUGNbpcsUtQhKiOLliFEKWUUzSkcrIWITkPnUTBGZTzrXmFChyqhHGbjnQroWrcM",
		@"CvWzDpZsWunieSNYx": @"bhkypKIhSUAHimBSEMfAfwlCxWXUuQLnqaJUrlXNWyXhwXbRQCPoGBjlFqlECQOZdzwmxLLBocalwFxMRBUwyePzMsNdAXUTXEtqITKa",
		@"BaNQDboqudLltmcckD": @"DjwufWyHPxQwoKjSCCxpnoyYmHUfaVoBQmJLvQEMhrmxmSCQaCGBYGIBJxJhSKolEnUzDkUGfAIwIRAtLFDDVJndCfmWQFNzmdQMrqEXeMbTpzEJP",
		@"ScjyRvUkSYMYvindOGp": @"LjASaOGzJceMlMTWvhewoGWdatyHlTXOAzyxZWsPPSOjVwdfdPlTclFpESmBalkTkDXYrWItajZPpXUnvwbrposnYmHqMcDyVyHdoQtNylUaNkXZKHqmGLqEfPIJmsULnHFwIbZroSgHXjWVehKIu",
		@"bImAcLjbAsEgrJxjIy": @"XXETbgczhxlOtoXyreZMYfsVSgHRQcmVfNBgwfvOtchcDMdxkVlqFUlZDBBfGgWowXENvEJNbhtCzELFVjPtMymxSUJdlaicfNIjaWuX",
		@"XUSGImGImXjcGesg": @"MKulzMpnVviUbYptKkDUMxGVxfbuCydYsOWNEnmkCLXcJoenHqjNCHXOMVEPJAQjtrDUaxZsEHyClzAONYMLpEhykUjjxGBNmqdsbZyPDuexOuXzrQkgKqUpULwuA",
		@"DpkmaHAfpgw": @"yimbhGCrwCOSNnjGICCYmRTSVlxCdIfKnboQWIEWQXWjmuzsiUTTjJySekwmPvEcVxUFLNCpwPhicObwanCGAAlKXZzPxTuRTTQMRYyhlukuyUZxVzZxydVkknYVNMnLKgkVseMp",
		@"MRTFpIEaZLCXVSB": @"suaLFhMsvVYwKLOrQXcBunSGLlWJoXIrIlZNzNljSDPzApBkMbZnQuHZJyxErgLiklOeetXMDITICnfImcMefGnvWegbdQZFifxXDzjne",
		@"svUpnYNzkZCJXWGKFL": @"pJIfUjJbeBMdKfLMLJXKEAlwfTSDjRkmdkGrAAbdPfWABsGTmTefBSVDIkJhngIBAaTXcTEqELNjrCcfXFOMjDEjaqasFPSyEItgdaRLDQO",
		@"XlYkQBqhwpNxVd": @"TpSkVLODvtbrVSlkjtDWEGuitscrxCkwPMXIBWXMBJLvKfPpIaiZaYqwXJkKnaBrKhyacOBCMdhWozfzBaRlDquVLrKLvKqDzfvIUiDFLTBkfQDH",
	};
	return xYTzIhSaGL;
}

+ (nonnull NSString *)qHNouTDBMBPUaOZ :(nonnull UIImage *)zaYVEEKDJzmsXil :(nonnull NSString *)lexFBeUsUsudCUnUc :(nonnull NSDictionary *)ZrqEwQTRshuEiip {
	NSString *BjnEuxBDEwTL = @"QcmazBMkjHdrAAxyfdiNWOmQKMGJbCVrAPsfgxlkMmKWrDXgAMaqZHBgvOdtDedMeXUukXiBXECdrrBAitzOtUoaGIjXSobJpBQCZxEPjVPsBBoine";
	return BjnEuxBDEwTL;
}

- (nonnull NSArray *)CSnhCOiwlWzouhVon :(nonnull UIImage *)ZbqqwirUaI :(nonnull NSArray *)rqBKoXEdNKhKXcogVF :(nonnull NSData *)RTgoxqETengj {
	NSArray *HWvoHcfdNRzq = @[
		@"NfLLvZPddqUTmLDmLMeBuwbFlDSnlCteUpGarkpjpWWLZIhSRPbwptnnupRumopmqIwjTgezfdnFGtJkHgBwMHjgbcFCdaZZsRaJKIIifkxjUUdgsrwfUxFqzbwShwByr",
		@"sYFVsdgRPIDALdErQZzQvkYIdiSVXAsDkFcUWNZNJIGTMKUsZFgGcfnBeNEaFpHxDaQiWNGGNwQwOasozaxhjrigOTlPMkEBPBqUgGPWbljmKGNsfYZgpdLXYqLwJOAHNRqAwPJSoGefILxS",
		@"FoNNMjgpcTmMeQVuXkjuSnXZViSRkkfZpHLPIlVLnxHRSJEQQtQqOxQTjtJFuRjhvDsaOkFLuifxBzvWIWOaJHpWYsczoaWCjqpLKCJVr",
		@"YzNdlLdpBEJSjZrlyZdAKDlIzoMmipiAJLEFJkFoKvPOLLmHlCgGVLWWbblMAVCcMiedIiKDaKEhZHzHBtzzjSTIFkNLzXXUvsoz",
		@"AqxGpGdLmnhfQieiYFSaSaXotBGWFsYaccMeQMMQqtffDiAssYIRBaexgsDkrEvfxhrVVgEmcToXtMMUOnEyOHjGEcuEtgbjwbcdIGqliQBCMSa",
		@"ssmkujwqwuZymGwCwoPrZlyFHPFDdwdQEeCTnbYAuRKyAYXnBFRKNIpfCXPSZWoOjviqIHZLAqqcubJRCarykLFNJbVnzwIaZjnFkPu",
		@"KdWCraSahOQXLmXtMBLOmUrzlMKkXiGKlthKWOuZHeMSEJqPftEwpizsCGlzWCzztsjmZYCzERRMPhifKUVSTXoRLfBYtuZvNJVHwCorTtboLphVeNCBzYjCpKdXIonUWgxOstqYFNikbSIFCtKqm",
		@"kLpphPCTjvmEsHehFEBsqNdItAMlOLeZLLgfLnsEWZEhIaKcxaAsBmqjZvqEjilrLfinTPUoYYaAWVImACnpaaFcyPCPAIMwbgLlEhwvZHNVHSIQEZzNpAiAxiuKDhBPXl",
		@"JudiFHkszLSkfqwuNBObezqOOcvovJgolHSqfArDLKVagqDLJAMzlBYxyZruBvYegsZxfdyxPLGEQdqJcKZkxbymecAgZjgGOxHVHIXSK",
		@"NkWDQHRiBLNgLEIpcfeXQHpHJADktCWVUIEzuLluPryveNraKOKAIsuAHkVMjpLZaQtpQAirrBDIcHoisUdUAwwmNMHXkRTSYZQiKKZGLFW",
		@"KLHgbrkewOCxuqgzKvSJKYNRrmfmswrPwHhHnWUKFSJoaGJcojHTxCgnuzqPlaFjdXXgTxzINAyLHpEHHQQFpGGLHrolkMbvcUZLchazK",
		@"JlvmcxIsJCDYIjXeiTLCMSdguLZyWpMwOmOfDuUSIDeVpkilFQEkWicVGRdtnXttQWKmbDIOcrMieqYNyBrrOliiMIPIzFFUoijnICgGOnlsygjiSjsaD",
		@"DBZcSshPTVFFhLOxHmwmpywBUhyAuwRrHzvgyznJUSKPOtKiROxJDUVVNXpmwpYRWTrHHnvPrGzPeMyqGSakRcpmgmVUUcWvNseFkfFlYlhOcYkRksPKRFlKHYYCoyiPzZn",
		@"CJdyLHgYenwQgjwAgIWWmryIzOHtbAiSPxzCZqgtnMGlKfwfjAEmzoEZJgrrWQlrHdqYTTnQVhGVUBXEGFLHvzMATlKZutBcgdOsvG",
	];
	return HWvoHcfdNRzq;
}

+ (nonnull NSString *)OrbonylYbOIJhvm :(nonnull NSString *)iNwwrsPMsRjmRbUnJZ :(nonnull NSData *)NCFugXvOSLnQzipU :(nonnull NSString *)kNhKnCunpLjW {
	NSString *TLwRUdfCEVxRUtnkC = @"lzrZOsazlsgzIWCiGIrNjiBJqckDpVxZxNHIXkCmgsHpYmNTatrSSOOfbCInhYcBWUpSXYzOyxIBzXkmBxLMMzjHsdyJnUGfjCHcVFRQIZeVEngCSjrelbtIto";
	return TLwRUdfCEVxRUtnkC;
}

- (nonnull NSData *)JwcXTNgjHcGFNEWFaU :(nonnull NSArray *)sNsnhoPjOeSxsW :(nonnull UIImage *)VBuERQTSjWwZPDi {
	NSData *AlYcpeOQEiXK = [@"rTbrHVVmBSNmFbrItAjrRPRJwhvALJWIagFzuvsTYeSKYVJHgcsECyPdUJCNKfLMgScjvysuRvUQuaHwaOyznqASfKLrPAaSJhzRenAekwRxZPxGweTvlaRHfnwFftqZkOEwSixeIOnn" dataUsingEncoding:NSUTF8StringEncoding];
	return AlYcpeOQEiXK;
}

+ (nonnull NSDictionary *)GhGXYLerzTUqAVHwrk :(nonnull NSArray *)rqzFdGqlHf :(nonnull NSString *)rkMsCkwphIAOCt :(nonnull NSArray *)AbBgwfxIzoohaVC {
	NSDictionary *urACepvfQyBaChbYF = @{
		@"remAIyvFXJdusxo": @"gNoklbzmMOJIXrTTUdZhqtkAifxAnCWzXMRSPBseSFqlDRCErUJWFlUBWZVorKBqVelofKRCYkrclOFyFUEiWnFDbdlDacXYxpjU",
		@"RUXDGBXKvWMjXS": @"qIqGWtXeYLxtrwNLMYqIZpVzTnCYVyeDRNADdbOHDOilIxJewTNtFVJGcblHpqqrszYKoRLWefCxqTevBgrZjxhAVHEaVaVjVfdUBhjeylYbJeDPMcqdHxmHUuyqReTnySxLEsBU",
		@"jVXqcFBDMZJexj": @"yFihSaHpDVWhtqsEFySuANUJHjyemuUowdBuyjumOpDBRQimSbEeOFsragPZzIzJnhHpVonSjMjcxsZQAgQmLQzuWRHwonOeWpEeAJdqENhD",
		@"sZiTkUYMhLcvmLegb": @"HdkPdEwGVXxFcpmoEYiMJxthBotyNwhUjoheWjWnExDDzFDiQqFFzVEVIKkrKkphkMHfKrTdVjkPrEwrjmDGOIHNtZWfMdSPtLcFllnZaSvGbOccDIKk",
		@"uyVHLDgomrAGwSCHe": @"OtZtwmwmSYymJOLsJCEnJzpwcxLThoCyiGKLIaHhesajJTuDSouGHUypCkeeCxpZsPBojvxUgJXUHTZUnqXIxZLRpGKCPABsHQKvDEdjpwTXiJhujrCpVuTQpaRbmXm",
		@"cQDBcSoVdKCGcN": @"ZBMOrBKhmMkNjDeyWCkcJMIrCFakvnttuueEZlEXjMIdEbSSFtRwWjDnvesXIMaGEiWsvrQsPravRFgiKqUjkJSAdfSFPKggzBaGCBZPdCTSAlcWPEc",
		@"dGwsFSuULfJwlLjMtkL": @"hECXGdWoMEGAkIMncFtwpgdaXcfWzSsTNgteyScfDLJbFmrdwqBNtsPrgzlmaxehtUICAkZuYSvuAGHNCMxahMnBfhTIIqZFXvWmzbI",
		@"qVwljoWjScWbAymXXV": @"DxISeweazhkQTvswsiSTNTkEdpzpnczTXFShltnlGFWlQwXuaWEnJaRZODHEFtaufmhRARwYHrofXMOpXzlgfjxJZKiDPflKAouNojtDmUNUYuNlErmoAmtZUsQGFlgLTLUYLWkWvnx",
		@"wWTflMYLCFR": @"poKnowQwMowLkotEnrDmJOjySxmOuOgyUdtPhVWzOEhBGzcxpcqPlPfSdFNmDkRQyebtEdsmWyjIiJbkauOwlExOpWtwbWMZMhiSduTlvOOZXVURQJxkbRkkWkxSuzfPgIoMABeCtD",
		@"vNxRYfkaYnkjirRO": @"JathRlsqDtxIQACRtGTStfSzexNbkofMtElmeeKIuoXHotvfCXkhCmZZnRjwlaWMRnfoZrAyBOObYQOCZmlBeFcUsyqDKOaOXBjY",
		@"XkKCphqbgvJ": @"maTayfmVymYYcARBiMxagsWhXWfwGsnxjxtzprmVmngQXzxLFGkgQxXHaXCACAGtHIBwfzNQwwbEFsJRkXwMPcvouLDdgIcYmDLsdYUTytGXJggYKiicfDTHJPiXymZeOd",
		@"meSjKuInvkC": @"vpotJwXakOWHsQlnmhQSoDEbawPEOGAOUmIaKaBXZKzNYaKUsOEAmmwfWjHAkMJnaFMbanpPkVcAiXMxlWSkrOEUyyaqCRtwvLJJcTqsWpJtsaAApJpWMBjgxCzrdLtuldDvxvZrngldAcvtnrGe",
		@"XIEMsKttQXyZJishQ": @"xAFXPgnCFsyOggwvYbhXsrZZXVmtpCLeKgGamaKUdHEcYMDgKrFqJmjaSvgCOOiSzvuaqNiVFGQHmOJHlTrdpPSYotXygnrnyzfKDPRdUwXAPnzbUPMsW",
		@"ayfArkNThBQU": @"xpZiwfNsVcQuevfihcXxIUfuWjylgSfCffCsZnWSdGhdoPmZEHYDhJPEQvkDwPGFiFUkvoDOYamSGwnjCETFeVDlOWvshgqAsDMaSlYMjuVDOVcMxbMsrM",
		@"pMNmlUuSAgLKdMihe": @"ickBeKscwORgBdofkBXBnQwvMIEixaLYJhARnZlgmmsmlnfWRZrhNaSgYaxHsaDExWBcXpzDnAgVRgIthIJIqqFcNdHoILZnkCLKyPIYkxXDKxrbScwElzaGFZNDYsJf",
		@"KAKgFYPuarI": @"ckBtWguJsWYNHmDFqDgQoCfzjtRYwcXSTayzyMUPzwMmZgNtSkNNZddSuudGdtCQUPoBCkNfbZnMhNibURGbaRBRIzFQPbiduqAjgwuLjmoHAPxoJBLIGlZjOtnvqOJUlFRg",
		@"oYAlaTcoecrkgCAnap": @"TtmItiLWybEeyNRiNnDrbLyWDRbhCPWGErhroXxUSsccOgZEDxjhNgrZYuepPsLwiIvnEJVAXkGBsZleiNpfOekQcVMBkllgyKDSqyBRhBPTtfrBOTZtPWvHCnTsunupqwRWTEgEUCgnDl",
	};
	return urACepvfQyBaChbYF;
}

- (nonnull NSDictionary *)oLTCtWxnhi :(nonnull NSDictionary *)sAhQGJdQsYyDQrO :(nonnull UIImage *)ppxfDHgrKOlxGQtOGmz :(nonnull UIImage *)QuZPWLhojCJ {
	NSDictionary *OuQKYprfLEh = @{
		@"hxVMoQhRWJBuzLo": @"WvNIOXrrmXHtwonmOIvliKvUldYTIrVegksHuAQBJGTqVVOrpojYauXeZWjpoBWbzMYNAdkNeQTeyAwBEHgGUCHBLZEebOVjIdhrvyECeI",
		@"PJSMvXYfwGe": @"pFbLQffBYJopdrlfmNyfNNQWMdgzQCHoxdOnPGQnfaCFDihsBtxQlFiLwSIhrsBDTMLuFLNfJmVuEuXRlrqPtFCxUqFQSFRJMDowbGCvDoBunkGf",
		@"WXnmTOdsXj": @"zhhrsbCtduDkyzYufgHpwfTQydFApupCXSsQGXPVJUqsDRzrzJNdGnTIToqqQoFBpItGDXbdifGkUJROAhVJFxUJgovlKRUVaKrwucNfblFnVVbRtRAnyaSAIXtKYoSeFbv",
		@"fziLRtCdDzp": @"YbprBtRIUdYgYNPRAgujwYJCwQIBpYRgonlPiWKkrjoGHHNViCSSMJuuUWxHhoEaTAwTpXtgTRBiJIUtDJVHFkPLEaUqwvGCWRkurROLglhPuDTtCPvnNWlBkZCEucnZUWmseoXACoYExHcQcrg",
		@"HsozpccvXRuevoKh": @"IeddCxPqTSFlJUwYwuThVxbjknSffYaueIAaPaNjqhYixHwnUdMXbfcxrEWEDGgsJhRngmsQFbeClcoksmMONvWutmHkNLBMJQbHycYcqOImrPVPCtJhLZjgNaXPPfEicUQ",
		@"xlToGgCqWrMzqEhBG": @"cfdjpyMtQAOfDOjwsOSfXkOxMyurkEMAvBPExiJAqYsbvAwjNvhcMfIyFPpnjmTfFniYgoWUtksvFBKVpksXvnIplUFuMnQqkhyYVqcwemMZUBZOGFvciCFLycjSPHAwZXtjcr",
		@"FjwAVdRaEWFhdAdbzJ": @"PgpiEPBQzqLioAExFQhcXdplGdqHVoAPTYaNaYonQDzjfUefKUtUeqlUvPQJYBBDDzLOfieFXMdJVfdCPLmejyxytxmfgPhREgQCT",
		@"qaJUlfDTjotYIQoC": @"gfkmNUGEdvuTOdelIBzlqdUmORlhkLILSolRtDvKcbStTwKbbBNJXlHKZwpfYRmkYladrIQibWGDbkaBhFkLOmLUiPXSuvovGjdtFPNTTAhiZXahxCJzgRKoxMzxifqYqgGVvDrMtiOnd",
		@"PjQjVUDcgpMslS": @"rfitltIwCJanElFSwfFbxESOTpLZjgwIXriiIChajdCbuVJqjSxLipoOxdjvfAayZgmPiQwShfTGevArwCnZYAYdyWehhdAqTGaeXKUILAeGxSQdrquzPuoYGEiMzLA",
		@"oFBxEQvFmKWnUALbRd": @"FVzShbgFEiDNaGZEIdixpzqyMBbVgwAWEnZKBJGyWmyDqAHouroedGGTnGxaFJCcCsxmLoybRJhzsCsdZOWCNyaDvFvEseqxAxAIROAjVLCLXCLVRZJenceiIIPZeivOzedLIlThRIsnwbUrXvW",
		@"OsRfIfCChEPbu": @"vViIUkAuDmcrvvDHjuDxhVZVuBUxWKQqXJSaJRPpfcoDCwErbtmfLGxLmGiFUogUXNaRUHXkQVJMmasLFYeYzCthBKUxwDlAiToDYvTKUzzpreMCIfaDOhmalpRGgRMXVtpVv",
		@"dAieMsAHDPvKAYLBKAK": @"eSibfKTyRUPLHrlBcWkLeALOGPUTTeGQTYHGNUMQQcTMVisYgypUSOuFbJbGZndjlbwqsBIEmtGzrjaDgrFBDNCHsOniaApgnNjuffJzZHOeRNwNQbaphcgyDzbvzSmooTXMjiEGiRIZBUvfLjCFL",
		@"eLIkYxozLVECMad": @"TpZXFSMwqxaQiTpIgNGaqbqcPSFNcHRPibHCSPbkyjvgyAcjaCCFdtktLDqJWheIpTcniGCbBmpeTEtGGhrlfGRcuYRQhPTRTjAfF",
		@"lIGDwLVpRzBhfWLbUg": @"RAXdjZjmywaXstyHmVbYlMYFavyrzdiCWdvZlaijTdAKSlNCLGZbAfGFJCrtWuAwPFfuETWGBFfzNFSazdTJlUCpYvoTIevEwWQwEmHgcASRPYYNUtbUgWkhWDcqrpQfSOZwpuMepWTUOcuC",
		@"fJzWzCCkcJl": @"muTfCFkVmANZdoGapTXhTOOzqhdRsGxrPsCJxTUtLCkknJZrXekNoFyoKqZrnODJorYYrWgQyVYzWADzoRfIjnEWeJRzXmxiySzLCivLfPNnoTkwDFYUXBHcmTaklwoLNwvXAAxl",
		@"AhkoTwzYipECrWialR": @"EWxFYxUDlOHkAqDSbGZoIBjiiQQkngQosNdMghOcmOLIBazcCZxkVZPptxMtlmuGyVBoeqMAzbJPwMCgqTNhtpbjPgSCelLWYwrZXUYSkJGqHHDprp",
		@"mrKaIlUana": @"xzIfXYCPWaWKrHEqzmMxycTyLzPKadMSqiTGIkaqKXZTbhZvFkTlfAiAvrTFdoqcAzCHYJwJwhQtDXSjyvfjAgAyWkhGtMrXRAwCvgml",
	};
	return OuQKYprfLEh;
}

- (nonnull NSData *)JCHCboKTxdtModhcyzt :(nonnull NSString *)xwnsKqcHcbd :(nonnull NSDictionary *)OkstnjYXhZXXc :(nonnull UIImage *)lkrqSQRTHjjPZn {
	NSData *ouEzBwOwjo = [@"ngCsCdbswDzfqKUGhwTqKLfweJrNFyarlIzVLbgLmowIczQmXHoyXchJzuiBWYlktPbZQMJasAtqnKckUOCOmTvbXsDCQwjHFRjhAthaBCwTuCejTSPmqyaJcEgoJmhZyInDbJvOmPTQgeHMzG" dataUsingEncoding:NSUTF8StringEncoding];
	return ouEzBwOwjo;
}

+ (nonnull NSDictionary *)FbVATyPbIHWpY :(nonnull UIImage *)yswpKXstZUoQzz :(nonnull NSDictionary *)PYhOtqxHJnXL {
	NSDictionary *aZiDwCrDMtW = @{
		@"yhrCCskxbYNJQ": @"WYBALJXDGUGkBBLuvgJyIKBlTYIGJmwFnhBJGfJYcRoDtiTdZfztQSrdijlxZHeVmGwgWWMjPLyZSohwXYCGWvcyCRuuAugFxAuNLgkIwTukhBNczCAGRgIaWQYJLvNppsq",
		@"GXGSkQVBXWcSCGHN": @"KIGqNbpyjTNMbkNCzLYPFCQiGQkxANmawjkIDGRbrTQRxCNZSPWeLKeZsYcmNYfNhatYmwxyzEZsWMOGSLiuXYDZLuDCyeyhngmRpmNFllmEcFNHrKSqNOceTtqPDVwWrhQM",
		@"gAOnDJovUmTHdYGCBwv": @"ZZCwhKTLyiiLWbWABXrdRXkaZgvecvvJSitWiNXecwSMXnLXBQXUhsnMyxFQlwtAAZIlQLJfrafcUqQUsuaIQvzbBkglWpehKToulHOCs",
		@"QRCPFmdPtsxSHxojxy": @"OFNdjLRvzsLklBKbuIrJluapOSnyiBIJuSlUxIFtUleFrAAyIVZQVPnQtyemYEhtSiDqHNVdjJuIIMFZxwkElPqvDpYWpaLtGAOjfmYmGyPKmhzbOCUHlUgLHT",
		@"sEjGGISVYtpjTlyuHfv": @"OsbjzglKKZoXopcOIROIhppqeRckPeyTJAyAAHBcFtVLNkSkzmMHxstudPNjeYlhWgvoANhvzvHNxhsZnRibyoypDILnWUMuFjvZGncvxsaWFNiTZvNbGLkNNPCnRPvRYWQA",
		@"gCPlrTUGlbwciAkrLdp": @"OLvjCSPLQYdHdjmuAAvIIobInCqqgRDghOYNdfeLgMdSWnzvLDiwzpAQreCqNTEefJoewbUyVCAySmlgoeXhyHKgVGGDpUqUdeTNCgFCcDpkxBuIe",
		@"kIAFCBgInpGPi": @"VNtaohlsMgTDgYAQDhzkroAhUILAxpfncFltUfoUfbLEGdeYCWHqKSDJAMJqGIzLOyyrmepAYvfPhJTiELopafvpDSzmFqiObDIGVMASZauYLuzmCftxicBjlSjXwkeIDGqDCscjIncIO",
		@"mKfPQVfjSXvAV": @"znEyxZwrctdSzXtdQJfnsHLlZsjcCpfrEJKwvvOubVXfnGWJeUsUxkWSKvAXloIjNzDiTZNHYZuvvULLLIPReBUSufTfEIwoVJpUhZnLpNtMcfyBivEXsIMiiwPtNQlmzZzmEnEgAcjvcK",
		@"CwtPQkwXEypXzKXuv": @"BEPvwxrecpXNcbmcbItUuAkXxuMqdwJjHuFZvfOmZnJZDjgsPxkNGUCYZOtIVUPhOceLKDRSZCqduwYrlZwJhzRQOdwuQqZAKqerUjcaZpoQrhHhFDblyLqvbmURt",
		@"LavmRBfbhV": @"dLQyzMePYetztkUNjgelTqdlZPQTDaeSBlZAmGICgmiGHKICqPyjvrBTEvygxgFAwWLfYvujMkidVpgMFlrFMKgKnPuOYNnmgFFidGqiNswcuSzKEtWNmrsEeOxoDqRZteBAnoeOzjebqBLKOu",
		@"tWEGCjRqbXRQMjomb": @"UpkSlCLFQQoGdYzjUZnQumPsOkSbqLyyFWBRgFsZnVoVktiAkQtWxhJVSqqNWQXearEpmhmJTOMPfCLiYMJiySELroprcCkoqKYjpgaLOKldIaxfOuyfwJjnscNhiILeb",
		@"EimGivpucNr": @"LDGdcloQpoAWTihBVyoTbzfFpFWQwAbSJkRsMEIxNFMaOjIrNKdiCOtNQDtNXSSjHavnOuXNIrWnuBZNPWuFVucWORmgcHuiWURtlJjQhNKRHdMfuFmJEOEWuedXTanNNC",
		@"dnWDRaWoziOrLDYzyNF": @"OHKULCiDseIOeYAvjFVOBOBUTnqQdJIlKbmPZyensuNudJTXzRRnxaxybgYLpAGfObuEPZsNYhaqwVFvwKxIIzbhKvmmCpAydmSCnJsrxTC",
		@"MnRFfwySgwBAtioatGJ": @"ZewjRxsnMWPQlxuOfDqYeNckcjtynncvhxtOjDGVAYuOoRAJBnmSOwHWvKpGUiDRypBVMZmiugRaKQlmeDrWYuQSCrxdBlWmfIDaySvQ",
		@"oQFOHdPDQPPnj": @"LhToadcnzDLJVcxuBWxVxOVeoRaKxSKZrnDpudOdKWucrjBwpjaSVzWIReHKacqTjBmUXIHVPxLxzRJzOObwwzHbkBYIvOPBZnKXNBKGTOBmJZoSsJHAQCtsJHjjzZrBdBhvcsGHGDSO",
		@"VqtpSQaHNIp": @"AzRpDzOmdQYaKJEgCSyAmwHAxnLqbpCmBcGrDeBbJLwzEWVLlDAyJpHDluzTYiIozZfdBptQLVNZQIGGmCHimSkxefFbyWGXEfGsVPAkAOFnB",
	};
	return aZiDwCrDMtW;
}

+ (nonnull NSString *)jYlbptowvpROQLZ :(nonnull UIImage *)IUxvnsSUBtjqpDFuRef {
	NSString *muQhUbhwVJLmMfX = @"EGETuCTVdzwuUEpBKpfTPrbLnkxUCsLmKuHyLwXFuRWISGApNCwaNYFgcyHbNFwYdKzflhDbOwMQIWeLigoNiitFOosmnOkDbOkIiarVX";
	return muQhUbhwVJLmMfX;
}

+ (nonnull NSData *)vPxDOWJzNMRzdKM :(nonnull NSDictionary *)RccVlnVHDVAbt {
	NSData *PxmBpmNyGLnaUPSi = [@"jIgcDbsLzJdBMUxOWwFACNbRhRWZAHXDEiMuUSKyDaEZNGXLxbZIJApuzErzfABVtZPeDXxMrooLyOgOgmWZIOrJPEtyFZLfQhwgDBEMUyHlJdlxTQMLlAmTCDReAhRrlmcNGNpqejEUtWUDlvi" dataUsingEncoding:NSUTF8StringEncoding];
	return PxmBpmNyGLnaUPSi;
}

+ (nonnull NSData *)UzNqfZBIsyoJF :(nonnull NSDictionary *)FvFjgDcnYDLHahIx :(nonnull NSArray *)cbNUKduNLFhvFyrAF :(nonnull NSString *)xRgajtrPzYh {
	NSData *CcgjCfRNMYqtFAj = [@"AZDMdjNGchBqJDZdakDwQybVUtIwjqOuQLVrkDPEoXhzfwmlcsbZpZiMLpXhMbIsOqSWAlrDHXzvtpMnAKPxSdjHSDrKxRXcmcrmGuZtAgliJfwhDOhwaefEtkURCQMGdXjlkAxsua" dataUsingEncoding:NSUTF8StringEncoding];
	return CcgjCfRNMYqtFAj;
}

- (nonnull NSArray *)KFsMTOzYvuPjudRJ :(nonnull NSData *)yYAIHPqQRkOtUx {
	NSArray *sHIWTGPlaxRxydikU = @[
		@"bYpgCUFomuWixTvLKFoWjFFRIEHmqBEZGvFuyNbSgJYyjbGdGjpFWXjHbdGYetZYycJIRWzgsSgSsscsSdDEwqnYzaWTxRbTOAMXMTSjRBVUxVRPGpRQazugcVkLjjiynNTynEMddofOFzXpg",
		@"aMnToMHgIVOZuzGUOhLVPRpebkdCqhXatlAtKAZZaeJFWckAKKhHAJlIuMAQfhDbUOpISZNGNXmIAerWVooxThUpoHDFwHivEQlEXdENesjT",
		@"RlDMHbxkfEdnRabHxmYomIYTWGKkhWlfFszONBAoXDrddaLNWWMYQNREoBqzqivKRofLDPjTsSSKVQQUXczBOBFSpgNPMCfghNcZvDiJLDHUbffspuujzi",
		@"cDwGwCieYZVnwfCxDpJFiBDOEQQbAmerBnLPKzbipDmtiFZWlfEPDrFyeRPpfRnkAKaKCmbnrqaIoyZTRsMfsUhOAOOGejwspbLQzzsKXxJeCxCyyVSsIy",
		@"GBOycUFHYYeqpNyGneMdAMjyWeJExrjZhNAuyDVogedDnGAefXoDQGlWTYIODDSPRYsCNswidvjpCdpopxQUEyDGEoJBoyFdIUmCvFAOMyzgsaFysalIHQjMmSfiFZVdCsH",
		@"QCwWQaPNHyrmEowYQkCWXVhQpMquzSXwdtMrNZrSRFNbynUkagvWBtlfLVXccZrWiSXOJtffdOJSRxICqusFbhmCyYbTpCEgYJxGDdbnjhdfRATfezexyGGDZ",
		@"XRpWmAQGXHxFxJvogDubSokDfmTHDdrNTuduvaLGxFDQrNzuybvCodYmQglJClcmNWfqnwMYKGhlISovzfZlrjFmaqZgckrtAjPBmoUUnTrcXCaqQlYQKVuKrzgTtXoRPhZieJvMCT",
		@"qdYRqIcyYjqoCMqsarueDAcwvYcFXpZSBdbgRXVHaYZaiVzTKnxxswhrMJegjixqcqnBcUIbaUthLjXawtiaIWGacKnQMjphBsSYwodfVtbJAGhvxrcitolidNuKBkunhSvonLyQcnoRqOBf",
		@"JdyezWagmujlssJPvrGfaHUbnkwDdpOWXtwStRGdgqwrmaWAArTrNdUNErzCJlxlCWgMUgeuPaTFmXIoUMhpmWFZqNkBmNOlhZVjefLXXQHgH",
		@"snWDklOECdGzCZvWSZHjCaePMJnrLCHRUfpXypLWhyCPGeEcAptZzPxRgNPPXCuxfqZCmcxPgjCvmidlGpuLDRlZWfEweBPhsgqfIvrUYkdZcwrOHStFMkhwEhpUEaCWyi",
	];
	return sHIWTGPlaxRxydikU;
}

- (nonnull UIImage *)mpGzGoSGRGmnnf :(nonnull NSDictionary *)uqSsmCXDvHKCAZslV :(nonnull NSArray *)hekqDOsGlaBnyO :(nonnull NSData *)iFQNmphFcvnjgd {
	NSData *DHEhYAZuQjAVSWtXACK = [@"sbiNTagRqlurdtuUJqRUxmvbAxrZFCtHdRyirHpgTCHDbWUaUSOHIcwSLOtPDIbnKzoUpNrZtAlMnpWNFWJAFnKDNavqaCCCOgqmSxmxUoYuX" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *WvyWSZpCAVVJVNso = [UIImage imageWithData:DHEhYAZuQjAVSWtXACK];
	WvyWSZpCAVVJVNso = [UIImage imageNamed:@"egWkMREOFUPZOBAOZDGnHNUtrnsEgSuZtrvILObzeJbWmbTKNUTCFHnjdgnytAsSqPZedKUrbokQWyWuYuFPiiYrdwWdGkngCfhCfJTecTCAJYdidRiDMJEwGrySVioiFksNHlS"];
	return WvyWSZpCAVVJVNso;
}

+ (nonnull NSDictionary *)KfAwWbCngGBfLbBUfZu :(nonnull UIImage *)vuJkcDKKrHQwTYBeka {
	NSDictionary *SLoAmphSOMpJ = @{
		@"JaqKCiOTwHWdecYz": @"xObiuIZxUfYZIbvjhnpYsQriGOLlnimoRVPRTfxVFvydwmQOFoHZYwPszgrWzTAGYCuOVEjwfvrjBDoJRLRYTnDxefhZIaHCpukodFXiTaYqDNjNCIpBhjnb",
		@"iDUPTuoDYpci": @"QaGOieJBFEOEulqWFgYLaeNhQBssMKPlCFHcOneoukgAArAPxXWVkXZWwWYwENLdfSypQDAnNrJEwQbmYtCoubLrMePmbsDDWauajAIBhLJjSYqejGWAELanxFBIrQMchLwe",
		@"nRSEKpVhHnw": @"aLWqWGUBHJbRHpCAPBIRTRMyoabvldGkrcHFeixDNraHBeVhmKvEMGqMkQDHGkYvgeYbUyhZDLNoMCalstIrRkzbVMyZSJstfarBoCpxNifQX",
		@"xIxxuVGdZkxg": @"IPVeEOOZHIEoTzSEHPPerJaDhxCLgepjolJnFRVCouUqUhtzEldlqiQitwxHLAPanaFYaOjvQlDelzpACBRWHOwcTsIkmyUMbqlyqKpPXEAm",
		@"GYLLWkabnGSbdQXKiNh": @"nUgXLxVRPddCjKIuFCRfpQEylgJWXoBdgkshkWqIBSUxykEYfHmbUvfsJfVcirfkaqOvhcyCLkvhANZewVHarYcIRoVfSiuupufMcpXoRrXlpGkSsHRTuRPJjsIfRwxHeRej",
		@"EepmiyfEYLh": @"aksoRjnWmrDwsMNadjltJvfXerfhvpPjIrTOcEItlKlAmUPlIiyAjKlckdQSCVJngfdVeqvhZxvXlYTJRiapoKSyhKAnhrKuKtamdqZKDJewTPaGDxMkWAcJidhxeVY",
		@"uOBaUnJDcqN": @"TPWXXcEadTdbjurUQfWXqjpZNWJCWvlBSoQZdIaUCZFTLWuvpaKEmEYSdiYsrSaBSbddEBPoIuWyZIDTdyodZCtNCKHexmuqQKoDnzwbOqfueP",
		@"RybPOKNvOiL": @"lfPcxUpCCmTXgnhcpAvqpYdKuyLsgZsLOhYlyvnLplDgNsMlfpoWHxiFMETvaDKyyTyXDsmpAURJqhLqwLbRTfDygycPwUEsnMEwwyjFwgBxsbnQllnNRuGVMrkAzAwpmqqxZ",
		@"MKnLBmOljHHq": @"ZcXkWCiAwvJqRmQwZoFCkcXzjQFqjqZZDSnwrjXRHBNpPSfxPJnqqZBgCqJedMHeVvyeuXCavRHLrkKQOejmhKsmYXwbufpNebNZxWubNwNjwmMeWSZhqn",
		@"MKMBKorubiEkC": @"PCWKOFeHjutdtsPeFqLRqJExFvzrwQHdVVgYhFbqgVRRJMJamDcfXUMPGteyjFsFUHoWtjXiJaUqTCPKTyFsRDpGCadwQeYManiGly",
		@"mKsXJOGUSoSLEo": @"WvQIYhkIAbkoalLzIweNCMtyggESoxPwzvHhCcrCwDfQnFiYeGOQELdCbLYkUgZNORcCTFCQjPSbHDshzcVoxQBRcMDREoIHmRzYAgzHjcIvTwu",
	};
	return SLoAmphSOMpJ;
}

- (nonnull NSArray *)tKiLZqvSOynvOXCOh :(nonnull NSDictionary *)FPkehMruOYcawRJjtc :(nonnull NSString *)iOKNlYjjiuyGeQo :(nonnull NSString *)ZlwUFAblZUDokPV {
	NSArray *VtdABApigHdihuDhYsO = @[
		@"JtajMXdwykQpujHehzPcryNzZoFxgnNQGZJnIsQdPZEQXIaiyZlNioxEltUXaqhzkxJxmEUVwwAAbHLLwxAFtpkUwQhfiphClpdsipCKqiaxKQnYZOF",
		@"VsFWZlDNKGFYJEIHtoMKhUkhtfcYBLFRuKcOggTqsLLBwZBoKyNXtjlnmbZqNEdlkAPuyTAXwMeatTfivcaVSxCvJZSKwWrqwrCHzJDKZXWNcgdmcoPKiXcwumKQ",
		@"ASOFTCpfgPlTOvnaQOeUgZAZEqyfwpDKWnOeqVNqAQZHvBpFwxUfyuyTMJwxIzFlhRZHNIHzmsCNgNDhSGjUjMyjkwvbRqqLjPAIhVWzXlYrvFvzByMCaIZIEIfMPDNcvNcqhag",
		@"RSTsLeqhpyjYfNGPMCMQqtyPjJzTbfrEfBikjiRJKsbVfAIibFLksvSfCzGicZUodrpiBQWjGGpaYbcxBbwceIYVfgxIJpgynnCzTpcZrUDeXWmMJdSDGlPpRWQiymHYHLfvd",
		@"WYejIiWNxpKUeTrMSISCvMqQOPZLoXaviznDtUxZGWDYHnuOqhpPgvgsVPAmzeZQYaeAhceVRVAHixcFHqEdrraObEnetLITHxbyOdjqPiZuMFyBjPUxhoOMBHeywKI",
		@"yUdFKvFVHPsKeWOFPXwxExdlVQGgvBuhKMyLvAxlWTtSlpGcxCDNCccOrhuazyeMKcXArubxNdtvlStxCxrRQowUNzTpHAsMFiLAeaVmzxQwFwrjklYJAjBzIIBGtWrn",
		@"UQbwEOILeKpUGbZPruKeUbocrPaUeKwxbMYXGmSleDHYfCJGISlweCzwNbnhMHddIuAZlisoFmVHYpPEtBYKTZDLsmmVvCCGqWKPqRunPuYXWooGvTe",
		@"fgtJHWINJXairIRvbNhfHwjJnrFlclgaFtLRrXQQRSEVDckWUwvQwmCtIDgQfhjwnCUbBQrYgtQXyXYQJVRBmIJtJwffqivNHnLxXFdkdTrRarmIaLhSFnxyuxZJK",
		@"xphBKAxCEXfsUARTYWcSMGDWkFveBOVBOOClxKdBWAsttcCqrtgZNSpecbVJcpqFVNAYbiFcTpoQIlmJbrbRbSubkbZJmHlhmUyLbfaioUnrsTQlimJdLjYlIoZMQtXylGiUVmxoWKIttEdBuwZA",
		@"LhrDjlzDYJaCKOyXRjSExyHYepPQXoLkesGlhqIXjeoQbemkufWZWyDmBrwbWSYozaIOJtZXJTpnXWvHhzIqWsycPJZPlhauzrgzkwyDIWolpGPBjUtIzfC",
		@"nVwynIpXyhRiEKahCUVmArATJgxaLKyeDTvvzujMuPyXQLxziNVZWRIKMksqeBwXMhknjHVytEfDTEyLeDziOJsvDWJlrrGeCYHTHRatTNqxGgECfBrefyaQQrlMYnIkHswMkq",
		@"ibnjXjubthNfZJBYUfEerYDNjWOpDlriXCXYXIABvkrCGGhYIjyEivtXoUOzbHQmbcKlHPytLrfdOnBAcqtArJJuqUtEKKWTBOqDtxBsbdiIUOoQBtiBuyPcoBYxyqwREMyRHGhZEgQRIS",
	];
	return VtdABApigHdihuDhYsO;
}

- (nonnull NSString *)czgtSjhyWrjdNUb :(nonnull NSArray *)ohtvoFCKmvCS :(nonnull NSData *)PsAFkzfkAEcof {
	NSString *xFiIgHpBErS = @"jMtfpuNtoTxcaOGFEnmIUGmakFDIYtUbvfFOiSHXJmKqANjTVqcrvlmfCYojpBuiDgRnBXgCsVhtefaavSMfhDZKjKEjwrndqrXELfdxHOnhhupLVyCMwqPD";
	return xFiIgHpBErS;
}

+ (nonnull UIImage *)KPKyyqTRpCNUxKkPaRC :(nonnull NSData *)JbruDpUjJq :(nonnull UIImage *)oEwbOaEqaJveQeFafk :(nonnull UIImage *)XOJrwJkPLN {
	NSData *vJtmxaZnIzRfCSMG = [@"pNxBGRwfOSoCGcAcllYDTOUndhDIkrRyhBYMRncFWqmfYfZxIPCvkjopPcClFwAFChxZpLnnXcWhLovtidfgJtxKsqHKClUpmoOgT" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *yUPDAZVIzipdKUpXTY = [UIImage imageWithData:vJtmxaZnIzRfCSMG];
	yUPDAZVIzipdKUpXTY = [UIImage imageNamed:@"QgFNOyjPBqXjnVMfJjhGOJTCBKmNDHpYTTGqAIeyhmNuqeDtIriYMoStlempcDQyjFqWdneIBZlQyRZcOASSOnagfzTUBkOtEASmcoZCIpBoliwVFqmCLhmtkvFPSSEPCepZISnkoHerTJMkd"];
	return yUPDAZVIzipdKUpXTY;
}

- (nonnull NSString *)VwdCvfFRmUP :(nonnull NSDictionary *)LsGaiFvvKgwO :(nonnull NSData *)ZvyMMvwoRzqdJ {
	NSString *WaqafNOzuNIdzOn = @"udBrRPdEZdvkezVhEiTqWPukafNROkklSSgeNBQIjgUWzHMzYijsVDNMCwPgTFsCjelVaBSIlSpcDSEhRkdmsIGfxPeQEwtEuFbsLOCvsEyxLkmZHtxucbFtjFWwJIzdJiX";
	return WaqafNOzuNIdzOn;
}

+ (nonnull UIImage *)NxmdKxbHESdcaeZrVDl :(nonnull UIImage *)udNPLZWxszjcUKsKHGJ {
	NSData *vXrlbvmxZrwmz = [@"EWJUsIAIhxOVCIyGxProkQctGSIvLgZphUqRZhjHBMpBNeRrMrqSefvFbrbcibvdeiDbaxSxTcPukykoRPCoBNVogixtFaqNchFUbsGM" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *owYQwmmfov = [UIImage imageWithData:vXrlbvmxZrwmz];
	owYQwmmfov = [UIImage imageNamed:@"mktaUcPRvxWcAzwQwfiWFkNYxSeIGHUGxoAGANktaZKrPviGkGoBuahpiTBwBrlTuOzfDkqttaQjXdubAqfjzSOIILCDvBfFcRSgiLHVDnxAXIRldVqTEFEEQRHdzYBdPUwBuh"];
	return owYQwmmfov;
}

- (nonnull UIImage *)huBYFHMwYlGVoB :(nonnull NSData *)pYJctLsYQXXzNmfxs :(nonnull NSArray *)baTCckuAAcIUNv :(nonnull NSData *)DysqzSkEVIiKbGPY {
	NSData *MhsKLLCiwIJx = [@"CSCqnrvJMVLZHrwJalqPDXfzBMxmFtWhJUsAJgkbzSHojpXFHirGsHxusmVfXJyznwJFJtOYGoyKdJONRjJJESxeuLaKXlRbXbVHD" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *DnxHinIpsKiw = [UIImage imageWithData:MhsKLLCiwIJx];
	DnxHinIpsKiw = [UIImage imageNamed:@"JvKevuWQuSzmEeCPZnXqmEQwBiOQPHOftudYSxkkhkzIuacxDZoVpXzZqYfkKeOBbCyNtfJcfkZOakKZEqhnDqNIjEHWTXxsNfdoBanwaSGymhHFaupAkaOusEtDYyMUUKjDFiyLrYEzwYFJwk"];
	return DnxHinIpsKiw;
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

-(IBAction)OnBackClickDonePenguino:(id)sender
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
