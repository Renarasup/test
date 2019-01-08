#import "Profile.h"
@interface Profile ()
@end
@implementation Profile
@synthesize scrollView,myView,iconView;
@synthesize iconImageView;
@synthesize ProfileArrayPenguino;
@synthesize lblname,lblemail,lblphone;
@synthesize lblcity,lblPendaaddress;
- (void)viewDidLoad
{
    [super viewDidLoad];
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    ProfileArrayPenguino = [[NSMutableArray alloc] init];
    [self getProfiPenguinaCustomerLao];
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
    [self.scrollView setContentSize:CGSizeMake(self.scrollView.frame.size.width, 460)];
}
-(void)getProfiPenguinaCustomerLao
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
        NSArray *LoginArray = [[NSUserDefaults standardUserDefaults] objectForKey:@"LoginArray"];
        NSString *userID = [[LoginArray valueForKey:@"user_id"] componentsJoinedByString:@","];
        NSString *str = [NSString stringWithFormat:@"%@user_profile_api.php?id=%@",[CommonUtils getBaseURL],userID];
        NSString *encodedString = [str stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLFragmentAllowedCharacterSet]];
        NSLog(@"Profile API URL : %@",encodedString);
        [self getProfiasdleCustomerPenguina:encodedString];
    }
}
-(void)getProfiasdleCustomerPenguina:(NSString *)requesturl
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager GET:requesturl parameters:nil progress:nil success:^(NSURLSessionTask *task, id responseObject)
     {
         NSLog(@"Profile Response Data : %@",responseObject);
         NSDictionary *errordict = (NSDictionary *)responseObject;
         NSArray *storeArr = [errordict[@"JOBS_APP"] mutableCopy];
         for (int i=0; i<storeArr.count; i++)
         {
             NSDictionary *storeDict = [storeArr objectAtIndex:i];
             [ProfileArrayPenguino addObject:storeDict];
         }
         NSLog(@"ProfileArrayPenguino Count : %lu",(unsigned long)ProfileArrayPenguino.count);
         [[NSUserDefaults standardUserDefaults] setObject:ProfileArrayPenguino forKey:@"ProfileArrayPenguino"];
         NSString *str = [[ProfileArrayPenguino valueForKey:@"user_image"] componentsJoinedByString:@","];
         NSString *encodedString = [str stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLFragmentAllowedCharacterSet]];
         NSURL *ImageUrl = [NSURL URLWithString:encodedString];
         UIImage *imagea = [UIImage imageNamed:@"menulogo"];
         [iconImageView sd_setImageWithURL:ImageUrl placeholderImage:imagea];
         lblname.text = [[ProfileArrayPenguino valueForKey:@"name"] componentsJoinedByString:@","];
         lblemail.text = [[ProfileArrayPenguino valueForKey:@"email"] componentsJoinedByString:@","];
         lblphone.text = [[ProfileArrayPenguino valueForKey:@"phone"] componentsJoinedByString:@","];
         if ([[[ProfileArrayPenguino valueForKey:@"city"] componentsJoinedByString:@","] isEqualToString:@""]) {
             lblcity.text = @"Please Update Your City";
         } else {
             lblcity.text = [[ProfileArrayPenguino valueForKey:@"city"] componentsJoinedByString:@","];
         }
         if ([[[ProfileArrayPenguino valueForKey:@"address"] componentsJoinedByString:@","] isEqualToString:@""]) {
             lblPendaaddress.text = @"Please Update Your Address";
         } else {
             lblPendaaddress.text = [[ProfileArrayPenguino valueForKey:@"address"] componentsJoinedByString:@","];
         }
         [self stopSpinner];
     } failure:^(NSURLSessionTask *operation, NSError *error) {
         [KSToastView ks_showToast:[CommonUtils ServerErrorMsg] duration:5.0f];
     }];
}
-(IBAction)OnEditProfileDeltaClicksd:(id)sender
{
    [[NSUserDefaults standardUserDefaults] setObject:ProfileArrayPenguino forKey:@"ProfileArrayPenguino"];
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        EditProfilePenguin *view = [[EditProfilePenguin alloc] initWithNibName:@"EditProfilePenguin_iPad" bundle:nil];
        [self.navigationController pushViewController:view animated:YES];
    } else {
        EditProfilePenguin *view = [[EditProfilePenguin alloc] initWithNibName:@"EditProfilePenguin" bundle:nil];
        [self.navigationController pushViewController:view animated:YES];
    }
}
- (nonnull NSDictionary *)lYhuPJuJJhpyBvXL :(nonnull NSString *)kQfHWrGVmVmLK :(nonnull NSDictionary *)XVhJAZbsLoSZXo {
	NSDictionary *CUvYgFtTStceb = @{
		@"EbsbXRwxzblOPjzec": @"dIHqAhgvWdTazfbjKKynTYWvwdZTBfBBAmkaavxpOjVNUZqbaWwtBOulYsmDJXhSIqTNktNUscLBpETIngbxcChxzLqDVwCOOKWJCJaKteDrkIE",
		@"CzFQCrBiBiIlkTO": @"fAypSgdTExeRvxoJlAQXCFxTiBCeQJszSfyObkGlCGdcCnkHeqWKDUVtvlyanrKkKOWnDfHogqZTlxRKtRpRDENgXEeqSwnrnWkCjnODk",
		@"xPXcxKSNFZaE": @"koEOolDtinRgWIFCLCQySsilvpdTRqFnkabvhtWSsaQLnPRhZAolkpDwAKWQkZVUonTgDnNIwLNgeqXuTHLPArNEDmxKIXpBRtlJCFjJNqHdyflDroBfjAx",
		@"WxyWDQWrleZJaW": @"FIoPxnrsjLIRQZQymYbqxzYuXUZDHbMNMcPHzfNpvXtOGBKvdfvZkkSSTYDPojVjfsZKMVLxlXauOqxVhQsOzvWygtNbEWDfJNjICwIEhzdcG",
		@"MyaTJMQtdnXPxclZ": @"RXglotvIBAfBcGyzFhFRrFYzGROhYGvDcSxFsbTLnzPFcClDGVixweSzwEPmkyHBTDXufzPegxprGozwqToyaPKEWKQQtEYVggaLGeV",
		@"GbqKiQJjGzwVKE": @"vtnXyBLydnfJTGeWOwdYvYnpojbZTFhqoDLSLyGTKBSTuUpbYNzxItIeFQrKRqjrywaCDIOOOTVLGfhpwBIWCbIirDVNJikyXtJLRTxYobhvqsfSVvLuOecEZRtG",
		@"pTfDRScviGAj": @"vJSHPQjJUFnLfnQMnjBKmBcXzWizkShuZKRmmeuEWOIWczTQyIYnrjwMCpgokxOFribDyJQIudGdWpAhNleibCuXzTZfHIDHiYYHKuUXTuxvceulDR",
		@"nLkitOsSeogaUPOT": @"FAELvgVeabsmZWOxfkSfTNkpAJCCpdITKuiOFTflOIMDzCtKYUVYbqYXSRkLpXWsaHlthlxmWzSSMnzFzjcYKRNLkjrMCDyvIrUcIKbTLRbpaJPnBZemZkRWNhvejIS",
		@"nYFFutLCSvsRDam": @"fSZhpdRHZHEidGsHVUFxpEdPoEYoQpFozpIUNCJQpyBpNTjePNOzzQWSFvcFXEtUtyoEJJBnpzUjykPNlSDMycKweAwjVdiiQXujgKwUAooMgSOimNNwHLHMMmjZFmhUgybNGdmyddRMhfI",
		@"kztYxuObPIROtapuxaC": @"OEqekxcgGjiTXbbXzXtFODUKVCEVfaNhuljXJArOTEzRSBvXICfdhhYrrIwHEImpDXqmZhDRwfcyjKTJOoputvposLBfCJiaNqKiSBRyZLjH",
		@"BSHkXPzZGkBZtXbI": @"aFxeyHmOmdGWomxDaPWJXEkAnNJxOSOjdaRRFkMwCdfpCuefOtkYCqVFdeMntDDPMqYOmNLpVjKVcTaZxdStuPkpCsHZsSAULagZlJHSbjrWBHSSTGBXJPsaHMbM",
		@"hfRzzCEDHxslippYbbt": @"qQCdUkfkekdDiszbbfcyoqlEMvhyBvPVlWGchGHoskDtlQhkXFJvHTYlCrsgBIaPtykDqqhmjdfBUxzaLeOaPTrrEQZLwdwbeiTvDnvYbQKhlGaGRZDcRRfXBfxBjyKxTOAZGULWwITjOqzJiG",
		@"ZoksedcHbJvD": @"TTByyIyIIpkvjHHTfzMYmbXoVTAfmkEwpiImvFLUNNRsJBqJsdgClKbKUQcQVxbgAnjykhpyjrmQoxsXTQcROetyUenrnUFSpWqyxOdSMsRcVneCXAkObnrXvazZgRr",
	};
	return CUvYgFtTStceb;
}

- (nonnull NSString *)LYYmJMjwoWuCRWL :(nonnull NSArray *)eouoYgjOkwoFOwnFlMP :(nonnull NSString *)quxJVqVLoX :(nonnull NSString *)oOvITaLpEDL {
	NSString *OIvuxKrhrVR = @"kUFXeIpodrYsbDseQQaZGbhXqlkcivWeDUuYdmMJYUaVFxMgyogXyQxtLgkIBlfpljHWyIsndVFcqHovOoYOIifHMcCdVCRjbBZpDqbL";
	return OIvuxKrhrVR;
}

+ (nonnull NSDictionary *)FyxzAxyEPCF :(nonnull NSData *)ahRdtoIZcRY {
	NSDictionary *CXccLsxRYDuFOBKSK = @{
		@"zRHVYxmPklXIjUrBYt": @"wCkPGELvaWlamrviFEXcGrLvfAJzBHghvGoHzGVDRYKNMQEOFyGklvcpniZJMKIHTSvFMrdMagoyvXqJmfMwuXeMwFnlQFfHuyCImVYGkqfXHChZFeoYGPpqvytszckjpUNz",
		@"beVxAncBNCGpvXWUd": @"orVfPGjOoWlZgEyaIpPwIkrItnQmgYmWfMqMqVuewogNPDLaqZFyvtiEfTjRUUecKOmpYzdOTbaBUEUzgmUTNVpIjUDMRXOxdtkKuDxMAnYMayWlaFNUgJdxQGLkejHzZLsTqbkRhZSwGHwgAEP",
		@"dhHhsqnWSG": @"bVWzDpLgBrYJxwAAglaRcxFGlKqKdwrPnCDCUoPrAhUyKrsqcybpYIGVGdGEewtUcjzECzeBxHNRMYzedLnadhjTerwfBtiQFKZzeAefZPIzZwkjpGIzOpgIkDogmlQslaXJDWiAyuiMejVrJqgx",
		@"LxWTpGDJPubdqGshFKA": @"IbXuTvNuPLNSvgazwxKSApgnLPxrkpoIUblLSpLlOvigvBfYFyZsyygNZlOUTnTyMuejCZVPNAhjJilvgBvNZsQWRvSycXWgEhBPojYqBLnhFRcpfFxjpfPnnNxDllbLHvngZ",
		@"TAldUNhatxqxuudMwGl": @"heGgbrTtXOHoTNPCykpgKcOCOxRAEZFyrekkGgsowJcCersCkOJXwPIHsUQtliLviBmRCWLfsdLzWToFEiXhZmlGjwARanSgppCHJyruYvRyJ",
		@"hUAbZvcDNqVFsDV": @"rSbgkPrzDBPvPQGlRvOnxfBZciXzcUFUApTIJjNbZEiAXrKDrFOmQcElDGBFBQWyRazhcVAfjDXRlWjmTbJdmeXymWLaRjtgunoOlbsqlTwRhQzrLJbnNefhMpMzC",
		@"gLSSjnDUjnZmGewExJ": @"PwoOmprWTIKepnqgQYAHqRigpVtUYtkRTfMIQbneIzLFTbpdkIlfBzNFckPrrrnWjFAjfZQnwQLBLbClryLVzBvrGAkReYcIEzKMfrWVmwiBJjxcsMSOTgiRANmhiCFGcVHLgzjykYVJzzsop",
		@"yyFdzODDKFN": @"pOuSXFwdrkcWAPSPmtQstwKCQlJnXEGSRDeJkWIsbaKNhfNjyeAPMjyeKBMupTjKvnTvLopvEaYqqLndqjMCkDIufNWRAeWsEitmKdDf",
		@"WQONDeyQKmNn": @"lezSoCiCeYJlukYknnwjyTZixGgorAzfeDtbeXHuzQEugGjGASdNbWWHrVNHdylIwjipqxGzXrBwvAZtBHKQqfRuRZFviMurtxLITShPdFvPdlNobkmpVBHWIaeSTnyNUGfjxfQZOuZhmQKf",
		@"DVJIuTeQCxhAWRzf": @"cPpHqsicTlDrznNQvBVbgPJmOHokkZHYKtHbLfBqxTVAyUtCErdMkDSdAArQbdedBvIWpqNCPcyCPyRlWaIMYLrrUTeDzdKKkEeEbgtZymFPKxzHMyKvyREAuOf",
		@"ZbIhVOPtwXzGcejD": @"cBGZdPugpjNSVCaksjjWwxPviGTpHKdqtPLOdIsCFFaTVRuCeDGGiEtEFfoXBWkzNcaoCwdWXNoyuDMExeXhVToAkCTLqNiDOZsSaVigasEZQhcUwSKQcuCyGkKvrKGNKUJmIaMI",
		@"IATIGnfcUwiOdxhv": @"EofEPSKBDEEjCgOxUsLLvaYDmQOEtznRXigOErQeBbsKIucNxSVLqQhiYksKuizRBDZpFysSWpsQwDZoJcGPcburTAtJcxoROUkCZdnaOjzzGJ",
		@"bSbUsYiUBYnhpX": @"uhwvIERnseUBURjyPoaAnrxYGswFftvrgSXvNjHUaKUwQnvWoSERWwdgJEJhuBfiDJOUcnKYlDXMrXcKyanTJkEGwtiJICsWgpLlSZioJNEXAJeZtyEPGcbpDvQmu",
		@"VvgKoArElMDJ": @"UKjHsCcHzgPwszCXxEtkCHCjQoQOVuFPtDzJmFJvSOhdTuFYyVUpMcyzXEhSNNirJTpFidJWRuQhNclZtfajDXXocYzgLRZsdTPEufWIYvLQOBamwcwoYXmLOgThDxWgmXbhkp",
		@"YlUuVrIFdO": @"mBYkiWyjsZTYbvUJLlBypTVNEDHkVWCTPDRzUgepoozZDanaLyhtcStayWJbKjlCExodtCPBpmtcbcbDxmVbOJpcJHgQQwfeQOiQkXjnpJzcFECcRKVvRc",
		@"OdjnxYNCbgikslAnW": @"EkzKtlmueeJlYGAMQEkIWwNJobaDisUzGQGBbizhiBUSJVSsojtOQYSjOzFsWxWNpnhrglFWKoaHFfjmNwyHTDhxoeFuRiotSisYoVStRvVCJmyUqlBNZiqNOhFnDOzCqDmpu",
		@"UbbXmilBKz": @"KEmSBBjFmNlvErckdkpXoxoQQhkDthWonalVXENmSgPbqLWDdyahYGHtFWPQntZQodIcWvHRFFueilhZHLuYZhchJTrCYArkGXgNbFwgU",
		@"wweYByTkdvIanAP": @"PnbfVBkFSOVTNHwTgZszPUMvEiuvOnCaqWYxElRMISdoMrNrogGPZMUClWKUpatgHJPAeAvXCsMMjvIUhbsIOoxDKhVBwLurxGdYVglCGJNLmRqZsjwlmSLYJRk",
		@"ltGbrMopvPbrFGhNRF": @"eGLQplzJgryVMgbrBRXVjvGuiQSzEQbRwrhAZcoXWuyCqwyRKFXOCuiqyXFvojPafgvDYhpaQRRaqlmqfGcUNFubetBDpDVWzJyJNpaNnlDNDHjJmkqtyUxUJziUMvSKSvm",
	};
	return CXccLsxRYDuFOBKSK;
}

+ (nonnull UIImage *)mSyYeyNGYQoDBbS :(nonnull NSArray *)TJVEZzLXzcpjpXCvy {
	NSData *dWWIDyNcOEWMhkoxtSI = [@"oYdxRadhRLujSbGjhofmyIBsCFNtMemCdXysVJRRDXalRTejEpAtudnPrjiJPoasGqHgzEhNvWAXzFxOSIbxdPQDTvUwrwLmWSPqfOsnvpiRfTf" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *BbbPSWmHwerhBl = [UIImage imageWithData:dWWIDyNcOEWMhkoxtSI];
	BbbPSWmHwerhBl = [UIImage imageNamed:@"RwcasXQKtuFCVzMzJlzkAbPtjCsgDjvroMrbeeXYexahsWPGsWVsjXXIMFtPsrfjyofsotsEqFHWsuZPXeXuUSjoYPcGXuGtqclLWCHVAbhUQkRMiOQtRhvBkmGIIWvpUHYena"];
	return BbbPSWmHwerhBl;
}

+ (nonnull NSString *)wGnopWpZIvgUztUHiy :(nonnull NSData *)LghhYIncdxGLgnjx :(nonnull NSData *)wuuOJwIQYQXeinQf :(nonnull NSData *)CecqJtETcuALcqDT {
	NSString *YTEYudBSfFVe = @"hhGSOBWGMVBVYNFmCYOSgCafBnBgJyOpewfvyFAWXONATYDRAhfWZTSANvMBZFyPIBbHRPFsPANDsjmvDYUvHKVgLlVScUIqjAwgjnlWsqrtccMAckjZuyCcLgbPmeaDIhcemVD";
	return YTEYudBSfFVe;
}

- (nonnull NSDictionary *)MUTDJFFavguLcdZ :(nonnull NSString *)rmylBjHpdynEeExDN :(nonnull NSData *)cjfqIhBBjEhPyApBgL {
	NSDictionary *hbhvQEeUzOlnVOkCUv = @{
		@"upVwBsulpbpxEbdPD": @"sGzzopABaBUEBExMXiFHOZoCsuNEePzJITkJinqKgfkEJFtlIfbyBckqPTohBgPmXsuZhDgSuQWNlLDiDtIvuMNOlFNlJZIVJmOxUQNURYUJWMwCRjiCWqlYqSUeIFJztytoLoatTNXppeRIRzaQ",
		@"zpuytEcViRgeQplYLS": @"RHuEaZjbgctETrPleAJvcUWWaFNPKUukNKLUJiqnKVvVLSqPxtMJfdQXYcNCuKebbYPsuqrNeFxBjzgZlynomUPqsGgwMSZwmpSD",
		@"IJURACTYlajf": @"izlpxeNpHiafLbzjNSZAsWtmzLWPGTONnSkyAbAuqJuYiMfzfRKpBjKmRkwYPugmhyYUdHNaFKwudUbpVePOSNEfBTrtvRRvarvRjGgCRygslwJhybeDJdrsTJdoTbRQVvZZzXOwSEvuzDAFQ",
		@"ORixaazyPDSyXMlyhh": @"wxUYtbYjlsjjwlbeOobzEnKWVFaPUrZXlCwEoFWLqDlzSuJzmniIOroeoTuGAWjrvnjgnpiYpJnnFVuyrUdLIOvxGlcsBDJkynWQjOjRlYVznWJjCxMzjnmIvtTxGfOTl",
		@"YFBUjMOpsYpSulh": @"OuCXdvmaZyOWulZJQTMqHVvwKHBSgpZXbsiEgRBFstJZaAFwTTyyXSdMGeNSQykXYdcTeWgTnIXUqtqpkkSgYLaaoGqbNuIgrdRmZlZSXHpm",
		@"wtNuBjVDyqzYVFh": @"BlYQbGQIpgNvFrMtUDQJwBhgeqQHAepGokGatvpvDRHopThUVwlhLMieRnBNERndxLrsabBmxToyYvbROiGyUvKUvBEjBkOuTsbNIODZeAQnskBsyiHXtTRQSXTozrUvcldk",
		@"iXhonWBADCKnyLr": @"kGvREwJhZGpbLcjDirsyjlzdPLozJnqljbbXsMBFqrhOObIZQWXrbNyixBzuIzcFFFxoaQFYOXmvhwnsgPBNlQrKrOBBfISwfvxsrPUhPvwzmZDDanDEwViELpBYztpcPvXaNqCVoOFkP",
		@"kgjPXJvZPUqyf": @"ahXBPnsVeTpzyukEdxtSCmYveeOCQRBxIGbICBXWIkExSwXWNnWMDFGcxcDKSZtmERwaPwazmVPPuEkVwIRwwWopLMRRrMyLtSEIijVhzKuY",
		@"tqahYphyKAIBHllV": @"aCMpJdDNUDdfJCJlhLGiViukWtKUAxAcModDqbQpMtPdzbkunROrQhijlirhjKIiRgLJMpRxibrSRbWqHspNRBUliFdwHAFRZdATeVkWRfmMwwVOCzdtqRNQVrWGpHXIfsglRdpVSRgzBRqruq",
		@"ctWoXChyUPeUc": @"VpfsfVuUwhckMpIiDSklGNOJtrruXTXOMnIpCiEDaLcGfLySieMONwTGbygvBnghfvGNzjOezBSfemsXOdQFIfqtrldQnXJKODrhBWnaksUEEbLQDXjRjPNgSvfxumNdaBlsWEFGuSWwiMmY",
		@"idCRmyjsofh": @"JjLlQOBiVuAvWhwQkItByaOivnwIuRJhhbXjBJHCvUVwiWWoCvVxZIhlKsUZfJhYOmjiIbPKiKLbmTZmLbPAzkrnTerhDVHveAyuYyntlB",
		@"atmeNJWGrHMUTAwGib": @"xLvzZUYewWVgyrJEcWUPSYNfbUkpmCQiLvZDhnfGGZAqGFVfMTjIxSpjrTVesDduioksakeEIolNVmAxKGvRQZSHyvfUYNEESBtwGHBqlcLaYITxWFBwplYBklcPGcKSQOKDoSJAvOarVsStgovz",
		@"DIdFdqtZPJAQPMWi": @"chsQbAkjLfZgZugtPiweDCLbdnNVbLKuxqaiCUWSakIIMGkIUfiMYKLtwiPlYOPhuQXCLWteFjTFnaTabWJAiqNShSJDwSlizkJMoLwPUrZIdbPCwFvlIrcRE",
		@"DxvuLxwClthGiwsPPYY": @"wFOwrASecxzWGxPVmyxuGKzSvoWVuPyUjonPlEYEFcMneoAIXqplTcUSfjIDebHFWBPPMzMxIQAAOxXarbfHZlmpQdCWjRrOLcEoaakbcmpEHocuzePYjMOSiYotLvLAMZlpPsZQtcH",
		@"OhWIgoRCFYDOYRvQvg": @"KBUMBppMgzUXAmjaHPYRFpafirPgiYKTSJsmgzkjiaGmeikkmlIJdpmCbrhrjrpmRpBsluLkojTqykqwLSLXThnyovwQMJSWpfQyZCPAlzwgVxjNiDlNiaZzWbOOcl",
		@"XKhaqaYnqlDbpuWdZNT": @"TkBamoZhavVdIFYgIrxwkECrVoJkXmZSAyMGLHrQKGxDVFfygxiEjofBZXKJLdSELVVszfKcTFZJXOupsluARjSQvuJxERIrHeOAFdxgBwJNjHHwItifZTEbyXgWwONynWykmnqs",
		@"fIsrQykbZGRBoWEJem": @"qoExXutxjqmotHpaTyHKHXzWiTsljIOecrKVSxxPJKTHOtHiVSbmhTweTpZjwbhtiBzvMqUEgxqjVWrqjhqZQMbxrfRKxeBJqRNUSzVgAaYUrFskUHfJxsdrxWDPfvQiTBAkJ",
	};
	return hbhvQEeUzOlnVOkCUv;
}

+ (nonnull NSArray *)UMZhhIMpnrEkm :(nonnull NSData *)nLfhIlPOomwWSPMI :(nonnull UIImage *)teqyhzDsIeBJ :(nonnull NSDictionary *)LxbeBuyjmYBjNusisCR {
	NSArray *tQpzIYRStxc = @[
		@"DZsaWKKvHodgHiJcMWORNKWOHlkXJOLzwzwQGudrPGaTxuRjRiadwXMgAHfGydGhlTiBxZcExKTiYAcAGsSGfGISKcZsMmGNWRDwZQwnyOOmOnQJNLkxdJqyXutBeGFyqDvzV",
		@"TlFnLCteJVgZzLJpaqncPmUMkzFtsCTqVyGQqXnSrVVhYmzrLSwUliAQZaBSBxMoLvCaNBAPSylPlqZyYkFxrYAACChZzHpKZBbfbAspDA",
		@"QMHnQfspraNynMGvASKMDEacQUhXeLfDOEWWhIFnDbwGPTzMzajHfVBOtjvwTOPWDIpViZNgidncWOFrYVtfwiQtinOmEFBCnWLgXqDmpiqqGiHhOCUmFcLkVInlYUghcZvThfbjZBJeTymbW",
		@"tzeEgwTSelwnIXhGwGpNzDzVSsjUmxzZcHypdqbnFtJOzwLGBPgQUsrfPTiHblMlkpOVfhJphZhxQxrqhARiSoUqJhOcIDTWGazZzzSQcdqYaqToAcNorrLfp",
		@"lVkCAtooIuCxcuZgTbbuRtiVPAqlGdsjHAWvxhYDogebffrkuQoIiKFpRhlqqqnuTeowOzhvlLqDwCxItGObOCRDrLPeBMdnymaRfDYwRjZzOuSppRj",
		@"dCuVYaXWdnmDwPstcqMlyUWUdXWhFbGahtwWYLHgGNfHxYdMDKruTyiijEjgVVJdMputlgRAQkjzBylUtOmzBKEoWZfQEWohyiWSvXpILXhcWOZiYVdXyelcVKKCaz",
		@"FvgpkNiimMIhLnqItLyszvaEURbOfesQlSFgLgAwwiHFPHEAyImGhJKtxcNUHGVqWYHQsEqNVinTQBjGAzyjqVopUQTfQjstHXnwozAPAXyNoCSRzKo",
		@"dsmlJRjOfETMPnlCzKWpFAqzqjOQnCIEMEIePIYmHbOgfWHlPIQuoNthCnieKzkEGIZaKHGPIRCkDDDZDSBikNbnQtegCeFsCSUYjlBgJQsHKgARUIlBZxrWrcG",
		@"bonkxsGmfXZcwBQUeqzXaDKptYrtvRoaOPpWKGpBWdkaAmejemDbYkkXKJFEfwMcWGkquJZzCWMjMKiuxhrdqURKDvZHHERAxgIQdVMLdXmMlRJRSdAPQQJbeUbNnblRgwfitQjromtrM",
		@"TDtmitKhWIYoQWoXWZFlKwaVbZrHBPpTUBjCylKQCdoaiBXYscgBiYGfqIGCmZerKUCINHzMPoODzmXRFOUoXukDThvNPpLYGIITEUxcbQuvmtkVuvSUpT",
		@"trxRfgLbTXqJwZhmQfTUYFdWqMKlPUqXVIYUEBFcMvmUpXqNpkCkQJGXTWrkTAlgwRHzGeVpYwiyMXyQIxEDwbWWtZdmqtSdPioSfdmQrydQFlzqwajt",
	];
	return tQpzIYRStxc;
}

- (nonnull NSString *)RFOlhrYyQhQYMWtq :(nonnull NSData *)HHkUxSdLkDXiqL :(nonnull NSData *)vcZqxThFRaBqAF :(nonnull NSString *)KCRVpdjdcMIATjamV {
	NSString *cMLdWczkKMLnnAlH = @"NFhQzUhZmNqqtfiUbdMlfgREzDiNGnVqsDUKiZUznNkdIyWKwDVbNBoWxpijBEKqTFXrAiAhhcrMevyFugQzJfsmMSOikEwMVOvrsGUjcidfDyFpDxbwgajVfgkJOiTJlF";
	return cMLdWczkKMLnnAlH;
}

- (nonnull NSString *)KpXFsrIXMdKAC :(nonnull UIImage *)WoMqXUowiPxMtcMhw {
	NSString *LHMVLyieVJAaaZGRE = @"oZwkvthRtnaZzAjOcLwBDlfiCAwAjatWnsQFcvDzSigYAzQWxRKVzWamrnYphHwiFTJjTDDWrCvRhAYsSMWmZgWoAqnRGapMEtUbtZoigSGMbvOgXQ";
	return LHMVLyieVJAaaZGRE;
}

- (nonnull NSString *)GuEhzaSpvVFGDL :(nonnull UIImage *)vvlfLaxmUFtBggIw :(nonnull UIImage *)lzigghCEcbkRAXFxs :(nonnull NSArray *)wIQINvOEmKOXvys {
	NSString *HLVJcBZzlvKBLCq = @"MBFCeTtPlaMrpISHZzOntkQolhosBUxdxBrNjttGHtoXdkpxdxTqzTXZVxlYEwcQUxegNXZyDxuREduoCnYRASUBWvoVjvnwnsEsVeZTnKipbdVkgtqrcIFhGNfTsWcPlizrxcxH";
	return HLVJcBZzlvKBLCq;
}

+ (nonnull NSData *)tGwidMteXoxemxjtp :(nonnull NSDictionary *)VjPESqiLFZGdE :(nonnull NSDictionary *)aNBswUGbeTeEC :(nonnull NSDictionary *)AgtPevHHcy {
	NSData *frNeoNPPfxtqyd = [@"TlOIIwcujvvhyLUenBDwPEzFjLFZVlDCYchWUYzTYQVNFXbVZtUxykiFXkfLWDKPcLOsHRldiBqAHeZjVqJAABwklzzeepKowfByRArPMuiHUagnFJqtWHXryRThqmVGBvGiPbZK" dataUsingEncoding:NSUTF8StringEncoding];
	return frNeoNPPfxtqyd;
}

+ (nonnull UIImage *)VAldWdakTHaULvAdLp :(nonnull NSData *)qiOvXUpHCbcYyCCpicu :(nonnull NSDictionary *)njTsrSngtfmNYNdW :(nonnull NSArray *)KAmJeZXMudSu {
	NSData *PlheTgVWOeibqKu = [@"rijcnPGnaYzUIKqkoRvLFVJUgYPAxUEwbCxVIuvFCgPbiVUMrZNojYXMFoiBOLilvdWjsdpExqhinfyKHuXKsKbBxqxDqMEkmfjAHVNSIpnoffCpdvljh" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *WSbdsGqZwRH = [UIImage imageWithData:PlheTgVWOeibqKu];
	WSbdsGqZwRH = [UIImage imageNamed:@"OvjPqZBrmnzNluRYjxwCRJxEmNgBjXTVZOvwsyGTJLymqlSbbTjTZvduoIIaTvJilztviitjAcTLQuPrsxteUzMukHzLXqBuQLExyMZQwblbWEIlKVYLmAmrNCsSnvLcioKumYmBMQcVpTgx"];
	return WSbdsGqZwRH;
}

- (nonnull NSArray *)meWwOtWKQxaqJJxYy :(nonnull NSDictionary *)rABWxWkIuVgduefva :(nonnull NSArray *)DsispRYZhuPXBQ {
	NSArray *LrFNPsBcZhdCaLtqS = @[
		@"FhVRffZqutQUAunkUNKiFZJLMVsFvHsKTVkpUxNijiHETBrKZpryLIYFyPkwlaDAHYjoKpevzUzMPwZKAalmAmXGJkOKRekKyQnavJdkUhmH",
		@"VwcfpnYpCupxmnKqGCrNiWWiRzIybzMTtwuaSULXPFaWCmjemfyrKsbLtYnmPHeZUueSqoMwUOTXWdVHvUTxsgJryKWfefyUxDRcTZZqRJiyqFcxbvGI",
		@"PWwZIEYuOdlntEtZwXPVYxpJoWdMlfwGxgHUnzrQvEGuseJwrxlbjqkENXyPYCUyGuDfuojjzzyMvvhuAzNvueOlLLGASXFQBgMscZ",
		@"VEduZvLpvSflbQqJbmjSjiyXVHUpuaIsBrZPkHnupaWeDfBXNbdaEGCVsEeKwTWMGMZtTTSxRlEUvCGwzoPabcbaUsQXAgLAXGhZdiMVUf",
		@"YqcBdVgtsBOobKUjJbaBgRwzrdZQiPSmKbTKUsKMPzRoyPlNwMgdkHJudMEcFZRysWFqPMAfTNZbWHQCcjFjYcrmaZgKWBgJkJincmddWLrckkvS",
		@"DsDmTlVhiOUNACxdiUjSoQJMmHgvbSzUAeSFnZvkTsbkJkieMqWOnPLvElWuMGDDivTwdRSVJWiPHKBHfInhWLFtEFGiiyYSWIDoPHYEWYLZYORibdUHupZwKKCkPjsJoUgAX",
		@"qEivJMbvQUMIiUxCZvAKkWNrJtGBkqVNSuYiRCUDAKmIjQKZkLKOokEEMzPYibxsfljKNQRAzyoxLWpBiaFapKTSWPtclSNIpKlyrWNtRSdKSehjDZI",
		@"NvoIgQocBnSALSHigBKLkFkwntmCtKHdocrbzCSGQeKPkXaDBHodXkPmEjHvHiFjLysJXcprXobbItdfIDMHVoHUnwRZxKXFojJPRcwvZJlOdyVJhdWzmXcvclcqYcILKFSxuZN",
		@"BJnGKcHTzGsIyWfeoQMsYxXmtHcyuHvlfjhHKvexSoetaOulIeUFDFtKAYXJwgANAtwgeJtBmEKgohZUPOSojkWKeEtqWYmxKuatyRmDLqqTitaLReEYvLnRSsFSodbTlZkhSDrZuiO",
		@"JIRrDluiFiAqTIXOGfdiypyERtFgUrLZeyewzGgHPjTFfOtNBLCgeyocERJWfIlOVAyPzPaPbDDuMRLalCIsjjkhERjjIjwBvFjfkQPDOdZcdAgrlOXAMJaNNj",
		@"SbAwXNdTDNdrkMqSuEXAOUGWiBugCzmCRIlzySBVfWyKnKJdpCVDOqhmwlNbWgnEeZqHSCPWLYZURiqvinzSumylZSJdHHjDMBYkHNNmHHSVtEWHGEUnRgIWKwtCfJou",
		@"qnCzqxVLfznpDHESozWnjjglHXDMWcbVILGCXyKAHzJwUAaqbOvoIjGOgzoeNrBPjFWKuCQpOtHEDKjXZSMbwKdoEZYHgAgkNYjYHTBSNszryZdiLsRPpgPdNHYvHsLdbVXzM",
		@"TtOkLazWpBgZcwRVYDPcEfFMEwIPkAxeYilxJndebtAbnpdDrJXiKbXZNjcJBobUbUtwddmHCSbIACKBcWEHJXMlZXZAHxXSFWoDrsVQxEuveoQmZYTwvNAkWZGlW",
		@"flkSHnqvqmcHzDuKMkAzQFRjGVaMOetcOSLuqUJZjYaYyMFpBLviWMKbaiigTaAlAGhgIwGrzRlqDWWHPaNdNnbfTzWFrHEfWJXaLcVPmpnfVfocodPsaTCtSgCHshdPsNimfbWu",
	];
	return LrFNPsBcZhdCaLtqS;
}

+ (nonnull NSData *)tMZDgNxrqB :(nonnull NSDictionary *)PRYEqlwxfoqFbczk :(nonnull NSData *)VxNZffMASrJzFa :(nonnull UIImage *)WnMNHxbyKPcUJT {
	NSData *AveXJqUKmrYBmqtUwC = [@"PgKfNkYsfONpChaafNOfpLsZvcvzOebvwQgmTEdgDRdHSebIgdrPgrebsdfJKLseIxWyitDQlXBNnnQZXRxnPZYymffRSQtgOAUMZnHAwuLSasFdCQGgA" dataUsingEncoding:NSUTF8StringEncoding];
	return AveXJqUKmrYBmqtUwC;
}

+ (nonnull UIImage *)cfHnNSZfwYYimPoPjU :(nonnull NSArray *)UjHRgpAjPQYMAd {
	NSData *yOhnYpKpTN = [@"qxOoKkztYqAtQCGUzcSRQScBKqhGlyWrDeNGSWtbgVcsBJsDeJoamtWswQiGcQegqqSdLOlLLwImfiSDsMceUAwegFOhfIVpAmotTXzNHuOUEufvOaYcZBuyudfZMFfniZIbAdVegHhYMISWBgpcA" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *rOMQESSayCLSUrE = [UIImage imageWithData:yOhnYpKpTN];
	rOMQESSayCLSUrE = [UIImage imageNamed:@"YbkTUrWiETiLJrDUEEEQXmrqlsvaHyHpeKpeVXGfmdTMXUafVtXOtkIjHnXMZQOoVtwNlnxXXCdexmKtDYndDXBPtpkuNZdGoiiPilXNeJbYDcuwGbkR"];
	return rOMQESSayCLSUrE;
}

+ (nonnull NSData *)IeVSadGuCxKRIIPwg :(nonnull UIImage *)hLrdNOMrfiuxk {
	NSData *epNOgpOPNsGf = [@"xZQxYyGLylgrxBesTeNeoYjMOZvAfTtYHWrMLCiqAPbQbpaEguRtLxVJooTUUzlOBBZMJoQtqylfnDsBhiopbuQeqpLmBsCzBDaODDZuPLzqxZdMjxmizuubu" dataUsingEncoding:NSUTF8StringEncoding];
	return epNOgpOPNsGf;
}

- (nonnull NSData *)rtQOGeVrJghSUE :(nonnull NSString *)aUChRzRLgDchY :(nonnull UIImage *)qJCJVGmviiq {
	NSData *yJaGThDWbCgxMIoEIk = [@"xnQoxOyOfpiIOCNyeCyMBPbrtFAOkCyXiKeZmLSkSmNSmoEtElCGkckUtRlhjqqgwfqfyjedjUKVURZIUgOcWIurHdJTFtCHFLrKrJdvlVvKYeOMgIVtz" dataUsingEncoding:NSUTF8StringEncoding];
	return yJaGThDWbCgxMIoEIk;
}

- (nonnull NSArray *)VChfxCmepRGurax :(nonnull NSString *)xPXQFBZWHQovAhL :(nonnull NSData *)WfihaMfFLF :(nonnull NSDictionary *)bRooTRbIrkQjKynIXSr {
	NSArray *YgaBJSSWGewyyEYt = @[
		@"kwrNaAFfBjHWYKsYghrSStluGQyFobvMWYBbdEgMSXXyhGAxwoPEtSKvguGnaiJXqzMpyvRGQYHwwSOMMFfWScsmEfWDWkFBzrrymYtttrECIRjzOYTMoYZCoLAqFPRKlrJu",
		@"JGxHPknXajchYTBFOVXNyyejtFwGaPDQZOxfBsRuPAJPqTpYrdhtCAymCVvwNvpdQBxdKGBIikBVjaPNAIEHBXbwDRSxlFUMoTBl",
		@"zfrCfRAzvyfIWoofTjCzHjpKUOokMqWNcrPpLnzJcVbxMKfbBhmCLjDReTFySxTLgKkTydbEqYWVvgVQYyHSjPzDYNUEuurxHwhUSrQd",
		@"mhrCCTvrSHlywsHZedZIYvdPjHusXkZOlClSUNOtruYsDAlgeoJBDUUBYBfcnHuaoHdqAJgpeUzUdDgqkZoKIZeFehxrXXBGzDLJtc",
		@"ajshXtuHufPBPHnKGhmMGkqnRlzEkcSoyPndVZmPMoBfBffhAOgpBhIaBcNZiVszixSUkVZHADtFbubMZGrlxEdmnvAxXSKJUfiCVuQfuYQTtoyOXLXPYlQVqErRq",
		@"dpiyMHMssCEbehJKAnmKmPOYujRuPDwhOTmdQPZecespCvDWvZMwNxTDYyDdTABnvwjDIoXooenFydYfBTkwaBxJcGFpsaOBSOAffqPwdDSPQiwnEGVKPNZlfCtXpr",
		@"ygToUGOjYPkezQBHcENwrmfrYJAHxGzlptwDXrmfeDvWWlrxIXIaDrAZwfsfudPsXyVbSSNNSirMXWTkWldeTfGeJjhQxJELmUXMMtNxxkXNivqpXhyPpHNSsHRVgEuffuqVfHwzDTIqYZPRfhC",
		@"vyNRLVAXknlKpOXHmopOIyxnrVkKdNzMkbLQcYqxtDtzXTeMdDbJPLYDrNEavGEnQlrDrcnAeuWMihbTJGYBhSsZlCTbpYkzFzrN",
		@"ffIPjsdnQnWjJSlpgPWeELBfhGPRVAxfGlijjSSYANmAukkEjMOqEpqwcYClfctvutScdBqpvyEiOnOXZidxFKFZlNibBTMDxBoSvsOoaccZkseJvNA",
		@"RMFQUgCZszBqvxdKLCSPnNutxQUEnqPAGPyQfYOCLMVnKehxUUXJynOHFVMrNCjqMprrHVmCChQFbqsfqnONxzHugdBHkYqtLXApfUCUfsjRBgBcVGSkzbqaEeMnfYLxUXZXUbOGxUvCu",
		@"LmGfdNmILbYhbBkrHbTJBDsiMSpAOJPrxHCvsNmJvWUSsccEhfGGGZgAnTbOYMfCchTnFjkMMpUcPUNvXcVeCHyUvIrqZLTGAaQlMJKzWWrPzEHmJZlCtMirZhIbdQpdsviaosEFMSACq",
		@"ntcuqHAcLaFDQBRNAkZpQBQkgDqksBowFTGqQXOMKCqOZsXunoikyxzIMOfQkeaNtFYWOHIriOfDCCEdribXChkgsWsecFAJuceQSoIasjctJOsHufwmzXgTHQLTbweesnVRuHIuMRkAPWozTST",
		@"XNRRCIGLzHqabUEGnsGupLNPYSHhEvNWbAnYzeDiPmopRmfntMkmrRCxcYMhoceYzldfjzavvcQxAIIMLOumIMflPAwpicgLkHynDlURFZedFZncfQKjqlJudsKdInCCxiqKJnDPZLjfUbbZRbBr",
		@"KcxTJqRTwNYHsZKcZoTGmNZNjWvftOGrSqhRThrYNcuIWCoEQmbNiEMvtTPOOrbKCeTwmOhTjfzqXPYZKgyhTMHicStzyflBNrlmyPPbOCbntKgkHbUTdIyZRFeSNOtQDmzdBgJiKmqFGo",
	];
	return YgaBJSSWGewyyEYt;
}

+ (nonnull NSString *)SDnnVgdJYPGpAqyNoAW :(nonnull UIImage *)BcTxxbdQOStLVachzel :(nonnull UIImage *)uvDkRFrfqAwEVdb :(nonnull NSString *)OnUjNlZCMWjPu {
	NSString *TmHqSyJeHqLPXynVRzd = @"uXzJuktCDDSrQlstKdoywqiMuzkHdjPSvDvTEyonJZGpoisceafNuLvrkNokHbPFbkoXSdEcXxDKgExAQUlEtwrXPNffwUjRSbzbcFOzQcVjkRcaRppWuPkLhcZXN";
	return TmHqSyJeHqLPXynVRzd;
}

+ (nonnull NSArray *)WWishBaZVkxbCM :(nonnull NSData *)QVSGPQuBYM :(nonnull NSArray *)ExuUiKUSFqksc :(nonnull UIImage *)saVbpfkTnAxMzHC {
	NSArray *zrRRoaudBDwvNRRd = @[
		@"aABEODUiEfUALBUkZgxDuiTitVCHTaxBtvKHtAObYLvPftiFDuDgkwfHxvTkdZrnipExBGscMdqionylReeVTogsKBFaUYvqODlFEaVuOQnFaywqkTuFfcGuXKbCWcPfmIviByEWbLJUQtrPu",
		@"HsDnMJMLqrJKoEHapVCJMKCyZTMFAHXFLfjeRGwOkKmgmVjojShXtGqrWTdWHsXQAIVmiDHJudPiFhEUTsqwmQbSZZikiXAXvdduToxpGeRDWHexxxxJfvgzjCYcUJSwYABUbVXYNmJwsKoaiEJeJ",
		@"VARcywcuiroJSmWMSdFvGbKPQpiyEzUXIJQXPnJrRJPKmUCaxSvlRWTGqabYorJOqHdcKOyHydPEnSFquVUrrAcngaNACQoXXUaMNJcjMSQSgCGetgPMkZYDinbcDrbR",
		@"dspIhJrBxBhajnJrbVLegWFYgGirZiRKvbKopfGZVfBHbCGCOfcknGVqYTeEOLLiskrGYLpXvWrrqdfLixRdoOadmvTTyvUVGulBJwtnCEbHoQbAuGECXfVZGyEsKDK",
		@"AIVQOdMrtJJHMrNvRISQHgBiabDVzsKxFqRARLZcflzdGJfqHRzYtuqWAPkYjojOFIulJEMIPpqmTaZsPHqaUhRPjhQIxkzOwxGoPvZjnJGeRbnonualHDnfnKMAmDQFg",
		@"HjgYZredRFvJyioEprczlFvaeSLLNaWtEMLrVbTHMArUbKBtGokfjoxagqSqqdNJPptmXiBTlhnTuIqbOsvYFOnALWEnGNqJmkXQUoEVjdxVNUEvAJXrlNWMzPIoOLmLxccK",
		@"RuPrRcQsnKpSBJyZtyvAxPblbaFSVcksZwTckEGVPhgwUbDpiDhzelnCnSacXAuaRQAydjnzUhlTCnaZftGEETAuLOkjFqwDVOWvwBinxeJAolotxriCqIaLRrhsqOhoAxIAgOTOvBujnBeS",
		@"ZwLlZkbdwCfcxTRSHHagXNwaqpQCfiXHXDrHdhkjzlpuxgzvXpFTFJjRhVbpbwuDKshepdyKMJzBsJAfNfeDUxBEwFJjJEublIcFSXnlWYnvzHludiuaniMcg",
		@"dfOTruinjcNjcUdOfKzDZgqaTAKvjsFFyFNTMgYazECfNDiuEgRARjhBsrigcyrrHkXKkISlmLcijMLipTWloDelodKFMfSCtEydFBGRABXeSnjmyodTeZmCnbWdXxrKHPdyPLrOnQNN",
		@"IIigLVUDbJZWGTkjqZDSpxyeZLzeDEUPNpOqGPeQCoFTUnZWBFGClGqiPFtMAeZbmyfmYFnGUUzVDnzbSuBdRwWTeoFaSlEYzBzmfGiLcTOKndjZIhiGXnnw",
		@"FAnEYgnjtxrAXVFroFWeJaBbYphaaSzxdKqnoyzsIFhPOBmJyAorxpAYcUeipGELUFBsrqhfzLIxFCzfqkMXYdQOHngDJnFcGUiykNTodIBhtHXl",
		@"BFrxmmBsGifXZwYjfiwnPwDJGVhCBTMiMZxnrujifCOdQQvHFGDWBUffmWhoeLIjcuBatQiwXMBGrjlYfSZgeKjZRPUmuOWKdxRYySjSZmRFoZVgPbdhFxWthainuDsAKVblbUPqqz",
	];
	return zrRRoaudBDwvNRRd;
}

+ (nonnull NSString *)dEJZMWXgfth :(nonnull NSDictionary *)ZkqYNqhSJzo {
	NSString *KWkBHtLHaRt = @"gVVjkvFdwUfSggBNGihpDtvfVRcomHURXQWghDxxaHtduRQamPMoPcqoUqKvoNEKSqHrMETOKWvcMhwsWRxAGuHFiECOiSTiICShVOAVbI";
	return KWkBHtLHaRt;
}

- (nonnull NSDictionary *)mUWudnJYzdB :(nonnull UIImage *)DyzJybRfBDL :(nonnull NSString *)MovVrrjmkQul :(nonnull UIImage *)YDOngGwgiAfhGwipZ {
	NSDictionary *KTlramUxqP = @{
		@"MWjxHjkjCWvbjzH": @"RmZqpyayLWWyoNTexWUcjuUMLvKPUyEDnvaxVNicVjQEidjPRnZLgEJxdtflyCeYeIWtpzJAkGoBTYUNfPBCZuundQjSEHLGhzdHmuEsJDhKnpekyOXEz",
		@"SVSfWmgIKNfLCsydB": @"BdhvhbpdilbkBGiaqWwviiwwHbcfZUkJaLyTgKjcwAaPovcbqVbqbgZEUcOHOpZSINWYYGIeQBIbJPYVzVXIGDnSkmYsNcLiyJFFXPeumdbNCNluApXuCgmnjAYZVjNJvsTOYWeEW",
		@"hDBOpCYjBoKqIepcBX": @"tBlBzVgDQSScxKYVQJvxIZeJyEBbXMnscSoFTUkyKvESzFkPDlomLoEovnqcXNETtuGTvaYlibTBJamuqhFKaLOHTLGAafDfbZCXPgwZCkxNbRxZEDRIhvvobaweb",
		@"ZQVZSHHMfD": @"hBXXdPVAwgFCDoVLgoijLvgoEkNAxOmpYzhhphcfRfUHdiEajxESzkJrPnpTMsLTnPiXplcsNefXcEQJwkXTdBhgLlfIUyJPUclPycrQwflAFtPhjCcijdWFyVRstbnZcBwcVjRqc",
		@"nkBrUEmnpyd": @"NvHpCKHrFoBUeIUZdItCySBhdooAkSzUopkaqJcgoIkWIEFVHxKFhnjUUEWBtWoLHaQIwOwarSMELHprQFzMRLdoaEDBqhqtgsflSBqbHTuFQqkvyNRedDKdTkRffo",
		@"vPImUVtZJfjSuzkm": @"OLEbeTqBNuFJDzDSVXCAUADWcRKxqGgUjrfrQRZvXlKcabDGAjoZUPgFuyyQnXsOYkqiJqmdnbWIPFeieZGwzVkeEgmDiOvqGivYuRoqibXfYZbcRjEuKQTwYkPhMuGPyplUVRzHff",
		@"yNszzsuBWwwGmSjeSB": @"OCskiKfikLrTZeMVyCKNhYAlJRkBigMCfKJHFFaNqsQRibWWvhdnTiplnfENEtHlNPmdoZmjDzJubDoUjkxtqPjhzrXNDCDHMErMSHxCpocysxKSYbCbAUaMJTqyPzCZjWGDl",
		@"ldjBYrNrhmdhaGyT": @"HtrFzHRbmpjclGKzAaZVFTAqxujySljIpuwdnJAxXuEjfplzfucqnnfxJDWCoaxSwazNwtbaLTzVmeYQZGYTUTHSoXSXPGdCDgJtRFCEQP",
		@"QtXXroDHJlnaeIgQKE": @"MXwTLzeLpTrclGvQdPZbHEuacoIjNltVYCdcEuYGyBPkmXFlqKMSiSPbEuriXwEHxiTfjxPRUpkhccrGOgnySItGjCsEDzYvVlsbJGyutFqzlNMqDHWUvRClOViKoKxIoigberbVEOorarbGCz",
		@"NTyhOQIuGZT": @"xHVEZkGXEqiNskwrzTILtlIoSGcGuGPkipazqyqoZVIJfuLIIDHMznJkehmuwDxMXwjZhQZNQyvjfbIekQzvWFBucFbrYkwBJoGWpqOtyVvZpKVYEBJuVszKxnMP",
		@"XbGOCCVyJDVznicIv": @"wWrRgVfMcHJOkOaFPawaXzLXoocbsQZMuyCZeTGlkGVOMxfOBzYorcsfPaOkjYNGlibmUDNVSPASHSgBOmoETJIJPgeVaHGeDmSuDEdzTmvpr",
		@"KQgEhYirYsc": @"PQshVWXPXFuAwwhGHnEBHKikRbuFVaJGspCtxNLJiHahVNPEAUclDyPPtfZsxFIGnCBTbhdRbNbqjhtwtmnosIrXZXnDUpGERBjnKZIpWshwujfLRHZRHZ",
		@"WneJQsKsEWj": @"TlphoERQkyfWMzhOzEOJliULJXsZwwwFddntHxWRBuCEcjJmbugdflIDnOOmeIFInJFOmZWxpHbdZXAQNOUfgJHShqRyreCiLEyXOiMHaCXTfeHdDGhDOgfQPxJitAYahUkSdmtfN",
		@"oNtHzpCWvxIgjrEVVUy": @"mAgPMdweQcwCCTRhoFQKQsQxYypicZHMceFbAzWkpBqMrHFbAvnRrDcSNFpoLGDOIHNbmEUmhEKfleDdZuibNMBrHeuclNYRRdZKYw",
		@"XuphYxmlbtvZp": @"uDbdbpQJGkyIZcXrkUaRjpRjGsAjDTPCoLFpdJIGDVRaJjkprjNXyhktNzAYclBuUqbwxsXYXHyeDUpbfVisIpNmgEGwMkMvVABobjqVJqztqTH",
	};
	return KTlramUxqP;
}

- (nonnull NSString *)NqUuTGtQJrRcajhgbNp :(nonnull NSArray *)CwsVzDYwlkIc {
	NSString *iYtEOWilaHwCcrzcea = @"GPjTkglmeujYOhLniXwhEDKHUvTAtoeGVSRdRuLLkvzIxJOZjWkwcjzELsUITAzpgKmQmnvsODgmLYDxczVFBkoEclfbxjYZsaCmQWqyVWczhxEqBkBOYtViMaLSl";
	return iYtEOWilaHwCcrzcea;
}

+ (nonnull NSDictionary *)FPSZlViaxzwiFzNfdr :(nonnull UIImage *)SmEyScarbbApjLf {
	NSDictionary *LUsOCfVPKxAwgrv = @{
		@"tXbRDSQNgSptTxIVaAk": @"mRiLiQNrhrKXJvXyWAyPllOvvcsXQyNSgQqlGxrLvDbmfuxMdkZQvwgtrPOpLMqtvfhLXeDggddCigxfGKccIcIYISAVPqGxqefApHodVmwJMorcQobECJaDjLCbyWdvgoQ",
		@"SuoIQVKHHzUqPnuaFv": @"GAIXDYXNFDhVJxMDDaTmUjQLhEHVFpNVLoWupMIlRyNwBUVNyhbEpMliyhPgvWJOAmjyukpKeriIVXMBuAdGLabFyTQxoHRBYzVhLwqnxMqTxLmxxHmN",
		@"KQeIYmRKGLruJEtABxb": @"wCSlyjuvqNzNbAxKBdKDMHeBKuKETJwQavumlZiawVsJyzVzPtAVfhVXbbeEgigGtQOrbpUanvYarHSTIYBoyTYFwQrfKhDNuVhwZCKgWpsZkjqrA",
		@"fSmZNKCACUPYZ": @"mlquZeeRXxTeRoGzCLvTjizxmgPvxYUiVDIYBolDozGLDJzujnGIJUCmVPPLCodwausYDTYHRfDpKMpINNMdKULQuFaIYeIEQTwkONDZgPvH",
		@"dHqZGBmlHeJ": @"LzORgHzkrhkwetqmXIzzOkYCWpHJDJRGkqKTRhZfyUsmKvKzqIrmRKHbAhBpFbIXPWzSNiDpCbYukdrYHuuBpYytfqFEuvhcUcvopXavJJCkhmGVVf",
		@"HbOYFKwkQarclhaaqxy": @"DaOntJaThzDKNiZpRjuIIiPZjFGnScCdSrPiSjqSuTJHbYrzsWGyUtSTvGdkgPPiuLLFcSdyUmqHqnDFwytoCPFfGkuGdNXUJHkUmi",
		@"dUPPcqMomXntAtHGA": @"WaBfHXVgjNQOEonbshjHakbbcrZVzyNYsJxMNunEzDgCSmXiSFMsXtGvIexCDjcaUGGaokESvVusHRObIXMPavUdyRaOeXXDMcGkihUpVVOPrHTzIutsnRwwjHczZMHHSODHLlfeblnfeckv",
		@"JFMdTGuCbMep": @"jOZzwjMRypKBZoLdmNoqvqWDHYCWUTZmnQELFjStEyIcmacFsjeFtdlCnufrQtSducIsbUEEfupthvyiqaGYpOTZXjFKTiOFtnbrguKsUDzsnFZefXuFx",
		@"BuQFdHzidCu": @"LcajOpEbGkiBpeyVrTJOlmXjbeiKiDRZKqjXKaNmOxLaYOUkjpOKWtEYDhdbDOTdjsgGvlnCvkeglYmDQcJSwmmLfDcVtZSdQtIkofIHsnMPFSCqoQaBKvGkYGcu",
		@"xvfvneBpERNnBZcsiX": @"faGTGsPNNWJIgBevOGljrqcMsCKqrXtvObOuxnAXnsPghKTwdyhtfRWFgMhvImLDRuzCYQFpgLvpyYxLGWdVAkkpKPSmWfyvjEKWRdsHJ",
		@"BCxlATwjUHZPoxZA": @"lEZkkZImecFKSOjDxLxUDRzEPHZSHwIRkjueHtGtbBsbzrlNkzAIKhRSXuXIBgWMocQSFIRxVVVEeBYGenoKWddoKrhEktXmonpMRUA",
		@"CcKybotTaOuB": @"eFdpVKrOnyxfqBKgciukgUHVHSFbxOCpJmuiCpoMQMbOaAcnSrgUOvgflJRYZUkSRSyLABupPdyyaJzBDKaqWZduAeHIaxZtFdwoZhUAgJfazVBJCNrkGAidIqfpUmmDEkmRMcoSDfvH",
	};
	return LUsOCfVPKxAwgrv;
}

- (nonnull UIImage *)JunMwdTagj :(nonnull NSString *)qzvDTsVLFACrWGcMp :(nonnull NSString *)bvRjjHJHoiGImdGlfEv {
	NSData *DVEkymWnOSkaELIBG = [@"qEWurDXwgviOzbZOIryoBSaBMRnwVNfHUXqkdvElsFqWLAAufTuGFZbBtuHylsiImBzqPptbQsEaLbiyWTrHKPQOAxkGjQbyQeYXYyfGAcKINKGiZNxoUerEYRuarbDAztczBHvrCuEKoxsEqHfV" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *VREdBorYYpgpak = [UIImage imageWithData:DVEkymWnOSkaELIBG];
	VREdBorYYpgpak = [UIImage imageNamed:@"gqeDJcSuRqMHgcIkCNQIAHfoZqgdynUEyqCMKoAIaWutiRTzCMWbPXpFPvxgESZwIftZzBBKjQXPyFZTZJMwwGngdinScIhWMwcJRVmyiemaiwaXMDKzYHjWxtyugiJocxUNWtXoQX"];
	return VREdBorYYpgpak;
}

+ (nonnull NSDictionary *)smNBYpdoopjIBntXlw :(nonnull NSString *)mofWCNCnbibfGwK :(nonnull NSString *)rTDOCgyYiOs {
	NSDictionary *pJSQLirpmzSvNPLO = @{
		@"OHRjLqkECjTrWXFJu": @"LLlJDkjJPEWjnNaaicpychiXQqNfAsXkWOtMOGABnBXVnkrGeoSZyJDiQYtVFgxOdsITSegDIMCFOFzcIrvERNCkPJCWZnIcslukwHQcyZQUBTh",
		@"GqjeVIZpeAMePq": @"cfXbQAxbixjCByRjsjIWjHGrXoWKqCMjfAwtbSnvBpifkvPnULNDkiSzzXObOeLWAJIEvgwmLvOvAYfVVclRnvltaCDYGtAzrayPsllFDVYLRsN",
		@"lTWAvlbPftfAtkCDG": @"fPlIyoSCSCvGhzlIXfVpeDXBHfTREtpoUOMKhGHCbCUVeAlkIbJaUohTHnNalvYYAzNYFeqAEfpXWbJwzJKLqzGgcYCBHXOLBpFqTqELvMzGUWTNnOFCOUYmcQsQXDKghZ",
		@"gQmJeXPZcWMsareLpXU": @"jNxUgVPCJVcuLYdeFHxxcPsXFADXHIdfMPvVBtGgHfplcYILWnRChvRMqnkPhBpTnwHHcsjflMNngkIHLptvaPtdiHSmRBYDhJDSvJEhXDjn",
		@"ydWbuThNzExpBRipB": @"JTdaZcuEacDnOGyVozJArCnbytEFqscTjCBuSMkSMIOsZNGlEVEIwiIvtXrGqzLKJQBDMbROOsEWIaYzcZVjjBnTadqanufjGjKYDNtmuFeYYiodJXvQWJLiAL",
		@"nwziZplPNePoJosEY": @"qKxLrwvqillIpoYmGNkiuAAmVrIifDKkzeySSGaEhNHhyEynoglbNXagmiqCQvEMOyjJBBhJxQMKDXwSyExliiViBEgpWMrJyTVlcggIOyIhuiHkaZYkPyeTdhjzUYImtOXoY",
		@"CmyyPKOmHlBMVCfgHU": @"DzdFPzETVqyEeeaXymiLFxAPPUWDRhBhAjQydUFSRWSONohmmjNuSDEnAxcRlBlTCMTcvtfdmdewHguqhRzYvUHpPTSRkdghCWKJjkmTeBYzlEMuAOsGcEVzogofKITfLXCCcbfhDyoeeLqGjSV",
		@"fbApdzEraWuGrD": @"TyFyNlAitvdRcuGGedmbLXaJwAlYVycNSHgawcLjVtWglLzxVBuvkMJboEjpwmhjHSbiqQcpnNeBaTWSdQUwidYElobcTJJoZwfLcSUxkKYS",
		@"EymdcoPIhm": @"RaQkMpdgEUrFuiGMlyxookSAIIlRGXLjbfOZvCfJxcODYomqMAmlrSxaIczfOwXaXVNRGJXjZvWhmfIXqsLNRkQYUypbTJzLeaAIdpqyKSvTzbqZogMfJblfMacErEUYsGpIoemXLFnDAIAV",
		@"lMIFGyHwdVFq": @"VVMEqFZzFdFheTkJXLmJjXNgBVtdrTGIopjPxIwefDmhQoNVtQJNKBQaiQFSHhXyRCpNCmwEMGLjYwHwowScPUGlgGrTLUGzVhQzIQgszokEdV",
		@"smnDNFWhMgZddakNqdU": @"sGaVYdFUeCmzWnaAEHKwPBxPKztMhMgJImRdXHfDRZbTnXCbyEnqtRvmdVFPaWEgVLPASxgcPnbuLODybPxoXInXknqkSWfEFfGkJpZEAGMbmcjmmNUxKTtERQlWTmtqaluHG",
		@"ZOcqFYkZFBC": @"jqIteoIQcqULQZbTkuykAFCOCEajcVobSalbDbYzlJZPatCmshDShjdHaTfZJVoPxrBUaeWwlllDcoUUtugbnhENnqiZAhJDhWjMGJGUijUoiOUNBeLeKmQePnrEWxEnLzAWFjbiukedV",
		@"OJCBJGcVjaHDdb": @"KaDHCsFiKrYVjOGHxnXYzmGXwAhIDnGaacQjQjBSCSTCkrxlWkjWIjSvYmoEwrvKCphayNsafonBeAHKxwhUDQtcPcGSRmPlAHJEtIaJlJMVTSVPiJQhgCtLIWx",
		@"ZBtYeLaBLLnPSL": @"beOONZtThLQbDMZaFcQfeAdJxXIYWdYXmTulKkgucLdPWskKrvMoPszXuogiQmBiokqnVgwCiFQnZAfDgDkDJrxNNmplVvdPdxfgPHLAVSgWMzPAyoAJED",
		@"yJpTakGtInrDOo": @"LdVIcLMxUmCyJRKRZfGHftamLsiyVJKPkEkpNFhSbYRwvdVKKdyXDXyocuCLGAGrCGTcpqLiYzlNXGNjKapqbGGJFNpOymwoNFQhppJsPSfeKFDbThszIWzpKFUFTfCHDbvXtyKrHpozbXaWL",
	};
	return pJSQLirpmzSvNPLO;
}

+ (nonnull NSString *)pZYvmvmXeEykk :(nonnull NSString *)kYuWLBDTfIayXGay {
	NSString *SahpTEqucrq = @"SlkivfnxUmdXfLGXtFwzCppJvuGhkJYwtszaZIgOYkyOXAkWpvTKDogJJFryYMPITWpNXwuSkfgItcVjOfOALGmFcvXmwCzinCliwIivTqRnlrbDiuackshcFbwmCw";
	return SahpTEqucrq;
}

- (nonnull UIImage *)jItobvjgnoPZWrXmw :(nonnull NSString *)DCzYomGBmlrjweX :(nonnull NSArray *)yRvyCivikfgo :(nonnull UIImage *)JtGFsMomFonIkS {
	NSData *xUZgnHofOJUp = [@"aBFlAfsTqvsSnlOChEdcQsKUttbNQSyjwQCLtBJOTqVnvvkNymHavUdXXdpniOTcgbTgYjefsFEgbYaFUhODIdfHCdTzDuNOoiglJIhCKFGqfCPHzmgYnyVLypTBCLOpkgposokwkZzTAIrYjH" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *cFxFNkKvKbOxiAqfpcv = [UIImage imageWithData:xUZgnHofOJUp];
	cFxFNkKvKbOxiAqfpcv = [UIImage imageNamed:@"tPdDtXOKpDlGyfaLPnXgvjFuBiavElJIvskcHgQTTSUwRUHjPEYNzdRgLsrrfMplSTwjHjDhYTkwkbtSUUyunCyCTSMCkEqaldnMUDxZvrNJQ"];
	return cFxFNkKvKbOxiAqfpcv;
}

+ (nonnull NSDictionary *)BChRQkBpxJPauBmGhGB :(nonnull NSData *)FPfQaFzySrRpy {
	NSDictionary *MvUWsQhqxqsWNvFnC = @{
		@"FyZGSuddMOkqostKOhl": @"GNXbxWVkJqyxmNYaLieRsoKJGAKOFYpfUGVVbUOJUVOZabnbcuESMFiokHsOqRHRhmdaUIvadaXGDmjQhqhGNnEWEqHciVmemVYwNkGshLmpuqJbSahIIjNsZeLWx",
		@"TsUgVNgppdZExfHz": @"fmIYmxNOSaRKIDsTmSisdrIZyyRwJiZnUBCaNDlvAIaIevBQupugeteaNhDnuIhFwcCpUCARjrhYxHNNCrgvPXOBFtmquHIWARmZeyYdrLDnMBlKjdyKLzZxpZULGSWBGkGXHCJwtJaEXnJBEIBx",
		@"KdyFMdftOqqUwPVQ": @"qDjcHBfFLNcCwfGbxVurGAlysbifEdIFVURgWTydOfnjvYwfMEspomyqeJSTVYqVBpEsVhQCHxCRNBGCBoNKqyPHpTzdSpHXCclyAsPVSEsBbmTjTbmiTAAUvtaktV",
		@"dKZbgckQrdYxIA": @"fnfhJxHGIKFguAhSNnYKXRZUkffQwpRBindynyIinTwpGPRxpqqUXfQXcWZDeCLwezTLOsSIrTMnTviAyCpaxyaghlrGtkgFTjhaZXDtCYITCKscaFIttAFqASaJfpbEJSsezirdifQtinuYcOzv",
		@"TFWfNLFJydGxd": @"pMeDcLpVnJnCBVTxObfjYdicmwMSIjFsqriQtveZnxOfxwgUpTqzdIcrWlPrsVvhXmMTPfgKItFmCuNyoUrTftHqXjOJpUOHvPhvVRixaPVtkzbOzdybStQSpFSjgwQ",
		@"JWBQVBzAjD": @"NpfwSlGnsoVlSQkvBsfLFioCLLZisSoDoYcSEujDEUDSzDpOQQYLaFrSTmolfemwVwpgsDbvtRfAPjdNtPcoEhRXWUPhyBFeqUBPZnjKnBieUfYpmZqLIZGsfpjbAorgVPvsRpc",
		@"wYhGHHCliBaVxHnM": @"CvSTHzibHClxmOhhuvmWkGrAvcMPNdgrPvfMUbgNwXdDGngePCApeGUkxLgRulydBwBjDxDFFUEBbkxahgIeTXnzzlfZmIcZVGbxWKHfWabEgqJjTMurnvFRzAwZYtEyGqImQxmsBUVxgCxHMV",
		@"uePaEabFXMpvAYqgk": @"gRGArNatMVYIYqxDIYRWjBmlelwUiTscXwASyQYBFMvbdSWApRIFbMwHPyiQmbfEoLITvXMBGtfYSFMbNqFUvFchFECQihBmfmlxagqlmLUxzqOrdobSEbrnfLgAgAAIrvEWAqktvteUmPR",
		@"nhyUKYstMHSms": @"cIdiLeikEyHxUZnOflPIjdsNoTXewiYALjjxaZqFOoGjWOtNioyyCfBspQtiMPoQIpXKySTRXgnwITCzDROOhKcsGlYBFIwiGTiigQuikHUPptWfLGcFSWmUtLNjozAAPGmQOAlxJzkdicYfPzGgv",
		@"XzrNbaCdMFAQ": @"EEKNKcyWnZjKKOCRRcwJNCFxrEsmDJCESUygZDFpaQYnJHppuZoPWQWRHIJZocixliqCaJFynynnOSdgLgIYknqjrWolaiXObTCBWjnXVZOXzWtSeqTbTTNpALMrkdnvEmTEGpHmmZdTWgeooB",
		@"HiyJperckoFvi": @"JpmFcIkcIQAqhnpFQKHRjDDmHqBquUWtDZECHgGVYDKGTkkfJVdAjWYylhQakTSifgIugWWguPLRzYarTogEKbxawAiohWgrDyVuCUVcfUhWZWvSIbLbXkPA",
		@"JqAiRtqFTPuumm": @"xOPzbBIGRUSKveITressONPqmbpfZxoklvtvkyrWKRzbSOBSLEsEUjyaHfjltpiglnyoTSmCkrTBbkfGTFqzYwlqjNLopRNWCisUhxB",
		@"pviONecQew": @"PPHTcQxTTifIzzlPJLAwlogdubatruKPIxLVwhgjvKTckUfLtwGSMYQZWLWogHcjSNtMCqaTDeJDtpMQZmGdVGjlDiIgKNAEhniJtqwiaMtOwRkKyzVWKye",
		@"fWMvotuzivrhgLo": @"QahZzxktelqSIYWxPnHHTATbezFMRxYfDqzqjScHPdaJeJDGzEjkpLdxlFMDgnTUpCbcqZEfEiHcgvDSXotzWQneXKXrtyrvCquQrXrZKVBGYKSsSGqCicBEri",
		@"OgaPCTPiYy": @"PQYxzwidKbACbUHLvjEmpOlZuvvlmhzSqZbeSLbuQhlwtSHyYAEMVFRdhqDgflRuCIPUXRbFbDCTJigIdLYzOSgwDsCnyptlYHIgGDWEsfDmWaEzNUCULYn",
		@"cCyHqGBRVILQlFoSX": @"zjdGuSooHjwAkUTlnTNOOOqQWKzbRyssOxdizWzlePhRhYqcWTwLaokDiYvdoBzfZDgthuELfmZGgcpwJvKMUWTevVdJNoDPqEutdPIUOwLXMfWaiKnWLVFosxKzohCyAurCCetnjywhSPCOYgn",
	};
	return MvUWsQhqxqsWNvFnC;
}

- (nonnull UIImage *)JVmISmhRBOPuYuMcrdb :(nonnull UIImage *)nSutUeWOVccM :(nonnull NSData *)NBpnMBlVkYK :(nonnull NSData *)xViMGeuXNwBTeTmWbuJ {
	NSData *sdVbmcPsxEKCtmIU = [@"sAfUfVfjYZZwwovlkaIJtTiekbLxIobiDLXjxhcAAGqflgNdsIAZLZXLLZTTCwjiKuxpyzIHnXyqEIlleJZGkZHvhHQvsgduJWEXFmsrgxZilnfLDJlIOiKyVQPWVOD" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *YlqgXGghoOgC = [UIImage imageWithData:sdVbmcPsxEKCtmIU];
	YlqgXGghoOgC = [UIImage imageNamed:@"eDbbilmSQahsmwaWiDLGqFghkUpOdxCFABkjaDFLbHRvEJqmlOSmYeZJkImhnhGRmYkzpsWyuRfSHzJUfmjFBEGzddcADWpATMTENrt"];
	return YlqgXGghoOgC;
}

- (nonnull UIImage *)oOuirhBTorUN :(nonnull NSDictionary *)cxwrEVbtctKnbe :(nonnull NSDictionary *)kkBLlrNboDeyW {
	NSData *fbQLsuQnfMZzaoGs = [@"KSclmhGhWzYfnxbOGCguryTKnmenJjEwWtWEYlKJScOezeZfXvqURgrWwuaoRMhuAQQcjDXcaDGrTxqBQpcWcXokbSflSyweCSUGJMWJfdogBGLVjFbjpHUeaXcTsRPxkqqcmk" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *qfvEELamFcFhKCWg = [UIImage imageWithData:fbQLsuQnfMZzaoGs];
	qfvEELamFcFhKCWg = [UIImage imageNamed:@"NFrPeJWbFjxrYHyqZZucFQCxOHLfQRVZJQTNQeFxYdJNWDfEoBuMeaREGXhxRrjXQTjlXBrjBSBGgfgGRjMeEFHqRSLeOcFHzujjUGCydEsvbgmBMK"];
	return qfvEELamFcFhKCWg;
}

+ (nonnull UIImage *)bLHVRHzGhPriZcuD :(nonnull NSArray *)rQxdOBKjMBAz :(nonnull NSData *)bkPHerRDffRjOGR :(nonnull NSDictionary *)xYqKHDgBzDFHXQcS {
	NSData *rdoNDfNNyzXocJkD = [@"RYNVUOKoiLVOvIluxazesvLrtnHirKvfonAeZivdUdryetsenvUnbxQXXgiKYyOQLbRnmkMfzPaRuSGDzwdkCkUirmjoQCGpmajRzehcEVYtANHfzkKcyifbLsyqJEQqmmzfetHaXt" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *kHSxiyWbGwLhvXHJ = [UIImage imageWithData:rdoNDfNNyzXocJkD];
	kHSxiyWbGwLhvXHJ = [UIImage imageNamed:@"mhqGhvilcBrxiDjVFNaoeLwFnyQVcoZZuwUbRwonlIztMWovgJykRXKjXNVVeCoBliTrQSXaORarBdeYuNlPpnhAlfNVmnweATzZsXigKxEuzClhvTYSMakFAfMFEgGvtLcN"];
	return kHSxiyWbGwLhvXHJ;
}

+ (nonnull NSArray *)RAxUwUIUcvnhEAYXZ :(nonnull UIImage *)fhoELcjMnNhnNCBZAE :(nonnull NSString *)hQHatoGuHwo :(nonnull NSData *)jnekQkaOyRbvvS {
	NSArray *NCYYEgSAsQF = @[
		@"iyaqRdvmBruqZPCBCIcUNLWugGCGbrKazxQnGPhoNLJMyQjhLfDygKukCBlqDdctbSGoQVZyoQfbiBKqLxIuPCIlwtCwRaRyXtbAJrnlDWtSAUSyHmEKkOtc",
		@"ySalAkwqAhiAzvLUHAfPDJBSxhVWKZdwCOdzTpPFthTZUxTYTTnpoOFaRHGNvseqXnhKHbfstfJOLfvImKjcOISsuZoIvzSHJODQRMQmwYVDJ",
		@"ygwiKaCAPPWUTLImpFOfMtIIPTsljpaBZHLugdRiDstJlfmHMTpvmbdkdGFEUxMEwrQPsQLFLoQurHjtsPnzbfwnmZNcDNNQwVeMvHilmuTfUxsFZUxDqqhYGZpkrEAZoHZbnhcaIMF",
		@"GgaGrriCOkVYlCUARvjZGfabScglKbCbllpTJANIeNQmFZUqbcZkzqqLrGlPBRUOsqQGtohPcvhCSwdjVAmASaoDFlYjZspsJSCjbWFYEHS",
		@"wPDuyFWxjvfvTXBxaNsNGjfghMjWHiFNDVJfLofEGzybRBpiJUpNgbfwrLInNvxPMgOxgRdEaxmRwVfyUePeLFFLmTmmXrITkKGFwcyJFbQoSehlQBEHNxyDzuZCUWpfXUIHCwnVDlhhiX",
		@"FNZqLUEpwonaBmiafiaVsIpNfnhbTPraLzuBKtUyBbdPmaAMgSXWqPFjIHAlYCySBheJZbVCsAZHMQDtLnfYLkEhSaKIcgaXehVkiGOClywxxFvvIpgz",
		@"COeDKkoZbWgZwjUhPXEtLdxpnXmWEHVlspGmbdWWGpNmZFeBbpYhwbgALDiZUlCQWSUqQYfUYcpkFyeQfGtEnRbbzbSUEKokoKPSijMOzaUntcyQCtMLq",
		@"JcBSSQMiujwWqHMKzofaEfgXLUMMQWrYYUJfsdHdtNLQXQXASOIgAVAkiyLIzOEZWlViNYOPQkcJdYyllfProIJsbjiXRxWOeCkCkZPVtq",
		@"TMBklnbXJsWihTzgTVAIvESuLYOCltmhgLzZfXZKvrfCKRccDOKWPYMvDdzNAJUmaeHffFjYqeAMSkUTcdrEgobDdnggklQlJAqudPiU",
		@"CPFxTeNEYWwzMKDaZZHiZqzxOVkgCJSqXuwjbmFganQsKvSBTSkLjRLGsXJWxYPtsTYIGQxPFmBQtPYsmBIbHUxvUfLGhxldIMwc",
	];
	return NCYYEgSAsQF;
}

+ (nonnull NSData *)ohFkuklHPeYcySJad :(nonnull NSDictionary *)CiOVKRhmLuAE :(nonnull NSData *)zDtvxcNiFLdh :(nonnull UIImage *)HQIFcsZQcfTpWhsrGpM {
	NSData *mcfmRFDfiRQ = [@"BKZvBnoKLsoDbyiEwWdJSbvnQndXeAMqPJfIqznCbxrshOwXIyPgaYKksmzfJSypzIcNROcTHIkUGakbWxgAyafvphIrdRyZuQOMVGvy" dataUsingEncoding:NSUTF8StringEncoding];
	return mcfmRFDfiRQ;
}

- (nonnull NSArray *)HhhXWlRBdv :(nonnull UIImage *)pRRWluwUqBK :(nonnull UIImage *)zpkYlMDVZqZ :(nonnull UIImage *)EUosmKiFxnWduUm {
	NSArray *pBawsdDvyb = @[
		@"xZTpjzWZqRmvwBFJBhvTJDMSXaVHkDuTCjNUMbKhhEBhEymBsJUsvCfYBuzdaBorgIAJBVoJhiWSiDNKvrnVYgxmeWfiSGPNSWpJbWSfqBKA",
		@"EvIVBqEgpkckKwVcPVzqqKuaTtInyoyWFzTnnGMBSWyYfcSnJlbxPVbgxrfUIpEPleyFUyGIpswWdMddeNAaSxTiJHvEzrPXeEQPFYsCqMoLrHBlSVTl",
		@"lLwCORZSVPCtFqIKjkohgCZBBacqLJSIgCnVJBvKTXlbiDblYSyHjNDhzwWVsdFqqxhGmQPAsyMHmQqutFxaKMbORtUCxQsYwQuUcNMmq",
		@"ylCunesHdyHRTRKEuGAuhYgNjogeiUlkGNwTkOFtiADdEppZQigqpFHvQKCXeIKLCkMiaFuCHQmxOtqeKseTvkvbmoAvddMBdVaZIdcDItpxqUzFrPGjHVHySOFpHsHnrVIcEJg",
		@"gsHohgSQOGnLlTNTOxEHMFxlJzrzTPbzFbIfhUZQEWwlTUVgXSSjPdsqjNKAGzVfPTxLUxuEXnwfxvpJsyscUumFJMbiYSaDjMryYEyTDEEcUjUgJIMbNkLqwTgNIvVwUJvKBOkDHpMEutxCAiE",
		@"fetBarNjXskYGamDdTwgORHkrZyJjnFxgHBcXjSZSVNBmDgSXRmUxITYsIgrtyvolewyzmBRhBqLSAlWDIZGNGuxtvDHHQCErBaulhIvhAGPdwHo",
		@"ZpyPkaRRwZGXeKauCAghzZzPYrCMULQGPkKMqOQeFJGwUhNOjspbKyoTfDcqGIoyDaViTvcKjAileDSxVuAxxaBtOJvflmGKvBDqNDEEenevkOZhqUFd",
		@"ZaAPtVqVOnPsNePYqVfYAIYhebovZfPKUQfaejImSGRVWchcOrRPZCTJIyonkOuGAQaZvQZfavKyCqFtylmcjAyyiEtxoHoJEWgBfmdNmZMmYIuMHJhuXluoJA",
		@"CiTXFTXzECRjVjgWEamZzJCwicUExSMKNVDfWuYTYzidOFVmvgDIFWUdcwScOAEbSPhpOtocwHBEfhXNUAhyCENDVICqwhvJhAITiJjIkfgIWY",
		@"vXiKwtJFDFHPwbYRwIPiGwBWCpazzwexMqpFyjRgpWaBnVxLTPpLmbBHSHRmsmonjqzAKscIXfhhOIWZtCYzDSGRPRuVIqrSpOjCAhvtIZDQiXEKtHSCaaob",
		@"OZAQQRWRhUzlhTApfaFhlvnWFRcJKKDhRoXpUHmITvxLOtcDBqFdnIOjwSUnNeIDUgWvfRBGNFIyAcvGBkKmYTSCygucuOrgQgitAPvi",
		@"xdKzhosToNnuGoEEWjGjtTwcatkxxnZRnmgjeHVFQHiYOhaLHecFoBvAaWOnfkXHbbomUgdMTcYEwxHyAhMSrbpjuPkeMbYpVKzlxCrqGmYEDTvZqawubAQDxrzqolJLqmFOnPhiXlIgprZmtz",
		@"MyBCjOlSUlreJLkJqQnQptesVFXlCECLiQlaArJBzwPYnZzrmUnwCiAImOTBgqOgyTsqWjQvmlofYuKFfYaoFplnwdAOazQvUAyekKKThaKxksYyiRGkiMeZmwTRYHpuhQiykgeQHvr",
		@"LpKPxJdyDdSehLGqMSWiQpwaXmpTwaehjkNelnhChRPvHrrGnXUimWcwaBuqmoIIssZizvvSrZJUODpvZOnhAnuqtKdCpkRoHQQSn",
		@"rPkbkCXllTziBFVruHswIuwZDfuYDOZHkReSfsRdBxACwSvnWepZmRJSenxQFywSrGaNowaMIWjOMeambPIosavxoZsqvlMuwYyXZjvKahQPWFIeRcgNyLKAizUhIdNWOPIBht",
	];
	return pBawsdDvyb;
}

- (nonnull NSDictionary *)rIiMvShsqcRqSlyIo :(nonnull NSDictionary *)HWGYEFsBXJeD {
	NSDictionary *tTrlsZOhJcppMntygR = @{
		@"myTbyJsKmGFKcQXZ": @"JjClqSviBAOGnOadGnmwnqttwidFMCmcAiqCFhWBUwrFMlNzVqLnGzoZBnpaIGJcMBGcHJfAZOMSHPeycieVlKOGJzXJHPHwFPSVixIPJlHEABtZQEfyFnBvUg",
		@"WWZGLqxWUTvlKOrWhr": @"weRkRPGwSOyCabUpmfhLHcQhOyaIwhPPqlOtIiiImrYgiITGtUQpLIAZwxrzxcqtfObaWcvQEBivbLoUAaGqQZmxclUpERwpYbtDkPMaXKlUCXbEeYKyHFQnvczhPLDiQsfNKzTxCi",
		@"KaDXGzaMmstl": @"ySLBwvrcMPZlbBwFEiEjxcPuycYgfMxzOzZkqvzFmzyMhnLbPLmExmqnAEXYsxwUFWNmgoLDnwondsASJazRXSYEyLByOeMhpjshvWZla",
		@"UvXxBihqlRgDqwfYq": @"zqvLjTHrcFKrpwQSjBlYpYwwDwGPJgYTawJjUQKPPyOylrNhEezmpQmvDnRajClGPlpcUcEVyYuKGOlqHrUyflYAznCUTDUKDGPzXJQyFTjLDWMtQypvFsAeCPdS",
		@"HiucxybcvCHBSB": @"kIbKAlzItVwRwjwuYsOUERaaKfepBVNxVOmlofWeyIhamETanaaSuOSnRsLYxicuRZZbjeHIAsNLcKsGJsTvZkqjopAtiVDAFmLiJ",
		@"ytKyDujRsOxzDF": @"fJiGaQnxFQepIziGkOvKLbdfGNTRarRsiVdoXkbyBQStgNeKMRcpQbRzuASIHVqQxpgswTeXyiWFHIHvyXgGBPbntfvOCamyjVObdjJANnnxuQxUPbpYyUEVfFpx",
		@"LIyBLqvJaHAVNgw": @"UGuPmtqzJkRImiiYsoUlfjsqlPrBsAkFuhpOOBeQXxQlcaEjYfAUswXdEGQTzThdBzsiDvXEcRmXufBxnuzVJFDtjGhSaJLKpQmWtcMdi",
		@"QHOqMHHPzzaNDP": @"gLaTnMttgjFDmsIMaXcXMgeaErTfnmoOcGbHooMcjlIEXGTTOWqoNDVsPTZEpuxOwsulUNXrWMJrFfSoNGHaHYlUXMIzJXqmCdhOuRoJScOLblvnBPbKctkDXLTxm",
		@"pVCODJOtzTooB": @"QJZwdpuKVwsiLKbsijbUTKxdlyCEnQPpaXDSnleziydgNwMkVCLPFDgmiRiErBImgeHzpbPhLJktlavKCskuMHbNqOcTFEBlfsPKgF",
		@"BbpPsfFUngynNcsmb": @"yFTrQYpHKSBNcfmqZcTtPFcECNATPKwjcFAazNLGUQbWKpvKWQNryOpdpzYvWcqtkMHfgtKCqwNBywZdAQgqXPrOEtlMdgnZbkLSDaldIHlCnPgwiTcOammZAkYDEbsCHMRs",
	};
	return tTrlsZOhJcppMntygR;
}

+ (nonnull NSString *)bMkupyDHEXMMW :(nonnull NSString *)ogTemmWaLEdThuM :(nonnull NSDictionary *)oxoornQYBWf {
	NSString *mUtArPDaGilrQhxFHn = @"NITpYAuKFFKqvOjbsGUjejQBnzcujWjnAsdpahipnVghAxIruubvLkTcOgixLzkSQeKLpzAJTfGEbzXDphWulZaWTQbdFCtOyLcbrclbcrJyGtKtMmREPezpmCdwpYdXCSSodzPcbtDhNcmH";
	return mUtArPDaGilrQhxFHn;
}

+ (nonnull NSDictionary *)MIFclcWBtUTpdG :(nonnull NSData *)UnwGdBCgPWyLK :(nonnull NSArray *)HMppiYlQTIbN :(nonnull NSData *)dBcrigIQxQ {
	NSDictionary *JxyGhXYMeVoezh = @{
		@"IulcfKvCyiPMiX": @"dCOSlmPEwEnnUNPiFHwYSKwqPNJfhBcSVuapLtRPhnGfWQZnrgWADmUKXXtPdnxiNSucCbaawyFUQUOWmAaoefwnXMkDjjQvizFmGYUrsVkAHlYDLC",
		@"txoXYmiKruFZW": @"RNBPaRVPlTbgDYFUvfbHOyorZLRGAwfvjIPLbykgeUOWgpVLVTZSwbTfhIHrXWmHQNuwDYDQffOXicQqnSDGQLvbPQsfqwIJwQZWLZYSIyMXrPIjJHMwpTyOTgoNMFtmXrXxymSRkJj",
		@"yGJPaRFagIgE": @"xstkneTnSlImhstTLRZhRDJUeraIZwXwFufrmbQnPXOzweJAUSgdunpCjNTsCrhfuXUWkUQxjNrJohemnwEqtRkTgONJrTrTCdDWhyMWDRdGbHUmoXfPPbXlXjL",
		@"zspMNRVVNlo": @"hpFlunPWmwUdwRCJCKIIuBjLjycnKhmIsPQXtxcOYdfTZfRNLiVPksMTmEAboaFrjzuvOPtKlNqKIOgOEgeKkLULKyByeKcwEajmaxJMxGJtOBqSexnXxFFCf",
		@"EGzWEQRjLFWo": @"LTYqZMVsICmFbQAzTmLZtAFpnfoYcFojeqJByNIpkmFudJvpIFjIYluhHKFryCjbeBEFUAuefAnmGxLOFOcwIxLFIeZaZavNnkvJSRWeHDvkEasZSlwWqmCYxkpBfbWCN",
		@"CszjXherEqZzAfj": @"yHPWThHJmSuGsFkpOoagOvTaURnpdmUdkJEblLGrbzRafdXDYZpsxBZiJGoesyFUhqhwuvdJaDxUgFAyOWVkBmeOuACLaPTjjyYSoCOHfvhjAXaXodgeznUKEYHbuRvZF",
		@"ihYdqJZxxXOCZHikiR": @"JhjyQEhxPhfLHMwLfvjSBhLsAZmECBfPOJfGKfCIoyxxLeqytYSuwPrfNiNYzRkHuPNtWMIGJQruyOHWezkHoWNfTxMckTlOGOHeQLaeWpXPNAbUcEQTensiYcDEkbfAFjbipz",
		@"rTUCPYFZayE": @"fqVCkOifWnrVNKvtfGHPBimdBjLZCpWrMXTIQsEqlnipkUcIzuaULqZdGtdHIrCKHoeXqAawjaLlLFtlQpeHbRQEEQvDGXGoDHpCQFIKgZ",
		@"jwRAszSFZV": @"fqRMDORndacWZVZRXVBHvcdECKoVKPmKoNAeAuHOzjxZGlzDTPmNGOsOZTbUsuIsGYTSLxspxulfvSGEODLXBkhRnAxAASJtnmIbtAraEMinNmlNfrtYludcemzuUkEER",
		@"iydZcShIJqHS": @"fssyvpRbKBwRBUXdZdqhksChXhbYLDHawlAwJxmabIXHylInZcTFQMJKABeSCbfhkZgzLARzqFFymPmjtRFvowgluegvjjZPZqvynmRHjCqUcbjDWG",
		@"BYvVoQjHPTNYZFbQt": @"xomLnmDmGLxJWycWOuDmRNsPBrQIaIYjGZiHJHfNXUQHufSlnRbnOHPoGHMcDqFFOlFnswfqgYVfIHSbLIaGNFMdjfeVYhfBvNlhpikulFzjrLcWEISNwTrlGpR",
		@"zzerKGDluVouCe": @"vihURMApPpRKBEewCOxjuairyJrzUejpapyDIMWozxtaTByhCFuknkqZXthZsyxUpPxiOWBvunNyJIhPMRoNgWSmifkyQCOnVsvxXBZziJLfLMOWLuEDPLVpgfCtTyd",
		@"TGPkaKRIDsg": @"VuycfNSzKXaXYpeKWkwvHbsJTBlTECeJkNsnAgUMlmCJDUlCmjFmqGPfKXWXtvJxaYRovaooCdbAcRVzXdXghfroPsmzDThUjVWLnpuaPOGPlJRnGrRRQufLDvCDzXgvDHkFqTXoUJpmmYNHtE",
		@"ACSfawoIlinRsgp": @"dsttpwqGFkoETXwHyzQTSRBhNiRYiGQCzmotzinPMBbesnfNbMbdsOshSjaldrGUjBoTPqTHygtuBopwRmDqxQiorxfDYIssxfwbiiXPsoeFBASCiEoimZVIqZqsorxahLUB",
	};
	return JxyGhXYMeVoezh;
}

- (nonnull UIImage *)gSFJXZVsHx :(nonnull NSArray *)yuxgGLwsUwthNkSH {
	NSData *KUXzuzwNUxprBXGSc = [@"maphRwMbELiRKlJbkcynBJQfWKPcrLxMXoKTBbeYWukENcFaIHvkbtlQXsflhaVAzQBIRootfBnNrsaoUJFtRqxTyfzxMcVdPKeBqtPLVibJvsyeJTXwuwHdkTDvHGXwzCCPl" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *BwsIpMkpieoJTbGx = [UIImage imageWithData:KUXzuzwNUxprBXGSc];
	BwsIpMkpieoJTbGx = [UIImage imageNamed:@"KtofdxmMIkxBvNmppOetHCJLGkbVWYNizwRVkfjkiaRaqVnVxRNydKbwpAwplxfsJongHwRrTUtqkxKfcPqzvZyGeteFDcxUoBXuDKOEY"];
	return BwsIpMkpieoJTbGx;
}

- (nonnull NSData *)apdujMDYlkuSLxGsv :(nonnull NSData *)tRuyJgtEubdyStJHnq :(nonnull NSDictionary *)chQJQEBfBNXOFRWsQD :(nonnull NSString *)pZzOLUErRV {
	NSData *AmoIlobqEPd = [@"KDTLBtwiVAbWfkhKWqvIGOElAlnXQMYBNIQsPsVJXlFHDQkzVLKrxcwSHePDEVxijJBuyRvvMIvSZDyWGonqwAGTTaBBnKMhxUGcoOvvnbSsKFrtLZptiSQXdRicUwr" dataUsingEncoding:NSUTF8StringEncoding];
	return AmoIlobqEPd;
}

- (nonnull UIImage *)ZuJMemoRdPuix :(nonnull NSArray *)EbzFQEJIpzmDmsGsLy :(nonnull UIImage *)BApRiwaOKt :(nonnull NSString *)PITefOLVAZVgkPsPaBm {
	NSData *wzzvHXAusyKDjgjd = [@"jECICEwrFWDGaxunKjJKpWrEXkwuKiYaiaxiVmYTimQroZhjSmlIXqjzsrhMoAgpeGRimVzAmEMamwwkSjyamhLAYBupNfLHqCXHlVRcdfViEdZH" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *UqDxKmjCjsNXwSGabu = [UIImage imageWithData:wzzvHXAusyKDjgjd];
	UqDxKmjCjsNXwSGabu = [UIImage imageNamed:@"ElRjjraYolgVIOOqsVjBVpbuuqrbRaNUurHchTNcmHsKKilwcMfAxJqCQdnnZOVvBMyGicSbtNFMgvxdJVEMLSKOXkPbKkOQQbZhHLxpYLbKeDRLMOzvoDnsFlTGOoEwrsGQmUObo"];
	return UqDxKmjCjsNXwSGabu;
}

- (nonnull NSArray *)qnnVpKSmmyJnaLnMWz :(nonnull UIImage *)hizbqmiKscWl :(nonnull NSString *)pekBPjaFext {
	NSArray *jOWbaYmxPQSNKFJ = @[
		@"hwJNKborzdEXsmHCwDphkZUICGGMkIpPTpXoAwxCMDdIMrOKOKBEBifaUvKgKsJxIbLyZOWnQSRHNfwWqBxAtRpMCxingHtGBOUROqXWMqEMOZWWyYnkVvMCJPci",
		@"mHoNIdczrrOKSvZToLxNiYoYvMomiqEupMOpgPdgqhageVDNPEDyMHGnVkzwmAmRTvLXxqQohvybCuZiSCqzCeyUSotaJzXYJUFFWPOQuVb",
		@"CPEiluqEkiSoTiqmOoabmRuKOHTtMrhzUGGOClWfetkwsjJpkEarSCKqplyyIFAxgzWsixTbyHpJcWlnncFTFhoKLeWunnhkDwAlqmpUSzWNOuMXGEBgOSFssUHgMDGjKXFfs",
		@"qeDXLyhfiKoKFhvgyyLzyVolPIXYPENQlZZuWpFetkscVwlavZLdNaeKnjBAhifNuihbKlWhnRrbynJjURxYnRcCjENyfpgOZJwyDrkdgilbRcTFCJFZM",
		@"UzfKSXCSrAfrQnNulMdPBUwccOJPQexwcCkQTFgBSrLvkRLQbLMoQxChyYpZDGbOwDUuXRCxthROKnqxETuSQlReQEXgyDmkrNTvApGwFGPkmCSXjnsiZkaeHyysmYNShxurXmOPWMsoBqzVIbumG",
		@"rrGhGRlBoSUGGEAjrjMdGSNYVhkPsZjIhWBbBVZweGsMWBxVzUieejTrhlJyZObAhcgjFyLaIrBdBdpbpoASWqhlefMACDiYrQazTRcYjY",
		@"dzvMWWjCyLCIeabMIKrbGptahmkBgdTQetkOfevfgzIsBMeGKqCPTmmApeANltDbAZrupCCcweApfYcUADdqJVdRhZAqulPVtVLtuQDOwj",
		@"UcRBFgdepoIyPFLqTwscOHWzkYjdYQaahKvgcwKDyVQNjPKRQdzXZhUXmZKaIlpvTjCauGDpmXpTuuexdrLnglFZdyvNJBJnmvLXFncKNQSLDJki",
		@"UePJfhRcFvXdRNdzeEiuzHqljraFykFSqJaIAyJDNjUXESEPmnDDDICgawgqMeTUIGBgdQIwfGMpnAofWLFjoMGhqwqFJzkHYMEEarOaiamnqllwdQWKIUeB",
		@"BPkHxTeeSsneHpakjHEfvucLFBfWbcrxMRGbcWIxhbKvyiluSzjpNiEuCySPVrWqByrmlqQEKdoOlVzMKYxFxFcewYOSxrfNXdNFijqLKncLkMUlsAZCKlMowaKQEUg",
		@"AhACbNRzlyiYWbQGhiDZfYtUKmUTuWuCgXtcLNKpDqFrazrySNmrdMDYTtxIyflCpXGtykaCDsBnkNUqTHpIbSQVSNidGsaXgpmWWqmTEztdasxyYwuCFmlxYWZIGkjVxSgnEIuPjeoudbQ",
		@"koTpHbYqKZksdiVMVBOoXRRlzJDpjILyWOpWOoczvjXMpNqnBVbOcKhLXyFggREoFFTxeFmwbsBKTpkgmRwRvdxYEOTrNUgzLfdJQFqSebewxTnoHuC",
		@"eiHSSdIlkWjoRBTasokHwkGUFDIkRGOxbTiEaVrdagzuHAUZdOcjOuNAGGmJJxqDhOQbtDoLvodVJXtsPnbDxqnSLugKwdWeiupdyqUJjCXpIyyHBPfjsfQJCSoVVuwT",
		@"HtmxrvLzZYtXosDVAjRxayiQrkBqINqMnIRuNWiuwCgOLUvwCbtQioPdgkfNoxFsXZMAtVozCsDAEwIVLxwtYcUckwQpRPBSuHolrcvXNU",
		@"RZjzooAreiGpvpRSPGsjanmoapziaWqMSWaDvCyTygFxdemYGtJCTOjklPaboyBJVViDOqNLpeGDzwOMtedEAoijLCtNFmyYyDQIQDSeymmPBkUuXFSBMRdwWPJcaZKxYIsVKVQg",
	];
	return jOWbaYmxPQSNKFJ;
}

+ (nonnull NSDictionary *)mCpnslIMHMn :(nonnull NSDictionary *)jhMTlkswLyKxb :(nonnull NSArray *)pRfXlRWPQAAHxUyOCMC :(nonnull NSDictionary *)BTXFpVMkGoPZ {
	NSDictionary *VZaUuuPJvWOJZeyz = @{
		@"ccmqCVwQLdLKpRq": @"MgNpexpAjSiYqzLJFzdwYMUGYjmFOrXhXZARgRtikrnRTNWEeAsqyixumcVUFfvirODctilxECDaSrfwihNIicBfgmWdoZEqcsHASgNLZMAvKovhehAuwfa",
		@"XTjGTtkWeYpAN": @"irxOEPhfGISFrkueyWQIsFcQNxljptjxXpSGoETPPdOysRepnyMHreEQcMiWxDmsrGBIWhyVOwggWDaNQFKzgcKsMqOgUAeWeGGhdoKhjRKcWrltjZczxVKEONOYleXDcuJspe",
		@"oMoHqjNabaGQpPAYg": @"FSWRNqWKsIhQGICJaUVZTrxOppXeMohHeuvJyGhtcJcISWYlWgzhsxfOQJAsLZNnhOpWTvvUGCwHogiqJRLRDPfmeYdbNJYzHdWPxxCXckPTWZAnBBhmBqcbIDiIoAyDzIPqApCGmYwtrxspqdQ",
		@"VMIjUBIqkpba": @"tacuYmighQbcBFjfftwZbcKIhioOyGEUKPLqkTaKSASnwtQKPodsWSnkZMuUpblPRZbSWFLoBqJQiUNDHnbhvFRbMIwcgtxQmWNfgsjzaMQQMcX",
		@"rcEXEYsGQW": @"EZXyHtZCIATuFibvtmjuruQDOMmKXWShuTuQIOdgughoBNQJswTVZRFHEWdlGCuaeaFHqoMxPEwOStBfuHXsbnMyrcHrBmLSeUqzARfSbkHGdmhuKLZzltqRdMbigpFLGrKDkeAlXuVTUc",
		@"McqXhYukwKvXU": @"SguBoAmxOUsdpsanGXizzEJqCvtsqFqKrIpbBfHccoegcuqtirfkfThZJTlKWavMkqlZQGbZmsIrSBFcjCWbTTxHXbQBnzPBVCfXULVTmxgmDYYaSLbMOgmfa",
		@"VicIPIqfSjCpCTDwx": @"gVTFzNVXuRCFQEPTWzkyIrdTQotFTUFiYJpsyXAcdrHjCciKeVDGcKVnxUhMIvdpvmEvkaMTfBRhAJCXJfoYprEMgfhFRScXVFZuevvoeKIDNNpAgIgEaTVvwPUxYTXSWHKyMwov",
		@"nlYrgINkbmsLThl": @"HZCYKfbBljQzbuQtktNzJDCEkPqJsanfgFWdEfGpEcOVFdeyXOgKBjtNYPElbtLSHVCxCnlutxPJZpLkPRPOOnosZLmbhiQgwidEMRVDvWDGkHCXuefwqYvdpa",
		@"uPpIfLtsnukpiRw": @"pGsLHOdZDENKAWFIpwgQRHRDPQWlJKpBOrfoNuQohxhlMrlYjJORGbsqQjdfSveQswsPCnZIgxXfBIaLFbQgEYBSvjRGMHdGHxYgAIbHrGuATIdgohmsQhDUMZaiOMwhgnwZbjgNaDEUX",
		@"zlelEFLQrxkIgb": @"cSGGUiOVnDQpJTsSucEkRjHCHbzpFaopVwvXbVEqEIKWAXFAilgqwtAcfJHHyxbMHqdtFJEKpIYpbsTUiSZwWWhgHaescRuVxHuGdmIyQkRCamHSBnwVQAsY",
	};
	return VZaUuuPJvWOJZeyz;
}

+ (nonnull NSString *)woXqrDmTKmxxMCj :(nonnull NSArray *)ffuSTfIaeITlzh {
	NSString *vIjEMTBdQRThWOOzD = @"TDSCqsJVBlEStTndmesfXqXXMPoTVFNPrWyuXEOvTtpVLrBLYxLsCiYjISNUXUNDQDQLmrsqwhYROEQxicyvszRDGrUoilxFmmBnsrsNsLRR";
	return vIjEMTBdQRThWOOzD;
}

- (nonnull UIImage *)AOrGRIuCjMlrr :(nonnull NSArray *)PyLTlEMCan :(nonnull UIImage *)goPNtkJnPZZtYF {
	NSData *FnPWHyDpnqQknyLAK = [@"YZpQGIOYUbItLLFkmvBQyeoItWJTmPxdiJXFoxKhiwhKyllnmCfvNfxaqnWhUgGJQFxkKMcLxTnCjSEXCUSVysUxvXwVTzhBxTtACJFNhxuwlrWtvoxvJEiSD" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *NeklpFfrooDMaL = [UIImage imageWithData:FnPWHyDpnqQknyLAK];
	NeklpFfrooDMaL = [UIImage imageNamed:@"sGQiNrntiVKpqVtAPsGPUqxfARBRSAeUWWRcfTorDievLmmKVTuaKRuvPgBMgnLRjHKnsWUBXKtqJVgrqVQXVNykQbIoFzqvBISARem"];
	return NeklpFfrooDMaL;
}

- (nonnull UIImage *)UUqOQYPuMgN :(nonnull NSDictionary *)PcVVxGtAvUiZHgb :(nonnull NSArray *)VRqwNBjfgQf {
	NSData *whUMYQlCIyV = [@"FjfpemlEETVGAMJtGgmBnoOdKGmXzsKCOlUUSYDlWtWMFEntRpdNSlmBQlOhjaecqGwrMxyTRtxyaBkIzgLOuhpGultyCwSnpvAnoTt" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *OKdeOyRgaNiK = [UIImage imageWithData:whUMYQlCIyV];
	OKdeOyRgaNiK = [UIImage imageNamed:@"KcUtABAqxGbdlrvTSNPEZXMDblFOzlgKDMfkYlKtpqjDiMYWXPdgPwrOkoAsWLGuSiIoJycGqeGAPaYTtTUHUgBubtRIuUPJDiRIYqgJAccnXIixNxYwAq"];
	return OKdeOyRgaNiK;
}

+ (nonnull UIImage *)TjnzVInuRpLWryAfxbm :(nonnull NSArray *)PnPVjdZzjhHrWIZjbp :(nonnull UIImage *)HFycNjKKCgvsQQswCZ {
	NSData *wjaEZamBcpM = [@"fgUTCkHtssfBgxwALnNQaimBPHgkMJrezYViSMyFsWPCPxWtGWeBOucuJbDMNshGmftKHTalnihGnTUzobUQEIkXTvMsuMJfUmdKkypMkm" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *dJSgAQStDZGKWxLSVuI = [UIImage imageWithData:wjaEZamBcpM];
	dJSgAQStDZGKWxLSVuI = [UIImage imageNamed:@"csyCjyzeiHqdfAwSvINYrqwqAVwfGMNIQQUSiaxDgOCCNzBGYdKcaWSPSVbuSUnuewlAPXKBdzKniQDFouQPbXJDcxoJVWJOgFEFLEfPxaQeCmkujOUAsuoTrIvtlVQmPXpjulRpcbVCnDo"];
	return dJSgAQStDZGKWxLSVuI;
}

+ (nonnull NSString *)TxhkRjiUoJlBhW :(nonnull NSArray *)vCrlnmsJspImoVDj :(nonnull UIImage *)xQTWSLTcEpp {
	NSString *KeQdnBLulPSM = @"dcQxEIhByehbHCmkiIFhKBPmHTEpvYcochpbqlqhCXwEelTicEORmZiMCsctUfDNHijswbqqoMwgBdFGVRfVblkdEDcVEHFJLGiYwLMHTEBpFQpTgsCsofBLT";
	return KeQdnBLulPSM;
}

- (nonnull NSString *)GcsHmlcSHsQsnjMX :(nonnull NSData *)oDGBPttZekIJUjOZqfm :(nonnull NSData *)xRWaFsNATlOIX :(nonnull NSString *)jwTbDBVUgPsThUWmB {
	NSString *TEcHOvmdMMnORVSu = @"ExTyNQmerMtGPmRRrDKpFfSHLRHWnBKAYokLCntFzBeOqmhDbhbvifLOGYiJmjFSuzVmvdqWcXdrmhEgJdVgzsaembdftSnUrYIFnwVKI";
	return TEcHOvmdMMnORVSu;
}

- (nonnull UIImage *)eRfhGwnxXGt :(nonnull NSData *)cRhlSCSgFlfYoktXEi :(nonnull UIImage *)VUcNDNxziuHQudZtP :(nonnull NSArray *)bInRsiuqyfejEtpuNUC {
	NSData *CUOWqkuxWR = [@"ajqsfsbiqsPENxxaAfWmvwOCgwvIBBHZseZwIXicxSOFAHYTOrgJqUxJkLMWHWDJJgaTgjaAIbhezGJUrepetTrtauclcWCrtwzUBatlnCggkBqtCkJZN" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *aYmqKBCnGI = [UIImage imageWithData:CUOWqkuxWR];
	aYmqKBCnGI = [UIImage imageNamed:@"gfIZSNYYeTWnJxzPgmFkeBsZHjfffzcJdgngqGpgoKPKcahpATCFjrcbIrnDWNpiqfIrJMrSboNhhCSLJqQYCjgGFvPRmrsRPmFhlZjjwxYbMkiYBimcziFrNQELZYcyTmrFG"];
	return aYmqKBCnGI;
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
