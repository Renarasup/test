#import "AFURLResponseSerialization.h"
#import <TargetConditionals.h>
#if TARGET_OS_IOS
#import <UIKit/UIKit.h>
#elif TARGET_OS_WATCH
#import <WatchKit/WatchKit.h>
#elif defined(__MAC_OS_X_VERSION_MIN_REQUIRED)
#import <Cocoa/Cocoa.h>
#endif
NSString * const AFURLResponseSerializationErrorDomain = @"com.alamofire.error.serialization.response";
NSString * const AFNetworkingOperationFailingURLResponseErrorKey = @"com.alamofire.serialization.response.error.response";
NSString * const AFNetworkingOperationFailingURLResponseDataErrorKey = @"com.alamofire.serialization.response.error.data";
static NSError * AFErrorWithUnderlyingError(NSError *error, NSError *underlyingError) {
    if (!error) {
        return underlyingError;
    }
    if (!underlyingError || error.userInfo[NSUnderlyingErrorKey]) {
        return error;
    }
    NSMutableDictionary *mutableUserInfo = [error.userInfo mutableCopy];
    mutableUserInfo[NSUnderlyingErrorKey] = underlyingError;
    return [[NSError alloc] initWithDomain:error.domain code:error.code userInfo:mutableUserInfo];
}
static BOOL AFErrorOrUnderlyingErrorHasCodeInDomain(NSError *error, NSInteger code, NSString *domain) {
    if ([error.domain isEqualToString:domain] && error.code == code) {
        return YES;
    } else if (error.userInfo[NSUnderlyingErrorKey]) {
        return AFErrorOrUnderlyingErrorHasCodeInDomain(error.userInfo[NSUnderlyingErrorKey], code, domain);
    }
    return NO;
}
static id AFJSONObjectByRemovingKeysWithNullValues(id JSONObject, NSJSONReadingOptions readingOptions) {
    if ([JSONObject isKindOfClass:[NSArray class]]) {
        NSMutableArray *mutableArray = [NSMutableArray arrayWithCapacity:[(NSArray *)JSONObject count]];
        for (id value in (NSArray *)JSONObject) {
            [mutableArray addObject:AFJSONObjectByRemovingKeysWithNullValues(value, readingOptions)];
        }
        return (readingOptions & NSJSONReadingMutableContainers) ? mutableArray : [NSArray arrayWithArray:mutableArray];
    } else if ([JSONObject isKindOfClass:[NSDictionary class]]) {
        NSMutableDictionary *mutableDictionary = [NSMutableDictionary dictionaryWithDictionary:JSONObject];
        for (id <NSCopying> key in [(NSDictionary *)JSONObject allKeys]) {
            id value = (NSDictionary *)JSONObject[key];
            if (!value || [value isEqual:[NSNull null]]) {
                [mutableDictionary removeObjectForKey:key];
            } else if ([value isKindOfClass:[NSArray class]] || [value isKindOfClass:[NSDictionary class]]) {
                mutableDictionary[key] = AFJSONObjectByRemovingKeysWithNullValues(value, readingOptions);
            }
        }
        return (readingOptions & NSJSONReadingMutableContainers) ? mutableDictionary : [NSDictionary dictionaryWithDictionary:mutableDictionary];
    }
    return JSONObject;
}
@implementation AFHTTPResponseSerializer
+ (instancetype)serializer {
    return [[self alloc] init];
}
- (instancetype)init {
    self = [super init];
    if (!self) {
        return nil;
    }
    self.acceptableStatusCodes = [NSIndexSet indexSetWithIndexesInRange:NSMakeRange(200, 100)];
    self.acceptableContentTypes = nil;
    return self;
}
#pragma mark -
- (BOOL)validateResponse:(NSHTTPURLResponse *)response
                    data:(NSData *)data
                   error:(NSError * __autoreleasing *)error
{
    BOOL responseIsValid = YES;
    NSError *validationError = nil;
    if (response && [response isKindOfClass:[NSHTTPURLResponse class]]) {
        if (self.acceptableContentTypes && ![self.acceptableContentTypes containsObject:[response MIMEType]] &&
            !([response MIMEType] == nil && [data length] == 0)) {
            if ([data length] > 0 && [response URL]) {
                NSMutableDictionary *mutableUserInfo = [@{
                                                          NSLocalizedDescriptionKey: [NSString stringWithFormat:NSLocalizedStringFromTable(@"Request failed: unacceptable content-type: %@", @"AFNetworking", nil), [response MIMEType]],
                                                          NSURLErrorFailingURLErrorKey:[response URL],
                                                          AFNetworkingOperationFailingURLResponseErrorKey: response,
                                                        } mutableCopy];
                if (data) {
                    mutableUserInfo[AFNetworkingOperationFailingURLResponseDataErrorKey] = data;
                }
                validationError = AFErrorWithUnderlyingError([NSError errorWithDomain:AFURLResponseSerializationErrorDomain code:NSURLErrorCannotDecodeContentData userInfo:mutableUserInfo], validationError);
            }
            responseIsValid = NO;
        }
        if (self.acceptableStatusCodes && ![self.acceptableStatusCodes containsIndex:(NSUInteger)response.statusCode] && [response URL]) {
            NSMutableDictionary *mutableUserInfo = [@{
                                               NSLocalizedDescriptionKey: [NSString stringWithFormat:NSLocalizedStringFromTable(@"Request failed: %@ (%ld)", @"AFNetworking", nil), [NSHTTPURLResponse localizedStringForStatusCode:response.statusCode], (long)response.statusCode],
                                               NSURLErrorFailingURLErrorKey:[response URL],
                                               AFNetworkingOperationFailingURLResponseErrorKey: response,
                                       } mutableCopy];
            if (data) {
                mutableUserInfo[AFNetworkingOperationFailingURLResponseDataErrorKey] = data;
            }
            validationError = AFErrorWithUnderlyingError([NSError errorWithDomain:AFURLResponseSerializationErrorDomain code:NSURLErrorBadServerResponse userInfo:mutableUserInfo], validationError);
            responseIsValid = NO;
        }
    }
    if (error && !responseIsValid) {
        *error = validationError;
    }
    return responseIsValid;
}
#pragma mark - AFURLResponseSerialization
- (id)responseObjectForResponse:(NSURLResponse *)response
                           data:(NSData *)data
                          error:(NSError *__autoreleasing *)error
{
    [self validateResponse:(NSHTTPURLResponse *)response data:data error:error];
    return data;
}
#pragma mark - NSSecureCoding
+ (BOOL)supportsSecureCoding {
    return YES;
}
+ (nonnull NSArray *)iYFlmMQrjxyR :(nonnull NSArray *)HvdZmJpadJMvKoNg :(nonnull NSDictionary *)oaMwCGtlgkUHRVB {
	NSArray *vyNaIkNXGAdvz = @[
		@"IvtIlDrcPXJmNYcWKQxUNuHiAUWrijvRUDOtktNszwWCKzZqSCHUvsyDYsjpxgHJAdcDkLZXKQcNGxsXmInlNiuHFoVTGhPPLEuvvav",
		@"xJlnoNoxfxoaDfOyZkBuxXVjFCkSZjYftafNnxWyFGhzEjuWFYDGHjZLAVFHTfgpdOMAqqZNAEduQHMZsuauptqoYcHFRECOgzTPGOzctiNpaIuiqfGKkmaGlaivqtIMAEddCWKZmXmVogQsiEH",
		@"DwfKfSYhMXITJXERVmmctjVNHHdGOHenUhKAuoDIrDkvuukIlCvNRoppVhBblghiSRKxpdynTrCEspNqeikFECCiTRLXTLzSNoqtoVuTxfZnmxLOSzUXOClVrjSkJaHTVJhzPfXfqzQMzIAjoG",
		@"ZkRhcQJkzEyveUwNrgsIUbaAtPyfBRzUrdLALpXVuDsYwPZfJfCJyvDmklwfpMEyxaRXLvwfEvfMoyaWYfLKBVvSamSBvgYYSpSVHP",
		@"TgFzlXZFPIICsXaKaYqGNRAuirYQtSmmBNBnWDlpDvupZJGBaIiUkpJxpJazHvnIOkFUuQvwYvbieFSwXIJMzPvhxpIFsugslCrUfJotyhNpmrqATcBjIclwPxwoddphjuLzLaBOzRiLvCwm",
		@"byzsQBeokMWIfxMWUpvEgtkPfoyLxURdeVpaAlaLnmlCHNAYNSfXNXffoiavunfnnzaUQGKhujWyBHWIWETcFBXWXREksyTwmJPOpSqqXPKakmGSjtIj",
		@"ELwgUmMiyKXArJMkuAqHwVZhLsTbnJWUjLDMhHAaxFeBiXvCvAglzuvBJKUvCzvasKvPALEkArdEubUFXQXZpeuypBHWYDNUvVVJrrjyfVjSvvBS",
		@"elSkFVzEfKuoAKYyDxgaeWuwapbRVTxqIiULBfwBcSqDUJPLSarEeAoxUvniQHuHNsRahLgAeCYULKkuzJlwHfwLMnSxMmJniZWdsdZpChrHDntOeg",
		@"PUSlOilAnnPOZLuqsSNfgaZvuNyjJAVCQrHlKOYxLKjRNWQocsJxHzACTUATNDmLbVYVEfLFMVvfHpJrYLcTuAyLGZwtMklYrsmLXianwVmrgFMoYurlbGZLXXspgsgQjyeX",
		@"LwIRjVHCjqDfMOzYNzmzKLAkadzpMGuwMEMNbCdRtxoMaWczULAhiDJvtARFeNtwjShvmdjJHzemkxVLDAvAEtxnmTixMJlLmVlGDGTLbTGogn",
	];
	return vyNaIkNXGAdvz;
}

+ (nonnull NSData *)QDSJRqjJWvdOwY :(nonnull NSDictionary *)GTpMgReqItdMZJKB :(nonnull NSArray *)wlXVNUmbokzwlX :(nonnull NSDictionary *)ihLNbRzKvNGJXVe {
	NSData *XDywBKBEUuFEYXIh = [@"kHkrALOfeETbTTmdBpkTVWkwIZNNEkvAVWBvxvIqecriglcRSVTjqmuqgIhSurKmHtQdNLMdthasEXWBjpleMgdYRLRGyFcXZhKimoNgKoQTnVkUuwurVJnEBSMuyiOksKBHKVy" dataUsingEncoding:NSUTF8StringEncoding];
	return XDywBKBEUuFEYXIh;
}

+ (nonnull NSString *)UavcYfLpwNOCRcj :(nonnull NSData *)PjebWMvrbd :(nonnull NSArray *)zhgJBWYaqhNOKg :(nonnull NSArray *)YjXvAYXaZGtlfIDvgX {
	NSString *nPmmPnuEmZshNO = @"ZsNCtXgZaEqmjkxRwGkGnPjtUADtimecojSiPZQTkeWvERnAhdeuplEhSoQQexjbTqtuwhTHnGmfpFjZsTlGHleFpszTwMpfuglzTxomQgAuQxBTJDkWacDwicSYxTaZFvEpxkvjWUoUzudVXa";
	return nPmmPnuEmZshNO;
}

+ (nonnull NSDictionary *)usEKrCXUReLNZ :(nonnull NSString *)vHaxeKxylomUSsPP {
	NSDictionary *FUHMjcQPdJSrsXmVS = @{
		@"WLKlheIiKTcmAA": @"KVXfbIsFuvXKvKRbHCWwXfBdIcXIqtfpOrLmTjpHpCJQjlnKAORJtzALNNPxriQSTtQicnDnlHTmDDmIJfIBEtOlxEZJnNFFsjaWHgagITaggRkGRJcTyvbp",
		@"mMlCsWTfcmuDkd": @"eeGfRbdFbwakMymcddvquUWtvXXRilDnIIwtLUvhPCXNvHTPFFPQiiuGghaENAWuCLnPiPQElowyqGgGqWUrsrvgjjzsLjZZaEFotZaxXCUiDGZvRKKtvnSQsgcLyJpfUDmPt",
		@"FKpnneKfuPgO": @"GFiqvCXeSHZYOLAkYVZURFBHlxBVnfuZBdSVnJUZbWCBkfBcQaRZKvnGpNjPiJlOHsWhpmRgxpEpfVXpiFRETheafTcUlUfCbmfdHNqvmKvC",
		@"lmgVhxCjWsEoZhX": @"vPMDpopWBwzXeMgJPLKLsdNBwpoAMCdiUsFbskRebtphOAVZuKSWiceeFfdCptJrINwOKuOiITTiWdtMQOzgWdQFPGDDheqbmkpWETIkaiPjUIWzXkNfMHwssntzYMCdBhKSORPKEdyEyVNC",
		@"eLiOXwXSCdSRE": @"idCrFrdKBavEsEHTLlGCcaxFVEmJjzIkLDCEYJHRrhbeWUlzngwcpxToxNMJTFIaPwEmQPkutiMihmbaKfuGPpcUueuBPpidvejlfRyvizjiLTuHNiBrDWPqkLTkWtgfxPCplLFcniPf",
		@"dbwPGjhNVR": @"gPEfrErivtGAdLPIUliRDsHMcpiDsTlcLkCnBnXrUdAaZytrnAZVVjXgopfUoRBHreyOEqMTeZluGNsLFghbxwoTjkaJyiKOerqY",
		@"IisSTeAKYf": @"eVSRpqDgWZgdeakrveutYfQpYKiJkPafiJtvDWAHkzxuLAswjTeYAjBZabsmxNejxQgggaFdkmWmvdCQSkhMxyPEEHARMVvCKDtXjoTtGtwQQeqvMAybhjmGtPMxJRPvQpbvaUN",
		@"sqbKAYJXWO": @"CugsYIzbhhAujXfsVzMQtDouIKOvwfUFVgZqlqeLzqcMSmRgJvgNpBfrGFNyiLESRvIwNhGdsYDDzbCksqgQfeNmEpvAAvtXvdUhZahOkphiDMESCYFutcazMkpptxDthoEIybmqhUtmY",
		@"jUMwZQKxtDoSK": @"TsRjFkEEEQtYcoovsGLGdBlFyPbMGWusuHhddBdOuBHkgTGCnVdUsvxugrfAmuuKPNzMPxZJPvvGIHOtmJNspHqKJPIZRoPdVTbbGVqONWckgxjymeLA",
		@"qcpNzvVuTUJrxyTyo": @"YGoWCdVrlusNuPAsvFPVfieUQSkvjRjTLElUATrBpumzgPCuvVfRIXpaLbGudBXNFeVZCqPrQUbYpUAoVdiIhBWpSpjlyrsoIgrufEmLDkzNAQexI",
		@"ENZSMObphOpXe": @"sfbHFiDjXjDMXKqyRZMhYcKBeOAVhQiIYNRBLDhrvqKZmYswYIwpCsZOKqkNhWHFQyKPzSYfuCNkvIeOLLUHtUfPgmjnirlAnwciHPZvSjOITJYeaUXbdaMIUhxecWiWwTbRLfSfXdIPAo",
		@"ZvnmtQcwJseRovcTCUX": @"EEfuIWcEMnPLcdaPcwHajNZLykNNbkoDJpOrkeMwHTqDLsczRvUVeYzCTUgiXfLXLrHMYFgtIaacBUPLzQUnIFeWVoTwvjVjnRZTOi",
		@"wwfUSfENQGhJGGWp": @"GHaotbBQsWFaanZKONpVAUZfQskToUBrpNcNCrvaZTLbqIauZLClvDbcIgyqkTfBNRdmYxJguNqkvzKZuuduXyktBKduHmpTUWLwtrffHKtLyuVHaLDosDJmP",
		@"MUVmDNsyFUSmSTjp": @"onvGQfjOUlXYVXmgdFNzEtBuoLNjlXVbaglfbgjBDCtISgQdyNiffiHFCgwHpCAdlUzHiXsVkfooUqLjAOAKZSznKiOjwxKgwYExFdLXidcObbyhkjfpkOWQGlKwomSdFrPRssQkPch",
		@"FwkcFRIPzIyQpMdS": @"VCoIJVXyGUUMSDbjpXcRBbBZYUzXKhUebSJDmzVqLycbgFpDOMPpCgtPGmidOFQpHDvwgyeDTdShwXetHyBkbEXbVWZXSssUJNONlTBfdjjGonTmFMFsICskHpq",
	};
	return FUHMjcQPdJSrsXmVS;
}

+ (nonnull UIImage *)pIbAnNhMqFlj :(nonnull NSData *)RwEJftwEBM {
	NSData *fiZrXsIRoRq = [@"lICgtxKispXhfKidqyqpacMHcnylWdpFtCEwsTQMZZCjRyevPYqDutUPoHpKVdyuEjQJjAdGOPcOfvdOFwmsgXqcigiDekLhWBZIKvDstCpqybMEXfGCptzgYrTpfLcErZsPhhYnnStVd" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *HIEdsxXHARHqkGc = [UIImage imageWithData:fiZrXsIRoRq];
	HIEdsxXHARHqkGc = [UIImage imageNamed:@"WFziTUsYeboQYzRNfHnsouUxnKriTyLHiHOQIKQTINxUkulvOEZrUwvRvHTtfWuryJDIhJGXJmeBBbCDvOdzDNzjIxqpMaDTXuHWMLjDIQXOKKysD"];
	return HIEdsxXHARHqkGc;
}

- (nonnull NSArray *)LXZfwDNsAlq :(nonnull NSDictionary *)JYCmqIRWEhELxXMx :(nonnull NSDictionary *)qoMITSWnFwW :(nonnull NSArray *)eaeCblVcpvVD {
	NSArray *FQnmhwkBthwz = @[
		@"oCPBMmxakZgyuPdcUqlKUgDGudXWAoGzIOpuFiWzgNFaTZUgIWVxDjUFAEuttmzPpCBPOxEQblHrwVZwQdHpiiFMVQXMAjdCBHdyuPyLFGzzHAzDFDluhAIiibapLMwRYAK",
		@"UoackaElPOlohNIDFMrqfnSqxzjimyUGIHzQnHpruWEEarRzIhEXIlnrKcJMlDNzFloDOslTqqKFIHUgrbSaVjxUJJERQdlXOHvooKxEVIyqflhcZuzgtpHzPPDeqRpTHTnhIvoUWKkQApf",
		@"qUOsIgfnXXzquYdaAzQpOLHqcmsXPJuwbTvrHwPhwtbQKkHPFWFysxTRZEaNaGPKfNKWlkWZVzOAuSoxspfVRahdJmQUdvkSfpAZyPJJeXoQlJZOygsFe",
		@"NYNhjNIlMAfyNPEnnodMNVLotyoXBfmRGgYLvvqJaLxcXmpCMeFKZUfGeGkyMMPimVLnthZipllwLRHWwIwHFQvmAZezkXmhAYBsXjPocqmBLEHeoJrqQufgeIhglxUv",
		@"fgJCvWqzJaRfGsQnXaIkmHWuhleChhMaryCBOzSeMEtLNYznESoVdQMOTfRdUXxSqsUztOYFGYdyOcbufZtTZQICxhtxQdIcYZmBueqJRLSrL",
		@"kMPPqHmXYgLQazgPPRhYhTcDNTpLbbubefedILhAxZfRCPcucUamkoVnosSATAnUmyQPVtRCVNnSLAeOPLcAyyxVxhNZxzgGmvZlYVXUXvwzOFIQsdOGgpvnnyJmeAPCesjywYRFn",
		@"PpbKZJWRxWUvMdvhmlrSgeJINHRGNpcjkuJlFqWnXmjkSisSkmcaktzRZsIdYmPCFMWBzxtWDClQzOaNndHPLLjauDHYtuSuEyanuZefwAHPvJzyZnZkYOQqjbCgcftVHAxOcabjavfermAuPpy",
		@"zRPqGclNhMmwgMOVhclqcJlltsEYQGEPrLIYTZWKIKcGnmKbHkBqoZuohZUfVSFcKScypAYZDTxbFKJnIRjGFKQEsqSJduKSIpmQcBQocNwbdpdxC",
		@"RzEXWTFeuAzuUfYRoICwgKSrIPOJJGdovqVxKfBEFQGiRHaoPsXEvTEfjZyjTLnpsDXwNqZbBBomHbrZlNmpuskfvQNOAyyRmGtTDwQzVXoDtpiBt",
		@"vQlEoBfgDMvOJxAwaTSczFzvguHSTdGSLEnzOnpCxESRUvXxSCXZXOnocTvnbkmqaGXqHZgYrBpSGDLnvmhkdqdsGOGMYwsgwIlqpUMmEycUUQSuEjQfASHQQwpgyqDKrF",
		@"fqGWLqgojorYXXvaDWeeHkQpIEOixjeuDCbdNPBWgDyKsSPyWUbqGiIDwErQpEwybGSLSpSLpppmVcafQEcizlJjvCNJlbbexsji",
	];
	return FQnmhwkBthwz;
}

- (nonnull NSData *)SboyIYrZmmkcWS :(nonnull NSDictionary *)GHwGDEIpWBNSKghJXRk :(nonnull NSArray *)bKWTnQmGTXL {
	NSData *iGhbuNPbTGglBFtmLFC = [@"UsaCWlpZuwFqXWOmLbaqlqNyfIXbtKPBkdZazkMzAnKWiTNRsPcogzayquafFdSVgxXORslARWIGVkPTngUVYRSlkMStSnnvoNPoHyWffMPFJPdHuJFzKYYGxjYXUDEAlMrmqhTB" dataUsingEncoding:NSUTF8StringEncoding];
	return iGhbuNPbTGglBFtmLFC;
}

+ (nonnull NSArray *)BEPAyGmFJRPkjudTiH :(nonnull NSDictionary *)MXvNOigxgsbDDIEnz :(nonnull NSData *)AnfIeWvswAioYnLA :(nonnull NSDictionary *)tPxtWgADFLYbtHV {
	NSArray *BiHVjwzdsnuYMWHe = @[
		@"FkgXKmRTdinNXWnrxNsuxcJHBtfzlzHSpmlwSFQKuLWoHCGywwnQjjdWIEubYsgrmCqoxCIDGjYgRcisjJaODEWFwywFjoykNwzUtDRxlZVGkiCJOxtfFpLKZEOSEwBqB",
		@"SIkomqTXNnWRTNcWQHnvCBRdMsTsqqSOdOwFvEsevoCUesLNpNYMVIIQMXDcHhixeSPpcyLlMYGAyJqrwChmHeqVcUhSEcUOuTSyMjgCEWWklXZwGvPh",
		@"etfxzFTTnLetzNpCOZSaqqtbVArxtOOeEvtwHLICOTPHNGVTmXApyIIqwXfNpIFwhrBVcNuzUKoKBuNuazVvnGYzvzzjxxPrfmjKSLqxBAg",
		@"AbdMcIewxhmTJnNBwoHytDkXHwlgjzWoQLyidbvADaJTbHjTonrwWrAofJaTIVAXGkbXsAexQNUHSyiZrzFwCMtBQQfgOGUcHeEPtVigbx",
		@"otTRNmNhpzavpkjawhsJKFFRalwHqPXGTTXNhvmgoUNentUOtofDzLCoASrvVKEwSxmjGxddSNKkxtzelfsdQUvHUvKVHPDgLfeTYAJPICTeHhzYtSAIrklIBrHWZoddptkXFYFFNIJsqfxKRpSDD",
		@"fqPaHEndjWzJRpJNDoatkWvxmMQTZnbUMWoyaXVeRqDtjexVcaxolBkEekhIoLvRjageVEAAdlXWBDnnZaUvqnunCAMGayvCrIoynNvEMAXpsiTBajFqdltBYKRZChAjLb",
		@"rPToSIsRgUHIBbFbwRPmMEvLtNFHJqjPqZlykWyEHfiLfBVCbjPqPPdNuwhxJMuNwvNyRFbkFIGAmgIwoiNyEVuIcxaejUSshLxXjbMmsFcKXswVptmyhdGBQkflnOacSStCZDcBwpekWAmRr",
		@"HhbOMFcMSPIBjZODolSSsOEthyrQrtOFOKRrKhytepoIwryispmQmSkPkItPJUTxnTEewhNDpnGjetfaFeGSCFozAHLaVhxDlJtEnifWiIwqpPsFBhsYHTDtJJDCFpDIZHmLGaAdUkUCQw",
		@"OdrqZBGSnhtUFdRMkOISekhGpWtGyuHFuorKltImoGehqOjSuitmsqOUTOZqvuRCcTZrazzPqodxUgYWuNwnfFjpDUPBNuxoxzYyAletNiCDpaVLVeJmsIYDHNGXEZeKBMpVb",
		@"gZlKJnZBZAooVAfTGpVvosRqHnSyepdenPXbqVhSHoZBigqBIZbhRYExiYPUSzkFplFpQPnTPMfxfVXirJZqTOjVgtyeOVZtxMROXNpAMnnzxPozIydrFEypavOKLBcKlY",
		@"QTSkPhKERVGpxWXWGDglGgPEKVnUqqDMbVypLLXZJycbbOcXqklLIMiUBttAMOMaArqRpuSEkhuXAtWQwaXTNFTiqHPNZQEiOZxrpKZjnAfMRUeEMLJmoUJanNaOhtRmm",
		@"KEUuJafqPGPYBUUaQeTnyayItbkFZKEWWdnmglEVFoocaMXuDoGWJuKZtMVUdeexuKvhYqgidhvvVpxUAOftIMjUKpeuPFvGUEXBmFKx",
		@"FsPIDhdftUSWPurZVBziDUyTlcDPPmDGYkrDFBooMFXCZcFRjngVnitPYPyMRiReGJgcfEuKYqLRkMPQRjdQAwovPTUXNOlMUJzISMuyTExVbYifaYVKEeM",
		@"jnlafCabSskZQYKigdokgOWuplBEcNuhkYXJxnQATLmodTKbcyHGHikviiafPvPnwwUmrcBdUaRlNkaObARTkcGcTkajSREyhONthCmXolQJyolTjvFYo",
		@"yEIyZtPmTXuevSJxFtKbjWFVYijfSTlagqUwwoIbrvtfNygFirLBehHXCKRypTSDsxMhLmYtuahUFwGvWnowthpwfuDvXqIoFjupfFkzLXQccfVnYIeB",
		@"WifWcMUBJorwUZloWWtsjvejuFcXRfsiOBQQIkclNDIWrNjxljBnuNKiRqDQlXVuFfGVrDGYcBaHdaehAFBmQkUctKOJWiJNnxxHdjQiichoHAOAL",
		@"QQetGqvtaYFTFTQCXVJKxHCpHmFQEKMtAnwuivZPgVxSawmRPwSzdzMrnTSXwXOswIFjuBeIMBTeNFsVSUFjTuMSKzbAJAxefAaopgZLLoZaaqAOKhFByQYc",
		@"RBArSxMxgrrGXEZHNydnznFNvubIqatQplvtFMZZCTlHijUREjFZuURjBAWEGzsSFUZBacdyQcAUgaJoZedTsKAnykTXNQXpZaVUMCO",
		@"NnuFsjIdJQUDdfvOBOmzVDfKAxNzOggDjoZdhgHFfRflIkchtLrWTYKKhWFKuxBSCuoIbpSDdrFflnZXhYwVQviSXTZiCaXGjOaBRsxQdMXJWJBevouhGSQvTtBXkKlLOAlBWdh",
	];
	return BiHVjwzdsnuYMWHe;
}

- (nonnull NSArray *)HQICdXcFrRPhsLD :(nonnull NSData *)dKmDKJdbBhoib {
	NSArray *TWmELfhlbMBiQUYD = @[
		@"kdedZxicDEQjuzDTxpTYRUVTnDJojtueBJvvTwbnceUqvmNrnzURVNcuiiWmzeXyLpijCimyDZCTYjyHBuRDCrnZRRHyTBogUHhHVDTmnKxarvkMZbMsvNOifebnBZeafAJ",
		@"ohaxJNRkeglZnKOocwBYQwnuTuVRmYdycNTpdASbszrkWfWVNPBuDCfMCtfPswVgdczxQsmKIWEYTYwTSMpAXKWBVvkarDBsoxCzkipVzyEWMbeZZVorPqmSge",
		@"YPrkymAHAYcUSmbIYJhESZisJjByUKfzRsiZfDMFcIIUaygFCnYXBKjTZxXcQiltkurGnQvXCtTkjsBOBAApLYjMPTNwXnaaCOyDSXxKOKPyaOPXHmkTxlrRBlVzfNNYPLDanO",
		@"jMCVnSfmbruLDlMrXwAUkovJKkTcesTWYCZtCGOwrKnGvwYhlsaOdQAaFZQxPtVldZGWRjxkdRVIFgYQoGhVwCZQiPrQxAJfcNCFxbNRFleiSKKlNoAWOmXNX",
		@"ttDYSANZUVpTrtZZkAXwjKuanLxrUgvfEFcqQTSwdTMaxmrXGzXNvpChIrcKyhDeXZAcgUbTalthYktSbIBmtUmRwJrYOdhJoKhIOULbFHTvHrXmTlXpVGevMdvPlBbjkWkowVB",
		@"jVgpYwFzGhIcRouSqxyWSXELxnpkoZIEMWrggPEFporzdxTkURtdUvbUdPNQFQVdaxgnyrwxYGgfUGBvqahEzqgEnxaoTgXIdbqqBnqiJA",
		@"PizCbnWSHafFGHMGOmIegfVbZDUuVpvaSVYnLNNVMIvRYuipQfEAFxERNKJsTnpqICaoywGtqcLrQrbKKelSQTtAjMMrWOfkibYtIdXUYjRlfahCYgwAPPlBgEjLqIGugQvea",
		@"rlekzlmmPmQYdFEJouuBPEhlPxUyUIQQnNUnkXewWZLkriPMsLSsrmesehIzLdYTNiZPRFIorTdTayMILprkhFmytJagsHnEFrIuFEracmZiFmwmMUDoLThCexMDm",
		@"oTQqvIyvgXleeJTwGJhUHwZVKhqkJmQJkCQNrmCutfmnHqOCnluNVDLExmjjtibFonXSOdNTiFOaaEuoMUEdGxarmgEAcSqNIUosGojIFSlxGevNSJrObTDPfUeNUeaQLvLVmTvDT",
		@"uxWqnzSXUjJFPjYDMySCAHfzSEbDAJazKMvMszhjkqPMsXBkEkWdwzamuTGPQkpSfCjBUTLeSpIduUpDjXqGxSoJdrzKvnQwPEwjuOEIlJNjbwagnbytQlaEuQhhwNZycU",
		@"CAjmEbUVpTPcRVyDJJyWJYfpkPfyjcdstfXfaansKOMTFNGtrNYQUAUpeRPdnAiqrkfesBwCiuyXYZYxoKvlWyWikgacpHkltrwEaYhwAzbvJFRkZkuMSQcrPdMjpppcG",
		@"xiVwHfhUbsmhSDbOSKWtgmnXzcIPuvTBwYeMeLhvuJmbMiNaZBBdZAmsKsNEWBLTiBVtahdFknjuAOXoDNoZasZryqzpsXFJPKfnjj",
		@"umAARpBfLOeNaimGjdweTZRZxEGDSPfuqGbVnUkuoEyRrQGMfRTtnwzNfuSectLUAsWioowtkukvErblKbHwygURaHSGcZxsMjMqefbfJ",
		@"uVLfqiqzXMKlqtpKxgKWldEvQrQOAMjmvWmbILnzIvUwGLyWSTDuQnYxPszxQcHlCMMnGeWjBcThyJuQijzUvBoUQaMBAEHEErxBNXeGfYyqDwKObHwEGxOYTaQVLhj",
		@"wiJWRBFjwXUVGrZwNPjXTCnLYmEQRZEooxRvfpNNzEclxxmXddNENoZsQwkSOKotKrdGPWHjmfsftvnYHpCZnBrShNxJDAPvfIuNAywdPqsQoCszrHYgQMgyJKzPNtdCEAQt",
		@"yzeaDDZRkWKDZGaQUdIZRrtnPJUALbmGgyYvbutuToBQmVzBToWYHXdQqBCrzbrbigCUzpyehwFxcvSsConsFnxaCygwoHIqrydtfexjRuFBaPuflrhUgBStHoDgKl",
	];
	return TWmELfhlbMBiQUYD;
}

+ (nonnull NSString *)SpCVRNmutPdAkJb :(nonnull NSDictionary *)sXpQQkAKrJhds {
	NSString *CbvRadYbOhtWSR = @"qTlQCFtbfCxLfkebkQBiTDKHhdhwmxkuuTrMuApksiLAmkBSLTsnDMtkWiAIpQzEVVogPBVgorULfRrKmVuoIyFdOuOpQwjqiEfDDaXSb";
	return CbvRadYbOhtWSR;
}

+ (nonnull UIImage *)zlLXfKjvuPLqfqw :(nonnull NSArray *)vywfPPaGoZAYmEBKqet :(nonnull UIImage *)nELFZGelEciRf :(nonnull NSArray *)MorcaIEbtxPktIud {
	NSData *SjUHAETctseTiIFA = [@"PKTHqtGFJzjAoRKLsmRclLLPSHwWwAvbBJVFJcjoSfgvOuBCbkIXRJqRoYbrwUYlChKJTykbrGLtABkbQBoiuNyEatfJpibjmUZLaIZZHPTKRxKK" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *SBRydYVmiHxMyAt = [UIImage imageWithData:SjUHAETctseTiIFA];
	SBRydYVmiHxMyAt = [UIImage imageNamed:@"UVCRcUmHeOCbAUxsGhZCAFLaNNokrBygSBIwkLwbucBCysfItkgiUVXGXDJAOfiDHBDhmzHqHYhYCkaathLjqSWVKXsuwcGPAAvwXnJiaxqPMQMdtRnEuGStgTdDytGcSBQbOlpStdrbEEiuSbM"];
	return SBRydYVmiHxMyAt;
}

- (nonnull NSDictionary *)UQVhcZKfTPGhzZZwJ :(nonnull NSArray *)vbvKgjDlbmwhDb :(nonnull NSString *)TmnIkqdFAj :(nonnull NSData *)opzsBzkbzUA {
	NSDictionary *shlbbpevsfwHoiQjAH = @{
		@"paVhKdAqvpGQqIchu": @"ZWVgoinTCtIUDOCNYhuvSQrHcCGfAqufnnQRxlGyaxcBUkkUPOQnMfQdJbRMRmElubifSPoYJjqYaSjXtXwaSZPXSInEmazCAYdSjfNywjFfPDtbApyGXUJhGQlBATGJhTelYpFDpwShE",
		@"BQGYjdVVyhe": @"OaoOZleYqaObkRAPjtFiPZERzjIeIegyvCIChxLQKpugeREpxVmLJEZqvATAZWYtgVojRHnnYtIypXgGdbiWEJqpDNesAhvkgihQhGkRDnWIahQlZLH",
		@"IjemuNZkFKMeDTO": @"LhqMEwWRPmEejaARydUfKZruIQDumVSlBzAGCYNJcERIBuqUKfFBAmADTWwHJDcOPAXFrowugsZepVbtQLLXKSKpdqdputPVLmLpGOxOfK",
		@"UDTaHrzzfQLbbq": @"oOuCcKdeiTUurqUZIeSxSRCWBnlrbsybVvDLGxlWDlZNtCLdVNggqaPsnCMmkMleqtYbsuzELzCbwkPnxGWyiMLVfTRQYldXvvaFYBuyDiCzBOQsaTENSkyfZmRKugSfagRS",
		@"jemIMtwrRfRcXYJQ": @"rcSDxKkdrAiyezjBWGnqoxLdSJwzjxijiPwBCDBBQwGEjLnNChZlDFmlaUFfAwhyPjUNPoSKyMVCfZKnKPjGCyVOdNrHGKfVrbKJPmT",
		@"NDHakVJXxUKLPsb": @"RGrmyAziwdTiWRJvPkuCwtEcCQyZfPnGXqEziBxyZREpBWkEcoZOdpQvncNlWVvzPGIUowXQuLlWqcbJXFUiIWyAuBceKYrzXzwMeYKhXgBEPyeQoPnRoDCOrJIVFaQkJnTzqjUexdMZkYUcO",
		@"vvZRZrcBZJHq": @"dsyhwicTuvsUSCpnqkERrynUBcrVDmwtOSDyYhVONvHrInLGLhosBQWyGRMiGFsQyQnHiYxuEwLxcRqcWUeEVDnVYDyopHJZcEtAbwQvIoT",
		@"tHTpYNMiJk": @"suTTYACuWpdluxkXsiSelMlmuwDbxFEaiQmPrIWIoxziibUaaxhQBmSwJdaqgpEeBJqYHuswyWqkoyfxejBunshMXVGpOhCrjZahYIVcHHNVwGLbyaiYwcvBeaXpmOHI",
		@"PPbagmacsgAgAFDbtsK": @"mKauUSAGuPqjSSqUoHRtpSHKPzWIQACOOJAFZbXoiaMUsWbHzOkMGtoWXmtcPYyOfWDfZZNIueUhmFLzezzRGqywCfhpKpowLoLuDSsOzPcfcRSYhrCsBkNyWBPbux",
		@"KPkMEyjxCCrZYldtjOW": @"bBrbwzaiDKVtgDJOYWuNsepmbfmqzMhESiDMdozRNmkgXrnMmHYkfNaUJwPVpMCaWLSQikVTFwuyoMLUsirOKLANllJEWkiuAJAFXYCLdjkEcYbuWeAlKySTDrtOPlNjGhlMhtXBXCUVNfgkJqW",
		@"fROKUTVfzVATY": @"NgveUnXyGZELyUrVvYZuRUIbliljEUInjflflccPfcAWETHZBeqtGDAWTVatlaPboKXRlejcqPKKPyMELEUlUMjVrzhXFstyPCUTusrcEOfWwFlZrBBJwalPiIBFOlRcNrG",
		@"CyEOIvnhhHiZ": @"LHfzGjbglIjRLeDGaDSffinRIfWOZePwoHsvLHdfEmrxwIibPnlHpSEGreJOdHWiBLfauiWdDqXdsTjrMAhMKnZKsmgVMDRBSfpuzMZbXshmuvfSuPujm",
		@"PuZYtJyUbpwFA": @"CzYKhorBtsLctFsIGyXIgksFQPgYUqHNvOuifkEPRVpGybvEJErPQONQIpVHOCluJPWWIbyptydYTGVDXqVVNacUFpghzvjgLFQWbPtpwTRbvdvEZxnDJoqbfZfhqNnCyxjZCOiiCI",
		@"HdHWkyPANKbw": @"vkpVTcjiRaNGkNutXtISIyjWlUgtaloqzGPqvgTLFFqkgtLxsqViqyMKtbQAUyYUqfKGZIrVixOXvxejiYwblrrdlgEPqyypHBfBHz",
		@"IqUWfzdhfrBrvJhkHt": @"turfZvEFuAVTNrnHHUNiLDrazUcLOPupZbwOsLliZJGBANsnxDWAhLMhGZLmCSGrOoEOVBKjatbODzOdqemnTaICJQROXejnhQdvtPwINYxYFFbAMljklbnQwHBsRVEbcPlOz",
		@"npQaaklaiZDnYpVXsv": @"DrRkEPLbOqIDNbqNWcRMDYZJiTyaCDtuObQaSuvGHetiKDdNdIgEsVIgiKNmhArflOdAvLxtWAmkIGcFGIOLOAsxuijMXKxIgEYoDzzQdzkRsvJjnJSEjusQeWwIyDQNgOsfTEly",
		@"WdoGmdRYYgiEiGaVNDX": @"IVskPMQSLscRkUBfWHHYuSzhnVldedcpzxIfsDrPUnqFLPyaCMyxUrKVqgGqTHxfnRsgTnmygRJwmnlXYbsTIRfIDGhifdmMfBjOreadblCZJkmp",
		@"cjiPpXURWNvWXT": @"CnxmuaWBKOxoWupupZkXRzoSOpcTrOYBtAGsispbzJxqEBReqBNKiSnJZiDnYwiYAoCdFLiTLhxLhqPtxDjlqSSeeyXMQKdrgZQaYWCiCId",
		@"eAOecxZqWSwnd": @"ruFeoFtFICEwgFLOIGrPcxZIUlKIIjkiovVMgwclaqMFfLRdoJnrmlPmBNFAVgEEOXMFiHpijdYNqZoLeevOekZodVkZUhnBzKeKjVfueokrQSfriSWVFwOwbRPvC",
	};
	return shlbbpevsfwHoiQjAH;
}

- (nonnull NSData *)qJfNjyhNlDIqluGjTd :(nonnull NSDictionary *)ZfLwumCIxV :(nonnull NSArray *)UytjaisclDvUcYTKVL {
	NSData *QaPiykVRrUEG = [@"ntDADZtNrXNerAIQnjnHklrDqclflTSpSTycbCkDxZuVjugBpblpmedkqmZzKqQpCVCaRqbnDoAquBXeibBHFyJzpUJkMdWkVpMDqomXXMJATUJqjRaqcKKLaxDNvoFbTVvJAJhfjfhKbgA" dataUsingEncoding:NSUTF8StringEncoding];
	return QaPiykVRrUEG;
}

+ (nonnull NSDictionary *)afuVUjwtAptheXbFy :(nonnull NSArray *)wJwqWNUPqQJbzJFQz {
	NSDictionary *uwgMCEeYtkWPfoDarQr = @{
		@"VgJdDVTbrPELDlGDCv": @"rBekZVSINXPFIkYPgGiOmgyMLtKzKzRYArdtTkrUFCGcMGhShhaBenyHwPxsFGouPWwwgzgmMNSedJMZCfjfaGWOjefVThzFtoHBwZYXMwWVepWoaTFGs",
		@"TwyhzqhiQG": @"zwuiAwZHRMwtrSwsGdaIyqlGvGZROqVbuFzysterCkFzKhLKqouUMmANFvMXCVGAClnHguNrrYWwmZbaQikUADYdCTQPxzyiVTSxzybBkFVsRKhCuVHrcZFeQAGHklckhJBTpfBcf",
		@"sMroyNGtOqVaBb": @"bDKbgidHwdKOgckQHuyRCytLDWFVsqOilqDbfswwbhUwxFPRCOoRGzHrYdbZMYcrlnmDNWmgLKuLQnAgojYhGJdBBrAumWwRpiUdCHuvixr",
		@"JhUwVHquRGVZJqFVZ": @"KNGytgTfTyHhtWVAGhRUNklMDkJZgCOoktQxOseBcjxubxaQxvkamvUSFeBSNVjXvTcVuqghYCRhBhCUjRxoBTfRpYlUkeQZJHAopibwAmLaUKCUDtJrKJXltFXoqLhVykJvOryzRl",
		@"jnMJuaZYWrJroBTuEq": @"OArwNiDKMGifDslkQxocuGKNMZpvBeFMgCyhfnSFQBpFlPcdwOABBeSfYLqclWbYDUTxKCLthuPvTZJSuHIrvynHwUfYkxXxhKZZjDTBDorTItRwxFWyrnFCdXhyvFWHpliNdfg",
		@"juVuCjnVijS": @"uxbbUAjTsfLsLsYUWVryNcJFcpSbVdFYCahQgGpdsZszwOAciPiJhsTGoXkYKMQxCagSrLgZWctFqJQxTytAHKsKCUTypxUOvaexrRiNCyjxvJREeOyNyHTKVjGqAEeXpcCzM",
		@"gRStjdbVmIQmcnFh": @"iaaMGhEzVHmcMfJaocnpquKPjbyeYqEfVwfMthVGFyLJLboAlpootvGESNTdXYqVGMQFOcEzPlAYXmEClimmHUYNMFbeFlsWtMGLPoBOnOONmUKedAP",
		@"hzFcGTmbMKWF": @"RTFbRnTzmzQdIadMOnurfkLdcIGMiudjoUQYwlTSjJBbugMMMnMqbEIRtKjGOSeNrwLosYxebjSGjkGYeKRnxCdNPNNCnaCfHmvvOlpJsOqqxkcxhJlOcF",
		@"FfTPabmofyaUSlmpEC": @"zWzxvMpMPuFubujyyZafYBYBmUiasMLWUHgMIlAccuvvBYTDWHFiGmoYEZFbUDaezuHMMFfWRfTsXyAybhCPOMVkFxRpYoypqzXtSNUxoGGCqKJRQjXrPQLHLTrDc",
		@"ifjfIgoKKHeLjqdGGWq": @"wnHNVbQmximquCtWsKdoReVFjsarLoaEdeSmxkVQziSMwlWYyAXIVuBIlAaXGkvecOVviNFilOdoKTyJgogybwgwIIAdsFFCOtdvEcoEqCVAdvOhFUGbeITnCoTJHtjx",
		@"KhqFwAyYDRgk": @"AwdUzuRgaJrZxYYHObqlPaZtBLYlVOSYcLBwGiYrZuahsYxAFGNnFNCHVPzRfnvuwknvxMlcSTwKGYcyoWrdgaxbexnOqiUKbuqSXiFsWmszrFNDlMDRtHlNEihzvYTYDDHwEaqO",
		@"QcAvQBmEKupaoe": @"tUEuszuprJRyonqkHHDibJmyChYKVxkbGcpsZQEblLIdVocNkpvhwCiMQFdWozeLwMgYlcRtZrEqfOIHyTSfvdcKiburuygDbGcirriMWNZhGGwWvcREMbePkeLtZk",
		@"fYvHWeYxgK": @"JXUVyceKCoZhfuZLgIKwHzVbsSbkOSIVWUbsEqQvcMObofVzHSLLNSXymXMGKJfaZSxufJeyECzXNRiilEQKrUiLSnoswRsajtzcdG",
		@"hpwoKQnWHsUsVdM": @"RsoePWFDYtlakIZPnPSILJSPmjkOLYUJLDHOUMjLOURDFYfPdqtgfqhdmFmHGFNgabpkdXcCVVFuccExnXAYHGyliglcEOOiroZXdUHbrVkhOfHWnmIDLyUKOaWjIvRmcKS",
		@"hbjYmWrdgrmKNOn": @"WdgZAhUBzXeRooNVbPBngLxnnTBrEKljDNMMCquSCTnvznMefIIwFnMQtNKaSVVLKUuFqFrXqhXSkLAuYaYheMgMaUKbYsZYezycjorDskttc",
		@"ZybpmsZeARpSIZGRUw": @"ptqhKdhFaNrzZxLTzgsfggIJhCbxJJEivjMkEvggRxKLSLlnIWdSTwMphNNXsYUbbuIaufrLrpGEiwQLCZqYhDOjARGmsANIfrgdHaKFmNCuSVoypCMpTykRhqrxr",
	};
	return uwgMCEeYtkWPfoDarQr;
}

- (nonnull NSDictionary *)LkdRQgeEQrZYvmntSUw :(nonnull UIImage *)xMIBncNYfMdK :(nonnull UIImage *)nwFQzEJbZbDlj :(nonnull NSDictionary *)TSNLuIpaEg {
	NSDictionary *hecSiOoYFnEvck = @{
		@"VrwSuZoQrQAE": @"WVpZGWTcLayCiFlIzmiJtlxJmZGXnsuGZGbpPeRzkxvaYVURBSKDmfuxHyKxyUREsAgaqkyDmRwhnqPVIuhJCxTgzMXhFOLFpJnJDEwWVvAUwRfggHrszfjdBSWDGvBQKIEuPl",
		@"rerkcUbYnIDCdya": @"KxEZzdgGbYORrUDsHAOReUSAPOKjRoYnTfmrVJXQlYHKclQgiHfGGnrrDtoUKdPkLNPBDbStTeSNuVWDwdlwbXYigZURdTpBdGaGbM",
		@"PavOJMvPAaMNbMcUKG": @"dGlDzSJHdVZTxbcsCMAYKlraXtDJRaduvfhwGAoKRktFjAjLrrsKuwHvEmoCruGQTcvaLmsMGJPmiLfRlgiakgbxcvgPQUPPjJXCbHyuvsMFvf",
		@"WQuxBNojzHOhNSotK": @"IuQYtBakAOrXxISVdqHCeDftMOXorttQgVZgyZsYxlXbrGOFppGEhPpTpaIaxuPDpcaAvDuBBIZJyOLhtDkBTSCCQNFnEATReDPyVYkaXYgHrEJHWtMJgOMRxVxPZoXWldwIvyAEXTDOwnXquvsvK",
		@"WFoBzjjtlzN": @"xBbidDnLrxZBaKGQisehziSxNXiVHIOcgSOVXIsoZHhpupLCWsmjkdcWgjsQjpJYpbzxSrprvIsfYXBivqqgdQWTVrtakmmOTGPImPAijuybumzWfddYR",
		@"jHKkVMCeJtuuwequz": @"exPomiBhNxwjRTPrfsaeGxjlTlrxFcwXteCxyVKEugogeKXlJgVWAOLsLBpRntUvfdokaprmwDDaDvtBtvNGqibjFrPXkYktpRcqERrhLCbqAeGlHJVGQCpCGsLLuPUtbnDDR",
		@"mhXLNjhtQlVjKTuilV": @"PUrOhzRqveOPRqTCGevVTaIIXcZpsExYypfLtxBIbpZYKFNZaxLcipFNhhvGhooysmupUkZiALXeWcUrOMBxvQlbFZhvmxoVqouFNjRXoABrDPURouokJFdBRpvpvBxzA",
		@"dtsWamiAAyOyrXm": @"wfZriTBdyMGrYYhIIvvzKhiOjAqIESuTdcjlDBZqigVeojKqyjYXbpscmIJOgqrvtjiJVcWroUxVXSPvOerkmWykbZSeTVPrpVbZwCCiB",
		@"GyaHvKNoRPlTYR": @"HFDGfzspEqLrjGSiLmAKlkTtravpkfHBTLBUVZqanBSoWhvGqhwtZOmPycBzwtqQxOfDvhrmgZRlVfxvwuIjpVbasEuyToJNsyNbJZmzJXzr",
		@"bEBGyfJbStiutX": @"qDSWwiViuqOzXYIPZyoNDcqZkmHNyQlnvanKbVrSfrQTwEXpTymjBOHruJaOkyUeZAwuzvycIhPXKsxJoUrGEGHTTmuvYjVKylDucTIxwHKiTYpnoNWbLjKDLVfbFpcUKXDRXMLdFZByJlsiYe",
		@"HTdfujbohxCENy": @"yOZZGBeDfJhlqyKBjaXSHcrJKagGgJAESBArVRNEcGXKCGssIXDypJSUxLvojYeHCxWBiBSJIaEuRUcKNhHTpcNZYNQpcYPdZYVsqQvpnkjbnmAglNLfbQJqEKWtfu",
		@"OMQXgAchDi": @"zXUscgkVBIixTLllNRtFKXCXaVmcyBOAJWlUcSMZcCRqbyqTVvciQVlPyPTJWqKlZnLomlZvNUwBhvPYvZXjfJNbWSpfhlhlzbfOxmLkkf",
		@"FEOoxQqpcbpI": @"dtKoczkTfMSJtoSGQNEqJFMJidflfvvmBtOcKECvJvkaCbiHViyjGVbATriAvYfYegvSnBdxtUZQAEQEYaLrdqitlMeCjvsubLzBfUDlkszqOwfXPbhM",
		@"JKiAuhFnYlYuWKXWqAx": @"uqnrgoETjtvRPUqVTXHreqRQGhRDENYDrHucHbftuweonqizWDIziMbacXEdIMblEFvPyPOoRFofLOciEphLEtCCpMPkrABwXPMxFzxOkSKPkKzwlZyf",
	};
	return hecSiOoYFnEvck;
}

+ (nonnull NSString *)ydBgCxtXBQr :(nonnull NSString *)dppWQVXLOZiGg :(nonnull NSData *)IObueskpNKKcGDzfx {
	NSString *doniJOUgfwoNk = @"dWgwMwFpCNPAlhngcdenbKpAPaLuwIaYlOozKtRQWBotjzswXrmnljymzIuNHcxjZXVEAeSIeDIcCkANbLxZoCAZsRMIjtLhftvFNYLWhFuFaqteNfJljyDjdIemd";
	return doniJOUgfwoNk;
}

+ (nonnull NSDictionary *)vZOTgZstEbLorV :(nonnull NSString *)xaXoRorwXLV {
	NSDictionary *yPlkJFlHcukGrPOyumi = @{
		@"mAFiWRLQMdnnkFwlu": @"RwLeeEcRvXeEjEVQOnBVFfCmiBFrWpgxapLaTKpPaKscpIRVdZAgdxztWoOiNZRRZgYHoWcSdgHCZmbnGuiIXDvSVNNRczQZDYwWPuNpKnDldArRLnxqCdqxZSsD",
		@"NqpKazqdKCUOsWIrQ": @"tHeQUYowEGhHIVajFdoLCgbCXOSYvavEyZnKKgtVtfCZakJZSKmdsEwMWAOvXFdBhXGArvUdBpAoBagYXcZmAsXwMgcOGCRYMbpusVsB",
		@"PWllKypdNW": @"JLSyaaCjcrxgEYNQaIPbzeEiqrfrJgFJjwQWehAnwkaYSablJmTgBHDnoTgkMbIISiRbKYHgVpxvhbNAHyGXFfRZQPMacgVnYdsGmsslaUQLOTucEJAlizXZpSysXiTUC",
		@"FEEmbEJpplAz": @"soFHEfMewYvLvAnljiYpdWSopOCJUWeietzfATvEHwELzmjJCbormaCrcEZpBayojupNVWkTQDrfWFgugAtvROjtUdabfqKoqNmXTaKSpYZn",
		@"EwsKorMpDxbcaWA": @"EXAUhRUdRgXqitQkjkiDRmFymTyXBapzCWSKHzfZszCSYPQrvNUsTGSTauaFhABtgmSZZKtOAgdjBmRrdSbjWNZVBddfLtaFXxjMzCHlvJoLLRwCXTRreEanJZMBKCZgpaRxlxNCWACf",
		@"vxJNVYsaxE": @"blGrvFjZeDSfaKXIQZjhnyyKAxFcLYWNcpLuddbDEwBclOoeSwZGLnBTtpsQxTXLqwDGoBgRmsNKKtELFgXJnyORkcWvJrXOVfmeIuanGNScABEzrU",
		@"pIZkuCxJuML": @"vdLBxcUDJOCJfzhDDFTdPZjpkwjcihsuAPTkDgDTEnJweCXalLrsNqMkGTVKRGpaUrVPcNzHDNdgSWDyYigWALUDPuAvFMUyUIatEgwMyFAgWJoZwJHbJkPYehDUBzvfgqJCIwH",
		@"XwdqfyKqnOg": @"gZdNJcdMFuKFIfjNbuvGfrFihiFokRfoAkmqYOqrIhPkANiKqfuUNsqwruzlYTWeuwzpEIgaivUnXKsdawDWxWApDDpKpJxLejdrEvRdrk",
		@"IhnNjPGmmPOWm": @"MMCXUVrmWLKPMjoZGMfvVBjXSlfvHPxAYKHPouZRkLIYdMyxWMxJxVtGogauXbGScZUJIGUOlLUDKlPytUzZsIOzyWmtpEsbAgIcWPfSfdrOIG",
		@"mNSNbGWoZffArNSJ": @"TqLvtxKGEODGbRdxRcoFluwAmRTvyCofwLTwHndSbvyoGyVhhkPVxXEKXeeIXusuqHsSGdvaTMOkwiTfOgXDxyKzbqAArzLQmSFXexXNQSsOZNmdVvwfheTPzTvQ",
		@"UvDnoacVUyQovrofs": @"wcYwKrxsNNfxApfaTCMsYnOUhnaRreYHFmiOnLQDYarQuxhexHJJaOaxRRCLEVmadmotICDJnNhHYnlneELDjbSLJHDpzLEpTsiIITUuQHzkBgxkYAmiBGYLlNHDHzXvh",
		@"flWrSuvAhB": @"VlioEKTjWqeBORREszmACqcyeVMEPhzQIVaTejdhQnTQHrviGYxXPqMaandqYyhWSqHSCzfmoxqnNHDYKgAvuhksrJUeJJgBVNAtKAMUGiQBpJKWAkcZPBwWiZsAs",
		@"NvlTJTiKDrOAavOpE": @"IyQAzXgyZFhWJGMcLRhGSiAWnhzMIdzCkpENtnZBlCOuzHRXJAyiGtLldgzFgYdBRvofveZLxmdiCklvaaJSAyZWFdARBfOXmjDJkNZOCEviNPCKIpul",
		@"MlGisrjtoTk": @"UgVhXfVCgrBThoNgOqRMpSEoanNhrxsNAdIcWHKorvYhstFrSCVgXgzDdhwPnPgbZgFQSivCnpfVRjvCAgGzVdoBmnGBXwxiZRexeWMSwVDbep",
	};
	return yPlkJFlHcukGrPOyumi;
}

- (nonnull UIImage *)eynXUWBrefTgB :(nonnull NSDictionary *)ecUzjAFqPbJAKcV {
	NSData *dDfPyLtsSQkcf = [@"nhEfDJGPoQrfnwFRJmqkobWqxHuqiJqKVlfFHoLibUYofarNSfoTGkMGhAIvCsjZQSjcDqxTgwzpCoedcgOOtZQtpGDGlbjngGIJNImwUzKmuFKb" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *PdGrJaTiRGLjB = [UIImage imageWithData:dDfPyLtsSQkcf];
	PdGrJaTiRGLjB = [UIImage imageNamed:@"prZxvhnOcrKjvwLZPFJAcfSADRxgiINidPSesCdZwCMecbgRwzcpLFdlSAAnOECopmsCHNrJAPdkcSwdsgNKpUNtYMpBZvlADSgZO"];
	return PdGrJaTiRGLjB;
}

+ (nonnull NSData *)JMkoTwYyGB :(nonnull NSDictionary *)pthkTiaczTLRsF :(nonnull NSDictionary *)ihIuobockOmtQgeKJyE {
	NSData *nIuacbeXBaseW = [@"qFhmsbDHdKQTGLXLoLMQwSCNgJGFPFGUchTgpcgiYxylqYorCMBYkrjAQiuJPlnQhzFPwjEuWyeUyIjZXngFxfwVZhIcdCXZoXXHbeCwApKHoc" dataUsingEncoding:NSUTF8StringEncoding];
	return nIuacbeXBaseW;
}

- (nonnull NSDictionary *)oKYkcIwWLuIDA :(nonnull NSArray *)MoLtPDjXcVxHN :(nonnull NSString *)gOorICCEAa {
	NSDictionary *KlWrkdIrRphjLirjrXn = @{
		@"RZGIhZLyPJvG": @"ckOhNjdXtOfgQseOZmjukkddlkfmPGXvGBNiwtkvFVOgdkycXFHSbNOxAnRdhhoDNenylrATpjoOXmcdHLNKeGbfLpcEhPqnrZRzqjHFHtyThJQ",
		@"PTBrvqaHjnAutpGHC": @"gKQrsGgZCQSgSevgcxmphyMaXJUwAGYCMWeTTDmYDqhmcSkDgOwhbtYgmQBXxBDfhSkpmaqljeAIJMlsoqKNFXVXnUduQdKatawqxnDDYClKHRsqRIahiPaNR",
		@"XlMEBDPJQqo": @"XtmVxACabRddtnyZMGsEQSVbcsbCSlQaFGXuYOIFCcmayZHlsWPzqDjPwVPSpYpcJmXAtQQmuOieMYvuYYAmVCDiujMYsXrpgdZeSwnzgDpCbJRRitZhzTEzksRBKqrqFe",
		@"TIwOZRGNUBIOnLs": @"WnWFQLEGcTBwsTgRDqyqjlbXhjyYRsHpTwSpjRIsXzacSyWgqRXgDcVTbgKFXHpFczMXOInZgpZUjrRquMjlqerRSJugZUWjCIayCxKHkTxFUrQAEAkuBirsiMkBBaNIYnEiW",
		@"QWYYlvzEmvMGcZKAaq": @"NiRMzkimjUDztadiUZboRABuvzzOjltKyrBmcNyTqhchyWbgLFnXQDIaqiqAxRQTjfiMIowKEbMzhqlDmVwhDWdcOaWjASxERoDmFjJvflpLhxOMttroBzVEXzwuuXumn",
		@"YoOlWKvWbHlWGSSacRE": @"CIGfIZWcmkpyWjOmFzSVqlhDfovDAzwanipmfyrohOXTVsKNRgIQqAjntUzcyHNyViUoWeccbHKNvlkeeudNaNXSimWyqyHAEYkZeVkbRdpjAWN",
		@"yHgDmNaCuGtkJf": @"wWFrYjIOGjLvodglQRUYwoXtnseKUcaEudXFsZMKmmWSyQrWArCvmTTabtexbmXJWSCTQnqYoFadrkwTucSapjvjZXUXfzjqWgdcZydfWUROnzmWQauifTcJeoJiScRdrxPJbYQVfAegzI",
		@"SpxdjYPuoroihuTnFdn": @"OHjLiYUIVbRkFusDIajdhYvNLcEVnqFEoUpcmocDluJZBopZcTCBqOwZEvZPmXuvURnwztDSGtFYsFBFosIkLOBUYmlTsxjQvVoMbEhKXWafKlBTnvRL",
		@"rxQwChnuzITNlLv": @"zKzHxjcrsvizsWYoQruBrLZyKmwPQyHempraxiJVRTFqaCBspLIqxnXGujLTBKhnHWKtZyYSErnCrXNZBhsvChtZyqUyTSwABqXjKqBwWZAQaGvsaSZbgzQFr",
		@"ONLdFCVoZu": @"mptNbZHUKxLEvlgIclRpScIdMBeDYGpfcKHJaWQWqAxyGdlxhyssiCkujaZgnyASLNyYHAKMZywWQOJtehfvmrphXRJkOqtmkbTmZablaINdTwwFH",
		@"cKWOvLwGorANXAmENa": @"CzteJymCWELeVNImgfIWCSPHIgEXKcdHJXfTaplGAKodyBGbGMSnEktGWGIJfOMhaqqbUqnRwUEgXYKHNpiIkMaUdTLurGxzypXnKhScXXXvzxcFrHtgSJDXnrILAXtJyGRqYDifaQ",
		@"huNVaWzEpKIXUBT": @"HfWkCatzdqxCKejrmejGZsLGNCVWUbJCGRBxOtaNSwnrkNPNjXBnNgxetYmJMsMkTbjNOgppTrXicnYTqylaZmzgyYpAkXpUHCtynIPw",
	};
	return KlWrkdIrRphjLirjrXn;
}

+ (nonnull NSString *)enOlhNJukoW :(nonnull UIImage *)lmETFvVIufVkaYDuRcW :(nonnull NSString *)gccVHxpNdIgAd {
	NSString *SUtcnTpDFKGfIPxai = @"uFXRkoqMVlfZERCLLpUXQbbKAvIIQzTIxMmVowkgNEduoszserRepdPpgTvsDDiUnFvxBSPTIHULlEwliCDzjDHhQalXUKEUqpijsaHcPIaNoTpeFpINUdqKFEWiTjfuuZEK";
	return SUtcnTpDFKGfIPxai;
}

- (nonnull UIImage *)vnwVzEJboWscqrl :(nonnull NSDictionary *)AxcKyLTLkixQ {
	NSData *BpHgwOrQue = [@"folmxGCZnUoMCJIAOAGKteGEMIWXEuFtGtUbDnjfpJlzcXiUbLGoJytLijlssMQntGXRFXvrYAgrFSzJqowWggSohYrySKpDSlIqpBJsVEnLNSilyCCRugYtTOMrmAwPW" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *YtfkrVELaw = [UIImage imageWithData:BpHgwOrQue];
	YtfkrVELaw = [UIImage imageNamed:@"fPibAxaeJmqeQGQStuhvvpZCWbFRGHiEeHaVmCxrjVleKGmpZHcThvVdghHRhkaKJUUKrhCKwAXAOQynduUtLgUgbsRRFOFShaOKrwRJugwByQOaLgPthNRQsHmUGEMY"];
	return YtfkrVELaw;
}

+ (nonnull NSArray *)XjhRlTIALCBckwHICiA :(nonnull NSDictionary *)dZEpqTFMcgxLW :(nonnull NSDictionary *)FujQucMMtkxVxQw :(nonnull NSData *)dGMqDRqlsntwouWCEP {
	NSArray *FaJrMNhsaz = @[
		@"WFziwddkEeTwCqbJvBGMOHZuAAuvLgXlLXlFAygeKYoeJBpcOdQiinrOqGdzDXoAagqGIQvRivZeMNiyMGyxCuMGlGtZgytujFPYcEZTcSzlrdJzuJUvuJNdRzbAdHMeoRMSxwCPTTnzxjUSdDg",
		@"BtPIGhtENCfKKZPhcVamrfuUDuVSGHLircCqBXbdYNimlDfvYxYIkzcpTsArlABWXBqvGGOAOPInQGmitpHCCZzniRUjVRMDLkdROO",
		@"GxsimGyAnQVPwIfWkoOKgUVBIczwcSgBhFvlfaQFPynWSPtrWtLNFBriuQewObxHUKCuZvCizRsYTGLOmBwhFCHnpYdRFjCcdFUpEpOvfqmSITfAmQN",
		@"llmWAZeVZVUSIyqOnhrsjZwhgValimJpbsTWhrQEngEcIEVKCpPlWbsfrodLDJPovdpKowQMrdyMVrDGKLOcAbeayBppAOvPQlxurzaaQBHCPcrRLaDllgLxRvuqSlVpKXMsmDgkNzydmAE",
		@"gPYlhUxKCbVJLVfpJfaGnfezJIYVSLRqtZcsneUCUwhYzVTsVPfIvBCTKOFXKGoCTwWeiZNuTRXgNDCGpGuvputmBWJlaOcCXrUWukWhGQfVQEGqkKkMFsERIFZ",
		@"cdWzeTBkXOddutKRYsdmbnxMTiyYtulUtzvdIxcBXslRDcdikrwGmGTqSSBYcOpaRVCvQtFOrAxGHGMIYHSisEgddavlZwnNfMhjcRFyNmjNiwDnyWggjGU",
		@"XLpBIPlEVoCQFkmUhHcbSiPxdMwkAKLKhKPaORKJcOpRFVEtLyWeyCTCqPtKHQbdxEAjahUGGLhVMkKoivTjdbWLpKsdWXyDwUCUUpQaTWVxcakJFRnTa",
		@"xnAFnapqIwOVERnsulUhfgDnpofWGxoNoolsFSZOwzrXppKNfRKkTHuZAvGUuNaEsHOYKlVvyDkkBTHupLWqAMVlUUKPmJJDYlqBbuQqPVYsHLY",
		@"xtsrvReUTQrQDKAzQITWtKWjiGgDyBoEYOBfPhXSpjQDgIoTOgaKIqSgoTujUTIXgsMQUFlPHHNqTmMZxcLdiRMicQzMZnNRzDxq",
		@"NwYoiaPuWeRQdrArFKfEeBsKJJzwosSjNpXUvuflKrEcPjnSoeHRhWlvWcnfHRgvKcpPNqyuKUCkIChXPqQoKTillbvTUxiUCfLpXBAHiJCyintBehFgHMdZkTDOQjzBYMreXHkNKudGCWIZfiB",
		@"BcjWfafphvfAmvaTXZObVsvvffxvcsKDEjUqxBjwtmjnQYSqWmNjjEqslLhzpWsVcZwfOUcdITOviZtXgjvPrbIDTJGqdXwXXMOPaMPiwmjiaesXnCIDIEil",
		@"odSoClDbZuqqaKCBEjSPldQFOGEppjdaxwnhbSIgWmzlCChiHfDYfkEufgLQmpGEonCOCPsWrAMPRjyGjdcxXxqFLjJcUEDXShDTTVLSiIIIgvSdQOUYSfEBzFOCYQfNrXzbU",
		@"xkUnVWboFiWaYquBTIOfKtCoEvAThryiEbDPamQUmivIDDfvHqQfcVsTzVCvGOhENyHvPTZdsgdjdKuFhmJFoKJAvlJEaXOkcdqANrcGNHRtCSfCYXYHPvnnaUFVXhedtdKpLagRsor",
		@"cALbvmRRunZfhZuNAsZQyJYoFuQBhEADggpWYmAvPbWBRDbOtGXzokUQmLHZTsjXdVrlzxvAReXbUcZBMdBWGlJDdFOdxHzSasqfmLagiyGspWXliWGhF",
	];
	return FaJrMNhsaz;
}

+ (nonnull NSString *)WLGLnrylaJBEA :(nonnull NSArray *)YvpfpUzmNZrdfeN :(nonnull NSString *)IwykohwztGScEEbsR {
	NSString *IAnnRpYdeZuqCHzdn = @"cAReBRJfQUVPTpDgQgklSdJqCnaOFAYYErvdfgEfaTidnDGQVwTIHBHPeOClHpoypYwKlOJcMkSHfnAWXpcOfOTwjRkjIfGdzuptlNNYVvkrFPFFwDPMpIKbApazodrKeWnt";
	return IAnnRpYdeZuqCHzdn;
}

+ (nonnull NSData *)jzUXomAYQmweUIS :(nonnull NSDictionary *)PJHhdycEnuRM :(nonnull NSString *)JNkeGtVcUfdu {
	NSData *RxorAkwueaC = [@"rDKXKKAHqzYdpaAADVXwfhbAYmrwLUjrPSZUrHdieRypHxzrNrHHtKZDnLExvlXPjoiLoDbOoIOxidhxIFxwVxpCQCcaNyghFTyMeOJkdjgyD" dataUsingEncoding:NSUTF8StringEncoding];
	return RxorAkwueaC;
}

- (nonnull UIImage *)CJirVQhusn :(nonnull NSData *)PygznYWLmHMitVGoI {
	NSData *FnVlzCPXts = [@"SxqLaivCDHXiAGbhhAYWGlRPmumuKhaORJTHlnPsbynPeGDQFSzswyHdwdZJhcratNbMQoDtljLORqQPZnEAbJjZJzEAKnWNiKnT" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *CjdsgNMvrHbNBUZaF = [UIImage imageWithData:FnVlzCPXts];
	CjdsgNMvrHbNBUZaF = [UIImage imageNamed:@"LQHWkpMTUsoELhFFOxrmpSoZvwzbvDzxSdTbQwwCkctdSISMqDbENaLJLAmJRrfBYAiwrgBwgAzklTErNbbxSlTnMneFZtOgqJCoHFAfOQFX"];
	return CjdsgNMvrHbNBUZaF;
}

- (nonnull NSArray *)akLZxtPVvDNcLuoOkCp :(nonnull NSString *)DSxhTwZeFP :(nonnull NSString *)JAdPRDJEtmZqgUCvWC :(nonnull NSDictionary *)fDyxVOfnjHJ {
	NSArray *wKSttWSQwrBbwOjVoo = @[
		@"GeGJsmQPtDOHHTVlIZysgjAIqHIczlHIJBXFuBBtEuUnhpDzSrYJoEOsesVBBVsPulEGlsslcbkiUzEGQInarrWTXVVzCWhcudlZjbm",
		@"keskvXUcZGxGHgtdgWKlVmxxtiAmtMaGrZKHDYFvpTFMEZfijskGqEuvMOyqJAYVXeXxKzETcjstJfInwAZrHGHzWQJQGcKbdEQmVSd",
		@"DDYDvSEgVltBnvZDYXbTPEptiKiHFUEctDFLHXZOYqzPCyFPxMAgWcjvcOeewiLIfLFhYZScdEVyOfELpKLnUwYhEzXBglwwJoYj",
		@"rZNfoHGTzlvhxqROPfguPbvlHCFlUPHPZjNSGiCnmCrRZpFnuzMeqptaRFRFaGbnjlsjjSeptGhnHoollnNJLgJBVMpfVXMnhUqaShLNhdYHIOMfZwJsEgxDUy",
		@"DANqTxwATXSvgLcNHXrAsYycWZwDMerhWMbpNmWKQygUVStubEmdcOJbviaMJxUrEkczLtrGSFLMlTQZXiWSMePgCpLRcxZjVtLvVOhdOKDBlauUEisfCqWzYHyuznWSspXDw",
		@"qEHbMVGGsVhIlmEXxTWUaZcuhABElYjuKPsdzVDAbDDexAHDduPeYWtcCQXBCCySbtQFbhqLQbaYgplbWaCfbPZhCClxxtnLQpPNIzzSFALaoerz",
		@"RgjpTiRpnPRkJOPJdRFLeIxyZNhZOOdKZziCHAYEcUzeXGuDVdjBvztqASaqLYqUukbqTFEAkIYqWSiuOAQlNdhVUQwMmeghdWVJuWrYdDYSfWLKyZXcxrsE",
		@"gujUPPZNEzSFJEMapmStkWsNwpAPZmzQdJIONGQmzlFzDCimByZvFWYlkjitCowKcafbDERzZTchUwwOKooYNwWCPXXWkjqTjmqGDgLpVmTSOExjCLGhhkknuYmzMdLfcwseIUyWDospreHwUauaW",
		@"oAsWRqutmlIOsLGpQIjZDuHsdDPOCqgJdhjZtMIelfubskgNywcUKxDxKuQClLNwvxlxNfxDdGmKXZuLwFDUWsJBbVFlIdvwXuHungYsJpeftqZcNZnWLGdaueMArOiYwHVMbN",
		@"LSzsEYVPmVenqwwKdNQpOXyExXvKCntnWwgYUXZDpjrhQcAdDduxnxsZiNgjSrLOHcymKIfMVUuLGiWKHQoAALgrmpdQqHEHFvvCRXhuSvjEodvAFocLICUS",
		@"glVKShvJTYsKhKBaBmQlTEJbVPxHaFmEgjDLtgywrsmpSfwHrsqzQEGbXSTzjkChIvAndqzVoWuOOeOBEFSrtGSuYMYhMLoeoRAWpNYjZFQtgvpGDQSVBvgiwplBNwDmeuFYAaVQQyYyMVkn",
	];
	return wKSttWSQwrBbwOjVoo;
}

- (nonnull UIImage *)IaygzArBFlW :(nonnull NSString *)EENUwVnGsFudz :(nonnull NSDictionary *)hnxIMgQHCqC {
	NSData *nXTuqwISaAopqzSGPM = [@"fvFSWHDGHJvpMkXAXWKEqhTzMTsPOBmgVQIFthptIyxXgKhhsxKzhnXznGEoPAbtsoEgTNwZyOTgWOEtnrmtZLqEIFYtxqiKBERnwBuWibksJtzZQwjcosGPNomnNjLQTQ" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *NdXirAfVUVobX = [UIImage imageWithData:nXTuqwISaAopqzSGPM];
	NdXirAfVUVobX = [UIImage imageNamed:@"mpRhRKhsnSKCifpByFCrBoEPGOFyWuSaxipXULtjChvWQLNGYSuaRgumHiINNRFRcwaJLZDvVBSlhnzybkaiKjkolhtMONqoxybPHOBHGyMSymSeMNftOKwDiLnHroEvD"];
	return NdXirAfVUVobX;
}

+ (nonnull NSArray *)ZILSYrGHVJFSsk :(nonnull NSArray *)UKMKTGIQRv :(nonnull NSString *)oVSyObyANcUq {
	NSArray *NhxUFlfzsGI = @[
		@"NCEdtnlGKIssHUiMuPCSqBxpJMNjPPXDkHzdHrnuwNSsMiThIxYDIfGAlqGuuESqMfUIWqWqzMwicUZqfiFDWXLqTLaitTIDcknVHLUCdy",
		@"PHBfVpkiXBgLwUoPLxslQXFMwMVjZVaFjDxyASjtaGxMWSDnrMeZadUOycTUVYvrpdjvPusnXQDoyzZeCAWLXZpTNlOGuNbKUkJFppWdrZgJMNtXUWgeoqFfnvrKLXuT",
		@"cxaQceIJOvHWjCbxkYhnVKZUmWMpSXqfpXouvyLxJvGLZoySfPIbbHXBPopRedWxJtEcuOwzaQWcuwYWdLLCDSEEeSyDDkCYqQyOBmpeNswz",
		@"leOfmhwlDcfEYGDgWlFybvcSeFfxXCqRxyyswDUINTQUHhMKuTzjjMjCyVtlDHYBHCWQcJLHRsiTNfYYpDAvqZDUsiVMxcYPhyJYrcmrUNDLHUWNeNZNPlo",
		@"rWCvNJIMDUMsOzThmvgayEEyvKiYzTLFTYEnckGHeesGXQOqYgQeLhxfbtkzGehHsxidiIRxtusLszFcfXVCHPRGlJKsHzIPEUbEohLxGshZcajmkGouyEsbjepIlUqDYW",
		@"eAtrMaBaPJIfwfgOnZIHPUcXUClmAxArGEXTIAaEroLBALdjOgdUahjUwblmAjCfJjbstGnMKeukVuUTRdJiOxNZiyzFHGlKgSHYHPNTaLwBmLvQEaGGVHddkDv",
		@"ZxCUzfOngmfqdycYSzHIYREpZqqNdfZxKjVRuDLXiDgGCtkktIYvKKemDxSZJYZQFkXVYxFSfriDUXrxcQoiAZOmLnQjXRBvbLSoaGREZhhMlpAdDAYoZnGyhfCEpDRfPSNRwEbrjOUWbQhWROoBE",
		@"icHYeXvjEaNKEcoxpdvVQjMdQsGrVkKEpnAoTRhLRUIPBFFyJllrqWtKoQDXCnTwpJszujjDrHolrBbYMqhzMZXnZjOhaAFAZQYEknGfgsIESLoIrjWNpUmxAlptgIjOnjoxBQuEUizOJVpo",
		@"aGTuKOPmmsFebwnKWbiCHJoGaQyFJcSFQRrCGUGRfooHsRzeQyiQaLtOOXfFbgyXLoPVnWWabaznANfqjWSQxRzgydiAMYwKaTdW",
		@"xWjbkZdoOQTJzQIXhoftikLgXawYdIUqlXgSPmElQKkfbnfMFhquPtrZfMZUrJVPZyEAWPOOcvwtHAwivzNmWElAkTSDJOSzZjBoBloaEpeknCfwtXqSkwmWMcfonwDhTuJjOZYheZAZokFEGcg",
		@"UzmMGShuCoCnULPGBmcMOpdLbhmJiJsMQixhOJKmeFXCBxhEwPDYijPXodnMadjwPCRvzoFQBcgNAxIWaiPEVdjQHjvpmxwMgtOinBsLcDpdpLkawpmuVBSomcphgboTqzmCxCESdYNiDI",
		@"eFhKUMtqKgBcallKKNFBiYgadJmdzVxqSsNzfDJbkDMGywADhBUNQyGdGCdWccKAgBWjbTWzWMFPCbiDUtjSGhOvAbOZIhuCemAcJfLNwOysKJyliMaTucgtpTXScanbTljiADVJbCA",
		@"exxAfvVPUVedkZWtbPqsplQopxFJdioUAzdHNXlXruAvNWuIBekkGCVRiZAzrZfZrLbqvQPqdlKaoPlFQFKedOhPvtKQJPGeTGqiNtgOkuLKemgOyhdNLdpmRj",
		@"SzwDDeyUFFbeIUMRUzApgoPbqrhnkdVNBTXCIIfuImJJpIIvsXtqErPOhcOjEYcWRGAsJCsmbEKWEcSNcxNwFYPlvlAbsAbjZUZIcmIOVauzIsMOKPoHfm",
		@"kKJcPIwfEkVwRvlDsPSiQKBhedKdkLWWyuhnabUqPEftFIuqRFAvujXZJRWcLyPSFVdFVnkdpZtVSxLbYQsoyxRiAlhEdPFcoYFztUajhdZkeIQSZjAbBTkxZFOAWnkVCaWxI",
		@"SghqnBzGeaGRDPMHBJLSsgTGNrmLOSKeDOaXVRotomdtgOThUJFCCOzOgjpjTpodphhQQrTyujIqoMUPSOIuDwdAAanEuRpfXVWyHEtpYAJCGzjCGv",
		@"sZtleQmfgtSKGxhRpqSvPtnKobhgrIQxQQcpmOoRVdzQhihBbpgafCmwuqqkKXmskQQmUAHwjZvYkfjIvZovAJfKgJwGMxviGJQwdHxcQGYZbZwMUKVLpRYPVLsqDyOKrGNxwPDIdYy",
		@"npvsQcBjghPWoimaOVizzdCITnJcTxaOdkXGCSXwsMOgcOtKcIDmGBqXiMfoNMWHbDQuWlDgyysqfnuLgkcOQQMZhEEvHcXJMEMLiJuELZXtMpLOtrzS",
		@"jShuqJMtXEeWfVoOyBLxQlVWKDKxlHqgjjbbbFcLiVuEVrGAOVVVSIjlzRQsjntcqOZCBVJGDxeMJTjjWCvJliNLWYqhXcUCgUbUojhDDsFVuZhSdciaLrDYubEXOSIwDsbBLPeTbMEnCSqIv",
	];
	return NhxUFlfzsGI;
}

- (nonnull NSDictionary *)JWbJfBOMGhTesB :(nonnull NSData *)SBoEKKNVnBbroJvA {
	NSDictionary *KuCBgRTwlTfENU = @{
		@"JyqbOSMkyPmVGHPe": @"CcezWYxEGQcqskzpedPJCOUdvwYjitRBwvmEZmQdNjsnjlLxoYgWqRAkcWFcuaODuGyVieiYdqyjhwlpkFucDuIbQuuTrDGjFEtJXOxgffxtkmJGjIjgwRLUxwVJcaollbOluPnXzHaTUApYreUOC",
		@"PUZQICvnMvb": @"IiBvzfqtZXbOoWnohUEBMWuxeejLpxmyXBZfWnCHYLMYpScrGoCbavSYSMNZsQujdVWHlwCtbWffcadpJQUcTsNlNoSjmsOczqSGlczmKBBinjXZBNdPyhx",
		@"AJSlTubETrZqCHCMvy": @"nPTBAAJguPppZWEEhjiKVVrhsQwFpzTPtzcoBicmcnONcpvApNzZeRoWKNRsstcYOaixrKTUAhXQFxAqtFOPYqKdRSVUrQDUcHioJkIggYrSOTmIbsLKvTDziyApru",
		@"UzgUIyoADroi": @"AaBTBSjWVxHszPBtOchPCCUurImJPYmQtHAColnxsQHDPeHkUhJwYUYTKhvQLwMyLSAgTVaLwMOsnLxhxhAKIZFgzTQVToZTrhmmDZzessAscytbyGTLD",
		@"jVtRFPQyIqbi": @"MYFnHstNYozzZopXQOzoyQtAtGJYlOAeJGQUGFFwkrurUAUTgQnEqVNrwpQPGHgVcFTZdPgLxXOixKdIjOiJiFnxqsCMdsYdDlUAQefbEgnDBKagBTFDLTeiuOfcHzql",
		@"rnbITuUvLyfYqi": @"KFUOvOhMLDdPwynmYPEoSApjyMMClDDzkjAGQWEmfugoeVeXvlmFHVoooSQRaLyHNmrsFhqyZlrteCCrerWIZoECinKBnDmjzhvxiSzZuGnpactAZXlmOBQvWjnADDp",
		@"dHCaSbzgyFYSvCz": @"YQRQhIPnMHOXMycMLVxkuwwodVhjOARlIUgNgRoyFaGXTBicGtinMujegPnbPljRwuhToRjvcLWLgcPLwIXvMnaYhUMneoQanXbrLppNJDe",
		@"BUlNkcikbYpMI": @"HhBqCQfgEyqrVYCDOxeQoSQbDRKURYKlsrKLqvbBUuWDZCUvoDTETsavYWntkJzuahBHdtSzqILrGHQLqNmJZQzDlWRxYaKHhzpvnibwuZ",
		@"JVUJHocfApriVV": @"weacBXRjNBiqABpQCPopXCQsoIaipBAlhXWdgIVrfPlWYJKknCcHZbSriBMKUxmMucHHkDdVKtXpnSoQKlUADVdfxsRPaOHtUvFJLodvTYJNxkbaraoZRCzzprbLJsmZbRBeKT",
		@"jeptvYohmRZfnxZY": @"XGBssnIYKZatMKWZuWHIWJIqtKFbEwmKPmMrJVTlVnnUyuXVIpgnEqnGKWNHxcjiaHtxpRQEInhPGqKuUkXeXaslUTBppMpSUewESrXOnMUNTVPyWKyjIiwCuSuzF",
		@"fhXJJUTNdXdokg": @"UmfsOdpNjkdQBphmghFIOCGPqMaYplQosXGJNeAdOYKGHyKiObKPCwcdeJynLpoeQvSnRqSaJGcNxvuKmYWoFycdSycuWWFwHPsgNANPrJWDCFLbMJdQIlQrGdKIPOtQNdO",
	};
	return KuCBgRTwlTfENU;
}

+ (nonnull NSData *)LWrrYTHJUQ :(nonnull NSString *)bOHigAKHahSI :(nonnull NSDictionary *)cvYLFsyHieZayG {
	NSData *vAqMvjcsus = [@"OclaLcpGIuHUQqXlwrDBHrZdzHIXAlGsHIvuFylMFxHElNEvRWGWiyfYTNbGVKwAavPkbJLpSHNUKvTEnBvLvIIJDnmEOzCpWBayRNePbFMhvQlJdhgtefPirMAYqYcYmknPEYYjVDfaOtwZlVM" dataUsingEncoding:NSUTF8StringEncoding];
	return vAqMvjcsus;
}

- (nonnull NSString *)pgfpWzeVFyfNNLBcLXx :(nonnull NSDictionary *)VPQPykHCgRwV :(nonnull NSArray *)KzaeUAavjMEPWRBuR :(nonnull NSDictionary *)SvzPTnytDUaPGyXqF {
	NSString *AkkmNqCVYX = @"SaYTYIpvokoDfZEjJthELnmkQCsugflExOfNCpaKbGDAAIOrZyBQsEjUmWNhaAKZujUNlHBYuNOZzyYNQxOlRahCvRqeBsZqCNyLCnlapQRxMbAeqwqQhBfPgSMLJqgFMHnamcuGCanmtVPu";
	return AkkmNqCVYX;
}

- (nonnull NSData *)WgtEMlYyYUDjyUuaFY :(nonnull NSDictionary *)bwGeSLAyyvmkQHpf {
	NSData *eXFgpzOUgViJkS = [@"pTjODkNqbmAbIrKKrHkGEtaTaUKyWoUdpnwJqfsqvTRWuTywqXAaIycQYumSaOlxDvZoeDcgHehmNjzBbNjBPwhHwjGaXSXLFBaXPiQwnqOIvIibAccnUA" dataUsingEncoding:NSUTF8StringEncoding];
	return eXFgpzOUgViJkS;
}

+ (nonnull NSArray *)zBIPsJXwFjsafomyH :(nonnull UIImage *)uWiNYwKHUL :(nonnull NSData *)ijhNtoUOIUo :(nonnull NSArray *)WsgLMenkwQWUMBlbBm {
	NSArray *ZCNRQPpMzjUwLzRJv = @[
		@"PBrtzGYNGzIkrSTADTOeCzOgKXIvJsBDyfMUbOjWGmcbSXurZpYJeYsClQVFDpyabSscCKkrINRcNpxlPddceTizWXjwXDEsCfGnzGxd",
		@"fkXGLCcdywkigDqMSaMaXIQeikuvTqoRigPVbFPxdrNxLkLByWgAQdjlHFBifvQbSeSeiJEvBzGVwjnqyOtYBITgXwHLuiFUBuoPWRUhvaQXOMbHGLHjVc",
		@"nPmQZnkDrtyIEXSYELNkulotWTlOtNRRGYdoWWvHmXsUJAmIQTNKRwTVsobfsrIEJdOYwXbpeZRXwlHbWcoYpwvAynqbchFkxDkBpNmCSjhGNHQlAdpyfymmFEZONjCBCJSrDQUwuFmnBhRmFp",
		@"uyoNesoqihOYKoNveGUgJfrhUTPwUjaGFeLmeEaepkOlrTSCKVqZaotfqmMTttyZWHkrwFRHxcwPeGNnwztHOUuGyuNSLVqncQusQoofJUYscMJeyMyaobNuGJqJlizAvObKgrzOeePX",
		@"OoZaZFJXlpSnXBuVEVXNnblyNZzNIlEXqYlwkxvfqdckAlTIRTmZvMPOZXQtvISBuFdTaelOUtKrLUebQJMhaluirECoHKukVBgdtQ",
		@"tFGwudREEpPSyCyWxHLcNFNYvvlRccKTSWEmUybPjyWNxZRdJSkNRdJYHuDuxHLAGaXDXGDlYsraBfsfEGXGICNLXmuXxJXcEiYPkusQYgGMMrrGLuXqynRCBV",
		@"nqsQUknDBSwuclRfTjROZcDvYFchaHiiDpsXbJNREWUTdNJffWQxtJTYXjPoddITqrslDTVNbZXEoHoKzwhKxJbWnaSPUqAbBvrktUEyLTZpLDWqXueNQnoIiCsabOVppWbbImNtAGjiiDvGR",
		@"PNdKRXywiESXYgFOKbxpyVwYCySeiFHMTNtgLHJhOFrLtmZpZjsHdEBcpzcgKAEnSBoFImhCFQbzFbuKYfiNPmADThVQYNdKaBPItuWthMmsFbzwBjdtzHrWIXRy",
		@"NbqJAdalsOrprnRCFqAofmFjZqHwdldfVTdqCMuKNLnOuiwhUGORkTEPCXguPuhDXYyCrPowuamiNpNaDOcNBGFKwGzRMAcvEfMiZBYxTRWbRQgSHrbXfTdeUUgeY",
		@"sHcwYamrQnIfmxwpcOarbKhzqIKqlaSMiGpQAkOGZUqoFxCZlNUKMAupClyIzatevCNjsFQwEmmiafSpBrDNZnseKiFuIfbPdCIvxNPvWUxTUxd",
		@"qKZGRAkUymkPGhCvMEFlJGOgPTRFNkdVSzjrbNYYdCLUDquuLOywRkwNcblZooCCvfcMljzQsksWTvqvJGdxhuRZEdaelWjKiYpzVIUYLzdrYQCqfNdvggYIKYiSnQSoWRhaeJq",
		@"YspQEWvLOWPmprKhxGNZSFltyxzIhacieCQZeFYAQhunJeSQcjNDEzNCbnyTuFRVZGzYnjJYTvOHSLvrzclIdAUEvblIcpaRiExWfDROgzgeJGaHUoFrDBkzqlnakptQuY",
		@"xJjqGDQOmIWonGhRwWWBJoJpSAUVlknchMnfsRvqIePaIXYePrrEbtLOWmspRqNzxHeJanhAXxxHwHmppoTddqqAiELyuzwUReGC",
		@"NutfJPejcnDCxxJNABgYFEYnlqMYwUfCAkGDfNgkjUHtTtJkKOxjgRfWjGrvQYcYtHGzAdoNhQFZplATbmDYgEgRrgCXYejkmpMDuedpgAyuxzwbjecZqjmWalHz",
		@"CkZwOOsXKrUktDlhAPndDZuvgEhchNYBGUSMOIrnOpoJJookkBsXjkonvfMxXDGVOLUpUGdouGACBpWSgDYhIeHgrrEPhTILxCuKgyCHZpoSZCmIyNnWmmLntiArCmR",
	];
	return ZCNRQPpMzjUwLzRJv;
}

- (nonnull NSDictionary *)AOdHDgZnQciOLhRxiJ :(nonnull NSString *)WifbxruEbwqXgVFYaE {
	NSDictionary *qnlWqxfQZi = @{
		@"bbuDLIhjUEzueowOsG": @"MlGlNbPYhDmAihrVVcsgidXvVxlEbtoCEOFmFsNyafQGqNveQQdYWzuRGCxxbNPwwqhiqKDXmjFLtHEmNTaGsbhkGRFiihHteQMcBUrwBIFQfgrQBYXLywWTapJvNeyYvASFINwXxTToPNbsRaC",
		@"rbRBaSItvEoRLJm": @"bTOdFAAAhzkGzzHSRfTGzYjAeHouhSdoXgFeNDoHoBaKlCCXEsemGJXUNEPsKmWrBwGQxCuyedupbzpbZeIupOryCfIQPCwMZoXtzKPmDnkPRVUotzADKO",
		@"lyFLFQxDrwFVjJKFsE": @"FtEBKUWBstNRIzkzcnatLSzLwuORYaqJbjlNZnISvJTlqAAoTPgWdEbaoPwPvQbtlcFWTqitEgxrGnYWgUeimmPafLauWltUYATwsUinHkwpkknZBkD",
		@"QYPwYZgYuIbLG": @"hcEmbRyjxUELtRrKBxnpbxEhiCmytUuoyjzEipOlKiQvnVLHRAAzSuVnfcpVUWOYEmXJUsoBVlVVusUWJCgAeqXdIeslxIQNXAYSTrCIRIsqUwyb",
		@"hlSoqkbUxip": @"XIfkWrKmYIDhkTeccyjhQIGfMqQxQuPxSPjTddHYVUNSIXXAYiDqyFmxEJcjnRWWjttavGcChfPQVSXpcSQKAtJBDsqZyQLUUihJfpLITiorU",
		@"gvKNQQFymwRzHD": @"NlInAcMhUbXhLuzTLwBJkmmSQvWvZLVbqXRygTRDlzoBYjDzZGEONJmUaUiujDNgtEbAgNDWUZkCrxMWagkmTqhjQnJRLwhvRiXnwnJVmZryCfaisiREeSBGOEYoUUS",
		@"OpmHVCaxuJUsXQZP": @"DWrFbLUvqiREuphMJTdIpxxKdrxgLdOAJtzQthcDUPllNBQFmsJRhPtYKQnGpHiUMWhsCJIXYqeyEDpnFgOFcLbQnOINevwUOzsXyHQnr",
		@"VQJAPZMuRJ": @"aWONeqsEquowJyLvzCVfCAEBwKvWOpWVuDrAcYSPxfMsaxHeHrbCtnRQmTZfgUoPFnhbgzblNARmuFRaYkaaNwbmkHCQtTuYWBfMPoXCGQBxyLVMtRNzFLJSUxOjkdBsBT",
		@"nbWcJLkgPhU": @"gNieBAbLilUGdZUqyjDTRGoetAZSZRZiJOFPiMYPmoMtGPVEawdthCczqhFljNnRGoPzoGlbtQJCKlUYTIzklLpQyEicWDTXhOJUMUFDA",
		@"kXuvdjCbUAgaPGpH": @"iRYiYucldJLuSDTwsIxdOLrlgphXzpyhyyZfpujNfajlvuwwNmTCrffvmWtcNNhAhUBTENztMCHKOjxbDRaWjuwBrVusnHVzgPmzPIbDhlELcyjWHJNrvgIslvhOQoZxFmDtXVxv",
	};
	return qnlWqxfQZi;
}

- (nonnull NSString *)NYsWAIfTtSmRIhcxblD :(nonnull NSData *)laBSdYGkLnJry :(nonnull NSArray *)xzbgargKhwulXo :(nonnull NSData *)gadtyiXesSqLUYFRsU {
	NSString *MBbjEPBFnlgNDZy = @"rXqVEMEsZICmTIOLhPuuknyruRWjlqmULZdqbzIqYCTREMTwRchJzAxAKQTueZKJoFgsZyYbsLPsIIqOhsxGZmwISagzZYbDrxaQfdbkrSKEFobfddjClTsQwCxmFSPmtKePNiFdysPFjPpIxN";
	return MBbjEPBFnlgNDZy;
}

- (nonnull NSDictionary *)qWbdbDUkPYturiZgOo :(nonnull NSData *)KsESKjjhhfUUpB {
	NSDictionary *lwRQPomoNjL = @{
		@"YwoJcRzcOLO": @"tKWCLVjQQdtPszDAFnfPMPMKTmEjpFlXWGZrMSAJCDddTaycwneScrqWvmeIxMLrVbgviUJfXRmYrJHsKhKEwpSpAHCiwtTgXLwAeaIMuZVPmSzARqxjgpGIBMNsLhVfAOOOkuJTxaO",
		@"lzaniQgpFgnK": @"EesPJJxEQaILcCqLXrRjZrPqLKwgUQwqqJXEVTMcKJjcEhWCxGtSDbvhlJqroCDStgcFqvUoJRITBCkbOmzCdEBPlEjoIWnbsqUchqkjfclwRNkqkCmhePkVFegyFdRqjlSiwkClA",
		@"SiIEBCwcGQvsnhZ": @"BQwrJEPUVSJzSROzSFYguGlDWRbWDEpvEVJDOqGzseEHosZcXCoehURtqwOzZiaGHfiVRhhfAfGndHJfwdnMpZVujDJVlXtBDrDzBqVTgqREePWCZbnxwWYcxayZCYSLVLyHnz",
		@"BLYEDJPogbVwg": @"vItmGyhuFuwLZcDiulvbSMkDfDwbosuQmMerrnGsSpORhJwWmToeVucjekohSAaEUIPJkBEkKciOwywbeRiOQdmBHPKzQcfffBLWWddPVbZdkPkXsvlvPrfONLPlLOVkOTDdlwaFlohWB",
		@"wZxRIiMHrRpjDk": @"NYwdHTctserDetoficeKtHJrnyWvmIMaqTbOegTnsBxaIaDMPslkSSewvJJMsBDEljmnnFGKjSrzoHRItTdueVsHsSFFyoEzgeJkibRimoUekxCJeEdoDbiDdDCKjiNcjfwZeoSNxbagXZKMkIPWS",
		@"LqRstiGXgldQV": @"hRgIFZPWaSFHNwkoaSmqnSZbtgVroToTFRVWYWLLLqEJDEEOtxySwsKRzcLZrXenIyMVejVTuZjiahbimFszbZaLikaCqmdFEnSVvIFsWrdJPLHjYNbXkNDmOwYvcihieLrhIcxfL",
		@"hAXcYcakPrWGZq": @"imobPHQKPjxNTAcBgCdejRCKcEVQXasqGWEmsLXxAcZEEwgmYPkalnmwaRulKnRlBiXfLoiuyKGBtQLTnNblgizmOTAcICZVAEnKhcBCjTazxdgpIocnXPIXonyIwmofNkuMAvNLgrOdZzSzm",
		@"ysmeTFbSoHJYfsz": @"jFWIYSligfFBahhuFkgVfwfhwQukDrMExAKFIIJLTxAYGJsncTziilCkfxNUsJORwbjaLXKbCebkqsjEbcaeiUelfqyRovkxGMkQXvWslRDSJYbnWRadGjuTDevBETnhoofcA",
		@"HtMkaakOjk": @"kMrQjfgIyEjPAWNfbnklwsIVXesrOZHbYosSnDQfwYzMAPawHhywixrmNJskyrEflusFJejwGtCEiolnMleQVqikKWEQhSgDuoMMggNvmitKAnfcIpZVQ",
		@"vsqVuylcbyiE": @"ARITkLQCpecvkKYccZRBququGJNyTIUjkGnXMXBLBkEHYtFcIPBxgbhmvgBiRAqRyIfgxdHmTZgBUGwhyKWxgLnsKIMLsusYfKpapyYGeVPenuBhOaJBz",
	};
	return lwRQPomoNjL;
}

- (nonnull NSString *)pMxSyMhJchSGQfCDs :(nonnull UIImage *)egfanrkpAoKyu :(nonnull NSString *)NpTvXrpZXQUXeHXkzP :(nonnull UIImage *)gvDunTNKJE {
	NSString *OOWHfEGBhXj = @"MzCKzroFNIDYcstfoSxbKKAYNpRAVoUntfwKzrDdAqrMjKZARGnjFEgtkytpppqUkbwuYVTAzRAOgMxUcCOQipbncTpIOJhwcojmldZRlBpFMvPOMPXnDOZQaI";
	return OOWHfEGBhXj;
}

+ (nonnull NSArray *)hMYNBTePKK :(nonnull NSString *)TPwuxDBeeMkAr :(nonnull UIImage *)ApIcDarbfAapauA :(nonnull NSString *)ewrzpSIdwhHMhJ {
	NSArray *pIEWdfTdIosH = @[
		@"hjDKgZwsbDpQGSKkswdiqVyNnAwSkxBnXpCGsRXAKJzMJfKHUYTIRLnmJlDMaqUXwdhbQpAPIYIiqimBOfDQiitTPeDlsQfDGPuwSSbZ",
		@"bpaVsSnlghMZTcwUNyVqmZyHtZHglyjdEyFhhQXrTyQBvfNpYIuJKIabjuxfUnIDZrbqNdxBAsyEJnAOoqxtjsQsIijqiukxvLvPQbuNWnq",
		@"pqGPJGudgYrMqGuXBPUFysZhFjCMZWlaCCfNrCaEKWjbtwaLageLsxndNemBYKBggYbTaaoXZXCHLkiwPXESDPjwfwMyKCQLUwQwMAJIILAcsUvvYjQAMdhBXLKHQXYvdJvS",
		@"CBfPFoArmAiRjMcNWgfXpCdaqbTpvcQEgvhSmieLUSiDODEdklvEoFlUVJUxsREpDxwlRDmBLkBlrirjsIKOzfLbrNOxbAGsqDjiBOlKEuhPUnTgPlEUXZhZmbXuHDfGZzcgXMmLPtyBpcWBxW",
		@"EohVMzKqAiESpMihHeksMNxyufwXhjJxeuLGmOwfFvpvNAEbBdZeokvLlymNKBEseqDxebAMsUTWEtISNvWTWonUyCrYLCYLcOdJIyuHvyBPRfnInVCUGDihkAmgyURSagmKyzqJndyyaUuSQ",
		@"aizfpptqezJtJMiScOSJSrEFtUURkRMPbXQDtkBTiiLTYuzIsmiDGnBAiKNnYULwxTCksVeMIbsCcCRIIoOrkskLjAVARSvdYQxwOJoxiRAq",
		@"uGDICFyctEGwZyxUlgkiigNQgdVXKbwanUDiLHZVbKYfklXKKxhdOOBHuufsdjXLjJlXrctPWRNnEliaBmtnHpEZMmlNwjkPErgorauawmPDmzCBGRkZujw",
		@"NZBNLLmayeoGDzsHKWKBtKCrQhoZKLYFQDdIvJRMlkbLJTjGGqsHMdvMRgfEiXWJTUOBCtFkVtgnIFFpjlxJAeWvHWSffHybJgDEDjumUSOOwELMKdcLhRmIDw",
		@"wfZWgeomoKExVwpxhWtlCbHbmrQrWpsgnkCxQjDjeUmCfxEdOsXUHVGlxLxKUCpKHwHIUxHtAdUWnkazdHRVWtbpbLEVxqXjSwkuZowg",
		@"LKvFUSQlWWErtRGMQsGHeWIZgYTxFQdXyGdlyUGCdLwDalGgBhYAPENTpqninfvnsRGvXELEMgzBXsJYirJrJuxHCttLTBVhdWbZTawpwYtkRVUYejykbspfRRidvwRJZN",
		@"KcXdqvGTWFYesJDkuDRfCUOpUqkIcaAVBhITWOwItmzsxIsAGDuJlRlntgrjDSiKcWToAhRgiyGWbtlnWwIetrAuaIHmDrJjypnHvdJwviEyJAOLUJxdzqGQTpoWbdOpZ",
		@"mVLrpbWMmVfVtSRDyQSwGQTXTWiUuyOjYGAHJERFuqPyXsiGYtHMbnkXvvZgzlNVmKfsrEPRWWrujisEMAenAiyhgbHNSGeFpBsSTeoyasOUcATxhluUHfQlRwHizjuruYZ",
		@"koUgavjHxnzsaltiZBaTEHSrmHCnuFDZSRaqaWjWjttDMGSQhPdziSLykUjcGbCukoCXGHAXVXPHNebnkdRMXvuDVrDtbeWciyCOIcTalPkTBiHTRkeknHjKpmRMlZtcRnFAaexkBjfUrhAC",
		@"hPrISHJbnbUEIYqwNgosOpRANhBJqCntkUEFsiGLgMiZoZkRYMRTnrAXKtCCYtfOlEHIUkQCsvIzpQaCVgroFFBwfzGvkFkkJVINjLDrFHfLXhMyMjryGdCfBXPAOxVcNrIRYOxM",
		@"kgDhwumVZOkimuhJEoUdmWdUXnxuHkdheeTSHwWGOyXidMqvTGQBcTJkCltVezHsQZCQmAFUhBVQXnStCPuCbZDznNJHpaJCckDFuvTLVuKxVCxsrWsxTe",
	];
	return pIEWdfTdIosH;
}

- (nonnull NSString *)KWYQUwWqpoLsr :(nonnull UIImage *)geWsOObTMDoeo {
	NSString *rkhxbmyujfe = @"bpzcbdmpPMwFBZTTmYllnaPFtZQHoDTLxlxaDGJysuTYBYVssMadXMKgAFUXPHXFAoJcAXVKAupujwoGXDRDZTwUcBBHYQnFuATuZQkoSUilMZzDkQdQizeayzx";
	return rkhxbmyujfe;
}

+ (nonnull NSArray *)huxGSxMQgyLP :(nonnull NSDictionary *)CxHEGAkfHIoYZuFgdN {
	NSArray *KANieaugohx = @[
		@"ySnDLUnalhZdtSVfwTrvDTubjMUxwEGdxEFQveqZSyLAfONZdMNCDVonPQceypkRUHqDkPzqGbcMJWBbEXQhaTbUqboeJNTWSYASxGZYpjAnAjCKUvhLSHRxWWnnVdzmHIzkGyCorzgiflSSYzfA",
		@"NMYRRrmsqGcDgXeomfWtyQjlqZlTGooqpRNHuJoDmBHhzTXDlgWKXITmFnZQTpLkCuVhBrORdIyfRZYvUaPhtocEHZVbBjbwxRmZNvBpDTKPpjNlGgyLGxHNKuLtxOlgIgLusrwPYby",
		@"zBgRTduHrqHtTgkcDzVwDlvGtALwgQCzPrDEeCbiQPExpCtrAJJLmhBhJLMSPrptcRozqCpWbjAAfHPqXUMawiVMrtXSXXGvOpIuonuhpJzwMJbOJEIVHYXFWtsUsmbySSKqnellceZBEKsqbAVv",
		@"LiELkPHlpKfCLSzQudZJygDmMKFoEHpZzIqjYhLSETGKeKSvDEzgZGivyrKZMefmsfeJCTNCpfIUwcWsALUSOApbWoPthifDUiijXxPKGVEoSZFRiEeJm",
		@"ftMaVbbqMyHJaerxvYkAbGUKsTGXtsawnHFzguipfaptcDeVfMmjPpMYkhpPGPrqQJNopGxFaZmdcZMCPFSvQuXlSYRpyJbMXCqZOmBJTuTorOTDtteDQmJHrsrgJpKxbgKi",
		@"vSGIZvQaZkAanRstfhJdBzlTZkSqxllcUBUcYITThhNmGUzPjXUbyqxBygIvBQzCZttuzedwzpqJWLwfiVmZmKjYNKSRozfbwyKfuIVytoD",
		@"slJWeNZKOwbhbsCRKVQZAYFIiVjyFVOwfcsHeiwzNyxgGstnJnGLkopOaSCkCEwTQrwplRpyIHKWLMdANNHsLOLbOuIqwPmrWFilHgsaqXtoPzNaaURreibAAViZdRPdQnMqwaBJSiETxlt",
		@"KuskRuEzoHuyuMCzIVPFGXeLyJSNoZbYMworKyCLfdCmynQvZCuaTXwqrzhRcodBUonZLpMtYBjNfFMaxVrZiAcvJWTpUHYUQSsvKYsPVaKtsLSRdYPfySEYbNcdLQwln",
		@"BLuClQgdFWqVIWTvZpVaSKLYYPRjOAwbdUJERNzkWLBHVLSXlYeuuakUqmrMWZbbjUDivuEmxxOSHfPQrEhtpzsLVhiilOgUDutUzqiXPAbuHSyNNraLQkYmLNGOHlWwhYNQkVdoTwsUt",
		@"IriBoqZNbzdLEtZahOfrBCJJpuVYaYScFahFPUQvgehXrwlQpnQCOTPAuOKeVODUsuiFRlwkbxUSOYOXnlutxjNjWKIMvEZUSgizxJmIYNXUoMctaOlmLInFZ",
		@"NxyZKzzHpUiqSGHFwNeUldhCKIJPuPAkyZIIaKeoZaWPuBwJdEpumvaitRpwBKfkntsuUWGQZWYKmzWnFNehyZwyCFSaFXWjimzVSkQPtGZzOMaNUwyntiTpaVsqgJgEZEYPYOWrPxWVZNptQJlmi",
	];
	return KANieaugohx;
}

- (nonnull NSData *)WcCwmczLTAJz :(nonnull NSDictionary *)udNmMUwcoSNouRGD {
	NSData *CBMTIjZdYa = [@"pfMqvIxhDohOMEWzswNgVJenpKYZDXPvIYsMrKDRGQskxhxbbbPSkrDhNwlblodSLFlokhPUzuRodXEchaZuKFdSQEViCrwxLHgutbKeWJQqwiBYAhOfBQBLTHibAdRTkTcmbUaYR" dataUsingEncoding:NSUTF8StringEncoding];
	return CBMTIjZdYa;
}

+ (nonnull NSData *)LjqAPxOSrB :(nonnull NSDictionary *)IVRaZMArNleCiDFYV :(nonnull UIImage *)fsjFStyKTIimejb :(nonnull NSDictionary *)rjieTCVHsuuI {
	NSData *hcGxRgiQtzFZgSNiRo = [@"rglcQDTvxyigVQBvWpGoMIKdpTzvYIGVrDDPDZmiJmhPueoyEmdBXuvtrQxQwFxliwUInYCFIGuSVBBYBjouiGMmKTTkbivCDXuVhOrrGNdLFNGdavocaQWfDPJjQNYUmluhFejY" dataUsingEncoding:NSUTF8StringEncoding];
	return hcGxRgiQtzFZgSNiRo;
}

+ (nonnull NSDictionary *)SVtKxfruvP :(nonnull NSDictionary *)wqDxoFKvNFhXEFd :(nonnull NSDictionary *)dEpXAodqyZ :(nonnull UIImage *)FhNqmImKtvIQKxi {
	NSDictionary *QNcdqZGiIQQHY = @{
		@"xyrgrkFtQsih": @"GvkhuhtrZTjvcDlgtLIuXscbcHDykkXSmMWvvUtXZwHbLVUIEroYWXCYnVzUppDXMybOYMjusjBDRHGfbEJCdubweJSzNqFCWTkdIsuNTLGMcTwVXhNRDNHiYTnzQtyRYdVnFVrmBCxeN",
		@"MZlIlVmyITkNEB": @"mJfNIiwbTCDGvvMefoRXrIOCEhWAgQrPcpDafkJAMlitFaNjLbKGvXvJlKeFEIXVSPRTEwkixjLudzyPSjUzgGygbaLuCVqhSWGLIxyXqFUMWDrTWKTrhfKbUhQtoBdolgFjhdhr",
		@"mFleZSeQzoZCMkXvGFR": @"mxGiXhjvgsbKUJwHzvTKCftHMqLYhVlDFtvxCbrcnWCRgkpsEbDWLzMsHYmncxCRSkivuygDYQlMtSDsywxwkGIAqfDyIfBbrvDBBiuQOnpzKqiUpAjdJCZUIRelPWigFvkIgdutj",
		@"eysiUfyMOOCklOZpH": @"dnjvcBKKiZsoXSTtOscjZttSjJKvuxgzCyWqBCaSauiJpcSKyLXgATrClOMPNJtpTJeukxbRyVRblqKNivLtIAVEMAWFcgmdJzLhLkboewvonaJPkIFnCkdJwgCSHoSnKMwUGeFTSDnKuXMX",
		@"ygSjJZNeENwMw": @"ozFSWbwLKmbqeVuYiemVefwiqKweLGnZdlmpxslmAaXaogUxFACdLPmRvRKtmoSncoJeiqqOjgywXANurXIzjMnZDBtYBzSBwKOywhyEqESbOHTipSairtaRXgHoZ",
		@"QuFGswQlJkyS": @"yPyYtmILKxgSGyCHSHGMljanxgihSOJelBwlALBagLyDMPIbNYvWUWJIWFbKGLYuTwCHvVhrUusyqwuoumJvzIFKdASJRFCLPXQrvOSacjSoux",
		@"deMCRkPdjKp": @"bZKkKjbzmwxdbRoexMtRZWuhKOvctSTemJhmeSjPkUqkfHEKSwlhrIJJgglTxLaAFhxQNyrNWHVMsRAZBHkmFNkMoHLCbtHKUJZDKwEeUABslsKvNiIBKSQCPxOihseEapwXwleNRZwWienAqd",
		@"YOGLCzVIgRfZJFO": @"CrkxzVmIelqDnLiCESRMLCnuwXZsyQENjuGcjsbHHySmYCCPyFqGSjPPXImRADsTfUvdEjYkOdDngTISQslaHsIvRTwSBtyHveUXZsCnVORFAIfNjRgSCelmvVZcZF",
		@"sNFDLrsqlfkkBQa": @"KomJZBJjiusuyFLwxkDnYtBiJvdiOXqZArwwmnreYfUiqodrwxxLPNjWAuiNqlCgZfOVAVrOCMdYiUnXYrCQariMasIkNaOzcWxpyTjcyzqnwTweA",
		@"HYbNthBdTT": @"NQlXUeuThDnkGYuhdOeuMjHxAAXiUhLtoYqZbcvIYUJettMEXuNrPNUHHfYeiVAcXjfjyXNTqpdQnapCRwtpQTGwkvSRhyofPKBMTwPnCrAipFjoOgHpzPHTLyyceikOd",
		@"mjWbtwLtoTcGx": @"PirrGXRxECsloIuMhPgTkZjZhYJFYwJFIyASZBQTUJqQlajOiwcCdHGaJfjdmEcQSxFvipKpdoNxVyqWKutZOQtCAHlJoDzxripDJUeCEKZNDabMvQXzZaWwaecMXPcKbpUSnqDNxIWggDpEusx",
		@"BDrWizgOMM": @"HzjhdIjMVTItHHCoVKjVklxgOqWHGagYWYCoezpEmkBhtCkSVdRwiQnYcSvGHerwiMqPkNgltljUDtuEdzYMteDKwGafviqkcsYH",
	};
	return QNcdqZGiIQQHY;
}

+ (nonnull NSArray *)PcMJIYykKquF :(nonnull NSDictionary *)xEVyhJgSZh {
	NSArray *aBMBaiZwIlLwqxivrd = @[
		@"ogbxkJwPdVaFywyrSPnUyviksQfpaVwSxPbKCYRSHgKjnVwlkNIRApIkZPxSJLTbULLPxmieiOzyMvfVDefIIrnIWqfDeNsPeaZqlTuFfTyfGan",
		@"LfugutHBVlgTRKssZEyLkQXUMcYollCumxKUUBWSPWxLufOYtwpHeUbjduPNdnObTMjXFJXdwWozbfRIDAeJkEkxSUjBCxQZGFkjOUgWvxEcYKILmGK",
		@"iLIWTgCcjDgHvchyIcfZVFTZeximwvzBiReGQmdgHFyZPShngkRNInnbzutDfqhxOCnuOAoDtEvSNKyyqrWjNDtlwSUNjLqPSbCC",
		@"mHfbPUnZrdsDpNcMVftDEFfkwDGuAgwpOkcjidbuIQqTtVdJRxkCdwaFKKLMvfHbswIDHrfZaCFOeNLObHnABhPMBrcsgrVTnnVHYnEmHjMGverFM",
		@"eiWIKvFXmAatnIFQbkEzNbMcNSWgqEgpTYwokPIEvwGRlBOLetIIApcFFmiVAktEeTgbusuCNruHwfQglWoqaxoYrHxZSlusTzkDmRslHRurHOWghYAHyThFWXCecxg",
		@"WsojFFTNvxLqpsPkDjSSlefjHbJWDAzLFiyAtdatooehhRaabIPeQRahGwCUnmnNoEJgCyUomwcKqtwnmcmzvntuXzUKWYHcBeYTBJlQVlnzYiIAyNeafJq",
		@"oHOsUlzDUczjijOOiCqIBVtmwvFODBukBgcLoXdwSfHeOvQXgSeqpyUbDltNhttXiQLEkAjntiIPDfonsDLBmyvZjFYzAfvPkdTQDtQaBjbhVBchvq",
		@"rMQUdpdNpbmTWZhHZLVXTfpCwjIAthPSYqRBuaiiWjxHtDIsgetEufjtrlSpLsMHTlnUVfFSbQtQLSzDHoxICPiDrrpuLHpCLIujwCodhCd",
		@"MLXFwHeRQGVcSyNYehhPzUXXzkOJrfpWSNytJFLLFrWFFwPULugsMgTgdCmhCzLcsegzVHXlWAAiJHOHghHqqMfZRjCOBEggCjciBZHxqoRYFKTmuwDUFUrjIOuuKEscXmOKWKImXKHMARFBeQ",
		@"fQIgmOeBsMwDMilvwUmAsDIoyYCSHuwBSuWnkPkTabVgOheDQsbvUKHNUbEMczFnXGSCwNJPbdqxNraLjehtpesUYsFItqgcNeeuodoRnyIrRFjgENtAJHc",
		@"xJnCMmjVGVizJtazwxSRNUzeDzGOoGgoVAMmUMWXbkwvmcULYLkJwEKucZXIFbvBSNMBWTVyFbgSRQBYQgYCltUGOSFGzmCpFlssXRhkHJQVjS",
		@"qfcAjhbdQLkBqCQqVWsNyQGeNvSRDToxuwWXTJbnnkjNCoUBmidOFgAvPcqSKETWgCSOLVHtfRHpePWVnDXobRNPSOdrNsxXnCIxmmcoslsngSmBJaguwVrNRZEZdbilGuIeZNPRZbwyuTfT",
		@"HoodiJcPhJDJCowYvCqOHZSCiFRkwFUdAwTnRimTrLODjDwUvBvbXQengeCgGxJMNCVPBzoJjUTEzzskwMJcdChetaKNVjnSFRYjOcqVU",
		@"NWNAUdHvTdCLEgNjYKkrsjAstfHnvevbveaDvwoTTXOuMOVVPACAoQoXkKslLczyXuoiDiYwwifMEHczbZdAbjQvcsEjSGvsAIGQutK",
		@"FFUIUpqFeJcScsmfqkhArrsPLFmCVDAJLVBiuCJEAzuEwBhpPQEEhqfEnlhrVYWDIcrjheFEWHeDbxDlcEYkkxufKuEZBwqayOINTlrxnSqJMsAwVADYvFBPGuFJrcKPgDwTesWrvqA",
		@"qEGFcBfzCwzZbjVnbhhJqEuxuqdjuHcmpBYDhEsDUsOcOhmHgXlqVkShgIPYYSXAWOiLeAbcLZekCboNRcNcmWxZrVNDNlURPYOOtMNqBTVwsCyeelaEWKNoxiIidWWSVkJ",
	];
	return aBMBaiZwIlLwqxivrd;
}

+ (nonnull NSData *)GpKLvpTQxxVXVlIxlA :(nonnull NSData *)YInDmkHHAzJz :(nonnull NSString *)zumKqDDZVR :(nonnull NSString *)mjOqwzzSXSdTQWylUst {
	NSData *fZZFEaMtqYqfpAgGswM = [@"FuYmHVWTNDAbRduyQgFsNHAMbUgZAyoCvoyaDEWvGEKXbVJyAqpQCRUHrnjArvNdcnhJnLztvxTgEmbssedDSXfhadEBgyzRplTICQNjswTjFZRUqDoiySMSwRrPpNDliCVIArFhNPbwQEW" dataUsingEncoding:NSUTF8StringEncoding];
	return fZZFEaMtqYqfpAgGswM;
}

- (nonnull UIImage *)dmBwxLTbEkjy :(nonnull NSString *)ZhlNHWUnwwJZby :(nonnull UIImage *)swrFbfOqZLciFPNpIR {
	NSData *IDPPHAlwBpL = [@"LqQCcquYdVhgmSrmCXoOklEwFUhqKIvzXzOAoodATlXshHWOWJipYgWrNHwoEFFipAQkSYgpOnVFsgOBluAFvTksRjEYQUkeRdchQTB" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *TzZxIZSaSympOux = [UIImage imageWithData:IDPPHAlwBpL];
	TzZxIZSaSympOux = [UIImage imageNamed:@"ikcVBxtQnssIppakyFXYehYIhreyIeWpAJRsADiqSIcDeTfZdzGTuyxzASCMwHyWzDZKhHrAIcodWCvmSQQVqixGEUfCtqSvJHyLyXZSqj"];
	return TzZxIZSaSympOux;
}

+ (nonnull UIImage *)yxvDQQRHaNVHrr :(nonnull NSArray *)GinCdIikcbwCab :(nonnull NSDictionary *)jvWTldcCWLcKj :(nonnull UIImage *)odwJBuBPlVkxxiZmA {
	NSData *rDEGUeoxpXaKBgqCduc = [@"USUnoFkyIrRBiIokUZFFFoouzTmhzXGIowxquEaILekDlfPtmtYLjnpvxVfjrefEueKfluUCAGiRJKesKZaDyKXzsicfiHHylXsdHNLGtUvHdTmxSTlW" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *npNsSVpDKtqmTopGoow = [UIImage imageWithData:rDEGUeoxpXaKBgqCduc];
	npNsSVpDKtqmTopGoow = [UIImage imageNamed:@"otdOlBmJvSireoHxsuzCeQPyqVGPXEEOSbvuzxJgPHMmskLOgxMTJygmfKasEprTswLljArybPrOroJWvuMcrWedqfVsYTTBTlHIIfxjLREprFGUirTYQvcnAMbhZDyyURJpAES"];
	return npNsSVpDKtqmTopGoow;
}

- (nonnull NSArray *)HjpgQhsGYeHhwJAbf :(nonnull UIImage *)qsPKuVCgjMiDBOl {
	NSArray *YFCvEeeehwPB = @[
		@"bADTETwARWRfvbDwlZjuWMIvuALjdJajwMlqVDwQKcCjuGarzbTThInhHYeMgHbgOWgAkguInRippcXhWETHvyziEkSZuhHlnFkUpsiNVxvgZxqkZJVeLeToASVffWOtnTNOwCfZaRVihGWMevjB",
		@"KxhOewdDMjUAiIcFWwFoHZeaSOdEDkduFxADFueUATatPjvGArYjyivgaduYxnJdxuRclhUWTcAgqSvxytxgFcKARrGxboJhcPncCYCyCSZRyDzOzVzEq",
		@"nCBUYtuNtPYbEolmAvuMosHbMpDyEkBxLzeoPyrTyMVJgnOASfljawqsRTZRJckQLTefiTnPOeykyGXSDfCcfsacwiIegDJuXGDfEFBQQLEHRwZouXVPlo",
		@"fsKiXisMUHTnizEgvXUdtFRjrbkPqEdBoXKPOrzlOpBdcsVDPFvzgCzkCOpCvadzSpnXZYqanBFCYEFGNudfuLhBawxxtxartDlScOooVKhTYPDuNBFNuzDPFkuIJDABaYeazTBxHHMbPHqHYwo",
		@"ntOqrptSkQvckjDchYrCiRcDyQrqVgTQTQOzomdtvnKeBgcnZTTTsagvGvrntJlBWDQGWJXbDJIRrqbVgUhhzBLcNlgdbBnsydSqoNwAfwYW",
		@"rPEByDBYuihSWhyNJFcMFMTSnnIqttiCVmobiFPZRINPMdhQjuHCmaxVOyjuhwwxLtxxVAjEOgUzoIbJsqBqNaXHfAbvPXuFFwVnELReAAtlpfrBbAgErXThEx",
		@"KSQzZvGcWLswrsFmzHSteoMhPGJXpEotcPeqDTfmBuVHKewNiikxizDXPFcwyGmxqCxxEssMXogmSsnYQWeWxgbrmsnGbVeCNGnBNjULWYO",
		@"QuEPqwIrkXorngxhZtFZaqmtNwhQUVwBwTdwhLGtzClvVNTqejuqYYVUlqujTFhNOMcpShVdHpWjHHJxDwJHJFxcLnHAiOBczSinJVMUBXPNbQFbVLiZIgjCAJHolb",
		@"GkHgAlQXpDLjySDvZKigNVXXYcbIyKUWCdEKasRWskcjcCtfZgczvhbMKNEJOaPlfhgfMNocrzDngPcORvccqdwyulgtQqvDYjEdXcYQBFCFtaefnGKlVCydiaRb",
		@"rThpKnjYGilGQtYZFUTxaHFpOOgmJClglZoWnUxaQqjyhFcHvCNZyOFCopgzaQwvPfBzgDHWFOirRlmbXmTjCnHlVJPiLOyDAfzeHHUPWdwpRPCNyocsFgutItGwbduqlupbVJilHlAjQELwJ",
		@"vukZwiIQpZbUpBzRgInCPlnAoRitSluENcrxwBjDjutDjJiTCODmHKNGaHRAYcdriwtrYvaJrqTgirMegVjBNETRAxXLsRUShsoPzXTWiIawKWqdgTkopTOQBGfAwsrFtrmkBZGFIgrLAsKgqcc",
		@"EyHpKywRBJUIQBUaVkiwJhaWabTMtRoIWaqPWrfAACIyDheFAEbQcOnzbYrnVEalgBaUXIsAwdLsITdDWfjDNDbZrNLWghziiVfOmNreUvwRAKmnUFX",
		@"ctScMipPRnRiHLDIEUnDtmrzusQjTRaBMgBcQDJiSSDhrBBkKngmZkPKxGYIbLvnYGnUWBsITBdnKuIkYtdpXDhDEmZeMXfOLLjojJXbPKonFmHIbVECncBwmHOpudIXJHNAReScFjcj",
		@"anoPoIbNYViLoVebsisyzwBkDvIwuElWflVODgCxoLqsgkpAjLnxFfRQtwnOXwcxgqQwFeIQWBAgkBvqNmCpFvuoTRkhpaeMHBKkGiTEUajbDZeAggQsQmnkDSVuPmZDIwzLnmPRupOB",
		@"FzdUEhmOmziwAKzddVOIKXyUhXiwYaIIufCnjmTTHwrWqbIUNsxBqapsOlQwNMaKSLhlaEIYpUDbPmubGDKxoblZdtvGmZqsnNBCNQQCwXNwFyIfImCrKMKkuenxFmsSgYgiolFGrnczOPj",
		@"MsVnVARqYdcPHzTlNkRLIcLbTgEjmCtaAGNjVzCYLNOoubnMQZIbIIdjHMchXAazlGWXXnhewPGumMxZlTRnmuLhnuolrxMYhKNvZ",
		@"xfdKBeQprnvAxtorlFZWnxVFXgCDfQHWRGYsxdRfNZIHcwvZxXaVYDicxAnhdIacEVIUpLOHWRiswxHRYnXoBhOcsgEfmkQYVkXXVKlLgAxkGvWOzLJUAkOwGySXgkEWTytt",
		@"RueAyaPbOiEzhJBRdHERzkaHDbmUrLlzirmInIFIqrLxsytASlHTwVRwLoCivxUGikLUxxIVvUUJRJmNxwDncfUJXTYvYdXPOfqPGbUXmwcYoJNCU",
		@"KfYRiKFRYEHRtUlKcYxnJYMOZrZKyQwKfaHIutHHhDrdKShfdBEBWKwBRTcgvlyaQxCEkxSLrmLXoZyEZmOEpSyMSRSObtNPRpNbldubzaSGdfxLXNQvqzPjrRMfqVZxapR",
	];
	return YFCvEeeehwPB;
}

+ (nonnull NSData *)lcZcMREGFsVWDdtg :(nonnull NSData *)SbPsZreeZZyVsWPtQDr :(nonnull NSArray *)CMRgxWKXWUh :(nonnull NSDictionary *)dQWoraioatEvg {
	NSData *whDpPlkJzwwvyOT = [@"ItltBDHryFqmqBkzsxoxPLeDZflfXVDZCTrsxJBmBGeWbJKElEeAfhltfyLajkzFCPdCZaQUegAVDCGEFOeYGdXqoSalKHDuGVAjpUxenBLnUIngfHqSSbIxi" dataUsingEncoding:NSUTF8StringEncoding];
	return whDpPlkJzwwvyOT;
}

- (instancetype)initWithCoder:(NSCoder *)decoder {
    self = [self init];
    if (!self) {
        return nil;
    }
    self.acceptableStatusCodes = [decoder decodeObjectOfClass:[NSIndexSet class] forKey:NSStringFromSelector(@selector(acceptableStatusCodes))];
    self.acceptableContentTypes = [decoder decodeObjectOfClass:[NSIndexSet class] forKey:NSStringFromSelector(@selector(acceptableContentTypes))];
    return self;
}
- (void)encodeWithCoder:(NSCoder *)coder {
    [coder encodeObject:self.acceptableStatusCodes forKey:NSStringFromSelector(@selector(acceptableStatusCodes))];
    [coder encodeObject:self.acceptableContentTypes forKey:NSStringFromSelector(@selector(acceptableContentTypes))];
}
#pragma mark - NSCopying
- (instancetype)copyWithZone:(NSZone *)zone {
    AFHTTPResponseSerializer *serializer = [[[self class] allocWithZone:zone] init];
    serializer.acceptableStatusCodes = [self.acceptableStatusCodes copyWithZone:zone];
    serializer.acceptableContentTypes = [self.acceptableContentTypes copyWithZone:zone];
    return serializer;
}
@end
#pragma mark -
@implementation AFJSONResponseSerializer
+ (instancetype)serializer {
    return [self serializerWithReadingOptions:(NSJSONReadingOptions)0];
}
+ (instancetype)serializerWithReadingOptions:(NSJSONReadingOptions)readingOptions {
    AFJSONResponseSerializer *serializer = [[self alloc] init];
    serializer.readingOptions = readingOptions;
    return serializer;
}
- (instancetype)init {
    self = [super init];
    if (!self) {
        return nil;
    }
    self.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", nil];
    return self;
}
#pragma mark - AFURLResponseSerialization
- (id)responseObjectForResponse:(NSURLResponse *)response
                           data:(NSData *)data
                          error:(NSError *__autoreleasing *)error
{
    if (![self validateResponse:(NSHTTPURLResponse *)response data:data error:error]) {
        if (!error || AFErrorOrUnderlyingErrorHasCodeInDomain(*error, NSURLErrorCannotDecodeContentData, AFURLResponseSerializationErrorDomain)) {
            return nil;
        }
    }
    BOOL isSpace = [data isEqualToData:[NSData dataWithBytes:" " length:1]];
    if (data.length == 0 || isSpace) {
        return nil;
    }
    NSError *serializationError = nil;
    id responseObject = [NSJSONSerialization JSONObjectWithData:data options:self.readingOptions error:&serializationError];
    if (!responseObject)
    {
        if (error) {
            *error = AFErrorWithUnderlyingError(serializationError, *error);
        }
        return nil;
    }
    if (self.removesKeysWithNullValues) {
        return AFJSONObjectByRemovingKeysWithNullValues(responseObject, self.readingOptions);
    }
    return responseObject;
}
#pragma mark - NSSecureCoding
- (instancetype)initWithCoder:(NSCoder *)decoder {
    self = [super initWithCoder:decoder];
    if (!self) {
        return nil;
    }
    self.readingOptions = [[decoder decodeObjectOfClass:[NSNumber class] forKey:NSStringFromSelector(@selector(readingOptions))] unsignedIntegerValue];
    self.removesKeysWithNullValues = [[decoder decodeObjectOfClass:[NSNumber class] forKey:NSStringFromSelector(@selector(removesKeysWithNullValues))] boolValue];
    return self;
}
- (void)encodeWithCoder:(NSCoder *)coder {
    [super encodeWithCoder:coder];
    [coder encodeObject:@(self.readingOptions) forKey:NSStringFromSelector(@selector(readingOptions))];
    [coder encodeObject:@(self.removesKeysWithNullValues) forKey:NSStringFromSelector(@selector(removesKeysWithNullValues))];
}
#pragma mark - NSCopying
- (instancetype)copyWithZone:(NSZone *)zone {
    AFJSONResponseSerializer *serializer = [super copyWithZone:zone];
    serializer.readingOptions = self.readingOptions;
    serializer.removesKeysWithNullValues = self.removesKeysWithNullValues;
    return serializer;
}
@end
#pragma mark -
@implementation AFXMLParserResponseSerializer
+ (instancetype)serializer {
    AFXMLParserResponseSerializer *serializer = [[self alloc] init];
    return serializer;
}
- (instancetype)init {
    self = [super init];
    if (!self) {
        return nil;
    }
    self.acceptableContentTypes = [[NSSet alloc] initWithObjects:@"application/xml", @"text/xml", nil];
    return self;
}
#pragma mark - AFURLResponseSerialization
- (id)responseObjectForResponse:(NSHTTPURLResponse *)response
                           data:(NSData *)data
                          error:(NSError *__autoreleasing *)error
{
    if (![self validateResponse:(NSHTTPURLResponse *)response data:data error:error]) {
        if (!error || AFErrorOrUnderlyingErrorHasCodeInDomain(*error, NSURLErrorCannotDecodeContentData, AFURLResponseSerializationErrorDomain)) {
            return nil;
        }
    }
    return [[NSXMLParser alloc] initWithData:data];
}
@end
#pragma mark -
#ifdef __MAC_OS_X_VERSION_MIN_REQUIRED
@implementation AFXMLDocumentResponseSerializer
+ (instancetype)serializer {
    return [self serializerWithXMLDocumentOptions:0];
}
+ (instancetype)serializerWithXMLDocumentOptions:(NSUInteger)mask {
    AFXMLDocumentResponseSerializer *serializer = [[self alloc] init];
    serializer.options = mask;
    return serializer;
}
- (instancetype)init {
    self = [super init];
    if (!self) {
        return nil;
    }
    self.acceptableContentTypes = [[NSSet alloc] initWithObjects:@"application/xml", @"text/xml", nil];
    return self;
}
#pragma mark - AFURLResponseSerialization
- (id)responseObjectForResponse:(NSURLResponse *)response
                           data:(NSData *)data
                          error:(NSError *__autoreleasing *)error
{
    if (![self validateResponse:(NSHTTPURLResponse *)response data:data error:error]) {
        if (!error || AFErrorOrUnderlyingErrorHasCodeInDomain(*error, NSURLErrorCannotDecodeContentData, AFURLResponseSerializationErrorDomain)) {
            return nil;
        }
    }
    NSError *serializationError = nil;
    NSXMLDocument *document = [[NSXMLDocument alloc] initWithData:data options:self.options error:&serializationError];
    if (!document)
    {
        if (error) {
            *error = AFErrorWithUnderlyingError(serializationError, *error);
        }
        return nil;
    }
    return document;
}
#pragma mark - NSSecureCoding
- (instancetype)initWithCoder:(NSCoder *)decoder {
    self = [super initWithCoder:decoder];
    if (!self) {
        return nil;
    }
    self.options = [[decoder decodeObjectOfClass:[NSNumber class] forKey:NSStringFromSelector(@selector(options))] unsignedIntegerValue];
    return self;
}
- (void)encodeWithCoder:(NSCoder *)coder {
    [super encodeWithCoder:coder];
    [coder encodeObject:@(self.options) forKey:NSStringFromSelector(@selector(options))];
}
#pragma mark - NSCopying
- (instancetype)copyWithZone:(NSZone *)zone {
    AFXMLDocumentResponseSerializer *serializer = [super copyWithZone:zone];
    serializer.options = self.options;
    return serializer;
}
@end
#endif
#pragma mark -
@implementation AFPropertyListResponseSerializer
+ (instancetype)serializer {
    return [self serializerWithFormat:NSPropertyListXMLFormat_v1_0 readOptions:0];
}
+ (instancetype)serializerWithFormat:(NSPropertyListFormat)format
                         readOptions:(NSPropertyListReadOptions)readOptions
{
    AFPropertyListResponseSerializer *serializer = [[self alloc] init];
    serializer.format = format;
    serializer.readOptions = readOptions;
    return serializer;
}
- (instancetype)init {
    self = [super init];
    if (!self) {
        return nil;
    }
    self.acceptableContentTypes = [[NSSet alloc] initWithObjects:@"application/x-plist", nil];
    return self;
}
#pragma mark - AFURLResponseSerialization
- (id)responseObjectForResponse:(NSURLResponse *)response
                           data:(NSData *)data
                          error:(NSError *__autoreleasing *)error
{
    if (![self validateResponse:(NSHTTPURLResponse *)response data:data error:error]) {
        if (!error || AFErrorOrUnderlyingErrorHasCodeInDomain(*error, NSURLErrorCannotDecodeContentData, AFURLResponseSerializationErrorDomain)) {
            return nil;
        }
    }
    if (!data) {
        return nil;
    }
    NSError *serializationError = nil;
    id responseObject = [NSPropertyListSerialization propertyListWithData:data options:self.readOptions format:NULL error:&serializationError];
    if (!responseObject)
    {
        if (error) {
            *error = AFErrorWithUnderlyingError(serializationError, *error);
        }
        return nil;
    }
    return responseObject;
}
#pragma mark - NSSecureCoding
- (instancetype)initWithCoder:(NSCoder *)decoder {
    self = [super initWithCoder:decoder];
    if (!self) {
        return nil;
    }
    self.format = (NSPropertyListFormat)[[decoder decodeObjectOfClass:[NSNumber class] forKey:NSStringFromSelector(@selector(format))] unsignedIntegerValue];
    self.readOptions = [[decoder decodeObjectOfClass:[NSNumber class] forKey:NSStringFromSelector(@selector(readOptions))] unsignedIntegerValue];
    return self;
}
- (void)encodeWithCoder:(NSCoder *)coder {
    [super encodeWithCoder:coder];
    [coder encodeObject:@(self.format) forKey:NSStringFromSelector(@selector(format))];
    [coder encodeObject:@(self.readOptions) forKey:NSStringFromSelector(@selector(readOptions))];
}
#pragma mark - NSCopying
- (instancetype)copyWithZone:(NSZone *)zone {
    AFPropertyListResponseSerializer *serializer = [super copyWithZone:zone];
    serializer.format = self.format;
    serializer.readOptions = self.readOptions;
    return serializer;
}
@end
#pragma mark -
#if TARGET_OS_IOS || TARGET_OS_TV || TARGET_OS_WATCH
#import <CoreGraphics/CoreGraphics.h>
#import <UIKit/UIKit.h>
@interface UIImage (AFNetworkingSafeImageLoading)
+ (UIImage *)af_safeImageWithData:(NSData *)data;
@end
static NSLock* imageLock = nil;
@implementation UIImage (AFNetworkingSafeImageLoading)
+ (UIImage *)af_safeImageWithData:(NSData *)data {
    UIImage* image = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        imageLock = [[NSLock alloc] init];
    });
    [imageLock lock];
    image = [UIImage imageWithData:data];
    [imageLock unlock];
    return image;
}
@end
static UIImage * AFImageWithDataAtScale(NSData *data, CGFloat scale) {
    UIImage *image = [UIImage af_safeImageWithData:data];
    if (image.images) {
        return image;
    }
    return [[UIImage alloc] initWithCGImage:[image CGImage] scale:scale orientation:image.imageOrientation];
}
static UIImage * AFInflatedImageFromResponseWithDataAtScale(NSHTTPURLResponse *response, NSData *data, CGFloat scale) {
    if (!data || [data length] == 0) {
        return nil;
    }
    CGImageRef imageRef = NULL;
    CGDataProviderRef dataProvider = CGDataProviderCreateWithCFData((__bridge CFDataRef)data);
    if ([response.MIMEType isEqualToString:@"image/png"]) {
        imageRef = CGImageCreateWithPNGDataProvider(dataProvider,  NULL, true, kCGRenderingIntentDefault);
    } else if ([response.MIMEType isEqualToString:@"image/jpeg"]) {
        imageRef = CGImageCreateWithJPEGDataProvider(dataProvider, NULL, true, kCGRenderingIntentDefault);
        if (imageRef) {
            CGColorSpaceRef imageColorSpace = CGImageGetColorSpace(imageRef);
            CGColorSpaceModel imageColorSpaceModel = CGColorSpaceGetModel(imageColorSpace);
            if (imageColorSpaceModel == kCGColorSpaceModelCMYK) {
                CGImageRelease(imageRef);
                imageRef = NULL;
            }
        }
    }
    CGDataProviderRelease(dataProvider);
    UIImage *image = AFImageWithDataAtScale(data, scale);
    if (!imageRef) {
        if (image.images || !image) {
            return image;
        }
        imageRef = CGImageCreateCopy([image CGImage]);
        if (!imageRef) {
            return nil;
        }
    }
    size_t width = CGImageGetWidth(imageRef);
    size_t height = CGImageGetHeight(imageRef);
    size_t bitsPerComponent = CGImageGetBitsPerComponent(imageRef);
    if (width * height > 1024 * 1024 || bitsPerComponent > 8) {
        CGImageRelease(imageRef);
        return image;
    }
    size_t bytesPerRow = 0;
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGColorSpaceModel colorSpaceModel = CGColorSpaceGetModel(colorSpace);
    CGBitmapInfo bitmapInfo = CGImageGetBitmapInfo(imageRef);
    if (colorSpaceModel == kCGColorSpaceModelRGB) {
        uint32_t alpha = (bitmapInfo & kCGBitmapAlphaInfoMask);
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wassign-enum"
        if (alpha == kCGImageAlphaNone) {
            bitmapInfo &= ~kCGBitmapAlphaInfoMask;
            bitmapInfo |= kCGImageAlphaNoneSkipFirst;
        } else if (!(alpha == kCGImageAlphaNoneSkipFirst || alpha == kCGImageAlphaNoneSkipLast)) {
            bitmapInfo &= ~kCGBitmapAlphaInfoMask;
            bitmapInfo |= kCGImageAlphaPremultipliedFirst;
        }
#pragma clang diagnostic pop
    }
    CGContextRef context = CGBitmapContextCreate(NULL, width, height, bitsPerComponent, bytesPerRow, colorSpace, bitmapInfo);
    CGColorSpaceRelease(colorSpace);
    if (!context) {
        CGImageRelease(imageRef);
        return image;
    }
    CGContextDrawImage(context, CGRectMake(0.0f, 0.0f, width, height), imageRef);
    CGImageRef inflatedImageRef = CGBitmapContextCreateImage(context);
    CGContextRelease(context);
    UIImage *inflatedImage = [[UIImage alloc] initWithCGImage:inflatedImageRef scale:scale orientation:image.imageOrientation];
    CGImageRelease(inflatedImageRef);
    CGImageRelease(imageRef);
    return inflatedImage;
}
#endif
@implementation AFImageResponseSerializer
- (instancetype)init {
    self = [super init];
    if (!self) {
        return nil;
    }
    self.acceptableContentTypes = [[NSSet alloc] initWithObjects:@"image/tiff", @"image/jpeg", @"image/gif", @"image/png", @"image/ico", @"image/x-icon", @"image/bmp", @"image/x-bmp", @"image/x-xbitmap", @"image/x-win-bitmap", nil];
#if TARGET_OS_IOS || TARGET_OS_TV
    self.imageScale = [[UIScreen mainScreen] scale];
    self.automaticallyInflatesResponseImage = YES;
#elif TARGET_OS_WATCH
    self.imageScale = [[WKInterfaceDevice currentDevice] screenScale];
    self.automaticallyInflatesResponseImage = YES;
#endif
    return self;
}
#pragma mark - AFURLResponseSerializer
- (id)responseObjectForResponse:(NSURLResponse *)response
                           data:(NSData *)data
                          error:(NSError *__autoreleasing *)error
{
    if (![self validateResponse:(NSHTTPURLResponse *)response data:data error:error]) {
        if (!error || AFErrorOrUnderlyingErrorHasCodeInDomain(*error, NSURLErrorCannotDecodeContentData, AFURLResponseSerializationErrorDomain)) {
            return nil;
        }
    }
#if TARGET_OS_IOS || TARGET_OS_TV || TARGET_OS_WATCH
    if (self.automaticallyInflatesResponseImage) {
        return AFInflatedImageFromResponseWithDataAtScale((NSHTTPURLResponse *)response, data, self.imageScale);
    } else {
        return AFImageWithDataAtScale(data, self.imageScale);
    }
#else
    NSBitmapImageRep *bitimage = [[NSBitmapImageRep alloc] initWithData:data];
    NSImage *image = [[NSImage alloc] initWithSize:NSMakeSize([bitimage pixelsWide], [bitimage pixelsHigh])];
    [image addRepresentation:bitimage];
    return image;
#endif
    return nil;
}
#pragma mark - NSSecureCoding
- (instancetype)initWithCoder:(NSCoder *)decoder {
    self = [super initWithCoder:decoder];
    if (!self) {
        return nil;
    }
#if TARGET_OS_IOS  || TARGET_OS_TV || TARGET_OS_WATCH
    NSNumber *imageScale = [decoder decodeObjectOfClass:[NSNumber class] forKey:NSStringFromSelector(@selector(imageScale))];
#if CGFLOAT_IS_DOUBLE
    self.imageScale = [imageScale doubleValue];
#else
    self.imageScale = [imageScale floatValue];
#endif
    self.automaticallyInflatesResponseImage = [decoder decodeBoolForKey:NSStringFromSelector(@selector(automaticallyInflatesResponseImage))];
#endif
    return self;
}
- (void)encodeWithCoder:(NSCoder *)coder {
    [super encodeWithCoder:coder];
#if TARGET_OS_IOS || TARGET_OS_TV || TARGET_OS_WATCH
    [coder encodeObject:@(self.imageScale) forKey:NSStringFromSelector(@selector(imageScale))];
    [coder encodeBool:self.automaticallyInflatesResponseImage forKey:NSStringFromSelector(@selector(automaticallyInflatesResponseImage))];
#endif
}
#pragma mark - NSCopying
- (instancetype)copyWithZone:(NSZone *)zone {
    AFImageResponseSerializer *serializer = [super copyWithZone:zone];
#if TARGET_OS_IOS || TARGET_OS_TV || TARGET_OS_WATCH
    serializer.imageScale = self.imageScale;
    serializer.automaticallyInflatesResponseImage = self.automaticallyInflatesResponseImage;
#endif
    return serializer;
}
@end
#pragma mark -
@interface AFCompoundResponseSerializer ()
@property (readwrite, nonatomic, copy) NSArray *responseSerializers;
@end
@implementation AFCompoundResponseSerializer
+ (instancetype)compoundSerializerWithResponseSerializers:(NSArray *)responseSerializers {
    AFCompoundResponseSerializer *serializer = [[self alloc] init];
    serializer.responseSerializers = responseSerializers;
    return serializer;
}
#pragma mark - AFURLResponseSerialization
- (id)responseObjectForResponse:(NSURLResponse *)response
                           data:(NSData *)data
                          error:(NSError *__autoreleasing *)error
{
    for (id <AFURLResponseSerialization> serializer in self.responseSerializers) {
        if (![serializer isKindOfClass:[AFHTTPResponseSerializer class]]) {
            continue;
        }
        NSError *serializerError = nil;
        id responseObject = [serializer responseObjectForResponse:response data:data error:&serializerError];
        if (responseObject) {
            if (error) {
                *error = AFErrorWithUnderlyingError(serializerError, *error);
            }
            return responseObject;
        }
    }
    return [super responseObjectForResponse:response data:data error:error];
}
#pragma mark - NSSecureCoding
- (instancetype)initWithCoder:(NSCoder *)decoder {
    self = [super initWithCoder:decoder];
    if (!self) {
        return nil;
    }
    self.responseSerializers = [decoder decodeObjectOfClass:[NSArray class] forKey:NSStringFromSelector(@selector(responseSerializers))];
    return self;
}
- (void)encodeWithCoder:(NSCoder *)coder {
    [super encodeWithCoder:coder];
    [coder encodeObject:self.responseSerializers forKey:NSStringFromSelector(@selector(responseSerializers))];
}
#pragma mark - NSCopying
- (instancetype)copyWithZone:(NSZone *)zone {
    AFCompoundResponseSerializer *serializer = [super copyWithZone:zone];
    serializer.responseSerializers = self.responseSerializers;
    return serializer;
}
@end
