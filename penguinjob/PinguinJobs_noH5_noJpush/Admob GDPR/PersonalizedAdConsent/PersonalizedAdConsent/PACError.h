#import "PACPersonalizedAdConsent.h"
#define PAC_MUST_BE_MAIN_THREAD()                                            \
  do {                                                                       \
    NSCAssert([NSThread isMainThread], @"Must be executed on main thread."); \
  } while (0)
NSError *_Nonnull PACErrorWithDescription(NSString *_Nonnull description);
