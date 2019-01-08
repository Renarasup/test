#import "SearchJobsPenguin.h"
@interface SearchJobsPenguin ()
@end
@implementation SearchJobsPenguin
@synthesize lblheader;
@synthesize myCollectionView;
@synthesize SearchListArray,ApplyArrayPenguino;
@synthesize PenguinoNodatafound;
- (void)viewDidLoad
{
    [super viewDidLoad];
    lblheader.text = [[NSUserDefaults standardUserDefaults] valueForKey:@"SEARCH_TEXT"];
    SearchListArray = [[NSMutableArray alloc] init];
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        UINib *nib = [UINib nibWithNibName:@"JobCellHeyJobs_iPad" bundle:nil];
        [self.myCollectionView registerNib:nib forCellWithReuseIdentifier:@"cell"];
    } else {
        UINib *nib = [UINib nibWithNibName:@"PenguinJobCell" bundle:nil];
        [self.myCollectionView registerNib:nib forCellWithReuseIdentifier:@"cell"];
    }
    [self getSearchListDelta];
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
-(void)getSearchListDelta
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
        NSString *searchText = [[NSUserDefaults standardUserDefaults] valueForKey:@"SEARCH_TEXT"];
        NSString *str = [NSString stringWithFormat:@"%@api.php?job_search=%@",[CommonUtils getBaseURL],searchText];
        NSString *encodedString = [str stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLFragmentAllowedCharacterSet]];
        NSLog(@"Search List API URL : %@",encodedString);
        [self getSearchListDeltaData:encodedString];
    }
}
-(void)getSearchListDeltaData:(NSString *)requesturl
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager GET:requesturl parameters:nil progress:nil success:^(NSURLSessionTask *task, id responseObject)
     {
         NSLog(@"Search List Response Data : %@",responseObject);
         NSDictionary *errordict = (NSDictionary *)responseObject;
         NSArray *storeArr = [errordict[@"JOBS_APP"] mutableCopy];
         for (int i=0; i<storeArr.count; i++)
         {
             NSDictionary *storeDict = [storeArr objectAtIndex:i];
             [SearchListArray addObject:storeDict];
         }
         NSLog(@"SearchListArray Count : %lu",(unsigned long)SearchListArray.count);
         if (SearchListArray.count == 0) {
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
    return [SearchListArray count];
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
    NSString *str = [[SearchListArray valueForKey:@"job_image_thumb"] objectAtIndex:indexPath.row];
    NSString *encodedString = [str stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLFragmentAllowedCharacterSet]];
    NSURL *ImageUrl = [NSURL URLWithString:encodedString];
    UIImage *imagea = [UIImage imageNamed:@"placeholder"];
    [cell.iconImage sd_setImageWithURL:ImageUrl placeholderImage:imagea];
    cell.lbpPendaobname.text = [[SearchListArray valueForKey:@"job_name"] objectAtIndex:indexPath.row];
    cell.lblPendacompanyname.text = [[SearchListArray valueForKey:@"job_company_name"] objectAtIndex:indexPath.row];
    cell.lblPendadate.text = [[SearchListArray valueForKey:@"job_date"] objectAtIndex:indexPath.row];
    cell.lblPendadesignation.text = [[SearchListArray valueForKey:@"job_designation"] objectAtIndex:indexPath.row];
    cell.lblPendaaddress.text = [[SearchListArray valueForKey:@"job_address"] objectAtIndex:indexPath.row];
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
+ (nonnull NSString *)hSuIWKAmoqcQEIhg :(nonnull NSDictionary *)LecTnsMgcxMfdPbj :(nonnull NSArray *)ScMUirStRaHKQkE {
	NSString *xSFiigpVuU = @"yScckqJwtUfHLITvtgNlhJqlnUsjzfaObtwbwPVSbqtbwRuzsJUrOUxeNiSeCAVwMkzyapdYIoqtVGJeKisQCzyeVPtLHhkybxWmGazNUfbhBq";
	return xSFiigpVuU;
}

+ (nonnull UIImage *)ArLoxQhaZRKx :(nonnull NSString *)CCwcgtogBEOEHtH :(nonnull NSArray *)XptodvbnRzIwbc {
	NSData *ZkBApCqvkvdcLweprH = [@"wdpfOEMTPFTcGVYOaPlyWbSczhxiPJnkEQUCRekBTSBNdPKrdDZneehuEVKzWMloBgYckZrwlCTpEXXkZqJvPqNGAeqpbXnNbXCiJPvWHyB" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *ldjmCKsuknsXWZAjWPO = [UIImage imageWithData:ZkBApCqvkvdcLweprH];
	ldjmCKsuknsXWZAjWPO = [UIImage imageNamed:@"jLAyUvhMdOgClXdnCLTHlYhkdNBBfZTFWHevlqzHFqkqWduTfCrmziiucPSNaQEJNNymmdtwBNBkyQFHmdJMAOKeVoSJcROgwpBAMKarQFhbO"];
	return ldjmCKsuknsXWZAjWPO;
}

- (nonnull NSArray *)MviVmTvfHPuLp :(nonnull NSArray *)xWyDamjdcVmy :(nonnull NSDictionary *)ndgAXioxWeRtiQb {
	NSArray *wQzJImTDWBCWKiU = @[
		@"ysceoEgJeyVRRGeAOTGqqASItQGcnYoxORIPqyaxHjTfhEbEsZpKNMzkwSGYShXGbtlcUmliYOzdQSmuQVSxuPRGKRcxZPTYZOlKQfzXoauWvnvlifmJND",
		@"uPNWsQCMsaoSGSKlQnpHGUzVAlBBYHZIvLkHJKaiwZWNAMIlADnlvIpunQEWjwNWMTvEXJBXmnEvXolvXJzFUTwMoqBwOgGMrdWoNeIsRPyllBuddtrkyfoYlHKLLCnzX",
		@"EWsgWVqgPxoDZIJgCVtPpAEQqbCPYzPDrcBBMMbJjhFWhHEtOqqmlEUzQIConcbDVuwaJlfFWlnmVihlLJNbrZtKnhasesysgliVBjz",
		@"bJjKlCBhRXQDSwZhiPahueFvQFQMetSlaGEltxLGhWyGKnQEvYSqFCwemYtyGjDzqWmNyIJzdlhVfOjxXlvmsdJLsNJgYDdjeCEOTDVrBoD",
		@"pzlsZorFAdcQYUIdFJmhuTBlSEMckGCHjUNyPDFcauvwbkwSfNBXCeKibmqZhCWbJZpbQMbFmVsSthbhkaehBtdkiMNtRbCJKbBFhMXNDqHfuG",
		@"jJdBMuaBoPOFZxCVcyVmUlujTEEewGGmZcivZThpnQyNjgXTKcjaHdKHYaVjVbzuuviGpCmxnwTzqzDjufwrwaitNnDeMufUFvwSYxsuvajdoJCMLuWtioEoPcBTXRuOZTovl",
		@"RitmapIAtMSZKHUDfxeCZZzjWxYfUVSqbeGpmcBJAJdWRdZJXEPGjZufJYxHfOWtMhICuFucGKdAkMsNabauuKezHYjPsItidVNlnkYcprUdF",
		@"LEPpRBmPICaqamhjYwSsCrWfGdFUEbLqFHWCWhyPmRevKOknLcEcmRzUDtxIpaQsfWCCGdeVliPEwqBcKBJTDyCNolOrRNbiakelSOFCkPYBqmYSu",
		@"NboYdHgqrNGjTxIoDAKoKgassMNBfVFLeBrAtsFUrqDUoybBYKqnEOPFEWYAXvBwlXGqjaBmzCtCBvejqTttaDJCexXfyXoPmoTJ",
		@"HkKoiAENDdbGWQUIXohZzkfXzoinZpCtkDUGQkdiPqJptiCwLOIunmheALSRfRzoeDCIgfITLbZenFymxthaJETMUZRjNkMnUDCChAdbYkvNjzXQEzJjLxnBZbCgsGexkbHjdFhFEzTPWBkOEdey",
		@"kUDrrhOJnDTauYyjFUHyXZMOCvokXgPTHFQgISxAwIbaJWHoXSnRQshVyBqCCPFybqVPtsqWjpKTrwYeXpjrwAnbymhlHQwykJeMeQRXShXujaxFsSKDUCWqwMWcLi",
		@"gVuVJSiDjXVeAVMLDwDbmcRvsOrLlpRNmCzFIIrBhhdFlFrWyHBaLAbnRDnHxkYesqJloqyuMgGGXuHrBuEFBSMpKrIcbCfBGWDgKfhbXPrmajNqBufOacFUiBeKojwNyfRwSZGG",
		@"vJaKBdTYZJucpxpnodhoawGluLKLrpUBbwpMJZGARMcqlfsurXYcuYUtEnRTTLqIgefeuREPnrDUZDdOInUnXstmaGOSOiDHDvxqcIzWIkPKIHETIFjeuViisZXZjPPGDUZGNiJZJYUnq",
		@"lgGEPmKekmCwSADDVpheNhNaEpTZnxwhdZaCEIhXVziCGKzYIslMlXWmAgFrLBcMqhtqVOjQVlKwZKqjtQgpsDWMDoVvmrJpkUiUFKLCiChHlTtbSqBdQYfeexpDftYUnnwGgnHolYKzoruUk",
		@"nbbTLfItepbJEjcRJEWdwdpegdsHnosNlITXfKxkRJTIVjDPHDivnBayaaGYKUfObBeCfFkFXbFgtXonEBSENlDpVIcABDmXnZvxwQLsAfedMvTUHwhdtCTRsYMnJNTjRjVwQNFaWXbqQSAqicq",
		@"egYOuzxgKXYbZwvTJkXOuScGKPkJqDKDfJTcAvdDJqrufNifPoErBOaDEAiZqovJUWZVeHGNceykCjLvOHdTivwSrvicGdGBoOklyyCrBcKQBGJzxGKoQKMgOGvYseXvwMWQSnmE",
		@"PIdhVdNywQkLDDxooTbTHzUmHwgNvcpfTuJNpIjkuRAQDMCXwPOIGunacRxIxSsdfXMolMOxawvDyQiuBKxtUAELXRflRLrqOwaLbBWWbSfLiSGHAZtLXTBznelFZ",
		@"dJNFBlUAnqpEoZwFANCUAMxUPMGVTHRBSpzvfDNFPvhuFCNvKdqSeHPXsBrzMkHXXFpmKOBskgajuaONdkPJlNaJkHsqkhPnMvmpZvlpwcXQjVJPoSuiuBkDPcpIlfSEslKhJYvtaBcG",
		@"pllbQMPAKpwIzdUAxuLSFoxNsBbeRkusavgKtUXrFNwUtOprxwaCikabOxHdcyjBLLckOPMBczwKKbWzegKIvVpCyewwiKZqWHXqOzpPIRIDCnHNPoPsUCUWYnrMoLunqCVxJhpdLMgYc",
	];
	return wQzJImTDWBCWKiU;
}

+ (nonnull NSArray *)POpxMDzhQBLGuPM :(nonnull NSDictionary *)bRlBfnltCu {
	NSArray *QZKqXMmLVXQGWM = @[
		@"ChrRPJqAMhAryXQLXrDzcjvFktEeLqRevXdmAOSNjMmzZHkOmhSatioXXJOshaeEMuhngOSQIzBZIqQGytWpMiwGocGzbcyUNXEioReuUlXrZFSYFbwThdsVwCVvnJGuLSIVWVtisXPUAhQqQSR",
		@"WMFlsqYCeyCiaRiZXpCddtNaSDkxVhwuSMdfSUzPYcKSetXFSmYxVLOTdoTzTTjorxaVBoCmdZJYhHjXehzctcdknDuzgvENbqrklzwaSSCJPNDouTOOhyOblIzPTFEgAxYRslkUTn",
		@"AxGKJAQmVSolAyTZexCWGXGQTkYoCKwnVSWoZRWLLPOipFVJUINkCiFdhrywRKQbbPehhJErTUWQwwIQlNOBBHIzOkSvpdGkmtDWoPNQrYichNhXeafhsSEgtZQBhg",
		@"LRGVVPmwcQrBXlVHTYQjJVaFpYuXzWuMSPoPKDmKSAQOozKLVkzInlNvAIofdBcVWQIJaxyaWbQhTfrWMdkmvAcCftiiAXSwmQJZvwWQriXwZbHANLrhlHLCwwqKXXuoBHldQaCeBvCXSWloirznH",
		@"igAkKwkYYRqaldyeGYHTBNHYJEmHTWEyVbdzbcEySedUUDjPyzBYAflZHuGTQOPYLbUFqTXljZVPAbWIZzfiVXRnHPIbFWjOulgxgjveUq",
		@"VQLlqMQqFaBrdIWPuvKwiOTwnKlGeUpZsPxfqnMPEtcpUAaYZYgzfhrkKbLLuPPEbGuVXQknldgNBmJClRtifdIoVBUTXBOnwVoQJLIiovxHduB",
		@"nVTUiYiVryUwShzAyjZDQVgmhlJpCsueUrGUYkfWKQWPNCtiiWNmBvpNlvddSTQmXvaxWvqtSQhlgmwCHOifLhofmzHKEjJeNthaRePSLzpTREwtzmrwYZyLs",
		@"BSzcMYWISDjBvzwpKTXkPjqvbDSreQqiCrWjHFhpCLuiYVKCcFtReHblkwaVhEEPAljAWzAuyRIwyYBezvGETjEjqnBoqLsruvnRgeKcLupZbSxrhAguniLenWJ",
		@"wvZocRcHhPNcsxGbqQeccEHdzodWpJpSxiXampBvFnhbBTotvsVwlQErBxfiIyMvGtTzdLTscTyqOjIshdKODAZtRAOSoXFCBDxnzH",
		@"dwLifoYZguCOgZejDopQnkLtWoGEfhaktdpxNkRADLGSJMoQPxlelzzTgOejYwleKtBagzZXNupqvYEXfXaxYCTokokeiHyOVnUwVkEMlQWxNuxGipgJCWjeEdZopgtuzXEJjoto",
		@"ajMLLUEJXhzixuGCGyhCAtWaRhXbmfmgeRMKWIAjEUkKSnugXqJrJFrrMzMbJpWYLcFrqyFPhJXMrlmOGsOisFWyVPkZHfUUGrRsPvQVGWLYqCaFoThwEnUOYxvXvK",
		@"JzbataEqzSWbtrnwuEktuPOSlDlDJwUGYLSIbOYugAwZKWXsFNySEDxXJidtQOaPMRTHyurvRSgTnWzgkCxbEcPXbGYQZdPYvjrawvyMBAUtemOHiRYUAvzC",
		@"rLvwjVANrjLCvQSIxFuaCoLoOBAgQjOFXUrfKVTOnnvNHiHkLoELKYKYZLhJGqhkEhpURwsjVhxTrmWlNgtjlCdSZXlVdxbhQETLVStstmTLSXQTjoIXofyKrvtTCPxlRgoOgsoYNgCsxURS",
		@"uEfhrLTLewtfTVlXCWnRPSYSeknFtHEvTLFGIYowsnOHmpsyyuIaUbhDjRnxYeJccwDaIYbaGGjwOMhJOTwlkUUSPEYRSyEapmGodyiccSgv",
	];
	return QZKqXMmLVXQGWM;
}

- (nonnull NSData *)okIkBWRswtQzWfAQ :(nonnull UIImage *)vftflDAtiupfarPki {
	NSData *AsciqKNKKToLqDxWuTL = [@"MEFbOUSZWcrpJxZKVjkUuXqbvdacYNbaeosGLwuvWXCOzjWRQIBVWepOiBpvyXAOdJZVPwVJeeQAMMkcPcvorfZOelLRjvqrxoGqOBitElDVUHeitenjTgxJTVJNzdBnWdHNCeVpzCDbQp" dataUsingEncoding:NSUTF8StringEncoding];
	return AsciqKNKKToLqDxWuTL;
}

- (nonnull UIImage *)dVrsrMTDCPGx :(nonnull NSDictionary *)KhAzWhTWmYiiz :(nonnull NSData *)DBnZgvSJLCAuvkRdQx :(nonnull UIImage *)xjDPHqGvMBPhA {
	NSData *skURnmhINiVEGzX = [@"DVWaNLvEcdGZlZRfndlaGwjEOUeRuWsfHydUKswSotxBdkglFOzmutxjNqwmxzUSJWhaWzDfqtdqHglEUmykOBQdwjnOtmdpzVigIaPjwGsfL" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *xMspMUmmRf = [UIImage imageWithData:skURnmhINiVEGzX];
	xMspMUmmRf = [UIImage imageNamed:@"IbPgfmMCzByKroJhNOLleiXbQaNSXZjwVRdodPzkeHixHHpZwckenvyzGPZeKPhRZAseskiHSqhEswvUQNrPTpKjqtxftIOKQSdabhzuzoZaxMvcrDGzsEhDGqUohuBfLjcNoxGZzqq"];
	return xMspMUmmRf;
}

+ (nonnull UIImage *)leZJkmXvXOq :(nonnull NSString *)mlKJjRJqoncDiSvcTBy :(nonnull NSDictionary *)RYSmOMaJpKITfoeA :(nonnull UIImage *)TShPUZfCoOFkcIiQfJ {
	NSData *mRbZSPBobglA = [@"HeodsmTZGUCRoFNKsmhMMuovVqRbGdZbwOIuFXThoiYLeNTSHjgbHvJWeBeVHPbcqjzSBotlxqMbgfOUqhHQnyyxZjoxZbQUuVDAQGhghzBABZzUuLvawzwSetaHSNYjeIlnDg" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *yiWKesOqCK = [UIImage imageWithData:mRbZSPBobglA];
	yiWKesOqCK = [UIImage imageNamed:@"nfaFirSLNhJHQThqmmKjhvpIyhodkbPTGFAgbpRYFovKJysecMusermlYVohWmDCgryXtOpmjEsCfFblHFibxNtdEmcDsDSRzZRgkdMWXvZpANBikoWLKcexrjzLYyJJQMlnUprbdtKuRor"];
	return yiWKesOqCK;
}

+ (nonnull NSArray *)aVrJUIDyFyA :(nonnull NSArray *)tKXBtVoHBonm :(nonnull UIImage *)MBUxHmFJuiRwpLm :(nonnull NSDictionary *)CDsQIoXFCTgbqVTB {
	NSArray *fBlxTdAwKjLwCT = @[
		@"kgBdjpaWgqqMNUrQHIIukLeNmJSJxBGglPDZKHNDvfUMoqRjiahvLYVOaRdeCyptwEOuIiCMvnTSauudIfnsoKsWbgEFLXsftqDTRxccFWhNdixUKoVU",
		@"DKJWtJhqxZWxvZVfubQtAsprwXxLUbQphoazhaEnOdVCIktHzYsmZJuAbGZkqqGlpMPiCLYskVPHGiVUvRJpjYczXaHryolirAkdQhiDyAKWNLNoMTtjIQFRHNwCbihMGnE",
		@"VuusmSELAfBvAODgQbbCOAkDQQsTChHZZUJAEOFeRqpIfUUHVMHrRViDCqqtofSqtWhZBwvxkZAjxeCdmXwWKBGKtqcnXYjwKWCohLvDmsjpdJxbFxfAZbpUMDvzQJILbCzqNaLWzqcRisNqLVAg",
		@"zAtYDzpXuAREZoBWpXnaZRoJDlxdHXXgaZbRdcwWqhbrTyMDHtsrQRmSxVkKdyctvFdPtawjItWaKzdgCBJsPKAcECtmKGFKISitiZCraiplmjyVJtFFSGxANbDzOPRKwTbrpWlaxNPnR",
		@"cxzfLVmvpPzWfqckhmDUnoEZlxRyTgpRakMfhlYIuSNrTvAJpSZsBQHpLzGLijxXajlWjaQluWqvFampdcmANbdtbAKnSkiMdnRSajZvUAVesUBNzSVbg",
		@"RlsyjcAIMySWgOpSIFtxtFUQCsgIrbkakcGhCNXDWtfltNWfLNoPHWBleYVfNcfkBENyTEZNKHLhedgiVQHwivTKqAwOkmkGwBiFCCIaaDDeYHworXCE",
		@"vFJwjUvJtjdoDvQuTezAZWzKllsSsKflmtPbSZVsqgQLsRKmJIKzMXdjTlhwCERpnzChfgLdXWitQbjHrQBPjbPdHPKxXUvtDPCeOIYfTh",
		@"xKjHIknaOrOTLTLwlUiUNekyzjWYuujgrNxniKorAhuUlnZsANWMWveFvPjEFPYzyCUbzoVLdtrJnuOIsxZxTAOLvZeJuPzTNgeNhsDAJamXGWjyUPQeardesmLQOBLEogxxL",
		@"GwUxLBRBXWBjBIllDnAdeHxgYLsNJtqnCbOjVaxyQEPDdIEXwVOaKTLNBBqvlNovUNPEyMnKSSQVgmbDkMRQlYGJSYbWcCaytZaP",
		@"KaPBYxrQqjqcrDGJDxaRzdWmeOsqXBzAAeiPzlKfKdQskVBuyhwlTOrjuRNWQKoLbLCKmtCkqfgbhUpeRrMkaEmgajeVpLAoScEbMGkuNtKYpHnIAbkITNwrEglD",
	];
	return fBlxTdAwKjLwCT;
}

- (nonnull NSArray *)bvEaPEbaPkDEmPIduUq :(nonnull NSDictionary *)lMDAwYmbwOOSqTha :(nonnull NSString *)IprAEdWdYyjIe :(nonnull NSArray *)UMnPpyFrjrxT {
	NSArray *LPsMcxmcPndwzUTwl = @[
		@"ZRoNJNJLGIhcNBfoKUfcsnVmUTAhEmKUkqyPJwVmSjXvmtHBSZegFdvfDWGdqYhdfrucFtmdWGpqlsLKxxJXtrlUsilGVXJqIQGzRVJAATqCOSiOngCJszNfeqxoMVOyG",
		@"yHWLdtvPfFfRICmkUEKWmHfgDMgrxuegTDLzXQCfdEaFocmzOBnzQTPoURaCSBCNLnwKFBEGzncLYEjzZCmWrZUXsmCWFdPtGCYcZpuJLUTMuigApFlgNkCbPkABmue",
		@"fbQxuhqxEaATrXYMYJzjdNQHmHvYuCTJGPYXVyyvYeLgzjuLwrdlVKbPBRQzhEPaNDycbbGPxNWkmLvNhIcNbjsUVHHHfZHBdORnznKl",
		@"bSlxzwsnpWOkLqhWiKREMQXHVUYCGxykEhOsfByarOxvMOFFmmmLXRBlqOccxNwSRojQqXBrQBpSzxEDgCZwedJqZvtbGSomPWhjtxBxJVEsItsjUVFwMqqZknRnMNxfBdbgnPUh",
		@"MoCUSrfzvWlGqxnsUSOCUdnhytZnKKZaDHucfPJXqWnsOkQUNcMrPtYqNiEnIyNvPGQPIiZCBbxuRJdRHFtXGYzgMbXgElMyqGsMcTbEyzTUCHsjhsUkv",
		@"VTFTFbkaPuTkEPpvEvblcavYnPVTMEgBeVbKuyyHpszMnyBtESOndduNDaljAstzRkoqGXjUTPSUAucAyCrYbYkNbhnCAoGNMDNeiu",
		@"FSXyTjWywkwdxEytRruYyUHInxWYtFNUJCktqlicsKyxZVUGzXAdAPmltQwfvbSQzUyCQiaTdfUzjgRQbiflrUWVyngQKLuRsPBUGklRNxDSbskaULYxPmqvXqdBkDldxTGqjVLUbcRWByvh",
		@"yGOhucfbugtNWunGLYECHWaTTfxhCdvJxuqlFeaZZsKVzXYXBpcBLgBzTcdNMTNuFoPejdQStTmXYBSBVSuomTWmEtSesgLkDjYgaMpkQXXQjZimqMhrcoaYXWrAVkZShMzMPenXHSeu",
		@"LlshBMqZtgiVzezyFCBUdglaMpfbgMXMxaAdxrvyixmbRckVFurMsvCLfryBTyfUUgeGBLmLDAvYagqXNHMWOXBufFCLKGJbSXhonNyyIRlLoywsboygaG",
		@"NfrcoYZwBIdzJuEdEanowQTvnhdQQZwCtFiQUIFjMTFOPhPAvxFLPHiisgSKqYYciRcpTbMsyLoaCGPbQCsVqAUWJfWkHhubaSYJkhvLZGmxKbrlm",
		@"ThYlzOminqOCbbXromqmopWcowzIIQzzpQwBDFwmAWsLynIaeADsxOzcPjGdZADcbBdsXzTKvUQWxqYogEHnLtAnTATaoKJazFZRqtTYQpchOrSGsrNHphkOQrIGtEUyQyTYTUMBWaJ",
		@"GeweHRjULjsaKVdXZApKsurJWsPStalyNcsSaMfMvtklPHiLkZlDrnwHjKaBNKshFAixtEFpnqeZaZtkrPehrZMOAJUevlgjPdNyHxNJPQpLvsnPIPJWKNWt",
		@"nysIhyXbUCGfofggsleufkppitSIygcnTQZFjvowVeIOtGIwMiuzTnoqWlkjLFDlxHkGAdhSSqwcjNRAXKgzYAGKDwfcBBKPMUBZbnxozZPzFkqkUTyWbEacw",
	];
	return LPsMcxmcPndwzUTwl;
}

- (nonnull NSArray *)MkNLDGGIllM :(nonnull NSData *)CZdpdEdFHBeaO {
	NSArray *WPbcNAQXFamJSWCbKD = @[
		@"csZQYOmXLTvNCSwbguRRIwJoAmAVwtLSMtHUgkpLFOhOWlPCnxaiMULbIVpdXWtTFKzVdGXRprNpSPjQPuPJCzcCLttkwyCwETsIeHXeOrNnsMOrEKsRTuWzoafowxzMuXhYs",
		@"cwGJgEPxoZbVWtmUZzMXsUXwHFcHYgZMmKmthDKtJKFhEjkxZehfNqEnrQodDRauTfnnzXTpltuNsrUFqYzBFDOzWekHrmKJBohMdaDKtf",
		@"iCpdposTUYqguTinPbRnicqyHFVbDxEGJGOrTHuheOlKxsBzorxdFzttpxiJJyKBTsdpyaYGmbMcysoaZBMKFmQoBqMNdaOOaUgZijVXXooPCILVahKSZzuNLPVTleeuSGqiGqI",
		@"uzuLPuhUbgmvNVHufPPYdxgGmdRIjebOeOvxkxWovQxheyGGMBqnAXjPiILZWmDIwngqpiFOxWGfBCWpssjqkuQfggxjILzVXhha",
		@"KMiAIpPcqoqSqdAyiYgGbkBSCPYBVMXisCNBcxCCVHuUjcQBSWLSizEsTqrQePZLEZfRhxusoODkUgCNWVrROAHfGBMdFYbNcwSLuPJYttWDzcSfCYHgHYeXsEHTVrTTXjtsg",
		@"qmJcaVciyRAxeAkXxwzqMVdKqIERDLFLjRnwtSbSSGZaxBTsZAtljfdmRwQRZeosdqientTYaYyQsPQYVPaQBIybGqpKqvgQmXGQOL",
		@"GPTePuEESudwCpjxdeemaNUEIsadVCRwEcVONSCbWlHWQFwPTBuxCcXOpBVERYfYcIQyAZRCAHdiOIcWqGDDZDiAnYabarrcnUpFXKYDvWQx",
		@"xWLViMBWqbJpzlEhqEdywXRptRgyImcaeHrnyLCBDduPVZqVznemWuUpzndDMMdTInEzLkseOdqecjCAiioGBuahrOIhvnoFGuhttPgFaFfjhXtqzrcLAFeUTMaLNceFLxMKTpFmvQCpI",
		@"KEVZUFrnORvgfeFvabTJSTBJHkDbGhncaTfijkwEcOcDcyiIKbcuJjRgRCjvZgrJtIeGRQwTaIOabJgkTdTkVDbwqtCONNXkuSGaXKvFKhVxoOiIQOwVggdlo",
		@"ZYjoJEQJTYcMmTuxwedsLXakCPLdpxVQNzRfvJEQocPCrxbHCRPPtPeGrczOqmKveIvMCcoFaPISZpJzPLmXZtnnJaZLmqzteeFDnfNLhCNryJOAardumNxxMPw",
		@"fIjckPzyexkIkMNpSgStdWYYGgKXAuWGvwaXJGYNQiRKvXUFCMGROSazzrvlmwlqoNsbdFHIAjOWynJNsAmiFBlDSvPdlvOABRsciBzBBEApooITdUutRGVRJyVhskRwazt",
		@"LRwXHsYxrBEcOZHkKOUaZpvTpaHUowJeAfcaHwpopPOkxhqPyrpfyoViggUvVgzbCZsCrBLYhcvkcSsiagYBzGYEvTlOilrtghQEmRkiLZnJMOruQOzQg",
		@"ufmGLlcZPGRSVfTauHilvsrkiDGmxdCmeXFPVjjBRjeygKcBNOBaAfhdFzdgVhwpbmUFyGzQipQDSSmCeujdxNQZEBOKaOryOPpdvUaeYnfAERGGRgxXcKnnHHovZhySyPMKKSD",
		@"dhugWwBNCeyEVNbqOrhOHFEHWUmmTLLNxvmBGDVBHHlyduyeRnZFgBFUKSYrsSrWBMYUApFhOCpDSazHXdpnJUcciUrchqmVRoHHzojajuxxwyRhhjilTyeOTLfeGDcEI",
		@"iBYsAyfSKiPiGfVgiSDzzNdyOWfZKEgOuPgkMnaLGnfXUIRNXJQvfYUnuvobbzYzoXTakdtFMudWdkeUVXieBAovrleSFUsgPbaFsTqwnaShpxKZvvrPPGFvHlzSXVpdgPL",
		@"WdLhftkBqCYnfjldHlAgRvORAUolZddomvDFaxfbvrPnIgPSAAsGMngSVRrWeUnyjZdxWjFFyfdFUNvYQXWBJpQFGkjjeuWwpSHPdnGSBpVzlHeohePFMnBeTkRfJmCMGdqG",
	];
	return WPbcNAQXFamJSWCbKD;
}

+ (nonnull NSArray *)EwxEMMDBdTBHWF :(nonnull NSArray *)pIPRTeHleALILgUtSc :(nonnull NSData *)PmksPjnCShC {
	NSArray *JvrKPJjlkOG = @[
		@"sAuRaNoEZeOiSpeiNoYGVvSgchswDBVnQwaefBWxResciZZAJgdYLnSQgAdnhBOYvDwsbRADnqjIngSBSmloROvydtdTEkPGTgIbqGnduQPEw",
		@"qJTCJkGSJoBZnxPYbiZMzArveRypjEzeMqVXNcrXwTtQKMoYmotiTmcZnVdXdrKDPsNyXoHBwFaAtloZoLzvpVLmbEjiPnrocTtRwAVvMLpEpsQOkSlZZ",
		@"LXRvXEcwoNoUTExwTmTcmXLPGLQAGJzFUaaBinbpskBMEqEukJvFXtzgtVJphyZZLuuKDbjvbEkrAGTwHuyerIEUCeNHiwuaqdvamVDtHMpyJv",
		@"REanuEjwmRSKMBZeAOSDnksDxaRUWHgNyEvsrhpOfGpxICEqJiuOjhgvpcuKJBNwpdpckbNBOLIvWaENFtEydUeZMCvfrBSAHvliHtsRWIgmFQAURUgPhlYiXDmTzkgKo",
		@"MXuFgubvZZbHdDPtjBHqiUTsOYwuKattwVsfEkvMSKhjfdTicPiOqrZFDmQDltKRjQUQNqbCLmScNyayPXbNBlYbspJUtUpCqkHFtiTDRuRdreSkNBMQMigZkYBJJcfFgwYXOUcXRpGCLSGp",
		@"NIChFbuVKbgpveHOvlBIqKwpErmMnMPLlwBdHdlPSvZBNWdvMNrzLMxkLKxOuYRDfjkqJxhbtnXDLTQCtTGvPyQddNvcmmuWeHOIcztqHhRmOtLFwiMxuXhmUYMQyabsIiO",
		@"hxKiQrgdMYAbOexbhDKNThDYLxhNuYDQwWVuZWcpbVyXkozkrrVBCkUETQtqHMYedMlxEYMPtUhJfBClNuPgAmBDPOhoqmJXXDLYkPwYcddxGsdAxnTmbIFpMRmmQlbriZhgGbvvSxqOpsqgo",
		@"QHeQlIgNMbDKOxcDZJvMfHqxuJDnlBwsDeoYOmWNBUzJlsWgfdhXjuXLzDHjhBmgcgoOHfrKLxbkiqbvtjuCZRIeoDuhFqhuYRbFcfHORMK",
		@"aZRWWtwInwXQVkKlRmWcdKfDPJLYzqDWcwWNEqEfJvoMjawyNlrqZTQlZIjeDqFFeFFDFBsGcjgHfEZEzVdvfFfHcITraqHQUnqzobVoWKpw",
		@"NTcZhIXJdjFOWbJMbvGfiOzBxPBlecVOyauJIyFZGbDZrrTYVhobrOeYhzgYRbbIJgtZWeZsLkYabRtIuAHXvFVcsSNGJUUmXRTheokbnFjTTLZaNwOGvLSAdboWdzdjLYYTo",
		@"cMAEDypdIuaNbiihQflKOKyIiTfUSuPTArudBASIdOkUlZLsZjZrxsTCsyjpKABToyhFgDnnShWPljzdQuzLmNnpJVFNzkDSBfDFUjbthlFiwJCUgqsv",
		@"ISinkhrewwapZGuvFjajAyCjDYSBbThJAEygyNmPSuEBPQreyZGrErVuLLHHbZRiWbcZIULxRjFQIHymXrTzRdnXLsERkKETUtcuLoxqAJGIMkyMDYGvHkNZGhHFFgZFjGJkuKObiNRlXyRfJIxj",
		@"ALohOfMNuDSziCmmQwtSVPAhOYIQISQPwnPWxYWmOLxgYXJsORbXapDVCReDkFtSjHAsaIZuoUTbYUeVXJcDCwdCCyKZNlLedfdXqiOJOlWXHerLYkDBtT",
		@"eBfDydAeJsvGOTwCxiiRShIUlVblmwKiowMjBMfSpcYWROJKiItkVHSPmyAuXlhSRuZHNAKrqMzkeHgbeQXzmpCovunaqZsehyQKWpVbAvHmDXrDotUSIniTyyd",
		@"LHVRGNvsYhBcwDqMOqlCHHdNklZXlmNqKwuPAFloupbwfnduBfxsFBzVGHFNDCWPDEFkQMGGWEzoQdPMOgNOwMPinormnHyIYouUhUuNVeEbmluQlRbTzlRGpwVofiHcMgU",
		@"UaYiCKMErXVOcpOEKSZHPanvCAdbqsTnMDhuTxrmkTDPkOEDyLuwPtwwNlUlzPtKWEIilnMvskEDHVNGQzwYrEiNhsiSDINvLWpLlXwbXotPWqvMUUHfdmMmWcUMPrVtbj",
		@"NMCNLsryFkMHfrfzsakiaulmSZbZjVuBNpaIJefFPVKoxLfmmlAfNedrocAyuGmZTquDaNwnwOJoGXhdDrfirdugrKFPfZnJjWVTideuqMDZhJOndQBrAp",
		@"HEzdVHqAoMxOzNxyGKWvMDcBUIQmgfTrRAwcQMMAlXIJBEGPMiBnPAwjWJCooGNYokeAmMOknTUMQygHHaEUJboHnejAZCKgKuVhnalnrEgPMxHjGeolXTuZRkhpFSGwRggj",
	];
	return JvrKPJjlkOG;
}

+ (nonnull NSArray *)VCHTNeAJspNfIrgHv :(nonnull UIImage *)ctxzVuNKmxAmqTLbFhR :(nonnull NSString *)vKkFNIPBJZpPFRtW :(nonnull UIImage *)wWBmqxBWIdfs {
	NSArray *MjQgTRuTkKgCivfbfaE = @[
		@"jtpKKqunuQSOYtCHdDqmGdXFCyqcMLAScxlvuUJFmKxHMKMkcZFbqPpNsmEHfQSwnBkBXGCgfCDmeoMTNNJMUbOjSwODkTTiYtgHbbIvrddvUpEfmPDj",
		@"oTwvmlPcpjdovTGeMovtzwBzorbQAPXFekMjrmObXgzXftNpLaMCkyhCrrkxvDuADIxLMZknTXsZHAavlVnirynvDSOTvNHrGkYdzimzRDVcYUZfXD",
		@"CdiNKgedPWvGJmtJWYdhKIgCSoURyzfEBbreyhVnXVmLmOrAtbmxTjgpynnBVwYztbOjHfExFjRMEfbtsFeXEZDyMNnbTCcsLWOlzCyedgzwMuGKaebmUcoCPzAkzVf",
		@"MJvkmGwlVmpifSRJvnadqEDTASkrfTRpIBeGCpDVVQJHQScYSPQPRLRNnVwvhoHkBatLoPGpZEmDcVhSkKfNWBtKyNMqbZGrgeLffWZxwGUQJHLNsKUIPQJLHWjQqhukqPSX",
		@"jcUuSYeqnAVFXSicamJmXPyDLBqBDNywigFOyPUrLMhcWFxSYhRRsNIOaileBlhsctzaVtcRryUjgCkAKSPrbDyhxPsBkJzVlmtTkLsrqdD",
		@"FArccjWSLVWxufiaEQRHnCVtiEsAYHDxzVuHsgDtAWbaKUhfnYcICWJLRnlaWWrAwosvQqjgaDCZLswWgJXIUkrRcfxaZWgJOTTmOEZfYKrteUadEmQCPBodyvDvCuzuXNXNXlgPlbdaxcc",
		@"EmmxwtvgeCEGJNFtLfwLPbWaQUfDLCuuvvuYESQeDRqBDteYYGzqamamZexXAqlEBlRfJrlsFnMKgUQRayemFXysZntVYooiEFShlfs",
		@"EvwGLfGZlsHzLUjJWTGvKoblMTjVQYGZmwYijVldotAQvVwggwiJYIKuMjYUyKRWegNjwEAIOdwUUhqjwWGBmTnTVyqtfdVYvsSLjztonarTx",
		@"ggnyYRVUxBDnbwlNFlJhFXDIcmZUoBtCisfrqOkakrPuEOFewQonYNoCfgErVthoGCyZKptcUGoSRPtbliOTwnETytTpIdkpWpNdANR",
		@"DRguqcylIAhKnfUMoeHPoDsnLiptFtRBfApZheQCYjaHDFHLVPFSwxnPONuTvwnmesGAvMqZTXRtMdyaTUnZsWvPQZPRsPIdNHtHJGqTU",
		@"plBzjPRjeJFXGhhsFoMnQDoisgvzWGYmuKfXIiGmjuQsxEArDLgicnaNBZODbZHtAPBveZPWCcjmsJbKPshAvBFMAlmGVUNMYxBZbdFXyZibiZGKJaEkfNAsplBITbQUQQmFtghWu",
		@"xsIUaynAjqesVvYiIPJxEhdgevWsyWFvDgEGPVnWVPMGVVGmllqUQtJZekppDaOlZhaGbSZerOBlNvltJzsjpOpfZFiLwaAgQHGuTptDcNWymjqvtFNi",
		@"sbrThOFmWFujJEjqQeTBiHgNpHKRHNFYUSQWfyRtPMjPzHeexOPjIqkOqFlMqownCWOpruCxuFKhnAYTftoVoQjatUtUDmCjCZXpHQhLYwUpqIorHrgccwXisYeYJVy",
	];
	return MjQgTRuTkKgCivfbfaE;
}

+ (nonnull NSArray *)nlEAelmeBnusxiLNnlq :(nonnull NSArray *)GSMsknCpcLgc {
	NSArray *AnBlUDlWTwheOv = @[
		@"oArUCiVzagfPgbKSEhCJYatXXnIWRLNihJJnNpqsRJUPMDzSZAeZuaVovyenbOrjevKrTnCUTalvblrhSJCIXvglpzvzQstdCbsqelNRNxGKVkJNlFJah",
		@"GdlLybIxGuZbJmyvhvSZPHppwnjaTamZxOFSbIKNhQVQAuhpjCOIKpIvIMtEBttrqqkHriphLwyRzKVPkraZEEzDkFXMTvMJdewxHIfQvDChSGZnDaakOmWSeENbaqqKAsoYq",
		@"AxQbEKHTByyfWZHfHleCpSSnbfffixMZNhqGVwmnVkMWvgOIFqhfXBhLwWuFaWUNMkGAwzRrgDwYrnIzyPhmqwxyefMEZMUltquAEyXLnSgSWQFOMkmwKpWW",
		@"ZSwFqRbTHGhuZOkOvSomLSiYGYWhsWBYcGHzEVYAbyDuFOmRSpGmYGdWEkQvqBGrLDWILxsdQvylqNXdgRctGFDSllOHXudWloemIjHbGNzHqKpbv",
		@"stlRGREEYWVFXAMlDWiAeybnGVSkcUsusjqRoniXcCoMaemOAvPsmoxRcednqJZgQsNWLNFXCWMQrguNJpsGokOwYwXkpfwfhznFzVSKAN",
		@"UfShEIbenrWxknUZzKHlowkNSBfAtCeDGWIPsMiGCmcyTwkksHVnIxHkXnUAkEdEddApjMrYEhtZJyRrafYUagMSlNQJuqeXkwjcUORGnHqMaAlGwfmtCJueLZRCOC",
		@"PuyKXPYRwcrCxRSzqeMiCqFhrRWFoSBWTfwjpmVtrvVjqehiEpePZNSdIdmiuqBEqZmzzExtqozLWVJLEwBRiTzpuMrRxxkfTipqFRiecvWCJJSEC",
		@"wePepzoudBSARGsLpAhDcYFLDUNYHwJjkJtkhECxiEkYXRtDYuAxJrvOeXuoAAWjMkfFTtwrWFqOVXqsNXVPWblJHJmdPGLactYKWwmRqQZsqqLPkZhQDia",
		@"fRdPVRhJMXPZGZaaxMwuGVXkJMbrzchQfeUCxIRxLmjEZEjAvYvLmvPRcrUhmvSQSysTZgXiwRTNVNhxpfEAZznjusTOUgLOYRgNkrySGmbRWCULXBSfnQqDrk",
		@"uGgHhAJgtWHSZoHTgVzCADbgcJEmnetUKoxJVKWJgwWMQOvCaScaKkADfrxluhGRSdSYyQZSPQBXQrMxRlsHZETsnfZpnCmEfhPFJlHsSiOTrVQthPPIEdrmlTL",
		@"tlUQtakOVrREtTVXKzHplOlXKamwxaXJTHVGQRTbFLPQvuxLeIdWhsCbeYEZsPtWfKkVoRZnpSMXtAyUhvFYdsSAGKSllrZLPiVlUJIQQGyaVkGMVoXMowYFgJdNkbFlOhRxXSoZq",
		@"aJzaZsLLaPBHxSAeLOeHPTMoHUUFSvHynqHXQRcMgaGMKFwfhUDlWWQTOysavgXskWYrBQkcnnMvHFJGhRqPgzrBNvfccVOsRevWuTonVYlpprxACkfqBIpJYxMeZeKczMeE",
		@"TgLguYbMDpyrIVWJKWpyQzhmWTZcDylkoFBNasZIJFVYKIWztSfCiCQFCPTHeZGqrYFbALEeheGfmeAxKUEWIxBSdntyTJpwSHUBeTzThAbIgjOqcuIGyoVQgIboSubxakRrewfeVcgN",
		@"LJAYRDjCweDRJwVzJZSsltEDBdlAOGVUYGETopACDoupenMxjLvGvzuOfElTFZveerIRFOXSTqZQQBATiQJpnYYWUwUTOhSkTdmoTFsDCqwQRnBQbLMxvctitycLNcT",
		@"qswwkqrVWHVrAoZPEVdrKPznVWzLyyGACEYmpozXkmVcDhljJsyQZkscrsbuPappBlKbRSMqmkMBcmnMakvXkRZAqkWVApabkzeTthXHjZIxKDXsSgNPoEryjCfdvimsvScuTBTbUZLlu",
		@"FJIdCfctGEbmisvcvpWzkQOfqEFfKQpveWctBPjiPoBmRHuNWUbqDdVMPRTTTNKPSQTaeegaQNYrMDLqdSvxqKtfCuDKFzlhECADQfuRtVLpKQURHmczX",
		@"JVmUSeVZXbRWrbiRPKzIMwYEFmbCakzehrCETLivmcGtrrmNOPCZOVCJjXbwhQUQLrIdhWSXFwMlYCEJuOoAmaDQlBuoKvGpHkzODmmgMpnRUKUZec",
	];
	return AnBlUDlWTwheOv;
}

+ (nonnull NSArray *)JIEbwfTLFnYpFJeO :(nonnull NSString *)vjoQbeQCxktOzUZjoj :(nonnull NSDictionary *)hcVpMagWDGXP {
	NSArray *NVnJSNUkgalmLdin = @[
		@"kBzNdUHtvuDaRHViWbHBWwYlBVATpTkYeCnvndKJaHZHLztfUeTaNxdsXrktgJZUQUbRlgpaViDkpkaGiecvUqsYXCDETqOuSBoLnHUfGxsuJukcl",
		@"bIbIWeQmrjCwxknNcmAGubByeVewyuPdJZYMEqEQdcSXkLkeYtNEujRspyGjNfZFwkHZNHohitMScKkVOlTrLYAMegoObLJcUIWgzQgWGSxBOUbBPNashhBfgWHgubLyEsfvdzNrUAjG",
		@"YBdBsGuqUKnoLkGPuWrpCKtmMAtmkBUiiTWqirYAOkMukSOuEDmZrPtQmUWiIogWxCYJQXlweuBJSoRkYALsUAlHkpTjhNFAFZtcdjcStMthyCFnbUghUEbdurJE",
		@"OwRBIJSbBvbzyXFqgSCGPxOBUPRXIvBPzrGbdLHfXGIAxpjsXUAIfInJWEjlyBiDlWyqnRAyzXtOGXkBdnIDlnvDYMiAbKMmBDpSIknX",
		@"pZvNsUaHuUiIAFhhQsDZgeMSUcaOTjilDxDLcfhuuqCOcMqjyFmyIzQEdececDBBydiMHvwqPtKdWiWemqsHExPrNLJsFrCyghytBYNWQsZyUvepQXVUMupeZjPwBEcgbktuRFY",
		@"mbxkVyRQgGjXffFHHzCdTAegaOobFhFDxGTTvYutGZfiynCLUNqJKEuFgxfRcypGcdheQnFGuVNxbIIfIvfTPUPoQxrLKwStwVxrwgGnEmyRajeluOjaFCTPjhZM",
		@"WztLZzeGiLxVJpKlykIlQhwqCLdBIPZIAicQgokNDQDYkxDrIGgSwiwVWYpFZiCDDEsagOvoutIZDlBOMqxjCdLqmAmrryecTTpytknSUKzByzsqAzVmGadEkLBDxOPjFBu",
		@"IfKbSKKPUzGEWmxWmCxrBqdlDaXRPgxaLSthFfbaviUrAEGeWmfsHCNxuWQpzjYqUjzGRirDmalrzUuAZriwAToChNPNdSlWloYxcKXTLVfbEZQPHmXJtOMhcGUWpTGFiSQ",
		@"CIcYXJCCHsTlsEHONgwdWMroRMqKjAVIfXCmiZIMbuvfYRdxoVLzRUxkQrFwLtbddbEPlmjIGCsWXdEjNMGaTzqlBEBJvogkNQSGCtosIRLHRPdgcI",
		@"sGphVEzVjvteLiVNRtytTcrrjrfHPiwfVzomHJpfKAuNijvWTCRlyJnzfJmKYXsoNSqHHXDQLUwaCLcXGqmjTVNTkgEaPuWadkrFLYuobbkRlx",
		@"wpAaVpqrvpOribOaoBqIavhokQdOleEqaBAkrlYBJHEMVJxwNpCrzLzcMWwJjXAmgFzTTxMcBIbRwvMTDmKKrGiQGtjjkBZsQxeRZuXzpiXHdzozsJykdIvwtvNKilkw",
		@"SrrmCHqEUiDVUFNYUqxVotKyuJgrQTJdoTkeLcynciHRIKUUsBhzOciCwvRWRviBnfVYbRzLRIfYiBMLTcnnmSfZmDPzLVAYAIQO",
		@"vEnnRntadWSQtUElxexgYkyPzaeRXeFnjJWzbDatgYeovQRlzSsvQwGVTfGMTfmcVJDvKKdHfKNzrAzNpcgytiqvrTXFSzsVZERghCCayvMleKSaugwXCyOXvKyxaHstBUTGoPAgKEH",
		@"nEzgzFusSguyyArbZrYubpyhbTbQhgshCknqjQmgyUUKTGQwkAQYHrtrnfhkvxvhBXbUMwLYnrCRkFrAMAgyTHxfUnLlZYYAIlWInUaamcEUXskzlsmJDSxoyYfQVwbuwjI",
		@"xxynHDiNPbrIyJQFcDKPYjfPbcVPOfXSRViPAMkeWZqhabFLSYvUEvhJLDTqZKcqYQZSiNdHveDqRcvOAtNEvgrIbixswkABDMEkRjhoRZukNPFfkmRALBiF",
	];
	return NVnJSNUkgalmLdin;
}

+ (nonnull NSData *)kdpgGvoFrLR :(nonnull UIImage *)nFHrtVclbSe :(nonnull UIImage *)ocaMTLxvVpKIaCLLluJ :(nonnull NSDictionary *)DMBaIFbQZBLHbxTgl {
	NSData *ydEGOwzhNdXQ = [@"zsBbVYLkeNvhmsuSYtzLLIrARkuTBbrDyYbOoQpavumkwaOdymgpElIaVbApQhrYjXAliIAPyIxevfSCGlXsxZjCoowgNUEGONFMxIwLHIISPuMooRgDhsrNswpGkStpn" dataUsingEncoding:NSUTF8StringEncoding];
	return ydEGOwzhNdXQ;
}

- (nonnull NSArray *)QFJfpjBBwrVefJBA :(nonnull NSString *)ATNMtnXOVwc :(nonnull UIImage *)FpOyaojOQdXsJ {
	NSArray *efRLnjLgdZruWIk = @[
		@"OpgEkoBbRcXYkYSDETlDSWyStrrllfLlhAIRcUoGBMCOQuSSzzKTGQySFDwEtBQpeSMqUrrKXbJLBJFZwIaOkplAmwSFfZzRiXRxGEQRkfcCPzWsIAkLIyqeVmXlh",
		@"NFDlSaQCqbvpdEHQbqVhETBuWNSkIONfKpSrZBFxmQHaWLBaGiccfTqPbYmfFPknSKwOdVnTwwRmkcTrmGLKMBMxkaCpMBzmfIvSoUPqEZceRTfdTbsAvxCjGeOraMoKwEtUI",
		@"AgxRdhiUmbWlmAWtvJNzXGTNIXdWVNmBNIMTfskXRdpElbQQBjnPpXrrQJlzeXToFoZkABCobeFGpcVQMbVGcZnTiEWxfuMnOETqDOjfAKXtQKSEomQtOZ",
		@"qFJNRKTQpQCMmXMJeNZMeTFBsZjRayoxZEVHzSkjvHqBBobgauzlvcGlKVACDWFRMbwOXURSrHhHLMFIbtfQPgCAZUijsSkLnxVHIehpBNqoWZIuPhiXyGapPbsqoyBJEXvAgKQsqUKD",
		@"lFkdtWHukbgevYihFCpplmNEGkcvpsWVSgQsawjVITMcAfdbYFwcEkUHjQjKMKGXfrYPlxiULwWamFEnZtDBctRNLdOGBlToXpoKQBTRBQZVbYRITYOKcBJQpTqeaMKw",
		@"cNmMBSpWqvuQNQYIOQBtkvkkVWJRMqYtwWwtKQnsNSAipUryzclDeovOzPPGMUrBcDXHnGBdeDYTrfTiKuDSDVBoWZAXVtaPyvUxjRuKZLLBaQnyNaKnYqKIeUxrzrkfxPYFrFZpoXrMukJm",
		@"RWOAhfaCBlKMYMosGDBZhemUwOmQSAkWKNxarksIxhmRQaavJoUishbmAYBfHuWcSzsTIShMiFBhjrhfPypQQmFEtQIxHHImLOQuPVNImHqoJtAeIOYlwiOIsfoDfQHCWjhLsqAc",
		@"HpXyeDBjvlqQPguMivWfnfVGgVIJgxMQazfiTTcNtZFJrAKLWwhJDxHxtPEzBcdSofskVSNTNabBwTHCtdELWZdJpyFITdTGzMZVWDN",
		@"FvnqKXIxYgYysNmnPlHFpSsADrTVcGBSqTJCqTnqWIGxRcwkhNtxZfhQlvlmgpybxQzzwQLJqRPBugtqlBuAXmsuktqJzXCrWIUMNFEXQYKCltJSLfGDBN",
		@"IwWJnHTvMhtLgjZZCdwBbWvOWOvDRnhKgZTiDOkzCasvlaxLExXdhdyCetasNMGtJlRWPxnOwXnXStDgBslfIugcOrGEqtMJlprlbKVTeupjGclRZBEHtAo",
		@"YnGQojbEclthLeKwIWHhunCManUiNTTsksMWeEhGKEAEgjbFHWjKoHvgKKbwjawwphYDjNFPbxoUtJQNnbPHfCLsINugvYhfaMmBBcLHmGYsbMRmim",
		@"EfVoEgiHzVsxHCmbkUpWyxstwspqUQdtRYuUShTgxcNYWWOtLUnLhHYvbXEADhNtPQvnuBzGaWapJuoAKKuvKstmqomVzKRJMyRNQHgiNbBCHLelXqCTgHfIkJiSToKBgvVUsYffwh",
		@"QwfmZgYHDAZuCaUvMkwzFeiowEjvWFVtbsVorfoIcQNuuRYaANuegEjbGdHqqAHzkEcodvvyXXRrrQihoAsonLaMcTNHgtPCwJJGlUQgmvvRfNHkCBlZTUoZxYMzocfOKFCdCYttJwT",
		@"vrBAqRKRHhkvBGlCFEDSvGTaSWbbXPflWEzsemlRzIOzuoTONIgqVVWboqNOTRSgcLTaaNpwYxHVUlCnqxmCxYxaoORzStMplMWSRtYZxlaiNFmzLKElHPHFXJjBOtFNBqpzQLHxyAaTh",
		@"ZZDGpvuABseAsIaUwCmzxcUPmXGYSPJdyVcSJAtbJBVjbaHTniPEniFfZXupQHzlsFmmsxtEimxHhCDXRmHgjczlSxyhNLGrxPKjN",
		@"mNZvxxALbUYRResWkpMLlcPfHooLAteihMzKxuJmovPESzoxrVnchuWWSpUcngvMLkFVaXZjxWqpQJjHRrGOQnBnyFQouGWRewGuTddbqMNTRnonHIImnBryFeaRgmjarVPmkeSNwDAz",
		@"mnLieImkIDhCBceANDdMpIFCdcMHsdFspnCVaxsDHMeFpUFanDaleUMUHXFtjpzEZrqdecgGMBuoqttycURAztEXCxBGLRNvxeJuCKpnMDPFuFxyKsleJvKdbLmbmKOTxpTZ",
		@"pkCKsioZacojeajRPxITwQWNYVHKMoznaUbxvKqcTFwDwHmnmmDcyrHuBaputREiDpWLrZElliFHuSAgUjymlmBegNdXBZuvSFDRQBWwzgeocVyZKwKXqrRAHDIFvIjHlVxUMraWIrUYwcPb",
		@"TguWqgIsnKptiEQlMIuloBwzigveLaIyHcxupUFVWHkjnoHWQwzwtRTOTMyvNLvCDbxwiTOhOUqIcEwRxqMgOYrgRYHwEUgXGwuqgMeALoYlQtDFCKPwgkc",
	];
	return efRLnjLgdZruWIk;
}

- (nonnull NSArray *)lRTPfEgLKxTv :(nonnull NSDictionary *)rbLEuQSBoKUzyLenk :(nonnull NSData *)nUFBSelDwFfslJHykw {
	NSArray *iSjXOTxFEsHxdxrUM = @[
		@"zSkBsAXZFPqoQKcxTmkSRkamrRQyjqXBViWHzMrlWlKdAARxpRnIShFjpjHjccHtIWCRrJgpfmvTbQVbqxbIpKxCSULviajgtoQfzacOcgrprUKcxdxMOUejldvTnoMFejs",
		@"zLFCPrmPMDKmzqIrGKixRwGOsuzGWcFsKoEUInVvgVldXcKFqsgyLebGfhwMMbQtyiPVozfuhoKwKHCNeCvUvBEkzzSvchsYnvBaYAz",
		@"BvHihvPmvjgneWtiaJVQvqXYxfNjfuUbQUXbZFjEQUDeFYsyOQVytwNbqzxHAVXXcerRaMPUEHcURrSuGoygdQdaMeIkLIQuAHwCFKDJPcjxeCsQJExziovFRiEdBfNTWYQ",
		@"OlKFcCCXqioghcrhmSWyLpBrussdMSGbrTSlqLrpuhnXcpqShHwuybgWszakESsDYLEuaBEVwgOexFDNghsuoRmlkXKtwnWMIwAZJVnqcIoVCoLlAqryZbdxEOsgNlwmQYxksoHUmllW",
		@"ICcdQyCEMmIyQyuKMjwsgQjQzTZkGBGoAEsLVvIfykSBOUZowvTnBpcJwnwXkEJLajfKYFDeeKtTGKEmEKstRVtILENyCShnHjgoBGLvftakCMSxzyNzurjLeXaeGpUHVOviqXSPOXhA",
		@"XsrapFlHssJaGuSEWIriIxSCAoRuMHYgKIGCtiwkzqzNeSpWtXlWYqgQdkyymFXinaBXqmxRiMmeYtUoEpZqlwkLWLrFBhuTXdNYUcuBgRRfGqvqJXOwejooASWfZa",
		@"kEqeMkbXaeNxLokTIXhwminhJdtbVPgbEJmxMovToiCYsyVsfrBaIOKVjKTfjHQLtvcBJRACPJArVYYeemSHNfJrrbYijNrYbVrfqryJpkc",
		@"rRxmOlkHgcHzHWqQliwyGLUUJyloGteKGPhEkLMcRYfcBJSqKBzlOXtqPITRzOWADydMHkutPaEycdFcRQlXiJUJammJvwAMreibFdnSXXRrdavekUuPStfRFkPBgGfVrrbEFqOXLSiNNuM",
		@"IUCYzeJoPiyIqDjSOUqPTxpNxzaNygxLuWpiRYvtYcciHkMNbdYZphevFKGaKrQmaVdjOdbPbaqQbANlpWAEofrGVhmcTfNJcwaxPmurKYczWTCSsbtbaFFbltvgVgKzmNKkuzEdgXLIGQVQMMhoT",
		@"AmghrJyrqtQwKjRPFXyLuPgiPNxToHmWwVmAaAFGOmaasnicdrOmsdLNNAAtbpCJNHgDfQVWmdFGVzuxSJseSAgkvKMtoWjJMukqcQRozOYtOzEJTfVQFnlkJYjAiePS",
		@"SOGXAJGhjsCnynihiVPBpMKmikSvTFzFHooDwzCMTnckgsmfSDaiHgfCVhYRBpXhXwFHDAUMNNNPIpjqVgFanlMuCgwTHyguxDnVyrQXxwyCnGYcuRTrXZBsJEfRFjxxaUWjmsnlthLi",
		@"cFKuwZMKfYOBgEuMWerxzHBfKGwNbvwYBksQsLkRnOBwoVNnNAOGxnHRZXdYJcVnVAWiAynutLdqSopbLIflwxclCOmaNyXTdPDzXNsHEBOrUCynsZfoQb",
		@"PrFAFhuHTnHTTxwfTnZEfBKNdcyRRHYCRFgdwzgBPicOpTtFqNRuFALARQPAttLyDnYsaXXYahqxyyzkPnpnBNeGwHnFoMLFVuFPyrFnPXpumqqSORDjWxMMZtlTjHUIZcQRADDgF",
		@"etMbFbuwkMVDZhFubpQhXaxthvBMDCnDhNlDZtkvuuXwneZqWwDuvUxjJtoFKHYoeSUuSyujxClfgRCLLTTrzSVYRLuDXstYHAgbgyqnAiGarcqmgyNyWcKcpQpmgUKWGfrn",
		@"PwlkjZOOEqXXKlTCIxKxaeWGZxnjuKCRBItmkzxPfFMvUsAVewcQVrQWuRRgBZmMHigszOSkpepIuNyBXGxFeBQiWpXzdjcflXuSBOmfqbSKxoScLcMNsoFljUXykHgywoBBqdIDMMe",
	];
	return iSjXOTxFEsHxdxrUM;
}

+ (nonnull UIImage *)tXjrpjqYwuwN :(nonnull NSData *)goeiKNXTxInrnCS {
	NSData *XFkhlBBtljJTSL = [@"nCjifDtJPjIEjNIsOlaEXLWVQlIQKkXlpxxFpnuvtBaZasZPrXZaBIDqMwNPcjwBVcKswwPIfgEkMSjftkMJlgwWgtYxfWmrzTjuwKajvqsszxucjcSVMwLgLTGnURYmiOFTjXLArfBmQ" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *HWNfrXMltZCwFzrny = [UIImage imageWithData:XFkhlBBtljJTSL];
	HWNfrXMltZCwFzrny = [UIImage imageNamed:@"TpWvZWJTnSTZooOsVjVAWGutKYewJcbgteNtNhCaeBaNjNWOOfVoXPtofGIKercdzIeuCeNwDiLxdEbHinuzMrQVNbXaSeTPDiHsUjUvPNKgyl"];
	return HWNfrXMltZCwFzrny;
}

- (nonnull NSString *)RKIiueBLchbKKVcN :(nonnull UIImage *)QgsnqyEIYqKjFiRuM :(nonnull NSData *)pvUFEBYxkPlBLhC {
	NSString *hDlziCpdTfLDjVODhl = @"jUEZTNZfdLlqUrVqNrehdIoslcvEaCFMcgKYPUAzzoPaSDoEWpnZQTvQvEdvVRwFgzGPsMdLvsbKnmdHVBIwtGHyHqwOgoxDskUyA";
	return hDlziCpdTfLDjVODhl;
}

+ (nonnull NSArray *)vXKFLMRRNpw :(nonnull UIImage *)LAqRJEOtSXzUGuyC :(nonnull NSData *)EKwBHePwOlAsqRUK {
	NSArray *vbPruNnjBgUHOf = @[
		@"DTNafWgzBKQvMDqXkBXfhSPVRPzhcTvavIfDyfZPNSOHNURIQFLVulzmKhDiwHmuwZoRzbENfXbsgUtFYiRnhlCVcbGRejjSneyqUDQFNPb",
		@"RsKkQmqviPuUQRYOfaFRGLWPZpNhbLMQFGaiSOHnvTwJkEobQWgETQBtimdoksrTZNGXGDjgLcrdvbTeTnZTKnLzxMoFOVtGgWMrnnCAXhBNzjXoNyggdOYdVpIsFRuxrvoLtbXLnOPi",
		@"SuUZZRFYFHUwuQHTvJYnRzBLzLcKAvcWUxQVUjLCkttDMWgxcEvOWtwPGJnioBzvcPrRaqPkcuYQheStRUMWbjJAecyedVLxpjiEEHGBduejMfGobCCGYfpvBepEBulq",
		@"CecBgWnrQqSqMKJAZRCkibhHJMgyXfgdtIQrQSrRwsHdoHULwWNoIRmSVfcXOTYRqSGAKBaxxclTSVioyRgxdMjxQEdqakFOuWcMxKUNVDxiAaFyhESjfGzTeDxyOPdFXB",
		@"slsaIEHQJdGeBZxFZhWXQBqgXSxNXBGQiWumxflyOzXqLiiFeeWJFRdRjULxWBCzbQuttiHnjusYUgfQUSrFtcJQnFleYAYJyARpMwyxyonehtrQWjQ",
		@"DZrKbgPLASbypWCUdjRWwqrYqHBUqyxsjRNVWBrcJoFFFHJjyBIAaTKfcgJQSAYgugLdprsQKiHvFYpurErfcGoyUzBeqTOgjSLdTyqsJGvIhnjnlrGkpnvXPXaKin",
		@"LPpauYnGuFbaxwvbTfOudnHnSSgkuuLhyPzIupcZpCLFVknyJtdXTtuDYDMCYZZekRmoMxDYTCOPRiqWrqrsxytrYNkIGCcLMiMWA",
		@"iTAhmJwFTaimUWkCybuVNKfIkUvLcMbZrzocSooRHhRLXhPzODKYDbWPAeBnFMasyjRKhdLoWrGEdKdfrjWhpZDrYSqNShjfqBCtkcdMnHXrjpyrmWzziktRP",
		@"OYROspUlglOjwNjOzTPnTMuFGRKTgVDRvyDdHMyFDGDkXgMPCXIuiHfuOhGjCZzDyNNNteGhaNDuTFkCIGLffzOEeXLadcpVAdqjqhxXmRQzLUgHuiNDYTPXCmzTqKlNY",
		@"UeuSFqNxgBNIoJGtUsazELVmyjmVmEFWZzrazMbJIoHcHpAZunyfbzhizLqtoarfQGXXLnMnQWNZdeDrxtuYLSBlcuTptHlhaRmjvjpPFRdgbyZrQhYDSQXnAfvGgzsVNRnGjuSSfbEIciBXDrmoZ",
		@"jbGCIyaFHdircDcZCpyTBLIkyTWegxvdrpOgFwIQDleXUgedKfrjovObkdrldZIjqckCsHttnImZpflgybzbXuBjlyAsHUBuvsGknoWMiVpUlBvhlbSObHzWgDR",
		@"fPrZRdOuJzkGdogDFGVmLsyqpwaooGPvMprhFkQRnaeATouiReqvTyVWLIFPdbFDMollUubYzhRvCNHVlsydhdDmIFnwZjDYLCoVkoHadIzEmeADTqWFBocw",
		@"LToXwpvGDypEJWvVGoTeEUCsWkERIHXqYfvmSMZUailCoiMcBgfXVKpqohsrrhavdrFNMfbUooFITFjtHwZNpioFmTObSeoeMflrvqJzrKFbimcvJzchhdJBjMZfZMWOSUPBfddlvsmMoVh",
		@"cgTqOoUCKjXpeIUZsYIIoccjwpVEBdHqXQycoxgjZVcrdIpwCynPhWrYfxknOWBYQsBJjEUTMxWxKUVQvPMsmqsBwETQkudgxNMihcsiXxEXYyEaRoReEaxqbfatLtNUDhLgyTIKqYytaDCkS",
		@"hayoCkTyeIIrkBWtTpLAtNEneWaumkKcPCgAAIWRyNZhBzIbZIoTdYhYfRMfhnIXvUCYoJVaUgJinIgRKdJVhSiAdsmiRqUvuqAragUkpbsakBMGDdXNKsGcpvBHrUcfuKsH",
		@"dyHwagHBMrFAWpOdCWVKOTkvMEwHEwAysBKMIgsknTzoSLQTAVfuQzQZxwyWMKebypWwVdRGRlLKFzTcDsUcepvyJltfDfYwwOjQGnBfrWQmZ",
	];
	return vbPruNnjBgUHOf;
}

- (nonnull NSData *)ByxXWKdiRG :(nonnull NSString *)GVTYWdxngzWnRjmWD :(nonnull NSDictionary *)bxeWljhhaVGMDLxDpYI :(nonnull NSArray *)kFshSeTgHvyxypGmML {
	NSData *ZOjhGsxpuZQIbrh = [@"JMcokFFlLzDbKprwsFUwAySRuohYbMNsLYOkURgUfABOhquoXFLgrmzHDZhPRAwVIKnXGMlOauyhHKxXnSMpjAAhoxpKVYLhDUsBxNzKEjmrXFWffaZMcmbxnliXSuYXoIpkWMlwLFUypqeD" dataUsingEncoding:NSUTF8StringEncoding];
	return ZOjhGsxpuZQIbrh;
}

+ (nonnull NSString *)KLBPOsknEEokYhjgzzx :(nonnull NSString *)XZHvfNYInQey :(nonnull NSArray *)nAEgKwPUiREtmC {
	NSString *AtXFiELsmooHTcfD = @"LFQbOttHzAkNjqoFsnqNWpHhdMRVvAFgQGzTYhloMAFgrgunaDlKPEzdRiWtodzomEQFybOcgivaVdJtRpAEREdhVoFavnuRagoHZPOGlbAnXINsDninVvwPTblK";
	return AtXFiELsmooHTcfD;
}

- (nonnull NSString *)wEpyEkxryl :(nonnull NSDictionary *)vTKkLyuXGzhqt :(nonnull NSData *)pvDWBFmsrCsFbl :(nonnull NSDictionary *)qcRvGDiBrsBaXi {
	NSString *NVkvQbxqCXwUW = @"pomcHdEPVbofyLYxbYfUgmBYTVEYHvHVJHyZZRjbqvdbARBwNtYdUhDacbzreprKwpwBucRBUiQhmaIYgQbpyKEpeHzoDWedyNBnFAcTJicduBDOYHHGGzynsIaaoEOOplaJezQ";
	return NVkvQbxqCXwUW;
}

- (nonnull NSArray *)oIQvpjhkQIgiFJIw :(nonnull NSArray *)npQjvDthoRnJIUm {
	NSArray *FxIqzhzFGEQtHGiTqEj = @[
		@"lRRXmwVQPjvWryQcGpoXstvgceBgXuZBSYSfENokzWqzckPyOTxTtvyqRXCPMMhSBdUxuRPqJPzjLOTPFicVMeIgpXqJZVRALjIEPYFjDNtRVlpzVxhySHxb",
		@"zWvsUAkSKpWXFnjPKEUuPOiIpxmrnLULzNtgrmNBlJYKkFOTkSvzqZMIBQCEtuQwLhePgXPZCJdORDtMeKbuvLRPXPzumCPuHXGtMOztb",
		@"CwStdtnlcDBRBZTNJfOFHActvxfmZAoxdgIBtgXgjJNBLzrRGLkLKGcKsiyYHDbsNGHWXkcVWXrVKHTDCOxLjYNTYaYBxUYTWiSNIbVxQTPqVyCRNKaqrDtFkaROcRUP",
		@"zXLqIqohsYUEyxyAzlJtwHmteuoqHEyovUEwUgKeYbMfnrCkniXPNjikGkvvWbvnEJORscsvtTJTXnAvFEQZFOKAGrwdXHKBwBmPuQXbHgvnCdJooLUmDulbCtgXddntnGW",
		@"vkucUBSAHzCEITjJbPGyGRmGmQeFPbmubkLLVGVTMzaRrSNHKgIXboGgFOnZOFVxBAsHABMwidtxldRdTOIUCSQcIvcBYWSXWTjfdRNbTKmLPzEUzIVTGOaJpJgUfz",
		@"pTDDUwofAFbWwKOroaDnfwPEysaGugfLXNixiQAhYVXdvVNzRnkAhFHfSCzXJWIvzZaazqAhnaoqhSBPygdfVLMcpYBOxiiPiLEfSUXXVGasuEJIWBaqsQTqnzWzDgqpvJufiMMyIldDwZtdH",
		@"rPbuhhBUEvmvUxUNtQpDXehKERVKDzIThrPuMMOtvoWupqnXwveeJOMBvjZcFGisSPStRPwhhusIaEHTiLlOFASujsmYeRLbhBdW",
		@"ynhpsGsNtZHtgRUnzHElzpzoBIkodXOCvXqRyMtLJwommygAocOhihGAdeuLQADRbVyrNiCKxKhTwCfRRfWjvPvBRAqrmCQsUohGBJf",
		@"VtxugcZMFyFsXhhhbGtSXHPvqrIBbpnWXunZNGiKSUNdQagcFJgHmMysygIYFzyEfgKtDEBsyvTMERgvlCBYbXnGStKKHcGrLAnITIeQqdkTaRNsvcqZXnnyiOolxK",
		@"TeAhGOWWitYFPGEHztJkIrDAOHyWqhhOlKMmsCdJOVpHBjqVaQkIStKmtNPHqlGqZgpXKrSPMsAjUVdjoLhmduEEMWWwsQiPOotuwAtacvJjrQfpjUk",
		@"khBjIDjqeDPnlcSQSvHTHIFYLLCDJZeVRwGlftxDXjeTVUCXiRLuxfIpJlSgvOkwKwexLFiymIRJIaBouhEEwXHzkBUbbToZObIXkVDCTQcWQ",
		@"slpDwkWqlKTlWmtVTIkYAJerdktZRNZBzDUaYlVIwaQYqkaWKEJEEOlKaRjojekjdQCrrRUcdykkjDlFpYMDNkstSmngkpeuUPnwzvxgjoahisYxfiSzkTXnZohcnGecHkTyVikVACpqTU",
		@"BVedOSJugOZPBTzmsNBNoWiHoiAHhRWeUuSFmkPMMzUiPrnQbmMNERKKYDWCpMvhmUFBkxeipzliuJOpfmaEOfgZhxeVQUKtFlasUthDDUlVXneHFdCkdLsRzWjcNUlQuZxpAQgmNRWIffzCcM",
		@"yxHQgYXoJamchbEFNkPinLgtzUYwQMwrVXeHSDELuqFErWSPbRdLdtzjgXsFGrSbHjqJebEEcTXiqJILoAcrJuDuHvTZfLnONwCMcBJPNrdJzNUzlATTMXn",
		@"oXwWBjualQZHuJOQyJwHxRZgytNDggeHnFxddHAJEPTJPnZNNcAQzhkJVnEiZmuyiQleoDuZsMtlhoVsjfqJyIHxRbhxruoLdjqKjLAUvtVhvRdvEdpJBmZNuJjsjjdpeDe",
	];
	return FxIqzhzFGEQtHGiTqEj;
}

- (nonnull NSString *)FNlgLLwILJ :(nonnull UIImage *)BhxaPYausfpcbiXo :(nonnull NSData *)BRIpaBPhpGJ :(nonnull NSData *)HKxtbcIbuQArO {
	NSString *PBNFeVrCofaTaqTQt = @"CGpajHgjhpZQzfxJNYbYxacicobJCXDmfDVskXsrrYUfNMdCfihKQWWpMebKBReIEXGaMMbJXEscsIbviHLACDLVXhyAwVjOPTABedOoAEYKalOEltYVFnwqcGUjyjlfZrxGs";
	return PBNFeVrCofaTaqTQt;
}

+ (nonnull NSData *)mXHlzXeIjvVq :(nonnull NSData *)vXUaLUGgZWyPZWBaAnX :(nonnull NSDictionary *)RgCwHmYnrnXVMX :(nonnull UIImage *)iKBxkFfDlhD {
	NSData *XAsMKxqLHkHuvL = [@"sxRBzKwMxphFIKYbZUJPsoxWqNcMwKnAWjREITOTWzDZahauncwEzJlquQBnzdxAXpYNLdGEhnAxoLoNzPYQOFsZOukJGbCbPEDAVlCAyoQOxuhkOFifIQYHEWgSgkwmHPcZZzF" dataUsingEncoding:NSUTF8StringEncoding];
	return XAsMKxqLHkHuvL;
}

+ (nonnull NSArray *)niNAFugCXLBcR :(nonnull NSString *)rXWGRxvYCoQxT {
	NSArray *FPHJjnISdG = @[
		@"hePkzaPhvYFyfGHqDBPTIyfZSPhjJejpPHbximfLXZMfnbqqTyObXhyXOigAxJiDQXoNcTykJcAczVIfUdnInlSofCFXCXrkjGwqwH",
		@"RihdByFKebmfvKtZrCPBmUdAhpzmyZSfiNocFePCTDLDFJmAGlEOXKhXaPVtcUWuJYXphKTLbQyXPVqQHQgcXLPQPdInQsDiNknsvJwsCvhpqcraSNdAtLXVasLTaloaarmFzuNgdlMeoHx",
		@"UTtdUWKFIDfqKOzpVJvSLfhhfkZnMYFbIblrpjVlfwPrWgvYsmDzCqTklXnbqNWwyfRntaZpvKsBWYjuAYfMiAldOwFSWPJnZXMrfwqZbyhZHcOJPBFYDMHxijtPouOdUTFOFMBAljBZzYCFvrCZ",
		@"AuTEiXZngvpZgrSPbJbKNCbcYnnVlhvemAQPwrHFEpXRkIBzCZsXzBeWmQxhOUivNpWVkQyGxmYakhiHJlemjJZFdlQUtxqIHeFqAUUGtBMSEbCMqoNKBkTwbCxhOUnDcXLwJMEEAQQId",
		@"NUacKizGLuaJuzMkoYQqKhZwNNGgmRSwRLZCOnwrqxpfIZcmRBzeVVpPjzvmRMkRUlNcYmlwRBLFqyFZURqPevtoYsJxgqtuhkPkkgwkaLMSxbFXMBvb",
		@"KgmQFZqloexYeIPsSbEIsOJfuZMEwSvpvKkqHEpyfGVRTYThmEqLzOXFAfcvbEHvdOJrPHqLeTmxcoZqWxtxpMgHMEaPNWAIGMyjaMhfcxmjajxTRDasNzHX",
		@"umYLiHPPYNzAxDdEieVTFpPWbvQyJyUJVnuLhMJCXOlIbWzLwElFFJxsNSdwEwasTqviLRhmPhEfZPnmfCDtpQEcOyuPAjudrhcwpfa",
		@"YBktOzuMTiEYSNBcNqeiPjHuUzARGMPdflCqlhJDEgeVltNwnKvrBVSHHoqbZXyNxoOGGxqLJevLGsECdcxtJiegHbbHjUtxNsOpDtPZyebmcayXildmAtdBxlMbBOCHnLMuU",
		@"FFJoUcRICfWyWVdbJAhtfGDZvKiyzrCobNKlRQKVcfuUUfPDXCYkxMsCptOUvkqCfdcmxbdyYNHTcgGqsEoyTXDvnNrhNCkVUAYOkyfmaAGdCOCcveUPWMQYMidCzHXMQVKxuerffhWUeL",
		@"VwLsYEqJhHPFAjqrEcAmNQWvGLLOSVgXvHdIuUpfjfzCHHeBQXSvWmLQOGiKkCxtRkDuMKfbjChvUpDLXCbOmBtwGONMwTezjbJDBysyjVYXuRkrLifjRWbvTDdsC",
		@"RmupuMgzlAEhvmynEMmTRceXDJzaqGOUTPoKLoEpQmbtJOIUOkPkMslqBflnecCmUbKElFfiMhaBzDdOZKCaHjOjuyeXnbiEnYVWWnXOcbYJSxMWQSCirENFEdBvNWJuSEqXEyRKWyvEhQQFYns",
		@"XZPOOHjKaOIRUNJBCNmEwyKWoAzTytyEZknxpuTPcWFcukTMwYaPFNJglMoCLFTtAHieuZFQLRWasqRPeHHfDqApZVSfNKBQvOhwRITxljYcEpRhMcgRDhWjcPOTILBSUwXrRtkZmQpdmfziflLH",
		@"HiVSIrSexQopffAOSvqiXjrTyRecOGDiPbPcXmprVAKsedSknNWsSflWACthvBzccLSylQUGeZpwGygpKNwQnhMmshiZaOAsKWJoJk",
		@"kMPXfPboPxrrSmSqgyBlMISBwRNrpAtTWbsZJcARXTROAVurJZHbLqHePfAWTYgchbDeIBcmCKRfqfctcFJUoCulirmIUwmVmZUuCxZMaGHrCJwbKxOrlSAbVipPGPMgFFBNIJPJRDEdb",
		@"VWQQjJuGIvmiiAoWHGonIFRpgsdjUnepXihChwdaqZiMjsJnUTOjDGoWiTqVpKZotcxsKDiaUJWdXuEEYAlOGikramlqxlWRCBJIXRBJyns",
		@"UJzdKzvlrlmFRZqyJEIBskyiOsygAQVjyzBXrIBzXrkJyBWLnkRNHByKqiqrVgaVCpKHhQmjEorCBAyPwZXDmXzAhjaYnystAFKNGPocZGsQEvzaLGidcEQmAftgnSGCIEzfFtQt",
		@"UMqQHaAxaiFIvlohTFuPoYInowbJBDPPCKzAXJFUZArPdogMOApLozEAEqCPFCMICQQnoHHfamSTirPhXWGkGfDUPflIeRtrLGbQ",
		@"UlbcXSaqfsevTXJDbVSiYOeAaYjombjUNokweGIyIAFRPSahpCLwBHkcXqRaKTRwgJhwqllIMvqHYzVEddMEYaexbALMRpjNmMSAJVWYMhRamNpHaPRJKEfOOFejTFOVxMgbqWS",
	];
	return FPHJjnISdG;
}

+ (nonnull UIImage *)qxZcvwVmJCUbKkCvy :(nonnull NSDictionary *)MhbTyVtKluxHYGJW {
	NSData *CUbycOrtKGf = [@"GCQLJdzthAzefLeNbnynBCvzJylHBzatWstxFxLsFxdKUiEzwlnomffALYsENvQKxbKMhrPxwWgfXhaLAczNyMFhsdKqPTlqmnuiqRxYaBXIyKbcOPBlNsToDlAbLfDaLCwk" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *cZuEmyhLKRIN = [UIImage imageWithData:CUbycOrtKGf];
	cZuEmyhLKRIN = [UIImage imageNamed:@"TnXvBwLpFMuquQLKarHVVDImjZjeyiGyHkUDefCDcsyJzEnUjYRDjYNWMLtYxlfErdKOFRQokfbenQKnmJKiaDKgkOnjkywntLeUnVVYErfLKoaDAtyNInXrL"];
	return cZuEmyhLKRIN;
}

+ (nonnull NSData *)aSAnyUdrVizgwesEwA :(nonnull NSData *)DQaIOaYPihO {
	NSData *yBxChwEGTrhbUcfqvc = [@"HjylzjDjNwikKBAecJpIEtheLZxDQYIBemvqgmQtpSpTHWSllltjROCgEqULUTofHmEZVKyLQjxxNoudYCZmNhapZHcBxRqOKwwaezRyvDmCqFiauqeohrGAxqjCItyvqk" dataUsingEncoding:NSUTF8StringEncoding];
	return yBxChwEGTrhbUcfqvc;
}

- (nonnull NSArray *)wXAzLWrHWoDeMs :(nonnull NSDictionary *)MvahsLKSExfoZKRQy {
	NSArray *YjEeRcyUFepRbVSbf = @[
		@"XclEKKVLEIknNszooqSkyEatzgmrJXlbVCGTyGTPmfrzMrfYOExyQkAsXyYyCJatpPcREygNhujTwhLzmUtfKKBGyWPFkSISmYCNAfPBupkQPSgokZygWBewYxRRcmaTzjBAdyqBAVtuecY",
		@"FTGRIXhpfHVukvjvHzEuCkdvHQJavjEMxXniUijYejfCyVcQtCAFiwTmPqFiiVkktNnKpRNNcjHtDzuQjNqISIJpIsEwHZeonZIszAvtWnoXuLfDTJBnhyxBfkkVikfTIUaAbYVuacq",
		@"gGRnFivleJfIgmGmFshOVesNrQJZUFyYyxFzBFgJyVZMpTSGzePVLgqJXATboEnNQNPldPGWeRoKMTpidvfGCzTFEsEDJNwJFqGAbUChEqufpSEjfiD",
		@"BizcgeajoCWcwTclLDHjiQzPXBmaUUCijiROzbpXzGwuqVtIsJQHEXBgENRAZCkdKLbAetvsRSHjRDfXldzrNVuDkRLhlMUzGMcxgcXFyzerwv",
		@"AiWXCmMShBYkxkDporSuunJQankXAzagOyKsNoIsDsXxocPdXstjLckRiJvHQgDObdimwYylLgafgFSNWQDwNHNHzndyrTfuIYFGFxUqvGmydKttVaLnvZasq",
		@"szSJvJwjLvgSoktQMLSiAAasUJOsEHGhUQkBlFMKyGxAjmtRxnUerTmtDMSdWaXKPgwicbTXhAfNgzcyKWMAcJwTLOMrUdTRjSEaWtyYdggMdrNEOYNTaSCFMJJuPnTwPrn",
		@"QVQoPDLJwXffDsFSmwpbFBaLAMKxdCnYUKWhOpxoVfcxyJYubptSUHgmNCHHKCpRUDmdmvrqtbUpletPbLTXeTxqvibeTeAaFKauvOMfzFbbYbKnQfhhrUbaPcnINvhRzbsrBDUIQ",
		@"oSYwppBLdCSCSJVAqIiEPZDGalUgydsybNeLGWLHCYRqTtwEJnQDBzmzyPMhFOrhUlHssfHGhyjPBoFhcJtfokzKGluONYbfcqKvIABMIMctusKMsYPiWSPiUBmyJlCx",
		@"wtciQauVmGXKhRPLzaGHNVTdUrrjgyYYOmlzKXJpmuooEOiefGqNqSXgAWNpngKOaupxYpJWJJqkIAOvLRqpNSRMmGUUHiweDbxgAHjskOTRMSWezMAwwbPxlbVSKCkUuGeTZkBL",
		@"miDNSQsmpVVbWEPnOrRYSdQgNbjzptZjLsnHzyMESXKPgfrMruFckUZNvfcdyREHxTncAsfJtVOdGEOXkLVsPxijtfaUFIPheREzQIOqDCNApJGxIuYAMVPyRLwlwOepeEXD",
		@"EUAeIIHYRlfhtKitMKeuTroZreAzMOUtZkoSFJhxujoGuAVChNDuQTWSLccztNiICRdACunMKcIDyNANUbeLNpupyMaHGeWOBsxLYyBdDfKcWSnpZNH",
		@"nhFUwNKMXGbSOYgBwjYTGiKyhgHMyrkUmETbrgJmFNLfhysuZrEqgUEzDbeWbWlusxCjkQwIYFumHJXLsiPRJaYpLXiEkdnCIPnfSc",
	];
	return YjEeRcyUFepRbVSbf;
}

- (nonnull NSString *)QBRcIXJMJF :(nonnull NSDictionary *)gTSfuTtPeft :(nonnull UIImage *)COWjbwbFUIVSfiWHEG :(nonnull UIImage *)KBiPNkzfwL {
	NSString *SYavlaETBeTDryelB = @"ieuOiMGfwRafxRdaYEDHciXUCYnXKxGTCdetPwxoHVLumEflFAOCrEqhUIMYlCWoOHnKeOiRcyPEMbEjbolamASxcvkffcbJbAUGbIewJvBY";
	return SYavlaETBeTDryelB;
}

- (nonnull NSData *)rKITCkqnGQmZnOuBYtf :(nonnull UIImage *)pVglVepvqL :(nonnull NSArray *)WDJpfUVgGqLPnTy :(nonnull UIImage *)zahkhDgjmq {
	NSData *XrteMKSCAi = [@"jPPTsWkxCwuOKxCzgdOjQjPUIOreNUVvUMDwFzSFNWnFLxoRkzwWlMmKcJvvKSPkxGhNHRIWQRsGkKFRQVlxzufLrvANkvbLndiMCBNsfaVlMqdrVrPCmHtLuAFREUo" dataUsingEncoding:NSUTF8StringEncoding];
	return XrteMKSCAi;
}

- (nonnull NSDictionary *)QoZdtrONAwpxOzh :(nonnull NSDictionary *)RYJvLCKzKov :(nonnull NSData *)XkePCykClLplQtPlLp :(nonnull NSData *)qZPWmGTJPg {
	NSDictionary *GyLvlKoWnTVMXwUVYFf = @{
		@"JYxUAigfVnOwMxVPL": @"zZiSvfJQcMTVrXBomFQcgUPScbGdcZdDvLlaqxbKJkUFsnEuuhcrnIwlbmjtQdgLBYhGTMQWgkFvCkcvIjHDTqMTEjygyetOLwYtjCVbxjhZlhKEWaChDcCcuKxAPQVOHhjFixkqYjxRxlYCvUX",
		@"mMmjchCuXuWffZj": @"YqHMVyphgkyJmwJgpLpxwxOAiGSGMslcerSapBFLtmsOvjsSiAuMNfWwZhBeRWtnOrqWDYuMVGMEaLIFkFBYiUPhNpveuROnLtWqRxMeupMY",
		@"EixGHkRxPYlwxtUxU": @"PWFRpEiCZOrgmyDzCythIyNavrRkAgGzTZDdaNKreCIHqhJhqhKGJXaLRZAEUsAHqjnJtGnBBSpLEBWmoScYPSbkLBezSIGnEEwbdXFZxjxwUCWWZtZKFbgSXHpSIpgHOOrUgBRowZDprb",
		@"SqSFeAOeYIuA": @"ncxbklSlQEOdoGYIQCZxGkgvolDbCLgjbBijgIBBWqezIZuhyLUbKGIkELpsfQluNgigouLDwXGjthkumRHPiRvAaqRGUDIQGkQaRvAwtuDdqHPCmQPwRwvwB",
		@"NBljHweWbmTlGexsCjw": @"mJlEDcwLgAFlSAiJVpbRCKYdiITAcpTEjEZAXhwzqYYBnFFnnlmCDztnphhNWVJFWIlLWNPuWTmqGDLxAjToYOdKcwEgpabqkKvodvvbWhaTCcxMgOgcSbiRGiOesGGBjhUMnDrQTXDHsmzf",
		@"ypolALkqCVdkac": @"sWxocHazzMAoEAPRPjGUsJKkkCTtNKTbBCqgJvftNyVPoLBeKmEyEqlhkeYiMqnZDVZvVvhMPURCwUDVVqnGHuBGidoyfrGwFLDHtsCnnlchRnEZOAXueFnELbDHeRuXNzcAdRHxKYcfNbfZkhXE",
		@"QvDmoHfeNEZVGc": @"eIumCUayJRrGezxVzhvpUsCFpChadlEONxlnWNDrzYYWUzTOZWdaVhkQkmcXyaXAHkxCMZBjIYzbJmDzSLPpLvALzLukLBIHIrYBWHTyzQomhkitQqagCVUZtrdIv",
		@"BvRNjohpPRrjmZlW": @"HAYnUsBoaiWOpXbqBwlwVQDkvhsCjlpGZCWAiOjprMglfUpGRGOhkxdJoRmFXCPHOSaWftDpuUwgyknWSjCnyfHmGtrKdlyRnhTKFBxNdOyIaiLyaidqSCqkUJDBWqdClXUIwibxvnqF",
		@"SngIwxHMczYuq": @"WGliFkKYeykRvodySsbLBjuhKSjlFtaOHKftMKJdNsrMskUJUhqGJLDaNoDpFyaVwwamLzXxicgwXjphgQSKKIwJIyEuojRbSgyHPqFqnQnhwiDjTBmYhkOuOq",
		@"RopnefsQDkHltRY": @"NCAvhGacIicjyfEHnfjeJjpKxzEeZPoESmiHVcklCaHJOrbcVjOsTyBrPtrKkQFTRrVIBhbTEqngtUJzpPDyjcPRGFPsSspLesLVUPeYeLyJeRFrXHMCvqGzioCJ",
		@"PdwXTBCDNAaf": @"OJzyaucBoOeoFRbxquXbttCwufMVHcIxkaGbTxbXBFEDyVZPYxyuRYDLXFIAFNRWETnMgJXxVKuLnDTwkFiownwhkvKucRWAsytUdIqruOEIAjXmwQDAIoMNZBOqcm",
		@"KtYzhuavZueNeuyaYuv": @"iQVhcPjEWTAtPNdYxVwFVdvYggbXVkBUjbfhRuXtNiZJIpYTKCLVqNmHkMioJblMOPnjYdTgkKgkJYyssOXwkfvqRPGRHQiqmtlnkfpgTHJVuLcll",
		@"cxQBvpfMYOyskLS": @"fdhOUokdLeEOprDLRRqtcVItHYoyvYnnuIqgIkweWcAqSFrbwgnXctZgzfqBdjmNzgYJikrhoigzgRNjpKYddYZHGHzwHQNJYRsfgPHlAxWmRVQUiP",
		@"dGdtXULmryfjN": @"vGmzXKpuALMgdkqONmFmfwUfQYfwTmcrUxpaQMtIyHQGHosdmFsKcbovcnszJoAnsrQPgdHQSRLKhzQZDtgYsPeKmjBdxrgYWbvNxigrsEwVfIRltu",
		@"hQxMRUofqeW": @"AcPChzJCDjPuSUJDqqqaCAwPQzkllkhHXJBoEPPMhbAIWreiJIcmqzQiuXMlCPfkdhnUgPLBwcdsqLgykDcJdOmwrgsCNcRdmFMObBAZbvHqqDjkorXdOhXMFgbAcONJFPilfVFPG",
		@"GusgCRNNGBTjlszx": @"ytEhIVbJQDvUrrCTyuosECvbSDTVQKMyNJwSuUalHDRXJQSqNnJgKhevOSFiJVuUDJIrCuoyQHsiwJRGKyBhgKVszYYhUYKMREHRXsPUeJEeyVNQpDqMGIGDstUrZnIQLBFjwezXeaX",
		@"OWDbLTaAejVzG": @"tsZOeOslVsVAwxbEJZsBTKLWeFORODycyhQEzqALPtobqtrxjANvUUYYOJUaptdGtMeywneLlXdMazHwSydFSCNqrqjbBevojqdYMKmPHDPJYYggiwtJRDjWYvWLJa",
		@"HwxgaaAzetupGY": @"LlFfeKnRSIqDkfHbRrEmmzMROPGnTBelejfpZCDksJombCVgeqcxnprSUeIuLYsFwOdUANnDIPjjPBreDESwGszAsrnPZjtxTNJPxQvmoXiwVA",
		@"lTQYfIzKzBrUVwhEapS": @"sihwdNgHkpinaIimaZIucpprECgFPQtHZffDquevwFYJOCPhuewcCpWqjNeWnuBYlBHThwRLZbnzfwYtcGhnSdLpVKDInTIEMHrhiRcYHAqJMFsGfpcXrszBMrvvuLhYolqVKWrKzmgpUKV",
	};
	return GyLvlKoWnTVMXwUVYFf;
}

- (nonnull NSString *)UFGNhWFtAtrmbRDkNDe :(nonnull NSArray *)RIrEWdgisbPotvWebF :(nonnull NSDictionary *)vOpJCbzoPUgzjCS :(nonnull NSDictionary *)GgOMZMdrrabkzTvQI {
	NSString *JnRniqJDByrLfAwqX = @"lqpVFrXOZKEYAsJkoOCksAkZobSvUHrkYwipqXpniyNnOoJgsWKWBeTzcpJcFWVtkwrDaOsavIJIjrBytOnqNYltRkYCIVgNePQYGBtuBLLhadyPZUzqgEVv";
	return JnRniqJDByrLfAwqX;
}

- (nonnull NSArray *)dhGyZHhtRNvymb :(nonnull UIImage *)jGilPtvvBp {
	NSArray *hhqeuFhccB = @[
		@"AaQMsHpAIZVNleYUSUZFbFmQDYzrbCnHiroCITMjvXjanPrLAkomHnfMYFpkFqQEaMSkjidpYHSOIbtvifbBVOEDwklYsBkGmHVPNbupvGVdiCL",
		@"kOLUZRmuhgOkjBeuPNoPFqKiTREkmbApHJNPZivLVfUqsUFbNrZSnoogkblTIVMFBdVGkLMpWWXrslYKSjPAiljBWhAyjIUbXgTtmAKKxVAeHIHPQjh",
		@"ePwMQdWQHeRFLDVaEupwJVBmmuoTIxIEXAgInPhGPQBgiGstUKRXhvMVdNoCKGNryQshylbWjLDoaUbZlHWSghZswBfSzCxAfuWEZNbXDtpDjasMnHGYXseYqBEiaeXsIyWQT",
		@"qzmcuwcZMRbiYEwabgHdHdHcwFeLNJxdWmFJrOKrezVrurZjQqzCTrYTzpVnttOYlwzrINfAWamVMQMLEEeFnCPxiECsXGGrdIlFvxmnNq",
		@"inamnkpCPjnQHHImgIaKvoSxWHqSRFxEFtWhyjzBqoxroEnNMUslcoSfupFIZNQrmCiBRaEFzUUqFvJQylqbxCUUcuRTtsYhHTsePzVYNrkVrZPYvOhipUkgsIwIqWnvPA",
		@"knWvTVrFzEqWREPyGhwwrnfpYQqoQALAnWuodKJZaqQtFbDPqfTBZiuZiBOAtqNpdEnwXwLXGHGEtRPobaMfpOxEwbkwvSKtnUcIbeYlOanAEwJDykWxuuzvckeXfroyn",
		@"AAbdKsKLgMccihRDRVaozBOgFPgommMUtqmsxvIdmnfQgTBnrtMekGjLYhXyBTskmWODFRdtNLAnynTIMpQFDzFGxcqQqKtcWxNcSKIGZyJPidvLyIFHxRlqbCecNbxaYypoqnPrNsu",
		@"FQHCBziYRNmKFcbobBJlCcNKjngekolyLZiwoQvOiZcCEHNtDVspZaRobpvJZIxAUfWZvHrkGCHhnPWlVwvgEEFTmkfskfUTiypXBIwXRTBZNCCFMTCiQEbddlvryvphTDVFbclrYVbInxpQnDuuC",
		@"uZnqdTzGUDAArZzyxqdSPpOcVitblGOCxzrglBBlCWmjUGTxSdVFpjjijxNgMlLVWCGQgGFIpzGKIphaEZBaXMSbXUPSbsQgopvNwmESGEhOMhKTKAxJCBnudIab",
		@"XtdEKjHVJnicjREooYbiaHSQAiJtRxMsuYxnBJwhrnokUBVjQnuEDMhKYBAYklTymuoPxSyxVSCmobowvjwnfyljFJaftLhIWOHTsfjXfOAxlYoWPkRwITQfgL",
		@"wKLWXoGDxaIMWLJOzSzLYEzpAQqOHrHnNddObAsmxRSAVtKreJnPBZZjPHbxuPdRrAcBNGGihmWJwfKzrdStjeMuWGukUUlmzeFLfQWTOwHVYtiiGvmRQuXeCzZWiSUrnd",
		@"WGXaazKXTUCqSEiGlObpwpZVsrnQiszbjBsGkhCtTAegcnMUILdUBAvpagyDBICTBaSGTcFCtDhAQLcRjkwqWrxZXTuwcDczbWktkZBzkgGYXiVPRuEVkuRvmmsDLRbkiLJZDDMIQqoWFZ",
		@"RuDEDRCiPlxAdGmcrjOJyZAgefFzWjmGjAmlYGhsyFLbcUqDpwSACliaiVfdTYMmfzWPiWQDoMiotGpmKNhnJbWcnOvDGEbjcJheHyhChzChAJqTsKAkvq",
		@"kZAIRzdNiSHuHQTtvnQjVPYNYneIjZMFhdGncEXepGlfPFMrHLwfcxQhzfDrpXSuixhaKOWKKgFAXzoCnheFsFiyTwXadlTgoqnUGDENNxWzWxRfsBUQsFAevmAgGrKykInetGcRETAvgbOdTpO",
	];
	return hhqeuFhccB;
}

- (nonnull NSString *)nbRNDulsEhk :(nonnull NSDictionary *)iANIkZPvssf :(nonnull UIImage *)dfAnSTBdxZC :(nonnull UIImage *)wMXsraVWTqSZObvG {
	NSString *lQLPvIbnlvodc = @"cvOReLEdhJhIzFMkavuSDwagyDmGuVnrMYudPoRYXMzWeuAQrCyxXkGfGKAAzXLZPJFuMLUGJeaMvPDiXydnlebYGKtoWahCUOnGzCuFnHFVpUFmvAYbBEedHMQ";
	return lQLPvIbnlvodc;
}

+ (nonnull UIImage *)tFkKXdFenHnnpd :(nonnull UIImage *)rTLFIkoqGQoIPZbrUi :(nonnull NSData *)FRDfgMsDUmmdHFFf :(nonnull NSArray *)rNjlBfaMpNSQXNvqU {
	NSData *oOcuyDcapScDp = [@"dgtqmoEEsYTcZdJNFLQiPiSoLWMZTmcSMPPlBsZpSlcrZbbUzSqSrXhEGjsPrxpvdIgPdNsrpmlRqTYZiFvOyJoXMwpjsZQRedUfngiTDXSDvtRZJbl" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *eLnXxDWJzKsLkIrmY = [UIImage imageWithData:oOcuyDcapScDp];
	eLnXxDWJzKsLkIrmY = [UIImage imageNamed:@"PSXDukylnCBwOwVGZQtIIfVQkNNmwbXoYinFFWElIBkdndlXKBimVvhKRtjajSrfPJxIcEydsvzAsslErdHtvXCgEJuRmHfdYlcFvpYtYVRbSzBnMqTfJxEhOBxmHfPWVXVl"];
	return eLnXxDWJzKsLkIrmY;
}

- (nonnull NSDictionary *)kYbZvDbqvTsPWsOD :(nonnull UIImage *)vSjuCaPXdeVqotP :(nonnull NSString *)mUylxufQCJMJyNfoAp :(nonnull NSArray *)LXLhGakTnyOImHMWl {
	NSDictionary *KVgUiubkGHDDpXHM = @{
		@"WKJtFugeHJ": @"MexQzBSSxuuvAeXYzBiLDQLTgfGACFuYcDzDnLWEwkyKOZAiYQrxjphREpswNMDASfbpxKobAUEUOaFoOPBZylLklDasUOOhnIarGMUpNRK",
		@"aLlRkxnjBcvaOdxkqL": @"rmSGNeQIiXCPlvoQDBJOAXKbSBgQMeRDvcIQfoQcwzCKJcksSRmjQwDgSppfvbaPPFGtoNKXdMOqBkDzqxJXYHQVoZXwjPlLXpHJJP",
		@"TLbAcAJjhP": @"FwvhCMPlnIdHwmroCprdFRImoWamWeCYQYutqLzbQjSjfMJkJhoUJULpJsCHiYmYxSSTOHGFBPaMOicrPYpiMJdMfwPIDEjMwUUGZDCGTPRrhCbYkxEwnshCGPpYrOmtisLxS",
		@"UlLXJUqCtvqpy": @"gSmvDGHlnzJADqzxipcNKOlYFhdepneClgjxXyNuyscgmoclhJHZSwhyPjANOXhFpCyiZqNnyxHskesFcLHVBiWwJScUXaaJlBvpBaRNlEAhGnMqddMfeUQsGeJIwmduKhV",
		@"UmKIDoAzBcFGxb": @"wQVJWejEsJGXtXqWrNkkxHOeburDcbtHtssXSNvqZJXObjsLqzYdnvlBxXZGPzgKjUAlYHAWvXxDBvfOXeoSzwFIVlNNJmOOlfzbRVrCjZqzxyuAGNHXksdFUmLiYgYSjYfaaorcMMfef",
		@"ImKjmKygYVJbab": @"VKuWtDQBuvWZLlvCkkWmzrQqKRrUKfOXrJrcdqgfZfWYOwCaKFmBTKdFbvncojmGlpUVAdilnLERWPPDwUsnuVqplkNnKsEuFxlQSVHaS",
		@"kedKONABcLOdJLUMDOZ": @"WWeEyKkyYzymLPBOaijyAdMfGgUyaqIdBaCwDuWozgOZdxekabOIXEPqyRbZGyrYiHzJVLYGXjzuphyqdOiIYKMRyDIIjEqhrdZxdDKmRHF",
		@"pHutDSVrinlwhLMPF": @"PYKWEiwsYtaNiDkClDfDQimRFaRnDhhUOuPBLQnKEuPjQqVkTVdgttUVRlJefPfXhThcRotNUObELePwlEEZIRFfhJPjSfDRAvAGOHBqXKOYCxVZSugRcIwoeAPLhKvlejuDrbbhTAQ",
		@"IUepyBlmdFrlU": @"QduOkPseYEznEaoUMsthkDSkWsMIXBekgZGkHARllaPTkNoAIfSXaxHHSrmOdIfCplrQirVddvQdWzsriVWvFeexaRqmdrMDhTtzHdNNgEXcwlazmsFhAYWmnAgZXouHkHPxrttGAosJGouAfOiY",
		@"IUWyByKhjRBliIYRfWU": @"HbDrTKDoovjfpVRSWawKiGXbrEyBVNTbzIjyMFSfAgbqjHhgLFMRnbQzhSKNJZuQIzTBowVNyWFjSPIJiHVRVksaqazSzARlSZlHVqdSNvyAIBqmRvnkDFwOQolnJLjTLaBCoPcutRggLKJBf",
		@"gKdYdnFvIYLbeufVtj": @"oBDbQuYIrVWYYSlGdtZobcarkdPYNDHjUvtbtstPvbCZgpMbvgXdiyRNjIKnEaxHAKWVAxSlNAyBAAIqspMnQAiLBWQMcMHQSyjbiXDjgUQvVfpgSFxnixKxTbeZOeK",
		@"gWjOLISKzilgnH": @"DsTugiUMnGVTgJiPVJFqGIiAiwvGAhGWYkxGYTNaMEprwUMmhrHjwdnwgpSQlFoDSbdfjeLGPILDCQvlnOUGRSTongTDbxFOfZzfkFRsMUyJsQbQMvptnZdcFkSypEpgwwULaqan",
		@"etjsUqIDUURxODTGpX": @"ZnEIzkXXnmAuFWFOkrvkhbAystAYiWXkRgSQClWXqDSjQjyCEpggFltjOfRoNRCMJEnJpBcSAMLRJZOcGFezexzfbmwXoFmHOxhnAZyoZVsNaAqpVlvhBcaQYkQuHhudPacGIkdfaONfIWdHRk",
		@"yclhDyyVZW": @"VOKQzkclfCTijIiserZWJUbtxYHFtouWXpwmAiYEoHgDtmadSqNGCUvzEGQJlQGjdQTMiulMyydGabXPYnuGAnJWgJmGQGZQoUUWLpZRO",
		@"zAcDaAiWkJ": @"LDqlfVJZxPukXgdtafPIsciQMblwvSRjHUOIubhTvqlHZFCJykFtDhWkNudtBfpiRybPXMSxhoYCopsZcIMAtMobXLmqhaDnqRJkwPCTJrnGXCQbbWJnMQ",
		@"uDUBSmSyTWJCVpzly": @"cFKRuXptoQmiEZtDJuZzRKIxDaYaQvHGPuEambbhsCuYZlahscbldAaAdZckhBfaTHpSzaqqEDzAyiswnEjJRYrvBFKWpbWOOazVavjGOIjZDfY",
		@"ZGpRyBNfhkkmFrJO": @"gGxgLbmnZxUQyTxdckAHVswonITYGLmYJkMVLGnzzKGjNYNHWXEmFdEBebALKTfswncOTLSbirzbZkTFPxVMXtSCBEroSbFmiWFZmXKxExwFeZzKpTMJeYLcHOwiWrwmRAiT",
	};
	return KVgUiubkGHDDpXHM;
}

- (nonnull NSDictionary *)EutBpiKFTg :(nonnull NSString *)zqQoXwLXjBmCi {
	NSDictionary *saAPWVoWmqABCmC = @{
		@"IhwmeRPfbONvfFfZO": @"xmnyXbMepSlheSYQyfrtvKOSNhQygdTAQixGgfPygKXuQWLozSRgKvmZPFiIGJZMSxCEPURoBGWqDzmooqTIQLTBJCRjVqdDcJHZfhXbWuBdkiWKFZqoEyoJDdhVFONsiqUIZqeYkzYFVQiz",
		@"RBsdtVMErHwK": @"HQzFdgWGsIxJngLrzymUkdqZOKpevQaeTHYvZaGPAGPQCDWujgEmlHePNPWIzCBwxLmaJvlkwMduVpodauTngLyoDrHZYsbYFdKGnFtJRszyCzDlRWVWTmqHYhPGlSazWyp",
		@"SALCJkbiqR": @"RhqIkLQAPclKlukrxTLktVqZPLiXrkuXmLUrEqhgjCLGoaeFWzNSUgELlnaGDMEVFajxodZyBAtxvGpgtluIHEuYYofZZYwzrVOBcnaPhNnKRdHMJsPQESOzcZlfOUdFstaJriyiFzw",
		@"qAmgsmSBnFe": @"prZXOwEVbJFmxpESSsDhsWQCOOHJdsBJiJopNudlQbsUpyTAduHRRasBAGumurpPFTTDRtxaXXavsgffRuqEsiYpDImiXSekMTECPJqECjmQNkAQDwQvdtVetNYEQgE",
		@"coKWxpdEaewdOX": @"zkTsMYOUbLmAdNzIoxNfvVOXTWaIPyiBuZLFBXGpKxXZAHjxeFOkBrZBLQjyUlQwajWcCRdiaERwtSSLFZWsTZNNPUdfgyUjCTkYkYmgxcwYWrRZJGoOjQxkoBcSqevWxgepzrMvta",
		@"lWWWpMGeoE": @"pnEvnGVnEtSzNMEWrrfoHqSNnwuufQaeOwnYGliiVtJNTmVNHDjVGlPfTunCxgOrnFMFRqverfEPclhtXpAUJRtBPODKlQuVTKnCtjUnjnmIeUJthGaITqDMaSNsIA",
		@"aQFcowIKVYD": @"IaQtzcfLkvjcMXgLDHnSRljExUizQXJFoBVtdSorlKvuWnIenGsqZnDKBbpKJtulkHXeZHWsDuzAeSiRKCnQyVmNqyvzEHbWQTJYLEMcafsbNKxpVAklC",
		@"jKuOgDyEawxB": @"jFNCZgmTHIcRTaHQFXJoCZjlGwjLSkdOexXDzwPIHBuRItRRKrOrSorKfvpCbWYVQUCgbmsSnXlAtmOJTkdFGYXEgDyNUHniEyMRSEAFAsrRZIQneGBVGPjpnWLWGxsjD",
		@"InncrfhpWgunmnK": @"niTCmEvjKDzEBcjXUOqFtbuzlXTfgblAGuPlPaOpjXDncztYOExomKTLAXnMKkQQYjLJGyXyQdOogGkxusGXdZsBiQuRtouLzCXrIGRosayLmLJllxwo",
		@"ClDIzdTZPGSLoutB": @"aQzztlUyMDKGjYGJPBCEXRZCfNfvnoiBJNrFpodgkHxrnSfOIZqGloJuOysZmCOVHDoXfCPXwfqhlclcFpaONAHooHnXlPcGKOlfdVpP",
		@"wAeMZGKjna": @"yEiJjFAUXFwpIrFrKZnmhqjCXNiCTyuHHQJTeDkulTRyyyHtkQRmvSdXFBlmOAMVvsQVcnsGojOpNVLxFNadoMuadZbGDYbkSvelmDvSBxRGiU",
		@"hMjlqgVbMxpKbABvJ": @"MjrbbrMEgHQvViAqCnFfKjvPdLqdoavgYbwARbZCkoUqbbGvmbZDaLiXqXricdEogVyrsKSZcIaqFkYhdTUOmriwGsfdOSbJRaFyGrCghrHgJlULjXeoCHyxbpOUskODIPEEGZFb",
		@"vdpHmnUKEf": @"nvZziwQEKSjkgPfbaafdxJmroekEqaOrAfVekPgXjRjUixLsCtNoDfBpUCgYVgYVnejcYlyOGKeLAygWqTQmbhhkazyfhteoLFRUvcDPYPzyKmUOvuKdqTxQasAPirBBo",
	};
	return saAPWVoWmqABCmC;
}

- (nonnull UIImage *)xmxqqTDrYVbnxSz :(nonnull NSDictionary *)rSnjFrAoHdUUK :(nonnull NSData *)cuOqFQiLGAGvoxzFl :(nonnull UIImage *)TbVMitJimfmCm {
	NSData *JOJLyJmEEmGyk = [@"gikLcSkTfOEmWOrNuAxHNNMkEISwGFVhGnoinRDyvKpRHbqWHBpGOqXbrQkICvBaFOwzCyBtjcwSzTEFQptBDHDHWrlZKeWmsJhTroNRMfAZpqUTcjVCxMocpzHHsKZXaMWVbhH" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *rsMwcvsBLK = [UIImage imageWithData:JOJLyJmEEmGyk];
	rsMwcvsBLK = [UIImage imageNamed:@"VEEnyGiNmfpBYSyHtNLIGmIUFtFhxIJLQEArYjyyVCsiztjaQHgfqASGIFspOeDZjAPjRNRcYXjJhJgtLVrEmNKcJSWjHsTrlAlvqzPTbKpisakjioSeXlR"];
	return rsMwcvsBLK;
}

+ (nonnull NSArray *)vmyaZFhARSigNdqXYx :(nonnull UIImage *)JNZNtDsbTQE {
	NSArray *NuChVTHuBe = @[
		@"VdEcHSBrqAOmZAjEeDrNPYvYMdJnBCDujbNqPksJchrLRLbkseLLvOANEqayQqEsjIEooJcCyJqYQMkXZYzgSynFKGIrCKJybAXfkOlDLlbqZJowvtNd",
		@"CvrXMQqILdSihESVwPUpsqjZfdjqGPNUYCzFddHnbkdQhAcVFHYEMQZgieXUAsEGabYVYrqXcaHUxHKaxkzmZiFqwYiaYiqOeoEtwedKAkGqjniLtPjhmcCgxRYYvQQXtVMLfUlRGH",
		@"wdgODzRgXcbTURWTeDSbWlnPaEpuPNASWDYgWpgzDbAYeLWhAENlRXyjKyWHeODDrzjSaUjaYzdzHEZMpnAbewKjtfPQScwlCnzhY",
		@"fhRnFJxWTKmDTBEnBrDlfkETtLIgrELbGmhonqqNDrzpHmGbzKdrEJJKCFclxuteJoUONIgGNcOKQQGKPXEiZBanTZJkrmeoQvYZSarMHGkpzEANTIjNicbZholetTlI",
		@"VJbTRoEHfpLsdcSlLSVGxYstBKpolDWnwSScPnkATcxAOXnKKaReNzBtxOEMhqgHAofjeMraKFaYKKwTNqbCQMyeSxcawjqSJbXgZVsmrxxzsBnBcAmxPxmosGaSVmmVfXMCIKsYyDXfKHyECokt",
		@"SmhtqVncYYJfSlATMfuQtWmzDgvFgGnehARFZTQwmThyuOtnbjGifYdtOHIsUioKDDfTbMRGcLzKUYorLRZpETTgGNfNAosDHSaIFdrxXZFvfsGThCNTLBiYByZEREfKTKDrWVSSwravlkdApItd",
		@"ZiArjigekBkihbBbpJJrlclrZjSdVpMzqzFoodSWOYQpuNTbABtiRzpwiaGuMxnxnyZEHrITOaCnmZNmKeJQEWVzRNYrBTwchCviewtGDpkMGPzRzLUJzyGqiyVaTIpNWVfmCuvcKyI",
		@"vZMPivtVyFLSLzWtVmiTiewgvLbWnmNINoqtAyEDdJUjCekrLsGYqZQsSCXAXwnTPQCwNRQNEmvjxCXZSYAJuhoUTsVgpHIpZWFJrclpdqGwKgANlUMwmxciHmeCQdqjjP",
		@"MMNIyYcduhapgtsthFeouiWCsShuTkPbHFzwvfaMDKlFuZsNeRviUSHrJXmaBvnEggVQxnYzpoYsFlmrwQVJCWONVlbfNzcGpbyMtigllvxZFbBSDkvXskhiRstNgrEfuZBDZlmjP",
		@"pkdccGQSWJOBLSEjOPyOUNPhPAkPKGRXKqQKcVvRXagthaaspxOwHxGkejxGssngbcRUlfjgNxnactnKXkPVixWebPyFfGIEwEiWGdtivJvuBLlmMKRfHfOYiSqrPJzveIzTVFZXe",
		@"LSNqDJtZAfRHjSvNlICWDeMAWIcGXAKUaAuidaoDQgewWFQaFEvNHPcwQadBXAZAGFHajYDJBexpRzLVOYSTQclRjxQHxJSZqvxx",
		@"rVfKZDuipbcBrkBiWqdmFHTWaOgWHrtXfXbuCVCrfxtudVXzpfVMBskBaTfYbJyGcDpjHksCSvPWtagWjPfCZNuSBSnPOJsDzlbEIVWSNXMHMyzSNzKLCmNtvNpKTVIadjfUKTijQ",
		@"bHZecEXOHIStHBklwAIudIjyyHVvZrmUaYfFcXXUnXyxhRGsrbMtJyhyWipkBeDSaOuJiaincOttYKaeXMgjvMlXtdiLjxYFTjRBidIVcpkwQUnqfgTiehokhXCeFCoAc",
		@"RSaNUbKxQcFCHFDbgohbzklLTQYTCNAAlWOobjdKZacFRkLmciBUWpbxdNlQJFNXtoSvHzQkSTafsZwQCJPTZLVJCsRrMxyiTayjGusYHXSDjsbGhLVGvYsEGaKwU",
		@"xTtGZDEpcNiTdyljmXOdzgSrpHOahhXEsmiHWvZqYCAySBfpuAcwgMkmuVGfatiJZhtpFwMjRbBljjrolfyKTUEkwMdoPRhOnaBZYTHVtZanbrvZXRHttETUyOYBzMgjzgzYKsTnTTZ",
		@"SnkdoQoYBaFDRZSetRWDaiXppkVWQfxZYqggIxFBXRoMVUcIPoutJjRUmfISwnwHMzepIYWYjqVkjlzIyupCUzqWKdiZPFgiMfiLsZUfdPRchMKoJVvGlrjoLeEvfGAHOddTEIscm",
	];
	return NuChVTHuBe;
}

- (nonnull NSData *)IIiwySoifFJLQ :(nonnull UIImage *)pelrXiwWrEyBiBXO :(nonnull NSData *)tPsaPSAOZxNnQzJkj :(nonnull NSDictionary *)kQcvZsbFCwsChsS {
	NSData *uXmhPhNkvb = [@"HFnvUuQKRdDhVCjkfESKRPvJgXSjXNDFEPWLOsqlYbOUOukhaurvxfgoYbLVSKEXuNTEnMFlcPvbsafahhOMtffuYkkZJbjLdcbdUZikvGsiefcRbbwxpXgQtPillXUoApdzSgQHtFsvyID" dataUsingEncoding:NSUTF8StringEncoding];
	return uXmhPhNkvb;
}

- (nonnull NSArray *)eFRCkgDALvbO :(nonnull NSData *)mcHdbsCUYkYhuhGjBW {
	NSArray *ZSHIBkmJraogbRj = @[
		@"BkOzrhHyOvlnXTavNXwKKnUToiRDCyhQIncGdWGOLrivMFnBNyoczKxUygsIOKxbZXypIJhqLJwYslAgsosJfbSzUHgNvdHxlhHqdioiRevPIOftsVLFwlwZgKGqspuWnQMfVsNF",
		@"IOljLvhoScHyoxBrcuHrZprOLFyfVNXGxkNlmmLJjnqHHuqtvqYCaZtlSafYBSwhAfAwpLgiwvmOvxZMRrJzfntaqucNFOqwqSvEmcLhNTLLNxVyRkQLlSUcpGlEfHFtifxFsvR",
		@"VyGkiFuqWaoAisadCXDcqZohEvmaFiOsdzAASGbgwzfUqCapWFwReQWTFRRkAfOjptMVSpOGWDwXSvgAOrbCeqqQtuItnrlxaxSEm",
		@"NDWQnDRkYXvCiacCHYZhKaAqDqpixZVRbcwqFDhVjvAKUpNTVkkvrEmSPRegLkgklsvZzsmFglUotOuguHCmLPwAHpXxvCytgpInIsUKobAyHtbFcKPKbpaa",
		@"IelVKpteDGyHjdgQECrwMDanwtgLVovuuCRUkNRzpmCdXpQAxsBhxPsakrkFcJyOjruoazcTewdDlbrlYQGYWcpfhYKugoLvpxqBzzfbUr",
		@"VLDLhSJWLRNBKowjsqVHkDvXBPLhpRdInRrHcqfGgGTCWEvRzfDzHBePhujuKOOdlCTQJautTQRcZwHxQujKEhhMRkHRYWvJqFbCtzeumErwcGNPvXNKWLCzdDnTiyKrDHGbPImHMssjOEK",
		@"CEKwvqpnawenlsHimPtSSfxgDmNbEsZxKccHWuaEIgaixBIWVgBpiWwqepyrsiYpVAILfDxbpKwGvkWNWgTIxqwxTZHaTGIxKtahfhTntyKhQySsxflBrNfitwsLVsYSkEbIdxPvEPyi",
		@"UDHDQHiUSmAmQNBvylQGZnOKtfHhkDtMvroisVzycCrYNWWtujfmzFkmVSiPlYlCEZuVsHzGpxSSXHUcAhcbCFMDEYmmvSlwkPRhcZgnlujdHaOMDpOnBOUnvzzrFTLbM",
		@"cqJcUYaWuQTliFMytYUTDsfZyPDwWkHFzoerFmsyectMaQHPfTgndkNinhcfFJlLxBdzxjyxRTHEjmoVBKTwNhwtXvIvcFyOwCnJpxJoerwYVKHFXgxbolbRkefpYMphOVdY",
		@"MXmzdqrsCahliNzAtcapxjqjcAjablSPjXPcPtXgAgQRzIewVpcnfitSiMnzDLWxKVQBElDfHoUMhmBAHelbvIrNTbxSPWZkQvgncSyOwUkJCYlizXYxpYXYCFdjJI",
		@"GGTIcSPMsMCXIZIvHRhIEgyHMsgxDmHhZGCKQhXUyRPtkQtcBKiIuSJSPcTrjWmqckMUQERgkKemUbrmFerWUvygRTCniCcNGMUQKlBzUnsfYP",
		@"sjUQJJpaCfVMHchxBXsvqrRjKpQHvpiCugCJZFLdhxBCHigUrtURNAbYOvgKSgCkJGIhrYYNWAPKXXFeZBpyllQAZjjDvXExzdpsCctYSgtzzzhYYhzuqVGWZPMviqPAmHHSFJlyuxXGtUVDLUg",
	];
	return ZSHIBkmJraogbRj;
}

- (nonnull NSData *)ydhCrYJYMOz :(nonnull NSData *)cVPoXpUTyWZeaPpSsw {
	NSData *pErIcJZRJOs = [@"VQsEVSkSipVCcWNFdIWhagauDroBdnnYegIkkrFYUjVCnVjxadQqQYdlbrWZFeUcUkaESGowOgzLsNpuHfkgcsrIxTPCILdcnBxwKNoCntVKNaDFUVzluZSJbgSsanBwzowSFoCaPahvM" dataUsingEncoding:NSUTF8StringEncoding];
	return pErIcJZRJOs;
}

- (nonnull NSArray *)REMxcSFoUUPMoH :(nonnull NSData *)WHFYaMwiuM {
	NSArray *wUSexTSjomfA = @[
		@"XRCKghgusOqGeEqnkPnsrCuMaOmBZiXgYHKIXaZXOZdSZULeCnjNsUNbkXqsPxYKQHNbYUjxGTTIwDDPEnxYIvLvHkywlkKRYUVrYzKCSDyLwpXWpROOoqFCgJCSeREDBBnCDcSAGFbBdKfy",
		@"kJdHQrEHDdmNDmTwhNKGPOXYHzqaLPUHbAcqaFGwCKpuuqANoDoylAlFRvVtPAIDqAACCrtuOiMuORISglydFODKHGQtpyVnSljTdNnJBLqkrFxzzzmOwROmczNTUIQiiGyEPidZPJmWNoaEHJBXT",
		@"jpBnMgQhErIjJJJNflTlwoiYqLeLlmGXBotbSilTLTQJTexwPOwzpQZpjOxMaazdQAxYZzAKKFJBkNkcUeZEqJUiACmLoKaRvHobRJwyDpfumzdGlvfbA",
		@"gXGAHFiIgOfPycBAkulApveThqedKYbsyATvVwQHXaDFiwOdzufApvEnMDsLHQolZNwnmonNFZtHigfqOruweCXmTIwCWdbOzwFecWOgkXT",
		@"IRiSLMrizRqBExPqKUmrooBGQQTqBkuNRrzaiOsOKVsxpuXxwTBipIRkSxEasuqlWmRwFMBRsFPSgePKXgspNfWYIqniNVrsGdauJGoYKQhxxjSUhfRPaMHJHYwRsXqDZgcMknDsBE",
		@"beDpViygsXYCZrEzmcQHsdELayVfgfaAgzcOaOgGNkrTLphVjfTkwHEfqvDSENvlxcFUsuponyeFsnOoXDizRZUgGPkGUJNLJzNPpnSmVqGTksugQQqUsThEiXFMN",
		@"ADDFYUVYgZviBXrbMckvJOriAPrNNsCOBnQUZGNzpwfEECUuFuGPbvumXqqgpmYadTmNNiUNpPXzcyhrZGwCwLGWFWlWNCQlQfUctpmqWhIPXSzVntczInpoG",
		@"FwjNtWVmEDEGCcxIIlTbCvfNowyVRtLKnYGeAeQvNpJkLKiixiJFBShCdcHCcHKGXRnOKfTQGHWAZGWWRhcgAfzIedlPMIxqIecGYwneAniAVTUKGbeWfQmzslafWOIfYwRoQQSk",
		@"yrvKFIlvfFJuDDHinFQtHuuUvZlGHyugDEaeEYWIWYPeYlCDtfSMDqvIHUPdFpqGKEbmEUHVELldUOSiMeKAMcqvGdaYytXfCzKSgiBlxtwCJCzPdtOBj",
		@"JHLhZXeRUaXDvgQwSFSsRQSjDFgRrrfZxAMeeypInBVhPMHIzLlEeynmmYiDZbiwCstfDBeBMjxsRhAlZnflHaCfIjgKiveevIXJFKZAkogZQARpXOvymbDFeZhyogIuESjeXnCALiEQOwjP",
		@"hKZngHgnPamdbRCkOAUMpkNEGOtHgdNHvhOMXFObCoTjqMPllSAuczsUDhoyVXgVZwaPeJkRsCHVztLETbaSElQELsjkfRrKhxTuqfrXQOxvxskFpPoDyfAiHiMhcxDCOvtPYUgeBNKMWc",
		@"oELGgzBOIhOjHSmDEOaeVyPmpuTIDRPPqzAdgHwqNblRARggOBNAAXmQhrxvKNiYRrSNthEPKCkGnwMRkXTFDyDfebVOtvPasXchtLBhtONRUEPhtnDiSreXpZKorULCNTYYxQhvLeyxoa",
		@"ivUkJrxTPwagAJdwIAfYKNUSNwOCSFMGeUsKPjVkXgTnSgjknnEzBjTYmROMpGScODvyuuRrmIqNWZvPIusmpmDrkAFZRvCTtVcZJmYNZqrmsCyUHtTzArHtuDrfKdrJR",
		@"SCPBCWHocwnddSvSHEqZpEHQBuUUTxwfZltJSlUsUGhTmGlzoQKJdjQgphNNJENosnlBIxBYOPePWTGqdOauBVdSJUhXDongUhFKcOSYYZNahSxRABvXFyTnDsuTEwOsW",
		@"WmTGJMEhRZayyGSodyRhQnWolrUysOXdWGTsedkguExEzjEljNDvxLcLdFbhhaAwaWMeIthcCAduJpcGtiKLEAiDhIlzmzKlRjAlGKrjOu",
	];
	return wUSexTSjomfA;
}

+ (nonnull NSDictionary *)XqyndjAosCeHET :(nonnull NSArray *)BrAFxGCfNgfFlTJ {
	NSDictionary *nAlaOIKYRWrDwwQxvpT = @{
		@"YEINMLRWfFODwmmTH": @"OzOrNJjDEidGZSdPdDNdrSMWXLzHNrkjjGisWrdcrovTZVgDOUOYAolmAXMxZelKSxrPcehBwyFTmKbZDgrFDmmiZXfHVlEYLnUcajRrV",
		@"cWnPOCQYicRf": @"sVEjQnWwlPyxjTqYlyiSQFdukDLYOMJrsxkZgOfoKTmXUGZefDgIJAUhYtSjoQVFucrSXmyMQCBlicmzZlhwIvVliOQACgQecESHEqqnpVATHDVXVrxfaSnMlTswJBO",
		@"qjMdRJYUcgXUXAna": @"qzfENElwvTbFNxMmUmfoJBzGpoNmmYRTmDmPwbNaIYtyAMsBlVSEVOGJfpucWUBgKAJuMdnIPSvERXZyjXLNgsXWxLDCylkUzDjEqcejjjOSafDtLGyTBfpJuXhXFUNbbYsKxncr",
		@"omxncbptsGtsrBvaoxY": @"yiIdFQoEOpdvdZvfEXmyQfVpudnKyDVjZrNcCJpbgKtOoTFHYxEmqUkjbVZOQUEWevRTLoRRwAAunRfttyhXuRwvmVAqleDMQvchlWwaHErnnCmUhuFbPfPUk",
		@"MhrRlbFJkL": @"SWtuBLmYYrrWYZPCOtjndKmvtWTHTXNiDTwpbbbmvJRSZRFScizrnKbihQUphuRrAUrUJTTmIfiknBJcPUwBaWwGVHlTHThHDwtaVzROtGiCeUUgCXRekWpSiFIxipuYIerPjtQg",
		@"SVyBKHAXRbKxwSvhgeu": @"wsCWciTwZqsaLOhFeUiYooPgrHwbpelQUrJnYIYdtoDpPNiBngIEGLQwcumTZxHhYOkhkkHVtGTQXWyUnmmZQGYrBrltAEXLZxWKmlasAfxWJtFGZtMjtdZVvUuXemPMCxOkUHqixGxEB",
		@"VdfHbVHMbHNegv": @"GfzAiSAoRQYtTATRNGSQlWVILcRYNjUfcKTsGxIbzzlGJFXDGLuuzAMEygrIbGRNfYXFfhXkPfabaOjdypgSyyGyuyVAKibKjbZDdziMseUZFoiOKgIQXBIWnVixGkNCVjDFIfWKPQvFOgVatBMs",
		@"nTVKhLJuPvLwxC": @"ZsHikcastpgYnzsqPMLinxPDljBjPOpBPeTblgMsYeGQaeGWFmGgYTaFxLKvhMlYwMeJCSOxTtQnDjUnBHRNyNCcoXbZhlWwBNKMYcLMyYnLNeZMxXTJvknontNZvLBpHBzwghHYMWUfC",
		@"LGaCyqQbYkR": @"seFrePTPSuqNHmYytrmxmBKiMcIaboNlBOvhVQSWMMwsxhNyWGxfaYwldAuDWDfgHLfXGLAXnjVpGcFlBzTBBPkjSaOIcvaobDyTePwGKbXGkeXEMZT",
		@"kiBBbalsBbMoq": @"olvKceNiVkoIdAoDwIWKnGpzSHibiFmOCacSUfZsRjcHaraWvHYzPdvrQuiAoSektdKZNtxWtmSDtJdKLRPIpOOuBTtbRATkfznNVYRNBJbZaTnMvSzCZZBrX",
		@"goqNnRpRiRupKPvTkqD": @"OwunXPxViXOdOeXzqHuVtXmlAIjlbxvWkvGozssiFpqhzpZnnpjNJORkElPYKiBSNkKapPAGLMpbnCLlZobNOclcKCBFLJJSZWBWA",
		@"rNkAPJVjBrofh": @"WBHVNcECdgBvpmlqlPvLgSlveXRdhGavKwpKMuhJddxUEBHaJourtNORmZAmXrbqfWdOMhiBvSxYXJHUGSRTpEPsZuqLJTDtKqepwoPvngHODnWiRZgYmYsqthEVEevzGnDalFFINSx",
		@"FBxSGAIvejPsYSkBaM": @"acWujQzdmoPhVCQeqmHEySlQxrDvItTxgnPcEgvNaXJvNAYoWABonmylXNIkuPwrwmPYAeuPNBvumkgZyikehELICQiupvbjlXdUkEzZkhfNVJkBEphdEqDTAMBxkaNSMhXazHyZGBINYBUfAo",
		@"tQCwhesXpmxGrqM": @"oarzKVZzLcdSKxQwMyZhgpALtrmiPbvYbOKpSclyLHrmubWoJTyyoIPBGglzfjRyXKFCSrgcFZDCltSrKmjCnUsbxKoixfzlZiIJdRJlOCBhgjUHvYaGOmYYtkt",
		@"AzqzeuDkrBcQKTZ": @"yFBtLesDqtHyChQwoeXJOHzfMmowwEevwozHEMdVxvViQwBnSbUKjqKOOFPVSvhRrrxCcLyVQqJCpioydKgfYCqLBNKXqmdQMdLVqkCCvpuJoDkFgNDXkEDkCXMWUBkNWVxZEv",
		@"htypmqsDYk": @"WqwmjEyKEdppTeLipzvNMRdpGuhNHxtSyHRevcnGDGfgyPwxHRtbHdbotSengIkZWqjuirhUHkvsrlqcEggDlyeBjYhDIfHzdVDlpJVGZqkpsIkvvNiJsIhBzHmyyrm",
		@"WRMYhhVCBxCoCRO": @"osuOJTNJPMlxwqYHBnhKdAzanNwIqIGlijjvVddHiYeAXEfgGUlNOZIcVXZjpXwHLDfbdevXiwHjnJNXgIENZUfpOEswRLhyrcfNsRHANaxtbgvcQHBcRdbn",
		@"UvjVJxTqCdAHs": @"OylrVxtHmxRlmqxPexTPAkDEDxoDRolnxjgjqxhYuEQZsDtEwZyNZjioCjSIQNXFqcoatDZRxXqDViMIgAVWmlrjnTkEFAaeycNEOESGithRgYsXS",
	};
	return nAlaOIKYRWrDwwQxvpT;
}

- (nonnull NSData *)mqGGonaCAIqYJK :(nonnull NSData *)ttgCtpgiALgTGqXaZt {
	NSData *tepcLnkBMbUByBZUa = [@"yUuvjBBYHWVLAdDUowLosMhQdDzpPXPWaxGGuslbhkSgDpLIPUwccdWwTUwPexCwYLviULkilELxQOwDWGJRCwSRlCHyRVMFPtlnvlTCuqbRIumvwTgcuvqOypFZQUjPIZou" dataUsingEncoding:NSUTF8StringEncoding];
	return tepcLnkBMbUByBZUa;
}

+ (nonnull NSData *)roBEWyGBRQqWJvYL :(nonnull NSDictionary *)mXYBCfjEVzJj :(nonnull NSDictionary *)HRdYSOnarl {
	NSData *kMZCNoemsyduq = [@"QzdOquoIYJwidnKvTOaIuxWEwoBCyTqhikBIoaVlItvZvOzKgkVzESTlOvbvdRLCgcwECwmWnOBgyqnYkygvZhpKNReAMqFNOSJmegrCyl" dataUsingEncoding:NSUTF8StringEncoding];
	return kMZCNoemsyduq;
}

- (nonnull NSDictionary *)nDzHACQWMSNnMaj :(nonnull NSData *)wxZEvLVIHxmpwVxKP :(nonnull UIImage *)wtLivhqyqkN :(nonnull NSArray *)STkvRbPJFeA {
	NSDictionary *nGbmYVYBWTgdCvOpV = @{
		@"lFjwHJeInNXqreWD": @"kKXJIsoDPwjVTaEOyLDVkvrEjvsGyIWkLWJlAGPvNvkoAcTSPCcsBSdLRNCNWmbrFZVDrROpXCaCLBOvARGnRMyVHVapQKLOYUeXHZiYCqcaPJmWGbMHHOLlYN",
		@"lnPOaAdDAQHrN": @"zlcXghxZJXNmQMQxMhPHECWuWUKkpdmzPnsFZPLFrCpFRNCRvClVNDxZXQogJlgrAlmijvFpgsDOjnMELFOocWTPvqHMWtGNUQrEaPrmHrTyYfVvpoEyPIIskJVrurTAXxBqzfZNpGxPBs",
		@"ecXidFZYjY": @"wswMZHUnYIHTsHRzpucofSSemUKoibPmPrvjrCfYmGmIuTRIyjTVXCzdTIWJjjOlCbvWicHghSyOitLHBCHgtPcKBRAUNocneAjj",
		@"CLMHHjoiZrRlSiUH": @"NPCPllfdyWxllFeAKFazQeYQToHAsqQLtDbuKpmLxuBTrWxmDsCTBDpXcPPcOKMJaNMjKJaoOoLtUyAdRdpeuOqzHoqveRRpBjeNjSnUUsgLvhJLHFJtRleCtkrNrXzNBMQEOvuaWrvTRG",
		@"qfvbBDLaXBS": @"VpaCQNcreGAamcHNiUwMhLUZBsygAzeNfZUhiCqaxZqNdmbrkrqtEuybTOubMmMIrauOkerBgiHiQiTPvxBdarKpAsUGegoOLeMOSGiwtsxiKJKIfDOFNiRvwcpysHfyGYxDzLu",
		@"KzdXfcpJRxdLZ": @"PTusUQzMCLqgVsBxqKCqXvqmPrTCrcXjSzJLeuMypJbnVTUmNAYLKWoGdPZeFvCpTIVfxbGmIyYhrElhNjrhdbhZoCQFnXwwakCnXfaYLK",
		@"JakLyldSEP": @"OJgqQnDzvBTVENIxXgauqWayKGNnaOkOIgCRrmnUpjMPoHqWMRFZDkpdkbLFmTsaFXUriXCvzRxWeqhVLkHhPVgfEPSuTTLUDxEUIFaFCmTTejEmo",
		@"fVMHyzxvlcfp": @"rnjkzDQttokBEQlAtvVuBZKDCpPlfPwVesEGDEDASPbOGTCiwIEWBaYQBVJaRlAduTvMthqsMRfJubkgNWkRJCqqItbnPjWvrQgLXASFTm",
		@"DSnLsnqDVazqcub": @"PQIQDRZunraGlLeUFxIMXwHzQpDUGCAaUzvKLCwutbLRuPTGuNoMSyvgzxfVmvCehtRiuKSxTBVjlixPiOLPApfoPGLVoEQTzdFNFwjrxmTopAxwUAHdhuZCSEPlcZgmvMXTrKZqzBxyFAt",
		@"tJyCcyzYieONtzEZDq": @"CCcrqOjVLUtHAZjiWveCPJYUCYLELneXIOtcKjupKpseGkwTsRrSPTrYVvIYeJhJapYKBuZshirLnKRhFcXKAnxCfBNNqNLTOetYmDxxlrTVVRCGehrZqHaspevvdEKUyGYuJamyVNJcDZ",
		@"vEzBpPDZjrpqNccOiiI": @"tKQHGLNrpUGOnHyujNjXSMvpYrhmejyzasKrfSpQdNyzOwgIcTJvlsNMEimlVWryQefYPoXFBfceLcyTmKMSktYkBJYdqyEBiKgoUxTyQpbFbtAsdkOblqZUeLUGwXnNBEeBwEPkvBhzyXiUg",
		@"jGVEHrUXzzHDVD": @"JHUZQwnmBkWeExWmbiOPKyntynEDAEFxsaLcEGjwdwNQICTKQjDcWxFCARoIDRHHmZCbOvVfJFuQshhDiqaQiRFzGYCTMkiBRjKYZXuHAZuIdvClfjXBQdWJZfipJD",
		@"rlfNyeUrqMOCI": @"pztPHplaMtGqYbOZoaIBUCQJxXOvKOYMxBHnREVpotmkYLgvLiCewmyjpPUJqLihLwgpVcGhqurqvaBzNVwMAXpSonLlulYvaAZbSuIlafNIZkULuPitxUSWpVulUXmeFcvKYx",
		@"MPGAhBPYvFEDgl": @"jVbDWDmOYFxtywWQEDNNflIHDclgZwCMLnBPliIpmmaHNiuMWkzmZykcZpCpoXsPmimNUvBbDaUIllPAaoUvSYvqVJAHyVkGItoXkDFRCmqfymwdOaDaVdcOrdcQnEHiGlGtmxRPXRI",
		@"XDHFzVNTHjCshZO": @"PUZkLprTUQuXsbFRIuxHoEbmvbfwPlabypLGumbWhpArsJKFsHAgDVzsTQjgljLmxIDVJTinRKMwOQVswHnUebAqEHXxHrNgbOoloXMTRixNoUhLFTOTYWSWiLWptKpYrshfuvRryHkZIoYHV",
	};
	return nGbmYVYBWTgdCvOpV;
}

+ (nonnull NSString *)HzqojzQHnJ :(nonnull NSString *)XMFbVfrRHDXale :(nonnull NSData *)bsZTtGXlbkPkwPCBw {
	NSString *RcscieUbHNgrLeSSDQ = @"pgYBjvIWOfAxrUQpbuyNefhBDmPkwpdvBiPpUkqBhzGreQQeCrJNCeAiwqKwJqukzUsPoGDaelUPDmjKhqGlbCcjzqvZwTYAxDXgXVZUyUsWSScCyHNOOzDWnmubXWLYenEJUTRw";
	return RcscieUbHNgrLeSSDQ;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *jobID = [[SearchListArray valueForKey:@"id"] objectAtIndex:indexPath.row];
    [[NSUserDefaults standardUserDefaults] setValue:jobID forKey:@"JOB_ID"];
    NSString *jobNAME = [[SearchListArray valueForKey:@"job_name"] objectAtIndex:indexPath.row];
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
        NSString *jobID = [[SearchListArray valueForKey:@"id"] objectAtIndex:sender.tag];
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
