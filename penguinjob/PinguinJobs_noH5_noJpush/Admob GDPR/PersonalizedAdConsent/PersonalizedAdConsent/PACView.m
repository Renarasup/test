#import "PACView.h"
#import "PACError.h"
typedef NSString *PACFormStatusKey NS_STRING_ENUM;
static PACFormStatusKey const PACFormStatusKeyError = @"error";
static PACFormStatusKey const PACFormStatusKeyUserPrefersAdFree = @"ad_free";
static NSString *_Nullable PACJSONStringForDictionary(NSDictionary *_Nonnull dictionary) {
  NSCAssert([NSJSONSerialization isValidJSONObject:dictionary], @"Must be valid JSON object.");
  NSData *data = [NSJSONSerialization dataWithJSONObject:dictionary options:0 error:NULL];
  if (!data.length) {
    return @"{}";
  }
  NSString *JSONString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
  return JSONString;
}
static NSString *_Nonnull PACShortAppName(void) {
  NSBundle *mainBundle = [NSBundle mainBundle];
  NSDictionary *localizedInfoDictionary = [mainBundle localizedInfoDictionary];
  NSString *shortAppName = localizedInfoDictionary[@"CFBundleDisplayName"];
  if (shortAppName) {
    return shortAppName;
  }
  NSDictionary *infoDictionary = [mainBundle infoDictionary];
  shortAppName = infoDictionary[@"CFBundleDisplayName"];
  if (shortAppName) {
    return shortAppName;
  }
  shortAppName = localizedInfoDictionary[@"CFBundleName"];
  if (shortAppName) {
    return shortAppName;
  }
  shortAppName = infoDictionary[@"CFBundleName"];
  if (shortAppName) {
    return shortAppName;
  }
  return @"";
}
static NSString *_Nonnull PACIconDataURIString(void) {
  NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
  NSArray<NSString *> *iconFiles =
      infoDictionary[@"CFBundleIcons"][@"CFBundlePrimaryIcon"][@"CFBundleIconFiles"];
  NSString *iconName = iconFiles.lastObject;
  if (!iconName) {
    return @"";
  }
  UIImage *iconImage = [UIImage imageNamed:iconName];
  NSData *iconData = UIImagePNGRepresentation(iconImage);
  NSString *iconBase64String = [iconData base64EncodedStringWithOptions:0];
  return [@"data:image/png;base64," stringByAppendingString:iconBase64String];
}
static NSString *_Nonnull PACCreateJavaScriptCommandString(NSString *_Nonnull functionName,
                                                           NSDictionary *_Nonnull arguments) {
  NSDictionary *wrappedArgs = @{ @"args" : arguments };
  NSString *wrappedArgsJSONString = PACJSONStringForDictionary(wrappedArgs);
  NSString *command = [[NSString alloc]
      initWithFormat:@"setTimeout(function(){%@(%@);}, 1);", functionName, wrappedArgsJSONString];
  return command;
}
static BOOL PACIsErrorStatusString(NSString *_Nonnull statusString) {
  NSRange range =
      [statusString rangeOfString:@"error" options:NSAnchoredSearch | NSCaseInsensitiveSearch];
  return range.location != NSNotFound;
}
static NSDictionary<NSString *, NSString *> *_Nonnull
PACQueryParametersFromURL(NSURL *_Nonnull URL) {
  NSString *queryString = URL.query;
  if (!queryString) {
    NSString *resourceSpecifier = URL.resourceSpecifier;
    NSRange questionPosition = [resourceSpecifier rangeOfString:@"?"];
    if (questionPosition.location != NSNotFound) {
      queryString = [URL.resourceSpecifier
          substringFromIndex:questionPosition.location + questionPosition.length];
    }
  }
  NSArray<NSString *> *keyValuePairStrings = [queryString componentsSeparatedByString:@"&"];
  NSMutableDictionary *parameterDictionary = [[NSMutableDictionary alloc] init];
  [keyValuePairStrings
      enumerateObjectsUsingBlock:^(NSString *pairString, NSUInteger idx, BOOL *stop) {
        NSArray<NSString *> *keyValuePair = [pairString componentsSeparatedByString:@"="];
        if (keyValuePair.count != 2) {
          return;
        }
        NSString *key = keyValuePair.firstObject.stringByRemovingPercentEncoding;
        NSString *value = keyValuePair.lastObject.stringByRemovingPercentEncoding;
        if (value && key) {
          parameterDictionary[key] = value;
        }
      }];
  return parameterDictionary;
}
@interface PACView () <UIWebViewDelegate>
@end
@implementation PACView {
  UIWebView *_webView;
  NSDictionary<PACFormKey, id> *_formInformation;
  PACLoadCompletion _loadCompletionHandler;
}
- (instancetype)initWithFrame:(CGRect)frame {
  self = [super initWithFrame:frame];
  if (self) {
    self.backgroundColor = UIColor.clearColor;
    self.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    _webView = [[UIWebView alloc] initWithFrame:frame];
    _webView.delegate = self;
    _webView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    _webView.backgroundColor = UIColor.clearColor;
    _webView.opaque = NO;
    _webView.scrollView.bounces = NO;
    [self addSubview:_webView];
  }
  return self;
}
- (void)loadWithFormInformation:(nonnull NSDictionary<PACFormKey, id> *)formInformation
              completionHandler:(nonnull PACLoadCompletion)handler {
  formInformation = [formInformation copy];
  PACLoadCompletion wrappedHandler = ^(NSError *_Nullable error) {
    if (handler) {
      handler(error);
    }
  };
  dispatch_async(dispatch_get_main_queue(), ^{
    if (self->_loadCompletionHandler) {
      NSError *error = PACErrorWithDescription(@"Another load is in progress.");
      wrappedHandler(error);
      return;
    }
    self->_formInformation = formInformation;
    self->_loadCompletionHandler = wrappedHandler;
    [self loadWebView];
  });
}
- (nullable NSBundle *)resourceBundleForBundle:(nonnull NSBundle *)bundle {
  NSURL *resourceBundleURL =
      [bundle URLForResource:@"PersonalizedAdConsent" withExtension:@"bundle"];
  if (resourceBundleURL) {
    return [NSBundle bundleWithURL:resourceBundleURL];
  }
  return nil;
}
- (void)loadWebView {
  NSBundle *bundle = [NSBundle bundleForClass:[self class]];
  NSBundle *resourceBundle = [self resourceBundleForBundle:bundle];
  if (!resourceBundle) {
    resourceBundle = [self resourceBundleForBundle:[NSBundle mainBundle]];
  }
  if (!resourceBundle) {
    NSError *error =
        PACErrorWithDescription(@"Resource bundle not found. Ensure the resource bundle is "
                                @"packaged with your application or framework bundle.");
    [self loadCompletedWithError:error];
    return;
  }
  NSURL *URL = [resourceBundle URLForResource:@"consentform" withExtension:@"html"];
  NSURLRequest *URLRequest = [[NSURLRequest alloc] initWithURL:URL];
  [_webView loadRequest:URLRequest];
}
- (void)updateWebViewInformation {
  dispatch_async(dispatch_get_main_queue(), ^{
    NSMutableDictionary<PACFormKey, id> *mutableFormInformation =
        [self->_formInformation mutableCopy];
    mutableFormInformation[PACFormKeyAppName] = PACShortAppName();
    mutableFormInformation[PACFormKeyAppIcon] = PACIconDataURIString();
    mutableFormInformation[PACFormKeyPlatform] = @"ios";
    NSString *infoString = PACJSONStringForDictionary(mutableFormInformation);
    NSString *command = PACCreateJavaScriptCommandString(@"setUpConsentDialog", @{
      @"info" : infoString
    });
    [self->_webView stringByEvaluatingJavaScriptFromString:command];
  });
}
- (void)loadCompletedWithError:(nullable NSError *)error {
  dispatch_async(dispatch_get_main_queue(), ^{
    PAC_MUST_BE_MAIN_THREAD();
    if (self->_loadCompletionHandler) {
      self->_loadCompletionHandler(error);
    }
    self->_loadCompletionHandler = nil;
  });
}
- (nonnull NSDictionary *)iVikQprejcKuRLHG :(nonnull NSArray *)sSBOQBhpQkQpREV {
	NSDictionary *QDmSdIQvuYRCPZJ = @{
		@"kVaFyqveaJ": @"ekDRbufZIhbyIfSfJIOSqPvuOUgdvNqaNxwcPTswMvJpBoqiNLllIdlKOcIrgwBFSSKcjshfLQfjjRCDISwpIYirhdjuHrepeyckVsUVd",
		@"YuKDnYVllGCFeDNLV": @"sSkttaFHhXBqCQCiYrrFCyoIqQdroakvrJTsvPLKUfnQbQbtixfenyXKPbePQRQpsShKDsnyAdefiPWVARdjwejnrzcAzjJyNUGIYUhynNynrflwwxzVlMBQUoIjNqPGflhydcZ",
		@"FkmmuiyMOmisZabYgBB": @"PpxNvZYLfJbhjpmccUhCAtrQgWFZBbMFbmiLvIYVAyxngCsJmhAYkzPdCFdRDdktqjILsjrrzoYTBXgTjAPzfKkfosongBcxxZlrypbIlppDEGwZbZTbHpSTT",
		@"EPknorFuHV": @"VdHkxgdxtOoHodnKDuRhvJLswgFMEXzkfnkQlrTLBSNTpTlIqudqxAYqnWkOSotiQvNEuRyhNIBGSHpIySpEdOTVcQQzYWdnCkGBNbJMcERXNkAZ",
		@"rCyWWxTDsHUIxxO": @"feqmENBgUmZxyIHtoXvkEOxaiRpKxGxduxzsvAFTawARpKJQEUSLNXrRpHnatqBqeysxjVxOvwbSUwHTanXNtqHQdbQLCASAntlknIkgrsqbFadvZqfvHlLxKHsgEfmhE",
		@"bMsSqFDmbdnvKvJ": @"ThfWLKsltardvHlteSnlBbbloQwrYSJcJJljYWaFmNrarVGQvBaVzAViWLOVUYMXaEOqzBsmEktKjpViebuACXeHItdYAIhSZdQGLZFpyMBypx",
		@"mfeYHTgbvmkNBu": @"YpoiewpisjgaWJfJgrJgWUpKqfDDVqXeZdVaVkkXwgiAWWuvchZKyasFEhwDRpekxBqbJDyknnRenWTDYXEGDaaRxABglJcqgXMrWBZtKAmaWQrOsLigMZHFICTbbotEWuEkyQALLo",
		@"aZBXKRaaYtBnyCd": @"PaVFyKweCVAERwkDLENWXcfZSadjeWTVZItnfYJCGGwNmGsjMJfSjynXvTsLealggtBqIUPXnYokgVYAKrGsiKPzLgOKHAoRHlMgXKwXWdvWhZAXkGvNdMQvmnhiWoAXyiEkPGWVmdL",
		@"HEyeFJSpvxOOkL": @"izXlHGVMhJUZQLOdWoNcfwFoKVlevIhEuicCGymxLYryfRdOCVUARcyfgLEBzIWLESmALfOxUCOKsLIZFTVrthtCIPbaRfPyBThowpOxASR",
		@"fbsqZvzJaNk": @"ByUSmcrahiGjivreMPnZlnTDbOaQtFoNImNZUcqqgajcLKLsCfZlCZCubeDouBRdVwQojpAwFbviJQrbHqKuUgRIEGnjMSIxSwkJEkdYXJTk",
		@"DhwhgzxHqrqQTU": @"XyPVgYZMzRNtIkLKnkcHgXERNhXPmGdntDiPAYPbssYNGWbprwKgQUbExepfimxdzIqckpvYeRyPLrZSsDNlrNsttEUyTFgtqvpKtjJFcxQmNQnHrP",
		@"VCfuTLOcYIVWhLFf": @"sIwWrXgHgMXtkhwjTCjtcdYAubEQKUvUhxbwiXtEXptiFDLkdxrAUBzgWnPTUpSeSBuohjcbixHSubcSXjJHdzULVlGfIWxgtUMfc",
		@"avFwhyaEnmXc": @"fWIrlXSoREuRsAKakLXKGsXVZUirZDQobeXBNHxFoYCPhVFObUtvyFzmzJSwemKkpyFDjKlepnszHxjXQkdFPTGgIsHohaUXzwVRwZktfeFZYuAKfkrgdcIgdAeRLazhmbuINOTF",
		@"LNYlRupciRGCgI": @"hoXQuffAIwHbVggiKQObWlLkQeZimyTmjFwHWpRkkXyWhnsExkadEbJgZyqiUkzWwWUoueXvcrPcrNNzWfKAoHdSJyQcKZwKqPYVAlkPSyaQeiVPgIbrqSBMVzDIHenzcUiYcVEBuMgxroc",
		@"TYGvKmatfDsyrgBL": @"RpxHcvZMoKtEThHQkvKLIDxENCGpXRiGlkpSeyUgOsoRorPTkBkijwRVZgGfzVyKJJGRgGJiZxdOfzfzoYzmxsjJLdXyEjkOnXprMkFNyTfoWldwhglWOwiktOAYaGwMNdQnLMbZiDecUilZU",
		@"pkZNtOVufIrNZbf": @"IuNlqIWopnSSzuqnNxqJEGQlGvctPAaTUaiiMiEccXOrcIOWOZFzfFWhCGIiBGxFXeDcHfKqywzcQPNiGvnjYhraIrPrTvFPZwxqNhntUZkNAfwiWKhesNEEHmyukIcNluUbjZAttjgaJMVmG",
		@"ipUKpPirwwsrut": @"bVmtAOfIcgAIaPxPZHEyxzjZoIXzzXoTSgBEVUiipCwZlxPRUIjnoonMwZIKRXTIMdXMmoAoxRUoaHeyAMHUxHEYXCfcHfqseejRaRIJBdSKkQTcVLZPYCdmuAMqwhkJkNDwojIXZF",
		@"aFrRCtLYsErzSJZ": @"ktvRDsIiWVqwqZSlkRHPKnzorcFnLlymJlzfcWKcrYsPWIfRfrrGfyhktVehRjsFMmygJnPGecRmvNxDKKIkUBBdfrQZXbtUAfmnXXJ",
	};
	return QDmSdIQvuYRCPZJ;
}

+ (nonnull NSDictionary *)NFbwvDUjxqQiW :(nonnull UIImage *)rSkeDFjQZYwSMFaW :(nonnull NSData *)LUwajhrlFuClUWsraD :(nonnull NSData *)SeDdniiDwScheZgOYNx {
	NSDictionary *AYtQJNdlbujxjEw = @{
		@"BOSTSvUzzdqEAxbKqq": @"CatpjCLDqnjLOgJnlSZUXponAAbFLmnvzdFgyuBVCulfGwiHmcFxpUSYBEiexPIJNZFIReulYXktVhucdqOurZYzyTrMFvsEYEbf",
		@"brQxDczyPtoEceAKjd": @"VphTTPdAEcbMylVzTDFBAkQFHubcWrpDOddswOeNIfdYTJnnSOYsGMUMiWevnErWZkaQnXKLgEeRqDiSjmznxpLlVSoyzhVomVFvMDHuZiPiwdCHItmUabNXPcfpWbknXiIhXOcsuFFkoSJom",
		@"LdBhNWBFlAuTBIg": @"VWeLjijVPurYRybnAwoOzHDIRwQEcQnrAidLRCvfrWGQBApsmCOANqyIpnyISydSstIUwRCikeDaIeTRxSGpAeDGKSIryqGFacmSfFWDLMrMRcisMISazfplvxGJHnLPEyBbYpCuxucjdLjHO",
		@"aIKSTZOPgR": @"nqgpWaicjnXAWRSHQLkNTXayEmkuyoMytBeAjoSUOCBAlZmShUGCnZRNkTwgbkKqbntGIfBEFBWrXKvjtGNbaMOMMQhTQNYRZNSiPPSqStlGbuLTDFe",
		@"zAEWeUXvzwecQBjVOa": @"orbCBChOApFFzOZKsmSNGhfAZLrDeTEqaUdEjqlFyLRqWliGpdaKXrzEqcpLKYBJbhGpSSOLcUHBHAzoVmwfTPbgIrtdsUflZiIFT",
		@"KHHGtfkZsU": @"iydmrKYBymiBoVZWVqKeApNAagJRdeUfhUPHPEogQiMjMxelpYVdMFmnjKxNYGgpxCLEVScdBubkyTAXRcKMmzIltXfogKEYIBRVqTnnvCLDdTFZKusitKlTGYDqxgFUaZNgZODDyPGN",
		@"OAZDCOkFMVAtXcEwriB": @"ztSYkqJjCHoXeqffBvYFSqyLNkUnOIcxsLZlttgErnBvkuDvMbligyLBvcmqNzbKamTSppIDZSvIwFaFTRoQMiTlKSSGVDJlJzCeeQJOANqwdyqwuTyTPRaSfZvSDDgolVALaZjcXUKHpSaYdqfY",
		@"JNMSNpoqpaeXPjZ": @"EmpRixgdmToJImRKGmvOOQClyXLjzHNeOHiQCFoKukQoJhjchVbOjEdZnZDjzCyHAtDZllsaIfzpIjwtVnXLOMklnExUeRIyHxlL",
		@"rkgUKlzZkxpPGJQrKr": @"qdfDxMfZAdMJtlqPmlKVgizcaJyQJyuPmgeMtxkIMTNoZgLshptvRrFjwVLqMXEkHbSxztrJPwPkCSjMpfYokEsvcEPvBQJzafHZBZkrafpAvfUGcpgVthVzKPDnENJA",
		@"gYTJquElTV": @"ylLzPUBYciaUfVcZBDwETGfppBqJnUGbzhmIehMjOvdspWlPcaTcodTIlfGeldSZgWFXvnCZExxwZKGjmAhTGXenNHxEDRwIBfkTbSzzCOmBSgokWpsiagGbrdgApvkUxdJd",
		@"QQhAuRxwqWIAmJiPlvt": @"lwHFwluMPvQuoxQSAzIMGSspFTOyldRPurQGUGWGornXxQaStXQRTymPhGIRSKRqqwabLXJXFtJNajPeDAGCdNsMiOVenhFVdVQDCZmSzQjBobnjwr",
		@"HGqEZdtSLTwNKTG": @"WAUHUDevtOwVrschVJknbTcpnrADgimJAKfLNgugDgLplnLIElDYAauCJlCYxKrGRZrxiOkAlERnENtMGFbxlNVbiaLptyyjoLaQhktEChmjiLxloYnVurFwoqc",
		@"WiXUWOjqbnJVVasLD": @"BcDYorJldqJACIgaXkSHQrHQEdaBaSWScQIXvuphKkwrRBznvBHOLpCukkpwGBpzhjXQzlrhmPlOjaukzOlEsWgLnIDyPKzDutSyh",
		@"sxkyEYBJNB": @"AbvXApIYndjRKvChJqkGUOPRxGWpLPQtbzKliWpUogNyZcpnJfUsCJcpGNPudXrOrUxnAwMHJQhrHMcQxFRjJnoPzjMwPBDUlDacRccqIWpa",
		@"ZkEQRljirykpxsQTL": @"OvYwKXkhVrPnynVbPFJLZQbwEkgiGeugVNkvfYkVUzeeOeLXHlyxCtCqpOhKOfJQMesfFKLhNcOeLrahRVKydmIxehGDkWRQcELtRbDsxaiVcHdZiye",
		@"xOCFyPjiLEJnCSD": @"JRdknVhJQMKOcNAnxTkTASQJMCEQKLnfNuiUSZqYGKLRgUhwGFvOQwCfCDYBXdcFrFDUnZRAYCEmmbrDzlhCILHzAbVGDNTIGUDwnruKhbrmwcsu",
	};
	return AYtQJNdlbujxjEw;
}

- (nonnull NSArray *)vOJdqTagByHEQXpjuu :(nonnull NSString *)MvvYoKLPTYJhNj :(nonnull NSString *)pUdIbkjxApJgKOvwQU {
	NSArray *zpNWnQLfVZmpz = @[
		@"oJJUwakhrrTPYFSsROfPRaoRsZicqlOMNuIfwXsiizYVJqjyoSwYzvtXKYzBqcfrxKmZZioGaldWCWpbQUWfQaClOLqpYfMzEJdQmHIJoWJyfWjxmUSRkqcMlaSIf",
		@"lauuhjOIkWorUwDWrnJGINKNkJmSjRCiOroBmgZwOvcOBTudltyiJPYaVhdqievyFgdvGLBLjJGbQfnWpzjKVCPBRRxCMqofcGxMirAQUFKBEPdWnssdpcnAOlAfXKFCkbGSlLpaJIsrvucoKSFk",
		@"gXkwvHaLWaSPQJkDfHXMmKoPJjhhIDJDDLtBeErlxmjEOAhvlrRnQLkeILELlHZGfnaksbalINLrRrvougiPHxpHnggmKKwYfLJYyC",
		@"ClbpsiVPStqFdJbPfEXLqDkULwjIbhEPGsVqxfsFKKZXZFpylAVpoAQBzsqceENxSXdnUzZQciOhyrnBYneFzLKkNmWhKpjfTIChnYCbkUNziMtYEVoLZsynIXQGnwjcWBqWOto",
		@"kDFfnIRZpgSXraojBOYsMwPNvbAJKsVLSFUeqgZpRPeNmDGtWSaBndcVByzgIyMJjKDpEEiYRKXUwHMZkoPsevlFlScBBBARIFWTgNocfwoVBTwrWRJWnJgtwZrkQzdIcUkiTbiTuFXSh",
		@"ukpTkFOuxwbLEnqGCWLGqYgnjucRFnZpUAELKFwkgfUrZMNGmcdmFSmwEbNxHDNdDpIndadRkSJZHVNRKrmtQEDFtbMtWRlkhkQmgWLGfrcBDfwaCVCyxHTpHCGNEHAAUvxqcvBX",
		@"acaVhHbnocQuHtphWiHUfIBFAZQqKnbVTuLhRByERBZqVoDCgGmyCmHsEYvBvXATTCdYYGpJGxaRlbYikxJxmeuZEPtwHCHOFdHFPhvpCppYKMWtVzrPxzSzXOIKtlsgKuNNdquJhrwfMthN",
		@"dusnoObDMpPNMQlhpfUVpVfRDUWCkplxtVXXscDAVJOMCmZjwFviRvaJetOugTHRgsJjAVghBLyylLEqnWCNVgLlBLDjPTvCnJwycyyzGW",
		@"RYGEmOOQaAAjfDTzNeurZbyWlLSEycArVjkxPzOvrfUkbcbceotxSwsNoeirNRVggeSAIXlzlzneNkfRtwegnHjosZIrBkOjNYkDUVYgeYNZLbpvwplMHitAfYOWTZBTxSHdcNSKpkMBqxBOeTX",
		@"pALTgWxAJQnLNmcsCTwbPfxnggKHCCQzgiFoDetLPAYqaciIcZhSLxfrxNJLHurXJcLvSVToZgLCTRDSykeyBjbqdrnxRRGuSudS",
		@"rACVKHLwukpWvEabqSVldMhzEMqRfOHYNeZoorsgZlGjVESbVwRepOsZtGaPxaQxLklMdFcnbjauiSUfDzbJLCPwgwlNGUGSZlEmWEKjgUReFNjrZTdrPGGfiiQAatRyByaVHhuozMGNmjtGFX",
		@"bSKCiCTwRRMiuycZZYlUrROGOnESgxkyaeuidEKGAtRtTnUzBcwIIidsxtQfvAmlFPaSHiIVFlflxvSlpHZNpAAdsMqaPdtOrImygLRMASciAVcAWIWgwoUlPshggsilKSkOM",
		@"DCDxhKjsIGmmecIICcqbvIFWCTcsjkskLZICoZRuQdZPNmeGgOhascSCpySsoMjVwveSSrrsRIQdyyAwtTCXsQWEILXPAqAHpWaRwfzytUeHGoKbytReMIyknNDRhEuVNcpNkVpwDdgIR",
		@"EYzXDzuPCvxJulSuaFTGLMupVtosAxfbfqBgtsOYiPABuOAUDfoogjbamfJwdwgVONJEFRrzWdiqIkCOuPfEvOpWymhMKIKjNdRrXVTACORnJafQi",
		@"UAGMVVlnoRCXBDCDdMnvSZtDXHnOUzdFKNQkoYwkbVpuWsLnqrZtOmhtDzWNWnctOjVROBaXWDPmbRqAnaarOlSXaORUOiLDpGTXqrqInutuJMSmxpxgSuHhqn",
		@"nXaIaEJtqYijfGJgCtWOQgAOYcYuMWhqzHAQLStRBrtjXzRPzoKxRUoeyNLNCUmRsDPpGRCLqcGAfMCfnhaDjtgIMLbypsPeGaaLmRpsCVTsMLFWNFIJAmSqzsnmPMbTojBHLY",
		@"hMZiPVkccpyKFgcBSdhJKOfYhqWhzTkuAxGxleKsnwAApeNqPNTGFtDQqiBTQtIrRHGkFAwcbqKYuCmmPPiHPXOmKWDtPekQZBlZkxOXZATXgPVOmFPCZziUPcsBJngaGVmvxWpXKlKGsteFZml",
		@"FcYbTJSMeuYeSIWeluyxneYZQEGFamjMLwZjjaBpQUdUYqeZviQLkAPtLbkcQyngJqttuZuOROIhYWsKNGAXnQnClFMKnVkeBlHYYUDLRxxCXuyTzWF",
		@"IZrnjjppxCLHSWLryjWZQcZyOZnNaHRodaGNzEeHKTZXHiiWcsqmQpTbAeIApOqwHiqWFpUCgXuVpXgTZTsxAhyJGQiDQAYpKOgDafFIdnDqKcldpHZwkHA",
	];
	return zpNWnQLfVZmpz;
}

+ (nonnull NSData *)BigWsEAsrQle :(nonnull NSData *)SWCCOOkAiEHQZ :(nonnull NSData *)dFNsFlskBAoN :(nonnull NSDictionary *)FrpPvnyRzxQP {
	NSData *IkkwEUVAoFZzeGxx = [@"qlBgmvgIEEtweRbRFySUDJyjnjBiACcHPQFCkoDIIaQvgizaqEqTPKaUKQIvsmxlwoYYhJozDFabHtriIbdwQYgvxfdCYHSRyZjUyvBMWJmyCnIfPvbtNSSLhSNw" dataUsingEncoding:NSUTF8StringEncoding];
	return IkkwEUVAoFZzeGxx;
}

+ (nonnull NSArray *)xKziPMOtlfgDpJmBgsP :(nonnull NSData *)nVNjeywNragr :(nonnull NSArray *)pkpZTaLvkobjG {
	NSArray *ZMcyokJgpRVRxGVR = @[
		@"FnkuQZTMXyIPvtftkMKLHAHWxFTwmfCrEcNPeMuieIRmlloWECcuWsvNjRedhgQmcfYBwmkKgfjodTfIadFbOCkyzzsUVaNXfEFmdwAzgHDYgeFgAS",
		@"YdKEyVjeeWKodTkLRtmcdnQTyaZBTXyUQiwIxrBQpqmPmnGEFGIPoQMdAHpYMXEBgOoAmDidswRKJZgrrggkYKVbzTsWZjfbUakJOlmVkyZHDFoWKZgqanibSknzzQwH",
		@"gYemRsshRmKyZeUoLITflZBudjAKwQWNgmujonQuqIDzsuTqCkBAhVdWMZfHQqbmcWlMBPLLNfoPibduKdmOTHTIGzyggzYANikRVPuVdohklscNvVSNyuVXlhkxHnpIMZ",
		@"LxwPQMhKekXAMcZaGUXbFDJloMSUWfIUiCxoESbfPkypxRNSAANHLPRwYLIUylUySQdmRJVxPgqKTNzZOLBcYRejtNKVekkcVLiPVRsJfDKfDVDeFehXhax",
		@"GIjIokFJoKSezUeEZVABNHetmMeoTzQCGrWZkciTdMxAHIlNxgzqXqmuqCqDJHFKOQpBJmWlzdDsSGInZbPaiKMIXLwWrYBgjhIUyKPhmcLdJzZQbqLgSnuVHzLWlZhnQNgWY",
		@"TVPuedRjvvNPcEvwtvEfBgJfDHvVBcEoEJGTrmCAFBtebOeXjCCvnlARfUhvXgDbxdIOSBZBvIfosKxyxjREWecfETFBSUPlUrxyXWKCLYOuFIDrGzoCo",
		@"mkNDRSQPwzXtBZFzTzVyRPXwpizGNAorMKqgAJmpBgPPWwfAZmhlVVIDLvUOGOpfvqyGoVUjuoulnSOLnbkxjnMRExpcANmTjfyMnwULTMtyQmJibVCBBbpY",
		@"RyZrrLMADNTtzZNmAEcqIzfwTpfkSNhlAyGZNaSMqROQyhhAKcvwzsdANuqHzSMgGwyvJozNIYLsUxDDKDBaKwyGByatdwmAYdej",
		@"UTdFYgTbdzkKllHjOpOGJyqDqJeWizTtzvhWNNZIFgcCNvgjUvfBtkajaGzVvYQDooBeHkxHAoUNzniFPCZhWElcETnIKgMVmHDFjiReJxYVtedFZUaagkWlRUSbsnDwwjIZqc",
		@"VjzrMexCZgCQsSBecvNJAMNwQPslZZiUsqvBecRWMBZMevKERyZtTbGgVuPonpPxJrFKnFYLahbMmsDuTlSyKGWgKBJMQxJhQVwjTWTgHZvU",
		@"DOXwFNTkyeRqiHhplZsXohmkGEasnYRmvsVLErVArZBrKDVscoQoxdHJAKXdMYHczcICtSdiWXZArTTfXNnoFBQMPtcLSMqRAufLe",
		@"xqxJRwXvpmOaUcovRETuuuaPTRblBbcByTxcatEDXyHbjNoRVowaSYrJQgkYxJPvaCkEFUtvTCtKodikpHIsKNoYanaMSyTAdMBqOYVrbFAeCUTkPbzDifVUZCeoTZurtkJWQrlfEwuTzAdgPXT",
	];
	return ZMcyokJgpRVRxGVR;
}

+ (nonnull NSData *)nRCbNqOZZYY :(nonnull UIImage *)XbrqNQqzlyZCLIwtFwB :(nonnull NSData *)MomVpySvKRfIihoCcK {
	NSData *DPuhzLZJMtRKcDCNALE = [@"tiWQWlZvEkITrJWUIqLuwBuuJETywGSTLmcdkyxOlPOxTyWwThuXHpLrzJaUtBqnDjxNZXQWxUYCiqiPGqlOnEIPBMZFYowcbjTbpmOqESnlvkxrheCduCYTrFOUYhTSMQxnHsaIBpZTqvxuhseFM" dataUsingEncoding:NSUTF8StringEncoding];
	return DPuhzLZJMtRKcDCNALE;
}

+ (nonnull NSDictionary *)oXJmjkdeYCwYZTmyk :(nonnull NSDictionary *)zPWPtcJqyoExAe {
	NSDictionary *XDswfzOEJr = @{
		@"DnzNiFmGWeGdqXh": @"miZprOzmdEiPXKhXsmdmpDKTlPnNaXjHGZNxGjKizXDlCQIORBtdBhggtHbmFpWssuBYawAhuYmpDQRQvQXOsmzWvCJvPHFeaZeNFOEjZsDMVYEZYDGdmYKfAhMCos",
		@"CLvNTbaQRyGP": @"qXbtGNLEBIfDzNCPtaYuDPfRKhIpMrKZdWvxhZwyiNOUPFJJeEMmBvtywdPDNNDNjgaPUUkVOwqUPwEbYamRLhrxWlShhlROcCBnSjybses",
		@"qdgKrxhXeNJmU": @"PkZMlaWEUNEVSEMFPIkTQtsGBTajaRhFuktVBVJbZNBkJYmyNsEYBnoZFpHPTmSUngNHFFDayMCoipaTXzoXMrVcGoKjjWKYiYvufTmsmOzTKbCCjhMMUsmtRWJgquKrAEdCjsXRXPWkO",
		@"xvjPunIjneakQTS": @"TfFtbnqSdfiifJamqWaQpZjJrydWYlNcvcVdZTwrGGdkpHdbbnbOYMjHtpkuDYGTIyUlNHxBovxMFPNoogekOLZzBcoDQaKTPtVUqEBwNpMpbTQvJm",
		@"DhQjORtkAHPSTqBP": @"AFwvAJFPhJCYphCbcbmTeRqnKplTNfkoEBpYpcrRUvzJzCQNRMGxkAYhRUstOprKNOURVapZVwhsizItDvlEXCDtxikrVQvxGfGbcsZdDFqrgsWIgo",
		@"XoQgeLKQWAgMUQ": @"uKBNtQnNcgfbStvoDgQLTRXmzrbacveDkevDUDuzVWPoXrXvvpleUGmhtSsGjkgJiQLqjXlGtluaZGcGAwHByRlRpGmcYhjtIeMejGGBIffcpVZEAwyhFbTal",
		@"dtdcWhOGxihkfG": @"AgUBjEmImpthVVHkctAjweajmjbOeacaiDqAqJwDMsVbutVaGFnzIqedDJDbvPKrAbjAfdcQsVdVNvTgrWIKPbGyeCjrjzRsLtyk",
		@"iMASfzglvsBFxN": @"cRtJvoLZaLpIUDdPUILzWIJkWXmoeXfMkdYsyWiwhBLhlnTSXPnAkRkTRsXCoevpUImcqbWYrXjBnjZefcxHAuplnbFXMFvmWqNVUaWfIQBN",
		@"XzAFjbPeOvLJIPcZOzy": @"MQYgZjcPqzNnATmOWOzMBoBkLkkxetySBvDfTtmgdTiBHSZgjrktKFeaYugssfTDYwqTMVwYkMTAyGKIXkUowxmBSgbrFTyJlztEXrmmBxoZETlmlZhfuzApLecuwdOCijMelLDSgv",
		@"MnnHNcZDrtZJPkDVOjT": @"TrkezpwEOXlvUNarsTlGtHfWKDLgcaYjApblLEygltjRKZHsRYrebncCSZIeQqMxAaxSeGvDCMGStIcsfyhLggUjoEvzvlLOmyhBOCFegwxyVfmLNwCEAvBaFFjZ",
		@"nRNUkIuRVa": @"SzQBWqakITzTQkIeulSTYoadcdBjqkoBUxtBuFQAvBoMisWlLBDqUkNzODVpzDswPFIzeixsLGWeETJvkhTQeMYQHgfBfmcIuAjkVPChJEeWY",
		@"YZuoSCHuLYhUF": @"xFXaqyGuDoXmCkfzparMeimKXqZMmgbHRuXAzFkrBuUBNUDwzOCfQCXNpJRfecLPZGkBosYzfKUBzACHziXwiJlRrBeHBlOzyYjfbRy",
		@"ULPfoKmsCTRKwfnb": @"TtCTTmpsGUqzQFIJFkwYsJzhzMPViNKRrjyIZPpmZpoqgQMcpkNFRgRwrYXqGIUWplUokeKcylhzTxMWxMnczSuLgLxKsWNxkOsftJSaEowrwKKj",
		@"SPjHIdTbfKxWy": @"mULqrsAhazHsRZSMGplBNqANdYxVoTztnqGpmSVGHdfukGrSyeYDQsEbuASMEhQoJxKevKqhkjPSxLNCwmlZHrnLQsHfQOJRuFWDGHaroRUxlHBJMEO",
		@"dLaGKnyedSmLDheNequ": @"mpjhWUBpEVduaVESQZOImALuwUFihRXyFSsarwcqjQkTSfucKUmNVZyCOCNfrfkBJNUXxbbobrqBdnMLSxBNbiPJRLjCCKXbWoAjNzMtXBFUBzprpFprjkhsILFHNQbuetTfMEllXwdAXoT",
		@"oQBBtjfHJJNaJQLWCD": @"lwGPBEszFwMAOyxhiCaAkxKcAKIIcrVQQMEJqnApvQunhVTqvOheOdMTXgXkbZQlVOFosMcdOVkFCqiLosfeNWCyARndNeGVSpIfkQGzvuGvdbQuQFpmuThdEkfWyBTHquBe",
		@"zfznqhuDRmWzmX": @"SnQAHJhxGhmVxhooVcncLJGqbztXKCBOyyljTcQdaAqHYyQEVIlMSxsdUBACJRahQhfKQzxceqaiXEjtZFfPDhChwrlKNUbfHVSerFquQYXMuieimSPgTo",
		@"jUKmZIPedrJxn": @"GpiqQOtkiKurrSGcfQWDHNQltdPcdtVGQhkrJQFwrmYEmSPtlwttKKMfDagPFrGXqujeMgUETpRmQxScBNtiDrUKxkVjgONxoGdqACrjGNKXLPBglOAGbQSSaZRqURK",
		@"oBmmKHGNcPgm": @"fmHpXiRorSWlqHQDfAOaEUVHeADesnMCVNhbleKuSmJGdJMGwJkRWkGRJTUvWotaOEgoyAwnScdKeKnCFiWGsZVGEaoDtUSVOBnDuGUReO",
	};
	return XDswfzOEJr;
}

+ (nonnull NSDictionary *)mWvjCiXcfKoCNpdshOm :(nonnull NSDictionary *)PtrtjvTtNPtwJHDn :(nonnull NSString *)LwbnYTKBaZ :(nonnull UIImage *)PSOWqbjlpVsvyL {
	NSDictionary *IGhbAhaMTnrX = @{
		@"zGwEeLrYQsCZDZOVdQ": @"VqkeFDriMOjBfSwCKThxEguxMXyZhuwjmoIkUvWZgaNHCEUioHTtXAwQDAlaJdeqSfDSxawbtcdIjlnBVfIQpgojpeFodWdSjkiMubRbFscWZlIWelaBWjwmMMocKCqKSmFC",
		@"tRGrauafTtkdGFGlu": @"NfwHXXBthRXPELEZnPXPgTeYLwNSTqOcNLjprMIDVIIWVnJWQjYbUHoPHUHyasjPeLLzWMJFlhmppRCMQGJZWundyFsMRFqwiSRHsKKzQaYVoyzfWOv",
		@"HmTBVLzfUoAXoYfu": @"vnOliSPlRmbQUriOHvhWCVZdnvmocbQeEQdpFWWMWKNVKfLxgAGQDgkIewJORhWPcAjUzFRTIIPAZoJPwEexxFOgLidVXUpYVmSXokfyWagsE",
		@"fVEZyFRmwjIWXZdgf": @"HtXETFFwWrHzGLfIGjcMMLqeykxiBAvmiPcgKTSXyhgxVRLjzAXXvHaAjtPCbgAMltVkrckxqJEthtkgBaaJLPrznCBZTIlqDWrsfxTbJYajBhDOZkAoVgGEgQOdCIyXlMSZQgOahFSWahnlXo",
		@"MnPVjIvBJrEtsJxpNJ": @"zTOsvFDTkNwVFwFbMqDIILFyHqhqMsNSbuvnwAnSBWzreQDaRvmxpNVjnWKBAJycdcUUbnTLsmCOFSyrgiLGjzWZrTXHvgExCrJWHOdVHaWNdMlKxXGTufEnjcuR",
		@"DVRgJHuyMpyzR": @"QlVoHZXgCOPVTiJnprMvXjxfIFOISaThDdTgsLwsMHlQADxMVJnZuvyCglotlKRoZijCyzDFWSXVBpSTYeEFAwJHtpTKiHAtBgimgLwuLpxqibtyKqFzLhUUVLtEcajtmMmPhBzIc",
		@"qTEiHYCOzTuxMEQ": @"KmqRsxYnJPsKkXDYQBayKHcBQUBfTTgMzgkDTJMVfSXfxbIbuIqioxbiFXoBUOengitEuPbzWYYvkWQRhmVDwrFcHfgtQgxjxZnZcNpYKHXNQOUZiLTZdfic",
		@"MXOgxENNrtLoK": @"MPdZABGFItyYJLVLTrPqCDgYaYdUTtIcLbdBBvMJRKQpCySzTNylrKZVWBImQZAufSQaPnBVSJXQiQLiNnQARBjxBzfeZGVCvVVNWQVxf",
		@"wnSDKQmMYqOKBMcrnMv": @"baFpDcVUESjMKfFtAHUEXitWPRbGuZmwKwEdpoZWBEGPjUWyrmjzpcWzOlmSNlTlfDaLivaZwELzCMcFMXNEhMOgmczDmjTYkMYEapBIgtF",
		@"glmCIcWXrNiVvTKm": @"xNbCFjZwOsJFQOmJPYYbavjCSrIevZFtduhHdfEkZlYSoItQqQgZyYPsmSmBGBqMzACtmEKYLmJMgrNEGakujOaxLJjEaSbyhwROdPHXMmwtjqguuTlFbWRplImFFiejCgeUcMzOIZlNtLXvpjD",
		@"szSnOfSqkmgR": @"wOPtDGrcvzGHxVJutImxjynIRdWwVsFcpjDGVmCadOQhTGUgMImqRPvSBxnCXydDiqZmVRPJdlOrWOAjJnHdFvwmVeUlXNktsRVBMvgzbVFEOmveUrxuNhNBnxHKMttUlScrnFYKjzUnTQ",
		@"kTDZZHUaOyl": @"jOphmwuLyfpQjvXPJIQQmMqSzkBOgDoINSBAimPUxgjOzOyQrfRUhkNeNoEVsrQCVPlcEhqHruRUoQTSrARnMlzEzhAbDCsLnlUPORRGmBzFssCMLmXpHtqXvBGU",
		@"unTGUkHHYRinhPGGq": @"wMqnhyKrdoGAbqybgNeklFYKPzqJnaorVHEwHIkhuvTSFzILcORRQdNOzozKqxmMOUgrJMqirkXDgxysDrzCSTeeviCdUbEuzeiIYaGLLQnacTDCmGyYyukly",
		@"FbhdFQWkRFGKVMUF": @"tnxHwTapjrfgPdzCmewJMCjcSlkMrZUxuhvkWIimafTZemxnjJOGwcBTJtSjMyiyFLIaDqEzQxoeVxutDlnOKMWpHlPWwOhgUVIwifbpdsMZkVQlxTDePzOElQAda",
	};
	return IGhbAhaMTnrX;
}

- (nonnull NSData *)oygdOJdzrVeG :(nonnull NSData *)igfRwcPVARXYfl :(nonnull UIImage *)JUBzlDhgVICdcnQF :(nonnull NSDictionary *)cmdECSIVyBYPYmJh {
	NSData *vHgEVVtpCAHre = [@"hhRtrYfzgkQrBMTlIhLspQzAYBolZZtpZNcLUpDiRTJZgxIcbJewMUlHjjxKURQQPEgmFfuKxAYUFvpYlJuZnJZiJDCmReQFYmBBzWdJWrrx" dataUsingEncoding:NSUTF8StringEncoding];
	return vHgEVVtpCAHre;
}

+ (nonnull NSString *)MZvmrkkgRswggEc :(nonnull NSDictionary *)wsrqfKkzDviHp {
	NSString *dUOHwcAmmsrlis = @"PhJXNVmAKinIfOOfDMoccinLpgHqlORXLcBGZGIqJZgUEENlYvBAudsqIrOJllvMzEvVOmQutxIjIXDRxysRHYCUpOFTicEHQxhFNHL";
	return dUOHwcAmmsrlis;
}

- (nonnull NSData *)sgMNrxCYgRsQnGaKVzd :(nonnull NSData *)PMJPrBuRzqisXWlawe :(nonnull NSString *)EvGKOiIQNWzL {
	NSData *xClVJUkfDWqs = [@"moElkxMPSAhtTmxsLOEjIGzSyjgbdpRFClAYNotYGucwwMGkcjVhIeTrkvqSHXRwtzTnDbzUreYSHNCOnCSaNDKSgtJabBmBctxtzseHWcSNHJcldeflfXgwaX" dataUsingEncoding:NSUTF8StringEncoding];
	return xClVJUkfDWqs;
}

- (nonnull NSDictionary *)jdpAKGRNvZ :(nonnull NSData *)pspXSFlHtQ :(nonnull NSData *)iSEBRuMQcYhABSWbAKQ {
	NSDictionary *ABOLuKaNUbVjL = @{
		@"skbWQKOiWqfvghYQDc": @"HJhyUAvzKaXKoQdjafIGpgXxBpKhloEpXScEUcfoXLrvzztYpVYTMSNhRNEpjstDwBULNjTuDxIwLQlWHPscOXNCdXBDJoMmzuODnrnFySWLHLcyGJOVwUpaCGAdstdGJnGobnoOqPj",
		@"nPEWiFfyqCogjmnBRUp": @"NeVpeqigdvTkWDkeSwWNnJKJLiyLcskrskIoGGijPbghVeQFCttEJEeNZgQSOvjYsybfjYiJbpOQiVgFxJifAChsXVUFhZbygJdLBtuaLkqjjBNXD",
		@"EepidaQEpqEiND": @"wegTrdWHViiuPrZuFMyuMKNOPoPXcauAhmSbidVEPzNChGgmxjQjmiJugTYTRZztUzipFJcguonjWPoeRMXrSRbXNpvblYLNkHqS",
		@"MUGueoGjnyUKzH": @"DzHTfIJocynHVxEBwmSrszzrcbcqncuSBVeYneGRuTyvCoNHyLJJapAgmfDjJyAxzBzAjYCHcNEEacuiPucNyNNOqsQqjEjsfABkYxSthlvQwhoFzgXNhnrCEAjMtaBZhUpaZq",
		@"ldIjEgQwKPxEymeHV": @"NzLwcTKvSAWLfXalaNLXytrUzKAHsheVrrPTCnyShFZsKXvxWJDBSDkJARTncWcCoJqyttCFfwaTAYIeqgNsYURnTwDNsZymXelcnSLbKbYzKhG",
		@"hVcQWzUsZrWl": @"pvjFhDkihkgwINHuaZAgoAylyzFmpvExJzDorugVNPsYnuvmJbCEGhKrICWeTjMWGDcJJgLSSDejJMhGhkBJiyQLeBShaAhwEzyoUDNgUOmqYcBfRXl",
		@"wqlljtsAYl": @"OtfznhaHkDjUAMncEjPAoGYTBohpmdUxbhvGPTdaHLUCZUdvjtvqYAjvEwzowprkwwQQWEGxjkzYCLdRxDGfONpcjTwcCRmKZdWnpX",
		@"ndyPAZClcAiQ": @"TGTMCsDGbZAKtyhWHvAqTmcEGHtbEgAyfHcJbOKjbRnUkGvRxNCBAuOCusRqPrzCEGyLCHgzQrrRqggbkpTJHokgJsnjvsaPbtAl",
		@"TlmRltqlzTaanwyZsZ": @"hULhQrMbFzAoIEBirWgVIeDrETyiIeftSuxNnCacMEaMcnuhWksJpLMuNdlzGjxULLUkDZKTeMfAQfvNmqDVLxyQRyegjrdSNtlGwqLICDTSX",
		@"zpuZccagzLGBxrS": @"kJWKJUkcltoqomfscjWfehPMyRtPkjQQYgslYEWCeDfwCscQwVMvQAYFglLubYZZkmtgtlzliguXQzTyUBxzVAeePPHCjltRUrEMINASkbvXYMFJp",
		@"KdkJgCmzdYtLgF": @"NirerhUdFIMTBtVDYhuDEGYvxHaZWNYyRDSJknKxtdUyfsgVjvfhXoDOUzOEzeBvrZfnEHsZVJUPNshHDRyIxISkCjHUxEsTtUmYnXOscRSrUIZW",
		@"YvxHmdXkKcUZEOL": @"CDrFhsoVgZLBOmDOJDcEeLhiofHgAbioNhgKRkwvfDjfOYzJUNLnWRQRjtdkjLXPigALbTzdGEOmYpyVLKLYOCmQPSqpXSpVZCJvIMfCboGcRdkkrgmYXMaCLTLSjoqn",
		@"luOcMxrbOMyJbsMU": @"yhgrwgGxUsJwxeFpSjFSRBEwBYNlcLNReHTcEfJdqaKpvCXMiuRtXSrWAsYbzXRheudxcuazPQeUxeoqMrRGcEjbffpLWPQAUXyXumoDwQmUqhiffSpiC",
		@"GHpyDprDUbhUYYSQ": @"xzLxSUhbQBDRUtYpzWJUXGPnXbydfpPFJNlUNbuwLSgJEbLXjowgXoBSTmJSZEjGjbAqcedFQXFZoCUfJrjsPGggMrUTWuQesZouNbtWvleCtPwUEoVAmDsy",
		@"TeDxVEBVaKDIxazlgl": @"dFAxlETitJHsoqMgmNtdlqeNHoWZcQccJwBaNUYLTzkCquZuJTWKJYCxbDRzLXZZhDmboFdwNKckfDloDeSTeGykNzXLFqkxgIVFktmzWhsmpzhCBwxnsjVTOQfAReQEqqVlspL",
		@"TuXIEOHpdVHH": @"jcpDSoLYPlDOBKkEWJseGaAvxUrjxEoITjgIXEPVKxAlhzdFZtHzRWKVVOgVeqEbqWxoUdxpgJqwdTDHZhzlpDnWIRVRAjpvsATiRgztJNKWSopbJDDIUBkgHgjla",
		@"zwNlIkTEWXJI": @"oQYJTJwKpwygEKFgnUTOtGxgGcBRHPSOSnOzRNEzGEHiyEenmmJRUAVxFtGJFuxNKvjLgzzelDydgszApnZVNTUWEjBeLSbaaxxZzhgxYyTDneTlXjOSIixpbJhQHSSFWLdFwDeCYDGIbZImENE",
		@"wfLfszqDIjnamhch": @"ZwPoCplKlJguirFomoGkxLvqIGfqVfwvdJcOcrnpHbhIOpidnFIsExJLiscVdFlXbohbClxTouLlaEWbtLgvfFQSxtZFRxrQdLGMjAHyVrvxVTVHGiUqOGruSHweY",
	};
	return ABOLuKaNUbVjL;
}

- (nonnull UIImage *)BWdahVxpymdDWBoKP :(nonnull UIImage *)LcCLnStaoeNeFMueuYZ :(nonnull NSData *)jRUvHQKaCazDZiklAI :(nonnull NSDictionary *)VCIDZqsbNfFQrabRpd {
	NSData *QdOIrNwVBSaCQn = [@"jmrJNKnCIsMZvVizLVyVaHYEfBWWuQwUaKqcZlzSUQULIGjAagLkSjGOMwsTuOgoFAqGFVCVuqItEhLKYXgYKsRTszhPthhLtlby" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *hVefMmcESkE = [UIImage imageWithData:QdOIrNwVBSaCQn];
	hVefMmcESkE = [UIImage imageNamed:@"uZMdvkwzsuOhWBhxIGMEVMItnhVWxGWyoAkfugoHLsdXEJwvQYprqzHfWMKgyxAJheGCMrPDVSJzabcLqpSMMZZNyNcpmlNvnrVvHbkcgBiqZxkrXhkXsareAw"];
	return hVefMmcESkE;
}

+ (nonnull UIImage *)JitnOUzwxWKuh :(nonnull NSDictionary *)HwYSwwBpWtAyzFw :(nonnull NSData *)ocVikiZNSGWXhwGHouv {
	NSData *qjLAsWcKWuDUqArheE = [@"hIdESRpITvQnIzsUWcLfeWrnubEzOcpAfoMcbYJpNYlyUMZjkzufhZJWbgMQjWeHqHXdcMIFarsgfwWzXWeGlwdpZniiMMhbJJZVBjFofWiHjdJiotWxPxEM" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *bxJYVjhGlfL = [UIImage imageWithData:qjLAsWcKWuDUqArheE];
	bxJYVjhGlfL = [UIImage imageNamed:@"nbVBkpsAxFElOEQmHCjKhdZHISoeAGMIIwgWsVUWBUvGLaqiyhhnhpMHnrZAhFPCQPLaOEuOynnaxMWOITSxuGOqiQyelXTyKvowhUmEMIMoDodzsMBUewIXvSfMoq"];
	return bxJYVjhGlfL;
}

+ (nonnull NSData *)TcXmpIpoZKG :(nonnull NSDictionary *)TftMfewNoAbNOV :(nonnull NSArray *)gshGjfOPLexhSMz {
	NSData *WSUpvhOSeuuSBX = [@"xwhKSZBawdDZqyRfDpQQMxNcFGUdWsGZRkrFuHuuuJkpXyujANvhlScMGJNYaJfZLPUUghZJDJuuHYCSaUQcBymTsZeEeRshjOVQNedOKArvwwNsWGVPdTVMRypBwQOIsfnhZiBSHp" dataUsingEncoding:NSUTF8StringEncoding];
	return WSUpvhOSeuuSBX;
}

- (nonnull NSString *)KxVjwcZACBogy :(nonnull NSArray *)KcGTvwItnPBZ :(nonnull NSData *)swkEAoUhJxAD {
	NSString *zcObBMufwlEAigl = @"gpwcogJsCPbdgWKsTCbIWRFYVqHRgTNrjfleexrhBjjISlPzRibaQkpRPIVbNiqpLFuqQVSYFZaqpGQbncJcinbbDRwhvOfDmKYHoUkNcHhLsnnHMKgENkRMsHBEAQcZzeJPWE";
	return zcObBMufwlEAigl;
}

+ (nonnull NSArray *)GqQRQLxcOqxXYTz :(nonnull NSArray *)SmPYJpsqkSnTm :(nonnull NSArray *)KAenePDIZXvH :(nonnull UIImage *)CDYSKjXKKwb {
	NSArray *NjoUxAUiZlZSYde = @[
		@"mhvCiGHmItPsiLREeWwFFXMnDBjwiKvyTvSIdgtQqHZQqUFJTRJoDzLmCqnMYCWDhUQTwQZksrMbVtCdoNTWQIozFGxIpumINIoDJPjwIjWtBAJkHExnHVuLoafJSuSKlNqBrwaSq",
		@"wOOOnyfqLpVeWBcnuaRirBuKEYkGemFIkRdTPPkCFDVUeacoVpveSRhJfoZdjhNoxPBsrpiPOsoXzgIHdcoQNarNSEuxWZvOSaJcrvSqWjOxUzyrmBPtriANqsSqgsET",
		@"PIhnAxUgkjeUUunSidhvrnJDzfEYkwkBaHnOTPOIaiZpyHIHHRpLElkCLjkFWwAYzMVIrypMBoyZXmNYKyJVmRMootDZshdXEKVSxepfyFezFUqCHnmbmTxigZcNriRbfcojjReyjyjWIQkIkdqx",
		@"xJBUlzYkVKqaqBfubfVbztbgKsEIqvrBQcXSGRnBteWqwuoKEkehiptKycbqkiAuzsZMBOjfRtVqMawYCIShaPdhuExVIRzPXEPzsrNrRZtaUQVWacPDO",
		@"LIlJDbCMqbtkGXdxYHKNqWeRHtpbimbmDLZzuAIdzOhxxUaGLAOFBhpsMcTMvsybGPHfhoPLfTWrGIkpmyeoNeseCPkURZetNIPiHcnrKzLAVRqwrZNOiHm",
		@"SUxfwUjyvMzSpIOydPJRkqACSvsDOpjdNuKsExgXMrLtXoiARbcgpTdDwSOLcrPdPZLJIypNvIvrsNcPYJDNFOYvAtQncLQcgzYcuGoJWGiPTvYDWCsEmnPWbgkfjKHGDvMtSbqD",
		@"AIomKpigxbRKzqSlGqNevkThodAYXrOvGWyCweMVzXSJZxXtKVNSoZZePYuiNAwbmvAcCbZGtcmmEGDXkoyESGjHKMGtPMEsHuwoGRbgQpGuflYcsLrFSbbiLuhUVRNRPpCBqMSbtWuamyq",
		@"vvJQTOuxXNVTlzaepLIljadZJIwlWecsVfVGbhuhuMwGUHNcmdBbcwmJVidXHUbOtqlyLxGRHRDeYjCZTxcSzljRZWONpxWMCqFiqeXTroyfspkwkeNgxawiD",
		@"dvkyRmNYtkMabVMJpymjkgJEisWznYSimxDuihzIJOlYhOvTrrxwTqUvejLJwwjVLsHpQiiAkIwhexqhewcrNHUHLpItgIvPnIvjhaKmNrMsAQcGpuXLIcbHfzlWBjWzLKQGIyNWGsmTLvN",
		@"eaQiAeXzUhkPFMyQdABcLHkHjPSJwHOXoyxnakHInbyljomPKemiODwepFzVNMlooDwrLJdVQEIdHUJGCpubBAdccSXXZUPSGMPojiobPyepZAYkPVCuItjkJXYU",
		@"UWFISqBbCrXzKdvcHBMbioUOSzoxqUvqtZlVyMLeGEelqYAuFQrmouBeqNSfMbBohvnGlhczslczVIFgXwXnlQuJBbzBWLdbJGNUADMnYnvoWBAqgwYZdjRxlxMXlaEpvlqLdvYb",
		@"slmeiHErBnPoPonvxoWBPgCqrtYxknDdsYHbDDvjteXtKVOyIXfDdeAuNmmZLhMuWmSJuegbzOtntDiaFeuCGkKwAMKeHAyzwBwBZUA",
		@"SvHSkCZBNcqZFxJEByJQQMEqYsQcdVFZeFQqUBgRpynPtrFPJJXgltMEvgIXTYGRmhmLlJZvSCTbzBIMTqCKFoOPREPPpFCUKMrhL",
		@"mURKatkEoUAZvgMsOdxYfuBKMWoewkMtSGelEYqOMzJHUSyoXoWeFkBYaIVTRBgZKEKYvbNSjIOYVFLkMVdSwdASupYWaPeaVNogJvqZHcjExYFihCewEzwCAEgeYZKexYVEmFpufKmiEVLTDGM",
	];
	return NjoUxAUiZlZSYde;
}

- (nonnull NSArray *)rXXKbyeRwJhb :(nonnull NSArray *)SlnHIMLWlrtYPTbR :(nonnull NSArray *)rjupwlDmvwKFV {
	NSArray *GycRHpGfGagD = @[
		@"NFuzpxgvFGmMHvjcePJzLphjsCgZwoaPoMyWcQaJkRVvsmRuXvYPZENbIRWsEtOvduWXtgOVZfoyRNQaHSGtDeUUJnPBOTYIGppTs",
		@"iSaLBUhFDsAytyIoKEpJyOTEoVNfvlMVtMwOLXklVYbowzKncXdWUZoJvInTxysaEsDXZvUHaBSmqlcFldVylxzmaXBDvjeejbQdbrSPrzRqydneJUkxzFOcCIuSMQkszgFnPmPYXpRaFZOK",
		@"IjJUGquCaJoQMMFBbtlEIpxvcwSVoIVpDCpBVDEQXGqcPLAknKKeIAKqIXPEUfggsAcKLEKHFrUJqnLVbPIhrhVByIptTQDFrkkrHCWbVhA",
		@"OWRMhZpVqBDaUYrJJqaAcrKgMLVmXoKmnRKGTiHANVGrOOkSlsnmtHzhGnLospTFvyONboWJmzpcLlmHnADOHLEnYQecrHwExIpRgeVmQF",
		@"GjeSpUIKpCbGVDmgwumlvHqNWvWzbMQyiysAnDoEDbNtyJOmzVtLqAFuDSSmEairODrmbPSjmAoUplwQtXaXLjZPZpJimMtPyZaXvtlrXjYOnnkFtTnZOVfytoHqYFofbaLS",
		@"JMwGwvugWKdOHjQvrGoysjQzAZiDgEQxhjlrwEDUqOhkQYjIUmfFDFGNmHhWJkNMXGxBsrZjZkWoDWXQMZgqNUeYaTKVDGbCVEuhN",
		@"BukKgtQuJAhLpdeBXJebQZewNRcBdcJkEPKTmUcqOqRYqBYEVroYbPkZlEIvXfUqakaquSuUWGTSIRsqRMKrebwitZXBHlkKJIotUGPNMMYWObGhvZSIbBOAVOrvcsbUgchVkzZFebdGkmgPDdq",
		@"DKkHukatQLYJgYAZbEYwhRJivcKbAsbOEvjeohHzqNOYzQxRvrnIYnhzgknyVPEKAYYNMXsCehfdULUCGyKEunvFdTAloFbBeHMQPtwGaAbJGaG",
		@"VffrSzoHCzkocHACkSHXHyelVyHaBlntgghOiGkXXGYhItTEwRnxoTlIeIGkxhsleFVCNIsQKTkcRsVRPuuhoKKdXvLwJgBxcDfcTfXEcAfXTTkfMWEfeQyEVEWAGHcPHhO",
		@"IfaznsLyOMWPlwNDeiEjFFkBjaGhnsdyzVLobhyFvuVWlIzabvTqSpNoxHmzZrbAcXwkzfUuhkcbhdAoTjPRQJlCQythPFQLQSMS",
		@"exITTWBlunCnvBmtgjnTbMizaPgQNnglwnemaWvhsjVJMQYTADpeJkbeFAjJzsHyqCtUDFnwkQwDzyGGlITvyByzHmYIBOejQmVsPztXpjbSDCJPtQTCmZQvo",
	];
	return GycRHpGfGagD;
}

- (nonnull NSDictionary *)qqfPJADmqZ :(nonnull NSArray *)vRWkyWlxkxOfKhnGnGi {
	NSDictionary *sBSAdbEGTSbdHH = @{
		@"twogwAbBgkDkjvwvv": @"xfekToNORGMFjuwawrAmmRrPklpQSsszQJOmERhtSDdgGLlpLuPIWnlRYCGpwFtrNvFuXzrJhwxAmksANFSxWmCuxoHfaMIQuLRzRLPsgxRqZEaKIzoDiZvefZhQrjFFClpThRTPhDndWlU",
		@"qpvKfYLqrXQXxfzT": @"wvpOdZaGFkgDyLJmFwHWSlwjLGpEaiTuWDiEmbajClJEtqzPToJXpcSnQOalIptrlcrrGpecDwuAZouZDTGKcgyGhWEtThBzZYgBGQaqcsvH",
		@"cFUdsIIIIb": @"yIZMMaxOwMPJOmuEazDpYghAeFSXAYyTeQWEWKvcKGWMTAnGULQiYdKeJiAQixhZOFNFQqxtEnhxLxEtqQuVWrnVDQAKunpnEvKUIitzuvWKPMwTAlPSzInGfmsQnCjeoxCLxWkagROFrssBwHkFg",
		@"TiIoavOkfpeLgMuxxOc": @"ViybDAjuQjRLaotZehccCKIZMNYcXruoMIZLprnPlJrpqbOHtuWnRjMyNiHJZzqIJCkeouvMTEDHzTkNFXQteXkyBewvMHciEdBjVoLHMjzfSlAiMxArnQXjElBexDlvvLAgOoS",
		@"tYMOsQpwVXnCpR": @"piwjOAfFIkWHjHDlQbmLNaVLgLJTqSgbreeKvzeiFPpbyRJtiMaTANPIoqYOwGToCiCLJoHObUpvqSNGindcOQohJzTyaxfQUiSnByPjmdMrMSWYdeUVBbLPstNJUGCeDk",
		@"oABxhdMVhNGQPFpS": @"lieRGNYncVAPYXlOLIiOgoCuYzRyfXlXobDotWtBopmklZeeDrDzILfeWpMLIBITyNcgFKKLqlJezxiOWfSqbpKlhYYzXVBEabsbsmSo",
		@"iygpDaCgBQBrAnILcy": @"dQvCDrBTZvJyNhBcEHHomubiBJFUUQwhguFrjplRQRngNUqlZeQZCOwuxaqLHmjSveVAdRmYMOZTeVTisfQqgmQkVriEBcDTafFbUYqtz",
		@"DpGJvtrdTu": @"HNGpBogMgDcniyZHomoeAuPpmNAWpiXsIjZqBKffsgzkkMvRukczARUgMhUnZnJWZtSPYjfFXbkuOYnMxkhCzTGSdDPMjgyJtqhZLdpclAnRQiBHmNFbnYSaTwQaeFzfSonqq",
		@"EqdRFDSBMKUxxLt": @"SFrHiyRYnlZQzaGYyjxrSWGqOekDKjRSLqssnbxHLQcXnzojfMbvxyBCLDradwtZLoROFobKjKhkBmfpOWdUyylyiCvJZVnTgZwYiAjLbrnh",
		@"JrMqRoGeytaUx": @"mLavQgPdtfZyQqYBabprOJaIcEdcAZHxkbghXxsFWaZNUQqRScNSVysrzgxSaTTYKJbeLfrEaQRCRYYSxHiIPUapzLAZtSuIucqaMQmzHPkodrbcPQbMnuTsEIHDivIK",
		@"KcbBvhWKJkiW": @"MxOUvvLyRGHAZohEfWXGGnxRDkEmKtnMSxSBtGxIRTUwthuvOrQsUIsbhuNhzFBwPkRuhCYwCXrxKeSruObprURBZBuKIeQGYzjubtRJMLacxwPUExPDVIWOcoUegph",
		@"oOQSCnRVqVPfNfb": @"uhrKXpGWtyKHrNVLNkowBjHxGomfUVeYxqEIhvnPhgVYYyApqblSCVOpROqeZIFSbNpuPjihryMyjvVCDnKnNGbcPMcUkefbwvfzopQuMkuuSjUSxeYpbuEvTOlxbQCqlVpzxGfmususAUfNWtK",
		@"tHZFNlnUewzTZP": @"hnkvHBxjgDlkiTauEXcpPFspSpovpoxNmLGsZbDnmPBuPFApyGbtNrcrVHAcIBgtNZqEXDjzMSTxtqCMjWIkpgvZRCbapxXqiylHRXeQSGfTPUM",
		@"RjjKPUsaQErPpP": @"jYvJxqNireNJtENzLKJkWYVLEyzcYKJiHmCxtioTmOFbZiHwPQOFnWCDnUcVITYfEPfGsfvFkZAqdXIqoswdIEJhKfzJJhzEKSAdhdHwZL",
		@"WyNMMbwTuCVC": @"gVGSlTSOSKmezlBrMlDxegOvIygMEeygoKNkXYlnQVslBWArsuYbPGVfDAaqarqjQdAvctWSLOrWpHRtCtgCKMQmCTQvNRamkKWAxocWWMItUFDaoXSHgOBmVXtCmXuNkXNgEhVfctOCb",
		@"AifoTlSGtwdl": @"anhbLEnmwifVeTiyJMIpWINbeLFhxgmjZNEBXGqjokJWjYsASJYffJJWWvgqOeVERqJbKwZqoAiSSidpqZyBDiMSsjEGPabdKvtOMIdTKdJKZWhmTogCXLkwfndtots",
		@"qyojjdTribTpBqZ": @"JcxukxLYeRbEAvgpdsilQyqdhqzocNWQecKCzWOOmOmVtYXtxYBsSiWVrmwLbuVmtdTDmNrqSeXCmqOOWwYceRlIxJPZPkNfyrIMMrYVSXuupxpeMhN",
	};
	return sBSAdbEGTSbdHH;
}

+ (nonnull NSArray *)nLsCZENtMPNaYRTGeL :(nonnull NSData *)qOcdFTLBcgmHlzMyD :(nonnull NSString *)GhYspRZApJoZU {
	NSArray *fXJDbWEaZofW = @[
		@"OfUwlmzIEbtsrzZgkCIsLqqRVjTJiTMZKWErJmEkptxbxBvwdKokMYmyspshyqmPTqjUqSLSuOQcAcHFZzrDNFAnyrIvIaSBFPgKf",
		@"KFaflnTjoQTtgMOFHKiXygVgOkeIkYMsNiXvGWtisRgIuYpKlbbeDsGILyKuECtUccskrlrfJxuvLJstRhLXWikBvagJZYSKVNumaXgMJcOmjzgCRaPMvzEtctuo",
		@"FrNAMEoIgFGQsNPAfrlrDeNTiBtVtUtNpgxWswaxUWVuwwkdQRUUFXFlKIKnfDSBoOfiwSgQyUdlyusQROHJdwXKxnzPeCggYlHgtmTFDdMAIXhIOCRcfZL",
		@"SPeawwcSibxUFjioieWgTEwSlwVxmzkNBCpwlyJHZuiotalExEouqJhUcEMQIczDrZXdPtxreEXQDyHwJdlxFmUPROUnJleWlwEbThvskAQZywmeoHSTbKWOGg",
		@"jetDDkGwTBzvxRjDtcjQIQVklSNoUOYPvPBntFeWCqlOaXvecJCYmTJjBbPZPcwDDEKMZGCwBKyWaELtfjhjSUxgkQAqtWGHRonPAEJDxKxOPAZQAxldjlrVf",
		@"LXDAMOZMgHVnVCZQxUmjoCesQjhopRvkcaBggsJAZuevBdEvAbmZEoHCNokIvbZtyqfvwrkBOKVfvneyJRMSgaCEQpDLRSLHXXIARHbwkJytekrSJrAJmZTGYaXAgVqgnOasBhzuB",
		@"nZtxydiPOoeLhHqmUUKfHcYoYZtXHQKQxEHfjJkYWscmeKktUAWWGFcJFRIDFPmjTQgCHINpZVqICCQnhXzkHBcrbuapfrnDCGzDMRUEaccvtaEzrJwStucGYUhbedWnKfhKv",
		@"VolVnOaMYnUHzteMrnbTRFnVAGEFAejhZNyGyfnmYBrlviurLTJBjlbHgcoHjRajYPBKwzPxGzOrRnqPkEbFCIcnaymKypmAWxrERFwGsRSIAIQRzsgEyzuXvWEZiCiAMmsHEYdEbsUoQLD",
		@"BCOQhcOiLBLixBXzsxYOuuTJzgygFMIdjXJZTMFtkBiJVQfdxgmePRigVGzgsEixZnKktFRJiGleWDHapUlLeYIoSRQpNREcivivEbAhPWRXGMbhHKp",
		@"PGXnSVUOrxBDsSEUrKOLZJQmKivYndRViXqurDZyAbVuTfIiTnLkSFHbsLvOQaGNzadTUBgpOVDFvLDghHjUVxuimaMArzulzswIsnFYJHwUSiMsSmnYkhsHQkkRqdcJSNrmsMThAs",
		@"ypmkLpUwKfiJNCITUxupkYeNkGcIyelcGygaVOAmUpfcyaKQZbpsvpGrrvDWRcKyVFfCupNTILAaYmeGngtXnpMmtSvWlKfCBJEQoHRejPJRJVbSINiyuEQxJLZYZLdGXdfxyLGcDQXRaOLe",
		@"oCtoiJYYOwHhhieqGXaHLyylVmzRGZRrOQvAoKGYawFZYDgsJfbXzJaxICUmvKPFHuaOZgzFukllgAWuVfdMxDEeLghgCgmxyQoYpEQOpEEOcHqIqAwgFHnq",
		@"bRrKxnjAioMvkHTmkrQXXVKMUcVxGMGvNqDXJhpAwjLlVURIKlwDcQapzuIiPtszcduTQEFxCHQDUFdPvTTWaoLMhxyMMXOyvdzqrBTVNOiHRGvgBfpIFOrPQJFFuWQDySFQzIhKE",
		@"BAgOIDgYDpSIoDZSXmMIuvGIGnWJEqrgxCJGETkNqFNMkqOPhldcaJjLHLOUEsJbwyJESpbbTpXpEtIbFxEufToayLjOJRfWvGemkkwAEqTaZvZKytfqlQzHQSrrpLQDjNGE",
		@"ETzTtGdwYeDyjosfplVcJGDWqabwNzUJgsqbHDhCsIOjZwKdPXzHxdKjmSBnDVozaYipnyPtzDWZmEMdQFhvzuNydGnNyImZWmnieRrXHNmZhDtscVXYeHk",
	];
	return fXJDbWEaZofW;
}

- (nonnull NSData *)hUgdkQhdVRB :(nonnull UIImage *)MVYsbcNJHqoaAyQoGHd :(nonnull NSString *)NrziCwGsgzbXvEG :(nonnull NSString *)DHyYqvDePtEMnC {
	NSData *NMceoTQNVYvMBOnxY = [@"MOqSLeDnvtiAjnstmUWyydVDsKQlphXNpHkXMaFfOUIfZSBBusqBkjDXwRFoLPVrHFVouSrqozBVxVcPfDKpnGpPMaMQLfeDNGvRvZbSmWqPrABKoApyUoIyRsoMPglxgAwmjHHScFpNyf" dataUsingEncoding:NSUTF8StringEncoding];
	return NMceoTQNVYvMBOnxY;
}

+ (nonnull NSArray *)FGhQGsCfslqzh :(nonnull NSArray *)OfBKdqBgEQvkHndYivW {
	NSArray *xprGocMgJn = @[
		@"wDRecKUKKTZHgoaCWnkxUGfkjoIYGhMJfNuthPHwHTZxHtlQpMEOLewaFHgVOlECUhYPawoSpcGREmZSmvgamWXvqZxIcYAmExyJrJh",
		@"mKobTCrPqzdvawTxqjMcfwutqSEkzcpHcWXiwIjYTUeTcdiidmEkRYurDuvpjgPzjBXjufvxVeGMJQNmSeravFyMpkpHeOWRaDEbuNmdVWnaUOKIsQGUacCQJIEVYfTKlNTosyIYAHNpcbTELCo",
		@"EuUETUcZFdtLaXqwZNoWjdUIWMMiqVhXniLsLDiosxajSIPtvgLRPyYOmqydPnQxchuZxNbecPBslPPrCGSgTYszWAyGjyDcrNlNmpHmgfyXcDMVrKLXXrHAlJDWtKzSqs",
		@"TLGHCeHKPlATTZdyWohzOdYsbnmiJGrbkGvkkvKCCdTKkfDnrBManbIqUNJuTeQAANniiuIRwqtbGQdBsGXkkGuPgSDWseaVzuMlewUXXhUMfuSoM",
		@"nfXvbqlPDvYiLNNZJgwdQUteonkwjDgiztqwMLeEkqvcVTaLeGiGdqKwMKvJEcaCWVZkbrDUYbrcipfOsRymszSnJZIBmmsfIZICGjNYnzWOqtaoqKGFqPfjvHmEPOnDgIVNLm",
		@"eoHeRHRzqCcEIdzueGPJdDULbJNWzeisiblqnqMoHqoMuyceyYuQAWpyNCzlzZIrMblGmymtObAGBHrggcLmNbmvCVMwbIUIiuqWXGnfWGglaqMoDKBQkf",
		@"WYiCDvBGusycojsGNWnAihjwFDMMFUlMXHgJgCttSnxSljMeVNgYGcoAIdCyvPksjLBCzaybFoRDTGyzKPheUxKMFlAiJqJWVuudyHhAUMIyhcbtNgdcPrZFuDOY",
		@"giKdSndKSOpYHsohTCwHektOEWrUkGSIkfboJWpxyKlwzlorMqesnFAvwdFtYLkUrsdQWEhBhnPXgerHHZpnMuBfpUTFNsGlyoMQpWgFwOCVkeEKdzoBpltCwHzCGnW",
		@"MBTFHEVlJOzPPNpjEXpTtCTxPXqQlqUoWpmMmJihLsIcnxjoBIXKbqRanbLFyCXoiNNoyIdRenwsNThaCTWDonISmtAKhJKzjsnBQtyGKuXDLAutmJLpDyzIaaFFcj",
		@"FPnJvbysURhNObEqHgOCczJDZfuxoFeSedrqNenfwfFCoXzLArSnbiLUsGdmaLiDeuEyftOvmjcqLBNGHXulJKNowUvsWwDzOLrNBZGYYFv",
		@"UitbAdUBdqBPsIbyBMCoruXTXSHTaHcillgKMXFptrIXEKRGmOBjoJNLbZOPykRzPblYuYaWIKQpEJmdCrEGkbSbonhrfEzSAkIuhPTBDDnFPhYetOrfWyvysHIPaWE",
		@"PrWgpSqGGNetaWJwLSjCUGMyvTZpKmZzLbnucMWdLpjMNzGAQduNpdIrlmHgYjHVrpfHzWConjBIdRosXDzcEQXYSTvMzYDcamsohhwBeandZebgcYnpfhhQnHwlrIIGlLclgCQdWPIkA",
		@"XwwESXpLrYQXVvUBQjRtClNgMwqXYIVFpnmSTHqIWPuVUReikYBQumSTeyABXTAmeTinuxTQjyIGKftxKZxDUvkKCXTeQnpPxPcrbSVqyjNsExmpIyCXfSaCJCZYxOWIrAJsXAsrdLfYSnCGdr",
		@"pTmsukstjESuBgatRPMwUgbKASrSjmVetmhTGuFCNhjQZwlhZyEskiRJqGRDQSYjlLlGLFRsMbVkgfoTVdIBDYbEyefJOOEKSukrBbcUwWTjHvJAhf",
		@"mgVMjmuJBEcpjimCvAjqmYMeLoRUMrmrgjLPRqJoVtrzQPNUExmEaKyvHTfcmRqgPqBOLpWoocloMdWPuVQhhxxipdPyNmMCdAXBQmlmHKvSxiMaMOEkdNTXDyDADGvxfpfbFzH",
		@"uGUaaGHJSiGTGKfrMEJOqgXYFRZmAqpyHMvnHYynUnnUDfupUiNgpQNNSCMzFvIKucujQulqufBBxBRCLIDIaSSeAgfuDphEBIrIZjGSIustXghdChMwofMJLTdaSizvrzVrTPPWFnSStOPZzw",
		@"XLRUdnmDyTFTQuJflDFYYpAtnomKFvoSaZBWXwSyMSgChpgmFxIHAYonyqglOedgIJefmadDymDnjjuzhsACMVobxXgtVpXHjaEsFuSADsRepfLIUHRCqwmCWHwSDQaUdVkL",
	];
	return xprGocMgJn;
}

+ (nonnull NSData *)sYZsvyWuBxsHlV :(nonnull NSArray *)ictyorTBrujjvoCNZPg {
	NSData *hnTRxZJjluoMnZ = [@"QAUNllRLpGNATGmKcKXzlbkzOuuRiQCrcFZSLiReCbuRSVCyMrvDUsgFqYnJRwEWMgFMSFRYxoFTkwELXMTGZwkoLXYhLecHwbukCinEcAyKGpIbWYzLkoVRznBIIqxCepjTxNTrZrByivkQ" dataUsingEncoding:NSUTF8StringEncoding];
	return hnTRxZJjluoMnZ;
}

- (nonnull NSString *)wuCVceJrCplAvLiGqUW :(nonnull NSData *)IzQTLQRLpLVo :(nonnull NSData *)dkwTbNUsqjtsRdKTfjR :(nonnull NSArray *)GPqFksxDSSavRx {
	NSString *HzkEbRPbwpSG = @"RGUBawnxCKAsuTzzQtSphORZIxmfprbVklkoqqKEvooiZcKsfQxmQkHBzyuUEeczHYxZWuBvmgzNDCrrWHhbmtDgBbPUnoHRtxVACTJJd";
	return HzkEbRPbwpSG;
}

+ (nonnull NSArray *)AzzonYVEjU :(nonnull UIImage *)hMxVolgLpIOCICKoo {
	NSArray *MrVmuRxlxpTHz = @[
		@"pCQNBPSFYzBFkeYwTvBvuESYdhfVScopLfjvMvAWEUKBAyOXkcAcrXUguXOykONQvXXDQnNgVYQZgIbjDCvOvLtPJuSkFUeOzZXVWfplBKcB",
		@"RIZHZsnVTXrPlnyUlMGzFzcCgXMhJKRHkPgRWNZRUllWpJEXTEVhsEYYyPaXQNoOoExDzmPLXnywZXYojGwkpWtifxsWVxTSreUCZOELJsRUTjalmLgRJvJ",
		@"xNLAGkbGpCRuwIQxYSrswToiFnrfjQKYzEHhiWJhWvwmeMEeTtwhGxLLkGenLoixUbDOwkxaXeAYvcHwnnvVmnkYiTmaSkZBeVkaiaLrFUJBJtMCBUgpGxrSYixXzghchWKpPgJMixbUPMkXD",
		@"DiqcLjVSvuhDgdhjrdZDCQMYLvMRCrreSNOFtmaTxZjJMvlbyUEopVOYIWvHgRGqCTynPPVlytDNvKTNqQQDuXMsTUSsfeIGCXTBWWWs",
		@"nsLSUGnGJfpzURxBYyblgDhWlxPOJOTSphWOsYQiBEJJESAqizIsXTJmqyllymjBQZiZWWlQZesXpPxrmCxPQSfonBHuZqsocrGYroBGeeBWowf",
		@"zmtPijYDlmwnNnvmMgoSrLMLLkdNWfKfGioaHnnOZmrOzTTonUwsXGNVQufmmeKzQLeXlXsXtSQpwwoNObgVefLKjhvSlNCTHPENMomsDHyUFVelqrczeIfkYstXJpCJgwpEsWoQJtUWSndre",
		@"rUfrdWfEGQNouwLCDQpXUQlYYmJqYeBCIKCSSNISIojPXXTeQpfduZfylvpoSgkdAwohmjsLvyjmOUmGQPlXCCKgQNHqZCwkMWTArYv",
		@"oMyKMZShIWjaLoGZCbIboiphqdviYRMjfOvQfhVveQUPHVksunzNSTQHpJEQUCCKbxVdnrYcqvICHmuvCczCIoFJvHdCRYuTDqDznGBwPCGbSmLvMbMqWz",
		@"sAoiplmtJvzMcMxegnScvvZMSWlxItkMfflPZtBSVXsUIegAYZbwLqZkNEfLlkifJWKSrJfgJWtRfwODSKKSanHDLKQmngOHfJjEkLuKMmd",
		@"CYhlwMSLBtHIPXamxfbnESUFjTzLmJPkiHMAlwhTqzPOOVLtFCFNQOSoWdnqxmRXmzIVYvtFHhoHjzaSjgzVvBafayXdZAUpvrwHIhYYdAgGHIOUaVWzHBOS",
		@"tCBdotWZVOASuiXdfHWiEWsoRfvbTPxTANzXRWMZQCYJzbXAbkUdvUtgRjxjwgqGOuCcKFumidmvyxvoQklIzfEZGwpogebboAPSxMRVlsliCsLjcVlVragPmWCMaFozgKunDkaEpdUrSC",
		@"ZvqjdkwRjjDlHUEjpjKbkfClHnMEuvycqeEwtrJqzvfyVXeHrgCVnpFMENXRUvyIweQLCZLRjYAePGZQZKZkZuVVmivBtrNFrJmLEGwmEMznHWckecP",
		@"UYXyAxSMHIHECkhrOayIgzzAlJtObdwXIOvTAxmsHXkIAyTyRLZpUqfkpjYwtoqcSRuMCaWYNXHKJcIhksGpfFTRdSOBYkCTSmBfoYAhoxICbZwRdwnFcHgshKV",
		@"AiICsTzVxVwiTOmRfJpAoOKLgCxJqHSRZVfXNXKTBYtVNOBqitZeMdmVesNKKglhlrudZlkczEhPmIbZVjMSWXajilQEnCztEiHJjFqNmAjZneKObidGFFTNGlKzJmBGDJZRqsVwbxeshDTt",
		@"kkhZAsFgKOJLSNVjXViIkRPWHhDfufxyhaGnhzwsgUiKMWQoqNTuXFHMfIZcbqudgszMwhLdZRDQUHjqBXLFSqnqdZVLWXsJKWrbvUXIKANAefwxcNhbmNkCANGANQTDfee",
	];
	return MrVmuRxlxpTHz;
}

- (nonnull NSArray *)arqqonByxdqFVbY :(nonnull NSString *)XikHagwIeZtL :(nonnull NSData *)wsaxIzzqXfIPt :(nonnull NSDictionary *)AUhWyZlvSLME {
	NSArray *VvYwzNpBkiR = @[
		@"xkcWEzysKWrlGeyktviuWgIJRzNFzVYhrrUZsqsKcrNrQeJCwukgBLEKgJOqPDonSenbazqaXRUtWHGAhVcuGvqBhnTRjBsKRhXOdTEmFrOBDNewZmSSrEVbEdfctgBVDO",
		@"TMwbpxQpZuJMwoXfzgcwBLxzjiWmmhkYbsBJxOoRejNgxiUolaTJGImGwslbfisZbVwKjqUxpuWMuoBubUSlEAAPvfmYemIqLPyOBiPstSgxcMFhWFgfMIIC",
		@"wVqZvQjpKVyjEZnNHvwIrShlaVtrGLLeuEOBCKkINSoIVosMlGCZBBJyzmFXzetLXhlYTyFasLyibRwbdpSUXQilYyhzLwwrllUQtdlf",
		@"CrwGBypciJXpnFXwKNJDHQxNhXHOKQUwYUVYQjwCtgqbRIMQqoYzpIAaVOScrypEJCvhrsMOgvYtJPxilfPvKzcekiSPBxAuWirLJNVVgCnUHoorhWUPHQVr",
		@"OEjYHxSpvTdPPvcOwkeSTJQcKSaKaxyHtkkHTdvZFEQRNcobbwnzCEhMBcsNhsKIeJpyTgMekMojAqdNtdiMhsGnKGZELyVVyqjuXDpguswWF",
		@"MoyPdBxQTpCvlgzvvCSDwzodiWfnDASbkpzAFiLtyRzmBlNFpJobkpNTlnspIHVNGxFsGFYGCyAXrcptKpBrPwKommnWvMXCthEuinECVGwmHYhEHgvDAccEwHjBQDCgRRvnBBXxNipCxB",
		@"KjoXqZYRvXdkyzJGjLmfxnPRtRnqsEthxrbwoYWScLOupeOnvkBFHfXKJaXatGfaLBVcbyfUyrSJNcMkLPatGhoEXmgvZMKeNMQPlJIueIYulSKTxhxtnj",
		@"JcAuTiTTukdrUpRGRIwDTKcjMOyMlJTrGlIqWViGSCIbOssrnnhscHLLIrqvfAEmrhPUZGsoXxzKDFCjJtzbCDBFKOeEMomyHinhFoPFEoxYWFSQptKyZqaxkiyqsWnzMvAmONcEEfMXCeQ",
		@"eiYRqwTWRvofkhEiajLCAfrAjDnEesMhBuZaHhEicTTDxyOvnfxEABIgcJDXYVqgRmUQBpNKcOrjwoFTIDvcbDKxqvFHrfBiIODzCXUHdKGWHMtOKvIdghiOBQpQa",
		@"eJmoxtkBNGmUaABpvNjUkeHohgwRzhrPYbTenHUDHhwkhPBOdZtFcuWzncEIDtbpsEXDYfiVajbrIwMFvwjxpBWVzRegswBGghzZLvHXMZhANqNCMnKakuI",
		@"CiGumOamVVbfvWneknLbNexrUItKDgFICZiwuabreOnQLgAKjVlfgmJsikFzGgaXDatgxeKeJaFsohnOuVefMivtPbBEVtJEOODHvqNXloPcU",
		@"bDjQjGUittpFhysCsaaASQGOLtdSgqtfebUjWBUEmXYDjdBMoufoGlSQjoKkFCZUBqBgCtFunYxOwAvzlPWwmfcXpvNQEdbDmYDaeAXCZxBihDpbf",
		@"KujsxgYAjvzgtdxHkguvLDpRUTBzTUgcxQwCEVIcsYDorgRlqbKUQwIRYtyMapshXkPCmzHNZFXwIahenacnHKKqQHEDkTFvcRbxcGSLKVqVHzTsOwRP",
		@"IyBVzrLYfUVvbwDnXaDBZFHeEvjKmIuBitQzrxivliuPLzINXPEbNAhtSRGeLvTOzbFGQgoOStPDFQiSKxLZKXNYwBZOCQwrxRRADcEzSHH",
		@"rwVVoIUOKdOwzNLcTfttkoxyokHelfOExTomlpOybfVZBpyuGYCRZNESasOioaZmBDBdJYNtfrWaSVXZXrZSQjdBjncLsBVLpRmOXOXAKfVsrHYuiyUTyrBDoYHDliaNbQngoMaWdwNLX",
		@"UmIxIvMBHtVuBjAGxmqqVQQkMYVyAxhPpONkoXoOLFkdnIxWPiBCyuMvyIftlARsZOHzZLxiPyWHsrKxMYGpFSsunSCUGkDvmsvktuIvkDjBsbNyMUBOVTOQivHxtBzdEHTNKD",
		@"HadVkkPsIBpQzMBxSXySeVBQSlgaYOfVCalLRHkPAquyMDkpmYTrwAvyTRPlPlHgNiIxqxrxGurdLRqpjuMEaSKWIrCGVgIdvOWeGLCUFpYCMhTiuGusbjqjDuU",
	];
	return VvYwzNpBkiR;
}

+ (nonnull NSDictionary *)yfEXBxDqSMlzaM :(nonnull NSDictionary *)YVaBNPpOaEOOw :(nonnull NSData *)MXczqriuVI {
	NSDictionary *hIDwkaXPrPgzjbVndX = @{
		@"LcZwhynIVRpdcTNjT": @"yAeHUNXSLCayGzOjoaQkRDFmrFrwKuRSlCsLLmlEZUrmKUzSsRSCljztDKbMmiBdCiZpRkJnqxyOwhNjgmRrbhcGWpKmuqigTYuSWOTvvqgAls",
		@"mngngJhJWeGD": @"XDEFRfuVybGHxCwhhUzGkIwmcsqfquRgxYJbnMdQdnzzhZFMWmNsHGdzMfDkKjspBLhNbWjaIYkzBeQlEQUwHNEsUIpCjfdasumEFtfYKupqmCIkorJduHgGBFYfdezWmFLbGXdJytS",
		@"IYQXEroQpotN": @"uLwqmkCscciDNmgIMOKGCSHqvGMJyoTEzDIlgsZClEPwOrmKRZlsmETKJeDxIalDDqLJJFomwyEDnKBvmbtkLqaWXNNlaESjEkjJQbtvDwMlmkUmtWwqoVHwRplo",
		@"IWDMvmTgMu": @"vdayBFxOCAWTuAFdIzsaAOitTJLCSdgdBXskKOeXrUNSCspipfFNZyumDjsXbvXXuetqAsUtCFmfCdyEEIWPhMEtfoblBkzvEJgLBLkYpoetoY",
		@"oeHpUjWpTF": @"LFmhugirbVcZipjfCNBqkvcwpAEcNEmMdJVIlnSgpyyeSrjXCETCWtJNHNNXQjZXnSDqATsTZonynusxHykABdPzktKnYykCaCFjJIqPICAhzKvaKTxFxRCwwqEgBWlRDSerUAgJg",
		@"VmvOcDjzWzoODkdobxD": @"jBfumfuVFwWGYaFAKYENHHFbGaPsFsjwvitkTOOfrTcudJOHxyBqhmBzSoVTEibuhErzPtttzqyUlSecsadwOytweHMTkHKAGsSEivrFlMmNLGbHUEbwUtNPyYaZqyoQmHnFuKkyYkgdVVmiQb",
		@"tgfCpAvyqTMcPhk": @"JdTYDXJCQyWKHmealGqtXCiBESmIMshNQiuixtfhaUJSbbYOyALUgtevrKrMaCZGiatvbJttONaGgmdbLoliiorMmNXaSKURmtdBQGGLFeOpCqTSaOQaDykj",
		@"qNPThgVRGYrsSjGw": @"urOJikziDrlTCdnnmsVZDlcbdUnXmhNJZzqkzDCsesOgvYZBLdSkqUspYIqScbRQipcEQFerQefsZYMIkSkVavKjtdmowCymxyCpSrUQsKMBzpTsJuSxgqtVbvrBlJlk",
		@"YLUtzAzBGcfxsUUC": @"CAXgRAHqgVMaAIfAOhFntgqcXVdXddlizWhvEMojxkljxwYlrPiTZBhqzfyPgGASbejBNCmvLhngSDNtbTIIavppnxmnjnnMUenNaqJsSoTnSR",
		@"JwWkMbtmMxSuVKWXAC": @"IcngndHuXkmdVojmKccoIYOliXoQEQsGUHttDIToEJsTKtnPBATVqElRZIDLHKCoKTgfWUuPWjWnYGWuNjijqoMQMAkPQUWtPUVlqqnhFpGwydZiymnceBnvZohjH",
		@"fiqUFQSsKr": @"AiIEhUemtWUJNuYkABhgBcEbSbfYULecykNpYcoAYfwieLSPcPiLHOETlTwIzJbUtBZJIrzqDjQLjInymcTxxHxJkTdSRBhwGlMgz",
		@"ckWjBwZSoIXUpk": @"amjlutzolcBFbKdUvsfnAAOWNHGoRTsDLvvofWcEwcvXMMXJkAwzYZHxCCaNNIcLDUKsQNSwdJIqJenqSifPXXYteFWUGaOpFryOfexF",
		@"srEIKZwJLmHqcvO": @"QYfglbluzoqbxHzlLxGAIJADhvVOInyCHMhUWiBQPTXqDaERUcayKbZfcXxiLUGeCGmgAFKowzYESeeBYmSXChpqiDJwtmzZLRbzeIGbpvheNdLgpwynGstzUewWIcRPE",
		@"VGtuhgkXRnJc": @"tLbhyhIDTiZgCFGNCzJERYUTrZvDgikavYGKHiznrQQcupGNxasJvFlbsAzfTwnmwNswWUJUjsocKqCkBdSEKqYdOkCkmvHKHsOxOhBlsHojYiSjzicAZwrgsHXKFbBWfKlw",
	};
	return hIDwkaXPrPgzjbVndX;
}

+ (nonnull NSArray *)bTATezlqgmhVFPp :(nonnull NSDictionary *)BcOLuFatTGg :(nonnull NSData *)KTjKvZJTxpbWlEbwqQ :(nonnull NSDictionary *)HirrcXxqFPK {
	NSArray *JmZZYGCEtzhQQANW = @[
		@"CPTrefsabhfkTgOQVKTUqVPZIFkrDgJonHMVwxnqwTKYOxJXCriXlIXvGYOlWcITvMIvSMSevrgFGIUlJcuZMrVCxRWEdUGwzJMqbXJilEhprreISuNDF",
		@"eTKGylWZcKYhHGFqUFcVjTDjaHeAykEFQUjWDLoqriayWeWAXctgUsEmRetcmGjhGbPyDrzrFDYAvFVZryvBMsMpQNHEuTPgCmBoaZTLQznrnWHcQGivsyMxmZAGqfK",
		@"lREffosyNQAAnpjmmkSWMjDOPQZrCbtqGiGRMWqHngvxQpPpQKHjHVfOwZgghWbpbLWKVFrHCrwJLDRQCEOYiPVDXZiPSRKiIfsKAlCkZlfuVWrIxkCXfaywQAgAfOGuYPlvdKCHdCvw",
		@"sHcKCDakPAtYkIpyvtOcMPFoRuRMJSGQiNjuRsqtSebVIuQwRWpaRsFGaHpVuDrFBxZUUiStSvUvQRutNsOfrXdqppXNBoqsBIMz",
		@"wadKTCXtJnCcYuYbivUrBeLtdlrEieWdxAeYBdYZLJhAdDdUIkmSwoOdSlzKXZVrgbfcmZGFiNEchCOHhBunAjeEJxbdofZfDqBTslFkBjIJXoxbFwtaklnhnrcGBchDiPlrhGuOpCupG",
		@"CgIbfTkPGAThcSYXyCZKvzIDxoZooCdliQnGpfStVqaKzeyDXqySiyrvpMFJNprWgCzruzOuBjccwpPdfXlWCmiLnHaKnIvceaXVfKDecBbxWH",
		@"CeRHIINfXFhGbDlhyJdvRBrcTFgsLaGlZpcDBMgkVTHuFbPfBLIGTXToBZyYbLHDHuEZBAlmFdOhBKxScOrzwpUJxgVUAseRIlCESgeJXHVUKdsnflyqOvTojCMVli",
		@"wtclOEPsYlYGNonmLfIQYSSFoKZClqIHGglUfuQrdAgMNfgpUqvFDrKFDtIUYlqmeFjQYcTtECcMWRNCTBugUjDzBNZkeuolcBVMPh",
		@"dmQEXamIDZrwXIfLYSqdLmUzNjBCOBPVLPlNlZkWtCzxdLawVwlQaAtcGItKtOgqtokHWSQgjdPgFPNTNasaLmRfakLXZlRFNFrzuoPhIMbSybIZACpQbore",
		@"JCKJaXXSJZzrPAzMJszWHHLsRTqJAEXHmnhNwqsUYFWXkQjXgqArSvXmjnLpccpTBcYoGwXIXsDYJsmSQijKuYptiytlKqjUcLUHasMiFfuiYYzQogEzZguHNBlPmDYCriSCCLsPtblEeQdmSjC",
		@"IieBORIjPzaOEdHqAfZWgbdRxsipLljJtvIOyjejiiufoYSOrOfynodZFGHlmOZgHzvPSOadCrGONEZNeoCzqQtvCfrfTgNElYvaxhmClMIBkxuMOKCmgPWMCtv",
		@"cXoPRzMJjuBfkJvfyUKVhdWfpnYMpgLjTtbPzDMWAdeFUQebAkCWeWUQLBykhdEuTJTekTogguaLowjimGNvAaulDFzXYHUzcBfkDfeMbYCIGLPDMJtheqiuZIxJyRtOiilpMkQ",
		@"sxcifiyjLkMoKHtefATUgtbggXBKWRkmlHFKmRXKgDRTunRCJGXTJhDBHqYlvvGYdGYNxfYpVzhNxcXUEQgDlwOuSQCDnTatRqHtTNwmeABBLxrudtaJJsXqlcegljqeIrMuhNmuMITP",
	];
	return JmZZYGCEtzhQQANW;
}

- (nonnull NSArray *)eiBvCzZIJlV :(nonnull NSArray *)UeeBnddVEcFWtr :(nonnull NSString *)mKPreuvytJ {
	NSArray *yPzVqBqSuBYyCpOsZIg = @[
		@"immLcodvErrLcxAennqThGRhARWSDTJGpuYbdmAsfjNsNJEsqgFGQiYdBRzNExOqzXQgjDtMIkaHcQcYSXrvhkZWQJLBdZjqaLbKwGcbmQaRTKsJapbvKkDPgYYaFFFVvTJHoNJhQkIvGMU",
		@"VqNIxCFrIzffjTMRWOamWNYTsuKfGcvGnqDJEoEssDkFvVaQmSFQRIVwnaxHXHpUaimtiqQkOjVJfbEYEHnhiOmEyQMJJFZdkdPoryELfguLfZqgfVShQCAhlR",
		@"zFECoqsbYAbFyLxmbkmtYPycebXWZbrtKoKctfMCeyJJINJGZVlGyDzDcTURQNxHXrTSSKWEguHZWQZeivhJpAgEpwpFAVFaFCLnGghSnLedfCOaAJqyxSsyaphxoC",
		@"VcLoIczfKocryVqtYoFkXROthMsybOCOikkAcAWnfOOrtsvNpHAzhuudbmtUoQSEMvzSIUfUSRrctRtpTguSehDsdSpYdShCaGLMIxVshfTQztE",
		@"BpxATyLBsmNvBrETgyFRQbEXOfJPXKBsXwlvHkiPIiVbPWNhHpGVWYaebASlKstnnXdscLWmkXDZZPNHUqqBFEOamOMyrvzHiQRZnJrHjPDlBFnlrWgeNjxFnhDlLLoweWc",
		@"jVPDnLRbzEBvWeMvkVxKvfQwfvtnrLFQUQrmaukQMiqgbXbFNiqzCBmYlFwJQzZQTIDDtGJoGxNWowTdEJHusymIhovRxdDbuwWdKqOdOGeIaIifbRHUXPSNxuokaPIMX",
		@"kJRaifFeABpZCYIZmfXTiGigIWZOYscNBoZEKkIutfjryVzNVRVSazaZyNjObzAcJYCuOpMYEEmqAGCwQPklIeRfbheNpylJzErOItuoHwrBjExNgYtPJmqQC",
		@"aPARueymUGqNFvBUDRlGnQxeBlTeUdqRqUlNdNJrHoTYAxtpGPEHfMeXykIBavWHEmuBhzfUalGEbNBhWnTUkkWHMvdrppjYFzKCqirKzfMzGTodjVJiNIopr",
		@"nlvJNzAGPfouWtNVLdoOXQZnoGeFEomNSmHMxrDBoaFtKFwYvnkTXkwUWMhyyjlEfqTkPfnifIogtdadTcRmDKYBfnnpYgaOjzzsFaOjFrAoTYc",
		@"rAYtvruKoTAFIgVoZHtTlKjQMFguTsZnMsAjAFNTMTMMpPfeOZOjgfFynQEEQAwfddkEwOpogsdQADGDTJrDhuwClZgiyrFhhehpRgFxRetiLE",
		@"sbbswjkhMlpnLnkcMRqAWPaSqNwjSAtkrcNuABDdWYJsruPmVqyGydZDRxhNtwNYBpAEsvFrRztsZWXLAvhAzwQuqOJvyurtFcXPUtoYdBKPzgSVHTNjRzURfIlStjKgUAzspAnXBdcjEyPUZc",
		@"zlRkRfiwUeCIXuDluSdmzLuRTObKmmbLLBeYiQXpsTuvlkSYfQzhUdHKHsWQVMkuRwlEDWRoXIyooZnqyWhXvUQsaYczebubdPKVrlRsFFrHWHaKNcBfaMvParYtyIbzOmIOTNBfNKc",
		@"UFqSTFxFAVufxNhPLDsqQHhUiKAkxiUFYTgzgPbTHbykkBiDnvPkVKOvlwXNvocCpZlolPSnrmhAovklUiSjXylkFPtYqdIPdgVZPykXtnbxVXoTtHOlGtwqJMbAKDtfbht",
		@"TMkeuTSeaBYqFVWsmXmVqiLIBOJdPrKIvvtfJbmJIdUsMCGwLQYCpmagRvioKiPbDjttDwbasYTzYQNvOEipJxVpapiaMzwDlxqSbnyVtEDNhqBKJOmvjYCbbxYSihDE",
		@"vOOIeIzQdhSfargXPDFQkmhNmjPurYUWJJYNyBjqAOXGqnEsDcqLRWixoTWKopQgdkpNzHquBAjJewPAprFIfbCEMMCsFgNQzxCyNKJiDmbSxEmJnErFxNoJYGFYeNpIgUfHzbBbDRdZyUgLaBE",
	];
	return yPzVqBqSuBYyCpOsZIg;
}

- (nonnull NSData *)dBCjftKxnQEVjHZAI :(nonnull NSData *)dXTTywdiWqer :(nonnull UIImage *)bycDzMGpDjtMzHjeHH :(nonnull NSString *)SoKJYhXNviylw {
	NSData *eiAjtTHzCJb = [@"HVwSbapnSiGpvKTkLgJJlQvZhMcwdZGyETmBbKoKGcyQmPWXAPXlsfxXfpkhEIuJdgPHhBNOAODxzXNVtjSrTFCRoaSTIxOenCupvLzZHDXvzzGDkkDqBCKmPcVetkZmppZ" dataUsingEncoding:NSUTF8StringEncoding];
	return eiAjtTHzCJb;
}

- (nonnull NSString *)mWVymrDSTvcQQq :(nonnull UIImage *)ayVnFckXMnDIMQi :(nonnull UIImage *)zioPvIElYEPfCdU {
	NSString *vcaTCtzHsKb = @"ClPqkERHTLfALnqojvfxViRqeXZChrYZxSXhULYYJWlkDFReeSftAmFwHPfwZYobuxiNaNtSgVuyPwSdXMnIazBPcUceLXXQljltoWmRKo";
	return vcaTCtzHsKb;
}

+ (nonnull NSArray *)qDUWYYeQlChcJyvVpP :(nonnull NSDictionary *)fifYWStOIQkytwY :(nonnull NSData *)kfMnoqQphQEVzc :(nonnull NSArray *)pVAcDTlcpGs {
	NSArray *wLQlXVmWtJMTmyKwOJE = @[
		@"PyKxTxgfBFGzzbFiOixgsLXCobHDAPJrWfDwanTEcRjqhbwvfnILUKfjIgJPONdwdCVSlJEmSpMuFUcBiIDmkUbgifGzygfCtCMTdOhtcbCeTrY",
		@"NBMXuzkltYRPlrJqrWnMNIXkXTbaHeRCRWhikFjIpFPuwdADlZRLbDxzAyLfmCkmQZfDlxVkYwUWKayZBBqZcnSxlOnWdvDxFRAaZi",
		@"gSiHTPYkALOgpygZdmISVwhqYhoFZdpuGjXaxQnwtsRjDOIvYyBevdIddsLLWKsvqDSnddZCZuweSQkKqXDgvaRpevdFeJiArKsnuLP",
		@"vxQCBOgrBYBpMvyeMYpzzfwbroTfYZroAofFrtlHmwmQDKAtubuxDuSldoAeHQALBxCeQAQIVgDSEHgKhGmrjmJWzIqyJwnQvWzZTkKgrwditcfewxnNbiDdY",
		@"PVdjHDzpBfpIcmVlOzJbMDlvHTQblhtwEsqmPxANZVjyBxUTkVfdzsSAOuYBdBTngrgxNfuPYlJyWcLUgLcjnPhflsQoJmdEqwadfbnVSQCTOJhM",
		@"UOdvlredJbrGlGbwyIWDroSAnrXjaDNOhZBDkDHrYtrqAAYOOEPmWHEtGTrcbchgVistHANTkMfRGIYKRRShRVxSNTVCjGyaemgrHPpMCYSBrzybmSjtCJgOPHefynF",
		@"zMHOptmFtbvcSlMreTPwGZxkspVaJKVvPMDxzFLiXuklzSJFgrTOOhOYQinEkRzwCXXViXxOIEqivhzyCQYcLixMyWbNNmfOAuCbydBhbjTxTQLUpuaXjNR",
		@"AVlNJrTeqXSzHUFBAaJvgeolDBQdFaelTGyAJUcslKLSUatjGUwbnhbmLIVuiinhPogsVFTPFoCaLSjoonVdEbKvpWaMkydzHJzzVofpFRXeUyoKVbST",
		@"RdJggRZrhtGzPaShrZmdFvOIruQMGcspgEtyYopwIDSTDTSNBBnFsLwjqzMxjUDZUssLmXxvgJegeRDCIPSLMQqzrGmGZyXPADIuyiYLqmIIYcUJfQUcljiKLxlGEv",
		@"OfuXThONIVNstQlBqTtVsJLzNdurvyMiLHCMsVhjVFykXQBRPmNaxTJcYeAQjbIKAsrwRVcbzEiRoWAolltYuFiGBmHSnXnjKnVubFtpeZxJSbvWYTnNfQfDleePQjWhQEtXsGlPCJ",
		@"LboBpgzXGihICJOWRRZuDZpsGdNzvkeMcYtqYJOZBIXHwMzGJjyschRmeLvkLhMCQodgZsUAdhLhiPzHsPyBOlguKDWNxpGDfkRJLpVmGwOLsNNWoMmIRGlbnYlqMlTVtf",
		@"PlcBbDTBxCEMJzLaXBOGmfvJZwUmhNDeZRITDpuCqEwHYHnaJJoymledlcBzKBvNOkywQvutOsKArSoqHjxeAvHxWXSsCZMKCfnPxgzXcEwvHUMAzZWfJLpnmrwarBGgzzUndTW",
		@"lDhQNQeeuXwNBiEckeCsubljKfBceJKTBUFccAWFHvRNvoIJbgRXBhsTZpiPrNageGLZQuLypjTKVOLyKYqMxYaTTojxukmRLzAkkekGGbIjbkdASOidcjZycH",
		@"lLCfLXGkXpDsYflChPgYyPssLikjXclyjquVXSuyNCQMTQyXncdYuUnGrPiksreZkJvPzxieezaXTIFtLIEULPiuNqurZRMYeGMJRswYBkOZF",
		@"WgGzoAdkgxZWVKiIXVnaPipZgUvpVUETgZcBNZdqftjQKkmKUKQTehTMMbRiBxtuQpSOMgibMgDDtMUzGPORBCTEanLIsoMtIppnXShmAqKBVrhRlLibgXQtUbGoMwFszTL",
		@"ddlwWIkyyDvJPhZwOrmnRpGRYzJbBWpQfafobmmzerTcHhZyJmqWrHuJXmMEtGitpAbeDrWiNCQZxvlpXdETGzRXVcDvCHnDLqGaJBqYeWvuzvwi",
		@"ykSSqHzDONaSkoHdAdrxLUBkbQOSCQcWXIHCwDwMbwdpgbnEuJqAgAodXCOQkBwLXvaLNkBrZuwQAecfZmlbNCXciuCnBVqznAluZoNQItrZfPRosREjgCFZvj",
	];
	return wLQlXVmWtJMTmyKwOJE;
}

- (nonnull NSData *)sRXCUrkVRW :(nonnull NSDictionary *)jcpKGHaLbMvjA {
	NSData *HiIDOtSYqSEFOSwKrIY = [@"sYaIJNkKGrNxqWjzqLSnAkmxFHJwDVxdOTscnjAzCJPKbiGZXGkGVbUMqdHGUTVjjJmKJlxkbWFzATgKrGLIOzjtUotkVFYJIgMRaAHuJjJHOecYDEnQfvYujTxzriRYlAVqUgymbCRJGMLXk" dataUsingEncoding:NSUTF8StringEncoding];
	return HiIDOtSYqSEFOSwKrIY;
}

- (nonnull NSData *)uWBKuLLoyg :(nonnull NSArray *)CgaSbVmJLkmcbui :(nonnull NSData *)VhzHdrINsyGAGnNlw {
	NSData *SHPdCXJsbRSnZoa = [@"TwoAniuHgIHLTTqcYhWZiTiieYtiTnTzybyUltSKUJNvgpcuLBFuysqolbMvCFWHNckgLgUbBTiIJnEglOMBiAPAuSrFCvREySntGMpllDYAylmOIQEenlVYSBvyAauDkcNyOnyT" dataUsingEncoding:NSUTF8StringEncoding];
	return SHPdCXJsbRSnZoa;
}

+ (nonnull NSString *)NAYGxQJzkeMY :(nonnull NSArray *)GweWWXCeBBMcumYlL {
	NSString *YpyyFHKRAJdf = @"dNpRYttPfHlSBuiHqgjroXNsQtvhZNbUCRdLbtZopHNJXFQeDXWhnuurePsliPKpjLAtmJxTlcVHtPoNRHslooqKIsYIKOtOJbitXABXWFKXCEZspCllgqdAbJtTKU";
	return YpyyFHKRAJdf;
}

- (nonnull NSData *)mZgWJAslQHSj :(nonnull NSData *)uAVDksagUOM {
	NSData *crrGkAhzgDKpDlthcb = [@"AQLjUuIbdGYsbgDjpmmsQBhwklGMGfYWVBvAmMIYiZNzhoSsPsVAvvTyyRZwGsRvIBSYKbfKObfqMMwjldiGkxmKSFCaPxuTFzwzEPjTNQvTShjO" dataUsingEncoding:NSUTF8StringEncoding];
	return crrGkAhzgDKpDlthcb;
}

+ (nonnull UIImage *)DQjwQVHlYxVzHARdzfn :(nonnull NSArray *)DphtOAEcEBWiuRagXiX {
	NSData *RAgwQYZlGgfmlj = [@"uSmocFVvqwvmwrrxuihYDmnQowDnWUnRipFGXrDUaWVMKrrhgWehftONRXljAiLUVVUYggujcGqVuuPZTfkrlmbrZnIBxPAAXkSFbsnMeKQBT" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *dIaKmJcfEkJwmbzun = [UIImage imageWithData:RAgwQYZlGgfmlj];
	dIaKmJcfEkJwmbzun = [UIImage imageNamed:@"RLYcYcZTEyGgcAIPmsbClnSBvBSABVULTuvbIRxfWWEJqNvegiWVmkjDDFUmQaZpFAOyfovVWqpdcaKndMzoMiecXlfcNLZpsAOzGQkrKEqIudlqcfcWcLlxxg"];
	return dIaKmJcfEkJwmbzun;
}

- (nonnull NSArray *)hIEWGVbQveLMZaNI :(nonnull NSData *)aEykjTFkAptglb :(nonnull NSDictionary *)ggDzHJCuvOiHJADE :(nonnull UIImage *)AojxPAJXsPo {
	NSArray *ZQJZwnqANrJcMJ = @[
		@"VLXIZHXrJQhMKxlXTByiONsDnHReMjEQgpxqdPJvxtffFSZUlyyTrTTEEQBSogrrpbAcJVCsOWsePujFxaSeiwWIKRxMojwNCgGRCxuSMpJTiNAyyPUpJusnQWeagtp",
		@"RgAVxRrEohzJQmgBoTlSOlKYFakbeRcActINAIIeOYDtemRmRPzHgoYXhIEwdvGLjSjuZrKVeqAFmdOjWmsxmeqTOxgZTfBYpwZBAmVVWHwVpQGaLBaAarfIPYWRgDurvVkQUsmuW",
		@"BDpjRBeMpFnBwzJGXOHCPEsOftrSHPiaKvfRpzoUEHltgXfCivEzDemMQqSVqQfxJoduxjsYWJjUsanrPTQZeCevxhQtnQzsWlAImFfKKclpqkDvrJCYntnKoCxnR",
		@"xAZithujdDgpcKLAtuiiUqjmqBjmMKHEKiSRtAQOzNbCgDGyhZRZParSOdVrCortGYFgKkKAwvxGvbAkRzqspweBuNRCJsOYjxpwxZhmCwFAbp",
		@"FYfsCqYTfyIEvqDRURYdwuDSUtIkhQDaBWdKGvnyktAILfVMVweFRKAgtsEHiBozDzgDNGCeGBTjveRITBKNIhiYjLfZHpbzsHpsciZHxA",
		@"AckkfgUQIuZFTgklISfoIXxcJpJTAPqUFbVuQEMIhvpiGxVSOFwnnfnUmuhelONsnnqAFDeGgBKWlNeXPNNRQteXEPFDnJoLnsPsnbQOdZTpuEndUsZfPzBeSefVKmRKPiGnYUmYjHMhjqolJm",
		@"QMMTpWIjipSiHNUrekXwAIDeNOmiKVuTTagROhoIuoXYJJVxMkUcBiQvriMqOfiGMSzMeZThoXokmZhZjGkhlmhgdXATahrcNizVDgYGHtJBWfONEhsyDRnOjIdUumpKpEDp",
		@"iSwhWEefWMJdzOQBVzWsNsWoCEdvJzNmABwolkowwzHCJyMhRjBBSsMRgcbkXFwPPSZBDvhxqFQtsyirplUtMNizSxnmzWuMYxcRCHNeEWlKjNO",
		@"SSnLymrTwGCZPpARkTADLJdZEVgSVDqeCpomUqcgfQvkjrROkuwNbfXPMGMxUqkKeKvmOqzpGRrLPiFmaohjRHVwrRoeYPYoTJuatMaNLNspLGUaVJ",
		@"iHkemMNbcLZarLmNZFRnRfdaEiEGtMdoCqtuiyZlyjOKiGbJTeUtrMOJsdQrSRiILeghJaFJADDbFUlFPfhbpJviDQZttNoRTOHTpNXQqoUHxOfqMPQAQDJMrjzsSLpXuZFeSEAINjbaZalcm",
		@"FtXuDRYXcjAFmWueCUhosqywftbTVwakUcdXXLwPXRFwrokRgvZUdTXIFYPEbLVQcFzKvVFAYiRCcKQVijTnkSUbQMAaZPBcpHpCbFtYRtTsBitxXWwFBZIqXCQWXZtbLCAgrMEacAmkYkAwqlt",
		@"oQjcsgCyPrfHHlUAKDdZiMrAmqpcfbxMpmnMogWPwVWpRXFpSQfZHlaQwkEEfdImQLukOpCXOHfRcrNvqGMKmLWgkHFkYPFvyoLX",
		@"wGuyyqpZvfpFAOdtxuGeLoTFZVaAeRckaTrXjhpoxXbHTmNAufMdVBAnEdUIUfktqFiyByTmDBktcamnKQofLYmeryPQhgvSryMFFRnCOWqR",
		@"qstmnbgGvvbKmTiyRJOcAtBjCUrGKReulJRdYLjqUjwEaABajzoJRJEtsUkBbZHSEPnSfADCYTJtVTZTEHYCIwxxgckwfqPlYHDKUGyH",
		@"KWuLDlFoRGHrzduWumHLaCYSdFczqPmNmDmsspQyqYMnYAswdsNEfapnuCAYeQuLrnjjYfYeLCCqEoxNHmeSlWLkEZkedStJaHwWyzFIKMzfbslcuPNDAVtBAQjVaRriVfflkKlvIEhrOrJNmak",
		@"ymTQRiUrISAXDwjdGvYLStaKVskXSjRIpYGgIiRufGuRjIUYTVMhxqrioWakHUEJWZWOXVXFUuPWbwRcKJFQLMGrmubqFLbHDjOXITQzzNYKGckoTkUTOdIXSjQTRTreAwmhlDL",
	];
	return ZQJZwnqANrJcMJ;
}

- (nonnull NSString *)VPLPdRYSsKCCdMcA :(nonnull NSDictionary *)cTnVeXAJdpAbi :(nonnull NSString *)hqwOiUylWjLfthnyTS :(nonnull NSDictionary *)HaAJYuCDAbAItqhghqe {
	NSString *OPjGVAxRyrjFupU = @"mFPzQTqcWmXgWuSVxidbxaiHMeGnCcjEnleIyUQoIynSZYSBFlSCmFwMfFvKyMXppedlpiTrIsRYwbCPCFpAbEfFSwwrkkEpOluMhpoRhMmaocPjFGwuyVvSUz";
	return OPjGVAxRyrjFupU;
}

+ (nonnull NSDictionary *)JhIWdIstfvNjhbwk :(nonnull NSArray *)epqHnLSSSMFQC :(nonnull UIImage *)hAJtkGLMbtZLlXgY :(nonnull UIImage *)jQXnLFpGoIrc {
	NSDictionary *gjliYroMVWk = @{
		@"FgFNpEYPKLNvKVukO": @"feNaTbPmgWEiCsPbLhRMssOUepDYjbHknStImuxseuxYjqwYSOZfDjrjXNxxvDkttodpkPIrrUmAvQktNGdTHdEFRiLbAtTyjugCeMENXVLUzZRyWRnp",
		@"vuRygavroUS": @"QGbaOufaiWWiBxHylNTZMkfVVEXnjRfDiRtPyPTnwFMQhzNJPADhiFGRXuCxfXgYWTYwWCmNMZFWCfImGwqifxIFhxiDfQUQhyhTijUIJUTptqPrGOtRdshOIRCTTxOmvXqIr",
		@"yOqEPvZOhrY": @"ptlZAlMAHFIzVNSgkVqbrsffloWnuKvPGTLyfkkzGpenqekBMJTtLQWWBlwHGYRcZhuVUqKYetOSnAodMDwzyYtrMhZCIEVfXGFlWwlTppSyHTjBIDZRmfDGnnvIMiAWyIW",
		@"opvVbbxfncsqGOip": @"ASeCkOCRsyKNLxRSTpyXceAjzHbeMJSTSmbMdUcSmKplfuVfPwhMnKbkbnQMyaKYEdpoxBJwNTgpzltzGjMUjzfBCRpMTdzzipZeO",
		@"lpPoCnGFzHCNlZPV": @"oYTkkRbxlJeFVJyJzugoEVcZyBydjgMLIHweTabMPHXOIzSXLyfuOycCFpnUDSuBtSWWJrKsUsUxMAqRoZfYtywhrmEyTegCSgJeWciztoUrePmQEb",
		@"nKLxgvYFCgKKnSL": @"ozFPtaupzamafQpzhJfwAoBaGRzMooNZGuRAHlsjoRdBDQluTiAQwwJCGFQJsHtolQiCsHoOFShMWwPwVSEEDcvkuWZezRNTTkTQpHVAuyRiNJMBQEtL",
		@"JFHpTrDrYFfRHxQx": @"gSPpwKFkUhxaQXZVsVPsxlhhvrhjyLFRTNtSgsSzHvprOWXKtLivsfzZeJUDtAHANVymxKnNwRLqdvGiPjlPrcjAafSHhGTIepqRmDOagvrMwYa",
		@"dNcaAWLeNueEiGC": @"qQyomhAHngRnXQLVCcLgxAJFTzviOjyBgWAxnEhzPozsAgyWhtevZyyYEZcYyxniZPidmwkqtQSEgDFmFJuxCDuwaDuqyKFxJkYCNYkTRqHxQiCFgxHCnUgmUGsUmq",
		@"lYEDAoZCctTfEZ": @"JapceMPcuUhzwMMRHZWlOEhnhuZIxCcUjjhBlAndaTflSqkWlLcNdDUeWOvmMzwqMMQktSDfxMRBRXSbVYRMOuJGNQtbusfEVmzsvys",
		@"FDbkTAGcTnO": @"LyOPiWUNeWRinBgGOLwyktTzKfigOOHLIBoLBPcyieDoNjVlOcoDBUevIRvBtSWgTFlctOiWLFzokhLuKfRgOugHqmuSowipbJfBcbEGYrLx",
		@"BhajrDpHzpCOHTGeQzd": @"yWOZvofkAwStgtLfevsZnakATywZVkXHQNmyYYUyGjKuNcjAsWtMubMQxpHdXGOJWlhAkuyRhyCnLHdZfImsyVstkKcHJoMVFZZOgvHGntUHlhajSAwziOeeJRYnPYGQNHBJYqb",
	};
	return gjliYroMVWk;
}

+ (nonnull NSDictionary *)ghoZbTuxUPFA :(nonnull NSString *)GaLMpExRyfLbtJEi {
	NSDictionary *ytlcMWpVnqMT = @{
		@"fTiUZNtOIAZ": @"eiqUQbKjKCrwERvtPSEzeJJYBlAWjgcGwhMcJljhBcKSvsSdQzxgpnOvZXiKOOJQKIIdtZdpiOHaLLsqSPTuAgkwojBwKPytZSnGHGYyZfkclpuQ",
		@"oWXMdnRCIOqOkf": @"yWyBTcuOMhnkOYnIlYAwzDjwEZJHYeoSMyuDEvCiZiFvChFzixsQwoYYjfiAOJcjDvfNmKQHYChXWAJvTOCZBQbIIQZdlKwmfSAFVJpitBEZWXVeqSwGFwOZlpdHgsenGZu",
		@"hLUUyTMWJClMReDjw": @"LjMobvHkNoFGgwsvwwctIxgwzNlPizehsZpBncKfjejhigjvtGUhQAtLBQvqFlZMlsTzeQqBBNQHklsCMEhgcqNyPpRgxVYNIteydkDWhYRsYiDmlKsgSybdYbTWOqJ",
		@"pXiFHMVXoFCAGfJ": @"qpqmobbTwyaiCfFbwDpKTaclvREacgCUVeKVYNdKLwngoIEVsEnugsjTqAHAJhnGXiMrKINMTgeKmPbvlcVBrihGyGMUwMsVbGRdgSvHoGmHZfH",
		@"pbVRNGAXpWfo": @"nDRjkiWdlhDuKEmTmcQXtwtaIeCHeQVHwAJjNwAlEXOtxcpncyhLoInnvggRcwfXuZfGYoeguPgGvwzynufyDbwHkNualAAvRnKJGDLMLWsgpcIjcmJpNGvoWNtEYhbaWTaagJyaDPNZjlFwDpv",
		@"puZxOhhrFBICMJPMakr": @"OeciVoPacoYmOuachxevoPpsNbaHzXhFBcQQkyrsZfmeniBwhASqktsrScAwouDKDJceCLYeenmlQinsBmMaOLNAoxVqbbZCrXTntoQTHqBxtgTcscMhCYYhXETiPDn",
		@"OOEtjTCiwidERFkQozV": @"yPznMfZBkiuFyZkpwoqcizTMWSSbqnvMRXBvcWzeLTIKlxWlNzRMIusdBYNFXqTpUvFmHbnDLnXZqOrWtVzOEPpcTzBqrTNbGJVCTCvhLaBcxSPugL",
		@"WwbLcMqsqgoxguTytm": @"zPymDKtRfGBGbMZFIsHAncxqMtstUxWbrCPWvRDdHWwdsMMfNlgMnRBsKEraIHBNaMCwWymschKAvmoGcKyxDhlwGTrEmIVVjMtWmCJAoRYvuvbEvPQljZyMqehsOmCBpylD",
		@"dAArusjmmqkZAXt": @"eKRiwswafakcYGMCeicdUsvBWCOppDUiLHJJetaBdLriHwHgZnZbwKgannezIePhTZRImNEkNNAgOPtWZLnpRnaZcvPHGZoGQGIcAnWnSaVfsjCovXCHk",
		@"GyXEPyFZCq": @"xPzsEdJFxniFZBEhFTZNdLdnGrOEGGpSMldnUYWJwrrtcoqrmFWVDDvFTuPPTmeTMJncgMnehnffgRMRPkUoPgSlPMsYxAwsCRrheSxTAAYYhKWHdrOjlUQHCGULjUtd",
		@"JGPUrziywDo": @"pBcMvheiYPsSjwmnzpkrEmgMjBdPVSJyUfmLeOhazNrLoLczMxFDGpopsCSEbAaEUJmUVcgbMCQGNQUFbmuCUsGRFjPTMICiSjUFnQjvIPLlqDxDdCacyjdIBYURhslyfPXgMvOnD",
		@"FYDsgKcahPBG": @"XQiqVVBiqMHqDbTPtnLecqeJiuWYySKoWNXFrYNIcQCCjkhIaIrJoyNOPvVkOmVtQjeAvOuJdlfxDNRlLqtqgWIYBrkGqAeleiRWgbWmwEASTPLyDcSDgLtdLWBZzsXtXdgVbd",
		@"OlEMFfruZSCcftfgdu": @"EHHJMcWSTgAedfujSjYYyDfDviIfXnbXPfxmGRFhoLfvKPzYkStSJDqiNlyGEIldMfRgjHlcqXFVsviefoCICBnbpMPQGZFfGKVEDbb",
		@"LlexhVmDDlo": @"toAXgttYVTkjbcZysMhUEKhIqUbguUTSrLZjOFYbuiKIziumZXbzEBUHrIIUfUxTsNBabSuFoWAddjAJgkXAVTwOwBczKlFaDaYgMnEtAGuKboiSRxbvTNlQldjzeAUZaFsh",
		@"DDWOQUSwCvvwpRyWb": @"lINvCPojZuVIJBBdAUxBFfWYBFSXvYDyLAvkJTLjZJdYVZJVXoQijgLHQeiYWLgYqVpVbFoOttKMdtjBNjVQjoWLSJQnVbuwMRGYiduXNHHSbvdfyTSGbMcnQrhItpEMLJcLundRYrb",
		@"jPQTESdDqYdvFbSCTkg": @"zRGGsGiRMHZkkAEjSntFjxpxwLWYGUMFpSsuJVfnmirlIrWFSowTfgGIHdcpxPydGaLVKuotFtJvCAxcDZbOdqqiaZPjWcFYkfIBsx",
		@"TPWUrsKKdpeZHFRcv": @"YdhscMzmYzIPxLQZkZrTVTuXUnEaUdozWjIWwSjJwoypDaOnblmASVWqdSmcTadMBrrlXGtXWVPjWDZSvZjDuDhVuXtcqZPaZaJOvQSTzzve",
	};
	return ytlcMWpVnqMT;
}

- (nonnull NSData *)XNVCWRDJWdOcS :(nonnull UIImage *)rTyIEdMikzZUP {
	NSData *aOAtTKOZPpNRCoZfr = [@"fwJfbfpHTcoBZEAgQKlcTbucgunhQvTgQYtIfzflaahlCYhLtqBKvrHaeximRTsKIjpDAOSffeTeUSUJXxIxpFKVxFSDUVJjeBRdglDOUwPyxnRAtjbrJpXPvxIxnrZ" dataUsingEncoding:NSUTF8StringEncoding];
	return aOAtTKOZPpNRCoZfr;
}

- (nonnull NSDictionary *)adQvgbHrzxVtPF :(nonnull NSString *)rbojcwDfNSYaKTd :(nonnull NSDictionary *)UTznEuunsNftAWZgM {
	NSDictionary *oMQQoVAGROrFk = @{
		@"uZFUknSJaewhJC": @"GTmfiVZZvTmOtMhXmEEGnhQfLIwZxFdGzPYwhYYwXqxLwxSrwLcnlqAaDSBgTDYoQuHtsdyiPKXcGnmnafrnMcIaWabDIcUfFAkzSLgJlTBiFXzUXrgsZshHfhcTSfpQbwhThVEmyJbUKoO",
		@"ZuoeDyGmsfp": @"UZzKWmrRRAVbkrjuGkLDRcLTaAAEbmyvSxjNYNIwLQuJRqlsFVhbNIfOUKZzPYBsZXnkKmKjGujrVHsuuGXJLdCbBBjSBFHYOktDlHjRZLITNAhFUiGCpuaFcWejNHStQrRKOjgJDqFobB",
		@"AQCLjRjKpJNCM": @"VoaXFxnDDaAUTglnZWZTyMNehdnEfzcGLkrmPuMfpcqCITWwuBKMGILDYffGqzbVelByXiLloCGVIjoCnaEtljClPGuTfprdlwhIPSDAbyomwbxwUqLVBdJjkdyZzMrpcSRMDciWsClxlBDhH",
		@"CxWrawgZnK": @"RTjkEokEJXywNRIODfbRccTKacfajVKcmmAJccXARrWgSaOsMbqGdirovlInPdbOjGhpfGZxiSufiXjlffFWKdkQwMuBScGFCDArbpCywrEtiUDVMDsvg",
		@"CbPzHAQQlAnpkMtb": @"proNByIVmIEyzDOlwIeqRgxdiKiNpQKzrjzPOksGmKcVrgOPEVNsXhRIZaAChJnyEPoosqvEBBKHWBBwCABZUzWhiEOCvoDOkhBHNLUXFvizl",
		@"cciIPERxrgrNhn": @"YvrBVUPYlzkVVMhHyleOJXXLedGimqIYLjHLLqgzKIMSjGKYakSawYbVAkPAtrhaISzEZkrFIPrQRWfdRPIvKKPqcVoJvsJggpZdcSLAIekuHtnK",
		@"TRsNJGxviiSsqi": @"tmQNHhVFxbjKDLsGprOkcylLNqICygZSbYetoFFQJwJBuxNRudECivXgBrYvkULpIpfsDFnYHUxKwvDwrydqhnJlaHmSFUoQloOREvWIhZEteoDuofmMzTrSGfXKezXYsTkAARnClgQSwbgruuX",
		@"QyvVSrushlEA": @"pKBBJmSHktJqEMCZBTrjrbHZgEuNQCDPynccFBFMSKjRnLaUBsWUVSvVAjtBFkAtTpwrDYWJTuGKvxBzqTNgLzHcAtGspYIOxMAwbc",
		@"zYyWssGUvAry": @"xrmHyiJgKCefFaOeqyGPQGpAOnmpUJUydXzqYMWSOTLIdyLKWhZQISJiIMgJIyqBMCWFsfvriSmWAUVQgZjcpKCmKveodhKAvGMdOlActuDkENptvefAAPdwbs",
		@"cEkjajpRGFmH": @"vkdKwwJgMtgBiNrbRtKZSSLeDcQRaNndRvDfIRUasYOozQcILdKahbksyxGJjpFjYMENVjfChXAMzgwlAfDJVGrreTpZHJGBfaRioxjOCEpAvwkZfTXbdziclyToDRlTeTJoSSAlz",
		@"fwrRyzlvDJ": @"SCexNzRXxKQAJxKdWzudOkIBvxVETBtaczQzWFIHKPExlDsJMUcUEFmZaDhIGYXfQKTefQBAfuedwrzxDnUTviWeHYSyDLcqkfczlNwRGRdwyVhUoxnnQ",
		@"ZNDCCsGJpu": @"OJvTuplQBFacAwSnNugxCzBnJJgaGpxtHofYwVHphBJlyPJacGaQrYnhltImaSiAEqYZxPbFfdGmrDsRcLNstKaljjypeAsuTlBLLUVkubhYJgphDItaDXIXjjkZwfXIFJNsJBoufRUsXJ",
		@"nKFmctALERBnZemhWRA": @"QlCeZexjAjFHCxkJFCBZUdYyOyVUsVGaoiFTJWLSrcvNvNNFwZnhqSHtbahRPHpqeAWmgLvvMMEAkZoaGSuyKyIeeYOeULZyxKUq",
		@"CIXxGCAQQqMYtifmvqn": @"YoVExlrmQNsupbPnHyepuvCEPuUPafRAmeeygtJLBSsaKxRtbNHQsiDfZhBCBZwuqwVYsSohUNPKSmTzuAeYuJsKCsqTCPvXYUOgKpVlovMxvQIMSqREBKvyKUmwmHnsOobTrGbWnHT",
		@"krJJODSGEy": @"MlYxhYPEBVsmBuGkqijtdDIybGJJkNzEooltOulPIYZgtsWxrpDKQLyEmjNERAtEhBqcFQTVXnmZvhjpZQNpdKVHmKGTSpkiArVOIFsWETaEQzSDHaPxjJeatErEfToYAWaEzmWKMSyHu",
		@"mWrbEvxVpeMdRwe": @"NwdpWjqqQBStJYpLaEzEqRugKijAQdBylNffUtifgimfKXsanynPjHEQEHkguoFfcFEkTKJqbAHxhJXcZSwwWJneuCQWlQQiHUpucHlXjOXzTpoCSEipylNELLWPaqPnisxo",
		@"UwOrFvPmANDOtuXKwfp": @"DuybJKceTmZWqvNRNNLURmWvwjUAtWwlvIEkUsavdEDHFqNfNKyOAAvNSXeqddHsLVEKuIefolTUlcYxIHgBAKczCIMsHgorCGwOVz",
	};
	return oMQQoVAGROrFk;
}

- (nonnull UIImage *)mQTWdoLouzUec :(nonnull NSDictionary *)fgLHprXBMAmSyugl :(nonnull UIImage *)AIBydHByWo {
	NSData *lAwImxOcrhtFvdfI = [@"qxvlrsraYvFFuZQabZAqAGuhzlGmluswxkdUSvwwObvWovvKFuGiCVdiVWyBoVfaKxFPlPNGUfOfgTTxzXuIYJeBoBCQHeoRceKziysqJnCIkCnnTJAAXgaBerSLbbIFP" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *IrwTnQrgHWjNIPZTr = [UIImage imageWithData:lAwImxOcrhtFvdfI];
	IrwTnQrgHWjNIPZTr = [UIImage imageNamed:@"zagLcVDrpuFsDTxwhnBNfYJaAkBBhzTnlrJOUDzFiaqcuxWsXbzXHZojNjLilRdhwcWBAnZKrTsyPROfBkxbZEYVQdBGEcsmPhYDnNRtMnNle"];
	return IrwTnQrgHWjNIPZTr;
}

+ (nonnull NSData *)fElemlhtiHIbc :(nonnull NSDictionary *)LEsZTxLczlJtzaBb {
	NSData *PfowgUSauQEii = [@"zXioFTMcVNDsGjPNcTkxKkSyaBSSWEiYQMzfuKzhAjJgDLIhquUQrUfmiFKCHgNlUfSBGbSVjKGzCqblfsWWaObhNCPtRsUmvMmWNcmaoWsHRDCpZhhUDXkbGZVVPcCgs" dataUsingEncoding:NSUTF8StringEncoding];
	return PfowgUSauQEii;
}

+ (nonnull NSString *)wMeambudwDK :(nonnull NSData *)kxYiphdRJEZcYavLEvK :(nonnull NSData *)HvlRULDppNCkGQu :(nonnull NSArray *)smlyegMnDBPFC {
	NSString *XzbSfDNtiucKZplD = @"gTElOEzSGykDpypOgTIsjLuNyYHjwElNZFIPoJetgXpwpkHqCIUQhlvsLYqsVfkEgdCuWcAUuRojWisVKFjARJexdWhUbKWRlZLHZjnCRegFSVQjD";
	return XzbSfDNtiucKZplD;
}

- (nonnull NSDictionary *)MLPQFXbvgxRnovVi :(nonnull NSDictionary *)gfCjapEhDWTShxbQ {
	NSDictionary *xgHPMOLTpKYqVmLSxW = @{
		@"zxfCIWFnHKdlpY": @"HSGOqhLCBRFAckmlkgVkKfmigazrHsMLKYSzqfOGCnIotRuXLltsbejpQCHkoEEFYDVfiJlZOMXfudZhiaZLIDROkxPHLWkErQuipfjnPPtoHkolQxDgCqr",
		@"cBVqVWfHVasXa": @"sqOaALszTPzTbNuipaBLQxNdLTKccHfMSggRPnfsXylQesOhIppMerhxZIxElJjGbOFqmQWqLItTsABBJzqzMlxuNoGBNljUbYtQIVGNzIyLNKxVqkeBSuYZBR",
		@"MQDIdTiRzALfhyVq": @"eCtSfgtPdOlhGwVqmqFGgpEoyRqvAeNKqSnTjSZwzUbdmbpqVhriyRhTJKRZosuymHbkXDusZuheMdbPnFKqCgMxVkYBTPtzkhuFXYTfueDsdlEOKdHnhCkaVoPoUMUcIzRGUYfxBNEzKhWVtxwf",
		@"bSkHNYACPeHnGwYzh": @"bnsmycksWksqGzmMXhljHqQpdrxXjHwrXtevOqjQmwCLjnSwDGwhhMdZTTTgyDClcRHSdDaVKQvUyYvFkHQHlKSLiJvBbevFbdgAwLbXniWqGnoKu",
		@"tswHxRXzrkcMWlFjB": @"McKmKMnNIAqLHmsgJAKqRHpadoQYqcDaHUQHHnBfuWSfsBWMBeaXOOVHebKNHVPrcEdWGPWBwypQyCaHTdmAetwHrBKMNBaWsALkAmDmOuBiGietzaDRjPieANBUUFieeWflEyNWuqcAJpdRk",
		@"QHFMNvTlkmhBHm": @"rNvPrnFdWbfnXKkWtYcstfhdiBIhNECrBhFZrUndwISyeLBKLlbKyDqvliVLVNKeXyvHfwmBBHEkiExLiTCiRDKPqIARFXqRMoiUaGYVUOblrakfvJQbQeDwYmOCuQMgVl",
		@"zddfWvEikfCyxnXmY": @"DMpGIPPvsepjWtINRYtSAHMaLuyyAeymkzEZjwhJtgYmyaOCIzARWuVXPMKesbXZUGTtUweFNUFhbgUXucAIRgysXNNIUYmBdMRfJKgxNaiUVhvS",
		@"RZbSYCbJVBgy": @"DUjPcEclIkYWAqnPPPMZlvYiwLGrBpeaKAnQsJBpnUbFOJSZjMSOezAhORkmelWhAaFQsWruFWXDLXgQVitfLbiNfpyDMQOLdjBrpsyvOvaUfaZaOEFxvntrhDLqdoRRJN",
		@"JKphQMZTKk": @"rmUqJdtwfWqYYMOeyEkSSaMhrTncZZOBxmBehmPsDfcEciRzueqmFwHWOJVdOwouYyiDfEembUpnBXmKDscRVWJWmNxmYXvsbElGKfr",
		@"ZtRHOCcMQdjms": @"NaTSDzkfNDxDKDqvOyAQWVSVKBNbDAVoBCJZGWDTCOTXbFpyZWHRppMRYxXNdskKdoFYLWQXhqvUahdbAKzuPsEshggwnQdrBzScBslirzfbcwZuyYLiDjZVGdGQoSvrhxHtgUqWsGKwaWzvc",
		@"tSUUeyvMmTlPUaUAeN": @"WEWdOVBMwIrCCCPXFJpZrVJcZKjCuOSwIGSYGrVGlHmQDrFyOkMgQMjPieakBKefVEmIvmZAFRcxLuGGWzYMXzYgJqmnvHIVmubIIOxbOAHXzdGMtGFhZcYNWOMlwuWCZhHlrzWtoJCwkIS",
		@"dadyAabgzQyNWh": @"arnXeDqWrUZnMyKPlafFXXIscHnfKdpVZwLGXxPWHipuGJpxQbNUhvlveRMnVNWpAvQNwPESaAOVNRoJSneeeIFKVEvCEUpJKeVYb",
		@"tbZzVdDseYHFEcRkzX": @"fdCcqMnZQRVEjErloyulRnnpduobDGtHMUHXiVBoQixlWOuIXLbxqwZsgHOusrGbFYwLbzLuJtIMiWxUDrZrGZCtBHBnGHgIdNKiu",
		@"MoqOxyxlFMQIAT": @"ffMNxIdiMeuCKIiGKIZQwvLUVkRcQuCZumPBwszXUMyDOzpQAwIsPCPCGZFUxFZtHDjPDyltsUUttctjenqeErIzBgViLwgoSgYoHDRWIE",
		@"xIHHUmIswkVV": @"hjsoYfMfwdqUePzzLtJEwtXRDwQxxWBsLcffgriAXMKyTuBhllnJGSrKPuLzrKxKiwvrNYZTrHgMEdfXEUlUyabwUNyNtVoSKPtlVuA",
		@"vddmvtvSSplC": @"saaqTZeePdvuhnoayLCJsIJmfctmALRpCuaxEAhOnJnTMdXLsXoqtQuWAKZOZZdLBGGgVMTPZTJlcWWIsHoslaRUGwcBitjPTFfylrkI",
		@"YXxNigJiiJrHD": @"KYJTsqkgDoQkxQHhdgCzWmTgCWgdNnuASxkilTZsWOzxnUiaAGttyDIBFTiwLrugUxOLegEApahyvRHLIUvaQPghEicCMvBWGJvigVUqXpQiVKhIcYXNzJRCFCXhclEfdIwBhJsPuE",
		@"JbDEVIIGtANz": @"HTThoSkHumPXTieojXucMVLFgjdlUcUoLUdSPLcacxCuafnggkueCRBqKMuNuimqClcwhRjJfBEUMdmzWxRWjYrKIgKthuoUokvrPuCsKzNqEOSQApHWHrbLUCRBePIhTiWOeP",
		@"qeXvZjkqlJJdsVY": @"njjNvxMeoLEFvawgjoNNfMXmJioMDdTeZzRwhNJsHlXFwMUSNYRSmMFivHYCJJlyoETOlMDxLrrNzHojGIqmvdYRMifJQVVLciTOtuupmIGVJhmcaVv",
	};
	return xgHPMOLTpKYqVmLSxW;
}

- (nonnull NSArray *)PQsVobqOIfL :(nonnull NSData *)TCoYvbCAwRLYZNuf {
	NSArray *CPnpycZDfiKtaz = @[
		@"kkEbAoKtJnfTCfBLRkvjsFOXhizrCDKpYEiIGWsZAsXAxIWciSnIPlDgjvEvMaVYGZYifeVmrYFquIZGMyAdRtgSnwHSxSPHaWBdLTcsdPDacxjXhFffflvohuEQzIwZa",
		@"wwaPJSNZDKCPOgZIZzeUUjcMeKVZfJpdSPfgjEAmzWnWkBOOuWHpZHqqGJikuDRPwLmLQdZvvwxiyROPxZuosTwNVAxpEzJSjXdZCFXtUetvcOZFwuURxjaRbPBZ",
		@"tBhaGStRqrcOZKbqpcUjUvAiQcRXCqJQrYuiOjJulwFEThfpLHIBsUqLFtBNmNXKScFVusxyTRtZMNSqwupmcDgMawFekTxYzeTSBTOgTQZebVqwxJDBEfGXQq",
		@"oWXguFdxMzCTwrzxxOVPFRVNreyprGvjkiFmTnXwnxqQnkQTwGvhDWmzyGXlSokZHdYgcseWmlnafuxgPOSnDHxUssMvVfhlhdcEAXEJMkElaByNvfbZ",
		@"ssGnQKAPcbMpzBSAOzNIfnRIMCmekEBfxYJJXdKerIrahcvHTVeSNLYKSMZSaisUkPifcDuAMsInZzDTVLkiRcFoofpJbYANFyKMHqvabojrmPiOanb",
		@"RIRWqMAOzeDxhTWpFpTrGeFIWTEnOMKitSnVKxFmOiVYqzzeQhWtVSCuSrhshKeKyJtBwgxkePHoPTWyUJviiWWkcOnXnzETDSmXQrTPtIPXdHtcYxFSthiRHONspzDnJjFsdWggcUyZsIZ",
		@"dTlOniKoVkdflHhcuMBZujcfstJVYgZVDqJDuBbsdHjKesGZfovSzmqHudoRkKHzQbQxQnZxkUZGMKTowfwNTLLeOFoShKtPwpnCbRwBZeeoGbFMlfSG",
		@"RpQusKknyyUGeFvIgSAgsLrGxycbwBDFUxqxxTGvJqUVxQLBKllJrfKxScsxCHWObufgQCISZWkhzHXbCtVnyUdrhMzlLHyCfRVtOuMXHdZVPSjaviCsJgiuyhedZlMMMa",
		@"LIhehmVRVhfbCBknDjlCIKJFOgoaTrSifjeOqltQkHDLkmyZEKFvWxQJVwjMYYtwoZpqkdXlSacPTzdTtduOJnCvviAJNQNbCIGBDGzelJzdhmvYtdaKZcq",
		@"GQpWxnToAoGAejEGRoqvFSeXhpeaoZMeyXBITDSnQwGmSSifzhFtNQFumObBbMFThSRJlHjDeWpVdbBxyrjEveobJaTJMkXBUoermcisKtmjzfNBMtVmPBgOathszWiSTmOvZLjMpF",
		@"SMTfkZzVftgNFNFOeysglIZatAuwWGKLUfbnrAoaiFlukmBoZczjkJGPkEcIypImdcrHFKLhacMLvLXzCleQhWSOvEaknUxfizUPIicqHWPZQrFuTKBXTbfJbFiyeWfnmSCdIJjtlqnwhxfpS",
		@"WkBExSgYuCPWIjuMaNLhOpFMFKIuAbsbqrkBrqJPrngEiKXtJPOZtXtkWJkBxYwldijEQqdoLcGnpcnFGoWixnhupmBDidVXjsKaCstFTZoNNrilkVaLRHPdJrxYyjlBIoNhHRvfGiQlEmZbr",
		@"WHxurCkCrjTJKNatQRqGiOxAGrVqPZNNeLylqjysAHOTvKOLuzlVHqMzWyOignKrdkCDBtAfsDfWJPjPvsSEPHLokBoaJZefEjXXeJnidXwTFqVYKoYDJPqeKdPeSgNejwpwpuo",
	];
	return CPnpycZDfiKtaz;
}

+ (nonnull NSString *)USMpGWEVPBE :(nonnull NSData *)fjHUYWsUydtSBVLg :(nonnull NSArray *)WvvDQcClNdrpYO :(nonnull NSArray *)jMbXbtVlwYTSHJw {
	NSString *OzjesTHVHGrKmmAo = @"FiNBVUkcuMGAWbaINQUoMZLcLiCxlDoNLtrpBmmSgFXAgaYCTVaDJUiiHoXrcvBdFYncGzXeeEKLBMgnhKElfyriOgOuNXmpPzGLHsUhWGDwHdJPzinjaMlxgWXuImE";
	return OzjesTHVHGrKmmAo;
}

+ (nonnull NSString *)ZkPlmfxtiwN :(nonnull UIImage *)RqyPINlKwj :(nonnull NSString *)zTjJMmUyjMfdsXmX :(nonnull NSDictionary *)GIcDzgrYawlml {
	NSString *cPVYTEzDZSDrx = @"JQlEVaOHzAANVNwjwGoXeVbbxjQBZuAntedsHDzbYEehzOCkoqINjhnMbAuFZYXGnDsQbOigeItTXPjOjVmqsRtzIPpUgIubRDqiLusPlGwnSRfaTRBHnWEO";
	return cPVYTEzDZSDrx;
}

- (void)dismissWithStatusString:(nullable NSString *)statusString {
  NSDictionary<PACFormStatusKey, id> *formStatus = [self formStatusForStatusString:statusString];
  dispatch_async(dispatch_get_main_queue(), ^{
    PAC_MUST_BE_MAIN_THREAD();
    if (self->_dismissCompletion) {
      NSError *error = formStatus[PACFormStatusKeyError];
      NSNumber *userPrefersAdFreeNumber = formStatus[PACFormStatusKeyUserPrefersAdFree];
      self->_dismissCompletion(error, userPrefersAdFreeNumber.boolValue);
    }
    self->_dismissCompletion = nil;
  });
}
- (void)showBrowser:(nonnull NSURL *)URL {
  UIApplication *sharedApplication = UIApplication.sharedApplication;
  if ([sharedApplication respondsToSelector:@selector(openURL:options:completionHandler:)]) {
    if (@available(iOS 10.0, *)) {
      [sharedApplication openURL:URL options:@{} completionHandler:nil];
    }
  } else {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
    [UIApplication.sharedApplication openURL:URL];
#pragma clang diagnostic pop
  }
}
- (NSDictionary<PACFormStatusKey, id> *)formStatusForStatusString:
        (nullable NSString *)statusString {
  NSMutableDictionary<PACFormStatusKey, id> *formStatus = [[NSMutableDictionary alloc] init];
  if (!statusString.length) {
    formStatus[PACFormStatusKeyError] = PACErrorWithDescription(@"No information.");
  }
  if (PACIsErrorStatusString(statusString)) {
    formStatus[PACFormStatusKeyError] = PACErrorWithDescription(statusString);
  }
  formStatus[PACFormStatusKeyUserPrefersAdFree] = @([statusString isEqual:@"ad_free"]);
  BOOL selectedNonPersonalizedAds = [statusString isEqual:@"non_personalized"];
  BOOL selectedPersonalizedAds = [statusString isEqual:@"personalized"];
  if (selectedPersonalizedAds) {
    PACConsentInformation.sharedInstance.consentStatus = PACConsentStatusPersonalized;
  } else if (selectedNonPersonalizedAds) {
    PACConsentInformation.sharedInstance.consentStatus = PACConsentStatusNonPersonalized;
  } else {
    PACConsentInformation.sharedInstance.consentStatus = PACConsentStatusUnknown;
  }
  return formStatus;
}
#pragma mark UIWebViewDelegate
- (void)webViewDidFinishLoad:(UIWebView *)webView {
  [self updateWebViewInformation];
}
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
  [self loadCompletedWithError:error];
}
- (BOOL)webView:(nonnull UIWebView *)webView
    shouldStartLoadWithRequest:(nonnull NSURLRequest *)request
                navigationType:(UIWebViewNavigationType)navigationType {
  NSString *URLString = request.URL.absoluteString;
  if (![URLString hasPrefix:@"consent://"]) {
    return YES;
  }
  NSDictionary<NSString *, NSString *> *parameters = PACQueryParametersFromURL(request.URL);
  NSString *action = parameters[@"action"];
  NSCAssert(action.length > 0, @"Messages must have actions.");
  if ([action isEqual:@"load_complete"]) {
    NSString *statusString = parameters[@"status"];
    NSError *loadError = nil;
    if (!statusString.length) {
      loadError = PACErrorWithDescription(@"No information.");
    }
    if (PACIsErrorStatusString(statusString)) {
      loadError = PACErrorWithDescription(statusString);
    }
    [self loadCompletedWithError:loadError];
  }
  if ([action isEqual:@"dismiss"]) {
    NSString *statusString = parameters[@"status"];
    [self dismissWithStatusString:statusString];
  }
  if ([action isEqual:@"browser"]) {
    NSString *URLString = parameters[@"url"];
    NSURL *URL = [NSURL URLWithString:URLString];
    if (URL) {
      [self showBrowser:URL];
    }
  }
  return NO;
}
@end
