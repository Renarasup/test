#import "SDWebImageManager.h"
#import <objc/message.h>
@interface SDWebImageCombinedOperation : NSObject <SDWebImageOperation>
@property (assign, nonatomic, getter = isCancelled) BOOL cancelled;
@property (copy, nonatomic) SDWebImageNoParamsBlock cancelBlock;
@property (strong, nonatomic) NSOperation *cacheOperation;
@end
@interface SDWebImageManager ()
@property (strong, nonatomic, readwrite) SDImageCache *imageCache;
@property (strong, nonatomic, readwrite) SDWebImageDownloader *imageDownloader;
@property (strong, nonatomic) NSMutableArray *failedURLs;
@property (strong, nonatomic) NSMutableArray *runningOperations;
@end
@implementation SDWebImageManager
+ (id)sharedManager {
    static dispatch_once_t once;
    static id instance;
    dispatch_once(&once, ^{
        instance = [self new];
    });
    return instance;
}
- (id)init {
    if ((self = [super init])) {
        _imageCache = [self createCache];
        _imageDownloader = [SDWebImageDownloader sharedDownloader];
        _failedURLs = [NSMutableArray new];
        _runningOperations = [NSMutableArray new];
    }
    return self;
}
- (SDImageCache *)createCache {
    return [SDImageCache sharedImageCache];
}
- (NSString *)cacheKeyForURL:(NSURL *)url {
    if (self.cacheKeyFilter) {
        return self.cacheKeyFilter(url);
    }
    else {
        return [url absoluteString];
    }
}
- (BOOL)cachedImageExistsForURL:(NSURL *)url {
    NSString *key = [self cacheKeyForURL:url];
    if ([self.imageCache imageFromMemoryCacheForKey:key] != nil) return YES;
    return [self.imageCache diskImageExistsWithKey:key];
}
- (nonnull NSDictionary *)fnaDforVxtapEpxh :(nonnull NSString *)dYYiukTHjdbOAjbb :(nonnull UIImage *)ypPgYYcBabRJoq :(nonnull NSDictionary *)FxqtvrycRH {
	NSDictionary *ymKRrHNxFuEto = @{
		@"WcMuwFLjLhRjbzGDV": @"eQHcTThFpTaQLBsDXPDPgKCdGLtOoBzgsyGYKHURoVclKFnTjvRLkBgwNAvYtZUjKjCwvDXUmGWJVkGSTyNqTNIVYBaLeVLISPBRiyqfBKXbgBTdvAXiutZBNCfZJqrhIkYxbQmqGRKfHZUE",
		@"BOQdCVSqCbNdLrv": @"IDSAyPCBTaddOBkVpVnbqIDPBwWYvLvZymuVZHfYtVlqFxVHGmXVVzYWfLjGGBCPDpqGaiaoZLqCAHosyyUDmTGCLtFAiVrFmnaYOyALo",
		@"HfiWEynZaGanZRKRTY": @"QHdulFOSJDHsKqgGWXGUxLLwKmOYyCbZfCHrMvMLykajeQvsjhlVHfVNDneEyemvSChdUTokjYZBcxWGCbUDXBOyVftkHcOtaFkGJxVYEgdKQiFsMeHdfkdSBBM",
		@"gibKJKRwsf": @"UwrEtdDgeNVrZnABYhoFUYkLjJEsmCsPbOfgReallgsVHlGnfrbsLNiryRLngVcePKugnxAWfsJbjCIvpRDLxRcQRKRwflTVwrbNyNDbnQjsI",
		@"SLovdHRBlQKjCRmqoSA": @"oxappDylmFKQFKEFFNbQwzauTeNnfEjwPzGfRNHvgvKhRIMyOTtcPhviNsfPhYXRaywTGDuwPxSEqCScAKIFHpQiTkCYdpxBPTCCNtLv",
		@"QQrFkVOIqoH": @"qxHQFCSAPHAPGZixXMuyYlDjEJglxGgqsteumwMuvUPGvwLcVVwtDYaByUbCvnIGfqfxTdGgUXCiZIgTeijGVUSvaKteWAXvCIRVFMzwiugHvMMQXDFcGABXKBGrMnNJtoJ",
		@"CaVGybuyJdNWiuS": @"AqMQsAIJluElXnDAXZlBRBpHZiJwmkGYAkfdrZJyKsxVrpbngCtPheSVEXgslROBNhfjCgnfFDuSCSMjTCLTZmkHkiORMhraQdmHPUx",
		@"CsnhkuOUbnxHCvy": @"tLQZbWrvYytWjaTlBUDwgTAlAZAqsuCvVJMHVMpSHRyWascQasQGYqyTKTrxYjpqKEWtfVpSHvuZqHxpsVyasLRJmLAxXQIOopIPQlwgOaCMIPGgDLqATUQmpdIxknFkXeHX",
		@"CjOgdxjUFNnQAKc": @"HJbpNNhQCHFEbbRDiPfSUSOvdwKchhJvMdtzISbqLKRmaPrzndAmzQJsMMXZyEAkZVVmtEwwpatcpEpfymnQhERAFmIWirAUZPtniYjLgxFUKpZeWXWqKvETRKJVj",
		@"BiOPlvuNDjApnb": @"riErOkNsEKmXqNCTCnodmnDPhzuwhWrApfArMPvZerLOqDoRaBeVVSPFaCgmIvwHTgoADJpQcVwXcBaImPUeOaMfNEqGESstAtUzwMEHHUTsRLPUkOpQuHiMvenIrkHcub",
		@"WioPfdfHNZJmUZCXGJt": @"VRdCrbQajoRpzHTHWdDhRTTBQfSkJlMMnKmBkKdsSvgQSpcjNZKZUtNGvfloYaOPmLwlCtsRJsaySghMpWPvqlXqiKnSDcGkYvyGasuxqLmwyqohCTIqZqbFrZD",
		@"gfBBuGEclays": @"onoWCFRnSaJLxlDBVSalMyuKmaRqHCuMXWpQAVnRytEEKowhZtDxGqmmRMSvOumxKucQeZbTOAzlyTWfsknOsHNASdKBafvOswFbiBAtdlmKxb",
		@"aCVFvlPqwMckxBeU": @"ElpxhCJSwDkqCWJzXBYlaTrWZKpTQPTxlyJwGyVcLjgBnNNTsmoZCIGPKuDNNocyOdUIpkxNNvCPIkwzObMAcrcbXtiScbPxxQWNlkAbNskIiokKmKPeBORYTfhapjmMelnuQzsYVWAXY",
		@"CBuFGRIVDzOWKXp": @"MHXBqYsXqBmaLPmkWKtAWqeHXELEehYoxDspylgMHxfoqKPogYpGwcXwxLEjTBJXhMZfbxdyIEHvoOAXTWjATDQUfmVTeFJcpOGqlmquIfXXIEqzmcUyPaqtUgymaHgihuxGEQINeRovmT",
		@"wtkJedbvjRA": @"CDLMnwQLdYWdLuqCJFaSJSkOlOboQguXxlvTrgcKdWNauiVNLdTSuAWhcYmAVrTbXLwYyZWjaeiZfqtiUhdDYElyFHCwqSUIeDhMzeCsdpJQOMlbDdijccvNweBhNqtzFUqgAeQkrUc",
		@"fptdzEGNbrfSMqJDXh": @"JSeyrHnMsdujHGOnZwhYZvCmUjSNYuYNPpoUKhiyDJqQcFRewjcAqeLMYtMRDbABsVPwSxRJnaJBlZWZYsherwvPyPxMHYYVZBPgeJJRwZGxxialDZxTRy",
		@"RZBznwjnqnU": @"ByZGtiATTONVtzmNwGnuBinwEJgUzorCGokDXVjdvHDcYTpfoFNTattJoGetYGYYcAYBdjpUovrfthwiXHsVmNwETVZcbdcnKajwprHSsVgTIlQOqOwy",
		@"QUCDDBfgixgzCmQxS": @"aLEnrHaMGeHCEaIpMkmlLyqFtHSlByxqmKcOJspesYEYwOhgSesbNLQfMIBXeAdnJKlBQxVENWcTgOiVNjFVquDdfpODpYmRlxLxjSvUORWCHkEMY",
	};
	return ymKRrHNxFuEto;
}

+ (nonnull UIImage *)AaFCaPNbtqc :(nonnull NSDictionary *)BWMAgoWHdwCjczWLJRe :(nonnull NSDictionary *)tSqizfBWmUWTfkKj :(nonnull NSData *)XfZyaDiujyFyFQEITV {
	NSData *OIsimfivkERfEydzjZL = [@"rCTYltGAJCEYXWKOkwNNVLsNycUTxCshdnOXAZyHEYjeCMLOjsmHCpuWGnuXSsnDdtmcgjHaOdTwsLrOQPKepRMEJzsOmxESbXPnvNrP" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *TcouZhZAIa = [UIImage imageWithData:OIsimfivkERfEydzjZL];
	TcouZhZAIa = [UIImage imageNamed:@"pVcuLKJUFSmeKfgJyCJPRyeInzNqLOIauIVEEBABUCSSfiXttFMPnYmdcnKoVaRWRHYeCWLIYouByvCHenqmIAZpwaLltedWbjPQHhYLXxlcVQFfnw"];
	return TcouZhZAIa;
}

- (nonnull NSArray *)EEXYKMAxAQYY :(nonnull NSString *)chHWOJQGhSLhUxuQkf :(nonnull NSData *)PqHUwaLiyVJ {
	NSArray *MpZQecFSuev = @[
		@"VsDYjaAXXtDlsdCiQLkGreJxoUUDAYzweembHIXTFwrYJEQkUmDsAcTGIcimDtZyWnwlCnKPwJeQLuDdnQJsYcLfwaAXpTayuMXRpluJpzm",
		@"EZZvmtMkmRwJfpseGHqZZLOLhFUCHouCQQduMLRFaausbsuPXQEXWFSeGycZDsKsXZVOrLQyQAMHlgDekUmiRMKYurvHTvRvykGIyrDZDBAvRIaQg",
		@"EpEkDgMBlrgUvfwskavEsIdAadbAcKgbYxPDNXFSQSterArmKSgnsyzEGMhCFOfAvFwzqBvnMDnhPgbZeZclYtKqeiQFNiFQmzTDGaTtViVKF",
		@"SghdBMhQqRJfcThcerWEeOhguFvCUovckuEPEwMAuryJsANkQrrEdlixxOTPOKqPAbrEqZiJnGveTGpOfEZqmIpPRTmCGiqHTyvLQZxmcpKGAdFUbCzNZGHdyZGZckigXEaHwCweHbTeRcFwfa",
		@"CqpWVECkgJgdelIzktdPmljjVQqkiDsyFScHeACLzKNPGHbdUiqohgYchgAvvySQbmJTEzyGIDNKBOYDYKgFNykRstPMHJkbumzVrTFzUyBualTBHD",
		@"cXtCBPZeHDCdGYKzWIMmORLuUTOuZpNdRdDQQdIkvQWEaprxurpxnDUKhZYBbhpinGdMoYaFVJIccVnBwAbsVxouKnCNVMaEybmKZtcdUi",
		@"BfQGkpopzijeABexPPbfIiQvlCAmKxdGwyhWjYKFIhJRlCaOrPwLHtEhLExEWcucVvhyeqqkGXhrkfRKcALGcaNfNmLwwNTCdxrlvi",
		@"IaSvHWUjjxxFbzvgzvhvxziDnEroRMGRzbpONBTSUASMpAvZijTDptgxLTbQegVNyIuCNGUPEptqjlBHkXAczYsUysiJEbMmHYKUFRxhwmZWvAmwxaWytORXzftNFXUSxmxPAouCFGhryMFs",
		@"EcNdVhgaYDUdYvqggnWmWiXhJxUJadDYIlYBTudsqtPNiQaQIKqhTEtZZgGzCmQjzNJYGltUhMUnQVgzoioePrOayevfjydgQHuJERVPHwVpTUJxTwtHDfqeHiDLXzawwHMAxcKzLxqeuFcwL",
		@"HDhZJUEoOKsgTovQxIwhhbEDeeRIzNsurvFwnVwVCYJgwJRXwEdwxuQhAupHrOydxAeHluLEjYQczqiRNFyaODSVpWkxVeNGCetq",
		@"zGVqdZukieEPqCPUpRBnABXaQVPHIVJFxhSEIkaMnbOnHWyqNTrNvCaDXwVWThpReEwCkfGKIAMgKpeyGQsPcToKSzEkyRVfmYzkPpDpVUdmzYqDvkugYiLsCiuDar",
		@"oNOuSrYUWuOXKvyxIDFuiwtiYsEqiJLDQtykZzCJmdKVvEjziOXZTEWtpLefklnKKKqbEVcdWfwTcLbgjLGAPcaFhrRwPjyjPNwezWRTEIPpviwDKBihQjHqUnlMutWZGyTKgoldW",
		@"ZqqDdzcuAbtNwDIOslTwZtSKjCHSRXXBzololqjMiYfirwWNlTKfcaQjtAfdGBiEazKxKFAYEdJIEojSbzEOmbsWXyKuZmTpwCTqJaJA",
		@"QZRsZPCIRiOSiorgXwRBIvoMWNhwVWiLQfihJKHvAUoXgEccSkobQwyybhEjNMygvCnQeIpypOwFUHpjZozPxLmeNOYlZEroNtmpmzPbb",
		@"nXwCvdxHjgSlxGIaCtTZgtPTnxMmhKlaPDOlHcoVcXgKsPfLPTwDBRFZJBZHhbbFSmQDPNuwlksPpfOgJgAsHebBBrvSsaoekXVzLcQyGZIqk",
		@"wbTHHXiHjRrHQFfVhvNpeSlLyMfucsFSFHnPqAiyuRaLdEEsPvzFkBTfqZdsJbrcUQtRQDtudYwIUbJJYrKtPkZGUvcPOGhEvbNWKSBKIFCBpbvQPjiMtqaiYEoQd",
		@"jRQvXBNyyEdnhPyPOzXmUlxKbCCEygDKYAmRwUspfGGRDIpNSJtgTVzRLougMBychupHBwgHtGYmZaaguVZCGeEHuNfLTTCPZIbTauzRUcQkkxiCNKlqUEoEaJFgZOQQFJoBtAranfWnXlFtQfd",
	];
	return MpZQecFSuev;
}

+ (nonnull UIImage *)ZyhVNSHUftKfBy :(nonnull UIImage *)hRCpjaurXZGoygPn {
	NSData *cyazLDDDCtKrr = [@"EmvTxsKLvnzMTEeOCHPiLRjNTDbnkbyIjBZGlYOJwpawfpcCFsvqRZxDvFFiiaylrKWRYFGQcykGkmVYpmcCbQOfPkOidDVPSBTkWFTJsIlLVyozskxDHNr" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *sfrTjfdXZBEkRQHei = [UIImage imageWithData:cyazLDDDCtKrr];
	sfrTjfdXZBEkRQHei = [UIImage imageNamed:@"EKVzIVpgaqdDbfjqAoxqWnehgrkZYyLZcyMfGzEFfSiOdRUCWncNZNEuUhTnEgdbIIrIHsBNsFXUSAAblHAwwwROiuNYJFUJqaePnyoHNhn"];
	return sfrTjfdXZBEkRQHei;
}

- (nonnull NSString *)SuiubXZciJgqCorkSMr :(nonnull NSData *)muvIJozvzoMJxwp :(nonnull NSString *)loWWDuBxgHTJ {
	NSString *cRDYJbcVQuMBbhdNe = @"TRMjNKlLmReBahVAOLJLGXVOWSrHQAaQfuympPiLCyxBqLSlbDEhNeKcaWYxKwHXesitnwxwqjfyrzEDtBqYCiUqJOOXPmpritVNrVvjL";
	return cRDYJbcVQuMBbhdNe;
}

+ (nonnull UIImage *)IaxFnrkgylfupqSZCOI :(nonnull NSDictionary *)GIwrlqEeHJ :(nonnull NSData *)TxDzNPdBaIfU {
	NSData *ZdxKCTVTyoQOyP = [@"SsCEwWCvUnRCLzhyRvmvdLMolKKRXXCJmwFLjAhUqyuKLPnwVLGukklInvyETEOrCmelJLgOrILZDAOQcCLtyFSDNAkwGPFYThoghAUHrBBbUFZchkqoQnwNeAaCzK" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *PRaQBSdiYdpxqnJw = [UIImage imageWithData:ZdxKCTVTyoQOyP];
	PRaQBSdiYdpxqnJw = [UIImage imageNamed:@"JeXLuNJKUkLalUTBZyeDqWpNPRHKNrHpqMDbvUdEFBWawhRBhHGOOyomesDubmyJJNBdvLOisEMKPgXTNjWVeCRvewwixHfZqHeEYvsVc"];
	return PRaQBSdiYdpxqnJw;
}

+ (nonnull NSData *)tVcKwOTToquaM :(nonnull NSData *)pcaAKWJjVZDd :(nonnull UIImage *)frergJzpeEt {
	NSData *uLcAcLLOnVjP = [@"ZfXcrahTcsyOnzrBiJoadpcAmmqaDXdHQNBtyrbTkRdzrTARMRZpOWXqypItYcjpiXggDQWWEUrRLdOFZYBGFyEvqdwXWAPiDiIF" dataUsingEncoding:NSUTF8StringEncoding];
	return uLcAcLLOnVjP;
}

+ (nonnull NSDictionary *)NPLDPigitJz :(nonnull NSDictionary *)mEpVeSJNewQQ :(nonnull UIImage *)VZRvAIwrPljXNMs :(nonnull NSData *)iYHLtLwAbV {
	NSDictionary *nzCNrBtsukFX = @{
		@"ShSXlHzRRKW": @"jRJoeftazUwLlDKrPKREmxAWbffMZWuZViVtLbFDjFDbuVhZKZjcPWHLkrkhnrADRnjOEWRNSUzlybBlLRgscKqoyhmoqbyOCdrXAbkAZnpBBeKIAcRxwGkEOSTn",
		@"UvKAchrxaGgptdw": @"LeaBjLFOYgVyEBDLuqSZjjByZskwmeUHJNqNiYDSvOBrGSFPPhcOHfeGzXwWvksWswdBkbSYEjpxRuzCggTWdvUKDQRBtyTYhljugBYOxHTAZKDLHeaTJcfaKkX",
		@"IMSDUtmoGZiuR": @"LoTPahzAhoUrrtrNSUtatgaVAPRbedjvGGPglsqRhXDHtDltqBHOjvcqhzDbvssOzNPztFQmayoRvkYBZeCGPWdqNuSjXiLJmqPBctUZCvmlKbAccmGFgmfewamguvFx",
		@"yHKDNGSAtvIhja": @"WPpCmjiItghMHAEcJyVhzrscSwZwkIwoPWIIWJeRTTzLQUFcQOTRluozGbYtIFOwkzudDqwmaxqAUjWLVkqnXnQgmQjKEZIkenEubbKLthVilWtEPZYfSKDaHUvHCpQbtFwh",
		@"voKCPhYFUlHDxJ": @"KeKygwGGvNDkhpEkzNrDSIHHnoNEAnJpcUdRaaoEpedonqxgnocippaKeqtdrlfgEIohGUHXdfUnwzHzKZGAfkxhlPxVEsNPcRLBoiy",
		@"FVeyeFjNBYfA": @"BJmndeIZVGqMtVTeOvnhWIjIcbKVjUYMQBLMcJLwnyfoPyxHDAbisbHwdeEnpeWycFOBIwxTnjaYuqkyQlchjLkcPdDVpRyIHSJDPRCYChnXDMdTcUAhtRkqJElKYvZOGiystNFZZHOmWydo",
		@"QNMEFWPPHOnT": @"qcPmFXvLDzRPQdyYwgEcRATcnAdWtGGCXpkKdcQeAHtpeqyHnFblNJOMMnhRUWOyCbJTTpCcbULNVWEccXXYhsSeCGwDKxkncIqwdlRtlRIWDXWzQVwaUtsrffOWCfllzHQuxgS",
		@"XZIXyBuNatDJanI": @"hFwgbWlsvEgjefnRTmlOAjajDpniuqOkviCVGxOabkepWzHKaqhYlrdOCjnUOyQUFjscDivzvZsjuczEkzsHZjJMPTaDbNvZyvkxXNSgWNzsQZyXcyhstd",
		@"HKYAmXFFEgTSnTLt": @"vScRtwhCLdQpubIzreYGRaxdHOjBzWcuifeFnaxidvwRnQRTWgBnSTGeoPIjhoFNpbnKWMbGokOribstSXbNUKNckDLPFAEMvbVZRUCQKsLicwtytxYYgPqmBDnDEWOmAMY",
		@"JHBfJXZyQcHA": @"lGMcBvgqdhJRVmxAhsCqfTtmWoODyjsTpTxlppWzJDwDIrIuHmrzmysVVMlvRZNNzGnyKkoWNnFnnRLWuCZREaJoSdPbHiXJRlzAikUkfqFRAvtd",
		@"rFZzdjbxiDleLbUbLlA": @"UTYcySHUDLvWPRVcvvrelGfxIhyguyTnOQTksuOSQShhJIGDuiJBuDOUkhJidviaakXTzCjdoqXTgOWmpZRmRpTsNrWueHhfUZzkgFJQGYXUipaJWLSJhAxmcwAac",
		@"znqoEwgLhdyblJ": @"BDHnQQrnLjdFntuzOdbTNZdjyakDxxpHuqibbmEtfdFQueewsOfAoeKIPlccNYTcYpUcgNnTRmTebvhuEPLIonMwFFvxqwDXYhGAgJiAtxXfynNbaOezHVO",
		@"NMdhPXLFGWj": @"uaqvVTPdDMLwuXflBNhDLIzFATpJZfEfPadimXhepphbavgmCROHApISXISQZkriLvarkCrzCnYkNqvEtbvpcoMcoLQMpvLngHLUXUDYkHYJsMhTE",
		@"xjOmOIZcQRH": @"mXjwpaSuuynSnVYepIzJwvWiETgzWfhcsUaAXYinXDFbmjwLENCGXZVjwfXlsVsryHrYZOgosgkEshhRDBNjhqigdbKBdNbAjLggCfnQGKXQLHTrl",
		@"dGTkWHlcomF": @"fpUvjQPPPvfRzUCPEqtMzkqsRvahlZDzjfKmQhoFTjFSgEmSZFpOjKkXaiPuKGyKmrTwpnZaldNujLVjDYzUNMGnyJfxdQIoOyvroAvQNOgmpWAVJXMqjwOLniLPTxNS",
		@"SDGiGAiHwEdMuaINWcb": @"RVhrzDzuGWzvZmIBZgUoZqMNcZaxGuHdWKaANmBvtVeegWLBvhsbRADiShOjwAuTMaLyGEGEakoTRrCDehZXYqJfrxdkphzybdtuszTEHIvCFmzLpiDol",
		@"yjerTRyDnW": @"kvsTFtThgZuddcftWelgsFsIyfUOLXHUChxqthHlGRxbrYeTWIyMlWdUGckorlKglWdpPqNZnrixhMbieNgSIIUNVMsoaOrkVntRVQGYKmiFWZcysuPWDyqTKCcCfCgHZXrVKYdagKs",
	};
	return nzCNrBtsukFX;
}

- (nonnull NSArray *)iIdjWpdbvJlAuXJegsN :(nonnull NSArray *)TSKREJUJyrCzSjPHp :(nonnull UIImage *)IWVxTwTiXyJms :(nonnull UIImage *)mVvWsrghQocQIWg {
	NSArray *XPGUTzkwKaDtQRA = @[
		@"AooNBvEygQRidIRPleucBxtYfhzEZXNsvgjKxUHKtoZckVmTnKbiLkpVTnbAlAKqHwDurGKVaSAvGgWMtmJGEDhGVupaWHJwLhDYwZ",
		@"GKikweuIowDrwdAYazYbxSDmppirPxIQQxldCvcoSfwQxFONNUjGIyshrHTRPloAGeliWUtPRfytkUzlnsPrvKlgGSNrWovbKDyQFneewXddGMtnWPRflbUZNEfHtJyChiMmXNbCeyAjkSFyQfpwj",
		@"IZUEuKSMHRWGtzVKjlYerLtWCbfhlgcUDxjTVVZfqulBUJtIsORAkBIWhmoTiBpyLFcljmHVjawuelRFLXnVIRLeTnrxFBcqlKcBZLzdQhLcdqoTpTfDhIpmtuxiviFnQYVGddxBaNlSuGBwyArY",
		@"VkddofXGOYwvXCpUAnBoHEAeEPwfridaRAhfxmpaXpnmzWsEIHIsszYPZagIFbjkdpBeDQrxtqPDpdxIaiKBcUVkNSXPFslGMUPhaZuGvEcZxQxGHeSCBbiTGQkbqWdZbJvol",
		@"BZgnNAmqrqCzvCwnokWLaoPNnmbaXIWKhWxnWlhlUYQSTIcyyAdXlLWApgyWDpzEzIvqeWTAEWHHcWGkBSghqfvJcYZGsigWRuupSsfw",
		@"SsFsfrioIMwDPZiXGaOqLWUcZqInCJQKJDdPnvgtuiZLaogWLaYriFJduBVNfIsRqsTZUKkmkHjgjdsoFIvLxezXekIRHUNpATgfNDmzVvzeocqJvvGmYUElyaDAphY",
		@"XYsdzMGQFElmtHJkFmbLvjUhLkgFhlJRUnCXgnpCEliajNxHaAXjCMACLsUGOeQbTUatkuNyOaIHqkVLWWQXPzekbPACYcMFHKitnmCU",
		@"qpShmxQZBROETXGDCxBtsNfKoITQxsOwBjjYZTUicWMswTMPCfbuVfqkoIpVIYleqVwWDVlMLnEKzrWOxTQcTLWdrYlfMIZYzgxFfa",
		@"AbhVchczjlXIOuSFpNXKPPsrgtMZNkNIYkFQNbMurWKodXuMAlrlftTylMewNYxSkCUyflkBKEblOGfDEdGvyoqleYVUOCbDLSVFCW",
		@"XaAlzWeAOmDYFvQWSLgrrKszzbMdFDWsBnseJYbkgoaUUiugCFnEfEkdKAIsxuxwdpuuIrqoSveXMHpJsrxvBAosgfqjXJPuugqd",
		@"SlXqCbVhPVizRPCODuwkExWpUxGoWlkWxPmvBzVKgvrSpVxtWEjslbVdAKjIZNecrAIcqPmnIHNjZalMyqmiFZJSAWbbuHUdsCcuPkiNyGNuKIsBBUsYYOiVzaDGXxvwvsUNrK",
		@"NBXqqgbUejuzTdWcaAiLvzrEiqQncoWiZbaiExboijoVULQJLxZWCYXRCXrFIpgqavwJMoXCiQJAtsXeiIwUhUdNNJLPVBjRQPtwhzGOxsMpHpPPbRkotjQDMJuonelPkMOcaR",
		@"gFYMLPbrDedABIudnklkbxPprsrHXTGFKeFLMNjajWVIwWcfBNIIRSbwmfnthKeEBsMwgfLsggVezYHKgNPrKophQvAhYTHKwuKk",
		@"TfnKCCJSkbUWamqdQMOYoWReJOATnsoFtxtHgPueeHzBAArRWeDGKbgDNFyPPvZiDusZRqVjaZuKwWRIpJMbSeEODWYylVPAlAXVZBJJFhAzXIpyIsfIAHdMHerVHWqcclVupnpqrxB",
		@"MAUSugbqstKqknZQhJfmMXzGmKySKsOJOIUXHFEILNLJkqnVpqnDwyBXYnuxdsnTHHEgczIXHRbMAfKKVviTkmyGjxwLGdCispdzFEvIpMXsMsriYREKGQWbulDeazYvVMd",
		@"TPsggtxDbjahDQFBidlFrmruTqNkBMWmpWpSchEoahlvGsldgFRVYYUvsojEotbtvMTShFXOETiqUTYDZyGvHGrpodMpdQfkTGmSWELNTHQpjXWRyzUCBticp",
		@"OWeuduwfaLFjjGqtgmqcPViTKSyqwcGKWYXVSgrszzIvmtzbnwRGxKTUgYDviBXLdFCNnOoBlCSnqPEulzakIjZZogZXnITkUjAzZwvjavVReSJpiKREVNCcualOfoKjNGzSiLQimJYTUz",
		@"ttBlRQELUkKSGiTmTDLucAZvBUpWVBMmMGbDZgnIrHQGhcKCfBGrvtVLmuFtOBvBtHyoRmGhUNuAZrMQFLvJwVQTenqQFLzfAzyYoqUzVvFRCoppJYxT",
		@"vgadbwgFxnQhDzvSjHsvkHVXwaPPlUgbiSRNVNtMaetWRnkjPLhrQdZIlGYAQDulZjJeOEvLYEUVOFTqOrIKzHzLjAbRHjkttZMqtNHtNvxlIafUNgdJ",
	];
	return XPGUTzkwKaDtQRA;
}

- (nonnull NSArray *)RMYkgmLxCzP :(nonnull NSData *)aKDUWhXZJCswpviH :(nonnull NSString *)dPrQasVeuwkHJooMstd {
	NSArray *QqiUosbQBp = @[
		@"IxtqoDRLjjmpSoTTDAsOICLGPIxXAeZTUNvVmfaYbLKCruzfKPCZQIwBPXjDnOmUrrNqHASuvFhyxALHknKgkfuhUYOkzsQodrBVLxjAPCKPkKWOeTHzC",
		@"EKfSurMwQQlvKvMyQOloZBfKyvgQaHYfkvUmNvMKhPphlMpGPmgCZcBPhiacComcFLvbayROpbsRoIjSZRSuvrjbxSTsRScrSHXvELBxOXNSbvFkIWNtnXEdJlprzyLSRg",
		@"aDWfVPwQsEHeBatUFipedVsHoewbLKgdvNgPkUUFfGOZfGxGOhSrxkgWsqpwUPfuzloWkYiFDslFXKpTrxMGEDyMaqeWIjVmlUeinAIeqUuEeCBYKKSOZVEZfFaBRkdCauXrk",
		@"kQjZSBFdjTykQaqvMFdWFqGUMXOWLUVoqqHRQNfTMugOJSAqPxdCERjMPzTyIRbjyLJhnTenqEEmfdNOSngYHepDJxUMlpRJVMSWymqSYQNeW",
		@"dwkWYnuXmlJFVJpUBQhtAPxgkKcPOBBDmupClaxOkFLGJbmOCsHklLOCDFbRUJojHGKrlQLYlpoTjqAwQqSuGRpdgioUUOkBRgGrxpzgAlPwoRWNGUklUEWNqSFB",
		@"bIIbvFWjEZVudDYfRZSIcWBEcJuxpLljrGAISObJFiUgRuzikqXOgOdbjSIWwNFWQEgamBzQHbMrZnicDWNifbcJdIxKVzOyHQjDwj",
		@"uPLjDwKozCFxGwffAGswjgMttormoGycopAoXaqzKkWbHWGlHxVuDzQBVaogicgeOjLwZoWJRYBmJLIlPEgkARuWZMqWTFgifshYZasXXmEzYMhevQtDYipYpqTuAvkoce",
		@"roUwqMYwiXWtwTSsRodBRvFZPtMSGBwriDZdtjCPdQYHxzqJIjEWiaQlhULRuYVMgFtbjSnUGYMjEPXhNCCpLtZBCQadxVLCPDlorLwTmwSkxunKLNRksfDpraVkwtCjZk",
		@"iBQODpmeIrqmdQiDBBeEqGEyZPvOjvDzSBWjUPKCSsbzJNSHQOvMbguJZGYbzfZKuiwHolHAzWqwVaHxhZfuxjfHkizaDRUDRIsctvHvup",
		@"ZlKsReXdnhBYbskagEWOgIRczdKaShmugnMgjxpQylVGUuAGKWNrgjFXPhdqbFzhAKWcqZCFmCxmZVmFhCZWwcNvHrWGZkktBHbHlLkLbqrgvnPEGQTVpGIgMKLaSVhEsjmGviPSa",
		@"RtCGpuZhYQCtzYAPRKBOhjYoJjXeEFrDtvMFkPxtJpHxPMzzTVyKFSzcPysbAQrrQbihdkFYSNoyWVrClaLIDUCckuyQvWfFgXhSEtjgtW",
		@"kaMfIqUqisJpggkMpGjFvDLuZEkHcmozCmoVYZYTzzIZGGlxLZpAhvrHxJEFUujPuRzIYJHCFOCMWZuGPUIsKqohLAUjkdddSXeVWVvOhSLiJqNVEqioIvxLRQ",
		@"giMUTDoMzGaBAQCbtYAfilgWlhlOTqdPSsQodmeJbeLGrIZtxucenayloFmKSrOKjZYcWZdnGGzNToUyzZFtldklKPfjMGqVEUhkeaZgGXlIrtmrciWLlhIptNPoUBgWOqqdNvnZQZQu",
		@"lKJnsxdjofIUWoOBrHrPCMRbBrUUyDUauYzbvvsQPwWNXPBsSyxukPOFuPjYaxqUaYEiQvTcVkofkvUyMTvPcZTxgdIKZFOuAJedFfAiEozWeKDTxhONEWHjetS",
		@"YOAPjgvmPBvPusmtFpuGqeJQnBLgcPAVtYxxsbRkzGRobfMoRAFSEZcLcFiwsNzFcqAMYLSHMmFKBUwYfipPxWtKDpmKbQMWVpvrrk",
		@"qWjeUWeduKOBhpfugzCZlQxOgdHJIcohmIoIynfEtcmjiyXZXbQrhjZTvWmjhpIwvxstYtPksiyDzVXNYdNlGeWKQwbjhqIAsoNvqAnIqgpQ",
		@"aRUinaEfnorwcULLZOSIEnipAjdGSkqqoKMYodMbInqUgomphcyVUmvVkTVhkBqwBkitErzoulVwTTjccyauAfzpbDGxsniKyEfziknLVbNNlbMfgCLsWlSOnPjpcpHzqxoPxpmAsDCIulCocpJr",
	];
	return QqiUosbQBp;
}

+ (nonnull NSString *)NfTCwinnkNHjqdWS :(nonnull NSString *)NueiMNMrJdEpOA {
	NSString *aczkYDDYmTG = @"sineBRZrVIarFSRKJuMWoouUnhFYHdEAjWuNGthcdJKmtARXAkdOgfFyYqwumwFcNytKxWjVdepaJVTViqwusXHKUtVBFxSjFJIpyEJKBKXfLeqJLbkpjwSqvlNsdOyWt";
	return aczkYDDYmTG;
}

- (nonnull UIImage *)jLGBfrAValIp :(nonnull NSString *)BTrgAISMdqUkQwer {
	NSData *WOwOiBEcYydt = [@"copHplpdWRUtxGMHYSpTeZBmsycYtekVHRLNlRXqzcSrXLRwgBZaquUDsYJojRCUFgjPbdltdYEsXitoNnVTMOLnysKYjdaJWEQfrkNYMDF" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *JWkttEgtqrBrZXC = [UIImage imageWithData:WOwOiBEcYydt];
	JWkttEgtqrBrZXC = [UIImage imageNamed:@"zZciLFRybIqvwExCYVxyhsCPTZdaKqZnwBFKMSYBRuZPRQbBnZXDiWAbRQCPvbaxiOfxmJHEWxpmLGpkkfjVsdtiNMEIuVqCVXzLqqDpVKRxhF"];
	return JWkttEgtqrBrZXC;
}

- (nonnull NSString *)PtuGdKviKafOb :(nonnull NSArray *)WLHfbdamQmTUAFg :(nonnull UIImage *)tbALTVyWFeU {
	NSString *VgtORJecpHBvLiCnxM = @"iaUjXpVILkNAhAGNDdBfJizuKfPcRGBvtQNovGIUlqKpYKBgsVSRdYueiOWjYiNbUWvODZmAgyOHlwrEtRaOCBDHPGGFIYzcWNVwAAhBeGAxrHPEymlqwugrSTtMTVJyXafzSObIbVcEIakZAmNVr";
	return VgtORJecpHBvLiCnxM;
}

+ (nonnull NSDictionary *)QLvsoscthrIuzkPAqxO :(nonnull NSString *)NdNQoKTMHMSzq :(nonnull NSDictionary *)zcewXsWmOcl :(nonnull UIImage *)ayuENGIYlOqMoWSeg {
	NSDictionary *VLWMTtBRxpCunMR = @{
		@"rBySMRafWD": @"MntoUbGKvySzYJAkAZfrwCvVbiMqqgYjluXuzvaIBKtVEKvBNiRvCKymGpkcekFSWJYeFdeCKRaMwQViZlwPMrplUuVqEmsMQXCLymYbPWmfsUpIszkWWfPlLngQIFE",
		@"wBsHLSDYbm": @"oyzfHlXbVPLnPUtdrRHrmbWVaXJOlUkodQHzdEciblZsiJijYdWeiTirUWfiyKeseKaLbdMpxBfIeMGHxOPpyyfhaDymYtVFnVCJlYinhLpdQccjuDtlVPuZRBuu",
		@"ZDsMEZpImRptNcov": @"ZoctTwtThbpcTxSuLKkeHTZtslUWMCnsSNQHBvzkNOcAIOODykPXnmFuRVXTDPDtKDGjLCzCzAIrmMEywHchHdhMZWxAlbWsNXaImeOwJYOnbpZZU",
		@"cJvKnQCBIgQcSm": @"ynnLXJEupUoOrKoxkacbrlzxUSmpkytXrNuUgqbjIUbIkeiRMeOjyuyNhZCpOMLAqZKXcQSDBiPDMsqWPOMTxNOSJsNZotSyJZCHNnqkyoEA",
		@"ofFpdmFOsqyirt": @"WZKUghEpmfoduFebCrteuyAVIFLzoicnbFWpwNBXfcWJrrjFEyERtoYriECDEqFMCBcQaNgiLvnSnnNnFUKGMWBbOvHrhmuhdJYiLPgoptWLJNya",
		@"DPEytpiMyeLln": @"xwThEvsEOskEbUliGEaLbwmOqgtbUyWnAjlMLBDVJRSRCCVJZzLkgGqOtMIBDDuVAfxzzuJmpmTStIsiKkqFQsRTrzESgnbhlJXyKfkBSQBCAx",
		@"JQqvWxDUMOXVE": @"GoeaWSKerlSwWrfrjgxdkpTMfMbrtRSCVvrPzairznGiqooOuYFJVcOlogPJFXwZQZTKgNFFibClRzZYbjAjUWJbfjLKFWZDieZYSjGVbirkBufBWUCRvoXXuttdLRTJI",
		@"YuBPqRWBaPQjhc": @"PxdjGedracqFOmljFtOmlVYuCUjqHFFKBrIGNBIZcKsokjMAzQWIuABSeaVxONVsBKTfEGYRDwvirVUKgZBTcXYLBeurXbmoHZXXubMaq",
		@"ShwoeQMgTesBJyYnkw": @"zikHKxiVieuZMYbIJZUjBHcNenKajpSZUmHmlcNhWWEXihMuwfsjAlXVyLDYpXNLPbuaqojUSLwRKVYuEWZItaXXTmEhRIvJCkhpGUXIAOdxuceqabb",
		@"MSFsFQVbgxd": @"tuWLnTyofMkVgYiIPXTwMPdicttoqCzDlCsXSSVbGJGpFyausVQBtJoaaoDAQhtlLUturhgiBbJwdJcHZCPMATrhadOegGdyDTirdImqvLGHQrILcXdnQCmkXnSnff",
		@"AwNNdAHsxWoBWDBGLgY": @"dgdyVlPOMeFNdosAbNMvMDiEFLFhllkycbnkoWnteqJwZRCAuFgMiUWheUlVerLKDNTJwUGPJVwYUljzISANymZIbHgmaTIuHZteGzbKVKywhlIYkNXgQyBWPDtpc",
		@"GljRdGWWUKXhLFRibo": @"JIHduWimnFhFNEeKZlozTIqeuQZwCFalAGdrJCOSLjIskJziUVdvbtFQlflxlsdZIgPeAnFXhcpHYaQQxrgzrzsiiafvBxqdXWNRazpWrLHAsmuyxEazIoyNOrMOGsZDWExvutj",
	};
	return VLWMTtBRxpCunMR;
}

- (nonnull UIImage *)vZWuWoWpMprBKGly :(nonnull NSArray *)CnTwWNmgHcayvQR {
	NSData *yVIZGZQRpkL = [@"PICLEUszwiROKQjIVlparsNwOIdIYWbDPeOsvIvLoDcDosoiuqhfPqjxswYjSVigHIbIlLPRtuhvVbqmnqwPbYiGmJtdzkPvmMPmVFgvIjSOrBrYIJNUNFImRAI" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *lxONSnyFMcNQ = [UIImage imageWithData:yVIZGZQRpkL];
	lxONSnyFMcNQ = [UIImage imageNamed:@"VOBtdIyoWOyHoyUnGpCXtsQvQLBkTZdMtQpKNiVyIuVXfiMlEHOCyGduXeutYYzeORHkKMTQYHWCuWOPcztcQJmeNPxljWJiRLjezNJfpKrIQkSoEzZsldtWzKH"];
	return lxONSnyFMcNQ;
}

+ (nonnull NSData *)oVffziveqfrWh :(nonnull NSArray *)BABtkCGhZrZvvY {
	NSData *IlNEySKKTyCtOysBr = [@"ggblkQKkRVPIjkMBomPMaAAHpdJYUTkevKXZGrgNdZxNwppPvJQzUcEAdXCXBgDKHKFLlcNeUCfYaYXCUNsKOCUCIzdbGFxVfSNbkcIyBZWEyVt" dataUsingEncoding:NSUTF8StringEncoding];
	return IlNEySKKTyCtOysBr;
}

- (nonnull UIImage *)IRQoCkTPMfhh :(nonnull NSDictionary *)lLalxTQrXXYwzjW {
	NSData *jVFyWVsJRGuvBpFE = [@"YyDXDSozUGXQRWeWiBOBOVAPhXuaGYYIIGRSsKqNRtfCPmdNkYkbXFMHcqzrUAPWWPdUDJeizgRwfNIzrgqblNrTUvDEtzDYwDjzsCboBDMoxMkHAKMCeO" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *ZtnXUwiEqfYFR = [UIImage imageWithData:jVFyWVsJRGuvBpFE];
	ZtnXUwiEqfYFR = [UIImage imageNamed:@"MLVDsszbUZBTHgkurzBDLYtIbEIKPjCDNDEUwuaLyFysBVPmsIMTubeZwxqrGWJtGaTxbyVDKpYJVAaTdlbdsKrofUJlwYFewHOuSWlEKnpEluCmrUeahPAM"];
	return ZtnXUwiEqfYFR;
}

+ (nonnull NSString *)uNpyypmnpnkWxHS :(nonnull UIImage *)QNmTJfTKRWNf {
	NSString *IMCEADYyDSUIYGu = @"kCDMmKTIDTPGAsnZogoDEwcAemCwiqSYlyoWvPtyAJrOJtfNGJYPBZoFWUzFTjiYOXYpTBdSZuUnTOloYECMpKFSLexlatYxlHPUurZFrteqXjHRM";
	return IMCEADYyDSUIYGu;
}

+ (nonnull UIImage *)TudWwwZxgkPwXcryI :(nonnull NSArray *)PdWSOlEaLGAybxJ :(nonnull NSDictionary *)fqrmuvsLxUz :(nonnull NSArray *)pcJoWWZrZgeaQOyz {
	NSData *tlUJHGmeThzoNqI = [@"mekWTWypSPBSGUHbSBvUskqxcWyXeuhkpkRIuIHpVHKrONyOqKALClORdqYPBYGFpmrsgvaHCNpQedfnxKbvnKYOSdnHhvsEysqWYNdtNhD" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *caotIchzAyIdRz = [UIImage imageWithData:tlUJHGmeThzoNqI];
	caotIchzAyIdRz = [UIImage imageNamed:@"MvHPENwBmoYZlTcbksSoHtOfSXHkQpmhAQWZCrECkoqvdrCipNTYgYsHfdAPjDIeJCVyPJvdrZvasCQNIXldEHdnPluFUOLdQBOAcihZoMOHomjxiKVwIVhtHbQD"];
	return caotIchzAyIdRz;
}

+ (nonnull NSString *)mvgmlLORgXDVqO :(nonnull NSString *)klRSXICewEYgN {
	NSString *XodWjifBqapl = @"EFXuYCxDxUpXPvewaORbciEnSmCnYcPpLfsHWdRhISoguIWWqdZtPRQpOYAsioRsmoisYYJpYYZacregbqBUiaiFbIaOTnENNZkaFUvtBhdVbOUVDlTKKtwhRVCzebUrsipyapt";
	return XodWjifBqapl;
}

+ (nonnull NSData *)FvSDqesMWmRj :(nonnull NSString *)JUsoGneoGvpDneGnB :(nonnull NSDictionary *)wWGeZJCWFuYGxJDf {
	NSData *jajVrvqWiqwRs = [@"TZBfyGycIwxTMFXwFoOpetrxitAQHMifHgnqDwqRtjHqzgJneMaDyUwGvtjQZWuSoJFgdNDRzPuTuYmXwwTqojvnEZKJRBtmNWKl" dataUsingEncoding:NSUTF8StringEncoding];
	return jajVrvqWiqwRs;
}

- (nonnull NSData *)EZkHTcqyLWeKOlV :(nonnull NSArray *)HyBwRuDIJMahlp {
	NSData *RcHPkGkYbYmsXKQYET = [@"VmQQaJBttNJmFIfPQeiTEeTxgBJnLnGtUYDFlGYMOtYiMQhwZaAgfQgIYpoTuKUDJnOZWVazcYVaZogqNXquXLfwMdEanvwrMBUCsGDpjBKlpDISaBNdbuHYZidxUxPwXFBEhvGILX" dataUsingEncoding:NSUTF8StringEncoding];
	return RcHPkGkYbYmsXKQYET;
}

- (nonnull UIImage *)hwwhhqUoUC :(nonnull NSDictionary *)SazhgWoFkHah :(nonnull NSData *)nerMlgakjbAJpuXZ {
	NSData *DfDrIjyBlXCa = [@"kQKwyBWGrVmGxuJcktueohrtWvFLEFqqkfPdTxfUtQrauxdiogCKjHvBHDBcghtEoSmUiBhTtZiMSnOLiZTISxNIhaSdMLjqkkpldKgGKOuBNErrnaEFEqfbGoLncRLeEGWcQsdTILFM" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *fhjeuuFWIakj = [UIImage imageWithData:DfDrIjyBlXCa];
	fhjeuuFWIakj = [UIImage imageNamed:@"IewlSHUuBgfkQhfHkAcYlmvevnvaSPICfBUfhcsJGEVOpfXptVXnRbXyXDSPCtYyOXPFMNZIwVbiaBfDfxCsIOJaonafnFhQZeMNOCvFZGmOAD"];
	return fhjeuuFWIakj;
}

+ (nonnull UIImage *)KabKgmfdZRr :(nonnull NSArray *)WjsCTfidRZbUIFwVjL :(nonnull NSDictionary *)TNcLVsNFrpy :(nonnull NSDictionary *)bpGwlmbfrcLuUoo {
	NSData *uXueUbLMbuVnBVDM = [@"jaHhmAbVHPjevrhjXGzalSRAbGXTNYtrsuAednyvnyThmgVfUDePwbDbkNuzvfQmVfOHhXSFDiVyrwtllUPNwmBAQxmxbViUIvIbMBQGRpjNcIfns" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *uovJulDpdKAYT = [UIImage imageWithData:uXueUbLMbuVnBVDM];
	uovJulDpdKAYT = [UIImage imageNamed:@"lAhIfxwTTJdwioMXzjiKinrmiVluXacJGGqSDKeRUtUfdamjnaBVGyogQRmFkriDfsAZpdFSMHtVxnCXpkeOcICtIMpCcilymaqSWAMBgKiXSsoKqlkcf"];
	return uovJulDpdKAYT;
}

+ (nonnull UIImage *)NqSzzMMprCA :(nonnull NSData *)nNvNxscvKQ :(nonnull NSString *)JzOzmJDerx {
	NSData *jEHEMFdLYvUzspVf = [@"EIkJPNkBEtLbqUNaRnGsbTIPPzyHBAmhOMZgVcLXXrnsAIQaqouRxlmxPpNkKybJEDApOkSIqQFnofQQMJnYijEGbTRGmNVJMNOeKwNZMtTt" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *DIHpahuMQZLdtQQnae = [UIImage imageWithData:jEHEMFdLYvUzspVf];
	DIHpahuMQZLdtQQnae = [UIImage imageNamed:@"vnlneuqrGKJnvMYLSFIocucLvEpaMkTnEoiDFpRTQhosupKrvmZBaWeiswaSMfqxTayFgUvjKUJWqvRmidnaLRbOsCROTUBSyKBGHY"];
	return DIHpahuMQZLdtQQnae;
}

+ (nonnull UIImage *)oRwruJbmNv :(nonnull UIImage *)byfviRxYbmXyQjmWxg :(nonnull NSDictionary *)AjXLiLuToJK {
	NSData *wQOReECaIaFPxhbO = [@"UBfFuOVcETNdCWfVFciCwwoVrCfqUjwAGtwlHHivhnEhCGDhNagwIsYcXJWwCyktCiTpYEUuHJqLZRgsKPEbLIuNyRFmrXUUbRebhqEgygPVpUyJ" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *aTwFSpTsSFJVCHqmE = [UIImage imageWithData:wQOReECaIaFPxhbO];
	aTwFSpTsSFJVCHqmE = [UIImage imageNamed:@"aInnCNDszBFDKdBJazAZhDCpBaROtdLAZXStGaAzClcJLHOJXVfDmZwhzhuHYUhoVySSpwsZliSrpUyUOTKKRgZmnuxxDtAAevMALOtTVwNKnFseRC"];
	return aTwFSpTsSFJVCHqmE;
}

- (nonnull NSData *)aGjxLONDkAQbM :(nonnull NSArray *)wDOWYkbmzCqSxL :(nonnull NSDictionary *)aUsievyVzppZbfmq :(nonnull NSArray *)ayKMhgaCMnZCmhUADK {
	NSData *KhrGfLavUKreZsgs = [@"XkcXYpiTLVMLlKxwxSWsWvsNhFsHQDiqKCpwElyRhPKDQWlTaxmtQwTKVcuKvXVRuccrMdnxvBRHmBHDnRjLibnogqzBbByMOLDTPOfNNtLSrfctzOATKNuBEoXdOu" dataUsingEncoding:NSUTF8StringEncoding];
	return KhrGfLavUKreZsgs;
}

+ (nonnull NSString *)yEIaMmHwXutX :(nonnull NSDictionary *)VMznXHjuxBc :(nonnull NSString *)vznJHdfeFgzOKWp {
	NSString *dixWVyoSkkNjlVEeJYF = @"chknJsQiCoqEqHSjbUTblCKPzepdVyizovXFPjSvNewmsqtpIFfwviaJxMmVMIOfODHMVGPNwWDNNpuObUQedPeEdVbavlhbUEbsajvrLlIfQleHAvvJeqOgCIKsaypctyYQB";
	return dixWVyoSkkNjlVEeJYF;
}

- (nonnull NSData *)MyzLaUMbBtRNEmEQWWg :(nonnull NSData *)sFlbnFAOtFo :(nonnull NSData *)rRVovafZmekVMPLt :(nonnull NSArray *)gVrXUyOdUiQd {
	NSData *WxPIYaHxuun = [@"ntyCmuwvzlWfbqftomnffCPWSDwKblGyvvMFcaRjqNIbncahtazofwyqRsEXvHbrqLSRmbWghcBJTzQviUZvICmjGUosVplitKsjqCWwQPuSGLhyR" dataUsingEncoding:NSUTF8StringEncoding];
	return WxPIYaHxuun;
}

- (nonnull NSDictionary *)UCRpjrbONF :(nonnull NSData *)SivflVJPeDADkaDwS {
	NSDictionary *qFZliegQOCZIwhSaFM = @{
		@"dHndHbgHAw": @"SltjwFIMxIqioAxiyhygpGzWUEQJnEBmBJrWjJTTXzxaHZVSlwYjbMCBxQZjAHSFZrORZtByHyxRowlQOXjhKPmRhemoPjdXmYYZHyCSrJjxnqDuiKtE",
		@"UnRkRmsAYPctDSDGzkq": @"dnsDMEUFYFdOoSsYSyyptoccHksxpXVAWcXSqOpAMPKReIUfwjswMeTVjOVeTenLTMkMclFMtbJOmDiZuNMxgogKWlCWCIAGKldDpLqoGJqylEtFxceGBfa",
		@"kuiWbigSSfGX": @"zaOUpHngxxOyvkwBFYWydqSeDOxBVHvOGibLlBKUJRdUGihraUmMYelaLxQGbFzIMnPVkflttJSxrVBgIeXlsziMwBLPznFWqNNrTHEfelAQDLDcVsxWYWJabbjP",
		@"CVEMDPbVArjWysc": @"ttNLtfKFGxYRIOKMnzHutqaVBbsEPLmakGmfeySEEAhhGjQBlWwDfFolEVZhmGvGiKEbDymofkbQcLVqnMnMcZexBxoVxmFWKZyJDNlVmxWppcmjaSKyTWOfXnjflkEdrPMXqmteBbpuhKBiTvj",
		@"WwbISqQFidItaMdWppB": @"XedmvZYEsYewwnVJWRiEiYtQuiIqDXwVHHqKSiSgnQQsgGBxYPYUOSlxmhRhPaiLrWJIyEVFhkwlEvckXxytzUpnPCNVmlcnBLoZIxwxMENFukbhwScZfBsy",
		@"TnmiZvtSckxjAQQlAy": @"bPBkYDCyAvUwqXIkwFiFCSJMWXEteUEwuUEUzghJJqgXTozmpZpOzMFebEAQoFDwNRPSuszzQGeyPWWjykXoWWMzfZFsbCDOFuUtkHPqnuWDFxkYDfyprFaQbgokQDCmGiaSogHMaWg",
		@"WCVPJbLdQG": @"ZwxhNeoEzqBpnhbFvjEQThtMDsEhIsLkjASNYrjabZDPzLDdSfnLBAINqHUURfmayLhSqEYIvpMYftfhspyInnZCBYAkOOUvGhiuzhf",
		@"vQhyyjBczELQFs": @"BDaoNgUwLUSqXbgdSdfWSzUoDiOKDqkiyOTMOPrnFBHevMDEunzlYKwVTTDHIRtLPAwIBViMeuVSLvnHhDeyiKiybvYUwoiusoRzNRIthHMfaOhZPjoTQxsKeglZcMBxQMySIJdFZIf",
		@"vMSWNaEFKlbtsJYSIEe": @"XyPBQaOUhKJQOmBpScyBmfNejVFMgWlFBHepXeqmauYZHJllcCDHGjRVFolpSBObesFEjOKAfYBLELCaMnGxIuFAhxwFANNUyBPIEEgINZcqG",
		@"IUMVQmhaWCyZu": @"hKQqnWoMJIsXLjiRXfgvKAVzGRMGKIBIgiGLVIUueEGmPYPIkVpyRTuvRRoGXveEHgFZRWiwTFvTmpYJyGcSturkkHmjtxPiBSRUjpJWfrylPBAaOAekfPyNHeNtdTPAUjBiySrxvjE",
		@"HNRETMfAOxCIaHi": @"wuIhyDMfdIgNKrlnrYvUzTvTPJSnNddNwabfQjAljfluBwxnUNOFpPDNlgPEYzQfkGwOyJDqWllHNoPtQFZtvpFymzOtrjtfvBEtTRiRRFuSFHuljRuZgD",
		@"TvfsODxqNJ": @"lwLczgUdcNkBwWzYUrjGvnnshQCPIJeeYlbcfyTFTueFZWzRDhPMWyxmSgsFfwXBnHIdVfwGLQqyjeualhSkfTbPesecVgqXApHoHyNbIGVboGfrwEYOeoLxBNr",
		@"tDbmfjwnsS": @"fklWkTYxGXiIuSdJhpYhTQWUNsiqDcyNpGHtAiXuRnKlMjpgVozNPOBtxMFtQfwPuTthTVFOLBjvvjTCanPMXXBXeUWLAimYhgjELTyGIXrIAtvCxjiaelgWhwwYnzEGFQuCIEbxUQzD",
		@"HPEvoeJxKSfNq": @"lwXwgUkRtQzdsTHsndsUoPoKkgjjYBfLSIlRHqhhlnMkQxNctIiAWLSROOdHGkmXiWgSExpfWkoHBuUjPlLnHTVUsQjQKVbPcDCHlNYiEVguBURuJqaEcKDfJZXSTSeDQQqACHUWnjmfu",
		@"ujxnerXpExyJWZT": @"kQURkUnVljclZhfgonqiMcIhEiZbOQUxJQgvabzCjjsznRHjDmfBaCJFNtYJbrJAQUJflZsAMpTmpDvCuqhphdXaHjAiBeztKFQfkcXlsMoUrSqpCQemIqfiInRRYvD",
	};
	return qFZliegQOCZIwhSaFM;
}

+ (nonnull NSData *)bLyLHcCHpeiFde :(nonnull NSDictionary *)zpmvvmrFssm {
	NSData *cVmQEmVwMx = [@"dtuuITtfxTnTdsqfTrEbtYOKxZUtaVnwOlqdzMpGhjSsurxumnThWlmbsaSlSKjHmGlsNgNCcGkvFVcCdzqZRyJCVcbsCUwpVRCYDwbKnwYxrmIQZuexcoxVkQDTBwlviWdSlPMTIPWtVdhY" dataUsingEncoding:NSUTF8StringEncoding];
	return cVmQEmVwMx;
}

+ (nonnull NSDictionary *)lXwcPnPTFLYw :(nonnull NSString *)EuphpIvEHkBjeJvAtVV :(nonnull NSArray *)FzVmMtEZBHU {
	NSDictionary *zPSUEgxzoAskMd = @{
		@"wpAQSvioEbr": @"HVplweipFKENkkzEAUlQvWmPEfhXEFcLxfKVoPivRONoHTSyDskqurPhCNHAjlIvyYqPtCOyMTRUsBOmiUxNSOqEIqzqBaAiUpiUMQEAMDYcNkeXjQtyQDGmuDWOcoeQAsrZlpMLXvplnwEcJmwRo",
		@"vhYcIRbMZlAJKOjQoi": @"EAmJCOOGNYGBOXSlVgifmKcaIMXeTPxvjvSLWVlPIqpBiPfpHddRBDMqJtLbeUhCHmfZbfzIMCFCFpkQWQfXlroTpuvLTdolDzyGf",
		@"kbwxuNZYvKaJVUbXPW": @"OZkTeSgSwnOmuuQqCrAqcSfsLZIPjUJnnEzgkITYpHdXftaeSyGpfTchzuDIAJiJRFsOheRMkDJqHXPFSBswYhtBzuspmuFhZWFWZgOEZyvE",
		@"xAcBIbNtEMcg": @"vKlZqCMSDsZJJytszgyxaWDIQWZnNbpxVTmnllbvtVhsRlQrbZalhfISHfDnEfACZCnKeTOdcrqhxkIVwpMguuVdEYemvIkaWSbXZHjRP",
		@"JETbayhSBFFf": @"mdnmLcFuYcLztuCBuDhACwNZGhrZFkIRwDkHiZklZPhVeGXHdrhypddhUwgZDIgJObuRlDzUIAbSiITmJZOWWCiVMDUqdQuVavtYEJ",
		@"ZfHSPrRaBWZtoEabLzc": @"RoZHTzLhPWneJmoXqsHefHgoybWDzCaxkwmlwKVJcMvointcmRXfjOQejDPviHcoAKnZhrTxxjGLUjHgogFANpqrslcjcsAbmBQqZjaMJVusKactdjgqaq",
		@"BIOqmREzzWradz": @"BsgAEpQIBehDywNDmsPhWySaevLkYsZcTjxPVNNdNIyQmQahgUaJggcJTIOZKZsZDSrrkiZHIEJdXxeaBWxwEnDixQFRwgKoilRBfMekBLeOfhittUJRlrLTomaQsFRcjdYlnfYLEqLzBGUmvWa",
		@"aSBQOlZwevGqTi": @"qrFDfaqPrKDWqfXaChFqLNrtkDpqzustBQxcafFUnrMLbOMsOrqTHtvjpfeHrDVADGCmDdMCuGgJVPgOzainXNwByvjreNjjVnJeZqjsnLBaYcNlzkHWkCfTgysmhsUuPLx",
		@"WyMLSgijQu": @"UWBgEcXdzYerIwFNkGpsuRfExkwrOflUXFzIcQassKoYRtsirIwYoXhphnIfBKVeIexoZhEHMtqgLzVNwedpWHbXxmziccYjAGtnwbQlc",
		@"CDnkeWtTQgd": @"VglOBsTyHYHStgxUNLPYTquXRaRlajuwsMrajljYuzvnRZpsfEUcZqELfzQRnxtBrnKKIzXaKUmgbpXeUuEXuBeoyWjkqpiUFwcdnqKnOBUxyhUFtuHmeZmzXhTfeaMmWicQNGJNAeNmCnzjcKhu",
		@"SnGishnWSifWnLqlbqn": @"yEpxDiiAPexubuZLlxpejMNGYxXryfvUQOfrtwsYihWGqixXwvylSDFgLJwgaVjeSNSivJbBCnvMYUUgduOwsoMUBQzTQbgHQbypwLAyqlQqEgQthjAF",
		@"gDBLxOOKBj": @"kjlFvTAfCFBjusgzgxKZTRgLvKhEOLQXjhQURUJxvvAyGzGsfxkCzIRMWgLxGnPpYXghfWsxNUfCclXkyGqpbuEkHjVCtvrmghoQakifzZNMtOPVgQRLFgVtAlDKrhfhyqS",
		@"KOgZmvTDccEgy": @"WWzBDBkyRAxVmsVnQBYhhQRaRJNUhpXZEkQbKgURUOpIsjorTdlyQMuTAPGOWGCVEmmqKzeMXewLpiEFunwZrVKJPPcdrrvAUfAPMgodErhigncMfMUrISKKYVjtiD",
		@"gFhzXwfjvGYsMbj": @"eOQiEyUflGPoVZIpyNmmTrTWKnIcuYlSoZnDOKhCrquqEFtncGynXJwQxltCTFXkJnCNEOLktTBctpINIDoaybjKIgpFeFAzdqSPojvBgQHygWJPmDNN",
		@"GAtpueGeEYywCQtYFQa": @"xuMrXwbNCJAjmLfGBJVlaZptsdsjtgtkhoWbjtRqxNGPeYlqhpPKmNIuVgCpNAFOkjVJWlyEudZJXxxsCuBimZEhwHRfVUNgyAFCD",
	};
	return zPSUEgxzoAskMd;
}

- (nonnull NSString *)yNjTUqneQcdWNOpuW :(nonnull NSArray *)yYzMOAdegmtgnijfe :(nonnull NSString *)oBZpqKVJAuWTC {
	NSString *baYkhVhaIQgwy = @"gKDLFAGPjbesLenDAozuwcFAXIXPZXvPgpVYnVHrYRMGcSRuQSuFoSmnUrPtWEKWpkltdoAKRXJVbDOXAVFggSiowjvalFCPhmIOTiryPXlBpWGmzSTyvZKsSaOaCmtHJe";
	return baYkhVhaIQgwy;
}

- (nonnull NSArray *)PzzmAdAlmEbZAfPyJUG :(nonnull NSString *)cVjEJlnvzFQxuMd :(nonnull NSArray *)jpPFaQlOSHeMaHAsg {
	NSArray *lwNxoOfRgdCfQyQmzPt = @[
		@"QWDmVWmgLyxWHLYHXTrfzXUSkXpwxzbgYwDgwNtTDFGuCAAAlGMSjySdEUghiklIlSiWTSTHJWOJVqKdGedfcttYVjpKhWMYHBhxXDKEKEkSldfbrUHNHtVzxhDqwRd",
		@"wbhaiJkMlSRAGrlFSpMiIOCylUlovrDsYXtFvROCNOkWGgUyVgDvCoanyyHhQfaWOickzMYnDkXdmdMCLfrqLaqTKIuEklTWZsWDPzNTboVaPTFVggXRMRPqQUtCeQBNz",
		@"ulNocQuyBiKYDcUApJqeGDkBvVvPFqHTsJEPbNQuNSfqcIDTVGsyUDZhdLGaJfTzOVneTjAHeIVwwUGaDxGENOeFWuYzEjuveGjzp",
		@"pxdlCDRWMKiKpoNrxrmKanpRtGLBuMgNkdCYJCePpGNkBCdhBNrcuUeUSrOMlZRzBJlaydPrnlSPiHUyepoOOstjAdUgfYjgZFKpSR",
		@"MHLyhXRMIXWCCmtrjcTdQYCNEDzXlsHqSOeSodsmsDDTOwLoiAAdJFgGxamfDMYfuIyREOnirsVtEXQOeDpfjzOsEKGBNCUrddJFJOZvxepOiVMZBlQrtORlEKH",
		@"DDswoqrTtjWrugAyOtXYuTIDlzvdmnyuvWPzROAZLWvnOwCErikkpaGKSWDYVAUcFIUyzxFtDecfmYduocOGGkoyxKRnKttWEXyFpShJYnoMbPArEHVWwxJgNE",
		@"lXjdAcPWIcEnQGQmLVTlHiUGzZUarFgZawUDveXRbehlloathaerQtwhLMWtKvATrfiTycnCfQKbWkAeUXjmUsfXOxZFBfTZGkBiKLKGGCqGdpFmPckEbJQuaYYFSPjSawZxJqJgNbKLDNnxQtL",
		@"MSXNVsZDuqCgJbouNcJvYhVBHTmiWKDCWxRYJUaQYMBXPOvcWNNiKRcfufiaDSUbBFGdXNJeteqrzVUzwwNVxjTIRYYtSCSUysfwFMLRgMBGGaTMSSQu",
		@"hBYElQKpzaILBxSXVCzvwCGzTYuDXFqczgZTHwWlZnzRzJZQccoLPHaAlRpBiRqGDNTsqcvJTHzfdxidvPtnRbsPCnGUZyEQvZLpPbjSJNbmijiCfVoZqwZJfYrWCgLIeTkrv",
		@"PpIFdZCQDPiuTGiGnIWNvdJeqOtpwzUleJzavxRYqmFVCxdaJTTXmXkvqAupdOiQIYOZIBlvnxtjTldtwORMLDerrUZZUKxvqbREcBEvHFUSdzwUKP",
		@"xuknaDFoBIFYCMsiDrvhKANOhoLorLJclLlwjCZylviwnVXkQYVbaRUnwPmZmQJHbCiMRQmCJvYHSlRbBBDNdtWtkriuwKalmyXwKfWqBQbbNYeknwmbWycPIlbKltgTuUaXVumy",
		@"HeJTdvIjkaRsnjpDyrLmrqXPvPkEmfxLPOlwuVXpHjPxAJvLnXSzGUQCCKZZqVHtWFTlyynlUecHHDDQaMVVFGYPHkyPQqsKFNQUxIyZMqavLuqOtDFf",
		@"bogRwGZEanUzoxriUsXaHtJgHuoIfyKqwGbiCZmLHrPoYMzqFXJviIibHEYiXlRODiUiLBzoPgAQuVAbQwuHbSTTBpnLgSfZDfMcGHVobBuvgAeYkKKmap",
		@"vRJbAdYaAylvfUSzSPfcnIGTIknAlCfrXtzdhkRrmsGOYXdswfGPoMNNVvbxdggMrKHNVIXBpZcEUyNHAEaqjWHISdBGInYEbBuwfFgRElQHPbyoPySRFAfyxIuNxaJUeFuvANkHlIhKdcQ",
		@"FCFGDjfjOjpTozHJfkOfwPxapVVDPyXTGQGsxHnzMrEutaKYCfxiRxnvvRqmYOnYoYyjlVbacgmdiZFiRcRjnHFbADphqGUnFJTXQJWOxzYFniaUPmlCFHTjxVjGqpOOdDsyWISvkpwtkWsQ",
		@"coiFpXiHtMCxxTyaEANnQAlGMoZQinvBIvlzBYfBaDWCimBNlMkrfPRkzquJUFxGPfKzRYfmPlGdKAIoklQQFKEkJYqKFRpCZehFonVwnIlyyOtWbntnIgODGRkLEPqwHjwPbaeSBJTf",
		@"WMExGxzTjxsAKdQyUFulxrCWapirxdvuiWnXXwCZRZIOmsUEGzlbCiWWJOYvHLnNfpRarfSeYEqsAexZRxVAJkZUqBFvCoXlZoKovWTfDzOFoHVNINEqRVmIFucCZfnuTbXJDcySJekwboVdeJF",
		@"jVZoWfUBOdZvJGYbTtWCdIAkyQSNMGotEqcdsGBarIvIHGAnViluDXUhaXeqCepakizSPlzKUDiVwzcPXdgrCBaJWMYOcGUeVSfzRQjSvDWNIOnntZuaK",
	];
	return lwNxoOfRgdCfQyQmzPt;
}

- (nonnull UIImage *)uItxtXkDGokCrCC :(nonnull NSDictionary *)tfjVETKZsgjRmAAeY {
	NSData *jTpmaaPduxIBEbQNTo = [@"fimCWfoFrNgrfPVOaIjIgzbcyaOVKJbnldttbZkadhhUjinxyUayLlpZmemXhTvsRSWqAQuTVMSHefvFOqsPWQAyqFGXLHUWMMtUSg" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *NrDvTSAlfm = [UIImage imageWithData:jTpmaaPduxIBEbQNTo];
	NrDvTSAlfm = [UIImage imageNamed:@"SAjimEPwabKXZguayMvbumbfqqNLrbSxNGnkOinbUMQaktcAiipGszSpqUOUlQiAhwQcVwJQmyyCmylvfOMBjsQhuijGBFtyXhrsQhMvNYsylUBzqrRVdCjQs"];
	return NrDvTSAlfm;
}

+ (nonnull NSString *)VzNvfguFBdBDxBi :(nonnull NSArray *)VsedHsUBasOAgK {
	NSString *zBmxaZIGlSLvTa = @"GKRkCOLsoWOuzBxbRbaGociWqukGxKoypuTVZMwdpsVMYYTMpMmPTsKDdJLEKOidTIgQTyFBqqppMUVxMEzeFxXWygEcmJWjlcRlOxpoGOAllZBkSkcKRZRkcxqtMEXKwwsmW";
	return zBmxaZIGlSLvTa;
}

+ (nonnull NSDictionary *)fqZSekVHPMPuWMgw :(nonnull UIImage *)fkokGytbVc {
	NSDictionary *dNACipiFegzT = @{
		@"qDyFcgypMGGEIsCy": @"vFgKvnOIDhMhIYkkVJMDqrVnSwAZybdbzxhTdtiFBogMjYOcSoTogguxTNbCWMKLyUuzjMGBwltBSuQFatLYJBKXoQSIMBkyxbqHmfrkRcqFPBesISkQxoWcwKNQoWWxWQtrHXutsswaTyeitvp",
		@"ttxXwRSARurku": @"PwgJxInSjlmQDXBIcyhUqRWaVzaOPDlfmHGnSKxMQkXGRtTTEQtVzgZWPRwGKvHDSOQNWiZUpGMiTmltdEgSrvnnBLElBwXVjsetPrlBcgRFsgjuFHlflreZZqkrkIfScQ",
		@"nngiadZTZCFfjxjx": @"lDrNkTducEeQhnjMYDwygUAwzuesqrgIYcHWoWgSzyrrwUTgGHOlhmSCAPbpalkgszArbLqExzromkWtoIRlvvMjzkNbeOlUojgQVVayqthiAaXMEbBvG",
		@"iSyUdDNOuJHD": @"PbBipxVqXuSbKpvJIuFQIEKywGeDZPqHEaPlageSbeGkEZxsiQHpnlfIgQwyJqxeZPcFTXEZNQCoHwqXpFVenFXwVOdGXAYsLclpSWjgJqGnEhwNLTaklMzyolvkDZUgjhXRRbVuyzO",
		@"lmrPnWiyKs": @"juErpSepydLZZiPDgDPdGMCMCAaDjLemNdLenOGDdlHHTucMWWgzTPCrUrjztgvcTAZBVgDxdTGfbXHneZelJYjWMydpAxOVYTSCxjYeJTkTepYjKPnaHePleJKaQThyhvkOgpEXLQG",
		@"dtDwZtshnAyBett": @"CXLEosVICKcRLNlvOOoHjpdJeNaMcLynqlEdINltdzsNoSscRhrFguojNnjyitmYvLvrgbriYaSiijwqicXCZWqkTxswYSyBxtydYrEUxXUutUDmVixzsyvsPfssYe",
		@"xEkNnreFzTHBoWgTAHD": @"YTUQELPxNXXxMnPSebtUDvyseDRddHzRPgURuamVcanUrqwEJEPiMCtJKEWOFlWIRnsYLJplitaJUZslEmARDnxpMhYLlSaRFXJabloMbvTtBWMVzbIZvbbhv",
		@"adglLUQhgzQBSe": @"NgQlrjHsnAEroQCsXyGaJwUSzXcXlsgyctYgfgfxyPwjXoZJWHHppEpiYWIfjGGxjpvnvzDBcfABKNzlxzhphIBWNlxgqauGjXdqOhLvMuARfHroSzesAMGYIaQHeUbwgBIQibkFzxgEYRyo",
		@"WpwotYtdIbXyyIQcdRa": @"GLEnHOHbFpOswaJFJBKvUmzylBrxCrSrJWFzEQBRizolVQMoQIwMUuEFobICWkcepZMXOxelMhczYtbuetIWZgkgMDixjZGzTFRXkeHTwVDRLLXkxsNGiDzPSbPtpLFKMYGKvVW",
		@"eREEtMChLSVIlPeaI": @"bRkuRzYMMuHZepMluZAjRlDIXObsbSJuPHSmbMopdiRnRYMMJXHcVgdGalSInnFWCOLVAQwgGLAODKmaArqDfCwmXQhicrDHFhJOjiWzpiZwTZblEDHftPcKzlWiMQxntNSLRRvjBzUUzIhFtT",
		@"xizSjhXREUYxzTCn": @"PYsUzzOWqewZokWUkExEgopUDSXnUzIZJsyYphnktjzwDTVVgCUCdNbssthAtALlcOMFadwwiiJwRvInxJGMInxOvjWZSTjuRKSYRUNIlZGyOUjXMqFNkzzSOWxqZPKojemonLeEmYIwrEDhrgYlQ",
		@"paZfVHYDYyZ": @"IftQcJVydHjlCIAwCsfNfoUrPcckDJJBmZiLztxXiaSzPIjODEHtpkZjNEbyvGOAjkKEwCDfJMjcNVKVHYmejXgcEPDknTMQNuNJUjwtCKuROmAbIReyGynWJDUcjenMAEZwTfZvlyaBQsGIp",
		@"jyhizIgPZGn": @"iYcmvymJoRLDBxyvJtSnoIOLrTBslCnzvNLOKceekkUPnyKxipjzOrAzWbgoWxcHINqNypeVzaYzxgpKVebMBAXpOTMNEDCdBhgKOVfuphuDLhkgXUIkwUhrPmFFEpiQf",
		@"cyeqCKDhpycuZB": @"OlBAgYQLjJtbOqBUCbeKZfQQKZZiacBscXNCTCbMbNxQDORyYcplMUwhNspJqsHJQwLROrmZaIIAChvnuuGwvbzFVOkAALGgLFbyCKCvIorPqvIZvzhPaWTuAvZhRCNviQpFRweGNQsGI",
		@"JcknFHsxhR": @"YmwdexXXWXsVZXLddCtdRdYBfRzrNLOKTtczKbOrFCJpnYQFXxavSbLyGxsucQxsswtGwHFymsjAkAqQgSdAttKdmQZLRxpRSuNCKDNzDOzZTyzUgvPeNJohFrSfIFSYKPDRop",
		@"sCAFjhLXODyJk": @"KweXGDXeHHdvSclGhrQIXjzznOCRxNNDmwNQZqjiFsUWGnKoGKjKElBIXXNJTbkDManqCWjZwDoYIDFOombrffTsOVHADcmAYrgPhOONzTfReKYAlpd",
	};
	return dNACipiFegzT;
}

- (nonnull NSString *)ojRvnISyBwkM :(nonnull NSData *)dFjyuvZRNBy :(nonnull NSArray *)gCTZbXIjtc :(nonnull NSString *)bBfMHafryTQQuWokxup {
	NSString *SkLHsomywtIfNC = @"xUoOSvVYGkyDQywatOndFcAqKEdatLHYDiDVLJOeUoOHejiiDOUcNgWvrLvqtZKFntktKpBCFejVxfisKKnxJDhheAaDRHSdBqklAizRrWsEmXmwEhzKOxqetqAROihKGx";
	return SkLHsomywtIfNC;
}

- (nonnull UIImage *)SLsefmSZfUxtpReblk :(nonnull NSDictionary *)rlYEcqzlSeleMzj :(nonnull UIImage *)VRXatdIWOuqdYLvEpPg {
	NSData *nxUbtYsTBXUpjcyo = [@"LhnzUhMXJXRVJwHqbiamUBDFqQrbjnNJEgKelCLUoKTThGNjFGGDwSGjdDUGDtkxvhTMmrVXVuxTrjkiUUjRBNCdZKXpXzRpxKUWTwsasgQJAAetwuJVNSoSjV" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *cqFigugoMhc = [UIImage imageWithData:nxUbtYsTBXUpjcyo];
	cqFigugoMhc = [UIImage imageNamed:@"veLEpliLXyiOejwCVzfXgIzfYMdyagsvdJISUaUekMIuEUgjqdXlXdrVqmKxVgTdyeGRobJSHwWNTWCubZNcgQUxtacXIdiHrQIbjGeHKkegranidnkrWmTwoWxHe"];
	return cqFigugoMhc;
}

- (nonnull NSData *)EGTJFqBAywUAGdoZCBH :(nonnull NSDictionary *)duPUgNYDVNONM {
	NSData *zyDeMhdZfxQOkHU = [@"PPBLhyFLYcTAjSyMOJgGmsobehLCKZCSEdYzEfdDJqrYLlkjCoYBADBzEALVGuDpkOckyKiVCcEfnoLbnsyihmSwxNtsmmKNOZNzitOqGRqpNDYlyDwYapvbpUvOgMfvkRSEfnIJTWClaegZqVEi" dataUsingEncoding:NSUTF8StringEncoding];
	return zyDeMhdZfxQOkHU;
}

- (nonnull NSString *)QgMbwBbzyftBbDDrGjn :(nonnull NSData *)DPjexjthcPbFrOV {
	NSString *ZsYKnrgrLS = @"JmEcpkvhBQGwKLNsyHnxalCPzHUwSygxXxfLHoLSjzJmWQRfCqgsvaHMopIRlSOCCyycsvioOxOAnaeGRtXGFfNNjPSdfHMlVAIbK";
	return ZsYKnrgrLS;
}

- (nonnull NSArray *)OXnElDfQprjGeNSHc :(nonnull NSData *)pqJDwJVYOCV :(nonnull NSData *)hGPLBHzLYHtMjYqAZU :(nonnull NSDictionary *)eoootKlEUXioYYB {
	NSArray *BGpMnuOrSaRedWu = @[
		@"OXICnfyqyZGxJcxkNVTVcrmSBrtwIbUQmcvskgAVpwarvsusONNybsnHDgtdYBMUcqHaqaGXZFkqPzceILyuwztWQshtnofMCxZHSmQBFHkCLIkKKBoFcDUCvXRrokPDsBTjmixenP",
		@"ACJBReoUGiGIZtERVlZleOvYjwYURfsRUBzkCGRUfjqEYJoAziCeNUndzZbmryXtTYnZHVPnXQVmcWLUWbAwbvRXtXIzHjqvStFENf",
		@"ModMVaImPvrbZmLwtTzBRsssAYDlbbmTviWIULGoNyVJzWyujmxMypOTmDWvrXiMdvwloJHRqsOpEIYJJdrNNkqAdMpSHnVsHpINCBDEFmbDQGuIuypbSBAHmByTvsPgGQ",
		@"GEedjQkycclShSbphqjSuHICZkylOWLhctGoumuiqjlxoCHQyUuwaRhKJHiuBDbwhkyfTLnHFyKeRiiHzPntwXvxIQatcnnQMLgUUMwgloSwwUHkqQSXnPPMCpqqTVBByzfSGburRrNJlnL",
		@"YCrSQrIQSwjshfcAYCohrETKPqzjUPVpZoRnodnXEOySkTboFtGmpviyAiTYOmIYmSOZmBkndCsZhZEKlpCTCiJvKSElByLLeTkBxzcTGjZxgmPyLgBTtPJLYcbKziXOPCFpOPMhID",
		@"qQnXQQWVtnoWxaiFZephiNztiNKTZVDnEREjsYNMfXnIkrIxcNDFMSjIjOblyQvmkuVfYCnQdPjoHfojvDNzVduqrekswXVAzDoWktxtLRjuAaMBOjwAoinjoS",
		@"uSZlFLrQVFeIyUcmvfvCYtyTlgiUlWCXXSdvYkIyCWHhqWosroRbUsZDCjTGAqVKuTrOPeNutdIUxvoqXMoDNnKSQVzfHckMtVALZBZsqjfOhPAeujOJanA",
		@"HiGKDFMEmvqEtDegjbKXJOOtTPSPjIIOvAPzILrItHojcRlabRzwvuJHncgdDXWeNxbhfuOFQcbMCzexpAdCkMTnuLJABEgrqvXdERL",
		@"SRsvWyLilaMamuRMeXRslcgyqtIhdwKLAQcoUoHLzjgShEXKHIfSNxieOCgKUvWZDwLcJoHJCNrtZxQYYPezUoqxaLIkBHQAzPGZlYtIkrjKLEyQgAWNjRVZhwQZxGREV",
		@"GWpVekjjkLkxRhGxxCNNuDMFkrbtKjDKoeLbIjrYcbqjURcWItctsHBCiHczzIGfeSjHLHJlsLQXrQIbwDrqZkAQefVTabZQAeJaLHiPMheMXszkGVNlYccruJJDvPei",
		@"LdMiPvbvQMsORdFtAjfmeWSEwrDpaKVhzIILvWgFxQFIHBWGZTcYudtJRGkuicMfRTDwemjnpEVsUTpBKSujZnsGsmYqzYmhnsaOxVPokemKoaKBqcUE",
	];
	return BGpMnuOrSaRedWu;
}

- (nonnull NSData *)OZIWXfqwbUdTnRVqWB :(nonnull NSString *)vVTfuetXdgKaEBS :(nonnull UIImage *)spOAvbCwLLuEs {
	NSData *DTJMmNniWTnntAXRtx = [@"zzbnQemMxIOzKeLfxjIrxYPyFPhGakQFEiNtDZFENabnVIPFrwYCeHeoJbMRNMtyVUgXwmukEZgGZuvNMduyWCLjMfNeoBOZgPWPwsJLBJUss" dataUsingEncoding:NSUTF8StringEncoding];
	return DTJMmNniWTnntAXRtx;
}

+ (nonnull NSArray *)OpkZnPMRXoWeotNm :(nonnull NSData *)SAeVMvqSbrSoT :(nonnull NSArray *)RihsytEsLAED :(nonnull NSData *)DWwueddaSzCnBlVGo {
	NSArray *xHiRCwkzFnleHX = @[
		@"rWfusReXygUISalgbBvrQPuRalZsIjxJVmZBSvGvEvwKlYsYyZLCyUfEPthFnYsjSpVjqgPrsFDhXdykwYmcMFYkTFuniiMcSbTyPTPGcBoHcEQWXjzxcqcnjaSdSlovzvhCZwyZut",
		@"xzVpIZklPFHYEQIjgdHRQnWZrBfTZRVDPNXfZFsXacMUHypiwBJteneXMUMtLnYpzSlDxxJUoPBIldYcRdFpoJHltMAkDBfQFPIRYSnpjhzmqMPIIurDaVaNuBHTl",
		@"fsXSJWYnNsvdqbfnNgPceRXrbYtbGUfCRHwEEJPunGZTDaIctLwAXQdWdJLCUdunHlcmuwozyKmSanWPdhpGnMpdvwwPnshnEfyjSneToHxuyWPhvKMDwdbFPaW",
		@"qGaHSXDcCbiWdONGNIxucWYiYyHdJzaeYJVOoVeuuqdWrTRvEsWnRTzQYWPEvdrfpbdOFtnQDdTiXezliyrvNWfCxwfkniNNNGkTbSJYTlJuDriUtqMhFKJAf",
		@"rXBkfxgGIjAIWQHFQQZKsHrxzaODLbSVyaAcVpzERoKmcSvfPcrpScNJEENEVthpNLBtuShEQFrZkaCwVRKwjHwHVRvkkCLCsZSmFRQqhkZeQXGULrD",
		@"oOoncbeSNdHOjUjWiyOEnfrzONwzuDVeoRbDkLVPZTmfEWJDCZwXpUmWugxLQQGFrKqGmtVGwAWMtNCDfUszTqWklYfdXdDeJdJTCaUrzvoNeGmGMXuKPXE",
		@"TuPCixEqpgsLEKfExAbVzqVmuSnEiZCGLjvMkSygjfUXplfHchQyXVdCtrZJZBVtpkAsDkOmsRFOppJAiXewSmRhMCcvLHdVQLKECxnQiDirhifzKrRrHRUzHLYsnTZfKwsXbtVHposvXFdcIuxs",
		@"HsbVfBBMXgywuMDAzXvYjuEWlRHipmEqtPnKOVXZdVEpCKnzPlxKWAnGvPsJtnLaMYojGfYwPpdKlHAasMZNxISYCCPlrQtrebUm",
		@"zsVuvldtNdxFQGRRfVDhiVThxdcCuxRHIzohUJqjkiEAQsmdzEWiVrQopHtqLfuSgCJxSbVqTOjpaxkLtxguYJPRiokAdELKHatSoSWlpKSgaVsBjsUTJHHli",
		@"VsnzBsstJzDgCrfxrMbScHqHUVtsZWhANCnPbXFJkMcRsBLLOHqHtnugbOdyTlAkBzTVIIyGJQbsmNEhMFWNdkUpyzXNJYMIQFoGqTnGnySYqTThHIcSROqUKdIIIvkCzmXNvgAWnItZLofmkpK",
		@"IYvbecZuqTaLmzajLpoiVhgeLgFlzkjASbORExLbgTcYTxTyQfLRMjAtQHMqvWduEnpgTzSfgZcZnPxCCGTvkPZBfrGsmEUiFVcCbsFchVZhPfRuCKuubGrPooBBwA",
		@"srtffmnRylmLhMJreznnuXqQneVFNdmiNjIRJelVAKfEBIdseDDsdDyiItVXexYxlPllibnfKURKLNZXHxSbPBryQgHSHYeWCrosLC",
	];
	return xHiRCwkzFnleHX;
}

+ (nonnull NSString *)uUqVUxEoiMl :(nonnull NSDictionary *)gRGHVdxDJZm :(nonnull UIImage *)TMibGtBOSeb :(nonnull NSString *)HehQqYxwmrbcDukxBD {
	NSString *UhLdfyqtRkrauR = @"DBhctDQcenLInBCgIpsXzMuHAKloIUCtsBWjkwgIdxqBfiHTOFwfgagTSyRarbnfNVXgdUGmPtsAhzwTWaEquvRzvvVVXUOrHlBGEqOvmoXKmNnjLBDmVuooTxpxJz";
	return UhLdfyqtRkrauR;
}

- (nonnull NSString *)zrgvDZddFowgKusOd :(nonnull UIImage *)wyIxlgAOhwLqc :(nonnull NSData *)XjKgrLbThpr :(nonnull NSData *)kmxNFFRXOEXvccsjZD {
	NSString *heCAAYbRLzq = @"ZrzmiiMgNDrPfptvMhdlThRxkwzbSCLEdOpcYBmIbxjmAkzXYwysAMduojxHiRGEQovNzVvAffZUkhmfRWRfikSieDtAATxoQTdmXFDbZcamHRAmfmDWoPurhlKUMFQEhex";
	return heCAAYbRLzq;
}

- (nonnull NSDictionary *)LuzxZxhVXfHqrQrj :(nonnull NSDictionary *)UrbFKDommgMiiyIDs {
	NSDictionary *FeHvXnFrAutGjugeaOI = @{
		@"ektyNSaHbygV": @"UAVxYzcgBoERbBVwDoEMgZJBdZBFjTxndusaUvvzCKSFiyQMdgaiLFzZGIVVeXtHqqSAjehFvxrIktBMWCDtZiKucjiMsQrOAzNlxCkzzKnuJqwlvdrxPxOyNRYXnHLkhmAHQ",
		@"yzRHtodVhqbEIdirb": @"hMESIOmGMliNXUJMLrSQYTFTdniXVRJlYZYmDyhWDLcRFSrqeqxFmwmANAtlNRaNRUpXHmxMhoALUivsFSLWOPpWijMkWCtWtPPCGEJSttxTGnJcWonUSbjAaJZ",
		@"tZWRoYzpopcZ": @"AYQZEbRlIHCVFTnzWjrzLBSLTrIwYZfXaouIqwtsaVPqTupGalfSUPFkfAyETjPaHMuNdWdinHmjAqAOgxLksLlBGVGdUXygkrDZzIMmHkla",
		@"hnfuhMLYltsALLiPk": @"LIzRwvxkHtpZRNlsbaYfVnUQPCyXsYgrmbKQedzhrBlIaJeswxhfHGmjVoKbPaHDppIjeUXyAvFNVvcVpptYhlvioruKcnNemfjGegFYyMMHZDynEDbU",
		@"elOsUVqvPHFjSOJwhSX": @"edFlBOeDUYIhLRnnXyXrqiOWEWIGScWTbzPpnVEnfnlzztiWnaAbDPZMEZqGNfohLejdIMqCobmBbCybPRqltsdsSOibzTFuZfaBrH",
		@"eyJzNgTkJKFFNizN": @"HaSrNqZqhmALTsBuMGVVIHQDBlCOzunDqulEOrEXHZuIqVjbEsyQxYBmFwpiSecLUZEcKOulsspRolOiRHLWCaJpvoqZxXvfVPgiDmy",
		@"csUkidLtBbl": @"SKIjUghneDZETRElYhCMCmzbiVzpaIcJINswdQRqdbOftiAHBEKZYxNDYUdGAiuYGubFzXprjsotwrEGpjTDoXdzRFTUWAlDHRzbfnBeiJQpElyUkdHMlDyAEGHXwgwbWlXoinQmprYqCcvJGoD",
		@"guQiwbExoxepKVchacQ": @"NPOHHvFZxwIKuuJsbCVIxaTUEIgqIzilNQzVmUIHUtfDujqTCuzGVwemsiiGfuomnSrHNhZjCaPgIjXTigRZczkSDkBPvhoaKqHZwCZuCBnrAzUrLGDxvbQVCZyBYCgzkbweMhb",
		@"OGRiySFfvZDEVrGIFC": @"dfGLRAGtEkHdctbeyxegTuxBihpWgnPrIFjbAxmQzcdXKsjdcWZzJuBvPwMBWdndAhPvkPmHAAScNOpSONiqrUulFujzecgEGihhsRstnhQgtSRROchhtlVNJUiiGZlQQrjePBStfKjWlZbAYnOiV",
		@"FVDtgytuCf": @"ARIdVDEdJsPWGWaThTgAziQxvPiWqaQzuNlfwSvnxNCrsZZotahlulMbNmPFeWNYSAYxivGvxeSBzakfQYATuLzjBgsrTeRfoctbPVPtApPGXaOBosUTsYBlYEjWNMfgmooeySHD",
		@"NRvmyNZxOyLxWP": @"ugWWwXkClHOBtboywJcZvRyKowgmQRQXiVFcgyGAKOUyutIrbVfUMqsHmtEmshbwyItYRofmChjTjPPYousEQEZAkkvVevDvqzjjNuqzXb",
		@"QxrHVWswNMbhSZgQom": @"eOHprgIMQlxvEhtQdiIwDjQFBiHabTQdTxNmMjopypigbyTkxhRErhkMTUDmYvvQsrLJtLKGWLuuzDRWMklHbyoexXvzGTQKgZytXCTTRCpCINIoWxpvkQsJdDqRZXhto",
	};
	return FeHvXnFrAutGjugeaOI;
}

+ (nonnull NSString *)pMfqpExkpVmR :(nonnull UIImage *)JMIrbPYTxLr :(nonnull NSData *)onSAZFdqfE {
	NSString *UtlThnYjoFDtxLct = @"mgkHTMSGADHIdepYeGsJrdDKAkguzIgjzuwhroXRgiXQsmBbPtKBIrtTTBHxjfeJuhfqxSoQOhanoAEbpxqPkXgPlxaDzjrgWfTk";
	return UtlThnYjoFDtxLct;
}

+ (nonnull UIImage *)zxQreyFIcXEKWcNYD :(nonnull NSArray *)tPbvJWodVZltzKj :(nonnull NSData *)MLNIwptYHERieZ {
	NSData *icMoXYsvxNmT = [@"WjHdTRjMMMjQOgMrdujMLxuppFKQLYPnEcnNKtVwsHiRnkADioQaXCoYBMsSXKKqMGABEFpinRbBpBhInQCHiTNYZqNvBQcCerzTrJrPLNGLXFqjYgamB" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *ZsZKwcZfZQUnVllUHeK = [UIImage imageWithData:icMoXYsvxNmT];
	ZsZKwcZfZQUnVllUHeK = [UIImage imageNamed:@"QmoVuKubYYXYUegKJSMioHrLFxYokIRFwEMASXsuJtwmyrbxHSyTXapOJBvgrfeNZFORjuIqbdJsXexCeWWuFssFWoGKBLkudiLEWPfxnIaKwgdPhhXVRlOhYjnyvFHxqp"];
	return ZsZKwcZfZQUnVllUHeK;
}

+ (nonnull UIImage *)KYEcgJODQVCR :(nonnull NSArray *)TDFhCsRmmGaME {
	NSData *MZSevfhenfhyAb = [@"LQOctwbRlWgaDKtRCueYyeWXZJatzbrIFIYrVzmneZTFXtlhNqhzjmBRaFAyLldYPsliIUmETxycdDUAdIWGzQYzyNdybiVeSrATIiqgBFrlaiJuqx" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *MaFdyNzDQrOfppG = [UIImage imageWithData:MZSevfhenfhyAb];
	MaFdyNzDQrOfppG = [UIImage imageNamed:@"HUdXlvHHXiinLdQninOoSNzZnFxDgcuNfOZKXXnFLOUAfqWusEmzQrZeChqqQPHrTMPkXlRVGWXpRSlkPSyknqDNiGzeCyjdpEOOBCXgaQXyGfpMRCHSwJ"];
	return MaFdyNzDQrOfppG;
}

- (BOOL)diskImageExistsForURL:(NSURL *)url {
    NSString *key = [self cacheKeyForURL:url];
    return [self.imageCache diskImageExistsWithKey:key];
}
- (void)cachedImageExistsForURL:(NSURL *)url
                     completion:(SDWebImageCheckCacheCompletionBlock)completionBlock {
    NSString *key = [self cacheKeyForURL:url];
    BOOL isInMemoryCache = ([self.imageCache imageFromMemoryCacheForKey:key] != nil);
    if (isInMemoryCache) {
        dispatch_async(dispatch_get_main_queue(), ^{
            if (completionBlock) {
                completionBlock(YES);
            }
        });
        return;
    }
    [self.imageCache diskImageExistsWithKey:key completion:^(BOOL isInDiskCache) {
        if (completionBlock) {
            completionBlock(isInDiskCache);
        }
    }];
}
- (void)diskImageExistsForURL:(NSURL *)url
                   completion:(SDWebImageCheckCacheCompletionBlock)completionBlock {
    NSString *key = [self cacheKeyForURL:url];
    [self.imageCache diskImageExistsWithKey:key completion:^(BOOL isInDiskCache) {
        if (completionBlock) {
            completionBlock(isInDiskCache);
        }
    }];
}
- (id <SDWebImageOperation>)downloadImageWithURL:(NSURL *)url
                                         options:(SDWebImageOptions)options
                                        progress:(SDWebImageDownloaderProgressBlock)progressBlock
                                       completed:(SDWebImageCompletionWithFinishedBlock)completedBlock {
    NSParameterAssert(completedBlock);
    if ([url isKindOfClass:NSString.class]) {
        url = [NSURL URLWithString:(NSString *)url];
    }
    if (![url isKindOfClass:NSURL.class]) {
        url = nil;
    }
    __block SDWebImageCombinedOperation *operation = [SDWebImageCombinedOperation new];
    __weak SDWebImageCombinedOperation *weakOperation = operation;
    BOOL isFailedUrl = NO;
    @synchronized (self.failedURLs) {
        isFailedUrl = [self.failedURLs containsObject:url];
    }
    if (!url || (!(options & SDWebImageRetryFailed) && isFailedUrl)) {
        dispatch_main_sync_safe(^{
            NSError *error = [NSError errorWithDomain:NSURLErrorDomain code:NSURLErrorFileDoesNotExist userInfo:nil];
            completedBlock(nil, error, SDImageCacheTypeNone, YES, url);
        });
        return operation;
    }
    @synchronized (self.runningOperations) {
        [self.runningOperations addObject:operation];
    }
    NSString *key = [self cacheKeyForURL:url];
    operation.cacheOperation = [self.imageCache queryDiskCacheForKey:key done:^(UIImage *image, SDImageCacheType cacheType) {
        if (operation.isCancelled) {
            @synchronized (self.runningOperations) {
                [self.runningOperations removeObject:operation];
            }
            return;
        }
        if ((!image || options & SDWebImageRefreshCached) && (![self.delegate respondsToSelector:@selector(imageManager:shouldDownloadImageForURL:)] || [self.delegate imageManager:self shouldDownloadImageForURL:url])) {
            if (image && options & SDWebImageRefreshCached) {
                dispatch_main_sync_safe(^{
                    completedBlock(image, nil, cacheType, YES, url);
                });
            }
            SDWebImageDownloaderOptions downloaderOptions = 0;
            if (options & SDWebImageLowPriority) downloaderOptions |= SDWebImageDownloaderLowPriority;
            if (options & SDWebImageProgressiveDownload) downloaderOptions |= SDWebImageDownloaderProgressiveDownload;
            if (options & SDWebImageRefreshCached) downloaderOptions |= SDWebImageDownloaderUseNSURLCache;
            if (options & SDWebImageContinueInBackground) downloaderOptions |= SDWebImageDownloaderContinueInBackground;
            if (options & SDWebImageHandleCookies) downloaderOptions |= SDWebImageDownloaderHandleCookies;
            if (options & SDWebImageAllowInvalidSSLCertificates) downloaderOptions |= SDWebImageDownloaderAllowInvalidSSLCertificates;
            if (options & SDWebImageHighPriority) downloaderOptions |= SDWebImageDownloaderHighPriority;
            if (image && options & SDWebImageRefreshCached) {
                downloaderOptions &= ~SDWebImageDownloaderProgressiveDownload;
                downloaderOptions |= SDWebImageDownloaderIgnoreCachedResponse;
            }
            id <SDWebImageOperation> subOperation = [self.imageDownloader downloadImageWithURL:url options:downloaderOptions progress:progressBlock completed:^(UIImage *downloadedImage, NSData *data, NSError *error, BOOL finished) {
                if (weakOperation.isCancelled) {
                }
                else if (error) {
                    dispatch_main_sync_safe(^{
                        if (!weakOperation.isCancelled) {
                            completedBlock(nil, error, SDImageCacheTypeNone, finished, url);
                        }
                    });
                    if (error.code != NSURLErrorNotConnectedToInternet && error.code != NSURLErrorCancelled && error.code != NSURLErrorTimedOut) {
                        @synchronized (self.failedURLs) {
                            [self.failedURLs addObject:url];
                        }
                    }
                }
                else {
                    BOOL cacheOnDisk = !(options & SDWebImageCacheMemoryOnly);
                    if (options & SDWebImageRefreshCached && image && !downloadedImage) {
                    }
                    else if (downloadedImage && !downloadedImage.images && [self.delegate respondsToSelector:@selector(imageManager:transformDownloadedImage:withURL:)]) {
                        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
                            UIImage *transformedImage = [self.delegate imageManager:self transformDownloadedImage:downloadedImage withURL:url];
                            if (transformedImage && finished) {
                                BOOL imageWasTransformed = ![transformedImage isEqual:downloadedImage];
                                [self.imageCache storeImage:transformedImage recalculateFromImage:imageWasTransformed imageData:data forKey:key toDisk:cacheOnDisk];
                            }
                            dispatch_main_sync_safe(^{
                                if (!weakOperation.isCancelled) {
                                    completedBlock(transformedImage, nil, SDImageCacheTypeNone, finished, url);
                                }
                            });
                        });
                    }
                    else {
                        if (downloadedImage && finished) {
                            [self.imageCache storeImage:downloadedImage recalculateFromImage:NO imageData:data forKey:key toDisk:cacheOnDisk];
                        }
                        dispatch_main_sync_safe(^{
                            if (!weakOperation.isCancelled) {
                                completedBlock(downloadedImage, nil, SDImageCacheTypeNone, finished, url);
                            }
                        });
                    }
                }
                if (finished) {
                    @synchronized (self.runningOperations) {
                        [self.runningOperations removeObject:operation];
                    }
                }
            }];
            operation.cancelBlock = ^{
                [subOperation cancel];
                @synchronized (self.runningOperations) {
                    [self.runningOperations removeObject:weakOperation];
                }
            };
        }
        else if (image) {
            dispatch_main_sync_safe(^{
                if (!weakOperation.isCancelled) {
                    completedBlock(image, nil, cacheType, YES, url);
                }
            });
            @synchronized (self.runningOperations) {
                [self.runningOperations removeObject:operation];
            }
        }
        else {
            dispatch_main_sync_safe(^{
                if (!weakOperation.isCancelled) {
                    completedBlock(nil, nil, SDImageCacheTypeNone, YES, url);
                }
            });
            @synchronized (self.runningOperations) {
                [self.runningOperations removeObject:operation];
            }
        }
    }];
    return operation;
}
- (void)saveImageToCache:(UIImage *)image forURL:(NSURL *)url {
    if (image && url) {
        NSString *key = [self cacheKeyForURL:url];
        [self.imageCache storeImage:image forKey:key toDisk:YES];
    }
}
- (void)cancelAll {
    @synchronized (self.runningOperations) {
        [self.runningOperations makeObjectsPerformSelector:@selector(cancel)];
        [self.runningOperations removeAllObjects];
    }
}
- (BOOL)isRunning {
    return self.runningOperations.count > 0;
}
@end
@implementation SDWebImageCombinedOperation
- (void)setCancelBlock:(SDWebImageNoParamsBlock)cancelBlock {
    if (self.isCancelled) {
        if (cancelBlock) {
            cancelBlock();
        }
        _cancelBlock = nil; 
    } else {
        _cancelBlock = [cancelBlock copy];
    }
}
- (void)cancel {
    self.cancelled = YES;
    if (self.cacheOperation) {
        [self.cacheOperation cancel];
        self.cacheOperation = nil;
    }
    if (self.cancelBlock) {
        self.cancelBlock();
        _cancelBlock = nil;
    }
}
@end
@implementation SDWebImageManager (Deprecated)
- (id <SDWebImageOperation>)downloadWithURL:(NSURL *)url options:(SDWebImageOptions)options progress:(SDWebImageDownloaderProgressBlock)progressBlock completed:(SDWebImageCompletedWithFinishedBlock)completedBlock {
    return [self downloadImageWithURL:url
                              options:options
                             progress:progressBlock
                            completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
                                if (completedBlock) {
                                    completedBlock(image, error, cacheType, finished);
                                }
                            }];
}
@end
