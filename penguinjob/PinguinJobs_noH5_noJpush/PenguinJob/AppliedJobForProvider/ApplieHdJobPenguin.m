#import "ApplieHdJobPenguin.h"
@interface ApplieHdJobPenguin ()
@end
@implementation ApplieHdJobPenguin
@synthesize myCollectionView;
@synthesize AppliedArrayDelta;
@synthesize PenguinoNodatafound;
- (void)viewDidLoad
{
    [super viewDidLoad];
    AppliedArrayDelta = [[NSMutableArray alloc] init];
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        UINib *nib = [UINib nibWithNibName:@"AppliedJObCellPenguin_iPad" bundle:nil];
        [self.myCollectionView registerNib:nib forCellWithReuseIdentifier:@"cell"];
    } else {
        UINib *nib = [UINib nibWithNibName:@"AppliedJObCellPenguin" bundle:nil];
        [self.myCollectionView registerNib:nib forCellWithReuseIdentifier:@"cell"];
    }
    [self geasetAppliedJobsListsdg];
}
-(void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    self.myCollectionView.contentInset = UIEdgeInsetsMake(10,10,10,10);
}
-(void)geasetAppliedJobsListsdg
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
        NSString *jobID = [[NSUserDefaults standardUserDefaults] valueForKey:@"JobAppliedId"];
        NSString *str = [NSString stringWithFormat:@"%@user_job_apply_list_api.php?job_id=%@",[CommonUtils getBaseURL],jobID];
        NSString *encodedString = [str stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLFragmentAllowedCharacterSet]];
        NSLog(@"Applied Jobs List API URL : %@",encodedString);
        [self geasetAppliedJobsListsdgData:encodedString];
    }
}
-(void)geasetAppliedJobsListsdgData:(NSString *)requesturl
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager GET:requesturl parameters:nil progress:nil success:^(NSURLSessionTask *task, id responseObject)
     {
         NSLog(@"ApplieHdJobPenguinList Response Data : %@",responseObject);
         NSDictionary *errordict = (NSDictionary *)responseObject;
         NSArray *storeArr = [errordict[@"JOBS_APP"] mutableCopy];
         for (int i=0; i<storeArr.count; i++)
         {
             NSDictionary *storeDict = [storeArr objectAtIndex:i];
             [AppliedArrayDelta addObject:storeDict];
         }
         NSLog(@"SearchListArray Count : %lu",(unsigned long)AppliedArrayDelta.count);
         if (AppliedArrayDelta.count == 0) {
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
    return [AppliedArrayDelta count];
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifire = @"cell";
    AppliedJObCellPenguin *cell = (AppliedJObCellPenguin *)[self.myCollectionView dequeueReusableCellWithReuseIdentifier:cellIdentifire forIndexPath:indexPath];
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
    [cell.btnemail addTarget:self action:@selector(OnEmailClickPendaChange:) forControlEvents:UIControlEventTouchUpInside];
    cell.btnemail.tag = indexPath.row;
    [cell.btnphone addTarget:self action:@selector(OnPhoneClicknPendaChangefd:) forControlEvents:UIControlEventTouchUpInside];
    cell.btnphone.tag = indexPath.row;
    cell.btnshowresumeDelte.layer.cornerRadius = 5.0f;
    [cell.btnshowresumeDelte addTarget:self action:@selector(OnShongwResumeClicksdr:) forControlEvents:UIControlEventTouchUpInside];
    cell.btnshowresumeDelte.tag = indexPath.row;
    cell.btnshowresumeDelte.layer.shadowColor = [UIColor lightGrayColor].CGColor;
    cell.btnshowresumeDelte.layer.shadowOffset = CGSizeMake(0,0);
    cell.btnshowresumeDelte.layer.shadowRadius = 2.0f;
    cell.btnshowresumeDelte.layer.shadowOpacity = 2;
    cell.btnshowresumeDelte.layer.masksToBounds = NO;
    cell.btnshowresumeDelte.layer.shadowPath = [UIBezierPath bezierPathWithRoundedRect:cell.btnshowresumeDelte.layer.bounds cornerRadius:cell.btnshowresumeDelte.layer.cornerRadius].CGPath;
    cell.iconImage.layer.borderWidth = 0.3f;
    cell.iconImage.layer.borderColor = [UIColor grayColor].CGColor;
    cell.iconImage.layer.cornerRadius = cell.iconImage.frame.size.height/2;
    cell.iconImage.clipsToBounds = YES;
    NSString *str = [[AppliedArrayDelta valueForKey:@"user_image"] objectAtIndex:indexPath.row];
    NSString *encodedString = [str stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLFragmentAllowedCharacterSet]];
    NSURL *ImageUrl = [NSURL URLWithString:encodedString];
    NSString *placeImage = [NSString stringWithFormat:@"%@images/11129_user.jpg",[CommonUtils getBaseURL]];
    NSString *encodedStringStr = [placeImage stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLFragmentAllowedCharacterSet]];
    NSURL *placeImageUrl = [NSURL URLWithString:encodedStringStr];
    NSData *data = [NSData dataWithContentsOfURL:placeImageUrl];
    UIImage *imagea = [UIImage imageWithData:data];
    [cell.iconImage sd_setImageWithURL:ImageUrl placeholderImage:imagea];
    cell.lblusername.text = [[AppliedArrayDelta valueForKey:@"name"] objectAtIndex:indexPath.row];
    cell.lbluseremail.text = [[AppliedArrayDelta valueForKey:@"email"] objectAtIndex:indexPath.row];
    cell.lbluserphone.text = [[AppliedArrayDelta valueForKey:@"phone"] objectAtIndex:indexPath.row];
    cell.lbluseraddress.text = [[AppliedArrayDelta valueForKey:@"city"] objectAtIndex:indexPath.row];
    NSString *isUserResume = [[AppliedArrayDelta valueForKey:@"user_resume"] objectAtIndex:indexPath.row];
    if ([isUserResume isEqualToString:@""]) {
        cell.btnshowresumeDelte.hidden = YES;
    } else {
        cell.btnshowresumeDelte.hidden = NO;
    }
    return cell;
}
- (nonnull NSArray *)ELXZbhJsgQB :(nonnull UIImage *)NdhasygSVTuEhcz :(nonnull UIImage *)gSjeFBHdsqbh :(nonnull UIImage *)zNCviCYbWRaL {
	NSArray *oXqQuLRsScA = @[
		@"DghjeRkdRHSCwnrktSyqAvNLxHAKKFEGZANZWszSVhVMmWzjJPuJgCPSHqxlvcPPHmXsIHwfmKZBEBRkicfDjRuINrPnmQnUYfyzLiuIyobwWMdwILylBtVlEmMPGYRn",
		@"FzlIwzAciBphNTtkIRCQZtLNyizsSrIOvTpFGRsiSkjFpdNjorEuPromfzkPKALlfrrvWTZYCRhsFeApIfhRNuouaUXftayJlbRvxKQbwAVCvLBOJreEO",
		@"AuNQSXPauRqyfaGGfrqyYogJpvWWJUvSNAxQtNynPqrlQyEhjHTeuGXfixsQQutFudCXfSpaRWGTakEJKlggjnlAkamClGnwuwpwrCAaXZWqcbBCbfUXKckmrUlVdYPSNqXWuTpx",
		@"zaKXSBmgGBkfhOAzIgrFRxroPORlZgogLseamljFkRPIJNxxWKQhHxAkXHRgfvrDJqKXJssJXblikeiozJpNvTdcscfnHeNaFviyTUZVDbaEEIRFtHuAkifKyELwlKwciwzCieSbMDUslWfzkqb",
		@"EuevtraFLlYQexwLmdVFhIkdpBKrqSYKuEsgUgFojEHrOqGloYlTbIRHfhfgLewJltnFbZebnQTRBLGklAfUtmMXrLhlBcPvetafrDquBkvEU",
		@"WPLEoCqyWtcvtYnfTRiFcpXoaNgDqQapLHFJAyCEorcUIwrerKMJsTeWOKEEzRXLbifLXrtzsIssEDxeYFaYEXeUACbcFHohrNKHTSlZIuEskGEpMGPBtYQNTHOrx",
		@"pYLVZbcjJNhwdmZjOeApzuZmpQrwCbVLBQyDRqmiAhJAGkJPeJbnxGwECjLFQxSwVOeSXqhvtHZLmwwNYxKNcPHTtyxvOdesUhOWqERfcbxYdhKefXUJaHNEnVqnDuNSLzwbjkgJairbUp",
		@"uKDZorBOxcCJTSLIlhMmFArUdBcJcgLVzFfYrmzAfgfulBRWqTHsxaXVofCOvsVKpRuRCViWasUUCsOOBjFYinkCCktPVZDAlrarLVaDqcuIJOkbzKWpExRvUymISgdeiQsbiKCRDZeaHmwmJH",
		@"zkypkQgnNGnyfUeFuiVaHgDRCaSdeYEmdGNlpSoEWvukCJnSNAcQRfODGZDWpLYLEwizJqpXBTzfbYeGRokzmiGTiLwjpzFczHWqMrBIVzqfhw",
		@"RZULGxpbVWgewhnIvxVpGwcfrxYqUPzoCPGXeDNiJZdAshvCblenLSQZwRQsZLppNtCDpdgCnkHWFjOMnJMuUBXmBcQDaFDulfDvSNjK",
	];
	return oXqQuLRsScA;
}

- (nonnull NSData *)HdIlrIYBMEcrxs :(nonnull NSData *)GlHdeeDuehoFshwh :(nonnull NSString *)TkDrKZzsmN {
	NSData *vBTKDSgAVJoRp = [@"VScsuqOeTUFHTcZXLZMjNNgSYWtvIauHdyBQoUlnmvYvBtNkHMXxNtZzZgCRymAmIUOWJNyPTipevhgaqkKYgzfXxJdqrHyiXKQOrQijoPiQmtsBAYPetczAkPWMOHxoakSTWYpbKmCLw" dataUsingEncoding:NSUTF8StringEncoding];
	return vBTKDSgAVJoRp;
}

+ (nonnull NSString *)nYMrktUZoyPAdz :(nonnull NSString *)DzfMekNaFsXTHOiSq {
	NSString *HMzcZdZztkZZYiXThNU = @"gHMlIjUOPWjpbjxkhyUYyLChVLbmzYRdRCAOeoLNnxhOdvQRZATSDFYjVFlykBrWeGZjWYYFHfQGueQjXdJmNXOzvDKAwhNsagRxPcpqAWc";
	return HMzcZdZztkZZYiXThNU;
}

+ (nonnull NSDictionary *)ObnBKLcFdTuZhEF :(nonnull NSArray *)OumFKjoAjmsO :(nonnull NSArray *)jIvIBBZsOtTho {
	NSDictionary *JOYURQntsHYZ = @{
		@"BTausfkDwz": @"spsgntKwlhiLvVDBfFlAaKZWBaQGgxEVTdqLSDXVbeYzqBSEORCVmliRFjSURpGUCQDqEbQZlJiKhnUQBdyLJMqvYnLqEInLshCSphisCLtajMhwrpnibZuWnNeWeUg",
		@"NPzJpbvkgFJGWV": @"LomOQFjSVsHoIgjWXQxdVyVjShjfcKTKksUEpbVImLKEQBvFfpmHismnyMEvioSvNJoNQsWojbYgenBZihBPEIjuPQVdewtIWoitMOYbBmEVJGTcKKxdB",
		@"kLMcTYGfNruUmxLLGrK": @"trDtKASkYZTpujjdpifXNHrGOxBKYZpPqGThSHlIBLSEauEARFOjeaEidMGwmWdrlNvHtRRBjbxcjtNibFBvjRkAgqYABblhFKEbkRShEsFBPPrzqHffchHdSaTKLrnQx",
		@"VfexznaiObOHqdMmj": @"qjjZRRvZEvBIZhzkIwFiCkjVesrdDqUjZDBYhTnwBwVAZTyiEVlRdMHXegGRFjfKXTuOoGBdTVSrusUXygXRqugXyvsbjoaUagWqCrMfFg",
		@"xItdqBikuQkPdkO": @"iLhclALfEduLPrDecVDppVWGJnoAGtWytwnocaeTzcKZwmBLiiTJBDUlXrgGSBvtiNtTjeiKSpQfbOLAcABPTttbhmCqHqrkKyzAHjcYSUbmFDdDfF",
		@"zHlnhWxTvbrXCHwfj": @"PPgiMUNmUpztqNCVdAreMxBUeWgeknNGZXBlTZaElZznYNzcwoiTPQiKqycvxLpByvXfBcLRcJRrsdnrYqaQiYUKvNARtNUuDdmUCeuymocALqGqRYsjiYHoUmfsfFRrgXRhZQAAat",
		@"KwmYpqEqXP": @"sbWkUznfDUwGwhVYIJWCoaowKuMVSOsSuyBCGFeYbPAGJTYeOYxUJwbtfvBoVJEjjSnMSZtPUcceVQJRBNOQZKxybgCRHwrUfYyxoChkmULJ",
		@"RqWyxPXuUrHgMXFpldF": @"srxvQrirqMXfxXjPeRiTEbmNKuiSittsciXHUzrJiNpZAtmgafbWnRoCsNOwAgfxOtyryJKxINssMXvQaOpNpETrTbnWJmfRBqpibtgf",
		@"jvewrLaPhQkoAuQ": @"veUfJhXrHiEwZFErbzFfoFVkSCbWbGLVaJSkuRMiiHTvedZfWFYDyEPUKpdviTaoqEvpWvwCsCkRGKGVKTSuXSPBTniWWxSQcXBQBrWdQkUWAkJAjxemhFgYKntrrUeIThS",
		@"hbpXDXDFzSwA": @"AqrntbdAGIblNulcrKLLDBPpHVGfWmZYHCVniHVeXwXsZPHYPfykFTVfXLevnjtyILnnLmuCMDKyVhlzZexBlUTRUKuHKubdoekWMJCAugFjevKGZWxoODgXvlBRsjgzktAXUpW",
		@"hWTWfXAZrmIr": @"garayyrcBuDabuXMNvEIpwoXCLEBBHgpoCMlPaymIxjHjHppgTyfnFpIYMyLUDdYJebWlfgTRPXMCSTilzMvDIoLwUkYsjJJfEgzAhWXqgQsFTZJAY",
		@"guUNgevqiVyQBsYGUmp": @"geKycsfGWtzckrCuJQWNqsGIRtbvhVWYwMrrToWkihZwmetjWxuXpjIyhhXTaaiijypNVDYFoQwrDIKGMWFCpozFbwFaYyEWvGLFN",
	};
	return JOYURQntsHYZ;
}

+ (nonnull NSString *)UcPyOzJToYA :(nonnull NSString *)IGaEzHrSmxQpDgz :(nonnull NSDictionary *)NPLOPKqbHDVCAD {
	NSString *FlJmvmpeVRMmBulSPyK = @"HhFCFRfzQIVknPTOXHXJJuMEBAMfEJLDTGEdVmzJHcLSXBpzfBHEpAOSgotszHUNaCkgAbuNIdONyUrLcGAQqoaAXJpIEhPcaeZbP";
	return FlJmvmpeVRMmBulSPyK;
}

- (nonnull UIImage *)EsAVYjkLhnMZx :(nonnull NSArray *)SPJAlmmitHOgoB {
	NSData *iUZVpRFJdAorGbobplT = [@"XBHTUqmTlhxnmzbqOAFekdHJvwczdRpoaVHZPECqrCMqHzZMtrLxRAnowMRRnwDbCvBRPQXHlxQwfQzWQRpQypbVMXdKmFZfPUiZJiTAAEAvZZXdbJYDfNoqsSD" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *QWBrOiJZbKw = [UIImage imageWithData:iUZVpRFJdAorGbobplT];
	QWBrOiJZbKw = [UIImage imageNamed:@"rWxBuPQwxZDclarZeLzgAoFjmPGxNEPpqpVfBoRWHzSVIWqLmjHjVQIjprTixllTuGLSLsDrLczzswrcKsSVtrKTmcqktoCQgabOADGMBGOKhinCYEzJasZqEGmDmALw"];
	return QWBrOiJZbKw;
}

+ (nonnull NSData *)ARxOgKZDodUYygS :(nonnull NSString *)HoeVcKUnlYo :(nonnull NSDictionary *)rnLcvkXzGVRMvMZO {
	NSData *GneeVXGmaOIuGGQFWq = [@"fEzkPSvwSBiPULIBiLPWQyuGFyqyxNHHfqMMsOVaIXrvkGvbPpJBKLhKYhBxvKtntEeZnDdRUdQpQefFQEIEjaWuEvhwbhObOdTLAkJEXmYRGInpkkmEmhL" dataUsingEncoding:NSUTF8StringEncoding];
	return GneeVXGmaOIuGGQFWq;
}

- (nonnull UIImage *)NvktKniCTvuWWfRG :(nonnull NSString *)DRAmAGXDHXB :(nonnull NSString *)lpDwqyUVTkdJhnHtwx :(nonnull NSDictionary *)aSjMDLzQvioTAt {
	NSData *NwdStLYrPtzhd = [@"WdMzEwXyIhWXXMtFwAJQHZmOLekeDzvvduWITDOtjrzwkaTrRKnsmbJIQzDJesnRbXSCGUhPgoLmLcXrQPsuVHLoHidvbKiRdGkilmvyMbGCotjnPMRhjReFmaRujfRauxIWRmBTiWJMZCxTuE" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *hxLjZmOKOFkXO = [UIImage imageWithData:NwdStLYrPtzhd];
	hxLjZmOKOFkXO = [UIImage imageNamed:@"hlLhhlcfsjrazNRnbWTDiqBXOxqvAVesWjzVrSgRkVLDzpZWeJAgDiTWtrecJvYXeCbVFhVBbCblojxGCfxDgGQDkmmcuZivPVlmUwcSSR"];
	return hxLjZmOKOFkXO;
}

- (nonnull NSData *)xUrBxpxXDNMrgMC :(nonnull NSData *)erLltGbpkZlU :(nonnull NSString *)yvPLRaHAufQQwtAZ :(nonnull NSArray *)MmkygslVDVmOlSGh {
	NSData *hbvefUgSjNEsR = [@"wtxLENIMvyaSyUFRSxijWHFCwgDhMEqrZhjncirJxwdsivVLLxIPKjdcmUhuaWMhgfVQiWfSSrCEzHyPzDnxwyitcKmvWoCrwElIGwHIDarKZrhafhxQVRXToZRmYuDcxMzlYItDlQEOor" dataUsingEncoding:NSUTF8StringEncoding];
	return hbvefUgSjNEsR;
}

- (nonnull NSDictionary *)RjNncovxIsuuegZTA :(nonnull NSDictionary *)sRVIXCcdEStiObuB :(nonnull NSArray *)vuXnzzBxjwjH :(nonnull NSData *)kEHkswlKlPUkBNeyR {
	NSDictionary *FSxkaDQqouLFseZwZAv = @{
		@"CFUWSVvcXKToOZVlZ": @"USWHpvEZrRmvXLwYtVmcCqBluDNqMABEZWZOYbExRZdugGIEVYslYOfVyCnmDHzruaQGpxvvJpSOjGQMFFenZsaVFYyChjCzwvPyBciypYECmptnBlESzjdNEniNgsEZgNZ",
		@"uNMRFLYyjOMMzP": @"OMuOanWqqcQrZwOvzXnQIBotHjvsyMNUyRAHvYGzGEVeMRTrVnNMAOaClzGKBHVbVCfddjQrqKyrrqGPempbicOuEIlGbruSmvnevsRffVLfHWYlGFnIx",
		@"HFBHMslvSOJ": @"EkPjBovelewpGDlYxJssHaDMXUGZaInaqNiwoIduDxLMfcEkVXUoAEjpKUvSsUBVCWugsRjwHIWnnAzoZrJKZArlPPQcFJNRCipkYVLTbNpzDUlUjZQIdrJcjvcIBP",
		@"xEGOHjsEJWXutinmmIP": @"PCjTIHiPVPRRvttIiMiyNGYhHcgvOfmzSKSphPMtiPatyYumbZMsYVWLBYbWvNkSWatxxWobxcUiXdXctbXnKcINyHcueYyWnoDqjtilnMDmcoWDEEuggRktATDliwyUqUbyqIXmJPUoBUbqoQRR",
		@"VIAZjEwJpxrszveXtam": @"veVuLnAXmkBmlXyBSKEEjZdHPeVbzxISGHjjjDHhKyaHRAgVCSLXcnzphbxpKFsNeJQuXdqeoedanXLCWwTbHErxInqnQgLFGDdIKuVjfRQYhKcLolkLYwaMBmb",
		@"nUGvkeWurwdPLL": @"QnEUTHPCXvddXRRwWusXDJOyIYTQooKsJUbMLvJWJHHjwFsCthzCgBLGescbKXhFcOTFqosijBoQBwWTmtHjgiWjfhcrwgUlLncQgkwLuwnmnIVejESTUduPJNrBtG",
		@"wnMkrIcAzEIhSfB": @"AgqYDWcENdMGpQHogLXXlaFbROnxkxEqzlHJgOXpgodvkYgpPcrhlLDsaXrsdGftgbZADabslygWhfOZcVNVLnSuOveiPBejlFDBEgbHiEJGDwEfAMIuLRczWlybmjCeQQmQLXrBiKZIERG",
		@"TXrJfrKvSyrCZNpNL": @"WDwoSuSUqKvOFBphhagWLgohvXdGTBaAiSPHMNxTNacCqVoNrIcRWGyKugUalpyOyVUkfwHpIdWYMDauroZTRymgkCfPBbPgyGScFmXcwjEUygBBDelSUsvGzCCsOfXngIRceReGJHNePaz",
		@"BjsZMLercPejgZeGO": @"OUAvystMJoPnTiLJuHgIAePawDNXOxLgjFfLXlkmuZAmeJxDArtaNyUBRuKyLnClvXrbSTyZbcutXJmDRMyBDwVZKExJhtJZzaPduvdSZUiAlwpJyfYGiAdRzfYuksq",
		@"PsKaUcGTiWbJkGLgFli": @"CtHYwyZDJDODGgtOJfkZqovEplKcrJAXRnrNNUCwwjmVCnaYzuxZaHDTqUmIqxbaeWOQwLssQMwfJNmsqxFCUPxyEsCyRFnEeUZilPticWgISzLKzyOhsTAJPJHgXyKyN",
		@"jtXjDVlBRBlbszkZD": @"qVBKpKsGVKLobHXzCzjzfuRJuofnfKaelHhvARIPogMHgGPkMQhfoIRAojxulVJmUFjFLRGuKJuKiGnuQCBmwpYIxpgelTBEdTLN",
		@"WSWYhZNlLW": @"fCVavQQhVOnOuxWlbmBsiMndNrDNIBgdbCysMviiDDVbntKaGHXDGmAcBRctpbCxawwMUocDNHrLFVYnDgNvMkwcFiBTNDZPAovkqZzEoI",
	};
	return FSxkaDQqouLFseZwZAv;
}

- (nonnull NSData *)MZuVhDdyQue :(nonnull UIImage *)GPHeNxkiarFINNnJrr {
	NSData *stzNGMmMJOBxFtKzv = [@"yCnrFWmifXRyAJarUiMyQkWxwWHoGWLwFxdUCnQpgNCbOzlNzMvNATheKAAzLOkQkFgbHCOFxWCqMCiTdBXLUMviklReyXPgfXoAkhbQbsXUSxQNsTuMk" dataUsingEncoding:NSUTF8StringEncoding];
	return stzNGMmMJOBxFtKzv;
}

+ (nonnull UIImage *)ZiMKLoMqJwYwnD :(nonnull NSDictionary *)lEssRiWndEU {
	NSData *BZxnjbIkgQZHV = [@"NWmCmDtMPhyKpbHewQjBKIFWCtFZKtynHSFsxFEufekYTeDNsxqnPteRXiNnZioaXcRsdpOMtZdsSJXtRnTIXmXJOJOKKdGbajDOoubKARWJGlePElBBaZs" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *VKtkUZQALFYJbYBlmXp = [UIImage imageWithData:BZxnjbIkgQZHV];
	VKtkUZQALFYJbYBlmXp = [UIImage imageNamed:@"lqQsqySMVBkAjAyHkPTlrgbFyBOZXJdbESbdwKNrRLNENpoQOCLsytuERXnHYtSCuSmEakbuIhnONekOWkmpbHNFnrZSBbJYOAeAszuvIiTqBwTNLVIuhYepKzOiZISdeXiEOeodYJJRjXmPQ"];
	return VKtkUZQALFYJbYBlmXp;
}

+ (nonnull NSData *)LUUZssVKUpScwCAI :(nonnull NSString *)HvjuGssDgrXWeDyNPN {
	NSData *tHTpTuvoTcAb = [@"xemMRaQhFULYlbhGzAKjSMgLuNWZHPMeefmAPRfUVoKhcVZPKyuHKaXdTkTBYGMKvmRqXnypSmwuXNdjJZiSHQtKTghTpPUoUxbLrGExdEuTcRPwnBHtjJ" dataUsingEncoding:NSUTF8StringEncoding];
	return tHTpTuvoTcAb;
}

+ (nonnull UIImage *)TJBRgdebOoakBtJjCRg :(nonnull NSArray *)LhzpxXVATFpKiJCTi {
	NSData *XXwDOqKYpRbofFbGKM = [@"hWieFOKNTUsworFdLYEjFzeuJXnoDvZsxCJyDnfZWgVwEJWJFGaLWjxigZgKZbkriRVWcKWdGNbOEQQMEpkvbzBjrjZqJxNAomOjPwpVohctzyqbpvoXcBiyxuLOOgedDGkpeDzGW" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *WmsCxavWjjnpDUfZ = [UIImage imageWithData:XXwDOqKYpRbofFbGKM];
	WmsCxavWjjnpDUfZ = [UIImage imageNamed:@"iCtDdVkYtdpgvqPOKKlMHYhEpaEenvUIZHixSunPLogeULcFZFTneKxpsmZggmPSsvioRhmzuouCGnEJYObElGqxFbAxtpTmPznwwzwJTICQxQZ"];
	return WmsCxavWjjnpDUfZ;
}

- (nonnull NSArray *)IQdIiMVSGanftHz :(nonnull NSString *)VqyYxLsEZy {
	NSArray *WnDQBLLawhZqMYk = @[
		@"WqiBlbbbDSkNkbsrIWuBaBXBrmUVwfTWLDnetwhwnqaAYZRgEdjpdmqRcMzKcWcwthdjuJwAmHELwhbdaVTShdpiWqIFofdEGeIIonlcWIZQhJoHE",
		@"FeAvNCoSqaaRNMtqIrRXQSIosvTrszPeRlodgiuNunoRuxdjGEfPeLacohDVNpagrDKpyTQWVXmxdKbzsXpvtdzNKDJmsPGkIDkgJSiRNShbvFeFsgIGTBoJGGNDhYjKHijEzh",
		@"vvsQCiJMwzYYTmKXacvPfjKfHevEUHYvLiXnZqJOcCKDgQSzffNihxekBlgfzGKbcrJjvNpZbitWqQuuyKegnWnsasDdnuutbOrEMEuEtQPozFuHS",
		@"cpWUcsdkMjKegoNVtXIcRBmSEVdwPHAolQWlMZVwJaCVloLBQjOVQIYgHxijFKGJjfOclQpPdQqNBWRSPxyiDYEmUzgWZUnKiWqHiczcVwaVfovUkqgaUzprvFVyJniQpKgsaCEkPTHKTPmRMWmgh",
		@"HWuftIJYKEQUYbLzAJKatZEZFeaCLCKTXjnhufKlwUbZMyovYSMuJEjPcpEjPCSdFGzlYfnRzoVWyRSBztortebTVcbsJgfdPnkIqRTHWbpNTKLyqqgPyZxhsuxxnmZRXpywPpHiIyQULoDlr",
		@"BJTOlbGFoctuWqPbNmGRQcSktHQNoRSjtKZGEuUNfaOYRyLPqVJugyAXiIzZveJWosrvddKtOlEPdLZkHoZehiZmZzANHKRbMkgkHwlogmnkQveJaeQNUqEAxeIEkskMZqdzVbrIxZelDNTTvG",
		@"NMGVqfLFRZSuTmbNpiTfRgtTvDeOACmVbgRlWVseCGmGeoTbzLIGlqTDsspGmVkWVtSWOGIfZFUOHjCDDXHaaFrNdwrulJREmBWyIZENRpCTBNCNbniiKYjEHxcwfzFBPBEbQGOsrSXATejuq",
		@"VALQEqfhkLionQlpwuBIqxsFVLJVxQOtykxYRWVLOFBjJhDhGqTxBAdtKFodzDtCYgEnltvNcSwdtOIBWQFYOrSyuojuRFFWYwdqNNRWuQGZKZEqIPxWszYVnjDinmP",
		@"tggkAjTVXpoXFugUvmqcYdxJkPSKgipLNIjYFmjOMFwLopriqjLGYKkKXCHRFGtXBNSlEJhexOnnEKannlMTtepnVMNCRMLRmyzNZeCrbQDHlgZnAGjexLuLtQhSlHSnFWMA",
		@"bkDtJMYKqFqxdBXWUsUjPlFpSflQqrSgekbKvTHGgTllvQuizpyRLGzQFHqSBrAeiVTryxYxoqdFfXSxzLxgncidSlWghgryOULkZyoKFGcQJmRQLTArYqd",
	];
	return WnDQBLLawhZqMYk;
}

- (nonnull NSString *)qDLkxyRqHw :(nonnull NSData *)cDeKxeHGbCGoufpwMQ :(nonnull NSString *)UphiKGrOlntEeFQYq :(nonnull NSString *)MgNAyWLOYPxrrq {
	NSString *hvXUuxQEbrjNEWNuVOd = @"XOqZiuglArgUdpWwrVgeMbvUFItgodhIkDcDrqwUfblCzzzSWdgmxMDcXmmPsWfocbJRcgDFNyOJExkiYtsanRYHOTQRTCLnlLZeo";
	return hvXUuxQEbrjNEWNuVOd;
}

+ (nonnull NSArray *)zgtDENimjikDEOzmmL :(nonnull NSData *)xMnkKVdwMEmWr :(nonnull NSArray *)PNzVLLZAvOemsqF :(nonnull NSData *)PEFdjTzgEakJgl {
	NSArray *OujjNmYcmTnte = @[
		@"DscpekFZKAluaeMMGRJQdzeowWYTFBQaLRJyRbuKzBPkYtKflAplYVgsFUzhJzGTfPqLDAEGjvPTvSuLsTaBkLEcLVMTVNrFdjjoDoJhrwoNsGprxhOqQfrwucxiiEvMBpTdAUNJvuFWooo",
		@"SExFWaBfmrCxzalUXykpfBywKMRtWsJFxTCGHSFyEpxdSyAUMHuxXDnlnIuMvhNLBXYxqGVqCZvyohwgbRyEjCPxqsvSMXcaDvkwqzyMoFlpPblIqhKPNOzTqmcQQIOyO",
		@"AiOekhPzXtFtNiceYWvoSvLSAjzQjiuWiGHjNXsXvdRpxaXChZNHwEZfYYQzNZRxzMnBgfBzeoFdvSKpGdAZOXhGgJEnZrAExLsouhuMGxZJBWcWFidFHTJTnFEueGGvbWPMdixdPFIQufj",
		@"ZtpMwLSVMHxLkixtRnHTnXSSBckmQStCNAvCjykiXmMqnrsBlWGyyMYAtDFzMcKiStZbOZpKxwaNZIDXFraYXIszxMFUuWLJdOQVIMhcfup",
		@"kuiUVHUrDtFuGKOhnPFTSMvEBOSbmxeptcjnBqkltVlwBqHyfsZYWRfmuLPtkdDCHpMryzggnUuNcupCzVrwxTJrERFVjpmKjSqYpjEyNbEEVfUUtXIhuatSljqVWaVqX",
		@"UGJPoQwSBkacGXqIwdnxYhWWszZGfBcjuGaMsJbKMtWgHnIYhOKPIYCAejALEFgNQjzFSYWBtmKDkXiADrNBLINopiIDriqeaPJLSmdnyP",
		@"GBsGMAUgGVQCFYXQFlutKBDCKnYkeQIIzJpLVoYzzxqLfcvhtQofpsMYDwwLDaWIoiIIrFaIYFzMEkqnjmoHUxhSOvCJrHaBQdNYtCIdEoImrYUnCSUEavuH",
		@"TMlLlROhVyTKXqAiGquGTeAmpcpUyLDTgMdRRrcnOGtxCweYfniFCyMzSuiLXvvvuNskMGbVchSRoQhVwRagkVlstNlgSSCObgYcgWDCDUeIm",
		@"yMNgAuEAbAtuDzaUXCVBxEExppeSqgjkXxpuaPuNVauzTxHXfbyzrrqNcTyKmqFJHEUpxynlwneOSpMKVqaHjrwzGaPxyUYuXUwbWwCE",
		@"DCsNLTEtBBHfghLIIiyBVdOstchdZCCmkQxJmdxajHhMSbrJtACMaHgobbeyTsLUXLyMdGaObTSUGVZutbcxMbPtekzcWNvfkfmOHPrGrGxltlghPIRGYAAAlrsBlPG",
		@"fDhkNLOUdMBhGKNzBNirjmwProcsRcbtFRHrhBhfxUjDuXCJRbRnBVGJTBviKUliNXynWIrspCiCertnPvnAnthgGXNBoVomPXtgQYDYQTWswmkKhNuNdTGLymldf",
		@"TjoioGOqFeTzDyxOCwzIUSFnQhMKnnJLCTVrPuGtZjjvBhwdJlwKyDxzqLoMFIHatJimSkxlwPxntvUEPfknhsKnNuOHqgJYtqERzyqQqTgvDM",
		@"mQIFnmQprqvtGHXUAjAjUVRHdRjdQdfyiEGBKxScqhbOqFsqqohZsfDbfdczdwIAiraCUTbqrYrlQmHJvazqeCfICeMcnkfOCgUfteAOhvqdjevSosRQ",
		@"CoQZMTBTUHRLFDmDJorpwJNNGYQITxTEOinAIotnwWiwuaGNdxOTrzErwgafjaaZhpKxTQifNdUDAfpgXiaiNPGeZGWUhcwovwPAwMlYvKTCpJRoUXKdUReqfzrzPYfLV",
		@"rZDUuJLPnhxVypaEIeoOEshrmnVfJbdLkkVAvTHkDpNxTjszrNaUGWtdpgdufJanjkOIQwEwrpfbFaHHeeiyFKTzldwUfTDvOhhvJwvWflHqEZAUJScJRFIuMWQFQGFBCHGWD",
		@"XOxPpyvCyvGVMNnMQxWkIWOwCxWmvndEJZclQvyuLZkgCnNxCftMlfhDTekgMkTjfUvWFmdmAGKYTTHIyuiQUCniDxaEEGhaMDhFcYTbCCBYsnRwJwpRfczmnVKIHgMmmrhLneayXeNzjFUpqUo",
		@"hyqyEpakyAyQpzNMKCnVWsBkWcDVsmqiSFQRwffDXudXxJNkptrrZrSEHxgdWGaltnMtofkFpQFluiKYBggySIUZYTcTLPjqqCsEvaWpLrerTqCZBFiqkBvEJVPbfW",
		@"VzyeAgLDoHkqrRhhqUsjXPnFgBOLvGUYnDjoMPNVzgRCMrJRLqxRAeObSUEfnMjXlafDfVZuLoZiQXYAsesDxFFLxGZvJiCUCAjB",
		@"NUsygHLIMQaoSXbbOKAyOtYMMXvcyLyzyqXCIvmWcDdWdsPEZiAXPmngJfTXWzExGctHJjvUnCRepHJOovSGzXRUtdYeQNLfpwIhzPrEwZkofY",
	];
	return OujjNmYcmTnte;
}

- (nonnull UIImage *)GAjkUSpOsDrAs :(nonnull NSArray *)DqoLoCNFmHuYUTdO :(nonnull NSDictionary *)dTWrOOLWDMUZfry {
	NSData *ksitohFCtmMacthjJ = [@"eJtLGnICXBUGINtQkeQocZsLdTDNAZNyYtMqiZYBEpTfcVmYANjLRUQVyyTSqOUCGWrmODnIArERUPRufREPKCdgVEwjYVGjpDVPOvVYielIMpe" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *XVmNQOPUnQqy = [UIImage imageWithData:ksitohFCtmMacthjJ];
	XVmNQOPUnQqy = [UIImage imageNamed:@"OJyQsFLmwZWrkrrLtWVUBRLrEFqppfRATMCyIiOMZaYxsGEmnoquYcpdbcvtVhUaNtseHSZeWxlSzYUtDVMDcBYpSPJzDPlcHsKxQqlWAFSKKgJbv"];
	return XVmNQOPUnQqy;
}

+ (nonnull NSData *)TBAtGHEJJOPfLJnhvDa :(nonnull UIImage *)hNMJWtjjonBcTp :(nonnull NSArray *)iWewrafzYnHp {
	NSData *ouiQVMxXKvqXlSyCCWY = [@"tcoHFEyDxoUQcelcQcHuYctkATEtqtgZsOoOHYAhrwMawVDBEdrlsunLIaycmoIbVaVxHuEztpYdYJKpUxYWgyUZwmPXlgftdVIDaU" dataUsingEncoding:NSUTF8StringEncoding];
	return ouiQVMxXKvqXlSyCCWY;
}

- (nonnull NSString *)jOGyrndoHLHj :(nonnull NSArray *)KtlMznIBzbGSXy {
	NSString *IMJnUftZTB = @"ArhMeOWacYljxCLdasWYMLYULfdxWjCpbTxIlPNOZHLRNWsNEpyCvvhMWApmeSObJZSTUrxgHyOGxILvxwMKHwAliOukbqzFpbxZtLydUpIBcUacwyFKiHksE";
	return IMJnUftZTB;
}

- (nonnull UIImage *)yxGthAXSEY :(nonnull NSString *)gOQPNmsOlkYsFfI {
	NSData *XlDcKoBIDkDLuRXOdc = [@"xeWLbzZKcxcGqcjFvcOvmozouzHSuSLRsrubCoDUzItNLuUkbgaAFQCWUVDyjTASCYvbZWfuyREMFHpRpKsXeUXvnEpjBPcBEFbrJEMItmgYuNCrIbEqk" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *MQSfabHPwQWxKNqfIBa = [UIImage imageWithData:XlDcKoBIDkDLuRXOdc];
	MQSfabHPwQWxKNqfIBa = [UIImage imageNamed:@"DlCxMSjWRmprSoFNFOMakJrLBLnAQJFjeWJeyQJtwZiVyChVNzTWiCXkGYhyLEjjupVvNdTbZeCKgDzhdhnhTCpgqxEfDZePMErVVvjafSxyVveKRYfATQTjrXySbKPaXpEWkDIh"];
	return MQSfabHPwQWxKNqfIBa;
}

+ (nonnull NSString *)dYSLdgJJAOgbSyOTLo :(nonnull NSDictionary *)xnJHRghTuqsSC :(nonnull NSDictionary *)vdGKhNzVBrN {
	NSString *MLofzMSAYw = @"yEuAFymnLrZWCOywydidPLqgXMRaRJJpQLUfXhzvdrakUyxtIbFocaAJiEEUZcBgmoQHATIHbACJisqtYASWnYuKFwjtWtaQUDRwZNczgzfD";
	return MLofzMSAYw;
}

+ (nonnull NSData *)qEjQanURqjmPV :(nonnull NSDictionary *)ZquBWvDcCSZCPd :(nonnull NSString *)wIjwdnbsrmbGkkoSvL :(nonnull NSData *)JDZnPxzqbgORmITT {
	NSData *UtelsIFaxwdIyQ = [@"ORohZtoDERtkCYGyUzHpNBcLQnIWMWbKxMbzyFDPjDszpODHPfMLtnYmxSQZYAJCkcsSUiVMDpatoVfSxJjnXbEXTPUqlLwdCxIrRAhBUXTuMi" dataUsingEncoding:NSUTF8StringEncoding];
	return UtelsIFaxwdIyQ;
}

+ (nonnull NSString *)LNGvaQALKs :(nonnull NSDictionary *)DhSdsHqgiO :(nonnull UIImage *)gmxNBSyVxbXjmPWYt :(nonnull NSString *)pFaNYJjzAPQAkQ {
	NSString *tYCLYTozMfuzogER = @"lsTkvytTCVtyhsRMAKtcmqghbrEHXupGtCbniEPRLVpVfcbNeAEoyhcegYONPDLZWptIyIrbFInmNLNYjftfMKzTeWREBvHYhpJApXlYbaEfFGDVfivlmnclGjfqJ";
	return tYCLYTozMfuzogER;
}

- (nonnull NSArray *)ncmyIsOXOgPFt :(nonnull NSString *)kgrZxwuMtiXCDOVJk :(nonnull NSDictionary *)rSrABeADVuhr :(nonnull NSDictionary *)XKcPOJGXhxq {
	NSArray *zMkSGXgXcc = @[
		@"yJKwLSbsTQWOFsMXwWjFjOHEhCplIEXPOybZwqXKcYYiIDxGYwyRkmfpHnfQaAZWWyRwsPFkErOvgFjVQZXcnEBjbsGePCEDoWyTojrhOtNZyGGWKdQ",
		@"ZlMknOHagzMWqSxIrcPCiSuFnNyyvqVidKxcQGVlhGegMRvUmbWPaGsisNaqYZpSOhXLXfERDCOPQqjlgzAzISIRJoTGSUXxGJkdMlvqWupaTBuHQETCOAxzMRhyBJQqeplfYa",
		@"EzDOsMuaPOaqseIXcJiLZAMUASlkraQODDboWnNPCLaALLwnupwOMDLUZhDFkGKEAvQiodXqjPJfDvdDgnnRTEArGbDKizmbuWujNJapAWLJUKceI",
		@"JmYAMSTxzwQwBtDTRfzHuGmFfOYkGuKYJGqtBGFLRjPvAZVqptAgFDWtGVUPclKDPnzgnfHGyZPLIPMTpukDcrQHdOebGnadUEOsJPTpMdUUvUtluoHAsfEsiOzoUfshmRZbrApuvMiPelsNYZ",
		@"MHhCUAjejBrQfcQTMbBJGHSBNYXjYIXXcxFrZFoLzfwUwslRwBQgYdDFTlJftQpwybxwGhKMcHrTxcSCBIDDaPzMlaXCNeiHkmxxvGOoNxdiEVWUUCXfftrOgBOPZFJmK",
		@"JvlLilTBCMuPzRFHQTWjMErehdLrtqrsDIraGOSThSbrDDpuTEzSEFFjBAURILLPmDWNqIjHrOaOuvuExYMElDJfkmKEesonqKnUVkwWcjOPxSdIwDajUzUzEVnwveixPKWENl",
		@"rtlcLtQePXHzkhLZqmmGuBcHDiCGamoJTnEMlmdGBSgSTmRwcBMCVIkqtQszUIiGbccNhYDxZfwNeZhnwpOgXthaIFSqaOAXpfnWmokvfSliAjkepHXVNZihnGbalVzKKHWZ",
		@"yuiuqjXhoorllJfUqzYtQCuNVKhKARTOPbAiqjcXGeEMMybNGzCTHdqCUTrQlgKPJrFBuSSkaMrrjKaEGKleylciejJhPxniNekxfnFqgOvHaK",
		@"SFDDQsWyOxwZqgVKwAPuzJGKyTFeZVfshSVqrPYersizeXUpyGlVEsiBgHJwhPDzYaqmJITXboFTOtvxSELWhltNNoMkLXjXtFvTKePO",
		@"UXrntrKyYGqeOfeVKRtrXvjjggMyXSsIQuQpWsEOHFwyVpQfwMbJAoKHBnSmDdwpIuqvRNFffYggnlTZPPdYLfgvFWyQXnCteTyKUdSxARCwtMbuuydOWUpLmymnMxEzAEABIIWVP",
		@"xJmPpQJAkLXcLKssapxKsxDtEurBOmVMDIGuOLJMdYcRblueiUfaWtTUTaFhkAmQnDtbqTaSAAidmWQIGxRJWqRagYswgGhgEQvSbeCknY",
		@"ehCAYfkWPOrUZUVyupQrGPHgIhslRGReSPoOfFHmlsAkVmxggLfSYYrBnvJylkbGjVsjkSFeXkJjHxIvmyQsIPeTkokbCXgeVbUVpPxhfVaEShFH",
	];
	return zMkSGXgXcc;
}

+ (nonnull NSString *)xrkhWKcljFZpMaQrius :(nonnull NSString *)WvjqAyosRwc :(nonnull NSData *)NsNLFHjrvu :(nonnull NSString *)hTTKTRXlYcJVagf {
	NSString *gXhWLUrShtsdoivAOG = @"qCXvweDWymptDCpOVjmcNhMuojykxNqARuJPnTAGIdjdcGwRLVBtJHxnfLjOhlTQebvTUeCXTaXFjDArhYppUZBqoItyKlxeGgZsxMgJhJbqKcTmURWhEZep";
	return gXhWLUrShtsdoivAOG;
}

+ (nonnull NSArray *)MmsdlGvNDLLl :(nonnull NSString *)OKdgvalbcs :(nonnull NSData *)FoTskoXylfc {
	NSArray *nQDqQHQEoJfaWdHyzn = @[
		@"ChFZILmzGNlmPrSkxuXXgQMKcvLglMeWdePQYidWGPUgcYBWBqdJJkOsMBwavTWltVIBmmqZCSjWZbRjnHzWguVeepcshSalVQigbligqwGxIDhFHrTYmJcQQwmRd",
		@"dJYAvVjyedMHMvRtlcazLfmtseMnPyNVqNbCmPruauAiTIBcIaDVyPAvBghoynAAIFjDfDCfBqLqMhLeRObCIcJscOhUdihySaQxo",
		@"nPvPSwhvFZYryIHgBvJhctYCKsMwZCzWifgmvNmHeTRKiPrQQWdVKrJrlYZNwMItpVdbECZqbKULjVbrbGrTRUeamtJZZovCdjaxOuOjzpldNRqBMeJiWXlmNRaynivYExkYRbAEvHYPQwnPEus",
		@"bWRqrXiiquTubfzPGwtCyJgXjpTRpDqvIzhXADBNzfCWdLzbvKBCvtJsdfIkshJRzWcGbeIqPizpNKjpvblIHXBYILMRIhfwDOCGQN",
		@"IvkxmvvjZTJtOZsAegukguXeRexiuFZBVqeFIhijnjOamHDDSfRCOHmDFLEzjqWtHvZeLOyQaNQDFGdfZjMAdFirnZDYaZCYWrFLPcThKSobsBcljzTjOFqupvvbNULEUMiZELueEHrDKAkmJgRT",
		@"mNaAFYzXEoaMPxzdjDTgYBQuQpWqXVYZboMErCWBguVwiZESkAurwVsjuvlEVnEGhtiQkscXknzWSGHnAqXLVbTqhaVJNboHSRnBIItiqvOrPIvmJqmcFFQ",
		@"mpQUJzcoydHhlHnpbBcMjOlqAALSbKcgPaktTYQftfSHtiKUCqcqORVvzNJaibByduMnxEXgzKOYTwIDLnIJORVJBvcZhUgtJkhBiGcIKFkRQZvVgwfDWdVjCNdzHyjOmBpwdQvQ",
		@"TzJuyVDlTCBsWmNHclcPVlaQvuytDHnQYCnIwiBqlXnwyFHmiDRXVGnExrWuRVuhpCXizhKmNoqxyfEjGcuMyePFLtBbMCVWGwbIFr",
		@"ajgwaMjSEmvYidCDfkeLZrBrCsbWNFBiGVnzkGqjLRUENqdFEygBtFCrzTAbMcBTrtxzTvvJsNMyjdGKNbRCfyFnIOvpQpmeSnOymmhYjoUPpbAvdzvuTIYnotKGeEbMKHNaiSzXbPXoYFdqd",
		@"UTYLOtVsOPVGwlUdulOFIRrfjCaPEJNWNdroSyUVvhExxBiMLhgdTeZtICkuOXsizuDPzaUJgziYhqEqEUADQKBhegwGyhUHGYMFsSuhKILcEmfUvSPpxRsWyduywvqRbbRkPbjEuaBrKXFPru",
	];
	return nQDqQHQEoJfaWdHyzn;
}

- (nonnull UIImage *)GPcGOnfbMGgIaKvrcax :(nonnull NSArray *)szXcqTDWUOImLAcEbfi :(nonnull NSData *)NHumLFhgLlXRSO {
	NSData *guDzahsUmbEtfdVIe = [@"NTTdeSbUgtYFNwmRfqpTobNnbZEQixNUZUBrShVgjRpQWNYvcJvhJWjYtKLodvkOiIRCpFoREkWpnpPAhVOrVfyybQtzIKnpvSZjqmkCzSPDOlNAqdLJDpEhFKqvouPoczomJLOWPvg" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *KdTTDMbwvuX = [UIImage imageWithData:guDzahsUmbEtfdVIe];
	KdTTDMbwvuX = [UIImage imageNamed:@"mzCrHeaYDoBWkCfUFVQNxqgwrQjNkiNrmwrnzTGVbZfTYibnrfOEzoTvQRTEzrJoVpmFiunkzHGpklYOTZxJlrgbviJIekeXkTESOgLwTeOmBtsdUpxhdhfrXIhGeVIwbYNodzOMDryfkrhuJ"];
	return KdTTDMbwvuX;
}

+ (nonnull NSDictionary *)tbqgmBkcfEVLIGoOe :(nonnull NSData *)JQOWhcmSvuQwE :(nonnull NSArray *)zMoyEbEXgxNEI :(nonnull UIImage *)dFxyhXeQYkahP {
	NSDictionary *dKkOvGVfBJu = @{
		@"VqWrQjQaXAKDjempm": @"URjRaFSwsYxODWhTiQCIBQHqZLkUVuVjvArdynYAGXNAyRGFkJBhQwdSWpiWMSXOAtnLKEnZNKcDMJlTjVALIXaeJcgKmokEsmCPvAowriv",
		@"lmqQFQTDenSlhLuLec": @"dvktgGeSGeleLKzUTrcGGrdxosLgJkmeRbvLBJwLTCEHqDTLDifAXWbeYehHDdULlRbSRKtcjspluLcnVLtGUSSdiwCqCjbVOTYRmrnhHxaCGAGSydtXGsLoyHbQPJCquBEOEjjuSzqQVNivzzQm",
		@"LfEXTXzkeC": @"ldwFLVKzGkHraxwyXaSbgaWpjKQdUhkbptPdlMfElUZRBViIPfJXPaUTPnOGpiFRoKZinMvWzsKkMpJpJHuizaoEdRniIMJgPZOK",
		@"sDHIhVLHYfeJmtD": @"gXfpqLQbjBVAiIQNMFnbLfIVnIMGlMGDtykwItSlYTWlAgmXCBbQhImUOwlBpuUbnwoNBBpXQRZeUZayUBlKhIQUYZMvRmaJaMEAumsSnYmBmvLEivn",
		@"mWAVgbcyzRTOfwMVFzT": @"XZBoPorhiuDxPvRnlzFaipQtRyQsDXMuyigfUdriLflVVboKVxJqFKlUZYwMGYIDyyQkJbfTKZLvjkuAZiAheTjTadBZcaxnWJQZsSSsvjgoLELgsQoBHsAUs",
		@"gNcgFPebwj": @"WpGWomBvnrNziUmYNLebwJeZGrpoAnRnIXvmtQoVOhHhCsZMFpxdLhUckAuVoYHceleFrllKWrRhYzUgDovKRTIfWMOWlUaomVCKcJDlhTKoIGjlPBbJVJUuwgd",
		@"vEpcRtxIMi": @"fFHZCibWZjHGVrpMwhAlsaMVbUmMsdoMsVKBxgxhcAShafvNRfDVIDNusVaMnhhoHvPXTVcEEwgGVewLqwTMMGheyMTOonANunxLXGGDeaWqIlznKXcvhFYuHxTnHpILvpDsedAjeRwEZgmtzAME",
		@"cErRiypdgylWt": @"PmicQOUZSQBTiczBvFGmjTYapDNtMSWNdkzuQBRVzEVbnzXRbdcKdrSVvOrqOUaXPjeXQAtRLXPImmncFVVASrjYLZsTlUXKBTbswRbakiXdgKPxImxx",
		@"eNWVxQezwU": @"PekmfGveTiURUMoWdHjJTMpDYsVLURhyEUsBVaTPORFxRRfeMdBmfVoThOqRufygJnAtrMdRhiHLqCKmMREubvvAtHIHyVUtZYqHIkOBDprJvnoawqFrzGMiIfDa",
		@"tGFHvNqzOAXeVXae": @"zMItzPwrIOmjaGTXgYqzsOcXtMjRhwgXHPZdjzGEEIEZxCTeXbSZoAYptIBABoWBPPBTqyGePyZwsawPdVYLrlpiFXTINGVlTScVSwLwLZiHNyFQVz",
		@"GMOSJXsEWxnSO": @"chLuyUDPifmaVgmDIhcbPwMpDjMUeaQTzmkCQbhnhIiWsizMkPadKBaJPevqRFFMGvSCEMGqRzJSdtoedyGejJKsWwNTGkDtfYtBpdtkXvwvqnwgdIDTYB",
		@"YErykmyMloHpW": @"wKveFIAZYGEIHvgHiXIKICsgMrsWCHFAmONKoWxDVXVNpUXHLjpXocEPrALAiNPTwyJrjlyfDusvkDOpaDtKYbLymgkdazJFDmkYjoJlguYIXooHZqZEFFOGCXzcLZZKYlRHZ",
		@"JvBjopHybwDspPEcZ": @"cJGpdAUcSGKSWWHZmXXrcJrVgrwDnkryjULtfIRrpqPlonyLDIxzngjhVvNGgbGfHlFqeaVDVIKoGczYIgATSIlbbTSQZHnhaHvEeahRH",
		@"FgYzPgOOLYFxSUNCrQ": @"hnQyqcbdUjRcZtzXOTQbUbdBOTthnvfbFccJaiSLyZKtZxqJmkNPOzmVtctzgsHIEipyXYAgCXqFYZxRODyISrXEcWiwVOlwkGliasZtMhsNBBVEQsQGxOfpdxgzLIQzLdcXvmZeh",
		@"UicpRyRhbGJOODajaAp": @"HCXOehhbvYPptkRxxuXbjnuFtFYgXCNDjrMNeCCkigpTArjBNCeZmJSvIBiMRwGMDiGxBSbokLHUrsOWmsRqqtBJZGdUPgcgjImNAEnlYXBWqSGbCuXrttVorEIJmKLcfanPKOhFHemNxFaEgYZh",
		@"ewNRPDYBFec": @"bRUYkxqyqzAVFJVXpupWCPQFeJpMZxvIdDPBBLnNioCkNAfISvctmhIiXvvQvSHsYAPJANvyhupAqCygVwnpXwygLDACkPaOgXXCwWZfJkQMOPCryWxwRJaVYKzpGvJiwAYhPdSNIB",
		@"kzlvhiqtLSJJxGNhLx": @"mXmDtDqZOZVqdmkFIrfZVmyVbSzBvhBelyebfBPKQSHoQXHNmukLekuDmjDKwFwEetJToxhHMRPYxICDJKHrdFRtJXiiNcCcWrpfuJQqFunMBgcQr",
		@"gkCYWXOHOtMNV": @"qRXJIrnbKhPlOYWRBEBMwwJbBXkIQxXpvPLyJeFheRPqaAlJYLeQEiYUIbIPQDwlozyfnStAKnubwvpgVnKnmAbSdryqOnagqoeMDBdoNnsyrncHxYYj",
		@"crsfRBXQoYdxJu": @"UKglOaASKDiYKPgMspDMWsgBfhNYtWmuuIcnsLUXLkNKqVDkrHjsqgkXUlPjoKNjfWObkpekqLtCODfGxClwRmGZMBdOPVpNPNpxPyVwXviMlQyhEsMUCMpeVheumTpcvlGKavHkXIuZyiUBAynu",
	};
	return dKkOvGVfBJu;
}

+ (nonnull NSDictionary *)OpiCWKYqTemhIdA :(nonnull UIImage *)pXcdmnTErQrCI :(nonnull NSDictionary *)mlbnLSoUroD {
	NSDictionary *IASYaUhWQPs = @{
		@"PKgkNYcMVzj": @"AqbosZxYyHcHOGrbDobqvgDegriKhSptAeiwwzkWBpyVtpDPtWHjTmKcBWtxhPRdcqvcZaXIMfMABQvUmqNnsJexXrLXtXSyaFgwzPrqqqcmdAOApjmTjMARBifBrDwuihjwru",
		@"mAqsJKoaaTomUj": @"CqbHBfnBrwzGQVdnFoeHtQlpGvYDhOZvAdIsYnaCZihkEDezrWxgbeqccpFpSMNthdhaRtQhSNJoHxHdNniGJplPEzWoRLHUUKLUKiEiIjfYrCeBvq",
		@"hWSDPXPfZOOvfmMJCnN": @"eDLdtytbHSBzgeQpWNQDZTOgWxTeEdWOqLUIyrgNxgySiEsDoMNLklxVDyqbzavhNqonSOiMfttVLsDrVgIXrdwNHJuLdiSxpHJUFmNvmHpiDkUprk",
		@"UToWdrQDEVM": @"iczntZOcqWNSRIdExMLpTESCsfuscqhKPXtbgkvaLcdxIMrLWhjMDzbjYjVEEWbsPdDiZCPHDuDyzvMEDCXFkgaaSpXEKHeNMDPwhBDIOtGOL",
		@"VBKsLPKnriORgp": @"lxVsKMJvNcCCiihXXSyxlYydAbFdAFoBdXyQONABVdOHzZXqafLMWCYuYwIAriZqMmrhDLEzqyUWUthBTsheeOBkRmdZxShnGBpd",
		@"gLynWFtNihayxTmBKXX": @"aFKbniAWiFMqJxFaqItRUuRpBcGNOqFCToWYumPDsdyGvkYKMskWcXcxvgZsbRIWMvJnRsPtcciLFgcIECxxgzhZtofpzllVZISoPiQUtToVEoxRYClQePYKLUjECbS",
		@"RDZKQZVHsPIteuzMqr": @"bhFlvDJnoadRCNIWeAJqxEjicFkgsnbktMRQRbWYpzlIcrZluyxecyNhlEDsHMVfxqUHxrcowkeRHQTxnKcKJYPELldZltbvdEauflOsjPcI",
		@"jrqiztbIJU": @"JKJtLFYiwyuAOzysXaQAazFglvmOiNOKHekbTwzupliqYNMnuwozmbixfmrlsbcxdBSZsQEZitIcmfvUGYMVJJoIadjSfSJZjyccfgFBesmCSPQHHGFirCYJaTJe",
		@"OdxfouMcVybaeWiDg": @"owKENuanpuZKtNlfPjwqAtyNffnIZcrQwuMGpNgsVagcHPhUkncTEaeDBTmYEkzEJBClBckTMxpbpJcILvJeMzUpxDpuSpjNyrqTs",
		@"JYVxwyMSnRCIVr": @"ReSqeJspoJPqTdtszRHKueDFXQIgMXbmQgPHaTWaZvPZuDNTiTSwLdfiLJUVVASTzNjPdMezpSQrondYXImmMOVxrCdDDXokkuPwT",
		@"otYEhzCSkCugfYoWanK": @"YgaysnJXJfVZgXgvtpaUxjJfPkRIrJBjORhJARpKUBHEyfkeMIljTAzltVSaEtnCRswAjYHeNMDnBkpebfiBHLBFNXGfYcaLwRTMeabbHa",
		@"cTUTpyqBGKru": @"fDFCyfURGcVFgUQNeoJQbRgEtsbwJoqXccxObkLMARSTAGDSJRTOGKiOaVhtmhrwIQFYLlueRDORfbmWDIsbXLFwYIAqpLZzitKdBYqtUTlPLqbQQ",
		@"irwtwKYahiXpDR": @"PwPZVGklSFssaXSJTDlmxsVGmMrdUvDBOOUQvmfdxkBffDglEvAzFoKODQYKpnBOaCrLWGIAeDUrpiIqRfBlpUmTutywHdipbfUiyLsyFtOVTvhVgskoCNcScGUbItALjoGwcPFVtfX",
		@"ZoWmrHgjyhh": @"exPYRKdbRlBMUdRlEyFnTEdJEacOfLYisbyJtokOlqiiFwabdOwQzOQxwQSPXtuFwpsphurDZWdAGkLAwDQnPBnhfXkxsKppgDmSgEDeXEKFNxttkxXJnJId",
	};
	return IASYaUhWQPs;
}

+ (nonnull NSDictionary *)TyOsBHFyOmRB :(nonnull NSData *)DdgADrWDkvq {
	NSDictionary *lWRgrmsIduRQ = @{
		@"FBWlVHNdOK": @"tLviuxmXqdDKJRaVjXCDQSpWobjkqypqaFkBsREJAzyEcHYdCzhjFvFTsNaAvTZkhCaHBhEBXjlTYdQZasCvoMPjZNdAQNPyFanukuaxZ",
		@"pKBXkOTIgJeG": @"RFsuqyhsHRijrYhXxFtgYSzfTedqGAGGSLoKgngrZPhuZmCRunNefJyVLGBgAPsGRnrhVLKxYebGUlySwbMjPZkrMqvcnJdXxUwiGRBfpNgSzbNaEKiGJkITKsjxVeQbAQyTnjO",
		@"MbHousRfGxfJPFlqK": @"kPAkwvePJGMpVXIwgpsuTvobutioLSYLYyWmsxasrzljioWYhPPxcpCdcIFCydVSBPfDPOgEWiUYHmVpKJnXjAhEtuExFvaMthovhnvkweFikRjBsuPZxRvxIPAdggEzHZj",
		@"sFfHSRxjwZOiFt": @"QaXCZmlbwTWQZWNsjqSwqtbIFZzQuHsELWGCCYsjfYKDkoyEcbeqfNaLAvvBnSWgONnrIHEUfqzblyOMzqzcteJgDjDcuSEGwVCnZyiOksczxuVNNOyBuciOGZkkAZpugDNbVwthwjaDACuaL",
		@"pyRahKFOJdxWPYIvmmQ": @"kzAEIcIuzTifEPMcXfwbkHGdAduzlJllbpdYMieWXrWIzrUGiKaOFkyOpFNvYbfAmfWOBSPqvvnoCFrxcpWBvqIXOOPQCxMLKzJEEzDPzX",
		@"ZgBdAcoanGZCzuxBGIF": @"ckjLvVxTeluOCImCxODsShtCvvcdNsqySLUdIRbwwuFRhqEMxBGvJFyEllsyfiNACUVSJpIyuAekUCuTnRuCOrZsyFKjGQmaOggFUZsM",
		@"DqvawaHdiLvQzZGNMF": @"LFgtZVAfTyWctjfsMDludeJYGgFBneNodBsFXJZcFIcfSlNAfgiKEWXADTvviNQLZMspQnLvQpVcbobmVQyEjJjcFHjDJoGNacEckmJJfgyzAUYZkYQuGuAjAoIiNKKUukGtGjMCdZNRPzMh",
		@"aHRHGRcwMb": @"UWYCuijeHexbSDOZsjlVwasdgIDuCvDTrwLcNuFySrbVqfCMrQAvjPkDqbccADkfdqGBkiaZHlWhuhgxiqIdgdrsYpmZkkWdLVrpbgEHhZPHrDvxJuigZHAVHyszMRwQnuXnwiIXItsypWX",
		@"tHrvAUkPfFmUBvSPG": @"KepsTzgUhlDDcKImuqIxtBhffKZSLVksHNBuTgbgyHskFUgbETXcGHfuCAybQmKVPnfRCWlwNPeWOOjHixtSYVAtSjwyTzzdVAetlfGgNomBvDiDdMdsdUwjtXuTFSMDlAEzrPdOAMbPu",
		@"nMkBUIWknTCD": @"VEMyMuGSCxlsSlzyNUgjVvoTmMCLnvEhFAjYRniNpBFzglUrWGjxYFnPYEXSzdaiVpyPPnIzIDtPzPhUjohZbGwjuxMIkdilEUXKpnYlFigucSmIqi",
		@"bIxiJfdkClpM": @"GrnRWRTdjMeEYEyflZDKknXLpIIcTfJIWPwddmxpFvbeJuEaEMfrNlzqdWpHonlnpBnNsolPgLMdudPTFnzEdcYccsmEZNRmenEWuwWezhFGjvoAVJMElQaUXXOnvFA",
		@"CYqdbDxPYzpdmHS": @"ImJcHgUKsuiDLtkzrYJgmqkmKNNKSMeqGrQbRpNikvWqkKkaBYCHgWekvCTLLhKdxxyCUhLfskLelXUwzmnNSrEBwonvKuVJkkgAU",
		@"DXFniHcoxjqiZZrCvaF": @"opHLNLHTVHnjjwovREzovwRgGQoXgeDJQHxDgSdrpcSgbCSTAfFYIRviQAYEunPxNItreyyuqihenGKcMGnaXLRSLlprWMZHbSRXLvPrvUwyMCJqQJM",
	};
	return lWRgrmsIduRQ;
}

- (nonnull UIImage *)gVTBfdkJQiRgHewsU :(nonnull UIImage *)nhWNyofTKbIAHWtxed {
	NSData *pXjgHecMhLS = [@"cTTwMiXfgneRtKmiqaSPWyHyRGItNJXTmzrBopoviwLHkaSsmhoPkghrmZfEsRvErcsGJecENhmjASzKyNyQHpeZYdMHpRtHkHGdJuCZixlMTM" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *BfmClKPmmvDXkxxStK = [UIImage imageWithData:pXjgHecMhLS];
	BfmClKPmmvDXkxxStK = [UIImage imageNamed:@"xAzBkNkpWvCPPnpBRJpHabBxqwTMyLNXqXYAbClcftkKOXnVSHjpvedpoVwKlGSKcGtIxKwsRJuwiElYJNKcpSkBbxgXkOmXJUlDyUcxdQaBRSmGKBPdmpAUWDzALMihLJbmClaKcaHvBHh"];
	return BfmClKPmmvDXkxxStK;
}

- (nonnull NSDictionary *)fhYiEkYoDb :(nonnull NSArray *)JcAuuXSdunGaAnv :(nonnull NSString *)APAIFhFIGm {
	NSDictionary *CXvpoDWGzdyfAaVLB = @{
		@"gMljQREaCckdRSdgF": @"nPClPzEYLyOESDIYkCWBppxYCqZDLdJciirrqvGsLopbRZtQUaOhaCumnBtBJHbjaUhGHOByvjMaBSYykndIArGAYpiXnienTtKZYRgNHmpQHdQjGnvPqGjGMrFCGBkfOwfFLvMMXBwRv",
		@"fLFAeXqlrz": @"uMWXHsKbSmXuLHytqelfzWuDywPfDSGfPYnYEXDWCUuLpVSWVSBAyEhOjaKfhUborutwYeFjwHrnuREItBtbhkKCQrukQTqUjqqSCmqGqTNUIAqXEhgMPotUF",
		@"mIoBvHJjWrEWIAi": @"HXOmNqenqjRbmvPHuqrSYKyymQtdyAUADMJMrJlFQRjkzLPyEryFvuzpyqAOQBIAPhdChGwhGLSsrcZSfGoLOcpaHOjewNbdivXgF",
		@"iTOOnjfEHMpZlGAh": @"uassjvjnMpwfQCmfkFitVKpGPNuayBuquEppvWxULsAydPUCBDRCTOozPpCOtPMmsqbMJTAuZSAiVVUSgtOAsxPcGlfygUMXXtttOPnHlZyVeBtSBJuUDvDwTwMibPtUmCmtuxchImiqgu",
		@"pulQoDoMeb": @"lzmVPXBWhfIvAjEvxeOIVcvmNxtvavevBCFDLBEKTyrcGPDzCkjUaLHqiRxEmdDzPLMcwDxAgmKcZsnsoEKlAPwglfzBJJzwsJHrnXxxSLenSLWUBVVGFMtKrZpu",
		@"dnkzNmwiZWvRhTMod": @"bhHnxQHOPIuMAZhnhPkrgAGmAUElDudETKCJQYaJSIFDfDEnEahIcVYaDOVpwHvXkLAIIYJXkLjFMdFpRtBXlOWTRNjoAEAXAdTKdZYcmhhGDdQmAAoNMMekkAFsDaHYsPPMmhAPLtOr",
		@"qAzyNTeKryr": @"PCaMWqDnqZwCperULetXhlmLRPzHgiiedFwIOKWxWuIPKsOYxOaSuVdETdBAyiLwFlSHlZZTRXhVTvezezNCvBLkqrAfbFdmIwgJiBRCovtNbnZwXYgItLV",
		@"PlPaPQoVrfnKlANNrm": @"TVNoCCzqZiAlZlstwRlSdGEZxpHrrjuVqfYGmqHwVfOTajdXByABKSdyQhYkeTgdDtPYcnWEXHNGfPFAMXSkgalLUpRsKlfdnfiTJXWeQanWhPLOVGurS",
		@"KrohLfxKhy": @"QoHsSHAEKZjPrGZksDjUmqsOWoyBsYBvavNfiVQGfpZyeXlZlDbMbBVYALFxPeprufOtOnpfpCSANoGZckqgChzawNkVSPKAoKulPZiMFcYgsefYwodMguadALpKrxdOdlYjM",
		@"rmwwnIBEcVGNPVTh": @"sKQeetPsxjJHyZJFEVeORsuUxbNGxemeNPdMeWqAYoFnAYytUwGWOILhYdXDabWnaScuYQilgpWlUsJSHXSRLSqakjtdJmQBMFHgI",
		@"mYffDUpaOBGCHIxMnus": @"QIZivpcKMRAGMGMaSxhLNkApCsvBuKszmzTeccKVzjdrTzaiqOdWxcpugVSfOiLbYPecAAKPbiKnbZKOTNcxsujqCWnGeytTsmELGlTvpEflphoMUEQVCWIvYIBd",
		@"YQDLtterFZUkBeipr": @"pHRuOGvKCsuAVbbjNAIvzgZrYihUYNgzUCsjfLvfyrngcKUtdprAGMVERKnkyoFKhlcXWwctUinDjezcFsZBaOwzUtaKozXBiqzZ",
		@"NzrBjnWWQPX": @"BbmwBEfjzMBfBuSpAmYLYIXACLcZnCUJJapDiUDxSZTUhVoDTxUDgPeKxcKZYQSIJPOxqHXhhPuBMsIgdpOrKvZxNrMzAFqNNiRpgcZzNxuBa",
	};
	return CXvpoDWGzdyfAaVLB;
}

+ (nonnull NSArray *)kgKXiUnERrOcgXK :(nonnull UIImage *)ltseTwPdRJN {
	NSArray *YyIVIPonCeoMVLpA = @[
		@"ZppBglYJfzbCNtoLeoXqEiFXoxFEhdKAyALdRXlclXlPmbRUxPrTvWrwIYGXofxDnzJUfpDcHYzBnCeEwpEVExvpDvJUxUXfLKTbWWSDVtwkBSBwguZUtiAvBsSSB",
		@"aXtWgaNmvSzvhZsXEcwWuoXPyOXAkUAZcYBJTsXgkysdXeHjPVoqCdldnHjVlwWplrBBYeXpgIvivEjGefQwZeaxkvaZIUTyDdgtQMffKtimheLGsim",
		@"WQEigUFTnyotaHKBYozxEbZhWXQzdAObvrcbPoSdsbHCDAMSDiSLdZmgyDIZUmVyvwXqsVYvnurAowgMzROQYaIsnkoyCccGAUzFttytZBnLFIwYsDsUkkbUtbnhvsarFMKSInkoc",
		@"IbFTsdOAFMkLbcYYKdlzipwnbtgSwVAQMSwnQibdunLZoprpeMTlvtsPRLoBBFtrTGzIcTEblRLuPlQqbxOTvEKaJGPTCtFdLuimGBJSdHfuaGzQoEunWkJYOYrVqWqDonem",
		@"KfSTIqCzlltWTOCjxeMAVxyBJLEonwVwMiwcSdCHoncHpnAzJPEdedpTCcNZSoBUDcZyCoYqdPyOoSKZxndbUGgmFmpjkPGwUoSmHhriIQIPMRtnAbUTNkWkRcWMZ",
		@"BdtLDTfEUUSLahqObJmefMUrULjMrGEQEAlbcwGLsobdrLfiaTOmCATvqWlhstAeHkCMhTmYOLOJjcAecKlqRrGPSLFqCPgqpUIaejAMGOVhLDHRYpEnVmGiXgKV",
		@"htHnDAVjFCmpgIggxBeCTBJPrjMCGRDgMmDCiyjwigsiZUOIPkqOULhUCtMOloyOYeeqwzEyYKxwcuFMBSIkAfnbIIpiwETjXiUuIVSNMyCTdGRCEa",
		@"RkZCPDNfPHGewddhbIagvnZwAhzEUSlVEGzqcTDUaGIKcxdrvhyYNGdwEKvQZhLyhYAVPhuXHHPhVReExpAdsHUyuKTtKKKyZScVexASiDtNsQcxDfdMV",
		@"ZSEsmYseGkjvXypiMLcRKuinODmCIYCaeXnHKOEqMpUHOOZamthNcoAoNxAEVEDkbzDHtkObYwpPiOqXsDmNCDXoZvJHvgsugXeuT",
		@"oxKFwKznMZiIUPEIPLrBHoUmmCUvKPhtbnXWAbGtvASXARuaNcbnsYKNPCiASrfBVkUXtwxxVVuXHJuATjomloQZmXdrnvWgXBpvQhxdZRwzNBsetO",
		@"sETWrayRYYoClneVaddUmrOCHYkvGWsikfMzNiGLQWrPhCMtFPWLIflTPwmfzOhzpoxWTEPTldVjqQFeNAZKLCyvshEMpItexhGGXhZhTUBtRQFHAemgZUBTDQjAQsaRawybWpEpBiEFmXeFsVwHA",
		@"UCxBtqmNsLWAWngeAbUafeuKSdVJLKDTexQNNlxtkviukrtPeAOWpOWFWUVsjLsEiaSZnRvOctOcHsIJXuHZSCtpABhPvCZdupIpKhnwsolhpMcUSqlSuelKujsAECyKLFSRMY",
		@"ysoztjvGMzzQWLbrwZALtYnxZujBcahJqZENPEQCkjFKytzdYEgkZBYILLymXiyJLFNuGEZYhbdjQsAeeimsAxigWSIuFdBGndvPYhevUPwZBMzMDHZmXhKejUlDTYLqwLQFQHwYNUIKMjaGSrW",
	];
	return YyIVIPonCeoMVLpA;
}

+ (nonnull UIImage *)meFVgGEown :(nonnull NSArray *)JgLVCqnMBGMW :(nonnull NSDictionary *)DlQUwxQwMpMgs {
	NSData *OqiwPRSGcnIOvI = [@"NekhKaLmgVZbNFBjJCjrtjXZaLSDfSZPMPaowSyQEjCugTeyEyrBuUkwwiYLUIHBLqLWZwOiOaBAGpwxzDRWIqGtrbMlbnUTZHoSRpi" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *dfnWFBEThsXai = [UIImage imageWithData:OqiwPRSGcnIOvI];
	dfnWFBEThsXai = [UIImage imageNamed:@"WWKGVcCRrDYHnQxgcPSprAcJTjLVXNCovQLAFxhagOWGryzRvEHxcTTXhuaIncetlpCwlChYVGzjESJLzoYdAdRkcuLvtcNRJHcEHyjjiGBAMHBLvVUCFSNUBVCMDbFqGcpkpIZsYJikLZ"];
	return dfnWFBEThsXai;
}

- (nonnull UIImage *)bTLIAEeSkpx :(nonnull NSDictionary *)tEMTVnIzKzKka {
	NSData *ZlzFTNfUtN = [@"eeHIPETszkNLQlxuLjsbKJfvclWymylnYwuIEzFyyiqASiLtolTRqPrOxqLhbknuIGufexZMNpjloWCAnUeBsOyIOhQUfrnHdnPwjuHbRkJClhhOT" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *rYINiuuvUoiB = [UIImage imageWithData:ZlzFTNfUtN];
	rYINiuuvUoiB = [UIImage imageNamed:@"KUNyuMTpNvpIpUTweYxWvtlRvKztJjLrdaGdiySeRoBkJjQqcpmkTWUHFlBtTZwQtDljtTcAHqYXQIEoPNxaknbQNZiUTPnBKsnBBsMHfJISuzDOstfKUncqJKjyUyxsEHKOBYd"];
	return rYINiuuvUoiB;
}

+ (nonnull UIImage *)JfeNOVHygEdqkUp :(nonnull NSArray *)vQcUQnpSaqKpyNJt {
	NSData *vavohtubyIOfnJyMCn = [@"oipNgUFFiZoSCrFkFbhVAveHqzUCodWWSaZgblDcvmGuZLCXvlpvRQflWuSgZoSBMOrjkEotceUSRHaxQdfwtgtkgLprqwPoGskcdikVLcgZMAECipuzcunbjP" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *LyGbDIpZjyQcS = [UIImage imageWithData:vavohtubyIOfnJyMCn];
	LyGbDIpZjyQcS = [UIImage imageNamed:@"oKBwNgmVSTTfjrgUyqwUzNoDBROOmEAHFSZVtjQoEabkuFBkjDSQNjOHxwvnvUjjxqpaJfgosPpQzPjpmkcHEhsmnClnYWWUJmgavSLWrVfCFZfX"];
	return LyGbDIpZjyQcS;
}

- (nonnull NSString *)fXcDXZKtCNbkS :(nonnull NSDictionary *)TWFPzkdUxsV :(nonnull NSData *)lqBxjQHUhNQ {
	NSString *iLCdNtMsztAS = @"hcULmpvWUURqFPHtBBZzjEodcIUgYPYPeyJZwIMqoBhIQWVtjZmSgsSeHypKOOeguipRIIRuxptLPNLUltfZlXDMiTFaGiKmzghFDAYqKvziWQ";
	return iLCdNtMsztAS;
}

+ (nonnull NSArray *)lMMdFbENucdrqzenA :(nonnull NSArray *)HFOepozGPcRuFwGiQ :(nonnull UIImage *)xRNyAWVzLbtxktAkMA :(nonnull NSString *)DxLUFxEaYhlJp {
	NSArray *FDNZphWxwoDkfaX = @[
		@"PjNNTbXwWhWTRUgVgIgkjpLnPHvnzWjMIKKhhvVGPqwKbFAzKpLCfozCGkoNOazNeWKPxyoQSPQLTDkojvqtoFvxrKwGKqOHLllDELpTNIthXRyeSPvTmTXbLdHBrDG",
		@"bCVvkagKarfCNnBvUopTgDLyXOmwvcaDzGdzhjVAobTVrGjFySivyFsBwaXXgrvnFwFOXNahNzlSPPgtfikQcefRbPypagCaJSXJXurIfBXXzYOKrfGKdbqJPVGCMBJzLIseqrvk",
		@"cRxPSFbjWzJaJpibnASvbVXgQTWnoLwTqbKzGrzQpqicCBGcpPhXlDuCtHuZpfKRgeZmbIPcJwXSwIzNijwXgTcXvhYYcsROBRpsjmHo",
		@"pKZLEAqIeYmFYIfPyTrVgFEGRoCLauOtkmDAegpLDOjrYtEvoOnzmYjLGlPfsxTPfdsLmiQNMvCsDXpKeVdvsHyxKWWhyfZWmxTQtodngVKrl",
		@"HGxMGQwIeuLSzblPEsUCwBolbRfVDBrLLtygfighygkWYbWhJYnoJzBpFMncvSFgyoiTFddSVqWPUTZpvBRMWmZXDSpvsNMwkNdnStDrWBhdFCCEUcCG",
		@"ppsBVHPNhlUGPQSZHoVaEQDZabMOsrPdCRKcQsYiYAelovNqmEbVtfSoSUGkRpfCfvlIfUhEbAuoilsulDQYymrxaCNEamNnJbboxRLaydttOKLvmkb",
		@"vSJIUzQuAKcpVTyPgtbwBfurWiKmhxJDZcpfGkQTuUENZAqMkBJSDleNVfYcuJmOPaMkmtqbIgCHvDWHzlNciacUVMEwBWSmFcbmyQiSojKYjlovHeDkHxqGXJAplgmnvNg",
		@"ryGMaMfnIYYNQgnOugaYVswAHjlkbGXNcjDgsGAqqvjKGpYtYHhUFEsZpWMGzGGMCOCRESXnksjgAyWLQGuZVtfbItBMvOMbCwbsiWFLsOtnTVKHtDRrfWQSHfTLBgdPrGWOUWtJ",
		@"TAXeQFengblSuqFtwvjsBUCvOdZIkuqMYdSpYGSRMPuEEbFJzMWGjpoKVEbvLpptPucDHTrCBYBqguHJipkWjZvseaTAqskalqeR",
		@"mYrgzFvFPVptILRXikmWTCxSHqdLLdyHJtcbnSBGMiyiUrjjaNCCIgQGLgTpywdNJvkNAXiOqLJsuqHvUJknbkWsVvOWHKUPmfAnASZZAScHrsYlElcfYEjYVegfBPUNmzeyQCQlNyiZMTIBySn",
		@"ELCqFSCPLtDyUWTzyiBnjvJmctxXNzNirxSErFJVxBwzZyEWGovXMvDouGgpQDGtpttNqudqoXuDaqjNGJbGkrfskDBdGRbmBKSZJ",
		@"BvHkTLOaIQNsxsPUtyvRmevExVPwaqKtgnOcPsSkdyJwBcAeudULebtwfzatyboZjVxKKAodqFuULHXxJRpLDIQIiGnJDJsiYAylfOfkBMkGWrHzdkCvfvYOzEpnTRRoFjsRzxawMwgYP",
		@"XfJIBxSvnvYmdwaEIJfEzlcVkjkiLkMBxOSsRrHWooJnsjxzCUOTrmvAVvCZTousjuZhbMQFclhXFnwIErhcpEYMtppentXPhBDg",
	];
	return FDNZphWxwoDkfaX;
}

+ (nonnull NSArray *)BzrlNpErxkxrRvUufo :(nonnull NSData *)jHFCJtJYrMqKJ {
	NSArray *NphPFwqmudvcBEOuXAK = @[
		@"xLvjFNgqXxgFZWdmJHvXcFMXRsNQVaxSZwpMuUVSBGPdCJkFtkTlvubaUZlhzjiMSxRAUaUJGZHpcqivlysUKCZFUFMRlPkFhRAHgahdbwIgZxpUdgKIrpXahgTIUoCdIxyNAyanvLrEhgpJxqWLo",
		@"bgdvsbrhZpuAXVbHypdCNoKfrnZcGofYpXZdREbNUhrwGWgynPwWHGjVAsStJCZqyyZRViwJAFUpScCwrODGaBtWZAoHbDBCHDprcNKLMNHmXAzukRKGQmXSXUwWFYZKpWDnZUbClLwhKUe",
		@"sUSXmGnhyyDnEaDKCOZfuZPKhoThBPHfgOgEFMwXsCxHwUlVakGuaeBEcWTNBPgdvXcNZVCZOZYmKqlcChOSsKyNtTKZHyZgTuwozosUEUkBZdeiVlOqWJzFZTsJmuAbCuvRinbPoGKYbllAK",
		@"tjgULQJFCDBxCRgbbdwRACrXOXcjSFCqLAfuBvdXEFOcLQSrvRQkmqthvStzVTjjcxmonuEypwONsMdIWhlfnAqTXRebYDRNakBXpCVDFnaIzaKEleDHObEMguFtnPKkQbfUppxkaItpqBpQUs",
		@"HpZnGBKJVTYkJkiiFguCzEgGpPiUkiFoAOVAeIgwTWkPzqNpoNAahAZzdelRxYSMjaGKrEnfvkuNaCxowosMLdllaUdsmhtmjkUPMUBwEhxIlYYsOdcrsYeYaL",
		@"FwKdIqdjqPYWkRdBZPpOxisvzTliDSffRPDvKqbKMKuENzIQMDnYluEzwEZBRkcPIRxQwrooVcCvVlBhfNmDImXhVuHDiYLKbenJzhJuFXyXZfBzxWvJLFesBx",
		@"TZUNXbThBZQdqJOAmUpibCXfWonZIMryCGBVHXOEzrwdIbWzxnfqCiWdmeQxtwCFykCLQFMRezkplkYFKCJzvfpRZbKjGewylPCFgKhbypfrXRyPlmZOXmHjvKvMDiVchdQP",
		@"OhJhYONNjKcYDkxDccXjEYrWiwTjuEcLEhsDVHqHASwgKimImnSOewNGyGpmRNAiExxnoSzMczeUZoolnRGPPGUmLCEWuINLymOsIafWJbFeHigTpUFX",
		@"TvRmEoFHOwUZJSyprmLSwBcHaHmHwaJiXdyjbiLecaIPwKTOcLDpgHTZrCPXzETaBRNVGSSUPAbNuanfTFpjHpydIoEJLQATcpQWvqdToOEwzrZDYplin",
		@"nWdhpEKMgeUQKzouyKygEcwyKPOECBVZfJVgTdauNoNSDDqOvuETOqUiedExeeFTZWvCjhlTVlRHrknnmHCxIOrdOuvwYvACKgZRjTXIpMHMiMlSwXcLHSDfmNoiSnFl",
		@"csgmFbBwBsgfWWbjeCuIvAAtwvZsFiQGwNLncDMqLMWkapYmvagHiUJsiTMhuxDSsJKqfIfNXvmrvgADgoRAhmfiNDqBljvIWKTmcldpdujLwDFKyQMVbSblycprAuEz",
		@"BzRIhozcvXwMSJgMAlMaXKocInmTtZBRFcjoaTfwwYIWKPxzpdzEcoSiWXHDeJvwiyqBnWOpkBtCPLzoJQosOTTCuIARaLOGjhHbNvZgWRBoBFeOmdGSJXtFDudBCpB",
		@"xoxOMvghzdFiLRzKxwQimOtmxotffShbiQjTFwZflckYZDjkCBAmpcqlrwrkqJOcZnvItlIxZUlFRUXSqgzzjHRLPGAmwXAQaVmfviympBbIkGQiHR",
	];
	return NphPFwqmudvcBEOuXAK;
}

+ (nonnull NSData *)oAGtFQASEUoCF :(nonnull UIImage *)zjJLOOfVhRwtJXlF :(nonnull NSData *)fGgqSqidNzZs :(nonnull NSArray *)rIHgOMErrSNkolzIMbc {
	NSData *eRihxgJLEYQoHfeazP = [@"CfCbbmiohcSTuUClXrBZuOGXGCHjGTfUILbkIfJOQQPYNLtApBbIzLVgQNTMmOlauZGOXjiTOpJIkhzamsdumedVYFBdSlSZjPgVdcFJHTEBLpAdhH" dataUsingEncoding:NSUTF8StringEncoding];
	return eRihxgJLEYQoHfeazP;
}

+ (nonnull NSString *)XNXpOTIsoPjRVXdwol :(nonnull NSData *)HxYcoDuYMmCkaZHusbF :(nonnull UIImage *)ttGgAUDiODLuCwlr :(nonnull UIImage *)JMLVfqYhVSlOOWljo {
	NSString *hbkIrjosEmg = @"dpVYbmfYDcUYezpMmdSVkXXuNGLkGfmDpYdoYgNiKOpeFlFjpYOqxanJMySjpEojWFJmBVsIzRvLbFxAGcTHKYFjRuyeTbfYUinDJJkoNpRZlZnimVGzFeGrHiS";
	return hbkIrjosEmg;
}

- (nonnull NSString *)DcbctKEjPCtT :(nonnull NSArray *)RYelHKVoVTL :(nonnull NSArray *)zEVCsenStiC {
	NSString *bqhkliwbfJkjpHYoqgt = @"wHhEzeYpzvwRJWsuIImdQpcZRntSxJulmGZDyjaMpCoLYmkKJmKlGDPxRixshJwNupSNlinZHhRxtcPkwRTayPkNWNmhaIETtaHBUtPICKLEiCSlHYUSZSnNkjZhTKewdBmKWbXqcOnk";
	return bqhkliwbfJkjpHYoqgt;
}

- (nonnull UIImage *)ejdDHEXsixIzC :(nonnull NSDictionary *)AhiRGfEBobA :(nonnull UIImage *)xOlcGzHEIvtcmvZxT {
	NSData *xnWodKRoMoNLDfmyYJ = [@"OkNAglJnHTPridjaKwNIOwbDtbRAdZNjmxAIzqZHqPFsEENDqIXutSzHNmbkSzWMsOAxRWtDriEUgZzCtHdUkNhYphwntdSyHjIuluHJifgdFLGJtgsliNaUDmwkqWKCROPLdzHtBaStOlDqYBv" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *obRRpQkOaywAJvvn = [UIImage imageWithData:xnWodKRoMoNLDfmyYJ];
	obRRpQkOaywAJvvn = [UIImage imageNamed:@"VgWsDKJoeUBshMxuSRrhfjnOoKcJmiPRhRBzHfctoPRukNSvtLujasceostNDXbPBfIJoPKElMnKQBpYDcfnIXSUrreiDakjnphMKrotMbYlelMFXIbKEkAcDqNTPdTzXhZWqBDCwTQxQgIYTYBd"];
	return obRRpQkOaywAJvvn;
}

+ (nonnull NSData *)KfuDxFgjClvyKsqxW :(nonnull NSArray *)QlQhkRanSTQexYzdyL {
	NSData *unbjbloQjeCPmuK = [@"ITJDufwMVqKvPnFWdPenCfRVtuxqqVLdRLmMvfTJAMIpNVCDqDbnIcUBrUpFxcNLwOGhSpPUFRRysPHfwrKYefCfwtSTyGnxBghbwsq" dataUsingEncoding:NSUTF8StringEncoding];
	return unbjbloQjeCPmuK;
}

- (nonnull NSData *)bFXbYHUYEreiBn :(nonnull NSData *)fplgBkDwxeAtkFpgH :(nonnull NSArray *)XwZeJYNCIQZZYdOvAnG {
	NSData *QwmEqbmicZwnllpaZC = [@"aMqxllHFduRAoUbzDGuzSCGTIYBWVtIBEhciUgPflOaxoDTKSnfZcmFMLpaWwkKoIiKrNtSTNfgJdfTiChOOhIiUJZZwUerEBLFAiDipttIIoYaBFJNKVcIROoeUUecOsFRhzdUWkyKEJnTjLJaW" dataUsingEncoding:NSUTF8StringEncoding];
	return QwmEqbmicZwnllpaZC;
}

+ (nonnull NSArray *)afcHEHASVJhbXtBe :(nonnull NSArray *)RwzeqoLkQFioWSX :(nonnull NSData *)pZFeJSDpjBJlfyIU :(nonnull NSData *)ZMJlzFlbcKtJqYyqvM {
	NSArray *BFGZPVSZSQjBD = @[
		@"lJNTaRnEtbfVRfiEJlbtNxCjDqCcFBaRtjOUEMEajwpdZZkJHEkOhZtPjhANJoDddonDovmGIyOvmWjEcOekZutcnrvjtpxLiGkhduTPjCOnbSzn",
		@"BvBfWmwYSOQKCAigkirFJogVsKwcACiXuSJUSDSXdnrCmYrNZdHjqwVhyPYoRgdUNihGCcvajBQIggmvNExjLOGJlTmYREFVAUlqbnjOLSLrshcOAUNjeoZTGPgOiJrpVEXoF",
		@"DfhZKvfpuMzMYaZRCafgGbXIbiHwghVITFkgdYnxbkAfGipXICqyCznhXVXnFdrmEBgmZRiKOmcWSoaTWeSWjYHzzgZFBLRnvQJjnusKVeoXOIkbcLA",
		@"ZbQCowmtTyxylkOxVQBcvQvWwwUPNHviqTABhNILFtBPlGAfTDOXdlBhfOSXVZijeqdqlkqxQwnXDHFyaZMrRmjUYcwKhEmovzrEd",
		@"MhYjIjpBgxncTmhgVHFlOeqtFZUducgqZcivRnKZBEUEWzvyICUQXSObbPhtumFgGGucXlJpllfSnWzeXisTukRYHOedEbcBuEPqRIKAWcYlmEaKOk",
		@"EYMCWhecDCfMxkMODpFLhtlVPEviyNaRPyOsNcCLBwqLQjPDpDqlnYjqzzXUErkRIQqrNQNGtCqzYgWxwGqtDAfdANDPCHrzxtYJWCQcxeIrDCyuWjeJe",
		@"juZSiGCDOxEeUTRNqLLCQRgKAUjtqNSTedNTGkUOTlAbCMvGOQmPrnTihEbJWhwnOYgmNiYkMjdNMykjHGneMnKcHILlmFtVzgslpuUYWyEzyiBVNXJoqNijeTawPDgbWYJgjymZWpMYGmFla",
		@"ThkmQcmntJGwnDxHcDogeEHmnqngpNGeOgtmmNzFpUAEqZIAocOTJRcDbxcyibJBHfPNWjkClEyJSjPevdkzBRNulYzddXDBFbBphrmEoGXyNknfaEAjlzYAaTMVESBHnk",
		@"YniJViHjiHHMVRHYpJdYFgHujlfNzvjTHuHiMEpxkJbyiafOCpilDnkMFchApRtOirBfdVeHdoJgGJmjggtnMIJjDlnjmesRXcAGEGIFfNAioFHuLYcuoUQkRlmRKeKiRRcbPMZgtJ",
		@"DAuZtNpwYTDRaTwcZEPbDplaZSgRmDDlcwNlFPQGwDVxkokVsUqvdktDTCSXWRfxkwMgBeZSouISnnYozrGGKIdgCytztJwtmQvMLxC",
		@"yxVRqiEdyMGpfETxgTfKVLcxpXnOoSyGBguGiDPqkhJVhBGdYdBgtfSnJzIDrZlfmCraWOZNCFVoBZrFdltRXbhXoJefTXLJPaQNqvfukm",
	];
	return BFGZPVSZSQjBD;
}

- (nonnull NSData *)OrgcGBxuvENddkmUABV :(nonnull NSData *)qKhRLsRrhJKWack :(nonnull NSArray *)zLNeSAXowh {
	NSData *SpzObKOgpLdHXCy = [@"qdEqqaEWPRUpwiUuQLNlOyZODhbPmvDOfJvdYdyxQlIqIxNcIzbHYdxMsVweogaNdSWzrPoSmgOoTpCfuWGvzWaeJMbZhOiJIzhcLA" dataUsingEncoding:NSUTF8StringEncoding];
	return SpzObKOgpLdHXCy;
}

- (nonnull NSString *)tYRLyfCWjZKlpA :(nonnull NSData *)xQdLClxnRYeadr :(nonnull NSData *)jaywnvTuhNxgYMNRIAi {
	NSString *DTkFodtqUNbcAHgIPD = @"XYbVGbmRrQnEMLDTDkezerUGuCTLHKCgXSBuaIWMWPiDnEjAROCNRaKIvtyFLlyrSvsaKdWUUPiNDbDViiJIWfolvrebrmjheLmpUiSmivweTkKom";
	return DTkFodtqUNbcAHgIPD;
}

- (nonnull NSString *)IMsZmcBdNNw :(nonnull NSString *)MIceGzwuKzLIoV :(nonnull NSArray *)fnnXklkLQthZIOj {
	NSString *OzZFLeDWqbGd = @"qkIxcXvNUEMwonRBFPwrGApUgkOZeNkkVOSyYvRqNlqMogtOMrYQAdVtsMEnlqZrtIljQKmNYPkHawcewbtsRPLrVaJznqigWfwLOqWW";
	return OzZFLeDWqbGd;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *isUserResume = [[AppliedArrayDelta valueForKey:@"user_resume"] objectAtIndex:indexPath.row];
    if ([isUserResume isEqualToString:@""]) {
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
            return CGSizeMake(self.view.frame.size.width-20, 172);
        } else {
            return CGSizeMake(self.view.frame.size.width-20, 172);
        }
    } else {
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
            return CGSizeMake(self.view.frame.size.width-20, 216.0f);
        } else {
            return CGSizeMake(self.view.frame.size.width-20, 216.0f);
        }
    }
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 10.0f;
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
}
-(void)OnEmailClickPendaChange:(UIButton *)sender
{
   /* NSString *strEmail = [[AppliedArrayDelta valueForKey:@"email"] objectAtIndex:sender.tag];
    if ([MFMailComposeViewController canSendMail])
    {
        MFMailComposeViewController *picker = [[MFMailComposeViewController alloc] init];
        picker.mailComposeDelegate = self;
        [picker setSubject:@"PinguinJobs"];
        NSString *stremail = strEmail;
        NSArray *toRecipients = [NSArray arrayWithObject:stremail];
        [picker setToRecipients:toRecipients];
        NSString *emailBody = @"Please write text here...";
        [picker setMessageBody:emailBody isHTML:NO];
        [self presentViewController:picker animated:YES completion:NULL];
    } else {
        self.feedbackMsg.hidden = NO;
        self.feedbackMsg.text = @"Device not configured to send mail.";
    }
    */
}
- (void)mailComposeControllerSend:(MFMailComposeViewController*)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error
{
    self.feedbackMsg.hidden = NO;
    switch (result)
    {
        case MFMailComposeResultCancelled:
            self.feedbackMsg.text = @"Result: Mail sending canceled";
            break;
        case MFMailComposeResultSaved:
            self.feedbackMsg.text = @"Result: Mail saved";
            break;
        case MFMailComposeResultSent:
            self.feedbackMsg.text = @"Result: Mail sent";
            break;
        case MFMailComposeResultFailed:
            self.feedbackMsg.text = @"Result: Mail sending failed";
            break;
        default:
            self.feedbackMsg.text = @"Result: Mail not sent";
            break;
    }
    [self dismissViewControllerAnimated:YES completion:NULL];
}
-(void)OnPhoneClicknPendaChangefd:(UIButton *)sender
{
    NSString *strPhone = [[AppliedArrayDelta valueForKey:@"phone"] objectAtIndex:sender.tag];
    NSString *phoneNumber = [@"tel://" stringByAppendingString:strPhone];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:phoneNumber]];
}
-(void)OnShongwResumeClicksdr:(UIButton *)sender
{
    NSString *strResume = [[AppliedArrayDelta valueForKey:@"user_resume"] objectAtIndex:sender.tag];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:strResume]];
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
