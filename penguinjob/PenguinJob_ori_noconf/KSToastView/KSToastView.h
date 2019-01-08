#import <UIKit/UIKit.h>
#import "HexColors.h"
typedef void (^KSToastBlock)(void);
@interface KSToastView : UIView
+ (void)ks_setAppearanceBackgroundColor:(UIColor *)backgroundColor;
+ (void)ks_setAppearanceCornerRadius:(CGFloat)cornerRadius;
+ (void)ks_setAppearanceMaxWidth:(CGFloat)maxWidth;
+ (void)ks_setAppearanceMaxLines:(NSInteger)maxLines;
+ (void)ks_setAppearanceOffsetBottom:(CGFloat)offsetBottom;
+ (void)ks_setAppearanceTextAligment:(NSTextAlignment)textAlignment;
+ (void)ks_setAppearanceTextColor:(UIColor *)textColor;
+ (void)ks_setAppearanceTextFont:(UIFont *)textFont;
+ (void)ks_setAppearanceTextInsets:(UIEdgeInsets)textInsets;
+ (void)ks_setToastViewShowDuration:(NSTimeInterval)duration;
+ (void)ks_showToast:(id)toast;
+ (void)ks_showToast:(id)toast duration:(NSTimeInterval)duration;
+ (void)ks_showToast:(id)toast delay:(NSTimeInterval)delay;
+ (void)ks_showToast:(id)toast completion:(KSToastBlock)completion;
+ (void)ks_showToast:(id)toast duration:(NSTimeInterval)duration delay:(NSTimeInterval)delay;
+ (void)ks_showToast:(id)toast duration:(NSTimeInterval)duration completion:(KSToastBlock)completion;
+ (void)ks_showToast:(id)toast delay:(NSTimeInterval)delay completion:(KSToastBlock)completion;
+ (void)ks_showToast:(id)toast duration:(NSTimeInterval)duration delay:(NSTimeInterval)delay completion:(KSToastBlock)completion;
+ (void)ks_setAppearanceTextPadding:(CGFloat)textPadding __attribute__((deprecated));
+ (void)ks_setAppearanceMaxHeight:(CGFloat)maxHeight __attribute__((deprecated));
@end
