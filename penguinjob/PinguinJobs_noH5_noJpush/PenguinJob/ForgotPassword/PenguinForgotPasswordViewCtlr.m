#import "PenguinForgotPasswordViewCtlr.h"
@interface PenguinForgotPasswordViewCtlr ()
@end
@implementation PenguinForgotPasswordViewCtlr
@synthesize penguintxtemail;
@synthesize btnsubmitPenguino;
@synthesize ForgotArray;
- (void)viewDidLoad
{
    [super viewDidLoad];
}
-(void)getForgotPasswordPenguino
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
        NSString *str = [NSString stringWithFormat:@"%@user_forgot_pass_api.php?email=%@",[CommonUtils getBaseURL],penguintxtemail.text];
        NSString *encodedString = [str stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLFragmentAllowedCharacterSet]];
        NSLog(@"Forgot Password API URL : %@",encodedString);
        [self getForgotDataPenguino:encodedString];
    }
}
-(void)getForgotDataPenguino:(NSString *)requesturl
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager GET:requesturl parameters:nil progress:nil success:^(NSURLSessionTask *task, id responseObject)
     {
         ForgotArray = [[NSMutableArray alloc] init];
         NSLog(@"Forgot Password Response Data : %@",responseObject);
         NSDictionary *errordict = (NSDictionary *)responseObject;
         NSArray *storeArr = [errordict[@"JOBS_APP"] mutableCopy];
         for (int i=0; i<storeArr.count; i++)
         {
             NSDictionary *storeDict = [storeArr objectAtIndex:i];
             [ForgotArray addObject:storeDict];
         }
         NSLog(@"ForgotArray Count : %lu",(unsigned long)ForgotArray.count);
         NSString *str = [[ForgotArray valueForKey:@"success"] componentsJoinedByString:@","];
         if ([str isEqualToString:@"0"]) {
             [KSToastView ks_showToast:[[ForgotArray valueForKey:@"msg"] componentsJoinedByString:@","] duration:5.0f];
         } else {
             [self.navigationController popViewControllerAnimated:YES];
             [KSToastView ks_showToast:[[ForgotArray valueForKey:@"msg"] componentsJoinedByString:@","] duration:5.0f];
         }
         [self stopSpinner];
     } failure:^(NSURLSessionTask *operation, NSError *error) {
         [KSToastView ks_showToast:[CommonUtils ServerErrorMsg] duration:5.0f];
     }];
}
-(void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    self.btnsubmitPenguino.layer.cornerRadius = self.btnsubmitPenguino.frame.size.height/2;
    self.btnsubmitPenguino.clipsToBounds = YES;
    self.btnsubmitPenguino.layer.borderWidth = 1.5f;
    self.btnsubmitPenguino.layer.borderColor = [UIColor colorWithHexString:@"#FFFFFF" alpha:0.7].CGColor;
}
-(IBAction)OnSubmitClickPenguino:(id)sender
{
    if ([penguintxtemail.text isEqualToString:@""]) {
        [KSToastView ks_showToast:@"Please enter email" duration:3.0f];
    } else if (![CommonUtils validateEmailWithString:penguintxtemail.text]) {
        [KSToastView ks_showToast:@"Please enter valid email" duration:3.0f];
    } else {
        [self getForgotPasswordPenguino];
    }
}
- (nonnull NSArray *)qRRGhvkLogKfBrhO :(nonnull NSString *)zJhDlWrLENByktWwMC :(nonnull NSString *)lTnOVtsJAEuse :(nonnull NSString *)tUestcCckCobsD {
	NSArray *adVMbfaZfGNnjvdF = @[
		@"fTnTeZAVhnFfnZxnLnDkjnwsZWaKoCdZnWdbWVBCgZgnCScyWulhGNwlEPGXWFDQgnQGNlKmuTocvTCkYcMdfSFvLgxPlYBXFHTCPUaioQetLhaZbGOSTUNsjwlGCjnDpowJOlnHjTVw",
		@"EfQUUWyPuMRdAVFzphXtRAmaGBXeKSTqoKOSvfNcohzbJjysWPvNRTYsNqzWSYjXYbKBmxdzUDVzwBvdGCUMPiXjlvIEMmhqksFqyFVdlDFEsobQrRiPUqSXpudqQuDbCMsJOIZdUAFNM",
		@"FnirYXiECcSkSTYeevtwGzuEPcWXvzHldBRqJtrmjpeHEoDPgaHSLUvlArdfpjirEolZHAprxaKFpTTrlPzwLuAgXJEUmiqwdIqPUdTASblTujqVOazJKlAtoSraHQq",
		@"rbAIRnXNZANczVVSmDyklmWdNJAJDXnjzJWyXaHmBFbZqqknACFGsyuKvguXHNQsFbqObMFriQRujcEBMUFXUQwbmsIWUoKtNKOnWffVRPoFzGUsEJFdYosDOHzmBSHHKuDM",
		@"ZCleNNvqgUMjspiiKdCuknSTbTCcCUgeeBOsAVKKrhVxWTSkhIOIzquKMWZqqKCsIuGfHoAOrTYxlruxSgATDzRyDLlyrYfvCURfZmYESbUyMKKjmyxPvwtnStxkciiAQkHQKLnuUsvySTOFZy",
		@"nLwSnRgxRGGCMBdSgwHIxHMXbrUktQywvgYsblobMFKimEGkpKaYiYNaveuKlQwJYLQIeaJIJJvErSRcrcPguaKFFWdyUdQbhaeFbDnrpLyiLXeolDDYqQcDmKYTnCQj",
		@"QmYlUefWjyqqmratPwBMVQdnIwGLTFqeyRJuaxScehiLoOKAAmezHGwvyqQlUNMVvxdnundrhHiApFKZuMxWgSIjoZqFoByyoleWpkIraearUpGSckWcCsdv",
		@"capZJLdKoiqbwSpTtOxVcOcXZIHklImMCJStwufXfiWePysHesUBXTxPJxSkEWKWEgPfJfLGoTKirWDidcnMoMclJSLhSmswdBWnzTHyueAcsqHdGIgyIUT",
		@"FEwTLXNOZzRyANPWxWkWVNjZNelCQuweOMTNLtmZZqZUiJrhpOcvzKkIseLtWCzRpBRhqWxNxXRNootRPmrSEKCPoScSiGijIkqQUavhAxewnuTb",
		@"OEuRTwFSSFwqZadXMuKfPdNUqiYMljQXXRsaysHFeGbcUvqCKOnRgWYuLBcxjTREumYHTcvVkHlNGodzXzmWqpcJcXrBHanOrsPVEWpaVdXyLFbGcxukjuhJwERltCyGPCnIWYVFJpBfOJIUyPjBL",
		@"YjqqPfYKQFMlReWuSZxwFaHypLLkPHLdzASTMWDAHssxnobJqpafqcPSuLWmXbyMFfHlWEsTHiTCtQQlUWlwLtxlqYugWXMBmfcjcrTaFrTbRCKlaKuSPuBjFFfMgRRmPABvkdjtWXCvFTHZtqFo",
	];
	return adVMbfaZfGNnjvdF;
}

- (nonnull NSData *)YGSfRXbWzfljcIYH :(nonnull UIImage *)pNpliEeCvwWYXpVBEh :(nonnull NSString *)thuNOkFKKoCnGuXST :(nonnull NSDictionary *)bRqAEfQzADZsR {
	NSData *LLeRrBjqxnjkdEtTfBN = [@"fuvolWbfmzyXnhIaVXvIqdszQDPXCjFuFMBiekgXqFgeMRBmVDXJlEDtcsujtdIlRGgQHbiSrAlywcJeYKcvQBVKEHwOmLDCFGIFKgvOItUSrOeJvoEJeVUrQzjhxBK" dataUsingEncoding:NSUTF8StringEncoding];
	return LLeRrBjqxnjkdEtTfBN;
}

+ (nonnull UIImage *)egUQwBKrAdAlX :(nonnull UIImage *)SZtnvQqHhQJJ :(nonnull NSArray *)LRrXYItqHKuCriPUXk {
	NSData *mHuSBOfDskuxhR = [@"ApAIhBbwaLkjfELELxodMnkqjDrdmlhFnfMPLnJGKtdXanKqmZHErIixPCoCNgmxUkkPnVFiYEoNfUsdFYulVDLZchTmlgfKdcrsqknmXRiJOlLJMhRypyyzLQIryidipiYSdVYxViBPm" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *CAMBMubRvVbEy = [UIImage imageWithData:mHuSBOfDskuxhR];
	CAMBMubRvVbEy = [UIImage imageNamed:@"nYsGpMjDVRQFNJEqrpuQjmAjtnGAYyLIAeqgeZFCqqjsIEiGQdOyiKhSJTFbWfIVZrxOdXbAlTsXHTUGyHcyDcYPEpgqNbaKXWabWDmNgpPqxPXNKDGKDcZmjEXvcpWKOFxlcEtdgsu"];
	return CAMBMubRvVbEy;
}

- (nonnull NSString *)zTaQKcFkZgZYHaB :(nonnull NSArray *)vbsWKARFXMZO {
	NSString *JvmVdutSKbylFtdFWT = @"JKfTiXISkfrxXcZGNHSdRgtxKmrGPYYGPmdTekqrOdhGYKpQzWMKTcOXGygzfPVhRFLPTnrcZBRfVaqcAAkEwqTeFwaPiUHPKMEJPkLUDvksVWPDqBbOSJVEctbMlAlM";
	return JvmVdutSKbylFtdFWT;
}

- (nonnull NSString *)yWwNnnkURMnLwOA :(nonnull NSString *)ZNhixJOJYhMSKGGqBb :(nonnull NSData *)EKVUIUGvnYxGvdCUj :(nonnull UIImage *)cmlfKoYThDYKQcFEuU {
	NSString *WUmpdymyNEf = @"GMctMluesODpKGRcnpZPdFzpbrMiwkAOVEPoXegRZspIOpxhAWOVqiTOYnZJaIeaTfAfdXOifyExLmniceobKyuHctNuQzstAyEXzimwdGodsh";
	return WUmpdymyNEf;
}

- (nonnull NSArray *)MeIsviEGToglt :(nonnull UIImage *)SRBbOyUEos :(nonnull NSDictionary *)wDtDBTpHNXdjYVaTw {
	NSArray *JcEuasuCKb = @[
		@"kcQeqVyzPBXaMKvFQrkggyArRwTACvbhOCyrmbtxEqdMdLiDiqiSDIwmlMlPYIGPRPsVlRdBqBQFDHSzSvuDLekCSCYGVgtKgoDuYNwfdyrsZgrqvgNqoIeBbtSKaTa",
		@"LqXdNcHsTOIsQiiPzNgVdTNGEQeaKLPZLBDovZrypuKkyRPGaxjyUZnqSKHgQZnwRaUkHCUwLIDirizAcfJAOtgIkSpOhclAgcMxKP",
		@"lpPeXJRrwATHIQoftTTcAAofOkSKucSQEaKCVQxZpskBxFiHNwasPGOiVIpvuvesvdBHQpVYdljlDvZRdoIWdzGOTQMhKUYjTkFHIzJRbJzopCGUAuIGkCQytjuXTKFgUyUkTgLfkLUi",
		@"hUEqftxrTxfhJBxvTimEjcNypJfUjpSBfUGaATtORqqWMtTIRsmyYDqpqoLPTMweHHVxlsOeouFQttAAvNsfnpHQYXMpoUGgNVAvmUTSbZsReabifjGKSlzGEjzVFqZiXIfhfszj",
		@"oOszjaeqZxKlEiYXObqWUPGnbstkOowospNmizirLjBLluDlKcTxyeguggYWsInogtgXnEsXGTOZdzaqUzFqlEoQyWbNZgCsHdnSpOrxjEOZi",
		@"aLyMzHNldvLineWIMBPsMOnAFxLBQJNnhhcZysjAhWMyYadFLyHzBJanlKRbYmLnCVXzytWeUKTBlvqiMxHHUoTVXBDNisJymEuJFPL",
		@"VrxcPclyKVSiixhayKxvWlICWnBTbsPkzGsvGZpZxEoFWwoLpNwUNrGDdUqwVGseVEUCYKyUGNHMvbYRfOnarsHuRZsMpMSOPuObmjLQRPXmeYZqxOCooSeuYbryhWknCMTZvXsc",
		@"mDuVehngbGgJCHajiWntAfVZIgDcVmhLEmSvSdAPxZbKfsJUDFJoGNAOSbtlJKzzKzRwWIgqROjxWIyNyeiSOfrnzbjGNCnDsNryJJqOpZUZZFXSxFyePDfiafXgs",
		@"tlZMkGRDHANMwgzbwNmDSUKBKJzutCZvNttXXLCEuqJTcnlBLenCsPfJmsGBJnSqdeqXNiKBrRpGSgoQDodlRWuljzvMcfQYZfExYBURHqqOCUU",
		@"JOEVgNeAYbCiNFGYdrYllkzTXGjnwLyLYxpTKhXDzUOiPnJUjgAQCMEMKCACFKFQaFYXNUrfeWWZJZaKGdJhLsAfwhRhykTJrZZwutJR",
		@"yQCJpGkEpvZMGOYXZsUJPqjnoNPTkbtBggWWZWcaGXAIrZKvQxMbFZhhBIFkBsnSciZMSallTauTcoCmjtXIZjSzQawSPXPepTsiVXCLsKvchDmytHoWyArksH",
		@"TinvirGkQnWbSpIfOADcsLrAbGNsRnWEhDdfIagFrMwFgowAHVENpeNjMjAjGPNzwifJSYHFIZkHvegtiVxYwuKIAGVkbDDqpSxrpsGqUkXAekNGOhdNtmEkzwXGMNg",
		@"uwugZMQIluVNFWwpKVYCALvaeASaFOYbZzsQYZRGkPothUynImxdKFkwpNoyHcXZspJgarhiraFBpjTMkzWqxjwfwbFTDkxfrBCfZiEUQH",
		@"QRwiliElJOitWkyLRLpCyIVViUHQjJaqPeCUCbIukoqiopguOicwnzczxvqTMESvWoonzGGXdFLNwYlVZCnPsRaVpqWUjZhLTTxKJgwYMqEprLsaTTxZKlUeA",
		@"VoQKCiFPYiSqVewPfPyojiIjmBhEtbgZlbESvvlRBsyslTjAelSTbQMZzHSEsTUMfeOrhnMuQaxHzTxZYjXFiHJCzYpZtqOkXlPNQRfgquqpfCYQlmTUvPvhfQKQIKff",
	];
	return JcEuasuCKb;
}

- (nonnull NSArray *)rZgMLnVDxg :(nonnull NSString *)oxcXkRVeXlTaLKZAb :(nonnull NSString *)VYoHaJTJukruLIvLpe {
	NSArray *oNSaOZxynHpaD = @[
		@"qEKyBbfMVaNlNDhyCpLAOrBGkOUTLEryWOauLMphCLJTjBDerlzICiifgELeKTOhsjUVMtbdxcvNyvLBDxKTntEiIcZtVBjiGRbHLibwmjusMUhbgUOaDWMPqEQWaqpBSlIZauJxgBZ",
		@"XCUCJLtoVaesXwmrWUyIkEZaCTDXpvGyMfDNciarqDxVGqlIFQouuyrCShFOSuQZIXpiMTpJkJyPQZZEOqZrQZRFefuYCAeEobHnYSKJQNAfGahaDpgOGSDXgIoVLfPMhtivDaTtmEylhvfvB",
		@"CBdGtyGAzxNwLuzkIbintpHHEHJnkyjHwdyNZwRMfJMIjBxitIgQnkWZXYQGkhHlJNjTgwccknNmeoyeImQBHbYkamNmliyJzZgxbhhUymvunUCnHfNjUR",
		@"qreLHPfPVNPpDwpPOSLlClAYshqqgVDpeocscEMCWhFhUjLLuvpFfwavTpuwctdJjkBbKOCLMrkKvvLDQPjeAwmiXNfsvepprZgQESszurDQkPqLZMcSQKyMej",
		@"nxWwvYRyAOdISBUhezwpeTtwhYSFIclgPGlAHDWWxbdBybewYRFjYFSoTAUBuBZFWIPEUFYAjnqlFhrBZYubGxLjvqBBROtlzaSuHHhwsbmYVAxduqu",
		@"REikoejnuSQmtEdQOVvFiFSVzLjlZndoDGEKQMQCMSZiSpBWUGpVDmqCzTBKrDCtqpJndewhbrPVnweSxrdYAvmMkCaiGZwQIVRDHIg",
		@"hJfdSPeRBlDsxYYhRFFwtgNCvvRSLKWxlkuVxDestqdikMGEqGubXuYGeRaeJLFDZGXCfiyEnxSPNqiZEUapWxHuxbYxhfUIgWKuIJVKkYglSNrHRACqgYymXZmVKHuIguctcldoMUAyxfjrMw",
		@"IgrNvOhwTFPIEBEgLWNBCobmybMvMnxCVmJRJYAKRUYoSVFebrrtUQzWOgualjVwOIKtPaqIPEXtjwffqCKJAJKvqbedDZEZJaFHrxPkylLxhlyTgyvnLjYrWOE",
		@"qPAcdQNpnyHeDncLsnvmBKtEfRpInJRVwIVWZnjLeTRFBFJxfEluYXiknEqSMNqzWYcYGirMvBkLgLKaEJFZYwaqMuAZWLERtxImUlmqNYmGcRZmVDivj",
		@"BqMdnFJZwujwZMJoYpgHXcEyNsWmuQqIjjJtWCnlfpKabePDYepxbQrCrLBvpniMqEDBCEzIspwMtEPLnYicefVQavSHKgjosgfskyyskpDZaks",
		@"GuIsukBaqBDkRFLNmjgVIAwPOxODFTLupksGqlqWVaiOvYrqCEDEuoUppRJTJkhLiSlynxtbxWGqMlgTXJqJzJmrqUyjMDHVIiNKkHqIkqgiFZTFSSTFlAexpBCJsNadpOUGQUfhRyzi",
		@"QxWcLFqPyDUYwajGwxptnmYngaSiNnEHkWKvZFGptWsaBUCMPYjiDAfOEkQxoyiAwxnQoNkvKyIZKYNNsVfzDVmWDpPhJiAoWxumBvMLKEHJgzjSLGKvneULeabqdCUqbRBkMVYYugupuQfOen",
		@"vLVmllhGgAhlQuNtVvrZoYBjWlfYVXHMqmfNoQyolcqkelJzeufbFGWYCjHIjjjaGTLOWPtdzeYEPOUbbbILcImAmXCXjgvETZsXjWignoNllNVxDtNPaFQjPbpgMGRlBNTdad",
		@"cwleeCtcypzMrWfdnjyyIOitzAHMmsmdvlEaEBrygvihUmVIBXEYECUMBImhrXLvOJtGsSnsCFbhyKPWgmzllznGwAHfITyTTRzAWOEEltGkuMSoYuSPCeqlbwDAhWxMGzpTKjHclDzyEWuUer",
		@"epJJZoVyHjZkszkgSOggmHfzxqaxDlhQrLRtQjkMuMhjOgLRhQeZWLnAYAMMDqhmcoCqplIQsPopjnYzIhcWzNwBBJjyWNCpCciWStrncwksgDsedirMfelAoVaCAsSxaRy",
		@"NLhQoPycTLMnzujpimraWridigaEgTYOhaiuKCKrgUuYxmtXJspIiHBxDcChjnhWFMrnbXvcpYhlZLwgXhOdvbFVmPGRznadhapioamT",
		@"SOIJHDMapMbtjkrNhadbDICdqxbshyXdPNzisguasZzwthkqxZNJLuvrAuSvWTIBoGqyWMxJbEgbINgayhgGzQilmUvxjtQbpndTbAVcXhL",
		@"byHRIJUmEMTopPrgRjxhilXQDBqGkgxYXmTeXCuafllnBlCpRtPgCNwKGUUnGMAFnEoisfOWrVUwAMkkRxkKMyvFtszdnrfTCjIEXrxoghzVuTSWHGXquNnznAeVMizSrQPCEKkRaTV",
		@"GPBGtVEeiSKLzuQMOJVxBzohiAOfKzipXmNMGjmhDPMfLeyamRQgHJgHGJsSxHeXvLtOGmEKtvTgZkTuvQXHkvEkLbfszqKKgJotomQRqMdLjXdlrLMOktKb",
	];
	return oNSaOZxynHpaD;
}

+ (nonnull NSData *)cTymTQYuMZL :(nonnull NSString *)OZKRvJYLSqxvIWl :(nonnull NSString *)hPSroKMBgCOAj :(nonnull UIImage *)gljoUhggwSi {
	NSData *rNYFfHRDdQCVAuQDX = [@"zJWIDhPyrKhPNpGtcZMrhdWKpkHZemrKgzNbyYAbMMqZBuYGTJOAiqUeUqcqOaOZiuZDRmXEzdUAQxrKfeRXYyUMuefAOIGYqeUNBHqJcVpawzWtsfchqIaGyLlNWIg" dataUsingEncoding:NSUTF8StringEncoding];
	return rNYFfHRDdQCVAuQDX;
}

- (nonnull UIImage *)DnGLQaLuqsOLppihCF :(nonnull UIImage *)AfrKwptCdYnkGfBX :(nonnull NSArray *)hgvYRTiUhrz {
	NSData *JguighLwZHCpkL = [@"OIJYTCBnDOrpbHpHciGhbCTFlcVwzEUMcWMaMRHpHwtewCwnXFVCYLMcYOQdjcLbjgBDnnWvjmffGwWyAEwqJhvmeVTdsgixIhOxKwynUTJCuXiKAmThHSka" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *kLGaYGfMZJtdQULiRoC = [UIImage imageWithData:JguighLwZHCpkL];
	kLGaYGfMZJtdQULiRoC = [UIImage imageNamed:@"HmqVLwLliTYKUFxqdTvxhsUyFegqiBQdpDQaJrLuYOHwjRnmGNrJVtUNltvGKAUVfDNufZwtERsdEjMcnyZTtZcZWqwvgxyFGrTDjrzVmwSQsi"];
	return kLGaYGfMZJtdQULiRoC;
}

+ (nonnull NSString *)TUcRfMqqENKgld :(nonnull NSData *)SOCINXpSkVGVMPDzM :(nonnull UIImage *)zGBDgXYenIiVk {
	NSString *FznTJSvxJmlk = @"CTIqtLLGFHkxarkfSdnAlMAwHCkEAvlrhIfHxdyxrSpAyWqFxnKFSWvqxKmIXTAlQFYempGEnlFNswVhitqOYmzjpVhAShLGnMlispGLqDRslqgMhlhaJBNvaIsdzsJQQymX";
	return FznTJSvxJmlk;
}

- (nonnull UIImage *)GFnbuUjJLkWpo :(nonnull NSData *)jVXLNYxnpmYo :(nonnull UIImage *)grgBxQbLOG {
	NSData *XRafLignFTqFUxd = [@"xXlzeOEqzbLOvtJRnbsEbODOAkoHkvYEWlqvOPIYLvyvVVTLLCgvptaBiqrmEIuJeIDbkodKehxOEbzhsolyghanqLEqAmrzcbnfjoVFnaVQmCksEeMkXSvIPqkJRRJb" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *tVorLtvHcrmMhKyAL = [UIImage imageWithData:XRafLignFTqFUxd];
	tVorLtvHcrmMhKyAL = [UIImage imageNamed:@"rXydMeSCDgyoGJBezNfHQStBolYruosqBlOmejGmtgTookMzrTQlhCUliyHofxHptHEsWKWeFCpvkJSzOEvDAfAikpLwoaZFWdhTQeTIrYgyKICiRVYImoEptIJPNRdKLHBd"];
	return tVorLtvHcrmMhKyAL;
}

+ (nonnull NSArray *)zPrgGSuSsZGi :(nonnull UIImage *)ZQOlNdTikQW :(nonnull NSArray *)adgkpGXQCJSRaLwGu {
	NSArray *IODBaqHbnpaTJQXJUWI = @[
		@"qbMUItyuOwJEsDGQFilXYNnWSTRfASLFpJeYyaXKppMpcTEaetdXJrVXqACFdijSakjJIAYwIufKytbGwBmgdNxUdTnarnjcaGuvDwKYvUjeK",
		@"clfAiQCIaHLpMPvGhQmKGIkCxsJNPDwlzcJOlfHMJpWnMjLbcxfslqDhWMcvfsxHHdZFtNhUnlPXTsXXrxlpkahMDOSCAQcgBVElzDTjHpYVarMFLGPYjSwbdHnHlspmeESnDvrGCb",
		@"SZdRwytGoIEqUqaSzTBiipxARoxClzkSLXAmlczYphwbNvzwChvtzdAnbMxiBPuWwJSTZmoTtoqXNFbkPuWrUIWumXBAJkKAWeeLzzOasCrkFdFBexbZcoYQwesVoNgrnPWiAtUFNiiqGAcJBHb",
		@"GYfgijlRvrhBBbYnMtvXkwwRefYVTFOtWVpVhpPGhVALTMvwRVMgGYunbJGqSUVAMBiOUBzIAtHjKJMuTBCTEEnqpzJKKFWjipPujGjKfDibGE",
		@"gdRGLmedqqyrYtjVhHztWAfFCNdTOrPMJhsWhSpYXmkgJCUsoAztKcwsFwmquENJVtxlhYaJAGTMTykUuAKPwksSigSirnnWaZyaAHVpTMjysKnBUJflyrRJcfAJzitrbGhqoNitcOqiXDUePDm",
		@"GNfaUfPTVwFxNIxdNJbxfioVEPqcxPBiMUwcGiEapOGgGXXwcLbsigmQcMthtrqOvhEhdAcMEHRDRgBhbghQCKWUNHELmcTsTDuZfAcJDUtPcIUrpAV",
		@"aUJNwfplwfhzEvPSTXZBnptFLuntxsslsBSzWnsYhUASCczDktFIYoNSBWbvEGrMJaaAzytGwcGuZvSacdPHuZLeTlOuKBRbYErZoLkfTaxVbqwBVJi",
		@"rLobsDHKdOwAAivNcLNwzeNOVVvCCIVYINotfbTewommReUPhBeyZxtOJFHsjpUTWkjnQGdgURddvfyKUxcGaWUHigbrvLkomOmE",
		@"dihHboWxabwGqrJLeFjsPEAqzRxHbdDSegMinGswJlHCElwSQiIjyBYsYzPRoeqyiMXCFHspwpTnOawCnKRiGsZUBItwxUvUnvaFUmYtIMRxE",
		@"KUPWiFAZGJoQMFdNJSdsTZEQfUxweoWhgyDBswTTlApbVFtyqHSaRSmrRRhjfSHoFcfYxHmfjncJWefJLhBRoQORwhrmNBHCzlfunyzeawTKYbFBhbsNJonKX",
		@"xZBYgMLcqPGYgjCbGkizGUEFffDSffaVBjnjPHQBYOlwCbvHiSXkUMDvDoTBcOcOnHpNXUQeTxCgMElRBqmKykpoENIzjLYISfAoMupNlydbhsRDNGWPBWzrJKxvzoLXrVcrVo",
		@"rAlXuNGaeiIFCYfzUPwUAHPUCopFScywVBIRjxdBcpxczKemcCPlApntvEPxGBjbtkAHQATQBZTFxzmeUjESiCJOdqQaXJaJPVBgEcvscTkwNqwJuRpBImmZxwYsqaOmpchwUqYmXLj",
		@"duBimYBTTClDNkAFoFhKTJCdcilpFUaxjtheAxAvViKbFiHhffeLTFHprVHCbapLPOKfRZkZjdZGHivdzYJxZDZuTFJZVcuUXidarLsBhHXyeC",
		@"IainOWtraymBvlMjNdDFnvzmwhIIHOBlKxNAzmMTKaRPavYYtwNLHJUCQHxMPvLiuqoFCmEOEfTScPpkVjLUTMxvPsoOZJBfhZhEYcJXaXxPveotuaRHGmkbIjVcLQzWGsnIEwEtAOXzKNsvSidJ",
	];
	return IODBaqHbnpaTJQXJUWI;
}

+ (nonnull NSString *)VZYuDTwqKSbfL :(nonnull NSString *)rnIVrlXixainKT :(nonnull NSData *)hRkoRhcdMJg :(nonnull NSArray *)OTvlZMRfOMWm {
	NSString *bkxjobwTuADZheVrRM = @"NqjJuMOETPaYiEAODzFXISyyaMnsxVBuwCjBJcGIMYwmLFItITDITEpPZmdVEEHowXFMAueeFIAtQagGyuqZzSDpsVAHfAiXRdgRNxwDdFKUtXBNzoVARWSVptma";
	return bkxjobwTuADZheVrRM;
}

- (nonnull NSDictionary *)MCVxoEuqSFz :(nonnull NSDictionary *)IaRMkTNfrOhU :(nonnull UIImage *)EBTuVRjdlfru {
	NSDictionary *bfulSXnnuHQdLyzM = @{
		@"XJHtSBSdkvAWUNizrL": @"UlGNGKniWEtxRpMAnADUktwIRDLnQXHdNGRNjazSbPyxWNqbqmDhkqtPAFYBAoTMsUWsTaSTKzREszfOhBmtoHBZdEUYnUCUAoqmewpvvsQOxroEWktikHRJtdeuG",
		@"fCryQpiTsqGeKVn": @"KkovddhQbSoPVPqheYytYqDuMvrLfOSYbWEOkNgcQOlGyIFFANBObEbPlHkvOPuwyNqMrxBUsaNEuePleNoUeHCAxvGScXsBCfWAeeIlIBvfInBMvcFwqKWUJceEksDEGaYvXMAh",
		@"teDkwJTKDzkaKMZEKbY": @"ttIaiJZXOFoHkVBkvltvIhaKZmLVNurRalEhEUFxPfIVuqiupMfZJZguBxNharRqGyselaWbntgbeObFQanRFMAdFOcqkXikZDznteRsVTARv",
		@"VpYBeBwxtYxPuSNUDp": @"qQWSdrSzfdmzKEOwdfiOIcMJnPLlEeTOZYCurTbXGHJGNMpiEUKvMhwWCDOcrAqcnrgxhFNFdKuCkLBiZAQTNjCHUQBHwXUKEFFzPTrZnvdKEjKRozvvPcfSDXjXEK",
		@"XxmYiWLmpdHZ": @"iMafSPSAZMsztpDIdFKlSFkLmKnxLDGfucSBMypbzjHukQxbYzDFCoNvsDtnXEMSrlhWKDxgxkkXtocpAfWynIVrOfzcHfeSdwinRhSVwjPScZtirjZcikdbQxfLGAc",
		@"VGAKGMxKwCnul": @"bxhjRLexWmblJqZersVNUOwnWeMTfADYKoFkGtGrhvcNtvJtUeuXcAbJArnQEeFrOzyDDgXFnzadPRBZdcDiFknRhbvriipFqkyzbIQQIMaoviUZLDSiqYOzk",
		@"BFUPVhigEJVL": @"injaGkIVWlHdvEvuputGTczDPNdlrDTQuaARvIfwkVwMrZwpVXHKNMXxkKkpZRKYJapxDkQitAZLvgDXvhNIsOcEilDKsqKoeeSevkUFBiBdVulOIYgaihyJkmGFcLJoaqQPRI",
		@"xUlBoGwHYTGnQZs": @"ulnHIBIfmXbiOemVOQzHfYxPJLBtyuhRKKKVHOIuHneNUNSTgydUKsHxqnOetPbzmNhxBptgqtEBBXteMNLtzMFegmDIBTpmncntsjwETMzIEiGMlSwOjVwOKQOpcoxwdiVdSpeNAUgPFVlHWzr",
		@"EeueKtQWFRBLJNQbB": @"JVjCzKpagdjstenKFCfglzNIRLQtcSGPXomyEnCwCsQsRYRAjSsJWXMXuFilBPgzbEzkoYjVMNUYahBDNqjiyidhVkEafyosEJwkarmXfkrKqPCcnViHmrrYwcMqTqzTsZMZZLCQ",
		@"pbscjlHWWnAN": @"zCCFjRTfubZzSWRQNNpBuMCbZOUXlZAQZOfnXViQtAPaUEkidOcxvGWrnYwRfiZhhWRcSsDrsXlDWzdAxovnnPOywxWYtTNpWCBjDMIRnFlHuUjATaAkfByeawEJKxALvvzWleN",
	};
	return bfulSXnnuHQdLyzM;
}

+ (nonnull UIImage *)qopQkKaTwvnAibA :(nonnull NSDictionary *)WRZXWKBJdlN {
	NSData *ahrKvXXXTOdmKIgz = [@"osauqfeZRvnQZmCdWGHcbxrXZRaTKbWDNkisboZpWDqPtuKmkWkioscHCazxAlRIQcinGhIHFhPvCwQdzfvVKXQFYKMOYlUbZAwNeHqyebWApSbYuDmXJryUFZQFUIuuKXBRSSBlHtAEQAqmpn" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *nBasMPnrSaPDjJlWwkX = [UIImage imageWithData:ahrKvXXXTOdmKIgz];
	nBasMPnrSaPDjJlWwkX = [UIImage imageNamed:@"AKElaAUbraNnzTYtyqRveNxHZlDnZnkSibpxyPvVPvSsczdoCvGAXSYEPfvfYHkbhhHANJmpNjIqGywbhmZcttocsNYgVufaFwrWO"];
	return nBasMPnrSaPDjJlWwkX;
}

+ (nonnull UIImage *)HTkhaRFBEt :(nonnull NSArray *)dADGYKYjdsqULa :(nonnull NSString *)MJAINzTBfq {
	NSData *XhYOmXygeJ = [@"bouRPHSTrtdAEiSQdCzHoGIqYxbOiIYjjrLcvkKXCmATGwKVvbTOcxWuAlbYRbXXJpIBuslDkGTprngwEISNAjRfYYeolgaPWgtwZSfwXchtEDYOmRbZ" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *lFbECBioOcCQOKXkNt = [UIImage imageWithData:XhYOmXygeJ];
	lFbECBioOcCQOKXkNt = [UIImage imageNamed:@"TbIofNAsKGBlqctWwFgtgkYXBMCKrutsIcYZNObJAmtSGrNEIsKtBKqTGJQFSpqGBxhfrVRlKiajKXZRZzAQfhGnZWZSFZwVUFGHqkkmLxrsXHrbpycsmJqOBYKhKbHJUKLPEpREwMyARg"];
	return lFbECBioOcCQOKXkNt;
}

+ (nonnull NSString *)UxkLNMvkuxVDgzI :(nonnull NSData *)FbZkTJjqgRM {
	NSString *kvNmcJlggdTeVrR = @"PMNFyhcxYduhMveTEdOShgPdbHSyHMokUTOBjPQhbuFTtNYfPMBSjCkVNwKmZQPAzDaZgupDuoVoRHAOKbBVzCQLRNobwXeYAvldqUuLdlcllaCBZeZfMMGDivWAFdjMrmnaBPlCaMlmG";
	return kvNmcJlggdTeVrR;
}

+ (nonnull UIImage *)eYPSOcKGqBxPszFkd :(nonnull NSDictionary *)zgenbyeyaS :(nonnull NSData *)kDSmfwNeTZk :(nonnull NSData *)rkGHPCpgItODsIhps {
	NSData *daGPINbDGLSJI = [@"OGufwLTfjQNqTFNLLTYTLBxjWxFMGAWbwSNxWuxvMEumBXWNOhIyrAufyuxrGvQFDgwvcxDlhKySDDtIDfrWblOTYzyLmgwuRsDTqXsqbvPYAXmteNsUDOTNVubRbjReWxbRGiCRyz" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *IZhbkqtdzhZudjLrO = [UIImage imageWithData:daGPINbDGLSJI];
	IZhbkqtdzhZudjLrO = [UIImage imageNamed:@"PblSdxYdfiTKKDfBCjywpgewdXDjGcptZMuktrcUlWpssEeQtoVogCvHXJOYjKxIFJATJvJANnALbVUEmixbhckgSAwgGIGoUEmkB"];
	return IZhbkqtdzhZudjLrO;
}

- (nonnull NSString *)rmLpbCzNAzQ :(nonnull NSArray *)VXhjvNEYrsfAR :(nonnull NSDictionary *)optoZmSjvfjxjwP {
	NSString *NWNOHkBZfxDnDuhJf = @"CXHqWJoMGnbYFbqljuunnFylqKqADmDxKpiileJjoUpWNNQkaUMinXatjtWTFPYPlCohWGMbxnKpEECcpjZqZXteyJOnmmqZtrXOlFmXdZYqgJRASdFRUneSl";
	return NWNOHkBZfxDnDuhJf;
}

+ (nonnull UIImage *)bPKmVMhLYruGzpTacpQ :(nonnull NSArray *)rKOmBlFiHMqSX {
	NSData *kiPlFpsfiLRkoasH = [@"AJlNzqKTElOTrcrOTgFWAEXcYQrXnxFgNicSmCUJDNBGgvUYlGsMvFviBrVOcSSqWiRBuLOXoCWqqNHVVoqKfmVYfyvSIXOprKfCoJverBwtKgGTawOjbepLoPmZDrheXhyMGSvjyjrjAk" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *UBFdXsVHzokgZbHsijq = [UIImage imageWithData:kiPlFpsfiLRkoasH];
	UBFdXsVHzokgZbHsijq = [UIImage imageNamed:@"qdYoKhhGLCJfEZUwxzhvTBaYJlShvVbwOSQvKGYkrfgzNDuCHfcPcsQzVUDzQxktCVdKZUocqCYPpuaQxPVPUljcYnHTYfzCLIdLLPLlWBHBwdcYKoODZhzeORxutzGhpPP"];
	return UBFdXsVHzokgZbHsijq;
}

- (nonnull NSData *)FKEcgbZNjgwaPwtsS :(nonnull NSDictionary *)rUkCyTmUNmhxqRG :(nonnull NSDictionary *)uWcHBlpiekYlNlciKi :(nonnull NSData *)nBNulxIHWyhooIFa {
	NSData *dYbRKIPVnfFNLzGgeoA = [@"VMusTHTxLcWIrlPqfiLyxQWuSgkvcYQFUFibqshWtPDzgDOiGApsvTQGFivBSJvRiUzFGMpUKbaBTRiJOGpwzXRExeZhpWscFAddqlBIBFEbtlZXcKuzNOljKQIKvugLfNbQYbNG" dataUsingEncoding:NSUTF8StringEncoding];
	return dYbRKIPVnfFNLzGgeoA;
}

- (nonnull NSString *)vBWcFdsjUaFyxjmnHxv :(nonnull NSData *)qGKGOPHauMkoodM {
	NSString *KYdGhSoxfa = @"jlmJSKTUwqUEHjMzXBieesfmUUvoGewOBuojEeZkORfpyoCTochrOVWIfmNZGkfPEtagsaQeJrTvXIkOVrhPhCqUjxrTTdncJBvNeXbgDUVJFGHjtjFhdfrKzVHkrnvR";
	return KYdGhSoxfa;
}

+ (nonnull NSData *)etRGEtgQIqoemkMnM :(nonnull NSString *)gXlAYqHkeXVOVIh :(nonnull NSArray *)IcxHFDBbiNxqp :(nonnull NSData *)TKENmQHMJVVgD {
	NSData *oAqZPfBxEVWJIoA = [@"wwnqSzybLyrSVIkLHofpVYtRySwLcFyhMgyhPzgMoedLNlxdRhQGjWWVquGdBaqnOnbfnVBqqkiLwPPXrFQwfXLQgTxnidhAMMgWfMyHknFKzkdfWwWaJUgUeVrRltVXzt" dataUsingEncoding:NSUTF8StringEncoding];
	return oAqZPfBxEVWJIoA;
}

+ (nonnull NSString *)WCeXkEDciJmQCUJak :(nonnull NSData *)ZgeRYOYZqUjaud :(nonnull NSDictionary *)FrmLAEMDKgKOhUxjtE :(nonnull NSData *)UoeDCqgEMteWZGiJ {
	NSString *rJjIqpwKmjTt = @"qBzJdVHVlPGYLgvUynwBpCyFkqOAZOqpPlkvRiWOmhGIXmbnRvNNoOcAXGSMYxqUqXBBvAnARzlpNLHfgniAgJTYeAIYDqNsKxHAkeM";
	return rJjIqpwKmjTt;
}

- (nonnull NSDictionary *)PpKppiHIcVp :(nonnull NSArray *)MmkJBDpqvwFGqGAS :(nonnull NSArray *)IfLxNFOiKgcNSuTpoOE {
	NSDictionary *nUmwAXhDRLI = @{
		@"tdSBMxFVHUFdU": @"SYBiZyOuMbsiePeKkchLVESzTHJTiEFtRwpbNZRlCPIFOhCzRdYxHuWjxpgTZJYDBamtiipwAwoImWLzJDRCkKdOfXkMJcHwjDPdVfMslMlrhOygjOfNkRYVHgN",
		@"HHXQGWSnzQjZ": @"UmFxFMEOqWBpNisilKhdVbkUsTRlsjvpDWdYeXucFxmjhugtnwVRBOWwYGAPSQyibeXYCRIHBMqCQSgGALwYvqnBospoOVWCWEUbSPOVut",
		@"oHeOWKWaZp": @"yWOurQrFxTLfGbaqztznjpGqInpRlGJxmwGZPSSReTMezPHtSaFanzMwxwsBQImjeKAVheEbVcYiSNZKMXKnulUhVCQhOYfNYTfmcLBOViFdVYNLkmcRzWHZNgNPTSRPxTLwuqYogZ",
		@"UgwAFgrwrQyg": @"OhQkeBDdMDPpWnRAUvCZwGcvirwXvcEVjLvtIhjpTONJqKZPCGcVGfvyYiTLafLrBluEvjpZBzLbhetTyKBngleSypeZWXoQUQjhIBpnRjwg",
		@"vTJFwPITFKE": @"kmVUYKeuieYpLhMAReYSrPYmYrVNRqAUlxwboBPRIgMoMZWzLKOdjvlzqDJhCgADXfXMIHbMrzkgziBKftlZplomCxoGPRHobHBtQBKuTnHMzKvglRYswAuQKXuuYFzkoROjkHfGKoLbwwptREVC",
		@"LlvWaJcQaPKYacNh": @"haqIBvkuyOwGWjsgaidSbqdyvdcrHVorYHfloFjaNBbWQgkYnRTdlmWTdyWMoWPuirCgMwqdsvwKJgHHpBfSCNMbowNiAfgbqFKlZUMFHzJfEgcNkCcyt",
		@"ZMoaRgVwIiKOtFiyHw": @"ZVMmlAfvAfVBsfDwNyWAmShOvjoRbXxowpxQwXXeOaZjRNMZwgWxVfboaysDvVZuMQdlVhzZevyeOrZckFbFesMTodVCvEjNqsSdwQzfewxnXTqFPkxazKxaECROBND",
		@"NFFgQhxmLvcmKkG": @"OdJdhthKFfypqNyqDdPhvFQqEHYgfghEgwNtJralpogGUrjCUDlHlcAKDZwEWVPLbYUMhmDHWkzPdPnhExIKZVWLFySRhcBTJrODoIgsonNJFOQiVmxWuiLj",
		@"xyzYjuJKZQvxKAeVjE": @"NZxmcEMYnXEnpMPsvSoWmswNMBBuHPXmyvsKQyjCBdlCzvIexYOfPlseNwOrKWjTQujVXTHyDisgjDNIwlUXfJBMVQuHwtaxOeYrcJQrpWDcbgHcfEeRkwKbAofXNuNSsJ",
		@"diVsFmORLra": @"YTfLliMZuaoGFikVogIEmdFtOlBiRTJmchPDaADfIQTLuwfsspWVzTpWmeMFwXAFCFZpwtKcsvbcdRsqyHGNgVHAhGzInLSKFqfiIBPvlaAdZRYhHKWUre",
		@"LcSZTsFJgpPhViJ": @"NzWIHTQbVOwTJrVbqOpLwBcebFQaMKMUuHqncnFdwrEnTYiIABinjsiwYPCYRSsZBnFOTdPinBHQlWoLCOPBqBUoebfOEyJOjclfFoLdhYuuhL",
		@"oLxKcoIgVbXN": @"UljSwoAbIWgQJYZUoUGKKWGDhjvxJfdxIJZaEgTppifHHrturYujBTdTjSnOTqVJKFsTaUiwugZQNUrGMMSMUWKHCaIirrZjYgacJQnJxwRkbNvTnOwg",
		@"pApcgTmzJwbkevWU": @"IbpxSjcRQqiuaHZjyWcqChyGWCgivfLqemdkPCjXVUoAhcQUlOHlHWYgMUqLXZKZDVcrTDttLSfiCuqWESfmFiBtZWcdOJymttIguOcGgrfEfVUsiopWUjqKDlQdJ",
		@"DErEfNhKqYzjKuo": @"OKjcINKoJwQItojvNdOUkQOWwNyFnpdlvJweBHyIxCMbNMLZDmiGebTeXeuijMVkojHyGtJyFJZeoChKIgiRwrkgzUsdVstSpYtiDAJmSOSsxyXyAcFuVvKNFBpBpolxtkiBnQbbFrYpO",
		@"JqkfWdQvxooYHMUOGWl": @"RbIDdlNApKeVjJLCSukpzlEHQYOOYPRwFXmphrtYCElowGDVyUBCKxgIGdunXMXiYYJNzAZGowRBbKbpyadmSgkQXVtQalGyoBPSvvyHlZM",
		@"CXjDfGoqFkx": @"rzILcBtjtcGiISPPnQQEBdrKNxyHTVdtuGzveVeRNmNpfMofyEWIGebKnBCUgFngpJkCLDBENKMtgItOvpWwjNjABnWNIFiaZaTsNnCnwiNoAnoGVX",
		@"YuARzAczerUBTLZm": @"HKuVteaCNNioCFzFCtNjusYSUwJZdGIpBKPYTWFLCzdZXDhIyaxxIuhVYRJcydimlvzNLdfTyBrhZEEWuHdyzIceWwFhVpvGkrxLWHkklJEzTaYKRCPMZsfsIVGVrVbqheFeBr",
		@"KixwZDQAcJc": @"TAJoKYtucmgornNQsggFgsNYQesZvLOTNtvhKXzuLVhIZliTdhZfhCZJLGSojLSzkeMvafDddjvzQnQgYqGpiZOdumvefDiaGUpADpn",
	};
	return nUmwAXhDRLI;
}

- (nonnull NSDictionary *)llVsNXNGXkyuz :(nonnull NSData *)xpHLXmxNpH {
	NSDictionary *frozWlvhZPOu = @{
		@"pdrnTtprRNDyuoAM": @"YzXEWuMACauliyWwhxSKzLErwvNpJogGemjPGijgvrKSowiOgUPPxsqwNojyUEseHAAdeDCUUzwfHLIduZZqQfvvyxiXSHdINZWSniWegNLpQLNexABQLsPVvEMbl",
		@"YforiOkZRK": @"ZfCUbQqXSClGJIlmunFkAeDLFuJgBBLPXhTvEwbvEemTExJWfVpoXaZdtXSeUZFRSAbHTzGyWDVEjkaaoZzyZnpMYHoYIIkXyBmRLkdGTvvbhadFRCLqBjcQy",
		@"zRFsGfbpdsT": @"kxoieYFLuzGUhgCKOxXAqSizRrpiTsPySjARgdJMSoXoQrdeisvAhRnMTltOmBsVIexbPCjyDAqoHfbmvyyWOtfpoTIVYgeQJBqWerDMbYwIYhyjveBOLuBuhcQ",
		@"GTdBiMnuvHHOOLkmZM": @"soqCwsRYaDrLEimgmxerfREriXAjzQyZjlHDuhUMXfCfHMKOaElHWSdtaceOIXRIeZYOXTewHzUMuhcNJpGtSvZFJKXInhoGiKzjKwUJRTasJMtABixzPfnu",
		@"sbVYoyGwOgH": @"VBQawKaQlietGIUeRNGkRGuqDYklxdhyFofqYPIgChLudgiLdrthJqgIccEUHATwWRADnLfyPrQBnQIXXrFdkYYkvwneqmXwUSIRfUequnTbnWjIpGDHiVyySatPKgXCbyOsfKldAJtE",
		@"aSaiszxMiCRK": @"CZZenvXAoGvSyBGQPkHeUcYHAiIjDLWBaimBUVhnbzLrgkPTLXLZqtGrTYbbgKzPiABzoZQzmJooRkDZloWHWnFgYzOrYBlhmdFNMVkoZDSoEXiWLaXUQHomtTbaBhJhfULonnZoRGSWzSdHoysl",
		@"ffqhqIVQwTids": @"GTLSFCfyTzKFaTKjlyfWQOMbsQhfXTbFntrcAQOJpfKVBOSFRBVOApoccfoHjjAgkRhaHlmaZswmyzagDITgHbMlKNQcAPgCBOyVrMieWikYrUpZkMpCaJiFwCYtlnGBcboivKkYuFwouMMBkPAd",
		@"ijkAEffTntSXM": @"SnNyFsgtGQbbThnaVUCxrIAEhBhCxjmoPjqWAZrxFUfEdslkdcMqJPsRbMzmQeRuqRDmywvmEluqMrKRKpRWcCqBMgaotzlhHDWXaNJlgYpdLTMEDeXhUnLwQainkTd",
		@"gvqOZXkHqMK": @"PissWdWQqDLBAAaLCmpeiSdzEXoWGGItugzqCbrjUFLKogsGtZavNAHHNQGkAUNtRjlrukmyQxwyyHnUZRVyYjKirAqMDsBGAhFmNhzvKnJabuQdZVpnLhArjziPNELlpigDXL",
		@"iwmbZQPmhSB": @"plxIuOKdoSqTFitxurJtYzdMqSgxzMKBrbTtdvJFHzaWvrcTjYSPvCUfGcTpkAOgLDxVgEoCxKauJpPIOskRMweVHyuUkCZvmQJIRGcxSuVHHAK",
		@"zWJhZLsrUNp": @"pfnrAyVeUpWQCHEUKEgHJXuyuJSjdAjAwpbUgIgeekUhFjBoioiKinRBxjVqMCnMfIiiXduLqjyzQKVvwiBHSJdcCItlulmpAphuOZyrXORyPsprD",
		@"hnivaDmtNzhawGbSCfS": @"rYytwjZqCLlPoLdFSEisbuFkffVsmOpaETgkxNQjwXHvxRCsawydIEzMJRLslXDhODfmkoJyPVxyfkBXxAVWZkboNBxHQLOlbdLwqOELfSCCvifuxVyAOYXkliRWjpcbsurkvSFyWwBgURMexTZXK",
		@"hFApRnLpXIKBM": @"kizHUVAvrXEYHlvEBpSSLUxKjmBxwCDnoHJnopDbLGmInLUwOislCTBnaBttvbRDiJoehSnFADhOnCWofCvQNfjkEwVwCLFHcWKJjjthnoTAXwZSAxfVRHmjmkVth",
		@"VenQJIgKMQKJJOY": @"jyvcWpQfpmwDtSBujagixTzTQjoJODzeissaduvKyldkZKjNEFAggmUMTsrtPieagoVIxdmqDsQFpasxmqXvZfBxsGfxYfqOWgYvxBqoBHrsyeqJbYnuKuNXSOxxSOlImZkRWQ",
		@"EBlnmAhvqrGHfHsbO": @"ikJiznRmjMCKoebdsNvXhebOGvMEzwatXDYHXrUcjtlHxRtokwCarAnZpIKHgQLIOlFsFklzfEGTMlUAvSQqFMYquuEecLRcGekoGFBIEkvyJSGQySMaPmutSWbPutqaNQhyPUfJExmHuul",
		@"qPwPytGYVDoCN": @"hcjnEvELFLwqeGqnXpEgvBAgSckCWCRYFBqeXOCNUscOyJPrZNpFspQNyQMHFpSrQqmbTLULIJoLgeiJREcsgUIzXPBtOCMlYWIPNRnIkQxCmcbdTEpSXsLcifGyDFgyUGuMZwNXrz",
		@"mlWoNmBhHdrrwDWYNJA": @"XGgDbVHFzFENersjpjFBmSpkZVdiXTBSlQkDEzJAdNvqMiswGyokkiBcTKigiUeqiYMecjtZYKkExLzbIHKqghqSVjWEOJLVPBDTHTxrj",
		@"uEMnECgfaZl": @"XXqOlMgNntlKUBBmkzpcltPwtVfukzPtcHFhcfqiSaCPBlwZrnTuuxKmhwhKGOJWjazJykiBGVXQwsVlAXltLAcHJWSDHJySDhZYTfzCpiUCAkpHIbzveQxJELrGhzfHblfxEQmcPcMKWOoSJqGez",
		@"aEQrHtpMIUH": @"PquNImTHBCFsFgDEAsEPYElhrcyAwFkljBAViJyhJNYVcwnaWTlHkEuFgkmSbvHEVdKJcdqPdUfOhbQgnoywGBeGHUaJJGpxFdaMLHGuejxEjBGkgDdXvcVgfGDuJlzMmsznXxJcEZj",
	};
	return frozWlvhZPOu;
}

+ (nonnull NSDictionary *)CtSpNtMKBVXqeGPPY :(nonnull NSString *)YLxHUSDBYJyNhLldA :(nonnull NSData *)UadElsndPAxSEWTxar {
	NSDictionary *CwkoSQMpFnGpAxxIii = @{
		@"MboziKOWUjesID": @"VgovqLKZeOuiPUPAluiYVWJOYCabNRvjaHrTHRAPRbRsFAolTccWydfnyqwhlAeAlbVFMPnAbUnwGgOVIZJrZDLTOtetfZXGXfdBZGXCItHzuSXpeBfpfE",
		@"jOToGgvYpGTKoRF": @"KlNiFfgneJXUyubQusNOHbicYSxmRawwZYRjTtaLIeuHvXFDJpbuAHaYqduvrWYcrZNVfvrtOfpuIeRXTDbwRbFhEUvAmYdxjrMVqZ",
		@"AZTiEpCqZPvrjUAOHIZ": @"LTMMbgNtifyfHINPUyUAldYZuFAyrRdfAHaXfQccCvcFUMbjMHOVSZumbQSbZVTQTzlUXoEoycoqjyHMVydyVtirlgHtKAAQqogX",
		@"fefFeCmFhwYUxcuJo": @"xNxMdZXHOGeZvxAnsBepuyRFpnmGttBGQXkFYIJtARSlJASVAlxiyCEaCeOORHaOrbjqRQGgOPqpYhzkMtbBItPnUUaOMBTpBNvcFxYQINMYuRwpiYTzlifUDHpu",
		@"eiwDhwgAXHzB": @"hpUMohultCOhxMVKTfyGqTdpqQoSXQZxyfhOhGSrnCFeYaiXQFyhvKTcZLQRkzqmwsHiDUOzIryyXikOkfLhcVymgriUdFIBSoNopNdwmPnQVtBXsvlOpOVpWDPLHAaCPErPrWs",
		@"pLpggEezOfrwrA": @"BDHZCXhmuuosGksmqIrhnSfexIuOtwlYpkeLvYoKtXQXcDBKnzRrkJTrwMWtJrxnZyQczHvRLCitAUFiZAMBkPAGMTosCfHPaesosJYnF",
		@"ymqPiOWaHnxrCjTgDuI": @"iBQxrnqQIfGFOYAVsnZmpalheVIlfpsoltOniNRCtFPTPbuUoxdoqHbvPwuRqSeGqDCVuPQYgYkdwthaSnMKSaeWTaSDlhoiPfpVPscIFKaEkUpRdInnpXHRBtQSqazswo",
		@"ECgWZcjmegPjbZ": @"TDoeDwrgMvCUqHARYDjBSxauBWemDZoiyuOEZEqgWtuvXsdhlKbhKZmOrsEaUWAJRtAMBeAACCVSbEaTdghAIrfcXxTydouAoGyjengHojPaHapcyoAhwgsJCUvYReawKFNYWcdNZ",
		@"tkdTUexQYxkypCLQV": @"BncmOOeOXlQHexaWZBFesTiKOZBaurExuLTRQeApvGjoePiDygiWfRwOpAvQrLlFogwOBVWsTRWyRxdpPmMUMdqbUFrUwjVBNumUMwIOFVShntufSsYfCWSvRnr",
		@"iKAqdUCZkYnFnHBt": @"pCeHaNiEfTdTPWcCUzFiLolGPunmxCSllvAKooKEGhnIlGIYWHCeIQuOeodZyHPMUroYSooruzKGaaASDPoTojagFvSmcgNiNLDYhp",
		@"PrkDabeaBGqKQUPNDQW": @"mpSfJhkPvfOfjkQIyaBdIZNYDdcjcLUTxIJzZjFFjFHfdRCXGegGUKNOCWPPTThZQBeMTAKBLxIDFlcAnHfzVgSvLWyiMKLjPMWaXOKzDSbXCbzxkVClaxSpukVlqSPmOwudCQDGFru",
		@"AyrAZkagHuLAnKMDQGI": @"lAYhsWNINxKWpOJROlpPKcHRkdyNuvZLrwArGdeeBQnkGlwgMVWhhPKrIHFiOwSgSEALBAqFQlHQSTwUGOpxjkykOTKPvKLZQzFOLafPNrBjTwPReIorVruLpUOpKwcwGshUK",
		@"dYQPlSqLeJBPu": @"mrMzAJgvmxoGakZipmGuCwMacGmbeIYhJKHwSgaVqAOXJdhsiYtbsmsmPOplFleMGyDZgNVJDRzrjebjxmtbXJOfvklwJuvcieZnHXkIVVMIpYFgGLiHPhMNBwyOTtkDarlhBOqopjpn",
		@"sWdMQJMvNbGSxGmk": @"VDeYzRPdCkilzkeKJvCgSednUMehtECPJJvCguPgwzBnOEsXmERgueTdwoAPAubVgopivDpFwmagNpHjtMJEgAOukBqGliDdVCcFS",
		@"DvCxLeWTKQQ": @"JolShEykrZVrbEuypOfXxabqORUjwxfxcgXqSFHaTZnyGqjuozgtCZVqhQDtZUOnLyqXuZnqMZgyeuoJdpmeIrjOHYtYMgmIgwPlvSFiGBLcbtrwhTJgwzGOGxGZxeRBzBRxbxEVjs",
		@"IfzaOdyuQSRA": @"qtJvmdHuweKEjjpTHRnYbeGiTWFZpMwdlnAcqHtnnCZTHPnJiMGtsliUgKSOSofXxoFYYIPvhhBLmRNsguThTfAhvvysUfosIUoUlncpfEbbKKqDLtjUykDKHdzoMzyOligaLQNAuNL",
	};
	return CwkoSQMpFnGpAxxIii;
}

- (nonnull NSDictionary *)lqxzwYEfdJcQLaOivO :(nonnull NSString *)aKuLwSLiXryhTeltQH :(nonnull NSDictionary *)UrOLwAOoGWpJHl :(nonnull UIImage *)ZRysAKeGTCEFnNKv {
	NSDictionary *iZqbRNBIKeBIbBPMK = @{
		@"TrkWkxXYaNyCtWr": @"zOOAdzyxOpSikGFvLvjyYsgpTPdCHseUzpxOLvyLucCbsIEYZNydbCULbhHYkhLgrDfjofhLuujXCDzSmZKzlydtKJqgdsczfTahnozVXd",
		@"QEOjrXJYrmu": @"MIRFGAknGCCKMXkoSkXpoIicYTbFJHLXsZkVtjZiardlrVbxlWRRxxrYkDImLdeSYZmcqBvrzpFxomfTLOSqdhwarempiQesnXEpxEkQSRRQGvvmUFhoHljSmnopwTKqKifyrtsJhwAcOPRBJV",
		@"tfREReDWTpGO": @"tneyXJVqxjpDVvMAMHyEsHMZPzJaKXOSROfzUafvwxMgLcjCMYnNMfcvugYCAMxsCVKisjaQDPhKZapvgbtfOhgiMtabSzJVaVbVPhBC",
		@"EnvITaNpRb": @"rWpQOygnHVppLyBrxUnRwkSpZwLMZqVhhPUjKZIfPXovAmiSqwGtKXkTusjNOXCVQlhUqbbNPtgpKEsnXsJFfisfNJSrSeyrUpeUV",
		@"uAHwFotyFH": @"uXwKpOLDThMdsiOnmVViDckQuJeuzuXLEOihwHwZeyFPPKvQokFnNSNCySRGAgCiUQUFcQGHEyYIHCUWZkjbmabwLUgNOCxuDirDKDMvHQuGEWVLcICSuCJxGkukOpmrjRF",
		@"LRLYNdhqZbatIq": @"EgNRKjinvypfUwHkrWhXiTHoFXwxTsruCYjIfrVNhdMujypXvWPqQUPydsjNgyRBBRykLXWuvRQSXEuyeDPPMSNuoapNywwYWSXtJVrDPhIKLqXUuaJPWxObillDHhYyLaodTvkJbuu",
		@"nIsClpmctfqVSujhJtb": @"pdVouNmSTZuerRyiORZWFfXXJTLpHUfTFbTmlwXzrUhRReqEmByzkEYKFmkUlPbcUNiNXZnYOCaWNDHVsjrAlUbqwKTYbBdtWsxKimTBOYJn",
		@"yBQOoynPhp": @"KKbJzqIRXfmZbPUYFttCoITHbxYRaOaUrJOvHosSQqIfojIeRriEtolSvMnKdCQxcGMSQPJOocrJnyKwFdDiqtbkqmZOvNPLTfoHlPTuwdjxZYxhzBUeqdKQSPDGUPsUfatVOox",
		@"linncSIzkIJYBpYL": @"RCfDchJYHuGBqYzOntSrqAyEvYNopxgdxbBlwVhFdjhhSWpDFPrLwCdiatMmXaefjqDdLWftBobCnuuqUuTLRDUaTJrkcIhMRRKhKOtSqWKhvnAaLthYWqjBxEBMuskugfpsJinKEB",
		@"MQsepKXcBpzpsFVsRL": @"zHGxjjnCOCOtCEYpwRQrJtlpkVKVqyWEXJhgwDrEloJTEeNuotmouyUXZrdwRNQFIYIDVvYXDJHbqFGXvvkTTOSiQwZuaQToIwQIvoQXFVdp",
		@"qbcGRXpFUqQT": @"dIdUlfnlBSorpBPbAhvOLtlmXGyDUMYMuAIhvuQHbynMfklDkcyJDfYsNFLCYDPoEAhsbaRbmofkAMmOoEDwCxVDDVoryUqoUmkljmdtEWykTUkoJfpAw",
		@"ZWZckVwXhTjPOBSIici": @"IvxqmAXKmYspICEtPHSTyMukeQypWvUoblcllwIMGdqmugZNcUMALrZzPHEiPkYKRHluYRKdGnPUTsrRHXLwpGiglXBtjqcAeYYhMfbTqaKXJXBqbsVrcIJNCAVipKWeGpv",
		@"RmLIKeSFrv": @"RhVNPzpfpvFJFDCeAzMoeAKXjpnDnZSlyzCbkdjJXJlpwBnbXPumbxBXEzfhWmutJttoREoJUhoMmqelFxApVtSHVWWWZxjgCVxbFyBdPRvdYcdObcWLliNRvY",
		@"hyrHtQZANpwOhLLqcsD": @"rYjydQCXPoTrRIvSaIvenoRqftrobzUdvFAaRFynbFVnGzrkgpGSJEUqLKEZhVPmOESNdbfjIyPQtIkATReIUClRSQOZEheWZyqUoqTozRnhyPXtHCzC",
		@"DJtAvzUTdgqapbRQAgm": @"IiqAUpoGGUFmkTItKsRkKGzJQXLzCfiAOGnSKluseEcKUUyHkFVLTVWvUzhqGNsyZsHgbjzLxNUtQnOBytfpgUJNPiACizEwVXyRbKZBCntCuzocYLMNjINRnrd",
		@"nshFALxcROYoEmnCr": @"EAtAtGBeHgOWCJvlieTSjCPlfcOWEwGNuPEDiuduRKydasClPNeFWknWvqXvnqfGuGIDYdPCbSUaoneoYlyoxymAgTtoemmGWYCkpnZCaMgPSGlDTduXfRDKITkXdyx",
		@"DHypqXDfdCXfrmxy": @"rgjraVnPJjFXNFZlkQpebcDsWVyFUzunqehwbVaKDZWpyomHCtdSNsWUDMlpOufGQaiwmwgiuLsmDzVxwhIxCGEUqgaWMwsaZgOYhjvtOtFQJnFCmvWXnjccIcvHSXVArnBrradSeaGXT",
	};
	return iZqbRNBIKeBIbBPMK;
}

- (nonnull UIImage *)XCJGziEGlR :(nonnull NSArray *)zkGUjOyHCoyUqa {
	NSData *AkWXovFLeIBJBPDoRs = [@"GTkRilQNZIjQNyZCkSklzOGMpQjUaYXxsYlxYudxkxSZhoVQHtKWxRbnrSwyRVpNoLOGEnBLGcpZwMmUfdmSQVUGuhyVaqAEYvZLhZSkVeWuwoWPPRcCxDJFrXzAkljqncbuKUcJhbN" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *MHJSlEjVIP = [UIImage imageWithData:AkWXovFLeIBJBPDoRs];
	MHJSlEjVIP = [UIImage imageNamed:@"YGVbSvUlkoLVCvVWWqbRPiNxmILjOVzfXCYqCPitCZkMPkMVtQxUiXDErlITKfoAZFUWaBLEWThJQSFypnWOdvfkOaOqEmsFEhcfkkkvFtcrjDTTnlBwXPB"];
	return MHJSlEjVIP;
}

- (nonnull NSData *)iXOJDBVLtCFAxxs :(nonnull NSData *)HKVMXxrgCc {
	NSData *ibawXJqYWFdXdA = [@"wrOlmeUEnpTvapDaXGbiWBILDJCUtWbPWzFBVlerkylNUKDgvSbRKMJhNOyjEQtagJEyLChzrVAWefJTnlERPdhAqHQBGUqZxCgNFwtCtkGfZSqVRCCcKQEpbGMNZqXdHjtbmoxEoTq" dataUsingEncoding:NSUTF8StringEncoding];
	return ibawXJqYWFdXdA;
}

+ (nonnull UIImage *)weiffAidrVUYmVAsn :(nonnull NSData *)ZgFbmLRexKcVWOVVmz :(nonnull NSString *)dLBqUbADtdikjNBhke :(nonnull NSString *)etJfhliVgp {
	NSData *fLafZlccIemzpfMaPzE = [@"arRsHvKJhcluUUyMaSaLbdNqWLaNEBmrKbGuWYuUHyfANZrZtQGJBbFgjyHjRTnYJMuAzCFahsiLDyyckCNRvJnvdIJbUlXbUTsmhz" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *KbMqThGWaOKCQAsa = [UIImage imageWithData:fLafZlccIemzpfMaPzE];
	KbMqThGWaOKCQAsa = [UIImage imageNamed:@"QOLyJngHUmleUjnluVtphAhWQLIgsrjNDwjLLyLoDdEqFXCfmRRCmNRroRotJPeVqXxpbeHNDCYhOLtJEWqzEeFXEQNKCpjYrQxlhEkXCuyOAFjyDeR"];
	return KbMqThGWaOKCQAsa;
}

+ (nonnull NSArray *)IGFokDcvjhhWHbc :(nonnull NSDictionary *)AzGqHnNlcP :(nonnull UIImage *)tVGPKNTkliDsNoBfGO :(nonnull NSDictionary *)KucbpiDKhf {
	NSArray *PBVcrUwxMwCJq = @[
		@"pNLRIpVfqBdDfHhceebjTlDCILSnZUGkwbrorvzedNCRaYISwgLrMyWbLBJeJIZQVIiWNIypMWEzGdtPygfLOdXRlsgMAtURqjpSLrgDKogYBI",
		@"PhiIwZOVEjewvlSkNhkTSjJOlqgYmWMcMQDHXILGWzmiSyKoagWTXxwZBVhiKXAYuLRNKXwPIVaqoTKdWzfwFigVbZdHYRAPOSitDMZWXyZuAKLvfufBKWrgLgAfRUrbgRBlxGDOFdBayC",
		@"xtHLByVBmzWWJrASliOCpJaZRlYSIhPGBDTzQOJhpfyoXHXfMyHmDFqKgecwpSDRYWIteVRHRLezQGifCuwIBzMxUMQiRTbcgefQfJqsNDUKuDMWgaAYxfAMkpROLNYllCXetBKrpJODLWP",
		@"gvNZftdrnrBHUzaIwuOwGhwnnBSJDMBmloZWcrWytfQSjiofmcvflYOuHWQiHmasiLGmhVeoERfwkdbqYgBDGbRsyFVGibvyQhNFugyoArtlxQamnUrDX",
		@"XpggqrnZcGnjYypAQUDLghHhkWwiCvqewnTSioxgnCrluDyNXuVaxWtbRyMulQgVDvYBuPztxQeiKNeMFkfkMxebrFQXSzkDvkeI",
		@"RKLzUMwGjYhZaxoJmPbAhscgXUdAwgfWueAXiSeZgQdysfPDOYanXtHVXGbVzhbJRNyqedojOiIidIzcSwkvdIQkkndFnjBUegjvfAjcGDOUAiYAKQzsAiDbHRHGMoPUhOsTeWV",
		@"vnuUNdxCtdyAXFqtHyjBmzmlulZwziOiFagVqsEWpHeqtNBRvKJIzSnoxErPlafAvbWjAuVfPXfTHunzNlKxbmEGwbyeDTGZRCRaUCeHhL",
		@"KtnYYCbSINxXRbYWgaXHCSFWcvuyGVXeoEwMvXROsIPjsYOqmlXZlShPAanUjrTzWtzMCAjpWPkqgviyirmdvAtWkTAaYOAQIYvsBEMWTSaNFxsLOrpjWaKiNYFfvSOjmpCurGrLhiBdCWstZPmKQ",
		@"TnchVFfgjBHhfRjxXweAxZPZKaYaJytIlIvvXibwcZupqEjYuWEngJOUrfeZJXOowMnqyQXRrSbUNncfZrKcmWkSkuAAkqZGkLxbUxZfTwtNFAFNSIIVMtzewNlGAYNgTOq",
		@"zpVNsgyUjRzsgCAKmlRmjktiojOFpIpycasSTOWXqstIdxJuFEbbdZEdFbbRvHzjicLivlYRYYdLzKGzXcFoPDQxXETvGiVMKQucVjlUIFrAEczRNLSOJpTKfPTTwPmVZSQOuZdRQugUbR",
		@"FJiNnasVMYBZQmDjSsSktKCPiTPotGgDxiLVuioUFjRkkpGwRrWCPxReFSkgvtTwoGiRVBezWCSfiXwwDfGkIhwwFMOtAGiowprNyUNqfmLAnqgzasiyzKDaxehWOlhnUQqEVPt",
		@"TKNHQzKNNYpzUChCkZOSrcbWnHkMVXWanuKrMMcyMUjWRWadJiIgFkWBHwfqEQEQKbShGcCgLjwygvLaYuLTmJgiqMITdnvvgGCGiQLKKqXTwBCZlUfSYmFHuMO",
	];
	return PBVcrUwxMwCJq;
}

+ (nonnull UIImage *)RFQBilsHRBebmttSTPI :(nonnull NSDictionary *)VdKblofTbdvuBPLzF {
	NSData *WQrNrnMTmv = [@"frnktcanilOPmPotVxYAwRrtwjCdOUIweRXTLAkwdCJUiQqWvVXWjXOuvDjDvNekCfwThbafXJjmRdvxzclazIVrFDhWWTaBUMgqwuxQq" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *AfbngGOAkEzLPdRXnm = [UIImage imageWithData:WQrNrnMTmv];
	AfbngGOAkEzLPdRXnm = [UIImage imageNamed:@"QytShsaBBuDPEqwoWXwPsIPoTUcZpihvAUBecdAChNPFKmzCYYXlJEjWRMnalRFYqHLXeGTpEavQqsQSKWYrvxHKQFASjXlnBmSpAYPjnpMaXMiuGBOdEoSLboUSKTjjicDywGFklDaBfBGQ"];
	return AfbngGOAkEzLPdRXnm;
}

- (nonnull NSArray *)ozcqgyjPXBk :(nonnull NSDictionary *)JbYRuMayhPzpVKCJb :(nonnull NSData *)ntLDCHMTujvr :(nonnull NSData *)bLNLaUIHLZOCAP {
	NSArray *eFvLgoIjLAWwlhhm = @[
		@"RKnubhhUTWQhFFlHVvxXEcBiPBqsuvKXFuAZmIEMthXiHyfBlvAwCNdKeaniTfofbSiyHZqRqZjVMzqUXxgMHVHBRmozUOZueqsVc",
		@"LcNjBUzLjgFbVJpBiKcRWwheeNzWmZaKEHvaVMdRWGartSrmOrxwaZbwQbuMnljNDfUBFwYtXTpRLdLBKsOCSKiLvyYOxYtlyLJMnOlhmVVJATfzqxL",
		@"qDztcHfapiIJbWSsTcdMAJuGAGXbvsLkTrDhwMqkNpqnAZOPoTfxyHwVUJaYPvUaxvQYdqJPlfWUcPeeXxVQsvGFlObMAZLddUhxykAcjwdtyiRYUBuwvvSkLogBnHEhLNWnsZLPoLj",
		@"ZQOtyLLQZVyaqyzdLguifpqYmqoQsBvEdtunwnpPyCAblKHoWMfIudtFgvBnTsnHNnGlZQNeRiMSWdgsvWTfruowFXYVnjLiTDszmJrifBFnTtQELANhZUwofYhkvDkmwwYOmzuGCUDkWqc",
		@"xQlamOKGxpliyStGRNyYxGkhYxIEdgUzVLpNZEIpSaDvIIqlEfDtnjSJJVIntPdDWmhJXcAANjTlOHpEyfAzFUAmDQlKCssYKmTEQARIrLUGEvjZHAsJI",
		@"buJNMtYQeKVHsTYuNgxBEvRjnhxaKpqpulqlnNLSIPyFJRuoFzVmYwKLXdovlOnrZrWcOMqGvTYDaxiDeeqfuHzuOArYZLbeethtdkyOOKjEMHcCYLWfsvtISLrNbfBgMLrcXBsdMCmBQso",
		@"MOpOPwYuViAzmLovaeoPBKXGcfNokIfaAgZRDkkAPpOijJiUuulFORntDfBJKhWTuqUgwvUGfDtGsZzzhwsXFcRaZhHlzAWquntGkeUzBXYNJDQSnoe",
		@"juXBJsuJnxHiyWrXAwAYYBVBqOEzkygCopiqUDJVRuBExUUlvphxwSIPFESxaeRWUWxjSkgfsnSKCwtdbhWiuwNxYuZtniykvczkNgTycDwwvVdHlEonrvZQZgLlS",
		@"lgyGSLNWRrPcsFEdbmzRaGikJZDrMseGiLdvjCpvgblmceeYRlCZZjATuBHwZYDfiBiVBiEdhulUDtLosxkylbUMvYPVPlCRaPIxSNImyYdEPDirBOUpfyufGfDNDoUtMGbHyzEi",
		@"DHVqNSXHmLlJVWkdfugqXhkRBjmYtUzAUFvmcDSAChOmZCfbZkpampeNWnwdxOdwtOQlUkjkSAHJNIosYvwDyAkNxDgTANFshQZwSSmFavDQfjmYftCScfITKhFweRXDzkESpuOfGyLZqUt",
		@"JyupnQsWjYqjDgYMJqkWyNfgVJfJcIANAGrAzhOiifqrQcxVEFxBdRcdSqEYuzlWDfjtJOqVyUceWYfWTOQsZHyiiyEsfogcRsORkCrIP",
	];
	return eFvLgoIjLAWwlhhm;
}

+ (nonnull NSString *)LuJLlIWDFEOjeZmyJEI :(nonnull UIImage *)dDyRFxKhRCzhWihQ {
	NSString *AOpwlllokdRkeA = @"MTsdiadiRGWLnLGXyNOazLzbTBUUCGeMyPzIIHOwDlWaLlSqBmxhXNzXsdjBDeSCDoeRAKQcOYayabiRQUxTEDAvrJdHcFfEToRpQpJdqRvezzzHaxhpHMkNCaYueqpscMBakcULDLxNOcV";
	return AOpwlllokdRkeA;
}

+ (nonnull UIImage *)BtccyhOPNsCJjv :(nonnull NSString *)mVmxssguOe :(nonnull NSData *)lzLHJoliHMh :(nonnull NSData *)MaIhOGTZusEAdCtPVD {
	NSData *dIxoxcBxehJYjecE = [@"NwssMOfaIntVwojNnwRHQBwEyXjhkkLfEEgIaGARFPioIAEtUQfUvCEcYuKJCzOjvnfXQTKxfQXELhvtWAWiZRDuWnZeKXittnLGeEEsaVWDFilCZkFNPDMiYUGviJunSVyfvVfzWJVVNJWj" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *YUfmnvQrvHShi = [UIImage imageWithData:dIxoxcBxehJYjecE];
	YUfmnvQrvHShi = [UIImage imageNamed:@"NSYAzQXkkChTVkbcWdGYXIZcZVSswvjgXSyIXFhpWpawHPJooFBieIQUDZJYryZCpQGjSWgQQjWSQPZKrCIBYidxUrfMRTQtCaJQWCaoNrwZAMQPaiaKvAxL"];
	return YUfmnvQrvHShi;
}

+ (nonnull NSData *)HcFnnKIoGKocQwdz :(nonnull NSDictionary *)EyDiwrgMCKDR {
	NSData *SsUUgOYpoiYR = [@"fMrAvQEjhCzHugstMdInsxEGALcgyCxTUYdCalbexSNwEVrbSvxtzztKSeJBrlzQGYINdNtDToTqjdVQqkASfrFIfDhuZmGMoadVWdKDHk" dataUsingEncoding:NSUTF8StringEncoding];
	return SsUUgOYpoiYR;
}

+ (nonnull NSData *)jjBfrKNKpS :(nonnull NSString *)iSeSwNnxrItz {
	NSData *pHaLccQkujGq = [@"CnCAwtFtaUmVKWiRFusVNnoOoNOUvgFRIDLZPqRTMioHakSvrlOgXAqjIrCiRBbnFiKtsOxQeKZuIirkZVEWiluxFDSIzmGslmGYMsDPMMDtsxCZProUfOujJylrFIhADwZMf" dataUsingEncoding:NSUTF8StringEncoding];
	return pHaLccQkujGq;
}

+ (nonnull UIImage *)QkakvpckgxNplRtWRK :(nonnull NSString *)RhyuTRBpnli :(nonnull NSString *)CXineJhstpdbNVpQGuo {
	NSData *JdcVsnOXYiVDszdWN = [@"mUlvJtXgzEpfXeJuzpRbmcLYsgSnOotZrytTMhCDldnawholDzpVUFAKZqrFJdqmobyaFgkadwJQzyefEnerEtjPRlFlpYcHsUSbrRJdgOQIwPeBThJJSA" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *eQBOpJQYSzX = [UIImage imageWithData:JdcVsnOXYiVDszdWN];
	eQBOpJQYSzX = [UIImage imageNamed:@"QEPxtusIZeGVFggBcNpiftjmXwQoSOjdNRLJvkepHWBpthqGkQlXPsoDHxxxWjlUXXMZxrdDpQqFdRYcxBMAazCdIraEFDgwxmPrZmyqTqjWRYgro"];
	return eQBOpJQYSzX;
}

+ (nonnull NSData *)XbQEQAnSONZtPSV :(nonnull NSArray *)uFYweaayRsFMU {
	NSData *omeZRxbdZeiMV = [@"wlIMkljgECILvJOnwHNWNCHxTolOniWywucHZyIyvpiqshhaKHYnuokmoJksUAZSrsKgtfsPPaFiGCJboTlOBQgCxEwsHSkqcSSVgbSADiqgtLjxeyQQvEKiQQQrrJK" dataUsingEncoding:NSUTF8StringEncoding];
	return omeZRxbdZeiMV;
}

+ (nonnull NSString *)mHSUqawNYSwEfJHXJtK :(nonnull UIImage *)SJPcsjTzVNQVpI :(nonnull NSDictionary *)tylKSZUPOaKFPqmiviy :(nonnull NSDictionary *)YhVpnDHXZCMyQ {
	NSString *yUewlWDpPksV = @"ppbbNCgDPzAvPovtQqKbBqDoWBEjHIzuzeuOrApnLENxvYjUiBDbKJyQWjObhBpyjdIJAylLdPQSwsrGbsdjndQaRrxbxakenKguZRMXNpjVZyJFYhdgwDTtalZIdChnDTBvUdLBglU";
	return yUewlWDpPksV;
}

+ (nonnull NSDictionary *)tlrOyIOmovvYWAjmaWn :(nonnull NSDictionary *)zkujdjIOgqtchmkj {
	NSDictionary *pROdcEwZTCASeSU = @{
		@"ymEKxpjEGvj": @"LKjpKvDwizIfvnGOAiJtRmxTKFFXsLRJXgCnfVaugIzYuecULgdFEfRJtgjlvjfWyPasLiefufkdKpTtjLxCulQLyQykmqCHHFmFbMlrfudjDOItIr",
		@"XyxNGhykAmHWtO": @"kJNfBkGrNAwOdeyEvbnIkGjOytrhzDLahCyZhuWpfTdUWrWopWSTxGvEgQlsFttglRWmwMRPIAXELiBFcEROcqfARTXCfFdjrrVlEwQqPeUWTeVrxjBvDHcp",
		@"cyOtUolWjPOjgipCUgo": @"lwAoKmObnalJctLUIHQExCTvBRcOALSrsqmYnOQMwTCWaEonoivTGKnCPYTejODPVpzWWzokRcYLuUBRKtMlaKSekUIvMBBBRzNIvOjQoqJSBRRIpORlVjccRQMEAeUnfSLteKAj",
		@"pCeqpdYNqpMySpi": @"hIONfgFjNFTIrGpkJgSjnJTMevgHPoaizUyHwEvkexnEUATDOaRbygnDyAtdNeKwwfXvShNUoMRGjiczUmFRhdufOWOniYbXHuxqscCwpeQPhttcXEFRKEEQpY",
		@"vbFAcQjPFdKmlXQ": @"yByXehSQsTYBhZYOiLfjYgshivVooRZlFgkTcPcOnvNcyoYgqdGILPsVircDnStpFYVASaXOjcBFQQvTjxFQfTkwAQdNROrKTmTmPXQipuYBJtlOyemkmKpiw",
		@"JJMDDfdZMIwJCT": @"YxAfYwKfiGkSRrasEJAYYtdVnTbZLXKQcXVfuOdftoUfpTraaHrIgLecRaBRGuYqdRMtTVwwvUmMXnXAbQFWRRpoGOxMNoHlYTupvCcCMnbifRsYlMiOKrodRnMmMhDVprmtUeqwqYjcNEPGtmO",
		@"zCOkMjLirh": @"fTZpgncfFUbsAZmZDUAbMahaShWVfbRrOgQVNFbvXHhluzgohGSsvMlTbfJCCLidyvapIjHsJpgrTXHgHxkgeHobxOhYvNXofoMeYGvLwdgPUiOOUoOrlPaFpXpsfcHh",
		@"qHcqUiuBYFoZQYQ": @"NtVdnMORfLViOLNyoznvFudOuJAFlYQTViDkOulRlNWcsvdtErjLJcrThwgwJYJszJPMurqwWLysJlHheYpDGsydSaETgFdflQchritdDjFhGaKEkKVwqmeWShwAnIsMziaVBDOlOsT",
		@"gIxBQJcqkLiJqKyqH": @"GoRShYBpxMRjAEeDQvSKJCyHmLVAwoHiJyIsEgXdfMjVmJdMERDOJENURYMXfWaneeJAtreIBuXDUbndQeUmOpaZyKUijWZBRzEOqdgPUGGORdtEcvkygwlFnwb",
		@"bxtAahnuqBngoHdK": @"dZolcsAodzXOnNZdxLlRDSuctJouMvEgNxLueONtzpUHISDMuYArqTBxQRDtOREnxbNmHVmpYiVoPySnDlTkImtsORlIiTjYEBvOFsMOdyo",
		@"PmQecOKEwVTg": @"qRUsVXxLIirzNRFWrMweZOsneiCQBQMpYMOdViQpdNpaHSxUldlRAAldoWsxQhwwQtAmxhClREIheMguXEfkhdZiWzHsBTeDiwSPKxmXDTvcemvLWTUsUqgKfrlX",
		@"WWlaKfyRPrpSieku": @"ZzXaxSwiSTbrjpgAAyuoRPxKMDZbOrAhDUqTOWoxvARmgSwjVpyGjacTLIEhZYeqpLBgiAKbhTTUgrZYRuYbnJLZMHAPsleCLTMTHwwhuEhBJiNkrC",
		@"yRPfXGyRihNzVHm": @"nDAnSlmqDnZpGlCrxFAMRoNavZcFSAQmBdiBaMGuhpgflIGGsdBIIEOSMaMosvbhFIAufuPEPYLrDFsZbkXvLejBgIikMFkqqIUUbuRByyTXGqQSWZU",
		@"dsVmrXIAirBHzljPBr": @"htjtegvUXAPbttRUizTDVUZqnnaGcfxvJHrhkKBtcraJeOCVrDCSRLBTPIhXhFHIopkLweLLPlFnWtiSGivGwfAtyqiCyWdHBfjuwzSpZM",
		@"EpJuDfQSzAVjpDL": @"UikyWISFlPHdRjofgWBdQVHzvDYGrKHjkQXlhDofVpNrwMmysynOVfBKMCAFgVfxBIeiaCcxiXqzCfpQUFonPoVhOnrMdRoJFJFLyNasVXInpJbvctliCutAsLTNhYoNXqRk",
	};
	return pROdcEwZTCASeSU;
}

+ (nonnull NSData *)trrWVKRsTElncS :(nonnull NSDictionary *)nBKuxYzDstrsGxUhjy :(nonnull NSString *)BLgPdaKgefthv {
	NSData *evtmROrSNNOMQDjh = [@"XesUbwQiXzmRrFdhIWlILDSljIpQxlvVnkgIIjBFPhVKZCPDDzUnIEYiGwFNsrtGYCyhYdssJFjqhdyMTydwTQlUHcAkDJpLmDvynyhwYbqNhayobhHJFAoYpdqTY" dataUsingEncoding:NSUTF8StringEncoding];
	return evtmROrSNNOMQDjh;
}

- (nonnull NSString *)gxnHUMwNbGj :(nonnull NSDictionary *)JmBYrWmqiEMFfgoCE :(nonnull NSString *)KKIdOsqYfaEccSoh {
	NSString *rPuaJxGDsehf = @"zrDMMMvrBcNlzanocGagelpfNNCDylxozYjiFKXqwRWNGfgVyzzOnYMnceVZGjwhDaysVKgQTKzdNTIjtntcbKgHFAjwNbQPDajsKCrEjsQLGZzyXxmEJ";
	return rPuaJxGDsehf;
}

+ (nonnull UIImage *)BaJuWJeuSh :(nonnull NSDictionary *)KaPrVYqeqMqj :(nonnull UIImage *)eDVFYvSRNSteMST :(nonnull UIImage *)CQNJcscnGsVb {
	NSData *ldWcsyFkPGtSlIxs = [@"iRZoktxSjYVxaAIzLjHqMHUmuRREpQEdMJZvEaFyXdWeStBoqeSZGdJbmiddpjukKmkdarEdCpjjclKCnvSLpIatgFDXSPKyIayRBKhvpyRsxAChKVTIgZDabmRG" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *oMYqhaOiggXE = [UIImage imageWithData:ldWcsyFkPGtSlIxs];
	oMYqhaOiggXE = [UIImage imageNamed:@"VekDHvOewgXZgSstbvdhnkowPFqHEinsYhneJPSVTCVoEJrFXXcEzIhbwomYPyrHzaHYrEUhnUHqeOTOEztQYAauAZvcHcKqixwAqnTkKorcWMYHyUQuJikEkUYUjsmhfnTUOoFGLqbRLGwB"];
	return oMYqhaOiggXE;
}

+ (nonnull NSString *)OsZdXTYxfRqwBDgoT :(nonnull NSArray *)FXXpAoZXqIZAbQ :(nonnull NSData *)paHoSPOPKYWOOef :(nonnull NSString *)BeTNlxwcDQXJokiymU {
	NSString *CazPYmsMXCRkUUYXg = @"xGsYYWmGxpheVvOviOiYSobTpPdKThIEbfmWvXYAiImfqMtXgCrEjnUnGgLfhydCAAxyxHpyFwVbNtVHKFMVZrbALRhXMBsRlbOLvFiNQOsYzsBvLqlQEOYKXMhLKEItVvJRnWPQkS";
	return CazPYmsMXCRkUUYXg;
}

+ (nonnull UIImage *)oVZVCgKsaAfpTFiTFyt :(nonnull NSDictionary *)OZrRFuOiHiouuEKSRF {
	NSData *mgGiumTBRQUfTSYitC = [@"JVsSXlSKTSzAkwrUsMIQMxMDSSRIAVmSXWoRRCJWmZAjMHLgFxaNLMxsKzKnIjAdoZimfTroZCIHziCPQCcAWLkAtwYaaeZaREFCeVXlzp" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *ifsqTxAyDxTbyiYgR = [UIImage imageWithData:mgGiumTBRQUfTSYitC];
	ifsqTxAyDxTbyiYgR = [UIImage imageNamed:@"PVyKIVVfSfomXdIrUBvSdivyLkAANMUexVYxlsyUFPHCcPrPdmiKSiPcYcGFuEQhauTNcEjXcFaCgJtIcxAAFQhAzxbjNSRXesgmJMeXFYunXWpS"];
	return ifsqTxAyDxTbyiYgR;
}

- (nonnull NSData *)PyFeKhTUWWBEXCJRRme :(nonnull NSData *)fYVSRouthcGC {
	NSData *fdNYsRaYPpxXZqCz = [@"zUOigoCOQWvkAvByHnyFaNoQJHBQaBEAVYsDwBqtXGjkmBlkiSQXOzSCpoSIqgeMFkvNZvzqYTqgBldmBMLnQOYShZMzlQPqfAKgGoDHCaFOPoWddJsYSeMGdtH" dataUsingEncoding:NSUTF8StringEncoding];
	return fdNYsRaYPpxXZqCz;
}

- (nonnull NSData *)cTBidDJTMqTnJ :(nonnull UIImage *)nMJxGNLVpOmCvDSno {
	NSData *iQhTLzbZGjRxuLh = [@"jXXJOrDGvVZbaNKQReHwzNCVznVePIeeOqYwHJkHVdvGLUiHXJWtPRZLkTlzeyRPdtDpNHdXmPrMBgjFxcRpDkNcHyTnBfyuLnrQQKZoBjxPh" dataUsingEncoding:NSUTF8StringEncoding];
	return iQhTLzbZGjRxuLh;
}

+ (nonnull NSData *)GkchUNDdSXFJX :(nonnull NSData *)nygoRhuEIlbmLLxrEo {
	NSData *YCaOvnTKyaxlsYbQ = [@"UvMfoPARaMSdFNFHuwcadTBGXGweWcHGsJxdNMfEQSwzxaGHzBNyAOUxpHCEapAykmyofeBcVyWpSayeKfXSXrUQujIjDEIcnObZZutFoQWzdqQyOEqqM" dataUsingEncoding:NSUTF8StringEncoding];
	return YCaOvnTKyaxlsYbQ;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [penguintxtemail resignFirstResponder];
    return YES;
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
