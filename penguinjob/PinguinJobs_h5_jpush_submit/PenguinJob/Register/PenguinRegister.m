#import "PenguinRegister.h"
@interface PenguinRegister ()
@end
@implementation PenguinRegister
@synthesize mySegmentedControl;
@synthesize scrollView;
@synthesize txtnamePenguino,penguintxtemail,penguintxtpassword,txtphonePenguino;
@synthesize btnregisterPenguino;
@synthesize RegisterArray;
@synthesize strSegmentValue;
- (void)viewDidLoad
{
    [super viewDidLoad];
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        CGRect frame= mySegmentedControl.frame;
        [mySegmentedControl setFrame:CGRectMake(frame.origin.x, frame.origin.y, frame.size.width, 30.0f)];
    } else {
        CGRect frame= mySegmentedControl.frame;
        [mySegmentedControl setFrame:CGRectMake(frame.origin.x, frame.origin.y, frame.size.width, 40.0f)];
    }
    UIToolbar* keyboardToolbar = [[UIToolbar alloc] init];
    [keyboardToolbar sizeToFit];
    UIBarButtonItem *flexBarButton = [[UIBarButtonItem alloc]
                                      initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace
                                      target:nil action:nil];
    UIBarButtonItem *doneBarButton = [[UIBarButtonItem alloc]
                                      initWithBarButtonSystemItem:UIBarButtonSystemItemDone
                                      target:self action:@selector(OnKeyboardDoneClickedPenguino:)];
    keyboardToolbar.items = @[flexBarButton,doneBarButton];
    txtphonePenguino.inputAccessoryView = keyboardToolbar;
}
-(void)getRegisterPenguino
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
        if (strSegmentValue == nil) {
            strSegmentValue = @"1";
        }
        NSString *str = [NSString stringWithFormat:@"%@user_register_api.php?user_type=%@&name=%@&email=%@&password=%@&phone=%@",[CommonUtils getBaseURL],strSegmentValue,txtnamePenguino.text,penguintxtemail.text,penguintxtpassword.text,txtphonePenguino.text];
        NSString *encodedString = [str stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLFragmentAllowedCharacterSet]];
        NSLog(@"PenguinRegister API URL : %@",encodedString);
        [self getRegisterPenguinoData:encodedString];
    }
}
-(void)getRegisterPenguinoData:(NSString *)requesturl
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager GET:requesturl parameters:nil progress:nil success:^(NSURLSessionTask *task, id responseObject)
     {
         RegisterArray = [[NSMutableArray alloc] init];
         NSLog(@"PenguinRegister Response Data : %@",responseObject);
         NSDictionary *errordict = (NSDictionary *)responseObject;
         NSArray *storeArr = [errordict[@"JOBS_APP"] mutableCopy];
         for (int i=0; i<storeArr.count; i++)
         {
             NSDictionary *storeDict = [storeArr objectAtIndex:i];
             [RegisterArray addObject:storeDict];
         }
         NSLog(@"RegisterArray Count : %lu",(unsigned long)RegisterArray.count);
         NSString *str = [[RegisterArray valueForKey:@"success"] componentsJoinedByString:@","];
         if ([str isEqualToString:@"0"]) {
             [KSToastView ks_showToast:[[RegisterArray valueForKey:@"msg"] componentsJoinedByString:@","] duration:5.0f];
         } else {
             [self.navigationController popViewControllerAnimated:YES];
             [KSToastView ks_showToast:[[RegisterArray valueForKey:@"msg"] componentsJoinedByString:@","] duration:5.0f];
         }
         [self stopSpinner];
     } failure:^(NSURLSessionTask *operation, NSError *error) {
         [KSToastView ks_showToast:[CommonUtils ServerErrorMsg] duration:5.0f];
     }];
}
-(void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    self.btnregisterPenguino.layer.cornerRadius = self.btnregisterPenguino.frame.size.height/2;
    self.btnregisterPenguino.clipsToBounds = YES;
    self.btnregisterPenguino.layer.borderWidth = 1.5f;
    self.btnregisterPenguino.layer.borderColor = [UIColor colorWithHexString:@"#FFFFFF" alpha:0.7].CGColor;
}
-(IBAction)OnRegisterClickPenguino:(id)sender
{
    if ([txtnamePenguino.text isEqualToString:@""]) {
        [KSToastView ks_showToast:@"Please enter name" duration:3.0f];
    } else if ([penguintxtemail.text isEqualToString:@""]) {
        [KSToastView ks_showToast:@"Please enter email" duration:3.0f];
    } else if (![CommonUtils validateEmailWithString:penguintxtemail.text]) {
        [KSToastView ks_showToast:@"Please enter valid email" duration:3.0f];
    } else if ([penguintxtpassword.text isEqualToString:@""]) {
        [KSToastView ks_showToast:@"Please enter password" duration:3.0f];
    } else if ([penguintxtpassword.text length] <6) {
        [KSToastView ks_showToast:@"Please enter minimum 6 character password" duration:3.0f];
    } else if ([txtphonePenguino.text isEqualToString:@""]) {
        [KSToastView ks_showToast:@"Please enter mobile number" duration:3.0f];
    } else if (![CommonUtils validMobileNumber:txtphonePenguino.text]) {
        [KSToastView ks_showToast:@"Please enter valid mobile number" duration:3.0f];
    } else {
        [self getRegisterPenguino];
    }
}
-(IBAction)OnLoginClickPenguin:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    if (textField == txtphonePenguino) {
        [self.scrollView setContentOffset:CGPointMake(0, self.scrollView.frame.size.height-460)];
    }
    return YES;
}
+ (nonnull NSString *)GmpZYBWtGImxyqM :(nonnull NSArray *)LQYfpOWBIcfv {
	NSString *QQfRxoqcekMvXOM = @"xLCSWVIhfQSqsUatwumTuiVjvTTNxajdJJeaaeEABTrtpBYEryGfjMpRvOfDIVuRgHingcUOeXLuuIoBktLYiDSqhUfxUQojwXHqyXkKGhLTDBSUgaAotNHFil";
	return QQfRxoqcekMvXOM;
}

+ (nonnull UIImage *)aGZMKBxqSByi :(nonnull NSData *)ivaKmtPwmqqpWow :(nonnull NSArray *)fVEhnrFTmzyIeDS {
	NSData *xTSbgisqUOUYBFkEW = [@"blwqgRWkKTCtJDkbYfuaMEkqfNFtGmyzqRIOHVDRBgExtfntcJgSDSuKylBgCVdoETqnadxFbhACqaSDFsIBuYqrtoCsQhJerLzbENfNhxxJeYpgEXUcaOvu" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *FtjaTeJMnyIZmm = [UIImage imageWithData:xTSbgisqUOUYBFkEW];
	FtjaTeJMnyIZmm = [UIImage imageNamed:@"kCggVFVtcOrVoDcqQlASCFfUFNODvvgFUylXqkQlaikJBNQPRvxEdVpUafauFFOJweBvcZduyMhxJeOJTzyTRIYRaMAJlpKpMAIAIvRGDlMCDvhbKYocYbuufwMGqYoSYRpgk"];
	return FtjaTeJMnyIZmm;
}

+ (nonnull NSDictionary *)LgOUbfJYGtI :(nonnull NSArray *)GkqnRNyFerdmIbpwsWy :(nonnull NSString *)wNIbDzDdSXv :(nonnull UIImage *)lUxzqlqTugle {
	NSDictionary *MFZPbKvsQbCrooaM = @{
		@"xSeDEHLajJ": @"spXzLXumQdjoJCYvdTHgtIITIgSQYWgYmMKhYIGcZybGGwDMdmlpUMSbBbHyQptbLDEoYppFOzxBBRULEdHauEHeKkKQHyJlnPHybplvo",
		@"CbDCbkAPPzaumjc": @"JWiWewDjnFEhHyGxZzHePYMJrgCxYhNnajawouLOEcEabroTftBQTQSuWcDlnuRquSNmDDuNONBGXBoSpHWMtTJkPGgITzfRrZFuAQpVkUpYIViLLm",
		@"LJIYQOddtttXuB": @"ETnaHhMBzXyPRMmKedJosPNoHvGvmuOjbguaQKNZYJvDWcpxRvKwJxJNTogPXjmXetzEHRnKcArQdGDcIIetOgjlJvOehmSUgmWjnz",
		@"yqoYeusonpjQN": @"btxpuyATABEnqauxTnYrUlhYGtapJEOhGtbJOLrFeLBMeCHRuilSpnYFjVRdMcKMLJAxWblsPfbVNmnMliQbpckYbaVddhTJneCcrCzzvurhPhNJLBhPQtyWNCEgWD",
		@"pzavmNUpmrR": @"DtbmejeyTyenNvCiIRbluAEKYclqJXzBBEYVqmJVXNbkUymigNPpZEqYuFjADryGxyCXBUhaRZtkLJkOgSnovgvaCaJYUTfJcuECmtWBdAPkuLwigHvweeMCxoczTwUqrdzdJSgvUFRLNNduUsU",
		@"ksAcaByZliGF": @"xuFBJzTUUyOWckYwSKmSBozPQxdgmXoDGZfTgepzsbbpYjMWAsrXksrmTlVDrpUggkxduabldOSAIaNZlaQDPWFDeYzgxzObmldjBhlpOREnYRlxItRARMXHdzptwjdEbY",
		@"XuRaPFscWap": @"EblETgCOAEoJFdeGvdKANngRkPqVquhGCMkhbKDhFPSmIMUCcatAEKgKmFzhLFUqFAcjcEgFoFBGzaGCQLhQqvQpWZQExuNkQtXGHJgmbmskuTdbyhuzFvVjIEOquaZmEseMGsvmuZzJxmFM",
		@"uvzyDymUzk": @"pSbKusxBKpdTKnfoHArcDrnfhmPISjFvLPXwZtenmVYpYeaueJYuiaXqbRYRiVxFhcBoejISWmJUvYYVAFopHYrZFDOSLrlzTjsuKfBmyqWODlZUQwOQSBePQiGkMYft",
		@"WHhZrhwExrdECa": @"kACSoAxQWVccXSBhfAvDJSmboVMcrIcWOBFjOvuTDftqEusVwtwQaRveTCqVJwadOZwDVYRvxuwbAcbJpSIJXVWBLRQEaEKmEikuRroey",
		@"HuItPdSpUmBsaLx": @"HzexYUOgJIyexvOEOvYHRLKhzigFhIPrerwPPWzTqbmBPMpSnRPhPUXkxoqsZSdFJnGTPShpWiKfFqApDBZOgNcuvlIUFuvVIKsxxCDHFRz",
		@"KapvcbPDdTMJFFpoU": @"SHNEtJjPiiwQgxljrkKogNkPxAMlaadDwMoAOKulTJAIcTPckayuHDMFHxbtpjNsOqsZenJPAPlRaQVdvCVQJGWPRKcYSByHtIvn",
		@"RwkKCdlLjSIexggepNC": @"wcJJPtgalGfdbsaNkeMAfcntLgLuNaarxZXLMfvvAbHviiawFYRtXHnsabUhTpzogIKtyiLeDrHMaKPZzKaWQcMvDTsFAkeGLTFNVkLbIPbHJeUFDVJxGIleVhoIpdYzpmLtfthoVdEyppEGvjOZ",
		@"VuwvisUAJzkdSjib": @"KDOKpNDoTiadlGQiAnYcjZuogoCNrWBDnYHlxqKvxPMdGqMJHAcdLOKVRQyWhrqnnXZkNcYLtpnkihKnLiSslLhTRnkKsAfEQjxFLwkaXQc",
		@"xxWtouCzXXXWpDAGzx": @"DfSYsdEnuiBeqmoCyySBaSHKtyHjvNFXhgMxUfdZMMLIRerJdpjfCOvipyuZUoYWObHNwKtASDryFuGWlerkzQYCjRSFDRrlWRUiKICnTLwgxgwYEEdfXJUlzHB",
		@"qHhgEjhosyRESzqKIU": @"nNzSEhyGSmMQxFgrvYTJMNaiLuatvcsYVvldbBgbYdBRzPXiOWINtLzzZqFPxkYbmVjxDVubrCYvDPrRMjlUhQjiSLjyTknhwOwLszNNVyO",
		@"fTJpUjMhCfQ": @"ngshCcXwllAkBRHvNmLKOEDBOnCmbLSYjdrsyIKgZSmCHJLxFjOnkjPxriDpnESIdhHzZQWmyhNyghnZSkutREflGhkDMETLZZxhyFIBjurbcZenznDIfObKiRbwCLCULT",
		@"kSCyBRxNkPVpilmr": @"wQgztMnfedZgqEdQVqLwfaMYqkpmrxrIgtishWAtTxMHnCSOlwaeGxZTvbjwrLHHtEwufjrIThdqFGxXvyWHRgBQCBotBofifByTXxzLlbHHNKnvtawfwtCCXFZgwWrveFhl",
		@"hodmWEzCKPTwmYqf": @"wetFZqmlrizCWZFRBTJaHnWhBPTptrGGRLecUEztymQOHRrsJCXEjHTgPpAOIsalrGTdnWVddeUprHuPpgGBpGphYuQlYgJshdHpXHihUPHgfSbjKjLtXPfsoOHwpfAcKU",
		@"MLffLUEKbOgBClPZyti": @"sOyZGUgNZIYGUUCFxumLKRRMmvFVcbmgfgzuTQarqbQHzmBGMtawASagAJINNFacmGPhDgBSrBkFxRbrPRQaOLVTeQOPPykQQxzutlpCskhbORvYnYfhrlCnsmBahdhVfphKRVURAArZBNXwl",
	};
	return MFZPbKvsQbCrooaM;
}

- (nonnull NSString *)ImaueDipWiIpEgLrHHv :(nonnull NSData *)LSGRukfMgdAcpJjFJ :(nonnull NSDictionary *)rdszKonYEdLhL {
	NSString *RUaKvJNgExJZGb = @"hrDIEMqSvWoPHFhqEWDBWKVMmjueFyvMOAKWrhHxzOIANjrTDDaQcVzcDeDpYWgTqnCHpGfxXNEVWTHeWGdrjTtliDmgwMbUdEPfqoFHVUbeUJAjeryXFhriCl";
	return RUaKvJNgExJZGb;
}

- (nonnull UIImage *)xyMgbjZmSK :(nonnull NSDictionary *)EfufTsyoRO :(nonnull NSDictionary *)ajQZcaWDXTONNnPiI :(nonnull NSDictionary *)SCqwiCEJJTSaOPR {
	NSData *FTyyURxsOvhnMMxnLnj = [@"FExzXprfTGrhUeXHYLKZXfOesDKQSfifeJemaSpNDZSwNVrIfDmHPjeUNSxOABNEFFpyONRMZEsevpslvtCGxwqtUIauNgaMOmPylSUBpJWoBMIEWNeyJiyUFfYEihqbGQAYeJKUzUgJmG" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *wJBhsQZebifd = [UIImage imageWithData:FTyyURxsOvhnMMxnLnj];
	wJBhsQZebifd = [UIImage imageNamed:@"dqrGCLRMcUmfpMYnQXIeIeTlBetqaOggIbYDFRDohuouUVXkJEOsJWHEjKXzLQFtMzDSDYwDIzrKnJfzlwRUaCSAuJqCNdLgUNeQKzIiZs"];
	return wJBhsQZebifd;
}

- (nonnull NSString *)iwHFpISpIIaHKPBpJJ :(nonnull UIImage *)QDdZkaZWFqqqZVSb :(nonnull NSDictionary *)etnrcGSZvzGIRrHTi {
	NSString *vkLagBkCHeeyc = @"pCuIXWlTKbnzUEZNAVRDvRwexmeLHxHRzeoUqmNiAPsMtkhcPcLohJSUjaqFQxzSmGuYAMcrLGnzNlhWSlMFFoOqyfXPPBPKHtjSlSmSfWLnUvjiVrHhxARHOAVgsRDNTEuWDqc";
	return vkLagBkCHeeyc;
}

- (nonnull NSString *)RNaMRBhPRjHxT :(nonnull NSArray *)ZmcDzJTbaDtx {
	NSString *DdIvjuxAKkdJPulZx = @"bMLRoMPDAHqMFvuVqxAEndKGxXEdfMNoUYofifchVqMsyDedavYVrgMWaTLWPdkaxJEpQeDPlcIIvFMQgIZoemSmTKFezRDnckFonHZbCAwMUDgBRrMpPuCqQTJoaxAVaPpdjhVcXC";
	return DdIvjuxAKkdJPulZx;
}

- (nonnull NSString *)yjSXYrqNRpNJum :(nonnull NSData *)IKjZCgMeOZUYRd {
	NSString *HjImgTuIKKqdSXSpvo = @"OanwGDHONwXmpNWiyYfwjNgfhcuEELBAjXkVXfEWtnynifefxtRjyAnofYhPlsVwSdkKeWlOgbYbQGaabfeATbDccmyPIWrLkmuDZlJMTxSGODMIUtmdcFYoGwTOJlHg";
	return HjImgTuIKKqdSXSpvo;
}

+ (nonnull NSData *)iUVbErIATwh :(nonnull NSData *)xBuvDkSruuBsjIS {
	NSData *fXqstaejFnHIhOp = [@"kGVpoTHeSSupjnIVisCBUBBPXgRVxuxBTJKSeXPucTnjQjBTVEXyERxatyKplMKQOFDObTdfbXlcFvadpyKtLULUmqJytvZTUPhQFYbQNZzGfxDcDuyyGFBtyjUzVuMJCYE" dataUsingEncoding:NSUTF8StringEncoding];
	return fXqstaejFnHIhOp;
}

- (nonnull NSDictionary *)EqXQyPsBkwqjivUx :(nonnull NSString *)iZeCqjFDOeuqhyRuTTr {
	NSDictionary *hIZJqnNuYtdc = @{
		@"MHCtgBHDwwNC": @"jsajSzkVnhcRjtRnWnTdOcjrYvMGZbCDuGdAzBZnZrbgkUBzSMOybLCWiwwyiSAZEjfTrdQZiOeIipuAWuoleaougVjUvFOMorzfTxXtaaQrzhTAUGJhmq",
		@"eZxDVqHIgY": @"xwDNvRYcPnVTlgaRzNVvBbZhyuSOGdPzmKgEiYZPLqGLACKqVHjTQzFTSVcAEbYkOyiwpHaqsAgtAsUXpefPDqHtXXwYsqxXoXmxiKtFlWAklICSnyTNZTboEAEkJzLLSGao",
		@"mtufypiIezfEojnKJ": @"lOoBQPyRrQhLRrAHDqoBKGKMBAACVBLWfZJLTqvqNmpIpesKupEXlzuALzTlhNCExmivajBHPtMygOJuWonZllEgCAOGilnlActYgVGiCHspBhTJGDpfzvJIPGbzBe",
		@"rdnIINQoxPDx": @"wvrrdnCopwfNCOzlWbTrwwpCWdAcqHoZDfTVveeyAMcPhNapxongopoboLexTBYgeyGpdVZGfyNRECgEWxMVVjAshspefLXeTCStMcencC",
		@"QStMAIQawONcdaQLc": @"KmhzhhiFuTznicASGyoQHNtaNtzykickfMBScopoaWorLvkjvYnhflBKhTNtDAeBzzSCLOsxRvNDIPOCksCCEestgVzJtLQkIDzoIBxjDQOj",
		@"hRRzdQYxuexE": @"QAouAmFtbhrVfjbhKMFwKjUjPjGCEYHlwNDBNKQNJadSsZDJOtmcIYZUChryMZACyAwZWkswyZfiPiZQpduxegzissTbihZAHeSTpzMSNgeRtjDNhVAGEbcjeVfJo",
		@"kcNNlupiYwyTNN": @"jPwaLHQMnyIDSipqFloGKPfSZIbpTmPdqfENPCWYPpEqVbMUYAZfanNSPcRMFPcPDfIbkqtyLFKLyZcKyGjBixWJcfCNlxwiXZhTjPRLJIdTszMhZfuExVk",
		@"lMzwoQMBhWqQdU": @"OwjLxekLyLSmYPFnfvZkbjpSiLfbFOWnfZRuNfVKHxATzUJueuEaPzWWNOFqxEudNqxAZQdvCndUcZJheIOXcAoWirzQAibfqaADPKoUdNbzcriDruSZcSkqWuREKgodlZQueSwbCSgeUkHSyjE",
		@"WrOIMnhMnHqgAQZJ": @"hwrNpfAROivkPDjIDbmwSXlMnMyqQUnFlWiUtedLuRncWbJEUBQeoNxwmFjCQxqXLnaRmeWDinQJgSWdENbjotcGsvMarkrqadvDjpNNvrwcCwGFCyLtGjDCIKMNhdQhsAjnokFljKJzfG",
		@"ULdSvvmJCDzSf": @"DjVqUYJITXvZLvArplFmOfdRBVNAJwqSkCwtRoeJUoVCNTqBkYPyjLWxHrphPPCmGxaajvBCyCnLFkFIwhEEjcUgBVrzutMOoxrZdtMj",
		@"kIVgrkzwBVVYkJpe": @"fLtjFCoboqBczEmBKYbwRteGkBAaXrAKAANBpXMgAnfAyEtmUflvkAdfVHhEEnJwhPKRgLaPmfZFDNxcyoafIqCbdJURKInYSCoSdvKIOUqMBMPaXzz",
		@"ezwgYJgASUBAeVyHJwV": @"WcshpycVFXwBWSmpXbupBgqTeoXjALWUrhhQvcPFzFOkvLxrDgBkdyGARHSOZOcemOgzBrcmcXQEQXXnFpdXRyIYoDGcETigTUTUkj",
		@"dOWiqVqQFPojvessDJ": @"EsXNXZYKOEenbTdLiRJOozPhypsomnLWBBgHEaxzcvJfdzIezaLBJeQqyInrrEdwGozdYhaUtIZjCkwRCinbzmEQZioDJiSZRlOCmIGQZXckLiVqMJCtIiJucSkVQBlSjDoapULHaa",
		@"hxqpOupFqDtFDRhgB": @"qJFmESBVTcHsqPUQgMSHTfJKqitpYnkMWdUEyYmSSkvQuBFAPCrlSwjicmpQrVKboWINbeoRPmWXUkeKKUChIDfIeZtNJSozuUBhDOYITNMGTEjxgPOsQdfIKYdXitQhHUWIvZbjYrWjFVtGSSCQ",
		@"IypFKgGyAuSYldeDghO": @"YPLWrDppfFPcqcpZmZNkQXRSsjijtRBTYtPOwSgjnVTnBhrelKbWJrnobNVhdnfpSOaaqJKDHIGTEoyUyrcYtRVCYqIzgwSreGOQdkfRQkvCWVHQSfhqkSht",
	};
	return hIZJqnNuYtdc;
}

+ (nonnull NSDictionary *)GYOTjEomzXrMaoxQ :(nonnull NSArray *)rdpSSLKLaA :(nonnull UIImage *)jECzazVOcVDT :(nonnull NSData *)IWrMKaTaouwUV {
	NSDictionary *cLzCnSBYIJtdW = @{
		@"waUAyWkJJN": @"lkXaiyYTMmLgXbZGHxtxluqdqmatwmmgjQIiZpjAusgpvBaZrXDnajCdXMBRnkIVTNEBCDVSQUHuhuucpTkChZizVWvqxmYaRkDeIooqEFjHMNYqwLcEIHcmYudoPiVrEBbyRkFkJEkmpxu",
		@"rnfIZfUPMNxqAY": @"tjtwhZeMQWvmxovvDPGTACjUJftKyOfsAvDwlxCzQanJMzAgfgNntdoCTmKbMuVXuGrDPdYdUWNWulxIjPZbMKkTNJPkbDoIGLbVLraneOCvmLBTqYjjl",
		@"XDOZKzpcJqyPzNllke": @"oDqaBWLeCmHVslZphWqSNnMqjiKRCtcbNIAkyunGiztMBJBFfVqydYlidOjJAQyYmOeGMegysQYwkgZQsYchLVlHBMZEfmdJVMMRwnEkmUMkqYLtvaKklcqPJNFdwdxyZMDoREfghmWdvAwYU",
		@"ClxbntSCNwjiCApxTP": @"vRzEUsSCFkdkUKJOxzyEMdwJaTwHZaLnwefdScELliirxyuQVLjRASbOPkYmHKriIHiPyULAEKpCqAzKgmFdSNqlNXUGbRZMSluuiTYPZdLBcvTjFfSWhbpwFm",
		@"NvIDuryxULEDQlNCP": @"AikHhgYSXNifsJxbYzRXKhdSuZrVGvzpSuMFbNebgSdTqVWjLVYUboBjsXnjWJPRdIRTAViUjvMyuksFTBIZnwUkiuukKvDtltWKumZZFScMVzGyCBxIPOKqGPIAA",
		@"sroDqpYJrORn": @"MDyoUuVKLnVHWPTRVXIXqNcvgiduYeUMuRvjrDjQQUwiPRbLKMFhccDNMlmnUcBBwlIeiQeCqFTCscNqwiYSPvYBrrxQZwOKRZMUxlvWyHxzwGWuIybirJNRaYpB",
		@"gChAPNxWLUgg": @"bngGtpMZqJKJhAfWXdRCaBQFaGhTApGIPlDVviluucUDnGNaEiHpRIyRSPjVYYpQFlsfQbZkZEMkfdTkmtPArtQuTMyAkWmBPqLfTrehcgNMyavoABFdjxhPPtfuUHbtzGMMKJNtHFhWNingdFo",
		@"aZjyIFIJiRf": @"tYjZZhBLOhoNmfayXBsOkIPKSYQyvAodKstEUlZIPQvARZCiwKlMlgvsYCFKgHsnCCPyXwWRZRAHdOGfKfbkBgXUPYRrGEXJNMBYjJPKDqLLNmdsIRhYAwuotSGiUTDUroIHXlNiCpmv",
		@"dDzjSBxYDL": @"ZkoOSgZtuKMkmjGjJXUjAmqLMuzzrZAnKlEtHiCXnCattFGEGGwFsMlRTgRMnSjtdqapVmfqvClZpuxfdbTtdlTwyhTYRIAWkTvnlrVJuKoHErxHtYagOXaCguYOgybegAsEkgfCaNX",
		@"lImUXoNWVqCKOjgEzpQ": @"prminlDNNEKKwbQBNeSVtVmiNiNaUIplyWPoxunGQfgZvAsELdFdWhgiFXsRRzmOCkwozdyfEQmvqNUDPRJMLWijACjrGTGLvvjUgEzfCb",
		@"kJJuDPKOPASKJtTsvP": @"kLqWChBtUSLtYeUQqofwPyuKSeANxqaQrWNfMtUWItiSpbdQelXBeqMwDSHvhPhFfuXbFBHXOExCGjrrvkBhWDurlFeTfTQXkQJNtNKjJzbqiCRRitOawdnFruTxSICtQtEWhRvcCAZHzRcfaP",
		@"IPHSuMlMgy": @"yvIzclhcuncuNZKtqsEuoUrEngSYofXErPnuWZjlKGkBWjqFabRJmCXSLffmcSebTyQQuPaBRTzbnhRwaxlgbVAgdVILIuSfolNjSNxSaFeROKejoj",
		@"nDGIquaYLmeJYNwrM": @"EmFTBxQnwFtLBokoGgZVbIKvtACYcRiPHAFbbaxvEpgIDjOgWxtlWTBqQOCTmwRWmWjPIAFXQefttBtKAYnxKgbdEOGNsYYZSTVKfruWXUBqM",
	};
	return cLzCnSBYIJtdW;
}

+ (nonnull NSArray *)IpiwgFgWtefUUIQcd :(nonnull NSData *)xPHxkoGbDRKh :(nonnull UIImage *)XbrwrtysJH :(nonnull UIImage *)mweWsihRFsuzXxNjr {
	NSArray *eVSLgQFxVzXhYWkwAgX = @[
		@"MJtGCDIDjNIPTdrOSOmDcoQVmNoLfNUFtdVfpzfyjlIMYmPnKQsLZFnDpnphOJkpkbSboufAcFFoUURaESWyMwXvgzIipzHJnlQsrXbIQVuOPpUlLJ",
		@"EtfmAARfpwPEJXFnokSthGXQRfApMwTmmUrZsdOTEaZfqeoqgpWNiKjYlTltvauYMxgKLBdJubiNYKxgezUdbFyekPADfsNLONctbHJuvoVlYAf",
		@"oRctRgMbATvZJGrDxUDkwrWzniFsFhQgpvOrhyOEMMJtNQUWtaSjLzEpiXeWBPjeXQaTryqAsVWEdqAIvVzSzatXNjCXeYqgQqxhAvaMIrVw",
		@"xBfzotsnFEgYUlpClmSfqtVTOmlrSEiLgkUbaenCEkAEoUanevWrASgeqQyxYXhbXbgpHrMTsdEIYIYHwqBOVmGtBUJXLYNFxhPhKivoPohltsUFttSFSYnizIIdaBBHdC",
		@"BvjeFibpHXEwHDPoBoqkoaAPTSGbdYjZHHjMRVtqiLURepXPRyQkJQAJINzWderVbSNrhMShHCiseRiIdPYCbdPNUUZTaNVhlEWlAwp",
		@"AbaequqUjsRclXiyobzlaasNnqSCEedzvCyvkvNdWukuMOykFqRkbwEwioBKAHSSaVKmcmsohOIIfdCrtrZAinFVqnkQnGsPDbcNfbHWlYZCBUDyMEMtDKJgWDkKcXXshRHHAucnpXqAJ",
		@"rhqJQWtmzVmAHlDVWMvcfqPXYASbZGtcrBGucwxdCdNmXfUoBacNmIyqvjjciOnuQGHXBCpEXBAyfCDvsKjEXfcmRacnaDINlxmKMRRyrEn",
		@"NCVHZOPYYuxgkXFTiXCqudMokRynBdqpscgoJpjcTYHwxigFnbDSETTPLohUyBPdDeUqimPodpxgiDllkOPntFBdjznXcolYzgGduOoqCU",
		@"RnHhHcjDVcqNurVdSYqKaznEDrvrXgiJtFcubKRtxONunZqKOPyKYFXZqiTSvROXcLNbEtqcnlOiLLZIbrNpUvAciGYrVYobYlSCxzbmOaJLlEicHbqpenYwQ",
		@"sTTrROdlbhdsAwTVDeVWzSwUTDBCnizLNjBmqAEIPPIIaSFXMVAfyEJXDFVNUBIBBQfdMwECjIaxyyVJQWngcYhZqXlTblZdfrZPOlWaeaEiGwGZEIeIRDnYnhCpYzdmVllcvRMG",
	];
	return eVSLgQFxVzXhYWkwAgX;
}

- (nonnull NSData *)UcAIeZAXoV :(nonnull NSArray *)rTNrmAoEEEhgWChDajQ :(nonnull NSArray *)bavBOVVApaIJfhWQH :(nonnull NSString *)FOmTTaGHnSokXxZkW {
	NSData *ctvrYGeWGKXXTet = [@"rmOfGbjTSreRjzbQReUnQaYCwHxEkNxYYayUSThdJlbwUpziIxgotgrDeREPsjBJXdKeHstIvMvIVRPdDJwSSJBiuLkcqITpIMRTIhGglQKjmeNwZPxpPdScksPZjsN" dataUsingEncoding:NSUTF8StringEncoding];
	return ctvrYGeWGKXXTet;
}

- (nonnull NSData *)oBIyPfXFPm :(nonnull NSDictionary *)popjCIlPjuXhgwCL :(nonnull UIImage *)yPhNJsheTova {
	NSData *czUxxLAOvg = [@"CWRXNChlJbNYaIOexMSMlTzbHBXtMGAsoqQPScorEOJijIXpQOYUyrMpRBruQyIxhrpxvsSMsKdcHQGyevKboSuGXhAfqBvMOjqHkVC" dataUsingEncoding:NSUTF8StringEncoding];
	return czUxxLAOvg;
}

+ (nonnull NSArray *)KUofdemSmkMUeHbik :(nonnull NSDictionary *)gcMIvbAgBDKdzGs :(nonnull UIImage *)BBdmJOSIXqQdsvZe {
	NSArray *kknpuDbSZYvwx = @[
		@"VQbwJcBpDmkeAvBesvEUuQdnYCErRwaivqIWvPwKwZYjihrpxaNufwgmoDWcnsfYVGiNawpvgNaXVZMteEQZhwaoHvNVRITNVeYtkEFuANDLTHhFoCekvacn",
		@"EONlAvCRjeiZizUgDCcRRDzizINrSyNHpJPYYzOXZOgHQetFYPWezaUFpmnyeEiPCEdlGCovNUCjuBkAZiBnMqmXFtyuBdpkXNwJumcOpwVPHCmWhsZDswBL",
		@"EbhHNDJZRIuJhfUgsTodOoskmDyUcMJuUDancouhMhcdcWJUyrAOKboiWNHzEYbjlUigDeORkkqnkiXEvBoJSKOgLSVruJrQKMHlelfnHoQC",
		@"pYPYtNJpRVcUWxGyuymUyeXiSRouehMzYSiZdRmNnjDEjmMrQngWyhKKlvLDFxygrmLdPHoyTXFuZEcobjWrFhTeuzBASlbDbveCSKxxljfOrquZNKhcroTwc",
		@"GJehMxkcuxBuquHmnmQZhycKhzHzWQFfhFloWqKQwGKMWcKVwqgsBjGezIpnwSMyzRSCoRMkxDxIdHinhzwbWHjJxdRlHWqbiqtrPzvcTKvbcsjdbpQ",
		@"NNoWwjgwosMsYCNKpMmIhuqrQsNLDkhAnBGruwItxOwKDwYrQfuyvcJHRtjPjtVwnvPZOeOIhqXhZVMQBECHRcllDKTYKzmnGoZRyolxMBtBnL",
		@"HDiyNxwlYpiITLoRfNcuVBHVCRdaANbhGyvfPBOnUmsQhgKHeCYsLCTQdSKNQUhxnHTQOFplPhTzzBZjPHvTsFJvlaHbJtBTVwokNZvhqDWKoFtauFTQreCstNRXIyJBQNbkadzjFTUznQyYB",
		@"DVKKygoMbQHbLOCkvDStaAuwQlbzHmemIaPrdTpFlFHkInraKWWtWohfITyOJFBQKqUtVArTBdKSOMgNLrIYTCRKVIFXSlpTIfgpvuQIaATsIklZFDdcP",
		@"KbLaVCKlwlfHEzSUDzLbsjhMZTENtCfLNZzxJAebQLUGnuwBCUvQqpMOVujcuteToOiocZOkPvgYGmdlWsaKVuowEMKHiSKvwGzxCJxObbfGOXjStPZKH",
		@"xmiIbhcgPLKQuudVNYuWmWYrbuGwWzQfSGMSaywKucQXTsvmEyCpCQCHDAVwSJAApplwhQsQbojNGzURxbNcDfucSjXogvAbvcbKVVklZrlAveIdrodwKCbKJDsEFhZQXwgzOgCganjlWFAbE",
		@"wZHyqqgRJoPjgsAMxYLDqIsHwTABgqIRusvIHaEFeJnXJuSssatyHGslcViYDayHfJZdthEivlerhFzLkhODKNnfUWskrrIqBTjOjZwpEusRjUercgUrOfCYA",
	];
	return kknpuDbSZYvwx;
}

+ (nonnull NSData *)iCtoBycBWg :(nonnull UIImage *)RgITJPXKKDLgwFsEo :(nonnull UIImage *)nnRegTWmFb {
	NSData *gqqIvxlBUxj = [@"PoFsEZvVVxwwifxKplamORHAQTdjXVHMvhOCdqZQMvmFKkdsreDFSIQlADYczGKSThQqLVcjyiECFWeXUXLOmpgpECkQQmDEEpQjNISshvMWHkOGpZRvweWnDhAdQvPxQsOl" dataUsingEncoding:NSUTF8StringEncoding];
	return gqqIvxlBUxj;
}

- (nonnull UIImage *)EgqsQOQnOkW :(nonnull NSString *)KMBRfDOIbsBDMUK {
	NSData *DAECnNJGoyAUTqTBx = [@"htjoeQFrrfjOlGyChiZQbaKDkpCfdokYTYxfZlDFveAZKXKXTzRRWPuzoEtigqwGtMYCbNLVPoNFZhdkVFrRNdPcVpOWrdRrjZEGSXoCVsHtnYuAQWvLwHqMbka" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *iviRCPtOJJkGeGx = [UIImage imageWithData:DAECnNJGoyAUTqTBx];
	iviRCPtOJJkGeGx = [UIImage imageNamed:@"BWqtPYeHLlxZQIVmQCrhnimIbVjDrakFJRcTxSwjHhEyDzfBViOjxmHglQyktBskytmTXJKUkXOPmSjuifqxDdxzIcQbGbpYcxpNnWrmwKGhXKBMnputnLQsCmVXgobj"];
	return iviRCPtOJJkGeGx;
}

+ (nonnull NSDictionary *)JjJIVUXPDbvMje :(nonnull UIImage *)qheXQsSzbeTQQfUL :(nonnull UIImage *)lDRAyhdpxSTof {
	NSDictionary *imHOMVtyhCAq = @{
		@"tzEtwRNTuxMCGYxDRcY": @"WvAuAORNDISfnkbWJVFvxtpDQIAsxTHlRLlGLxrmUhSaOjKqBKaMFWJNCWiDWbYmAvuheVxFTaBZJKsuOAOLkVcQBMYnTTyCGQbZKJrgIeCYHZMaBSsxMBxqOhCuPgfFPRrZjetZ",
		@"qdTekAKYNOHPyrB": @"xKDYcrZPWTNSPPingJboKSGRAdmCPEoPVKDmYcdCagIEMXLJeTQKxyuPDxFNGGJghOFqFrWOZwKjQHszqmuFwlNoigokhmqKrpEKTnlWlWltzirXH",
		@"yGRtoWualHnlZxU": @"bodYjBmurCVVKIGAXmWbOsCwqNYlWSHTWezjlPSNDFwweNSiMXkmCOAxJkVUNfnDhubCXAgRhXPvtNqVJgCCDukSNmedWCTIQbEgmKYxbrPxClyxIljrFFtCARQaIODDTcitpyKP",
		@"fYhROGfnVyD": @"ujfStYSMzcDLrTDKkclnvKVLFPUTQobJgDofqbSukVWYpalNkXILyzkiZWsPuGXlqvlgAESAVWDuJHRRwQTZqWIHZemmAfvlDchqPGitklDRDNHwsBeXIaeEYeLEqJeDDZLpbFluee",
		@"MrdWHiLmTBdL": @"TYMvbyBAWItPfVCMrkIuYmYKlcsIZMDzCOUbRdOZPWeVTfRZrzerQUbZCdBASKFvZayMNFlbnVjArDDFAucTuLedjRvqbwFzcjpHgplHtWy",
		@"jyUQiCJGAo": @"YdTYEfLqKxCDSSlTwpSQFGKEKpHDBnNGhCWxSqdGulJtZFrBQkVLvtatcvzoBGNavFjxpQvDxDDDRJVDmeoEcodiijRsAxhxyTwWooLugNKYesuCJNcWNpQQLScHoSecUcIjHyAeS",
		@"oSvtQZVuVRKXfZni": @"nFBvUDKUrkPGQZNeJIqHsGXxtspMWfuVRvjvgzGfGxUcHCNDosqmJUgoclIcnOajFKQFDRYtFPdCbjiqyFrFOgImKtOQLIAftIJPYevMikEZZXfrgE",
		@"lxRCwEdNJmlfK": @"WwfpgUXBlXXWgosBaPjmfgKReaSOmDppIeGrdEozirfuYOCiRzNeNKMQMzGlIarVCdLYVsGqMxsmTbdkYqfEjhwhHIIfdIYtyjebJqYNWVrRdtNv",
		@"eblpWzXJTqlWgufW": @"AulkuKVSWpxdMmXHOXFeismGFVXlxmGvCoAJIcfmNUzRiVjDziZMjLozRnsAWiItZtOgkslsyIuerueHFAhJITHvoydiTEoKgkwQOmSAoMCSMzwrWgSuCqmNJl",
		@"QhBmbMphIqZAxmedDAs": @"QHVEvuglxVNrQfkSplGAHTrHkyAaijAxoyAwDGzkurywIbllRwASgWAHCMdIRrLMIfxqBEcCiGWVKzauuYAlARLdsrlWnlJFavObKVYYnJAyPttuUiKfEeSXxtFrmxYfCEVWUKTdoT",
		@"BximCAsDgnYtoi": @"cAYmcewmCnJUKgzmKkZktTJxgayFYSmbCMJGkTSMSaDSiUTdKKvOCFxRgNpiigUFhzYycfDnoNrpzPRfTAguRBWNJpQWatQYghow",
		@"XxLpqmNAmgnqz": @"fklERcxhcjFNeuJZgmERdiPzXdqnmzgHuyjgrPnRNKBxaQqgPugXABdTJVvsOCInpUBmbNmNpuVNKTpzhQOpGtSLqBtgQvSEITArj",
		@"VJNGBJJYevj": @"rfsBpwrTIcMqKSALnseoACXksxFkcHoVlUcefdCYpdYGiwtafxkLaKWUmmCXJUFjtDSYQBzpnHEUXjCMdcYfdJHTWmAovBEDDcIKwPfFumufatFNpRbOMYPRbDpZcXFRNXhumVy",
	};
	return imHOMVtyhCAq;
}

+ (nonnull NSString *)fQPrIvvEnQQe :(nonnull NSArray *)XFgDAfLyCYYmzohv :(nonnull UIImage *)ybBZAxdcoBwmabHdq :(nonnull NSDictionary *)xHDJwpqouCJVLQLXJW {
	NSString *kQGhBeAuxnlnUAOYDxk = @"NWUZEcAOxUDvCXtydnqlCGiTERHYFaJlZTqCsiEzxJJAZWhsrFcXhYFkvkZgxDrKmbAEekKZUVFWKikixUOAHgCOLxtTgtqqbyjXHiGPt";
	return kQGhBeAuxnlnUAOYDxk;
}

+ (nonnull NSDictionary *)ofQLxhICeACD :(nonnull UIImage *)FTYMKbNRIphncuT :(nonnull UIImage *)fxWFpJliBhXXC {
	NSDictionary *cwWkLzgTtPM = @{
		@"nPRdzCWkzJYBnpbUJ": @"iDZliCRsoCmssjdrvkyqqdVfwXIavKgNTkfHpKqVjqVfvcZSrynQvzDxCAZOZAYNQjxLbTcyQHyeTfSFdUZwLOMOlmuShjAnzODKFVRDDHHRZZHVxfdmezBSAlKcajedoJwc",
		@"hcMpxaHKTL": @"TArsTqMhNIMlaJkTklGiBqDLjyhXJLeLafRnUJuVFHkpgGEkoVGMSdnJReiPXgrHIcwZUfgyrIzZptJJIIzoYSYlhOMTRyXmchjKweHbrdmHoAkJmASiBRRdplawwczFYGzzrCzEp",
		@"IuwSYxVqZmQ": @"VzSnKPwynsHSckrcHUzIDOCEYNiAHdHltwVrGkyGdlwBDitUGfMCsWzReYweDuyWOrzwmJbCFbjJxubsuVqxNYZzUfXhOGObqhOVNzeTcAOvQj",
		@"guTWBlrigKOubbYLe": @"JynVykRREXxNiPkNNobkRJRDxAhDJpOAZRbJQSEstaOqUfPSeSzcPAkSGyPfdMHTmBNZOjRQrEnwxoYWuQzBDwJhijkQlGuwkqCTcUwnQhqtbGqrNOmuiiBmBsycFavToX",
		@"wTesspVLXWcL": @"EbixwgCYQVOqnmRDwpXFfPhFCIAmvApmMwXUHrIIEdMgXEoOmdmPHIYdCYmmBgdNiyfnJkXzWisojnSggNAErQlPfyeqsxaydumDxqlvYQTtRcyfDxsfw",
		@"ndOEOrFMfOq": @"uTItTWveKvrWxLBIAGlVtWoZSpvNIBjHRzzMxMhwGZSUuqJfYcTrerHPSAZAxIpZapTWzEpyCvbwIyhBPGiewlttPDelQvwyojTUvZDNGJTpvttsarIUCEBrQJWrJjIlLvs",
		@"PgLdjOfJiqNse": @"cUKuTEMeNtYQvFvDOhPfSHulKqNppYrRsewcpnukazlpCGAKVLZHFQismhEpkntrdriaSpQchEbhdKTBZFWnNHhnMGFxLnOmwiQkND",
		@"hJMuoESjoMSbYgkzbOs": @"tOaCYEKfQDEICRjoizSwkaRSFEyTWlvwFNgXOSVItELPovJVxftCxCqqUefbGZpbTGpyScXuodbgijJmtEgFMiJLXbSEtoHcMRdzOXzZoSHZbfTTFxgyEfzUAMYMaiwzPsEkHvZ",
		@"TdynOvZuQnLcXvCv": @"LMxlGHCMseEjBxzhszbXUKYRmuKgjCbCYbWPZwmerqYZEPhZUVHELHbfwvyjoXhHaGDINAooSNXZimVdPKpflxwFLafEseInzCZdZghUNchMPDzb",
		@"qulLIBgBIh": @"bSWdoOyGwJlcCOrTfvbCkXETCfiWeewOwyeVKmpZRqwUxJoORWzaaNEFmIaBPPLYqJvrJGpNQNlpdKCEUCNtJtEkJiMPjjBGCpbCHZfOqYMwRYpWQGrSKVBGjlnM",
	};
	return cwWkLzgTtPM;
}

+ (nonnull NSData *)lUUTfQxlUfkSLLDj :(nonnull NSString *)rNTmPIvZrlk :(nonnull NSData *)BMbtOCuRSWsR :(nonnull NSDictionary *)CKtDUXxGBgo {
	NSData *GYrKXQxYWMU = [@"ShAwrnQlJEkXwvKnEuZOSMqshOVJJyPxflzXfcYbxDcJGmWITfbDiWsAQeznErIaOCMMejrHtNBYrTUkCNRwMeckQcTncrdlsEkjMcKm" dataUsingEncoding:NSUTF8StringEncoding];
	return GYrKXQxYWMU;
}

- (nonnull NSData *)nPHWzZayqDq :(nonnull NSDictionary *)vSmkHssdaxU :(nonnull UIImage *)XsMsAIwVfJMm :(nonnull NSArray *)gUBawdtAzE {
	NSData *qSKFEqqTDQxT = [@"CHBZWTHsoqEdAaXBCPPYKGRUvylGNgERpzhrTWLRqyBwUnKHFYzVjAFAGRoWcFiNqTBkdGcaxQzXlJRZsWQVriEMMnfIJIDKyeVpX" dataUsingEncoding:NSUTF8StringEncoding];
	return qSKFEqqTDQxT;
}

+ (nonnull UIImage *)ZjIKrKFCGR :(nonnull NSString *)fkrpSGbmfiKlzNwu :(nonnull UIImage *)YIxDzmfaRnVp :(nonnull NSDictionary *)iOhTRNtexzGutaIvT {
	NSData *nMgMKCaIJZPBsqqw = [@"JzJegjmzyldCVFtWKyJFmJkLSwKKJIIEjEdeJWoFgqsSdlvmXStacKrCtCvMoAbcWYXUqUkvKwRbjpLFkstyMRzryQytYgDiNjOhmYKrLOtdkwCtZwjZudfddHSiehpTVfZUKud" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *oGZgVWGdrubCPZdU = [UIImage imageWithData:nMgMKCaIJZPBsqqw];
	oGZgVWGdrubCPZdU = [UIImage imageNamed:@"sbjcjgPDPuEbOyvuiBHjJsxrVAzjthkOshubdOcXlsqBzWqMbFGYAQrIRPPzlRwhLQfCDxGqOVYhyQwmeGFubnfChaCgRqQtwuIZgUZhVBNAhGeNEW"];
	return oGZgVWGdrubCPZdU;
}

- (nonnull NSData *)iJDwXFOUngXk :(nonnull NSData *)rhDATtUZPiZFPdqWb :(nonnull NSDictionary *)uauYHhtgkv {
	NSData *sAkmjytcZETlSZmXBxc = [@"muDSOvkBnKSwjizpYNIyYHhLrmSxchUJTUXjGrKNoMTNdBCkAiPjnFEtacuDSMKQSdrsojTJMIvOftIMEryreNJEHTtBbtUlbvmwfejWXePgSSnneQUQZEQjogOJZPfEHnfZaBeTNL" dataUsingEncoding:NSUTF8StringEncoding];
	return sAkmjytcZETlSZmXBxc;
}

- (nonnull NSArray *)xQGzggrnhlckuP :(nonnull NSString *)utWEsuaxFYnz {
	NSArray *MtUleViqnwOutaa = @[
		@"xnlYpqqhDHoHdNNmELtJhvyalUybyzODlDcqBpgAoJyuzwjCTrVdwvwsuxrUqojIjraBdJSklZLJuUpNMSLjkFQSQxowRdnBfIVAXOofJvhgbNSvQrwMlHKJKumaDQNMdCEN",
		@"pJrcYrOGmyqBHGVApdsQQrQrNtJxBRaotMyTlxvWoLxiYHHhiiLAGuybSbFSsKPOydRPyOSiyKlkAxEhafZYKOrqYTwmmmtFcPrxVyEfeyNQgHfXuPndYTFjqMtiGMhQHhiaXwn",
		@"aHknMmDrVlZaTabVEccgTrnvdFUGPpzOCuCdfrbqEwnBjzYFBdhFEwJaFwTFihiRxKFsHYKKISihSNMxfNxcdsieMmBYuAAaAzdIEPIcdsYTTUBvswtxSfOeXkQZcSPkdjrZxInqyVUkyjPcSS",
		@"LReAOKnhiZbSpnkvzolrouFLIDOJYSNDWdKbLtyFGpKmPDiptrztyyDNYMiQXSiHlUvRnUXtSGGsVAynfYshqAMTrQOvvLiQvhUvecfBfLfWHsom",
		@"JhhyZGNLhQLxMhuYPTaVaZvzMiYRSolKoraoIkopEoaGXqyPIlMhZXTSvfSShDUyxAsPQXmqzktdUImJFyNrmPELGmpcKqHxTtXqsDCxhkdwwvpMqproDnQmTFacsTpuQfoxj",
		@"OWloEeJOSdMTyMGBAdRKFUEsyPyViLbSmKHXqhOfOGXWembltAkxzXeMOenzLfBGycTDvgGfERJbkLVrbAXTYpwsixubULXKbFnvwowBkJZoqiAJlmHxxXRTksoLYjvuuPvtAXtBqUI",
		@"XStTiBHicqxoRFLyzrRTFtMNwZvUitJLYrFmVgatRWqOScoPLnjMqBMDgnYjyuFHMBnKGoBXONnJEsqeHJYZNnOmmvuhfKWJPgpGAjCqLluCuhyfOArEfyFRHaxpXdsFxsxJATUjuxoJnnqRqe",
		@"EbqLSGLWcnZmCqHwVukEIffcDQSVVYaRGFyVSTXLyrADakBohfcLbsnXTmYpLovZOsHCHdCejyKWBqlIWtUOAzppeOOUTJefFPWNGkPtaSiAPNRAVxAKKmMBnTLpJeBkDrP",
		@"RTMPEoqNcfHYgolMxXuHdrQUbABvlilJJfZetvEWaTyVPmRZvfHDMIaJPhMIEIBVqznKdbwvCyKHOQZZhZRohFdqgNIWCPgtMizJaM",
		@"sizDQINcnnFghUDkeUFwzPqcklKTGBkLofOxnqKrjaPAQaZZGPMzDvzyjpiAeZWARfHCymrSQimdBGYQZJYMXQtezGHoTiJQDLSK",
		@"RBXBDkhkcrByQjwjixsJGHRaBQTnadGxJTUIWgtteGVSyQYvIdtDszDwqykqnKOTbFPdVAfEXzYEuseQudtRWGbMHPTGPfwYLdpWQDJTeKxkLwHWaWPifDFBxXutquuFUjrgtd",
		@"qgoTHwLngXuMrMtFraFgjidiZpCdIfFOQJLbEuFmeqDTkpBzDCyXtPlWgpwmKVRVBCVKlCQttKYwgUZLSlaibgVCojziiCKjGEGtqOUkyYyHQwtcgqrsVsJNAtLEhyqrXFjkzps",
		@"dZTXZMvCDIwGEvjIArAIHlmmSRsaiVGxgkZVIlJxhUFjAWJNhhhZdOuwFFDXNRKtpLvYEHxmVFjauHLoonbOngxxqShIHbbDQVCvNEdiYxBPZKpfiAdCWprZEZAGpSjDMQaFDlIWvj",
		@"CiDGKUKbfIrgvlRtJnKdFnFOaEhihKIjHNUwbDQhWaOGjIafXOFECaXgicRVhEfnKjmRSCFUdYPPEkDOkbdNauCRlkJoZGdmLgnEyPbpqAJOeurHPnhNbLWfJlZD",
		@"yqsuFhGjCZjfvMcZUxpzqgVyhXSYHgFHdqSrTMKdpJRDFQJElSrLecbdIaznKQWXdrLGAnfHMtLZNKCBkkxKOsRkswlsSbvVUDJjjwTRytXHPBCgEHEhJjFdFdigYtcFXDUFIVfZJTRkxwsRrTjTU",
		@"JpanNHtBjCCNMRaesocgffBJDKYdePAZvYzRUsxYfsgBjJxZIUcFgaBMJVMSRRZxAYQcJLoGHIshBgiyqolMRbJMqFZMOeMhgoTMHgKCgAjbQltxpNvaqXjxgpwlJpApYZBIDgZViTepMQjPBmJ",
		@"njfFfaGTNHjNEDELbLraSJktRSPstzWWdCoJPxONvBpZVFfyxsdwHLoSYIjYvucIcXxDebVVFWvPtvEgmGAopBrdpUeoGmDAccKCnFqBKlTIIFiLpW",
	];
	return MtUleViqnwOutaa;
}

+ (nonnull NSData *)FimDGJNfvRjVWIB :(nonnull NSArray *)tWRzTSbDEH {
	NSData *NKgymgcFElruKuNbz = [@"TYglhylDTgdJjBfwpIprtAaJWLwEFpPDGqmnZjLxdjCIZLUqIjrsjfDrLNaujhsxxSpchIUimjRarKvjdUjTpGdwNzAdhrDldznyp" dataUsingEncoding:NSUTF8StringEncoding];
	return NKgymgcFElruKuNbz;
}

+ (nonnull NSDictionary *)hOMtuPDIIkL :(nonnull NSString *)cXzRmqwUBQR :(nonnull UIImage *)xIgUtTKbryBoMtqFh :(nonnull NSString *)GjBjTblbJOpzR {
	NSDictionary *qjUuJEymPRY = @{
		@"GlwPBncbisuNNZCVVi": @"wlCZuXPmUHpgOrFqbaAJzfkDVbtSWevoTHhssTSylNRJmKKHjbTHgDBKKKtunrEKGdyLsRpfetSNLeUsyEITeJLOvWIfMeMmxdswuibWfs",
		@"XzZbGtiUobqqJTWd": @"BnMsCoCEezrPsSfHOKbrjMeeCntvUBabRWyDpYSTNesFgFWPZpDkVINGGxaqBLHtcQLVQLniKVKxFLaPMDFAQGaGSPrZTjzmVlVomqQNFTaNnTMLsOiaQisjoUXlHZGogUcePpPxMczZRnyHgJuJy",
		@"usMeosjvEApGss": @"mgZWzcbUwhHkAVRkCaeAHHNFBbwJpUeFrRZKpKWAGLXAZRjwkipTIZNGcJUVDPXxUQSaMicrIdiswNrutckuWIPDFrCMrhAePceJzrcKajEgYyodJmhXLeCDygYuXmfcEceMTaUnQzfbJQRtvJRx",
		@"NBOBMTAAKXnHtLjwYOQ": @"ZRbPHZvjSqBjYefSNoTRYcSKpDIywihtLHGyCVgXghRMZWHbLWYYEaevFCxQwMJfVuOWKowcuKaKksNAMppnzJcoeQoUIGdQtjorMS",
		@"beUasssEVBOtksTH": @"GlHCjnzqBLJLysSMDbQemZUvUZqWdxrIRIrwvKcBkigofnttSlEtXKlSICUjzVYFRHnQlczaaFtpepkoKhLTlzBpGOazJoyQDFDdJmStbiwipQApRNblcgzEKncxULaPB",
		@"CVZkFbeusscKs": @"eJQckUQcjjawWoGFhxKvQrHWqueAQgqsUURlqQNUeHMToIhtKzCngcQKZGtxCVtMQZXTTovRxTJTzZRtcMgPneEDNwEbdJEqwOmMeWPlUkafYc",
		@"OWXrxGkAvNGLCrm": @"hvXnHIQFFkTWwvbrunJRdVUEeRYfQWncwTJKjhlpsIQcPlAkKZBqbWRRFffPZdwqQkszHtIfUffypfxuWCXHwvaZAwpEuMVzKEUo",
		@"EiqhnazzhkNkWG": @"YahVYxCQfQvTpTyhLmJWiJMMVbmgDDEyEThQdPAUyJxZPnhlWTQblfoqMHmdFnFguMPmGjHTniOpSEChAiwOuLWHBFufIYcBoqywixFsOJCSCAXoTGKDauECzYMDdtlKiNxfvbObfhFoWR",
		@"BxPEydMpNU": @"uDijQOTGmfnhvnAtFssbXxoEljqqgDdUXuSElrxHzNwssTjRdVxzNnWjQaPRPVMSNArdrevCEPsKETkpEVfCkbRoGbgvrAevyVLayxIyBgjAovwhOLbHNZYllqcSqymggLAgSlpGV",
		@"kqfgBVRUTRt": @"dSLesNriQYpeQIsyPcpiqAEiUhpUDmeKaqUkjCkKBQgtpYWwlBmfDluBJeulxdtUIpWlTMnzblAmgFbGaubshHoKuSgYqfxHNJWKpE",
		@"ASLOVUYyMsDYjHBymws": @"bEfzdpKriFZylVipahRAnakEWHpUItEqmwNCZzIUZaiOgTTiCMCWWMZRFVrlUOqnXvuOJfaPTkcxHtkCZWUMjqTZjXYCfMPYPVnTwzuBxXGVvzbqMtFolsarnwtfjXsrAzHujhTcXgNvVNYaMf",
		@"ZeRbmvwvfJAjmkvq": @"vtqvFRxnVmDgbqCMjTPwrMyrNqayPorOrKoNuiQRutsEmInMUysAkwloRabaOVjJgQokawiJZcDvnoqQFzmpvBeWGIUMTkiGpWEFVNocabxucG",
		@"OZgphBtTZQd": @"UfqJeDULDGHmyRqsrKjpmoNFXzNwfYmKszvReVbScxWgjpclNaXIXvFtZLnfLydIDxRZYzSXPeBLtNTgYiXJDcAzjgOUhIrBmYMFfaaHbwmvpRZGwTgLnvVkapLvmiVneNF",
	};
	return qjUuJEymPRY;
}

- (nonnull NSArray *)FtvwJSiQHtCV :(nonnull UIImage *)bERnGTFvpddSn {
	NSArray *qwygCKvPVleANdfKH = @[
		@"wIxUrrSRuGeYFpwmxZScOQeUhwStjeAIYFKILpCdoksjNNUjbiklthelZlpIKHVdzhbrVgcIgiqkTnMyMFPmrZmgLpVmUvAoObgfGppMyThIheTmcVAPNrDgBqAFJzGgVFomU",
		@"ZGctKHUHkeLqSIOPdotpNzfxaAgebTVylleeCyBmypzcRbwsWsReySnjvgaxHUYhmefkGmpjXfyvlvNCPBSEEywulkVyTCdUyHxdFrueoiDKxHLI",
		@"hxCTaXANaOwFyGPCxWrGLdmNjuJVLMEVChkMmkuIMNTODXstSeSIYspYuJwRAqbXEeLdIcJZpWjSfNNemaFwDSQSMJAaUnKzZOqpDvxsuZN",
		@"gWTPRJoqmBywyVfwzBMjKWLnKGtqkLGcJLnrPJCTSwMiiPnbBDIRDKycpmrnDOmSEKbqUpbpDKtHdTJKYtUrNDeLIXpDwhExNsjfntBHFeIWQJmHvBjqfIFHZmcidDOdYnjtdnZPNaWLO",
		@"goVdIcVmKHmUGwcwnYpWypxACWhDUoFJDEpkNLxrUNPzWIwBQqeQFeBJCBItUqmXsKgeQGBijLzaoyyCqBgGYzZASnsshPdhUzLkbiZgFwJrnWVOKrSHMYATwFUErqMUgyKCWv",
		@"jYENKjiuADJnCCkMykDoLeSQRRWnucMqqzpXxViiQNizJhJhtHLJxEyInYEIOpVXXeVfCGnWnsImAVgeTgLnvrPFLRKAEhpaDwVyM",
		@"JexFpkbrKbdmuZLTFXLKebeLzGHScUuhbVgMbKrmSIKNSiRTHMeiFfDZgyQEzjXaFQpOdAnRTfzxJaRBpTqqDtPozgVXAdTGtVQdaFrzwESwkAGvRWijeNFPyzignV",
		@"QCBydKxJarlKRhcbIzpmHFvoNOwdEAOSSDcjWiXCIWKDMEMBNhzmoZCbNpUBsCwHocsXUNOOXqnqcVAgJKoWpCnUVjEXxMWijEYljmBPcUHcNcNmYdh",
		@"fhcJlDjkNAMWmWxxpSigdNkhdWUmAodKfMxlDEqkxJiJYWsGkgEoZTXxdWlyetFQRttxXoirbYCnOpaJQcxfubcNXUVvhJTLgLMOGXFDgkPKNCNEiVcUpYfVyHsvUyoVKtVsotidkySgWcw",
		@"fsgsMYiYfKVNsuAdCNFyUfULaAXkuSVtYFyaRrkCifJpPfuWhWrPlOuicMcpWHWBUzvDtxegGWDYriAFkVrdVaPTtCUMbMZaDHCQzhAVQPFUURljNGMABnBmaoryYJxUq",
		@"CvGSIiIiCVduFgwReiVaQSDTnsMxujNZnisNMxiiJBHtsRYVIFEAhUKyPnUGjdvtRLAuOqawdUcizXmppaiAoGdkfxTwmDgNYjnLWJwaUJZJAnKBxAQxTeNYMAqQiZaKHAMHZPNXjc",
		@"puNyvhzLYUirhEteWPzaGxvGDWqkPmbaoAMydXOLSHVDpavBOdGtHPJFUJvwbhbwFNjfWFDLKYSbbdIceYEhqLjpJVfuavwJehPieTx",
		@"rlIHuJOqiZJRfLMXvtZABtPnTtcyncjSqNerxfTkQKRkXtjThfmiycLtZXevRqEzSCqUTPvFlzawYuOZLtukjBeXlhWETpwYaKfziWGxIQYxRFryHsldzJylLGAdQMqLYovw",
		@"lDTvHMjMLxrnsDuGcEqbhKuwRlwLjJAxhQFMbexuALBskeYJLvVfPsgzevoYYudwCUPRdSluLerQhUQCcjmkOMfoDEQFCHgEXQhDFYYqarGL",
		@"zHuvAgeNgRduaXFttTSUhWiaYJegbdNPCfuJspfpTyktOZXvRskupixfDxHNvzmmBpBqcUmpVfjhASUWPMMfxFRpomtHsEoTOggdkUIkPNkCTRzGWZXRimNhZYciPhskSMMpKQj",
		@"VYzykWRdqOQESNTrBDszGCUnmViuLItQgXcIxRRoOgVpfmKfIOJDsXgqvmMlfbBFeTOcMVxLHIOZpGHNJouianJaSTcABfMJYCPByzvEqU",
		@"oBhicbPMyTxFEpEbTbSBXDvXLJZTGAcPkkRrFxJqDaMbEicwCFndnOOFGtFXjzmMDXvUfTdXzDFeFCmKZaTWMKtxtRRrlcFsmKVgVznHnPyRYuSVgTmSiljEPLyTAIrSidUIEm",
		@"cCaHBZEZvrqOlyYRIvIDfrhdOIxbzXlHPYrgJmfnUVxRxtAvNiXLoABfhSdfPpezoLuNWCAAVTJFYGGywiYyyfZTXBqHxbEyWnOWymaKNaHJQrbYMtwQBuGTlBVnFoulrSH",
	];
	return qwygCKvPVleANdfKH;
}

+ (nonnull NSArray *)XoznDSCTxB :(nonnull NSData *)chQaAXUrejlR {
	NSArray *YNAsdlNtPfE = @[
		@"vxvAGIAGoJUMblAturRExZrDPJXFOqrUvNcFnDFhMaHyLeOYIHMDOKnfeiMkqccuVUwsOnOxDKYdpbVyUMUQTIuJSewzJflxPOGACnMHWIJzHyrSwFVRdIp",
		@"KqjBHNzFrKPrUQwMQMkkmTgvghNmwGIMNkIevlPTPlSIVqxyCIsCCsRXBeRmhDjSKzZKCIyZSTrvFLNrtYWuAhBcIOiNlmtuJmYZHCnI",
		@"GHiHifZBbFeLinLmBBnBbtKImuUoodOgNkIQZXYxipXzYhCWrRAQahJlLHghmUArMsUBVyMehvsckXiswnYtWlIvLFxvcVdXRWejLMVKaEQlmBspHBGu",
		@"SClgQljuYmmWYzOkHPQzhRmqpYWcVwClhjPtJkzjtXwoyEZeaUGsBoLibDxdTgmrlHdRkMFGkcSSAbmoadEqqYdrArJVTHqDEnRNthouSPLmPvdUZDKqZL",
		@"ntByPmlteSDGQxJwcPJWFEevMGRRvzaQgLlPjeArJbjvBAHDMtYHFbWQKmpuGcDBQsdGvHHEHqrDdAZmTJiSyBHncwjZBIlBzqgMqljHbUaxzkrH",
		@"HPdBsXKgdzmnXeWcQgfrAINyHfCYlZTzRlibwBBsYFywOaIayRNIIOGaYjLVIoLsifYSRlKQwKIEqUYDIQGSfQvChQoWPHVKlVdimtELRfTVEMEhP",
		@"EbzToRFJqdIgrKAmKXndJgFgBiMICoUsaUSnqpZoZEesMAuBkBiLTcNQnTAARupzuefyUamejRLxVTGlljHOLUKDfmwPzELeRaKgCDHFalUqU",
		@"KowjfVQdrKcUdQwxjVSCSVFEstvQYmkPiRzLWFmirkHhuOzBdiUgCMPEBbyBoWkIeQQifVtUXqXztysTRdbikRgyVXaJQbvJBLxSaoyIcnMwfwQnuecCtqBE",
		@"DfMDDWmeSBSpjYSGRGMcMDuziqaKFbUIGKMCAhSSdbfVfrmGktGnqVFongRPrMyrxxyiYHxIQAtBpHhkYdjXGBiDpysgqeNyyiRMIObXHgWKCWuVHmXFfUSwsKALTgqQmtTHHnI",
		@"dEJCDbmaCqsXHAFMrPhTTSoANZcWGDYsAjEwnWffnVooDpIQcmtzkhOZAoETPDEPUdsAdmLkiQmwjNpNksNedXZYrlrViBkfiDGlWiC",
		@"TpSRoGgBqRKxPyPrBLbvbcMNoTzaOJGjHiqKWCYqqcabhHoHyPzsgbUIkajAFPoetLzIcnQNbpYNgzwAVhUCNrNrEzDisPBQQOrPAdICKkqWesqHZHqmDHTDDAanuXlMb",
		@"syxHtpvumPFBXZWEuownUzgFblGLXGRGzynlGGttsBByethuBqLQSUZzQPzlZRAqtTikjBBJfnwcFmOnqFwepbsOeGDyoUQPoCKyldKlEbJT",
	];
	return YNAsdlNtPfE;
}

- (nonnull NSString *)wHOEIKZGXfa :(nonnull NSData *)tlIHxaDbWIuntuiLK {
	NSString *LpEYtDopJGzyxERQrJk = @"HymFMxYcaZejhhubFhatGsAUYdyuszKRuTwDOxQTssZzUpCJIOxNKRhBSfVsYuHGQUXNkkTelgcNDUyAnEDvsFQSbQcBQpiCkjOrElewzjzhEUpeYXcnSDNmuXCoqLDVVApOCmfNUSMoaSyBvks";
	return LpEYtDopJGzyxERQrJk;
}

+ (nonnull UIImage *)eRuCJkdFmZA :(nonnull UIImage *)sXTWittHszjoyHrpR :(nonnull UIImage *)gOXOWYNHrIoTb {
	NSData *KaxEkYQOQpJAPCEJm = [@"lTrslaxqdrCXGWJHOwKjbEJIrwfOtyrusJGTmHVNmIqFGWdedAMuCbEhuMbscBKCpnUllqdxXZqWFqFFsdjqCxiITFUzcoIljunokcjkPRpnDuQWgRuuLRAmMQ" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *SJzMRNTGyXBCp = [UIImage imageWithData:KaxEkYQOQpJAPCEJm];
	SJzMRNTGyXBCp = [UIImage imageNamed:@"ZJfxYWjiFWjblIVebIseYEJIvgAOiKKwCppyNmmFLYBhTpECcfHCWFUllOrAAgewVODyTSKIRQIToQEXLDQlgFhUDSUXsRKXtfRSylLzjPFhMONILYhMShhUkFFhwNMmAcjh"];
	return SJzMRNTGyXBCp;
}

+ (nonnull NSData *)EjERsYuwftmMH :(nonnull NSDictionary *)cbsahktLnFzP :(nonnull NSArray *)UYhsWhABZddFoiWz :(nonnull UIImage *)fOYYHesRaiOGUFv {
	NSData *BdinqWMAlVRweF = [@"YwIGlgLjDmIZGjyhDFamtUTWIfXfrGgVyTXSBsrSrKvTqvRpgvEbHNtLFoHZhqYaJWUUORJAVWDhayoEjeaPoKXkYajrOHaRCIdHSCevQruztObaAACcaCoklZTOUpZLeIilYPLExYupSNJDVnUHM" dataUsingEncoding:NSUTF8StringEncoding];
	return BdinqWMAlVRweF;
}

- (nonnull NSArray *)inHLenjodkk :(nonnull NSArray *)YJgLNuJotxEhr :(nonnull UIImage *)dvFtWgemypuxZxla :(nonnull NSDictionary *)tOamCYJuurYv {
	NSArray *KJntwqMYQW = @[
		@"pERwFoVXGPemFPZPnceZHymncXqdQpLKszaLTxLCWMiSJKKAxcDsrJmuLhGQxOXGVuEcUohIInBmFMxEmaoNrXKLUaaPKVdaePbrlfTmPOFRwmLJ",
		@"NYftTZwFxAzsaiYDNRNNUvFBlFLTHFXRrItRADCBEPZpPuDrYjnUNQOncvJuhIfVeUcPkyRqcuHBxqVsHnGCVyAielDqLJGdCDvsYPrFMmYhhawqVnzeFCWEMTKEFdZdy",
		@"MpobHWlnVqNazPewUpzleEemrVzTUSZahqKjlWRTUrWNtwmMnvvWehQKuziIlvPdKJLuSPhpxVollARYublNEDtAgZdBWzSMQXZyZzthsxavM",
		@"evDGmsFLHcXIMupQjhIorFiOdsTncBLQALuGhgaKeGIRbGShRqNrSfSoBlXgbFqZHBovbdoSglNoOFIDLQURGyTxlmkreNZmwpFAHdSkFOaaqtrE",
		@"uDJWMrjusurhWstNwWbnPtiuPBaeBjvXObZGCIHxYJSrmmmsROOXeuzolbzzOMhKfQdCkgFsdsSpxbkvnPCPdKpyJrtiRlbgTRSgCIbZxQUM",
		@"UKcOWrNWhWGWGPJUpmVIQMCzRUQcxmWhHHiMMbjdSMWfgwWNsdchpCerQuONbQifBxrBhcsMhwrMkXAUgygNulzpbZomiOGaHmdHYBRHjqAIetyaxtMeZelTAYdkVBqgEbebQiwWhQlZwCyxu",
		@"qmazUZFXOrCrVTyjvbsLaIgQsrJCPgtbfrDJdqtYprXzWtesjawEUrxnDRTITxXVCsNLZLLlrjRxsDiNWeGWFvgbObpvMVNikvHlWjcmXrIARWkMKeHZkLsXHyiHpJqKjbXypILuFIxzWKcpsoZmh",
		@"ygwhZjLCvHDVzMybecRUwLiCFrjJzVdTrLdMJVWxOaAQTSbQdrEZqWlVBOaPhQRXRUolwRvGlhkzLXmRpZRYdnASChdPzuxJuzvhPPLBtGbmVHd",
		@"owIYaPUROLORoosWGlsqGFgDjuWbvnjWHdyifaxQTxZkSZkITuDkRpWVODhAkEvJuzXqiAECsUqAhrXpiKmgljnhudUIQUQFdnPmgubtoLg",
		@"ADrMfonrxzuRFqLGFqfQbvQxfKxruQHxZyifEjrxZKarcmelQrXWwWqwykuKqxPiBBKueMTyyEPzmqVqtplhplAkwtxEBQPdFzcDZFPmTNEGBWukrkEJpbSTDzTPtYqzOikHCQcgqCXZWwUs",
		@"gYDtNkhAWHrvDJBSYhZfoacavHTJgdFMAvhBkQQWgLuYzRxTNFETfwXVioEDHZwHbhrUefaZqYXXNRoZTzOXHUNCmgQtKbfDaxBMFppKCjfVEWUavIj",
		@"JXxwInHVsgNdfyqnONTBgFcogPhqFGPikFnjrtpWcMxjdeEEjHpffSOMWUcJTAcARczgIPYjNlNUquWrXAdiUrQkGFQgqobqjLdWtTqdMAKrQyIwWwxGfUKpRymv",
		@"zbxjHAFXnXLhsinlWEuNtBFiHAuXHCPaOdWOjhHZKjsafqQxvjpzNzGShRsxiwiakosizbMGajDvuMalLXBUFvDPgGzBdJvmhZHBxQSOIUavidHwGuClqvtrsXkYsOspGmod",
		@"KnkTCtKXQjPtEdBEvdXAvRtyqpApeknOXBKnfhxukIyKnZCYcODoTYSoFYKldYBDbNixWysBZcBugthXltnaIcKziaophFRLkpQTuSVGIZmVVvirHsXqLkTTpQNmvDsFCsYirRx",
		@"PZpqiiPhHlixWyRafuAAmxUqaascBdkTAQfEizJILVccbvkVldXEKOSdYUNBEhZPePBVcXnjKEROGLtrJSlxGAdGnCyWNqNgIezr",
	];
	return KJntwqMYQW;
}

+ (nonnull NSArray *)JDLjomgAikCRHQS :(nonnull NSDictionary *)wwElcpXtaDzCnArgOI :(nonnull NSDictionary *)jsvDrATNFbTeRjP :(nonnull NSArray *)OwXJJCBlzAles {
	NSArray *WqFLOTVcoDZ = @[
		@"NaIcOTHXEfTHwNiLLgmWJlMMyPnnmMZfJZKVPISdpCOKSOAjzGTsOWGslGAXEMFiItIJTQhDDxaNDnNwNvLmEtErIbqaromlIdiYYsufpd",
		@"aXlbboAOJgsRYiFKgJEDcRZemcYcTbNfZirplGePdkxQEDHQLoyuDWjrJDTvfhxSODDsvcBjgFNJcSCXthiCnUeBIVztuTYBRVtp",
		@"XZCnyZvxaAtHBJDIofDRCDDDsfKnIuiXcowqajYJbQekiJOHamdKUJlipiGcTMKCuhoxyEtgaLmdceYfsfHvGyWfSfreLhIKnRIScOXkqnyuBTFUuAeklqhzvzOxzql",
		@"qYKRECbANQBZgYzFxYmKPiQkhRAoWQfRkDMkmFUCeveODOQeocLsKNOUrNELeqELzATcOGwyglvGFZoLGbMOXcOIazAiWYksHiqOwhZOZenSmbvFlXsXaorQoD",
		@"ciwoxhAIYVSnorYwMxyQExtiltJhcyDMZRNhdFygXutzWPxeHmjyLWPQxsFGpbsSbONJcrANzdXdOWcBWanLrGvdUgpWBFlRpQYcSnJZbAhPYRMEiJvFlLtfR",
		@"xiZRDeSqSJDvOdkWRVxgmkcUyHisDBpZCOTJOQQlPHpZeRqRCgcVhugYhPkoiJRdfTzWbDKAbEvFJipzmuxRfaNlMlksIdrtQwByCvOPGBDyOozUFsVCdWPEzLYxNKGUY",
		@"ohPSzrOhMBbaErCgnndpNnFZtizCYfJRPTvSOvpuXutbqZufGvqDbwRPBVQgoDTOTiSIlYaGCfrBfWVuQYrkMBEzulzqLLhvoTlxxSACTtYAfMnccNKlkUgho",
		@"ImAJIsgafXeifTEaUggZPJczJZPGfxtrZUHKOOwFmGJjBYLCwWnoNuKFFhbMUGPhXiCMavImdFzkyXNNLjBmWQjIYDxdYrvEoHIwnHDTxvqPYBrMrvwEVhgtePuawdGiaZlE",
		@"eNSepVwXgWkDTOyLzwtrXONHfCixVpqyWanItQzEMyzmwHIRXeNtiMMEYPIwmuYzzgRSsmrCXNhTWBTevRQOveMJWXceieEHDYsnSWGezFmefNpUuQteIndWUuTbifJjxkXeyqtPiQbEIhUMyDg",
		@"WwNEjULBKXCTguBZdaRGjWAfskwiZWjMUsSnUuVTnVZPLvsPddhveVwUytcFmHKHkyBkOZGRSpuQDmBjCsEsxqCjtpljvBXMAaWDcyzENkTfYHktXEwtVATuqFyinIMMfksmfrgoPjLbE",
		@"KHkeegyoPvVeXPZxNJZPvyqRolHdyiQPyQVuJqEOjAxCzQeMsBDOMdLDVmksLEZsUGYbPvSNevTYTDlkfihXLnogKQdECIbFZmBfPKIZbrTRoBukIgfJGevBCXimwDQYimUmscjTUICi",
		@"HgGThUwKgLKlZUWqtczXwEjEtyUPIEfcTHAKdsJBNkkFbOfeMEVpVXvVzhdysBIaBxLFMmgTLDtcwhlbEflEHRjsCNAcLNULhjnRFJRiR",
		@"KhlIyIXWBoMXVgNeqBwmQCGHLXwnWeAariQiFwbbzEZziEhEvIzacOTPWbuKPQDcdNmmzYzYQRyeHxYhgkpNzfgoOGYADJyLkiaTFWbjnlsqIJioeGIUOqPl",
		@"gmONnuxHqtfmCLqJJISDKcfsyNMbIdZLxOdMMPKhKLnAhdaaVcAEcMjQEQNDiYBnZoJWSzWfkPaOsfMSxSDSSiEoCwRPCgsYzUoorJGfsyuVxThyFrSsLjMHApGYjqZeLEbksnjPmyQR",
		@"EqHLgdVHZuEAWlvEoLulIMxzoLIGliCGMhGpfzdtlcPtIhFJSlNyrCSxWqrtAjDnQUvGiULZnZmlfrgfVaqAcidiPZEcawtnriToSvu",
	];
	return WqFLOTVcoDZ;
}

+ (nonnull NSString *)qvpHVqdsIEc :(nonnull NSDictionary *)YchmyegwEFET {
	NSString *LxHJxEWYHCK = @"VXrCANIvgSqFRMBujXzYwEmdPoWbcgIgMqPqpwvWtQodWMnnuMZrIRvIuYXFTiObISgfpMTOXzZEItPxLJacauYJWPSVtNlmJiRMVgrUoVbf";
	return LxHJxEWYHCK;
}

+ (nonnull NSData *)YVdhkLATUswTCz :(nonnull NSString *)isbUnmTuFVSLEvoB :(nonnull NSDictionary *)FhzPYqHJjlKqxUZ :(nonnull NSArray *)hgUtWnEGaSkjmxogfO {
	NSData *tLRThyHBKK = [@"mdpHDoibcbDgiKRiNgKGhhBKgcilDnpzevNdqspieAskcodiIBhAhKiUDeRAqaugZoxyGuLJlTSCMMXhHfYCkcpDYgDNHDndsorBdUQAKzmvfImwAqrwOTGZWPQBMatyLfDYvbGoFuKTdEZkt" dataUsingEncoding:NSUTF8StringEncoding];
	return tLRThyHBKK;
}

+ (nonnull NSArray *)cCMNEpjUcuXmWy :(nonnull NSArray *)TijMzPxhjUeq {
	NSArray *aqfiQzQYorysgy = @[
		@"XqgvedzPnIloCyzdBSxdARCDfJXumGIiDMidstpbBzZZVnnnCJZxFvCTAApxIEPhVtGxPqGNbnhbxaJufqlERmjSqBgdRUawOGnDxuMGSCwsacrr",
		@"GldxyxHTmcdoaKfJuilIxVmfIpxDnGlMOpRrnmMkgqWrAaBibASlhibUwiPqwqCFhzoCHQWVMXtvZdQrKhLyxdhLoYcYnlARcyPxhXPBepzQpDATTGmfTb",
		@"EjHbWjMrQaejOMrUvrXoCzjjmyxGYMEQIJZcoUXhhuHAwtTuZWVYdTMQcYFGJntuEEHJKSyMBrNTFbGyhjBaLnRwlXTUCQUziDGQTnqSZveoGjUqqqYDMiTZKPrYNjGEZ",
		@"mgfQRfvyCFAQCcKTyfufPckfqWCzKHcEmOFLHGmRaZvwRBnREVjVWrsgyZcNcRbFCeyFrCmskfIFyKRVYsXHlJAXIvjCMQbbwtpaSeVKxkTGKAOecFHsWThkVKYNKWyiqlKSVQYuq",
		@"lqDMKFKEsUzQWpbJJsaPSlpVYnGIxQSYfJMuGhgjEtPPAYRyZszwQAGPSTaYjkwXAqrDSzEqpOyLjrYdbMPbuGNkvbEnRnJJXBUQfrJywNHszEggJEaSZfbrHrAJdLZRzynYTeeEBgTaaUaaYlzR",
		@"ulwnjswlhGhGtjTaMXADCOwMRtPnEmhRJqrzmBXBQaIUVqiTfjFPFfKfEnpAgXihSmUgtWMkxrRHQouMWwMhDBSyuAJEEOgjKRrJIgXJVsHJiTyJPFqAuLnsBdNJYZUH",
		@"EdWGqhhgbsoycYwnATxUTPwmtXPBkRlskaotnvKOktGqluNFcQVVjNwNkECTuFqjSHiYaLGinUkTyUhSVNaNGFiaRPggIyoeFsaLZYAjyrSNjLjGKkpXNtwFOYcIHLIdE",
		@"MAiJKKPzFsgNnKYYfxypUXQgFYAUJTtzoDboSmaNWPXYbqjdZZaayPDBxYEhySuqjjEVzjLSJcyLjLVZKeKGKRWQRsZBjxFfeRzKufEwjZygDpujcJQvhcLwO",
		@"YDBnhzaXTKpLkOyWNBKVCjJzYHFgNBlIKhmvhLeTWFUjHgYmylSiZDoywSrhlTVniLYntPFRMHksqsVBmGfRoHFSVEdVBhoUztyZKoXEHqWOfRRRRqLjNAbfJUrcxNfl",
		@"YwvqsoPjsDZWICFviNBhHlYHoJrOrEfKFBqpeiLhFzVdCphtwSmdWluYihdXrsSOfkaAPlzTlveAmaAdchxyZrftdIaJvtKEuXDCbsGDOwZHXIIgzbVIMVfiATruu",
		@"vYyTNqmpuOkHaIoNoZHTzTVSiiamXEesggEfUNErRvipVhOwUPcKrMsDOYswcBOqnLgjkrGYSebSCtJEBoMBGXarVVIvLDqvzdwTPTnzIo",
		@"BUooShoXDllADmCjliYKmxjvpiKiGIYbrvgKijeWanjbUBPouKzAGsNYLRUZOmnHysisAzaAtOtAHTfWIAcRuWQwFGQlQrWTQdbBWYWCdhwsiW",
	];
	return aqfiQzQYorysgy;
}

+ (nonnull NSString *)zslObkwJfXAiSThnHe :(nonnull NSData *)mVfQZyCmaMIVekoOQCj :(nonnull NSString *)vWkWzYpBmKgYu :(nonnull UIImage *)XmdaptGrFpLeASk {
	NSString *VOyUUVNFeMmZVNJ = @"KkSXjqMoPPfhxSMwTdSWbsWkikZcKmiJkgKtTONuOComZiddZrTKuVlbDbkrTOAwvgVZTDpcVutFdXqkooWkazxMBlwhBSXiELUFV";
	return VOyUUVNFeMmZVNJ;
}

+ (nonnull NSDictionary *)QIKvcJUaiO :(nonnull NSDictionary *)txPCdzVpXOWlfz :(nonnull NSDictionary *)swZOAyswoVDXAkfzQrD {
	NSDictionary *SJalBucbcelJp = @{
		@"JBJdFKnuJzF": @"AJJVJUUvQTFkFEBQdfTEZQxNPTsJJXAkCiTPKgMyUHOBgZZOXrrKcMJcKWPErgQyFrtcjoSbqDAEwwJxDfMoNaylmykmqtjMaRXkmjacbamCbcbaLoAvEdiSU",
		@"RjMIOBOIaeuDCMCWy": @"fTuyypfeZIdherthVTNjluOfbxfVROUuweoHUmTOsYkKKwDZPYvYSHrGOKxyfdSXYOzjVLZfKgllYbrvAdPJAZlTVDCguJJeAstvKbDcmONmKEUmrUIeJsmoOsTaLzU",
		@"lizmzcMXVCEJT": @"rZwQnSwimMoXZeMFwmMsrnHZPYQFeJpgNMkpENhkrHzqXcZcYZJmKFlgGLiYaPEuyebKRtQnojxahneUnEoRstKhXYmGHqmtapUzCIQkpJJPO",
		@"vPiywKFaOkoHq": @"QRjTeKPRymNsKhdWvbeAayoBbVVBdbRfhzdnBgpPbTHdYPPsDpaGlgoBzdknFRyjgiLEDTYiScijTqnpxoTFNECFQtmOQldKygQzrUNHFGDzlkvgkFOTcVNgMzie",
		@"eHeVYVhgWppqIpVjZmr": @"XuTGJQNrNqNwcvZguRbZgGLKUuTcZcemLWSLekTQWJSyFlKcChCYOWawLmUqpdBgRyAbcRaGIPBbFhFBakRDNpXZnPUwIggLRrdLeLHgxxGfXigVHprTwKPHDclweLWQVSaegnzYGNVPKlAASfew",
		@"dLCXmbNAVqDENWI": @"VHMYLtmkaGpHtPEcOIAgZOTtbXcikXEMxLzfQjMbkUDVglpmFktNZpYQtOJutDUcYLzTpFDIjJTbOMEhrjyShaMTVmDpdSiwIahedfEwBGfKOXRA",
		@"KXgFNUOkscVmtC": @"TlQoyTAeupsdIUbygWsdSIoWiECrcSCGvKOYbnwOwHfRKUCrcyoDfkGlytsFrMWErzOcCYHKDtoNNEtOqSlrtzIFGWAWJKygfdSnu",
		@"nkZLBMereDTQDjZS": @"sJnwccPFtCOfdywsiYvdJtYmiQPMzREjTHucNQwivSMHguHlzgWpOafdxCPvjBrxFSEpqBEPtaUESRTKSUbdRXIGgunPZqjJQEyBQCjnKNSuvHxb",
		@"fCgdlgGUBlUek": @"nDkZTLpgbgQOfRZDpDvXBcmTByAcHNqwWENzjTLcuNMXVHcRNAnhwpamnDhwJFNprHosEqpDyqDcKzGhkziaunOSBtUvlCViPnrMSTbKDPBOc",
		@"qeVQohZIRRTkRjJE": @"bsKwlUEAicsotMuvrpCFrgsvqpWcfMvRzyKajnDHLNUEcXDQAHXQxcTJcdlDHKdtVAVemcczDymeBybGpvIUJnhhOWmOKjDzawnJxrFadUwCpemiXeDabBpUlljsJgCaBtHaICkKVSyajWTdDI",
		@"oZwfKUjJgHNFePH": @"hsSVNApNTmaOClLFDbXGIewBTTeJcJNopPJhGVeDpnOKRIZcAYZwFuRHRBbWoYzZYQiiYNHjuzqBWByVHYvMRgadyYygkjYzzrhO",
		@"gAIoKKDtywUtjZqk": @"JArrsISPrEnXsaCapxFGkgdkFVAyuRhEdrjxEzWrYowiOozTBAhBGSrQhYUwFgtRUNvOLzIFnRUazssMIsKtmwPnbnvBFFmJsQEZCSCXqljkyyIhJrLnqdpouZCiuPLlfgUApCtuxAdlt",
		@"MzCDTKcmnuBUjJVrvK": @"etglpsVuYRqGuStHQjxwdPDNzmUalSYRkPAlEozslKCGvRnpNOmNmWyhoCLFFeaSTXVZLOjlaoXFUhMKgUkFRirNkBxRZMqMoEVwGvobGlVqQqcJaevPgZYtBPaQOZbFoXsmLOuYwCRmifiVBkQNW",
		@"SGomAmvlggWgERTMnrm": @"IVdQeFtWzYpzYyPeEcLNlKoAidqgkxaCZTwNTOXBqZRcwqnzLTpUxRUbNHYGCfcxgjRMLTMoxPVrVavsyjeWEuEzgJbBqsYEOGBAoXWHUIOWkJRLOqemMgScCsHEHkYpeuLKRXDsUVrqIgaxYfTN",
		@"dfUbrpditEq": @"iRHeKUsYhLeFAbmAjYEEWexRUqShSlcbAMmBVsOlXqJKNdfmntGBLhufQwWfIxmmubMINtbvdWgJGbMjsImrGQnvhSoLTdFiLiHpSlRefSDL",
		@"tDYtVoDyWH": @"MjbftCfpOUFTTLyyUnDGTPHpTaSSpJisOHfmVsrzAuuhHKVTNwrmmPexyhTAJHeNwUWTJiDTdPKxqVBDuqrasLBDdXkvyhGJbVNqOfYbUXIAKe",
	};
	return SJalBucbcelJp;
}

+ (nonnull UIImage *)KZPbxyqKxxzIVHxuXb :(nonnull NSString *)mZOYMNSyKYfzejyr :(nonnull NSDictionary *)PpOhfNfFdTIqlJ {
	NSData *xlvIiCkTWAZseFKhV = [@"sRprpJtPTTHwjrlFWXsVWnCtVgfILcRvmLyPXyKqEZLUbVBoHYhCaKzbStBaUmVwGGfGsvvRknNRptAhESyoKyVhsuAZnGuxqroMrgGatxHsWvHtFLwAokmbBaKorXRaqkSRpp" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *qRwvBrVRggDFM = [UIImage imageWithData:xlvIiCkTWAZseFKhV];
	qRwvBrVRggDFM = [UIImage imageNamed:@"sYMyiCzYCPXQXUGCbTfiaPRiZdHJxTtjSPzpBqqDJOsZOwkdGnIeOLQSHvunJIeoYATmBOxFUtpelyHKyKtoGDIovnLUBKIxlJgmGHIfJjiAvcreXPjyCAlvgUaYz"];
	return qRwvBrVRggDFM;
}

+ (nonnull NSData *)wUDCOLsWVu :(nonnull NSDictionary *)GsGXRBlWJcjTxN {
	NSData *xxlhGqsKsQtJw = [@"DPxWKpdhPHIpXcEfEjELrZJusIipvfPsaENMErvnOaocPnUypoYxeYVQHInAjhsxTSJWhwsbFsGvuelHPrfrfbGsYzMuFbKmHlIRqTkxpWBLKuCnfVLHNDGSwuRXvvOdCRrmlpUQ" dataUsingEncoding:NSUTF8StringEncoding];
	return xxlhGqsKsQtJw;
}

- (nonnull NSArray *)agszQRgpJW :(nonnull NSString *)ezPBtLOhfGKHUai :(nonnull UIImage *)chGyjDNOvftmrars {
	NSArray *AvyeGlYAbrlSTLJ = @[
		@"cyCXCufTfMdolrgUhgNPfVfuBRiOVjUJgthWhCfbGMFMWxygwUjGGDWwKlQwcEGKnPLZLMrDaetHslWzbIxKUZLAhaSzqCgANXEHzrATjjZoYbYMtxAA",
		@"rbqOIyarmRGRhbFRptJHmyQxqwcnxEyGJZIAtxtoZRJzUzsuzrlbHaQmKXcRBDUdWXbRljrvmEuzhHRmgxonfpmitPLffuZxlzTnfpRWGUDMYhzgtkb",
		@"ZYTMzHGYOKIWBndZmZRwXFeIBebUreGkvlPTcLKRWfaZeLvGhdXsuohHMBMjtWZCQieyRGrjphDnHnWkWblnCgpCvdAfEKRjXXfCWiZ",
		@"dLpiEWNGyYYdQhkLELoPwrOUVtgoWqjhNXqIjEoFnncIdzXUTQmqWnIvTCZXnuEfAQGHTqQTKCeTGVfenfSyukksbyWyUTrUeHMidLXWHiqIxXogyBqgTyMFvhqrrCAooXR",
		@"dkMkLtJdeMuGzvoDxneKoInPKQjJYjstURzrtzDmNPWfzHSyxlrdVIWdBQsBLcOFYCTIdVYhuCcTSOxTvAMEwQtcvPoFiXBxitZpsclxloHDqKotqtsWpHEfGQyqXzCHtDuqStN",
		@"VJbZFHwAslFSharhNNCrKAeerAbAxZQbauCPjmDuIRooRbxxyejUawbrLZsDOZQngjuXIJKtgRXnTTQSAMYPYMyIXGJygDJMeWHBLcQrB",
		@"pETopbTXlrwqCttRsayXkqhkuoabZIcdMSVjSJicuYbQxLzazYHNanYIdWJmMyUCIMpXtwBiANRpzjhnElVoRvKugVVBzLQEVkTuBhIKqsASSZaERQiUTWIuqCRsOeJdqiUTGZMfG",
		@"fLVJdYnbUaRjajeNciJSiNjDNydCIGviwaSmYgECmRkbQiSEvtmdrIfHmYIOHPUptpVEphFPmUDjPvbAEpvQWTxFMGzMuZIwgbQFdiuRrArtiebxrGsRONpPkobuQHq",
		@"wAnABukmtHnwPtuTvcMcxTYfmBeVBMJYIprxuKKHwLmJljILvxwSMLwMOGmSzEEEpXqLNQNPOqLmQavUsTDRPVGvuAtSXHGxZOZQnHldey",
		@"ihMyzHFtFypsuOmQJUUIIePKQRjKOTmembtSjRwYtBfdTHAUzufxUVGexwiHqZmkjOnoHobJknRrgwqkqTekhenicxDbbKzECuoJHmVccwkiRwDzQVi",
		@"LFlqnvwpVAOKwAvnwnlnXpWfmuUtUpocsGoIpQGJzytHvzjPIeycaKkPkTnzdBOxfmlSPgJMQcCLpuqRRedNSrmLlePJtXifTvFCeNotDAvHckPXTVbzFeWoPQrApbcyIbNhV",
		@"SmUepIhDPfhdTpsqGzVqSomvgFOsXFLkvmxWWHSMOBfvcGBUiRlgIwjLbjPLcFTnPcqzOVvGDIPZNWWPersEgUHCGQuwEexOgJbvkntmxQYFuPChyvjyYTKFseMemBsJzmbzwZQAkZDzrJ",
		@"eIjleHxNGSzDwuNUKVtEkrsezGuQtLrDmUCzDmIekmBoofHIdDEGQfWQeoKjtSdQpLWUpDnQCENvVzQOkbWfRiyreJEtqZniMTSnX",
		@"YRFKouTXXXXSasOGQdYSumJpCbnfPXWiZBVkgMxXpcEaXKaxtOzgkiYsXqAZNunFFlxoLIVDKbaHGWABlLRGqxaWsUwRQlqbPgCSOElLfUrEJVOzRacEerCskdEaWyrfuVebeKd",
		@"zpzKTukkDYaqjJHzykkCRsIzcjQrobsWKMfIeLQYcRtZvXgZbZBXKyRAhlDyVFCADaFEdUyJlbhQlhOFaEDbNGZKfcgmFqdWhNbcTwPLbWROCbteMAhpjsBgFdukoQGckWbXfJmWNXGnTgT",
		@"MQlHGGRQEwAXhYRNzgGkHmjbVtPIZCQypAFmwDrNuowtiGOqSeZEASFShzbGTtWTKwzNGjthdkAVEiUQTxuIccvlhISiJEUwqLWw",
	];
	return AvyeGlYAbrlSTLJ;
}

- (nonnull NSData *)MozPvcDsXcejHlWaN :(nonnull UIImage *)dlDkdawTiFa :(nonnull NSData *)LGUZyMuasIlcfGdMNKe {
	NSData *NHnJVaMvGa = [@"ZkQKGXZVgvWVCNJRFbNGCmjiInGuooVyBHFazGUvdrUChzIepLFDiJNPHQjtmvgnYWECuUpUVplLScQfEeYTlPcylcyVNsuFLGpISdROonJnztcCMmoptPyHZNjSnEpUuETARWlyeNHWb" dataUsingEncoding:NSUTF8StringEncoding];
	return NHnJVaMvGa;
}

- (nonnull NSData *)wNFOcWJcYSkSznQuVU :(nonnull NSDictionary *)aKMqzMRkMwORyQ {
	NSData *rlsIFFFyExeKXcbjEge = [@"VYEEyDXLCPTRYpoLfNrxEETHmVtUznQLhcQmXzUIFZRNotytXOMCuiqsJRFsidmSFzdOpeBNBZfSWexCaamflbezrXwjJOmdobGFOAbnTTBviKwytfmCRiAKWVFlFhfrJDbWvAmZsAqH" dataUsingEncoding:NSUTF8StringEncoding];
	return rlsIFFFyExeKXcbjEge;
}

+ (nonnull NSArray *)gfgvwOJKjRVp :(nonnull NSData *)fbUBwGLfRh :(nonnull NSString *)VpXKUHlRBIYYtY :(nonnull NSDictionary *)mGOdQqXSqLqlRSsucvZ {
	NSArray *kKZNcLjsVunQFuhxOPG = @[
		@"TeVdaoqiYdmxOnJMXxSiGKEyOrPGGHAtSVIdNRyYJbsNmfiGTOAJGYUeojkZDFnfLQLMtNHcYcpdQMwXCXZondjWAhTVDTzgDPdoN",
		@"axnoFGBBWvpPZmMQzNjnrKHSUxKTeXuUQksDWiTNWgPrbiYUOIxFGoihQaJzSyOSUxwoFMVnvoeZEtGSmhAIEyGcDGZiBBhxnNqQJMOVqknKkFAcm",
		@"uKTdtLpeZIhihEURCOtPrUoTrSoMiseUQALTyFFohmzYFFqtvGlQfPEXMOKMTCOSjaKzMwrnBoEkKYFDvggvEBkkCiViXuJXIEIhZ",
		@"bjaHKpUdLyMtpYrRNMPrivfxglWOkkxHrtOLtrFwbBbZMeQPFLagEYmIaIScrkyFZlvznGOzsJhlmDHoyBIUlwoLSmvyQaBZxdTqC",
		@"BEDktphYpJIvnqjyHCGvzgOueektZQHyMKWzxmADGnqLsntvQCoCTVCnvkmLLcuQwvuaMxAtvuXFMGAtHYLliCQpdFKXHnruRahgobmaHChrTqCeYoSXHPpMDIFbK",
		@"AhDVYDKaWTasRtoilbaIjDHnhjwWTcKtCihRjhftBrpTloERAUFNNEemYtsbulCmGCoTkdnwnuDMuJnuPlrhgqlzuuGqfpRUxiAApK",
		@"pAyCvxrbNbPKALJaboiRRxKYUPlPPEzuZiGxfMfyLMMdKtRxUrmmHuguBicGLHPwWbeCFgPhkRMTyvpjKTFtVcHRlbChIoynEfTnUUrPeeJFJxSMuMAEhuGyOSARcE",
		@"kGdIkNrVPdLeZcWCMTqDTJbJvotqzfdtDXAbUGmRlfqCwZtketKNRzKocGoJFxKhBwJTeiShLyFBHKEUEeVLPohAmtDTkhxKsFkjCSeuQFXJ",
		@"FYVNojkjCYOnLANTnDLqyLPdkHiiEYThTxRXSigjuvQHipVKTItejrIklQPaVnJqrqPThSGOwLDORUfnPsnvfUDCagtVMnZrZQtgupWhdbdFTPkfUCQgtaMSU",
		@"oXfjQIMIzZLwLRHZoLawflUVQGdPiovuCyGYtcNbUPIpizaXhldiCzZKzgBtiUZYRdpRjWIzxEnkxTfLCItkvzPDqPwbkNEgbuYyJUCjptvVxBjPrQQ",
	];
	return kKZNcLjsVunQFuhxOPG;
}

+ (nonnull UIImage *)qwSwWOvOpLO :(nonnull NSArray *)nEtKVcWpOh {
	NSData *KgSuYBuYxdJHjDh = [@"MrNpIfZHZbrpfaxyLMpPbGAAmCtCGrgEZJSLwlwItJkokmMtsznRKXveynrqDboDlxBXpzcfHZLqeKgMmXGajcBrTnsFdiIgmfyKyeLIiEmPdCHCaFrfgpcDqFNvuIIsgftoaS" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *wulHSpinxMiEdkan = [UIImage imageWithData:KgSuYBuYxdJHjDh];
	wulHSpinxMiEdkan = [UIImage imageNamed:@"HdqZuJQpRxJqKFBxSZUxlmMIBkOWJaOmVinQzmtmEcdXwyslaJruQPeJAAXRldaEBpLCXdRrDllRZjxNHHarlDMrZwNkpUPcIBcbMuqvuo"];
	return wulHSpinxMiEdkan;
}

+ (nonnull NSString *)YcntPtVgEQnKj :(nonnull NSDictionary *)fSVDaxLanDTPDJUe {
	NSString *NnEXUjqjvbPOGgYkz = @"wTXkkypsztlixwtSWYtyFzWRjJMrcggpxJvydoNolTDWjefxLFPUEjkPUshVTSkVaNibCtSfwDiAPHmrDdDVhxTyBAUydnNEaPDfCdfIGxcvUNsdjMlsvhdAzOrKUxoaFVZAbODNbRROZLxDvpysY";
	return NnEXUjqjvbPOGgYkz;
}

- (nonnull NSString *)VROzbFqhEnwZjubPVAG :(nonnull NSString *)oNefzRIUvOQHMXlico {
	NSString *qsJsqTAQFnf = @"VcqJAHoyfDwtziukyBIJflfpivawqayfMquUECEkyQVYaACqWfkBfCzxgLBfOBAKsxXVViuKwSaugdDWoqHkqdemXlkaqVprlIsOVGxAJNoFAuGFqJHmMcSxOCAfBPJjsfYqWlqYKiWRkUvU";
	return qsJsqTAQFnf;
}

+ (nonnull UIImage *)ltQyvjgAncEJs :(nonnull NSDictionary *)rZWYnYFFemEgocP :(nonnull NSString *)nrCKyUUtjzvRnuduq :(nonnull UIImage *)XbgRjdBIUiQOxb {
	NSData *fEtYkFrpPTAtB = [@"rkUcTqJcAqerIBOdknzZCyChpUsfleKVCMGhwABAWyktROlZhoFNiAojNwRnCdlAMoBZQMixHaeAlBdMHpTawxOhDEvgYCJHGqVvYgFsKMhbJejZatnDKvaQoCrljDNut" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *RhwCeNMDxjQbegCYeB = [UIImage imageWithData:fEtYkFrpPTAtB];
	RhwCeNMDxjQbegCYeB = [UIImage imageNamed:@"kqXHIaMcNSgpaORrKSqheYFxAfwXwBavrUprXrdHsDpNMLNPpNWBgbcnbvfJjHiJteGJQZsgXzEmQmUxyYIEZkzcNjGDmFNMDdFlLXYSJgopfvvkjbf"];
	return RhwCeNMDxjQbegCYeB;
}

+ (nonnull UIImage *)gZoXCJaiUlwKoaM :(nonnull NSArray *)DmaTUqjBeJSLaBid :(nonnull NSDictionary *)DtLypaBsKJCzVPTBS :(nonnull NSString *)UAFHfsTlHn {
	NSData *lEjobQhAjCairvHensC = [@"dHemIsLWQaCpLqSjDYNPUNgyIVPJoQIqzPybacOqGzfKINUgYWSvULuVXhLxJuYXyjbIjRaRCZUTpvUQazZoblcUlAZoZRvMknpPcuGUPytLJGMR" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *QXegMaRtBboQvcbZyz = [UIImage imageWithData:lEjobQhAjCairvHensC];
	QXegMaRtBboQvcbZyz = [UIImage imageNamed:@"RxtucafdZovdllujwMHPUhVxlskQqUNVECDMxHSGLqxkPOrHyKGkXJqrEUCVSGIFMiXxfGYDCMpEZybzlFvPYAwlQIPiTqiCkxAuTLroNtGlscAGQrIgdOJeYbDKzW"];
	return QXegMaRtBboQvcbZyz;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [txtnamePenguino resignFirstResponder];
    [penguintxtemail resignFirstResponder];
    [penguintxtpassword resignFirstResponder];
    [txtphonePenguino resignFirstResponder];
    return YES;
}
- (IBAction)OnKeyboardDoneClickedPenguino:(id)sender
{
    [self.scrollView setContentOffset:CGPointMake(0,0)];
    [txtphonePenguino resignFirstResponder];
}
- (IBAction)OnSegmentClicPenguino:(id)sender
{
    UISegmentedControl *segmentedControl = (UISegmentedControl *) sender;
    NSInteger selectedSegment = segmentedControl.selectedSegmentIndex;
    if (selectedSegment == 0) {
        strSegmentValue = @"1";
    } else {
        strSegmentValue = @"2";
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
-(IBAction)OnBackClickDonePenguino:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
@end
