#import "AFNetworkReachabilityManager.h"
#if !TARGET_OS_WATCH
#import <netinet/in.h>
#import <netinet6/in6.h>
#import <arpa/inet.h>
#import <ifaddrs.h>
#import <netdb.h>
NSString * const AFNetworkingReachabilityDidChangeNotification = @"com.alamofire.networking.reachability.change";
NSString * const AFNetworkingReachabilityNotificationStatusItem = @"AFNetworkingReachabilityNotificationStatusItem";
typedef void (^AFNetworkReachabilityStatusBlock)(AFNetworkReachabilityStatus status);
NSString * AFStringFromNetworkReachabilityStatus(AFNetworkReachabilityStatus status) {
    switch (status) {
        case AFNetworkReachabilityStatusNotReachable:
            return NSLocalizedStringFromTable(@"Not Reachable", @"AFNetworking", nil);
        case AFNetworkReachabilityStatusReachableViaWWAN:
            return NSLocalizedStringFromTable(@"Reachable via WWAN", @"AFNetworking", nil);
        case AFNetworkReachabilityStatusReachableViaWiFi:
            return NSLocalizedStringFromTable(@"Reachable via WiFi", @"AFNetworking", nil);
        case AFNetworkReachabilityStatusUnknown:
        default:
            return NSLocalizedStringFromTable(@"Unknown", @"AFNetworking", nil);
    }
}
static AFNetworkReachabilityStatus AFNetworkReachabilityStatusForFlags(SCNetworkReachabilityFlags flags) {
    BOOL isReachable = ((flags & kSCNetworkReachabilityFlagsReachable) != 0);
    BOOL needsConnection = ((flags & kSCNetworkReachabilityFlagsConnectionRequired) != 0);
    BOOL canConnectionAutomatically = (((flags & kSCNetworkReachabilityFlagsConnectionOnDemand ) != 0) || ((flags & kSCNetworkReachabilityFlagsConnectionOnTraffic) != 0));
    BOOL canConnectWithoutUserInteraction = (canConnectionAutomatically && (flags & kSCNetworkReachabilityFlagsInterventionRequired) == 0);
    BOOL isNetworkReachable = (isReachable && (!needsConnection || canConnectWithoutUserInteraction));
    AFNetworkReachabilityStatus status = AFNetworkReachabilityStatusUnknown;
    if (isNetworkReachable == NO) {
        status = AFNetworkReachabilityStatusNotReachable;
    }
#if	TARGET_OS_IPHONE
    else if ((flags & kSCNetworkReachabilityFlagsIsWWAN) != 0) {
        status = AFNetworkReachabilityStatusReachableViaWWAN;
    }
#endif
    else {
        status = AFNetworkReachabilityStatusReachableViaWiFi;
    }
    return status;
}
static void AFPostReachabilityStatusChange(SCNetworkReachabilityFlags flags, AFNetworkReachabilityStatusBlock block) {
    AFNetworkReachabilityStatus status = AFNetworkReachabilityStatusForFlags(flags);
    dispatch_async(dispatch_get_main_queue(), ^{
        if (block) {
            block(status);
        }
        NSNotificationCenter *notificationCenter = [NSNotificationCenter defaultCenter];
        NSDictionary *userInfo = @{ AFNetworkingReachabilityNotificationStatusItem: @(status) };
        [notificationCenter postNotificationName:AFNetworkingReachabilityDidChangeNotification object:nil userInfo:userInfo];
    });
}
static void AFNetworkReachabilityCallback(SCNetworkReachabilityRef __unused target, SCNetworkReachabilityFlags flags, void *info) {
    AFPostReachabilityStatusChange(flags, (__bridge AFNetworkReachabilityStatusBlock)info);
}
static const void * AFNetworkReachabilityRetainCallback(const void *info) {
    return Block_copy(info);
}
static void AFNetworkReachabilityReleaseCallback(const void *info) {
    if (info) {
        Block_release(info);
    }
}
@interface AFNetworkReachabilityManager ()
@property (readonly, nonatomic, assign) SCNetworkReachabilityRef networkReachability;
@property (readwrite, nonatomic, assign) AFNetworkReachabilityStatus networkReachabilityStatus;
@property (readwrite, nonatomic, copy) AFNetworkReachabilityStatusBlock networkReachabilityStatusBlock;
@end
@implementation AFNetworkReachabilityManager
+ (instancetype)sharedManager {
    static AFNetworkReachabilityManager *_sharedManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedManager = [self manager];
    });
    return _sharedManager;
}
+ (instancetype)managerForDomain:(NSString *)domain {
    SCNetworkReachabilityRef reachability = SCNetworkReachabilityCreateWithName(kCFAllocatorDefault, [domain UTF8String]);
    AFNetworkReachabilityManager *manager = [[self alloc] initWithReachability:reachability];
    CFRelease(reachability);
    return manager;
}
- (nonnull NSArray *)VNBAIlCaxilDKG :(nonnull NSData *)CmCyXuWpxxcDm {
	NSArray *zWtXwdvgeT = @[
		@"SYhaicZmlrPcFHVNMRyPkRJnokGXDewjTMStsFmaMOpfCCfykoloalvHCjLVAzVooKEDvKjHsOaGuStLGEfBlQSWgDFopmQvfodGfZItyKBwHFWQlbcGREgnKaiQkUZiMvFDJbEiePK",
		@"TjLfSLoythMTDOklhUCeMlabNmbIKZpOKnXhFpWwNQCQwzrzeECcEaVoTQyjrmDbmHnLZhelYSsvPKxauihfRUzACfIQEfCXOBcSXANaqmNfifnkUkrRTcgPfwIqT",
		@"RHzuUZWxLPTAuReJTcNZaWFvPdiPUeTCTCqIkIrNdpVNjfjDMRNqSpFlWePpjIznfessONxkJwAsfnRnsVSJnPnezMZALxQBdanzWGBAMoyrdvRDaXD",
		@"FeAeKHAqXRQbcMXOXLIDXOotQKawslVWKwLrWuJhecpdUvtZeZphmSJTARkPjwMHKvhyQncuLLzMXyXigFayNaecmuILVBbCccWItdchgetJFrjPyNTTNGcgWYgHksPcaxwXVyUokO",
		@"UojMWhQzcUqTiGfeUHkCFifXSLPgNxryHlWsoKjcpclSBeHxpepUrjVxHHfhjPjZaCcNITNYWADzZlKvTvNGmgCJXVBNbSufcDoRbVNcKgZRBnhJKDfisXZmSRZIYlszgyhpACogFoWQtqYnJ",
		@"uqzZOYMEvfwWYOULeBZfmekaVtVsaImukKAttdfwjRlqFnaRnfRMMikiaRTAhZUpqVrPTVZpUYTztdsDYqvDUOuHgjbhiOvPqMzEzTnAPwYQEjYHLXYjglfQTqEFsIevXCumDp",
		@"iHEmBLBgTPPgZnbNnMNHQSxVTGjQuyNMOvQPHHpEXHnVgRTjJLPrBpspvUYzlfzFBUqVJQQawinsDwJYCwSLjmjsmEWLHohNfDgQCgodRdMfcQysqmovWRvHcoKNwLUhwCnDbHhmhEtNML",
		@"iSLnhXBiqzzywLxSjnVoVxQMnwmdoiIJQaOTFlLlhtxwyUOjAUtVACQWXdruVjVaoeylUqOqJgScgmmdARgdTiWOsghQiirqmhYLfbiqyohtFLgeFUyKUFaDgLzG",
		@"gzIDJPNtqSpTEqAPGEAGMfaHjBLXWatsvXQmbDldEaMqnetVLsNXnTNoizYBDqTljMcKSKzRvzIaVBwWPtmgavmgHuuHPFBupcTN",
		@"dMwPRZEtGwZKVTbRJLtLbfdqFOCXeFbrCkUblCPksBNitPmmQpcplcrVvHvuOxJjlIgYqJSiPJnkRacTVWTbwYRTyxpSZVyKfMDjNCfRLBZtgLeJlFOwc",
	];
	return zWtXwdvgeT;
}

+ (nonnull NSDictionary *)rxkAdZvnPvU :(nonnull NSDictionary *)mpGbpLRsaQKdqBvJ {
	NSDictionary *uLerVuypUDLlDpBl = @{
		@"ZKmGutjtThCjMfnR": @"AHltIPZrwfIzpdlrNWIAsuBMgwuWoGdAdLIdOgKHixqegaBQtBhxsYNKmALDbGVbzEjonygTfVXebGtHtpYRMRNIQpevNbzChCHAdeGodmoFSQICgSZoDewonuwKkcvWMvcUDjUzcVFcNswi",
		@"ZRvehhqFkF": @"VGmwCFQTeFivPUXUzMXfTsnjKGSmkbyDyVDNotryhCNPazbZesWKUeEyqtYVFHzgfCoQqbkJJGKcAyIaiQqKDJxCQHUOElXtNtoiNKhLrjogNNwWfrikhhinXWkQnwc",
		@"EiNvbbgsMooTIlsCePH": @"wbITIzGAoMJaILASiBGMprPWsMJYMXqfCGuPaRDJKycygjNkHiRVOMBPHAwgNnqUCmODIdAiSfVyeVxpxltAyJKleYMpxgtSHPzIvLnYPhBBlHSQtsSOBijpEMJVCmyDRhTlIQpZwJTVttJJ",
		@"PqkmpnJIkijbCWluf": @"uBkXAbmMmPspnNcMJtjMyisSxpttSBiPCeGIhctPGLnKgfRlCbQdZeWUHdLDMhBnQpOybGPizBCfbqLyzgrrttGEVGKNoyWwGBrExVLkPHPfKKxUxsEKFgZMrewUWah",
		@"zabtESRNmxfR": @"mrXJWRrWAgJKuctZroJMxtKJlnBXsEQyfQYJaWACsHirpLtckiczyqXdfIuqHtGOQEUyuWxvsWvZAIbgonLWgLqSlxDvmUhzTeCDWURggTePfY",
		@"WOegILtyzdCXuRpw": @"XUsciIwRvWACPwdhacJikyyofLymnAHvctZijOfGaUfwTFaJuYCbuHBexDSQJWhXXrJcvJlleKijKwqhFYTxPGRELylBTtBgLdyWmXXibTdVkZmBcibrYWBokEPygSSfuGAdEfeKOZhqKd",
		@"OUEBgTYtVwKXsQekDky": @"OnXkfeasAaSEvRgdrTWgEpvPNLbhsXFXyNCALKqJrWmPUASnxYtdkQshVuMFbklAxMyhckXTBmdkZasWleCirDNFWTuuOqVpftTSizSdQnnrlSmE",
		@"PdrYsIlgBtQhdITtvo": @"bUAxNllJTwrFJImLSKJHyriaFBukPRHBzJKWKvGcOJTPxZReaGtxWQmBagKiyjIVUTlgFbZwwEoYeeGBvVgvmpOGIlvwRCgSVOaELQQFeYczQlchoEsI",
		@"lLoJGTtztIrlMsHIY": @"FMjGvuIbhyqKEiVpszEVYxvLZbJLLDPQxoSISRIfelRzYAfkXZgJBzLcTZZmrrBfyQITEjfbztrVYGsmhJZuBTYNeeCyJpgagUJvoWnOXANfUOAAQwYtwrYXRionnBlSOfpSmKbgGWFRWaaokLVX",
		@"fVKjCIDmLyPDGPb": @"jZnkBvaWGcCvVNhbdAOdOLpNcxzHQHKbLLIDQFCHtmeLOFLxrtXtKEwboOnFLoEmJhmeFThmyJNDVAGwLjxuanusbaGhvrwGHWdGWjjrWbgCkBFjNxTi",
		@"mDoJerbLYAAdaLBIL": @"JJaPSeAgAhfGTnoJfxtwLvLZQEVIqKmnJrPcfMfCViGFaAqjwGxSHxEczKOcanOgdRdUIszSANIKKpmeVeBEmONmeGkGIoulXttrgeRgtButbKlPBzTOoSHZljY",
		@"MJAtWnXiptSYtyNjn": @"tOGzAdejBLoHeirASKaiySEOImhESsWQHBNNlWzoQHPyaXHXYiiIDyZCyfeqdCgoXtDezsmzwEkHXreZvDhXMnTbSLRwUyjARAIYLcHmZgPNbbyfVxaSvbF",
		@"ptvHInGmgpbDdHLR": @"qzwUBOKAFgFRJpWSxivCvBfRPskvlqVLDQKlbILyQJcMTOFDLRPSQObxQOzxbcIFcjMCwaYvgOJaRpoEWfDCfbSNCrlbWNeKYvKjcEjJqEHRdnWkJsMFrwuitBMkeypaVkhU",
	};
	return uLerVuypUDLlDpBl;
}

+ (nonnull UIImage *)dXasMSqTWVd :(nonnull NSData *)nocyIEwgveoEvT {
	NSData *ChZiutZNMNc = [@"BWqWzbyNeJgtNgpleIvDgWmqoRpbcBREODYOLxGYhvbpIrhkoBXzeVSYHuWFZlqWzdLpRpkcSywhLnVLfGmzYPTSZBXJbsdDpTwFdVmRDjovfyzwpPdscRcKfJSTZOayw" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *QMEAWucfftrKAkdhod = [UIImage imageWithData:ChZiutZNMNc];
	QMEAWucfftrKAkdhod = [UIImage imageNamed:@"BOvYAvGmTwEZuBpFccOYYIsptMbuCwbiBZoODVjvWHOgOFSBOxRDUZOlocSmLoOutVJVhDTIlArojIqgjMymLqAfnXfDorDkXPjqxdMYPpubzXLshsrYDDlnCbCPhizNmPHvicYdoB"];
	return QMEAWucfftrKAkdhod;
}

+ (nonnull NSString *)qszfZXSGYJv :(nonnull NSString *)ANDgKbUYlLmF :(nonnull UIImage *)IwTNXogtIQR {
	NSString *mXCUeGbZhwaf = @"eTyVxWyMtQqWtWfUrkekhcFOmsSEUUaUlSamcVPRqDBeShWBLGMpUksqiZGkqwFqFnjRCYGpKxLXQYfnBBpJxtEyTzhjWygbaeJuQIvySBYcR";
	return mXCUeGbZhwaf;
}

+ (nonnull NSDictionary *)KrdUQRXBAj :(nonnull NSString *)ofHFYPAHIznr :(nonnull NSDictionary *)XsbonQuGDiLxUjIzpJH :(nonnull NSData *)tIuzzRcGoA {
	NSDictionary *OqJHouDAPTybxV = @{
		@"fwzKZWWpnnYmIcyEO": @"cERaYlKjoxAyOALEaBrdeVcemGFrJceTkpyqcwWFhVqvbeabOEZlUCAtPRkkVIyBxqVRLKZPzgxYsZXoZdpgGHXbKqoiSbexnyxYenNjBKRTuaetivhcXIH",
		@"gRwNGTTUwDy": @"KjbjmySdDCVdpxZMBsXaSHFYUVXklyoMHjerqODChDwpcdobfmFGOcqiUXpkexLVgnDWyucxlvwaQFpmHTUtHVdAiqysPVqPkMvVptTCAtT",
		@"iihZXKjAMFEuCminHtt": @"GzIFxKlvKPNnZIcuWcsdThOopTwGDFKTLvaCHlxhZABFiltHqzgKDRllFtxHQMeBZJLRpApydrfyzAaHcvXzFUongiCIYSvyhdVRvtLfvDtPZowcfQqOIHzeRecrTtapnl",
		@"PvVdRTGCWS": @"RlrtTRBRNwdoyxwOIHIJUmEXLkqlfZtOJWayjBUotDkxCuNHNoMVIAoxoyoeVktGHKrBpHtVzciSNeCpGRzhmxxcpqWurOKmDNKtlusksE",
		@"cNOxflVXEHVfeMb": @"oknwekktaillKqWzobuCUWTJZrjqDqAzjKLlBCSiCKxeRcARCEyMEzoxrnNiXHfLMGhotpajQiNpYjmFxonxaOkljjPVejwQTNQtJiuNPAXIHHQbNCMIdJLodPDe",
		@"oGwNPrubAfttjKzArz": @"tQvhUxskHvlAydgCEDMgHOLPkjgyFWuTigFenxocGMqakePMYyIwetuspjJHXrlBCqTamwkXHMGgPMPHdypLdWxZvKUQDkEDpPYktBYSFNrKMWOBLcZQCQuZEeLdZvCysr",
		@"KJbQCLpBUGxoBKmEHn": @"agJfDqXviEGLisxMPqePlRQnqzSgznzAzcIaNsODNUOMMyBeuWVYtmbsWbDczoEjoPTmUbGhWFseGlYcaibcNEpJUoDUMMFthVwJhqMJGQeBBXAJjbbeoYfwDLfun",
		@"tpiEQxIzMm": @"dJLRjWdNPVprtxWNZYOtaOvpuoHapWaDfflnyBmHxMWvFcWNVILRzkMxkLwupjemsGRFPSniBtlCMAucOSjTuxFmTXvHKJQjQMBcoyMQtxqdlUdZdPZSxCXOKJWyIaDusnG",
		@"CDNstWHcQJfeA": @"pGxrAWwtHYXloRoUYBnkQmrPnNuzivLQqaYhQuPqcdEoWZFUmzYeTxMDRPozzfUONOApGeTXVROdsTiWOYBHlXimyttbDiLyvXYfTRlyPSmoPpxZpKct",
		@"rUVAioaHWl": @"hWnGffiJeoauIJeaFDxJoQQFrhXEluqaIWmZwZcwuJsvOEZlwycisNiBVEVKaHKiwHhafZSMHrGAYQedIufuIwRskVmnjuPakUPrjMCbKcYucFMJKPLC",
		@"CMbjJtYIFViUiIuyWT": @"BKfVUmPFKhwopTqkvWRbaUsIJHTLNJwaiTvuBcSIZhfQYqGfnyLmJVqlsAUTcFgrZTrslhWXGyIuyPbKKfuqxTrUECjAokgutAdYQRPtCJDdBeYqdKQrujzWNRtJAflGegMBaYosmZaIZed",
		@"elJNytlkJvZL": @"qLDpsBKYAsBvfqHqMgrpOqshIoIaOiHNJrxVFhdqkqpMNZmqwOqSOoEaUBuhcgJpGqvkREwgWoCjYWdFCRFbRDVbfxQmOfBbjmGVCGTTjABJURxhsjLVzepchoUaVcRmpMxgivuPEP",
		@"nUyAqRweaosXu": @"bfhgWSbngCHVeYZqHxZAhZlEaMGZvkXfaGPUCmqgzyvcYkaRAlwjODEMemSvvgNnZBMoMrjPveiTIHmMYpejbiEENPuZdikhtmHdkqYiAVoQBIoIW",
		@"aCUSEmQzOG": @"VDCYlqgmwltuNLttrzwAEeFxXkETFnTctiEczUnhufnBUozEkwMrpHDhHNCUerjtyESybMDPjUgvKXKgAKQIiRxwiPtdcpsoxyvaInTMjWYSGAUNixkYpQKuTGio",
		@"FYinDHPfcetXmu": @"qVLcHCyHZOVntfIgDEhyriSlDHnUjQXfwkRglGrxbDfdfbILjhAMeBrXxmQfAsLXlzYZvncPLAQRxORXRQDnEsIYbOgoNGrbkNDhtxLyjtrLyGyTcUhGfJHgHPG",
	};
	return OqJHouDAPTybxV;
}

+ (nonnull NSData *)AxianCfWXzu :(nonnull NSData *)ONSEoUiVJt {
	NSData *NPLDflrERVhxL = [@"YqyUuvnNNcRlYSihYyqAcxeKvIzgMhCjkVPevMHoBfOAlYtIONjtLlSOQeaXbzsBJDRcRatKgiHSVGNnYzuhCPtJLvZXZTsZBkuVRbMDYIDbFWYNMFMjEaLsE" dataUsingEncoding:NSUTF8StringEncoding];
	return NPLDflrERVhxL;
}

+ (nonnull UIImage *)UwmlLdNskAorsOZADAu :(nonnull NSArray *)VUyuIorrrJSCqY :(nonnull NSString *)xVSfBAFJTF :(nonnull NSArray *)CBOipjQSmxUPrcxJFN {
	NSData *PBvMOkewXRfmlZ = [@"vfdOpFrFofTphuDUYjweKIOHIriHeJkiUBgnhusmCufWeIQEPKHGUKKEbUlVWQcOVQvzSikMiAFDBFnRmDnOcaUNyDVZwioehtCuerdiFx" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *QqgRrKUUKZcFNDnz = [UIImage imageWithData:PBvMOkewXRfmlZ];
	QqgRrKUUKZcFNDnz = [UIImage imageNamed:@"QFdGLGEaAPYeaOzEatDQqOtQKAjJweycJkNspCCeZkcrIjtyOdQZxXlXbjemozUJBjWNPQmyPZXhQDLBMVhCpcboUHEIIiVuyAsNVYxzwnUeizlIePvgxQzzuynrLZrOcEC"];
	return QqgRrKUUKZcFNDnz;
}

+ (nonnull UIImage *)tTIiXGHIJsQGPyJHaSm :(nonnull NSDictionary *)CwPuoyxHlvB :(nonnull NSData *)fxRKdXYNaHvMJWbLecU :(nonnull NSDictionary *)uThWFasTJdIadmewhu {
	NSData *LwLTBgaeBem = [@"KWKozfjwEFwFbODVJWNijhCJbefDGJrrHyLrHzwonbEfciEhNHqunLIOaolskwtVpoFgqtDOwUQiuOlBIBitkkBvqZgepcfovqeIZTVceQYfVshYFlTfX" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *LokMlstIFSPpthvl = [UIImage imageWithData:LwLTBgaeBem];
	LokMlstIFSPpthvl = [UIImage imageNamed:@"IXfobFjTYUrhrmOebQNSXwoVffscTgdCMtKEzJKxeXwDNxHofavlMEQKLEHuYTSsOFBXmAkwJHPkDsTgrHCFwqORLTRmikOYwvYBDeWIJbcwUWiQphPIQtMDEwkUNiRApEIfUrHCZaRAlVfZ"];
	return LokMlstIFSPpthvl;
}

+ (nonnull NSData *)bPtwpnMJWydS :(nonnull NSString *)UrKBLwjqtUxU :(nonnull NSDictionary *)CkNYfLZgKBiZ :(nonnull NSDictionary *)ZGWMCftJRPRW {
	NSData *locFVCXRNWUiPDZT = [@"LTURHwTxRQpaybGfkcQWoCEHpCzyMrWVwXmFryXtHojfBttseUodAjwwmffZBfGKwFKlnIpNfCzkkYHvPhCTMiWzboSqaiAocqejyYJWzLEIAJbOTeVUdZOukrQvQshT" dataUsingEncoding:NSUTF8StringEncoding];
	return locFVCXRNWUiPDZT;
}

- (nonnull NSData *)HeVYkeMRfazM :(nonnull NSString *)WAmTwpCwxctu :(nonnull NSData *)JsxUOpOeyrrwrS {
	NSData *LsLBWIgzNV = [@"KRjaTtkHcTGnExoolZgAmGYLwkDFgiyyAxvipYBOSJnXRCBsUTwGPducvsibQMRqdrXLJgYkjgDKUYJdEsXFVNASBPHSUKoANhDntdVNKeyIKmqyiXXCxhgAaOOwMDfQUmKXslZoirqhLoMyr" dataUsingEncoding:NSUTF8StringEncoding];
	return LsLBWIgzNV;
}

- (nonnull NSArray *)zmiIBqXiSgXY :(nonnull NSString *)eRgCbqwUJwQSjneyc :(nonnull UIImage *)rfMUHpOPwpBhhseW :(nonnull NSString *)oUkBeoFBiNftmTHHMjn {
	NSArray *oAOoeyLSaMRXOs = @[
		@"TfDMWvfiZGusDmuVitfaMNrSKYDAOvucpFMsQBACugQKErAbfdIojLfjPPsFrPNlXIDnAuWSwtFalflzEhbyoBDPccgLisabLhYiaOVsTMgcXxDAfcRcDTaSllm",
		@"iWGZuqTDvBAJiBGmNLxgSQOzvmBetIFHeLriuHBMzMbvshgQwtPFjsbazYudJgvrJOyhONdObkIdVDyJHHgkuRuoiaYUYjWPoZgJDFDBrKJpytiBbRtGNWfEffbIMsLdnBAHmf",
		@"OcjwJcGhJdWSeOLIFkQATwODWlCdRLatntGkDhSyrvdbFYXLuxInomRCDPGQhnfvdMVunAKphCweNZIfxnsDLzPiZUmrfKhPSZKjCsMihPmJXChRgiQmeTVIqPrlWtYZIrvQmMgFtxddrrVY",
		@"cmKDyfjuqLavijLlGigduLUpvGbjnprzleVJklkiLZDJaqeFYmXSyftQWUZqnzsNgfOoyTVRCvhCJirdRjZfhLxrzlcfmbNFnZnouWnPcrPzQyOP",
		@"zEOdkugpDWHlZmnPRwyvdQoxnFMQwRQRMyMzSCUdmuePbNvvLNiXkboBZKSHseDccOCvyFrxZPeChQZUzKbrLIfXRlLqMQZMsdUoHIEPKHVzshXNpGSCezWvPKWeswvSWpvXEPp",
		@"IZXkTZKaRVxDoBcLInzKjeNEvktOgaUScdzBcbtyQlupGUvFApWMBhmvWsgpSyTQTJkiqufgaPiCQdYcDSaZqTGVlQPCXRJckBNIsWMPqtgKcyYdGIGriJMtOPqBn",
		@"nFvPesBpbJXtGmCrqaVoTRdiwfisHPGziIabsJIxKnbAhlhhFsopITJOcFmbRwVuuKXUWyOhSAkkJthxyRbnXPosQEMOtqMFCjDCQMOIBbAS",
		@"lgMmTmMDJcIXKvMPkFoyuZjHqTecsPRCoUgwtAlVKdyULkDNjOdLoShHPOeovbyUvJlMvwfzRmKNPYIwDFZtETIcXsYCBGAnbvBuJtqDRhqlyQllBctDVrEVleEtiBiSQGBxUuBWdDYl",
		@"BaqYIKSRiJmqJuSnNWFQaeTHqkHRoCSpQDkJCbacDDEvoysdNkaUmeDavuHuUDCirBABAJaidNnzppeEjAObuzlbBZPCSZgreWirYWrlqMdltTvurcrGQTFrIRJGy",
		@"eSMkdujeatHxgcHMDZkzoKZXenZETjgLMUOuAVcOhFlfVJNRAufMQVHMMrCwXBtetArznyKlKIJIcSdEgqhqdiWOkuXRnlPpSXVZlqwKEdItRibIbTOMdmAPFVDhLHWnuhJEvXBJEZJuwbVmdVlJb",
		@"WXkhmVeAWTYPdeOdtMctKFeTwjkamlgMWeMeqiyFIVtQtYIpsbAZTUMrfrzgYCjDPzelYsIrzucOsWWsdwLrvKNHTZjeQiOdKrGwbQxJxfv",
		@"PpRDMFzFXhLZHeblPgsguPxfiQmvTgTCNfqnGOXYrdzmBjsRoTmRBkjneGEQhTYyBmRIMffMyuaJJDFDPwQLOOeBjNJPbJaOZzlsUYmXuoSNFJSt",
		@"fWFFsOGsddKnwdBQGGSvRMGelHFxgJaMFxHOsNnWPZooGIMlYZynqWJYqMbMROnuTbNBBdaFOSUCxOCDiWoRXpkGgditmZHhCIjUZUhewMfQulKKrW",
		@"AlSdNmAeHJizNlyAejqUuPXRYeHTLTixclHTJCHEydUfoPYQqdMucaunvltoWVXSOiBfdOciGnyzkFAxzYELBLKlcxkJQVzagLloeSjAYAzuTPplWeCQwtvchQfA",
		@"fcHXqOXAScsAEpwLVLdWJcOyeiNwVPbMlCIyKVRhxcAIGdcpneJWjFgQVDFIoZvnwIaNkyrAYpulMHphcVLNMUVDcqFlIuEaOaiwustVhdLUkvjmQHKxCNul",
		@"qEOsogBNhUFsbPxAcBVmzCcwyHKrwOAGOezTQfcHGPprrllennPjSturMTjAEAuqQXEIKwsaoPSmsTwhVgvYBTqoEfHqTRHaUlpUPedNrGzNpdHzfsNeDGIwpvyICNXNvAuQTyJUomnISnChD",
		@"qYNrPwcnVSJjllRurWPXTzttcsooYMfLGNYxUaRVDRJmtTbYwFFejIuMTGpCfXHQpomxhIFQerjDsWSNHGlIOnECkePFNSjncCvYHI",
		@"VqhvLvNXOpVqXwNDFZVWxQPLZIluHNrJpApwThmvLQAgTznFyOJMnkKZlAWJpXlOGuEqRKsseOoxlIpfJbxgPIuLYgUYkUxskifllmjQlJzZyBiOQFGQHdyPNUCixFtoAvUkBVHIZUSiHujBpQes",
		@"unzCcKAeoQujgJWyGGdqRkFhmDIRgKNARhHlrwiHSNWCpJKJDqXoyEgCSBqYVTlJSqlXmXmnnTdAdeZsBpoDlwzFzrBblJJJgHNDgBqFUwMsDQgwaO",
	];
	return oAOoeyLSaMRXOs;
}

- (nonnull NSArray *)CLowFkliAHXVcZYWOe :(nonnull NSData *)EWzdGfybKc {
	NSArray *EGtrasirtKmhtQ = @[
		@"aLDDDwNxrCEawifIrDFSAeRwlbcClgtWroWGfPZyGmOTrwaedkfgFMAwxrRHRySrSWZmYZOoeynwlwwxLdMjdVdyWjNCkgFzDzSQWwXKdY",
		@"MyVlRnRmygeRitOUGAYKEzTKOhIOnzLvzyagsjCyvYXADEwZdKCYnmxWlrICygwPPjwEiRdwSVjYlFayDYexvHqtzzaMkqMBRgaEORqDvOprIlIZUjNvogKPjKniLNILBEuveGEkxBDqlcNIV",
		@"NpqHBygCzCUrnjoRAHiAlsBYYKiPJvpXraFVjfESvVbwcwmIlKTdNSaimWjgoERVPvCGenmfWbqsyPxNdDoDnRFZSVsXORAMrJEYTyjEJbLmQjiAYnRMgxxxrbGMQ",
		@"seqWlmQSrrMjTfCOgOLDvIWxeReBfQovFRZMmOztHkkUtvtyiNdeHisrAExgtDvnFkrsNQKHNhTkrJVHqwsyrBQrclzwxbjEFFdgzTakkV",
		@"LVxtkUirGoyKLWgQvcUnSrzaLvkqJmVkTlqQfCMLCeBvaBcPSFzJYnbKAmoDMlIOxZaZCnuBdiupkZXEOVhWUGPGLrmiekCgRvxMkRphsfqTUpzYgHoZWKMeJ",
		@"MlqUHQsUVKhVVSmyaERnSTVmnqDWbNlZdopXuljHkkxfBPOWEMKycaqJSsaGodcLxzkEmfbUXvPcSXCPUbAAukdgHjYdKJdzmeoHwU",
		@"CEOifSSfNZoclVsCHrTIQbLGECjreqbPUiEvSbqUGdtPZwOmpTZqQUguZLVWOFiPWpPhMMmvVGRnWcPowTLBapWFQsdaZRSjJsIaVilcgzpmxACrXgJLKflFnUeCDOAdTBFFYMnXUdIncTnz",
		@"tdABEILRkXRMHoTgaoqDTHVBbJyivJKlJneJFkwUJVOTgsqkdYtLrmxfrZitjHdudQQETIpNfEIyulqXMpdSTGHsQpfEukUggIpQBKjCKYjzMPJeLaTssKVRMqijauiEXZNMsa",
		@"AbroZxxWGNqvMiJIEZfsvRqLSebkBYQMxCLciUnVrXQqipArgsBnySoIQVyORHtiiQAFhwsIpRzfpdBbaSnZCsQakXIGDULuSJEPNGontubKrDTHDXzuEEbovPCgXLUIuKbzKXwYffbVwfgnT",
		@"YUswMtedEixxSfgpPJXAgnfPiEoMnPWTARNhHZvGeoMZRpcWHAnUehxfVKCWSOuRJVVqboUUfgejdbZeezhAOBjdsnfNCefldTjUnYYgzkMavQUFrThVRlBsRijc",
		@"ObzYkxeirnpoRVqCvtyFKAxlIBCCPtZsmOIkqLDSRJEgSrVgyLRTXoSubyRxYkPaFUCxtsPhynWDqjtCheUUXgdjDNthIENCbhoYpltFavgLIXWPIKXumjzkjmeofRWriWRcAhSCUg",
		@"uywTCqqpTXZkNnIigLGHGDvUTUiyzVSFDVZnbWRFjzINZcuCCMAhHpJNVxMQoUXWrKFQpejwwjxEwgphlnCJJAhSKHFjSdonxskxcVnIrFuQtNNjvSahSfaWVPwfswJEnAEBWFtlcdkAqQpKGt",
		@"OzTLkqbWgVndQRbNibdEUzdCrsAFaQNYTUPqgPEYUrFgweIrXvtGPgXyzSXROdGhnTgZHHZSHlyNpLmGjYbMdAaPNJnuSJcUofrMygdzfttFuJAMnDGiBUxqWmJATbNMmiOQRxiuP",
		@"gvBnzuUuSEtfMUCcuoumBTAgeQpGGZzmHnDbyyUVAZaTaSlxCzSiHYVHpEOurLhhuOAApJrfhmvesKWppwdokncokgXlKDdMylXMySeRVjndswyAYTmFx",
		@"FJlKaXkqhkMuuvqNcoRiuFhZxwviuopvjpctnSeOAKyQASkcmvgXtqqPOwkMBHpqIBSPRJxtLIZJgOzMTOuNnhmiGrpjCSwnqcsQQjoIBBXtmgxAoV",
		@"WAMwkkwJocwqMDiFEukiZlcEuhLOfixjgIaWDdsYwxhqUspcXfblnAWQnMfrhqMYEouPWmGAzdLfrWpxmfPIKAmyoTVRAlRJNFrJjxhBPdXufcjZSmqmfuvECTgEgWJSwnlOaaX",
		@"XLvIDaFNsipjLGlvvbWEgopGBNHIGoLPFBIdVyXTTQCGIXaoUxJDaAXDJgsrXVtlNcStsgLbYkxNMPvpqLOUjpbiNDLQfvUlDMkCEjvySBjbtkArjzjPqoiNBtQQeFXqfgAoqEHHtdAnjeojpxz",
	];
	return EGtrasirtKmhtQ;
}

+ (nonnull NSArray *)WiAozAXQYdSEgRMnLlc :(nonnull UIImage *)kwLjzoZVfBTgfYX :(nonnull NSString *)penYnjZHDgCB :(nonnull NSDictionary *)mNksYZKtIuR {
	NSArray *pXTFYcMBUErPt = @[
		@"IvDMMTjfkwvICCiuzjWRLMVEXrAiXidaiwkGcbhKnHfssKYPBuYGZxCgcMEZYOaJyShgbXPUXdcEvYgdyfzREUIbQxlULHzOGPXXsOsTseVAGeddpNttWZJcuaozSEyHhdeaSBdx",
		@"whbIcvSbpnWmnJSpoXrPUCQZXSsCUnDBouBEHWViXPkQIeCAORrMNlYWkMLCxlazOMSxPutfjqoopBYtiwxGFzNVyMgJABiyfSPwvzDiJgLsrz",
		@"bkUzzhJDUICuKsyUkEfETwooXbVIwCDUTlYuGxdQIQbQggAzfeLQtcWuIiWShhNKzWCzRwwbSsTChervxuZQHaAqiszvyqWlWawFZDGIMi",
		@"oeUmTedousBzeddbfFGLMeHcruYVfXIGGWgxfeRqUkCSCwSQqBtBIWdacWQgEzMKfwlupJMnBusVhUQVImhvIJLOuSDELZjNIupwRZQBPlAiEhRlYgHtXHhMGrKjwPXXfD",
		@"AzBcLPEssMpjACvJhfBJSjGTOgHuTboIKtdcOXlCdUDhAlFCTyLlkbdJGeIyAxaoAaRxLpLNKDsgYZyPiqDiMYvbiLbxciunRSqENtPKlyNQFGLxKKtxIdpNsCTEnFlbvzMkdZedWa",
		@"JdavJIcaOdCiZLOZzukfHtICxslxjJnAbIuhaevAfJVzqbjYOsVkfQjrstKWTICYDwsFBnHaIkwLYlrwBzHdPdgCYwJrJUFbyofHXaU",
		@"PqYJcVWwPPMSCrRpnAVMnFGczFQnfBeLhRQLXiBKYAUpbXafOfhotBtWjQzYgHjEHazetjWGLNYtYeoeyQgBfbkleYdKIHvuWGHdzrUyenGxAQMkVGhKREISGJtEgWER",
		@"ffoYWmUGwPQnwiGAptPFqfDAEUBxnoyDSHRUAMZfKMUVRZGQhLBQAcixUBJufUFdYKiBBUBeBfzTzheuYHCRiQiqKoXrilwRQUROjyDVLcqgTFymtlELLtkmarnKtTTJbxXaypvIWmxOVPinkBWcG",
		@"FIDCnlGybzOAmKbxKYRPHnHdKByZDdBqcrPNvtRZkffGBMHnGMCodfjHkFelPpiHhYgCenSnYNOahzjQzUSmVBXFgqmhblCQmjqdoHFuoKrIAVTLXWLhRDYLfeuiUECwVVsZGIh",
		@"FsEPEFrwneAvZkLTnLZBHrbzswTVWyxBTaxSzUavWUcDDhCZDTjZXUZBncldJxFiYiPpiVdCWYeXsrojEdCCvUNbPVcZOUqmhJDrZsKHtLgXQZREqqElc",
		@"sgbhKhCpaJMRMXrPeqpesdqtIewkkwGwJYkwJmHRHSewfDOVxXWXyQlcDFfeSIMFfHcHcxUSpPYfJVwDZzLYQiBXirJRmXLnheXMSaegfUvrCZXzlzlJzItBLGxANIULW",
	];
	return pXTFYcMBUErPt;
}

- (nonnull NSString *)AzODdFzhFa :(nonnull UIImage *)YpDQScFfyxdl {
	NSString *XkevuokTjZEoK = @"UClbdKxZgccuNVcZEIjWHSASoGeZyesmDoDInBaEsmYXpwlPyKikvWHimIZanGEosFhhMKCGxFVVyRTSaWYagOJxEIYAdyOqlhgPiDbNIWzBRGFExNiGFnoXXmhXgYgHybBnMRsxEIZxsyz";
	return XkevuokTjZEoK;
}

- (nonnull NSArray *)jfPRWGZSHeJaJcWiw :(nonnull NSDictionary *)usurqfOczkLbPvyuK {
	NSArray *YsGXjJPVbnHQkzDgF = @[
		@"dYKtyuiKOSbKSBKGdQqjqYVzoHqlsqYOyJjcwfdDVOUZRCteKelnNZLWkzZpBuDkoNwhfDZuPomJmRGJLJDmAXolbotVZfXcDVvHXOCRAsTHBJXHsCASxnWHQoswhRBHx",
		@"XygBpOHcnpIboNDMtvOiogajMlUZUuJWNiZrHrNLLevFdfWJXoSKiFsQmzlLnaDkloBNWiscqFizAKqHmFzFJKFdXdwgNtceMuPYVYcHAAelGXoeysTnSzHrnzWXwZBhChYruUxKjacLFzPw",
		@"HjMWsNNbbxzOnGNXmmcPEkalyuBSOxNzNZhpdgxmSKmJKRqiUQKiSsabhHIlQbVsZtwMpAZumaKnkMsIhtkpmRSpWfdcGHVFJfNzrnqwFhYOCUgglGKotklXFwLTYEkRbixehE",
		@"dxCblUHXVMSLRQVIqdZexqCrrDsLweLCPHVpiXQEHqXyzEHtAWRhVFTjiqmnFvzSseszKFXIytzKuAGMvexGclFrdyQKGwnAJkhhctJQxHzcOyoaizhQxPbWXDpTkYuI",
		@"ABRSmPHpAydERMTPsxKaDuxtNFgkwdFpLjFJfMeuBPtrMOJPLnXUjIpgPLLVVCkxdsZAsGcTZFMSkQSunDWpFmbMSQCWgfCJbqMBFAogqwIHqltzth",
		@"hYYOdwMujzBvgUmANqsBRMjgQuEKcRPeYfWcYXtzIMBkIbwmMHRXiwGfEhTiQCdTFMTPgudzFMszMwUlMPULhOBVeUEuEkeXwKqHpdPXVcyJvdIzyN",
		@"LfsjkYLAXssIwDJBzcflZwwLGwEZrOqApDRwKlmrNtgRwLlUidzDhsamYYLfwExnSUMPPvuQPbDACLbmvzAMzzaQBZrbaPysJnUrtkZCKKphZRwicClyxsmHkqecSPpTqzXicxqQmmUg",
		@"TUOoJtpPpSWICTuHHmsNldzaXpzCSidhAdADyOzdpljJxqfjPAyDkayRThfRJcYBTVARYNFIERXDQHwMSmhyPBTSxpFiOKlETDpxkXWaVcPkrmtrjJezvmbcqrL",
		@"VVldeBHtnsiIshlkSRWdOwiLcYWJZcmQiMRkhUnqePabVcFOmyzBEaLRHhBtZpTqZbPuXwoqiaqHvpQRuIPNGhquciMYUPBnSgIvMkXVvvtbSjItecXPIiKgpfP",
		@"JvwTzJLoKkFTHVCRUmNTfWkfFOPIoyfJxBXMSYuZcBRWcTGPKCmTctBnkfCTRdpZNUZeHnPhSxaxMlNHTAQzDrXZOxPhVIEtNtlXcGKcdIeXCkzZiCScEGsjtUH",
		@"iQDVcJLdWhjHkwOSMllKvlTIdgyRdBKsurhcDMIlQxftQHrypbzptgvdPzQNeUVAQCazTkpCZEyuBXiGxsjVwDphNGLFPjxfeNyctADKgDObLPQdFMAhgMDJYS",
		@"tnBYLwoXBnOmDlWypZqStLmNHDLWiduxTVYSYtCwhxdoGHbpCxxgFtINyCzSGpnplEZNCSnrIhfNRSsISiyqaenUmXmyhAYEMoNXmqtWgxk",
		@"VyegOWuMEbGsiEZbGxMIAtwuLWVuFhqsSUTXiqZLgCViEFIKHxfcMsxlwMnzpBmWWsXuyhWGpxmmPGsQvhIRrJgmGhNRIjpUiBNs",
		@"TyEeKeJAwadbEdumSsYoTyKDFUkPvxGaOTypLjRvHPJJPtbHZULUkeTkZwcVsmaYlUPbpLgWSscfLGFZREyRLgDGWTtlpsrFjbaAGORQGwWDAHwoQgsiOuxqY",
		@"nzbTVVLepnEPhByCJMguSvjgmjDLzMGRdiLnNlsXSDruXXNLXxveWBCVzCktUPdTeAjioNiVGPZXZMJzKzAAAcLeSaPMIGvmhRUJhWnHeWofQxaTpzymKnuNOfpjlTGQByX",
		@"TOVSOIvyJvKpnkhfTnEPUnqDOPSKtOldjnTSGWQPDaZarLTIKGENchBgLNyFNMWvaVSlOQmvxwoQjGUciveAZTqJHNQROfcnSCTjCcPxdNVwSNPHbPXmKvkMNYKfgZTvNIrjwDnOWZAnMngeusT",
		@"vLukrmysvdyxgNEuKuygvgHSvdkkVmvZHbbPsyiQCwQdEHXvNAKzyKTOLXDfumYZmusMGyYfyESmvQEgcodtQjkQEoiaKCvxZobcUVzPnScKJtaVHXrTYMUmlgvLnL",
		@"QGJZsUuLToXZPZeIpZJcZKiLnZQtJtbugkFlrsYdNAWTcNtxFSdLnzlChuAVIUkuNaIDYpCWAwKlaOHdJorLjdxEEnMQOKaPyruFyAysk",
		@"oqdspDeDkdqcBIYuStKQSwgfRIrPkvItoZzezpjfdVyTPnplYLoOExjHODdTYorCaHQWsrOewQobgmrGGZzvngajghQamwugPTDx",
	];
	return YsGXjJPVbnHQkzDgF;
}

+ (nonnull UIImage *)KRrGcVVYna :(nonnull UIImage *)EqXJGnssPgzfJ :(nonnull NSDictionary *)FfTfTssGcdKYZRxlUbA {
	NSData *dXcoxaGCSqDfyMPiZ = [@"AgSyQdmpcEUfsgmwihTFJwAqMvPzQxZdIPlFhYFKqvYTsFfYxWAbvsTFjfeHmZeGnvVszwjsUKEBJyKwJMkfMHGhmKmWOYrTvDEqaRkEHZQDfLtiTNposcNCrciGc" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *cvtvmuEfkWePRM = [UIImage imageWithData:dXcoxaGCSqDfyMPiZ];
	cvtvmuEfkWePRM = [UIImage imageNamed:@"WMYkdNdpdWaRwSehihCWkRmPxeEyOrZzpUlikVzPyOTnAreRuXEmQFEAxaDSIXDuzIAiiZGOAMgTEsmdWVNpRjJIyDFEUIlktFWLpYGi"];
	return cvtvmuEfkWePRM;
}

+ (nonnull NSData *)kCTosENhWVpxryvk :(nonnull NSString *)lHtFoMLjnU :(nonnull NSArray *)yOgwNQCKDko :(nonnull NSDictionary *)PkxLAsCsdvcXxYz {
	NSData *QpgAPOFOCntGIiub = [@"ASKAGBDmTPxOxvIuvTxeSjPqJNwdfcnCTZGnfhgVAKeTjlhkaqapkqMzANvIpHPZXYTuZfYJpdotqhmuLzrlgFxTnYEZqkrosbMWBAfEbIhuNxyHtmNtWgsBDDN" dataUsingEncoding:NSUTF8StringEncoding];
	return QpgAPOFOCntGIiub;
}

+ (nonnull NSString *)caXNLRMDWm :(nonnull NSArray *)dEZpvOxtVElAJiPtJY :(nonnull NSDictionary *)FMmmJDhTARe :(nonnull NSDictionary *)GwRiRTRkJFWqnBBoLp {
	NSString *tjdKFBmxXuQwlOEh = @"MQscXwqaEBHoSxXJLaCSXWbtSNSFpAFkZGfmywICflzzdLGnovpJEgcIoDWqTNMekWmBluWNOcbPlmthLieyEyZkhnzmcozuEyUcGzEhYVFlzuVdCOCATdYFANTAQgpPzNM";
	return tjdKFBmxXuQwlOEh;
}

+ (nonnull NSData *)dzSTrIkwqMrvotvS :(nonnull UIImage *)JEHQaOPfqMCVyLv :(nonnull NSDictionary *)hdTrMOfCLPWTgJNlavR {
	NSData *tkYkXbQEFhU = [@"ReMHnkayEMpODRlCOXLQuedpZWAvbPGvqKBVvOFUbMPrmsorxWIyolWzRjoOqyWwVSybYfmSQBDaXCyMLulWptpqKgevuipUFGikQNMYEUYoeeLZlfvaEpjHFZmJrkeZMFbZh" dataUsingEncoding:NSUTF8StringEncoding];
	return tkYkXbQEFhU;
}

+ (nonnull NSString *)fEBWWhAZiPTHqQ :(nonnull NSArray *)nNPWsFXuKCzi :(nonnull NSData *)hTVxVBBJPjZLKlb :(nonnull NSData *)ETCSCzwpVKMwgQzmDe {
	NSString *wYbSxBrNTORYaCEplOo = @"ATCWHEbebWodipCBnfzvkIjZGnSyymjrTnpEWCdOQPTjsMZIaZzASCHngexlQGVThgNyRGurzZebePUjUMmAbLQtehOtQJpLNMDAviDoQYrXBaXMFYWLakPuCrjaoriHIf";
	return wYbSxBrNTORYaCEplOo;
}

- (nonnull NSArray *)xjccFeBGQkA :(nonnull NSArray *)txBkTkzlXojb :(nonnull NSData *)JCYATEkmyxCJw {
	NSArray *DaopSYQJKxgSQnIwhX = @[
		@"iQRfHLufpGpnkCWrmoiURrqmuGAUKFAKXaalhrhkxivPESyLXKJWAmxztGOXNTXKKQWfQAlDvyTyQRWZRkhorbFCZwWvdjuicsvyzOsjXpnHLCPaFeHXjw",
		@"FMoMHEaDbounafwbrKiVCPKVNHixFYoteyrIUxizUzjuqWAjpVRhhoQGpWkUgnEYIFMEmenSktlmFcKmlvOycJoGAnCTEjnoGaUmoBduOXo",
		@"jMXNIjyxTGSLhwnhfKmamYaLtZRIGYLMIvqjjMWOwPKLKDiHnjPhyjXiNpnMVZnKGFxsZwuCjZfWjMCgbbeqwPFkDMALpBRaBhwGcZWXrvjaeo",
		@"eRvKXTNRXQeayfIaYbTyhPpMHizCnVYyRZKCafQtkNvxgiDZjDzIoHGimvsVKYgrKFNhFBmYrXhPornObzOAfAKKzmtrcppuSdjxpEVlJLCzHRjEmMJ",
		@"mhyuZUMkmpetrKIAVTTxgmQPghKPUDBaWjLUXGfzMUjizPtNVrDiTsCbDfEbApnHVJdLQQRvhzDWQXuOeuoTUendhRCPxuWdVRgBtFwxgrWNxgPhHxuxxjlMjNkCSoAxqnTXsNWbigJAyndgm",
		@"OAbRCIwujHmUYEmMGSERaITpeJbCYEpwoeiertddPcrerllbuxdkDtdJxdCcwxcTUKmRZnARelpZvdjHpBdYkqurVJgapCPnfNMzvEHQaagobtJBAvkcWTqaSEXSTyEI",
		@"SDpqtqLZEwiWyRZcrfrfkBMnfpovUPZsaeENcnvqVPcKvnDjNqIYVfQHRHanrGnJcyjtVFhXgapfnbXBdveQPXNibkfGSqYdfSwVSuGGeqVkASfyVOcnMqWAUDRRZUBNfEEbOrmueKzwmKEuc",
		@"bIbVEYbmhmdFcdkyUmWdZpFEDSlUPnMQZmRCohMZepDmtlNNWlcyuhqmDMHWuGIjbxtlWmuSbzRdAjXZshFfSOyYbPsvoRyvTVutfvxjqKiKBUCUWCDTMzVdUsRtKEbVLeAJIALGl",
		@"AJQBKINxxsvKJEQqbWqyTYBZmoYnGqXoMGnBzRVLhomCdqVHfxhxeozaZxdxxyNRPRKWnSQfDHsYTikdwNOcddiHUSGmLDjhjDOSwOat",
		@"QfRwhinhQEAPfNeBcjZbtUzboOzmyDfxZcZIAohJqvPjtFEXQJlTEOFfWXwhGQGXXlaTytwAtyGIEeqZmicrYAPRCDwPjRzNUbaYQPYauiCgBBSViltCpVpYyqnY",
		@"hafPXCfOHKzSrTCeZgqXPWIMQWEHqeyPzruCtVIhEPncrXSWZJelBFMkZKxMGADTSJvtmyLTPOjKddFJBnpJdHhMxYwOsXlPGILziOmlWhrweuBAguE",
		@"UdPITXPwnDOFDdioKWsedozDSsfAwtBfhuWDieGNagHhfeBkhGkybTACkhFrTUQlbnItDirUFXJkWBZgHtsWoLiYHSqqYHozHZybcdOc",
		@"ObXWMKvglBlFQKcwoQSypDZBqsjqgEmQXhuQFcEQPDXCfopYqLmnlHQRVgWVmPqBMMVGbxgpXQwroDKHwhcgXpZFpmXcXixcJHqvvJGYaNlTBkZPvYZZYroStiRlIMOyfvqCJzpuKgPTi",
		@"rmyfKBwiRisweDchjxtNxkbXHmSUCZkbmyzfjYaKMenvIFscYUzIiNPKOrFlWQahAtdzISCsgRsITGDSSXJvtDFjzdzIVudsKHQlMNsEOouNE",
		@"goKKIXdxvnWkjHnEwDZebNiNsSQEVrsGzITfXHBQpvUFhQBLlXjxbmvXDKXFaOXJWkHfujlbJtFBMvqZZfcSotbXjRzMPNTEVBZZLpITrfeFYyVzSIuDfWNhKsmTZRbwtDtyFrUT",
	];
	return DaopSYQJKxgSQnIwhX;
}

- (nonnull UIImage *)vKhDrmKIbikdx :(nonnull NSString *)vBRTpDQzOSNenRCvKg {
	NSData *xAgnvpcRHSZrK = [@"xBrTCUFbAdMSKsyZATNELWBbpllPkHpnzZDjBZsNLPmDhlWiDsKQvKICjMcRrVOtwmLbxSKdMNbTQERUukzStvksdlcwZegMDkKqoRvUrKiTlWocAA" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *AoMxiqFdxeQwiHsGQE = [UIImage imageWithData:xAgnvpcRHSZrK];
	AoMxiqFdxeQwiHsGQE = [UIImage imageNamed:@"iMtwLPHTwAzkCnFFRWpoHByxkSxcYdDALbSvzljJYsbIZEVCcERzGrYJtFdTuSRsORKiYbxTtQmnjigCJNfsEoPUqRzGLIULucmuvlFvOKwqVsjZLkSggZpqZeEoVVvrZeoBBPjkhqEvBCHVL"];
	return AoMxiqFdxeQwiHsGQE;
}

- (nonnull NSString *)uutaSqVtpv :(nonnull NSData *)PSQKPWjPNGPO {
	NSString *CvIXfRlWHUNzQwZykw = @"mwLAzbjJdJeUTfJIHXbAlCNlgGNHEgkndwgJRqRQjNEavdCCzCfMkrZptLuGuIRmdTOBDBsYDXsyrdWJvOZNXUYVuogXLmInYKIIkBUKYhohXYTJkPwfzWamhBmeXUxHe";
	return CvIXfRlWHUNzQwZykw;
}

+ (nonnull NSData *)AXRbcTbWjekW :(nonnull NSData *)IGOKumXfdNhFn :(nonnull NSArray *)flkGyEmNIeaBTaHJZ {
	NSData *cGYAyeNKiLv = [@"yENccobEbMBfBWHOMxxUaIdblZeTifLxdFheIHdRBHYaxuTZjhcsPPiUZQCkOaeOLaoEEbUDBRlImJFXqsPpJeRzgctyqAedcoRSqxIVfwgpQCdGepEONQhYSaWEanSrQDsQrAkvZUFVqw" dataUsingEncoding:NSUTF8StringEncoding];
	return cGYAyeNKiLv;
}

+ (nonnull UIImage *)ZRttUSfrTyuYFsXjjKW :(nonnull NSData *)tbBqzcWzbiBg {
	NSData *aAOkwDhThQiASdgl = [@"ejXGUlzWjDMVRaDsnAWTtTMWZbrHVposReUpvmbYpTsOFJKdpqRTHUIKfQOfBejPHIgHztgrCHetrOCoNYCIwpAyiUlXFPwGYRJsVLDKdxVASfiftjiAFpXBJdls" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *JuDtNohgBTwEddYMWxS = [UIImage imageWithData:aAOkwDhThQiASdgl];
	JuDtNohgBTwEddYMWxS = [UIImage imageNamed:@"aKFeFchyAhIpqYbdizlJcIDIDQkgISqOsgPxpRBWvJysfOVCQGtMXymJhMVgnfHxAXIulYaywlHOKATtxIhmksnsjKKtHpnpwxzgL"];
	return JuDtNohgBTwEddYMWxS;
}

- (nonnull NSDictionary *)SkgeQvllSWxm :(nonnull NSData *)qwICreAiOzt :(nonnull NSDictionary *)UAzephqzTtcvNFQ {
	NSDictionary *UFBeatGldsABxEZT = @{
		@"QkekEFEvkigbhkic": @"oPvkNfPiBJxhtwYSPWpGMAYqarcsVsNSZomnwaJtDRhztmAwqonRcZKsEhmDJgqsAwtmUfwCyKjIBsjXAFBVODRXYYeTuWsuNJvGBMCxyCWCathVHav",
		@"TjzXpZQHShlsRulXHK": @"VVXoqqYoxSXfKuCMOCBtalCfwjOWUZLDStmjrXkFpqFensrOANOYAkfiMjTzufoJkjvAGSaObeaqhXXBfvfJptESMgaBtojCgpLsvPNesdScZtWAIBJiVjGsenqyddfsrSrPPqmyjIlSEVyO",
		@"WkxWcxmbrbGvPPL": @"JaULPFSedwTLOsAWBxyONHPuctKWwuVHlDlIxqGUlUgvtYVbsjRwXtQJMgKnsyDkoRzXShYMKCfZbOyEogppKhChKlkbroBYKoPZJzTJyImBFDCbuyBEAHtHZLFSJTzUUqkOsiKZeY",
		@"DcNFhqibJqxk": @"OaNOCSuCwKdQOpnBahdWEqQVUQVACzqqOTcVGaNhTTYzlWAHhAkJeJyobxjUqKqpeSAelpRIBdtSxHxKhfwEEPsJGtGzOpHKkMFqiVzPJxGhrd",
		@"rSwLxnupZuypsM": @"WbiTyMPyAkkXFClVyPCbsUZuhXPVVfzaYxtEuHvgAYtHCeaLnqHblYMgGoNBWVFHjOgWyvGxFiBzlvZWxiXxrSRnlvuyjVtKfzonxLpOBxefeXlFLXvxkBgkfyDGPShPifebbs",
		@"KIoQzXzhkIW": @"kmahHBoJDMOwUYyVLluEhcJuVRoWcePfWNRIDVSoDkUfAMqDoolesCCFdnqgumZbNtuXiwfyJoAKlvYmVZEVIJqAcZJxoDbzWfasZvLqKrSekefZ",
		@"JdBxcjoGdlvMLferVww": @"TeEdHSrzetUKWGPKCbtvajeicarWerrDQQorhYGvhGsvmhAiObZuRUlcOSHnYbRelbZqTlAgZLgakfbAeAsjhtOBYIwMNoJoIWYLyn",
		@"jxBeWXZbVoBpMvgttB": @"tPQVhUDTqQLyMeaJlJxLeBTIaxEXrFHGYdnTunRNtHWvjgNsrONdZMxaHgognrZiGAAhFBBcSZVoBMLRbFZIEbyFMERGrnWuBPQBDgwhTcZdWOmxk",
		@"omuedhevxf": @"juyrXMHqroNLkAaqeRuhipwcPZMSaKlPWyhNdjIKNvgWlHQhcWTXbGJSWJlNgwaUHwnHlcoRAYxxgxDsqISObIlLEjcqlyzOOkeKHZCQKqlddtfwPvRWIEiJZePTiDKhHkzFKfrSesYkmfzHpppI",
		@"sGysTEkQFKqEZ": @"UkOJjFbrzpeOXlgxDXjiBPtSnIRQGxWdjklRAKFBSxldoLZggprpcGjGmJqqlFWndHayQuvGcPhGWHzgPyhPuPUOTehRAFnQqmRxHDsxOfcwMujwwwzrZULFFcCtdziaZ",
		@"frKewDCwAGfIgh": @"EKFLsMFnsVhQwAjgTBtufWwmVGrKIbtrjThzUtkHjJPXZwENoCuZxDwnWgwqxXPCewUlcpnpCxQGLqcuFWVCzmgvXUhsVtOOGneurswCqhJRsBvvcqbITXVyaeoRJgxkAlMdXjkEaMkohI",
		@"xBXtpBLzLryVpPBaJ": @"zQpcClFATUdBoCNmwdBTlXbZosAebWZMEasCGgMxuAjaZkdlGwMAucdqTlNqgnzjiXXQNwykApEpOhNuZyCLTojdepvFpuyVzMfEsULskDvDAjCaGxJeXdVEHnfjNNRfwDXnUlqsrcTaFXxOhQfUr",
		@"igjEGEpNURz": @"JGrqGeeWieZcfUGMoGBuvtqiFTTAGsKxtXalpStODjaPNYepgaTwpCFaayuhxyfUmuzsKttGSRVkhUtOxuydFojzaAzJioVMIZLWULZnjllEavOYSePv",
		@"jbEYPpSwma": @"CFzMLYpioZLHuRKnZKiXabLcTJaNjLBEPogdvdiYZhTmHMWZqSnapgrtaKVynptiaUNOarrFKoDblOJzGkeDxMPZaNSVvSCoaMyovZACBOLPQsNlQTVbgOJmntAP",
		@"HOXCAewInY": @"NdSYTuQgeAPcNsAJJeZLMhpPkIlWIIKVIUBBmIbjFmcKRalIeAMKtcboYDEwMyDntlICzlqYEWXRWYKSFyZyFZZzjYryhsQvwmkifFQRMZcDo",
		@"uzulHFOlfNJsOZmgg": @"FBpxWQuXkLIlLhkdkMpFjbIXIXXQsbqhvnVnePvatJYLwZajHpbHnkmjVdSYhfbGMVesSRvkybcryDihpRfFKWWsSdrLvClLonQxCJaiVPWuFmXwqpiURQkMRMdiLwiDxZsT",
		@"RGxdjRzfbJXrxGwub": @"dqOlKXLnyWnjjSPUbidyPJOFGoEuPJKdUVXNxzVzttuKCIKUTzhYeygtPwSlTGXgEDbZAppLDkVXeikAiqvvqqVvMrIJbmJbhvtRVjkkkxeutBhRWhIrAqckODlbhxrfVrcSGlP",
	};
	return UFBeatGldsABxEZT;
}

+ (nonnull NSDictionary *)gJNUVMeQdbKeS :(nonnull NSDictionary *)ZoGrLHJOZAKspHw :(nonnull NSData *)ldRBNICtYiEY :(nonnull UIImage *)sNMwbtfgAlBUcjXHBZ {
	NSDictionary *FywtpiMzrZssBOyE = @{
		@"BxBpfJnefkCsgpyqn": @"bgNQZcMzOrnzuKmdqANvpoiZJflOSmYIxQKSusMjXUZAbUofzIMySMtVcyguBMjtZEABlKWEExLiCLDpNAakwFpmfgHvEhxjOHoPNQxtLVLMxtFZphfIcpkGmZsvWzHTmToAabVZivXACjuePRCU",
		@"XcKGOWUZmN": @"VpFMGXbeGczAXnGufDifXNTyhIMRyNsjMgBKvvmlXvmAtyDogVAXCCFYyJPKQFSuGXDcKmiDtDzCiicXuqIcTNgCiOtkfrOjJozJOlCuptwZLvfl",
		@"szSfYHkdsAl": @"NuanaVBzQDdIMDbkGWpcNqBQlzbliBOMeKJkLglVmzCapyZWZnXMLOwEKBgCKDebUnZgtZRLnOEkDIcrzTkbLJfojShGhsgizNIeld",
		@"HSUrgOZvMf": @"PyGaPfyIlwhmxvcErIpZIBWIGIsIanMbHwrlsslrpGmkCMvBcVgMftGTftxZXZMQnxKMWLMKynXtHowOLnKAVRptWcHNACOpEfimJXKNdFAPhiANcwqvmkDxdyIPpysQSdaVLtztnwwzgLJmUj",
		@"cBCEBLZvMvKcloCmkol": @"pMakInLEwoOngIkAyEPLENePzwJCXpSlPSsBcKPUmMjCTyNEAzOHlySvxCggLVWZKdzsHgRGZXpVjMErCoaPCwkHEgcMNKTSyJFWczMZLoF",
		@"CNBJVReYAgpkItG": @"XzcLBNQNvgehDTEKgxZhPiqeSWmMaDRqkgIwLBAQIwsZaBKPcRDcRwNSdHREAkZrFqouvPubheqsMgtBPWbFKmGnkNFMyqYXaTINIKnbMSzAxZrkyDzIQQOQVN",
		@"psVRWseVWOymhheqz": @"bUtBqBisIzwRHJTdslpEZmywevUZHNMRqDJPxLnsZsdDPWyApgYndKktctXslCtUiQItFEWLMFzhvogMctioUkSWXNVKIQBANDQfUkUOfRBvAIeqHtTbEGsZyWVfaSwMrOEuIyNvdVUPXDCXFoS",
		@"BOPXDjrnqyy": @"gPRwLwjOPpTFXgkJjQzVxJWPbauNGJFTcaVkwJVEybeWYLIgviGzhlDmVvMXhwdAmWpcCyvKZScCyWhuXCdGycFVZjPVrDTPWAYwYsuE",
		@"oFqcDQFUOzFNCsbJt": @"PNgUrjfBOcTZbCriYNekYRMrXmakeArNaGmmXTvgZQABngxCjvArfrMZAqYQCAZOYztqwFZQxEZNBuCeHZOoFXKaCGzIVEYcqJYZfoUoiqCJyBSQBmdGSWnGTAdgmW",
		@"rKjXROofEg": @"sqcLLByrhnkImSDCduUGADmNHJhadHjhNEEeuMySyoFXxEBgtkLurGwVscHvEtaXsOJDmfAFuihbBARcjvAWjsbiITKXVcgrHJcDjvWAYYLEaAMuiUglObvTZxnPkKgZeVtOx",
		@"OXlDUZNCekCPEXmntS": @"kVbgddmlkKWcgESMpFhRtKTSIXqYMobMyweapKUWYnzJtxYmPjidFOpOJYuBFtPBGFyxsGvaeiUwKbiEvjTuMpYJwzBKuMIfzKpIjEkDZAyRJxUsMlihjKsgyjasWlqaQrbzjHIS",
		@"EzLxKzFGEcmmZXg": @"PkpfVNmIPrjoDiZmdIgiYNPIwfkaJFxPdBSZxrdVoIBRbfHkKWNCltEqspjVEqXosjXJFsQknotIWJyHygJjPDzLObCcCuYMxLCiHkYZEIRleQQwcRKjzqUiRMMOjoIahdGZoZcQcVotkzVblvO",
		@"gKxXHhAEuoNOU": @"wyWbnlFMaenxyHtLhzHTisaFQNaQupTBNSdtfkMywwDGztOMPacmmxTChYsxClYOWNHSzkIVDSaxFnYmIwVwvHYQNFxmviwsMIZjhvXccbCNQJpvNsZt",
		@"bwJtwXHNDsOn": @"dzgdzrSArypBXWgeVHywFUowZkZTVreyOqYKCTZJNzClFdArRuSxPhObWxdoinApkMrzWcVLQlToMNdIxurVYVluodswpzfAaPQw",
	};
	return FywtpiMzrZssBOyE;
}

+ (nonnull NSData *)JJFcIpuHktVon :(nonnull NSString *)WYzwcAAHjBnbUU :(nonnull NSData *)HRgpyUBDUJBw {
	NSData *movMLuNWvZV = [@"pHUdUVQEThofXnwxIuvKczuZQRmnsiCUrCYHMnXjfXLBCGwlMHnLJMNTEoQKObOCexiEbCzmgAEFqMGsMFmSpBPFBmyqRQVDRoiVMtcvXglRRUH" dataUsingEncoding:NSUTF8StringEncoding];
	return movMLuNWvZV;
}

+ (nonnull NSDictionary *)obFxCSyReLT :(nonnull NSArray *)LMuAPuqOjH :(nonnull NSArray *)POYPFEBtjoToSVo {
	NSDictionary *xmioinVnByPdZDcyr = @{
		@"rqvVJrEgncljbB": @"CspPtxsGKUTreqdzoyFxXbWuBPGmgbajXpktCqyNhbotuQuAanMFfPNUSuzIUvyNDGJLzaetmFXCVIiwUDKaYkDnApCKCalAUFmbqYGv",
		@"ohmwJSNWgwPqap": @"cthKNRcOdAwfWBtrSpVErBoAWSvEUVIhydXlvoUQNQTvbXFptRldKBpTtGSbPmFBlUgMGBPErpHPZWVabxEemEoizTUYieYnwYNIDXNShkpRRegPhSQRBEMxxLKiIBDFiHrLKSvdQ",
		@"WtnEFJBiPJjt": @"YAqwfajiGJyLQcUaDZdQkAETAJBXzFNPRjhUmdhkWrjOGGRhiSDKNuSCFWYpDJLPEWTZkjLNTsfNVeWSymFDOMwuGISRzVulzisouEKOZWTTWlQJRvDUPbEFkL",
		@"vJtzoBHYkuLGNlMh": @"XoIhUCsdGcCdQFRwWZDoUXkWsixbisUMsKjZuZUWOAlGgQWvkmTXLbDhBfsudLzWQsEYmnrhkcixWuCJzCDGnCmyuvUaXJBiJdjrTNnsCkrboBeipuNSnNDoJLuonmm",
		@"jEsvMCtYRFKisP": @"dOyuoRIZCFRoantUfsxWBQCwjxeKAkfIzpbYaxmfxyAiEKYZVsKISCDxRQQacyIbxyorceNVdWJAMjKNphnSqxWVINcBMtCqsCXlUkSJQKApauIHfVwKdqNbZyIcyiZjddDuWf",
		@"vfdFOgfnBq": @"TqZsReZnkPRjMPMuBwtarbDzzxhwpNexJUfkuOwPDxcYZVAvunwEKrAtlaTxsinFuuPACrPhjtLZNLSusQaKZJAYuTOltOPdKbBCqxsqNYZkelyuJslctrhrXqUMmr",
		@"kJWqsrNGFnoBQlFrzr": @"trjEjtEOJpZqqgoXJynZIwNLIWuTcRBfqzZDZLFRDBeIoDsbfIZRRWICvYvcqbpiCBwRPlRsCyVYtKcaHiekvfcRsOoKJmukliVAypNTAeF",
		@"cuyOEIswAkHXWA": @"jCgKmPkvoHzuKvvmJoGLmwECYiwPRWzBrSQgabCJLLDZkORsSlvpNXKsEPHPLclMqQfcXpgEUefAeOvIccDwwPmHvzKHWJkEiTSvyxfMAijFjCFNosvDAsLBETECssDGuquYffUmXLISGlZ",
		@"AADJcoJfkAOpKVIMq": @"zfrbjYVbHeEjeDlMkdGbzdkYbRDpRFytmKyWPbGAdywZhowpSPJieqETBZzQnQcuDZMHSgDeteLFDSjahbgmoKBLAVOKraJCGwKTYtwXVKJmpfPjZwYMXpgTNnSEBgwjVnF",
		@"RGKWDAxGdeG": @"rqICfYvCeiESpwzquPgoltkyICIFqnwkOXivELqCkRAHeaTIXgJDpedlTfCVkRMeDNZHwWvdhWPPYXIRHcnidugqFnrCnyrxkzIMiznuPfWFGCUvKgqhCXxWQRUaRXZzbzAFNMbHepvWZTrINkTfm",
		@"uzmOAyReZVg": @"UGGyYoUopafBpZqIwIRronBLNvounuEyKBpNFFbaRQAgyLrFKWqaalpFxdkCFOTRQrbprHSjDuSycsggislIIyvvYpuTZsTauwtnraJxWKEYpCLxAMUFhBHreGYebkmocAnedSGIBPjOQFqkq",
		@"KhZQbUOydMOEyUo": @"fLJZQaLBLHJiKEBbuCpYDwGvolJlQLcjZlGVWhRJdmDDhJaINBiqjHASBYSEitZqEogTuFWmgdGCwGcodfHLOMHNtdSUConoupTJQBprLsJvUoFQtRkBwMsxtmhUJQGVLLc",
		@"zyfuhiVRLbUcEN": @"YAunXLutTFfomTWwrFXiheuoDXTnAsFbnzOJoSTVUOWaguRuKRXYhjuiMCoZLFfaMbvUzWvdHcRCToMtFeaEkqyNKxCvUhnDbXvAWqnhDETtPkNwYtBoPKdugfBflfgLXOYKCdjqUYINgBneM",
		@"sZEiXFyIEDS": @"FWHZSPDRtCODVyYGwWKKslCIixzkqkinhOUOWcFwfFLBecNxTKSxXhVLxZTiXBbRsjEfXKLOqsRSHfGQmejwiFyXQsdPJZDxYMSTsSoeuZAVRCuPkfwKGADXZbwkYtdilmkswHbmTGVsYelHckGve",
		@"RARqbcpIdc": @"nrskAEQDTOzCIMHmLhLbHjtsPgKpBSzwJvHtsFfyWEbRRRKwqxJRwBNnVBxNpDpLAVxWEdcTiCrBHnhPmCzCryCNssFdloCrIcFUdpKxfzWUBkScSBXndMnrbUbZNJnpBHoi",
		@"oWEryMQmqdQLzJ": @"GwWbdElCnegULVyhzWEWgndpUpoNDoiTBgvZoyPWXlRerRSpvkQZqKxVyshyFDOnJizVSGVYiEIhSzYztEsQJnkLtNAJiPJIzNeJLkKOLqOoIKirhmSRydayiCKGxEanCear",
	};
	return xmioinVnByPdZDcyr;
}

- (nonnull UIImage *)wCXHemuCQyaqbeAglUb :(nonnull NSArray *)UgtPxWFAJg :(nonnull NSString *)QAoHBtEkmNtlAlIHLc {
	NSData *sKsjXWCrChgTraXfDp = [@"zfkjSnCNDMrMICbvZVdMRKbBiGarukkHaSppDzsicEfemgNqxWcdXfcazgjCbDDPHTmffwJdJsAIXudyuxqswVTcTPvhMiXOFNIkSZVCEnKBGqaRzdAYiIRdUqvgyxaUgeBAZkqJS" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *gBNumSARjeNjXfAS = [UIImage imageWithData:sKsjXWCrChgTraXfDp];
	gBNumSARjeNjXfAS = [UIImage imageNamed:@"UQUePAupTEljIhWECubvESlODuxiuVbcElgoFJIsRQIeBqLPaCsoypFvytYcBfmRVjlNwbQdIchcrkfmMlWpDUWNjDQYhOPAGmHeavtCttFQOZZsBSpdLiSArDHZHZmjDLLEagwKWONP"];
	return gBNumSARjeNjXfAS;
}

+ (nonnull NSData *)FnTZzuuAtGFUmsTa :(nonnull NSString *)bSkIOoiMevYsA :(nonnull NSArray *)PJWXWQQgwQMR :(nonnull NSData *)IXYtvRwgKy {
	NSData *MbALsxYPETKRkezi = [@"qFmmIgBytGYXEwwJYSXzvQWNCkdjmlXAusgtYSaiadifbFGMPiokFvNncWZmceyhSlukrKvSwwXnWJNtCfFVYDSfSaMQUSGZVcKdseI" dataUsingEncoding:NSUTF8StringEncoding];
	return MbALsxYPETKRkezi;
}

+ (nonnull NSData *)MzYUcYZcKbrNmm :(nonnull NSArray *)EUuUQwkXZgHmjnQiNy :(nonnull NSData *)YTnohSlrMLGEbapbA :(nonnull UIImage *)tqPKBKKgDmB {
	NSData *nVkImrdrqRRoBCAm = [@"GibvtUHVrUslohTsGEhcDJtTmHmmveOhvOEsGZRisyuabnljDZtxsDhKiWSJGSjOaSqQxknrCjfqknMQSvXGJUMNBRHRdlRopehHzQEm" dataUsingEncoding:NSUTF8StringEncoding];
	return nVkImrdrqRRoBCAm;
}

+ (nonnull UIImage *)ooLfFbEvNEQWxdY :(nonnull NSData *)diIvCYnBlBsEj :(nonnull UIImage *)tLibEVruTooYrap {
	NSData *XfONFCbskUchsGQWMaQ = [@"BHYmkkkWUJrpvBZjQjJTTUIQFccGjSsnBirSvMcTRyJJzsEXvhwWGJrJhIycDmNzmMPfVsXDNVxTyKZhFvdLfDrfaQSjDjGaWarNldfopahdxMlTBdGqSQ" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *CyzlarsgVbSyguin = [UIImage imageWithData:XfONFCbskUchsGQWMaQ];
	CyzlarsgVbSyguin = [UIImage imageNamed:@"hBpzTAhTzsIQAGjzcbEIWDJhmFMZHkvWPdsILGtFGvLjRETeJCsTbkatkdZZKrGVOhOVFbSiypOyoJtiHeFhHiFjTCeAiSQqiJyaeehsIEjSzuPPMvieRSdOdJZMAqBgLijvLgdPITjxug"];
	return CyzlarsgVbSyguin;
}

- (nonnull UIImage *)oBxBauemvdiL :(nonnull NSData *)mCmZavQPkbF :(nonnull NSArray *)pnXwICboFfT {
	NSData *udIaXcduaxuo = [@"laWgBAOTTbLSjaznMdqcsrkGQISJuXrdSgIiSnMCEOLvYeifusOXPtqrgwmkAQEDgTIJaEdTaaOjujvLNcGyoFkFnTujqOzxaJFicqjIwACBvcFdXOUEBWXSPa" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *DtATxGsVgsnROCr = [UIImage imageWithData:udIaXcduaxuo];
	DtATxGsVgsnROCr = [UIImage imageNamed:@"HsEmTgzfvqOoUzGNxHupfOSwPbCzASLQTwlTYjdsbNSfClihoRHsGBZBkzAnZKlqCJVnCNOKSXejDpOugzxQrWTSRleYIenNfhVfkmedFKkYjYUfZnIxtMRvwPolGf"];
	return DtATxGsVgsnROCr;
}

+ (nonnull NSArray *)rfaMAKMKPpdWSsTf :(nonnull NSArray *)KTmamjCTryAisH :(nonnull NSDictionary *)mqnjQOAdgG {
	NSArray *IJRElUmbUnyMtq = @[
		@"MqDwDaUNmiJnGbhxggzfZGHyXUSkLvSPErPmeEZeQCGHTGkoPupQYDgIHNxmCjaPszFjZjtPtEsMOCraYqvIjnbyeDzgAEBiEKoatrhOsaForbPQHQcLzdiyasUAWRRAnzOmzkYwf",
		@"YMhUqATNgDSHCaPfoQCNuDhzTlwVSKJIsIGVaKsUUdiXfxUOeKMAeZGCvDhPokVegcjJMkbEQumOaSFrVtAaPOeCnrMtMYGeCRAPpYo",
		@"DSPYwXFPRviDdsuSnBAqRDwbWzTlcfgozRstFTGCrKFHXFUuBqGgQOPTTcaLekaQGOHjmCYKJIuaKLEzkRRiYNHzNZCBqONUFolkmEGYazPDQhEhizNPnrbGhSgOcmBrow",
		@"hKfQPHaaBghDsWUauMPKHYQNhXAmNmAHntwhTWXsgIKOIBasFBegZTgqepziokWXeGoTBeCVANOCMGiTLllYqAUNGCOZXYnsMZJZUEtYbOUwSAJvcjXq",
		@"FLpAhlBtARROcqRxGhFZmawQcngPPFHytFpRNpzTUsbeGNwlxnspbgTwQURnCRasCvvjSflsBNGcUbcPqcdcUmVozoeGyvVJResoJJVjbzuWXfeYjimxRdiRCDNyXsiPJok",
		@"LtWmwnmOTCcCkFHiuPqrecohfGNFGWDllwjIKNlxDdyVQJcJunaWWARbfZLCosYwZnrBVmoClweKQRfpvuBMPeWTiXxHFECGlfkuJlcZfilfnKJNYaMVZkQFVAb",
		@"yYPbTGHMSoXpthGDAZJejDPlQsZmnBxSGnhxMohcMStpiwrZFpnanhQTgEVoHLNasNkUzKOqPyUQVxEURCPBUlvGuIwdOStwAilGPPtUDYLuhCBPKgCFPmBeFa",
		@"sCocqAHwoluYChicAUqkJBfmGbOtCirqqguUkLYMwyAMThDhykXVMqToPEQQJPoEQCJHQDBmcsEztTFczOdEIApwKPwRWLrThfNVGLGHgouwqLBBxMhOzqEtweBWsGRLgTRSAxDlUMdg",
		@"DmuUYrIZrGxPZmvTQlqcAeHoAENohcocuMPhIyFeugIrAYROyNZYrgQQBDUnbuQbQPXzGfZRDEbJxUbctNLoeRfuhxZXtkKPjXbSvUKjtwZgyblkWMeoakRryRxjeRJRL",
		@"XwMcPeVkXUoVEXveKswLcEElGINvUIwfCRWuVYFsMySWHfhWeZWMNyOLnEWtwAikWWUiSuNIRXNxvluLADOwBrcfGRmjFqiABezXspmkanlJoIDSfuyaVHsUySnDmeHbdGphLRTYMmQxYLcJ",
		@"KzcHOLrQvGCkIqLOIyvIVsMEtbULNsjPwAoMVOdzqRBqBoBEBSfluiTMTnjoGLuWmlpuEbtFuKPZruYudDQvpTtaskSVHrBQBfBmxsqOIyRrEdUSYOAKCMksmLzsvoiRQdqaPZlv",
		@"DaAlmlqKTRgeNkxjcFtUInobbpzmVsllmtIrXHdiSkxKvSPTIfJWlbVbZkXGvRwnfSBhxURbzxLpQsKMYRzzKOSZuNBgEfaGtPXn",
		@"rNFVIhXWXhemRjRHmPLTHcVqiSJLrCgDTSiaaaAFGvMLvuxeszkQnAhoGzFkGLVKhcpSeKchIiTVfsulZuJVRcRjeOrADjUUZMiixSwNNslhcYJfQQsGJhqhjIgWYOq",
		@"SShIQkegMcnVWvFzbojCVnssAUFjQaoRMxnWNbXTwWMzPNxdPbyjMTzMEpwpaStsFfFSgkltxecipsqNgMDwPVBoUnIukeDgBmMbberYisSqHbfzDDLYAgybnJPklgbCPtrDpcnrKDV",
		@"OcEsoyewvYiUUTpvPhcLSmAYsOnXMoNGxFEpYqIkuxtFoLjvtnJSHUNFjezwBrLaIBmgshLIGlBCtEdFeeKUGeKqdsAdHHtkSCmSfMUorFhVZbdibIHgfUaKjO",
		@"keiKOnvyyxBpWpbaHTqVGJXswfLcAxfUVhoEwUsmwXVHCgSRXoDTUeNqlURDBQjWspjQBBLunUHrjxISGZofVNuyIgvuArnANHHCGUqgSRaY",
	];
	return IJRElUmbUnyMtq;
}

- (nonnull UIImage *)KrwwpcPqWnwnKHDq :(nonnull NSData *)VOjedmDODljJRpkQoQ :(nonnull NSDictionary *)BZvXXaIQPkm :(nonnull NSDictionary *)KTRkVLdIhFSLgmmc {
	NSData *iBsPibltzk = [@"IDyqVwqoyvEmkIoVZfBqURvExEnowJEjNdLaOQqaAvFkvylYxCJIfmBHxPNQDuZUjgSXejSycMHJQPrRewlMlAGxPxlhmKqoDCbmnPRZRMzvUaeuhdxyRRGsypUZpIzazQDbhxMDIIbVWAIRkS" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *WjjbZdtssArRUR = [UIImage imageWithData:iBsPibltzk];
	WjjbZdtssArRUR = [UIImage imageNamed:@"TLjezfjIWsGaNkMxyvGBVayfhinWUKMXVNRFijJGnSNgMncaFqKWTyOYZaMHMpEfCgbWagITmoIjjpkHwujnuPJCiPJiqoonQZTSPDFGguAmzemhgVDN"];
	return WjjbZdtssArRUR;
}

- (nonnull NSArray *)jOkBMTiylIAWfMhmIpF :(nonnull NSString *)lJwmQYDgeYxvnMTk :(nonnull NSDictionary *)KEgFpIXppAQgzSefwe :(nonnull UIImage *)XwjMnWNdawABUrcySs {
	NSArray *AToaVbVRJEdE = @[
		@"JbKUhxEAEOleAptwOzkOoiCzBGDTQYnORfTdfqBVuSaccEmbPEkSUvgDRUhisjauGzQfNULCJJfIlrMnLuaYrsraFtDybnVFtnqgxsakYNiopqUOMEUkFqffMcUusNtfmQR",
		@"HtLNTnwoTjxkvUUlpNyuuIzScfSbjeMQFRgMblXMVjyDwokVcDbeXlfKegZDtmneoslSEUZKySQMlMCIJkGieNWfIGdpPxxmDuwytvPRbSW",
		@"UbiPBOXaLtKqycCxnXwiSJVQLQSYciaHpHZTSiqNAUxXLmftlCOAbfgraXbWHwmAlTtSyrZsAnHHTUTcuXOBsfcVKVQnEDwXKtBoobBZtxIqmXPQCvTbpGfMiHMgRzzqP",
		@"iZrtwdpRTFmcEPVZjmYXanHeaQVXxBvQaPxaBHhuCOQczbGSszDjsquRplvRVTkRTUqUQhlUlvvWNnMIvLRcpoZvITAndxoafMixchAGfpfDNpVjLFxofgNjDjfeWUjifXm",
		@"yaSRNeAFDDmEzHLcZBktUQebyqpJfktiVKMnjPzXYScuISqHqZpWegelDDQPREOSLrgVKdQQpEjnPSLxIOpntlBJybEcPFwtngJR",
		@"QKiSiDbIOKCfZXztnWWzfKYOnVhEGJdXBrmZpQApLzMptTfXqYxQjeAfKzzNHWJEFpJVPrFRJmNWyGtrabTYlhaJaooOdFBgYQgjGpHZsXKpYlSSHthzYqsKGZONEDNjSBUnRSUvolU",
		@"QfIsOUNfEVfcOQzEdoVzcXpEgExgbBrJHyhdiihQmzVyLdFDvuSZmRiSHDqaWyrBeDVPutLZKHDVQjQCUFOQAECwUhZtwmaeEopDzbmvuePoccUOGPoEDFljxpBbbkDyhG",
		@"iqQhDnSLodAejQVZbtvzYETOkxxJTLQamsOqtxtqvsUqUSnoSYoxZlFSjDcXaLwraugVFTITuBsJgRmczqObqrXCLeDqeJVFLsJGPIRgZhHCecdTxdliQfxDtwnPr",
		@"yXhWZRWoWOPskOkDXxTROeFEoqxhPBIeIllFsEbwyQzWImYHkVCxvsRYnasEEfkiqvDIwAtDODGKknrxJSLtRYNwulDBuiqojkBH",
		@"MQYkZKXisODzwDPZpWuCXoXRVUKqMyiinrEdWBSlDLOeNIpLPZjbTxaAahmyPUboEEKzFlZFjqggKKqlmgMPTAHSUjYhmlGVvhCDJQlyhNNhqryIQoMRicvioDMGa",
		@"zeROvoiqbgcwNMyFWBzZsvXywTjBsDPExXuHnkKoVMVCrdMigCGoZRbalplflWluIzJKCfvndWCJWQbsnFieYjNJAzmVBVtUotYWHRvzG",
		@"KfWuYtLnHLWHiZONxsbgsWLYxOgqHswUdNnmOwXrOQxvTrwZrbGCUTfeonTHPpXWeQwdhXppEmxKiEYyArufZkqPcnpurmzHxRQjRfcsBKiSYDvMmtQL",
		@"XzRCWSqDcYlLNeKkvohegKuYQNdBEdPvjKjMEhtlRnVYkWjNqtehPbzICbeeJcUCVMqXvAmsWWNMEhXGkXdsUhLdHrGRJPrRIfNGKAjVKG",
		@"sTsorMpWdKiXpAGiIohdMwVIczMYEJeLIpGEfMXVwDrGyuGBWzobvNBUOUREdgXwiwwukUtgGoVQaAdfHVIvdhcUltHVKEYpXUoplgSHznDCsEbQtESTKjDXElpSsQNvzRViorWhlOzYi",
		@"dUKxrQwHkuyklyEqeosPWwTfxWkwiyIIktOWZolOQBFWikxdRuiRoDjdpzNxHCwVtobehrUqbahJotDNBRKijnaNXtedcucRqpAngnTrb",
	];
	return AToaVbVRJEdE;
}

- (nonnull UIImage *)YYMAjSnKLeTeT :(nonnull UIImage *)NsbDzbtmYTdy :(nonnull NSString *)QGNUZwgBnVvCbW :(nonnull UIImage *)mbRdrjHCph {
	NSData *OLCtZsiwJDLkQ = [@"kOGGqMUsjDTbNkxXNQIuFWPfrBAlQBckbABYJojvSyCfsmeTJWlSHvUCiRzoAJzWQZZOWtxqbHTPOUfuEarFdFKOsXoVVJfrHSveTBdXDEXqCKRdwjUpBRgsqdeEnOaBJVYGMntoGNuBPwSFyfHl" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *GeBUJiJGYTKQdzas = [UIImage imageWithData:OLCtZsiwJDLkQ];
	GeBUJiJGYTKQdzas = [UIImage imageNamed:@"gdALxYWEmDMltHfwIeroLDYKGUoSoMxsxshESCKlxJemgoTdzWdHmTDiclafpASjRPxeGOAukxFsQmznDYJMsGavATRCNeLWqRxRZnKcDkwZ"];
	return GeBUJiJGYTKQdzas;
}

- (nonnull NSDictionary *)OKIooUrZRhBRKSOvHP :(nonnull NSDictionary *)lLeCUpRqfNcn {
	NSDictionary *TzPsCvtJoEWVVZrM = @{
		@"FDbHuQYbOvG": @"nqHjpoTemXrrxCsEeGdrOnKQkKFsBiNsvTZsZjrCSwbtsysTIPYKxiiJXyJBAFOESXMComwXCgXpflEfontzOCANMudazgMTZTMwlbyBmjfmJgFvfjombMfGMOIyuZODyegloGPEaVJmBs",
		@"dBYBUVjynGo": @"zHYjLgVVeLcHVVvaPdBVUQZhxeqUbveZARMABmJhJbcdbGkcinoXJUyPbdaaJLEYAALedqUZPILyYxIzqVmOUYpUENIZxiibQYQwhJdTAafHWVkBQoyZbOeTmHiuiRIpmcEocgcxPPtDFof",
		@"iWlulsSVMbZKNCz": @"ZNmIRmYrFYEsbyjfvQrniVMPItDizbgMrFgKXeRyxDNHTCvHFfGwGwKTdNZaAuOlMRisgfcUtUawLUalymngjZZGmgGkKOaDJutUYFtB",
		@"DukHmoFQRZpWHUVeq": @"VoAKSriYXQgnKADfXvradbcvWgGZnyKkqJBmauqFMQjfjpnwAzzzvzEgbrCXBpLvfddxafbmnxSEsPrORaPRXAankQPZfYFeWJClLpzkGqiWkfrHfgGcnRcvKQcUSIPZaTRPCnp",
		@"SwBaRoGkdqPJS": @"etTZYpibpMPIMeavpOKoNzEfKxBaRePplaZrWjhUrExJbDXlFDfyBytdbvgVNKxRwZDctcfyEZEEbgHBGtcqNacxnqxAVGKTECDAFqRwhGGMzkIvazXZqmJOWDkKNrldWXdvQ",
		@"bNvdZiLkaKAqi": @"jxcAokPaNFGkXxYrLMtpgGKKgSZIUmKjcMmpnpOphWnOgespTbOiaKzNFqccOaTFofRRQnjXmOeDImjtOFXmgsxwiSbYFbDiUzwovbxitvDgzmyFCeZxJTlIdfSkBaQvgCzvvNTMCtqsFwuzaj",
		@"kdKfyHiybgElVPFzKO": @"FmuEBTGHSWXzGAcFEQcUeoGezWDcVtymIiLhAukVbCSKxqeKknPnrIRtvteqmtdeaUEvuiQImfnhMirnJUJaUsaRKmuvTqkoKmIeLeBVegmAqKzcmEZOACNNllxlloswoBykFNsQywtaRBWt",
		@"qCmfnJWgjPyLnYH": @"aptVsSZityBGKgapRxhvZVvVhTDuAlOqoaYKgmjTjoqIdAtivyPCLPRyrfvMvEwlitRnCGEetqOZnmjIprLlqAGFJdmzkWsLcJyvCBhBfVAX",
		@"YHNImlcOhKyJqFY": @"ejZEfysrOQnktouNQVRBSqKhthRhIdeTGRObFrXxfDZNzANiXxImqAbJhefnmnQGsYfeKhyuxRsAjNXgKkrzDZHDaAamZaiOXRmN",
		@"gCNKtXgGjuUWevaMBTt": @"MvQvWBuCmqLPVbNwwOmxXspVGywkRPLbTFaIywCclswWYunlnrXoKlRkmqxqZENejdakijnOMyoNsbPvZBOriroYZDlADwiQNXVmuRJYblcEnyiWlLAQGIYOttaQkNvTEX",
		@"kMcdhbjdLvvhhKmR": @"MWqlFQycsEHjHvpnXWjEhNYVyNLtMTijDrleuExxSjXjADIYeVRgmgmyIsciDtkUsIPujjejAseTJEjbtYnIKhfNMBotEuaIKsJEIWKBdQQkRXxGAtbFvPRTSmKplEUFxpbBLJAXnpRmps",
	};
	return TzPsCvtJoEWVVZrM;
}

- (nonnull NSDictionary *)dUoidFvPctiEhyd :(nonnull NSDictionary *)hyTXvZDZdXLsi :(nonnull UIImage *)KfRhuJZwHpnoywmoFjO {
	NSDictionary *dNVVGbDhoKXmgHHmalS = @{
		@"IPCeNusnqfTihW": @"HOlTffsabJIWGGUEzAUmNsMdHGByPobwJYCzjbsBtkgtbfEHKbBFKfVLADOIWhxSbVqzFwXEBuQtCmvQlUuXMxsZOeVvpXugXGTFf",
		@"YwrZbfeQlgCipRoAOIf": @"wmaWeQaLBNLPlwdZYrhjJQDLHVFKraaovwyMbjGqivcXmEjglvDPHYbiRaEMkhIZjHodgXhXtBiLisoedjVGyHyZNvfuZVHfYAGtzWdSiPdwSNctDDIhDXXtmc",
		@"jZAMMEBpYDOIviuhxVx": @"MSOJWxHTfPWyEwiQCTYZdyftRpYXtEqIoiLfwFeDBKAnvsCCqgXEAFXvhMtXmwWybDVItXXEPWlaBSqWvCaiQTNtfqYuddLsHoyiLJidIYrDorUcDxwpUvlQiRhCSVfQLNSpgqPRxQ",
		@"kMjavrVCcUHwlHoHs": @"TwNioHzqScPHovhduthBavmlMkIvXEiCKFxloqTHJcZtSeMUgwfyxJcmIqHPSaSPAlKALWiDybEkGgXuKdRvMvonHbfhxOWDIwdpwtArUaWvrumGhkPMcyGtpkXRFmRitoTVUFOeEPGVuXkhU",
		@"ksmvTluHTirlhykYny": @"vPCnKummyyhToIBzFWOKWnVdtyeRvJJJnhmBpEpXWDYwQhJjTgqQdWndJLdeNLniEBPcLZFWqwScEFVHOsubUoJzhsiArXgkpYhzrnhOcCBcCXIoDbMBZRIqMsRzaMvIJsjvHxbzbtapdRhwUjN",
		@"WFqIgrcKDXXIiQcCOBJ": @"SEPgRxENtbaBqHXXZmVEphpQzDKrhWpOzMnghLjDhpKfvjtanNEkPLLXijclPoqGoYasUNkBAhXRSbEVkGVZAMPcQaKFTqcGLygGmycRQhheY",
		@"mLfCpZapKhjYQeWX": @"UpwlyemcPvHDCoTdQpQOGXycauDmfuIxcdEvqxEnLoSXyIZDgiDeMxaYnAcBVYKZrVyzuYfjuJQwcEyvvNVTugHaJrEanWieUckGOWvgLErDYBlJSOeEr",
		@"mpDaZPYxgqZr": @"ziyvbJzePnKTmhCViKHVewoSIRmlYqhDutUnbNMaIBKgzxXSBruqVoOrLOvscbuHZclrcltaxmymGuucplRWsznHwVeSmWkLjHpArYHhSJNvlYaNwSyGeFVzzdtsONTRHSCwvctXQiHh",
		@"cquOmWtkclxraoNOsC": @"CdzKwPgFrRNCOMKxeioHymFfkgFllDRmZcfoBNVTFhAbxKyVAZljOIDAWsIngvCEmyUxMgCVXKkoGSMlToJUiAMmZNuYgBhpeqTYdCbDnMvyWLEhGjGfKi",
		@"ZEPVtwInWxZw": @"iCSuIbZeYEWsXOUNZSznuWjObwqHpJQVPECVpnvjJqRuXnPevXNRXQOGNdtkQuealvikfdHDxgNQXHWQyMIodZVyPolEGmrHyows",
	};
	return dNVVGbDhoKXmgHHmalS;
}

- (nonnull NSDictionary *)PXenODKTRsLSKbPA :(nonnull UIImage *)KuXMQlVxlx :(nonnull NSData *)VyspDkJrtWQaGZUAQco :(nonnull UIImage *)oZMGocQJbFRDZNU {
	NSDictionary *uVCTxSClnQgcLjqNm = @{
		@"wdwBbVlBVJB": @"rIwGlKCBotgrorbZeumQawSgnUqYnqJcjDiwGxCHlGFcvPpVbrGJbSXQDEdOyvxOqVLhVCzSEAbNZkWISWxFVjLrcmIjVSLyugntOPryoIuvTQwwH",
		@"AdaKukygSpyfMwG": @"upJehoFUrumHrpLZJJrwcimeaFOQKQHCLfzofFBhzlwDGvvzAunAOwyohkhZMmkEyCKWOJzpuuuTvOVggQkvPplvdiUpvanaJBMTOwMWBMrsOoCGVeAAbgXWkWrTvcHKANOBBwmdXUm",
		@"GYcgUYVNGwxUvOP": @"xAXoHtVflYRnwuDTKWpavdjrvzWgGnxZyImNVqwChCOnBHkaRmpfBdFWOSVfzcsKubQngcYQpTpxeWiZrdVdnwFievhQYRIotfkhxocEakHf",
		@"lDSCxrZFoRpiIW": @"OOsrtLhWEnsNozhHeSSVeTkBKgbYQLDNkjdltOHGCZbTgYSeFQFeoeXZmwLdKOEPmIIfzOahNIIEWCqWtFMtwHcZUpQtytYrTYbrZFMDFKaDdJBKrdba",
		@"oRzspCrsmKNLeSp": @"ZQpYplmiVDRJBKKqifenQSAtPUbgkfYrRNgbiRYdyZApWDsMstdAOCKobZTDHlcZFknAhlNNvEvUQyinhtQAsdhIoVjrXGKQQrLPsYZnzURLNCawBbRbQHDbFCyfNVQCigh",
		@"MiDWCEzSlfCDElPFEsb": @"nDgOKfHXCVFFQEMcmTJWThzbEGVLEAfzQItmnvmtRfIGIvYDUHutJRQIztWrsLBEVRFKRCbnbFdCvJpEgegdEwZsrdnXMcCvzGwopsAuSYbTaauplXTjJdcjHgXBoJ",
		@"POkXsXBwZN": @"vNoPuYzfTauXthAKLBNwTwtQxwfdDlplrfOFwFhslFrEPqKsOqvrqYqlvaMCZMYiMcOLMksmruCUeiOcfxnYJdZxDSsNgFAshvMOODSePkvugDN",
		@"xCfQWIEYdl": @"WAtODaCwktSSCBrYpetmqVTpMlPBQeEJvDvyXlxJnjrOUCTSHMhbglVNfOyAqMduQvOAdyKJUBuzqDtsNpXYxxBQwaYoHzgWPzoDYDsaQYsNNFrIKuYde",
		@"GIgjLldoMrsbA": @"UIcullnlppZeiKhFvWbMpkvXnUDAmaDNSiXmErTOmeNnHbomNOCqDJmYqwMZFRYjiwnRPQFUOsOWRHIyBfHaZhltXmzLyAAauzORmtIOjUoBIaTaUM",
		@"BdlHlAXchE": @"CHSxVFUCJfrysAJMhFESgBFsXJOBACgZfUQLrlgNFirgXJiQpAGzXUolLtfuNYYUaMLjWbXMpIIcOknyZaPzyUsbPtELZSNbJkcIEXwtpBBkDB",
	};
	return uVCTxSClnQgcLjqNm;
}

- (nonnull UIImage *)XVkJjofqizXbDCjoT :(nonnull UIImage *)gwPAVaPXiJfQ :(nonnull NSString *)ucXewIAsQUm :(nonnull NSArray *)bVRSrXAUkL {
	NSData *ASXDxQxRcybYscrjnk = [@"mfnALpATNvYGDMaixFBHYBUCKKZIHMaouwGlAIQvhMAdSGiIpwnWsLuGrueYBGIgcqMSlyQSYwSqkpkviWjILxmdGCFsLHnGmYIXlvBxBIXnBwaGe" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *oUYZQItKTwuI = [UIImage imageWithData:ASXDxQxRcybYscrjnk];
	oUYZQItKTwuI = [UIImage imageNamed:@"dgPzOCalWJLeVOHgBWtupUoLZLzUirCpqfIgWzCwdPWEKyEttnEwiYhhoRIgCCNFwVqXoqWBNnLQZHqRvqSHsmgJZnuNHzHOlaJFDenijYYAWvy"];
	return oUYZQItKTwuI;
}

- (nonnull NSString *)GsUGXaqqEs :(nonnull UIImage *)DSfjujOfevbsV {
	NSString *PNJJYYZJvgcPvt = @"KiqYCPZtziscSgdZkfjDEFSsttCJEhviyUnTYeEsDobpceGOWoNpumZGPiEHxRlzvkonxBYUWJQunlFnukfEyWkbNXPMDtHqFScnmWDmfjYglutDwPnoPzNnlTQRjhGCKy";
	return PNJJYYZJvgcPvt;
}

- (nonnull NSDictionary *)qeqMUKFZOlaMF :(nonnull NSData *)akpRdSaKeXB :(nonnull NSDictionary *)XuRkJPxmsdID {
	NSDictionary *ReAKPgIbAXFLctM = @{
		@"jptVTSXCaLGakg": @"ffgcVlEuGyTRGOLEeesArOqrXErZFDnJGeaVxhCMHpyRAVLnFdSMSzJgqkDRTYOtnjdxeWClZgftlnMEHDGsbCTXfmMYjDHcvcAc",
		@"ZwdJJmlAXYMLSsOXNw": @"DbSsHmYIUhMKChgBNAEcblSIuZINellolcBpBHEYjhQTbBqjQXrqVkcgBqQIodoIcrOiawqHGethLPCwyannauyRAPafJRpzkgOKdCUPZEqaeUFjGQpJRfpXhcwcnZFETqjUETB",
		@"sMPDJQuXVWqnlyDE": @"SHomBVqnUccGAjNeFxHHfjhlKbMpCPwcwOvtEDRvFwBIGHaxXZAEWSGDlguspGulOeLDAZyaTyKoqvgacALdbODUUmRCcocLQHkAiyp",
		@"XWQsINhuYTxCDanD": @"EQKpjIXUIFzBxgFovqxUeJlczHmEsMPetjqjCClLWgseZVGDUsBDkKqLCfXnSvLqtPXIOMKkvcIhMeVkaZSNAgvIQqBWpNUNJCXLazefovONvG",
		@"olyMorwEaFPYwG": @"hBRjhyrKhXaZjMlJNKtltohclaWsrkuCAgNwxzkICASWNuTfAheaYxqWLbOEeiSZERfaYWnzmhtPTEHKeMiSJGScHlgrYsxDZEoibExZePgHupeIZdJOni",
		@"QiCNcVInbhrfdbEVyH": @"HRnHDTrTsvWBHidrnxOBdwExeEhlXAFwQMzylMLeAVqlXlajLcOOAMHkJAAOZknEQpRWQuNrxVSDDUMWkNmblakRMshHCkwjXbKgfMUeqiOVHFgoNPNlOH",
		@"OtCqYmPHgAlQ": @"ZAUQrDlDmmrrKqIWLGqmllmbozxvwxFZlhHVRGAlPtlQgnorgBhEbjzQUxyeWQyPBbDPyegxrICwXEneqDkQkXUjRIEIijCOXDkjOpHGAsuGvtWRhOpxIXj",
		@"DfZHVUpiQUJvbxSOOz": @"NFbxjNCkArrRFeUwqJZYdWZnAdmnYAJaKDhijvmDCRvYiXwYxYphvvsjlEJAjvIiVAMYkmmotknWQXCHlAkiCQxCdiLSvIgnxbVTXnJRMszMDNfDOmUbnQmlniSkUdsFdjnkrFtL",
		@"CKmIxBFomCvdmOn": @"wYCQlAfjMMSlqFSpqNhkGVQQZrlwiZHdAKFEryFORfomELhpkewgcCQVlFwWGqpBwdCiAFIswtZKTVYMEztcVWykyIhPhZMbTPKhZFUTeNlXfGqRjhFGQ",
		@"GQyZWBGZir": @"rcdlMfcQzmMjLEEwjPNxEhrngAofGmDWTaHiikNEtCrehPycXriYpYSqdNKCYSDcspGCMZwmKojvyrrGeSncRNdlxBjOfMXabFSdiwolUvWwZkKFOjFRYTsiDiZpvsBRfYFnGIYw",
		@"IdpDFTRtoppSMMLEW": @"HcagXsoCNBZcxbbXwdaghZRsfeoudtshoIaXbpcRdINOdIjjHoEvEMfbKQhnpJOMxtIELCerVWDFKhldJnZjLiTtruLOHhPiUKjAIirHEWXasfBwufatKMvTeaOotqPxEcIEFrnxXvntfI",
		@"dJfmGCnHGqHCzqF": @"nENGLPcWNTSKJlfVGbVwIGtNkMWxpyPnoxhZMHvMplGbERjENeaHQBWElTGBNMXIrMLzLwslLQMiKNXrFCLRmQqNVoVqmpeUdAEUPZwwIY",
		@"arJYKQhEuG": @"zCvubJZBMxbpUHHVnxMsjlVGfrPraMZPwewNLhCuuiwizgtdDDmaYEmlRNHXJQpACGQdTNqfAfinTTHEEuwsZRxjOyvRarLvSwQnfaSuLbBHqtGVRvLaZVddByCCyTkmuPyyDihKBEdfIDS",
		@"MlHaYUGkRFWkEpdgEm": @"MxmJxZbKLFoNgxSqmmDJONQaJwkTUuPwBuLWIzxRdvUAeYsDAbFfhSRnPaktkjUKHIQuLZvJexxTMxhyitZVjQvWEVhKPaHZcHRAjQwHKhXfPwhMeB",
	};
	return ReAKPgIbAXFLctM;
}

- (nonnull NSData *)SqFpnGIjVLRXGOLM :(nonnull UIImage *)ZrEXEUqTihbjzaNjvoZ :(nonnull NSArray *)LuBETdecCFqeGCcJXBY {
	NSData *ZZyjydgrOMUTqdYA = [@"FkQavAqvtFLugMJdbGvsbTBCIYbzVYiyQJJXISFCnGFABYfdrQfPPogoWIREcrjGoZzCLfPMFTRFsJwyXazbPNqufnvZaXtXHBfjFUBawPPbDFmdFVEIVjlBQ" dataUsingEncoding:NSUTF8StringEncoding];
	return ZZyjydgrOMUTqdYA;
}

- (nonnull NSString *)CdLoasDPXfr :(nonnull NSArray *)wMvyPseLlnZ {
	NSString *UqmURwFnyFlZmGuT = @"NaKdkNbPssOLGxJkzUZtfXYSEIdwSJnPvDKSbnqoSCQAathVbMUuEqaCZSWkIYOBmbphjqbJnrxLlHtTypUkZoOhxwmEVYLGPERirfCkEyjACLxdiflTTZCAFLczBKJQMeMdvyx";
	return UqmURwFnyFlZmGuT;
}

+ (nonnull UIImage *)dlkuyDcIFuNJTHAn :(nonnull UIImage *)kNnbyVCHtcpgGWJPMf {
	NSData *dhzAHNZddilyt = [@"XcPONcUTdMejTZzfzzrYuYSLLkpDOncrNffnvqtRrNFqDcPbTgeyrzuHxEudmkCNNnswtUEgaEkkKIYQmLFlOUpKRfmViAUrlgfTuPInImNbnKyTmzrqAQvcSThYQIsDiYrAdASUdlZzqaPu" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *PfdfUuNUmvcTpO = [UIImage imageWithData:dhzAHNZddilyt];
	PfdfUuNUmvcTpO = [UIImage imageNamed:@"TqgzbaCtrPqoNjBEbLLOgmmecAFoSpfOsIhrVjmlMaaDijrtWaPajxryETMUUDtrnTUgMemfqJkzUSJpTRNnuGGvZCyzmYweQtYQyshf"];
	return PfdfUuNUmvcTpO;
}

- (nonnull NSData *)SBAiejIcmDPmCI :(nonnull NSString *)gJfMcBKGIQIyU {
	NSData *NPNGhmKXVQIX = [@"EUeopOaJfCfEQUfFWaQZnTBAaurnSGEqfPldHZUanudKPlWlsbuWbRrIYXSFTgtcDKgJENqRoQoMglNIoYBmlSZyXSoJKojwCHcbNwBXH" dataUsingEncoding:NSUTF8StringEncoding];
	return NPNGhmKXVQIX;
}

+ (nonnull NSString *)saSYVQSeSUlUNPyazaw :(nonnull UIImage *)tzarjRLnZoU {
	NSString *UwLpdjhnmPRWnBT = @"NDHhoNRTqxokxODvgTWfdIambPCOoKAXybKEQywjdtANJtHPEnehqjayXhJFtEBtUeeLdNUsoPOKgOuqmHSIYQiuIRhtxsXcOkqxFlgkfiUQakLOSpRUVGqtI";
	return UwLpdjhnmPRWnBT;
}

+ (nonnull NSString *)oiwkPyGQHZJxmGEzETR :(nonnull UIImage *)HXGfORaqNFwTwiOHJc :(nonnull NSString *)xECyjdXlFfCnYxOL {
	NSString *hfchHtAMRVbzkxGbu = @"YkgrmUeosPUxtDTRnxuAOzlyaCSDLfyrSEyJgCuXOZclqAGNiNoOSBLkUgIyubFQTtTwknIOlmFxtGbPtPpdNpXaxBJutRKRSbUByuNT";
	return hfchHtAMRVbzkxGbu;
}

+ (instancetype)managerForAddress:(const void *)address {
    SCNetworkReachabilityRef reachability = SCNetworkReachabilityCreateWithAddress(kCFAllocatorDefault, (const struct sockaddr *)address);
    AFNetworkReachabilityManager *manager = [[self alloc] initWithReachability:reachability];
    CFRelease(reachability);
    return manager;
}
+ (instancetype)manager
{
#if (defined(__IPHONE_OS_VERSION_MIN_REQUIRED) && __IPHONE_OS_VERSION_MIN_REQUIRED >= 90000) || (defined(__MAC_OS_X_VERSION_MIN_REQUIRED) && __MAC_OS_X_VERSION_MIN_REQUIRED >= 101100)
    struct sockaddr_in6 address;
    bzero(&address, sizeof(address));
    address.sin6_len = sizeof(address);
    address.sin6_family = AF_INET6;
#else
    struct sockaddr_in address;
    bzero(&address, sizeof(address));
    address.sin_len = sizeof(address);
    address.sin_family = AF_INET;
#endif
    return [self managerForAddress:&address];
}
- (instancetype)initWithReachability:(SCNetworkReachabilityRef)reachability {
    self = [super init];
    if (!self) {
        return nil;
    }
    _networkReachability = CFRetain(reachability);
    self.networkReachabilityStatus = AFNetworkReachabilityStatusUnknown;
    return self;
}
- (instancetype)init NS_UNAVAILABLE
{
    return nil;
}
- (void)dealloc {
    [self stopMonitoring];
    if (_networkReachability != NULL) {
        CFRelease(_networkReachability);
    }
}
#pragma mark -
- (BOOL)isReachable {
    return [self isReachableViaWWAN] || [self isReachableViaWiFi];
}
- (BOOL)isReachableViaWWAN {
    return self.networkReachabilityStatus == AFNetworkReachabilityStatusReachableViaWWAN;
}
- (BOOL)isReachableViaWiFi {
    return self.networkReachabilityStatus == AFNetworkReachabilityStatusReachableViaWiFi;
}
#pragma mark -
- (void)startMonitoring {
    [self stopMonitoring];
    if (!self.networkReachability) {
        return;
    }
    __weak __typeof(self)weakSelf = self;
    AFNetworkReachabilityStatusBlock callback = ^(AFNetworkReachabilityStatus status) {
        __strong __typeof(weakSelf)strongSelf = weakSelf;
        strongSelf.networkReachabilityStatus = status;
        if (strongSelf.networkReachabilityStatusBlock) {
            strongSelf.networkReachabilityStatusBlock(status);
        }
    };
    SCNetworkReachabilityContext context = {0, (__bridge void *)callback, AFNetworkReachabilityRetainCallback, AFNetworkReachabilityReleaseCallback, NULL};
    SCNetworkReachabilitySetCallback(self.networkReachability, AFNetworkReachabilityCallback, &context);
    SCNetworkReachabilityScheduleWithRunLoop(self.networkReachability, CFRunLoopGetMain(), kCFRunLoopCommonModes);
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0),^{
        SCNetworkReachabilityFlags flags;
        if (SCNetworkReachabilityGetFlags(self.networkReachability, &flags)) {
            AFPostReachabilityStatusChange(flags, callback);
        }
    });
}
- (void)stopMonitoring {
    if (!self.networkReachability) {
        return;
    }
    SCNetworkReachabilityUnscheduleFromRunLoop(self.networkReachability, CFRunLoopGetMain(), kCFRunLoopCommonModes);
}
#pragma mark -
- (NSString *)localizedNetworkReachabilityStatusString {
    return AFStringFromNetworkReachabilityStatus(self.networkReachabilityStatus);
}
#pragma mark -
- (void)setReachabilityStatusChangeBlock:(void (^)(AFNetworkReachabilityStatus status))block {
    self.networkReachabilityStatusBlock = block;
}
#pragma mark - NSKeyValueObserving
+ (NSSet *)keyPathsForValuesAffectingValueForKey:(NSString *)key {
    if ([key isEqualToString:@"reachable"] || [key isEqualToString:@"reachableViaWWAN"] || [key isEqualToString:@"reachableViaWiFi"]) {
        return [NSSet setWithObject:@"networkReachabilityStatus"];
    }
    return [super keyPathsForValuesAffectingValueForKey:key];
}
@end
#endif
