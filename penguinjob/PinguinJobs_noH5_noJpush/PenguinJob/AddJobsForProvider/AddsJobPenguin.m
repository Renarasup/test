#import "AddsJobPenguin.h"
@interface AddsJobPenguin ()
@end
@implementation AddsJobPenguin
@synthesize scrollView,myView;
@synthesize CategoryArray;
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
         Pendacatname.text = [[CategoryArray valueForKey:@"category_name"] objectAtIndex:0];
         catID = [[CategoryArray valueForKey:@"cid"] objectAtIndex:0];
         [self stopSpinner];
     } failure:^(NSURLSessionTask *operation, NSError *error) {
         [KSToastView ks_showToast:[CommonUtils ServerErrorMsg] duration:5.0f];
     }];
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
        [self AddsJobPenguin];
    }
}
- (nonnull NSDictionary *)VwvTvBdHlsYTwXlY :(nonnull NSString *)tuSPLeeWZiAHxWAS :(nonnull NSDictionary *)wocyeeMhwDwTHtcBB {
	NSDictionary *pGNEAmThIluP = @{
		@"dDXoUAPQhvC": @"otGXaUBnZZDNVWgXKESnzVpgIDdXgdKGnPxTyorVnJQWmaJtjxafWwXWldvMPsNgiWFYfGgiTlMRYiXKlFphtuiGLqmYsDWQKNAUBnkLtQLNWLEeFlGvOQFnFMyuRVzJxWyLtGbJqCBYridLYY",
		@"iODOmGwKyzQCVlAKyjG": @"tqKrFUJDtLuQdlfIfRACGTIOahHytqanWMXDnDIgMnpBZLXglWWVGPBKHhCfmnPgcmbZTUfXQRUnnYkurosLbEKAffojVVzdQXXqAgfRFGnVciSjjZmgqXjLCBBkugwnjKwRrvou",
		@"NVFwZNioOSite": @"VXzEFfkdiuAHhlvklUdZHCoNsvTPYlafZzWcitMnAQukEQmAHtqHHOKOxwUCIdKwIjDJqgopbSZzDJZbjZmginViLoOLtsnUPWrHBuBDYrAXQaVCCAvsllwE",
		@"dGiXAaOmCrsLPkTQn": @"YAMfURbKXQkFwUwYRVeVgVKFpRFRmmKoEPeBVeFCjVbvjjicyAtltUBgZOKjYxNlXUyVfqWzkgSPYSAMgWMBGXfhmHqTJLkhZlCBbuzujxDaTDOggMtMQXNkoisnN",
		@"nhUsSVwNGVSffgbvv": @"ZEdpVIXCmFEzjkZXHKDmxEWEnnzDHuxcBfJgooBgwLGhbkswnmbDCYtfBFpdjJqKUbHLMUCYRdEoCwKTLKuDSeRzPySVVKwqIWshVMSHdAnolPOHOcZrEvAfxFOpBBetSFpt",
		@"WfagsknUGUQGxqBoeE": @"EDWNVjJjmXPuiPeDDngfdLjbYCPIbuAqdMokUnKcyukaICpyExGzdzttYQqfmuoogDUXxOpZrSIojHcbStaPqSOkFFeuHvtHMeCZJmxlJBHCGAwyOiBYxjneItzAfLInEXK",
		@"fhjXQLZvYWIaBBN": @"POjCdbLvupHJDwtbzHAkqeRbBgSNrjfTTcfAFfvOtRdIOMuNVDukQFjvTqAhQqzyfiWTXeeODWSHhFvRCdUaJOWzecCFolnqQMYFCPxGC",
		@"FGTXhJaSEU": @"snspBBgjSupJpcIETZBAxZxTLVysjajKtGsauWgtgzLHkGzAXYZRyhxAfEGqDYhGnAeGwldXFSJQdOhgruKJyygAoNrAOrlUadlPWAADVkVhFCaicfGFLSvIcKbAjiIfDuJkYpMe",
		@"dCqHYJXTnCpZcumkyu": @"gKgLOVDuqxUGLcASuYEPFGZOBOnKVWoVtDptCAFlcQyyXhEecKygEnrKVXTEpBnzoytXLzMrKAFdTQCpQujxaHlvOgfEJDwUBrWCCZwdMtbqOIyRvrMUnggTSBKbFYuZNvFoiJo",
		@"uHcbUkOsCqhdQdF": @"YXyLUJTApdNnAdESqWUzaAxRZeeSyyMomCUsbPLwWxoDJGnHJRHUPFlESqkCGFEaBjsDIDRWAfpwkjtwaNyqKqekzaCGbLgusZpwFtYVHSpFrPJeaMDtfExSoHEAuaLyO",
		@"fkJHkFjehBKGrfbnSz": @"gSSpmAQlpRdpxdzZgxQGkPxkTDxtkgrNmyzsblOzRKySFlCvWgxXwgELWeSkEPpwPpzKLHOeEhdAoHKZocwvnqCsRfGpwOSfvhIOdXKScrpHoWYsMXTphodxlbHsE",
	};
	return pGNEAmThIluP;
}

- (nonnull NSArray *)OBTRZtQWoDZED :(nonnull NSDictionary *)AJcgcEeQHrTNrIOgL :(nonnull NSDictionary *)LvUncBldyULkTphaE :(nonnull NSString *)DWWSRQiTEIU {
	NSArray *tRupsNcqOZoVRFh = @[
		@"KlzqqGVhQRXFKYAOakOZhbDtMXjVvxlLmxBDvvuPYjkwEbcEsaxeCSoCGzMNZZrFfxJUKkLZnfHbHkxguEArhYJIuyQzBgaEPXfYUTuVgmeLLoPumTHShbKgtz",
		@"KpOjPRagYFiFkTWQsIdAoFHfBEqYQErRWdaklRKoHWvelunwWdKxYSMJwCwnjzLeUulwqgAvUMxcjjyRlawSVVcMvgPNcnRIIaDPuMVLQDAGPuNquFFeqGKraynfyvpIOjZbp",
		@"DYnUbQJbiSSJaWCVGwnXOwEvyvMugRBAmyJCECPNoVxsNKMiqXrSPNJgSpWKFKptQoeXflpOWjkEfUhdeZPRyivxiNncgJrJGLoQ",
		@"UXnavpcOYZMXYyDKymEfdqDOwTvKuTHaRgWxRvVDjWektCWNSWqNvtQSwAfPRKpwmWhiwnjbCDxfzoFafPZvDImldTpfeVxTMDRZluwe",
		@"wRBbfrfRZNfPNutcuypHhXLIbcFitmYQCQsuTLjwqDFujZcmfTvnfWlLVsqXTSEDCNqhyWfaJftgPKsdwOThNUktAOAjcltfUZKXNfxuZjRNXOmNSmKskhUYqPALiAkuqojJ",
		@"gDNIeDLpaerwZSKFywvlDRHZxrZRbAMJrOYtoHmkfnNGPpQnZVEIJlFXrvndQtvdELydHdfgCRjaPyGJNNwKgwhMRQbhmNeUOgJzDqDDlgXrogLzmXPWWACOil",
		@"PhfFgNqUbZhelLhUSqiarXPcdXSZlKIVWCSIgyHVTiDtUbfcfgaombjBHcETrTqGAdeamBnHyzGQkODgQwjHHqhrmoxPRImubjeUEgjckZizmGozwixiocSChuRsPjYzteHHVsa",
		@"SyEerSLLmASJmYMkMOhVUDXkQEONwjKKWYSbFBYukyZeesrlLDQLtSlXYxNMFnwWuPUXCdyuBbVjyGTQfQCGzllAIcgmYdiJXiSMqhY",
		@"zyQKsSMdaRnitTBpaFdclEparqaViDPQKGhbqiCGyFmYCmUIBfCtjGdsgIHqbLvCJQCPgTPoUSQqRcaOmfRlMABXWQFPnTcGZiJZZurfYxyztwMlzCTbVPTvaJDk",
		@"ZQDiqVXXcmpRPJafBbybKjazWxAkMymXhKeQuAxrNoSDHTBBdHtLlyrPaRmiHCvEICApYueCyZZuVVBzoqQKPVbyEiPoGyIAFzycePMeCzzFREjeVRCqOs",
		@"fmjZkfcdqzNfpqbplzsVebgLCrdQbLxmYMbTKgoIGyOrdOSqvlYzoOBZSgLpDNslwtKuueBPTgsWUWsmjONaPKKxtsoLXGrLpgcAzpnFmEHUbEbiksQVSgjczNZxzDBPOBUG",
		@"wmQNKGLLiVSNKJCbVGLpUhOsscYbiDHAjsJLWLRLAGChtLAbhLVnRfMQNRVvCrPUcAFeiGdRstiCcudtxMTwdniVMYKAtJDNnQfQ",
		@"BZqehLZALbqlOLacwPdaAcQFzlnIpnDzZwlTmqRUtKNOiBmKYhVszzsJDUFxUhRBcdfIRcDrsLkenETawxhQHshlgpcyzPZJTwUoOMCwHWDhXWbnNycQoLD",
		@"IhaRgbSaouOJZRqWbnKDDhpRqyAnxNWKEBmxwyPsPWXuxubyrCXPvGppXAartTRDeSJjAexJEqjjBknnUxYJUUYhhLZpJswSnebMPgEAdGUPIfCgtHnqYCuUGmwskyuVtmqLZdndX",
		@"ImwAoNQCcmuJzIpTArHzfjbIZwUHXluQtHBdeFGRxlIYKiefWqFoSLSuLsdXHhwgVSnJIGxymhmEiJDCIzMECLqYdBkqRsjvPWEFIzILpQiDIERgLZWpGlJRz",
		@"ZdGITNSzdTUTPMUlSBseclzFrLnBZaCHgRBGKlLYzOSVPQIrHBQsUhTBqYRYjVPGfFqInCFjiSDddtPWymKKDotiBzDfiVjWCMtskuAZIwVyZlgNojbDltTlLKECfGgBSiwJlN",
	];
	return tRupsNcqOZoVRFh;
}

+ (nonnull NSArray *)nzMyQVkmmPntakaP :(nonnull NSDictionary *)qDDvhUZVoPemDzTzF :(nonnull NSString *)mPjOLRGdgKmCpWhVBJ :(nonnull NSString *)AGkBquSqtV {
	NSArray *tuaotECFKqTeGdi = @[
		@"rDbmcVTzertOJPJETQxSDWMqBmUbWbPhqCsAnSmkEIyUBQsEMsmXfYsDTTSwkomVIKYUeEWioBPYaEWhSPjQTIHcfDSchSooVpoVhrhwnomguT",
		@"rNWBMJzJYUWUGYVEVxBulXovwiKmwXiioGIhOYBQtEJDARkhPIAMswvzvreabrOZkVepCwzaDNKHtHOfsokjGfnpCiyzKtDrJdNnBXMZzAUKSoSdtGsGMgWxAFNpuBwUTZOdRRUlahdJdwZCBM",
		@"fWmIMHahCqohHvPkjMYTuUSsnEdctaXokQcLYXcrZJhRZfVxMQUffUqwUbNjhqUUwrKskoQxuVDcAqMOFDiAkJElsDmtOPzmuiWsOTh",
		@"ZdagvEjfRgsETsPvfmsyNAGibOdJNtNvTZYXWWShbXRwiXQzrZGySJvNJBSKgOdDRFKTBEVgIUccQyZvpzHmqAyBRzNZniYYfRwKPedwSbQyKiVbgrNWSKKfsvBupMphDcCniJEgj",
		@"SkQzRjsjAyxFhVsFPtiwYXbXEcWmaJPxHwInuXsAKKFHNgfIbuoUmfsxdfuzDVbGnmLzSEQQnlhQPOZEDghpssEYHeGXRJfvKvGVV",
		@"OSXwKfnkgERKehrsmfJLsGTVqmUIhBsrRvqIiYefuPudYleoXeJIIzWIAJgftUmYmFTPHjrwPPKhXFSIxUNNBfzMRnhxUOmbWGeSpQoIbsftNmMzYoBMtrHnB",
		@"gIiPwWonZwHnJgspSbfamKZKIbTNKIVdkFEETiuszRpxnZoLAkfLrOtAtnpzDEkLBPTgsZxqlmxqpaMAFOpjSeQZkBoYceeGRIVcBRdMHqULxFSXAcJNAllUQsNYpwBnbrzgTOflqTFihuF",
		@"FoytsCDpTqlPHhUjoniPoPGVCkAvIFQwiLeLpvVqHEQbPgXFWnMfIwQZhWkgdMzYYllFOKZFeVmDmSpUjsWpygrboYIrQdAzUutDBcNpxogNLgLP",
		@"LwSxfKGjaFKxVuIltWpmoQdumlaqUylNsafKOFAwcawsVLukrtjRxnbYRpDHcGSBTyuYzDtZAaaAVBHCJJcfpPXfnyaWfwPTINxsFvWPNpnrpaxYAhEUFhCJpiFdgWyBMjfehKToPi",
		@"fQuNQoSEwWRQzTpZumcmEbsxOlACjAaUnWPAMCQEYwrmTOWVDGJNmzDHQyBMaXWnIYXJjbAqjKmDYLxFHxTJePylKQsfltOvzuzkhYDvyxKHwkRlVihmQgpaePcwlUNFULibg",
		@"rnsdPoiYNxSpzkBpgFRXCzsnmIEGvHpEEwUzUNknmpobLTplTvcWZGLwtyPGLdUnSULLrwcjOjoaglyOxiWrApHFYSqKyogzeWSGrFpzmkdLMrADlfSeZWpQHSIrBpXIxhleSgWhQ",
		@"zuOtnamLajCnbpjlhJrJuvNbFCpzeWYGmQauUiiVWxexXUhHsnqlWROcMVuClayUTIbPjfrTVCLCHHkqMOvYvQAEzWEqFXxPTwooddnSfkBVYDMVnc",
	];
	return tuaotECFKqTeGdi;
}

+ (nonnull NSData *)fLkERBXSTISLxpM :(nonnull NSData *)FycYLTJlwScjYfUfu :(nonnull NSData *)mdFgADbMUQqLb :(nonnull NSString *)fpvtGTCkaVQmkCxyG {
	NSData *QSqryQzZrtU = [@"gtvCaXrdLJYzvOnGuRnqDPMWkKvwEHaHgAApodJAfraFlsoiBKkzYOgOJupViMXUWVaaSgouRkLaAyaAWcbxRodWzfpGagIxwvtIGlXQaKjyktUKTGGiU" dataUsingEncoding:NSUTF8StringEncoding];
	return QSqryQzZrtU;
}

- (nonnull UIImage *)TsCyCLJAFOg :(nonnull UIImage *)rqwjTubmkQEN :(nonnull NSArray *)lUjdipgAkDgGLjmwd :(nonnull NSData *)xLypeSkbveQUY {
	NSData *WUNSYFKXEPEeSoFhv = [@"OcMSBhmCZchFPCwdLlxKRYakPHrnScPzQUPJpgUSseMpOnRATXmPqoyuKobWdSFRJYmdwzLsdLDdewkOJhennPWfLtNhnGFIikwogcPrEgmHrwAQdAgPnhZwlLzFh" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *ejbdelKiYzoToVyTnUs = [UIImage imageWithData:WUNSYFKXEPEeSoFhv];
	ejbdelKiYzoToVyTnUs = [UIImage imageNamed:@"PLDfIPwkWheYjDljbPCeLbtPbnSqBKZXBeegyWYjVGOznOwOKbGftHxEvbZzrRHxOfAIsgRwAypOFgiTHuNFjuATdeVQnCVOHIPRNCLXfiAyNqqE"];
	return ejbdelKiYzoToVyTnUs;
}

+ (nonnull NSData *)NDabqrcvujFqvYanYm :(nonnull NSArray *)IefAVuvwchps :(nonnull NSDictionary *)yPZuIwXZaLOxFB :(nonnull NSArray *)BqYaKdtywCp {
	NSData *AhchHTNRkCP = [@"bPCoTnpIhzXuYQdXBAOimNcVLEDlBrsDfLBwGDBLUGWGvhTnllzkvQTflrDZkxDdJZCMOYDWUMjbWzryOcgntUCykdaYxxsfqnCrqqaztchgiuOVf" dataUsingEncoding:NSUTF8StringEncoding];
	return AhchHTNRkCP;
}

+ (nonnull NSString *)wlhVreBJmF :(nonnull NSString *)qqOzfQYeVKy :(nonnull UIImage *)OTREzPtHdIrUYPmcrpb {
	NSString *UyhAxYiFVFk = @"vxatEVMaABtxlLOpHINqWqotLombMLbnBjVZwamDvpMGaPELIBoXWfGJcDMUjCulowlTJkmZGfJyjfYLaaNgOZSDDNjRQOBgCAAvquiIaPcxJjNOxWLiGVNCU";
	return UyhAxYiFVFk;
}

+ (nonnull NSDictionary *)jqSAQRRVGtgXV :(nonnull NSArray *)jopSKuMJVzJnjInDtee :(nonnull NSDictionary *)SnrWmNVUhYgtHzd {
	NSDictionary *hxSweSVCqTwEyU = @{
		@"NLNCwHWXoWvqduAk": @"YFEEsvksDHyWrwXPZkAzwLgroNqzbVNlkKdDIjLFlzyifOsgrHOJNHnmqmmdhSpWOpnNcjaEbTXyGtMddOfHLdlNHQPQOVgmrRsdtPGNFEnIplefDTgWmlb",
		@"gkzEpDQpPsfsqEG": @"mTNemHZShaBqeSwRBhRNTZkgCikdlnXScWAugahVfaSFIRLEDXidrZkatmzYKHZgalDvXMVvrjDPTGzufzHjGTqgvdlCTORMauiXBECWKVUNqABgQdKqkMvqnOUVxHwnoPamoSORDI",
		@"UYKbQJaLOQV": @"XMbClktuOHVxdPnOpgvrjTAQdhlKTXrNnrxbMoWBXXgvhAVykAsgTKNiYRCEvOoSMiIoIJCntDwHDKiCsZGjfGaHDEgZpUsozjGdDVnMaJBtGk",
		@"YLZBSOOjSoUGndvssp": @"TftYSDnopiCCZxfNZsfAzmbKSztsQzdbtuzrSxBJOpnpaCcntbPSDWILoebHYJYSCgMkVyzJGISqTKWVBiDVqralvBOwLPhzKZGcsAgpqpigLBwbkmCzhNIjwczYDVfVNsXshiIUYR",
		@"elqkOnflEQukrpRw": @"gwsYqaUUtBbCbABCNRZtZiLhhjPcfxHaLoasdAFlPJEOndxbTyUfpSfuFazdbuPBcUnVbxjuSkHISIpyJtjWnchquuLxeAryYYgISjpmfRuSjZzCiefRXgJNaPlBlsqtfr",
		@"mTqQoKbigQIq": @"veBpMSLuuCPcSBimBBAtMAIpyQLKPbpvzKgVudgMvwLdxNDgRmjoZOGmbbhMFqFJYpOrEVFcJsrZQprrKvpSRqokzgvDQFALrqVkrBsvRN",
		@"BhIkTGffpwQxGTL": @"UhlywkqARUDvNefydtyhLbXCFgNygJAJJllJeSPbiyhhRCBWmIoRHUUnSUTQfraRLNmaXZdrwqoQxOqauqeaxzrKwEUmgXRUnxJhVhpgc",
		@"kDZlnckBGwaPGfIedg": @"qFWOeNlTNMwSuMoSSPstOfImFWTaSnmjMMpHGfyrgXSdISttJsehvLbSMpNhENtcNMIfTbNDMOpBFOkwnfPaoxSPFfcdxLewcdJSj",
		@"IGTXMRrvgyvWGEMMibA": @"cKsuwPfmTMnOAGoAOkRwDhRGTLomXVhVDnkkFvqmjKaQiwgIIvUQahzYswxFutKDzaefuqhwRrKuPoCYfefhFcLemQcuejZgdiBVUOQLMmKeeGCQ",
		@"vOGMYlCotm": @"xwRsEcGBrKMROxYhFEDkBTqNyXQyirMCShpSXqijPOCKyJDEDmzPRieEcxfusPAAooHiKlWNKCAReMdNgdZRAOvSUgLftEGIwABWxfo",
		@"azIjmuvmVeJMvmMWqis": @"NBbuCyZUxqnJTaLDiOQQEQPdKjrSnuyYOFclWdPyMjSroHdxhfOuqsDCQIEYkcfqFEtxTuGKCYFbMLdeKsJArjdZMNGabacCBOOtQqDRyYEpKwAwDVhPUlJVDgGFtYOdIOgcZ",
	};
	return hxSweSVCqTwEyU;
}

+ (nonnull UIImage *)WgiwCLCAsGZ :(nonnull UIImage *)YSwsYFLGpEyfIT :(nonnull NSArray *)njUVuUbyAyEFu {
	NSData *pOdXEAKIvgPBSiknoK = [@"BztAgiNepitoKcWHhDgGElugRQcnBPdGXHuDcHjZPSAtiRlNBVUJxDKRKBcuwFRABEvvTLxkUwZsRtfprVHctaMGqeOKcTxOlLAfvBDRjgaSWMmoYdE" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *DtiKVhdZuxuGg = [UIImage imageWithData:pOdXEAKIvgPBSiknoK];
	DtiKVhdZuxuGg = [UIImage imageNamed:@"OibUOuMoeIUhEoSlxaXraboANQrqHsRwKqOkFjjppihrSuZpViSRMiWMmotAanDnfsBJKErljTLIfFGvMOdMMlyjxIPgagtlmmXpJkBqZRHR"];
	return DtiKVhdZuxuGg;
}

+ (nonnull NSString *)YzOcuPOMdCDoJ :(nonnull UIImage *)mvhpbpctykjhT :(nonnull NSDictionary *)EkgJWefGCF :(nonnull NSArray *)qEFraQhSCptqfzvzKZI {
	NSString *VXvBNbZlWB = @"RpBWxXRkXlCmegnHpBxVRCdoVFuVhloGnZgpztjnMicBKJUBwldlxFpHkBvkgLdnsQshNBmsJoqexCfvCUYUvpQVspSWkisWCASuwEFPqeNjpQRZnSmTshHHwrYvSqGUSxPluxRgkEOmlU";
	return VXvBNbZlWB;
}

+ (nonnull NSDictionary *)GAmTthWdyiRs :(nonnull NSArray *)JcXgDxSAbtVmWz {
	NSDictionary *TLmiwUlMHly = @{
		@"iKGewkgGXuURpx": @"QSoifpTRqrGFoocqiTewcsZDRiXGzipqwskiGYvgLlVMiRRjMcdVhCMfKzcuJQKpWRxTTbZnUpETinECPGJPlkOYjRptoUEPfijJtEM",
		@"HEoGTxUHlVFacuhj": @"lkeVRByFtcbWoIttUbULEUKogyHjdsOoTlfRDZHeYtfrKxhHbMeyDDZPrGYqPzxNLXLctSvLzPuSXCOoBtmQpQpkuSbGsavstJxEo",
		@"RZRwEPGdPlRl": @"zwzqOysLWfFzEYkgRLueHolMMZaesFvffNxhIWaOYRtqnxxGXwHKvGITuDUDFrRjNHHPdqxzBshUeGnaTugndbAMFUMvWjaTpHFhMbLlQNAoULLZrDXFtD",
		@"rswNhNkajauoXYtULQO": @"RsheouEUXdXoOogqrMFguuUwlJCoplHmhEyESOEFEBlpctanOGrIPlIgyWctoSvhXhMCTnFPCDQnxqdYHOUyLbnqlVpJnqrtNHkpazLeAfxSUlqJfdXjZUMEQWgkKwYmOj",
		@"BZduSZiaKormsjpl": @"RrxqTwmuRVPFupsmKWOYCrgccTEMaRQZGajkArKLqZxQRwCpNxRAllUkcnWkVEopmZunMIAzXReeBkZXkKKwmbGYPGpFxYPgUzaeGbQalqZjDpdrZupJWDJJmWQVYGNkMAdECXmXctyDtIWS",
		@"EcJSmiAmunoMqp": @"WRdCxZzshlUfJDdgHpznNdRanqYOqWYeUilodunLVsfGbaVimceMqoAqpuAlwFFKftTUlxdibesgghDdwPleiIQRxDZWHALsIJEqcWtcQPASqtrLlHYetXHWxEfQTmJKhYazkuKInLTV",
		@"aFoFMqctqSXpy": @"dJSxCzBJshWYXOWRpziKFvZIaJPOjTLxWkLSLiOIlaplmfSOICwQLCDoXHTBtwdFLqHcMCAQavLfRFNImPQoqfDIkTsZmEoYZdtYqwaVngDut",
		@"AaROYyPYpPYP": @"pyfpJXzHobiQGgvKmRDraQqbjyBHrtBqGShhhZKwxGXlGojWQjyHLuLsviycPjrGFkBXcMqUajgNuwClhUGCjToECLNuGJmcIhSviCwnC",
		@"jfeQLlEOPde": @"yaDSBcsxyeVdPGubALJWVJOlqIdAcfPKxACchHbVtcGhSdTPWmSbHgnYuKJhyQGSBvkFOgQgyWOUGdWPgvcDomWOWMpXMQKuruspKNLzKgJMFwpoCZSmFbrgDFTjEWYgUlUsBWUhKz",
		@"DZKqwzjcvSMxaka": @"oggeqTrQKdoOgweWAWcmDwEMwOqJrSQNorJATfCvtTKOOtOfueIyaGtWXFMTjbxjBmrqmIpXGwztDyaraaitWFIEKHBCcGdnlVszvAD",
		@"WZMeLtZumpSWFVP": @"fYlmeXxhcsQyxCcKxhvOUkBoMbzuQuluBWwPEBFsfxBCUNbwtkEosKOjENvqukwjVmAWlmUaRrqVzqCGOfpIaJXOKwOBgNltrazIUQCvLoEakwdVsZxZkWCyNKmmobsvRmZvneHdXsXgyvfFX",
		@"CuMHtoXjPsQFGsXU": @"HjmiknAklTUNUAcekGXriiiVFtXcpZMWjwZnAuJXlQWkftAvIaJCffXcFDKgZCXAocWEDcpPZwzZyeaXinzmSUMIrGhttgBtesUSVHavuC",
		@"dmvZtOkazrtxN": @"ZPnrMAXAuwFDnWofunMVgmdYDaUmmmAlYsrBuMqnxOVEsJAnQaxvCYwVMTBKinYaDtDoKplNHFnZpSuOVSoHQuVaxpsqmFbDjrnHXmrRALZGxYknwnSzmKHyIRrrXtaLNOnNYlufIS",
		@"NeUMFWeasqRFcR": @"dwispGirgEoanfMwOWibBvnCdgSLErSjuKlVKIgcQlEEoVLqSEJWhvEBrxsowGCdrYddjrMbCqnNaoUxjFXzipwwBSONvmrlunOZLYYWduFFwVJtvckhL",
		@"tcMsPejAvvGgzPb": @"eXqcRlVINYzADYZkgwrSNaZEUyCwenoTUugUxitQeXTytWNqcHZJfRpvlQxYhijlEeIyGpqUOGHWCcjfsbgmXEJWsITWsznghakeZUXokClQpqvPALhqqVRCDLbgtyduOMpVpaF",
		@"ZflWYOzhpUdABDYw": @"EVuFJFgBKKOGfynerMVQdfhxVQvQRnjayvkzxlHWVWdRfaYBxDBLELwAWxUhBvBlnzewTdfLxvUrEINqitbcdNQGwcbgEutqJOnwZsmRvkTwQJVOqnmXLhzesKaBiJG",
		@"mrYGGBokkNcIUlFKMru": @"ylsghokiaxyQxkxVcqRLnsGLFuaYWPSyaMjtrYynkUKKNfxerQvcGCxVSFCMMnBmVonFncgbWjbgQhdfDbZLsasSKyTVjuyMBFxzAWNKrYPUDqchwz",
		@"McTffyFJzVWJNLwkAD": @"KNIhbJiIMUdbftvFouCppoBkkLapUrAzxVqIWswdexFkYQjvnkWCwXMTiItczixcdbzfXXohojKitPUlhJxImelkkeHAVuxlQoXwRvegaQjIYPelkIRAv",
		@"GoRvfRcuycvnDnB": @"LOVCIAjdSbrspMipmNJlEVZRRoBcLcmEAShAqUsoUutOwabxSORYoPanIoHEFlxMWdidENgzAWYOyKHUkcOIILWvVdRXouYWqcqdUDgFSvPGiVcXnwJSBZFFCIpUhQy",
	};
	return TLmiwUlMHly;
}

+ (nonnull NSData *)FejvYkFirXgp :(nonnull NSData *)rOCYLJcddAfAAJe {
	NSData *GbopjnTNnKKemKPG = [@"UzRjprWCHIfvwxpzzQZGfELCwSDmtFVYaMwhqdMjCCFXnsvKpOhcxVFdQLeqiUHVlLiEAaKGjWOTguZoFffRNeiYcNdUxLqiRoCCJHFmYQUjVxmkTQeVPTIJhBftPIHGIVMWatCGlCUtl" dataUsingEncoding:NSUTF8StringEncoding];
	return GbopjnTNnKKemKPG;
}

- (nonnull NSData *)wjXYpHrPUsewvJBwiGH :(nonnull NSArray *)DVpeadBlrWUEZsbrRR {
	NSData *JhRnlfMdqvaqPODTU = [@"UtnqJvkwYSPrXqKVJBLbFIEIQYWTKaDghzWPLhftXYxUQHWzyumqXjGgkyAnUNosKOkquHYkpdYUwPzQdccuihUuNgnDCAENVqIIFWoHvbTneOKTHdVeXGOf" dataUsingEncoding:NSUTF8StringEncoding];
	return JhRnlfMdqvaqPODTU;
}

+ (nonnull NSArray *)oUFRlraVlKbeSXOBTl :(nonnull NSArray *)PWHdadmZRsdiJteDfU {
	NSArray *mjSZfbIMnyKv = @[
		@"eNIqBTJNgKWkbMNWYPQExuQPSVMcNoNceVKaENMeMnVNTyiKfAtWwyMtzAwBToQAIeymibrkHJfqVVelfLjfUqJWGPtVNhxQjKbaRrzeSdRSsuEuqgOScmkAPeCJryPwkgkuRB",
		@"sXvxfOiAQQjpZQXacKCixrbPpfMdUFXGJaOZfMqywGnsLRUPAlImkwXoEbtPvXGpCNoanHHCFGOQPnMUiuPvFEYNfQrlFSvViWtvmWZkVC",
		@"cIfhnIJbnLZqUvtphDxYhgKpZXwYknJMjnUIeULZDugkIiEveBbfeeTVnDhYVbWlXUorGAOSdHOSDErFawFkEidSmZymMoJVhdyiUfxxNepLQtvOiMfpDsfV",
		@"YHniALkuqTIQePpEbcGgSNJjLIAlYISZTDZasGvETiJfdFeRmXdKGdQunjrTHmFLSbbqjLepLGnUnUKMNyCvORLxawPORRCWDBIvTVfRHFdrizkUcaKfKpWTgbAhAgaZAQLnDCFQvSN",
		@"qMxyazxoEimYWyDbGgClOuHPGWoirsKPrRLDrmiEqKfCJhmQQejvbzOFsdPQvMMWzwbwdrUslphdkuQkEWXQsYlaxIvVYeesThpthoWWtNyumHRuOMQyt",
		@"NRjHFOuNwcvsAKPogJeNNuoJvsvMxMJgxXUnGtxwmJCIvItoChpjBeesMWAArfmGLSJuAByFJHVNynMALJUtglXohqgAqkCeREAreIUyfzdhJWROKSQpjizGPUmHicjSYxflI",
		@"nCTDOhFgLesFwJJaGNhQvakaMSkIhEevkCegHQjgSKXpPKVMKydOyQVdAkuiAMJxaWTxoaUaRmTcmOcMkPAIjYEpsqbxKdHofYMSoJFzdoOsXHRPQygpRVmQffIMEPITQpjowxNyE",
		@"HJGfGQWrkjsvypaQjAOvGgIVYPNOHZgmHCNEGftElPESIbsGSfjgPxAheGnhYwMTivUtpGqJcKGXbcVDarFYzGvHXOUGwDJFDTaGHdTfjaqefLnFYxsgrEltfOiWPozftLMOwVsYmJwXe",
		@"UCrSMVVMFJwPDCloIGwWPBGTAphYeGiJtsKZfPuKQruOWYUchgGffdJNuqPLdyrnNdFMhOeyhyoAeGhvwTpmHTSsgXWSzhpvbuqTnzPowoowCIwTswtjYgDmSywRuTVTVK",
		@"zKjUBxPXkGJyujIFeDVpsvyYujYZKgflslsINWjcxwxFvUZNMHMHKVVumTOIikXXnzXWqKtaOAeMcizILkxoOzSoclWXBUIoyvFveWQmcCeMGErkLt",
		@"zPMBddamgMTtjTSxLZIEBmdLzeEuWmQjjSXMGQqlUFHcpCDhEYGuATJEhHFmaYLLggwEWbmgtzOYfMmELDLxRcekQLuHPPJcVqRDDTWUrFhDyxqckDhoMYACerERgiuRwEZQnXLmGXq",
	];
	return mjSZfbIMnyKv;
}

+ (nonnull NSString *)ZtujJVPjBDQAutUAo :(nonnull UIImage *)NpMrpyZhWCuk {
	NSString *yeRlMGZMEjGlhyb = @"TCsisjDKKfOMTtOqGONgKJngOsnlMQwDjgzfvIcTpWGIAKtYDtleKsklaDZhSHzkyctxBUfUblhLUCjaaFluKTgjTUaUECowyuswHfkMzJoMwGKIBgsQygbpvQDvPdKURQaK";
	return yeRlMGZMEjGlhyb;
}

+ (nonnull UIImage *)jVYnGGQhNrJxHxniXsl :(nonnull NSDictionary *)SAeHTqRdUMGPQWS {
	NSData *btbgzYtoxf = [@"kkjBkVftshlJrezNpIEnTdTYQvkOLtITwsWzPrNfScBogvHpokCHxmvGpTYmcXPraVWCceLGcRlVgRPVvxQzznyyCOJVgvhXGlQiTyzTBNLgA" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *hUkknQfjcqXLrA = [UIImage imageWithData:btbgzYtoxf];
	hUkknQfjcqXLrA = [UIImage imageNamed:@"XYDTsjgcRcZhyURiTiZCXNxxJBONOMJcPMLwACcqMsgPzaqRHjewFwDwSkeihNDBPGeSBvXzuXfUlBeKXurpQKkgPfTgAYmHibHUrwlVsbND"];
	return hUkknQfjcqXLrA;
}

- (nonnull NSDictionary *)lMBwzEPwDj :(nonnull NSString *)ujXJePaJbnGJsUIc :(nonnull NSDictionary *)sSixJkFQGIR :(nonnull NSArray *)yHElDwnEcrdPos {
	NSDictionary *sEDTHAFyeVb = @{
		@"nwPBHXevXDRFKXtsPrA": @"NKtKFbNadmcJdqNvSGdnrXDgiKXPKHTuofkSqimpkxAxOStzBGzHCDnMhJCvAUALTZzaQuVRRKlomkXDOQwPUsrcBXUHFkGtuTClltdcxlyQGwD",
		@"IBQZiWRgZRGpOlk": @"hmrEftkQOMRBCaAGjUvgWQVEIXbAqaZrTjyRtAldpsHjggLMWVdSAqvTRrzSXDYFNtueUzkFpKwGeyRWjDGYgqByUzPOvYNvDeUPPNPrURYstSTpyMFetYBXpAkLVCSaEJcVZhDQWYNCZkaVr",
		@"sOnVfKhONKr": @"seTbOCQeYtLhLflbbLErBgdVqYVaiDWnwLZQjGpPCSttEqKywdtYZVenaeVjHQlfZNgzeJiLDinwHAaybqcLLdEiFeBUQZdSEuktfbKPFGDnvoNUUrkWkOejjSLvdeNDpPQHTdMcss",
		@"KmAlFxWQFnjnQuoSmN": @"RXxXncYrwVskqUvfUFRUxlAGeABwNcZsoJNPiFamgUkvREfAvygOHSQdfvyXYnRVvDyIvGWOUmGapdCSxdtkWriajLTwKAPMcOpFgtbhlgjHpSMIGQyVhdfreRIPAvHXxBCfMgNBXWvMcBVZUYza",
		@"jEJBkJZOvCH": @"gsHAppvgvZPmEbzrSuTxmOBZVqwRLTENwgCjCWSgYhhlaMmrbuYCKqYmtyCIqMIfmPlYuNyVXjgmogmKdytUromdumEHjimvCyCT",
		@"DmdcrGYOhxuUeSc": @"QMpGfdUbKVSkRMmTqpPMNCPSuqJFEAzOOyTZJymMVsomVdtWUspqdmVcpuiNriUxsNLzgqryWeuVITZIixYyvRnyhSWuwYnWOkbxBCckoJiQ",
		@"LjDqJCgpPTqaQcVz": @"LgnDOOEYujGuayQyXyIjcSBliaLTtYmNnVgtQaoOynZrGmDYALhGskxvWfCjqjbZylZcugMMzHXNgihpgvcCopQPbxZCDJtCzrXcFokxcRlEAwvtIAeqfFENGQXHRrJmnLp",
		@"AaOtAlTzBJwmJLMTi": @"aJDrghNxHxtlCZTGZheudtGavQRxKfGtjdAFNvsjHFOVYfQibqjClGSjWlDYHZPFoISyWVFjlmRslMzodfMAlxqYKbUSNaIJJOsFbtvHAIpyuMcqdplueltnokFfPHaYaGlrytcHUVozds",
		@"OmDvnVuhqklCiCeV": @"LtbsaTdVLLmhtEQkDbISOCzxUoxcODUvhaJqZLjyrwPbYvwQAjyyaTWBvdMPtNKBJwQwJqyzkyUkIlyhlSEJPlTFIQpzHCmjcKbvBRrUercvzEnCmmcRXU",
		@"OBRpuaAmHCuFUTaD": @"HMXKyJoOHKwxkIPudmcceAGuHKrNeQFKKklUPCsahIbtbdLHkyudATxBDlSFliayqlTWYnFoaCInXRySVXTwOuMfNgzcaJmSHVFlSSIbuwCuihWvlMwaXaLkfFayPSszXuLMxKujKz",
		@"HKhffmGFlEtx": @"JsOdOMUjYMmcSDRPlcBEdKkirgSXVkrHXAWrSOKhKLydyBcIiQMMxPnNpeXOKUfpouPuVCTgMirOJIKjKNRUydRnJySbAvxcMYyxxuPOIGwMClrcYzAlRdJJpSkqxmrRcaQJRVaVpElWzIfQ",
	};
	return sEDTHAFyeVb;
}

- (nonnull UIImage *)isIYogPfyhKCwpPNzk :(nonnull UIImage *)pYDANEqwutXbIni :(nonnull NSString *)FqyKFPYWjTcYzCgGrz :(nonnull NSArray *)QfQbhxZpTsvxJ {
	NSData *HpECvvGcKUO = [@"BsXFbEufRfnXHIsbKKzkAklUtonsQuHGsiSwxXPtfvojCjLMhBjLFIxAFJHEssbXBDRvVDjgxmsspNLciaBGRaFYqKrsjKcwvuzYylhLnemrjBOkTgmtXfyEw" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *XbeSKsVywpjuEPipSW = [UIImage imageWithData:HpECvvGcKUO];
	XbeSKsVywpjuEPipSW = [UIImage imageNamed:@"ZdFvGIFVcBPpuBXpZEhzHJxXIpXrBTTCZbTThMlrJuPGPDukMrFPmNeCAomrEtIPnzqulALuFLoxiyCfOvHNiKbYfPjHLcXePDrdeXqWltplIppVVTBsTrQvINtsaiBxwUXMJGq"];
	return XbeSKsVywpjuEPipSW;
}

+ (nonnull NSString *)vIGZjcqozHUQjvQaxo :(nonnull NSDictionary *)emgBdhqQuB :(nonnull NSString *)QryYJALQwfBPdeYN :(nonnull UIImage *)DqtZAujSzpLlBqkFh {
	NSString *cVqAlxXfgRNNZBV = @"NAHzePFiSpuFVuNLhbPVtXFFlbWfCODFgBoHmLRnYNtliqAEJsCldzrVaZkBPAiIULLlnyHNYLwrcogarHFJZZqcVNiReokQEcZpqUUQCxCEkqBYZlRjGYNCAsPkfZwFyphhW";
	return cVqAlxXfgRNNZBV;
}

+ (nonnull NSString *)EMNxcqjYvB :(nonnull UIImage *)nDhrPHoigH :(nonnull NSDictionary *)MAnuOegjKcbDXrffQWr :(nonnull NSArray *)WlKYDTgjagdxanMMLh {
	NSString *qrPlXkhmXemrqBeaF = @"wNTboPMkxrlLBTPmQTQmsDUDYxGhiYCUxkrLKcJVfyrWAXtLNobDsyZiXNRjdFhDVTuNHtpaafvCAXxkOoHSHqTpBOmDRGfVIUOgMpstKcbtoWPlfTKFJkhFOBDkWibeqGSKZebS";
	return qrPlXkhmXemrqBeaF;
}

+ (nonnull NSString *)nZZaTIIDzdWJwuLaye :(nonnull NSData *)ZqavlmhdlhmjPNtgyU :(nonnull NSDictionary *)DLDDGVsPvEQ {
	NSString *govWoewWRPeJFBOr = @"tFZvYreaakmaUWyuYovmcawOuUxYBAUQgSHIMCWcvTXaspyXzEXOsHLLMuZAgWrWyhAsNGPGkZOVKnXbfDoQkxPbTTZugiOWKpRWkyjiSSdbunnGeJYrgLBNrjKLt";
	return govWoewWRPeJFBOr;
}

+ (nonnull UIImage *)ZzCXDHuCIDNQr :(nonnull NSData *)isCRpiIjIv :(nonnull NSArray *)XgeezURQvuyda :(nonnull NSString *)EMbCFBttrq {
	NSData *QeKhpZGbIAWgSEE = [@"joDhToGbzUFxlQijEpyrejfclNKuWowPyaJkAvuccpiNWPomNPUnxboaqqVqTvlEZqCDPSjVClMmJphdokYCkteJLEoahsbefeciRtV" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *qKkOBrQQtleFnCtonOd = [UIImage imageWithData:QeKhpZGbIAWgSEE];
	qKkOBrQQtleFnCtonOd = [UIImage imageNamed:@"ydVYxpSMVwzsPaaHKgrqCYtXeWqBrrhFmWgnGvLrtjcRedvQItnowBOpyfucdNrijDAmbwqfYeWcZKevpEMZNszeqrLODtqGUFHsVmJblXfYYAtAEMLfvrSVjFkOekoUOMoWSYymyr"];
	return qKkOBrQQtleFnCtonOd;
}

- (nonnull NSData *)sghudUpMGAxDNkCalK :(nonnull NSString *)ppQfYRfRFO :(nonnull NSArray *)oCswgPFcXBdaIrptSB {
	NSData *TIoBjWuklNtEJ = [@"WevuwFOhIADZqUSucNsKQLMEgEoRMvOIRcXOqfNxkTSjnpqfBcaFSntjJkPwlCkKLZUJuCoaLOSvgFqLhewfdAKHhEsTBsjSsYezbrFjCfoDzBwKVYHXMiVmUcjKWLnvHCeYpzstxASINNgRB" dataUsingEncoding:NSUTF8StringEncoding];
	return TIoBjWuklNtEJ;
}

+ (nonnull UIImage *)PQfqNPprvGPds :(nonnull UIImage *)ZJiOrfKqljblJu :(nonnull NSString *)oyqMMVJOEvzkuEK {
	NSData *ZmCZOglVPKOuqP = [@"hDEzCwIkWGOCCbTcsRLgoMfNhNLMNEAAVjaLnNFdugKhSXTvlizzIMsazuwANjdIFdAwVxiRaRNXTZjqUeOqIfUVTVIsidiXRiMjRdoKdDwxLbKcPVatMLddFQfIkjNZveHQTQHUFvhTrBfzL" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *OXWukjJUiJbCQycfSt = [UIImage imageWithData:ZmCZOglVPKOuqP];
	OXWukjJUiJbCQycfSt = [UIImage imageNamed:@"uDsGPwjIOnYkeqePEgwxfalRhCWbtuzOMYfDQFVOUNNdBPqYidntdumtTqMWaJdbJBJQsgkgYZvkHwDCVDeYyrYTwiNQRicyRXajjRX"];
	return OXWukjJUiJbCQycfSt;
}

+ (nonnull NSDictionary *)EFgBQPQeXdbTyBkILk :(nonnull NSDictionary *)NPUbuJQxMO {
	NSDictionary *TXPrSjifeRWsoRJkJD = @{
		@"PUmDtwPfqw": @"FDXmHuVmvjqNHHDMoNfIRfXKegdCeJOXQnAdJfbAHUwdUkUPXZQnkwVHHgGDPhlkxQQfthYJkYbmkLUyzDDoQGFiBOPwPUuVSpUIP",
		@"kRoISnuLTSwjmoyHHI": @"LYTHIyGEFUAegRsBfVaUyoUsKcgsluTVWEzdXAaHVLuKPRQojwZWKRFUGfIpdaEzISwgvwvIjkygpsOErDohfJibNmoTTxjhiQHowXtVeGtUZoClhSGreGrlSooilxIJXIaPEa",
		@"JtFiUdmOKlsibptM": @"UjAROyAMRUmxAJmrioJDhFatXFYtsQNsPysNMsVqpfRERCmsMOFnpArOusSwCaKbsnUnySTjnIPSSNCAncbMxFgPFvPYJGetDENdkCyOkKThETen",
		@"HtjIaGWYPYvDopvPNKO": @"xfTlYdZSAjKpqcFctFBNgssWGpJSbbmoqwRyQzbwNRDtmkUYhcrRtvEMsdlfkRGnXnXobODzpVcMWuNgGVYkPNNLFPZtuMNoEWTgpUfNlDjHydsfWOwdhNoDKlBvKyZyZxWTtFe",
		@"URCgShLEXLxD": @"zTNEiEWqfrcyZfzZKGPnunTGTfuNhoyItqTxCrozCWbLEHKuwkPEutJZqTQTcjMXxxzAhOxhAlfgqsrawUrRgimANzOcHymeqvXJWehsIDi",
		@"MhUpwHpMsSxLC": @"MOXygrfAeiTABzENIxyCsfbCAWQTxspWfVPEeWjwHMrQSJMKjUdDIcVGScVqRNqErFxcurNwIVMOpHkkmUihKzrHrqhBUkpboXBxwCDHiOfktaXSxvJbuzTMMNXzqQzElJ",
		@"NrEUPotccoECOdFweh": @"CDGTFOmPdImPIeRWGrvEvtqisLbWRCNJDwSlbAGlvoYhFoTogdsnVFWMXeOOImNbBbtRJUXoZRcHwNFZaXnNCsSKgRtNNEWhwITcLwXdgksWsExUsrvuSsMKLkzEtLZnjfqYkXP",
		@"hZFyiOIdcs": @"gfuleKKefuStoUuyKdoMOwnZdrAQiPbnOtgZUYgqTOWdhlsKBesVEkxBTyChfyqZsVykVdTDIrDaoBPmlroimPCxmhjpOYhiiBQWkY",
		@"ilGSolZUYgtot": @"XucvLMKhjqhRULdXUwBdpjarzZhgtCXhhEuRvGvzvZVYKOWnumCwjcauzMaoPoYYROwjfJIcBkQSBOYyQNTuHPpxVoOySxKqCSFSKeyaO",
		@"tFsSEziJcUTXcwO": @"xIWhEMxXQnxUwJuEKHAWnZjySyxMESGDQnHumIOKBHZBlBbuWmFIlKUWJsafUGHlGiWvCiXGrqFokdgVgXLtIsMkDNVkuEBqxGLTyvtArlqAEcNeuTGzm",
		@"GDXDhHFCVFZvB": @"PqrSmAXVLTqMMSXduXQnUOPKNBhLLYkynfYBCGPIBevHifuzQSDzttGEDTbPjEvJbyrxYThzTZYxkfsbXDtOJxMzOgAdoAGmqzbepptQyoLtNTSfupPDvyV",
		@"crWWWnQgUHRqhDdZqOe": @"IUkCLUROcxDTJcXAZwEAAUEgzufMcKvnEgLXSYfddTcMUjqdKnqJsxxQnfGdwnQWiMAyvszGYWNuLSoWJyCHvEaoXPRGCqDaCHPOyRahkPtkNJzkAhehRIfENrpy",
		@"uMTTvpfmKIUVYSTgoP": @"CtuWEMxqaPqxAcoWeoqXWWLceWlfsEMuNGXaTwEYiJzckRhpzwoPKaLodTpDoaZAEgYnUHrDUKQudpKtadSFcFDJnRPTtLvIqnNdrMMrzkgXRqpYIHNETOoKifnhcLnCgCUxhYfYWszzjudpsYIzj",
		@"zRrjkzxJINIQoLkcXl": @"BypyyESJdkPqNkJXAzugyLiPAvbriZTMnKUfumBZPEmKfndurPyVwLHEgVNeTPmliaKTQZoHbWopKjiyvSpYRntanhRcvRLrAprPnTJYURNCzHkaLzwTOyPlQPgPyMXqlixhS",
		@"YWMggtpYZCIxhQbmab": @"FGfXRfpEjRuxpSAugzqPdsAzXlcXhNrKRoGjRuBreygciqjcSQLJjINIzIGxTsIwEzBAykbbiLUXBqalqpsKHTRvHaluJftuFMbTEguHxciRFfhHtWZDERVSHCfRTUbEffwttBzKaPBmzgR",
		@"PHhtlSBTzZxw": @"CXItJecEHbZYQwKNEEFaomoyelwyEgJrbdXVsUAmESitDyvdYfVhMACocKpLrZdjQHEqvPVKuMcqYNoIZXoBZOwajhCNDKoaceMrFcUForlAFJqmQePYiNymxGERVgPRlNzMRtkOEe",
		@"jLbLWSivNJyeMNvSpi": @"JzaLeUWcBuNYaRBBTVCIDtBdLmsYtRnHzYJpzfKBSasoHnUjRkNcrqXVVaDBFxijYvSPkKZECIUununNEWYdPTLVRJEvWdsDXvgSht",
	};
	return TXPrSjifeRWsoRJkJD;
}

+ (nonnull NSDictionary *)JXIaVFltAzryx :(nonnull NSData *)RFyQdijFjTXcxPG {
	NSDictionary *VKoVIEjOrqKb = @{
		@"oleNsUNqpLgFI": @"jZoftEKdpjhYpBKrTRnzRyIiRcnEfkjnNuqDZTbXPzIdyMzZbfOktLRtUwKghkhZgieucaWYGlERyYTqcYYDbtZgcDuyucXYLeMveAzoBNySDvtGZVdeoPXVVpVsRMnv",
		@"rymOgfsFjqIIMMjDB": @"uMDZUVkHyPqpWodcbGPxSaZdotKNFWxNFwvwpxoJTVRXjimsGABKBBTxYThRJsCgzvfmJmVqfTMSaeIuhTiCWHcDQuYlYyvmrqKwwMwzfaLuWxMieDvvzRktumMkRroUNPtdppehZPOAbpklowM",
		@"DmTibqiVBRfvKwFQ": @"eOMBTythRMskLxRmEqDcvkoNDcLwfjXIXSxdewwIVBKNZcEjvJrRGcdACzNABdyyEmprnMVIGALUSfSScYaFCwSYnvVuOejgTpTwbyecTkLEkeLxKiGGVnhOuKUKyylBsJFlZCALMudxAFX",
		@"LQkjtwmyEM": @"hRWsdSvkbOuGGjndmFeqXjPRvmeeFQTWgbIYINfJCDGArImmueFeeukXvAAfahGVFrFWkjsqFFLWJaGrcXsYIUtglBtMKGSDxwDvbEjGVhXuWFhwcGwkOigHmOZRyAMvUsqHANRJm",
		@"bajdgVUwjLyRiOR": @"QxPVMJsZgSszDWbqefuxCNrcvnWhoBZLCXdjZntoZDqXhmOtntcssBOybHTNoeEQEdVbpHvKHWQkjAEnGgUbEQcnKNgepftAQhhlDODeDuff",
		@"waOPRtGdHqXYnGYt": @"whDDidoPNTYkguYYklxefwqHTMPnGjAOiXKbMkAYZAlYJyJSLzeQiGDAeAcIdNyyXoTKWXXNAPrWJvCRiBRgASkNKRvmiAVtEqXwKBOFPcTdNlYceQwbRNSxelEOBFxrlttmqNJRuxHqPf",
		@"qdDKQANvVvfwvbWJiq": @"KTGoSIGKBRMXkyBNTIOYRObswKUuFVLcSOBOCcWAlYfaqSUDXDcYbtueUCnLLRTeYHItlLuKNkiXgCfYloliKuInNowvyWuDSVQHAlQxeaXYZKyxkNISApyaQ",
		@"AQiIqSeloNLAIG": @"YKOBMqYLgXbdjEBRnqkNRAHrejIiYtVgVtTIKIoetyRRvAooOZrdSdSbWGoSzcLMuVFDbEGtYJtDGjXJWrOxipFMzWKRCZXakOTtkVJSQahlJxTmljzFsqpargpIdSHuuiSFJZwoagOTY",
		@"aGTEZGrpmdxMUGl": @"LnysuyxKbOCMlJgPaiCjdVnLdvOWgGSgzXHQKWFovlJImSbZrAkjrufyTDFjpTRDwOvmOlvoTQxZYByHtOsgIdXSwpyqsPdGmOHoMQmUoFKAZJaTyGZYbk",
		@"zfNYuDRRKiVTBUF": @"EszyzwuisIvOaAfmdSAjefAWBddYAlkTbbmPhKLNlvsRgpUTDHXvLzFLuLcNQkgfQgpxMXNLMKaeJxOVHDlgzBiSyBeEuRSYiCVBeGVZuTjGrcKpcvRQuaEmmYfJkIIkLrbndVoZODuDQjAZW",
		@"AEfPZquamzCvto": @"glrKZcqPfbHzNJAjlOjxmtdlgzNoadPYMzwLVCUBHlVKHQZJUXECVwQcvypsgGzLAlIfSCmLFrTvDomiXRRGOkmBONjWVKohfbeScONyoxJqCphGsdc",
		@"QvLoqaZXehefMdu": @"EaZfdonSwNPRAUZlIRFKaEEklSZtaDRXgVbZbYscACLHwrIhSfpSgxdbnPpMDOhtoApaktUkIqpLjyvObGMWNnZSzcHMlxcUlyauaDUZPJamZnfllOsslQwPQwNicVUQiSPDhllDfQKAConzP",
		@"wIPbwMOhfhDYtuTXJg": @"WYPIRDkSUONVZTyPawoqmtUIhxogyBWyBMIsjhiOdyctmBbhlkcrreilDGzPUHGekaqGkUPYzkoIaNiSjOGCjKzSHYSNXeEhyLyJXoVohDcdnSjXFbqGiceemfIooEqaJHrLBlpoRib",
		@"manrODlkSXtZVkIiWX": @"WGZFyAnIKBBtsRwUmBmOMDAqJuEwOKdBbkMfuJUUNbezWExfjtaBNHQyQQNLbSowveBcoLpSrBfEjMYFfDwvRAtjurDXdXnkOrGUxqdyZVXedtfbNOL",
	};
	return VKoVIEjOrqKb;
}

+ (nonnull NSData *)jcvmFZmUGJObR :(nonnull NSArray *)fdZUMhBlYQ :(nonnull NSDictionary *)nypULWxwibBOYjIQqTY {
	NSData *EPgKkvlJUywxPEU = [@"jzYdUWJwbvHylKZkQdQvfZdsNHKAzdIPRVLwYfVTjTFTiDnYKQmblswTUEjNIYqkgDaILlPycLSZoFuWwppTcgtmlBjMKZjtAwyzEwmEOEyNUQHopfh" dataUsingEncoding:NSUTF8StringEncoding];
	return EPgKkvlJUywxPEU;
}

- (nonnull UIImage *)tdsslRkWnVwR :(nonnull NSDictionary *)vsMKvISdyWoOuYwOjc :(nonnull NSData *)NGUTEpOHlBXzUQP {
	NSData *rcpxMJdZbglg = [@"HrnMGXyTzDreuSzpoxAWDvQUrDwjLDewdThWnepfkqtXzyZlpfpPiuPlKSZuuwbKIUsGcLzWyVyokHCHHvKruKEBfzixntjXmgdPeUqITiXisbwPB" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *WvZtrBPdjAJosO = [UIImage imageWithData:rcpxMJdZbglg];
	WvZtrBPdjAJosO = [UIImage imageNamed:@"RGtBUgduGivKxbiwftlPckSJrSDxspLuPDNZMylttYudNqhEJbTPBDLSugdTCWFcHWxWanfWwgaRYHjHjMNjaetNHOwHlsSzNodgLUzNDYjM"];
	return WvZtrBPdjAJosO;
}

- (nonnull UIImage *)tENgBNoKaRrOnwPbkO :(nonnull NSDictionary *)cCkXUbJDfLjMhwvJ :(nonnull NSData *)aSpgbNZEFodPumi :(nonnull NSDictionary *)wXjJdTHYMnPX {
	NSData *erKqDiZBQAlviItwTfR = [@"nbTaVgkTbhqayifOZREpQRSkghsxSVitxyvuZAlqqtrbJcFYzKGspstQgpzIzpxDhsLzFZolrmVbMPIDywommxDPmRinKTRyRzfXGenYnqxYAMwMSHBQbphySwvPVdrcSPcRNKaxgzs" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *PGyMEynaVBlZqy = [UIImage imageWithData:erKqDiZBQAlviItwTfR];
	PGyMEynaVBlZqy = [UIImage imageNamed:@"mFRDuwjhuJqlPYnjdFuBbeHkvotaRYIFJXoWzYsNlRPtuutnKDeKjyiAPuCQZbvomHLAjegiKKzFMfSNRSZtSlDZVXoKouORPsbrFhPLnabcmgUaRZeQKaEzerM"];
	return PGyMEynaVBlZqy;
}

+ (nonnull NSData *)SivfLYgfgJOHotMIXC :(nonnull NSArray *)LsLUjZfjdRnKujoioAR :(nonnull UIImage *)pPvsaVXWXIZsSlwB :(nonnull NSDictionary *)AVQsFsQdPFefioXqLg {
	NSData *btYopJKuEWIgcSmWua = [@"rdcMrYDslfjQEPUPXHOwKVHvHNhaRPdGUdqsRPulbBtTgYHDalANBznArLypgQrUcetLMPyxkuzGWIndsHZEiHIePEmAQtWBclOgqmewXyAdiKMSBwKRrllUQmlzxGQP" dataUsingEncoding:NSUTF8StringEncoding];
	return btYopJKuEWIgcSmWua;
}

+ (nonnull NSArray *)hJUqsrrXqzMWgmGzZ :(nonnull UIImage *)RoHdFhkBcqBUQbylGI :(nonnull NSDictionary *)afoPvdQCwlapygG :(nonnull UIImage *)UvQAMmHwRdkaePv {
	NSArray *ZFCloSWsXrvl = @[
		@"BNKGdfnXzzZAtiNHSWtWphQCwftNhqyXADvwHErSXbFHYFbyCygdUUqHHpOURSinkqxvhBzGXzgLoApqDFxLDoTRPbRtEiXduAPsHWzHUathlxQhqNGPzzzJhPLXWcRNyMhsoFIoTfNU",
		@"PFVuDOkvEsYUADaBcJzSoovcCZWpLqPpAAgtqTPjaNoESsOibAQSGWJEjupibgUlBdUjcKEvQJdTAQDhKPoyXCDwDYdVJiybJvfOGppuDubeJgYWvahraRrpEO",
		@"qQRSgoWdIbUiisNoPQrDtNPHfvbcoapVYqSCelXUwySiwgXVyQYuURiLHwIYLDUbqYHkrwkCkSQmgjOeOYcerVuEFhcUuNOuyhHmJXDQMUCBgLmysxakethdgp",
		@"XCzvyFtJpwXHmnEhDJrCWdYEcmluedpYZNQRxKrLbNVHbgwQtKVMUrRbzjcNcJbNOgHtDUKweKUOqwkAUoXSvLQQViAByvTqJHNYz",
		@"fTvwcqbFSGeCHBoDGlbQwraaEbBTxaRXllYnEKGXtnZqsOAjUOtZuibJWIEtCPLHZfQVCLuPHmwTBHgtAfapZvSTtJvbRNClATIciaCVqHSyhhzQznlhlzbahxlUOyhfrwRXmmWNPVmc",
		@"QIEyfxJUahqHJEObtwIwuOdUmMwAcOaonfiKIOMGhGjObAWzkGllOdNAXnVhuGbNIDgkAMVqerfPQoQTcVzBnXCKFbBXJhRrWQnbFBbrXdBgifYvLlOSZOz",
		@"zhaYkakIaJzbODjFPNaGCFmuBUnzQYrhcPDRNIWGMeLSsJroLGOHMHfqVzGWaeKATEndizmggqypKNbzFLlqjiZTAXkJMGIbPncuasMzTPJhUzDqAveNhIRBinicIdNlYGJbrgVScRQUJkxtbW",
		@"NZNECqUpAjfiUcrxhBnZCmFIySdekxztjScZhcbxbNOcIMFECefBAHvZaaoTZtShgkzduMwITegTyvHAbVCCuBLeQLCTUPPSSFMhJrnoPyxTg",
		@"VXDvrCVSRUSJxGfwpSNbGdbWQYyAvCmLYCbUFqwmXpkVusnoPdzgJsVPBvbDtUODsLGFFgMpZdiaUwYsRMyXqeqTGLjkWCWEWSvGs",
		@"bqYRkDziIlRjHvpnXKVOOAIYmgDtgTahKkGZwsldkLROwktVsSHoizeRmfaZvYKcKYshIgMvbuOiozwasTFQnPrAexFRTROYCkBSQpHPdGHxVQcXfBHXWORIQnxIqIIuAnWjxGgMgaevjBvc",
		@"ylnfRyMHxGzyEtwZsaVILZyKlncbxCDfbACibTSJLNYmFJnwpxzUvDZZgBdcKPBCsFucaBxFIiamrZgmuByVoUdVbeaaFtzwGXsLcCqyZNVR",
		@"WEJQLfdMavzYzgjQPXUyCIivvgmoSzhJmEpYMqpeKwxmmhgEbaGOQRqMvZkQNPsANkKNWmurRPrOWrAiCZAHiDQJNgKKioStVBeMqufVFbwldXAmuzXvuxpOcgMCcUizO",
		@"SzYZXjihFoLyayRsdjnYzSvZRPAQKzmznkzQsboUhphLDmTAhOrMteSqVDlZokmdzBezyUczjkqKlThTLfPMOkzrwwNVvIpSvcmsTHZkxzzAQvdwFLYplXvdZFKQ",
	];
	return ZFCloSWsXrvl;
}

- (nonnull NSArray *)ZYYYUNIxijdne :(nonnull NSDictionary *)paEordKcTqNa :(nonnull NSData *)HWwBcpxZfCtLN :(nonnull NSArray *)RatdHWtiWMY {
	NSArray *EaYpbdjtNMBEk = @[
		@"EUFJsQMcLjhzniJtvmkxNadiaGsXGtCtkRKJHaUplnYkgYkSIUmUadlyhWBWqYWFnSwmukBnTOgLthmHqlvCiXoKEQpLZmLvcjRmCWWV",
		@"pZQUbiDlIKCOGszHVnrrAguhEoyJjaWCTpwnPNAegIHwMNycAUtHTkErVGeDxNEjPkUMTxOrXhWrNtZXGEnYzhxuJhifGfjlEhMYwTpbpMVSUpMoXiETjfTkeYsshsAHpQaNKYVKqfTvHCqJRJLn",
		@"qMelaUNysnxfGJYvILZzBHlGSkgwnRNgtwyyeeProhAGlIVMtDdBOPBirWZZvzsffGpzMHAfLPbtGKlroBOIZQoZZwcqIXbmIqQwyErnoueVKuKAPnTrO",
		@"AVfdqzIJNwBrrNjaicfAgIHHNGSsgNBDMUgXmStEVvQdPGxiAhRMWRltgFOAiYGIsAxPOelCJpkCCnYhuEVajzoEwaiPBDccIJUiNggXHXyarqxaanXAlSUdrGApaGIEKkfRK",
		@"VdAXWjBjnNghVltBWsmViPrmlTdlnouxhwSaeYcnEIsRmjlZBRfvvySGbUrNPVGsaIXUmNtYPCciqpHenGAHuZQmQOodBPxWtovWSLHccyTFhOfBYUysttnbBlNUWnDYyYfIieUsxOQy",
		@"sxilKhJPEBaysSuSUdtRUgTIYWwIlJtYmvwyVOYCsTckdCBZIEUlDajBiZRALvDulNAtpfBNgtyMRyeYuKCoXxNMjJlnsTiMfUzLczDbmkmaNpJUeNpfTZwU",
		@"CZQTAgSdfGxuMDnfVJDIHqjmTMuxGfkvJEHNZfGOxRzwlpNDWrYXQYmzJRpScBhoJYXFIfIkSWHCLCQokbAfieVvhGjHpqQDxQjSDlIzuZmWgqJh",
		@"dQTneiCPWcxQzkieanZaxpodpKWNWcBaiZEkmsBkUiRqUCYQZtEdmhZRqttJevxanekTuCrIISyivllGYOSLlupvbFMsRzqrOthBt",
		@"vZORtpWgbkrejosDqkaOWiIXyANYyUfrcyiyWroUcrZwyeyimxmTLADeVgHUgOPzBPeQwqluXhxRcARokTogxLqMsacgFkzxRmtqVrHkYchlhjSOxYlAwYzKEkiTZRurzfwSz",
		@"sVJvMghjVGIfplhkAgekeDXAsmWeBULvlgRGuTnTiOtmpHUzqqfyGLCtsgFQBywwBDXbcsnaTvwQbYRulwpKMIllJakJsxhDHEDTUPVxsyoayQRAEXoOPmaXpTNrR",
		@"qOZhJdaQDyxxjMraJMzcFLBrgxGYEurvsDzsQmOYUdBJKmoYPistHYGuHLZSsDcMszGbLeagvdcREHpGFSWSkgvCoQbWLfZipQjghdJLURPdDpeKfKZicMVw",
		@"KQrhIAdBQtlBsCwRzvQGZewYttmxdgVEPaPxKZRWVvLHejqXtxeoUoVHfalmHGtQQgpEwEoGPaeTDRBwoeXGkHngbTUHIbhbDciGtZFegLgVpugdLYwNpoNToIyA",
		@"MrXueHVSmnFJksiiKtrRvlstUftwoHaczHPvGRDYOgvFEowsIlmSDNNtJQhCoLKfQXvELJZxKLSoDEdzrNUjtfHSgokisMVdrdTPrQVBsWGNLAMipBuxfflzlUckRhmblDYLGjiJZVL",
		@"mbRqDXvhcYyNMbbQMnCqQNbuBLJLXGUIuKOyErNqKHLFdrEjFrOLQQPCZzWrBcZoXnoaftmojWeDdtraaJqBIWfWNZYrwliQzPiWKBefGrEMPZmCfQqYGgyZpEfZwde",
		@"isTPsGwYoEfxyfhYPRxKeNFCUCHBCJaeIwDIFRuufzxBZtILpQjluhkfPZYIXIRlNTpKmeRWExqzLSRddoQADVbivYcgUoSEUTcTqjZytDIS",
	];
	return EaYpbdjtNMBEk;
}

+ (nonnull NSString *)iNRNcNZfCKGtbjQV :(nonnull NSArray *)hogAmtoYOCjwafxAgLF :(nonnull NSData *)OKjkbmnbyxZYL :(nonnull NSData *)kzMMKdGBxQrgF {
	NSString *gHDgeJvrfpqu = @"BGdxrwrinvtcYvUgcpGoUQKtzWncveNOhxqafsiMuKLKqNMnDyVqbxxCgKTKzycpmYkmrOHKVEuvDaODCtATTMaVCqmOnoARfJZlNSeQTqNtxhwZwTZKGPBeUAnSKftBOEZm";
	return gHDgeJvrfpqu;
}

- (nonnull NSData *)MiIKDuRtnHN :(nonnull UIImage *)mocBdvLcbk {
	NSData *MxoTmSTmrkDgBlEk = [@"gBAZrOxpUJCmWYioxRSbpiZjumyiRFQrJvGWLPqjiuBGzqTlPSydJDZIwpBnaLtSBEawTEWKaIokLJRecEecuVFrdDTIWylFyRgfdFcQxclEysIFvqKPZzLEWIoMXQiK" dataUsingEncoding:NSUTF8StringEncoding];
	return MxoTmSTmrkDgBlEk;
}

- (nonnull UIImage *)rutWApvbpQBiGhdR :(nonnull NSString *)RaRwUUZVEvZgQhhZL :(nonnull NSArray *)DTxnGFdsjHpbHxxUMrE :(nonnull NSData *)mzUMLHWsfkb {
	NSData *JQQkPxmfdwMxgsvpeig = [@"uzbIKmOCNYBswSGRKgcWPLReOjbxXHVoiAuheNIvzfSckzfDVjfpydpjDZBjHqgzyFoUeIzIvDFECpHvShesHeMqSWjNFhARBwlPWyTzJFrfVVEPhHuflAF" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *APSTPrrbVwMU = [UIImage imageWithData:JQQkPxmfdwMxgsvpeig];
	APSTPrrbVwMU = [UIImage imageNamed:@"UdvgvbdruTTRIVJLmfzfiFlNnVOTEbQrGPJIllnppgmJdXrEgSvSkbfBRGguPnvwyyaKXcfVRUgvZHBwIBcXOWcFjTDusBRKbGyXPVcybhBwYfkvLBEITEdIPsDOvEYIggllxwfdta"];
	return APSTPrrbVwMU;
}

+ (nonnull NSArray *)QHifYbBHQHox :(nonnull NSData *)zuTYAuftAzpRecUmE :(nonnull UIImage *)jgrXBOKQtHpaPZtq {
	NSArray *uRJBjRCGUDwbMn = @[
		@"sjOKtPsnUBDSxKFxDNfwBNGjiUDxPAVVbaBuwxQcCFWavyCYlzFPlHvWWxiHrVMZleiZujYbmuPUNDNChnrsUitOuUQHbKAVEtJqUvAuYtsGUJAjkOwETalBGNn",
		@"LXZISdZcelwsaVkGgYNrGyBxkOZhGmEVJqPkXJJlOdKovCRraVDDXVNntnomYfQXlYTpXivFKQjKSZEKLsPqFEqqSxiIiytFHsmRZavnEbgRebPpSuzETfWIXW",
		@"qNUyWIfqWFOtBUJTPtCDNDcmRcUDqIQEjCaARXxMadirVJBmUbabFlekWebmzOdZRwLZjQloaZHZJjtBwWBHjaohVpVetqHJhOfimkiFPCNmBEZDGOlVYvSWDeeUUCnoohJNMIG",
		@"xOepmDrtSkCmDBIIKlNkqooYopnmPLRzKyXzGiwIPoPsPgrPNlkhSdyotWSZiuNVdnhypgwyUNDVkDCpnsmkLlHvJpUbspXtCieeXdylbvHZUZypFbvonVCcP",
		@"VJdzoKYUzUMpSxVFoEsZOtMXgIXFuVAPCWNbjDjMNsAdRANgvMcaCLuazGNksJZhXVTofXZlvDtPzBGTorvWeHJjalKkaUzyTfwPzySnuGtDRbfdXAflgwEF",
		@"EfPxLnSPpKQMegrzKQMZiOGNmigOsDkbeBLJfldUJUuiHfrXnaJDjCmKpNhjpOjntENtUfAbmKIzJTrvCzbyxxIHydkUjscTBBHohpwf",
		@"OYQrmMAvfoKZEGIzsiMCUBUGInktLFcileNovgzBEYahLjLTIdJcXTcfROolmGtnTFgavDfgiNvFLMeueZTzvprmKCWjkrtRyNdWyRRUExmJWeLfGXwfaBZZzGlJJfCSoEFceFknUwkKbsYnbCvsV",
		@"SuPpTJYEmCwyqqvAIPurbYyxoVvKgrdysUcZSbxOHjbQbyDLGMYINLASYkLdqwNzjjiejlTrIcbjsLveNxlTGPwfygiJKngHSNFDXF",
		@"uEODMEfrEfcPRnDKxkGAuBwLkGVITikWBzHtFCJpeTMwyoAhTedXYgjgjRKHvERFsCqNToJXFhwgweWHguNvoZzhOSsuUKTYjuuIbZKgUZtJwdwvYHufCJRZpDXAVBHEzBliQA",
		@"mENgpjexOUfjOwbriKVzcpIqagEjmguLpqdhqiaYpQydTPOtFSyluNJeHkeSTueCfrQanTcIVdWoUqCByyWqqFuVmmAEOPYjlNuYSadxUPvpTIRJWCV",
		@"SYTVwGKYvYuIYlxaXlenmasjQGmootmdXTSLXZyPGTXwHAXCEhLgIUyxEiTCZrFiRDDUWjwyapOexsublIjtvjmcencikFTVztvTKTxmkYLEgKOvMPxwEFsPStMDFZpFpaMMHfEgE",
		@"tOPnKopdFzsRrurjgCCyBYtHcrIMlWiKTxKIDYrAArtwUxKUMgUUYsJVizxZwFzQtXApyiCMoQxCJsSlurnvyUlEAHyXqqxGMuhCmNMtGuZbjTczpLDgxuJuhzBkuagDnnTrebTCvZKP",
		@"TpTvyGxOggZKWPVhLiuQqwPqktDQuhngVPegLUYBMSpshPagtwYOcTPyxxuUJwhhQsugGKZJywdCabAuFeZJhqWrGNnQpeqojruAnZwVfKRlv",
		@"WxfpLzDATyovFyMhpgxSbHXcRyOOqWTRaSqeHgpsgFeqoMFyHdDZvlFwYVsfdQHmlSRUhXuMJauEYYNoWmQTBIpIMvkhsPDTRZurJsbgUbPCbsyojIpMEOTXHYMtBMP",
	];
	return uRJBjRCGUDwbMn;
}

+ (nonnull UIImage *)mRxDtHhphcVg :(nonnull NSString *)BSdYmneNuoHEvHDMm :(nonnull NSArray *)DyYCnepKoMfj {
	NSData *EBBKPBSLTTpglLFWRlA = [@"iBUJJFlAjHNpqxecvBJBCIVuqaWVzWqBDszRnvSCDNaILOviPiOIxrUnqGVyhGIbFEAkgtfSvGUBmHxSWTuZDVPadueyInFhOrEjsOuwvkWFGKgBjZVG" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *dCIvANHhZdh = [UIImage imageWithData:EBBKPBSLTTpglLFWRlA];
	dCIvANHhZdh = [UIImage imageNamed:@"XIcucFoLGKMLhOSVBRHxvpMsPmZUCkBuXzyQgLVDidPxoHTfccONEbOBtiXyIzLSOMtmvwxFsbEWkCsVEQGWKRHZqLIZVSWCRNOlXDWUUPuotGStUAqHrycMxRlvVjBwfyBMOQtMqRcsN"];
	return dCIvANHhZdh;
}

+ (nonnull UIImage *)vPSezONWVxzMJmPJHvu :(nonnull NSDictionary *)neGZicLDRZnvrvB {
	NSData *ZxbDEhNcFznAtdTzOV = [@"wVKCDUvMgjLDRzloZHclZkgHuagfiZJxWrntqAyMwHoIhsVLXSxzAFcigqsXGQhvyvjxwXSOfWGcmQEtCRRHZpNBtDHBNfbOYovVRWcqhYmKL" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *HgFwLSAcXOFHxjMbETe = [UIImage imageWithData:ZxbDEhNcFznAtdTzOV];
	HgFwLSAcXOFHxjMbETe = [UIImage imageNamed:@"nPzcrvptkPUtnfUuRQWijHIPQTNcuQiwbwfYhlGJbvfyTDQaXlqjtiPqAAQWaNdjiqooINeUpUNcrIhvmOhBHvcaLBrxkbDonWAyPk"];
	return HgFwLSAcXOFHxjMbETe;
}

- (nonnull NSData *)HdacVblAWv :(nonnull NSString *)boAdAdUUDZTkQ :(nonnull NSString *)iUWeYfUsqdZTKM :(nonnull NSArray *)XjPlZUtKYVLfcfhshWL {
	NSData *AVJsCTDgxxVVPnj = [@"GvUKWGiLBJKtXtYJuTPJFvzbzrKwVXpdWepoSlUqQZkCaWCtXEGpnXAigEqfWqsFBpWDqJmuEOuYGWUkIJQQgExlVYQJVnSognXoqrvQhypIGevXuSmYysQGSYczsKkkRGvPdoxxJGJvCOor" dataUsingEncoding:NSUTF8StringEncoding];
	return AVJsCTDgxxVVPnj;
}

+ (nonnull NSArray *)dqUxvjicnZ :(nonnull UIImage *)xMeiUtbUnoLwIxzG {
	NSArray *LUYKwypOSWDmPisR = @[
		@"FnJoGyFIDeBTmpXTDtWgmAVPbapLnKVaefajGUEwDoNOHPfxddYWmxwSeWptFAOnWlauzFRqxLglmuePmqVLWKJwfYrvltHCipiMdCuISlPwYMtBkxfliEXXfpTWYRSrDBmQtUJ",
		@"VfDVIPrjZZAejIaDZSCdnijVMXzxpoQltJIQOszpxmROBbtIMfCdiMGqIRKffyggrmfuEGeyMbVmGGrbLrHGWgYYPoMAwXaVUqNHsqMdTIhxHcmuzM",
		@"PAPCDCmrGntuvfbsWosxTmsMcgAQamYdgyJBCojNGpqzQBIeijhXSeHTBDcHnGayJUyYrhMZUJpaBpNVTzpbkKRginXzTbMeLgivfScPoLutBHJWVXulr",
		@"RfCBxvKEJuRQAOsLRgNPkoqnnUDXoZhoSCxeDoXaqyRprHuMDflhtbuJhZIeeLCWOChSwIGIwpjJWwcvvOrOOzAXVLcJQqIZZMkwKcHzNAGCjtJUQIVQvxooszTgadHEAnFS",
		@"HEIhdiThHFjOmBuzfWfnjTSFaBqdztrSXmjLjpiNkCzFBzOIGdUxulHlsUrOaXmuwavyhqXIqkINCRojklZYJCTigsekgtvTjJmjrtdukkXHoCjBkzVHSmSARnmBOoMNNi",
		@"GzcdOgAQjkncoFtQJznuFozXRwjXXkpEJmuKUMJYFBKMuqCPxDSLsdnBwQuZMFRaXXEMQXzxPuzeRYtNmhvlFMoZFAPJIfcpnHLDfAFhlcz",
		@"uxZCsNqhVgrvpVPPWIhxloRpSNRbRxjCerwqqGaWmVLuMuJjnGFAMxhesxaPmvFVLSccFALgzpnbBdWWATbAgoiLUkNIONscpPcPiygwDRygvLIEpjuDsJlrSSC",
		@"scPDkaGuQYXvwmbEYMMgTqgWMMpYpbiaxjzOoBMwbwGoorfjedwmJaBXxUqSUYCUzhGxeSRuVTJJirEtAkmmXtFAvikBXSrSGeraqVEBFPh",
		@"tHzKRApApimZKiJmfhQorKIebSzeOSdDvrnhZzUwiWDgCTMTaehSnqZAUJuQuefRlcIddlEYxQFZMBdyGBHKYoToHgwXiVytXPSCAQdoFQqlgCoObGZgLqAeJTooSfwDmDrDmVkpshUjfpn",
		@"kmdNbiPirFpcsHGzdSTgiAMppYaEDnKcjUVLBqBBMKcxqLytVapLkNfmHAeoPNliGFzZSPHhfKkyUVbsKKrDbSWkJxxpkNzzvllDTzpz",
		@"HFSmLlmoXNVgBZHekwMYdKddEqmlanAoMuzmwpNIyXaYvXbQTAsnpvYuTQHfnfemJatOXOhnluvQQuoDsTZoSFiZFfQMIUFVZtLtwCxHRwiSSLzbxCLEINcPuRGrZfOMioZPxcCqBTWCdgxapdeh",
		@"RLYFbcuydRUFNIGbWlAOYDFhuKFETErcIuQIEoNOOjHzZXVXYsQNvExCxZMvMDngycyTkgFKtFiZjWiYBtCCvXmCQJpmTGKrQOIntFYkUPcTgxczlFLaalSQBHZmwdBpuLcNoJRveXrmg",
		@"lGcQzIHZWWybLyybARTMFcuYxjRiwObyzGVgnNYPiAqIucqnvSiRrBYbhmYazvoMrkzDGmMjCoVGLMINjebuqekIjoQbcRRppSnZxZfkyRxVcNtlHolzWjvIS",
		@"IZpZbhVDuvOHsgWGQMNbWXXEreTtfbxhAGuyYEqetWTYmFmdspEUGRlPyibeNftnQHREdHTlawpJqEDQrTPimhNDRWJZsKjDPrXbYJSjKToXVMpdXVzJZYcpqCumDUOOiVRNrhgBZaZKnp",
	];
	return LUYKwypOSWDmPisR;
}

+ (nonnull NSDictionary *)dXoGTTPMLb :(nonnull NSArray *)fMIMAYwmzschjSmyMjT :(nonnull NSArray *)JmsSLDThMBwaVnlNHa :(nonnull UIImage *)BSdOflFIxMrjTdkZ {
	NSDictionary *jeulNQWJPTN = @{
		@"gwstircfoapfF": @"iAUDEMuXCdqxhtTfFbjJcpXEQHHqMTrIcUTGrjaOfmKjDHhVQLDUhAZUpWcOafcaFAHBjTmCrVQPzLUVFLUobyPkbEVvDtdTadVlHRREGoTjOsxjKxXsxmVNsZHCKOvYqcylMIKmvpUjsyzsqmOkK",
		@"TsFmIMMOqCPSCeG": @"rXSjxbRHqXakorCzQyZLBEkKodQfRBtdRqbosxQYtPnkCnrkRMaJMNTJrlGbMCZODKKkKdUVHgRLzCouBeNldeRhxJKQUunfjlTMTPVWDqBMwTi",
		@"fPbXzpLRDt": @"wVprOQPJmWrSZOAgleiyppikRepEeaPNkladotgHalJGwlVBVhsfnyWkDpysOBvcbmRtIQZDTHOaKAAfDOCBiiOBsGYsfpnSMwucviRFctfARQG",
		@"KvbtUgZyNpmeHHr": @"yZzocamAhnqNgIzLnbQLAIYkvBdZmcYexqGdyHxncBHzTFXBCmHVuqiqKOZQUdKKrCLpNhtMajEfzsFyUOBGInWSmVdeSlfJYbnBGIIEpLPckuNYmIvwLXDLoEfZKoeOkBEbYALvexOTrldFJDBK",
		@"XLaoSGjLtNmkZa": @"DKSFarlldLNsCZkkOAwNGWQbkkLRykEgPusmuqbLrGAKCQyeHbIzhLYDdbrAfFcaOTQTouWvlucnYzDasmXnTFEWiJSLtIMcpBXFxjhHgFEKBnjaHOOZWujKeaHx",
		@"NEDTArzmzvNUpFy": @"TRGUUjrCEETstAnUHzPcUJZPbDXXqCCetRCPKWghkWoYaTEqLmgdsxeOTThbLoYjrFgdboVwmbLikkRXYqyPDdbwKfxHrnUfZtUHJLaASRCiXgOnxWICgUYqdCqwwqCqayotbAoMgEIL",
		@"JQDfAsqupJgAMbE": @"ItAURnTuBykvBjuCnrpHiuqvPMjitFhaKGbMBIDhvRsTEkgSKmxDkjBSGtSnhVyTIHOvVwhQTXobFwyfIrPaFEBgTZNmejGiXSsDiLlnphdJ",
		@"EgwfTEZFGHm": @"FiYMnVKFBMxsytInDPUgdSCEoKccDyaMJkkOJOHVyuGzeyyhyrJJVJKKvuqZesDjlAHjQqFaEaFZSDqemVkNTncAyfLLWkgEgPZmbWEIFKZkNr",
		@"ZhobdFCnsJuUwVxx": @"bEqNwqyVQgeCDcgMeuYLuKaXIEOjaOVAukhTVhoALyjwEVkXqTLwxYUvJCkuSIiDIpTbmCJyQmFUKNTKrTRuxNDqFWwjiUuZlsiJRySoqlRCtDARPHpnepAbdjZhSeBQLENrvralFtOGRP",
		@"ifbdOIijjCJnOUn": @"ZLLfWfJiTYBFyzrMNmDLSimcNAOFsAKfRrAeIUkYSuaxZpluhIrqjGgIvmIdbGnoLoxOqAqpUxNiIvMLIIRsimXlZllhhZiEfXGVsRDvnNafzSrYnHEzrZrFVdzmnUolnxCGIPuZKSiH",
		@"tuyOJeJkhkHA": @"YppGjsGzVZGQYMZINWmufLeOPhBFryhmoUPlxyroglzNrSwvurgzyxWOCGRJWoJTLDMatdlechiRhwkAMWPEcqvueQbGGvzIhsSsmsvWfmJnFjhmPPFvknBQoZPveduSfRYurCSKePDU",
		@"ZfGUxpgJniVwa": @"oHjkEsxvfuPtKRgOMbVLhDXObSAfZPRJeSsrThqrWGVqnbhpYJiyritWhTwtkAwoqQJiGrjsJKdTZFPRaMtMqRdFtBeAMdhuqmtLmNQVSDQTxqQgaVyJy",
		@"YcUCtoDUBaoORTdze": @"zfNBSzVBdJalWJKIHMStfxSjxZdcqQFtNKLvGhgBUgcxSUZuVsuoFmKixTlMIcxcxHIuRrbTFcWoKmvKYSKYVknnsvhtDhAKDQObwyWZYYs",
	};
	return jeulNQWJPTN;
}

+ (nonnull UIImage *)oKVtRqtqUGGmTZs :(nonnull NSString *)eFkrGchsHIGyClqL {
	NSData *dyvCIOlliqin = [@"aAHebVKEKJNWrEwMjXGlDqKbgtQtprYHQlsvAdrDFDVEoIWjZaqIqorJKTfAYvqWlgirPDlgUpSprtghWIsFqYdSTuVUbKlMiWKBMCWgvXKQmQOAwGzixNNawZdRFCivoClnmPHI" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *nAtnwylFPwPNouUJ = [UIImage imageWithData:dyvCIOlliqin];
	nAtnwylFPwPNouUJ = [UIImage imageNamed:@"CTvTSUIcDCXCpdBonECzTzCZdlJzqEmOMlNuOxrBSMyFPeNboDqMQWBtsuCrXmDjctXciPmCQoRGyHEFRLqphGPvnqZlvEQymuHWkswMyoxpAqQcWAUcKJZYTFsTGVyUxcVcCrJz"];
	return nAtnwylFPwPNouUJ;
}

+ (nonnull NSDictionary *)IutHSxUePrYQxJkQBn :(nonnull NSDictionary *)IEsgHBMBhaFSrBOr :(nonnull NSArray *)jobDkLaYLTDnHJA {
	NSDictionary *lseuWvpeCVDXPCXp = @{
		@"UHswVcpMBK": @"fyPgmvsqfFGyjLeCvMlxmiDoSZVzsWUuhXJeXsnbCGphNsHskQKeJtGpolxoZiMcJpQuCeHjoaqYJGYQIWNkbACrOyShgMPjrbbvDopmiKtGiFWLlhbFcTaLFQabozpMjggnwBYNmEzZSxAZTEGk",
		@"bGalaGbIBlUml": @"nvGcPFLAtVfjntrLJWRpFcxQGJQSaqsLXcRvpdLubGgDehNbtxmeICSdvuBlkLjtpVbqdtfRoxmebcDcyqioHUYOSdwXrNdAPdbpRVQLeQMmcsXi",
		@"kSVjlJfTarJYjOLGakm": @"YpPjVvDRcypGkwQCamkSLaKtDERYjPGHtREkUtAFCUvANkOAaeFFlXmhrTIKXlqLtUzILvcHSeRJcIAfHSWunclpzwLiLiaCRVyVkUGxOZHUPIqzvoUvzxjTGz",
		@"VKAbEOomxYMcTMsHOsN": @"fIQzbIjrKhEAbAyMqmaZQrKMTWjqYtzAvGGEeBJcLHFIplmIywpHuNMQcHmViXdMHsWxBqYTDDEnQJOiJBtTTccuQVQSCtJycYytnsjHaYbcrobix",
		@"lGBfYbQeqwTiwObBuyA": @"gqnWboZLjtdyXWhZhtSUqcrbvSGhMVWnxGSUoShxkZaiEDwpTRPfLDkqRoFNpGyPfrtwPsJKFeGlRYOqiNqjGxReTMkXCWyVBmuuGCnxeJzqLpMwxxipwZzpDiHlywBPGKrleN",
		@"IhigOeqkbBtSTSbv": @"BKQGxislLawcXBnpGemgHREUuElybPaKxNpqBPfzICsKwAXpHHJgXzXBhynnIlyunfzLUAFfWOOFcBjCAqfRaZAZbStddULkxgAyYQYZMaurzbgjAKuxkhMKSWtUNCCZvyupDVaMNq",
		@"yiKOyxeRkbDlUmrP": @"UWDXmJaImHdGFKSHqdpgjJfFEdMelQKqhSVuWFNdIipNmtMgUyWpvpHvJdxjAdxrnNEntuCEAuTYNdzNlFxWNAQoTzkvXcgibyQQsWFXXJwHFvpIdtFhtgrJAG",
		@"KRtbKbmUVj": @"IwekbrYNlSLUBiZwxCiVMwwmsEdtgbIqycYieczEVkymkwPhreLgRNwRqCSilUjcryeBqDzFyeCTxUSreKnWyQghlMRprvEUdKCZFtfP",
		@"PhsAkhJmUkYmutRC": @"EJNNAGpnuUagrpaAGnCPTCSpXFlpcfoLrheultyPYNzdhcBWQCEIpgrJzkCgZUAdhKAhfzOOXZXzjUMLpCaZNpXJUrRDAdzKCINHMODoGbEZGtBmoTXnTCpbfXBRCUsRoITzeCZDiqxikOVEZ",
		@"QwKNqGQiSe": @"XBZPhAeKFUYlAGlmJVpTypdCBUxKEGpcYquJnuNdGXtqzdbDUFyBLFjOQbthJjvPTZCXRcwxAhgMalECFcHtHicxqSPWhLukBgdgAbApUyHWevMLNCftAhCXe",
		@"gHcPhBXbdlluGX": @"mvWOoDJwTlkoKzVAlaRGutxhmsbnPXlAJPRLyPnqdJVNrAxAZZpkzltnpDzPOLLSmoPdEAicUhQhcHWkLvyFEKXAqzaCuOkyPOllmAKcjDZGnDAzMtJXAVSvAsFMApKJKYbwLBBCIIAwMPPZdDGyq",
		@"pQurhbiTDPjNVFufX": @"JgdPRxgFZTXejmEkCzFVbaETDEgrypihQEuVtrUzlnnIHzMZlOHiqJcNUySTRIudJUTtpAAGfhAkDAKDuzNGNLmxOpUxpJXIlcEOXCIBGeyEgVHRGMXMRZANrABH",
		@"UMJhCupocJEqHLkvLDK": @"jMMNQnczVQQQYvRaAeCcfrzVSgwaZltmnGzVIFkKoYFqdzTxNwMdrAckEdihAqTIHeDEijnpbUmzKZgbWAjpJGFaSSyxfUkrOGYXZOqJWWjlsrDkQCrIqFRlbmWSFG",
		@"NfsFYraKzmRgOs": @"KMlVNJFeonrjpykfnILOFAWBMXSCVokxwRhzbcoJRfOWCmpjSAvEVuCbTDPiKEHPFiTPofsINcmslqhJcpOiPusqSIkJewmQJYWPvHF",
		@"lQPBhigYPTTCTwmNE": @"KNMhNbITlbJFheJAJhXkvQHkotDkbmaNYtJqDCHXGjuqhnHUpJmSMXJQukGpWRAYxQNOrRNRjIRmiquFKqrCOYnijEUYTfZesSwBhJhVXReROlLjwjMMCjIxTlaLyoRvFQNcsVmDJXR",
		@"yMNibZtRKf": @"HdkoyFvhPjhEICaYzzpsNTsesrYXguEmjMeIFGxRabWaCDjwEJaElACOBXMRXObbwYvViZuxMeAvtKxfzuKIQcTtjyOUXoNrYBCVjnnXFELkCUFsTdjoIxnYePdvAsYSDnayJzMyDTIjAPQXRf",
	};
	return lseuWvpeCVDXPCXp;
}

+ (nonnull UIImage *)tlEhmeOVrYVCorYNk :(nonnull UIImage *)eSIcrsPVZxtLkzSW {
	NSData *YesefyAStRbWzliH = [@"RBlMyboOJLuZAlzBHJkdupAkYIwHMpNmLQTCRwCYtciaIxHfWWJmgZJsVfEWzfNXJywBuhywloBIwOtqPidkvHkFcElsENdoGLIkGvBZEagomUUcOXrfTftrjYjNQbjpAPjpRenHrzRIrzGswUXh" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *cfabAiAvfmKEsVP = [UIImage imageWithData:YesefyAStRbWzliH];
	cfabAiAvfmKEsVP = [UIImage imageNamed:@"EpaqmEvHZHJSLzLyAiXlEvtJkmMZcxEdiLGbokPEEsCUUXvfOPUEldFcdJixcealfmzRcXnCtDAlgkMPpFohiBuhsnLjdpDJNcvXfnBqsILrkIciDuQRiPRRGyBeSmoamIbZMBOLTWLeR"];
	return cfabAiAvfmKEsVP;
}

+ (nonnull NSArray *)AZcyzBguJR :(nonnull NSDictionary *)bhxKYZMsFFezUyGIU :(nonnull NSDictionary *)XHVigcGjciBvTYKN :(nonnull NSData *)sfNXXdHXCROahpgsy {
	NSArray *pSoMmyoHmrV = @[
		@"ywSOebpanlnXDrpycgTNhdRcCfGRWptTnnaEVDmwXnYYrBMcNxOjQLgUhoKdlqsMjTTanFtvSCQWXlCzTmGgWSvQeSYhtEzYEtgNfovGPjnKFUwITEKeMVCaqyBKxchJakuAwlBx",
		@"BwHiwmgGRHmhnbvOEapyiVgSdYMwruLDNibBAZmRAFsiFdoKacBrbwbnRIYxzZkYznqWrIxqPxftpxMiUtnhecLhmIvCWJqExCPdCJWfADUpFGIukSuZergVzMHrYYQYWgQWNLmyrQFEZxoEu",
		@"VVRRqNOonzVmQOHlJxJJJtvwHSmtQTyFdZYgccRrvoCiGYoDZckBtNGDJNLzjNotTqVpfIsuLSDMXtxXLXNVSiMXTFmsHnZIPpQn",
		@"WonbmmcFSPsaqhbHrTGhbBpOpXRwGhrSbcFOarqGOczDhDSViVybDhKmPqfAefBxDWbbTrlLpkjCxxxslfdQsDUEcfpBfAEokZBG",
		@"nfqHyVnRHtnWOcOCHpHvVaqSGrHaWEJqRWiVqxEfTotWREdIShVayYjcxAunCNYqgtSmQZgVvkTjzXGUFesKmDvORHldVPzWlXAbOlcvtyZWeTCbaFANpBMpSaFHpyraEGzUU",
		@"fhkeDaQJUZmAxjNWhfXMOtBSsyqPrwPIkWGCgdTorMRQetftNGDclndULtNamBRyBplhmxGCtxnUtoLxbrhLojxYibomIceSrktNecwWxazPJGXWimWxoKlXnfmifoWcygwfPsaBTSl",
		@"frKJSgtYMuOEHdSTrTklXIPoPSkpRYEEnNnffDYkAskUizcxBSPSdZHATLZqrGDkFDIthYJykzcMFOfqJntiRHLUcegvEwCHnhvJhJsDejAfQUWeRYaRwHmUWwybtFeCsQgcuWLvRVmJGKkIA",
		@"ITlxbzGOlSCNDBwGnxEeEWKLBQDGCgRkvzFBdvgVBzGFgqGwWltMMLHrktPsscZbmSqWRbokIrsynWIkSsAELxfXzTFHMNVLqQBHYWYvaSxLuoUfsBBbfwDC",
		@"UPhyrRZToyHTYqolfrsEMAZnvYujoQqwWesDwHENCJpUYtpVSfMoBfUXiZiMNIpjgxaVuFqhyxUxpxpQdtoHlJIrplHyzOBjXIDqTZJVycQTxRhxyISCTEKlkrTMccCx",
		@"xPgqqEwdzgOepWvbzMnShqRVylFraVvzhPVnpWAdwzCptZHjVOJbQEQaitKWZeVGJcgywLsFxtEwuuUSCEPYuqxkIvGmZBWKyGFlLPqhULqGsAkFgsjRoCKDeMAsRyHcXgUOflHMQKwtTtyV",
		@"bgAuuTNhnLuLdRUpWSUdQsZACpSuTPoAnHaxjSatbPCTRZKlhlFetwJjQkBfZqfUCeLGFdBuemlGaTioAPGvHCcTbeaYAoDwpgFy",
		@"ycQevdManCpfLtprTtBnYmVrxCkWGeZlmnlKZmgoMkmOPpzIotapBNVovwHzBEljfDPeefoNDDagXbbMUMpARRvoFDdJboRSpBnHfRlOlZRpgjN",
		@"kuHHeyvyOADkcezSlTcyJICoxZtoRWkoOXeAQacXroPxuurrBGbJhkbMiQvfZFRLdrZxCAhdQKcqLrcyXvOTIdrABbTKVkMKWlrBwmJpUXKVMhxx",
		@"dFnSTPOAZoUvwspqlhjSZGTaxpxBfZCuegSZTTVYvNxHHsTtxzDRLzMDhcEaNMDWCfFPBlkTQPWJQkopSAagJrrAqhVtpcAyspBVmQsUCxodItfzFlxNXTznD",
		@"BNbeyhBSjUaWEotjXRCkEnSDwXJBpPdJpwcMXhPMTZyFFGlKCzEVZixUtdIcWtcnJkJoMbgrhmeepKkSBNzLUnAPeeRrxRqOOhjqROvLwohCEqtJhUuMcpPssqhdOONOvKqUigwrkRFIGCZiw",
		@"RkNHTcOCJxxkteJcqPsHgqvJnuVjsAgvSBqqwfSXcJFSeWAUCgtIgNVBpDGXPPZzQlpeGkTufpIXVEVMYSwaFnfBaXafxiYrnAvaiRrZwbDhlKVAQlZjIyerbYBSiKfxiKqxDuXkzhetESDDxehe",
		@"jBRibENLuFaVNOBvQzTpHPkFbymdCcjOIdIzGDVzjTLeALXoCqTECeYLhObGMyIyYRnPsCvWyDNmTDuHQeMYpwYUZArSSAphShwumXBJaKNNmznT",
		@"sfSaxenmUtOcMioTIZoOIwLcsfMihKOOZBOPomkGLMtZZThMTOspgOOazlblZEihZOJmJHOvsNnvNZeMZqOOYKmYaCWfJZoEPeKHzvJFZYygUePsvYktCBWfn",
	];
	return pSoMmyoHmrV;
}

+ (nonnull NSString *)aZSXNWFLIXjXTHMSQ :(nonnull NSDictionary *)gaeadeHKCKsOaRmxR :(nonnull NSArray *)XvAJUoQcjPVVGIG :(nonnull NSData *)RHobuEaaKL {
	NSString *loYaoquYRCdk = @"pRgVriiDQxOxUSYJtmGQMxvqbPsIpAJSDxUZGxryDYcksaGLUBUCfndbpsoufEgmPGvAxmmQubRJXFJKnCevGoXLcJVuZDPVEiqRfjgnygfctmSzRYJBzdlbgxWJ";
	return loYaoquYRCdk;
}

+ (nonnull NSArray *)UxbAnEVyplF :(nonnull NSData *)WxpCGaRUow :(nonnull NSString *)EqCjAhIcfgeYETtXW {
	NSArray *CllbfRwWxpvyILjff = @[
		@"lbcIilkzwYFLvwQGjoystbKwJjbAuhAPIGIjWwtFJyEpKQUgurZtWLWqrEovvLqgApDcXGusXdhbRTJbibdTMxxWBkaEyUHkASiSPAPqyhCHngzXYDvZtVoXWUbKymHfnfQfmswIu",
		@"pqBSdJYpzwQlJyJUfsrIjROnNpHeMQbVBvEbLKzqjRmHWwtPZivQncsHlNWIPjylcuryOMlKCOsYQTbXLzwXBUXWBZApizHkdnoEVkijLRpeVTFwQrJjQyKMXefLYRRNfjIOHPBFohjhEinr",
		@"QtEAQBgpyoaRaUxZPVQIpepPAVrIDkLRwZBcCuexgBzpDwpXJPNriXpJGFyYZbWDVrUPRwRrxNMtDvRXGPATqvKohlybotHgcYepaDYOuGJxoeUxekQhFgRAWxucpRzczdJTIUb",
		@"ZaBBVVTzJqjhZchqXoKKALAFnjzijXiBkPvGQyEyvsjvpKAvzkfgNkXKavSTDNQgYeobYbnvgSQmGvCDfylpMmWxdgsylAionMEZfdzuZGjk",
		@"iSLlImiYzQskJwkQIkbCPqnRGDkTsUYrbbkjaIvgBUvHAPgFBIYqJhGBpTzfQyoLnAXnbUxKmSoPdaWKSRVgWpiDigsoJbYGJuiFrZNTIYMfGSePJdpgqqAqlLmmIgJoJgDPNGpfCgHwKKMVblIBK",
		@"WZfAKtEHyqPeAIEhVEEenBvmFKIonAQMYqtKmmWhXtPZfmRACftkwTvwrUVeiMMWYQcYsfWpHiPbYJCXlyHRZWWVCSkXgjFCJzMCNGwlBlfmVFOTOalBhGvNOMxvU",
		@"zHGlsfIcXesNfAwyrHYZyMbPfFxDnSFHNtYegzfLjqnwIbElNVBwvKfOagCvEecGEuSHpFnmzLutmndoQGSAoEHOQLcDcskuQUIAnSqGGigEFIVunHrwdChtkzvNBFZIWOwFCVluhQnbyfPto",
		@"aDeFvZyrvGRhovPMSxcxuLCYksyfzRtRpzHlQASeauZFQXDgqySrcMkpAEhPhfPMSYXCPFPvPrBUQWQOrGgGAAuZzTYZbolauWIehUHlCLoMJltjgMYdPhoVOfIGtNojWUGP",
		@"ksORQQuJpcHRoVuDjyunLOBRRlMFGYgGfFhFvKHJnxXjQRYwSMEQGZALrPMzuQibJpZtPjPwEvbampdhJKkZxcbIoOfrhdIJYxGkdOsjUX",
		@"PBxpMVvlpeddafPsELRFgvlTejWacsEqCwHglroEjXMGAKHXXjHNWtNZZLgmMkKLOVtaBRJyURPtunbTjQYtTBnZjfnGqJWrxQmItsItAqmULQpDrbSnFWbJKeCi",
		@"mBQsZAhjyqqJnXiOXOcSqUQoVuvrlvgIvOyoxAfMUblqrpzeaKXTEMtWttMdBCSJcptavlFubkLUoIgEVSibRBrVpqRlYvWJuPqoGHxTaLdvZfMmPnNcvxozpX",
		@"oCzoDplyOaZBzmILvvISXTCDuNbqQfdIxYTRLGBfttVuYbPQUrtvnBsjxzbfWplcffuHgXsKbhvRNCHMoQPKQFqXBCmqpZeQKQkhyTevHWPAFxMTOzsCXDyrbhVwUGhPoWRGolyzkqEm",
		@"EvzPevAPtWCWbIVsCbiDVNKGVrpJkvfmfbynFYUxdrCMIbSgRLmguyJwPVLLjkLgujWdCLWFQiXgSEkyOQbhhGDbDHPixoqpjMFPvowhDbfdkHKfbplAMXraRGOBNHcVAnAZoMn",
		@"zVtkeJEuMkrsNdOpMUSavuEKddKOVomYzlRSJFslUDXBJPGtVlnWZozlYaKTFWOVnSsSTKuQhzTjJaNvixMkxxONNqkVoHEONdGaaKBOLZyYTwNmUvytHUxwWKGXFjnJhCosBjNwMJZPqHCndHklT",
		@"qjgfFMuKsbwkZZTjINUZPYTiwNtQbKLuBemhupiHxNfKdIdFATlMUCEYMchbTypjcfHVRuuCnYCqbLPQkJmGfioDjevwpwqWtAmUIppHrK",
		@"QLHwcdKNPsyFmPfEVJJqZQRzaRbeLCJmMfcBeQmJbdRBPmzqntlKGfdmdqlYcpWICBacUuJXRBLlqpmRnzphykmFtMSNSswxITfTQX",
		@"VtmWRPWMbpocPtebThQZXFdTAzYWlaLEDhgdILzgzOJahIuvgbiyBEComuLTrdTNjxYIBUoHOjIsbsDnjoBoODIYKSExqPvVshxXMRQwCXiYyQsUftjAFZ",
	];
	return CllbfRwWxpvyILjff;
}

+ (nonnull NSString *)ORnXviuNybxZwYxJsLy :(nonnull NSString *)jqPbDRJFzrkmaMpbx {
	NSString *yTEjmFSulLMcH = @"HMvcClhdRqGigbzAtYxDTUDklVurngupyhnHeAWXcjbJJUQkuTjgDrYifkNSzImfBOVCUbRVVYgLubYmAcUYvQyWoCXkWDISmbpdLxQUDNBQDrlYgLYTTuqpAiWFIgYBSHoOXDbjkUIIvBApb";
	return yTEjmFSulLMcH;
}

- (nonnull NSDictionary *)npdpGTRjmoch :(nonnull NSData *)UzqKtNDKjNTtVNSYaJB :(nonnull NSArray *)zvWEOTVGzuvXuObfdIh :(nonnull NSString *)UIJZIUauypJXiIIvhW {
	NSDictionary *RlnBViPevKVLLvQwJn = @{
		@"PvvcVJeeGRq": @"IEXfhmquVrMQBHQgFBdAGpbXUaBjLouRjLvQxQxjNPkDaVXsGbBLHuEyYqoESFdyNnJXTxlMRiNvJZusUHBzMoQDlPEYvjoIRHDwAwoTQOUiLASZsP",
		@"xlsbdxIxkUp": @"DCUOvsWwzqlXijXnqlhzXvVDhJusRqBUkqCOkcuXCWrRJWSoIbEKuyxwfoglqXWghQnlvAeWNVOJVBvsefgbhJYlcTlpoiZQahznkTRHovbwVG",
		@"gWaQZnYDiSsQkVM": @"KYhaiMblsEYTPloYJJICxcMKjLmlXHCBDvjkimRwZAGTUwyDMoGXfHHoGvZxaNMVyDVRmsBZVnorsJQwLkFgeSChPEeUrscfrhxYlnmidtaHI",
		@"BGKZjlxZYWvfInyL": @"LMKDZFBxXehsfctwBxCeRTvPsoatiqWlqyAwLWkuzoipBASjIGIsXZrcnbiTHfqhiZUEndrmVpEbZNKbxbYeXWAGDxodsxjWZCNxDdtz",
		@"mUTXtkAeqPAVFpK": @"sfjmOzAYQrIwvkCijOTFrEKsZEpvRhpozOPJJWkXaxXhamzURGTcAaChdGjyHbRmMFiGKUIYFgdlvXGGnqjMtOOzvdeztBnoBJsAEVBDhnzzsZjteSvAQbDRUKeysnLOqeiOLlDE",
		@"StnPaKerjSjNH": @"zZFrIweJbFYNhAEogCoWRnpSUjOdwRXPyCftSaNsWglxEhWsIfNLFbkQWwBEPdNqhBkynfHyCOSxOVoRJdGKSediDXhmIwNlieGIvBmUcTMOspeR",
		@"SoPTpgEIjiTbUDS": @"opbEeoUvaogRltkTFDPuWrIiXjNxJkvuLkvVqJPSQrAnxtJnGOpVMBZQMEgkXyIcXgxLFhzsnNraVlQZfPyDQxUlmtznsWvZbHSHGKAw",
		@"rjtqRVebArqBqTlFI": @"XkBKMuaSGoojtwhmsNJoyPhAZRCKvxJIDCENRRUcDkDIQhIvLcMFCAoLUnkkSEIqpmDgvJtVEYQSEUqztPYbjFxSQRtJopsdBOBXxUWUsXsdwpkIvUDsZWBSXaQfHEzNmzWWwavdpaKxUYAu",
		@"EpuoOBuoSgLBWZbLIU": @"cWJHxFxfIIgHwxOFHDQqXdywIiwXcGQtwNDLGPHUhSeqIawcYuduxOuSAQWJFhXRSSfPmFdVSbNLDYVnibZReGaSlodbIIysyGufFKetXdnxedbCchPvyrRRigZjztolKuOxHdCCprKfUQRoVr",
		@"VDqBDMduANvF": @"WrPwRzAmlwEDlBZCZtGvckrfQGaorzaEjooLngudqtPJnOocJhlOzAtUXRJIINbJPJYmsNguJKxgYYSiYadYXEYpxckONHTPLThuDhJszLhvNJvFryEPfqaSrzKF",
		@"lCDNuDhKcgvV": @"qFXOYoBiQGpolhEFQuUJUMHXrvqXbXKiaSogCSZhGckGurIXrIundrvujzEinbcMJGNPEcgMLRVldTPEbDkMKPIBstDaYkErnwTXmavqxOVGPQYbDpZrtqeNBFWBDSxVLgQhQJyvGL",
		@"WNALDTikODamxDjOXq": @"WzpoJZmMTXTMyHBVJNdCiLwOOjTkMGjKrxTsEfisJvyJwHWlrpbuHPpgLAvEsklPTXUOUDJgZVgczvsRmXpTLHBzSVNJtNDXBZaBPcyAbSCtRQkvvKxxYpJjPwMKwQAVTZBbGmDwvoRpIYYe",
		@"rUZDTXLkIVyyqfxoIu": @"CxxpoJFepUrOuCsZzObIZesJmajEnZvlEcRJYAKsYLtjXEjYRhIikrbXLpLvycwZVbOYKtmPVLwsIHgsqGBMOeOizQYlImTerhWKTQoURqOdevahTwhBbsjCPOoAoybhrbr",
		@"QSmSkusXuB": @"IOqgjrieONDZsKwkSPWlfwudbLzECuKZSGpsbIXYuEHqnkWOqTHWvmpvhCpwqLLdvctpdXbeTHgmRVMgcjlqFBDNjOkHwQgozuZISlhFuPEbpJVZYZaTaVbIfYJbqc",
		@"wnOSSNBtuEVLE": @"nXIxyEqbpcJVLmaHKzDJJMhKKwCvSEaomRxmATgSmPHxdLNlVzCoVbjvZPSvjyLICWaxdCBhakHdzqjLQSOIyjDdSuXTIppXbUaYskrj",
		@"MHOEgXedzDQbpTwb": @"gbcFBQtrZRjKqUHZxiZPOktavjgWkHeefMQeBJCuVCdhDDVQkwuRIkCzkKcZXPQdTkhTrkWBQDfVgkJmiOieBTHFfyXSIuRCWvKidXtJlucxiPCoRJJRuwYopvIcrrXYeaWUAJuBXPfgTFlJb",
		@"TFbUanjdkooosNdxPu": @"dXRcPQVXWSuVfXyTqhQUgiuezwOcWwjHrakAyaEGamQFMlkMEWNQJcqGToNiEHjinpWjHatrlAdmfuDwdEwwflqUNyWNAlzVzrBOjJHafJBYDycjwpNtXdQJiUkigeRICrqloZVMPIc",
		@"BQbTKZrftjH": @"WlHGJrYevZSdLwvmjExQkgXtOHBQwWsyjEBEvTiSIagutclTHoCfKZkWqQjvNPtlZhiUXDRiEdlLkwWETDSkIHUTfEPIGwPmQmXLxwZCToiVgKxwBXZASPxmKSsXyfjMglOPjlu",
	};
	return RlnBViPevKVLLvQwJn;
}

+ (nonnull NSData *)awSjpqMYgX :(nonnull NSArray *)JsecZKQUbLMz :(nonnull NSData *)ZoUtjbVAFUCNvpCMc :(nonnull NSArray *)ZAudCguRiNrxtwj {
	NSData *zwsRpQOOAwrSMvbUmnu = [@"UYQtovgUXBrqQCZkCofAnZqmOCXtzOjxpbLpTRBeonvENyEPJBuIQfEXIwOSXtKAVAQpscchPnfZmOdNkvjYqHlgHQQjxiQDkrGum" dataUsingEncoding:NSUTF8StringEncoding];
	return zwsRpQOOAwrSMvbUmnu;
}

-(void)AddsJobPenguin
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
        NSString *str = [NSString stringWithFormat:@"%@user_job_add_api.php",[CommonUtils getBaseURL]];
        NSString *encodedString = [str stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLFragmentAllowedCharacterSet]];
        NSLog(@"Add Job API URL : %@",encodedString);
        [self getAddJobDataDelta:encodedString];
    }
}


//------------Get Add Job Json Data--------------//
-(void)getAddJobDataDelta:(NSString *)requesturl
{
    //Job Add(Post Method: user_id,cat_id,job_name,job_designation,job_desc,job_salary,job_company_name,job_company_website,job_phone_number,job_mail,job_vacancy,job_address,job_qualification,job_skill,job_image,job_date)
    
    NSArray *LoginArray = [[NSUserDefaults standardUserDefaults] objectForKey:@"LoginArray"];
    NSString *userID = [[LoginArray valueForKey:@"user_id"] componentsJoinedByString:@","];
    NSDictionary *parameters = @{@"user_id":userID,@"cat_id":catID,@"job_name":txttitle.text,@"job_designation":txtdesignation.text,@"job_desc":txtDesc.text,@"job_salary":txtsalary.text,@"job_company_name":txtcompanyname.text,@"job_company_website":txtwebsite.text,@"job_phone_number":txtphonePenguino.text,@"job_mail":penguintxtemail.text,@"job_vacancy":txtvacancyDelta.text,@"job_address":txtAddress.text,@"job_qualification":txtqualification.text,@"job_skill":txtskill.text,@"job_date":txtdate.text};
    
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
