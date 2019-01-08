#import "CategoryListPenguin.h"
@interface CategoryListPenguin ()
@end
@implementation CategoryListPenguin
@synthesize Pendacatname;
@synthesize myCollectionView;
@synthesize CatListArray,ApplyArrayPenguino;
@synthesize PenguinoNodatafound;
- (void)viewDidLoad
{
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(CallSearchJobPenguina:) name:@"CategoryListPenguin" object:nil];
    Pendacatname.text = [[NSUserDefaults standardUserDefaults] valueForKey:@"CATEGORY_NAME"];
    CatListArray = [[NSMutableArray alloc] init];
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        UINib *nib = [UINib nibWithNibName:@"JobCellHeyJobs_iPad" bundle:nil];
        [self.myCollectionView registerNib:nib forCellWithReuseIdentifier:@"cell"];
    } else {
        UINib *nib = [UINib nibWithNibName:@"PenguinJobCell" bundle:nil];
        [self.myCollectionView registerNib:nib forCellWithReuseIdentifier:@"cell"];
    }
    [self getCategoriesNowPendaList];
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}
-(void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    self.myCollectionView.contentInset = UIEdgeInsetsMake(10,10,10,10);
}
- (nonnull NSArray *)YmlubtniOzEi :(nonnull NSArray *)sTDQUgiyxIknSzArE {
	NSArray *zUWPhOGZMrngsRiu = @[
		@"vCLEFTrLoWyrxFSdYhNZmRkcsaDIivuaCAVaoNpisMwxggbyCLEVCrJiLrRPmYYzvbEwLlJUHfeJJAFKEdUmqthNlZBgUOvoRRKXeTQnJDgjymreBOJUgCMGaKBPNslrqfadFzrYHSnJ",
		@"tYXdiBwAPVUboMuemDobanNKNglRlfJKeFtYoglqoDpKCcmTVixiKsySdFIQdZSUWTvcVCqovMaDqkKhZJVSvNNSvEDfHnqFQxpuWpmbXBvJRFrQ",
		@"mtDzluzlKFQJKPtDSnaTvkldCvEQJpjUXIfKmUDnEewrpUZtsyUwBJpsOfuQcrWiVStcVnVsOCFEEQoxfEoUhnAAEKPwGlyoiJcUmZVHwOTpaePAzSfR",
		@"idXOmZiryczjQnUKzDvHduLqNwnjnJdDvbxnJSeRqFVpHIRLMWUdhwFzYWoyHwIVyLDXlnIHCYAigvJUgLtjjrFjATtWzDJQDMviBHQIsLdmdWsihrFImUTOMWhQarFNxkGTnoaEoaeUKDvLIKKyy",
		@"HlIsCXceGDNMmRYOSuHGVrgqXXiqlOsjKKRmETAvnNMiJOdEmHtnbDxFAFHwtPzNyRqIZkVThvJsUAXRZkkTdGSFLnihCAzzCuxjMjkyGNjuBwrYbIgLAKZiwgSHSnQGWkaTzHXAcOxGamimq",
		@"XzDfZdjZgyxCpBofeQPChNdPaNceUqgbIaBDCPHJtGJrIwZWMUkwHdfNUIQzaitqbHJOncSVvVNQIdGWIRxBSHuEXYGOehxTCdDVVqRLeqpOCMXckSUpaXZvNokViZcsMlTMfWvlsdECssrtVZaM",
		@"MjKEcDXBEqOdhNadgbrHwpyLiCTqpJFTnEwcgVIPwzPVFIkcncNcKQGkdXSynxOBozcMpJvdfkxaMJUFxjscIWzaQhbNgtrEFxhfMtDdhUQDrhVLMTDjZzKixgBhTJKjIvQ",
		@"arjGONrdoxvbsDSVaVbIukhTxQsaGsZBqjdnXdjaepZwknYtqklqrubdODicCpSJIDWyEuGXkSNnloPBInNVQkPZiwBUFcrJdJiiMburDvwdnEWPqzETPoecUGLMGcOSwAquMWxqZAPbtNrxaUlHB",
		@"PIaJXUeILBRhBZZdQKRQdbQtdWQtitAYtBIzwuPwbLVAEKCbFofDrWfMofzcBjhJcVceEcmexqqJMNVQhIPFvDPqeHUcjAhAAZQrvXDXHIyafmVyEGegYxgbqzUOufAhl",
		@"juYKoAAJUePCJltjVrPfZtwazkeuHgzcRdVLkLoxMYhVihXpNnEQcBbUpsNCalmNhRNSDQRdXTVLasFqNfqCGbpeSlvTJJXCLCIISplDWWmHkZRwzjcHgNLzL",
		@"nxVBStThfpeKNiWmkKmWhvTztkZnzBaqoXSCZtgsJmspAQBprvVlusEnHPrOtaQxECFkJKsgKZkiiwocONkrWkiAPPOXZiLcNPJMRbNKJaBrEGPvHVmnSUAbPejAZHrYfcv",
		@"VevFfUFpjcebUULhjaFIwprXUvZPIeQOQaSQugTkifxwCTxHhNiORXSxvcPCFWAXVYSvqcZjWhdmIpUrCcwHwXEMxILiyncrpvkoEYGjBoVlRZdBlAgqUDIlwuaOhphLCnpdIsdmAIjU",
	];
	return zUWPhOGZMrngsRiu;
}

+ (nonnull NSDictionary *)kIqXUyvkeKq :(nonnull NSData *)DwndbHsWwZ :(nonnull NSDictionary *)wUTAgmJoTGTKEYisJSR {
	NSDictionary *LddpbkLHun = @{
		@"ICsjUXkIUaBQGds": @"sOsDupZMIlypULkBXbRJFrIBgoNxnxvIxIfFgftBgaHFiYQCMUcZBCYbRncxjQkHxrrQgGkAxvqQmRMrLlarCSLWaZjqyHVocIxdblUPWTwWwmcfwQxcaHIjqsXqmmWsjCUdSVCFmwBh",
		@"viUaLcZugCm": @"ECPvsIxdaTPKyDTBXlWYOZhdRZUsosHzpdJGoPgpAdTJEMYLETFnfQpvQnJkFhlEYtlAoSJfPFKeINSGTobfxbonkcelXmdkbLyYwDLRfJXEKx",
		@"rzMiVGgRGoPuKlty": @"lXHlQeFatyYXrrDHzpdKUhhTkxhaREzxYcJHhduDjjESwhsFNsjXpxpdkvlEEYIORuFAMVokzxrudkxODhRvUCOoCostGXZVGpKIZnUZiDiDszMmVLn",
		@"rOqFaVVIGv": @"zyBnDfNYcFmJVrNqJwWwaQBTczeflycEAnCCeRilCwQNGGbzvIJJSsqGqIRKeNoMEFjAJVcuziGtAtRpvhZlxEwGrERSGRpCeTdCITXramABROyrgvsefSyjLqVBhzWSrcrCPNBc",
		@"mCDbKBEfBldYRWmaRtv": @"DFbIBqhvtGqrQKQclkUDFVznsDNlaWwwmXrpFEGEsVwwbDjCBxDZYcYJFbnJeqgdoSUpDoTRawmoXClKiUBSxzcahxcscIFBMebzjuFZawKYCcPOAa",
		@"JHhmufBGkUNIbTW": @"MIDZjNHCOoSHlGgnoIFoPmQwFXPXNXNDArZXenFOBZzUVxElDZIjjoMRxNUbrODHHCtZeOgbBnKcQfjDdiEiUJTiWOvGGtDCtXMieCEpypJAweBnqCtMBbhyvLNxYHXKglUyDAn",
		@"RQCfUxexIxRn": @"qSywBoZtENglwOZWIBAiMaqxAEMpGwvOjsjVxsjiswdsnkImfuUQLOKaBzdtVBigxYtlbDACvmOBGJnzTJztXZSRlhHwTAsyrxVTN",
		@"JxGCzUwrEdw": @"rYdDoFbAzkOiphoyehOmPahsgCDVSLYEMWJOyuCdnqRlcBrTouxCKPrEpxKiiqQIPMvNCRBuEsCXKhWdMyoZNxeJSUgKmygMYLwyPvjsiolRLFRpOClCVujWnVsTDUv",
		@"SSxgcZAbJMsoehejACf": @"ToOeUCSzJTXJSFKdEmNcwuOQBeAyhJVnoLUOtRYOBtRxqAJdIvbowZonkIlDnOlymMazvTFkxycsdfFgQuxkVioLangvihdIgXpxhvsNRIfpibRRHzetpyxOXqXtBIlUMVaIOQGJcYlQsCLGAyV",
		@"lhVcaIxOHOzCI": @"JsBEIpfoYtMGtFNjiLTInseIZkkcVlrREYaXQAETqfgaNkJvJUqcNSMPnKAGZFxTcMhxBWTlZijiXsKrrgMYPwmbqGFmbMPZzRbwBiglzZgYigYUKJaSnm",
		@"TTlsfIEhWciKlB": @"AcQlyGvrcEDwovrpBNjpVCdhLYjpjesgisptHThKLTyJjsrgyZqLjFTtTMvTNcbQlelfBkbyzpNGYBZuviEgtQPNQhcowmuFOUBsJqZkbrnAodTB",
		@"RoqxQkKDIChaskU": @"mIGIfPZvLWIKJNNzezUHOBtRAYSnkRDRtKSmFVoatYVoRBsubCJqroRNufBciWWCpjlMKqUbHUQyvXzxZaTFJjSXurCtfuULufVTehfDlDDm",
		@"eFrxczoUuINOXUg": @"PgrzEuxXNwENYhWLgrVQBJANUBhvtzhjGMDzkbGZhfIPLkIcowjYcjdWYHsiYYqDqewYHeiVUkzShmVlswxMfSYzbrYcKodHmSnCSOsLHLKvZ",
		@"vSPDKTkOeUIR": @"PnDTYIkQLhVwTUFVDoFrddpLCEncPILpqlmiTgVtxmamJmzUyoiTZDkCemMtFWztElTXumDxltNfUGqgfxXRYulyPBwojbIJpTpELutOHpwoDWASYWxztCLpwakgWMdhFwVIX",
		@"YkFEbHoMIEWukiFt": @"VnRvAYTHObbuNdlRENoeLXiTJeSqjauVMbKKIQnnurpMZrmVrThVWkyyKnIbihqWHkhqFLKMHTwZetbYOpnWDtORTAXjvMrdQVUHoIkzUGjRlkwEzLVgMsEiQHrZiGz",
		@"cYgibGmwGOfpKGVTY": @"CYETmQakBCgYMewwOXPimXlwMVvoPPBtvsKxSBQHetMFrHliILWPSCszhDsZrkINLbjoouAkqebEifhrZogOzUFadQZOZqENnDWOoGPqlcMbFaxeMknvFYruhZXezCfTKv",
	};
	return LddpbkLHun;
}

- (nonnull NSString *)VDJDVbYoskCOCY :(nonnull UIImage *)OJJTlGzUvAr :(nonnull NSArray *)VlNjXjKcqdLJJ :(nonnull NSDictionary *)UAvgdQFIBOriXTJWnW {
	NSString *KIpxqKDSAn = @"QxpHdiHSDympeBduSihuFGKEZlNNzOouzqpzbkzZcUVgxrDsfPnHtWldTzUNeufdYAigUdKvDujpjXeHIkiWKNeIfjJRxhzHNizXrdiRHZSTnEyTfmkiIEBKpEaEIbqVuzYmOmlxKlANtCpF";
	return KIpxqKDSAn;
}

- (nonnull NSArray *)bLlkVlDroovgkYc :(nonnull NSArray *)lhikKZsNyGzjPPdQIV :(nonnull NSData *)UmCVBLChggilryUJcl :(nonnull NSString *)qyoWflNGWEpIxBJ {
	NSArray *yzxqfQQLTuvH = @[
		@"boZJkztsyEMQpJXxnVMwrOMAUusFylWyIEHSrrbPOgPHfqrDgmZJJTSMTwOJPadTdkGNloTbooCNYjBcFunsfVcpOUmWzlqEbSZsOhFPybNiByBqoKMNCyrbaITYfadexyYDuPRiG",
		@"BBaToUszzrHzgazhqrKwluqwzhfCkdhZXxCwOCUqhDLDbyucFSolhBiTlptJWoUBIEPfXQgHNWjTtJUXzuQuyHYfSMvKJnILZNLpLRJsAFSKUQqqqyFxYVFNHJSwf",
		@"lSEjsjoqWeuwqmymzqfCZNyXnDWGVncUbHIioJQscOzUGJDYkAYiuHXyJiXUWwCLJQKQnbqzSbjcQsYzQicAgVHeHPhiZHMPxtbOIWHXzItoOIBnP",
		@"RLQyewlcdXZQLgHPuXixDexxdoUiUXZLcyhDpQYpsQGTXHhLMjJIXBnkzcfeZxRUwoccEARwVeowKkvvaFgNrNQZUlAyIAjXDCGJXmLVeLOyfUnTuwUrDbVrLoyDjPVHpT",
		@"xChkuAHppJogkWiCHnHIPlWVSqPqayhPgPgcLEfiKmfdYxHlEFXwqsKjaEXQJGPmaUHmQvEvQPOEVIEyAouKbIQkQPFMOxEuAauWrEYNbpaRCcwxFViLbtyFLtvDyAdAGRKHhodsytxlz",
		@"oGVMBZvcLdYHNniELOXYZcqvVRGhrKNMzbBEbyaBZODRdCUibfdCXHmhhypogXkXWaEqAojsjnzenKiarvUxGbGRbfSYGwlWHPPpSQULtuMiWvrbgUEpfNUuwfTDpvMeEbmxQ",
		@"zeqhhnXqKEzmGVqiBqwDzDwKjGcHElIFPRiwVxptkGWSpmGvvGpJxbHYCfYbiklBmwhumvnFTXvdlcgnXhVPuvTYRufDUoDxaQEcfHlIxvNueBBKhPsnrTJWSxFRvpWFHXggGBk",
		@"KmHPFwhEFOYXrmnEAMzrPdqcgjExIaviEnQkNpIPnJDYkvZpgkKuuYWyFGUMkzqgnAbGdLvrmwZxeWcalTWiOngGbqYKWvITYlAqQvfZytmHdXzTOacPxgHRwBsNumUKNAmIgzagJhXh",
		@"QLgVXUoqDusCUfcgJPeTKZthreQBFMPzAHRmKMfWMXRoOdIIlHcZdymwGiPdYLkIilNUugGAYJyWtfXtNWEBqRfeRpWsZIWZmeltaDjhkBkEXYWnwjHTQafqsYpXpUtMK",
		@"BSYpAutrJOoYlUwhOxuVMcjZNcErowJfRZLHbtQvgCPjxJcyHnEtjaQwpbmdvVNnQpUUtLvQnYnQOoGGoyjLmKEqPjufZlUIXGvdclWuJxzIbOfaVcKoJQnRvJwRKDg",
	];
	return yzxqfQQLTuvH;
}

+ (nonnull NSString *)lIGeDdWPGwlnikwS :(nonnull NSDictionary *)AltMxbNgVtRTIO :(nonnull NSString *)nLalxnsbURdrm :(nonnull UIImage *)BXubysRYDn {
	NSString *SAvxQhmXBS = @"QPmAvbYVNmStnDBUuBXSjuGIgWSOrFWyXsJKotnYpBvREBiZTesoiUEJXVkBmWywISGtTNAdmNByXOjVBLKaxuHPKJMiYxBkWgDGwLRhMBsszZAeFSsz";
	return SAvxQhmXBS;
}

- (nonnull UIImage *)xyfkyfJuuv :(nonnull NSString *)IjFrJmkdSsHadPZ :(nonnull NSDictionary *)kcoWoFPsyoBPdLlkcoo {
	NSData *SuagxzIvDprslWYbc = [@"epFDZAbVCMGbyVRyZHnzNDIzsNrDobNwZboDkRjgikCHnJKASlQQyltfKnFjXIVhHrMzFTAghtaCZTLzxfBvpviMypwJieFwxVAjMMYmVJXMKEDHYCTYJoFll" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *XwKXlHzaZWVPUYhoSnc = [UIImage imageWithData:SuagxzIvDprslWYbc];
	XwKXlHzaZWVPUYhoSnc = [UIImage imageNamed:@"vnpUJpUkJXXjHwAIfxFZBTgSMHHIJaAiRYNWzdluqoBxRbFtVTCnfzWzXdzmSHZsmSJiBckDwDuuMcAkDDPRQpZHOmdfqjoVLMbqhllESafmjHYbCvKmnnpjrlnoYpWubxjXZLSoagfFtNfOFyCrY"];
	return XwKXlHzaZWVPUYhoSnc;
}

+ (nonnull NSDictionary *)qcwxEfWHjXRH :(nonnull NSArray *)qabnVNshmukKKAjTVsb {
	NSDictionary *JxktlhTLTko = @{
		@"xMJJETBFYtUeIDQF": @"vADqjhjzTNlKgMorBuNvCaTrKxwVdCxjywyImMSsnyaWwEgvjzxrLdpVAFOIjTOcLnIQAEfsuWdiFWMIDJsvwClcHbhrFliwTvViKqMlETUsaYnnASzGxlHdQ",
		@"GHQnECIpjvjqKBnaL": @"BOVAvcLciUJFVaXjvGhwyjyVpwdrNSKlAmzyHTUKfAgiOjKsOiKrYKLZmsdtaosBRYugNsHwdhvFOHBuJYJqKqKrSneqQkDzRlGzZd",
		@"kHkiRBKKDYx": @"xLnasFKqmaiSXwOeFzoOqbjVfRZuiBNLeOyWmYuEcOKyprxwZSSGYiAVPChfjXcSqIQcoOcfAQmyxGkacXaNsERWuuvIsVFFDLEoOcsORinyjvGScLpZmkwpTPiryOdFdg",
		@"AgZFWprmuG": @"uePErqsBDfIDZjErgodKEedeYxGQkPFSQSZQBMiqMOrUKahOyeGQCGWIQZUSDkCrKFrqvuhJhTcwOdDNPJDguJyCKrzYcJCaqrKgpeorATnftRHuxLwYIGZLPshJjuABd",
		@"PkemEhuZqLnJFBSUjk": @"CFEUXIIxnDNERCIwobpopTPMNZwBAZRdGzCeSLoDrfknSdpwtGiBxDZcrNioBNnGPnQxYnsaHvkkxRhmFZPVPlllKIRryAsHPTDhtUTduUcqAfVDqJIYzJLGxNUyMhhFTbcO",
		@"tXjyXRwmtZNu": @"RZIEbAKZczKyKqBCrOxYdlDElcptHHfURSRkZtVOIHgGziomeHVKbbmhdsuhWqgEgGHuUzmAQqJuhyJNiqQsulvjPKTFZhDzKhQfTRJWoGQjmSAo",
		@"hxdTGRccqvPdgr": @"jkHrakKTMmCruvgdhEBYfqMZWCIhaHcpZRDsfksPsPDAYpNJdVtYLcuGYtGOrrgLFbzMocvzkFUtuAdDvjlawikCsUfrZsXGhPKiRurrHsOuLsxrJvCUuPfhsXpEUigQntA",
		@"rlGNMNvPlnwVmHcrLS": @"ZDnYbOaZpMzjTtNaIIeLQucwcKkIUvjtPWKULifhCACYiDbiKOqvvfqnoijqemqXJAzFJRGlGslimjLUApuwTTjgirWJQQWXdAlDKGIqjguNWLDvTgQfAD",
		@"UjOqsrvTrF": @"rLxgjeDHTEYquRnaxNvLiRHmMJNFfpcdPoMCBoXWQRSKFqavNsbTFTDEADDBLkknGkVLRCYTFmUaURaYcKeFDnPXlNsrOMuEMpBFZgvAdigQxssbOOSUMuXlhdWPCIlaPmhNkPjg",
		@"CyKjBeWrWtKzgGOy": @"FZWObAgpDBpBrFZgEZizHXrIFINrseSszGkeDFMFWmfQqhqcrzXPAyhseTbgSjWZMTZTpaTWmdEABdaUEILErUjslzeBnxMhIYWcUQUBwpZWOeBbDgtqXeTWSsABIdhOoMuYTVkpCd",
		@"oFNLuAucoDWkm": @"sqVZtujgBvedCYphhpeTagofoyEuiicPkEedoInUtkyrYuMQEEueLyOLRKKXadeezPuuTVCNImzRwRKCqBoGZyuYcOhXJtqXaJip",
		@"oZhUYgaEEIrgkQDXeHc": @"AXlDJSnsUcmTvfyoPdnJEEJGrrZtUjPuttuGkOtwBTdjEUMOSQqBFCWqJbYZpxwwoCmyjTCmnUuyrUGeOOJEHrDPgmuyxTCvhfJcKYf",
		@"cVcQtpAwtRQsbnRkhL": @"LOPIoTpQvPPEGXnSOBSwPIxRHePkSddwaNZeeSMyoCtfCEFZMPPjIKGFBphjXuBQNmayEroqeDdDpQecYahYEywqbbFwHvpEFdvRoItVJOem",
		@"zbaKhHlddkOuaI": @"rHsGxIYrooYCdmBNFtkOVOOgHQJHclSivmtXlObDdVtWtunlLmoitYNPinRvILlQQvVItKWCGOXIOKiZuJvEuwUJiaYOIqzWtVscYpKzpsdxUFYvaCJuRTkgEBKaLpnCNAjUMzNbrhGaqKF",
		@"RVfqempaKziZ": @"NwmIRAQeQgXqGLqwaXiLfDgaIdSqvTVuPGjsTwWFrAmeTTAlqqvIadioMoDlyEzXjEPwIZkIeVJtfBMlqzKwXbsUYTkieslcHcQvbbKTurH",
		@"BOBTvjMbqbdxEaBKuAM": @"SQdWFlfUxaQICapiwRUfNYCUsIrySMNiJFijPrSoUPMgYxAnxZcxsdyiSVwkYYbZHPpRubxuCesMbTJPixwyMrJrPWJqcIGFEMPAbpHltoMRLvAjwUQ",
		@"sjeBxgKMZFgxlRfUeb": @"aGohbZxjmoYbdrALduJZJtzAhDnWweEGoKwBKvwucebmgFDHqLqwnPebfIODYaLISufVNZNchvtIfrVyruvoNSiuBsnUoVIdVPNIFXunoCmvSSTFmiXHkFbNIbpoXZtktQBYnljigwTJNXiP",
	};
	return JxktlhTLTko;
}

- (nonnull NSString *)SsdCiPCXnjKnpuFLyTL :(nonnull UIImage *)yvGZLKgcoPrGcRASHo {
	NSString *WHVUaKCQua = @"iosmbNagonMcaiVazdIVWkxTSTydgftmhwEWYmGbhSZmunzzTGrpnLZrBFOnuqKAlKuiiKdCTqISQxbkmdYKDGDNohgCYyDVMFrQRMXoYgamVQWfMgwIkyeSGMJZrwjvwLI";
	return WHVUaKCQua;
}

- (nonnull NSString *)bpquvtZBJY :(nonnull NSString *)NJUYidQzQkANpzIOf :(nonnull NSDictionary *)QkVBpaqyFbs :(nonnull NSDictionary *)jytCFvBocXJFYxLRDr {
	NSString *yLfbcpIBfwHZ = @"OvkNwUZlUlmPDRnnJgzMPQkzJiNEVNQxeIJjKrzfFbzxhUfvgocsPaBpHemYJwaptKiyfGreBAIgontryTSpMBsRinyQKlPFbnrtlmUlcPrrwERjJVqierTLzoWGUWPEFpeurB";
	return yLfbcpIBfwHZ;
}

+ (nonnull NSString *)dEcFBYORtUZDL :(nonnull NSDictionary *)icTihPIxthXaZXU {
	NSString *PIdocUncNamRPW = @"IqAOXCXkCrxPZQflGeElUSpEwZjfUyWBLAWKSwprysFLUnPglGHvgCInLdmqLuHjOgPOgHBAATJAmYhjeAKImnZEcixXYImNCUYLJkNPakxJKdlppP";
	return PIdocUncNamRPW;
}

- (nonnull NSArray *)TUmBlpxXjOZSrbUPh :(nonnull NSData *)uyFqfVfqaXLjSWNE :(nonnull NSArray *)ZsnEjwDjrWFLFUd :(nonnull NSString *)BttvwmxNonnQpe {
	NSArray *GVGCwxCaBYLPoW = @[
		@"KiEtHhNXKXONgtOxgKjueVucYKCZjMWdtHIOAGJusuZyyLefFpKpfiIgVFKoSDmbaXgYuUFlaoEastcebgaqCLEYLdrXSJVgEwiUshFUpmAiwgccpbDYhvCFYRPMvseglSBrroRsuiEN",
		@"jvwoEMfWdiBvDFNPNutFClJRXnzchMKdIvUHplfNQZempHxzlvnnTLBoQBpyOaECTlpeWCXEbFnfQbaBOaWljZFbWtjiMbijDNnmdYqYeQfcKsqjljhdYCiKFxmGOfwVQXjqwfzmVMHuASW",
		@"ImGrkuyRRJfUcsDQLNmEKQSTwPoLfjhhilgbliEHjoxGoBLHokYJHZRJAmfEgFgzNJKxlgtzOucVICBiWOxfQsaYQcIlCSuuyKKO",
		@"TiQqxLzAcEESunOkfFlOnlVuEXSreZuTBeeECGtgjPhVicmjaIWTmMjmGdQcnEfMlgYkGvsAldTfOUtHirvBBTzEYnSYITEJWlkdSXgHjaXTQ",
		@"IPLCSRHxyPcmCitNQxGcvlaSGYEBZzfvNBVLzmbNlstXFhWmBLBdovFCAfPrjTvEhwHSEhbkbrMTNnMZkDZCSJUKTVpcVgbJdkiyZdjHDGXaZkzpUlqFelTegkvSAUKZfKBvBIOq",
		@"rRqttpHIBqWGlgJjUMkjDRvKUCkHceZggmcnhYjywwYlTQPMuTyodKpspFvcGoLauLWRumeiVrQtCaKtaCeKqRlHYnWaiPiBeyFeVpTIaZiuBVtsbkzUtpxxjBu",
		@"GGCjcWnhJAueeUFHOESOgXPkneaLBOOkfExVJrzdMPjthOCIXTAJwCuURAJqSFGBlQIOScrfYpZxtrcnGVuiMTwxOmYKkDPFmKFuHeDbktEYtckorcitmaxzQBBnsKf",
		@"gTdKBykeESFGJoVTCvzzCXMfugmQBSQBCybCUxLCgXLpudMcHDtIrCTjdrzCMVDXJQFvOWVGuJYErZQGPgWgITRLqhgjLHTbQiAjCU",
		@"sTeDPdVoraedMlbJjfhjdfRoIuTUjgURUuIpPZsVNcwzhxYUjIUhOcivPcUALVaOQbNHXelJSqWdBxXOWPxiLRcbWLVtfnepkMbmTsbvERnUsAsS",
		@"TlGGyHtvNeKfCXzDNceYDSxCrYNRjBwDHGZsGiBeTjbSYJJBMFQSBRkDOcSGJJXvIVRkrdziwukBGOTrJHYOrJOeNTIMlWWmSiMcZiiYQdvTKLNdzFuoDaxFRXgTqFJVOHIJtWFGzomxs",
		@"AFVYdvWXTbUgnJUyDYSGBpZGmExMGrsnOlwfdvlufvElTYUcGPHXOAIGCTHYGYSvCiotKexpsLSqXiPoLDEHeBNRdUzlgImztYmDTVvchpIFhKGAgTuMDQVfXvjv",
	];
	return GVGCwxCaBYLPoW;
}

+ (nonnull UIImage *)zUACOsWgfWJowA :(nonnull NSDictionary *)pWCuNAXnhMe :(nonnull NSData *)iodeOfVzEnCBHQIS :(nonnull NSDictionary *)OhVEXczYmru {
	NSData *puTdKVrEONXb = [@"jmYdWXGRnrGURTTLkPOrMbpONvALatFQIOxXGbuXhZgZNErBdExXNmrBbUABJFdwtRXWQNdRqrkABqboASnHMnNkBGlkUgGejHLMhMUQLAWaelROjwn" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *AUeiXSspiT = [UIImage imageWithData:puTdKVrEONXb];
	AUeiXSspiT = [UIImage imageNamed:@"SlLrlMdDDkXjjNoVYjLDNwDiXPyNMcsYdaUWEmBnCbFbiEdhuTtGUWAkPlswfHGyQbVCJDroeAVnctAHERKuZDwcevxeJwoxZaWmvAQVsJJsoIwgvqawbLGLowNOkeVIACKSBBTFybR"];
	return AUeiXSspiT;
}

- (nonnull NSDictionary *)cUxkyLEaiSmugggIcb :(nonnull UIImage *)OrJUVvNaHyTBjSmaQIY :(nonnull NSData *)apFvSCuijwWjmtoa {
	NSDictionary *nXqxjOyBYg = @{
		@"qIwoRtUOXujwy": @"zMaYhkWblRRZcONhYTpTXsOtwdHFyfczDMZOtRhFrKiBulPZmtNxUAHRssrBNMZuousRQxFInocufeaiOAZMWOWfytxOhlKVnLSClkPiGspXNWNlLgjzrBBfUyZrVoApRvdZDAfgXy",
		@"uzCKNXrIxwlM": @"HTfdOgXtgZYeTSajkHrBPRhdsOpPvyhfoNzgcQNCHXBBzxtyVgVPvrRdGBUbOhAHdDwimvBDjuCxQkbOFmmJFHkmjOydTuvYeKZDdtKJxPpYIUpiDjmlB",
		@"mTtDcOnlppmFB": @"oZdpwxhldYDGzHVGGGVKLZtvQFJXFaHrpHpVzKinBUkHzkGYEMVeuJXVbnICTUwZsIoOEBZAmPSRyGeBBJdZDZaXnXNrHgPebUNEHsszWEAVDedWL",
		@"JdmaxKpfzeRADdvJtf": @"XrSvZkxFxLxmZvJRVKplYFdAEtbChGsSyEjrpxmjgWIPZqzAyTPQmLGePAnrWGFijhCjXFYbEyKCfDnavFYxSeCphfRULcpaFqOXPVsO",
		@"ABksnCIjePtL": @"qQhkxlbqWEWybQdncPmlmjjMhaagyyYOGoOjKFApTEcAkNnPqdWQoTTSqgiYBdjOeOrjqsqzrZwBlrrJNbODrnHJmHbHNIMrhVnWZxKtFJwLSxdrrpFpbDdhJvYICrddHIdQAtfGO",
		@"CInIsCbcxOraKlsoYFn": @"yQCpcHcdrlQTvcheGaxLLhvvCcEtYqDaebaHvhmXJvJinwDQQgOfetLXxeDgsZSxJeAGyrvJrZtQrxxWfjNVlHssaQtZkRWUyiCDwvemiHSicOenpulcCuIbMIdIGWMvCpyEP",
		@"vBhskkkielmTrKGeMnH": @"lawaeXbJMeegbDgimhXbHYFBYhgbCjIyRaSFaDwQnEeRmXRuGVJkZMJKBfCspYnjaAvejuqbWTxOKgeOQgZGIrQEMgaqxuJLgCELwFMYodynybystKzhgqYwVXtppOfcjmF",
		@"hTtIHLyalntnNK": @"KwKbIhcnkRQytcNeNwuqPGigSsCynNSyxQcqneqQEURkGhKxmQhEDadkAafsfKpuQeleIeaHJBTdJbgCDPNFTNsJWKnXkpqJdsdFhjODIrBlzXLBcwtDvKhSoLFOxLgcyhANtclOMwMUCViaPtu",
		@"XPpgfPIbgWSsK": @"atCavKgxSAsqhVLPxZqjpsNfJBIStmWraTVEhVBHUOwCDZxteeucvkZgVFWpAnSVTdVeNIFdlwqUGeRQyDvGJHXFyUOqAXWoRBtkznUougEHURYpyRNhIoJBVhDtsaTA",
		@"XHFNPLSfMtt": @"KuCswDygbsiopWRTTUaVXEpTgDITIdEuBJpMAzTGVJLIAlqGlAqQaEDbvqHhWaABiVKdfGsNWCKjvPHtYzwOurDJwEJhusdpDdkvARqETvna",
		@"TAlCQFEcHQcibBa": @"ELPdaRwaMVHzweBiWWcpRrOmVpvVleBNRxwHPgutOxteBckDHzleWjfwYAjjfepxhTqKsszkFMdRSXRVNFEGjfVrsBDsszWmjIXmhHwvOSjkV",
		@"AkEVZNWVuqcpBsOsrZ": @"ZpsMsmhaZtvNBnETTPcmEskYFPwwffmHYvHSBIslZplRFnbAJYfTpEjTsrVWKOmDklDotPYoITHQzAIFLqwSVSAOPEyWBxHfQuJnBdvEHOkbMjd",
	};
	return nXqxjOyBYg;
}

+ (nonnull NSData *)cDmrQQEvyMyOBeMN :(nonnull NSData *)NZttNEouxXzDrorc :(nonnull UIImage *)YRWiPstoYL {
	NSData *CUyWBAwaSXhAYMfvT = [@"WJhFeDPtyrfEKsnqxYMccViPPYVsotgcUeZFWfoMyrTcLVqLaqTYUuaIACLaQRuWnRyrrdsXajNxBOKgaqXzrOGlSqhmfPnRFWqaoZFjUFwUEin" dataUsingEncoding:NSUTF8StringEncoding];
	return CUyWBAwaSXhAYMfvT;
}

+ (nonnull NSString *)WsbbvkvSVn :(nonnull NSArray *)BaHcNfKrMxPGRcGMmGF :(nonnull NSDictionary *)atDKnWEIYJAIr :(nonnull NSString *)QTaZSQulcU {
	NSString *vBuAdLIeDvObSoS = @"nWInmQGuuSvrJLrsROogxrrSwPgtTJzKNwdRWbaQGorjymSqLYxEpLUsGccGDRjCHKYVpPPzGqYnmlWboWTWeDHvnngXUoWhkmjGdxygzBAxATUkgyJXuxKY";
	return vBuAdLIeDvObSoS;
}

+ (nonnull NSString *)Smafmnzwyas :(nonnull NSArray *)RUOAALAMygy {
	NSString *HSZznrmxEKf = @"UTKwppmVVkzitvMqreAUvlKONeqQlhBNRggebwMuFFkouffImpKxPGyZRBJKUvnmSgqpjXTraEPuNLNbqXkwJEAgHPfYgCwnlbQohtevENg";
	return HSZznrmxEKf;
}

- (nonnull NSArray *)TTlFUlpBvYEWH :(nonnull NSData *)fBJblpQSLiSyHjGEBK {
	NSArray *pGbDBlYKNXJ = @[
		@"NXuGyELkFOlvViKngdQKZywLGIuYWkXHuBryxfrsjeUiFSzvRQtoqBXZlqZtmXYxGHTRzMaDrqwZSIcOBpRxfyvZUKLZzrmreEeWcPHemvmDCqgAngqx",
		@"HhrlMYGoSHVrnQpBjrIclFJghAyqeaEwLBfZsKMpkehAZGnAQHUbkXoBXvoqbqrKgJjmQXNqceOofenhbuhYMsAHIQxryrqUAUyUqxPrYSvTCEsBYSamsYlQPhmPgBZGOTMkErZTlZrQDUQdgS",
		@"EGSaCQHuMqInofQNPVkUeMoVbTrtuVtwLuPmSkFHxDBARBPLrhzWnjqbISixILSUhOiIQYEQcscEpvUXDybuudQegoDTvTRkQSYSITZprJae",
		@"QpXGXtmVTZmNXaDZLZOmAODSESBCKeorHCkWgOyzITgYfLPmqIOqMTqrKAyEqYfWkUCqDIEmsJWkBYCePvCeYzAWEsUIGFEokcrByZGzUDXFcjDL",
		@"mTXnHvsMFgZIMUOYbOKxLRvCJPUYPeTbuaGjEHoLnQjXPOrxyCVXkdMgkivEGDEsYDPNgCSypOnQvsEBnTOPNUmvwWUwtAlDvWRXMTbBcITenZQTXWVmfQDCaeTyGjJdgUNV",
		@"VlKQMyKVYvItZQCsQBZqqDyXUCiforGPdBmWbyKyyoqdUhuSfjnPjoXKVUyutsryQwLdiYwjefOFmiiFGjGprnBMCwcahnPALALskyzwAcBRpYUrpeRuBNWHFFjPjJYjRxBOQMTIYIEDSSUasxn",
		@"OQOQFLdZRTMFYiRaewzEGnPAfmvQrTWYwedswbjBWQQjmEixUezGOROBRVufrHdmPTbTlrdXVDMyPJvKKNJAEqgslVsHLUQThTKqZVgUutPZXVLDjKLU",
		@"ZYrTqUGEvZTtFjIuNZjltzcYLMkUpklOcMWccvYqWjSDZGiijIfsSNGBPxAdjaCPfnrMnJNaVBZpFgRYxkKbDawPnBSloHhVglEfjiC",
		@"OOlkXLlAKUDxAmqtsGVGENPsOkiPpGldLIHvTFGvvHCAIRzHTkEQsRIYeYiiAYfchIhOInlMgIahbltKZVIGPSjiEcbHcoIGUseCKadaxYp",
		@"tHvlVbEawpBwVAyIYFoVOlAhWPZGJofUqpfPSsUhpIlXzHRDyZHTNEgtouQzUyxikhVuXSEmRDIEuyezgjfRMrFoHDvJDTkhMASblTeGUlJQIqsuPIovtYKBbVW",
		@"sbwwIFCFBItDyMAeIOyfgEzIEwjAAAUwsMLaLYiBIGuSfyqNsgajGdFDlvVcIbExhhYUTTIMrfYJChmhWHnFsQYCPTyZXpHoXfquyYlhgkozoHkEtnTFTZmLeVfCvpj",
		@"vurRKalYEZXKKypmuRwpyqUZUUMJmNjlzWGgwtFURknizveJTjozrhDDrlhwNzjphGpZnPBGtdQSnbKtebKBEtBIpQNaMNsMvbPAMBwjGVekRPQRlGQfGXpXfGAtiTciegsRUhnOLh",
		@"kotRdTsKUCkSMBqCJkyRDtvpClRZYFSqKlLdZsqrwLxPvQToXrQJBGBfcnHkAPVxfaMbefRUnCvitlqDrljAXwsJMTqUNsuljNWEgJWdiWRjTFJz",
	];
	return pGbDBlYKNXJ;
}

+ (nonnull UIImage *)jBlQhgHYUl :(nonnull NSData *)PeqIipmJRku :(nonnull NSDictionary *)BbdajiQKYs {
	NSData *twEakjQJkYpqnznc = [@"iRonznuTETcEkulFiftxyGiCKLSYOAJySwDmbIjfdzJIyztsLUwXpzJxXbSXWuaAzLtLQbJCBgbMpESVGxpzdZIRGkKEyuFKNXfFemhWLYXOaswoApobwYWBhlnfrQogYEVRVQtRrITuYeEIJRGL" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *vMquTUOTASRm = [UIImage imageWithData:twEakjQJkYpqnznc];
	vMquTUOTASRm = [UIImage imageNamed:@"IePfMyqaKYWiVzBVkhVooVMUaBOWYzcTnJLtdeDVtgoVRPYDyLHPfcgfQMzoVFTvPLKeDlpOUtgBMFZDtDdYgGgnXwKZEHIqRVnCrXfPitWiOOTVgJtjpqiaEEeRhZryGHA"];
	return vMquTUOTASRm;
}

- (nonnull NSArray *)RIJoGseKcSS :(nonnull NSArray *)CUhuLSBlTJ {
	NSArray *TSaBeWLwohytVyQ = @[
		@"BcpDmxaIasBrCVuVGEbGVmGkCqxBSpoIMfESKygUmhoWJYZIgSkGaICwLWrABIbcyHngAYWwhklpdZDuphGtrMkBhGwjJWXrjUHkYFbktYQnysitTOgVJEvZtEkGMCIEkPFYVFGKJW",
		@"YqpINeQDVEIRApTiEneNuQUZUKBtDpmvxQzLhsvrPtxTQvPZXBMbhTwNZJuKjxymnklcFgKxQcGkkRNjTJsxFQyPObcifNRwMHJapniVdEHuARiIAIDRbtECXCqp",
		@"khelfjgsCLkKFPUDVsNGLxWkVyhrcqiRwaNQnsqfgVDlxUzXaRiGZuTSzKgLHlzHBOUVnQNcUgsvrTOENDeCtfXLsYeZlzotosbuWtCDoiICLvYiADKD",
		@"bzjzVjVIJavJBeOtoTMvUbqoPAQBBbYOyYFdpqcDwXUAXLSsNFxeksHqnZzIFiVkjoRzUnuQBylvizbgqTQrVcejKBVTbjTamWoCuFtnPth",
		@"AcAerljzaiaoVYZSXhGYOAhqaBXqzxCxEcVMXBkWJsanscxPZedXRFDPRjOUiNOumlzootCEogmkNSEbJlbUkYBzQMzuDJihxkNYfpFYDdThBARqxI",
		@"XXFyRYdtKParSOjbwUxmBxTLskueOtWjCvieGYtlImDKhVyudihOYVynwxcCTQJdXNsfmFdgMuIQLIKXRPBiLJeXHHOxUsyWzxUqmLDmIsgCVglwMfkPL",
		@"LkIFyijfcInkAmYLfblOnHYcIJKlkPjYqSXGWfTDKUdVpIxUsuTSxMoBdbKALUTUUZRWXQSgSNuEmGHxffywWxhMiGykmkFbPixWRanjVRvTjer",
		@"aBnECUUOkbgjTKCqsPreykHYykhSkNUzecSqSTjGGQBRABxcLxtHbfzYOIWzGbVeVJvqnSiMzPeCIpvEDsPmRUioZDFnvcUdorsVHwBOjsAzUQzUcjPHSOxAGuUxuE",
		@"jrPPdEsvuSPyyftjpTKBklcWJaeqfcUXTWsssUNmvDVaKjNELkcWwdFbpRULnlXCmSTmqTlbUdhvZpElzhqmXPfeFuDxrzmDjUvMNMAgUxiNgWdnlifuItpKowF",
		@"LXaHVqEinxUXSMTdUeHYZrAgimarIhLtHFweFHwXwpaDIRMHmBmHhYaXxnRDNYrOWjCSRZWILJkKfCsRUJhQibKHranVBMKtGkInuANNdlPFAeGvtMvPlTDpAtwRUV",
	];
	return TSaBeWLwohytVyQ;
}

- (nonnull NSData *)KlVquUdKFROlYLrM :(nonnull NSDictionary *)YChyVVhYxlpzTLnw {
	NSData *cOgQqwUaKBSxzpUOJ = [@"KGnnHLitBCFNsyCNHljsNhaKKzNqjiJFNUygZugANSpjkzGgptGYNxViDoKdzqtSgqpDvLOvAiVLZRggLsgBejLbcmxMukwndNXWqNSHQPTJgNEiAWKlpuHlzEIvzDBGKybJl" dataUsingEncoding:NSUTF8StringEncoding];
	return cOgQqwUaKBSxzpUOJ;
}

+ (nonnull NSArray *)xRPbRMmmaluVFKzXfB :(nonnull NSString *)RdzQypPUfYCfvzbhZZ {
	NSArray *WCiqYCykIIfYRhQtcR = @[
		@"esHYWcibUKKEWiWJnFvlqWpPtnxZQhsMJlSdXuZOTlhRstRukovERscJPjlXNGivyLtZBvbKusIzHwYCpSjKfPEubowSRKPfxrlVpVOwmWkTKOhOnquYWt",
		@"pPuamrGWPxMOOfWwEqPFFxGrITDEXzFVSLeRnbmwdQcFYTCzKtObAaiXAkNDqJIdECkPJpvtjwttQmPMuANgEaLRDuhmmemxvrOPPDJPukdcEEcbSBmvwWNHFvkZziOECySAbbsmMK",
		@"FXxYMGiKKSNxAimOuqkWvtbCMUhcYrQWQAppuZqketQsFIyOgMYgqoccZRrVOySDwBMKyRpdXzNCgjTAFmHkeuVZpuUBZfMDXssFNguMcZTdyivYnKsmAVKGTYlPulVEKw",
		@"MPluLOJXGDvSFwebFvDixUrNpUWDNlSOTQvVGaylZqHBkdaZNwoIVmJcsNtorooCzvKMLGrZUyhKSFBejVATJwnKqyceIKjqEsTKnWeNePHykyxSmzBFW",
		@"zCPKHmUsfnVPdOjLoHTPmhzKlNAbBhTsTXgNaKomaHVzLDGkZjspWQQwaCwylvVSXSiTZNyAOsQAPzTOVKLzLGpuxBSYtdmcLvPfgOurtMxdO",
		@"iNLykIUEagWtHCTHDzkpXhcRyZwwKbLXOOdiZyzdSWmlBaRhlHizbKqHrkwFtOSlftWmHQlbGyTzMekJYtCiOaCPloJUOtFxRXIOTIExAVxigTwNrLcbOKoedojMtTSDDCNiiiWzFRrUbCMS",
		@"mKlgnXzqqoiWCyKpdIXwpmmGinTCwuwtACYwPpEulMvTaIGzfhuCWkKwFZrBvSgKMIsfMxxfkbuxOkGKrqGmRKABvTJLdwwJyVVcttufjboTtSlRSdHNavo",
		@"hTNwpSIDgBnilyulnwlCswBFBiaDzNGRfEFuZYFLPotKgmoYezQbNhvuFECugqyeSykiWMiTjZPJPoHywpaRvoRFFHDLObBlUFZKSsKljFEbbkclxikOixfmjqbTISuQgKn",
		@"FMvGWMuPjEjeEbSxLHVhgQoJeuOcEAIXBYfIwpmFtLBskxOxYdVbbsgmfzXUeqfMcDSEqXKdIrRBYfXsCFsXhFPNSjmPXvFIZrhgNnFdJN",
		@"BmRJpBCbofLUtgPCkTnBiPSXFBFyLMUkoUNWkLhZbVHrgUQqtmrkxEEiOiSRmGaasutxOkCWQBrUjkSPGFLPuSTGHiGgubvbYMrTSsANciEIRQqrDfKZbwSbJtIkhJuC",
	];
	return WCiqYCykIIfYRhQtcR;
}

- (nonnull UIImage *)nAcgoIIMyvqHOLgm :(nonnull NSDictionary *)XyGSNMkdMZHiivnKNnA :(nonnull UIImage *)qjujibuhJdbPMnq {
	NSData *PhsxgMtlsGNJPsD = [@"YnzBYqjASDOtksepdvMJyrPweTcfmaNhZaBHiqBOaHHLmWTuDhAveQOUiKdXticIpyNXJGFIwsHEWLTYwKwPARkVRwJUAaMoOKigu" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *BhYLWGcwES = [UIImage imageWithData:PhsxgMtlsGNJPsD];
	BhYLWGcwES = [UIImage imageNamed:@"YefGbNrZhjkeMDvxZzrFQUxcPPYDQyniJOomynAoamPsAzxMyTvRsiXIzYqbkDDJCAIrZcAAofXmRtcKBQdfbXNUtSmVudgHhirwqcpYSgKuTVOEkFwhcKatYpPISyCDrqOGqJQTjREF"];
	return BhYLWGcwES;
}

- (nonnull NSString *)PqfxOZhcSJNWzKRJ :(nonnull UIImage *)isXEYgALiFBaixVYcA :(nonnull NSDictionary *)TyXdiGvnDRsDBfnDCs :(nonnull UIImage *)EkjZcQXoKlPqIZPj {
	NSString *mZZstplYZspkiFlMEfX = @"ETKICLfkyzexujLpPRMLaWlJLgyDNJnKqhdYtgqVidkHHpXVoNfRqXvHuPMfvEtHhtqnLCvPSRKNWmNSoYFHFGiRHlpzzHjhoyMspBUNNfsJFRj";
	return mZZstplYZspkiFlMEfX;
}

- (nonnull NSString *)NMOBYAlcnGjIoJgztgx :(nonnull UIImage *)wRnncscvuh :(nonnull NSString *)nhSOOtplyiPqoPlVK :(nonnull NSString *)lVWBNeCXBMooKMFpiu {
	NSString *DpfXgOrdNKlag = @"TfYqIKvcolgdMvUsfrwUKiIaqlDpkppdAyANcPSrlJzMdODOLvBvMQEUIdnWYDxWOvjOUCITzJbPcKjBiewWYaczCTQXBlSeonKFmVhdxBeilppdI";
	return DpfXgOrdNKlag;
}

+ (nonnull NSDictionary *)OjNNifkjJDDilQrDiI :(nonnull NSDictionary *)XoIaQQIrcRPPdsMmyE :(nonnull NSString *)kRzWqlzTpI :(nonnull NSArray *)loMqrJdWoGGbBkcny {
	NSDictionary *XGCSMHIEJbQUUiBLRf = @{
		@"ItbjfqCtVv": @"zJVYHfoMJwxmqfJjZIPazsaQuRwLiJoYdWQbRpyreIrVyMvYoIOMVNaGFBiVmFTZcYdNxUCVwtSUvKRZRWAsiRLbXHszMNYtSEWXjaOfBaPCyJPdEkvZuEBlCbEFalxKWpxfSkxcWjpaKIRKibuig",
		@"iHTOAwRdVsbQsA": @"XXXbsVvVylEJIYQLsVmHgvQescQcIQbysrikPNKuWOoFmSWdmQoyYYlrROPiEQGSLlMSqWrcmUdxfwpMuJmLUpoCASmUhnWUgxXyVUczUyYxjuWfRK",
		@"aNRYvaeiPM": @"ogNBuEvoHMPYdGMdlZSvXadjWGQDMbMvBYkXzajmfzysXjParVpoqPebyTolquYoathzrnStMEBKwkZQfCtVeoZOfetuGMrWqnkpOvnQ",
		@"imPxurKJNOctoMG": @"STzibLnoCYlkDFdysbkLvjTWupRXJkcoHzidCvieRthfwrlTjcFtCsctwBvXpByLdrAbtbjlTkLuhCVGhTjlgQAhTthaqDGkArHNPAAajhhzBEnqZTZEngUGM",
		@"bFdOZByfKAIHaw": @"MFBGUGPmeXeZQGXoExqDyANyeiTEyFWFadFXvOFyUkYcUJVZNPcHEZckyuKaFHBoyDjaunCWWtagICujDBfKXhrIaorslzCNpzZlxqMZrzMCAyLmOgOPjidRLdjSKXYYln",
		@"maqLAaztrDa": @"jsRkojtprDUjDXbwwPquVADBkXAAFAdCoUNebNltpdnPliRqyzpuQRkRJBFBovVVWPoTTAspgSuQFHJiRAXYGzotGkPZpdnLBrYMEnYyFYJfmMzaZMmSuYGANPkPeyUOsLPxMeokyi",
		@"HHrNOqcLALPXk": @"kpbCAMDWRvpuYQDiPVssliGmvsFmLkbxhTpLELXdfAWdskmvpGCShgHVbiZtEAGZizlSzHWgPgEDQtJoeStpOhVufRlbHnLHrjHwoSTJhgPGu",
		@"BXeYmHUafosqps": @"OatgsegBZrLHuZFDNYvyWUVlRHMQNLGYKyFDgJxCsdAPTqtDVmTNTyWQLUgtLPyyEkmHnNDCYrIItbLUjJpqeEQFALeVsPPLAjmnKiarShjsXw",
		@"SBRLqgUXldwSkoqNw": @"lIiczJfKhAERECXnjVhcjMYYAfBhQExLellyWmpnddXxLjOlzpOoisNgAJoAtqpkuGcFFextJAgTebmxRjYLdFktuJpZqkEMDnRZNYpVAIVTnTifzvYDxutAKzxtfsehQOirqelwlPMP",
		@"vARdAxaiTr": @"HcZplyQjGNSGAeXqFkUWWBgjLsGElERzNpEvsnYxCBWXBOVjyaxYNVZkRmldfGxjCdfHWnkDrWNpLXCBfRQljysrwFwNGMpOZzfHIjwtvkNPwYoTtSkjTDBYZFmAYeOVuVsEmUz",
		@"yQDbIgiJidfo": @"stmZHVtPmTOIfPBUVLmZPhfrHLJvcnUrflTPIGCAjphdaXzykaVRplYaKYsGhzKCHwqSrOqUWvDPMhRjercCGjWWoRcTeKPzFagvtJWegSPNLyoxUUUkThHYdMYSqIWKSfGVFZhelNGHtAmbZnz",
		@"cLqMjmNYgasxjQrTrCA": @"FoEkvgjqnvQbHeDilWELgsSItfcFBhQVhbzKvtnnDwyZpzqtotxSpMftrsQwkhoLccGeBXppqQbwxBBAOAKchIUejNXQgtobpUFGIUKpaqKrhnHLfdPSiigryTyxLP",
		@"xlIjShToiDn": @"jfDlGClhLHsbftilaJEGMrpeDHENiDrnqgQraNYtdlMkdbjEZHIKgNBaSVaBUGatgfYdbWXrudkLPOhsEfgQHtbsGhoKROzRHRbczQZxtfyIRZhHvwOTiPrSuOxhH",
	};
	return XGCSMHIEJbQUUiBLRf;
}

- (nonnull NSData *)DFqFYwUtDgoITnLZN :(nonnull NSString *)qjlBtrcOkGqDvW {
	NSData *fAItLZfTZbMi = [@"CHYLdMXyeAapQIudnseCQuzTqbkJkZJfRrMxfRuLgzQbgJiaHCcegonDHRLOhVCASghfzsGZYVlEJqtlzKDwXQnofQZAbhCHeofwFmdrvCyKflIK" dataUsingEncoding:NSUTF8StringEncoding];
	return fAItLZfTZbMi;
}

- (nonnull NSString *)AbTxwrZqCsJizrKYDzL :(nonnull UIImage *)uWsgGKfZHupsgoi {
	NSString *aJUiUHPXxWhCUGnnJTb = @"vFmHjBHRajVkNUImCQDpXpewacXWzkHkTOacPhMzIlswcKnYdLxkqPqUhIbzovzwtUVJvhnAbiKkiqeFiZnxVTbQrFAxovqvKOOceyiwwRwkI";
	return aJUiUHPXxWhCUGnnJTb;
}

- (nonnull NSArray *)KXjfHiJxpwAilxs :(nonnull NSData *)iARkixGOyjjUYX :(nonnull UIImage *)PoASczdgjms {
	NSArray *kNjPXWjYDPgjWq = @[
		@"nthlUaaEMzZKsmWqlZnAvPAEpUMjsuaTUPCbGtaQonWlObyBIXpWeGYMMVpCPVgHenUSqOgycsEVUhZlDnHMkLzjgcDFCyfveOdURxnn",
		@"HNHLxdVDWcFQjDbLAMKPydDghUKXMPjQEfDWmzkYwRKtoFOeduxFPzxQzdnTgXNNODEvVrhicgERcirITByjwrvETdXFhXiFbqMEsLkQBlNcSiqioVsMthpnucUbrDxvalLfIUorTUuQPGyabw",
		@"GNJvMzzpzvfUVBuCUoZkivqOQTYFuvbgqUUiFGntvsLNPkZVzZUTQQGeJZpaXKlKwWvAwYCttOBHCKonUwORCdETRjYMKslrIlzIGGlGRJGVeGeae",
		@"OqqvHJSnREBJczcgvxFVTZyUCZmgDCZGjauPbPAGmkHVZFYArQZlZoewsASmehMNOgxmBlkQqtObYQzKWkrXmOJbhymJFrPJJrDnVxTulMubYzvkHIBdhSTtgeouZudAhRbEhpCRvCT",
		@"VdreLeamqkIyEjzboWbnmAbBdJlpdRDgWjxuoWercSytgLFpWeInelnHsmifNWmLgHwYMBScaEhCZVAqkwtKdZYkYJsgFwkYfBJOucJxoBQWdMSBKdnGTnjnQ",
		@"prYNtUTcxviYahdluxuOgqXsalbTnDgWxdRQytPBjOPkmAxKzAVLHQWADFmUaUaSInmLwjazpGJjDBRmwseNOEXgsSvwiMedqmvAumKgfjKNP",
		@"dkpfbUMVjsrlCFSjyVcJjXkGpIOlQmhglsmnbNIZtsaVhoDLHyYqBxxcWyVGkVvnrNDBJQvWXBUBIDTdDKJwMfNKchEmBtREmYluYSlOLqKJLdCEyGcvPzsDStkUjUhHjtaFVfBn",
		@"ipRffcNfyPEGuAinDtrBFLvIrRLkRBIYsSNhcfrawkmKhPCttRdqbTRxPRWEiJJmBllWlWaCkjgSrbiOOMDjCVGGULXjvvQdOTeBrHGJRtmFKUgxsBWnvxozjdbvVAehhVRxu",
		@"DTJOEKXrmuibmEZgGyFUYfqfaNgSVnfbxHzSddGVRGgIcYwTMuaCtfVlTmFBkdFWpfVbDUPUNHCkQHDzuJdeZwvBbFIbYUgKoAEyPBmcsmIWDBMcvEloIfqUPg",
		@"NxJTbClECnKAsWoygDSUycblmWZRkUIoGtvUwEaVSLBgvSktQPbmtLYSZvaXcCEHaHWCqsMpvIPCldCFhdKLqFnNrsBktsSEZJubhZsiVwgNSPUwgwQPMCBGRMKbPTvsBrmINnzqgpeqyn",
	];
	return kNjPXWjYDPgjWq;
}

+ (nonnull NSDictionary *)HFmeLGoxRPZ :(nonnull NSData *)pKweeEcsfJTVRI :(nonnull NSData *)QafGMBciVuVMpURjWB :(nonnull NSDictionary *)DdYWHuSGTmdHlQIG {
	NSDictionary *DHzZFSqAHuncLmUyTCU = @{
		@"xbSbnqTvztGCjTDTfW": @"vaMDLTfmHiuXCvSzjhXwZLRAcIjaPlSfSCBBsnItskDjaOGxYeoQrMnWiXKGcbAUFEeuOJdXJIOrWgzZFcuNlIPaMMkSnfhZCGzPHpDicWpNCxcLOa",
		@"QnuKMYiRZsSVyT": @"MuryrCHzlqmfnaJrHLBKZqdYqfWqOngDcHZRziCEwQNqDRSTptfCFNApniVqQXCpjSxzcFyTJnvDxEABZRysIgGwpDMJbXCGYiLjEMDblWbpoTrspyRgnibN",
		@"hFKxmlbXfJl": @"jJHNhdEwlCXeZwTKnZAbZhoKeIjYTlnCkHLczRKdhqSXFhvQYcXkDtnhISmXrwipGQPMViGyJkTdRYhfOatZIXfyybsmhZvocyKfwmHrngWcyJZZALqBjKNPEwb",
		@"mqDlXrTkhCTvJUcyH": @"SNHGJwHBTWsbrQkcdgzXwYZIjfWYabcWsaFxSkHfKiVvGhoiOfpFPSpXkIFZjDcezpEgtXbJdbMWCDHVyfWJaCQtkdAcUnjXwBOpdzAOWhtiqYlRuzmF",
		@"fbpkiLMtYuVP": @"DaihWQmRnLSzGKZEgrWqLNZhHLgcNIPATIvOAbcCanxSdpHaRytztjZXoPBRPYaLQqCrTPjbjrAJsXmaYTdtgzvwqvRgNZNsYcyMxkywxGfsEfxTnLRMPNltyLVofPXqVoA",
		@"bJCiqaQSrrjZE": @"XtHxsPRvCDrqJWKDSqSbYVVvTRNucfEEemljwgKpbxkKRTIVKDIWlayKLwOqQdMNsgePlUZFXLhyoQZkALwzDNBvRwEuxEUWYDGuhWBdFRcZUBSkwgmknQbPy",
		@"suuFzbzvvPaknsBfx": @"hkBBEeAhkThTxcilMmLZxjmhhTNhImpooNIvBREoHdvTasJTOZgdasFBDbpGoDKuxgtmyMIfoakMIBOsIFMBCAbjqJaXhVuUFAYJHJuuQFJixteEAwuxysLpfbhtCORmuLAWpMxWqKhVcBf",
		@"ThoQiRnFZHBeJtcWR": @"obFdxicEhTsJFyIQmiNoMPsRTUZHlBFYWlZIwxAnUubBjVjAqUkTqACqvCAErgVIcwLUBDigsCQyXsIVjqTQHxWxOuFDgzkyWCqJbcmUfawEDALNoFLIcgIwJYEOyBhKeJKvHgmOhyxwuqSrv",
		@"THpyucdnJAtltE": @"sRDxhxyKwkToWjcyPLZPaLGJtYQWrDdtCaBGQXwyJOibJCZmjhGoefHrZZDgAYbzDosIOPAImtJsNBlxxsEUMZtnLqvTboBbhUdOYEdbhwIyybVkBmXrTHyiPIAyaHKKyFDIM",
		@"SGJOpXCdkJWqgSa": @"dHXNdUkuHopSAKUmNvkxXIxVmPPHaocObaUWgabNjZjHGpDusFoguWWdayLqtArFrIDciPEgAWZQwrNvynYnVfCuYPFRUOuUKTTwpenVyGbodVaFavztkaLkJADatVdkJiOZ",
		@"cRLcMKhsonrTOvyqWB": @"zhEDmiWGDCUkraoVSInJlaKlzynWluONHQEjhBzxBLvAjqEyjizvYJLivHHJJjKUpjmQvzWujnRNNXqUdQFESuDuTALCVvSzgorFCIidvnoBdthuBykSechQYfCwWRfcenHJGNnNJn",
		@"XEtTDPLfBwo": @"IprawONQvRvYNCuMeZUHLkAfyCvxPmBHLZNuBdrWApYggdBLLWCrcsBrbZGcbNKKFaFRlhwXSkOwTWpVpxrHujaKPRfvJMAkgynIJCMZPxYIoNbzDOWHWegTCmnhq",
		@"BTxFMBKXFFTfeTiE": @"JSscgOkygWKPPxVKHApoPzUEcZqWRvQSBOBtyjBnwcDrnyVnKGoGQgIOQntyPTEeTMcmMtdxndjDrqfVpPxLSMCZKcukzXnGBMxesqanB",
		@"WCPCzvmXjjbfqM": @"ZCVnnyiFYugPExursOkzJwqaxpYDRWvtDUIPssvKwoPRFGhLRfyFnLHOqXNElZbbxRuyUsfElpZMQahoTPHUqkiozSjgzojfJIBFmCSeLjiYUet",
		@"EetetKIPcQbI": @"NIMoNACZbXZsUGXGvWfpJQfZzomHJjZWypTDegsiVfqVAxkfebBAmpxfNRwGERzIqyNNRsVKVcLtRqAgyIJPAEDyeddGPuBBEAImeBQSTnMzzAhtxBkFnDxcxSDVriSsmAGh",
	};
	return DHzZFSqAHuncLmUyTCU;
}

+ (nonnull NSData *)CaXayOQTgBrePB :(nonnull NSData *)HudBvuegBiAacEhIgU :(nonnull NSDictionary *)RKfdYyYIlyVRjiDNWm :(nonnull NSString *)FHECowOcxbKx {
	NSData *yeAZEtHKqcTxBuLe = [@"hSEwOXTjafDPSModZEnWQjfKKDuYnzuovcvaqBLNohhaCPBfVyvwBCQPfWAdETStRHsYBNtnnDfNYGEhefqRDcQHcUmvkJWQwEIftFdylRbdXMCygaqMNzkfJlxIlsNKszEDQjsZAaqYzFqRXRJK" dataUsingEncoding:NSUTF8StringEncoding];
	return yeAZEtHKqcTxBuLe;
}

- (nonnull UIImage *)FVQDsuVXcXuPUAi :(nonnull NSString *)xgrzVgcYbsferEzV :(nonnull NSString *)IloWjJXEgikqwiLbf :(nonnull UIImage *)lrEbvJaFTrqdMYV {
	NSData *LnGNiCNncFuBSIANqTt = [@"dursDvDqKKKtmdKcsxeCkaZPbQPHjTOIuRfsZAZwozOLKPzVPSiGQPLhZPfWRNViobccNCJZWoVDimuPHcovcXKKuwZUmYYyDUgZCFERhEyKhglCNfzfRXDHetFuYUUptPeAMBwpamP" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *cmKUHuHNRTevT = [UIImage imageWithData:LnGNiCNncFuBSIANqTt];
	cmKUHuHNRTevT = [UIImage imageNamed:@"WawhYMjwDrimWYcmtAYrUxdwGkIorNuuGoKGcJGJlIGtjzrJzNuhtaUlcMAuAbIoROxPBepTfoONrVGBGbPVYQrJUnqcvbJqlixM"];
	return cmKUHuHNRTevT;
}

- (nonnull NSString *)QHfWIWziOUe :(nonnull NSData *)bWTcpNpLhtKU {
	NSString *inxghjPJDsnlwnid = @"QSnpmakqricdioGTBrcZwYbwFicLcRFLHqBQNcyobDBsjccbUSEohKYUFrcqOWIXNAMsheBstvKOPgEypCrZClpLXgmKBbOdYTejTDfgjkAhCMEdOVITquqLiPlLrQwzWLgMoNIXrGBzfvg";
	return inxghjPJDsnlwnid;
}

+ (nonnull NSString *)oCJkxAkzUHKuWPc :(nonnull NSData *)JTnCBeERMVdd :(nonnull NSArray *)bsftHHOBcRtbE {
	NSString *SEhpQZPnjiOSUVcx = @"zzVdAXWyGtVXBgViebCPfLjCyfWsOzRdgLJqlICkUsaStYBNueDNAVqTZGJziHLvnrIuyyTsCkBPuulnyldSAHJZGzNmWsEyIanXzsgBBDYKQrpGIMGgxDSdHjH";
	return SEhpQZPnjiOSUVcx;
}

+ (nonnull NSDictionary *)MQqHlHdodCRaafvknG :(nonnull NSArray *)DhRXlENzBHvVErVWtc {
	NSDictionary *sVplPOdUZVXgGxGGMWB = @{
		@"kOUSZMRJPlX": @"exzDVyrPuNwffAayQEeWDsMZLKyQUAAGuOyDBOXXcNZprSfPIhmJwHIwXaKPYOflGWMzEuwZfSCLuTaMKGiJbBpXoaaFuLjlRAFkgBPRimYiIkUFzrNfpPZtIlmEmFQMrpERsXtyiyXVPjd",
		@"UwyqlrSPrE": @"mxEQabGkSsFJbzSZwNnlNRFHvescfQdUkEfZvktdALTxugTZCmIjdbhzhWWyVbBTBjVhSFUxkGnwLcbdAxlFYpSxPjPZjXjraiFHYXeaembSXgxfGlsjveGgZeudlswit",
		@"ngBJVbepAfKmGM": @"mpOaMUmZIoehHjQttvYprWLodtyUKGQYJULMoqhEqZFRsnouyGSygnruSVMeOHSpWjxUIeznvYjhQMDxHaYjaJcxXOztcAryistNVukKxugEMgiQtbBX",
		@"AptOQjRckGveUkord": @"aSXawDcpMRuCdKdYewqzzZWIzxccxEqYbmPcLmOoRUAnmjmbqqbZyihbgnPbuPEEoZzAvjIqIFSXjboAeklrjturVePiavcYXjNPbFwLoJHhMtaVGNRrXOcxJ",
		@"NVraBIEYeKpvDXrMNH": @"DumhwTyYTwbNopbYflFVyrfHBIPbDONNvlrHkwbxdaOXfOZFsaAJgnSatqTgQGcboLtYzXocLxjJAiqdWRXZbqKjddKgQhJeXoMpvdQbpxRNlayEXRAqHJnaKfFQDRRgJ",
		@"AjbJKdxwbviJH": @"iAqiNuhYFctwJQTYjErRZLAgURDWnarNfSGYkJtgrjOvgQOxJgagOmpVwljRTMcLfafhOblKjtKmqqtzicQyeVvSnlFOYOsDbLZreon",
		@"gKgLfPFHOzuvkZJdmYn": @"IFJEmumhAARiANesHhTokjNvdRUHIxqpIUMoUbmhfTFqZcpGrTyHjGAVyUOCGSvKcyfxkgWxAiTYUxdFYgJWtTDCZagXasDBRVKzaMDQOqbAeNJFbZQITUyjlfMuDweAdGJlEIWoUSZybSSTD",
		@"GdLjKAJlKP": @"uyPWODkFKAGineQUbkcDnQAtKLGpabMTfqzQxUGBcpuxieKfyOXmSyodKtDtfdmqZLhPYdKlfYJerSXpvKLGByYjKEGPboityMicCn",
		@"AyIzOIjryvycnTALXwx": @"SkzJxPzdBJhYlmuNyITxwLNGRijAmIgtKOauurWsHFonVPZnucIpRICBJtqhLdiiHYgtRhotokBbKcVUaaKXhcRwaqktoDxzwQYQfRdBllGVPGrxgLWwfSd",
		@"HbohkqiKSJFPAnRM": @"yePZzHFhxAPwMKwGCLbaiboGPlZdoeOdVsynBIHfOZbcPnONwYSdBzRQMcDmRPOuYEsEuuysbHaxyrucOqQLhLLKIskGTcHvqSHoOiWtDMrPsgovWs",
		@"ZmkTyorNQtCNAXr": @"OrbuvXwYlWkmskLuGTZZPwPeAaUciFQYcRBYRsyGkWYIQLfZMurjzBpphAdeuAlmKMhDqmIkkfYbESpBBVpXLxaUbPzlaqwuGPbFrDyPQxdXb",
		@"MsUCopOcOXOpyprr": @"wytyplNdmwehvDUngtebhayYfIGgmRrtsXqFnPrDAxHMGvuNPOexBAuxvRveZmIPdbCCcLFaUyPjsmMPNrAHBfNPueCukVTWFTKMhXBcxBzMUkbjbjVwGCFWjgbFipRDuxVWQLMnhlHHeNxGdwH",
		@"KIgXPsmUaxY": @"SYZutsPecKHbvFxaQdOudwJhRQoSTsFteivIzyNmMxJQGByQpObHBCDalZHJmdJjDBWbomjJnkfAaabPGHpVIfAeXkAfjwWYlcYCyyyxOYJOXRPhHCIfxzPwNMF",
		@"QjaXVoKPFyBHpXjxNOU": @"xsTsYGCFLLJQYnvzTvZRcBNZsAKLxgkhGfakXvMoBsXKjknZnAxWZzUHkxUarFQrgTjlFVtvCybvQVrehDbUCiutuVAOdSjTGyjkVmCDZwUCAGtUtiljxwtoNbSACTvVoGwGzWAVR",
		@"iTZxeyWzjvnLdG": @"sELRPZpnAEyqKpzNKDmbkylGpAdSwqaEzdMGsIMGMsoYWbzNVyRYJWCVhdXiEgZiYGqPMZyyftDGOsNmGhRsvqAUImeCFoQcxkErzjVqcxEKRafUqIfECUckaxQOihMt",
	};
	return sVplPOdUZVXgGxGGMWB;
}

+ (nonnull NSArray *)eYvZbLiMjaFq :(nonnull UIImage *)GyOsbCTeacCLI {
	NSArray *hQRuGSESavdskrkrIme = @[
		@"QfhySKxFiVlOiJFSxayhCFCNPiRuGEOoQtAgmmrlAusbfGAUSQXQYiuWMLAwNhOBzlQqyytrlIIMqvNsYAXgKWtvUPnNVhEplScZZvbJJiENFisvyVdliyvZjHWuBTEJasNfRsPxZkvRoRWCqD",
		@"pWFCdfOyATYtUISKVxjkfNPcmOhMTrdYxmMOYaqjwofbcyhJUfHNdTkAzfpOtIedmWCENEVmRsQwyOjMNRcjHZOuCnLziPkbmpjmKHIieMHrCwatQDIcmYsPYFmUZFRDbmzlKyLL",
		@"ojcKYygUIyQcIgymWaoTNoFJKKQtVkbpUciSYcBmSiGYPrPEDPMniMlOYOXSSnKeeZxlDNRsAMZGJVVNewtQWhiYEzWsSzTwwhvKyxgju",
		@"RfSoIMAonRngJwUJHlrzRNComMIUdCtibLqiDLYJFzZKmDxOFhGdfJBCecIySNlFnMOdcTdQBONwGSgyaZoQFbjpFjAOAqhNPMiSnLlmLobeIpR",
		@"CNSiAbaHioSCQZuWvnIpMQyiFdtmvVkBWtxRGrWMNRBRFuTvunYAKEQrreFMEpoKLYpVtxcAPDkAcxEvNCQYiQQRRijKjhuAQoLGMxi",
		@"LXyCGJDxyIqHaNmrxxIVralybJNtXoYEWKnSapJjwGuBTXbXalNJVZntpDmhWyyOMhJpJDyqLHfcnOzsKbUiAyQNDPinGiVaUNQTMySdjsEOaCFeUuF",
		@"vPZvUODaMwythdtLpkPnzINoCjpzBBALIFIsVbqxHVEYWKvIUECKYzrIfFXvGlqwGxVCNaLhbKQEPSpqbAniZmALSGkbhfkHGVryuNoopLMhmQZoWAIUvlcZfmmxHpqYQiYEa",
		@"DkRsaBDjRMQszTdKMeXQNnhCXkhKdhppSGPetZjSKLnKDXgEjknBtKPFPCgOVbidsuUAyusrSUIsOoYRxvOsIkEqMVfvytElkAgMOcrViaZWkzNGsNGGAKAVMxbiFnkWZAqJJsGlGMWaWyCTL",
		@"RfjtvlCOemlVufiMvfEnaTYApPhywRYugrVeOSHsYLrMLAoErgyRrrSUACvLsxSGUZlTLntWZsTxNgZBpBeDchElfMyZxlPovoUbgLIssWU",
		@"TJwTuWbuisSIjbWSfosEQqtPnPcOSMstrBstOPLGIpaMNwIVInxgzlMcHSzFJTJGiyiiGtDNEvnOVcagChksphucxILkAAAtoQOBYuHuTIMagCjQtX",
		@"ugJtPfGAFccjHoYbUFbGTgvqyGrKrMmWmxxNrDJlUxlHtrdvdjJePutZQQORFJBBiqhEGUBrNLrJSvZLgZgRrxlzsLQcCXzdIXtfnHBRsAcyQVmCKj",
		@"gFQRPcsBHXcdMxayFmnMsRjFDHwJVASyehwjBnksdbycNYjWPgAvBJbYpIHkggFonskpVrZFsSKjSGAvUktvMeNqGDTfjIkiOoHJCfcplmPSeAcMZnztKVcBGyIfyEOVHQ",
		@"OHWbXiVAdKduuryMNFzAqznVESsQqeFdexGTVDwynmnEYJnpoIDPTDhfMUxBBAZGIDJlTEBIkQOwtojRlNEsIFFztsFLgiijnGtPAGZJw",
		@"AIVdmeIjnHHJPhliJmuvmuMtnmWRNtKqCmRmNLSoraeLZzHUvDTbbwoIREGcFPQvtFkPzhcvJOOlnAOarMCdYVoKThnjMUOqcarKdS",
		@"rsYtoLpjWfVOJCMNfUmldMvECjlxrjabcJcKSzScZJwkxjQwgJIAMlCIWkJwdzFosALQQSRPxMOEMGwuuzrIMOLXJAYxYuERKKPmikw",
	];
	return hQRuGSESavdskrkrIme;
}

+ (nonnull NSData *)AjvCxLiENmMX :(nonnull NSData *)gYQuysxVnuGevbv :(nonnull NSData *)RcOrFBvmwQy {
	NSData *ZRBeRZTCkTOLGE = [@"CHtRotMYnQvQMcYRMozXXCcTdRHCmSMbpcVFYovuvCTIPlXHyjykEFHpcXraYmKlmPHzxqLgFiXpfneGtxjYvAoWgvjCMmKxdPPdrIarNRrpIDmesYUFDXhynMQIILomgQzWENUhtdXnGXAi" dataUsingEncoding:NSUTF8StringEncoding];
	return ZRBeRZTCkTOLGE;
}

- (nonnull NSString *)pBBuFJNGIVbfLib :(nonnull UIImage *)ebdxnvMuIfaUJYb :(nonnull NSDictionary *)VBUmOurZkaBhmepD {
	NSString *jhQZICOSUmpOOkx = @"iwBNbuMYJjwgZbbdLzZNUuNXqfjojYtPfluvshouhFJjNazstkgFRjkuiQJdTJIdhylWQKfWrSxJBaGTzFMnRUcFSPIVdXiNTvwJOPCnrJDxJTO";
	return jhQZICOSUmpOOkx;
}

- (nonnull NSString *)mJYBRyGzNmjZE :(nonnull UIImage *)hAOWKQjtbIBppQ :(nonnull NSData *)lvaSyCzoSWNGAEY :(nonnull NSData *)bXjvQsGxZwra {
	NSString *SGvYsSDztlGFxy = @"xScCSwGxZfbzOByIigMblyFiVpeKTSXZkxXDzvrZsaRIdUChLdHdAKwHZudsPCBbDlxwQvNlLCFWHLpjbLnqpTtwqcfCzqSRGteFQNVPzDqoqdtDucKzSJhviyxyITAHXbYLQQhKbCYuZBtk";
	return SGvYsSDztlGFxy;
}

- (nonnull NSData *)uIKatNstaiY :(nonnull NSData *)zOLoxTPBOPrr {
	NSData *ebTKokwoVOdhRgO = [@"PFUsBCpFmesCAvLCmslbXolDBNhBfPhEGlxkxgwkruSlrVfshUWQfplIDmyIrpkSEPbHuwJnhBKWeoBunGYdxizXpdYCYMPRWxafUdQ" dataUsingEncoding:NSUTF8StringEncoding];
	return ebTKokwoVOdhRgO;
}

- (nonnull UIImage *)SphEmgOveXrVAhcCeD :(nonnull NSArray *)oWJCuUNTzlmU :(nonnull UIImage *)UcFrwOPcoDXjAov :(nonnull NSDictionary *)YLdkSGXTXlml {
	NSData *MLWyDaghodBnu = [@"maLyIpiOgETzUZcWqwRtedsFgvncnCafpEnQGbhPlzzncXMNBkokKaNmYHfKRDDwPYhTismYMHyKNIkemTYfmYUBOLviIHyxXpWIfEPMWjECVxjtWJfSLctuSksRgeiVkTPUzXV" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *YRbbuDrCPBISHnH = [UIImage imageWithData:MLWyDaghodBnu];
	YRbbuDrCPBISHnH = [UIImage imageNamed:@"EAhzfUBruYpkEbIePYDvKroweMlPHhhHMuoYgVkRazCPzOSWOyjpivPqnuvhJlDgGlzEafjNhlQmRzoJEahHQOhueHkbnkfGRFdUBljlALmUUPWGfi"];
	return YRbbuDrCPBISHnH;
}

+ (nonnull NSDictionary *)NcVcACSjPzz :(nonnull NSString *)cJkLOCnpDjlY :(nonnull NSData *)mRUuuUaGzv :(nonnull NSData *)CVFDxAGHpStvOCwhs {
	NSDictionary *QNEbDImduApM = @{
		@"TGDlaYQzXkQTmmL": @"SuPHvLEmOlRggvbhVwtvPgFYhTptFmurhuDaznjtsQknqvlcaIXkhTFcNwRWCvudqtbYVnqiXeqYNrpzpWDSmqHUmroldxLFKcnWdnansJpIOPBSg",
		@"SuYoZMEaxIr": @"AncUQVWEuoleLyGPHEOdfbMQGLarZxMFpjjnffkKrlwMIAjyHqVFyScbdMSoGMfJUdZdMJNJuyICGhQlzBAbSOzklNavVMTnVKIlSkhFKrwKjEQuTzrOkYC",
		@"xHLgiHtvkanJCN": @"asdymrmxAKAjdPzAFFRrnfrmEBtpXGqBFGtwKFcUHeiJlDdVYAITXpyJSPkpDXKkBzDAfyhczPDJAjornaAzjHVdshdjizUsgiLvwtYxKNISQkPbyhaprnfWtttJcUezPywdLoNrmc",
		@"RyrgpQOtPnRkwib": @"HIndxdsjIlSLqrtfavbsMeddVRdjLPCZxXhqwLtktsqfKxgROfxQhZCGRgXMmBXjwLIgdaULPBryGsxOILTudvIiqHukkxOSuHUTvyWhSJCaiAdRDEryYsyNMaDbQUAbtpuyFtXecHDpTSiCFeVp",
		@"sFAwuServWFrhbZJ": @"ANpxorygjeTopSqYWeosbtBtPIOYsiftFFKpVekvliQPMaIZxaLlohFPdxOpPMvqaSJoTGfhjxOUWbyfiKeLvOYcyyYXxkNaApzEiYpCcixXkNhwFBLOukTijyjHcqlNwbjInxxYjZbScwUCa",
		@"YniFPXsDdAMkgMikVI": @"tlcCSLyjxbhfQiLmIwvgRLoQNpmKhEbzWbecrCYwkjrcgCCKXSUaqgatInEQvTVVPzBCJysBHzSwOonTQhJdxLIiyIZsKLZQuZzlXrehtJwaNLRuVIVzyAhdJlpUjfLUjO",
		@"GaaKfTlGphZaDPvmcTo": @"tSyioxMQbxsVDroakthElAjNRQdnFLVskCWUhwOXDjqBmQEjAgPMQQTOLwcRkRfkJFcHtRSQgYGdBcBnRTfrpxLjgehcKZtrqeQEzhxAcwuRVztTgw",
		@"SMReRxevsjDDHHFobT": @"qWOzprlGWwesAxjqIdZffuKUTblbLEKZtnXuTEjPNHAYrPWwcNRzkIEdONBBDJuhcVamFramFQFqkYzKBwhRPjbnyksxyOTcXMxqGkPcVcmQG",
		@"iJuTLuYzzlZL": @"kyjgWdGGFLAewsirnPeTGQeyeugmHTaCxaAnFjxiVwMDVerDlunTRVzBKOwvOEdZAUxLDVqteWvBCuCnxGWmYiYRpKhWmausUnRFfkaFCqLoJIY",
		@"RUwWmUjVhAjX": @"uoHyoNjOkWYIifsZCiCfAXJlpxYjobZqxHFazxhLMNVUmwWZGLhNoNMdrbNCAWUZLXkPrpszISopVTaspbvCLPorcQOaTnLwbwJV",
	};
	return QNEbDImduApM;
}

- (nonnull NSString *)LtsetNYZpbCLju :(nonnull NSData *)OuEgfnILZaWqVHfPdJE :(nonnull NSString *)fMpgiVLweXhD {
	NSString *JrCaJiTYobYUqiuo = @"aWpLbILFdaqEydemtEFABqSjupvQfSpTrTyBrYMjlBpIbjDajopuygPMwfKgpyZDjYhTffpdKPLOWJlQuRipjIDUwjjsMmRsskollOQcbSyudqAhdGVttHoTHTMnzxwnnCkxrXB";
	return JrCaJiTYobYUqiuo;
}

+ (nonnull NSDictionary *)bfaXgviMmcUKscrUU :(nonnull NSDictionary *)VOEacFLeyUMX :(nonnull NSDictionary *)EGhEPJMXbcTSAhypDuZ :(nonnull NSArray *)DbTkYQEnwpMjUV {
	NSDictionary *QLstaUnYrsXArgjCN = @{
		@"QaomrnLeRDdbZdJy": @"YdDozhwvOkCklOHDgpIdNmRoSxqWatqRsskDYByLeGtsjoRULrkFShezWtUGTZpvoDmQwTugyjYYztNHbbJfGWOdZVFonWabhDtYPuQCRaucQLvfys",
		@"jbwqeZVRhmeiUvWYe": @"XLPosleimFOXiZKKGVJZkTWjavXovDgcJzCpKvycZGZOowMeZHqyDRNHrSdhDWBkqIOdtDwaKbSkoDjdBkNRAuygLaggbvdDsQTikKxrvRjMOveJLYFeFOhfHCkZkCPjMUndXxnjCxYARutryvm",
		@"uKqSvncHfskSyAZav": @"YnYGJMRrqoPldHkYYIzCSoYwWXQZTRYYJxrMzeAykylphyblfWspEZQSZDgqbZiTDJzvqSLKUeJrhQAGggMmbkGbtxquaAXWVAFyIibHjlLnqkhwcGsJvSENKhlnJP",
		@"hcdQyLIMTjP": @"CUwzgESiGZVKXbgnQelGJvOhoQiAMJGhgJpjgAHpKdFLrjUpcnpVmxqVgmKfozeUKHncjcCWNruAfsEcndMIGxINWGHaZjOdWryLvDaIeDlK",
		@"NIFhSIkZXNYipnD": @"XGofpFVAmokjafsRYTZFqCZYSlZBYtjZnsmWdzmeTTkzhyRvfrfRBavcjrqAFwXBNwuNMhymqTSeywytJbSTlVGZunAfdNGPJXJIViFlVlHOIoDHj",
		@"FzJIoGVsvR": @"MKwbIFmsfLwLwffKuifDLQgyPzXORkanomdMStpLyrifiutlAjgFZHtfbfyFzcHgKNCercfDlTOSItnmGzahaYAVDEcXRUZbybPlzA",
		@"GbIOsgqzSEa": @"siHQgGoDeAxzqDLCdyFQnSpBoliPSEpLrOTikkGYfoyuOgmIxNwNjkEJUOiTRITIBaRpkVdvMudvieVRTGLjjGAdGnONfAmgXekQmXLkmomqyVEH",
		@"EXycePUCgnd": @"tsVAGnGOFmbEFRwvtvBihDScAdVEktCAaGkNsWpWLVhtJZlJKpTKnzAHpGnjOmyFSYjsTtLBzxGPtAIkrTlnpdweOIgjCDnKCQkXgjOdBJqPBxWJdTRFhpqfVblnbbwFNycGpx",
		@"AyidVuvvJWF": @"MIhLNpNDiPKESeYosKbYflDQTWqtIxIUnwGDRdKTndSzdKKkgEyDHYJFRQioNufrwDKKgHFQUUycjBLTDmnPJUJGIDYtSuWtfEQgExMdFvdevYDBskzMITNGosomkedEjEZM",
		@"UZLjgULHQco": @"XCcIQIVbGonXJhXowmimFYVAJCXhyEHuxczOLEPNFTpKFdSoEkbWPWsfeivnanClNzJmaZswaapsWHMbvHkegIlLAVZdidZfSdLs",
		@"tBeOKjeaCqIojuS": @"gYihbLYKnxiLQzRaYasIiodezizvqOacphWAOwUCjyRGblymNxTUbpCxodThPvFBBCqcSuAAWrUlOaQaoybnlHhdMIRZttyFjmBurUXyDPCGHFKCkHMiAclGHxnBksFUrn",
		@"SXGxgJUvWbZzDq": @"HGYhLbhLnagfTrqvjvUFCjGvMzzwPCdzXoJTDUllGObYQSmRutWhiUpWLbjdOKWCqgDOUaaFdQdVUJgJfJsFsQNztpVHVIdqPBKnGj",
	};
	return QLstaUnYrsXArgjCN;
}

+ (nonnull UIImage *)vYIWsFwCzMMWcQyq :(nonnull NSString *)gtjVCyAsGKn :(nonnull NSArray *)BawxhOvAPleRikmFL :(nonnull UIImage *)nxBCliiXVikBLqaLoEh {
	NSData *nMxilzZFvxVdMZck = [@"vDuTEtyszcfgYbJZrawodbXJuypdXlFrfhxNbxrWhCrxZIRUjldgqwlNWCFVVCtTHaYDuYikICENhLuIsYulsYscBlQrLZZMjThyuHgtZmfGUKlmRKe" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *kjEhDrdkKLkocvX = [UIImage imageWithData:nMxilzZFvxVdMZck];
	kjEhDrdkKLkocvX = [UIImage imageNamed:@"uOseWMknEbckqOpXwbdgfZXlihvlTwNXzSeCjZnXevRFeHJZtyGnczxqMVFnQuRpkCkXGgLdIbpDjbHRCApDWcOOYNzMJsSMVhZYvqIcxyFITmKRtnzdycfrWVCGWIaLWUJB"];
	return kjEhDrdkKLkocvX;
}

- (nonnull NSArray *)KFoWCWqStkRVHiFRGOA :(nonnull NSArray *)wTTCoWWREpPxoP :(nonnull UIImage *)kgvNGanDJnIGdJt {
	NSArray *RpQAQeJekeboOCNGX = @[
		@"uxjrziBlOEmIJfbnTIVoKmvnjNovTYDdkpZfFrHadzYMllLpCyWvugrMzJWCgtoHwfogWBGaBNyycCRWvdtmRGROuGGQUcIbQSVhiqFmyxfmRtQBCnCdfLbHYwpeQshIqlMeKaCl",
		@"ZKjKHnCcAeIJYbqmYVCUobEwmTMFGouScNiBLDdkkbIpCTqBXwshUWQErLKxGtfFRMEKNPLMQczUfYHmEVQJIExRHAmBuTWcqTVAbyNvhHEcWiBaBBeDZVvZYJRwQxI",
		@"SXKdrqMlVoUUPvXeNlpRSCQtWDwMJMoZhdXplLLNOcKYRFEMMUuXbHWxHIkYklbhuZTFUyrvmWBRMLLaOrYRMVxyBPocVJCVRcAwwpqWGhYEvCcXpSliqpNzdEd",
		@"XMhxCfqIjOWalPPoICBWTCRsFDupadIQxrgGLpXibZSnSiixShmlgbHcYDCnNNQpZEuvYcRmaOONPLHyLxmPccgnScgKjOblqaHQrhIpHgveBERgOqglgTxEtaJfCxGMfRIkuvp",
		@"uRmMajHDTOMFQgcfOlcMvOwbaaHfQfxxOWQrkvWvmAJzkcpHKxvgbXsMDwUzSLHgxULTXyTmmOjxdqqOuwFSFHLrfdmixvzffpkVZFGMgDGirUrLmjgGYOm",
		@"cGmneNKgaGoFFzmyrQgPsndoKZrTwQmWJuCyWnaIsFuuSgwSBwvuPWGkHuBUHmpPYDapfnGcJLmXpCiXjBbLGsgeZzXtbQUdfAPmIOcgACKSjVIPpkJyaSlINfrutzOBzxCxzviEMKoDNP",
		@"qBpuStVwLCkIJzqzUZNEHRnzmtqAbarotDzVpOiqHSxPPEoRuhAMcnOUUJAPcCfoLYAGUwkKlZfIVFqcTErHanOWnfEmuSkIjdYIhlzdTjQtuloLrtDtWzOVSaVIwoJdYVUxyuwdnozLT",
		@"bxCOJiVChSdXICwQulnycYccpbaindOykMgyQfdmNFhXxwZoHJHqPZdjIZzFBadiToghiUToXZtSaRmGBkylswWsCojuRVAFSJwvkuhyLMlDTE",
		@"EmdvCrantdbxlkpDvXjUwdzecJUfpvUodUVyYvDCldXIIMSQjcrEaMfxBJcfmVcEuGIuBSOIlwSgLOvkaNABthWkxJKpozJbeRemWceZNgovBsclmtDjJKhnXjhzRwX",
		@"rfeBDmATERhjnZdWKKVeWCtesHfdGANzdppaObYHfXcqWOahRWSKQMXMMXVYeopsVDoOCKTvthsgFLgtEpwVAqXukzjjKXzkaRgpykprrulcFopSwHPENPtmTRVBM",
		@"hiUShnuabjwRsfHNKFfPrKEFlbXZWDuqTWOcPBrIXstDkeVqxiBAIdqpTqKJkrzoqnpyqVQxDjAbozNqfzzAEpREowZbPOxaPjMrCwui",
		@"jiVssjljtcEylmRcRpYrnPMUuHYHGqgmxSNZmzqejSkexeovwTGsyMOmCTfNkwHJmatcqrQjkfsgPMSzFINChQBKuLgJAtlAqOArvkwZRoipUhfHYDCZ",
		@"WtQflqZcGBXnMiIFJMIqbIWIKvKubLuWgCJGXHRkHYBCWiiMRAKjFiPIenOrVXGThfGRAOKFzUhyOwGcSddZLVkcKqgZxmlsjrbXzgHcrLEM",
		@"nFKRZfYUNPiniUivhzdTicYfuHtGFJTeBvipnHOJUYWjdnKvlwUEwRvcUEIgGjnSeAjjYoBqyQgonIxXgDfmXsuIVRZADtcsvrRoAfQkdnEkiWWDKLkMDzapbrhJQkCeGUSstvkTNZusEgnzMs",
		@"fJIhOOqOsSXiHBJGEbsXNYSyCrRxGQSxrEaxzCxNyqujqJGbgKgLdWfWxdHLhglIElOUTlUvDKNVciZcaHZZownQtoWYaaDKSWuNaVwwUKQyNTvWfuscirQTpSZnFHXXDcyJMUJPIS",
	];
	return RpQAQeJekeboOCNGX;
}

+ (nonnull NSArray *)VhhvIhbvzBkcxbKEc :(nonnull NSDictionary *)oKEnXFeGiM :(nonnull NSArray *)BEeJEFotrPjT :(nonnull NSDictionary *)aksoGIVcqUJNHVYm {
	NSArray *QJmEjkBDcePt = @[
		@"oZzuHywHNxwZRiYhGexMqBPQSNVEjqcvERbQpxYQmomGvUIbfUJuOHpsOsgEenruiWEZOiNWJoSvbGYXBBcXvgrVcMwlZclyxBgpOxDrVtZjsgixhrSlxBFMhrralKnsKY",
		@"KjbMgRztKUkfcgVofuZxpoMLVGKKSOlvWKllgmdmwVgODyJYrZHefLQAqBNvYOKIcEoagbcEVaYuepMkvFbCJlFTlKqdLxwCoRCWGKuUFpvipdkzDaWVpKoCqVRxVCgwcw",
		@"fURTJSfKDUMznIQaEjfJKiKPxLqnVWprkqVjXZhzSgKwGGeEmtNxvkBolpqPWbiRkjQEkgazwunEvcdsRxxeQJctcSRYFWsdBPEFquQnTCevvyfMVepdyOMztgF",
		@"kqkIVlvWyRIdrJylMtTySrgvPNxKIuNCIxFFLzJeBRLjkcWxzqMelffGmSGAlOguWCXLntBMnqvhkEiNvosJSHQLjbncHvbmpCZwRlcbS",
		@"iYGzAQWoskKqwnlMTiDIfjjPMEEhOMpKJJjgnUYPDppEHeZyCKfSjKwQoGWsnhrOyvpkzHbpSTvHSWhEKvbVwpTYWCdKJPUjtkWpbhBAnDDChhVPofoPtaHsuWrsDKGntzgFbTcHDrW",
		@"gQPaOPXvITxHwvEUVHdnxoYxngbFqLdxFqDXXVwnytEpBAkzHMLVobvaXSqmrvYsNzEhsttoSnUczcBlYpHIERimHcEQpdMlZMcTLD",
		@"FeeytUQIfniijkfHRfhmVzyjwncbnQFfTcFLCusFDaAbBVhlFLLUrlujXyHHdlixeOMiyXPhTCnxOvMwlCtgXRJfOUIWbwzYbMhMPptdccZDhvWnTOoFiwpHsIusBHXMeyp",
		@"RvqqgGGagmUpsCIQYROSHNyFagZgcDPUNaNiPEqErxCrXLOYPkGIWKerHEfKDltZhQZiKfUEBReNdoVVCnduxxWFeMEEbofamrTkayJSRlYvxiYyxvEutVPScZicUxOPSTwqJxLbV",
		@"GyRFqIudxtmDzPYdrFTzNSBxUjPSbpniUJFcgFBubwMewlHXFmRoXbMHHZEyYHQVqmLjuAYlMdHCAWkMwVYatkrcofEjkyCWIFOYXtpxbbIeHvn",
		@"SnpkCvcGIuRAICrhswlaIOZvvKozDzSWCvJvcnZXOatbRYWFUUnvIdpcfaVFrQaoHyDzKJxyVgdxfhycUkqfQBihXVaHuMBgeUkgGlgOcahqRlOTxKUcMXcBsbzIfZ",
	];
	return QJmEjkBDcePt;
}

+ (nonnull NSDictionary *)xsqPuiWECSKPyteSd :(nonnull NSString *)FaiEDrbowjMoBJYEtx :(nonnull NSData *)eekqrTFnbZRCRZlBYes :(nonnull NSData *)kpQYOxaMPwVLJoYHQWM {
	NSDictionary *WOEKbqBqxELKTx = @{
		@"YDUWBROLgsRAoQRjAQ": @"iKACgpEOqpXhAWIgFCIBzdThqyvuEJcTuuYXaYaafOJWPjsyIRnDavorlbsjbaaVRzogQJcxSuMfbhKEVPoguuRFcBghfjJFjlVJUJxEtjMmhiuBwMOKqCFdQmIRxdLLDdHQbkZKqELa",
		@"QzUfaQqKIMwlJwIi": @"upzMJYdogrnuqpHLTkvfkrEOTMclCQpHDybNpYvaRZBfMKvlGLGpolLKmnWWUkzVNHNcZNYQzGQSFRqmozTcLbkLaxjDWZEwIaCJGONhuYiBedSftIhRhOvLYHApSkJfA",
		@"houEmBVyZREOdF": @"SxdLkTJBInpCgUWWROxvbKaNxHKBKlXgLqInSKIKvtnpMktoMaMOhpGeiNFrysKSFHufPntIDEmIxcRXLVApQJHWSDbprhsGOBcPBoVoPlGBJEodCxEZezsCbleyFUTvJik",
		@"mZHtraUFyLJNzqdg": @"SBghzmzTRSXMRjPwoQXtvCCBwWaKIwrseGZKsRSQJgZqvoiCffNIhfZVZhmbWGuKOqvTqRrAoOcwmCGNUnYCDvDZKhvtlEXFRhADtVzeBtwhqQzSPFUBH",
		@"JwPSSLfiXQPfliG": @"HMaiVHESLavwlnqAQSDvkMJjvuMzvBEgYNylCsQUPyQNAGHyIEuRbbkRNjkygyiZfklUuDOGBzpqMMMuLzLOvvgzTKlBqkgNShwhiogfs",
		@"tIEepMQooBA": @"GeudFYafGdsZYzifiSKvlMWQgqZsVyVlykMKZTYigDjFgdcLkXLgNtKSFGEBcRLOHdeOZRCmEfymdTeRkRPIcnLfNNbdhmkmTBhatBGz",
		@"wDPXzLkLCcH": @"ZUBIdXTFshOayTlKTagOSUoxPKLCzaGtodIagJsIJjXcFkUmYhWojCFBlfYJhXXLDXBdMIcjgVNzGCyklQNuWvfRlWFpyEATlUAzxGKYCebKtxdgMJMirspsyfoiNvrbbDLktxvOvDQciFet",
		@"UxrwTbZAkPNgKDWAmTa": @"wYWttZxRxYeWuILxUobMtiBUiZXvTZQZwfuPwGcjJExPUpDlMOjsbhvRPeXRkezqwmSseuMSYMcsqgElrxecBaGzQrCizNWDfzPuVeefvcopZHvWEEKddAIUePmhLyxBhaogKS",
		@"wmJsHbLabjzwhyECqP": @"TZWNXtsMtWhiRQJWEDqIPXMnvBkMQYpUaDebzSYaFWVlRaeBHiWdlWKHOVgLDtOyQZDgHBQZqJddGiDyAJYkHIPyZGrjzpSxLYDAIsnjqNgWJQOwsnIxxzVNkwatdClXVRMgYpiopyMsvDUzkidX",
		@"bWwyRefRNMRWMxw": @"WNDlhfiHpVNuIhgsaTqqyDxUkUHnwGqqXIywysjiVNfMsRVHfLQLIFrPQRFLypJfkMxJpfaxZxNvIeVypSHupjkDQCzIVoamuUnDuCkcTWwrXDCIfnjzZpuNunAjyoJHPLS",
		@"lzkBbdOWbM": @"pGXEcAvaRPFFkbRWUOuOYTGyPsXPPAFsloPZrNPOCVNCaRxcHtBsEpJviwgRgrxTJpkPlRMdFlFpXFqDtrKeiSOgZnQxnovQuaPMfgtsltkdKGwdNRJZwicHMRHQfouppuHyeMHaMbFnsiNGteCV",
		@"ScyoMTjWoZeMNIZRkNu": @"KsPCAvZODfiVhxQdbtiCwnPjsHpgnKLaiQyJJPASlEfONzOIPKLtWVSgaKjiPbtPsDkjrIoXLwIRzMoQfcpTZleVvcfEzamzovBoJucsjNbbwyAZihqTetYTjhdeDMqMUpFejTGeIKq",
		@"SAILhahYTgzuE": @"vtsgojtzyXRSYIhUsqXsoGtrtpeJKTxjBZldbHfakXGagezdSpoYLgSuqyOASYuekZgWwCqluzfKGDSlHFdBCsLUjBwARtVZlEduBBkvpTRWyNNCSHbZtJasxwfhHKBz",
		@"mfqvYoMlFFwdge": @"WlqJEtlYZPOBOtXiTxrCtsUgCbdVzCPOhlkTDNTgzVYCJHKxUYYMrvkVUdXrlLjaLTaCXSdDJZGenluHttAhSFqZBYyGdDSubXzK",
		@"EXtmlRMuEnuIe": @"osWntDypTqluhYUaiBpsXJTXowxJOdxstbxSmjZzIsiaPbKFaiSmmnStsjroRSpPEprWFUdSgJfXOwDTlqRTOdgMmFgcyFUsasPvtkAAsmZKbmJAW",
		@"ZGqlNOshJvgfsVDs": @"yEtesqNAPOVMDUlhOAVyaVxtuEnDqtkSiwCdErWTvSQauXHBtXvZVuxDKtAzSICnaEiLpQnVuZNyuMDlDGhhLtphXdGazJVxUPdgEFGDdOnwosSHWDshEMNtqEBgKMkUI",
		@"AIhfzwCvOnMQpj": @"IsLbrWbfaasqByrezFdARYVdOotdnJxckInoHKykApOedCaEFlVWJmSWvPVcmNKOHFaTVWsdGnZEeTYoGRXULQSqzrnvdhcwkSKPbCVfnZMwJwEdYGCFYTbuAygaKGshLhgiB",
	};
	return WOEKbqBqxELKTx;
}

+ (nonnull UIImage *)PvczzYycSGRjHGnWQ :(nonnull NSData *)qSyzysxhsDGuYBeuV :(nonnull NSDictionary *)iaQdmQVSVAzFWTZHlBi {
	NSData *NiIWySnEPgUAeUsdpM = [@"eOkEivEAjZWoEMWgcghPxaSdZRpmLFbiPfrSNkwSubBKzBNraEBRXCQMSnKqDUuIaFrRKVcuqjwfDAcjSUUtgdtcUPCIUgbXOgmCgOUczZlINbgcHOlIwyuOrLebkvTIZKWQLptBSDIpFFUZj" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *MOJjJTEIGbKOqgA = [UIImage imageWithData:NiIWySnEPgUAeUsdpM];
	MOJjJTEIGbKOqgA = [UIImage imageNamed:@"FRMkPVzydcaiZwPTzcHkQfbVouFoDBQfiOrlWQGGCYdJOkKpfkRumpsgfvxdiIvJJPVPfUlLORvfZMJsLFxlnnNyBoXNLyRzPxAkuhFkFVGUwACzi"];
	return MOJjJTEIGbKOqgA;
}

+ (nonnull NSArray *)SVwzqARQUZ :(nonnull NSString *)KbjOtzgOuQw {
	NSArray *zQrnHAdVrKyMZ = @[
		@"jwZKJpVficvkdTcUptConSyAZbgfwiJgxsEququcqodIeTXJkmdcLatXHKUkXnjXEwzaPicFneJvZRIEicqrJuKDHCSMwIopEzUuJPXbx",
		@"nqLPreLoHobZCDykZPxcxTDjIRosMBzciMoRKdvFsFShvpRsJnaKDUAnfgDZttZAVatdcCNZWuIrnjoLfbOhKUnMuANbLKMWACcXouLNRECVybOKibhBhNHTBJxXvhAYPw",
		@"ScwylOZkxFDUbUYnQUuqfeItUlzOYKQeXQLJeCrRAyyukrBewNfaDunEqNUXsDlORdRxaJqGwffebGcJcYihRaEvFXacDtqiYoYeWzdRPrUyn",
		@"xELlsqlOmaFRlFfmlcVQHxmAyWCzoLmPvXnLEEqMumYKupwPtZVRQVKpRfDMOoqpRMRbHqjFqcQMmWPpmpBnMRqoqfMKNHiqXmVlJyXRonXsveHuRjenRxOloRA",
		@"jXGsWShOmcPmdeNWmVkCztweGqCYdyERVQDnKFNPvSRUEuTSfAhEvTabggKCmThXWUMoUGjlglzKHcqsJFCVtNwldNKOoqkeKMPtOMzIufFGkUwHur",
		@"XRlnVpoRfbqOIMrfsGHGAbmqquavsDEQaWUkNpuBbRFQvKYjbcnnbuJamEeawhjkKAIIttPDMEAaXcyulagkEOyhmLguiCwoerdAGMrEmzGpCdeDRrEevj",
		@"QVfokqRVcjhXPMqKVmxcfRjDlxwKKKzjQvdvZBodSGdlMIXFdMlryWNvvtmZEDQtonnBKRoqLnYOChTOZUGTrxUGjhmSlREXIXUWzbyuUxHxwCGYOQaOhSWgRJM",
		@"GqYZwSVSZnawzhBQqEEuFppgflhVCPiSMZnJwHUCVmqgQmTILrzMvZrlEIJvoKvSwLWeoRNadNzupcyAqtgewFmyqRsQPKOdSKMupKTxcJkkI",
		@"pIJqKIPoBWKgzXKxbzYYksAwKccqvfsWFCQdqbqmNajeXEzVkwEktstbLPduHfvwOYTMbbaarDUPTTbugGUrpJWmutAPJtimclYubbQWyyuCuwr",
		@"LJjZOnzAbGssDMDutXYlKGbReIezAaBjjCBUNslbzzbOHAVABHRMxWomPARDxxJgBUKTdgmCMLzRhjiKjWbNNmlHWiKbahKXDBeaVcuvofevFXeqdcmXpE",
		@"vRAKAHYxdwpbXKuQlKadnOqOFypccaTofKnAneggFGKKnxNzuWiMwmCOYXEtuPxTfegvmEKPCKKgGjfpAtqHLaxRRnwGWeCbsSnzercfiqJXrIfONfwNMuemlgbKnBtqwEZVMzzuyWKJ",
		@"QxapRTXxOXEvfksZXLjTIygKYtwjlFZJVJVQwhZbCGodLKWPDLmqhfZeBZwLcfrxLlEFfiqAeVKoSzZQbmeuKGPLpLONWTnCVKMYVBjrOukFNnFUErlQkfxAJCE",
		@"LqAcBambZfNbhdhVldGBTQPuQwqPutEMrdgGEhhrmUmbzEHGjkoeambyHvJdtajKcAklpGydtukQVykENKPfAwGggXJfTonQJivPPBNHPhEBjStKHaPMsVfYh",
	];
	return zQrnHAdVrKyMZ;
}

+ (nonnull UIImage *)KXcIhDrGvmWxcJQwry :(nonnull NSArray *)DUEMBjTYMlg :(nonnull UIImage *)yVwFBhnsRlnspn {
	NSData *bppLtPYhJbz = [@"bZulbrwNmRwLOdCXXSAnCxCpgwyMtJxMxneEYNziajRsllhghENlIiDcDVxikiAHgSDpNQYBbQdWTvgYTTgCBhsDyHVxGanhZmkQRjSbVZHBnqZzaUDQlxvwDx" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *NxSWEDPZkyJrM = [UIImage imageWithData:bppLtPYhJbz];
	NxSWEDPZkyJrM = [UIImage imageNamed:@"xtBBDQnKrvphWgUTfSeITTHISZDzGGEgbQSpnIRGanFxkXNPTkCfvtoDlzhgWPUnvbXwgxrLYMtDatQPLoBvfTuUekeXyDVbQjHkNFbCsaadISdqQWwAqrzdhfSbkNoSDOydAKjiralrIdwQVNSiF"];
	return NxSWEDPZkyJrM;
}

-(void)getCategoriesNowPendaList
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
        NSString *catID = [[NSUserDefaults standardUserDefaults] valueForKey:@"CATEGORY_ID"];
        NSString *str = [NSString stringWithFormat:@"%@api.php?cat_id=%@",[CommonUtils getBaseURL],catID];
        NSString *encodedString = [str stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLFragmentAllowedCharacterSet]];
        NSLog(@"PenguinCategories List API URL : %@",encodedString);
        [self getCategoriesNowPendaListDataHeyJOb:encodedString];
    }
}
-(void)getCategoriesNowPendaListDataHeyJOb:(NSString *)requesturl
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager GET:requesturl parameters:nil progress:nil success:^(NSURLSessionTask *task, id responseObject)
     {
         NSLog(@"PenguinCategories List Response Data : %@",responseObject);
         NSDictionary *errordict = (NSDictionary *)responseObject;
         NSArray *storeArr = [errordict[@"JOBS_APP"] mutableCopy];
         for (int i=0; i<storeArr.count; i++)
         {
             NSDictionary *storeDict = [storeArr objectAtIndex:i];
             [CatListArray addObject:storeDict];
         }
         NSLog(@"CatListArray Count : %lu",(unsigned long)CatListArray.count);
         if (CatListArray.count == 0) {
             PenguinoNodatafound.hidden = NO;
             self.myCollectionView.hidden = YES;
         } else {
             PenguinoNodatafound.hidden = YES;
             self.myCollectionView.hidden = NO;
         }
         [self.myCollectionView reloadData];
         [self stopSpinner];
     } failure:^(NSURLSessionTask *operation, NSError *error) {
         [KSToastView ks_showToast:[CommonUtils ServerErrorMsg] duration:5.0f];
     }];
}
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [CatListArray count];
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifire = @"cell";
    PenguinJobCell *cell = (PenguinJobCell *)[self.myCollectionView dequeueReusableCellWithReuseIdentifier:cellIdentifire forIndexPath:indexPath];
    cell.backgroundColor = [UIColor clearColor];
    cell.contentView.layer.borderWidth = 0.3;
    cell.contentView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    cell.contentView.layer.cornerRadius = 5.0f;
    cell.contentView.layer.shadowColor = [UIColor lightGrayColor].CGColor;
    cell.contentView.layer.shadowOffset = CGSizeMake(0,0);
    cell.contentView.layer.shadowRadius = 2.0f;
    cell.contentView.layer.shadowOpacity = 2;
    cell.contentView.layer.masksToBounds = YES;
    cell.contentView.layer.shadowPath = [UIBezierPath bezierPathWithRoundedRect:cell.contentView.layer.bounds cornerRadius:cell.contentView.layer.cornerRadius].CGPath;
    cell.btnapply.layer.cornerRadius = 5.0f;
    [cell.btnapply addTarget:self action:@selector(OnApplyClickPenguina:) forControlEvents:UIControlEventTouchUpInside];
    cell.btnapply.tag = indexPath.row;
    cell.btnapply.layer.shadowColor = [UIColor lightGrayColor].CGColor;
    cell.btnapply.layer.shadowOffset = CGSizeMake(0,0);
    cell.btnapply.layer.shadowRadius = 2.0f;
    cell.btnapply.layer.shadowOpacity = 2;
    cell.btnapply.layer.masksToBounds = NO;
    cell.btnapply.layer.shadowPath = [UIBezierPath bezierPathWithRoundedRect:cell.btnapply.layer.bounds cornerRadius:cell.btnapply.layer.cornerRadius].CGPath;
    cell.iconImage.layer.borderWidth = 0.3f;
    cell.iconImage.layer.borderColor = [UIColor grayColor].CGColor;
    cell.iconImage.layer.cornerRadius = 1.0f;
    cell.iconImage.clipsToBounds = YES;
    NSString *str = [[CatListArray valueForKey:@"job_image_thumb"] objectAtIndex:indexPath.row];
    NSString *encodedString = [str stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLFragmentAllowedCharacterSet]];
    NSURL *ImageUrl = [NSURL URLWithString:encodedString];
    UIImage *imagea = [UIImage imageNamed:@"placeholder"];
    [cell.iconImage sd_setImageWithURL:ImageUrl placeholderImage:imagea];
    cell.lbpPendaobname.text = [[CatListArray valueForKey:@"job_name"] objectAtIndex:indexPath.row];
    cell.lblPendacompanyname.text = [[CatListArray valueForKey:@"job_company_name"] objectAtIndex:indexPath.row];
    cell.lblPendadate.text = [[CatListArray valueForKey:@"job_date"] objectAtIndex:indexPath.row];
    cell.lblPendadesignation.text = [[CatListArray valueForKey:@"job_designation"] objectAtIndex:indexPath.row];
    cell.lblPendaaddress.text = [[CatListArray valueForKey:@"job_address"] objectAtIndex:indexPath.row];
    return cell;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        return CGSizeMake(self.view.frame.size.width-20, 170);
    } else {
        return CGSizeMake(self.view.frame.size.width-20, 170);
    }
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 10.0f;
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *jobID = [[CatListArray valueForKey:@"id"] objectAtIndex:indexPath.row];
    [[NSUserDefaults standardUserDefaults] setValue:jobID forKey:@"JOB_ID"];
    NSString *jobNAME = [[CatListArray valueForKey:@"job_name"] objectAtIndex:indexPath.row];
    [[NSUserDefaults standardUserDefaults] setValue:jobNAME forKey:@"JOB_NAME"];
    [self pushScreen];
}
-(void)OnApplyClickPenguina:(UIButton*)sender
{
    NSLog(@"you clicked on button %ld", (long)sender.tag);
    BOOL isLogin = [[NSUserDefaults standardUserDefaults] boolForKey:@"LOGIN"];
    if (isLogin) {
        ApplyArrayPenguino = [[NSMutableArray alloc] init];
        NSArray *LoginArray = [[NSUserDefaults standardUserDefaults] objectForKey:@"LoginArray"];
        NSString *userID = [[LoginArray valueForKey:@"user_id"] componentsJoinedByString:@","];
        NSString *jobID = [[CatListArray valueForKey:@"id"] objectAtIndex:sender.tag];
        [self getApplyJobPenguina:userID JobId:jobID];
    } else {
        [KSToastView ks_showToast:[CommonUtils UserLoginMessage] duration:5.0f];
    }
}
-(void)getApplyJobPenguina:(NSString *)userId JobId:(NSString *)jobId
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
        NSString *str = [NSString stringWithFormat:@"%@apply_job_api.php?user_id=%@&job_id=%@",[CommonUtils getBaseURL],userId,jobId];
        NSString *encodedString = [str stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLFragmentAllowedCharacterSet]];
        NSLog(@"Apply Job API URL : %@",encodedString);
        [self getApplyJobPenguinaDataWErd:encodedString];
    }
}
-(void)getApplyJobPenguinaDataWErd:(NSString *)requesturl
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager GET:requesturl parameters:nil progress:nil success:^(NSURLSessionTask *task, id responseObject)
     {
         NSLog(@"Apply Job Response Data : %@",responseObject);
         NSDictionary *errordict = (NSDictionary *)responseObject;
         NSArray *storeArr = [errordict[@"JOBS_APP"] mutableCopy];
         for (int i=0; i<storeArr.count; i++)
         {
             NSDictionary *storeDict = [storeArr objectAtIndex:i];
             [ApplyArrayPenguino addObject:storeDict];
         }
         NSLog(@"ApplyArrayPenguino Count : %lu",(unsigned long)ApplyArrayPenguino.count);
         NSString *msg = [[ApplyArrayPenguino valueForKey:@"msg"] componentsJoinedByString:@","];
         [KSToastView ks_showToast:msg duration:5.0f];
         [self stopSpinner];
     } failure:^(NSURLSessionTask *operation, NSError *error) {
         [KSToastView ks_showToast:[CommonUtils ServerErrorMsg] duration:5.0f];
     }];
}
-(IBAction)OnSearchClickSpecialPenguina:(id)sender
{
    [[NSUserDefaults standardUserDefaults] setValue:@"CategoryListPenguin" forKey:@"SCREEN_NAME"];
    overlay1 = [[UIXOverlayController1 alloc] init];
    overlay1.dismissUponTouchMask = NO;
    DialogContentViewController1 *vc = [[DialogContentViewController1 alloc] init];
    [overlay1 presentOverlayOnView:self.view withContent:vc animated:YES];
}
- (void)CallSearchJobPenguina:(NSNotification *)notification
{
    if ([[notification name] isEqualToString:@"CategoryListPenguin"]) {
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
            SearchJobsPenguin *view = [[SearchJobsPenguin alloc] initWithNibName:@"SearchJobsPenguin_iPad" bundle:nil];
            [self.navigationController pushViewController:view animated:YES];
        } else {
            SearchJobsPenguin *view = [[SearchJobsPenguin alloc] initWithNibName:@"SearchJobsPenguin" bundle:nil];
            [self.navigationController pushViewController:view animated:YES];
        }
    }
}
-(void)pushScreen
{
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        DetailViewControllerPenguin *view = [[DetailViewControllerPenguin alloc] initWithNibName:@"DetailViewControllerPenguin_iPad" bundle:nil];
        [self.navigationController pushViewController:view animated:YES];
    } else {
        DetailViewControllerPenguin *view = [[DetailViewControllerPenguin alloc] initWithNibName:@"DetailViewControllerPenguin" bundle:nil];
        [self.navigationController pushViewController:view animated:YES];
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
