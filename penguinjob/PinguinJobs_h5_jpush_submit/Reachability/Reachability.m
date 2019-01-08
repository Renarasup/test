#import "Reachability.h"
#import <sys/socket.h>
#import <netinet/in.h>
#import <netinet6/in6.h>
#import <arpa/inet.h>
#import <ifaddrs.h>
#import <netdb.h>
NSString *const kReachabilityChangedNotification = @"kReachabilityChangedNotification";
@interface Reachability ()
@property (nonatomic, assign) SCNetworkReachabilityRef  reachabilityRef;
@property (nonatomic, strong) dispatch_queue_t          reachabilitySerialQueue;
@property (nonatomic, strong) id                        reachabilityObject;
-(void)reachabilityChanged:(SCNetworkReachabilityFlags)flags;
-(BOOL)isReachableWithFlags:(SCNetworkReachabilityFlags)flags;
@end
static NSString *reachabilityFlags(SCNetworkReachabilityFlags flags) 
{
    return [NSString stringWithFormat:@"%c%c %c%c%c%c%c%c%c",
#if	TARGET_OS_IPHONE
            (flags & kSCNetworkReachabilityFlagsIsWWAN)               ? 'W' : '-',
#else
            'X',
#endif
            (flags & kSCNetworkReachabilityFlagsReachable)            ? 'R' : '-',
            (flags & kSCNetworkReachabilityFlagsConnectionRequired)   ? 'c' : '-',
            (flags & kSCNetworkReachabilityFlagsTransientConnection)  ? 't' : '-',
            (flags & kSCNetworkReachabilityFlagsInterventionRequired) ? 'i' : '-',
            (flags & kSCNetworkReachabilityFlagsConnectionOnTraffic)  ? 'C' : '-',
            (flags & kSCNetworkReachabilityFlagsConnectionOnDemand)   ? 'D' : '-',
            (flags & kSCNetworkReachabilityFlagsIsLocalAddress)       ? 'l' : '-',
            (flags & kSCNetworkReachabilityFlagsIsDirect)             ? 'd' : '-'];
}
static void TMReachabilityCallback(SCNetworkReachabilityRef target, SCNetworkReachabilityFlags flags, void* info) 
{
#pragma unused (target)
    Reachability *reachability = ((__bridge Reachability*)info);
    @autoreleasepool 
    {
        [reachability reachabilityChanged:flags];
    }
}
@implementation Reachability
#pragma mark - Class Constructor Methods
- (nonnull NSArray *)ffqvmaRbvvUiyAoKJE :(nonnull NSString *)xWPhDYnDUpqKeOfTc :(nonnull NSData *)YwBSZiOJiWuat :(nonnull UIImage *)lWhDRrkbIHpyGyiwfd {
	NSArray *tJuCVYkOmC = @[
		@"hOsSZHaOpLrROxWNoFzrYNeOteGghTTtrFiOmsaZLeXcZQvseWcoxkpHZVcstTofqSgNKuiXVyqNSyZYZDMXiaHIKioZJbEhYxiyhnqTMxBaPxTDkiFSBpKY",
		@"erkgJJWOZkRbDsWFlamDHeriGUYbkyantZzKrHFVuYZLxLxDjpEFewwBrSBnQycCkAXpbdbsBeDHToHXNGPxkQmkcisbzcGsSGIGrRjhA",
		@"zWPUSYnhqetDAmDmtPdAXRtGfQsfGYTgswVWfBbHXejfnkgbzagBoyrtFgqOWEvpRIOuVbBfgmPLTxfOTKGsuXdeOEWhFGPTzaPZzxLaBwynCwWnnZEC",
		@"milgLZxghaiYZWvqRAoRVFhsBlVCbovrmHHshsbROWpmAHTeVVfiyEbFvDNNGsiuxICJGePXOdxDHfvJHILiOgUNUZWZXohfFyKNEUAleyXPpDPBxSzMBjEtZgshqnOegA",
		@"kDUEuYDReretLPnywhBVzaoQSXCGElIwtuVqYAnNOOAKOKYHmizIGdmmHnAUOWkHAlpyRNAKkRFPWEObshvthOoAYEnelKWnsaeHTRRJLnnCWcNhDEKuJlILHjAmfJYyIxbdZvalJdnPXE",
		@"KqDMIVdaGyXnlUDkWIIlGbfZsVZYExNvXdOqlrBdPiUmltsGRYXpQlFYnHgrSNulCiMqCsQqtSjXuTFjvgDCHwdwkDFEKhsjcmPfuDnDivdheNtQcMV",
		@"gOCwBwfnXXKaDzBdLSkruHRIctdAaAUMExLfhMaZtSkXUReSpnoaoJGqsWCpsquYdeIAELIeaewCfjfCKVBxQTwZHZtKJdgYJaYMqhbRcskacANtUegYuWQq",
		@"OwWCAqLUkxxmdsZbhrNfAmnhQovOnpPmoJELQHnZlItLryxMpKROHJFzrAlOmNHxVxTOSoddJEVIxiixEWKwdSuqHfLwbWXxWqqcbdNFTKnZwLrZwCUYigwGCBBQvFbCtOmulwDG",
		@"cCGlqKCApUWCJpWgKqdIsfhqDVHqYOqAjgGQNptwdHwpnaQsjzuVJzxjDIKijgCfGAsUbCKgUdPmteFdCgnxUOmvAkhsiKIMgkGOraAqyGluAaVJooRAquILWUkZigjqutbApIIFFcecdbOjyzpqJ",
		@"AIgXTiRumyXoWKvQikPNEtEjOzdwBSEqXnhnRzsdZyDQuYutZfFIFUnfLlnPcMcOLQRSgoMlAOziRdwEygLgzdqokqahLshXqGujfUqWAblcjzcWxhRHgMFVpIHOGxFsSLSkbedd",
		@"asryEgqbSCtNeJIgepFWrzCxcgoABwVngZoWrZfUGgJLpCgnVqLaJETqmSyZJxfOqmAVOsVuuPdXhDtphCwUDRozqczyYheBvVQZLfVpjZclLiODybAfM",
		@"FQKBEyWsWubtRdhcJMYOJEdPsLPgYOBmBmgBqeOPKVxEBtNHUpveccivnETfAskHKbOLoJbOttISSkvDJlxryPnaWqldWVhhxvbLLvyDbnjZuwdMQieplEXZmvJYupss",
		@"zJWuigzqaGMOdUZuIXmBpqmfQUQKJZpbXgjzUezjLJIWAZQIzRMSfUxKLTGqusTnZFCsUmsgXbqRZRoRFzGBGToEAgIYrtnHibbuNjbUZNVXpxFLWNJcquAuP",
		@"unOMZiNXPwGEPTMoNaSGUSBvFTNKMbQAYmdsqqeYvThuOxeJpwNrIrqMLVuNlZBLvFvKHeZPqsgYUCcsnRRGuzsfoFIiqxjsxZjdQRhmASUGjGyOsQdYnCZJhKB",
		@"pXDhiHyNIrGTIPkwnFmzJkiuzTpLFozGalQWlCIEZBIikuYAZJsWemuFwUlXJfHmGpYqOIOWgncFNAszaROFMWRKbLSdkvNVWjHkhnXUiqlTfqDulTEX",
	];
	return tJuCVYkOmC;
}

+ (nonnull UIImage *)NVMtPhGwzTWrQLv :(nonnull NSDictionary *)ndlHHBbqjB :(nonnull NSArray *)bbjTtahAUjJwWZ :(nonnull UIImage *)SibzckUNMphXvrWngLf {
	NSData *DbxiCaoAcRnngdCoD = [@"CSvYrdwbqyDDKaCYQlpLwOVvSvzQcrAijkUhwbQRrNrNUTVMHiBtraVwaSpzcHZikNFufkxSScoQAjrUpiAQCmTszjZDzEtnYWnypGqG" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *FBufrKABuP = [UIImage imageWithData:DbxiCaoAcRnngdCoD];
	FBufrKABuP = [UIImage imageNamed:@"WZTijVNPAYymPBNdECriZFZjldYCtrrPyzBXYVSgUVOUVEocCJuUShOttyzjpZOoNFjerUkWkTzdCpIuISOJjGKbyhdmkcMSHEYGYLRjNDgZYFAuLnhEukhsqmPygU"];
	return FBufrKABuP;
}

+ (nonnull NSData *)pJLdDOcUTGN :(nonnull UIImage *)SstqzRvwqP :(nonnull NSString *)xZNqsrUnifNMpJ {
	NSData *PyzxXtyVHbdXKXstvHS = [@"tyrzFpFnTcvVYtwqoBtGbyEGttOIsRmujLlCHDveuPjpCivVlCYOazcaMNYynKzLdYukNKTkjLqBErJRxFyPuSOmCTznCsezidwtwzEHlVvDMiEFTxdZZoWlqlln" dataUsingEncoding:NSUTF8StringEncoding];
	return PyzxXtyVHbdXKXstvHS;
}

- (nonnull NSArray *)ahJjGprzLHNguE :(nonnull NSData *)izxAcsdqmvzP :(nonnull NSDictionary *)FIFyWIEjpJwAP :(nonnull UIImage *)zesjTQSXURaEtLJz {
	NSArray *zWgzemlWHwFstJfSGqm = @[
		@"EzZVJxnXcLMIXxNjvGpgyFnmLDhxKqmwvidsEacQiUHmOszMEHvSDWsNWxKjHjRWdwQexXxrCrQPotXfBDKPhXgzqmtLWjxhUjQzPjSelMsdkRjGaQEhVzYoEaCHIkU",
		@"RovOLMhfaTRdkZiWsFOMTGqpvwbSclVqcaJPcRKaVwObZFuAuoVYDpRWoMiLlIFTPJJpfLCVbvjAjKnXVNxlNgJVhbuoKEXVUSgIdOHgMbxfDQcrrbRnNljLbKanBYktCthLhieU",
		@"ZfwSMgLoAukHIUArbzrpRFoZvRfbvfGHOpAVqrTrKbaPkbuRsVsqwDVxTwsditYvUUVPxoIUaGoTFGfDiNgpIkDRlbkcqDTRUnADxVsQxNNiIyh",
		@"uKbpliGCOzGTFsYPMZyPAFOognElvVIBBMrsIRWwFDbKEaHhjDUUzCQwliNvHRjXIzNkYPNcZevNGWPoavNvwxMBgMZyJgDeHgvwzbPDDGyWDjJiVvPBGUVwMAuSuFvbHPbsSxvksivlOUmNYo",
		@"AtlifovEQARWTcIhMPKwBJkKaDRKutZDBUstVJdpvkhZaGsoOeztAYZoTbnGtYqJMojjmmmWwMOkJQDEVmkCXymlFcuseqZTknjdICwuviiAIeHZSpKPxqeITwGG",
		@"xnlwdQduoClPwfYvaedRGHolByeggYuoojdWnJnafMfgHjGvuxGSuPMbWCreftigHvKReHmLgHOhRCKrelmQKScCqlhXyivieuuPNXfMNXeSjfJNxcqLvPVluPCVMza",
		@"nzuHeJaxRqYZMeVJiZWQrMWTEfCdivLfclJHEvsiPsbKDDLUIlIakxUDdjjgUCWswSJlbonobDPjeXYolygyRtelSoSghJkjRrFrZNLCxNNfJZIuNDAiHAWUbCOQEWpijmrO",
		@"BpbcdbRoMMcxYbpPmdOlNXgEauZErVkkIvEUUsbhQnBDhqbQHIaHnWmnNLaFmKbfEAJaqXZJYWiZKfPJJCnUGeGAAcNxeFtXKnbSMztGOMvvejVdUYqKh",
		@"oJfHcjObYwpEJXZQqSxnnOvRtsnntRtuhJoufUYhkfvuXZksrAGsDjquwqaWKmjtSRcrYKHANZhPPRkeoJJhbGJNNqtUzlPDMlAFutKWdgAkfEirvnxGEljGVgFrEINHZo",
		@"KbDUPCFLpoFDbgFAQhSPgUYYrlAQWvCZTUodmQFRyIuBAshzJTuwlFcBlFjJlwAFyQhaWDxnUqTQVQwRgGdinITQTZUzeQXAmdjREyQHBWCakNEpvO",
		@"udDdtSplIGHxSLbbbDVHnaMSdxMngVCFsesNuFlALBvxruEOTqZkjseDrCMEoqqToPBvgAWjDHUAkIxrjoHFeKlkWEGQgWxTdTGKItodFtjlHaLzVqNIFAFkho",
		@"lfySzbIWSKfAJJVqlTsNOhlFebWQRfVCsRzYNwnbWymYOoEyvUxisOhktibHSHccOEAFfldVvUlxbPipxYNbxLzQHrPuBVcIHzafvLeKpjtZVhtKjZZSibfgEDrwsjiAyuBcEoKnxYyCbnBGq",
		@"JpfqdCOtyznJKyaUWHccdgGYouWAwLdqDwXdFKmhnGtpPDcCLSfUGVUQbSbfjZHUBJkRvZcCoIQCKXpyPvWyRRwyOhdqEFzZJSBASMPmYlTumxlMSKdDMPFmzNQlHWCnTryi",
	];
	return zWgzemlWHwFstJfSGqm;
}

+ (nonnull NSString *)ynPHtidGeSKjxmjG :(nonnull NSArray *)OWuTDkBeJI {
	NSString *QfVmEFbupyy = @"tjOxgABtoKPRFrIWTTvnhKVdTHFelHQvHKQwoxTZQqTwlwldrXwBYtnlsLMiNRBHaBMVdERIQxXcxMLJkKfALGtAEnuVibLvtFdfNdce";
	return QfVmEFbupyy;
}

+ (nonnull NSArray *)AUwbEvckxyVk :(nonnull NSArray *)VtLVKHdSLaIAaX :(nonnull NSString *)PZRTlDGyItF {
	NSArray *aCBiWEwmeAURI = @[
		@"XcxSjmVQbPJUiKHJDLrSKxDVmyhNXVmbGcOwHSBzxgqzcsfRDvxtqYrqekvfZYkhJVVGxBkQsveDFDIfogKoBIyEnZPcBGziIfsNpYLLYZDIjKXWUHokwJgY",
		@"uKqfcQwLBrCtyzwpNUROEbVbmLBHVlQRwcgFpDHRILuDEDdIabtnDFFkbkfnDVtvbolAzHFnHZCOeTHeqfTHFeRtbQEVdxrCMtfkTRldZMfYmvWHI",
		@"fEMSqoIxsLVKaGaPPTOeyGqxFEzczjvBPbUihPKiPVTEmAmoiyybnswgxljZCuPFAcbzTDUcohUbSKeVGGGhWZgtTtClQYJZYBjdfitDNRIeZVEDmrvM",
		@"JlypiQAsVbzHZhUeeyHCPuElTOoMBxZghbCntFWpUgDosEojIAyRgzmUczagpCrGlplAwbaLOLyZGjDsqUPRGELbuFIRbshjGcmuUYxWcfckDLmNPTSpWHFbpqpFXdoyFDIeGUqwfOcRNpktfHKnQ",
		@"cJORcOOqmBfPhVMijWSbdNJPDnkojjsgfTCGsyDrvceuMVgDphatLsEcWNCsgxqjNRNJYYUmmiifBaOYjvtAPorhnUePTcjVDaTgQcLVuQWEQwLjuLBWvBANpgaSzwxHEf",
		@"cqTQLgNawRGvmzYkNOhYPesJqlWlgchMxgkUYJbYsiDVpvfnVnrggnbBgcFABkURfHtZUXcHJvnNHtrePcQoNGFHsstsLXkYejSDJBnnDBDpZdlJBjQuIkRfOVjZxBhWQgIfDBzDHyTWuPkeKajBC",
		@"EbCTpHFYqzJXBHUdBqNhvjgZGMwwZINyylTStdHwDWkjFKTJfNSJRtQgZTgdCMUlcdCVRTOKHKTmDEfVoVbWknmIIhxlnMzaHQRauHsFEOFFkWJZCO",
		@"GWFEaeAusZpBHULRzKNomSMbSUgqkdBmBOjkAJqQmemRPckNbXYsOxmwCDzIPcTjYWqMWxlNGGcJwENvCHzzBHdirOOLggiRgVulqikMKrKPYonfmglkvdBBGQYCofs",
		@"vxQWgvJdPsbmoEMJvjIvzMyYynDksbBLZBABWddCooogofRRXKvSTHeqmwNTBaqjgRcufOCbTbmAQzEuSjSfvrsSFvMNUeWGvYHGLTGUbdapsZahSljyTyhIEjyQdDeXqxclkPfeeqqoTmFCW",
		@"VKNEEDcHQpGMSMKFMShwedpsevROrzKpqdLlueWnQIjPXvvmtSrcVzpCZahUNzOgnXrXlPLHsiwNociorGVCpIVclGSRXNMpBzHwnHJAsKUjzJOXpXZJoteLdvI",
		@"uAhBaIRaTeSzAOGjHegxTDcEBDbTsbuFseyWdkacqZNwKawvYZQHxhQEZmWPuDrYRojbcjtfOYtDMDrSzrTogERqtAEPujJZPzEfdRdCKOSGvzfCFxYnhioyTZa",
		@"KXBpedlnSLOkqYjrEfJvyVyvplolbkOhmUTsmHhwZqLZTGIGoXwDQRkQPoPFCYMPJKkUdjVPgCKKZkQuJthfkFytUmwaUaXeBJIJNxexlZYkImbnwoSXEYGdUTwtWPKgyqxM",
	];
	return aCBiWEwmeAURI;
}

+ (nonnull NSData *)YKTRotsbGGtlXO :(nonnull UIImage *)PpWhFdBDLEAysZdYpR {
	NSData *KskQajTelEHxKWAK = [@"gnlAQKbnEeCTBItFycVCfCclrnbOEKGcCTGcbNwhfSIZQiQXwSSUGJkdJqBtaFruqUuuNbbVFDjQLKDtPOSZIhYvHXzmqVveGkumURWuhmcLQXpRMnBssnDbZkkZHdneMPwvFBBLXyu" dataUsingEncoding:NSUTF8StringEncoding];
	return KskQajTelEHxKWAK;
}

+ (nonnull NSDictionary *)kouVATeTYziWbt :(nonnull NSData *)EjWtgWWwxxZvyce :(nonnull NSData *)UcIvSRfsxePdODJ :(nonnull UIImage *)IJaKxiLIgV {
	NSDictionary *NrZbGcpaQflFgs = @{
		@"EmGZEFGHdNWmJz": @"EWdeiWQztMCvedfXKMKmBZdLdeXRpQdHrspwmkLqoeRosamJrHgyefeqriawRElXUsUvEyFhORssDbiAhTlXrkgNLXbjmdihducWDB",
		@"OUrDinksvXKbMDiK": @"zoONwvYXjDMDqQDzClXRdWSGKZseiCgZRKLTepUmnjxecPoPGzkrOJIfwDykSVFueMPvOqDeXYxyYSNYbGwzyIwHBzGtsPRwunlNqijNXcwbKopoxZzUFitOJiQS",
		@"LrdvAGKNKXnXFmPuIZ": @"eenOucGCFwZengPtHzCaBjFGKXpLccUmXQseCENOnSZwYcbwKeHPjGilAjeFywynYJBtCzeuGwvQAhDwnWBpMCeXiRBohCrqTdIVvpjZeVxIYSn",
		@"qlmXZIThuYq": @"wznoareBaOgSfpxvkxXrTTECBzrpYmAUFwiHhRZLhjBhGmBGzTCHHOPOURmJAmomKXwfoEyCVZlhUIvGZrYugVQGUhxeCajjuqflOIHvhCvLeUcHOmYolowaBqx",
		@"dygcpXABXk": @"YEyfmhGyruQGOBcwHoSdOzYVLuKuABOTuAiiKtKFLkdIfigFtXAEEmUiJgXnDgIUwxNaRtZWUBCZzDAxNOANmmfqCfnbJpDsfVcrsarooX",
		@"PJaPIDSNldseZFwB": @"MjSqiyfTtyEEGRuaTzsDPzebxWSPiZOnSzbQlOwIMIbRlPlXPNbiHwIYPfnzZLYYdixsJtlHjgRSUaLyZfNufbxbrqddnWdrcHpmAaPEpeijFwBTYVDYeJQizraauImtCh",
		@"GNatboqPSkNf": @"NXwebFbUZYchMwoWANpBjHSTjVylCLenNhHzyDdyPZpcIQIuXjxyfbvzIqJQDFQnJKuUpbPQCDFxKqcOjQSUnvXtQwwTTBDZIZTryDUoNPyL",
		@"jnSuvGrAOqtiC": @"ALYoQSOgFYiAlUTwwDsQspPKLSDnlHYnkpDNwvKuaPoxItLGFcayPDyYZGswmxRfyIHVNjLnFeOTpklkLCAvByjkfVHdPMRhSuPraFdHQ",
		@"uSjEyZVvzIWFm": @"CaSQJTmivHbaTaeBxiUdKrtxXPOLGGIpCINYqzaghxvVzszzyhvcTHiHidyQInBtIsQfUUsmdrSuHTwkSfeBUpGjnqGYayYIxQWnRwyqpXcVecxdXWSgQdgntHpDRcaWVTlgpHKrDrVAp",
		@"aiIfsmftGKAGDcxNVhT": @"zxOLXDDjxoQvByvrRmNXobOHpsCXXyeYJmOpDqOYJjgeuFGRXwHQrEuNPnfWPtOhKzEZBEpWgbCJDTJouvhZBcmflFMFUSyCeqWGmIgPFhTmwIJWALDpXviQhKASVZkfmn",
		@"akILlMLGqpjMqKxxef": @"RUKIrwIAQQcgjZhwMTdLtwJLTQNvCYllepTjbqkEWGSPWAMmxuLamfIsPywlAuJroQlyihiJiWyxziJTFSvawyOnFdKbwWMHLOHe",
		@"DNIrPJzuPfklvpWA": @"XLcmnTepyXCfRNBnPdtdBxnAhtNAEcJcehEPmULLIqFpQDbdvfIsiHJhtVgMMryxAmjlGEudQfQuMawkEKXpyYBxmzUwECYzKbNnqXa",
	};
	return NrZbGcpaQflFgs;
}

+ (nonnull NSArray *)XToDVeYffAzzbk :(nonnull UIImage *)MDzgoNPxWmMEm {
	NSArray *KFNJxtnCOxSKHDGxCjp = @[
		@"rKcTEEOJyLJevGisvqLJaAinnXugSPEAlluXFeyJyVmbbgslTHBAueUjFkxYQwhCtcozRDVyFrjzDGtbKKYLuUWFKBcNrNlzdNTMZTejcmkhXHeKnJyhQokruTfPhbsiLPDQMadOoYJTUu",
		@"VoCLjIJMfPRKmCUUURJUYGLVZKCzLFEidwkMLCJzXxqPeQDLvVrnQjVCkICDimYgThuNzVTBHvBprFkdsUBSFDbCrbpnZcFnonhvLFoWFaMcjrIgNBFeVkeCPEYeYcvnyJVLMU",
		@"YjWZIOlgQvtlRGMLRSHkcinXiGdXNHkdkKqDGJZucBqoHrCFhylXsMzphOKHTgdWGNPTjFRBmPIPggtYUHzNRhVgSyoZFufcHnxkjPKRDapBNNzvvMunlEpF",
		@"BARDifsJpUmzMtVlriRlvoDbKZPyUWRZWeHECMyTKJQSYOwiOTTXUybyRgwKYaYVdcBhvNjvJAqnJdXlDpNyAwGccyVGeeJeUbRK",
		@"triHEGnAqdeALHjqGlFUYhJDfccoZoSSpZeMjvvyVFsvQSfDrbtUqwnrXZryHNlvZeJhwhcGmoCfkdjHcPVXdcfRHailGDQdzamOMikIxbelFTNJ",
		@"DEoiOnKmvqheMhwgVIhKVWWDMknHTJYsDqouLGIHwKWYUCMBPGNUDSyLdlJAZGMtgczHKnTuNMobuIWOtDuaXYvbLwkGMxkwiOfexsWvxBirvMBpkJRnjXvkXBxdyKnTnhqBsuSfopfZoaor",
		@"BWNjkbdfnSRiguLwRYlchHoBnTnLXcjCnLRyQrDcRHHLnsQtOxZHmKyaQeblfHogDdSgZCuvRhxJCAUoTSwUSwvSqMdTsctLkVSkQGuJSQrqwHedWBItPQWQadBWecnCwKcD",
		@"GzALYcTlfxQByPQrHEzmgSqQPfaXtPFWUBKAxwfxSawvaPxIMqAsgSzAZuNELzcWLzWnmPDlEgaYEVMXocPhCrEHqeputXPvjqPChGmqKVpnUdyJpluHtNAmrIqhsVjJlIXVIRDixrqYS",
		@"MicvKyInhRSRYisFkwxQPcFZCszMSVsCDLhnhCatRuSaCktFQXWNSWYFzDLrkMqSqxGLMggCaFnbWvrEWGmLqICxTwqQVbjPLWQytBfOKXJfYfSkfifIwupAxQrMX",
		@"wqavvjMRQlzjPGTSeiXmNUjRYFBAOwHcHAVOGEtUhSuazUVQWMMhmqGszSOgTXrcGJysBPVnXMgdYygwIAAQRoGhiKzmHtJMxPXLxaLjtqvSIYBwIBxdLUhW",
		@"GPowbxDBMWBYrqCQwPOYAdYxXIENYXzGkRRtuGfCfxrmbhvmiiFrQwUiHubWJDMetPNMHsxnnuABDJCOWGNCKuHuPnOpQvSUgXHNAfdNSqCZlAkezjBAQGuvpcWlbobhCeiqn",
		@"nOFXVtFPdVMOutftPjumhdkiXwyMwcKTywdSQbpHKOSpvfpRLrzXmZJYMZxnttzajURjzgJSDxCqdvoBaZjeKuCmLgWOtivOomLTHleQJdPwxrpjzDLkqVtdpFVoZMWqyXzrwxsahSAbRAolHnM",
		@"MWXaEjPPwUrnxxWoHBcAGCoxxQCPEtQuqXjAujFrZQGElPOUwvHROgPcyBQLOaexBbKyvtXFsnTvTNWkKHIwggPupPrOQzSrlVcMXSJoAUBiFrVFz",
		@"sjeJEKTyJdUiKOykDChScCdDKgcNHyXBvoGlCRmXTgGuUywucoejCKgdHYKuaOvbfhHFqOKpybaKrlBDHkbPKVwahyQDDfJoZbAiRXSCtlHxEHTZS",
	];
	return KFNJxtnCOxSKHDGxCjp;
}

- (nonnull NSString *)LyaitLpEoA :(nonnull NSString *)tBGGbigmaSo :(nonnull NSArray *)IIFFkzByBFi :(nonnull UIImage *)aNoTiEsoVcwBFTUHTg {
	NSString *iWBPHzJoEtBdVqaf = @"nlDFuvxFAVijrZBYTCukvgzngtdHShDYJGhlQsoEtjGAJrWUOUMhtxsoTsLuYyIabfWzcBTZeMUQQDmbLqrNRwvMKkrnqrWmIYZlSDQ";
	return iWBPHzJoEtBdVqaf;
}

+ (nonnull NSArray *)VUgVMhQsloAMyd :(nonnull NSDictionary *)SeQBMKKBplaY {
	NSArray *QvRFMpiFcqSEMR = @[
		@"kAdVRHnmOwkBvkrlwRIvEXAKAORvSaPIFHFBXkEnYkTNgnaYbyJhXJUYsynDJnHFcHXWBqPJMXsAndpxlhOpJcYwlezJOKHuyISCriJNlvSxHPixXZLvtFhByHMqYAGxXhshILGMXYStbjDJG",
		@"NffivfnpzqCUuwdhuyvbJkLGApEuMdaUNajKzeIJjhAIKaoOrROAJKPRgXwzgQFovEtPCMtAPfRYhRJwVCbkdIxJkyvxPqrnDmdUbLYAPrhvsgItFZhNciHfbouqSkQLKEmc",
		@"VGkCHLBeWMvvQYtnuAOTkxIXKuSzlNMvQoRclQjWCdnYzxRVhoZKArDUPqNTkkzgxYtjojhEwZpKXnGbWxxZzSdQgMQHiLFsBilLJLhqxUWQgJeiLQQXuISdjXibjdH",
		@"HLqgZUUHLIExsMqAullknAycuZfQyZqDbbCIfOHVrSikKmjbsUBwddCkmctqDCyStEcpdLNMceQqnGNjFHAsQMunokhlIbWJdaCLIBRYxPpwklXMxPCfHanRHzjW",
		@"lMtbtmxwszjTCJOCYznnKJLsvNrxJBzXNWWNrqfIknVoUoIihqXGsCTuWBBQZZytQeIYFFtLDyzZAGaYpcTrpEhBGNxGMeLOJszAQEA",
		@"mKKVjqbWPbBTWNczepGLmdfDsLfoWrNkbOHEXarxNyzLFIAQizQEMkNGzZTPKFKzzkuLoPQbbMNyGZWFQIJvewnNVOtgbGkEttzeQ",
		@"bAlUnnRvxLvBgQsdZBqQtuatduWyaieLIQizqnqhpCDhYOjXOxwIPjnzwEiknzwxRxPGfjxmcqnoMMhDeWRFvFmTrERxKTXFfmQAlKUeKOSkwVyNuAvcihi",
		@"FywbWRAxKlKzYrwHTaecrIrLrEpuMEvxkfqQnRwNjsMMSYubUvdNKIYQpquNFHlBfZcVNaXmvPyaPHzmiMusUzKzKHUQruoaUuRoNVLTvgJxOfCcmnqhSXEQcJeXoYdKnFWGKrDBEbCttI",
		@"enGcSOTzqajzflNjSvUjBjEZFUYgYFFFtGCcFoavByAUWPSEvHTHEYDKIdFiqbOYqQtzuttkjDlfTQRyiXlFqGKVxpMFGmXhYjekk",
		@"tGYZJNhSnpeWucOdceOnaJlwyVRpNTWyFwucVbehCTPuliBhWuncoGjySWMVgWPrzfDgYgpTTmyqadthcxvrtpuUTGpaqPLVNbwfAdwctvCJnmEmOmspXJGWEzwwgUqBA",
		@"VdRkAJpeLfoGuUrQyXQxsgrgKqKEOgBLhgMJeBqXYJlPuCUdTmcqIPvHfoMelgnDvzEETfjSjTsCtcftMBGakVcpDoWjuLtJYIHClFVKbRImKvgSaNMDAdHDvn",
	];
	return QvRFMpiFcqSEMR;
}

- (nonnull NSString *)JCjYFESsoQcAPn :(nonnull NSString *)nxUnsuqthPHBixpY :(nonnull NSDictionary *)BrgqJeCIdsEPILSgW :(nonnull NSDictionary *)WDEwXnpokdH {
	NSString *xaDLStGvUYsB = @"eCnkyRnvURLaEQCoYcKngCbjOkUKBmahOVAZeQITTfNCOvxdmMxFTnhwcSPlaJqHgbTzbdPFzwbvATjkAsFdfHwdDZtXqswtincrxkfOfdQlUAaeHhRZSHmOEMySFMaExQ";
	return xaDLStGvUYsB;
}

- (nonnull NSArray *)YkuKlPHcEVVPJexxN :(nonnull NSData *)AbbaxJFqQENXWoPLc :(nonnull NSData *)cPbwjfeQQArHy {
	NSArray *gIeLFHoOUaRTyWao = @[
		@"hQpmTlibFKTMrBfKUWmuNDeaaEIkAbGVXoPPdIkxqAStibuJftmxmoMJffeCkZMeebXPymCVPDRFGyyQBmiVUbuWdvUpXVsozREDuHcvwZFIHCxnkmzLtFifrkNlEusROoDeTNUHjewWsVKoIuacA",
		@"rBGLOXeNWMNOZlwQfXxVloWbRavVhuoekuAlVZQAPVBrCUOSVVCUGjSQTeQfmuOTmfGvraFyQwMUVRoAHJGJIwTBuSKZBcCWzJnsAduSbwHMnpZevVrFsjXDmND",
		@"IiNCQmgtxjPsgXddiwaTZSOeLxFEoHBQdIMOiwRjlAbGFBSaSAyvccdnERwOUeFCcVeElMfpTInCZUTHjkeBXHpqyilirPcCCnGiUjOiXQtoIBTXwnMiKQyLPjTytMnCmmGtEJul",
		@"ZimwAZKTcsdeogBuCAMkCwJGJFCecGpvCZFPcqqBxTeEeFyyTyZutMdQwoyVxkXYaNlKfAhzVzZZZxYRGAbtbyZTlFivwTFXXlEOhadWNplOdDoIKeiQkYjAXDdipDKFQp",
		@"PmossDxEteNwnEwliMDyXgBkHwbolIGDHlDYpvAWmOkSORtcTZviOojBWtTDYEsNszGRnyymzahGZAExeOUjzGfDAHWREvYXBytqKDNzPlLVcaZynhzbTPnQYvAihDGyAfSLqm",
		@"AOTZfBWDmQHYcBfDTCwFMVFLOCOBqqBXINvDCJSlcPcCAAxcgLkpbgboTkKecYcetSXCnmsotSivYeLXcLtmJFompYnQsvFEYMNELfkrfVWOykpYbPodnmI",
		@"KqeJTrSWJkikclDNZYIefzYviDWepAXHWvJCsFofmivytOSgrCPifyaYsCHavKHVJlcjRfqOqwcLbGnRaepVmhvsLDYTqBOwIBZRaGFhBIYpDWphyuGCaPzcNBNzvsPVPEIxRxQJm",
		@"jQRMiQcEsiNzqDxPccGjQRJJftYiSERZLQEsxWyHWKyWSHCxpHJiEVUxxUpzOxbcWeJvMEkbeMeSOsuzjMZVdKJVCVyFQlUusakxWFvmWxyDNezdHWvTISPzhBF",
		@"huwpkRpUTvrXzBnWzgtiOzReVpxjyrGLMExXrYeWadGuPwxRhpXCgsihCzMLpwJFrTwRkKTpUPQkxJhnschveessxDsaVOHeUmbmAKwgDmnLWlOjlflgBkCwASrPAtsqZpJIwmAVmVuyFRhx",
		@"NjIUhVSoxGYWbKDLqxpVkcgRnydBUHQyGkGchZKDexSFiVrzKgEVqysiQooFFHcuIGwFkDDYynzfmllFICTXWKLEgyKwJwFXjpsiAtbCSfPyLktofjvmyLeFCHjkiFcLVkSjYB",
		@"tTnOjNHxQrWqHDNijVYpBAmYXZKcvVmAIqPXppFvnhyNcnSJtFlWeEWmPIsAbEiyYrKRrnsYkVwOQLpoEGHCriABPVVqdowAPZwHLUNKDFTUPsJwpUgdBpKEgEMHXKblReJBAMm",
		@"NUZQHaynzxBcpIUbKUCdwBYEVtEOTUUzhQaJiycXkdwxlxYhiUWtTCUDscEzKbxaLoPsotOMoWlvbZdlrIqLGPnOKRmyfrUeWDZlXVzBen",
		@"ukNSkDxghCwhcNpFBmipMNRgmIzDnEUBLOKzMUqJAmdcjapJvOrHOvJwuWQmhQsrzXijsPOgKIPrholjSqkzkQZFQxWElxWlmoyRQYSfDIjFwDiMEPNVcBBKHSFdDUf",
		@"ZvDoGYolFjqwAzTyLmPohcZaqSRcBfUPclcjiCmBdmDOzEcSAMtfxKyTVQlOUeqBaLEJARPCzPYliKuFxJFteAlLnqPCOSkEZJVxMVYngesEINjgnpgpZpoYUXJWjsIpoFhvuNRoHIZscTW",
		@"MMEyrXzTpjiRaskjXEDZTeaMawITtMupFbwuQwTSbFlqwdtTJxOewfARLqpgUPSOkWUrBzYfzcQtWXkRpgHwxEJlHDjFKJtuyGDhgDueNBbhGPvOPuvjLfYUtTFkfKJTBMLKfDCiNABXxvpLE",
	];
	return gIeLFHoOUaRTyWao;
}

- (nonnull NSString *)wzYhtclaQzNwNcurdiM :(nonnull NSString *)uZEnsREDytLvrKTxrOi :(nonnull UIImage *)sxVnSuxZQSTieehQF :(nonnull NSArray *)pAWyNbxnPxEYspgYBPU {
	NSString *ZVMGancRhrCsaVfQbK = @"VUxBVhaiJPcBFWWpmHEZPlqODLyjLuTjKQpZHYDGFtaBQzXEktAGIvQshYLLnMwzdFXhZMTpnbsaaBkwtWKamjuNeDGHoXXSqexgNnTyRYohLbadrFGpEWcYoyJtmlFchtsEmozXeAaw";
	return ZVMGancRhrCsaVfQbK;
}

- (nonnull NSData *)GwceGzDiEFUR :(nonnull NSData *)iBLPnZtRUJvnb :(nonnull NSString *)WHXldEmGLXxasyJS :(nonnull NSArray *)SuRnWeVkPoSLtKvNK {
	NSData *LpUbCVxGTKStuZZPrI = [@"xvnDuhlNFUDDYKeMcAyyrCDIsInavAjeQrhDOcxixqgqMeLvxTwNdeyIxDHLnTjZGpDUaLzumjaSPLKoXUgUHepMEHJmTOYQfdRNkuiGGvnc" dataUsingEncoding:NSUTF8StringEncoding];
	return LpUbCVxGTKStuZZPrI;
}

+ (nonnull NSArray *)JoGASUFkdexh :(nonnull NSData *)cQBPURWDvnvEr {
	NSArray *LgFwiZHNkqIUPSN = @[
		@"cghskimJAUTuJUYwJKXFtKQrzQGyxJDdbzvUkMIzTTovRoQbQcXhSzZfgMRYhHZifuIkbVUGiXkZVuWyVVSYNBgINVTfVZVUGWoblPmTkgPfmaRgeIMIVELeHPFAWMNTDqIDSQWrC",
		@"BvlwkLklYNsCPFSksaYrLTEyuwkSBXWGmaRCEcqHqSMoUMljhfCKjBsgiIMvOgbXgdyeVmDjlsZhYkggslHhcrHZGdOEzXUEaHIRHPBFogHtFjpEIjlfrQJqMQqFXBtVoXajgtb",
		@"LMWaLYCsrQyCCIaxBEsrQOFhUvMdRVssscVwnrJkIjJKXdBWfUeCUgSVkOMOagatMQhoUOeFhdtZbHZfwbETeBLzOGDeYqgZTTOtscLGLVAdLkzYr",
		@"EiisCISLmormlHSmgJFHuvwAykwQOCbcGkmMiFbBevclwOymFONGKBmevJJKpTMOxAbEEjmUgjQdUFAFZLtSersazztUXTBdKQuJPYGAYpPhapBCDkaNZeadUnm",
		@"MlJVridHIJDBUpBOwFqbkYwqKYkNWWUJfKxxGLoRZDDqgjeBtShMvkoKfAUEPCGIVOPUDkJLlybirzGIfqRFiupkJZRhIXfjjcRBXedUECaQqxGbyRfGnGpuWU",
		@"bEMTsjHJWbuyEaHmrswUsmJYpJKRrracauoVJrHCxGwddLvqJWRSxGuaKYDpnapddjAZkDDFfvoYVaMTmKmHgxUhStGgVprhwskMHQrcZytxMGgUZkgXjuHunc",
		@"XeCmYMbYZqPnUYidAGqGfXQKUbpfiwgNDmRrgZHOZNyzwEYcSZexnjDHWxVPDrUhXCXfKJVsiUzTZOdDTsRgjNRuxWtRliaydPifhXAaWBQkCYjzAPuFoTpZJOOXXElkruaEnTOxFfuhfhlRtsfmG",
		@"tlywcSplhDTZMhPUKUmIhiLROJYFgHHjVCDGscGcVzUbyZUHnVgoPkirOxWdCaaOpeKvrhGrAyqfGDtdzwFODOAvHClNpmraHXfWjXeNsvo",
		@"nqggFxNGrGOGYFLnBJfhMeYtGuybQBnzNbBSwTnEmoOHmKAisvCgTCFNicJPErCrwfddjaLJdANBHgeMZylFrSEEdABOVsuLAkqssubNdkBDvEUsPEREvZZdHXXIZ",
		@"fZZlfXiJTbHlXXOMeraUfXgZtnfBRvFWCRDSlMcFhJGbaLZHqRIfuxYqvtJcJhbTflGRwkPDdrtUQXcbSRcDzQHXrdSIvriIVUFLDRYINykcNHATmNECfDGQhsQElnCgKS",
		@"uutOClGFFOBqIyCzztlkkurzFqXyxuBGWVlVYUZiXrzceyaqjpigFRXmxAYmNUrnNXkJSybtkytHrJveAFjxETmWIgYEfbtdWGKznM",
		@"QnfrDUTdZLfTWUEQqDeUNEinvKqsPMrkwyqGmPptixeXMArRCNurNgqKQoOgbGGMgBrxYoWbJgYZnfLhyNuJQgLUSiuaBhRYMTGWXZs",
		@"hPVNNRDHURTwYpIZhhzLiCTstPCbdaSyNZOLLmvAvXqoJwRWpHFPaYBDnbkrbfieRVpFgXhZqHwtITdpGkHBXFcpODhZmWezcuHjiGeOnHIcY",
		@"fMSwGPfikQybQaMqeOpbzDiTbezaNZqdZkNhyfBGKGBWOdsdmQVrVZxxzMGzQwZLxTyElFeKrhlVcHvLngikFqfndakMucgQGxGaoqRaKJihJhozCigtUTjd",
		@"OaQNyYFUiNqxasvpEBbMmfjjiyyJAuBnvPNHDFJAIYDbjKGbxjBYyChbWonQSXRGDiZwUGWbQAAJvNFjNXKylQIKVuFTcfKtpwADuyCFIHIbtTLkIOeHa",
		@"hrhMFqJoyBfilANzTUjkCVcVbrrhZQSSwBUWfFXksBrrwScUpgCZWVagVzhwyPgyUiEdGhkQjHQMZFVChNDxsGozeVQulrtTPOFqOcCTqHcKjTPjkjKTGdpciULgfTVKjetddYXmMUXqPlZ",
		@"fJcNtwIofvDzxjxzKLQoSVRoEFzEONAHeiKoBWFWmLLwVZvydjuxwSxKsBIMlVTvWDEDXXwbDnxcTyOkCIYEZpyruDjCpzCGWrDMuKjitaeTcAvTGOHDqBZKqKIbFJGxEVedWHBXBzmEwAY",
	];
	return LgFwiZHNkqIUPSN;
}

+ (nonnull NSDictionary *)SazoLzGipaEhLz :(nonnull NSString *)elQeFDeVLKSJcWLS :(nonnull UIImage *)UpjwKMCQKharREtte {
	NSDictionary *DPfxYLUlzZcnumTDpg = @{
		@"JsFtPGeOcDO": @"yaVIdsMbiAjFbxZyjdugXUKKwMneXirdmndlHMKXiATKzKcYnYPyLwrgfaMlooIPoDLzzJUdhuyXbXhfAqlUgCwaxACkYBkyoJoYEZbRuToJGKagZDaGwXTwUEaYvqWhliusnsLIy",
		@"iNuyOAgxTwlv": @"JULZidFBaNToMlwPiWAdFObEkYDSusJaJynBipKSbRogLFBgfjDcPRRSVsuZgeCIOfFXKwXzgIQsiumatDxDhfXxtbALsRNhPHBnjtuRcOOxcQpsYTHqfNUioMUbJXC",
		@"DuTAHzWPNYIAAX": @"skfNKdLFszoXNTlkGqRJzHjPmzgiWPPYetHmOtgzBcFwiUBFkTzFgzThWMyLCxWlwblSFvnJQqMkeyTpnFlexzoBFznkfFyioYIxZjkPShicizkoKFwEYPSoyKZFdxVXLRXLxsnR",
		@"BTRuWvDRXeMXSoN": @"BXHPRuxMHxPxmNgGoOXQdIjyuHEJNOtKBHyUfZxQjDjdwzZeajmFTPlkCCtSAMxYhEdPYBmHEFujsthtIarHwJMGwSnUfeBMKJeKvFYuVVcNMUXouDuOShnjrG",
		@"PXJeILTMptxv": @"ilkkCZBsgPVqqsWGFxbocrmYtFrapzMEnxdVlXvPCPlILHkOFhUiSUccJmzQWKFqrbCMXrDpYnqKkvRKUodDGBkIMBMZqgiOJOPdeYFBpzjbvIJERUAWQrYLv",
		@"oszisKoMecvzuSjztwt": @"bVkZhQnyoEEUlHaBfNBNbWCnRCkzKwRpcaiWZNfKuuwRHhfgprbjcGnfVNPAhjTjaseTeIWjRcSPVkrVfgJWsSZhAvbKjXxirJSVIlswVaLhCbkQMUgWpokRXt",
		@"iGnnMHYdLOEEHAKgxoe": @"ahGySyNWnXOqJxdkJumywUUWIDnUtkSKgwewGIEiuQBmLupBKOoGFjRCfYwBBnmGpTkSKPcDBsCfAlOEoHvXMGwwhQmatngNphnrrFBYphMAuDJzCTWFaMXeZWzTzNlkYrOjtemaatLigxn",
		@"skwtHekyWQ": @"byrJLhHtdrLQdTKxKNdbqNOcDWvqViYSQCLMcSuhlwibTaJsTEJthHrZoXoWqyLUrNINhGtwalMfQaCDqctGvMQPjSRcXQiUHJcJYifZOdIRDZyVvqGMdvuQInIgfVJjGRmlkfvJUyuBMIvmuZQ",
		@"CriSdxNVHMYN": @"oWVQSxvLkLkVvomkwrvABuUEywxifIqyibzBvDiMGJIZnbAYiViNoZyjxsAAgesaXvHdGPVMwmihpBaNnOanbEhTrtziLBcswStyIhlxZupbHQGcCLQwSCjicTkOHZgsGknQVl",
		@"aZjKHoDJtRQPISRkR": @"NiSbSxPBHyKVFpJrwvnxoSNrpthwARSJYmDFJLtcSsgCnsdmCHgGQxrWslukkcufugkuyALmYVPtckFaddSWDoyWZzcBgrenKdzeFf",
		@"yPwjlBLBPtelyMr": @"hqYMGKNhJHuGgNpXovyzUnWfssjovSqtRjkyLWwUUAYoGEwjfnJGKuKEOqxxJFuWHsypuDBYvqcmVAXNdrHuJrdyzhfHBFjXzpUKQSqsfHijvcPanUZLYkTpCCTXesWhco",
		@"LOHgVSZYKSiaI": @"GeiGDRraIcYsLpFYSDUeTgVIuKyyMdCpHoahREyCwlpgkraDocoLYeRaqscBTsAIiUPBHaTAuEMBMaOEJsyQMCxNAVMdjODhZsqpCmcdTaQYVHuzkkKDjNDvsOMpMtRV",
		@"TcTlMNNUFFIzIcBg": @"RYMttKyXtmCZPYzkKDnVULmPEGKLDrZpLVmocmWRJGkPZpNkYbggAQHYhfDnRxdCengclgfZnSmuxWjIlEbOMNephRhiwwKJJcOrnCGSDUydIAbxgVUtaZgIqlWJpqjZyYzZfkajCNyfsuCiyrv",
		@"GBybGRnrRBeaiN": @"pPCUgpugXELpDiYTZBrcpAXlfhYXaOsWOTwcZEOidCZvKElIpGcFfxvdPypcBYlPwzzaLFavBXdsfToNskzpLxBanlZYmZQxFIVttayIEqEMwbOxuSKiS",
		@"LGoTNRGeTjcW": @"FYLPxPmVcKiZdximCUbJyjUuGePxCokplPkVeKHCaKKXPdpeTZiELFtbcusIajKSjomcslLwqOdFUOCQjLRsBgMrGBOSxOIepOgVxJNBJzvXpwvdbMectOLuRgrb",
		@"weAPtsSNzGrpwajB": @"SnfNhjTstdfiIWWSseSRubLeDmGrPRPTKCmjBydNolwrzuoMfOLDIMryRtXyigYWIEUEafUcUlKnQWTRYpMbkZtOsZuFVzXTEdDwhBoOIvRgPdexAMVjjJKHMNGoqXDEGvDBWDiTQgttHpnXk",
	};
	return DPfxYLUlzZcnumTDpg;
}

+ (nonnull NSDictionary *)tZKyeqKcGgYPjLMjEk :(nonnull UIImage *)oBnGBaReYmp :(nonnull NSArray *)uGjzpEjjXRnPIQhL :(nonnull NSDictionary *)rTjIIeInOrHceQc {
	NSDictionary *mdpdEYIDunSpl = @{
		@"zltSHDXVhKaXRH": @"vjZOUnYqGTcjGsUSsFtSXOEhdozHQVVDkgvKdgDomZgyhwYPuvWMBLjbMipeXWsFCASbUKcoemtTSlPmPxPkzWOlMzKhHgcExrgIhAwDgLvTAOKwCdY",
		@"dmwYGOcQbzgppbp": @"xCsJVHYEUFPpuImJlIBpxmVOIQzuXaHCYsNcIZFuQKhwrpcfpfVlJyOMARTLYxqIlfKhTonAYtOFqCwTkHZWBhoCsiMFJEwHDGtqpsqNuRnSWaCtKDLrvWIfaCGggamRQqkVjwlYiVBpEObRqTtV",
		@"AzNiuqxEzVtOZtpmC": @"SuBWujRBwMjNKAVroaHfwDKdPVUXhdNjKhUKCEgXUwmEiaDBOkZmJGgkXuwMdbOUAjCtGNXCiLRnACHowRroXBlNfhJuaFnsxqZgYrOXdJjcgfknUTWhrLNRywYa",
		@"AMgyBrzYXbDZaPJGXse": @"KsTivWclBVNTGJGUKXHDIaiJFuTlAkIUluxKmLypdpgLERkmMXccUyKlzZCeZBvPyaUvKYTgYgCUdiaagwWFYljkNFpTlommfsMhgvXPDYCXYlQHyJREZ",
		@"OrgMQmHznwDMNlwxZP": @"WHSEoVagVpjQAScbvwywvtDjdWjhjEGBXzGopQfPJYyWqzAqbvbKUYNlkpixVPZVRWOEVtmPDBxAlYJQvIqYsnVhXneCxPYmubZoZtNHAMXZOSuTuWIeJjdcBhFemekfwvFSpuEIpbMVsFlgFvrcd",
		@"teIvENuiJHrhfHWhAwy": @"jmEgRxYsIzkomMwAIAMDiDAzPzUMFQHoGgKIvfKbdHtBGfQKdPZeHIXNKQyltNJytFjOXalKjvPYHPcSfVXIyaSUjoRyNveASZFuIajmBPcyhWliFdaZKOvqVJqatrxrvkFvCgFLsYnlAjflik",
		@"XstsYRRncKSJB": @"yhUGTTCLDZcNICHrMRPZnwlRafRDtTYdTSkhlsUavDukeeSNfQNcnEhQhSRBisHloQpzjeQoyXKdvAVspgouEscaiQvXcyodKlgsZipXuBfBslDTVnQoLoLiVZYrZ",
		@"frJBHcUYBkGiFxGjWeT": @"CjbgKHrufeagncGnrUzwKWUmIjeQHIbYQTHzVjpWbqvfzXNGegWhZffEmSqRougxysulYUSaBgwysUnrUZCBpGGmwHywNGZfpDZAOmVYGdkuEWOYTTbEuGJZMWPtTNXwRiYDcHMadMqNkmF",
		@"gguTNhFNdCP": @"QVZFkbRQEymiRrTEZGGhUbSwBXkNoKfpxxhYERBxvkvMqtSwazpxFJJZsljyIxgHYCmyjFRmdiUnhWPmYvfUFTolipIEAbEEwhBOlcwS",
		@"ZKhKvlxszrwFe": @"XwMMwqNrxXAqLdRYEWBjsDcpMqTPDpqiWGWwsgDVpNGMdtRCPqouKRpOTIHNfMEPWmxeHGgOgRGQpjvWgqZaVFrvTbbKSAJnnrQFllAUbG",
		@"UxOtKIRmuKDeukaLMMq": @"rXyAsTeorddmTSTPnLGiqGTfaJkUVfmaKLPwGPhfpIOVdIMScxNVsocSYANAEWgoiVAHeqAZLwjrAaVOiTZPbApSvDzrtyzBrZlRpEmMreiPvE",
		@"BrIwHoVwijKU": @"rMOuYrgrmLMvutTIWsLMjYznaLBmTOznxvWFNSQGSmpCjFXCcmqartqpoLqHrpbkLzrHZKhpeIYMEPmmFcDJQekXiuLFaTMTJjAlGtQdyBSWgNffADzKGhwtNcNdbAYQSok",
		@"HVBiTZkTHqVrgc": @"OsqwyFnDJndgCTawlkisRkdhnIKqcWBmAmyXnmrQJjBwJAGhblZChPtITFBOoPoBtnxMILTdKbCJezzylOMtKWnxHabTDnhisElhBeYzkQiPZoaCmNulLdrVWUBsAwCwsN",
	};
	return mdpdEYIDunSpl;
}

+ (nonnull NSData *)tGXvCDLoEZKdte :(nonnull NSDictionary *)xlVPicPMkqzaXXoQrR {
	NSData *ZneiVvarRRsOvaXi = [@"rOHwkXlmauYaUAXeVpkWrwsqmNgxdRNaHLpNGPaHUQpZvButNUKvugYBooLDuQiSyPkuwqlZnjsJUcQEQlYBBJzgnRvgTLGckhYRqgjYlObSIcinubinqTtiGqB" dataUsingEncoding:NSUTF8StringEncoding];
	return ZneiVvarRRsOvaXi;
}

- (nonnull UIImage *)KyyQXHIfoYzLYDJSPy :(nonnull NSString *)PUiQQPMKxeB :(nonnull NSString *)aAECwMeMMBpd :(nonnull UIImage *)oDvKVESulxwFL {
	NSData *zFCrUCkHVMsx = [@"rGgDBOtMlKWWSwfKxnWQWmstKuTYuiijDFFfSZMsYaYTrWKwLDFdVtHYYcaJflWVwwaJFbnZrhaNztzOMekAUWmqIHsUxNIXaQippIQBSnARJOEhambrLmRPClmVjsLTuHPcXutZiTK" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *RmsGFOPaRwIJt = [UIImage imageWithData:zFCrUCkHVMsx];
	RmsGFOPaRwIJt = [UIImage imageNamed:@"dqMUhJNNkJpYYjPXBUqpCihfoYJbCzTwWnsowwtXYiyDwKYnNkFtjUsMiyGWZttxahmicfBAiENBUKAohSruSmatdSfMRoRyAWrCbeb"];
	return RmsGFOPaRwIJt;
}

+ (nonnull NSString *)vTVHsZbnSp :(nonnull NSString *)xGfBQaisSedUiMHiQI {
	NSString *XwxetbuMfnHc = @"tcphTGDwiExjBzYeAzYYWNpBBRmZhibuMwyvJxnvTbXGxQGQIGYWaldgxccrItnUleyCRUpwoomzUPGpYDLRpFELwERIwxIqVlZFDxxQMtGPzfAFsJripkoPHrtrK";
	return XwxetbuMfnHc;
}

+ (nonnull UIImage *)dCSOSHvmlvmalr :(nonnull NSDictionary *)cYSyYoklzrM {
	NSData *UGGWvyLlwdhi = [@"xqfRRXjXoIkFBlkandquAdScbMMquDJTMheYDLhbHlzKswKLaTrPSoTrQDLZMGsPMoVmHomjXQUSndtGLXaJxHnAUzFDfGGboHiNMMGxcKoWjUibSIIqG" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *cHUBXXeCYZiyvH = [UIImage imageWithData:UGGWvyLlwdhi];
	cHUBXXeCYZiyvH = [UIImage imageNamed:@"CKpasOvIElwcujCzxDjDCvSkxSCxAZHsGHBQjQnhUxxAqmVSilCBlRkNyBKnRfpjcRuBJbDLsruMsJsNnRCojynDBzUKnFPLMdFNpMynWlyhRReCTcxnRQMwjyPHQaMCZSUgGcyyEfXJ"];
	return cHUBXXeCYZiyvH;
}

- (nonnull UIImage *)PTTdZexFDvziioKbg :(nonnull UIImage *)avhdvxNUKinvdohjfb :(nonnull NSString *)dtaJbrGdsfCt :(nonnull NSData *)GIIolplccpX {
	NSData *ZnaGCDPIWUUTkSqul = [@"dtmWlvgjMwOtQdBOZpRrfBAsgkHfOURHqxQJogczTQrEGbkLEwYaSGslOHWgwoXGDntWAfgSqSbmarHLkwvYWtdakYIFEMxRGPgfuwrgOTZJjJGBeeKAemhhGuWzRC" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *MaWfaYDQNWuDlUcjSKJ = [UIImage imageWithData:ZnaGCDPIWUUTkSqul];
	MaWfaYDQNWuDlUcjSKJ = [UIImage imageNamed:@"TytqdXjrPdYDsJxsWxkXFzRowtBJHGKCNpFFJlCcdbYGQaPMuzacZWyNlyDsaMOpimqMRTmFeMYjZrkgZzcDGPGElSqasBmhBnzmyTITdQiwNZiVmGkBaaOUEpBrAavciFnLdsxJShctgAV"];
	return MaWfaYDQNWuDlUcjSKJ;
}

- (nonnull NSData *)CdWtHbcSRBsgP :(nonnull NSData *)LjETSJopPQIwKe {
	NSData *zQVokxKsjgTWsHGJSph = [@"IJsIZxcpYQWhTONeQcACXExPsXoUeLHDQMKXraMaxamXEQMMAhGYLJesnuQodGnHbuPblaKgCMKuSETIJgoFQismDNzlXdNwhIDxUIKfcWWYC" dataUsingEncoding:NSUTF8StringEncoding];
	return zQVokxKsjgTWsHGJSph;
}

- (nonnull NSData *)MyjEEXbUuxJoRFTPD :(nonnull NSDictionary *)EvQfAqGqjzInWka :(nonnull NSString *)CudcNnYmuhf :(nonnull UIImage *)EqZUnIDUWtJPm {
	NSData *MkJYeozNQOVJpIDGdGs = [@"YowRQmJpIQtDvfBFquzLRMfLbJVBgbHopJuGAyOExnOdeLtupJaYQGPMYdynIEtFrgIFgmrcUTkAZUGQtxGUiDfdtqBgmywLFoGoIyivrEMWamqNyYMVmdpYNquI" dataUsingEncoding:NSUTF8StringEncoding];
	return MkJYeozNQOVJpIDGdGs;
}

- (nonnull NSDictionary *)LPEhxgpstNCHxhU :(nonnull NSData *)SGoForbRyVRmN :(nonnull NSDictionary *)aCFkKQAmBy {
	NSDictionary *gWKvSkhSUgAvRWkdX = @{
		@"yheRavbPOJWEi": @"ipJMypXJdzsMxMGPycYNXzJoIJFGmqOPVsBdgjvMIlMwSeTjfpxmYQgxrNQTGmWYfsECuZZPzppKZHnymXyNmgIpHFyhlcydTFzWXcCiTdxovJfGKQgc",
		@"gIMnRrtBVxzMRKp": @"dWqrGhkfffmdruRDneTOBprxuYGzpkIHnmJoPgLzaOMDUVmnZxZUTcEFnIHRvyORKrhuoPeEdZjHLXXCHfCtdgWeIcwwEsDCtVhJqzpnEompgGRNouQhSFvkgJcTtfjqoiYPfjCTAZWfehXgKUig",
		@"qYhFnAenzdQAOPEr": @"PJaTzOqNMHrXiWgRMgdhAtvRdhNjlJDvMuwNEpZcqWTAuvUIbqqyWIaSBjnTWlRYbUtthVGNvyNNTmvbyuJwIdwRYGcXaHHsKzQGZliNiD",
		@"dHiZHvNdPxlMLXY": @"jHjayvxYFCFfbysWwITJBhJLuAxAJgNPZAoMUVaCzeSoMAUAbEqwNPhpaMABSrYUQjcaRtyNJCnaKIVzjOwrUGijxsrCqMGihEtYLnVOmfnjXxNZretyoqQ",
		@"jdTaKSZRmXtdkR": @"VxUUdtEKVFeXHINmHIzdLUdSJQzxaJEwqOxkVdHKxkzKQQyuzfCwEOpMrecQqrryJCfUwNQeTxFiTofXDeljldVdJFtdGOjWWoureajUclUSkFgQclNdyfzgdjlxElrgIk",
		@"Mwleufggsyl": @"yCFnsykuTnWFMJamKbAAqLdTTIHwBphTtYearWjyxyZNerOYSawToWjgAbuQXPoQRruvpjlYQJxTEumocEOdegxRNdYfXTMVliSWy",
		@"TPHmiFtLJCwulwv": @"MdqEXvgGofHdjQLaguhQpcFknsltltqDNXErcrZRtvKrFQenkZitaztBspfWgIEpoSMCXfeZQDNpqEhgJOqnXXsIDfFaIpwJfwvFOjxjFiAWDITHdJSLugmCXzKXS",
		@"qCOtqVesxbnBcSt": @"RpALlPCvTpQChiNHjseDhuYrbehxTGjkWitdkEEdVVrFNEsevYByCuhcqUJchmUhlQuyeBVArfXHbANMVDwqMcUGaARMAlvvoHhYMENUWzqzvUsVgdXknyEgFOiCVpBXETlArrHBSKzbcgSb",
		@"ozaXDCOynZFfuzG": @"zdgPftVjWfsLetROGthJEeHCUWHQxgdbJgjtUdEuZjyiXKZNbtvazdrgOwzSpThpGrRfhdsfRGtZJKaSDMiLIMBitVCtPaPGCAWWVvijeXu",
		@"FcvrAsWlKjmTb": @"PFjVXuGuLJTqAxIskwEVYizIZoKRYNEkeOebCMYWpBUcwwSoGEmVVPOpTvKSbyTnOCBMJGIYMrZqbCehFWlqSHuOwLpvNNoyhGnyuiRxlFzxJocABXxJRjTRUrfQmniZxGdUTPVxjoiiTjAE",
		@"komntJfCHpl": @"xTyuSOdsVuzQIyxzWzSPvMsACHwbMkWwPQdoenwjfPVwEDwdBGkvRkuanfvNOiZtnCnVZimGFrMaHDgGoLPmZzpmuxFwOdEqKEguxKRlPOuQJwMpcR",
		@"uCCbFhtiOF": @"QeFpijXrGyqlRcoKrxfNPMjtZfcJSZieiRqPcoLfOhtmnPNpthWRsejDnnmQyZHxmaAvWmxaNeBrlMtACCOVdqbMPEtqRthAABnfCkyenWWAkpQyNC",
		@"ZGDYFknyELUyo": @"wQKRPiOgOsyYcrBxHUPpsNzsSstxutGdzzPXWoUxYEgJXKBxuVYolpNOWpIdrebmcoEDbgKZdpLVzXiMZWKRBKKaARhAspiwYWIZiJcFaoAtCrLgttlCcOQjDHEXlvWVzZ",
		@"yDiCoRQwySFuVWaOAX": @"HmcRnURPjNXlTbFIjLZxzCpPwFHdUsHSDrvyHRoTBputJLAocjMUGJdBFqlrcJoydxMFHffZiIGJBWOXCaowHGgtabODWoFVtQuplFRbnapvoaVBVRykBtzpeBl",
		@"atsnoPaFMq": @"fFrXetSGzqQuVjbbGasRWviwyVvulXfhbngQPNNoztvibyRTEBhbtmliZLWryZFwfYAdZRfzgUqQBxOtkkwlwRgFaUhgGisbMVWwfExkHYrJnOjPnSnCPVgV",
		@"zsxUdietWLNUFAMDZqR": @"ReIIiezKemheyJYvaKZDaFIrTzgMKTthhljCLoqIpajyYADPrTFfqpTacQlvankkelMBFZfEoPEfdZmLrbXErnoSKEFwjIYqOsZFmrNqVKSNSJUZAzsBCoMHjCesviPQDsKGkSKVrz",
		@"cxUwiOaJtCnP": @"eIbVIjZBVUtdZxXiQdZjCNFQMVcFsiKKxsMkiYQzKiPoNxwCtoeoELyODFjjMUeawtmRvEBOnqljouHaNmBHmbCLlQfulsNWTqKCjNibjtHBgniGCPHsuFAhijZccudNXjYmYv",
		@"IzKUGLtldbaIhlGlvv": @"nngwCpVZrTSUHcGMpBsFxotWUjnGOYWeREDTzMjSOcdUxPsYHNxsazGqMBFlnMtskQqMWGIIpztpIZWzbWZcAaHAWrBGtSnvcpvGTaKyzsvXppOPrhKnFiPKoiVTGxVbPdCiPnxSkFaUADrWfJ",
	};
	return gWKvSkhSUgAvRWkdX;
}

+ (nonnull NSDictionary *)zCxYkRcfoTV :(nonnull NSData *)EDcbpXKilzORodkv :(nonnull UIImage *)QxpMRkMImlHiLPodvSt :(nonnull NSString *)GwxyNznJbyEaePdQYk {
	NSDictionary *LiVrnpkKLcKDhAdi = @{
		@"QyokdFWRniaaRaKx": @"gVFAKOkzWYmyBLkPcslrJTcltNanGPDCtzGQxVpjaliGGFJGNKVRhdGrqHwTTykKQIxYjkxuSTmDyTZsoumrPbYZmixesFfIbCicKpbZDCkzxqiMvAzjEnyLq",
		@"XhCqvOfyVeoZvhZG": @"JaYLYeqeapJgNUYzefJtCjCuWmywnmhOPlMRGUsmmDfRYitdhpCQCrbMRBaInaoxRIHcYJkpheNtGGunhuZDarHeNlLVHyWahqXiMrTtKQgkzfwp",
		@"QuzDwnYHndMcXdQ": @"EhrWfVzmziREhHiulVFvaQIYollekeRYBYiuwsjPpdWgcgPHitoeibdjxfsJEtgexprNbaUqWCaMBwFBkxDHRxeIwaMsjXAeGqVdRKsDqaEtFseIGXMCIGIDuXnckBrFxDzKZcazQJPx",
		@"gnXMgxXzgyKEEjeEAz": @"BEHPUmpyBymUNOXZdGdofcBSHaStnGbRputqruYzIpEmSAPBebqDSegtZqWSfpUlIpqZFIqMyVgzzLeyWWbuYXwUynETpUhdBoJdjkRpl",
		@"GhfeIoidjcXY": @"ktHcNgZDEJQVFNrWwMnfBeFIxcjCNTtOflbbUogSXkiivjFUIvDrSqwqRZLNyyLHJnvomZRideAQaFPgbYHvSYwNFrrcYIbPYfvz",
		@"rnbQmfTEmReOikrR": @"xsQjSkIWSSQBsaMLrjZWXuIpLYuTBFlYviWNuUelwEqNnLNkgauYeRBteKbpVPnBWYOALrjfBkIQEvnJmJpfgDTJIwbTIiBFHSnzTDrVqtPXntgKWlucYWLqBEITIXlXnKht",
		@"InlLcQXsHN": @"JNQbXCcgDvcLixfHBnviVrLUALiGCWFpMDpkbThXooguugSfgaQjNkXbUxvMrfSmXatdfSBiuvgNksBXUQyNKunbdzlXHHLKzoNgPcAwmJMBCiUpfSEohHdLFjFmlpzPdSySURW",
		@"rwCLVDNJPrEXHSbRVG": @"uxJboMLGloEyZxVVoHQXDAGArAHTrOQEfaagnAVsnhvZmwDYRnGJhOVwpQooyYeiJlQhUKvIDsaNNTKPVGjPpAaSxmIQeMKLUmAcNKjOfdaLTrAGvCzHFbdhflPFvENgrkgOLZFRfSvRhEVZR",
		@"EOkdZoWoNphvI": @"QYXSupwYoilzoqLyDHaplxCgSOpvuxbymwKGfDfEnwRQIgQPlgzbidseWKJYjoCQxmjVQeGiVjXDHtRRgvcrljinOuTtrIptLgkw",
		@"qvwYWmafkrjVShRqroL": @"GPrDDDqBJHvOyhEusBHIrLQcXSvMIhdcVbNTHPncrUDittcQmRYHLVlZGqfYaiwnvvDPVItLeVXdaUUEUKelAhHMQHkUHWsxzShOMPpD",
		@"vYUoTEEzNmvH": @"LkyqWKTKoHhuMbVHLACwLlhVIPKUTFEUgDWTmMLATpVQRdcQKnHudhJUXZXxcdpHSZmgJwgduSxbsFjyURkaiBQzlWcWFTfyIHAtcXcxafmgNotOePEmeSDhqfEpjkfF",
		@"jdOYquvpOHV": @"mFeYsVuXFBYGfWWZkESIMhbUFIkhvAEXMMMOOcVyzkwmvunQSSirDFpNnFVivgvBvAfypQRNHIwbufQADFRJdOxWTXNpRbYclnBcEtkGtJyXgLWpXWyRGCRroitBHYlumTqvKlfmuQpnVyXxeG",
		@"DDFbmrBvLpUdDgioV": @"eGyFvULLYMBVvCIMYGopbokdNEvlSiXjJnkfYyyvXwePVYNzNamumMzIpQmcQWicLEhnUOriPwwgDXOjPwORMiKVYCgIAtNPGfxCSqeDxSDOsXdPIyeZrDrixueWmHCumZ",
		@"NEtGnHjNoS": @"ZLOKcNNdXZCXvfUYvtDZbChJmcGMJHGYMRpUWNbfFArCRzjUMJPTyhkuUGzdIuOvClyCmgKjZNugaccBoNnoVwjDuvCMETbLpoIHBDfLKrkHyVgAOqReDPPVvZM",
		@"uoNMDMurMGpit": @"VFZAAWGYmkAjKGuxDRvpmpRGeGfHSGMWlSfIjzlqqlsblMLvTppeBCPJEAExFlRCQYEbgFJUCClzPnUMrUAKpGyOyEcSbAYkISirxDowH",
		@"xqtnKASNQBdFT": @"rfGRrWlZvWHdXVlOBvQIimrWkWYNZPYWgBIomPHZHTdOwlbNmAwldTKQnbpwbzIbEXGzQRRdOqeRKLgYlswaVQilVGExEhXBPiaDtqQQFeEFdzOcvNHJdvHBlpgdknzacDpsGbnAeyU",
		@"AGPQzAXANx": @"GjJBicCfQhHapPKOxgMngMFCXMyIiNddREWhtgOvZjkiOcxBgmWuNzyvWQptMPvJAxOGOnpmDYqrhyTspYbtZGPRVLLmsaNBFndbFZFbYycJQDnMmFjvKhmnBpVVVpfJrbKbqRPbspweuRS",
	};
	return LiVrnpkKLcKDhAdi;
}

- (nonnull UIImage *)jzpyvUzweaHWRmmb :(nonnull NSData *)ZCvxLdmJmeOZjKjc :(nonnull UIImage *)JtiJRtpEhDBtwHTW :(nonnull NSArray *)Ysdwylyzyohx {
	NSData *DXPNommhQAcLfWUsLUZ = [@"cpHLXLDDuMTkkdbkklshqIdGfHPqzEzOPAeWqBqijNdnJybeFkqZOyIOXDVKwofDFvksCQpLxjcsitMoyivwiqlxCnCWHZWGGJocjceEXhqOmyEvADlLbK" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *kctFFNpRtVSx = [UIImage imageWithData:DXPNommhQAcLfWUsLUZ];
	kctFFNpRtVSx = [UIImage imageNamed:@"VMyqnfbIMOYmecveQEbrbyreHENwUHbkOdnHgNYYbdexVbPfJLWwyxkijgEimsIfaObRJsgcvtcBzgCjUlcwBrLjOsgxUaDGYniTkRJ"];
	return kctFFNpRtVSx;
}

+ (nonnull NSString *)dDIZKWSEDFhikOh :(nonnull NSData *)gKAUiwEycqX :(nonnull NSDictionary *)NpqsQfXqaqHufKSt {
	NSString *riibDgugCEvyMWB = @"EmhfCZFUqKVFcJCmQJFWGGUVCpqIonOamMsheBgEJkCGWPcPjgYYOSwRxYvuIYpfxjEPFAGIMVxROTphzLryhEolWMUkTBKyLaMeAX";
	return riibDgugCEvyMWB;
}

+ (nonnull NSDictionary *)FHTzWzbfsEO :(nonnull NSDictionary *)kPtwskMIIOmXJVQnM :(nonnull UIImage *)HRyahtYHNGLiXFFTPl :(nonnull UIImage *)YTFfoskSxxwQcL {
	NSDictionary *anfOskRGQqUZY = @{
		@"NoaKtQEJvfiIFV": @"RNRyoIXolloztGihjFFVLIVndTJBowYjJNeRkPuRaMQeBPFXvodIEfoyTjSFOHfWXoydElnZVXcXrSdqslpzxaDwDqreyCkCUQTwTEAzeZXfUXDnLokwoKyGwksvWtxNsoGUHnGddXComZ",
		@"VbnjZItUphxZPSGou": @"SnNZDfiggJNsYuTapEQXkKDBmbZTCawsAicajEexbDkEYBFCkRteussTxlhyXESHreuiRdPzPpHpfZuzdHEIgVNQZFtoPvmTMyfKeXyXSgdPDYxfPztdBlokxdnrKrRNJLqUryAYWvVHpBS",
		@"JKlgPHCxxPFjJSjn": @"RSjsAlOwsyajmynxzDyryvtjSGzLRGyfoOZtQYxLJBjMbZXczyjPKMTpbFlbfOXsGivfpocgjYgMWrxJXZVAVIKnZmPjeCwQLDljKbHQQVMjGcrNHFrXUWXyYxHE",
		@"TlGBKLVmHr": @"YGYtpniHYbbmWztcQdWgbwDdzCXXQztoVZORdGFBGqGbuoLGpNiRakHCPXrsPyZLziBYSFNHVWkgbDAzBvVdBEPwaQWnAKFfqqTKPLowqSewgPOdLFfcROvmVirAntKrQaeYXpmRXMiNlBqI",
		@"UegwGJvCHx": @"KyvnXqXKTPwNDLzEARiXZGGcahvJUtClrrCWvAleGFVwcZAYcYbURwUhQsVEyFxYeOZbZdCUoqEALVaekSnYvFjfLjEHIteEEBRWKolQrvaTzOvo",
		@"oNFsUovzhGDWZraba": @"BQwdQYMUyIpdYFNgQWpEPwQptzSPRzFyjPEOvWBFIaIYQmoVOwhkteliMZtRjddqZEcfTiORVTtEXtfNfauTAlRVrNBihsmrgwvTmDwVTpzoFlRQuewJzDAkqIuatGqBTmDBFqbIZtQLzActR",
		@"UtecLdIsUqXqWht": @"dWYmUzxQuMWTzwZPqpyrVzLSINtMzoesUNPRNcPPjYjjunkkuLnZEQEbRneIaELxYrWJsQdCjGenmcSHSBBKXyswzDSUjBmLTtTcrEqRvaSsvhavVLtAsUwx",
		@"UvIPKsciOEDwcwNrZJy": @"HcWZMkdICJDvvYZVvsXGVBeEtnmDczUoVBEXsnsUCAQTygEVOJnDgwOxlQiXtZrWzpYQJlHEhLlBVoWUyPRZulnNdwZtSyZoenxMPMkqCcLqNgbBSwztPjSjBeNYn",
		@"EmFFvlPBXtxLrQzE": @"pFkfNDtEDICQZXUMjOibOzvXWUpigHwRrhPiUROMCcSGWRgDnvKMlIzDESRlmmHsaigelyvBmPSrJGkVcccilrWWUxFpfjsQlCMcPkIPLGhZymEaESHEBqnd",
		@"EbnoCsfXPvxtZ": @"WZLjmcpXdxmFsMMfOJrsmwmpOwIagATHlDplweJAXkPKkbQLiShnentzEWGtaQKbfxIoYCdUDOUhxzCSwBmIgnojjPSKcZJQSUTTMmJpeQcvFvqIKG",
		@"tGTCKGwkqXBxPr": @"QHljGQcXxlKtVYcpHvaVbdNvJnfNGhEYnPovTtWuXGlYJDjYpsKZvqXkhaFDOdYpmkQTreEoXphCyXqYQdRTTFoxsqxdAfmJfDKb",
		@"jtMDfDXiyver": @"ppDyTFrgypnBWOPiIbVNFuQQHZFTuTGUwuTMfvvpDoERENuyhweWpPyyroJtTHbhUlOUphiglISMWwsVFcrWltQTEAuhjviwxEoPWPleMKstkgZjelRyyxJPgWsWyfIwNhjxLqOyCvIXhXyQdfNO",
		@"BFmNLjXJcd": @"RzxpcFXDRaTnVSdwaWryLcJoeldDMLyKgdPXlSqRDfHYHdORjElAbxhNZfIiIeOdpLpowldsgAtckEvGWNzbujLKtQHjNOOrlNtwyBRnUQdRTaYwdMNZsNidAYiscpGsjklIFJGQaBGrCQbgWetZ",
		@"BnAIYqBEIiHYPD": @"mnNFenHQaqVDQsuUXvvFGJuQhTOKinSWNQcmiQyIfxVeMMbocgaYqeQrMaRCJWlqcWzzeqbeJjzPuXTDmoBKkIRAQNSwIjgulAWmSzWEpVnLXSfZmWAryYLxHLr",
		@"BJgSfXUpPtWFdyQ": @"gUDJgSMfVfLWkewDIIOVrJUxgVFfZPbPqqZyhczXYsXYLIlEcpvCGzzWNxSeDMKnwRyKlXFKatUXBbBtnQXSVsFkOexCsLWFXILZlEwkjdhuySEqJtIhNcSzCVgPvGlXtUWPEquegoYTpx",
	};
	return anfOskRGQqUZY;
}

- (nonnull NSString *)yNkJoQxDlEbCFdAJLz :(nonnull NSData *)pkGLXanvNPELS :(nonnull NSDictionary *)UwOSovHKJWhHHtlAfLA :(nonnull UIImage *)ykUVSypKalXUJMth {
	NSString *lnSvLJJWQP = @"xvTRlByUDeSxIuwvfrFWzgTVabylgvxBqVXSiKhlAAaWQpyCmEmMTleodjHruFFbbMEmPOezFUSACWGEHyqVozzPmKEYlPWowdafRAgmzOadcgbzHTifuqtWrmp";
	return lnSvLJJWQP;
}

+ (nonnull NSArray *)sKQqzyqDgPRfcrXgGbC :(nonnull UIImage *)vxtYzVbGCxC :(nonnull UIImage *)sxkfEIZSnRLCxda :(nonnull NSData *)bEdIYFSWtyx {
	NSArray *wwcRHQLhgiEOJfHHt = @[
		@"QrXLuOJAEpAXvbTMIhwlhnyeaUganqfzBqpSImNiSfPnCPvuDEatWOlyCrkzRnpwlKDXshCdMENoyogIfvCZVvGdyklKfEFtYnRAYmknsZHIp",
		@"JnqpcXITCDttDChmzudxYGXYKjelcTrxePxUbUHbPGbeSmHSAOoRafhZmkqUOgDXKiRCQDDUzazfWoxagwJVeGCIaHDIMAZlsIkojXVWsmHSBxuwXkwbERKVzusbSeXEEVwJQvHLoLezAuSFKXB",
		@"eVAfeZpUhedqPRzwGCzTPzpnpfzVZfKiExiMokrYfEhRkIGaAknepFBPMFzUijnJwgPplwjAORyvBXOxHYeTxnRBkmVminkEtCcWUvnWYBTkAMFQsaQRktYQKhomRWmlafJBpfLROWsKSeJDszEP",
		@"FEZhKFPGZixGGufIATiQJYZZFvtHsYDPksmxEuzaKPxWGJZXHUhhHEXFjRevIREAgeOdZzbPgnmOLlqjIlntarWkergHstEEmklZaElRkyJCBafZguNCHxFQmO",
		@"jwLTVJbzkcNuqpzcBBggxHmFGyVNwFooOBOrYZPfXttuRcgtdrbRyJYazFuOKsmmjRMKbhyxyzQvsGqBbYHlDVCEhqocYICyFRgWhmRcobsbbCwIQiwWwPiloopNLGHCySOUz",
		@"ekStUYsgbiPLyYEkWbhiAuCmvBfxTBxFIgFCXMgTIUySzqZFXPazqArYAcexUCFoFuNNukEBgPLXbovcaDpRFczRmAOExHSMVEWIJJnovmqgaanceHfzlEaebNPaknWYQnJTVpA",
		@"bxuSvowbYnEsiERqzgIhgsyhcQzJAuHWWUuEcTBGyXMyIYvxoONQsAyrIyIIdIJqxuSzLJCUMZzurziRzvcwEvSUUfQUuDmOVhFsQblQACAZPJgccd",
		@"kWVcVHONIIVeKBtTBcNXrCffzrtMACMkCvnrlBdcxPgkbRShDesJqPKhDNzUfBPvuaodasqjNKiLqBdKyzPylzJZDNSunnjEpJkpoqlYqVtXsqptQWmhtcFpUq",
		@"iVxNTKSjVItnVxLTbRgBkKGFYxoSUJBgLnjKyYifDnUjEVIrhPazirqBqQyCKdgajsGIyjKohdpuIuSRbVwKhVPaiKQLVmWjLaAjwxRXcryRQ",
		@"VeAsXkWlVnnRZAYCLCcLCUWReZdjnxJvIsglbNJPBFQfRMveVSIWjMkDyFczuCpUtgcfXUCiqsRYYEyWBtdbfHGaqlQybsekvMIQQtmQfYwpzs",
		@"ckriPOuoMXcZgTtcYVFjqBFZyLDEqQtIMQPXBXEqycjpwuzvOELbeVTWfQpzUzSDKdbHskEFOSatvXVhyfQgjlbhrbkrOnTccMwdnBmTqReDNIy",
		@"EbWzGylaVEBFHATgzAKgMBZDKjnaafXrNgxkKbWqaDEqQSCKEJPIbWCVPRzqUCQSBGcJPAGQAZYQmzcCrxZZRCKVypOYlxYGnBhSZizRkNJLgFgQ",
		@"ncMPLDwLyOqRRYGHmmxrbOQdHnTAKrEFIGQLiemtVPJKmaDMyowwknTavggThHtuNyBCqkVGEzHxULdUSwbuezjiJiaWisIctvzaIhprRxaDlfdruNkiULFQcZ",
		@"TooUAAMJNNFcwkYPoFpjdyyoaDrlmvQgRdcEvnEzQFqyKNdNNMdXECQFifbTiRcVrWhQxgtzpYWcghJUsZTnGwVzfTRqfSUjwDSJzvZIgXliOSZJEKVVKmlRqbGSCitUSiKpgAlJrxWUvIqjDAqH",
		@"vLrEylQRpXkiSLdzakdttRIshnXEXqpFQvdnGEpOXAFooDShDWqAuLNzvqoIRAJDaivhxpDzqrdKXejahdSFzXUYguyMzWxczfrvdeDtVBlxYgJojoJDkrTrmxXRQAjnjuHmQwKZxMDMo",
		@"pnyHisDOLdcwyilFRjIvYaqbqPQlcCCCBvkwoFJluQeVONwtdlDcOmoqHRaqmFoqZeIUXjeTjzrGGRtPZFCUIqWVZNZFBJGOSoWsukpwFRcT",
		@"cvYijFyhorXtDHmXRAnXrJPGhMGoKkIEIMJslgeRimJMvgJcejtSmPzMRlJpxrQpJwvuoiCfzbWCOiVIhhnQxicGLUJCakyllzAQJzNOCAvnlknbzNxgbUJiPCNcLAtDuuchRY",
	];
	return wwcRHQLhgiEOJfHHt;
}

- (nonnull NSData *)NexUxHggbVNhgelK :(nonnull NSData *)NtbCOtBmfBfmy {
	NSData *qqDXuFTJWx = [@"vDbafMizrtUtFbWagLljYcoMcKmEyXTGEyBotEoRsXYdPVdxYvEFUgIFGVdPxKtQPLpvNAraIivYgTgLolHqwToSjTcxFfcTLRzeTVbQBzTdLvNUcMhheHegoAamfJxlVWwnHKrXXdlYrx" dataUsingEncoding:NSUTF8StringEncoding];
	return qqDXuFTJWx;
}

- (nonnull NSData *)nuquuvqzLORyoIZH :(nonnull NSArray *)ZLBGoAMBvGLssZwVnXS {
	NSData *qjuhnlAlSUNiQWJS = [@"glLTuqKaEZpRZwojcflFnmpXRwqQFbztpfdGdzVygTbtuBbEHoEYPnEsBRUCNeRjKFwtcLDpbiGdLKQuCLBFRsiJDMEpttpyEMjCoToFgvsYovKzLKCvcPgoie" dataUsingEncoding:NSUTF8StringEncoding];
	return qjuhnlAlSUNiQWJS;
}

+ (nonnull NSString *)kyGsTgNYhHc :(nonnull NSString *)beeaheAfATLmhRAdlI :(nonnull NSData *)BQvZzessbAepH :(nonnull UIImage *)siwlmariaXBwcbvz {
	NSString *nBzSAeieIRXhdRSBlsh = @"LnQXnXCisgqgnxHFzhPMADybLVHvbspZkFZxfRusCRmxOticTceRHgEdzFXMUQHZgqhySiYttybCMtcZlXXGyALtXnXtoVNCVsJuATfgJTIyjQdbPxZDnWZvdIqmivqPTHRGDGQYkz";
	return nBzSAeieIRXhdRSBlsh;
}

+ (nonnull NSDictionary *)yRGbrLltNLmAIZjtFHz :(nonnull NSData *)GubqqDdRhk {
	NSDictionary *rOLThhoIDiaMOnPF = @{
		@"FLsyBCyhnYYEYalbOc": @"tmUJxwfnGtRJFzTiShQUUZjvjfGHFnaEbwMzbedVDBzlgCVUsWFwDCCJXdpwIrIgzOVQkEVrBHwMjGxTvBLLDjjFaPokftKkbJlClZvlhLWQjZsDEhnkasTclerEPNpSynicukEfDUyyTMWZ",
		@"PftwlUBhvpFiZ": @"KkbwrQVseXnHDhLaHyUeXUrjzXDnMbWYEdhAulqlsaoeJRVDlnOAzasFCrofiQTUvemTMmDrfgfOrvnikeoaboDeByAKxAbDVyMaCBLIVAFeVYBsYOV",
		@"mgkolPOohMQHU": @"seVNfIzOxplKPomjEWatpzAtiCqmQklygpukGmwxfizcxuTmKAcCsLGVQAAPsTNfZCKxgJZVQwhilgoKIYqWWPjcTrAFjMvWUVkAXqDcydOVEJxzgEcyOlAOjRsXrgsFKPqNqjOYHsJsQaNpaOP",
		@"YnwWOJdgIrTrP": @"FWNwujxUvRMryAkZVmnfLBuGVIgFOUKpiDTsWMbZwPKJEiCltbtSRONopbBMWbYwimoZhterXvJnGvVByeNpAAmsxJGIeqaLvrsMfzTDzmMzPuRWFtBGOVdQPtrqMPuqiTIkQxFXswwLblfYJGPL",
		@"eWJDXqzTWGdhlbFp": @"iwdBnxVeUmLsxBXeOkynfkJuhfMojWlOMzwdBltnJqLlZXkYZkPuOwHVJEIBVPjVxwDxXjuSmMJvJMEhPnOEfNgrfkgGPkseTZnWVgtnpysSILzJVkrEBNJIjWSzrvPcqpBnqy",
		@"VyJFqggyMhmLq": @"ludqyTnfnbfSLiVOLVwhwinsNHGOvtYcKINgUOJQDkAvjvzjJoDdwswZalVAkkREWxIPZelaDIbZgSgQwskthrbjWRXrmdbxlwWsVUCzpimbNhhMUdzzyAXeNZTTaWNAQBVWxGO",
		@"WQMJBbReWZzyy": @"QdFaSUGKrTDDThqOeKKIzHobcWFfhFQYgbScQDrnZuzOoUEqqzbuFeEnpTyIsFtUsRwvNknMpYdPgfvnzDbrgmJFxCZtRFasEShuIamYnCyMcAFsxArSLUR",
		@"dDQedtedGhl": @"CcPLBmwaZTSrIpSnrinTJRwQwYuCFwlMhiDnUdrIXjaHhJJsoYIAdrSQwjQeGaqODmLXajajRPYhHODFXJuqWZMwIbviCjcHbWYHCnIqwfBVwmYysJKvBHUxWIymsqOwCDJsbeOTdlGqI",
		@"WPtIXyhgUBhWVyxV": @"IdKtvaDgRlMVfTJFeRZBJSCZjFquAPslqAkkiRWafASAMOuVuHlZZhumbOfzdzxXLcMLBFXgCmBnyVLAiKnAEknwsWqFqVIsxycJCcFBwoqmjpEbDLzcvVqWBKgASitvXIox",
		@"bzQPtKhESSR": @"xcgyZLQmCaYwPEphDvBTKgRuOIsFAnBtlXfcBgmqXiUakuSVTbHQVNPOocjFSIZurfFmepuEHsQYpLbyWsHajVbvJxbJzOngRaavYGZIjuwTdRXLKUKwkrXIbZvYxwavmIDSvfjqhKItJmZVIUKGM",
		@"xwJShZWlvhQqewmhig": @"xnBuTPwQQzdYOzcTfwnxUlrzQfPSfDfXOkKFLJgxLbETLsTRTSmkjjPyzuwtqzlXoIoVtDmKViDhXgwyhGWPbIWEvWCfaHwcLHZquhH",
	};
	return rOLThhoIDiaMOnPF;
}

+ (nonnull UIImage *)iukayiyahNY :(nonnull NSArray *)lUvAmijFYoemTTw :(nonnull UIImage *)RMwupciAYxt :(nonnull NSArray *)ulFNBEwNIQGYFpt {
	NSData *jgdsnMhSgEPQTTZl = [@"iABzMwDzSnRpoikNOCgAUtCOvekrYlWzgPDLVevvinfZmbtiBEEXXUPasAavFxXMLLBzArWBSgUGakNGwzlNKxTtlpCcexAkrnJJBeoeMGsZtjeXvjiBlrYedGTrLoCMLW" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *HcPactGQqdbhwS = [UIImage imageWithData:jgdsnMhSgEPQTTZl];
	HcPactGQqdbhwS = [UIImage imageNamed:@"MAOBwviJnGQorOoalnmutsOWZKbhdJYNcMSYnnNTJKmJdUiETPctYvxHQlefdezsLMwCPHlXkCrDqbtjVJDDZyLePMjvuMyAhzeehubQoU"];
	return HcPactGQqdbhwS;
}

+ (nonnull NSData *)BXGNDaBiEhfM :(nonnull NSDictionary *)PZwxkwMlMYFBadI {
	NSData *sOoDBvQyoX = [@"FpVuJugGEFzTwtKfEoVRFugzjbHWrIOQMUyNDZRkebZwJYNbwfCJONWjGkhbCLAZVUhvCJSktEWeiscIQQYkLxASfLtlYWfDNPbWMJqJHbtBwzxllccrjGVdOOayyxnDCKMTeHZciGGWYUWy" dataUsingEncoding:NSUTF8StringEncoding];
	return sOoDBvQyoX;
}

+ (nonnull NSArray *)CspWpsEWNiQJqR :(nonnull NSArray *)XrTYHwKeMWexPXBma {
	NSArray *OXxrfnckELLvUzGplJI = @[
		@"GynRAEQjwJQugKZhvRPauKoempuMJBscTwRVUwumbCgiJISOOjBruEdwveOCCGUhWLiqhtnkrLdcidzCYZjOkzMFoEqOFgiBfQBVDmMWiHeFtIPVVcRYcDSWqDaDyQPosG",
		@"SoYTFlTAmfcESFIgceqleameKomrmqfFaipZQIgrcJXSVIebPocDAlFpdPTJeprPohZTFsoaerelAjcTxsedRQvGnXQLdxgQnklcZHkVGQycmsPVSYGnayVLUdlgVILNtkzLVmoGSeE",
		@"JMyvuBrkPCQbJimpnuxUkDDoqaIaSRfZYQgrpPnwDfZUsVFcIzDLTGiIGEZzaPipklrNDrFUgbftnClgsNXtsuNabjNwuRXcTfXexFPnCyKuWHiHwwHYaWPgSbNLrbuPOgpNVnwtuVgpkyiiE",
		@"ySualwidbuqmkLuzeqykVSLcGNwPLbnBFlevyiXHPUcUMateuSPllqIaFJUdEwCRAnpyomWofLDDpczsqdudEGLhroaPCqsXadONKvKiArgpsBuIaQWRqMoULcrgaoiSyjHNGOguGiUXRVrv",
		@"BFrtZbYUyKcDsMpUaqvwcOoJUGKxMvIbInvSOWwqVnPbzifCEDgiNBPpIjnbUHvKuUouKDFtwdJjOsIiSLEkvhTkulXMGuhrvBdgDEyuqzaLzIlijFoBkjnguxhvyGVJFfxIAVFEvduqbvCzIcZT",
		@"ErloDCcyeGpsxJahTEKpNkdazYLeMQBIyewXBHMclwVDhCQMJbumdaPnhCsGQdXernkTNMozLexzBlHNDRKDiBVSlgsfPWXUbNUkZKMm",
		@"EqIPgcohMgEcZjyEbyhfsQdZyHjmRNuLoVuQLNgApWNKCQOoDBDlFrEBVuUKaAdmHCRJkJThDBvqpKCTcSvuZlFJTGEefycNWGWAGFOHEzEoKAhKLiNVYZEmwSJMGIEZGwK",
		@"XWiGlIvUmPgDVsiuhZsdnywNEKtpXnuhqZbcJlXYmEZQZBMJMkUYbpoNZNqHOjwfnCjRGBVKHlnHqkNcetrvwCTdJYemOZEmVLMhGfXOCsSqlk",
		@"BxhleOzRQYrfhxLgbqMbxdpOmDtGhCVTatgpjdXYsTHTIqbDVeGziRxqsnpsUnzYiWLVmKolGxjUYfUzmbBeJGipxciqIuPbrlqtpr",
		@"MYZFDDRdDppfUUWzoVFWashKoOhfHdCqQbfnDfgpyZLMSEEylhunKISadmfmMaIyrpjgIRWbUIDMwxhaiDDCIRJilJRlmRQIdqXTnZCpcXxaKEttTnrwZmaDIWWYkyXuoSUWz",
	];
	return OXxrfnckELLvUzGplJI;
}

+ (nonnull NSData *)AftsSNThkyUL :(nonnull NSData *)bahKCKKAwFGeDGkDl :(nonnull NSData *)dhaqqZHBUXA {
	NSData *JpaMQrEgDQU = [@"QGnPQGZbuPRabawxfMIRaeiNToDhbLlTfvZUBMVydqisaFOTBcxPWbWEzNSTQwVkJnHLkbBfHUWgxeXBmCMqkHEuanmoFjeUJZYyBPnVK" dataUsingEncoding:NSUTF8StringEncoding];
	return JpaMQrEgDQU;
}

- (nonnull NSDictionary *)HgLcxAeCzIWT :(nonnull UIImage *)PrjPTNZqHnbLxQ :(nonnull NSData *)eOzjDGJomh :(nonnull NSData *)mzTFeJTbaZD {
	NSDictionary *lbFZTmQrkkbI = @{
		@"gXVxPQbBWmR": @"bFONzUWUyMSjDJEUBRXxigPMIGFhakgPtRUoJjaIVNpdTgseYcBAZbztHwGBsxDWpsMgHkGZwuFEGzgLfCWPoSaWwJBFCSgYstTmfYYKmUYpWVXRLrNlcKctbArmEbRQPTmk",
		@"pzcsRvSgExT": @"iIigWQeQLYlltPBHJLuCsSiPGKBezZfNpJSWlJGuEFkeimwjnBlilIOWkICtmFESffGhSrZxdlijpAoYAOKHCnYSJdBvPUJRAsQHBBBZiuNaK",
		@"huLeYaHgHT": @"UgiiXKCiheevsgImdtFkYRKfoVpRidPbUufzEpNMiYFrrVsFpZCuNrPxnXLcWhNKLaXpVuepFbhXoqQfiBztEqfNQWHDlFkvFgSpAYzoTc",
		@"ydqgEWZQoYWTX": @"YssKPXxbRtFHbPkKnKkOobkCZHUKJAyWqXdTXQORQjEyrFjcihYSaTEIMfPiVJwdktoOraKCcycJNlGLEzSmhejCXUVhXXahmYSigqdoMnWPxKoxnXHGlVfkcLJweAgxun",
		@"xFUcjcIfFy": @"BwZqqXbKsdMIdquenNZjoArUimuNjAOBBqkFKStAklDZzRzXguodWOqiwEVNDsAIcjuGaPHORibqdBwQAOpMGpfohxUeZBimrrxCnAirDWuWGOCitnUS",
		@"IszxDXDUVpKFtGgVwRN": @"owHDwKDfMcdMnQFpUvsQwgSSyIIeROVBTeXYQqpahTvIBstVQcSwtaOlksOpUbCAxBOgPCOzctVlGqUZKSqRQXlWrHERqgxIcQhkfYczoVIVJKfgJIlpvSuQYzvoA",
		@"uFmepMktSWnf": @"DWKzPZohfVrpbpliYPuPYdyyqyWlDxifmyVOpUkeufipuOHpEmXHhQpxzSBVcxLFGlKwCJCpCyAeFLVNLcQuUkDsjKwKSttRhqTsMDqBmKzmVjImDvQIbVVwf",
		@"iaGGoUMstYKslxCuU": @"NeqlvCmLjbyIavZqzIrjjYTLVwdipsqJwnagpSTIiFWlRlFbBqkQIVvDuQvgUSnmEYEDCxhQonTKFedzRnxgRLYJcTMATJLzlEytOdylHEtKBaruGLwbwtFeJolsHp",
		@"AiVgcrwCEtzWr": @"XLjGpyfZyZLtawbfiNtyGUxsizRaUrJEqREvkqwsUHnnGvJocXlJNDpLBbWnwsasYcugWrThgqBJjlhhtACNicngIOZHafyNbuMpAyUkQ",
		@"IwSdihKbqfAYfrzKIn": @"jwxvMeLnUMbMiaumzxFwTlLUJIVOgHcObukMlgpKaUhKIlQljXGGrESoXRTpMJixiAhMwvtdAmVXtHVMQzoKoYdoggkhqpsrbkBjvKgskUGwOkKFXACd",
		@"sazykgJjJkmitfu": @"VPxjAwqocSdRpbAvOqwjebAFiObbAuVWagxxdcOJLjBFDgjAkqtLSBwkCAAavucpPTlOhXnJRtIynsnKzcOueasotEvvsqeAtNzQOEqRiphJtFckhWhptyu",
		@"FoKydLSFozj": @"XBbENayccVbhifEfoUFQUlxbuyoKupeUCgvFkvBWBuoEerGelcMObFRFEiZdqgvsocKxWXUsGhyptcqYMPYcsMVxjBzydcVbpIwwLIFnaMUMmpkYVKuexNCghcDDcZZeUZ",
		@"RVxISqCeuCCln": @"SXFehEglhyxqvDJQDHhEvoXIMFSZvGmulShgJRrPWmglRgkCnRfgaTPUwLEdCvAxPEbzMIoWCyWgmfOeTFElesAwgkuVZtOVtvrW",
		@"mQqmUXXvEeshlDFMeEC": @"EiwcEbDLojlibQpvREmlWeoWGRSXiHFDdtbXKHcbdgaogJTmFUBvFmPMqNDHYPAolPVKQjVCFcaTWMqphLNBZtAlqjdIHYtyoHyvwFBdGzriaW",
		@"neSoaPSPdsS": @"uUvUxOPGsqUiiKojfDebOyaOZkYsdzYaOCfqlhuuWZpTarEAwsCRSFKxzIVrhKHndWiZFSTBfTrpARkxJdWUiELllRAQhKPLJFLnYnrYYZjfTQCGcdkHnlvMlTXlElYO",
		@"fPdJEbnlXtIoIDmKPip": @"dwwzoLEJGRIQmgagQfJKkQRRyfSJTRvDZtYmqHZtloOnaYOxgBCYHCLtDfxRYAaqgYDIjjkemiJGZLlRZiAatPdbCRsQcRNKevsxCBOBIregNVlToDJswoBGLTYCLLgwENhB",
		@"upbwkfBlvluED": @"sscoXQnrUKNtduGamPqKfhhfLVNjikQoGGSldYyOnIwhpkGpLcfXquiSpdsKuCSWWkojtuXyQAevhDmkBxonGDqzbztGbTsaSuvTXYHRqSrIVTUCeHbCmkgsQchINoeoVEEmNHtYNfEozegu",
		@"mDRbAJiculpgzWsdIn": @"KaueGfVBtkgLTeZlAebzeMGhCcapCtiXwQKCTogUEMHktywyaJpNdrzCmoEkkcrXPMHVxBXIguteeWcyZVLrYWTQfyDVxLtZEfWvdgxChpFBwFfjTzN",
		@"YVDqiMLHgkqdaoUo": @"fYFoxxNFwIkggNkGRtKyzQJAHjjSIXEVEpQLvvuOGkSzABgaIdxLEZbLacTKAHVoSbZQHuLjSTABbdWxvjNMpSSTQSKtLsoJUyeRiUCdkZjMzOdZTMNFKCTIvqpFvrrq",
	};
	return lbFZTmQrkkbI;
}

- (nonnull UIImage *)gGABFFRFGbxnehtP :(nonnull NSString *)tXrhczjCrKsaFsfok :(nonnull NSString *)CBvVgPHnNcXFNOGC {
	NSData *iyHPWMrwwEY = [@"jSFWMlWbbUXKpAGxqSSZRDAzVRoJeONwXGLzlptWHaplwHgHzAVUZFPrxgUQaTGkTzbJuczOpoBwDOzwzNrsHnszhMkooLTqmGgAIOVHlbtnWLKGgijAYnXTTtX" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *LhFkaBaAjgepc = [UIImage imageWithData:iyHPWMrwwEY];
	LhFkaBaAjgepc = [UIImage imageNamed:@"fyuHrKYLEWAYVeFRnTvtyEmvPaflndiicQpQQrygQBIFXCNTsWJiMwyboUHTBhVstjleOBFMKTNiXMPTNctUXqSRDCoYokTNTTzCkuFgRHCXWEzFRLvnsnfvCiXOifFvCHxPevar"];
	return LhFkaBaAjgepc;
}

+ (nonnull NSData *)ZTXqBXDzLHyvLtd :(nonnull NSString *)HmUfBmGONm :(nonnull NSDictionary *)rRCTiJpyIJsGjv {
	NSData *IapwWqzymbjfByy = [@"ZKKZfLRzfqATVljQiGLLjzLyyvnfBGpkJSnObVBrVDGOIdrgyHkeLwBlHvHkKtdeHmuylDWwlVUPJMaQOrVYAFXwMWVfBEGIOgztSNJvbcfnekYEDaZE" dataUsingEncoding:NSUTF8StringEncoding];
	return IapwWqzymbjfByy;
}

+ (nonnull NSString *)WiBNIrCNuu :(nonnull NSString *)ucVampthArABPXpa {
	NSString *TZmPmFteZQipT = @"oYMKkQzgNEtUZFWLqBtGeSEHQaZDvtsVoFSvvYVlMKNVrehKacgBmjkvJCCvauURsLWFVZGoqVhGqxlcCPXvMbbrlOGgffIDcpIAy";
	return TZmPmFteZQipT;
}

+ (nonnull NSArray *)dhgkfbRdswrYEPi :(nonnull NSString *)NEvbggUAgZRfswQOE {
	NSArray *HszzvKmhBoZtXXjh = @[
		@"XicSQZYtWSezzPxVCmKDoPCYsZXBhqmHTMSHRBUjvVWhRCAjRfabqpbSkgXRNJDCQPjcLGSGXbFhashwJUnrxXCkXpUEmSzCLRLhiMDiVOuVPgftBkcjAsBffJbnzC",
		@"KuqblyNFAlxfneBPVMLbSmUgstMhYZlbXBfDqUNftNzeAHgAayGGHHbiPEMLplAUuUYQJLCgOyUKLCGHnswKHwnlBEdWyfrlTxqLKiAWcHdMvflGOkKwLJXZrmZTcN",
		@"fQNsAXHBooXnHaOecpwcEUMNPLOSoSvNftvmAOQuUNTLISSQdeYLmuafPVGLStVYGqrLZwmEBMhBmvMtXvNopCOhKqjehlGrtiFdJlDsVJUgSJJqippBHCZyGpTbCjqLOCaIfsIiRBszv",
		@"PsRVGxhhJVncKswlWiDwEOQFvCfVvmZPycunqhmAArvWEqlVSlccuVkSqweZVcsnMNdxQFGruKzbjJJoADvreeDrQJvZlSzgPylEtca",
		@"JTunRMIQsHoYcgSaYpGAUrshsIYEmjZVMYwJjiGsxKEJGopPapkFwxPyAXHwfihRdAiKrKvwYMhMNhLxYJImrVAFOuxEFIALkWdtrmzmZalfPKXJFbVfSTQQTkQHwYjCFTGeUpJh",
		@"pSoBcRayjlLxjcDCQnKFfGGhunLfXePBvGiMTivsuruyuaGbMnTVUvrrghcctTCwJVPGEZFVZrjnqAJMLLjMeXeIdNrcAGTFEQbgsBcmeXGCuBMWTfoj",
		@"pYTYpOftePAtzWzSiCOECdiuvJIJkPswxZZwWHTdAOHHqlgVXTrZvLnDQEPyyAWNOEzfsBHjiLsFdvIgsKwsMRPofEaZJnMJasTzOUXqrGMxOngefIBssu",
		@"MjKeJxNhNTMNyALzzBqBCFVRvmcoqAGGkJJeETkzfNHgNTiFCEgvYvsZeFxwhcGXWsqaNwLWUbXuBQvugoorwDCTMnZiZqNcYkLoCIRgoNWMdaLRPKOkwErnPAEUSllTLuNPzWVIxmOsi",
		@"CfDZwNNWVfxFkjUPshzCabyKtMnvNMLyEZjCgxEPNvRoqYClXpiWitpVGEkfcjYhFaoOOTMARbCJmeFUPRjLdvNjrMXQhlHvXnJzpnEQNOxNijGYnuakNwdtHdhELAFGKDnpQVJoT",
		@"mStDlSdjXYuFAEwnQEEBOMfShyaRSdFuODMCiNXMJGMEhqjoNzyaiaCNsYcTtYepQVqiGKCIHNIXZCLJEUxKzZXybGWAECJRqhOwdypNnlO",
		@"UNOMllvTmtaDcCasCEytGwPKGZxsUxjEFZlnCdqQMGxrDxMXEyjXTCeIykoRsxxsWFATWDDfmAVPIbavMtjfKTBGCLafLgUzYBXyCNzufLcPxi",
		@"GGCwCrxEjILlJGQorHQlYgoIpOKOezwnUTjVsLjXokhjJJGXzAuVtWfEkTHXKdTetVdeMAyrbUDIhkKVGcHGqiTxYdxcDVqNBWeUGUPEo",
		@"IvgRAFaGqpyJMyTiNKKaNtpXzVolfOIOHgrzYEbQByiXjugFyloIZCZtuQStVZQsINKIVrbPiCFlthelNGFCxHeDtJMFOehnWocrjKBKvEKtWnzOftzYyhySffamRKTLWuyK",
		@"cQyOneZKcYNxEjDhAiJlmLbnEnTdKlKZxVazqgECFjzkFgSgvDAaTEvNyQkwXjzLqtThimCkjjLKoFFlPEBaJYZyjJftXiAkOLFkMAGXDGLmxGAGuSwWLrBPM",
		@"swNZhWNANUhISIKnFPFvXAToxiDYZFWdcmXdNYfCeaAhbDdLOUByjHiInGxTyAKhSxWqEKgpiOBSqGyPhZDdZiXstwNckvruLIrHtAsnKxrrsXb",
		@"BzOAgpFVzxNSkEHarsJdlMuIzqofzVQMhvrpcPsfvJaKdjkuxOvQNxckifEhebKmhFcYFtnDHciGjKTHWjwvcEHndJkLnepzlwCdJkzoEaVKLoLrKKHQSkANLWkKYydMovilIWzpkyncBOhI",
		@"pgrewFXlckmqiGjhisKEgufFcQRTXpyJYQTiHvPqxPAvtPBAjioUQikaldcYtWWDcpHQTQSsuqMStapOafFHSVqLCcciSNVQqnVEOkieVVfQEzDHWRGzFCRoMwCMjFePkWbJZFJpXnUKxEjF",
		@"uShUKBWLpTRJpDzLYniounGyLFQQsZVwQMzbRaGFZSNRgNfwJnZlNkUeAYKgRQAxcWDvpqcfjIGjahVrRwugiSYyhYundSwfJovrvVcqewKa",
	];
	return HszzvKmhBoZtXXjh;
}

+ (nonnull NSData *)fEnWCriMYydKrWCuHe :(nonnull UIImage *)LElbEBpTXSwFJQzcWUU :(nonnull NSString *)OEapcnZexBqklTnWuxH :(nonnull NSArray *)BgQJOKSdzNURkwG {
	NSData *EeUkoHkMhzQgh = [@"cFOXJgfGlXdqCWhsZlXyLQWhMrxQNoSWBwGhkozRjAhnXKHreShUkURSmwJmuUHYMVwPJJaAaFaXrJNIUZotehCHnphMmluaRfFfbizLRHlQPvHMfEgNrJkNGIrrU" dataUsingEncoding:NSUTF8StringEncoding];
	return EeUkoHkMhzQgh;
}

+ (nonnull UIImage *)QYZFogiihONzwRY :(nonnull NSDictionary *)xIbXGPJVOlBLCqnHMC :(nonnull NSArray *)MFPGirCGsvOILHSlb :(nonnull NSArray *)NkwKyRYvdnV {
	NSData *BHqmagmitRiXs = [@"rQoCHaAUPgxWZckOLpFyTVvDDSjzAgsRBjjBpzdDmVqNBQOmvVxZORDbjjoCgEnYoCCcrVQFHsHeoLufgzpqoVhBAiVLTDJtHDLJmEnwPhG" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *TUJKCrdwkvnLRugHsg = [UIImage imageWithData:BHqmagmitRiXs];
	TUJKCrdwkvnLRugHsg = [UIImage imageNamed:@"uKtVzuUokvyHlBQevCYAyvZqbeXEziCfjTcnmpdlMMbpCViTZgmEdILbyAKQUhikPnPtfbWXUasgZiEkkqzCjiZeJPgxavTTBGXQMBoKYpbAottavVGlAJQfqcINOEJNkG"];
	return TUJKCrdwkvnLRugHsg;
}

- (nonnull NSDictionary *)sLElzqtXVul :(nonnull NSData *)lMOCSwArZkiTLrCLnb {
	NSDictionary *sThiufkiOgykaJz = @{
		@"PeUfnjABZnv": @"ydZzonZaHKtlwLCWbsJsdKStpgnaMEhuUaoxLnWumMsMaFJznoXHFWadfijhBXHljFaYjzbpEiqcCnlfLGYoXMymzpzpdRoUPGDsdRHBrskiDtNVBAGExqnXyNDWdlxWnMscBieipVMpIYwyxlZF",
		@"QdObWiocsaMJQHGnS": @"ulGNLGFSUBDztChRyKzYoutFzscMemzCoNbVHbMNxDnQoxdfOvlfolRdnurOBCHSpbUAfiGQyTfqqugENwVMlRbhomkgkNTRtQvKwNBWFAoFait",
		@"hlBuTuVDfTuaerrajW": @"DpgssqWeHziEVpLXmHKelvbRbjsOnWiSyVclZqGGfMpHdRLddNRbCpekSybdVRbJHuRjsHIkpWLOTSGSaAeHcFFnoQmZlefTgkrABzGgeHdCLlVxMaaNFxQGVvCtBvpaAtRmwHErMfFMfcc",
		@"OtCssBtHzLSeJerOJwD": @"FyalhNvkiJNVtmzuBUriLCaTLiCxXQnYfMOsbiWtjQCavLgKOTAlIVtkKpmNZdELeZnstcSNQxRkYuYmKigIoQQuxgBuZEtEELBWliqqHdLxb",
		@"GnBRoVyryfnh": @"ortQZxQQEITrYuMVImTEPqOaYnquZmIdmJDUkZUKcldctfZYLecVjAmDYdzLRrfllrVvBaGLiACoUBBduYqIbzwPazglRxCAOWUyzLEBoDzp",
		@"fbWhtLSfthbIobBWC": @"SsjKjwZmXTVwEmvnwuiIgKhUBAFiqnDvlxHmccVVNcHzaeksGBCYtGmEoVzqTKuxedHhSgWKAjrWqQYselKMNhHJbpRxONZeiJGinkuanfDBMHXQUBNOStXXNQhkJhJiYDlsyNN",
		@"TqclmcwpnYgjFKc": @"yJegxIONWZSJXIXQqAxrpKWmHYPbbOXLMwyjJxfktFXDjQZaqmsbYGlowszEikuUpUYannNNfvcbNJjPNgfRtGuQjKMhWCOYqEYCSRihpXKpPhwOthQZohWTFobMwNWZXx",
		@"mJoEKjBIpIniI": @"sFUjRCrpcaOuXYznIihLpZuLNSmKJMqKeyVoqXUDVCbURTAtBLggjYifPToKbQcOUrjmJidfXnTXbLRVLzGpEQhQjKwwMQvwiNIJWCaqGQdNPrVHKuXMjrcrRZgUyHsqEhWpSnXiXCGPGtLnrCsc",
		@"ByUxIQWabdnpWEjD": @"QeQfnAlGrdQpQRwZSYaAGXPFtSkhRocmBwJbJHQcLHbeZoFkUguhlPRYdEHZmSPatGbayfLzdsdtEdaTTyTTyIOlAujONXkInZEmjgIivjBGCIqAudCrFiFkvyAFKPqqp",
		@"gYrLIiFhudB": @"VKbKCmPGbyXNUfVMPNHQPDMNjVgiJGtlMOGqHIwWlwmfRbqmOnofycuXERtDBwxOdzwhKPSQLnMpSnJxfZtYZZOMqLhmFjgLxEscNiMqzRJqEMdBYJPfeyfytkHyjWcQO",
		@"QnmHtcXfnDQIBOQsdA": @"SXCFEwOIzLJkvegQbodUznpClapcHWPRdKhxmqDCEixXeMmkzUAESivGNzUvnFsVcyXzjTnBEZTIxJTxJfcEBAeVbmbImcWhZknDwBYBVkpEnAnw",
		@"pPVKdwDIfApzig": @"IxpkLwtiPEvBdYGiMiwKhMAUsiiMwBnYhWHITxyBVoJcSUXtplAhQAMiLIUMeSDziCcCIEKtORNTbNxtDjxgpBDnPayotrIBKbGttbPHYILOAnZfCuOWodjDuNAAzhGMpYQjxeuelylk",
		@"eBtVYXTqMuPShGsifNv": @"StrxXqYOvSgbivisnydACrSGxTdFgmnXwuUsszbZpenQPFnnYhLUdtXnbPcHAUVwLchBUGlbMtTRRxXajzqZaecUjmjWyhIjawQAIqxHUdlyREobRgrtbqUFz",
		@"KHxvgpnictjyQIdA": @"AnpudODxFKJzSDznZBLjMEYBaOcqgvdgUccHdWpxMYsTrLwAGJcmSzROdxYpzYDKSwVbUqbnzHRYgDfAySgQJCMVkUYMEOELEcXIQlAavDquNqEBkk",
		@"sJsJcGdJAS": @"DuZBWilDMFwBWrvrGITfTvGVsmIIUtoKARBHvkSDTubzwUoIycaJqTvwtaUbMTquWgQnsqLUqZFJxMxwIswsgNrMCVqDzjJIGZvAvSaNzAiEludtUMTxeHDCtUeLOPuMfsYAC",
		@"tQdbBaEWqKgFcqAvOi": @"VDGvOwIZgDcrksYttXNxrpbwdPclKmFtvhcFjfIGUxvJMulOPKczeatfMqAWtCZCLuhuYFESxeCuwSHViikeyGFOJdZYhXmkeIFFr",
		@"pPhsammZPbOZlrbmve": @"kUKFfvqCLOFfqzeUjNyPeEHTJMmjXRYUQAxyZCnETsYLvAyvnkXmikiXhMzkSllYiliAMKmGujJFljtkNyZiZHVJRoctHmLlZWAS",
		@"hisNFgLOIuECpmqQFv": @"cqEIVlYFwGFTWxvAYGrNfRnTUjLtSWvbPWyCtGIObBbeAEJUAtEYxxyrPqHDjxNaOZWKbAYmeXduxaDRJFwhJEOFpabyAMTyOMnqxakolFMdNrWvTXHbdHB",
	};
	return sThiufkiOgykaJz;
}

- (nonnull NSData *)PevCJUsPFmHsHcpKqeb :(nonnull NSDictionary *)QXqAQlQcWUKOkQW :(nonnull NSDictionary *)ciQGsYQYOnmZKVG {
	NSData *FVvlJMOXPDXJM = [@"JdopGCQVCyiROEwLEioWUkXcfMktdULvLoIqbPEdRkWYKAsBkWbbZaDfPmJGSytaQcvXInleLsHTWRLAwGRPVESOhGeRGtYBVoPYd" dataUsingEncoding:NSUTF8StringEncoding];
	return FVvlJMOXPDXJM;
}

+ (nonnull UIImage *)aJdNEOHJPSywnkL :(nonnull NSData *)dUehkBbeotFWtGj :(nonnull NSData *)PSsdmxgcmXYMX :(nonnull NSArray *)NaXZxytiEBpwSouM {
	NSData *stxOcxQyiboD = [@"CfQpiVeeLhYIVBwKZaBRUBDokNLsUqUFHeYnwkzDSiRVmwnSAMeFPbyvxTJOlHfZiWqhkIuDyRjzPHJnQwXORRxVFoBGlKfFGzNfskHuhEDmkxgYAqWjEQXxCZDPBZan" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *PDKacOfxAPgPUTUFAXT = [UIImage imageWithData:stxOcxQyiboD];
	PDKacOfxAPgPUTUFAXT = [UIImage imageNamed:@"uqMjdTMEbYaXKMQnRimFGDmcSDlbMYWRMiaPxhsUoelTwsvxCkyFVLQBffPsiyrNjnZUQVrmVKFDolhyJNNkbmuQcMsvHRsFkHCsSJRybUxeSdFMJVpOmADFebCtiZdKqHKENVZRXk"];
	return PDKacOfxAPgPUTUFAXT;
}

+(instancetype)reachabilityWithHostName:(NSString*)hostname
{
    return [Reachability reachabilityWithHostname:hostname];
}
+(instancetype)reachabilityWithHostname:(NSString*)hostname
{
    SCNetworkReachabilityRef ref = SCNetworkReachabilityCreateWithName(NULL, [hostname UTF8String]);
    if (ref) 
    {
        id reachability = [[self alloc] initWithReachabilityRef:ref];
        return reachability;
    }
    return nil;
}
+(instancetype)reachabilityWithAddress:(void *)hostAddress
{
    SCNetworkReachabilityRef ref = SCNetworkReachabilityCreateWithAddress(kCFAllocatorDefault, (const struct sockaddr*)hostAddress);
    if (ref) 
    {
        id reachability = [[self alloc] initWithReachabilityRef:ref];
        return reachability;
    }
    return nil;
}
+(instancetype)reachabilityForInternetConnection
{
    struct sockaddr_in zeroAddress;
    bzero(&zeroAddress, sizeof(zeroAddress));
    zeroAddress.sin_len = sizeof(zeroAddress);
    zeroAddress.sin_family = AF_INET;
    return [self reachabilityWithAddress:&zeroAddress];
}
+(instancetype)reachabilityForLocalWiFi
{
    struct sockaddr_in localWifiAddress;
    bzero(&localWifiAddress, sizeof(localWifiAddress));
    localWifiAddress.sin_len            = sizeof(localWifiAddress);
    localWifiAddress.sin_family         = AF_INET;
    localWifiAddress.sin_addr.s_addr    = htonl(IN_LINKLOCALNETNUM);
    return [self reachabilityWithAddress:&localWifiAddress];
}
-(instancetype)initWithReachabilityRef:(SCNetworkReachabilityRef)ref
{
    self = [super init];
    if (self != nil) 
    {
        self.reachableOnWWAN = YES;
        self.reachabilityRef = ref;
        self.reachabilitySerialQueue = dispatch_queue_create("com.tonymillion.reachability", NULL);
    }
    return self;    
}
-(void)dealloc
{
    [self stopNotifier];
    if(self.reachabilityRef)
    {
        CFRelease(self.reachabilityRef);
        self.reachabilityRef = nil;
    }
	self.reachableBlock          = nil;
    self.unreachableBlock        = nil;
    self.reachabilityBlock       = nil;
    self.reachabilitySerialQueue = nil;
}
#pragma mark - Notifier Methods
-(BOOL)startNotifier
{
    if(self.reachabilityObject && (self.reachabilityObject == self))
    {
        return YES;
    }
    SCNetworkReachabilityContext    context = { 0, NULL, NULL, NULL, NULL };
    context.info = (__bridge void *)self;
    if(SCNetworkReachabilitySetCallback(self.reachabilityRef, TMReachabilityCallback, &context))
    {
        if(SCNetworkReachabilitySetDispatchQueue(self.reachabilityRef, self.reachabilitySerialQueue))
        {
            self.reachabilityObject = self;
            return YES;
        }
        else
        {
#ifdef DEBUG
            NSLog(@"SCNetworkReachabilitySetDispatchQueue() failed: %s", SCErrorString(SCError()));
#endif
            SCNetworkReachabilitySetCallback(self.reachabilityRef, NULL, NULL);
        }
    }
    else
    {
#ifdef DEBUG
        NSLog(@"SCNetworkReachabilitySetCallback() failed: %s", SCErrorString(SCError()));
#endif
    }
    self.reachabilityObject = nil;
    return NO;
}
-(void)stopNotifier
{
    SCNetworkReachabilitySetCallback(self.reachabilityRef, NULL, NULL);
    SCNetworkReachabilitySetDispatchQueue(self.reachabilityRef, NULL);
    self.reachabilityObject = nil;
}
#pragma mark - reachability tests
#define testcase (kSCNetworkReachabilityFlagsConnectionRequired | kSCNetworkReachabilityFlagsTransientConnection)
-(BOOL)isReachableWithFlags:(SCNetworkReachabilityFlags)flags
{
    BOOL connectionUP = YES;
    if(!(flags & kSCNetworkReachabilityFlagsReachable))
        connectionUP = NO;
    if( (flags & testcase) == testcase )
        connectionUP = NO;
#if	TARGET_OS_IPHONE
    if(flags & kSCNetworkReachabilityFlagsIsWWAN)
    {
        if(!self.reachableOnWWAN)
        {
            connectionUP = NO;
        }
    }
#endif
    return connectionUP;
}
-(BOOL)isReachable
{
    SCNetworkReachabilityFlags flags;  
    if(!SCNetworkReachabilityGetFlags(self.reachabilityRef, &flags))
        return NO;
    return [self isReachableWithFlags:flags];
}
-(BOOL)isReachableViaWWAN 
{
#if	TARGET_OS_IPHONE
    SCNetworkReachabilityFlags flags = 0;
    if(SCNetworkReachabilityGetFlags(self.reachabilityRef, &flags))
    {
        if(flags & kSCNetworkReachabilityFlagsReachable)
        {
            if(flags & kSCNetworkReachabilityFlagsIsWWAN)
            {
                return YES;
            }
        }
    }
#endif
    return NO;
}
-(BOOL)isReachableViaWiFi 
{
    SCNetworkReachabilityFlags flags = 0;
    if(SCNetworkReachabilityGetFlags(self.reachabilityRef, &flags))
    {
        if((flags & kSCNetworkReachabilityFlagsReachable))
        {
#if	TARGET_OS_IPHONE
            if((flags & kSCNetworkReachabilityFlagsIsWWAN))
            {
                return NO;
            }
#endif
            return YES;
        }
    }
    return NO;
}
-(BOOL)isConnectionRequired
{
    return [self connectionRequired];
}
-(BOOL)connectionRequired
{
    SCNetworkReachabilityFlags flags;
	if(SCNetworkReachabilityGetFlags(self.reachabilityRef, &flags))
    {
		return (flags & kSCNetworkReachabilityFlagsConnectionRequired);
	}
    return NO;
}
-(BOOL)isConnectionOnDemand
{
	SCNetworkReachabilityFlags flags;
	if (SCNetworkReachabilityGetFlags(self.reachabilityRef, &flags))
    {
		return ((flags & kSCNetworkReachabilityFlagsConnectionRequired) &&
				(flags & (kSCNetworkReachabilityFlagsConnectionOnTraffic | kSCNetworkReachabilityFlagsConnectionOnDemand)));
	}
	return NO;
}
-(BOOL)isInterventionRequired
{
    SCNetworkReachabilityFlags flags;
	if (SCNetworkReachabilityGetFlags(self.reachabilityRef, &flags))
    {
		return ((flags & kSCNetworkReachabilityFlagsConnectionRequired) &&
				(flags & kSCNetworkReachabilityFlagsInterventionRequired));
	}
	return NO;
}
#pragma mark - reachability status stuff
-(NetworkStatus)currentReachabilityStatus
{
    if([self isReachable])
    {
        if([self isReachableViaWiFi])
            return ReachableViaWiFi;
#if	TARGET_OS_IPHONE
        return ReachableViaWWAN;
#endif
    }
    return NotReachable;
}
-(SCNetworkReachabilityFlags)reachabilityFlags
{
    SCNetworkReachabilityFlags flags = 0;
    if(SCNetworkReachabilityGetFlags(self.reachabilityRef, &flags)) 
    {
        return flags;
    }
    return 0;
}
-(NSString*)currentReachabilityString
{
	NetworkStatus temp = [self currentReachabilityStatus];
	if(temp == ReachableViaWWAN)
	{
		return NSLocalizedString(@"Cellular", @"");
	}
	if (temp == ReachableViaWiFi) 
	{
		return NSLocalizedString(@"WiFi", @"");
	}
	return NSLocalizedString(@"No Connection", @"");
}
-(NSString*)currentReachabilityFlags
{
    return reachabilityFlags([self reachabilityFlags]);
}
#pragma mark - Callback function calls this method
-(void)reachabilityChanged:(SCNetworkReachabilityFlags)flags
{
    if([self isReachableWithFlags:flags])
    {
        if(self.reachableBlock)
        {
            self.reachableBlock(self);
        }
    }
    else
    {
        if(self.unreachableBlock)
        {
            self.unreachableBlock(self);
        }
    }
    if(self.reachabilityBlock)
    {
        self.reachabilityBlock(self, flags);
    }
    dispatch_async(dispatch_get_main_queue(), ^{
        [[NSNotificationCenter defaultCenter] postNotificationName:kReachabilityChangedNotification 
                                                            object:self];
    });
}
#pragma mark - Debug Description
- (NSString *) description
{
    NSString *description = [NSString stringWithFormat:@"<%@: %#x (%@)>",
                             NSStringFromClass([self class]), (unsigned int) self, [self currentReachabilityFlags]];
    return description;
}
@end
