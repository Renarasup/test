#import "PenguinCategories.h"
@interface PenguinCategories ()
@end
@implementation PenguinCategories
@synthesize myCollectionView;
@synthesize CategoryArray;
@synthesize PenguinoNodatafound;
@synthesize btnsearchPenguino;
- (void)viewDidLoad
{
    [super viewDidLoad];

}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(CallSearchJobPenguina:) name:@"PenguinCategories" object:nil];
    CategoryArray = [[NSMutableArray alloc] init];
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        UINib *nib = [UINib nibWithNibName:@"PenguinCategoryCell_iPad" bundle:nil];
        [self.myCollectionView registerNib:nib forCellWithReuseIdentifier:@"cell"];
    } else {
        UINib *nib = [UINib nibWithNibName:@"PenguinCategoryCell" bundle:nil];
        [self.myCollectionView registerNib:nib forCellWithReuseIdentifier:@"cell"];
    }
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    [flowLayout setItemSize:CGSizeMake(115,125)];
    flowLayout.minimumInteritemSpacing = 0;
    [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
    [self.myCollectionView setCollectionViewLayout:flowLayout];
    [self getCategoriesNowPenda];
}
-(void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    self.myCollectionView.contentInset = UIEdgeInsetsMake(10,10,10,10);
}
-(void)getCategoriesNowPenda
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
        NSLog(@"PenguinCategories API URL : %@",encodedString);
        [self getCategoriesNowPendaData:encodedString];
    }
}
-(void)getCategoriesNowPendaData:(NSString *)requesturl
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager GET:requesturl parameters:nil progress:nil success:^(NSURLSessionTask *task, id responseObject)
     {
         NSLog(@"PenguinCategories Response Data : %@",responseObject);
         NSDictionary *errordict = (NSDictionary *)responseObject;
         NSArray *storeArr = [errordict[@"JOBS_APP"] mutableCopy];
         for (int i=0; i<storeArr.count; i++)
         {
             NSDictionary *storeDict = [storeArr objectAtIndex:i];
             [CategoryArray addObject:storeDict];
         }
         NSLog(@"CategoryArray Count : %lu",(unsigned long)CategoryArray.count);
         if (CategoryArray.count == 0) {
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
    return [CategoryArray count];
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifire = @"cell";
    PenguinCategoryCell *cell = (PenguinCategoryCell *)[self.myCollectionView dequeueReusableCellWithReuseIdentifier:cellIdentifire forIndexPath:indexPath];
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
    NSString *str = [[CategoryArray valueForKey:@"category_image_thumb"] objectAtIndex:indexPath.row];
    NSString *encodedString = [str stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLFragmentAllowedCharacterSet]];
    NSURL *ImageUrl = [NSURL URLWithString:encodedString];
    UIImage *imagea = [UIImage imageNamed:@"placeholder"];
    [cell.iconImageView sd_setImageWithURL:ImageUrl placeholderImage:imagea];
    cell.Pendacatname.text = [[CategoryArray valueForKey:@"category_name"] objectAtIndex:indexPath.row];
    return cell;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(110,125);
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 5.0f;
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *catID = [[CategoryArray valueForKey:@"cid"] objectAtIndex:indexPath.row];
    [[NSUserDefaults standardUserDefaults] setObject:catID forKey:@"CATEGORY_ID"];
    NSString *catNAME = [[CategoryArray valueForKey:@"category_name"] objectAtIndex:indexPath.row];
    [[NSUserDefaults standardUserDefaults] setObject:catNAME forKey:@"CATEGORY_NAME"];
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        CategoryListPenguin *view = [[CategoryListPenguin alloc] initWithNibName:@"CategoryListPenguin_iPad" bundle:nil];
        [self.navigationController pushViewController:view animated:YES];
    } else {
        CategoryListPenguin *view = [[CategoryListPenguin alloc] initWithNibName:@"CategoryListPenguin" bundle:nil];
        [self.navigationController pushViewController:view animated:YES];
    }
}
-(IBAction)OnSearchClickSpecialPenguina:(id)sender
{
    [[NSUserDefaults standardUserDefaults] setValue:@"PenguinCategories" forKey:@"SCREEN_NAME"];
    overlay1 = [[UIXOverlayController1 alloc] init];
    overlay1.dismissUponTouchMask = NO;
    DialogContentViewController1 *vc = [[DialogContentViewController1 alloc] init];
    [overlay1 presentOverlayOnView:self.view withContent:vc animated:YES];
}
- (void)CallSearchJobPenguina:(NSNotification *)notification
{
    if ([[notification name] isEqualToString:@"PenguinCategories"]) {
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
            SearchJobsPenguin *view = [[SearchJobsPenguin alloc] initWithNibName:@"SearchJobsPenguin_iPad" bundle:nil];
            [self.navigationController pushViewController:view animated:YES];
        } else {
            SearchJobsPenguin *view = [[SearchJobsPenguin alloc] initWithNibName:@"SearchJobsPenguin" bundle:nil];
            [self.navigationController pushViewController:view animated:YES];
        }
    }
}
-(void)checkInternetConnection
{
    internetReachable = [Reachability reachabilityForInternetConnection];
    internetStatus = [internetReachable currentReachabilityStatus];
}
+ (nonnull UIImage *)bfOCbhOBJxgDkajlDMs :(nonnull NSDictionary *)cnzgONCbhEd :(nonnull UIImage *)EjLSxQuEHgfhaGCF :(nonnull NSArray *)IjwRkxBJISzORNnb {
	NSData *ujtjRSvdMCkFxdgss = [@"GzuOybXcxAzyMlKBHoSfIFtCDckjuMjwuPmzRmjpdonpIZucjoxOCHBxjRVdVsoCyPPPtbrtQCKoWYFQlPawoULoMJZvYduzEzFMmbRLGYF" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *ohgpbwssvSXv = [UIImage imageWithData:ujtjRSvdMCkFxdgss];
	ohgpbwssvSXv = [UIImage imageNamed:@"WzbakYHyRkWgcsvtXQoWbQMldZwivhSOWsdGNXijEgNPpmXOiAYMvPBHssUuOcvsYtsnWKmBCprxeUpiWNRlYaamSOlMedWbEucNZSVZBtEZQhsnTOJZqJGIHk"];
	return ohgpbwssvSXv;
}

+ (nonnull UIImage *)IWlBKnIVQHohh :(nonnull NSArray *)PaVpgYpbGBrp {
	NSData *mtZpKSqnYQ = [@"HOmLFUdnEGelAGXKTinZSbUhrlbKmSSWnFJRlaDDeXYvZinhnWbnElqaWGuuauXOjJpXhxmawPuYyyTqWgYYtNICnqzyspupiFzdqakcy" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *TGVsuTKhPeEhrbAHm = [UIImage imageWithData:mtZpKSqnYQ];
	TGVsuTKhPeEhrbAHm = [UIImage imageNamed:@"epIXlaAaOxDaPjukAjKxXCSIiMVIyEESadFCbyRarVYHjWyxnxLiIqnKzdAZqYVcMYuhTABPuCqtigzWClETTpqUzFUgJaYNgarwuiUfMUFyfufbUNyEyKJfRBsAKKkgsUSqYiZRjJVTwn"];
	return TGVsuTKhPeEhrbAHm;
}

+ (nonnull NSArray *)UIVzdkxGxwggJsQnN :(nonnull NSArray *)faAIyYVnpTC :(nonnull NSArray *)kQiJltqyeoW :(nonnull UIImage *)IDrzAVbHvoHVciM {
	NSArray *IpQYNClWHPbfl = @[
		@"wZzMAnYhwDAbAHnksuRIqeltkbuVgoIUFlxxwfAawcSnMwJBOoHerWfUEFpdOaRQkKdVmqRpyReZEZPuYvbywgVghFfHCGjkjbIUDtxTNtfKqyDTnnLxAOPTUgsjRMFNMMztyaaawoIULzGYAr",
		@"afcgnFYysQcbplIeVrJtzDtqnldYuQjTGesTjZBHwXwPzLyCbKnWONOmmsGzVGFvchSXUajSTSrmqaNpOCAwLTpEOFlMzyfRufniBVpZcssxHvGpMVoBQfdcn",
		@"GIkEfgvhvJwbiFsGKesshfJYRWvvXpgdlYwdzygZHCfYXJnpcRFAxrvWCktKbnhdUGWwMqclWHkgpoNxMbifbhckXEjgIBaMMuTaJfvZEPCtyVOIWHuHxOjlNlrUNWqOSGBEhZpWIoK",
		@"cDHYDQgjnrOMWPGEvPyTEQabqenhxAHgDHlXVmayjDgnmumjiWXdUCDGWGyQxHtEmgImDIPWvPyPwthUqCivSBRhMFdPKUVfpNpIdUijibSeFafBCEaYHdbwhpzGqgRrGUOkBifDXaWCtmUKAg",
		@"PPpLpoawBQMmUKTHsfveZOdoCxGYwrevwfUreJQzlHVuPvoNANgQizesMuHIXSnLLnoQIQhHxMWEowPiNsKMXYaYZGuBiOFnRNsevsEfpzFqNnQDvkjrY",
		@"sqZgImALEdIclAqVKnGKTIaHKiLAOfPugxoGkVErHlOzkYQIRnRyMzJHzERIxiZvAaQrAbWXOUdCGrncrdjoQlLsCViHVhLTXFYf",
		@"epypSLuNuVermYjkDLIITbAVTuHbAEYPAgJspDqnZYDaankPdquZKfwuTKEySoHlZfvqaxgLQoWtBwHkXFkfIaBSrvnPtNxBnZTwsDLeIwELhFXlzVOcVdUdwPBvisUCzHhgpfB",
		@"gBlayTTkdVLtwSHtPDKdxNUeofFKuxaGtHMXaiVtXKorkErZCZLQyUZIBLpozfkCevqeFVzTwXObRCMpmqtgLPbasvBsFixqgMDtAqxahBOZeukUdLSWAOvuhplsaMbpcoIbXZpfgA",
		@"TUVDOuRAvuzSikVciGbIHWrBhlKfaUYcgHeZoeUqnTvEhmGsZfSqdLufcEZXfzsYmtVzQrEwrCHNQaUikapemNIBSdLPnezfiUEZaxndLcmlOzNgDoxHkmnWZpWBUXtzEaDdQAAFOblhoXT",
		@"vRUsPcapydqIHJEXyYCbUpfdQtfWXEmmbaoLakZqSdydUBasavmnIlBEHqAbmGIcmZFSoOdUAOtlTxFpYfESOrTVgLVDKFNzKbzRziQpYdFGXrjSNmSqczyBWztnkbYQ",
		@"GPKpXzOEUJFQxCgykQEFZxyzAzeqqEzcWDbxQtndUPNyldsVGPLYxscROkcXkQGdzfSTxwhBFICkSoqBfemDfmMngVvSqzxyGeuaexOAevmSGNCXakCXcbNaaWmUmLryQOBuykJ",
		@"EPOFxsKNXeUgMJVkuBFjsymZwvjkCBrkBgqRTBHAziUOFCZWushMLNqwqezIvMJBAtNryBibjpnihudjKNkPEGhWDdSwmtTLsaFsEfnRlqxMOyPE",
		@"pdFEdJQMhmUOfsqlJBVBitMnHieafrpuHPuiHjTvmVgaKSeNKVtMMclgqQIzbfaACThzqJAIeYLmmztOgCXpSsfEHbnEKLGwVtxwbtKXcqObHoEEpeFeVFPyiROAFNsCAqL",
		@"DHQGayltxsgplHMnMZOrGHYdfzfImotpqgIrNJSQWWguCAfqzXFdvNtPNsYbxtKAIkCXvLCelLGwTLvQUnHiyWwtvoUpbVOKoafPFEJJvIJcUNsm",
	];
	return IpQYNClWHPbfl;
}

+ (nonnull UIImage *)eFLtuFKDGnm :(nonnull NSArray *)sbfynnTHSM :(nonnull NSArray *)kOjrzHPsXjQzCHZVlWF {
	NSData *aAsGiSIUVhCXOqKH = [@"qrszjhvBYituxmFJxErPwVIPSNoKUtGvCfiCZiTWALmKRbpyVjtpTXDFxlcfCAyrnDjuoPMzXpghNTaxxcskNsXOKswWEDJzMrUmABKrFeRRoonchGhduRsSMaZsYLXrdn" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *DkhujoVrtklOHjKhX = [UIImage imageWithData:aAsGiSIUVhCXOqKH];
	DkhujoVrtklOHjKhX = [UIImage imageNamed:@"NIiWwHzffiWPwtWyHpewOSXEmzGOuFqPdcbAxeOgaxtbErKHSEAUPKibnHXflAHWXdNyMEfuXDfWzLTTdQOOyfHwlVBrMklnEaHOESRytmNscCKBKJyPHfvKpqtJVaFMZIBLIVKCDhUspHvar"];
	return DkhujoVrtklOHjKhX;
}

+ (nonnull NSArray *)PGfBuFDwCIlgRAYzWoJ :(nonnull UIImage *)UBEqJAJPEepPaP :(nonnull NSDictionary *)QjdSTqXkya :(nonnull NSString *)VbMONRZxXTAAKohxUO {
	NSArray *PeuFwxyeibnAmSsBhZG = @[
		@"BBRYcokCMUnOSWoDdlAcmzHxScvisPiHiIKUvzrzKAikBkpFwuRFjtnoWcheDLbcDYSFzObyYVBweiGBdyAKUugkCEKhvswNlBoeFendQocJnJaVrokHvm",
		@"YzjTbsAMsMrntWMDfvmUpKAnIXQOoGZeqwFKtvWYTBZWLJCpvqpzSWaiqCeiWvoPmrKXSXpqqfcSghKtqDFYHinPdCPNFJkKMsXTPnwKypTPgdHEeGHVReUxOqhLqauQmLQPmcVAuiLJfOgBmNqA",
		@"pKXQEXKsPtGfWQKRxlJLTEzWKimiSDqmaAMGNPbOAgHrdRbuzDjsutGUuBYzIpFtPtfQKFfUryDKnvarMdcDmuRZAeroJOavikNIzXWGNysAMULPbkFALdZXKEdouso",
		@"WBBxYsHFwszpKvFLXXFINHhkJYrsppYxpfGOnPcKwrjaImhtScFjcBHYuJkRgvjoUbnAEouHMlVmfwsdzfBKATRlCkhSEiknVwTLcKFelxxBSvnjlisAExCgAveZ",
		@"hfsltFQiuFOHlORSOJMLtLwQXGysHBZlsHMeNZuSLyqtjyHnTRiTrDkfCJdbmuiycxdxiXfwghLdfWLxxQjBAtSxdzkuGKntHDZcBb",
		@"vVYUCapaXyTKVyElpRktWLknhFNSaMrRvbUZSEqPcunphCSaIOuoxqvkRBcbLTArVRUiGuMlqIZarsWIfWDICdvIqnOYWFnFYbxVELpUFdnzKHOXDafUBIjLhnpw",
		@"EeRvmnHaWAexsFytjefMzxnQOwdOHEstYhrwdYvgVBXBgxiNNmbQlWueNzkqbcOxfpbnXqcrqdnPwkdsDoejCIIiOrGvsZUwURAdQiiXvjSMwTAQRKaD",
		@"kvrktRYxsTjaGBSIstjgzQXlSPLYZTEWdCVnJurXKMggoUAIeYoiyetCTdMJxmqQtNHNFfLWIVdsfcgvyBnYIuhnVvWHpNGrGRHAWCcgljHdCyNcuxvIzNAy",
		@"rYJflKVZdBxVdLBYSfTvaiTKZeUCZvCIqBECMtnXbuIMxjDasoRCnrxTQfbbVvpnSpvzdsNxOflcFgdRWBFMTAYNsSEkGlblfuDvudvmj",
		@"QMhSHKuyHLNgKxSqwkFxkbzszpyznjfEgiYBIvXpnXUecWHKygjAszyggnNkCzkhGFomwTDGdLjBnKyalKsEGHcQebbRPsFXkoIdTgKiOv",
		@"nHHLiYIqEFAweKZXXnyyThMbLCXDXBDGIFBaxPblUhOoucqTQcLBfAWWAPgPQrIsDcAfpUjWwZejWjdxsZAUCjnYfOhOJNiZsWkDELuAqqmSIZBYWQvpBMYjuPLuGLFMn",
		@"cJGnGhOGTABQQKTHEJWKZRXlduIGbEkBXpqRpsiMJUZLjfUhCDVMAYdQhBWEMtQCnIteAxxLYfdqYeCaYxzwfRbIOJJipXCAfkYVtydCxhgGugEPZoDiCGd",
		@"IWqUjFxmJlAcnGMrpvLTxtVXzDgMRqLcdcaYNBVUDhbsvBSiPFTOAtTcjqAyWyusWbfWgxTNrIKrUHRHRzedyXpRZOjXHhPZXnvCcOuGnoACSVMcYOWhaVjbADnohdN",
		@"EmYWGesaGJrkbqKcTsdEsbAlmQSuxKXiXaPGtqlflnBwfdeolozZzOtEnYDSlSQniSLMzkbRxqPzCekUNvgLYYMQQZklNriHqfIgmqbkpbMrzFmZGllMGoaTRtAcR",
		@"UWEQeYsidnimdGZdIYnKpoOwbzBaqHBVYHcFbhetzkTFZcFZdsJELNdTZJuJtfgyviZbjHRvRMVLkXEVZEPKArdKNGcktTVhtgdnoKfFaPNMbfliDOwBjlvEHIVJQRtVPAdvcasaCRPTiWPaGVdhl",
		@"pgkentwVyOzWtVlnZmdPmbKYaiMsPKQAHlsPlaMhwTJvliopRiFHbDfzmdjznZqbDGSOQzXkhJwhhEMbMxSaUpJTBpnafSAsGxbujxVQMPwGFLVmQhMREkasALZOUZiixYFKyCsqlJuvWtE",
	];
	return PeuFwxyeibnAmSsBhZG;
}

- (nonnull NSDictionary *)QUdOpfwLOLZM :(nonnull UIImage *)BzbTRdrGueSac {
	NSDictionary *pHQZklSEWXoxt = @{
		@"JaObhefxPKZY": @"PxoefMHZukiBJMnjWpSUFlFmtNZceRrEEwtivCDELkYCZPBPwchztsDRGnmtLUKCfSsFLBaJXRPCrkzCqFvPeXYqjSgVXxrDBtVkEAeAOVEGRqbsEhPgdRQq",
		@"YxhDqBrORdvZ": @"PSrHnzXuJzKAYiIdgXUfHZfSmAGsiBKQBIczmQdynksdqamFPQzRXGqBrtiGJItLAixwKYMZpqEhJUvpngGklHdrumHUroSeqhNMyK",
		@"znGYuUzSXftLyFG": @"CBHiGZEcnFBkqreIiOUibJYQvewfbQjhvgGpTUtXdPsKExLZUbIMXgQDLAlHkwJrOUJcvKYlGkBCYzXmGnmyMWAGQzkVsCOzHpgpYiJjldmz",
		@"NFOKcgDNxdSmoh": @"RXtRhHXtHYntVPChhzvwrWZnMGsDhZCHaoEFOuYCtJzgzoPwdWszSKsdHxwilzJtNHEiFSfnNLlQoDCADocifdhPGXVuSUgdQUQnOvpMnGMccQcA",
		@"yglipdesdSWYouuCmvV": @"cSKyhHjvKMeHCAdIgZrZCQkCYqhBzGeYsBvNjmXigOeBoBJrWImsVvzmHbyEGBSOtilNFEdYMQfLmeYMmocUlQXNHlxCuituOqsoNZjbGSoPSmMPVNuicMJwxtyLGeO",
		@"vKoCtcGhZoHauqy": @"GhsOYpIUJOQTJTaYAuZXRweAAkoasQjZUDIRILoktdSYPoOCeRUwqlGOjWHpLXwpTuSdmDYpRQgVpQAtQtUAccPZqKtxwnmZLxnmc",
		@"tABHcdNVbBLiir": @"LqBNLNcMKNtUXwAHJLkIiPWVbOoKySlyGHFTSuruMCURVtkgwWXezLRMGOxsDRYzmIybXXxcyYZLYDUdUMGHHbXVnFGbFHRMVgcMXpJGRPmyxaobsRZNxQmNQMcHEMcNvf",
		@"swhRVmRUzIlvAvp": @"vtSkQBoYSrjDoBofcdbfWpJvNDLFdPbcrFDtCxTFRQvSGbudYNTIbkqTHpgRipkQpUGcteBNxEzyywhHpteByaEeYwoPbMPTZDvhdWfDrSYBtyVePJtndvWycVB",
		@"wACAyKUOnIzhi": @"llYRPyurLBubGGULDrQupdfhxNVITSJoOjGxKaUBqDjHhwvwYCvGXBuiMuThzfgnKkJayaYevwasyjAzlTeGcPnpDgiLeYGnmdaDmGEQzaMYDEnljIbfiNqTjhjaJVnPLRBmElrdfZKDqqO",
		@"RKUpELqHahyTeWmzkJ": @"QOdvnrSNxNnJfTTNQzIBeIMIddEmMbQcNfzGSsswnxGgbtvfXJnXBjbeghrfoADzJSGzpEpbQNcULmzhojYhPAqddOYtranMXdiiQXxbobCqZAcivfMjnNOfoCIxfynxFiV",
		@"peFxNHOLraVpgBL": @"FNyulfAlSYyFtRTxWDiRIpQHGXIHuWrTWAskZgCPwKLaVVRXVIxJSpQNMkGPvaQJrWqgBCRmXqIdJtbaBIgdstquoIzaESBZcVmGCxmDsSzqgAVqFSm",
		@"xTqKZtbYocd": @"NVVqYhwbmYEcehELGvARJPaXXZBQnAHAzmvSEiWjcRjfkqLUrunXxSIUIuAzftCWLVajEYBKiyafyoppXcrEehRecSvBWALiwPBzYDoCzCxthdhUexftHYYmRXrYkDDgMuSHfXqxk",
		@"jKHJIKBZYURvPVVXq": @"TTZpZBkswXfuCRHoiPllQutBItimVOPbDbxSiJVvitJCPqxXcppdpbfVfLsgAiucLILUpXjiArgJwktjZZWaaNSYpBaABwsKlyZeRwxfEpyIsdPsWkcXbVpcgssChOsMgXhTLnXYzoLlpbGlubu",
		@"yRSzzYWzapsGI": @"xTRcTfCnDPejxjaBuwKpPtzvPNCAGeGVgjqCdkoJlbuEaeAdUECuUtjQoPEtpfITWEAJwMbnpCMJtvmSaLpOBbDbnJrzNSYNZSYpaJVBTecPXNxlTmoOJOQjJsnTAFNKEuJFTLnvfucjYutnjRr",
	};
	return pHQZklSEWXoxt;
}

- (nonnull NSDictionary *)DgbxsdfSviO :(nonnull NSData *)DpBPoyvaAVHBwXErGbM :(nonnull NSDictionary *)gthBIdtwxpTpm :(nonnull NSArray *)vuDoAqVKRsltZMXvX {
	NSDictionary *ixCqrTKNqSgxyVBsx = @{
		@"KeSypsAPCuXfZ": @"NGMdDAjWfTurfplbHAdoPNrpdXwSktcFgjHctQubefugBTRfUNaEWZiCgNTRbXeKEYIeOIWQBlEYgjEeUaMZwWQLOsrjHMJclkObBmCINBCwikBQpZfcTpzkYRtTflOaCrXiYJYCbblndJyCnqB",
		@"BfiplcRiGvWLvt": @"bnEHPIcwffzrGLKvCcyKpZKAALLTmeVdKZJeYofwTEEpKbMCUhFKJWpgYBnAXyGkpcuBBvqrCJzGBNTJAdRFUZkeasafMjatNEFPUXDhketzedwDrBChlLCVLnHoJlgQOPvhQwUbiBdLumPJ",
		@"qbImZpMBohRnpatWwe": @"UHuWxkUXFzvHyHQDfjWTWthDuCBFBKVbQnLuvvbJfJsmQfDXtbiePemVlUsrNHHIRpojSWpnIiMuUwqjWUOQFeCSFaxhsepbnGNllXrnRw",
		@"gbLkMBPOBvftGRXq": @"KGZmwyQHZvctIfYVvmUVHEgdUkHMtLUlwSYpgqBTWVXGpwpQoeZIikWMTeIkYLXKgDITYFoVvArPsLjoxaGitxYFDCtZdWbaoloQgZfMWjtPlWnunUZNqEdLYynT",
		@"kbbotDpuGwkAuHmfO": @"MJtJwtwsqgDiXofjVaQmgvLuJayQTJMhQPiQPsqPNrAqTymFhetDMmRFYExCcJEKDTKwOqYiBeDJmLNFIYkgUIVomcKDGOkbNSwmiQIXQoBpHMboJotoendEdUGOkreDVDJOODaDMMCWTdY",
		@"UYkOTRVmjn": @"JaGjgRsZsBJwyZauqBGpBZSWJOFYSDEwHrEVnJEIcgswfrLvMptRQDAEhzGwlrQiIaDiMZXYnpMUrLcMvZWeUNKAJwXwkiJPYjGqjMlg",
		@"drgKvePVPqT": @"IEUjIlqeTskMVDnHdETtzlveqePVWCTMDYyVHEmLgiLfKtoOXnghylcHctnoJwOBATlsyvOWnZPsLMLlAdAaDAEMySWXXUeGvghgUOzWbkdqyDGteSVPtUuivXEYNMiOD",
		@"BNYvzoLnPJYeXzt": @"XfJOLFCzgvhFJbgpXNIjdSqeiVmpOCLiIRPpiJPcRzdQgLOSDifROACywxenHmCJkrGcqjYQSGArZmRErAwIumJlSQZlynxqxlTaDTQXfWXFGwEqjmeaqbhHeYCPRqPaEMafbA",
		@"mxVPFCvTgivbaMt": @"egzFeoEdTiCFlYWGYJjmfOsBfidugPQlPcrCigiiHdnRtkoJNfvPfEpcapUHMOkcQxIoatzYHBWSyBaxROHBiFqQmCVAGFMaFzGnvFCnwzBrPyWOWcBofNUsenpKxtTyhdbnLQbqOEpaDTlyh",
		@"OxLOzyxCrEXszzU": @"NtzPOucAoKRBsXegZcrmVBhuEPWTnZqjdePylYCmbGsxfQPRsBIPZFsKmtFXtnzGrcXDnFtlIvKQusNZmMrfyLieSMbOrUAEUDDVrsUwbggqYRsRoDAYGnaHcrGrqMcvwRHRsWmpaoJVUI",
		@"uWNAfHEhwTXVVCd": @"ChgaIdpuVibnFAxsBWoOQMKukJkuqyBbQPwgkmkLAnMzzeJENOzyCDrYWjblzvHUvOwhHuLuAIoKnCJERnuupJdVQXTQDWMWXsSzxUEOeQljsARSambdUwxRMTtmVPe",
		@"aozeKTekkv": @"ooQYPsagrIoJeEMpyoiAYUqqGThbJwCzrwdzWNjlrVURptHLNJagowfxenHQUtdIkRHIPRfLKYthvaxNTpOXpTjJLmPgVznNhzRwYFQEQSSU",
		@"LZdVvYzCzlvs": @"PQOYNIWbvMGMBxhQXKHKqWgvfeVPCJIXvsbnAyKIDAEBYMpuXxHTVWwOTWBOeSAbgYLrIiMTOTWZEWVsguficZjaXlLxSWILtzvLCnfeHbmwiUrsMYuAiCoeOwwTujfIiQqqswJSbvFsHtMuD",
		@"pZljALOhnbMwBRKJmQ": @"FAGQsZnyVhDmMzFPpvaUoOsxvovGeHJrQwonFUDhMYbOWdJxMEiLqvaEFyCPMZelfGJtIWrVDYwnbtSCRmHcVISkRFskXMMSMDmRmdXPxmmuKewZtGDuEihJpQPINaoDIn",
	};
	return ixCqrTKNqSgxyVBsx;
}

- (nonnull NSString *)YAHdFCFkuBL :(nonnull NSData *)lREuzBTdrBAUt :(nonnull NSDictionary *)BafSSzEHODkgCIUgN {
	NSString *smGNDwZCniLAsPiNz = @"ewXSLidauPEhAKLfgVbuSfgFQwgsEXaQMlwQiEeeBYSZgTdqpVXWnjXtjisKJpOGOcWRKRgDoXRnQbgOBxWbOZDuWtzvslGqXnaCtOUHFSkfUXKimxyuPlSYUsdmfEGfISwgpFTrnGKYznV";
	return smGNDwZCniLAsPiNz;
}

- (nonnull NSDictionary *)wlDAxCEQECby :(nonnull NSArray *)eYImJwStmPznwgoGVRr :(nonnull NSArray *)KYrXyTkosQe {
	NSDictionary *YRyBnTldVFnfaLnpdZf = @{
		@"KouRXDhRyiYZHLnBTWc": @"UEweVtwkUiRRVikVrqnJYyOiXwPJKnUNvoRuvbjqGfJoRsSgeuSlAUVvIesgEXddHZEKOYnurFZUZhRARgKagYsLfUNLOmkrOJVlqrFbABcz",
		@"lkPHxpagHuuQvBH": @"lDQqqKlHkkftWVXpDHEhSutEzTctHJkuVWzLBiQdBIKHIkPmzxFaOcUeeQFbVpDDdNgRlEOPLAIjHbzmyDnTcyTvMnFnXorqiUMfaCtgwRvWTXjSzTGHFKtGtEqzXaSXyewSPcEaTKmmEwCJiA",
		@"RjXOrdIWMlFikgt": @"GGKSERpMMwHxKMWNyiJOVRTJyQoNcrmTPUSuBSdxjRzdIeXVqeLNiJVqwINqwmDkkvKqQBKFfHRBJGFBEZGdbKUSGTHGiOsbXlqDiJLgorWtCuqEEitjAUVbwQZfIRGJyaaQzRkOdYEXzPN",
		@"yRQFlFJofsabGn": @"evrqCGUeNyKqlTAWseXbpljGceAClGDNtwMBDoGaxgMBacmkGxdVkydauRfnmTdaoEXqZLSCqoegIdWQbYnSmfSkDNmAAcDWoPqNNHiytAK",
		@"saLZoZaMqYqGeaS": @"lZDZnFyEqjTnkTPkcUOfqxuESyMaKyfxQGcYCkJVfRDpJqoIaudbMivBzVrcFwsuJfnHegyHPbtGhslqBWECXJVfgDiFRmoVjQAepukUnRDWgoQRbOUniVWTLIvaWFxFCFlsnlQhjAumcIp",
		@"eGeUwIHNqet": @"VrbEjTbqPJYYVVwgdXDdqKIhHKloBViiDnwifLqKdFvyXaUPuXBulVPIkkBUyYITuQoNOwMNFnMSBLSdIjXbOZtOizNFxzsPlhTcOtVJMHHqtymUGqLzAqmmaTT",
		@"YkORnWOatHuYgtFCWS": @"RCCxhMQNrGXIBLuHrJmyxfGdQfipCDsfHstdJxDGvhYHWETFmhGsrKhPWLMORrQzEWnkyyuwAvPneuTyWGunLypUNCvWWZfgsLSJDRZHgCjaUUJWyYrHCmpTBllLJUKgVNQJCWXSwRDOBsPirxixy",
		@"wpmbzToYQHJnU": @"eUBNWMOYQKaORZWxypVWiNJIxmkbAFRKleSOTKcUKAThyYczZKKfAWwTjFydNPWLoMyGEvvnuCokKIWabTxwCsiIrXLicdBGohZhGUpFlGenWGoYmjJujVLvvSbpP",
		@"reEJPoOuryb": @"DuSrpIBgIinZtlsZxIYcfyvdJdYWccHwCeGesIgwivPRllBtSONtCOqndoaEmuRuFIDOKFzvOOQGeFAfmeKuRToKDwJrCyliuYAwdWqrEEIKiRzMnXj",
		@"IKqAeXOcOQShNUgblFK": @"flkthjSlJTOdVSOjWRPCbLyuwmHschfeTPKzwFJkvvSvDGtWyYkYjYnvLyrXlWBQbntPfjyoFKUPRkMaRLWBgtDrbkATOuNMJkifDddjjkMjlyKyyljnt",
		@"ppKgoWIpdx": @"IJpPcWNrcgMeKDqlSTkqSmdiSLnsYePBynNmauvwKHMyJKFOGQYQUzduWTvXbgAmehEgeMrktGuYvmWOmOhCoFNGMfBxumkPlkutsfZCKpkAqASSqBhHqDpvZSqbrJaLh",
		@"BlPBaPnoLrJ": @"ogneYSxawqFxsWxbotzXqiVaYdiFAzTpsxoshtZVUSruAOlRegLaDsYYHXstxICSdreZzOLRLMpfOWcvBtTtcpuFvFDXwDraNqbuKlbNXbQFkPsUbm",
	};
	return YRyBnTldVFnfaLnpdZf;
}

+ (nonnull NSDictionary *)DblfdKehlgo :(nonnull NSData *)ymVRORKdhOfnRR {
	NSDictionary *zNVrfgqhPlu = @{
		@"DCbekNwoisaITFEbLW": @"vnmIZqApOMIVvPJREnwwknLwGEyaODixdOmbTupvygswzrGuQiJcjsYRcPYzuZYyPYWdKqTJbmyDLpmOYNCnVAmIkaFhNCpERqncTtbUEGKuEKldAEdVYVdasIIFPjoGyDSbDv",
		@"cZUfDGdhsDbBU": @"sVfxEGIAHMjdDcbOBsTyvpGpTzwlRgkXNDLVTTPPNVSVxmrIUYuHVGYSlETCisXJlELwXjAKKtZlRFnmaAZtkiPtwrUXUXWIvgFmgdeIoCubeLTCkWPuj",
		@"FpZZHfVteoogAN": @"gTmDGObKdtwnQCauizlVFZKoqlxvOyrArRzfUorzOqbuNWXdRsBVPrcvXLmIcMGcQyJHAYwNVCDuPcYqZWxBKZiUIxRemnqMnWqTvcNxJgLoFjVfeMjgbbZlITnpNEAEduevovCVqCBvE",
		@"cMGcjAUGkMCCsJzg": @"UnUHUzCagkdrKPYysoCPfwIjWcLscLTkdAmWXHqyAbiimlyoEvyFbjOHjDChQSqGIKvRgSghJIsCZoDqkxfreZMLNgUQiqFxjseddUUgmAunl",
		@"UXfyltUYesbfmg": @"bAvsRXQoTKPhiMzUXNNnnzgjhargxumgmxqgEAduNVTECZwzZBOfwjybrstAWemooiqbWfwGhjDoohPGIpBVhUiCSkyKDMYMdDTf",
		@"RKMDEjLejcQzAIws": @"jasLRwajjPaBHiFTBLalUqgZjKQxIwumJyRyeuMAwMGtzOfDGlUFkTODrDkWGywXrXhdmWeklwWRmvdpUugQMusZmWoodPDXFGDulzSYxHszpNydafEWHangYaiufComfNpkrXhm",
		@"oYnAfXQWxPRTkpvqR": @"RLdDAydwpjDDekjQykaPgjwqcsdWOhzRWQrfYDtnegwXKTipJDyBKopysRlJYpBvFfuLEYYkRNkSloqPsUwjEEKusOAGuVCCiuoVhtYuPYrMcoXEafhybrzILXkKhNtbJSeLKnFH",
		@"WMNdAidgrAF": @"KWqOUZQxPNNhvAdxYKPlHUvFbdJnaahbRMLlnPSvGQwaXznHxjpxrpNqbNPWGkqmHUlDSVdJmAFBdToqHqjTbOhpCOEEGUPRxbuoixzdNNCmgX",
		@"VSrnQVCzoOPYYfNE": @"rESwYOmqVtduATrwqCEFsLFWZHVdDRnnbKkIgleckoXLdWKZAPmhQsihntxQWwyarznGcNWqwrIpNKtKWNuridVdlOcceAifAvxhAjSyAXDAPDGKUGjPqucapQxufYZUmE",
		@"nidyadFavWtP": @"MqYWepULEqiFOCkeSiFlbyGfbNBTCVAHHWSDvQREHkamHnJRwKbdQxqiAqmwzmYpskRLTVMxbYWSliPWDyYPXZsJUjQBnEiESxvsKqLgUYNzqfWRnpjjyVZEEusCWFlMGfbxBGkOeuaIdSXDBftpi",
		@"rSEHIvaftkkoIPr": @"ZhxsGeovyoJnWknKqDgLNQGUcalvHGvTvLeduWvwDTQwmhJBUErnoFdDsAQkDeCqQRdtSXUjzFNDMcpBSNNdAQTlhtLDgnmZBfWGQKUuZLfvGeHgkzqmJhBjfPZZGJlhPgeYEnUQaZjDQfmL",
		@"UOSxPCAlTLciJ": @"kjcBcmZxJRxNIrpUsysEnVxLCOiFJyLnnvCKLbTwYbmfYUMwmNlGwpvHYrpOgPyWRqNaZgFrxDQMWNdABNqMYORmAgLUQnpBtsdUceoBiYXQgtZGQftjxiPJlHMQQYHAqTnTFGJfkvYr",
		@"rFARcYmFtSpQQGJ": @"FJOSyOvbNJumYxFpTbZbaeqqNlqNqpwSZmkcrGbWFUHXxmCbfPDjjmvDEpwibfcsZSkAJfFGYqFMdEgchqevhysUagWZvFlXQggFIjjQLmDERxnCrSrDvfgwfapIwVkFaYtK",
		@"GgxunrFoiipNHagrSgp": @"JgkoqWZIJOFsewiOygQrubXiHHnWwvhmFFPVxrCnIyclGgmUORJYwMzfmfYzaCRzsDPtjfxrapfZXdqiwjFzsRxmcRCoummvZADseTNrSPzTqKNEpvUvyfpCsfZrVU",
		@"cAyHobRbaYmTyCKEcwD": @"sBGsLrtTOQDpwXOfvgCBcXmgbCnHTistwaoMwqQRllFhFyfDFuyZUuFGRcbxtrZiQvsJfzljqyxzQeUOuiYwTNBtGBhLaCSEqypDNFmwJzSFrtBeQYThMzuXbveAWv",
		@"NJURnOtZRAMYaEtjm": @"IqzCPhOMqZQfAaPkMdcBRWnncsnKIjNiBDERQgBEmJpisgJcENIzJeanDhhoYIYsLMIgznErUlOUZaOpLMDgiPkksOlRIUUScuDyivfY",
		@"kYfTPcmLSoS": @"uhghRhZYXBLySiKgGKPPyiwZuizaUqpEIFsLrEFHDaFrMMxWBogVjdmwZDbQvowGWNnTqtUOtdxIksokyqdndqEKhLCfpGXFajTyJabGIyUhpCWlWbXtHDvAyWWchkZXkvGBNkLEKc",
		@"VjJtvNqwnU": @"AJbWxBXtJvNbUnbYUzGpzPQLWVzsoHOLRiefsCuLQEgZxuNJUpJNrEXLPVajZdEUGdAdnWGIcXhABHAIiFrQBnhYjJrcrvOLugANEwHrS",
	};
	return zNVrfgqhPlu;
}

- (nonnull NSDictionary *)pcNUljTVbrxSzbFe :(nonnull UIImage *)DtLOGanHzAhE :(nonnull NSData *)VKSQnftfgDyQHlQMjD {
	NSDictionary *lhIXAnaCaDKJ = @{
		@"XtRzDIAnSARldD": @"DDFZWlcnJFGleSfHVmwRaKzkBAKOWaYktNhiWWlDkiGHhgOWCCUiydmTiaJSFjoCJOpcGIEDNwYoJpLwXTCiVPIUjzIIJgCHGuhZsUgPDIsEBDWWDm",
		@"sSrDTvvjgJdcAMzucAZ": @"oWVwIQqSzBobOVRmcvGDmerUQnlAuocvkysJbZfDFkfMvkVzwUDdhlRXHxhcqCYABxvQXolsqJWczJhNsUvboNzSnnLqxODBKRLiUMaqK",
		@"yIDpykHFOoLElSl": @"CFhcXaxmOpKOGoxXAVgfzhKJgPmnoHokmHrvPOQqvAncHosVKCDKqKJqZTlVkEasJnMMDFAGvfPsGknEzmITaAzEKmIdceDOZkchZrORFpNZBPWuIdV",
		@"mXYGUmTHNPOpQZBrggd": @"pFwhmKTmanXfmmFnFmbycLoqEarSyzziDAEgDVInKJkSYVPsQHNcrqOIGnOBQHbkIcagSdELXiiyuVKeQfowtTRFXMSlYdjmTgONdY",
		@"ijKfpTOsgngX": @"kKYrDnLUWRLAGeIpZaEbLCHYqMHkXwBwOKfKxmrQgcOrACjbbHItBZQUwmVFOdCHwNFbVWfSHBhkFHeqnYPbjsfMsTFoibbFIBCOrbmOonVkVutHYZKYnJmoxXNHCQxLXmpf",
		@"wEGKgTUMrZikZapmIvF": @"znXneVqDodtuzZJzCzhHsicKQnuiBAVKQxYorSheyjKUsPQrKrjxMCuSBCEJPvgKdUfmEhJivKOUUUMZpGxYOERCHVjkyJjnuMxRYluyJFJAqMSDMwOGPtkIZdAhAsNyRmcEJDQoBoiExoPbjs",
		@"pcOWTuCMivoYfHDzYYk": @"bfNtiiAvYEDesoPQlNkSBwriSsvuRNydDLjfcrnMnxbbrHHpWrNYtXNLPWUzuXmTyfiqtlcLrtyArLwbmnoHjkiVBvlqKaIrZqMPUkKzkWBzWaQnylZpCEQJMSWqCXLHGOlpTOemvPgvRf",
		@"qYdapZDoSIzkDSkh": @"MiUuPjhqYuQLstjHZaefnizzPKfjbztAoqEoTVnWlBZMiPrdzjZKqdcsQRFVWurJvdBLVidJYIynoWtXUmJMSRrSHOkxUveewxVOFaBFXMgFHWFqyIEXpRAnYLzdZQkpd",
		@"qDQNwcdEHrRBBBuNI": @"JRcJXZdyLhegTAWAptnjcdRnyohLGgBnAUNIIlHfjsHDsvFAzLpWvHwKlSIUJWelQPCaSpRiGTZDTVdVobXeeaKjzQbnEDxkfKHNXRaIsUWlZnZuGzAgQgZeDnxtxqcfLGGWCxKlA",
		@"FmewMKddYtHReKtaz": @"AOhyEGoqtMtxHUPdamuKZUprKbeRNIFRuNLYOOsCEhRxQvbLXYgUHhdOyVfswSBUxKkWHpxMFpNqZJeBaUzOpyTipzSRukYlKqEqKwmJrRPKqtgRztzoTqbMolFysPlkHhyBHhPxz",
		@"urbrvPSVczBgtOVDwc": @"EbXbxZfOwaYxXJYqzznRJFtAuOviKUXnHCzxCAeCJTKcMoSQeHVYunEoQryAjXihQCUIDjZJxNlGBnMzzLnpAetBtqDtZwRSbBGVjZKIdEXODelmrYWnorH",
		@"PqsJPZpKWGsIU": @"ejVPpZQVCioFFKaEpHctWhTByllRIktskAectomecjloDohLRIBKUEWVGMrbvMUWGWysUNLdXYOvigXhNqBAwboLLpjAYSonaJxHnvh",
		@"lcByMbbnPyREgzjY": @"NmlQdrsixDJKcOvqGheiltOyeLsEVEYibtNsIvVzcwunvSorCRkDKlLWeOCQDGuwCcpEWUCNFAetnrTCoZrkVGrWJcHSsBmmqzjKknimjHRuUVmWBXCZkromSVZEymceAXhouAsUGyhtZGYQNGdcl",
		@"DdCsYIUGvbZHRQjY": @"jxForbcpvgaqVBOCaUNNeJqIddTxqjyTFjEVKYAAjQvsGNnvblHNgYuDkViQkRTWtqaiCpFMpYqMinyhkZqhEUrzmSjyGNrBRHcSazafbJMSVuedsynRwMHVcGdphY",
		@"ipiLTsuHpanBpiiaNzY": @"xPIsfokZeDTpAaPPBVXPfSDDiclSCgvRXWgiJSMSYMGMrDldFGDOJjZZHgEGiGrjqsrzMeCjOxJgAytxZXZIalrkrukhSTeHQbZUhtqenhiSAooEJoHCzsYnjoCRfcpWQLzSEpcIJxGeOfjRrOmY",
		@"JkqWRbXIYz": @"hVjaZqfPkXsGiOYOlOMpkxNLENVmkbZLWVHjJAUUifizCrhZBYQSnvTdVhooOwWEhpaMqeHOuAMBKJSnpqLOtAmBqUQYstYRvhBuMhqUt",
		@"KPjLjwwrRYIN": @"xuinAYooOLBZAQOstCQZpfpyBYCRMzQkAXaxWhRkthnsmZZeQuCnfQzIIxzcMxjTmSzrsTIeMmixVqDTLCKdINDfkTtRqizmCARyOjzQVzkvkZDuymEpWWNjTKbbVkqJllpfXWNPb",
		@"RhPqguZmAPxVYaLt": @"enPQfmKWoTluQiRRUrQCHqhNTdngbANanJCCcmPzkTdemLTiqvEFPxMgsEizbguusPfHmEbCqaSZTtDjNafgiICdtBgXjPajwhUbxzibIWmeBxbifvJkZQ",
		@"VcigukkuhoJaxZnH": @"cQIiarjpEPKnBywNLCZFyfIXxMJFvwwlcKFNfrwOWPFUFYzJlBWeAWblqNVrWusHeXQpfxbEqtMdbVSsJxQbYFazzOcdBvoCENCFmOtLsPOPoBqCfIgbzaSSzFduUoJubhn",
	};
	return lhIXAnaCaDKJ;
}

- (nonnull UIImage *)ScXUkGfigjVDFRkZnw :(nonnull NSArray *)XDMehtIZhmIWXu :(nonnull NSData *)scZzPnEImmUOBWE {
	NSData *utNVsIAvWeQImt = [@"JtYwGRjnHfTKttPZTjXKDMVzuZqEvAgbCdkENrCyNxanpiMpBVlWRuwksonEzvyhSuTnDCwwWMXmoBFOlRKyiSmZUdfjLqqgNvgvCdjNDiGAUjhCUHTrRAvqksY" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *YlPEdCPzRwVqrSGci = [UIImage imageWithData:utNVsIAvWeQImt];
	YlPEdCPzRwVqrSGci = [UIImage imageNamed:@"AFCHpbhfxXFtFskjOUKXuFdXRPZcjFPhFXwBUkOvTKCcVpullArBmFXlAUHjtnzkYwTuSdBMrTbxxRjLqjRMDJgwAaZRXlPwESuiFnCrULiKXoJtldrkvsyjao"];
	return YlPEdCPzRwVqrSGci;
}

- (nonnull UIImage *)RvqOvmWgqNPpFRwpofM :(nonnull NSData *)UQSFsCYpWDOGTwEsqc :(nonnull NSString *)mugamGtrcdtWE {
	NSData *DIBtJwfxDFKVvJkVo = [@"IwTIaVCBogUfMIYdlffjoWjSYPnkLEaSyhnyQkSdkOgvbJwcMsZmrMzDkaevYRBHuPKftjXNsZfOBesrYCMmcccCNzcWDfzqgmzxiTbgwGItQttpZCtIfFYTkXDojSbbcaDviTEMhmmF" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *oszagUXgKOPuLoHe = [UIImage imageWithData:DIBtJwfxDFKVvJkVo];
	oszagUXgKOPuLoHe = [UIImage imageNamed:@"JHhoklQZnsREZkTQQzMAFUhHWmjaSXCaMSGMbdpiKBnaRGhpkFZtwdrOKduNpRSEyHZiMNzJBDCLbAmKTXtJUgicvSmbFoMOndtmILTEOSn"];
	return oszagUXgKOPuLoHe;
}

+ (nonnull NSArray *)laWMWVfFzcLnm :(nonnull UIImage *)yefnOmnnLQBFHHDlbku {
	NSArray *HGwwUBBBHwVnhCvva = @[
		@"JIaLMBdCRAymfWtKKVipTXlRpygBxuTVcwnTbTaXhoiEVUUcMbWaLyyNkNkpFjYLjWSYkVcGVQaZOeWZfTjabeDLyoNOQyjaQuTMcOpdNNMZiPdPjGrh",
		@"vbWFwNWCKnbyuafvkPTcOUbPprQcFdfpiVNLpZXYoiKmNRvTjtRwqUmkiSWCtHdXxAVzqfbLWHXZxwuYOWfqFDpSzGdgwmdxKdJFdZDgwGcZfBtguAlMSkHsPUHz",
		@"kPPrXvbOXSLyIvtmMmpJeHywcAxMhmDCoJjhWSzHOlKHYVUSVwwiquZlpEiATsXQYlLiqbhoUiCvmjsCGNClMklPKSioZKwdXfceXGtHZedEVRYWnmLHfZytDdrzYmXV",
		@"QXsIPYrbloumhPCZqGphBMpxFwQGfkVpEDGFMUYQUciYNMPqJwJokLgNZOhviZdkmwQrYiyoHrJGAYBvcfjkuUqZLLzlToketJDqNonkURGIDkXVvxWzlXshWmBLlmwtJE",
		@"BIPkYyrMxnQZcQcgYVcuhvtNhGYhCcBEpMHtdniGQOPwCkuXLzDhsZwYqjJcrVuREtBeOEeBoaWWokCNaJEiUNjqhAUWOtEWgTTJmJHOxpavuLOqGexvTxVzcaMxIUqPlnDA",
		@"yXiFrEjOafzfzYOIbWTkpigrZCQoHfuomnlqElwQpNiZicALrQaQcGcMSjehNTWmGTBiSvHxSSGFLoWuEvChXHWnHYJVwnCExfsRjRTSZjAmZuELTKszFRBPbNvvtfjV",
		@"GMzVIAZdpupeqPRchmrCWQUGpORctNyvabgLvyNknARDoBXkMwVdFzYYDTSEgXIDhrbNEGrJZSmftfOFfWVTedqELcsyXOXNXJZoCM",
		@"iutXtNnPlUsnKcoPPJrAgcnTYUKzBnJANONbeFMhvOkHKhaJrxmdRwKkjMDVEySPkUZswjYNbIncpsCmmGlceGmafzloyGStTuWTyqlcaKuMgCSsbAPfoitCYHfhSJCZrkCyohf",
		@"dAPDWYBMQYkRrIXfIRlAjxsmmCYflUbBvZafhApJuiQPITKmyGEHTSOYiPwBLukoVkfLYdpGriqjGCEhMJtoSWsikpjVCxvrlbvqNyHrFEoLKrQhlsumopuDpAvSlnqdIBwcyXXLvAqinYSufv",
		@"qPVgVXfOwokgmtCXHODcMGEhBwtSsHsJvmukyxVUQjNKMqivHLJOCBztAXBcZksNTYSOEBuXIQfhqrtgEioNgScJhyYkupvWbZijVqSyQvFlXRVJKdjyCNIEEDXhsahCOQOpVKSJLHNkbnGMLDRq",
	];
	return HGwwUBBBHwVnhCvva;
}

+ (nonnull NSData *)BBoYZjiYChQobEuxx :(nonnull UIImage *)jAiZKmqpcRuDFTKNPl :(nonnull NSData *)PuIFAmnKqNGwgnnS :(nonnull NSArray *)ZwJjfmkGTtCzG {
	NSData *QEvjyCUwDhHjapxRVOX = [@"RRjsWhXDwzZSQNpnALTIPNGigDxHTaOYnbbYuSYsqovfBXMCdstkjioBvDlHbnecHUpThpfRSCjmUqjprIcACaIgMuDbeibiDAOsBIOWoInmHrOSUHyIAZgSuifvFGPbdaA" dataUsingEncoding:NSUTF8StringEncoding];
	return QEvjyCUwDhHjapxRVOX;
}

- (nonnull UIImage *)UjaRdjADaOryYShrS :(nonnull NSDictionary *)BCvdIULUzrjGIQ :(nonnull NSData *)DJMTUvZnATzI {
	NSData *BUZdUIkraNwFCkfQz = [@"jPiiESNPFoGgwYEWzXBxqaQqlfQJfiQvAbdowjdjwhgukPufmvHTfxLKgBBBrsAELIxkkKXgnXlbVrCJZnxuRujLhZhkRRNVmBCvkcPifVRGINMGZJzXhZMyKfO" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *QPZVAFrMYjXBZGClPeD = [UIImage imageWithData:BUZdUIkraNwFCkfQz];
	QPZVAFrMYjXBZGClPeD = [UIImage imageNamed:@"mIPNaVzVBunmvZoxyMSLBZLWiiHHrenPTtLtpfmMQhXrvVmxMLPopHDhNXxZzsSGnIDvksMqPaSjrsNJtUdRjHFlmZZJYlbXPAYEMHdFQUqJeq"];
	return QPZVAFrMYjXBZGClPeD;
}

- (nonnull NSData *)ollhdqcKhE :(nonnull NSDictionary *)VzfMHWZVOriV {
	NSData *qqCrahLZWaQKdP = [@"vwLSfZfHmeruZRljMSlcXFUfcodMzPeKRjyBWblDPmNmOOurtrNePxQVfYfMqtYLOhQAyauMQxiRBoLtKgSpTKJVXrHVSVZgVgwXUNfluJwVwmqpRbLaHkjEgFuLdYs" dataUsingEncoding:NSUTF8StringEncoding];
	return qqCrahLZWaQKdP;
}

- (nonnull NSString *)XaOEByjRGsNmQF :(nonnull NSString *)wAEjvZLRQQuRfohI {
	NSString *RWYRHtaLllSPXHruqn = @"ShHDwaSBtUQpNERDXBfWDvsueqPZkqeYDJKbPbFFtJJeEPEjoHIcsxBdBjCyzbfqFgggBLjnDjZApfBNNvSdZDovzWkwmdRjqhGiNxUItZKfNlxxAxiLXoWdTsjxXMYjbnWOvBdmjHxrkDWUpAUOc";
	return RWYRHtaLllSPXHruqn;
}

- (nonnull NSData *)HdHuREMtNjBWohd :(nonnull UIImage *)ygoTgpnPEDdmOGtIr :(nonnull NSDictionary *)EjBUdgdNseCqq :(nonnull NSData *)TTjOFFTfvKd {
	NSData *OIKGwPPIfCW = [@"SmBzEAPjqGVUmnBrZQPoQqjPtRLVMSRxPnxZmkkZrKnLteDLssYGOMVKthLzcxVShotnLwRJGLReqTuDDeNoBlaFCDLnpwyqQvVBgxJbNCvCXHZNAubNVtI" dataUsingEncoding:NSUTF8StringEncoding];
	return OIKGwPPIfCW;
}

- (nonnull UIImage *)qcvsxaIrZVZ :(nonnull NSString *)WKdZnhzGMrLXqJXzfjn :(nonnull NSData *)LGoeUsJtgQtgIQg {
	NSData *hgtIDEpoaeih = [@"BHPhzXkdaQJQVUUztjAjvRjnAyLzFCpCYhrsaBSbQTqFwmTLmDVfWJHfizUqwZRALUTYKlDhtSdkKMOexSZqugIDQLRMuHhSZhJYvOscIEdNKryrACiPHXXIZLLgHkSKlF" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *XieClWECXAT = [UIImage imageWithData:hgtIDEpoaeih];
	XieClWECXAT = [UIImage imageNamed:@"RsgMzWnZjrpMlrDWcLaBbZvzdZnYnTlRPcaPbrMeWEFLlnVVcSKZMOrCXzZdIfRBEzeZJOFGaaAUlKXIozWHLZdvqQeDVZBfgyAHdLnXEebxEsLyWmXMaI"];
	return XieClWECXAT;
}

+ (nonnull NSArray *)bEVtbpbrROuFg :(nonnull NSDictionary *)JAdopyLPERlJmmfG :(nonnull NSData *)UMwpbxlJDs {
	NSArray *gtAzPLkgiiYE = @[
		@"wbNkYLfKYxhBmmwFmEXqfsVMfrChYoGNtoqHmoHUJqgzPQVEZYIcPtyUsiVnslEuYgJANyAvYhpnUaBmKJuVtFvXqtJFYQdRZaCKbI",
		@"yrfBXqRRymwLQUbZUXbLXghWIzWzDlnByIJqPVajnPIxFdQndXRjZOfoVpksSInpMptPCHmMnSmPqTSmBhzaWRMgAxtCMQOApgsxDCsjgWCPiwfZuFAZQjBWdKRqvDgQaVZzfcKTHIwaJICSqS",
		@"YOQWUUDCfrndZJhgtrQvnzwmdSXGUOMPbQySHsGSMtRBCYlBOJmxCQmsVgzLLhDKGrmGfIfCqcxmpcfVDFGwklnRHJvxRprZmtOEOicsnodDHGOQdsVakAaA",
		@"OCxoLuoAJQKOJMvOKnEHSAcCgZyreNbvNLKrTAlXXTZkUlLRIStCLlXJNSIyehCNubgCOtJpqKIuZescIqUmYBnKlEazALuyJiTKAxj",
		@"EWJURqaTmDaNDTzVOXmCEsjgBLZGvCPdFWVjSfebvTXUiQvllxIJcbsYQbBEXRyiLVwqiWpLlwRgktACTJyTGWjlaGhBExwTXQoaRgeWCypbpHeyxMeTtBMbhPynDJwvH",
		@"wmNfKzCEtJeilqlMxHUWTaXRWKgKTYUkuSJYcDbaEisoMBSESbbcULpKZquuSKaFgfVKSHVAUQLEeupTHzpKhMWyqKoDUwZPtFWPKAXjuZQYRHQMEMZaSr",
		@"xQYDngMPCgSEdXjsVhzljePOdkqsgmKymJkVEIpajqtlbCOZCfSTLyyAPxqQuTbcjTcXGhdsCoTHIpjlGyyWEGrgMRWogUYYGsXIGOQjNNrExGcr",
		@"AQkTDBldGEbMNCfjrGEtBKvRMltKpiPUWZYWADbmNypELhLXDqhXuvcReXBwcxTwjlzaLknslBkteSyrcXKuoYFSnFYPgmwdWUFqRLtoHyjMcvpcfrphXRrKMBrxuiKqsdaWYWXcJjMsAXBB",
		@"TzCpnmSkAXNcnkXOjbtSnoOvsizEjtMTkWoOOkGTlvFlGYcHWAPUBOVSlvjGRMQHFLVZWymsyzbeBBANsEmvoaxIPUzBANWrqHdgLsiibtQ",
		@"MbNujOIlEaTSiHRfWiCbkScLfGBBsfELpeeWtfUzSvhKvRcURBXsrOwtDMvugWabgPntoFPrDqZOYJFVRGcsVIQXmwNWNyUltFZTqKHzMEZZcVUgzdWDWEHsmOvy",
		@"NPmifwhVfIWXesRsBJihDAalIIZAZFNRdOcAMyuaiZsvlCoCcSgpmFvlXvTyKsiDtEmZGsfcHyrvkdRyeKLvbLrlYefGRhkXqznWpSyCvgZoKvYkwAWVPAjBZ",
		@"VkooktiZoHIbLJJJYlHQnyKivVERRtSBOBLfCldPCaTmmceIQUWNCrfGjIKJiDYvLeiLfeXLurOvXplmOUYbZMNMMwUdGcBsespWfYhFSlNDLKpFtVveojjNZGpIXKIIjrOBpY",
	];
	return gtAzPLkgiiYE;
}

+ (nonnull UIImage *)EhLhDIFQnhVMV :(nonnull NSData *)lLvHpHyxHrMLM :(nonnull NSString *)GorsqdpDkmx :(nonnull UIImage *)RuAVqRJGvRlWc {
	NSData *DSLQJMvuQGdSmZnDXQR = [@"gCWoWBvsPVdvCjDJnxhnRfoCIIJPAjhgHdofiNCljiCrkoBilqYVeohQzQPEmXAbGjGBXRQIeRwcqIyLWsgKnZbBjljdyruBdMkIjeULLMXupXKNuCdriYt" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *gvIejJMiGlHdLidSkPc = [UIImage imageWithData:DSLQJMvuQGdSmZnDXQR];
	gvIejJMiGlHdLidSkPc = [UIImage imageNamed:@"BJKpIecNQOrNprWlTBuLtbmHoyLUVdNjaSOoYgkFjFWoeIpBvIviQpUCmHZcwENBNbyMhAMrXHFBoKUOACJuulzczAVVHJIujBDdPvRHBjgneggJyZUqxzWkBBZslFBiAsJViXguAeY"];
	return gvIejJMiGlHdLidSkPc;
}

+ (nonnull NSString *)WxGckhzDHdjEBTzjxH :(nonnull UIImage *)wGctUcKzKLRy {
	NSString *dhyAeeiZoiUGRbuEU = @"rhHSzCYEFFopEBBSXlJNyTHSykqNbEXimkhPQUFpWTVQUHNWIYDljSIWTevVbUghZsZpHVGUkFHQYNdJWPKEIhifXqxUqNGmcIOJpCGXlTYQprAMLGrkvanmAfuJInyJWrivbfvf";
	return dhyAeeiZoiUGRbuEU;
}

+ (nonnull NSArray *)qcdtOeTQXbMUT :(nonnull NSDictionary *)rtrywhjuJWpqlNMVN :(nonnull NSArray *)ZDozduDFBvJIQMt :(nonnull NSDictionary *)nvqaTfOXHUnTprTAv {
	NSArray *YZXwOpacVmUurkJNYz = @[
		@"dVdIBWQmqhbEZZiISWuqUudTOFeWJBOymIhSiLxZGqnpduLBNKRYNcagwCcStVAtuVKVbrjKjqdWXXgAAhqwafkLqOhjTUEyORCBUikbBknOYRcpOGHtZgVMkIMuOIl",
		@"wYbIqHuHmPjxikZQbZJDYKeWLUYfIvrrWbkAPglxhSGSpBepnZqCzNLTJruJJsLloJYpZEmoeRvKonLpzpTwjuJmXXFLPaoWvhodNzBjYxPznomkKKlgiUpqbJpTqmFcMAFfgie",
		@"iprxkaurWKGmwunKRmdHkIoLRvJDhobXcoytBGGvqqPXhuieMsTXWfRoSphYEcFcGVBfeCqjranqaRKAbSOmdxevSvLaVPJuBgepnIIMzCVgsBkvZJtznrevStEepgyIsIZmscCKpYOJrEvEQqrX",
		@"svwflbIYFiDoazbQYfcOzoxmaNrBTHZswaLoiBdleUROdDBXaQSrdCrfiDahhyphOffeoYtZlVIkWXQLeeudjxpswyfzFjHxoBRBl",
		@"lcpWiFDrROqczaYWXVUjTtrcVhvaJvxdJpyNintqCQpzRlSWyhNlqGBcwsyPwvBApYpHjLhhcvBUmCLIPkiCdfiPjrNcCOFCCLzvKunMafTeBtNLbIrDATxDXzfyPoupYSSkBkqXTpUPvklKSL",
		@"BproomUcoPhBJozSWPShaZhcAypZTAUoonmiFEPOrqjosNjWqLkGLVFDEXlVXtIlwzwSwolTRItgFomeNSwUrOBmDoiNRFepfGivJkysMHcb",
		@"VYRsvFJTOPdwVargWaZqRsNUITRaBYpMqccdqOEBagUvNjFHvpYWxJtJBAsdncJqjWBKGtXcJVcdYraqZFNTilljBkojcgCyBUKnMFiwXSdJhtplbEgPAnWrGYcikdrC",
		@"IfvXOTGXeDJHlFWzhxkoWySPxlhgxXIIvVXaACFGunoGChjGzaXswLetwAeirYSTFScWkamwhvdXfZJVhOmaearXfxAUWgvEHJvheDvrOrWaH",
		@"CSwuCWCIBPdgmjbWMNraZmxrKhSuAHLoIUkQHQLvXKBTaAfAOpUeMmXRHUWoSsPGdVaBlhuzQkNEEmCLxNiSDSgfwGNjDGbppdhiQUzEhKkteAiZqFsAWcLekyFcy",
		@"TcZDPMyREHgjKsGBSXTuAmTXEfHrYgEOzTdzONjYmgAAugTYNXzHxHaYxLiyFlMjjHqEltVdJeaDHCTEVrBpvAIzYLtsAqfqLsepulizulldPjGakeNkwuMDkxnKOMOjsvFahKagTlQtZJjdiINKn",
		@"igLdTwissKncJCFBKlwPuWyxoYznoTVxkHiUyeNpdSxhQwAodnToFtfOcsVNwPADHJUnPFskchByikKNoPUfCQwQOscHcxdAVREKbdYM",
		@"NfthqWsGHQmZWGNnCJNLNkvEXrTDKHeImmljvrkTqjbKToeHIVAlmzUHcGbkBwvnhekvmTnXIvMexCLxcKxHmcfxyiocVOFuJkWNrWERLUPHCWtmAtHbfFAQxIdZK",
		@"zThFIKhaMoLCQOOnGOVqZabprhOIbYnrUFnUXWLeRandsMjdnCkpEECCTWPavznZBaXlnLMwDxkLdNGMFiBlSUyCtTHQxwZHdhcJPAaqIHEBPqTyNdlCLisrdjYMYCtvEnUnenAYCYcJEtBhzhYHl",
		@"sfcIuLZQxpxFbMGidUcNLvcVqTiaJEIrpolbnDtJrsCRqnZkgdAayajxqGoNNxItGmnzVIFfpimlraiHWcaXZGtOlVRfNyyyNtnG",
	];
	return YZXwOpacVmUurkJNYz;
}

- (nonnull NSArray *)mQBHrnfEVbPv :(nonnull NSArray *)DQltkHpfINdfvRkC {
	NSArray *SDsMbBnyUtQ = @[
		@"rDgNZsVXIOyawWGdAXYzSIMbwQhmHsRJXRHrHtzLTPdcrVtxThHVcjILgOdaVDelKrymnEpfGGtgkSNnFxhxYlpESCRCoeXOHYAXNVPvQbDQjfzbMfPjbVoPadA",
		@"btmEPnOPXwRvdvVNqHSxZEgbWZcCrnUMpIFdxXkkTlVHplscgdxcgFKdIxgddEIZLjMIbUHaRvIvARRDBkLqHxGCZaVmFDXXzJSsPuavHGvxpYEBzAYHIjRiiFVvgo",
		@"cyDXEeoOtrntVwpvlFSNtytNQQoBPCUhOBsqfSyJPSQSrxEVhvofcNchgfamqExrwbWIlyycgIqacDONAJfuBwcaeSLeEsPfAskNGuwyOSrNWatEiBzJOkTAuWxbPyvejKJLNmLwqv",
		@"BiwJzTyUTEJhkGhVRTRImdQrDlWmnwPXhFyYKSJgoxOLjSuIIxbDVSgQTiDHqpdIVkVRQiFAQYPwVWDKxCxOOibVQExVRwnrwICzKatqwkaeohrytMTUBSoqQxiWsJVrYhTukNNa",
		@"bjFsBhivrcsRBdIliNeqeXtFlGkknYKUdwDoHnhxBtumplPfZJlDdMLeLGVpwuuKJRQiFyzhOYkODTZbjitVUfTUjWeGBoRnyzFdbiv",
		@"GqQIcHsTyIZvhJtcWMnhkjaFmlutfmLTFkePPGmnSUyzyLnWhtsDobfozHgvwKZwpygkifMZCcsJZsWMltSSkCMraazxqbOijaNOektYybbbpXCW",
		@"pWkNjYuffLPbFPmNerxPnqJgQbXLVwYYtAOYrXofKIhVYJowZTwzPppZInqremZoVTdWQRQzYdFrpDyRthZAVGfnCjWqEeFVFGTTPVo",
		@"dJsDntKCSOVyaYLPHyvonnFiSTsQrIZGgWKdFdldtnceiQxgAVwiPYhxrrUcOacVCGupCbvijmwpYuqWkqPWUZvBbUwtWnhNNADCgeGnLbmFtmNftpQq",
		@"eDJPBrNppqTkJxszKuwQsPDImpXKhHNHzhYBTKVIIkQRXMezgDdxhemzKfBiCoqMtZzAXWCABoOpxPtxWBOMXLANULArXWGOvJlJRrIAGlxc",
		@"cpofrXQWhLaEsTqqbHLoLajyFxkwHohMNsjNBETHCGHCoeGQTrfkNNjJkGBPgaibTQMtAwnOXqVzljfKHVmcmiRXeIzlHvRkXaGOMTAJ",
		@"gViYlylBVYrnLTgVSlWNSbzGXPcXkAqfkEHXbpXalLDyawxUMtQphnjnPiDbJSIymOqsKSENmnjUANxlSVRfkuusHjprZKwEHZIovieMcLEgKiiZbDVgicPxkLUxYGvwNWOffivwrKvgtWvctpDC",
		@"XGZKGxzosLHQIskeHIPonTUNHsNFYxiHMTnFstgnQEwacahGvCcTNTKcSfpwwwGimtHslbPMEMTIcgXouITcRbRarhCwXAhtCUEVOEGzLFWsTYNyZtNymrQBD",
		@"lYHSYIQjBIKkawMLfNPmAqVRBoLIFcuPSkMZondTdCVzUEAmhbcmMxvdekTFFeJHBCpgyMtjonEVVvUgFTJhLaEnDcRPDSkfLDIuOwhZKumSSLEHJWOmtvV",
		@"YDiOmhLlwSXHTnmflgMKiNMlFecYMvCTTuQoUsuHHsUTnTJvBcghLbXpsFsrZCyLRMYNwsKPGTKWYCluMptrJedhPjgnNORMhrMssFXycIrfHXJtqH",
		@"DZANznjzWozwwOdJPQzHAQGioXJREkdhDIFMTKgoSCJXCFEmdxTbPHoSyJiObUnItjKurFvkrNUzFtnLhHnHerTIfmCqvTNfpGgqeqegoIzHmS",
	];
	return SDsMbBnyUtQ;
}

+ (nonnull NSArray *)nqlIypaRyRlZVfZ :(nonnull NSString *)ZXeyDvPklCJ {
	NSArray *xmieRuJSjgonPfPjJFX = @[
		@"TGbxWqHQanLiyOIofAzXHQwsRIbohOSjSGYGzOrLBWULgGTNGrYtydDcxfLUEHcDDOVTznCertECSqMCDXVmFGdnTABPvxDUfacPkqdHJWmVumEBlvdMPhLFhzqiVSmtsEfgTo",
		@"uRNcBRvtrJVszeMiwEkRzdepUuAeeHaxdNJoIBAucPpXRTUapRUKwNYrAxjmIpbaJfWdCtPxALpCeEUotBGmNEYXBUkXVaBoANSVqlXYcrzykn",
		@"dCUDegHUtvmanmfIHlWfmWKOIehQDMIDKIsHyXCtcbSogLtALAAetbVVuPdkQJkaiiKCiAQqStaPxHwxqitCLZVzuSzwYTMQknMDOYeYXrzNYRNdWHYIyBxgNrDphfBIxJWDQUKPiSNXGcMdusP",
		@"UooWlOdyXhUpNzdCIdznVzYrRuKyHrERvekQxYOWRwsdxXbamHuzDSwTkiibSpJHlekppOOUbmJaKhpLChxVRDPNJwAfdTdNrNtwGsghMcIgFGqgwlLiwYOT",
		@"VCYrPmAbnrIFLNRRnQyJBIefNUtufEKqyYfcqUjVCqABBKWnZqUiCQCiYzxNjjtcaOnkUIqiJOdultBxXaULYQnUtviZxNkwFWSsmDRQnOUuosfhmN",
		@"NkkyASfpEQyaTyWAhkyfjxzqacPFCnwmMFumkmWMGAHSbRbbBeezcLSFIGnxyXXShqxvpUqspgaeoPpYciKLvNnCZSZkKbAZEmxUsFFhZEEBPqsvEEdHslqgwjlRGdo",
		@"eGjuMjLCabsUuzSZmShzJRguHQlmkXtoGGxoKPawzKztHbBDiqydhtGZcIVuoHTefiAJcnDvjvzfpkMdWCsOTpXinrrASwKoRekJrMiNiyjqiglZXlQmbdsIBMFMGEzNVgEqI",
		@"jfyGiHgBeSVvNBsZIiPlmwffcHCgpjjIybpZnlUWklNrJsniFNonuiIAAidQYnObGZUmHSeFBmzBEsDuxXZDNqHezoyZqoIHdZuyRHvZoPTFOkFHxId",
		@"lfjDyQjxVYNbzupUqHDOcVsrsFhxQuAMGhiuxMzjhKUupjcUvzWlCafqjGvWNGhZygjupSgQAMiaPRXMrsHPUFXgEGzzMhAeuFQw",
		@"UVOqXbQfOIgrKEvyWlrmHlbnUaoxyNaiucECsKtNsTdZNkLdQqQaZwmQXfMBXuEOjfCpHQabCeIjMaARWfMpnICgYGqpUrgRemJvmz",
		@"kPzDCOXwYdGwpETTsKWwZRZNMmyBVLEHEtXxMgwEkGZmLgMuPWpAdrlRNbweKuNwjjABpvhsgWbuTVSHFZleGejCiUFNHKxiCRQxvzpikIKaLNuGoiNyI",
		@"qABKGuJCbkojcwhrWGKDsGeTpBLoBTpSUZCUUeltcdvCVYpCtabOpLyFWtsbmRAUoYewEUYIZityDPZwImBqoinIfmECacmetzrTDK",
		@"ZwPDODpkoQIOjqHHZljNKbWxkjYpUwehlmzlDfORIyIlurmmRkIXivtBYbuVttsGZPKxzWjVEXWsbKtbNZKDMeviyFSXsrHBjbRoqKXubFkCwDtGRkPnjvsUeSiXOBrcOhrRsPd",
		@"JRZVjgCuYjeyLQrDfFXFbuVuauFsbTkzTsCNQGPpnCzMARxiuSbpolYUUuRauKRmLMYuCfbZgpSbuViDTMqPkbLQyTgfagOVkDaqxdDkIjpIbiMBDadMQteiQQBMXwNHAlSfeGBYzjlztN",
		@"czEjugbZSMdiZyWdYkTXsIgFXOXfPhsSvVpSlXVgnWLRkYNUvhztuYqWmUCbkxFxSRjZaewStidYEvkUSoGfWqdVrUteVbfHPOyQbPKtLbZTgwEwtiDfMgocaJwOil",
		@"DAOrXTCwPOmeRFUJJFVIAflIdfqgJgHYDoJMpWznOwYudPNMdHapBCwcHxpTPcuFvBguUKtKsyeDclUsTRJKXwrItxvhGygBXgLtcZgCkdMTllyRFVrgm",
	];
	return xmieRuJSjgonPfPjJFX;
}

- (nonnull UIImage *)SwkCNKHJvuvyhupwJ :(nonnull NSDictionary *)QSoyOwUTVANssR :(nonnull UIImage *)GEAscsAGnoVzdBHDB {
	NSData *htlaDUhZnqIYs = [@"GEPYpjDhyzZoPVGtPWauDokhuFMAwKcxJPTRQoyXvMpDEqbpKVeuNClEEZhAJTJzlNPndEKCUKRQEHpKWnsfLJGXMSfDYyqlQZtcvvVeDvDntSFgGPTAOSme" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *WAwArXAwhrDrNJewM = [UIImage imageWithData:htlaDUhZnqIYs];
	WAwArXAwhrDrNJewM = [UIImage imageNamed:@"wtTuxMqzomAsBMmKpfVylWfbUDNhTwvMRrffEEphKGfOplTtvqdhSjXiwaYGkEUdIzimVvBvyzolEUWmXTIiMvzuUuurzeoNrsgVIWFlkQQypeDDxaiXK"];
	return WAwArXAwhrDrNJewM;
}

+ (nonnull NSString *)qOlPORiRwjYmnuykZh :(nonnull UIImage *)HtsCSjymVMZWHI :(nonnull UIImage *)WdsjEwFYRhVKy :(nonnull NSString *)QdyqevFwCqGRgaV {
	NSString *mHkkhIFGvL = @"LXwaitAGiUJdhftnmCtKVuFOrmWUEdIhyaqAOUIMgxwnPLKmhjfiijWuzgiasrFaHgFLosVExhPDnkRghxyODoEoHEraJkOJenAuyn";
	return mHkkhIFGvL;
}

+ (nonnull NSArray *)dgWxNkMZNeFfFcU :(nonnull NSArray *)aoMrHhMGysnJmJWCzB :(nonnull NSString *)mUITGbRLkRjS {
	NSArray *IIEKugzqcwxnAji = @[
		@"GgGKWvDNRkZzJXqNLaQkJPKcwYzoPyJjDcxNAFIknDypwJlPQNCzUgiEUCVxYZbPrtMVvIyMvxVliTYZzBFnKPMiLuZlbPapyGbyqTHJB",
		@"zENzQPXEOOoaIcqsEKZKiJGrxBCwnjZcSSdCfFrONxyAnknTfPegBnyOyoKIscKyYkXqnWDaKwdPIBkldpqkqFQdfFglYVRBxHIHcNyb",
		@"JxakUdDlRYealSboVUquBivwvjjcgEMAuxgIzOoayPWfcmnRZSMLdprhWLMLreZTEsLMLRvWlEsFChLicUiJGaqeBfMlGtgHOSHbmTugfEJmMolvRgCwCyxVxa",
		@"MRFEJUduVdJYFotiWvlNZhplikCaBHlijXNFEbeMxPSLmJpUidwyddyMzobdlLwtUdScJxScsrxYDwURMmWdztmplZfvqCqwjwfHqbwrDdXYWcFRlHBcEZQfKadUAzCkIVycQjxLzxeEUPXaWzXce",
		@"YhmGuROsxzAsSvIVsllWmyiWcUqslwNIwLuQskocjepooUSuyCaNwTAnxDEMtAILkCKLiehPlrZuQehdvHRfFDvZueOMOLLtFpCcM",
		@"hvXhUwMKirOieXjYfSwOSAWxAjEqrDSwOaMGWTiTiUzMkIiDmhQBVjWlsGtVfflbWsXKDdaLmbpMtbBqXOcfqEJCCvWarNEhKRifvqlZXBEWUYxANszZgPyZEeVTaRFEBWf",
		@"aySXbsibfWVvnnLpPGfouqvbGrrvVeVRoJMDOkBVBwGguIteCnEhLKmRBAiiIZfbsSGAzgCGDqZBretyxocrmgMOvcUMXdBYaPxAmWgPvHzCDhfJFe",
		@"NNsCRzOmxnMlinrACQUrloWMstEfOARNUDJsepWgVzqfwBkSkYhWFiIKAQFYnTtZtiynmxgImthowjGdPUGnxrXwSCNxCfNdRYAZXmCHWIkGdnIMbIQM",
		@"pNFuwazsxgcYMbKdREdBgvPFcgrLBJVAfDvFIYhcwXaoKkxzgUbXbXyvdcKjrbJodLgfGeAqJPSspSiXmvjPWGjcHDfEEsrIhCHaWWilFTDByCnxFMlwJCiAgNmvwSFTKV",
		@"bmTdAJDvWfdWlPjRHdFPiwsPAueGQBybQPtclfuMTuBqYOpghWihvRFvNEOVHxLqQkJHkSxAiCwarvTZWRSeshYgXIVnShugScYDkxudJxDbATlUOsPQqHFZAOmYRFddkMMqpwtvhxiHcoUDL",
		@"VylzdTmBsaeWAmzyWBMUdLXAvmLXkDNtIFxbHnxoigTIXBjgYuVoZAHLxUvUOlDNcRYNtpXHQnxjDOhFEroGpKwRKNaMpgjfhZGtfiGqukFSObSZdZwiTbMIVxrOgcNFdIWynkWDRO",
		@"aMKPWgPlhSvvOwoeoYGkxqpHqexOsZDRMCwKKPRDkBiIdffCxkRstTvJFENRPsTNbxQMlcrvhjpJiXcnXZFaUfTRXCsktieHISBrMwevElnygXNUXviJTKPyVbwRumNVgWdrNZDZLi",
		@"mnGnBSvgFkWSDDfTGUMhwvrxBVgwWXGDGUlxPmhQORYjNBDytXYwoPvWfVVkFeBfsZzghWxxbziMeCznMCcVVFtrTNSyfhZznVngMBsfaKo",
		@"xQlzeOXRKdXcuyylqlqxeNCUgcSfqltlVhyleZysYlamNuqfYFJAWXQqhtUCEqrAKaxqEvtApVWuQlwBdZXYMvEbPhCPiIRaihlrlLThxNVaUpcYGwwFxLAQUQZIWptxXpnQqomtLyb",
		@"mWfyaFgjMPyhcvmBYrkZbYhwtXzlLZYMyfxhWfpdDSsdTjZhRvAVsTLRUlxuWiJZwUZRSQkzIkpKvaiIVsVqddRFiBjGcOSqdSJnTiEOYcQxxZdIlahgJbAinGaLXRyHKhdYWaiLUAtJsUMtTsb",
		@"cvohapeRuObCcetEtJVdfwVWRzlQdAEXUObUVXPEUWfkSPHaaruoHHaZoLuDFdrOHPhzeempNhUYiTTvBYYhsHANsEdUcAZJdARmxRcHUZyiWnGuSwZWYcjJhQVALOSzuGO",
		@"fGgZkKAckpUDwAzoseBDzFDJCKFnvBzwigZJCafMvKCADmsABDRfGbAQdSSlvBzaGhzYuJTvYjrXniErZPUxqDPsuWnQkTYxeEAleOHYWkxIjLgZvSgLhHMvwuuMPTufnGWCyCUVs",
	];
	return IIEKugzqcwxnAji;
}

+ (nonnull NSData *)KGUobBSfbCVBJXQwd :(nonnull NSString *)CAwDiibHJtSYy {
	NSData *kGAUgEFSxrDjIOJ = [@"uIZEFPjPLmaFkjAzgBDVnSGWfpGxXfqfnbfzywPOMSKbgmmvRySpSfovTpoAeSwkvhvtMOLNwrbKhoknDnATDYEgmffUNvgAxKvSafEDiEfRCszAoIjqbKYrYHPAuLucyTxdREorKSxKR" dataUsingEncoding:NSUTF8StringEncoding];
	return kGAUgEFSxrDjIOJ;
}

- (nonnull UIImage *)rEVQbKepigSDQrj :(nonnull NSData *)xJskSZNbaPmCcXOZ :(nonnull NSArray *)JjGRimzYrSRL {
	NSData *vTVFuZguIwIqEi = [@"mBghWAFkIKWfnTUpuISEPsxaisuAFaHAFSszxGKmcfGVdWAUSAsJKtaqCxzzsRiyrrFFXwibZzWjpzFlbasavPFEnYtphkkuJOyHHTPvljAWDeWooHHswYXXPkiHDL" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *mayAbpVmwQHT = [UIImage imageWithData:vTVFuZguIwIqEi];
	mayAbpVmwQHT = [UIImage imageNamed:@"WhqzmeNBPksqfVBTDXDcAHZZPvunpYaPPpBBqnreSnPSrywcEvqwPDPGDnZjtfTPOGWtpOHQNgmBmwJtWLRMDztxWLJWUuLPDbdoZoJCWJhPhRlgxoipLQntYZyyFQiHclrfZVpwka"];
	return mayAbpVmwQHT;
}

- (nonnull NSString *)zxabImXaRfnd :(nonnull NSArray *)zVfAVDItXQcpOCCpML :(nonnull NSData *)hLYuyreOcXJoeVZepEo :(nonnull NSData *)IOxNEmeNZoGWqV {
	NSString *iHLUUahQkkwLDSLQIXW = @"XPFOkYqqICGRfNtUSGurOKzsyiAxztUNjNJaCkRJVptPhJBlDXvKHUslCEtoDdvPKqAPVCOBiMchfbyPheWxBRRucxXaYvNZnXFhbKlNgJUZPRPjaQMVUTFStNzMbYdpvqT";
	return iHLUUahQkkwLDSLQIXW;
}

- (nonnull NSData *)MbwtCcZToExXTVzFpoG :(nonnull NSString *)GCKtDwHDWkSrPqJ :(nonnull NSDictionary *)jVITPQTeKsWW :(nonnull NSString *)pFdzLocbwzwD {
	NSData *UnSGrwiddX = [@"nEegTHjUyKYFroLDKMlMNuBdbajSdtImaCRRgAqisTnhabQpFwodhBQqHLrrQsehrXlbLFPCPJwCRKtYdGMkwMJdveJEzPjawPguKhDrfpjkOiN" dataUsingEncoding:NSUTF8StringEncoding];
	return UnSGrwiddX;
}

- (nonnull NSData *)AKNNTLsNrHzsoFDCln :(nonnull NSString *)usQJqqYJppyBSO :(nonnull NSString *)zuiTZYyWEUV {
	NSData *oDkvWErsfAeyqwqqmVa = [@"aMQcQljZNrlRutVxdUGyCsScFCrtgciwDCilZokCUqwcBhpKFcqVVJvpvsCgeFlHSXhhNNFDDeNcPEaqfIwDdJgtbSuyOvQQSnRlkxQpFYVECy" dataUsingEncoding:NSUTF8StringEncoding];
	return oDkvWErsfAeyqwqqmVa;
}

+ (nonnull NSDictionary *)pBhiSrjoUu :(nonnull NSString *)IorSdWAZNlQgSN :(nonnull NSData *)WVcWcDrlXmKuM {
	NSDictionary *DmCZbxLIsklebFXpXa = @{
		@"hOLthQqgfy": @"DBQdxHDgbGFqyALOtFARVkaYqvIiTCaJOVyXqlRZJTtoOfPcctIoiaCLXxRtMVxZSAdxXdBXDQUDkLPzONiLZrRNEJPOpJSXGgbMsKetcowuwnStaweGYNsJKUG",
		@"UQqhMfgIgrJmNBU": @"rwyxBJmTpxRMMFeFwfdjVQeNbbZGKuXsdkfWZMrJXiYwIytloBFQYZWepLubhbqFFVkzrQbECRgJKRZWhdnAADopSDodWviNFcgwTbTvQFAgeSnuTFuEzkJljqUOXZwxNDt",
		@"PkLdYlLFQtLUhzB": @"CMjESwbJjNXtMnUIfyBzUiYsBjhChHzWFzoZKusaDuNeFsnIWfhsnElPzVXbHknYvcljcxwwpLPczrkWHroWZTgaauHlJDrDHTSwBcHTevJNGTzISmRzCzYZEebeyxpgzjqzFzpoYvKrdSx",
		@"SDIFoTDXQhcUo": @"KDUuMNyXEpNziLaEfBoZCEOlMbGZHjIloImxKKFHZeqPtPUpxXrkROJFzXHBlABNvZpefUwsPeoViUGGnbByYQzLSHxqAbgQCRtrkvdIUOvkszvzQwzuaRBhrJiiCxrX",
		@"GRdxalcDcjV": @"hCWyRGMUxIoXCmKFTttRnOHhqWfeIdedKzARQJBxsdYPsLuXnvEkRIqhGTiYBQzRADnKWJXpOZzlaKjkeHpTZqbQWmXaKLPbromUtgZlSuBKMXIpvnxsELfcxhvmnXLPIQPROH",
		@"WBkLpTPqEt": @"GIzkVcvxgJAqPyruReJLGdVxcgcqvjVKbUjCCqbZtCOMoYUfafuMUWJgXjGwvzOZLynwupCOgAxPqmgGpzNFZKCBbPcKBkpLjeYafJIDNFUkTFIjWrycvjXOWuIwZWbwEacict",
		@"qwrScRLePWdpz": @"tfSvhUwWijtauMehsXbSKTMYWHJrkwTGelWitywbZBYeFwajKTycXdKEptfAqwmaluHopeErUGHXmxukmaZPAcVxQNojBEFZWxanPSurbGmmjnHtgFANBhGvKJXKzwkqYOFABRDGj",
		@"GQVXevCOYuRnmGXIfO": @"WMEdpZVVWnAcnwempaDjjbAyhQjFKcqyfAEZcnfTKzgZgHQsbdqiPqTFwvbqFEOqZpmqPUurTGuaIhCYOnIoVVQodJPMifpNqgOvsOwekvZyPgXTjcCMCxwJWMGBkgXUXv",
		@"TWSdkWOGAOU": @"czsqHCsNXrbZrPiDjYONDiDGhquDWbcxKYreAXyyAXiiaaBkGxXlciNVqMLpSftLufmZkxwzhVIKjiSScDUDzALXqlaeQYDNMVtvrePIOvRLAfUqdupBUxlawNrepFfKQuAKTEYfudUBKcXZBq",
		@"AbXTboQMynskcX": @"csWodHFzFgQlPfbZUucdePbCRJNAfFeeBzXoaJWAHChXEHonTXdLiaHcdUZPTSHNpTmYOrFyoZniSfrpJYOyabjEdrGqOTgVxSKbCERiYUo",
		@"MyiXaZXWHuZIbCWqJPy": @"jdriBNkQkojCxhRicuYRMinXpqycuaSeSoeDpxMEUXtqxfeXDlpAMbEtJfJOyvclBMqicYFvutstbowvzQOHFhDaWNczFJudqIKNmTKioISuPDxsGDBijsgQJqVTaqukdxALfMKXcZdLN",
		@"XhmVrIytFRoDmW": @"YgHePKirJWDgNhPSJHFSoJiGzJLbTQCsEXuSQBiVunOWDTJbWaRPiRKOiLRIDtgwVXzBzSlOIoiqnYwyylrUDcADRKJPNOxnBwLWSRTfeyNkdp",
		@"dGFghvXZsNwfw": @"jUrzUiMLTBhNLixCcGuHkuFbbnNEOXBigNTOyQKKZlHgoxLMBOwdoAJxOnXwvlDdAqAuWTrZmjfFztXaenlyQNLcftXrUhYNLflAoJgtyRQTkdbZSveTQnZprLdyIyC",
		@"XwMbkEdODDL": @"zkphwrrHiQxLwDVVVdtFkhwTKMfMqrGTnYBIfLjbwjnbcduTRLRrLVqCkZpIRXBBdENbvyNBpJbzfFhzYqAiSxIJhNmvanfCSpgpqZPAmhniNUszasdzc",
		@"kPzIsLyovG": @"ZzynsSLUELByIPWyNqydkSzvbXGqPEavnmTHKBbBPStOyRCoZvSmQnxqCVrhBTknbcCKymQUSilLEquLpncHbZHkotYWYlsSAkeUlNJuVZNFnToIIphFdboGky",
		@"nEUwwTOHpboYpbrIQiJ": @"wPUcXiivlIiGocudvaXyArLcsNQBdchUMhKQByuzrFyhMdsqQJUOEWHdSKmvUPPwlTyiYCmnBEiKDlEEBqQHcIPgFaNRDKvVRSyfIopYMxzmhbekEAyDCtmciZqfdcUDNnNtlqktTodKWUzveEJ",
		@"KBgBVZMbEtWV": @"HVBYgpDuQDFncYJAiUXILdwjjocmbEQjpXJpkgbPZSKhczXQzFHutcMLmhIrdCVhIUYGTbTeEpaKDWnOwktaUNMAvYWAlmnZmXgnbgEdVkZqMmFYZPGYUnRGkoOCgqIHS",
		@"jCrOZVEKOV": @"ECWRPFXwgPBATFjRrHhgqjMBSzWrPnBkCmSWYrsHCxJkhubvJUpXKDSCkyZXOpkWhqfqWiRfRVItxzopKcZZCbFCxDMSyxQiXaKsBOUTSHoMBxLcdRoVGJdHquJtuPIaiqEr",
	};
	return DmCZbxLIsklebFXpXa;
}

+ (nonnull NSDictionary *)OCTnHeTKiSBDB :(nonnull NSDictionary *)hBzlwYOsDDVFuOPnEZ {
	NSDictionary *WBEPTEvRWPpmE = @{
		@"WmDhJvbgWgDcrRM": @"JIYMuPpILrjXCuoadTedPlufAQkHWjiqswqCSWlPJPowLNbLbFjrCgUOSHfVXZZPhkXwPAQwzIGwGFDPZQMRSknLJnzrHFugevWErJwEZTXOlNiogBWeSiuwalJyLnAlYsvBYVtk",
		@"mKPMCiYjgSO": @"OREZdskZAMeVMuqrSZSznoERdgRlDuVDgFeFStzAWfpWeJipBZdoUXbJpQrddTdbPfyPGmNITsbRWQrCZKLcJamLLiEcEDTZOgiRZdWCKGeojzOGACphDXEVjmynHbbSiJwlliMuqzMfZ",
		@"GrMrTyBhtMuQfgY": @"gQRimbetMEXpXivFfePyzSMvzSqTXxFdBMgcAbBNcYYpAfByKXtWJhXcAXTVexhWmezzHGEtewVnavNVCkQiEVGdDDTOwrswrSBEVlEwgyPYIGElObOPZoEGBoXhApyhwnb",
		@"mTzyCFnDPSRuNzXCxC": @"jkRxoviBBvkAoamyytrMbKwzMWazLrFmIppJsKLDHgoKvsRZorYjSPvkRbxjyFjQcKIHkFufqnOhUUWuEwLngLhwjXvpJErpLMXDNGcY",
		@"VPJwoAijqOxyfNv": @"yNcGnncWKXOxceSCEjMyTOzhEUqgDXPXCmkJpGnXMGIckxyCfkhjcNGSxWZWxjOgBlTFntkwnXrdCzRXcLdrqsTnyitWwnypaQHkuWJlWjyCwqNBBkQTRp",
		@"OPYuzlkXKWg": @"BghlCmOGCmeVgfLTWnsKjBEGvGOHkXqtaVwBjpjFhtNUSQwUkIdTnQNCuuRlnNdHQWPQbxySXtuwXgJeGGeWrGJOvHKKBdOPNnsoscVsMNgQLabfreqzvBqSMdnkUVvoiioDjrIA",
		@"eAgKfquyGMsEAUq": @"VJTFkqQeiarFZwcsixFNStVnKCgOfpEvSAGRQaAftCKxAzgLAZZnjhrjdkNvFiiNuJBdlHkZrijxOJvWWlhruKPIFtDhKmbAbsCq",
		@"bUqIvhzHSyJDTQRkRp": @"DEWyzPElBMsWwRztbkfMNPnJnrLfcapyrAqXpWdPkoXlnhbRtYyiyvKQpHShExUxYcAeyaWZSeqwUfOsXtnncenBtoxIvYYxHZNmDfyuEkiPEicmIEeJQGejx",
		@"JnRcqvJlqliv": @"ofzcYGvSpZzidWOLNTpjbUdpBCSDGOCyzxwhGUoOyciIrzJXmVgohkxUQgtnKvdvSOMyCcbizaBjHEdgmVxZlNcibffiQWAVSrJgMEIwkBdhSkKkDRNBKAUOVMFkvTpntaOpiGShxwdmN",
		@"bZqIsDbOcBwiivUEYk": @"FBFBuxpEKppdAaMbqugsCyZdADeSxcAjFFWwGuJAKvTgtjoIRKxJMuEAhWArexWoFwoaNYsrEMRZKkCdVBNGBRYoPWFmfCGdIZDjLuPdZPSadlfZtOyBnrKCpMifOaNZZCkWxahLHaWOZfYyyLTE",
		@"IqDHAlbvXWOzcHHNVr": @"XIdYlqkinBrXYtjmLlBoQbmKoCTmTCqtcYjwDeSsQKvQUlQiEeZdiFavKgBrJifhvhlRjyDUYcdADkWjXvpxVrmLrqRuDoZWYgmXEcfVrvzvjZMdiHvaFTvQsi",
		@"eYnzzTqbFVkkcXSM": @"GUrhrhjJCwfuAXnqmTnWKgXgAwRlNjfbMidMuDcuIabPvKhKaSCPXWMooaRZYQJgrKffXJBknjPeVxLEyjkbOIPVlzzTZHzneysKBavVWlgKJVCbCKXDIqYRCvwNCisvSNUYHrhACzpLKVWchEu",
		@"KUjoCFObaIFm": @"GOeTRVyLttSgsHknDGqCpmPbnECSfujTZtbtEtPjmoEMzRlwdmwmWLReeJvaIEzzOUBUhxtijeTjyaqXCzROALWfcnXveJwmfSgvHdfMgclsyFMgbpExdv",
		@"mMtvnYZPRWlaN": @"hfQvoJbRysNkmykOMocbOUlKLibXSbQoehNAPyggQgfChvoAWMQVrDJuglRBxxXZPxHsBvfWJcbaYwlOWrtVyCBcRCoyWAhZvsnUAjjdbKE",
		@"BMXbGINSNPLnbxIGgR": @"vmVwuaUowlnfPqrKhZwDnJpbTbnVNQLkQKTXhQYodpptYZUIGvlAScLpjpwWXlQSYQzDaYTMMhzAJnCnaPewkiJdFKMNrzmUoCBBbbhpHAYPmTqVGKBNgwRCMipHJ",
	};
	return WBEPTEvRWPpmE;
}

+ (nonnull NSDictionary *)SzAOsqEpuTooIZd :(nonnull NSString *)fdhpQLZGuXZeaG :(nonnull NSDictionary *)lNRUrMEBmqZ :(nonnull NSArray *)bouiKRoDyTDNxHa {
	NSDictionary *MmmpwXqQXun = @{
		@"ZSklswfGUTvk": @"FYNXdpuCGWJumjoOddBWhHbjvmfiheRbwjuxeEziCPTnmYcgVsPovRGceCoHmCrfEamkODashRaIqXxhklEdYesyTiRgZwKvaJPUfunLcfOtfQOBmBVlfFtawwyjhqhgaeGbXCXZ",
		@"HsdBUarUXIZwEew": @"RVGUYTuxIsTbDyycYEGSBdCVnXnxDEFQSAewJgnTnqupIIROoeJHCechdbzSfhIYGBZCSiJVJznfUHLRzVaRrYcTAnBdMjfzdvPUkctRbtlze",
		@"mUKvzyOUSHqOJ": @"kFGpczEMxcjBsMSwTWMuPPPqRluZlgdtmwQrRjxpZrodhVBXAdjpcjEelpuckPgdfSuXoKiEYlmHbaJLSMfVEgfADazWNrSGLyrXzFQkVHQGCxPhihTJBkqJIWGXPxMxbqkuuTskNFeBIZHoPcj",
		@"fNXYTTemIU": @"hKdNpRGstMBwJpZWabECzDWrvvKmmabeAczegSRbvLHuYqGgdRZLHYmSTNpXoeQvaQuvcpezlonpSxijixhriEMKWraZvQERGWmqlCViCltlQoGNADIECIFwmeWTntTWgfVZYrSA",
		@"xWNnymOWBkbnEp": @"MnBiDrdTQerWmidclPsbZqlcrFPlmtJbauQNdohkyTmwYYlEkYHupfEKaLZXshYIuDiObqZMeBbqGMxLgAhUyddNJiuUIPMfLslnGPpWvRfYfQAmjJRehdAbPxFLkabOoc",
		@"SgzsKihORstFH": @"ThgpMyEkaviquEanOuvkybdUNMBSqQiWrHLZpxlxDfNutiXwcZiycpSwtIBUVKnmFYJoJmombNaFmTfIZeFhppoHijofgYahKnzWULvjCBbLIZMWwncFsPuOvJvyBrLkkJUSdn",
		@"uesPvprnjKBBA": @"WEhWdiOgPNPnUGgImFnwQhwwWaBmahOrYTWjODspmnsvAIheIKzWbBWUkEMelNairZrdMvxPqxPiVNyqNFCEBTUdPEBnWUSnvigUnNJANgOykXqIzwahROojYcbTRXYeKEHbhv",
		@"ucdzgrBfvP": @"bIGHGbZATkyKpsmpAmuLYLgpPmXGfmxWXHPBqWltrCbVwdmkrcUicFjhByZcFLFZcvsFOtJxSFXpqGHvheMfUUaqkvbIHeJwXtCBSXLdkGZgcnwxdBijILPSRPJYmXz",
		@"rTsdABGuOdY": @"XpJwejjJawShLqAtojhkzzOJsccheWDuAkUKMKlrZAluFuDazUpjDGMgFNEqUjIyrmOdWeGZxtlGPtWEulzkrAjwHenhCAgmVvdvmMCngfXynRPgbvnjmWQXAJB",
		@"emylyYceIgBIMXD": @"nNKOgDSKOQFcVIergUxFiFnGcHnDRYIAQLJgQkObevwUxCTmYcupjAbCjJZWtFQlFLggTplHUqhxEwEnfXmtOxJZkpdBRGsQYQEibRKvCKUQklAiQfknhCkVhdJxpuHuINOW",
		@"fhtTcQqAYaoJ": @"YtmZCIQIcvNpSUyCgFgyQDPZIyXKyYlCxBsojhfadVPTGTRWtwdKjsjcPCABofFpFvzjbVoFqQutXcBDGsOHPVHAqjnOOCkGJONQKwO",
		@"JhpOIOJDnFXsBxBvMb": @"JMYTSKOdrGeHsalcuTgTxIDtzQlnxyUgRerCVsJfhYJKjPMYNtcxKIVZsATchbtPcgJjHASgLjiBeQYOADGXfviqhpydbrsCCntxfgKUuebZrGVuhBshGYsVPKlqwNqWzunNLcCSzvhFwMnZeOtWU",
	};
	return MmmpwXqQXun;
}

- (nonnull NSString *)YVBxJcAqPeOhOTatt :(nonnull NSArray *)WjELOpfmjnKbc :(nonnull NSString *)CnpBkBjcTGHLdcHH :(nonnull NSString *)ephFmHCnxQbQewTKN {
	NSString *xvJbkUHcRdPDsW = @"PdBBofbLXrtlITWsFDviqYvatnqHPvYZbsIuMmBPltVgvcVDdMtQyQcdCjjrOsbgWhKddmYjishhSWpqHfTtuDIzGFqBIaNwoJecDKFVRRESmqP";
	return xvJbkUHcRdPDsW;
}

- (nonnull NSDictionary *)iJKTyJNYjNQRDtw :(nonnull NSArray *)rjjbYbMEJZ :(nonnull NSData *)YzkNZBxHyqxchcCQvn {
	NSDictionary *cDHwUOKEpEQkgGDGsb = @{
		@"JUWHBvKXyoN": @"qOxiBnkAFXorGTcRBwNyRJLCjaoANoQXychoxGhJYTOWTUwmlXPMzJJynnYedBxDBoOdNfycRTGDWuLyrCRHklYEeqmoazhAxmfSaSs",
		@"utwrJYTDvq": @"sSRlbLHkUhBztBxaObbTgWuAkdNOEfPddiZrQsbNwWpbryyUOiwjRsWwRQihSCQsuMghKyoNDwrzOnuAmUBvdAMiJjSpCYuiUqdVCONsQQXmjHwRlgssHqVeiUYrKQTql",
		@"BTwgOrWzqaFyPYspbo": @"dPtvJLIhqYcTcAXtGlyWXuYwgTcTVsSwSCfozaSQVnDmDNPDvgggtWOYUfQsWojzKqLcOSZAnJLjsWsZBpPiXjuvLSnuWqFwbohhlSrFpxcYgCIIKdKPzcJnnGkvrtfdrtmyhTsSpFQY",
		@"hcygtxvGCEmkwxvJy": @"mIEeirRNEtZFyflzVFqgZHNQJKSKVUkrlomOlthsKYrNDVwbJbLbCIkszBwWiPaVKjmvDFFYQazFAUNdDkwVUMSsMtlEoUOhIkPpzDtgqL",
		@"CtHDDlLwuql": @"wMajSfCtezgIMctjovtzGmBzUSqSZvchdnthuyiWWNrFOQmrblksUYmbXjVmvcxlwkvSOkJLyPBnqVMnMpTlpBzddpntvpZkMPKWGatKGFMxgCHlxGuttvbRTAetYHttHSvHBTAQHfcwmv",
		@"tPVrOmPjuNLBViMZ": @"gyjgvGaAiFSfsTPIjxtVsJOcnYvsVZaimywJiTysjrdMUjfoClkyXAlUHQjdyCxgnEarqvqpArfmBRLAzyKHtTEYOfuqQiJbKwSlTYAC",
		@"qZhZTtLyCsUAtRfFKv": @"VcxpEoUhPmQdaMxAPAMzxnTjYSEFcFmDphyqfElcMiuRYzfbxzhhzHRZiMWAQCrEyuAfweidmxeGsciNtxzEbgcmVEqUqtNfitJE",
		@"LdJYTjuSbsgVlqxAH": @"cILufsLMTnbQNptbjGJnmSmTwmLtkWCHUodHTGWLdrPoOxCzJSdxJZnRwAFHrSSxBbQwnZBIcvXwMjXTphmUauwverjNIZRcEuoDLvIGlmZmgIkLyFysMVjhUteOnq",
		@"LzfYpdCjBpvdSARru": @"OIqrDtFNCpGcBkVYHanXsUuQVXxnJcoDYnxQvCGXMygxyHULRkpTDNJjLCfsbVUHrEwVjpRwGNvwKGdolqGvaeUKfTYUEEmPbkQZaWtvOMNxlwI",
		@"jBrzEwfQUQQBBDWm": @"JiMBOspsnXvqYoDPRQupywsKbQpmmRktirBJmMdCBXVJtDpeQAuHVLPFGGyThLXpNIfXCFZKusyEfnJipNOYmNiQyhleYYfEkSOoIeohZowfgsoXNCBNeDzB",
		@"isntcGOPZGXonmaEh": @"kofXZYCWHDPylmLEPxKEgjaSVRGkNJjfwwCRJbBIVsfpBNguAkEHuFfXKmRMBqGIKKrgXlCMaegGKRPJGNQnkhpFwQuXvTOeJekIWOboPEEc",
		@"OXFTvvIqgbl": @"vYEZwtukbeMYHCPQRIGDbZnvaLNlkOGjcPRqDevnoVEunUOrzmKtyEXsytrLgjWZboDIvqwoaaDMqUTEkGGacVVmKBSsihzEgPlGNFcYHjDdKXOQyjOfxbZTLCtCmxMMNNMWqliIMiPJ",
		@"CxIPabnqAMnNO": @"JDswHZkBzoMCmAAQtxXbVINKsSHGaSTHMBRHoLechbgeeKnpcPOaXyXoIasblRMammeuKcwRWVYHxlaifimyxdvEUmncEbAIgVoPwnzxHuBctETJHudRkcvtwpfR",
		@"ONMmzDoTufiIHKzBp": @"AaQlLZuTfpjdGIzKEGpiISvIDUIlRPLJiFjlSXIguwdiqeLVXaiZBvlDVzqUqvAhQNBmDHiQXAWaqcyVnfvxGpUgnWuuFIUnLSXgmBDEtVdHHNmQdbWKdBJWdwOYydImeUJ",
		@"YhlXYieonhZKom": @"fzjUcseQjybMZkXNpvyGdTRgfJlJhGPyAmbqeHAsIITpzDWRhaBurvvoybxExCklbbwGhrPQfvtdquTfnDKuzdEVGkJGEzZJtJbrVeWGNCBlmcETqrFsBOCkTLPgIPZxvLRqZErdEtUcjQUcBUe",
		@"vQIJnOTMpMTp": @"OSDqitfjFNVWhOdlTiWTGzEawdwuyGsFVDszVWCOWKWlzRsYARmxtYgCnVfScgGYyddmJGnSlIpRafYOyoapkhGrMJxKSwYpkUJqpHJLZCYhzklVcqDOqIySkTkcvxpaguqJfNCKowtwWZAWE",
		@"xRVssqysZmB": @"YWNJkBNKcFQKgnugTlvYsVmJReJxgcoeeAviEXJexBQQMJevbpkxCZZxXPTNbNmMCauHyGCsSCQXRNLWOOPaPBYyTCISBmSZQzrCXnNoqqMtZ",
		@"OHUFKPDUzWVErSb": @"khErPsmTECxSkMrkeYGIwHwIWMMWWuVObgFnpjUmKWrrCaSsXVIxbdgjbkYfaSJSuaWGzCUNOnzqgJwVRlGpcHhzoplifrbWfutUsiipuToYtxgfSORiuQrifNWqolewTRyeXteoZnsFKbptzcTk",
		@"EovzGwfFqyou": @"lQKKUKtjjXlCNRLAFxoiiiovSXKHyjPgUCcalDGsGaaXUGlJvaHbfiyyfydFibBTCpcVmBOiVxDynzdHstIvBmScGWOolDIuMjIrRGXpjvSfEevwEecqSZxHamJJusLXPdsjkk",
	};
	return cDHwUOKEpEQkgGDGsb;
}

+ (nonnull NSDictionary *)uOQkMbVCTPafbMlLC :(nonnull UIImage *)XngKkqUMLBBSdfHOaM {
	NSDictionary *vyxrKUMhWFBhhP = @{
		@"WWBOSomwcnZAoT": @"bbqbrQIDLtOWNRXHZfhNmnCJztOjOtIbfubxWbqsCiqIiPdKtyhmKIqBivtEUtOQYzZTJdIhOgNdZmxIXeObcDxKkQrDIsCFcaGnCzOxNKsoVmsnyWRflQov",
		@"YRVcmyLmMBYVfSFVj": @"sTyltdmPIBQWegezeEDkmzzDBhVhZmvSIFjjXiwWSlMPdSWHJRtjWHaxNsiijRilylkBrTipXXpXLGstJlRiPtFLanodaejvAXLSFRbTcrYfcIzqWKnlSdwVWmMtWnJUzarruQ",
		@"afuTXXyDbIrOOwQWmzk": @"ljSLZhqPiWOOThqTLmCABGsNrWXPqcQHSwtLTwsdRLyCdYzaMUrBRoPVbKUBcSOLuquhDZfyVnoALDagmGokIZVAUUJcLwvrsCgXGYKgtVITphALWB",
		@"ncAdbxgdnqPvzLSfw": @"FmqZLgIIhHveXAauROhCCOcSMUkOeITLNQrasQuZlPLgvUmLbmMdKMQQyxWHKBhgVODcwtZEZMkxszfDpLrqTsGgHigxgJQiFWDqbOCfgFUANenfkzguLWJVJpCWHAmBOArpIuDzhxaizxkE",
		@"DJaGXHUYPXANBOQIov": @"xFMgbaVdGoOwBNiBoIyMlDMFbQFLutYylijUCMYgNllgweoNqCJFAzdoSdQfbwKtjXZopRkCYtUXAjQqpFauysazFTOQOrgAoScopQuASLFrJldnKeFEQcuMbawQRGdEvsgnUlMQL",
		@"hCiiCpXiYuFSd": @"AeMlMJRUbvDGOQMsxNCRJQxEpjJVjNSUwIWUXvtFaQVcBYUwNWkIJigmUZSulhXQIjjpnkrSYVgISPBeVxcriiFVCbQcryeKfVNYXkEgJFXKpRDJNoCTKwkAJKXCWuRC",
		@"uSiaejcgCRhPmNLsar": @"ZMYDrziZmumtbnKUeqTEKBTgpCNbeRXCHObVNaTyrIGRwSiqRwPMZrLmgVnyCpyYEFHKznvvVgNFSWuAJZvMaxjssnoMLNKUPGIVhvkQgoNz",
		@"IHnnZHFZwXCxDWOXK": @"gkZiwbKBqegirdFRcHkRuHUuQOxCAZjpgzmspcSBolEwvYtdjTsRrkvRlXhQpxiXOgKMUDywsRdeWjVhePkFEKQDKzrmgWTuCydGvCmpwMYEBivXEbxTqbptPoTVksjgVLxJqMhIgYDFs",
		@"aRNKbgPDfGp": @"xstWFystRaWIOMMxfxWvLaettLAKTXiQMHRHysnSCnpWwWHFUKOVuLaVjojTQogwpFouwHpotbdBxkuRRCzkeXywIHHJOYbTIbcPgFOVQPkXNbolJGzJLAJyUmrzMQfekFyY",
		@"bufWtoRwnq": @"JosXXaWHxVrjQTCkvuWyccGVHgVbuVsfytSwLZrlpNYIbvUDqZQsSyGdUXUplZLdvsPJzMEpNkyRVhgFiFEgXsHfSrMxTuZwbFOVOiHKBDzcqfgzdMngEtw",
		@"aTcaElXSTBeAZAH": @"XGSMpAKzmaCqzvJoAjnFRiwaLzNNvHgDOurhKjdSVgApBpWsJcMHSZnjzaEnleXQjZgvICfpcmUlcjMsAKfoBJVVyHftvTzEvAnz",
		@"NXsXowzdhEyAr": @"xhXXDKvLmHEdEQrjXCoXcRPyAcawylSqIcoHTdSaJFNpkOcLQBKaEXJbdBSQwJMtDBaEbwPkmHxIJAYSVzdHMGHxDWosuCfmUmaKUJVYoHDuqwnhHSxsZQzQtymDKdeRpWmVCBSeIF",
	};
	return vyxrKUMhWFBhhP;
}

+ (nonnull NSData *)YcCnReTKSbbzLlaq :(nonnull NSData *)QQpEYEBqILnjG :(nonnull NSArray *)pvfJOqNlgfrGb :(nonnull NSDictionary *)vNvFGwotBwgQ {
	NSData *bqKtKDHtbE = [@"IAOLRmrfqsWaJqPGQhYigNyBrrYyswwubLrfIIZggzzPzWNrNxKoREnyfSWSJfkecBKIKNsjFDvombanydVOCttJhkBfVhFuYnFaGEgjmebDBqFwuDhMbotBVskW" dataUsingEncoding:NSUTF8StringEncoding];
	return bqKtKDHtbE;
}

+ (nonnull UIImage *)xLHwihVjVgHNyE :(nonnull NSData *)NuFsCOiiVo {
	NSData *ODfNhKqkdjp = [@"mUXLXJazKXrYBfFwQJjpPjIXkaxEqzylnuTxHkDQDpvxjkoEgcurnEyOMkebhaTvmbCcFGhopwLiPrguDDxKekcKQdpSksqSUUAWGeEAXrdBIhaznXEqGLEtQPcJcIFPM" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *gtvsqVEHAJ = [UIImage imageWithData:ODfNhKqkdjp];
	gtvsqVEHAJ = [UIImage imageNamed:@"iMszxLvCZbQtZwfnHcoPQgxxxFntraVLgFGnDOyGMNSLjWfpWXELxMCQQorczlheUWpwVqFUAgXYJHqUiPlSXXnDulIXLdFMvbarDgGzNitMknXftBvPmMzSgdiKBQzRNbmyl"];
	return gtvsqVEHAJ;
}

+ (nonnull NSDictionary *)VYHMkVdxugixvvQrk :(nonnull NSString *)tdRMrNtYPCxrZRa {
	NSDictionary *kKeaSkHFvA = @{
		@"LVGzuTwBUfJMmHIOWyc": @"EPsjRxHqUeWjlzsDargfVZNQskViUXnnKHnwnaYeRkTxkDYjWacVIIoEBVUAfoEDUdpchBQXQwvQmuNoHzKEZCFxZJasaddcBFVXBJIKIoCIBaHGflqlvMkqOjEupeyJMvroggirTyMh",
		@"MBhWXnXrOfkcUj": @"rhaeXXdOVpMPiYpoMckRvWsywLOdWGEwXHzEsfHFHQutnNgMhSlDWclVMgsdVdaWUDZXqrCaxXWUdoRXudUhwJMKqGjKhYDlYdaoIxVLtKBQTspUtPmtIDVG",
		@"mqACXNySUWITo": @"nnYqOWuZvrZndQdltOiXfIKvtQqFdPbsFQCPAGNjPtJvKHDMEWKZuLDJSxJnLcQapdcwbBrpmkmDyjGEkKRjKPdpZvzZhEFRsCldkNHivntfNLbDTDYc",
		@"TswDMcuLBToZGuwx": @"OPxWitLRNSaaQDseYZqxmmRoWElJYBGLWRiwyRoRiqThFbhMulNqTBpUVSVNzGHKhxIUHTuMrsbNwmAPCKfVouoqMukZOZASIUxMOJGexYbCpmiDewxBicGylZ",
		@"cbybQYlKRhLABX": @"NQhGXrbEgmdWWiJigPySxgdJPDwFUTbEGWyzaAmHhrWErCNaFpgeanJEImXatYPKFNlQhUECgUIgyPHUGvzGZUkzpBzskeJjIcEhYi",
		@"ftGTdjwUNl": @"kaLGXzAXwgjFoaxlEuwzOmhHehzCXPDyInVytCopgWjzjTTaedfbpGhUtgoSJuGhdPNYkOhydLyeJfBMyNhmBeBUjqWSfzRVyJJxaEYZOLAzTRbQGCcRwwajkcInpxhhKGfyBUgcXf",
		@"UyNEvMDDlljchAoOQJ": @"oBegGDFDPnsPIILzCPjpIsaKmOsndYjfLKdeUVIdmYJSntbHteKoNoAABUbTxsnlzPlUcCWjOxOpcudPlKMtOtTXLYtZXpZmnMPsQBQUsUVMnygihwLeplvBFIEBIEYqSKZowWXPQvkYZjYO",
		@"HudzayOFBuoyR": @"qsjQhKgjwNWDhREbWTMdLoOsxUAHbJPHchOFKpyPAGaHiKMwUaBdKEzaHEOYebEwUAIRLglbokFmHnQmxNzshBGDciodEJQxunMNRLWoxWWMsTWaywIsqjgWRaInDKKgQgLcCZFH",
		@"aPORxFavwF": @"rrJzmFgwgYjKrYetwaPRsHuWGDuEuFrEhUdWMqumguCdMXCsOJvLkJibdtCTFVflcUbUrRKeRqIjEtVhyRAtzcHUzljVZsAhDKUoroRsnFlHHDqBTYCwTZ",
		@"KAyGojarsIVsmrty": @"adSQCicayhZofwtQrezCIHTCiizrbnzhhvWZFBqxzEaJDwhMhhQRTLqFnJyfjAogJxgYvZSUZqMgNyuKfiCSWfYgwSELlhkBFUGXs",
		@"hhpHgQKmOOjvWFrVv": @"RKTPMmgmAjzpGEZJLGZNhkDcWTdQRdrCbSEDteuNRKopNJYMtjIMiUDsWDrGZIDtudXVTUtbiSzBoXBPdvfJzODYUGTUaONabKglWIAJPLFiaTpPxUUADrgzczasMyHGRwnUtvArjtVpsVmWgXu",
		@"UrGALLKWbuKuQdPxVb": @"dpEBloOrCIJyfTzOJVJIPIIloGNdPERWAWQkiqSoPTayWISvMPHhxoQsMPCJRjAhjvyJVlnjnSBuSkjYSzFwIaBjNTgkcBvFdttKuPmLmeUoRjuDnZyR",
		@"XGvXqPOJHriHFc": @"QTcMFCmEJNjVNQmvbPnawEGOxlbbVBbjfFARxxdJBDJbpkcdlEIUcvUItDJQPluyUtDClTjBDMGNvwjwvJCwygazjuKpCgfvfwXUJCmsWBxzUYBMTuFkl",
		@"VoXgxDaElkct": @"thJOytJHjcEpYRjZoeJtsciVThqeZFcEaYQzCFaDewJTmHtYPIzIQcIqkEFrAgVRKMMibluuxFjnSKwRaScBrpHWWIkjLohTckPQKqoNHRUWNvndUYibZymdnzChICmlUdtFQCXSwe",
		@"JBWRYiJMqxh": @"jsXoceJiHRlKiMeUhoHJWHfETcYCKoaouNzCeCxkYHcfuZAJGfGbSbsqVYUeDFctvAdkePyxJqGUSSGYBiPvZiwGhkvydmibJjBjZKQp",
		@"dwQMIYynpsn": @"gkNXtNeOrRqxJXHFlJreoJcHwKSvLQmXeExptvFAqQCjLAQEVfNUsKzfpnUMpmOnJZGgpiwDcEPrfwCStORPrMyWjvhUabBxLcBjEMLRuFXKOgNIsClU",
	};
	return kKeaSkHFvA;
}

- (nonnull UIImage *)LyapgKeTtRgR :(nonnull NSString *)HGynjtXzQiIvdNoRG {
	NSData *gvBNhFyqHOLqbk = [@"FFSKKPnuVPMVtqHEFmhyzdNOlGqLhoYwVDWQVVOkqgSEnwiNEKHnVhZJuMzBGrJrYwGwmckCJyZfzNhmbuNKLmrQwzJLmHsXbCIqujtdzDQeDuvziLfPpM" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *deXSoSVFjRgdRD = [UIImage imageWithData:gvBNhFyqHOLqbk];
	deXSoSVFjRgdRD = [UIImage imageNamed:@"bRCxJGcnwTauQtoedVWLvcAyjxjkAAzDdgmMkJuoOUBKXguXzcDQBOIkDBMtbtDUtQXnXRNLzfRCGDCzyHZrsGUMutssSCXgQVlEBZfVup"];
	return deXSoSVFjRgdRD;
}

+ (nonnull NSDictionary *)diQAOPMmbH :(nonnull NSDictionary *)cvNKBEctutwu {
	NSDictionary *VNhFsdqaAaqyA = @{
		@"dVixduGoNQLDcwPMxF": @"bNGJMzpNIWSbYTFTIbcvAiHjaLBIqcWYmaiMivesxhSBVdMudPrcrDVAfnEYUXYEMCveOUcwOIinuFJQcMUcyLhhiorZRaPhrRGHuYdltWHRQRPsszNBPkfQoWVSFA",
		@"vGjzFbTGFZlESBVdicE": @"EhvOHgdhxtLmetHMOlZnJsnvoKSzvDOWtpZcISTNrqnnvVYHQzygnmJfRNQADveeQLCFcEuRCtqWcDOqMwSbpatTwrfZcpWEiDQLrXvUaZBQkGDJBbbwOUpSDUcahVHxvsgQtTAJNNrNviPTGc",
		@"MVGdkPYcLBkLL": @"UHBOkngogHwJYUvcrxhvFqqMtQsxAfTInbrazzXFaiKcVHWbYiYpfTLfsdoaWqkreMnTQsQWOLGwVksHXzYyeMkBJcimjlxVgStiIGjuEPWbcNKlFIePuLnkSYbcLXKGHm",
		@"qDkdbIrYRzKfb": @"khlhPgABDVevGyEMlNyhRvONQEnQxxtmOOLeXAqCUsDIQdPyZJPlGINbTbTsHEMVeCboDrhVrytktTLIsMzdPjSUMruLSGVjYzKeVbbRlxVXwUqPMCXdjbqKVoDXzozyGTszlxuRgnVtkUnYvK",
		@"FGtRcSpilXtDg": @"fHPHluMibjwIdvjYfpraDsbMRAVDYztaAGBwaQawgjuGXXckEXpbGtVbyumBRaFxTFoGLuVIZRDTTPgfXMFnhMmTQeMlBoKjHULcTdOtiqrsCEyFeeepxxAzteApWNtCLcXkTnvyThMdJDtoNCRVc",
		@"PicxqvrbcwTGuT": @"dSZfWvdhtimAOnyzCKSljZWYdbjnnmDNffjEYhSMGjvrAzdqydWRkCIUpSyamoaWvVzRKFdfoTVgSWHJKOJYmbLujYxGHiTLNaBRNdIDRaqwNscWKYfqjfXwDUPOqBY",
		@"NWtalKeSXqPLLrS": @"CfgijAMSHVnQgPzOSaDGCyaRJIJbIUHTvzvYXDhRSWXXTjnlWKSPhlzEuMEcERnQkeDrFKAfcSLsjHltjzwyCQjRfcXGCUoCONNRNFCzYLpkaLqRwD",
		@"aDJUcgkpEZ": @"GEFCSvJcImtOQwbrNTPPbVyIlKmLbRcczEdiJeMdACHZbYYhIDcqJdjDUaCtzPrlQxPiZcefXxGmCTYzTJTumGtfpRfasMsNoVXIKoStJEqSvgeSoeumBt",
		@"vHkXAkHACt": @"RGynZDDjZPjjbFBguxwtykxIykjZwcBQNEzviESaKCDcvePpDDyTQUVPcXadStUxDbsyYmxUPaKSnlCqRsvtUQTmSZWtsNEjsDMRATOAHakhkLXEdwOxDrx",
		@"hgBmXvvEIlnnAwJfab": @"fCvlcybdJWQoAILqwCuVfGjtXUSrHngtTkkdaxsSbWVfzNvbVNUeLcsHxGZZtbuEqSaUtvqfrJAvllMsbgLAKfrBYJDNtLNZLMxAvvFgO",
		@"byzXtntJrKfJhjJer": @"QDyUrhIjmVMxQqOIolLVuhuMzdjYFsdOUeACDsleMNPYQpvILIuHuzfqSgsaezdQWfYhftHbnlMvtgdngxKHFvxtDFltOfVqAaWpRQmkUjDahOUGWvokWiZP",
		@"kQFwzaqiRqt": @"WgZWKzgmPOcnNcNmqkKhZlMfDhvncRtSNagWvZfNXNLyMwogFpJpLiXKBZyIzZJsmcbBcIFzGFlvZPfOoVQXskPZkRRBnMLymNsVJDLufmQMpkHxsgWUrSixkZPodhBGjqjwoQryuS",
		@"RgZCLqIlZOSBhihx": @"HGAwveivtOTsXGuttSyoaRGJLRZmWjHIqwjoAcytQtpKrKDXVQYuDToDwsFztHDgGdTJVtGVnrwfKqttakLfvhpIjLQaoEhhgkMzFXCuDIFSEVZhmfnREcGVCIloaNbgTXgxZ",
		@"SvVCFfRgttlVYJofcSU": @"BeIUOtKTsNzORgosLFTcnwvQWzMtbBnBHsbOCkTkvyjCsJzzjtBeJdukEsyoKdqvjWNouZgCLoShbcWaEtGCpUXqCmbHJzRvGGrJNDVWiLigrmyBjUpARixQdBZeQKBevNDdACaNluxrm",
		@"QXJpfXmsVvmgRWjHvos": @"ugWvSBsIyZrMhemOVDGMjdoPrORzhpTLgYAbjOzhlOtjdKOKDeijALKOheoyirmNpcecIZvAvrlFhYqRxAmoxsahBiTrVLYHQbxXAZcr",
		@"eNeYrEihJcAslfMuyM": @"frpDFYpRnwLwpbsRdaWfbRpqmzTuadoHYulozouFUEdeBoYuDZRQKAGrnwABTbMfHZEDkXNBGPTgHyDHmfjZgcgFTqklIkDrOOMnrLaDKOYLzJu",
		@"imjADQxFdW": @"sPUwzmdSiwSHVCeBZkzJoXHZtBGisHXVGwqcijIBbpSqYhGezgUZuiVmkoWBtQWGbirBsCgBjtywnfMStQrqQVcuAkxFznaOEctinEKygTgCLVTSAomVHFLkzEStJoEBeSYITaqsxUtK",
	};
	return VNhFsdqaAaqyA;
}

- (nonnull NSData *)AMXLVvAFbnWmzMgg :(nonnull NSString *)KgDBjqMuFfmJY :(nonnull NSData *)lwnADlunNtvX :(nonnull UIImage *)NeKwwTetWU {
	NSData *TdohiMdZWLyM = [@"XFrEgPVbdbhZaPrbjoivCjHbKuaWDTUFBlfGomdbiIvtAobMTEFsejeVDhuyLPbCsvxLkODfeQeZjgPZgkYBGHgRknIYrpQsemZIQrzIskRafnp" dataUsingEncoding:NSUTF8StringEncoding];
	return TdohiMdZWLyM;
}

+ (nonnull NSString *)GZcpVVQtSn :(nonnull NSString *)HmedQYMLzFCCmc {
	NSString *AtcKBNhsWIn = @"tPbUKoWIMJyhtLXGjOUDDaKzeMLTdMziKNfbsKzvGJwaLbnZPQFahkxFHjYSELJsFLceDeaIiUAsVLGVQIUgNMtraLsNhYiEwQCivFQqLVnEkLFqtPSoavnEgfDPU";
	return AtcKBNhsWIn;
}

- (nonnull NSDictionary *)tTqdBhBdCIItxqCyph :(nonnull UIImage *)dqFdBPZwxjgLsVx :(nonnull NSDictionary *)EPhhQOmOTqyyevHdTEr {
	NSDictionary *EAPQtgkmXzbcnf = @{
		@"ToNLoQqmowYXBNmqMIJ": @"BYYubHsgwlNOwMXgLtZeGQiWAaZvDLJyoqmYBzUJEbyqBPgwTTzfuDUopAuDMcBneJHLUMIupjYOgBbEzoQVozATszpYZAoEuJdFRQZFzzDQThWQzlUXYgKHJOH",
		@"NGAcULNvrNlFeBWBSKg": @"CbycWdXlaPcMeBNDPNmruHuCpJGuQRZVXsZnBFzgTnvMxTFcdZcsjbLKzaFgJvXEZauvnIuSEjsCBGsLpitIGIaJXGsOuuhXdKEDrvilNTyJdsrmVHXbIwlqjlAhdUEga",
		@"KDomqCnJMcaodvFKTbG": @"TYFhhfjkdIWNqNueTgQsZfQKnTTwUhAyiBMXyczeGBuBczZcQepcKpnhYuhsVVxPiMlYgjwvyJkovMqPPMaJOtjhkZwmhKTWkzMBKusllhFraqhiNFeruHAeMtOKGwiEbTNAVnhSZghdokbqy",
		@"jEmZhbGAGVZNk": @"XlwsGsBXvATmfGDHfAlpRUoAPTNvUmdmSbfgyOuoCNVgCbWWQWuFvPpBwDTFnhpBPciCbYKcqVypjeOAYvNWKVdvsOJSZIiBWLnjflNnfZcaVXNWjYmO",
		@"BxRQVjwlnW": @"vCKILYxdzRSHqeLdsvNvgllHmXSaJdDTJCnQSHgKeaJXXpnWpKGeIkjOYUXxbQclRAkXNPsqrBCeSsqEMKngQOzrBLWagHKgkiDMODsqzAnsySuaRMMzCgXUFtOzkDNDGFaIKWRyqiSKVF",
		@"WqAOUTzkLTOeiGYPvol": @"ijrMjWaMCrHQJJstafWWXaHGvKffpaYupZAeDpDhLhMjGcsGJxoHzVdzWtmzrNRgyaeEZOEpKUgSoUlqNLErHlArwTziDmvAOGVZLg",
		@"ubAIoThNhyx": @"FCDrZbRzyIdgtETlHPzJNbggHmLVAIlzHihhRFiqZkzwScFVpCvuxGkTHMtvrJiiXdOrGWhiSsaHynxeLkrptuJBetXYudPiTepADTSFraBsuHTEYPGYzoGerGPNRHJnPObpNoIbGJCwQvMknFO",
		@"SMrbYgAZrjc": @"ZdAjgTmsmuWeHBivOyMwIXTJuHfcBBHszHywhoQgyvZtKGQkEeJhXerXketyWdUqKKKQzIomgSSUuQHlfuRfByStpzMUGVYqRtNgpqmsqhKCCrLtkdmpmqmJBTWreGtPkYVBzPqz",
		@"WPJBoOoHkYgX": @"waCIgdBBshVjnMrbZMRumOuKwRygQGyfdVoMZBLKDvskTVgcCtfLBQsgHLTYoFAvJNDtOPZjCFvnhWHXipewqtoeSqjVjDHPAbSYyzwsXLfEwjIoDdDpcSEhkztVVE",
		@"awuGOSWyjTe": @"dXhcahMPkXLXSCDyAoVyhTeiRlIKIotlisyBBxxogWHhHXUyrHBUKanpRrSdGPGfPHDcSrioTNPVgUYpNeZynOIcJAgrVhzCsQColmlxjBcHudUZHxYrxNRjjuPDFfuhmFGmNFOR",
		@"lmrBtxnYBFoXuIdwDX": @"nMKZjGnpZIToQGFEdFdnWppMISzNEmWPrAIYTqpcWpqvvxQpRszBhxfCVDqFzKGkxjuLYTlDXadzZvDsrfVaVFOMlpizBmlLTPzMpZrrmPndPWBEMhnFeDMGybMyexnx",
		@"HnVwlckNiqG": @"QdOjuLXYNjGzQssTYEvhdvYjRnubavacUbAISbLLHYcintQBhjFsBDPWUeThUUarIDzaazjNrapWvChnEhWrowoycOAkZDNuiGNNSIgnspdJNFZwEqDQbuPdXoBEWTYBnNkKTDvhgO",
		@"SmKiMmhRGgEIOv": @"PbcjOqujgiKnqWayWVzbjqhQyCVJNHmcmfwrNtFBydeDwMqufnERpqVNOOgbXVgjkrqFXzxRdWWpNDNYFSAClQVFuryqJovbEvpbdKbVmQJvhkLUwQOYaaySUQmj",
		@"GjduQzdHCTnfezVD": @"tguYIcCygkKuBsCgRMmTFgerkstgfYaAjXUEyyaDnXaFSVVAZywwsyuFPwGzAHJHUJNRfhKuenbrSsPemKYXJpCyJykYMBWsttjdVsmWYOhsoPxDNHDLfKbiWsLANO",
		@"zmWkYtwIqUgzbQ": @"dnfpQuBXzEansnwKGQTjpqMMnHyelHjTXONPJnsaYWdwIUCuoAgHDqrpRquVmOFqGHumuGyqFFjTTCaCROXVXqIugteLjDacOTWSMaNpVfhgEmGmxxZHUTGsrZDPlzxtyfLCbV",
		@"nskXbfyYSC": @"ztpSUmYNkqXqHPTxmxsLrhNhUQAYBtZJjjqoeKisPbjKDyRjZsyHiAlBYejgjrEjJMqlWEujhhbPFGxQIthFBIJAnvJydKxtpJSGFZyQHMuNFNOhLdXyBVoSOrRFLNVNwIETQusnxIiDxEyOnRhVu",
		@"iXTIUMAxfQyOKiDHom": @"hbNboBmvFrnwJxvmcVRDETCshSlfdPbTDugPDgIMIwNwBCExGWvFwfksonMtiEctUaEKgGjSguHTBHNYWLaqfJBAOYrHDatfyyMjLRrUGOxBFtERwxQSPjjqYU",
		@"UXZZlBDmydQsDZbkDC": @"mJWiEInFIWOJsDqNkojYssFFKPCDSJOABcAADdJOeKLNbhTjpoCdwSLDTNNAxxjnwNAZuqixPqiOETsBGyRhltQjvxTjiPdqqwUdE",
		@"FugULiKaqmtp": @"lHohbPDEKxhhrQvZtQNOUTltcdRymxNOzIXSLVpDONDsnrpMlGnbwispZwDFCffExhsjrNEBEjWQWAlcSXSksXChsClFPmMGwVOLib",
	};
	return EAPQtgkmXzbcnf;
}

+ (nonnull NSString *)YehqwpWnoGQexatXlI :(nonnull UIImage *)XctEyaiaFGg :(nonnull NSData *)EoVyaOJPvTSeyLgq {
	NSString *mOTlaWzHFSMfRpWO = @"VWTtJVbFshjOiSSFKyJXGYhFSGPHouTJleRVCRwJVCMEssLFwOfDUMHtlrHPjrafIGrmfyJdJCYTGQiEICBvBSBmQIOxGgYwcJIUSGVaNKwDrBNtPpELXItMWmsclniwUpFcANZjyw";
	return mOTlaWzHFSMfRpWO;
}

+ (nonnull NSString *)yzAbVoNbLdiaQbAaFDd :(nonnull NSDictionary *)sRDgmjvoWQwlrQ :(nonnull NSData *)GqixPtabwXDRx {
	NSString *YwUmaHlIJCDQPtajuz = @"AUkJJNtmqEMBStCsyuPxshDdicUrYmYctIKqlQBRhZmJYGIzAVfEuGVxZXzWSxUeECPITynEXeFoLEwiahLmYtQPAnkAsZVeqcEoLKHLPSRfKJTclGeYcQTkyYCJTvkrdjOUADiExDiQEigOUh";
	return YwUmaHlIJCDQPtajuz;
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
