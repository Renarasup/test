#import <UIKit/UIKit.h>
extern NSString *_Nonnull const PACVersionString;
extern NSErrorDomain _Nonnull const PACErrorDomain;
extern NSString *_Nonnull const PACUserDefaultsRootKey;
typedef NS_ENUM(NSInteger, PACConsentStatus) {
  PACConsentStatusUnknown = 0,          
  PACConsentStatusNonPersonalized = 1,  
  PACConsentStatusPersonalized = 2,     
};
typedef NS_ENUM(NSInteger, PACDebugGeography) {
  PACDebugGeographyDisabled = 0,  
  PACDebugGeographyEEA = 1,       
  PACDebugGeographyNotEEA = 2,    
};
@interface PACAdProvider : NSObject
@property(nonatomic, readonly, nonnull) NSNumber *identifier;
@property(nonatomic, readonly, nonnull) NSString *name;
@property(nonatomic, readonly, nonnull) NSURL *privacyPolicyURL;
@end
typedef void (^PACConsentInformationUpdateHandler)(NSError *_Nullable error);
@interface PACConsentInformation : NSObject
@property(class, nonatomic, readonly, nonnull) PACConsentInformation *sharedInstance;
@property(nonatomic) PACConsentStatus consentStatus;
@property(nonatomic, getter=isTaggedForUnderAgeOfConsent) BOOL tagForUnderAgeOfConsent;
@property(nonatomic, readonly, getter=isRequestLocationInEEAOrUnknown)
    BOOL requestLocationInEEAOrUnknown;
@property(nonatomic, readonly, nullable) NSArray<PACAdProvider *> *adProviders;
@property(nonatomic, nullable) NSArray<NSString *> *debugIdentifiers;
@property(nonatomic) PACDebugGeography debugGeography;
- (void)reset;
- (void)requestConsentInfoUpdateForPublisherIdentifiers:
            (nonnull NSArray<NSString *> *)publisherIdentifiers
                                      completionHandler:
                                          (nonnull PACConsentInformationUpdateHandler)handler;
@end
