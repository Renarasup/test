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
@end
