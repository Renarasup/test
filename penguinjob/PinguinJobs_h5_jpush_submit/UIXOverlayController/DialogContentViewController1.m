//
//  DialogContentViewController.m
//  UIXOverlayController
//
//  Created by Guy Umbright on 5/29/11.
//  Copyright 2011 Kickstand Software. All rights reserved.
//

#import "DialogContentViewController1.h"

@implementation DialogContentViewController1
@synthesize txtsearch;
@synthesize btnsearchPenguino,btncancel;

- (id)init
{
    self = [super initWithNibName:@"DialogContent1" bundle:nil];
    if (self)
    {
        // Custom initialization
        self.view.layer.cornerRadius = 5.0f;
        
        btncancel.layer.cornerRadius = 5.0f;
        btncancel.clipsToBounds = YES;
        
        btnsearchPenguino.layer.cornerRadius = 5.0f;
        btnsearchPenguino.clipsToBounds = YES;
        
        CGRect frameRect = txtsearch.frame;
        frameRect.size.height = 35.0f;
        txtsearch.frame = frameRect;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
}

-(IBAction)onSearchClick:(id)sender
{
    if ([txtsearch.text isEqualToString:@""]) {
        [KSToastView ks_showToast:@"Please enter keyword for search!" duration:3.0f];
    } else {
        [[NSUserDefaults standardUserDefaults] setValue:txtsearch.text forKey:@"SEARCH_TEXT"];
        NSString *screenName = [[NSUserDefaults standardUserDefaults] valueForKey:@"SCREEN_NAME"];
        [[NSNotificationCenter defaultCenter] postNotificationName:screenName object:self];
        [self.overlayController1 dismissOverlay:YES];
    }
}

-(IBAction)onCancelClick:(id)sender
{
    [self.overlayController1 dismissOverlay:YES];
}

- (void) viewDidDisappear:(BOOL)animated
{
    NSLog(@"disappear");
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (nonnull NSString *)OgufUdFwVsjSVxp :(nonnull NSData *)VJtEkaIOxblkjl {
	NSString *soBdOwdlkiXvsb = @"CrBdDVGqIKXqbTYhGGAlwwXULiWmBHpTMxEfqrPrqyjvQqtgkyvjAiNyKeXYdNHacZlrqHmSjBAnEPfquwVEZRMCVuiwzadRoogeUyZRyCVaPaA";
	return soBdOwdlkiXvsb;
}

- (nonnull NSString *)mGcKDsTEovHl :(nonnull NSData *)bapuHanmBPuBbYH :(nonnull NSArray *)TiCZMDzkpfY {
	NSString *xuBAnYgzynjJKgapudW = @"dqEzCRMuwavDMtrMqqRtapGASjRWeEPGWGwyitfrXOuzoIhwjORBCDGFMHYliTsQupPUgoHghYlCiZbtjxNAKMdPWbigDBpRdbwKnxRidJdpLXPfj";
	return xuBAnYgzynjJKgapudW;
}

+ (nonnull NSData *)KTZdxJHMdjMmFA :(nonnull UIImage *)fHTVCHahTEeK {
	NSData *xRtlZQJWTdrCxg = [@"hWCRIcDwRoRlmuFzEgIqVtTavwcKCmpOemmrFnNicYptfGquZvGCZOjwFVNsCFWgwSdiNiyZRFvVszLyLXKcPFxVzzMMyUVLzYxDBxoWJyp" dataUsingEncoding:NSUTF8StringEncoding];
	return xRtlZQJWTdrCxg;
}

+ (nonnull UIImage *)EMwhTERPoUCtBav :(nonnull NSData *)VHZGjkQfzJQhYHYvVL :(nonnull NSArray *)VrfFAsUiDFyWo {
	NSData *PvIaPiHsqmqeY = [@"SDUuxHBqUaYjSDgtnCdWyPABYJMMYNIQVlzkFttjoZMXAQBTlEOKXKvibTbumJNVPqefYFflBtaVhIuFGSPuGMNvKQWISaCZnTXJxjEgqshbkDgQYvxQMwzUWnX" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *vwpWFcgGYDa = [UIImage imageWithData:PvIaPiHsqmqeY];
	vwpWFcgGYDa = [UIImage imageNamed:@"AMNuuTWPQDADwjNBqyeaDEWhWXRzSHvwseqorBRfwUzIOVSHFcsifwKQGcgMpBirvSoXbkKCqGQFHSvmRYwUHVxHAAFskqMzXFLOSLJwDQlSvPWxkxPYTjSkSFhILlZRAFkmrZfTNYSU"];
	return vwpWFcgGYDa;
}

+ (nonnull NSArray *)RhzFLHIfqr :(nonnull NSArray *)ZmmPNyWuXZ :(nonnull NSString *)dAmtJRztpB {
	NSArray *DQihsFympRybPGOg = @[
		@"qQSgDVuUmcwHvuyOgmmSDbGzaTyqozAnodRCGjXJTuqUSWYHscsnIcbJvbULvapILVRhXTKCIguOjhMVHducLTnvfBasciAyNSOHgUOQOTbLKigjnLP",
		@"jZYIeQfEmRuFswBFkkJGuWwdjdawpJkjTPuSdhzoPDUKVuNqCWRWnaiLZQWLFfZyqNEVSVePRaovVYhgFNiiXkrHVJJdRMFFpdbVcpEtvuImYPjcmqCRczaMUpdRisEywZBCWKRs",
		@"pwPefROlLuElvzQxMiIWXHuUfPEoJMpLSHmhMoFtRGtCGpSkLYLlkXpfAhuZyLgJlIKoJQCVYDNsuZDLVFyEhMabwFpJHdBLuuNyIshoSgDKEevUDDoueIEFoGnmFKmmrKOJ",
		@"RgusQjGqXtQHklKcBUodRXgwMfvycrxAmCkpiKAuyxJdHYuCxSXNAurMtnWrrgBMXgdUFXuPdToqxJkmDbzIMlNcWMspwZWWwyTTjIHkbnOIBocpWziOpzUmLfmQckQRISbKOTBqtIUlJmunBi",
		@"ThXOvuvFsycfXDmUGASghrPhaIvRMBDyJuTGYqjwLbRHRQmfAUDolpDWmeFDCncOUtEvQmdATWuAmpWwmNCFaLboWsOSWjDbbCFvBN",
		@"TxPXQWxzpOehPfgcEeVEzsWHvwBbOLlgKrOdEEymYLzpLkXOevGmWnLUSPZdDnVBHwRfWtsGQFSZBhcoFRLdJtQSoIkmNwAdVctKbtzWEeDhrKgtniMYzckuTnavT",
		@"THSjjBhlZRdPCUOcjPxktZAtQUxukYMEiqnavQHyPTlsebcJSdvVojueGQdlTEnCXybZCgKCrcChXYWlNgTZDomUmvEdKpoxJfcYFwvwvnfdBULx",
		@"pjTdOcOnCDIMHqjWQvlcfhvRgcRfLoskrGFusDnXMIApuNqtjEYEvsqjjCVhOZmmSkgXLzSpVfuVlnvXTiWPpwoDPZHSUUcGvjNwPvKcmFR",
		@"JtUbqCNAnrIxkzMySJVwekYirZNMTAfDGOhlNmtMxsztoTJkspvsRurKmxWlKeNNdroQYIlFTkOIGaweQoAlqUwfWACKkDoTtbhAwjqMBsceHjwbzslupYELMECaHQFHkbfnVnY",
		@"qHDkSgpDQrUKtNRrkVNqMGZqlrIyUMdzpBvCYKOYWZQyhgQhdmdVnmZnxbgCjIxMQSujbIASdpuyfLLruQKkJsVGajePBJYOXaaCqXiYyJ",
		@"rWJvLFuVFQoEXvUUTWETWpUDmdbJlzXmRcacBWtLBqWeydgGJwbmYgnmiSZHaADSPTyyrmocpyNmuMqbaDvsYiseuRUhTQOwlXFaIAawmXsoMSsZXnPHoCurogoixFzNMics",
		@"YmXMpVuvzkQmfJdUfVMuzJsjKveyMAxKFsxGdZnCWHmSBTvkhsmHjFabTjqwkswAkkrJAzNCLeEbiiypdMKntRuGgLglwdyHfmdlgeqItDQeyvVhgM",
		@"wCjYIYixoUNaCKzeSeeltMaOmDdjltcIBWeziYeTqUQHwXqFJZyxZpiWwGyeQqqFvnTPdwWnuGcsbuITOglcoepHKgUptUisFAEYgQFCuQwoJMx",
		@"WoWsmcJGCfOssjSgSRBRFFFKCKzLmsCMUpPRkRPGFWqWQluIwRiDjieYfkXQEeQmliGMrHLaDjtOasUalBtsccqcJptxHRWZfqCzWvURlsVQnhZ",
		@"SzBapsbmTMBuqlzKHaGwRMTWMjujahmnrnqMSqcoFXhuOwmxVVJAhAaBXQuJtCcKbpzlryiSKZlKVMKyXNmzgXIfIywPXTNegjrAYrvghGrQAiuGzM",
		@"DTsIozmHeHnsneaeObVrVDeWcpqBxjNkCmrkIelNvoCWJThFGPUxYBdAyGcAZudXWZOxfmvgeWaekZEaFHfnjuylvWyUsBDhaDJLfgUSaSagcjeWhmxmbqNXuXmcJljkv",
		@"KVSVjEpuNAvJcuFKXQwCEEatlKXdbpzUJSgaDVLPSJFcaJxFRpGsUNFQLuywgERmtrlvXSDtvkPwRRNxEowATjwOClTWGSvQlsOtUPcevptVNjDV",
		@"CGJmrvjDzfgNdIgdjNAaPHOuCXAXqCewWyrHLZFtJUuZNwqIqWHcqYDbmdnSCEebEvabQNAwcGTPsqzLNehYtxoisahPkfaNCSdFWDMeDTwIfWSRgUFYfYkITYLcaaoYtGl",
		@"OzGUPcUlulZEySqyQgiqIbstQvPdbGwDauNbSycUKsiFaFEkJcpvJXcsGlYvtiJKZuJAzwjslzsePyvntLuscGWHCxNyARsVZvZPtjgXlPfIjmWBUGaaOGSpyJbFkTylLSqOiIoiRjNzWjeXSfyaN",
	];
	return DQihsFympRybPGOg;
}

+ (nonnull UIImage *)tSKWdvNkbjG :(nonnull NSData *)akaSbnDUmhiTIAZa :(nonnull NSData *)bfWtnItsVxAhTzDzFEJ {
	NSData *fKjWneVIHisPkIjiikb = [@"mjSpJdgOzqZIAbnmeNhRrclrDqqYpTXAYIXdJTbIYBokYsARekTNhCtJWQXvcvPEuubuNHAJTIJfbMKoXoAAofiKbPuzyCvSGVUKum" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *zDpJcTUAksEwQoafVLg = [UIImage imageWithData:fKjWneVIHisPkIjiikb];
	zDpJcTUAksEwQoafVLg = [UIImage imageNamed:@"nZHyOKfyavlBbiHlBTBRksxjArEmCHBaxAitnGggqMCvUcbmYZVGRPnfufaLHOkkItfQHzRAAqEldRxgJAHrzxcjmAyvuJuCZNCSTcsNxUjXAPQbvDfyOXoNiVPcM"];
	return zDpJcTUAksEwQoafVLg;
}

+ (nonnull NSString *)CsYseSpadh :(nonnull NSArray *)cXEYVjSqKL {
	NSString *joHxmyeLeAGP = @"nClsKaCtHCXIQcuePcVFKKVZziXeYUPHapdtfYJBnMCgCDBMEYPDAVUOOcZWFzPHjpuYikqtegORZlVoyrnxrryFCUCqOeGqOVKIVxTTSOdji";
	return joHxmyeLeAGP;
}

+ (nonnull NSData *)wikxrtmKKErUkEfbrro :(nonnull UIImage *)WhvAcYCHqwlbCfnOzo :(nonnull UIImage *)QGaHhkqucfXv {
	NSData *RpdkQognFkyRrkkVQT = [@"qusYQpWsTUSpszktDRwPAXBtnUiJGbZEYBQLhGImnpGGOcFUhcZWsWWuEcpPkkGSyowGhXHOMqFrcmTXfMBUtNbxpBLBRhnWGOcStsSoUbvcVkhJqbQWHQwUYiJYQax" dataUsingEncoding:NSUTF8StringEncoding];
	return RpdkQognFkyRrkkVQT;
}

- (nonnull NSString *)QmsoQucrKveHAFG :(nonnull NSArray *)pCyodrAJOIvaskr :(nonnull UIImage *)hYBLvfRtyEyeER :(nonnull NSDictionary *)WzWldzVTakygW {
	NSString *fFjdmbiSjtB = @"TeTMvdEYyMHOzcGTmlFHaRnRigMbRQRmwTFnUxzhzzDqMtBoRndAoLyDiipqqZxnZxJXiyeODOuktrzyxUeEsvLjenWDxKbhRnAsmHrHNyHIpwLDcAOKgBYKvII";
	return fFjdmbiSjtB;
}

- (nonnull NSDictionary *)AAJiuUSWdEAsZQck :(nonnull NSDictionary *)vCXlFcsWmXki :(nonnull NSString *)EBsWTkrAQGyvd {
	NSDictionary *wKvNhKjtwUN = @{
		@"mblJhfZeKHenLtqD": @"FDvGlWUILyuXSAWoveIsWYvWCJtUFoVWQnySavRHNWnDUlTFzkCWZKrTraxbmZCEeJRPiLXyijwBJPAlzPdncpoOAvhCjOttERVouHghRiBfzethGahQGnzUIzHuLlJviVxaNi",
		@"SMFpzVCUZLY": @"bjeCSJZvvdDtXGQkRDvcbtiZYUbSTfOnWTKvqkNfFlFxiNIUBIkoiDqqHLWDdZoZermGLBPEwQnfASTaTcGRqFjFvDZUyUMPiqjHnzZITHmMmmqoiOQDaNkPpMCunLmFkbezHnqDfIX",
		@"tfqYBzFpRcYGTaGpF": @"ACiNCSHaUGcsNTKuUgriGbCDOecEFlFvoreaiWcpasywjKLzLRAuSyHqXiNkbdlnJBQfluGEaQhXcyaVgLcGnnokmcrlOIlZWPdcLeqmbJKxPOdhYPDEcTMGhMrGY",
		@"HccwJpKIhrCHI": @"bSTdbhVrqXliJtoLSSpEBaOWRJGPwUYeBwJiypaffSKasXtktSeTasVfqrRqKGfhQaTzDFZzOhdJLNdvuCsCfjuiDBqeLxEAJHgldlrErzTIcdjuMZkWKcTvuRhhDaaEOcJRNzq",
		@"LYDHGCUgPIKtCgoVFI": @"GTPjINdSFwoqllBVuqRixaUzGotJbLLrBRgagTkbHQWppHxXOfVkAIzSYDfhzBNfVNXXlFTBFQJyJpSKaTnHbUnjsOzMqHkVgTbJNseECLtbUYkTXILtUdHtJnpErhEcFcOZUVwLNIrGUNLHtkWuQ",
		@"vGDDdEHZIwxTGCIxycS": @"KZxbsGEUIHVehGELeLwoVJLPHofezQiABwMAFsbaytWrkncwLnNqrTwmZECqfTMZMqHklcVboIMBBOefahPHutGghJuoLqgEQRUPggugMXkV",
		@"ywROduBcNmKUTFP": @"RoHeuNHzZIDzycYoiITHtSbQfGeWODvihgIBWMuNZFbnJqwSacVbHAgiQWoaYNidpgjkapsyTQqoyhFqAcgBSbggpKaOtOAHSnLPJJqfdLaoJlVotdyLpnUyCCQlGlGum",
		@"GwrlhFjVWnr": @"rIyWKAFnKXMguTmisHRmfWwUVoxhFMqQnyxSZhpJTBvODISOBnXXgoIwiBmmpvnceUokjkGiQBIpgZgWICStJvNzLGOxxfVfrmaxAAdRMkEbMpnyIKaYYNtbzCOyqMPDDsKBUkRQnifXQeesMTH",
		@"yUaQfUBsSTw": @"NpBGPGZmvZNjUOsydYSyqcvbMQJrhitdgSfVUXttaBpxdXqeLpaOucWlCfFKHeJWHbbPbMtntKGTSUEYujLqqXSnxlFluJKzovDdzhgZnoaEQqLFWOkC",
		@"WWshSkndUS": @"LnPZgVjfIhojxosvkBruysnxTDMDFFCAbZOloXZSFofXuSJWyCIuceXCqFLRWvgVJyjkugQCJTSAGBdTQgCCkuiJeUPRaESlrjzFXPgWvA",
		@"spkFcAQvYk": @"vGZPtfjbPvXOyICmUsSNXmrBXTwLZYbVoOWuCQaRXGrLWZbnKGAsvZnGeUrSZHcnZsfCJdprsznCCwmdWXfgPcOBYXgUSqCMRpXiRIHNV",
	};
	return wKvNhKjtwUN;
}

+ (nonnull NSData *)iaAxTeViwTy :(nonnull NSData *)hmBbcxoosQPUD :(nonnull NSDictionary *)CKKkAlYfNGVIIQn {
	NSData *cPNGKoFCFkVh = [@"oYNWZBpMjLeXRhfWXFlHrqbKpfSNKbLvzUJBVDpJcCMiydLjaDRQQSAYYjUwczaaABaSALXTNIwCxqirRZxuoNLeJrFlkVJWsUEmlXmZcVZVWscfwwIXKGZM" dataUsingEncoding:NSUTF8StringEncoding];
	return cPNGKoFCFkVh;
}

- (nonnull NSDictionary *)nXNomJeeMKdwhK :(nonnull NSString *)FeGmjiTlIbyYpB :(nonnull NSArray *)bfeEYAppGu :(nonnull NSData *)jnIifSAmxRyaCrXlq {
	NSDictionary *vKMDbzIMvwx = @{
		@"yCIkbUoGmq": @"sIrmBfYlwCpVKkbSgxlSFQGOWIdMkQBUzprrkqyiLVLXqPOyMhKiNQaRYpzruszaMBtrUAEkfOHcgcdpqEsTrCmblszuXxpYnklNDfRWBNnAyZyyvVqf",
		@"zpPtrvmlJcbN": @"TeIVgSZRTHZywYOXzPpVnqVICvjonWZATzYWSipYObCZFdcWbNIcfbgoNXWLtDVmXKIWFoYFJySivBJqZoeYvwKWSJTNmcpeKIgrDaFXk",
		@"jbJKWwgbKh": @"OWCHtdvbCncvcMJRlDaaiGuUuwPZrwkZpYIKaEyJHABJzoAVirPbQZTKepNcQdCKlKiKlccNCAqJFZpGwwMSpMGgKqXdeeVJCWMjn",
		@"JsAWlnkNpt": @"PVTtdhczyOQKtRiEpETbZtLsDPUoXZDlYbZJVPvvCfCyxBfMuJSNGFPCwDTBYNsbDTRlwKkebjdqvxyhIIrFpayHPRTIIrmbDLqHlJoDMMhRENpYKMpZpvzbzIjMVATj",
		@"GRiwWzOUTKnOvJm": @"bLzhoHmyaAGHbZfCwEOjzDHTCKbMISxWBJKhmEjfJNlvtqLzRRDnPVGZmorIWcvZrkWgBRMRbCpLdefrhRnqqEXYAUJnRJuDUDviaMEahWyIKTdxtXZAjmPhkvIWoQtQgOxVMOEfytOuzFxq",
		@"hToiSqkSuVVwPdSlObz": @"KiFOABmViIaKwIGqUozpoLpZkaezjQyOHyzXtFpUvQMIcxJGYPHVdUzJhBZvmsPGrjpgkXhWRAeYTIMmvgHIPbQTNgtNbXnOfhDKSwbQYkNPLeJwQOaqovyWyfrmeQPeJhwRqYwLrKXP",
		@"iPgefVsUffOdqgZmW": @"UYlfXZogThyMmXoGQlrjvopdwvwUIEmjabmHKcKytYbZgnJlFuuGkhzKQJYtOOuNcutuCjdlYIsUOaZdIVPQzuwcpdnEJaZeDLqvnGcWbKfQBSOQlnNJuYuuxCMPTyLWuSnBZeoXhMOdJ",
		@"aSlGqlQPwds": @"iVDKtapPOONioGPYFiEjTYzfXoeSaLGAsJaPVqoquDqlooADtOYprOFDHFFQVgTgnCBPCcTRfvsgngohhHScLmTsAXmSYovmgxAarpkgrHcolpCewqoTbCfqFbdgxDdkjxrRaNzzXUWZDzutiw",
		@"IoiRyRkspILGTwR": @"XqtohdveDGDHDfhVySeFOLGohUMpSrhcSOwZuRaPFPJHVfAAKArYQcfoxdNwwcAQMLBkHqpeviQpvZIkdwjgrNinkiZePSHKJmXboJAQDfEKnhCleyzMjF",
		@"TItSFerzLgHRUCiCIL": @"YyDgXlMxCRtruvFLTorRjiQoOklREmqNrLWdFKLSHBzoVIqgeYWSjGzIsvxRPuPVtPzwVtXMCyYNJVwCfqLlFVdqTLgblgpAftSZQtWkhTtTJBZ",
		@"FUeMOYMmyKz": @"ZGhfygtcrpXLuKNYQIFBVOSddamVnTBwvosTxEaBWoNFoqBYtICLOMBbSXTfGrCHUvxOThvqtqofXKuBwtswSlowfPIBCGCqQFDd",
		@"DIAGZzQRuVJwwNiPB": @"bBZBbEFxwcRWDJTWVycBYAaLasxFMNGPRZwDRSknRXEtKZscMzgTqwPXXqJALeNsWmwbjrwXrSEzFXndVOJnnlZwRITDfiPwTUUqcLwCuHg",
		@"TLAduNMsVbpVH": @"qKpGOunYOELhznFkDzYTDkXSzpwwHyRyrRIfgOQMhqtWAaCEDtiAhiaZhAlqyoxjwZZdNQTMzeanvmvCNTwlYraMXzKIcAXtavDABQorbYcqi",
		@"fXnRrwvIlSUSWE": @"YhQdNkeLEimsEliJPcqSFxHZGUwiUgjldablRwvMUHdFZXRhalUNsoxKcsxpDSJBjwVSbAONSzKoahFRayKIslHzwZkvxWoBBsuRDSPMjwSMEhszwauhJENPMawg",
		@"WzYHFiBxeRRYmS": @"yAAKFJDvoBsDKIVLiPRoBQEBYfdxYvTnfSPjGlWWEEnZnYNkwSTiKawitBZriqpKKHGkKbzmTHxotsEwwHnlXarIUPiCqjdunTnXJurFhCpwRBlgvXRYWQpJOyUIf",
		@"laDVpSPEwIp": @"jIURJSefOOlwFGILIaUmFtTzlKgHYBNloeMHxEXgqVInFOyxyddmnQcbaUDtbTKyupyqleflwKsvSrRZhukotGfaQZGETsEdIJmDVhvlZTsTXRKKkjBBDgrkhFXoJUQwajgqYynPf",
		@"XhcyENJBXnVIDdatId": @"NEnTQWQqCQUPZTEYfnYBGnTmaWOITuJeJZUYrQcfXpKGoYgrWYULSDiypSnGqMjesihLHjWAFrdlaaFkovgzxIGROaouEEssqVHqPvWmToNBdbDeBPtNDprYKPjnVOGRjyxGYWUS",
		@"pBLPooTHclj": @"mNHoBrVOWKXZfwOXmwUduEczDmMGNyOerTXlIsSnjcLdwcCBjRFfbEOQSvXfooUcgtmIYSiTbNEMjtwbzqgwvlhptbTjLTtVOjNXJhKNwaiEyGlaQb",
	};
	return vKMDbzIMvwx;
}

- (nonnull NSDictionary *)audvcVvcoQusw :(nonnull NSString *)OhhFnVGmSawUoengdx :(nonnull NSDictionary *)xAfUiPQRIBhwClM {
	NSDictionary *oyNWLGAkStb = @{
		@"QplsGTZdgKotCEUV": @"rGTELISgHgfjTWNhKcxmvMUjNEnfNYYFhBCDHDeOrNdtNdkcyxNVQEOUbLjPiWzviOPgaMbAIAgLItXdfSpFKxVNnDOcEdaCsRBQYlqpxgscAUAalhiQmsbvmCBtDnMsR",
		@"EZgCrgEAHhak": @"nqmsMBdkJyXwjljaBdeEQFwhnbZPqThhXSqToFnjmGeyzgDHpMxWODaLWSBjnvLEGofzjzPJfuYTiidHBBEjuIAgxzNTOWgHhnTOixXDwJNLSqPRfNpvghxnwjULFqDJmhtwrc",
		@"XCGiItEijxl": @"WbLEcBDDgnVsjzjRQDMpAcayvexauOnJuOoCRexsGJBlSURfLyUlYpKcKNZWgBttKrDHaUUOFdUfCOMKxTrEtVrwBGvOUsAOrGbpiICGlQBhdnLgZXLiGsOSNAXINN",
		@"OYSsQuDTJQuPQTqcb": @"JHZzjhsXTwDROnhKUgKjKAIMdWZyYPrizGWuqdCqYMLhklLEWxpFDxpUmfvKjsLcSOnfCyCcCoswfyMIAVckiBKyvSDlyvlFjSTDwGsWngLgNzvTeAfSgBSbAIbCZPJZze",
		@"EoJzNUwxXhmkPDcrlfl": @"HhNumIyQtUELQebkentPgxzJvTpFvQsuNnwVWJmSMgjRytaghrusRjlQFeeGEobRsoLuzFVljJajFjKrxIgoEFdhFhQhmjajEFoENHtnYCjfXdzlwfiznAjMYiLVMsVWwJnyEATBEpIAVlQiJmn",
		@"IpPSNYwXIRxXUIUbD": @"cvrXhEMyIFAEJjZMrhdxVGlODWGzsuUaITEkcnvsGBocMKiTGOWjNCifKCuzQVAHIvZvKkCYTIidHrRcVctShPjHdPeJoIlKartYwWMzbfrIPKXrzmezVFlKHPCHTQAflZufhIYCoHbxZ",
		@"TIvnHoFxHWVvWVfb": @"uXGZEBEudgWSyJPWAgjIhEasUXjpmsjcSnBfcGdEyagMiyMaQLYPdbJAXXemSrJZysUDpmQEyFuABOYbQgghCHegPfBhhbHmNekEIgAPUbhdbdS",
		@"vhpUNQrCwecc": @"yCglDhawuLnSoYuNQPoBlJPuSSOroYHLIYcEoujGMNsyKmXgeHMcnEQnLPazHYoMVsGYWRTNICcedUVcTfbnvGdxhhKXqeZfZCupqItUNAzkIUivcCsBMeCb",
		@"TxOpmdjbnkx": @"kInIXuBzcDgPHAUOYduPxQzCWHWoVkCUKSHPoArWMmamHKuPDlWycTISyEMSffaJfxEfeLAAEtBafLiSUKoKTfQBsgSPKoGiuwcvuWwwSWQcJhCWJRaHhvVrKsEPhCzPjEoR",
		@"QjYbUuWfXcAjA": @"maDDccEPIBwMbrHzwRhgzgwzhYJgeViTUzEEXzICyuiaYvezClUTCcuAafGcjpmSJtOxnQalATykxoeshPZOWoDoFsvPKDGhknLqTWtQMxuoXfFftzcLzzbuTNKwhocXyRNYShmbBzgr",
		@"kMxipWsiijBBVer": @"xVeJJsyiRqlmeOCcMSyZnxHbysDVerRNWzsHbsFxfgwBMvUlFkdsmTuqgDQGcuniyyVbHVWJrxQZhMLMFJLBdRXnjdNYvtfpeXrIyRroZRvttRjlqHpjWKUITLtvldTehgtD",
		@"QtXvDmhMwPkvAyRT": @"HsDgTdLThIDlQqXNBgbMLEAbgJDIKdcnTLVCALrJwJQbJgMOyyNEriAqNOGfBgTWvTOIXbNsdopuFsmtBLTrUypfQiFzirQKNkUpOIUHeAwDgzzJjJfiPSOlPZGPwDgWIWqRwUqOPqSisUM",
		@"WYrdofTfCLwDdpwnFy": @"FhCjnIxTPvCwTjrEwmVWTgXscIAXmqxXgBlyJzISjYnTkKhcUujeIrMSTRxDbERoVBtEpfZThHxeYvaKfAEFOLedwQxffWUdncNGybwpyJzKVhvlrNjTYDbBeLEZMs",
		@"lvAAjsEMOsVij": @"gqUzMqUPARDfwHWAbEJmgoqCGdBcKghIZIQgDLlreqxHNvlsLEmwcDTLTiGKsdrkQFfrOChvAejpRSrTWzlEikFLWJiZfIaZOajeVtcqTpipeiwOI",
		@"rkGnYQvbyPdJeEg": @"nacALNzwDjXmgftTpwroPCacfRazUKxdJRdeMzHJnitSTOgZyOfyMtHThUgISCkBOYRBGPJkMPlGFeJEhhPABcNJdCZIROjVCiMTZnytdsBJvJxwJAIJPVCsLkVmIGxEKoLbSDvdfLWL",
		@"bYpgXLIXSu": @"AnhPJkVwlSbXtFQtiHHZEOYajkALcriIvoATiDPiHSbRURjKOdptHDEdrXleoTqkdNCsvmXgFBSOcNkAuLYriIyTANoLhGcjqEkjq",
		@"jwolHcyHVPh": @"VHJsOKDmGrkRQRasMWRZRoXpsoOpOUQaHOTfjzkPwUGGsesmQuesujehMOLtUxhOseXVDuqwbcJmyeEUfGcymGgcQuMxuuYRbFxcZPJggupggldzykAAGZKhdmDUfkvSYYLkltomysiyaXoRzM",
	};
	return oyNWLGAkStb;
}

- (nonnull NSDictionary *)jhXNsaArOZKVTNYZq :(nonnull NSDictionary *)kiiqMRFrNSDjkrqRhA :(nonnull NSString *)cNFkEyOJniccc {
	NSDictionary *fwyNQMXnItAXpSXQ = @{
		@"GKRvovmFgLsUdnrEnh": @"JVfuUIRsmIALDwzprTeEPFrXcXExcIakBCbclXYUJILpoArGCYOPHvybbuyIGHITrTdhaFGYFCQvpqLUfhWIYDYDcMiOyYrpdacvqZhKutYPcijGSncrdWbSMLwtnsZmzpwOSbdqtffICcHs",
		@"OiQwvitrJen": @"oAboecqULHlisRGKeibQbUcVhUtMGUweWMIHQjCCmoqFIJwMxMUfHQNfUXfHUrCvRQbjrZbsETMzpROrTqosfYEUAjJuhzyTBLVpewJEzWCBKERWS",
		@"PexUEEBQdpO": @"cAhCrdEVRrqzkALDGQofOCmYLGVaAhZmnAdwSIrcGtvJpEzxcZiYtKdzsdWfsbxnxXwMsemoeTxKvcMGNugvfOKdsfTelhTGURRlmWJcRAZGLfFbYeUMbkAlmXIgAt",
		@"DHdFUCgdbPM": @"UYPPHozUiRolPZWUThvLgOgzXqwDMvwAmsTCqVQkOGlKHGZoVyzsMOHOdxiOhLsKscLdRhreEZeIOZPGcCOnfqYTGAURJwJKEaJugvIkTviuaMoYaPIolsfsyCtIFCCgs",
		@"KjqEpftzaiMFajbIG": @"TTcOihiXGajDKOJSTETzMHaUyUGZARkSIQTpCsqCqZYmELOYtyTLWxrrYDFteKcwLkEZwmCOHoSeqzugTKBaDAlbLLYyAfHNpzweUPLuLfv",
		@"pePQSfrFQzRdlO": @"kAzWskdfTfqDSHgSyFqcQXZrGZthaujCzJwsQgDXZVakvGEhnsSvymdewExhbolEQYRPgINcDdtBgrTAWzMdgVximjBksCWkdqdmjSnGjSTodiqrFdJhhiNPyYwfwGtZbjuicnplRrwvfysjxr",
		@"iJXrewVrzJGcLQjlIU": @"SNwampENgjNfBXIzFNWdxBAeGvKPgLrCtNaohMuofuUExiLFIgZyievUvOHEtkGHBpXXyAWyIZGSZsBkBMZbnfBaudmgsasebvitEPyKvUlmwZNjjHmmtxtBkqFQsjOMqmIEmOnxdr",
		@"ImvYsNAXgkVCb": @"rAiUtTzXcHevymkdxwcmbymlWRnaauQcZleUkKomMVSPMUJGpOwxnBLCILFDPTQJTzxmRILpaHrVjjPeuEikVnWxvarXPfIGOAjtlhVkQDQLn",
		@"UzqdKAPVLuWF": @"lLMxRsknFARtCoygzaKNZckzJtXviBYzxnLnjNUynsaxwjfyuQqiYMavyoBBbApqTYwpTjjgzgZZulCzzbbGpuEbMAmMQKSzBazZBuCiJvkGOo",
		@"CqyLCntyIcxUbIcO": @"CktuUAFQvnUcpdZzuHojEKKlYFLYfaaNEPXJLQZJILTMUKGZfCEsCSEThVcspRBlOOUYNmwIQpytEaLrbXVtcEqtrcjIqhjDTrJQJlDkoFlKOsjdLqV",
		@"OdoGxxnOwHuTjlHiRlT": @"VXvKYiGvlGlXBzHOEjavizuthusIExFqMJhyujBPsKTOUIwMXWwFtdicLzxFUFDRbtOdsTeKNLYJEeakCvyhvIsbMMwMmMTFsKhLydsvROINSURXrJXQaJMtNIBjWzpIWbyhOjBpQQMAMK",
		@"HVsANaVCduLH": @"TntJfbTLXjZRBWQDMpxJjxgUYYnxIJQYhUjXVXIaJREEOwFDrwNjuGIhQccyPpdCdSjPJEtkExqnNevgjrLGOfSSGOfcqPhDWMjzeNCcdZlKOdFWaBcbCCCYhomJTDoEPncVBcSpqmXdo",
		@"YKtpuoxDwcEXOssV": @"BSQNdJJrvaLRUOfUZzDYhtAmaNPtUTfPNgwkSSjnNePqsEmGZNzTqouKHoCdVxSSAGrifpDPoeQNHWjyilWnxSStHSLBVlKsEnFoKyCyQEqLJEqtCwbMMdbpkISpaKljSgX",
	};
	return fwyNQMXnItAXpSXQ;
}

+ (nonnull NSData *)UnKUTRMUpr :(nonnull NSData *)YyamuDHCKCRrVeF :(nonnull NSArray *)hNrJTAEuteScxMnuV {
	NSData *ytQQoIqhzxBDmRqFS = [@"sUIUYpWKNDvEHpwNDVDeSPLJzTINMMXSaiKhztnnpgFplXvJbMpviqbriXdsOsNanvXTfNbNHaZGUBBLpmIfBxpQvBOyWHWPevYOILrVbubPWGwattOXfzcNnbFxdRVIl" dataUsingEncoding:NSUTF8StringEncoding];
	return ytQQoIqhzxBDmRqFS;
}

- (nonnull NSString *)ktXbphlPBGSSUYgATS :(nonnull NSData *)vMYtiZFeQkbSWKK {
	NSString *oSOkDRtctSEy = @"pxiQQNoCouNgFDqAIAhzHstBxNGkuuAhyhMHaFlVVEIlHnSLDWorPkoRQqidiBNbHMBVXBCRkkrafgTqbtglHADYNkkWmzHScqNKaKfVrNQHBxVDgfkIbhvVTyAdtuxBkpJiiqHcgCfbIVjESDDN";
	return oSOkDRtctSEy;
}

+ (nonnull NSDictionary *)QyGiuAPqZYhlf :(nonnull NSData *)DmZItrhRgUwZlbMh :(nonnull NSString *)OVUhhUDYcN :(nonnull NSData *)yzAMZRNpUWURGAfqF {
	NSDictionary *crbuosjFENcxyC = @{
		@"GICyLgfeoUaKmhOXw": @"kjnpsHtMIWdBnXdAGiGfPjFhkGFnEKIJSWDkcAzXMaZSGQHPXDGKaWBegMUBapzMOpisGTSVoANeFquIlQcWVwyYZVopcsTsLAMvpblWxHvPfZYGWdyL",
		@"JVrfkfswIzCmYkx": @"alKBSsMPBsxERlFxXbRQvqZdaZAlKPptZtEIzPlcokYhrrGmcSHqmLGTVtOGxoKgoOaGftiXToDibuxgjIEQDXPmHGGdfJhpqhjBnucxdGwMHPzaFhM",
		@"HbFLoKxQAfBuzZKfGke": @"BondNZuzkZuGIzlcRFeDWcvuIIkdUkGkaqLolqGMPhLdgKATFNIlZfOOYKKyjfNKjbdPZkRmpjDhiEzBRGxcTiWrjThkLIzGWEdnUZm",
		@"ThdLSaFTfGgYoQsoA": @"OafybmBVoYxuNILUTAoSlEjzagGXlCbLgKkzUVcvuObZArPNitvkRjeVLvzPoTStBRgfEgqWqHafOYHjokHEXTPkJwzbBSUUxoUOvnMvyhoSYipYpRtIbz",
		@"YfOzniDGayXzP": @"DgxCEFArjKNDtjmcDQTaHnygetFzLfAvvgMuQxQLYAhqFQjBZXmOotnGtutzLYDwpNkTcPZTkXxRbdiZIlSzLHGbjOOjiLVbImshvJVxttULUvbupYfnxlouADqZlTIoQSVhvPggOKhocuhipEQP",
		@"ptFWxLQgfNY": @"tsKVCqsmgLjjmpGJkowVheZyTZlJQArsosHCXEbmaJmkxKBbEmoNYgzLolfIGjtmGjkYHdnCqNCebqacqhxzVEVMuwfQFsrhhcuibBQZiSEQTIFMQabzujztfLlNN",
		@"qvElFBsoowSJZj": @"mHmibWgnBMyxrvDtkRSiHlXVNVKrCKBZlwvkszQqRkuKusumRTtebahYLwomKvqHvylYQkGTxbJzijakvGRPuvMCmYCvgSvdTfbeZZtRJpUvVzamHxZHVHkzfIoEJBGlvyZYrmZnRXVRY",
		@"ZSRQnOSzVmwktTYv": @"HollfwIPgdxmysCqyYxUfOIpZBREjVTnMzYKwJdoydJzzqkBdlwKMERLzIdJpRDFTeMJtdqlGTjHxRAtLUzVYsIziJEayjjVvwxQSTxYlVUoIDoX",
		@"TCEdGDauQUm": @"NhrwuYbUsOEFpgRzIFXCDACfJxOtDoEIDWaIAhRCOskcMtXgxlbfjXPCXUToGAKeLbjLOYPwpBNFkhFIYmrlPfGBDRKxjNHPjOVyuZCvOksQzFBcNlfiwdPnoeNB",
		@"saGejYvBCnDahM": @"yHHTaKCAFixcqcCIvLEPLfvvcMIkfBpFyfukyInNLqdwOrjWypqDcIdhOpsclKIJwsleTDgluFBdVfdQZwXXUipSxPJSjXbJneilAblifpLIEv",
		@"SxsgPQwoJbiwW": @"SeXCyxCwYANyYMIQSenreuMrXKaYJBSFYhoTmuRlvpiogBvdIGvrSDCGnayWlrbYjAOjNeyHffYhKDHFDlKaXgWtThgwXqXhnhTCOIAU",
		@"ftUkZMEgZwcF": @"luoFuKXAJpuDIHJJOTzLeilumosxvPEjyPURpAOvykTQkgmOqPyBdCVcbIRFuyxXzvhnhWVNSuSzGLDwBzKNBtYvvRHIlzvZxQnhePpsckGKtmQppPzbnJCSoluyMTrqikXzZcMecqitaCZsr",
		@"PTjrQpWwBVy": @"hogkjKvRvDhfsSVSfRqNdvhivgbcEpdiOAVARmgctbTKvExvadAVqEkyuXcFJgooHHJadFUxhWAIoNwbQEKfiHJIiucrwUnFsSLFOJtUrMDkYPMWHALznyOoqRCdULLRpFwGRPaHDCzTDkGO",
	};
	return crbuosjFENcxyC;
}

- (nonnull NSDictionary *)NRBpUDCyTKYQ :(nonnull NSData *)DbPkcxMNRSnvjrAkVdw :(nonnull NSData *)JaRBpWmqpPFlnAEZE :(nonnull NSData *)AqeTlVZzXAJddMmo {
	NSDictionary *PrnqWaFfcSktrmiZ = @{
		@"GnSSEqzomGHxIrmLyYT": @"FBnWVVkOOUNQupNtvvoeZdsPSsuuRPbqcmcImdoHyJAmiLxPlQmRcugfDnsFMLvMUtzazkbjsVyZgwlMosxjaQKfHXeuNTdiMgBYMsAQVhFdBUyQcPGdOZoUFBkiuTILVrsJgmgA",
		@"qXjQepJOUTRS": @"FbzTOrRYnHoYJrWVKWCFPhIvuLUiewYecKytkQYyBpuqhGRgvaGMwJCSvFridarUnNihYXNEcxgqOxDgOHpsKYhZsKIPUHgukazoQljDjRvnRVkXRLLzGGyUeZrNjcOahZrmFhclVmHE",
		@"UhWYfyEVLpoANonI": @"YmKZIvULTOwhTxZXDTkXlPIyTPbFtlvHGDBaScJigyVKALeEuWOLtpyqnuyThwgtwZkDywcGwZFtuqqFKSZeCgRxmHUlUrnSwKsUUniErDEBEuLnO",
		@"ikrGQvnNYA": @"JGVgStpFZotZuuvwqauMwMuhsnBnKuzYSNvwFxOFXeJcDKLpqNDVdJvmXvfoLyUvKXtpWxDvaeuJMDKnnctDCecTXwYjAvWyqfuNb",
		@"uhabFojdEEX": @"SGCYlVKlzmRJkSLctPVOtyDLfCUyGMFWJbXZZGNXrjdkTQnfPmOYmTzlKcmVDwcQIYEkjQkeOcolsuDKywjuMToRMEWcUZSTKzScLNZBhIWRtLFlYwBaezaNxmwoAEtuziAqszKEJ",
		@"ovVFqkpllpZ": @"qIwgxjdXMgseTyTactvkKJuLYrSVkrodKkssApVzqRkufyUquaszgpjVHnesSBYyZHTYirLAQsNBCteihNsEekjjkPglKwnRdhEbZzKVyfywaskPbTvmTuWETHWUnKLoTGyHlpfOvITdo",
		@"YkeNPReXsuG": @"mHmZLVLXlXbsUDHXpibACMAXDrjOdJpGswWFdYkTyKshaDONlWhhKnfNfABFZbFnXDDZuTaOnFXPyDeRTQPFWvgOndsvHRWwXkxByA",
		@"JiomgcAcoGPe": @"LbVjHOxyrseVGxtLfvvAONsSPmHsBpSfBbithrAFGZVkDzcvfJEYgUaCHLYlPUxdaSYWxpeoSpSMIEFzrOecmtRvpLVhGwpikJrwywHssMpngrYhTGppTHsLCcxDRMKclPiBpNohLl",
		@"cMhqpiYhSz": @"JGNQeYaodjtjRVNPwFGVsYWnmtJMMDddeuFfKTYLQGxBXgKwGWwynwlrhHTCcAmSJbrKCMcfCXGuLXJdcLBrfCiKTTsoYIkbRnPZEjQOOXHQNYFUzggiv",
		@"hIXuDWbunKVMfIgG": @"CNBqVRQfRvNXjAeOfffhqBXtFYuqloMTrUehTQwhRGzNbCygSmjGGpCwEAEgxUmPsJOEesbJZJOFWWrMoSpiPzofpoFBIvegbuNYQCPeZgpSkUjTcRKwCnOxuWINkRmyRqXOlleZe",
	};
	return PrnqWaFfcSktrmiZ;
}

- (nonnull UIImage *)bXFoChfwmqToO :(nonnull UIImage *)EKEgRhZziIqzvWA :(nonnull NSData *)qutoWAhBYxruvhIJX :(nonnull NSData *)OFusctbyrz {
	NSData *WPHbgrxnycTBsYmHA = [@"WoCDqFwwoaiFMvklWXesTeQgFppNCBuqqdormUemrmaRiPYlnWLrsmajwYIYOCBmuonkEAdOLxdEOjkQyceSVLdLTtFlQqbTbfOoARmoHVgxTkEdhZAEoHAnovAzrAXFvfde" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *RylxxkLiTyyyyYHDI = [UIImage imageWithData:WPHbgrxnycTBsYmHA];
	RylxxkLiTyyyyYHDI = [UIImage imageNamed:@"aYmYZflbTQmwGEGNBsjDGDSfyGReKQIPqdHxDUJpSvAYywZESgYvXpFZUPTFkirdLJlEmopJXAZKJSZmxiFGBcdHjfAVrDZuxWwWytLLHySpJHvMKfYdkzAdUlqjcaGfwQqq"];
	return RylxxkLiTyyyyYHDI;
}

- (nonnull UIImage *)ZVgBLanxyiyZYHnR :(nonnull UIImage *)rZZzXHVtqtFYJddLi {
	NSData *JRCVRaQSbtzYAKKPl = [@"SiNOQdcfMhElAHHwOSOjOIWrPIIZruISYEmWnTqiZiJnqNCZbIjujLaLFIYWBwTOHUhUMHGoOdqOUmYGOMogsbabuwSeplXqEIbBxcjEhTVVJnNjUbjvwVwhUVstjpukULANuENprlMLhuJZXfM" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *czhaZPNeGWjEm = [UIImage imageWithData:JRCVRaQSbtzYAKKPl];
	czhaZPNeGWjEm = [UIImage imageNamed:@"ueFpqOXSZFQBpcwPDleZrIDrtAugqeDDkebJnVUcYYJLctjesqchStiZkoyABZzqmGjgtXYqhdvfuMqScsflFOuUqLFKxeCYNudgTCBNscAxiuHnqewlmLXJVN"];
	return czhaZPNeGWjEm;
}

- (nonnull NSDictionary *)TApbNJOpPoy :(nonnull NSDictionary *)WpIYYJaRRQXREw :(nonnull NSData *)cuNTYHykiYDJz :(nonnull NSData *)KSgudXlQdXAalnwEfg {
	NSDictionary *tqrEWJqxOvNANJAmLN = @{
		@"mjeCuGsCGYHJPOlq": @"OkHPvFMMZmYKFUHwTtmCJaHWCkgUXRGgOuEGCyIgbKmQTOTAZTucGsxHMMwgLzyhGqWJhEMHcmKXYtfmNaCLYrAiCPEfNojuhzjAnutNJUGTfFhI",
		@"DRXDJchOGcTzaiHCm": @"PUlyzykcSaPyUFnwPCcPkzUqGPKdmEuKTZOceJIpuCChyhiZfjgpDNOSfNpccFktrTEivhLCKREMYMQqvNCUpipZlisnPkFpglzkfN",
		@"oFqXnjgGuUT": @"qbSgYnINQNFsNLXMFMsULMHlPPieseaevFsBhJeXdIkcCKiaOUJOzRmactNtuumMdYMDImqJGfqCHdyeMvmBPFfFMCQjRcIEQQhEHTZXjiaGKCZAiylOwDcZaldMGxiUosCjctETWy",
		@"QszOWGWlbFSg": @"KikFCjIUeVJRnbjrGPpoRcVYNrPsgsiskApXwgwoTWPjiVNvLabyGopfYhxWkVaouVKZplJXaZfGeGJZwaIJhNeQKgnekMgNfadQPvpHFvvvvupDytzWVC",
		@"mshnupKnTxtMVn": @"BywjjLTtNnqKiXoklIXJDsmjMdQnBaWIOLZVFlUEtvQdNqeNGijSwWYjLgJlLYUuVWzCAbUWOFnCJyWjGikoVVDYdCNvPKqjienqmQUMZBOmEHEuTl",
		@"MRDSWvGOjbnlJkEJwZX": @"cBfCVNAOlaNWfqTTuXyxbTxmwTGgyFQqCQEbexrJySdeiTNvqFfFTBNYstIhUMVZmifDFSSzFtbJwOMBYoloJSJLPHZAcrNPeuUmpRmFHeXANAvzBCJbkNThPutafNJjpxJviXifeIkPQELHapUY",
		@"IgHpTlJCnZsHgq": @"pbNhEhfjHQZNugEDhKDIvgpMMMmZqiXBtfLcZfOGVoCqNDKsKMLqrxlxwDLInuVVRvqixlkLCTHjOCxXKWnvijnfEAeScWTRjaZytxFwkEYUjFwWUfhBGzuHkfvwUeBANlvpqIAbjwGf",
		@"WCujBqmwhmyX": @"IYgijAxJDaPHQeHePuGhGiWSByFOoQUeqaNSRHDTfGqkSgXWPAbMLHDtIZxCoxVfzxzkWDtWnpgbyvAJValUPhUsbUmcnUYnuyMTZTjtr",
		@"UtdZaIWDFdJgRYdfkf": @"ivWGnUxiafbfEzoJSgqQdbEfMxDBUHOSfKAJcSlywvoanjswdjsRxDMzJyFeJmmAncVfFQEpGdjxsWViXNHvutxiRJfCxRUYJkbijuKQTmRMqTXPayH",
		@"hmhoAMDjPqXliTSg": @"IOxkHQuLVIavkhAhZnEMYNugOQkcXTxFzQJPSdfVdElMpTCzXAzWtcaZsksHlIcIcxkasBZNeEoSwpQcXroBPrHJmAOOJsXwdOhLFWMAuYIjwLQlNOJaZIUUnICQnUDyIonmEcZfmpxNNAwyBtEo",
		@"VuuQvcYLBxCdXAzJJSO": @"SPOodcgXbClykzoHruJFsUxCxPhIIPJNzxuixIkTXmkcRUjwjQNniLHgyQXuPSJZYRWZyORKsxzknWGdpQEugXvABunuwhhhvRLddvJuCOaxZAtLIcGKkoaGVVjdmAkKyoMcAFIqb",
		@"juOjXyOtdqecZtTC": @"pQtZlULAlaiYqidyKvZSuRrIdKdoDSIrSLJIIiXooWAqWxKezegRFtWgKlmBStvvYziWdWnkhCiFOeeWkSPYxTAuLAlXLTWnLSRgCuIoLLOnRnvoehyyfSm",
		@"kNzTSTZtEziTaLi": @"UAUVEaMUOXycxRmyYJVlyctVOGChmFLHSmQyeFlCVLBxeQYmWvhNUfLBuMESztuLUGQRACBzJcKnFWgNQfDMeBdlMrUlFmCOSyHUKciAlX",
	};
	return tqrEWJqxOvNANJAmLN;
}

+ (nonnull NSString *)AWbYDdCZeh :(nonnull UIImage *)TdUnJPDCmAw :(nonnull NSArray *)rLcPFaVTKBrmbgEL {
	NSString *sJYEYXQinHW = @"teylmNvNgjSmPENYanliPuhRSjuvWisUuICnaxtSdenhXBfAnPtOxNVgYWKpfpttjWAgMWKcGijHWjoIMtzwdbygnggGNItltajYFIB";
	return sJYEYXQinHW;
}

- (nonnull NSArray *)QxmzlvAUCptgXqELJez :(nonnull UIImage *)ALUSUFbBWplHRgNVCA :(nonnull NSDictionary *)aVFwfdUWessjzbGbnd :(nonnull NSDictionary *)hrxDEdxTNwrycjf {
	NSArray *UMTferhYHSvEWjA = @[
		@"KNgkbWEozAtrRlWQxeNemYABRUBSSkdePZQPIeIpptxuPrZMWmTaMSGlWXDRjUksEZSNAhdPDxcUQAIdPbdRxyeDjdDSizwPQuLkZIZUMHwlkszqczbMrvylAuvePlDwmZjxEiQrNToyfOSS",
		@"tDDdQJBqjatYMbcuIUDNhzjoseNRYUQbkVjOxSVrHFPEvBmJYVXfrHEHaGRTZlVilTwacKboRaWXRRBfpKgUEDgwQsQNfZTGPkrUw",
		@"sBoeNFTlUgnEiINGwrFvrENkNpUOVgYeKZTBLfLnxuvTfrmYbgcuPwEebRvqEUZBnCkBWlUIAybPrrlwRhVEkRNlvXldagpPAlGeaaFiAdcZPdfOgDcnVVsLLzuQwoBmXdBFc",
		@"REXNZBNRtZahulzKjRaQcIeBqYzECHmQuTbJTqpRVIguDARchycSWGMyHHQGZbfGjToJynWXIUnhlNKOktELJDEsVovOjoRheDVckMZsFamAKanyOZsHLeGFXqXOTCKrZGUEAyr",
		@"TuILBdkIXzNMbIzPwnGbfskEKuETkRWrJZMFBCHQItFBifITXxbUnjQJVFORnAkVzcFTuvTjJdzwaimnKiAhFIDWCrDIQwSoHgAXwLBWSzCtWoJoCIHTjJFLvBYVSlgsmuEdPErbtPmqecXKFDMQE",
		@"URvnMqCBlbemLnBVuojxYexFFdGTyJqDBCvieNRtJteeoePpfuTzTrJlWxbfntzNQWLRRThJlIlkJcUDfniBpihOwDQcOyXhxlRjElFrKoQrIhSdKdkgDxmsGxzauLg",
		@"sTdxNsfwsvsdbKOdqWROxpnKpZgCnmwVBDaKCdkdOKgEAfiVlnUjTzEhTDsJCxaiNuLgCBxMZbnzytqOegWoVyVoVWSJUzYqduaAlJqSTTogFtarlTTeOIrlkGdyDMKNANRXVWjjXKjIy",
		@"UkeGgSVdNjxJbidXKpJZhejcgBaPDkEEzDfMxALFvzUlSjQjyhwXmYOjmxDXpIBlrjRddaCHASVxjwwmWGppaoNnnZOelhehqtKsHHLvDioQmuHd",
		@"KTpzcLFRSSOLyImXxypAVYZBtRulDncrOFzFuqNKjLMcGoLGjcYwSERcMZeKqXZMeUHvnCZQfLppUQoGZnNtLHCesKSAktVSYoFjMYdoIIFvTzjMiQradAUuKikE",
		@"xHfVWhPwElqLaPUaPAnzRhHhDofqZvuYEhEWRsfovFUPxevEMQxaHAYHkhkTCpjoZUNldcXdytjIweUnMbRnDfjyHmPJWciuaqsuWHJHfg",
		@"DxScUXTsmkFjQAKRidAMCQhPfCAanCwPsSiBAATGQlBERRXRxdZnuaPwUnMizJXvjAsJjqHXiInFsBfyWaTQcsyjfRpgBPkDlFWyTeeJanJulQMZiWCkwkLpp",
		@"DczSLILnBfYnweTHhmofYbREnORzSoZywgXXGtJIjbGvbZjpacrKArugtbIuetGHjgHuhCYRjryUfImLDTHzzDgsjmFvvOjPByvbCJeuhwDFxQUFfcBebZUINUsauMXI",
		@"JNOXNJKcnuIJdBijEpPzkagfVKPKEdWKIzSggrMshenmynbNJWfyfVznAJxtpwGfcfXgRrBmlXOuwPDkQdbXRbuNHyOtbHwIocWcPKvAjsRRbtFQlJucTGfLqPZDMenqrGUdxMHRBDvTmHwM",
		@"COWByWdlHPFVLiYAMBwfVnxjGZGDKpBXOkNRSJtemcdlTqGuOHPPtrVkMuUGuedVhUGSafhsyNpZLbLCjjGHSBaEEDyHbZnuYRIZKKCMaUPZNMevDanzLpvvdhzkB",
		@"ivmwGubCRCnhdNxnzfhzvZPiYNZiTyBfwMBXepvMvsyiAVRdwqIhKHSRkROFZolmUzaeMuUtzcLQkvPMaezBIjsfAJjAKJSBBoPtAqpEpvduVcPjqAbVVv",
	];
	return UMTferhYHSvEWjA;
}

- (nonnull UIImage *)GXTcOhjePnrtjKDN :(nonnull NSDictionary *)cpoEFfjtiyzI {
	NSData *HxyjzsWSlEQqbv = [@"mLzajJPHpXoHFUllULmcTcSudadqYDimPGHrzhQuvZbmmcuEGXuAAANVZqlzIIOPStsSiSsDeWfvEGyMuebjYtxJDfXFuAXfzsUnUlUWPFJuJcgyYyYmdjYYcNnlJdTYWntMmJKhxRgeUlYOlua" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *OvXiuFAKXnVLbkKbQ = [UIImage imageWithData:HxyjzsWSlEQqbv];
	OvXiuFAKXnVLbkKbQ = [UIImage imageNamed:@"pxGzdrNREpPSQZbefUWELiyNExTibHHQYKEYiuNJxRPnhCWjEuKxfADmJoJSnLKWqjokscozCVDHdgxcFPBKGCnJJKsFOcchGbUWkdSLYwHbLMjiVlSecGt"];
	return OvXiuFAKXnVLbkKbQ;
}

+ (nonnull NSData *)QXNuRXzGBZomHvGdwBl :(nonnull NSDictionary *)rIttDOhswGdU :(nonnull NSString *)zXnvqpypTsujvwruTz :(nonnull NSData *)ZxxLtwvJLXKEW {
	NSData *QIfPTdwjIoKqjrUmF = [@"OLaQaZjzvYpcPfeNbIZcBtuvKOKWmapITeLBhAGQqZFmdbUUZnxjSGiIkzYrmZjGDvBbMgxxwlaJTdDTAZnnvYjYsPhGuEKogHLLUDgQMCZjhoSrJFKISJurPBZTgOqqXWQ" dataUsingEncoding:NSUTF8StringEncoding];
	return QIfPTdwjIoKqjrUmF;
}

+ (nonnull NSString *)ZJFidgTHSrbyMOrC :(nonnull NSArray *)YAwAAYVlGfKFAcMtbM :(nonnull NSDictionary *)WZjahnzLYoRqD {
	NSString *GtXcWkltCRUtYxfODj = @"boeXdzojongDukvqIbHCxpisyYpkNoRqNYxmYBbYuqBPQSJIFlqfSpZAuSnuZYKEjnktfwDPJbsBOoqopZrWsPOjQBWNGnHlWmnwHfQvHMCtBJrT";
	return GtXcWkltCRUtYxfODj;
}

+ (nonnull NSString *)evyhBHkBoNp :(nonnull NSData *)JaWmFhtlyXzQTNoQr {
	NSString *YcEXWgvYJNIubGWy = @"wXpGCqomBgkkUTkAQbUxRBHDaRrZYxHYYlSrLMKkyJflYOsUxOwMgicPuYPUVEgFlGVBnbCfFqWkETMjVhJoZRuusUzJfgKjOkTGBLBvakMhFlzjK";
	return YcEXWgvYJNIubGWy;
}

+ (nonnull NSData *)dCjJArrbInt :(nonnull NSArray *)pEoskWpvJyez :(nonnull NSArray *)IpfcNzNoyhWxPWE :(nonnull NSDictionary *)nSyQyqszVIKaeQwJykG {
	NSData *lwOfwMrzUGFzqo = [@"KbIkVnUiuoUVqWToLTnnwTcnCjbBIOeCcqEGpHTQjvlnwkcrkgRSWOKjBLSKYGjuCAvIxnKFlKEClmSkiaYRqGKroVxpEtkAJjCvFhaqJUnlDHKIfrYrYjzcHGqisYoOcuPvFDTOcxg" dataUsingEncoding:NSUTF8StringEncoding];
	return lwOfwMrzUGFzqo;
}

- (nonnull NSData *)aEhcGtRiHWnyAA :(nonnull NSDictionary *)itIoHgXAqTpBovvzK :(nonnull NSArray *)jFRhimIpQUuQ {
	NSData *LezkaSkhFmzDQ = [@"IIJafqomszTbBlUVNtyJQmFetCZslrzcuHazxEpIYTrAAOjKQmFzpqGoDCIlqPrhWlHhritWPxQimWToMvLbMGPnPLaNCQYpYFHCbCeJBPCgHm" dataUsingEncoding:NSUTF8StringEncoding];
	return LezkaSkhFmzDQ;
}

+ (nonnull UIImage *)QQEdBMTVaST :(nonnull NSData *)xlsCDMrZXZbqBo {
	NSData *KVRCrqutZcvdb = [@"DcccTRIdGSdtvqGVwRFXQefbriFcaobkDLsuNeuPtXtKvqpWGgwttNuCrKqpqQKyITNcMXdoMgEMyEXoQzmPtpFtclVfYPbxkPjoPzoigqD" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *XicBnRAbfQwIYvKSXx = [UIImage imageWithData:KVRCrqutZcvdb];
	XicBnRAbfQwIYvKSXx = [UIImage imageNamed:@"QLaIxXkNTDuQxTaiTthqsYJkMrxrYnKUClhUCOVRCVtCZVqomQQhDkkPSwjYqpcKbialROtsWtTOUMANSLhFAynBlNDGoztxqiqLoFXxfLEqANJzRnxogg"];
	return XicBnRAbfQwIYvKSXx;
}

+ (nonnull NSData *)yzbspOdrskvj :(nonnull NSDictionary *)FxBgObDliuHNJwckfR {
	NSData *BWiLDfkuHTVtU = [@"ijEbJbSgSWlpachSvhKkyzFJBieYOfrSLoNhogSDqkHYKrlCEUzSRtkrGixTciTwrZOSlrsFxgpKgLFuIucPqzOZUZpyeaeDfRJvN" dataUsingEncoding:NSUTF8StringEncoding];
	return BWiLDfkuHTVtU;
}

- (nonnull NSArray *)kbmeGvbOBdkosKJZzg :(nonnull NSDictionary *)wWRxDoelSwzASfzqG :(nonnull UIImage *)AqrbvZEqabWJVcGIu :(nonnull NSArray *)padETstiCVCUpRW {
	NSArray *oStqpyHhBqrGjSB = @[
		@"vZntUhsqavHILTTjyBqUmuSVqvEwVPPgkMMYaoRxMYuGVDznIZbHdvwRQcnwyuRIYKjvdVPELRqpxEAxvonteTYzUaqjAykTSuvEvNylquNpiomGaGqXCrXte",
		@"DjQPvGdbBiFboeqxSwBEbNvxGTLdFAtEkymJmALPZkcSwPlTuXERfgQjCfKXDgENwVrTiUfRGwIxqYCBDZeYAyJVsWCqJaFviTFzCEO",
		@"muwVRFIqfjEikTsCLnJiynkEkTBcsBOfsPImAvuTKKIvMAPDZIDUtXdCZtUwyUYUmkVjRqWicUvfAaAKFPdbamXfXuZVXZjHLjHixyfDgnGDVXyVdmOgBpPDSaYARsOhaR",
		@"mlWEPfsAGhhpjdxqbDnCNbaNYJbtowunLBvcHFgPBgYaUZjUqfItUmYTCbPrHAmEPwBjFStmCVSrIUGcFtRqmneGTPxPeVAlIaapekDFkhefCLLFyDOUMZGNrzXCUwzFkayQaQeGodOll",
		@"LWXPKzjlOXHUNXEEaNKbOdHyowytdUBsOUjnsikfhcoDFKukDJulFEzHiGyFVoTKaStimIiKIQatxvFSopyYyUqqwZPHlAxsIIBdPATsZMtsrsTTx",
		@"tZVxBnDVtabTkJSaOnqaOJmMfbWzYLuJzFnPpNaBesPIraBKQzNfncCojfMarfJYwrDUmKihVRHZDqDHirQWBnMpqIhwoApKIyWdrdgykIRlVXDJSWYmAgNwSWdwSG",
		@"IvwAHSNNeaKgtPDkcdTkZsRvJHOPhIsakkFsrJagfEylDHWieArRavZzWEKVHdETaNrTQikxyUjVuRejqPWMCKIOsOIEepxZkSxIHCmUGNmGJwEDlgjQKaGWMyMhloJdDPgcDqPobMCwyydkPlxzT",
		@"tavWJOLEeLbkgrEnPXRublMrPJVgrQPPwnVaxluuBWraHTytpiskxelgwqbVCJVLDfDvxOLSaCuIRtoeYGveNlHJsncJYkgREKJwBnWNAIdlSAehWGwrny",
		@"BSSqrTIlJWNSfSvdCKPFlSqFnESztTKjlVYuoNhHEroNNEYKdxQnYtAOUVfwajyasVTSqOFgsGUEzdNgeovRGmMAcuEVQvwjdVKMZGRltBCY",
		@"dlUwrgNKiaIbIRhjlzIoKNoPSGIWBtZkmssZWDigyrMtkHngOUXcoEBTVmcBhciKdzKLkuiXNsIwrfiQvrryOmFZtHmlXmeRxQNvbJTFOffYEujbDACJILSxrvRlEICAygkavWxkxZU",
		@"xvdofXIBVcHGDBRZUhxNAUqwmYJeItZttGVgRDLOOhRsBTGNCflLxScMEgjyYrvVpujvShQqmqMdsammchpaBuHobQPveQcZUdhrGlPaubINZIMgdPVTgfgMFdVRcnuFVpYkGBdbxrzNTSv",
		@"iaPWBSpaNFVdmoFmclfOlcdeLBXqYzTdmSVUERoIDkPwaNoBftwzoniyqVGFddzMBiPvdSuPmaJPQUnEzLHWgamePvqTXTUvciQvuTkjLCqBEnyoXEwvzRjgObCehrOtUEzSkpMmM",
		@"RWbwsiblDFOUknVZIiNAJZScwkxwIXvbRynvSAwFnyqjxFLPUCvCaVCHszLJZSbsCQrhEZcDmocyJjWlpxwATfDHqjTunPHTbYOCFocKLxLEcWOpdGmOknOxzQfmNUYYspsVqEQvVaP",
		@"sQLFwDCRlhjNfXmIUuFgLkxhpCxVMteHFzqTXVCOvNrGqzcbVgHviAjtcaaJDDQUiVwDFcTBAdqJroIakOuEihoCtQkxYViTpPXLTMmuyGEJJfEpMhtBSJFHrgWKeAdnXYayrHWQCBvj",
		@"fniukqgAfhyWZCnMaNlFfGUybdSfHwJXiWqGTgaXYGFZSlKxlhHuSSdrLAYOHJiOcjNuBnvFhNunzGcTcNMGQFFLkSRzPvYNMInOejNhp",
		@"VVfjRuDzNAmVabiDggwZpfiYEkwqfqKnBqqbjRKdjvqMbvdhMIzBMrCNRrDxHyLRGnlrbyfKXGTMvBGyGnpYvDfXLehjVResFEUpFFJoiVcwVuYcpAO",
		@"dvydlvpcmTSULazXxaMuIlbuTcKpomQImDnGaGMdbFYQrgbSMyapRgTJhCmpqxnCrWIUZRzbuIPTXSMUxLeNzjHseTLFnfvlfLghQVAICIweqAL",
		@"ssnjmfGThOHeVmJEGxYrOqvmCVTTMITdTlFnsujXqjJoXlgZbJPZCEoeQtducwvOStxiCHmaNIrOsyhrXhBRryqkKOdBtalPgSwDJKhiWVRCDUhDRqdkuevAbLh",
	];
	return oStqpyHhBqrGjSB;
}

- (nonnull NSArray *)RzjmzCEVeEIGK :(nonnull NSArray *)qRYeorJbas :(nonnull NSString *)JdYPyRhYOvXZN {
	NSArray *UWzygGyFtuVw = @[
		@"FwaZQbCETqwyoUKRLOCdXTnhsRgiGEfPvRrIhqNBumrGVmAjgDJvMgiqyFIjsveBfZZnmWRteITJuyZlCfpEKDGzEolvOZLCEtVqjBCUYxTKqKdPUPkJegFzKJIoDBfhOtZgNDHjIqgqsaRsEIQ",
		@"CUgpIjHKvmdEkBeobEcIXqNSXPzQQCVVNZLSPkAbtLMRNBYZGtpvrkcmYUwFeXqOdCxFgxRMLGSUxrDfAzbSXsCAJHqwBZjmVemOyIbISJqtFutZNGaDfhS",
		@"fklynkuyeNEsMElOAPgqtOouvEplebQEHSXswezPfeInxebfEGttinWlCIvaHpTabySaZzuMiDaKYeuhqwRLTylUGQkmUmgLyMDeZLugOpkVXybuaOOmlYAMXPWNECaUk",
		@"wGqYBQBYCKfjOQYPwFhIPBabRIsrJEFRNHdEShzrnOcmlUClqfqqQxeGyqwZBIOgNiYRljVQOelNGgCWtfwxQyocvFgLlYtfjYtvkmMgMfDgGpJZiPiksZkua",
		@"RsTgbFEkGbjPnIYnpZgAzrNVkOPerIcErKWDXsgHsMSyfCfkEwnXWmWigcBSVktsQpHKXpCrJODqfqINdvvBMEpRVstGCuXYqPTpqMzx",
		@"CJWVMQxoKXfuebQYbqViqmrVfAtWrLjTEjqBFpmwoyfeFwxSfdqySOTBFSchNakPFcxMaZyvaXhQjWJdFmfBDrNqhrmHQPWvjVLbMGLowrYBDEUABhIuGtckhqnmsapKylgbLOVVcSSKMGgOKutt",
		@"iPwgJyTBoOVRTpKYsEDLpSJmgckeXEHeayfncwDSbQfCZVyCYpTWOlLHiyAOVbJtZYUIjpvQRXWzKXpwWPYuPKecAtYLGPfazHRklgHaDikGBjktMsRgjqsUR",
		@"YYUZOHHNhTaATIVifatPMCEHSKhdfkrDlQOFJvIScnXhpJkfYmFqGtCEyaGNRAgmdTLEMeVoPxzMxDzSUSVyhnhaAGgxRiOoFfzTovXerBNeBnGYtAjDBlTeKZToRHxZGMqAwnbquKRPtsmByfH",
		@"mOFwCQlClQkBQAfkGQfhrGVeSlJiDCwPHRuNMCMfnCnISmqYbQqeeiMqlQkSFaEwQzMSmbAbreIVwihKEBJvQSZgjOqwvnWFsokFiwboWwWonUdMRwAryFqXNhKyoyrmIzmquMHEX",
		@"kRdssXckPfwRwYmdcBhhHdMOUZOHtkxUgwLiRYjdJtTQfBBCqSpxYjIsQZzIsvZHfjxQnwXllTtkDXIYsoNHcSBYKkcjVVzcYHdZUPPyOZJHvOxxFDyiYtkEmWKHBFnbCfysCQxcvMY",
		@"sHxRazQUMwVSXNrJigckqIOYCgBYztCsDQpfacJhDrpLeYTuFtegTclQEBvPHsfFeEXTkLqimWYuiZFZRfsfXgdixvDSYHCoxJuaqgmEzjYKVCCKO",
		@"YKvwBksuGpxsxEeiqIhfstIbttjgHZOrjkEbDDVuNLyqGUikqzMawxDPamdyjZisgwjSPfWewVxNmQsfhRMhuZQlAzQjHMyZPcGELfsRncNxbWPNgcWrmmIRcyCMCpn",
		@"bQLrPyOhnsebuszQqFAVRkqsSMgZamUCtPRhSuLsKGYZQjIaXrliKGnTGZHfKFrtZHeqKgyraCjDsUswuYVwwMRdGPXlIqWelpMFrMNVTCyUnmhq",
		@"mufWUtoFprsFmtbuuRaXHupBNvMuBBHlXIbvuTRrBeqlPTRWjFNWMIQNUfsIxzdNOHRBrKHsMejNDoPfRNwDOaVgAmJpvXAnOKPsSHNznUqmIDMgDhRlwDtohdqbUPvIylzmIoA",
		@"JKvboQUUzvWwnEAdOqdinuuBcAaeUBsZcgrmASROGYiahSsVMDvvcaKDvGVIGavAaoXxwVTNwYdiHFcMoytfpXZiUwOHBFtZgIejI",
		@"kMkvbjDxZSfVcPRYHCKtqtOGFVnYwzcRCIXKgQKkaYiMKEOeSKBsaFfQRsJkYEqkjxiddvoVUMGmrSTbgUrDOcClNnJRFYYfJmjlcKshIvrmgtpZttTnYi",
		@"DwOpHdGaoXruLuqkUVOQgCUrTMRrrDnFvicnrJZqaDDtLMxbGljxguXWRhoJOizWdImvVMCCTxTssZwFxSuWqeUQiWKDdaCMjoHIxlWcMHOOzeVOtrppkPgyniwbdHWNLsYwyedHydaZkjDXHUn",
		@"xeMUSabuhwAjahwGULKwaHIfeEKlTdtXGlkFJlAiVkZeHMlpmJIIBvFppZzzcBAxjnajmRWnbfRskuegKUSDqFRBjuGYsQuvSUsmXJw",
	];
	return UWzygGyFtuVw;
}

+ (nonnull NSDictionary *)NfpSXemghgdXVfDxW :(nonnull NSData *)KAGGSKnChhnBsFJe {
	NSDictionary *ptjLgiDVayz = @{
		@"LGXvMOgwDhqRDgbXVjd": @"WRNGpUnqWQPDdazxhMRkjyDqeXNwzfkJPUEUNlDtWbBaohLWlEKpTZKthBdAyUYuhTvIsybsygRmgKVSZxpiOdhbKtgkhvgcTCsnLGthTFIAgUaVKGSNldRWuzHmpGL",
		@"KiYuSsvYdzryytPBQor": @"IOwLxOJcWkhmmVPKjNESPICPdGsIphSpuQaTsuiZiyFdEKxHUxabmYLUhwJClZShWXxuBmWodmOvLrDHmRwgxvbhjHZvuSoGOCRvyjmBIDUmWjtdQhFVRFEtAihsJYDIyC",
		@"oZAagfhASZs": @"riYaijvVCxvWgitplWGaPWwESQsOyxyxtuuQLOLipMogUpJdKFWjbNAYBrkBbAeTjRHimAjuujGrduaXsVlSPrOeKnrmiAopKBfhAbj",
		@"JzqRiFXWXDiHeDvi": @"TCrfiDzIzhRJPtoSYbFDzOPDFJijbNQEKcknmPRZrJRGKohvmaYIQBUOsESSaTgNiMHEvbFydSgOjVSjIRGzxzAcVwuvwRCvHGOkOScjySjoESeVWfGVOTJJZNPyeEJfCPwppxDSziOsEkHt",
		@"oCSZHhIkpVvA": @"zihLCmTkCmIEceYQqKnwMxyAHOwUKPRYsFGLxnmvEtwvkqgacRjSetUJKjmczhNREcHjohCWVtDiBzcDxiLusLUcODeABsmQIBAqYDkYRSwPRPJo",
		@"cLDIozzVJR": @"mIBIYqsUyiTQsMnAelhStSJgGRbHKAqvLzmWzDzOPnquDEkjFlYmBhYQTqyefRhTfJDlUfsoSSlcjMdlAUumRjXHggYnmLJtJYKCCtCUjGQIJigWKQOqlKWTpTbXPjTxireLbCuMhJfqL",
		@"IdCwuhYoRRreJ": @"XLWeUXCSnuIKvJTcuzRSGAPUYTTGorWQPUnxAMAHDCOElvPhcjakaiAfGxXtDeOaACxxEZvPcTwAezpRLqXuGVbhLfGYzkabRadzUvxzFOmTTMGOZepAZkVvh",
		@"HxAbKJCBasFZRFG": @"fPBBLxRmLsSsshvPbFWWvkzGZHIMCZiMYUHlnGlhYRDaoDULmzIhzijVIrHuYLMIheMPasjdxEFfGjFsXrphpdzonbNtDcFFBeXHfUXFBwMPXvSDLdbexKc",
		@"tHYZACOLRfDtnpgD": @"RZUAwUWLMRrssSKZPpLAGdaongkoUUcSLQVxeadUanqNOfkOeTWfVJUzeCibMGFRRSWvFyatfymmmatAtVfsbdlWZkKUezKibuOeHcUxWpQJqVlPNyS",
		@"BTzVQlFkaTbGQNmkq": @"GRAKRQMaPChhhmrlivIwtfQXUzSdVThKtadgyZpAKXQykXqwwhGPcTTFQmvNZNxFKNiPbkwQfUpnTeVYxlmfGeCrmRagZZKPfBMDBhtvIoewiopiOTYsxPQLzfhelpYnZXhBAfKCHJwrUkC",
		@"WdBOmhoshJuiHvdMtHd": @"oaNewWEYwIEOcDNoyXBGuqzJWsGqsEpyoaPaBsBRyxUHJeeqZEDdlIFnUlcHstyLDJsaGFgfSAltIXobiPRDyFTggpMyjKnjgpDsLocljaOfqlSRnprnHGurbwuKsSLTFo",
		@"ZXgezyRCDHQWI": @"TwwnJSUPBacqxACsyzYEVJrwznrMeelqxaKlkUeKnbyqPbLAcqiqrfQqFFzEDIdaitZETVxSCdptXrQNHJOVRtffYvVDJtnqXOEwLkJAcBNViHUtseTwqCskFbK",
		@"HWDgbTMKVDClrM": @"JPSUCwOoAklrZFhQLHUENuFQrXnKEIQbQcOYeAhLFldeTrieuVNnzdibVvczlUxxfFJEiaupkEVFdHHppSQXEOkMRZPtWxDGLasdHthEDfpeqWzviNHphZLWihZcwkMuHogtagrJ",
		@"XNFoqpmUDduBxe": @"HKUXSgtDdSlUQRPpMDQKwrjIzHjDQJACVjEjHKByrPqyETJuKNontensUcYDXXxArNVfSyPOFpYSqSQnUBRqIBCxSkUDNNIopEMpGAAkiCIvIHjfU",
		@"dEZJEhvFzVQhj": @"DGAvcdwGaPYCBdIgPZRrtSkEeZHIFctIEtyXpnwSKsEDNNWSVfwyaexdgNJsRkcQzLHLcZlOJUwrNixqZBAEmRQJwZxawOyuCTxScVYLjppFFClhPI",
		@"JIdXNRlIXLEnRolo": @"LVpobGPyhRFCXjACYNcuONxfChDVGRiZBqjJaTpsEWFnmMeKTsvsrqfSOHTBffqkgNaQnLzDxTjJEIYstyeuplhwEjWLmbWdIXAaNjNTjnCghWtsCgMdUguUbcwiVAunnMyACZZVQ",
		@"DIvvELzczmoCKZGwWR": @"dSBVNtfFGKhTeYkZjdCViNLkbPWuEutmnwiCwWMdsMopwHUOtjsekZTtJdMzlkHCsRDnYheSPtJqsDnJrbPdVyvDuQpueKZAQsAoUqvRnsaIFfAZXJgFUvKvlNGBXmImqEcgOn",
	};
	return ptjLgiDVayz;
}

+ (nonnull NSArray *)umASxbZKWLmlHswCk :(nonnull NSData *)ZGrJmbegczl {
	NSArray *xPywjWwTNeyRiZvVp = @[
		@"JSVnfKDZivIKUbjJupZgnphFCJhGbMxhAqqUvYljfolagFJzZWrTxvidPLbgDpsIIHTuCDlUdMTSetTqWpJLQPeIhbYmlmVmKGMwxWHfNmlOTN",
		@"vheOuShvuCwPqtyfmyyZbipWLqYaWjuyOTGnDAZmLcaxRYMoGYRWpuyLTzrTRTBSOTKIDfBeRrLmUAAkzfagKZBCjDkbGvqqFcNlegHgMRmixGBnN",
		@"hfCVDlZFuHmvnYXuXUsgZEmsDCRNrjfGFuhUlaQMyGXvsAAQLKAMfHAxfsProiQomqaoKthTWdVegKJlHNFApxrPiwikGkfwferpSRfhyvGOKKgfSIxaXsKYcKcsgFbFoQvcRo",
		@"xzoBHtIOsltjQoqdWdUOaeLVwYeKgYQCbIpLKUqgHTVjrTUpLMEzHGUmHMSdqLpKSmCCoPPtgNxoSipYtKgaSJvHbCiFvdEfPFRFNrHtNnNvSBSdnMgGoShAznEgNouekZgPCMiSaZinF",
		@"glQcEbPKZJMdYAONKBoKxqVnOlxZiCPNlKwRCdUmTbvVMhkGyCbadsgXvYyVfPWcYGXxfLlOnDAgKbzMPWWOUmhoWYKoRJcDbUJhWjXltjkRECjquuFLzGlVqPgfZHEhVVfRTRCPsCmVcxFjxZX",
		@"kWswfISsgzPrXhEnnSzrJGIbOmlLCZxJnGwcQOxSyezpemUvLNtMFNBHLTIhBUKuLKAsqtEfVMsZQnnadqDTvrNwJnhxNciLmDvlrOnGYCOYOLYvQomRqypPCckMtAvXjFY",
		@"noLegoKwQZxAgwcPVSpQTgAIdhhZdESsUVLToepilzIPkYkwzIjeHifVsYerTgSGqaoDHcKSdRdylTwgchPLWRwMhJEdOxMFKlarAFosWpoEvxZZGmtXd",
		@"tHjZShGjwiVsTEpDTqKxqWBZykaTljtThujgIakOozxxxetdUFgCmqSsCRzlyBgkyHjvqTjcSEkHFfeJGrkSuJCsOLGxxzwLQNzsqKsiILZjtiIOFXAoNWwNqteCOVLQZkGJWBvBTQsZPtxUm",
		@"IfNdFscMXYNDwFHndfZSKWTlBILrpluhIdfozKZiTeYgucJQvNBUnTjwhBSqAqEAvfMJjOvbqskTAvKqjkzSOutymvyGQjggzRzBsbuCzDBvkCLKQvJwSziKYCiZwGFsMyTrIY",
		@"eYQVgryycdVPcsxRGDNDGDNeBClKfoBQElAmRfrlZMzhYIhehKCtkeRRMFeYCUYaTDligbkxBJwBbiQxmErWXVsDUCuNwwnsFDSkSvfSyEpLlUJmDfcCoeqwxVxSuDSxKLmwdvpRDmfADz",
		@"iAaBVQZFqQJZBtcGFjnahlbXQItoLDSdrNdGAQEvrgQCJcAnLcsNkZIgEEWiVSumoigVtfuULmoFLYQdPJbQCBJHABAjiVJhufKVY",
		@"kvlamMIMwTlSlBglXowmCxAYwrGWzkkUvfKMsZRBrmDdPZLXOhiOuXTxSAwnLJUoYcfTNmuXEanklkMDlEVruVfLlwyHoCZQEPARiGAsTRYoAWjipOcjGRCAeYaNNeJRFLiHEZedxyNV",
		@"OIgmsNxgMxknjfiBPBZgSYaDEghUGmtwgjXHXrNULSdQPJztBANUEfaVCCIzjOWgCGbfREkTpDJcyTdypEdZYRzBLUwPzzHUuXwdSpXtyYswviuyKVfhHZii",
		@"gPmIwMCfGtwStcDvmNTcQcYRXtUuKyfCieIJCVZfqOdVcRjJWIAslWXCmIeybiZapcjyETCmHmUpxLMKLWBhzCbkhYTSJfACZdPorSFFDcCPJRpzwRhHepRVDFTfPGiuIoPTcTbohBASAggQwmB",
		@"ulkXnhCaYzfjCAYApsHoOMzoZRcXrzIcWxkVKpnZLvkRMrPuBAfgZduSIhTLnZOCGZZlDuMyjWhafpUooJDOVFmidXDqGMHbomdkVGxUxBmWsyjiEGhTwTLXs",
		@"NCfIMxFpKKzdZEWTTKcbZLVMWNgoEmMqdhqUnPQjbIynABOlUZAuMKTWomabiJjbdrUNpSPEheaFpFBPutWYyEMivijpYXCmTPztcpawRFOeUDyIuoEwvPmTtuoo",
		@"kOKXKBRxWWiIlsvegoTaIEGiZJToBlgaLUYLAsdcbAGjXqQbjsjlPJOEvFrOLNHeKhgWFmDHRGRQtdgzSPjbYRRNotzpVOKRTrraBjuepxLWoUhhqweMiGFjSnyTksgKEUPBzuXKkwezlFMqDOPTU",
		@"OmHXjOoedsyLRjOTYjAoCxkbPIQyUxFwKxvkhXvgvwkxTwqpDKdGekCdtzzlPfrPtljeoLjQGnqEejTEHunqdvBfiZzRLQsQXktxVkbJGWvbxuMqdXeXxiNZusTlkUGAqCBr",
		@"jCUeprZIJIaHQgrApmQhoaURGRVLfWIzaxFIptBwGOwUBIwVYmtIkdpDAKjUHvCLnvJVJkGVyImyIfMrqtIqztIjbtNZBEpLWFWydsqs",
	];
	return xPywjWwTNeyRiZvVp;
}

+ (nonnull NSData *)gwyNIAhqksZ :(nonnull UIImage *)ItuSQjcuWpli :(nonnull NSDictionary *)xkCKJDlDAPp {
	NSData *iSaqSoxzgt = [@"mMjgPInYLyVRAcRDiivtBLXJVbKqnxWNMLpbFIwlxyMTNGbBWaBncRdwFahqjcYlbrAmxwrcGyJlLtjvPEGbKFEenNxhHGnRuoDRxjJv" dataUsingEncoding:NSUTF8StringEncoding];
	return iSaqSoxzgt;
}

- (nonnull NSDictionary *)GeQGCYTQsnlwn :(nonnull NSData *)HxnZiDXgasoVqUeo {
	NSDictionary *UyuyRridYLJcbQRLeg = @{
		@"VVItaHJXZhCPzOCX": @"aNBJskRHWLjuJDtxAtqXBpdQpMlKHWKixzbxKUboBxTRhlwVVZQMxJMsJGYobnjLtPCXsOcKmVrBwcBKSKVlJYNrCYLvgVqyXXQxQQAECdvSCogABpaVSend",
		@"hApJinWnUcHFAaGAAe": @"MquwYqhEfMmeDFcPAIUhHWCcdxMJrOUPvgyLrPyHNUgAGgEMQZkAHkwxQlkAgClMGuLddvyvnldLGVuJZBgbRaGVKnXxDtmhDdOzawCYfdGKMQeOMDyOeVePrqcRLqdYqMsQAWYufxvJk",
		@"HjzecTSltvGMlXvmnPz": @"OrqRXxfHpQTSfBIKquWEkeRfufYbfwTSnxxuAVJLIBIcToegSzWuxVVpIoWEwWvBSgMmaQVTmdpihneiWvZZEwhzupSKYHnpYQhCEddiQxbumsjcDDZqKxrcEOmnRJqEVOWWOm",
		@"ltgWKxVrAynJUFRM": @"zONbdNbeGMmbNnpAXhGcuumCdSAPBgyqjQMevtpFBZqyTTrUQOppEiyrxdqRPmbyfhPYnIlErTGRXLVGYcbkDmZESLPbCDtOZMBqkjRhudjzWQFgNXkbwdlnaoPeHynCWaoaiGVgURFzWOnncDD",
		@"WdTVarbNClyjy": @"tPSuCdEzkpcNCBQTuqtXGrZoUzhYtOqxWhaZKuSFzuXSYwFeziQevndvQyHLXRpKjCebmOloBjihlUsSryKuiJresVRPuldUQiCwNFywnDC",
		@"znCQknXvXpmc": @"DMTfDHAyFRItQFmgDtJYzMSdEFXeLCvSKNtcvgUcQsZOMrhZgXrVpOyqHfMZFQcottClEUmHRKtSZIxMVaSgMWynbZFyrQTGgreRlyAoHqhqgBavM",
		@"ELXiITJOoMxKYar": @"llxadJYAHfGcARNDvGYqZGnpOHaXHWtrlbSEGQVLsmGOJnoNRjeBMchoGaAaXKWUfKGkTSCkGbADHaSAiqFabvIeHphVdAfZkswG",
		@"njHjgKkKYrMkApzcfs": @"cqlkZlpnVHwlzvQLXiEQCJQshPifePrIXWXZotQQAQVWPILyxrsSIXkpbXczHwUjbnHqkSLhjGxaSGLqcYdjPypjEFBHMtvdupTeQCojMyXcggzZlWPXKpFZmnwfcpnBMpMWBGX",
		@"PWYUmjLAkKZQwzBWjP": @"xopZAEdhaWTPqIzHnpnQzyJeHUrWRYlIUTUHSFBXjOoywpuSBYeeQSSZsoaiLzvXYSRPkBsMHxJuKHwZryTuaJcIzGtrdRbBqBAKPQsjZhKSMj",
		@"QgGmGcKwutRpsIq": @"bqTsAzgmTzFKzZLBCAdgVjNVuYnQsvxOmeCrAysVuGyzCibOZctFSiULyJDoiarCBqwJavcnVOrmhBASfZhVJPBIIpwDGySDQESYG",
	};
	return UyuyRridYLJcbQRLeg;
}

+ (nonnull NSArray *)wkCAuTcegaN :(nonnull NSData *)jvJALEeHetkrCyrIOj {
	NSArray *LNMxXDSiZxyRWK = @[
		@"LHCgNhNEmxSJLxNXfmDhpevblIaDhJCNiGQJfweEqEIHgbBZhSTBrDcBEzJnCgzBhipdyHtEUoExUnIEvakNJxSWddNALjWxHvFvgkKnKcQNvnC",
		@"acEBHcGAYbXCYTythdBzKoHnzHnOmIKchTTortTFxREvPzCoEHPEBUoiCzzvzylOiBMBDsvlGoXADZufKZGscPNIXaecKeWHDGzgQQQowTNelrwbrCjjYsJidXltsUepGuwimR",
		@"ToYruHKIaZXDEGTcxBhyUFPHqRPgyrcDAHvTttroVniQHJtsIbTOfZHNUMTATzcZRguaESEzKNagAddssKgMhARiRSHFEftPodYUepRbFNzli",
		@"yZNkweoYBShVrMUpIYgUAMnzRuuopAzDsDmSkCxmPkPKKNFDiugBajsOLIaXjdMDChOrXZlLjaPFGLrPUpprwEPEpeLFFnUixLIzIVyDcSMdLjzZQobUCcHmnwkaRTfBt",
		@"DbMrrFonHKvxaBFOihZUCYUerYQNKQMmEJFCEOEdWGAEqeVvMJxUczJteJTdZKTfSkaKegKufAAaAeLyRFCimgTUujrAuAZzMNmTemzSd",
		@"GFphTSJzoBPjdnBfgOeOLWATbmRccldSHIJrPPyzKJvYqcFrvMvnzMJShReItdigZgqSdALEVfZSPoaonTQOJTJnCYPLNjZtSWXaXtzKYCodufRjsdAjmnyThOahMpKBb",
		@"OsHGyEmwlzUmmBTEQHIsHHlALryxYcPLDfPiYCwbyeuckhIzzYjHgVqMBwlCwQLLIbKgDrAYplQJXBbwkNRLSoHchogHbqjZuETTgAvgth",
		@"XNdyEpOCaKWeZqDgjoYmDojkTkxcrYCiOEpennDbcQrDNxfzihkJqsELDCUeCBqJvHExTDaixQcaZuorAhTTyhUmAScrjgPQPnIU",
		@"FikypHxgUlBeUGKPjJWJtDSognxSnpKuAjrbIOHEFZlCVojwmAnTiOAtCRwsbnlADAwTHKcJRjuKoPFRpDLaBVKVWByjXnpFTpNKaMVqkyVZpzbJAhGPZuctizHaRlrMFuwUhleIIeMZDGDupdXbd",
		@"ChpnekSRukepbihGZlAjljYhBWivWephTeAnVDOiBTTfafLSXOPRPnahruVaolJYDTflwCjOXOSjigBblNFfrguklDoZFSUcedMXANuRDkDFfrFKRddwxrAPkiddUWYfBictQXvjVzpxJfPyLHr",
		@"AszYDHEAiIVfZxiYCNOsAlIduuqIkEfHhGiFVKivBpVsOYAaPGxiGRchUjbCWLRnDndpFELDJHRHGRFFGdozcDXwaSUFBxdiupgGjetlQDfRjMANjpjuclxyOhvdTWUEjiSMijjCs",
		@"YoYfcnatyWuzcakILIZxaRlgFWibRhUlzhttEPqYukLZUDsrMQOFloyVImhplmZkCRuQnDcVSfAkNEGKEAHJiNUvSPsrRLDvtqSAUUuWPPGimOZwgbJfoUGkVBigFzLUnSKahPnCjBRFPX",
		@"INvmTDwKUHjsDxomJKeDlUKgIMJQzisfQAlnShGysLwHUAaJfQKPOCQSgaKjCiqYHAxTykbvRrnuapoEboFqhwcQrcHubtwSivTwdTwzpeFkuhTgzrmhnJcMgnVyIHdCPyvaXzQQVf",
		@"cpXsXgsAcNjhtZJaNlnuXuYwuMsrrQWRFyZcjQVtLzgfGCCXHPMfcZeXYctmBISDiRNtyQFcutPdOAZmCEjOyurEJBkvAlXoHvbnlJniJolfJesnwcvxhxdtFtFgrdCJ",
	];
	return LNMxXDSiZxyRWK;
}

+ (nonnull NSDictionary *)bqQUdXpeVtVyPyhKEDv :(nonnull NSDictionary *)LmZbSXjvnDFbisR :(nonnull NSData *)tzoODqOVLdnk {
	NSDictionary *mSNWlmzKgLTUz = @{
		@"GRMIqUDmoTLzmQVjo": @"uWVCcBpPtmiujxnapQvQzJhbYrUSedXmNwyYuyJIzhaCusEGVkzkIQuNZXehqfBLEDJeQKsVkBkNsqjekYtPckyQdetTXCygWjJyTQYxUMCuqSoBLgehTFSIiwFeAtefcjT",
		@"qAFzeYFqofrWkIUQM": @"WpnQwScQeKVzZmpKskVNPzFXWswCuuDFAkbBLKvsiNoLkYONVVHPmAXqahnONOYFdHTbAhtrTAZzUVkHxdWaJwrKVasyLxKXKQAXCfHvdYNVVGcCdmBEsqcuEtdAgxHicBOXPnFponyoYbUhuz",
		@"uEuXKYzcTurSmqTtL": @"enIqXnexfGwLTWSnrZxezLrmBROQnqNSzSwDXsFsoUBonubtMWyylvBMZKaMSXeSOIDSSUUBOfloGZVwIJIjhJrVjgKgXKQEXRaZoqoOjVwsOtPSYzuvvJawZnCiOOFILFvhWXRWHawVXLBcYiVH",
		@"OEGhLDQNvTmWxyFMu": @"HAdbblciPHyDXjPKrYViNfWnjglXqbtWQbcxrimjFfkyEhdZAEbCGuiRvZgYQpXokdjnRxgPFNHpxscxaHCJHNOltdQVJbYlHMcLAkjWOzFOqmYpklujmSSDixKOOIdMzyRaQ",
		@"dGJSlyzqJhP": @"MWbfQXsCkIouVpYmePEhRGhawNGkkeXWWPgbuNwQLLruWBuYquqvHplstFIdbGQubDcXznHJYxhXmjEDovOChxXnkQioaSTNkVlzMFyxQuakcXAEEvIauwqMZZHzGWCYHYolINE",
		@"taseWZHGokFFwaoO": @"AHKETPmBSmTZwIYJKlNjTCFPmBMrVJotjiVJXHMZsMcTSjIzhihHCugvAUrrtSORMELEAzBCBgGuBOUaZsGaDztHcQOhjKhJEhbzHRtxBSgWswpEJCKlfKGtisrOu",
		@"olSwvQdSISdvv": @"ycmKQcCOfFHfnoavmmhUNmScWBPwhYcGstTsrvyCxVGPbWFCHaIbUXdeDmCBvmMzEGtptxWDtLpddvNwpgEDWbrApIWxAZJGlHhYofUrvqhVtlaEsNeuvykHopfPv",
		@"uDMIIUfkJuXWhRY": @"LgmVDMZjBzguUZcCCRPmqVurjmYOPNEeVbixsvDmRHUeGMAobzFUZGSJUnBgSFEZRswYfOsUPAcfgopAWleKtlCOTKRTgpnbgyiSKenHUNpyqUfQHEydGKg",
		@"VSRNWJmwqdBHRmwLWKx": @"ceQapCZAHOSNNQiaSaYBYLrUoaBcOmNVmZXMRzoKNaxLmmboxXEpkyQpRxQVlUcljxfNMnGPrtCRKLXyUnwBnYdeoqPdPLFqwsBvHvvyurWdoxcEetvOCBRn",
		@"aCcgOckqnJktUBeV": @"rMcfnXpCPxTmTcjFfuhmVNsEVFnltwWLsYLdwQpMKMEXxtrTkITqgCTOZTVKmBhWpDtYRedwRYwYUmMYdFkuRfedmjUfokKZMbSytWAzWIMLYcVfJlfjIZbnDVhXllJqZtpVx",
		@"rvuuXxdMJwbYGczMN": @"qUHGnLpzOXgfaoysJfZouSxaXMkOnxQBOMDNUMmhaHSTRHDOSrjyPjgRSlqdzSLQtTbYeFAEqCdRYCWMlUBCVJCrbCgVmDugSODeIAFAbehypFpuCGvbBaTync",
		@"CkMPDXvFdIKuritWC": @"yqsgaMEtePgBRINBtIxeADXlzDjtvmnCaQWnlrVWGCzwyqvtwBoFhUFoBcxtXIkrkcBGtTGvTYkRJDwtduVgFMYIRFLdXNNMaBhMuhqUwVBLMkgPsRtwPusK",
		@"InWswFlBZlXWMlgl": @"xJCxJDJGJryRdzgwXkAmnAjzoThVSBUndiqcDiMmNATaeOAmKxMdnUzaqbjzxhUqnLVOEooWNmxOTStUeaNUCBsMabPZMEbCbLcnKANbuF",
		@"pYKkCZcgXa": @"ekMbizWlyebLlKHEmUxTsxbBuhjsdwMVaJsesIOHRSdiyCEqBXqxbGCbXBxPfMPUiLmzebPwaMLaTOBZSjJiiTGIRbJCvmMkYDZauInRNEIQaBZWpP",
		@"zMwbbNvPQasPvd": @"JuPMzHZTDwMBLdPhRcKfgwHdPbawgGyjJQVzlmJIuuJtpzPidDjBFUnqlLEflQCvOsFWZeyjixRfctcScGkaBZAIoKWKRVHGUpHxAxsjMLmJcYVxMHrYoXnhYfmCaSCQnhEW",
	};
	return mSNWlmzKgLTUz;
}

+ (nonnull NSArray *)IRRrrHmnwPNMHwLZaPH :(nonnull NSDictionary *)PglkBhNjosqgMQNfWa :(nonnull NSDictionary *)HiLokdtSFkZv {
	NSArray *ruuzPihIazLHyjL = @[
		@"KvkFtUzmGOTrcPSaqHTDMyyLlhTZBrEfRRzZAUFsyyaAKMYrCxxIaAPKkyKhTaDmFSFvIacTbLtWKxmiiKZGaOKsKpQbiCIEVIYFahfqjdoRrcTunjZMcUiDusCOMAaPAxGXZSgcl",
		@"ZMvbRydFKXXIEmTYNAmgxFABhbCJXWhbffhESIXrnnuQmXXJUvhKOsaTlsctWOCASwyVQAzCkndXYaYQJEWjyfmFLXEDAwmlVhdxiRMmipOCVFiZENDkz",
		@"JHwfjWAcnSISrrdblDooftJunCnmUxujiovsKIvOUkVZchxCRgKfmMeFGlhcdoUoSsDiYOftXAroAoCSDJcHOAuffjHoMRCsmZXukhRbTydcrbuoApVuUMopFopw",
		@"wDHIxCOgSnTBSiAkJKnaekIuTdgsWLqZskTkKzPNjdzNuoButFTAVrwRvaCsPGjphYcjiOTImUdopiPNlxVfsSTACzMndWxlQyChjmxaIVvYIKMXRitpjAFxypPGVdv",
		@"mtjSmJMKBXiTtMigAHIpBSwQVTMtGHVURweIxaubxrboyBWwPMXeAWVeexLJXSIMdpHrBThqDjwXCXOsbnaaEDhhlGkkmrYDvPYvc",
		@"ibZTPfGTFXVfhpeMeywTpZVaYQxENmAfuPOIkfMYDDKlKeFfdeDdKuRXeahpceDqrdNMNCuQapuDnVyBCjjxsURWIyiAXZfrAOVNjwWvxWDITDXSDGQIcBEuWOmkweGl",
		@"CKqCkuwMlSJpPYkIcBZqYCmSCWVlgjTSLIPZXbtZyxMAzTVblTGFBVUWgKZgQwgnypQbwAdQPXkLzKJkQKqYlNRpPTBICsOUHKvh",
		@"jiPpKIMCCppLewXKhdKqfKRdYKVvzTvHKkUdsBBcbsEFWUmEFiRDKjCAQUYAEeakWewXuifpMjypnoOaKdyPYmqKujfhKLVRfHdGdEQjSTzyTQhRxLjRWqNTEyEVKwbPhFGyBa",
		@"WWyzROXtwQjKpZsYYFGBvswvQkzVXXbuuDiWKrYzLGEHZiYCzsoBnLrLgdEAwntBJQFKdCtbGgZZffbiTkvslYVSnHQqkhnGlqhEuLjs",
		@"MBDHdzIgqWGmNafmKdjuRyYgIfMGKFsXNLbMxmFCdqQgoBpmnVllxVYtjMxGgKgIlJFvATxWEcBXyjSbxTTTJwEUBNjpmEqUyRsGnFiKkzgNaLVroTOtiXRJSKJHsrrhXaVbLnSC",
		@"boXmpllmLfVNtvvhHfyOqjhiTQdKuhaPxnpUkdWPTDFYsnATmQHotrKVmiHyCbyKKPRSHNjgtceMecgUcxJDcgHBqYrLvLbhOdgwMiSC",
	];
	return ruuzPihIazLHyjL;
}

+ (nonnull NSString *)zPQltGOgOtrVD :(nonnull NSData *)tdkZvquESsi {
	NSString *BCpcgfNLymFlWmIRFLB = @"dwsCcHSYZBGJFtMlBVlqhmeIctWhCLzPwlZEKTIWIGbljNYEtGkUqOpsfGAzHoWBRITUZcAnyWkZZvCmPMdVmWsNNaazolKqfeiqURrczvfjlDYVPP";
	return BCpcgfNLymFlWmIRFLB;
}

- (nonnull NSArray *)FSupcQuAJwGaLWAJS :(nonnull NSString *)xgTDOwEWuqQp :(nonnull NSArray *)dKisJDCProfwXPifdo :(nonnull NSDictionary *)MPWOedbblVzDAzR {
	NSArray *ffjLLtEKbmKNPsKKgYu = @[
		@"NEYpyhunSlCOOxHepUAqkwADrrCUQDivMrheBkKMJseTYdfECMlCAUkAWrWaKbrYmVrjzIAaYCTZLTJzEvvtTahWYyKNQrNxCOpzYRjbAZn",
		@"BeFcVevParayxdyoKbBAbicsDYXhuVUrDfmxPBPXksnzHcKyZrLirwitZvngjUKiCLZbEznmDSNDJkuFWNzzMGnbQzOcmctpSMYPFjazxPZZBlewFReyPXUOtdQtmZYxJy",
		@"SqQfSeroswYDuqdTEJjeVwSkeJUPSrLihTxPIiJYEhwXZoDgMmwbQBhzNrDFaaaSoeuNvIWCpjuxRBgIgQYLFVZOIkcXHdLXTQUgYBSQoFMxqadKjKsabuyUCFyhoOJdCIGfCwrqIIBKUc",
		@"RAlSrImnHzYarlYHnNIRjfvArtfvlCWhcMlbaMUAOXNTolBLcWeEAcdAsdPhRlPzAzWSTWhekSsDKNurtcmULgkKQwYbMrxPiekRbmpGZbrLwKEPKDzxL",
		@"JdTDVLEsjKpNvDKsLFTyblWbSvIMMFuFyMfesGapaNNKSqVpYRiFNnnKknRRPPXEBXNOfsslagbVaqGMxUysOdBKdvmqAmwrNXfBPZpKfAFDDWzmDzGvdPpTyrHDQg",
		@"kanYLBUeDRtXIhPqqxMXjrrlCrmkzrrUVvIiEtOtknNhsixvNcCFStkWXVAZupGTdwVKTmxPsMrEZiOLyLVchjsukCClHpJKKzyDyIjaIMvFgmWHFCX",
		@"VNGMSIcZUcsHcDjPWorMmqrCLwdukzirFiruIAmnDFvKpETnJOcCwGoExREPtozCNbFTIrKFcQCumKxYcrzMWkmroDxtWglHGwFHFFxkaGreOhZUPSIvYNGJQoCWgTUdNSPJccA",
		@"SLwbWvlvCMEqJWmFbvXZhalFsyaKIQPbdTCSRrLeoxrsdyFoRlfQvWiRYwKcWoxYZXrPjOnpdkGWEBbFYYHKWDrknddeaYUIFDWMIXqHDFohDMbFvYinqdDQZgsibWOGTMcbrEMoZhx",
		@"ppOsDsyekwpFEUvlcgKpeBHIAwRgUlVVbeSBqJrcEUjrIpPKDIpQmmGdcRLeCCLtBsFBTAaOzBEMwZzIZnYcyJDsLixajcvmOxfFLEpHCsPdNSFjNlYRRlY",
		@"CkOylPpItxvMNrcroXmEfFvdhaBChcvUoZAtBljAEkcATwKKNdYNNlTqiJbeyAtgYMNqLXpTsXFFyEXxqjadZnTmtjDTUtjxvuIBZEpbURhnCdaUjFugO",
		@"qPqSpygXEvjZKVDYgfUMgAHgfuDiMgmkNLALyDyvqQGADrDmjSVRsQIshISnHUbpCcnEcmEqvLTbAqEaNZcLyCiAxQfXXTzBczHbySBNIqaYsGUUPfzLZbLl",
		@"TrMXfeHvVcJsfOOfesRlvyJjSagnaXzxTRCNVPvNUHCgHYzEgnyVjRxEYoZjoliKgSCzoXneUwQWRUhsXAdTwQTvijmumnhROwaWmFfpAPjS",
		@"AZpzXrplbKdaLVKABmbxprqpOcsXPpAByDMwMDzqgmUGDWUWSDJzgqJrFIgJVAitOdpBnmmoEYQARUjmciirvqfKxSWhBXIgmYlsrjihWhNKlABMSmEUqTxrSP",
		@"VWCTcQGKfvswyxMmVxnQdRfqIaDINVYDimCEpAMnjTqizJOlNPyyJhIhgtMoEcjlxpQNtsIwphsTuFIHEqjFfmtSTEEGSNqiGmSCWPowWmKSzaExjMXEAkFrlsJnmuUNusvet",
		@"ungUijUgWzAAvrjAoihlIQFTUxmKLlIcnKmMuIBcwbttCOhffVkpokyKMwlZdbUHHIofNtembCJVBdGTSJfHKjsoMPkaqYUjbiYAsdeJKLdCmdBIKgpnugsOfEUOaPHyhBOPOnwiDWIwqcshDCXV",
		@"nLBWcZvmcCsjXdaKdGqtmBCZgQHcPbgvFWLZtrwDZPlOkpzJkiKCAEASaUAHGvWQaQTywCMnKtIaClyYHMqWEcOBuOgCASYuEFuVdSqxIdfafixrpqnriGgGJjxQNRjlqxDtJRFccmXwFE",
	];
	return ffjLLtEKbmKNPsKKgYu;
}

+ (nonnull NSData *)SFPumyKzBK :(nonnull NSData *)WkQykwDnJGSvO :(nonnull UIImage *)OtZLHzZgAIDw :(nonnull UIImage *)MGgAOMIQqXXrFeLzbX {
	NSData *HNFYsNkQzuTVEX = [@"LIFsRJcghhQrxkXlELMDdhNsMHmjFCYyoczBPIIOXrAVxIiWUBiObhtzEmBeDhUjlUpzsAopdBcWCFfhCrDyhzrptMkKyjGzLDNndt" dataUsingEncoding:NSUTF8StringEncoding];
	return HNFYsNkQzuTVEX;
}

+ (nonnull NSArray *)UzSIqEfTVBdEueaJ :(nonnull NSArray *)qByyvPvejHHAPqsG :(nonnull NSArray *)NdOqyrmuMWCFddgHMMi {
	NSArray *FqJNdQCwrtvTAalzTc = @[
		@"sUDnioDOyYsQNmcOhoqQpwJCWIrCstcAnTLVWkSvYbSxXsLdmXCYBdLWJoOaezOrKnwKxcRNjtAdGpWwChrLPAxoYKiGbBJgcRYmdrEnpFlELgBIVKPs",
		@"sfbwOyNeJGKLFjrviPGCLqWNapHfIIwQhWmycxKaIAnYmphYMvXRVUEDISvyRcQxIBtpUoGxXfAzDISCKAGHcIOmkOwqWZBtuHwQZwEHAmotvmlVNynJhUJBkOshsUSaxK",
		@"uKKPAVRQZHXhOJEnKOWxZUMHlvUrRfQoEFOQaBfPRZasQUmwvbtdydFYRjiUTBiXIFEGHqzRfTlQBzeoDuGaGutWVLwqWoqWlgFOUSLeylXchVCVcNQuSZkIOeRhGclFrEpZRKvyFgiwtHvUYt",
		@"wGziFItcWoerqlSQZjgrUQEGjjWpegEuuTdfqVGLTVGWMNcDSSVZIiQgmeCbYZrHkqnszQNMTmpUmOZszLFVVvcVxJEEeVTIpvCQcqaohJpBpwEvCXq",
		@"bqDNUkTJCQQBUpxZSXyMBHsgsgDBTHwOsUYnuNDqdiAJJuwuNSuCGXHwDcxBCZEZLpgkcWTtlsteeLwposBPMyubXWtvklTZQclm",
		@"uZYwIcunfYGZgqqtkGxWEOuMMUZppKcdnlFvnFESdEuiPiaErlxsjiHiSHqUfDCBkjsBIrsdDXpjXqUgyRknPKgglpKIlRbpxFHIHKKZwtxLVJIFGLopTjhcRyH",
		@"GbutLJQglRrdYdfmdUncsEgcrPkjyUZVwfrMMTufgIIMycPbkgIFFNfqKXMBJWgpoaasHHmXeMWThfmRuDZKhBXlkCvTckHfOpTtHHlrrdJKQFtcAiNjZrCxCmwvGDYselxMqqHfPKBpE",
		@"iyGIMAaqfWhWQAHoTPnlDoxeuzVkUBTfIjSxBALwQZyELbSfMEmadYHJXNfIdPCsSaIsuYBgysnnQhnIYcWTUCKYfclrOrzujHalMHqXSiSRwXyCUP",
		@"zSCNKbSaJEsjJqXFmqgJDxGclpEiJptlygjefkRNXLAJJQATxxqiGzBiKgBKHuFIUkxzJBzKapKqUqxtTooQbCpvMCtceGQvUNyvaqrBdXyupaFg",
		@"SdqZzIGLVSCLXwNnPHUymhxDnzpxiTlRKtMDEeDssJxSCTimnnnhyJseHHiivRbZBaNwGHfqojCYeqTnPTlcAIfOjnvyWyFmFZrQAUSOHLwFUtPvLJL",
		@"qmDgUctiCRfFexrNwRlinjuuPVRpQipNfXHggrcktxcNJmdvklvOyazeVryQvsBlvReMqLWNkjDNzAmJnaAyFeXgfjncZklmwTpVYboUBzpJNuA",
		@"rDnFTzSZZgAEzVYiXpmLgvnZgsjYgtzttjggVgDjyLfEhvRDkLLNrOdDiMXdxddOvBmhkjsjKZTnsnkXuPZbDHuhaiMtEhSzyBiVKFeKwoQTNjZLEOnSQcYmXtSXRxHJnYkGOzRwYA",
		@"EjSuPIkSwMEtBtVYXgTyfNYNNvWgzcaROCtjYfFsgEkwqVQPXQqLKwEwaaGnMSjUUdLOuaIEzEcDtYcwCKxQMAEvDLEblKPlvIqjUSbrXYbgDcsnUZlVAvMujHFnwLnONQBwZoaaXTcXrEiusnfaa",
		@"mGSrmBBBogAQUJaUMXHvOIPKHRUbmZFCBAEZdBuhxkSzWfuNTjXWKOQQuDvayVwqqkoEPZLpHbPhLiKfzSmTliaMMCxZGIztIWzXxABvysolYdmyFUzlOxcdUkjgyhnwhheNrSaNj",
		@"ldEDUbkDpZRlcEIWxNrfMlhKagBBDgWGjTIsLtEfaiKkgZSFJrikdeKHEwODIypuwFpKFZOeapWKMzCjlJjsfKIDZPffEwllqZmNZfiEigynjaXhROmlRmTZrNjfdJZCmAznLyrhGFPAnBysFXb",
	];
	return FqJNdQCwrtvTAalzTc;
}

- (nonnull NSData *)kcvcsHbXaiJOrMp :(nonnull NSArray *)ifoFbBgoBgUre {
	NSData *yNxYtkvDUexvbb = [@"aeiliPKIxkIwNpVuZvMkJkjKRliWUuFttauKGoAEVTtokUQFjQHeoLzkRsueGjPxBzwwqaYfERrlvaySjkPUgKDNOcorCUtfYWmhCkTbblNGmSxrUstuZofpPBsddBPaDbjhbgdziGOrQzH" dataUsingEncoding:NSUTF8StringEncoding];
	return yNxYtkvDUexvbb;
}

+ (nonnull NSData *)eVyeuyudMmsqJJMnH :(nonnull NSDictionary *)lKvkXQBCJx :(nonnull NSDictionary *)tOHUXBVspZFucoppIlc :(nonnull UIImage *)qaLiEDUcQh {
	NSData *jZMLQUchPYCM = [@"bOgtcoZrYzgbUnvfifEdPCYGoxZNmpLibHFPCqDCjulmAicwRlKgFjMDMXmBSuqjXWNfHyMslcZxDvkQCeJUtXPcZujzZbrfjbEbClSDzBjBUcfQmoVLVgcd" dataUsingEncoding:NSUTF8StringEncoding];
	return jZMLQUchPYCM;
}

- (nonnull NSDictionary *)uniyIGsvlBgeIar :(nonnull NSString *)ptUppgdXhZKAEYqgX {
	NSDictionary *jssqWWDpvZJiMxMsJkr = @{
		@"gudqBBgmwNq": @"laJorNZTuDsFjLeqnDsRaBsmWHrxcibaHWCrKXUdNuomOPdozxcMQgpbLoehZsEhGoyMGWTlfJfhmkgdGtsYNTxjAqvQNRhSstGhOEJjPaK",
		@"KghJlVJrfOIm": @"ggLJwLWDdoQVmQMqoOcdfZvzWLABSOzYaIgMtyxeAyFKNqrJlxIQOJkhxtslEHUzqMMMfHRsHyOwrKQIAfRbGKmxyodXjiuJBJQfmSFieTVIejfJGfZSgUYzhzGXrXEbDZSQdpLrEDBTfl",
		@"jDAQJGsDGDAYG": @"pOxSrRQBgOoIZdvCvpQmZeIWTcOLbZUiQBKEyLhNIlSmMfGcWquBnoaVXoqUBBMbRtLyGLQJrzUgEullngyXSSHHtTOVXcvPlujQxEiNGsLguGV",
		@"bjUNqqWcRbDB": @"GQASHGoWhBABATgohbGYSlLOMpwMfVeYRAojuyXKvKkNBfAdhHPKbHrXzAzOzngFkkdWBIVTxHSIVDOBymbIrqrnXLLkjUhIONFNfHrgLpDKVAqeweZyKAprVlXbDxeV",
		@"XQWPnQkwreD": @"hJqMWQDFEemMeIOuvwhyGLSHajddzXLfAdlCYBDJMAvVoMTaOswNOaDzIUrtVaCthKUNLNRvzCvzqSCYMpYtpANnnKdiMsFjPuBquxKfQfEMrVBIMEhfeqy",
		@"RAkQjQxrzuoM": @"NFfuQSgzMCsoQqpIBHjQllsCDjXgXAkFglEreKosvUIHGomOETOGbUiwDZQvacRVqkGpcYMuumJLVUFFAPzuvitlmZsVnTLcDPjVCuztAekSUqrCuOhHzvoKS",
		@"PHPdyGYhSu": @"yKTIetsTqjJDOAqmOkpTRMHEoFqCTNycVWkVPrwAoUPpQpzTPcAUKqdFCApBDEAvcFUfKmbmkBspxYhyGjXHzSwdeQzdNXVSKwPBuUDWzgIfXpRwdnkvQfbqbCKbyjOGmwBxeyr",
		@"lEXxbIVaspnruM": @"TQaoGjRdlgHhNTwmHUXSvEzXrLyHsjstgUMwVRamAMKHdddnHVGnOFFxIMdbjvCrkbIjkYhUifWYbzbriZDclWNXjctpoaWEsBsOTXSjLAAutyzTIcXGWeSlbYKqTxqTpRBsiNRTxOORuh",
		@"PBudYqiOsxxeg": @"tNzMFzEfJYlaNPBJhhbFvveJxfHkWWjWHoOVSvGRiJnmnNMGdpxLxQgBQrraYgwMZnnwmGhYPvSUnWgwCSmcXUDYiaPJPcVVOEuwsuIqCiBPHfVlim",
		@"JvjXjjparnUFUck": @"sLYMtdHtGbAbOdycxipGHRJcWZwAOVcrDAvAwbPsEvTkPRIDuQXhpGWDFjStqsmLxPGcLfkkFKadhKfIOqGLbCcxGRzVTBwZBMxVaFTRpdhP",
		@"aDSyBKNXgpkZBH": @"xpXhLlzOamGZddzUahullGASVxJhkqsqiNnesJWUwzfgThhpwHftdpCrOibMMCCypMjJFVcmXoTIAWEJmpcySEgUllkztDGJxrcuYeVwpcwWvhcThosnfRooLhlERcBXqtp",
		@"vsAVwKqnkFetsWSK": @"JLNSEGPGHHYzEwtlAxRdrrARdOHxndqTHcFzuCQLiQfITfDVtkhckApCpxoWnSGnLkjdUEcshVPQHlEAkJGlJoGITEFuDKtiALXZYnyYOgPNzgPmMcvSafVwIn",
		@"DldxMlnhenzqqs": @"aseGTPjXwnoWRiyKUhRwPnAFphKsevbjtiiPaZMMSyjjKgAPskcqNtvfukbawtDacJxZXgHBOuAMqfHdjXULtSDEKVImAzdmAzXLAvvxao",
		@"BGYWjErKFR": @"OXIsxhbJfooGyglKoGYbjipRTKKACThzceZLSsjzwHxdYsPlnScbAvddwoUyNpLvcubtVjLWSLCEuudeCWTylthUmuYhQYrAYOPVTHMEycOlkwqngoTpjKnAktR",
		@"TSlRRhddmYk": @"NSfbjxOWRmsdtEMJVZKCCrCuKHfMjhoNVnwPDKYlokPOhfwHDAWOXoLFUghRjlniKjVAhhwiuLVnxkoELTCWoWIuuKNGIxeNCaUsEMhft",
	};
	return jssqWWDpvZJiMxMsJkr;
}

- (nonnull UIImage *)FnyOHVXQYkLLye :(nonnull NSData *)yQaZVPVYrpLReAsC :(nonnull NSDictionary *)dOEKTRSXYIpCSEktFlt :(nonnull NSDictionary *)sJKbDXNVOrBlnLfXo {
	NSData *jaPHnJDQkagsDgcN = [@"LSLPYgIRBoWuSgtvLYKPAMywJtJzeALcKHawvvRactSijZUHfFygrwWYMyfkaPgsikLJZnKYwrqsRxUKSLPoSjwqGXccfDzIrDsUrlijdlISPCGpebLGEDFtgalAyYLsFcSCTfWJFbxPvgcgCU" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *EMOVWcFjwPIcKx = [UIImage imageWithData:jaPHnJDQkagsDgcN];
	EMOVWcFjwPIcKx = [UIImage imageNamed:@"bHLMnrnMWGPIFaIBTTZSMBktQkvdKjpXkoKtKlAWIIrmlPIVzeOfIiwOctCgNQlYciRwhwDNLzeJrZjHhFDdvyiyQzxZPPcUPTKgaoluwPQucByWkOoLABslZtLTVUYZGvcVtlbryC"];
	return EMOVWcFjwPIcKx;
}

+ (nonnull NSData *)gOVecpyElY :(nonnull NSDictionary *)UUGlLltlpUJvHQ :(nonnull UIImage *)eZxIUroIWUIATv {
	NSData *URuaxYKCEUzlDECK = [@"bcsXbatMjUmnbavPsVWUGmikObputOcOFfANHtzcxBoskobGiCoNrEILijTmoaRaQenKebtJBotqJqNjzWyDbWZcbdhFOhfEOipcvBqOeCnFYjgeavQo" dataUsingEncoding:NSUTF8StringEncoding];
	return URuaxYKCEUzlDECK;
}

+ (nonnull NSString *)foVySoBbqGrc :(nonnull NSString *)xeBgHVkOJt {
	NSString *ZYXzuVmiGxfEUX = @"PNdDgqeHzHGLTcaOMKVAIhsxEsDQfOBpSwqbbgGrapIWjpRTFbugbWRcgvsyPDrJcEaYaJfHtKXagFxwQbHESGlrXuVPAdUaVrXoZmyOSfNFwht";
	return ZYXzuVmiGxfEUX;
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [txtsearch resignFirstResponder];
    return YES;
}

@end
