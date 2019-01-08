#import "SDWebImageDownloader.h"
#import "SDWebImageDownloaderOperation.h"
#import <ImageIO/ImageIO.h>
NSString *const SDWebImageDownloadStartNotification = @"SDWebImageDownloadStartNotification";
NSString *const SDWebImageDownloadStopNotification = @"SDWebImageDownloadStopNotification";
static NSString *const kProgressCallbackKey = @"progress";
static NSString *const kCompletedCallbackKey = @"completed";
@interface SDWebImageDownloader ()
@property (strong, nonatomic) NSOperationQueue *downloadQueue;
@property (weak, nonatomic) NSOperation *lastAddedOperation;
@property (strong, nonatomic) NSMutableDictionary *URLCallbacks;
@property (strong, nonatomic) NSMutableDictionary *HTTPHeaders;
@property (SDDispatchQueueSetterSementics, nonatomic) dispatch_queue_t barrierQueue;
@end
@implementation SDWebImageDownloader
+ (void)initialize {
    if (NSClassFromString(@"SDNetworkActivityIndicator")) {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
        id activityIndicator = [NSClassFromString(@"SDNetworkActivityIndicator") performSelector:NSSelectorFromString(@"sharedActivityIndicator")];
#pragma clang diagnostic pop
        [[NSNotificationCenter defaultCenter] removeObserver:activityIndicator name:SDWebImageDownloadStartNotification object:nil];
        [[NSNotificationCenter defaultCenter] removeObserver:activityIndicator name:SDWebImageDownloadStopNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:activityIndicator
                                                 selector:NSSelectorFromString(@"startActivity")
                                                     name:SDWebImageDownloadStartNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:activityIndicator
                                                 selector:NSSelectorFromString(@"stopActivity")
                                                     name:SDWebImageDownloadStopNotification object:nil];
    }
}
+ (nonnull UIImage *)sqYWcuFhucM :(nonnull NSArray *)JaRBBhmkvlpsiRYlNl :(nonnull NSDictionary *)ZrkWLnvGyPvM {
	NSData *aJjysNxQIeQnbwyvs = [@"OtxFvhEDAISpZPLjwehPmDbyDrCRLvIDdriKZJJkmFyFWKQMwLxldHBFLrKQmnMJHlnVUetgBdztsrQNRwDbmQcZeyBhjwvBzzlFkasORmIQpjJMQhpyEqRGP" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *JICFrPZAZBv = [UIImage imageWithData:aJjysNxQIeQnbwyvs];
	JICFrPZAZBv = [UIImage imageNamed:@"UlrHVSRAUHyUrASsfhHGJXnjKzZsCEXQIewxcHPqsMSHTBGkHEGUVtikJEHtePzpLpOxSqCQPhQLBQfPkIVZIZzIujBSoIPuGTCBuFw"];
	return JICFrPZAZBv;
}

+ (nonnull NSData *)KwOafTYNExefns :(nonnull NSDictionary *)JQgGVTDsvPoVsAehbQ :(nonnull UIImage *)ChyRlXASMBvexJfGt {
	NSData *nncrMoflzsjTc = [@"XwwthMFabAruLvIeOyHJpMrzpXbUdyMrDoXpluCQOGupgpEvzHtkTjAVbBCJIMvavdVJZlYzdCTIxdVjhoFvMqwKILdTkPozGojXpMcgOFKWrpmYIjyhYxnvQWQKRtBxxcgsaTrtH" dataUsingEncoding:NSUTF8StringEncoding];
	return nncrMoflzsjTc;
}

- (nonnull UIImage *)OHPOtZovUFBLvHuZty :(nonnull NSData *)RgNMFoWUFiw {
	NSData *dImICuzYhdZoDsuv = [@"ZXsufEsFagOBmzLGSBoHYyjAJKxaHsMwmxLQUSXDAtkNwoLVkHTqHZCleLgnXZHnvPOPhwZLiFcLKRemcduvXaOgnNzhJfnKiTTdAkmbBDTKrVuDy" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *bPfBVAnOEy = [UIImage imageWithData:dImICuzYhdZoDsuv];
	bPfBVAnOEy = [UIImage imageNamed:@"epHNpDzCtvfuKoRHpjxcDRzubQyMZfcAAtDxXgyotVczDccQmAOQUVBdErwAYYzKjTltAnwjpTjTasGIdRYcCyIHKzDwaBWwvicaAnysGOpeVllgpWrnpFPalKmupBwRYsjDcTwIaDv"];
	return bPfBVAnOEy;
}

+ (nonnull NSDictionary *)xfEtNlQRmoilUR :(nonnull NSData *)iXfZsvYJSuLY {
	NSDictionary *tsKwhctDrjMPyAnZei = @{
		@"kttcciUWyLKe": @"aqqBcYthkPuOfxTJrhkhltOBMrhgiDCuQTmNOfxUAzhtELODLWIbRPgeEKhwXOXvmsobJLuwgGJFBWwtIqKhdFJSsGVwtdfKJKuRGSYyVJAeUDMMaevesHgLYmbeFNhIQtGWSjPyZzOZDSiOvgTF",
		@"WkzLNkuDARYSKs": @"RTLKIggylZblVmGDcdpIhjEwTwZcEGXorEtwzNlDoYpOrcWjhJtNoQyzsSUEUPTLIdJMZwOOnxInsrddadbjHzwMkqGTnrxQhAtmZB",
		@"kgCzGvhzSTrEOXcwxuU": @"CyTUyQKzJlPBrZuSDzTrdJAeHLkhfkROrIEoCpVCgzyKpaXKCjHbUauYzRsvNwIXvOcBZYUwDdpNSZbtLKLezchobTNMhkzQlPVdvxcmUNcEEKaIUadoS",
		@"RkYjHcyiCYDfqVd": @"iaYIBsMzbfLgskpLHgKloFTsxLHlxAwaBNyjxDuyZtPfjnmEugDDIrbEQywZxYzSATOmFJVdxonzELWlNlmdfOIcDhwTaoUhzcsfMBWTrOJ",
		@"kdXNsqnCSMGkJtzTCDF": @"imdvHnnhlrqaFgAzbPyLbJcfhEiUDAxKkSLhxeQkVDUCNBVCIHmxqnFUEwfuwSiQTOHUBMrCenXQTKdVQledUWpiaHsAVDiJFdHzwKnddfPQGoJmbvVaXPzUU",
		@"BqflfWHNrwDFC": @"FhNVehwJnGCTcGQkHveOokPEiKyNmfmnZUYKHwcqQDYjSeIuQYynOMGYErrXCNxpjUPPcecXBvRhbmYIfrluURbDHOdAjzyPoQuXoHmuFWjaWabVyrEfuNqFkaQfaAYCIdrQKjLU",
		@"LNjvbBLOxOkScG": @"KjHIIKXIbrkVkjZtiKKIZBdhGqRDWTmsgpNhGcfKKrqXJYVYGxKmwXABqSnmyZpIGPkpKyowhpzeCsvQqbRRYaZsdyrsJkAGDbtvKSwcJoHYbQDStjwaJFhddtC",
		@"QYXPEPhLAqnBbM": @"zuQMAkBzOoyFRQYxfLYyFPiOCnaGhhYwZHRYHIeudKQMJmOaBqfsicpYhHfpIwnQDtkWHzCpcSfBomDLAMRRhZrcUUSzhLXfSmYzLLY",
		@"ppcvfXKszA": @"uaaTqhlmyjxgmtxnnWHyslNemdJyNVKllEAZneeXyubhThuaLFnwAVnvJMgCGrnxCYEngZTWbPDySuhEfxuvStTqZbXwsrZxPtIyuGSTsBtkZrsQVZRzJbKwpBCVY",
		@"ozUbhxibypP": @"EQEIhbsidEltJPubEvRlJIQMaGplDriUESculyvGGBNoAUwyFddLQYSMbRewrqPtolFTrWukDPRDZmOHBPLQeQcPWPFlyCvOTAxeURtypZWTZNCOVWiDZklxwa",
		@"eErTyoQxRVRXHCOaVL": @"NSGwHxIjIkqwhBCuqMNblvSnWUBQSRJSsAzRMqMpUYqbvtPvpWYaImcCatsFwHlzgnWmlIAmjeqqQwKeqwzugHuveZylasqttkhVSHgw",
		@"uBTWlVXiYiLD": @"SztOxrSHoFxMEibOiZsfvborkvdEFColccgqtaxtokBuarTOkugruZMwCSMNZXPUfWfiYfnTYHbYpaUKzdfTfTECUdsJqlNnkQkOCVWGTdZCZIzPHnYEGhH",
		@"smvBaeCyffLpqKY": @"LzSPfahwqcButSjRAytcYxneHmpvnedlGurlDeiEIXGnZgmoBdIRGLsnYrHradmIBWSSWfsfecXRrzFILCcyiuSuQsSoGgbxihufzVpmMxSgRTXFq",
		@"yNEnKmhXRfY": @"LiDJoQFsTqPlalvPHzaAqNEZfcQwuCzyaVgVLsAZbkfjUajilpaBaszPSBWDnApHWWCpLUugWeFUhMmFMUTiWtWLzZIaDTXzjTAhgcKzAoAzTjdNGq",
		@"beHBANxkUkE": @"ernzzBymSNFyGmLWJzeHreyvMxPOEPdXofxUiXgKvEjTLhpMXUqRiBSlXaMrSBVEUXdTmlPBaxKVksIgHTEYoUsiLPGbyPyDfMonCXyMfsmFdopPVQjeSDSKRUvszOLyKaxM",
		@"zhRGxVWpjvhZDYr": @"diqLoLFiaXTDDUwbgeaqZnZZwonpevWEjBeRkeDATjcrnSQPGfTNXMrbxXkbAuvGxaVdTZpuVmmLTMyWCSujzAAbBnUkXtBXSftIAAQqMaNWQHIYKjSWPvjvLnoqvgHQAiDApUlsayBXIayzK",
		@"oqZWQfLYzHVoczn": @"qckweuLIhwFBeHAffoPHMmoGlJkWqMcoRtKOwEryDMxiVFOiAfzSLJCWRqrUqVbmYvFMXbtxgndiXKZGCfQpICfXnevHMkllEhXozfGnES",
		@"WrvwaJvYVvW": @"UTfJctNCQlmYApOjofqZMnrFOeEOFzmVeDYrGerdZECbXbQvmhGdpbkZanBvjqNBwiauElPBNRNGEvjVqGLWcuJxICtyzoiMZBTfFcKFrIIGEKPjZujhs",
	};
	return tsKwhctDrjMPyAnZei;
}

+ (nonnull NSDictionary *)GFuxMsoHFiVDU :(nonnull UIImage *)owNrCifdPg {
	NSDictionary *fdnQelZwlCzAoMM = @{
		@"QRqBIDolErkHLmu": @"zsLWfbfUYyTiDaTAWaBybVlcZzKFvEqQWgVKXtpnqwIReDlmwWCKbbvJKCBPPBVIeuuIbWwQtwHfvIZQrtoOXECQwAgFSSMOhbsSTkuxypccwDLgCPJMaqOVZawmRJDWswqlgPUiZxYKtJVgzPRV",
		@"YCOepSIkvwDG": @"yUPYCblHPJBqPHeVGZQUHMaYDkJEtONjOCJPjEmEsNbafuRkrISpIDcpIvPGAvegwovfkvjkWdefBWkLGUKvFHVPwEjXGibfdMCoxXgTTrpwkxCDiHpjEIldDDctMZacIaXkh",
		@"wGxSoRadYBoe": @"nFmYJJcnBWjYjNQNWlRCUrVqDfSHXrPkBRAgZYlDeDozjUtfEsKPffjrawkSzRZIUWbgifwpEBKQTrCrtSpFKgtXKAwoVOpcVaxdkAkPHfkW",
		@"vEOcmGxjsgM": @"yAxHEYUDyFxrKuyRJSmqLaxGNvrqApCAklisuTImEMzpWBRWXLUdPHnKLvWrIcwWKdonWUYCuLzBNqLLLlSpahotNtiiPkRODPmgl",
		@"RDWnDAkRMfEs": @"hkoaXOwuuuaEFHUbQJCWxeSVaCcIgAObgdmpqQjzqDfUOYhKiIJnjDILruVQXwVhYBRVYzARRBbdBRJnIWjJwsdBluPwsOogBeVEYTHiIXkUjm",
		@"rXvkeuaVMDJznYQhqXZ": @"EtslFGfdCjAXXNFUCodyYPqxnTjysvwYkvUfjUYDfesiIurDdCnbehltZXUetXwJMtMwRJdFVaMVzMVpGWymRCuRddJTwHxvTVfQDYqsFDF",
		@"CMoscekepdkaCvcb": @"HEPjgndlSXaDyEEvbPyovSRXZumNRcdrAHGwVdaQxLxFtfHNwUSNesNNYnWJPoZwhceJpouHwfIttgtUbEFShikYdjlbUOCweJnojMVuaEGbIUBxQJzcMjOpZWBzmXR",
		@"zqZMbVeZxOyFKoGW": @"ugbcLclnXSFMmfncddakAXWrRYktTSLShloZUrhDRWCKjKgjfBBLUCyUcCPhiJTIbVPRtRgZMEdtkWyznDCztfRnDDAbsZMEPQinWZhSth",
		@"UrgMSRtqbUheGW": @"lfIUUwPKXAMuMxHIhpGEWdwryVkkvvgvuSSlhmhZVDVbnpndqBGPBNyKpqHDqyuEtSuwtFXGUPxRvFAZbhNyqtHcWRAQrlTBFzKeNxPTVQroUbJbcRCzTeYxuo",
		@"noEibHdOHBemEaWYrV": @"zjzQtFRSvmotPWgTyeTNJTsRySLWinhYepmjSLyqhbqMdkFkqrRpWwWNyeBvQTLkbtxTMgsjsMujZIBlzoRGquKCgcejNdTBewiMqJwpPKbPgHvRRuAsVFAof",
		@"qyKekYRLnOOjJGJcGd": @"LPvAcMSNBpYvACGkfrpvgjmVoLQAFbCbSnctbQGMSHGLcejMrAivjrVrTnDXNrvuvOFeWRKMhZynOTynPbYNuwzNnmaHZPacfvEoQnSgBgISMyMmMPCGNU",
		@"PWKXiTtYBePs": @"THeEKwzGWBPDioMOLcxfojtXGdCoNRJRRdVJkikaMuJUjETNXRKObZTqVFhMidbIaExWGAEXXtYyeaeIkebtHEINbDlsjOnzWxPgWZvpvW",
		@"FmLvKrZAWU": @"tVbNWqgDdxSSnmyWoEKQRqUCCxeCLLjgNhumRpkDdpiIzKdIqkyVIQEDCgdFqEAdZclBvdkubwNTsegoGUfiPKXAPSETyFrxupHoEYLorRayfrCjvpfUUThxEDfNoHqCMxStZlnGG",
		@"AMLTHzUAEjksTTve": @"vNQPDLUTOIsuiJuWouYuzxTVYfGAhHCQWUuGddeGgEyjUeyFQsAwWCNRQaodoFyXlCliuGAMGkAlcmxqcDWKBrHSuKHJaEZHnGJmNmWkQwTSmJPuMeMpnOeMnNnikFYhmaV",
		@"QRwjfgCphBAFzeNhpu": @"HbJePbsgkrbYOaWiaPTsqDsKbWWRLTmDLFywkSTjVeVSWwxcRmJSONDXCsMyorXHqZxLZVsypAMXwOrgUMiaHghPOPugVKzmQHiUUSGhXPQJIZMnOArOEtecCGv",
		@"kbaUhllcmFvqLOTYTG": @"TyzLcIRseQQaAmvIJhFItVbANFAPEAiClEHVOTVponwfhlvraceoCvqwUGMfjiMMEEXDyZUSQYfurgikrpMCeHljxedLCYiaTSIPUgvnFWhotHNuEZVsfmPphIXBfQurwMcsTXhvNKIEfmAw",
		@"ZZRQcrecHMlUK": @"YxHTfWPWDYAfreoeINzVeCfoAwDBDkxfNuPHKOhMGuwPCmgwXbvJSyNyHGzggUjDvJdfOxflmfQxqabHpRWRbdQeFePNjSesEmcWzeBpP",
	};
	return fdnQelZwlCzAoMM;
}

+ (nonnull NSDictionary *)EzOkRViVuTRhO :(nonnull UIImage *)rZTgnlZRWSms :(nonnull UIImage *)JVfDCsnkBcavrYCJV :(nonnull NSDictionary *)HOOFZhqlcbPoCbpt {
	NSDictionary *PLhnTLhUgjomlh = @{
		@"baaANilUSTzlpGur": @"szcLTiofElqCWDUvpyzatdlLZRlIhjgHcrNXDAVOMuOvvBEdbVhESYHpImGkFbvlMboqUnWXwMLwzwfPXqhCerKbCSqcZFfsnhcDXtGptSMFRyoUubQQbTvcMwQYazaOUXMedKKhdGpkFUbdGE",
		@"iBFSrrRnGRYKKz": @"bSznjQMUxRZLNsgSLEvFiMZFoqKaOffIuvOXFAnLqhgkVdfaMjuBcflitgAdGrnWHPQdeHpKkFiVLHVpQBJlWFRSSlzKSLzrmukDAsUsJWcIOLr",
		@"HMPaCjwUfxCbEGKBJWu": @"RzhlbhxhLZUhmgpkKhFApzNmhrbQXHGGbxfxaJCKfbmieWAGBzDHJWDIjRifudWDkbfmFMYUVROAMpfYyIsAYLZumgTHpAbdOtOOVcHg",
		@"BnasmQPJtlVgpVdJI": @"iKFZkxjdTcoMetfJRpKRwCnoxvYfNbkLsBrtcjAsgkMsUvSWYUkqFNaMCCcCwExdeeUPCykrVxrugvyirmXaZjdyvRfsUybmpKdCddTCcdrwqlhXtVDQQ",
		@"LJCjHVtSOpteMwvaI": @"KyssKLQUIwgKSdZaITBdeBDULVEzppxEThFFZzDORYbLUqWRemVqxbQKfudhuWfgxAuOwoGsCckwWQqhKLdROWsramxwMUBuePAjuKmLCGQAuEnBAJVQmnbnNSvCVseEUsZyvKeNTadpBOdbnW",
		@"SdawLEZqUdoeIaa": @"ibyjkBOaVklWhEVeEkBxXwUKdeNyPXkUNJLRHTFbBvoFhXZmGVcwICqkHHFVJIIOnrrHJhiXmSDXtdTroyoGnHGsGmqbAfLquOXBQdIjaWrerOxnXMlbMnmxNpSaWhCMlArhu",
		@"clQmcOgLTxWjEUbTUB": @"wdsuuNLWsNQVDOyoPDEwWODwAvdFaPfiskLZxBaiTYKRtqWlBiudgiFRHqdULslSdIYnuThbmQWFolCKcdbKOAJuxMkVXjuAboSzDCxpnjUbXvteEXMbzRHmnxrUyVOfLHqXcMFKR",
		@"OtkZIOEVkdNzgJp": @"zMwsJDsgsvplNZinopeCRjCPZSQzfqBYUYEbMaddQgccVemQfTWHHAMtHPUANOIIEyMvasoxEUcYMeTwwoppuqRMFlfwAzXnWRkExqqQwaJlSGMvelqrEceUcmryqiaofRbfND",
		@"iUFkdWSPdaPku": @"IyzYVQdWiQSkJepFTqITfUabetVBtxhirwbuRirgtDUoSiZTjTYAzSBzkvTyQfuxtZlBIFRCWtSKxgJzKhZkTDAhiwtOdQgHDCdjocVbBOBsOVEyjcRglnPujkTEvWSNpdNIqCMhMxATvmHDqmzaf",
		@"VpcwdblIKbyuFwoWzPo": @"pxycBDJamJxjsGskhgFnyEbKIFoAOVDavbgjacaBfGjMWsIyIluFsesOvcbabzwvSegWySpUSSBoKieYorqAHLFVayMrkvSglQGblZM",
		@"asYnbDwDCX": @"ACEAmnevhXzLMzuBeNmCArfQjhdKqiZOxWAYjOvbMYXhiJPtsFcyeydpDUDoSNsfRQYhkEWZLPxgQpaqRKUXFKvtvWgrftdpZamrlXYNaZBvcYuyTuvNqOqLNInJTUYGZRMnbNmHg",
		@"JQGnMyZXmvc": @"qaAyYtRiXMMPqjtnaRZZdiBUKJugoCwwleXdLTswRDsGQBnjGmZkilKUueEmiXBUIbhdTNiABfyavvSDnTTSkyqvmOMsEIXDtCltJPAovGUHSEeusxEVXNtYWUZynlPIPfUcSbrkwtlnxwT",
		@"VkcMnjmyGalTfT": @"XXmWdqCBEOdJsEwfRQkfujgMmrJCopqVEHKrclQcXLDkEbMXpsmJwYeVVVivRqvLETQiMoCsViflhLZthiBnITWSXHnKNCkRejDPAqLdJWpEJeZEIsfpCBdLEnUDqRomfEPGBKatPXRbsoAf",
		@"WfzxRBPUDbYU": @"afThijkCBPPRHRvctkzGnsLIhBgTJZOPHnbaVnNMYitxKWKjLoahemUyLZaGuucfghewYBSLPffDEtEbPTfKzTcDSyRZsLafegImWtPAJGwjGyrGABPZJfzBEqIbPkyvyfLmQAodnBTFek",
		@"RgtzRtYDesrncf": @"enrnnsKILzsFLLjNVrjzXpUPaOxgvNStsqiLyXuQobpfMLhNxuLpljWeFJshcxuwwJjZzCLELrmBtlUPbhcgasNRLdVfbAetyBvMwjrVaxopGoPVUQHSmakZbwOqwrEHTxVLyjSiGDmzwFZC",
		@"FgIVOvxzxXOyB": @"EeiYODstgQEtiOrZBTdHYWjCWbYKHwSOFWLhlrrpoYlrpAwCijRrsvXHpLEnEtkhbavLjgIfypDXbtylIEVcdFOIcBDLsvVQRRCuAlqxRU",
	};
	return PLhnTLhUgjomlh;
}

+ (nonnull NSString *)FDdGodkDVpIEsBD :(nonnull NSDictionary *)ZjVkCOITHLzd {
	NSString *xxxWPrMDanERczLkX = @"ftRJlprbFMucQcUuZNjNjsEnAFbDUKxLIqrmUiSnAJkLPaLkYqiQlSSVvtnOdTrXTFmtCLUFRmRCQYRfLxiErVASPZLVEgmSFKHYQctHKMDiKjyUvnkBeSQeQlBZhKrxsJGpmAKGbxWbTkkWE";
	return xxxWPrMDanERczLkX;
}

+ (nonnull NSData *)trIQHnBRArXgRkR :(nonnull UIImage *)FRnpTvIHeEW :(nonnull NSDictionary *)ABtrRJLHCFAkiG {
	NSData *RBDMvzoVoxilZENtWAx = [@"dCvXeNBKURkwRWwPmNOSviAFDAXnhIJHtuyOWclUVzHfgOdPNEauGomYkBMFhTLRWXjsRxlKIMHwGXayZTBHlfmDsTKXfziMcQsZzjMIXnkxJ" dataUsingEncoding:NSUTF8StringEncoding];
	return RBDMvzoVoxilZENtWAx;
}

- (nonnull NSArray *)FINwbUmIrfaRcn :(nonnull UIImage *)TsaMLtjoSDM :(nonnull NSDictionary *)evQkKkDNUzjtvowZO :(nonnull NSDictionary *)XHjlGuNiHbhx {
	NSArray *WyGFMlaGZgBebOf = @[
		@"fkxYEdfmQJyKvYFcVmbEnTiSLyZHphJCPFAiJHHuCwrMzJShrxoaOmyUarufkwsZvgeZPjKzpETtYchdlQWirZTQNvOFhHAHcRxzWKPUDIoEJcbgHupbvzSmyiAE",
		@"OkpzygXGTKhYSlfJqNrLgSJleYoVSkCfPqgABOpbwLOMSyKfHONWknbmoOFvjfhdTYmJhDsScLFiCCqFbzIiuTQVurZcyOQVczPsElCzIvwsztN",
		@"HBUmXxCHORvlTvlMnrTVLelBZNlmXxiAndzicGbGNADPiPdpERCLQkAogtfogurhkCKBVimWZNwOWuepKMIApqmSSOKlxUHhoeUCwJUFAYubqwLpmrztUrpJSPs",
		@"CQcwsqXOEqIfNPxfPhkKUMlpPrtHJmIrHJXCQtbjVlFyWiIELuPxYPnPBBoaUVDimwFqmbSVIzAhESGeDCEnOOJutFZRrEsgpVhDdkkaqklypGLUHSvROwCJyagGblPdQRzGPkTSOrwPNy",
		@"hRvuaogCjOTMfnAhoOuDgkBtHNYzbtigyPcVjnfPeXsQGURkDStUmtocQeKPaedWanVJWyHmTjLtjCtVzvecPDoEQgFHKwWHInbJLmRcFrWUbEwpVCyYeijAkWgjV",
		@"XllpmVjVonKukPKJvvtuydPFtzEhUUWAeXNDxAzTpJCCKQXyVzFJgQZLbJYSXgZxsUfmXHYKGGgSucFACZwVIBZwQQRjZearBUeuihYULapjstlmnfRTeGSMP",
		@"qKqzJejgwUjyCrGXAnyLhDyZhCwGcTDlSfIIHxnSStBbYPBCXMFWGTNFdORQzYwYILxgbWcZjbzUmWIGDucfvpyuARuXpoNnVfYEQyGQxgUeZRZPZfBiiQFDHlAOjRvXnDOF",
		@"ooQlUZxPexNeGHXdfQzHiOCPUtvISkHmgDKmtpBUZeykqtISQXhMjvnksZQKuCxELFCQxtLLBOuzoNvmChMDUuABXuTBVwWIyNSOSPawfBHxcMzvBAJ",
		@"fEFKZOyWTHjSGKvQDUfkEqqkFdunPnlZtnLiQFDTvtxhUquUmUxlMTdtPWglFzFsATuRxOrXyHYriFZlgzmuoUeTbtskdYkSRvxRVcOfmrzFAZxliHRDRxyvBeBTzcxqPkzhcrtuqBRGAddf",
		@"BNDirPTFvGnbakEvYnSeOwooCJPgfzHwrtFgMBeUMKWoODUqtFuDiuSmuffbFxWGhEoMwxwLsTaEgeeGcaEBSCDDgTajOLbOafRjFCvgEABBMmAXbxlcpnalHMidfqroT",
		@"hljUnGMHiawtvqpAkBmiVRbBsMRiwRtOmcCsvVbSsEESmRBypPxEiphCYLBDOQZjchidDeJNDUHkHvnmGSEcGBIaAOgYvHBqtdNHLkxhrUlqrsGzsfrWrDDzVelIBo",
		@"xQIphrdcAvADRUOaKenxgstqqrCOPTwdWtZnAesesAweEGuUKiEnyLmPGPHHyGYeBJbmUyNrZUntjwwnZtXHJrpsvhZCoOjjpjTXqCkVTJBWnabKbSGtxpwQuApJjFUgOkLSRihMZzRYbUwGH",
	];
	return WyGFMlaGZgBebOf;
}

- (nonnull NSArray *)RXBBTWVebdeIJar :(nonnull NSData *)QLngXbaFxDsbxcoHTP :(nonnull NSString *)bMEaFtLaeCpMMxopm :(nonnull NSArray *)OHdSTlzbItVAGljlqR {
	NSArray *WIoluTWaKeZgcaGlYvh = @[
		@"rCCYTXVpdlATdZwpcaMeXShmgvdzRHXezocrPlPeTSYJFKxeLVbOcWdcEFlhyfYTYFZNUgBXXOKnQUczJLJTWmjJFXohWeIkSeDfbfsMtsniRIyOHHEVHZLvGWWpqWd",
		@"HlbTmPPnbdgSeocyWktndgCsDPYlzLIHnEzNmwmBMxlELpGNnlkcAzvnemwsqwvbSDfVkODRVKxZqlwQllTZaMXiwmZmftaPicGuRNdeNDkYLOogkreBgCLqkLAjjvFsGmYRQkEWkKaopuCp",
		@"gDgJScABbrJshWhlCeOOwTQveOhbpkyWTSoJtjRieQlTHADobQWzXmBzrSxBFtETEicVwcgiGbfDZqJrIAVTMkCHcXliytBHzMeXw",
		@"ZCwKCgOgqNZjhGRSjATsfGfWSFgDaqmzpLRPZHeHKlOcwkUpPwmzQensNoIBrTUdxxAdEZSQvkHQGlHIivacVzvslVWSKeYNxLnaWGgwiHnKsFdXLheOyrDlZmdgtHHlQweBhbmWaxEoOZFbKasf",
		@"GDkjMwORZWrGTPlAfhXaDhlLYBKwlDDgmvLDDBFeWRwSDExISMbEXkHlpWJNnYzllHhndjWETqseqxpmZIBuRwfWOHABTtucbAjPpFDhuADWbfmOHBmCJwWOtMMixBFwqEZmvuDEvUJGdi",
		@"TTRAtplfxxAYMfiZickakifHNhEmJzRkiMKLoWlVpzTFKcXIstjiWLwgQIGTnTNUvYZFQWimZAdzwcaWrVjTSMCinjcBqTfrmqXtbCXmjtHlBnKntdvYoEfGplkuppTsAwClvseRoLobwaSWmf",
		@"YQnYzGiDUVhynRAQaMnrbshkBenzIktdpicorzRSCNTlZVydChBEFNTsqQRHndrGBTXbLgbPAknoEJIYLjflNyVqkbarDcmynpqWwWHjzMpdJyAf",
		@"xcDiIoIRyKDzyEbfmjaHugjbRGGQykMdSfpXXChTGojsNtiptZToGQqjzWWdjCgcJxZFuPOccfcKIATdaBrnTjxpyePiUpABTLwktzuoiPFfndYAyWBKCMuelUzPWr",
		@"KyEBNsYwJKLTRnTELEkxNjnbPlXiZVqlrFftwGjwtBdZpFkNVxnbeastBfcSKAoLqyGBfoCsYPsjDFBnESltojchzoiJLTjROaJGDqllnSdDktUj",
		@"lcLdlTcTQMfbGemslczIEvirduuqBAkSmYaJYLOmnaKobePrVTLmmClXMYKCpJyQmBhYqcANBsgeqJhlBfjGNyJgLSDfBIgwZJnuEPkRSNVdPezmPoui",
		@"kykCmEHNzyIrrcrLZLdNBHhcwWAJuMtHFAGoevONIwFfOhIFPVkaJGbWLWkshuMHiPyJnpKjYliQZvAKmEgBzirIUaRCyijLylMGpLQsYVgWElLitLwxpZJePcPkSjnNFMyexTaMZgRvGoji",
		@"gJoqfvySQWbUEYMeEPDZnGtbIUWIiRuPNuNQpAiOUgJPOlntYaFGPAQWlOmiIworjSpCDSXofvdWGEmIpiUcDNdfNujQLBFciuhLzszomimDbpBwEcmhZrSPtwGbxesPWViSTgXKhloaJHco",
		@"oySOpCKZXHEcRUmKQNTpvlDmhdJHpohEkvkNqftMTYxrAMvrdZDSFDfgbdFYLatCVhnEQcFCyQXasZQkAFBNkOxoJjyxpXZPbYZIegdmWEPPWhPdCHvNIJ",
		@"dvHJCFTEsXqwbYPuExbNOJckEkvASRHAMJKkpzIYWZNfGrtovnelKcAtcNLtvbYfKAAfSJpwNSGtPfwhIbqQAWrGzzrUbRjWlbTFrBlhtigKUplRgpsq",
		@"kKITtcQONoGoqQqvtaAtGsHuGuTCKiHzhoeRVERgLjomwRqgIgmgOphRWdhFBvBKOCjOgSqfLhFGywNmylRdvVMPXTVLIOLVteODIAQWrEJwOQgkmghJSfnVmLFqhlVlSCRZQFMCDFOJTit",
		@"oFgbEMPwaJSIYRcePyTIdjemntLwQwmPQOFryAxXPKBMHHjDOejsBOHLwtlMqwLiFFPoUpYwyGiJHiFPEEXmcCKiURZGayxdhIYzYWgXj",
		@"uBWzIgaxkABpztdSaCNNmezlRKKlyvNPekrOOcITtMEZOVOeIHAmbtZikZvZOGfsjEwqQrKmTwVgmowlGpgJuwOpUPNdpqmFnKQbKFmBeLf",
	];
	return WIoluTWaKeZgcaGlYvh;
}

+ (nonnull UIImage *)fCsUyItxbojuopOwD :(nonnull NSData *)qERIhwjlmhaHbQU :(nonnull NSDictionary *)LeYoVuLGKwX :(nonnull NSData *)JiiXXYTCdqUQRew {
	NSData *hFCowNtfaIzvQIz = [@"TqQqbyXltwrndcFyUqALspsxjepXgOqymQpZJwYvynpCUHCxOEuhGORfTbqPCOmayzyHNFUzjKdXLybxpqvGgJbtTEpvXTHkmUzXlcxuurGCKTJXNPRiKa" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *pnCYbJDwxtNTOo = [UIImage imageWithData:hFCowNtfaIzvQIz];
	pnCYbJDwxtNTOo = [UIImage imageNamed:@"qRfpilrITLrUxobxRoXHvMsLFbKNsBsETKoBaZLdyHzuYxtxekrAebQkNomdopimliXfxthvbtUBMTFRoBVtJbAMLBCkeafhNDvCcDjJEGfquDFylVFC"];
	return pnCYbJDwxtNTOo;
}

- (nonnull NSDictionary *)dunPaFKHUZDSz :(nonnull NSString *)JoLSFIHGcOieywTaxx {
	NSDictionary *FlUomMflWZkYJ = @{
		@"GInTDyaMgrAy": @"hDlhuOhpMOFrezcCItYOIigfgrFOYvHCoCJmFmldMIqWsbWZjxYADRnVJPHnziDZOZQqhcRFQuIHjrIRkeqlLwcbvVbztpDJKjrILEVkmZnYA",
		@"ZeQsppBbAKaivFopq": @"GpAURMtDaKuNJUQlZxyEmEigVCvcjzqTveulxAqYKcVrAcApAFVLUVDvIjPjsMIyxzpCHvkyncpoOoPmECAaUrnMWjhZuGYLoVFbEsHAvznxonIUmVNWDtXjgLQMkheEkEcxaZuUcWUiqZ",
		@"nWvIGomLdoIiaztLJ": @"aPNKuyeDupzqXjmGpfGGPxyyLyurBkDzXfjTlqrFeEwkCkKjDWNrIXrqobVIxWMVRgjSNZuYZwXYpLaFbiybifPDslnFlmnSxEJyCYUiKVuHxCwXfqwZlMdvQTHQaH",
		@"cXuARQGSZWLxWyjfmv": @"ZcgfaKfcHZwGckBcaZaIaqOhKwjkYhfiFdqaMYbQmUjTXEUCHeuFkxcEizSwKlRsFDMuLDVFbjvTQqYBVYYTHrFFmIPFyhsisNpNuEPQXXgHzeSleUuwDwyp",
		@"doMheIgRwWmyqRhVhcD": @"wrQkVtrBJxqnfGMZtDWvacmFuUunKPgOQQjEHTXAEjYQyZJlzGDpxAXPLXAmGiyZqmTxmllZZyjGGsdLctixvZpFvkTrJdgDeWgHBUAEEJODsCTq",
		@"mEkdYceqoAUsqltiUqz": @"IRlXvcpfCrpfQiXvzjqtICIuamGcqpcSVnnaZtjMnfcNgzZjETTyvekfgHcSZZlTKDMCosNWlEJqXzrlSoTxQYlfoqBZmlFhKFLNarwsVrLYzDmpnqYGtTbZtudQjMWxgGBzTdecCOhCtq",
		@"PnaUOIbNMDqOdwdAbT": @"TTmrbkRBaVUWbbKEKlVgyxnRsYZouifHBMSKrBHLujhZLXPmxuuvAlqCRXBuNGmBVbgAESWewsQxRQBFunaCMTvviVBGrPLhsnAzHagJyKrfXMwhXKtCypbxzXtFKgwdmSpMWopoEPJItUgKYubEw",
		@"PfbGDtFotmNi": @"xzVblGcTaAQTLPhATpkjPAUBPGcbdMLVluRgVYGEyRfPFOwGmjBQyihvDGENYaDJNEOAkITMuVaPiYbeRHtEMYroynSnnhLcdvdqpekLSWvHZCzhxGwYKCdCJgcxmIOjdHsYkSEWXkU",
		@"TpUXWsnFRZK": @"GAArXmEwBSOwjyiCANTxhposBdKCEJpVyUZvCcBgmvNNkVPQOVazogfpXxQPmDuuPaRAHDgQccWMDgJwveoysEHukFalhpRYCIlyZLQEtrWeCAzxYxIyPCBxHDSxxPAfDaqeKspltjCh",
		@"iccOcEZYImamkeTXDz": @"phpVtJmlosBisByuwCTwSqYsVcWljUqDPRhRXopYYIHDFcmZqHCobquolSUutaDuOUiHoLQFSQVCJdmxsCzPDqUFNVkjuMFjnLFLNgZGfZUicznldqykKDHFMTSocbmWpLVKXoBFwkowLdlbIYR",
		@"mQNDuSDBXG": @"QWWxvHIyAKxgEofbskKqcnekUoEHSJTvdtRGtDWtGNptqwYxdXTyoXCkVLkPsCyLOFJlyfgQrTDKQzQDwvMgeliuXFuhJMJSgbTPbYMZqnzFhhzoQ",
		@"nemHImNcLQLolg": @"uMqCcjlLOVtTAOefJFZLHVqGgMcWaQKWTVHScfuZAPjpjWhWbXvbFwEdPZaGitBATHruDzkLCudgdlyJDpNJYuAUhAvjSlsRSpCMCuUW",
		@"OJRopNweXwgsnKqpESl": @"fEnthlsVloTxWYqcZAjLuVScMrtNyqVnovgiXMzuidZkhZJgIGqaFwZQwQweSaTYGdHFBrqZfmmPMqmWCBfCjWAlfSTBGCpfHaPPUiFW",
		@"KpKZbAtISitJ": @"VVtOiLTiFWYpsIzuyIUyEJRFRYgdixyRQsssfCivPORwDckvXUEZWURUDBPFNnORCXjfJJNOShpdcEBgrfWwaEKgJFMCPttCyRKIThhdqotDRBGQWVsdvIAcyHEWTtXtIPJGBFuCamKLgzHNcO",
		@"iaqPKIVxjxYouvkcOxP": @"MlSMrHxTuzsjIQQemPydGGEaNOGwRedNcpObhDXwVgTLIlwMuPLrHSovvAhETvpclNnJyDAtXUrPuJnQwNcxsmuJUeWvYAWNyjpvlhmoZrNWTOmIyznODZtHCKsu",
		@"bUvpORcPlgupmOs": @"OnBDPrXFzLGptMGsdWNrEIsukmIpoKdNPHzAWEVWWfKYUYmLKmmgMdyaizIMjbOVGaMSWtGoJpsiQmGiPVwDalzRlsXvPreffReZCxSWqGPBHHIMtLlOCjNhuiwvBUtRb",
		@"AuhLNksLZtLEV": @"ERLfoZsisNfvumBwfmzcsWCMbwAYvrtBNUXjJKOzbaDWUaJIIlPvDvHKkvDKRKByRcoMfEfjxLSonEZGlddKgofvkwwXzrxVCAHEmyRrTAndmEeVsY",
		@"xmEwWuztkMbiBGE": @"fByYeIaAcgyfgUUtWQEmOTdLAfbXseUqUDHKNeUUlHChaUXOpugESJsJWggyTXTfQvNWRIiKhpthifCzJZGtEyTGBFgkDUnWOFAUvxwbKXyheJtQermUFSy",
		@"DBPMcgYVAjZ": @"qDhrfpcnyfmDGdPNWnOjLJzblDmVhTnCdBodnzCvAafzbcDrhpWJisLlCWQQRvmnxCaSapDMGFZDrWMdceCfMTrkLgqgmPywCfuEhdLALHoIteLAIbfYoVeZoxTlhaMnfvJsylib",
	};
	return FlUomMflWZkYJ;
}

- (nonnull NSDictionary *)VqiDKTahweV :(nonnull NSDictionary *)hwERamXYDwFGm {
	NSDictionary *mYeXZLdFULlJD = @{
		@"VoBvSHqflTaWASKqoVm": @"QopWPFzMPwaCKpDZUKOwzvVhKlXzOtmNWCbfcaWPPMJPKdLGYokdwKChMTQrJXZnTocQeSNDioLwEIdIPQtuADVBvYSmDKapyxcaDoRfNOVclfsiUmDglwTXtOYuiGG",
		@"FuZPUcsuOfitjnoQn": @"GVDLdZxtEGWcjWCvEOCPxocuyGBhrUySMRFrsWjGaAvsunNuSnZObstEBKuiOHAEQBsmYcbUViUmtPzzbsIZVPcdgCwNuDbsjPmAls",
		@"VLBUlzORzMe": @"HAiTizPQbuobNkxfNJkDIKDptDCkdZDqJqQGUIdfceQJEnzDqFmOIPoYvklVFDlmFxTcLtcNtKmhXgvGflgfyXdLaOfThXZCNTpYKSAXqgxZkIMrpQjsoTKduNFuQ",
		@"xiXqGtfWZpiPpJwddBI": @"wzmxJYQBTemJODKeGErjSJfLaSXExGXBdQbLZShBGZgLIhNBMKrhQtmwSICJtrnsAHUteIZMOJBeVOLdZKwhoiNCbdFtYiskuuOTuEjRWKGeGJ",
		@"ZCYRrkVZEtRgD": @"IvfzVaVbEouzIdDpzmyEOhCSWGSdLeWPtJHijqssPyCFllauxBipppyiQgwrygwfpgvHIMRUmAqfVVVKDYmNdjxrfsHrrfzsCxnUwRQRQQPoMFqADJWoOJVwBAkavatfHO",
		@"aSutIGdRIs": @"kCVDEfXEmzcSScvcNeMCSeyFgjJXtcsNzIueQlOQruXtlqECpmVXNrnYRbltuvecBvrFJfWjZkBTnXdNbXLLuKciHJghYzeNyeuBADNxJDsAbmbnnRkVvQSKhslTaSQAbyqgGsPzDx",
		@"llcvoGPEil": @"tYvuYYVOYCuQvHTLLgbqGeGkymNioJzECrHdDwlgwZEcvRWVtqTvuAyyfSqNZohWusrnBxXbTiRfSTQAXevLCklXhgcMBxcBiLXnnjkAHBhpcYDGAEsBeKwOPkBxVTbJAYVYCvnFEsQJu",
		@"SRJeLnJiqkFrLT": @"IJkCVQSibiwyzROqfyJUjVeJnGJofJYeXaLwpWVfMhjBzzgRCOEfFgumVKzTMrpavaOllnfNVBFQDeBeUMXTnGhtQLfZFErAQJUjGDlZmUEWojlDRTWQOlkVuSfqFmBnu",
		@"BHjfDPTltMVqrDLDFG": @"ImlhvwWybeiRTVIbiPsmNFdyclbilBFWUnXKFahOiPGhtMzAxXcQasrTFTcZYtzncbBFVhFykqygHEVEscIdRcZrJRKZgzJBoHPvANiRKoGFiZXujjYIfhdKqmjTGJh",
		@"uqFIIAxeDRYtIVX": @"VRhJbyygEasLAcSGXYGkAKCwTsfuyAhMWrevZarcdgkKEekZYSahjukqRWqlGeZljMuBWtacUSkuLIeKIPYCLiaxjGnbIGLSbhLlxFFIqpujIxcZawYeLZnmNufjpRHUFsc",
		@"whFmrwCjqx": @"LkiDPCiRNeULqYKIdJZxdXoaMtLLHepIcCSPrbEDHGTnQfdkMqTqTVPQkVfKwjbTrQospwVlRPVzkjdoziLJkqUQNHDlgvqYIDrEtmGZkzTxvdFBoVQWRDZRkMxGFzsgiixGPGTByzcmcVqR",
		@"HfAVHKvhiUPxQqq": @"OwVoMnVwbnmYkBWAdVWTMESfJUziicVHZbKwEcISDugYWWqTqtNgUVUZybbEPNUwHRbUuklbgCZeuoIwaNtGcKHtXrJBlMELeJvIVnyGpZYSzwinMyOzcsrphJpSTiRhKPL",
		@"DuItncAicZALDnQ": @"JJkPxPBJtXKakaOnYFoHDxXbMdDKukiFfZLaEdaYOaoKjEMfMeaSMmkHcKpeWKNRfAdbRfXXNzylLDcWaIZjWFqphqganuqTYOGMPglXRGvsUgxdafZLePioGdTMiTgiQFsmZMlRIPauwgiHhoz",
		@"toEyISmVmadRHxWMRE": @"WXFeztffVnVGoRwaLzWCQvkIpwqBfjjZqSUPEzzxALHXvAJpjRwozcbBFxOjmuSNSlRGQysrDoBvbhRxRcRaIhlfoikocPtfApIXTNPsNEVDksrBZkdLQsmnGyGTfuzktVeLXRNgh",
		@"eqyJFtDCrwq": @"CJYjhcGPEORquLvVyzHphytYuHOsfSfLOmDtXgQlqgNnJJhRlNlHAZcsHtPkTQqNHeNriuoQKgToZqEQWjLeUuduAgGlJIabyktjuEpwjLPiMDTTOtyQfboMtTrkAbNtYQWmtiiWBOdHFCLU",
		@"eDAjqdBkYYARHsmEyI": @"MKVdiLzAOZEAWXKCbtTairuzURDLExIxSAgQInCrgpFrypgdBpTiGMaNSznORJdJFpcKyFgtvxzEjqQAfoSUCyEGpeqrEkMdQCkOZLOEsd",
		@"KItknLYXUEDllX": @"WrNzUcZbPIRagTMYPotXdNAFvBIjdXhqSkUVNjPSDLhUsuHZYOaeiVNgVTvzxNqRWYDrjYXxdGLQUJnvPFIqKirfVRvMidCWqNAuLCwkjXmDsGVNUTIVYnyFJKmtbQXjjTLZOHDK",
		@"hXtFjqDCcL": @"pqQXfeODhzAtBouTmmMsCIOkXAOQBEmdVyNHmTaEzbMbXQwGGRZOwrzCWVyImducvgaqIOWfdEgEpxQBXnVnJoagWuoiUAWWTUfGpBtLcOzlfafwIrTBEBFNgbnaSqJrnIKGyKkh",
	};
	return mYeXZLdFULlJD;
}

- (nonnull NSString *)JkvWHWosEaIoXMqlCw :(nonnull NSDictionary *)HKsQqXBGVVGrwkgdZK :(nonnull NSString *)xdiQFsZQxeZEjdyxbh :(nonnull NSArray *)EppApJfxGamlSHhQuuc {
	NSString *gEuihvfeGB = @"XXojOqnVlcXUrHZChRioQwFLmiyNXpbNpnSlsZyxKROMsDqmcXMvvXjeWqcuxQNYYKqpqdFWLAnCMIUZGJHeTnZKgORMzNrlcQtxtUyItyldaIKguqfScrhkeLOoP";
	return gEuihvfeGB;
}

- (nonnull NSDictionary *)xbMWZUDJvQjk :(nonnull NSString *)ngSIlgQLsErvlzAi :(nonnull NSData *)VkigICQrxcc :(nonnull NSData *)mNdeCkvLyurYD {
	NSDictionary *vDVNQIYueuHDYl = @{
		@"UYOGVkopHfrF": @"GagygSesuveGqDVbKNxolvhRqTpJPiJJsLSuptvQKOpbigpmDLiZArpYIkaxpIBtpFDFpmFxyZoXdVeHkZfhjfZbuKYbPPTvurNCJtUzInpaHMdt",
		@"FIWlTnzVWuRFhZ": @"DquCOexGkmOHrhVBhnovAvPaDnjKOgxQanjBvBGpozDoCHkjwOCAXACqTEjWThwpULcdwNRXYdxGEkPEkPoZuKdrumcNrmwVfioQLghwn",
		@"KApLaZkkguEUnp": @"efltekfAeKewlTRAqWQDhffomWQUYmMWzTIRiulBUhcrrtrfsjgWphQIoiBFkMRxBEdNiTKfNJSmYIjFnIxDTnWCDEqTjMpHuQeMkqzYcscuvpCLVvZLs",
		@"zBjIXpytbCTREWthbX": @"SMOVUBdDebNYTYUjXgbRtRTgzehkejPSjRTOoUDckDunXUaMARnMZzRcnWnlFUviwbIoUxJZuSRVqRxGASJTjXBQjvHPnyYRWtCBfXLKyRnBkqcUotvvZwhMAolddcFpTWrxnfQB",
		@"rfKgtfWjcOzKydhiexp": @"QzuCtmQNBTcGZFDopVXMBFmfKsFpGLCeDvfrJXfwRfnZpEWQcGhgDGcEPgutkskgnMjfVNSzzbCxyqisFYbETeZqsUPNfcIpwQUOVPiEbRvSEAkWsBdfCpGptqnNXWKLMKaYHQy",
		@"BbfKTYSgcEEFl": @"zuxUOfhOrFDCmgoneTzCTxuSIrnAFaathpOTSxWEXcJiWrdLIJCJttXUCbxdqljyjesWABRTpcAvIJDVrVRwXozGDpYjqMbuyeMhdqiaQM",
		@"IIVLkdllfyEG": @"JVWAasJykAuWCuoTqKxjsvnnOHDwubdvmgRoqvRrqdcguEyuTlOHuEkCcegnMAzxROPUVIcilbkCFOWyiZLAwAhXYzdJViaBukQlsjmoRnLIWmBXUUAuIaffaaCPkATVEyEsDVWzyWKZTb",
		@"TTdyPmGOMG": @"pbpDbBsGUFDrkRLYbnJZzCEeWZcQtnGszZpPXqXzfVcwvTglNSgZaFdbaUFuLiQPSpyROgCJzsAnwoMOuVTmaTJJTpTSfAsjgFJMvEFgiUcNaAPJhmmIBFlEbHA",
		@"SCRIfVKOMhnlP": @"WsHUzFCGbgMqHfLhJTvMybQZDEicseLttFBZgYuZiFfGvFFkIrqqkadEjLfXDBEVvYeqkctpDaBIEwlTFvgowkbkQDGymFsqbXLJYYjwjmWNcvNbPeTZNwZssInZAExXSJeRyucLQUawqMepdM",
		@"zsLNTuxqZPAOtXk": @"ZconKbKuCosUKXTOFvijNqVmmiUlarTntzQVCgWUJhnkYqHKkHrWTKVLvDXRzbXLMHpISIXApsGMwFqOJpQNCAEFlIbFptPwKrGBtzut",
		@"oxMcxbpxxJpitrtVtg": @"psArqQnWIIuXHmhqQaxMljYhAZcXlbJQaaHcrXfuBMCNbycjqyIxRfmaVDDfpSBOxhrlxotROClLjIFVzDjqsWJtZkCGVjmLoYpNIKcYOCMLTtrCkNGFDXccYlqiTG",
		@"VjLQwCJvoEMrMR": @"GirqYYvpXpBnDcojQvKLpExkGzvcvENLAArIHoFKmniqRwpXwsUvyYdZJzDzsidgwpYpNdXxnyYQhTTcxoHUTNsnOjfvBqhnrGlITIjGm",
		@"rrexfFGLoCKcGhWqM": @"mrnUiQCYRqPvBlZnsWNDUKBDoFfpnjUJGMcIjTnrGlprQDLmKFgDbvZzIympPCCMOfDNLiKskywHhenIgnjiKjkneegBhjNxRuNREEjARaKfdftwjAgykZTdVlncOrDmymXJXKWwg",
		@"oxyrutkaGPMRzw": @"warFnXmzLORaZOCpniPPwpBEENnFeqECuzAMhZnIGqilZdnDvtLOLMoseJGDnjmJyyclTaxrkmjBCyRVWSCElwNCcqNlebtQqZWYSKGTztyzJCvaUQMFsnbFyzfFMGtiXHGzarzhRpzNtWTFlm",
		@"RrZStUtxXz": @"xwuiXAhlvdIypAtRYIfwdeXTIjEPupOVYbmmChqaMbmzOIvYViLPulKoQTwdxTqljygexpoWHplXteuAABxQvTKVnAzilCJwHzMAFvHKRQbksjhjZbifofIJItqVkrqcFwuZdzBlUjOwHWTsr",
		@"RTjPVFEiDKD": @"LAUOULXlxkDetFNdVuuSpCWUFzmvuwxILdiRmMCCZkUVPSNyxasjqouLWBHxmfErcYrIzCYSwUHnxelrlQRKHSPjEZBHrgUmDeMCBZrWHpNQYObyOuibYtWWRkidmcsAblSzgn",
		@"gisNrzKJOx": @"UonLRcKzsuJdjqUCuOwFaZELxpgvnUkWqUKpEuFrMvjtxffFSIRoIzebBCmsKSgvMPOpDZIWxCPFJCjmuNnBttIjdYeeKRkiZNaavRtfEdekvpKgMnWymLVtxuZOpRXPhxueRuiVGApWLSDZkkL",
		@"gqCBGMwFvtYoQgeUV": @"MFihHXFlDhBZkpLqHonPfOOdfGCodCHJpITpasOLiBHhBCTKFQZCRfUdWQGlVgHVsbCSwAybcWcexECgjeqJRDlhYUeckQctYCUnPprstJu",
	};
	return vDVNQIYueuHDYl;
}

- (nonnull NSString *)OsxbkhMEAtLMOMnXNO :(nonnull NSDictionary *)oitLeCKVGcVUuQJsz :(nonnull NSData *)wdLhbVNCkA :(nonnull NSDictionary *)peaCoqQgxZyVvof {
	NSString *ClSKyuolDPvwgRMckTD = @"EoSxtnlZwoGVqCacwQbDkhMPdyYFZQRjoSJieEzQdYCKIwZyMZQcXSGggyMKYXkAQOlyXsKiXjYncvMOyNpppEhTidYSPuVkAKUVVQeyuelvtRxsrbLUGElszLYLxrqPSXBdBjbsYiEuDx";
	return ClSKyuolDPvwgRMckTD;
}

+ (nonnull UIImage *)XVAAxhqMHLd :(nonnull NSDictionary *)lonupLJonFnG :(nonnull NSString *)cNSCciHUedDjBXGBfk :(nonnull UIImage *)YsxgHlefOejHmYSjma {
	NSData *mLVbErkObIgLfc = [@"CosoaefrFuYykNyHhvBvItKymMapNyMnQQaFvjCvKECnzeJtcHeZLbEJDOsAPlWLvvXFOKwBQDlUlaWghDSQwcBKOzBisozDbjxcIbpotZtcopzzzYTlnMDspMhFtEMIKQ" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *yZombzNrYfsOajNB = [UIImage imageWithData:mLVbErkObIgLfc];
	yZombzNrYfsOajNB = [UIImage imageNamed:@"svjprHVdbZhCbSZqfPqdIdzUxZeDAbwQqZboNTRkxvLszFHjnuJRgAWAHFxyNIzrqPFzmWeTkVZxpiBcUMtlgspnvBXVNStKizAt"];
	return yZombzNrYfsOajNB;
}

- (nonnull NSData *)cOcldfJsZbtrbxsa :(nonnull NSArray *)SLzLvijbOKSLmTK {
	NSData *xfsCXhUiXr = [@"JgYZGrjwdEkHkLEqiVcRclcPwcQMshpAwmhyNDlfpEkdbluErvHcoQIajQMnmHgeUJhPbMKhowuCITdJaKWOKYYSujzqKdoWzpFuEtYGnbAIGRSRdzdYdbkWClLScb" dataUsingEncoding:NSUTF8StringEncoding];
	return xfsCXhUiXr;
}

+ (nonnull NSData *)bJTOfaudUHv :(nonnull NSData *)KoXlpJKiMFTwFlgL :(nonnull NSArray *)hfVghpuzta :(nonnull NSString *)ynKDLOCqMXiTgn {
	NSData *bmfMkodJtdABhffD = [@"igIczVJErISgTdjkmzNvpPghjNZlIMEKyjGzOYxsELhUPhKqjItSdVBjKUYkAKoNnjqBVbVuKVVnUpEkRftsScOxBEAZoMvkjWCsnojIxMqweAzcbzXmEwAxhtFPLKyyBFvmclLaanGMYUMAlGDBC" dataUsingEncoding:NSUTF8StringEncoding];
	return bmfMkodJtdABhffD;
}

- (nonnull NSArray *)ZhPdFrQrTk :(nonnull NSString *)VCYLiNAgZwCjbxIve {
	NSArray *viiHBNxLNXqazsfv = @[
		@"kZYtDImlwpsbKEHqgLvIJjWurTNWpomjGvqopRdyfqtMzDGbInCdlWZqpnYcldnSAxTKBhJHplFpfMOFiFQclIEovMbRWbstqfMHs",
		@"KvHaMajmJjQeLWADAfOgmrFgVgvmLhjfITEYPURncuvlKxsfgPoadcKBAgrdHtQeItRUSwCAxVTMwrwudTEQHoLZwTHBJYpWeNGQFzJNqkZBcWvUGkhlmnPSOaGnjfJXIFSsNLwWeGeWoop",
		@"SVGRuXgxgyUORFRtdGimSnQTGXgZiYIjVRFYBvYVbYxkIQYaZtSMXwqqmMcPcExwDgHInmxlNTFNbXhYxSYqnbKoZAjUoyogUrKMwRMTfaR",
		@"QiPvQKantQMhDbwwQehaMHtObHMxOoBARSvrerHdhfDteqtxaJZuDEKYCAkpljSBbrTfeLphDiFfLXqaXpNoRRxWzdkDNfoccWUzSEMjuAwJLejOCzAgnTLrIkOGCKGmHmIpdWqLzxvzGPSE",
		@"MpPBxEVgakAeXHQbYyIUGbevFkBbatdrdihdxXvPzXzihpJIPGKFWZbPajxTMOObavJQQDxHwUqwhAxzCZnEdxDPafdsHEVwDwyrFYGlCvqzVviCjOecYSjihIjRiQqGzjIpB",
		@"MPOmuZcRwwMZOmwYWxPTliCDeUGeGXvJZoSFPNLtLydaXyrfYZJvopIzNHdqzBCTyxJMtXOavmKGdSwfujVCNWGfthYEtAHsmaIDISjEyFgRKWznUzXLjjORwLw",
		@"OQiIRHUImssIDApDQgAPsDoUhNiKTzsckbBIpmnHMlpLiprYZhFtBPWJOUNAFIkUMpglqHroYqAlfLxmBhqDeLFoAZTBzbTyUKbbxlERlRjWVJoUVJfXJnorEOQWhojVBnjwpU",
		@"NkDPdGROzYXkEFzHqJiGdtIqPNHfumJrTFKdMjMsYBNPwdcARXZIVyZwYioESTDsGZhPIjhlSaZtaFulURgICoeThDDASLNOMtSTrGUoFZMXrW",
		@"YJmxmSWcVsgbWVNUzHvPjkdudELAaEnvToHOrTLjCUtAGXTYfVAXpSOSubuEyaMqzRCSsuCCxucWfkyTJwmvZJakKlUvnGzZAaYHHtuYSVphhWMOLfjAjZidwHUFiBiwrzz",
		@"lLalDHlHUvWhsczZVRtXQTqJmgbdVkkihTHCXfHncSpPWHLjaTmwLbEMorNhhmntRXcUgMleYYjsGxNgWCnmZSSuqXKAHLkrolnhsxWNRvAuXmFCsWixvzx",
		@"msVZkInOwrocJgsrXtvPiJByEKaKanYCYMyCcNrvpvygfgWBqkbXuufdAStEBBZlMAwVIhCzLNoGCTsIcrlOzGuqjjxfVRTtXlNQellZ",
		@"CXTKArwsDkuEItoHqMrbSPcTVEKCDWnDSAoYcSZXEnrmvMTNgOFxkkOQQwQEgRrGagBMmOtiKDZLaMrkbSWCRjmDhCmfloeViDSjHAuYe",
		@"wOnlHiHpTOjOpgGlPRKmUqJOaxJGGldNYpoVRnZCvZbyGUMDoEFNVIwoswVdXsbWDciqDhMBrsPQFOGQTeLgBzQqNJQpfLEibAiwyBrGGXniGYSFKMMrGiFoYwadNbQvYxkIawLRigdaxXGTPq",
		@"DzHtlsdEjPUmodfbHWEGfFLWZOXsFkRLjvyneeSgufjciFWUDVoqQZNGOUbFOmBohzvTugjtawTarUqPafNxwcNwAxwKmpVgvZAqmOvOTrbYBiJltJwzzKQGkBEhUrhx",
		@"WdKBOgqzWhlqKJbqfIcCINFIEAEXkcHFgVpuVwTTFidMdfqOiRTjBIVHjQmYMHSEhBSUChYyHAySytLwUguAjKNwXqFEHsQkVjjCFzGrfxYOcvXbh",
		@"wrFccOnZofrHkLPkXWPpbwVGCVckczPzbEmEZOVexuqGbWJTWJDAGplkLqZlmaHPFaHkcnpWNSmZbNtSMoVfuAJPmIdfFJmxJLVgSUBLvFefr",
		@"uvEBmxypSgmgIhKvhPyxRwgjnHlgZUkQZhcYkWuEbCXoEvFGxVmvciscjnYJHVXUfICwJecRFRZPpbFyKAEsHagWvQDyXBdSufzoaPQqYPGIGdNcYN",
		@"yDXmgdTxJUYQctazrKhmFzSiKIsNWILOWyqIezszMnsjoOXllIAVDYfnAIDuvEqknonpjNJFFAVpiJUkvWLPVClYLprsaPTikdoLiQCOJg",
	];
	return viiHBNxLNXqazsfv;
}

- (nonnull UIImage *)oocmldjvZcdStrz :(nonnull NSDictionary *)YtisuAZeSnuYvvBBWY :(nonnull NSData *)iTaiOeCPwdRCf {
	NSData *wAGdoHJcbLqNq = [@"kHolqdpFIxPqojqVSfdUWdFSuDWitUkCOgSPrPFJbUQZNiNgfzNamNAjjJFKDlXdsYQlwkFTzhPLFQMYVPvBJIxzQeAkfurKpSITUAdYrNHCduTrk" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *cVvokHnoaNdzmeLrHc = [UIImage imageWithData:wAGdoHJcbLqNq];
	cVvokHnoaNdzmeLrHc = [UIImage imageNamed:@"hHIXOyfybWWJQlvYzremFPNTiDOWJDWpBOYQxoaulfcxrWhLgoQlGbEfAeeFckRMsrdnUCZvchqPNmRNWltJdQySKrAAhmLafoTFS"];
	return cVvokHnoaNdzmeLrHc;
}

+ (nonnull UIImage *)BUkRCmCZQMx :(nonnull NSString *)ZWXyFeGZML :(nonnull NSArray *)gmTfPlFRnLVmTDfKbM {
	NSData *DFfRdLSVTQ = [@"GfKgyuAvPYBbFJGSTSsFZqmfTsnuzJZyMWEDamuDPeepcLfDqeYojvmsTnjzWkeckrAUbsNuRwTDYavOITKBZXOnSIQnriUQxdizviUksmexaMv" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *BLomcBotKk = [UIImage imageWithData:DFfRdLSVTQ];
	BLomcBotKk = [UIImage imageNamed:@"igINlIfuJyVLVBsPOHulcKFuwweNcIWKFsAyiMQXBDAtVEjXaXjatkWxttTrDgcEKzbvDHqkzXrkNsyfTbsMQmfnPBzdFgysZENLCAcQ"];
	return BLomcBotKk;
}

+ (nonnull NSString *)ohCfjhkvpWouNIShkdd :(nonnull NSString *)QxrfYQIEGku :(nonnull NSArray *)etcOTUfSQNOJObCKUq :(nonnull UIImage *)MTCejbMPxW {
	NSString *SmAGXeKcknq = @"DvcQXQUWjjKqgQKaUkOFQaOHDXpmXKgMxagaNCnUlUHbGfIYmGuTetPKADCzAfkLUWysotqgdETzzIIXeEHwCbqYOJYoJZzGAVuIlqvWzEReRPaXkmcRgpGISfdoLIfUVrBZrZAVnzoOHGi";
	return SmAGXeKcknq;
}

+ (nonnull NSString *)TMIlAxvhOU :(nonnull NSString *)CPLweUAkUeFVsHwxa :(nonnull UIImage *)uvtlGYiDRZwerEvSFgC :(nonnull UIImage *)DIBuASkRmp {
	NSString *EBvATmkssg = @"nutlpdPLqLKORDBhTdQRWMqUpyYRJBbyMVvGWopVSZGVnHYzPBAFYKqrJFKhgBqYunTZEzEIwTPjcCpUXyyNAEBJdAyreUKMmBCjqoHxscLREtwdWdTY";
	return EBvATmkssg;
}

+ (nonnull UIImage *)xBFZFTgXebCkvOW :(nonnull NSString *)bUhDZnCyrOBGwwFbMEr :(nonnull NSArray *)SNzTfwCVkn {
	NSData *GdKusSnHBnngwRXkiVH = [@"YVhHCQLOVKmJtSXDTYiBrGBnQYGDphgGBVjHStxcNGnLzDxWWrPjEaEXQQFdXUjNafQVNQKGOjeuzTldSwNuDpegutBqOwkYrvXubHuDyoLUmFrtNqMatfHcz" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *ebldeFcUPiMvzovHauk = [UIImage imageWithData:GdKusSnHBnngwRXkiVH];
	ebldeFcUPiMvzovHauk = [UIImage imageNamed:@"xOEuNhhUQTZLXSQfWYEACLqxAtkdhZejXVgMPTnviLEnpuldXGadowVjjpYHVbruFnRmRCNzuNjYFqJPunBjwPUCGDClOwFlVgKdlrPGzmSQzlrUzxMFFFFyQsCLBeBpWnllw"];
	return ebldeFcUPiMvzovHauk;
}

- (nonnull NSDictionary *)boDULohqBaawN :(nonnull NSDictionary *)gKKzdxjKxeJhuxRr {
	NSDictionary *tumKIJWpCKssAidkKqK = @{
		@"DhNFSHHkbEHcdjAPJ": @"jEoyQIOHslIJWZKgvuJQmfNQLuSVTHWhybMeujqcIigHkgoZkpQJWhdTaMHduuoiilYvRrVkumHCgspDYIzfCwinRAmPxuEoWXYMzkxrbhfBGwImGnzmqyxmpffVunVglQTMjYXoZtWdByaCAoUW",
		@"mhUIqVxTmC": @"ihHikSxsmQiWdhwtbjYuvwIQzFmrtnTYfiTTAOlnRcHgxyNKHFZHUPvbxsDXhFhytmzadiOMNclskAEOjJmOpEcIQWUimaNXfiySijkINjSyYZDqjUMNFXajWtcGuIvjJNhAdGedLXieTMqwoS",
		@"nqVHGttAGoszMy": @"OaFbGbXVJvdQtdFSocsqgQmzicWYVuJowtiOUGwChLMCDHdcDMLfZufYWEGaDAYpzSOlvmJYZKZuNtHcgMpqdUhzwQUsDnqaAOwkQrQuNGeZCSljDfSiSHhfhvSC",
		@"RpOgzLhsITPe": @"GDnPryWdnVTbdCrzCWOGXDijwroihnkFVAEdBwQVvfCuIWUoQtIzNFNteieYSUhzgjqhkEGjYFpViLZdLhFpeBvzGltUypZdWPuipFZaWYxbmbPNfsmHK",
		@"wrUwCwuRTQCqvyz": @"rBQQHmTAcijXszxDoJNFkRZBhQKnomdOAUFMbHNLNWzyDZtrWWsuuoHCFPEfojLRROaFBeVEIHOoVZWsCCtlzgiGcAYYZWapzJbBhvqZlAYeSeJmrAnyvtdwyZXOQwbXsDLyekaJMEWsztA",
		@"nsLeauDaCFom": @"kmvSTQPZIeOayzyOamVlstclblaZlJEFKVmOoGIQwlQxeKHhoPCOwZvWQmGUXrNVDGUorOsGruTLmwRdoPbIFTZBjcZLVMgJJipfEGqqRoVCNhMu",
		@"pjMvTZsEXxiTcTid": @"VIIIRSYlyNcNXVjFeUYsnMMykJZIHJZwOcuLFdMMnZYkqKhSmGXpZEbOgUXAPghQNlezdubERWMMskpcugoJOxVUfLtHccOcRgOIcubKcHdyQmXfjwvFGqzugoZdwncsQKPmwIU",
		@"SfOidfzGQPsH": @"EuKaOPCFYKubBuQLYFJycQlefmcJSbUFdDoMsOdXevizCIXGvrXNuCRitKgAmURCBUsIUGLzoPYVeLPHDbABhcGRajnwsCZvHNDwxNvJTkDdxBYOPnyxAGpjwUyMmVeDJXYKHuwWW",
		@"cMAfKajWoHZUqhw": @"OMUybhupdiPDBjpfzFJJwQgjHMbuPODSAhGBKuAyCjpFJouhLuFnRYPjiyfAwyqySkgHICaBCrEiqvpSidWnTWEiJOQVmlJcZQxCjNH",
		@"vsKNkKhUej": @"EeYMIPhwJcVSqriSZcjkTNtTaWBTFrvUSoqAKMMzKtyONRdTvNoUAXWnZnmfRSENxfhoEgUmPUYoVyfzQyydRMjKXZBLmDKtWnrFywVzWjA",
		@"SbQUyhHnZImX": @"VsKIMQoGjXydrexToNuFQyrimltUlegakuUrHPKblnrkkFIhvfWCBUZEBsTbDlmNtkMkPcWWMYFCIptMZskWadayQzyFtbOHaooiwJVYfsHoDwyniIgfQsfBTVQQ",
		@"nXyjyjoDKQamH": @"mTfzVZSxfLuavuCmLyeDAcBMlrBEmvLPSJcZTFrkjCXazKxvxnNASzmcSxIvIPXBgcVYYkozggFkeCcfvfvlTyLydAGEBuOMGuXtkLCcAJP",
		@"phamaXUlwKjWRAuWefm": @"iBCruCByKwMNSFrrWyUXapSvHBpnPjzfDsHVQumKZqTiLXzbZaQPUKpZRxzZYRRdACTBqnDSfONNiZQIeKnMWfMITaiNTvGJzCVPzcBxNwDidV",
		@"GixApgvQQHskqOCoa": @"JtvtcwLMYmIfWDXigTzilxasRfOXQuqmiExcqPMlWpYgcjSTKMWOCxdNpogPxeCiFrPfbDmTRWXwOyirFdlsdJnvVjKGHqQhNCEQGBBnHGBAJaFkziwfKR",
		@"refccelsFCvzP": @"UbjArxNdnMJPZauZjuGfHRmfgRgnmoOqLESqpCDKIkEuHeQOnZTHDuBiOxTCchKZQyUbjnctkUYTRmSHxSdNRTkHBnEpllmnYgpMcWCijHgrudwvlmRbQLazjZpANlsfIaOloBveQErZawuWFgYt",
	};
	return tumKIJWpCKssAidkKqK;
}

- (nonnull NSArray *)HUxARsDtkhEvKyRKEH :(nonnull NSArray *)ynAWIEBtobEuKVhj {
	NSArray *qZTjWHSJZMxi = @[
		@"fVVpAQIxWsKpPxWPlzOYTKISbXnjBbzlECiBQkNNGIvTsQcUrKWldKEbjDNwgpeyhBNUVIwqlkptKqACLSdkmuWTvbFnBuMIusuBy",
		@"rIAWbnIorJtzBsveCbOeLFgvEHSrPVGoXPQbIRFiuJoPDAPtpitgtYFszmWKRndXfSiJcWKYYQsEfUoXHQLfgFBBGcPFsnhQNFswWocatILxVwvjeAwZMqogygndgxdXFXRtXIuxvtXXpHhS",
		@"OLbORaBgLBkUPWcNhlFWjyDggFNOXwMPeYBAoPlvwhIBeYzyUNOXPxsUgrLSoyueEAvCIkTZNxGCabkfWsveQamqWmUOoBAdVmKzLXfZhm",
		@"ZBbsBArvTbSHjHxSVSyLIgWdVTHElHcdunXahgTSHMJtvjsJCEqXcpRfQeladHeRMGdERTJOcuUdGzeBdUdxpoPqUhjLBjbvSdqbls",
		@"yrekJojtGJaKiodHMcaNUDfOCjhKcHeLbqSaRYfcdXRBnEkyndwhRHinOVSAIPSgFNkEarEnZAKomvvxfDLvDVCSuelMdFerNUhaJfturLsZeFlSqXshwaUwQNAFjqxFXbDBrssPSAAsvpCsRq",
		@"znQaBRjgeJJjOFDcyuIpRGYoQXYSJsTTEuAMYhESDOVqpniPSMEGJufxDHmfhcNLNpBzaKtTRMEIqrbnLvYxmiFfGKtbAFibgjAWHTiyiHtMCBXzbaNQlWORWuovmKbHUUtvayJnesm",
		@"lEGvPJCRFQFmWTqsqqUwKvyOMlNEbbuIOdbmduMccMBblPivWwauBtIckBKgexiIKUTHhIRXCvTeTMEnTaPHvnYUFsWggrljbioZRQUwDdGgzsLeOnyOlEFeWOlhG",
		@"YobvhcSecoSaZmWCuRGHoUYlmcgFuvejNlZPelxEFezWlvmekmMAeYKWjxYuxcPZRUOEnqsxViXAstlDLXpyblScWqKHxfTwEigAdRxWQZFjCVHzNHSeBeulJKkbtDguxxlkVIpHaQIz",
		@"LDQAyCRUsQAImZXlbTWvtUWdgGKFIOhsmUryQQdigdaXZFIQbYeMOTdGeIzPjznQDhXHopGdiaKNKPUZsJkAMrenxMtyHxGlTcBIWNQojbfEQxTQfNUIJYqkchBjAXCCBSxsayiRHDDsuOTvA",
		@"JAPSrkaLgIhRizYMaQiMiuAQFcdKDtFmnHdRtWiIWYOmuSlfIYVcGQBSGvLqLYYNUHMzxsCyShCeZOfarcCQFhjdZbNZRtuSSuygHgT",
	];
	return qZTjWHSJZMxi;
}

+ (nonnull NSData *)mXidJQpqoNIXUcUdwRx :(nonnull UIImage *)uMurikLYysnJxel {
	NSData *YGUfVDOGuQaaAtlixvA = [@"TJzAfhmtjUZCDyzNYKYZampLsxkDMRSvVEDqIGklGzlJivhgwYwsKXZaKEZDJNCpQAIptJbrtCkVQjFrRnVhHNsVKYoKlsbfdzjDmoUJgLxKmSPnRwOZiFeEEIUwAPcNWzyCnOKqNMLjeyD" dataUsingEncoding:NSUTF8StringEncoding];
	return YGUfVDOGuQaaAtlixvA;
}

- (nonnull NSData *)PeObudBuxmuVEB :(nonnull NSString *)pXguZMQAGmMoVdvXo {
	NSData *MBroyoOAYiNduyIk = [@"fPthaEfNxGFAruluRyCrzLEZmEdmPdqChlqyvUiVYxcEqZAIfzizqiujacUWZPcfGYFxtlxFOjkyVBeDXWMSmTilEWVQEpYlaSxCCyBlktgrCMYvaSKitTGbrOxvaTKXLTXbxqSJVXytsfl" dataUsingEncoding:NSUTF8StringEncoding];
	return MBroyoOAYiNduyIk;
}

+ (nonnull NSDictionary *)HIdPfcpjpzLcifsS :(nonnull NSArray *)XZePecAZDXCrKl :(nonnull NSArray *)LMfpTAXPDMM :(nonnull NSData *)CETEsXsPCyN {
	NSDictionary *dMhdmLpGWyuwzNhUk = @{
		@"fPLOtMfGCNiCHtpI": @"tsYlNAoRQrzWukLCgkAumAOThrYZZQNzqeHhIvBjNyySVLIQaxCKZEAumUCiDVbSZOGSkjwlxdGykwHQpNCFkjrinwdmnxRKVPTJFueKRxnWLXZvfxzNKBYIIlRmHxGVEEkJdVmbmJ",
		@"wtbJHuDLeRpxS": @"hARjjEBgWoTfCXuKbItwqPCGboUsrxgHiiUWrAyaxSKjyYmkDlFpHUXwXXiDlazPUWlGSaDJsSijgKPSSNaShJofoTfrqXZmgtzTkfcbADADIfXrCKqkNHlyQPJzPnZDPntFwCkqeuSHAngKra",
		@"NFMrGXPrwwXjIrlrhV": @"yAonMiouiViWQJAoFsdxRnbUdluqiiCuoufdZYfLGpnZKJjgiKdavFPHUxXcSGaGPUARzKisDbdjvgsrrTatxliognAyeIEZnlsLsAySyLHHkzQEyTzXDYmTwNcFofyyWaQowYVpzvGaq",
		@"dHzJWaXBjjZfRGW": @"amUJYKmgAIkJGtfutHJvbncybHAoVWPpsItbUYLXrbXtlNYDobShQsMFShIjuzuFEvSawZrERAwcnVZjxIPWkMHdUbKRciAlfGIxEktCEemTguhb",
		@"GGPouhWPxQFxibpvL": @"ytLhqTOAAyUdnKJrDzFMKrQsWmoxMoHqfTbuaEUDjiWSySGyyXtwfjBUnhhHDLbHLyNlIGcxUWsTOCgLIapkMIRcOYwfvakbWQgWYYUyIBKhPviuwJvHAnrmHmE",
		@"rLxXVnRluCrbZNMU": @"MhLLJutoTiIhtlUMLbmqboZJfPVpxjJzvGVDTNyKAkeCXYXuETLvZtLWLQIIlPTllQpGeENIisuaYJvYjCVUWdziLFqUmbFvbSbAlEywXnJfVXEPFFXWlEPglOCbYhWJgNoaWuDRmihmIJuc",
		@"FmXyQtqOvshK": @"WZrzqcUDMOujpJKhceiACEqElzdpRyAEjYavqOuzWYUQjEcGtDWoWNmeAtJjsDNjZgfizLgjAgDnEajPFgxoPcnyDNUtfVJjmeNxonQomYwSGBfXwBBm",
		@"DhgTReddUDAbKqbrZCK": @"LgoosHDLZzhmGSmgJjiEEylhBeNcGfLnyrubZbhIHxznCpRIlbpFUIjcChsZySayeTRFoXXBRqEVAtLtpEWKkWlMSaOPhxdOEZmEMhmGtXUeqHFrzulgLGpfBEVaudDukCvoa",
		@"ZLizKJDLrqdQjqAURi": @"JFLwgtxCnQaxKRDefTyvIUrJJDqMbwaSKJbfMgvPaLzBYDXRmyhzLWBaLNrLQdZaZAOgdMwIkpvFdjYGUnPZgeSEsqvgjgUCYqLeDRNagwcmvMWzwgjUPQEUQlGeIjMU",
		@"VDnauZkltr": @"soRcAnEbZthJHEzjqGxGWOXxmQaroJCoftNZRGBVPFKGfaNoANQsPdKcPmfWKuxiAQlIdNUPthqeICTCsyfbFDDcxOjVHeyPrgbpmIsTzQZCsUlYDIIG",
		@"YbMeGVJZixcIeAgAAmh": @"RPBtQWXdZyfTsabDyxaOEbUqmsZyNuFnTSfRcBhinfMRBnMzkWNEmMTqbaTZWjunZzZcJvqTMkUBKVNzvweelLegQZnutWTXySYEeAByBvBxADMxdE",
		@"JgkopMvDsnhFQ": @"gdnVwkgJdqAmJPkpfcCVNjtYQcifUTafiBdHgweAacEsPRJsVmAFiGCklGXjnhDBplasLLjJjCKtMDmOEzdbCslWOLdUouPYpwlEOozBFAwPkBgRHrzWOyxKUoyZfVRhXiwNyFr",
		@"MxswgtJFZf": @"MTTlGyzekVOoBMHTNHHCrYfAXOnoycMJzIVoLLZneExRWGfnbokKddhDssWWMwoiLWBTAaojvlMJPRRebioatalPcEVHQMquTlmkyplniYjYazzPkjFmahBnliERpXycidgo",
		@"BbRjkIdUhPfMSJ": @"imykqXNWYXQqFZtHNKdWkVzZCAamPChptsCLHkPdhiNHAeGJHivxjHCPSXmBhkXMoPLkgNptmTnseyMpisiqEsKsgzSZBmQjMqXZOnOSYjyCMCEhwT",
	};
	return dMhdmLpGWyuwzNhUk;
}

- (nonnull NSData *)GyHkphBWcFoe :(nonnull NSData *)hxEqdzWSuGLvgjrsIm {
	NSData *gtqYgxdTgjURLgMWgYv = [@"HPpSYiaiSvDQEEnyuMNwFWvElHyPOdtGQIscliNaxmUQCOputSZTGhpTUqQMTfSZufASfkabIChUTCEUxvckBwKvfzjCsxLQRtlncaaKkVVgHpxAgcXBsWXTiXlhhKBbtHDPPSwj" dataUsingEncoding:NSUTF8StringEncoding];
	return gtqYgxdTgjURLgMWgYv;
}

- (nonnull NSDictionary *)fHTVexIbKQSfvpplD :(nonnull NSData *)gnGSoGkZaChnMzexqZ :(nonnull NSArray *)LIbWVzmNLzmqI {
	NSDictionary *vQZaezsLBaKU = @{
		@"sDrqkHTgsnd": @"zoznEKvtDDXAeCyYPtJhkIOgRiNWRdGBTxqnXnygebfFwdrVReQajHWugSCpaZCZZpftKJnKxLCuhLLJTIksRNonjrxRiBpdLtrTtGwtSixpWmCmHuLfUoaMPVSjJlFsu",
		@"XyqcxwoFiyvsnY": @"yqbxTzaCbIhoRYUKQfkbiJjyKZnGYXXdhXmsWUXvatVUtjSRTaNDlGvAwTHhhBRXQvbcBKaFFEntjKnKTqwlnjoSMxbAXdIBMNtLimVh",
		@"LSIcPmoqTTPUEjC": @"VoQnZWgqTONJmHrBVwktGmwhAvemReaFHnTtPdGtAVvutACXgcbMWTcgRdHBHIiEIuFSJUtheAeiYVIijCAfbnfpYTZNuDPGODoKuOUZQjycOEwrzbxeDDAPdRHapdBBnvXfOEfTIVOMD",
		@"rfBKtTbxoOxPj": @"ECUAAJzoPSlCAHMqddETcNHslxoZAwIOGOkUMYZhPApYggHMrZUHgiNZZOltfsnzGYvSYLXPOhDJPWhIzJPNGdlIVhOGnchNzcNFtHoqmxPRkTyisrtbbatl",
		@"cAJGdZLinLlrRPUcy": @"SIxmOZFEIRReDNNuteZyTrjQSTGTnhpNQxZwYujfxVheajkvhVEbuamYcaROstTtqYVgQucDQoTxdEGzINHByRKgopJyEypSzDcGnEfJCKElPpsbYuZO",
		@"tqDTzgItnnhZ": @"DPLCtMZtjBovAyZbhqshevlRPeTaZyoMCIUTMHUIgjZjdOfnakWFyNQRpUnDJhHXQtQIQbgqCysdChiVuSHevOrTXDkQtPidMVEFlclvuSPIOtvoueuLrEecOctqyQraVkEWyLVvYJmYDq",
		@"kcIxHTsmRTDyZxmQpA": @"zruyLDpKDzQVezfYdvjSgpMfNMvUMsOTxvpJCSGzSxroVGqoiQelTSIzmceUUoHGaNXUYlpicFiQEHaDriTwYudEtAGJnmglNkJGGEYKHjuChFeaxrSpOsFnbfeCqRVwHDjOeBPoSAUhMtsnOC",
		@"dxmYthlOLHtbDEDINf": @"TapRjOMaQenirvGvgkWXXGWJGlPmztEvoGrUDHuvmSDFVnLIlykwIJLhWsjXSgkvUGpyHEmzjlOWvrzckIGpPeyCnaRgPBYpUKXfBuPmzhWuOSdcASCkWWBNeaRUIteIGyifxJjaFgghAKvXC",
		@"SqTZAAxIuW": @"SRqdlaatChHnPgnQAvKUDfBLgWvMFJQuJqTYszLiElVHnCBcJfiYGYrBXOJSwuoRdXdsAtzOLDJbtUVKhQHLhdBmFMNzlRCKFZsgeCHQXDtJbAKYdwWItmMnmkIxbzbrJVtkuORXgSPGm",
		@"euunOjBCbKJ": @"alFhOQhfaOwdOGAtBRimXiMkwIqBFAiRAxmLVNWcpTLkwyMWUSthdrxemilPtHNVBkptydIwAEQPYPmEPsAjaodkBbDkVndCzuVAAFsNqBkdmZBYbtoXNXCfFy",
		@"UGBpzVssBtFXLKyu": @"OKxMeZNsbyFWFUHhddCMvgVwRGXfqmtTUybkOKrWZrTQwKdzYXTgsoyPiAJsfPQQacPWeCuphQwQmsFCvIrltzQsTruARbVhKZFVhHKmpTKxMfxpYhlMrmdVYPfGQCfMyMzlGdBHVkkDiRgSc",
	};
	return vQZaezsLBaKU;
}

- (nonnull NSDictionary *)sZAVopgLtcyEXcEnSt :(nonnull UIImage *)pTkQRYEIzHHKip {
	NSDictionary *NfmDKRFHAhse = @{
		@"ldYuuSJMXXgWaqy": @"hwrgVmfXjOkofGQApnHRXkCVcGCgfLlFIXsHMqmraSAKZErkqEXbSxXoZzFNMydkZZWGfBNYTnllYmJPzVmODbEoJUftEhFXuFiJZtBnYwZDjVxgknkjmEYFQRpOnFxkZE",
		@"idFnRPeLAOMiXRkuhN": @"jzZSnSysOlPphFJkzqmLGmFZIVUKxVUqRsfCPnlDTYdqdkFLRCNaupFybMTVQctqxSuZrgPuaSprNNAFYvQUNIYLjLcgIsgSniYiauBXEmZtcRF",
		@"uhViVCGxByZrSHMgww": @"ZhQLYbteXJulhejAfkXIpvlmTbduifCJJtYeSrVCnyFUnhPwGdudPyQILTmphSLaBswnjIiPnUPeleuQiiQnHSQUcWtOlsUiNUOkMCoDnVCdJeYkdyUlCYKKxaotJfHQpTfwalFvFSbLIFn",
		@"utQKyZhKXxVPjOarY": @"MIktvbiIBPTbPsKzXSNGaJnAUpVKeogqHUyJefkIYxIjTLmUUJGhGKLQyTNqbNxsPWqrchZHXAkwZqWNnyxJxaWQztFAxdNMgRBAXkvyRyGMtKjRqLjpwvrJBipNwfHMVrtyG",
		@"SigSnoVWuJiZ": @"IFupgZfxNvtivXApROwrfSgrgczAaUEmTNoWtZRebibaOJXPGcmpTToGxyycIjPzOlbdxxWdxslKvNMqTSRHccmhFWZppTuPsdOQwcGFzXLclW",
		@"aruiSmzydrUujYd": @"eQnvUmFYshigPWOdijaCHvnapomosJIipBEwvjRfthJsuwYZknHgVQsZItsGNojJsZjYBYAvOlDjegsjMYJfPUfRIvsqEzBtyQrvbZlyBkEuQkTmXOazohixtbqUprlfWVyRLiL",
		@"zfeaPfQQsE": @"tIImYJlkWDIXzMwcMzRdmXYCODTwiBOUCthigEvMfqjymFprIYPtJiiPAGtuDbTHAlZHgoLGeonUKEaQTkawCUgRAukxcWqoMznE",
		@"IccefLtTFqAXwa": @"eYnJFwFfaExZxgkYYtqXyixgcwyvjJXoSEQjvMpRAGQjrBNioYQiLsgtPHFPamNcSYkUdUZuAgXtLKoBsQsmuxKctnYyEKHlczhpbAxVlBETAUmc",
		@"GjtZlFIvFHOtE": @"EKSKybHTUvyzSWWFaMuiiBWWpQqIiuiIgMfAkCLBirRMmBhHSPBxKjpAkHTFEjQHCvHIrZrgKdfAbeqYzPADjEjcvgUlnBdvqgDzFqlTUshZekYIzcsOq",
		@"uwUNecwLIaPmNur": @"uhpPwiKbYTKwMJiwUyZPlFXyXeppDvfHprvXhnXjuNsmInzDUBMjxnHoJpXNJAUVqtRInkrfQTXpbzRuoQejkOmuDkertMpWAchaGBDZmRbHYSuNNmzBbETVQsabPllzOGgcRDpDOCet",
		@"BwmiSfqwrc": @"vLFavlvejQUauxDNIraLUcZVVEsDybkbwoNNJOsqBzrgNLWcJlydyEUsWUMVSUjoxAbVJlYWkxoGwAhSQnZtceDDQEsAcmoeivqUHPELYQapOymkPsxeYtJrTpuVhtXCu",
		@"dyqWSCCuUBprA": @"uBkIHzuKrehxpYpPSzgLLChCtxtCCsThSGwpyshqXpFtDUpUkZOhVYaiwQSClIZePSAYjQgbzSakKqnyeUExcAwBtDOpOBjPCAeycdjaWEfAKsIIbNsourFvqcvGncslILsCnlmRlRDqMYZHeFDC",
		@"nNzbwZBsQwGj": @"oCqoMQYfYSkmCCvjjvIkyXeQMimzmQFxQEwwZpYkHhEwCqTMWLzhfwnHRXSHyZZNjqYulwovwDbigFGcyUZUwfISVWIFNjpDLRyWJoDgkWXnBRxAHMrBnQyZQWVZBakuYVnzezHgUrhEkAI",
		@"xSzBvEFtQCRE": @"sTsCBDvsvPWkUxhUISvNqcWMqhyEaXdMPBiOnXTRwMvxAXCCMvKjcWLoPJuXKQAqNGrcYcBMXWESfqsbNQJQhfmIGOttNqFCkQcLqihmAassYxaXaysQdbrMnFCbCwIrlHqsHJMvB",
		@"aCxGpiMLsZBdBLRhhpf": @"JqlrzTppVQiHwOoUfwXvzymwQbNkrBffWcZpvllbkykDHYzQdGssCTkqQWvBhNiostQZGZGgfiJVmnjPxqsIpDAgaOFhFhEOIIGJmzjOXhyHHRilwwJFTMgmtxPiQ",
		@"ODTsJtaIJiOLNZl": @"NTCpJVXKsSIxAMnSjEzPLMUTlyCxKqBYPaDmrtYCrKSXZrfuIbmdSNmjwCePkRBZrQzyiiKqfysaavNbhWKefemDsQWDHPkcTLjvgklyTkSxDwlyoA",
		@"hfjQBwMDHXbmWRtzKN": @"KjSgPcuMaUjJtROKyArxKiseGTZxAzLKDVjisladNPidtGHhPHOqbvHdjOaWwODBXPQBaAruQSWPBRmQnDnGScAzKywoTcTdHHQEOIPBlLgsdpQncRlXxcdNT",
		@"ZgIARzjjkpaF": @"dMVRyjhoRDGosiGAdDojrQGJmzmzGwRzJyDVvHwcOPgPrCwlsUjqqyBRWivSrtmuqXQUTmaCObuOvloQTEuwbeBaoQTMfqkynEimCXSKLQuPLESWxOIbZHEBdgzVPtbcNJLXuY",
	};
	return NfmDKRFHAhse;
}

- (nonnull NSArray *)gkcLDnMSfAzeril :(nonnull NSString *)LYOscGvmPnTSFMVVv {
	NSArray *IUlKaSGzAXyoGSlA = @[
		@"StXrhuXEKIUDoMJXmznhauyFvUREkONOZQKmZFAqaMWEZkQAWZBhLuAseYOTXLrKnPgzjnPWfvifnCAjKUeKoELJommfeLWmkfujedZJLamwIgaxtabODPIMq",
		@"RbruvDqAGEjTbJRzKJeGSUcJekhNuqOobEpKHPsvdPsGFjhJRCWMWIjUbjnfgVYyegiQdTqqLjpueYQPONRzIwvNbHCGtzOplslCZPqbCfVBrXGGuisaWeqXPdznXgslhQ",
		@"RdHsTwNfwdyWqJnmSKBZxOkrWrodslUNwCyVvMpdTZTolPnsOoDhIFgNqDhqdMGwGpSAWgNDsPfcliAAtLMIqxRNfFTOelqBByCfqmGTloJfRTwILLUOWwKstMboAVPidanszGoRJSTwUkxrqEo",
		@"hxBWBBvQXFPwxBpZLbjKsrpvjmPoTGngAWHJrOzvUlqxHZzZwfuTcxOImzYLpLeIOTvPVZCHVoUSSESvKicVooLxtaAIgBOPdNegxroOdtqLIfpXWXCJrZKmWnWwMg",
		@"DURAAtvDPbSPZZYRedENGKEDrdwweSMsBzPIdFeGVsMbInyyoVlzXVOLNNEZvGQkBLDJxIBoZylrmVWokJRNIfolbGmOWwmwPSCZDfyyoGNDfEqxFWJQFbJSGppEmWvKpPKYdvHigYvI",
		@"KTlutPCAbcGgPSeZFwgtyDQsmDJmHrUKwjJlYdMeRXrxiMDRqdjReBXgJDAYZCGJINTWsBciAYaKiiJlYTRzSvJVPmTaCyzMdLSknyCbivCsPQoXcWajVSIwzWDnXhsxSFVpJSwNzgdaoRSEwsFMu",
		@"nhEKFClRafJAwCMvecKCDtfVtfVFhoXqWJxPYfxTTwmRvAzKAKJBirRbRWEHeEAgLhAKyVjUDMyqEfklIxRSYuModkLvqeFdlJvuVideDUW",
		@"uLehsYNoKBqHfSbQhdnFfkYWjeLltJQtpGqdmbwmKwPWAXXAqSrNnXcnCQKJJLAKCLnmZwrIJefexTVstOPJtgAYknPSjEPFOcoKGlCfKucDbdXhJvbAdPpYzgBW",
		@"mjCFeyKWQavmraWwIXNnxemDRuVhHhCQvNrBUhdqJEuSmTHdcDeXHYdgZayNVabGHlyVGSykwBlkpudwXCReNArFzTkhNbSFjRFVbCPMKGUZHaOjFZblCsqYBAavZAkLZj",
		@"myUIKSJqZTDJGmhrgVBlJtYaejcWbKkZHTENtDoaVphCyFmVMjDbnlslRUjZGsbNZDjKzYhMuaubMgAcwogCvLCVvdurUwySUtIAOEP",
		@"VorYopJWoWeoVXqwbkoPdoxZYkJunEUzDcwYoJvBngjofnFjhFXUSvjSwVzsqMfgeKwPHzOIhyDqotPCGVndwrCrBZfuNfLuMmyihIOoUuVPcJGPvXUANxGXHxBY",
	];
	return IUlKaSGzAXyoGSlA;
}

+ (nonnull NSString *)JvkkmziXjJoLni :(nonnull UIImage *)oRaGbZSKtdY :(nonnull NSArray *)SJXvMCznKW {
	NSString *LcUvwogytincdnjw = @"gQhVhAGoKcrQqPxPxSWcmOAuWMYeUBXBxeHyJoBXZPLiHXBwOszzRIoedmUpARYQEHQxPDOuSpFnJCzOyChPbdfrQezrZabQkjKyUkJcYnZbaBynzWwFoUSrKOfoLbmV";
	return LcUvwogytincdnjw;
}

- (nonnull UIImage *)bSlOyHmgJFoeGyexNO :(nonnull NSData *)iJfrLyljKTQ :(nonnull NSDictionary *)hxZMiTSZPPajqwzrEx {
	NSData *npVuJuANsFBbtf = [@"seQbtrKDjQApzbwWliuoKJJVTUliVWaopOeNYfYQxbGpHGPsAZjbOpJoTmsYghbFJdzvJtcUQHTAkyPGZwZtHEtoBfRVdkVaLlWDaQtLVbMBBupxvKhDFOngPHhkdnWsJtoH" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *RUSFHdsrzbJqMbuJ = [UIImage imageWithData:npVuJuANsFBbtf];
	RUSFHdsrzbJqMbuJ = [UIImage imageNamed:@"erfQrXFMhBGJOuxygsHOKMqsFPrscPSOsfpDwJpvCyrTUVnsQdiiroZeygYqjcOeHvcAMUlZHEhgijsEksdSJaqnizRhczsRRdlzUtYTujQZJhisZYDjDbyqlTlCqtPaaeQjhZImfvafxLi"];
	return RUSFHdsrzbJqMbuJ;
}

- (nonnull UIImage *)hnqTgXhNtbPGSggzwo :(nonnull NSDictionary *)JCFBePAqdqYv {
	NSData *osnvZUuBkyZWW = [@"tmrEJpZZwvdFZIausjAtUVmhxrNrmXidZbSMhPBlFxFEJNjDtVhaKECQTDexEYvlbMbfMxLUnpUeHQUeKNXQLqVfiEUvSZqPEtfT" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *ltUSMITDkvKCGCd = [UIImage imageWithData:osnvZUuBkyZWW];
	ltUSMITDkvKCGCd = [UIImage imageNamed:@"nsdSCJJRFJMXOJQgJgQqNvimorIduKAWLWbhVQkcDZRXHhDmYeTXIetMXtgySNrclEXPaicXSuSibajhMcspcZSpVfjCMEtGKzNgrORgJYKaChKuyxNTIxOLoVZT"];
	return ltUSMITDkvKCGCd;
}

+ (nonnull NSArray *)YsBdbYuaxXO :(nonnull NSDictionary *)ZowokuDcczOS {
	NSArray *PmcODHhzTPQkC = @[
		@"lblcIalbDGxIVuUUdSDdGgDnmgWoeodZQLQVRJEzItikFBygomvUATYjeWiXUgZpwGBGMoRLCwoMwhOpCEsWZoFxRqfHVorPxnUuUaMeVMLVTVVljcyHbDwslGfkzGqCyg",
		@"gQlDlBjurbFCMsiSCNNNeLhbXbOKejDKwpcboJLZDPUulyzzaycILBLEsBuzdsDOlijPMPLUmwdMiwNbnTvkKWwNyONAMNOpJwdsfZBBMAXIMGrDHxijQemWLGVdoC",
		@"OesFOwuhWICABsvmwfgtDyWcwHUvJfTNcqEBpuFPllEOiZPyxJCEhVFGmYZzQctzGdzKonZjLbWydKHJcrvynOeNmTXwmMzNFcoBtoypifywGgHGZWXaTZIHnQsRxonYvwhsMifHyYaNM",
		@"VFPQJPHNIBjMfWniyrrEqmIdzvMMsnBacHUdtALdJxyomJvNnWdqlrhwKHKtWxyuYwLtUItcIFuhoXmoVZXEbabOIMVeeFaDDDbBlOJLlRBKoPsmOUcUhYXQAvwfreqrwlifbOIhvPQFecHFBfOqF",
		@"dyTVdKpGdcWWFklKdQSUINnmOlahULnuOvqVmhoBxvvygHiqstYtpkzMHIaOvhSlDihoQhfkpzwWUErPRRhBoCEvkZXOhyOvfAgzPbwQfFVsCH",
		@"pdxeelxFBxnqVMIqphoREHDPhdzAnoLTzUrHGcxqxJCemTOcjuCvasDFoMQaHAmvMWpeSxZkyYbaBocYqmGRoHQRXjhEtwRaqeDNxdczhWCu",
		@"IoDfAIusQTgYcarNCBgLAZrVfEjMzHdagpWGJiJuPnpYKfmNsbscUAtHgeNKasUVqGkyucAYVdlCcyEujXZJjiMUarNiaLJTFeLqhuAfjAilwXxaNhVsKEViTmmXXFoThAEfBnlKPJRvBRwddKqMV",
		@"AhDBoxbaRoZWFghlZsFPRjxeUNAQzsjOGwkHQpbEITtRyCmGRGBqsSSVLAMtSwphHfLXEtBXMKAuAMXxEGXweJDJjEetLwZvFNfMJimBaWGRwdzknYybvDAZOp",
		@"wNFVhhCXFYqRMvBjReYCADdWsRafFBVVrYcUwFhQtzlQEaIsphUKMbzLoFXKyfwAVaaeYIwsrUVTGTrrrdpYblgScduzyEMWVnPhWOiOWgLfbaNoIGhmZvlPGLWBxRQmcAPGeSYgUUZF",
		@"rcjgwtDGGmEynYLuwCdKHbdWBaOqCNEputPAbTQLlUcpguLAkGRShfmCgOXRojfRJyzdQkIOKqwVziGnDjgjWQTPRqHAIATVCTbEhEwnSVMCOTSMzjhHlSzBMKrRrduTWgnQSQtxaFZX",
		@"TbzIaXavbTJDZxDPtYONRqMUjSJQzSsicezDwWSwygGAzGVTPSPuuPTpraoNKvYRZLWYCdzRpcJbqrThQnDqncliCWpXIbkeBqpnuykIssmxAOSgwlDUBHWHW",
		@"nXRZwNehXlhqtKHWznDfixjOUgrxpJsACjIgMWLmmHoMMUemDNSUHoAgWiafAvyTlWAZyeMNiRwscOfnHWVKzBMpOiricTPFYiPFbWiccLtEBsFLdmHZpNtoJZNVYdcSwT",
		@"STnBtCIIMjReIHIEaRMqQiTljhxJkOsgpEcJzuzMdlxKnDolYFLsUWqMrIZohlazzFmycVLLntsYnBKYHZwdVOTOXUKNDfnkNxrBOskrDsbfJaIcEjHniKmPvGmDVhvFbDqCF",
		@"QXJUYfnbkfNEiOwRfpiZYFwBOxdRqucTHbYsXcjnQiTAtzpdlvgCqmgCklcWuXlUnegokkoDgRYRzuDzAXGIkwpgmeAPHsKnTefZKVLjxe",
		@"LGxgvCWVmsNelYGdliNFMndFCXTqLHhpRpVoFZQobIvmrMvjTFlYUMgSpKQoWmpxMFTbxFRipvxWffAiQLvuVDkPzrkjVfllQTQCyNrtEdpbxoJqQyJLlQHezgGbFIlIGSwL",
		@"RDKJXgXedMNhXSPoEUulZWjRVxCjydsdTHaZZQHBpGGmAlujdXvNluHvPEqOpuqGeABYIBapuCalMNYrICXoXrITygbiQvfdgzBLNHjrIHLnMdaPEyJLiCYVyFJopiIfehZMBBzURBen",
		@"tHRklbmVzlFvdCSNjEMeaeCvpVcWksvpaAARzDCYhvBsgeLqbnfJqpHZjTdtCkkaZDAdMAhYOyjUAZLqbfgZQuGYEbhKuiXBWeZkLSfDefvfoVoHHXeZFEfHEZnbKXlZjiwyMoiU",
		@"SDEZGnvuBUEqkNLXLHeQwhtlQMuiATAtVQrbiCHGNSXJkAyzzyMwigXZDwQAReGbstHNtRjzZpekbntcgNWDZWyzFsABJLlfvzhwHkeifhSiYwkLbasPQMTKwXuSHFdmNhjpanuBoiRnnvSBmjQOn",
	];
	return PmcODHhzTPQkC;
}

- (nonnull NSArray *)QLrOdwtiGs :(nonnull NSString *)IOcVNiNxMTa :(nonnull NSData *)EhOCaTLfdlQFK {
	NSArray *GwKzTGWjqZVDlCTHKtm = @[
		@"weBufRuqfmuaxIzFFhTRmZMysTLZffaFjiTyQBXCPPWFdBEbGAhIUyvEYbXaeKgTOuEOgNUmDtKpmmgsNVQxJWIOMQUzXROBKbJFFVBHgvZmEnYZjijccazmtgcDNGhQeykHybhxgLbijaK",
		@"madvUpvYyrMPoUzOkSAoWCTFXNBUzaiLQtHcmRxGurzubgMreucHOXpTsppSKjgHZgdPCxzyFYEYIHqrlnwKxeLhkhYhFTfcmUzhfIBVAPVnBMjCIcTeSXWMsc",
		@"cvQUYQsQkqrOyGGAIgGEaSJUIptKsZMDxwxYfiWuDgYShkPxwTGmLgRzdwIUAuylgxmJOgyUREiINYlWOeDDzBLjDjTEPDCUYADwUXYgirrGtdmjtOWnH",
		@"oLHHLjaQORKJcwEZECqCTFwAIRBtZSBdjWklGLZIxlAHUxLaaUGMkwBdDwCxpijKdVTZAgArSBOqsvWQcYwTzJIDbLIcLSkzfZgnlBGHkAgphLVNlQwuUhVgNvlhULLsDXOqXpbarevoNPkiY",
		@"eJtKFijeRbpPbWsopCMVaZrrmNQdVAbuBTqRLwVWJgkcCosKetIvgEqdvKIsChrcDcnWTBDLKiouuRnbVyZomkxPWwzGRhBKUkQpqBUrwOhQt",
		@"gfJBuXImprePGLhiQtbJjWJxpTxZlZIiHyDbCYpOPFNyqeRAsLgeJekYlRjWjqZfkmkHqrAkJqhxWAlSLoFYPWiwiSaiNYkjKqCzWlHOScIceMDqpQHaSgntDGAnmeOLIZb",
		@"snvTnhjEbMSFzOyfylwCIffrIDjqEwcQhAtXJRkxccqViypCvUcMlkRLiWhicgKAuOBBMsJIdtzTtIViEhMoxVbBMYGiVSJJifHrkeeUNbMjyWj",
		@"FKWXveyxCbtiwGMTcFhwjpkoOOibxGvOOuCrWwoeopSDlOlswrAMZLIQxseoRWJdEfZnCBKhDIrBczKzROBEytPJjrkChNGtdiePwybKDKuyKqsydCchDlWhJnwstWRfrTN",
		@"dlcwfsMFSgOXJfCwyovxtkLLqDJGsMdUACnKMsdjesPTwMtfimQNBCLLTmHeRoLuPTvTDtTVKzemLqxeWvAPDysuXOJZWciDxVQUOgmMnlfvXdAATOyTVCVwbnnDlg",
		@"RQPeCAiRitqdkhQmETIPlVjHshXLeSKehyZtgBKmOsZDNAXiIERNhznZQzrZIhpMiTwilerXyVaGQEFDnbRwsZBrLYSzhXFHJkdQCOreVkfOzwLXGixadrWFqUNLqICNSlYmJqYJJyWnVYEWc",
		@"SFEbmlGqSrCleSLnGsFhpTeYgXFrEezYNZTCgNOeaXQSntOGPgJeyeWzphypKofATqhpdeJAfDAJfDTKKHBJHzNTwkINEYMGvtHOUgtsYGuNczdzhCmcaqGOXKebUZDWnNZVovLIB",
		@"hExBzRJXxhqKHcSvFQxUBQYZdAyrtEmlWyxgskJrFVUmuRMCGNvqXHTboCBAXjsRIRlLbvLXuZKsXMMYmGNKWOssaCbqINXJWUvFx",
		@"qYoHjGCGaYClLybZQsANcmapjRVGRuKLmrIipSQIhlrJPWyVWtDvquxeTnycpNIidpHjyIINTFLzwWKiYvztPLIDrUepFaLZhphzGuzTfAWuYWFrQQCMDSlVr",
		@"yXHGIWuPSHcJLFQLbHLADAccCXMFLJHfoegZlEqgXslQJUcVVSsfBwRwnnwcaMYozZXAayrCAnMsJSiVDVhhMcHBEoIaShFQDhdPPxHpiRLlhAiW",
		@"IghJvEBWkbQdCnQrUQGRwssDYZJSJGcWlCnlTqptKfMxdqfybdkSAUssFocFBVkMhfymqQISAXkNCWdLJGHBEFRtnUGtXSsaEZyxPLTCNyhavbIuBlcZKfK",
		@"uTMLzWNVWJYYunMOHNMTbPkiWEqwRDzudyyXYXrOofWKgUdwSpkdBdeAwGpiMAqrHFZbvKsiIKWwPjZHIFHfkeBizEQyeGkEcoibjxJakVtFhpvCDZButKcDlCn",
	];
	return GwKzTGWjqZVDlCTHKtm;
}

- (nonnull NSDictionary *)YgjWTEzvSasRnkBAP :(nonnull NSArray *)rUQLRhpWArijinIMLEg :(nonnull NSData *)RuwhKdiqSairvdUXgv {
	NSDictionary *wfssLchivIdFwqdEjz = @{
		@"XCoTqddTdlabeZBl": @"KKaOckNuVTlrkNQekDVIOjIxOxZSbthrHJqNvgCEzgrySvasXoHbxxItwnkDOGPneGSCGxplWXhqOrAczmcCToYrjVdfQSLxEKslRadcBAMMezOfYiwAkmuhtENSfTgA",
		@"vQArYLlTZTfMzdwHWMt": @"SErFSQjRxjmyLpMmFHCuhobAjUXZPmPAXfbDmfwWrQaBUbXfcHHAbqwtJkbSMApELxMpwxkGqxfNDCTPKhNqCfrTJSsIFlxpxwPaKgUCeSVaZbzJnzNTZGgvQmECxdVMmRnVXabQUUCgocWV",
		@"HNBnJnGWknnKJ": @"YDUYJTXBZqETvXqaWmNyidUerLTewHDIPEYueNtImtshEchDUNTYnPnsTIIjlPGnzCMCUfsQYJNXtMiZSFjSXBoHNOZGssGVnGKIeAxDJdjMcmWSDXWMRekTgoFZbvvbmQQecTPVHhikRTCJg",
		@"xJBchnvmfVhJa": @"KSAjRaqilErDCymZMQlMXdGxjZICLClnrMfdgEcMXkdDuZSXCleBaURwDlzKidkEDWsICWWAodQRbNMdCkrarImVjygObcuBQhNuaMsdE",
		@"dTBCqDNwgIOUH": @"gWxJReTMwjKoCqIojhUzmritMOchLlgcBycQAijPkqDMfeEptaFjEQiMdiFYQHjJBFJEFrVngvuVnPdZwfBTyoDIYGIsFdGcJVUaNttmOcrN",
		@"qgmsfKIZXJWn": @"RYQOLHmbeaeaetzesSrIxVQCPYSVErjBLBDIncKGsKxakCwwuMfukGjDUXdzYHeQNFgHameCOZKiLraJXIfKuipjldQMrzGVeoaBmsruLxOUYVgHJKKepxE",
		@"PKtfwrHzVAmIx": @"UIKlZQXAtgBcBVurYlzDjXvdfRUAskaYIKTRoMZNKANwcDOBMTWubAzmTzxOCfeEfBzMznnVFKLHaqnejYxLGohPBlcnhlrjeFtWsf",
		@"WpYBLGLVLQu": @"xtEgJgEVCVeyuzEvDjbrpmFHycfJIYltUwWRTlgsQDqSeSyRykaqftPrzZLStBcCkWTjouIDEuVUWaDElgPwWWdTKcXYMAjaSvXJtvWlGK",
		@"OrTtrcIxtual": @"FyIfgJSdCkutttMtRRnOJnALuEaUvGblvmXhGUNJDzrGyTMnCoDdWgWQZtXHmaDimasmAPPBqrqQHQGjBTkjlZjulruJiBbuXQtidJTUXGG",
		@"HbZTnMEytoWvTMU": @"ARXlJByWRKBnZiBYqiyWbFykphCXuPGyGxcLchnbfxxbLsuBcSHygDojIGommuzMfXLnGbouChQxJxuPlEMuCyjITHgetvvQFNQyYvhxIqSN",
	};
	return wfssLchivIdFwqdEjz;
}

- (nonnull UIImage *)BuiyhqPbeBvtSgLc :(nonnull NSData *)ulxNbhlbfQURYXK {
	NSData *YBdlzUroYbvftcsL = [@"NAchteZMtNXJbvXSCXIABkkMCdwjSdwRtlzCqzHkzDHaEjTLnWCvBDabaSNDOGBTKTmjmRKdbyopvoKgYxxhEZquyHDPiDbFJbskMawOBdaw" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *RleqbFnDCSWfDDVSAA = [UIImage imageWithData:YBdlzUroYbvftcsL];
	RleqbFnDCSWfDDVSAA = [UIImage imageNamed:@"PjkCePOQfnRNbqqVzjbgkQOyZlodkvKOosLagkuVTkcdtrOOvBEhVrzRZuuyTmWzoxMHFaeIuLqwvKlgNHOtHpFiXUdoAryIdMIWgi"];
	return RleqbFnDCSWfDDVSAA;
}

- (nonnull NSArray *)DnTxcpzpqUvXh :(nonnull NSArray *)fbDNpEBggEHmjlD {
	NSArray *vQYKDYWIUpjFbaf = @[
		@"lghWOQPAXpDmEnLQqepJtSBzmCnFMfFzuDgNgGJbKxLKdYgdXVgwrBKktpRPagDhMMIPRcsweEPIdEFyTwVkNYcDTPyWsyGukhHbKSKXoJgPLLlcSkjlicJADXblckrPzCzrEzPzABAVuxMcURL",
		@"zAPlGfIfcnJCpHMiqgLnQhxVrMYwyuzOKMgZmPhdektMFaZOgVdCCHQfMnoYHkjjtlREiiRDnDqUsifbmyLSlmkEBgdQHixiHNTwPxbfNSTxADZiXRcEVncrbdWUmHOw",
		@"txELCCmjgYQIGttUFlfNgLycARquKboHqGKVGCuVrjmYchiUOzSAdEEFUqExdraywlKHrKkpyaEQGBwNEExzGXzKIqbvhlMOkkBQadNLEIUbPweyXIzmZgkXEzWEXnONW",
		@"GIDmZFgjIpgZfyxDSEoqMoKNChUmTxWjRKXNyEYTAEoMGZVDcGlhZiDRQwYOUUDUzCJJvbYYtPVkMXtXcwxmLiceTXvjWHBGhwzohZgEdofhrQE",
		@"GaQodYmWJoeRvoarliQuTlicxhQddrruKVHAJaJWMKsAQuIAfyjvVTRXhIneVLIlPMPxCwXJwirvVtDGaSPbKNYsGryrZOoICTWDunNsMspnC",
		@"bbHuQTPeLPagbaKsyocJHtIjknVOEFgYNmGiOJNIJMStLgozsybrTqzMWsvpnTqilZHEapXReKMjpdREVElQmbGNIGKkkvCblPzAnxCnhtpyxqhElgEoUSbHDkxFCeKiTaHttpgD",
		@"OwIyLVqIzkIVPsBCmCEHpbhEZdvQaBiUfwOTlCZklNykasOYIihbuHNTJgjAXxVLZpxyZDnghIiFIdgopUJypFodxUWYeweAuKvyCtHZSSPeLMpRnFpCqt",
		@"gpjSdNjPYvRgblZQgCtUNjEtjBmsqJmzQhASnoGftRPQKPfUdthsodjhZAtZVVxbTdVIovQixDgfgjlxVAUnqLZzQKGZokjZWbppZZIlkTSeuJSKUQnOSqDQJxeC",
		@"jWJlTGGFFMNwfzXHtXXXiwmvOYDDanTPvvZrTXdEseFdvdvqtUKRcHDcmJgxWeBVwxLcENJwFcxhRlFDRiRsolzGSXHgguJgRdGPkrOqaxoOXWHdEXPxFXibcYUvtOLglANaReZARUoMDZaANOL",
		@"RDVUtMCVGWHcxGBDLTXoAqLIVlnYMgTyGFXaKFgQHbaKEgUZKPHBvyeniBzdaVUTaTbucqTilMDhLCobHEEBzmssObCjwWpHMFyPMdHUFjALvEDIWYfrfDUkUeebLNAYfUhMrJDVncOqWkYWFQL",
		@"YZHXMhFCYZrRQWnBNyERiHZQyDRNUnQIjdmXcgRTMgIoxoDfalkEIMBOiXUIUQvTjgblBthySPCivtyXAwrNAIVqCdlrqmDEBTVzRiyNeuhfVSdEXhYYqDhdffWlYfPbERjrx",
		@"dtwQsXmrmXGKdgElrOvflxjcBDAGVIaUDVrkFWdPTxmRyHeAwPrpjGvORvklnIyfnAYBxQzPNkEoiLavUBJkyduIpsASUImcQUkEfhnvXEhWeeLtcyABlQNRtkdhTFfRqlrbsVktnCBAlDhzX",
		@"goteROidsHiUlMZUsqNxBFVfSKJETjyULPAfPXGspszdCWvgcKLYeotMaBlgipcLiPOWIBHVwtZMOoOgWCcLPCFMUsZhpfGZpsyxOGmThBPbwg",
		@"xLolqCHtSosuACSytsUDLpgqsFuJpbMcYyEBgTbgRYtPZZVkIQhswiQPHNEuFyggmJXroXgrBIgRUMvdnQQMMPYoyXOyYBhQDVHRHxOMKOlafOlh",
	];
	return vQYKDYWIUpjFbaf;
}

- (nonnull NSDictionary *)UZMHFmRIYLAfLzkXM :(nonnull NSString *)QFTPNVsqGlqGZ :(nonnull NSData *)dOlhAtcIijcHQ {
	NSDictionary *QifZiTUIfWJCEpBF = @{
		@"dauKluhyqajgWUXPzb": @"dgOHIRTNdyuVbQXBJhVnaAeFGhNRGxdnFDAmvVcGizCmxMuopAjvSyVxqcLlYeOdYrLLjGEaMcSdaXmxtXCgBBpYJqvDOavoqSALkAEEOuMOGjXGFCpAFIZKqStjmH",
		@"KGkEwWNbjnwws": @"WVxgTaCGEftUWuFXioaWcnBldMKJbbgbKKqJLbZGyTXZTnFHCsCYMQRsYlcwtTrEzhaPISEzdYgNWfxeFKlaSinVOZfeDqZKcTvpqSPcuZmredCBtsGYseYqCHVtypMVu",
		@"RDlBbLypCmbdxZg": @"eexKdEvvIuNWSEkPoNdupVwNVaRsJKWIGOMtBocVTFQQwYJjdakiJLpPZYBhBFAHfksDMXJoBnpUYMfmbjpPftuBZoDJvCcjxeoVDLbqewoAwsbWeMMgauGetZBsMfOnwVAEbkPvJpgHkecCon",
		@"iadibilwKzQ": @"hiebgAUAIBfFJQsQLRXAgUFAdlebOUUKkFXvtxuLLKlXqGpJVZWgolzGuXqwElfimHJIEMYHWBuhWnLcffHeRMobdmLrgExPMXgonETaxWmkJoBYAwRnhPfKdxEjVpW",
		@"niimNqQpnimcMCPwT": @"waDUPndrSkeonEYOZWGYIPVnNZrISHhlTBbsDGsEQPySHOWFIppQsHcPXLZvMKQaFpuNluqqOQPNXBUBtxWYgvyjhEFdCzRSFlzzIOPYxLgvRhSGIapa",
		@"KjxSYfJgnZqc": @"bQKIUqHLtKLTWBoDlCvlMHixIrsIfrhMWWgjQUWXqWzdebjFoDFKrrGFUzcczWrNYEKIYGnHgquuQQBghabegnQfJPKTKRulHhLmcoPadXFtSOtNiVJkLWcdTIBtgyHrlsEIaQDWdzfyObgOxJVuv",
		@"rlDKzaYNIqN": @"TCrAEjJLSgbqFWtZkNXvvblWBtXEVOCaQMgnjkwJPRIYVPbGIGSFPlreKBFpEryYcgBkysuVusjTdIEnAILXDndcSdmQplLSpSsqmJzdMseLufmGFkBhaMywpVMzmTLXNqCQwIxAgNAf",
		@"YIfakcAfpIlMHkMh": @"mCxYqObzrqkyBXxFqxSBBHrnVZTfJnrajDEuWxDvZioBQSQiQNDatsxQIOFztLuYEhqegeQhgCmrCrKFZVhHuLFDUrjNlYzRhEJAgUgdRhElMtbgOpW",
		@"kjFBxUWAhhZcKUZn": @"sNdLzuwiKmzBnBZxVBjfYKgftdTWAjqdWbrUeacVQFqSzOxlQKatCBguSkjcIPccTjKzPUGoigKMYklNJyHuseAgygYtEgEDuFmozH",
		@"RiNUYWsERVezfKnHXhw": @"nGYnVvXJzGXrXeakMTQIQIyXklWYKcIXrNotPCpeMFHQscdDlnleYjLXhYLRBTDnBITMBtokYrUNqfdvEWvTWZCCNWkoHKmXlylJaugkyPzLs",
		@"cVMENlKVflOgHvq": @"KnqkunvRyeyDkkttVDSUqsXteVUyPiOywOraqSSptILPkgYomCOZMwWatYGTyXdAQyckCwKkcQcMGNnhNHnckRAOCQnIUpqjZlxAqbNmDLVKsgyLhZQIdMaUwXYvmhHDUOsvDf",
		@"VPbKrVNuwTEKSdRz": @"KHMCgMwedmMMQbxawxbdjFYnxEbcqhpJaYnwqIVLmxWzIpENRcwTzMzDHQilgFVCvmNDoDQpeaaMlxpXKHftqzQaqlAppqifIEdAYcbopWbeWyEXGHThyfapFZgSLUHFczWaXcHVbLFEmhvEgrEqx",
		@"rtSJwesbRbRDn": @"utrcBhKZxOWQkyJKxpzyRGeGZNnBxuQlymJFVncpMjelTGgZZInMlISBltqYzFhviPOhFvraDFPPEdRsjkTaeSnxWppyjBvHpeddvLpEjtPBGGcH",
		@"fIPWiELvvcN": @"OSYoFFyyKAMxkCTLreYcBsCrCIEoaSpYovZmACtIadWAvgEnYAUQmlQqfLGSnzzKfTHAQZljHIkmHrqGrthFtYdSLckwaNMStnoDxTe",
		@"vBzaDIHaCDohCG": @"IFxsaLwYiSoPiwHmqVOxWbYDuqCYLIhIvIWSWXcrfMIoSdEpqLtATMPPjLYnxEaBXDmAIZXnwLeYqepUobSeVekbKSGvArCIliFuHzaTiSCxNJPmiQltapUYzYRoKgGBLishKvRdyCQUYNOvsvbTA",
		@"bukEtYiIuR": @"RQQVmvQfAMBDnjjoSCWMStjamrgoXQHiZGmkhrBTaHQAtgERkcBLgGfIATReqHEkXPSZxzccdyskABsDfOuVhrsuiTGIfvKakqZEOCobWOmQaPUrKEXzbxeRGibfDFVvjhIovjgjTLwbKAtyLo",
		@"DGIQSnIHDmzziXfQlao": @"NVIfFPPjBoNeEMIeFwIlOiDBVAsTGAUnexZTyWClpEiEJUiXynkKQiCUEcPKgsdVXPdrIUMKteFCJHtoEDYOUgrDwUBeIayJTgUslzGzKZnCkgPpLFHWWzzmTeLsecpvvRPapXQotuhqIdC",
	};
	return QifZiTUIfWJCEpBF;
}

- (nonnull NSString *)OVRvfNaRWsuhqSiLo :(nonnull NSArray *)bvbqNRMuNit :(nonnull UIImage *)aUXnymSCDHHXCCyNTy :(nonnull NSData *)bPJaPUkVFgJbPp {
	NSString *ilZjxChTXDjbzXQfGGS = @"ibWDMVbIaveWClIvTicEHOOVKHzTtZYGQKrheiCofeTplaBAOJMMmMIKfSSiHBPmOilNZFQDbldFkjulkZvIwZJHCkiyZBWsAcMclDYPvGEOcqySWkMUPEZgRlCKkoXIxYsklPDACVhiL";
	return ilZjxChTXDjbzXQfGGS;
}

+ (nonnull NSData *)AOuGoVlKkZhcNzM :(nonnull NSString *)XStGzjYrlXB {
	NSData *EylmwdKkMscZmpPdzEd = [@"eECKqlcYmAhrybkzILjvkqFhVmViPuareOqZeniYDUlhICUqOZudmQLQIagBpevVYZNrtPZxSUMhLFjexESysBpLUanwulqiqqgcUkvQXZDPPksVIWVgNnvWPzkZbhxJ" dataUsingEncoding:NSUTF8StringEncoding];
	return EylmwdKkMscZmpPdzEd;
}

+ (nonnull NSDictionary *)beSltlivJKpnAg :(nonnull NSString *)kmISGxLYhQfc {
	NSDictionary *eZoAUrKgiYCfkzjsFA = @{
		@"CmzpkJsHcrIT": @"jNTNSiuwUOAwWctBXvrOswogbdAgbzMjLXDDvxdsThhorvWmgUrciHSxBJWbvxmDElbtATpdJIxijbbOCRLAKuYMcEYjwpMbVFpuszoIxAlkfyzmQTzlCzHwxAySGTcIzYoWhx",
		@"IFtJdZCxac": @"zcgkRLKwsKFsGpifvgKFcPChRrjGERNHqoOpiXOdqSMoEsnlxlYEmPBlWPsJyNLgFdyNhIGQKlzAFEeegnTzteaQteNeKBcBbjIshU",
		@"zDNvANDvjPiHI": @"qtAEEhujzgspWaAMAvXomeotXZKcbadCqaXOSxNtErqZOsvLoDSdfOteiQyuILqPwpBBoqpvsWsDoWkLbMGPVtsTacJkfNoCdsQxvmUXUECFUaqKezhtWrPkuHpxWlaEjrDnkOniAEOoYpSmqPkz",
		@"xqbtUIjRbmorBPRame": @"jVchDpJTrAQmIzOXIQYEBzSssChzRSkOToKqyXYRUedouiZJVSfvGHlupJFJZXOAYqefyJTlKaxQRmaFppoipSPsJtWdyQmIzdJNHqHGvVxKZFaDaKKmuRwtImfA",
		@"eVhIqZUprSaS": @"MwwqhmVqFDeyQYeDkFosKWteRUwPPhPJKyvsgTQnwUQJQkYdVqWtNdPqwNfmzeFXyTKqPpcTzbsLgxkhvWicAIflBPmLjzgtJrAlxWVDHhOBhQhehfxnLozMkgjGPnwxdVwAn",
		@"RuGdXBbcnAntjLvpzgo": @"rZhaNpaiubTKYuuoHLvAdyAVFPEgzwDZHzvxmdSbfwTgrRAgfZxHUlgKuNQpwfCAfUzUyQyzBKMBUsPAgASIZKXnxmwKQzixBKxbwHptmWPzmj",
		@"oswVnQJRNOnWKZCSZT": @"jFLWlhqeBlskbdAMgCrWwLONieqNGyFvJmQrvwZuUnVbSyVFMHjvriUZaXQjVAuHnDmqMDNgGfSdocMdMcGmyhjGWCVaFEhVTaVxxCAiuBGSVpBkcjHUcRHpU",
		@"hZRPYvWJagvNTptM": @"CrpSNJFDMffTXksWfAQixiONzDquVlclesBEkDfFudgjVDqkeabIVDOFAfXweEpIKrfObvWrNBnxarrFHLUqpUiMJAcmsWKGZfIVIFTEsFHmyPUcAqqcEVkYbseRDOUakGPBtNfQue",
		@"JLvgdPDZFhg": @"jfnherrGbGtiMRuCHJovJmKingOADiKtxGpLXaRaqKlIlkZNTZPiLSQaqXZMbeJuMjXhgFfJqKuRCmwgdsdLPDHuDZEAwwOBTqCRfUFwZqtChTPAicRGtQVHmHgl",
		@"UHruXpzXyzvdTPW": @"MEobKoECjKynaxrFcRssMHPRojmYuHdPjftZHgJEqlfzmjCcANKKjEVnjHEHIOKjAGmnITbEPMVifiUevgZzZNVaxIEgyeXfgDVtvvgiEOAxaMpTihlxqIKpwFgIaMCxEDhW",
		@"MjzaBgWiTaphjymHQY": @"hneeWWPWQUwCSQdxPliwRMDalJvVjHmqBqGnwRPqYcVngLEaQisZRpzzEWDQPspgMlROmwCZxUWhUjVJIjRknxkIhgdnKPKFNlzMXCsyTOtgHlxBIUzSPgV",
	};
	return eZoAUrKgiYCfkzjsFA;
}

+ (nonnull NSData *)wBvOonPIfrGxXY :(nonnull NSData *)hnBvbArYfEN :(nonnull NSArray *)ysnYJmkfUWwGWlR {
	NSData *mWdfvXdxNVZQG = [@"BZyROYKhqBDuGSjDzEJNLjBZXUcGCfKkcoqABSEIetKcpYKdeXCBJUfYembzfKxRNdjqGfAXNSJRZwlqSPTuzkPzrFbdhlxJnzwqtKfJYjiLxuEkDtPNGIGKW" dataUsingEncoding:NSUTF8StringEncoding];
	return mWdfvXdxNVZQG;
}

+ (nonnull NSData *)mWFlZzhxTsX :(nonnull NSString *)PtdfEhGMDzwsNjYxS {
	NSData *ewMeGMSuyalSntxOPp = [@"RpWvfuQjZjjeAlaWhAfKvCuteMKBjdozueQXIKLrDQTLFpcFsFIjonjATKzStejyCQpgJSHYHaegXgQyQsueDqsRVCDRiKppMmSKrwHEvWieAGDjiDBkcvDNPJYtyhVtDObohwY" dataUsingEncoding:NSUTF8StringEncoding];
	return ewMeGMSuyalSntxOPp;
}

- (nonnull NSString *)xPLgbTAAKf :(nonnull NSDictionary *)cGgpCadpzd :(nonnull NSArray *)NECdtImEKJQ {
	NSString *TTmXfQkZUTwPSknX = @"iBHtoeKxllBKJftIQiNkGfXBYeOANpuFQLKUqGiIDUcnqXdSfpSDVwowJtrMMKXgaqyHYeMbjAtHFCJrbJDAmSnRHCBNPqhuQUcZTFMglaPBXQuFjellIhsvjYeqFrODulvFpzEHKEwefJVrUi";
	return TTmXfQkZUTwPSknX;
}

- (nonnull NSArray *)QsgYEorqaJjIfqvgf :(nonnull NSData *)FmRGrZIYHfgaM :(nonnull NSString *)JXMiyHnbArv :(nonnull NSString *)EpudywCatxljlTVas {
	NSArray *zqqRBJyQRUm = @[
		@"HDLcZCXXEinYOJDTRieZUpBLjKFLBGnMAtWFvliJhOATibDceSLSsVvijFmWZsADDvoCngGyFXiaUuFJFWxBJNpgwAiDjSGsohWvwPKrWKVsZiEFGghWEfmOjfQoHl",
		@"YnwnZaqiMlNxibxqbzlGTCAOyPZFXSvbzuwJJkOUCgAfWuyqddmGHnnkykfWjwzTgTNZeLALsjLoTObCVawZYLaEGEbrAUjknErbFzQowrwATZ",
		@"TXDXOEjSPrRBmzquUdqvVgcIOUbzavnEErqGIewWaMCpIWlOzoFGLEdkjVFBrhRKgDsJSRlKrVQxKaLarCKtGsbisBxMwSMFciLVyAvOaHDVmF",
		@"FiTtShnDYDDRpekbBRnAFiarJlpbembPWRhKPSsSisAbNdvLExNWzVboeSiVZqKcSUgiZnfPvsYIUCridNfgCfMqaXzlJytTtwdmiLUF",
		@"hyhrzZXXfujqdSYkNPtdmYGDxuTDBoDTKgrIhWNoPJZilxBcMvqQjTqOGlEBVkJKGaDigTTbQjKKUzElZFKxDqWRcROxRlYtPzlTnRglDTLs",
		@"KVHIdKUjyFRDsilQpMBntzpzBSRdmxJFkLXLTaPZmDJAKVXroCPngIYDObcUozUcalQfzTQtNXmNBUmIfABfaghEeExCxtxLKHveTaMR",
		@"AgVEUJElfoSZoMrksWZbEcWHLbxGKDdSFoiUYxNfKMuwRxrHYXVvFDCitABNVPZITKpGjfBfTGgWwjiDdnBpXVqIKimesvjlqmoAZqzYckXfthvwSDKAxPZKiBiJgGSetggRrychugoGqQO",
		@"jforGSocKhfenZIVIbjIdtHuXigbqHwvTNiKGocbTHSzvpqrzTLYvDKpvVSvShFlWeCUHBkduRdIPmLkGgXzUeqzltlSnCFroRNaPfKSMpuvHtcKTQdOBNjYtbOVieRobyBRHg",
		@"BGVKbMuyQSPedpAOtVcjbuMPIHOOaCXZEzDEczPWBefXfVUbRKgMQviIrUiZJWotUXVDGLdKhssRyEjYOmGLcqDbaBlktSFFZEUAJDsXZXAfQaSoGaVrOhMjymtwVjdNbLXzCRxAxZdgxd",
		@"VFGZMtzSwApqZLaVyhkgDZznMLStvYxGVrbknFHkllSvgrOyGCwWviuNpqCMkGZzfHGemcxUQkCzIbJphHMlmKjAkTEkplaOlsYCSjVBAnElmNArjQIAqSQNbwkNIHooLBkpyZ",
		@"JsIepnOxUyJSWDbMnaaFSRMMoMXogelIIIVkInoUwYBYCXUehlmGfvUMktKNXyRYSsTZtsHSrdherqDEMJIMmlHmLqHvQZMehWFjsIYonjAttHcoLKaUEHIHNOVTX",
		@"wTXcQhgGyLlqSEVqgmmukGOLZsvPZGywcqDGVNWzxCSWUZzyuWETbQvpRKguHKQbzeKTJEgmZmryAKBCdDtKaqnpgoytmOGGVUEvLhqEulKQCrTeIR",
		@"UtCOdeQjWfQZmoIIMRBJpYjFQSfbvmsoIPFgXQgBfbSBxPkkerXflZCaGLIHzPnqFglknSBmbMSfxNNtGHfFrsHTtmSWWeTmvYcFzU",
		@"knlLjiRZuBcbhVteflPTCNRkVKBrkUITrrAQpvDqSKRniNGkDKmKukyWUHycnmnRlnMTDAqfJxfVXzfXonqTXkhDlBusEfMWvgMUxpyiYqtiPMEhzTtEcNwknSOGJfxalvyRaZCItEltqPfHa",
		@"nJONPbaLwzbIHkQrtNhZNgGlxyfYipbmMYyaIhXeuXFmUQtswBrqqizwVHRqzlPlIUHmXgvUyzweeIrYOwduRpqDZtbFClctcDJAMXC",
		@"BqRSHFwDyfKnkvjMSKrJTHQbglictnGmNGUIUVkMQxneuwiWjJtgFxyRfMxNveRpJhXhzQWiyXkcogMSrUuSFKGnFyOdIdNxdGWGNljlYKAWqwzdJLpQKfbNfCNZMvnyMuDiVtXGljq",
		@"JKbPuDMMAAFYoXyoLWZMuOUpvJFDVRNbAuuKdPyiTqSkyBLNFZNmMJwoTJtFTmPuLvdhbXGLTuSIbEpgJpcQkesMKvRqoQYPHcEfFVqYsEZunNltorzqYUNhpulLWEsJEmHDkzxFgRLbpmfztqk",
		@"njpDbgKODBIkktCnJWTyfEcilwwygMtRGrkSaLOQueboaoPPTpmZwKzZbgmoctZHnpSyWejrhlffyiDlPyJwUdQlaXgCFOOjjljuBzwnUeJPVXIbLQPvOIrBHkFGWgACdNwpOSGu",
		@"qVgLIGCzWrCvKNnsdPQyzgBEefpYNLLOrnlTvKJnCUnCtNbOWnJWOwCgtdHekoIzibyVOAQwuzlmFzMuSZHHqnKpSbVJzUVWBQEbekVDqlrDDQTeUNquNkClBuWpZXMxKffxfldVBkkMjnGBssdr",
	];
	return zqqRBJyQRUm;
}

+ (SDWebImageDownloader *)sharedDownloader {
    static dispatch_once_t once;
    static id instance;
    dispatch_once(&once, ^{
        instance = [self new];
    });
    return instance;
}
- (id)init {
    if ((self = [super init])) {
        _executionOrder = SDWebImageDownloaderFIFOExecutionOrder;
        _downloadQueue = [NSOperationQueue new];
        _downloadQueue.maxConcurrentOperationCount = 2;
        _URLCallbacks = [NSMutableDictionary new];
        _HTTPHeaders = [NSMutableDictionary dictionaryWithObject:@"image/webp,image/*;q=0.8" forKey:@"Accept"];
        _barrierQueue = dispatch_queue_create("com.hackemist.SDWebImageDownloaderBarrierQueue", DISPATCH_QUEUE_CONCURRENT);
        _downloadTimeout = 15.0;
    }
    return self;
}
- (void)dealloc {
    [self.downloadQueue cancelAllOperations];
    SDDispatchQueueRelease(_barrierQueue);
}
- (void)setValue:(NSString *)value forHTTPHeaderField:(NSString *)field {
    if (value) {
        self.HTTPHeaders[field] = value;
    }
    else {
        [self.HTTPHeaders removeObjectForKey:field];
    }
}
- (NSString *)valueForHTTPHeaderField:(NSString *)field {
    return self.HTTPHeaders[field];
}
- (void)setMaxConcurrentDownloads:(NSInteger)maxConcurrentDownloads {
    _downloadQueue.maxConcurrentOperationCount = maxConcurrentDownloads;
}
- (NSUInteger)currentDownloadCount {
    return _downloadQueue.operationCount;
}
- (NSInteger)maxConcurrentDownloads {
    return _downloadQueue.maxConcurrentOperationCount;
}
- (id <SDWebImageOperation>)downloadImageWithURL:(NSURL *)url options:(SDWebImageDownloaderOptions)options progress:(SDWebImageDownloaderProgressBlock)progressBlock completed:(SDWebImageDownloaderCompletedBlock)completedBlock {
    __block SDWebImageDownloaderOperation *operation;
    __weak SDWebImageDownloader *wself = self;
    [self addProgressCallback:progressBlock andCompletedBlock:completedBlock forURL:url createCallback:^{
        NSTimeInterval timeoutInterval = wself.downloadTimeout;
        if (timeoutInterval == 0.0) {
            timeoutInterval = 15.0;
        }
        NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url cachePolicy:(options & SDWebImageDownloaderUseNSURLCache ? NSURLRequestUseProtocolCachePolicy : NSURLRequestReloadIgnoringLocalCacheData) timeoutInterval:timeoutInterval];
        request.HTTPShouldHandleCookies = (options & SDWebImageDownloaderHandleCookies);
        request.HTTPShouldUsePipelining = YES;
        if (wself.headersFilter) {
            request.allHTTPHeaderFields = wself.headersFilter(url, [wself.HTTPHeaders copy]);
        }
        else {
            request.allHTTPHeaderFields = wself.HTTPHeaders;
        }
        operation = [[SDWebImageDownloaderOperation alloc] initWithRequest:request
                                                                   options:options
                                                                  progress:^(NSInteger receivedSize, NSInteger expectedSize) {
                                                                      SDWebImageDownloader *sself = wself;
                                                                      if (!sself) return;
                                                                      NSArray *callbacksForURL = [sself callbacksForURL:url];
                                                                      for (NSDictionary *callbacks in callbacksForURL) {
                                                                          SDWebImageDownloaderProgressBlock callback = callbacks[kProgressCallbackKey];
                                                                          if (callback) callback(receivedSize, expectedSize);
                                                                      }
                                                                  }
                                                                 completed:^(UIImage *image, NSData *data, NSError *error, BOOL finished) {
                                                                     SDWebImageDownloader *sself = wself;
                                                                     if (!sself) return;
                                                                     NSArray *callbacksForURL = [sself callbacksForURL:url];
                                                                     if (finished) {
                                                                         [sself removeCallbacksForURL:url];
                                                                     }
                                                                     for (NSDictionary *callbacks in callbacksForURL) {
                                                                         SDWebImageDownloaderCompletedBlock callback = callbacks[kCompletedCallbackKey];
                                                                         if (callback) callback(image, data, error, finished);
                                                                     }
                                                                 }
                                                                 cancelled:^{
                                                                     SDWebImageDownloader *sself = wself;
                                                                     if (!sself) return;
                                                                     [sself removeCallbacksForURL:url];
                                                                 }];
        if (wself.username && wself.password) {
            operation.credential = [NSURLCredential credentialWithUser:wself.username password:wself.password persistence:NSURLCredentialPersistenceForSession];
        }
        if (options & SDWebImageDownloaderHighPriority) {
            operation.queuePriority = NSOperationQueuePriorityHigh;
        } else if (options & SDWebImageDownloaderLowPriority) {
            operation.queuePriority = NSOperationQueuePriorityLow;
        }
        [wself.downloadQueue addOperation:operation];
        if (wself.executionOrder == SDWebImageDownloaderLIFOExecutionOrder) {
            [wself.lastAddedOperation addDependency:operation];
            wself.lastAddedOperation = operation;
        }
    }];
    return operation;
}
- (void)addProgressCallback:(SDWebImageDownloaderProgressBlock)progressBlock andCompletedBlock:(SDWebImageDownloaderCompletedBlock)completedBlock forURL:(NSURL *)url createCallback:(SDWebImageNoParamsBlock)createCallback {
    if (url == nil) {
        if (completedBlock != nil) {
            completedBlock(nil, nil, nil, NO);
        }
        return;
    }
    dispatch_barrier_sync(self.barrierQueue, ^{
        BOOL first = NO;
        if (!self.URLCallbacks[url]) {
            self.URLCallbacks[url] = [NSMutableArray new];
            first = YES;
        }
        NSMutableArray *callbacksForURL = self.URLCallbacks[url];
        NSMutableDictionary *callbacks = [NSMutableDictionary new];
        if (progressBlock) callbacks[kProgressCallbackKey] = [progressBlock copy];
        if (completedBlock) callbacks[kCompletedCallbackKey] = [completedBlock copy];
        [callbacksForURL addObject:callbacks];
        self.URLCallbacks[url] = callbacksForURL;
        if (first) {
            createCallback();
        }
    });
}
- (NSArray *)callbacksForURL:(NSURL *)url {
    __block NSArray *callbacksForURL;
    dispatch_sync(self.barrierQueue, ^{
        callbacksForURL = self.URLCallbacks[url];
    });
    return [callbacksForURL copy];
}
- (void)removeCallbacksForURL:(NSURL *)url {
    dispatch_barrier_async(self.barrierQueue, ^{
        [self.URLCallbacks removeObjectForKey:url];
    });
}
- (void)setSuspended:(BOOL)suspended {
    [self.downloadQueue setSuspended:suspended];
}
@end
