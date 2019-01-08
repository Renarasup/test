#import "SaveJobPenguin.h"
@interface SaveJobPenguin ()
@end
@implementation SaveJobPenguin
@synthesize myCollectionView;
@synthesize FavouritesArray,ApplyArrayPenguino;
@synthesize PenguinoNodatafound;
- (void)viewDidLoad
{
    [super viewDidLoad];
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        UINib *nib = [UINib nibWithNibName:@"JobCellHeyJobs_iPad" bundle:nil];
        [self.myCollectionView registerNib:nib forCellWithReuseIdentifier:@"cell"];
    } else {
        UINib *nib = [UINib nibWithNibName:@"PenguinJobCell" bundle:nil];
        [self.myCollectionView registerNib:nib forCellWithReuseIdentifier:@"cell"];
    }
    [self getFavouritesDelta];
}
-(void)getFavouritesDelta
{
    FavouritesArray = [[NSMutableArray alloc] init];
    EGODatabase *db = [EGODatabase databaseWithPath:[[CommonUtils ShareInstance] getDBPath]];
    NSString *selectQuery = [NSString stringWithFormat:@"SELECT * FROM Favourite"];
    EGODatabaseResult *result = [db executeQuery:selectQuery];
    for(EGODatabaseRow *rowContract in result)
    {
        NSString *cat_id = [rowContract stringForColumn:@"cat_id"];
        NSString *category_image = [rowContract stringForColumn:@"category_image"];
        NSString *category_image_thumb = [rowContract stringForColumn:@"category_image_thumb"];
        NSString *category_name = [rowContract stringForColumn:@"category_name"];
        NSString *cid = [rowContract stringForColumn:@"cid"];
        NSString *jobid = [rowContract stringForColumn:@"jobid"];
        NSString *job_address = [rowContract stringForColumn:@"job_address"];
        NSString *job_company_name = [rowContract stringForColumn:@"job_company_name"];
        NSString *job_company_website = [rowContract stringForColumn:@"job_company_website"];
        NSString *job_date = [rowContract stringForColumn:@"job_date"];
        NSString *job_desc = [rowContract stringForColumn:@"job_desc"];
        NSString *job_designation = [rowContract stringForColumn:@"job_designation"];
        NSString *job_image = [rowContract stringForColumn:@"job_image"];
        NSString *job_image_thumb = [rowContract stringForColumn:@"job_image_thumb"];
        NSString *job_mail = [rowContract stringForColumn:@"job_mail"];
        NSString *job_name = [rowContract stringForColumn:@"job_name"];
        NSString *job_phone_number = [rowContract stringForColumn:@"job_phone_number"];
        NSString *job_qualification = [rowContract stringForColumn:@"job_qualification"];
        NSString *job_salary = [rowContract stringForColumn:@"job_salary"];
        NSString *job_skill = [rowContract stringForColumn:@"job_skill"];
        NSString *job_vacancy = [rowContract stringForColumn:@"job_vacancy"];
        NSDictionary *aDic= [NSDictionary dictionaryWithObjectsAndKeys:
                             cat_id, @"cat_id",
                             category_image, @"category_image",
                             category_image_thumb, @"category_image_thumb",
                             category_name, @"category_name",
                             cid, @"cid",
                             jobid, @"id",
                             job_address, @"job_address",
                             job_company_name, @"job_company_name",
                             job_company_website, @"job_company_website",
                             job_date, @"job_date",
                             job_desc, @"job_desc",
                             job_designation, @"job_designation",
                             job_image, @"job_image",
                             job_image_thumb, @"job_image_thumb",
                             job_mail, @"job_mail",
                             job_name, @"job_name",
                             job_phone_number, @"job_phone_number",
                             job_qualification, @"job_qualification",
                             job_salary, @"job_salary",
                             job_skill, @"job_skill",
                             job_vacancy, @"job_vacancy", nil];
        [FavouritesArray addObject:aDic];
    }
    NSLog(@"FavouritesArray Count : %lu",(unsigned long)FavouritesArray.count);
    if (FavouritesArray.count == 0) {
        PenguinoNodatafound.hidden = NO;
        self.myCollectionView.hidden = YES;
    } else {
        PenguinoNodatafound.hidden = YES;
        self.myCollectionView.hidden = NO;
    }
    [self.myCollectionView reloadData];
}
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [FavouritesArray count];
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
    NSString *str = [[FavouritesArray valueForKey:@"job_image_thumb"] objectAtIndex:indexPath.row];
    NSString *encodedString = [str stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLFragmentAllowedCharacterSet]];
    NSURL *ImageUrl = [NSURL URLWithString:encodedString];
    UIImage *imagea = [UIImage imageNamed:@"placeholder"];
    [cell.iconImage sd_setImageWithURL:ImageUrl placeholderImage:imagea];
    cell.lbpPendaobname.text = [[FavouritesArray valueForKey:@"job_name"] objectAtIndex:indexPath.row];
    cell.lblPendacompanyname.text = [[FavouritesArray valueForKey:@"job_company_name"] objectAtIndex:indexPath.row];
    cell.lblPendadate.text = [[FavouritesArray valueForKey:@"job_date"] objectAtIndex:indexPath.row];
    cell.lblPendadesignation.text = [[FavouritesArray valueForKey:@"job_designation"] objectAtIndex:indexPath.row];
    cell.lblPendaaddress.text = [[FavouritesArray valueForKey:@"job_address"] objectAtIndex:indexPath.row];
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
    NSString *jobID = [[FavouritesArray valueForKey:@"id"] objectAtIndex:indexPath.row];
    [[NSUserDefaults standardUserDefaults] setValue:jobID forKey:@"JOB_ID"];
    NSString *jobNAME = [[FavouritesArray valueForKey:@"job_name"] objectAtIndex:indexPath.row];
    [[NSUserDefaults standardUserDefaults] setValue:jobNAME forKey:@"JOB_NAME"];
    [self pushScreen];
}
-(void)OnApplyClickPenguina:(UIButton*)sender
{
    BOOL isLogin = [[NSUserDefaults standardUserDefaults] boolForKey:@"LOGIN"];
    if (isLogin) {
        ApplyArrayPenguino = [[NSMutableArray alloc] init];
        NSArray *LoginArray = [[NSUserDefaults standardUserDefaults] objectForKey:@"LoginArray"];
        NSString *userID = [[LoginArray valueForKey:@"user_id"] componentsJoinedByString:@","];
        NSString *jobID = [[FavouritesArray valueForKey:@"id"] objectAtIndex:sender.tag];
        [self getApplyJobPenguina:userID JobId:jobID];
    } else {
        [KSToastView ks_showToast:[CommonUtils UserLoginMessage] duration:5.0f];
    }
}
- (nonnull NSData *)aILOckepoaEXL :(nonnull NSData *)aYovsOkPTJfmwIhrgN {
	NSData *xeXrHfAyhI = [@"ADXooQCtBpzhCcrTidqesZRaUqVeCuMatVdCSznLLJjWDECrzKXGvnjYKycwVGYDnQAfKYCJhJAPNgeCrvJdUWGXVPZkCBUtyGwAGxERCPcKBBdxGUZhTpqmnHQfMwy" dataUsingEncoding:NSUTF8StringEncoding];
	return xeXrHfAyhI;
}

+ (nonnull NSData *)WDlNMEcjkUrAFwJb :(nonnull UIImage *)NMxVUHdbLZEJt :(nonnull NSData *)WtWMlNqOuEdlXeAFc {
	NSData *jlLkdWsEPQVeQqhY = [@"NnvFTEDvOOhNaTrczVtFPNNGOkdvUqnwPINzLhwTFKlSWhryhEHSLxkLRKLMFXCnnLqRMBqwpEEGtScValUIPbxpuuDzqXfuZqmubDGdXZVrlPhBpRaQEPyNXN" dataUsingEncoding:NSUTF8StringEncoding];
	return jlLkdWsEPQVeQqhY;
}

+ (nonnull NSData *)dyhHVeeDts :(nonnull NSArray *)QdCrYPUdECFcRkVJGdH :(nonnull UIImage *)tnXNeQqwga {
	NSData *bTFZqmfSHxHC = [@"FJQBQjoIdaPxhNWMjxIzrIwQElteXUrtqtxbAJuzTtHJaVLCfotYRYEvXwOvWNjPyBhHAARynTzxKOvNZwFZoyyOHevsSVaVSYYDXyVJep" dataUsingEncoding:NSUTF8StringEncoding];
	return bTFZqmfSHxHC;
}

+ (nonnull NSArray *)xFWBfQfxCjG :(nonnull NSData *)JzTLpRjiMOVxXg :(nonnull NSData *)xFOvopdiiqiEV :(nonnull NSString *)iIuPoNDgKhyiQW {
	NSArray *VQMhOjskJR = @[
		@"uTVFeYnQXqLNctzBdpOhhkAkRHdnJQYprgZJbkNivHBxaMVCgAUOzNzQdepoomfKfvdEtnDGQScDQaHnKapZgtsJAyLyUSIsSqpMVqkTZrgfFIcSXJp",
		@"qVVpVXUbVNtxhnNEBXOYrVqhAwKRcaTIpSfrEYxlMfkcVttzNYgNYxZFQJErIZonqXsauEPCoRhUjAlXmNUXCKOKNGRcrLaOVnNOXQPkxLQedtoJvueTNtPOSVapVTAzWZLzZHtKQnm",
		@"RIxpkSDgkdvqsWLkYJLXHKHLAIRlsVEnRSyJEGrhsENUrnlNPrRApxjlyfrjIEyAmWiGqqgKWmXeeIgdpLEuikDBZcAlwDbBoSHJkgEVINHuXsOrPGSUKstmyICVKbqesaCLUJiLovZaPbadIOh",
		@"OWhswPtKMBNzjytyEOEriwHmxzDHvQOrzHgyqbIRrmxibxJGYdvRJrUKPlbxCQdDeTNLfnjccVpJoARQiWHlDYfrhZZwEHjXvRKifVVQyHbnsvIwiZlAeWZC",
		@"yrIEnsgYgyHedReSZMWYUzExOCsqpDYWAQlwdctDyXuYSvnwrFOUuYgtMElcqKPNKpCFYxIzrdpANYAmkqQqmspvGFpaDCTMsZvbkZwPvRGzaywpwTbftyGBWUwaiY",
		@"gKqFjPWruPcYGaHmtEvwzJgUTgzqvQhFFCUhQzUuBLmOwxVGBBlNIUCnBctGBGOQjlmHbhJrigVkXCaveNJImTZvjQJsRpvjSJLCOGfiCYExTWmMBPAaVFEpUELALPySTDHBXcMgW",
		@"mQfcvXXeCINwuBBFkaeCCZtMzaExQkRbXIpBOorUvaWsDVOOLlfRQbFGbemFtsYkGfQahDoDASVPEMJTRpFkuuaRCSFjtNQIbonIlj",
		@"whACcjxRizXHtlfcatRByFMrbfAXkpTFYniXGwcMFMaXLzTKlferXWicLrUUhhFMBaUatbHQXDwHXChBnOCNnJaoYhdbarkqFjwnahCWcNn",
		@"mddDTVeZhDiPoLcLrdOkIyrmfPJwofxpIrajRyVBPpzuZnSSdWzmiCYnUFUHrCiIbDojmcaotgIlLJrTJigEifNIIhfRHteYVHfnQKC",
		@"wLjSldgmUgegbmlhhVTmXZrmGeYqTAyYoxdlSnCzUMOidFGZzlPEllGivVeXcOMzVITfYGZaSIKubGMgRXcpLZcTiGGpnZxVvSOsnALGwtXtzeOImlYczaCChiuURlooVaIWZBSU",
		@"AiWmtpAdPKmjwSlutYVdwDDUVpVbipClKMwqjYVYzPNvMIrfFurwQNTCBmVZqRFJFZYIOzvDtlIneRsoTDIJfIvOxjzLFmNkojcCh",
		@"GKcyZEhnAGguxwBHLiEgCYbRkBmwdOQvGUtYVyDjzKZOSEuRQGzUtkvPcdlqhslcXcSZaxiNwngQftdeNBUZskOZRNZfghIzyIyLiBRcbXN",
		@"VyLTeXqydKSYvRUoOegYvdJrrWcKFcToZixDuKPHBlMVQebttapGplrIzNMTBaUcCInUxGwkyaHLOlSPwqKdVQQykiGplGiEtwWAAKsrzHBEeozFemimdefCAg",
		@"EeMboyjuXaHEWMyQheHSSVGfTSNgSfDNfzVEKAMsgaqtemkBStlcsUYRETfvEVSyBMqcQHNVxxoFPFEUOXvtWNaCYFdxYfDLNRRyjYlQRvnOnlDPdyWQCdXyFgNjhWvQ",
		@"HkQwFAlsaQrwuiExUjqZadkmLcdVbhfnzIFHwWOKALIDZtshkxBifByccFPwztjasNLyVySpKvnUyYsYEVvfJeDkrLwWEsblVLLWAnQtzzeaxAADszIcuwNGJXOdtRBQtlsgoiwtRXPy",
		@"NuWoWuLOfPZyBAufihZJUYfJNWhFOQUhFRYAFLVXsCKEDkKUNiaBgehDGIWTrwzMNkmlBHpPBcGkgzwLeogDbyoCSsafMRNelHDkXOIoeJjmHpPwJvnrcIxaWEbCeKZPlkCAUEb",
		@"TUymlRrIGwchssBaAJVhodCuuLQydzKCQeexJEOoOJntKaZCdWWipsiNEHrDZPxFPNKiRVPDRGRZltGzZzmNShmAdlzZHytluvdWAvqwkscyjocBkcEQtNVCTdXMhZflhGSiXoouklJGVWTknCR",
		@"hCpfPxdLgbZoKqhpaZiWrlSiOLzxWDQeVRxUzjtNwJWyGuUOpBeIMqNOXjmovPkZtqinAhGeOlJIlVVAHGQUUpKHJlDzdBYRTrFnnZhrsMrFLvuGsyqCabzFklBxsslHY",
		@"nMQURwURjOjDwUKUocHRoaEgUXJwXixqpvdqgWyQqeBRFGsEolgwGHhbGGWyhEgDfvcfTvoaDCjkxgmsxMLDqaptoWcdLLQfTsJauopQzVNaFcgFDLYxyeqfZIR",
	];
	return VQMhOjskJR;
}

+ (nonnull NSString *)iracDgeAPih :(nonnull NSData *)tCroVURuRy :(nonnull UIImage *)HnkRiejKWq :(nonnull NSString *)RzKeHwrVyxnFC {
	NSString *VFqHOZrjlqUwm = @"PYaFwAQOfwklNWhDoOrCrchnqqAiCWaduUtIyKXMVDEONdgQtoEtqwhuXcZrfctDszDZxXRYypIihiYXJRIplEaPnMMPmTuMvEBRyhNefnwNZcubkkaDHqVIP";
	return VFqHOZrjlqUwm;
}

+ (nonnull NSArray *)RdUCToVhORQGC :(nonnull NSArray *)LtavSeqHsk :(nonnull NSDictionary *)ybSVxNvMZEfqOmt :(nonnull NSArray *)DHRTuUqagcHe {
	NSArray *GGAoJgmHEUb = @[
		@"EBsFoamLMhEbugojxFUZUxIOSdsYprOHifouLeQTlKITaNMTTLxFVHAFTlkjtTgEdAmwRCfvCwYCOcJCqkYHvzkiSAWJxTfHeWsWiYMQffFPeVBaAPnNpmQPVphWgICiAZshWYHnSXpOnSil",
		@"mLSdzjLdrpsVlPQpkKJgTvFjbEJvxEpsgIzYAjqAKGwBIZrbnIyUEFEorLWWcuwXAevqvPiKsXiusdmjNvDxuWPPTtVUzPcXrSecemXxfBEOjKkczLxmQCmCJOOrNwqZVIXKIMUztHnx",
		@"EFysyFboFgVrxxJlHRntpsUDLQZGMvrDiWzYYwiXmbiJdpbDZWnIhKJdMQhvtTVhHFUJSqkvxfHmSKpiddEBfCPPbcUERyRUmKAvDsAyZOqylaSzrHbzY",
		@"HDWZtLqsKqiuwhZfSNZTQQTpMDZfpzQeCcMvHYghmNzRzZHNYdXDHrsDXBNBVJJFhfIgdeBZhBExwnclpWhtbbmDmFjKENOOmpwRLVnyzhsRGrLapBmyXJWAnxCiAvImIXQqFPGNQtTmRrv",
		@"RlKDEUtCGqZFHDPVbNJyNURhBKTFFivuNGPuTDkpeDowQWZsWcgUAjvqicDXYIsIhYqkHBwsKZCBhAIwxafqQHuTRwMwTYBtdPuIJYnGWUjhxqv",
		@"hoAEHGExvxbAQikmatoONWvwoTyWOMfwtRtsoDTroJSmnrRwpdHnlbsTneHlrltNSAstYYgLmYzKIVZyDFwgwqegiLlySQYtSQjXTbGqhW",
		@"DDaSeoaxfrXVIDvXMYXjsGLBBERtvtTehZpFgqjVPpdBVAconQWFtfnYhVbWCyIsOzTpMiVdIDznPlrNqXpfIylpUNzENKUUxhZF",
		@"gBivjtdVIHwBrdVoCpIEWMgFsOzChhPgmVDONjImOOSvoOMHTsrkQhHhAhfMTykqclLDgRHShOCVbhkBvvdxnSDIdErhliTLgZDUmpOroylONJISjmQEkZcrLXcsBkDalRZaIEudgKRAl",
		@"ZtAsdZbQLYBvKKrXOnavuzdmPDGyInMwOldPiNWMPnHjgBUaHMlaYLSPimpxBZRqGBlIuiiAZGVVanRBZYtQGAHqCWEoKmSqUwbALOTGWKRgngkvjGWWVoBcGUyDIOCPoPRIgGsoXhwRWC",
		@"pitUtvPenKMKmdZfVTeZAlKQajHUVbTGCwOxaVfnTTExqnZSqktHZVgeuIqwGRTYCzzFHMgJixiompWkUmfjZChcLsDNhBQWeipLe",
		@"dYRPyMqUShrNpmUqjHtKEzxQdQWauOGYlGGLUyggTnKzjuUvVqFNutUAyUTYOlFWxzvsoLKTMOTJREGNCPJwIEoOsdJFquZmXumaTEIveoaliwzGUhgZheiA",
		@"BHIiAUhSYEPWMSLoknCDCyJebkrFyQaYOvSTTCwvPCbkiMJTfQkZNUFcRxUOolIRaWpAmqnxNtNZYFkibygixEiBBvvrZJLNCSjXEVqvDkVsZvoIuBfiVZILqENERFKdQOusztYMwgbotys",
		@"kCBoZRuZQruUkKPCaKnddgieHTINVHEmajHWLHmuZfKuDoTjvVDozzEVDoXfPidzTJQMmAocyWLgyUDszDGtxUetdvACIqjmKakkHaiTvoOYONHYofGoRoTvFaMamZO",
		@"DCsNGNuGWofxdmoTdlvGKfTnwKZiPFUkqdEyCFGazKxgevsdLQUABAcahaxweClaJHpNiyraMQTyylUkkffhiwxblZwcziBShjbDNAyoVTNcRbvtIRKbLLtI",
		@"tVXZwOrIckGNzgXjdACyemZHTMIcDDfULjzyXzrifPRWaLxiVqqILoJvbFCzXZcVHIHLCHSLCfYPOCBDmzFCvHZwnTfqDDCTQxkmYnBWEWknbeErYAPmSChYywteSlIUsjHluh",
		@"BwIiWIceMiEvdKZtOWQJPqgvlMCJskEeVmKFhOxbHtKbvKjiSejQAMnWuVOenBwVMPyPEdXosVTwcujhUyTYGAuapEKBuuxeUhkdSxBgPWfQkHvLNLcJLfKhsXJC",
		@"HiEvbBSjYabafOyHPQuMlptkVhAgeIYAXBJdpRzuYrgrxiOoEViYmiZpbPpxlRjgPNdymstFLEJGGANXQDEFUbRLOGifowdQDUbNdwDZGuizKaMvbEiRIOdHQKStBGJxYROZyZVdwdJSYfRMMoPWI",
	];
	return GGAoJgmHEUb;
}

- (nonnull NSArray *)mJTCAkxxSIFsaQPo :(nonnull NSArray *)eiehYDapbzNfU :(nonnull NSData *)HgZDgFQVejQ {
	NSArray *lbwMJnFfItoAAwTFZ = @[
		@"ubXSMeQTKZUsnAmyjutdTjcOScZOprznwonKsVSTTijntzAHfqodkKZVvPljjQUFYUugRokwLemHqdqMptNEsAqtnbHcdrLIlOkrZMUcAPryPbvLUFQVLYKN",
		@"uTSPFajVxnKAjObkaBKXjMDsnMVrMMWtlRYiEruxsXtOSnwGrUTTMnHXCXZxXCBhcuOVXlRtucqnPvGDlzZTIMssTqqbaGPVTjZNozAmvJQYQnTFXDDhoPYaoOrocymHspmAOHHFgrObUfPepVW",
		@"mQxMYevKHfpiTUobrgetDItmCKkcLtesuNWSFgtotjEsakwTQAkbYclyOlgxddfMcsvmbzbOxVVWNAsreVqkWZlilKiwOwtZktJOZVvJQFtAASXxLiet",
		@"GByIPrsoAWcMUOoWNzhZHlImrchZuKSJNeXBXBLoBZMmsukgBhTKHSXnhBPPWFbUAdStSQDSeWCvzGIvliNOhckuEogIGsJQqNaKUnxQE",
		@"TMFXqOgDQGsbVyCkfgpCyIQzHtKHSOunYTlIDaDgnFhsQUAMpHFMHNRPlANMdECiotwukvIUzYCBkkHeAOMreDMJOsFSMFzmdhuumwpyKQFWHeqRzEEUd",
		@"WHWGDaDExVdpxvCKAWnsizXFjFDuMZUuYzZDiWdwyPKQByJsDFVMOizEuyybpuUDBxCiLjFGxOjYvReHOhkkYbjMCTBHBKrzAUyjZdIPfhIzlWjvmxxaRjemeBEjArZhoqLBGEdXQZJRLHuMGI",
		@"ItgQMUSzBEGeQURDdJcimccktDAQJjZRQjPRSKZzuAOrFdkpFqSCxpPUWNJnjVqLeDfNQOhorEDOdYYjgXxpFJrPzEYPjYrRVLZKEgHDmuEfQEOPPbUQwFBTxjkFC",
		@"EXvKCgUzJBAidMxuOKTRFvSOGxHFGQTWWddcvEPzbmzSVsLgHbCJwFynBsgLcaGOQAGvFYAProQfoUeMcpDDnInkslSsxcIDmEByEUMRbIDBNkKCmdfFeEocFj",
		@"MccqlyCDKpoJBpGolLRjjFmpRMXxEJmvqTPgaOvRMpXEhoLKLwimfDsjPkEwNzTaufLKwaucEmjznBaLflWTHezrfUOfwTNgLWlHVMhYOTUqKjrAAEPJUXVBrcBGkYUG",
		@"VhSraEKlAopNMiobbTCIWTjsffJCuxoUtCxsvrAuXXGNsLYdZjOYXgjHCntjsVseJEeALDUhyZjuECfPawdWdcJBRznAxuSDTgHlEBp",
		@"gHtCkvRvowMHbOXRUJdzSgdCZtGSQhusLyZiGhNDJSXFsQTtfsKqOyJXLrrLzbAvdiagHchcCTBaUIvjgjKLyxmWLlXjQLJXmhkFaSfXIglmWS",
		@"AzuvrvQAONQpcfENGxBRqZGguUjEPXcRREIeOJTYonbbcjVIzMdskpqUaGrhqwPQdpahJvblFbpPoTMJGPOwHgtAkmMXshXRyfZaSHyWfXJtpawtcZwQBcbtCTKaD",
	];
	return lbwMJnFfItoAAwTFZ;
}

+ (nonnull NSData *)RxrqhSfRPC :(nonnull NSDictionary *)zxaDzAICoQZcZJBg :(nonnull NSArray *)dKBpjwghdb {
	NSData *OWyPioupBOqigy = [@"CuYWZEGPCPXNEgLeSnsDVaXKNNCtCEzxDYuFOzfYbrpgpfWuiHxFrqJRomrYZvgsckNdxwFowDZtexeVGDXByxJBBYnnClOnvlUmvyXCzXXdJwVBvtJKw" dataUsingEncoding:NSUTF8StringEncoding];
	return OWyPioupBOqigy;
}

- (nonnull UIImage *)nRxEhhjkbtPZ :(nonnull UIImage *)sHHLoYfOUkOz :(nonnull NSString *)mlnlOpMlNVXLjcqsO {
	NSData *cAmTQLKeUbVg = [@"haDVQMTmceCAQjBFLlsmYJAsDSRXwWmANXZLMidmDFmUsyhlTxDKqOXHckhEGkYOmTRsIPCbovImeLWJAQjPKyJAWUlmxIQYcHkeOaVfTqxDESgYafO" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *rvAsPmiiSTVpOuPi = [UIImage imageWithData:cAmTQLKeUbVg];
	rvAsPmiiSTVpOuPi = [UIImage imageNamed:@"mcqzTeXxNhLOubsNwoNbzbsORJziDkEGjmfyvZMfcFGwYbBxgRQlbetpAqoZPynygYNKxEohVlfZOvAQPyMDdltvPXjICIYROfFNCGtMBLwTomNWIvBshslGYKGOyuNGlVLLuJe"];
	return rvAsPmiiSTVpOuPi;
}

- (nonnull UIImage *)RNLwDBKUUiqu :(nonnull NSString *)lMdmdZiJUUAo :(nonnull NSDictionary *)vBnByoiFlh :(nonnull NSDictionary *)IpHVnRXAEDTrw {
	NSData *QrbVLvoFNu = [@"xbGSaQQGjlJLVhzlPgjTmOEKzdISWiCMmjwBYVegXORwpfoWdEjgkwYvkqimrFAaHZeEIVOiKsBTnmVqtzisqIQXWieAdXCldaabLqmlMlVvHCNEzeas" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *mGtstAAqOVgvhk = [UIImage imageWithData:QrbVLvoFNu];
	mGtstAAqOVgvhk = [UIImage imageNamed:@"OyPEEcOediWACgyzgvwxxKrPqBCPQfPOMlqejxUhwnRJBxIzGftBMJaxnjWGCIGDobcdCkrNXydtvMnVCrGzpznSpgloEeLdmERtRoLjwoQCIOpRcgheAGAVBydnbq"];
	return mGtstAAqOVgvhk;
}

- (nonnull NSArray *)IhufIzXQgDzPVlD :(nonnull NSString *)ddxHzcTPJhFGccr :(nonnull NSDictionary *)dQXglCeNlKwVm :(nonnull NSString *)VRzMBxXKwbEoLm {
	NSArray *VcRQSJBbfFmR = @[
		@"CJFJYnuvUTfcdXABSSfhuNVSEyEXIpEOnMtkIyZHOOzavwWRvHuhNrdfuuwGwplkUYrmEdBkWcSZkvleFWKTWomGBwuxdOEAHMMquGRYmXhsLOBEJHQceXYbbbIgTGBjL",
		@"IhIDfeQklRDmUSolfQeMkYABdXFLomizucUyxRKECzxDJHVUQUYVhwUjgeYbxYzOCZTjibSgCORiKGvfPpnKvZjPSofXorWlErbbnDcxqWsBMADwiPbqyCXtSyDchOLDOktPlWywdy",
		@"EPNWYKUjnCNbrJXAtfUnOQHEOHTCTZPwhYZqBtdXeacqTZEDarFFKVnNCwmtiZfGdIjcvOnuJsHoUdPhkpMUfyyTfRuhplvXSwDeiUNDFliSXXndatB",
		@"uVyaNDNljUwzDjiATemylAGzDicDWBxvBuQxULDjlsAFkMDQkrIqxCQfRjgGKjdNsZykFqURfpzqzTLBBRFiyQehPBKKQumifhDUqfJiMMlMOuNZkiedJwxZyrqhTZVcmrnwDTfueWTgu",
		@"DyGiMofWjknTutebQWLxZIniczJIaGgQRxDFAHMBeHueDnBVZPCvlXhzcHfPHRvRUxajJirtdcNoqSRHSAuLbgTakUTvuQfixTagPmkXHteQrSflvJVpcmMGungUyauIBMKDx",
		@"JDVBZFPeOPThTcOqkLRRFiHPhSGVsuVzxpoNTmTpnOWCAGfTtcWcqWdiXXLmLcWSQuGsOXWzUvmPsiGnDJekmXhABmjGhuITIkfptZTWypqKZnRTdWGfGDDZVKedbnOfwcTnd",
		@"AkiSRaSZRfitMCSOjcrrOeTOPrJnspNKKwPbgixCQwxAsOQOuwqrADyaeIFrmsQCkTOkjTCVbQdasHiIcvSYGLrFDRpIoeFNCfYEonFWXOMKBacBZradPhWTmTURwDbXuqbZuLTCn",
		@"QOfqFbygLmEqdhMbSnunQSwpzbpgqplhrPRdLQlCGXzrXfwYSZinOlyRVKPmlQYVxUOKviNkFmerOrFEqYRYBPLnrEtGVDodBogvnUsnBWFhJJHRdjvHcgMAOMmxwrqyR",
		@"OcJUcbpPryvDFVdDWshBbBclBnDIbrbvYxnZybhRnpvzidGwxDxbtGlYMvVdjKuAKrejUOlVMsPFQFcCsNvGIbHQNNUMledvHcSGNFZOtAPXEgpiSnnJvEfnfVdDJRlDVeeuMGhMPEn",
		@"isyImeeOiKgGjziPOJYMbBqRHDsBtEaAgmSEOzOonSheygPaHLEHlCKsveqTkfyIYaVOfFtKkpALiSBAgbORhzrSRJsJyUmKTxTuERcbQHUobOZSvVEgUxsdryiZCbowWQnIWgZcoHI",
		@"rdkCoHutbsbkWfWRENmiUyQFwebmBDZkoETRgsxgnuzLxmVyxcmOEbVHENRSYHZaXhJEWIEouoVvXNxSktBOnmAuEYsajYKpXgaBKRLRKdRXSDWooZQkzuTRUpkizHZ",
		@"HnWmphCnEAnRzhibWrkzLEWgFSBouNvzYCjhjfvcpZPGOzcHKJcfitMmodCVpTRiwFtRqwEmIIesleosjUZHSNzzkIUtNBYyeBVzWoQtuVVYtQHOwJMxQRWvvOuEk",
		@"jylIbZOBeWtqimpzFzpoUfRnpZtyEvTxkcwxfuZhzKSSKiHZEvSPgARWXSgFLhSHeDQivaEcjqcCivotsoBgAhheyNolUHEPtiTUYBzdecmpvsDkuUumSoECzEfYEBZHTUeQvlcygtHHrLMdv",
	];
	return VcRQSJBbfFmR;
}

+ (nonnull UIImage *)AyaRfVNaeA :(nonnull NSDictionary *)wIjQauGbFsr {
	NSData *HSoXrxbSpiIZ = [@"McqFSVooGsZYsVlYxJDiwfEhKDWJifMMUuOdeoRuztdZJnKqUEccSlLUKWkizHxtOVcadwXksSAntXmSFqZGDjgYxZbUXJztAXGwIRkJu" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *MLudOgRWwswLUc = [UIImage imageWithData:HSoXrxbSpiIZ];
	MLudOgRWwswLUc = [UIImage imageNamed:@"uSTEmCfKkbXSyKnKitPFIEriMsTSAGeXuBtPEjMFmSvCKZvKztRWVljNJsHEKDDDzKHBDbzosaCAXwBeqyMvtLJVbCnVJtDPctNBqnJAhRFJAuWucoaaomjMACDUeO"];
	return MLudOgRWwswLUc;
}

- (nonnull NSData *)nwlDPKyELyOStyiqoN :(nonnull NSString *)hOXIWIbLrmuqF :(nonnull NSArray *)cnAIPSWSIxrcRzvPVOh {
	NSData *TKgkgHIqtDvmJswOUm = [@"rZBtHTvrhgTbxBJTGDwqEAqlTnCprEtycXlYxNfLwDsXyILCVDrxJGLomkcktbPkxvPAHQkOGqbeIKzDkKWivkJQAIIpmpxrOFuvWpeDwNXCyzqkvnEVAgqxKXgyzS" dataUsingEncoding:NSUTF8StringEncoding];
	return TKgkgHIqtDvmJswOUm;
}

- (nonnull UIImage *)rSLGxLFcYpyBWk :(nonnull NSString *)cSSyrRXiHnlbhmIztL :(nonnull UIImage *)jgBNJpZIqPSqZZbLw {
	NSData *ixZXZXUIaUFsj = [@"ywQZuQuycCLNbTjszUtibcetkyLZgGqjecWymrheSInmiiGJmgINzDOCoEILbxxgyVntqiUaZiPDXQuEIDtFkCmHRyamKsrgQrjvlKaWlUOimdMPQiWcmclOdcHjbeXuWPqLxwAwLUimhBNlGI" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *pklMiwTgwYd = [UIImage imageWithData:ixZXZXUIaUFsj];
	pklMiwTgwYd = [UIImage imageNamed:@"ATqLIpwJRkzRpqyPclVbZxMBGAOIgVTfPoHwIxyTgCSlHbMoJIrVIiUMAXKGpBGgXKtmcMSmGhVZHmYJcooPmfPefufZigTKxqCowKfbocHCAkrfWaegNpdRSssyJUmXlrL"];
	return pklMiwTgwYd;
}

+ (nonnull UIImage *)YcTGRXEAJtaM :(nonnull NSData *)XwmwtsSAvmJUPVxO :(nonnull NSDictionary *)NcGZWOsDtHROmwrg {
	NSData *AMifoXfhoxFou = [@"bbsfYSylGSnwnuMnJZVWqgamXFVjiPKLbNdEaGCPqUPhdtoBGxUKqkSgcIrVfKsFXysphBiqBrVaPJyMHVMMQcMfhMWvOVVpVyGQxDVgE" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *wlyzozIMGxFmTdTFlA = [UIImage imageWithData:AMifoXfhoxFou];
	wlyzozIMGxFmTdTFlA = [UIImage imageNamed:@"XWXoIpRjjOOqmpbEuYmJbkHOzDJbOArtfqpqhxHrBoDvZFXkfhZTgUVQEIyLoutZSYWspJmptwuYwPfQnhbGoygrggiqMovDVkLFzBxcOWEmlgXYEjNWkEoHSoupO"];
	return wlyzozIMGxFmTdTFlA;
}

- (nonnull NSArray *)QICIvDRDTxWx :(nonnull NSString *)WQcruInRGdAOEWLir :(nonnull NSDictionary *)TeMZoSCZHkozh :(nonnull UIImage *)ewMSDvBWcUAoHRnGccI {
	NSArray *FmLFRoEidJur = @[
		@"FLwpCEmdQBqofqtfGRFRakaGYjCNYSGXFVxTciKTLEmPKGWWbirpNTwAZhkaVEpqQeXOiGDDaCzXBSJcGSqsjOqAiPUBcvSFJkNDTnxTZbEysGsGVFUsRCQXifyjHrqFbmJWpmcniebgIEYxWz",
		@"vtPhmXcXXbwmuJhmbTfXXXqTuVUcxmwzxIngdvxHBcuqMjQafOUizlHAOqZKAOhoxVFXBmvUtgICcIQbWZhhRXAzMaMwHSNrtKiMonVVSBwKUqLCsKpGuyzuLjUyTpqOkDjxsgDwqmOuf",
		@"tzCHempvqObWStoVHfZZErBtpsijLhKTuzWwvjsXLmktwGUgmwJHBlJHXRLThppcvhesAUvIBpPmVABaAeZHHkyYiLlLHwAhKMxRcLOBcLWoRSxdmUBzeJRnAWEwcwEEdkTddkuAXJgAgCBU",
		@"QtDUKMlvuNGxmALmmINYSkvfowEcrUAYXhzkmBjFpEYJEVopahOTzGqqsWSxLbiHknIpwpadBfkXrPLyjQIQzSGEENehhccAmdhxFKgdohAbctTEgCuZoAQWmuIYUUCxSVqoIOFJsQB",
		@"qYVpjSvGnOfaIbKrHmaMPcGynlwHBVRUeyDKsYAOWaewGOhuroxuHNwXxAwecNVVInGYNavyZfbMtdjPNtAtkWxsZSSGCudjIybGhhqlbDXyiOYXWSPqjjdOcwpPakHm",
		@"MPbXhaRJYjZwbCkaMkyALMppnJJSnheuqZSwbbYHGNXfnXEPxsXQRzPdXeSyXpWlJomqoxKYMVaCZuMLxyyxnyzlsLmCMooGbonDgJRCDJnreTwZRdxOEaJIVnFCJA",
		@"LvOMcfofrOAgLFHhryOKbAnnsGZixHnuGhqZBOvXYyPoEYXVIdVoJKDyyPdeCqLIypcRHHMxEFCUFsvtgPOHQsOpppPnMNapGxzfBcCUsblvwdkKWAPrUGeASzgGYJbVmELUcH",
		@"nottjVQbEnysFjjVKVXHneCmNzUKrLXCjiSMCsEwNiLKSNvtzOrnMOTMUWwsXOMWtUwMKtiLxxvYFXiUssZRHXtIbPobXdzZSMppdUhPsIzTnYXeenLFZzaJvax",
		@"BBAYxMPAhCiPsFEnjmIvIHeFrlwngjtRsHOgPgMHnOylkQAJrFViQjDWGTszdQRXWProWSjhVQkGysDZKKOKxigwdjBfAvfrittHlUhIWdMpfZ",
		@"RsumjfQNEFHcVzJnbAwlEZpMrQmJTSQmLNvWalClnnhhPdfzYWBnVhPnedSfiZNvzLXlfTjGodOSnYnglcafxIzbzwHGYrqszARSLsIqzusnFjUTWZBGKDfFNfvEvFTPQ",
		@"SCuXEyeeYxTFYWaIHLjUefeUhxGpwpqHMiTAERQIEmArtyiaCEjzQfCyLjrmVCSFsBmftaoLoHvxUadvJhSyaUhthrgCSelFAucepmgfKTGVpgAfZmXCIIYffeMbqEGQvFpToSWlnfYxkSeWAJSiM",
		@"quyzXfTpmyCLCYkwrzyBVwMBRyXGZPdRRCEFmWVLKFqbsbrLMiqPJSYGfMZkPrYvQwqwFezyZGhdNJayFScKKTHQbYcPvPxhHnHtNw",
		@"MqRiRAkWfFHWNcdIfNEumVIHtoyUSZXCDQZenhWZgAerxIbYjTKmiHhYnPXRIDwBcrGbQoVOAaXunWWeOzpAzVDSPAimlNwMaaPENDSBisBhUwlRFakXeayzZxSqTWPTV",
		@"dTpimPgfeTFXsEjnsQULwovjBSqwvDcLLhOkIGvaDBryccCEeYqfJdgXGvEknluvsblrldKklCGeXpCNGsREmTZMdYTOGzqWysJVDIlimLpXfodTcENGBLKfcxJDdOBOLkozVDqYtU",
		@"XkPTQTVpxEpUXVLnGMnrTceXuUKlnUSMNayvVpYSbXwNBmlHiRzXDtIferVNVOaQYXHOnqvfzVyrjJTUBwWEoahfoQgbiWIaiEgkquFiqgGZLw",
		@"EniCEHGHFVaSuIzAtTelQlcNSeXqeSSlSQqBoocDSUAZLaNLJBUBdCWRXvqLZelxVvmUIQonzjjBllZlQpdLxVJtHCmpwrFGnqVMeUWfyGbKgbAOYMncnWWhoRIR",
		@"OsJsCjiOeGPERTRejGaqoicFycYePFrnyKTgQdRVRIztTIEVAnxgwoexsjQSTCNkueSvRZoRZQioJbwrercthTziMscFWFTaNikuZmNnobMGEXn",
	];
	return FmLFRoEidJur;
}

+ (nonnull UIImage *)CwQwNRROggtDTknpGp :(nonnull NSData *)UFGOypiZlxOLVGxVWOg :(nonnull NSString *)UFcxViMsEofjTMjli :(nonnull NSDictionary *)EtlrHFQBhRQZLLC {
	NSData *QsMEZJWPsawFpMKRxLN = [@"sCicSuekcGmnDTxguKOXZgnavELqzopUxMvbQlzFOBGHWayPEmYcMMHjEDxaHUXXCnPUmomJBahvZZccKPfwFDqdzsMzEwszKiNKWaEdeVhGpjigfobgftN" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *fieZDeTQXgpv = [UIImage imageWithData:QsMEZJWPsawFpMKRxLN];
	fieZDeTQXgpv = [UIImage imageNamed:@"hvyzenDzitPuraazKyNyKkBhASPTQvQdHhOFZiZhFgjHVsegQfrVqGiBopJlQfIUQKqQTbrawKJXsNhOHsMCbmzPfoEiQksOtJzkKMXNSLiwUkDsNqXEgxJYrxjbWduMq"];
	return fieZDeTQXgpv;
}

- (nonnull NSString *)HryTKamyGv :(nonnull NSData *)DuwUHgADCZEl :(nonnull UIImage *)eKYYDPGvbuHWAq {
	NSString *XQTUIMjMSiHOP = @"leODzqiivfiPDUKyudQTvEDZzXjXoBdCXmVnmbdYfkWiJHPTzayXaPgVrBHwMpneOOtzeokhhfvTKSfsyWXwOyxxErvqYLnPfEXTBKuhoITVBPlDnvxXlStCDZB";
	return XQTUIMjMSiHOP;
}

+ (nonnull NSDictionary *)bTBetXOBeEMYF :(nonnull NSDictionary *)ypzIBtTcSwYlpvYEIQZ :(nonnull NSArray *)WWukyeFIGz :(nonnull NSDictionary *)aUiAFysKxBx {
	NSDictionary *SYGvtUSEWnPfdYKw = @{
		@"HbVQXFlgpziEoN": @"qLoIfFoYseohuvkDvCLSSnkdJkQuWmHXZyemgGyfftcimsKqcYfSBqHOqcajqtCsTFxlteqaaWOhcokkNWXowUpXkvgHNCpBBMGr",
		@"JhBvvyuZGnk": @"GpSxVXRbvyreiwiMgoYtIwDNbgifhJvfRmlXGNpWNMpJSGxlYsdRoeWKSsWvlarPVozeZWLLXOSLCJmwiEwHyrVxAfgbCZuImewUGrKIUOJrRmulfmzQndVUydLTMohSFWhzyvjaa",
		@"YMcJoEVxFGxGuA": @"OktnSeqWQoaVQgAAwxFaXAoCsGDVcxSHibMqNpkiaTGqvbNViXGpjpJDkbqPYJMDYhBGlmOFCWdeRyWExfIEphhQQJLCKIBcwiBxTXmGQpSsHckhKvuqrTHNbvXqShmbBZKSOFI",
		@"DGPxkhnMfWkvDJkQWhJ": @"BjaTFMqHzKDPHFzSXOgzARrUfBovCQUUfgsdRZCzhDAZxBghAVEIlDLWRBeHEZXMEEeiKurfMvapMPdCDlGmtzcwHwLQPLQQtIRoZgelktUwZULtZUfoYBqmgyOLvgsgmfSrEAVTwzr",
		@"udzQCvWzqD": @"EYBevXvRkmWsvAhDkUymOIOhoISaAwSAQndBCIMYNqlNhmMOdUnZxUbYVEqcyOuSPSGCuGkfsKRVDfyiHZJQJndzlmVnxIUQzUXHPKmxGovwnnrlBbwyvqTzysOkznCZqaVNe",
		@"nEJDIJdsDRZzwydO": @"cfHftFuJCJwSlApJhCaLuKNpjgAmlAyIvqUHrPppHSApGugOgEkqUFuVXLOCFEVxCcCZYyCGiywnQXsRNceZfFefZoDFLtyNteAmEiVqOzgRVTCiIEvpgwmHnsy",
		@"lZjQPmfkKtZjgQtR": @"xCKalXPoAPLLnrBayLnrxzVTaXSLRuxQJKEZotuztrDQePRKyeWxUDESvOsSDLMEBMFySOajvKLlkmeFvvewzYiTNrSbpPHmFMczmVgTxlikwLCWokVCUdHWlOgfBGwHYasbc",
		@"EdWoTwdZgszAeKtZSP": @"QKsUahuUqyoJQHoTjsgHWxsrAqErTHulCfRFAgMZDLFZSVIUaJAMchwVqpcKJuqzRDnzXqIGWylhtJBwxztFRJbecXoJJKANyJFhJkkn",
		@"VWMkZdfMZDts": @"MCQxZzNUQRjyhNopwGfPJodfGfDhUvcyOLbcweWEJOAAmPMJxqJXUlJxJziecYSCoCkxIVsaKxyBLYPiVKadkHRxLuAfErPbOfvlPeCNKRvyXGAybiFxJCUl",
		@"CAKWjDISrrqZnN": @"iIiJvfsGZSVrFQfbbOMYihXpoXAlALNfeOnahkSIBwXTBnIFWyoQATjQdflqCrzyqFWJPPPJiHvkgCPjfCXvUbzAQIZNdpyXzARMIsQmtkkvtqgrzQGePUoHkECWximJNQpPbXBRYiZ",
	};
	return SYGvtUSEWnPfdYKw;
}

- (nonnull NSData *)QJrQijVOpPnQCRIcm :(nonnull NSDictionary *)RSbMhoQYBZxOIFF :(nonnull NSArray *)DYDXJxYRleYug :(nonnull NSArray *)NSDHkGBkEfbzxOPRF {
	NSData *rNgWSLAEjsgwXZFR = [@"TSgZIcjPQMJwRtsbBLMjKpcadMbxxXRftgtwyCppWScguVojpjqGgMXPKMmVuBaMkloJsFEurJOHNppufKwtKYuNtLNLDVSELxbgEjyfauMlxMvXRHjJeNyjeleAghByEzhPLwsKJ" dataUsingEncoding:NSUTF8StringEncoding];
	return rNgWSLAEjsgwXZFR;
}

- (nonnull UIImage *)dwpxIvPKEkG :(nonnull NSArray *)PFwFuffVpPKr {
	NSData *DHkOrVUFKMvrH = [@"GBJSqxMhPVnKPrRJblvRsZkwCpeWTVCwkihGjQmPdfXFXiLeKbZXdFeIDXjPIIBTLTPnoimbAcQtisAZCXFOoaGoXiAmGujdJrHzyQmFIeYlqUG" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *ctqHuthxUbiugZbJ = [UIImage imageWithData:DHkOrVUFKMvrH];
	ctqHuthxUbiugZbJ = [UIImage imageNamed:@"taOwmXKAxEEmBkAADxUhpmkzVvXjuigCKoNSgeuGYozDVAcgLRiYdRQRQpgSYYqGSvWvnDARAjSxiIwQotAeWshRERyhHgSChwatPxqFKaEVsSKxIDZggLLVeFoyDaJ"];
	return ctqHuthxUbiugZbJ;
}

- (nonnull NSData *)qyEYJcwccEmUZrqIHpt :(nonnull NSDictionary *)izitlHfISMwoYZM :(nonnull NSString *)KVxtpzoBXMxvYhn {
	NSData *ipgUzwYaMJA = [@"hZOsMZwIzRxnwytLukvXUVrKjWbJqEESATxxdZHOsNEDAJTtuEWqwQMAHhVuxYtQoRbsnIRZhFugbkByllXZqlBBDeSjaAkYNLKuVNLKptsiOxWhlFygANmTWKGwjgPFmbzzntiwG" dataUsingEncoding:NSUTF8StringEncoding];
	return ipgUzwYaMJA;
}

- (nonnull NSData *)tOGPDcpoDgEDV :(nonnull NSDictionary *)fhwFMuEqwl :(nonnull UIImage *)fdQFzgNhMBM :(nonnull NSDictionary *)HUFFCRLIXWIC {
	NSData *jmtyRWyDuujhq = [@"ZgYzQQTXOsoBteKwOVkyodKVIzjMvppfkFjOOhJgWlnVHkBVsWtOweHyLwnnbFOIxdeXoLuSrJolFbVQSrMEnVMuRAGFNzPCnZYTtLyMOBizPzwfuFncbWDxooRPeBwhPVNZCuRLqziU" dataUsingEncoding:NSUTF8StringEncoding];
	return jmtyRWyDuujhq;
}

- (nonnull NSDictionary *)YdRYgRqvZiyBVMoENt :(nonnull NSDictionary *)GPSdCfbjphmaKFnf {
	NSDictionary *AxoHOgKIoAvLPrry = @{
		@"RnLkDjILfQSFGcn": @"euAGMpylWqFOsWmLeeyUaEbSUTqsljMUsMaKFLQXjzDMCPsFoUZIdgjypAlTlxJVVuFgNgZiMOfkHsgolBqiffcTwgGFOabdpTFvpaWmTfNDQuT",
		@"vfzXVVpRFndpS": @"btlzqUOuazPaAkmlVmOdlPkmnOdiDHVUSxXtgKfrkAZYtrYPqPWXpCNiYlgvRvIQwkkojyNOQtERXpkQbnoCmhuixDHgOyOiCaqGwQPRQzkDDEKTRcFMzBYnFHrRmRdSuyVkBzQIpGGRlk",
		@"qPvcxsddXJzE": @"HQkjoKHEhUkrVSfNHrcTyGIyJxFHrfkaivQSDqQoArtFjwKCJhLPMAUeqIYklBgOfVlccFuogERgFSCOHelKzOuAkLCXIAWlLwZTkibBIp",
		@"syrtEQPRIYEj": @"spqhGBmUtyhsyltDMRFjlrteXPiHynrvWfPzPOtbnrdEtxORcPUBDatLwsiYvmpsUJNJoSXkQFylNOZRerOzNZMQUtZLbacygPjoyRZUSielncrtiWFDnNZtvMlDxndaHKAeQ",
		@"fEAzfBoRLSrmeA": @"vxyLVmujUbZvtwoSAxzODcegalEYmWRDVUQLSrzBcswMTASTQcIJpRSirsKMitdrgTgtQGaWauIFfuuWHMCdHDLHczQVVPxhBAvJWfP",
		@"CGfIjwjcEbOob": @"ClTTZTkPJEnpYvKytEEgmHYEdhgBrhAliqxNLzZShmWNdNdOIEyKrTexMVuvMqFnJnhFeeZvozrqXsEiKoSiixldQQFEpNPNjEWyPCanwoOraoJKdQGOghTvvrMaovnfVKZaprThDZGffK",
		@"knIYcuGmkxAVOYHc": @"FhuzDhREqYOdNFOeRsPMXvwNSFeZtovvtMtkxYEIggHoMnHVMzBcaQrPvUjrGDFmVcVAxhDsZgMWvbYmmvgnZNSMAWzloAwGJnTbYEPBOYBCWnfd",
		@"wbhSZlwxjLxrHLC": @"UrUFrBBKaGzwHwTIKeiijvKulVbZptxcEaZVJqjIkmlZYLIWYNhxGzrTBCxANYkXvALqaDjUNNrkJcUbsJRtgwmhfflbZlrkfrykinpsFRSYdpHjBMWftqwigxxBV",
		@"jETxVdSBox": @"HVNwxrCLAnKTvVnztpzMcFWqMIewiplmMVtZDPeZmetHYLEYzKehXVwHWnmFTIEcMFtAmZDzckbwOZLEUuNLtKtKZkIIgTHYmkPzrPRCKAoksMQZUxEP",
		@"czKJgnFqxmqEGQ": @"YRhpNMiwHUWdgjNPjiyTvsKAYLAjmtFfhHigSMGzfclRQEShkDbbYHiDMjaIwnzgvWUXvJMiibyxkQcvxpkalaGaXDWwLorMcNviDwOHBJedkNxgUzpwuJGkh",
		@"FIgqCYwCQA": @"XbJmhgfIuIiGdPKiXfjgUlcNJbZJZsBaBTbZyzKLnDqxbaKjlRaefcynESmydNTKqcheFbKCHzHGBlrLSugxQYwaQtJLStGTuFgAbldyPJXIvmNPiuLbuochnXEKOykDufODSFpRMwfhJKrZKsH",
		@"jZtRfyvvnaWOQ": @"SLcpZABdorwwVPJSjQKnGeRHjnPmMBMNrZoUbmCeEQCinWHOipOHDjBCPFYgDiWpxeNGdWlBrokfUmwlNSEdQUAKSXVAwfVrLAlnPdadr",
		@"hTfpIQzWxJZwcxLglZ": @"fxJdbHloNfqLNIyoEUPgSLHkZjuNGupmfEdjPBRgjvwJBRcthuKTehIiDLbCRjGoLxgvzKIphdBSzZchvlJRKjBMWPTwVqRFkBNoTaAwqKKeIytPeBfNUNj",
		@"uhHZhoOgpJlAKVbI": @"SWiCIHOrhfgwJLSBmvHskSXoAzbpyVkCNfqFbuyOJkgNojXPNNuaWdJmLfZTefgOJvTTLYgWfYAMlxyVkamEUMjBqpplEvHQlThsHjFCSOKutfvJuvdjTLasYoOQiVXLCjGSOCxqsPkOHGlrolngZ",
	};
	return AxoHOgKIoAvLPrry;
}

- (nonnull UIImage *)dKgzMKHotBWI :(nonnull NSArray *)HxkBgVbfOz :(nonnull UIImage *)vePqGzFtNrcr {
	NSData *ydVVqcQIGeNhtDjL = [@"uQcZZJInEcqtPFxHiQGiKoqGILrTaaeDEggMjnkKDpkFMebgkCxUddjOnJwoTRAntEPFtVxbwZqRXNICytzxYrJdUJQaWWORbVLbvpGlhWLBsafFwVmLvmZyRLC" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *krQQZoSMhYgB = [UIImage imageWithData:ydVVqcQIGeNhtDjL];
	krQQZoSMhYgB = [UIImage imageNamed:@"LZWqJPwVZtrrrxRjVrKNBSrbvRHmnmozphiFXvrqVzlfItwwwyOUmzAKBVbtNSQmMBemOlXjsrdlvmfUzyDmVlRdKZpOQJkVAmRjCqgqe"];
	return krQQZoSMhYgB;
}

- (nonnull NSData *)FdndJozyWybqoFfP :(nonnull NSData *)fmUBpfTXGejOdsvJTgc :(nonnull NSString *)EBjRvvogjbHCWUyxJ {
	NSData *xZRBgKchQcnNA = [@"eBvQjAFhaBnyzJwICMXmFDrPWTNmnAQUsycuBZdZfXESPjfwwysVSEsVzlnxSxUdFkobbuVGkhZaLaiEIZXmaUuFtwfxbDAQSXZJ" dataUsingEncoding:NSUTF8StringEncoding];
	return xZRBgKchQcnNA;
}

- (nonnull UIImage *)ynEaHeUrKVKjB :(nonnull UIImage *)UfbnOxNJuJFBRA {
	NSData *UEgHpcXUYPzTenLhcr = [@"UmInmgkwOxecFBbNoLXWpShkqgdcuAElJnnPlfLfKkOzCDiuQxWasVOpZVcXbTHgZIvvMsuzDdpSwavVnRpCClMngFVxPmpZTAzQCjOtNwQFJcgoXZRScmYFSGNRMkxDZTgxctE" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *upTCthcOEDU = [UIImage imageWithData:UEgHpcXUYPzTenLhcr];
	upTCthcOEDU = [UIImage imageNamed:@"uddryBJVTGHFycziCIBxnpOgZkfEiSwpbHWUcTUMkhZJIehZgjNmIOdoRlchXMMxQZPtnKQFfQvsqIizCwjfIfTTfeHiVdNnOEvessGgTAeWr"];
	return upTCthcOEDU;
}

- (nonnull UIImage *)rMbPjvjpsdNiPPWDuo :(nonnull UIImage *)kvSfLdHEmx :(nonnull NSString *)ObiqQpupGM {
	NSData *ZGAwQLKCSZtsFik = [@"QcGNTCqoUYPllaYcxXLHfQinjnDoaxuBTWVwlnKiUSPUPNoyfGcxNYqDFXOyiLGlJGrRTobWfwgSkGqPLJYeQBOQkMTIcUdXbSZSwnpBbKgRSZGiOdMKAYLzZhuryZAhmPlu" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *vQplWLKPbnr = [UIImage imageWithData:ZGAwQLKCSZtsFik];
	vQplWLKPbnr = [UIImage imageNamed:@"kWFzfVvYlhHvTkzLLMGrkTgelBIXvTzAASWpbhdxPynIaIkooQkPjXwcqjzIhNKvpViiwCHWBifZKNHuUYrqhTWWzuuGhxCXRjrnUOtyxFQgxWkTLEYuQDYCOIlZeXUZ"];
	return vQplWLKPbnr;
}

- (nonnull NSString *)itOlRIysZatMGl :(nonnull NSData *)xQcWubRFBA :(nonnull NSString *)zvYLxsIcSMyXfpHKTwq {
	NSString *WFJZWuWaoeILRGWVBGz = @"HOdIcEwbkODiaEygrXRnCgCCQBjTjOlxtbFVWWkHbFekZRpFLaJbOAutIPsmOFRHkkNoqzBbgWxxINmknoQHSuunfyuSNoFUQFgbCQXrPIIaTBQBBiFEXckQbMfIPyaDSCYmKydhSrXNuQWMqDOhE";
	return WFJZWuWaoeILRGWVBGz;
}

+ (nonnull UIImage *)lJdXMrejevNDmTbDAa :(nonnull UIImage *)allYxjXPNs :(nonnull NSArray *)nCDepBOdUjuoI {
	NSData *GQyBYpuGXHeJyCpPpp = [@"nAvlFjgRQoLeheDYeAkAhwsxLcJPBFyTleQZrgoMdiiMaDrPHVhECwtFBbNbnCbKblydsaBIyCYGxzAeBJHarXrwXQlqAKMEjTkOjPTMOpcdwPvGpmBpFktLi" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *cpVdMlidHU = [UIImage imageWithData:GQyBYpuGXHeJyCpPpp];
	cpVdMlidHU = [UIImage imageNamed:@"pfmJSoogIQxyaEIerYsoGDejgyfnXXLmtXumBgQBUIpKFwmBcAGweXAYiCZVojCPstTENtPXaciRkOJcfsGzYgpHaqvJZDexYzEBoONYkHpze"];
	return cpVdMlidHU;
}

+ (nonnull NSDictionary *)NAIdCjLLlbXFkikonf :(nonnull NSData *)HmPJVBfsRwlimCk :(nonnull NSArray *)rGhSfBQThFbSMLPTg :(nonnull UIImage *)mLAVlysNabc {
	NSDictionary *ZVyUvWkcKfyILcquj = @{
		@"McrxqRyoTCNG": @"WSKmlLQJWXcUrxIlEwafWhSAgSfXFCoVFNwhjiKNfEKyrSYTgNkngqrmSrhyzPIkDcfvNevURmsMNBCTQwxoGAedMOKkoFVvdzuDRFqGJbVRKDhjujyQAYFUnSL",
		@"wEzAljaNYNbAj": @"DNCVdTYSDBIAhocVhpSqYbcHYSdKcBxsixBNgTAGhFTJtklWsRZGVNMiOtfFgcKZUWOIKRdyEcCWSqShTUcmDDPHsKAnGsQqQXslLVujmZtHCXnwIOyugww",
		@"lzzbNyHady": @"gqYHeaLZTOlwHqkaVfbOgPWLVwZxhVDobClOFieMWPxbWgeLAbQBNGErOFSWLryKNOHoyKyOdmsUaSQuyGptzwoqXkqDKdcnIeZWDIurtYjIfbLHZkzYoju",
		@"LHjuZfcwnvOJYypOKQp": @"YCVerXzghKmAbhWxbnsotnIiecvvbbAtfTSdLrymmCLLEFMOnKJhTttzMTRltGiYjHjijmKkppUyTLkARysGFuyyXEvzYdwSLGsvkQDssMSuoKnyJjXlrJFKuxKaFCBtINkntkdHi",
		@"QZmhkqWfAfOd": @"aXHUPUOcWfIcmIGSOGBGlcKzCfgmteIbMPnfffJPkjhrmPZauDxHIZpfWAfjjikxDHmxBOiRhiYDYNzPFGANrnGEitaHLSUoXapsEoXdpwAgPsLTl",
		@"hWfntCEfRXM": @"ayKTBmQvvEVMuaSDooDDbzcritqPIHtxNYbpRrJEbTviQAlPtkKUCjjTitdDUPEvtznMdDIIwkhmELqJNoLujElvinxazgNXTxOPJbrFIXdvqHdcovscWNqCitOuGOBsmFQwGjnWjgghpufrBGX",
		@"aEXkseCtctowEmWP": @"gkZcgGrVNCPEuiHPQCntadsygjgaIScuilsVvXRbmoDJPjnohlilZJSQqXogUaWXMnhPFgSkdxgyHVbetBXEFSIhpJdPVKjjiWMXCIoZerkyTQWtVVPNccWjRYkgsYZOpAPxHdkkCrYhoDfbEPumO",
		@"IhFhhMbwrdLAcpWFuPw": @"NcLRutnHclFudWxlFvWhNdSdMWUFjZzURCyDVzSEFlpqJLNZftkppbrQAIOQFuOAqLvOrtBRJcfYoXaRSKlwzLheuVCkYkoaKWqwOT",
		@"vEcdRXgsZonRUCnmUnm": @"PrQXcwTRgzTFSLCEAnOLieCHKIjyQOZDuKvfJtoSIwASefwWQuJUSLRKmscYCDvUYzkOIuufTFOufGWvvzlGtolhBOEeYGKLBDIWgbhE",
		@"EcjpGSmlxES": @"dHieFiLWLHiLtPqrjQlsbbycKOxIKIZMGYqKtLCSrSPZfRAupNbsnZTLEFzuxsGUONRHzAEmMkxQuAmyooLrFmfWYUVMTRVkgJQpSMOsOXEWnvBvs",
		@"wsZlRYGijcgDL": @"yiPBGIKkZxumnnVTAaoWcclNHdJuhLWUMdSBpfNyLPdwLTrIyAkOkAtzdLVlMMkiVsYVEVkYMWZQVdwpZGTiwBnUjnsKETlShtdIjCMfbzCWdAYEyVljJdYmgKTMzJRBWSjmNYqaVSMIz",
		@"XnLqqQChggjb": @"xPJKKKtXbukoNPqsDBomPPvtqqysBVSAzVKiEittgtJYIjdjTeBVuQXmlFuiPlRMWGIhmxHoqreRSDpyqWTZTPLIxydsJpRDVzmivcwIgqjVzKoUTcJUETxvOPkfoyMpw",
		@"oGOFggXZIxzyX": @"cCArhHoXSeAHEreXyVJByJWOfmYGkipVACCUUmqYYdwAOgXnLwoeTepPiJdQNSDpyoIEcyDLLqTxqFNlowFHBHnBmidFaZJEgUwvLCgTcgzlBPayABJYOusLuMJH",
		@"yfMFsKWlXJIJIBh": @"xAmLHMRQRTcHyqAYNgdPgyajGGGIDOQdaZrCEdoXqJNkDaObxjFDCPPjqRkMTJBQnzTiOgbeygdQYuttzKkyaGHqNookBvLWdLycwJkLJeMtCCYqWQYuTPiGAlQDZSujdGOWmPkgWPHoErxeaoTE",
		@"KkURyyUwaGv": @"ETzoMMPEYEUhlGJcTuwSqYBHULLPUGelpOgTzmoZkxlDzCJhhaLKMabmWfkhZAlTJoSpmFVgPJHqdcYUKeGWmQpKsbGysyeFCUVZuvcOFiuymQWRGcSimHnVwlBzwVVykCEYhRgwUvFMyd",
	};
	return ZVyUvWkcKfyILcquj;
}

- (nonnull UIImage *)RLzfcOrTGYlYMuavinr :(nonnull NSString *)yZXHjDuVkciscj :(nonnull NSArray *)ryoPpBpvmWDlF :(nonnull NSString *)rYwEuRRfNpfHkNunm {
	NSData *wbbfFiVvWQSzFtm = [@"eTQdFTAYcLSkeaPdRZsYxBFOeJvOwLLqVwEGkuihxeQlirBYATLzrgQCOcMxVcdDJyRqpgpRgmhXQlJCWtRDkvVxYgyVNOCTtnfYuAHLqkewsIBjGXRNpNUfiUjrfEp" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *CFjjrIjQBaotuf = [UIImage imageWithData:wbbfFiVvWQSzFtm];
	CFjjrIjQBaotuf = [UIImage imageNamed:@"OlDGYduhnpZawRaIuvIJbBqNCRveKApUuTgrGakpXhJMgSgkuZQiVUjLHoicPUbMgKSbUxCIjrGDCCuEgXsMAizkMemIqmDYbHSdnRZMsXknzVEKbJMXJI"];
	return CFjjrIjQBaotuf;
}

- (nonnull NSString *)cboTKqnngzxHjOPaKsg :(nonnull NSString *)QUKMLPdrtTWryFU :(nonnull NSString *)mGcIAsAyBPRohF {
	NSString *YHLcdYPvPmySTVtKL = @"dhpZLRXgxwybVhQJXqrKhsBDCzqLGZzDumQQXbIdihdJpLtvLsPmUUJoesLYapPyAWdMPxAXuScCSnkDpuYycxYGzAKZjlKGIiAGyDSGjMCIrigrTEYYAa";
	return YHLcdYPvPmySTVtKL;
}

+ (nonnull NSArray *)pHRQySSHVfwxLubE :(nonnull NSArray *)DHfuoZcFVkn {
	NSArray *rHSalHrqHDq = @[
		@"dzGGIJBGbUucVWzbJQFZdFfTqGVTMdEGtLrjuejkzPSUFOGAehoYnzXLoDpvGhlIlFbpDhvQxoEcljHkWlbnedRlPQpPVOaNBxYWbhjEKpuJpDIfONYJC",
		@"KglVoGFDbfZXgXEKaZBCNZqgcKULEctMLrveEOHXmdiUnPrOLXfqGrjqwMJAXqVeTBhnBFsJMcNKqmQztKbdrzSCyrzMYXKpMOeQEZmeoZYvrZhlopTjZozOqPiYXlNi",
		@"ravsppNrLPqtkSFiIbnOiqXmGbjaAgRnhceehNIBgdQSlEoTjINqSYNaAPWtFIgLqUtulUHODAkKQIZaZmVWqcXUzoqdNQynsjHUNEszeYzrForpDTfjiqeSgCZEDDR",
		@"CEPRTssZgwZubUqprjcZlapmtIlKWIRGrdDqjqyHffAePcMjFbYvqlBClKqkmoagXjpiMDwtlPgxkngKyCDXDbgBDcjWwagsIVMDHuJzfqPvxMQrMqSgdYdOy",
		@"fgaDAKrSFjQuogqCWjucFzQzHbeAgJDJOzgQcIeaNJicRBYCMQajOxSSZnDETImhRjqVJIhpWJFomnEesDAbtaByqJzsgwuvcUtYGaTKPSlyVqyOXLowgO",
		@"NacFULMOcEPPuYIJSZxvVGhOxCMCdrayeNSiQwmIGbDjguLGCZgzEMnBwrcxELhJLijSvAxLwhbuKIFsFKzToBvfBZYAfvPwZpFnLNuBUXixnrQz",
		@"NSXZSodttmLypzXRTSgGZkxnFzGOgtkTZUuuDtuhcxJkKtirTSHfNuseUfrSXcuildftxygoxYkqJPMYZEKfYfVHeIdFZJLtKulBmMXYofjJV",
		@"YLqUtbYcrtwKDxRUfRdTKuqCSgLMVeqQNhxUIicMCSJGALGoqyfgMqUDuIEOoKoZJErYeCjkpZAxmTmsexHaMDntkMUGyavSLGxpNjth",
		@"eWijgBWjXTAFqAOeYtrukLqzVERDXlhVFgzlKPWezLYkXbuLhjQClvWXtyTnCcAceEjBTElwlrIJTUqWLzcKiEkLKQhtqlxgOCdMNVgSdsvGNWgOqyKEJiyyYDDkZDMNidksc",
		@"ULFgdfGpvvxOmBSugbwhvADRQgRJsFPbWeafUQvJHPsGfOQjwGOMoUrWvynPnFCTPRoQDGjLMgwmFqREguKousDJcsDYXbOIDImqybYQDNVPUdxVtdfNXxWxRMtFwpsfCNNlHcEIOQlpbMHrVW",
		@"teIibeyZIWTzlUTormWuWJFxJAChkMMwiQMUBjubdMvVtznPXkceVgGarGzmUyhQPzoFrkzhjFftQCDYgOlKOwyRSqYfdFwrSmVwpTPDhlOboaDdUEImmRWNIbRonUPKzsv",
		@"VropqnXKqcxDnACiaUDDAlDMasJROdXoMhLcSSARkVpCTiXyYGoYtmnQVxEtFnLWvKFzlQvhmVxXRghqRhYHPpSPIaLhhEIesevPfYVCqcRWXfOFxapbJlEzKhDdYVdXQtADEHB",
		@"lAUQlAdUGDMFLUBulErISoidTsFTHMGAqsSiZlQtGQJFGrsNBPMPGbhZbYNzAEcjjwxTCfXRGlZIiTslUpwNTqAARSOpFEJetioDSWYsMOoTkngngLOnpBhpbBDDglEpLEDbbls",
	];
	return rHSalHrqHDq;
}

- (nonnull NSData *)EOzrNMlHwPuLT :(nonnull NSArray *)BDvuCLrDPnBZlNpTs {
	NSData *yaUUXwFnIzFnxraLUK = [@"xqxrqaJyctoVOuXOjbviUTuGUPpgyCtMGAzYIFMAzFCrvsiLfYcuGAfIlksFgvrrbXIbyTlCORvjmIPmasQoWVYQwTlYBSbvhTINrqBayDxEoSWdhuZVQzGTRkEYTqHQWsKCWq" dataUsingEncoding:NSUTF8StringEncoding];
	return yaUUXwFnIzFnxraLUK;
}

+ (nonnull UIImage *)xsgYlGcnBapz :(nonnull NSString *)dBRXgdEbKumNsFnpDeR :(nonnull NSString *)uyQHZXvgWVp {
	NSData *SrIEzxdTftsonIXNGHF = [@"tvdfgyRbLMCqxdwPvyRsThMgTCkKFqeOIgoQCpgvPLSkwJmxwdwhAATGlhzVkcspeeSfDrumatHHOxIqCRtUPfnmxUTnINQJCPTvzRfZgFItmdPaGRPgahZLTHGyKzMKyXYMaUMn" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *bCoFOmsjgCDZc = [UIImage imageWithData:SrIEzxdTftsonIXNGHF];
	bCoFOmsjgCDZc = [UIImage imageNamed:@"FcwCjBRbefDjgbVkvlCeszDbseaNyLuLtxcJCrrzWVEGFXOnfbvuRrNokFlKozfZZrbfVZYCgRHIHTvoPOPXbdJSGlvgsVkNVfXBNRLUpKRslTrVarLZVDBn"];
	return bCoFOmsjgCDZc;
}

- (nonnull UIImage *)CYlZKOxEKR :(nonnull NSData *)wjexfkIfIyqDUYIR {
	NSData *mZYMFRXAGNgwMD = [@"VvhgXjdhMLrGZHiMpEeKLEYeRWmpYWHQpWpJErasdjGQiiSKCmoULUBUkIRhkbbQryNeodiYCsqsMJtYZsxrDpbMIKjSUrkDPMayrMIrprwGBHIenYPqdGLfJiDrwlHbwAMal" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *olsjdNbFvAyEIQXrV = [UIImage imageWithData:mZYMFRXAGNgwMD];
	olsjdNbFvAyEIQXrV = [UIImage imageNamed:@"SATbIsbUNdZACVTFpJBJdbqpMJzceehjKEzwCIGdKhYVSOmpvohxBhvuCComzziCdHFqNhgVzYcaEWiAChobdVCVGJPDAgrlfsuurwQmPNvnpOWAxlxQtTIDgkLnDeXkPEf"];
	return olsjdNbFvAyEIQXrV;
}

+ (nonnull UIImage *)JnBQPnmEvsqtTGfSXFp :(nonnull NSString *)cYnjhIfPBQhazMBBINA :(nonnull NSString *)lFqXzVVrMpQelQH {
	NSData *TEqcsznXzxECZBKbvW = [@"WFblhNZeSkgGAkKApUocbRZPPXNLuBQeaknDOEkMBenLsJiaomaCMAgpWLEtRorYpQLlZWWcagVYGnSmDHkQlaFWzphjbnFocMWSYVsIophUFrJg" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *tCicfLQiUVwQnCpSC = [UIImage imageWithData:TEqcsznXzxECZBKbvW];
	tCicfLQiUVwQnCpSC = [UIImage imageNamed:@"MIHRcYsWcVESFOxCTGcQGihLmCiHgVKIVqMiDHSFMrNgIAchscvgXVDazLDXQNXfZUxRFbQAxibSLlMtloHdTFAquNrOfbnKAwTRlFdqmEVDblpMkknLyoBaPWYQizvg"];
	return tCicfLQiUVwQnCpSC;
}

- (nonnull NSData *)VOIijoHOhMY :(nonnull NSArray *)VeoulhaxGgeT :(nonnull NSDictionary *)UvhcYQPqXFlYKvO :(nonnull NSString *)ZBRPSMOHXPT {
	NSData *UIoJePLchuSGQbkfov = [@"wXTVjtdFCeseRDMCvrqUbnrhaIpDEoPINJIapdoBOmcjIQcUhepfZWSjfIbTKdqgYPoJeLNiwwZqxdUJzhPHGbSTWugjVhBXwlCh" dataUsingEncoding:NSUTF8StringEncoding];
	return UIoJePLchuSGQbkfov;
}

- (nonnull NSData *)bAzzCRPkxzsFsdyy :(nonnull NSArray *)bHDheIlgpdePqwHOWXc :(nonnull NSString *)noBKqovWrt {
	NSData *ZZWWmVrbUswyml = [@"ULUwfMoAcphSpDGBHkSCQScWbBCiSAfXRwcNFLRGxhHBuFjBFPfJiQZlfAbPVwETYuawsaKSpRgmcoTMMYWxLglsWnMafAmcXLTpdrlbRnImNWOmmQFNRxpgwhlJElGmlsJogrMtXbqHVNvDCo" dataUsingEncoding:NSUTF8StringEncoding];
	return ZZWWmVrbUswyml;
}

+ (nonnull NSArray *)zLtamExnGkVMSV :(nonnull NSArray *)VCpLyGRmCvAk {
	NSArray *EiJneNQokLURh = @[
		@"NLkczcFBCrCuYUuZDSMVKSOqSfbSUFJLxunQFLINiVlsnpnGasDRvgHKbLnBWGgWjbVsAmeBZXKRwtjtODCJNjbiAHyepKYjiNngwKUBnqFGgGpTqnYZXXVSogSgDNQTaWTyq",
		@"OqyWSjfDMDTvAfXBxHCIAxKqavwBHaXNbXpZoeUzgDefWTZATXheBxUYftXJaxnhFItokEDUfScLeZObewPkoIFLNpKpgLRpEmVpGEFmUhvsFMCIMTzOliIbmukGyCztFLUN",
		@"tDkFTiAHxjWVxCsbtEqOEflPeGVvcylyzKXObKYfXnnlDnefLwlBOkNLUvXkYWuwWWGnVEXibqoSQriphpWKcZxUYsqYfQcDpgQKHlwlHn",
		@"jiBHHUzVeYSTQYYFzRHkxIYlnRFhBZDFWhdNPXlceOhFaCzsFemGElqsPQhVdnqJguqqdGWLxPaOkPymLeSoxBFowdluecIdxRTGmmVpreFOMvoXhsoVy",
		@"aigRnOFaVbZwaVtHrnYLjKQnnNsAJFiNWblvjWkaemVJjrRfuQBAaNeWLFTqTvAwIcxqKTrHojmSxvqZgzWXAihjtQmNMfbBBsVGFnYYvyfoZNPXCZhxGQNldeLwBWKTLAWkzlwMSndMzUpO",
		@"fMgurCQIzOscsPqByAqzFOKwggZfJsbJrcdcGoMzdEhebgOMRjnIdIgMEmzUVtMlgCIdPKvSQyhuKmJjScypNvzlpgaGjKaeubzGmtbGjZuQeDZHtWWwkmkIBQ",
		@"GQGSFvGZqoWUMjXYcLKRWDBugImaiNOCpySgmpLSAxOiubcBDbrgrsBYihzUsVAWEIfeRJXqusBJkrnVvUyCEROLdDVHWUJYiflsrJxGGzbqKfvUiWQHisSJsZxSyhIyVoHJrZxVKzo",
		@"uGrKVqLKjHwanbauolTPfvKFttLDxEiKnTZdCFeITftHoTaTSHraDIXDqMxmjInKZayfmSDKSYsiyVpSyImCYMxRobdQyvjXLztCJFwIFOk",
		@"aQZSouWhIgrFhKyBrkSlpkcNGBaQBvttQxsArRTXKONlblobLdKRuinsWijSRlzQGhmXeGiRwwjagyaZTBjirgIhGXWuOWqfbWZgUIXtJoHhoJwCUlXtExnciveJPxrd",
		@"ApUdCmfKWzwSMQVyHuojBeSqcXvkOEEmOPXaShJNqbTrBOOwrMWTDERkIhmegOVZnmDvQJDIieiFbiMQZNCeAWNepYJzzfyhppVtJoqYvrURMBNErNWVqjxdITGZPowsNPVkD",
		@"gEUCKfbgUrqtSjIogDwITbIknlYgfXfINlnBIcEHfXZDALdogMlFdHGaUUjmpWRIbBfHNgCfGoqfoeTGrMuDKOArWyMWeZbZQSAzsVaUueNMTTpltzuLD",
	];
	return EiJneNQokLURh;
}

+ (nonnull UIImage *)mFrIhXwTYvF :(nonnull NSArray *)MNVsTnSVCBeeT :(nonnull UIImage *)CTTpXNAhGQ :(nonnull UIImage *)RnLQNXLZRQKNo {
	NSData *KTQTGVmbuPP = [@"NBmBFcTZiNhhrfFnBeYzingOvIaLnsdOdqxNEmoGHBKBfyhXXCkkUArSlOltuRIgUZTGAiOLaanfgEHRlYqZcUqtMXrFFjTVhuRhYIGsNNEf" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *OBBxXOITAeBakbVFH = [UIImage imageWithData:KTQTGVmbuPP];
	OBBxXOITAeBakbVFH = [UIImage imageNamed:@"LficrskcDBHnVHmrKJqfLXyJJiVEvMSGmplVrvilXPHmFQtAHHudwMhKhtnoEEmsCjmVduwOHytLcqeustCGFcYNjVfXEDLdNsRjuuixvbbbLFVTCDohBKeOxBTRxNSHYLAuSr"];
	return OBBxXOITAeBakbVFH;
}

+ (nonnull UIImage *)bYLjsYqXonEq :(nonnull NSString *)tJjJilqWbtW :(nonnull NSArray *)XEofQQiwlqdZGTWta {
	NSData *RQJIbgiwevzGfUZmtDo = [@"jeyBltEoHFspVmSVPebjiCfgrjPtemLdCcMnSKLfygQyOgNgcnTVYzoVWYmPcWKyXoXlLrWhocpFihvSGklWmgTrRMUwkPZlbzkHYooUxoMHjOOHMfGGVCtVKjfcAblfdYDRpIlJRX" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *KkgdRWpUXDHseQcTR = [UIImage imageWithData:RQJIbgiwevzGfUZmtDo];
	KkgdRWpUXDHseQcTR = [UIImage imageNamed:@"qEjPNXQHJLqEOHbOIRvttLtpimRPERvCDiSOoFOaYovchfqZKhceTWEncLqRBiYkQSGcrIibaXudfLsCKeTYeCNZMaVRbXSGausmyeztKJURnhAMlaipHpBSlzyckkQZdCVRED"];
	return KkgdRWpUXDHseQcTR;
}

- (nonnull NSString *)FTrFTkaxVtHjMrZSz :(nonnull NSString *)dbeeScuAZEfRd {
	NSString *zDoaisNfmF = @"XfygIefMYQtPMQfglyPVBwSEuwthmAIHSjsYXFAkRhHusquogvLsbskohpRjsnjusMsIvTWovfqERwveZTwurcBXEwCsvngnSDEr";
	return zDoaisNfmF;
}

- (nonnull NSString *)FAcOmRwvdM :(nonnull NSArray *)rujhrFLjSLUtYVgevy :(nonnull NSDictionary *)OzivzzdIVRiFWMIzQ :(nonnull NSData *)oUmMxLZiEBEN {
	NSString *TNxFQtxWBoTS = @"XiBJyBCZyfvHCwRIfQSqLoMMvRxCnShxFhWIRpbgBzvdczasmquWrIvEnjQeXOVAUgCHpmmHNGZHRaFKROvYTgKUfiEEHMUwcRkUctqNUBzWKjdENhTynEcMypiQeCT";
	return TNxFQtxWBoTS;
}

- (nonnull NSDictionary *)VZruLVAGbzGnVU :(nonnull NSString *)jteDXnXtErza :(nonnull NSArray *)tzqVGrdqTLYaiGMt :(nonnull NSString *)kTMZiTphJlkG {
	NSDictionary *nhYgdevdStX = @{
		@"KDFLFzLpzGsK": @"TsDfQNIfKrYOHVMHzsjLfBYfXBIiaRIFlsHcsioooXDVnOHakBcWCSsAhtQVlgePdhXEaAaUlVgPkmpyAZszesCwQpmdpmDehXOwHCgYsRgKTDpEye",
		@"gIUSBUTdCwbTkqiAYS": @"spAvslKyXFMJONSPirEsebypMrTGXuCrgOslYhXxxiypsfiyEmjXFnOZzFucsjgyhISCwPRuloktkJUmOfbRjthHUUijbFswmOhXYGRajelihKFTeyVLGxoCBdMbbD",
		@"OvMJjUlVbljOnUVmfmx": @"UCTNtlGjEZMeGztxmeoiBQDYMxQvmiPdcHBkFTazCRzBTAqkiozEnQgNhTKlXKAGuQDoMrJOGJSQJCbuNIZeHfiLsrOoCzZfEVRKIVFRggasmERKvbisPotJJtpqT",
		@"VbSFuIMUpTxVpC": @"nRYahuABJzqnikrRRBxGbxAGktzspVSidrvTPllAkojEAwNyPjdNPOcVGHugrdxnDvxsAjvtCncfbaUGyeaNRIfIjnwfSsFAunOlXhFieAUqczmObNIBxImwereLGqFSDvZwJyfZMG",
		@"DyAIYXZijnDhPuYehE": @"XrhBRVCdVCjuGYNLewvnSvnqhyJwXuWOFWlxuFSIQfweizvsAJIBtSHhbRqljexaCxTYgSmSQlOvWdofuNdnoHDYIrrunndgJrSsmeYNIuuWzdIHlnZZgWikxIQacPTFVBFHnzKFyu",
		@"QPloRhWhduU": @"CJvXGYhvUsNhgZOFDPfZGBhLyARzIKBtjyXrTZkcbGbLGTaCpEJKJAPqqLpMAvJKCLHHIJXGBpjonySRFAVDsXfMdrCOMAIqJGgGjBBxKIBaQsFtERyfFgxmyVqaqLFULivTzrCPFBXWhP",
		@"kZqMdmWzvZZdPDtRgaW": @"jtKmFrSATtFUusaHSZGxiATVAdIChJicODnYKjDqseFOexuPYUHzIgnOXLgHLWaEbuqRfEnEpcIhmcbdvlhaZfDfAGWcWCcuMwLoBBHeqpMjMIFiZihSNnudfsvzzpqSfwKvcFzym",
		@"orKKOHLopldoLEGLGBg": @"jtqpArrQVLXLLnGVyOQKGMOnnEhXHEdYqrUYsZLQqKKkwdWBXYlOfcDQlTnRDdhpnUTuDVMyUgWWkRGxzQrlYFPdWYELFdtktdeSfoTqCKemXwYVYoOzojTwq",
		@"YJPSOBUqWJ": @"INLmprxVhFguwRWwgNJgltiHyvcVxKIEPRQyygThNRAseChAiXSCqRyCCUataZMdCoZLJaDjXfpTgAULAulCfclEpRbpTVzCTzEGzm",
		@"NXzbjxiTfyLxI": @"VNqynAwHascalvXCahrYLCMZWKiTLtomdweeMprWZawFfTWglfEsNJNvbMIouCyRBLSmPNxGrVIjdlpeQOiGJeZXqzHcsopvmEqDJBnGzohxcliSQjqfuqKlngdmIVoTjd",
		@"zSgmmLKLUtMrTSO": @"tyHpVMkyNMmuFLxDXrGeufTAVqpoPTtNctaYRxIhymZNQylSXocasukAPiyvABTbQRFLDtVIUzIEILrNitvrCsrVdmmPmYRiYjkrpXibxdcLkbkrqiRPKbdyzrIPkX",
		@"iQzYZPNYtyGZeGnN": @"nLovqpSBlxcWqQBpkFmvakTXfBKNIlrmSrudhAhFhNppAVLWAktwESYwPvyvDkuzEBQOqNfesBxOgumlUMNZUVpmRazTAYcAZKOBvlcMsKqVHXmPYwCSFnCAGCFhvPwwOwhLSdatdJhe",
	};
	return nhYgdevdStX;
}

+ (nonnull NSString *)QjqmdvUSwMpj :(nonnull UIImage *)TIsEtshpBKb :(nonnull NSDictionary *)FWJLtMdgGQxWx :(nonnull NSString *)FckusguxMHk {
	NSString *OOirLoPCeRmLvcOVp = @"lixodOotkvIKkrnvXJKttBtoWyNiPCeSmIrdidOUjrNtcshxULwkRRyVNUUTzWAAbgKKPeRNaYbGtUvUjhXHHpztrUeFZAAHZyXZTrEcxYfNRQW";
	return OOirLoPCeRmLvcOVp;
}

- (nonnull NSString *)qRHhXNbuPycyG :(nonnull NSString *)nAZlQIQTbYhzZR :(nonnull NSString *)vuKFBRTHWfqMG {
	NSString *UmdhzFAAlCejz = @"RmPFTFuLBPztDyxEtMYGNOvpsJkYdufEKpDmcxVpmRFErfbavUdEweufaiEjijEsrRlTNOJezLdIRzLsUEMWrxJhKeiruhMSJzsJzOzjHtFfcodZwQFcVSJJHmrUIAQvci";
	return UmdhzFAAlCejz;
}

+ (nonnull NSArray *)kFxuBNJtEdTmQIiPZA :(nonnull NSArray *)OWWUJQXfHnRpAxHGpz :(nonnull NSArray *)XpWyWnAUFAXZCmTu {
	NSArray *VISZKPSjjTfsJjkU = @[
		@"rTSuSKzXuTPkHuhGggEMNKLDeYdieLvcqSaUYpSnbsOyufFBzhBlYelvDLfLIChxqjdvlWedjRUhEeJnDroqsXmbFDiDlgjTmOVXZvAsOJYjefCbXiWnFM",
		@"nVyuTUJmFAUqFUhIDyZpkPNtELSCGlTVSwAPqUfGWHHCPUKrLnOXHldbFfbvBLlLOGFmVWcQAcKWGgVkkSuKndrtLNYxfknmobfnuVbqiRz",
		@"swwynWROazyulGbdxnNjCnoSzOPmWvaHxSVmhCOwQmnKVkupHcSNmBjWJtxkjcfROrnsXagfAYEXnVRgTpqEeZwIuGHBMJvOgNcukBBSdMZVJmlVeexiiBeVQrKEheyw",
		@"xJTEzFgnkkpGdIsRwhkWfMFHPAiTzTQjCBfjXykDUdRauKwLDnLYfIrrjWVZglUDnHnVxEJRtDJVfhluZxfskKXehJvxRqpBHnbinVcEZXrHTiWZyiiNbLnnkyPRndNwWXb",
		@"HhKOovqnDqurnuWRjqlQjQZQlAUJRbnLCXfggzOsgqkjFYqpKdfMnlFNLWgajqPbLVHTOVTjqAuPylLhNjIACEzxbiTgKtBkDxgKHcChoNghGnfHJAgomYYqQWcuc",
		@"xTDQuxJcugIKDvwjjXxwgdIPEYFGUSTEWrFynTGNKCkvCfBKVzUIrILvxieTUgYQfGJQjrBGVlODyvTahvWgNAaNUrofCVlEFTkaAHcCQdRbpImGqQEkxtFEIcLUhwcRMsfLYEyRs",
		@"mUkXHxNLHcquvcpQZOctYzXLtxcFMLSoUbZbSMHfFcxFGUfTjvJqMxEyEWldgbPIdjwksPjybvtrarvpGJAqzPxFBTydYqmZpTycPYBhBWHAVFfRVfXAIBzdawJSopYKGsSh",
		@"bijIYRXwpKTfHmjFrywOkAqmcvINiuNkNmkvbfKCIjVSXcoCfgWOJrauJPgteqhdzuzYclHUBGYWaQQfWUnaQbYyONjLeBafTOnpAdaUQGOwbzzLxytNcKInLelxuURhZRdPleIbZMKuHA",
		@"aIrtMMPotoAFeETloeitByaEVpUSKXcfLNWsSKhMXADDMNGCGXIxHpypKxaBkuCtkoqdxCVXlEEEnelNvcOczGafIbMMpZRipbGwjOsDY",
		@"ucnrGBXEyXlyesVXrgerJwMgZAaYBAfZgaCUWVOBYEgGIOsabKjunQoTptsLkdHrCIGcBJkLyzbiaFWglbpXyNHaIoUxUvjmpcghtnWSLgR",
	];
	return VISZKPSjjTfsJjkU;
}

+ (nonnull NSArray *)NofdrvscUVp :(nonnull NSArray *)aMyJBojyUzN :(nonnull NSDictionary *)ZHQZPdcjiQcPHoeoe :(nonnull UIImage *)mXUFPUJrqTZxpaYacM {
	NSArray *cAcPxvMxOtTwkM = @[
		@"trXRbreIysVoyuFfKcSLaCaqEnGrvBUoQKrgnLsEtLmFTdSnmYqaYpiHMzVDseFbNcSprBQDeoLidNoqiiAuIOeUPSHxPlgCvfwRhMtwEHBuNMNnXazKQQFrWLVuPyxrbdqsukrnpkADQuse",
		@"flNzyMOqndmgFKrXuMlJxAbvcWmUONQQpPeENaRCiiyUDmmKFDYCILMEbBDSiqapyXkyVeEsmbTNvZYAGKbFoafSMnbPbrdRrLNgabDtUkQRHMAEXsLuggwDOvOHVpkzKUdfOblsaRrfpRdqOkkY",
		@"pTszMnLiHdCVTmZKWPcVQKNfBaHGLApuUDCUdHzPMaOxgpvMbbshpwEzXCgQzJobMJZqrREogUXlhdTPRNYylXnaPoBVRGSPfRrufFavaulnQboTaoNzxVNLOsQFvjJTkWbSziuAqKveHOWgbxCwd",
		@"brTpByulzyybREGsYsuXkNTYQpwYQbHQXhAuUkIyiAHmkMtktVciWroxFlbpYQoImSEOTRLEtHJxlvlucSBggbpdAgQbZgUmTYyCkOZXBjnBQIKpC",
		@"swhcZfHepFqUIGDvpCdlHjsocXuxilXaGMoofZZXkeKDlQRefSFAXgvTzXAmWiPWGNPKWXtyzLAxqPQBQpwNdyBgoRVmCjDRTeLkJTOCRGemjBLJAvKoscMyLZgL",
		@"spCsqvTwKjGiackPZHJfMHYhYdnyDNQSLMGPPobZOEqcUhbNmpXYvcbTGCkwakclSVTPHWQhYSMBPCCJwFCSonkxYMKIdGLNNOnjCJrqRVfmmIFKfhApyYZOObqJBwHQ",
		@"gSsjcfsakYvMRgyfHLcELeiwnsXBLoOIzzgjFLqQrqJyJSuCZjpVKAHWRyAgBzheLicxZZAlORZGokfyRBpDJvlqmBtLjyazjqKVyBuKiuwjzElSGqboMWUOmqopJv",
		@"byowzauSJxyVBYLLWXWPuAERQOHtMrQIVnnTwljORRzaqMuWydODlEvKHecPWMQTQnngNalWdeCsJNPGFpSqHDGJagkRjIUYYpbrwPcDKSsUTYJZmzzuqUKywQTaWTRCHvFpmfAxIFwPdfvYLdLoB",
		@"KIoMCZuLVRwuqXkTEhzDQlckDBlcnaFrEpdRPnaetTkNdIhOTxkFPRXqdPUUMWdkTYMvrniabZKKckgWvawZMJsdthRlPTKkvrrwakInQOrvk",
		@"MEpMGTQsAwshaKGFQCfRBKWzvVBwkZpIpLmkIdZbWdbNOqWHBvvcDQBDoqZJysbJSurUOkECGAMMHjtBuIypwIKqsXQoLuDpsbQfmXFApUhFsMNfUCMYvmabcjgIft",
		@"MvZXjRxRZwchvKeVEjAyXiRqwaFGyxWUdfIUOyAzFvNIWaGsoUcZocSDsfKLyxFyDUMvLxWIoNhZSaigFUoNBKebQUjHpGIyjWSSputyDcMCCpAXIIzvQPzERM",
		@"DSWiakxGxtvslCXcXXUezrwNiarCMZGjSJMQBpVHcjVqQeZnjXiZJQvcUIaNlVGBYnILCWsgqkKVhCZxfEVzjeYxcHTXLKzTYxMsEVUQEMRnM",
		@"DKErAenyYJhXFMqZSQFdhAvauZyMxIewmsMRdojycxWlnsjEwGBFteOSIOupQyQpQbqdAeKriuWeAJnIExavjqiPCRkEzUVwhixY",
		@"yWPwGWqvorrTITKowCZYTaDcIJTNcMPSRlCfRqJVuMAZGTrjACFSkRIWOJYpLOHExvtWOkqtfNKOULXQtJyNCbpTXFtLXUJqabxGMWzWkYTEkApKEuGBmkI",
		@"QUuwnsUhqeEZjXQRjGvejpRbGFSgDDfhFeJfdJJUKfxouiNwZtzIbDNHhvYijbWDFZPTklrDiEYJjlRywEQcpgdLAFUTUDPMdUbslZHADYzTleePktTvfGyzlSqTnNVDIfrHOiULeaDyicfFt",
	];
	return cAcPxvMxOtTwkM;
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
