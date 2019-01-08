#import "PACConsentForm.h"
#include <stdatomic.h>
#import "PACView.h"
#import "PACError.h"
static NSTimeInterval const PACAnimationDisplayDuration = 0.3;
@interface PACViewController : UIViewController
- (nonnull instancetype)initWithConsentView:(nonnull PACView *)pacView;
@end
@implementation PACConsentForm {
  NSURL *_privacyPolicyURL;
  PACView *_loadedView;
  PACDismissCompletion _completionHandler;
  BOOL _hasPresented;
}
- (nullable instancetype)init {
  return nil;
}
- (instancetype)initWithApplicationPrivacyPolicyURL:(NSURL *)privacyPolicyURL {
  self = [super init];
  if (self) {
    _privacyPolicyURL = [privacyPolicyURL copy];
    if (!_privacyPolicyURL.absoluteString.length) {
      return nil;
    }
    _shouldOfferPersonalizedAds = YES;
    _shouldOfferNonPersonalizedAds = YES;
  }
  return self;
}
- (void)loadWithCompletionHandler:(nonnull PACLoadCompletion)loadCompletion {
  PAC_MUST_BE_MAIN_THREAD();
  NSDictionary *consentInfo =
      [NSUserDefaults.standardUserDefaults objectForKey:PACUserDefaultsRootKey];
  NSDictionary<PACFormKey, id> *formInformation = @{
    PACFormKeyOfferPersonalized : @(_shouldOfferPersonalizedAds),
    PACFormKeyOfferNonPersonalized : @(_shouldOfferNonPersonalizedAds),
    PACFormKeyOfferAdFree : @(_shouldOfferAdFree),
    PACFormKeyAppPrivacyPolicyURLString : _privacyPolicyURL.absoluteString ?: @"",
    PACFormKeyConstentInfo : consentInfo ?: @{}
  };
  PACView *pacView = [[PACView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
  PACLoadCompletion wrappedLoadCompletion = ^(NSError *_Nullable error) {
    PAC_MUST_BE_MAIN_THREAD();
    if (self->_hasPresented) {
      error = PACErrorWithDescription(@"Already presented. Cannot reload form.");
    } else {
      self->_loadedView = error ? nil : pacView;
    }
    if (loadCompletion) {
      loadCompletion(error);
    }
  };
  [pacView loadWithFormInformation:formInformation completionHandler:wrappedLoadCompletion];
}
- (void)presentFromViewController:(nonnull UIViewController *)viewController
                dismissCompletion:(nullable PACDismissCompletion)completionHandler {
  PAC_MUST_BE_MAIN_THREAD();
  PACDismissCompletion wrappedCompletionHandler =
      ^(NSError *_Nullable error, BOOL userPrefersAdFree) {
        if (completionHandler) {
          dispatch_async(dispatch_get_main_queue(), ^{
            completionHandler(error, userPrefersAdFree);
          });
        }
      };
  PACView *view = _loadedView;
  NSError *error = nil;
  if (_hasPresented) {
    error = PACErrorWithDescription(@"Already presented. Cannot reuse form.");
  } else if (!view) {
    error = PACErrorWithDescription(@"Form not loaded.");
  }
  if (error) {
    wrappedCompletionHandler(error, NO);
    return;
  }
  _loadedView = nil;
  _hasPresented = YES;
  NSAssert(view != nil, @"View must not be nil.");
  _completionHandler = wrappedCompletionHandler;
  NSProcessInfo *processInfo = NSProcessInfo.processInfo;
  BOOL shouldUseViewController =
      [processInfo respondsToSelector:@selector(isOperatingSystemAtLeastVersion:)];
  if (shouldUseViewController) {
    [self presentView:view fromViewController:viewController];
  } else {
    UIWindow *window = viewController.view.window;
    [self presentView:view usingWindow:window];
  }
}
- (void)dismissedViewWithError:(nullable NSError *)error userPrefersAdFree:(BOOL)userPrefersAdFree {
  dispatch_async(dispatch_get_main_queue(), ^{
    self->_completionHandler(error, userPrefersAdFree);
    self->_completionHandler = nil;
  });
}
#pragma mark Display Using View Controller
- (void)presentView:(nonnull PACView *)view
    fromViewController:(nonnull UIViewController *)viewController {
  PACViewController *pacViewController = [[PACViewController alloc] initWithConsentView:view];
  view.dismissCompletion = ^(NSError *_Nullable error, BOOL userPrefersAdFree) {
    [viewController dismissViewControllerAnimated:YES
                                       completion:^{
                                         [self dismissedViewWithError:error
                                                    userPrefersAdFree:userPrefersAdFree];
                                       }];
  };
  [viewController presentViewController:pacViewController animated:YES completion:nil];
}
#pragma mark Display Using View
- (void)presentView:(nonnull PACView *)view usingWindow:(nonnull UIWindow *)window {
  PACView *strongView = view;
  view.dismissCompletion = ^(NSError *_Nullable error, BOOL userPrefersAdFree) {
    [self dismissView:strongView error:error userPrefersAdFree:userPrefersAdFree];
  };
  view.frame = window.bounds;
  view.alpha = 0;
  [window addSubview:view];
  [UIView animateWithDuration:PACAnimationDisplayDuration
                   animations:^{
                     view.alpha = 1;
                   }];
}
- (void)dismissView:(nonnull PACView *)view
                error:(nullable NSError *)error
    userPrefersAdFree:(BOOL)userPrefersAdFree {
  [UIView animateWithDuration:PACAnimationDisplayDuration
      animations:^{
        view.alpha = 0;
      }
      completion:^(BOOL finished) {
        [view removeFromSuperview];
        [self dismissedViewWithError:error userPrefersAdFree:userPrefersAdFree];
      }];
}
@end
@implementation PACViewController {
  PACView *_pacView;
}
- (nonnull instancetype)initWithConsentView:(nonnull PACView *)pacView NS_AVAILABLE_IOS(8_0) {
  self = [super init];
  if (self) {
    self.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    self.modalPresentationStyle = UIModalPresentationOverFullScreen;
    _pacView = pacView;
  }
  return self;
}
- (void)viewDidLoad {
  [super viewDidLoad];
  self.view.backgroundColor = UIColor.clearColor;
  self.view.opaque = NO;
  _pacView.frame = self.view.bounds;
  [self.view addSubview:_pacView];
}
- (void)viewDidDisappear:(BOOL)animated {
  [super viewDidDisappear:animated];
  [_pacView removeFromSuperview];
}
@end
