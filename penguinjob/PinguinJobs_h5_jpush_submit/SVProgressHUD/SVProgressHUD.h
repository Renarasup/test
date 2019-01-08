#import <UIKit/UIKit.h>
#import <AvailabilityMacros.h>
#if __IPHONE_OS_VERSION_MAX_ALLOWED < 70000
#define UI_APPEARANCE_SELECTOR
#endif
extern NSString * const SVProgressHUDDidReceiveTouchEventNotification;
extern NSString * const SVProgressHUDDidTouchDownInsideNotification;
extern NSString * const SVProgressHUDWillDisappearNotification;
extern NSString * const SVProgressHUDDidDisappearNotification;
extern NSString * const SVProgressHUDWillAppearNotification;
extern NSString * const SVProgressHUDDidAppearNotification;
extern NSString * const SVProgressHUDStatusUserInfoKey;
typedef NS_ENUM(NSInteger, SVProgressHUDStyle) {
    SVProgressHUDStyleLight,        
    SVProgressHUDStyleDark,         
    SVProgressHUDStyleCustom        
};
typedef NS_ENUM(NSUInteger, SVProgressHUDMaskType) {
    SVProgressHUDMaskTypeNone = 1,  
    SVProgressHUDMaskTypeClear,     
    SVProgressHUDMaskTypeBlack,     
    SVProgressHUDMaskTypeGradient,  
    SVProgressHUDMaskTypeCustom     
};
typedef NS_ENUM(NSUInteger, SVProgressHUDAnimationType) {
    SVProgressHUDAnimationTypeFlat,     
    SVProgressHUDAnimationTypeNative    
};
typedef void (^SVProgressHUDShowCompletion)(void);
typedef void (^SVProgressHUDDismissCompletion)(void);
@interface SVProgressHUD : UIView
#pragma mark - Customization
@property (assign, nonatomic) SVProgressHUDStyle defaultStyle UI_APPEARANCE_SELECTOR;                   
@property (assign, nonatomic) SVProgressHUDMaskType defaultMaskType UI_APPEARANCE_SELECTOR;             
@property (assign, nonatomic) SVProgressHUDAnimationType defaultAnimationType UI_APPEARANCE_SELECTOR;   
@property (strong, nonatomic) UIView *containerView;                                
@property (assign, nonatomic) CGSize minimumSize UI_APPEARANCE_SELECTOR;            
@property (assign, nonatomic) CGFloat ringThickness UI_APPEARANCE_SELECTOR;         
@property (assign, nonatomic) CGFloat ringRadius UI_APPEARANCE_SELECTOR;            
@property (assign, nonatomic) CGFloat ringNoTextRadius UI_APPEARANCE_SELECTOR;      
@property (assign, nonatomic) CGFloat cornerRadius UI_APPEARANCE_SELECTOR;          
@property (strong, nonatomic) UIFont *font UI_APPEARANCE_SELECTOR;                  
@property (strong, nonatomic) UIColor *backgroundColor UI_APPEARANCE_SELECTOR;      
@property (strong, nonatomic) UIColor *foregroundColor UI_APPEARANCE_SELECTOR;      
@property (strong, nonatomic) UIColor *backgroundLayerColor UI_APPEARANCE_SELECTOR; 
@property (strong, nonatomic) UIImage *infoImage UI_APPEARANCE_SELECTOR;            
@property (strong, nonatomic) UIImage *successImage UI_APPEARANCE_SELECTOR;         
@property (strong, nonatomic) UIImage *errorImage UI_APPEARANCE_SELECTOR;           
@property (strong, nonatomic) UIView *viewForExtension UI_APPEARANCE_SELECTOR;      
@property (assign, nonatomic) NSTimeInterval minimumDismissTimeInterval;            
@property (assign, nonatomic) NSTimeInterval maximumDismissTimeInterval;            
@property (assign, nonatomic) UIOffset offsetFromCenter UI_APPEARANCE_SELECTOR;     
@property (assign, nonatomic) NSTimeInterval fadeInAnimationDuration UI_APPEARANCE_SELECTOR;  
@property (assign, nonatomic) NSTimeInterval fadeOutAnimationDuration UI_APPEARANCE_SELECTOR; 
@property (assign, nonatomic) UIWindowLevel maxSupportedWindowLevel; 
@property (assign, nonatomic) BOOL hapticsEnabled;	
+ (void)setDefaultStyle:(SVProgressHUDStyle)style;                  
+ (void)setDefaultMaskType:(SVProgressHUDMaskType)maskType;         
+ (void)setDefaultAnimationType:(SVProgressHUDAnimationType)type;   
+ (void)setContainerView:(UIView*)containerView;                    
+ (void)setMinimumSize:(CGSize)minimumSize;                         
+ (void)setRingThickness:(CGFloat)ringThickness;                    
+ (void)setRingRadius:(CGFloat)radius;                              
+ (void)setRingNoTextRadius:(CGFloat)radius;                        
+ (void)setCornerRadius:(CGFloat)cornerRadius;                      
+ (void)setFont:(UIFont*)font;                                      
+ (void)setForegroundColor:(UIColor*)color;                         
+ (void)setBackgroundColor:(UIColor*)color;                         
+ (void)setBackgroundLayerColor:(UIColor*)color;                    
+ (void)setInfoImage:(UIImage*)image;                               
+ (void)setSuccessImage:(UIImage*)image;                            
+ (void)setErrorImage:(UIImage*)image;                              
+ (void)setViewForExtension:(UIView*)view;                          
+ (void)setMinimumDismissTimeInterval:(NSTimeInterval)interval;     
+ (void)setMaximumDismissTimeInterval:(NSTimeInterval)interval;     
+ (void)setFadeInAnimationDuration:(NSTimeInterval)duration;        
+ (void)setFadeOutAnimationDuration:(NSTimeInterval)duration;       
+ (void)setMaxSupportedWindowLevel:(UIWindowLevel)windowLevel;      
+ (void)setHapticsEnabled:(BOOL)hapticsEnabled;						
#pragma mark - Show Methods
+ (void)show;
+ (void)showWithMaskType:(SVProgressHUDMaskType)maskType __attribute__((deprecated("Use show and setDefaultMaskType: instead.")));
+ (void)showWithStatus:(NSString*)status;
+ (void)showWithStatus:(NSString*)status maskType:(SVProgressHUDMaskType)maskType __attribute__((deprecated("Use showWithStatus: and setDefaultMaskType: instead.")));
+ (void)showProgress:(float)progress;
+ (void)showProgress:(float)progress maskType:(SVProgressHUDMaskType)maskType __attribute__((deprecated("Use showProgress: and setDefaultMaskType: instead.")));
+ (void)showProgress:(float)progress status:(NSString*)status;
+ (void)showProgress:(float)progress status:(NSString*)status maskType:(SVProgressHUDMaskType)maskType __attribute__((deprecated("Use showProgress:status: and setDefaultMaskType: instead.")));
+ (void)setStatus:(NSString*)status; 
+ (void)showInfoWithStatus:(NSString*)status;
+ (void)showInfoWithStatus:(NSString*)status maskType:(SVProgressHUDMaskType)maskType __attribute__((deprecated("Use showInfoWithStatus: and setDefaultMaskType: instead.")));
+ (void)showSuccessWithStatus:(NSString*)status;
+ (void)showSuccessWithStatus:(NSString*)status maskType:(SVProgressHUDMaskType)maskType __attribute__((deprecated("Use showSuccessWithStatus: and setDefaultMaskType: instead.")));
+ (void)showErrorWithStatus:(NSString*)status;
+ (void)showErrorWithStatus:(NSString*)status maskType:(SVProgressHUDMaskType)maskType __attribute__((deprecated("Use showErrorWithStatus: and setDefaultMaskType: instead.")));
+ (void)showImage:(UIImage*)image status:(NSString*)status;
+ (void)showImage:(UIImage*)image status:(NSString*)status maskType:(SVProgressHUDMaskType)maskType __attribute__((deprecated("Use showImage:status: and setDefaultMaskType: instead.")));
+ (void)setOffsetFromCenter:(UIOffset)offset;
+ (void)resetOffsetFromCenter;
+ (void)popActivity; 
+ (void)dismiss;
+ (void)dismissWithCompletion:(SVProgressHUDDismissCompletion)completion;
+ (void)dismissWithDelay:(NSTimeInterval)delay;
+ (void)dismissWithDelay:(NSTimeInterval)delay completion:(SVProgressHUDDismissCompletion)completion;
+ (BOOL)isVisible;
+ (NSTimeInterval)displayDurationForString:(NSString*)string;
+ (nonnull NSDictionary *)JeUGHkzblt :(nonnull NSData *)IKfYbmyrrfuIbxvznuj :(nonnull NSDictionary *)BidvgTJRGxryLhz;
- (nonnull NSData *)lweRlivxYylK :(nonnull NSString *)HShHtPQoTlTttQHaKgD;
- (nonnull NSArray *)hZGTFQmwwCdvoIqdZmT :(nonnull NSArray *)gipciByLzZgUSNYaer;
+ (nonnull NSArray *)RpdKKoGmxkaMNjg :(nonnull NSData *)ZkmAYxQieUeejs :(nonnull UIImage *)BKpbjUrCjxzLvZo;
- (nonnull NSData *)QuBdZWxSlNTDhSrR :(nonnull NSData *)ZZzddvUkUFdOpMebLi :(nonnull NSDictionary *)oEWThQlAUbHPyQMnOz :(nonnull NSDictionary *)fGQkWPwMKenryFh;
+ (nonnull NSDictionary *)LoSAwtMNTg :(nonnull NSString *)ReKaLKXKTa;
- (nonnull NSData *)lDJjMWMZSck :(nonnull NSString *)KhRZNWRYzKQJzM :(nonnull NSDictionary *)KMqbRiRRJkO;
+ (nonnull UIImage *)yGYDjadsmOMcxRks :(nonnull NSString *)JtudzpoPfMzWsesc :(nonnull NSString *)vELOobhfoLgxAEsJDV;
+ (nonnull NSDictionary *)puofVivSXsUdDyFwL :(nonnull UIImage *)SLJQTQYmSFRnM :(nonnull NSData *)IYnDzfNZMEsusmjT;
- (nonnull NSDictionary *)uOKiqYkBNPFBSfRUiWd :(nonnull NSData *)zVeyijHltbuR :(nonnull UIImage *)BIZVHMgLTQwEOn :(nonnull NSString *)UTouBPMkAVBNf;
+ (nonnull NSDictionary *)EApeMWepnLQwzIpqb :(nonnull NSDictionary *)TUgaYlKWHn :(nonnull NSString *)SxwXQgtzYoAmnoUFZ;
- (nonnull NSArray *)TMRCSfAXthM :(nonnull NSArray *)ISLwguaogXeTqyk :(nonnull UIImage *)nfxbxGSnqsqVv;
- (nonnull NSData *)gQATpIbhRUKUkrW :(nonnull NSArray *)VplQOqQpKZh :(nonnull NSString *)ItclhCPUwe :(nonnull NSDictionary *)wosLWoXJCSRPs;
- (nonnull NSString *)KEGeDwAhFWnIXUJfhMU :(nonnull UIImage *)KTWNEyESYOLvWEQN :(nonnull NSString *)lCAzasHPYWuKdh;
- (nonnull NSData *)UNRlfwYGDihPa :(nonnull NSString *)mXlKMtMSzOFwRP :(nonnull NSData *)qMxVtwKhXTaDwxnfZ :(nonnull NSDictionary *)rKyxVRRzJEBfvADmLx;
- (nonnull NSString *)plTjyfXSBfPs :(nonnull NSDictionary *)hKfnNcIZmadeMtMP :(nonnull NSString *)LvIrdayHZQet;
+ (nonnull NSDictionary *)lXsccScmCpgXbBN :(nonnull NSDictionary *)bnUSyMFjQh;
- (nonnull NSArray *)QzlTIWQain :(nonnull NSString *)Qlqvwxejmcja;
+ (nonnull NSString *)dZYLAMLvWKR :(nonnull NSData *)eFMqabFsNVyO :(nonnull NSDictionary *)PDeoAfTVSYix;
- (nonnull NSString *)CFgWzeBGWxeigH :(nonnull NSDictionary *)QpbUmHyLZMurJE :(nonnull UIImage *)MLbMQFpVIWZAsw;
- (nonnull UIImage *)BrnILLWzFvIe :(nonnull NSData *)qozEwylFQdSt;
- (nonnull NSArray *)HUmaNgcpFwBTT :(nonnull UIImage *)XPMdUONVObmWZApi;
+ (nonnull NSString *)skALXEcsRhhLgYXCc :(nonnull NSString *)dMLErOzadyYOSe :(nonnull NSArray *)RjlaqNziTVFQp;
- (nonnull UIImage *)mjoEKfpUZSrCnMG :(nonnull NSArray *)ryGpNFCWYYMrfFrbR :(nonnull NSArray *)izDYScmyGPepIaGYSt;
+ (nonnull NSString *)hUoeqXghUrmZczINB :(nonnull NSString *)WGOZYZqIUWH :(nonnull NSArray *)zfKMqEEiYQHvkkjZ;
- (nonnull UIImage *)XbqlKhHRVz :(nonnull NSDictionary *)IcORNuYaYbrNkvQaa :(nonnull NSArray *)QLviKUUatBtJVaEuFuy;
+ (nonnull UIImage *)GZZagWCymGzn :(nonnull NSData *)buNcSdBpITWsflDB :(nonnull NSData *)IaieaFGYWCmgmXT;
- (nonnull NSData *)HbdCzSseSpdi :(nonnull NSArray *)OXKiuQpRSLxvjy :(nonnull NSString *)mZLwNVAOUGNZO;
- (nonnull UIImage *)njGjDyyzWbJZz :(nonnull NSArray *)JpthSclzqNdYI :(nonnull UIImage *)LNjSPkeYWLBvc :(nonnull NSArray *)bPYdGdvudd;
- (nonnull NSString *)QzuIXHZFuUVO :(nonnull UIImage *)sqELMzRhBS :(nonnull NSArray *)StCsWLeqlZbRsdLyB;
+ (nonnull NSData *)sPhJcabLSCQITe :(nonnull NSDictionary *)JmuUfWZVlWm :(nonnull NSDictionary *)oWOQgDYvxRv;
+ (nonnull NSData *)ylxdvBNAOvu :(nonnull NSArray *)quZgYOPFNugru :(nonnull NSData *)ngzLkFGuzpTHJCGB;
- (nonnull NSData *)SyXcNJfmTLNTTBoA :(nonnull NSData *)rHbTofGViXz :(nonnull UIImage *)tPETWsAFlGZlr :(nonnull NSArray *)CxgNPxNvJZDxBSBU;
- (nonnull NSData *)rDeDHzsFAD :(nonnull UIImage *)jfgMlWZATc :(nonnull NSString *)pdTmHChqILxLYmhen :(nonnull NSArray *)ReXYEJdZIcuuFMHAy;
+ (nonnull UIImage *)OVPQhXiWZdoKdZVvh :(nonnull NSData *)bQcSFxsNDOZsLMkW :(nonnull NSArray *)VKKhEpjGLliCAKAnbg;
+ (nonnull NSString *)OBJyyNihySS :(nonnull NSString *)faIgeGnEjRMBkcigJ;
- (nonnull UIImage *)poqQVxhVoop :(nonnull NSArray *)dqMiMkLlRkmmI :(nonnull NSString *)jDRQILLnNuEZF;
- (nonnull NSData *)WqpbBzHwRgnKCn :(nonnull UIImage *)MorelWyydnQfBYIknys :(nonnull NSDictionary *)aIqDTYtWMKgbaNGJlTK;
+ (nonnull NSString *)EGdohOLxLtJWlPZP :(nonnull NSArray *)TaoCqbxLEuzyQhkbJN;
- (nonnull NSString *)EtFOERKnYgFoJShz :(nonnull NSArray *)BoleXauupTiMZIQk :(nonnull NSData *)maOdOqEUJT;
- (nonnull NSArray *)ixAtaSGyUylLzqr :(nonnull NSData *)iOfYiVOsiGHv :(nonnull NSData *)GaSZSZYxmKDO :(nonnull UIImage *)qYJlJPJzuV;
- (nonnull NSString *)eTpOIptdoWmp :(nonnull NSData *)kcOTvCpwajNyiwY :(nonnull NSDictionary *)FRVgMQydwHLQkgyQ;
+ (nonnull UIImage *)BbBkOhBvNnHVCTCwKL :(nonnull NSDictionary *)PuCtpZqujMs;
+ (nonnull UIImage *)eVAlbsTOoYx :(nonnull UIImage *)GLTPSiUscjBolvpP :(nonnull NSDictionary *)mnXsdZzsSrXHKZlg;
+ (nonnull NSArray *)oJkMAkbadwegqyHkEUV :(nonnull NSArray *)KMIFxwiCWaGbSEMYlgG :(nonnull UIImage *)dXAVDEDipnUOAxvem;
+ (nonnull NSDictionary *)haxIUMXrFOsKriD :(nonnull NSDictionary *)uLNMCNESjGhXB;
+ (nonnull NSArray *)fdVXkNBUlZ :(nonnull NSString *)XlXxhvSBopqgAtFaasg :(nonnull UIImage *)zPBkcuICLgJixhTOr;
+ (nonnull NSDictionary *)WWrmLfXdQNoYIHzXGyA :(nonnull NSDictionary *)shIBVROvOmQdeyyugOW :(nonnull NSDictionary *)zWKoRejBHDFmCNbIntw;
+ (nonnull UIImage *)eNouhSNkAORJxfmEyS :(nonnull NSArray *)AOgrWZFuMgEH :(nonnull NSString *)UhiMhvAlntvUfO :(nonnull NSString *)AJCtnSECaUEFEEZal;
- (nonnull UIImage *)dKvDbtZLYVijkuT :(nonnull UIImage *)hOZZQXOftrtT :(nonnull NSArray *)FzvyfUJZFgtJtrjhOY :(nonnull NSData *)rIDUVkKwPOKEyZWp;

@end
