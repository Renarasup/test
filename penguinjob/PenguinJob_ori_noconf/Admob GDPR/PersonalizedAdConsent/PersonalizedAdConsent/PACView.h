#import "PACConsentForm.h"
typedef NSString *PACFormKey NS_STRING_ENUM;
static PACFormKey const PACFormKeyOfferPersonalized = @"offer_personalized";
static PACFormKey const PACFormKeyOfferNonPersonalized = @"offer_non_personalized";
static PACFormKey const PACFormKeyOfferAdFree = @"offer_ad_free";
static PACFormKey const PACFormKeyAppPrivacyPolicyURLString = @"app_privacy_url";
static PACFormKey const PACFormKeyConstentInfo = @"consent_info";
static PACFormKey const PACFormKeyAppName = @"app_name";
static PACFormKey const PACFormKeyAppIcon = @"app_icon";
static PACFormKey const PACFormKeyPlatform = @"plat";
@interface PACView : UIView<UIWebViewDelegate>
@property(nonatomic, nullable) PACDismissCompletion dismissCompletion;
@property(nonatomic) BOOL shouldNonPersonalizedAds;
@property(nonatomic) BOOL shouldOfferAdFree;
- (void)loadWithFormInformation:(nonnull NSDictionary<PACFormKey, id> *)formInformation
              completionHandler:(nonnull PACLoadCompletion)handler;
@end
