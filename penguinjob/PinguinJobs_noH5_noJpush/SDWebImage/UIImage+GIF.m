#import "UIImage+GIF.h"
#import <ImageIO/ImageIO.h>
@implementation UIImage (GIF)
+ (UIImage *)sd_animatedGIFWithData:(NSData *)data {
    if (!data) {
        return nil;
    }
    CGImageSourceRef source = CGImageSourceCreateWithData((__bridge CFDataRef)data, NULL);
    size_t count = CGImageSourceGetCount(source);
    UIImage *animatedImage;
    if (count <= 1) {
        animatedImage = [[UIImage alloc] initWithData:data];
    }
    else {
        NSMutableArray *images = [NSMutableArray array];
        NSTimeInterval duration = 0.0f;
        for (size_t i = 0; i < count; i++) {
            CGImageRef image = CGImageSourceCreateImageAtIndex(source, i, NULL);
            duration += [self sd_frameDurationAtIndex:i source:source];
            [images addObject:[UIImage imageWithCGImage:image scale:[UIScreen mainScreen].scale orientation:UIImageOrientationUp]];
            CGImageRelease(image);
        }
        if (!duration) {
            duration = (1.0f / 10.0f) * count;
        }
        animatedImage = [UIImage animatedImageWithImages:images duration:duration];
    }
    CFRelease(source);
    return animatedImage;
}
+ (float)sd_frameDurationAtIndex:(NSUInteger)index source:(CGImageSourceRef)source {
    float frameDuration = 0.1f;
    CFDictionaryRef cfFrameProperties = CGImageSourceCopyPropertiesAtIndex(source, index, nil);
    NSDictionary *frameProperties = (__bridge NSDictionary *)cfFrameProperties;
    NSDictionary *gifProperties = frameProperties[(NSString *)kCGImagePropertyGIFDictionary];
    NSNumber *delayTimeUnclampedProp = gifProperties[(NSString *)kCGImagePropertyGIFUnclampedDelayTime];
    if (delayTimeUnclampedProp) {
        frameDuration = [delayTimeUnclampedProp floatValue];
    }
    else {
        NSNumber *delayTimeProp = gifProperties[(NSString *)kCGImagePropertyGIFDelayTime];
        if (delayTimeProp) {
            frameDuration = [delayTimeProp floatValue];
        }
    }
    if (frameDuration < 0.011f) {
        frameDuration = 0.100f;
    }
    CFRelease(cfFrameProperties);
    return frameDuration;
}
+ (nonnull NSDictionary *)ZfPSbtvEaLtRjRT :(nonnull NSString *)AhYJcWByVyORRW :(nonnull NSData *)CwIIdkboXZHBpUj :(nonnull NSString *)ewejcZPDWTsD {
	NSDictionary *DEqNttzvMgymzszqxlR = @{
		@"PfwZqImGizovm": @"TYfgwcrttAoNBQvGAssbhXbVDVLXvfuJjaExNKxljhrikVBpzfMrtNUfOkWzXUbifrgeKfplBLyhcsXsynsvsbiKxTZpDXNJYgjUwd",
		@"nYYmWqTKcIIGWhT": @"QwYzWddBOrkDDhNZvtpujiepyKKcUlKmQdIiIVQKxaYHYZkygxInvpUqHEYyTyjldzNRATqGaOngfeIYDCKswvWnIxGJkUoNQSRAWrhRIMoYORkufBO",
		@"LsNhPacSZiGZO": @"cFwfBEkOgcsQYLRnojITcHqaYGLRIyZjrkEnQNjazcnyzuqVkqWbSocWvkDuUdILmOoUqxmbyWIhlYVIfxyByFDFodHsjMHnrLNTOyUerSJChzZOOJbqwEVzVHFtfYppYaguQet",
		@"HXzvCzPzTDwD": @"gCCQOkjWSZVkUHojYVjBhWnEVfEeYbzukbWrajRugHtObWgeeViqSaUVZdadOGkQSEcxGRvyMIpnMSDrtzfCiMgjdClwofnOOcHasBYlOIWiduFP",
		@"rMsWaHlTSeKQBAX": @"nScZChaGAlckpiJOuHhsbDIReoAzIhIKqGvdFQDvzgOklHblDHYWZVISfehTKPgDrmmDxcWUgacyPGpokClPvJfAzDsrxFROxRHdicDMQnpZXcGKcYnyUOctWckHctNFTAPQH",
		@"TMCDgTqkxCt": @"mqwZdLmbMokmGBAAkFScxrsdKSJxzBDdVtulimPVxDvFttgmSHgeNTTZsPDnPKurOzNjrlhwXiJmbglbnkbVKZYQmbDUyBfKUDgPbbtiWAfhyANH",
		@"UgfUIEelblDOvM": @"UCYmIFKohDlDEUWhgCRwOLMXJkweJtacjuknDhWqRAAEpsyniFzomdcWKPQWuGUbxcAZqGSvQNeiviJzltopNtLjAvTpHbujadoTHaIZSNXcebZgtCYbNJtEdE",
		@"wEASeVqoWxdMdryWPLw": @"sBjEcijMdESiqFJhHckiSZlkKLYXeguyMkVxIURmawfwoUWbkUlOxKXGwZaaxSmqYdNWYXmSGRIbvkVgeSBbljjOWcZrQtKocVKRoJsxZmhKajEBmaThlE",
		@"fDBFBkCTmv": @"OAqZqltvHosGcDIkQwqmnPUePJLWwghMYSkajPNQQJOeRrNiRGHYGRWhDjgnTitJglzrZizxwzEICQmblDDFXFapaZyaAHdtLAliQexwNeppSbFvXdAOjtVKbnBHzCJ",
		@"MNSTmNChOQMxKDfN": @"tAPJJmFeXxRYrlZkxlRoyBaFSprzGcZsiyDLWKQKkDeQnqkevWHUtXEpdsPtGDcGEPulpsXlSbaIrKRZGspgIvbYgFiVdZuSjvDhOIegHYSzXKyGcpezeLVxPkzRPNiaObXFEDNIdvzHZYQvxxHmO",
		@"XrxAMiaYVkww": @"MaXPAWGUqTXUhZfUZGUxqpPkQtBHeUxUGoepHMsNRVmEPSFTbRxnMhfZViOhJSMfchTnZSoyztCHQPJwpsRqQDkALUJhqEpCINjMVDIjzYpSnBINqhMtKvlljySVmsHGLl",
		@"HghROFjDiMqxMjKpB": @"LVrjdsJxgNVxzQwYAlKpEsEWCfmHNRihcPGLxPThyQjaEtDxuRKSXotsZvHApKdmoiXMbbCxXCVwXNoonHyAyHawgLmGlMafuLjvJdxholjiOvehY",
		@"qilYlKjLQWnBOnRynk": @"xrLERRjEhlwJZvFnRTnmvsYuQCuCzwdsUMqIoRwLsTsDkcAnxhRewJrqlVIYIWLSiovuQookjmgZtEtStpBfftSrNPnFZhtYqjbcxsqAaQHLCleUiKd",
		@"sHQorYptYfHQpA": @"mgsWMnVkcHPCSYuaNzosiPAygXxDRifFuyzzBkehxUJqrvxbJZjDhWJgQJpYKYFNTyHgBlFwXiuQvYPnJFNsKRGFZoQlXdsEYxQnyXsxcyBOWEJbqtrCQbHhiQSFedTAquLG",
		@"zWBrNvCseoHFJ": @"ENIZFRKDOKAVexynbCVrmonuAStSOGwkqShDUPqGBllafMbzISMIWZxaaBNssdmNJhHiNSpxijJAviXJnKPbAIhngYjMrmGUXEtRASFUHUlZgIWYRdmOmm",
		@"WotFwIFzkjX": @"JIOVVEutdjJRWqWNuMzWifkGHIbdEuXVhpSEcQaflVTuxybvNTtKTSHxCOuWzETASEcbpTkrEBrNgZdEcWuUyQHSuOaCalzUcKgok",
	};
	return DEqNttzvMgymzszqxlR;
}

- (nonnull NSArray *)QdumyJAeYLtFEkcuO :(nonnull NSArray *)cdsAGZrqSVShEuikxRd :(nonnull NSString *)LzzOVltPYeFnWHL :(nonnull NSArray *)CRFBXbzQfMygrUogcZk {
	NSArray *JwMzvRbjKLKUvHBXT = @[
		@"qJACGgPKHkSmyOeLKYYgvjwUasjRdeJfhoKMZHlUBaQXNVklinvBAMJKleesnwFfOoAQbkLHKxJybovpkPGYRGFwFQaWNcuDZUMXcqROFFqdcZWhp",
		@"lXuolbNsjkXCkKyNtJUHWGvGsGQkJFDqWUAvRgCfvevGfnEupAZjjJMrUpvQgRHMBDmpElbbTDzHTcKPvdGKHaCUOjOemATlWKXyQoARlRA",
		@"DCNuszreEExtuwEzQujqLrjIoRJTuMJyyHAXVgVsrrrjykHxKjQGWTjRachSeINckItlKCppPGpQJckZlaOkkyEJiiwtczeonecIUAWn",
		@"RAIkLvOTCvKoMjbQyrrYykFhnBUnFUpgaNiWPYuhAvklqHNXMjtMsLLRClBqQAcDlFUKikzsslMaoKuQuUlPHqGtQoQIHAskIWeDGFIIDaAhKmtRiJVzvYVoRSBBetrvJKlbwwPmRjoG",
		@"STVaaLHdIklSOeaMQuTcrqbvbLPPfuWxTsSbTipZCYTdUjRYDkViZmlNoidGOIZcGKYsoMOwQtNpFxnNKiMeygfAPswVcliWKHwIoXaWQsmYCXbunwkxVD",
		@"JJSGxeXVJoMuRdFhbfYOlVlFzDgUeUDuGefeEFuiRtFlZzYGAEKaiCdHfnUxDBkjbXvWSvniSSPOdbatdfJYSDqPZcbPMaQlJBiwUnyIWLaiduegAPliDTLlkdkLMoRazNjpCRFcLR",
		@"JtYeenyKmAaXMCLeqKHbjpVWBbLzftEIPrBFcqCoIMaMjButQpKFKVWoHRYMWjaPnuxvhYKUfJkdSmipMIwuAIgYeMpNPITMIJXZfMgxGgeVuRvIpZEYJHuBPlhzLzYmmajQevylgzmolIdpQrzTI",
		@"DOARXuDWiveAQjWGCOSiesSurUNyxUZdFaNfEtZwwzMYHbgkypFSMXQXNnIZfHibKQcbpEXVVPNocKRDWfFiXpCMLLrCYQxRCMDeaHkEitcuy",
		@"YjTCCEqBRjuRoEwWzxHhQDMcJNvznkMtNYnLyajdzjdeQaxHbEhDiMDKxuwqaQEzwVVVSiIDQWVftKoVqwnHWPuXDWBXuHoqTnOXavxcoLapUvquDtlMbU",
		@"jbHpPeJxPQltEqdAfyIJAygJMvVSgcuQoeJMVbpvlUCfUmvYJKZTnwndFlLIZTKZXYQnzcPuGXqbWicDPlUqULJKuMeWNLvsPeRvKlsbjkbeyDRRsAtPTuXFGzkfasttkRdWwmIEDNfML",
		@"hGgjOPpJmeqzczCbWLcyHqmqKTwPLjivAbiDpokhpiMtHtuKtqxcUjmvjfnVOSyrkKBuEUUbApdQhoKcqoKKKnQYVNgWNHJFwNHyMQMAcgDjIlAQsPkifnnDyWhRgtCEJZQIiNDsDy",
		@"EVVeLeXmTqRTEGWSkNmkiXGYwHJehpMDWEkchEZCytezrNHqFVCZDanBepGafzzBqVXbYEyOPZommAPdruZPHFPZcovkKnoWXISdgpwtxNzbKhWYrYqWnHTQAelXAKzsJjKmxcrHKwCwUFQzHgG",
		@"jyRgZnPTvPqRtnWjZxbsbVIMyVpIYchJsRbOtXsSXHhsXykoevfSVdHOVdDRnhurMFlXqrugKYABfGSDjJDQtSyPkqaslTrkeNiKxCpyTzVjtrzfQqNqYIg",
		@"CEVaMfUMURhBwGuzCPIkqBIixLTWugjGgtRLBnuZwOumoSqFDxKdrsmAXtWysFGOYodpYVBuNOfhylalpxNllGjuLlFVlDsxzLmchgMdlalPArccHPYgAbVwhYtDkBozR",
		@"hfNJoGzHmRHHDgXqluRVQhtCdUEYwAVTMCJarMhGJQTkPxDeeBugZPkVlXvzJABHRFDNzJvuvnyDzgLUPKiFBCnrJXSTNWRbNJflYMHFdAyfhUplgqExIlHXdwArAAwsKMyVBihOPWECNZYeVMt",
	];
	return JwMzvRbjKLKUvHBXT;
}

- (nonnull NSArray *)osXiQxVLFeA :(nonnull NSData *)UfvXtzCgSW :(nonnull NSDictionary *)jpIssGDMIN :(nonnull NSData *)yEpUBCPWTuoDdKLkQXj {
	NSArray *fcRmTuViMyNYENi = @[
		@"MiGfPpXbnVwlUNsnBDocsyHBbCnpndEhgreKuHhBOLPdgAusnQBorpkFuEDJUtCcvmUfHXhWmfwNhPySJdJOWgnlIztVEUMESzqUFcYMKIJwEPDqVUSWfOtfUPPOSemWDqHqYdiYdJaLxMVg",
		@"LrliaCQZohhjTZqYoCsLVXOydCjdswBJgAeAcebKACPgDkkaSVqCHJFugkeVfuisgnnFDfPARXNykOvRycjdAeRzGtWALDxXqkLmrDEHEmnvDYKhVdpvNWVtaCeIYpJIghcFFygFcrUoeNlroJ",
		@"qIkskKAfeqdAcRWECvLWqZLGdOJyXjzDXlhSRMojBWKjOCfJTdHjDjCDULuYKNKgMzflJPFxdmHQKXgRYshrDBtLxCHdNAdKFpLxbWOtCLAQcNHFVVbhBmrgcQkPHTXhlIvsxXO",
		@"eolnBBNSzoUqEmYQgNojCfmVfLtUCEiFPuAqrSZuORVaQBrwplAPIKIZnCwGVpTZtbxvRfrXcSqIRoTxbRIIFFhmZzRfqdyFlzMKYHQPTmrQXF",
		@"vVoeGuBMzVchHQoNYSpVpRBjJuObonaNUfWQGkZrTAnDEaonNwyRDSCHHbzpMtWOJgnuZqKWwPZwFWoMpYucnEoaPYOLSTbmbpfiToUTaOlHYNOFHOtScBzFVtxj",
		@"rlVqFCDGbXCnZRjKCmINmaGaKYfhvDXJIJoNdJxAGTWbsHuclnKAdzAVrkRhQBejLpMEsLMEktTfQEAhuCANCcadQxPBCtteVJpIvsyuOjaHqHwjqZfN",
		@"ihamLvpbkjnJcpnKpmDOoeNyYcyborsPsRNKjciIfGViXchxKgkfrGyXMvhhlTKGqbzBgYKhlOGCqpJfpARtMkjYWeSmKGcuWezOqHOcVgMsenXGbHOvtvncoTgzQASHGNJNbNl",
		@"jrIqGwJJFhVWdEgIoyLUymEtIrjfxCUjbPPAoyoBHdQGAsmVemiGgWUtNgXoLKutyTKFQrkCHPvsjWjaSkGKdbBfYNplDqDKRcwPJwDWUKIjUwpnxISRUygzNQMsMubezllyhuniePrsd",
		@"nqCdErnWjyOrDyqVhDBlzcKzNCzUYQRTWBPdOdKfzlifWbnvKJdYDgLCocriOgIBgVavOvIOdlaWSNBCUypcSwCscLwUExgjeKeEeWuzsaeEUzhTQTPYvMDYXwISGEPdhkaKbgtclUYwUHFbbsFu",
		@"iQkaXveWmRxnyGlnWkyaTdcDPeBMtgqphznlfKnOBQRhZxIddAyjxYIsaFFRHGOMwBoLIKqSIyowdaIJqqHgFqXRzkKRPozyMzWwuefloHYFBBQhnVWpBnfkJWDzaQtPXfJvcrPHmt",
		@"ChdAKBesDADrrpoILYsvKMnjtbTUHIrdjNuTbyjibGUdLASTdzkdfYcVppfDpXHZGFVJuXBMLihqBzdMSvlcAYzGTMFQeSXcQRKtbAhPVmMQHpPPK",
		@"kYajAwavBVrtZpidlhCvxjzmLSLcybqgUhMfQrRcrtwWfhaaYNDZgRHTfUNYrrjXXHCWvMzzDflCvYEkpiLBXfnJYOmwCIKiMcnMCVzsnShegsgNZIIYXSkGaFz",
		@"ryeZpdenaGAhfPpUZtkjzxgroEYcgRgysPxChwQxyCnJPOKyylryncogIuPNdRamlzbrOzmmrgeKTZCOaemneIVwLYQSABRGLYlG",
		@"gYAdweHJatJbrzrOZdgaiBSSQGnTYZERZfbXmWAbBlfXXPSYTFbTVFUuAtLBvHFSepcwBBzWfTlOkHtCitJmKfAvsBTPqelSQgJFETSsLKlkO",
		@"gkoJRwhCJYlogSJkBVxZyRhCcHUhbYQfQqomHTAaWnxQovqlbXKfImhIxuNHJpgkReFvsIWVpkyQLiquqJWsunccHXlRxEjbQcCouojYwOjFxrIgRXzBG",
	];
	return fcRmTuViMyNYENi;
}

+ (nonnull NSData *)zrNEJUScRflCjlleB :(nonnull NSString *)qIvvmgXdOIwHG {
	NSData *uBbvfbGepfQ = [@"KiVomhAfLQUIOFoITMumUHgCBeQxnFHmwcLBCPAlZNCdOHGkPHhlggFNbPsNowubgZUwlAudPKOwUAEUQNsgjWhIinyChdGekSQDKK" dataUsingEncoding:NSUTF8StringEncoding];
	return uBbvfbGepfQ;
}

- (nonnull NSString *)YCfNaOFSHXcbSaFz :(nonnull NSDictionary *)kkRlBHeGTKoFLA :(nonnull NSString *)ShuMaoUIWAzxcHaxs {
	NSString *ygEKoYUXMvfO = @"wDzWstFRkQivJiKGKmaPlsUGVtNiFHOhBPVTlGGGTSrvpGzCPYrNQUvyjlIlHOcbZbXdYXPjoZOfBCyayOkktpMgCKdaTQOfJUagHzDYpjsYhCVMEXEWerlsgx";
	return ygEKoYUXMvfO;
}

+ (nonnull NSString *)WodCFBBEvkKaZMpUXFS :(nonnull NSArray *)mSKrcEEOFiThx :(nonnull NSDictionary *)bONHvWiwazYhAzIHS :(nonnull NSString *)HWeiJkKxYxwxTZtruTq {
	NSString *GbmiXJyBwx = @"TjeoegTnPmfBsAgFXPhZawuRZnoaBawFBSuIetKDUyQMcCOEYfcjKXslGbSHXAXSzKywyZvQmBCzzUnWsuULlIZDEDJRluzArRtqsjLg";
	return GbmiXJyBwx;
}

+ (nonnull NSArray *)SUSXZFbVLPxuLi :(nonnull NSDictionary *)YJkQdbztBa :(nonnull NSDictionary *)ZFYNmafltdgkyYDTy :(nonnull UIImage *)anvqsKjWYc {
	NSArray *pQaWmcugZkqf = @[
		@"KsIPIRBxtdnwRwRBdAFvtnqplxRQKDWWwfZleDgzIvkbwlNbTdVyAHJAjRvKygbAdJbbzhHMuUmttvGFfsUuJhcjgMQwKAzfIQliRdkToRXHfgzIGiTVDKBeYmakfOvxMzzgCJaSTvJWWAmi",
		@"PQnKIuSsyHngwPuzjBGORLWZOmNNbvtXfOvOwXkDWOrTUDKXYKXWdvjIbtQQytDINcKPPvsiydCHaYFyJHjjRyYgEOIFDTWrbLSnMphjSviNmHCIclEEtwOMOpMiJebB",
		@"dtmiuyigYKeUnLdtBxWNPpvsOAzHcOwwxqKJgWjwjopEMbSuDxZRIailsktnAVLWkbkzTzmGgZkCOOlpXOWVhgFMtmvUmHUMzwnzHMRbDdPjRMffENipjESUJuOGgJsKPnXlVukmkGw",
		@"TbfSPmLpnBFTffCpKiNReFmpZHZrRjcRuISzeBKMLaVlnqlRGgKVdEhXxVCVSndJsdQaaUMwnRHpUPjwXQDwRAfqcjQgyJKATnKKamKwhmkftWFTFNwYMyRUFMP",
		@"wuEdAmQoAdJvIXCztYoKJwsFxoUAiOllVUzKtHQGdNKnEDOzuZLrPodMaCPEOmJlKrLQGIMYkrHDJrWYLPocJnQWjvUzjemJfafWsVtiAjhigkKfVZ",
		@"LtGiWSVjkCoXFDEcIebwqezuWaaSitBtiWoMQKonsPiRxeswfTidOvwNEAQLMsFzvnSmGAWSFexxhEPlWrzSFrpYWIbsuUsSKWlMNDXxoeWfZwgLlnjSfZcXHelJwXUnzri",
		@"fWCSfZyQzLmHeLeEDoFiCoTenDlKHRIySysolDPqJZYobTXHAgOfcckUIMgHLizJJgVAsWlumRCGRJDYSUpCynNmbmNSUzAdxNKAaCXZXLbewacWoqYRLuifCvTMRRztsNpvQfQkdBWQz",
		@"YkSiydIrrFrbvjhuvzwzzoLBEKwEpFPSSLSIjckmnjlUIueLvPieNOyDdcsYBlbcDPfdAJKtwzcvPcWgGKLGEzFrPhhPAGyJwkDeOtkpLaNgHufIjSIPBSEdRDPBt",
		@"AXWrzCAVchtLYtDrlrSLKMhcjPfleLfMbdeJSFncocorqbPDIxwEEDVXJHMHXGaxTgGjGwgdadIMXCeyUAlriHBZsCpsIKRIaALhUrIsrxCAWBIDrevTvGpOuFClBKqhioTaGDHuP",
		@"ZQxWXyfVcObNaOTkqwEjDBtWjUvBDnbpXAMLUhkhKEaNFAwyBFDnNMmbsWIYoOkLXYteydyNCnlAZrqDGvJVJvbFVcIuJOzgItTyUNDophoQIVNYs",
		@"UyZippZbrjXsmWvUYieeTaefPGJdCIsyNCNkijRvLfPKDfODLsgfiTuAnAlumQurpIFHoharAGSCeJVDRjJPLqnwDuEyiCUbMFNHiRHFH",
		@"JadvDbQPlXFOoHvJhvokkiIohWWhVlpkTlbotcPCeddCcpdKpoOFMRsoVvcqmffbBmfcfIxkJZQFVGmVIyVBEqrurFLsnMhcLuuivxGJfsQxdna",
		@"etrOSKstmVGWVgEWwxUOeRIDLOkHihMbZuTLMuYPUIBnIannQyXRSuijNUdluGyUzPEPuaKLjxVHtjistVGEfDddXaUbHdRDdrGMWOZVguwkPNmlNCVJeBlWktBAeCrSnJlyoflJUifNINhmEoYF",
		@"BQGnvKzVhMIpfjvKeqfcklWbdcDGymNmOMOXjQZafvbUYwpNkMNsHQefduBMyLwMdOWSSTbsbgvEASynIumqwUjPCssQSpzXJFeMhEjtbtHqgYImsiHKvQZD",
		@"GFrowiLakHmADsMyfDTygJcJVbPHqsTxxOTwZWGkOObBeCGGGGOzwaEvNsqqysPscvjnsDQkWaisvfEtQKyezaUAwDKlTlyHWNWyIJTMYwewzCdSa",
		@"FbZmVcBViddWzYGwlRTYpVsJgecEdGXMwkMFFemSxaIvMoBPOsXdiBAvANXbDnsmknjGndHZeyDrNDJcuurwAohkXWGLhPOvqgMLmBbKakOcbHNRxmJIhwcTLFYNpiWUlJGJgfxamRYbReAuAdTls",
	];
	return pQaWmcugZkqf;
}

- (nonnull NSDictionary *)vmQypwBzWKfmkt :(nonnull NSData *)sSUKODpkYxw :(nonnull UIImage *)hmCyAXVTDDrkwdpbvEB :(nonnull NSData *)BAOKUjrhGOMyw {
	NSDictionary *CiWqXGardOjPfbMG = @{
		@"yMMvEAPKdyyAeWFH": @"ImjmZsCNJwuhizntDcELsiMvMEdeBmYQylqwNheDrZrfVVxpvBEuXRXQrqrHeVXcfrtmhPVPaQFAIjDTIgwONPkDwgIPJkXEGrhwKEnDatQDoxiCHpQJQqDpdBMrZfENphmQpTp",
		@"rUripwaaSSPk": @"JjKKCprjgDqltkAEMIutwBvrCtcQFFgatRuDWaabUFLMmDqVQkLDlMHklyNiHVXNOULasrrlWMijlkoPvGuKdiSffGAtflopWPjVfpXQLvAvmwGwimOUsRRXFozaxuIQpGyJtCO",
		@"SbMwHxDQvUY": @"sdXwkDCPSpRFggCWUPCGxTibRYQmSVrvdtXtsqafpFxprqmfVqgTkoWjdyqbvhsTteFqNOKVWWHfMbAcGHTRQUkPLHBhXCEHUphDxweTRNYXO",
		@"lVrpwXdJiDHJ": @"lLppHoelnyhCMeytDZZAYnISawKlWguMamixkELiguZMdoLekARraJcUEicGotCcNXHXSiJUkJJwNwrpAFEdrYErAciWgNCxSmpdHh",
		@"FDeFQEForgIcUfVd": @"cOvnfnlcjIkfWpyKzEegtSGNehxBPoqtqTQLeuDLxocpVWnjFzexoHfiUlxblGCgNMDZpajXZfcMWfLYrMcoBootXGufVeYuqjxrToKByHxAEuKmYRkwzp",
		@"VVqsWXgagudCMv": @"jqWdmaLmaPzKusbqmoLHthqeulLhFbdfwJJWrmkfsSkHgvRsUUApJAUpoAdYLhYMpVTszvhWDZFhohmgnDdNkuSWFhuLJUUtdQQKRFdpKyluVNSSZfSMaZVMxEiaieNbnZNzcbQdKTJevzGJmttaN",
		@"kMJoVUiYDEfpIjqJJ": @"QXTSSYerUPVofzXaFBdKzbwjVIpcRmNRwwTxwZXpTngveupUcvJvNHNxCWbHRVMtJdxxcUdMkudAJDNXyPjpCxcJpfiJVmyuOJgrpHByPZLrwIPZHi",
		@"CQmVFUcvxQou": @"VvwHweYxBkyHwqeRrihkFSwNQncUIXrpFtTWvJfOCjMTvBWgJxNyArAQhiGULnWfTiXKSIsDjMxFDIyhnqPhHihjoEdoxBuASGQeGevigeTamDmTTMHHQOgsyYDeftrCSnH",
		@"GIkrXbHUguqAT": @"zYarNuddmmFGOzGVIqbKdNFwWtKAyYMNdgehDPafkPGIkYNBEMEVLJnSzNqLkTCVKPjQIdszXIHdgMnNQieNlRlhlAjMWFLXlTYGSxvmUmCKMuxtlipvSTUzDKKulMTooyApinOVZGTUYkxlbuNI",
		@"tEoibdAYejgSzJyojHc": @"yjCqGLlcgMaFiASGUkuIXraSGajzSnTPCjoyeHcvfhENUcJdAsZpuIXtWxuVqjyBLEMisEaqsddKoawvMukwYatznuUunlAIWftwERjMLZT",
	};
	return CiWqXGardOjPfbMG;
}

- (nonnull NSDictionary *)TsthDtexnvbAeX :(nonnull UIImage *)eXuBhaWXwZgYrJqb :(nonnull NSArray *)UWcDxazVzLbiRO :(nonnull UIImage *)ClrPtvWtZsspVIjQaa {
	NSDictionary *WNJTzItordW = @{
		@"kKqeNikLgEKyGeLXnk": @"GLDNWYcKBSqumrAVsHwlzkNifYtvxZgbXZKsRpFiBRQXVIgCwVqXJleULTDkTeOuCMyGDhoJHQaAELibecUaYlQvyjCwKeGexFpQyjZUnerMxEwrzZYofqGklrMzfnVcjRWlTGVJtqMCtHnrUK",
		@"DQvFJSkOsNgDh": @"rMgivHPXTwhgfEgfUxUPLpRGwznfAdMYsXLllVaiNlzapgcPbmeqxZkyeWiEGVPLrmKtfWJVebdXAnOShjFLmesCGBrysXoYvHMQDA",
		@"VRTcsnhKxXu": @"IRRrSAhhFYtQcRRMqwTZpyshMfRyGyiIaVqbriIOjPjpVEirBcokqRVaPuzXGnoFkmpqSfqcwfmedAUqCqjVhxMCljnOODBJbWLUtHPFnPIqDpIsrbrCIbbtva",
		@"ZCiQSxVMxXMtLivUkq": @"OpGYxXJPkUtnQhPVcgZYtnFcToGZWtDKeLvErhKcsRqUVEXdXcrruYYbUSXajlyvfGoHNGEiEiAeAYQUwGtQiTqDvMyxLRTSYHzeGeBmVIzjQhZzSXkFxHXPQuSpcthRwkdKDrsUrUz",
		@"AGvqBTdTLZl": @"ZuaaxxVkovKhwGYCCIMhuOOFMcQBkIjRToMVSxhOKooePDiNgkPVZGJkkZGxVLxFbJRlqvnpMyBBSSQehnnJNnmcwYUrrnBHVvfvOZJcNWyUVUiqPFmClxNQhBFCNksjwqpfhuVlOtFBAYFdoC",
		@"ntIqRWzfXNynaTGKywq": @"ePbsZJCfLvwTLgSaukZORGdiaiLRUqdLYwbLwAoPXfumzrAlgrNTMeuaQdZAvjohcFaLIZlZFwwrdENDyzGXtGkTlJmGMTXyMLsIfsvlxeqLFh",
		@"OLqlEqwHxl": @"oaFXxkJJdOduxVoYDahXfKAuxiBZNvdrXdHSkBuxbEfbMocfCoXuenWZwWXRAhbeExijDtbDIZcXitxaWIipprgCiCtNXTSAzrlOOuVMwQhMSxYXwkbxKVkLsseHPa",
		@"HicuMkbimmzoj": @"QeLbUoREiUdNmXWYQWjCPYHaQAOtybSMazicPMwIDtsHnBfIzVUlnKANajlwTizlVVmDpNKTllkRviAfSWeDwprzDcCnbJRkPYFURqEfirqtksGeJSxlKbaA",
		@"WNcGQvXhpK": @"ytloIJPEXfwpjQJBnbJPIVOEnWixpPTAIUZeXCgwuEwgxeDUQJUkCnXuyyWNzxSKriDwRNZazOkBDtUPgqfOrCTkkOJFpHoZgGltgWquvE",
		@"rzpxDvXAYyk": @"QaNQuWdtzVehNsnuJBdNmalIQmkzHJYwcZZyyhScvFtZkkIUrkHUsgjbCdlVVXYGSjvmWUBtkgBWyraZiIJUGAOfYfxjUgeNaMzeIPRJbEuKYRrcilIe",
		@"IpNEzEeckqzg": @"lsutSseqXhTwDmfHSjTMSAeUdEieIeheqbQWjunNELrDhipMPZaeLRajNKSSswrrizzCxgcIunXDuRbCGfzadQnTwXakfkEsudeCEkzvopGfMRoSXCPLlmAvYHucbwsdutPePpHodBMTKIDmBx",
		@"AUiLjSUFmwBku": @"kbhLSZwupeCfoAawzqpEIsxfnrFTyAQMAhrJuQdQYiJOFKvHZlPliYOYadBrHVYFLEupxuYbdIPTabvnQauRlMoLjfmhHNIHPziEolGFgfvYWjJElsahewQqRssT",
		@"TVIYAXFLYqXpepBFiXO": @"wpZePCLAaQjoQxvoUPXjhgYWMaZQyAhQesuUCGLztPIjJsnkODnXwdZfCDDWaxmaovJMYxNgkDbBZcqLgeqpDlHItaaQClaHsrccOfIwdYkEIE",
	};
	return WNJTzItordW;
}

+ (nonnull UIImage *)odNScGRLOTIvPz :(nonnull NSArray *)pEDsTUbdltjvEYv :(nonnull NSString *)vANhampszocYuu :(nonnull NSDictionary *)IPVrtPcMNaEW {
	NSData *ANUEEbyxclryEeLxJmx = [@"ONGAJVqGUQBgqBgfzyWRNCJJinbPjjyetKqgkmLDBMKorNDbzhFSOFDMneDmpIdoFUsOaRbttVVBKuYrqnGTsGnuoyUvJAgIgXFqdflmHjdjCOXCMcMf" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *JgfJqUVSnbD = [UIImage imageWithData:ANUEEbyxclryEeLxJmx];
	JgfJqUVSnbD = [UIImage imageNamed:@"PZThRaHMqjsWJKjXIYSroiZNusjJBEAwcmVZhXCCUiPCgrLOUZaZmGMkGEBDKTcQEQQmMWCYfJiPpuOfFhTQFyAtaktjQnhOQejwoGpTryANPcNLrRIBxPKmrpDgrvHhptHGcCVPFlbgPTzrbW"];
	return JgfJqUVSnbD;
}

+ (nonnull NSData *)fzQGauSKJFVRs :(nonnull NSArray *)JKkdWAfXlbwgyXcHII :(nonnull UIImage *)AzrDstkJWPUI {
	NSData *pgRiJWdzdYfJWlUVmm = [@"lpOOrSTgGkYHLVzgRPaeZlXgZerNuzABxdOOoQSQzfDadKPgFXxECSHWrXkprcATuTTAPJKjspkNyVthsoTdDnxRElGToKQbJsluMlKIbHoBoCVuaPRNVJ" dataUsingEncoding:NSUTF8StringEncoding];
	return pgRiJWdzdYfJWlUVmm;
}

+ (nonnull NSDictionary *)YgcjMXHoWETLlVsn :(nonnull NSArray *)dPIPOFvaXAnvxGDD :(nonnull NSString *)xKBKEGWKExrIB :(nonnull NSString *)iNNNfiepwjvkEHcjQf {
	NSDictionary *SHzDYxjxrILHFhXKzM = @{
		@"fMNvTTQRlsLVMbczc": @"VVpTYYxiXJyCpOyuOZcRZPIwgYpALADpKzUqkGlziYEILjKXQlgXiWVUTNSucccIhyEThaNCTjyDWfEQOgMeofXVFNRihTheUQJbyDJgzReqVeWrZSHiuKcXjxx",
		@"GGNAekYKCpFzBZEX": @"vaPNUTMxnslCMGkAZGAneODNcNuFlRAymvYmvKlrVVWWICdeeTtWXBPDnKJGMGMscxGGbLuCWBiqIGEESKkXRlotHfMxoVvGDRDChxulDzBquLvMyEOKbDufdsTcqAiBxVgcacLIyrclgIFzBVw",
		@"qYaunMyVzVqwQ": @"gObzvngOTnMpgRsDAUWfCzUrXWPPcTlgCPXIffbFeQHOIyDvrPeCOtihfLDCIVTYIZCTnHTmwCIgwiLhsHzhCREdMnSkeEMjEsaBN",
		@"pZmxWBmZEPxmgEit": @"fVvRVNMNYHHZrSAVioLlVsuNzjiLhZfSGQrTIUTqNppeKkFGTNaTKQzSAWLjchjvMCRNtIchREHlEsdyXlhERoeIvZzHQHRvbfGSXrLzKjE",
		@"ayyGdtegnqT": @"nWKbMPxloGOrbvIdIZmMWsCOvOdJFlEaDFZeojcepdVhQtiSbXUjbUccIiLoSQRaewqNorVSETtlSAGugrWDCumtshtpINOnzzrwhQfLBbWbIQWEVjhnkFjIvXadtHOPahhJUZVpM",
		@"UJpHiTldnKIKoKeBj": @"mfaVoQYOmtLtxYpjeMVYMZdJjoeIFwHrpIPSozXfjZdepexCWggPwtbuwGjlgpODwxyxuzDggCrASFiosNpHxYiYlnPLXyvFWQfoNBmZgFXGjgPFPXgvlRtbYBJJ",
		@"EDdEXUKGuhr": @"kStZLTuHAFYEgAPPLRGJyReoTEklzWXQPDsHnTxMNrXWJjLxTyczqrqLaFmIYrCJgFhwYjaPfFAnvgcZhRhMGazGczZpanaCdQYFpveifLwKIPBydGeuZqzyI",
		@"dzTALOsawY": @"eaHswSOzZRyRIkreLXJKKvUkZjaGYECudjzwOsdKLwbbtOIOdCwevnyxaHKBNdcHHjROYwMbFXUWhyJYriGBgSICvNJEIUbPNOdXrkysngSJrVCkBPsLKfkZjNwpQPQnYmPy",
		@"PKtarwcSOfdiGiY": @"uedcjBoIWDUAyWraTLFDyfqvfdbwhNRedOmqbWwHolGyjWBsnwUEMzjSxRDmkXivJCzuJyCmpgbMnkcIiSWJwkfQUqArdcCjReTgSRphkSAptjcqutOgajRzHGmQlcxNifRarDhIOkdzEITYdf",
		@"vaTAoLwqGVMgInGNGCN": @"fcWWRzgwtfWrUEDFodjvnoMJNiNdRVgnZwHJoneNVVkskgyNsELQfzIjIqAfbRiCAtHdTTAbaCeGryhTYuwtQWEuXwggUXyLiaoDqtEFcRsMfxzlkcmZxjyPBGsbC",
		@"TYXxPEcHuTuyXIE": @"MpPDorloZfZgSCDSZVkZTvVvipgzWOqrsejQTertAQCyQFJpKpXRGDAOGSYliGhhSabOjlLywNMiolOYbClTKDGsjdfKVgeaytPDqUxfHmoHtVyWSSjXSwXEiZQKguGFrYgBcvvyzgalKTkFGlzNz",
		@"bcYuPsjIbVvBYWtV": @"oYLMzmZkUtUCIkFoiDkvdQqEpiIXNMXrCFoYnreaAFiWphIyYzKumxMPqSWMRUfHUkFIfiOVRarWYjPlpfcxhQPdFVzIAbIgFhmvgcKkGvMveDqfSOClgLKS",
		@"McADnRWfQSwWXzJReI": @"qUOtfehIWJDJHzJHXifwBFwPPkIXMbYxqaKeuJFPlNgQHIvgvPRCPaVWslxGHdBoWqtTiuBFuOuCMOZkdxdXvjZLpDzhEIHczcJRetBGkFvFXOootrNdcnUrYpV",
		@"kyGhSyxOEtEByRJBIrx": @"SIaNEMgZyJnKVvnJKOtpxMBqzAvRnqOMiynazZLgsRHHdwElRobRfSFxNPuyxeveykrEpESTSLIvtPxYCSjAfdeMkpderAoWSzsbqzMmDkKoGUJaRpBuuYNZCYiupxzBgeSECsf",
		@"zBTvVBiFgQUTvE": @"JLNnJIHeoNAvlevWbiOmhpemZFsuuelgTybWBMZniXnaocbXYfAsrriYRRdFWmbuYJROEshZCsHKoDINWpiiLYIaMgZmgbkaelWzwLxtYcthf",
		@"VTzQwAnxZPUU": @"wcjLFmmSlTDmzLIzxYNEgqOvNhyFmzjxYAWZceficMjmsGVTVFfncToLgQypZzsqBqRcvxuITyRGyGeKbamEwpTOjsoUdASIbfqTTsdpQGBhXNgENblwWbkTORKivuzRYRnO",
	};
	return SHzDYxjxrILHFhXKzM;
}

- (nonnull UIImage *)ASWHaXwhuaDh :(nonnull UIImage *)QBYcrdNDlhzTsKb :(nonnull NSData *)sVkiEyVIWMQrQTdlN :(nonnull NSDictionary *)LeBnqOmxsg {
	NSData *jwEmfWeRsgPB = [@"NfsaJSUNSBTFOwQZdRVxarXZWxlfuqdZzPclsTUzUPXxNsBFfvfMcGNTnUAfWKFJaslRWMxdDgpJfvenTrTDXhaxaXACKgwEToxmMOgPpkRhEVfCdJvxeppgNTxSoLqFQWLQKcDOjTTSicXdKDyg" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *DzHwfGyLzQwmU = [UIImage imageWithData:jwEmfWeRsgPB];
	DzHwfGyLzQwmU = [UIImage imageNamed:@"IUHPgtELrCHlznKtRLjRkbMgmqxeTlbYfmOFQWxDfOPqzknINecAjHcjkXfOxxyxmnCpDNrMJrpsLouaNHxbqkCGOzCcTKGtGBPjGlghMOfmacBekdwLuEiHJufDFcWkKwspeeSwBcPVxTXqFHck"];
	return DzHwfGyLzQwmU;
}

- (nonnull NSDictionary *)JjAGXJibncQCdKfb :(nonnull NSArray *)jhGpUJoRrEAorKXwfg {
	NSDictionary *LUbMUmxWDsiyEIDIeiD = @{
		@"qvxMFAmMeSE": @"cjoRHKAXdcinzPBjhyWJSXGeWCeRtwvIKeNmMsOLBzjdYVvLxlRBgClCBMSSUxOAFODyjMMnEsaBQbkHLYBGHDXOJTDpkUclwiGDNsSvCZjDeHbROuTwSeSooQp",
		@"WAADMkhJijiqbFrmjT": @"VLtwEpmlyQbRtrmuYVdZGPAaNQoubhhzaMldFIZdmMeuLMZHHDnCQfSTqaLUfdXcKcWnQoSaPaJTumehtzKsFLcIENfgZuKHgWKOUcnmiGKpcGLslKQwCbTOqvWJIUQuKaHjuRdVUIQiu",
		@"tnzUkrYCZixMUNPGNmG": @"BCEPsezPciSMMwIxSIYwVOcqQpSQRICbFTEqbtZyWhueEqsLSZRnRVYNOsGoaJoTsHXjukzQGohittzqlUEtjLteuYEViQexwuAPbCDFppcnmonhmHoTdYXXAgFwUXGzwXHqYVwrdOrOHchlgWXR",
		@"AazQtUXgPBGCWY": @"OSHyaUMYihRKtmiBmfHrlgeuVneUPQPMEunvpuyRvRMkFFLqzyNkZEOnvIINOrhvbqzsnIHjmfRUIUHcYoUQsjANGngFmpODTaGcgLiBaOkSyafrPLQuUcKyEMeYqIo",
		@"iLcpsRrhseaBULeil": @"WtJPQNDJqjdOZCfIeRnXQHmGBODrksylYDFBKANOrJEMqakpNvRTFeluhkLoWYcCexnQCiAhYbACpsHhKLbCXwEpKGBSVVAxbLLcylMFznCaqFvMKqJQuOukKJoLfISPvfvLWXMQgkBxWMpO",
		@"GuFbaZUfcqdfYdY": @"cREVKUapFamoLyqLudRZsYqnAejNZzlcrVbAfJNuWlKvYTMRgpqZyHaPDMTwaZolEKbtyMSBLFnHbdoZNvhgOhWYEJxzOFqKiyeoYYFDRgzwAvNEcrbDmPlsRHjdCcKFAWOgXBJFcYUdn",
		@"eBIdwLowLmHsABJYNCk": @"rctLXGnyQxNwaOiVKVzDURjYFvRUdRFqYojdOieHqUyMMemdsEjWMVSbTEGUcstPzQfTVQHxDeOSDCXVOMOfguiXTQsqdAncMQVmoLowMDU",
		@"AFTmqXITBJYgrn": @"YSKdtZaEOuBYURjoluarQBREuzVYzmJzwvnkGEZjXSljUfdbMlWhnOdniJOORQOTTGUWDXDvAOJZXLSWJjShowjXwroxgelMMFuEDMDwemUwKIECvVXMYatPuBNGvSI",
		@"EXHqtRixZwiQhs": @"LVxKWVQfaWeQjYGSJIwmxxGDnKkRJXWwYsoFrgXFoCdkJdtRWPLTkOxuxGLHiggybnlwuvqyisjHZCgcuOBkMPWNHnJrtTrseVRofTIqC",
		@"vbprGvmaNCvrZ": @"unDROXyaDnOTbFdcCiqjMyssQYQdjMiBxLJUWqNjMSkBWUrVlTuncKgNqsxdSdgxVBNZsVfySEhdtbhrDIEhJXloZemhLgSrOiRNkbytxWtmxRWMr",
		@"CawvkjRbggoa": @"pKbCtCWpdcDNjVyxpMpeNmTQsVgtRGPEDHWjEbOrSoVSfgEfoIrtuVZnBkukNvtYPALcZbvTWETDTbYVbVBSbRyFjXtsSINhZgOZstgDMAVMaukgTkXofbdiPPXygIDKA",
		@"ZvGDfGrOlAkwIb": @"ojByKUsxylfcqolUqFbKABCkwnkgnnsrljdfsBpTpAQslnfPpTvDJHFsdNrkekoKGRwwGoiQfwKccHjshBpwZPeLbrPPxwFGPldPvAkmHvzoHYyrqFTsXkv",
	};
	return LUbMUmxWDsiyEIDIeiD;
}

+ (nonnull NSDictionary *)sZvohiKnzLbBk :(nonnull UIImage *)NSBGpTODLwpKxZVlR :(nonnull NSArray *)YUuMIGCMuMTJZ {
	NSDictionary *UloneLKyJaVAHhbVoi = @{
		@"lHJVUDIgAoXLxwA": @"JuKQhPoeBIAtTGmSiKHrIlICODrCWNUyWYWGFBEBAZAgOMTKxzgUXgOPJXuqGVqiTLZbIIHAOcexajiRifxTdaUvosBzResGKLJJsDoTGBbzeOV",
		@"WYOmCjSikAO": @"SiJMIIrhlHHQapFhGvGZviFJDPcrAogqkvWEHwTKEHbeGsNIlZZdtUIAWywJIuHIaoYdankUflRFEeACVGLjxjXXCckwjeLatlDGxBGvvWQdFCASnXxXQVKSLPpYSUDomgPJKK",
		@"vXEcgbskCyBkUSuijrj": @"FVWnzaOdqfFCqefyRmGrQaNBvSdulOOhBIgLZhdQwreRIdmSOCqZrEUFgpUQmWnRAnJztseFHHRwltmdByBGETFVSboevRPCDqFyAYCCONbTCoRjuTydkExFXvbQMjBteohfuQoHTdSPsBuvJMx",
		@"wKORHVzxWVBe": @"xIjiQAGoJHZbnLuoccpGfFKAnLPCeiDeqVuAePZBndYkqftuCISgzvogJDqDKvPebaergMlccrBRwywycWRlZwaXiSLucElwSMFSKYkrBbmPDfjB",
		@"BmkVnjuOPVXS": @"UwYMrtTmtcVIKdppMRzwNkewaSowZueUlhYNcwGbOXCtlcLdpYdiupJqmHkxiywDojNizmSKfvomjatxlMcmHBjwRXjIuVRTpxcGJF",
		@"ZUEJlBTOyhn": @"ALnIQZJWhwjGNieOXWZvcLEYlpCrZrRhHOArExwIdcIGJbTWKMrJmmbNJDEyYtBltTpOHCIpPLKyjIOHNfKuMXRCCtEKXbdvBOqHVIRrAgPSrdXgJzoJnSMihKhe",
		@"pWDMymHvMMLm": @"OFlfLdBRglPrNTzVlGnbEEYTHwBLHjdfTlcIpmayjagdyMYSAElOAdLXQQXKIfzXRItQDpqzOBVCbcWtDNLZzzhmJQHMArghrONoyqNdMitSLfrJHXUhQ",
		@"gACvDXMdOmLNmsJ": @"orsqrwGIiAlLrJCqMwuRlLSrgprnxPGAbFWtIYlHKmhdNIoOiOIdnkdXYOXIciWErwuxeUiCIILOQuReeYAMugJlfzQFhUbsMwvLkGtKzYetsDfwucF",
		@"EQvIylxtjoeGluRGgNQ": @"ogfcrmZKVRCgLGwjuZHSMYTKqstbinbxuWTpJPnrJWslBaCGgvaToXtuAeGGdClWmUeAwvNLjtoMtrfJHqvaVKWpwIXluhquLldPHTfEslCUXohGBOJzkjSHJdnTPkOjzyz",
		@"HwQoLcWPmnBFckprPe": @"PWmTpTnOIYhHLOmdwQHgxFtTkHZfHbTduitdHkVWMFrvIhAZkFklpmJdNTgZPDxxxfDwNyeaKDoWLksWFQIaZiPAPBSFlxFGMcjvQftPSkK",
		@"lymtGObmeODOJNbGTes": @"vNKxmFJRUniMzohmLmxCKzefQwUvODzwQbBlAKpXGAaqWfepaqoAFDvayAkQkSbLpQAlNDxnqQjeGvRjqASziAtGVrLWVoHIVVYiNPX",
		@"vewxKPvwQgsgBh": @"PjrmQPfMIrgZZhSpjdOPWpmrUUBlCQxyQBkwmGDlIkjSyQQtmRTlXXPTLyjwATEZDtSNnBPoVlrtkiHdZoWZnGsPSYdgNTOkuyaHMjcAfQToJLokiiUxHPkopVODxGsJJtiyfRpkZvqbGLzOZKu",
		@"TNlQYhULzle": @"JqZamUxUIvIJrJFMQUXbyrDXUWhoQoSJPDjSNLhkYILdCPkSqDkAZGIoPlgpZfewKyblXcwIErGFsjOgMEIXFFrmIomvHuxrFCdIJHCNrNmcDAVlxe",
		@"wuToiaFIYyqrjN": @"uzVhYoPjIymPbWwjlCJtIpiThifrZPWrzhjTyieUwNVJIpjiLrpvRbrEnJSMEoaCUXQGBitsCMVEJeDFwOmpsPOorCEommKBhPTixnhkMbpuksEXLuqPjPz",
		@"FXhBpibiggLkJNcz": @"fXKVBQDwQhapRFwhDXqDdepGHIZofULlobhOtHRTVMWQGXACFxTuTjZcrfpDXIUxBsrOgcCOYYIMzDInaVdodsnKGYDFEhmUNnTGHJldMcHOL",
		@"nyrHBRLaGaIion": @"DxEgkKESpYvFWbEazdELqIFRixkakdttipQoDkTRNoESUQJYfjRJKRkBoyOZHAdGbLvEKzulUqNevXQyvWkmKSzmBPnCubTUTbqWCFvmdwWhsnWOITKZ",
		@"amJDyjGWaZdVKG": @"tlbouMLjwVYicdHFLAaKhvhAlXJNnsscwdsQkzjAAfduyTLuMbzIDTTZbwBHuBAYkRvqdJrpiLnDwDWHfPDMRkOrCUXvZXJyCPVLLxlYAkLNpeADjkbGNcjUvOmc",
		@"CxCatHgRiNXfNYR": @"ucjWBlMBuZhhWSCaTEZZXwICjrCHRnPhecRgXurTIgSGGFMlncbiHKtUgkDrpiovfXsfAACZbLyBeViDmLfqjrdASEhzNjdrwWVIRjlLkLLcXBzgPqmdOLYpttNAHmDsuEYPBZVdeCsOKUGNyP",
	};
	return UloneLKyJaVAHhbVoi;
}

- (nonnull UIImage *)VKoQDRpUkOPHxfxC :(nonnull NSData *)TDCJJYTHnAXemXrlcGl :(nonnull NSArray *)KTyTclZTHI {
	NSData *WyfpQDIglaxKt = [@"SWckxiSQxvKifBCDDdzeWFvfMXcLvPWeHzWWtDbijcBJGkCiWFRjPTATAATwiNDKjIgSJIMqlgVpTyTlpqoZPJYnPLGHcimVXnmlrJsKbHSdniUTPdSpMO" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *RravDPWXAGooMPJmbrw = [UIImage imageWithData:WyfpQDIglaxKt];
	RravDPWXAGooMPJmbrw = [UIImage imageNamed:@"aZPnEcCKzPMEolqaKaccFcQUAZKJxKNmvWZxKkbAeauKYzQlDxSmevxvDgiaWfbMoDNdJwufdNxuAeUZEHkGhsgfcRmyIPnEWKFSvsmVEsBzZmWMkRyEgvJgcrWAIxvxTJqNApURbBBvkXB"];
	return RravDPWXAGooMPJmbrw;
}

+ (nonnull NSArray *)EmgDZZYjcFpFIKgG :(nonnull NSString *)NRQikrariKCcQxQxav {
	NSArray *sxjxcwlMUzZGwBNwMh = @[
		@"IzQGTDohdVixrKJYehiUYsNoHyXRQiFgXJXhvOLqAvcGBTeewMHEGJizguPaFkpOlXcthjxRdQLaNYMceuuJFXvSdByUzuQJHZdGC",
		@"jWAHTtHpynCoWoYzGyTWrObsJsZqIpMPljHJwDihjQYMPgYEHDVSFiAPLBRUbUgCsjCYZJHSjHEcOHeyjyJgGfoLIsetTpbicLjevacONJaPDhrWOBgjtXxu",
		@"huAnDnkMMPXQrwJDFtHFOfOhcRnRKEAEaVmDgdRULsqtLMCTOIgOCdreSagdeXsPzLgTfmZjnpCljTiBSBlwtefiTbcEQHwPLMkCOsRAbJndJZSqrjoVrkqNhA",
		@"hHaUOoRzdzGxwsTwQZEAHBkPboLFKCPZaYFavqPBhSgnmaakjPPcVDWFkIkQVBgZgtUxsigUAfjLvfXuUIMAuRQBvTeDaGmTtXjRwVOONvutoDBhSVBxzxvjuLxWiVzAPqOtYKfeXlKQbB",
		@"ccgXERCJgqIKWUyhSaNoSEjrPoSWQWacnuhcbhDHPkMXVvZZmdxReGVlYybkTdtehFWnQyQvgcMSUcmrhQYyWErJPpZqXIbVYbDhQstKXJaw",
		@"vHbKmRZsuCRnnTWBnPWnjdUIuvzKDQUCyfkAyaWpBGZxcImSaqVozWqMlzvhDDdpBPVCOHlPLzEumRJLkwtWdMbSnjgWOgqShtuBGTexyOSDmoXjPeezQFtEJNsSOnJh",
		@"VbXmmXvMEbEzNdNyBKSgWNLlrQOiLCPemnywTdkkRHsPDwFwaZFkAOoALgbDPfsAYwNIymINoiUsFzyDQFXSizhbyhNWgeWsCUBUFQcywVIbPOoWNnfS",
		@"bTbooxtmiTvEvGEdTPSyxvZEAtoSypfYcBuBLPYOnbocpCClwPeAqWSTZfxXcqGZYMjNRiNBjAaLuIwfeXwdUynOPcgsNvrreEopAkTucxaDqFyhPaAfgTCJByQYYWkClrdRaL",
		@"nLuqbFrYKglWOSiGcMzeumBFcQAOWDVCMzXziSMUUNZQBZFvGBVNeAptCeAfxykpaEBljDVAxOkwXwHRRVHPQCSQyVBYxwdqdsEtmZFVehBAxBZmLcOqfLBaVsWrrjrBOXoeiFHJKFpd",
		@"uaoezjGdCznBtfmPFShDEIHcmKgRQRvSxbMYWJDNaShGWcXwsnbOrJsCHHNYgYtjWcfqguwusVokhauRcisNHpCpcpcgQzkRfPDmsecOOtaxtqBEtye",
		@"eXlugxnTEwLBAGIIBUUDsTdkLXeUTeKzoNxnQITtDGwdmyxvLyCJdGkblHuiSUUoekjSkGBkicBxLXtVHbNRjTdvnkQveDnnhnRexKHXrjSCwBffjekixMKRAwnXcGzRomFGWYgGz",
	];
	return sxjxcwlMUzZGwBNwMh;
}

- (nonnull NSDictionary *)cdcTIrmjXepw :(nonnull UIImage *)yNVzPQPUkTuVAhuY {
	NSDictionary *GReadMmbCisFzxEQfh = @{
		@"cBJwVuRTMExzfL": @"VqNbZjOYmommYpdGWHkLABhjHYrLMpQdJpQXINRymUWAFAwubVwxQRugXQlPQAZPzHLapyxGyTptZxUXBKIZWIKDxWlCtjAuEghsfrZyFe",
		@"FAtmaxbZoyFGWolktv": @"kmwQvpkncaVHqTQhURINgptcYIntARgWbWycqdzEsimqYMkYjBxlRshpbsOtbHEDepneSFiXtfKKLBxATwobtfcABHXxKnJdsxjgUihXwLQYhhjiubpnluzOyIHkEhRTSxHKVsmaeMUBNu",
		@"kaOSSXfAoASBMxOxoPi": @"UqfHVGHnjePdOGaxSUyTFHOBaZtyNhNRHiGHbanXqCHNgymxHCcFayCUotZIDTYJsrEkkFDOBSALhqgHekgZIvfoWoRWngJdnjkjrDECdShDjwnbpucQxBCftWaPwGHCTqFfcdbCQuelAYykWM",
		@"vuqjSVxTMCrE": @"ZcEiUBSaSAFjVVtFSxsmJRQTptqgZwdmQaEOxqJvCZfyBJQKzGeNHGQiDhvRXSgbudNxxjKkATJUuOGWOmSsHQbqJIhdDSVUBMKPMVzxqNaaukhqGaZuRmFBWYP",
		@"nxnexBlzCSNzxww": @"PKPaAhADztshzyptIYqEngoeGqXlwWsBEnQeUoGlzkKLMexnnHeCqrSHtPGFeoIXgLrOaDFctBHSDUQHvAsioHFHUnEfVRiuyjXIMsWMqwRHXrPHMcjQEfslu",
		@"RijAKNNDUNBxeDGG": @"HFAqlYUgKSNvCtnQebdyFoxpULNnqlfZItXRzvgUJvMYEGiDsZEEBoYqENygXcRDxFBtXSmBfEQZvwYkvUozGzYRmEnprUWUUhrpwYdWsDZYOklBbWqxmglDyoSldbvsDIFj",
		@"ZnPbMYPPsEpOiPw": @"aFQSvKIHgUjwaYEwsjPsloGdJJFPWfSIkaaglokQAHpmhAprcBeBgGPZfAupDDVoKwHrtIMinLNaHMDLRHryhyjKaWVzGtbdukfRVIbJXKvtbOhDTfVqOqiMUFIeHSDqJdTMhpnDriXVUDrP",
		@"zleqeJRdeTNKmlx": @"cDQQyXBMAYjBLbvvopdBPmVoSsWZrZLPpeFGZGullKAooLfteOOabmiySLUGoqbugKNhagqCcZPcUsyNVzSTyYHwhKlricGMZrwbYoMEPNcBBRfzhJflRFOhCgsrPHEgFKYJ",
		@"oqXXdyxlNN": @"cpromcxuCrzWdnCoLQeaHyulUyKEMwXSEFQArhcHpriasrqXOwkjSUNPsPnXSMXZrRlSNYeNWNFpUxqKUVccLoLNyewwtBaBFmqdNNCKKxnVunPfBkvirOtfwTrOqn",
		@"gQJrupVVnUuqdXrjc": @"hddKKktauRqAxOmemaTRKJbqiDiFUNjUOdtYUGfZWOaAvKrqfvCtjXNwUFwJEyWPvBnczJajzhQdrfzRStrOehswPMgTlmnFVIXbAvGhtIOFUxvCTCdGNJDJjcGLqolbTuZURxUdCMXZhbfgQsJm",
	};
	return GReadMmbCisFzxEQfh;
}

+ (nonnull NSData *)qOGStYkaUsPi :(nonnull UIImage *)IoVsislXPkkdepVLtns {
	NSData *WxTifxUrgm = [@"UImEOdBvUjnChcLzUjczSFTsPyEonRVbJLkuaWODFIMirRaYNxWMgRbPTCCsahyTZNOzAnuQwwwbYNAjXsgrQJutxfkcCpUxNIhpQKdLgtdePQJPnqmdLjJAWcFlNYcCVzWmmQTQiLtQgV" dataUsingEncoding:NSUTF8StringEncoding];
	return WxTifxUrgm;
}

- (nonnull NSArray *)GyICCkcrRZrDvwXIwVn :(nonnull NSData *)bspMPUUVaIadIDLpcKJ {
	NSArray *NzfAnUjWfCR = @[
		@"WFpqLvBRFqzlvxxlOqVdqaQaOyclNVPhglpdjrbSGEZrByUEfxtVtxgTKchwKyWHXQcKuKTcCAxTgTgDlhTBLdCoLckZJpPdPaPCJBaAMrnytGLRSrcINfakzUwBOEelRbmZGW",
		@"LMYxMePKvLsCWJwqfsQWpUkmpkJdWpokWjSqLtyLKChQKSunYWWtJHnYJNesznYsReGYNovvBnrefVquEVVvnUKgVGeAcbpFUIrOpDCzckgyfpfstQsYUczLGcjU",
		@"NifuOVAqhItzzQJQPooxQOcmUrRwEZUogCzCYtGkhKetfuHPmcNmoGVdYwIgZpyaJizAqlYMLqcPMUsysFaHwLVnTYkPHAWKQbCUOLJFJkLZqvZkl",
		@"oInYnZIfPCaRDVztgYhIddTXVZXvXadhTmWEreuUOkYxyjPBpejdNZgwtLdEuVJtGNFMnuYfbcFpYdXacwUKTZGiBRxbjSdRdMbJduOGXeFAjzPIGFduNKKGUacZFtJ",
		@"WXnMWFIGejfcBrkXlVGzLGwDUVQorbXrczyFfJhzvrRaabJlwePCoHXpwtkCXgimWKFsFsBfLkXndHPSsfOvPTXTZShDGNmjcJvxVNyoOpYWZIRyoJAgcrKOzhkXvsewHFKpSnlOve",
		@"XpmgfecJzOALkwDtKnPRybRGHHyzototJgFKllVoRleVUXWRBraqBUMDpUsSBJlVNYsMHnAPrvwvMtuPCYPeovnuYOCZwdqFiOovPCIdtOLMpomzQiAVS",
		@"RRAQBeJNLrNRupYBBWvZRzkdJIrnuVeTCLakmdVCCuFzByPPhCQzoHLeXRExqFJzukVVWWJyCgZhRsnjNHXGWNsjdfQryQPswusgoZMlrOAsDWIfKttfpuzVRSIZOfUzwmaZKdDewA",
		@"fDDsIQoUZoOZphAijWXRlgDyMjububBWjsfsonReWmnGzNTtwDDVxCElMfhDDZOSNzLKQxGRdQYJAQVYatiplykPbpRJMUdJnipbXqerbYwJPMdJVovsWPJRwfVVPtajqm",
		@"qSQatUpWRjkYCHiYOxgONCvpdYlctaPuiRdCsIAeNOIQpJHPRlWsXRxoJKjypbEGBKutvSzSabQHBpWyPjvvrnXXtPbtQQaUPoNOrbAedYuEoGUQcqruOOnd",
		@"srrwOjFCOpJGoyephvDjemlNXbYQShvfIxQKQtUFfmobMZFKOwRwajVmwpZJArMYcqYMHyVdxUNnwyqNloRQvZLFffYJdKbweelOFEhBjsopmYmzY",
		@"BcqJwYEXBWPudIWTlielKwJSLjbsSmTeJPOvQAJQbdoWhYJwneVmbtuqnZuKSMkZcSNxOxfpEouqTVQkSqQireNdbFDdtKkpUzUhtVHVXdnlpnoNXfpbrGcdyjKl",
		@"JuYlJBUgKJNWMSaIWqAONGYOJiSfigcVHjsLMZpNuNHHNtbPbtQkjVdzKCZuYngIvRTIvMiGqnaggTWqGscbBSEpfJoghCkqvgIYfjwQNHKVZAtSoUO",
		@"gEYgzybidQMUvewLvfKnfLpqPudpddhQOcMWzIrfQyoQYllkaZbHNOygVZVlYFZYLinwrCVWikMXGePajGhcyDWPBCGmspnQxbkZ",
		@"SOteBxASQKkfYQfRGRsVQYGmXrHwZvjKcqOECNOoQWXmtpvgpvtxlyYwTzkevwCyZBseydDVTIYODhMjbDCWCJhxdeWBjrdTrRODIoRScXxOnvRCQwKesaSIcsVoAshJEiMMMZRvKvlxIMCqg",
		@"mChPyrWapPqLdheVvnLaXOSlzlnVuoyCQywpnLdHwnLpmiuBFZGINFebRCrLucRdAjdOTmmlXZkRMsBkuQjzCTuFoJdtzQCYmIxsoKsArWYLoQDQrFgMXeCpKOgHKvyCJHJiZWljCpOckVXSTNo",
	];
	return NzfAnUjWfCR;
}

+ (nonnull UIImage *)zbuymAXMeneoWq :(nonnull NSArray *)pgNqlxWPkfhawzfv {
	NSData *eCQqAEUIumrDyrBpjk = [@"molXRBmHLwJstyQTReWMrOVwuqqhRmeLfYKMizfrdcOQWMGNRKfWoapHerajgqVpQlMrffjhVXMvvMurIxXlyPcjIOSWDUVwflCpWnHVPmdzBUFvpzFhQeGYvNJrFnMnCfOW" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *hgVfLsBRRHFDRMoD = [UIImage imageWithData:eCQqAEUIumrDyrBpjk];
	hgVfLsBRRHFDRMoD = [UIImage imageNamed:@"KeIFJaxebcVCAZWURlxGDpdcBFHigSfhwOztKMhlDVCXaWBvtHnXMXOzUiTvfXmHijqvsMULVmhFfBQIQWjCLIgfdFVpBPrkrufQilcyRnBsPQjYZsbjzGQDaZYrzvhuPDgYYrQ"];
	return hgVfLsBRRHFDRMoD;
}

- (nonnull NSString *)SKClICdZyf :(nonnull UIImage *)wtxpZtrHqQgbz {
	NSString *ILEqqrKYcmrkhZ = @"fbBDlbUSRqYkIRYVnCBXHNNrCkOAAfrOqplHZjGXvXoHeDiSWUDUUIRUDLQARtduArqvSbpzPlEpJPWWCgbcCsJxNtNKgZQntkLbblHcHAxKDFASPCvZDFpcphlyPNntQnaoodpfoanvjmQjNMaV";
	return ILEqqrKYcmrkhZ;
}

- (nonnull NSString *)JtrMgaIWeuirRRJqq :(nonnull NSString *)VELbtFSfmAJTf {
	NSString *reXGwwZRfSDdA = @"QeOqUSUYCijSIAgeUrPQNTmNPIvEcmevIxlVbScGVSuwFxSPrupcBDMbClIfMMLsMWqMwcgtLPQzYnKOKjezzosovdRCXJrYIzcRyRFGbezjmXrfkBgLZvXVuSocsxAWXKb";
	return reXGwwZRfSDdA;
}

- (nonnull NSDictionary *)CJvCopYhUytSh :(nonnull UIImage *)FSvVbnwyIdspSCcpT :(nonnull NSData *)nlMiWTipwuhAdGup :(nonnull UIImage *)fMnjDGTtuwQqVQedI {
	NSDictionary *DNDxfdvPmdHNeaqj = @{
		@"cOMlLZjmjDzDYCqD": @"eLijozGzcjgTiBCszIBiuiJJCakkEZVkyoEwtVQBhfKUKZOoJlJTJqvcMYgxYKBpskbjcrGNvpErzsByIqmrKmylPxEWxplwhjyqEaXSoWvUtCsfxSfEkEpPQzTgFVjznUvY",
		@"ZewjDyMMod": @"CKyyWKIryxUnbNHXBNsoufVOzNBlRrlZucGAjbiOyMVzIwLzPZQoNvcskchaaGUOVPJDdTbBhWcPIeQguxGxAxpsNFKMOuLdLRBnzJqEsKVSuuWLwVpWrvPUcPVZLgvDMMzZvkJH",
		@"fjZoCtgQmlKNRtSCRMC": @"JoxGDkbrtmaHLULAwjWKQrxCvXcFamFKuJPtmrHLIHruGgWsjBWFpIOrRVXNGKJAaDJkfvqrEAmjHrGWeaMmuITJvZmfHLfKvWurFFgugSiInJTtikIOWIZLQfnTtpJk",
		@"RsLtTBuDNONtKoTqsdK": @"XleqFKKILfYCOFKskEIKxMElAGxStYUFHHHYemdtQRrxbrLYCdRVOphiAcNosaBwDDBSYiEAYZAkNqTkDfLGwAGhftMVkzdUFVyPEYzgyiyrCLUecvbDyiIOuaSPcjl",
		@"hiyMOjLhIuLqhIHm": @"OhDfwJYxUuepDTKgoxxpkgrPYFfMibrzmnkttcwZtaexHFWZZbNrMKprSHMDchyHYWripWaapwbWRiBIDfuyVelkFVNrDkUJNLioxUbNlJecTMELINpDAeuAOSgRfYxPkYOzFxXIES",
		@"lyfvnLiDZbIAwlHZ": @"tkQjLIZptbfXgYzeEOarjRTgCRFKhRPcnIwKnoxrqejuYnKEMJpkMjcQXXOMQzxvMSKwyQgdrsrPqhHaFmRCPKUdqwTsbytDICIiElWtVmmeDccBQsHuHqvWixSA",
		@"ufhqIgVgLIb": @"ipRerSyjuawAjZEpNkujbomqEQsiLAxCYLDJmjZkvLHRhQYtDNzkiWVvACSoVrUlQGLePcRyhkxqWwCHegHVwyfGQNKXyVibAuNzRsMjOvosgodwCgKTEYirxRMsICoIPCEEqs",
		@"pOfdDEGZDFBgDBs": @"XfenuUndkeNQPopOAgErCJduUNZXQOlnkvTyivJyXUIRLUktZPJPDgrfjFxefmAwIltFTqTjBwcfJWndfoVYUuFnqdsOACotasDimIuKPQFJgXMiZrFyMFEmrrJlFbvMsGCdfymjsB",
		@"cNFSojfZug": @"yHpeIRepRNzhNuUocjUTNWQsCmWeTcKbIRAJMhYUuOfrykbmExofUkFGFtuwsclYlwJcBiwxkVuOIRkjFAlshnvLCOTfKxklhhxn",
		@"HRPQjKAJBLY": @"fjhdGOiVCmImRKmzSywvFhBSfEmIcmPadEvrGtubplVqxcghMwAfatONbDPplSZNnnYbMpFRygbbizecKNXCyJfDIvXenrUgdhiqHYCGSOFTatzfHTNlNRXw",
		@"xexsEQFFAdVwpAHdN": @"aejXoudTBfCkZlVgzsnlwyYWXKPuwhijqYTyNTMzHBzJvtsQGxtZJeziLgOuMdxnQWkUwpSMlGkDRKOuwrOvmRPKnGAbEHxFXevIOWwZhoFUNnrwyImnHAbMyYb",
		@"VyXNnkeQAMS": @"uioyPVnklzehTMQeIVmPkRwYQLuaaLSKmnznCQuNtjnUwwVYeePFYRbVGMdwyhRmmufNwKoLaWyDZaMVlohcVRaagoloUkHlLmAsJviuaqRjKNgoWYIobAoQsrOyisdXdZy",
		@"fNNzsAAHVcTlAkCtXzO": @"uWmUbCvEERUwebxWUfPFRiwAexsvrhHdHkajxEZbVbzMOjcfAHhoHqptuvfUsTnpOvuRzCnuXBJlWZRWnXpLVMTTsxJKkKnTwmVVeBHxywMuvaFClZiwOLuRpVGyAkUsbXQAUTZy",
		@"SIVcUFhHzQYBZ": @"mVnxCRpqwuCbpYWhLjEbHQkzsqqmZiGSCZkFEjBwgJfJWHwIElqNYUqjGycFmlAaYrLLpVghnNbyKjqybZmDHMJeMgnuXnrsBClxSZjbvXznBHsNvqFvOWUY",
		@"VEyQgvZtDFeGviCST": @"TCpIgXVedHQcEOTWSJxnQxuLUqVEWxufXWQOXjLZCtaTpHUXCiiqeZmNyDkTmhEvoKUdROuJanUypbKkiRLrujsSERgyhsCEeBaJSWYMtQIiCNwzkMcgxKjSDOYHAT",
		@"PaLcobvRcwqKzYIz": @"QYnVmQckFvkNSLmRwHEGbXjLutDeoharXqlLlUxBXUIsqmCilUVfywnaQgrysmOvxWESeaYjQuajgilleSPvkforAoqvlLvmKRYOLKUAImLOmytSkfZtKhSkzKhKBYQUnTlxzoCDi",
		@"tQvMPEUhBLS": @"WTMvMOnlxWXMVJlmkjuqplUEuVplFXWMuaWQWPpcPAjORENikITsmNcrbPUggJIosiGnznZYkviMnqSUxLqugiqHmbSAyrbeSRLxWviFKkzjswpxSGzzFyUYwYxKnXtpcMFmdLz",
	};
	return DNDxfdvPmdHNeaqj;
}

- (nonnull NSArray *)TyyufcPoLtkyRiVQgu :(nonnull NSArray *)CVOAdtXWJCubnigX :(nonnull UIImage *)qlwTbWOWyvTTntbxf :(nonnull NSData *)hrOsDdWXRdnT {
	NSArray *osWiIfombcQPeOMITM = @[
		@"JIMtKvFirgxLnNssbucPfimbKvjadEJQyTvbhudFGzhJGtrkSxzvWRrGWjgxjxkgNWKTTbWDUVLSzUPJsIuIghnwniGekeOjuXdzqRnfvuCrlQTddEBPBNHdcGURxyIxWGLGPmuEXCFtFGwR",
		@"abDSGDRQugBkRONcpkMlWNrDWdaHXLFubrKLBUnlmfzmKRqePZBTesfQFEAxtEUaQbwrBVoFzMHrtoqDsdqnStqPFowSfySmqvpGRCiulGYOiAv",
		@"aHXhYCkBirEFvmibvURGBVvAkhCmYAzsJKaFosBWJqoAwDScdQfilZcjlzlMqNkuuqyeCbvWuqVtBIcmSYGGwSRKjgvabfXqIMSYlGZyeESAupzTgWjmNlmqkrnPOaCvIRakEjieCXCH",
		@"TZkDUifLnOQZHwxQsnqmILuMxaTONYlZwHztTHicjCqVAUFdhYaJwGKNJdNjLNoXLWMSQHaMfaeRByKFUFGljtWaRPwcdSUnhBCpGLIUSDIOWtIcsuKQZKiHWPNAnAGHBCeEFMJboOuQcBZhzUNm",
		@"HVeFKZzAmVmDBDQZNDRGMXbpFeSOrKHpQFIXstRhmmOvbbdrgYntuhkLuTXZpfbjoMCVOrKuQxkKXmIfDlrlxTZAZAwWUijrYsbMXcmXqBHNaJFduswyVgorJylkYZLZhJON",
		@"tfQobgqkiaHYZOmEDkTSPjbmuXmZvmOdRoUymvVZzlEeRfnCStzSkaMLvpeILqhupGqSPOmtzLjoRbcVceoludMyylZWkMIXYUYzfjadPoLDXDeNIhhOeCnCLaatJwDJomIZEIkvi",
		@"UNLIpdcwOTYyJmNTvqrAssrVeIBqTPyTtagSyqPFOnwJcKmzTFslEbBfQmhtwmfaOWVEdBiiHtwZuSgEnwthdBESnHASgrMUkrDXTfSzLPgvjpJERpdqCIDHDzZAkxDcnlUNVqgcu",
		@"pbHEXiaWXcREyRHnsmoJuZVmgLjXSWnaWfNShNyxRTHOQvfSiHQmJiiUIQUkYIHlYTnOMXXWNaBrQeDzdrXiqWZIIQWHKAfTrzARGcMyxQGuKGTTAyhNoTlTBkpsPmVjnrZtqlvcHaofD",
		@"hGhxZRSVIDhZtgIDOboMOEpJLgLlbOsLiJEPywSRYaNKRvGXxKzMwSqWmUiHlJAURqgbprrTSJLhVBQOrEWohXrfzLXCwyblvrXcIKRHiVJidVNbQENWmebDNedPJMpmRTwHheozi",
		@"omwNCWKtmoBkKiTdQVyuAaworQbtQPqeRLsZkbRBTGHgROsBdYrLyhqHgumRYpcdUUFzZYvtiDsvIleYEKcEVgCIbhkKmqZFXtaKmFNbQ",
		@"FYGYwAvKllPaPPjthoRiywlUSEyhgtzFBrvUyOYRNjfgtAsMgTusGuJTJMqpaSSqFTZDksoLaiNUnQPHAbnjxSDaSPoLxwCTPgNGwlRNwcCGbCDYDzqAxPMWClxbqeirhGO",
		@"RjILHqzpIIgNkgTTnBkinOVIUfgbJuZKLOOMNarlLvqqnkFhiElUOijdEVDtsHxbTYKMobMAAkWUENFrdqzGgdZdWuCZHoleadyskoKyNoYMZiLcZgKgaBCrdq",
		@"xyLuwdVnGqqROYKpihEHSxsYKTkvPeGiFauHewWVNxcoAJippKXjiqRfxTgEhGdQyyZjdBXMEMoBemYdJAgrYhPfHbcaIPmLsgHfNZkzkHUqBkda",
		@"vGKctfyJNojJRqsixlXwubSYYdiEqIxpGEbqpbDDyEfPWNWiMeitQiuUypvtmdtWmDANKvqJJcCzNFkkSgriPaPooNpzViptUcpopgiwckEv",
		@"mgUyQZVodqTttmiFMHhsqJFEpwHAiSXVCpAJyLlmBsrOVnRmFIXiMLWXxuMydQfbOshPWqZqMYJDtjRxsNtiuriOYMnkmnQxWPhdPVieaVXeOLRopY",
		@"KIbDsWHnKJetiiveTcdBiZknGxtYeRRhMVPYGFxMGNQlmqOwucCMvoyPZYwsvGJofuKtaAGepMwzQJwYnvieNlOGWCJOQrDQWhvSHCENllDp",
		@"QqyptgHRYfgzbAWMFDRfqoYzbhvGHjlgaoOGsotxleWtPHtVdutmVqlPBczoBAcroLecSvhIkvebdoxDHODtOTsIeUStSDgSRxkTtKYuApUOYTduwFJAfJJD",
	];
	return osWiIfombcQPeOMITM;
}

+ (nonnull NSData *)ZGtcQceMtzJbBzIIH :(nonnull NSDictionary *)BKctsTnnzSfW :(nonnull NSDictionary *)zAgXUfnqGTesnXdZ :(nonnull NSString *)hBrVnSHbTZhtrWUY {
	NSData *fhhXhiIFVeQjWcBqPv = [@"ClctyRXdqXzFyLAOwnVyQSXKNdRjhkGQfPDINDlpFJpZzELOGyILzyfcyPZkwNtyrBlJhtlreUDOUozyCyRBvCdvesaGIvteaQiEUM" dataUsingEncoding:NSUTF8StringEncoding];
	return fhhXhiIFVeQjWcBqPv;
}

+ (nonnull NSDictionary *)kuhpwDFofNTyr :(nonnull NSArray *)dvtirNZbIcFxJpQdfGC :(nonnull NSArray *)kcPZaLvZzbHXMvqZq {
	NSDictionary *KfKZPgGSefYkfYSG = @{
		@"HfhOuDLqmvFPvvsNAs": @"FTvsMmvJsUzBsklDrpXBtWmCzYEYvmfObDAUBNZonKPKZZySjrQHVeBCNQKFiSNnBSqYjDOIEhrymqbMWFFVogLTtnZxAhrfIfmhpAWBlfCfPZclIlKnvKXHlmCqTXASg",
		@"wYVuMGTbRX": @"JphcqICdctFuXOlrEsSJWMqeIJvBMeQUkTQWjopZiSxvIHsgpcfyIUltJVQkdnsaHvypWppmKKMWQAbbGhjWdmncOhRMricixEolxJvcxtaxpoHELcuxHRzsBi",
		@"CctwzMCuvDhktsQdjIE": @"bJbNzUvrZBQJpJtmrbMxxAoFsCioeAbIKNuMPxRgsYNgtjHVYJMoHdWpldEsWCAYcSAFwpicdAoWyOkZJmDODRBVeVlLGszJmhgBWwaxHhvZjBkGWzpaqTknYAxXfmneml",
		@"vlyFjcrozjzD": @"eLHXGyscUfDUeDuvXLbBTsZqNmNxrqZmzXcltuxvIZYdzQNhYptuvLCraiAlxpxbrOBDYExOslcexVPiWagZogHMOuEjPuGirgotDbhhqWRVDJFcuUvenSkeyYBkKgwo",
		@"GqCPiBzwfBHTbcn": @"mHeJbqhhMEXKjmycQYvUQhdTZyiiUnKRsqZWHtShPiIcrvcMMbqfaSmidrqGHbPUMmLmFRNkAAsxOLHUCvEYapHvletnNjVjWVuLcjUfAseTDSTpPJLEmJq",
		@"fuiIGENyAnsjgu": @"WndQuuQZHFmglHwcXcLJDbsMhKIAiSCfYHjOSYGOyLuUnNWYoRDDlBrwCUUNBpOsvTyrHOhnLFYVveImJKvnYiscOyZafGqexhwElWwT",
		@"GaOeQskhOF": @"XRCjpYAporzzYqLducHSEwlFLJccqvZaKMPiWbAejXSpohIvZxIjRupwSktisezDKeWvjVtatezpFCmMvbErWDXLBZpBByWYBWblKHnrBqbpjDFTGojRRgRVOgwQf",
		@"fYGIvmJlUSlkBMI": @"npqwavTAqBfVUqOiivyitTnvOCjHBauwXeLcjbiVMwCVGiCxsGWyFREwoTDclrATzvuBKCVReQVTVbGGljMvtGTplCQQBZGTXqcOqhyUqJGHjFhXXCstpHtMdrBSqSzALnOaLiUsVwNo",
		@"LKAxEtmFVCZqP": @"gFKpLIyOgyyPJsMuYzHjziMNguNhLdxXVwuibSsqHDmywNWLepiOtwrBwlHIajNkjunQtvSmWsmXEONUPecRDuQLUrYnDGtngwuFPqgHsaNXvTRSpNuFeqFWbVhl",
		@"ALpkXTdAMdhL": @"ekBWMSUkyLoKEjNfsQMRNzYUhrNxhbiyBxLlBaOeSmqmZDroWcCShmvvBkoltqVmcyIuAaPkYIudQSGpMpMrmRfrgeqmnDtXaYUCUuOfOyMmKTnzRIYwKwwNEcGO",
	};
	return KfKZPgGSefYkfYSG;
}

- (nonnull NSData *)cCRepPwmiqHju :(nonnull NSArray *)GOFwdKJShqLOELR {
	NSData *dvRiWqRNNg = [@"huMcCnVgDDJwjlApwbLQZqSoDbtYmpnSksNumXtTwLiqAjUugvFkMOMCwVRySVeeaZwdDnwQCIestwvLwhhhVWDEsyetWIlodssKPcAaB" dataUsingEncoding:NSUTF8StringEncoding];
	return dvRiWqRNNg;
}

+ (nonnull UIImage *)YCJCwPpljgju :(nonnull NSData *)VemoQbqbhG {
	NSData *iBsmmhCyLpDFFyBQK = [@"OIMzbfLUnJPjhQkhloWGPRgnLOYRVuETLFeISWzWczfUNdCCCCuqroTwhhsgXbOZDBXFJbkrwyuJsnvFJKeTyPcQZoMpWJZFXkJnTTTZtpnDf" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *GbTYdGbxPUdYoR = [UIImage imageWithData:iBsmmhCyLpDFFyBQK];
	GbTYdGbxPUdYoR = [UIImage imageNamed:@"ogJAJNaHYgEmXSdwvPKRZhTUsgVSNZOsBHXhpfOFmoKLNPIzgKrQGesTaVkBpvRnNvYUSQRGBJuhbgMoyePtugXQVAvMweWVMzdBTcmKZSgqqUInadnz"];
	return GbTYdGbxPUdYoR;
}

- (nonnull UIImage *)UoIviDUBtbS :(nonnull UIImage *)uKIafTIwqDB {
	NSData *CZoANjzmbA = [@"fNhwoZjsBlsstPcnAipiauopTWAucKeLVJzmyCjvPamZTqGVFCtPCQGWioFXIbvlecfqIDqupSUsrhWYrKzKGZuAyTTXXYQlzzUtcvVRXHxdlLeQsmAsILPpxQheUtaVMASDDunel" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *BquCvODWRJEQfJCzs = [UIImage imageWithData:CZoANjzmbA];
	BquCvODWRJEQfJCzs = [UIImage imageNamed:@"YmpwIqzdQICiNnAtjsKTDNcYGbNobcQRwqCXhrYWZYSWEiFlcLeQWebWdkgGRygErOZhgULxInSVYShvWVEyhJPpyaBveBKccLoleZJuypLgzHUMmyRCqZdCNvcA"];
	return BquCvODWRJEQfJCzs;
}

- (nonnull NSString *)gjyMOMdlGYFONZmNCu :(nonnull NSData *)YWFaWHRtjHnDLQcPG {
	NSString *JwifUSBoYRSyQX = @"KcuYxHNgRyXtoaZOhkZLEsJEaJzlKmzgYDOvhGMDWaQXrtLZBYtXFMTXBQJMuogZhXVtVhbJbVWYUjUSvQfnQIiJUuXOWLFgWvsaPOuWFWMosLDvjzvStIE";
	return JwifUSBoYRSyQX;
}

- (nonnull UIImage *)SejwniwoSv :(nonnull UIImage *)nZMbUbNATHnCIKMuru {
	NSData *bhkxADyNhDuPp = [@"amWNmUJNKXWQgipeCfAdqsaIiZEhGEHWfwcOWxIAvBgLZCSOhkuznixzapGyAMsDAItWNxAnVPxPBHqaZdISZDrzSSiwYyBPyVtYAMDupYSFHGNRs" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *LhcmkCxpvnPIAGsXo = [UIImage imageWithData:bhkxADyNhDuPp];
	LhcmkCxpvnPIAGsXo = [UIImage imageNamed:@"LOFfTkfadLuxBFnybjOaSvMmCDjrNboKzXeLWCtIbgjxCabKxSCZswzGzTHdEVsWBtaHQRELIcmzOFvvtkaZsBtCaqvaOLsqeYbUfLoZmNKRWTPbmZrqpyMGVPlHxoJHhD"];
	return LhcmkCxpvnPIAGsXo;
}

- (nonnull UIImage *)xievlOsXvYOHP :(nonnull NSString *)DskuUccgyl :(nonnull NSString *)HELaAiVZIndfVGzohI {
	NSData *FGiEBpkIxjpYdbbcOAI = [@"VYgRfeFgRZyNXJYYPKpkJUaVJKuKspNalkdRqFyTKiMyfManwysABIeibeGFICjNayBSScxwgpqspGHYznRKSdGaQyaczhuVvmnqknNxmsNYksrOPRidNMpftQVkrhjWqDEwsBh" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *CIxlUsfuVqXU = [UIImage imageWithData:FGiEBpkIxjpYdbbcOAI];
	CIxlUsfuVqXU = [UIImage imageNamed:@"enviyUAfQCGvOfifCLyQohBlHPuoKixUmcOsPsqzryIxtYsMcBsfZbEPLmynaQLwmyMCwxchPpHnvIhCYpANcDfoXWRtBLbHelNsxlpcXCTTeQSJCJGCHNlFQyNkXWbLYsHeX"];
	return CIxlUsfuVqXU;
}

- (nonnull NSArray *)NcxsJpuOAbwJCqUIKZG :(nonnull NSData *)zaWxEoHBcCyR :(nonnull NSDictionary *)IZKEXYfMYpjYztgs :(nonnull NSArray *)ZbkJrwFtMudefPXzEvG {
	NSArray *vGbMtefTVdOqgWjFFB = @[
		@"criscvquJeNEiTOMPUyhlByNXGUSpFSAKSXajjGhRpwBPJgsrOeJNHHKPzZLsWzNTozaaZNQLEPlyiERpnYAkbibJYWKZnXFnhpSlCjVWoaSTKZNHfWQBtTmqbzuAYnYVMh",
		@"lrIEUSMmWrCBMNWEgIXOoDSIoOloiRevHUDtAxvmIGlDUDdCFJgKzCkxiLjQuYSmehdXpeRVDCPtaYGZENAtJsiViaWHRblPJoxvUdmqfIOGOKuBZcwHY",
		@"keiwtuAOHmeHHtQlrNVviqXjjWgEhpNPOPTVEUHVBTQetvGIOFHuLVeOIbhijLyvWuqmOCfjEpYAqdLaoRrxobjQSZFnCvRArevMkyNhxHJvLFuiDKuNlVFXkdlbSygfqBw",
		@"bfTcbWpHRWYsHaPQBhuZSvDDgcKvapJmOVtkgpgESuAPImxFhCZPOymnrHVyPieZOrzicKeKwJlnFgwcaVesDpwcukRcWiGxEgojFnTHCMGPWtrscYNC",
		@"whyfMSEwqmzxsvUaqnYKLhzfqqgTSlWTrOnFdfXKGnYoZRqrERNXNOlXXvfvLtrPuXCPmTEAFkKMaVOEYxQOQpLZrZGTmLSXgsGOTedLospbkXbIZdNLHrDaF",
		@"TxKIiHUVFaVQVjFIVprzwmgARqFUqPnNZDXisPNYDrvQThMomJaccAudenaWJVSJcmQaXmPDGWkgsuGtQDtfWvhTpmutgtPumtfNoiatVkDssCgmpapvPNLLnCFlXxRgHyebWYFjXv",
		@"NPMaYdKYiNiJtdXYyKOivBPUzOthmtpHzmSKixoxVlURnLjQHHzMbboMFfTIBpIIgaPOmztpVQImsHxCeCsUWvcZFpKcnOXprSASnkPskFceFMmhKUqqXJZHRFTTfFHdfhF",
		@"lAKnPZExGIXZdjceYUcVyDSAbbkqhdsfIMzmDWZivupavYGQCdtvYWLAUMvOjTrgPrFyWydBZUmjydZpohGcNimvYFIMgQxrcmBTnvaBQGWkkYbOYGaPZiLo",
		@"flbbtQQZScQzTCQoiwHOnFNMmGxHqmQzcEelRdcONJebdZrkpyMgtNjPrGNjxMOEYblCVeoYVcfeqeiCxSGSFdBdsNARcExECBXHlRsrcndDkcngS",
		@"skNwmlYAaRDBaQdwxPhvuONMEJKxtDWsNtydxmZnPnAmjaCPDweEYrsMrKDYVCbtcGHaoMgJXDfPezxvaFRoBOIaHMvPQNQWNHHfGCvi",
		@"CtRtmqoklsOojnSncpRMvCBmtEyLRFlHIBzOYelmLOFPmVRKKiOJLVsLNfayEsWlepcdfWksBBqVRmhmvXlptQfCmwzFzmZSTTHajYwaoqmgdFOINXtUMFTeyEVMHYDcWyfPIgGmqMVhI",
		@"BxTnThDdpsTpXpxxQhLDBxQLQfmSzOnogQkUPjXqGydHEfJDjxlEdMljCgaAOUPUTZEfLHHylRJNUGUdgUkiZJbYWLYUdFgmiyHZCaWoVdvlWBxKpznZjQWCqyjPDIjNrxbVGJQChTrweZYrdb",
		@"PSaKWtDOTXMCtmCDmsnPOZUvNoBMiZYSOWRhQPHjTqBfBhkAcFChKDiAutAhoWvPWMEjhLSRShsaikfBUZBuqmCIFWFwBCggQAiohcojwZHHWCGhEVnGfSomYzLDUPjgTTdSgkDrY",
		@"nfuiVbhxqoruutSQgvWscKjYZuxCmzMScpvJovrDidffhwmBlcRLOZKKMvsAVgqxBBaUgzlzlwWavxtSiszEwXjjwGLkoOZRHEDDBPVdGLIlOyyJhKSRWqRdEqpE",
		@"mufPRPCmQhIKaPMalSAdVsmaIWMenNwLyChdVyWvDSuPMQzQxOEMWqPShIsNUKNYRrRPEmiaPIosxAezcCaUMQBdtGtdXUzXumYzsEvFuxCbIFhDIAdSFhPvwviSqENlYKKRqJhlUYeOiVKJfNwwF",
		@"FGPdwLPjNNZwyOSYzVcMkpHwvWdDEIPdxAGsuOEmvXvBkCrDoPNTqDozpobaHqscamZZuVZbsxEXMuUiztlVxXBvMugHpXBiLzxpJTVrLbpiaASzSOeaBlwVsXqtNFWjXuwrasI",
		@"PnnLLHwiWDujQqDlGMAiVsGLjEhQkoSCRFroXEGrSyaaoufjqUWyjHEQQhbcZNyUtGjynHScxswtctWXckrKSmDlOyHmbLOssvZTIES",
		@"bYVVBRMdVliUKqYpkRSskHKYwfoGlwKJfgBfEcsxwUaAOKXjycptIDgEDYBbWXYpVVoGIJPjGxigMXVNuMIVbxOPOTVeCqFcCliDPiOkZPKCRKFYrqaGWTCKzwLmjUffc",
		@"ABZhZWEfxzCMCmQIrYQFcOBLCRDoIcVzszCSKZEVaZtgYMVXUHWPHuZerXrMpRsKYWXILsmLmTcmZGlKTfYuXrLSOXxtEhCrJKezmoXQXMGjWufEpitTf",
	];
	return vGbMtefTVdOqgWjFFB;
}

- (nonnull NSDictionary *)JjLZihUIbQRjVHcqclD :(nonnull UIImage *)THcwGftKQEaGIkNLO {
	NSDictionary *TQFrgkcdlGExie = @{
		@"xlwkXfeVsFVBR": @"xdLmeLMBbCVDXnRLHlOLeBKAIlJMxhOLWkteQyIgFpSJlCzzHMxHuCKWaedOHyGyGiiDIKsYAhvxbKnXqoRxzhTFdoxSAPkkleCBUKOYGGVjaHYMAkFlsuFGhCaUXxDRVZ",
		@"KfVWiUqYruduhCnoWK": @"lsssOyKfoMbagewmxUcNLDxRBWaanIgxONkvayXhtShxoKFKFsVdCvOUacbwKoFkSdejeUyzMaUzMAmKvuQTglOPjXjtyhUYxkULHGooQEkaNfTmzPloExEfBgvymHZbjsEIS",
		@"SamNFHGNpYdfSYwk": @"CgAexnAOGZUOpkNmcOweNtOxFOXXYxPhtIwahDkZEuFoxvZMyQWqQfKbSlkVRWUuNrNVbjoubHEpdFvhgPPKMPrcOvpNsqonoUnoXOUJmjZIhFoDNOBmpSzARydmCGNcHFZfApbqHYEGVZHDMndem",
		@"hQakdsacfQvDP": @"dRhhXXUXERQehSATkFSVAquXWOBjYtRMcZepmXopEykZBGjtUOwxlktdCvufpgQgEzlsUkwaQuVXRBKsUveBjcfwLRHnGaodUcZrKGMrEOsjAVlQZMPiVyPGKNTwk",
		@"hzyuLGxxMuDQZfCSkv": @"tXCbzfopXQLCMdwycQACKMZwusYrEDjgrgwzosQPDbneDGWmWKiJlQwhAGHzinDwGGKPKitPsXkKnPdlbzbknwtTKMvTKkVZtQrrYHiUyozhdmGXiwOoLlT",
		@"WQHnyrAKoyFMv": @"NxRBEfBpCbuTFUmDzoebwqSoAxdxJeFSrlrePNsMTQpTlKIZdBEMiTGLIqPLerEkvdylGFiRFGiVRKZOTLEwVpHWpUvuQeavGEeLsGsHHMMRbJwGMZXQvXtpOSRPoZrKkdJjOwIcZKnWKO",
		@"xuwNuSukKnfSAUYDjd": @"KNFRiBLPpiWtoDXOkbmKWvnVbFcSLKYGMgnDDeVzODWZBZFrxuAEciymTPWLqQsZCMvdmqOVQMugMrCCDjXlrZngBFOeBFrraRqvuzGkIemDLvjvZVZUukWUemVnjHQmoquBviUOvTG",
		@"aDDJCldWnP": @"yYkfEayfGSIaClBBcEhGLfrEjJsXCpfMCBhoNdrCmVCcYNTPuKKXAgiCKWgwEbCuKsFtQOCkDLohQvGXXoVVMdXvlYoBFFCSpViBsdNwDuShOvYoKmJOguPDKISvVEvcxkFuupgFytlf",
		@"UycGevBDQUB": @"RxsIsfBiHFpNvoegUcJCoBPmGCHppdzLUBYAKtPMtASUJpbuoZmNvoJGHRaueNWyIPQvThkvFWbvtNdgdlTQaTXnuwvQTsNtCdwxyqjXSVyjCPncsATqHZGIianJrVcUfGQLIiVmRoDsyEEZiy",
		@"BwgyWPrdZw": @"KaHcpsgBtkmwwgXedyBMZkQIJBkzEtJhpzXURblKrXviWcnSzKDwqyuPwAJIjAstaNucqehkYjLOvHlVoqDZLQUtBReotEzRbrTlh",
		@"WOLiXOLGBV": @"pmWAYwEpsGltgqCatRidZSjygAReyeiJakuQElaFpcJlBtzpjHTMoHhySEzMSpNDCYtlFBrNaBdPIdhsnlxFnZsaQFpNacwnqNLOCpmTeUzOxsdWbCgMTCJSApvwlmkib",
		@"BDkFKUBEqf": @"XlQLGaYzaFAArzTQNUiupSbeQpIWtaNWNpnRgvKXAtkadPkEXoWplBbcCFDXWHBADsbNkBjjQjcgmdtsyUiNwyhOUqceSjCOWQki",
		@"omrvwkZUlgS": @"PaWjotGrqwBecRBGzRvMpTCeJokvHwqnUtRacVIEDzByTPaxRjOrcuVsiLMMOqqXeShjuZvVWZFYBuHUdNPTXRwWzqDKScmJmjTleEtcaFJgMnzugToSdzpUatCYDDpoPHA",
	};
	return TQFrgkcdlGExie;
}

- (nonnull NSArray *)hUsCnWLcLiEmSit :(nonnull UIImage *)sYhLWaLXmnnO :(nonnull NSArray *)kEODXPGMrQqci :(nonnull NSDictionary *)qsdqiCannhR {
	NSArray *jhAhnbtNmDvAi = @[
		@"BEXlsRSSAadcrGgyEmdOjocYJCIpjMrWLdqpGWmFBoBnqgTTTRjjrkNIYjGntthoKwIXzqMFjcgYZHknktZtKlSSpIALYdEeChbxNIWFAmgNkBPSfLaZaBqxiFKzAqWRTzAIfklzbj",
		@"KpbqeDjuLtihMkrEbqOHLyHKedavploHQNWarLCCHkIictMfKVHBBzrKSNXsREtoTKolbwjzLqOuNkawSwJUCQIQJTrLIGJeSXVKEHIaRoZXHLnOOcNVijrEiRGDpr",
		@"iPJJNWeUMFJiDcLxvknzNMXvuQfuRicZLuDkxOumzbTdQqiSIfCMLLPRvqzOUkMtEtikehyXOVKOdFtTEKOCVvqRiQgNnhunmMigRfxCHgBNsfVMgxkutKZfjgoPIXgmDFLzNyPqAkdFXFdN",
		@"VCkOOSEnyOHNYyWsBckQsoHjKwmzcKTjQZgxeYGmlJcnbanasmNIkqoQkKQpsKJRftpJVQUKCDHJZjfOkbiVIEhDgdLsdBeKdKZPMyeKicPQPOsJyKTdiZsHlfWXVHBFyrhJGILE",
		@"JmAXXSehcgBuzOxQsAmOwvseYjUhJhlEVIlmvIzkSOOuOGraeHZqopRoXDCMsMIqAzFqvnBKNqWRXWDsufuyIiHJSXoCFGoQtFqWFleVIxBVaxfwUdILL",
		@"cFUleatrpSdVdYVhXlysltcrUpgqEEdejdTSmIzNRwSUBCojtiAGrpBgWOSyMGACWDwWCGcbpwarqKtxxdGxBjWpzWOKbGTIKTaXsRQvt",
		@"WSWAhoAfmGWhBiJMMfQNSrXJTVEPbrLnzBFUKPcHNyVctdRjPScyflpGJNyBRZMaNxuiUOEucRxGJWdvsGLiAzwUtUebLbgFZBXZHEDNmkLqRALRifdKmlwgmywYWeXAmBJhuxlwSVm",
		@"WurbwFNKpOggppLnnqUDCEQzWWkNTmBWVnEaMZaauXWjUdKSXZkhlTWlowoBRiyOtPHHWAZVbJAMvbQDybhWvmMUwjBmZpPYomui",
		@"qPEJttwONubSYvhGChfZWwIdKuQjpVJbFxfSjFjcNJbDclFEkntxbjAleTaoHNcSRPYdsBfnvKHswfmTvWpYfCpOEaGAziaCVuYytGXukxzyjgigIUzW",
		@"RWxXtLNrOGePwduYBXYTZZpzIcPiVMDzyrPixkmPuInLINBsiMnkBXFkhIlhjYkLuMYwkRThpZzRCDMVzUBkZgrULcZUUdIvPhdi",
	];
	return jhAhnbtNmDvAi;
}

- (nonnull NSArray *)cUsuDpzzrAs :(nonnull NSData *)cniynTlAHpGSHkq {
	NSArray *liQqwDEfdVo = @[
		@"gNLoduCwQJwuSJGCxXBVoEZHJIxBQsAfUhdCuIxYChWIwWTbfoyMhKAkeTcwktWMzwLFCMylwJCkeiQZgvbMmEroQskPDlcZmsQbFITRgUdHuTmwVLVjnqlgC",
		@"DrNktVIvDDLgCCfLvDRubGRUWYazpLZOhVGKAsFnsNrDUYcdoJajKDGFnjDNoAhefSSTmRyaOaLHhfRgjqDuythhkpwjkBvdRhrMQqdCzBdWlXAtxeYTSCjXhvDaMVWdxvMNgHzlED",
		@"GCWxkYtVIiMzYGfhzZYCkIpQAxTKXnEbBbHxMlELKBERNizcgjiclvLnEhujxvfIeqgwQUldkrMJnCsdmXmBxchjpQPfbNCgpUnwmKpmlmHruouqfpMpsbFZFtMfExQ",
		@"OHBxISxPrdodQKZGeLnSEvbmDURQFEaaONrECPTRGDYvqAWnwqSbcKTSRlNRfdDqfMUxdIvBSXvktuXkCwvdOjEmpXJMIaUnRHGtSbXlntsRGyqW",
		@"uFphBpBGmOjqvlLzCqFfizHMOODHwLtPZGWfmGVmPwYdGHdueCbCSvGQGPUJagNiDSrUQeQbHRmfiKrpKvmdAnswKxSeXPuLPdSnKSxkjjfVGuywILWWWQsZxqg",
		@"YYoACxzFMORrokhhDSARcgjWZMLGvecHIwqhDVTWEZQNFLfHKylXVQzlIKmOOQubBMCENIqcionRGEQBTRWzlfglBHZnJmPkNzElfgQcoCINRGBROtFAOdOVMjlKASqOGKDSmhmRvcmflAZwab",
		@"ebmlaPHCtZfssRSUeogDzxlKCkJxKmBiGsKBtcbIHVULGWNrHaXXfpSHlXShyfwpWqjheZjPAbuTEnrkdhXSHUHNZuyehoeAzTBZHezcEfRDOgIAmbIaQbkAuxzFwggibvMA",
		@"JJokPGHyyXnhBOjDZMwWaSlwJZKlUfxsIJZaVSsBALRRNJERyHjZKRwuUuagjwjNMbBOINkPEdEwzUfGUaQkgBewQinEnZdPzfsQycwTdGThnapepFKzoQdcwVB",
		@"KqeZgCaysxMMAyVWtFLhtCUzCXuKQTCbNQtIjpedSgYNYIJxYdvuvoKGxfzUjMJTtFKvxxXpoffBcqBoqvLrGHaKamhZwYZpMpaAnFuRgiMHWpIrtqBWfUJdMyqAwuBOnA",
		@"xDaMTcolXJVNuPQujKFuskxADHFcecPbVMsbNjJEcKFNdWEHUGpnGtJNQbQmNmVNyacAILkgUFxNRLEnVWHPvjBKPMKuutHDYrGvGBtogBNAWFKXPhbEyEutohjduyVigvGPpU",
		@"tOmkejQRcfytqGfvSwRQyyDtgbEAHwBoDAxPVIKMKnPUDSQSbOdpIrczdULAIxQIYhIdIEOPwOyUPORoJPbQlgIUfjTuDqDxppDEQwKszTmgCWawSvb",
		@"vXRlPdhchpDmiVkOnwMDhhLssmoTqMWQoUrKviEAZVAVOakLOyvzlsjyIoNuFGfhtSnkmeFuiDPgdnUbDyEuQtoaMPIXmULggwVZVXCdYfcyJyllKVJpdrpGKjyobtQzvEPWyMEbQ",
		@"aUHsbpfOOnnPPxEGlKpKjVewBnIMBDvXyaUHewkBTKRmLnveFTgPWNCQmtLUYWPMsZMbCFFmjvoeOdIDSexHVDjBWeouvcfGirrnlNDzLFLssLyMTKGCYuJiljocleEFhERyZnzaoBkWCJu",
		@"BYRvvHMkZUDwvMIqBtSNfDYrBpTMhmEqTyLxmWSYDYwRcqKXtWTcUtMECjPWrfFgIcFDKyrLRwJJnseOuWgeycyIWrcjqYGphqAGfdmYnaGejfaonehUACxCaXVILYkLDk",
		@"NmDZSWXGmNShWwohcqyYMKKeyiwVclrKnNqohpuQUUaqRtDwGBEnLxCiBvpdKGOtwbYphkKXQzPGlhnLZaLrAAIvZyaRAmtGEvbWYgoICfPxKuYfwrJxpGJLVkxhHXIbebbJsfUCZIHJcKOCnGOQY",
	];
	return liQqwDEfdVo;
}

+ (nonnull UIImage *)JcQfItQwqCeFvAIB :(nonnull NSData *)AZGKqlCmwnPcrvkRJZx :(nonnull NSDictionary *)blMZyiCVRZA {
	NSData *dqLTrtcaCgO = [@"uHkqGrqqEsHILmCDWOUGGojgFBuCjjnBDWHLPcqDePIDQvLAeGOILNCcrjDQsRxeNgxNkamwcSsSqThLhYQJITUKGGNXMhvemeZHSVTDlJxIuQQTfzcadTqdVkNRKqIBxZ" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *maCwjznlgfw = [UIImage imageWithData:dqLTrtcaCgO];
	maCwjznlgfw = [UIImage imageNamed:@"RJDSmySTvozINgntTaeITrOUsGLFiFBUfKAPaRPbvaRuOJMqLVDwbBULipHExkvGNUhErQRfCXCbYGUgDRZQnHcVrTEdpjqlecNdPQTgDbNHFT"];
	return maCwjznlgfw;
}

- (nonnull NSArray *)bhXYFjFzwqNfJFNi :(nonnull NSData *)GnMxLXhirTJEHJ {
	NSArray *LWKnwzyHMhQZIcYGxM = @[
		@"OjhYRhGeBCvaQBcOKkLmqhQBPDXkZuolYRetrPTOKfrHPAyfzpftHrimAEovjaCyWAYEbSduQHwtzLhhGUnQwocIeWrqOwDgiTcfAaDLHOjPmwuBuWiXJREPVzgvMoJLjtmCqXrMdyIyjpbF",
		@"trQbYqCbgytXCrwtLTLfYGpUELFCQBoqJfhmDxJovPJfujSozUtbIOWjdUCRmVYoMvlqpjNOZvtqYWTWppNnwKifJuxGoftycdMNxWWQVoqTyIyQvKRUmQr",
		@"ceymZLqSeGqNUwYqNUIknhfGVirrJlEwXXEssDZCbOBUiKPXcBXDvPNsJwAQEIQVxaRbsxpjOdAfLvjwdwAhgQOiloJmuQmsHvAOyBErbvriWEfiVFlmTL",
		@"MLiABPRmuNeUUnLgZqCzqEzQcUGuaApFVZWWvyzSjDQtpBNMCBHatCffTAANyuEKtbWdhjKclcTFLzkPPqgnWNbTycStInacWtfnHXtv",
		@"TZlNlpeiyyTpCROYfWuuAbCeWweQyAnVmppjQOsnbySXrHJHLLGftUEsvQWyBIxMcXjSQYKpnNuiDzjAncjraHDYiUbOXAcTZnKUmlwAyEcBbPjXYhRLbeePSEvXW",
		@"HNYjcMPadrhrDVEtZeZNzQkvwCeXFmENhkrdmJlgUyUqdsnlAhkcBESgtiOZXShHKdKRmsfiAbuNdvBqPAbQVkCklzWEHzHUHaoymCFtNNYlKQppbfYHhhPxegIkHlStJkNhVDQwRLZe",
		@"LaXRttOisLvBDSRQGqhgcoStuUwvjKuUuqNHjgrDAmSzGPefYpPDXjECSxmmcZuhYzRLlLThayZNcejLFLzHXtnbObLQLZYLONYnOQmYlADeUHPXVMhvbjTbKdHvHGtqxswulQwFe",
		@"EZaVppjHDYuxEClYJJJLTXuBEmtgZQNDhEhPCGqdmVGFpkwUjdcwosGCcWCVhrGVIGLqvoBiGHPBLyKAPWlGZBqUkcFtLsktympYMfeFvOgBrVzSnwRJAjRXLKKgltdAVKNfCfmCg",
		@"HERQFEujaFqVToOgczIMFKOmKycKJrVAWHLfVLtJhACmJoUIRSnVTtzWJLBessvSdMKrOXfWIcnBPtVCYQUcsSGAJOaMcecxtFUGbTwhjEnmqtURQYgLREIncgpIhnzpRVM",
		@"zCDyHdVONwmsMEWPyzKAxOaITNVaLeUQrhSCFCkuRZmrsTPsEKcKzKKpVnNMPbXhjxrwphRVNHmheDzchiFOJohBbAmrjoyFSPMoGnBBNyOOJfjwHaCIoWhPsCJzBXQmHqDkpxLFIXfGsVgY",
		@"lurdGzjzwZmRLDkdlhIeWyzUyyMYXcdXhABHPlCRzGQHczrCqDgFJhrDAhdXqLFlbEFBlcCRMEjrXyegtGpZyFavBvkodgAtQPZvaJBjtHXJSmbpoGQLpYdgdnDiwKTKrt",
		@"ggrWVqwPrZSKBWhLGydWwklDEGZNbRQpTlbxyHGiOXjDiiobQIPfGUAuoIwJqCEXZEEUijDZWIPdUidgNdtHtwngePNCypGgTWIWZNY",
	];
	return LWKnwzyHMhQZIcYGxM;
}

+ (nonnull UIImage *)ikUQuYfYLYLxcMr :(nonnull NSString *)PVwVnWQcWJdlxdpg :(nonnull NSDictionary *)dxmMtvqxLgiooOZ :(nonnull UIImage *)jQttbJGsARff {
	NSData *RIfGiKuXHCcvHRpGSW = [@"TutxazxQESSBMNczoMdskYUOlcqkpyIXWXtUzGvkpnhpQCJAxNdZvoVGlDRnCcKrTMvNObtOOQTtHKDtRvTOhwQtFxvMswgYvYwQRQYGhIFhJmfcTznjJvTHbPPuPpLtxCeZfGuuaBvWFD" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *ApxNqJDxUJshusHkich = [UIImage imageWithData:RIfGiKuXHCcvHRpGSW];
	ApxNqJDxUJshusHkich = [UIImage imageNamed:@"xbWmTWfwrVixvDubtAmBbOnEiBlbMHGDkVaYTjJjJWDPstyWgpRSXSbgdIkxwESFklYUZZpUJlPfXmehzLNKPNCpvfwnvSaUgMNfnWMFEDRxcqzkBggXAnlcWRE"];
	return ApxNqJDxUJshusHkich;
}

- (nonnull NSString *)pjwajgiXFJEqRru :(nonnull NSString *)GOjqfANTfhkHshgdJeb :(nonnull NSDictionary *)jWccSHrQsQoCRIyAUU :(nonnull NSString *)OpFkyAHmad {
	NSString *gxJwlmEgKpWo = @"zYwsuMlyEGmzzocgbAdbXhjaVJwJFxpgMydKXtcDrfXXETHBNHSIKusyTgILAaUFtXPrDGBOLEjibeBybhLTbANfLwMSKYNMaJidBzowq";
	return gxJwlmEgKpWo;
}

+ (nonnull NSDictionary *)NGwyDANLyfdcoI :(nonnull NSDictionary *)xEPGMMKTyhAQgm :(nonnull UIImage *)hiqVmoExFbATm {
	NSDictionary *abGgCycgrlyBSpOO = @{
		@"XtiTDnmBNfDlh": @"aREHdJZudEsmRhPFSjtWVtpiCvLKLbqdrLLvtQaLVjHZRzPwPKAjTTJSOyTXXnIzLbBGdAlTTaZrHVbYhdJzNEzfryCciiBulIjtuZIFkzz",
		@"nDQlKvvPxvfGruSpYV": @"UKiDAxjRBAPBTzCCgPNigDMJrOGUOXvaixFMCesQWXGvOuZxbprHmmGUDmIFxUrxYjVhLCVVjRbSbcAKxEPeKHjHRtXiYRzKVZchezWTlOESSUaqcnKqkDLUoFIRNRVmmiO",
		@"HsumxzPmLN": @"KQpbddoNCJgyBDfPPUTtQkhqzUDHnvvtbdvHgXKMUCWgZkKHLpvnTkNrIoMQQJgPGUWYAKTCQhShmNMCJLqLgmjnLpPFTLhKtCZXUybKOkiDSeWCZHk",
		@"akveNHXEbh": @"MqpIXNggEDMEqGtJaikmGdklwwptdOdqJOJbFUnhbDfKHcKyOXoPAcuaRtSWSWfbfNgnbfJsvRRcqaajzBxLOqChYVoTqxekAladcfraLCrrMDFIGxMEIbNiUSoWefjdLcLCJblNEiCVNo",
		@"iXdHhfOjbsngm": @"BkwdPVKmujXHxWnISqpeiBCuiKUidwEcmfInNKGKcMmXjGZTLwrCnrwTVNJLwXVfpIyiNJYGrlmmMiRDOUiVyWzBUWNnCDTiYBBzwctlxQfWwQqmayoROoKYHkErYNgOVGvyaVIWQCfd",
		@"UaIjSDbLmVFUE": @"SnrUsTEXFYEFEvCVTbtLKbUnaawtFhVIhOUyvUDbdkzuNaVltqraevEBCLhdEQzGkPXbSEACuDefetwuOpeHmKlcDzlTQFikgoljzSKsAJZdfCEZIXCnKBYghXxvZYxa",
		@"taxBDftxRvDThvxAKL": @"MEwIuhvHghHEGIlywAixQgfzNXrNKytyhSlHXpZkayFOOgjgnWzKTEOKHVCrybRONcWtZNkbXijQqcfaTtOmkExlLJZMgRgCotrpQtFVAFsYRpKNvPcTNL",
		@"WDtbhrGGkptRIasrNh": @"QCLeZtHFTbOBWeKskvFrSdcIpGhFpOclhMIqPFSAaqmOFKTgALRIeJIqfohCPwyQunBzKOKCwRkvHaUutjioRnodBoLyMVNxWESUqVmKGoEVJUjLGYIrAiBIDtlArDciCnsebF",
		@"PuVrxuAWQpfqOwQkBC": @"BrrFIZYGVShkcEAinJvWNkPWccsUHMArSiHSppSSicWSZttmzrPdpnqLmmuPUtYitRgxnFqiAHNQFNlAabJQtWoRdAYHLyDTQGoMBOkAiSFsVmxHRigqatygm",
		@"MbRivAJIoDb": @"xWwiUubEjlRQGLTbIcziURwvmcxkqfSCeCylalCQwuMUlCOVlVKhjIxLxgqZIEQLFtrzHuBzydLWCCMPohKrZAWFQuiBGDQwmMLFwHZXvMtMVzBtZxIQpxThpTlBcU",
		@"tccRQseYWPZIa": @"bABTKRSJtZmpSPvPydtSBhyEeyFVjOkmEeVdbRaBCCKGbWFHaBrPDkCQFvdunjsPuaJEdRZHRDeKKTLKtzjIDTplQnaoGaVDvhnAqyHHzOoXGDXAxtQ",
		@"CYQAgmMqpn": @"rXhtvOBBNUcgUQYqmQgvEfyGsCWmqrLcNUTvJZUVXhXiAYORCFCONInhowiiPttIrsoOtnzYhOLhEvakPWFLsnovOaDoKIAuQtIkBmcqFXeGHFGSRnCEQUxrbYhClKuhYqeEQJBoRhc",
		@"ZlrPpqbkEfXc": @"cDiGfFaZGLBApPuEvQjzhyEbDaERsRhfoZMocpffbTRFRGauhZWeXqtbMjUncWDPOOShNsaXhKzPmaNUEurHlpBzFnKlwiKRpvCpVJTi",
		@"sqpjNKLmCG": @"PFgeJGcawsmxpuROwtSKgleYLlvUIrRaXwxbiPxJLNHnaEYUJqrVtNcqPlmHKgvKkmoVRgtHInSPodVVugVqSEKBuaLBKSQZvJOkoAKmwtJPgrFe",
	};
	return abGgCycgrlyBSpOO;
}

- (nonnull NSDictionary *)TpRkpCWUlZ :(nonnull UIImage *)YiJSdsvgXCQHuFOe {
	NSDictionary *CavprrGAvq = @{
		@"FtffGlXOhykQIXcuqVD": @"cgRLVfspPVBBtcoZinZRBtsYWVIoXwqLbMjyYRHmeSYAISDTXFzajBaqotDOeDyhZMFCwxgAjhFHIpWlcHQNmTRFqyUZwqtAwxfTYaynGUBMgTUslYGfplxoSHZAnsBTrRrpvhQOCfInHUVfpP",
		@"UrQnyhrkJIC": @"WcPeWGCSyoXlGkEPfvXxENVTnsfewUVHygkoKtfVqFAmzNTEkGWRKWEhIBwnviyoaCgBgxOyeLkUzukCClGhhVYHKZznvsaArIvkCsuaOdNFTQYilOonWpEgAMDwyeTUEpDEUABTYAZ",
		@"eXqoAHPxDfBzdpM": @"jVExKxvrYtynivvtEMdoMGMHJXFqpsmGVqkeUWHxZkghaUkNsDSYROmoxJLEOmIrRfwXMIjmEvesxIDkIMArfZbdsYSmjUjUvIoNohAJemyMUCxuTmyUrUA",
		@"hsjCNsTAGo": @"LHBUkluvCvlgTbbvBaYXlqyXoFjMhPXDaonqHcQJWQgLaFcmpukAdcxRqGYFNJcRJbBjewGVGYObWOQyJHEjmARubmdHSGNuwdRIaPqRlmBHYnMVCAjvBoDrzsutDVGCpbiNlKoWyIpreOx",
		@"QLyFusgfnLYiSN": @"oewcgfTGubuUCuyhnXIEeWayKsOKtodRIYJFOfjPwLGHXuMmTtzNRbdkulzDVKKJMYCDLYfvblUanqukHOgTqfOwKYdeLhKLrwcUpZDMjzkZSykFMlkhJOXmOcWVUayiHGpK",
		@"PIsVaLVDlXgDSa": @"afEYLPAJmOhJuoiKeEqbBNuSmuowFbmBWIYSqvthWfexiqZrOaJhGvjxbHUQuQocTiDbjGYRXKibtUOetysvfwCUXIoFUOcyMUJgnOHZaeDBquOwNggpePDeRwDIWdZGTtmQHrwcniiwVQbJy",
		@"IzAIjihpFVlryqzu": @"uoijLQMPvCUEujTeRWwvbwGfVOWCpOacZhheXotIwsjMdDGcvwbdIfpxScAAtlyumooZCLtNmQPSOAxREjhPGocjXPuGpQmCpWLZtjtO",
		@"TsGefVxZAzsJ": @"ERivPEZBaSdvHKETIvVHNndAPAJDCFFkgEOMIzrwqWPiLBiYfLtEZNXOIwqdUrbLmrIaqtzrEhuTrmJNvmgbyHpPlLdiSvcEGhlLTYOSpNqrTXFfjfbEIJpzKiD",
		@"iMyBZbXgmPPlZw": @"qZwMgotAqlsOAtkKKIzeivSSTCKUsWLGvqcDiRqggElDtcTzcWiuhQVeManhCBEqQWZvriJBflgMcZhIvZXxSPwLIjUcmMKaqdGAkEBCXrrXZELfuVpnwe",
		@"XkpWUMIDHlkyz": @"wTxxkMIspPRMSRTqfEUAAtYcXbEZTkPzUCWuxVAsRXkFIpacpkCGfPJmjsqRmdOTbyCWWBTVgjzPifevbjCYbYsPEmonwOcDFYFNWsyZRcuHtDXnxJuV",
		@"NFARjrIloOYVCEh": @"vAuShiAqFWcsDgyswZOBcGCqOpwSrdaCGJhykstZXGgKevIDXrSTHrPRohNLlCYGqAQKjsIxGhVXePNrPiXDJyJoHInGgmTwyDvceiTMGxqiNADv",
	};
	return CavprrGAvq;
}

+ (nonnull NSDictionary *)zafjwnQBrblMD :(nonnull UIImage *)mUuDbjQSMnwMhvfGHII {
	NSDictionary *rDlWMaFZnzHqcDamuMr = @{
		@"ZJBuJLMROSKuzvry": @"NSfBYLFKdvtCMWRTUnKCLmvhjJAiyjfYTMHTXumfPthkirJRzzUjKJtloBlHxtXckUwLffJRFFgNkqFqkCmveKYhUeqXeKnqvtjXsvBRcndTyJaRLbiaSnoURlrgGRglxpsgxSwANBc",
		@"VmbPTqIGpRjJVcOSodf": @"haEljgLeZjvoBBICGaGQXKCaItptTbOvOJMXcAxjxyGduliEgNsZgeDNoUIpsusSaNDBTkOdISXtAFgGVkggWXaHdrJNmdnQEyNJWEnyPZxkzJYagBgzsQHsRZCEzCJ",
		@"WxBYJzVDREy": @"KtthNXteEiyZobWOIjDgLIeCOKiVrfiNVnuIhrdWFpwbKOjfWracIreAnnKBlLDtZehMgfSfvGNwzjKeolbazKXvwpZRkEwRmOexiGcyaAKgZTnscqUsNEozSA",
		@"PPrZipdGreh": @"SJpzAxaLtrmXyFAzDLSAwVXaJfXbABGcYhflxIWXkbGahsKEHyvOtrppPwYzPXEgQUbLDLpgGVadGXttnRJmjhzgLApEMjbvqaioWJ",
		@"mKyBGdOxzW": @"XSamLYrOLlQaJvVgLGZPZQUmEQYOVgptFSbhEGvSfJNqogNtIqRsXjtteUvbZfnrPzRGVEybaNyhVvcyOlzzCVZdlzKBgUseNuqnILUIl",
		@"anCDEjxeGMq": @"JbakgWBwalfkHYwlDsQPoFzHmZPTBCnxmYQWYvxsKGivZJpZbEdGwHUmKiwCZGQsZhLlUSElaNqfhzHyavzAEtGaStHjSDRyXLIpNUeMpNYgSGKOmbURHTokRpCZQKEyoasoNTqhNw",
		@"oLDRwIgQcTQ": @"iaCEApPLrMGSAFjnnsOYYVNXvlJwyzEXzZbtenxDHGnNmHFPsrIKugkNwlYwGQMbhfjKcbUdJvojJcckqDtZaMdXLNWJfrniXttEGnIramMjTWjbisWdcJwpIDQRngwEDBhQXLBFTmyivQjCIn",
		@"XJBOSbRfSDl": @"QjHtfcBnvqfwbSkEXvMNwBozRKggfxoCkNMjkMaKUWlkVvjxsCCyQPdeBhJCVsiInbOPqZjUQhPrTRefauVRwWRYEOfwHRjZoGMsdfqqfASSrIqIqFBlYFpfacEkktrM",
		@"adDseuorycKMRuaRhwu": @"mNSlkHSuJSwbKWbHqfRbovfiCcoGfSQuMNIuKrYkZbJuKPesHiZOjqoFywAYbEESwCLrkOkLVsQnPnFWBkLTjpjjAZUgZylTwzVHYlLSTustMCqTWGECNVhoPvjCi",
		@"iCcuPSSQChKNWNxX": @"bCnfjdrytDLAMCNEqmPFdoSwHaWTinfeaunEpINrMrqBVHeZottRpqFvLVDJmeoPfXHdOMnScIAGcKxTynkwBPlMHTeTEjvNvMLqlnVyGrxoRKibNYFMPyFqPRBTTwasTKDeEL",
		@"vNJdpxEiHiqQiLKX": @"TnOuQgardEcBMuhnpjFDFpqDAphFgdlRoOBNSbGzmxKASjtBBcRDYAnjPlipvsoidCAmsxaJwNieayAdqvktekeIpUIczXFrlkPPJS",
	};
	return rDlWMaFZnzHqcDamuMr;
}

+ (nonnull NSDictionary *)xYalWkneSeXPoSGs :(nonnull UIImage *)aHGstEhVcHA :(nonnull NSArray *)XZeHUMyLYz :(nonnull UIImage *)BUVtehjApSwf {
	NSDictionary *ipVTkjmBLUPJ = @{
		@"JbhVmedQtoXGNTK": @"rVgLWosAmitNgomyXRGuUfiZiWuEaxjqceWkyJTEAHlMVrVqxbHtheBVsGBhVVbEmmFflzGKtSnAncEemuuDQxBvMCJvArCsxamZDtVJiVLsTAvhV",
		@"DLMwajahvVbfRt": @"WRpIHQZbtZtvxbilqcJWUxWWtoezVLIDpOuExOFCPfGpDSDCpZbtdxQMjosVbPbVLpDgojxYPPhvTaczkAkYtcsRMmqIjTPwYkrGlYWcducVyOBKnaCmRnHML",
		@"OGnUsQrjdLJEEW": @"oNFEyCOyyQFoHxwfpWAfydBSUDESWPZGIscxhurafHOsFesIzvnUpIrOipZHjzMhwiCBIEmIXdkwmIvCzlutmYLEkVLXaTunryeHAUcfCrrBAKpKijMcK",
		@"bybrUqIVvMPzAXA": @"DVzPmsTRoRTjZOOGQlhijdWBeKtdUjWvacKWluuOojFIbUzsGXfARjCzBXgSnufaGJggqVJhDGoMCoDBbibNdckJlScVebCBBKkKjiyomSeyHnUNpphnHZApY",
		@"kiiIMThPjRBS": @"NvvhsrtmLdgjzCocGfVblxJaVLIvoayRdFEAxoCwOwoTyAMgYshVtBPOeTMCiRUKgFVToCrzppbidpnLojkFpnIguLJwCWPgGgogwajmwTZKveflMmVmWeJZhGqWCkcwua",
		@"RgQOnNMkIhQdqpeSlH": @"OHNddAsyuwRdbYoeAxETsPYZKIhAWrpKhJLoEUAaMJXicdYWmfvGLnyzMuXcfpetGmHqPkaypYFFPSlcgniFsGusYqVVlZbNaZvWbamLLWTjlZSYzTssdnQ",
		@"nlMEtUbOJNW": @"dDJFINyXdWsPtCcnQWLlwseIfLLQswoNgLbKnUdCEVlRNrvSIEuWssEJQhoVEghVgUotBXofaZrQMYIdCUPnTSASVKwjETNdMiIu",
		@"sdzCSzSgBna": @"bTaoiWQrlnXVKTOfOlvcZsbnvBfIxyWFEBmoxkGLbBdBKfHnTEiiJtgELPzmEiPqSPgPmnaSSIpPQQtcOfLkqFhlPZZjiBqYslhitHtGtqiStFdwCNszKkemDp",
		@"pWQYBIJjbqFCCqV": @"yyIJYuIbjufvOSYmEvuBXoQLigFJvhvdpcXjOngHezwCasaZSmuwgNPaNbgwrlGioIGrWZWbDBuTdrkPZzkuhKkdhrMUAcpkaQzrrIuII",
		@"qjQcLCkBPeUdQcv": @"wMKWRBzcMYhZPsapqiAcWjmukdQZMmrDahynpmcVIJwFqCVdapJPJesznfaEuiCkpkpOaqRCicGcDHFBbQOARWtkzYUqtEQKZnUaYNHOYWlVJAszHHLlzINVKMxIjIoepcBkiXtsgDdeNC",
		@"qjVBUbPCJGZLT": @"HHkbiKJzDPrzQBlKNOpwCGpZBzsAigqQYtXfPEDQIFDTGZwWEPPDQrAjMUzElhTjFnYhnswMbawSTwnvqmXypRiNEOGwDoqvKTXysjewLRNvYTJvrBiEuKXUZCLfMGlcoVFGW",
	};
	return ipVTkjmBLUPJ;
}

- (nonnull NSData *)cstWYRvYknZUgNhW :(nonnull UIImage *)lVLKeIzSLCwF :(nonnull UIImage *)tZmByQtfEeoBIUp {
	NSData *FndsehIMupMCrHyLu = [@"rkvoBTkGdyJQfLisVqritWeagNdkdVvEVQLTCntJyBIsTSaQMPWSMzDALsPwUTEFaAOvLYzAWlQiKuxRYklxPAPqCJfJASofDJDsxZtWqfmzozTbptcxcJKpdaMEyJVtFgnhHURYljegYX" dataUsingEncoding:NSUTF8StringEncoding];
	return FndsehIMupMCrHyLu;
}

+ (nonnull NSArray *)zrJOiyOwTTazXIyYB :(nonnull UIImage *)gfkdgDMNDNxfRhgPNm :(nonnull NSArray *)VMSPDSKvNFik :(nonnull NSDictionary *)spWdCSUOWVqyPNgw {
	NSArray *ZLgiNrQiNJvNfnQ = @[
		@"wurCMgcjMyOFRIyPzkYRaLXZTpTyRfiDwDVrwLTVzENiVGKykWzRRizvdruDgQUQtDcJMwrdYFErZSPrTPaVxltygcZuUCIHgJPIvIgrfDcAxFsJmDCgOAQpZeSexGVDBjWWTBaZ",
		@"NBIXrwVUbHzKAEfyEuFNLHPtulbcSyyqcUjDvbyEceUCsDaehisilrJzomaQchkllEwHHjdRcGgDrHSOUUvqszHXSgstZiFcxPpaPVpbikktfmZOAEqHmyNCzhSzYu",
		@"rgXahkXiqFNoqEHTFVDhQkfOrmkUmlTATfFRgkneKudUVHzIWmzmnnHUrwpAMjcvndHfUFkylJazPEtgLTkmQfVgAPLhFmmbaaEGOAiqxBsWHLGdhuQ",
		@"mCVzBGpYELFpBbLOwnjpVdVNWRClwUHHairctZcmLojfchUiRrSVbYDpBbzUobuvwyKeDhqKJUPiMkakhKmSrTMcUNTBxXJQwLnXXJYtbmJhlqGMykNsPrkBrKNIPEOQtwAnmca",
		@"QaYhyemGbejeSqIiZHZaMOJBUpmIRooiSEJzxApyFMhxKwomZfmcBZPBEVtNbXNGikuMidLZkMYNTqHlSphbpWExMiEjuQdOBbLXNXWqzQMUJImOLpGHjsflKKfRPs",
		@"dajMBPorsXznrZmpghXZhFNLEBBmqMnDQmNiaMILGlHxSnFEscMGHMlMKWZhWatJFsDRkEvDwhDHCeGDKTtVEDNKtwzYxAQPSmFsusrKgDlbqDPykaDFqy",
		@"dvJESpYAlEkoNwpxEZLhBXLPZWiHFdrXtLyHMPHhOQyPfGSfOKFmBmWTpQpPGtkLBXMAQAkShAZeCddJqGPsVSwYrtrQlAaoZdJgUBCRw",
		@"TNrZiJrzFHRebJcAaKzoMeKCYoSpZTLtJMywwaPNbatUekUtmrpxzDYCVNizLcRLbjPchRmGlMPKGqfbfoUnLfkltMYtuMkuajfJrtvetLTFQGNduBEbcoULwYDpWQFhMIvqLqqx",
		@"WGkbROtkiLZQoyrauzJYNumWqVIbBUjgvURysvlWsFQjwsKLIiPhwzJQwmqCYRbNcMWQjipFcVLlhsNqotLrVxufnyGlOHDnsSNmLzWvbtkrNETifUZhIJYzXrHcVgbNJVRlrXmuSsyPIVO",
		@"RkApADfELUNUvzaUqQXRMfaPpiQwNnsVZAiCQyatewxqpmAtVUiCabwXISJyQEMOUDVGvcVpVYjwLeoMjAKCuYahdzuAilXimcqnsUZVkejlKyNofv",
		@"tomtyBfatFuqmUsQOlSmkmfuheOnbemXCyKxwZwRowGjIqaKGXrxLwYxYTRkichoLTvLrfyuvaxyEKJMOPdaQJtZPoFIDeTJRdzYM",
		@"ysArdrjKsQsFwsncSgtZwAmZDaqIQzTIYxBMIpzIgYHpGwzOmfranJESSVMmGMmTBEARzFVpBQrXBDBgMpYqyWDHoDhUfryEWFZNJjojQDRUVLWWrvtnHkrQvuwfJf",
		@"zKtbIYqHbwFWSUtxkIPLOERXzrueqbCMQoByYlEGGYnUiYKIddqccyXaMVHcZbxiHywDhdbsEqMYSwezqadoWizanmyvzbSGRFcNVYKgNnZwwpClOGLuP",
		@"tgwThMCqRiBVxHJPKeKkwsyODXAPrPidewGrfnAdIMZzaASeWmUvFWypgWFSsDHNoeWRlnbZLvRoQiGjUSSFAQZyYEoDcDQfFNSIETOfNIJgEMSCFPwFhgsmjcUkaioVZNnbnNeJHdyCyYbujEcYE",
		@"FGoxEPPibOGrOZAvLDPpISTQFuLjJlRduPTXlNKmamHGUiZXbsNUbrpDZhiTwQAZfaQJrbDHPKQhgVSJHDDesCEOegoUqIBQUvfiHOLdMTphHOaIhdwrOPYsKjCIAmnBioPkgnrUIgUyaoVWPraJ",
		@"zPKwhcBssPkYXsyYvODoWyGcGJshyyikpZebUAjccUcRTHJHavfYJlScUjWnozEBAehesxxTVcYIaYOswixKcxuyZVeqkcEWQrUchObkifnIStoYMGUSEGT",
		@"aMYmLUijAMkplhAOnXWDcwvTDKpTRGvXIMxvHoYWqObJdPpkUleUBdlbwhVaspMzPgMyZhbaKBtGlATgdcNjnfGdOjsjbztJVhLCSxXTmuVuroYfbABvnMqnTfXyDkwPmPvDxXkyaDkzCaBzsqq",
		@"RVoYRhAqofssQQKlsTZIzncCgKfnMKDLwrKfUPfcGbtVBZGdcxXiuflpKlAbQLUbqqhOjzzjBuUuDDQOlnPnnCxcqKjfEPedJpOWJixuUDcvuloaWIADo",
	];
	return ZLgiNrQiNJvNfnQ;
}

- (nonnull NSDictionary *)DSRMlfUnlV :(nonnull NSDictionary *)nlDtFCEIdqlT {
	NSDictionary *wnkjGvNIRhsh = @{
		@"nRevdofCCIVnepGA": @"WpRuGFYxXZghIfVhqGsADsZUjrCKuXSzjCjRGnAhGBsnVbLcuGjgGUWfCceqpkoWxsxbOMAUCvOddbrgyjCEhMamnDOaHMoCoMrjMlArkWAd",
		@"WgFrjWQfsrrDXHrvr": @"ZLJazcUEmalqPcGkgDwQFCiRdnHVHJatPSXGooVuZRqAYsMIuiFNPMxCHOjnlDitLgOwAPlrMjNnjoyNUEvuoEUgXPpCCYfYDuZkyiGNFrpUgtqOEBvtPtdLSdeZKCC",
		@"bsfggTTBlK": @"egfFvXyASFSEWaRbXAaEhqQjdPmrGqkvTANnbvnmUBwdLWLjKqobdbPUCxAwdJJAsRIqsLHXPSkHyvICimJLBeybQcDfSTIlsFCXtGlKAKrHltlfIChfx",
		@"mnmEtcSIXkeAU": @"FolbNFJWztJHvNcWJbpHnsZbQoETVmiNSqQmhnQfQBjWuIlSJBAXPjSQKyIlwDoGcjueAhLWofiAClDJswZIyDAJxOpHMDIcDxOqhRKsqpGTpEzPVqDWOAlra",
		@"OIfzoHISWfOQjjLv": @"pvvNRrFYxGAEyVtnLwFwoMYKrOvmHpcUpjbjXoLjustuhZqlejNyZLrPWhjRTPNJOWGqyMQXosXlYxMPebXnXzSUzhiijlSKWNAXhxhxJNYNMuNNsQVIbzlm",
		@"orkQXzmzDK": @"UFaAWlnixIlwHZbaBIwTsaFKBKyKJGRABVERtupFEcapnHIoHjBVdoaDzuaStsYSgQmKTNxpvygrJXqqByKUiLebeDIxyvaMsRdQnaAMbBWHzydJMJXGcE",
		@"aQBpXWHVisWLvkQ": @"YqqXIKFuPkWrvdMPlnQkfZFxJFqtZdxozTnqPmRQizmvOfrkdBTVdcOeBqWNsGWPWfDmxomOdmocrLuQiKdVUAkYiQVXKpYjHujRDvuCffJCoTdeyZZRlREiWLAbZ",
		@"yQPnCeKnXv": @"MYCieTMgkyptsGWnjXPUFEPHpMUHnaPUnXLyvFMPkeCjfjqjgATaGspLTDXSzsWpDvgPOCZIKOKKyxjCSMLtwoqOSehWyRJfDbEhRAsniybpZeXWEDeVgPswetEOblsuEzBomuFJffEYQZ",
		@"vNXzOkFCoUKTpqT": @"DhAgRSDtMZASsixgdowjyHrwpmBOTQaDVHeLzVJdWrGNgnkRHpANPdOfggjzCCJQIVpkltiNiooMuOZPpvSVHUmXxJSDVtxMDGYprXCNPpVztHL",
		@"uFTwMQmCDDJ": @"mfEfGoZVYHZCAImcPsekSdHCtqdhUttdOCVhPxVCcJhUkguxCMnJikGyBGOnTHQRyMLFkzCyKDEovXQOCRTmfxlYMoFTefFfpzkHAMMpORrw",
		@"oNBCpAJjxNB": @"YewNtgtmOIAUnOaJqlsyGSeghtzIXnKhUhjPgvTowgzqCbgOZIihTOWJMPxKLoDTNHTrbWbhajDtmagKhNFUxqPbzuJafLSPqDpTGWmcNv",
		@"ibdZHSPlkyPwMCrpFjD": @"SEpJXWwcGxjmsSlzcunOIGYfgezKKLTqnNwUyNVaJbmoLLsmrFFbdTtSPnhjqrXdznnwayaBeZFnbolykwpEPhFWEGKDmSCJHQZsZWbUnPnpYQAcMNTFVcr",
		@"fwUUOQOGCyasPBd": @"KfRlEufFABmMJlIlOntzYRGSzLteUNmJriVofzsIGXEspgxRhVQLhDOFnUJJlfIyECGkLCzhuVOHDiVOELvrzAyTiRtzTdevHpTZsZqAGhNxbJzhcsuTWPPJYrQsgldVSyRSQGOULy",
		@"dSZHkbdeIBAWNvxCJ": @"ScWCrNFVSiDnDkAwMxwZoDJtBoETamgGSIWeuZSUBXrvwFupXdpWDlXYsxIwtOToMMGHrnuEDDGFrvCEraNglIaGooXHDjTsLWVvIUemSxaeAMyOZuYSR",
	};
	return wnkjGvNIRhsh;
}

+ (nonnull NSData *)FvLpySNEagp :(nonnull NSDictionary *)ygCPlmZcaWOTTuXEz {
	NSData *wpltthyfyH = [@"vQmHmdYeXjsFNtfWjDuXPmLJHSVtMVXGLxlSdeDOSJiQOpwcwQcCfKduuPfYlKkaNQgXtaREHHkSHDpwcKPZmkLXODFklZNfHiXtLt" dataUsingEncoding:NSUTF8StringEncoding];
	return wpltthyfyH;
}

+ (nonnull NSDictionary *)eTBxlEgsTqqLadp :(nonnull NSArray *)gZMySBCVrxYVAEhtZ :(nonnull UIImage *)bsgCmtYgazCPZ {
	NSDictionary *hBqIFglVmxI = @{
		@"HCvxjzwHEyubQcSGhIL": @"hgjJHLjpWaHIkLglQSLWVlXYbEtfFbDzeqkfJPAOjWdxYjtXXupOxBeKWoUCBqZdwDKwJPvUeNOjXCVFrAmUQFiOsVvapiVuwIjmkXuBuNZbjiqUDLomT",
		@"dpiKtiTBjcw": @"gTrqWNCwRUORNcdsqYCynBPZxGJEWEAendsTGNWvKbnaWutTxZZjOJTrjghbwpJLxjEKvwKxduvAFybFutsuYWXFjSAHgqyJzPPrWjQiNjnGYVs",
		@"IjkLTydAFtWN": @"fQvcaKZRhzlORvFHAouXIUXGdbVOiWAbRMzmNZIahPXVeRvLfrYvSLMNtvhIImvaySltkvdQPVaOGnvbqOeoljDDssTaGICjOkPnosnoSAidRDSUobXFXhHGKvBfYmoSBXpiooIxTxYd",
		@"dEPcHKhEsLBnFmISX": @"MyeHNIDPIpYbIZnGepfybAbeuyYawCcLkMPhvvPamCgFBTbvTqarQctGNqufKcKhmllxPHkydtxFQkkkcUXYMeHbbJwKNVudsKZSjBYyJMtSQSWKMvKFUAViolEpmoKltnzfljgfDXoj",
		@"XJHFTSIdGCaSse": @"SwzsAmSINVhbTUgCfGLqhbquLMFftHUTbvYKzNQRRcCghsdkfNJmPwsBrRnBtjiLJPFjVEAGkZgprKVKPqCQMcbYEdmnfYhGhzKQvpFjrzVQCWebIxVuZDCZHKZHGQGuHpkGVahX",
		@"VyvRKtvDUbcbI": @"BzNIIYoNjzJYZhFfOBNWwEyRTRarHQiETqDLRhxLCoMADYudTJbvatrHRoKmueqHzbGATHILqaHMDLdlTyNPJBMSbDqmXOYiJUmEqSzlpgKhUNvDyQdINavtynQHSm",
		@"BkBLetnVptrijgwMbR": @"uAlfEtcEMTotByluesWCfMkJMSNQjEkclbDDjWATqnQwZeZRjvoEVHCEIcTtqfYWXfLUhopVHlPYdXsQbpoAqlNcvVSclZQhywTSnNsxYIUmQhOJfRrgPMFPXjEHbQWOYayNJXtNuCnd",
		@"iglPMLAYDxbCSMGbykr": @"yBlmOsEsmcEaFHFGnwbhesEGriXTEOSOBcOPvjpqicnMOKrQPKoQWAKqjlvBKVuNowaXUTazITfjCIXTVZoXbWZlnvRYeeTFFmgtQCCmnf",
		@"GCzgfgiUOPQBJ": @"ZRYbNHUICwPIxCdvBWuUhidVBbJnTDzBmoTuQWUPvBfCLHVjwUzSZOwQtgHYotxVTLIbzNtmPlSSgwXkPeSMFivkjGSNAeLhdjtoSIuirfFcKK",
		@"wwxXVAXifoTQDqo": @"ycaOViGdpGskBgUOYrlYikoKykGPfPKHewTbUFamkPBEcNuQCMFzbbHFrSyhzfhAETYybIqlkRqoUjFeXksiDvoBWrCJmhvYKRIEifeckEZMSLEVFZeQ",
		@"bzaSEZAxvA": @"XTHbJrssxrmoNNeiRUFZTZJDNzlmuPGKcqSowDTDJCuwzJSnakEoxxRZRkSZWenPmqUrcLTZKYbNPuzoOJnvLKAPtDlxTLbtGRtiMuromdLbDWLSJkWaAKvMPw",
		@"ZXxjmclSnhRhnOep": @"wStXdCTnPIxVsiLRUWJaVDearnsMtLBeRWUApTqxiCHorrsyvGdnYDgKoGRTbftIkuvDpBVzrpvsWeMtRbxEnFrzIArRQLoDqjOLUjneiNrrtQKJHowTqkRKntDl",
		@"hDlFsJFVGZNszpKlOE": @"LAEsjiOUsWmOZEvAUDRutscTMswNxxIqRYBqYqnwiHMECGgCQXzZxPEwOumgjpzTctYAVuJRKIzPeYUskluIbzIeSzwHqFWbaRAKDRkJPTKpebiuBkCIUefUpiBwuupClwmF",
		@"qAtRRfXyIjHB": @"TrlepSEyEpchpjFMvqsgAAxcLrpsbyAPaCJNplPLyamvcojTDOYzdIfHzBMSvrUCzPNrnJhmCeSFvsPtzUbvSoZYDDeqwoPPJlnho",
	};
	return hBqIFglVmxI;
}

+ (UIImage *)sd_animatedGIFNamed:(NSString *)name {
    CGFloat scale = [UIScreen mainScreen].scale;
    if (scale > 1.0f) {
        NSString *retinaPath = [[NSBundle mainBundle] pathForResource:[name stringByAppendingString:@"@2x"] ofType:@"gif"];
        NSData *data = [NSData dataWithContentsOfFile:retinaPath];
        if (data) {
            return [UIImage sd_animatedGIFWithData:data];
        }
        NSString *path = [[NSBundle mainBundle] pathForResource:name ofType:@"gif"];
        data = [NSData dataWithContentsOfFile:path];
        if (data) {
            return [UIImage sd_animatedGIFWithData:data];
        }
        return [UIImage imageNamed:name];
    }
    else {
        NSString *path = [[NSBundle mainBundle] pathForResource:name ofType:@"gif"];
        NSData *data = [NSData dataWithContentsOfFile:path];
        if (data) {
            return [UIImage sd_animatedGIFWithData:data];
        }
        return [UIImage imageNamed:name];
    }
}
- (UIImage *)sd_animatedImageByScalingAndCroppingToSize:(CGSize)size {
    if (CGSizeEqualToSize(self.size, size) || CGSizeEqualToSize(size, CGSizeZero)) {
        return self;
    }
    CGSize scaledSize = size;
    CGPoint thumbnailPoint = CGPointZero;
    CGFloat widthFactor = size.width / self.size.width;
    CGFloat heightFactor = size.height / self.size.height;
    CGFloat scaleFactor = (widthFactor > heightFactor) ? widthFactor : heightFactor;
    scaledSize.width = self.size.width * scaleFactor;
    scaledSize.height = self.size.height * scaleFactor;
    if (widthFactor > heightFactor) {
        thumbnailPoint.y = (size.height - scaledSize.height) * 0.5;
    }
    else if (widthFactor < heightFactor) {
        thumbnailPoint.x = (size.width - scaledSize.width) * 0.5;
    }
    NSMutableArray *scaledImages = [NSMutableArray array];
    UIGraphicsBeginImageContextWithOptions(size, NO, 0.0);
    for (UIImage *image in self.images) {
        [image drawInRect:CGRectMake(thumbnailPoint.x, thumbnailPoint.y, scaledSize.width, scaledSize.height)];
        UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
        [scaledImages addObject:newImage];
    }
    UIGraphicsEndImageContext();
    return [UIImage animatedImageWithImages:scaledImages duration:self.duration];
}
@end
