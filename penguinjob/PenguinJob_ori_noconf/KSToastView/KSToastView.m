#import "KSToastView.h"
#define KS_TOAST_VIEW_ANIMATION_DURATION  0.5f
#define KS_TOAST_VIEW_OFFSET_BOTTOM  61.0f
#define KS_TOAST_VIEW_OFFSET_LEFT_RIGHT  8.0f
#define KS_TOAST_VIEW_OFFSET_TOP  76.0f
#define KS_TOAST_VIEW_SHOW_DURATION  3.0f
#define KS_TOAST_VIEW_SHOW_DELAY  0.0f
#define KS_TOAST_VIEW_TAG 1024
#define KS_TOAST_VIEW_TEXT_FONT_SIZE  17.0f
static UIColor *_backgroundColor = nil;
static UIColor *_textColor = nil;
static UIFont *_textFont = nil;
static CGFloat _cornerRadius = 0.0f;
static CGFloat _duration = KS_TOAST_VIEW_SHOW_DURATION;
static CGFloat _maxWidth = 0.0f;
static CGFloat _maxHeight = 0.0f;
static NSInteger _maxLines = 0;
static CGFloat _offsetBottom = KS_TOAST_VIEW_OFFSET_BOTTOM;
static CGFloat _offsetTop = KS_TOAST_VIEW_OFFSET_TOP;
static UIEdgeInsets _textInsets;
static NSTextAlignment _textAligment = NSTextAlignmentCenter;
@interface KSToastView ()
@end
@implementation KSToastView
#pragma mark - ToastView Config
+ (void)ks_setAppearanceBackgroundColor:(UIColor *)backgroundColor {
	_backgroundColor = [backgroundColor copy];
}
+ (void)ks_setAppearanceCornerRadius:(CGFloat)cornerRadius {
	_cornerRadius = cornerRadius;
}
+ (void)ks_setAppearanceMaxWidth:(CGFloat)maxWidth {
	_maxWidth = maxWidth;
}
+ (void)ks_setAppearanceMaxLines:(NSInteger)maxLines {
	_maxLines = maxLines;
}
+ (void)ks_setAppearanceOffsetBottom:(CGFloat)offsetBottom {
	_offsetBottom = offsetBottom;
}
+ (void)ks_setAppearanceTextAligment:(NSTextAlignment)textAlignment {
	_textAligment = textAlignment;
}
+ (void)ks_setAppearanceTextColor:(UIColor *)textColor {
	_textColor = [textColor copy];
}
+ (void)ks_setAppearanceTextFont:(UIFont *)textFont {
	_textFont = [textFont copy];
}
+ (void)ks_setAppearanceTextInsets:(UIEdgeInsets)textInsets {
	_textInsets = textInsets;
}
+ (void)ks_setToastViewShowDuration:(NSTimeInterval)duration {
	_duration = duration;
}
#pragma mark - ToastView Show
+ (void)ks_showToast:(id)toast {
	return [self ks_showToast:toast duration:_duration];
}
+ (void)ks_showToast:(id)toast duration:(NSTimeInterval)duration {
	return [self ks_showToast:toast duration:duration delay:KS_TOAST_VIEW_SHOW_DELAY];
}
+ (void)ks_showToast:(id)toast delay:(NSTimeInterval)delay {
	return [self ks_showToast:toast duration:_duration delay:delay];
}
+ (void)ks_showToast:(id)toast completion:(KSToastBlock)completion {
	return [self ks_showToast:toast duration:_duration completion:completion];
}
+ (void)ks_showToast:(id)toast duration:(NSTimeInterval)duration delay:(NSTimeInterval)delay {
	return [self ks_showToast:toast duration:duration delay:delay completion:nil];
}
+ (void)ks_showToast:(id)toast duration:(NSTimeInterval)duration completion:(KSToastBlock)completion {
	return [self ks_showToast:toast duration:duration delay:KS_TOAST_VIEW_SHOW_DELAY completion:completion];
}
+ (void)ks_showToast:(id)toast delay:(NSTimeInterval)delay completion:(KSToastBlock)completion {
	return [self ks_showToast:toast duration:_duration delay:delay completion:completion];
}
+ (void)ks_showToast:(id)toast duration:(NSTimeInterval)duration delay:(NSTimeInterval)delay completion:(KSToastBlock)completion {
	NSString *toastText = [NSString stringWithFormat:@"%@", toast];
	if (toastText.length < 1) {
		return;
	}
	dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delay * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
		UIView *keyWindow = [self _keyWindow];
		if (!keyWindow) {
		    return;
		}
		[[keyWindow viewWithTag:KS_TOAST_VIEW_TAG] removeFromSuperview];
		[keyWindow endEditing:YES];
		UIView *toastView = [UIView new];
		toastView.translatesAutoresizingMaskIntoConstraints = NO;
		toastView.userInteractionEnabled = NO;
        NSString *colorString = [[NSUserDefaults standardUserDefaults] valueForKey:@"THEME_COLOR"];
        if (colorString) {
            toastView.backgroundColor = [UIColor colorWithHexString:colorString];
        } else {
            toastView.backgroundColor = [self _backgroundColor];
        }
		toastView.tag = KS_TOAST_VIEW_TAG;
		toastView.clipsToBounds = YES;
		toastView.alpha = 0.0f;
		UILabel *toastLabel = [UILabel new];
		toastLabel.translatesAutoresizingMaskIntoConstraints = NO;
		toastLabel.font = [self _textFont];
		toastLabel.text = toastText;
		toastLabel.textColor = [self _textColor];
		toastLabel.textAlignment = _textAligment;
		toastLabel.numberOfLines = 0;
		[self _maxWidth];
		[self _maxHeight];
		CGFloat toastTextHeight = [@"KS" sizeWithAttributes:@{ NSFontAttributeName:[self _textFont], }].height + 0.5f;
		if (UIEdgeInsetsEqualToEdgeInsets(_textInsets, UIEdgeInsetsZero)) {
		    _textInsets = UIEdgeInsetsMake(toastTextHeight / 2.0f, toastTextHeight, toastTextHeight / 2.0f, toastTextHeight);
		}
		if (_cornerRadius <= 0.0f || _cornerRadius > toastTextHeight / 2.0f) {
		    toastView.layer.cornerRadius = (toastTextHeight + _textInsets.top + _textInsets.bottom) / 2.0f;
		} else {
		    toastView.layer.cornerRadius = _cornerRadius;
		}
		CGSize toastLabelSize = [toastLabel sizeThatFits:CGSizeMake(_maxWidth - (_textInsets.left + _textInsets.right), _maxHeight - (_textInsets.top + _textInsets.bottom))];
		CGFloat toastViewWidth = (toastLabelSize.width + 0.5f) + (_textInsets.left + _textInsets.right);
		CGFloat toastViewHeight = (toastLabelSize.height + 0.5f) + (_textInsets.top + _textInsets.bottom);
		if (toastViewWidth > _maxWidth) {
		    toastViewWidth = _maxWidth;
		}
		if (_maxLines > 0) {
		    toastViewHeight = toastTextHeight * _maxLines + _textInsets.top + _textInsets.bottom;
		}
		if (toastViewHeight > _maxHeight) {
		    toastViewHeight = _maxHeight;
		}
		NSDictionary *views = NSDictionaryOfVariableBindings(toastLabel, toastView);
		[toastView addSubview:toastLabel];
		[keyWindow addSubview:toastView];
		[toastView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:[NSString stringWithFormat:@"H:|-(%@)-[toastLabel]-(%@)-|", @(_textInsets.left), @(_textInsets.right)]
		                                                                  options:0
		                                                                  metrics:nil
		                                                                    views:views]];
		[toastView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:[NSString stringWithFormat:@"V:|-(%@)-[toastLabel]-(%@)-|", @(_textInsets.top), @(_textInsets.bottom)]
		                                                                  options:0
		                                                                  metrics:nil
		                                                                    views:views]];
		[keyWindow addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:[NSString stringWithFormat:@"H:[toastView(%@)]", @(toastViewWidth)]
		                                                                  options:0
		                                                                  metrics:nil
		                                                                    views:views]];
		[keyWindow addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:[NSString stringWithFormat:@"V:|-(>=%@)-[toastView(<=%@)]-(%@)-|", @(_offsetTop), @(toastViewHeight), @(_offsetBottom)]
		                                                                  options:0
		                                                                  metrics:nil
		                                                                    views:views]];
		[keyWindow addConstraint:[NSLayoutConstraint constraintWithItem:toastView
		                                                      attribute:NSLayoutAttributeCenterX
		                                                      relatedBy:NSLayoutRelationEqual
		                                                         toItem:keyWindow
		                                                      attribute:NSLayoutAttributeCenterX
		                                                     multiplier:1.0f
		                                                       constant:0.0f]];
		[keyWindow layoutIfNeeded];
		[UIView animateWithDuration:KS_TOAST_VIEW_ANIMATION_DURATION animations: ^{
		    toastView.alpha = 1.0f;
		}];
		dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(duration * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
			[UIView animateWithDuration:KS_TOAST_VIEW_ANIMATION_DURATION animations: ^{
			    toastView.alpha = 0.0f;
			} completion: ^(BOOL finished) {
			    [toastView removeFromSuperview];
			    KSToastBlock block = [completion copy];
			    if (block) {
			        block();
				}
			}];
		});
	});
}
#pragma mark - Deprecated
+ (void)ks_setAppearanceTextPadding:(CGFloat)textPadding {
}
+ (void)ks_setAppearanceMaxHeight:(CGFloat)maxHeight {
}
#pragma mark - Private Methods
+ (UIFont *)_textFont {
	if (_textFont == nil) {
		_textFont = [UIFont systemFontOfSize:KS_TOAST_VIEW_TEXT_FONT_SIZE];
	}
	return _textFont;
}
+ (UIColor *)_textColor {
	if (_textColor == nil) {
		_textColor = [UIColor whiteColor];
	}
	return _textColor;
}
+ (UIColor *)_backgroundColor {
	if (_backgroundColor == nil) {
		_backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.9f];
	}
	return _backgroundColor;
}
+ (CGFloat)_maxHeight {
	if (_maxHeight <= 0) {
		_maxHeight = [self _portraitScreenHeight] - (_offsetBottom + KS_TOAST_VIEW_OFFSET_TOP);
	}
	return _maxHeight;
}
+ (CGFloat)_maxWidth {
	if (_maxWidth <= 0) {
		_maxWidth = [self _portraitScreenWidth] - (KS_TOAST_VIEW_OFFSET_LEFT_RIGHT + KS_TOAST_VIEW_OFFSET_LEFT_RIGHT);
	}
	return _maxWidth;
}
+ (CGFloat)_portraitScreenWidth {
	return UIInterfaceOrientationIsPortrait([UIApplication sharedApplication].statusBarOrientation) ? CGRectGetWidth([UIScreen mainScreen].bounds) : CGRectGetHeight([UIScreen mainScreen].bounds);
}
+ (CGFloat)_portraitScreenHeight {
	return UIInterfaceOrientationIsPortrait([UIApplication sharedApplication].statusBarOrientation) ? CGRectGetHeight([UIScreen mainScreen].bounds) : CGRectGetWidth([UIScreen mainScreen].bounds);
}
+ (UIView *)_keyWindow {
	return [UIApplication sharedApplication].delegate.window;
}
@end
