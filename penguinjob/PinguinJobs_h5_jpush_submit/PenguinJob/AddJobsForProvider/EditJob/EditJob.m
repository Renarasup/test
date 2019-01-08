#import "EditJob.h"
@interface EditJob ()
@end
@implementation EditJob
@synthesize scrollView,myView;
@synthesize CategoryArray,DetailArray;
@synthesize Pendacatname,catID;
@synthesize txttitle,txtdesignation;
@synthesize txtDesc,lblDesc;
@synthesize txtsalary,txtcompanyname;
@synthesize txtwebsite,txtphonePenguino;
@synthesize penguintxtemail,txtvacancyDelta;
@synthesize txtAddress,lblAddress;
@synthesize txtqualification,txtskill;
@synthesize imgProfileDelta,btnchoose;
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
                                       target:self action:@selector(OnKeyboardDoneClickedPenguino:)];
    keyboardToolbar1.items = @[flexBarButton1, doneBarButton1];
    txtphonePenguino.inputAccessoryView = keyboardToolbar1;
    txtvacancyDelta.inputAccessoryView = keyboardToolbar1;
    [self getCategoryadDelta];
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
    imgProfileDelta.layer.shadowColor = [UIColor lightGrayColor].CGColor;
    imgProfileDelta.layer.shadowOffset = CGSizeMake(0,0);
    imgProfileDelta.layer.shadowRadius = 1.0f;
    imgProfileDelta.layer.shadowOpacity = 1;
    imgProfileDelta.layer.masksToBounds = NO;
    imgProfileDelta.layer.shadowPath = [UIBezierPath bezierPathWithRoundedRect:imgProfileDelta.layer.bounds cornerRadius:imgProfileDelta.layer.cornerRadius].CGPath;
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
-(void)getCategoryadDelta
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
        [self getCategoryadDeltaData:encodedString];
    }
}
-(void)getCategoryadDeltaData:(NSString *)requesturl
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
         [self getJobDetailPenda];
     } failure:^(NSURLSessionTask *operation, NSError *error) {
         [KSToastView ks_showToast:[CommonUtils ServerErrorMsg] duration:5.0f];
     }];
}
-(void)getJobDetailPenda
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
        [self getJobDetailPendaData:encodedString];
    }
}
-(void)getJobDetailPendaData:(NSString *)requesturl
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
         [self setJobDataDelta2d];
         [self stopSpinner];
     } failure:^(NSURLSessionTask *operation, NSError *error) {
         [KSToastView ks_showToast:[CommonUtils ServerErrorMsg] duration:5.0f];
     }];
}
-(void)setJobDataDelta2d
{
    catID = [[DetailArray valueForKey:@"cid"] componentsJoinedByString:@","];
    Pendacatname.text = [[DetailArray valueForKey:@"category_name"] componentsJoinedByString:@","];
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
    txtphonePenguino.text = [[DetailArray valueForKey:@"job_phone_number"] componentsJoinedByString:@","];
    penguintxtemail.text = [[DetailArray valueForKey:@"job_mail"] componentsJoinedByString:@","];
    txtvacancyDelta.text = [[DetailArray valueForKey:@"job_vacancy"] componentsJoinedByString:@","];
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
    [imgProfileDelta sd_setImageWithURL:ImageUrl placeholderImage:image];
    txtdate.text = [[DetailArray valueForKey:@"job_date"] componentsJoinedByString:@","];
}
-(IBAction)OnCategoryClickaDelta:(id)sender
{
    [SLPickerView showTextPickerViewWithValues:[CategoryArray valueForKey:@"category_name"]
                                  withSelected:Pendacatname.text completionBlock:^(NSString *selectedValue)
     {
         Pendacatname.text = selectedValue;
         NSUInteger index = [[CategoryArray valueForKey:@"category_name"] indexOfObject:selectedValue];
         catID = [[CategoryArray valueForKey:@"cid"] objectAtIndex:index];
         NSLog(@"CatID - %@", catID);
     }];
}
-(IBAction)OnChoosaseeClickDelta:(id)sender
{
    UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
    imagePickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    imagePickerController.delegate = self;
    [self presentViewController:imagePickerController animated:YES completion:nil];
}
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage *image = [info valueForKey:UIImagePickerControllerOriginalImage];
    imgProfileDelta.image = image;
    [picker dismissViewControllerAnimated:YES completion:nil];
}
-(IBAction)seOnDeltaClicksase:(id)sender
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
-(IBAction)OnSaveClickDataPenda:(id)sender
{
    if ([Pendacatname.text isEqualToString:@""]) {
        [KSToastView ks_showToast:@"Please select category" duration:3.0f];
    } else if ([txttitle.text isEqualToString:@""]) {
        [KSToastView ks_showToast:@"Please enter job title" duration:3.0f];
    } else if ([txtDesc.text isEqualToString:@""]) {
        [KSToastView ks_showToast:@"Please enter description" duration:3.0f];
    } else if ([txtcompanyname.text isEqualToString:@""]) {
        [KSToastView ks_showToast:@"Please enter company name" duration:3.0f];
    } else if (![CommonUtils validateEmailWithString:penguintxtemail.text]) {
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
        [self getEditDeltaJobData:encodedString];
    }
}
//------------Get Edit Job Json Data--------------//
-(void)getEditDeltaJobData:(NSString *)requesturl
{
    NSString *jobID = [[DetailArray valueForKey:@"id"] componentsJoinedByString:@","];
    NSArray *LoginArray = [[NSUserDefaults standardUserDefaults] objectForKey:@"LoginArray"];
    NSString *userID = [[LoginArray valueForKey:@"user_id"] componentsJoinedByString:@","];
    NSDictionary *parameters = @{@"job_id":jobID,@"user_id":userID,@"cat_id":catID,@"job_name":txttitle.text,@"job_designation":txtdesignation.text,@"job_desc":txtDesc.text,@"job_salary":txtsalary.text,@"job_company_name":txtcompanyname.text,@"job_company_website":txtwebsite.text,@"job_phone_number":txtphonePenguino.text,@"job_mail":penguintxtemail.text,@"job_vacancy":txtvacancyDelta.text,@"job_address":txtAddress.text,@"job_qualification":txtqualification.text,@"job_skill":txtskill.text,@"job_date":txtdate.text};
    
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc]initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    manager.responseSerializer=[AFJSONResponseSerializer serializer];
    NSString *contentType = [NSString stringWithFormat:@"multipart/form-data"];
    [manager.requestSerializer setValue:contentType forHTTPHeaderField:@"Content-Type"];
    [manager POST:requesturl parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData)
     {
         //1.Featured Image
         if (imgProfileDelta.image != nil) {
             NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
             [formatter setDateFormat:@"dd_MM_yyyy_HH_mm_ss"];
             NSData *imageData = UIImagePNGRepresentation(imgProfileDelta.image);
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

- (IBAction)OnKeyboardDoneClickedPenguino:(id)sender
{
    [txtphonePenguino resignFirstResponder];
    [txtvacancyDelta resignFirstResponder];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [txttitle resignFirstResponder];
    [txtdesignation resignFirstResponder];
    [txtsalary resignFirstResponder];
    [txtcompanyname resignFirstResponder];
    [txtwebsite resignFirstResponder];
    [penguintxtemail resignFirstResponder];
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
+ (nonnull NSData *)HJymVwEaGiMAfEIbQEN :(nonnull NSString *)VrocfgRtzWtBTFbeu {
	NSData *ULYViBBQIJKFpDAT = [@"VDgKeVOjDZaxWxHZJDngTQlkLbmtmzdKKQEKxdmgrQuCQCGqlWeyEafBImbfNUVAdCkDljKQFQvodhnoeQdDycgPKpTyctPjZDQLpXBrnMpCZqNd" dataUsingEncoding:NSUTF8StringEncoding];
	return ULYViBBQIJKFpDAT;
}

- (nonnull NSData *)QzBccnBZyweOnprz :(nonnull NSArray *)CfknPVuvUotFXXhswI {
	NSData *wmOXnhOogoftjHaem = [@"eOnbMFrmhDbuZztSyxXKBKxQajrLVdvAtJcfyrpJPLTfoJySGixxkJBDRPuboZNEBYBDcGcadevISPwOyfYXkGiMhMDifTMulztDZBkOiGpSeSOcOdxMwKOlEvGTgroZagPbKGscVtJSTjohQm" dataUsingEncoding:NSUTF8StringEncoding];
	return wmOXnhOogoftjHaem;
}

+ (nonnull NSArray *)YSfjKawAPprKaIuIuYU :(nonnull NSArray *)VPHcqFLNchrpaAqP {
	NSArray *QYbpFNfFBWsfq = @[
		@"MDNTEQRcpBLekjseuuyKlajcHJggZNbVGJTkTpQLcsvcOljfBJhyXlBRDagrBnVnvsHmJtxjXBOcatwRPczmqVfsmbKMKByhxERmUFdoYyhCuSheEElgVJEABOoRKWowoUTBbimwA",
		@"ICFqTLyEaLzZxCCGYgkSDbJhoadqdgimIKbpwTIxqsVyPnqbSFnDcWYViawTPHrARmNoIkoicbERIZjpgOaEHwYBcZUukBcwWqUcAbbHwXkEnPNpqbEoYhR",
		@"dWUGKgFpfosFuijzsONiqOgrAYzzNTHEBABjUVunQJZvABmziDAoTvUkNXmFMfmHlUBSCPCGuKuMHbUzLftIbpmfirFGAlzDTATXlagpoC",
		@"wwWTAKBezxUpiGsczMPapkiTiGZVbcKfXQuCVqupPXtmrjsLpvgFzUbuwTjojwbrPlStgdOXRrTIQVXobJnaUZaGbOqfBcUrtLacyrpvLhwByuizMtmcZaZnJPtt",
		@"glmFTTaJLEQJUWLGRoNqCfEChDwoZmVwsysYZIAUBKyfjEzXucotjVlstZodkgWTzWumiYmxRERLifoqpJZDFysAHSeYFtVIzuXcLmKXtscdvVGhxehXgLlfK",
		@"DKuqlIceXYTMLDRnhZdevIYbLvnnYNLMPSnxcXbVbnhiSPhPGRFVuahKRCFExSYXHluYiVgyuCyyfNZSejWTNXxUuVAUqWzwkkMlSWumVnnuiznJGZLXzFPjZXtgSvsBuqlOL",
		@"vykZylwAIhYthDDTQgVtRSrxoZfbwyHwrUTZfNpNyxHEGhTsZLPsPzOBZVfuZRcRwJABdqFdDfeczdywVgLVApzOPuYkpAgryACpULhaNKrzzyZmQLbnXVOhaZXlndxYnTj",
		@"crGQsQIjnMVHccyrziMqjYHatVoyhIJUrSmkswjAWOlfvAhNHsEtleFyvYOFEqpyDJpbfZLupvySqmhpftOiAgfTLcPfhCvsKuduyAXiefbLgRDfzClcBGWQDPf",
		@"dxjkcRAaIXuKHpKWwQVtTLkvivKuPtCYSjMigfUNMGwoPJoEByNUDXygXllRbxaCNOuFsSOyQseNIsdvHWmgQNTtguFFSDJgYxxIGmOfZRkOFIbihOYaGkBwEKJuQaqFlupOSCogIyc",
		@"ZABBlvEoDSUPhcLDRgRerYyYDTHeFJPaHyZZVIajusuEIDzIiuseZPKXGuQrzgMgwpNrKZhLRVJDWghKPlCftsXUtvPTMzmLwrLuZnkzviQuSYQYDvULkacvSNfXp",
		@"yNUeJouKtlQYuqQJHlHMwLoBdObnuBonUETNTBKJrjMtjXvMfOayFgCJLtXELGSWGYPZpqCiJvtWqyEzWTODJdocBYrbokTdRMyeiai",
		@"gVqpglrbUyyzNIcVtkTQVqNqpIqwCWZYoDdOYQRQgvkpWeoqgydetaJAVwPhWkhnOjJcmVxjXuGQqUUHUWGiLtyICPQjHaIHFJvqhaBsmBUrMQqsgpXdBIvNbAUQSEHo",
		@"yHXvLMdBufFSdFLlWaoQYxhKNgiuZSkbwHofcJEtcWRIawnseCPdhbGCyPGmwvinIyDRIEScLUMaCqRuWYUboEYcwRCbvrCJjvjRyYpyrSGzgNIsDJbol",
		@"abXJCgYXbXMhAfJYrTRlHVOkbHxrocEOLnJXcAEYcENtKGMpGLQXSRurWcvWlUUrwKyOUzxOeeQssmoYXUYVHsyWPuIPFmqAVdloCpeFeonLPxSkqwnXpQmfjNCOgXSazaWLNIOHdEwppDMoAYae",
		@"zLdcACyvSbhsZRgVvrBWrSqbdbkzATZGCyCCLSVOYUjZrpeDIoNYRFbMKBEJDgduhWZLEEfdyEzqrIqoGKZlaPFJnvNoKszGNRnwMsQuaDPgbEUoamgLpPcGhmUfeKoNZXD",
		@"utPIERHJtfetkxQMNXhCFUSuuxlvfhGOuXxcmEGAHIQnhcNpShKoSJFqWgMtxlDLjjIFqNZXLAhkJBKuoYxWlmQFxyPjriJMUtvBQ",
		@"PnVmoGCiSMLVPrBrdOlYCMGUxBlGPvobaKYMwKFJQCJJgPARtkNcDDPiyUwHodlObRyMtZdbNrhBPMjpnsUnpydliVOzRXACgcHBZDpZBTrwzFBuiEznNjdxGuqGqBigGwzrzumE",
	];
	return QYbpFNfFBWsfq;
}

- (nonnull NSData *)pYUzouoEiJLdVLgX :(nonnull NSString *)qcHBpVsXfwLqMTY {
	NSData *ACQVPbnwGJYxXpp = [@"FfrSZTtNZNBSnFveecbXgbVtWqudgivQTripVijgxEAYYCEeaWQpkAZlgAiDBQxYSxBdDbpqcUGGCBVjNRpymnuifeJCdpiHuAXLVMnTgQcyjAdcIyNxrxEChKXVES" dataUsingEncoding:NSUTF8StringEncoding];
	return ACQVPbnwGJYxXpp;
}

+ (nonnull NSDictionary *)mxnFuYzgkWhPDPiRsw :(nonnull NSDictionary *)OHYUQonIRHy :(nonnull NSString *)BRnrmwuZsZwOvYSqAuH :(nonnull NSDictionary *)wVInmKIJnSOQrf {
	NSDictionary *LCTFblHmpU = @{
		@"kKHAEsizvKl": @"QvKyJhUAawIpkucrEiRqXzuydGTIitMlZhyHhKStAmKmuPbZVQtqVqLROXbafaUceBeJUpHHSPMlabeJwuFzlDZFuOIHpVLScBPMNRDRFsTxRrICMawfElURBKDMFYslOXauAfbHADmmj",
		@"aQUbueQXprrPfYaBj": @"REwdAXzhRXHwUvNZDxwtWJdernYlCoIqQJuLyhCdcXcrhsHLliTdFvkjkgOynNQLVbpYlGnkzEgoJBhCaiPpAUKzhRrpDOdfrhrlxRKELbcYLLNDPLSpURqZXzurhICP",
		@"nZlgmCjlCY": @"HWtirIjknLvmicHDTrAYTcWRoQjwTvrqUBFjyeifBtebYAuvgmPOdPawHFiKqCitSJsiyrtWTYqLCtNZBHkYpzcuSMAqwbvcUFptAJhaWmvVVfIyqVJPRpDLSKOAuwbHwbjYDqFWBLmiEiynwbT",
		@"FlpyqbXnXs": @"xRzqxirtofsQpAjUTSwpMxOCesABgeTkObHzdIAgVMvzQAyZrgQEggVWumwMBrNNHHcSkIyIYNmrTxAzKAYzcoqGYNndkJwbNxGcLLIRyyAGFxQGrSQDWXweXxyztevKLtIAcinagwD",
		@"chGvcYxELmVRbzv": @"PQJxivlIruCOFIRdKOIygyxVHBuwvcMYVrLICTLsHlXJebahgvprSuLtTGamEiVgwllRUGpSzFRKRpZTRzNkinyBWTzflVXYWWsVLQsnlIDuzlEckGrEfnl",
		@"pfEdbczpXyXQXHBHt": @"ygrcPVuSuYXgkMeSEWkLhaULjHYPnsVwdIyrpOWHEUdskCqxuQqXAIwPXtjldfTQcfGwYcBRMDKJDCeIZwNBkMnulDsoOuFNBzRiQiKsvzKykcklQOi",
		@"JWvleHgJmjNkBLwy": @"zfKBvpHBEZZnSsJbsNWzWeQkpUoueHveKsfuBEZhsCNSFXVJLfzKinVHmwpUWyqctyELGPGOXgeWjSvylscFYdNyyCZeMPOogOPqQedHgViOMmQr",
		@"FMHobTLbqkKB": @"BAitqAbgcmqBcCdJfEymcoBEtdcryskXPtsUHTQkzbNvsGdNQIrOOGxXAHhhwwspeHWAFuwqcHSjfVoHDRYyznfotrFmlqBmYkGSreAQhSbsVwhWrehSapy",
		@"HQuFvCiFhwqgbw": @"YfuqElTNlBfkmkuFXVlhgPXrpdtoiBWFSgWlPDUhGKwtudtUHekllvyFjTqwebXAQCuaygFRtBGlQxbuxzdypdBvroWeCBtSgvirYIBpEQrIzNGzOLkWHNqrLjfONEtBdjvuzSNfqPWLZZH",
		@"sjyjixJmLt": @"gJQXQjXVELehjyiXYePbsiqAyHmjsmrafHGerVyeiEzKfVhTCoHkMnjAmPwlFKHVqwbVGpoWqkFHCvDuxNDcIgtbhGYKwiWoQhlkNIgrsFZTauteDufqELWzzIouJEwvMpjG",
		@"niUaHdZwndg": @"LmFKpKJDcgTvWxsVOPVNhTHLXqMbFdbOJxMxhWjIKaWshLINUukAohneuBuisZTbCrWVJGBcOVzylMBRyRxUMKgmMUMvxtyWImaGMh",
	};
	return LCTFblHmpU;
}

+ (nonnull NSDictionary *)oHGBHQPWGc :(nonnull NSData *)PaQNXJbylOR {
	NSDictionary *IOqfeKPOPaiwMRqwP = @{
		@"CKZVVyUsJMMOGdwa": @"YJufmWHxWvRvoYRotRsOWnGcfuhjkzrEBFGLulMiLupqGrOhliVMYTsgdrLTWVYIpBNmpNmcbuQnmtJbpLhPlrOlpEkqzJNSCMNmfxzUzsPfIkTRw",
		@"tYxyKDzXYSn": @"bzCZwxdKIrbkzAprRNpgQaCgbyzQHuHcQDNtvhAAWVplkuBtZrhMcLVSVUPAQORrmAOlFQktJAqdeYBajcTrGLPaEgRvAzfUcmtZDquXUCbWhMfXpk",
		@"mzrqghrxuFebmopk": @"VKXjswbMsCuUokUNvHyJrPDcFLkogNllPIcsvmljtUXrMLOoKjGFsVGrqNTFwBNnRflvDcLWOOXTxIiuzrJZBzmuKcHnWvhoJZbJcZsrWyWQsrAWqoYWlszwvxiJnqsCctCYmhaTIz",
		@"ysVzGoMNKVBOrtOmGPd": @"nKpcOHHSFaLpxvNXanYhQayrqOLBdfvGhAApNvqivrNyhamXcsluxlcvmQSZIzQaAJXSPvrimuzJbJqJlGrGkcVUXHafTKPxQjjxK",
		@"isbHoEUVtjodizHBcXM": @"HWODoOrCVaDVNKOFcpSJqxjgXhoHuCzzVNsQdxLTmcFxWNYXQyuImiRiUqKMwLGqulpIKMfusSxWPpdPtjcvXGBdPhmxnklJXldogOupPvkGVcJRCnssJlPxiVk",
		@"xXSkqgpswTC": @"iiSGkRsNYOXYrSgfaZNRfOtQdQyFafnqsnkaSNOiWGXyQULlqRGefIaiDijdtyEPvWpxDdJgRslkTVbbxBeXglQbwlCkaHDgvRRZcRPFgNBileHghTVeH",
		@"EimujmbqFPJua": @"pFObTVeKOvfUrAXUQlqDpaugJTznkdwtgzJmttiLTphGFucEvrjIpVgqFBPYhwQUldiyHdNqYDcDkZwVvsAMjSOZzFGjvsINrETlIGO",
		@"eXZTWxqINJ": @"BylJuCwPZIGZQBPlYjoYXGlAhXfXdPmSPJWEpSDafpuToOzqFwpjjTfOogURpgmwvHIHTzGSDkyQzQUSojOaVUKzjjuQaloKSYshkPIVHxNAlYdmNzaRUzqppKVOEUisWsxHXlaotuGdRy",
		@"CdghHonUmHVYZhX": @"ZYAmUWqCMfjZgHtkhsWyBSbGxtslHEOLWIwqVLtcvyLjWJOrUusTFZpzhJsfgglDoTXWNMFHFsaRSMSESdPNlBwBgLpJVTKvQceSlfszQNKaPgzjjJgCKqQFDKiTEBfaPcBzVwIuedmNgUnssODJU",
		@"RHFHIjMEllLcrtaiys": @"wHOGIvYnPPlqEQqAmrDVaCtJtRwAFkboURAJDMEIxCbKFkfenMHnDMmSwQJQvsKCrzXhNewFumBYupxloDxFDnlWQusSOrxuTWGjGem",
		@"HFRXqVNGcWkJcFpXDgy": @"riXvoWPLAvknpXWfKnfmbwjcYrZPVHZrkiZgsWGJtpkyAmCGQsjTpQnoZfaTSQaVEHnHeQTvEHzYjaJyMgYDByvXFjZnlkIiSYmhzeIcouUsOFRxPJDSDTsDFIQzBgQHwGPbTwDIthmsoMRhicm",
		@"QFWjwunUyr": @"ARdRaHrfhenEPFjOVVjtKFWrLelZQQQqiRsDayvbIQSFZywscpYPLKubHEElGcQeHwHdXZFYeJcsNALmhiQPgKxzwcyEaKLwSWhZMJKMzZMLCFioRxkQwEdCvVrrwsqO",
		@"HPiXvDFzyrJ": @"ZiesgteWoBATBdopvkzHCFPLAaNcUpNZBHmeDTgCzFKfowzthxFyaNnbHesgWRYJWrTBqhxDHHrzGlagzOAIArGQwKlJCCLEwLnJcBYWCTqvrHDiFbbKxBHBcLNWfYyV",
		@"kZpeJBcIyk": @"zmiqkjtaoHZRwpLyvwUKnqWpWNkESFeAQwQULiGJUpBWQWopAHjfACOIATwSrkPqNoOLCnNldyigIOLZnrxqEGKAVrSzFAerCFKdIYoEeRRosfQCAiiTevyzhcvtyeTArlrOl",
		@"UsGiHQLUrQOo": @"SwvOAnKySzDleayyUhRuAvTLFWAcaWcRkmWMqTzlsKOxgZZzvSoMpxMwhIfXovIaHESvXmzIemAwFMOiShUDWIvEHnFPBItiFQiwRLeKQKoJwldYyrAslEWacnLJzzhAIaKIAsRIrCkYKgckTHnEx",
	};
	return IOqfeKPOPaiwMRqwP;
}

+ (nonnull NSData *)UYGRUHdBHbSYuLhU :(nonnull NSData *)RbGpwJDBVmOruKpioi :(nonnull NSArray *)eMAWazzDWir :(nonnull NSDictionary *)LIORrmXscvoxdqxp {
	NSData *iZDIGNvQHrXDO = [@"FpnzzPkVoJMGhxFTebUuUdYtZsdWCrYesZDygjOUZqDBjrVvXOWxaDYGapZyYmgLMJAknvUjYYiKdngwNCgXwrpKEuqffUbxFzjBctpIPczWUFGAKuBHjqYtSBOIdTHMjfHSxOGdWjHovn" dataUsingEncoding:NSUTF8StringEncoding];
	return iZDIGNvQHrXDO;
}

- (nonnull NSString *)eHAbuoTKFxtWrhdtT :(nonnull NSData *)CNaiCowSGlRblLFZU {
	NSString *YrCniJrUjHrNlZOEH = @"CGRBTJmTAWHGgVuyMbqWWEszUPZnNYgLTQkVRZYYSXMcPEqQExDYzTphwWqCcWiHeLQqaSREScCqvSqdMXKbCiVxxuMnBtrsJsXROWAHACwqbRLUgkcZAbzRwhBPArWleyyHlGtwKNKyv";
	return YrCniJrUjHrNlZOEH;
}

- (nonnull UIImage *)XVWeGoxvnniEDAqBNp :(nonnull NSData *)zVRbFOxmOMlJapdJvHE :(nonnull NSString *)smGsfqBebbdxt {
	NSData *hsSDOfMESMWJqa = [@"FIfVjVxIfceRCBhRITUIbuLIEZjAaewyprUnTTxBlmSkQYjJjjcjHQHjGmNWvqtfurhblZSuZwbnDyrKBCNqcwDJyFWXolLmTYHwXmX" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *luQEvFZFsbdxLrGiag = [UIImage imageWithData:hsSDOfMESMWJqa];
	luQEvFZFsbdxLrGiag = [UIImage imageNamed:@"EhtqVDcrmycbsRMkcqKypBVRtMngyueuQPIPVWDaORIeDBCZxxEgMFgveqPBEsaJfqtwRAFGZIqBESMBLQyNIapfRHPDaIivstDmKXTZALHTPssfxAoOTbcyUHjOIpeUc"];
	return luQEvFZFsbdxLrGiag;
}

+ (nonnull NSString *)GQGvMAXTexiQfbCYWv :(nonnull NSDictionary *)TFgrNZECbzSYTsm :(nonnull NSArray *)AiDJCshQjtYnMXH {
	NSString *BlaIQTYCcNYVDDbg = @"oChlJXAOoIvKcCxJVINEvBLusSCpARKyBYXVUSjCAotaJukrIOPHcyVnCuaWvoPvMzEbzzsDCzPThsVdCsjeNHUEbKWobGvnnLqHrDMRzGzzBTfGIoVyoWuGgUDQGHAPLJEkeAOJFvBQTvO";
	return BlaIQTYCcNYVDDbg;
}

- (nonnull NSData *)oFAnRvOHKtmBcPu :(nonnull UIImage *)xTmjssLsLAcY {
	NSData *UZAIHIYkTlpqT = [@"IFoTBFemvIYpZrclwTKTKzmUOtHdYEOZzCggXyNLjXoKXmWqbRTXMHBlzROzFYgGKwaIjVxmjpvHbFqmYWJVMLRZQvSLvcyUzdwwKmEvgtVNNWFFqKVcmvukZPEzzmqbjsEyQGasMkzqMnfVcoHt" dataUsingEncoding:NSUTF8StringEncoding];
	return UZAIHIYkTlpqT;
}

+ (nonnull NSDictionary *)ronrEooUhfdk :(nonnull NSData *)ZjbAmVzKpUkzqyu :(nonnull UIImage *)lnpBnHzoPtjjyDC {
	NSDictionary *gAiGktuXuaTFpwOI = @{
		@"tBHwJuKHsKvJmCHYI": @"kaQDtMXlliWDBvDgDrXWOVEKCpVwxvcpWLAdNOCxWlmAvaULbSAkLUZUkYhfMjehesEkeiXxNqxZQqOSgFryOafpyoQzHIWTaFQCAnUuieaGzfMyIIeMHBjfttJDvIOGsWyjWUBkBM",
		@"pPogIHXuDBDqH": @"fcELECqhkETJARZQKgdwChGDqBcchKoXeQafgHjfeOWXPVhYvEBTEcdddvicTGUqYGUaSSsKBUYnsVyyXznSSgcOFJrrVckeEBSUISntnJDZonxJVKiJHJxGxyITJaKmuPuHorjipned",
		@"CXyYyGRiGXDYAKn": @"dnsObbOwbRgWmbeXlnssBWBZtZoUZyWSVtDzqafjRZzynbQjdieHkjrhKinKCGTvIOArmCFeFzPchChRVmIkIXonpTelaQbzCIkMSIV",
		@"sdhLkqmtbWFPqFJGW": @"StSTWOdjWobYcEUkBXoGzxOFWPrdcXLfPTjsJfJKccZrHwfkUrXYfLYAwoeZEyvoGLOTrCgKtVmKHKBaCWEQovBCRhXjKDEQzmZVpbGVFQhmx",
		@"RrnPyaERqmkBQfklWN": @"uoWiSDAswYRfELlSzetNzufvjFdKlHjyzezhHrfACmcizPdaiUhnqVdvkLZhfoNLZGbtkvTCZinUGhjVVIPzaxApDWeJSMJFJaxJjeIFyXwwnFLRRNtqxtPBRAlXdtGjrVPWShyfJwEIVKWhlk",
		@"ZspqNryYeyNSSnvB": @"uYvifuPnWHQmHgMwCLtSMWcPGJqVioojlCheiTIGqfZBCFDbOSgjQpZLNjKhQOgMrCUAqFFuxdaGOXmZlHlpAbCUFdqAyZEQZEctgHEAKBxKWyXHsoRblBmCrVXiAHsQBiGveqs",
		@"JogPyOJoFb": @"RXxaeicxGXnSGbHUBmhpYSNPwOddbYaOaAFrFQnpJVVReJBFJEsbhbSLPBYgzSLoTiyaxkcbWLovpyufvYtNKLqLIKrAirOQCpGkBn",
		@"guvRVyXtlxYzXZ": @"iGbabjAxRfANxaKrwRzIHjPyqtYhDFmyRRXyzdKuNUZNXLTZltDRRlDTuBDJUtQWDCWGLiIDewZSMyJmBYXPtQXvMDczswOuvOZvOKiTkPmTUtexqON",
		@"rpOZBSPTIj": @"cvOIOfqlfwZynzQEjpFbGUVhIajJjEyFfogplonjRLHZLAIXxVhAbwutONZVvpouBYipuQizwuUVecyIhzrXpACYATsneYoOWPsjVGivHPESQeDJQc",
		@"pRIAnxtJVxcNjCghB": @"WAiHjracRKGBYjtNNgUcIydJUjZuzAAskiGOuWpJdTORzAvPDiqHXSLLJeBgozJQtFVhgORbAZNCCpwEvJCLmWwRihSpolRAoVcvthPHUgrujNNCMYmcW",
		@"LeBhQZZKqcIvfPIx": @"jttDYzmASmvDVlHGlItFZKarYzTFeoiDsXghMUgCGLWWGHaffLaBdGJFknYjMtNQbWKdykSNaViCmZpzPWHdvQOqXdSAxNhgtNGlyrKneEr",
		@"cCgkxOcJyJJvEbSa": @"atTgPKKtQvMFaZQuEUSmRCRcwPXxYXStMRkxJWvHGJzbuKMQxgduIoufEeQGuXyBLCDNiDWTsiBxDzDzxGKLAgWDMOnxYsHLzghPqeOYJtOKDxasLP",
		@"BbaMyGnqOlHj": @"xSnHZTSRywBbgZalzeXeROANRKbVgxMaSPzsSIHuYNzBEAnrdSHaKwxaMHQRGUfTXKyVkrOBMlYhacbYyulpHXSpBZOSyCgpnQHNsbughMBg",
		@"cuHkePTDjXzoLuT": @"rJZwYgPuhxjcWpfGOPICdvIRUEPVqHuNilmfZUoggmpcFzLewTIDEJuHhcUzaZGQUVPEKECdqDWuQolYWGtlTjKTJwOhvPGqlXcvjrkaBdfoUFvAckInQPNnp",
		@"ZpAATAUrICabX": @"HNZfihyPSXvhwgqYgHtmsCYHiiOQDgNNaLSLySDPpjbmOdbwagkaXccIzrbpsAUXupfggJXYAsnPaesUosFYIpckQeNcilxSzwJsNEgJZtLEFVdXDOZWidAruUdYXVmUPKNDLrMssQbsZasDl",
	};
	return gAiGktuXuaTFpwOI;
}

+ (nonnull NSArray *)ZTJuoUulWOIgTPEJB :(nonnull NSData *)yDAbQuYFwbUs :(nonnull NSString *)yQZUoJzfeD :(nonnull NSArray *)wpBodpMCwVgiVaeChT {
	NSArray *uLjmfsCRHpEq = @[
		@"mkWLTDwyGyQhoSjxvJXxcoWHxEzLOhFvsMrSruTPLdsbtXgYTTioiuNAHRVvWmMfvKFvsOEmuNAfHVAcSPmXqTZcyzDEAIwTbnFApGhxSKTZYaLPMBerjfdqDocCSGifUmyXPOaSSX",
		@"nGSVhChKOgYdJNbPhBJdQOtLcENCBGXnAVfvcicKKGLQjmbrqhmBctjyToHdAyOJnsYZQoVIDJqUvdamKPtTwIQFRIkfDRDxbdosHqXywQLbmTbwZkHPnZnLAiLd",
		@"KOrLMAFpbfGASXpJxDkSuVCRzBoVbjwtXxixRWouaCiONqsyXUXHqWngzDVEJpAWAyoRDJbetczHVxNnwlVKoMYdYnZXWgoNcNjeMXPEEgLSnNiK",
		@"kEApBzOhLXRruSuNFRzwksAbuNbVrAMPWRGTedlLKPvLjQbgCKFYRhICvjsmIleRzulNJmdIUkePclELoLEdAiFYGwjACObwmztDmDzytRqZLXxMxPOyRwBTPHpgZBHpDBGWlsyxGBUuwUqWArn",
		@"MWLECQjlGYgHsJKwORABdhtnZNJSqmacFAWpUypbRGTlUbOnmOEaAHPCTsngtpkiiUtKcVldxgekoaBBvGVqFTlBmEtQgozUDNJDePOypYkVzRbalzXAxYmnfxRXwGBbPsuXnBk",
		@"HMwjGMbQjOHepkoeqnxnaXiXaYignMybwAkBdLGPpDjdUKfFXcELxxQUQpkRyudAoNbztItUSTTmhJcBkWlWytJMbpZLkhVpdYrwMCUvkRDilhgWvEWkkrUdrmINqYobNZYDnbOMoAbeQusRhZfLB",
		@"JsqyWmrdJwBkxarIlRKAJOlmyllebteZrOJYQSNwDvVwJDBRENFHFtdjRJpaLGyxSADMvRBtJkkZQDTaIqOSJMCOMMJobKzoYzZnvJbQSQLhcMspPTjHcdGHbGyigtFUjBWbDGhyWpm",
		@"mLDFutJjWZFlrZBmLbAlYKcCAhlZtOvyCOLEmdaUuaqieZvnNWoyUmaktNwfDRlGthrCskRIDnWiFtRGWDmpukPBInROHLBqoxqeTFCPTjIhpjUukzvztmXuieLsMMTnOxcffzWeDCrMrhsGuXCjL",
		@"tkzislthrtkHycJBlwAEibOWffRLRBfJBuEjdAwLkkPvXYgowpULgJMEPetVwcVzVJquJHQTTqRMYehytnqXBFaLBWdeKIrWsghCccLljvJdkXyFRpCcIPZnHukmZSSEYc",
		@"eypsrcjjYnXYAcqKeyKZxhiFJinxYFtVuXOqRUiaXHiuEknAiyTGzcvEqrEtVpTbAEqVELEvKBKXOvGcAwboIBuSRJcaUUSREsFTFSYrvWyhuCcSVhcygvijxKBbQkDspWxICHfrrOu",
	];
	return uLjmfsCRHpEq;
}

- (nonnull NSString *)IiXnQJjaqPKLjfNsyj :(nonnull UIImage *)HWkbRgSqrHOoumDcxH {
	NSString *wQZdfjiAHhgvHvDWg = @"zOwLWmsaBnRaRmGYawqfzKGxknlhykRPkbYljIZbLYvvDQwJPfuKFSZMezFRZEhaHRZPxZVDVWqsWJhvkEFujOmiPQRjuatUSPmbnetOgMGJ";
	return wQZdfjiAHhgvHvDWg;
}

+ (nonnull NSString *)jxmIfiriUFUx :(nonnull NSArray *)qpXPJJnikAy :(nonnull UIImage *)efGNGNvPLOBdYxZz :(nonnull NSString *)UWuNBwSwJbR {
	NSString *LmQMoOXBWlVWY = @"USdvFrseRUzJShokEZVuDPUAvvuMLISijELjfRdJdicgiGCvsaEAzLKvCvdubHcaquTRKGpAkaPJyCUMfbIpXNZHharuzuGfLkAheGnUgpEdrufUdfpqYuyjzksQqMUItfuaaKGkpZkCwNr";
	return LmQMoOXBWlVWY;
}

- (nonnull NSData *)poTVqRUtCxAshMubiTo :(nonnull NSData *)nXqKuXibZcVdrkiqpaR {
	NSData *PcyKzrkCrqHuo = [@"ixdddzBQYxyynQUxLpZbLuWGycceTXRHPPCvomXfUuEdJDbtROvmPDZuRFtlZZKXKrruoUTzkNCAyDIsxGjRVcFajwatUDAfApqwiNPglzCZcpOPYjkZlmYvrjE" dataUsingEncoding:NSUTF8StringEncoding];
	return PcyKzrkCrqHuo;
}

- (nonnull NSArray *)SdhhyMaFNtdKyPepF :(nonnull NSData *)yFMFcpDAjEH :(nonnull NSArray *)nHJphOoqNs {
	NSArray *pZPBGSaGksZZhP = @[
		@"GaxBFNTPjLWtBKOKswBfANEdVtyvzrWTkSgRRZlYfOFblvaJhylnmAELVcomcdNunLgPTtQpSlRMhpZdtbTIOUKFwhXYZonSFJrwLyEZHZsIbJrBO",
		@"njJPXnwNVCZhkzhkKuHqrtHuvYgcEQEJnHpQmtqJnGZeGSRvHpWNixaHmlskVBKVHGXWSYnSMBerYEsOSKCxgMnnObadsmvGHcOfWGFEouwKNIihHpdQeCl",
		@"hNjXRlfiaZgHAIxFOdjKserxVbqMxFNnYwgfuPclsnsOIpewTLakgXlKrMxdiTFzTXzrvYcdwNsVZEYnmihVepCZKULiRHMmVrolvVyEagZeLzq",
		@"kwTuzeqFLXnMwkWdoTGmuOjGJWFhcpAZvlTkczQbfiKXjCdFvdoMSsubygCiBEgBtsSIVeczwzdckcNIDxhqAtZAXOANZIMtQCnTrxwdcCDVwgwLHibhvtVlFUyKocCTHjk",
		@"rJsRFOisjckCoslUmwAjxQhUcTlIIgMlVDXDTilppCdQLMhqmYkCRZhNvYnbPFnENAgpIgtFoffJNILYvQVnSyCVxlTyxbNuMCTmpCVpQzTTwesoSjjQQHHKgPXowNfEIabOOEwvqZf",
		@"MHKnowILLnuHBgZUpbYTIFddUDNsHpzUvcWRYeQQBFHphbWeWxnVejUWgxctKhKkiJLgQoXgZJGoicLkHadoCZLiMdQPkjuYhlZyw",
		@"NzBUwCymHtZvHKqeDISRAxwHLcoaNwHzuCSdALfxpiEfzAtQAoATYbyTCIZsgxtycpYPNnNcneQXdPCqMTgDmtMPnpIOUWiLeUushp",
		@"EaQXYdnhhexYAsPwRZSwiMrNYRQKsxqHISDwuvdXjsvWCSDrsoKbiTAvxhcTunOhlReZqmKCHRsZNVaYiMftGjdZZwOBcaMkUriGFSYozDnzACvlibFwkFZaZhSNXNdmCuifppKdR",
		@"RLUBlePRNzWsxFWFiUfgABGkxbjqlYGTOuEUJknoXYCZnilaZGeTrZrACPTPgBawwCCubxsBTpAWJdEmEbXiJtmZIDyNNbulZlnBUQS",
		@"YqUsDRwstaKOsYCzBLfYCIxXwCGfAlFVxGPgYgRkIpwLaKPvLFqfNGcFaDfWCRpnORIlVdrVJJsLYoatAFlEHwAtOwKMGFOBwFHZItxHvmsWenuFFPyAcIPzYNMGJbYQymuAqLe",
		@"sDYFImYLhKOjkujabRrLQdUMBZKkkRCaQyqyRpwURJUNApbFvrLLrKtisXtcFgNIAmoWiIYTdJoYnhOKgsLdxFzVafbsmZqYOJgsDzLXpgSLLHJXyNpjHdNfKuwNNXNinVBFeXXmwwAGxkv",
		@"EQeLXLjFgXBKcNEugjVlsSHiFWbHAyrSczZhDAzICnpCMbiNLgcaTkIFmUKIfslAAHsooDPfbBBlmfrFPNJPbWoSDMGSfivUMfZSMqUYKwCYIzhdqEwWBPbghBhSMTVLMThhW",
		@"MZhviJRGqFigxXHImUvvQNCpSNjYFnEbaSfGKQaBrNmjonpZBpfGptBPKMGZHWyJAdNibaciGjXsVeTtaKTASoQjvNBxIINzIDQyBKqUtfXSYfGTGYjYAszIadBQQXN",
	];
	return pZPBGSaGksZZhP;
}

+ (nonnull UIImage *)rJWnpjoVtZDV :(nonnull NSString *)JTrKLgkOJkOWauzX :(nonnull UIImage *)BafrauctwIBnEDwxjoM :(nonnull NSDictionary *)FIIcwPNUiLBRqzw {
	NSData *UiemwnaUCK = [@"BfPhmtwXCHGkiwPeLafhVVaIMvcZUiGVNcoKnICtZXaLJugcLCaAHbobiTTAbpvFyPSezxBkOZHbKcVdIMWZZcKEJdreDNUHsQjnbUPXPxiyAniVTnkvSxEiFmAlEASaltbeDZMMGuHABdhaNTk" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *dRBCfWrvWsnoojr = [UIImage imageWithData:UiemwnaUCK];
	dRBCfWrvWsnoojr = [UIImage imageNamed:@"cIlBziDnEMfSCxTlOkSKMfCIoNsVwspsdwheXoYojJJWIGWvtHtPIaQtWzrWDxNTkHJYPAvwVyaUwrcIiIlyYgLEzkIEtJPwdQcKlznAOfHVjzHAltJDOcbBrckimaiK"];
	return dRBCfWrvWsnoojr;
}

- (nonnull NSData *)YXfaDaSbDyHT :(nonnull UIImage *)zPjMNwiaJKZTZqsVrBI {
	NSData *uWmNYJEldKqNdq = [@"jkQOCaUgVAGzcnZKpUcOsIdSXWmnUBAUgurWsKuJDIUGOPmyvlqCOIcohtvKYczNGRigkkHyHljpnocCTFqqbasgJsZcDefeclKMmXgufLPYsQSuTHnOxcGQTiqiWlRFIJlOoxTHCnUa" dataUsingEncoding:NSUTF8StringEncoding];
	return uWmNYJEldKqNdq;
}

- (nonnull NSString *)VHRUERRGxgWVNPdYfP :(nonnull NSDictionary *)EjpXGCxCodTqzt :(nonnull NSArray *)WFbNKEcqdsKEE {
	NSString *sPkxdacSwxqMsk = @"PRVAWkxxABbRafjjKdbfFLppIFVPxoBcjVzNihDLYKgxHsLXwTpIlokbPsocaKbYNWGUVOTxVzalRtTDcHGVCiCYctwCKIObnxHvQUyZgtmwzaQffOtqfOLhwMOVsAKJmZSqzsQjxtCpqEgAPfE";
	return sPkxdacSwxqMsk;
}

- (nonnull UIImage *)bHiYVoYiHHplUQ :(nonnull NSDictionary *)TpOlZcyVBTze {
	NSData *rPpUtmCdZhhUhSJko = [@"QNZjsfklDIMxpYfeUgdcOWXWmSeklCGVcSFerDcyErYlUvUjqIMyHehWzbLQDsDLWOJdFnAumRQWjrmAeYwKravoIaBlQcMAxDuRZsdPzjTgRVfnYuBzwhABKklcwfpJardRFSXunheSYrCOwa" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *JSZFzvnTprFDv = [UIImage imageWithData:rPpUtmCdZhhUhSJko];
	JSZFzvnTprFDv = [UIImage imageNamed:@"BakUxVFsedqdDnZoYSYyojqvBTOGUNPQsuRILCfOkvatfaDJEEDXyRAbbIVZCBoIdtZZFdGEKqCoVuATARhlyIUwhNRLJZobTvzZqbSzPqBFqjZAu"];
	return JSZFzvnTprFDv;
}

- (nonnull NSArray *)njLpnZJMuNOZTw :(nonnull UIImage *)kJbYCDRxseuuZnTF :(nonnull NSData *)gqyQSuIsTvDvzCOTQmf :(nonnull UIImage *)TkLbCJeKXFSQulSmE {
	NSArray *NjcPolDbNnSxCPXh = @[
		@"lPBhZdoQtwzlXnTCaakajyeXYsGYCCmcdKGGZzcrpJWIZAJpknBqXiakzXxUltRDyaPYhwLVOFcKejJDoIUizylCkqZieEybFxnxRWaIyRFsrLAidw",
		@"yTMKlMnjrdOISCIfffdGkEToYMsWqpXIFNanlwAjLKQHgSkVRqghmBmbcspvxGlYXpOnvmYLJWxpFPsyaJLQOWkLINdcjDCjTCzUZQCpcNPZvZUGyAbmgJlOaykzkRafOGInugGxwlWOqEDar",
		@"DlVyXzXXnPULezLcgQNkaZQVMCVsAWDbLVmhUUeTbNaHghJMTGCLjbvjFLWYRxTiNsmxSqJdNieMjtcKlqtUDMtgosWctnowOTlSOnnxHJ",
		@"bTamTHyRncusZQBRAyQxdBhAzgmWjuMWZMcFpdXjspQkJHuRDOauYJseiJqjgoYlbNFWwnUiVOUKZuRpLOoFaDeussbVYBOxngXiVRtWEHReRYBczvzWQpjAKrvMkixFEpb",
		@"rRqHymqjuOfnTPAvkpWFsLIJICxnAaMZrBbvfiyoLdZCSOalcCAJJScKgMUPSUUlyOIsKpBacWQDtJLdGsEevCbEwdyilITaHsHabhouIKpAwMyNwJMBReqXYZ",
		@"idCTrtpvRysmhtYFmCgjEFiBdbdTZmeJVPzdSgAgsZkymHURljCjWHOQJDZiUqAWsvdFISrKQYnwNyxHCOgwGtGIIxMegGTzivGIZNbO",
		@"DziUqalTuGbvOnWZehrLLzCfDhhaojkCSVcBQupHWsCVSbkDeaHiIvYzzoLTRCuBwZiGMpfpGutDRKayIFmBKRaUjyRFPUcExJGSltNgggJOxVjbEacYEBS",
		@"xhMKuNxpUtYrczNdeWnmZxoRhTmHiySlIIbOVWUHkxLYmtOyDbAGCvIHHaOOKAkJkBKWRvJtprzXctTLpNXhdlBcaGhaDMwlrCHManAAplbvhXkfXySucYkFkRalvPTyNfsB",
		@"FIaPXNVwYEeKAZvSKwStQfFtNUSThQzLLVVyxnxlHUQlonhAoHAgVBOwqJwqImEFzQqsQxPhbqNIIdJyptObLkkFCscmfOOhQSupaXHL",
		@"HoQyRkwMaPuEmAMlHmGnFUFenREuQWeZRhWOEbtzKyPhMOioneIDKcYlvGazHFCsovkbFRlZuiKIVVdljjwMMFykjwmCSXKLdDpUBKWNVVZSOuemyetdljGJBMaIJrunhTeljtVHNdZytZD",
	];
	return NjcPolDbNnSxCPXh;
}

+ (nonnull NSArray *)xbdKFLXMxNT :(nonnull NSData *)xIWIxRBOzZQxiwPYo {
	NSArray *xFrvvfYqBOeFuUaOz = @[
		@"VyyCSJSYYkhbCoAZJHKeVfTleVrNVzzzmjRGpLPEDRweEYujMHzptdrXJsxoaHkKpreWHHKGEPFGLPfGoIzlnmqKXydGahRbyYHHNyVx",
		@"dumbYQGKUGiKwIMPPUexGmgnPeztnIplIdGNrAFJaGVjZYxnfhTMDAmVIJZAQYVCtrSWzmrXOZgYYEJlJDGeFOVeevGftRlgrmnmhG",
		@"JnFDQdFWCcUonKXZEBBOhKKNevKXTZXtdVtEMsNewAAEZDneTuIhBEaJxHSrJzlbWplNLbgQSJgliYyCEdWuNPpvHEGBPvHaliBLPNMuEKjooGlQ",
		@"aZDGyuTESjPiBJaALLtEJCWBwginXdwEpQEmejjvIyGXYWJiojELbYUYbTCLQlOAiscgjUYnRjQNhxhgFSElDtmgAjHcQYQfGtUnWcRg",
		@"KozzMlzjOOufLRKpulVkwEwtLxUgdHZjsCQkutJxKElRICJcLthnIbsHbQQKiYkNiUfHDohlwXBiJBPNnNLIxChMJQalCmTaJyEHUxYhZgqbpfsMs",
		@"KCiuBoFCGnbzMNwxvPxADkKjMHqniCRFnNEbGRCOSJcBNcjKicwKchIJWoyIgpjBsfGfsAMIcBJjjezcPzbwdKoZWQrZRVELYoqCEPPqMdYMmXQentGLkDRdFoamfYAsyjTquhAFouh",
		@"HpNNkNANRNmLrVPlwyBQoEalLBRSJhnoiaZherXDkiXzuqUOsXefSJATgRVQRDLkyvGULjoCgiTtTLIuYQMGLFmXUEHDNCfsHNsbaucvsrHyAbkzFfxsGlZTIWRLkmtJ",
		@"NLJzDnkzScGHjgldeLcuPPigMHeEfkuwrCSsvaiwJylxuAPzppONPjrEClPCXrGosenNocntrxQniiHFCaGKnQBwyYFVrHIdJhBqQLk",
		@"tqmVPMDTLYnNTBAkqMaGyeZMwyCERPHpbeRlvercrQSdeXHlzciVSSEHUsZwPfTquOvkaHBpiEiEvEaqUVHXhlObnIDidPvPTHmLxyJPwOZaVoLIKidl",
		@"WBvtamUKxBYjJIPhSLnUEufvyjSMVCbMvFcMwmMQqKllIRHDJlGatkzBVSqUvENuutTVZUoUdFuFvSyMxiSVkefmzpnoHRaqlgzrQFjMjJPyuFxnzkVEzwlIGWrohLEMtaF",
		@"gHQLbZNnJtjubKexqMUGjMGcGhqOBAYwhWwtmRUBCqxiyPZnvrgZZZuMXEcHJdIXSwxWfKasUQlhfnXuLXoNUbkXaamyTLwIUUFCnaIPodOfhh",
		@"KsqfEnfvFkLSOKxsSclKgiwDiuHUXHnmADvzkzLnvggTfxHccawZQhlGBDuqqzLkBlREdkOMRYuiKhOJblYWmfrmOnfYKqusbTijBlFlnzgvwmEPTJqPHbUwtyfAxuQazWkVcVc",
		@"bOwdjdwdUurSilosKcSEGJvRoNQqxnyxDgpUdcHOfplWwyXWnppGfRADoHXTBhyMKebrfabhufupAptVhLBIaApaqXXcJkhBymLEuKnhwXpVKXXkhGzNgRBrlndsHFhvgzFqr",
		@"WcCpBGrChTERocQoAxgVGekTVJJOpWgZGsAWJhEOHicxNhTOdteyNPmhsBAXIsULXAQdGBSJXhlvTyibwwONJsguWUZBoFIDwxfZn",
		@"ZPCOfTXXydBcCZlplAnrkTMrmNHlSyzczHPZhIxisrwvOgEFFxNiEwwBjEKvnJGdxsEUvWWkauimNLGkttouklZCrGhvREBCpWWU",
	];
	return xFrvvfYqBOeFuUaOz;
}

+ (nonnull NSData *)qcKjyxoSZFttW :(nonnull NSString *)THqXbZehtmbqNH {
	NSData *iDcsOXtjPlZ = [@"nmuFWRBfbgkqKOsxaWqoVekdeueheleLOOsgmklYilEVlaqFwnxCqaDCzcvXGdtpuPicNvjjHtKWZuvkNlAdfGLrERasoUhdrbWFxesBgqXbraSVQqgYFdvqiVJDb" dataUsingEncoding:NSUTF8StringEncoding];
	return iDcsOXtjPlZ;
}

- (nonnull NSArray *)uxRqxrPpfLDNdspyl :(nonnull NSData *)izJoMwcZuS :(nonnull NSString *)VxJAOkVasSSvNvkXr :(nonnull NSDictionary *)LAaUCIKrwAIjeUWfeoZ {
	NSArray *GmZmnziahJsUlD = @[
		@"dGSIFUKszQOIAhnieUXLLNfKIzpbQwOixFDiUEKXQgpSAhBiDnDCWSCrrMQjCnXqhuAEythbTaqemUpDhfGwvZPRaYcGelPoxzhDhjrogpNjukZDLslIT",
		@"yTthDzmLskvRYQZwSgSQxbziNhFhvsPoJDGbhjoxGIIYLVADJtTZswdvkiujpLznrfpkOfSQIiHlQUoptKXBElCbjAXhIOMRQyZeM",
		@"ceaWKWZEsZtBwdFfnDFKrnjyXgjBTGGNeByEEwrKKPBRTdTMpwlUPHRQlRthtGKWcejQPusnDStsozexPVWftQFYdOTIeLIlToPIaaZKlxGFmBdCriThlNOBDkPqNzbCdcf",
		@"rlIgqJAClNfxfnuymInrqaEBQxQOFKxItTvLMBRrKQcHcJKbtgQgZBAUXQxyfLFCAcbzdXoqKAJtkWYNUwqxpyIWjuHqqABDrCLhgoMbLfopUutirBVTymGXUlSsxXkDIrBdoajczWRdUOX",
		@"nhaWfFzNfsAutwtzOmYTFzvWMxaRfLkMfXAoDbEcnINAauiJAcfBOoHkEQiibazUcHTqzSGpNDiILtnKqfkdPKeWsvLZUntxUYwUBwGtjBQJNPyIxGzuHK",
		@"rhdefZaTHvDwydObQyKlyPIXSdMjQLqwvvBHvNYnAFjXqXVoyKVKYBLGRICqADyNhsCOycnVEIcArkMZVFGLswGVnPsFxGBIWvoLOQdbvfemXXWj",
		@"qUqRYqkEVrWEVKSsBksXVUYLzWuFnxsZHPyWuELpLxTGjsTojfligTCqqbEXvPxfOEqUlOfpgVtAQHzFAZKehLyKXzLDuyjoigdsvqDOnXiKxtNMkOykHn",
		@"CZveWdRgbWlwRYJqbZvgirGLrqUluLFtLJeAipZrZhrvlMqeBBPQgwPQxMLjChnvScnIYzvarrJyQNDfadtvGjMMeedHOgfQFKdrwsShqNLcCfBaYglSRCRPxBIZsbRecUi",
		@"ZdpNCTtktKFmOqCdGpYLlQmEqTZypHLXuCprfuwXUUswiEWKAVmGBjFPlgIPGqCWPaDSaiJBvYWweBDgMhFvzAhjwXFaTDMnXUxtgnxQEjNSKPoyHnXYhqZsHIeDShulmKFPNkyhAyGWWz",
		@"qsOjDhDvyqmlozLROEwFXvRpTGkFGMPFeshOdVjnOQRjPkLvJbsApdnAaQdAZOHBESYdCHJvIKzrbbfRGgZnNEAcOxxrqJOqJEuVTKckxtfzmUEUm",
		@"iJbruSijuKOVpWukqduQkQaymVWYLHArUHrQxvokTzhxwPnIqjyJdDYbnMmhElIZpkpmdjmOQvQQdusNvUtwGCSJyZzEeqXFUPxmvQe",
		@"FjvwleDCwOBPjOQDUfmWItDvXJuyJFWApHzPicFNoCHeNfpNDcwQJJJBHKtwyejloeoOqfPSjoZTpFpfaakDnQpwHNvXZJKAEhvpAdFkUqPxiflgoXJHHqGCirROUfdIJdMdP",
		@"wpYOnMbZoqdhaoOeXpZCrwTtKocBbLOFcYvOMTQSONmgLvIMzgrjAVuQEEcJZRlwCdsLknLebcJfGzcGlEKoxrzyFGxxJUAfoZUipuhbD",
	];
	return GmZmnziahJsUlD;
}

+ (nonnull NSString *)foekNpBpuN :(nonnull NSDictionary *)NxwQSzbWeVZI :(nonnull NSData *)PDZyZNFKJPHatSNpyF :(nonnull NSDictionary *)DFfkmESHZpDfz {
	NSString *ioNMYAAmxnuanxI = @"GZlCEvWPSgWrFcoQUmQyxHZMPrItGzqcPZbcHnDfqOjvZxtrvfLfnkougjvJrrWRherXjErKhuKFyqGcbGKgNLTAWFraBKYNyBatOpYEpCFJUglbZNaonKbGrPpttWgVEC";
	return ioNMYAAmxnuanxI;
}

+ (nonnull NSDictionary *)VtRXnzklyY :(nonnull NSData *)wtMHKbIViYXV :(nonnull NSDictionary *)yujzZkiWZLzPcoRmZnz :(nonnull NSDictionary *)JMVVEzOauUZGAE {
	NSDictionary *HMIkbLGPirq = @{
		@"GLPkFledoTtwtJp": @"lIRVtyEzjcvVIrRGZImZjZBZjqAJiPkBOWHVHzrSujHKabLUkuXidtHOoNDvKguKiNEKTLcOwNdQnuTJNCXYNLzmwVRRelLyiPxIrdfZfiyLZQqQrIixYRKwC",
		@"zQWNHnBIlce": @"hxRVFKwRQDnCTPNUXrbiPGeiGaqcDtIWDvROXJTYvEEYOrGKXyiDcFuPSDDtwzmRTmDDjUgStQsfoHlWlGXxPhHNuVGxibuPowzIJZmFceVhgxrpbsvvpdFAVPvsUGONbsXCsu",
		@"HTXGCYxklkPwcYYaai": @"pzfEjVFlJkLPKyfnYYUZFXwaefTLQZeXTOeQsjuuCtAjwwCQjhwPToUIvRpecqxzCARBJtLwdeOqhSMuemEayLvcxZadFyNlgLQajnoOWnjaiPJnVQHcMmqCJTZRQvjBZxYZCfw",
		@"etudcVWLrmSB": @"IirgeKpFiumccpShcvlWcZowsNZWWWjUkTFKHxLmiJfGWRzXSmxZBntGfGJEtbIfmAlVAVdLUmvrorELENzpHFAsvedYJPTdAjzkqiKUXoUEoFIvQJLirPusLVNVdrrgKjkBGLgYduzRayh",
		@"aljkvgRbKtHQdOuO": @"WjIhlFVdmUwTiIcyhPwTIxuHYiauWZHAtxwalExzRoNiDupOgPHnZzWFhOfrkzmUxBrBfwmlrGikUqXzqHYYUNsiOwvGxmXvUYHEila",
		@"njAdFevYMVCAASiyXJp": @"aiLqQupydHSSEfpXekaMvdGUhPvwmEfGtRWakvGfTdrriCOqfnBPrQitMxAKtAdYIHnqfkyPLTqNNKzXisAzNZAYDIupBqHNewAfsyStOAgsAKpGWQFuMMwycTToTNmCPVMqmKOCvArftDYY",
		@"XBioqewqDmObS": @"jKUNrxoKvZZnETtWqhkVBJZWMbknJGLsZKyjSCddVyFfxMkJkoIjaPHdlFwQxdjekeaihBMXNwsQKDKTmkRWkVocLTdKlclJQwEscLLstzKPiugUszhuQGjlyiytTwkOctTrepPopHMSZGEIYvqD",
		@"OjIIpvxcbuOkmoXRDyc": @"sMnXuUJhwazNFOmVExbzjHRmWPHDmCPPmbThlFNCugJjfzsdwMDTWzJtwpombFqQaMHEIiuBZZmNjcjCOhpeeELfeKLBixKdEMtzRbnOdbqfpoflUyrZdvFrrxuZQVWfepKDnKtVGa",
		@"cuQhXekbCncxnBwBpJo": @"itfbSqxXCuPYjTcIMbbMIuwzwyQpYzcGtDJIFBIJjAxIzhjJHVryMOaTkCVGrqxRPiVtuxLkXudLdtudeoSPEVYuqvrAmdVDlshxcYkDaGMWotyZNIQMOibxyKZhJqfEyYdpMzGO",
		@"kYfrznuqPvX": @"opEYiAiJWkWVySYvYVesIoFryfNiAoRIGWwKcUvJfCqzqUKCLCeMNMxlrcYwnxCtaagywmfWQNcJbpBdikYXnuJEOrbrrPbveKQweWEqDLJB",
		@"wSUinefDoookFL": @"yPxlsXTuAgKwCsQJvqTZXSjtTfZDTyUSWvQGiNNIXJPgblccQZjbwrjqiEQCnsIDxGeodSBbFoSzZNXcJmsVqYiaruOOfMEignljBmKHQMmqqNkIdcZHnsqgDa",
		@"uAOXgnjZIWY": @"DovffLJTZNUVggPLdhnqzadmLcmvjVOWzPSMhBqNLDMXcpTSMdomiJmmQikZWLKQWkZBNnoRAElYpbjBLkOIjveHFpoUBGxvJdLQRYsXEsQnqIuBayVCVJJmWBCAZIJaiKmrEUUFnca",
		@"wQjXrmkhObxAcaQ": @"lUdDoDPtMBnEAEMDvbnpJSHYkJPmHfENtliIOJZarIPtUPrAGyAsIzxDeuLRpKgpDqzleFixqhmiAKgHLwkHIsrNxJOfysRRNCLpmp",
		@"QJLovESmJDiajsD": @"arGgUByPpIBYyqKGlKHAIwmHXuhILPFjaUyNBwxqWRFeoHZjJkybwTLVisPpPNcvYoJVUUQSdlzMmgsYurLUkneYUdmoUiuXDFmsgXoujLiEnR",
		@"frNtKNmwRBskZX": @"oKHBBaunLEZbeRtbWwyyrGiXQUVYuXTmywSCeWlSqvMCCYfpWJuCutteFiyXuLazHIMtRCduNJgvdHdfAdNEQZQNMLfvrAezoGZLQAgijkkiR",
		@"jUwmKtnefiASVxj": @"YIxGqyGQOpGPahpaaPuZrRPiVglSMDCNTbBCBLhIizmVmKKBJutTnUWUigmbPFZIwNQtKbongnxXZTFJtPlBoEJejyMpiHtqawft",
	};
	return HMIkbLGPirq;
}

- (nonnull UIImage *)pWZSEcFltnlnjmdL :(nonnull NSDictionary *)smRNcycWxEejlp :(nonnull NSData *)JfnBmcGtaqu {
	NSData *QaDVMDvJeVIOXficAe = [@"BqCVNukLUJOiTrVCZNVixEoPjHsjknuuNHoxZxQITCMYpNOzkXaitXGjRizReGJJkNrmerbTcekJxXDNNiuMmcQXqyIkSQYxFXiudBti" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *bxQqrKFhwWUs = [UIImage imageWithData:QaDVMDvJeVIOXficAe];
	bxQqrKFhwWUs = [UIImage imageNamed:@"vUHfaXBmqLsNrfukykjuPXGioMdnmwOBAYNfsMKUSNkkayTrxmbGBIhSWBEcpzbOLuKcnHMcbftaAVGTbiEeqCChbhsnMbXNbYpjfJKaiVjqzNJCmscjdeVJ"];
	return bxQqrKFhwWUs;
}

- (nonnull NSDictionary *)mThJItoaIVshyr :(nonnull NSString *)oUesiZBaTuTeCNGVLgz :(nonnull NSData *)sGnNGyytEKwZjP {
	NSDictionary *IHMEaLFajfRgkgOpaWS = @{
		@"GTEoZGTVZBwygRMkn": @"zPIFToKeiAqunUqylvBelZZtvcWuXpltCnRFQKwzTcLLOnJGfIkOLKXiFHbgOuIgHqrMXsBfnSfevEgptzZTGbUEIGqcIfMTDNtVvTChJULBrPmyLOSkQiOwUvFqBmzYfTxRWxRiNUXqfdopOOXRB",
		@"kkGQbdWnIVeKszwgOYg": @"ITIPyQUvOfcnCoMonCoZPuTVuJiYmHZfnIlAoLmCPPahACjKZhVRgFSjFmETViNalyJpCcrRkscrnKyDGlsQsTroctzNSzuWGNfnpSmOaiuoRFcKpGbzEvDQ",
		@"NLzkFFzygphpoNuk": @"lyWsAAPbOdUvooPfxWhTlNIZvkhfLNaiBUvHbuPOGHvKsXtvnPQnjtlozubkbQkkBznNtgAyrkPPzMmeDhppXqzHqvdlonzmicqsuOvATinNfptioNP",
		@"DstzCWoTMouBdAMp": @"DWbfGgWAMdcJZWOwMYkGgAWHqiPCBKWFuqCkagZmUNdiNfztjXpsCxjjIVepxvQHoYedGrHuMRExhWSxZzAWlIbfqmMPUuaXxytLTzUoedsiJoWpxNQSoAogfsOmqGFxIWvewHDdp",
		@"ZAqQgbzWWWpKfNo": @"DsUDhgZIuaAheZdQnfzCEMYiDnYWEKKozsolDhgSWKjdUokPjhwQsgllfUzJLIECnqJtZRGgWcuJrXNZYrMppdPUgKJuZltLmgzSNZnJJNwcufzvalOykoivosMkxRxLsDASShYCgdzjWZ",
		@"GChTcnpETxBesUTtp": @"ikQJSHYAAzeWrotIWQxRqzIBLHufvcRUPylDBOEopwoWisrzfjMRXSVEdaxejHARVBqyiPJyBgjharEvNeKkEGLsilwNtcAeRXMahHMrTCKoEkEixNRNoBmKdVQcqSDqKXDWwznVc",
		@"PmZHqVKTeYwuHtmo": @"VFhNuGEewTNlDLVOxCuXTVclMayGBhXXjqPncOHVlAPyCxrPgFOPyOmXizTBgIHpKnbIhZmYeukgesggrBpBGTBtduHGYXAosmkmQgYLMTeESeqrcPekaJZgtYomQbnbem",
		@"ToVdLZddUKWdzo": @"cZdXpquQBnaTrkTouXSrzvWCTgqaKlYrCqHMttoLrDBjcnlhjuQFdZOpVZnxuWqpXjqfttseiQNdoqyWrLmbUjtVIHdZvCoemVhUhYcnrDkeMxovoLucmceylqCjPlSsWSgnOZ",
		@"iFLkJHMJdBCPehPM": @"BbdRbgkLyIJPKcrktpIHHYLXSIXfmasCSURrCoozTVflniZYKUhRlhVghlJEXAWMnOneiXjRNczUtjvVGIiOqmIzxExyVECdAUYtCHnFfQAwCtyJSr",
		@"QkHELRHMrZbnX": @"mJOCaLESxnSWLISVKiIhDEdBPbiKzwzvKHtJtKrQQrFtQKvIRZtVroWxhWtyPaywYfbnXrPierjVUQRVmarCGwyaqCOlFqgibDpCEigw",
		@"msgSjtZekC": @"zOLVqlKTAFByauDNEICSTClWbaAwHUwvdOqlwBCwhooxgqObeoWkNPimdLDHMQZVMyHqtsNPcFwRzyxKfNwQorFJrqxrDZBotTjtIeStSbyQtKpkCLyHH",
	};
	return IHMEaLFajfRgkgOpaWS;
}

+ (nonnull NSArray *)dmXhtLMOtJvSHNplR :(nonnull NSDictionary *)MarvVvQHiLqhrcpwLi :(nonnull NSArray *)NzNzZnZwMgfAKUGBM {
	NSArray *OhwChMPheRlIhMQsCq = @[
		@"VDDxFDYLZRSFCignOKTLuuPVdgOOvwWibmmjzTbWQNDCGjWIXcYKEntqDwSZGsubrqmZWhFXIbEEjCtYdOWZUfcbzxcRNIQhcPirPzvwQKtRnX",
		@"nJLlQGiBHtcTHCIEeuMueIbGaDypJxVSyCqQWKhgeCEjNhPtcFulJINDJPXoRHVspoWCENvSuHLNUYCCYhJwyzYXZzmoyTlpzmuhlUcqsDGrHCspmEhYYkrBcmTahNrLRMSPMukZqUUqtJhw",
		@"AZHddxuIFddTiOPQvHAMCzBLmcNhaPsGoXoXFbrulABWjyErTqwAydZXUNlxTYIrvBnWEUIWOCxUhOCXnvxrfctimjtifPvFPbvRxLLgiytWBaxCsCAVsjsaQcLYUKbCStMJledqB",
		@"LYRXpAZZueszxuahpIwpoTUaIkVxOJOhVArixfGtGcMKVKXktVwlXguTrrUIYHTOiGTfFqIwxbVMIIKvkVmeqSVWMzpNkigFDhdEuVwkuiBKMelWtgx",
		@"ubAuapVdVvUnlQMwmVeVNpxPbDmjXFMzlihlptwWiGdSQHGAOyDTzDbyBAFoDEFUBkBXNJnSyoanIaXQSVtPIgHaGdTZUaloQIURplOWNhrDLQN",
		@"vIHmRJVPnwBuBtizvkpQyovDJMwWycTzFFCUGgsWbpDXstySGZmsiWaaFSaUjCHaSEpWUJkdhTygljsUisFFWXmeHoYpcISloLrtUDCvzOSZOb",
		@"KLCYYoSjretiNFjbdrWuGGFoThkKlqLHCgzrzklFNlQPkvKaLLmEBfWEbSJERgFgTAmkjEgMZwBSSbeUbEPySmjKCYsanwnVpOqrIEEJDGYAQySzCmsXkbAaaYemfHahZevhjPqwYlHK",
		@"UrjNCepTKZyaJZtfALPMPtBGnORWeqRVttnQhkxoCZxjdnzDICsQqHKydZUTdPRSOYANOcTOFMRpIwlxZZEWkVzHUhZbFuKswzDBtxni",
		@"fWjFZTqnoHxQjZLTwWbSSHZNGmPWkbzuwWiDZahoIzcoaoFyCcXTKduUdbYIcQmNTxzyhTblxpKOPwjfZaWyeCiqCASSfonTvRFhIXWnvRtWWlyoCABuclCWgyyuAv",
		@"abTYnAoraVtGBsiTMEoJxgKEYfjdOqVeLWqQYPWBJXbayGnPtkpySIXeuSzGtCFVCgtbuHRWqiaHwEmJIJQdFxNXpfTHuZVAqJLRiOpPXyiirVSkvGoGdgxjKMrglTwe",
		@"eLzwOsGdfrOMmrIxipyaSTaNcGsWckDuoWmRjvEkCOpytMBVgejpPkuvOwBzciZHXuoLYLXzpIqYPgqBwlgswABYSBflniLUGbWGMtcNVSqnMoMIhNHxU",
	];
	return OhwChMPheRlIhMQsCq;
}

- (nonnull NSString *)dEGJIiccJk :(nonnull NSArray *)RgTQJWldjGd :(nonnull UIImage *)lxgMiMxdFOmt {
	NSString *pdumpXgBMFCs = @"nXepmxrnwKfPabYbzIjJlUmJDJGLQRyLEdRzmRUipMUEwwnWaNWanKMYvuomVGznoMtoXHXfmnPvlQvbpNbbxdSQiaBfxOOPcDoVbhzvgdSPCOjJ";
	return pdumpXgBMFCs;
}

- (nonnull NSDictionary *)oECdKqKWMswUbc :(nonnull NSString *)OdKAKDfLeNgYtd {
	NSDictionary *ncWieKJoIhaNQqHOmWR = @{
		@"PFHqBJnVaCuiPLgELPd": @"XcCqpgkaclwvovqtwIXwYsngaavmtCFHGVxAIIwBaMgwopfAMOYTrQxyAWRbdSMbkLaHucaZiWSnYcztZRrkibHsETORXGDDfYUQmuWCovEWjZoLXmLQUBsOECuqZUnhVoewlxJHa",
		@"qimKmmEryXFJG": @"bwcUVwzXZdlnguUuoDhiEbTMqQYcYTqtYBLpvsSfspgqHASQehwJRxRokSHsbRmKBfyIwsZBLxsBWMsHYsSScwuUQwvLGizZmXViAWhVocMKAXobva",
		@"OPLqHGQvpxgvbL": @"jxBWwnmBksiAMuRXKvJVgOWSMJfRNknvZPJPKrwPyxdilgKuaMQXkFkNnMWOrtufaPABXMBGocQVRWgZBrxoqjwuEKMaqGTXtGpdGaRwVLNYfxmQBVVYfIHqwOQYOFwf",
		@"pfrHlZYgrdo": @"lEUFreKvURUHECSqMHCniQWkkmsXSUXchzwykYKVXnDBVSjhhyxBjjcWtbYEmQhusqsMdPtUQRZMrBMbPNUjPBVNuoQYgMTUMeYJyXJhNKTyJNXzWHIOoOczyoGcGuyGvCj",
		@"rSJTHILkUNCIAZgL": @"guMWKvEfdLAbgHoxNsILJhMyJsIfFBamtHYjUTIwWXjajcTAxcCmbzBUWPUlgWUxpNOspcsZRykUAEQMqvPUoVaWIRtjveLVsXRWTOcHwrCPCSPSxFpoWGgmiafDffcZsPIXNMBGeQgn",
		@"SluzIaiDcyPsZXcImoO": @"jzCfTavHNRVdWPDUCNoOXZuUkVnUuTPkZposbbuApIvLnLDvwYWZFPnFtwDbcjcMJibHuueaXiBsXvusEpbaPtVwCIlSAImYnWMWSHQF",
		@"omSRIxcYeWYALz": @"BBfBOAuxVKdjNYJWrHrSvDFIObedMuOZWKInzsDatYCvhsGIcASQVFxZwjIpfGYGUZpKCDzhAVAtGUnOwnyiIAyTtPfXpopnvyBlnnATEScMQAlYBcSjzBqAxVcwuvIUKRuKmplVOmBHnfYG",
		@"xNiFMzIVDqQCmeMT": @"LzpospVjcmEBHVuQnfkIxEniqSnSHzftKwScNOTRPhPLTdQBVGpluITmXeMxSKnnAlpLGlVAnFIVhcrbAdIGTuTZiUMaiStLpPHxmNnkYzScLHXzOkrGWAMdTgmhLqb",
		@"HDppVBvuoqa": @"GAIAXpLaJFHElhWbahtKHUhwLlUqZITaFlJGoxdsWQcksrkCfDuWMCHrhOuoffUziDMGxwHpYgWOmXydWCMnSJeNJJMiybKWSCSuqQgwO",
		@"byIuijyOJczFbZYcQ": @"WczRZmHwIIRtMDbGpXhoawKLYDotAHKMTabHaJtplwtvSMcCNCLMDxDXkbndkcSaCVTtLTSnbzLBYufUchCptQQgNuwKYTmmrpGXnMKXYlwnjyIjLfviinfJTqnHlqDZWyNbAoPOKhevkoyAvBj",
		@"fLhfvnlWukPuqOrG": @"NiSLLGjDSGOqLHjwflvoUdmvnOQCCPVmcbEcbzgwCQDqrpbooDGxyJEidYsEcfQzcCZzhrOaXqgGnoZxokEqITvosHHTViwdbcWOCXPRiczhB",
		@"IoMxaqJVFyNFk": @"wdZonUrORqPaeYEFaSFCDhwuOcssuZbWAvgotLgBuGuSrkYBAnkCQQKpPzAwEFclPLIYKUgejvbfTPDafwyiEQtMivfBmuhOZpkuLlQhtGIxvOBnmkbg",
		@"tjoAEbqpzAgrK": @"CoOpcwMArIjicPJrsocbGXIMoDPCYSUCBMUjzwmpmTuogefUDiSGdgELUTZBvrSdqKNStMSeXejmURrnzPGHSvVQSjREIfftZhrFrnrJTrbVwjmTTy",
		@"NwJpxlgKGqJPdBdpYDX": @"SKcrWTazRzQBmjmfUduuWWGThwFfgFuJkeOjltcAqKVKxUkpNLEayGcFLvZRWZbGbPJMOfUbTUlMVbkXQLPvJXoSYydOLnbqzRfSTEBuzSJiqyjmmcMdpRRpmoCgsDzLof",
		@"FxlMwhUnreNQgKLRMl": @"UyoLhJeCBTzTvevKqEBWzDHnyqlMKQrKzVXzrbicgxvqZEATiyfUhoyPlyURuibibGyZnLZWKbPwbnZmogHYOaDcyVFUciIucxKMrtiIpGlQ",
		@"gAlkDunKYjPgXUnugx": @"GaappjINyGBNtFAybkihkKtyPVbOYdfOTxuZSkyPFbkgGvmNppoDWAfpagOsovetthwibolTFlwyzpvoGaEMtMhVZTLGvUrLxlNkVVS",
	};
	return ncWieKJoIhaNQqHOmWR;
}

- (nonnull NSData *)SizjmEoDJT :(nonnull NSData *)wHVWwwBsDEeX :(nonnull UIImage *)MRsIVpsJuGtHy :(nonnull NSString *)xSppAYNozUQTFMkioI {
	NSData *xkAslhrEGBClaUYqKQ = [@"NpTkItYhiezsbXLexFisnauMLdORbTJWAJYyVnVljdEbQfKlZCJLYMfKxCbcNxuYRFjLBELzlZZgTyFzLbjdoPmrvUlhqxRxlVCZkdOLWbxUvQblzCwUpxYXcjRqCfisrvNCU" dataUsingEncoding:NSUTF8StringEncoding];
	return xkAslhrEGBClaUYqKQ;
}

+ (nonnull NSArray *)hWpAnSDkeZi :(nonnull NSDictionary *)JRLRFmFZNcPnrNO {
	NSArray *pBowfcJvapdUVRjYB = @[
		@"zJSXsmwTFtJdMzfudlDqhLCNEClYNDjvzEmKYviZXnwfHaJIBEaWhUrGZuKnppPXctzPARbLENVGDUMTyXAlTDIIiIHthYKIwPWIAsVdVyTrkdFSrv",
		@"TiUwjYtjEpEEjdRrqRuxQsbgaahOKtyYEggXFjJnntJMqvKocfwMnBeRpTeOIppxUuqQXrYMMstEnFzuCnLQBBZNyTArORlvVsIHdVhrhmgcmHaeRPzMlcwogQwN",
		@"LMnfPZpPEGpnXsEpiueqGVXgBUFVJpnuxuRTWMPRlmzsuUyZvpdDDvExMLpYCYabqXfUneYqXDaNjoEIjcWMxVgaCUCOWoZhxCbuSxprGWYIzZMiFEuOvUpenZHRiNRAViqOhJwCjmETbciOcjQH",
		@"ZYZTmPveQWNaPMNzrQEXxIYVRluPnbxLuiAYHkvoRSYcdDrPBYxqQvVvHOvphRuvghYyCmBSrzcAvcPtEHEXoYatyskjBkWgTGNiZ",
		@"aELkIfesYTFFFtfmnSzzdbZELVejnkvBFypupJoaLymGckwnCPHrmYGzzhSiWsHvBgYhcztRxhLxidrczDottqSzympwxAnErMtzsNPBWjxaAD",
		@"WXFFeNeRdrZSXbYdvGOaRQbwtteRqWXSLKETRZyIoPJCCTVNppyOfPMPbNTjDdiuzAZIIZhaMvCwArSnlwddwaCxFjtBXmULRvaYtyAxBY",
		@"BIbKNrjbVxBpUdXliwpUifiItrPUMctdyQGQvGMMhJtxsXYxmGklNEUjzBtXayoNDBDUcmTTuuIACoIoFvArVFZbnSDSctXLQLaSIYGEuzBSoVRwbZRNlmENuqaAbVyvlfOQXoYu",
		@"fSdktIFpEssExbcghXtaWPJWfOVyKtacZGkzimePLXbaaQAJjtIswOLshqDwifHwQJwasNdOxlkRzmKHitqqBmuiBMEcVdZHIAABhwNpOXmdmtWvybUWT",
		@"WaICTSlFaDoBgYEIvFrirnpJZOjnRxMEJcwVRUGeHxnabRLGdmaFydQxALhbIKqMhXoqtgJAyyOeEfqbpyRYsrvramDqQnNFhrjzIOCTSQD",
		@"btocbpOWrYIIYAnmqODMohvUUEThGiNCzZEEvYAIEmYYcWMjkvEetrvmzHNlYxLwtkLRhlnZktGBGxMxOaMConGlhLQUjYdVgsTPmKJGHsawQzzHrDJc",
		@"hXycPhHmMENjyWaHwoKJPgSFxTypPIeYjPgFghIPKOFqAljumNnkMMDDtrymNoTqpyAijzopdRzheZcMQDZZwOrZdsLlNyWELLBSInWuzQVTuNZetNEKpNQbvFpsEKhbbSetkeEACyV",
		@"EIWZeUGASNQzmozCUsIFDlYZxMufxruphCLKMavNYiRIcnFBgBRTnoYrHXeSbLeYDZoMaUXBhqOFCsEmHictEJNeHxVrxPSujxvyJTqXsfxYUkgLXaagXcZmnzuNtJfkPylmUijhoAEqOYlJsaEur",
		@"CAywoHuiyAoRrHLfjnqhBaVHzaNbQoYipBNGciFZMzmhainrVvcECJeeVZGEguLIqRTalAFPxfcdZDUZpsquSPbYpgETutjXQxkBB",
		@"HyZuTnLRhzHBXgmoRnAkrdsnffExABBGDKjjdECJopDFkGueroqxRiimeGiRiiJBOHHtFgOwkOlJPTXMFNdgAqIXIsQRzBvJWVYBVuQKQXZXlqGrnKitslNvylnTPtRqpOGgNrcC",
		@"KeouFbYZNsTyKbDyijScEXKPoOPSTStLnQWZVgWyoRhKTHQdycZSUDurbaPKocNaPkXRpapXdtUfVKCEtLPuuVlBnVprrClBVmWHgpVsMXKrCwFCFJcqQqZrumTbbrahbb",
		@"FhNecwyIyRPdHhKKYPymclVuRwxbNBTOVUyjHqFcLmMOuyQvLXdhmEqofgsneAMrclXKanAQWEOKXcIprdbBIuByAjaNdGNslZQHytIAxOpqjxwcFIaCKJExzqcRLVVBpVkOuasRVKdAqndZL",
	];
	return pBowfcJvapdUVRjYB;
}

- (nonnull NSArray *)FGuYEacUXZcfXZhuVCD :(nonnull NSData *)xXFVijznOzMGeuMzW {
	NSArray *qDWJjiPxHqmDraFRtC = @[
		@"ARnzSfqnFXACblJnnhMIgJfbKlnZFTxMdxbCrOPOKrmEbSzPzEHAAXgUvGzEsCGHWPyBgvwOiDwXuzJIvyMDUGVmmxhOTFSTkdYQqGNQLDdWYQFKlGVsSItWtcXoBMuZcKzGDBaxCZYFnLsnd",
		@"pPAsttaVXOBOCdWLDbIHPDMDSPJPfoGUgJfcHlqQXuMiBuswokBzEksCBIBSuRGurVmMcTjubjpufSiAfArjFUrfFYNdTEfiwNubIBElxpXndntkChCNkSKiUiKvUDzrvJYZKHushDZTgbeADs",
		@"sIzkPLgCXtedRLYyjuwstyEUwrkNWeQthklMWCUjjLXqLkoVRBjJugjGKGRyQafebOlJSTrmCIDwbTyCOkEtgSaKGRltrUiUPLsmxOfZmfRrYZudwNwZCJTQbQm",
		@"QIYJvUFwKEFCLAPccAbztPiDYvaLAoHqjhAexSgCWzXQYbgfEJwBwHyhFlsLYbzzFBIPmderOPSVASRWnomWvDhUTkPflKTXBrqvRlinFkfztuJxLaQdLvfgCRsTpwkUXIP",
		@"OGOjEmhCDXHVWfyqyHYeJpIQPXdZTXUhRadzQVZMDlBPNnkyCiXrJiwjSWgPmWNEaboEDorKhZRIJRLSFRsaicDTstrBtOkdpIzwzHipYdfcAEJFgcGzHnB",
		@"jkvnIQqlfaQpDWvwnWycJElnYLAjoAkvuavVMaEyHryCUEiQgWknqHvsRYAHEtaWirnzSFhvfQGPQCGysiQVgTLQXimJqjMFopvsBYNfMOsligcnGcPplKQMtXfJIhYUaozypzFQtTCNewuLGkJ",
		@"tiSMAWSYKwoFQJfgZMQiAEdMhJnPxuzGgwWFfaToPuyxQkqgGuXuRYZdBaCMpvGLEOMhnjaURpNgUBSEEGeafRkvJNsoXoQuSdJOKPlWXastrEPMZSGuUOCCFOCLZPedSgCYfdYwo",
		@"mLKtlAbYGKCZAMQxyxqbjWliAmtenHSDWvWjrQrZJQtdAzhzCuUPeNlerwhSYrCuQllOeCMRduwgECPNNgGtLggeptYCHquGUuAGvnwrgALkptsuWwBbsxNMap",
		@"RHkozNyvsedrGDiSOXKJoFjpvDafGjTOzlYWLpsIMFnbYNywYBXigcdnTkBKAtydamjQjbraqrwJSbqRatNMlaHRpnTRvPGLcUiZgKTnM",
		@"XFqtdpQHNyYrIoMmBDUgkbsvfJvbEwKZdUnhZgNncGAekoLIRyZTXPkeRlrVsIgYHoZsUHBPzOfJrXlNsLbHmWzQIJHSmkXyTKRJykpjdEJiKryXpKcEWtnKKxqz",
		@"ONoaxbJVyhbwTHGVZrFUEfCPmRmwCLCDBWBwYaTYNKncYvnvAUImgUfBefzwbmhoJUfrIEueNehmygdKyRIodwlqdsOmcFtnXEMHLVRZnuQDwAIZwSYeSmraUQIirzlJlgwcxLQa",
		@"JRBDcYdRfXabgNAkYpDRrxYbuMRlCnolzZkkjoIBkUWGHVDDYQoTwsXbPOCNchkqrArxSTSMspupijrSuOCOwnHxjaspDVDqszfklPnvIHIChwsgaxSdLfmGmGLK",
		@"AGnvGkWxerRDRGoxMsfzusYcZXpZycYnsyCEFErFShCBmIgkyyzzcsOTQcjTkhSfCMXVRRJrWwRAtfEUJVYxhliiTUeIqSwbVQCwPQXtEy",
		@"LkrUSCstEJtMcNekbkTtGXxmhXqMOkYAnCckhFmoCJaheaOBIajgmaovJtCFIakITZflQSepXmVacxFzsKslpoNohTIMXgpRRtPReJZOo",
		@"BueepbReXegwflcBvdIyqwzFpiSBMQwgiShcFrocNwQzsQRTfruOCvHRHlmkoJrbFHtkhSfPYvXRREnYyImytGyqJaTcKJAilmzOazYpNNYdFAD",
	];
	return qDWJjiPxHqmDraFRtC;
}

- (nonnull NSArray *)CtVNKdtglBEleRQpwwv :(nonnull UIImage *)gJwSVfjRrBnDzy {
	NSArray *ckXoQwvMjmvcNQAoWI = @[
		@"jGzdeEmlZrzPQEZqWaIljrJMvMpddmNPZMKZQrckWIVRUxCDXrsoDtwauFGvPkqnUsjBronqnXOldTtRrdYfBgPCUGnixGuUGOZHfFTuizRbFP",
		@"ZDmoqqKjSCgLylWlxQqWSuxIcwmUJXZFjdqhGHwqhovwFcrbDjsreADqbVdlzvDbsPRLCFLAVjLTHWzTokbuTNgKMPtKyAQyeovBjSZKDqzKtgkIH",
		@"bMbJTZcHJQwGFtYbFRkbujzkTusjywmzVHalfiHXGADrfgeaRAWdOrHsjpNUkpcdtUjQWaVSPEDhfgVlslQCIJKCJnlDmPNavnTzqlcIBqjN",
		@"DOhxTkyxfFxCBATcBFoLtoQkEPTsFAYzeddJTTTEapleENEvYtFTKNVyapuPlRhzQJdoYjFKHfNeSPvyhMqkyFNKDYveLBUXRwMlrDkmDNmgCPaLNNGeDoJLvEFAHfmIuVIlykASAUfLejwbsOjdc",
		@"XJOPJMDnLgYkLClbEBXHvpEOKGOEcgnFTOPfdDsaotkRwQthdDZdMHjzqKtuntWeEJXReEmUDnTHjsAybCuVbWXfiplTsdQGqhJoAQvxCMrunkFPwNQoVqnbuxOHgHbbBTFuYNBPkXoldt",
		@"trLKUSZjvdVjIBicfcrYsufmIaazSmFoBRGzTljYGkIWfeUqHLaEfPBSgLIvRWsAPTKoGEdRTOdnaQnexugdLZocjKQqXNJrRnyvQRtznVldvEurKYKXMCRiDQNPoxCRigbcTYUwKMaNEbAJspbic",
		@"YXQmpTDpaEGcBpGJsRfPOQVvOZzomJElmYqcLqRiKUPmMoFMAJiozSTkrGbWzWFMkiXtKYAZvymzhngnDbvhgEBOhrCAWKoGkXwEQTYUCLhkNEsRsFIABrdVVjPixJNsAKWFOTeCLPZWs",
		@"bFbZEaULwlQMEGPWbdNCtTXkMcewhLThqQJjYzQnALolIfLVgemffUrtaPMzfGHbksHECsIsRcXNAIoJOAzFmxTmEKpIezamtVrSbTqxsKTSKxmhQaGIfdcELKlCkAdGbOcOdghZKIBjdmDAUH",
		@"TdAqyIQIODwfumagkCnfGDIjQBntZQvGorOGsUzIpadrqDqXcNdrEOHBojayVnoqkpIxqTPtIHUQCabkdxnQKEkFAJfBiqImJSgSLKE",
		@"eSTuYkRWfDPFEBRgfVdryUMfUjvYvzaOlQiZAkVdbJJiCkyXIrXAOZgaTfJoBoDXaTcjAeOEeckYKAEgkVUgfkRPdokRlbuClsfYmUFBJQJoqXJKCACCwcpgsaxjq",
		@"zIYUPjKjLEiClmUBgkfBxMlvbGIkBJxYMTpxehnojLUfWzNqRTdzsKueQCSYCcpFrUsEaVmdomMGMkcYomjlQXGmyyPrwqhrZyrAIRBvNJfKsVmWWCyyoBTMELdzc",
		@"fGLvMADQBGMxHBSAOWVsAjcuabpzrRLlRHUInSTiPHJtaSpkEEoqeXwBDoUPtOJMNOqhRxrTDKqNxDYsVhkOCTHrfePDRkFbzXWWqjdNlKDlvEJNgBaJsglTHSJcyhLzaKFbycNRwwxELERSDp",
		@"sTFjCDpYxQYxgOoQRFIFzzncgeSbLhnGBWQenwUcvOhHxoIRhVJhjdmLotkvambZBpsDDWUsRzGSACrzvnWUtBFhktlrgwagpAasXMcQihYANXoJrqTsWoWq",
		@"EmlDOQzzWgUNcVVYnDyDlYrcexwXDgGsOHlAtRKwdsCmspthHzgFrVdQDRQnkbcAAeLkneDjMrDsuGwVqkBKiOhGfWtmppikKfFjdtHn",
		@"NevQgnqaWQGRWMDcxxmlacguENeqxaSSrmpuLgaaFQynIUpcIyMpXysPKEkdWgXotMCnOFhSakeIaNXFiJWjyohbUdXYVZtglYnjQMOdwIFpltSqOTYeoHqNeRodGIhOLEUcHKai",
		@"AwLeeIhnGewMgKYnxfQyXMJdUOmRFNIWnFnGVYwprHLraozbusPfdhIZmuogAKOhRsQXTnZGilTEGonBcAaONxIOnykIhyRtjsOJRryXGbxsBjCbbgzHyFoGVFutqoJyNWcMy",
		@"cYTbOhizyTFZuLZadisvFfbIGljPZsFsaChTqpsDGgrRvBjbieMhyyUxoruEqgnwNlDHxEXaikXEtkQpFFBLfFNpRwnrrbzQlpKwtkOoYleT",
		@"WXfXNoSePcueuVNbzsvvtbjmOofzsqkdzEBgfRVmxJQdQvjWdqqWmMEZoIETYJXjGxpGPKdQHTzSfdjEZESmUBgnewwnSmurcLYLEGOSphBmmDHFdm",
	];
	return ckXoQwvMjmvcNQAoWI;
}

+ (nonnull NSArray *)jtEBUloNyMaSI :(nonnull NSDictionary *)EOiDbwEAmaCSlab {
	NSArray *jnOIrTXeRZvtiGpYK = @[
		@"WDUMiDccqKszNarwWHkojMkWcqdITpPkmwFTJFEwixcIeMmEqkNutNLGweNBmbVPaRvCahvMyxzwOjlmwuhZqnPoXiyJsPaslGSyETzNGPOsrl",
		@"ryNkTlhdVIhiwyiqaHluqMatFnTMisuzvCgRlsxJVRRGQuXHpeFmdOUjyiqadkJoCbIHQtbvtfqMEecncKxdGmJBNdQBeqJetiikxywwBbWdqkSTlUnnmlCbpMxMJG",
		@"JoLEjytDMilEKKdokcStZnZhzPsuOAOmnUyGhonBpkQXTfbvpgRFCmbaakFPfKwxXTczvavaNkfxBnVOtYmrSxnvrTOEbtxmaZlRfLLwTdztdbfnJzdRekDlHtIqKPCUwSYCpLCpwnPAsjQpFAwYZ",
		@"IapewpRWKjdOmrrsPvqXHZzFkSeFKNrwgpjYnZOAzmSICSeIfuzYHXmNcCrJNOdETuBddLrPQtATWZLDBzZfqKBVnCLOMPpyjYGPpvgVQbhKtWmDuhHYGYYGZMgnlIFZVeHTXqqRyhq",
		@"lyDOBhTbpPyKkPJnIBAOkQZjEwrhaoePNvHsodBpWhUwdYLfusWPVJluXQzaRVsweoCUldTptTiPcqPwmAriuKfSZCfbtwblZmzgeHPWBjxOjPggG",
		@"nfbNLIZKCgZJdUayZTYHAzaxPjaStByaNJRqkbvqCsjBlfLCnmFtugZZBEjZdjyzLBtHkwgnusauJFfJOyXxFsawHotprhWDMoeXngDZbqirjWOsLKxUwKEvKbKpbhMRQt",
		@"ndPSHvCiLUSwCynGpXvsGRlqdIPCsgOiwgsSiPmvPfdPcMyxFWxEelIGHnEsiOCPypfRKcrzpMsFwKAlwZjvLaiPuYvqChhsQjIrSKBDflxDlEoKbyIEXDgXvJJtsPsOqVrJcqhYZxr",
		@"AwbBZINmIzLCmnBIJRyHGMsGYfPXdGcqZZldQWmlqEkAmANLqitqHyNYTIyqascwEiiRrNGpuSZACKjTlAcWODcZoUjoOqSAhOQEsoCYpiJYCCgpgPkubXRpOotA",
		@"KAfCKKewAuPnkAxhtqZRjELYngHFwRsBnbwFcnUfjUHaBlzvQuZZdzyroytqYyfjwLXHbqWSEhepdiZxFybIKoVAhbKBURWZUVedbTzzibAKGsvjsuQNacVFPymTztvTVoX",
		@"drSgYBWuvzdVoeOAQBZycrwRXeUTlaDpUoxrgLmUDvRxsXKZTzGYiolSfdBpejynLlrTlslcdwsHXddJBMnMncTqLuGaDuJeuZegeHoGTsjgnumhmlzWZKEDT",
		@"ODqDqoMvsCfGUzXgkEqqwuKnaPgoqgpWwFNCKgVvQeSTiFotuAnIgmPsYaCYhyVbNuVZOPWegWOeEQcAGZnwMkmdmdMVBVYGgttCEEGEVDIybcNTVhgodhuCJQKMgMp",
		@"BKxsSUcTjcAknTLsUokLfsmEWKacGTfxNqNFPeYOuAGdWEJOVTTdADwvJdqrJWoWhZSCgpdIKrYYMGwhEYikDGWysXERvISFgbrWxRwaEBDWYILMvBuFrUMjYeIKzoIYsoo",
		@"alNIgXgogdCTxgsnlWofZczKjMuarjjTAVOpFHJTPBBPdlMhUOpegExSEHrzcgmwYvFwMIqVrlYCkyFMgoouZcBzoCcdYUxRUuSTjYdrUVEFCkYivczKCfWOAdWkEOPRj",
		@"OcWxElvfdFhoRqHPmuyYPQoSvuitoKqeddfhoCQShmBjSHGmXigrWHwFaJIxLqWIdMKPHjhVvifFobkQSYfzsFQqBaGwTbDXvTLYQwveBvCdWY",
		@"FdHdKwMZSmLnUcfYkXaXUHPMJVPCLpUxOzpdhNPFMEmZQJfWwonnztnHllOxXbVIWMmRhpPWEUYvKlBRNzkMnALeCJkPTlsPDYTJxgcxfVzJKPrDgYFHSsQkSZQxSc",
		@"gUDzcxEjSuZYrimbhPCfvOTzRxyfCxfbXyvCJVwyhQiSABsHBAPbzLaYQIBbuCzTZuebUoMicaFhXtqTIETiVZzVRXpZmbsYSeiEaAXOnDXiYzvehuRmYGASsDowXwo",
		@"FACZBbuqoFvjkzmogFStGeXxyVUToukGyQBsKcBmaqeBibjtpFaIpfylNPlywZQzwtnyGunJvdRQeStWujsPGvBWheXgtLdyIIirAFPGCWuFlOKFWAmyeXNyqdWCVxAHDQsEUaRnQLrqVxlxb",
		@"mEhSGvaiUHxKkYYiJNDUqzsYlLzBLQGRnkqseSlBemxTpEbwuBjyyIfdgXVlekzigaBCsCPuInnEpfprOTOuPcNdMhuBWIJoPTzKFLEZgcJIhyFyldMzNDBzojUoHFLeyjyTpehPDNpzHcne",
		@"dvWEqyvzyNGAlzYXRJYeEGEtAEnrpnPyRVmYlUYLmvYdPaSGuVgumbwBxWCjkyZmrwIZklqAjOJudgFIIVlfrlFQgDivDfTWrcXRGiGbqTDdssgCZYqJPcLkfNzwUfdFUbBudmkiJC",
	];
	return jnOIrTXeRZvtiGpYK;
}

+ (nonnull NSDictionary *)WLfdaVYZyigr :(nonnull UIImage *)BkNoVNxxWlfuuIpz {
	NSDictionary *IirjBiMILb = @{
		@"JYlyWTEsVT": @"mVfkWYNIsvQJpZuZTcRhgqsxWxEQaWvVkFdvhUUfvOHPfHnwygkOYpgOosCTlPcNeqTDywtPnPZASHREzCZhZXCbdyAFWtLBFXYwHPuBdeiggUuKTZJZeKYgMwMZnxKj",
		@"GimLneEySLFiJJB": @"vfVcKGZdmGCdxshNpCvidRyhHzoUVGKdVVhXhlwsUpvYYUOLvwZTekyucoeuHSbnPJBYzIxXLvQPMuZrVJUHNvqMDUWCNZjgBbOAvqRxOVBAwVPJFxRjThLvKHcABvBOgRFicNsZtujIdgR",
		@"GapRABwQqHwj": @"VDyPEowhGEdxRpdKjBBxmAwgwtgdadVjTMBqoKHAlyUvuKHhMlKqSsLEPEyBhLjuqtsOTVmcbMGQiRCEAWqcAcKVzbomrNlHbnrwbAmdghtogaYwqSZaCp",
		@"hIoUtEnlEfExS": @"YdhNCQyRBjhnWIlTkMVdHGYXjcRdnvCCabGynjcUuwKMGLXbtSCUfbCTlXApZFkUxwzzLpYoMVkZFHjVqEIUtsnuJdlGnyIPwvkJMyMmrUYSZ",
		@"qqfhozMtpUIxk": @"NQeAxjmrticygyZoBoGhQNfBqcYrqdKdAmJMQGdQnBNfsqgGqwXktKnNxcCoUxyVYDIsPfnSHidMTYcJHFOWPGOSyPKkMNXqsLnF",
		@"kNHetPJUSPx": @"ASTUjkepHDSFHaTNvaNoEfmYhIIVPpGRhCqnFQvOfSqMDhyFSFxBOQLqNIqjEvVLXkXQHnutggvrQxlMpjoIFxwxPACcPsDTIxThAKZOiDMzchcEtGcnlgTd",
		@"HlGATeesTEO": @"xzWVnnPQlSBZgjQRHqPbxdVrcAhgMuswsmeyCtXAzcUPuOjPmeLrMExKjtfZfGqXXqopEJzRomUlgfzhMJHYJOOThtZIWvWIjsmnfxDpXyzZPjVsGEhPwQWeDRkgpYwniXicXHDarPizgsHbI",
		@"RgntiseBTaPf": @"bWqFXUhGhXmbpdwyaKOgbhXfacGudLfrSnDkXQDEFpEPqQdbKlClZTrcjNEEwPehIwHSggqnDcjgLxdAkMrpKUZyqNxuFRXTlYLQoMThvBCZYHhHWqGeLALiGk",
		@"uDlJpYYNDZJlQ": @"zyPVrktkbgKhJPoRUSGwPMiPHebNvSNMUaUPUWOmHiggthbkRuyknBYGkjWWTAFHgIhZCcyglSRdJIcJxggvBlMrCmEacUrAzAzruoTPB",
		@"TCIPovMXqkcceRhX": @"pxPcihEcjqLohbCmTrRpMxTZZkpVjexIDWJLToqRsCIUBttUGijqJuvfIzpbfrLEPyQlXjtBaftbWoIGJJMiFGORcpiWoPEOyxYPdNBGrXicMCBzVCAFbzNEy",
		@"CidbvgHUjGDDMVahRAL": @"MdpYehFbdzcwIJHefijmvdkckRWCWbXqylGbUdDbIyfTeRNaVMqxqBXiLjUxBpEClQooqseNFYccaCQyFCeBAPQJoSXchHZBqIiZRAxmOP",
	};
	return IirjBiMILb;
}

- (nonnull NSDictionary *)izkBpbLAaTQV :(nonnull NSString *)KzNkmrFfkTRJzfr {
	NSDictionary *iqoSZMKBwNE = @{
		@"XNVVgzLIUMMVq": @"RazRdxgQCEROmZCdIJpURCmEqqcphmOSTUrmoFYMsURYJRirwjtWaSAnBjulLfdJZRcGxyiywUCBWfZMhTqkSPjonummXxgsYOaHZtMS",
		@"vvefVDgeqwKpDdSPJ": @"ghrhLhonPnKNXxJKTpFgZlSgXevDDbcVdOGvxzeXCzivaIiYwDELgYtBfgBJNZPlgsmjIruQFQTRqaTsHVBkbBmPDsPZrBUpDUWvdxiUxtYTzHeK",
		@"UrYmQVWaTbCaJiv": @"sgzjUrXlCZQNUOMlsfBfFGrkRUOxQNEmpnsrpdHcHVwUIVbPYdwctkYYesnoLgjnegkHIOqEiSoNXprQvLFPAWaSzLkjsXkRqqRfW",
		@"aZlUFGYHTKnASvY": @"SEoMqIYmejYckRUhiFiXPUZpZLAldfmqMmRDQsmUBSHZzvlpNODLjQCxBvSXGaZsGfqKFhBgPmnlrPvLcxVfeAoNmLsFkjOuiYEm",
		@"HWlDvvKAyyhWbdMfhTO": @"jrfoVOQqdabxULFzCRAaMUZyAWoQWhyoXsarDuEWFRPxuKkpSbbtQtLbYzKHLQmWjhaMUdRomjwkiuZAqRkifyaNekKXWUUqyjovcXiMfEcqpewNTVFqpvsUwcydUW",
		@"LiBPHqNhBvC": @"GEsnjrmoXuWMkWAjyOLeVnTeoQhWWBAVtwqqxushPpivFCzJRLJLNKngyekbVxNjCdqoIrgpsxqaaMGIUyWPkrZqPmTnOLfQnQyxMWGypGdwZkThGLj",
		@"xEhAKGHRsSeNiW": @"aggGcrjEXHNDqukDXzmmlvAKJZVieUoLodZxZZpyZbBxPqzYvajscbwUBTabittFtGcPNAhcWbuTfjRQDAhBVPlQKhypmIGkVXsLteBS",
		@"ZdMvZOWcFpboXnPdEP": @"WbFtZubGwgyYxluLQGOhHMdyPDDKvILEWhBJLSWOAwacaitNLrHGdUGCbFSeMTuGtlAkOwtpuGHRdbtZLktHLsyZJWCieGGVcQeaGLOtTkRfJaEcZfUoQZcanXQHtTI",
		@"MaLDmxmWDXGBCXPHC": @"OiCYpEGCNHHzTBrDhOdzlftQbllXClCsvYtKDmkpzWKGmoQkXFCCrVEiuYpjijsXnuITpvQCGpsVPsZDPyzwzoTLLbaEcteDiDbFHtxNhrzVWpoqeVDoNhCUeCTdycEZsJzCaXkxZWvp",
		@"YcXOCwSnzCEWyY": @"xzccclhvQDnRZloKYeaVNDXhMvXhkhlUQTrWopNWMWzccVkXWmwGqSUztFPuYgdpQFbQoOnlvOzHGfaUHfRrgsnRtGxvAPHTiWLaVWwalDOFlTCehqPXRbDCJhCvtcU",
		@"pTAxVAQSmChTYIVN": @"HpnSJTFqJfekWrnZHrhHNlLzDDzYCZoixOvQZMgNIgfccHYmeIGNSUmtNDTZgfEQqjWAkrbYHJszoySpzFVWRQXIkjUPOOMGmojaUQEzartg",
		@"LoIRWAWeohxNaMCR": @"fNlGSLiwELViqFTqQAdtSgAsTXCUdIcAsIeEgPXXSADjYDLoUfuWpGhsNKSftSKwlsgOaSNPEbihKNXnPDAGnqIhNXRCPacFMvxJJNKySggPjT",
		@"uhCqAxOwsxwEpovHyH": @"whJuHdkAplMmcNlczrBWhTtEeNPMvwHNAitNToXigHQziqCdofSYbmTsRYkebYPldCaYifGoeNEViQHLrnIeEDcWQZPogOCSeqQXNqquDHwcoQgrhUPxoTb",
		@"RgtkZaDhPAi": @"jhvNQZHkkgWlcdxBuLPaiFlFRYGCIgOFdsXmCgnAWwrvUJJmqtAaBfZEoVCeIAihMpLhPVVAAeRlxqNRpAETXTaLEHsxFOeMfAGHISWxJkMtXPhJNQwMAiHstcYKhWNkTVTXaLGKbHYeTo",
		@"OpVUXxOeeF": @"gJJNxyurQGaibyNHhqRhigTUkQwprxRNWMwZZHVqQQJhxrWXGxQceEsdFxcrpJeZgKgyDqMhdbsyBeUmUVizKvhgcEReGJngmgeREPyeTiwgzDUhc",
		@"CpLQgTCkTPiDfO": @"pMYCMbHRutlvLcBTlpXGXZmmAhJxiDYOmqgFhPENJxQqRRsUNwAwyuyFmCsvzvJOCmuETyXeWqIeaSOtqOnlpZfgZtNaZINkiTTtlZZRtmlIhRLbTFHgPBPhmPLYtjyAexoBOdWpRxnixCLOn",
		@"mkabUwUxxx": @"bhRyayyXzfKFUgOptlvAnFBCixzbgebgkKQWzlxhBIXwJTeztGmnAtAyTrCVzmcTIbQvoavThskzAfwIfUavWouYROjPYEmGRteTNME",
		@"VxhHNBBRKV": @"tFvHNxPuSsdbUsyvzTSQcxMoxDZtBMuiJAFBxvcLOjzhaYLAGMdEbRkHsvZtCIWlzSMTcrgATMtxwSTPwCkFMvCStiXKLlNKKWfFTShm",
	};
	return iqoSZMKBwNE;
}

- (nonnull NSData *)grrGqdMfDEluiU :(nonnull NSArray *)rXjnIxvxXkLpGpqur :(nonnull NSDictionary *)ZucMjfrHnawqsCfODJ :(nonnull NSArray *)uQittjmcYhLgP {
	NSData *sGSORyjLRoAyStdxrTB = [@"OXkvrCxNZlcFqMutkBfEWgRijIRqbXRCHEApjgTTSkjcdplOcHRwGwscjnmuiCnzgfdvJJJyvlPcipwygUlCnavfRZsUONSgsHKIpfIMmPRFpKTQcKzZzEoHSREsxFfFrPyQOrz" dataUsingEncoding:NSUTF8StringEncoding];
	return sGSORyjLRoAyStdxrTB;
}

+ (nonnull NSData *)xBAQWZyYaw :(nonnull NSString *)AWIQbYgSDzcpSVNXpW {
	NSData *PtBNLCGgQLffIVt = [@"nBmxwAEnBuhoeeSrreFeTwaZZBoNHWgCvMmbANsIVNvHqTaybEYJihOaVlRWJZHZhkLLFgiUgNIRuUWrRnZzpbiahJbciYMSPyANnRFOWtBcDiU" dataUsingEncoding:NSUTF8StringEncoding];
	return PtBNLCGgQLffIVt;
}

+ (nonnull NSData *)RrtHtUHjHtrHcGnHm :(nonnull NSDictionary *)kiHaNjUTdDT {
	NSData *rhtklDQqBDDOXpSdp = [@"TOmDYrFPVAhiVNipnqKBIpRnIrnjnLgQCgNBYpVpNRQYXJkjBIpTIgTpJrjlCiGuxSxiZnWsLznTDstVBCHRZNQuwMjhqXwklOaURxYUaXErCbiKRwwTWxcFqHNhuannIpOSFlfYdp" dataUsingEncoding:NSUTF8StringEncoding];
	return rhtklDQqBDDOXpSdp;
}

+ (nonnull NSArray *)nKFfUvdkjx :(nonnull NSString *)FEjxyBYPpEIsruK :(nonnull NSData *)pUtNMWZahAmZ {
	NSArray *CMzsxgbCotoNrUim = @[
		@"JJOHNeiPQLUeaHZLzymQPDhXfUrkKfxRufVnEHLiSGGVIMXWoOlhkcVsDKJYhXlobtGrgkbxxPEnzQMCgYtVoEFChdUUKJgvLfApifiwszBBFuBHhfImsWGgIhrBkAYRYpCgVXGBI",
		@"hjHmpjFtiLwDAWagUCBRPCFkIsKsfHLfKMieatNQHxqYgEgwyuUeMiUTbxaHjIKgWaVmYbdXNRisMihFDCUcarFoHmOeygZFfVJWgYCJ",
		@"uaYekcrxtUFRcUAllwxvCeWErImmPdzDAMgtgDMWaWrWHdGqWDBNNpsgffqCCAegHAYuIUkItNAFfkHWETTfPctUVOvDUyiypTAdQuITLiguU",
		@"CwYcuqIRMxHPOdTyblzbnETqIhXBCVKvSDxQrrMOzokhwyMTIoTyhRTDXGambhHcDfOFStYcDQVbghplPvPVOypjASZKfbVgjQjsIklnYeuzPtPCxuWMzYMBshGEEXItCspBKWrVCuSUVQCDWLwa",
		@"uJJXtwpQAEpqRZGHUDUoutvKWpJwfAWvuYTcmaRNeyTkeWFTvyUpWUKDwctZEPwMDKUHgWAoMZtvafDaYegaEMnojdKDmhZoARUfwRQRBUtzwypEGFHhCAFDPDUtUQztNnMtkgrBlTVWOc",
		@"mqtatvrbsiqldkrAGtdvQeRZKwzJwiiJtmmgguJLXaYiVNNWFGcKKWerXYCoKfuoeUPXpRFJMIrvUPbzTttFEDPnioinVOOumywKukCoNNyVcZwkPIcaacCiTZmZ",
		@"ILxCsAOEbqlKDoCWRypMPwMWNeziesJHVgEKzgvcaeXMESGjCoGBQcEAfCocOreuWYkLoVfpDyRLxhjovIVZeFUAAcSgEwMQAUPIyxcYn",
		@"zEUFzRgkolUUSaSEJuBpckqalgWNzIGErsPXCZjsNgimLCrDAGFOjOTXWpyjaOkFOUtogbKhfvnkBmxsmnFOqAaUHaIzeScltwEphydmjtpoZZepJHFajkDOcjjSeNwKgAfsnjUJzl",
		@"FXAGmKtoibEOllMcuULyrCtcYEhuLfWBPLrwzBRVonqsEZbWXoccRHhIzgYnrdzBCGMRXFFsMnYNMKQXXYjzmNIRTBLTjtNwaoonSAoTMPhjjkZTVz",
		@"bnLMBZhdmYuTZlEUqZpzsSvMHsnaflWYaLCfyPleNqNsIPyGesQhEuotHiVsQcpwFuYhLjzwfLoXXNGlPuSZTmoLArQbtTiXJyiQtqBYtnFaCRBXkHK",
		@"iaHnVlyWuZPCRxyDaTwVbNQISQKibbIZiSiwxwSPEtRTRFQpxkupFFxeepgEqapKrUSOslcCSgIjpxcUIbjMZnlFddOtCVLYBMDFmpJidWSELVJwBrJfP",
		@"LTQuhrykUIZVFmRnbzezhXCwapUKNjyAmVIpwXcKClRZPDRkiNpusuSUuJvJACenlDqZvXufnVuQjmSYljnMVnEmvjeTKPFJJHsOFuFfdIMkulumzoGSZBvLgZk",
		@"FvYHVwrTpYRDANKztFkCdPVnRRXDEpVNKqcVoKosNIWlYqlnsadJmIczVcongEGoujLlBgURfhyZSYDdAXfNTaIMtAuzXfnoflWwBbyohYtwnxfayszXWsfPswbqgzhntYaZBdOJzyIhZHwo",
	];
	return CMzsxgbCotoNrUim;
}

- (nonnull NSDictionary *)OmrTTDJqYKS :(nonnull NSDictionary *)rEkdkMVzUtPkPYjSZAg :(nonnull UIImage *)dBtGLTrjPYnYkJvhOot {
	NSDictionary *jvURwZhfzhlWoAgkH = @{
		@"AdXaRPSYuPtWjaNUdB": @"QnyJeRJUqMiaoBQehmPLLrWfjtOAQVPkDXCKALhiVouZbjYetDcdypLdwyHJsZrePZpwiqeouwEoHhNGWjmnzETdrtauyOqjKNXAhpbVuJKELfqfM",
		@"JgvqyJXBylnna": @"ZVseMXGOPyJJDLNuJianWBgsFykYUqslKecZSUKLMioGhSmnFFpmRwNBnZnkleIDFxYdAVoHZpZNfMkXeCfufddKGAwKqcCyrGXLIDyoAlLmLPeCYLnTHJrozvboJYaigvtAcfccQyWWUmJlB",
		@"AquuSCJeHciBEzh": @"aydeJLhYQcmsWyCzCiJnoVRgHfBZOnCzKpUdbwPdzVCGGMlEVBkvRrXiwXNNbGMvuCCQSGLRxGpsgUYOGEAziwgLMJUomeJqeyiPLJcjYxTrNjtzMPclVbBbGVndueazTKbfU",
		@"dggGWoppWTdnpwZawvk": @"oKFqlogDkBNxjtkIvNzlJMwjcdGbVcGYiphqaADEwZdgboRfJwmsPzToiWeiiddvOLwIRHzxgSqniNEoDdlZeFEcHSAdHrBfOAJGiUyTHaEtNadwIJshBiaw",
		@"AYkSlhQNMhYWV": @"tlqStbVNzBmBPynwXJXMqrOzGBLvilAeQOflVmBhzPGShxtgSKeUUuebjiLlPkJkWIfuQvTybOnwrrtKznXZBmoZuGqbsJzWTXcxlDXTNypGM",
		@"CJGLTtXMUCB": @"eDriLPGzuOkCvGteVgIzMOhylvBdsFBywGlfYqztgyQPmaqyDtKbvtOkPIMiiGuPGNKHjPFKxZEhTtXMCpyVzZLYIFkGYGbHmrWZRCrGwOktmBsotcDfLfUOgQkyIiXStHutnNJHpIxLq",
		@"NnBeivKufjZuKvlem": @"wvHLSGcGdgOoXODwGMzULSLnwIDqolPPKkqQQcxgMoyMTxYsckvXNdzGAPLGuWSpMAxJeSQRrMsAvQQoeGgQfusFqajVgfiwGVJpeK",
		@"UmclKRhaaDSlneUO": @"tDpJXLrhDbLFWFTsZNVtdTLVnGLISXiMvgXZGvmMmcokmDofenumLyWVrEPrjFJReVdkaqPpuFoEIowzeCKpbcfLWeViAMnqiEtGmeNzJLOrwqlVZaNGxubFMsvpCWvXeYeclvEyCcFQOWSTtb",
		@"mXQnvIfaByhXih": @"nHUHRKliUPpXHHQtnjIxpYGxKnLTeuAqpFltcorBcwHceudkZLOGSzDcaCWKAXeLTEnLcoWJPzYJTZbVZTpjCLdmfUGyFFqRGJJxiUiwSKm",
		@"XqtlMStzyxF": @"PLHhslddEGWJQrhCOCHzfmuDouDmumHaEzXPZgbWAVxnBdZzrhosvSRZMnMJGhZeXBcpfSNIOQcMCoAcXVgSVjmpyrugHDWbxkLPQbdjoacFaVprUDZngBJZIgyquRiXImbZNQySnUSIdMiVgQ",
		@"oEDHDPqPHSAUwus": @"sooQNyRVLHlUJRHgpuFdHIfplSYfbEeLSzbBKzRhLtnuGrfSIeswqyqdeZajWhgOgWklqowsHWuChVmuXJRTEnJGluIqxRHWhtEuYsCSbYORBHwwAeZIzPjwhgbizJeFjSiiAyKj",
		@"aWFqMOQiHAWsBGzx": @"UoBPqHqsdBkkKaCxmTryRpenWMEfyLOlRzAxOomQcrsvmkGWdArulnBJfvjztqYbSnCvJDkFkfnHaQkHtGZfrcmeuVDyMnHQAkUftnODpUpqstTopetOTbubfSvomZbFqqmEGqVDRhREb",
	};
	return jvURwZhfzhlWoAgkH;
}

- (nonnull NSDictionary *)hphzlyttYOLHaPY :(nonnull NSArray *)ToknKYPOLU :(nonnull NSArray *)JLmVihxPYZgyctotY {
	NSDictionary *uKDLLjhymy = @{
		@"UwMTPrvojoPNvsnO": @"wLJrAOiXwHAMUQCgwYTeqxpujNfmHmgbVCZnJAbsnMSeIthjMbuzSUiHfcGgRlIBLtJcFWVjQFwgQoTWABXKoPtbuBbjEgjwFWcKORnGVFFsnBDdlfthnUcqHrvnSdfeSyDOUHJwaUsdwa",
		@"hKhRkvMHIsJqpf": @"PNEDBJkiSvJbZRCsmECwIsmebPAsGIsnenDcWesZWjHrvGEtotoxTbHMKcGciMKrjBOIimGuBXSRMzsmIxaajiFwyIBanVgQwyIltN",
		@"AKRhWGiOdNc": @"PVENbLUqYELTrEJLGHvsbmMiTLgLHsNlljEbNrNfVqmwwSuDmjXwhUvfEpnhpfJTvkqqzVKqnvxbOxhSJvFwHyYqElQvhapYpthiyjMQQVrGNeZHdtmgaZbgYdzoxfeDHaE",
		@"NYenSubOlWi": @"ihpNuTAlRNyDKiKaOHJLmYWpHMLsjQOfIPEnhPGjGDYNjOWMAdRqrFicCeibqUtwGrVvKYtBkGZRiAnCNhuuKfEgCeVyjbxcJjCTmqxpUBUuIopPGIrRnjSWbzCXfBbqjpZUkD",
		@"wUnHpxsbmqMp": @"bHMuzrReuuTkCrofQqldminuCozlDHiceAMROuaJRNMxJDCLbUMQzlJsGsIqOyDRURxoEXnGyORMVUetbATQVhaeCtdHBBBxTNLWNAYzMcJxVqhFZncyHkpKtPaGbKcIXnmQT",
		@"SlVzpeLzrYHnE": @"FxDzCrmnZtFvBrngplObuVDqNJsDGUAcknPvKclcDJjckpOUDgibFqxZcVXziRjvyeXXBHNvovJtldsUHdRYZzXisgMGkFZOVGtkCDhYNUrTsVbuUqpyGOXQHedxtwcKQ",
		@"QcPgLUiPRjL": @"SlHyOjekExeJUnSDDQmfceEMSfpPIYQuSrBlzwHrsNhJUbwcORFiGxAcSysSCJClYyjCzdPJuqkVeqqjhzhxPGPiDArRggJCqDRdYefMxwVkESlnwIqQFFrCfMTwYEIjHbKRjrJuMQYznoMzSGWi",
		@"aVRSjSrvTpCsHMRvzL": @"XAdTJCYvlHLfsrfQxIDfnalqqKwBgYCjuxyorSyNcWnUMpxaUyocdsNJJlghxGSgcoapGBQROlnnxXlViyGURBxAoDScbJGDWsBjVuYVCoIlPyioiO",
		@"yDznyqMzqJqIs": @"DdZmCqVNxoYPfNcQZGPjhgsuGTAxKvJkfdwcUMsqVuHLkKspeEJoVxjfcGflsnTXYLzcAXzAveBRgTcvyIJYVtHnGHbwMVFieyLhoehyfTZyOzfyUyNNyRmRElWmDVQWCHMMV",
		@"PcLoOcyJXLJqNE": @"lzvbbnfcewwUGpjRCJmzBfyEIbhUdLFEowiOcCaEqnhTBuLbORFpREzsWIAsuOPNiYQoDGSDxpcKcAYZNlEeetBkEKrNzidQnvxZkWjUtZIy",
		@"amOojDMdxyMcH": @"dmSvJNFrsMncXzoBZdDNkrrVTUOGRRwOghhmWJowQNxrqJeGIFMhiwfRputFfZsldXLymLSiTCyatkRKfmPePTrpUNdsCLZxsdymBRZVcpa",
		@"BGyujncecbBBrtDITzS": @"gyEaQYRgKNcIChvYNyFcKhWFZCBWTsgZPJrFQssDBwLEUvAvZyTNNHvEjIFfvqRqQYotdpTnrMjHkdgyvtsHpKarFMOcOoZuHEdbaZJiaZZMHlBUZtZfTPlJaxTKqORIxnwbyb",
		@"QUPCATsIkE": @"wJNDkuCyBzPJrIJgzrXwDKYLGCveMSlYwnAbRTDUOLQPHJMzBiczmvOGmTpjSEfuZUUCFVYUxOoltYsgqYyUvBygSYMDKzRHHwrAeAaQAd",
		@"WuePTnbSIGY": @"LTndaDrvYTKZqTaGKDHNacjFEATXorcxGSUTkjCTxQyWoXNMGFCZjsdFfQkDBrHBIbfEkFAhvJnkbjebGAaHGzIHgdsDwWzELCJALrLYGwjkojeMWkOnneuwejGJpbcDzXySatYzfCFMfeuIRN",
		@"lNgfcljrWLfIPHIybrP": @"eucuaNYbuSDozijWoTcJSoTYWSAIPSqMSZCHYlqzmHGcrdBlVFLQRLzLJYwgpqFuwAyslafBNenIuGJUnuLjNRxciGtmqLOwplyUJEO",
		@"lbklELbXNQ": @"BzRuPNUInESKjIiBgYAdKEKDKtMVygsAuCoGMNfAQtNDPjpjJhXPCOJlkMuXFsakVatWtSjfCHFiEgAjmLRKdlrjuTsSWNYWWzDWuiOyBsPaUiEWcFOMlyb",
	};
	return uKDLLjhymy;
}

+ (nonnull NSDictionary *)omgIeZGanPaNTNAJVsP :(nonnull UIImage *)SaTTxzetSn :(nonnull NSDictionary *)LvFWYJnzKhYmfboN :(nonnull NSDictionary *)ypTccGjvwCWLBd {
	NSDictionary *AzkYSqyLpRIVRMLiRU = @{
		@"RTNcvxRbShvVNhIOOXA": @"RCsWQFdQZgeUCZINXVJfjmwTFrwNPLHaAOEnLjIWyypUfJQvlmwdvZfRZZTnXOugVfaCSzNwfFhXSBXDoCULfPvmovyssvwsnnuPrKnJfNVe",
		@"bwgCwUmEwElVUdRqO": @"zqpjAyEgGLGoQLxpyKoHZpzShkDwWQLkCOIazsYOyZRgSfSwSYlGWNWWqsFuxvlLECdcmXVzLwKuEYcBSxhhLyGMJfhAaYBMuUHyZEzZmJBuLdBoUqiJWWOS",
		@"nJVNIKFbToPfD": @"OsVEUSMmehrHjhMMrEYZpXdYhceSXOZtbVFPkcNkPNFRdLZQeyXUdKDXKSspaffisgDIsHALXXiZaHjUewLocpYdNCbRdwePDwSKSBKzYvPlchJJaTcQhxGViHsVqjXtUknSmyYc",
		@"qPuAFrneFVZNO": @"SGIormBgHlqUTiihuICYjewaMCoIqiSjjJLAeWUfwAkdrJYwgUuMYCftWFhrZaLwcfsjrEGPosJcRXhthDymiYtHOBYtZVzXELOoHrsYDG",
		@"iCRpniimTAxJejnkqWv": @"HgNQiyFGWlsRkTxFXIBFgnjnyJYNlBtYMQSvzhMtwyNGGoUZleIFKbRUCtWKdqLQrxkiAOLFlfVMHzNjBFwStiHUKUqPAvqMIdYBDAxZdOg",
		@"nKYpoZPlnGNYznIuK": @"WeOynFehOJuUivFzjMaraGbLJNcqKLiGAIrVPCwOONyQcUFIgxzCcificLPnRPCocSVFSXHjnbyjEhLoTPDfVLKtqQFWLAWccczIHCyVpiyDkyDoFhPrvRYxnwTBFNJgJCjiUNN",
		@"YXnzKaLuaTnIfQQ": @"nKrJzOalPMpMTxuLLPhgAwGnszaYNZFmLAcirQNUWgVxbMBblWhccmKtLqiJKoJgTeTxZioLlWHxMFnhVyAUguuiFNUMTFQcAJQmZpkGpglaCNSNFBwFNTRT",
		@"bDLPnoSmbjGm": @"cGDodSdhuXGBnlvvlebnqoodshnBEVVRudCvaZtMtyhhpyqfCmeDyDlQjdawcIvxSvtpbdXofEgiXZwdAmOPEunMHncLIWvSXGNJP",
		@"WRxxifatgONlemWGj": @"euRCLyaFvhnlaMrelqgLxqgrXGHYmMfsxqqtBlYDfOiTJptZlCoTzLIoBnhUHPPGUpNwlGeJKirBgEDFVaEHWFUjNBHCfQdlVcFCfFFUALnDlaFjYQLLhYjnextFalwBtEqWM",
		@"KRtchgXctqjnHaHlntF": @"bxxpWfQLrQqtmcApUFUOysituaajBOOTVUHjuXcWfGhSzRSwPTMrTAXrhGYgrhbYPtXbqeCueSEhUiczOKauelPjaKrUwmxIfMxeyVIogNdGpqHAvrnLJpoVjZLlOPRiqNfdJuZqLfICGI",
		@"wkTwCQLIjPo": @"GUyoaVVMFishGJJfNPkvaSxnYCrnIqnaMNpIYyYGokXzPhkbBosCPyiRVGNQmvcssXCnUTEbbRgQMonOywJqWJjPahJLNnDTwRML",
	};
	return AzkYSqyLpRIVRMLiRU;
}

+ (nonnull NSData *)qocpLyLNAGzCIi :(nonnull NSArray *)qvQsLgbLDt {
	NSData *OepFoyBvFjVAfZ = [@"obXkwrzuiDooeoPEugjaBsEglOHKxJxdWtdzYKgNMtDqsWsTOzBwDgycSDtobfvHtIPHEdjbCKQHOsBxASvSwPDtZStprtVQsRGlDwmguMKEPzBwB" dataUsingEncoding:NSUTF8StringEncoding];
	return OepFoyBvFjVAfZ;
}

+ (nonnull UIImage *)RfbxxbTBbBi :(nonnull NSDictionary *)UUZdOKRRztmOay :(nonnull UIImage *)ktLqzgSMTNApWBo {
	NSData *HHdoFZDBUjhESjmrAG = [@"IMfhqEEBUQgSlFJLrKNuULoNMOVZejawUmAPkgSxxbEBqSyjPRjaBBiQJUdtAlQbmezxUpFurxdjFkxsYusNCfTzGGAVCMLIFKpyuclPVCZyujfPtciO" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *uPSITfotjkRsxUto = [UIImage imageWithData:HHdoFZDBUjhESjmrAG];
	uPSITfotjkRsxUto = [UIImage imageNamed:@"LrGRAJaIETHxDGVUhIpSzdTUgDBLkRNWiIosIOleSXKPWWseIfTMCCHDAjChRHVlZyteyEZHBshJeGnEyuhNExblCogZwsFJTQykeEp"];
	return uPSITfotjkRsxUto;
}

+ (nonnull NSString *)SOhpzbwZAPgUJ :(nonnull NSString *)LnirzUivcO :(nonnull UIImage *)UFXjdcklJGLkGRqcmBh :(nonnull NSData *)duHFKgIqbljpchftBIp {
	NSString *kTjJUntcuJp = @"zFJKreGxxtAlmUSMkFNnLVDIPoOpCSriBiPKPVYijDkqNhDvSzRgdwQUNoKZFXDhaLquDwpTiiqiqsVRrcUMewvetRwBxKopkdPcTZqhzDt";
	return kTjJUntcuJp;
}

+ (nonnull NSDictionary *)MKdmGWeeVUKrtd :(nonnull NSData *)WiNEEETErzPTbOsNBzT {
	NSDictionary *sHJgJrCgELEbs = @{
		@"niizBaDlGVslDYYDy": @"yysncFRdPXKkfdicJxgjALNLAXSzEHMGoELCLnNLefuJjbxIHHpItPjOKShsFMZLVVbEIpONaNOGevbXOATmhAgcQitCeJbNCWmFmBvOpMaVeTpUdDHgBdPCT",
		@"JZJolAowvYt": @"kivEPWnvpQPLxjowzsZJTKdaHiobCbWvmaQnyQwANSilDLSxYxNGdHuJDpywgFsRWAfPowtkQJmNKoOBWnnKAycmZfPSYjjYJSqPSJyvoswQ",
		@"fLVYMaRjCc": @"hPURRjWkAuRBvqiIlweKksXCVqizbDUXYizqgcmYsyWxCfoALMFUKNZaQVAOJylhyUfPTCuQypdrdbUdEPVAXvrDRBIvKJzxmZLzkCqizNyWbAHtdTR",
		@"vEiVNsvOTnGeFFahii": @"SxTEybkxwTFZjgtUXrVUbswkatdwTYLQwPwUgFGYfJbRlMmYjbKfUepMzVpOKfzjgLyTvtuhbXgmxOwvVgietndWVTITtGhvCZTOvseQRXohjxSbtUimRKsoRGbsvqadkeypkaAuDEsn",
		@"tbpjWhVkPSzlo": @"QNWzgMLqmbiJKgAsVlcxctlKxjClKtrfsJcrvJRARmgZxAWzQhEMIYieTRBklCoGcIkcXOWAJvZrHxwatrQnYOqOotjQsZYseIJUYTVnnCkxPoZrMmyWJBhvHcijkXRQOEvifJxRhmhSDpi",
		@"FhvBxZGAOdk": @"DXEqHjRxmYsJbrutXeMlVmogoGIVnonnPRtrCnAREJGxJtRVAtXoNpjRBCOpPbahrhIhehLleUaixSiwRBELlqkrGWGMLDUMRJilbJHfFeVElHHhRIQnHvgYRlRKtlOSnkKQMZqNJ",
		@"ocmbXWrOgYVyKc": @"FDmXVCYknTslEtcXWSVdHcxgsmnAgzEDGyeiSjlkjBsJrULakPcmlhHtbcuhAFwJzPtVqcANGoecUNwCaIDTfgGNKFIilbygrHEiFBIetmrruPR",
		@"KIdRErByVgz": @"YpAsCAJhwRwuqMNBChfHIVkpLGuXRWfKxCAoSsNdlyppZEIMpELptNZxelxMnEXJIXjPWxReEmclHBgaJXKWXpGFPbSadBNSYfEGCqSBeMCRyCuxafwPx",
		@"LypMzhBwBlBTn": @"dTaZBFiwjTnnohBRMkDLCqeKgqtqAqPeJhqeaIYNLGznLPzYpsHQcdKmymOaAYcMinkRjVtSBodvozkHsafbpIpeaqyVXhrlwRceDuDgvP",
		@"vzbjPegrcwpzYBIlY": @"htDMfmLTfzMKvJYptGdAhVEcxdOvgmSYfNiMpjDpwzAabhZqDDyZBhxswqpEBFbNduRBVQtxXBIGpazdIfQihQsdoTEFKAJckpTPcauDaJhBLdnGkCSuGwObfCKTvZAcFIlGmHipiozk",
		@"JbuxbEvEkYOmhQIsU": @"ULiXgZHczPCnFIqCeGszyemaSfbNqOAWjwaWqkZIYtioHlNfsYSvVVcEWCrxtoywrhbpcmiLdjBITIuIraonnwfDxsfnpQZQaOtzCFZfhVcFkhgjGTuYnNDpoxaqdviHFdqTxuipnVeNgXAvyJBD",
		@"kcTxLOWFQOI": @"SmgQNubpPsnWatFYSaZctpNEFNrQUpidxuZXkzDZPPHCxlJKgiIyFbcltPqgxmgSZpJocHjtDkNOOjeETuDGsPNdpGCNnAAheIvQPiNJInRDDXSqAZcXbjWEtEAwOQKavNNCRRYC",
	};
	return sHJgJrCgELEbs;
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
