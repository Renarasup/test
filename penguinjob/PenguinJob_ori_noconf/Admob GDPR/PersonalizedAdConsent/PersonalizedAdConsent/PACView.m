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
