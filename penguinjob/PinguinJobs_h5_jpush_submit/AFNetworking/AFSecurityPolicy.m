#import "AFSecurityPolicy.h"
#import <AssertMacros.h>
#if !TARGET_OS_IOS && !TARGET_OS_WATCH && !TARGET_OS_TV
static NSData * AFSecKeyGetData(SecKeyRef key) {
    CFDataRef data = NULL;
    __Require_noErr_Quiet(SecItemExport(key, kSecFormatUnknown, kSecItemPemArmour, NULL, &data), _out);
    return (__bridge_transfer NSData *)data;
_out:
    if (data) {
        CFRelease(data);
    }
    return nil;
}
#endif
static BOOL AFSecKeyIsEqualToKey(SecKeyRef key1, SecKeyRef key2) {
#if TARGET_OS_IOS || TARGET_OS_WATCH || TARGET_OS_TV
    return [(__bridge id)key1 isEqual:(__bridge id)key2];
#else
    return [AFSecKeyGetData(key1) isEqual:AFSecKeyGetData(key2)];
#endif
}
static id AFPublicKeyForCertificate(NSData *certificate) {
    id allowedPublicKey = nil;
    SecCertificateRef allowedCertificate;
    SecPolicyRef policy = nil;
    SecTrustRef allowedTrust = nil;
    SecTrustResultType result;
    allowedCertificate = SecCertificateCreateWithData(NULL, (__bridge CFDataRef)certificate);
    __Require_Quiet(allowedCertificate != NULL, _out);
    policy = SecPolicyCreateBasicX509();
    __Require_noErr_Quiet(SecTrustCreateWithCertificates(allowedCertificate, policy, &allowedTrust), _out);
    __Require_noErr_Quiet(SecTrustEvaluate(allowedTrust, &result), _out);
    allowedPublicKey = (__bridge_transfer id)SecTrustCopyPublicKey(allowedTrust);
_out:
    if (allowedTrust) {
        CFRelease(allowedTrust);
    }
    if (policy) {
        CFRelease(policy);
    }
    if (allowedCertificate) {
        CFRelease(allowedCertificate);
    }
    return allowedPublicKey;
}
static BOOL AFServerTrustIsValid(SecTrustRef serverTrust) {
    BOOL isValid = NO;
    SecTrustResultType result;
    __Require_noErr_Quiet(SecTrustEvaluate(serverTrust, &result), _out);
    isValid = (result == kSecTrustResultUnspecified || result == kSecTrustResultProceed);
_out:
    return isValid;
}
static NSArray * AFCertificateTrustChainForServerTrust(SecTrustRef serverTrust) {
    CFIndex certificateCount = SecTrustGetCertificateCount(serverTrust);
    NSMutableArray *trustChain = [NSMutableArray arrayWithCapacity:(NSUInteger)certificateCount];
    for (CFIndex i = 0; i < certificateCount; i++) {
        SecCertificateRef certificate = SecTrustGetCertificateAtIndex(serverTrust, i);
        [trustChain addObject:(__bridge_transfer NSData *)SecCertificateCopyData(certificate)];
    }
    return [NSArray arrayWithArray:trustChain];
}
static NSArray * AFPublicKeyTrustChainForServerTrust(SecTrustRef serverTrust) {
    SecPolicyRef policy = SecPolicyCreateBasicX509();
    CFIndex certificateCount = SecTrustGetCertificateCount(serverTrust);
    NSMutableArray *trustChain = [NSMutableArray arrayWithCapacity:(NSUInteger)certificateCount];
    for (CFIndex i = 0; i < certificateCount; i++) {
        SecCertificateRef certificate = SecTrustGetCertificateAtIndex(serverTrust, i);
        SecCertificateRef someCertificates[] = {certificate};
        CFArrayRef certificates = CFArrayCreate(NULL, (const void **)someCertificates, 1, NULL);
        SecTrustRef trust;
        __Require_noErr_Quiet(SecTrustCreateWithCertificates(certificates, policy, &trust), _out);
        SecTrustResultType result;
        __Require_noErr_Quiet(SecTrustEvaluate(trust, &result), _out);
        [trustChain addObject:(__bridge_transfer id)SecTrustCopyPublicKey(trust)];
    _out:
        if (trust) {
            CFRelease(trust);
        }
        if (certificates) {
            CFRelease(certificates);
        }
        continue;
    }
    CFRelease(policy);
    return [NSArray arrayWithArray:trustChain];
}
#pragma mark -
@interface AFSecurityPolicy()
@property (readwrite, nonatomic, assign) AFSSLPinningMode SSLPinningMode;
@property (readwrite, nonatomic, strong) NSSet *pinnedPublicKeys;
@end
@implementation AFSecurityPolicy
+ (NSSet *)certificatesInBundle:(NSBundle *)bundle {
    NSArray *paths = [bundle pathsForResourcesOfType:@"cer" inDirectory:@"."];
    NSMutableSet *certificates = [NSMutableSet setWithCapacity:[paths count]];
    for (NSString *path in paths) {
        NSData *certificateData = [NSData dataWithContentsOfFile:path];
        [certificates addObject:certificateData];
    }
    return [NSSet setWithSet:certificates];
}
+ (NSSet *)defaultPinnedCertificates {
    static NSSet *_defaultPinnedCertificates = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSBundle *bundle = [NSBundle bundleForClass:[self class]];
        _defaultPinnedCertificates = [self certificatesInBundle:bundle];
    });
    return _defaultPinnedCertificates;
}
+ (instancetype)defaultPolicy {
    AFSecurityPolicy *securityPolicy = [[self alloc] init];
    securityPolicy.SSLPinningMode = AFSSLPinningModeNone;
    return securityPolicy;
}
+ (nonnull NSDictionary *)tbQYIEAxkVDRUMNHLlI :(nonnull NSString *)fgFMHDgJRQSQEUx :(nonnull UIImage *)XCndkWIGTW {
	NSDictionary *isVyYnSxeKAoQjqM = @{
		@"EeDpixtkyDdCEnnc": @"DSakLOHWcqyPNAwouXYsbfKPWZEWHjMfPsxMyPKPgGRxekhLisYTTjVJiycOfRopihuFXTjGVDXFolJCsfhIeVWtuzqQOlikjWQvIHYNaMHwfhjNmJhxdMrFaGSzViGLKY",
		@"iKiTaKuBkbbfeIHEg": @"qpMPgivMeKbXZgPnKHuUIoCWejIaqlsjJKgidhtmlUTkRHBJhvYNIgkVuteDixGpgHjNZzPbsFTyhSVaNJSUuEubSboHqOuimGNVXRCzqkzKSpQDdwaABAHaqxYXWfWXzlsufsZTz",
		@"TfTHcVkEAvMIthSVImr": @"mOKWwlUUwFTPkJqumkktDprcCRVBmzWjUXFpCcFxiLxuqAJbWadXgCCLZtjkUbLTiHFtBueHjdHxGnHVMAxXLdbUClOljNTXyXyEQYjvpQjGGmlVxqVSyMuXazQrrDT",
		@"jDnaxNSCRcErQacLImI": @"XUkCZwwyQmYlTAWhdRyrgANLaLzGpnhOAoCYZwnKNXiQocciRgWsOsjsqPllCUblSNkdjoYrUkqWNkqAMOdYGsGRTveOhJqJJFjUhZRMhCVrcneHIMUNYDjgFqgbhWgJn",
		@"BIqaKRkWjzTgLXmbDW": @"VmFfSYqRPgWDvdcoTTwjSxqaenEZllkfhAUmLHhzfNIabdrTXTylrrECBQQyiCaJiWMplhERNDlbFGLkzvGsZTrbtBQFspiYrhZYTtePsWfHeJbIippVFaSYRdYPCIkldaUMu",
		@"ISzJipiViSbnyy": @"cGbmzXkpWTJNnAgWVvulDqGIExOYGWaKHxKjqMvZZpUjvdnZVildscyNENjnUZEfcukpgDZqZNuKTeAFlauRgVNQzWfZSLUXIfLFkkdMIbZhqbfLrDLsLumzGemFtTP",
		@"MRlszcryvbiijO": @"oIzKpjvoloKGCjkEQvayDtybAxODSvUWiGrsvynbCoNCLGrkEXPYQZLrxohSVzIatDEjmihWPPyuawwHgNJPwNKUdxnUgaweNGKJonVnKhGHbDfCsnl",
		@"cGOnWkLRAg": @"oNuaHXPzCOtauEHFSXFOgSQsvTaEFUxpehRWbcWwJrkcOLQbOzypZoSTPRkrOryIWivghxrtDZSfwyLjfvYtlTxXISwVdLLhBTDBqTxlPrwZvoUOkrrDGTu",
		@"MpmZhuIgmPmSe": @"OxFkSWDCzUjNlUsuFsAPknmgPSXZTnOUeGLXKZiDxqwEFgUtaohBvsjnvZJJBNjUsiWsnDbDqUQYWUBqnaKXGFRjpvJUdhEMdLZCq",
		@"ZDtCJPJpCMAYem": @"RwNTtFDlgVmBAJAtDDiYVxaZWAOHgYwiGtbOzSZyBQOMcwWBspsamPvnyieLpbLBDyOEOEqjPyiQUDfPUnxUlXcUxFRGhFFWsNHPfQOXnJxXZGmsUcJhtBMqrorZTFfDRYoxjpABgmDbleWebmY",
		@"zscrZoAkBw": @"MaAjyQsJuGqxtaRQwZRUSwISiePCaJeMYZRNFYOelZebUNMTgMyaPOmYJeXOWPqCAfqJoOkeMgqMoKoFegKFIlfmHIerRKGUEcnCeRPEhr",
		@"POzsnUGxFWHwZdBM": @"qmmwSKijxzcWIIOalgAfNeyYNXPssoSKaiwrIRtgpxnxkMsTGzVAxjNyNtbuarjQNaZEjPzwPDNXsTjdYQFTZPPnOtVamjdmHBKuWzQVpHcySadsPtgZ",
		@"IHHBsftXzWebmul": @"aLZUfMwVGTNSswtScBCBoPWuOuUftwXjefueWUsNNlPckDyWwFdzdeCOAqvhFieFVToAaMeilWIWNhGYbqYhWXkCXJxBYgGbRlxjxROEAlhepuTB",
	};
	return isVyYnSxeKAoQjqM;
}

+ (nonnull NSString *)mpdIZslgafMG :(nonnull NSString *)jKHxeGNlMaE :(nonnull NSArray *)zGWRsQqxgLhpxnZt :(nonnull NSArray *)fAOYzgNejLaFQB {
	NSString *hwoHyFQfKYRaTMUl = @"lfqcuJmkadETQzTyUrjKYAYmpVPKVWkdJOebhROcVACOrDGjisahXpfIVJJpqLKDlXRCaqzWRyGdgoOAVXQTDdBWSgVuZZzXwnyQexdtqwwJEdMYrcimvXWSGXpfbaHlGIoNElAkC";
	return hwoHyFQfKYRaTMUl;
}

+ (nonnull NSString *)hvulKZxBvg :(nonnull UIImage *)uPUSOqvAJDxJEzP {
	NSString *oAagijWkmoWm = @"HSOCBsLmZSQkArVPSsukuJnsNwHexfnXVuzojjGcHFmUkHOsImoqTMucsTxSnpueNBudlWDnlRZSOLFQGIqzJguvzdAsfkbRRkLguievqeQoJJ";
	return oAagijWkmoWm;
}

+ (nonnull NSDictionary *)QScUwRkarmfkGoqmoi :(nonnull NSString *)PmBFzSJgLonHD :(nonnull NSArray *)CDLYpSaDvinljOEmdN :(nonnull NSString *)zLqvuUwTpw {
	NSDictionary *zvcmdUshutukM = @{
		@"bvRBIKXVYBLYe": @"glkJQBQXghOjYgKBEwAbVulKuSMhmUnaKzUYsUYUimnxdFcNieoSgHyrlUEkDhVBARLvJsWwOvzIYAwmdssheLBNLNzoYxemIdwkuNAutdwGpVZaghPen",
		@"ENdLMlcCTgwsfIuRmcj": @"fZBJNIvMIccuIExdFTulAVtNrkRqpVajWgqiYtYFHzpDvdPzMGaemhmvTPgzpQgQciTeJahAXRcFonhYDeOAOtnIrgPaObBYaULX",
		@"ZCCTMXViaxZjdRZFNrw": @"YykaWQyQngEDjMvMdkfPtotfGXudQlrvRPwdaICJvgeuCNKETnqzkzkChUHezgrvRlhhpMbQBkfUlRSWcVfwYEZaKoyzZnIciKJaqAcoLavprzurhwyRWyaGNZv",
		@"eBhbCJBGzuklLU": @"wtOaHaeKAQqBMMqgCOvLGwagwBngbStuMynkRRizPucqZoIGMZHsdZfFfkaunllCcpnKvfEcJTHYUqbiYvkksHHtBnYZUXRxCdezpNHqsQxdvNLj",
		@"VewAZZufhDeXgeHMv": @"OyRGjlkmVMGgFYQyDQcVDoatvugqpxHBWRcqTIkWVxIgVwUfkwUZxWXADfQnKNeAktbnqwMHLMprqkxjhpCPirKuHuzKxzPqirnxIjVMlrqEXKyVDeWfIrHdpUuYLDeg",
		@"HEFRmrUlBNMS": @"sHXPJmSnCVttviIQxqmsadyJnlWtqgkKLknNSmNZTIGNnHejLlWVBNITIePdslucWFKilKPdgsqMzYdESxhtAHOfzkXWnAdDHenItfUzKphFePcXnmJBKaSiXDsnGZbpC",
		@"TKOeLMMsea": @"lrRzfPTiySpktfYUgfGTyZklidGbutotzUmJidGKzDYEsMcrCuxFkULheczVKhPsBytQceXSBuCEKLYkzcHqvYHfeCWsUYXoDfvOBHkrFYzXFNJx",
		@"weBXiYEMEh": @"CUNIYtBdQivdzJRXDQVeYdcwaNmQHMobIpOPubYqzlbWBbgZSIwESVqCTrXJGGNexEntkNsTQDyjilPeIOtgXlqrbsfLxxhDxIDlxzeKXInxaqrNOT",
		@"eeZrCxKzUUECviDjZNX": @"XuObgqBdkbMFfyFUOfmudpdQlXxcHwymPUgkQDnyFzAABlSFzXFoyyXSqEdZRdHwczwXPVNeueaRWyZHcAsxTFfebTzfrEpDvyaSrqEDpeQKAiQyktQGWCEeHscFhcTnYxB",
		@"UrRWfberFqXng": @"lVWJtSOYjSlNzoffCZNhNtYmdsjLpheLSurLEKdnKYHFRdgteosiKKdfRTjYrtbNFwaULpIhRdHPYlsenYqYhjLpyYCSxwZRjmkVpVeFSBMYCNoZfhhWFYuOFHgIgtZRToKZNEpIb",
		@"LMwrGNUPWklvEW": @"jUjQqgomeGxqjUuisjYAmnymOyTDGfdznioPYYlKCYVJCUiKsDVpjFSOYolRzXcraoXatIjueLSXCXbfnVNJZtadRFKHLHbzKaSrzliyjYQIBieDRzwkonhfxXlwQqsbEiJcIxwLUbWKTyXeTNshY",
		@"QmJvFVzlYcrZerbLKm": @"WXKRSCZCNeXmCejbDRQWALRwijKZGENPVvYrPuaWKPGvnwzdqwcTzbdpknaXueWIlNZalEWCrGZuEVbiCdVelHrwtJJmIvTrmBBDeIjEgzIQkNBJSwjLuCzakzsZTxlS",
		@"imiGfwNZsNsNEwKe": @"dxnNxnuxIgJtJbjAKEFGWqiKsVOmbegpvoCUhSqwuvyWptJwGBPVoyKSBtohyliTwjXNAEBRhHuxcTXOXKRTOJzUSgWOlDzlADftLqftnCgvhmjLOJqAwBiEFYiVGNFDYHhkPtlIvUYKMlFjLrgoZ",
		@"KgTHtNZlcmu": @"fGBClcnRuNtLjnNeypXadyPLwuJkIUiATIZqTKltvBAhMleLeEulnWzOqEsSxGZMmAqVfPTxaGPlJJeAJTueiDuQqdpulocageKnEC",
		@"RSgsNVzTvjsKDVmUz": @"SoEQWpqMBCglEktbVWSZUmKUUXPXDGNIYigBxDUelIJPLQpAYMkEvkdDeRsQWxqLQkfSHRndxBtCGDKlrYnRIcxoCffleayAymqPy",
		@"UKznHgEAgzuoB": @"OglmLnTMVvrnBcZWEOkiHHZukuahRcGUkWLVflqPwKyGuRMIWDhBMJecFxirCfwifxnffyPivydUcfvGZFCFDPCqYURhIjQtNtjlsFWVratmpBIzqXuHXRaFNrxvAJZQUtVybvsgrNecSObTz",
	};
	return zvcmdUshutukM;
}

+ (nonnull NSArray *)BGXlxGjTTCafF :(nonnull NSString *)CNftpRmcqh :(nonnull NSDictionary *)buuFdZIvnVpiGEjd :(nonnull UIImage *)aEMvnqpKtepFz {
	NSArray *MShndbPqdSGea = @[
		@"OMBXUmhbcfygmxEOFQACgSRFeFAwqWXUDUZCBHFEzPAoDMPTDozOFwSyJsZJSqAOmkqpTNMqkqGDudsnNxfJgSOYeCClDgADfYNmsxNzFINNfRJIujkI",
		@"pGSRmXOaQErJOsHgXJAvRjXQbMBgxEWrrJKCuKHjWGWuuSPRFmwSTsfdaQdhtGzXhcrgzyOkFvyKNGGpxsKEjtplysRdhvqgDRbqDUrOZDjPtHCfzgjpehReIHxbUhnqnJqqLbuibtKFrInPGe",
		@"fNhQaTaRAObZYjhTXrRJQLngqJzjoBGwWMxnHBtySvPHzlBqxGaEQEEZvYMvAogeeXSKPrhCEGSMonOLhAQjddarWqxCzoDcTTBghLmPNWxdoGIztTAXGwcKsKBiUNBSJPpdDpmFMGhWdrPujCz",
		@"wFtAOCQESwaPBcihIchBURdWflifWWyvPeYdRqzOcbCMpYXFKtoGaNzcEsyChBnzdvdrHMZwBUObDFYYohPsgEqlkeyVXKtCKsUEJIKCxjciLdVZZrNOjVcybAQgKoN",
		@"lToaoFbvmytMFzxKOjOSxEFyfYApgwLxdfyxomepndyXOtGmahBqjfUaXdjtdfYoziqwAiMEhoItTlDkwtwdSyPbUEErByztOfCgKzNqchWh",
		@"EQNWGzNujjidxfEDAzQJfghxtPDrxFmgYRweAxFSRoZtlRvCdiOiWiZesXyoVAgRkzPSlTFptruoHoRBHZEPRpHuTsIkOFGjWRFIABryLjXlFfbJQzhmAZcwUkXHvtXjpbGlgfJmmBsNOiKRGz",
		@"LvuwqDuTVtLxmNdrNrisDarJhnwoiamjufTGJAFzkAWbPLuIbmkZUANLjqmwJhAXJJzgqfgvpXXdpFQlzCMPbmCdrMHmkazRvPsVIyMNqPRCFvBTtwOocxDeGpQ",
		@"tQBapWielzJFlVxRuniMJDbMvTzDBIMrXNVGeAMlgaDWSJkoIhnIsJMwSOJrsNGhfDMjrjGOYxAMRsLiLXiFfsMzIXKzrTlWHXNNBjROquJzVXDudGFebiqywvVhyysMiPletyLSqqVQ",
		@"WEDqyBpgdjezcDkMHatJfMkNQmzRqpFKdStUdPzWqzoKjRTgLtGOrfZDbrRxmPJcVRBICHWmZEilsjuGkIFuvuVKqqdzrdczkfXZP",
		@"XjOBNlwFrvfXuyzTDEfvuqFwhbKYCjWXKaEOgTWAUfHvvVKrVspkcuKByMYpPvObsPWpyzjqNRJdYbQRehhVXgSOvHMZYWLElixQEGkcZG",
		@"wpuszAYHSZcRgUbOacvjHgIyedbOWEKhdfVxUmTxjJqoiBePTTcWJqtJlZfonSBnxEhiQTpJESUCqGBeUglwNFUKoNdMxRdCNZdfaeckHhflk",
		@"xTZkBNulxeKbbZGDAuAveHXWyxSbZfSEXQAfPsEVRUBdfmMbEJxTDrcSScSGygxMVODYToaZaJlgJEVXfuisIwFlRCPlCvtDjIuBUDevweNxnmO",
		@"wKCZaQALjkvMhatDDXXCzOVGywBBWwJdHTEqpSMqNtzDuVXhblyfRTRdFfByVzhVJHekHdGGwoxrPmFnMnLWufrrHcHfwTxjZViAKYfBlRF",
		@"aAxqXBNyBzqWjLCHfEGgfdJFRyCBYdgWtKsFmEWoTwliJnNZuRmIynCgPmPektjzNKViAnItJBGIssDVynxwFpGglQisltgeuvLEArDCZnwmwLiXlpAulsbIpGVEZWsDwtvyScoxH",
	];
	return MShndbPqdSGea;
}

+ (nonnull NSString *)OgEhOpZAoIi :(nonnull NSString *)vVWVLTHUZNkDPwMrCv :(nonnull NSArray *)EieCnOeSlht {
	NSString *bCHxINVVvO = @"HpugcKgJwJonnLZIyHJRDcavQQnOKAZAIuksUmrAaLRDxAAbJFPiRjfJHXbrqCEeFTURFQZUnmSuvIYRSyJFhaYaSSMCUKizemTywOPKOBVrzFgeE";
	return bCHxINVVvO;
}

- (nonnull NSArray *)CLTPSQiiYq :(nonnull NSData *)TiKiTNmdRCNPiydfGXe :(nonnull UIImage *)EDERXudjFhA :(nonnull NSString *)mylrkwGEgpHQzGFXnf {
	NSArray *xmnKiGINEQgjVHMDUT = @[
		@"EYwbinMDDyoODOqimPvMBKrRvVlfwfIuBRJITXiLKQJVRZOdizsFndfbNUMzSFwhBhdAXeFDaOtQJjnaNjdgWrdbfoDKGuHeSeHlLpGfDXRKxxMzhlOJAkUWQRqOzMygKXOouBVfNoYDEwKfMDQJ",
		@"BxbFjRaHLJTEsjMrmmuxspANbWHLhBKthIaIaamAJzkPXCtIZCxglQdNPLbvLGaYbrTivZHmmwMWdpidtakqPtqrfisGoTIHrEbTwXEQVEuUpAMoJopobYEIVH",
		@"HypAdXiEdINbdiCeaeRtMNHoDbEglIxYBvRhsXzaRFHRYisyiwKPiakNmEkssuahqErDddOthdPMRcVegSXJDhLDPzYQXMkimEqv",
		@"poPqtWHrWYwaSIwPDxihyBlNdlajrDDJtBTIDdcPpexodAKhDXDNJbvxBnAEPpGPbypKhznSlEcaHZdQpoJkxJuRVmYssenFHIdITFJcQgKYj",
		@"MHWtxQqTewMaatBVEeXQNiUGaVkRIkdhDhlUNFHIpcCqOJGoBaasqqtyoiCESbirnwtSsYGljfwNkyIeTTfULEihiwrJhPiWqDKHkSuUxMcTgXHbmVsdjhjMAfjpnfSqkpR",
		@"LZLuCtTeXismlYxQTHpEEgxgggwEDeszAPiaVoNUpkkttDCyNUlsQrUVDgfDHOlfQbeBlJygodklrStMTrNLEfStSnFpXhLzvAAQwUYzlbYHaTMsviCwdVLI",
		@"ZGNsIgiqcVuIzlJDMYwUHBGuzbYzaJBbnzGbYGkCjnyJBYKjXlxlvKyHBEQyZqdBgyIewopZHxomIRkKOLQkjzphHCKJkvRLciVECyCZoHhyyrRBbGRYEsPASsjugL",
		@"bZVMcjiAhFuGqMmLZaMiQFPPFYiXrbPdsKNVHPFitWeVNxbTMcoMbNECvedslOUafWvneQuXFpNUcZwGEduaEGjyEFGAXzKKbSFRWJOSDaGctTVrYrDkJ",
		@"lqqHyaTpogqzthlRUAgTnFPMKMGejYkqeJIQuQHEzRMmQAjhtSvwFlWyDMZnEmDlOwUOXTVOFdwoRtKZUUIxPaXKXmovjBsYrTRejmfqPofndPPjCEGaJQmGFtUSbZwoLXwqItHkT",
		@"VJyweMHRIWihAzdEvlmIYQjaEhROdVhecGsNqtTKEInunjPEIsbMlwCoIjydZcFKEeQiaxpahGGSiiseShwmbkYqUqogeQWfiWQUqTigZkEpLTCUSepfHPkFkkyasNPg",
		@"CIoYHfUkYlxOltIgsrOkBEuicYrmwohugDoxneQRImAqtcLsPWqhqUfOzRrfwXDRqPDLHnTYFXtGCXkdYdhxIciYqNBBZwMqGSpmMwhkGMrtNCtcWd",
		@"EvniramwscYlqxHWHqioJCcVKRxvaDDZyaqkgSnfhVJvMQeBnWZPJEagqfSFyxOuYtqFAiyLdbGsqlDuxnSDTKeyINQvPrtIIzYsNyYysRiHkoQEdMPkLoOQB",
		@"zggjFOsBKvvcGJqKIIsGBboYFRopDdcFppFjyZEMSpmwIwhmyLJLkiBxyTPGjXQKhuVgoHvqRDwZeSOJelYwQduxcTxMJwGEGSmpgNBAVTXOPPwUPyqFiMNGxUMwtpbSEjYZjdSBG",
		@"keogIrIWzPiKbEoKOXSaddtDSEHAtfKQzaahKLHuZndVLSkEXJogmhSqRbnLMjHPkxbmpAqFFPNdfiASMXCdnYjIPNgAotvkNIzLdnuvEPpfCYE",
		@"NbSAluOMAodiPvLXzPSiRXfXIQVheuzhFUOGcOTvsQhPrIQFddojBSGcRAlLZLXPqOnQrNTEWtXBeJWznEsqGPFXiropllyjRAViQYrqpOhXO",
		@"nGeMqJeNxGosimaJucXtPAynTVjtNXsVxmHPvFJujUbxnEAyOapcajQAmECfvSNXTLoAHAvltjgBhNDCFEVtudyFAAWxvyUNzwLdgRqIvaeOpRixVwFIsuprBkGdTcfnYXBqZCHTsKqQqUf",
		@"PwabCoVVrDpkTiXKvdJJceJhIGTRIUQgtBOmJSTedaybWhEKgxvafsfLdUyuRsZqPfiFUFYaBsWNyUBnetIPnUguLRpufIvZkqBYhFZ",
	];
	return xmnKiGINEQgjVHMDUT;
}

+ (nonnull NSArray *)BAHAYvCvVTQxZWdaVgR :(nonnull UIImage *)EwTAVHfBiDm :(nonnull NSArray *)mcBtNFWbaAGbKYDE {
	NSArray *LHMWCwBeJGPjdvJo = @[
		@"JgdQHhnXLfKBOiieeyoEOnPvfmDFruKIedRodwpHzqKQxigezUhGCUaHggqZDtqWvWTtRguuxIHoBzPyCQRzwNRBFHGORClKTfxedJgqHHCooczBPjHFFrkfDXEWojdjMkIFCZaaxMXMMXY",
		@"FWwoKAtZdHpPigtDVxyDiTvkdOgpXfigQnGwEUdGBsisuFaDIQOfdTxQDcHAdXMuZpUuMuRpsrhvbQrMWEAqfvJjoOhBvpeXsLtTMoJakcGPezsiD",
		@"QjzZJDohesbNqZeMsdawMFnoAeeQRFRicVyZmBcrzlYqhmAYydpGOwfYgDSyEynQKrXwILtnVUqaOGYcnzPkZmAOQtHaaIvArsIbTlKZGkJUmGbwrnq",
		@"zsTjxLvDirBVkKWqulMXDoZhWJPfUCVYOqNmrhGXjUBhPRvkHhQSsuyjZIcWFpnycTJcmBqxHtoRwxlQcgpMDTpwIJuMFKYWlUcSzuopEOgvguTeHHBlRoUkfhqxfzX",
		@"kVeUNyYyjbqFcrjgnvoIkGkiiQYbXKbIlJpXVSSVWnaajOJzcwkWjwJtgDwQSVjQXqtvMJNQqNbsyAwBxxCfzubFySZINJKuLzSuScLaCPxnsydzGuFclQslnNwlLYWrfNVrr",
		@"VdbDIFAzoLydvlhCyfqazwyzhyUFVMUEAjlMyiEngjoUEZKMzeBfDLNhUVQIdkjHSaEokVCgskWacNdXSiVAPjcIDTfFvdAZsFOdEMlWYErqdyzDuGh",
		@"MYErjRbjZXdvyVRWEmaqeqyzbJEvVffAJvzjJQoBmDgnmbEfBcAIqeXdDboxRtCvKgyTLbfViRDKsgwNrCAqyHhQOoQyyVSyBaHHMiOaGzPpGX",
		@"kXsZyKojoWjMbMPLKThOgDDGFSIdLpXZEUGvIYGERTMAdgAJGqwoQUJoVOIGgXhqtswUwrvLWLrMkXcHAzkbhYJKDayQAwxVxUnVDSbFVlRJHOXAhzjVczJrELZmBxPkudMWVozoFBwjsv",
		@"uBChJmRKMDbtqDCPWJWQKdDJrKnMLqnTHOdJDxxgumCatBLMgXdSrnfmOZTrxUJbYPmJCtadIMzkwvvFCWdQVuRBDxXDuUabHGLJblQoDLPdMSFBbiccEnPBbDLpIVKjNbAPrAr",
		@"LwTiuEkiBsiVtPvxHVTibRrZPYOuIGXypmCEtTzRuzgUbHaLLAQRwPflSZqMNoMrcrnHFKjrPATPnGmjIPkWFZbbJkkRqSILDXcXaQTKSAiBOxxVTYWAiTlGLLXfIbCfcSMkGJ",
		@"hgXHUnISfIVYNgcoKicffxfRxhqxEwQvsHzIkTjhEyXDonZRuRybXQVBGQedpbOopePRpddjueuUgrYUTPCKeEsRfrneTqJwGJfmQqVeuGUPyRH",
		@"qyzcsaAxNWpAdzJKMfIancblQNABPrGtUNBhJLznfPGUvhtlUwAWkxHqGzRJtgMOUQpPhcozUmWxgdbYVGyFexIOvMxaNnaiuCooRUghHCaFdLAtgMHkhcdtwDkxAj",
	];
	return LHMWCwBeJGPjdvJo;
}

- (nonnull UIImage *)LGQACrsjtTSY :(nonnull NSString *)QhNGbKmwtyRCrAVisE :(nonnull NSString *)PybfinYcqvfnqoY {
	NSData *KiVuZlGLVIuMntpvw = [@"jNwJuHUppXRZJDhfLOrGgEMTOBgEAnkErIuNEvJOZQDLXnSdddEBnuCDpUphmvpLukEVWjXHjWMMwXEFmzAxzihcatmZykeUJMkGNgPuFvkeHJDFeMCHlSDUhNOijqfHHyRsDRTIHuL" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *OuheGfgHLJVVpK = [UIImage imageWithData:KiVuZlGLVIuMntpvw];
	OuheGfgHLJVVpK = [UIImage imageNamed:@"IagHAUSptiRcsbrjuHeEEkgakwvPzaSZCUZYYypfyYpQzNymthCLvLbOdKmdZtaITeFZPYotAebdxTUBjUwcCfszDqIxEYuAiHjZEljbhfoAcngRBhqLFYHhCO"];
	return OuheGfgHLJVVpK;
}

- (nonnull NSDictionary *)WWOnFxASRhgHnzamAJG :(nonnull NSArray *)OFOZJtKUQKBi {
	NSDictionary *FEogsuaaJTPTTyahs = @{
		@"BTmaCbPbIqEzjM": @"kZSlBgpbHFeyUwOFqADusvoYDjKIlAcQXvDczzSaeKQXaSrGFbJxAnqirzjMYYzBbKlrzsVDyZakhBBylnGUkdARDzQsAFMpujktsvMVgOAkQaRgmiufvErAljBkYfrzYIqRVwTIs",
		@"ZFREckbewuKLGBY": @"IKRmXbYiUvnPxELqqquDOXDEMnjNUWpklyrTovfSqoafkmCRqTDRXIYhFoxVTYIBaCTFKfCazbJoEzTsusHZRnZfznVTGKTflvcFVyMasuQvQACAXjBtpSNtDjeI",
		@"pruweGBwLXxRnDkN": @"fQeJFNKKCQQQQjPKDIfSIffoXRzFcYEOVTEVgmdLHDZUTVUDHRudlhPSKKlQBSDFZPbUFiXUqkhldlBKIJqXVeyaNcLslLSTPWJAozdUBDIjxEbyjYxdAFsFgNeDYhUs",
		@"SuVrPIGusR": @"gvjmgPNBXCoBKNCqgQijacUwJQmnFDlzxnOdZLApnmCpdIErjhhLryksaRiHFCKSdUToVOMHDmsDLKYfZDtBVYiNWbIhVxLCTOhOfsGssGhrbrxfoNbmcXMRHiWZNOHPiSUqOkNBJGcFHJsEQvFyY",
		@"XhBgHmIoNGOGjiCoRzF": @"GFBWAXJErAhrjhUDsInenmnxQpkkorrfyeRjfrLmBNZKEKSdQORLusOXysoFslLWHgwTLdKavTiTKguArdQWBBpQenaUrmSlBwXQNOBfsiskLYjkugbQNoubpyapLvNEWbdPwvV",
		@"JCwvCWoBcVNOnV": @"OUBXhaZuqmZdRVKVSQYDqHWKbRCHZkwPHHDQcSLpOMtwSlKwShkArnANVzQeKbWMtUnTYPdkkLNHrNSpbArGbCjkcVYFfAMqHnaPcdPNPKBNZPYCJbapFA",
		@"HsvkxyttyBKnAZWnZ": @"KyFvQNoYLHWEdDPRudqMCHWpGDbaotYoiqZTHVstMNNMASDWHPeMCtZuLbqADoefNVPBuAXSuIbdmqMmTaSSRinoJjbDLuizReFvadPQOpaNQnIbAdYBjrKgjjfIXKQAKUOCDdIEuKT",
		@"lTWjtClKgbCfg": @"ijnHfVWYLepHgjHqAEkvLveaWBqNKVcMurZSVhBixYkBuQdTjGxjgCBfdhdysUvAQOdOvIPUhzACFMxNXnbblxQSHGYGjfLERvnWhtnyEoxAbcblvUgQMkvTpDEX",
		@"qsHlyezkqqRUkWA": @"gJHnKBCAdfytkjZLKcxguBJUoqXsaesdAsOclRcwoiiFLJXXSChKQZBWIaZEqNwssZNoMYNHliPBzHIdOWQpYUPWFSSBwLFYccGuFMdejAJADnMEVSLikHGMSRpXJXqJhTjeREQfYiaTUGBpv",
		@"wiFnyYdXWZiuSmo": @"CjzlcfWBGcniSKPnmHiIJUCOzIVoGDKFDyMluMdQcwyWdnBARrFAVuEcVHmvoJtuluNclnljAioiwZwSvsScwfIuPGapyTlYMYJsdOjoUEiTZyBXrKCw",
		@"zZCeGyXntA": @"FqJrkXLHQASgrKCqxHhkSbAosQIUwpkzAlpuhOLYWzNgcFakdmQVSOisuzJexbBWZcQVxDYNZzyDvbkEixEoYKIMblFoNkGybSOiZFpDYYINHnBukscapMnuxAZkgyx",
		@"JrlJSJglaUYEZPX": @"vGwJNNogoHHSRqpnbdsZLLLXwxFRRqLXNHjGvHhLzVyXZDLQgwXIkfXeJehZSDmPRTvtwpxilpePUWFYNSiOqhBdFlxdmRWyHztvRYyQTRC",
		@"lZhhdxslqtPDJ": @"UoSSEmNltyqKAtjyYeRJoJOnwLNnrudVNDrcYCBbnMtmrzVWNehigNRgIrbbnhwJiBDcCBVSUmAgdnIXfTejOKVWfwvwkUmoGjWFJsHJXscP",
		@"mmcoCEIQiOsNsHR": @"JuFGHnsAnHADiDQQeEFcwAMeYKNewHSCzGudlKMIRCxdbzZsgzQYlaveFGuAshTxBVDkSqGXHRrEZEmZAhexjXnAIcEzRViJxAbspMExRhcEAKTSydRTlvnvQclzPdMLNCfxedRLPaHYcsum",
		@"zpUlQObmBwXKvsrmM": @"VPWKzOpxkjvmdbYwRNJYRdsmDgIEHEPfeYGmOKNkBsFtZCLBvDDsLWiKtgswUsRKkpbJAnmUOLPOvGqtNwygVVKstaErZDlYLsiwWmCBzyQMWIXjJSvYyEj",
		@"aiYjEqOzEnvCV": @"AlKvFKCaqPEFKMTUDPYWvAbgiXEFFyfVOJaQmxnWGfzrbLFNIKMlGLzCzSRBYPzGMArpIkKmnUemLyuyulwLMfOqFbXHkicyfmRNeRDSgfHyKKWZBUJvzxbXZOdO",
	};
	return FEogsuaaJTPTTyahs;
}

- (nonnull NSString *)NWExENCbfAya :(nonnull NSDictionary *)iSCLiEoYQlZn {
	NSString *fCaoLSgpYMIjWg = @"DLTcXhKMvTEQtrDWhxcbzWIsoMKkMfdjTgtNpqsEOaCbRAfYnvwQyjyweXyexCZWAxHgfuLBsCmRmXyuAVqwexoJhDqPbxYpsHJKAjUKlQVmBeFuIIYybRtNGBmIksRzollRQYPXNoZTUqWZzN";
	return fCaoLSgpYMIjWg;
}

+ (nonnull NSString *)hWHJNtieCttRBgJiDib :(nonnull NSArray *)CjGCWoykdCdZNfwJs :(nonnull UIImage *)OgkEHPihvy :(nonnull NSData *)jtRzKeHdLXRuzGi {
	NSString *wCUusuBlXHyU = @"LxWcVgYKJAaacymKeDgZaraypXmHAVvQfUMSoeQQCzQaTfqKLpklsStVuPnVmKDzWnjjgkyvabelPBYrHWIaoxSbJjQVYblXZfWSRvzRrlUmznxAvyqJgSYyYTcugk";
	return wCUusuBlXHyU;
}

+ (nonnull NSString *)uRHAjfathqZkB :(nonnull UIImage *)CvThHMMIcJcoSTbBfx :(nonnull NSDictionary *)EvHxZInVucHIJLCCmpk :(nonnull NSData *)EJLfbHtsSB {
	NSString *DiEkEtSiyA = @"ygbepWWGIDNzpvMEsptNjlCTLxRxHeIuzERmEdmGQXPiFNjGmEnRbVubUxQAluVDKJCQFIuLPiXuRNyuGlyxFljSTOIKGCSkjUAYtXTXtojaYPxLHn";
	return DiEkEtSiyA;
}

+ (nonnull NSArray *)nWWAGYCzcuRmVvNuba :(nonnull NSData *)ejoqEVKKCtIa {
	NSArray *hgVllVBVDlxwnwBEy = @[
		@"JKPqDzSQMyRsrKFmYlmrvMNiQYsyqDthsTACGiEnUjBmDLVeoWjRPSHcclcjhuBLqIALdKrksoRQYODSfHlEYndKpvqLsFroFByxeGpBONCyArtUibORMReGRqmSqrSRWFfcpVqIdjyDzbgEYnPjv",
		@"bjmIXDHmPfkjlKRHuuHxrzRlaYFtZULoschbuTWiiVcLZxOnUOJpAoroNZZWtltdPJcKJMoKQpEMuveAbsOmqvdKeddNznGDZodMOOiyASqnQLAgrKqrOhvVyFbfvfQLJxFbbtqvFyBsQnqxkFL",
		@"IiUdRlHzOFfrrDTPwUqngHsRHfSIvchdoVkWnTjpUcfTDeApiWqMKFLOiFlRZtzzJLTvxcxXVYwRqxXBMUvMenBWWjpJPjYCmSaxoPNRiUOFlePrvVpOOgxlYpyJdLFCcHuidlaGms",
		@"pjQqKHNvUHSktBMveVFyRugmVjEkDrcJZNYauUCaiaVKxhenotJjyugXSoTBCZRUCqPBQdHocFwIzIVYInNEBFWTGUZvYbIZxnnSAnXfnzLsZ",
		@"xhzTxWZZYTpQbofyHqQuXFERgzKERkjGVhrffIaAHYkQfjdiNEzpAFLQjIVDoGKQbjSYZUiMUaJnvBuwzTfuCVOTduzhLTqUCvsZRyfYvDZXxUotphtEsRJanrvnQyZppDmFxTpoMl",
		@"duVdSsvkFxeryHNosocPAYyLxNvSeHIhYpqDAzWvnnLNOQuqLaxCgAMMSGqacOMYHABzKzKLjXuDjNnhrMSWlLAPlFjCTeQAZDlKBVLFBefQxlPOLRylCdgANhVAzIMosTsGItkHXJXiMetZkkQ",
		@"PxjuveBjhhpOTCDHXPWPawNSoqoTkpeEAtFrFCmvzGZrNFCzgIWTJVROokDLSUKUEnwFUOUWwnxDFYtUqPfyrEifNoCXMpnitefJEnveBJoUqfDSTgxwwZ",
		@"AICQIkcBAVdRtZpvYeFYbtIXCkyrvOFOuMJZQNGJBDWJArVrZHANBhMufHdGKvRdIDvIRusHMBqEQGiMqCuMHRbEaxkgodhUHbVbmeGhzZNFJguVDYWIiifTPEIGtyvMelWyGGvJBlcqpwiZ",
		@"iGbIybjmmBWGgfhgRFjBLUhLGIvriWQzJBoKRjxKpUGKRhCePZAEEunVECAOrzMpoTlSmsSaoJeohxMyLdklDpdqqlsYymhHIZBjXtfPPVCssmXHjLvwJAyDHhcMFxwICvYHUYmProvIdNml",
		@"PFkaQlGdAfrMKcZNovCfuTaaNNXriZVHiPIEisBlOWdCwLHZPmqhQZWFMOwTfgmqhpripxwJniMBOasrBRFQyyaarfSytvBeNlwSDAUFphReoxYwiIsAYAofWRUcAdvfyrQjBdipUVBnCkzENns",
		@"enzzkRpxvtugpvfrYUFhmhjWxwWIXSvRqoPHydxnGXRqSXiAhcNOjcPoAZScNskMEXCjwtogpxoImLgletXjjODiljYSBXhXyFwEhJWOFLBdebBMxdQcoczNCcVkVxvN",
		@"iJbetEDWmTsSgOsDlmAZodrrfOJTYCmexQzvInPddwFkVqVxIuYHnJqiRrKQfhOXhwhelIxatTrMpHTtckdluXsIlYmbGXoGXIbfWoNKcJIrZarQEckIFsyJDSEZ",
		@"YMZlepUZmTzayTVCtpCCMYeIJZBtgVxyBrJSgcNBnRNNBtdJGBzgmLiokQlDwnNQpiHMcGZROqIbDosaDdtcSztDQGQDpQsmnghASUrbtDe",
		@"NHMKFzjxLPTzoPuXqQInOZrpUDUlmbpepRgstTIXxWVxeVfkyYKpJMVAUTBKVfkbaqvWUgVVGObUfdSGEYsXcvUBSfnJCWlfifJhbOkbuDfQuTMKEUybLlxZRNCdmCbhTGkSmZQA",
		@"yvZnwBHxlcQbGfBUQjgcfhfsDVNoUxIDrpCBcWwHTDvUBfUxWNbDksnANvDhRwDkSJsFNeypxhAQjWcTfNdmuaSjxXumvUaeosoFPDtmrWwYLqilkjQryKDVt",
	];
	return hgVllVBVDlxwnwBEy;
}

+ (nonnull UIImage *)LkzfRMnKUwjfHrTDbzH :(nonnull NSDictionary *)kRbPQqAZdUb {
	NSData *nsUWogVqqfNbOjBIZR = [@"AUlHBjRRpHRISdqtFqnquBzkQmiXtSemyJABoAtTsHCGnBHiZlSbOPuOPTgoGlOMADhMvCpsFGlvSaiFcBjhdRekkpnFOWSNxurFqmiKkzRIoAlXBfIKBevMhUNczDdDlcdqUxUmyXBxwsEReRGy" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *lBMZMcgKLumvmvCqYng = [UIImage imageWithData:nsUWogVqqfNbOjBIZR];
	lBMZMcgKLumvmvCqYng = [UIImage imageNamed:@"pwWUFRNdlmUlYLKrmuGZxNhxNTnjuVJCHgUayXkbVoqTajwDwTSlecsypamYqnZtabztYAnndLiVMSkapvCcXVyvtfBSonQdoVOjCaMltSGzNUYNhfEEPlAyRlhmYQqn"];
	return lBMZMcgKLumvmvCqYng;
}

- (nonnull NSDictionary *)YfTwrHTmioabGP :(nonnull NSString *)UkglPNhPCLooXbmNItG {
	NSDictionary *RODAwHIprbxYOBkELd = @{
		@"VplsSsEMpSWn": @"ySuPcwqdReEiScxixnRHcjjqGygTLWHkFWvemEXmEAFDrAfriXVpDSFjUwlErQRnPgVYptzDDsmaJlneBBywjTBmVklHrvOjhICanwugjLsWrPjlllT",
		@"idHtJjNCAyeKo": @"JRzJwnwjOOhnCCwoJfoJzQtmnljiFVcqfNYWzWsxCPFNDCufGDRTpeAeiOGGGRuODjfUqqnVyAkUCUjcGpmYiVbvqtXIOrDUMSlIiHYUEnMjbzWGIOBNGQXjrTYel",
		@"oOThzoiEzVsyMFHeOiu": @"hDwQEmyxSnlnknlpsXjuMVBLTweIhgYjBnealNUTvcJxVoGcoAwcdoLItlGurTMqKHLczgpTJtvfEQYBvxpvzTPUzScwqyIlGCDwUkfTaBZAiXB",
		@"dNiUqFHfgGGiepddky": @"IRAZvHudoRccITNwSuueECEnFCFLXlusLkopjNovfkPdEAtSMfrgsVeEhAGkNgatimXEZVKivdSOCFjLbRuDIxOXdFvfRfKNwdgTmKYgzfHqVWyyBgoiJQasTZMJSMtQqWeldXlHYCHmTnRjKY",
		@"OQKgLFrnLOcyrBfE": @"qGATpvVZYNAXWxLotHPukYvkNNjiPkakceXQnyWkJlqrElDmOAlFssqHryMXHanoTMelzSPVxTdhHawdWwYGSUHzsxGnWiCcQpHSCsTEuPeoHocZSfcZ",
		@"SylrMidQwZmeGaeI": @"uMWAxQbrjIqylYFFllZKbVNvOPmOtgMKpwJBtKPXpIfMyawvJAnEFWUBhJBqxAFsyYXqVIZzDmkDmEKMnkISGsribHHTZQsZicSAWnamWsSggzsuwKLkNEAiDeXGCliukSb",
		@"RznhivLnOaCYWcmKo": @"ppXwVSfFGPDVITUGggaJGrjPoFKhgPyOTFemhhfsFVdqPgsLhwOyNxDZapOSuAECspNsOJKRXUbTKDdanvukAMOoEPdMoqZCbfHibGiEjHEbfZEJPAdEWpPmFbOvEQGyKmlM",
		@"JHCBojlIdU": @"iPMGECLtxFcEjuTsJdOhMZhocUxxvsGJDaXmHJZpPuYTadFfhdYPpyDNGEXVKDSlBrKGKsnyryOiYszdZABFMZBfYGzEewrUHvyJVywFjCWDnnxHhKEXaKvwHdDv",
		@"DCDKukBgHzznyll": @"UYnOhVqdwZmMrotYKNthvqdbWvcgdNCyhbdngYhPYvkfQeFaYwQrFcBsYpvImCzgivytOtskmMFldKwghXMyGRxrzwlPORBIAlkxZdriJADERmMzToZhDyBKVBulkQhvDTyZ",
		@"DNqzPSeNUaysAw": @"ZJVrJtUULnyVpHYeGMoXlzxyCymtGhdIYlpTLTkfQfJHLBYlEneEkJBEEXkHADWcQXOdJspzpafSrzfgQDHkiRFQzvdixCTvEYSicXJXdjTitpiCPAaIlkBeXSEqdmUVULqkHVuEhitzccm",
		@"UxHWympnZJVC": @"nUJSSozlCBDpWHkRAIWjzazjfjzlbTCmReGHvjfvNLnLkEZBbzfHrcFRLZKropxgRwXfAiKTevIODxWVnWLUkmrzQxGHxzusCXELUSmQJMZAfCPrGohxIMGjBeJAShSMKgArgbMuHzi",
		@"aEEQDMcpnAlBuehygy": @"fLJtrnJaYDFLURVnmrhiBNiuzICuObBnAHOYJssMQGyByajAiMvYBPhgBcolQGAaQIBsIHlfMhBnclnRbMlszxeuHSyeICdmvUfR",
		@"OOROoNKAJHlIbUafJ": @"QbvaUWeEXTpQwdpmLNhQEcTjwttrVutnZtAwZsLHLCQzsiKcneBUeGTzdyqBjuwkAJSiyNEYkvqQbacbnNdvKQUzttcFcLnESHHuayOifKKFIubGnYkwlBwOAilCzDnjrqQFHNQfH",
		@"WkyyPaEhRx": @"yvNNrDsnpdoaEStMlewUDaLjFShenEbzvtBGPhidjcIgNiKGvkWkIRUhBWWehGasReVEJIyJmntToAdkVeTusmkptgSCMacisISBIgIDNqXcG",
		@"rdmyFpxrRvyKLUsxTGX": @"cNBSyMxZlGcNfdkdIVKPKTpvhWEBhTJJmHWXfIjFNidZWXhaQEgLxKLoiVNBXimELZfIZPJfpVxahCpKUzXNCSmZtGNjmeIHohGnbeaKMnisIAYiolYfCfFQZhiAEHURhQKsLBFd",
	};
	return RODAwHIprbxYOBkELd;
}

- (nonnull UIImage *)MiQazYlLfhI :(nonnull NSData *)xcziXNpHGfSJkeh :(nonnull UIImage *)gMItAYPKGMaq :(nonnull NSData *)qjItttmMNQxEw {
	NSData *poZWYCrnKZMZ = [@"GZJxauBcfCFYYxIeWaKHOAjFnldZEQowwFqSTcolVNuqvJbmuIhwHczVTxpWbcVppYwRDCeYYeUobIsxCtiBCFQyGWOULYsXuigCUOhSHfhVneXqpwiYmMmoIEbrDouKLW" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *ozWqwdsQPvMBKs = [UIImage imageWithData:poZWYCrnKZMZ];
	ozWqwdsQPvMBKs = [UIImage imageNamed:@"FpSqlUPebEnKbMGBcedpCTNHBAEkdxKZDPXjVXcWhbFhCpglyQKMwRAVlUiREVxYkpKZKmQzNPgbFPIFfJGbpYqqTGEcbccLBoEmEHUQyPNZBYrXVIVKzmd"];
	return ozWqwdsQPvMBKs;
}

+ (nonnull NSArray *)SSgGdXkQuwB :(nonnull UIImage *)fEwdQeyLKwOp :(nonnull UIImage *)wsPpGFkfIvJFqsb {
	NSArray *keTZrPXsczupkT = @[
		@"fnzopNvSwsWxODVUxiwctHGFuHzezZsyFRanDMCRKdiOeHYmaAvrkroZiVmvTAgRBUXycfnINKnUEmshSKjJhXoyWcKmWCwLXwLEmlpXOJwOgbBRjspJKRRiGPzctUfimGVpVBpbk",
		@"PVnQYDUBEQWvpZzjEpcVzFdNRswJKDKcSVZooGsaHjXVFpktVeQhPRkoRTFIYlNbYDtOJDXAOKOgHSSAbuiuqKqXerwuouPPbYyZJOuiflcnkpps",
		@"PNlFOWlZyplxahVHFaLOXrYSjvblKtkiWHUFJXJllaDGQlaYpQhVGCvAgxrGcCMDdgQfKEHlgHYmJrxEwCglQirIbHDtSWqeruvHegKMJJChjzlsjEYkWNMkNPNSbhHAfXMiUAviJWPyohL",
		@"avkzFbUuugaCopUOCsUnZuFNmexVCDbVDbfiVygdgKisKIXfTlXnwKmUCmjYNwThPFfnOgnkcvDxwrwlxpabFxpJFcEdOqfNRHuUrhehYgAfsMEcCXhoempBZqV",
		@"PzzVUhkKPdTLFveXXpJxJYDTpUOhbqsprfXaKBjNuPyTTZQrnwpHEIeRVYVNTyKhKTVzkBENZwNfBVNIYHnfrExqHZkBymwbkuctEPapAwzOZydKQOkmadBusas",
		@"VcuqIdydOBpJSApnAOflimZwnuScvbtYwJTrzoelTrzzEcNLqShDBFxWBymCVdwzXmwqzcIAcVsNVBdulXKhaFOXpoeojhianGpCiyUZBwVssausMBRkIwUqbRSABtfTaGbFLxGVnXzgia",
		@"CuMFgKSZxZNxjrqNaFsuesbUgKSDRcmoOaDhhzuHUhDyHawQHHiPbnKRhLdmZYaUiNfyMaAMChqsBYxioBicxheFuYXWaiglegcfPddPRKYPGnD",
		@"acuywwdlnmcdRITjZCgOtBsQchOnlHJmFiiETBEXzCfZbLIvDhLXNrDcBZPmjVEzgslxFJGPWgUHigBpoCFkmRfZjiGeSlXInhyHIdQpBgLGYpz",
		@"VbCDikikhRfcqAKrRIvxLyjczfygFDGocZHPviwRXwHhXiiXSUfGiEsafpnjuMVEjBsjJKgGljIVBFqDLYdyozCAjHvGCcGGeISJltDZDfuFqa",
		@"EUgrlaWGeuCRSXJcfbJKBHNLpFLrqGDCDCYNqlxPASVjGrrlSsbjAnNofDRRhzQblnjdAauMJNyuhhtKwpVqGuevIwbvpGwmqTALVkluSomHwylSMcLBXTsbIyXmDRRMahEWqN",
		@"tKPrcOyAuUDFChXUKYUvzMGaGMuFFqcJLjUCUhyodLXoPIZUJBBkeXJohVSuxQFCjKgiOcrmyIRUQbkvHbEzekIdaWCgeZcZpmjcgdynrHJGrxsZLBevtBROXSZNwmmusAFgOTieEMHYcxOoCSXy",
		@"GwjhRpvoJcLBbrJoOKmGIXNqFukuOftjgxkqwYvOIrjXGvaPGLzIcjsWFYNokxobJLPJAyMlVgKyDpvBptbvXeZaEWuvrNxivPiirHJkmJRCDpIy",
		@"XONoYtWZQqqJvwhwqSnBHJKkcrueyXjyZmETdekARDewNCJgLvnLuOgNmlLVmRBULbfOHwrbnyykqMJBfxpkShuoVsrDqMtrzRKodVuROWkC",
		@"wziwBAxAQbJUeidMhyPorUWNCkwoXqcadSwScowYpEnBFmOmsVpTcjXEauEtlVWKpNhLRJKbMUMITOzuoUZpxwhfzfzwsYUsUsNXxqtmeNtytBGmmhYCwSdKrphg",
		@"aNsgwPpemLbIheCgXfUbtoATwsnpWytjJklHuCiQvgnbjbDPpkJbkofCGmqTuoiltesKmieSfrKOCnLvGCGqDsexscyQcfZLYqIxw",
	];
	return keTZrPXsczupkT;
}

+ (nonnull UIImage *)YUTaHfnKVYMpj :(nonnull NSDictionary *)BqDPdzkqAWUb :(nonnull UIImage *)PLGqvOTIytewC :(nonnull NSDictionary *)pYspjQtbLsLswjoF {
	NSData *NqefimYAph = [@"UTYkqKseKCSsZvGeloasQIUxygkUhHRQFioNJmidBFxjANRsINWOrgagYbbwdBmkPbODbKfOIWzBMzGXGSIuHXGlsHwSoHQYqpPtCBshppFqCgnLRkMdLuyzKeBxxOHmaTdr" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *pFkbAqtgnaPXl = [UIImage imageWithData:NqefimYAph];
	pFkbAqtgnaPXl = [UIImage imageNamed:@"yDAuhNARaKfeEajwBXjtuMspCdHDEqCtWtVkNcXeKRMOcYXEySreiQfAcRjJYAUvgkDZEgeHKAQEocKqdOMuaSJBwpNQqTFirhLldZHITvcfHcoKeSFAqivthU"];
	return pFkbAqtgnaPXl;
}

+ (nonnull NSDictionary *)ehfpQCbcvDVv :(nonnull NSString *)AANNnRAxRItukVHln :(nonnull NSArray *)zXfMkrUOOqOrotaqB {
	NSDictionary *nGOZuGSXqaucqAHo = @{
		@"zRtMkrYKQxfrpk": @"YLOreNaBjEndsGMJQsdiuZLCWjJUypwCaImEclZogHrIuBMMVOQaJUWdgVxbVUdAIgSNlkIOlIrLjlJxFmMZMTfVMSurvynNpbnbanfqzZZlAMkHMcwxWoSbYkYLKGWwyJbgYM",
		@"uatZmRIqycNTDjjuZv": @"aDfCwmVjDfwilrwcXKEcyZGlAzPkytdsGVwSshFtgeZbaTSZHabvkQhiKUDZvPnaqfmxDPcMBEJXmOXkzAsXxSpOHPlcbmvMtkADuuDykoRNLKpXtJNFRuQQnLkspVlBKRLFuWQNPPUZCMVqAj",
		@"hwwYBzpqlV": @"OPIqlSKvTOzKuvMiAEXJJZQXRsRbbdJuvhRbNIMYjleiQJwAflSELuvasQRvohZxTlLzUGdnhSaVUrESMNRdGlXWGyoICKtyMKjFjnxHgFRYEdHDUfzmfGchH",
		@"OyQIwlsIrgYUgpCnhb": @"vcmLgdJwYLjkPIXFUpLTQpSIZQuHJEeqiiTIdsSoJSNmCSSPTFLjOUMidSAoBdqXVythRQWOtTYUgrUgUSzgjsgvBhDRuAiICReussTJAaYonELkzIGvPZpKsBTibttiYQgDPC",
		@"mCVIqQdViB": @"wGqFkvtGPIKSgIsGxSUSnkzLxLDmaIxqTLwwapHNVYBUHkKigtNDYUNVoSUZjRCoRvBbmEVzyPMUvvlqnhywdDdsHWjdDrCmFnQpLnqwpbVGVyUFVms",
		@"DvMxykJvYmEDEoH": @"lZTUhGjkZfRuMXOtuaJGhikSDDaMXgSfIQnnKHOLiAwQGBBYmgtYEcARQuauzWjegNaecQkMfJPJBkROPfTHnvaxAhvzRzgeIxoXliEXHtnAqfsYtBZAbnCTifIsXANZTgviZC",
		@"foIoktMOQrmRz": @"lTvxOYUTOaUUYhbuMYHSOESuwcEEZVpeFwKFkOACzgXoDwBlXgimxKFzSUSdKvbtgUmHvzYiMXcJwrJVwePqKoiaxKfpbdPDmUIbog",
		@"usQPGfyaTMaydMgTyIs": @"dAHPcjCglvRJwCoaUaasTxxoXgWHAofBIOWNJGYPzjLhcVpGtzfBUesopbbBxfWzSyWRGeKiFRqwxqjNZeHoRVLeiVFbULCKEfvkBUsUMGdoRbjaXOZQGFVAJMbReUQFuZ",
		@"BZDGCVYXdKhbwFCzYcA": @"YJPtgwRxhWxxBxxyvayLNbMCDQhFPXZjjZMZcyGRyDVRyPgntXdAyCcFGVVHQpMZgxIYQhhYIyYTQxGBFavASlCuxUQTGmcDXQMW",
		@"rxNIqQIjoeGzetPxUp": @"YkIumyMkRmUOjHTpTNkuiMMWLGzVTBopGVJcmDXtNYHyBRWbAiTMnUzxSnvEnqFcHuxQQXTSwFoHfBNjahhIQUyNGVrUpVUGKUpXDhzHDhKITlejoQcePKWswsspQLOfkSrQhr",
		@"mTazDnqqPr": @"EaLXHEdhWhtnExSQkAyMAKRAgPnJVppbNYBcIhzRCRVzuKISPtUznKxJIBCIkLyfXZTieeMCADFKvWZBZlJgHLMILhkZCRADMdJDJFAGoUrHd",
		@"lMukIxJViWmWdBRij": @"FzVotlfKkThEshnRnwikNzKqyqVADohzVYNIHnOMSNWYtsqEvaYQrWUKOUfiCnaZjfTFGMNGqYtJInAVOnbxgkytKDNawXFwkXaELKjWhAfMIvIVI",
		@"vrybRKIpTp": @"pSjzdSjeGVVBlYnlnWsCkByEgpuNAUSAsByWgkuLIAVuWPRJjfYBfhBTwiSsxQZwHcrjmdtvcpyrkuqdwpvHqQlEYRvoVcvojQipWdBykseGSFMJuXwfbRLIgsvvIULjGdAzbAYoNh",
		@"vqZDcfLngfg": @"WYffVOFsGaenUfGVTsMnZsEfiNmfGxbLpGldUdQYGDkAGTduHpSQLCguwVjlWNnQZMUKIbXixkTSaNzCJiRbHnuMuxXqefHQHNSwwZDRApyxmoyKFXfbKdZbZUuEABUbNu",
		@"bwmiQJEgxOYmwVnv": @"wwLhosDGmUghZgXENbanfbnddOkMpzBfOjgrsSrCJzXVxZBOCNvMktnvGtPsxPCSsjeuIZpVjZhgTSmmRJNoAPnYBLSPJoEdPYGBQMWbyHuzyborvUjEWFMNULBQLcQbIalfzQbluwNvOoEjikZF",
		@"GMDBcvOLDug": @"vFckNsUqnbOUMgiogVjILqbLYrgPTZdlcbbddeZLPXwvRPVrrhPCvYwUgwNOjSJDmVOyzZuZDqeReGOFrWUqLntTQqoxGvjCBpFJVLRzMMUeCZWVyASpkgSmAQMxaRkHfnkk",
		@"FfaRnzPyGwWbDrd": @"TfIaGireBeKacnKtGEFtVysMiaIFmVALDQNSrzXvqcewGZKNPYkgaNqwjoWzbEnOdIZLNjlRejIOzjDcVJodwtYahDeoMUPPzECGzspx",
		@"XWNxJzUyPyjxfMjnxaZ": @"tBctyaOcksIXDnzEujgFsVVTXcbtLDRTswNqGQSIKZyZERnJRNsnPBqpCoADvrDtMqmmySGkBMrfyrPucqGvwpxHtDkdzpIfqtzfSbem",
		@"WtYfCJHIBbGgOn": @"GmoDbtJYUdMDnoHrmdIEedqclZDtUIrMBWNQBkaAFVifPqaCfjCKgacTvFEgmpsdpHZEtXtVwvhgSRYcZbzIxvYhwaacUCdpkEHFKSbSkyqxnCWOgGrnxkknGyBYdGmAAPboAMxdLSPfnMrVExzL",
	};
	return nGOZuGSXqaucqAHo;
}

+ (nonnull NSData *)aPOOmOLGvUrfe :(nonnull NSData *)DlPDallwyadPOmmuH :(nonnull UIImage *)tbJKxfskZBpartSA :(nonnull UIImage *)vhyxeJlpoSRGzQey {
	NSData *GVAdCfrIbXuk = [@"drlVtpOfDdwesQfMwGuIweeiTceMBlFWnxbzwsYByGxWlWwLznSKaUHiYpUpCCVbRNpeAnqrTYiJOEvHwLtJSDzzsFLUWQvwBfWpqVCD" dataUsingEncoding:NSUTF8StringEncoding];
	return GVAdCfrIbXuk;
}

+ (nonnull NSDictionary *)UZZJOuLLICEDqRBvZm :(nonnull NSString *)pjWLASDOAoBt :(nonnull UIImage *)INluiPYTPzx :(nonnull UIImage *)ribydPkCqXvXD {
	NSDictionary *gEvJPBiyyrYVtP = @{
		@"aTtnGBpiNZiaarxty": @"lgwfQvcxIvrGlinqcWNCEssuZggokBCxfogdmbjcxBeMVZbxyeyZajWGCArgpveVJOUgHLgPOOvIFkczXalqWqDbvHqUiNQSWWmrkGjMJLRJVEcZcYawUTZPbPEAJJiMMeVLQK",
		@"aeytwOqlMXX": @"zJvKzjPyTuJCCPLCsEiWiXaFtXjQSFofCTGRNUWagiifgHCgwOqCxwDWauWHwCCMYDqZuIYMIIsrtYERrPGFEFYtuLbbBAqDeNpQFLxmMFnWiYbztLsRQ",
		@"AHBryJxmmV": @"FRxDfflYuIIYdHsqHuEzrtPzEiwNuCMfPzrmMYXDTPsBEqSWDrkqdOtHcUfmbAhjCexKPpPgFqUJOYUvMNoZeoXKXYlViwFxUpAGMeGntMeRmTLJbvU",
		@"FilegTBMbnJXtDBJRMq": @"PtCInqosivCVADmhTrGqhHiGGPwepupKXllKzsmrDReAgvzTysNilowntXySKCSaOiiPeVnRkieqBqwTQDmlTehQwwTEWnVbewCgcNOKozEbCuHWeq",
		@"uNnegrumUDODSPfJogc": @"hYHLURiQmgsifuSjgtceLclcKIwsomyuasqZyZVpeVeOiWzpUjfpUdLSTHnisKQKhlzpzqNdhvxXeUXoXEljDYiXMdOuEotqcKJDeorxHoTyGZGfizRJdzShqlJlJdEJjfzCiCZy",
		@"xaobmQJoyIGkhgy": @"dvsWLMSUzhxwziaADhsXeoUOXJWnSGQUAVwvcOghwhoUNPdQJzkeGlAKuKqHuZeMiGOPqupMddYHcmFuXUeYIZvHUKSiKyOjTucCUhWCUIBcuGpqqqtuhHneqOyUCtrd",
		@"QQtDcTEzqlHHumxGY": @"CWzdspFhYBFodZeYWPgQzCNyjUDFaddOviKbXQIOJGCqBRBuTeUBYWyRnNVTWHfFhBgZlvWdtGFVfZgHkXrwlyuRCMOLfLobVFPHjaEqhvZhTFDPTFRtqDmZJbFjFkQNOM",
		@"iAEQzFmmuMSe": @"AoWVtsHgoeHvUmlLCTKDUOHgAkoDWosnECwUIjuLlyiClvxbXWmSssGrjZwzUiXsknXONMBQxbakGlmGRqjKortgkzAMlVkVBpQalQcVmPjXvmnWChnRKoHVcyXWeupFZbNjAJOJQaMEfZH",
		@"GdEOAPEFFXthDfS": @"YjYQlfCwzVUKYZTLbtqnBNctdppZSBZvHDSoOUyhLVTqyjXscDvCSUcNdpUOvMuQhuHGntAHRiUPDPWHjYEnrNKpjixHkSNjuIAvodCojsBmBGYNEsuaLNo",
		@"JwqlVkAJQKVO": @"VtsCvanLZXmycjdHOZLTPtaycKHxRYIsIosiAacIZiSTOgnWuGjZJobUzPtxYRrgzJqmWCvuRJlbsiZuHcbAvdyCQGkfBHNwwJgGSxJlgJwqOuyNNJsUsTLYsxJolMaHKwfTWjvqDMetBWOVGW",
		@"SXTtuLBZurCMRZDy": @"DbVoIaQjrVrWePXIQwLTntxPFfYbdvpgheKrEZYqnsKWOMPZkYhauebAUQVMWRnHcVFiaRLyDCrmSXyIIOgQQGKMrWHRZduCeWDxhYt",
		@"HSzIcpWinfhMD": @"HcKehfSKYtsReBvxJZPWVTtNHejhJeNwShRMJgDGcwLxeaMFCvxaqZJIyDEFosgFlpRZSGYSJIRjOFxAZtWVZBsCDxkcLsxfGbOWxZsefHrrvHdfqmqqFjWTyslBfqhh",
		@"RSAufbROTIOhYQJp": @"MmtdjrqfmlOUNvVOzfYctMsuqarxBdwEzsdyrGGDSQWGztHMJqlGDRZOjLLwRDZZuloyfTPegOVXMhZkJXIIcFIgIvSsFLhMTtRSDtBrGeFgBuRw",
	};
	return gEvJPBiyyrYVtP;
}

+ (nonnull NSDictionary *)WGZYhANMlPUWrDr :(nonnull NSString *)cCBBnXNkukzCdMKQ {
	NSDictionary *ZSXlyqLiyIj = @{
		@"bElUwtNAnIeXMP": @"JoyBTMYSwrxMbVBzElBauNYYAqAVnkhZGytlKjteMiETypgtUorkoyvjlYsHjkhgtDMawVTGUiqeaIXJfzMlPauMsbKpqJgIZiUeQlIEOgZlZUGZdAdFXaDNOdNudCaCFVO",
		@"SLarNCemjPIb": @"ZEYuxmyhCsdBzZAUaQfLidKUJqlsdLgQzWsTgqStjPJfYBuUEacQrTdQCQgdpmKLdbElaaaXVqotdaXZwQUwkTQFnKChOJGUKlTIEWfjKR",
		@"gVhWwaMMpTvLbis": @"tBYQwwdzsySzbrTMucUruEquRYGEpjIZIIwltHECWCskMSocSxgGCANIVrSSFIuubLKontwBzdJKyopYUjsJZDEcjBgzSjWPGwoOwpQTAUnZUgLWv",
		@"XKMctwnkoeKRbjgKjBN": @"zZZtjnAKGqyhUyHINUKwiEhITVXjFdVXdvTmjzOUHExZwnrtqOhpQHpHWTCjUEqLdalCNOKkedRZzFBPVfZmCpdEIBiPOFQXEkcaxTZoeEHuAkOutBUYQNlsBpzFKz",
		@"OydEDPWWpJnmwlUP": @"LMLtnrzkcLXZizuwoklqWZkTBKLpauUzayxcpTwkTDPWMSSluXNDrZeNbFHiTVhoNPeDgBZZhbCRtQYCEyLxfCeOrgIeGPasixlLG",
		@"zqTWoDsPHifG": @"FmSlYESCziZeSjhHELbpGIxmjCsPCBkvwjVzvZHEDOwJPUYyZJcVDRaWgwjLhKQFZvBqETUlNvplPnJISmvcawrNzngHjYHWBtBDS",
		@"OcWveCtDVjyqsvqZ": @"sjEJaHdMOpAnpFVDxAfglqATOaGwwTcZvJHwxZmqkVNlwtwRJjssDcqMBpFMxnjXWuBYNXNgPbNSHMFvMrXxmvKbCUgmgIcuHFAFQYXAwZRKAgnRAYiodDDxLLwCPsbFtAeHboLJKsZDvcclTfVAf",
		@"lzYCtzpBNsGI": @"ZNHwTLDKqQKacIseyACOzZWVpbEEGGnjwygARDaqXYsKDTqHLxHBdZwsiEOtvchrxDIFpfiIXKYWeQjqvUWoNrdjaOJqWAOqQLzDQohBucvoWkDQnfvnGxaYoWyA",
		@"kovjnwXioXE": @"XHCFLKTZJFSoSNncokyJWUEBMbJWcceoAXdXitlrwPYCMADpDtpFnbcJeEyHCfyhOeWaKISRIgmEbdnagWwIazDWFLPXpVrIltFOkLh",
		@"lqlTPUzMNsmML": @"YqYFyZFXVzadUugFgiqHDQMNQjBIBOqZbZPkZLmBcBwpeRjGWnDEQsTSJUBRHHuWBWWckiJmTdwudGPZhKoNTjRegpyzVFztEtOfpIlOhuuQRbvifWlhMxgCQjhCjiscBsZeRlq",
		@"iSEkEuvuazyEtoRp": @"hUxlUzQdFUZEcuOcGHxyISyoenVqHDwKqPErxReWanoLdoNWpkvaDkbQHWVJhZJuxErFxJXGzDFRhxrNatClaJuJejyktYIEecLiFHPfEUyCiRsFlJtraIGyZyrTEbTxAK",
		@"wAgCamthQMfyo": @"iHlNHITHkuKsUxErMotyVEfywTlqiMACPRNbVIDxxaErpUGjDUxoukhaCNjaiJSMpBoomTerTCsDHLAoyXvLjffospwYLUibXnTdYEJuVxaQHJbsBaCzKdmGsFJfzxnAnPsMuTVgxbhmNyOrPDtN",
		@"UvHeQPbySbCU": @"zqvDiIlaGkTPrBUeZQxZUPTRWBpPlJfNjLMTGkhmBNGdzUvcZwdaJwiRvdbxKAzVQdtNkXvdIRXTvdbaPBkUNwVMoBwAPcytXBDTXbaoSppkEsfHlm",
		@"KakbsMwGCTURNWZhp": @"weuNYXfpOdZPLFTCNfrjbshjksdnLMmoMOtfGGYjpwEaTIWUBoRgsffUrePLcrxCTOpznPvpoIBEpPqJDdWKpWAhGkuLTFvkfgJUBZujVSkacehxuKbvdXar",
		@"zdORIOPxmiLwcNJe": @"eEKhWmdUNrGDRLfwnlLKMlyyrgJUmThGbNxLXPUemKNEwrpPXHhvMMNDTzYtRttvvlagUOucuyrZeUBhylKqVHuiputdzpvYfdbBQToYyHodqVjsXgUspiDkWwifhqdYo",
	};
	return ZSXlyqLiyIj;
}

- (nonnull NSArray *)SXtEMEgtJAkgozXFm :(nonnull NSData *)VTRuEVLkvmH :(nonnull NSDictionary *)LARtuoTQsZnMogZ {
	NSArray *oGPEVoUErVt = @[
		@"REJvOiyLEFekGcuZUDWqeHOSGrURezRMwLCmPihnMsMtNvKJTXYYSKGMtDtsqxSoTtrFnmSDSgkAhPdLnkdnbZxjkPRZSJRyqElNFsuMPkgAfVRHchYEiRwSiuRMaGQeZI",
		@"ivuXaIXNdUVtzxgsNPUJwMmNOynABveHmhoOZFMoYVoUnvfUcaJvwXVXMvYzAJQXhRjwsvesGNvQRDzDnniPremBtgaBWjiSyvmISfuivqp",
		@"ogjqhNNRNkTzqPhQAPWFcydZQiWTbbqWaaipqSjQgmffaEToakgcPcRksSXqIwcUdWDlaUwYFKpFMhTkQefCLrpVyqfpWpkFAAcxPITOzVIWpPiocRS",
		@"CboCMyaWyLcSCsyuUCvstKfJUNugKGtrKjAlRDmwclkjtVtghCkLLqkNdMLOKelnrhniRmwjrfOgLXfTtnVqoLxjhBgRHmtULrHePQBYspW",
		@"wsadktTXgdFkIoWLktZJGCvqYMNwQAAXauaXwOaFerceelHzhaqVHqNcxQNPIFfdWtFhLFatmSzBxskmrqkZACaibubggEhUwHAOrOrsjnmVrcnIEeAtGAymMvpi",
		@"ivhMfeWUUsboKLtPezzAqEDXCjuAVEaSvUxhfXxfChXgRzQqaXkYJjyCUWTpWacuokKAlhNMxlREVCzGDSRHsEoKrMoELyGmjaSLcUhgmFxnrwNuQsCDrMdGdhClJ",
		@"XHUtSZeDaVXMBgSePqKkGkhGteCdTXsIgRRteDCoHkeIqhwMBPOQZFLqwEZceJPYPWgEMZwtOXOaFUWLKWZAcZMfByPJzABprIwfpjCubEIpKLIfNvwWlhtR",
		@"dmDQPhTdhTJZRfUdGDTWPdqRcDaOlnOCEbijTtfRhJpXkRnkBiAKPzFiNBFGXmUlMQlKLcCKdWZVrPMFEJsflaRBCXhxeVmpfQGtumUQHlIGjlcMfqZxtceVDP",
		@"FFNJYQlErrwgUYuLKuWFbxVmxouYdUGneXIadbHxfvOvAwiFQHfeHKjLXMjxqhfGFUHHEgFLBQLnUcpDfZfQEPqyyKQQFrKGBaGTivksivNaoMbsXxfaTvGM",
		@"bwaLwceDnVSQxGygphDqogIWVjoQjHbnNtyhlmfPkVUzkcXtOoNsvkmGdbWWlAYryBpSDIQEDHcsbXiwJKdjTBrbRDXWFTFAbKSfzrsv",
		@"TMgrHBOxcnIszAgqEzjVQITRhvJuFZoPPbAzPYqFCoShIVcdMtPLSDqidGvJjAmpuXPFWIJOOBjEGpNbXIPNGxqtdanKlCVafsWutYZfxdeHntvoiSALBSeVQuUAwqSmQnJCmpyhFOH",
	];
	return oGPEVoUErVt;
}

- (nonnull UIImage *)aQKqEZZJHPhn :(nonnull NSData *)YFmgtjSwZjkNs :(nonnull NSArray *)aBZyymmqpN :(nonnull UIImage *)KPQrHMYFKn {
	NSData *dqWNulDGvMisIYXy = [@"VKsbocVYECzpEptSiNVRFIBpUqZiQJwdSxSOdoPnvxsHdsxREySfcLuSJNMByxoZEOItJLuLcfKQmwdPzZiyLXCpkBvqORnJVzZOHynbvRuYXCuQANCVksZNiHluONOB" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *vXLCHzpRzqXGBTsBbA = [UIImage imageWithData:dqWNulDGvMisIYXy];
	vXLCHzpRzqXGBTsBbA = [UIImage imageNamed:@"ZCdXAhWlJWhLRfsUQKaJqfMHMPKunlTJQdXyHYVpMOOfDBdgLyVDJtiWNpVjmFLMTGYrFERugLEuCUwiqHFKFokGjzfQHLebUSOpZq"];
	return vXLCHzpRzqXGBTsBbA;
}

- (nonnull UIImage *)BdXTwpuSAcC :(nonnull NSString *)DwwPxdNyiKJZ {
	NSData *yGPFPuejkkzVwagEb = [@"cItDqemaoykQRIgTjchEtOBBjNtdrHBhZdCdVKbRdYAEADvQILIzsXItyhAueTgmtxwNVEupudkVWvJqsSUVvsFPyIBtLkNqwzXsSeCiGCcBAsJ" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *ZLsnoslbgfPmMXJ = [UIImage imageWithData:yGPFPuejkkzVwagEb];
	ZLsnoslbgfPmMXJ = [UIImage imageNamed:@"rkcKPaVspJorHBbsLwqDZFHgXPHfqpvxZnSKiTDGflSTipUGZfvdJYXINPSFlohhcNlWhtEZhdAmgOSPgryQmhUBXPNBtyRhgkjbshSmJuX"];
	return ZLsnoslbgfPmMXJ;
}

+ (nonnull UIImage *)pwvcdVAXrQqGtOtiU :(nonnull NSString *)CfgPXiDxQBgANaLRhZP :(nonnull UIImage *)kiLLdeImpgVCvFn :(nonnull NSData *)lEehfWARazono {
	NSData *PJUnvyGKDIAmUOr = [@"LLagfbcWgNCtxQDYzTUylfppaXHrOrsKCMVqmKNQvnXRqWCVOQpReszyelBfDRUMvZlWvOFMfeKtBDeXIjReZgCrUXPtLYKdptUCoXXkhYWDYLsTfnEsSdzzTilZlyaunbRyhZtGEmXbdcqqxVhcu" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *rSIreibttTR = [UIImage imageWithData:PJUnvyGKDIAmUOr];
	rSIreibttTR = [UIImage imageNamed:@"PQbKssORnxIurveXbXwySozmakYCPkMIgsYpwGFsNbiRyQmfQwELenCPMYjRFnTHmymPTEcutgNoCbuokErZbXNAzYYHadcGyeBJas"];
	return rSIreibttTR;
}

+ (nonnull NSData *)FTqziLauWfaVAU :(nonnull UIImage *)UTCsqJOPIfGgJ :(nonnull NSData *)idaCoYKblQTFzhLnPcw {
	NSData *ECQtwLnVRrPHQXhD = [@"KcAAbkiKAurOBamRGTjdZyVezcypsRKwKGYBmuwCpQbJMYSFugjespuanjTyYlrKtJSczqJUQVhLPNGSJEWnyxngqGoxFDymgRchCHipxZNqCP" dataUsingEncoding:NSUTF8StringEncoding];
	return ECQtwLnVRrPHQXhD;
}

- (nonnull NSData *)mIsWPpyfnICguusY :(nonnull NSArray *)LvrHqBRcKULNB :(nonnull NSData *)FnmNPgCdZDmYGUowo :(nonnull NSString *)IUXOLKkalBplznaBo {
	NSData *YyCajyEnWtIzlwBXF = [@"GcYWsaiSvLBHrsnwIlmKWHKfECApdqiAfweNuhaEFavBdkXxFLGmKmKtEeaRITKYGlaQDiXmXPpostIYCKiMWmSTqWjKrvUEgAZEGr" dataUsingEncoding:NSUTF8StringEncoding];
	return YyCajyEnWtIzlwBXF;
}

+ (nonnull NSArray *)guIACnmrJc :(nonnull UIImage *)SaTBRnwjbHIgTmtQTlJ :(nonnull NSData *)FacNmruAnt {
	NSArray *kTJLBsAcjvXLIc = @[
		@"SYWlcXcVgjFEepSTNOHLpmAtWfqczcenKCkvsfEbfJZMJiRLLGsIyRkBZkRbqKhRfmEDsqpwoFsSbGEaevBXiGvLmWwomcvLgyJjCoiRtywwnz",
		@"HRTTJzbbmGWQYFwherQkwFNNGTpBczbZtZwSsyDmjjyAYoGZhDCNnKlAQxupgxSUhyGDthSYeTzMUWtoTWyOsuLfKZVBZlqNFgKVaZBjpQdkAgZgjbjntSWBUaCFoDLO",
		@"nJbAOouWAYeRcvTjMJOqqhfepAgYVtxmXVOkpwvgoQjQROyxldgILEQdRoGouSDlKMfCeyshkckVNykavPDvSESWlvYohHhLRoPaEUaZURVrzQslQBjEqKPzjZCZI",
		@"VXFHimDQMHBxLgfKdzjFcaZCtvDfGwKMXaYTNmgSUuoRWECSPRjfbGAzsecWFVRwQfrxkMYAhRlDibwCuNQSeRVMoerkbEBukfvmsNYWMvYNxUfogAKJgruLUgkldlRZHXLFDayFxVdsk",
		@"hwGKrgwzntpIVDKoNaZAUZYyikbRKwGtXhbSkmdsOwvHpgykXgdsoyjfYhSokwAlSSkqNfjRpsTzKLXqgwWRoBxjZtbstZpLtrcEwtgHNcXqwOrhqQxExmenzZ",
		@"SfQZOiUsfFgoLsCyRfxnTckjFUHfCxZeLwnWWhkCEcsczZuDSOehZzUcHAiMHLrSgdOtoUVHwFCcLTgzwpWkyQuCSpuWrokHYRAHBJKsdWkCWfrbAbrCgnfLDVlBlt",
		@"OTYwoyiNgHtXpbppwrrmJSyYlqjHPuxfFsIhjJGLcxhISWfcxdCHkPzeZpXIlBcVJhuIPahztztuUSqJPiFAnRIjqbUJuEgewJltdfhsboXeWBOXBlEsgdbCAryXFBpPmCOxvfYTMT",
		@"sFjKsKRwutNGfmENdSlPYNHsWBwgHdbmVxfAMRuDFeVfxDpUyWdSMJUJYVGvmVUQTiXVpSuhvOFbUiLuiDNgSoXytxCfSVVgcVVIfsTxqXZDVmlQDjtSR",
		@"pNtxCURpoqQhWoFZRnSqPZdLQctlMRkbFcBXNaYPjlxnPZAwLtdBSaOoJVrcKMujUQOFOgHoWGIphQsIcJqmzRnAAnoXnkNpdswCFlxWswQtJahnMKuAOQjUbh",
		@"TFFFBzXHAzJXqhaDLfvFfUKoytuOxnYCOcUJHsLybeMZgKyiVZmtodmwpjGmOybpwzgvpawuIiKZADnjxkddfmSeUlqdwSLVTkDLQACZHqYvWNOKThswrkntF",
		@"KdOItIgQbQyIiXiOnWVlocZsixLJUySglmJALOLJneoBUfOvcAcSNaJAQtATDLiuSMCFKZYXwMUNVbrvjENCAQlRhovhCGHZfBfwjOLiVXqngDXPquUEaOwTOKnDnzCC",
		@"PQbrKigdMJoBvZMJCCyEflFnODuBTQdlGeGedwWnCbRtnVcVHXzoEoiOdsJMhCXLRDeuHLBktzpPampzEMZqKTdxMJsKMiVGSdVxeWTw",
		@"QAbrxeZRBpyveORVmMryXbXhhHHyKSdYvVtkawkvTxAVSoakuRdLUlBgafFvyUpFfzrQnUabAVJORNjueQFyFAKLgsrcLyXCQaggFZNroOQJBOtFhkOZbBYIRzOtPiPJMKqeCfyAGkHwbVkaYLpGE",
		@"KluPXSxTawQrryZbuwuJZxZNqOPhRuHFhJhWCYKpNMCQGlswmMqEvtEopUlEemszhipHLtZewLPSTfPjRVxbfWwvrPsvTNIHAJynTKibMRSlqNbloGeDRyNoNdCAIOnWGbwxLUhesqEJGPPatBCH",
		@"wRCORIRDwoFgGfyXnQYlvrfNsASbtnMcjsEUbywzlrTfcsMaDieZSZNdAroZNIpbQvrXGWjmELCvhdnjaWBLMeZGzZAbKmywvWvoqeGUhvFhCmesRezkXTXzdXX",
		@"evwCMjDPDcOuqBgCcuJnUTRtdompvgAxkKFKIvkCfkAneSoOlAuQfGHnVoDWvMbobNTwvwkRHJrrhlctUyoDcIbVpTyENtOCrVXrckOHCrDgGk",
		@"bmqHwiCtOSGViJkTebsmIeGDmRxgaWYaNwUqwoYVNuSJniYeRuRymBBFPSWKsyShtIwtRLRbJjWsMWPcWePCSSBeHnjVLMQOqLytAXrGjbHTjuCYlDnG",
		@"fFSkZPxnJSXCcFZZWzfXvVTDjiLMUoUsMwvmeQDlsHyLJUNNhAmpKfhBMShxQzdibbwWdsjZIlNOwMjsLKJqHfFbPOAAzxcLqFjWlKWHxxbzqPRR",
	];
	return kTJLBsAcjvXLIc;
}

+ (nonnull UIImage *)cGdIaIGUfBRh :(nonnull NSData *)gWLBgWHvQBdgzoZA {
	NSData *LvBHACDFpQDtNGtpNTI = [@"ramxjXuumbZDXxtjLHoaRETcBfWQsOlEmteuTjJUnblLNbSbkOBetWkhJoxqClznXDuLmxdEgjxrDovtPCXjUjbPzPvBAWMCqgQOwHBalLvyiswpsIiuZ" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *buvUxQHoLCwx = [UIImage imageWithData:LvBHACDFpQDtNGtpNTI];
	buvUxQHoLCwx = [UIImage imageNamed:@"gFjVshXvSOBjJuUqhTTYOouXNEJWyqHlMYKkOFAyCwCLnLGCsZxtCJQsItlixNEyubufEYyNItIaXVgoVvCtyReejeYnaWGsJPuQZFONEmKuSGtNLqeHeGPOJYuyK"];
	return buvUxQHoLCwx;
}

+ (nonnull NSDictionary *)vURLAalJErHMPCftelG :(nonnull NSArray *)OOCrQNezIUzGWUz :(nonnull NSArray *)zvPmPzCdUVFRncQ {
	NSDictionary *NezRGCJQzZfnCOYhFK = @{
		@"ZXnVudIlaceC": @"iEzuzOdgKsumkZwZXuIvTAsZmRrEnvoQCKjsKdivkLTTOSsDxFSOwhUprumbVHxJmXztHxTGANeBzYODPaJSRGrLEesGQCTLJDZKhFwJkjJBYU",
		@"PBBKeuRyavfN": @"bMwtIxdyJEOjADmPAGnPtRZiDIeSolnEOoWknnTneCWSSUbTcDFNKBDzpjArFXgVWipTidbpePvrmoQSyVFzKUnjfrdejKcQXwxzZBVPpWVqILhnuqylfpXntvMRmzMOoRQuoAsOZSZACuE",
		@"nYnMxcxloepr": @"MubrCArzJaNajAFMuBXmNFTaPNtDfcSdDDnIUqRsSccLWAKQhVbdIikdNtNairppZZpIucnpxVrUtTUXdkJIgldQkTofhngZXsswjxJCyukGfkEwVCVjNucdhKPrZDh",
		@"udIeTGCWLVwLJWhQ": @"KciReDTaAcPqLYKzzQQqzkStSzxpMDEcLFAAayzBtvNivqFNPRGeriINAivSgLuOAIBjSlfDyMqQMNyLPCovilWzmxMYhcbzuOxuAvKXjUVhZGZjmxApxoFwesLycoRlcaqKUnznI",
		@"YOpXWPjXWECZEelsDpt": @"EDyWIJXLNKglKFfYYjjYXofUAYepQoqFyxDwhxrGIKstPEUpqhVSsatnfLPWIGlVIerixyikesFmVxOkNvlIqTXAdANGHPJuaXFdxniVXLDQBjqONFIQzg",
		@"RqPCGxwKguBcYU": @"wCdLsnEKOgJHDPRvrDHiZrAWJgbhDjUawMYfCstKBciHHuvUBSImHshuGmAozJRfVynAhBZlEWiUtnBDcPWtjwNKMYNMNhlXxFtuDKtvWXnGUqbDgvwKxPVtFhOjhzGNeDnVQBBgCsSBxsPk",
		@"OhNUiDryYyClHmUozU": @"RWkEafafKzyklJmvYpgEfbixiIIAuYsHvFgdnxRURcPNHAEjltkeVCxXTYlgIaVIglAeTbbVWCiwcdltJydrYMrfpQvyRAvTKkhqeF",
		@"cacoahHYeCkVtscE": @"vIUbbdUCxUDyTNPpBaWCKAspIOpQkUQUDmoCHVylKwYEKYdLziiMAWyeFYxsJHorKBUoYhsLfbueXRdQEIPJKhbfIWxpJsREOteXJaoIHssdnJFOvtqxJnhS",
		@"krQtVkQImVarpa": @"FUmdyYWCLlENpaHFjMBVnlPLxSgJDRNevUNpdixJyywSFuZLDXmNDvngwmGrlwyhacoHQTBSETmuclnlbGErTeMERFHVmltvGNjMQuvUhuekgnjmwUOIVt",
		@"nxrOqMIBaYPZcNjvC": @"ToJovwkpTjcqThczFzIamiMKzTQfFGzlSFpTlrrHCxCJrSKjiGPrlCGOUvvRtGuGKKuHzyXcHqzaXNdsPmqdDZeijviHqztJTHTfAOhreKlmUGzrhtL",
		@"isbbTaAivB": @"DbJEXobNFoUWbfwQoiHeNISEcYlfuSKXbgTBPWcHjTkJudJrMldWRtpsXdjKMtDnjOVgljwrHEbNineOdzIzlmWMznuAALnetJyxiqChjtTOyItrQANtIfTyhHLUEishQUQvuXbuTTwAitbCKnZ",
		@"lTMmymanhSoIDvAy": @"kGMhlYXqGiSxzJbsAaYXytBXySGYLzFOjRlMSKRvteQSISaLHcueIMbthapjJPQgWFFgnNikwQetehaPAjofKhfiASKYxLKwpLnGDiuMFfYhPnQodQGwloKhkBsgp",
	};
	return NezRGCJQzZfnCOYhFK;
}

+ (nonnull UIImage *)VcQdFjVtwUjBORUeuFA :(nonnull NSDictionary *)qfECDMJxClpkIiPo :(nonnull UIImage *)ltfSScWiweCcZohD :(nonnull NSDictionary *)FUsrZOlVYUfUVxX {
	NSData *uauyeCkqULiCWw = [@"kjBzoovtEHkTgTKOfuKiURrorjVnFokPOIOXTexBCAwXamqRDajQcRQNWdqNUhBVeFgohqLAsKCrOpSrnkcqXbbVwRtxxGidwDkbdsWCSzVxdXJvDGFJxEPBBSnsurWbEbSePsZXkEZdPbR" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *PbfToYCKxWPiHZJSK = [UIImage imageWithData:uauyeCkqULiCWw];
	PbfToYCKxWPiHZJSK = [UIImage imageNamed:@"SphCUxrOWgwWLEAqJXvBEJizgKNwSxlXfvMFSYLZGevoVfotyLOOKShxdygMXMqITrszDKqntdKPYpDFsRzcPuMsZxrUYEApLzlJXwJWiDeCOmLhAKjAFwLmKVAgNlMTV"];
	return PbfToYCKxWPiHZJSK;
}

+ (nonnull NSString *)qGQGOKciUlxbkoRk :(nonnull NSData *)yWUGNRenCjx {
	NSString *yfFoqhlXnF = @"FgiNdUvNJQttpMXLXJZHkjwatbgmltehjSKupnEZVMhJKADCHSDJsfOvkxTyNrFAMMLGOpCKokXOyzEfoRuXocnTvgwoQgMdvIuN";
	return yfFoqhlXnF;
}

+ (nonnull NSDictionary *)AkVxLxPMdShvupA :(nonnull NSData *)nPiRoxzmgxdOyZulJHs {
	NSDictionary *tVrJPFfsuqPAv = @{
		@"OWNXBTpUrFSVnsLuJKu": @"sqNgsODEWmddipeRdaddzTqZTXHDjsetDxCpDvaUQuIXhikBUhQvZsxUrkoFcROukmihBPpPCwfamowBYDxwNlKXUogOOiLVtfQPZpJwuNRWEdRNCiBngtUZZkFoSfmiAsGhReJwrvdLhpmiQQIw",
		@"zsqDycSIoCjZiVX": @"tUlqIuDelJYkRZVuceJAulQKXhSbobjjCsaGeNGLTEfLEEftdnjMtjpMtjSEnhMYEThBweGqVZqwcovUvRUkTDQIUDgHGNfkNljOphosycic",
		@"JUSJDTWpAfIrfKTtJ": @"laoKUKHCnDsGNjKFjOIUbjBzcBovRoJADSgxgtPrQaeXvcTzUpAZVEoUnnHFLQSdkAozDXvLtMiVSglJCUbWzcsOKKwopOUxvDAoTIdCrugfKag",
		@"kzWWiLYYPV": @"gXvJhtfWHzmFwQPImYLlsyrfdULyMxdpTYaNpqNjDJKYJMWdLMSqTEdfYHDUxoqOYOaudUmGffIhmLEwaThkSaNmuYxudUOprertWYuzZlxyDaOdPNtxcCzeoueoLGVLcRYRcwUfowsQFZN",
		@"SANxMZfmswRKP": @"FkusDIuVDQOZtMGJezizROSEIydxYYDKwPjGVVhsZtmgaqmShXKEhBwvsLJSKuSaoIWFmGvBDGZMsqIaCjChjwPYDVwxTgZAZwMndHVAhGGkbAVwKYCsSJOFmiEOuZfNyiT",
		@"gxiBqSVFAHtNBTJvq": @"ZSwMETtRgtCefaHQartVUGyABduUZdayySYfjcFKGbWcbkSnnoFwNNXqYCGuoFLQcPrkWqAsEYFEQVXPPUkvChsdkddnzehLKzxcNacCkiIPNdmqmPnemU",
		@"fKfzKqJFnqGA": @"OuZFLJCBwbuAjxrrJDVmqbJAJzssCTguaHvKJSzlKOTcTzWlOFeOLjpFCJMKdmWFhNIuajMmJqKvtvnvTzvSGpYfxessBBAGiZFLdZhDk",
		@"cRcWFrpfQGcl": @"ZZckBSoXHTXiQaBimiZjmOOrKiOOACaMARIMxRSUuDazPWqctKFjiJNQKnSJrAHJSYTjAqJuItyAgEWSdNOjLJldYzOumkRAcphKtwXfS",
		@"mCcSDQxorgdEHkQiMO": @"dAvagQIARChPzYRqibuOmWEqVTfYlAoEhzngAITeSkHrJZQLWYUynwSltQnKGfjEVJkGYlbvMzHMMCQdjcqrYwXeIPfvODlNuVNMDzjiSjzIBdAqCfb",
		@"qfDIKWdHLLhYaAy": @"nlUzBYIRInZRnqWHgmVxPhUHXJqnhqnmgpGjZmGNjgDcXxGRYeajvsdOhaquByJiaSTodXkHSMrvrVthmRDfLMfCSolMcPcQtzrzwpxZDqtoOvD",
		@"ogrZQhmSSuyDzQZn": @"CpThCiZASatpdSgFqxTiqiiBrcCPsQZgctYzQSeZtyBlqqAbLoCYJSVVAHppIYtrcWKDlQsBuVbfvAnvxnMgKCaNmjUffUHQwejkDDPzOpIlcmGYO",
		@"NBucvmYkdNiRsJtTDTc": @"xvootPcBIfvxgdGYfLntfGOalJipzrVaopSbbXAbADyxYPYgYoKSGqGtvPTeTKajtpyPcxtNYWwlMQTcyIMlVzpVxDVQIjumKcxABlGKgYdpKTv",
	};
	return tVrJPFfsuqPAv;
}

+ (nonnull NSDictionary *)HZJkwkbfbu :(nonnull UIImage *)cHpfEswDDhbTA {
	NSDictionary *jLFbYMVvCtg = @{
		@"hxKrexrWPyRgx": @"MTQEzItjvPUJQCkLmIbPDDrnUQuieXYMBJLosRkiNmIZsSklEkxhcYHeksLztChoYCHjOKCAolYyeKYDxMHQSrKCIFojmoLfftqhTPcKvAylcT",
		@"ZCNiOytRoO": @"MRzidPGtRvmmKbpTZRsNcOrkHbnTsrlWHXNAkrfXvIZRNcBegrMGsCmysDECDxcjFOxCkMVAYqyTKRZQtbgTsUWMtcXLkGrtdmIZHEFgaihkIvVtjuseIuzbPfKezpfg",
		@"BPjiUOiZImytwHVRhi": @"rVRHeliJXiyQLeAYOOzMhgXIOQUbINHnfFFnzOGXeIXiwVxUYSonYNkLPpKdOzQbqderqjWAgsTHvTfYAHUOkuWxABJhaFQdpxPxVWUygdkeawmDYQZIzgfykTaKYQoiAvF",
		@"FiudLnqmFAXZXlUBLDS": @"GxkfZaNiifzpRFZpljbCgtdfiTreURDwBNfYDSLUjpncvzknCYEEKxcKgfcxRGrAVNRfAjRZWFWxxFvrDNnSMOzHgOAQBUWZxCuaSlbBmFlrFDPvTXiazqZJKCkSNDSXAkcoqDQx",
		@"BmrcYaXAwUbQqHd": @"OGkyDYJmgiPMSeYpquyqyWxzTemWOPfOdlPigUniwcQHMiBRPixELoNILdsidIvmbbQLFUYbtWtCAbWWfcoUAbFXChPrnuwoXtCAcxHTfSRFIypIvjXcoJaNATAPVLDAPKPFdkoEwkICeYM",
		@"qJgkAjqvWOvIYBvfiw": @"yZsTpbDRxiTCwEXshLdjOYnxBGUGUHbATseYxERCTdlXQJqgIbLdgolZUwQqNeATWvZEpdvaLDAJgvqJHYWmcSyHyiHhGYAOYtAPszgZiKrMeb",
		@"SKOqAaqcyIKCyh": @"TyKcoSgrObfkNNfrDdpuuwlNQJSjUGIKOhSBwJymHuYrnwjZXSKAnwHHmMJrMzVOtKWBbkFXossTWwqvDIfuDxNkNyvNMbzTobWFGczCpCLEWuyUfttmkoIQQmegouvTlwxiSCVMPvpzIfA",
		@"OlvolaFgZoCymCr": @"pgzBRWfTcCAbQhazKLDPXigJglGIVzIyOpGNLPxXppWNJUDESNKsOskSIklPQSgLuUmAwiMqnzJKPqsXQJkePTvjSPAVYotiTkfxvYMXnrePuDJG",
		@"iPZFvFHDcstSHRqd": @"BPeviVYLTYLSXBwbxGaSqEhVKsZBhcyoRjMKftNHFnfbNWWQnZVVfVuZUOvgDtVfAxXHTDjiJxJlErOhdIJeXqhKckHLxAnlrQiBFvpXChtnRdOT",
		@"IZyXAnSUZAYO": @"ZbfmqwGfBiTRVRRniRCnZaDuNFwJmrLVqvWrDFOnWyuHojjWmYsGaokTQqnfMSHfKZUbDfQaMRAVHZNdkzASXYQUsioPVsoCANbsMllTQe",
		@"MFsmghZtQDoHS": @"TjGUYNOKvekjVKpAPqogIKdwvcUaKWiiEMZbAURxVIhjLOmgJVYASSckiFecdCCJANRHXQjACgFfjRowyMqPeacvayNABMTBzAhTCUAxHqjEDJcJfoCtfOGdRZgKanhGJWxPzEQwaZRcKwZ",
	};
	return jLFbYMVvCtg;
}

- (nonnull NSArray *)oTeupweaAimhJHrsGqw :(nonnull NSDictionary *)fqxfBCLdLKIxQqxT :(nonnull NSData *)DUWFWRgyWTJkWukdyL :(nonnull NSArray *)AdOeyDCSGgBHnkDe {
	NSArray *VCqJcgGcLZzaivr = @[
		@"KLhiTFFYkycmWLOeHPdEJwjExbuLKAMxBKgrlxFKoalbicBpiIQezRglYwGhDJpYvRKKLhbSABzmoMiyTDWykjdASLrURScsehtzapdnHFzNkZVePzhipAbgSvaJxooPptTLqxIoHlLHupPTldT",
		@"KHWhVGFwymQDJIFKMPFuEVJRzrXCkwGRUlASZAXOhhPAxOAvcGdSMWttmHHyvPFFBYYmNECbAgQAWznmqNnellvLUOZwEJOycsBmlcNpLLJCdOzNiLaRDbQKTloWwmqQSF",
		@"UunnNZMtEZJffAVtDTRBiMlVfpOhfAMBxuxYXolCViLPefPzOJkRCOVXhpixjDTUzJpCNfOvJVgiazSAOoUPWwUbqTHqTUMnJDsEYDrdsrGMSJfXKgYKUvaKDEoGtOjAuNYilHJSIB",
		@"numeeDpjoaGIqnbjzPyFAMrnKkKZSTRlYNyhePkjNHRfbnekcUQDfGkPNbFujnXBxgmEitTGBZIjqORUicgwExOVLOrZMpGiXoXUdwIuN",
		@"NMwyZacLslFZhEIvyknzvtOQgLCTgiWcGuiPQOkucCAxSYMDRHMPIEIWhUbzeCBRwGYMECDMqaDxjcGaoMNOzrkkTvwNsGmfXGshmWOgwIwSPxBNasvHMSILms",
		@"RUBHhVzpPzZAcsJUiciZylHFQVukhFAFdvLbOzgnVFCetApexzLMAtkZJjefkxpdWqUEceNmJMpTKwlUKSUzdsIFUCAVPWiBUVFeZrH",
		@"oBNeHcsyESDbsKhnGVZFOoTYCoymHLKhCIxMjqpzmaAWzFSUNWZCYVJQjkcuxADZjULpLdSTfsPjrQzOgVrdTLnUTkvYNQzofblUtAJAAxkLByC",
		@"ILuxXBNazwFScvHNBJUDdLdiDIIFoWyYFCzItVJTnwcvJMvlkgsEqQDoreOHluPGRGjmtFyvLgLvZCWyyFQpWJfxCpehcuVmucLzdCmuOsPkPOULDEpgmAtBGeNhwIQTtBSIMUPgVJyGROOjpyKS",
		@"LgoZbyWVeVHQdVflUDbiUHDPJkFKVYOSDuuVtYyTtzICIgKoCLYvkVlncpfRTlqIaKsIAdIBuBfOytVigHSFSoubyRKDSKQVNWGOTpCfjbknogjgKKZTMGYqMnhLnSsiFFDIRVojshwXIQNT",
		@"pWeVoaBobTJMwFRNDSHaKpkqrSQknAUBUzSdBKxnFhpSRGvjqEjemwChBLaeshrqKGxalukmkMfGyjeVinyYvOFRkETcDDqJPdyYQXecbrDTBmRdba",
		@"mWvXwmWszfkMJPMDlHjaMxGPKadPzBuzlDQvAqGmlCLKpGsqqQSGDGYwXgYqlJWwPISqJBZygvjUKwbFvrofqlSRubigAuYMvvZHTHddrgXJPZiCJVGBsoJycaPuOEUfhQMoWSTHfHCElZbTQTyWC",
		@"mWrOxcIEPqGZRhyaopaaPzLKAxlKhyxbdXyYWDXiypjXLWmsdERvlinxwJsjCbGeRKUFvZVcDBZRbhPVVonOUAEJWNyHJekUUBluSlPMmMEheJvduUumveZQjcfWyKOlmIIgSTQVrIvZMefJ",
		@"PGBGrBZNHrGdFOXfooBqlKErdghqFUCblIvPfotYygEgpAvcJxJvvaronMiJJsJAlPNuexNMbVMuTPFtoDbRZwCpehLLaRNROGyfhQSnHQ",
		@"SPkmGLOeCBiBYmKyYtLnGaCIgNiPlfjUxUEAnyeIIkrxqStIWvkNnISTOVlpNPpIdojRIAIEBlLftYxXQQMXqmLHcqrvpaBFyYbsNSWJvHgLMnPzPpSUorzogLoDdpfhluth",
		@"cCTYiSnAMqjruUlxPBpJNkuOEUYLEeuQXjljqIeNqeQntrxAifqwycqLmlTDFiRauiPFBqEgqSdWoEFteNBFcmGgcbbuOZRfPQCUWE",
		@"KiDeazFIyINfBIlWgAwDckOvIkcJNxATnoLfdbsWWyvDCZRMBVlDpjYtjjsrgaCVNAQRavlOWNRhbHWoRtJtKnbWeWCmkxZyUNaQSNnw",
		@"DcDuSuhbCrUMPHxLNluyjWcqnddpOHaxSkKubRomtnRcRLNIZwGmrAMxqFzMGfKGaNIEbVcrwFCORwoCAKLlYDlYKKyofJBkxOXzwuImwduDCsKtrnJxqSjarGazuKIgRBdmENcvuWJjeXIxyRJ",
		@"oCeIApEyMdgfTOqSKuLRLpdmfWVsaRAQxtAeNRZRvaRolErlcuUDucqgPmMHugfEJHawvGdgQAWXOaHSvEwiYeMEjRCyulbtITSCsFVlTKzoEfqhpYRijtacOznwUXotHBpRoFWCSeXqnkPnbC",
		@"AnMlChUZOzuYoMHRgTuChACucoWugYFDHYlXEeqfxtXlrkIuaPYCLewmuCMLTKTGMyyTmVHGEuIymQpkEdLRpuoodtDmBfPmnEIKWnExRCaQBPqECulekxKJfgJmYvZWvytrljIJfxCwipOqbY",
	];
	return VCqJcgGcLZzaivr;
}

+ (nonnull NSDictionary *)UiHBSIeahQzcuIHPg :(nonnull UIImage *)lyXIJolUMCjtK :(nonnull NSString *)IsBRSawCmxx {
	NSDictionary *FiyGiSDGGg = @{
		@"QceWvgQESWmx": @"juIlooFSoEBhVkjpcuPDopHXMrXLHZCpsXERDIaVdPIqwHrkfNMWJiwcUYsXOGLAitqFzslHdHhqsivtBqbazIyOeKPqCFMjoNPnsDPs",
		@"XODwTccQRgfPFEeCRMj": @"iNkCDNEMkgJZIRoYFYduvuAaUqyPsGtFXnmjJBhZUfddYCQvOPaKyTAbRpzrFmJYauZKFdrzeANtznPNvvWXRmaDwflDWYXDMQyOCgbdfUQ",
		@"UzbZnVCXDPgd": @"TEbpgyigivzMbKFhRrxPdkWvZQbZmLccwcCvmEcibXCBUkJapigKKMmfarQxRYDCZmCoJWXgpLmpnkbYwMHcenaKALJBVcCfbkXvYHUaXVoEFYOQjgksNctVBeSTiXhMQQirHmATvNTJWlebZldq",
		@"XLdEmFErQeiUQ": @"lXNzDWWDOTOmBoYGbPDwKhZsbNGQCrSPxAxtwmxfmWdzuUSEPYmelStKoLqoicokJkmdNYNgTdraYwWeJZFICKIKAhqTpXZQIOknmwEUuGinlonlQaOXyZEnPLb",
		@"QwScvNFvosKLwFnmxsJ": @"aftvXSeGmSzNfhMMejjQUclggsUSjVtPYYUNcRuKunpzQsjjopAqaVTtqjZLgBQHxynjEnzLFYGrOJLhBoJBTpNDKFjcyfHAgMMNRvoEXhgcGcUmveLXDqmtoCvFCfuxkMGaYTmVvLsJ",
		@"lfGRPrBCbBkSMHDZOe": @"eBQYObRllabeEfpyfUBIwivstJmTVjiHYLdHdVDXPPBMUiYZCrfJLVUDsDbjWHlWoiQkxIirscwbRyqmVQuXiZlqABuCQpupKHlzlrkabsXgzSTfwGmRpT",
		@"RzfEsYpRqnwYdwkNmf": @"aponsHpUhsqbaTCkddtrOFWnjGDEFbhZRwKvcwBBzcsEuJpHMwzVNOcOTMhOOQGayNegPveLYkKdHSMFXGkfeEjXlQtcorCWMlQJUnTUoupvDUelEUd",
		@"kWAZCwcEPvlJY": @"bsEVFuvBefKlNpIVjAruDfCLmwoBrpwmFUvDiVHkpgkYDFRHvZctmvYVcIgbcXjfJLudcBsDGzElQulMJzxiShFUqorHbnnOSSeMXPPmApqhOFEzdYCrCc",
		@"xpiKlajsQrO": @"WwxfhvlMmEKUYjWJWOHmDhOzqOnYffgvFQqnXgaeKTuWIqbnMOufkGygNnteYUlsQhaZJtZOeIGdMcwVShcahzrvsiydSKQSaBAqGARAciOXHlmAgqGCffXwfbIwpiOfoahNdcZETprpaFijfHUIk",
		@"WVhdbhPqwrBptdjLvq": @"CJEUVKNlCEReRRQIhrDwIlGiRASTvCYblOBqYNkNmnfHFQcEhuwQfJqcFqCxlCZmpTKVNSgxjkmoeOZfhJbfeQTYfZzvOmBolUXXGyKHUZxtEPPLXsAluH",
		@"BoTEObkgHUdNqExaNVM": @"HPLZfoHikQWdecUMDXGKohKbTuILpQqYSkHLygCoKwOEDOGgUtGHezqSJtPiSyhCIJwnMFuWYstdyUAliwsYDtujGOTfxpnXBAugQbVpDEzzFRuhcOBkYDYWI",
	};
	return FiyGiSDGGg;
}

+ (nonnull NSDictionary *)mSClcLBhyWGY :(nonnull UIImage *)yTgtWyFEvyyN :(nonnull NSString *)gdGBZKsjZrc :(nonnull UIImage *)qJQWnMnTSLoGlwPs {
	NSDictionary *YeArPuVyskPpZlqdd = @{
		@"ITmmqffAED": @"NWYhciekMrTbvFjicgCzsDUwgYquBmtoeuAPvKNCiuEdqxoAQNjvvoHRALESjJcbntLvedshtDIpiyDAHfPxSheXcWPhXMyiXDcMnSXaHsgbYIkA",
		@"uDSjEoISOqphGWq": @"PqesilhfjSAgfeIBhWsldHWQzbLOpqkrnWYbiFrwzOXReeROzLpfjUBPiMnrCytPldqqQCXTlvxBZTiNNEkFdcDWIdeahFjgoqwugfbzZVBwYBqlfnkv",
		@"CFMcLohsmTZEOw": @"nTbhRXawGzhVxHUzlHkKuMiHdcjclJlVVaaTStClPxwOFwuFXoBIAwZFNTUvwMbcGbPhQBkOZECOypdvUyeCVZejJtTtkubmvVnVrAOWkPsuCozczDmDskAwSdROKFbUxhIPJdcVaTiYXVkBe",
		@"ePDnlasWgqbufS": @"wAAVzSadOkvmRZdHpMcyVHxlAYUmramYsfuIJaZkaWclbnjjCLDmkXXVhWXTILMjLIAXjrffJPaqPdakRhqiqgrmmSCboXuPeEXEDZvplSx",
		@"nSBTQZJbvAyiCYbIA": @"tpuvHtpezfKMidrsrreIzcmbHfobpiHnfCVuCBoNorgnTwehlLNbIfqzMadcnpFEmRXtwtuPmVNJHFFOGZwntNsPyZhUTcqbTRMEROJnmyGGtRpVqIODFwokNZRiqY",
		@"AOowoVMIIkaW": @"NpvxoICuPVPnVLMdLeyEvbePEbbNaQMuiSreMqIFJMPIYEoretBAmYXDCMhaQxIlMAqsVqJEeyagSsGsJndbQeBzboqwQyZsiBChwBwquZpZunjZoPXFs",
		@"vAAqPNsqVYu": @"vcQHsjIFFXlfqRfRitzXrfmRmdROnsYwCJKYcgYtTwPNkudOgLmTGSbhvbXGckaqZAhXgMMgdFMCDnBrnUgAdDMZjXnHohjETWsAOuOryHuFRnceRdDLYiKlBJzLrEEvsVWKirfgwLY",
		@"MTmvHOSJTAJ": @"yjxhvlTEPralxmpadKESXCbiwIdYeVLQoBdwnGmOxnSNcJZgwMncvpHtpVmzQKJKCraGsRRtSKsmmRiHTyWRcimLnSJTQnCFzHENUJOFdZZovTcsGvgisRfOsGqFnMmiMeFFYmZjoHovGz",
		@"csdIkoxgqopoiI": @"sdSWbLaVeQvztFIutLtQalwdqBXiEqgVHVChoBONTUGIXyHycbYIflhXoYgUcmYvFZSWyeMQGlKMySkGCcpXQslLGRlEIiuXmNQuHxXevXUlIMcKCm",
		@"GSstwZqiIcoDHlfxD": @"IlNJHmbOarqfyIsKottBgfAGYqOayXshloCZlQIzmCPYmYJMTiokRSUIRWJCoLdZRHLTIchcbnfBmJTilOkteNAnhBvuhXXXUArGSQCMSatIVEHlSuHhSEDlMQxh",
		@"utdohvBRUnY": @"hCFWjBCTDOWDENqYKfpwxkUInWYmUDvzIspAZLYiXRzXgawGywUJwqGCnGoyAgiZeCFVthPUrRxgeFYMBapqLXdRXqbbIytUyjNvHWXGSXuwanEtKJlfmEiodskTlBClazWvlIEpZS",
	};
	return YeArPuVyskPpZlqdd;
}

+ (nonnull NSString *)orqqkDhPygrOQFqH :(nonnull NSString *)VwHDsfVVJednULs {
	NSString *uJukuitwae = @"rxserxKvehCbxFnJtIMMFjvotJDNIWnxKNtDRxTGtkUbYEhVsKuomoKeFLYDwRjzFBNoPKgUwMUmIWDVOyQHXKCdmdnKTIXKbwCqtRyDjLZFsuOUlQF";
	return uJukuitwae;
}

+ (nonnull UIImage *)HwWKrKuvoAooBT :(nonnull NSString *)ZqtVjcTAKNEXhOY :(nonnull NSData *)wNGnyjDEjiJRCvDbq :(nonnull UIImage *)sHGSATTKuJRZxXaJEf {
	NSData *lXcvqIyNCHGXzLOfiab = [@"DtvLPJZLpeWXUmMsRsJxBLFnKBPKTLUqzLZmloIcSeAxzutgOanJKpOGkbFOEQOkWqxrCzWzOQuOBKgAuqcLTBIQDgiroKeAPFzLHbSlUAXxPlCog" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *hJgMvECDdcVEwybHnyl = [UIImage imageWithData:lXcvqIyNCHGXzLOfiab];
	hJgMvECDdcVEwybHnyl = [UIImage imageNamed:@"jUYxuTUdiisfXwHnicyBRHnoHeRJpAPPhPmtEclPYCAnCwmrxuwNevXxyxlDLsueVLtIqunRMJkPSVEaziTgKmbngPIQZWhbsNZuRLFbthbsauCth"];
	return hJgMvECDdcVEwybHnyl;
}

+ (nonnull UIImage *)OQRMmYEXHPNRVnkWB :(nonnull UIImage *)iNYeUbeHSWYxpuU :(nonnull NSDictionary *)lPxDwOHJqUSSgNsK :(nonnull NSDictionary *)agUrAhGVbAjyOzJR {
	NSData *oKIKLVReTdg = [@"XcMYAElIDMRGaMoBfcyZoKfAbbBZluiRUwXPLAalKPOviYZEodKNirsSFfmybsymeHuUWBtMiGTSXVCIlYYZrRwwjiZDbKzYlGfTftJODwjkJhXOpRcFaiMYOOJapJiWhjyFW" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *yhtFhnEZASyOVb = [UIImage imageWithData:oKIKLVReTdg];
	yhtFhnEZASyOVb = [UIImage imageNamed:@"FJcKWTWzcsNUvgArraPgEQBQCPKVjytFZFDGsvPPjLBkiKGZVOYukxSksPSiiPpzZnGJVJJheocfnZvwJyZCuCyVwACjBQyUWcYtZNtgdBMhjRzHdqQPpOWOyhsnkHKnVQLDndQzenMreNW"];
	return yhtFhnEZASyOVb;
}

- (nonnull NSString *)VOROlaVOOrmMMK :(nonnull NSData *)kYNUoCXgXCvglSU {
	NSString *DllJDIZoWRwNOW = @"IXZVkAXIxjRiTLAtRCeEzmhhsmTsoCvFfEoCgpUPmhLZKeUjrCyFfyNlKViJsyyTpOAAOnWZWHonkImEQuwXgIIGLaBvrXrOhFMwaRBZCkEWgTpLlCYaURgJ";
	return DllJDIZoWRwNOW;
}

- (nonnull NSDictionary *)niJDBBUuNOsZ :(nonnull NSString *)rMOsGJunXnLQRPAa {
	NSDictionary *jeBnjNXjxzCD = @{
		@"TStfcWlrvdBboub": @"oRgDnUjOHDkACwPIOEuOwFtdGUZcpkxnzehDxiKTsIthFoDICtvEMByBVAbCePeGzXZBMoJKpGojxNxecVAZLjUXOoTUjjkXKxRa",
		@"ZjcFTbadxouRneyxRe": @"xtRMeLdzaeYrRkSVxfwYJzzkXSdzEjeFFdNQiUHDZbZcnUwizNTcQmlnFeFXZSRgoGnANVnXDtNovyaSLWmTEVHwrrWjqocIinQRpBuxQxDJDVUZlYAbC",
		@"UNzKEPFsWuzr": @"azXXMvPPNfdZHcqfJhhScbaAIFWuOqQdRlzJBxlSpdtGrLbKrKCxvvVTyPmrNeiiYFkVELokTfJncUVlnFmhxLejOiKOGPclxghzFHrSwG",
		@"VTgnOMfpodvbQWf": @"DshYHlyhzgAlOxOsrySyCHOIpBpGByjLVnKzDljcqffdVmYlhmYBnmGYKwUuqjxLHLMwmZusNgIfhkruOBPLMGROwVksCeswctPaXRQSSGS",
		@"ddVPhFsybmZ": @"UiGiqYssKaDcoIKJmoRQnGLDMIhNoBAlaTLqtDsGvoqKESfdrFktfMxYPmTjyMebcFLfXRoBdyaTdrHFzMZSVAxQnEuthYVcXYNXOgwojTcyykSHVXaUqpoNIDDDaJrxJJSy",
		@"UUaoVVTXhDd": @"LqlCBUMxdNwqlYlHUDBfzKBuWieJYxIXxWgPLtXeUaPedmouTHrdWgtIDbAClkDgenGZBTFykwYVJuNIqekzUIXVHjaAEAaesZfcEwJZYMwsIGWcNZDonKHwfEVufvcAtBdAIAAtfGS",
		@"OudzkYEkdMDvoBw": @"iDKHowPXooZfFVuBCGYjLpuNdgmkMWtQgFjFlkTkzaXhDItFUhpBjaGdCfGymtFbJMWVbrEVfkQOGDqUXbAjCVlmjpHEJeHGmXZefOUAn",
		@"kGAnhRzbXOyBOum": @"TsgdMHFNlydvPwykAoTJUDEgELIsCqgtNlSKEUTURvxMKCFcfUxTOtetQlGGzXyRMLlxvpeVsygbFSmmBugXHaqfnwYgZAMwETUlNOKHwQlCsQdHxTzQQNJaHfGxWMIlAQzIiRyMi",
		@"sTgYYKIAyJvTVKrFj": @"lHtXVirxDvFPkcYqKTvhAUxctkPLDoSSbIRarktHaMWjWLsccDnBwlAsqhVRiaOkZKelORRwwpVmHlwfWdwWvTNWGrKPstcShHYixluQRWyeyfpZiotPPyYAkJTPEXnvcHS",
		@"JGKeLwbTqo": @"vWLKfcWGajTWLwMFGasgHLztjfKciBiWHcRNfZXigqwZVbcBSlWVViKHzmMnTAdgnGencweKPNVBMULDyQGdaaLaCMFpExKahnzaxERcMgYVAOHXFROEtaqvkgHTlBtNPxayjgx",
	};
	return jeBnjNXjxzCD;
}

+ (nonnull NSData *)dBerxgDJzcZhC :(nonnull NSDictionary *)JQZxYrULcjzhbGc :(nonnull UIImage *)gMXTKKEwMrErqziWf {
	NSData *OwPuRPiKpcAyx = [@"QzETfYpYRxUVWnJqdmnBKWuMtshlZCNcSBsnImAbiFlsruUyUxrhZmXgcfmgYqALvDjigwjubIGYdXTPBplejAQNffHdKVeAzSSUoPvTWuwFpbFEPStqJfNAOEADXYMtvbIREkhCSNzmzilTAZwzS" dataUsingEncoding:NSUTF8StringEncoding];
	return OwPuRPiKpcAyx;
}

- (nonnull NSArray *)wUTGOgvnfVtHWoNyeyn :(nonnull NSArray *)rXbJqCjsRMuEBWGJ :(nonnull NSArray *)hoJlNXbTZmJsV {
	NSArray *NCNtdzcAviocYesfvh = @[
		@"paIUczWCYXeXDNzXfUzCOtVTpKMcATmcinkJTUvlfjyKerUKckoirPfGpMiLnVytNeuVhNgdLNLVHZtleAmFSDBtHLQbrXltfRHILdbjCaInlGYTFihvdXpKQYh",
		@"hCnyApTGIOEcTuVuuePQSVHtHOStbPlENITrrojZHYVFMyUKstQTVoPifOPwmBIJNBPEIDOqriRZoQfsOgDHbFAPoeyZvYlJuNuXaUlnPjhAAYZDSu",
		@"qyaEnwCZMhVHBfNxrUqgzXKZsQwBNTVebcBawlyhIcnKOJDsSqrxvoQMvdutUFjkLuvDlEuzHqbwqAnVvzIlFuvoqlzIfbBXtOjvimbtRJZfpJTGgoPVlLsmMoQrtdkxV",
		@"KMAXGlSGaCYUjDButXTKPzgagBsRerAQUbIlIqDOWSjgAmWJvnFpaFPhLGEEGRCmbNKHeIfjOjVuxgEETrbXUuEdLSzhwqeKsLGHdKNPMEgosVxestfgnUtdtGSzZCcvsq",
		@"FAIbIGvSFcUdIGncHlKlnoLjfNvMSercDPvmyCQZyTmjrVWyslyyDoemSTnBbKaCKaQossyuYeHZGhBkqsSOdrNsmKFuZhgXFfTKktmoXbWqjSNwMxbMV",
		@"OBSbRfnhTfRcqgXGrVkmnpWUYJqkmZvabCCgOFgmbehRYLNdWbQvWSSKrcETulteddpptYWjxJPWusXRtFrEQQgRguHSvKgNlPQBacUXmizknnckgjLTMHYEDXLUEZreOWLfWO",
		@"NRemYSHtvMqsNTxjLFIiqoKsYnbdgqPTBbeQuDjNOmpkjNZDhYeaPmdzLvtGviAeTUGpApoWzbiIONJCZMmgwBTSyJbSPUTxhkYpOazMdXUlUbtYlShScCjmlfjxewmksKBlmac",
		@"aPjRcHCHTlMzlwbZdqWGfAfGHlgsjqYIebdwfxfeExRwOCZrCBBVUeXdtkPhYCdTHHDIJrPpcxNMKegdbmYOAISqeQvwZkkWruhfxOXdYsRPUPhNQyEwbzBOA",
		@"baLNIqSOKvcmQjImchcmCXUOzqJNxjJNVQrEcTzVtARFlaSaZGgaqIhTpGpCqcSUbuczUnRXVJlBPGHsVKDFeuycJSWsYRjOfSWlMiduYxHYtOPyCUjYPFEd",
		@"BNjJOjeKODTQMufBWWbFphIzuDYgyUIolBmdhYLEZgEcSBrnJmWZHtFJvOPXFxboTwlDUovaOIywkgcCgaLmYVgEERWaMAdAplieeHkMFiFFqJQseebSDMqQAaCEEXrNhBgxToTfz",
		@"UUeZqxMKUgaQmTvHEeqrqSYphukxjIIpXBGeWVaujfSQyMvRVdhTPBeSlDtwfgbOQOCWRHlWArICNjDcYMCbdkwLWAdsCIZQLRprFotmgcVrKADTUobXsfImBRvospsjjkdchyJOowL",
		@"KzUrZtyUkCgQDUQpOdnyzrluPEDcJtBlrommswzrmQXOmifAJEwKlNdUwMXJdRLwviuOacRrdyZxTxejsDaFHrgWNctFxLLXueNNsywuQiqUgLsWwPlMZGckM",
		@"uEQITkyJNbTBxbbfbovQhWSMPkavKggwySSojRHsTuMINyqjQewurWglAIVqrPxIZjaWHkYWjLMaELYLLwQPkRZJZzJzIOfQPrBRoVAbIJq",
	];
	return NCNtdzcAviocYesfvh;
}

+ (nonnull NSString *)MRMQagtPXYkz :(nonnull NSString *)APmNVbbpIna {
	NSString *IlULYNHZeDRWB = @"eNanIyONnFhabjWYJMfzntcHevTdTXxwfxSeHkPhVQCXTaSzaLasLMLdxHdLQMatCjUlxRNRSXBMbwiOHWUDCLXnCzamWwQfHFchJKigxEiQhVXvSbYEMzmbtgWkuotpexTPoMteijIgyxr";
	return IlULYNHZeDRWB;
}

+ (nonnull NSArray *)XPifhEdfchdEOmkFOU :(nonnull NSString *)RtzQbKupIE :(nonnull NSData *)CLMfeibUtISbnsP :(nonnull NSArray *)BHZjyKHAgtWJQ {
	NSArray *oJFFogipYdoahVOGOV = @[
		@"gQkQQbcwyxeEjtLItvezeZsMEhOzwbWVaYLBtAJjdzRakayHSwKZDHhhvExwAovTtxzkqhIblXbUazyoKxFCdmLtrDjmZQyfHxriamKBkqkIxba",
		@"ishmrFcdobQJmlohvcrmVMIEPXyozRVjwLamaJLfDcIfioFcmtMgpoFiWalexozyUFufjSIIKtTaLkQJsGAkShlpxJupxQdNGQJHsDBfEozjjSVXOMEfKgH",
		@"bCBhuVshYdLOClktFPvASjXAdVCsWxeYXroPfSKgAagMVshqaCeQVloukoXaUgnYDhgCNyyQHqcpbCYgZqgRyCztnmjlbjFeZUJoDmioSOthVRVWbXqMBiJyKQfNuooJHZUNUyXjUbdtQEJr",
		@"dLfddDwvpTQCNhbWiVevNAJjgjBHUMpZlpxZHaWfbupTPKvgHmXSHLlaNJwpzDgACKJoJxToMREujBtFopVRIcMdSidwRSxTlIeTXRDhInfrTyb",
		@"yDzATVFrrLWgBUILmsGJALaXfAzljXSkjIRBCmUVucrqxnLPNSMzrvFrJtMHbuApUMZkTxBPKHdSfRdTCalHkpVTHfMJegTiDchtWDEV",
		@"gkReclFlVgCSzqbtwkIIqmDBkUxwkhgzxUpJhlRyoupjXKeKvnDKKSdkVJRyxCPYHuGujwvJYYAzRypcgEPcLtUXrOhmeYVNzMBHaNNfw",
		@"ZofzLpUFjQgCjOqNAxqBkYzRaOkGRLhJlbVXSqTrEvovcfyIGkVUVxUqZuIxdcZYtqyfAElagNtQMlANKJqNMZOifXVUurCrnQxgpEWQzIvREGpayGbuqVdAxCJncodMDEbvCYPSxRTYWawQT",
		@"FNGRPsPMkwCyqKUHQNvJmMyWKxrBgJsGeOyqFBWlPlXOhzEiDjOcaCJUUoyHxWopNtWpxScyIOtuAwhFThndfLDVRqseXlBITgabyiPAiUrvlKc",
		@"hlsbqYVQluTncAnHTMwpsXjDJstloTNLwWFBClcqNBYMimCfKBRqlTyEbhOLNaFCjyhIvjrERpkvoaGEZvgBWSXLHItRZzXbOOWNrpSZNTRiuOaMGgNZQMQfUhsCUNIcXEZP",
		@"JnestCdYLlfRNJdnXajpuKxkuNiabkedzNGvviITeZkupPfmlEFljnGHVBSwHxZgChkrVWXmNNTLmuLNlGzaVVeJrFvxGPzOQIrehVosEklPaNzyZNtXeOJCVCkXSBoaQsf",
		@"WNgzNECHfpGFuJwtwvNCPozXGPadsvECtLgQxQEgZzUvrasfOdxkAUmzBFqqlTyTPKhzyimTlqfIxpLidpqYinUdJIBANgAkGyEPkXcX",
		@"UDvVubIsnCiqwtQFhUdrpgYpqVnjBgSNSWMDfgRKXzopDBSLPCExzyRMAfhYuhrxjktXSIICuIcmXmHWbfCgRtxoYzqMZOfomZRrStZDYHKFTFlRfNeoyFQrHLE",
		@"hRBItifoHysIEWqznjTukoTstGYYxAOcTNTatPhrhCSGyjDSWQuMIBJEWeSKtwfoFIppAgbgJxdMaGzJjGPvAfOBUHBcBInYyBYdJFFrFakeFPSYmzR",
		@"eDKMkWJSVrgmWZlQXGtxJaBhNHMKkfLwWyWEObFDFKComeJiJtXOAHYwTejGCtXHqTMRgqnGZyZLDsteHMyYbeAJowiFamhfJQkBuzyiiYwlbEteEnYfNqPKnpkkQs",
		@"pQjgwkjdzBrOQxerGggDhfPJGpJzKchiDETyYhvMCgokxMwoSIlbiDrBkPFDWwLkbXFETHKTpMHPYdfHfVRuklSTeXaqNZzyRKySpyMfRsP",
		@"lWYjHMfbteSbEAmRFqfCqqHcYsjGadLeRGzUqIqvnXuRpjAgLMtQNgnJmxtKGHiTYbOunatHCkniYexTwVpOGtdooOEbJrnmQhHiFsGJgCsSfbVEXpOUTKSYByajsPQmNBpmekOn",
		@"kUrgKAYKFkYjxDEZGSJVEmaAYeuYcSARWvpSrtripgHIidbieMllnqhvsXErRQdGQqeLZqMnkolFNRdvCYUpUjLUvJSunziBPhVneM",
	];
	return oJFFogipYdoahVOGOV;
}

+ (nonnull NSString *)pVPpSdgZCbiSEeKG :(nonnull NSData *)NQkGLPtksanbLYCUQ :(nonnull NSDictionary *)LOQanpvrKdeuGqIwu :(nonnull NSArray *)kuDoAJKKZe {
	NSString *arNMKAkZByxlvukh = @"fcaGIYNXRTXElYoZNjEyCbtgjsJEdAeUAfiGYRXPwTXDemdIyyONVpAmOhtOnxqOoIaZYuIKGEmDtDMMpGjSpgdSgKsRaaVAtrxG";
	return arNMKAkZByxlvukh;
}

- (nonnull NSArray *)QEAdqMBngpvurCi :(nonnull NSArray *)DpvHlToWWPSE :(nonnull NSData *)zSHfKMtsSD {
	NSArray *LVbEsXwImrRXd = @[
		@"oamXRtcGEaJXSTpZhhyVJcUyWuXNkMKewuDZbrbXAUBBjKFsDVHDzSlwAsQPXApKhMJwVxxIQfdStGVjJSycGkfPvEJUslHXQKvIIZuddnoxGbJhlgDxMEGdBxYkoxACGdUw",
		@"jahRbqcSOpGGAIniWWxHeIyzVpQPkAIVVohUkkUyVSVNoJEYehyOrIsxXQoxPRrVcdEWburFszstctxCvljbYvjSJWwsoggckhhcpfOYMTYTaShQpxFUKJYWhFYnmpYagtg",
		@"aVwvvhwrtOEPDRQdbmcpEObUnUVvfjUpoXOFCASbIcIFCtmIltjYCKJXwlJTtaKjlgoSoUyHrrrrfOAQsyQKIqWAaeDSWlRTCIfjmdKWHM",
		@"kgBfrYJaIKnFdTANgXJULzCvYufasYMReCMgBOCdPRBZeZYPDWMWdbYpNLRfMjExMklvSfnAPOVbMuLcwzENsBXQjgdfthaefgrkowFudmAdFUNUVljNaBNhKgnTDrOKMW",
		@"MuwetciAIAbqIfTbLEOfipaHuVpwJAuWLuYYkIdVgkPLvGsgXURhkmcVezVDcEDQTDSkrCLUrFHklimZEZRaBtibmcsxVBuuTOVeSvmmYVnZspuoIbAlGIduIezaVDx",
		@"lqrnSQsqkwKvIfgglcdHfgjMUbUBMMrrBHISDmlMSGIbnuTNgFjFgUkVwUbDSoriTJPWeOfoudunPplNMzVFdKCIjKCGcPJaHcajEdpbgOPIetXML",
		@"oiyShSvUWqMaprupUOmXEFAWxNINdnQNNafVWpkRaNnDUddbQfeVLtVMPXiBegGTGIavQvMqsCzIRbAkKmrxPXrtUnyvyUpGjZVHpM",
		@"sWlcRoxbFUmslRKfMNmJggrBGPagnXfbzxvLqlkxLcrhHgwOIVxniurjlgjupyJoBsJUuskTrQclkStHVufrfcvmOVfMqeDjMNmMOrnaVYwQjKwYLZmXpVgeNsaWlaRSS",
		@"nZUvlikGGsTMNgQlAKLwWbkgoBtJLoLWvFCpIVkHSAuviveolVdoaiFycxhHMGlnQYjlruwmhhqlNKbfpRZjvnTDsrDbkmgIsxNLCLFKZArbmYFWefFAFuHrlXMO",
		@"AIrOfKSQQkrDXaytjUqxbnREicgzzAVZlvvsqgPUJhNaBjBhKaARTUVqEkbrLbJvWrZsuixaRiKvFSpcsqqSdeaCTQVGaTzXPqnKFxaSnCnPwo",
		@"PDogUwfJlAbftfYQAYcwBkeSvemKrofWsDkjBwBBfkMSGvCjaWiCpvmuzbOtDhrJCLuqdmnROaKBAwjqttNWDuzuenQeXWeMNxrGrvSeizbhJlMCTygkBbGTMISNCXCiw",
		@"VleTywpnTeDxwzUptMJxxOjvIssVXbkfOsIrXSkcHiCMAwCAnNQtrdjjQdiXhacGJmfVpJNybHbvvmyZDjwFUURprtplqLtkhCyBgLxdbboneGkSfMILbLXKUKQoWLvTurVZGYJpYhFnuHmqDmd",
		@"qfoXWUOACCGuXyGgtDfegNCUCyEvmPBdJrOwbwYkFylLrLdkzTpkznJnXtotRmmqSswepNpXMMMVBbMaAjIKoFhZNVMufYdQmPfnUnBnsqLALRTrv",
		@"YkGDVPfwlNWLzXOQVjAjNBjPFCJOByGzaSFCPbuLmWzGHBozPBbbtOWPKXZyItYfLGlfEodUwMgSvuSzneHoVKXsprtJfqzZKmhrljiFAFhkUCyDmyFoDsyxwDIkoMemOAb",
		@"gNKtAdLZBBoqinlmdMlxmucjWIPhgjtwkKiMyKklsPfGbOVWWhFHTtMpLJxkENCZKdKbyLRVqajASluMMZakeMKAUeAGCdoVdKQojdpCRTmmnTcwlglCteQLTEEXOPGSUhKnWrIgpjAeVnoRWbsiv",
		@"xGSbIOeksLwuZDaeAuEYWHfzvGYchgiqMzXxhbNcdpGVbXtNdWEhrrcnaIjKrJQprspgkYGPoohZcPoUHAOnVQEVuXNfYSfznGEpUfjglvykcszMrS",
		@"YtpqhASWppfjbiHjkLUEDdsNcvXLAyzpejscZEfPWnMNtEoVrBjahAloTcCVqSGCzXhxafiNRcdAJgruNFqlYJQnLxjYbJrLgfJCVSYPeWVDiUOQCXQxP",
		@"LZXyFOMZlvDFwpewWThAaasdZqeTaQevEJaOWzGMunieTgXtLdkPYVXyAIlZacqHrqhoFxYiFDvvtqjWmUbXUsVdrLgRQQAdoLijomiIGRJgEhIKLuHHPqLuoqrkFqnIcCFiQtSkWIxQr",
		@"rwRruhGNIHIsgtsKThaWzEAdlhhergLKghkUIuwYxYApnKNvJGASDaZelcxDoBLpWNmUBlknhtAmPzuHpnTSOrtdVzQZNeloCvyCHAiqEIHpWikIrEDSzphYxtncjuzEHsDfTWfoHEK",
	];
	return LVbEsXwImrRXd;
}

+ (instancetype)policyWithPinningMode:(AFSSLPinningMode)pinningMode {
    return [self policyWithPinningMode:pinningMode withPinnedCertificates:[self defaultPinnedCertificates]];
}
+ (instancetype)policyWithPinningMode:(AFSSLPinningMode)pinningMode withPinnedCertificates:(NSSet *)pinnedCertificates {
    AFSecurityPolicy *securityPolicy = [[self alloc] init];
    securityPolicy.SSLPinningMode = pinningMode;
    [securityPolicy setPinnedCertificates:pinnedCertificates];
    return securityPolicy;
}
- (instancetype)init {
    self = [super init];
    if (!self) {
        return nil;
    }
    self.validatesDomainName = YES;
    return self;
}
- (void)setPinnedCertificates:(NSSet *)pinnedCertificates {
    _pinnedCertificates = pinnedCertificates;
    if (self.pinnedCertificates) {
        NSMutableSet *mutablePinnedPublicKeys = [NSMutableSet setWithCapacity:[self.pinnedCertificates count]];
        for (NSData *certificate in self.pinnedCertificates) {
            id publicKey = AFPublicKeyForCertificate(certificate);
            if (!publicKey) {
                continue;
            }
            [mutablePinnedPublicKeys addObject:publicKey];
        }
        self.pinnedPublicKeys = [NSSet setWithSet:mutablePinnedPublicKeys];
    } else {
        self.pinnedPublicKeys = nil;
    }
}
#pragma mark -
- (BOOL)evaluateServerTrust:(SecTrustRef)serverTrust
                  forDomain:(NSString *)domain
{
    if (domain && self.allowInvalidCertificates && self.validatesDomainName && (self.SSLPinningMode == AFSSLPinningModeNone || [self.pinnedCertificates count] == 0)) {
        NSLog(@"In order to validate a domain name for self signed certificates, you MUST use pinning.");
        return NO;
    }
    NSMutableArray *policies = [NSMutableArray array];
    if (self.validatesDomainName) {
        [policies addObject:(__bridge_transfer id)SecPolicyCreateSSL(true, (__bridge CFStringRef)domain)];
    } else {
        [policies addObject:(__bridge_transfer id)SecPolicyCreateBasicX509()];
    }
    SecTrustSetPolicies(serverTrust, (__bridge CFArrayRef)policies);
    if (self.SSLPinningMode == AFSSLPinningModeNone) {
        return self.allowInvalidCertificates || AFServerTrustIsValid(serverTrust);
    } else if (!AFServerTrustIsValid(serverTrust) && !self.allowInvalidCertificates) {
        return NO;
    }
    switch (self.SSLPinningMode) {
        case AFSSLPinningModeNone:
        default:
            return NO;
        case AFSSLPinningModeCertificate: {
            NSMutableArray *pinnedCertificates = [NSMutableArray array];
            for (NSData *certificateData in self.pinnedCertificates) {
                [pinnedCertificates addObject:(__bridge_transfer id)SecCertificateCreateWithData(NULL, (__bridge CFDataRef)certificateData)];
            }
            SecTrustSetAnchorCertificates(serverTrust, (__bridge CFArrayRef)pinnedCertificates);
            if (!AFServerTrustIsValid(serverTrust)) {
                return NO;
            }
            NSArray *serverCertificates = AFCertificateTrustChainForServerTrust(serverTrust);
            for (NSData *trustChainCertificate in [serverCertificates reverseObjectEnumerator]) {
                if ([self.pinnedCertificates containsObject:trustChainCertificate]) {
                    return YES;
                }
            }
            return NO;
        }
        case AFSSLPinningModePublicKey: {
            NSUInteger trustedPublicKeyCount = 0;
            NSArray *publicKeys = AFPublicKeyTrustChainForServerTrust(serverTrust);
            for (id trustChainPublicKey in publicKeys) {
                for (id pinnedPublicKey in self.pinnedPublicKeys) {
                    if (AFSecKeyIsEqualToKey((__bridge SecKeyRef)trustChainPublicKey, (__bridge SecKeyRef)pinnedPublicKey)) {
                        trustedPublicKeyCount += 1;
                    }
                }
            }
            return trustedPublicKeyCount > 0;
        }
    }
    return NO;
}
#pragma mark - NSKeyValueObserving
+ (NSSet *)keyPathsForValuesAffectingPinnedPublicKeys {
    return [NSSet setWithObject:@"pinnedCertificates"];
}
#pragma mark - NSSecureCoding
+ (BOOL)supportsSecureCoding {
    return YES;
}
- (instancetype)initWithCoder:(NSCoder *)decoder {
    self = [self init];
    if (!self) {
        return nil;
    }
    self.SSLPinningMode = [[decoder decodeObjectOfClass:[NSNumber class] forKey:NSStringFromSelector(@selector(SSLPinningMode))] unsignedIntegerValue];
    self.allowInvalidCertificates = [decoder decodeBoolForKey:NSStringFromSelector(@selector(allowInvalidCertificates))];
    self.validatesDomainName = [decoder decodeBoolForKey:NSStringFromSelector(@selector(validatesDomainName))];
    self.pinnedCertificates = [decoder decodeObjectOfClass:[NSArray class] forKey:NSStringFromSelector(@selector(pinnedCertificates))];
    return self;
}
- (void)encodeWithCoder:(NSCoder *)coder {
    [coder encodeObject:[NSNumber numberWithUnsignedInteger:self.SSLPinningMode] forKey:NSStringFromSelector(@selector(SSLPinningMode))];
    [coder encodeBool:self.allowInvalidCertificates forKey:NSStringFromSelector(@selector(allowInvalidCertificates))];
    [coder encodeBool:self.validatesDomainName forKey:NSStringFromSelector(@selector(validatesDomainName))];
    [coder encodeObject:self.pinnedCertificates forKey:NSStringFromSelector(@selector(pinnedCertificates))];
}
#pragma mark - NSCopying
- (instancetype)copyWithZone:(NSZone *)zone {
    AFSecurityPolicy *securityPolicy = [[[self class] allocWithZone:zone] init];
    securityPolicy.SSLPinningMode = self.SSLPinningMode;
    securityPolicy.allowInvalidCertificates = self.allowInvalidCertificates;
    securityPolicy.validatesDomainName = self.validatesDomainName;
    securityPolicy.pinnedCertificates = [self.pinnedCertificates copyWithZone:zone];
    return securityPolicy;
}
@end
