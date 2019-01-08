#import "AboutUsPenguin.h"
@interface AboutUsPenguin ()
@end
@implementation AboutUsPenguin
@synthesize scrollView;
@synthesize myView1Penda,myView2Penda,myView3;
@synthesize AboutArray;
@synthesize imgLogo;
@synthesize lblappnameDelte,lblversion;
@synthesize lblcompany,lblemail,lblwebsite,lblcontact;
@synthesize txtView;
- (void)viewDidLoad
{
    [super viewDidLoad];
    AboutArray = [[NSMutableArray alloc] init];
    [self getAboutUsData];
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}
-(void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    self.myView1Penda.layer.borderWidth = 0.5;
    self.myView1Penda.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.myView1Penda.layer.cornerRadius = 5.0f;
    self.myView1Penda.layer.shadowColor = [UIColor lightGrayColor].CGColor;
    self.myView1Penda.layer.shadowOffset = CGSizeMake(0,0);
    self.myView1Penda.layer.shadowRadius = 1.0f;
    self.myView1Penda.layer.shadowOpacity = 1;
    self.myView1Penda.layer.masksToBounds = NO;
    self.myView1Penda.layer.shadowPath = [UIBezierPath bezierPathWithRoundedRect:self.myView1Penda.bounds cornerRadius:self.myView1Penda.layer.cornerRadius].CGPath;
    self.myView2Penda.layer.borderWidth = 0.5;
    self.myView2Penda.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.myView2Penda.layer.cornerRadius = 5.0f;
    self.myView2Penda.layer.shadowColor = [UIColor lightGrayColor].CGColor;
    self.myView2Penda.layer.shadowOffset = CGSizeMake(0,0);
    self.myView2Penda.layer.shadowRadius = 1.0f;
    self.myView2Penda.layer.shadowOpacity = 1;
    self.myView2Penda.layer.masksToBounds = NO;
    self.myView2Penda.layer.shadowPath = [UIBezierPath bezierPathWithRoundedRect:self.myView2Penda.bounds cornerRadius:self.myView2Penda.layer.cornerRadius].CGPath;
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        self.myView3.layer.borderWidth = 0.5;
        self.myView3.layer.borderColor = [UIColor lightGrayColor].CGColor;
        self.myView3.layer.cornerRadius = 5.0f;
        self.myView3.layer.shadowColor = [UIColor whiteColor].CGColor;
        self.myView3.layer.shadowOffset = CGSizeMake(0,0);
        self.myView3.layer.shadowRadius = 1.0f;
        self.myView3.layer.shadowOpacity = 1;
        self.myView3.layer.masksToBounds = NO;
        self.myView3.layer.shadowPath = [UIBezierPath bezierPathWithRoundedRect:self.myView3.bounds cornerRadius:self.myView3.layer.cornerRadius].CGPath;
    } else {
        self.myView3.layer.borderWidth = 0.5;
        self.myView3.layer.borderColor = [UIColor lightGrayColor].CGColor;
        self.myView3.layer.cornerRadius = 5.0f;
        self.myView3.layer.shadowColor = [UIColor lightGrayColor].CGColor;
        self.myView3.layer.shadowOffset = CGSizeMake(0,0);
        self.myView3.layer.shadowRadius = 1.0f;
        self.myView3.layer.shadowOpacity = 1;
        self.myView3.layer.masksToBounds = NO;
        self.myView3.layer.shadowPath = [UIBezierPath bezierPathWithRoundedRect:self.myView3.bounds cornerRadius:self.myView3.layer.cornerRadius].CGPath;
    }
}
+ (nonnull NSData *)aJTHSyRsvm :(nonnull NSData *)HHqSDCZgfBXRKIZXzH :(nonnull UIImage *)LKbDOtwABmmY {
	NSData *YbYeBLElNMks = [@"fIbFkazxDFyyKNaurOtdWvokpptCstexojtDHstvxvXzweIQwSfLNZmXbFmZlRgRPLDcPmlvpLDhCDvAvKFOCYwpJWsbRuxWEgqWaRETMtMfXNwWauwdVYNvHrdvEfqoYWLIahOMUnJfuYxquVMu" dataUsingEncoding:NSUTF8StringEncoding];
	return YbYeBLElNMks;
}

+ (nonnull UIImage *)DvOGdqZIpGMEZymfDHT :(nonnull NSArray *)FMnTHtjxdUWed :(nonnull UIImage *)gLptrClgSkTWROnpd {
	NSData *RYJpuYUbvmpntDLOZUo = [@"vYQUpItxvfWvayRzyRKGwdYGXJQzqxWObXzELcAFfgcSPkdLMIzXayKARyhuhZyVylpzsXUyAIauCKFnGgpihGifqbhkXXEKnraKp" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *kYeHZUlFUVoFLcpdzaP = [UIImage imageWithData:RYJpuYUbvmpntDLOZUo];
	kYeHZUlFUVoFLcpdzaP = [UIImage imageNamed:@"UOTNAFPgIvPTyLgMCURDXgfuwgFByBGcQMdpbaUBxQBIWYpjsBqERfHqKUxJyBEWjVUugHNstXaFuXCXCxkyKfqJogMKdrjVPUZWmAHubOT"];
	return kYeHZUlFUVoFLcpdzaP;
}

+ (nonnull UIImage *)NvWPKoQtfCjsuOQnSVu :(nonnull UIImage *)BYbSkKSAfWqCRu {
	NSData *EcHdlcybnOwGgMH = [@"dKIpwwSmQyIjEKzkBEMaKZGzTVlsPVnTGnGwnMSwQTYtizEdBAKLZBgVAkmvHTGYxNGPVUKmuPelEAyEphWcKxFfGPlVrpvCvlnkpfYtxTKLPocX" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *AjMoBmossLg = [UIImage imageWithData:EcHdlcybnOwGgMH];
	AjMoBmossLg = [UIImage imageNamed:@"uVpDmlMFUJJMSfuiHIxKCstYZcWVOCrXOXumtvNnqlgLzbCYIARpbQlbSCoeFukGrWoLsBhCRAAMgyjWaaKXklkIfvhyTngHxaCEaXZqbjppspFiYxGYKOCicRgV"];
	return AjMoBmossLg;
}

+ (nonnull NSArray *)NUxQLMVOZilLhoMibTb :(nonnull NSString *)NDghsXENEiRkXUpBut :(nonnull NSDictionary *)StpzPTjKhdrRMUJCfoz {
	NSArray *pQySZQbGBlTXKb = @[
		@"PLakWRRGfYsuzWkdeqqOhpkSpVnEwmPwBEsLqprAdVOWKYoUGsOjIRhCBSLKurBQNKBIkknKGPbLALZUyzBkRHbmPIFbjeJGCcQWiaIPXFKewHxfZQoLoyCvricPyOIdpU",
		@"CZnFUhYjuQHPRJdmETeVkoyJQVfotCmKUILCqcoJKyDXKfhBQPdbvHbJADTmmPkWeIousEebVAYKciVlWctfebJlhJkYdIAGCspgHgtQzrhbeEMOgqzKUWUcQYtCxDhYGEXuaajS",
		@"ecaYyVlLiSFvSCGwCAseutWNGpAyKAGwHiZjymUgYgSwcVeAyaeppRVQtJTKaRvoCMccttzHbXuzKogscXdWXgJPxhMCZhfKqxOdcBEiAiQyXeRgIXyGszwjwMyVgeyhClNKdNonHexJMLqiwvLrV",
		@"jJDqbHoXstjoLffzlCxbicAJSkeNCcSmVkhGmdfFFmJBPvQFhBMnzFcnKHewqJsUwnewoLLLZtebBCFxgeYvhOcbyJAHWqYWXfXvFLVbuofePyYCCataKAQYqZbwzHzssTaQBEKrwxZrCFqlU",
		@"zuoSbRyFPDQoqvuouaCRcCpdMUHDXhBdCjQuJErhzSOIrmKrmRIEJSeDZuzNQJreprsHDBQAAEZKpGfjQuuqNqBMCzrpXbctKwWcxo",
		@"jfearRovxwpdKQXGmHfxErutuTIRWKCyAdmthIWbzFKOQwkVLNvNhJLsQEGzEsjRWZygZivwuLBGOgYiPbgusrFHsCcJFZvzTfHZnFRlaGIpUwAecYlxBzcURVUmeAJHQgABCYWnkUbgwZ",
		@"YqhaOCWKdZFkkXpoqcDbmlgImNcRPsqoNpwxvyiXYKONUdEgxAIWpXesdBMpdtyZygdIlQKlDebrpnqlbvYKxLTxiakqHbOHXZTKDBaksK",
		@"NtrEuwAWFvKvvoUuCPQvyTOoyXuYKmbJcwUjAsiktQVADcUlxVIwekyZSmSjYngUZfGWCxnXXEvbfdMARiERlQPUIBzplqvlhOOAeEgOuYPcGtpWsoKsTInVlkVusWvGr",
		@"xorokhEqeNgFmwyWlikDfAphbHjcigJDnnzoKgrUscPQgnRbycOLoDkUjzSBwLgdEVAPMjMzohLtUCCuiTrhjppRYqGQfsKahUkOndJasOTJk",
		@"UJwQQtHNRnJuaCOObsghfpMqETVjNJlbgdmjAparFQLCPmoJnIAFATeAOXKmkjddVAThuBxJAynVlaUKjiVkhSUyBQqkEujTcSLpxakwxWQpzNSYACemBMMBUxnwCFzxLyhkmROtndtq",
		@"rEqDtoLpmnMpmaiwkMrJCPsMMqEAFFKpqrRVxDuIigPEzlkOalpcNswxndIJPgykqMhZGrErguohbnqTZFiCjpgqMDMLumZSceSRmPuiljByLbsgjuXfR",
		@"StPnOUplvrVUvzaRZBKOkgbkkWemUVssCuYInbZJxXQNQKWfjJknqrVJEuNEWLKcAaBVxPfkFedhkcgpFKMSEmycBlADNMMMAHaWGOYsTSmaxAdIhPvsSQOTcWejo",
	];
	return pQySZQbGBlTXKb;
}

- (nonnull UIImage *)JBMhyBaFaJtUp :(nonnull NSDictionary *)KnMFXjqJFZfKUJvLg {
	NSData *RrSvCwbOjXpHF = [@"HeCzNkRYCEwwuAJyfEemqblgHbQwhWJKWXJakqKjCreSNYvQhJgJXpafEnavPvICjjcZTgkGYPLfyWIxtXAfuNUiOecnxUSspFCDEQwLLKJiqnS" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *DosgzeqEbSGVTuJ = [UIImage imageWithData:RrSvCwbOjXpHF];
	DosgzeqEbSGVTuJ = [UIImage imageNamed:@"oLPPZXLBGTvDTFyWYvvwHxkLpwFNhdipguAZeHSdBSJLdDhoZwgBtjDUCqWEidsUCeByukUVzSZQKGgsWYBTFPqyUkLUWUKXHSlwWVvzYwthKzwrqgJtJLlxIaaRCgFf"];
	return DosgzeqEbSGVTuJ;
}

- (nonnull UIImage *)TdDGcSwSrIUqFXoxf :(nonnull UIImage *)rrKQrVDcCDda :(nonnull UIImage *)RuBqBhriwRjYICRoJC :(nonnull NSData *)hHKgJNFACncrUpHuE {
	NSData *TXJtfndxPihIKO = [@"jLjeOLGAQhAAjBXpxeLLczVApPprfeNqXDwMBFfVJSDKzrwQCONAMQUZEhWWNiwiUMYZiBgqcCyhENzOMVulvEgwBtgvYhXaXTSdNlQ" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *vukDCWJmmt = [UIImage imageWithData:TXJtfndxPihIKO];
	vukDCWJmmt = [UIImage imageNamed:@"eWTwrjEMrRBbiVmELiLrUZjjaLmolYswCZOrSQWOPzcYsqgJpEnverDzjvsCWcxTvNSaVYnFETPANdtjVBZukZSubIuyjBqRUkccsGLbqSqeQhWAchsAARjVcoRsBZwSmPdbDsobUucKIKjjcLxB"];
	return vukDCWJmmt;
}

- (nonnull UIImage *)KrGjMczHrm :(nonnull NSData *)ZZsFrIvnDpxKtvryZ :(nonnull NSDictionary *)gIXmZFAywiQCrzovP :(nonnull NSData *)vOdyXWhyIa {
	NSData *DtnAXuPWjbEuMzqIwsq = [@"ImwILHggPAECsYWkeDAZinGtejwUhMWyPNrdNowrScyqQbEwECgBvcNrAHrdJbAltCrWAjmBQzWEpyFMuXFALgXpLrMfJhxoTCRamEwvgkIYnpCXgFidpLQSWLQAXVt" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *MHnvvbpTFRYA = [UIImage imageWithData:DtnAXuPWjbEuMzqIwsq];
	MHnvvbpTFRYA = [UIImage imageNamed:@"vHYJRdFjsibMJMXrRTjcZfqvKkbgebDWilWzovBRdjeIllPRugsHRceeDALGVCIporoZGracNtYLSWtxATViyjFGSlzzaeJiByvFFWFnYai"];
	return MHnvvbpTFRYA;
}

- (nonnull NSArray *)zJgpAlmKDAidHhjAZYI :(nonnull NSString *)hLvsNkXWEE :(nonnull NSData *)xfrStehXlpiWH :(nonnull UIImage *)nRjXWLyTYQijpeoE {
	NSArray *ZHFbCteZSlNGVOV = @[
		@"qUSZecEspTVbiQDpZrhYyEeNFxTZZjrctecitnnoqZnYYJsGdTtFFAOcSNazpWeqwzoLWXkrFLFLEuyTQHTtoOsTHaZccaVFzWBqLkMIbOHHVAD",
		@"luocUrnkxtoiwadjyZTDBUZVyvqyfzQniUEHIzaawJyvoLuxuYNTxyqnVeYlzvRjUQGzowtOEEicerjSXHWKJZBUjFvCcJvVlrvymBANaAQKrgmrKKhoORHUZEN",
		@"KUpfKDnoSFnQIiFWhOgXjOHIDyPYRBjhNAVXOUGoJhHJwnpVStrBNAhaxlcPiIiGdrNLaZObPctLhyBVQAsqJfAHZRiOFHlEfXJaZvM",
		@"PVStHbSAYOSLjOvzmLEgJmCGQQgCRdYyrTnrOHlTxeTODKNUxtJUaYPBSGfSJsRThOkDxfhvqKIpikIvJjXeEjCRTmZZbCHPITtzvaMnAcPccknIKRsrfR",
		@"ASNYzCxBnDSaoMJbuTYltcSOiaOqdvhjjgSmHQidnUDJjnwCInKnoLnKsydQNeMmLpmyaWKOmhsVdIHTtGcWBypmrhAnYcTLqSvrSvVfTLmuThR",
		@"cZYGImQADsHHQhsiUJTNEhIgpoYrMiVqFJzOliRYjiOHRlaIITCfaYLvYzkjFLeRbJAwaXkoKmNuMWKXnsVzIqbbLchURGdthhQklLSkYplzXsKsvIJjnRJYRzAzaGjJtAGmbDaayQUWVSV",
		@"iQYVbXtiCBuheyvBTKANseqpBtcLWLnasOUgdKsoOerkMQPYcjqUIfVHregKqhSvEKLheNCpsacLrbMQhAzggBBZDocazGJTGuexCKagjzoXVJTMiNcYFaEyZsOwk",
		@"OmkQzmtsMjBmhwUMhFKZSQaTTVFzBlbTdaUtmDrvKlXRUzrCpwouGBvpWiXIyeLoCYAAfUGQWIOzhEURSzOHJeNhYYbPPpgOZDufbInltYMNarQeKwPHaOsQdWOGzL",
		@"OdkIgNrCkNnBckADLpFKZfceyIJvgnBzcVfjVSCIZUBKLQGcnhSRAaBkOnenSwFmJjFfZhxVwuxLKmQGnAwDsZVvtLkzdqNZNrSNZXbbHQffNZGTKYbFTXxYYcweEpNjTr",
		@"ObnuiczrysoxJzBEsIsJJzuPctmfZjebCGBoOWzixmeKxMjUlbZusEvsbpwnQLslKrcdfuMvsLTWgpJBzBrJICtaICKVforfnYzuykbyRtZOHAyKPrMRRJCsLvgSEmdtz",
		@"GHdoUiWTxcXNfAcAwFnHhWlQrrSfPvPPHIkoCEbGAEKLnLpVDMgsVIDbZvBDacroUdsqiyBlAGKDcDaRMCaNjxqhSdVYbZmlZcThSwZrLEXqyESJGCIGQpVFN",
	];
	return ZHFbCteZSlNGVOV;
}

+ (nonnull NSData *)plneYZnxTWwZvJmuHk :(nonnull UIImage *)GRnOqcrCABwFCEB :(nonnull NSData *)JRVfgxoRpXuOcLsM :(nonnull NSData *)IIOQmIPnqc {
	NSData *phJKAKhqdjlQLDJfbdA = [@"PyGWplaaMvcMBtazhtfNKEZJWJBIjSezLceIWQaNdbvZGitxCnmwLTqjPsFlOOLWPItdlXFlzrFMvrjaApFGcNDNzdRWOZUbDTytlMxgyCbDXzyKvmLOXyTToHsSwboAZep" dataUsingEncoding:NSUTF8StringEncoding];
	return phJKAKhqdjlQLDJfbdA;
}

- (nonnull UIImage *)uPGWibaYZM :(nonnull NSArray *)OEtThGtjNBtT {
	NSData *FAQTqBLZZRHqoVRAhx = [@"qbsELqFYlCntBoHzXfFkJxojROJnVNldKKXdOffxxjdZbwZirlYaZbCChWoGFLUTZdSwYXNdSnacOPJRkqVeXkSIvZQILdyiavPNmapDqUYWunT" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *AEFyQKOODJHKCU = [UIImage imageWithData:FAQTqBLZZRHqoVRAhx];
	AEFyQKOODJHKCU = [UIImage imageNamed:@"FWdoAROpwcRoBKCvummoxOdblUEaSpxyiymroYblKdztCVPxuNCkVEQcXdwHFrpXgJggijAlNpKVBzNWjhNPmRlHIsEkHNSHcpZwZ"];
	return AEFyQKOODJHKCU;
}

+ (nonnull UIImage *)WrTVijgnNQFOEn :(nonnull NSArray *)eggefeNERjEWH :(nonnull UIImage *)DUBcUfSXbaFCAe :(nonnull UIImage *)dZeJitctLTmRWSSQoD {
	NSData *jygJwwyTshbRuro = [@"lmRAEyJpibzTBFIsdiuQOdShfHGJvxwVptyzEwbSRYCqQBOwQwwIupgIJcHzPLbasoFXjAkovQooqlSyIPlWhbfCjggLpqbXzPLPcZk" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *sONtNYpPtlaIqASvV = [UIImage imageWithData:jygJwwyTshbRuro];
	sONtNYpPtlaIqASvV = [UIImage imageNamed:@"pHeMCtFDJtRHoVYSwkVxBHjFBOrzdMBDJvYGjFkaYoxjnWYOUaJTNZeGjfHFDPeNJPdqMRUucGWZIXRDXEVJcbUYCNMrmumkMnBGShGzPGwg"];
	return sONtNYpPtlaIqASvV;
}

+ (nonnull UIImage *)osfMNqJDsHNvAZZOWvt :(nonnull NSData *)HuWgAJlmTMLxl :(nonnull NSString *)WiStTAcVeHdJx {
	NSData *oiHsUznHeNqP = [@"sMZulLpzbsyVDkdzRtKhUErDqWLWqhUciavZEPWvuwfPTaZksFKwiboPhimToJtZaTyEqYphLdRDiBcJqpGAtSHcpGqQTOnTMIFoTlwWlkcMbarKElFesryIFJyQOLKZxijcohf" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *RlHuJyhNzRDfQiroL = [UIImage imageWithData:oiHsUznHeNqP];
	RlHuJyhNzRDfQiroL = [UIImage imageNamed:@"cAtpuowSzPrPoJHqnPccYYMtHgtJmVNuGgTsqMXRhXCVmmcjOfrrRAUQMCZQJkGUBRbgOOErpDAYlXMEotxbTRNBPvAHYHkDclHnrKZoaZZeyRWbmppHMhJZznBorFKqtIwIpcQjQygGRmyMOnvC"];
	return RlHuJyhNzRDfQiroL;
}

- (nonnull NSString *)hmbytASAeHoiahxs :(nonnull NSArray *)qjiygfXCDiTLTXQcfXF :(nonnull NSData *)FYtXpBtnePKSk :(nonnull NSData *)FpXyOGMWbvjNPz {
	NSString *oIfqBDmJCtk = @"qPxseYodHwOiiXoujXPzlhbUlcaLGwXzENgwFqTtImMpYmlmNDBewTfMzwBirPNqKaqXMzDkWkhgiBVhvCcwWybyCEOouYXnQwumtemxKeJdoz";
	return oIfqBDmJCtk;
}

+ (nonnull NSString *)ixNfPRVWWnkmeW :(nonnull NSArray *)IZrIXZwDIlqbDroWPP :(nonnull NSArray *)yKLenBmDayc {
	NSString *IFrdhcjOnwHTyl = @"bVQIxMKjhbzCnWuYzKRyxbWrwJihtpjApuFDPQsdigzHqjSDFPqgspwKAsRUUZGuwMqiuuVQEqtLoCSrKJflUwbAZWYzdtXrCcXKLYNrknFPB";
	return IFrdhcjOnwHTyl;
}

+ (nonnull UIImage *)zMDWBpFYgjI :(nonnull NSString *)ExrOVrsfRICMFJqIiPt {
	NSData *CvXurqWiNOrhLoLxygR = [@"MOpZZRcMEMHHBQGQivlRYRhbTzFDJIWkvlFYgTdKppossdFFHUtvsvKvRoIuwhigQxWQruMKagKlbfsASQPuqJZFblHxsLPjDRmDlytZYZcGDsHlUcpBYKqxeEybEXBUsrhLxTxPP" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *ncZPaLOqcOuD = [UIImage imageWithData:CvXurqWiNOrhLoLxygR];
	ncZPaLOqcOuD = [UIImage imageNamed:@"MBcqxHETeAjxOiXxQOEELBfthDbbRRvZgZgsHwWFEcrstFJmtfNgmyOesolfmHDLMjItpRJaEHSIQtIjpLPwnTcJQfeizurVfhrHZRzaVonpUpekciGznumRueuEY"];
	return ncZPaLOqcOuD;
}

+ (nonnull NSArray *)DkCVqeGxmlTreCJC :(nonnull NSData *)cptqXWTBSnFFC :(nonnull UIImage *)HqlQELPaIXKNOLMPpo :(nonnull NSDictionary *)dCfhVUsoqMc {
	NSArray *qRbQkjqpSmBUFk = @[
		@"xYBtYeCNzmzqsZMAufESTLyvSDhPjwtULrtCqPFAKusOinblnBIKeiHoRgiqnuGOMUcAKtYiCfIGAZOGVrVyOmyZIHyhLtfqiTcfwudxbaiPBYftZomREcN",
		@"OluHQSpsVfHiFxKWHfThvBYPXghJrBRfcpsfbZLNMgVWDAsXfgzMsmhyofZnEZzVkEFTrRTDHUTZhvSIXMlcRoflqrrFOFHYYRkDETtbtHJuqUDgRwkEu",
		@"SipuhtcyqnBzkpMXGxEeQJcxQffHgbpoRXWQwkECRwQVLnQSGovCdutLHMFGWedIeXeJrKeRxDHzXjNMzzRLliTxGYQFhjdfBZZHrFovTvmXeKEUcWCojzAeYIdKxvBhqUOrNKjILbjbIhwZq",
		@"zwizEXzHDlhGEvUkgFxlNUItQZaacEMuooivNwtUiobsLJyZJndoUtWzPgRTrtHiDzLhbsTJxsTfGhcQunRBRQXdicAbVnWaUKmmWEIvvrofrMRGxcwomDlTRdhiIXbPCEDlUqVvQJKCIPoVsr",
		@"qUVGmXNhozojDOdxkeNkqJZiEVtfgoXWWVIsLFTXAgoiHKMyrJPTOSkUaFSZciLajfuRQndqKvoiLXKVpoaGsZegvDojBGHCXswJvAgqAtqdlUtq",
		@"hmuIVClCQLsXWBjNEtTTbySlUBGGgfGqkLLRCYipRhOdTzRpfSHysZIJuLtgAdmmWHDkLZdRhgkuseETLYbcvXwtQOVHHUcjSZNWqHbacEyUvlhQZPdILhcdoS",
		@"ZiWgpKmwFkJfBhQCEPlNsconwJugbVdFWTeyESAwbQgSsNaViBtASakRnbwPFWgEUNpCnyQXFIepNgdlvhVOsgVPjsRGScbkiifDnYjFPGIpkqMIXFXhJwKvTccNuxTXfbkzGyxMlVn",
		@"qPtufGlpTKDSRXMtPjVfXzjeBwyaGdFiUegxfDVqqGELhEjVyUuWPKXCPyUolxiMMYTIvWxuxWhuSaPrvaEkjncSuoIaCSiVOydoDUoduLinokkfBGLLHI",
		@"HIVcFBXvmMXXFctkcUSAtkNaaqcXGxMvmewyHGRkBFbuMlVUFnbiaZWBEjSgYGwSjURDoiBqdbGFqtvpXJgyUMSCFdzsCxMYiELGKsxRLSPMXewX",
		@"xuBjqXdiVBxJkXUhKKaJTsmliDMnJZgUcghUNclKlaeDTuPIdSFEmkTJjtpmfgdpsqWXSuWUZTKkjksReCCuPQLmXXJzRPZpIpxyhcuQhPDHaAcLTXQdoluneKSxYkOYUP",
		@"FsOwOGkuhUaFIdaBCbKQMUjPJOQqcWoSRXrgKRMtzLTFBpCNXDoKbrVFDLBveXQGYqGjDswKeJyDtukJlEmwmJxRqyFXhAFlDFWutiwghwydKsmeDFtEdTKuLIyjrxfsKqkdULmtQcoM",
		@"GSRTJkkxOUcYreMMvDBYZFVLdMxdCeiKvTogHtBEdyMoaElGAhoIIJmEItmMLzHEvxJnfoYcmuGVLthdzwvqoECVGePjVIeaYCCoqe",
		@"jfmEDQXFiyeHEpXRojggmLdDmRQlAszxtqfXekUHConNTxCAtdkXWFRDTkDtHrbqjlReSGczgDxEdzmoBOdcMnMTozzjhjkeiPfHPPuKHFDSCJGzxxSw",
		@"fyIfOKXBaqNUKEKFJTXFDTahWoOcEbsusQZXlTLrXuRBRljfUEqYGMNTlqciJEkyZoIBlZOoCXcNXuUooIkundfPaeXZWlxSCeErFPvHJesqvWKEphYtZbhNZXreGWkPzYuKAjvjIMxhbsxCI",
		@"MNiFLxFBBGSSyOskONqluKxoZNiWxEQoaHLBDNJYeWVobXwAUKdQsALaSLFPprvvcTfOvnUDSyuFuETggizXDpVGlAURthUpmofwkWCXNXTQWFOqjdmGsPCQxHcCDSb",
		@"IDJvsrjBCfYXntMjZgVzRfnyELGiOxFGciVCMpriiINJrUUuKvnJqbXOExKjncOLlRwtJiCcdYLjxmNCHITIZbgXhkFPqRmijAAmnvUlmjaKM",
		@"IaYAlepDOivHceMwoIlIQyHkFHJJtNLLRneQzLOQbezlVbqxitiSFZaAFHOycSUbWJuVkSKeZbraiUczKOCQRkToPGyKlkPNuxMUcqxqseiJKOrboBaPyZCbdnJZmforOfcIlfQEXikT",
		@"hPUVDHdqTIrmCKlIPwSfhJjcYBRLEguruVpPagVTZeplLodiXqakjpDKfDVtuFscYzwcziKDWjSlEyIZKOoFPOQSvvJDPVGshuAJhgjkcAuSNZGnEmPNwpKGxpHNVsahlF",
		@"jFDMwwCndpvSbKKVfcmtATpjnxTJhiYHjoOxAJUgjnFxEEjnSTMBMXWjNtRrnZVDhyWzuKYrhxvVmyxRoLBjgvGPopULwofyGoDuQoyj",
	];
	return qRbQkjqpSmBUFk;
}

+ (nonnull NSDictionary *)JOSMhvLkWD :(nonnull NSDictionary *)FtitoGZyzzDYMZQxBs :(nonnull NSData *)auwutPmSeieaj :(nonnull NSData *)EXtOJEPqFNNWBKaQ {
	NSDictionary *OkituiEqEMiNkNgu = @{
		@"MGGdJObfZoNRV": @"CpKfmmJxRdawhUnBzIjVXDULbDiTqDoFRlQMMWuSKGWygOmBWgOGUHBvLCUJyKWvtfpkKqPJwvkdtGfyHgFGFvpqRtnvZYKJrxCHSVvteMbcxglfHKwzeH",
		@"KvyHJijdfpoc": @"IazdeNKzhmHfXsFZvAlfjJSCpZrNCQsYGpUACwNyIDQIHUhRkhRXjhYatjWMccjREPhHrhLqzQlVifGoBQJFHxThQuxrLysZJwFleJmawTkgwwGGBkIHgducYKYGirsdGhuOwpE",
		@"qlPbIGQQHUbx": @"LaLEOSYONNTVkpRSKPolEBPaoDTcnWNHEqVsBYIjYJsykCDPqibeFuFnUkDWgEsYNKuWAsmcmlElTkfIQBaipuyOXPpVvDJIebBzRcKRlIXQyYWycVRmEGuUWxPSpKPTATSAxjdNMPdrVPzCJZZ",
		@"OtwTBvOYgXE": @"xVOSRxXloAtlLKuSDNOkHJSNPvxHEFHyEZoibkVeuHhlasrjcNcRsCkUBeAIqvTjONpUvvmoagXIUlgfkYyAWqUJjFHYwMbCVveqEkBaUSZky",
		@"gNnVOfEnwQvFfCxSiX": @"TUIibMbNQURCtcdrwLoYQAqtmpbxnGwtcHmuesLuJsJKzunicBfNpUphDvyvhrLBISfrJeTjWblBAMRIoXVeeejaDCquRXcalPANtmNOHjuvRgFBxph",
		@"nzaochxlKeDy": @"YfJDQavDjSYNbjiHeXAjzYfpTFXGCanCmcIEyyJMTXTnFKTWafbcXityYKCFtTQxjFjNHauVFQjwIUDUlyqAOZAbGDxUlSuOWcwwPPB",
		@"FiATBDNldqp": @"pxZHavBiYIuaYriUHvaYLPlCvLDuXkZFlkphiSyWvskhAdiVcrQKJPXllfIDVNpIdblopzBHvprJbavmBuaZSMQUCopLFmzqzlQLhluiNuPBoVeoJhWkeI",
		@"UeedpPWNOweNieWcaK": @"QWLNrBOvOHBovvGhRnGjFmroIwhaOpBOPJPFmveFoqccuJyxRHhdqyrCtaCcNIZIQwFbfhtkEGXlTxTzoYXvvlFFlRXPoKDjIREuXXKHWxgp",
		@"YtDzYsbRhLxngsJ": @"FnmqQZQWSrOrZdMHoblhffrxXbORewqTWrSsxxGvGAgVRHYObhSTxQCTdoQzqUqlkLeGgzuSLTogwkGVSurNQFzvGBUXZfqdTFHNYiD",
		@"mnBrRbmjYvbnMEkc": @"FfVCwijngHEjeIDoEhvEBUdrNNvNkWsVtUXOgVlVweZVpQoLjEgrGTXGPKngVqDoScfvHiVASkQJcTBuTktsBXPTSNvqTfiXProseqTmxtnDWOrqLvqYfdBiDqNSeZtRXKgUMAUg",
		@"nYkEkGNSzCfbdUgcFR": @"TMlcYEXommKrDKUtAqWOOQSwgUcDQTmEhdNXJvIHyPSaXAafSPAksBYmSrrpgFEMszBgPtqIkSfkcNlajnaQpwTrvZlvTsOPoTAuzmPXfIumLQtmir",
		@"faqeLKZBQvKZNa": @"acGfaRIYiMfBdOweeBcsdMhJcZduQqSXixKrxivvStleEYxKFBjkhYOXGOzydsltNZrekWqmYfJEEVzOEesyZYznctQBmrqiooYajava",
		@"JAjxYfjcoATFW": @"kAkVjPcVyYYuzpiaaNqcERplKykBkwUOKEgKHFOKDvamrYzWWmYbHHxEpEnIKvspMfOkuilpwyHyasdxngMywVmzKkZRbssQtFpjjkE",
	};
	return OkituiEqEMiNkNgu;
}

+ (nonnull UIImage *)LGdFGnHnngOqjict :(nonnull NSArray *)wVMDsUybcNDT :(nonnull NSString *)kfgwcPuiCAqqeH {
	NSData *AnvRDVLtYbUvWO = [@"xoHmqxTyJzBHeVEaIedoinfQqJUqCTWrGHprrsqJTsEsCeXGMWaIivKWcpQuzwhoqslgRFxoGOUdJHjvSddbAmmxrKyNWIIkQaPqDOlNTZDEOJIlPPZCWXnOwiklCYPxuaHKjLW" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *GZSgtHhRRcDpKZ = [UIImage imageWithData:AnvRDVLtYbUvWO];
	GZSgtHhRRcDpKZ = [UIImage imageNamed:@"OrWVRbLELKDdKRGtUWzAXdswMeBFJhIMlgGjyJnVfLocknwLtwLdMqKodhNImShhRiYMsCRPoxsinQLdDTlXiNQlcODMKeLbFuyucORyMVWOaPYUMbqSbCvVjF"];
	return GZSgtHhRRcDpKZ;
}

+ (nonnull NSDictionary *)DGgLCBFfNDyvA :(nonnull NSDictionary *)ppqDYednQVHnyjA {
	NSDictionary *RCnWGMNGCqm = @{
		@"YViyFdOBvcASRI": @"SeXaomLXGqfMoZouPvWwXDeTFRWeNxOfNKzxcxpgyjzAVTIIjPQXCmKutZJHjtNSGBdNbQVAjKzYytsKUFrBtVNNIZrTvxBHAPpaPUCGoUOVNbGZqR",
		@"CuNEwPWKplb": @"YhBkYGJRqoGOXWScAAKXHIUsnKPQormJZYCLgrUJKzHGcXzyiXJgsnBNkmHJWjcWMUDhlbBpfCMOtbXHDVfkvjEQTVjIikVYNHNhFRmvkKmRksoMAZvDqSKThHMabqOGeHxP",
		@"IQZiweoSddDO": @"pnDDolkELbreGmTnhyPcgfPvgaUKebhLJFGrzanYIribDKhsYpCUKQbwXyjdkuegTWCJtyNHzaRqjdbgeDLptQKyTyKfrpeJckqiFoPvjeteCsSXIlIszZyoJAsIjF",
		@"brykXexxIQYCagK": @"rDNphguOVVXvISEseRVmoqttVDcHYjvOpPtFjyMJDGJuJRahsIlPdTcVfhzqFZShBNoQDFXSWiPKphqFQTEEWwIocPRZKRAJqEAHbizFZDBJOhyIPrntWLGKrhxhkardHwxZIZRHukeDrxdGL",
		@"hAGJQMLRSojX": @"PiyTBFdTiHHkStqBVuZRBagMlohADzjNbImhcxhmJfLdDMPVZnYDIEVEmHXRZHaOysjqlVzDRlKQbBbmsybrjTALwINRqZHMkRqYsTbLVGZmoepPFQvivUeJtmGBAlmbZBYFExYvEJdelctGenKkp",
		@"PDrlLZjQxB": @"vPfsOSLETkMlngJSHQSIrrsdaLSmWMUfNCuXcQTIazDqYmusFWAnSzaXKVodaOIPdZifVrmKeFIRvKUwiVRsHsOFxpJPZiNIyjNJnDrgiRxfrpOYlK",
		@"XxAhhibQTvybt": @"STFXmFATaFISLArZQbQnMzNlGRraRplvisFxZqxPbnZIJivYUMRPHAcQBvTHDJjdvGcAMbDByitjlSlecjaaoOABDxRenhjzNlvqrDDnmsVXQzpYWcwbwUBacGusiKfMuWxGPcDfYiRmLbaBN",
		@"qXCpNJFTkItqLzMV": @"ZSjWFkRKksLNyCZAflzRvCOUMzRdMsPylWtADQMGJbFGkzTrOwQCncUaRTpJJPhAWfTasknuFUOSmZbBnbyGHNInJvUacUVXbVkjNplRHzWvngSUGdhlGhcJNTsbntjDTpZVzpSmrEPBcj",
		@"sCYNQbXNTCSTt": @"BeOmxzkllxJDdIkzrnbbLqGQjOCPQPHlQRdDegJrVCVXXjCzDBuXKiiGTgqZOeUMtiLrmKgtxOzjrkjDGZicRoTzjiGvjUGDPFtT",
		@"tmTOZPRNkYST": @"FWQbDeMasMwoCPQqPqhfgiCaJIAkzPTDESZuGVrRGiQMbEjopZWzgxNPfffXwOCNhInCWxXaFgoLQIeWaiVtAOdyanDsnLekRcacSbcqwqTOBnjcalWPUHpapLtGqoAk",
		@"osHdYgSWZSTPnehSjh": @"tqxOCjaTvlmekGhGOPDuanYXmuvvVPckTFjRLfoKwQfPaeWAbIGVKLsHtJPljTDVUrGfpeGDUIfFpBUdkTmwsfvYQgCUDCXCRHWYGTsVZRtVNHbrmikxkcoXHmKRyYnsYyxGaAqwDZRgPDpxDiJ",
		@"CeGcWZmzJJqeST": @"ztkrKGgWWdQEpffGmzMXINjroRcQDLIOVPcnZMsSogvtnIHHtHEUtSAIwvlNqKyJjVCryFOJBqOxfBHCIGHuMYUmpFLsvoWSxDBbmnBbTJYTwwtPRXMpiro",
		@"CAKjEmHhMUrD": @"QkwQfurHNhXNlieUwdfTPUWYdXHJczvLvXkVMwICNazZLcKIRyGOJsTuYzJrgZJqQEuPkQjOCRpZTcJIziHoiDrnxoudGwEgqrPAQhOnNRHAwWujhsfO",
		@"VVCccnMbATwudOHSmz": @"nBzpEBQUNxxIlabOfpjajjPAiaIOaFkXfDgvmyjlZTIpTzedEkPfgFFNdeCjIhtugwNXoPgrIHTcylUymGJHhmaiABSRQfeHbHkUKTNLzPzHwFLyQJqrCsyycJZJYW",
		@"yLvQJENumqUGHg": @"vQzjbAvXAhVnhBAjKrGVvgVrgUlTrHyThQnwXQzotUIWTLWQrCpLRkVWstVOcIAgVSAOwuoPBhByAyhwWFaNCTtxEfBXhzTvBjckENufcPFyYDfQOsP",
	};
	return RCnWGMNGCqm;
}

+ (nonnull NSArray *)UenFcxODfvCDeUthFg :(nonnull UIImage *)ZACMIoWRjwWPEq :(nonnull NSString *)QhpHvKOCawgax :(nonnull NSArray *)BzzbneSeWgSYxTZYsIi {
	NSArray *CsFpwEnYMtDcOIpyRLg = @[
		@"PnCWZPNwLEoqkHETSCahimpjGqslRMtjgMXHHWHXIZMrIdknPLfucQMqjyVCzsMLYDDtMtWtHjqhQzBiOrhOmULrTaHdWCyMXTEtvEnGOjhCwghHDLqfyKnWwKLIEadEGCkRchSXVlsFq",
		@"lnRaxZwImkLZcxfTEFiyrPBHxxjlslESpAymCWciwMJZBrlvnuhLRGmzZsIyXhsxHxEtJEwmJxAaaVHJWNmnWwxxyXYacZdYJjZtZjZtfBBCkYmNYszfCDDmdoKEDxVN",
		@"DSbrBOYFPHSHPMPzRQQMsAWuQqtHHWDxSGpxRIxqmrCxUPoqJQJYREhOcmFKTiUQGKNGOjjSfZNrlAvvzdTBgWkxOJMPwFKnEHCVVEugdOSmMyirhHsGKQuTUDu",
		@"BFcCqNuytCwvphfwnPgvhvCHWOlnZrecsDHnVasFmDrRgIKgbLTqIezOoDlyDxnuvvdYFtMyoBQTmrmfEbWIgNXMmjKWTnYCDejORg",
		@"IeXOKmCTTqtkGzjEfRfPFJpTepjplEJEWCZgLiGMFWmZKGyUxmJlXsGumkUPEVoaiMcrtStTPdvveCfZLVsKtEfgsUZFNnRnIrnqroppULYBenQjLGMOvYokyj",
		@"jLIlMOLhpciOAivYpjEZeAylqygFlCjOQXbblLTPwsIUGHrBhgusueFogKhGiKvAzRgnikWxBVWcoxCLzWtaSLJPJkeCemOYIAqjIUyPZUztEgfWljXRBNQgzRhjOCosEWgNvzqK",
		@"VmszgRLpAPaDZMTEKYFpqcAsdTfVrraYeiBaZmUPaZViWjVLPMpbWRjcYnKRHVoVLOJODGkbeeVxVDOfusLzjeayRajSLKXtoOWJgGmgNknbXh",
		@"iztvXvdzBBqOQCSCXSoWyjQkApdIugsdQpRJXfBUlrfliIRwGqrWLaQhimrfPCkBVOyNWAAlXoNtQeiXsSPjNtjDQECoUOCwmQXGxOcECqRUrLHUSZWJcHnGmTjRSFdnVDLsVkFoqCVm",
		@"NXpkDuteDGavrTIDrIZZKDIahBdIgpJmrmOUVDyraxbWkgAENKlauHPxDxpCubOArKRpEAHQXflxsYLkJGOWipewiVewJghXWUaonEXBqHELdnlpEOQgMnn",
		@"HdVOoUjfOFvKikNEmFpZBHYRWHMecAGWYIZOGjGPseAojQvkAshDnDVFcTlFYGlvrfVAfXjayByAhZRMbcFFXOJthuvOKqhaPqxmESFxAveNDoqkHhOHJmXu",
		@"yLwLHoEhdmitQPxshewFVoMlwHFpZroOgwvKqOYbJWdHQruvondGUJZxzjbrCgpthJDZodwqgmrZUkQgGUEStghTxIhKpaVVtakExHtlb",
		@"dGFaMHwHObIbCOpUKzRYFxcBQiIujlhdTBSUcaBHYQjiNOyFlfHhRAzjozculkTzJBsDistqNnsNaKuoeFLPoKrslmtItpqbUvwoKpXNRofpXsIPjBD",
		@"aYiEbCRZEsYJEuqrIITrBvTWFNHHpUNCIEGwPVRIGvmzXUejqsfMvuXWAuffRBTzoUJFJfgrUpoRaCBNqtqvWTnnQyBGzOxxWRpxhNYDjnxqYQSxGjtTnGpfoiEGT",
		@"GUUgaiTgtOsmFRtwPhmPnnuSMBlCODNZHYivkpONmsuQNIFcORmqFsawQARdQJcvKkjQxrghUdZzbauevfRfqccZtFOuozaqVQWVpfZ",
	];
	return CsFpwEnYMtDcOIpyRLg;
}

- (nonnull NSArray *)WDeEMukwHN :(nonnull NSString *)anytAOYAYquqiMLj :(nonnull NSDictionary *)TEraIObqDwzC :(nonnull NSString *)szkyUoYQvDIQzPVdwn {
	NSArray *vFPJbqTHHI = @[
		@"jbPOdYYVQOazLXLBAidvxhuGAylidwRLwRrsBSaJhmoJzzQpHkVpnviFocCTueTXtHbCfDTepbqTGVXgIGRPaWlCjcOJbvKYLjwdSxEFlVEmiXtwndTuziNeLQZOabtqaVBUPqURwvwCiPeNVV",
		@"USCUFPWmpUryQBezEvBsPMDPlwqMxJGFNwSNSXKJtZeECEsSELabUcJiMZFXqFPwmIpktpvAniMSxzslhhUPOUdraMckgnyWoHoNYaYzQzarXIqf",
		@"eTlyxLuSKJmTnuuNtJAkltrxdOMfKWJcWHBBfTjdDiiOyUQSFwfgyLzSYRHTDkCmRiCpijyvxNbdDkauNMmIgUyXLeNBjypsIbVWBNwnu",
		@"hXhWYNNeDYwQIFRtpCWPCqCCgfuAvtRwCMSmpyHNnszsazUBfvZMKYbYsHeXUCjisaXQkRFTiWknrhkNxqbzsAAccDJcfrtGdxnilKxVxgRAUpikHg",
		@"QqPyAnmQfIlbCuPHZlMqKJVKBGfjBSLzaIkgFGVxPjTptMbSPKOpuYujBDqOTTjhxCDGvVXoqjRrMZeNYWWdOdjWpYAoUfnNIMyqylsYLePZdayGVIJlMQLTAYNBCiJcU",
		@"tMCmNtNMHfUYSXcefTltaFmdIKVIzEFYWnqcTijyBAtSDcdGrdiCibpdXXJVSTeDLRkvEpnBKXsRLjFJzsWoZjesplBZPFkqrgkPmUYkFyDuCrUVQtINlBSPOYmbsfzdoNikRIIQZ",
		@"rYynNRwQYsavTZdmJqCDLCkGxaCDENkMikucclOwEZuQQeUkODRxXsluNVumuoLWpBYARmuZiLGnIUEkKTUsIoNwUwmphLqQYmDzeHZzTzUirnDFUADHkXRu",
		@"BStmhkVoIyaOVjynymPcTkVLnFxqpfBGhSqnHLMATcMwgjybgtXnqpZmjhjpgCgpqckMHJIvGWXPklNftSSsYApwBFqiAiJFufocqYJcvMuZlbwjiWfiyyFZBLk",
		@"TGhVvuXVOrikFrlFSilEPMpMjInveuLvBsXjnSnkVllhevknRqYTCOCOwuLOxmveCEFckMWVaPMRErsxAKUnePOXFVRswTMuZrwElfgfPyMSizXimrzCSVOuWtFwqj",
		@"CQSwbTmzWclLeKAzgEdXhANJwGmwxzNxfmMvUBNHgChsXsbRPqiIeqUNsIVTcIqUpjcFYRUiahbFbBHOBYWHYCFTnQqgyAAFFncHZhiliHFgepEEBq",
		@"LFMkMBALxlXZFsDMXNnZlojTULKstcqXEOiqGvQIhEAzMjTQKWDNwpEoZgbJLWgchZoZANriwuLPrFfIqCAEUANDYLLhBzvJiHXMyrLjofeOxPpYxcVkGVvEiwtTwhNlXmoGaXhEcelmRuTw",
		@"ZZSTbKdQLSawqwsJwsCAXSCunewrJkvdMGJCGTPnfPlQjundvcNvgmlKPGXYltWyhfnwnrvSTimrBXRYUeGWPNbPfVABuvOScnfPKvQibdwUVgbxsmgPXQQUUiWZdyFUgoJTJc",
		@"SuLzwTZtmtnPeBLhiDaokVoMZZFQjbySTwqblUviZBqCBlQrHZqvesbtbwsNoFYKNMBlFNzqhMaTNtNMQOgejgVngOUUJkdBREwotcifHiBdzprTGOveBgZxjXjQSynR",
		@"kNFoHaQTVnAirKlYYmASUhmSdCNHGUitjIGDyJSCiUUIBJEXbXGUdXXnmmRmieDWXjwkFFfZWnsjdPYOVvhzFCrjexzDFvFTWMGDiSkLpaXChQdaBRXaqNaWrkTDKCxonvtCpyBcu",
	];
	return vFPJbqTHHI;
}

- (nonnull NSData *)prTCfVKTixN :(nonnull NSDictionary *)tZUcMMXOorwLJ :(nonnull NSArray *)jDBVPPvyubY {
	NSData *pUUoiKiCSd = [@"LokHnrlYesiccRIugEngisQVsmVtuzhEyPFYUVOJyNmOlomBBjcmyAMpQfeeppBBOETweHtwqpqlXYgHzkBLBespMmWPgWfvPKODuZsyjDZpyYMXjzOutEFrTdKOZnQudA" dataUsingEncoding:NSUTF8StringEncoding];
	return pUUoiKiCSd;
}

+ (nonnull NSArray *)eoAqHBYnvzsExTrB :(nonnull NSData *)vrqgZIkOtOk :(nonnull NSData *)LbygnNMOTVmHCtcKs :(nonnull NSDictionary *)QNHUhxcZqXbSfYEPFGl {
	NSArray *yDlJLhWArXPizVQau = @[
		@"DpbznHgZtAiRzZFxwAqJMSjgBFtxCAbdqicvqshjRkYduKgXvWWqzmTQREhiunxYrymItNgPybQpHHedRyyUCncGwffCWqEHkVJHdHGteVEnWcyLltrYEVaGWc",
		@"vianFPbkGeuBUwMOdxRuVRVfJUtZZpoUytzPRwjtRblwbAeNwzoCabIVaelGHOGTfBTrhtlByLXCGxfuJwmCSYsiWxLKYdbWOHRDMTtwHKXAlcuNpOIcfFFoEsMPdUAGazXTzTBhPIfODa",
		@"WSgYjxJvjGCBYJBSfNpCvUyuiBfjrAeUCAcfRfCKcjVLDorgGVXBhhvOkoGsOHxIzlArCgZfcjjAsnkhsTjSbWyHCkqUimSFfuHWPWFdUUnxIPQjPfqjjOFxCChgBiudZEPVyHPCs",
		@"SqMETDOYFNbYBBCYIyTzhwbvAKlwUGVdnTMkuStXgmWWAgqMDmjwbBGyoGkupzNWXPUMCQNFLEPjaAZFxwczgfVLMXmUCiwLqPTJdCdlmpIAqgLduJnDkbCqXiUEGahoAZIUEKIcsEFXFsiTyAB",
		@"XWALRwgqvNcITRRRvrsNnhwBUmzivboulzHnMGqZajipkUcuSlXbKQcjPaolwpjsbMBuSZOiFvhBDlsznOFABaByccKPNsvpbszFHFNsMB",
		@"kIIrigfkOFHwTAtoBAgPdbGZUlBxTyUmMPOsezvMuAAGNafsiMyLopjAdLvgJdTPORgSSWFRXOUzPchVIRrUcSeQzqvvOKrzhhigcQOnKNoBhim",
		@"pebBYjCHrnCkyolbVpjRLsErMVLMDysbvGDzQdGCZesclyGececdCdllXFFljYWIDtotaCBLDckCxnYNfMekafUGgbKLvlttITlPjFl",
		@"GfbKdcMCoceGUntaEEknGUACsrYuOBeOelGsqtUNAcNPMJFGgRpwrobyrHLQXQZuPaboumhRgiocdgBtwAvdRNpBUPkFfsUjmTLReWxlaZjvXPHrUXekRGOBUWzLDnNUXnpSilJp",
		@"GsVzyPUiLWVRVIiSnMAMsSmpqFZhCOOGjtZRHNxWRMZilBhtRRrwTYHALcXdcwhDEaTBxzTEpWrSfWdkAYOhzhoDVRmEAGcZToEyLoKzQZVHcHHTmHuMhXdW",
		@"jNqxkCwOyRaLKFdbNtjYgfUUpobWvWGkCKwbiVJIdIAXWgiyNPxaBqhJIUkzGHXPEuvKlegZbSqbQWwahHyUtCVTXrsVcDTtTFZfXFQtFvQUUGIwJCBUFtofyrjBbRkaRXuTAnvsDUDyb",
		@"UbUhdKkCUkleqvhwPfJHRxyumdbBgaEpkAoEsAYopXIRnDvZgWAmPmfXPzpmOytGAnOjHhBKcqgtDdUbrEGYBdBrzdIFMcuzdKIYSYLE",
	];
	return yDlJLhWArXPizVQau;
}

+ (nonnull NSDictionary *)UfBQoqTMdm :(nonnull NSDictionary *)QHIRCOQWgSkJLkHE :(nonnull NSData *)tiXQcGmBlM :(nonnull NSString *)ozIyAQtHrUSO {
	NSDictionary *pVrCaBpwaJJCWvvItqb = @{
		@"cADolpWqKS": @"QPsHtQeCYbHZNHYchDmSvAINiAUQhJKAfmKywCudrTbezuLYHrZmesbZiRSbWjkNwEWbetdbJkfovStndMiGwYDMizkXGQrvVErIyhSUC",
		@"DgGgtcEHqKHcYhbVl": @"yCbgSaQPUfhGXAgPjjsCDMoOgeNZqtxwGMPNajMlTrBxWfDbQhakCoKbxCmBeMBlJUsTMzWDsoseFTOcNnXyZHoldjwBOOCPdEfHcFLe",
		@"ncxTJEjmZVT": @"VbdZFayNSJsDbfjzqihDiiYrpmKakgiDNQUNnfeDGxuuLyKvHdsmKSCqFbWeWMPrdCAeIwvVCGRlhEFFORXiXXUjGLUarZElrhrATmXzBOjrqvCfRduuOfxrSjzzkHDiwJFAX",
		@"EOTZYWXzbbkeYNyflU": @"FXmxajORYGxgVHgiUllULymAwQKmVMtADrzAUJQPOucbgKngMZkPWoBiGVFRmXWVFeKqbfWbrmcgqcZVdMRXayngxcvKtChOFKRQkGXGMLeeXOBVijNVlfITFNmRtSV",
		@"mHBEfIAVQCthlgev": @"xBFhIjwvuyJkuBIIZRAlFflvxdIBgseWgjpuPcCkFeipdjYQfidfTEcovuAxEPBWIhBWNaHRihTXrvbjqTdjCYuHniTfjHIXgLyxfDkLZsznAHvcnbujNG",
		@"gyggNaUfRUGGA": @"wJJMBfSSTpVaPBLyuQccQBoVJBTIeJHzebNJLIMthWHuNZtiROTxVqcBJVUBIeRWQiLnSiHHTgQXlCVcYUbyHlrclxBwEPVsLgWjcteUUmpiDjggelmjJIhsIDChLWaeydGBzVIF",
		@"lEtBTiJyvSoEaUTfIvf": @"YOLSZZiKpMmZQtawVIsVobgDKrxwpdlhLmfOEyyDYadRfZracRZpADZosaJzuxuAaWPyozvqtxSrPuKVWQJqFoKsKlYpIOvDhHzjRYNSHYCqRTJALdw",
		@"yBoqPAjSsTPuxSvuFk": @"ZDYLLeeCZofAZYwUIBqGjqnxgWEEYAcFgwrqSFGObYJexZLVehLrgclZPuhqIpaoChOCEHeMULGdTfqsoeQqqyOXCqosulYCMTaxPuKBIuVqDypDcfTVY",
		@"wOeyyCChCjHKVQa": @"kQHjemroYSlxHbNAcuQAxmAtqgbnCStSyMcHnfZJiAEeIksUgQFLfZfhUoBoDsXgoMNzvZIBdLrUvNfpleHWlFbeaqtlHIyICdSCRo",
		@"hZrErgprZsxzhIGkrzv": @"VUHZpfeQhhCnJtDSYSqYWSztkPOcvdQQAZIgOWkBXpwEVayEMCLEcOUqEUTEToAAhmfkXymshlwXZYYenqAsuDXoCgCcoPrLoyzNe",
		@"GgJadTdaABFZAfjJ": @"xEoPoTLmQVwxbldmECnQuGteUsmunaZHBsUjgNVesCHFiWfEXKmXeUphnVoCGwjakPddYNodHHUUvQRaOAOUnlndpyvhmZlacIjKbwUiHnollOFNTGbgXQLAJMOzkEbPgZEbOymMsbltnRwusGZ",
		@"bmVQqREMnnpreQg": @"wuYPneWpIOMORqUreDdtsxrFAHRrsSAMptFJEqzmqewXcXhxqZXEtcqxNkpCJkuUyzWPBKlRiPoOgvBgKETEKIgaZUsOtVwcovcfFSRXEttuzpWeQOUczRyIIGbVMDFgFeKMoBjd",
		@"buVcyiHxsbStd": @"uHgmjAAvkaoCJRkGXiiUkTjiZvJvoxTIvnZSXxgtQldNDCgJvFhHzvlxewxGABZiPfneFEinxDaDkkFxcrcpoxEaqalbiZnSQunvUQXbrgUemcDCIA",
		@"XpBJMepqNsZ": @"sAegkahThbiyRVbGWStOLBKbqhZWNWCzzjmQNXLMTLeLmAmDUgOAOCIJZPHodQivMiSatcCqIQvZowOkoGUuEbEpHEuwWDXdpLGhvPvLEZwQpLCVzlCmDlAIkhLSoCyFLiQkxho",
		@"YcywXaRWbRqwqKHn": @"SfXOjFZYHEusuQLmdemfBVUmoccUyRFvftjJwVGYJdYuNIhYtYfLjOyrxuyjBkNXnSTPabDWLAoiuKBsUelhOsnwIqtkLFOREndBfCtIppYYrlJZWBXzYfroVHVCKAfGZjii",
	};
	return pVrCaBpwaJJCWvvItqb;
}

- (nonnull NSArray *)wtMuraSUrMUOGv :(nonnull NSDictionary *)fhuszalqdUMT :(nonnull UIImage *)uaWhkkPZhFrbzu :(nonnull NSArray *)QyxFgeQZKea {
	NSArray *fMKsdYinSbcyoXyswc = @[
		@"IMSRHqSonGnRuLXRALaDqfYTlFPChIgzvXSziiDlpHxtyYpMootBWONDqBZQasabQBMJhfEhylvULbXrAveAdFbVxjCYPLVfURyTgMONHKsEUmtsgFNDlfDRFeKXBGbGiNmzdHmxcvdGxqzImHo",
		@"pnyfvIQZWnhGCXPeBWeNtHLVzpxskEmAdyyGWjEDAaPWpoIGxfjTcMdIkygpumFJyYPCrflPyFSNQwrahDfmhEnTTCihrMfFfnmelCewDHmskBuMQdtqvmZonSZsu",
		@"ZFiutztePbBAtwYvveHtypeFTEJGQlmUHrmBoKREAbklcZjxYIhGgNPtUMVdxonIzLiqjBYzUmcWeuhZBPxsylSCASDIVoeBkJxOTPxiZBxPuEcZlfzRpKTWMUhpbYHEqaGETmiJDTSmzs",
		@"SZaSFpbiiWWuLtdPwkJxyZflEIGgQQajOCtGXYXlQJzHJLEGkdeqrazsWpwPSejkNBupIvewZRJjktBuUAkcwYXlDcwSefNpDoXCdClHrHmXjLiccXIkPnyKNlNVMTVtk",
		@"GSqespwMnNSWFKCemfZCjhlYPyosJRyikfItJgkoOtOnjOPfLjQFZaBZDkEeBQgpwibXKwMAbLABMKundmFbGBkMZVsXOBmqcaLXvIoxjgaYKCFCRdFwxKjEiWgJRGGdgqcsIRWFReOE",
		@"dpHGTDRkGnJmaTuyiTFVCxAydSgdeioHitlJbTlFCeBWeAkWndvmusPiBPVMGDTQRyEoutnpVAxbOAUwNtolwzvLGEvySPzEqUBPAEhcxxIShGbkfjVgLsMcacVPMKguNsumRvh",
		@"fwpoJkXKwKwtwSdipDDitOCArSORJnckJXJNseYdRWrXVawwYUULXsVGqOYtrczYNJFiOWvkhRxGNNSViYhZBnUqzueQODgmmCOhPWvroqscuWrsLZYPIdPEhlmFRTTLSxfudflyS",
		@"zVYIuUEubQjDKEIZfGUjCqjSSuHhRCTElmRgcgdMFDgFBZAZWhFEUEywpNfCJaKgFuAByEOxlYWillixeGAxSzcFaCYDBisvIOHLEfRSXlLTQB",
		@"YBaIMKKVyemHYQnFBThGLIArLLaFgGUEiodxbpIIPBooTvGzNISOpVgLGNZpWGRulteVVtBTvqdrNedbSTemzGGpVNRGeDXuOeoqdPVXirUzRAXhTTFnZCRFLThXeGBPuwAfoUHXeKVJfM",
		@"jBqXTNoeZcIlgRjzCFHjpBTcvlWsKmKJkPkoAxUmjOkWtcbVsTBDKlSFyOrQSRNfHtthIYEZGOflTYsuKDsBuclCGRixgJRFlQeQiWGxVzEJjSUjlIZrvRkzWLIzgBpIaWkwDLNnRKQhBfGYNBq",
		@"QqkSEAYMaGVRndvRzvaBiidDlEAOvmmRLLatzhNKDHNCLaYKkuiKaDpVuLYfHPzjkwneWtbpUIsjxDsxUJqdIMWtzcWGDuzsQzbuoetUUgaSKAuRUXsrClQFmcdmIXiaqZkBFvGMkevHpTFeAF",
	];
	return fMKsdYinSbcyoXyswc;
}

+ (nonnull UIImage *)OxdzomaROXtOxIUqZ :(nonnull NSString *)DFAaTvDvuIZqomGUpe :(nonnull UIImage *)NbkVrDvrRCcv {
	NSData *lulALJBaKkoLSMwzphF = [@"wvOSFfIGmNTrZAIiMwnmyHmfKzGnMLrRaRtrThhweYWJAkNjRqJPEirVKILiPuVyrwsSabXjJmgzlGxlnGBMSEIHgDFDPXqwrfNZNmfxXEHFOfvZgiCnkNvmUsTVlcbP" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *twQMcbWaxwWSTIzf = [UIImage imageWithData:lulALJBaKkoLSMwzphF];
	twQMcbWaxwWSTIzf = [UIImage imageNamed:@"ScZjgVjmKzADBEdqrNKtohMQmBtbGWOujkbbYQxbApFnpaZtKUqEAzGqjpBxLTnJnlLDLElgEYRQVvDKnIEDpNAaHhrqDxHRqNuygsxKIPTFDIGnXhAjxhqckLNXEjRWh"];
	return twQMcbWaxwWSTIzf;
}

- (nonnull NSDictionary *)qgcfRHUHSyD :(nonnull NSDictionary *)XfFHcKdqDv :(nonnull NSData *)aaDaLUAscJRMZmYCS {
	NSDictionary *iusJNjNAyhMTrsqtwsM = @{
		@"VmtBrwCwChzryKgTb": @"yMWMlVVatEQvXaNlUYNrtxWkpbyETUsgbuOoSmnZEqlgqTKlLXmiRnWAWmJufFtikViyJVYcDJxHareyKTdGYmwPgSUGVDYspckDEuGxdpFgNmMdjCtKHxuJFtrfYAcgXguzdNLntHAznlXSrRAI",
		@"ToZXsyLFCjBnZcWh": @"dTOTGKfBNZZxRXxTHkZZRVFTVfDSbSufXzkZVMqJYqeuHAbTqypxFVlvJpvgmEGWoLwChKtTnuLdaashbEXITJHiwGFXBpgFniMrCxziUtYJCc",
		@"EcmHxbNaBLaEvUPMNms": @"VtLVQXYJJEQAlwHFrJJMQTcFHiMVfxylncnOgvNzQIymENArbhOxdTBVUmVZjdfcckDsZiIoFhTWZokuNpJwQpbfaMXWEpawiFjFnRPUhyXxlVYBcyzZylCPKXMIYlyBAPcAGWRLdVz",
		@"UXVnbtUDpyQbGi": @"DMebnwyzGnOduKUwIFZyrKqPwakZjTQQHvsKEXBDvrZBOEMNTMCVImTZsUEIRTCEatWgLAWJvmVoaKGCqqsOQjZSLHTsCljLFKrgfFtNlIoMhJERjChQqBgJfpyUNFxU",
		@"lvJqZGTlUUv": @"UZkEyVcpoDUYleXZqOOjSPYjOXDuMqxOQnPniAJoJdHUXqjATljwLzYCIfbWaXgrJInybNMXSsNcQESaumwrbixVdwrEHDCVHhNsFasItrhIBhqRWjFKIeBFcvWFq",
		@"lMttyVuQiaIttJBjiY": @"KEyFPPuLDFptTnhCJzUkUbjRaHJcMJkhrobpEDPVJtxZRceWGmExFNOBpaenkQfdIttPUaySoeQUqSsijcubLcOZOexEdaIvjPcnBFZS",
		@"WooLQIvlGMfTeWIvanY": @"DlLTqiYHAFnIqKxiUSJAQNCQDdzmmfevXqnGNaMQWrlGYbzrKYJeuFKXislxFVzcJNlDNvGfGXuZWRotOYZCHQdXDbjzJvJcmeckUHFSCeKoIjdmK",
		@"ZDWiSGpaYbfNVLHOFa": @"KXBdUCueADdpzaGECvbILjQkYOyMkqIMmmhxafQKDZhwenPFuyGRVLqJOXDrSTZTzYtVOteZbeXapsFfQsbcsBdoRRJlnTwFusnYwZx",
		@"zCtUwmXTmsAfWi": @"VNiZwpMrogQtYdfTShdHRwRBhCHbnoPHgENQyUyOAbAjApdlZHjUwCInMSwQiWLLEKbXTDtFKqQKhvOEuPEGkuwYvGYmtJeerSATtmPydfTdTtvXSdcdRWPjlFUN",
		@"plRJPPAYgiyH": @"QKxsQVBUyCBDprxjpAEehutegTANPMIBKyZEZOLMcPVcJwBHcxQmueENmYAYzlOEbduSHunplRMgeRuGAPlmGJKqaACsykORRFXyygMTanNaDIyHPvpwk",
		@"tBmnYEXJuPZnJxy": @"QSjXasXdRXyWunQHDskujqwuXSXVfucIWbjgDWLdEMmrAbGmaWCNTeDQJiBTifDUOSWEHhUASUPBlHmMhRoaUokQhMQtYQwQsTKYGRcRQTLQCmPHehdEitInCqkKYTSnPHfe",
		@"VzFiFOSdMVgDTTjST": @"KYLzxfsZqJwAQwQugShSleGWPkIFyyUXUquRhgErUxVpMFXBiwCCXOqSabLeCCBMHnUecVykLgDfRRFDLcsluwdPslIXYYZBNaFyZdwwrPhlWWlLkpXtqOvVMysZT",
		@"VnfePQakptubihNMbL": @"bBLKMhXwRpPBOIxsYulQQxwUmMerPUlZUPZdlxfHyPSFHBFkWBGLkWrArlqABDBocZtKQtiZlIRnqGouHaXxrfwxrnjniSxOjrcbLLYuTexIuXwaFoCrPlLAaNCW",
		@"LpuUsOLPGGYSIpbleh": @"QSIrgUBJsBhbOtbBNPlnCReRQVPlLbwfBibXWDYeRnMqSnhsweatGmyPtHZUkgOgBYGthkytNJFYnXccJQdAuizdmwbLtXuXSdmNvdc",
		@"rzJnkowInGkrbxao": @"gJijromWXXgOqKINKGfEcCXQLrbPmjwTGjmxcqqnuHGRFAyfbOIbbxAqffaWeJmyudoBfOvibtjmDCGdIeSruzInPcKBVtebMdLOzyRULbggDTESXGSZBiEwALanTowncx",
		@"gBarnvucfkAMMOttJ": @"RjVRZhhwuKOGLDNSRKjUqSWUOPsCtVMdUJDJuFTrVkuXqjixNCgtKIiPDRYwxulgswQSHReLxotxQDEgAJWQUDeLVyofeTpkqPDRXfnGwxFzYiiWWwzuqaWHlpALllMMgXzldiutiHkZRRTmcL",
		@"EBpDluAjKg": @"ZqPiQlIqLFZENIpeKuOxhJlspuRxTgQjyBIGEAcLumFHaTgqHTwHiezQXGxVmjrGPPsXdJgxIabhrXfppOaAtCjZwnnHvaKZhogwtJCCVAXZdLPjnEGXmTuRyyfVKFvWlIrPInP",
		@"KvydUBlVPcc": @"AzHNHDKbrvNekPUNiEWLjVlvQSjVyqOpOBZvyZfQvtpdqOEmFJMLmaIcrlfQDphRaurgcSLOTdcupeMIGzGnHLRPOQPncjMUuqTzQNXaEewBBVvjEtWkqKspTLtUyiXTAqrRfstiGk",
		@"FBSXgzKaWfJuKS": @"XQTMRUKSrNUAfEGnsxcoKgernyNTfLIctoohInrNXDKNTrhIrQcIUKIFiTveDsoTgunrJrjVXjqjlfmqWjzGGjZpcoGKmseuZxbhkZxHuMpPCyfQgwaRNhGGHVpOFsrgwzGGni",
	};
	return iusJNjNAyhMTrsqtwsM;
}

- (nonnull UIImage *)CFRKYFFmLbneM :(nonnull NSData *)VJXFckSwGcu {
	NSData *TzntgYGGgJACdaNBRN = [@"mSWzAeVoHfmgKkCLgWMAoffCIzquajRaZToSDBHUygOcBUArKoAyIvHsKtXUekrSKqgWIzcWtexAJQVbPLTDdVdvvMNbvRLffjdYNXWvZJUHSpHzVmQcXnEiKJM" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *sSsWmNiXrBj = [UIImage imageWithData:TzntgYGGgJACdaNBRN];
	sSsWmNiXrBj = [UIImage imageNamed:@"MrqgJAJTHQUxzLmwzCbHjDGhdnVgDFbSFwvjEUTqnuorySTTRdCKtAIpXuQyxYzYXsnEMQBUUFkKPuSwlDTbffZIjhlITBXWqsoudAjZeeGjAEHPvtcDhtBpOFmwPblV"];
	return sSsWmNiXrBj;
}

+ (nonnull NSArray *)EFveRlsPLtr :(nonnull NSString *)TPfTktPFrrag {
	NSArray *IHhPYZmebbB = @[
		@"hGIhXdhtWVJEIBzBUtPrHGuSXfEuoefleEIrhFHTasYppqDVYcVTZEBOGqpRfIRbAPcjTHdUJTsvCJxOYYgRDMbIcJePaHzdLMYbgw",
		@"oyaIsxhqwRiEERqbrDgeIGbZpULIAivwJIBRLPPLFTcrnlJdfjONZfRtaVXnvYtWZReyrmeHTSiHIvhOebemFDgkkysGFXMSPQJgZnWEUIJRiUIewBOeXKBb",
		@"vKtxUplHaElWSQuyDJutqsCidRERMKRlAeROcDBtmImoUyIcRmxlCocJXgGFWyvvecAqduEkVuiylwzdUnPFHDfODAybDmjPPSBSXlFFmQHDUhkOwYjaYpgFncvj",
		@"hhbnXqVYCsZHxbKiUYSTdfcuguVRvAOsapleczkDgMpUFZLVrcPCpAvktAhqIBQOqaCRgxOuMbPHALVqqTGzsVfGabHiXoiDvDVuwdUuBeVIRWTZAbxDfhuEvUoTjPIhs",
		@"pbkOmVePAYVHBaPLxWcLsEagIGyHiJLNynLgEyYQSnmzrmBYYbYjIkOEZgVfIGdGnGYpLzdKzpXhxfhKaWYGoSlkdorhYlWgoqlGaZBfVPQlLDSDgUhMvnHmPSAEReIDXrOPHVDlyQbfFEj",
		@"yZIPccbGJAINbvJVmNRKPTSBtpaXkUESdBOaBlnmyPzlRusYETVrJLaYMFWlXQKjyJMLgLMuKjeWvkraAywAEDeCaCyfgUsLehAPamUxyiTtkldCxTrbyBPNlzbgcgMAfXzT",
		@"DtpTdDmSQwaACMWmpQuBrIWlQvIRVCLztvcsFOswYInvDYqlCvRkWSwINEbcYRIYyhYiACKEwZGxrJMaMVzJiBATHqndRRkMZacJwzMdcOXDDfrhLzhTxs",
		@"HXPovGKIUGiXVSWfzazfOOjBjeCEWwExdYpjvBntSAkHbYvwhDgGSEYtMUlueXvpiKnHFGugvvcCxigiIfvagAmoAwSfzCQcanUrOZJcGuoOzGpPemDeQLJiOthsQWyuCPggebxRjipIweWRlRhx",
		@"rtKoATLPpuTEXsFqPiGahdduadADRjeoCziWZnJcbjJHVPtedSQdYJmIwYtIXuosvXUgUTsRbHDjtEezyCNOolcvQnaWhGtJypoFxHUkSfNvpBqeHJacICvaZqWUnlhhktASdM",
		@"yLuzjNmHqOaKyBJGhMfwwETpStjVMdqVAydyvNYSdFZpynYwvszpmygsjNqxmhOzPDQvTDmJcQBBKCUIhZdTONKmeFDXGvuuaYIEppSJNQi",
		@"jGGQHQPMuRcbjOnmHcWjBLBwxWEXIGiDoXwGBUDNPJGSGCigoWGVFpcJkAAVlDrwdRvHQPbGZNUsCiAkjmAJEoXLSrxaEceDIrSM",
		@"OncMLoWOPFGeFbbgYuIMIfekRgzHDWdotuUmEpujSETKTZilOkPfjeOOENNdbUhfGXvAFnqmiIXIdtTiSMraVTxXQURBNRimrOTufUcDyCkUQbI",
		@"FnMshDuonkEpHFCsQlzZjFrWvZAruYOgYMTBgEMZjqBNLMDPxvTgfKegYkUvaHoHKZsCrmwytDdDvTlRWsbMJMPxtfvnxOJIRtnPfNeSYLvdGYfKfWPiHm",
		@"YhXLcmtXPkSlODhbfBJeeSLDgruWHKqqWXLfrirmwxKJWbRxlgVnJUbtaOOICiSfjvAiUiUhFoxhVcLcAekhxuEvwcrhOiyIEqIlfrhPkDlXpAodZYnTJPpidZGewOYKa",
		@"YrSHVIvNCsUgCUBrlRYzKuoJNOnKxnOXeYnrUCuVcVJQNKEpnHrZmhDRQnludnjlVHFNMHcTbGezqlBgrzkGEvmEVQDptcWwFZPGnQdUstbauGWnHsLKhylEsxEVtkMzAPQFsMePbwDG",
	];
	return IHhPYZmebbB;
}

- (nonnull UIImage *)voIkCbBDHV :(nonnull NSData *)EwqtxLABtDueE :(nonnull NSString *)aLqijJclKxWxLorPj :(nonnull NSArray *)VjrFvZZUfbgMbZuB {
	NSData *ZIEXHLiYybHcyiZ = [@"cwxuoaZNUvjsiLeQOubFUgJQvhujKhIDPxEpcihFSJrDkGmLdfBRAfGFsPcqrwytgTYFWdaNsvPjVayzMzapBTMbsNoOFUhkpppSzewJhSnjoIOwfOEhQamwxlKZECxy" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *YhDkSwnmHTpfLuZ = [UIImage imageWithData:ZIEXHLiYybHcyiZ];
	YhDkSwnmHTpfLuZ = [UIImage imageNamed:@"kYPAIQHzLglbrybgWsPMHAyzzaQNBbAMpMxaKPrVQJEcMbTxOXzeKLmgabNgGvYDFgcchJZGfPWIttgXqcFfgcOLceBLWcEzqXIBydiZDSRqEyjXrxfvAuioBMZjMHFzlyQMCVATSczKNlMi"];
	return YhDkSwnmHTpfLuZ;
}

- (nonnull UIImage *)ZWJoQuGcin :(nonnull NSData *)fhXwmBVUjHejW {
	NSData *xfukzmiCTUEHLBzC = [@"lzmyXXEUZadGSQMKEiLpVxMBJRYCRqLyuzpmJfpSHeFrkmVmDjlEIAkoddvdQpwVKwHrUKKpZlPyHEfkNQHNxLdkXTtLuHdSnZQkAAOH" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *XaGRfSbtXggBNF = [UIImage imageWithData:xfukzmiCTUEHLBzC];
	XaGRfSbtXggBNF = [UIImage imageNamed:@"MMIbFeRedOxDGWqFTtFwgFnVrwyhjbMTKIrvnBIuUnEaoYbTkyKRAYmcpjhyJRQLAOGIFAPoQVkgfwQPuGPZkkOAwHPdEyeVBCjcGvTtjfelpbCSGifhAFAJOtxSPabqAYxhFlKQ"];
	return XaGRfSbtXggBNF;
}

+ (nonnull NSData *)UVrgkXWtFMhZho :(nonnull UIImage *)nIhrWFhEjTwAySejUf :(nonnull NSDictionary *)FRTulqIshXjjZ {
	NSData *CLQrMtGrtAvGQwSgERO = [@"kZnffYWwgfoEIqcZlRiRmFCNtGnOnZUDdiFWHqSMexHdoHicuNwUUafJCUqMyvHlySZCPTiQnjZBjIbkLCbLxEMfdHTbwUztIJUSUsZeAcIJAnCPO" dataUsingEncoding:NSUTF8StringEncoding];
	return CLQrMtGrtAvGQwSgERO;
}

+ (nonnull NSString *)yzFwUfitiNJuvi :(nonnull UIImage *)XeTsdyoGhUPicGYGaeP {
	NSString *tCrggIBWXU = @"jjOLVRbZbrZmgwMATHGswCuSeVEXxAJsXGbnRpyjGaVmmLfxJEvEokNJqjOMDynlYfnxGwInSfwmMGMhljDnqmgknwMnkHAOeYrPlOeQFsIXSkbqsUwNyorWNNhPMkwIPDzm";
	return tCrggIBWXU;
}

+ (nonnull UIImage *)JEwIjMfrSJZ :(nonnull NSDictionary *)fYAIdgfrinpPDKmhfL :(nonnull NSDictionary *)QQJouUjZMNXLDw {
	NSData *nuhRbJArkKK = [@"yNktmBARwedlsFsviqWwChxRCnUYKkfNXahOTCZkMSRzxFjnqbBAntJmHwHlfpLKtnYTZKoeNFlUaxwUthPGEoattvqCifVerGMvkWNYYKbOOXGWzkcvBM" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *toxuUbhhnPFgvwRh = [UIImage imageWithData:nuhRbJArkKK];
	toxuUbhhnPFgvwRh = [UIImage imageNamed:@"AOHJRFhCfdOdkOKOmzSrAUOkyRdlLeMpnleCqKbsBKlTHsnxXBfVDKkeeUFWXfRRbAGMgPDzWbChvSQlAehCOpkuHAaJugoaixsktclWwRYcfYbJaVZAcIYevGzJYoDrKlmobBbvJcnHuHsgZsVCn"];
	return toxuUbhhnPFgvwRh;
}

+ (nonnull NSDictionary *)JITfjjjtsMOZqUvQm :(nonnull UIImage *)uydiTSKejJsyZljYmoy {
	NSDictionary *grKWtQSanmi = @{
		@"XWDzwXpSbGmZSwgCYX": @"JQAWuUWFtmVmFgUfepvitxAbpfuLilnRYSZTEtQzfUMLHHftEuVEyLzuumPqjucuHHMMBmlQDcFwlKIWSDJVEdkTIoMdYzlcWKLHyeoPyeyVjQTAzWPeNzn",
		@"WhGEjcXDFQGwigZIx": @"fQIVVDyWIQjpzIvUOVObFvnBZZKsyWMvQdIvjwNRkTTSFLCTIlgAbWQQukQOnqEmuVyjVKaBDpKgDFrWIsjpbcMpCyefVdUPROOpRtmCxoKPCKLpfNVzXnTEENQLXswiVZqVHWfzdqXcxNYtswcs",
		@"hUVSCbvDkivn": @"bSzoPcPMdSiKqvofmJudDStYxdFTwnOpwUzuDVAgKjbtajNBwvBkVuAbxZcBpHiRzTWGyQALwCmMJqRHbmVNFJbBxwGHlxztdICJQvwPRLQwFbEDgZavKShVOrwRvoKCh",
		@"wibinPnMlDBFJhJ": @"nugftvUOaevCCMPGzvLDPRJnFqSfNWsBkcdPQqnzJiSFbwUhwrIhEuNCtFbCZVmyGxkMexgNnZGCmPvaCWMdyrfdrkBLEsOxddwTEZtmST",
		@"UGfGKntuRTMXFRdlVIC": @"fwbpbbbNMQhIXOalLPxqwgphDGiwjyacijWfZhayLmQDAWtkUOuuyKoFfRRPzrkNIwnCXvgSteGwecTZPLBOfrChPXvLMzgATbrkfoaMxUzeHxuFVFgvVjgnqiziPdtEdKGNpOiXFoLdjaZ",
		@"gnCQUwGogoMIUkdxKh": @"NunirHpbwUNEUWhOIPQddcfEaergGaUEjyOOmZbRnLvjeKaZfZNefGLGIwbcYpfrWcbOXDuhVmxLzzGMVjcMgGmLKIlmxuWJpOMyzNYhkj",
		@"sBzBBknyjxzjlmrs": @"qwjslugHlrZGTbSYoPrIWYlkuyoIcadyooAruINGvkFFDUhDBdsDXjJdfenslNSUClVqoyXQYOIdIDRCSCpyHfgJpHnxzRSUkXWUmDgfHvkiZZrLql",
		@"zjglmBdXSGftIQ": @"cWNMdlaOnlgxDzXHWUzLcSYuQJfUXkaIWoHIdQjqHfcAjimYOWfOClfGkksdqYXQueOQbVmxAykETIRwpPHaAdaRxFhTscxHCwjETXbSFDSWFOCMiRZNvvJW",
		@"lBjbYclIuovGTQxxj": @"NZKwPrUOnMOYBpsYQBCDkuXItVMtVzrHJZXOtjlIoWEkiYUAtEQpZNSBTPyfyWngZfNnzKIWaqqXOBwmCfgpOGGeOQwDQhibmfJuCRJhCgRRVJgScm",
		@"GnRncfDJfQRVcW": @"UGOvXgmTkHaqkTsLghyknhKCFvrlExcwVUYoAbLXpXZFIQvPLIkSkifFFCqbtgIoAlSYkvRYcVEIhvbZUrkWlJFHXVrVLLKFfOBlrOQqNLJuJVIfGrkN",
		@"uVBbAmlfBjNTkRCAvR": @"VRfYRnsTJFwTqqjqpAOFbIgfmPpUAfLPrpUviJTWqDsCRBjMWSgSpNcRwfiqIWThiBnINONEGnGEJzTBYBrSjXvDWkOHkZPEGMbJuxzoGRJjLlYKjNBVZtPCEVlWaMeAILkCiBcIUZijWFOIVGH",
		@"icSKLZmVFlNal": @"jeHFxeYDZeLDaJgqfTYAbyWtmRzSvjmVJWFgbcGsVfaIXwlhfwFFrtcdIecNiUUMJcjJSxgdpySwXJOcFMrYVoYKHYhWwuclarLYJVuwQdXdlFnRrbfyqZTm",
		@"aqVTvrpZDg": @"taEyPfpDgIYpxuluFWYUMSRbjXkOqbJLGAiGbAcvAlSXbFASRUoxWxThdKOxLTIHWROrWUOOoLWCkhrjzjcHnKnXJtMDsdaOrtjZUyYOrYDUBAeiHjD",
		@"tYDVuqERWLscDvgwSHr": @"gzfJqMhKaTcuajcrBADFSOzdzKsbpIYVUDLuKRCTaKoyljLHMXWalyBtDdTSSWeeDESraeDYwMfdJBUXAAuSkMszVohTvteVKdaKZhXprjgyHupRVXHjZc",
		@"fiUByzlTgn": @"pFMAeoyyqKzJqhRFJSfYkkjaddwfSZTKaaVtWblvLXsdeujjqkUlXOtRluIomJuhvYzgBrFvkSPGOemmmNQPxVwyzIfEEIJNLsNpiCRrooqiGLmTECgMvYMRdHmgOAyvwIFzFojbeGombtSSUDl",
		@"YBbspaVagAOUWjBG": @"JjIaNfYhjJtdZNuVSbwzcyevHycQKziMqTHlczAMeLYsOEdVlFiilTLeNJyFbCeibzBOTFOlKsalMbwCxENinPOZtOghGQiFpwWSnWSbHGacugEnRTuCZifTgqwhxuWdYhPgudYkTIbYTo",
		@"hsAobniKfMb": @"eHJLBxvGFbiQAeZdrsfeZwQKkBWBctdexpCSOMwyHXxwsCkIxeRDGjbKIUlYFuIlKVLkGoQNmwaKXboJtZuzhmJMlUEHtVjKomtcfJlLONzADagmImaayCWwrRqkhgIjpquVQrcH",
		@"pQPkbLbpxT": @"BUneGHUsybJsklzVHvOVfoOFUecTWqBzDzgXlDPxXoJGlNyjrnWWiCUcVMpabQEyYQUxlpstuyvFlkljkczdOEhgVAyzsHNUElefWlQbRPKcfYUnkRvIfqpzwwSQVKwhTBqTgoZzjIUBMwAQtv",
		@"KwQPpqVEEYFwUht": @"FFxvCnPQndRzkmQHauOJltomnwSVEgznPdacLArApPbECVdHPSCMmIWukEnbpRpsNkXbKUlYEojlxTLUGZOElHfOTZbVeMxspzeDj",
	};
	return grKWtQSanmi;
}

- (nonnull NSData *)LfGcGKQaKzRnuO :(nonnull UIImage *)tJyDaLehCs :(nonnull UIImage *)aTUZPbWmzYJj {
	NSData *jldsZAWwKiHUByUUC = [@"DCONtPSgiuHSOXpfdToRQLrrFvIZMcOSUwQcQzJYQZPSjDABABkzxBGvjsyhXwuULnYpquaoVpTJakzVVlwcjqnFFQeALEaJJBnetzdlsPxTFOwNdKRTHRmu" dataUsingEncoding:NSUTF8StringEncoding];
	return jldsZAWwKiHUByUUC;
}

- (nonnull UIImage *)YEHheLzAFm :(nonnull UIImage *)CcayhKkGOmTmcou :(nonnull NSDictionary *)fBtaaFtbMQxQciqrl {
	NSData *rVYSfxyrbgujsaBrL = [@"XYwDmUxPTnTynFDmqqTGJgkakuaMQyWbJFCSCcNsPPISLxhxYRPkImFaiZCBlcsFtiBxJPNQlhuJYHNtLWzKBtHlbIdLOULRbvExsEKB" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *kcKVvcWCQWgcJ = [UIImage imageWithData:rVYSfxyrbgujsaBrL];
	kcKVvcWCQWgcJ = [UIImage imageNamed:@"zWUjewrQArmKRKGaEYIlPhkvczDVfwqiVEjHCGTBItXyCouOXgCPIgBxIaylwoLvlOSIqpgXFuiIdiAnoEqHDnEhfMVJMNOhnPYUzHMcKYJyeGUMbBJxFxaxNLS"];
	return kcKVvcWCQWgcJ;
}

+ (nonnull NSData *)ZaSLsgFWIECn :(nonnull NSArray *)QoGwQBZVtM :(nonnull NSArray *)ZONvUKrPeqmJgYeUdG :(nonnull NSArray *)zbFvvFFKvvL {
	NSData *GsEXJVImxVIqXjLzxC = [@"RjJLXtWiExkrjAGCcwxlOyrArJRNqsZavZTcgKmWLBVTVtmGkCOqiwgbIRBHOLTivRoFrtqLDAbrWLbjRRDtyDxobTUjUIfctPcCRPcMHQFvRTawwvxueCh" dataUsingEncoding:NSUTF8StringEncoding];
	return GsEXJVImxVIqXjLzxC;
}

+ (nonnull NSDictionary *)diyTdvFxxxyzfMW :(nonnull NSString *)HbDvHRZcGPHVb :(nonnull NSArray *)uxUAnxcMQzZXPnqCP {
	NSDictionary *IAjJmKdXRUQgBHxVUs = @{
		@"pfdFXwOZfqsgBMgOHly": @"RTBCuuufWrJyfWUXJCRNxDpocsokAtzErvtDDWAWXfMNtmRRVpMeYOxIYSrxYzthPAzTaBdIaGExexVMOFsFWZeLqgTTVeeqxSXGbrMixfvpXuSXsMkkZpwyHHMSyNIXZxuTLAFjfxaisAqTfaQwQ",
		@"kGXBbOhfEGQbk": @"oQDlgwKWbGuDGftfwJbicciqWMUdGOTnjSiuhZlDVrrurHiDYWSGnpIkEbMfDBgoHopwHGiDsgGPSTGKASHpYfvelxFKrOFEhNcnrs",
		@"QfMJbIoXcjBGE": @"fWcdZntuunKoRYCeUEvlaMEERkGOxUHIWySAjhpYTubsrjqQgDCsRJIBbXALzibkcQhZbzseMJZweYrfdgUXViXdqQBKLuTxVhITFggRUdVLswDD",
		@"MaShLfEizAoOFzum": @"DmXWAKzOFplTfdoiZUwkqfBUiqnKuIyGlPulIPdfgqlnsjMqVboDaMgAXKOmgCPiUHbtljWNxRoHwBFknxOoEdoTZTsKtrHEQJWMypLyjQKhM",
		@"mxMMYiyLkzLFAGaoz": @"lRMIYcRyoRunZICGXVXYpIIEBxjGYXyaTXqEckxTDwJysjFFiQYcpPBcMpQtcwAZMOfDvGriooJOFtQCaEVtvXhnwVStQXsbYMceSZBXSiuhQJkNnzbRPFjcEJlzuX",
		@"DEvPPEfjuvAwigHpDM": @"NtXjTQhmjbohlBxmMtKqJGUthoCQkcMaCLBtAtyToPCeezkmFwwRyurXkLGUJWwvLLpGhyuYSHkjZMceccryUnKCtXLDteXyBGGYjkhpwksfTSCHbuXUeJlwPsOsomTyct",
		@"cgydIxiRDsDkH": @"liUMsbzfRfWWWAcGwFsYyzlHxZaZXZMEaRRSQefJCfbeLgtFwuCzCknCMqbOsCaSGJCICWroAEEdLUWUuHEpObjZGSUESmHiGIeTAXHrBduxwUzmoyajIDmAUcyQwtGdaJWLwviUZgzsO",
		@"ndNjwgWzab": @"wVOzWFtpgXDgFhmPjddAQqXXSHSYOhtJYDWHPpIdYLhaFUtXAwjNpMKFiSowTeFncanFSpoTxDcTizLKXnlVgefwfdBwgUEsuocLvkusEGfiJiwdMElttySdjXmlUkiINqyIMEcpKIx",
		@"vGMjFnidxXDmf": @"krqBBLXbqauLrqLBjHFtVKwNILCqmpylgOaIVJHWEOeDikmSMdcQBzIyfYrZaSijNCcvYTfVqhQcEBDKeDUWrSQqOaiQvaIYmPDHIrUdzLWybxstgzXysBAgfcWTJacieCNplVNxtmTFaXqajNipA",
		@"lzFOwxVvKf": @"krHxSVyZkIuohdgANXyJzWcoQgekkgwtjLhrjdUHtPeMdnZaOEogFMOrWlEdPCXMJRDaizGWbVdSYbEkxcQPFosUJZwgbogYHQksiYpfRzSErXvgqLeDNlNDNJgaeUPyI",
		@"DHiOTYEKwjj": @"AhpIGcSWcEBMTQFFlDXgIOLjjfNiGpNuMwnEggTYeEpGOAulanZWhEajKTaPIffFdGEKnghtjuKfwjBXCgBNnlRuQsmiwXCsLLifcBCLHArNSGIXITkzleSJpaZmgZSUwUbYe",
		@"fBUXJTUJmx": @"qsExqbCEQfgryBPdFfMPeLHTQIuGVmlfWxsAkwUBOSTihvwzzgwAEwensGmaAZkLVMiVOYvhUMtnkBUtWuWHKopXpWdsPChsiPgDwfuDdmseYJuAZShSbAKQWPQKTCPsNCEfdXyAdXqg",
		@"CvYBRMdkub": @"PceAYybBbzImxtdpoUDRBgSlIAxSibSsPzzIgWQJKFWdJRyXpIlGPPtYevgZoboFssotqLOCUDjSeXkxTljdySZZmqtEWnoGlyrnRwnMhliLzeZaDwWh",
		@"uVVGaLEEiaN": @"fdFjIMjrnuwXYsYihWSDAYLYCCBkhTNXwcJyYcekuDOUQcytBZuRnFLPBNqVkAAarakSZhWKGwAXbFoyCMQlDdldmCYsadMWZHdYRZvBzVfdCdmdHZYUPdSdATqMad",
		@"saDmcKuJzVdMDZM": @"zOgTNdEPxcVLluKxLnwMyORJtBKgJAtXCPwODWlOpgoAmYxmYpVOBBTozGTbZgaVOQjnMvmkdohkveUgTtNdoFHLelmCiMYsPJkvVbEVxxhCbQufZMsMxfSdCOgGkywAJNgYZcsFygy",
		@"zWiLcaPMCOIpWgkDv": @"NcYCjztumLiZdycXlDngCyuFdNFVFHgqdVRWZkvEiROBDfZiCQQahvLBOrLmWhFxlZgpPhZJwrSedgAKbxeLWDVczTqfAUptKpopMskpeUtTstbGzLMYyxTcyKddBAptlZHbrF",
		@"bFpzldCPCsHgIdgMfMR": @"zOHiWIIagEJvPCipjbsGSWcMhJywGCIVCCEVtBESStHfVlRPXShSryqNJVfrGrVWYmnsaewpNzRzojMKGKODxrnWrGCYWXitEGSZJqr",
		@"lAqtjklHyjFPUKHvM": @"QrGqueIUTZAcHGNBututkvbUaHEsIOIhKGENSrdQXsWFDYAOuNNwVbeIZwFFDLaSkxIZLWbnMfSzmOgcGOOVnpgQsuyjJDyarQJFnZJKzjBJZoWzFwdpVvtLvHO",
		@"trgXPMkGxWPKFSEp": @"bPYpZObTsfcDdeaslopHPZERmRzvwWTHjYSwUSdzvMJvFstvLxgpvbCmrciLKkcfrBGJSsQIPuMgPWiTrzPDHhxldYwGwPedWXZiDHOjMJyvuIuHayfqNWFPxwWoRARCtV",
	};
	return IAjJmKdXRUQgBHxVUs;
}

+ (nonnull NSString *)nxOIzLPnrpXGUUbZ :(nonnull UIImage *)ndpiFPYMloiNglOioi :(nonnull NSArray *)tKtPFYwmbMuTZPvpBG {
	NSString *BPoiyBISdJJoQndjN = @"ehyzdMyzPSmoeibzSWKHJBWNyCGejjHTDntOvWknTxlyHlWvTcJtGvHfgZGnUYJtsQCWNnqNUwGCKQcTlhsaCeqwYhbzHICnCZlnqmQXLSVsrquCThAlELgCtAGOxWTn";
	return BPoiyBISdJJoQndjN;
}

- (nonnull NSDictionary *)TiIMxtVrkldM :(nonnull NSData *)NNIDZlBsOpbn {
	NSDictionary *GwDqWyFTBaAbd = @{
		@"TkwBmxeqBNSrIsP": @"qhLlzpepuuzfUgQCXxrspBKhIpieCBrKZvqoUnLHVAaLYAGBALIRsclpMxWiQGCydZdOZjgREkIGtyAsIIQKYWSkYijSqJqsrLJcZwZII",
		@"ssXrCYXELfRHkxAim": @"pUbBAdanLiYcnySWvjHJnhzhhwxFoYgXlPnLMbvjFWbrUFJXCpPAYrsTENjzjYBYQOzHWmOQBzTIwQVZAPelkUFmdTSQxrIWzzULCedfAJypfSZTLdbFQfks",
		@"ggyWKasRVGEAIn": @"quRbyxLHPmztxDzJmDKtRMSOBolcRIHTcjWSODcGuORyhyKEkZgUlUTzQKwOmsgmbJVeBqhDzRqBffDkHmwPtONYOabdUnpsKTYUUnGGQbnRDtcmyLHioMedUYnkaGfMYxBZJUWFHfvAi",
		@"OPgPZHatfAacfjfyceB": @"WbjsMEnjTfGtUOqxAVoHjePWQZlgrNyvAhdrHWYILtlmkOjVFlypOdXJdubDyOyTZhtOYYHRyKZmaMaqGAHrUrxtlUvVdFrZRZjLDXzqXsaVazhbDYoHLgIbCsUPD",
		@"WhLZpZwqHj": @"NOLGnBkXaeQdyfuYxXthDgrlgCgYWLXfYNxAPUrjQnMPwGzzcmnGbwMkMHuTbVgMndaVKATMAZsluIqzTmUOHxppaoDsxVuQTEKdNrrFtLLBbuGzTryxS",
		@"NIpmEtXRhGoGkntvgTi": @"fXjrQMRYDfrqOEPHCqsdkQiUpLKiKXLBDScnNXGFzBXnadgnItNuLSwGRGnNcrvDZSiPsFWfVCVDVoqIwPpEjHIUzuXwMWezmgmUuaWljTyhXPcULDZnzevSuThjwTtTkjXUwiKWCPrTqy",
		@"WrkaaoBWHfRWaec": @"JzxLvTsrvNPtfWQsrQEfaHvYpepNxZjDyjxbleopeNiSixPrdYhXsWfYSgvgNNHphfTuLMVkAuvsYOwtSzoowAKovsaFKGqFJFKHPjarVEpL",
		@"obsnXPblmRTt": @"siVOelJAcqoHprPNUjeqOZSWnuoEnqxoRGHENumcJBltKUtKqtBckVObKquirtYTVpqEGdUnycDhJxJxjrFiSnCZGbZqkaznIckwOcsmkARhLEXsBqCSSULBJdYWGyN",
		@"WlejuPHjcspnPLNkNZ": @"XnZMSZGtOosGZLAZUyayCwkcJhtvQcCazqVMZmrkIPBxUCPuCtRWNGvELpuPXiYUxLDoRzIhGmjaLFPCaDBVjrBCpIiEXiiRGiAQFUmkcleBTQcylhXFqulHGeanVIqvrLBTcWkEjeriG",
		@"QGzXMaPpaSFbN": @"UsWhMjkwnRlvVVkBWSUlCbaNQBkXCykcVHKgjEXdzTnlzDUtaatYEGKfPXvaxwDeUEuqSpuFnuZzXpmmkicNivEFDdfRLjnfxfyShEASgfdBNFpKxnnzMkhUmpAbiqlgnUFDPIWqvvaQOIsFKs",
		@"zlzNYIOUlmEw": @"xhTlRWqjMJkpTFnwuOgDUTykcSMalyGIrBUJfExCOjsRnxuuGAsOWBABhmoeIdGLzqcMliecRKXsksZrEwcFyiMuebwFYLntFNXMMmqZLzAQLxpiyV",
		@"JsDPRfvVSZ": @"YDqRwBSnDExBXJSnXJOewtDmkIcYEvdPhvCiqdSGcObpdvuLnJCfjVQpUmSoNPEPgmdcWknbSoqHNHwxuedcNoRtrIRjToPBfVbAzxZZRZQFDCnxcb",
		@"golTchslcEGBNeMga": @"acgxErMWTrcgxoyPXsqlHjSDeqOXghmRLkuPVbJBkxqkXqLBKRRjAPDOWrmIgEUIbppYEkDRybGIOehychvovaNwKFNtchWzyaOgoFZuxLmPodffOAifVZSvLSZtoxKKrOQm",
	};
	return GwDqWyFTBaAbd;
}

- (nonnull NSString *)BrVXnYtywj :(nonnull NSData *)MyZlRcsXsaILkaQsXT :(nonnull NSDictionary *)ARBKvLPVoobcnt {
	NSString *BHMQAeBkAmZKEaM = @"LmdmhHRFkxwMRSnWkCGurIABJmxgsMuPDyKEwCxKSgyjoiIAbQCdAoZFBgGAYpshfAOAkiepFiiWNDyvSWorAiGHPHLNyZyHBAzRegJynXgHdTNyeaGGR";
	return BHMQAeBkAmZKEaM;
}

- (nonnull NSData *)FxNpZwblihxcJ :(nonnull NSArray *)iLkWlgLvlQRm {
	NSData *kAwgcdfLNiEYdgvT = [@"ffdPhvpxSPxSxwoturXyjFpJcRVieidWWfWHCAaaQcUCuyfCHEHrHPUjUcMFIUtctULcABEUREEARhlVUPWDEYEPGOGbkevNYGzdatZTEDlrHKNAVbHERSFGYI" dataUsingEncoding:NSUTF8StringEncoding];
	return kAwgcdfLNiEYdgvT;
}

- (nonnull NSData *)fzXxJsiaZeiMuFX :(nonnull NSString *)bPYEVdJnbbRaPF :(nonnull NSString *)rGoyZxreRFWdqEfznJ {
	NSData *BZNeHAbwDfsTYZ = [@"bLSzfYLlyHnsSxYKSZfSPHCfxUOilhRRQcoTnwPrYlRFMjgSXZzwfwJfTlhELrscgnBhwptHspNKbuNuRHdVpryFbieIvnbbhsnJjHpAnWzWTXAGcpavaVarSjpFrdYsVurzUhkUHuP" dataUsingEncoding:NSUTF8StringEncoding];
	return BZNeHAbwDfsTYZ;
}

+ (nonnull NSData *)rXulGHuhskYUaWyVnV :(nonnull NSDictionary *)IEFapsiAsyEzInpIo :(nonnull NSDictionary *)nhNpvSyrou {
	NSData *uHxgpvzYiVk = [@"PFeZMuqoDIroJhzLtLlPyiKHhIFFWhYHlmaogBtRDRCVnMWCsFVKMUHdWrULZxRJOgViRAWsySwdJooOHImEQBpabllSZuvKtkdstdoo" dataUsingEncoding:NSUTF8StringEncoding];
	return uHxgpvzYiVk;
}

- (nonnull UIImage *)uWFNhYSOcf :(nonnull NSData *)RfrugFhRVPmXe :(nonnull UIImage *)dUQqCeNYwMOB {
	NSData *qZyqapTSkyWB = [@"ZhqASxFAhCXjkIEBazIRWpVBxqUFrKczllGLDZqWrwvckumqOqAarKxBrxmdatmtmGNkaocqbjJzeyDaBLEIRaVzmQuRjPsMItuLRGXqGe" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *ygiyrVIxDxXrVUuWdlz = [UIImage imageWithData:qZyqapTSkyWB];
	ygiyrVIxDxXrVUuWdlz = [UIImage imageNamed:@"imYuiAKliFPvTLtiDUzCwKpwxXOvptHlGyAyyvjTjrxCTPvZbznBcrvknbHovTrRacLXJxiYHdSbkZZUjXuggniytqVwtWhVXuZMSLvVgNRSLxNuyLJhQUXyZPhAmljWp"];
	return ygiyrVIxDxXrVUuWdlz;
}

+ (nonnull NSDictionary *)sRDPrbqQdMva :(nonnull NSDictionary *)pChpTOjQBgpCMVSIV :(nonnull NSData *)HTxdpneBUiiFXDNyLJ :(nonnull NSString *)yuTGYGFcWlGyaXQuCMB {
	NSDictionary *CkWfaIelccjxPnO = @{
		@"adlKgdRDMcc": @"VdGEUSDHrmOykYeOksqgdNbhjpVGtfzmLjyeVgzbrDekCltjLxApYaZfBoQogsatCLgodyivzTjcDbVfCHsusXjJAwpInpOqhSVXdwAzImCTOUyj",
		@"hiqsWUrgIdQWQiZ": @"LCUUhXyYiHqwuBkYXaSzLcUVSApOxvAImPcxgnTPQEzraNKjaYtzMTNtwBpATIwfRQbbGaphqqZgSTYEJghyhCanteFxbtPNZSXpuHJAVLTITowfnWHmfnS",
		@"BZgEUPjsPHAkJUUeGCk": @"MtodLOASuVydjrcZeTPntntpSrWvWnFtNWsVwXEWSdzETGZHvMjQshtfDdDkkcKobUYyFmLnIpaXalPUuTtBmWEYescSKeoMVwRvcrIKU",
		@"CPdURRrBoT": @"RlBtcirPZdWROvRwVHciWSjEwiFqDcPqBqybLXExBzmYetezfFLEZDDfusvkYXFnUWPbkYuIGzRxeTKaplTioDsOLSdUVwKwMHYfaJa",
		@"GaLaAfOPZjabgnPD": @"NFUoWTkBgvnXrBnvwXQlTuMqHYCrhikRrbChGsmppFyFhGWQoJnqaPRZTWAUbuZfypofHoXgRNtathoGtgURCvuMkzuUPZAJXYodJZdcrbPiPdqHTHJYzoxhLkXbOuhllFeCGObEJyO",
		@"UIGxUbwSPPaBkQ": @"ACsxSBHCSCAnRhXwbsNfzzAfglpZAMjlYUFfEiBojMkgDOxvhjJFapatmMoupvSvtdZqIlcYFCostZnDcebHRInjliEuMlXCIkpVFTanGiPLVMqVDnAusvmRfEDIUlpgWQtBcvKofdyMLt",
		@"LMyvpuSUkYER": @"poAJkJWVjiPjjFvZeNaCghUVlJUkoTBdYbBlCJNGmXoxYdUqUTAooTRaGyhATkJXcmTjHcJUsIqSoavLSwYUpDkxgLXFxkKEMzvbdANwzDgtHXjsoJtkF",
		@"QPMBuGXGqSPR": @"ylzBARlEciPYWNautgViBLQkvCfDROOQtEYaHBJscJpmXbwOxdufYWrreSZlWSTAgiBulZGkJUjizdZAekUdNrZLuNiHsQxvvNAweLUvGPfUrZsPhGjNQCQYrirlHGusBLXBbyeuQuUqkB",
		@"AprEWzQXVzVaqfqijJ": @"bakcLcUYXzUKxtrmnMoGHcpaxrrXcQfaCWuBVNdrsOSqTrgxRcTMQWATLvckkSfdBEPIScVLANDbexAdWnKnzlGjfHMbgZoENzjOxLTegFYGQRMsIbNwPjZxvECFDHKSJKPavvpWOSUO",
		@"EArjbrhWxQvsBDd": @"MqdTUIDFovByfeboYVmxRCwoKtorNvUEizUXdmoxIrpcpMAVQsaLYVLTWLRuPvRFARrsoluTvbOofTBMleqyYsMsQhUKCjXhmnPLFByYnjIgxgByxrrZmNzTj",
		@"qhLDpqajgPqePLPzoCC": @"KgRJIObWqJutzosMHZXhlWhYXIvDTyWiCqMjuveYJLhYnnyJndarZoDTQVjQWfmyDURXcpjpNaKcPiaVVsToMsldLFQuZRELNJQcAtSchdzNVhBM",
		@"KezGAiCAssqhcrDEoLQ": @"MYyCwIkDXJEgRfgNopSrwVKxANHOaKQYWosELDcIiwrNuRESrGqkMsmPTYnIUalfFRheiAwbARtEFflNRvcvWkeKtrPxcoLERnZzCygDvIgw",
		@"fnUGyTHbnwekfYdC": @"gFPXCWiYIWTsjovKtWJuRNTToPjQyDoqHmxrYwNZEldUqJemITgDbiMzkGgcZiENCoigzOqnfdWZXlYslKcVZzVUkGGskcqfTQKBnUImBWHZAxTkm",
		@"LzPHxmzWCUVv": @"rznevRKKDILczIvdsApLnWEAdsMopZXmvRsODNBXNgqtEQGOswDvWNlvpkZpWUqtUDqFICBIQcqgaSYlKykaAXBnAIqLLUqKFCAGbdfTPiuXkqGZxEvdHsgpjdRgzUmEw",
		@"MjoubXSgREe": @"sjcsFHojnGYkHfHAWgKguBtUIPGuPvdegsgpgCnjeQdUfrrwtTibclBvIPnilLHIGwxUKTBMPhHVBKxlRqqOIlcjWjxNJMSuBsqYZAjQuJAdIwdJXGBhLWoelaPLXwCeoiWayQLGKvtT",
		@"vCOOUNkNiEF": @"oAlPNxuOqnlzLwtCIUpFpwcxyiKuYAbjwYVeUbuBoreTjAZhyuDzMhzvtiYPflTaFXiNnYobzZVIJChskjtPZJWcBZarysOllCSyDyNGnGFvFcBDKzZGvsaGlYOLYPsCP",
		@"APkDUHOvneTxN": @"AJTyQZJHSXBCplByaMyDxLIZuZNsXrjJnwQRjUvEsjZvokscGEpbArZWqITnMQGjDDvluOmrOjThZsHHYJAWytgYrMYUxvNjIDBkoDdNkCvhbskkoEpSVLLkDWGsNVnyJQjeMWTbYs",
		@"glDiVZbFPToRZYagO": @"KAdpQDqxOEKjzRzdSHAGEczbXOFkrVIuYSHsTqiQFtKoYZNZCuKVGsvaqvWnAgqOhrCugMZJtSgyiIJHTYDJpmXiFgAgbdvYsmNWPFVwoPDzYMGtNiTwJUyJrItKPmGZldygZAkRrXxLflRrpJ",
	};
	return CkWfaIelccjxPnO;
}

+ (nonnull NSString *)tJgGdwYLPmYVlOnR :(nonnull UIImage *)bMkhyqVbNgpyLvUWnN {
	NSString *OQxyEOCIKQEleIfx = @"AWSBmmyqoRwRcErvOlfAnLrZpQPmakAPzxumpaIRnsUvIJPRmpjilwxbrxeYHlAaQBKMaPLoUfyUzgVBpugGHOJMWHxepOffaFjywNO";
	return OQxyEOCIKQEleIfx;
}

- (nonnull NSArray *)cYeIcWNLrMqZbYFbDg :(nonnull NSData *)yJNwUnLDqz {
	NSArray *vnZHDqXmgIIB = @[
		@"ssaNcDrWEHeEsuzRzSnzliOthFyASkluzbESrHJvihhlYlkELRgXpvAlJOnzyTWghTlmDBBJgzZvXgJkADmhPErzkDnSOhueFAzuVwicTPDDTXYzKHgLLIGTFtkImfDGYhgzbjWAHRQLoh",
		@"tJNIuuzLLxWOLoKUQRjXAmfSfmkdEwPvclqziYhFLgeZxintUsAYFCCzbdNFbMxSYZyyuzmaAKZxLGqhDDoTDyzhEUcaLXCdujiAxLMrEX",
		@"NqsvZgBVuKMDbiEjTzwfCctXFzlomPKouewhzmZwzGcdLeHrmSSZqQpQYUxSuAfbxtpCwJUDIfjBAnjIJzvVZQLIGTHvjWUwtDFHyTdqPICEfGZnxbisfUpnBVvHfmcQOw",
		@"LfiMgFHNfWRjEreRNUJRcvfIIhSdZBmxOwDaWjDGpdlfqPowpwlBJjRPSXZjzwJkNcuHwJhDqejfBCLthojnvFDZPONENidiJLETxJcbCRQTqsiCqgUtTtOOkyTPThTHq",
		@"tcUhpiTcihaxXnTJnAmYUmPPONFDbhAszmRSPjwkAjXeJimEUrvBdfbTSRnpPHtmGbLuTzsapguxwFjmapQvucgcxCqHxdZabrWmUGlLNJqvtuOa",
		@"SRelVvzhgUAKOaxtnhdIJvAIzbWDswwYuLSdZYqCtukJdLLsfisYqefhseSfhWoycwOERUcjERSAwkhQKNvGxCkHdmLNeYdkVMBMOJYERWsUdxzDvLuHB",
		@"uQMLeTRoGfVRmYgLfmvCghRyjhXzzoTfBksbrCGMKJtfskELgdFpnKjisUmMMkfryUNOoQVlKWexumaxSyxewvxYUBuIENIAfRxkDJcqbXfGz",
		@"AxVJbcGJXxkBVfdYiVSVRSDhzaaKbImYSpsPFmvQrAYldraaQmkZAEbyrViMfeeKkScVQJLwcfQxmUgRYtNMnqmwueWihLpvcrwyPPUJy",
		@"roIJLeUlJqkQQoWaIbMCsTvbkTwZinuRDDgXhWVJugcJcgVTLbFPQmJiBDklHeuKEkxPwEqEftzEQmDcwXCcHGpsyzEXseTFBlnKqNjokDHfxTutsLgKuMVAavYQCpBIsYkyxcwsarezg",
		@"hkhgWFZkoSTjmdjDzALOGxlhuoxDxJffQPNFsmpHYcdzrlKoodMSucFvzesjEppmszenIrJvsVxyWSIdGfRQDSJSegkQrFUgimTgdyOwdoRMvRNVrWxuKFgJraILyOWEVVYGZH",
		@"jwuxfHWbyWzeNWJVTsoBdQYanhZxCuuiwFClbAokDsHBCbxzxkDcLZeEKeWziqZBBSUeZKumbuhXtufcQiSclSCShOvQDwzJHlKUJQxZTNnxHJMUjrJlyUTiEVcGUtOvOKPbXaxBCckxssmOZ",
		@"rynjiftNgQGeYHGJgaUqWonPmEWfvhpsIikJmyxalFQDAmPvuRbZDUaPcDTlPyhNNhamXxKeSsMixDnqgHYIYiozHLERXSZAMWKyJHGk",
		@"ZuDhVrldsOCNbPsItRFwtpgXrihmEciNlLfUCbnaDkJXGzXvrBOXiqkjfOJVuJUnPWKKxRBAxbySUDjXtrfOEoXmPZCXtnWUTlRQun",
		@"xBMFxQiSjeIVtRcLAshTLWfDWKuLgTyQvCCfwrLYiSLizaWMjkRMibtwnezvbCHkDkNqrQBTjnTtUBvzYRIurqigHmDWFtyMTqUlvFOmbeLuqbi",
		@"mLtdFynaiJdgJuJavXFCyLNapJoPuoOiENaChXSdozfaTwioQMuQwEHYkDwxYlAUioPylFNLtaoefNpqLtZhGmFFYIJiCDEsCOlCWrbIzHvJPBXwznSpzcv",
	];
	return vnZHDqXmgIIB;
}

+ (nonnull NSString *)iryRSIsESeEgeFDuE :(nonnull NSDictionary *)hwkbjahwHtuEpxXyQ :(nonnull NSDictionary *)VGvTDrWkTIBh :(nonnull UIImage *)lPzHrURrSCDT {
	NSString *iUTtgNTOuxFmDuPOAY = @"eRtKvYwJSQxoNGRnKpDzKnhmMnlznROasNHEcPCBbLqWhVlOmLodzWpiUAxJRSQiaUfGmLdsmGLHUjUmDyimpybqsvFnhdELlacFizWttBcuySoQLjvDlbpHTObWlCrORobmnxRMxvECRE";
	return iUTtgNTOuxFmDuPOAY;
}

-(void)getAboutUsData
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
        NSString *str = [NSString stringWithFormat:@"%@api.php",[CommonUtils getBaseURL]];
        NSString *encodedString = [str stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLFragmentAllowedCharacterSet]];
        NSLog(@"About Us API URL : %@",encodedString);
        [self getAboutUsDate:encodedString];
    }
}
-(void)getAboutUsDate:(NSString *)requesturl
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager GET:requesturl parameters:nil progress:nil success:^(NSURLSessionTask *task, id responseObject)
     {
         NSLog(@"About Us Data Response Data : %@",responseObject);
         NSDictionary *errordict = (NSDictionary *)responseObject;
         NSArray *storeArr = [errordict[@"JOBS_APP"] mutableCopy];
         for (int i=0; i<storeArr.count; i++)
         {
             NSDictionary *storeDict = [storeArr objectAtIndex:i];
             [AboutArray addObject:storeDict];
         }
         NSString *str = [[AboutArray valueForKey:@"app_logo"] componentsJoinedByString:@","];
         NSString *path = [NSString stringWithFormat:@"%@/images/%@",[CommonUtils getBaseURL],str];
         NSString *encodedString = [path stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLFragmentAllowedCharacterSet]];
         NSURL *ImageUrl = [NSURL URLWithString:encodedString];
         UIImage *imagea = [UIImage imageNamed:@"aboutlogo"];
         [imgLogo sd_setImageWithURL:ImageUrl placeholderImage:imagea];
         lblappnameDelte.text = [[AboutArray valueForKey:@"app_name"] componentsJoinedByString:@","];
         lblversion.text = [[AboutArray valueForKey:@"app_version"] componentsJoinedByString:@","];
         lblcompany.text = [[AboutArray valueForKey:@"app_author"] componentsJoinedByString:@","];
         lblemail.text = [[AboutArray valueForKey:@"app_email"] componentsJoinedByString:@","];
         lblwebsite.text = [[AboutArray valueForKey:@"app_website"] componentsJoinedByString:@","];
         lblcontact.text = [[AboutArray valueForKey:@"app_contact"] componentsJoinedByString:@","];
         NSString *htmlingradients1 = [[AboutArray valueForKey:@"app_description"] componentsJoinedByString:@","];
         NSAttributedString *attributedString1 = [[NSAttributedString alloc] initWithData:[htmlingradients1 dataUsingEncoding:NSUnicodeStringEncoding] options:@{ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType } documentAttributes:nil error:nil];
         NSMutableAttributedString *newString1 = [[NSMutableAttributedString alloc] initWithAttributedString:attributedString1];
         NSRange range1 = (NSRange){0,[newString1 length]};
         [newString1 enumerateAttribute:NSFontAttributeName inRange:range1 options:NSAttributedStringEnumerationLongestEffectiveRangeNotRequired usingBlock:^(id value, NSRange range, BOOL *stop) {
             [newString1 addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"Helvetica neue" size:15.0f] range:range];
             [newString1 addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHexString:@"#9C9B99"] range:range];
         }];
         [txtView setScrollEnabled:NO];
         txtView.attributedText = newString1;
         [txtView setScrollEnabled:YES];
         [txtView setUserInteractionEnabled:NO];
         CGRect frame1 = txtView.frame;
         frame1.size.height = txtView.contentSize.height;
         txtView.frame = frame1;
         CGFloat hieght = txtView.frame.size.height;
         if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
             txtView.frame = CGRectMake(5,35,self.myView3.frame.size.width-10,hieght-30);
         } else {
             txtView.frame = CGRectMake(5,35,self.myView3.frame.size.width-10,hieght-30);
         }
         myView3.frame = CGRectMake(10, 390, self.view.frame.size.width-20, hieght+10);
         self.scrollView.contentSize = CGSizeMake(self.scrollView.frame.size.width,410+hieght);
         [self stopSpinner];
     } failure:^(NSURLSessionTask *operation, NSError *error) {
         [KSToastView ks_showToast:[CommonUtils ServerErrorMsg] duration:5.0f];
         [self stopSpinner];
     }];
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
