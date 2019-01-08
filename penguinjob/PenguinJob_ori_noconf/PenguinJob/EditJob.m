#import "EditJob.h"
@interface EditJob ()
@end
@implementation EditJob
@synthesize scrollView,myView;
@synthesize CategoryArray,DetailArray;
@synthesize lblcatname,catID;
@synthesize txttitle,txtdesignation;
@synthesize txtDesc,lblDesc;
@synthesize txtsalary,txtcompanyname;
@synthesize txtwebsite,txtphone;
@synthesize txtemail,txtvacancy;
@synthesize txtAddress,lblAddress;
@synthesize txtqualification,txtskill;
@synthesize imgProfile,btnchoose;
@synthesize txtdate;
@synthesize btnsave;
- (void)viewDidLoad
{
    [super viewDidLoad];
    CategoryArray = [[NSMutableArray alloc] init];
    DetailArray = [[NSMutableArray alloc] init];
    UIToolbar *keyboardDoneButtonView = [[UIToolbar alloc] init];
    [keyboardDoneButtonView sizeToFit];
    UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithTitle:@"Done" style:UIBarButtonItemStylePlain target:self action:@selector(OnDoneClicked:)];
    [keyboardDoneButtonView setItems:[NSArray arrayWithObjects:doneButton, nil]];
    txtDesc.inputAccessoryView = keyboardDoneButtonView;
    txtAddress.inputAccessoryView = keyboardDoneButtonView;
    UIToolbar *keyboardToolbar1 = [[UIToolbar alloc] init];
    [keyboardToolbar1 sizeToFit];
    UIBarButtonItem *flexBarButton1 = [[UIBarButtonItem alloc]
                                       initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace
                                       target:nil action:nil];
    UIBarButtonItem *doneBarButton1 = [[UIBarButtonItem alloc]
                                       initWithBarButtonSystemItem:UIBarButtonSystemItemDone
                                       target:self action:@selector(OnKeyboardDoneClickedFinsh:)];
    keyboardToolbar1.items = @[flexBarButton1, doneBarButton1];
    txtphone.inputAccessoryView = keyboardToolbar1;
    txtvacancy.inputAccessoryView = keyboardToolbar1;
    [self getCategoryadse];
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
    imgProfile.layer.shadowColor = [UIColor lightGrayColor].CGColor;
    imgProfile.layer.shadowOffset = CGSizeMake(0,0);
    imgProfile.layer.shadowRadius = 1.0f;
    imgProfile.layer.shadowOpacity = 1;
    imgProfile.layer.masksToBounds = NO;
    imgProfile.layer.shadowPath = [UIBezierPath bezierPathWithRoundedRect:imgProfile.layer.bounds cornerRadius:imgProfile.layer.cornerRadius].CGPath;
    btnchoose.layer.cornerRadius = 5.0f;
    btnchoose.layer.shadowColor = [UIColor lightGrayColor].CGColor;
    btnchoose.layer.shadowOffset = CGSizeMake(0,0);
    btnchoose.layer.shadowRadius = 1.0f;
    btnchoose.layer.shadowOpacity = 1;
    btnchoose.layer.masksToBounds = NO;
    btnchoose.layer.shadowPath = [UIBezierPath bezierPathWithRoundedRect:btnchoose.layer.bounds cornerRadius:btnchoose.layer.cornerRadius].CGPath;
    btnsave.layer.cornerRadius = 5.0f;
    btnsave.layer.shadowColor = [UIColor lightGrayColor].CGColor;
    btnsave.layer.shadowOffset = CGSizeMake(0,0);
    btnsave.layer.shadowRadius = 2.0f;
    btnsave.layer.shadowOpacity = 2;
    btnsave.layer.masksToBounds = NO;
    btnsave.layer.shadowPath = [UIBezierPath bezierPathWithRoundedRect:btnsave.layer.bounds cornerRadius:btnsave.layer.cornerRadius].CGPath;
    [self.scrollView setContentSize:CGSizeMake(self.scrollView.frame.size.width,1570)];
}
-(void)getCategoryadse
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
        NSLog(@"Category API URL : %@",encodedString);
        [self getCategoryadseData:encodedString];
    }
}
-(void)getCategoryadseData:(NSString *)requesturl
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager GET:requesturl parameters:nil progress:nil success:^(NSURLSessionTask *task, id responseObject)
     {
         NSLog(@"Category Response Data : %@",responseObject);
         NSDictionary *errordict = (NSDictionary *)responseObject;
         NSArray *storeArr = [errordict[@"JOBS_APP"] mutableCopy];
         for (int i=0; i<storeArr.count; i++)
         {
             NSDictionary *storeDict = [storeArr objectAtIndex:i];
             [CategoryArray addObject:storeDict];
         }
         NSLog(@"CategoryArray Count : %lu",(unsigned long)CategoryArray.count);
         [self getJobDetailasNow];
     } failure:^(NSURLSessionTask *operation, NSError *error) {
         [KSToastView ks_showToast:[CommonUtils ServerErrorMsg] duration:5.0f];
     }];
}
-(void)getJobDetailasNow
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
        NSString *jobID = [[NSUserDefaults standardUserDefaults] valueForKey:@"JOB_ID"];
        NSString *str = [NSString stringWithFormat:@"%@api.php?job_id=%@",[CommonUtils getBaseURL],jobID];
        NSString *encodedString = [str stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLFragmentAllowedCharacterSet]];
        NSLog(@"Job Detail API URL : %@",encodedString);
        [self getJobDetailasNowData:encodedString];
    }
}
-(void)getJobDetailasNowData:(NSString *)requesturl
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager GET:requesturl parameters:nil progress:nil success:^(NSURLSessionTask *task, id responseObject)
     {
         NSLog(@"Job Detail Response Data : %@",responseObject);
         NSDictionary *errordict = (NSDictionary *)responseObject;
         NSArray *storeArr = [errordict[@"JOBS_APP"] mutableCopy];
         for (int i=0; i<storeArr.count; i++)
         {
             NSDictionary *storeDict = [storeArr objectAtIndex:i];
             [DetailArray addObject:storeDict];
         }
         NSLog(@"DetailArray Count : %lu",(unsigned long)DetailArray.count);
         [self setJobDatahejob];
         [self stopSpinner];
     } failure:^(NSURLSessionTask *operation, NSError *error) {
         [KSToastView ks_showToast:[CommonUtils ServerErrorMsg] duration:5.0f];
     }];
}
-(void)setJobDatahejob
{
    catID = [[DetailArray valueForKey:@"cid"] componentsJoinedByString:@","];
    lblcatname.text = [[DetailArray valueForKey:@"category_name"] componentsJoinedByString:@","];
    txttitle.text = [[DetailArray valueForKey:@"job_name"] componentsJoinedByString:@","];
    txtdesignation.text = [[DetailArray valueForKey:@"job_designation"] componentsJoinedByString:@","];
    txtDesc.text = [[DetailArray valueForKey:@"job_desc"] componentsJoinedByString:@","];
    NSString *strDesc = [[DetailArray valueForKey:@"job_desc"] componentsJoinedByString:@","];
    if ([strDesc isEqualToString:@""]) {
        lblDesc.hidden = NO;
    } else {
        lblDesc.hidden = YES;
    }
    txtsalary.text = [[DetailArray valueForKey:@"job_salary"] componentsJoinedByString:@","];
    txtcompanyname.text = [[DetailArray valueForKey:@"job_company_name"] componentsJoinedByString:@","];
    txtwebsite.text = [[DetailArray valueForKey:@"job_company_website"] componentsJoinedByString:@","];
    txtphone.text = [[DetailArray valueForKey:@"job_phone_number"] componentsJoinedByString:@","];
    txtemail.text = [[DetailArray valueForKey:@"job_mail"] componentsJoinedByString:@","];
    txtvacancy.text = [[DetailArray valueForKey:@"job_vacancy"] componentsJoinedByString:@","];
    txtAddress.text = [[DetailArray valueForKey:@"job_address"] componentsJoinedByString:@","];
    NSString *strAddress = [[DetailArray valueForKey:@"job_address"] componentsJoinedByString:@","];
    if ([strAddress isEqualToString:@""]) {
        lblAddress.hidden = NO;
    } else {
        lblAddress.hidden = YES;
    }
    txtqualification.text = [[DetailArray valueForKey:@"job_qualification"] componentsJoinedByString:@","];
    txtskill.text = [[DetailArray valueForKey:@"job_skill"] componentsJoinedByString:@","];
    NSString *str = [[DetailArray valueForKey:@"job_image_thumb"] componentsJoinedByString:@","];
    NSString *encodedString = [str stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLFragmentAllowedCharacterSet]];
    NSURL *ImageUrl = [NSURL URLWithString:encodedString];
    UIImage *image = [UIImage imageNamed:@""];
    [imgProfile sd_setImageWithURL:ImageUrl placeholderImage:image];
    txtdate.text = [[DetailArray valueForKey:@"job_date"] componentsJoinedByString:@","];
}
-(IBAction)OnCategoryClickasef:(id)sender
{
    [SLPickerView showTextPickerViewWithValues:[CategoryArray valueForKey:@"category_name"]
                                  withSelected:lblcatname.text completionBlock:^(NSString *selectedValue)
     {
         lblcatname.text = selectedValue;
         NSUInteger index = [[CategoryArray valueForKey:@"category_name"] indexOfObject:selectedValue];
         catID = [[CategoryArray valueForKey:@"cid"] objectAtIndex:index];
         NSLog(@"CatID - %@", catID);
     }];
}
-(IBAction)OnChoosaseeClickase:(id)sender
{
    UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
    imagePickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    imagePickerController.delegate = self;
    [self presentViewController:imagePickerController animated:YES completion:nil];
}
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage *image = [info valueForKey:UIImagePickerControllerOriginalImage];
    imgProfile.image = image;
    [picker dismissViewControllerAnimated:YES completion:nil];
}
-(IBAction)seOnDsenateClicksase:(id)sender
{
    IQActionSheetPickerView *picker = [[IQActionSheetPickerView alloc] initWithTitle:@"Date Picker" delegate:self];
    [picker setTag:6];
    [picker setActionSheetPickerStyle:IQActionSheetPickerStyleDatePicker];
    [picker show];
}
-(void)actionSheetPickerView:(IQActionSheetPickerView *)pickerView didSelectDate:(NSDate *)date
{
    if (pickerView.tag==6) {
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"MM/dd/yyyy"];
        txtdate.text = [dateFormatter stringFromDate:date];
    }
}
-(IBAction)OnSaveClickDataadse:(id)sender
{
    if ([lblcatname.text isEqualToString:@""]) {
        [KSToastView ks_showToast:@"Please select category" duration:3.0f];
    } else if ([txttitle.text isEqualToString:@""]) {
        [KSToastView ks_showToast:@"Please enter job title" duration:3.0f];
    } else if ([txtDesc.text isEqualToString:@""]) {
        [KSToastView ks_showToast:@"Please enter description" duration:3.0f];
    } else if ([txtcompanyname.text isEqualToString:@""]) {
        [KSToastView ks_showToast:@"Please enter company name" duration:3.0f];
    } else if (![CommonUtils validateEmailWithString:txtemail.text]) {
        [KSToastView ks_showToast:@"Please enter valid email" duration:3.0f];
    } else if ([txtskill.text isEqualToString:@""]) {
        [KSToastView ks_showToast:@"Please enter skill" duration:3.0f];
    } else if ([txtdate.text isEqualToString:@""]) {
        [KSToastView ks_showToast:@"Please select date" duration:3.0f];
    } else {
        [self EditJob];
    }
}
-(void)EditJob
{
    //======Get Jason Data=====//
    [self checkInternetConnection];
    if (internetStatus == 0)
    {
        [SVProgressHUD dismiss];
        [self Networkfailure];
    }
    else
    {
        [self startSpinner];
        NSString *str = [NSString stringWithFormat:@"%@user_job_edit_api.php",[CommonUtils getBaseURL]];
        NSString *encodedString = [str stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLFragmentAllowedCharacterSet]];
        NSLog(@"Edit Job API URL : %@",encodedString);
        [self getEditJobData:encodedString];
    }
}
//------------Get Edit Job Json Data--------------//
-(void)getEditJobData:(NSString *)requesturl
{
    NSString *jobID = [[DetailArray valueForKey:@"id"] componentsJoinedByString:@","];
    NSArray *LoginArray = [[NSUserDefaults standardUserDefaults] objectForKey:@"LoginArray"];
    NSString *userID = [[LoginArray valueForKey:@"user_id"] componentsJoinedByString:@","];
    NSDictionary *parameters = @{@"job_id":jobID,@"user_id":userID,@"cat_id":catID,@"job_name":txttitle.text,@"job_designation":txtdesignation.text,@"job_desc":txtDesc.text,@"job_salary":txtsalary.text,@"job_company_name":txtcompanyname.text,@"job_company_website":txtwebsite.text,@"job_phone_number":txtphone.text,@"job_mail":txtemail.text,@"job_vacancy":txtvacancy.text,@"job_address":txtAddress.text,@"job_qualification":txtqualification.text,@"job_skill":txtskill.text,@"job_date":txtdate.text};
    
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc]initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    manager.responseSerializer=[AFJSONResponseSerializer serializer];
    NSString *contentType = [NSString stringWithFormat:@"multipart/form-data"];
    [manager.requestSerializer setValue:contentType forHTTPHeaderField:@"Content-Type"];
    [manager POST:requesturl parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData)
     {
         //1.Featured Image
         if (imgProfile.image != nil) {
             NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
             [formatter setDateFormat:@"dd_MM_yyyy_HH_mm_ss"];
             NSData *imageData = UIImagePNGRepresentation(imgProfile.image);
             [formData appendPartWithFileData:imageData name:@"job_image" fileName:[NSString stringWithFormat:@"%@.png",[formatter stringFromDate:[NSDate date]]] mimeType:@"image/*"];
         }
     } progress:^(NSProgress * _Nonnull uploadProgress) {
         
     } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
     {
         NSLog(@"response object : %@",responseObject);
         NSDictionary *errordict = (NSDictionary *)responseObject;
         NSMutableArray *ResponseJobArray = [[NSMutableArray alloc] init];
         NSArray *storeArr = [errordict[@"JOBS_APP"] mutableCopy];
         for (int i=0; i<storeArr.count; i++)
         {
             NSDictionary *storeDict = [storeArr objectAtIndex:i];
             [ResponseJobArray addObject:storeDict];
         }
         NSLog(@"ResponseJobArray Count : %lu",(unsigned long)ResponseJobArray.count);
         NSString *isSuccess = [[ResponseJobArray valueForKey:@"success"] componentsJoinedByString:@","];
         if ([isSuccess isEqualToString:@"1"]) {
             [KSToastView ks_showToast:[[ResponseJobArray valueForKey:@"msg"] componentsJoinedByString:@","] duration:3.0f];
             [self.navigationController popViewControllerAnimated:YES];
         } else {
             [KSToastView ks_showToast:[[ResponseJobArray valueForKey:@"msg"] componentsJoinedByString:@","] duration:3.0f];
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

//----------UITextview Delegate Methods-----------//
-(void)textViewDidBeginEditing:(UITextView *)textView
{
    if (textView == txtDesc) {
        lblDesc.hidden = YES;
        //[self.scrollView setContentOffset:CGPointMake(0, self.scrollView.frame.size.height-717)];
    } else if (textView == txtAddress) {
        lblAddress.hidden = YES;
        //[self.scrollView setContentOffset:CGPointMake(0, self.scrollView.frame.size.height-627)];
    }
}
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    CGRect previousRect = CGRectZero;
    UITextPosition* pos = textView.endOfDocument;
    CGRect currentRect = [textView caretRectForPosition:pos];
    if (currentRect.origin.y > previousRect.origin.y) {
        
    }
    previousRect = currentRect;
    
    return YES;
}
- (IBAction)OnDoneClicked:(id)sender
{
    if ([txtDesc.text isEqualToString:@""]) {
        lblDesc.hidden = NO;
    } else {
        lblDesc.hidden = YES;
    }
    
    if ([txtAddress.text isEqualToString:@""]) {
        lblAddress.hidden = NO;
    } else {
        lblAddress.hidden = YES;
    }
    
    [txtDesc resignFirstResponder];
    [txtAddress resignFirstResponder];
}

- (IBAction)OnKeyboardDoneClickedFinsh:(id)sender
{
    [txtphone resignFirstResponder];
    [txtvacancy resignFirstResponder];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [txttitle resignFirstResponder];
    [txtdesignation resignFirstResponder];
    [txtsalary resignFirstResponder];
    [txtcompanyname resignFirstResponder];
    [txtwebsite resignFirstResponder];
    [txtemail resignFirstResponder];
    [txtqualification resignFirstResponder];
    [txtskill resignFirstResponder];
    return YES;
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
