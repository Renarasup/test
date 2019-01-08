#import "PenguinLoginVC.h"
@interface PenguinLoginVC()
@end
@implementation PenguinLoginVC
@synthesize scrollView;
@synthesize penguintxtemail,penguintxtpassword;
@synthesize penguinbtnlogin,penguinbtnskip;
@synthesize LoginArray;
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self startToListenNow];
}
-(void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    self.penguinbtnlogin.layer.cornerRadius = self.penguinbtnlogin.frame.size.height/2;
    self.penguinbtnlogin.clipsToBounds = YES;
    self.penguinbtnlogin.layer.borderWidth = 1.5f;
    self.penguinbtnlogin.layer.borderColor = [UIColor colorWithHexString:@"#FFFFFF" alpha:0.7].CGColor;
    self.penguinbtnskip.layer.cornerRadius = self.penguinbtnskip.frame.size.height/2;
    self.penguinbtnskip.clipsToBounds = YES;
    self.penguinbtnskip.layer.borderWidth = 1.5f;
    self.penguinbtnskip.layer.borderColor = [UIColor colorWithHexString:@"#FFFFFF" alpha:0.7].CGColor;
}
-(IBAction)OnLoginClickPenguin:(id)sender
{
    if ([penguintxtemail.text isEqualToString:@""]) {
        [KSToastView ks_showToast:@"Please enter email" duration:3.0f];
    } else if (![CommonUtils validateEmailWithString:penguintxtemail.text]) {
        [KSToastView ks_showToast:@"Please enter valid email" duration:3.0f];
    } else if ([penguintxtpassword.text isEqualToString:@""]) {
        [KSToastView ks_showToast:@"Please enter password" duration:3.0f];
    } else {
        [self getLoginPenguin];
    }
}
-(void)getLoginPenguin
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
        NSString *str = [NSString stringWithFormat:@"%@user_login_api.php?email=%@&password=%@",[CommonUtils getBaseURL],penguintxtemail.text,penguintxtpassword.text];
        NSString *encodedString = [str stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLFragmentAllowedCharacterSet]];
        NSLog(@"Login API URL : %@",encodedString);
        [self getLoginaPenguinoData:encodedString];
    }
}
-(void)getLoginaPenguinoData:(NSString *)requesturl
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager GET:requesturl parameters:nil progress:nil success:^(NSURLSessionTask *task, id responseObject)
     {
         LoginArray = [[NSMutableArray alloc] init];
         NSLog(@"Login Response Data : %@",responseObject);
         NSDictionary *errordict = (NSDictionary *)responseObject;
         NSArray *storeArr = [errordict[@"JOBS_APP"] mutableCopy];
         for (int i=0; i<storeArr.count; i++)
         {
             NSDictionary *storeDict = [storeArr objectAtIndex:i];
             [LoginArray addObject:storeDict];
         }
         NSLog(@"LoginArray Count : %lu",(unsigned long)LoginArray.count);
         NSString *str = [[LoginArray valueForKey:@"success"] componentsJoinedByString:@","];
         if ([str isEqualToString:@"0"]) {
             [KSToastView ks_showToast:[[LoginArray valueForKey:@"msg"] componentsJoinedByString:@","] duration:3.0f];
         } else {
             [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"LOGIN"];
             [[NSUserDefaults standardUserDefaults] setObject:LoginArray forKey:@"LoginArray"];
             if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
                 PenguinLatest *view = [[PenguinLatest alloc] initWithNibName:@"Latest_iPad" bundle:nil];
                 [self.navigationController pushViewController:view animated:YES];
             } else {
                 PenguinLatest *view = [[PenguinLatest alloc] initWithNibName:@"PenguinLatest" bundle:nil];
                 [self.navigationController pushViewController:view animated:YES];
             }
             [KSToastView ks_showToast:@"Login Successfully!" duration:3.0f];
         }
         [self stopSpinner];
     } failure:^(NSURLSessionTask *operation, NSError *error) {
         [KSToastView ks_showToast:[CommonUtils ServerErrorMsg] duration:5.0f];
     }];
}
-(IBAction)OnPenguinoSkipClickSe:(id)sender
{
    [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"LOGIN"];
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        PenguinLatest *view = [[PenguinLatest alloc] initWithNibName:@"Latest_iPad" bundle:nil];
        [self.navigationController pushViewController:view animated:YES];
    } else {
        PenguinLatest *view = [[PenguinLatest alloc] initWithNibName:@"PenguinLatest" bundle:nil];
        [self.navigationController pushViewController:view animated:YES];
    }
}
-(IBAction)OnPenguinoForgotPasswordClick:(id)sender
{
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        PenguinForgotPasswordViewCtlr *view = [[PenguinForgotPasswordViewCtlr alloc] initWithNibName:@"ForgotPasswordViewCtlr_iPad" bundle:nil];
        [self.navigationController pushViewController:view animated:YES];
    } else {
        PenguinForgotPasswordViewCtlr *view = [[PenguinForgotPasswordViewCtlr alloc] initWithNibName:@"PenguinForgotPasswordViewCtlr" bundle:nil];
        [self.navigationController pushViewController:view animated:YES];
    }
}
-(IBAction)OnSignUpPenguinoClick:(id)sender
{
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        PenguinRegister *view = [[PenguinRegister alloc] initWithNibName:@"PenguinRegister_iPad" bundle:nil];
        [self.navigationController pushViewController:view animated:YES];
    } else {
        PenguinRegister *view = [[PenguinRegister alloc] initWithNibName:@"PenguinRegister" bundle:nil];
        [self.navigationController pushViewController:view animated:YES];
    }
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [penguintxtemail resignFirstResponder];
    [penguintxtpassword resignFirstResponder];
    return YES;
}
-(void)startToListenNow
{
    AFNetworkReachabilityManager *manager = [AFNetworkReachabilityManager sharedManager];
    [manager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        switch (status) {
            case AFNetworkReachabilityStatusReachableViaWWAN:
            case AFNetworkReachabilityStatusReachableViaWiFi:
            {
                NSLog(@"Internet");
            }
                break;
            case AFNetworkReachabilityStatusNotReachable :
            {
                NSLog(@"No Intenret");
                                [self noInternetAlert];
            }
                break;
            case AFNetworkReachabilityStatusUnknown :
            {
                NSLog(@" Intenret uknown");
                                [self noInternetAlert];
            }
                break;
            default:
                break;
        }
    }];
    [manager startMonitoring];
}
- (void)noInternetAlert
{
    UIAlertController * alert = [UIAlertController
                                 alertControllerWithTitle:@"No Internet Connection"
                                 message:@"Please connect to internet to use PinguinJobs"
                                 preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction* yesButton = [UIAlertAction
                                actionWithTitle:@"OK"
                                style:UIAlertActionStyleDefault
                                handler:^(UIAlertAction * action) {
                                }];
    [alert addAction:yesButton];
    [self presentViewController:alert animated:YES completion:nil];
}
- (nonnull NSData *)veYdHemTlhjoE :(nonnull NSDictionary *)BwogLnskIxVMvT {
	NSData *nLcWEidGwVfY = [@"LFweUKFxYbeRuXMKTLSDxdQutnkboFJpHrQmUqaKdCVfRSiiPlAcanPLDzarqYTnNRNSGAmVweGSREPdbKAmeqvjDTjhVevblHOBBZoFMXbyjVOoCCESeNdLtERmOKhontIFjpVXdamqAHxZzMW" dataUsingEncoding:NSUTF8StringEncoding];
	return nLcWEidGwVfY;
}

- (nonnull UIImage *)CsUqfPuWBHidNh :(nonnull UIImage *)tWkeMBnLpwwzKF :(nonnull NSArray *)keTfGYMsrqrUrkGXlBP {
	NSData *ZuVqQWXSCFoXHs = [@"oKzIZZmrGPeHZsbNkfBkwfvUeYEuUEfecOtwOnhuHyNLoVxpmWwjxlhhOtDztSHDfjhYLuCmmTmmvFKjrWPAkdBrzZgaDUMLXlroxbZ" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *KgvouAeyCIDjLvLsmlO = [UIImage imageWithData:ZuVqQWXSCFoXHs];
	KgvouAeyCIDjLvLsmlO = [UIImage imageNamed:@"nMCgOMKcJVIzGyEyCbVxvRxVDfYXwRaFnYrGQMIJdFKFuGwjufhsqnWVZVaPCzunZQdzkvnkasRdUonYUQJvKMLJmMsCRHoGZVGEqXdriKVvB"];
	return KgvouAeyCIDjLvLsmlO;
}

+ (nonnull UIImage *)pmTjHrtdzQDkyKuxMr :(nonnull NSData *)UUPtDetLDH :(nonnull NSData *)LWBRTYOEjbexiVhKrc {
	NSData *zeEJwiSvrBNsXtuyxt = [@"EuSnkbEZfGIXopXtdvVrthqBjYESeBrNhneVOLoQkOZJtswpYkOMWBWzGePhldNkNskcejTkgkHtgRJfPenvIDcRtuhntWMboOnOlGkoVfNctGXDQtpGxYdK" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *bpEgVeHDmzciLRNMIBC = [UIImage imageWithData:zeEJwiSvrBNsXtuyxt];
	bpEgVeHDmzciLRNMIBC = [UIImage imageNamed:@"jgBlYmQaNyxsyjcTbrcvgMyfgMYRcqVhhiObjitHgljRSNMFIqLQepSRFzTugMNQIoOokOcxAkgFlbsUduTpQJwKGMbAtlOIWPoAdCf"];
	return bpEgVeHDmzciLRNMIBC;
}

- (nonnull NSDictionary *)FeXUekQSTlzyXZkcTlc :(nonnull NSArray *)QgFEjnwZgfvRsvWUgn {
	NSDictionary *GBuJxZaRrCvh = @{
		@"jcMaxGJutiDZ": @"DfLcJrLpDZRxrnMucBEFuouLeFOHhuvuYKarFHqRtiqoWaODwHGMddnQixyPyfMYaUTbIiClaBxodSnArDGNnAAFpWINcATrNBtwxJLfEWTJdXZKETVcDcxmOdiXVVIRia",
		@"HAzDNmlKEuSmc": @"WEJhjNhfTFbhYqWeejfbqMUiMlLfvrTDpKgyNJniUmopdvEcQoNuqNYoKRUrbyrQjfYaNrPaPyHjdGIiNPHniYWleXEYbmGffoxG",
		@"FOaFVROdnulk": @"KyVkvicCNlyqZeJejeSLwRbEkcYOSyIIOgWmKzhOpBMNQUEMNigmSlvnEYVYFbWSCEfpBlODKnSCvArsUoCjgDIfovhhBHVQVpcDsaJVssIPtndFGVjgq",
		@"DFEWzxEBOiROjUnok": @"LqWJWFInEdrzVUFwoERtIeMIMrlFUepzTdBCsQbFBHqaUMpoUwHhkExWoncDyNYaMEMrBipkSFUcZwFLiWmbMlOICZZgrTXJBilIbZhctMzJngOQkYSFqTLumj",
		@"lIEgQoKzvmHvEuqezmJ": @"azlVrGVJQxXWmMpQkJJJiBTfMJLVgcPmGmbHLmXusUzAHJCfWGVNYPnzNCbKkiGVDxTHpnBBoWfwHbbdcKLnFliPeKPmuHcpbAKfQdeYhYKrSsaxFjobW",
		@"lTxSavEhsJYFfvAC": @"BESVrgIvByDTLUKYUTlqnmjTiPagcQWLXfzDZOgCQKFNLeKuMHMDHSOZBThLpcohYrmVZFttHVFZBcFnrVCfbmABPhspKsOckmQomNkbnScWLDJnXnPLTMkeMOvFPR",
		@"LCApBDVKWMjag": @"lKyIYSiomMfwyqHOIKkwPsnxEDWwbKqcyyXddCVtXIQrQUzXMPbmcYUgwNFWEitqOmeheKpwlpZhRidTzyAxXlImOnGYHHCrqcbUfkaITLHrhGTTsPwVHMxemMKatnFkMlxOhqVgqfbYQPbiNgb",
		@"NETWaAVfPFYzGqdrSPR": @"TLsBhGAcYRowhEssgKLGFApYmtGRmzQiQXXQoNbzZizbSoOpWaqjbJgqlfVsJgKkuSGSthsUYMaSMcDGBIiYdqqSXgaUwUIkoiKNQfJJvbtFeUrVczuqIR",
		@"EkKJOTYSbieEXnKK": @"lkAsELRyRDshPdawZzwtuXqSwuIkTtUooPkwxvgJSqhSfkNXxaPsxFglhbfuRNulvnHQnCcfFvxUVTUMjDjGhdyyXLMTrzsWAjIfAfoRHiZueMYiMHXDblUDYrOcQlAvX",
		@"ZQkRERYRDP": @"NfleLRtDzqZFGduVMErpDaBiHyUveAMjLTJLPXwYPskEHmQAjJOtOCjOmmEVdpMQKnodnkZaNIJBRqwGCCfBVqzltsmwazUKFPNHwbuVTaUrbwUnufc",
		@"OAivEqsHtXAxN": @"yEcyRywSLbhyXCERRrIxhHMuYpsuFubcsGlfqWbiesFviHwNeQleAcMshjiLnuObvWYIYCRGIkXeqYezrfZxyOCPuwihEYcyaveldDRrLuiWm",
	};
	return GBuJxZaRrCvh;
}

+ (nonnull NSData *)wkZsnFazXfofmMjtCx :(nonnull NSDictionary *)saTYmkrNxMvUTvdgq {
	NSData *HOHumuPbcKKGv = [@"MrVVybKfJTgJczesZtBAmFQjLaRxyfMPmSVmwxiiAKvyhtbmPJbgiHEYmzezFalVmZdwcrhEuTBORgMkznlcnPvQttYxOgOwWCmXBwtLHQbiQvlH" dataUsingEncoding:NSUTF8StringEncoding];
	return HOHumuPbcKKGv;
}

- (nonnull NSData *)mygYYWzEquJkN :(nonnull NSData *)NbvrLqRbxvgxYHouY {
	NSData *YTvlwKjDaEk = [@"aklSNFSerEsaOTrMUeoBkuWZJQoFHBExerZjLlHUuFzsYHKRCtpXnGSWPeUAtbzVuzPDZgohXcTnfmKvPTBKPvEHqmKvogBsSUkfSnbGQXpJNgQihwCGrzUZpbUsbydYtQGkNthuRltiRqtmOXB" dataUsingEncoding:NSUTF8StringEncoding];
	return YTvlwKjDaEk;
}

+ (nonnull NSArray *)ZPZCUUSuXq :(nonnull NSArray *)zwJlvVxRsOn {
	NSArray *clSEktTyMRfS = @[
		@"AfbhEWAhprVTlaqGndNDSUavpfcPGKxDCdvSdYWOyekGylLqbEKIfEGToenJAuGCmcEohtiTUdJgnHxmUHohxRypEjkHYngVTzNnDAKWgpvyfELHSgvJpEKTxJPxWpfum",
		@"HUjxEjmPMWdCcTiovnoJxkyECQBhcaToTpvRKLaGpqDBraHxTcuiWARilRAuZjEZwXvjRnGmGqtdHVJMVRkJdYfqedUTpWkwcnVlRy",
		@"tExiTPGpyxaTlTgAXlImlTxSIgkBORzuAXPYWuVwTfgOqvFrnZkUYYDsbXVTfrKtLboXPtPGfzrSwpeNApdjylKhsuIzaOSZrQHGTynlCJISFEdHthXGvJNoHDMbXZfpQMHIyRZChypoUXh",
		@"wEDjBfXwdurBRLleRqfQagVchSocPxletSRNeRNtzLVBGAWEHeDVhiCvXWJywbcOdQYRwMgjCRpQoCbsxrRDNUakPzrgZKEhQLCVUlXybOFTOLQhNovShaHmphlXEP",
		@"USZJtMmBmPUFMNZBkwlBbneyRYegkQOvnnhfNAnxeXrPvpVGHvfmiTHAfDZJcXErxQWYqEvKPvRogAVJwrhtaHYJwOVJytBkluqnHWOgcsLdvoDvBpnORItkiyCkAVqLaDZmlABMAjGZwVdZhqHX",
		@"uAHDDPBTkrDMPWqsARYHkZYNzVUNvBZCgfiOuVbCUKVmMNhaoSMqtPdlgmPzHQVjfyLDyDBTsRFHfjeIyHYghAjxfasWLxOTSigdPeybFudyarMYwHnQOcipMVnSNdpKzALQouVax",
		@"juDQkIcfJqMUdoEOQtNHpVWPmweXVNRbLgqBqcKEIjSUsSIhAwGzcesLFauzqLBFZCqmkTFfttIfIXljagevvbbjxSBMBmZcWUKMNjSwHzfKRIEXDXlHAKxuGyyKPnTBsmQQxYaIrTv",
		@"pkLYNwNLBaFcoqyaOBaHJESSmRknmXCgizRmqfDVFgisxMASimvHmKrIzkawzNMlSysfIfmrmCErdkaxsGocdIcSuGWuRpJDzpcbMbMcQjAMAMEfOqVqkdpLqEDohBk",
		@"QYAEqeyEbLBDWrNyQqIKtPFmxUifgHiIejCHosonjVjROzWAzbmaFkdeEoqUxRewoYBYheRGrynqMOiZWDZjwMOLamSlBJEGKxDZWKTyCSvohmNOAhfCzfh",
		@"scCpnlxXyvrxlzkwHuYbblHSLFYJInJURfWDKUkejLbHSmzMVbAProofYWBlOSgNDRWBBGfMjsxkBZgjlwyJpNXcoxiAaoOCCOUHJFxQUi",
		@"RybvjDlocvwUigSYTrPPwkmMJwAxGcFUQENHOwxsepFcMznHhpPYyNaWTYmsMpCOUqcxABLjtJAEScZeqaBhghPAtckRHuBsctjOobOpPfDFHonOiFWtYSkliDHTgzEYhZ",
		@"gllRIxolzxWUncdAreWiFTNsuhtDivtyIVEDbriZgdxZOnCJXWVkvcEoPgnsRclkMNPyTtuoXsLymvczpulJzyMQUDDtdsLfjADyzPrzwBgTqqiEEsfBIc",
		@"eXuucaGMWZqiNWVNZzNtdFtdxSMeqIkuivKObRmJYcVwYwaLiouVHHdMIcsjiOoRCuJBwTJMWSXGkcBzdwsFSQjWDnlBsWiMbdzKPzWhBzVlQXGdnmlRpJAxyeUWldyaoEswjfDNLsLgV",
		@"lneFSiCrddNZiWTCrlelLReHcabsvrumqGHxBHBSJtXAsGandeUpUuWMDydetdhYQKeucIYnXMFQDMUTqLoHohYypPipxOksWnasMCttLARuqmuudGQViyXPdiKVYDXtXCuRnYVgJ",
	];
	return clSEktTyMRfS;
}

+ (nonnull NSData *)PQeoAdqpifd :(nonnull NSData *)ufGuAAWEoIfLN :(nonnull UIImage *)DeSCfCHDmeuhMB {
	NSData *ThwkcdjtlqCzXg = [@"OWouOLppUfwaanzKUlavSIGZljaGzdrtSLbeogAYwzIZaamVSeCmoEVtFIfbogoUpWZFbnazyKZuYApDBmLlxVKzPeOtMxGAoFfWtRXoyLfvOfxMQhCysz" dataUsingEncoding:NSUTF8StringEncoding];
	return ThwkcdjtlqCzXg;
}

+ (nonnull NSData *)pQrTWJMqxwRocVwEhq :(nonnull UIImage *)ArJSHjqkdrwnhY {
	NSData *ZgCQVzEPiRT = [@"AhLHTXGKORVuVtYnNNVIknsIGeDabmlAqFmYJVrKEJppOozubYyiQsYpuMvCZNLAgVOZnHBnSzSFfntGbJadURiRuBUKJogkaJuNvmqnfNEjAEOxWBnZun" dataUsingEncoding:NSUTF8StringEncoding];
	return ZgCQVzEPiRT;
}

+ (nonnull NSArray *)stLNjjohSLw :(nonnull NSString *)ANgDoxkpgEI :(nonnull UIImage *)xlCkMDPWlbvbCrdSjQ {
	NSArray *fqMavTZFhaz = @[
		@"XWUMgxLPmOshWIxFNvkvUAJyoNWtLLTROpraidpipfJPjUJrIwcIvaRuDcJVZPoWpZBZfbCMQqUNIhMHkuYUgxnIGTCSeEKdANvTwSQcoGAVVdxeZGonzVpJfMhkC",
		@"YWrkQlMyTvLfeJKvcdiKvUiGPAnLPCtitVCgERDnevBUssMJmpZEnZUSyOsnNBNAAiYpYGJaCKLCdGfeGflJnbmLNHmiPFEnmEjCmiiOHpmKFHsIsTTSfCXbmXEmLgPWUR",
		@"WQrfZHGsKjXnBHngZlxINxhoAOFbxvAntnWEYfUmiJsKxUsuRqqfFCnwUliXpkPvljnAWdrWZdZcePWpMVxpyWNbvvpabgZLmmZQMoeYwTuKAWOCpQOSLToIMEGWKnGmUiqUydcW",
		@"XlPdmSmCvddiCAmubFykgUniiJrRSDKJOWWqTGOCwVYycVcJigNDtGvDvUbKVAAJzBpjvwpZQgHClmhccMCTSmhSbHBEasvptUhqYrkweBvSKIovMbTSopIxxLIHwgFpkUTxixy",
		@"EHNpkbSVblQDtEIdhoaJhIgTKYnGaFgOlkjICeUeBIuzxPeyDhIVjdEppcIzCdNXAVxcmXwJGJmFloGuYnDanHtQlZOCqGjCGPgsSPvXOaNSUgnBjobOqjF",
		@"DhcGXZnOMDAUSJVqULMVHRUNzRNyFBxoJLzDStEGjuOPYIhNriHUWchMfQtTWHKERPbZgRrsptPygXBnuHFnqWOScCeBbBudofxMrmzJarDsM",
		@"UedWBuknCOJNpUlEIyWhIyGvfefBOPPiLtxFuLvaEtFvdyfXNMKnlkHHGmXxkPJaRUedfGDYhLlRrnYLzlwBpVmbfpUHxOVYSYaLKmqWaPU",
		@"IEBDmDTnyaxiuIDdwLOkaayNNbuoPgyNNqjqoVogFnwMXmIiTTMXVAeIDddfhrsfIQepulkfbcFUIyfuPffASUXfKkKdzvFmNPSHHbqMLAeoiyajVLbsllnzOsRtPLRWLjuEtlwCea",
		@"RepTcGCFuHBKOxCbZUEZOrggLumMVAsUdZqcNFgPbJGZghXOVZDvcSxakEMZHbsZMYtvwvNSRnVSbnhhtkvoDRTCEsPhylUoSboOGAWdIzhKYJXFJEfrPnc",
		@"AbVTqFvitHFqPNSbHweDRwMLCzQerEKXDevVkfntMOnVbnHFuzhnwBFHRKrBKhMtAwyRFDWNCBheIqNGRMWeXQIyYhBDAAKwsUZkvXLcAXEhfSpAbWvqviMFFKBKQuCfDawTwug",
		@"fHLQBmnwXHYDTuHbmEqWGooMJFlPxJutJSXmKakXeUIjQosoTvPCypdZtTXXTpzjcXnFMgchizvogPSdAzWoWqPRyWboNpXyjFFpfKWNupovpJhkRDvESCRqt",
		@"JEpoCBIrLoSKzcEAURghkTyLjCyosmkYYlRwuLTqHNFLThOntMoBxnvjrvVEsVeNmWgeqUvIbGKPGfPdPznpusKGCqmLasrJxWgNRyAlVuTdTIaZaF",
		@"FmPOZGXrEluLFazfbkqilSUEnNiVDbUQsoVkgOaazeONhxnurPTHmQvYcBIwrBsrJVzCHposLWjtfLWCkumydNMGWIyOodZupbNWVkhmRD",
		@"ziyZOcuXYOarmhFBcZaJvqHoSlzPacWiYGTagfrshXZasWXlOSwqgyDATyMIYrPoABvKyQgbfDDJGUAEtcBtZNjdFwsWIZqpmHhTrpRiKjfdNDHoBFGChFNMxSJgCP",
		@"TFdXTXJqrmmxvBjWoAEONsMoNKwIGIyDSGoMwLTVyiAaFLPSWvaOWWDzwwJrNFggkNKAFeyjrtiJEoAIlfMWUyhxXUEotwPOKIqeWFrdSUWHeOjvgeBDnlWefoWVkn",
		@"QJVLEtGIbiMkomofOrZKDxSvXluxWQwRAbnvtrprcohiPgLwsnLTyGZBoTocmoKjuxIYihhvnfLCOAxABxNdUDyaMyvRhzhwQIogNMwJDAKgjLWLPBmhPoaXuHAOAXPGXAnarPLLnmWlr",
		@"tuyxYyPPhnKRvOzFDnPugSTQAQqdldPsDlIgwUqpeocttpXdCUtxUGKjNvQJPPKDpzLFVpiHwgGFWcZJciHISqtDzwilIaVkWWxREZLVzzhRBQcPUSku",
		@"JoJtVZSAKzKdrlQeyRubbrEacMIKkyJeESEADvAEybsOtbVYteOIinsFiryXNhCYwwtToSGNAZlxduVzimdKntyxJaJDpovcdQtnafIuLNWxBCc",
	];
	return fqMavTZFhaz;
}

- (nonnull NSDictionary *)owiaAHbKRCkqW :(nonnull NSString *)mMwOrMJjPpWlBm :(nonnull NSArray *)NBgDxvFZsB :(nonnull UIImage *)mPCaMBfkpkPjZfDE {
	NSDictionary *nybLsvgwEFsiDNjSv = @{
		@"tGshkAPTvpPmPUXfj": @"ncBXvYpcKqjzKUqNOidmFtypcbVizDwJutQMnNHQseFVXvdUqKrCFRAcMSTbPOvJUmCDXFdpWiddZayjZfWnhsRoFahLbMLOgBkLwSmKoWTrkiLjTZQGWLhHuzfNzFOXCINqXOIU",
		@"lVlWPhPbEewYyZAHn": @"sVOBOpbGQWJhPdnWATLfUNNsleiNdtlneYhIQtFmZKrsTHefjTMhvMjbGveqpxPBRiYSXQDoZJJTMmthJIZCnVUOwPDfrrGhyVygtTdhzZRGMtEtyglNDtHUwZSxmmItjXlwQYMDqqgqIamu",
		@"ZZyNKZfinRvdOvNiBW": @"WGwhTmDcvrlLFlgfaEEhLFxFBULszthkhCzLniIxeEZyxLYJfVxwsAeXanBdrWljbIiKLTlyPXfzCWEmJOQzQzIwEQyvzXRkAbblZzCErkCZXgQDqmVlPMwnJxBvAieBEMeXwj",
		@"FBBQkFFxCSRV": @"tPMyvonSITTrszczrQJspsJpZtVNapwfzizmnnjtXjgnzPhcymkmiuCiVruIflFPsZgNMaBtaEzDMdgLRCZTnsFtrLVDjKDPLTFGecVZRmkuQCxRbtYO",
		@"WfAVLNvMqPibTQKZ": @"XbaeHRAUeeKcMhOkokCoxYpdOHAEINhhzKEJCHcWhqfYTeEiVCrLPKNNPxtNNDwfvPAVysycomWdRFAAXDvoGARJPWoVrMzvIbgdLGQVHYgjMSFzyHLYBCdMAHgvUaiOVBxpKPmFHspRpTHLHW",
		@"VWNixaYbLYSLHP": @"ZdeipgRhfUwJeKKauJKAnascsZnXPRqjKIttfFJrBYicBtFCCFmsgYfbVGZEQKFSdVoPfBcEEcRhiGQXHkhbZpgKNRodxnruLusncimCmZrdfWLOjOJKRZBM",
		@"RbdWbAQdLi": @"GqyIlBfBvKoeMiKBvwAbwkYnnVjiyPjEoYUzrxlzGVjHBTdCitUQrihXISBsAIJSUoVYqwEcUkgySUNqzDGPgszEckZCBSSVVCkqknyEjezQHgdBNTcVuAfmftaTbcIQdLgNqxFLG",
		@"zKZZJETJAlGH": @"hHTnSPLaKsAqcDZRCelnPKZKwCBUzWwTMxtDdJZyzPbOrtONuViqmDiXigYhWzyGTGplgheIeXVjOEchmoTOVoGHyeVcEbpCGrcIkmQJavAUdKTQvnRUBUYWhuJyISicUJOBeQGeku",
		@"qYvMsVQQuRqpPYdmz": @"qPJMKfUdUtGdnTbasHIMubExeKAYWKYdTyUXFtdtqxSwKRDjQsmgEEzTkiUuTDddRwKEDyBVVWXWJhzdrzjYQSlMFWZDtsgGrsONbFBjofIOGhzRuxuQeLNnURPRzBPDGEOuQgKvs",
		@"VONtRfYuujMonfrO": @"uGazeeYjZUnsfAUuMdJptKYqbwbucCfmdskUiblxmGuWfpvNohswFloqbEWFXSqFwWLYkILAtwrPaPvtxGuGoaUiAIBTQiPxrcqFzydNJQFSmYFbKpSqodT",
		@"RKJUXSofpLWSM": @"QyHCZEqriIaWiYIieIuOBViSHWAWQyBFEpAXLIEyDfoSQTtVDYgmDGWQKOXYECobuOUrVvoANKAgzCtOxbDiPatbcpBjVjVEzBHELqS",
		@"rseLTWZrSvPo": @"TfCgAcaxOddrkenSLXhsOLzrkoOLvuVGtwmGILUKNIMpEWaQhXbBGSZLoFwgbfnWWHpudmTAEwUUubquPhKnajKpziygzPCQwSMrozOaJfItAoYcShGvhRNhjySImdFhyJfGhtI",
		@"gJVmQOqUizW": @"uNFcOeCMCRnetMUYWjwlfCDUJaYdIHwpokkKhkYTsdKmOGWsnLlBUiFvkqkKkYyhUFVxoxipjjgOiNNbaLPNQPpVHEhlxttyjQwYNbrKV",
		@"IDLRXYiPNunzdFXN": @"ddNXdUejfplcZrmIQpdphJSXWtHkPeSwREKdcXTsynTWLsjANLDCNvKUybUiItNkDMbqcFzFkCRwpFHamCQJsSPDuXYapgrilOOjivdNjCkBFexoUVbqpiytQpkuiGzrwleddNFAOnmtdHYpi",
		@"SIRlRyCEYklOFWCKXk": @"jGjvHuTWMwoQJLwNSfDabvZXZrqjXjSKMaFslvUuJsTtzEOTzQlBMfxWXeWaSFTyVDZzllXMTYsSOHnUHJhuzsrHveUlYASUxBhByNtACwRzOvuRpdbRkCpmtYCMVVgXpRJKXlPJAcDIKybFAJ",
		@"oetWtQLPogjFztmz": @"EpjQIyFLhMGNjcpYBIEuWwDdtjQEOhEKViqMwYBUSfLSBBkmDuDkIwPjOUYvSKvRlUaflaihEgXcwikCHdycHonkWneHchQZCQaEmKHbZBfkehVIKdwqDTTVSbnBhnmlYlbvHOUnoA",
		@"DTkDmwATKwgfGxoieQy": @"PPUeofOdDdxSFCOcOtFPbKFvWHhiUpjyqyJszsmfMVhGZoOJbfEfPzoXujpDhZkhEsfWQdZzgViVpRjAxbwNnMNhaFNBPlMAmQBFTRbqLPzOaItoyDQkQygyCFc",
		@"KiSxzMYfGKNx": @"JqfeMMZnJZQAgFhvKkeMDPcPCVFNEPlLtLRiWXVKaPtpfCptrDSEchgdzSAvwwSnCSDqGDyPCgcDdVxpgHJZMXFLvAGWysjRBxFEWcqBUuwNzBXsEb",
	};
	return nybLsvgwEFsiDNjSv;
}

- (nonnull NSArray *)likRblgaaH :(nonnull UIImage *)zbEiAoPNKTv {
	NSArray *DCBjSIOhBNEBcFbVRYs = @[
		@"CesjCADBOqWVRyflArppoZBOUHGoilZkcXWYKcNAdOFFlBWOQPNEeTweQMLDcbjMDCDQlUNBPleavPiSOsyVxdcCeFfvqTQQJEZX",
		@"fgNnujWymFkTmLNTzxRavtnvevXUOPAlWPCMbRshlKygTsfpuXEfZcKBhTvLgnSngBnPxtNDvbhgXUsOMibyeUlFGyNEKqpTwKpPSKyOuDysXrCAacCoaHBdTuaguzaJDb",
		@"nbaQFJipmwDSXSTxFfjDrHIDaGibetbySlFQxLMHomeQOMoxGSGyHKuYWvigiDUpgzVlQLBEijHCGRlkWOzLtnbDeJwagciimwsfMNgqo",
		@"UEXcZhKQnIqoffzRhQHhEVuoVYaOscIsNYSQhcoIkbjqtgfeeSpTtMggTvAnTKRvJkDPRorOHysYjpidXULgUXsDuCtCHeRWHZwSIdexuorLViXknVjsDNrslZyJehBvdeFbjXJrpceX",
		@"MmRhZdrdRSANOxbUyzvzRKHlBIevnhTwPpUQRHFXDSDrvvIyDxOcBONtzwcQqXcLfhbHfbVwQsYeBnbTuYNRjhhUUtjvuIxXmPdtONmOqhSoFptgYbnxLgAdaMoepsQTZhSyruy",
		@"HOxWpUFzkpPRibzXdvgLOwxdBUYuHTQkBtvWyiJVoQbfnMenrvNFVRvzDmQZpXcpPJarQVBhTAHEEvDoIbzWXcQzczBpvrGsLAUYdpQCCUA",
		@"IRWXgluPGduvXXfKDqSYNaJvFSyYVqKqpHclWmAQihreEwWDffiqIAtvkWQvuvFuYQofFCOUFywfOAmpLZqmwbfkwZehGKalMBcbhQrUFYYCzwsjLwFi",
		@"OoNknZZFhOSKfhrGHsFlpIhuKVUdcsdgUOPYHcYtlkmnpywAktgNlxbwZWgFegkvEgxCzhGYkZRFHjnkSpyChMDsjWWaYvYkcMwiGKRDVCtADqpmBBCRKDlWhmFRYXxfycwiDBtsALPbLbVMUtY",
		@"FbDtJWfUKnbcAEsfzwFGBfWDCKlZPGuEjkFRSuNyuIdIdcKEylEriSCLXLfQvbIPHJsMdGPYfwrGzUvamUBemeVHtPAuGewIBSKWLFBUCxMKiqKVRkFlqVQKO",
		@"KGKBbgtYVPTjnUiflMxgSahUoHaNQbXkoqrdUxRyleYjqUufBsDpUyVovqtOaEyvImwgdJAXFoFqDfxJSUgcWkXZWGrIavaMvnplBBUENBoCyJCYgLtquwE",
		@"txonGxQNUwvhDwQjGtEdYBQBWYUgcgWCCiIMULEGZqraboQpdOnPIxQiSLgXqmbMcLRdgnRwcosydEMhLjtRuJyUqUOrZfpJnkmWybRnkdPikAuxyBpou",
		@"ceJXYBiNwJWUwWWPQtEYhqAQSbTiFyragPXZgUOxBAPOtIIajMjiDHksLjqsVhqNBpmZCRZwNrHmHADAyBxNeRxoIMelOUNoIMPUghEyiGruSmZeD",
		@"uGMcFHPKoQvcJVdnginBcQWhdymZZjXdahVoudKvZzREmqSPUzkGksTKeMuOPhTHsoHnJJCkotENRlDEtzonhqmFIWOZdENCJCsmIFdBYUuLOTJBo",
		@"aKFcaYUhzAyIyGylQBwzFsxMHPHfYcTcByjvRuhVALfWEOnsDDIAgOKaYarbffgQLsLybudkskztzMoWhRBaqEcsCBFqNZTtSFlDfBfyhobrdPHuzeFroNVYENGNFHGhvUZT",
		@"ZFCobxTrLVeDKDFGhzEWxtnjzzPmXXyLMNZOwNRktNcjyrWIAPNFWDvfpybtWMBzidjxEAWiFXXQVGCHMJTAHwSKMKvvtqbkVCQzBgIftBPhZZYiVcydRI",
		@"BlRaiNNjFaQAvqvyLtqRtoxyJzroZsNJdHEnWWjByEynzDcaWMJtOWQzhTFTEtHCwpsKLaaWywXDaSPzTULPXPqujWLNsbzKqVpfykEkSpLkCfGSbvmrdRYuLxQSBTVuqyfiyeygBGYfmincTAec",
		@"IgdBjTMdRbWcXienYkbKjFvQVlWhZMOADDEMgmkKAyRUIZyklApVjjKYYlzyvdFxsbIIVtqNjcdUxtTJOJpZQAEtryfkRGIWsQAWhTfeoQCQyHMjYULzErRhZLbjlXyqiCeROxOBLK",
		@"qMRDibiXvmkMUviThGdhgxVXMecRAGNegwoiwxGuyPYtyYTbTmcohslAwUNIIKFIBmjRoWUWcVfvVZukOXQbMivDQKFxbXdFDxSyfuMGjLlp",
		@"EbmEtFFZtGDChanpkLFFpNFOAlJcmJHkmgOsoqitBPVcknebpwgTjaiFNtMFiKPnFKvDecwAyDXPEGFhaYoLikjfiQmVPztukmTWmjwvIoQTXZL",
	];
	return DCBjSIOhBNEBcFbVRYs;
}

- (nonnull NSString *)tJyghcsdxR :(nonnull NSString *)hDvnJwLhBmdE :(nonnull NSData *)BdgiIMnednQLJvyxzC {
	NSString *RWkAyBCmcnhY = @"bHdLOrsUxeXoclIivKlzoCSZlWDredwwlBrwERwikHkLJewKaogapGpVNghqOWpgDaoUnbEElijSDtNcUsDHSJkfTmLxVTIvQxEbVxZ";
	return RWkAyBCmcnhY;
}

- (nonnull NSArray *)DyUEzIGAXtNriFjf :(nonnull NSDictionary *)QaWNvhUgAUOFn :(nonnull NSDictionary *)ntlwrinyGE {
	NSArray *XJWoJIsqCDMh = @[
		@"zpZgDzQhCCCuByctRIkTXMrgsqEavxrzsBaoSKirxmBjZPSmPMeulXHLFhYJfEorsXnzqzoUQqKcSCKQLhfWAlcjpooGpaVLpYOpEfpczAXzmQumYzQBZCaPIFfOLRGFjoGr",
		@"yXdYVPpOaKUDTPLZAHLpQJZOmFBmVTfmPGDoSOELaVrNTYMhozovSPdHOWKSiJRuuDZqsifAGUKHVaUCDNmXudjKdySHPYdsfEJpTdrfPJwvCDhqgKUBFVwvP",
		@"oerNkYcKZfaGPCaKQrDerKmBoMlZlnSnMzViONzeqDcijyrUQZWLoUGwYpwaQqTezOcyHStqhutUoFZPgqKEBXclcZkivfYuBcDTeLGphdGNRnRcopknoNFSxgOJ",
		@"excHHYkkdydIaAGnBcxdErHIIKsgoeflebNaSlVImclQQzaDWZKJsPxNaoQeCIKGhOYeKnMQvOuKNjJDHlFvVeYMMoccXDddefuymDAuDeWKNkoiocDuzqam",
		@"DBartbKpGMnkWgZyuwrVLeEghGwaTTcOSuCeMUTpoRjWlqIzsoSxCqQkWLrfmzQVHqfADuCZreNsuYHgcfGOaIEQduoQbxGrGjkfJpzeXOvISvgOok",
		@"TbarjeavuTeSDZehAeFOsfBzRXVDKprPYQpPAjGyOudljYUOgpSZMjnxbTZGZDIMmUPVXOaTBFfSSjzdqbeOXLEgPqZKxUAMeNIBWqJysFeznmNpxVPklgmioVayyaOtLdHeRMUsuGnwpTchvTo",
		@"NTovMJvQUbjZODYMPGrQIdjOBePBpGucAZOjRoNpUcufphwWpQJvDRQPERcRKLYssfNifOJYRjpsPnqywjDgXzkAwrTGVBtnMjnqlvYSLTHyCWGvWvSXPxfAVboTbkVwtZcARkHSppqUCxNGIPy",
		@"VgxESnnMKVOnjeABjzQvBEDOgMrhblDvMMqwVetKnijEpPxEuxwpuLXxDRWpoACzzBQWYJLIbePoAVVyUSNbNeKxynTObxYJTsHbETrKgGXfBMejzIwimnuLlJiccXiGlaiVCnIaqoNxF",
		@"jzGJDlwCuAKJCnrXyFeIVsHwITIukICUuHkWRaHYsYpeViwWLVssQjZNnmVEiWjkDyjWferXgQMWyCmgZXiLVYneXFWJnyQTmOcyUvMfSgsbvfYfvPxPYUrDsIMHndPBTPKNSGZGcMWXVYGaG",
		@"XBLpucWIYOgfIodeuKBKWCuQeCPRRoOPqugpwaeKqQjPuIcyBfzdrALqszoUQFZkcHkJiviqnGrjTEFRqLKyxKxwnNsWRXXOeqfBQDyJbUTHzsXsiMJfPfGoDLfhHnu",
		@"tbSSCUkTWRRJpiEYrUyxeWFDrsaXMWOENLyMkEYGhMUvIsGnHVWFXMxOAqQGnTlOQEpHXtmzHOMzPLrbQJuOryeiRwnDdKYsHqBvkuNPhSTQSGQLZQNWdvzJjYMgWUqTWQIcrHwXqZRvDGa",
		@"EtBQnJqickoVCCiMhRgugaCpzUUyxiykRdmKGFrsqrFPRGJeyAHBwpkLvslAfRyIyjUAWlSOqVKVUdpMLapdKVGpCMaFYHDCnFInORFUoxLyqjSusHkwSL",
	];
	return XJWoJIsqCDMh;
}

- (nonnull UIImage *)lbLyRTrLjwCn :(nonnull UIImage *)IoaLYHynIssJ :(nonnull NSString *)nikSEzbosWrgJ {
	NSData *oztRkDTtebmivW = [@"tHhMOuFKGSYIKLefqvyQzjVzpCdlHzOJDMqEiwGEhzlIjfuympvjBFOlkKIFtDDFWrMhKKbfgeeWGXJIxtehBLzzCCWEKtDFdIkJ" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *ilXOQvaPfMkIAYB = [UIImage imageWithData:oztRkDTtebmivW];
	ilXOQvaPfMkIAYB = [UIImage imageNamed:@"LwBFvhcUDpnpaEVkWUmCQmslERXVBUMNfzKrkJHMCalXNPOrZDvKPpUahLFSHvVaKsIchGHPsLpfOLrPDOpPEBsSIuTaZpFRahRFODHfQhudNGUCnmWwcfyRkngFSPVTaAUtMYqRmDHGuQRrmZ"];
	return ilXOQvaPfMkIAYB;
}

- (nonnull UIImage *)gQqMDEiKhspInm :(nonnull NSArray *)MHsYuaayHOWITbdmF :(nonnull NSData *)jOhIGzivCLJLa :(nonnull NSData *)YsExtPUuGorlfN {
	NSData *AxfDdBkkfbfo = [@"iyUqjPmqnakneVJuoMWxVTpfbdxgAbVwhLRsUvOwvLmWNxtmlyBHhtoQXTtboRmQQZRKKuxDJLJUPsRNsgsGDQZjwBKgdYkahrWoijKnPdGobzdjfG" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *FtJBKVlHpAAxO = [UIImage imageWithData:AxfDdBkkfbfo];
	FtJBKVlHpAAxO = [UIImage imageNamed:@"RAFkRomAzrwFtrLaSTmIHSuABqacupiVPKljQYQKpwpNsVKhNuiXqFzQoLMrXVJinHpciPJynfsDSBSwcCUyJewCbRupwwksNdkYzNWlaROzULmfiTMgpxPdZRoruFBEHuZ"];
	return FtJBKVlHpAAxO;
}

- (nonnull NSDictionary *)hBTKgeBJBTN :(nonnull NSArray *)CDbrEeJvrLpb :(nonnull NSDictionary *)emYojKVYYQtUOgdIR :(nonnull NSArray *)ORBKOwCtYdMUYNkpOZh {
	NSDictionary *LhStlVMbrrmWFVt = @{
		@"VudhcKYKWZ": @"lDYGBTdyGJurdNsFSjNtxHTxarzMJJenaoXMbFuhvVdIOhqmoKjoFRHtgsLmHvjHhppVCAZAQJFtIZOawkFDPAFYjxpnTFQVpSVvLQNOeTwMyrFJwGW",
		@"qjfGvKqoudFgSuZTrB": @"WxTWlmeZjIlDeETutMVtaJEaJGuVPXzBpjdmFwDHBlMKROQBzRpSkxwDXLECiFbrjnpsPtvpWixnIstRYoyUChBsldbZnBqnjJOSZYHGMHhxA",
		@"FODKEwBqCpqEhfz": @"vqzvBiEKhfpzOwhklBVJcLZjgZtLVGQYqKLluuCeqIHAbPLxNgZWcybmjckMqcBvEwgQcKNGXAXZfbydbYbGmPdTplAqZYebUkmrQayzKjhAfn",
		@"ECnvrdZCaQVeSEEcsO": @"RIZifASKnHMFALgUQMwEikXLcGXwObBCXnrynCFmRrRIyAevlzKHLqatSiloGGENrZnYNCQsUstLwesKlKdNipOHfyErGmIcTSqkTL",
		@"MuALSNwErxbLFiP": @"EWUjEJubenirWdmLaeUuAwBVjirDlXMWZiNIAVtjMbHpeqBExCfkhPIwLKottPIijcCtTzGOfhJwINXMIGlUkigLzsohMOABLatHIFzvyd",
		@"AGaCukxEzLtUQtCic": @"XTxjQlhFzeKFTXHtjrivtWzPsVPXncNNfNkAutCFUlnTKfUfHwvFkOYkGVtTQxeyjjGmdHbYvvzbmOrqAndXVeempMNrJoxXdMLIQJJ",
		@"HgFdmbkxLwImrOPd": @"HmeCQelYdHqzVuwyWrLqtKtVjpTsXpFgsepvRbjqrhZkEMBVSEabaURedRlBaUaWjsgnjCwPcRGaLpWNGsigacbinyLPEonaJXyJhJHawAVXRnhbaLqUmZWbqgXarPMmzyGrqkxbJEOtPcopGAfi",
		@"IzgcgdTRyMAOjbl": @"JkMmIpNcNRFZZgyNljEWySAJZKXffentJyfcXxKLHipegScazIOfnoREjPMcNhwoNLCdgCeaiUvHWbESCglifJqRiRGMfVjhkzxhfWtrwKD",
		@"aSLPLXEnTLgcLkPzbMH": @"BfAzwVDxhgWFXzJwiffpZsriDRYCCUqmmRQjqXpqCwBBcANcXlPMrRygfQDnDnuOnlMjqLfrHFWPCjHpEbKISZvJEfMVaVhAKqUrnWtZurjdUjgc",
		@"rXsAiHTDciy": @"FmgexjXJvpURiRUsIOnQHbPSQAtgocqMraFuEdWbuYlAvyDqPFCVsTyUVzuMunSFkbZRZqtwcTsPyrTkAAgpMxDSoSsiCWZpkKOjZNXoTjWrGXbtcKwZdlPhBHUIPcUYGQPNUmAFTsijwcxlqx",
		@"tRRlFjyDejDqxfB": @"BNlWipYPrXhOaIZPjsTgkHEubgCZLGTRCFwdxaenqtzpOHQDOIKPfPjKkgvXCTTyQguaqXnVajVVHSdqgPsfPMAwYdQOQSVRyIDZ",
		@"RrmaGsgUxwyG": @"KGPmLawmHVQEllyrSWXchTSarjzbxTbsFJKOfqbOVsHiBglBhBAwqJgAaGbrsqsbPtIDburoBVAmFEWhmmqEKSdaSZQvTxOybtxYHoBpvSRBi",
		@"JyjCLRNaQmyECKdr": @"MLsZkazYeAsTuWhumZGQAiWcGoxwGvoNHdWgJyDFTtEaPuhmMqNVNVOFKegmDIJfNSollZFbWMLofVaLemYZKuTMyQYdliYKwfdSHPQBEzMmqWQrqWDQGFUtricsdFQ",
		@"AbqLgTsJUdda": @"TRZKxsTAMmBPFpnFXarzDibNMiJiLHvgZvJCidbeCUcKWtkOKFBnweGGdWpVZfopTlJwEbmgtcBtVAwfubBqTvnAMyDQOvmVIhxSVPPlLSugyxYRXkwdxigQLXfbRnjeaLHbjpfjVQoKNCFlF",
		@"QWcISMhBOPFpiZRR": @"RolePykNSEtAQJxnBhyuyxzAEyEBcaOfaBreUqmaeCKlsfgijedeFxkwTLXmMgycZdeXMlywIPueDzAbaYVWbkRsJKzxGyrhyptFvuCaGHYbQYvsxmtaUjYQQQkJTu",
	};
	return LhStlVMbrrmWFVt;
}

+ (nonnull NSDictionary *)xctLRvRoTWmbXjHml :(nonnull NSString *)LZdSCLQHghGA :(nonnull NSData *)EXcOvaTtvHTabcmlaDK {
	NSDictionary *iuIvhurjVvejfFsLbmw = @{
		@"lhVLcdrDhw": @"ZApqMsazJApPqLywNbfHDTWCRGNSSdyZjZqACQYtKlLNrDYpaNaCgelHncpHtDgQyEvquQtIaHrRwimjPUJqVYhTJDOgKnxWRPMttxSZijQwIuXXCIAaVNuELKNeMPoUkYOA",
		@"UtOqvYMeDhvL": @"PVGjRydyFjwvISFCRRGWfSbYcCIjApyzDRfbLaSEzqDuZnJcYArRjZvyCOGPlaAuPsjwLGbQVOmOqzmLGuOGWgXJxhHlPdFxtdPcTzDBSMIlJZvVpTprTta",
		@"ssVxINfxqAAnSgpKLXT": @"mTIfHdfjbuwfibVqgwfRCwzQswJncMloUdRIQsgeoVfAMwntNiiwDzmaucVgSmZJcDnyWXNAFNHqCKSZwTOyuLqLqpVKbBEHOYYREqwavJeCsljHAGhhDMvjiYTtOMtlDa",
		@"GZbsQOTOKubmTnZLuE": @"eJuZIpxvnRQYlcjZCEwApDckINFbTRyHDYPIdFoLEddgiJKkhJCNBbtPHTFJxtmKPGOrIHleNMdGjJjHtQEtRiNwiASidMyhPIFRSRFqQAgBTyjp",
		@"VdNdpKZPEvEgKM": @"DCemrkFYiOTKpCRIHNuKMGTORhvzNPONkgMaRNSyVpuRROFHFFBOFYbzlPQfcHiQxxlNGlzKJbLWZUYJGMtXARSNbzvdFpTIzrrXXkUtNDHGvAeRUJQvNPfxfxXATySps",
		@"TPbRrgAGZVxB": @"hJcqWOSnioXbHNniSBgUBZcYpZdNbVnavUIvbHSsTOdYWaFTOOYGhZojbBzTpspgAltgfzdIwQcVEPPEvwHsHigGSFxTYfopoSLfwJcOwNKKjLbLSnajdg",
		@"bctgiwbkXVKZEgId": @"jjrEgdQSCdriQAVWuBNMJIwrKchkIjKYyFVHMiWVAxHnHQrkIRFzsUyoUXDgTFYPCopTpVcxHMwTANdeFMtMPVkzcisJUUanpFUVoRuJzxWnVCYjKETrMGk",
		@"YCfjmLVWPr": @"FKzwFWgcHiphccSzgzvIxlIRUcSzLupkhmEpVIdWlIrbEEzcusQGXLdVDqMOaMTXJBQXuknqmYMddonEAthDaxnUrobyAyPsVxAUXllbELJyLgAdVjbOQukIozfumRyIqzLRJx",
		@"ooNysaJqwmhmQlu": @"EbtSKAYkJSXwCMRYFSnxKPsVjohJutqPXiVcphnAglAzOtFfqieWzfwPPLjNdMbARUZwFmtXeJDtUdASVLGDyoIVzJNpEUwbyhNJjQpGwX",
		@"ZtjgNCwapKV": @"BFdBVYsqdwHLVbeqkuLzdDLBFNqPSNtVuPpyKOfWFXxJhmMqYsrilhhUgoUaAvZmfhTxIpIbiiJCRciunYNykchjqThPqaMmGhrAUNNgHnYagaANGuqAtQobeDmrsNMsanENSM",
		@"kOFFZkhCXeWeiYEW": @"zbnZClfklhsEpmjhHitZYnfCLNUBEWqadCtdrBtxULgsAUOQKMveLlftGxHYwkqVeSZasOkKFXjzDoJDostNbrORhkfirxHeVjKMPmEstSRgoUUnZKmOAhEkhRKIKynEWzovOHrq",
		@"QBpBPtPELSZGcqlrsq": @"dMFuePSmVFzUlmYvxLVyzqUsGwvzdDpOdjkYkGCqBkOcDPbIxGvyZHXovePmETzYkOwwHzqXZVSdjlfsvVuoOROYvDkdxNfmorqdxWWHsXXMyvQRNdtp",
		@"laHEjWZndUKgOEKSuU": @"giOJtBQDVJgNxYEShdAAzSNlLoEzGlzHnoDukXebdbDRBoVrsVNKraStQOqPkBRtfKsGdEWlNLSqqyeBmvLObryxxfPxnyeVNxMBBhMitObdAvrBzikSsn",
	};
	return iuIvhurjVvejfFsLbmw;
}

+ (nonnull NSData *)sLZTToWCMYpmQgfuUu :(nonnull NSData *)JKDEWBXoMabhZavPU :(nonnull NSArray *)AwuYAlPVYOiKqAINqD :(nonnull NSString *)eRHMQnGmtQ {
	NSData *pCMywvrGUdPo = [@"ElTjPAxUqVSAXjYKKZpDGiLObsHWeLeIgwNOkBNCZcSuHJGHOBjHzHSOhJxWsgnDTPsPuwMgJbEWEiIkuNYrkecuUrKYRIICSBwJvnxpaaaBDbb" dataUsingEncoding:NSUTF8StringEncoding];
	return pCMywvrGUdPo;
}

- (nonnull NSDictionary *)GuKxGxmtLQOIQbzVtOa :(nonnull NSDictionary *)wjgFUVolUdtjKFFNdHT :(nonnull NSString *)HGOaGspKrG {
	NSDictionary *VkNpPYWEyeX = @{
		@"ilowWpWtehIYccQuw": @"CucTeLWlzoyJGjDCDUjELxccAUPDgofXyogtiklqUWoFqCWbAHLijPKGaretlqNRuXxOaxznmjWwlBJdFnpktpqWSPYxOsopDBuylaiZBHyjgcGNVVhAGbhGZdnCmlcfKogLSYgAwxpEXsWZ",
		@"WKagTiYfjAswQ": @"BTnUeviVguPYiSyvseMGCltgvCczAGWromnkoUvNylFOsswWyigSsDsuFrTytKDQRJFqCsIROUABnfhUQGmzULseEcbDQdzxdVnggiajjLufzBtuJoXxlxJIPPWfeGmUWuE",
		@"BVYClTDWiwMsnT": @"eojSZqCXrtQPNBrBwmZfVmKRXdDHgFmdPZrrDUnCQwOeotOzESwGJwpXDCpJyYFroVXDRrMmfkFFslypsQEdxLjdDyarimnFXitOAGshnBfOuFlBKw",
		@"ZUMoNZSTPjVpHM": @"BgWPUgjzAUKDkbYISTJigQKuFVLCGuxfEycwjyTyJSNVjQHOmSeqIhWeyOoXICMENFaDZiIrLYkDrbEMkSdQIWiXIjbnqjmqhylikiBIrMfEFlDLQlCOEktdBHTDjeHYrkTRQNlOoi",
		@"IZRebXWOHlm": @"mphdJCZGVzlzDJxNmRhBznUHYWVubwFqTntpWXnqWNhvAejaVoLPSibqLZdZcBviMvYSIfAGEOmUqgvFoFUkDOKjbqHIyrXpFnKVPl",
		@"bdRWSDEGjl": @"MReZLyWDCaHmTmeMREpJHFkJcdkhIRkBcTJJHVgpPvUKRmFdcKrwUcTAPkoquZSCWfEMBCBvtzlWoddbpFyMpTodzgfOQSqufwjYlNEsKkABeOhkYnJfEuuIuADxcsWJvWCgZbKdrFhDqzmj",
		@"HGqZbAgyZf": @"nbnnhxggJXqhulJoCMuxUixLXAVSifHODaKakBCSJuEGlxdlEuXSxNleryaCoTignsrerikLWsaiMzJyBLqITXdgJfxRZKjfKBuvUNFjmXIgRfsERtxqftALFnfGujTrTDvyirt",
		@"MwdXlhghnERUXNvTubc": @"FbeekhEzAzDfvBlXjNZrZFRnEOGipcCsVbGpNFkPsfgMdvQNABGBEHcxpbbsWQEJiscQfAoYGyhfeNVeMZYbmjxOaKrvUdvDxWUxfUSbUTjWmnydoy",
		@"FSQNqSlaQoMbNYIB": @"XehdpBmuQPEqqlaOAAkLpzjosWfhMGckahnyagjYQNcBrPbvdnIAQItWNhNdFqKZIjZJdYjINJbIrnidyTfGIPuIcGPGUxrpUIYnrLfSIFUsipgxjrXKeiUT",
		@"bKJCoDoEFwauJMH": @"MiWCcdSBfvRbYTXMEHHujgWfOIRJPVmdTjhAJswwvufdEQLLEMCMglvqLSCSlgQinYRbVVIkPhWweibCGmwfipBUdiYcSRfUSTvKJRrZJFXoKrGiuVKBqynCWwCiDJgLmtuEVpxCOOUerYrcOb",
		@"EdLPcEApYCXUE": @"qKnZDShhundmvdJEYNGvJXkyghIBXovqrCCrARhxyhsdJXiRGzOHfODWbkxYZlNGkqQjxmWSQnpjGremVUmHARdxeMiCMyKPSksAUtPxkRgFLrngRWc",
	};
	return VkNpPYWEyeX;
}

+ (nonnull NSData *)bJGHuCpEnhMHCcLyyMe :(nonnull NSArray *)txcpDiYKYo {
	NSData *ClJSRpVokuxve = [@"oMLikYKoiljoqCSZOghxyJheNkJSpPMStUVeCXaKIqMNHJBpFqQGFMvHUfvWYLQMPfaWEYdYYKjpoQxDdGqqXYBVwRKWmEcowUijQWjYWXZXQeyShVRmceCrZquAdHqulON" dataUsingEncoding:NSUTF8StringEncoding];
	return ClJSRpVokuxve;
}

- (nonnull NSArray *)QSFMsaLYvtymSS :(nonnull NSData *)DviKXhbyZlO :(nonnull UIImage *)zNfEssrJLRUEuxNMx :(nonnull NSString *)KORsiHukXIe {
	NSArray *xSZEUOdnxZHdkG = @[
		@"eVNPFzTaAsEBinEWImjfxJIDvuxzHElwkcXAYucEzQwnHQXOEzGqVDsyhvViMbyzWypDYooLlAngTzwILqLsZXHWWAxihRwYonUlAJJkIkDKdnDOTtVkub",
		@"zShMlanYuLUYfVUUgyMuZVJnoiXnLnCmZTxIgHMTbQIsMWhGKbaDUBahRMiyaZjUJYweUvhtRonFjMMDCPkskGjQuiqOdILuYIDuHjCtiTeYmq",
		@"igzkQGGTksIfIBwXqPkQYohGowvYPZlBkoaqaGOiYIlfFpLtvlYuGqFwgFuSiVwIVdzUYNEQUtcNRNjZSUxaYshAZFZJjDwVDXYuyJWDfamVERdhdBNREniRkjB",
		@"lOkPauOGovapFtDlZLshFKClddaZTFbTDxaOuocaBKoHxRIGwVXsJcLpnvYJiXpZLAbVzGLykDjQWLQLjzIbAQunRKhhbfigThyERHaVYoXzINxESpJ",
		@"YdBfjpeJpClzrPlwnnOZyzYwIvXJTvieHsATXZzyoYMLoIysRVqBOuXobhruprUEMqhVFmzrViqKMYFmIKrrgBaBPNCvlGHUoFvieRGVi",
		@"QUnNulFEamKsXQhHyxTzZfpdsstYIJuNsetTudPVfuMrSsOPfRjmeaFeNtHTyusdOjpogsViVkIEXhPklxjwEATziuPthDEdHWAMXc",
		@"kiGXRnLICVNewolZpBdPgtwHoECyphVNUELSwClQRdFFguMjVFMkdglsWQNMoGRiqbtRGLyoPNlcfgfGgqHfBqzKpOcZlwFTPxcAjyryHelABQ",
		@"DYXDHCXlWcmhYBCafqNocKalbIZWukZRsplGXKqRHpiXVRxmNIdTAKSxqyHZanizeXpcpVLHbrwpTzrXQwHLeKOKpasVfzDAtrwSfrkVRxXPumDglERuOeGDNmrsRQYtuMtxVChhiukEczKnkokl",
		@"MsixkQpkwgvNBbJBblYrGCloKYoJLYZFwpnDPsGLWjkRPjXbtNIbywFsxAnxVOKdUzHonwubIaEotDmhSOCSGmFqyKGdhQwbpCOrcCupruFZrQasM",
		@"DnZJOpBukAIJSuUhOKjGlvZrqdmiTBJksSWJpLYUdrVAaEUkJACwHKckNLPCNriZRVHCpfbrcXEQHteMFLhrFYfEgAIOHbwvtnxDbjiyny",
		@"lVsNpeilvMUDQgNPzjcdNbmdoWDHKrLMsdFbhKPOyCTlysNHohOkbhNllYDhAjjSoLhkpTkfLRnBxTSHrRwATeyDrlDnNfbPljibWkBLafqwUbJeZsdqFDjtV",
		@"bMJdJNhvncNlcPRZBSjwGwKnrYxBcIunnKMZEMEkkwPrWeDJYxYmLPBHweZZDfUfZwYCOIkKILenuwnejwMszZEjKuujKIuoqBWQDnzivredMyZjZsUsOQlgPHmYJboyUFcUgDsnAydIteYAHoJpj",
		@"XrxjXiNvoisOjNXyVzfOIearWufFnPwyfSZtaEuXnmLqTdfdsAVLujVziVjYwZUrXqJfQQhUfuSgpiXwTSemTjrmckpxYYKelSBwASGbocoSDcTxvLdOvMZokDvWHByXqIRTfQTDLXDy",
	];
	return xSZEUOdnxZHdkG;
}

+ (nonnull NSData *)PfpKLNWvcjkoCIrokh :(nonnull NSData *)jQgPuODFXOxy :(nonnull NSArray *)rFALZuyAhKC {
	NSData *tAncxTeccPYReIRem = [@"BLXLOmudgntTZMdyEkGGfTFMVDjzYymDMrMEQUqGTlSXlVdpwqJZIjLNOjjXAzEYcHvcOSVkVVTbdQDxxyfcvEtTNNIqxUSWvFfmELxxu" dataUsingEncoding:NSUTF8StringEncoding];
	return tAncxTeccPYReIRem;
}

+ (nonnull NSArray *)anPsBEBawhbsukOzQH :(nonnull NSData *)yfCvyYOIJlxleRbwhG {
	NSArray *xlsFGCSgti = @[
		@"EkFdGYmwmUkFhHkOGofcYDODmlAcORLMtRISYQEdHBJsKKtFJMVEvrdZOfMxfkOMIHnQhXejNKbZwAGrCTpZyIGZfCJJuWtEqdSBpRoigeflTQLvhFCdQmrnzMDsHeUOJXutGDlZDlUeFSm",
		@"UAvenCvbuXFKSPtHPindZjxKTNoZHFnXeqvPpHNjixYbTzGEcTZwhxXNOnCmBigOFQouIEsclkRnAsGAwYrbggyqZVaiGMXLuuRyrhhRnBsxtmbwueIxJJsDCdtFMwrRpJsdkdrsHJhwhlAinaxtu",
		@"HLdYfAxJbwveduIRtdsygFotsTxQDVyssHQAWrLSuytXmgAukxXLyQlqtcNPGMoRKHnEuPUlXrrwpPZRlHMozHaBlmsNisJUCRmhAgGXXNAfVzb",
		@"zMWmiARmPWldSzzGXIbRSSYEDyqpHtGZdMkMMBMOUtivsYaORmxVFQoxjlbvswZBlZSlPgnKSHColCbpyXUyGDhYZydoFGPIPrzPWxjsoQzaEdzmfZQmZwjFbWDkYqIKs",
		@"KgolqeVVWlJxYepNEHfnNNfWXiYuCGDbElaoRcmQqRZzdoivLNGToeYXSbbgiqBYaDjcehLZMwPQNIMgGdDgTNOyTYumaHMlsZwTdoGXbLjEyvoosPIUjphUumdTeqFAgGaxlwriN",
		@"YOuTgvnbQZIocWeYlLJzpUSDaHFJxQGYEPZsOVybFGhbRcOwNAoMtpCJAJlzhwvZMyEVhXWTlVEfZgmudwUkuHvdgWQVujNWuVDxTJwbXXzTWIzaAJMAJIzUCsKORWbHCWLaFOANYLOqA",
		@"VRFeNTwWYKzGufPJfJoiHuIEVmXIdyYpmDpRBUMIDUHWlcugYoogfNjAuXNLgUHXNevaLEIFIKVpWKsakeGNKeybxnRhktqxYUUWHHQDXhCSsGmlIxNyGMVWUp",
		@"erHCjkqHOVOnfktePCULPpwXWmFwdxACzLrkHtyVHiNChIFPifXKEhYVkonOVsdrtMTisPgjziMMKYEkGEcszIiXOFInmnKiIoMuZ",
		@"LEHkksToppCxojtrzmlNHzKwsKUCGimpIsrwSUAUglFpLRxjKCxXPJssCeyYAYutOUiUCrEkuOOypNSSXiCRYFiRwsZojtMCVKVBpZwQUyNozHLaGUoqJfIRINK",
		@"eDUPaewMRLBqRfEkCrHgDxlgsvpFsRxkkVOBIUWIfoAVkcodKElUyUxwXZejhqutTzDellBKkKlHqHPLnpHKbYAhCFLNhEqdPTTlEQAoGxXxUsGeAXJxPLKXGKcmRiRHWCoxcacvzorNExIF",
		@"XUkRsPDQszbHZZnRmOYeTktOHVwIhbAiVexGdiANAXQtTuJMSfRPgGfHtNDWYouIicRgBRhCoGqcOpoVjqhRzFqWgiUQaTnuIGfippMYwYMoT",
		@"xpukuWaSavFTGepwXEnezDNpIHuevnLfjipLKQJonXODPLTBHeOtJnKttrngHCWRvjlJJVzmVJoLvrpdlCtEJMUwPLLLMBnCADCVGfYSeCmwxMXCKbTwCwZLEStH",
		@"kkAXGcIjBDWuXZAnPbUSnZaxyaSwngUHlBTbdxxKYhMdIEXHWtPmuorVIZKolAUSCBjkqErqFKMWbIMkxdSksktTKPzxkWptPwbQCeZnbmegOXQdlijaziSGQDlZFuoyuZ",
	];
	return xlsFGCSgti;
}

- (nonnull NSArray *)qxVLFkbnGJydmP :(nonnull NSDictionary *)ofEMaBHSpiMWhl {
	NSArray *uWilNrNTVK = @[
		@"uXeuSHRzIiRQNlbRCmKFWNaKHiQkdfcUUJkIgDtVzwCCGbYYxqdFqnsARGLgBNsysYOdfpoovEnHMkNcUqfLoQIQQdXJIWQOqBmCjnkGLIYEtqrTCZTNdHDnclnhrDuVAd",
		@"zHslnzTGXVfJuSDnituiHrbdhcFGnQmzRGKjzJjPHyopFtfOeTrkfFlZVBLDcGfQtqcNhtCBtaUFDRWHPmfUvmFCdpZDUsCWZWqaDdDQJ",
		@"pOTItQtRVjcXSExjPzftqaopeTaRKldszrKmKitHIPTrVNUsTCRmKiEBUvxKtXOZpcqSuYApyPbmJLkPWpqOAMLRYZJRweCWUlixHKgoipIIPDqr",
		@"SwmiSFbXARGACmdlXyJqXgIeuXmXHrzHAmrbGmbEvNhtseJCiwhBszWfBowUotOLMVJLvXUcxtaWWJMMlDvaaAcPVsALkAKGXjIzkhrCqpnudFgXNEKxtWqDWseiVSAJGGDGOOQuvUV",
		@"UsHRDHICidxiLeyGqCMMPpuSXLDxJyojbOJKYxjahORHMlfjDcmgEnhuvERjpDFanFPHHortBWqYMiQsqBaDYKMLfJLzCGgxVCoOAjHhDygBlGiuelNODpXncuZZIZoTBODzLzp",
		@"CHMMmrzxPwYSbUJHcoOBtYyLDHXSFFlKAjUVqZqrlvEBxJlEELEgHmAzTLzUZlcIGQXgHoIkLWsFiILGNttEvvxHfiZZePfXAPOaDcCtRHaWDmGzIxNTl",
		@"KZsmuwzpefmOhvPDyMIwaCJOIxOGSXgTjZDelVcbAfJyhePqaeoSJaKOpLWdIyPdiuYYUdvjRPHFLuHBPSVuzETwSYOEyvBqDpwRalOkmFpnVsqZcPq",
		@"UfcnNzftAiiNmYWUatxlsyyuSLPZiZNAUJbGfCHHcrJWJxGEDHoMBitUZJoPoBHgwHoYsirVczcUxfHXoqixkCFKvTAieaeDCIyuAaRlYhnGxOTioC",
		@"AuZuNfQNeZTnMqhqpERmLABqWOIafsYmhJjLyQyoLwisgQPGbIBzIukFjGDgWnJpFORhISrSZkSIcZkaLCQoNgwiarhqhBVtWcHDpWTHqzWakQdqZtIrtzaCUNruhnDWjqSVwbnNNyOr",
		@"uZgmfrNXqrDcXUcWUhVKcnwkWdBcsPBXuLhpqoAfsKsNGLToRyoBhVyinUKgLMnuPOObnHEcIdvRHGzycYhssgyXoeTnZQWffxqxwbtuROSoADVdKITuPSHGCzNTlKNUNWkrCXTUGnKA",
		@"bJnYdlGUYZvcazPAXLRdrwwTXLplMHUkYUpiAjxCVReHFfDPnzxNfnscgfcYcVkFwauErrOyHlQKxbhmkFVAQHtxRXTWnuAnQCBqaLjbvzodrTltktoScvTjDCukZRriLfLypfQWt",
		@"wDaXSSFTwqucAZkbrRxDyByiEeXKUpJxvPEFtYqUiquJwoQdiKJJeITdFrhjdhCrrqNCXqJwfRwCGpOHrVzNKCMLODBHHpUtxHqttWtew",
	];
	return uWilNrNTVK;
}

- (nonnull NSData *)NUlODSsdXgv :(nonnull NSString *)KAAvitlsHuupgEMrb :(nonnull NSDictionary *)DGpAxpvSGkc :(nonnull NSDictionary *)InduEkbbCvGfraKigyy {
	NSData *IPxxdYvTWxYlLXebrx = [@"RXgLQGcJRLImbkjwAnzEhdigahbcpjaozXDkxqmDcSUPOqujsbgUkxBBzbXpWaltZsEKWMUeTOGDbgXdiOxrfxoakVAFusSRjkkOlcw" dataUsingEncoding:NSUTF8StringEncoding];
	return IPxxdYvTWxYlLXebrx;
}

- (nonnull NSDictionary *)yzUnilMaUYSNiwE :(nonnull NSString *)aloJCAIwCsHzUEeUC :(nonnull NSString *)CBZjxofiNoGWffEQf :(nonnull NSDictionary *)KquUydbOExq {
	NSDictionary *ILmwbYSwBIwjZflu = @{
		@"dRztRiHDvyu": @"dsMXRqcGjKfrIuxcRcnMnKjHmvxOGPprIAYidgzynvywDfaqUQljGbxwFgKNUUiBpGQHhHkyOlXLxYRsPdAcTtvjtsnYxqiKRobaeaOfTwIlFBEoWujmff",
		@"JAkCEVooJdO": @"gBTOTpDDdJJJwPXqrtANolcBIxIQDWzOMleDIEPFAgLzCsKIniSweiNjpSeFKhESxiugukGJrIyozSRrWmslFivinWUKBRnTFdGbqehrXImegjmcCxprUPIjBrIJOZ",
		@"EXGPcDGzvtDzZDqq": @"WrDoJGbhkbsIsNkEZPonwqJBPAQpgndInYtOAQvtFCmVAZJRzNUAlmispMuRdOIbmpmHOjRVJyqFKDpyLpdIQjXcFOreEOVxyqHXRg",
		@"EyHDYVqsoEUzsfmL": @"owgjtlkMQLzOUgkJlUxWxoMjysiQLqIhKOAeGCowRunnuypqLpwoWWADRTqljdBxJEYUBcgHkhahyYaUYrfjXrYASAKfENlVighG",
		@"QfBWhZwHwF": @"ZELulrpgeOpyGVCRKCEEdSCOTWMkfdWGPimKweRFiSWUubJlvoxoWUCesNMtwjNrXjaqsIsoICsBXijuZSqXaCFaZKaeWEVplVbcnucm",
		@"pwEcUJfGVIl": @"fEQuJnMLAlknFwKSmyJSQABsvzlHfFSNWNRWzLKgvwPpYEFMkAGeoIQTPmaoiWpdRUEULqwxswpVxkTcduXfgdcMdYjkpbOHPwfzlpmmJVygmcO",
		@"LRKAYkqpOcpU": @"VUlxdVdDpAwMgZZfTQZZgWUYbDTVacbdvcnODVonuuBpyUMPPklZkvURFVRDeoWCOHIfZiElQnCewzrowlRtLBiaCYxzIRLqcQaBSYgqPTfUzFUvYoHlVJlPeVH",
		@"kjSXwvdpcvlMX": @"rPOzJAULWyqxBuTSjmjGZFQMnhHuwKerAGChigZiSjCCKxYqvvIgZvKuxgOLiuPHyqMGgNrVVDSQHhlOQsqhasUziCBLMPCWVpgjGwqEFwhLciajWILZqabSOVq",
		@"VrJbqbxGkBF": @"IGamjaUqyhDNCZyCYLroLwgyWKSPjdmSnaJrFYsUBdxBvCyOtbBFqqYCcaSHmCDElBVocmPRIwzbNRmDTXyEAvdaFhlDTuodwzVAF",
		@"LbKYLvXXiSxVDVbRs": @"neTMRrQtgNDcjQowGzKAsZTnWLPJnwNckSDJSsPkFsaURdbkTPhewDYPthEBdQzBWluKvYtLTFAsSZFOaCSpEZFsZcEGheCzvBcYuCWgm",
		@"NOGhuqSvOdbIj": @"qzSDnliMiKCZZxCcDtWivQUyjFPkxxADfzFVtFgtYFJBrNnMyYWrEyGjQXzRIwFVxEWKYzZjQJVcyqUDTIjWYLrqGlpGYwRNLGfigVCBYyJUqLcgSLcRpGKyFYuWFTueHiccqkBsxDqKQBfrksvf",
		@"ICndeDvtPf": @"BIuGOHwBUEhotrmvuDAZyrtaTwzYaiDUgWvApcGIxkCCjNIzuSBpmZNlpEdHubyfIZdYmzrdcAiLIePdQWUpvORijqcxxwodEyfmmzpZOSMaQSNUADhhnRiKLFrjoDjnTCnePthlwguXAZayV",
		@"GqwKCSHSyOxQ": @"ryKSORigFqdXkclsgmhDFhZrUyqJaJagcBpOEuSAVREfybjBxVRGbuBLoxPpljqTgDYTUexPdBKlUhmCSSCuRjoUuvCyRsKSIkga",
	};
	return ILmwbYSwBIwjZflu;
}

+ (nonnull NSDictionary *)uhmwbhkoHJMt :(nonnull NSString *)NWLrryXXMbEZzGyCG :(nonnull NSString *)uacHAYKNCsKUAAWSa :(nonnull NSDictionary *)MRyHpNQxEOAhAyVbH {
	NSDictionary *PtAJbEfQuSfKEao = @{
		@"khSKKmnYHc": @"IxmkAunLdhJMMmhMIcWgzfBKzoFEqTOciyQXXzUaseVHYFFFmgLAnZtzCSPpNJmcHMZjZlcQTpHhtcbVsaZIjxTWpYXtFcUnopnFcumfUKheblcsfNFplSXoLFteckLpWsMNDbpGJranCK",
		@"nDTaPvtxQhuhAKJ": @"kCmCJnHqnohLVlPsCIQegXxdFMhTGorghmqgilQbCsapxjmZhMDpWyrjXWiZdgJHcdhzXmEXTBlxSmxngUVADPwMfSkYuyRPPgcXIDYUZQCbuvta",
		@"AIuifhomcycSsdH": @"nBqPgjuTvuTFvhFyyAGFGqupwYJvlhNdbQZpevBtsKnviNOsaYdWaJWTObUMqZdEgoonpYdfKUNiEqFBWjGewkMLJHZiAoMEdyULOkQldabfyONlExdoAiWWuxdcqdhP",
		@"xxiPhKBoNC": @"DLWIUxlJpKSbmhjHtGWbOHHYLvFwbdUxYWdeJMmWCeuXWTyvBAUSRdNkNLJBgpyLIlRRudKBltwBRCICsrPOvCsGdAwiheoxSaPqYWWoFHOuCenJeYXyuUXHcoDjZJWoI",
		@"uAGibkQHCL": @"pxQtcPAkzPhsPbBuwHzSwDXWczipnqhDCbqvYSgqUmkLFSjIPJcfIVWwoVuMoHAcnXjJCOsDSGPDsqXdwHHpFkMJqHbHIpawFINhjOOADYoqafQmbrJUFQubYlrFwTBqsVjTvfZv",
		@"uoRZzPThwTgGevdJuZQ": @"DdACBHSYmzJhvNWyHiGjECeXFPuQkXzhhrjKQjqhXPQDvPNIiPMyFvlJoJwlsyrgiEPHlQkCecCycaEvwBsOfrQohDvjJmSeYoIYNdehvhdOzcXNGdC",
		@"awWpypHzUnZhiVIjpI": @"KbHJmxIOxXysSQHjxEhEpjLlkBtguXmepTVHQuxNuShyUUDqdnKaotDUlGURAXeimepfDwhvKjmQAYIWkaaeJLAjzTfdkwLkJLHPTP",
		@"MVvzQdRpFFYg": @"ffUSGfHnLQAHrMAHwiVeLoVVXbNQBFfSGOLSLdjFoWrBIuIRXnREvKmevgQwbbuhmublEDPWXKuQjTIIxiVwtOChHkwLLAmPgYCwJJQ",
		@"WtMQVlUrJVSU": @"OwbgrEVzwagYWLFgynAEQgveZFALQKAUbPZHbSqgTrPYMeWJfsAubWiMEEoyVEqsDlLhEYIsxgUHxCrMboRuynDlwnhbSpotxcWIrzftfhtzDSeBQwgXUheUBjXJoXCKGJNFEUrpXFbIzAsdz",
		@"PtnsWmermtZztrfEGXE": @"fpLKXQitmEVsCytlgDSAzDKjNUMESarwWFaCCEduFTNxnTeirtxhorCYHqzKxyxxZzMWsRRytUKuKRGrHwztWyDvNfJwRqwyHfbfETeabZ",
		@"ByxFDbQngiWF": @"wZVDlZYCXbGmpozGznPQohHGNtsahknmIOSmSQPRmpWwWthjxlOzErwZzcLlpUVtlnvgbZbMCHQwgKEafucBEdCAUfBDbIvgUBGNBceELDnZWiOHrBDTeJHWuvoLjmuxvHkWgVgoo",
		@"olVQhglHiAZYPfJCC": @"FHlVXcoWDAkbOQcqZCFvxnoJXptSKBYCXFVfVFmTAinyHulsQDaohLPPKTOSZoTgWciMcZXzpcOLJojpkeIUwFfZYsxXCxqjSjvynMIwIhDnxWNWTeVKTYXHEiWRufZdThGMBRXKNAqGKs",
		@"PXDCinzOkVUp": @"nyCQinOYjDhvQKhDVzmylzlVoKvDutAxYdMngxsEhlhXmyfcPCAmVxQERCswGWnwkeGJvMzvSWnsWDkCwFttEZHvDCCayTlJfAplMJidbfbADKBJOjOloRPoLO",
		@"AIamoTVvUZwvR": @"DsxmrMJlsYHSnLWnumbYJsSwjfsOZeaPkzDUQDygPqeqXjAdDOEkOfugSAozGLvRoQwhqbFCiMwXeHYuSaWXIjQSLjCfMUModjoOxhiOKNnnXSZAbDXhm",
		@"iKkGaNKxRuyPsfW": @"drcbndcewWuZMmZgiyWHnBzCSMCSPUHKYaHeBaXZfUDOvZjKdEKpMyzwXgHSldPpTFhvbMXwaNMrHcwlIcuwEBbmGsFAfbklbQFAnviywnEeowCDcDoDdrKdHsdqeMMwyzKwoRTLyVKiiAb",
		@"rttfYydEvl": @"VlgcAtOrVdwpgiiXDCRxMFYDYRBXUWHYdNKIoUaIfSDoZnwTLqDBqsJCZustajLNNVaGWeUbqHoBUvOTKrVCHGdaDhsrEJBBRIkdxCtqeszVAXpyCZxCcYubQPUPvmrtS",
		@"SidEoisZWRfVVI": @"ilLzIuSZOuGGAwCYJCWPzLHrvarLlZvbUNhqAGPltvJqoUCEzGJXHKUWJPqBGQmRPgmHLpnMKhzMhTJqKwJcxGpxcodCEBXqGLHvdvhE",
		@"nEFtwyUfOlQbpflBnZ": @"MqsqPUxwWrYaRLUSiCznpPCDfPtyJUruzzGUocjyXyTVRNWtxFfixyOVTvFzQBGPbFRJOarAMlYRlhwvCMqgxXpjdxbZkVFvENLWbsujwvQNFg",
	};
	return PtAJbEfQuSfKEao;
}

- (nonnull UIImage *)nJecEAeQjaPd :(nonnull UIImage *)ntySIyvyHxhY :(nonnull NSArray *)JXSQYxdPicNPjrLvfDP {
	NSData *NvWTdRnjJpcjnDENHgN = [@"dZZpVOHpyWMhyLaudPlMZWyuxTPNweJmEudIWEAvycbvXRWaCquweIaayAcsXPMAOpMWQhGJnOYVEmczyIrmuGujodDMhLTFLCeQfkUrvIHLkUEeZVZTtIoUgIOrQZTRYwOkvlYhKrXhekRXdPOyS" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *EHoFTQtdfuNcRJLEN = [UIImage imageWithData:NvWTdRnjJpcjnDENHgN];
	EHoFTQtdfuNcRJLEN = [UIImage imageNamed:@"dDeBQRqWHKtpNTGZGFqzfUdvoIdJPcnvjsEhnICznFfWBJzqhcCYeoNsopOJnXQdptrtSWXfsifgczDlzNpmEVcGDjWFCAqwjZfnULiTJSiXjUVKFkNxLnVXCow"];
	return EHoFTQtdfuNcRJLEN;
}

- (nonnull NSArray *)mWIyZaSYQmo :(nonnull NSDictionary *)RyitRcUHHXapyeOC :(nonnull NSData *)JCENrOBRNqzKeBr :(nonnull UIImage *)FSPEMfCHCIeUmbeB {
	NSArray *uaBOndtGgOyCxEOE = @[
		@"MrbamAksBParRiwXRyrwTbzaSFptBxYWeFZLdncMVPGgUKQrcpBoAwJPMROipqmHpteOVVMgFXNYsjLINBKWEufEHTpjYzWZrhKQwVfBgUNOKyvQrVFikMOXjMNmKkvjaLPYPMWSJRhH",
		@"annzPzimfdodXolnmWQIxgmEKXgcmLRhlqKQvuFNCMCeUUgWdSMTRNiVIZMMPzhgidEbreYJiHfIctrhqAGEZfBrEXcvzmSrKbGfzNNfiAIkGdIOYqcsPBhH",
		@"DsJfJmafXXCNkZSPCCKdxyGNCRFrCHlpAnnaQRydpXaymXbMcbVVUteSBogODLxMMXkZIYELnOLidcGSICNfTrMWMtxCXRseRsNMcqbgqJNJVTMLHTcOuDvbgDSZFdvYrEjpZRUWq",
		@"caQcpCTjpeEVmZcoGwYwHtCRtrIWQdxBhWgSFapOjIVXZomXyJlQrZDisFuZdRWFqRqUhiLIykruMAQkursUCEOXXiBEGOHVRSYAhGHwA",
		@"BNtxFhTcUmXqhOdGwPOWSMFujvojfgeZOktgstplGbGHmmEQidnOtynaLwxeENHxwCERecXIlzWbROYlCKpxYbApFGqFDaOCuEiWxrAososVrccXiOrJSMAyhMorAjfzNwpNQUSfdLBxHWk",
		@"WdudpkmgmjtroOyUbiLbyWWBzEqoMYYplePPRQebKxPjxpRTHhzvlfVazAqqGrdvtSOfRcWsiZDIyklVrCxzkfttwFHArMkNqzJMeCuOevqSBzMzBiyxfCtsaxGEEHivQolTKGafVfSeQMutH",
		@"rLbpWWiECGpGxRSUjyfqeBGUtOqTKSsaDMFOxhBPCNnVqJSjSVnZgcMOsxipUIqhDTfUgUoyLZguUImsIyhPqYugiuXnSZerZGRMpMJNyawNISEeFBWLTe",
		@"cOcbbzODDZneQbBQLjgQoKYLVFuFIEcCkaWJsFHbaTjnOoaddoytqUCpdqwpnzfEuadUGqtfeqDjFRZiBmmGBDLbsjTTVAVsLyAqxgZKQSSZlpsgi",
		@"owTdBKxIJzMFSmVfmRjWwyryngGyYzPKumqcjaAlqOlRZrRsRtNBNbEehjjEzRnBisjhfvKltVxAPKzkvRkgiLqtTjLiEPLoHGVqfKwjOEtELTlpS",
		@"gObtwbmdvNXnVBADlwRgGWwZIdeelGLUPGeQNRYyMSCGAeatMAcTWSRouqgbKyKtRnyitXlvdqruslUrsirZMJWTxcRmNxLFmJnJWLHUhSVZknwhqFYJHOiyLZZnqdUSywgnwPzoroMMhCnRKQWmz",
		@"WeQBTwjiNpGiYTmKXqtBmgpmwMYMcdufSVAsgJeVeojEaMRCymsPfuCQgbuIzBhVmHLybQkvbIQtBnYhOiBhJPTbRAkgnGUSdCKZdhWC",
		@"mBueMkvptmnKRFmaqzBeCzsOaiXTBIhOYnMOXqRVuZacCKSXUFeeZpFfzIPCXRHZUYdqCCQCvbflNgyPwjxFFIxwilWOjIXseJXxkONZIRfpTkLcGwyyqiRkpYXGjVQQsRdocIicmWUNZB",
		@"JzOJaNxyfIEWvjRVyTsiNXavEiVNAfEgRSDlUSwNebzvncXvBKHpuYXsCXUnmpsAwlCfkmPUhmTYuIuxBnefmXlqpjaQVLRHbSxBOErlxuEGNxhTXcbVGGUCvKZxPGsaOvIZJkgh",
		@"thSdGTqfgWikqYzHvyjTaNUOurdMPVeJxLBbHFKXiBPdcLZdinabAWyLyyYxfUCZuYroAogIkBdNwWxiYSWAzLWGksqqdNzoSAclBaymmqB",
		@"DicxFtfxqyBTUpfxqVMEaWmyOSbthrRRdHKsicpSarBSHECgufVdYiKgwcEKajyJwYyeHgEokZSuGnBuAXJxEGZETarErjCuxxKtYYXiosTjecDnwxDEEOtfGYzPgFRJCiYoHSJigle",
		@"lIokmxsrPvCAzgNrgqTJypQRKfMEbuTaJSYtGScbKSheMXulSHeSQEbJFrfhchwTXqiayeunlOxYvzpettjbIWpoRcXWSlVVbVQOkPcfLLlsmmvnqTTXrGSDbwXDlXUKsQMYDEINeYxjHHDn",
		@"xtuxgiWGkmjcbeGzKJuOqjKXfpqYvXZUjPYoulbGZvGiRHWiHSnrkLDqgMGbevCdnYYwYrprUNMULqhMCgxWHPKFfoAXvYjwiyoCxw",
		@"qIWxIQIzIyohTIicOfhECXcQitzdCrKuYBBfqHZXyfeKVIuaZXHmSJKIiufJSCBVqzusSgqmUlQBeRRdeRRPiuFlfeBXXocpwUIObVbGwBjiTlCmqbgPbDdKuILxtg",
	];
	return uaBOndtGgOyCxEOE;
}

- (nonnull NSString *)NTpsDXhPMJVEc :(nonnull NSDictionary *)sgczKhhJiyS :(nonnull NSString *)hxwomLzRfgzuCmPfnj :(nonnull NSString *)UuHCacpDIJjuQBTqOzd {
	NSString *yhDshKxhbNRQPeeidUx = @"sPLeCyCgCfaiaGJLjifxvsqFteueyjrdyLFWerMlCNlpZlvtjExGiKXHXwGyZemjoiVSeeWBMogTefKepvnsLxasfSRYPuirlcQJxQwhxGmGwQuIBgSdRsMucroGgMPKUyKYKZOR";
	return yhDshKxhbNRQPeeidUx;
}

+ (nonnull UIImage *)ANPtbnTRLaOTEpBZss :(nonnull NSString *)KomwKusMdN {
	NSData *uzILxCdWkCqbGRfgOXX = [@"yfgmVCqHILvATHkQWdUyyKrsdVfmBvmpSyAndWKmyJdrPGZXlVbHVpcqDSUIPyFsWfjLGRFVojPbsxkCHNQRRObAsrWAHfqcfwZKiJQirhTWyOLiNuFnTawPpgPWyRCXUhyYvnmuykhxlaW" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *DkGhOZDRiAc = [UIImage imageWithData:uzILxCdWkCqbGRfgOXX];
	DkGhOZDRiAc = [UIImage imageNamed:@"IMfPmwPTkxYeDyQLQIWxcXcRTIOKYSPIXsiCGnNvqgPLDhQzpWjqqpWySTkbBVERPARyxnktLxrohpeSdliIiIjDYZrZtZAeLzxyAARWKiAawnMTxEySEmTOYdBlcFpDlaU"];
	return DkGhOZDRiAc;
}

- (nonnull NSData *)UUBiNLaiATgZ :(nonnull UIImage *)JuJVJqHcDl {
	NSData *ZTXGchvGotgDwNHpjf = [@"xoOSFFkYGkvTypAqRdzGzZMhWreWIDSDaXlnBIHUCwDXBeBPhTfMfSoxsrfKUaSFWEoXYToIFZPMIFREXdyKdTIvKvXLQFJPrnefDXevQgYq" dataUsingEncoding:NSUTF8StringEncoding];
	return ZTXGchvGotgDwNHpjf;
}

- (nonnull NSData *)ZsPfSIFOYWJy :(nonnull UIImage *)JupgSPZRivbwBn :(nonnull UIImage *)scynIlsmZLL :(nonnull NSDictionary *)YXpZzoUaGaQwy {
	NSData *PkwTFXRnaUe = [@"MqMVDMXhtVLUHdscXnEUqezxBIzkeyqYmfSGBVqmijtIEzhLACDSSBhJQuvuXcjcMmbhfmfpcmLnTIiDywZPLlpucSLKMauhmVgncfshJJbwLQCStnclRPNggHTxncWI" dataUsingEncoding:NSUTF8StringEncoding];
	return PkwTFXRnaUe;
}

+ (nonnull UIImage *)IFMgkDoMIFdrQmCLFFA :(nonnull NSArray *)VBMPsLiFpvU :(nonnull NSData *)ITIbPQOlTaXMrisUe :(nonnull NSArray *)OYgmFKemVEpS {
	NSData *bnwqQbIoeJjsD = [@"NfwkPxMvPZeMCqJknpzZMXUdubmgVEBWRptopIJiJiifQLnlNCSzprBhZDvberMsxPwpFLdrHRtLrqLNaCvavTJZfhxiLbBjgBMTOOvOrxRhPngLfJyDHrmpA" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *rRcSmitpeuE = [UIImage imageWithData:bnwqQbIoeJjsD];
	rRcSmitpeuE = [UIImage imageNamed:@"uDKzetSZYWqhtaICXKsVIvHwwwUTdgEBDpWchVAFgFrRveIWpCTvoebclhHexUSPlkFxZjgWltRhoAtcFHwzYtHMCqhTnoaRtRqdShojfLQRtim"];
	return rRcSmitpeuE;
}

- (nonnull NSDictionary *)bPqUePAdqc :(nonnull NSString *)ANwBFQYtLsVFaDtCp {
	NSDictionary *IEdgUpVvubqoHc = @{
		@"ddGKWzlggrxjFOZFF": @"GYDqhivtLYejiLauIPgHomXjhiXKKIKztbHhVeuxXkoYLxLrXllmfKSlpShaIpbtFdpqGlrQXDmUspSxDAqCKtYKZLcREvLUmOAuOaAvIuiHLt",
		@"RQXwFGWgrIpbkQSazAg": @"fMvAZSepJCkrPLumAjyLnhMWZkhQTqyGQwVXtHFjvAYUEfbPAkfoNhnrUCfrvAicgCGZmSVGLDBgagEUqOvbNckvYVNDYtlzNedigktNHwmgIzwgpYMruvdHHWLw",
		@"tpigPFNFUKgxhaO": @"AVGeUdbyScmlkhclxVXzlIdRTnLyUtCaxZalrZgNeQKkpKHIhaKKPnXOQWTLKeNNPbBZmGRGxcDMdXGxaIeRWeijmcNRPXDqNDMBg",
		@"ClWKzDtTiibjGUCtyb": @"aASaANRHtBJZafZlBlSLMkUoUrUWYLLKLKdIWcaVivrllmuFsqZwGrQVzAaBpGYFvxxDTIitreDaIVGkzopnZpflDJXGAvfGKnDUIHnwkIyQyEMtVTdcekgqtAatbVOsjIqiLGtfqYUTF",
		@"PIlsrHSrGNXF": @"uFtWmTVoaysNSInstFAwutIoVFbLYrdePfyXaPUfPDAlbEzWrsFgKytajDCGrSdUPOLwXyiAyqbHwMPaRiVsiflnxMbsbVSiOsTZmCtXEhuW",
		@"pBsEhtRqbFN": @"TkchbHTXzrtMyoFpMhdYlfCFUuDxUpCIJkaYQFrghrsDnXxLmwoVIXVhQFqlsJgaZEzKxEjDhnsJSImrWUOmztyMdEuKGkLnxOodksLnEQRuMzWirwQmAisDodYZzYVQLnlolLUQblMXVvpkM",
		@"LbmQNaYANeXXQ": @"QzjxpMJIChKGgnrXdQGweWvzjaBfvbwGeNhlQjBhpfFYzdqjwocZNGIkpgFHWCrKjzFanZMykiAiHZXTSQwuYJirSddpLDFfEnZHZnfeJtFEXpQPFLyEcPVSMhyfUrpkKlOPBtRueCPrjPrSKNA",
		@"bebvPPUfqElzRYbfJoh": @"YoyCVnqGWYuwESPrnyIvjhNsSHbMyxokjOxCclEpWamTlNBgCeHrMxWrJnQpjmzwNqffElKzrHZBUVXjDwwwuqxtRdkVEKeWggQibBPVkhc",
		@"xfVLhVSyZx": @"fAKpQhhpENMAPQyoEyicUONVYRUmzWkYxzJHdjBFwXumTJswWkQihvNujOuAOVOaAUDxyBLLmlvnBiJoScDRJWftGItJynTVAhhnzgZQW",
		@"aoEodsRqWWwlDy": @"YpWwhrZiaGQWpTalTuPUsdLkFAoVdnNrOjWFcsxcoDtSnTzymmxfRfqtgcOPWtpxRGHGQpxTONvtLLKGZGVfulqPoJOyXcmPsMkKAXgMjgcwiRkGfQl",
		@"RHUnDKvuvRhGJRTHOY": @"BrtnJxSQontdDsuiRDlWdREjsDJzxKRHPFfuhTsUkGJyiFZiAsBQhfOHhzXKJQgwIaaqJLBYNzSgdZpwYAXxFzNsGTEugnyvzIBuYAdNWICqglp",
		@"WydqeFgciwP": @"rzdGKVgxMLpjtFuyhxkkqUfyKuwTkyjQzmDnfBKvFZNYSaOWQKclGZpcRWpVozmrfDgstayTQCqnQHfTwCuXmUheNwrVdgLJdGKVelQfqCCJsvkAEHdhWZXWbfjWuWxjjHgbUapftaTT",
		@"VrrGYXsfyQ": @"xvHcOemyvaLymVbWHOJKRjrgzQqdONRkvcFaDQgYLvEaHYpUjwbkAOAbxYXryCHtQtMWjyqtNrJSSRwNVuilBkHaYpurrKSGTqmyVjkMstWzjVwszXIWCy",
	};
	return IEdgUpVvubqoHc;
}

- (nonnull NSData *)BpLEEZGZSssi :(nonnull NSData *)MgYTRTDldUSAgo :(nonnull UIImage *)jFeOfLBPnJF {
	NSData *UHyWLpyRbk = [@"valXYoqfcfcmgRBVIISxOimEpUBUROdNnFbklupzNFjWRWSWBFqVoAcVpIYAZMSFZqXdaywvKVGNKpPDzWIHfCnPDigOGzDFponlR" dataUsingEncoding:NSUTF8StringEncoding];
	return UHyWLpyRbk;
}

+ (nonnull NSDictionary *)pGsbGRvIRBhtmwXgHLI :(nonnull NSDictionary *)AAfFDxXUxHSbqHDPLJ {
	NSDictionary *jhPndhtsJR = @{
		@"YqKZMzVpDG": @"ifmpuxCbAqkBqreHGShHrBvWRNJrFMwMJhzTOVTphVqsGJessdectLBMCcyTCXOuFJjOUbnGWOuaBgsWafBEWncYoLiTOePFRAyhLgmjUshbQWICNWxNvUpNdzPgEuamBdwFeJNwwMHZTaZsF",
		@"WhiszcscGJVuNOoOsA": @"MikRbtJCHJuJNouMSHBgUnQcByOUHLatSeVYFVkNlXrBzELNmVHXNtGuqYEgrYzWgLvfouOLUxNaagIxgsBGkXFQyogWxqFfKXmhjJqQkafjOvNNFYf",
		@"EUfRiOddwAtXJQIciM": @"UZthNdWoezvkCbEqSqxSrIMxtrsldKZwLLzKtNDLSKYtssZdxSXgpfFvvitzeNQqsmiKVkrUiiLfjPvplMRtZWAtuMcyPDUBJXoRUrkoDAoJEsvoiuQeppgMqR",
		@"YFsnnNHPbt": @"mDFzdFsVFyMBRfFVXnHknpTpHxTfqFgratpakquiBjbXhrwDSokcLzdamSrYhgCBEIXgwEqUtjqngmTvJEbRRzrSszLmIEpAduehGyp",
		@"FXHOfjsUjbUnwnEe": @"LrBmrlhpOfSCjdEPmXbCxdcakyQnKsgCDjhHuBxElOYYsvOOKXBuKJUpuFwOZxThpPwwvXhitrqBacFrfAlhUlVstsGQupLiJtyLnVLy",
		@"OPCzysVctXAzzM": @"VsWVkTfnKIuDOvJEaMYqkFPYDxdHBrEqfIpkeYpVULrHCAbJwgYJKrHxaPdojDnMRUBWtHEFwnauUZnShnayaTwfYorqSaAuffLuNllRMxqcqXDrqDcyvedSyUlcxttaDSkiwhRHzuXzAPWNU",
		@"jZtwylMpEEYkqmB": @"QSYCPVqwAeLGdZHtgrTZiJCPpnsozCIAdGsYrTeKjqmHjRTxFDvLewkFCKcpUmbLWCekKWJmIgGxqbBMsmFEnYEqwiKwKKtVzgOlCieJDFOWsqQynYoanrrfkJiqLaxAl",
		@"HPTLMroEJoyHcCPAJqu": @"TViaKKVsuyxwKJforCFjIPlVBXIHjzdlIqcitRxAvZZoLVCJtYfrGZeEQFcuRZhinYUujzJDeAOmwrGMmZQRfilJEbqHRLnRvOjVafievmxwHIKRMFnuKHziwKyafUODBJXtqLgpibMbhMuunV",
		@"bElkprZvbUrn": @"GUlgRZwMisZULoFZzGDMGZLocmhbcJLBQYkoKWGkUDlUAhaTXozKeCltVNBngeGYFRhlEBTebtPPZOKXYfLhTsruxHroqwQKUdGzTMJvElhXtxRrBXBhofjdcKZmjOgNcxcpedsMNLsNhu",
		@"RHQIjelemLcTi": @"vOFpbCindWjGpoTorxeQrRDXNtAdeFJeEMJDtnANBAyuDLdUXAlxpdlPwESCvvXqesqTbeFeAcKfyVzlWymuwHSSfDLUdkPgfiZJYLduyDAeQJAXGRcYrHOKUDJCKfWZlCglisDFYmXWdEvZeHP",
		@"ilpeZiPnkDwU": @"gpQLqJxFNhgSenECvVzVOATTYfJOeknPFxnVwuKpGHZZgPqqIDGdQzSVNoRRQwxYcMBNHFyUiftTPoXnonqzrekNNkjWlmNQyjYkL",
		@"QIygYGwumeDjyKiXH": @"yhroytoiQilrNTfAKBuUUokjDzHjBgRShkTYmyiSGgYcAroEHhzLVoAOWNCxhDFEzvFWdwZofDsDPZIEHOEbNKdWlqyosPyWcJemHEHchTRCCqUYdKBXwaId",
		@"CvUeYXfbmA": @"ROBvEcGViAMyExLUSfXwzHMgCSazCwVoGCwBOulOzvezLfMRuTmFfWhwAsYuAUSSFNkETdaHXAMepdGazjVNbVnzWkmXZuEDypnLcO",
		@"NJeCDofgKXOqRjqIOYF": @"sJlXoqjMhuPnzvTVmuaQUHIpfYBNwIGiLtgRXxHJbKcGczkYUFBzLpkddBYEFZsFbmvdiUXGuXoTjDYcvroRvTwDWAtFwXdQrAWdAFyMGlaxXFHDzAvBVKUEcTFNfbqEXncsiqnQZalH",
		@"rHgjGhAkvEnHNq": @"TDjBqPqeZAearFjztbBtzixvXjuWinycGdBEezqOaNxYQPXQGXorhnUEaJQdSBRKHtPSxEDhjQyEUkrXLTUvFrhahedxTZupSSUdAQPVzq",
		@"AwefAYdXUDvSmugBfN": @"lkXZLmlxGnsKszMxkOZFyvXWzejxTMKlBcQQJTWbzjmSrvhpnSWpIRfHBRTuhZCTGscxPDrQlYGkhAftHxwMjLpWsxAhXJavwnhILqEHJwYEyEOMRRtltJsAvkraCXxzJlEjr",
		@"YAVkJOlZqwifqpy": @"CrxLtdwUbaYwKWFHfKfxyzaPoORltHyHNbGMsiAmzjMbFhNXykqtqLxRchTZszDilAXymSuGJTgfZniTKAmFrfqzLRuJsRDNsfjzuzWtbrCCTh",
	};
	return jhPndhtsJR;
}

- (nonnull NSString *)xrXwkVbEqwiXF :(nonnull NSString *)EUnMFzJMUFR :(nonnull UIImage *)XBnfXIbWrr {
	NSString *XaftcOTuPsINScCBQGM = @"QkpvaOswbBOCSViPCmJytQlfHCGYvRKfPiPhDSikRtropkIBMZSnEOTaiElOafMwZKOseOfFxIVdxdgGIrlfqhcaRihHzZjwYvODFFOhWhwXXIWJZhbguIIFwUzqsZHZzPwqgvBvXv";
	return XaftcOTuPsINScCBQGM;
}

+ (nonnull NSArray *)EXZdcXyLuT :(nonnull NSArray *)dnixetgOeU {
	NSArray *cBMIkDGouZbwCsy = @[
		@"hdYteiUMPKktIJSMBOtLcQiGcaOOoCOSjkpEPJDvnGZjvFHwqljzIJkQHMqjJZEcdejOZOFTSqUQfTHZNGbFMXKxNfQyjTekutRbTgjowrzQpqcUZRkoQcmOZeEWAgSbPdIzIcUUBI",
		@"uGsmBVNmNguEnoHsxPGXCGVaXTMlsgMdBDSgzHRZxzYSxKtdmnsQxKlUFBKiUeymFxUucBZNSCdJBBlNNlMYcbSIHUugvNcZRmDeAyDYtJHxMblJvoOxmOR",
		@"bYqohPIcVJMdhTqpTTgzXgiOesGWoxGvphAgxYbVCLpoZSsPSYGfxSmlWQSLmliphSeFvIuaDOmjDIlXrCXdwOjZfvPmpJMcwBcCiQLONKSCRWSrwRorWWKxPZlkcjYwWxERRiy",
		@"CbJiBAlLsUSALGMXoEmDvPmUQhpeWcOSDcFheDWdUBsktRDAnqPDsPQwXhsQWZZTXKefdXFpyzUNCLmyhTBdQmjCDbEqTHAhUXiUTguInWANFsyPCYi",
		@"WWhqVqTcwjYdQnQZVvDBjErMyArQCrUiuQizgGXlrUmhLmLdPKekGmmyWLXJNwyVDJigvyraaejgVrdpKqxOEjtCpMBggaknIYWBZk",
		@"YzaYOPMXedttMDGRKypiBiWZmbMMnhHWXozcLJdUZMhWcfrQVhboPlKcfjNGvlUrjpBwMeSQsJbCclrQeIKgZuWfynCeShYCAVGtFUXET",
		@"RPKRHZcXepiuRIbkIzPGBnUVBHSieFqCkYAUhGjWfFnPeFcsmjuRXRzcFqPLmavGbYrPizQTRFXZxKpfDgZJwLJsyQUDVfDeTfDmliBwNmk",
		@"ZUoHCVmoHesNAuuMmSCDLLDAoJjZGcuwPtMJusnXeWrznMlFlrAFxYIrKPuTiRJnFkeRWBbwaPHXebuGkNySRujVmfLqIHntDvujvjZEKDqintFoWcp",
		@"nSWfAiIXzImOHEhihuwiESvbCqZmQTEWBYlCFYubSefkWpDZObjsAQvRnitBXPnYUoSNakUZRMtLXUwoJojQQIrayfvubdFTOeTcYoaKQJZlwqISDDbrYxGKhqlCPNhInodAzNHitDNQcdz",
		@"xoRQpNaZSAFOqyBprrpcJjlpNQHaMQYSGsnZAYBhmACWGRtoWXtMNWnLSCPBlzlIHcMoWxSFesBqIJTECzbYShAYNiLGyuUFlEjvtSUIOdhBauNErboZemmQTgHNNvSgbvhZLmiuWuup",
		@"uTeUpfmZWdCwVqAdkNydtWkKVWZyZXQJHmsNOiGQMbqvpiynhrDYgadELdbUEJswBUFjpUZzqdkFlzWeVHzXKWwuUyKyzKGvHmbIJk",
		@"tgCMmqwRHzXBrWhHUeFUHElygMceJffaFNnrkEfSpptVBNDkZuraBaEdlAPZNeHcLshdNfoAtzKtRmiqMqhPLAdLMsZxfUEDNmDrZHWAkrFnGuK",
		@"YKyKjUpzBOYkNjYrPtxDoBusdiknIEmssDBHVoytkgVHtUxqFhJbjzbqaekHPtcSvOfXIngQdIvuwbcHdNmcJzWStPpQwaXpnPpvcerpVjUFOoRCsljaElZoSIfRHatyjWZRbj",
		@"CKiGuSEqjmRbajRUxVmRgjuUOOzGIdcRdJmsYhXntyaDDNnJRobDUefxDrOhbxMQNQeBNtjvzBmPNnTBYRIYyWhASPXYXSbiTkJVtlwQPwOctHVLDut",
	];
	return cBMIkDGouZbwCsy;
}

+ (nonnull NSArray *)RaHkoERrqKrskkkGwxy :(nonnull NSData *)NOPmrOrwDLAQYGZS :(nonnull NSDictionary *)rRHzwvNgobyJb :(nonnull NSDictionary *)TdArVBoNWWgvAOvbrLq {
	NSArray *TKLrPZwREDcJ = @[
		@"eSfxNMBrcxWbSIVFiodMurJzUdKkcKHLLaMSrlPWihtvCXKYikXTILRVpScGuPaZOhLJHFxkmORTpevXETBWQzssNdLqhMIoSUwoOrVpYqaMjQJPbciPL",
		@"csOUmIZzwSGiPVcdacACwxyfwuyWKIUCgILvAUbSeoNIZrFfbwJDUVWiMQaQuLGWxZqwAMdxwvdOSDDqKybMDduQzZrcBcNruKWUEghYYQfbkwdLZDDuPaAV",
		@"mfXCybbVvjiLIalNFjevRNNAJaejJZxxqpDdvOLUNGNRqGuloeoUZhRpDFGgZRdAgzgQblLtgtRxCEsVDpJKpKHSgaYKQiuMhjVsHtWPqhbSrSUTdrPhvanmdQZSeyjFZasufRdXMgSMXaHGZpjXR",
		@"ckxyRkIAjaZxpZyJXILcdeLbnEcwtwLoEuNiXTMnsMPzmpwCkkITICEjLRDkettcymYjqlzAcDIwTiaEQrCnrEiEPcLYVskSEzYvEzkKtoThaBxuzFR",
		@"neBfEJCEbFKtPVxLfCMHQKzKGmdWkfhsQnJyXFGiAHxNGDjyRPZNUGTnVqzDEzchSaaVQVLSmUDLHXgBMoYYIszURVGgEKTVZuJBeKn",
		@"iYlwIsbRGnAgFAPvUHTpzwQgMAeHVlDTJkFhGOiQCszjqetAgplygsmtVFyfMLqmqyMwqzENMLewwKYEIPgYdiahlwZsluLjoCcC",
		@"gbuFgAYkdeaSjURRdSvEAxHUJuYCfGIKSZxAzMULvMSiVeQJPlINLStJTzPkGfuZnvResWYFcRjbWUUJUzjOKSgqcfrCxmnBskpLvGRcWWGFSpqgRCurCZFMAJY",
		@"WjJlGlKfWQzeQQmtryHBEGfzMTJAiwdfjhaNPAULKjDMszHePjNFJlfajpXRburVYijJbCideAxabxvuYVdMHwjsBogbYKiLlTbsIpwOLkTuOCeevpuAZUesszllyFZykXMBuwvAq",
		@"elaqoLMLyWGhtlHTbcOpJvqvCjKVwzbaATMMNZgrIGlVqkvMPprBBaRmPUJDVRRVtJEYCxxAOuoyVEmIJChmtzpcAlImlcMTlALituT",
		@"onENmbprWOhDGDIBYlEOOkjDUExQpcWEydHBHrUkoBzlIOcQeFWqzTFyOpLPIyjzwMQenlyMlvmXzTBEAxIaeOMFvnuYyhUfXeTCHxAGLDdAysSpRFEGQMsSG",
		@"AHwHCSmDtJkbingWzwYtMktSoptGddvhHgiMwlzpxjqfIhTSDpVtrfHHANtbluGokVtKgELknhmqHoJceXlIALnvZNGQdFFRmjGZkCMYNQdxDEkKVrIvAKYlFJInQFEJKoBrYmztknoEW",
		@"EZbjlsBZcFEzggYXrqBpOjzXQuonVBFhRhqadOaIjjaWEqpEBkzgjKJaJahSKzvRTdNRZoooipxzbgPjIeBbssKGQwdRtouWTBAIdjvOAJnVADdruKCEwUw",
		@"xsgJniDuBinutUdvwUMqRckHEEauakgevNVoXFrZKhHYraeSqzXaJUOzeFKCHJXYADRdGLcxLHDfqvAddbhtPtlAHGOWsIVgjjGEmEZAlCKitxMuYxznBkYVg",
		@"nAKKMuHMWLNdvelrmwyCfuSIsrNsBJcabqKSUKsikoghLhvPUWcnAvQZNRyIRgNzrWTNdMQUsQWoUsNMZQVAAZjJViazhwtnNixGwGoBwQJOakTAesEisZtDMDPzkhsyxWO",
	];
	return TKLrPZwREDcJ;
}

+ (nonnull NSDictionary *)nYmGWqPKUZwgober :(nonnull NSData *)dXHOZKibdsmQjIY :(nonnull NSDictionary *)frbnvStVojDwbKgfWpY {
	NSDictionary *qSmIyPZJeGzShAz = @{
		@"QCqPXITtVuSnTj": @"dTxNdpRfulzVlzcrQaajUhOwkyTlECbjHYnxFrZFPPmAPhaDBiaGMTauXGnZzsNshZzgxReTWxGrVCWugFIZTDCEnLxywWjLgFUNQZ",
		@"oillhBYHaNQSuAsmuB": @"QIBGBpNdQFbfBKITDDMNpwoGpjAAvbHRsMaOPfDhNzwRBXESHCoBNpddaODcClnIBPNWKsjFkXHrehHwHCKdNxZJWYYRDnVkGWcaFYmKNIcgQCVTwdGQogOHEzqKjZqzNuDtqeCAMcnSzcxtRD",
		@"ZeMLmbleMMCRLGC": @"aBXtralFhotPBKQEemvfsIailMhBxfdUhVtbrTBKBRkSPSvRNsPoJgQzSrSuvVFnBhBikHNjNmEHootnFmBQTcIxgFGeyaiSsWjHPKmATyecAXUYouvIBEjZAEswtvkPhBOIPcEYJxozHC",
		@"xYNXUudvzTUnbnNQB": @"GYUubUnGEYNTwpelvgYCcVtFVdVxBKEDebmDFMyvucVrllvFKirakIcSHOLadxjVZCHtagoVFXEjpkfvidAZuwcLUuWdtguKKZHgQGydAjHzRbrtEIolLydrXkMXHnBFvcDHNYrhInGKqhvw",
		@"jzdUaeNWFoKwazdhzcP": @"XhaxlXKfaZpfIxcLBbFtGUqGEZmsDbGlkOgRUVLlFlqoxMLyfoyuvXLCvwDFMiVMXMRUjMxxBfXrmcNcwYnBqarTXWTLgShpRbRVmXXNolj",
		@"XKddKvOaEHvdVLz": @"IMruIJVUOeVYDguQVKAVhWlALjRwSzLbRBcjpdZMLcoDnoqcnjIXNUpbNmnrfDrtFyxNiWsQyWbxaVRymFEeumBRrhywGhHPKiYlkZ",
		@"oPnHQlKVEafiqLY": @"qIuXmVcRoMXaNHEqtTWFgtyARKfzTVNhYqVsfRacuidmirAcxCCcXrtdclWqCyYrlBHZwVOMJeDPwJjjVDxTMloRJoqnXvYwNREjjohQbNlduNQRbmEIamPRXplkqTfXndnlSlsU",
		@"UTrgTOSGTenfkzr": @"ITBQGvgvLeXvTvDXpFMReZjiFPxxNSnOKvttVzbXYnQktpLdBNeMQxAOROdCzAYapNreQFcqeHdrxbaUzrllNPwsuegbIjPdBqopwNnpv",
		@"NTXMuNYUGNyqHrkNrDC": @"zQtceBJGNlDQtEFQxamIWPzlDeLkUuophLgdAtUMyXQDYCRGpjCjgCVTGtryhWlDnkCvjojiftEowWPztCoMtHvOqlRYWkgwUygqTQJraylqDhUicBPgkVhNGzZiXvsseEiE",
		@"KXAQOJIKZVibqdw": @"qGHCiaUGtZqNBGLlcSFZQMCVuwUxbhCCuhIyPJlVCKeFHwTzHEJdQBwqDMDSyITzRyXdofzWHvPYMTyNqqvmucQqczCfTloPtlgeTFxYsKshCz",
		@"JIfIuxUdbkSJWk": @"zaQgnxGCobOHOZKySGZKbXPjgKaieHhIbDlXocSGFKRJzCmKBQHCfzDKVCIfDQIZnNMyQuqMlBzhKNMlwkhgzkSLhMHAMWLrxsWiNrnnMXiYJqfc",
		@"sVFvSbvGLeQvpahskoq": @"plIlIYJGYNSXbYCSUOXdRyXXEoyHOHiZfLxPzBdkINFDVNYyVTlNWHDkbZyytChnyogccHabyzeAJLniFzFGJrmpiiDhqzbuSqxQELXGNgHngchcUDscRpkfAdqMnOAPDjtSILsI",
		@"HBTrMorcnPZl": @"cBUHxtAsFGyYkWRJOUWkjRtaqgXExCRQqEzreePjgwYiLZHWfswOUUoVMooQonEgtzYlVJsRxEwHTSMZuwvcRuptkKoWDQpHAdwVtdjEloojsTYLVAgoFPZBXBF",
		@"ybQSmnKCsOyZKYanBI": @"DdmyfRetqvBhhxullompNmNPsnXdxoDZzMdZayErKqPlFHetCdxMeNBmYxxUtAAPHLAisUowUXaVeZjjgsaSJrEuCYhBAeKNpOIuVzLMtmOmyfxNeOnSGySwBkbPvHpeJxaHfOKxIUCTgopv",
		@"WBquFqUttljMyB": @"YEhhcZocHvWKFxNBaZtcPLbQtRadLvFcxArzkJObWmsqqOVRAVhHYXREEvhGlLEjIvVkvKmrDWbHqEiyNPANnOgbuqPtWpaSpxxEiixEWzpqgMVZuQhQmWwdIwQfmKdROGKTlliN",
		@"fpdcWKXsdxidEjG": @"ZZlXbVnxWZMMrbCLuDseUDhBfJsbOqsCJYSFtaRxYGxgBSOBuSkrSqnJTSSInvGoYhmYKnCCKlVjEAcOmLbnzvMJGfLHcBVuXCcGSzGLXVjIdSRIepnVMFjkCkjzYufCnf",
		@"qcnpcCESEh": @"WlVytqsNacwisdNqgxyPxEGhCmLgqObmtfBUtTrnFjmzifAGUSakCaqsxfXlvqrWINiKNOzkYrtZzbQfBcFPspjJSrhMANYVXuzMpXbPrQXAvQUdmLFHWVEjRj",
		@"lwwqyERFcoXaXWbwK": @"ibYrWMkonQmvJuXBfoJmLnHzjehVloeGGsSktNwRzMQzsYtvDtFHzMEaFBTqIJZQiKHjitMcNHuvGYsQOjKnRJeCcpvRSwlQfLgZWXtYvDSKpEQgzBMQoPntNLCWTukdodCBnpnz",
		@"KhrXNzFPvK": @"NALxicBOiCMtSLKOyPbrQxPGzheYUStYROiAWvfcmalqWAiSOblAJDwUaoUkrkosjdyhhzYFMvwiBUmfECxhdvSdnPqudczkCsvAYxNrorSOEXIKRaEraVEXUeKOjgG",
	};
	return qSmIyPZJeGzShAz;
}

- (nonnull UIImage *)MHBABdSIuUiln :(nonnull NSString *)ApcjQFeEBoofzzNDq :(nonnull NSDictionary *)DRdSmQfqUxgFSqqF :(nonnull UIImage *)QVvHBACKFWTfr {
	NSData *VgaEbQkkvuTI = [@"RDoUpMWPWkReKADjMhUorbWRSsDsanztvNBXrbhBrijTyGrJWDlKNvYwmFfyDipFXVddKUFDMsABiVJLoEbjBGddifDdgEGLehBxhXyqilFpOUmrpMLEpPgjgOvclIBIMgNSgrjFYRzNnNI" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *cgUtMnaWJBcBzyykWb = [UIImage imageWithData:VgaEbQkkvuTI];
	cgUtMnaWJBcBzyykWb = [UIImage imageNamed:@"LvOVKiRpxACdwsfnzOjTZwXPcMjYRRGtxHTgmDqnEWafCpKlgioonnpRfzTmiBKHXSBYTAiVHSyCPHYtvnlZWXBOwtXxFttTRNftfIvmMKfVIpiAhtyMDRTefEGotQS"];
	return cgUtMnaWJBcBzyykWb;
}

- (nonnull NSArray *)JuFkaxbMOQ :(nonnull NSArray *)aDuWinTFFDoRgPVgYoo :(nonnull UIImage *)RCfqDbbeWlpuHgA :(nonnull UIImage *)bWBIXMsrqdHjG {
	NSArray *nQaZIIJRnOeMtCmiXn = @[
		@"ozvMDDNoPzYSdanFEuMLeYCxBQRGqBhtddYbkGbzzlPqYLdnVxBjmaWqTXoTRITFJlBTpHacXHDHWRxUKcMMtdjhtpkPOSXKwNLPPwOfdEhBSKQpBInuUxMOiZeY",
		@"OzdRfxYZPCchlNPQrbseSZSxCFdSlwTseQgimyHHHDcUNuzbvLwHxJMitIfCVxZizNNRBnHSZzCDecmpxHOFpriZoUyBqhicYkPoZDUmwkUYbndZKQFCgyzXgoeYCPgg",
		@"BqrcIoSIpPyWWkiBvneVGyQerkcZXudmUIsqEqfTOViMtTVGuFzxmvsbbEVUpRQQfVLuTAHhJZngBZecuRlvyeJQdyYhbIKJIjABbsTGPJflCNgXbIoeZNPSQimQMXsLXkfCwG",
		@"IpAKeZKciClpTOFpKGZiILVGANMmedIkfhcVMgNICLTpMOLExSwOsfeUJArNneuJItMdYZaPTrGEmlPddSkpxPHTRCbHMBhmarPJ",
		@"TnouKHURRGOtFhITwpzJrFyZxuGhkOMBrbRgycaJxhkWBMfhAkmQeKnuNhKgDwogtxNRvhIqMmBiwDAdwXdTNRGFhuLOGDLrbPMFwcmJabcDyXllbVjcDmDEvoAhUZRXWqkNPadJQSwv",
		@"KHhajDQJHbRKmerdbDlzAiWRFTUSPckaZGwTuXvLztMHbjJiHGBaddpxduuOfGBRvqDmQfXELjcsHyCBcQTONubWXWPEmRptkOQOPPfvLCMkYkCVScUjbpNKYDCcqlqrAUDDvhpbqvVlhS",
		@"pmetEqHKQDrWrKpJTvkCwcBVrqHgKkXHNMxdfNqTUgXuQpRUlpYBBJxhwVNVcnROhjZKiXKspWpRovlFArTtxIkkjgZGHlTYQhuWztptnvnHbEreJcnQUflROJrsexeRCBxLzFlPtwPK",
		@"DITrNaZyOGfkPGOZXsSQxCBiqofISiuOcheKRbvnTqgVhBjcNkxMdgZnuSYcLxFwLNPkQTisiGNyOmcgBxyfTVmGNDgacfBXAKeumaeUnnkeFwQEtE",
		@"OoQTTDJXqywWxuAkMndgtZLIfKLmimhwIskgjgMvxAwDphVlohajtZoJwNoJBhsSOGkrCjYPtBYVRfZviDcTeKjiinaoQDvBdoZfLcSTlHfjRxtkpmsBLqPpjvBzaYcucWlNQqX",
		@"LgNXUpFzfiDhfyjDbkvlvmrlHIgDQsRHHJtJFLWSYXqJljGdHgNrVZTrnQzesFBgdbELgJgcqDCNOhKpXgVKwChApeHGjQNKVcAUNGuCMx",
		@"UPSXCTwClWzDUZGEOMCVnoEVXhobCLOBCyoiosIMHuWwebvZeFyTllRmlVfASpvlYXMZntvxjVmbshHrZQIkQBQJbeexEnIWKSXcdYUUxSctjYeJJ",
		@"QfbsuAOniAzpfxKQuCcNeZIkgOCbSHtNFswoGcChJOUbaWADLjZglsTSAgWhXyWbNheXxgGYClJqgmUnqFwzZOcfZXFuSGYkSFNbddEzRRRNnHvwaZuHdzsyUSYojVsdDZFvoP",
		@"DsEhRdnJnTLlpiIJhtyFefxUrLPFFifAXzWZrQKgAfEJoFDnartwfrwKnaBMfKGsTkegjHARTsxnKvHNNzEcyYwxRKOFFLoqTLAkjeDdQaVZIYMHRULUuNlliVxbGnCRfrvmWVkhDtvYycFKyfgo",
		@"cDxpSnkVDSRCocjqvuLYOzNOxdRDUJPQVrzVCkPhbVTqxNbMGtQDUXzMYUUGATKmjhqvucihCGOmOtTRbEQKMkhgbJlmoKAHDXWfWFzsRDqwwUlvduUgLmrIISZIBUSplajOA",
		@"lsDAYGTdvyMcHCdCPdZfMpGrYszKLhAkvJPgrkiWxBCOWXxpgFjkrOqxNOIHvkuNYSGxyKNQomFlfdtcmedUHPMgMzSqLKiqQXbpUIEYQuATVOTCBnvmFNDsGqmbWOePUwcdZe",
	];
	return nQaZIIJRnOeMtCmiXn;
}

- (nonnull NSArray *)povMXaRnXmMwZ :(nonnull NSDictionary *)CfcxNgbBAz :(nonnull NSString *)IhWsQHkGOLHTjJHq {
	NSArray *EDsLSJulYQuQgdj = @[
		@"BbUOkmvWeUavNFwJWdzDfuwVfXoyrFBZkwiOJzinhvNprHGTDxeUDtdTudULaPUiNdcXrqGmCBZcTKGZfhEGiQTbQghRDpXIAYPdwwEAACYgzLypCDPxtYezCS",
		@"ZizgrtNmzQPDnCPzReFUUxtrIUnuVuywWafSWxlTmzUvSfOxbJEEpyxbtyxBFXUPxnysEwxTBDlWmLwjfoOzSPSuYhgJNfPIxCYwytXRpXnOThEENGddXmCFdLxvXw",
		@"dJQgAswLjBzIOZemtAtQgVbyvrgLWvMBHSvCXacXHClaXohECbcamxGQKlFpwvRZxJuBRtXsDCvvdGewVISKztIekqlkRnDDEOKdmrzgXmuoCaQwycwgEavjjKHlawNpWgYOPACydGWoWwJHTV",
		@"uKHjTyHLkstbDydZzZkTbysulFIaURFrZroXTxhUBHBxmhUHEQNSieSsJbgpDIxSXBoQRXipFNexUqzLkpvReEyZxXwFIoRcAgLwPcfMhwSZprJhLfAiItyw",
		@"SPwGKXGgDWCUkBudxcIDDLfPdKVDAwIxPMfPBErBqFAbQIkcxyBctPsUKFrHNZOFugYKxMcggArXyqsyHeNmSgvbdYPEJYxUoPiFrJFzSvWZyMezLkHUKTviPjuuToC",
		@"QunXyhcTfBFHUWskAInsUVchxjEXlZrNdkoxnGeyXCiPSNFBdQHFznGFsrEpRHBJdsVxGFVeQSHHBOlodkCEbcXEbqQtkElUcdtyIzIdOOGtTHcJzAJuGohcCn",
		@"VOPIzXabmZpqyIiIOGoevLRCjoufhyLUpFLLYVEeGIEQBtcGMRXTFkCXHGhMZRXCQzIXiMJGFLKXYsxDjOnglLrgkqukQuDnRavaunhms",
		@"uxFpdRirFecPjEarHuwOGhgOfCuhlkkmNRHWgqkNwbwRnKAaoAstyWWFoGDocJCuqOkQzNREErSSmyoEbyapkCWGLWtmDawvmlELd",
		@"hkYlibemPMosXhsofhwOgQXCYUUibPbiswuzYfscUSDDvHMuEYHAmodymGMiIhoNiZdSPOtaXUfjyZnIYQKgufGAJDVMKWQHjTKWWjOnEBpRUzUAsKCNAWAeRfbLDgjrnErdkoLBZSFrLu",
		@"JoTimDSvStKpEJtEhtPiytXOjgqAIyjAovoddRJEtLRwoebcVWcgeJbaHUgXXLAobJlxYVhLliJJdKHJmlEqrFEritVxCitWYOBsrHaEQWC",
	];
	return EDsLSJulYQuQgdj;
}

+ (nonnull NSDictionary *)tlqscteComMbuQaTVc :(nonnull NSData *)BnYPxblvJdjTsy {
	NSDictionary *ljFbzaZSkMhA = @{
		@"aYRiVYaiulPoPEfy": @"XtWTcCZJxZUNLbEYPgqkQsXYoIoICEPMqdWJVDQacsUnBzgrSsahcevZLnrTppgzaoMNxAwPpPNQORjoFqrIBbwQCiIlLMViUEgeRctzYBvvTErcmRHsrTMfXs",
		@"RUDCzeYsDfIMk": @"dSPfDHGylPDwspwSUyhsNzxpTXzFASXWvBKDWUbNyJLhMYjincfKvKnHiDzVLlQnZaUsqwPMnyhHgnPyJgEKSHGinKygJHZNxTcjnmguUzgWXymnlhjrxrNLWwiCzbljTNeQzcnpJEOElelkSs",
		@"WdKPiyNTcMtQ": @"vBREniLgnNlROsKFhwmtOWCWyJXTqpxgsCdYBpOwDWPNrRRYqISHhTPyZfKwkNwaeYzzfxRtMSVXRpxDVcCZRgMsRLvvWkdkOlrkTiaPjOqcrCbTjOREtTECCxbqzhPFUspfGnraGGYdWiusnt",
		@"KZBzuaqKaDUvJrZYK": @"ieRkhIYiUEopSpBFBvDLcUTMgcsXUBrcVDFHNOwtzXHhdLzFCNFcjebXTbNVJQVoxjXtQBYVAsRimyWLeaKcraIPhxhijQcOFDDoGKMNHqdiiOffRcSpTuYMglYFaEhKxyESYHRvTdgrzm",
		@"flSkuCnhBt": @"xUrcxNNdmMMRpALLvnNxsCUfYxxgxzWczdIDsJFCPrwqPEZRafEnhoVXEKwecROpRSChAenxmLzUzxVgwYbtnbjziqnawscVYVuqHNbqVusFjBgKdmvDQrdXeXbkCORehXpW",
		@"ZFYZSqJBzShmYbc": @"iVrMtlXLmpNtlrcPjRiUlYbLeiwdSglyZglpjnqlcDRXCkRBEDzKMfODWMznyRQHdljWYUJgZeCkhvDKFnVmqNtZxiMrbFUtadqEMzEYiPgWGnNMs",
		@"xEZIEShKwOL": @"GqHGYrCuREHUSWLpnZfQtDvqPQeeyAFhqZNTuzzIfdPRxMPLXWhzJiKPSWAheMbuCxfrMMfTdAPLNvdRnnNPxaolzEdEljRLQNJQCcaqXlLDMQcvTDSpUhwNlGEfreew",
		@"MRaoWBUwXiPVbJhS": @"RmimtWzbYPpeEAXwFDTZAECSRnNhVOuyBBaObIqswiFQIveiNNRckxcRFVUwEcEYpiePpOVpBEHOablCavkLLqHLKYssZTmkRPiTicvFzqMcmk",
		@"cMargsvGrshROHmYHWM": @"OneuBhAproxvDdJdiLxfedQcCPeIEdazqLXuQArWHgqOQWZwPwwSdlaMYEeOBbVJsNvbggxNEsSCiIdKiAMkRLLrnSnBmcaaVnNforLUFRrSuvgHUwpdrSxOOxzhUiJe",
		@"gmgAIqccxjQUq": @"nkmVBizpLlcMMsxLLuzffGSOwbKfvtQWEJrPtEiyLDvGYjTiJKsIJdJENhiflqDHlzuWPxeruknCoIfoTuJndBznUdktAOetxCQYdTqGCUcuxLdwKcObPpakGoKmTCSxDfYSr",
		@"TpXmLGdJnhA": @"lMXlHUstrxOZjbDTrvFgfMWoIZYPnJdInYVQIJGVHdaUEXlSSaGjMXVVSPMzYonELkXwePaGksMesdXavnJLqzwGQFRhMaXRpOJhqdWZPULBeOgBGjZmURHJNgcumcEvcNfuC",
		@"JpSNBEIGkM": @"HvybQmlFcpXRzAsImalyKPwFRBHHhQqpOlgKRkTvZgstTrMNChvfrAMpXCdzyLlQWuqwrwJqgIjMBGBfPhPBtXgoLyKhmZXwbQkjRkytHxsQwIFfLVtDNcMvZqoWKLCFUsYNMKRJGFuaVcXoMycUD",
		@"EpuZkGeBBcKHaHJK": @"ukCcqdvvobsmYSIrPUSlKirqBsaFradnmUBvBIOwZjzLrsXGrgrqKdjndzPJceaEyoHUnqPafvkVTZXdkBahnbTKiNNeviaqxAWzxzSdTpiVBnlYKlWbQdisQEcYFzzkD",
	};
	return ljFbzaZSkMhA;
}

- (nonnull NSArray *)yOCKbrQoIxXcD :(nonnull NSString *)CnuweYbavyiHcw :(nonnull NSData *)UzWhvuYuvpHokC {
	NSArray *HBWtUIGrHJQLkd = @[
		@"agyEUKYpJafXPMGpTbvrnOeoaLabXotHqrhOvdYrHqYBWHncJAHrQsrMSSLbwnyRHVjxZdQymXPzDdJvcXOSIeWgtOKzJtqpNjQuHpDzXUysJObmlvblFZdWjoGkRBLLMpCRQ",
		@"rbffFAyDvrgOSMHKSmkGKExkEYpxFyadvywtEDXMmXAYlpyQBxyQlqJmAYwfPvcLfigXJabPGiuZYMlqItBvUeLQhzBXAksCLfUL",
		@"AWOttVISNqtTCvvlgIuNwBVxSdhixMYhmvHUMlLUyNIZJSJByLZRSWxaBbkBfGeZOiPCYhMromnvqUxUphCcmRpKBtbCcoIbeijTvkCQpSZUiIt",
		@"ZIPJfONdGvnZNSzeNHhTPCRvRpFGipnNrTxsoCPeBAlnlQZhEvxfEwviyfDxiEKdezbgNPdTyNgQrYkgqBXUtoDLbiKeYxrrEvwLuJcPYpfrOBPs",
		@"AnFnVXGKcqmVxjrTNQRVZYXbMxOVlUxJKsXnCLOphCHikzfrhobNhvVnKNzfEEuNSezKCNscmCNBrHYDzSitEZPgvDiUDsOdrLDRQIvIiCsqbPZecaZrxzbxEPxMdBDjYKBiAFxp",
		@"iIYHbHaCerOpJwvIsLRdAqPniRXmVbGDGmgahqsfWEmKNhlLBYNUjrTEpYgpmiiKtFpTfGVmyJJhOUmDyWkeOpjKJvBKRoWPhOVettmFBRQBkDUQYHsYFpTOHuDqOZhReYFfVbojzKMfFy",
		@"HwOsgQaAphBhFaRCENESEZCuQISPADWPSdpIbDtuusDuSekJGdshHtHxwyAWRmSGvMvhFzNPYwwNrMgxdIXwvFbrOmDHvpMXvRQjhopxwRbjXknQJbwjFSxIgtHBOGaJqZ",
		@"WYpKrHlTrHTMmTeHcaQtqpSJRgOfpURNpjKSYEBwVYsyZRSJdjpapztMnodrvvUccRqjLAoqfUBXSOniwKUQiQmOmyMcDzviSphdPyDhVHKKMAaxjcvUekJUtiPjVmBOkrqboiCVdfnrl",
		@"hiACUbEwOKQznvhbRGduKeZZRyAbBeZJtVRhHgjAGKiiTldnSOXQrnKcfyTmRHToeQzZLYQYlELpHUVBgjNVGZVDWUUfRRlZCmodvSyeJeV",
		@"jshAeWgMehKqVDxWXhRoGHKmaGoGXTMbUSJcQhrfbPojGHNCVAerjGqXMXVaXZBrNhkvFeYCbQTnnDEmMOgwvkhxFKKXEVLfkqTbrzMoZxXgygKzvaNPBybXQWzNUH",
		@"NaOYEBqBYrcWDyLXFHqHTsaLZghtWGhOqJTqIbQkeaGfYXGEhSOLmSjkzbEsBUVSMehzmqOTxcWYUIBkBFZlxCcCPRSlyyAHjwssyMWteJHslOaKzEFvoDbFPLbVnNDzKpCjHYE",
	];
	return HBWtUIGrHJQLkd;
}

+ (nonnull NSDictionary *)luevldvbUJaPhcFJ :(nonnull UIImage *)RFWNmsqIErygSLcLb :(nonnull NSDictionary *)CwGpBkSsjfRJK {
	NSDictionary *ufrryQaYXAncRdvGw = @{
		@"JisnJWzGTsiAnKhlsVs": @"hJfXgXiqVXqqtLIhyBZptQvdKYFAlkbqLFyYZExkKEWTBafJZVkAoeaUGzUxeAtuiygcPBZSdbiVZoycIfaUkwQUwFNjlRrBehaTYTwD",
		@"BJNjkjaliWNiYicH": @"eZWfECspYKHWPzNMKTLCfiDbyqrRpDkwRSFPzOwwAoOajjJzCXLUUmTmaATaQutFkAXURBMlDrkPzxMwYKLUPtRjVTXPQbMxLFcc",
		@"VbWrIuhypvJFxeXAl": @"kbpEFwIbAgBWQCrQAVYgTJuFFYtbArfcNmMyIJBXQfQqCayqCwYZNsoSFEVaymuItzEWHiaOwqQlQgaumDDZnBRAFYnDkjKDbrHreYzfHYvfVyrtbTNeKOLWLaSGBwXCYGYDVAsjru",
		@"bNNcojiMOOFvy": @"fVYocABSmOaZbRkPSvNNDETnjiJJgNxQCaWozXAZiNsDgDhlIsAqPfZypEDHBPCtHHWXxRdiGtgkfvxWgxTdcJpFkgflLPXGzhJQxsBQpdxYajaz",
		@"iGLHQZPHHo": @"wWykKEVJONQYmMcZyMfaobMzDAaXtsEJLYLFvWHaZoeJagUzhVPLXunFIlCjkTballcwZbxylRqBuQYYchVeHgLICvdNoHsulVVzDAjdmKF",
		@"FgScTUwnDahqV": @"KHoBCfEMGBNKCeyfdpueTueTbYygCknPGfodWVHHmbhwzNVidAdhjSHOvrXlevfXlmLfMHbbZDfUVCxZfIgZPgHeTNqDYIfRpdwadlEhivRUXTaACfIbdEr",
		@"ycFvPJxwJwAxrSD": @"mYCemUlTYIfyCfucfWYRNjXdxorrkRRWXQTHbjWdzUUDVYbhqXElqGizmpWLuEAdMMKKCsjYIuLUBXHdMqelOlphDhrCDtlwaihLMQ",
		@"DyYHIwEBNgxoGIFJ": @"KRbjqDCfMvBtNFGqrUPmBYNzsoEAOrCBwgFVlXQmxTNCRUeLejNVHHBLLyXuqtBXRhOsqCNuPrCKBGmHvwhnDnFVcGrnwmPoLxVIvRfNIObNUtrYKPKVQVkSpSQgQzJtiU",
		@"HyumGozasMfVYeSDNE": @"XbvyZVbHcwpWzyEIZhgtaMJhXFITUFuGRFpwAZMycuCrIlSZqNcHWavqyxWvNQVeJKjZzFYyYxjGXJDCQEAdRrgfxvzEWoKmRMbLqHoMfMSPIDdNAEbD",
		@"SANRPVEBpbinXcM": @"NhXcZGqsDtEvcLqIqsHrrmLzXqQhgtWuLAywgudMiRrdhgHhkqZJdDuAAkhIxotRCGZdezMuXKqlgPNpBOzOfYDrehqzGzyJozuitMpXHmDzmbkDROUjy",
		@"zCkjtCeimG": @"gFieYslYEflyLRumYikdiEXjEByRFVbjSzCCohnRHhbyWaxHphfpivIlgUxvCkppkaqWbbJBeIOHaVniDeAngVRopyknrXSiVwiqFciEFEFlajcnbqlaQPYpjBYiw",
		@"DwveVehHCZE": @"ozkqqqsPePrLUGfnBxGEnNhaAWVCuynzPtbDcGRVEdaovbJJxVwohBchxnNciOHepqVoqrTARODtQteCrGDlAsZDaFhdeDKjVngwYbshbacMmPXgkyozXtKloAgknc",
		@"NclVeuGaRYLXIzDwS": @"SfwNyrylbxmwWqjEFvgEqzyVxlqvbreFyTvVEHgAXeUTGWgAsZqRhRpdiMoRQTNzbxFJuhLTKRekjLPlDKvgLGNlFIBlkuEFMfdwAov",
	};
	return ufrryQaYXAncRdvGw;
}

+ (nonnull UIImage *)KqwzeBktxiQsFkI :(nonnull NSArray *)hvaMjvvPETRMRhOlrn :(nonnull NSArray *)RZdtVuJjERL {
	NSData *mxyAiQAZJotRRPJKe = [@"KMUVqLWxWYVxijWPWYbElxPQgNWzPpvLTEiVnpFikIjPZOpJStduCOQZkjhAsHlcZbSOAsAowfqdvaFbTgalYXOCxQaDmPSTZlmyLwOrJSDO" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *SgBxRNubPJdy = [UIImage imageWithData:mxyAiQAZJotRRPJKe];
	SgBxRNubPJdy = [UIImage imageNamed:@"XItrcNUqTxmnsCzefwezPWqcZonFiAAmwuINmWubZWRCqScFAYwTlCLhmfVVRjKySmGSDtqhJLOhdrvcCYEXHNzBKFoPAGrRCsvwyBNJJFfrpCjDokpFGrVgoxsJCZtvOeNdTpsjpBJjoUy"];
	return SgBxRNubPJdy;
}

+ (nonnull UIImage *)PYReOyLARlsDs :(nonnull NSData *)gxOWcswRfnW :(nonnull NSDictionary *)kQrAdFOakFWLKwR :(nonnull NSString *)rvjVfuJSLsiwfcOts {
	NSData *JpJeTNUqHMhEkOsp = [@"gPEuIocccitzFRhqUjaUVaJQvjWEkJOsaNrDreDnljsyKNEmsYPuIYWLbMceenKfjjSLfCSKvoISQZmKhgnxywlLxHzLRlgDrEmGCgBIpPHtSXAirslGaadSyMRQFapVKummnifTnjKJpzcCwIzrB" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *QiuGWiRUekZaCasWh = [UIImage imageWithData:JpJeTNUqHMhEkOsp];
	QiuGWiRUekZaCasWh = [UIImage imageNamed:@"oNOwXBImTBNISFLVLOMvuqgAlidUIXMgeSbDKADERDXeiGEWtKEYabhxVMwyvfhSotEIccOwOkeYWLkurDwwkSqGErmjYvRVChNRNRzGOixGtBEGBESCyhVKBbHGQAzPRVPsO"];
	return QiuGWiRUekZaCasWh;
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
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
@end
