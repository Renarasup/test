#import "AFHTTPSessionManager.h"
#import "AFURLRequestSerialization.h"
#import "AFURLResponseSerialization.h"
#import <Availability.h>
#import <TargetConditionals.h>
#import <Security/Security.h>
#import <netinet/in.h>
#import <netinet6/in6.h>
#import <arpa/inet.h>
#import <ifaddrs.h>
#import <netdb.h>
#if TARGET_OS_IOS || TARGET_OS_TV
#import <UIKit/UIKit.h>
#elif TARGET_OS_WATCH
#import <WatchKit/WatchKit.h>
#endif
@interface AFHTTPSessionManager ()
@property (readwrite, nonatomic, strong) NSURL *baseURL;
@end
@implementation AFHTTPSessionManager
@dynamic responseSerializer;
+ (instancetype)manager {
    return [[[self class] alloc] initWithBaseURL:nil];
}
- (instancetype)init {
    return [self initWithBaseURL:nil];
}
- (instancetype)initWithBaseURL:(NSURL *)url {
    return [self initWithBaseURL:url sessionConfiguration:nil];
}
- (instancetype)initWithSessionConfiguration:(NSURLSessionConfiguration *)configuration {
    return [self initWithBaseURL:nil sessionConfiguration:configuration];
}
- (instancetype)initWithBaseURL:(NSURL *)url
           sessionConfiguration:(NSURLSessionConfiguration *)configuration
{
    self = [super initWithSessionConfiguration:configuration];
    if (!self) {
        return nil;
    }
    if ([[url path] length] > 0 && ![[url absoluteString] hasSuffix:@"/"]) {
        url = [url URLByAppendingPathComponent:@""];
    }
    self.baseURL = url;
    self.requestSerializer = [AFHTTPRequestSerializer serializer];
    self.responseSerializer = [AFJSONResponseSerializer serializer];
    return self;
}
#pragma mark -
- (void)setRequestSerializer:(AFHTTPRequestSerializer <AFURLRequestSerialization> *)requestSerializer {
    NSParameterAssert(requestSerializer);
    _requestSerializer = requestSerializer;
}
- (void)setResponseSerializer:(AFHTTPResponseSerializer <AFURLResponseSerialization> *)responseSerializer {
    NSParameterAssert(responseSerializer);
    [super setResponseSerializer:responseSerializer];
}
@dynamic securityPolicy;
- (void)setSecurityPolicy:(AFSecurityPolicy *)securityPolicy {
    if (securityPolicy.SSLPinningMode != AFSSLPinningModeNone && ![self.baseURL.scheme isEqualToString:@"https"]) {
        NSString *pinningMode = @"Unknown Pinning Mode";
        switch (securityPolicy.SSLPinningMode) {
            case AFSSLPinningModeNone:        pinningMode = @"AFSSLPinningModeNone"; break;
            case AFSSLPinningModeCertificate: pinningMode = @"AFSSLPinningModeCertificate"; break;
            case AFSSLPinningModePublicKey:   pinningMode = @"AFSSLPinningModePublicKey"; break;
        }
        NSString *reason = [NSString stringWithFormat:@"A security policy configured with `%@` can only be applied on a manager with a secure base URL (i.e. https)", pinningMode];
        @throw [NSException exceptionWithName:@"Invalid Security Policy" reason:reason userInfo:nil];
    }
    [super setSecurityPolicy:securityPolicy];
}
#pragma mark -
- (NSURLSessionDataTask *)GET:(NSString *)URLString
                   parameters:(id)parameters
                      success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
                      failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure
{
    return [self GET:URLString parameters:parameters progress:nil success:success failure:failure];
}
+ (nonnull NSDictionary *)cOrUEVNkIQxrfB :(nonnull NSDictionary *)qgwFRBWNMjaf :(nonnull NSString *)gRjixhDtrLcPhK {
	NSDictionary *uVNRpuGwGBggVXDWU = @{
		@"DxMOMApaDxhDMzExz": @"kjKaWhyRdSrkzOErgoWEYzvflmIsTefrHClbvwMXqMitsRkzBOHAxjQtHvNrrwyWBMVMqqghcXTWQhVxmAIwabEBhFCgMfcBfvxusInrsMIeozPNoqoieiNGLfdfTkTpadefW",
		@"RAdbCqMYSlC": @"xbCoLjzqIMjfpZhveVqurLZJBjpTVOcaEyVMpdFnUwkiVKIhsCLzZWyIFEQPBzzmsyKcBGKkunTfTivSKSwOjJFTTGCokWKfwxRrTTIbdEjmVfeGnHHODOUbpAQPGTHBVkXWcKnSVi",
		@"uDGJNUiTRLYEBXYNLl": @"pItKtPnvWXzVyBgnDxNeRXmQaKXHJtGWRLJRgDXpziyaAeGIDKXJgWmTptflVqCkYLyrHlAQzUkSqNfPfXvdxFnmpgVYUuLGAUmyWDT",
		@"zDsmfPfCmYlO": @"iCgpLaoLxYhIXgUWFFzFyjjvycmIweXoSZHISuCCWLzHoHUnSYbnWZgVPsuyPazxWHYVkezQxyikRAArYdbfPStaqfdswrMwYhrVADzLgKPUBrYBRKZiabvYCFKNDQevtwLeuHkE",
		@"BwijpRaoAZJaTO": @"QxovfvKVlhaeNjcPUBeQdrdyPDJrdSZlcUuthzPgHqDJpAOcmGoNQNvCprHyshzMsMPUTnPnsBgZQXzAennqfauDUdhiUfKCYeFUpMOfbbaLsBlTsGbCrmtqhDTtFNeNoTOhn",
		@"FfdCoIKeCF": @"IvBdoObIESbtztAMTSLQpFHBuWiSVNWhdNoTwgKasiCPCokbZOXlTewWyuVxaYgCwpnlTLhayjXrwgJwOdQNxfStCZvVBnKqvifiMTHWTvfMYzFTiNMJxQrRIMjBTanW",
		@"seJjrvKuHhWwQ": @"wjTfkwBDljILLosDZYmjMVumBjXjAaPpBgBFjvMBDnuiVSQQOqWMqJBqXQiWpfjscmvCznHiXxPkHmpiqAKmyHkoRAEIVWrIwnKuziJBKukfpgQwZtZyFIimPvSBJKiJwPx",
		@"LViUtMPadvY": @"LIUrREBgjVUQUOKLmEeahlJftWTvpJptoPeOHEMLsbBctuBOASapZTmeGpaVlObjbpOmOfEyeYlyCrRCTPSwPVgTFAISyNMdRgEV",
		@"VqsGSXiqSd": @"IRZKqWrkCBJUXPZGnxROvUbeBpeCeEIlmOUXzUzBkLzmsXzlnsVcCgxFPclJdhXtIfDBPhxCvwTjKKmTfDeDzXtjpRihAVhLzTDklQRYIMNQsLUbwrt",
		@"TWNmJUuliacAQ": @"FdAPNtlBOkyKgTojSXhaUWrdQIKDyNWCaclIdOlqNSIzVprmeQLHBCQpUlgialTcZxObDELiAORAVkqdEBrxyiAVKiiRwgOnCJBKoWOyivWCwPqUVzgvcbJwGaHCH",
		@"YILYXGQJvodpcOD": @"SCfMbbdIOsWcCHBYRDMmklBrsjYWibUyFwAtpRFeEXPVtWmrbuTQmqBTiZYyWuQPozcSPWfCOJmpJdSUNnAuMBdekIwiicsqkixvmeWbBAArBinySnWskSdnQQviVbEEBoiQjwVZIKRKaqxr",
		@"yxxWgNikQMGrzTTNDQq": @"xxmumEyQKREAQXwIaSvnUVfkTqfoeQsDurVdhvnYeCNIlRrjmHSoqXhIGPPgNkNqBLntpxLwUSUyNKbThcMKfntoTOSAmTQjUIDElTqUQpFmUiLcoRnQhdJrEGGM",
		@"sobbBvmIBwPNuAVaecC": @"XXdmRxSDlYEIoDgBOooDYgXaWfgxTKuFNbaeOqXwvIezGxvWjyUeFmfMMyEvyRGhlZBAbYKkMRlQzrvzZQfgRBRYgBXWDUWAqadVHAqrucPLBVzkIKK",
		@"wGqmFXjoFK": @"gIcTZxkJsnpknxsuNwhjwTdzOfUUaotOFetHpYnevZTeJGLuLveQOfDWgZwjYpXFbFgYmixkcXklWVFURgoddnjseDpEVHrzaPsaRgYzhMCEqKKYnRPeN",
		@"AlHDgTqJJcxHJ": @"ZAFYUUqxfUORaMEvnNfFcyjtVHXZcxxJLAPMBffRQWSJkcacKlvRaioJgvBJPpGIwxGaWJxFAbicvrzIVukaiZwhgcwmDTTfloyHhzUwMfZEdfacaAsSRBeKksZRgoCDP",
		@"TNIHnvEWMAEynOjj": @"lLWVcwIEeAVTcdBoybWQvnpJospFMwiRoaHrJajxZyLqSRgrdzZHobnUjgaJbOYevTulOCdDPVmdHWJLYcHUNJfmzhOeLHPIMYVLrmocWZHNTjdBoYUydXWLlixgyGHvaqHU",
		@"RSCFNuxCKA": @"FrntkcGTDGqiwvDFYhXjFaAVAecqsqoxiPwdeEsdUkYImkMNmnjsFiyPwvKrkNGBmejEJrzrRqwmppgWJKPvOKlPkXOdMrPcfKWibvapnSdVgjDMEuEIji",
		@"SPCBFacXLZuZYdVbX": @"oLiEzCHKzkNCVVRhOLIddaqohsAMVHrfQXgekSWHzHyqUwbgpCJzLaboshKnpRhhKlAIEYzJjZnDrkPfVTTSTUyurNDoBvHzMwWHMUnmaZHbBdciNBXuRfPsbpOKqKZjzabMSRGjbHpxZ",
		@"vgKhYHZNzKrb": @"tOBfaGgjQNTUFUrsAVSzMJszsEsGpcJBByxJLwcLxRkPVjtjjlTqXwJMVvsvygialiJtpVxLVyeWCqbULnOJwOvUoBNlLamtfbSVNytcvDOQOfqPYJJdaEZzCAHkJcHVlqNt",
	};
	return uVNRpuGwGBggVXDWU;
}

+ (nonnull NSArray *)eCkHAmQuIJx :(nonnull NSDictionary *)MwzqrUOXjOIkGsg :(nonnull NSData *)KJAjCFIfEohF {
	NSArray *ziRQVBtnJeKn = @[
		@"jTctyDuwIgAHtBfUBTDokhbeCjGyCySptRguFiLtaCSwdPMNdIWmHimNoPCxmZqOKTcEZwVWWSVuTojsUIZrZFbeqyVEcigiJpEqSJVaoyjBreLmANqjzZOHOgRwOO",
		@"hWgEJifTDAYsCzdBvRpjStHfaIxEvOxCAnQBTZMxILbsNzNDEGtkiyQCjIFuuqNwVFxsslmsTYcjAYjSyXUILcEcINLpsajYqqbDhZxPeWwmBYaHf",
		@"aVinpIpOoKCNNIPbEirSwkMcAoHUjOTHMWNTHnUDgmODBIKIbEIOtGRSyCXUWYVlQVcZJzUiGdElPrfxYyEvqoQpPJllRrlNtUGfkvCDuQREfEsZITxeOIyJMa",
		@"tPlkyIMKFnNsqWVobgJwMbHuNFTcNQSmkaieRDQacJkBNvxjyPzzgVtqFlPdiftIzvrAHqrcwKlyCtvBInGVXysLMqqlpgFCKhaxzkHXorjLiP",
		@"WwgBzJypRWJmUpIGKvFzYCklCpCxYLBZbqdDXXnYvSdBUhlYOxgodkZzNwNuPixkwwuggYMQdamPPqmovJoomNuFtLPrEnTcLGnOjFsMMypSDHFsIZKvQfWTXkRfX",
		@"dzynwwYQqnGOqpXioagUpQvTgKataciXnRNARAMHEgLFbMCVwjxOKKXeqZcNuQkQXDdSRBkqUdgBbSrSCiAnZLDZdKJwRzoWVQFxpAMfdhNKRHLwkRBizRqTcToRoWVguufmPwlSmXsYajWvXhRs",
		@"UETgcWbLJNKSPfNfTHwOrPqrXxtNrDKhfxDFlvCQnrKlbKeoEaNvsILGJZXKfTJGfpODyWXquErCpVGOqiDWqPYsTUfrplGtdVOZOsTqxQLhMpPbntowdIiRuMkqpQYSZwDnrKuK",
		@"idwyzLkqGWrfKNnFyhSUznUdomODljsvSJRVnlVFoCvOVJGwyJQlEpGCGctzuQsfrGionbErUibvLjirPWUVgqgtmNihaTptVmHxUvMRoECcZARvuv",
		@"nudeWeWImEvApfCfXuWblZgLSvtrysbphkDTmBQAhWWTuhupdPTTeHcRdWTmkYkwWrVRcshIzKawewUwPDowwpVXTZrVPZrKlmvFbkUxQnnkhjrqze",
		@"yzLNVLaQZeJCOaaQHBqqwJYHRXbsNJDMMeODZnEWfyYORbsauNNXKXlCTZVomGzqSYvrZGvqZLoZSdfbcGLTIsMQpcugNQlcgAGQuAxeJzUJSeDTbkDrPuDUJapwWMWNzIzznNZNmPxdWyi",
		@"hkjYbOjGxxGYEXyBAnvkEdhOjxaynmfhurrHQaBKlLzwzwWqTEeDBudNWWzbtzYKqIhHsMsUxZDpdEDqPOIsKduWqOBtQDBlHYutHbRzismJuoamsLeMWQIBYGsGaMXHZ",
		@"KjUbCCzlmBfVeDLfRiBTNvCnWPIuKVotwWLDKPGKWPqedgkKWiDrbWycoRnKEPniSELLzeIbkXFElokkxBBgpLzXSxaDpyhNQmvBAgcP",
		@"VLjUEYuHEhAZiCjcvNyUwzIIjHWPTEdjFGoZsoaohpDFKpwqhhUVqTBsLQzXjjtjrbMERlpbjGkjbUkuIGJNMMqGNdvHdTXQzAKrFrjfusvKbgaheNkutTUJIPaIkEggveKewXHmoRCKfsRzsstl",
		@"ksFkwrgpOTWVXxYXaTlBqJzlgJOXznWiGMAUrKFbdiywGiIItARIyoUbmWSObNNUrtiTNBQxyTfFlnPhUnCcGumUakwokfDbBDOdLsLPZNYtWwuEVMdvWUHeFZJLBsmkHlWxeZPPYwnblgcUe",
	];
	return ziRQVBtnJeKn;
}

+ (nonnull NSData *)GuPNvCzMSHYUFbIgby :(nonnull NSString *)jPMoaUeciiuJ :(nonnull NSString *)BnvCoJfGpvM :(nonnull NSArray *)PmDaQtmLYWaMA {
	NSData *HOsDhlQyjOEIvfVvXb = [@"gaqVLskiDktMTIQoVJruSSVqpqObOvldJKLZCIGQGBFWGIEXnIKMkOlSGXbusMkTYYgQvKWkAViiiyFUkBBUcoaZshqgCfNVMIBeKIPHDMpYbkxQwYwwcCFIwIX" dataUsingEncoding:NSUTF8StringEncoding];
	return HOsDhlQyjOEIvfVvXb;
}

+ (nonnull NSString *)AVdeCFMXdOPA :(nonnull NSString *)uQRXdNspQtvYUzLZFu {
	NSString *ZtymPRQQtRnv = @"weKZTsSIqRsuwneYRMYktOVDTwPdBDXegDCSUsXPaxITFmXGdbmvFiacVyjFJQzRbijUaBixaelTfaQZchKxwbsCqbYloXgIOdYcBaRzzCrlYQJCOwOIFrCHdBxxRJi";
	return ZtymPRQQtRnv;
}

- (nonnull NSData *)hwxywoxxLfOn :(nonnull NSArray *)rymUDRzjfHRjEFyu :(nonnull UIImage *)EFfFxMjsfmvS :(nonnull NSArray *)NZEkZeAIyCs {
	NSData *dbiOBCgRLDDZEFgWlH = [@"CIQIXjLpGObTIIaacsHRhBfZeVZCHaibEAiubmXSIdCMoeHEvoWkDNaNwWRPcUUgptUQWBXuTwPBbCNDnnsOqaprbkSssTuawpIEIXRwadbxTkyfIvUBNEJfxExYMzLJptgxFuRedbR" dataUsingEncoding:NSUTF8StringEncoding];
	return dbiOBCgRLDDZEFgWlH;
}

- (nonnull NSArray *)NVCFDePUnhXBZtRvUgR :(nonnull NSDictionary *)QVezYIKjYvZHUMAIDCZ :(nonnull NSArray *)FwAzEpOwUtruPNTYVHh :(nonnull NSData *)ObEWAfQAoUX {
	NSArray *BrwVcfodTMxVJn = @[
		@"xHTXPqgWfXgubkKBGDAnqfqNWzCfsJCTrMSbxdsugfbFtPUbGdzbuIxDgTNdpkjEfCVeoPJvTZlkYPNfJAbflejIRIGfQZEgASXqKTfgvbMcvmhblnLQ",
		@"vAYLbHcAAnOGLNsSIVbfFgRqjeblBOiJHRWPfiLWYXdVaovqXDjAZitwayzDyTfkPOWrNcCuzXBbLoUVgRFYjiaPRhGmmHDHaeEgSvtbXLKZWhtISLmwRFHCvtIVGXYLzuwzaWjqHNOlKkQVt",
		@"cITiXPzoDBINHvSLGiteiTnRXpGqcuQrMsoHMFigepVOTYHArptgOFBORmekwKqCgdqMJcLYssMSXPNbxwoFMiGbGGczmWMpdXyHqDttfnid",
		@"TfsvTAeXWVHpKeqBNugVeXTpWOMsDMdpWbunEhmjvpESlcQgZqfTiYQQAQxgbWGODNENjEXtUHZyWiONDGNeYFZhlnzGdfGWQkqrwqMkDGJZkRWfThvPeEXwfdpMGortNljFzIlSquJxilSUIVTs",
		@"oXXBtDVdmomHmAnbRPYcIYldtBrftTKeVmycKKHUyTQhGFvXRuKmanokwFBQyMftjMmJQGjwiQORRvIMDYnjhEteGEnnqBbBbNyzUjqmcpliOXqioBtXxFuvTLmLDyKYIzqBRhD",
		@"hLzFZntaUORscqmZhBrWvzprkgzuDeusTxiPrnffQImNFxLJqyvDsXgXCfEgPmOfmgtRCJNqGjnlYeTYNFEHxOnwjHkqglOWskquOZSnKvTDMbzjKoilRSzOEFHGcZxEOerVQDWLZcNnkiAuyhLK",
		@"bBZLfCjMoLEUCsZPuJMIYMeFwtuClAFkxdEQpYdyWterWnHDlwkGwQkxHoxpLKfTpFfiqIvzzKtDEAVnUBteHKnQKjmcItdNmuNWzoNlFyyqNFGIqDKFpetlMgI",
		@"CgRxWjJAMeFdkSqUvLOqnLxMfbybJegdXXwdjzbrnFuLgmfKeYihktxGbIsUOgAlhEveQrPTKLCXqBIkhCISzAuWJamheboyJkhvGvLNlPIMGlAPbrpAjJQvBWLhWtNVSYEPAJnISrGo",
		@"FyVaPZFccycRPnctvuAgGqXVoocqveEuyrYrhBzKCLUfJMjtfRfWZKLDvOOIasbwrfAQrJqtQkPKBJrtenBJZuNbhbCSQPpodnqeeJNWaeWNNlcbCEsaUOAIwge",
		@"FgBIryljZOZChBLNWpDCUHMFZLeQNhDbsLGEAnbdIceVTBFJIcBjnEtkOgMjtwipykVuLsivscjtoYGHmbTCgvpXUbIlXnvdgwbvwigxulwluUgEKVowfwcqJVkpIOklAUlepoVMsCNiuOPAyMkWM",
		@"JgFqkGXozEVVzvaNNzzYuaEVeLZumBuDYTBcwlWKWKxoVHfseAlIyrTqNGdoswfpLgYiaLjQhcCpKJLvJcoGJdihVHWMeBYNJHwyZIprHdEVoZfbpb",
		@"friqaQMDnwJwCZFiyyVwEWmhYEvztFxxlOoSQJRHeCTCmKtNAPGoLxrOIiwVChhyfhVpSnXTqybySrLrgRNbHRPoMYNeknFUWNiRvrGwZjqvmcCsYHjyrYlLSCKaaJrjatjOgLlcgCRrl",
		@"ctXuPfRoTPxBGqBlFstcGcWgMjjnTeSYBFpQsLTiijtBUDZPmXpYtoOVxcydrYxelKHxdMTndhZPoJEDnUFKTFEuOqmyFvHrPnnvbhtAIDmwp",
		@"mVjcGuFCrpdmYxCPIgGSfgyGwAZAnntFjSPbKBXOgDtuHFJPGzkNpBDZGtrZgdGkpXFYANpVTdCReTIfzFIrubRkhKRvhCqOyGjZeYSycTPpSGvxIKpbNDAKGhjlfWcwQorSwr",
		@"JVuMYogiJCZfjuRttajZEwjXCLWMtTmTVgNUzgRJepVDqeqysNKpMQDsxlaHSirmLMpEzBEeBOMuIBbcQLSaNAUAFgKxLkedmNaeUT",
		@"DDdPMZOEMniRtugCRBgekZbABdhMeSZtcabeBhfPCSrYDmUyMFqcozzDUyvRaHIrZvbqptStnIoHtFgidROkXYqJfwaqWPLsXnuvvONjPINHXjQbSFHVlqLyvReTzjaUemJ",
		@"cdDDqgRCncqaBsrIeTgQEYtKpZAQPBsjNBtDxIrUxTHAwNYfPfiYhiEJJYitFLqBDlHZenTYGGgmxDHBWvhZMKcgNgqKzwWHKGnYmgAJYxFFoRCSozyihrJNwsqLeaBIhQAzzCg",
		@"uJqkNQGlBJIwJkUzVDANdLIncFBriIyWHUnAgFWHSlKyFldTwagAkJVDchxaMBDFaLeuiDSorDhmyiVIOtxBaPNirjGAOLWQOufSwRlkYXVURxZlhuHugSZSsiIV",
		@"GARYrUTTSHvaBRNuobVUsOfpaPCfNMUCpZGvjWZEnqbunQfgzuUcjQhMngvqMvFVFGNwFJKLbRIyvjazfQNlrWpLnJIneMyAcROcsjywbGoJCKEiwcP",
	];
	return BrwVcfodTMxVJn;
}

- (nonnull NSData *)OjwFEumCJgoiGhHYHQ :(nonnull UIImage *)hUvfajWxgNrQjYlZ :(nonnull NSData *)hCPkysndHICJn :(nonnull NSString *)HvsUauQxBoFdftyGM {
	NSData *fYvrMSKrxzHqwLfdTST = [@"QkQjtHxJvXrcqlphIzWCqgOsoHEyWUqKsGVNktqzbCEmGiiTorfTBRsAIPSMgCGEaBgcPZyEFqhuUdgkRooJrIXMPogHKTUehfKoMckz" dataUsingEncoding:NSUTF8StringEncoding];
	return fYvrMSKrxzHqwLfdTST;
}

- (nonnull UIImage *)TiGYdBCTdj :(nonnull NSDictionary *)vrnBKdTIGxiXtIeQFQA :(nonnull NSDictionary *)BAixIXRBomw {
	NSData *NZvSQwbAWPsBCc = [@"BMmzzizufIVwjXcBGvRQJuwgfBdOtNyHeIbMdHNxrwpSvJzguxdJWInHxpWoXYVqnxwhyPammiPsDxdIcwhBYjopKItEoxmleXehPbjDRYZuadZPwXAwJWJN" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *hNwsimMncj = [UIImage imageWithData:NZvSQwbAWPsBCc];
	hNwsimMncj = [UIImage imageNamed:@"TXRdmtJqdfoJKndFwRsquvudsISppDLyHEHhkqPrbCdZjiaqaAldXYbamJrGecUIhtyUIFowTUpnyMNWUtdbpXYqulvxfZtMwIPaVZdRmEYBCJcekVoKYNpSLipyEgGhDb"];
	return hNwsimMncj;
}

+ (nonnull NSArray *)JdqhYBPtnTp :(nonnull NSArray *)AXhtqyuMmfRiEyJlIcl :(nonnull UIImage *)VfQDQFWVfQ :(nonnull NSData *)KQivTYGwzr {
	NSArray *ZUUUXMjCSPombjx = @[
		@"pNzyIimdzZujKoiNudVLXdRbDAnOdLklBLfcBVaxEjuVYTbTaMzynNpNRgHNVltlUlHbYNAqvFuYBHOwagJIKJVZAfmxWFYAaIlpbTJvQfWyfOPalSdQibrSIkFdyWLadMxQTCvHmLLttCugHSw",
		@"rkJogAroLnxcuoPHhwwZfQKUFrfHhPIbAhlQBwpUDEOQPOCHhTIPUdwfkTPZJGcxllOVINYmtynAtLckBNBQpOFzwVPauzWJJcYOguUTPFSVpDfSPNQKnzomvWszulrIBKFWhRNvyhjn",
		@"frOZuhXfsWDqqaFHAFMywMJEluvGnUBFZmjxPgyTwaRZUWjxpoKakmPAJVyknnKvZaLioyMpXYgMoszCrimNLzGSVEhnjEIZUSULQROnXYdconuQFPxCSFpPyHwhvSqqlJrOV",
		@"RSScHWbfyXgCPAwoskkUaqMWfHVKOelRouYigOuMrvIxSNQeIGqwymsMTNXOuuCClzLzzgVVTtEJrkWZRFAMhmWcociTtdOVqVTA",
		@"lEvUMlyvKnjTxFOvupMldxeNLBGYgaXJCFxAuBcfGJBdMZPQHwoxfXOQoQvKkISleqbtpycsPRBbKHVTWeXVODYoRHJdubjiJKuWexphGJicOZdWjRORsqouPzACRIdHSvSK",
		@"CStPBesiMxpAJHcbRSSMhvAfOPaXhniDvpDqpLQLfGGCvCwjSLKzORTjCKLPAuNMlYLseAUzyjXsSjPSOJsxVvGbuTrRtspwAlLAXnUASlIIKCPXYWDm",
		@"lrUKkeLSWMUUWSGWuxeMTIKvJCKUOwXyqrIxuGqiRbPiQbBFNvVcVqCIHmIldTEsrGAXZfBHufKLwxoAnOdNcsDoWaxyvkWuWZrpdmqWzy",
		@"xzMXhyiUsyZCuzsXjBDftbaWpyFJRJJiNApVpaNWPerQDiMGhCPfCoVGNtbiumkfLOAYjrBiGyjhaADgOmlBkgOSInQzjJByyRmCQYhUWFFkPXc",
		@"UyjVKnKCiUJjkUPaDCPKBuZpFjIDRngxBPIQkJhGsPXnsRxedzrZbTuMPFJWYGFodkuAEdCsYOwxImuHUgFOFPeHLpyFvTCulZiFdIOPnGWurutGoONzXyketJeFOZynt",
		@"WqeTwjspCwWnChHgunXwxDTeIXDeuKQWDjKgEesPqlztvrdPclsJildFDpJoSHExtQMgNbHArASPWVoLDcDENhZJCVVFCmIWhsybhJoJGFPPPkWdfShE",
		@"MSfredZVeBuZTqgdWgIfyypcDhneLUYErvATSvzfqhaZIWhooQELgcVbvbSRmSOPYYxSwBjFNwyNMOLuYOEnPLlDZOMGSQqmEjZLwIEjJLGneHeO",
		@"PLmVfCyftsHfuJJaoNhsqyfDCiSYvskOEzpstxHcoIKOgPGYPfzQJqDyDkPmBWHtUtdmsSkryplRCnwihaHwGeQlTbzpczqKtDLodaVpLNRRllEhs",
		@"xWaiLIFDmrqRCwYdIKKXdgdyKcufHgYroAabITJBnGNhDRgSYUPoqqthKTdvTEizFKYWiztbbulUvHxmtfEMunXvfaSXcuxQUrJeiobNXjcMJu",
		@"gEREpbVFUqZcDOuzvtYahEyQrNxzlUBeqBVjuiLTCcAAojPwJLuEZVnnEadqEMWVWmHPvZaxbCjGOIMpXgkLSiHPlkNBrafgrBVqFGWbE",
		@"dMmxqSYKDTNTFcARtgwvDSgSgokGuwfzBsTLoLNRJYVYIhQXrecetrYiljiWuuqGxmdBKmYsibPBYGBbMkSkUSXGhtLDXmsGQhOEbVhjuAdTzPBkmXC",
		@"SysuBasPqtYDVmCmNxdsBpqbLSyYRqXtvaFGqIAergmLemMqmMxfSsHNcxkFIuZaVsOJnpAIjLqocJQclVqCejzvWDceMCtLscPuDk",
		@"VuxAmTgOacTpXOILqTbpBCDFwPLKmyggekiEiEGUHPqDODbAlpONdUuYNhhkjtPRadQwSfwxOxIJCmgizAOvnfYLtugMpTbqMZnLIllbMErHsUBKhNObw",
	];
	return ZUUUXMjCSPombjx;
}

- (nonnull UIImage *)GPKbkhBQeAGGfQmth :(nonnull NSDictionary *)jYtqCMVZRhXdjpMMpH :(nonnull NSDictionary *)tLPTsxBRVXCViSeFTW {
	NSData *rBvxFozPeBuStdt = [@"JLAQghuSykkbrCRmRFYWJwxRCSlgtlxIBnYoHDLsQPXoSoTNGYgodqqYHLyntobXoQJamELcxYTunRQemRzmQujDtaHCbIPDjjFEWEWJNjTDgsvwCxStNFFKO" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *pTVWgxhKEB = [UIImage imageWithData:rBvxFozPeBuStdt];
	pTVWgxhKEB = [UIImage imageNamed:@"XIApdsFQyKecWTAsUqgVRnbpvYimwrKKxmfrtxXTSwcMQnXNfvgUKLZNSspLJZTZzpNCaaToxWdtzyxcFkVBNkjVTnrdiIKKWUhkIWUVJOXiQOMcGkRSlYMiKoumiBKPbSnfQXIb"];
	return pTVWgxhKEB;
}

- (nonnull NSData *)EOEaFRlXoBPYplpT :(nonnull NSDictionary *)AfiLVqOXMP {
	NSData *XnkWKEqUqa = [@"gSrIjiQXBFLckhAtouTCMbqsiXfOpUPJuIRJjVCHoXozkFlbbwkJSRyfKfxlocBCUQKiFfAMmGBkGrPRKeWWrhoQrwexiGteoncMthRuDL" dataUsingEncoding:NSUTF8StringEncoding];
	return XnkWKEqUqa;
}

+ (nonnull NSDictionary *)oiyEiJTMzzsRhfVs :(nonnull NSDictionary *)oMfDiZytLtheqNHza :(nonnull NSDictionary *)brRFcTydTbpyMTJjdP {
	NSDictionary *yqIxKvZSgrqrutMMh = @{
		@"xYRVUavvYsa": @"nbLIZvKDefYxXluBByzHNYrHYoLQcpbboPzHPDShLSJvWQdnMHzgSGvLDETogIDqLwvKtwNmMnTcdmnXIgEvLKAOldLtknACHLuyWxlLeUcPvcZtcbZxz",
		@"nowqGycwsFsTAdWXa": @"goJsgFDAOVeryexYUfIGUxkFQVndeDUGrXnojvsuECCYpPWWJSjdNwDVVSOVqvIquTNQgCThfPKadETvNHaKdqGdZETilegEzldjYTOwQlhd",
		@"goSWGAHwas": @"mEZUlefBdrQCbsGobLmDftoHjChnSzragwKVLesMAIHjnrfrejINRDaLCyabCOatXWtHkYeZiuXDqgdhawkyCIllaoWghAElcDrPwVJLBqHvPWvkqHCjUbgDLxdGckcHdJFtNfmePVifi",
		@"wkzbDCNTsIlxM": @"beRZoEWZmUigUjByqlbtjUOCNgCIBHdOOdZlaCQQqrExzqSKWAMnfbFomGorjjZltQmPDwkaShhYJDPCuJNBmxdxsBpLDVRYuDYDckyY",
		@"hWTPehnumgoygempzp": @"yWaAWJWdyoHjIKHORhQAAUFGxeZRzapuPUKhKUSLEgwnPEDuvStQfKDjNqJoIawBRSfkdGnOkKqKCNkXcrJuKNHwywnYoRmnnFtUsVmNGn",
		@"iQggrQFtAflJ": @"gmAARuMpWqqxVOAapremkhDiFdyzrEfoluadQYvghZHVKWzXqGsyPWvLDBwtmAVkNPrISNzBnUfpMfPzxwUZihGoFMbtMYXYAdUNZoeEHtLtoqrXumzwRGPjDByhbBuqYgUbzcpyLdMNZGj",
		@"YlZEojHfgrdWjBT": @"sWoyxxYcmDdvYmeKbxVWXMliXdSfvudijQlRgSwiUtLVIgIPNsGUJLjWeNvPyoEZSTUKLxUUOYVFaQCksPiUtbJDepZnWWEoUHcSevalVTqwAVuvVOEJqejJOHlFfrIWBAWMhT",
		@"VxNvHwAWBHZeQiJcI": @"hfWxdTeiEovCTNYAZfeuDgYtmMGyuMBJVefbYqowKalPWCCzmwCivqYVDhSychzjJPqelStlluVghmMJuCzYZuivigsauvJgmAozaMVbEYUHuRrJ",
		@"OHotAVbbnbSERofQyBx": @"NgeUHYxOOzPISBjnNZRxlNUYFxBxyyeRyRigmMaApXfDJddJwoSYFdPnIiEdxiSUgLMYlZJDMiVllkVVarJeiAXqgKmKyxcIhDiEjEBhjUWzqFONij",
		@"liZYMDpdWGUCWtG": @"xgTKGNWBTzdaxyAgCkMrhQTowoaxyYojaSnJEyfoHdboSNleDGkmmYMZgStJltWkkOlnihXgtDeZKUBtUtqkvUnIQBgDxcDeroXrYaWUydugkChmrWdUbeGfzHDgBxrNjZXHtI",
	};
	return yqIxKvZSgrqrutMMh;
}

+ (nonnull UIImage *)XqeGBDeDMvzilHxMW :(nonnull NSArray *)ckegvLnwnj {
	NSData *ouuAxhhtIPWslgm = [@"EqeJnZxscLlgPCnuRnhIymlYdvvQpewYfzpAfJuTgNvsvpRrqfvIBUfBCgktvwJLSthnUAuHNKtWehUybSAWujVynNSLXKJEgHrMqAt" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *JxPzfqkMxAkmjif = [UIImage imageWithData:ouuAxhhtIPWslgm];
	JxPzfqkMxAkmjif = [UIImage imageNamed:@"tQZBepeUqaOEWNEszBPwbTmiaMxyIIJiYjYmVjqkXOmkuGXLhhKHgzqlBSYexODKwvLOrrLxUoAUPnsnNZtWdNmGnkCNxIGexHwJHmPMjbujTnUVzSyZCRSkptjpl"];
	return JxPzfqkMxAkmjif;
}

- (nonnull NSDictionary *)itUJHHAfTPe :(nonnull NSData *)fxINfJRAYeJ :(nonnull UIImage *)HWBDeYnFyM {
	NSDictionary *wCRMjjBwHrTKxXMQO = @{
		@"YLrkMQAewPzyLSHH": @"cDUuVMXiYrvJSWOwrBTUeYngeanoAsctMnlRQVvBjxEwHcuewgvVEATLkUKNAOcpLWNguoOgMyziZxsKxLXydpMxPZOtoTzKtlPcZkEaePHYWcqbOpHIWUKNvjtewAFOnmLipxxNwxklSLIL",
		@"EBWujfdUzeWuuIYGo": @"NqXnMGEcnPyPTqGMAFwncVorwUzJIpnKAIKrfoRgcZDhiLiUwZFCuQuJIzGXtMMjdnJjohcSALdLTtEQLVysRYraTFlfhWkyBpBW",
		@"OQWWeBzCEIKaaDiOcvq": @"gJlyhFwSuDODrBMSPWPtfxSJJILMZzSRrFPxiTbIuTYDHOkrixkfPpGIaIBsbBKtokELABDJTlyfJtHXFvsHbKSzmwdKSBsAJVNqNROUhKqafPTkVGsPT",
		@"jVeDePJwiGqCbzvyt": @"rvJHOSpOLQtisJbIwNzSllmkTFnNBUuTXDKuTLtLUcHhFutDfPEUdHUpKlvypyJoZVaaUDIqInZYMDwvOXmBOkDuhCwnzBaHXxiEWNMRJCUUBaTLZhBtR",
		@"YwyhaoaKwiHXNG": @"qaunvdEdtaIAiXhnowDuyatgREtlfHResMUXLJHlLqkcAMzYAfhbffMdkxOsKfkoaCXZxKSEndnYTAZcUVrrJvcEBqWrzrrieUHQvjJQxkKovSotxOKbkEcUuGnYLCywOFbONLeVgkIHpvQeeQrZx",
		@"IUDQirfyQlt": @"DlCFjckbjbFkyswNEpzlhgnfBUiqjtwAFozVxTcfvNDDnuHekQTGOhmFUQWUlftQKiOfnljVTkgtLCIhDVNqbInDMIoOeUVgMFELYTsWdicHQQwXZeWYoqGASjzSWA",
		@"FeWYqFjYFNfzgKpx": @"lLtBSMvMAwZGkVRJqtNLMbWKjpvvemcIQrHmufGMOsUEJNoNbDlwBstxNCHhIbYQCHZQLcFXVrvRyUeKXihFHldxPncsujaXzJuWvkeLurPIhiTYhAK",
		@"vQeucTYlAwdNx": @"DBLtQeaniySWIjnTBYqwdPBJJVQKnGarpbnXoadvAoQSqlziFPKOdSvtQygETTLnwQjglRtNjWRHdrktJTNNMRnmrmfQaCmJUBwrqv",
		@"cYLIQJCEtMW": @"VsURDVPymFMBeDjCRorBNZligBfbpajjTQgPyfHhvJuKMykSPlXTTqPQRBqcMybHQZvYJSNcZTCAMBVvtvjOmPFfydmgncyVVyKboTKRWDsZbzKnaHjpxbjgMqqVcujolEppXhW",
		@"lkzQNZAHpsofHghq": @"EaMuERcEoxwyIkkmRdjDEtIFTIxIaxJYezRvHvFpvbkaBIPRDcUvTWjsSYrqOIrwyhMqxcSThiCeofIvTfRtiHZfWjdEEmxfPcIfXiVIQLMfIBncO",
		@"SwIlQWUdzTUcERCuwHv": @"CxmWLFLcLjGsbwmYbcodzmIxDUrTjljYFwTUPGmTEmOohpdFhaeOABjDTANtkmtKmyXzpJScuITTMYtWbJFPMxqJxLewcbJFCZHjpIucNDSQRDXVG",
		@"dnQvmfqATEEMT": @"zerXCgSIHatKcnbgWBCgiSZxAtLnFAEhvvbhKaDAmWFTMuXIvikAYecosZbleFdyHKRiuAFFWFjJzaxmHoZAfdHMutUoCEepiDeiNL",
		@"IcVxuhbScXkNrkDHEOs": @"yKPEqbHykUnXVrMHRqnEoIDBJFvvCnBokEtQtaocquuSTBtmIjwqdqdZKMthuDkyytLTTYgOXmZrGBOWFNKArZOPieXDfUpAyWcbOOeFsvhYq",
		@"RDcoZulBcMYVApPk": @"TPexKtVGrgqhKUCtazOAHRXxAIrXaFTCIMUybCxOogvRvjAYVZBsOrSRstamsiFTzTUuLWQUuEiuxxgpWjSfNeTRmkdossPfcCsTOIirEKBRKpPUTcJnSefRnyxKwcsoMWzDympymgFAO",
		@"MGPYrEtKAGRZWbj": @"TwkAsPfPIfPawDMWrQJTgyVWDxOGatqyKbEyMrDApurzTvVAlrSFDxcTWTEMffhzpbbBikTHIWApxwfvtQYnhIKJDJCSkUsAcUqQjiiBO",
		@"vglZvGXPbtNqSL": @"taVbQAxfXxOWWdVDGNHBgxmkSkEuRTKyhdizqvIHiBRQgvfBUFrELBIGKGaOALKAoDSBcKjpGWSaUwJGVDbnxlJuDXXtjjpFnrZrHzkhcmMPjEchYvldSJCgWZRQfX",
	};
	return wCRMjjBwHrTKxXMQO;
}

+ (nonnull NSData *)JneMqEaoZv :(nonnull NSString *)zyXAyAXIVIvVSLwGTE :(nonnull UIImage *)fkqsFSIvbOXYfUBDP :(nonnull NSData *)ZAWORMbiyNDucVJoCA {
	NSData *jMgrFLfsztlbF = [@"dOlQptnHNkWUKmbLyDbQRjuvZWCaoUgiJqjESDVmcQEbgBwCeaUvADJaMMpVvNRDcnUpqsybBSClupQfAfXpGQkoNXPuKSmeJrzbFCegPwhdqmEYBbsiYAE" dataUsingEncoding:NSUTF8StringEncoding];
	return jMgrFLfsztlbF;
}

- (nonnull NSArray *)FOFKbWzWWGAMAEk :(nonnull UIImage *)bSUZZGOZQDJTsC :(nonnull UIImage *)HGSnaSEfwW {
	NSArray *vicDfSDdHyW = @[
		@"AZXKfbnhWMcOGaslYymylRnjnmSHzpIcHcqhRVcEKuIHTKdvSbDQgfSbSQAQMVOzvHmCmSqPNYKBeKsrLYJswmDlSKOhIwdgtrtLYiJjMQvJekzjkgOymvkyyIRJOohJvS",
		@"UhduxpHDuqZXizMGAgwCrPgfjLilxyTpNvXthDSgVpZkfvvnOfdPdrKhcYayhukGCuqpYadufeXunVJZRCksmppfRjUMcCgFCInBdlRfvsASjJfVzdDUNThhCLIUpDDkdxamYIIkNSgIQzy",
		@"OXZRHVrWITEeomWzukEBGiRSwITHSBDIdyOFRgnpPAuEtjFvwXVvaeceTXidGHggWbcqKAjdpDYIItBrgzExpPVVGXPdvoHHLtaXMxrCqnraxMMbVw",
		@"MAjSjiRohmwgSlbwpmhwctCDoLaTAnsWNtTLAEeetqSUtnjSkbBNvQVBSsEbSWOBjjRvmHYCUWzLdSfYfMEWgPwOuHoQDRhlVHFQyjJLNWmgAdqduYmDm",
		@"WPQInhoaJBWLxHpDpCRzQwNFCjXkOxAMSGJZebAhmAFFYmcjXfflAGtIHMtYJpwBkpjYnbzRnaxKhWHGYivmYKzoqWwmIwDenNGMnxLLBCfFsrtNhgeFImfwLApxgKYhiyZcwRuqHOZ",
		@"FuaQbGzMHkmKaRHPOuXgFWfiJIfEWsLXuvdkfIzqfpXcwtTCgrvPvZxGRCKmykBTNPlwLcsPlkShHAfTiJioePriRHjbpApIXGldkUERZKgqprbnxhnlQFxGOVTV",
		@"qhTnhBXLPqrDHIaXWXfuvaHXegKkDoZZIehbyDYOeDTDWzorWzusVCWAPJtcrzcEuNgcWGFAxdYiLcxzGlSGIagqjhcmVJQsaOlEDnDYxXgJNnKCPAbCC",
		@"vQmnpdUVQvEuSQAhtQXYGHbBRzyTwzeLniicIIvasmTxTKstOEABZpYWiNaGZoKABlJXRqTlKLSCzAKmocFUthVGGRdJTroZHxfHz",
		@"VXcNNQszrGgIzpBXVynzvNuMyPmmobgkIPcbidbBFqEyexTsmFRSfmjWFRZoFdSBBHWiTHmmMYGtjcxVcPLNJOsPaPAJAIWepMpxjQDkjLNEoEMqbGPzatbkKnE",
		@"ChcSJBzcahvPCWRuJIbWOViJJvrIsYarUcsMnwYfLodkMoQjmqVunhPgiMPHZjdaCbrkFqIBCNxDYHisNvDRYRMlCcYJXVOftMxjkfJom",
		@"KnUWTrJATboIslNDuPfyfUzPMhaMvfNfIWrKAEBaVZklzCvhnDtvORRePLTWDHjnaPjLuoBLXtxaToXNKYBEgVAxOoXyaPEquKmXphYeOSmJtIdMkebaYzzXxBnDEOoaRpnOyfCRjCQlDTR",
		@"UHzZDlzTEphPXnpnoWrSiswdRxIQqFyLcWRrZkPxvacoZSoBeZfvtsMDgFRrTExealMMRDaqrtdtXOXlISRawxdtdndLTfPilHuTEpbfDI",
		@"vYVZoMisukpbGGBImsmmKsqOYaAEPfJBRaqaXvPclrlfLDFztNPANEmhttBhrhGACtBUBVQIDaOSaJOECDFOEfXObgetctqmuXMocwmoHzs",
		@"NbRPOfYlVvDbyITyQFUwFIryzgHkOycGBgzHhVOkpCTWRgVFBOFBrHTYQosTlxWNMtUzdEtZTrSMFUpGUEFuXKFNLgaMPUaZGWoVtCnohYWGsRLsRthNgqHoN",
		@"wXDfhoLsQpbGzXSogiUpyGQpXdzBTESYFSVREbByjYJnNFPqPTRcexDHatxBRZWdIEgQYwkxDwNllDqMUKWgUKzgjRiSpmVloeRbxvGhgzoPqHoajrqtAQoyScaQaYNrhGKCBRgd",
		@"IFyTTpYPpnFWhuAjlSwjWNahBRdCAuZfynxYvzIUwPpQIxWZFQgzQUQgoQbiaQrycKEfuQfpTewRhqsHUpsgwfWAWqNxdsZjtTNazUNwS",
		@"gpNXOMCRETUlcHSVfkmdTCxLqZdOfCIqOXRjNloORUnhOfUqlEUCXNCqpFMWjmwAwMqUoTcHUlTSZIMCqsyxqGSvpAnJXqxZaHAziZedGyrckaVdGSshabEeBIaoutSNhaz",
	];
	return vicDfSDdHyW;
}

+ (nonnull NSData *)DriVZBIfsbNpvyNLUCz :(nonnull NSString *)dSilJsQuOl :(nonnull NSData *)gzzMqukZxgh :(nonnull UIImage *)juXArapOATvOqeIRxU {
	NSData *YVRCWgbWDPc = [@"jvgxIRNJRWKPzpHeTSABbQWgIyLQGnQNwrDSiycFdnIpOjEXCExMIpuNDcVeRwGoGIkbJXKYWWZFqwCrHnUeARRUSbfCwXwYPvXRraBhNbQKuqXzNmUPeJNqZmBcQOttmNo" dataUsingEncoding:NSUTF8StringEncoding];
	return YVRCWgbWDPc;
}

+ (nonnull NSString *)eNxsVjjGkHK :(nonnull NSString *)BVDFXKNNzzyvEyUQ :(nonnull NSDictionary *)eBwSexrUzjSNYeAe {
	NSString *SQSKLcCyBz = @"xQwtRPPlUyqYjIANaltKtMKKIrBvzVtsqpQNWorFoYmKZTIcZkTjWmXNbpuUcojAxMgDKUuCUVZsNQJZVcPhUwJqpyjAAwRZuHyWdeLwZFbPKaZamwBa";
	return SQSKLcCyBz;
}

- (nonnull NSArray *)NPzhrHzfyMFTXSRpE :(nonnull NSDictionary *)OZXoRdEihtxxvNfm {
	NSArray *oThPWfYGanvZrkIihp = @[
		@"zHzqrzHgcXbhAjZcaRxPklboJfoIkRAAlkGZNUQjWaDfsSnBlxbiGodnYxXMxeSbaxBsVdwsNKwgfDvEpCczrPwKgapoLXOMozlyajstAqvjihjQnZSFmuGxtqldkOh",
		@"eyTqKJTlnjNJCqGYmHdoQKwLqsvwWhlIFMLXBAHcKeLkMFeGRMsJNtVrzArGVsvWoKTtZWMXaMPHPZXgrXvwXAUJlFhzbmysWFUoKXEF",
		@"OGsMBGyuDkxydkmrCLcmVNzrPShaXjjgIQILwOEKXQzbeyIGsSExETnEHGXKubBXPpxSQTPAHfoqwtctiPhrhpwrXBhvXSRPNwvqxstZQeSjbpyBWpYwvaNKUqfKssKpWaj",
		@"ipNcGTWxQkZIELPoVcoBcfmGhapMXZmwflaWbTftnlMwmdxAIrEMmphhooHDMJyWdXTeXvyFjmpnxtwyRAbksizLfJyTevYJLNqaQuSizemExFbYYM",
		@"jrKmJIqSFYvNCznqMyxtJXOpCoFYDvWUFGuWlEULeeyljGsDUMyDtTwUXawsGgCyOidoFFAcfnLyjWugknmdUzAeJsCHMWmNIwWoiwVpS",
		@"BgsKBggFSPGOXryVJYEBULJAFwrPwZdjHfVgWFyMhVGhdtWqIkLHDGytOJPGQcykViRDhyQTroQUmcELCAQdpVfyeSyLiNkpquMfsdrmYNpkATfzJJRGaZzGvmomEzjKMclNzltoHHwcGB",
		@"EIDllObclCvlxZdfmnNepbcNNQgoUruhsHQMKYypiOMJnYuZyDjmqGqtMRjacdKaqBcKmfUcghKwaTAXPFLZuoanLOoWWWcUrfnPGOXCNSZZOGMlzubUXu",
		@"nLUJNgMdoBeumtXJQlfHECXNElDqcjuJGmNHNenAXLqJJwVGwRviayhuJgCZJcfkmWXZrpAkqAjQBhUAlbrWrujKXgeMiZbTkYsDHrtRfGplCWUS",
		@"yxMsCoOjeppCpDPWGdoBlGdYxDASCqZGFbjtRFsgqKqrupEaplXxcgxrnAzxRgSjhHAGvUixjkJMiJshpkswICBPYLcegoBotDCTVOcCoWkFNzPmcDQBYzkFhmyJZwTpPJVOoaNng",
		@"dNgdFCFDffdaqCbLxlKzIQpQKmhEHFHGjInUXJuOxrumjkmQWXhwUvtFbIcLKJPUcgWFeOboKWYYufrhtDHEqzzRdjGRAPAQLyliqBDPdvAmvaFozsL",
	];
	return oThPWfYGanvZrkIihp;
}

- (nonnull NSDictionary *)wYkqQirtRJOGNf :(nonnull UIImage *)wbvVLNVfqHDcpl {
	NSDictionary *cqZAkjhXfOxFbhz = @{
		@"rhJJnPERWcGxIRatyyP": @"tJdzeaOdpAFSsaHvgcsaaibKIULPNJnJnMayWbKqwcKPPMjmjsZmbSauNaLzxiIQYSnnnZjOIOXEvhOxAeZMzxmiHduNlusdkRvGhSdDXHpSeIdcfzUHzAJVQfKxTobXvvWCwRwRkittxetj",
		@"bAyBXsBRrZDpESgCLIQ": @"axSiKXfxQTXmNHSnoypbbUHalKmUVOIIfYSlNsjIdBqEvjcmGPORZMMEzgpEDzetlDTsZCyYambpTtiknQpDypWHLuCnPRxmKxqgWUxpiZtRhvRkWKeKMePsXoicCLXBKRPhMHhqqeixirsFnqAqX",
		@"CplEKIMOEc": @"IwoyWkLuoztXadOGbzMPYOEnbAoafzySNokRrTOFaDBufEWZkmzARWIBLCvFePfvUeEKpywkCtwNeAEYBkZaMhEwTghOftmmqkaRWLgjcBbeL",
		@"fzQTNZBmYhbXcNV": @"qnBAfVxJEdIMsVoWMuDbzWthdANhOlltqQbvOQKTGvFtZHJjxLcqRhAcYugrLXsfozsVKnBAfrHLtplAwvHmwGRIbdDNJLkGqjBrIpRRcZzEzdjS",
		@"mxlbbnKexneyUNZeoC": @"HMgxDQnHOGeuJaGqsITYNpLzxSBQxbOBNxUKFdYAlAMRQQFLYKhDYkuLvaTvQOMQAqlBAocQfpLZDnyVhsFRJOabBkplSNgIJwWkMMaDtfnZMaoIRQL",
		@"nvjjaZDWNBzeuVORx": @"BGMqjTCStaHxCliKiXXBelzWDVuRKqDCkJEMFsIospItIyOdOAjECLikQERpxZkxwtIueKcHRxWNFFeprSdAIErqWCtXbktmVQORODfuFrNXxssPVUOxkXQyr",
		@"pGaFTCvLHJdxJiu": @"InNlRBiHygUqSgJaMiHQcCrlXJYuYUnyxWcUAiSNKCfNZbBRpidtIiIeldWoQIvZzMtoGooEqWtjskeLbSrUEkTXvrODaYNtUvxnwLcxMPNfukqHkSUBbzrvhgDHHRZrEOWrxCCiEST",
		@"dpNVAZCHYDA": @"bhNiubwhRVhxXKtcfHNkRhOGvuZlSCsyTbeEdypzHYzCOiSFhJjvLQVYsHniLqsmKrxHDZzbIwVFHeorSQuRRNHQWfJKKgmVNCTzsRuMPxUeYTEWagAsIDTGRsFAHwUprXyIPwtlVoIAGZss",
		@"JBoFQuIfNVKgLJR": @"OeXvXQTxCdsKnHEuNUYYqoZzvQhiVCOZxZHGnfIiTboEWJJaDjQOvTalWkgLmFgYLTuPRsWnhyzlxITnMlgecVrzirPqOrMoGdpITuqqY",
		@"XkasWInTclmn": @"umXalNKqniTtoLfZpkJGNfJgOVwJTFRybEdyvnVVCWpFapmnjOdcwHkmagoyMcvVKWKyBLUcAyYzJcnZxPedFDgUnKyOQYTUAmigIsVHgBdUtDnBdmhATABzOmgaAtDSGcAvUzC",
		@"SPqjPSAHSlOioLj": @"DgDONubaKuvQfpSnqmTKwWBefxHAgJpSoUGrrplLZwxDOJBFwDsrAQqECdCqTjCWdBCcRtNvOrAoexdjTiAmnneWlErhOFPmGNUEXFsjHIeDJXUzscD",
		@"dtchpFuKxADDZbhd": @"QNWztuqIUEvwhhReYsprdFPLtIjDXGsASnCclnJcmyrpdFRxVNijabRWqmvdectwkXSprcXfZjBpxDugGAEbCVdlxMygtFaDAEycUCewwXLOWuSTtWmUNXoVURdEcYngzWpsEwyXlWLmFqHYk",
		@"MCZAXnoUstlQsSYB": @"AthTxEyByahZnIyCpHFshPVQzIDnZUTrznswXYIFFITVHPVktpdrAiTigzZgBQApgOfJVdfwCwHNPqHbDHaWbhKHXaDMNfQtIdpFNATldKEaexygQubpjlsNryrZWnhBRWtdNBnMGxTnNRy",
		@"BJcKPbDMCMYhCSVUq": @"RgNQpIWEvTQIFbCUGElsldmimHoiGxGtKDOLklRWhoBBQgVaUWWXyepRpyoIITzonbklPOKdARkKqZsfOswMrEjPIrmJFKiqzORcMzWlBzVMkiSxkDkoXBTHwoNjWLFcMbnuSUsVhdnBCOrKgjh",
		@"BWvUhPtFnMi": @"fdgePhVXlVqNUyeOkpTquzTfmHlXiOWDBrOehUnqfAuqOBYhUPDvDWZxOFjkaSpVSmPVqXvuxZltNRJuCrmemVZpWhGQURLpJiJIZBZcstKlAQAgQTiRKzt",
		@"KvUFUUTLEqccKncs": @"xSebLTFmIUXZxLTWasDLVLBcZCUMZdzBINdhEsouXyYcFkEqTIdCqKYtOMfuwgCedWoQyxckOYfRMcPKiouUaBWkWwbCrficUWiZubLykuMwUqIJRodDbmFMINSpMTa",
		@"tIzMrCijkSGCYg": @"RTKKnBUjUtwJDcSSjPSsKuxRjOUTvoMKZCjxvOKBMIaVpqurTbhfRBqeWRYdqBwmfjFnDdPLnHKdhrrHPkGkbJpBGEcdKMRYfetYXvXoxBoGz",
		@"QtnwrGRfkyLPtxuodb": @"DIceckKuFrIUfQKPxLZidqqlOGhSHAJyxrQAYGyclwlPGXqAfiNiaqrEOlXcbdhAOdtiKATGQrluOzLmPoUtRXCAzWVcJOOiokgodwBcAoMbTyouEVfwSJU",
	};
	return cqZAkjhXfOxFbhz;
}

+ (nonnull UIImage *)RmgDBNHLJbSK :(nonnull NSString *)eGzrttCHBMqrqQavmw :(nonnull NSString *)ecxtERAmlzRd {
	NSData *gBRCbibQgL = [@"tcIlmQtdylYmFyiRTgjFSSOQmArburIKKISTYBntSlqpdCfTAjpZwIIXjforFUxwkxBdtbDhpUkWLBYWRVhlaQJVBmQJisLGMzyZYlYrkDBwTZbKkUI" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *sDjCQTZLCCeGBM = [UIImage imageWithData:gBRCbibQgL];
	sDjCQTZLCCeGBM = [UIImage imageNamed:@"NSSbyRHTYPsmyZeEsCrAcRUpqvSjPVEdDovqynJMAcfFXpnwHLnCNyEpySuSEzNVcYmxGDMjsctCBYLOQiJTjkCGpFnpZHmXcfLaEcROtHsVggFNBiYooeaqfVwdq"];
	return sDjCQTZLCCeGBM;
}

- (nonnull NSDictionary *)mADOwVRUpmiofTYl :(nonnull NSDictionary *)zTvOruFrFeKjELdQTcn :(nonnull NSDictionary *)ZsDckpQFZVYkbWPsmV :(nonnull NSData *)GrtCnLwUYcV {
	NSDictionary *pfEcnUTFEoKXcD = @{
		@"ZGbkNEevNx": @"ypOSnZHzwbZIAxbMTuxapLewNOIZsQFJxWfnLiZaBTIqkQUpkVEDWYjrBlctXXNucznuUawMwPgdnELAXLOHMZvUXoJuBtPEgvhSBzYLftZxUeeTkatcRUjjiqWSbDbfAPfsDXRPsrnYNWyiZb",
		@"mjnKCuVJRVt": @"WBrkpEJteKZZXtuZIehKlWYPiToNYEwzvwqbIiGwnGiBPzVugZLLUOMRZeyJJQsKqGdAxWxqbjujobANjOLCkegvlslvYyDVKwzMWlauWMyPTcBohOvFUhVwNyxfxAB",
		@"zminIGinwSauTdENkNN": @"gLYYljPeGLPjjXHpWhOeTeLWTULmNLcbcTNACdvLaATmztUGFqbEUUlGyRZtqBMKAXrQVxuDlUHpjkIFtHGOiPyOFIugytswHOruCIkVbJzdFiLWXWhrTaqEfHq",
		@"BHERFMkxfjxhaEiKYM": @"vLCxkqQaJSgrBJQvKTBaArLOPGhdSQhiXxjaptbJKkMlxZxsAPAKBvIEjgccjqplnWRMfLJfhrbBYZkbgzklpFaeCBQuvZvsnZTTdQaaOBJ",
		@"uAWomIhLPiNYEYQi": @"uAjqovWtXNhhSyPeEEdwHuhmNDMOqpscNFlqPaAIzXtGlpsbeyUjqWKYcdkUgKkTRVBTVCyboaghcxlRobyOKyqKENJFjSVQHcLzFSYtOCzbJDOTBEuKQedutxuUOYHdMZhZgSwmBibdmZcGu",
		@"OCjYugwDwi": @"QFUSwzxcduGoktrGkSpwAGTBjEKLXWzbfTVOMnVcyqIKorRvUvyZkLWuGERTNSMIYFrWBuGPOOZzSwjxtWDpaoSzGTNOtDaiipxqgtLwIQovfaMukFreZGPKbhlhywUHgAqGtKWkhuBMB",
		@"xthspGHwwtchaEGXpcD": @"iRCiJyxNlXPbhkiTPpBTvffezSVJFBJdiLuMDEHSJNQhZSMaPBjscNpOJJCEABZqmVEmhLmpqTVBxIZgvHVlMxWdmCmJNuDPwZcHPKRXPKjTIcaZfKcRUFi",
		@"PZWqqpKlEwWLhEbxwiG": @"ZCLsZuCLbWSenzQzNKVZhmLsMLbSbxXRiSIMcvoWtCkUgPrUadJqvofgCoxZJjuDLFrwQksCzDwnmdaajjIXkOWGKiUqEWqVheXtWfkwJvBEMhuv",
		@"TQzjTyEnUXs": @"GtEFUnwXAMQjbyqUrIovbBCpzKCdeoFaewaMlTHVnXGXZJvcQeZqdqltyRMeUYTZlEKUSMFloNCOlqnMxDYWMSCKgycvuVnHLxrbugiIdNmCtUHFmfxPGnwiNpurPQ",
		@"NxgTaxuBepnc": @"ZyXywoyzSIlbkDCfkiLWYgDOAJMsxUSMdXahEnDoqqpzOyBKbyyLtcLnvQwznLWqWeoKIvksRDhtRQuqbDEXWBpjuevLwoowIxmaFJdvqBXdCBrKLYVSwivkZcguNoiOjeDcyFB",
		@"IRsOTXlynTtc": @"uwgxzFyRNnJuinRwqhpDYxqgofFiBYLqdYgFRwATJDLnpouxDYyJAvmHYiAJkJqucWTKffiNOoGBoSlhubgXrHlBjukcJHfjrhJryzsLxd",
		@"doTEvpNEpvFQ": @"zGkjMzNqAUeBzzBXgHVFQxYQtYoMCCGVEzHyheAwvxaLDypMzOLbjAgoLzWkhgHNrKQgilqlOlkdFMBUOfbDxGQPHhSyAPZSsDhZxoMNPVhZbKdEnOpmfBiComyWMtQwhkicwOtVpmvM",
		@"eKrVuShwDKyyGdAU": @"AhvurDieaqZAseJjSqfzAIKjJblwgnNDKVPRYxGKyEFeBUlQLXHcdzUcPhIQARXciMehaVlAxQBrPGlDBDHfiRNfdztLEXpHhmDDzblNXfnxwIeFUlqKGYEWERLSNkqj",
	};
	return pfEcnUTFEoKXcD;
}

- (nonnull UIImage *)iophcRmgdjubutmbJQK :(nonnull NSData *)tKyUyLGtAWSK :(nonnull NSData *)ErMtrvrzagBQNpHu :(nonnull NSData *)LbkuJkKmmkAqDiC {
	NSData *ZaLZIrYuBgRySqcRjf = [@"nUGwKwABqfuMatcbimdUIELuCdKOUeKUAKrwoasLjESbwWxmMMqVsDlJfiDoIUCQaEBbPoPNhsPeJyjdLanCmrnmWIEKZgqOoAgALjP" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *CbiEHMkwIrhNHG = [UIImage imageWithData:ZaLZIrYuBgRySqcRjf];
	CbiEHMkwIrhNHG = [UIImage imageNamed:@"fiLGqhZHMGCzgXoddcbriKyyHKzYBsInYOQOeAnvrTrODKrFgPnzHsJgAxmFJjGgorcCqvygPBjCTckSWXYnWyBwyylTrANPIdDIfSQIlkcienONLAOIrpWXoxZTwllqLW"];
	return CbiEHMkwIrhNHG;
}

- (nonnull NSArray *)HeryRZcMJqs :(nonnull NSArray *)laSxYKwpxHgP :(nonnull NSDictionary *)bzSMLCnDdmlxS {
	NSArray *DmyreLfzkMoTnFQCl = @[
		@"jOoKisWvemJZpKCZISogzqWpfBXvySTkUWKGIZWZNxaFrrtdpqvQWOiuvCgkbCTAoQOGkhCkSMhKHGIbMNhMukVbOfcMPlXWCdoWiw",
		@"vzTymHqDipmHIlvRyPZHXoZjGYqmUelRtMouNHqNrpipipZwxaSOTVSZENdAfjGuZKVnOunmEqRrzrftwHTJjcRAnmcwLKRZYItTgEZmJkIsWLCBbMZjAIVmigpdCJYmqtcntBP",
		@"hfmrJeiLbnQqMCHeCNrQgxnMefNCSqbWbaILAYSqjGIjbMZVpYWeISgGxHjRRrIUTduWBSlTboOQaXtFecWizjWwodoVntZLpafAhABAWDrMbqQfiaxIoCUvNsRQmmfDdYU",
		@"iXsScvAXbpPfRorQfqDapMgRKGCSardOcoEyymipWxDyLrqXaDMLZJChKgBdmVXtGyBANaRnnIXGHnDspxmWKIAmXKSfDLQdlJYofMzJ",
		@"OpRGonYHJGLSTrGAkLbmjqtEBxXrfwnxVrVrFShONQPZAvROccpKgAqwnRxtoAJzaAXBSIXtksRmqbzwffNHNnpjMvcOzYrmjkGHuIdeZdkxqSOFPGQ",
		@"VAUYXTgyJVyWPgWzDmSzZjnGWsQbSTXWPTQpHTZykqzsufNksSHuWYfjNdQOlPcjRHhKOpkFHfjpBOteXHypYRQRikCGfgxFiPGIXXsHytQlbWObJUNZgzIEZOJLrrDc",
		@"vvtGVRlKdWXfOAuuFNayDOyLSBdGnVxJqaBtvCUoNUTtKZjmxociRnOLPXPCtzDSZiByborsvBcvACARzFtULfXIIcMreUqQAbykueDpvpUsmHA",
		@"vUlCXZhNyDmvenGngcFMDvpPNNUFosmneXDElRvqLCZKyhsQmrDvFTGSunVzJEJWhXSjDoaqmATPBqqeeOxzRCimLvapdFrWmgYeehouFWXyKAHFlhSPlMyRvKhBVNEKgmimVVcjCBLiBv",
		@"GdUnndQItptWfqSLYtUQcuzybuRVgZnTPuoLnFbYtgqHVFVOTPArwWprGmGuwvnVTQTMwUncWRkqMjozQBmoKHAimCuPvwAPXjdyLUdnWPvKXPQuuZcalMhUmhAPmJvc",
		@"FUzpDbUKSlaOvhUEVAEhFaBrReALJIyEWpAgefjQSWsYZQhSAJPjVNXgLKoZeRDGQEWVPusNMtwQaPLefZmeBQEKnaRLEOzwrHgBpPLvGSHrRZvkWlypHHVTHrfTxRnElNakEd",
	];
	return DmyreLfzkMoTnFQCl;
}

- (nonnull NSDictionary *)qjZIfdqWTyGjKS :(nonnull NSDictionary *)sroHusaNSym :(nonnull NSString *)ONyPtNivXawU {
	NSDictionary *nXCENBDlpL = @{
		@"ejBzyjxhUHS": @"XOhUpqvVfLwElAuMBOrwoRBRpMgUNwGvQKxMPCMEgsYyVRVTPsNIDvJDfgjtUOzFkHrWOjSpsJLHFaDKgbLDmsmHhNfzceoOcURpzHIto",
		@"shTliLKhJlZj": @"FVQkqJlUqyLpOgqUaKQdUEmloTtzoUIffBdlRmjEBoqniRNqZmtLpyBuUZmbJoTAZIwrLCjSfhfYHmcLFLWPaUjOmCzVyiycDcPUuIibqdbQTNqduwlOpQKhJdpiaNcxIBqcZagSYesJaEkq",
		@"zBrHubobtNKjUyMXe": @"sNUileqSXmpdbutDIeddlKCVDNXtEDRSHtgNIZGCDStTTrLNoZElycxJXRTxTmTwTJEIcQqaYABIqOPYSNvbYUaNmGuucNVAtOYcKLoMhRvyWBAK",
		@"YZSHhibcPBHrX": @"tkXNwEnnfiBRJvhwIvoFQuLnjEoPGGSaYSAyueSfmTTELaPceJbFjCuLAznJcnqfZEvWeVNRyhttFZRGMTojmiPVKYGdfUWNfBgJiPi",
		@"rvQPVCgualqJgQb": @"EAKjawGeiVDEcHroBhPtfyUjDRzDNRuLYfLIwHGtPcMchpjTuJuVoWZVWJeVSVuLfjoyaMRfBYErfHcKfHsuZBzpACRQitbpqMxAeWnNSpixaawTNZfmtGE",
		@"haLiHhqPxgZG": @"fZMcQqeKpDmZgvvvyywyQKoEXqNziEbkSIBEVIarKkoGQlAVDQSdooFSVEkeewtHPtRSSeGuKjIrVkmyqiobVwYRKEPYmrvVyfZfRRxJJBjQgPeLuzPxYbeohGJKowENizzDeIgMPRKwDNBe",
		@"FWRkAFmGxzDvoFBwR": @"ENzqykxXtZHiGgvichbrCWtSkwRarjdTzsFpuIUeZBByQFuDoxAJCvnXAvuOexLDRylOXINGseMLTLRpTNNsFNFyLsdrRJjXtzfdTOq",
		@"sfqKysIkSJnMKFjzPDe": @"kelDgsUtUfedeNcHiQPDZdNzwVgvILUFumgRymtpfeTKaZvnYtomxcETkGtuKKkFJsmeXWzlcJTZJBPMDYFmqOTlQXrIWwfNbTXfUtHrVVAKl",
		@"cSXlJixnayhbFIN": @"stZsmJfJafprwVoaJqQikjFrsBRrlCDfLHQGEDWydziFsMIriYHCHZgBiuAaqSyjYgLloxFVlgYETtxWcLzGonlKIqndJzLdLXdoxPxzvk",
		@"ZkYuKxHFWnroC": @"DkRfEbPDpmbyxAugTKhYGFRLgpMKvUQCZawaMkLiAzbrXslFXRycXxBimlQCfaBXmHxxBSVoOkkUAwMQGsIYeyfOURdlWyVEekzTldAblaCgCNhbrOWdzHnhqmnEZtRDzvZ",
		@"ucyGftaaSW": @"cTMemBBIOHJXqfsMVXStKKGfEJhuRJkAeJMXxXxYruCUhnQVzdGteamCDsCJyURLSVUtIyeSaXmvYVzkErDMbekdhTYjmMCeaptPeAqBjHPoJaKKjTpsBUHZlqyuLqYaUZBiSpdtyN",
		@"wuUTNlzftgRTjAbCHDE": @"WeugtAuRxoDfJcrgxcmicyiusxfHeNBzAcKmpcarvbvQlXHWJLTvELJUZrRibEJkqJvQQwAXVssrNmWAWKGCxPQxJhykXxtBQxqedmUTfEyrumWtikikHFOvH",
		@"YOIATysDEbthXloHNS": @"AgmPokYjROrnuDAmtrZbprQsLKNiaoAVvOiMQTlcsZYynUcoJYvvWZTkhOzKjhlQMXIjfJJoOaTaJcHbZswYzZfXJesuHMnMQKadVJyENzassvjENenU",
		@"vdkStJWTvkftpZbJJI": @"FtnMfpjyMbpMmjoqBChllEtdldzCdljhtNmOBzhRpaYTCaWSGdexWvwtTvJCPtythEZQozjVdwQVUZHGxDISQtZHZPyCvEtGeMYxrixkxoMgTeumdVWmvqgVnyBCGUAlhAHOlVgkGeQggfmnoMEl",
		@"MPJjzYuZelJvDl": @"gyqEuItUBddVmEQZuFlhFvzVEeYFYrfCInfCakkhLomdXvPrHrEGFNdKTDzqHlABjLLIvAQONmwPiYZRTqiBqfZpuvJPxWcIgeSUsTghsoJoiRRukhMaCJjY",
		@"TqliHFELyOIQhvegv": @"YoIUkoxVqkwQiEYCZFKFTuynzehzabhChzvGlRPunHmSJSAuGcuCBdlbLDmbYDOcnnSLiGVPRGnaAGDTbzGWDQAOvgesIBDMPilHEIbGSGiKqKJOjTnkWBd",
		@"erCVOzmwNp": @"hYoQWuFUdbQQTYzsvcxspVfjSPHPkOAGtSSIbngEDqdKEziVZnotuFzKtpObzAUjeiggEmWWWafxEkRduToYzUbsORZIurNYebrhBcUWxFhA",
		@"qbpABIwclMJVjVmN": @"MqsmzuKynNfwGZlPOLdgQptYJltrtiRhqZKLOwOpOYZWAjdXHzyiCfBxmKQtoHbTCOixORJeouPKhOZBFTtKSdbEiyZYsjNQMISckHkfAVNxsqdpcKjLXnsZx",
	};
	return nXCENBDlpL;
}

+ (nonnull NSDictionary *)kpnuzfmmRBJH :(nonnull NSString *)LIJcehWgxv :(nonnull NSString *)QAUUHnGfotOMwpHueX {
	NSDictionary *WjAvruXyvUBL = @{
		@"PBfdRWiThpdUb": @"KbIAObBjAhXaaUbsMtvUgPrFbNQiOgEKwClySoOOTmcTCeSyINYqtgwbfmsezmzPTDAeorJdJomtjosdeBkbAMYAXywWPdrUuXqNAheBfnFOSugKHmYzJdASmgphYAofHFUYOGVhZIu",
		@"qUaOCDVAEOtpYr": @"QWCuJHEosRVaUzLxzpsSlrkToUyPyEvOjFKbybQYxvXGZibyIKJNTdyDfvTvLJokauwlrcvnBFvKqGuUMZlxDxXuwqCrQkzGadppXnOkUrHnwfBk",
		@"JEArMnibtRkCbTEimi": @"peFbJXGNqmRnTIMmcwystuxsHWUMmhDFjFFErMVtMMicTTwhhVwRcJRTucYAcKaqTTqXYhcwKsoslxDZGLxJSWpJfCTawBWROQaqcirpBeZJnDPOzSPnafusGYzilXIceTnKxNMIkssgpSCzTqukB",
		@"yXciaPICabvyNpeFjK": @"kBqdcNTjBIhWMVwxezgmDNjKQEXgcDVIlmWXZKQhAgjqKFgpNeittjtfNhiOmHLMAwrfmHqahjREDxmimpPsklhUuZyGdLWGvDLAqwdkchLNKoEAFHR",
		@"GdVeVWjlQE": @"iMMhWAxINosTXUhMVAVVtHfpWkVQHtOKqpeItvXRJTDcSABznOdLIiksQQbQWNHQLyjCBSMcmSkTPKxMTqRrJzDiMwJmYDSdokAPPswMFYIxNzWQjQArGeEnZjbEIeUneZbpHzuv",
		@"OjfPGQfronXPbsuMg": @"nTiVrWvjFsDwbUtxSvyyYPFlGBtfsryTENRbAVUYiwDzNuzRhWKwIIjXXooYqZrZSdThWGiywgOnwUReZxgUfzjNoPFMXQyUjCuBpxwvPsMXhGFLOxdUUOqes",
		@"ovuBOKXuVeCAxDJdA": @"KJyeJUKEwUCqEONYbRaHPQgNJzRLLhSOZdyAoBzFqbhUdBhVIXXHSZEWvrjhbFIgXZEUGyhiXXEpheaESMataortielReBKgvrJPRmlSJggOgofIQVDFPodpDyhYeFbr",
		@"UNHciRckFHOUSTn": @"XgsiJKrAzjRefwCikMawMyPPbymhwWUpziBhUQOJZXNJxAXALafFWOWTUKdioKOCzaXFrYDOfcLZmWxWyujiIcfybedlmRuMrcHWaMojuCLTiAmTmNxarvFK",
		@"nnqaCaAESZczz": @"iktinqtKKVjeevYLWJMfCYOxiMTEkjqamvPvwHtbjCzXxBOpXWcuxQPKDfwwHazGJaAAqbZEOsqBpEZWPoTugYvWpdMUBfujAYmzQbFjvoKfQoxbbrWxYhDcXo",
		@"qmoPaoNHCjfDXYXFiZ": @"LJPlRbrYtYlSnPfodckJtaxWXTTFgerSRRdkFHLcHxsoLbESLwTFqjbIWRxwOmjpVxdIIXELvdEXmOXUYLQWMqHpalRxiEhziPqXXpYiqFfSBwupPijCubTuwxhAaKqZl",
		@"XDdbarWaJd": @"reUoudMwBGilKnDgwkVuBAUqVbEmzgoYBffGcNnOnmOxrmDOPfzkLguqUkRkRdUewLXIGqPqbJqYZOhukAGXHgjYKhSpPoDfPBrWUMmLcpCFMfbAKkxgFKSIVbYvOnmFMAD",
		@"qdiHSEimhvA": @"pfhmRccFkAFmGZjuYnjEwlJdGsMZCRjQpPnHujGssKlCpNnXXvApaHXfgFvqOBSiOOKXJIwlkQkZvWcvNgRKCibkDzABRDkHqISRSqO",
		@"dBsipmclemmEtUvhH": @"zmqxEkxuVWmSUqrLMWXrynBMycBmxKoxPGbCyybxPtWjzkUQfXobNtNYjNpiHRUOZviyMyFZHvBcHMJYSLjvYYSrHsdBwxsFVLYwaeHaaVJAuDThoSEpmoqxhxyoBRYTvUliwxWFLnZrWt",
		@"oCexPWhZzfyVJWT": @"OFwCRwptsEvFEIyUOhHcrAxEPLgBdibVASWvzRlvGcRzvAICekpYRmfYHhQXGFGoyYMeXvoZVMyEaadpDrQvPUZsHfHQZnOtpQiXTzMFwEEmOoUxxWgHCCVUiqqccNQWHblMGhheOBUiLoFkiMIJo",
	};
	return WjAvruXyvUBL;
}

+ (nonnull NSDictionary *)amrvrNGpSmKfLcD :(nonnull NSArray *)MngIqhKWQvLZVYHP :(nonnull NSString *)rhehXloEyJjawtlMmSg {
	NSDictionary *QKTJxmMTCDY = @{
		@"FthhWOOxNwngmIdIFS": @"KYryDIBtVeSxdysEPyDkWUNAFwfyNLxPFyLRtidCCYXkPXYGNVOtqaNIVkUMFKRbKtaQBQqnJXkdYulgAUgUYoEAGWCxuIkyrjUVnBsTSEWijymsYuAwnxTjjFaPZaQSShylmTbktegxALx",
		@"jwPsHodBAAs": @"mCKECpknbVtVPcLdGnkyvIbXmTCnHdpeYmdMeSEdyfWQFttRUwKPWttTDTEISnBzAIvuVnepoVszGyhkgohRPzDVZxUgqjQnFUSVFCoxncvfLQSALAZYvnplDtFpOTcGhlcjoc",
		@"hSTHWbMwsshAczu": @"pwWhRktCENoiFjbcsfmvRJgspKqcvcDhSHvgzPNcTQGfbEIFWWKqxtSOliUCQmBooVnBnOafdtIGcngaBkNkwmpDalMQfknsElySeJaTeEghmvroAxtDQxPUXgczUk",
		@"kwkpZzNvzrMJgZ": @"sKyqpeUbKOGoJIQlQpjjUdCgtBNbzSsgIyPiRtfWXrFhaBLCZTdCLgjAHxnfMsjNperRhAytASfosffbWjeEvcAwMRTYKFPrzOlsVTIJczaL",
		@"JkLSLuvDnKHjBeV": @"wovRszWbyxRucJAOXWogiDJeKYRAotucSIQGsrotKwMFjHidlXuLZtdujtuSqSgttsNptCrXfIFfAwxGXmzlylqzJgIIHoMNgqMjKqughmhlotqoydwJ",
		@"IlZHwGraezDBb": @"LtXaaaZorrYTzipzQLAdECXAadsZWvosWIXCcPePbMOjmByWLsaHbGMemRFyCFYIEjQugKVLsAnMOjHDePooZkFAzplNyMgzjnJPayFhAHkPNXCzELnmLISNxF",
		@"VuVKDmWSVPvMltM": @"JNhoDQVaroTgDzafrJmiCFCKNMmiRDsPodWdoXWPQwxWdCrpEnKYQGRqPXPkNYLyNwBBueBPlrrrarXhenLzoReiiEyYScZPQUXhfmbHNTQJzchT",
		@"WiivTExPrwbKzMXiq": @"blIIqoNfwbeZKXpJEqkZRNKqXbsFOBZozUhIsiKkbQGjFSYacDZCKJDriQodGynfosVcvkPksYRfTCjMwvDcBVYjRvSxlGhfBroeVmw",
		@"JcKdpRcyyFCQV": @"jNUpqhNCIYeXQKAUWbfegBQAKBgKqVdVnPMYwruxtzQxxhpQbNzElKVHWgEoqjPvgHLjtAMWuXCoVOvJsGJckmOYJuqURdEGlQWAFIXqpUWeozV",
		@"wVApsbvXHVHMBGSr": @"hDOUNybXFefEgHFXypRJRUFkrxeizjfIiekNlxcoIfShwZQRIFRZFNROMYfZHeJikcdvVfHmswLYTwLTWNjnExuRFSlasgXQKNNwdZxIkaTNznNpvyvXrJwOHSxaofUBHpVfZzHSGnGZXMcqJn",
		@"CrvwbKkNGXLvfP": @"HEdJPWEXlLJByyltnqLiIzviQGHJHbafLNZbnyvtySTtePUdbzCJyKlMwYwPNBNfdABqOqnkZxexgqUyzuBolxKPUoOIDKRvLfGNOROMtCzUNvliwrNlNTpqJWgpQQNmkMoCxYDy",
	};
	return QKTJxmMTCDY;
}

+ (nonnull NSArray *)ddHuPyDzKCSvd :(nonnull NSDictionary *)NGmGscVXTHLWRdn :(nonnull NSDictionary *)fUHMNlichQBYGtqJQ {
	NSArray *yNfRGvjrEcfHFUtjo = @[
		@"aIPEENFhMgdqXCFzQUTMGICgMwLUgriDBuAJwTcwvUyumyyDkSgJOzZKVswbBzDgdlTWDDCOSqipcLGBuXsNwjPMAACEMPlEKVqeFzbJyPNstBFyYaAScjizpj",
		@"tVVleqZYRtxHMxPCJtLDnOFECoMGVaovZYPVCyDPvyBswNRFmkclLsmqELRhciujoBwvlHMWHNmTfTvNRRhQPYvkPNRkzVOPnpfErrhjJKPVFNrZFvsKXDfTrKJNEnk",
		@"XMnYlkGnhjIbPkksanUIOnvvzZmkpDSWfkXKSAoxPhAiWTLFEWfnwDLmqvWlpbmarCyPhYaHmtWqmxybleNPFeGCXqjDlFfZkeeQinXyhStPkZkcuEZ",
		@"fmvoJqmabQDSkjhIVkEBPcDYYpySDflDpdYicsYNGMlsfobchrSYtARDYWJYJHyOaxMjSUYaQDnBCOjtUnUgOxCVpXzxAlWnPxgBnsCLEFPCDACjYWPocnYmOMqzUpncyWoGqjS",
		@"lnFfcLusAdlYvtAcuZTCNILYCXYYNCkMxVJnesLIsakYMHhcuayxcZFjsMfvDzsvqEgiQymDxGbqcwRLKgXYVQGZbAfkyxWPtOSEtflxdoPmvOttPqUimdwRalDQiLVd",
		@"TMvyJaWKqBLQGUFwPfCiJVKMmJSlnnEUqljODGKvfSVAGoVkVsjxokyCWMvlurEgcQOUGqrnWXaibnUQaElbgxNtxMcHLajppAsbDqfmFjHVbB",
		@"fSJJeELtrfvcBbOmfbskuZvNBDzPkxByfKmnBZVjNOYpFpUQqgMtNgPLucZCOdZqMKQSogLtydOyWEWNQiPXkZLeRirndykWPWxrYuRHKleNzHdBzptRrEWmbdSPVCECljkvbpRwEV",
		@"HxDeUrqtQlnDstBAwHxFABagAhOAzpcaBmqeABwSFmZQUsyNyTpxcrjpRQMcBQWDPYjBieoEXTfcCBpScRSumbkOsrIgAeSQqReeZOkkwadSRnFTYcyhjBY",
		@"SFnAtvzEhrBylOIAlGLQQbTLKVZjjdbKyrFvvWILOBUuADYLMRctMIgtJSwJSwCzfKToOIZzBxribzDshBffumDSQNdSGCdrTpGwmaAXJAuetNiGzfKYNuAQBLbeUDIYjbw",
		@"MvJmYkjKZZlpESpRQGtTzTWWwpUUpkpZdYyFsPmaxUIzLnnzvOwKPZnWMRGVlFMeCwcJPVHwngKXpltjncZLEzzDHglHgjVtjwIJtlCSJvqFxOJ",
		@"AmSQFhylQmazLnRMDMFfcdSOdKzYafapyiBZCjdqJNCRrRouKbBPLsxlCvtOrowgONSMClLuOBqKvziSEVjcEcpJgJysuETGTVuUsglvREDaoalMDxyrjErQMDAmKVQQkrCjYJGqQFOFVIXo",
		@"oTlUbyjWGBqRqQFltINvADoUeDDPdbnWKHsPJebBWhznqXbAWbhHNaPmRXkXudkbzzqlXIczoKHxRvCJjWMXdWIyxEVqcbONvgiVnLaJHWzZouHGlJTbCKs",
		@"LxdTvfdlhAggAPSdFNGyvUNrgRsmevjnposisSnfwHWrBSzANtJGiesGvbqWGjMmQmMyOESealjOAljQdsVuYznapxccMZYDFKsxHjRRhUKudmOhzarHmvnCCivFnVxGokPuwODmIq",
		@"XDmMNYDAuAKaKufzbWeDGpSnpiVDroDxgqaKAanzjmcPlQKesZGvMMMPvwgxuoWnIvneZBbBOCPkoSmMxOKEtdALLouffoeSQVuhBHGUhKTmuhSoPXpwqVXLLBNYlKKNxCzGdkZ",
		@"rnbVzRhioQmlqLJwSgfxtbnDofpkxVqAFgsxXtqXlNApfkIZBQaPDcrABaMCzFHieCVRFfVPsdMyoQSbvxKYfOzlYCtdMIbChtSkCgWYLwzrFjlW",
		@"tcAYYTmJwvUEZBqoerOYcVVKGBxwcitsMkNhxluTMDlLCYemocLAkTgvPJlNzdkOHjRXmAqNcKukohfllEbOTPWOIjMePVrbHUbZtqVMcazDylNmrLmgrElQiHmJ",
		@"bLrTIvBDWxuNQTmfXIpsLRtPKiAXLMtnfZvOdTOsJEddvwiVYPpYUKZFXtXSbKJFPZLNMYYubRIiqGoMwXRRAZslbrjdNZMHhCuAMUduFmrEGGWSwuMyJWXXvtBFaChIsu",
		@"hQyqCpmtvilQhYLLSeboBTEKpkKldzVOxuYACIBtIxIoOJuJCMUrVQmbYgaOsdXghsHHBQKSHaJezeyzmUWkvLCYJvlISEFPKmVHqJdtHPM",
	];
	return yNfRGvjrEcfHFUtjo;
}

- (nonnull UIImage *)loOHZFYzwxdvb :(nonnull NSDictionary *)EQlOmnvcMpJCsEyVfh {
	NSData *cZFqwKmmOyvOdHf = [@"JQMwENnEqTdlBaaFCdUIHdvWbImQIHlUWSxgYsuHgIwPuFIFSloOZaLBNyfJUKYgDbvtbAnARBvBbdQWCKcFKufMLcxxDVBeTXbUtFneHjABEteJKYtU" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *uSbIhbKyATjxwzrvtV = [UIImage imageWithData:cZFqwKmmOyvOdHf];
	uSbIhbKyATjxwzrvtV = [UIImage imageNamed:@"pQPSMwOzJqjaIoCipSXrTYYywcYLpcTVJlUGpmMJxwQGCTCQgXKkbRLRdgWmLEOoqbyjhlpxyuMMbEbpCOMTNJlXADZMMRRwykMijczHScjJdudFXdSZr"];
	return uSbIhbKyATjxwzrvtV;
}

- (nonnull UIImage *)lHoCJqqPWYG :(nonnull NSData *)mjkzwibXmoovUYo {
	NSData *ngiVucmPJOu = [@"VrDeDUpfdPLFyZeQKbmlxcxzhOxumuOobPiLnlRBwMAqGTPaMJAPzlrcTsjDfSosGnzBWXvAYoXjBmpgwTEZgErDKkgucglbKUQuKPb" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *xweKPmgvUSMMaPNKZVE = [UIImage imageWithData:ngiVucmPJOu];
	xweKPmgvUSMMaPNKZVE = [UIImage imageNamed:@"AtDjKiFyHqNGAcvouvBlBNamfyvGxmReeRtVXkdKdGeJzOwiueiNrFXRlyBnlOnVtkUzWbXrZLovdLctMDyeoQTlwkRuMpLmcudBWriGxUHbrxbYXqcAkVMpwDnvIEnPJdQ"];
	return xweKPmgvUSMMaPNKZVE;
}

- (nonnull NSArray *)pqadDjxvkXpJUP :(nonnull NSArray *)rZoKgdExgICZzQGAaug :(nonnull NSDictionary *)smLyjzAemfASqYdHmCv {
	NSArray *whWRcbWfdxIWAhia = @[
		@"IytvxdfpKwMogCfnWDewmbULAECFzzLNbQHjfucFFHUIpUsmvdsuoigpjjmHcMTHdOuZpjGvRHrfOCMwMJINHAKbrouXSRpffonAyYtrBBLjEBGezIylRNrFFnggJhZqZMYyJGZMTPVLlt",
		@"aLDoxalAiUyjXfzmkRHJArquqzQhjEssqFeDQtpYOprAPXVrWYSrmMTXFPDwZImRSQoKysGnPFfDjDBHMceubxCMjaUfDCzipLRyjDiSwXoeyWasENGiwNDXCWMwIOELupEdIHJpFFqwyRXx",
		@"FREdCgIdlWisUyXXPtOklfcvFgeMXcYcAkKCsRUOSUYixaRsMeEKgswuHzOMqOPliAhwhCKoQGcnmLsbixAnKfJvFcuLUOyJEBGYNmwTAgskPSENEWRmkeE",
		@"QjGiNepmBdmfcIZbvHqGJXdlFSPEssyKNNdZLaZOuoLdhbMmKdfbBXdkBmDMKjAWOHlrSoRVhQrzaBfKlrGzPgvHHhkctmjnSTToRlmashcxSXredfAbfPdUtaALNKCrHVZJktycCZJXzgfVcp",
		@"zFcluwnnMjUeudZxgQDhHVKeihaSoqGdBucUOrSbAgCTgNvvuWMMbSsUtkFDIDlbAvyFuREYVxZHTzYXatOrqlHOkjeRqqbTqRdvMIopVjpMqQiIqR",
		@"fuIkvMzQImceayektBKLxtcEgjejqfHCXyqohWzCSalPYMGKtjMTuUSuCxtcXrRnTYjdXKGrhlsCfhfyVcNeVgqhVbHIHSXRjqJBqsATSs",
		@"oRzWbqjzpQgEoUkzsHCoUPruMbhVUzZSkhoYXzSpvwzJTEHSXVvhymzJHwlsWLHluryFfwvIsrgBxACwTNAeeskmMSaehxkiyXiOVWJDPpQiMeVXyMlTkgqVOnJW",
		@"AlFvHYjCOQrvrDZMdZAXJalfMIfmEkadgaJATpTiulZMWEsxJDBOXbmxPhqaSkxSnpRfSvyfONiymDqLJdeaMPBUPCnpkhieitfuObyJZGFKNIFuqeMpQjW",
		@"MswWYfAMlXoBaiEZKcmYcoKUCoWcajNRGeSZrzdVzQDjUiznLLWLQWaRLQdrSopuBjKPXdftfZXafvrUKswdciWZKqcGrsKvxVlvdCKXQlGLwaxvBPLnSOZtYtjJWV",
		@"CjbuMfUnzujisGwlsOFNxojBsnSdbxCYplmRfJTKszufacZjWNOgBERjBHnlYVKRbYSGEUvNzggIxowZbUQDdPbUDMaLWWcDIijIWaJIrTMlwDiMfbSatLGeJ",
		@"pZYshWrgbrPlDvcZdwkKtGucQOAxtAxRwkOlaQGPUbUUgwQFNHtifHXaKVdKcmRRShnPCGHIrSqjLXcopPjEWtNJoCzelcPkJmDjSDJWHxHUCRyCh",
		@"MMzAzJXAvDkGWKswBKyHzdYsXbhNQqrPxhiTBclGqtQLYVLoIxzlbHRGPavNYYHSIViVMHpBDFtpsztcfmOXztCRjmEVBVSiJKhWSBi",
		@"jQCNpNPsIdPKtwoJpmZpCyupiwsKrOlWOKxkMCkOWagqoguicPQOLoBztfpvzMqqTorMUAJSYfgqZojXMOFsewkURKtVsQqwrttUAnHff",
		@"tcMAvdGzamsYPfbItGOhuBOFPrxcRsrUGqtOsXTHqUqXycXoOuosUTAYqZuMfLNLJTZcVYWabAkrPNsnuzxdAuTufHDhysvzGOOSPAAPpaJtSMEugExZvUYfmFfSDaLDNrnyVrSaOWwRBo",
		@"ZnxQxrYUKDquuIYflaohGaEAAvRZqLFpomFpMWXhTwFamhByKdVLxVDasGQHsuCFclGNWXsQDkTRQgtAfzclmeCqjlBMIzjYmeSatzAEusoAwSHhiXWBIqATKlQbevhWfvxa",
		@"GESgwGrZWHuFuldAGdvKsyOJwDuITvYRtZnrqgyTyBEwXxsmoifKJZgBXfTMxhDSFGVwQUIHxfESrzftelWiMjDtfwZJxDjtRzPiGjrBuhDZPclxkslTQUcbNvVoatagNNq",
		@"wAKiAANvVRtjiJckVlLBPFXvIdAfKePaohJEOqwOhboCpOXLRUnklorBRfyuYLimvfbYQQpufGIsvAQtHpDyIgtyLvNJvwMiSOYClVkCmoqXlJPPGERKAnJmxmlF",
		@"EcVFPqysbvxwBsCfnmhcUiEREfqlzKgEMVGMpdVWJchGVizmFbgldQRVGUyMnRfFfXJFhwmhUgBqpNNUZlWZCDjnMtwtVqnPjQMSSIkZbkWDCtaAhHgZoWcOsBiRwiyoSBVlDvG",
		@"HNoXaeBQzeVeKJhKCpvujaiSZcftwIgKWUmSqJuKyhUePCulGDEXFSbrULyHIXvSlEtPPagVJamnwCpnUhjkBhffeTgwpsMdjCLmOdyMfxNzQzvigiwxFE",
	];
	return whWRcbWfdxIWAhia;
}

+ (nonnull NSData *)UxirrvvOckEHi :(nonnull UIImage *)wIdNYfwYhwLCsz {
	NSData *gxpTQEMdBtXFMoKNL = [@"IMmDeauEpBOzVbvKYmkItFKxMcRaSVVgiXGZSUocvQqcSkXchbZGDpSmxapdseRegIxkErDqivRRumjWRsqfwFYZtwKDgmALnMEMtXrHEHpxDgqRMhwLetYVndw" dataUsingEncoding:NSUTF8StringEncoding];
	return gxpTQEMdBtXFMoKNL;
}

+ (nonnull NSData *)QXcwZJdNQrbpUfA :(nonnull NSArray *)TqPhKLYtSTzrxCxGE :(nonnull NSString *)QbnEYsEOdyW {
	NSData *DsZqcFjhzYYJDGcHWbx = [@"NduiOqsgbGUDLddqAqFibzsUtsnmECTFdptMNbbPIMSsgYHZBzOMGPqmDzYIyddPJtQQvppCwnLUFDHgqGlCEOqrHgNsFkFiIPBYshuFSoGxoGMyCwLpghyiGHRsYBzfEiQoZxtbhIIy" dataUsingEncoding:NSUTF8StringEncoding];
	return DsZqcFjhzYYJDGcHWbx;
}

+ (nonnull NSString *)ldxikCXFMLk :(nonnull NSDictionary *)lGfayBSSLBdhik :(nonnull NSDictionary *)fnHWPHJSnmyDRLgPpp :(nonnull NSArray *)ymGjzBZgNYBrhcrH {
	NSString *yGVQsoFqHbVjyfu = @"mKUgwigmtYYeEgAgcxJiVnYRvQxBgWIxqTEMxTcvtuiGRwKhzFoOMcgmXOduiacKfGgbsyRwoHlyKuYiRsMHZAqOExuNYUNDcBmSGtTTxApobbvsQiYPCuwfURNFDkQnKQqGiDQ";
	return yGVQsoFqHbVjyfu;
}

+ (nonnull NSData *)gWpUJUZTch :(nonnull NSData *)jsUaeYUFziQY :(nonnull NSDictionary *)FBZphcPaGsNKuub {
	NSData *GiZaGLHVNSnmUR = [@"NiJkgRkwwEztxhPDdqCrJERibwHfWysnJaCnuTegsryGAjwXvewHfGrjEklPTAbNEciitAUMPXVkUUXyjIYcKylKGIEFlHMfGVgJnKwkCJEAQPNcJEObZfMZsHXHgqxMcKbIGuGW" dataUsingEncoding:NSUTF8StringEncoding];
	return GiZaGLHVNSnmUR;
}

+ (nonnull NSArray *)wATKFzKfTTWya :(nonnull NSDictionary *)XVgaTClgshYwoXiU :(nonnull UIImage *)PhRqgHCNGYzQCtKLHn :(nonnull NSData *)XNZLJDCoGnIg {
	NSArray *NzGDxGJPTurlyVDAX = @[
		@"IXNaYYctrcHilFfwQCfyncyLPDpWKAPTOWjXKqQpPovqbVtVuaQVCKKFsEKpveotYjMErGHXSCVaWqQZzysCNAhWzjERoWJBmFAPyBAmHtimQgiWQFbieBdPWNswWzjFFaHQtYKDZZsWhfukQnG",
		@"ZBdaidxKZQKQGmABZNOSAtDYgBdWEiacZwspnefhpmplnHKvYIyDESoVQGiNUQpEwOuSdbUlprjOAEZdtJqnlGCygyjktXOSLhrbQRciVnPmTMbxgCRdJkXmMnuDnzSjSQaHur",
		@"UGvMvPiQlhwCVtckVkWKCWQjteCFVZIseaopIELVRlSMWYuDuizQFpZkcXlRZMobqOHtTAAuSmxmUYeYLxvOdnPcjhsmhxgSToskrcOXbsIzsRhPxUQnQ",
		@"AyCGaqnFjPTIPOsNdFbWTWzgKgjdxLLQtGaLUPUcyszcpDdsYYZJVKKcXPwhjwUgwdXvuyZxyWNaqhkxXdjuGGqzaRslXFeVNaPBZzor",
		@"zfROoukeBHElmkhyzbODyZlGDSfmoNpXcQAFjaNZAVgxqEzkctOxaNiLRurlgycjNqtJVGUArYCAGfAnNGuDMktkeWqXtPEaPJaTTCYWYuMNflLqRRltcWjGaFNhjQJpYSSzNzNxz",
		@"DhLIcTLSinpxuXKNEhoIHCavpqcZAIqZrjDhLFNRwxbkswhSQtwwymnCQRiSDuegmFMGXtUjRvyQYbzDycajDaihdJtbgMARjWIiuYxxQOkIyYnglybOFkbiqgGtzVKEyvaqTUItv",
		@"XmoTdOwCzEDnpapkSTnVNuVYwwaDgdIycopfoaMzOBgehefHIWhhtdicCxfZMVJrpvqgGgRWDpDBZIglLmmBMuAhnQiPqFSacfqEwtqDnAEpCW",
		@"fkrsxGmnKFUmOgDQyXdOPMjgEddVvZoFLgtnRnEZTNtbWEuzXXFxCqOlIJIrtJFlOxaIkMIMFRveuYVTomGdpNvjmIpuyTDzVbdFSvJTUbjkQpsUyhWjkvZ",
		@"QxskOPoyeKuMSnedyiziadofcHOlAjVXkQoByNdaaADMnXACzlPrFKlLQkINrADbYMZigbwTQaQdRtYsbMgotWEwgBSxgJwbOqsBNalqPrhpuUXpstoNaXqfMvDGhOAGXazdRyICF",
		@"eCCQecOdLCgXVvuFIIuNABaVJWDAXYWpraUUQMtbSohlrewbmHQFYAeJagoTKJGfaRhABsHqnLjRNtcUjGgSNglyMFVxSyUYcDABvOaxakNcabFSbsWUBWWOuglYgNbORZSRdq",
		@"nMKVNTLrzEvhYQRIGhSQgdqsyAUDoevpKDJDEuzqQFapUcFrbZeaZNsMcBNDTXzmeaXiRsLAjZvnjhWzesSdUGAdVSHbzSTdizqLJtxqjnykeuDipAvImAU",
		@"qMSNqecPRqyjdqZwEASDRzZqgrqRSwJIdpqwTeesnJUBirzJJiuLfAAJHmfqnwUstEhBNoKvacIsIuENqBZemNrgfYtNkzIZjilCCivOeWxZu",
		@"McUmsKMwTckIaWlAsaZNRtXoHqWxpvkmgagFcuNVMyQLGDAabGSsdkOBatVOadZakvFoHvuCuXvRYWaVQWLHtBgfjAiMzFfJSYHmqVbVsASYpvpqMBytGfOAUHVWRz",
		@"nqUdpgfKhfKwOlvAaEfZCftTDmrUwdobXSHFCYSsTNRBmBszlpbTbcaqARBbrNosVFDZWefrVyGDMATNZwrTDwleNPZjuKiSNepFdBqKgXSxJFiFKcODSjmqPOuiUjdOVsh",
	];
	return NzGDxGJPTurlyVDAX;
}

- (nonnull NSDictionary *)MGWYHagvZVegWwnoDf :(nonnull NSString *)DXiVadrKZNhTWEZnbK :(nonnull NSArray *)TPPsCEOPEYHXnDBe :(nonnull UIImage *)RQDdJkAxkmbnnvaEI {
	NSDictionary *pqMbxfOMcxWkrHzpTT = @{
		@"auGfoOkDpJah": @"CTRJVmgNuFHfcOnETIGCFHmJjmoffNBpfJJJoPxLqnnwVZJyaPRCHRvPLRbRYhzcDcNuycKxfFCFUptbsTnriywQIgdKAutUbEmmnmmZlIfcKiWPHcaclKFGSCBqIsvfdGyyW",
		@"dvGafxlITDOYMKCkGB": @"RPtORmcKXdXutxHepASsCAvrWGUjiiaGofrdomSLTehqnNMCQuNuZkSWFaeVcCukxoMYFvszZFZQWIcbTZHuCTYZkLDmmydfAjdwlYjoCFKvtTeERJiaIxwafMBDRcJKrGfzqxVUZbXMYt",
		@"JvnqIgGAxqhvMdbmpw": @"rsOZCCQkVFNksnGYQSBnixHTktbbnNiVeFfecubvxLrcEZJuqdlHPBoCJkdxytzHLNUtIgrbdEwiqYXIYbIRyngypWSbgnEKPXxEUfhPF",
		@"JFULAQhoYTfOEmJPs": @"vxCZYOoIMPPYEPLWdIIyCKVgMylptQnaNQZfWDOiNSUomVEVRfIjSaNRcbAHXnbjQkcrPtyvkXwRwHCoXIuBdFIUQSSddWNHobBKWJrVNThXFAJUPMsEILxQ",
		@"kQlCSwspyNSy": @"htkICxMbtgIrRuCrTBOALrloFFGhvInCKmljJmcLXZstwucsrXhlRfNKWmSaajJDGjviaoXaRWuBOXDKlkutgfDHBXJTJgACafXeQPOSYwALghTmbnXmMUadCbabbLpjDngauYZepWRuT",
		@"SZWVZDmQehocYMKzbes": @"VjPFTvmwIslHyanMDdMyQOzmElucEbXmyXmqOhafLOVDgkyRXUvjCYFJIHfbKlnZNOGQJGhfocrrkABqxvJYFgsnJlWZuBCytRKiaBhnvSEYLuPlSllaEZjzESdvBPgpWqrj",
		@"hSmcuEXIBujTTSaJ": @"cjqDUuQDHyfhcbVwVemzkpDWlvBKyqAltuXRKDYDyOWzmfplUmZnSEXrvzmbRTkYJQErpDPlsyQUQfTRcuHuTmxKPDShjOmYRELKuoGJJJezMClaCrHR",
		@"ayNngeAVHCkBfHuL": @"AiIfWLclZPeNXXrqyXVXssjeUSzYVGEzqtniVaQswMfgfZopHSQbJKPuDpwewkDzqNBuhAhtRiAMBzUroWpLBMWmTvCaGSbrOlQKEbGBudXYIzdsoRoaruczjaWJLBcBgEFOEH",
		@"XwxjCQQWngQSWRytJ": @"EFlUYUBEfXOqVvYLjessKqcKalbdJppSfiofNtmyifeIwYNYXAFqqkhYdCbqpGKvTAuhKRNilRyIfQIiOZdsuLsznbQHEttcDpulQhqFocbZHvSgGALQgvYevLVhiMck",
		@"anhCfBCGlRu": @"AnGkdxqpVvAKLeBTrRdzFktKmPyrFtXcaFVCTJDurHYnjHQbUJTFLBZzrlkJgxeNmwpyMlWGcpegbtfFEuVZPJOxGphKArsEXsCAoqKVXipgmFGfzFGsCDPAXSNdWJslaKGXyrd",
		@"JIOpceEmQVmSHs": @"fjoxmIgiiScIZJQZYjmojbHkUqAkFRHwfoBEudndisnjQvtBSSdWoYuGXJfBaaHjKWYculzwFHNTYzSEMDBbYMdGlQXgpokLDDGdYHrNykEQfEiABEmEQOcZmlENBWEludilxpuuxg",
		@"gbsyqTtiKugVdhTfNd": @"MbvqQuOCOoOjCCMszIkRqNlWerAwudUECnHXnUHXMqlgVvzMONvHMStVhxxycrbKEbzCXaKTbpYNbXxCUCtSvuZWSCaYhfNzdQLvR",
		@"fzNLzoQEcLltmxwJECh": @"aSfTDpDiQTeQsEIXbmASAGCRDATKsAZQHPQuHZIJeutMBNaYzeQqwUWacrgCrOVMVhGzZKaBycVwQRtxhjjeUNSMTwRFPpqsdReM",
		@"mLFfwGkeRbTO": @"lYunYKVtIAvglPWBbmEqUeItodsUwRkDXekldWggZIfDdtsSVwuUlCSaDohGftHEGxVCIcalAeizILpXwlqjXsnkSSVTeQUpEOlPFVtWekXiwaBCJNVCTnCribLzMKwrM",
		@"KahnurnbXUkjtJqbwKg": @"fGOTzivpVyOTotYBEAxTtqvHWHjacVuzJbbwhaJimCgrWPyTcUJfBfgYAIwttFDPdBSWrEaWHAsQevdqnfDRkQGEAzzOBDcEEiUUtVEcPOfXvHOqaBZzshsPYVYV",
		@"LaVPkKxZTKvXZ": @"iiWUZfUhbIdDSAwyWXJCASuaokQUNSRuykHoDlLSsBGoFRbrkQkJjnOAWdkYbUhZsrWPlhGqiMftRykeqBfQouyaabnrBoxGEUIvCnAeSPOFFounprtlCgbw",
		@"OiCqvaLuErW": @"IqGUAlZVmHxROmAdFUAWYwQohWZFfVetgLRCucfoRHoDjjcUppnpCAHsCNOEpXgmNQBrSVnUpCgqQqvqnCBNqYVRyDfwZttWRvKTUvwBStjUNNirurJHWWdvxmOVtYcwXrRXsS",
		@"JUjgzdbrahD": @"DYEHwhMVyuvurxIKVHsOkILbFuyPSALgttqjiZKNDWEDYlvScsuFMEhWDFcNtpnohykwTfeXOzUfKSErBKYpCQzCFnSCNDTWyLtLXxBtfwHCxLBrVpfBeGbhNfNUzRVXnCXHQjYjQTgKtLRgXF",
		@"nkTmmjicgqVTT": @"FVMEukZxHVfFhsNRwgZeAOVewqcDcrfUoYnpBGLyhucWJXBfJIgAutljHgzGzZBJMKmAcSEVwgBEHsriEOujfFUxltcyKYRZPwSixraUTX",
	};
	return pqMbxfOMcxWkrHzpTT;
}

- (nonnull NSData *)qgcDFSvJUr :(nonnull NSString *)XrSgzfzMAJrw :(nonnull NSData *)ZjaDYcPPJyRBWBKomT :(nonnull NSString *)WSVoCHmdthMRpZG {
	NSData *ARwOnPOkLjRoiDs = [@"SDXBRHeRWRfMbWNJBxJGVfihtDhuyIjaafXBnOSscsYDtVfMLuHPXGauCmWnTMwpdBAhNsYQjYhKCjlzeVXzjkpiysAupXURiHBKFuwzqncRRXYXOgDlkB" dataUsingEncoding:NSUTF8StringEncoding];
	return ARwOnPOkLjRoiDs;
}

- (nonnull NSData *)WAnUVaPmaJOJlKKtv :(nonnull UIImage *)GqHQfRbMfCZXsDAJQ {
	NSData *xktqKlkKRitRdN = [@"VfmWDwZWxpdPjyIgKBuMHtmFwCiwomEOUieHszzYdLBZrhPKbuPXXqOKDKsJzOtPnWiOKukeEzuzbxuueYGwuzjUAtwIeXuhzZduOaJxELWIeIbHruuM" dataUsingEncoding:NSUTF8StringEncoding];
	return xktqKlkKRitRdN;
}

+ (nonnull NSData *)oDISxogPTkjsyOVAyi :(nonnull NSDictionary *)euPpBIqiLtw {
	NSData *zJEfQSLrmLQsEGg = [@"xLLxVPQqsRYJujuEoSRAuGcXZaawlpipHvBawtCGpogBinZfwtwdQCyhqwmIwHnDyGLZFezGxMsoRWTPkaaqYMevbojrlrWGQdoaWYdHDvMmAnJaEMaRhInRhQFnPXJCyPTQjIWgWLIhCcvsfd" dataUsingEncoding:NSUTF8StringEncoding];
	return zJEfQSLrmLQsEGg;
}

+ (nonnull NSData *)rQvAkoLDXOAx :(nonnull NSArray *)GLlrLcxnoSrqP {
	NSData *XHaFcRnWKBPOhtGDna = [@"SHgLZJUmyXVSTmYYxQwLBFuRFZAWnrqZHvyHHJahrfAxGrOJNMwuPcHRhKnuQYzyTgkBjXMYBptUqbDrRLPxbQElSlNbdCgbcIWhjNLvsvgiKaraaNyr" dataUsingEncoding:NSUTF8StringEncoding];
	return XHaFcRnWKBPOhtGDna;
}

+ (nonnull NSArray *)uwVpJUKiMgInBo :(nonnull NSDictionary *)tIsInRscGdngnjzA :(nonnull NSData *)bHFNwrJdiLnlMGPlQ :(nonnull NSString *)hscBymPhNwIjVuquxMy {
	NSArray *NlXdfZeQbTNpg = @[
		@"UsCPuYWUegYnhRVWRJhOQwIXhtOahwQDvKQoqhtPBSqcrhrSZmJPwUKYNDBRCuGMBhfELknqilaMOnuBUTuIppIJkJqCHaoTwdzXCCBVTeGcQzlbbs",
		@"xYiLdoZiShOOQdmuhayGBIFXUASJiCqgradfNBTqJVVdQxuiYoWbZrOexUPHOKBqDzGrDSGpCYFmVQwmeyiRRZoGEWVImYRgaIIHpqtMUtGIwFNBVtzFKyFHyeqi",
		@"FrYjCxeIlqWlVyMuOZPGZgRquXunFLRoYTHPzdjDjkzyufoghFzpsQwdNQUwcMPcPtZkeVmDTArNWwwMFbOUxSckchKRHiOZlGGnIYvSHlYCMVV",
		@"IyzqUoTXUPfzLgLZaSLDsDWrwUjuOklFopoCfXqAyaBEQngJpZGzMTEBBuDTkKdQEoIoWnaHWCtMGzGFIQzKPgOhRxwnprQNZnyEZUwIc",
		@"GnHmCFlekmVPxwjVSBJNZfRlVJThxJLPXMxxTlWtNRijRUsKJrffTwdqHjfNdPMjPHuxMGGWrMNLtvTsaoFHjPjZuciMtcksfiqeVfzWYcK",
		@"bfZIcVPHrwkogbBMBMbednbHPmQJVsUhuhCcNlnthINpZiIeCXdvjZZxnDSSVzwjVaeYeXszHuDFqhWdMfxqcDoLXHczXfOjMeMoNGeDVclAFqojmSGLoJuKZtXsXPGMKeaNHPKPRPjuwYcCfytC",
		@"jaACvnOkTyxeYKAHBEwfCLzxJyDASzZYPmELwzewkCCbccJFHXxCJjDztmZLDUpfmiiwZZJqpyJlFucbnqnwlZjYyfybEFYBUzqfkgIeOnnsqf",
		@"cBSAonzJxghcyyMLLtMqXYyFgsMbDJxCsWMLSZPjfCboJbBRMMFsDjqpszHsITWUXbbZtNtQYAxQaoNlkOXofeSgHMwdynrCJaRHXANispmtymouYsGUFExXtdUDpbOz",
		@"gjDYFThHiBPyATnnoyJmCTQTZkeCOyBzMVnfPSVIjUTIsIqmSeBXjmtcGTQpBgXQRzAJPPocjyFUQfXgOWbdDNIYHXzMlbiEismWnsCDIzYVGMivtpaxHmecaYarpfPFDnbbnfTUaMIlu",
		@"XCqFuuhErGjvcpAzofBAdJxQFjKiPhDmQvcOyMqFdekAYNrCNBqEBBSPiGxFjlvStyiCTUCleoTGvnhxHxdvskagmMudItfxabmUblKVGlEPqDXvUJmAazUPxtp",
		@"BiWfohqqRgmqjbRwBLsbAsDtmTgUBYcwprmdphUQjpwsljzVyEdZqIxMFygmTObAigJySHRsFvOqJQEXDhopcVScCEiqZeMGjJXXgcwlbxvUQNYXgPxvCPBvgqzRoFypjEEEeIezglsYn",
		@"tPIPZKAGCkRbCQScfxebGkoAtZoKdbjKAjLwObUdrZWnFlbLYRkFRblEYakgLWLDuUBWUvcZubHukqdnmWhbMwPdcxwyUQXWIzaAbQQmNixpnjjjVrgubZYMvsGRhoKgIEGiBuhq",
		@"locfvOWvGAJlMogpYsbxfhWStvffQfdWcSsrTEWkhDyktwgacBrXOEUiCsKdIiSvwCymSKjkapmwMvrFHFeEqTyFidiNZBKzGSKTiFnqJiDizWoNhiH",
	];
	return NlXdfZeQbTNpg;
}

- (nonnull NSArray *)LfLamfECWv :(nonnull NSArray *)TNLlRmMJWjyPZYEqom {
	NSArray *watDlMzEYnweVYtg = @[
		@"WWqXwdMREAmPxGGpmmFoTIPRJhZoIbWqVgHiJFhTptVrGuiXziGyxoYychwqwOubAPwgJKoRwwncJwjiacyDqOoOrMSlvTqyLBFKnTXFICgMRIcvFRStneLmSQWDbPjrSUfpvWQL",
		@"BMmvSiEoEvvUBaIKDONtbxwCvxZpiMQTZUhiddkFqNFmKYsFokTUqTqjhVUcVUTHBONIOfPCDJrykpTpCCENFtQZwparwrhSnlyZBOKeHuUwuqAZBRhHCiPEhZpUxPHMmlET",
		@"flAqhMLkDmDssfqMjTpJnOurbqnVzwajSMacbkjwDoDdTbGGfGJWrhhiolOjGLQRxUuNqOAjCqzkvvsgyYurHLtMOVlIEJGJJwRZTFb",
		@"wQYLmLvlHQmOjMogsehhhFBOrDoiEEgfJSdmIPHFsICDjtcvNXqDLZsqtTRrKojEjXVKCfsRniPFyjeZgbLlGKrYZXlHTEvdwsegnQujrlLfUnTyws",
		@"ZWirCDyqYhgplbEnIdRjkmVkuXqzsUHJFKmAgMOJZEeBOVfdvJSoHnPxzORIyNHvJviBsJLMnNzauzvkcgviqLIAhJaMAuhaOpyHOgzhWMQlZIeoLCgWzHUKbnjevawY",
		@"DbMLgMuknydtIqvugdJuDfXJrOFZeRoUmWJIdqvkhrypIeLUcQxwzKwQtSyybsPNCyyLHmnhaGXFypzuWrUwUImfqlMedoNaBJwtQwXHyOafoaSndnVuIHzBkiDSNbOPXgVQzCPsOPKMgzJpJNHzF",
		@"viXhJDZylnhyaAvpxUpLuHUeQAfLpJRsqrFKVIceDgfWTWTfHKCIxkvfpqegFjwLyEKwOCOrqByjAwHdWnoXDtXwKAgOivktOnghDIuORQHfJbnPM",
		@"mKdvfKAtXwjcOlUirVdeProEuDhCAYrxZgflqyqBjLoSbQPvSFrmWaUORmIuJFtRCIPJOJKoGpeOanBVdZoneNMUhEUpKuOqgAalyns",
		@"DHgMTbGoSrEBJvmzdtvjaUtiAOzzxOUGcAvtOSjEyjDrUTANOJqUreAnAaaRhvrVcaIMNWhPAeqjgKAyoXeodCKVPRKZQeKCafdQgGmIRxixiCCIHYDarZGmddgbCPFfY",
		@"gcmExuXNTDrocwagYNarnTdbPBJcZLVqkXEuwkqUvhVqxkBgoqzCRyrQHelKrohwZFSlWqCovCnSRijTQhdWjJmEnSFupRrHBYMP",
		@"ScQDvSzeeDKluHXBrrpovMgbDhVMXNaQkyfxXvamxfxKoPAacywoVhXHaGhLjJySGVptERVqJoUWWFKWTfJRNeOSjcMYFaXDwKwBNTNhULPWRQJrzWLui",
		@"RszwhlKBHsncBOiyvWnkLJVKqMBtOsiMyXJoMHJAFMXQGrUEQsFWIyCnlneGVrUwBruULOsRPrzbHAWEOPhftFhcvBEFMGyDsWllhKDixYzUdbEdvdLAKNhGZtLAxcDZvCvAmxDbmhS",
		@"zAITRHZOFWVwLXgqWcgnaslFnawojGDXMPQjnvUGoAdSXzpukcRcCJHufjvjrpKAnhFBvEofABbGvUScJhTEbvjdotSLnRHrfdtttSjrrQiCgrtVElMtwdGlBSAXMDMYtWIZcLSvGHrFNTazA",
		@"ttlSUjBJKSxqiyCqHdWvhuCVbBUzoCvhNmxujIwREDmMQaYrIcfaEKynIWDGfEWQVpgXthuudxHQcFNHpmtNcoIpXzfsEzPzcpLdEkCDfmnPNwSkfBWbLmMkNtBsmmSoVNtalZcUegX",
		@"acTibFfziScMZwYWJkGtkChFlvzFygMuoPPQUJlfOrHLopUacOxxCLmCpsxSMECETcUrfGFbgqyEgGKSZNqOKsdhVCvHUDSobjWZruuqvmEBOKRoWK",
		@"mMFoTQFeNUZwWNnETDrRvIoBkldnYSivcoUVJGRsCxFhnKEyidArZCSdsatbmFFjVKolasHjEEzqLkcsgFTFxrxVSlcdEmxAVPwhSYjuTTYIaYMsUxgs",
		@"flpnhwSweNCcRiFprEnjtCSIPjvjVuZGesvvPgwQOTtvusyquOXLCMxrYtasqvxBnpMLKjjTYSkqeWjOafYIaKehBZQFRuiMFEFikyCjWgbtMHUmsOAzhgUrtnVQ",
		@"mKjEJWnHQoKQbUeCkRoMcmKyWMmeSrwvZDgWcFyWcljUuJRwkPzdqXnbMtraXAsZSSKZttUPLLQNGaHPspERcGuabitaXTbJjwexhegzPpxRkpLohghNOVjRVDwKuGY",
		@"YnrRBaVhUICQNJdQQCBdZmSbIWHvOkTqhbAVeliRhlWVAnILpDjDWOJXJapJZVlzryHvUTpwOzyfHlVLqUVZPbBqTQyqXIOXTEZuhOloRgTBgqUmh",
	];
	return watDlMzEYnweVYtg;
}

- (nonnull NSString *)kOiKJvhvQYSGCN :(nonnull NSArray *)GJXNQlIqwCzpVTkKfG {
	NSString *pKtTJICsZKJkWil = @"eofYnpNWzmggYJeFsoxpupdtaTIpyqvemBzeUetzJmiGeExLnYhtWuKeXcBIBvjviTkiegwPSTmTqXxUVwvNzDrPnJNRmLThAnvAfzSZDhJmPfQEuyVPKExEdTq";
	return pKtTJICsZKJkWil;
}

+ (nonnull NSData *)ZefbCBeWqaKOtva :(nonnull NSString *)REbNbFqQzXWbOr {
	NSData *jmeOMyyITIXHFOKaK = [@"UShzKrTSwhwjUuEueJzObZXrmdObzXEYhnVHNMPmUpButQGOrztIFbjeyoIeuatlSQSTJnukhJYGTCpiRvIFMGekpDSaughPsEtFkrIuCteOWbpyrzrMd" dataUsingEncoding:NSUTF8StringEncoding];
	return jmeOMyyITIXHFOKaK;
}

- (nonnull UIImage *)XOYsxRJYcSzcQUnJ :(nonnull NSDictionary *)gLaFNiVZZB :(nonnull UIImage *)FbbgMyAjmhF :(nonnull NSData *)xjlQwFxkhKBK {
	NSData *tnpGqVOWwNGMYPeIrAo = [@"DgzzXinFjjRwHgvUxKKBZpdZKXVMypPOAFEEFFOvoDuPUwtSMJYneafecvSuWOQCcaZZgcELAkAMxbOZokeJsSntUZFIxCsYXhCcarigcAtHyQdAEUAfhNzUAsbtjwLoKXuOUrxThuzbe" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *YDbJzbrmjOpdbR = [UIImage imageWithData:tnpGqVOWwNGMYPeIrAo];
	YDbJzbrmjOpdbR = [UIImage imageNamed:@"tpzGmLTyniEQEjqdtaXmaINRRVJnxKVpNaAHAihYrqVMxkTLwviXqruFGoYmIlrPlDhkUNcLtJIwlFZkBOBzQdhjiEdoEohzZLBeIcRsJTfIQAqBfDMnpykohQ"];
	return YDbJzbrmjOpdbR;
}

- (nonnull NSDictionary *)wILVXCnwBuNgWwk :(nonnull NSData *)ywgofUjsxR :(nonnull NSArray *)VhTEiFiEegnZOASKdk :(nonnull NSData *)kRwycVlTKzWGs {
	NSDictionary *SkcOqFQSEkWxpILWQO = @{
		@"mOrovEainEnJTW": @"WTCssISilLIlEptyNKhRZHUYKABzczCFZGBfvNxXvdtEjJRpZLfuFEHiKhcLkgWXPeUCesIVOdiUngpLPFbnEjnhZuNVwZMYzNsycNIsQyWCqSZltotwncMShrnvIYjqqjkGhdwlP",
		@"WrPFdyykILtDP": @"IPqXNkkNDDmUhEExiGkTENGclsTUwAwzYopyTCkNpQuIMJXfvqNhBnahulaMowSARUyIkosBGYIqAeoEJTHkuXnHWIYFfEehmPZgzYjbFWWbMFAnmQsVwPtWnCMHd",
		@"EPtoJqKKunXjQTyAW": @"jfBYdLFWGbMooSVdPmlQfmoEWhHaxnybwnEhJSORReGGQvpXcrRAPpvzbeLBDheBdptppTgqQwAcfGWrziBphazmkvBKgSmzMnzpnuxJSeiVtcIfYhmsOGwepJi",
		@"yENwQJYOjRdQ": @"hpqqIyMRNRXpupQDVzRmJLXkJGKoxIZgEjixNVQsQacyBxsCTvfdcrayVbKcaVlwVEWRAJyFMRmHEekHNlEjASHOwrdCdjSxcXViTWyXJKYcUyNwdIqeWVLBViCBrSGOoyl",
		@"KKhlpojIxBQnCxW": @"icOBJePqVvlbUOBknvuJaFnzUUhqVKfkDszEBWpguDDgkwtiFgzLiHIoFxBhpUBqExIOWeNDNaKtmNFTrWkmVgqKqoBmavqybBmUsOXEqsdSSOhQRSzNfFrJIjvCWE",
		@"AlBvZcQdDzM": @"YDcItTmygkpEXcBxVFaHbhemVHvsYCufbOslKRBjSKCuMyMKjAxBEVQgrirrWiwRqfxPyBTLeCseFDoXPzENOxvcTIkxTMpfIIAMBOEBkUfpAxBHdiBMSUYGTBImrRdICE",
		@"JUZoNYCxJldj": @"fNHZwHAyWunsojJokIGTNXJSwEXqDLNNTJKLFrPuGoMwAmhIMLsUbkPUkCgwnQiPpCHCdfEepZpGzxuYyguBKvBynnORZWPnazYkXznQBeeyagGBiBoYlksAnmZqExaFf",
		@"onUHzRRoCldeOP": @"iNCixhEzBFxyqIPKxjzZwodBUJlRUlLimSGZbZgbZJAOdjIQPwBZPIXCYqqBkUkJknSfOGpyNBlSZweBbjrYQfHLrkQSILQvGWONXzbuLVvJIUKCPcVDrSfaTaaJTOWePtTfhiyachUzUhtEPgI",
		@"ovoYAkCiOVU": @"qwUakXAIlrJGghrMIDFnQUmWcflAODdnwbXBwdzNLyBBTBamiwayVIZVAGWVQJVwQyDlCuzpYoHcEUukSMyvNTLNvFxXYsRBMluPDLYwDeKsXiLyuBOgeFtqDZBSNNzaOdkDrEabUxdsRxtslysk",
		@"MjBjdYvadhR": @"nzeHcIcwASJtKcbUDhbfNLbmPIiZvremCxOHQApfWFjBEYMjFLJOFWWpcBmzjqRcrudDowBsshfGXDhAnKavaAtTOsKsLFMqJdIRYTUXNUxThYrScb",
		@"JGdPChirxUVCuGlDQn": @"IiBFUrcyXsJfIsDFdwnNquGhygImmRDrSODGozgVlMOGKzEyovMaFeGfgXSkXKWGVzNqTGkVGdqgoqOKEOYXCdWbKitdZqLLvsQmQImxnrbYDzRYkDdkzVo",
		@"esTmTTIYbHUBvFA": @"XzxzNePdVIgkhaBLmbdwqQvCXYXXeAavauMzRDesvRExnnQPQLwKJdGukfmhfdsASYqlLYbLOyqtFMfDYsIkAasdGYvsLgRLwlDbapIyUxzAdlfa",
		@"iOeGlyxBBP": @"YlfBgCMHtHsTXJPLqfUwVDrJcgBkaFnzhutQbrjdOHHwLpwDxmSqvizwIiiJctKJqNrmidduNZEieeuZLauRMhzuGCkibTSyQTbJuXKLczYKaiLwIDTqVaePB",
	};
	return SkcOqFQSEkWxpILWQO;
}

- (nonnull UIImage *)VAQCwolMln :(nonnull UIImage *)IRAUDLCMQLWzl {
	NSData *YGZMKzPktv = [@"oMwKTaGzHUjPstrVTeybWkRBXfQreWwgeQClPAXOKyBppimjkPiqBzDAkEawgGxcxVJUJBBseUGqOFKfoHmaKMOAHRltQwTOkEcxvya" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *pGzjeGpIOTxC = [UIImage imageWithData:YGZMKzPktv];
	pGzjeGpIOTxC = [UIImage imageNamed:@"uQrDkiYulswHJsTvmbzQKLkyuhzeCzzcqKiRClIhnUmmFKZPsWdhPilMbrMsYaOUoQjQLRnasGTOUIPukYWfoChswDOdoCAdCDZcMTKHCtsIfscU"];
	return pGzjeGpIOTxC;
}

+ (nonnull NSDictionary *)wqyBsTQbIVcyiRFCe :(nonnull NSString *)cDOLxhGjFLBgIEOuW {
	NSDictionary *VwkyTCxgJC = @{
		@"uIBuwsCDpiirdhHOaYC": @"ovBviRxMAkIeiDONiXZKeDNrYWjpGwEuRgLmzzWkrFzwSWMJHBBqMtwijePvksWJSgLvLOwfsgIFwDkQKtuTKVkHLSquFMQeHTjWlOcWCNDLnGkxXKfVU",
		@"FHrOwDycWdUTyfgDxjz": @"LNFyMFizlyvvCbjCcGFppigMeItUyHzOZJoPEjUCsLvnlPjnDTOYMRbPvCtUbJGWcOSKCrqUfYeWlptGDiIMjcZAplSDpHBEGaNrFpyxQSdoxrdhIaOACjvnCFOiQtixwdLMtB",
		@"TdLkcFXMHQdDADUMzQ": @"MQZVrcGXKtUdAQgNpzERYOOQHDVmwodFqHgZhqYeUTvMakOiiYldotNXvltrlWjgUPLcUpGbXtmQFGZCCXQaUwnOpPJeUodfWsJzJUgGoKilZA",
		@"IFithvYrfxMXkyAkY": @"ZhyRuHLeqMKIjniENlXIdSwwBwbsyujlhxwPIJKsngKRJevhdMhLMcxYJSPbLUVxvuZoGNqeqHIeGuViRSolqvbswPtAFfUnpBqGWDMczyfENLhSRoxgqLDfspWWixuHshfqKEkHUHHle",
		@"tPaQHUsErKTlz": @"guzOMtJMJwFCgwJktZFgWdgVuyneBKMvbjEIevjqwFQSAbXhFcQIvVeAYJxUgehgBoVlZPDxQcVehNhpkPozwhPwxGgyuMFTZDdLZhJsrAsGrKENaVwPgnJLtxGPYgWheeQDULJpKZGZqApShb",
		@"VZsYzdkJvgZnLUv": @"HNUPAnCZKLVEWUFVpiCHsalPLxYdkYkwqOcawkWZmITxOXbipYMZlnbiadZjMllrCvKmWNTWTuEmuFMxqbCEWlCWIehVhIcoxdJtGEyMgLhudyShZEMkImLzcNV",
		@"aOdiKSrIHfuOAlYkl": @"VVUpcpnirahYPdYZMdCGzbyMBaLoWxzEEaVmzJKaNnZEwVchRNYqHmOyIRrqmPxvUSvmccAmLjganwRLiGtKIUkkmSJgxULAEGTbYPSWjYNsRe",
		@"zrnlRGNhOzxYtNwmzV": @"WTkXydfDXUysUKuOxJTHDNWLcsCwIguHWoUqfMmJJrcSAbEafZIakVTvsOSnGBxpjNxDjfMTeqByzmybFaySWwfGZEQSREyKzBBplGyYyHrHXrxzphDqKr",
		@"WWoFHlYorYsAVCiMy": @"sSuhYIjgPTwDaAesmsXaVKqAbQqnVxJEEUJxYeJNPRVRQWCLytExUPJyrSpNSevMyOmvNoiNwOLXugKbVDpUtaRdYAwdiwYYYVqpquJlEjwJJdKhqMAOayZM",
		@"BjtJyTKhZSItwpYm": @"RksZVgwrlxDmnmakeskaeQYSKPIpGRLyYanPjcMYvKxuhLXXHCxUtdjfGtCEnNxeGFYnqfQyVquUVYarWBitfuNFaHLDKTjrvyrEUgxXPXNiVVLhecpptJrbtQmNXsCAN",
		@"WnDDLnLYjzMEVDqVbl": @"IHPaPuKwykhioVnuUxmOHHNpsqagapnmFceTJZGSOxVuhkfwepTbCJPeseFrbTvfSRVCNViCrJNuewIZXpropnLUPbBLAGGsuBIFWHyTETuehTODtqkpvmeSRmGqSVexOiIaLOpYzTFTIUuprJV",
	};
	return VwkyTCxgJC;
}

+ (nonnull NSDictionary *)sylcSKpRbdCq :(nonnull NSString *)LJlBZUABsBrQO :(nonnull UIImage *)dwPUkKyMwQln :(nonnull NSArray *)MTqfcJSrboMyyeCIWH {
	NSDictionary *EAEaDKsIjTtr = @{
		@"ezdqIBEBPeEFSsBkdcF": @"bVUnTYNhMUVXOEqzkGIDtcUslwGBjHFnpONzJCNZAgUUmYQfPLaPiNCJNEzzBLcFUgapdJqojLmZyystgbhRqRticfJTgsnJiAnIdckvAJ",
		@"LVZtXwyIJBrSbpI": @"UMJtzVqbZALACVlmeqnFGzTOZBKDouuntHtPMurDEPhVwFFGchYefackaPPOfBuBTttlNibfwiKcVCjQzHPuuHnGkDSrwCCITiaNtSBhWlPgpbrMknzPceaN",
		@"vUsroCRUCQRwyO": @"epilLXunDRSSSKdLEXOLJCSYHjzLSHFSIiEnWqrkfsrPfONKIpjxvFHHYytaxhbwyHozqcbDGzFmeCOqjgZXNcJfubmIPjmvvMKmFLRItvpxTnwJZIeYZemzRxHAsliqKCgLw",
		@"BUDmTkMofWeaQ": @"cWdnANLeNXeWhulvEoLTIYvibKVfwgeugtPolCRcxgdxvAWbbbwaQbjanLjPONaNbUqHPppbPWsbAOLDalOEDNVHjhgHYHuleZmeWURkdN",
		@"FbsNfnJJhX": @"ZCMEghkRwkasqMLofcZOtqldRqFAApRVxOaHUzGpxgtFOyetlKwxSozHmeILCxOTXYQEpYmxusHXyqQIwHmqHQtOHbvujzoNyvPAoMUGxjuG",
		@"qOFfXswwBLwlKfXu": @"OYpsaOsArRMlLDbaGuGbXslnSwyKCvJYdClsRYBfJZsgFTmZBxrwfhZvxXojXObnTDTldfvTlbojxUOpUjxionTNPmKeFNegtwlgHQTKGMmfAUkHGjYdlaHQijsCA",
		@"NrDgvDZjkyWEKhWQP": @"FmqWZqALNkffEzhBFZWIIGummNKolOHkTLojuoeZqbvJaMWrUevyGZTtwmerVohTJQgufXZOlmcFTnXrlWYwMKXHaTCWPnMaRUJoHpVVKhgBcHANrPyJgPdjpwMvaEfMob",
		@"mBTwQEuHmtYjA": @"qBIPbrzWcILijBumNeEPQcJHXWvcSZpcGWvEFbRQeksOeipuzEowNudrTTRzjjJLuKsYiyrqHQmoixWtHqvBHVyvtLdLHWBxOqLHUYELGHewppXnJutINsOPXRnWEEKswIgSaTQPkeRfr",
		@"hPbXjcTKmAsXjPUAvbH": @"zjguBrZjNUicoLfeaIdQHcUTdySTFJDZkZcXDRCxFRFmoqEzrbfLfVAIrgxfHFsztjdvuZGCtmikEgAANXBUhbofcUjgOxeciYWtZhvTcqrU",
		@"jbwdwOyUgSIfYbGSFxl": @"vViHVJauZRgEEeQIHwCNEGjonJPgadIzFhOORgpYLDttOrqgkvXyVKVzJtGuiqIjRoWydERvCOWsDRQYrMsaRCYpsqnBKUaJzoDyudEsQEnVaMXeAluJOgcXF",
		@"TcRXRblkbe": @"WHqpMybdirYHBUUCmiDAtDJYjaFYZULsRjKlWjigMwWUeqKGuHhSlqPCncsMaDjWgBGNWslXsHLMfaevMSDCMCHIgRvXmtOoznkpoNcxulZFxdJgitm",
		@"CnzNBngeHXmilktf": @"eImElKjARlrRmbzPqpcRBUeIYfdmeepIdbHObKtkYVFQmdyACLfZiIlQyBBrSUdCyeYDIMQbrvgOAFRmqYLNKCzZNgkiDuTTpezMBLXyS",
	};
	return EAEaDKsIjTtr;
}

- (NSURLSessionDataTask *)GET:(NSString *)URLString
                   parameters:(id)parameters
                     progress:(void (^)(NSProgress * _Nonnull))downloadProgress
                      success:(void (^)(NSURLSessionDataTask * _Nonnull, id _Nullable))success
                      failure:(void (^)(NSURLSessionDataTask * _Nullable, NSError * _Nonnull))failure
{
    NSURLSessionDataTask *dataTask = [self dataTaskWithHTTPMethod:@"GET"
                                                        URLString:URLString
                                                       parameters:parameters
                                                   uploadProgress:nil
                                                 downloadProgress:downloadProgress
                                                          success:success
                                                          failure:failure];
    [dataTask resume];
    return dataTask;
}
- (NSURLSessionDataTask *)HEAD:(NSString *)URLString
                    parameters:(id)parameters
                       success:(void (^)(NSURLSessionDataTask *task))success
                       failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure
{
    NSURLSessionDataTask *dataTask = [self dataTaskWithHTTPMethod:@"HEAD" URLString:URLString parameters:parameters uploadProgress:nil downloadProgress:nil success:^(NSURLSessionDataTask *task, __unused id responseObject) {
        if (success) {
            success(task);
        }
    } failure:failure];
    [dataTask resume];
    return dataTask;
}
- (NSURLSessionDataTask *)POST:(NSString *)URLString
                    parameters:(id)parameters
                       success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
                       failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure
{
    return [self POST:URLString parameters:parameters progress:nil success:success failure:failure];
}
- (NSURLSessionDataTask *)POST:(NSString *)URLString
                    parameters:(id)parameters
                      progress:(void (^)(NSProgress * _Nonnull))uploadProgress
                       success:(void (^)(NSURLSessionDataTask * _Nonnull, id _Nullable))success
                       failure:(void (^)(NSURLSessionDataTask * _Nullable, NSError * _Nonnull))failure
{
    NSURLSessionDataTask *dataTask = [self dataTaskWithHTTPMethod:@"POST" URLString:URLString parameters:parameters uploadProgress:uploadProgress downloadProgress:nil success:success failure:failure];
    [dataTask resume];
    return dataTask;
}
- (NSURLSessionDataTask *)POST:(NSString *)URLString
                    parameters:(nullable id)parameters
     constructingBodyWithBlock:(nullable void (^)(id<AFMultipartFormData> _Nonnull))block
                       success:(nullable void (^)(NSURLSessionDataTask * _Nonnull, id _Nullable))success
                       failure:(nullable void (^)(NSURLSessionDataTask * _Nullable, NSError * _Nonnull))failure
{
    return [self POST:URLString parameters:parameters constructingBodyWithBlock:block progress:nil success:success failure:failure];
}
- (NSURLSessionDataTask *)POST:(NSString *)URLString
                    parameters:(id)parameters
     constructingBodyWithBlock:(void (^)(id <AFMultipartFormData> formData))block
                      progress:(nullable void (^)(NSProgress * _Nonnull))uploadProgress
                       success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
                       failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure
{
    NSError *serializationError = nil;
    NSMutableURLRequest *request = [self.requestSerializer multipartFormRequestWithMethod:@"POST" URLString:[[NSURL URLWithString:URLString relativeToURL:self.baseURL] absoluteString] parameters:parameters constructingBodyWithBlock:block error:&serializationError];
    if (serializationError) {
        if (failure) {
            dispatch_async(self.completionQueue ?: dispatch_get_main_queue(), ^{
                failure(nil, serializationError);
            });
        }
        return nil;
    }
    __block NSURLSessionDataTask *task = [self uploadTaskWithStreamedRequest:request progress:uploadProgress completionHandler:^(NSURLResponse * __unused response, id responseObject, NSError *error) {
        if (error) {
            if (failure) {
                failure(task, error);
            }
        } else {
            if (success) {
                success(task, responseObject);
            }
        }
    }];
    [task resume];
    return task;
}
- (NSURLSessionDataTask *)PUT:(NSString *)URLString
                   parameters:(id)parameters
                      success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
                      failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure
{
    NSURLSessionDataTask *dataTask = [self dataTaskWithHTTPMethod:@"PUT" URLString:URLString parameters:parameters uploadProgress:nil downloadProgress:nil success:success failure:failure];
    [dataTask resume];
    return dataTask;
}
- (NSURLSessionDataTask *)PATCH:(NSString *)URLString
                     parameters:(id)parameters
                        success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
                        failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure
{
    NSURLSessionDataTask *dataTask = [self dataTaskWithHTTPMethod:@"PATCH" URLString:URLString parameters:parameters uploadProgress:nil downloadProgress:nil success:success failure:failure];
    [dataTask resume];
    return dataTask;
}
- (NSURLSessionDataTask *)DELETE:(NSString *)URLString
                      parameters:(id)parameters
                         success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
                         failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure
{
    NSURLSessionDataTask *dataTask = [self dataTaskWithHTTPMethod:@"DELETE" URLString:URLString parameters:parameters uploadProgress:nil downloadProgress:nil success:success failure:failure];
    [dataTask resume];
    return dataTask;
}
- (NSURLSessionDataTask *)dataTaskWithHTTPMethod:(NSString *)method
                                       URLString:(NSString *)URLString
                                      parameters:(id)parameters
                                  uploadProgress:(nullable void (^)(NSProgress *uploadProgress)) uploadProgress
                                downloadProgress:(nullable void (^)(NSProgress *downloadProgress)) downloadProgress
                                         success:(void (^)(NSURLSessionDataTask *, id))success
                                         failure:(void (^)(NSURLSessionDataTask *, NSError *))failure
{
    NSError *serializationError = nil;
    NSMutableURLRequest *request = [self.requestSerializer requestWithMethod:method URLString:[[NSURL URLWithString:URLString relativeToURL:self.baseURL] absoluteString] parameters:parameters error:&serializationError];
    if (serializationError) {
        if (failure) {
            dispatch_async(self.completionQueue ?: dispatch_get_main_queue(), ^{
                failure(nil, serializationError);
            });
        }
        return nil;
    }
    __block NSURLSessionDataTask *dataTask = nil;
    dataTask = [self dataTaskWithRequest:request
                          uploadProgress:uploadProgress
                        downloadProgress:downloadProgress
                       completionHandler:^(NSURLResponse * __unused response, id responseObject, NSError *error) {
        if (error) {
            if (failure) {
                failure(dataTask, error);
            }
        } else {
            if (success) {
                success(dataTask, responseObject);
            }
        }
    }];
    return dataTask;
}
#pragma mark - NSObject
- (NSString *)description {
    return [NSString stringWithFormat:@"<%@: %p, baseURL: %@, session: %@, operationQueue: %@>", NSStringFromClass([self class]), self, [self.baseURL absoluteString], self.session, self.operationQueue];
}
#pragma mark - NSSecureCoding
+ (BOOL)supportsSecureCoding {
    return YES;
}
- (instancetype)initWithCoder:(NSCoder *)decoder {
    NSURL *baseURL = [decoder decodeObjectOfClass:[NSURL class] forKey:NSStringFromSelector(@selector(baseURL))];
    NSURLSessionConfiguration *configuration = [decoder decodeObjectOfClass:[NSURLSessionConfiguration class] forKey:@"sessionConfiguration"];
    if (!configuration) {
        NSString *configurationIdentifier = [decoder decodeObjectOfClass:[NSString class] forKey:@"identifier"];
        if (configurationIdentifier) {
#if (defined(__IPHONE_OS_VERSION_MIN_REQUIRED) && __IPHONE_OS_VERSION_MIN_REQUIRED >= 80000) || (defined(__MAC_OS_X_VERSION_MIN_REQUIRED) && __MAC_OS_X_VERSION_MIN_REQUIRED >= 1100)
            configuration = [NSURLSessionConfiguration backgroundSessionConfigurationWithIdentifier:configurationIdentifier];
#else
            configuration = [NSURLSessionConfiguration backgroundSessionConfiguration:configurationIdentifier];
#endif
        }
    }
    self = [self initWithBaseURL:baseURL sessionConfiguration:configuration];
    if (!self) {
        return nil;
    }
    self.requestSerializer = [decoder decodeObjectOfClass:[AFHTTPRequestSerializer class] forKey:NSStringFromSelector(@selector(requestSerializer))];
    self.responseSerializer = [decoder decodeObjectOfClass:[AFHTTPResponseSerializer class] forKey:NSStringFromSelector(@selector(responseSerializer))];
    AFSecurityPolicy *decodedPolicy = [decoder decodeObjectOfClass:[AFSecurityPolicy class] forKey:NSStringFromSelector(@selector(securityPolicy))];
    if (decodedPolicy) {
        self.securityPolicy = decodedPolicy;
    }
    return self;
}
- (void)encodeWithCoder:(NSCoder *)coder {
    [super encodeWithCoder:coder];
    [coder encodeObject:self.baseURL forKey:NSStringFromSelector(@selector(baseURL))];
    if ([self.session.configuration conformsToProtocol:@protocol(NSCoding)]) {
        [coder encodeObject:self.session.configuration forKey:@"sessionConfiguration"];
    } else {
        [coder encodeObject:self.session.configuration.identifier forKey:@"identifier"];
    }
    [coder encodeObject:self.requestSerializer forKey:NSStringFromSelector(@selector(requestSerializer))];
    [coder encodeObject:self.responseSerializer forKey:NSStringFromSelector(@selector(responseSerializer))];
    [coder encodeObject:self.securityPolicy forKey:NSStringFromSelector(@selector(securityPolicy))];
}
#pragma mark - NSCopying
- (instancetype)copyWithZone:(NSZone *)zone {
    AFHTTPSessionManager *HTTPClient = [[[self class] allocWithZone:zone] initWithBaseURL:self.baseURL sessionConfiguration:self.session.configuration];
    HTTPClient.requestSerializer = [self.requestSerializer copyWithZone:zone];
    HTTPClient.responseSerializer = [self.responseSerializer copyWithZone:zone];
    HTTPClient.securityPolicy = [self.securityPolicy copyWithZone:zone];
    return HTTPClient;
}
@end
