#import "PACError.h"
#import "PACPersonalizedAdConsent.h"
NSErrorDomain const PACErrorDomain = @"Consent";
NSError *_Nonnull PACErrorWithDescription(NSString *_Nonnull description) {
  return [[NSError alloc] initWithDomain:PACErrorDomain
                                    code:1
                                userInfo:@{
                                  NSLocalizedDescriptionKey : description ?: @"Internal error."
                                }];
}
