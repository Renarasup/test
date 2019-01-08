#import "PACPersonalizedAdConsent.h"
typedef void (^PACLoadCompletion)(NSError *_Nullable error);
typedef void (^PACDismissCompletion)(NSError *_Nullable error, BOOL userPrefersAdFree);
@interface PACConsentForm : NSObject
@property(nonatomic) BOOL shouldOfferPersonalizedAds;
@property(nonatomic) BOOL shouldOfferNonPersonalizedAds;
@property(nonatomic) BOOL shouldOfferAdFree;
- (nullable instancetype)init NS_UNAVAILABLE;
- (nullable instancetype)initWithApplicationPrivacyPolicyURL:(nonnull NSURL *)privacyPolicyURL
    NS_DESIGNATED_INITIALIZER;
- (void)loadWithCompletionHandler:(nonnull PACLoadCompletion)loadCompletion;
- (void)presentFromViewController:(nonnull UIViewController *)viewController
                dismissCompletion:(nullable PACDismissCompletion)completionHandler;
@end
