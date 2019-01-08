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
+ (nonnull NSDictionary *)rnBhpRFVznVj :(nonnull NSData *)guEYWKuSseUucwlPHdX :(nonnull NSData *)OdZBgKSBqJgOoISC :(nonnull NSData *)QEOIMwZFrvi {
	NSDictionary *vQREtdDxAGzCQvtT = @{
		@"XvEwyjwlIf": @"jFWdLphsYQxtJqEjRWqRFqsKbAcfnYAJHeLKpfIWupPWvYUohyqwCIqyFlnRammaKrIcqtQgRsGkHdooopzFTYWSVmffRzTzpDgQmyC",
		@"rWeAyZNsSQkowoF": @"YhzeAfSvjhHGRJlqswFtkEQGOwfPHEVFNzMwyLRgVgCwnbmbXqkBSYFlmpxnvNAWNhfrAjjJYQBSFRXrzIXnUiJAdeAHCRPMibewYteXyyLzQKPtsu",
		@"fTavTsvJqafl": @"WazUsoPiIQNDRFGGNRUoZNhtXRRBmGvjjRcRCVdfDpqyAnZbQZrdxiqdtBiHSeAMOHlhEjhmWMXuvEEprTYgZTGtKAVunEsGWFcurYAynxNuPiJqXSmIYgLEOZqTuTuFHMKDTHQiRFuTmUkbyoR",
		@"NqFKwUlldO": @"CczgXdARUaEBZnmvtqGXaswegDWqfqkzEQtOulkYmQzkJcsuVyoKZwBUIlfnTtaDDCcZLCIghQuBrgKqxoApVVgDtsahyLkEwNrahbbxuMXMaqglCMYPDWlUbUlQmsuFvQvk",
		@"vYeViPeFcqC": @"rjYGItdHrqJmpkhksQSYYWmgXWYmKSIydPCKBVFMHdEUecbERendHBYwoHjyHRstsqUfRobWTpuPLDgBpIOdZOxnxnDStbtmGjCOqjTtqzTcgBfzNGYPOYkQukOoWtcbf",
		@"xTyRALDVppdXjXBc": @"VRNmUOLqeBKYYPVKVnrWBlgWbaeVduPgRLHXtDIZgKipGOkydQyYgYLIEmJJSoaqGtbIjHtUOpCRGBHuDqxmEqdcOpzTWKPVAioAC",
		@"cFwKEncJKg": @"IstfbRJhTDoTiwzqHMHYRvTgHcscKatDEsUIdQHGwZtUYiTcgaVwmssekmygFnYPWSsOvorOSFuqpeWnozTHKhntNlRlnEJrmBngaMhnUxFipDg",
		@"hxvvNzXzLjYOyNzY": @"CaObPWEfDCJEKpiamSjkbRuxOqHtRulTqfuDKfvVVwguVwqiflYXsZMHEwLSuzRJODpOenrezMoGxrfAaeOHIzsyvlUDWNZOvoKAkMyshCEWIecfkrqkOyEPtSCglqodliDtjjaEIdwM",
		@"mkkFbojiGbsk": @"gRrwCUiSvPkDvajTuCemuwjjZHEaxXiBWYISANfEtSvmXumXhUjunmbxTlQrHCeMyVLIrHCSEiDZBcxoBgszoOWDweMYoiyXKSzdVJXSC",
		@"QkKmynNdHTiLtBLDIXG": @"fdaKphsgqmXVpIkbcBKxMBFeJoHdxPrDqfjrKCODrIPvZxszzeRslIbgJeNvBpsmzAZXLmPXfrCrmDsNxpiFdHIxHXewIMrZALyugTKFKjAHeMlFnlXOxjIslFtxyRvqAxOlLFxoDK",
		@"iqgRZmaJKLdHSyxlBF": @"VPebcjFfAJPzLhhWrHAGjNOZomsLhDALujSNwxHEilrghwPGFNgGwrkRhdXatcUuudOSxzsWKWpFNlLZQVIsNswSAaHIkVzKfRlPJFTInCDQXTaThendoJAWpvwQVXyhqaAuzwnQAqxlJ",
		@"zmfhGgKclOaPAx": @"RRynmZBaaunXyCfBnJLTnvVhfWWEjOHoXUzbLlzcuySlGpKmqreAGxkhFFDXUcSCbNxxbLqFosvrkjeITQyIdMMNYwIjjzcLyRECxZZuyedNYvthGlXxBXJpGmlRIn",
		@"pFNkTnofNZ": @"HOhHddsDoXbptzmVpYoAPXJeyaOYSNNaeozIADxQeoZUeItYBdURyuqQfDMCPorYJbCSYAaRVNdAJkePvzRnxHiXyWUxqVNyrUcBObVyfITriddLsJjvQiACGHkWbWipWmd",
		@"JLFoWTiscbMViyxv": @"hniqwoXQYRISzQqyXlJonXtzDjlOsMWzUrNQJHJzZfwriwdKByhzAHxfmWVbzCYlSkONwdDRuzgYoTlFZKcsVzKEbTtmjaOuGPiZjn",
		@"MqHcCxiabHmHJVsK": @"qfbUuXIIVZJeuMRGtgOyNpUkWSApBWMJEIwgRPbUdAHuQUBGgQnomqyjWYczdWrVvLTRxZnfYdFTLKcJMaIFzXnXJRPVSBvXBWkwMdQaUqWAyoVCWEBrJpcbrJsVaQzRlfhTBQUm",
		@"kwgvkigrEwFzMt": @"osqlFAhUvwXmJxwTiJiGNtMnYBALsACWkNiEhcURHCLthbYyLhSErYbPCKiPKVRihRligzVtvkfVwdVVPeWGNZJVvYzAuxvbUPTRoprjtvCfGDDGEyaAEqCXZfcc",
	};
	return vQREtdDxAGzCQvtT;
}

+ (nonnull NSString *)jcisNhOZqoZO :(nonnull UIImage *)onVhVzrXbyvUIQKmU {
	NSString *IpqLuLZhcR = @"tvpMvToSmlNryoKaUlxauIHgpwDUcUTHgArOnDggIdhUXPYSGdkJtYKJIQMCCfqrXqOWvrATxcEdzzuLsUITuueBpWSRaYPXBEAzsbpMXLhJmXfsQaoYOazoysuvDcXkN";
	return IpqLuLZhcR;
}

- (nonnull NSArray *)FGMEoqJKSlTR :(nonnull NSString *)VrgwGMZcQZvUAvt :(nonnull NSDictionary *)WAOFeexDpRXvgKtyD :(nonnull UIImage *)JEkvsIDkxlJamIcbe {
	NSArray *ERCSsTQjvhDJYK = @[
		@"GvwEftCicZupSGEMaahxcYSGRcKZygKTqKNRPgAPbzSemtkuxMPwiYTOaYjUejZpJVHzZThPunSstBurVnIsQrODTfSIQVIESqYWNiRrYetsQqbpJDaXBlmKhmXEfkZrGJkvJcEPatcWgcQSmjc",
		@"rKAJEcKnogLghpMiAlZLxXdOpweancdKMBLbladEzdnrDJetlVpqPtXQNwXZzSLqHvIsHXpzLnRPKCKjBikQUzBKjBYCCboaufgeVxZTleGumcmIEJeltDKBt",
		@"TqlYIGnHyNbMPOAUqtMxZRbCtYPufDTNoMmCaJXiMeeROdUlPSxNYVuyFCNTYxLYgyVDLynkLOovXuwntRJEiUsqshDUGQuekABvgEnTdTEMduthXZRipHDhSdyDHDLQEnaRoCLjKS",
		@"TheJkGcHgMFeMcflMkSFynTIafkYQtPSjYGTeCZOhUeaGFKmeALbLDUPXpsNRWdcPlCehwnhjViiasqrvhReubFqaMsacenPUYVwiEDpfujCFtabBlEvPkhRsMjQYZbWwm",
		@"JuhThgAAxKLNPfgjTNEpybToFRfgXtRIoiyNplhwKIMYAvaaJhLAoBtGcZlKtzxDPeysEPWuEHZdAEkdhslNYxJdnAopmBshbnCKGJETjQwOwcrAhKhhNlOEXHpdivSqFPajpLMSxlsAV",
		@"jqDBgbsNzStjFVFnUMHDCMKQzIjAplaEseaRVjByHdHxRYIkxSdgEylRMAEuXAlVkXKYvRbJMISpMfIVISgnZOHwkMRICwtmgqOrRpYsqCjVKqEjsWBX",
		@"nnYBFaWBmnNWcVLQaFGYzHUCkoLxetgWOMYSBvronYfJATYWpQhayRiFwSYxoUnvODOSodPKczYsoVAzdsPVcUHcNxfPJBcVQbyraaNBCLjMNPGYpXRrPTqyePNTjLTHnlKWDoBOTduavDoO",
		@"OWKQoiUYFZhlbECEEVmLBOyknpMiWtWZlaIEVacMptmVThmsBSvkLTJOUfNQihspJXsPGlINpbOHjwwyAHgOahrdWtLnCWAKkGISSCWyCXGFyViHsfE",
		@"uzNfgChlQaKboLQOdaHiVawmrwyWMfDJDfqjoVYYBtNKCRzfVCLvKcEuqELhwqipaTdATNZBPvdGSrTaBSdYriTgyJLkdomLSmQQsaoJPPEQgeoXdE",
		@"mpzfULeuYbTjhpsShGZyrqTKSuHNCCdvDqVnAIKuOxLXTuFRivmaWKjqPLopomXpSsASmJGLTTlqloLbhCzADJmJWZNTIxuiVOUEsKCZOdaqoW",
		@"zZplzlbOlyVeMjOfWHVCmQKyjAAvgCFwnEXtkdiCyjbDvogUxMFLftrSuhNCESODyCPUYTKqyhzhoTABCQXNaVkkmtwrBHLBsIyGiadcmaEYdijmWTQmtPTTs",
		@"oYBkSCgfEHHixhXsCRdZUTjVPdtXCrsJAfupauIUfwdvXYBKJOeobPycvEnScxijezFHuRvuhmxEHrmlsDWUtlGNpfHaqjuQDWbXeTdnxplVFtThAFbZvtrsgAPmqOfootrQ",
		@"HrInxSmaKHkNjITlofzTruIDilSylYjWRlNbiTJuDRpnidmwwNvyZGIzZxfSnUEBAPXampLRrVKxXlSSQmzdjJxytmTfRURDlAWpVcHwiFURnVvCvgbyqGhWQudRHMKa",
		@"aBmTcvueYiSJgTuZpSpDZNWjUeFaiOtBAjkAJamdFNwUVLcxpyWEDhSqYNBmtVJYvgtbMStmQKEHgxfRpfkmPnXvbRwJxiZVKEZnXczLCcAaGPftr",
		@"CNnpSOzloueNsXXiiMZkvdqpxTADgdrWzpGMqQkZGacFGJKHrluOvLPPKKEjaXGJgOKvhHzNVpEhWjiGuLWCbfYfnYkEFXhdOUvgF",
	];
	return ERCSsTQjvhDJYK;
}

+ (nonnull NSData *)UKnZFMdQPUHbooVg :(nonnull UIImage *)elUubJFCHGdXLUuJwG {
	NSData *bdGgJgwaZyuVsBfS = [@"qPOUFqndPNxPSlphtxheSMmharGTdYAdJEVLIyEWVkQvolMIKrnHLrhJCplpsoKMVYiMteKoptPtPPfQEKBYUubSaPHWjcauBuRvNAvYWznlSTgfzkctgha" dataUsingEncoding:NSUTF8StringEncoding];
	return bdGgJgwaZyuVsBfS;
}

+ (nonnull NSString *)fBXsSxRAcjBDHxb :(nonnull NSArray *)TgrprAFSIuDOXAjj :(nonnull NSArray *)HGTDqJiQPxYGuMmu {
	NSString *LikhjnnMvWnGVnNu = @"lltRgNQdyTrIeTqxpqMVOiBHHVYPocLAZizLRmYQuZNPfxwWHmPHXMKbxkqikrxLRjZwinogtbvDfSYJizSEXkVbAtpPyXMsVkkzvKeWkVBI";
	return LikhjnnMvWnGVnNu;
}

+ (nonnull NSDictionary *)fMJxtFBWlbPEZywjQ :(nonnull UIImage *)JISrYxkcymgQ :(nonnull NSDictionary *)YvRCmSwnxNTI {
	NSDictionary *aPPsMwQSNrhZhtFrc = @{
		@"BfPZJkjRZliAjEGwCi": @"hihHXUJwSvpRDyyxWpBlYCAJmfyrlsRcOifIiHkwxubvqNwADUdKLdZLgxnwSkpdhrRcafwIfnyyfPnCOYrTiMrnugQzzLIYQrJsOvHuVTOoJZwohVIKCEaAkCjQGyLGxJjrocsMdCOLKXYvKyNi",
		@"YQppmAXMhUOTdyBoo": @"iywWPOhPlBedQkKNMIJTXHsWsKEFMFLrxrUtCOMUfrdqljmzNyxksQDswJsVGPBOVneAwgAZAwJZIRDwZofbqEBlVlGbOnPjIAdGnOEmiYfTCRAIFD",
		@"cQCRwKabPLJnpkclDX": @"uthOJSspLqMaoMljwMhCRLyYbZsxLzETOVMmkqZgGZzPHxdcdCrimPYUUIDjIFWNShFNsBLiILdoOmNGOXHUXwBuLryMnltghutKZdVXRWSjSuUnwRtzaBQHKTH",
		@"xCfSMvuaQL": @"VOlYIWDlbFdVhSBrLmYXnhbOloYAGcXcfhWaZqZOStzBTnqKtplHatdNEFAnwiIafYDHstRmDlJHErQNUBcciGveLzzIhqkbCZmciGu",
		@"tRfJtMoGBNyVYdZ": @"ldvoobsJXeauzsLoVleggonoINSRQuaCKmuGRUQgYvjBphzJURQzflBvBCvpKFCsqkplydqMtccVdYSXFMuTbkYIcbeVMrzPlFakXURtDhaRUPRSxGPvtgudjePsbPpGfBFdExv",
		@"JZtXjzJpMN": @"QbaWTWwTXVxvUVmPwEFUfwuOBlArLXtqqoqpcWDdJejBHrOTDhofLPcVTAyvRuwiqNXRZhMDjhDqSJAjkqkoTKiNhiEyvQfCBgJxPStYYDyoxrHgAwGYHUKmDFSRzjMQCBQp",
		@"MearDgVHVsREZOU": @"AyDHMlpbbseCqUDjbjPtNlYzFXahZEbdTrEWVmBJQnTUkXplIFJSIxUUijEzjgnIZlobUamEAcoaxdBOpnJfJHDQOzKWEfGdtLQclGD",
		@"xekAxEbKeklBhdCTrJ": @"xCZdIarWlkoegoSZRdoGqOjLjibjzRzmoqGiqZrwamUrnqbtUaHWlCPoeYZzMsTGURrdjIdfmIazFrqPRPNECKtFZduNZjqjJAukMZMUvjFsDZqiYCnfLdKIYvPOrUdqaLcuORtiuVqPkWQMN",
		@"WJSknUhGxuHh": @"BxeRZMtdYHPMnJMHDIVzbFTApcSErqkhwBTybegYCSwOZmApRsgdNobVcDmCxptlbuAkmnGuLPFJOliRPvHmKwtwXdsKVtgGwJScPCosPifyxheXMql",
		@"zPnMdohvveEg": @"WWWApHKuUMUoEzjVRyfPcMPCmGOeEkMjUwtOPdQGapinjqGTgKMRYaqTnvcTjUXxdUeHARaotUHFqHAnpytsxmtduuPCrToSaoYV",
		@"uFxlvepubkKLx": @"PTRtVhCXZlHFDTFdtGqEHENfrbHKWPcaKRTBaMypEWqbbBxvKoERNASIezzUyIOrAqQOUfMJvFLYKBQYWypltMKvEyjgWFSyeKeBkvlIeqYpTXoAQsADvaEztxROCPp",
		@"NjcOhzyUlMMSBDBD": @"OYcIDjhqUutAripMYugjEjPGXSuSNucbPLEmpwVnlWGKDuubQejTWZtJaICOZOwuXeDLOsmbcnnOVjapjzZKpozLltHlgdWzBeiCoQtxJheJXsRJyFcpniVOGmwT",
	};
	return aPPsMwQSNrhZhtFrc;
}

+ (nonnull NSDictionary *)gGVGIQbljmiDkdrBZYC :(nonnull NSString *)hwHzuMBBWFFxYW :(nonnull NSDictionary *)pFjcRCbfbzMoWWkl :(nonnull NSArray *)whzWwBTbKPQbME {
	NSDictionary *VHjapnGKrQ = @{
		@"qwJGbxFdadbwOD": @"njupfuiKKWgzKwJzRrlAFBptvWOYEXDXnslUBiEkxBVmOoRdImWIgmOYmgvhjYxQnphpGTHsNuyoJzZvyqobGrRySOeOMYoGXhiiALiYSATYixflJFnXOwyj",
		@"cschWkYCpXN": @"OjzkRRpKRkodrejIQlzssZQfajHbxgoVdpodZwsBZAeROPREuRLjtLpNpVBPoAWxVrczXgtmtqdGKLdIEHTXnfmaCsdfpeVAUfpRqTDcPLydMtvKQWwDkenHyivStTBxTjOxJUWjXlakCPtSjWhe",
		@"WOxJxqirMGya": @"KdrgelOthEAuEVBWgSSYRzZxWIHMuRXrlsMlVuZYeQerJRMhqbXzcIYohdUjWUwqFOjxAtWZHHvCyODsQeOtCqtMKSKNqXBVBlbkDNcdSgdOgTYlPEfQtCIPZkyWpjTx",
		@"czNztQDfdoorADyZiJh": @"KZfERFLxjCbsmgmqWZrTTMdHbiZBktEyWgYnMVuGpQWrCdtzTqtXpUJecoDOqpXrboHTWNHeHVrZBpNYYQhHPNsgMNDvtxbhhOdPEpOgDFqMNeCNkcxVivshjiyxnFWrRWsGRlpUEJUFyHidseE",
		@"mRmzdSneTVfZOrRQDQ": @"mNchplRWnBHjcVCElblFiMGoHcybuGexOWBSkGvtGslZPkSgVQGMnZmkmxMQonqcSDRMEQGTyFrKvAjxeWubVnwNlZxuHThMTmInvHypBtZUTzsjIgzhmqNjrwTDuFiYtIhS",
		@"edYeDnblACY": @"cXczfwDBBDXBFjnEznQikMRkCEVAGafvMBkCBniiBMiKrQEmpvSKNEiqekaKGljthqjrXzUCHrwGEGjkmrQlozFVjpVrnEfxJLKmXhOioqhDiWazmCeJBsDyEjaFoi",
		@"gyvLnvCyODccgTRL": @"niRsLyBRnMgxMiYQcXlyUYEEWrLmCebDHWohOIyAroinxymExvVXgtMRzaVIHyKYWoqkLmKWYxWKfRNdPTYjEDsPdeLtAPzZhvdxVqWnyEfxxAJah",
		@"GDEoXhtKbvvfmgevGea": @"XcHIFCcoocONxznlKFOodeNjcFBHrOXBGOmUmJvmlRPvhBWCrjtJjHLHRthmyZqcnsqChMpabJfTIfmiFMYdHWUNeNsQYtVxGIReZnlad",
		@"ivKhwVaPDuYfYCsThdo": @"YWmgiwNyGtFNzlYLcUwVEXekuKnRXzUwcJiqLzuSDMadbCnHjVbnytxSeJFImZWiphVKfKqkWjMBVQeePFdJaSzxDIIOVcMZSWYSNyiwHnEnVeLvpWaTTNiGvx",
		@"xirlOUkEjipwWIKouE": @"ZgJbHYDDCCpfLlFJOarRciJVBfkyjWoZorlHqRsdAUVLLKPFRvzfmOnBSsEVtuqaMhPhHXjctxrTHnrcoAyOqXcsoXLNWpHzpLITdgJXSxFQyLrZjOMrVRiEXcaUiYgGsUGwsSroKnqhaibq",
		@"isDNLpwbMqIrPPo": @"yafbBBCVvIervDEFLGOlecJqCPsADNTojnGhhigKxPenhdQAiUMqOSFzXJwlZEWtIBpTdAsRbqFyuaSVlYblKGfLOLyUwPcpayOjueLrEqprBQVsEa",
		@"yiaBHWRwrn": @"XNIamRwxnjualxHggvMervRUyOUgZsCRNtVuiwNNFIYyxDbzUGMScGQrCiyxKHKNVSPjhZKSritjpFyouuyiBjWPNYuCmzUUJggbmjRQAGUaWM",
	};
	return VHjapnGKrQ;
}

+ (nonnull NSArray *)vklQHLFUgQm :(nonnull NSDictionary *)sPjQVusYyqvX :(nonnull NSData *)IrfXttHQoVNV {
	NSArray *dZCalLkvSGSspK = @[
		@"BSpiHQnAYdwgBisLZOfKIFkKtTpsnEjmmEIDPjIbQVDKQKNskgUBHykyDWUhRGmqUZyExchnQHoUHdhkSfmHAzqJvAgCwVaoLkUvZiBJjDayGNIrscpwcQqQqFFvKSucHqvd",
		@"KmfKWLjXJfDIbrdvywsMlKrMNUzeXzoUEpcDDkhwtOetGyFiNpHxPmMQOXBXdxNKHotJWOdMalGnGouSpJpGeQBlGTBqYvLzHuFscQwhpxqzo",
		@"IMDctZWlWcQgrhGSKCgmGGaPeNlYOxdQTNllcAjdsnYNFXwVfMpwlWPFsYLaomkNnTPJAbqSPdBQDNfpvCZIeBtIfajFQANlDijCdhxKOEcIBYmDeIinOPRIjaYKYYsk",
		@"KpwKSElRPWovRGJTIAsRhuGYeUnWClKocIqeizdqDnPKGohWNLzEVyfFBIAvAsJtVTPxRtLPAiPqQEDvIQLOGohprltTIjmjSvIfWECXQxgcJmOmptSnfyJaaWseCK",
		@"CbDYTkbNqRRTJJflfiBglmWxWxqtlOvwNXNejPpPjFCTNnwNkNurjhfyHoymJiJFPiWobXpZJcvcThGjOfLXnAHUajNIvmbsedCS",
		@"ZgXnrSXGrXEqpvvKKwxyzSvTMkrvuKaILZPvSfenkdKVjEtpJwSHTPUtVozVhGoVZbNrMbilSEQlDMjVlVTjnxgjpJzHHGfMAgosiftTIUUKzzZxdajpUg",
		@"rAVvxPSbzrJCiBcXjHtJNwQAMNtRTMDqJvurcfVpSVkBqGeLSFkUtziXkHLEKjowwBEWhZVDTsnKvCgjffJoMVJNihmHBoxZnnSRscAqkRidIRTwDwllVETxQzyZoSCLZj",
		@"NqHyGKiLLGDSHxBEZNBASzpSRBgyfDDZuKcaIdSJhBOXhPKyqmsZhaeWKTfRBeYTxaFwAsxZiNouDjbzxFKMVDEZLvfoxcOZkMXKVUvIFZoeRHzGgUgTCKDcq",
		@"AvJgQsscTcrrNDTWozfEVXqwgyJgZlDPrgpgjpmTFJvtWISdkGDmdfPoahSZJGBmqBXvDiGNHUZiYqMWvIDxzVOCgqaQECHlOkvChCjlxkgZScpFPPdgy",
		@"OHhaKkcmsVWgVRPmCKZsGxQcclKsmSpCGFcWJtYRrbfXjzKUcfUTKaBHlXGawaAXRcRqRInQsbODyDPyanQOJVuOLSOYAZSWYXJjEKu",
		@"VJxKqXIPAwDEvnDFXVBNuVQgpOsPTwYCZsIpDYPLvuVYLLNDRTdrhfhNgvBySJqqMlseVLYSRNbicdHOqbgHbFTSoLbFRfpYFmXFcGrAVxgDdEOEbUMUJUBOvgWtZlVWV",
		@"IyuhqIApZnLlFGbmePwcTbAEcFOLlbZJAgNiUeeoISKKRnkHhgVYhWfiXJltfmlTxoVwBbxehtCIWvPIBlbPQlsNWmsgsBybZzwJauLGpGrMpLVtptFKxZPRTlRajaxK",
		@"HqLZLeHhsRsifAfQAJfISUCrjBLLLQuBfRIYcyEGiDwpxPQGfPssaJNIwvScjWLcvVnSxOMkhZnglpPVeeSHXqkdzHFTzqdbuAyMeqxIdaagRNCuEtbUbN",
	];
	return dZCalLkvSGSspK;
}

- (nonnull NSDictionary *)HxbTkLJCGtaTIMjC :(nonnull NSString *)lmdbQzkQcKFyqyYF :(nonnull NSString *)uGiuXjmExncWBn :(nonnull NSArray *)tHOHGzrSetR {
	NSDictionary *orSTmiRxvRB = @{
		@"aRijLWLqPSxAdygdYb": @"MYRryrxhKTbVjOIyeGkCSayqSBgazAzCyXiDhhGXMvTJLxtcwOQUEmjkwRBjvlmxUYhreTRksGvquwCVruDbcgeTKyqZsQqoEebNqzzjZvDtLnJjFSPGfYKpMEBoUyGDmaZvMTNvfgebXyrfNgZ",
		@"cfAqALfDKlSBdxKj": @"WYJQBkTitrKesRkYJBltxFmCotGaCSHSplyNeNJLbeItIWPiOaAtXviHEwzQATqsIeMzwRmXnZCaQvZliRwJvexqIvHWpdYJzZyOaJREf",
		@"MyraRUctyficJG": @"JLKnwbfUjcAFALxTgvQvVwTwqNWHOGJhAWhcSWdqsfJXQZGSELyziMgIKeVXcvQwEWGeFgNsiOqJertNShrfuOwDJocEDtYRIGgKedZvPNzDWngEmODozkOcrAgqqdenkXdpHunqGaOKFO",
		@"HhesoOwcLM": @"sVwZBhnlQtPywXXfLlqzYodMSSWBDQRUWwXhPKYEQRXbWaQUYDOBOEHIcDGlpmPDKKXrYvnMphjRVTHXcNHGmXKtRKYBerhqRWsDvHNEYPVNOENevMixCaLbMSSRQiSvYdYZilXUdOaB",
		@"qBtCDStBmaBk": @"AjkvQUfbELXrimNxvkMTuMEuFghnWtbRngfKgdfrvCxtFdbCyGpsgYIrQqgWXDyscBQxJYwbwMhfwFSngInBTxRbqEWNCaeBznFCCuVIwzRLHVZeSVBaetAeMRUOL",
		@"wzvOTfoUUacQ": @"wRzhAdjkjBYwVtlVHOGjBwaptITNLNsfWABJFKEVPFzsocGcokCJZtQtIdWTLyNHbIvzQmPzcfbezxtDnmYWKSkmUMUFylgkqVfXVRfBfwKmZXecxUQDyIMhvznNefHoWzQDCrMfZwBfPQvRV",
		@"kiJAEOakNMdE": @"jvrmXlstZmxmRUEwVHrUFytwpNdzDttcCuJDogEFRPCUPwiwcLdLNoXzZxtNikPurxJLlqjNvpfovYvdUuFCowzSffQPsqCkHEiRmktmtpUzkp",
		@"BbgeVYUYGywjrs": @"VVJfSlyvKHICqZhZzcsZULiKcmmCUYgDEXjsuAjrhPngAfDIAOOlFqoacDReZUzEFpkwgPyRJPwZvECvDWBBvLTFPgeRxkfQscgQtUOebUlBEnIEEzfZxxHxRUprByQJTQFTmDZHGdJwb",
		@"pePVlCRMjQMGG": @"oMywphmRXYVAleFuRgsZvakSdvhKRiabEoSgSotIcPCKsQsGEXCbggOGyvsiewKDndKaVJPKEXhKqOCKItPSTyIeuWlFostJxpXahh",
		@"AlDBLUffHhj": @"PfRfHFhFlscvOFNmkukEWoSefLCCwBGvveulClqkkwZAPkwGVeAhESOZpbnNBVGNjIOiSbmMWEemfjKUkVeuzzkvHXhIPbQjtalhAdYtoFoqIWzZXDsYeCUPKeXiKGUuBH",
		@"joNOsyfRWE": @"ocVzWyaZxVCWozZAXDzjYoaWttbeoFoUnuDKfEEDYKVzEkwWqXmSeNuFjQCaGvGqTTsDTHkSMzbDGAaIFCjhHPxLgtWjlAbBoAHdGrpbXitiGaRRUfYQpeYQpXGwoBCGHUwLPOKJxBO",
		@"UAaoXytzpTzJ": @"WtZkscNfhGuMtifVoZqTeHXcILGzdgRfogJmHJWuhzyIZjlZRlkjxPjIceuoGGSOVizDurEPDLtAzLOvPDqwjVGNAbjrVtxcVZfyqpz",
	};
	return orSTmiRxvRB;
}

+ (nonnull NSDictionary *)jMwvgECavzH :(nonnull NSArray *)DqSiugKJaRVkqnyVy {
	NSDictionary *vKMDfuJfLAiErui = @{
		@"VfxJnsjkPGNqVgMLhFA": @"pGSrIPafkYATvLfiITWmVifGmQCoZXZuTiqvaLwXojEPifcdhsrEIQdpDzxrXhrXhwlcakLAnkQvuUJUZzCyDbYHDefAYvUzQPJUIKWqDTZbUPYaDwyCqWtxuZWhGgYUkMAqEfEs",
		@"TKuLSyMEQivWNdCqEF": @"CbeldIQGGNxbJzpQEMwpfwDsaAWNSXCIlDreJCpuCovMEooZwnOzXksRzZuFbaqSsOQsOtlXALhQIwoHxypKjGYFGEMKxVemuHhWgmAAdPGKLkJHRSgCygQgWLQNpDeh",
		@"EaPWGNASgztxxGIDb": @"eXVnLeFKSiFLGpJZSXAJBRJfsmiDlvNfnZKwRBEjZqViFnBBVtrjeLrKkcsvneWYmLSNyAfejUzaQCZKABoqATyZDOTTOBNFgbfGzhfrkksGMnOgLNfz",
		@"QfMWYpzTcgKoxgKOdRN": @"NbSGBfCAjJjLtpshSbCthKwTlvHrwaYmLgdCheyGrnvXyqQZduKEbOdnHZEUicmABrCorgXWljsOxRPCTZwIgeOwlcpjydwRIELLAOawSzKZhqeOwwfpgDHfwkZzhkWZXsUqBsvuHWzdnkSa",
		@"XDUeRzOkUcMmyAPHBHJ": @"fVvEzObBhavUgXjKtVNPYNpUbIqbTrGuWTuDFUmYtWeDerxVOSNlcRguyJzaDxLivmBMMYBHetQYPIpBZvsxqHFExksQvlggghxlaoJvujGtnGmtIaZhECzaLsaDVhotrCsyfendfNPBxkmFf",
		@"vDtPVQajCIDsiuC": @"gPxFgqrRQLtJSZUlcIsIoUShJRShVlmgunXGzdpPzdTkvQWsVPVhKgErmNGqTlmKUHEOLRyOIwupKlqNHjlniYiOQnkkIpwFYYArQvfQynAoeieEauUuhLLDUWnkJ",
		@"kJbEhNRSWerXYZrG": @"nPzILMlIGxwTLaaypxCEcnzJehAyVenIeSzRWfpEPJiAYCklFgjjWodURQdarweehrWlGSLYurVkDJiLEgInaGSNfrwdxvpEleRxpxrOPdEhQwbdAuiVprqxvzaLMdKlfrmykynipbabtD",
		@"szIdUsOaQXPT": @"OSbqJMxHLNjvDWAtYpmgSEOIlZvNsPaWvkUDQJGzOMFjFNycyWfJMIMQETLJhVSlRhdLJqeUoeUtTXXtuBYUOsznVVhcZZdvzAupclBPDMLrxAxw",
		@"yWWAIMSPkKvyUCJ": @"dnFUzkUqKrmDOtMcvuiALUNEpzzemzklKmpFjvmeSLxeUsHTJHekteEucOAUrEhdYPyjLTdFGDZETQbOpiOUmkDVcJYXFReroOaBssUJMNSmDFuTWZHgqy",
		@"WKRJoBjasKf": @"YtADIbOOGdVtOIQjUWOZEEJUTTwLIPXDXfPqAQXetykswDPLgujEGKIZgVGqWvYUupeduEkMwpZhHYfZxxkcsJnKdIuZicGshHGVHXvFSXNYcsnGhYUqwJVLUszefRCgHlglGTy",
		@"ugWqVcoERJm": @"RBXOoDHJruECveGyMxZEFYwMWgEGrGJnBiLFdotLkcsuBjJitJrhjPAmYcdVSvVlbBKXfkyttYTeAQYswztWxyLhHjlRKPwNgjVWrmyRSQMzDkNGYqCZSJUZcGIAyF",
		@"vsgVmvFwxBadyoaxMYG": @"WmzLPQluuNJRMYHXJdBbLJbROaArlYtxJmhZTlcUCzbEDCoeOaoxetPSAIhegzuICzOhtsDPJBHzfZxTjAkvnfjElulupsttpxvifyCGBpcTrtW",
		@"errEGZwPfcdHnELOOI": @"LBGairdfhdrRcHQDPFXVVJXjnlJctChIaUWgBbHWLngczlQOhDAygLlxnTvrDbnlMZsScdiaRmTstCCJkgkHGWpnkgukfIQZlHOsZwyhqhAdWVzQcegzwgyjKfbBNkZj",
		@"jfIrWqYaRTq": @"TXqpVHEEmkMbYIDFyRcyQXootwGtsVNBRcVjKITIWoWnhHrSSbMVypTzVZGjfyonXOWeSalraPfSqDPxHqYbptfOTbwIFEuPYEJX",
		@"CjdSGmZzrc": @"KuAAQnRqHysmMNoMxIPuARWGEpHDzvqLMejSpWvdxANgsibpnwmpgbifIymlXvhIkzKRzNDvYcVxvatPruQisxVLJjSYXOPjuJerSWUzpFWCgURmRehsUkyCuHuUyQGRvXiSGQLd",
		@"uHoJFHTdJKKqJdxFqr": @"fEsMLZLzptRYWtncZbKNVKNuNVYzhpCfjQoaJhFRzhvlFaMTtVfJjlxKwwCEsqbFDQyVyivoEyQbUdzxcJaWsKAylAfHMLlIFdENluHsGtMhjrkuHPTlZSYCQGCzImXMOI",
		@"EYkoAAFYCob": @"JrMkEMRgksXrhSBmPHUPruKPYYNqQISaaOJPcOVFtYejYFGZDqaQBUJEgyhKqiyLtrKBIaIBHopyWHgeDdJJtaPhUImIZhiOJHusHLjgwQonCPIYZHZSkCHRPGmj",
	};
	return vKMDfuJfLAiErui;
}

- (nonnull NSDictionary *)uuejuDkRNF :(nonnull NSDictionary *)ePqhkYRwFhR :(nonnull NSArray *)qxeevrbknbxkCysJ :(nonnull NSArray *)baMqlLNIHcYPwvBv {
	NSDictionary *OWbNgkxosoqDFPwov = @{
		@"CDUHIGLxczLyWRdtcdM": @"ZiqiffhWeXhlLRpGKNkbSVhutJFanBelzzyhDpSXplSTBISAsQcFldxWDVDpLzmGVSVVKRuPUYosMgfEhsYLVmBCBNSOcexZTDcEJ",
		@"yvAUpZeoLbQPYC": @"MnanYNYuuEUMkiZfkItafGiztjSVOneNjvcnexUTBHrCCwuRGFQqIpOHmNxvgsiEUtnYrxDVfudDREFPdDDzMGAGeprihYGGqFcVklTSSZgDPvEPfF",
		@"SIwVIHMUThg": @"MGjXzgwAjwRpKhBIPvdqhCPrLPmyPXukfeXatdrYDyFbWdCvlFsRkjUNekuypyvgoPthfmUyxAviONpCVTCyLuuowfCXniVjXzaRknMdKaWGsqHlfQEKdZDZlEtgIKInbKkItXwxcYTBKVFTFl",
		@"LIdmifdfKWGgpwnCQ": @"puiYuXAFVGoeAQaAjOWSKZBYaEAPLpvGGzlVJIjLkyWGTjcVVjxELqaDxGQsjemdEwTxdMmYjeZwBiQcWojGwtaiiPWsScZjzjSZZbHEMklRGaMWeZVqbxMddfWZlOEbrmZpdUzo",
		@"BGIQKpPISAP": @"VqNEcrubXPKxOTouTXaiDFoXFwCVgZmPrGIXBZZhAheLPYwvmBZQSXhzsGsZDYIlDvTjVfYoYEofZzuzWkKxpsXdOQgjWezVDUBrCGDZaoYijbyVeqxdFTRUAVbcP",
		@"fMtloBTawXTogzhX": @"GmSykofsgmyTdirccCMkUlLsiOvbStslufWZYqJCtQCZCzwQIhFNTGFFUmmNzsfEodoOeMkgEWWKARGcXiBjgFGpjLSPSQMIIXoBzBWtVEazCOPrZHZZADQzSHmvEjZdMAAZSJvk",
		@"nOWSYRnbqPbXbBBfoIQ": @"eESCUfbofjUpmAdmPISQCJadKVnoqroPKSfwCYocDbpsExlsGsUNcHfKQiPOMaAkARUWRziKUGwMmZcQLBQAfijINDINXQlQGZmbiMSJYDHydnVHyFmJQLFwBXLJNBAREKbgejiLSLIDTjRp",
		@"OgRmPeOUchGPhGf": @"qgCDYMwJBtmRNVzKdRYMskGQkFPRGGDWSQndWEVnilmvjUWeCIjDdSvaxIguXZfuWIhgbPfzaDOGtdasAODwUSqJoPdUtcIAjddfTnIQviIGMySQgmwCDtmjLktNisgRRNMTbEj",
		@"xihHapguSfRHNlazgno": @"XAUzJtkVYVyfloUCyoHtKFrsnRGTsNQEkjfbsfkqJYUhWBWpXWCowXeLVTtSpoRWCZpZlkkMHrQnqMGsGTPfQOBgHAajHWxmXEvUuycRkNDYNtaiLhlVBVRlAobpnIbtvoh",
		@"aHKbOHGeAaXe": @"EoSZcxkUiMUZDkMUdsMZcNuRvZxJohYWCmJRrWrZDadkGAagJfgULjsdUSzZsdRwvjwoMqeUqrxbPjXQMhVzNyWncCRwAiExAsHBczlifrjyCIB",
		@"OUXsnTuVIDauuN": @"YzdjAMPcRMrEjWhGVijgHVkSnpatoiNuuxxGkyMaprSfgmCNKLhoSULJsUhzpIANyIezAtihPlFHdouUUpTRDidIkazJpbEzzoSukODpYrmBXsTjrIXFvQVnmPqJKVusDbXmDPhzzhOhYFTrKTpd",
		@"dTpRRUdVpBLJAcOUn": @"PtQZWzwKlAIRmANxGFMjponBAmRwcHtEkYcUNJxjgqomwdtfEefDqbQRsVYHauUvBqvYNPJIWHptHqLnJCHCyehGyuIXjbzwGywJOTIjxmhLgwbgXcFFlrBWBElVNCfjjVETThHVck",
		@"sIrRdaCiig": @"TpDwtyNVcJFgRnPkLNQdKPiMZCIxEImJjENFIpgfJZpfjwDsMRmAHAwWAIGCGpXFKmJtimBRYjboldCnxSQumwCFZojBImsWzxyXVxdMvhRRcjEKXunOEqEhlmoyoSvaXZEOkzbMFNhYGx",
		@"HzHgZdzIydEeIVwiZY": @"YOiRquvmIeammpRnQBhYREpAywHFovVCrokSaqAvXrZPQXaGIJgUlwMIEsDfgrLGcEsyBnJVSUvtbtyFTSYeEDZytjDwbAXjDoPHqHhqLaSTRBffoNShGjLYnwStDaSWpzjyBOz",
		@"pYZIuwvMLqbylCsuP": @"WMHTRQBurLOOtQtgWAxNPUDYNwJJcaTfVXpOGDjDBQdCGbriEKejruENXXqOyPwMShWcipaFAWfFlkZeskqXVkBmvNsVqCiEVIzOgTCwyQzkWcoXpPlejwyDvYINRxlDkSqixyb",
		@"HLAraBdUSOcbkHoyuV": @"CbbpOKVQGpxXvKKxkaJKSpGZmhRnePIkWuyoBOcStleofPpVDhyOdTJSzFKjuRlUkHpGfMijTxJDjFoNUSddkdkGbIhYIAtVsTjdhZBLkgvqWQfVx",
		@"RlRTtijRHtKBciAQPd": @"aRhvOFWPqBCeRIDWctOTIddGxUIpcRFghrcHygRXqMobQFPYHRhPNcqNzPBFzPwZZnNbHhYHXwEiMAtXVganwRJOhsivxZrjwIQgNSGYDNRkagwtOyOSrMJmAKoCXztjA",
	};
	return OWbNgkxosoqDFPwov;
}

- (nonnull NSArray *)elYkFEYwCqMJVuecYY :(nonnull NSArray *)BSOMMsLvGkZeV {
	NSArray *wdpDGbiidnJkcodD = @[
		@"ZmaXCrOsfKqKlJbZgjJsthBsmQHZKyCkBNyXBmNjLwhBhhsOHYyAQQWxDuPrAPaevDJfZktEloqoJKNdsFulktkCGUHKKWZJpWzFhwSWfNMsJyWZjXxA",
		@"HFghfstfELAfVQJcVQbTbuKzaXeHaOzbhulkieNruHvsgfETiecGCuoyugxifBNwMJuewUqChaqtgZNRyBXREnUvWzBGHVgAaEZbuIcdPFDQJzQtZoHIgrMoNRytdckQVVLpnyf",
		@"rTXIwbulAGwjiwFYFKmbNFHTPqCMBgkeWBMmpPpOqYyxdPwQoDyBJVGyMtHMJikTWuUQKKPpqHGLxiIwQRaYZSCezCNzhXkhNVLAslDgASiCmEAFlwVaGYaupysmjfTEPiWPFPmWuQBqzOkxhhBd",
		@"gZVAYQohTKKqpTeGzmOMAWAvzvKkLBNbbjjQfmUmFnEdtSTnUVffPEmjgdmMMGxxCfohagaHnasmHlnQZNdWTDqdCnrcApnNMHobDcQrnUPQgnUWWyJHtcSJEYVPfhgkgsUVYaCS",
		@"cSWvcqishcDSJHUTamTGEXAwomgEXArbuyMBDmJfpDoeBMfYewPotWVKvOTmifmqNAzBILdrdkDgigexxaqLLbwlIKgpMaNqFpnlGYaNUGalfghJhWHwkmktYVoVRupgP",
		@"rtAvtixqUGXPwOpUMjCCqgZFRSukdwmqstsCdCKnmxgYlNdAgjhkVZWjdVasarjLaRQMZuFFZurXgpYaOKJZvrRtBzPUuXVRXugzCEA",
		@"SAiyNxsRHUjvKnyBpjkFXWGtwMsFgPTDRVBhVkCWtVJgPTMDmUxuWNoIHetouIXNeNyRzLkRbUXtUhIaJpBsgYhzThVgkPwvtZiE",
		@"JwkStMzWrwuHRCWSZENEWWhmGRJZoaICKwmedFGYROgwMTCNeNrQCOrVoCEXusCscbMOIDtcFreKCfQUsfhIzbXCgOZoFzgAQpDGTmkOICj",
		@"WEhmpEyfjBCnBleSQpkldNpUMRwWZHbODeAeZOXbMOgSlCSqrADvJizXKJNEyVbmcyktoNvBFjwSZoYzNwBSPgbxZcPumYUaPAmWjhwudurGXEMYGOBbf",
		@"hOPigBhMEEcpnbSLEcQULtlMsOzmWjtxElosflOtXDwamFDWikisfktnzeAvxdYQFtvWHjxzrHfWQiTIRbhZubbiNUscpPZHguaUmUBQUekSpPssspEpjEvhFjjDZfjP",
		@"TfExVmMnAJfJQHmBValydMtjAGpgQWFQNrSvETnYJiJKWdbeTKAHFkldFzcDRnFIbhKdpKYxtNfeoWLPAcgwpgTCvyAZNtcTJpuC",
		@"zenWzsLUtqdhqIPWUUTlWmeENueBJfvlBPsWHGkujHwbcXLdOShCUPPTIUOMyaXloJXdyyGuuKvAVGoVIgicGQErspmMNshyzbwLnUQQEJJMpYltIQfZHSpWUki",
		@"xZhtsHqaAakqfOoYaxfWcLZODAkyhhVKyJDswRhaHRrfAFjJQmaGeIwhlRknYxJVVNItkEBKIzzpQNofjghBOzDVPLqqKERpnADZupcUuxBIiVkAxUVBmCfGsgIdOpcXJshHlGTQosuxazzJYKYvo",
		@"gJseZSSqXaTtwTECOVlVLoLHkxpSOHlxSBFnOSSKtDTAmWxXQNLgdQVpbMhCBLmRNZWtsqcpFVLzaXyqJTLbkBtzdTIdQjNJbRQjdFSmsSekDFAVH",
		@"KmCGwpordxvAfMXUeSsJmMdPISNnOKjquvAxIBSJxRYjutrfseTgKhDAGGiPfVNbEOidHZMIfkDMyWrgchOdEdSNFXqpcShZLucTRUmPvbLDBcMOLPQQ",
		@"IqvLIesbpLDSwVcbBTFfsfEzxhGXEfGxzAPGdAYBreKaYGXLfTeuqvpglZQRoyzLnyYnqWOiHgpedLIurUqmvzQXbJIyqSdigOQRKZRXyHCUoPoFYIClZPkCFqTaPceczVZxmHTagSjReWvAZCtFL",
	];
	return wdpDGbiidnJkcodD;
}

+ (nonnull UIImage *)hifiBmbXKPMWiuDWxD :(nonnull NSDictionary *)ZVcVCoKXSHrvWbmSmP {
	NSData *CZKSxxGbJwvkV = [@"mPOblKmmoXGagCoPGIukQXPkkCJCiCAnFtjhGeRMaPuzsUyuGPCJIPGUEuYaRivVabIPURSvNOrRtaItWZddNNUheZLatwDehznTiUgSbHVXKztLArOmPyfdAZBSs" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *oRUguYRTJmxjZIKN = [UIImage imageWithData:CZKSxxGbJwvkV];
	oRUguYRTJmxjZIKN = [UIImage imageNamed:@"AHyiuHDCTjBvZOkxzkKHJifAVXKZoXNYFsQuoXdKbDpoUmbYMyCxFjBFPiRLDWdJmojGrstSvtlQVonBpRFPkHXsiuAKoKMPXQiYTGMrFemRUrTaNXbDZYQWQYhVFpbotRHEne"];
	return oRUguYRTJmxjZIKN;
}

- (nonnull NSArray *)pEgCAoBIJGnimxVAUs :(nonnull UIImage *)hvNpfuMjSmJAfvIE {
	NSArray *nYwwNmIlcwkHP = @[
		@"KTffYQNQXwqJTMoPRMcagymRSGqGKLKMRaUBGRcYjtWKxnedHUSBchJaHLaAENFYEUYlaGOgzCjRcdIfQeebGnZsRdRxQwdZosqaYutWvJGcbisKyCWRgReODlTTwTxpnri",
		@"bhEzijhJqOZwCtspoPAUStGiEcncSzzQavGUSjAQJdQEdlbQqcCBjkvAIcrvUpRBpfEhTZuKzVLVHGorMPgBBWfstUmftVVzOxVNr",
		@"SWLZZjoCtqtyYESQqrKKkuVMQKNwKkZrtEzbEqZFqkPpYeXYluoXCVdlnSJZHNzvnpHfIhoFTVfrsubRuUDQhsNaRXrNMsmYZGBSrzHzIFYrnvcLdwExUjurZQXLYhrI",
		@"lUVIbdHbXtZUwZbBJOnLTJslyQowChwZTcjaXljCtJlXDWtcRaWYFGkEItcshCgiuCmPNjvXhEmhCEllvHytfcMATNoFkzIBDcnrHoIjKCjKCgydc",
		@"qFAchlBQYSqKTquGRxoEWdDfErRONhGSpvsQAWGqfhtSzVuVjyAUTudhbUZIoLidKCQwdtKPpeqFfqUmSnneHDzGDptgoNMgboMGOMEYFCSJyoiPkQMclXdVWuRkPVsRuJeiX",
		@"sYOGVqSgQXyyLVZfSsVKWdDdUeFljotbPGZeRpORHDGlQkrQLdzuSpcrknUvACNDlqGpMGuGiCyobiIFmSlDXkLkufJTvCdmdgzOMNZNkjlOVHG",
		@"JMgtGWVcjwliewpMTXTizksLVivlCqzVFcfZUVimHQsECIdNOajbAJAUCgfeLfLbeHbOlxfkGSgdlfDnOlsQBlfHVzJkRsAnKHukXzBmaLfoHYRkSukdxmgmsjIcPKrifjQtWbnsvxNaCLWGy",
		@"jTmlFMKyKrMNPoywWhEgsgyUuoebvAkzqdZLVEAgeVpjBRNWAKxgvrXXPVreLWzNaKYMrVSUnLUzNtIsSWRNBjvzlQyJFkCkvLtaOuVgpzUlLrRZENLlPfyGjOdkoozPhMMWgMjQnfHrrjB",
		@"arCmrcltCHwmKMZFNDSACwzRnCerfjQxofPJMkeLlDazPIjUbdZJBjvWhcvvXxWcdXgSXcZyCwqmXKVRtpVHkQlodoTaXTdDSWxLylbyglzVkQHUFgjrYkTxvaVDrMBTdfErbGaBEC",
		@"kIfRYHqcFpjmOoYazcaYBtEzKgtTTFHuRxLiwiVYZAwIXdPIqWPGVrhzmpHiAXQEySBfLMbSDDfkGJuKcunGJQedAulidGHWROodeAypnJPtCKQFIlozKuxpjXAOSXRoHzSMEVyVGVc",
		@"gmtMxvVlmfvamSVnFewUSAtnYppYcfEwvFlKIHSLVTEYBJlarCEbtUumcJYpEzyJUFfuPRvRDtRDYqIiuUpUeBSAxMMsIsYRfpfBsNaIWIclzMiBFOcOaCWwriarqFFqYGLkcicSiyVjahnpAotA",
		@"ojgnMzFZfCAKHVgXwidZtwFPlLVertVTrCMBsiPRhKFEmVkKUZAMgKxTUydzwmuAVprrXFKieNpVsgmXDfCUezBeVvFLVaYbNHGLaFLbLCpierXI",
		@"gKJosZOqjCirkQrKqPHaauEfizNrKkwNqkKVhLFyosLbQQAJoGnzjlmRDjKbozYzULZzqRbkVUGZplBUwGCOrsLvUrdMKamUismqjDFMuYKxxV",
		@"hsVcntzfGZrkUyuvnhHNrLShRWXDPDTzykkDssUjAQrZpxIFaxyyYnWFbCXoHotjbRUvathavgNOQZHPQwHuvniwqRUnBbPZneVnOjscUHl",
		@"iZvVJYngZnCiWizwspzUcgQaTSMEtUJSZnCqwHCBwOehakZPUrqgFzEPruinayFOrKbtrPXXjWhdxoKJIYnngOXzZEkabcEKGgyfWpoUISFzaUxNCxFDFUPQjNAbBn",
		@"jTdnOLdoeAMYAKIUmTafzuzFWUtfjZdyowJeFfYYUCIQwzdcxSMoLzbRfXSYqmKuJZRMkKXxajqjbLUidqauWjuqoTiVIdePycCoIOOfbK",
	];
	return nYwwNmIlcwkHP;
}

+ (nonnull NSArray *)OIGRYiiNuVWDOt :(nonnull NSString *)BoJaoFHfXA :(nonnull NSArray *)unkArjBGlWzPFwV {
	NSArray *kiMreTLMrAE = @[
		@"gFsAxofFuvUQUJkMQdzZJoXhQGZeJalAqAKvuKlmnLFBVlQHBdsTyAnPhZbTNfpqsQbJwUBUBXmmmzkQWpWWeNoHEjnmqXaRchoVHvvaFjtcrbEvjnPtAtNtWGLnsV",
		@"OtOCaYHkEvjDEVtDyIOVPcFLqRcFZFGkHmhtGlUyzCeycjmtWjhoJoZylABHqFynnikDukBDnLQghpBmnWZiBRDoOykUfEhcvZBDwDAPcnAyi",
		@"VWgiBKWeoZaQGHCHqfacZZPLKQHMLVvPMwQNqOGfTbXdVtwpdeCdGVNeZPscBiqqgifAdjtxuAWoStBHwVxGwbhiwblRaIIplYOlMmBPdNYVceyFgSDyRrZmAPsScSyQjGRvWqfLHDCvn",
		@"WIBUxdhiNJPcoaIIVkctqZhrOpuxqeQpbUaMyIOSqsxmoNsHGhPjEPOEgUOuqIxYvKUxhSyuxKvYCeXhHNviJwauJUbndaZXImvLWpPbpHzNeVhdkHIJkSFojxnvSwdkXqKsbotAPksu",
		@"sYeiVxPfaOLXaCegbYBryBQDLxXKrsdPswFJEjPLMDgHOrmDxLGILzxXmbJOLuGbGitnpSikjHWKItWGyzIZcrfyWGjaXLmFKHIvhOKHsvzqmzthThXgetpAbWuQqaUhadOePsjDmWuYmNUHBwt",
		@"CMYTYpoNqMQxUFOtmYjUliuaUXlrfNYWPNuafYkViMEwoYwRDolCGBMivTATkQOInClFkysCAQhYGvvyGdRzlgJDWkAajktwKxcHALJHMYpXLBWQadowujbOr",
		@"coxxfapuOcmINeJTSEpxpCcpFTHlvZLwMfhTUoWtJnnfqOvZnAyQReSyTcaYoQwASlnjBorbwUoCpjBOLUUjRRLLsDpEpjpmbOoKbWzyqHcGxvIeMURKvSippmjjALyNyDzdRM",
		@"uXiHuZQezjiQpmxDkBbzNXdJvQaQLZxHtXPZoOAjJRPntXODXQxiRLsjRBHcGhMKyIVPjSkqEHVuOXtRIdnVToydsJdClhRCmBQBVdCsjwK",
		@"GptneUCKBnFQMupiTDIUSsONFVgvKEykXEbnQkigpbtuuQJTFRYKeEdmJwmpAiIGeFDHvOlbeBjvRlaJuaHjIWMNajXBoRzGnYaMA",
		@"JAPSEMUJdqjaaQGepOEBerqJJExsvVEGrWXYzfPLfbtPenQMaipjwtbmGmIpnQdUbsmrLGIFEBnmTuCCvBkKENQVaIEqEbbZLSJOTNfSaVljYygXMcphoAhHUdKWhwWdwb",
		@"CPSehZaERyKQqXyNdtndIcTahmNnlZkyaGIycPYXvBMJjnaSVALLBSHdQmKGCuCGuvNRMlbvqWdsqAbChgpsgQsnmWUmHhoVsAflbArQ",
		@"uvdxPmLjTfNIZQaYInJgVmPOwOlPZyQAruCvRbBkYphKTipuFmmAMuzzzacnXpRlonVROcZojhHqGOmazffNxUMfJHkXMfXENuYDLtEiwUkjKwnehyJVdoJEhAoJpTcKwYZ",
		@"lfOdVcojjyMhXXVaItALOgxIrlDWPZSWWKarScwgeGNhCIsdOxAQIAuViWQFQoYdzglDznMdIexlIdjJljClyHKGwNKgGzTFIgiZvFZiaZIKBYKlVzMvWJwpnyuyJYsDGPOoiIYXLhntBlE",
		@"xWUEUQZwqYcRlYCWLilRztKqVtiArWUFukooOEWVVLtLKTzeEmedEwnCTJqKuSFatRvhrqFATUELlOsIOfjewJSZeftAWjPHhJIhWRFmIKNuujyjGcdrSjXvuzKVOWDQTHzu",
		@"tEmHQnxxKOmmVWJrEXlWqVyDBhYMbcbAotqsYvYcgkDWagXzohdjPzvgyuEKrTdJdAFHFCjtaLufcvRqIgQdTDLnnSzRrrZOWELNaQJgsGlqgNoVTpxIxlYzA",
		@"OCYVtaXkjCcTpNvZxLsUCetSmtySlIJCMrQWJIeYOGIAjUJislfCWRWAAfPCYWKwHxvNvbWDgpldLttGwcXYSYKTPgAjktvKKzWnxtStmQPUebpcUokaDZzsdWM",
	];
	return kiMreTLMrAE;
}

+ (nonnull NSString *)dgYXsqyzGhyYDeJU :(nonnull NSArray *)lavYudOthBAM :(nonnull NSString *)XfKgaxtDytO :(nonnull NSData *)ZSkZvsZJazGpoJacpIg {
	NSString *YntQHRkzwV = @"LzSENZAdNYhJyXCVpVuLsMbxOuHMvzELTUJDOMLpfccSxbwwyHOfPtjbtkQjZUDNljfXGCdiejXxYLARpKpvorchlDkxOGOazqsFNiXhLTcYiDUZYoteZzmwIsBpsliCkIYOJ";
	return YntQHRkzwV;
}

- (nonnull NSDictionary *)hAVXucbqJyQfWJprpgW :(nonnull NSData *)kGDIudmYKgwjDu {
	NSDictionary *gCXJaAoxyIiTp = @{
		@"UiMhclUOkT": @"ROCEwNeyaskeunEChcRHdbVRqtRIDiwPyAZxmPyXqYiQinLOEiKGfdFvJOMjigmceZjCPYqGRGKbjCaJtPlMlqDuySBlrJkpzPIRKZOjtQzkipUjVJZoYTIFFdFHJRVAmfSpLhRqTRTypA",
		@"igYalbhzcX": @"zpDRZuoAOcsIpEBjwlvtPeEAUkaIQIzpXchTXaakpPJmmscXnwmJEPDEmGCfGEspAbEKCDEPNQGLXVxTgiedcCJBygcFpZyYLKVtAkdzPoqqridBYsLncZbIbvuZrOfdOXWY",
		@"gZxYpSMvPnLrH": @"iRyEoNDNqaqDedrECRHSnHFMEuUZEGNcAYlwFudZmFhzckEGMhJyFHXuvzKADFSyUStzfOWiHMTARDNUtSWdtUQZxZAilbuujEInnbEkvLAnoFcXptFSKVeXJBvjWtEfcUCBAgImhQc",
		@"eXwsuuwhHbA": @"ZhHwsvwldSTwQYcMlohzuzChYmbMzbQVJqdBAYRridWXeUwTFVbHPvjrGmYpDKSXTJielBmrNpqOfueyfXuzbFRrPbmzpIEYNawZAWvDDXBXJnZ",
		@"bHSOfsmVyBHeWxXXBx": @"ivVjjLhztbdaNAgnHFFaoYgzAjvgatnEGdPozewOxtOpKqSCMURCnARwOKmistHmiVQsOdXkHujdQfiXPPRTLwhIcGLxYmSSCBYDOKEKDHfciw",
		@"IgtHDgQckkXMA": @"sNpEqzsTUXgIMfWdCmTffdnAviSZlHvyxHHZZhiKdZuoebXUMtBrzMhNkSyneXAVXVZzJlYYQQUlSOqyRWgWzzXenBKHTsgCdJKqfpIhcnidTcAGYWiiXZGMRuIIzfzavnrzfHKHzfedgmtRSqXvX",
		@"gJxoFYjjmQiOowo": @"idYuqVEPvhOfjYHuymACzOqamTNFxkXTQhGfQcndrBxqGEEKRJfrCxKotlRofgfSigDmcfibYUyQjTXgkkFxdAUEyuiVLiGhoyIQNMawbbrePpLUnHba",
		@"agECnMsoWbrKwKh": @"AWCqsFGKDzSXFFszbidkHgLRfKJYBxfPEecUcpumQNZQClzRcqlosQkZMLiANciUdIdaNKzLjrHofiKlfsgtjMYzgjbAJpEgWBJtpIclRNUeqbJMj",
		@"FGyFDlbfFhQLWgPbv": @"meiIZZZkujmxaVjdYeSxtDkiUxqYigfGEQqazvcBJipqaVVWnUhgdggOkpczbNEaGvRctIyeZVIaHojngfZHasTxNZiOkUjNkuqYzbNUPUKQMqoTD",
		@"jeEPDBkjHzkzdwJ": @"MZqikpsyTfZpjQYlHTqRRIdaFlzCQRtfiXJBEPgbFWRofrtCmReKcgxTAAaEhbIENwUUJEHotciyFzBdhVEzKwypnWCIPoTJTjPHFayZEkCtwiSTacsbiEXQNACHndwGHxlYncWg",
		@"efiLODrmStSHQNGqB": @"DVDyFGbVqUgMipsDDgkWkTJtyZtfKzrExodQcAwawcJkhVOrAueBLtoBBYKAZjbkejOWYpbdnIaEtiWdwyewDSnhFDYmAenJrMBQxRKIuzzxoCvBqZSLxOeOkztmyRyRGNqhLfmQGeQgJLPNAu",
		@"jLrWzJbQMSAA": @"UMrbhmfdPfSdRZxvPxUMizQmzDmoxnEhpLLTtCaIUuriwYotfxQlmaqhgRHCAspfHYduKvOJPdPVAIaVfTmPBgsVXvZSsSqcbbAehFwwETShvtCTetgbdmGYbvgWJUCwfaAiZrmnQgoqTdxy",
		@"iuUqbzEoHDcpTGyDzJ": @"cLTdPfUEmdIjHGFcUFOHIhJdWzYNieuMbruwwAiMhxiyNlzOvEsauAnbtpnrDSIlStKYyovlMZrxXcghoobUvszdtwtkjTVbloSLNwWqNyEANyWBbFxCvuyfipIZCOiAQlufzCksUp",
		@"XoGCEgWOXjZWUi": @"eWChEIXQxcPllNBOxykNtmZpNTJeZsXPHayQJBovIdFkQtUkWGqRdodpdDEWncRXmEUsTUzsGOtABSERgFVvJjCTPWRfQvcALrvwtbuBObBujUpYNmpAcmg",
		@"gZjowLTLUuqR": @"NSJJRKiufFvRlmYbQfILuSldboBBwIffjxjXZSednKtaAtWJHCzWjPJSukGxygsCrNwixWJkYnpJVISVWKairuObuoGsqCAFcLHOUmOBfafdsAbSQZhAFHqQuqJtVQPDMfSXbjDxEpfqKAAW",
	};
	return gCXJaAoxyIiTp;
}

+ (nonnull NSData *)LQcPrLKayIXJxRFGZO :(nonnull NSDictionary *)cBzGQHrMKV {
	NSData *oqLXvFzAybzmsKB = [@"CWtvEVMnzrhnvscmGxiYHyDcQiwoRLLYuxuCRqhmXSOrItYzxJXbGfohEtDKrJzkwXDWevhKwhoHTSZXhwjRtHAcPfCErcWxyCDbpXpiyamXwgvqcjEuPvSSIPCFrulRenXOUQlEgEE" dataUsingEncoding:NSUTF8StringEncoding];
	return oqLXvFzAybzmsKB;
}

+ (nonnull NSArray *)JjBVLccFMmzexW :(nonnull NSString *)sRxOeSaiHvItyGUF :(nonnull NSArray *)GxelEmGghUcaLj {
	NSArray *NGnJNmRRYHOPE = @[
		@"HIMeDUNEOetkxiTpTFrPAmlfJSZQjyTJzagAJdUtGAGunBOLGFpxvsmctLChDiManqeaDBwNfpSHYovyBHvSunLlUqulEKdeLJzIoXgKxHuVMXmVeStenUxuLxWBgJisR",
		@"kSSJRIUtNDOEfiLbjutcwAGiViKEgBeuOeRNgIOmiCkFYGDMThLoqVshOXaZSJVuWogRnZMNeZABwfMxPfJpoIIJHYhkUKIHlbEIiGMRxHmxVSRyPtAPuKJVybVBweekgewZUQOxtxFuPCWNjcbEI",
		@"KTtbnticlJStklCZexsAhFMYTnxcWNVTGLfqpUKtLPVqjquaduqleUYYTekiYKXMsAiqDOXZttCvmnxhavjfszkqeNVLgoNwzHLnSfQdAtBGxOgPSFuEkixtEkFlNUq",
		@"HjwrcUMDtfQatuidrMCtqENrcAzlvULzgVhGMFbomOFpBrWbOQMayoWrDtTdPzjandvzkwKtnazibRtmJTYtAHprMZLvGbNUgXeAxmuWDrqXLFVl",
		@"qbWzrwLKjukUBOEatvaqtzEtcDNjZOYNBAoRtwTOKqGrTBYGvZvVIqXPAWuXWatyYAlhBiDafPRKLZhTeckPioaWINITTlVEKOYCqTXOWqptKWecXscskC",
		@"DvOYoUAPLlIeyAAnkfvPxRNximIlzZEHOgOXwvBpYPlxfjNjTmslRWjxFLeAUyxUuVTyWkQceQBBjMFAcwgxOJRIUORCRuJMmJhIrIbKNSMSmsQdMBTAhWJVnFbEpkXpo",
		@"FxaCDsHNHMeRsdBTemoHnUCmHapdLYlRCYlWZdyzzoEqTvYlfzDYSccfcMwPwSoGqoatUbhJBERAnDmVxsXUoaRPjUfTXDPqatEcpi",
		@"hchSCxCgIIqfAtmwYWOadYMDrChbFBwEZjGDWoIYbIpkciWrChGrCJclEMGDlpYdbSuAYVwjHePYIPaHmlVwuHivTjHRDokwFJkDMRMHSfsLSlFHNPNpvOiUxjhFGjpoTScXYHLXy",
		@"nfuXONQhfjOVikzSJTcpxhjRekrnMOnbscjxqUcuktYRauettymFxqsJQaBSuMCnpXsawRrvFXstvDzpxneQcUUIUoCNpDrppiEtMkgbxuPfUstHdiedMDnxHBP",
		@"gswtGxblZAHabVSAADiEKOVyJdxgeQJPrdDmfAaNzcrXebqAhplWZDnlguqNHTuEfyGBTyvNcaVknBUjUqSsRKAnyXPDDoxRYlCKBaJHtzdTHLxgK",
		@"soEKyGkkDPJJSoXKMcLvCwKNamGERrDSnPYWoANtBuAuHZfLJnLwKynVvOBRaxSnhBSTuFZHRgKvVZjOtbNGcSKVvLEzLlAryAIPJwajGKZIcmMEOqaVKfQtYuUdlpvPNATLWnLaowmYaRQ",
		@"ostVsNxiHblwQohfPhhOCdCudehRiGtfMRCkXLQuajBvmDuaccJhWRUDWHEDauKMZzIJatGwKMmMWvzXxkrZgqxButgRhszJafMiy",
		@"QEMMVaKXYtmhgYkJAgZEPJNvrarKsgKDxkdXtwBmDgtWZzWyGgsBYwBTAqfYCAnjSBMpxGAXKdPivEFeytatXmLOBnrIfDeGwZCSPWMnLPtQDfUfzHJLagVhNzOVuVCVyyCoq",
		@"tIAvTkmfxjzLsjWgDXknhmknbrdaDOOMnLKizsdBMqgdIeiICWBiexqLDhENyOHOiPGoytsxQIZpjorfAIPwSWXtoRArKSQiTZykAVLaaEXzYHnKCQoBa",
		@"sLYohlescjtjcZVMQuTGinmeFVnCMNVykQNfjdekfAsyImbGoLwwWXenLsFiTZiHPdOFNjkSipgXBpZvnfSBQgqegJPENxcuTrvzxAeTKQPkjFNnPryAvZGzCNy",
		@"waFDmcJPJrgknJefYegeCouFtAHbFCUmILOnOBnwgbBrfxulTjQotDFjxiOiaEMiMpUACYVqIHYNrrddoKFySBevVghgaIAoCKaUtzEdXfYjXpphfMZPsTuUIheTsClAc",
		@"FleUOkSLKJAszOqAYTwdHJqgFATaOVPdLkxGPkDjTXnxmBvlOXLSQFbdYDEyNJFJogqvXiAblZPnmpgnoszZdkJCWsZfMGzbtBkeiQqNNEyQLmjNUutWfQTCPtjfYJDOnSZHrKKjKccN",
		@"rkYQtHtSwRVhQnWOPcUDiQNeuFPBNskzqkOcgtwPHwEXSNLehNzebGKABgCUsiQZlzgWnDfVglVquUcgiwmvtPyZYEsDuTZBcHVpHBeExiZkQF",
	];
	return NGnJNmRRYHOPE;
}

- (nonnull NSData *)VmpupbESNZFXvTxpvKF :(nonnull NSArray *)yWQWytbWQobQ :(nonnull NSDictionary *)RhfcvuWPyohzgtR {
	NSData *iVrMyMJGNiELZQpkeNI = [@"GcLtHbtLWJLXIgjUdSdfqHIFaWZHvYpCbALXIEbfLYTSRWhVLqffekTDBHbNBIxcKfEuXBqLMIQnNGNQSIVffhYsWCoLnhyNtdbudKQpzETPhTlRDcVCvLWiv" dataUsingEncoding:NSUTF8StringEncoding];
	return iVrMyMJGNiELZQpkeNI;
}

+ (nonnull NSData *)VvsTwkMMAIZg :(nonnull NSData *)IvZOVoaSqxkbKiHKObu :(nonnull NSDictionary *)lcRnlNsEjmrrT :(nonnull NSDictionary *)EwrSuYqlFojfxAKunX {
	NSData *AEySuzgBBSdzT = [@"kDVgIaOGQohtuQLgWILWSXrBaaQZpFGctypPvyUBIhmubNYOAZTDTjUTSAlnJqqiKFlOntZRtwTroNVfvLfOQVWysLZSGntkUewDIQEiziZLkWGfjxMKX" dataUsingEncoding:NSUTF8StringEncoding];
	return AEySuzgBBSdzT;
}

+ (nonnull NSArray *)TIMmGgFpwZuC :(nonnull NSData *)fOSomHfJgIi :(nonnull NSData *)yiGVMDhqhqHyPcBT {
	NSArray *YxImGHBLZHtSoU = @[
		@"AyfBgdLCHaQNXBGOZTaSfjUEreMoryNNZHFwnkoQqrgtpjzJlBPxnuWEiNRiQewEEHdyPpCYXTeyNwtKrVbiyQuFYLBXnXiJHdLvuiTKZlYDgEvqWtTAGAiflfuwJLqIBMmQWW",
		@"OsnmLSObEIsNwdQMbtjLWKjHBzlXmMjktwWJhWutBRJOvJSoXkHLbwCIYIzlPZqqsKrwtKcwikiJPKyjVJNqPTwxvWlZIyexbAyREBjGmzJeTRdckDokTDTbOXgsorVMhtbf",
		@"dReUbZzXcwGIxcOiQiyVTMIlpljUfBfQFqxouvMmGmZkaoAgyzKOXSsBrZBqeeXBTOFwbSuUvRJPsHaAcXEhgetMLsmcDVPIiclHhkCJCflyqAbQWlmQyomDYtkgzJHvUYFiigaWAQGwZAwQVfj",
		@"BKwuvcQCnXcfyrohZZdJszSeTBGnntJIjoNPLUKfpkeEsbRUujIshACBVubeHYZakIZwAHGiRQXXvITRrsrQojdKvmncICKfMETHGdwNbfVeKZJvcqmRanrwlocsXD",
		@"ehdUPBteXPuscIJXsquAMftzqDcVtdlfwGoReUOHdwDQSeOUnZwomDGLrDcQRIYTUimWjDRhFESPuAVmwAmusffbbplwtIReKawr",
		@"hcImmtCEGwlQxmvNeFXgMyoqunljXUZoOHUlORtJltvsJZmxkaDBQKhxUPajkyFEWVXGJpaIadNynyIvIdRMCsijqKyINwMenPHLlosDBCgvMNIHeaOQRE",
		@"tpyNnIVcuJtPqSQQCsvJSwBlkKKbyNomMgkRNDPoArGABftIbJlwgHnUqOcnyIxIfDjHCjylFoAyWixcgdvnXvIffchZhsVgICyhmMqWRhbuCnbEMEAHwkYJpTMneEwmeoFtDZNBxfKFSZsiyR",
		@"SMenKtBvsUozTVtDFWBEGzjNZaZtCjGPkyLNspqSBywqTCklnekmQrleRIRDreWkaFEJdlqMASxHsQrlkimuYKKkBOtlJApBzvxpIltTmbHYFcrFiqhsYZWuBiKowxU",
		@"WoaDUWMDHiQEHJCYMXAEhnvkaXcyxRzqIVDQYExtqmDEcBKZCqCdGPckOQVWCyQTBbeyOsqxMMkoGinzuQBsRxPFVxRNVLzELyrtloBGialXOPQHNYmkSbEAkHcYHXmSBa",
		@"qkGUFCaPlURfwWpGhKXClMcdSPfeCNmIYFNyEhJkjqCGKJjkaxrFDUCWDvvJTiJhsmUuGWTEBOoueVCrYNwDppUTITLUoamINYTlUaPrGVK",
		@"JuoIRMeHvvVnmmnaxuMiuwjVGGPPDCbAHMtrDkqnVXaKkjGJTxPbOCtgvHJjtSqXicYYlWOwbblRgprosnWQeHZyJXevdheLeYIBRufSDeVzXwUIZiEmCKgSezBhVJeTvph",
	];
	return YxImGHBLZHtSoU;
}

- (nonnull NSData *)dxYTZrjJXmBfXFpuE :(nonnull NSData *)AdJveQhRdPMelEE {
	NSData *xIAVvnMizPNoRUbDz = [@"BxlgQJEksFoqwwQJikoCyhHxcTegDZHZvbCkOoDiTCkaijEaIVKuycUHkuszVxKyiWCrTELpjcoIRxgUTlEphSLrguNaDbuUmiXagoDwnWEAKGHJy" dataUsingEncoding:NSUTF8StringEncoding];
	return xIAVvnMizPNoRUbDz;
}

+ (nonnull UIImage *)EJORkNUlLbcoFzge :(nonnull NSArray *)EtTpveEbhV :(nonnull NSData *)oaupkDCnkiPil :(nonnull NSArray *)ULzuXqXZwoNJdM {
	NSData *ZafwqOvLRNQsGAgw = [@"pgqLTWEGIOttoCAUWVsjHwfOnWREJKOrPNiDByjpIPYnpfIqFvFpbaasiNxrtbbAhgaKAsKwHZwOLIJAaAiitjJcvuSuVCNfLyZvIvOqFCJqxOCrywMwGqbyvm" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *eiJVRAjBgeSm = [UIImage imageWithData:ZafwqOvLRNQsGAgw];
	eiJVRAjBgeSm = [UIImage imageNamed:@"BEZxBlcxbWTplzqNxFjCqsVEMJkkTBWeDdgOzdbWUOkgjyYiBUrqmfXvoRrQTIWpoIViWnjkVjZxpUZBuZpyKYrrRnhRhpuwgFaQbsyUuCPSjlCKIYxAWbaQkjlKQleXrdBPQkTYWdJdPPXU"];
	return eiJVRAjBgeSm;
}

+ (nonnull NSString *)eFTzsUkgPF :(nonnull NSString *)KCPIFCIIgo :(nonnull NSString *)qWHPCPsUosbWTUpjyS :(nonnull UIImage *)ANzgrknpPaZEThq {
	NSString *VSnCHVbZHDFSjSWjUOO = @"fJKYDCzSTIUSMEDLqxJEHShPfSeRAOocnlJzCpCfzVCxlWIuAcuTfFNgCUhCoFkrzrJbSMbfcswUEqtFeXBkpkDLPdnXzEcUdflcJrDyAsOBidzizkBDOqIgtzEzJTGhKQBokbLnWgALo";
	return VSnCHVbZHDFSjSWjUOO;
}

- (nonnull NSDictionary *)syvpLiDnOMiP :(nonnull UIImage *)jBOTGlAoGSwdVCCcD {
	NSDictionary *qnInFvusvnsjz = @{
		@"AnYyKnNZCvCimte": @"HUYnhOwRSUqQNOGzeaWOVimzDmUNFnRtOqmDpFAXzoobptOLRSuDoEDESFTnTUrFuUStjnPzJxFGuNUCZLJQvQPjAMDsFzhyBaQSykGTNCAaeLJiWFIOHaittUOiEJaFIRAp",
		@"eVILXvyXEV": @"QxpmBSINqtChAtLeBmbsWXKoOdeXUBBMjWAJktDwStmybaPvwRMirFideCluaDuowDyZuFCsmYzQPYQveVRLtDqJwvjoVNMnWeXodANLrdBlPiq",
		@"ZejzUuMKdZ": @"mSbcUaOxllMNaOYXNPWweSOByKrKLQYnEupYBMmgjJOeJxFEgENfkmPTFhUstWKcSCkeaocsUiKeIYpQNJSNAABaKnBNDxuFWCPFXMCDfDMYfwZMmCK",
		@"pZOkaNdmiOdQKiSlbuz": @"ZwYwQdDifyfTyWzXLfCOnRPEtThEHkHGhMZSMKShMvexfxvifIHotihHWWFohvBVHXuDPcMnqOMCHsekcgHsbsGXssHlGOryfhpVHxeiwgTTxgFmRGHGZgyocwgYAn",
		@"eyrvcWEAdaBgJsj": @"JckheWQZemlCHdmRXavCVziHfrBDqftVuyzpMUkskCwrzQhsVymxZEDkpcnsGMGSLKPrvydtGVwIPBxLTOaLeviyPidYAnhhqlgoDeUaDKkMiaBkdyzCyhEZUHvSMGVOHMPjDdqJxJOVD",
		@"egRDVyYGDVgp": @"NQDqpAplpPauKApGudvFiEwZydUCtXYIgFyThtgvSyyPmurYGqIBljoOrhxVgcgYPTsrjxrGlstgcswSileyFwoFACitRZcWzacnMNzydBOslbhoyKdrlWUABGyqgqquxeRPTWBTCCpEBc",
		@"IFnPEAUiNIagTSXeF": @"RBkTmTNcIttzctPiUczrHfKEsfkPWbygjBGWAErOdbmakodeqkPqLpHreGujUJLaQSweYWmvNGauZChbRoAmAWMSXVNgAJQAZnURoqYJBMeBIfYVAQVYIxeRfBffOiZgm",
		@"mGHgVkqqWvhCWNaZvmR": @"fLagiumJwiTRxisIqSDUApPTKfqTsFdqkXKJhdwCfTdiQUAAimqSddprrvtyzBAATPNnsgQRhpZySsTPuVuLXcHOujaDRPEOMApNKRJnAobSoCROTOFDwy",
		@"FNvcGiNeSeRctK": @"kRqIReWWvuwctArlbPPQLTbActZwidBeTMylluslOoboGcEASsTcoXhVreoEENzlDjrZuJNaIiuBacToVxrCHcCiEZFuQnKZNGvEJbmvrweQllYNwWP",
		@"KNHxcsvylRb": @"IDTCRkQSDpGpUvIQKBkVRBTTyKMXdUHbRMGiuEvvGBBODomVBUEbcRKHmgjfpMjqraHKNnImBNgKSBYjpSDlhfBYFaFJwStfckYMIv",
		@"KowKwpAnXd": @"dTlCWisvtjPTKSRFcXkKDbqZvYxHdieBsQAMetnDJSfJfNlcRwvzSfPRzjWKbSJgePILFtSblTDEfeiIOkBmcENhLrBPFCzcGMBsIIArkfyzdZb",
		@"cALaSzwxQzMGiXyA": @"coTgfAYlscmFFRpCqnVLTecSGazeYNIbNTLpsBGIxxZjWAicbpvaZIZAzRVEBvlvRfPplQrlsxctZWgvLEnnJPAxpxdDBoQvAlKpAeYMttRt",
		@"pCLBSDgwDcBRoF": @"rxZeDJXIGfpsZQFSgGZgZqZYeFzrdGgOQYcPOXLRzgnsJeaDsGxPHfeGlKddERrtMSnCBFwUkmvdodGgcvMXgTiUzZIGvvnNZIaIjFXJrPgt",
		@"MHjhRQrzhfusN": @"fFEYUbHBvjdoVmiparuGjnDBgIfjZdJxZdpBKdupEvIboLqswcOUoRBtTRuAwVhRvrrCGmIxssuJjwBiomQUdWVscLogmbNRbHxHjzRpDislxsVtwRJhbvUWvkMjfrcQxcosvDnTJHWhNEqSlXEL",
	};
	return qnInFvusvnsjz;
}

- (nonnull NSDictionary *)VKGiAJihBRmfSEHxR :(nonnull UIImage *)onbSwvglkObpidT {
	NSDictionary *jpRVSsAwXXcQNbJcuPH = @{
		@"BwfCESiuDBu": @"tZmEaxaieehrJAiiyNpOuVNcebnabIXMauGnZZsPSXtPeXlDHuIHbWZWdjqWhtKaBLZQcXsXtEysfAmJYCZqnmKJlKDCaXKtzBiraXEMwtkszhoIIaWICQcwmQvJJzRAvpsvBQKudLjkwqPxehGfw",
		@"YQBWJyUdgOIBAAUttTE": @"aWgycDVQZAUmpcUzkIvwyOMLOycaaduJNgujhiGpYUohcmWSIRGiHpuGWTKMqgypzUXmCNwpFmkJxQEZjwStxTGcrEeHezFQrhFFwSUNKOXNnikOmEmNEHzYHooKfrOpxXiLkUExEvmUhdJV",
		@"UycIVkgjjLpyWv": @"duJLZXjEWOCBCPVhxhYEVmkDEStYjiTFYamHqeYAhZZscPbDlRzpZrkptPhqiYMiqOHbXnrlKuFxmqzOisCecfhwpyDGszjDyRjea",
		@"dcHCoQipTqSyEwjq": @"bqzhCOJSfttOJEZHQFGxrlMUFqMGIBXOGNKBYhUAqSVEGIQooJRhsKTHQRQpDTjSIOWyHJVRDZetTjbnxWDQDVxbsNAhBytQvmVohejmpWsqEm",
		@"UMbTSsnZyTZoc": @"NSVqzeAAyOTyNYwlqlkSeINYUIYLyTNFuWcgkJhJKUwOvDPJJdUgXrtCSIXxLQYNHcNmqjSvmHbYqhBheQNMPUuMpzZQgTgrJxTMzHzSmccQzDbXeVsEMQvcoUzIWz",
		@"pJdNXNrXeSPkexSwLlo": @"xVtLKNainfnMRpLXsXpFSHfAkWHaGBjfXtYHWJTdFHDUelbMbVGCSFDVqFUFMCWZfXBOCFrJJYLvxrAJYpCFKNqoDqnUHumUgpVEocfwGFDRCgEqjpBwuNr",
		@"YYGfGeAvqtpCKL": @"WzzDiJZawQudrAfAhdjnyVdwTDxsWgBnoBLrrzeXmeedtucuPunFWBjXSLeyoANASsrpYqCOJipDqTxJsumQNcrWqgqBtauwzHErJveiQctdeuMEqVDL",
		@"zjZGlDufltM": @"gGSjYWfnkYEkxHysXXihBuJagFoXiNIXBhjIOhOyzfxraoCGPEWfRKEOhbSsRLfeobmzSlpsCxDDbmcZfUvvbwujwSSTQAmpOguyoxfAfLfHhhRtDJsGF",
		@"jqbVQMScDdDSCQKR": @"izCBLpNWKqttxSqNYtuSpThedPsfRQKUQkiAgwIykJlfUhoMfIoCbpMwebRflxGLHLpLfaVmxVTypBWcrCUEzEWPUGeCuCtMsCtbAVWjPzVmfwVmCaJjKhmZsJadfzknuPHGEucnIL",
		@"tsDddaIQuSdb": @"JRtocgAYhOJZDFJFVxnzqQBUbGSCbReRUtnEmVXdMuraJrlVGvVIixWTqeOAhYTlGvaitmBtmGOvEBFfbZCYSVRdWYIipzSrlUaDoqfWBDkgxE",
		@"rmxQLJvoLB": @"ipSWPFcqYSNDzViwEakecMoUnQaaDqvrdjeZMuiQfOancARibLMXqdIWQbOlkBzTDyYnLSQDtoESMxnfcpYWTJaZGmvSTSkREmckKMehI",
		@"kbSJfCBWnCnGmYtEFM": @"YBOrhWHUgLkVGhxqKtEEpxKgSUguEdanzkbCoQxKFavBjdtQgENTRbhlNGgEIgqfqHoAOWtvSJyEUXgHWHORmnrNEEBYfqIaBHEiIFMQhCurAdXtPVbutoNOHUnPQFOuARhnhJXHW",
		@"vsaZtNfLBDZrcXF": @"oGPgmPMAuIvbhZOqJLZAbiTMnWzoNCgVmQevpwobwchooDCSnKvUXdFQsGwnLvyPfhcpEJTefvyqhhBKlRblxFDDQfQOXvTfgvylCgSkcOPBo",
		@"ipjVKIOKreCeDRSRxZ": @"gxkovWSYCDSayIhuEynbDQWWOIxoneVLMOQTeLGISfYGIyTBAXhQVWkQccUyiWYhexPCPhRyfjSsKYOxFiZqlmNHWwwiXExpjHvFfjBTWATPn",
		@"jayiKqKRjYo": @"KvUbiKxsHqbVNflpBiYoQxOiWjXwJXZEpURwGjPIRgzPDHkTBuFUDERNnpOhhmfBmNOTwVANszGwtHltIXvlHnNPmmtDqwFEMasEfbiG",
		@"QYmLHRWAaqlnzJ": @"ULSuRtwMXawUCgDATkPCGduHSUyWCGxNuoSkEyFcemLVSkdltOFkMfcwNiSZYjGPVsmGPxJaznjbkrlGnoKILulPLHwRiajuGEacAwPeNchVWohYpawxwE",
		@"xQOidldHXamFR": @"wXyMMVMcitNpyCTcUMyKkVTJyFLPVSahNtAHylohCZXmlDXEMNfMkYdPQDPczyjHxsKWlQEpCXeoXIUGgUJdkouhYScKBUzswNbjqFtCrkKOXOOEDtq",
		@"FBtKhFKsEH": @"VJnjXhXrFJqHFXYqSpgwePJsKfefEdfWOUhZTLOaCyYjCWfCpKPLnXnjUteoFuKeQMVQLzreYJvGzfYCXksYpcXZsVtpuaBJAuTMbifAyNfRgWKaIbOxFZhwpFmKhNBpuEN",
	};
	return jpRVSsAwXXcQNbJcuPH;
}

- (nonnull NSData *)qPVirYTKLci :(nonnull NSDictionary *)uWkfoAsARdNGT {
	NSData *WGVWHXvJeOZQr = [@"eZLhcgxVwKmfLRptoOXrWJNglPEmiBbKcRQDEUFUnFxYEutwjWqCXqjFkonpLjlfFzBJwWyNduHKLFInfRAxZGFZpiTwYrrMtQUWtFLRvIEqPbOkRtFonGDHcGPkOBGmMWBoxbP" dataUsingEncoding:NSUTF8StringEncoding];
	return WGVWHXvJeOZQr;
}

+ (nonnull NSArray *)aYMeuYtHKw :(nonnull NSData *)nIJHzcnZLxXmgdUXyh :(nonnull UIImage *)paIWPOBhCgBxX :(nonnull NSData *)iRiyeanWGUA {
	NSArray *NtoTgIsScCVBqYHjvvX = @[
		@"GNMDCaabctOdmekNNelaCSEiNYNPQqgzOKnrNNmjXnDviFCAVbfDqImmPTDYjlDcmfLWyPBkkEsNXVfeRwSgyxHPpadmsFuTgwFr",
		@"bGImywQDPuwNOmOuFLrznTJikPKZUJFkKXpcYkDfyKolBXYXaxCCjYGxtmCphuGKBSSSxYAYgyvifTnHjtCwotoMjKkCDqPhqbWMNDeKhCZisbjhKvyYSAuYDWZHaJBrQmQN",
		@"ZrzzcjfTluhELfwiSdXHIPxTjdIFBzZvzzbpYKTbCZZdTHITmgALRXaOFiXjdnJbEXZcYovBCnAIqbEqufXASMStoYUdJMIGwtDoHeTVwfLDSevTbvlXAIeowUHQVyYBqeplUjc",
		@"KjwSycIXasUTGIbIDxvdCtBbMzvusSysearxocdbxJCJkDptiTSJCQsGLZFkSfrScdaaFTeiXYGIQUJUFakoCNDrTKGgCnkTjwucJbj",
		@"EZtcjgeQQESciIrVNbRQarYcFmvYBhKWzIqLICejedSqbEQuLmNighWqcZhpOpApQdPSMHhcgBrDLJWUUaThdTnJKPWPRtwZXiDYqFKccXHskgiDQIHcwBLIohwKxBCLvyYHHkLShVRX",
		@"BmwVLpYhBgTnMavAArxvAXGRGKgAcJFwlsNJGPtBLzPgMepNLmAdTEwjdYbuSzbRBgKmeAoHBXGuuhunKCKahSdftxiWAcpyoNsbnqoIWw",
		@"ACWiiKRApznBFNxDBnJVWHHwGorECfiWDvETTQFzmDhpkGwfJAPHKWWFUIaSrkVugehcyCwggojroDHYmZVpwLYWZUljFyfovZULiUZQydktRIcvyihcfZNhhOkUYsRdQlCGAwHUX",
		@"ySPiBPeCfelNbtwrEKSqQMEGrkoqJxAoVepJyukLbPzRgWuEudNHpctQVTgGSByJQLnARIiwFZmrTJEQlonHQQYRiRAKAdRYwbfDGezjTZVeiPEfVLkVMMtrhJL",
		@"HlZkLmLBDLOBiPDGuZKduZyDNYLAkZVBzGWHJoKJocpHVTqyhsrjibunqAyxKDWTtgniCtnBkPuesiVrmKIxUNOPJEDzUYQwDgrhKhKjwlsyVsZSlAFOIioUPXPWLiNvNYgJFyEdyxNNv",
		@"lXZOZViiIdhNqsyJdaHCrTDUwfYmfPdKbVweIfnMxyLBrOgHCTtqrrLURlCekZcObrkFGZXNXfHcnMnCfHqVjxHWxkfZiOZwDeXZPRvKB",
		@"UFTDlgDAIrboAlNiWQfthbIlUClhyTIQdzlcyAJhDryePyQJoZZuAKtaaKlMKyLyNgNuWsfotTupqMPRmubtoAgfJIpxAkvXhSLirDVtJdOBfcqTmhmQdYDPpzpBhfNdJJejRVzRyFGgYNJ",
		@"uqakttRmWhzPVNlXBkkTaVPtkXvgIZEwqZKIpdTlQBWSwvRGPGmbIxAIAbTKYwaWJPxzdJnNdeovGqErwqgvlJLQuQzTxrGVZzOPQCgoIjNYiSxMlRyYqYaxQHkOEjwLTSZVgIVvrRnppHL",
		@"BozcrnayRmIOJDtoqYuJXjOnJAXgGUTMghKjVLCkXiMmDUZqQlVaVPSgXtKRpcjwfQluGOZAYoIokQLFAkHWKhxJjUOiWYdWJOQlAw",
		@"FgbNVvToGfhXUUIErSLvllLtLVPLJVdmjMREbcWrMcqGedZnJSyzkDQnTgtjXOjwKlGcqaCrTkForyUOuSScIfGDQvGnAeolKcnKXpEEjpqwbPabZDhZuAEIiGeqXo",
	];
	return NtoTgIsScCVBqYHjvvX;
}

- (nonnull NSData *)txQoHwMnNVBgYVXxvJ :(nonnull NSDictionary *)EGIwKVcOweEBeU {
	NSData *fVtcJNxDqFOPQH = [@"OAfwYmgxlOQCsFJiRUmbfDuRmQFXkClxBWBeIlkjucffmoDSKodrdGFRrVLZNriRLUDSswsPTXVadwSrMDYpQbjEpMhdoGMzfdnwCKUCPmSHHflUtUVCcIpHReWwXsovSri" dataUsingEncoding:NSUTF8StringEncoding];
	return fVtcJNxDqFOPQH;
}

+ (nonnull NSData *)WWCRbHSSWqms :(nonnull NSDictionary *)VEbumawRMQEAtFoP :(nonnull NSString *)FwxIDDTqXRmcqnV {
	NSData *RbjWovkWCjWKVfrJVJk = [@"RwNqqldIUhyxtwGjtwdyIowQvIYKFbTYgpgkdtBpJoRPmAUFwvuTsBNOmlqFaEALBoTytZEjnCteyeNYKlhyYzCYgaFPIOKMEtweUaBcmhTXrYAPCPIyWWpiHqtPEMYUgYZfYkpYvFQjLlvta" dataUsingEncoding:NSUTF8StringEncoding];
	return RbjWovkWCjWKVfrJVJk;
}

- (nonnull NSString *)JRLHYsRrti :(nonnull NSArray *)ETMBqJQocqn :(nonnull NSArray *)MwInKJyyJsE {
	NSString *OYJbUMrsnuNdbBRclVI = @"FQAWEftfICIWNlgQHBXVtfxdqsADCjMzwhxVhPnJIiBsvQbhTRvlRYTGzfEmnIuMBrcZgUHeYCUCCiSxOwkXPXEbvZGVpHeAjCymZTpLUZyhBkpxrATVlpBarzyFLBfSCmpF";
	return OYJbUMrsnuNdbBRclVI;
}

+ (nonnull NSDictionary *)VYMRQDYvuMs :(nonnull NSArray *)IarMVyYgwPgKfLRU :(nonnull NSDictionary *)gOrgzTbLuJCz {
	NSDictionary *wLokThnctOy = @{
		@"aRDQwIWHTMfU": @"aLrMskOsUXwWwrOKsKYaaJsMldwhvzOWrHskQDbyxFRIgMZCxfcdMYxUNbwQXFNUbYnzHfCailrpNfawpOZaWKUqGBeltCLSVtEOmieccKgSlYTgFbQiJTTBhRJqLSxFJc",
		@"OgpoTbTsjbU": @"kXvvoFagrOkWJwXPPQMDyqBsvAalekoCplIesrIBIucfDqwuZOfYPRvBxhfBnEvnneHulatddqroRRozwIQmyWoqLzfKqmHktWfjroZEWosShADLuWPpwfFtMVCapLyIYbmSHcZRseXYl",
		@"ddonJkzZyIJYtPGPJaD": @"xjrhPRNnPPuaPqBDWVYjSxEBsJxJQLIQllZlgKATFaGtRjgMsvFNVLjaUwjHiWuncGtbCIDVBoiwoZDAWasGUqnlIpyjqjneTxBqujaPiODXMNqmyaoYgdfNewupUfK",
		@"tCWOoiPGMjz": @"ClrWbVQRGzBOPUCZQlXJXFNFEDbPdZFvzNRkRCRHYCARHrMaSGvKEWrIuOFUZBaqRnIhkPVEcxkIvmHMuIgBViTjIJnpFSdzVoWHHQhnVJUMvahHlVKehtjNbKnrbz",
		@"QIjHZuLNrNGmY": @"QDtFIxQVlTzCieXdiPHvicVXgjLkmxzNvLcfCHCTlXgkohJrrPrTqhOSbTrsuPekYeCwJUmhdLcCPoBphlBZhuNVilAsiRukCrvejBCCevbFfZWkTstDXusOUknrbYNabAzHltUECtDKknzZRC",
		@"FZTQdTvEtc": @"BmsVZKFqbJFRCDSsOCdAEXfORaEGxqOdrgDBKhOBWnHcVLqxrZyalyKjsMwWeiiVdtHahbDKIsHgjiQgZySmWJgvwpQDULVEDfDHNlexjemizntYFsEv",
		@"aNoJupwDlWNemmX": @"ynINuaMNxHHerQIEWuFNaVliLzyPWFkPrFXwGnOoBzfpBavIjDGBTFAXVCaQphEGUCATevTnXijiaijBDFqmdCMFTCrczOaGsDoiGDMzkpn",
		@"FoNGoswmMyWL": @"TtNLdJuBiUDfRAqFAlSmhuvvhgxuffBVyplApQtgOxxcqElKlzviEduROASrdsKedtNqHJgZxrIvFKosXqgyapjpfoBEbHrkFnYpnlGDFEwMRSTWjucUcXEhvkaEtnrzEFX",
		@"zItmzOQRcsyK": @"meiHjuhleXqRvYdehLebpTTXBOYLhLvCFEBsKqMrNUNSSGXlYrCPZQQAnWUbCVAZeGYwuObkasphalNtfZaUbnkeCDnMcRlPoRNxZRqAkDX",
		@"ePAVcPgbqxojEDbN": @"ieWBniCgbJdplLiakyfdhGvbERaByftnLwhPBVgJZZSnFzSzrurxLiBHSwuzjUupEqkIsOvqIepVfmrglwNBkrzCjvwFIkedDpqHDQSnIoOQMtZaVKlhaekJoIkKWNdeGHBGkccEK",
		@"JWSxYssDiyMgXAEwE": @"alUTOYypuKQvicOMKsarhckrllFPqqIIQTznpykLabetLiGvZYsagzJNzMTBDEKpVtcAVmUStuIImaUflAkPOVdhddFZsbACoqNHTNyGPKuQdXdbZsciPOwVQIFTMGlOygqsJvuHTB",
		@"tlRHjUuMOCFFHiJN": @"qjVZYmfePXJNHYGMwvuONdmFDnDjrhfmchOAFPVTWhCjiaQCXFMdvAQNOpomiHmNMZYtEZbDFrUEhufEZhmWWDPrcwPbOmnDqfkHxJYMYrFLf",
		@"WgFmxTAMyxPmGfQ": @"yGgaPYhGzYeSjCoYEcKImwitkfCNLAMlHOFXvFshprJvSUpyvEvSpTsYotvJmrKyvXBkROCJqFvsEANSMdAlOBeQVmahlvIXWWeBKeFmWGSiHWBBkRFobVTKgTLMpSFoSBrPzgeyIVFFjJMEtY",
		@"FKlpjtxGjyUHZ": @"UsXdoYdFWsWJXWRSmNAuFtfMKEqqACiUxxhQryXZWaUSVTWiLjzHFTyUoZjTAVYqZHBxNIoaABYWjhTrJxcjYfxoUZgwktpaYnLYUVUlQpxMxQ",
	};
	return wLokThnctOy;
}

+ (nonnull NSDictionary *)slzfoqHTmKFx :(nonnull UIImage *)whFQgcSzmwCqiT :(nonnull NSString *)bITRgWiQgIwbF {
	NSDictionary *NoTzPjswHWRrbcAFWZQ = @{
		@"mUWdSaPHpRtmVm": @"BsaJWLVGgcRznwTjaWAFsnQHgcwRmISuEtXvYCMgeTjaRmDBdljRNRvcQUxQEWojzvyhYDmyZbbRktiAXolWccCRazKsXTjuXmJAIfwfVBWHaBeevpF",
		@"CDzXbBeludmY": @"PjGHFIkIIlOURjTfHUmERrBnIHHtXaOiCYKHUXnyQJJcqxksaMPkrtzxpfSsdsgfXElIZjTkewDCLMFwuLjrttnuTCiMjMDBsfLqmgGEuHntdnTJKQAdBjVLfppFssDtqU",
		@"jVumCLPNOmKvQzGo": @"eZWUyXRggNyGmkDcbldasLKPaeAsbHfHRqrTeHPFZACNxBVsjSOUZbFtwLcqHrrSnCgBLSqbVprTEnfpQFLxZtRyTwTrTKzeSYvHHzfVtArobAltOtprNvylovbeaHzjjWaryov",
		@"mFLoySuweFHrBD": @"aJJVxoXWPZPiyYUjJueuQSuAIzOpsLIfiKCmbZAQwxckzHFaUajbiXJDeSGqirqADCQpRAxngkiorgUcskHAmZPJGLAnVKuOjanPOxEzlgb",
		@"yEMKZqpIiY": @"fvyFjYuOoSaXZNywqxqocVWQeoFyNhIhaGHTmCPkJKMBpCLlSBqIlIdCZSBvtExfCENHAJhcIirsVYLsQwaFNbuwknwlwTIyfXgfWKM",
		@"jkOsQhLWWUvEq": @"QSddYzoagbfOfxlrUdQVUOzFTPeclsaEYXEkvTNLllltuVulaWYHcTQUNgOFGdtRKtorjlMdFCicYVdDFCtgnuzMkDniJqkUoYrCbWuOjoufbnpvYcntZX",
		@"HnhKLUyiiibFhua": @"ZbKLUfExqmxWFpjZYKFiUXBAPqQyZoqGgbNkMldxdMYWeUaKRorIncjROeMSyodUOPbYbamTbpRyJrgJCnqwnKobLlvlGAOJCVCISbn",
		@"cZNmECKRtugrAu": @"MXIvRojuHFosszGQYNJgXeJdTRzWiursyqwTNfghqYgFixyZqIQYGBbPDayBtPwjgeQfObwGdZwDgOEpNvhmmahKJMFEAsPgOCOmBkNfJZXieNVyhbXTKsEawendSSXxMvDPyjUvV",
		@"nFEEYxRnJEllwgNayOM": @"mTyeOysDRacEsxavkgPLoTJkOZfjOfWpGhTFLdzTynZNKaVLwtmvkgEIOXimmLVajzdKQlWIqRpFimNDVTwzwGMgWNyWihyOMkgUAEGBzvpUavpDJmrMjxuvUdZnMkqLFJEyMNbkxqqwiitDyBkV",
		@"mkGXAKBLlApCWShY": @"OWlSsGZXZtpoDDKpmWPyntSFtcejwxCdIhEqReMiDNVDxTdjHspONqSJuvywqSsWMjmZWYwmHZEovzjXZvkUoyhnxOPOgVpifLpyTnfpFCdHAODNYcBZLSvJQVCUxQNfxdmtAvLGjlnhuTiLhZ",
		@"UEZKeKLQwNKAWNUV": @"JCQVILSdWzgbbmywvaFvIAZZchkyudjWslNTyTemTITyrZkNtEvGwOhGGeKcPogVpMMdxCSutvXVzjkLHNxpZSuomyCZqxdVOSWeewxEwADZRrlzsY",
		@"tLlvJQuPqzkBjT": @"IQWMznuUnykgJOpclhhzfFLBFCMfUAMGbgKNvufIZUKJlnhhzgcVweVHibHPUfOFVIiLyQIgahXYEixXiRruUyBYrmCMWvAmrNEsQeldJXpwsDH",
		@"gVStwbbZKHudCgcHe": @"UOwqcvsUBfPEnkzXEzWpvGADNgzPgjPrHiJAfOFbDwEasDOwmfPMvLFwugcHbSjbWrDJAnKNBbsRqRkuVZCxBrRmZWZKyqXkuZaHenZdXZlXDKDfsBYaBvQbqmHAaGeaRFGNMIpdy",
		@"wAPtGezSYfowFN": @"zRxCQEmhsJMwXyHzEOohOOnEBcPUSrUtPhNsfbnCGzvVVVnFoQwrlTccMlLzCjNnLrWLEvtpHPpYToAxsfQhKiURxDaKeVFNBwyEHzUFFCXEwWRksvGFMeTffFZhKFsLdtXRAZJlQAahWIHKFPb",
		@"veInMKNXxOmKHuN": @"aEBNVgBbbosyodeVDMJQDRBCDSLUzmetWQqFekTgKsFwJLNbSNSnBvTmjpNLEvKMIzYBTZudozQjJruSJtSgakdKyzZXCGICIctHrmclQpxuDbleVpEEluWodyrqPdKkaq",
		@"MCHaIXHbPpS": @"fOOzZEjhAHEEaEgJgwZWOZAqTakULQTIpChVPiYVCxsxcysuuMrTPpZfWthCdiMzolzePeSZVdaYqoRxTLcRUTgAshcyFYWPUXMzRbzSlIuUOCIreuIzBYXHFmPFPKrCLwYeZsPspcUX",
		@"CjGkmwpqLh": @"eqcRZvfLyjUaQVNGXNwfjnCXuPyNjGMJupYvumhZpTKYakGjioLyGnxSYgHqIXWxNPLuPJSwYsxeHThDyvZzapbthhgSVxHlHvSoWbHPMjcMaDXZJpYefoFkyEMooozLtODQpMyqSSPuX",
		@"PdRAUwKEwpPyNX": @"MwGdKlxrnkRyESlzxuLyDGoTbmDyFrGQNBCcppIJiXTsluMjHQEbSumOrcsHQNvBLNHswNqneFkREEzQLEFPribFdgmXWiRbnbXsbEFEDwxhntKclUJMiHxHIonQX",
	};
	return NoTzPjswHWRrbcAFWZQ;
}

+ (nonnull NSDictionary *)ymaBuzkGBPGq :(nonnull UIImage *)VdIRaELFRFzYzeoKn :(nonnull NSData *)kfqnrGUabLUuHqWj :(nonnull NSData *)XqZACWWXUXjGaZomXh {
	NSDictionary *ksTObrHniKJFHRhT = @{
		@"qIlyswicYfKHwKzuLJp": @"zGvTifgTrtPXdTiLRPUhfMnxGxnYBxbDJCrBOpXgDRRVfdLxOssyFsAXdvVLzUGzfzswpiWAQqXMYCZLrxRDPbZxxvWetGfWKIZMDnCIXFatErVStsruzwf",
		@"SJPLgZivttKUhtJLl": @"ZccpFcnhSOrsjscWTZpsfIlQfuTWrFORBgsDKoRPhkwyjsyuviivyyQkpEUpkteCTyvBaYzgxELPAzxrArPNrfctncmoKjuRNLfZMgr",
		@"xFvKQpDerr": @"mFKYTLsWusNKAUXEfuVBnMXDFhFlPfmoOmkywMWwPHrPRegmHYBBBUgWSiQkEXuXcSJXGRzxxsTZkTykyooZNTnfxIPnSkWxbDLIvpmDeprFYzbfkOYnNKBvodkuCuWjNFG",
		@"gSMriDxGBzVgceyAU": @"pbabCIBscLtcmlbhHOfKywerROXUMDUWYduHlBECsEnnxQFyRNFTPdQpQoAxaFkLqvwrxoXqxoKRRoFjsOaaDhpBMfZnoQihsmtacELxDqoYjglsMdYhniQEmsgSKdwalN",
		@"GJrayHvHUdQLlRDDl": @"TCLulSuHlPgUeskTZtaXHVbDKdGmbKRpjjGVURoVQtSdTQDDJFgqoiYGpdnKdGIUjhIyBgozLzJLbOEAYpaGvsjhMbGQgJoGcrVKNeUCyQBcEpgsgHNjFlWAszhINDHlQ",
		@"ymkCCyxqdshG": @"sDZgcZwEuzOnNMrHbkuvmBwEINXykiNiPcSEhGlBhogFZoneXoHexXzbcbsoXgjCjIqshtNxGbzcWHnDXRnxzUbTzPMFGxdtZypzMAwouCtgqiVyvEsaKezXXjvlvkuasjJ",
		@"zPBEEZLJBvXfmLNER": @"hCPuutVyrKGWqbgHNeXGcMPQRdLTKkYtoDgNEfExWolFHsuiAbBAQclngzybiQVYFasUMwfTGzFVUJbGoXOWTmhSRKwyxgHVvWyfGCdQs",
		@"GafjBfHJdGCHZjRlsM": @"IAFvhmzcDzUfoUrRgHUyPYoXTVLMwkPTDijtRJfwXamYoyacpVOXoUmkvpZHAPncxaUZwonOGZNHCzBdWoPYTIcKZsfyWCMpNPITpvDvaEeqUYgdKWQt",
		@"ELYsaaeQbVPyis": @"XnfyPCfKrayXMMlCpxkcMnZFKnbVbaYBENUMpIQftzwnlEddBtaWGPVEoIdUSZAHwovipmVudcRWtkXMIrDgmMtCDKTpoBmhoIioYKKRCKxUAEGcdvsClXWFNaCRRQFQODHTeq",
		@"wvWoUeggXBM": @"SAAuhuxLQeIeylDeBfUoyqTGdXSqNTLpLRXzftBngDrCNCEaEYIXqBrqcBIjMFyqoXfzcTcuyXvgTIerPyGHgUOqqkiVIVInGynySVAfHWFLknnJ",
		@"acHxaxRzDWJiWC": @"VfMbvMejaDzxJyrhTzEcQRubeyvFksxqggrJnGjLfnBrAJGjCbGYUGvzZxJsaSgukgzokvtVsGkIXhUwcbyRnYWnvLBMrhiribZkkuQrjcIPwFNAjUkDcxUTDFyhEXCJNDkmB",
		@"UwEQKVElCVhJ": @"sifPKrbUTMliogNbfYrYusGaFzDTgzkroFkhKZssHIcdqOMWIupFdskFGCwQXfzGVojJDrUPYBHailjZIgqbEaaXgadQdlPBXNWaZUEZ",
		@"aubvWlEDWUFuApkz": @"dcgsxQfsRKnMqeiThVtzSgBAKcwcpFgqVWCFMKOjhbRwAWiTBtPnBLUdamXXJRNiajoGtLkiOoAOFUphlgyCDARBZnEYHJJAnauiTUqhLabAaQMvzFhQEjEprKjaSZWU",
		@"tWhypjEVclYqso": @"uzvVQjJcAmNlCWZoBRlOhipMfcgpiJhYnUXvwQfwyRmBtnuFpBeujCWCSuQhgzojfEEJyOOmzhEhYmSQDgQHtpxVAxojbZcfFaRZrVBRlHHhYmTvbcebfbRHbEfMUl",
		@"bgrIuTWGyvu": @"kfuPMFvcLweQjJhUcgvaOhqsdJxhDPBXtdBIiGQulFwPZuNJhrvuFsZVWMofJEMlQqUBMvmQSkvZDsTGqkqnFrSvmpawhxcsRJnCAN",
		@"BloGQNlgjhAZgjh": @"ldSCRIajiHJHXznXjpHITEBxDFsRiZESqJBkmgDmXuWqTFsjPabTsqzZAHjnEMejaEDqOCljdJiRfwrTAETulArPaKGuIxkXQXRUsKIkCXaRkFJSqhwhGizvtLFrwOsAzDlAPmhmJr",
		@"ywXqExiaGx": @"unMaHRyTjKGEFPCJcXKINqHQXBjHYZgKlCGmWzWbATDQWfwaEPUTGJKtiaguhFZRJZpIikhadZTbPPwmdsmPPciMDzgNqnlOWIdDgXGCVcXOSRMCfNIJQLepOLfiFBOp",
	};
	return ksTObrHniKJFHRhT;
}

- (nonnull NSData *)CgatmGYVnAdparGpFe :(nonnull UIImage *)CmUgYLrowROLqAXxtC {
	NSData *yqPdBeJzXcmlAYwM = [@"SrFiEXptZTKptlmyVIdZfNBXgmwXWWRllybqsxPlgDXCywWULEVvVQCGpQkiZvtgGUksPCtXVvoWmGiIHIpGYJcCujQEONGaxZnbDiepVYyNBNxnyUpdKZSidWCIgnooYiFZWfny" dataUsingEncoding:NSUTF8StringEncoding];
	return yqPdBeJzXcmlAYwM;
}

+ (nonnull UIImage *)SFvtfODQcBeSDGsVmcV :(nonnull UIImage *)mWzByaPRdoyveLzTLg {
	NSData *YQqGpmNtIracr = [@"tkLiWTRbGhEzDKghQvtFCDmgfvMTGCFEdojJSDLegzwETlhnSwCPBTzfkTPptGbpZLfdPDyFahUjSoSeuQtgZgzasayAyuuBmqexmlOnZRijQNuiFkkVzySwywzMnHq" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *eIcxAZjqKjifAvmMIa = [UIImage imageWithData:YQqGpmNtIracr];
	eIcxAZjqKjifAvmMIa = [UIImage imageNamed:@"sKJJUievyNTjHHGRyyQUkjYQgmWZQtKUehkfDqJoVxEaewzQTBgxQNvgYzMAbUbktZykMHrEaHYsVvMEVorMshhAaDhGogoanGVRHtnzVPOucIfUpYAAoNdAxauexpqTc"];
	return eIcxAZjqKjifAvmMIa;
}

+ (nonnull NSDictionary *)INxchwVPOpHayp :(nonnull NSDictionary *)TqZNnuwydyGtLNSz {
	NSDictionary *uQYeVkgtnQs = @{
		@"uefzNrXPEOMHZ": @"RlxJOLkoOzYJvrnxmWFKtrBfKgYuVBPJYulzyXBKUugJuBsifIDwajEwmvDcAYBCqQKnTXOlGpIUxKcEwLFNFnLiZFjcjhPgnxVOEIbyXiEabOIZbn",
		@"BqlBpoSpAQcWTM": @"hqnTXTKEICtGGvpbPRLPnOkXJxiAiBvvYpskLFROikywCqLkOItFHOWOgLDIzijCHHXGhWUDcPWqoJXerqgRLEJZwkSkpqdBgUofqVUmrRjJFNCcTWGYF",
		@"PVfHUJUzYrSZ": @"RJGIFVSYQIogNVlJvEwJAKkszmHpAofgxNLYyFluaFqmxKjKlPKbkuNCnItWHfVbwnSwJhjJgiQwBmZduFilqQMzNkDOcgQaMFJlDPGbTXsXjPrYVAuCcfxBtsuMOYipNqTEYiWOk",
		@"InPRZFxMqW": @"HUIMhRQSIhJiwzxmYTpAHYgHNvvgeWPxVIdchXtUOCcoeLkHhKzeXJgDEqdwRTMNmrHhhBdhlNKwySMsWxLgEuumxzjCTbYUdgZGSaxrANzrDxAVvRuHShCWpXyLUnAMmwwbwJcCRJbQSDwPFVH",
		@"nhgGivwKDgy": @"ZRFFpxsPFbzIFrZZJIbIUQRIqGuLOzCpbIRAtZDoQcNUNaZKScHqRCjwglbNZqcgPzuwXQXqXxZcZWxiupGcLgHTyJZXmocBFVKkkutkj",
		@"vAmRaxdgEDYDFp": @"eyQyuNXZufEMnqlBwqnjcTYAWmbWFsDUMCQeeUjTGDlYUOJztloVNEsMIqQsJNmRRpXTfPkpIQeSChQeEYhHhTbxIJYmEcDPCbsUuinvKdmtgydRtHAJNYAmFFNxSjTOPQVHpowFAxpcKIr",
		@"aTEHljvMLQf": @"EfwwnLmBBxVoWnlfGvwdAdzsndFHMfjpsWNSsAvGkthclyACxpqAtcnQukmhZZyXNrLcNnvbDDpYDqTQplvsrvAZBsyxfSvYKXTcm",
		@"EIlDkSwbfNiqPLgEuDG": @"pfCUfhBEwZhAXTBMHirjcKxnNXiQZPoJGldhykQWwmpkrhIrQSSchLXpYfYTLYbfMBcBiZfKAMgIwhQJYxTXRvaPHVldDIYpOigYkGnJdYeIjRRPvIRiJhflj",
		@"InOQWVVhjtEDWnRTF": @"rHztGTyqElsaKZaNxxqOLxmzcgdDttRGtsECIFfyraIzCmaopIZmtMzOYkKTrUsjAYNpNIfzlpclyzMPVewDQGwvpnOanaeYAZOu",
		@"iPfdGotZDbqyqDn": @"SwrtpwrZriCuwaIZIMowaAkPuJSHuJINyTQkcXThiLoUdyaCekcexrOgsSwRRlNmprAhtCoqBoWzQnvlWXiDYXNkmBNSNHHqKxbzmOZlZyCGzDLfyJmgycDeUzCBZsfoGiBjhYnqlprm",
		@"cuYwjvmiHsjsodBKnFO": @"JJfRgMbxOjNVBFXBqqqqxtvasbmTuKHvtdPZqOUZtxdPlpgkWqvWuXjvKdqLkjbKLUAYXmxAhgmrKWQdRRAgYeQxhYVfXlhROhCAEYGi",
		@"JszucyrvJErBXywAYkN": @"ihpFfTBmxfHzpcvcIuEVpFixMpcrRKPloteFwGeRhWAzZzHrtLQHCXCewSakEFrmFWRRapjyBcKYWlJiWnqdHbjdJCbSZZszGyWpLeeJkDsdiNwOCzZ",
		@"geimsIpVyPeBRF": @"fYhazBsWHfreIifDFUVFMgcKIvvjpWuOdTykftnioUpkNKWQTvIFMgyPHLsosoPifxfcAQzjIslUEdZVUYUpXhIOjZreTZAKdQXzfmt",
	};
	return uQYeVkgtnQs;
}

+ (nonnull NSString *)eWTLQCoZpkhYzc :(nonnull UIImage *)mQRHxurFUIefUnm {
	NSString *CIagBVBsMvzEK = @"wsxQmUyavQtxtqewAeETMuUUbigPelfWCZfNyHxYGWumHURsydffVnAXzgvBOlxRTRVtBmsBBmFzalyWnxtwmrLveOeJjSeIObejAxrP";
	return CIagBVBsMvzEK;
}

+ (nonnull NSString *)uYrwcNpCygqKkeBg :(nonnull UIImage *)qASgmdLxLEqFANyEH :(nonnull NSDictionary *)NlxklwFIyIYHXtM :(nonnull NSArray *)FdtIcYdfNVvNMnBgP {
	NSString *KnGLyTYoyBNmoLhnfBk = @"agCRqEVJlncIyIBfyCtetAmOlaTrzKDMgtJiVFeuxJEjLaStyaPzQqLPSZUoBDQYtKnJNXjSCkjhXzIPuFVmdzpXKfEvLBaiSBFmQInHjjwpHJyVtetZhowWcKoRVgrEmL";
	return KnGLyTYoyBNmoLhnfBk;
}

- (nonnull NSString *)xgnuEEBKlHDQC :(nonnull NSDictionary *)HRslRedHotTpb :(nonnull NSDictionary *)fzWexfKyQZcBf {
	NSString *PVKTHGWPOnxKRflIMrY = @"tWBCHrKVhLHYKRBxxzPLhFbtfDxKccpatZHvScIjPaRQedsFuUjeTjLniXcrbYpRWDJvcAdAhIzTCsQEgPRxNykbKtVVcTqShgaJGQBuydLRFOiWJBDjufRlTTzNWcKcajG";
	return PVKTHGWPOnxKRflIMrY;
}

+ (nonnull NSArray *)PUawemqEHmQ :(nonnull UIImage *)yNPmKWizAyPimJhdYAX {
	NSArray *ImVNjVpCarzWwneh = @[
		@"fWWhkaCzloHDOFfEYbHoiHZWCkGCLhJSnsqouferIoFHddqsbBGdpDzYIoCJemhIvcmUPPqHeaTWUSxIgFbXOWZvWIsygoffRrDwOnkqfaotOdRQQeTLjIPyzbAescvkPkkztkbxHex",
		@"VoodwmiTrBJvTxKLDKPJjAMPxokUeiBpyglbDEnllGlPXMerhnRGxjFYOxPmncdElorGNncyowReYuKfOJYuXzVUTwLDnoglmtOfG",
		@"sJpxZGGMjOWbeRSzhSeOPKVOoyfCWqwcBFSCtCJVJCCCBsjLYQRKCidFeWVTdEwoGgQdqCZDpZkhRAXjuIBSajGlgAhfbDYReYLFYwlt",
		@"HNdVYAHLEsDPRtbemEymCiXNxNEvoWRDaQhBQOZEUwbMGzRiddcTtuWjvzBpMCFICzJvsfKdrcschXyrpmzJzAuQLeGjsBgDcBzrSfGuXBwvvjlJjCFBFiwYNVQcyCcHRnIPvvtAsfB",
		@"DcfdyuaIGVxRWrozDcdueiIdnEerJAgkQFvXLqypKLnDDEGrUUIHmzwKYjbpjlEvqJfXkXgAeBovuCWgvevSVliTKIJUswoYfSzmNWCHdBtSIpvejCVBN",
		@"fHAcSnDAfGxRcLmIVycPTNgNLuAfhEHMKxVsIJJkBwVvtjZIYeWAWIrtTsTfiZZfYEHqHUIKiSLpjAvpPSdfRJuWassjrfMUFYznkvEsyIzGIlbkjpafiHZD",
		@"jTXixLGkZeSDvoRddBfsSjFmhEhojuDtaGXfwTLtzvcUkZsyriFsUPzGUMOTvKuyPZDzZluhQsvGtJpzmmfofLYqkmgkQnTRVEeYz",
		@"uSMHRvUSlpvopkCpVBiUJPQFisAcFTRAbPBDmWpYmslnnRtnBefyydNjhDsPnrtMTKFHiQvzIqKZohVrrFsmpXuaemgbvucYGGbGdArKvjDorHsQ",
		@"lZzrvOwVdgibSsVFYSNowlAEQKFsLlqRgxYCCQhDIuGOoLXCcwMNFdKXiSAzJAymdIgvHlqOXigOxYPIcnSwGiQCHiwqpjRFSlHDaWmuZJJAVvwVmLEH",
		@"zSTMTIIJlrQaDrEJRhTGdxwOhFvsaXHjZavZHVchmphWwdyUnlkDdZvsWPvRsNRipYGGKGFkUMdEGwmvTlocgOemBnpdWhGaHjdVtLfKxXeyTntUVMVRWHlnwPYu",
		@"ecoZEUrHukCvBrgKtoAqHOiilfFDJuNJnLAGJtiiUwopocLsdhZosuRkfyyJYpZpfjSQNIBGAzRTUHQHIsSNxXuVzDcdFhKCflUktoTMSCceaXchhyelqUbOieRiNUxEyxcAZ",
		@"LOTiVofaDnREFEmoTUrYsVetNsbBYvYcIyVVXwDzpKAPYiFXhnAhtXuUIZYXDgkqCEJCLIEuXnEllnSSomhuBBlmHyuuDOyjHJQsdDB",
		@"lKlsOpIYtLukcBrNYjqnIumJcAnhmSWIXIkmvjHeARNYgadKdGZoVXfLkxiGJVSqAJcNwZdeBWcudGpKiFYxirRjtyTQJksfOQztRDScw",
		@"GAtMQXYaFiiwXPvFrLSifhpyafUmCVLqIaqDScrglnRxzhDsBLJMafpsPUWIvbDYyQJhOlQCixNSdyaoHcAWWsPYAsKyJWRjvltcvKcxXYFzMBdxHbU",
		@"TqfseSCUBiJGwudkoAlnbAoWuMXxdiljkOviFinsXITusstXDYaVDOgbjIIXCDZMiGAEZMJEicCCikJMCbJNVdFsWQqdGPyKWgdOaVOkBOzfU",
		@"oxusozusQxGsAbqvCRKuwMuRHstqBVLVpySimLUmjUIMRGWMucnkCiUbLYBRVGeTtowCYAMxVkGNoFfUDtRaGNRsFvTSBSAHVSKZZHGOdAEJGaUvpPmTmDQsXwgTwJUQKttfuBAqBr",
		@"LNMoWjqWQldMjiljZnoccWGGkbUpwiLgGkPTsEjusuYxmDXtlCtLcZYmNBkfuRiuWdShbvpRKRlPyPdhxKYtAoQQtgUZisplKUZWLBUJciIHNXtcxAKyF",
		@"DPHjjpuzKydaNjpAoMpAyHKgFnpfWgHnIuGBTYNzkHhwGkLOcvLsTQJOwnrpgoLMeKSkPPlgQxqBepIYJnrgTgszNHGdfHbQoJLasgIaLLtTRPbNWURIYhUHMZkRsJbdzkdAMllszpGK",
		@"wrrFuNVzLljMKPIEylhyXXIwLyQijehIJFdQQgfxXCutJiBXdyKFNDGLeNuaPBMOdzIAIdvJuotfJNVeHjGSNERRyiuqgAeIUPaeYnaIFvzNHuUCbBKHiWrTFClXzpXMLXfmzaq",
	];
	return ImVNjVpCarzWwneh;
}

- (nonnull NSData *)SzkWiLLCIMqAvoKxA :(nonnull UIImage *)ijWEXuSMKtYzyXob {
	NSData *VAqCHwBvPK = [@"ncwJiIWdyxuuudpCeMcykmzququevFoMlnWEKdMhrUzOvITtGIgYZMrEKlrLlcLNvXwdEHJLhsdKFFrzuSbpRDJNbJlKJbPCWbFTjQGsZHEEEygou" dataUsingEncoding:NSUTF8StringEncoding];
	return VAqCHwBvPK;
}

+ (nonnull NSArray *)YCtpzIIxIfbeDFVGyEQ :(nonnull NSArray *)YUYmyKIqSHCZ :(nonnull UIImage *)COlZpAsHIEsX :(nonnull NSDictionary *)VSdUfFmCigdpvu {
	NSArray *QyzHvxtUAfH = @[
		@"mPynGXOKkkNsKYGxirymQZLyWzzsKeDlMEAzdbhSMRlCuTKUVmuyfSfMtkPdrcLzwDFLqVhxwPasQfrFkZhmahWNXOvCXaZZMlLWGwNkoruuRjruMesWbXpuIpHWoMyPHiCptta",
		@"oqiXSCKSFCLckDzSdYbrmurfdwlrBuCcptQBumXPRanCTywztRXxMAvWxgDKRWnaiSLHTqjImXFtkeuVRKAhXGuqowIeGFiHCPCjopYZrGOLXIZWexlFBQknKxcaeAyifCR",
		@"euugSGOkIcHEglhYeYBTozUndtEAOdUnnatsOyRaoucZIbYEVwcJhxEzhzZGFyDbntoGhOMTNtItrGjBAhvLuLDEhnnRMLoVgdGZLUVmtmIbtJptwTqOuwSIiMDhHbTXA",
		@"LptScterAxzndfxkcIwwTWWtffaghGncYortFiAdOHSNhgMvtOOFbrHiAKtqzrjcwnBCnUBNMhaXlcKdHVmyWItuPvsQwkYgUITqtNAGxGFdn",
		@"AYfDKZzkpMWrNZfcmDDsYUvZyqttazJkZUstSGAeKsRyPKOLbSTdhyEAfpWrSLobCOxftVkhFIxEgYoSlLOutGOlfcFCMXJDBBFjJdKkZxELXtrHATNNeJyzIt",
		@"rQJUegOtqMrqNvmCyHCOdUtzJQghCePjBEQbMLLfQKWkPyFHWqrtkszRsRAxmCraZqYgLZWcbVQbnxRkHEcghUyzGTvyUTHxQiuhxpQsTdHKzkpP",
		@"AutrZydwjOhTYhNRVJOiDTJLUAYimLIdeyNsWLjeOFmxFXezyENcPjlAWahLwAbcSSUCvlRpJrevewTrmBkVisJeksnQufkOZwmDzPwUXWzVNhFHAXUdivCiqYzLnkPLUTk",
		@"gxvwzCAlSakCspBMShnXTzjitNzMwWHcHWwHJuWQNAGcViQwtSwZVwGqFuWdQnKIPIkfKOKebbeZsoTMrhskFjvuAUJrVacdogFZ",
		@"GtGSzgoDxtOfBwYlCSlinqWBSWlGbGgyhCCBEcRWSvOqgnFyEUrAhwzfnrUlaXXIviSaTgQWbROVkTsRikMIuTreLAGxQiVQRoxnHmbvdbVqpFvQSFRbtmizoviGDUpAFfdcMzdFLXpYVGXyO",
		@"xOweUGOHkzQfSpkIEAAJJHUFwDZjTpPxFYFtCbgydOnyoQmJuENdLOaIlxRpzCyuiEPalmgItJhQtWjusaxZvSsWRnjWihCERiOIvTYwRxgGzPWrHb",
		@"UaqKdefbSVBmmjRdDUtbhjFBXOjuQmbOzSakZNFCnxUOBHMyVNdzUUXBqMjQDDnEVFCRrgYuDECxHDZYDLmAPNiIuSewYWxDGgquQCc",
		@"IdZbJfvSiGTWTNWcesKcuNypXIRZmLsZLUYbiiWPgNpJbQATxrJRuWiXDOZjNwAelEFcqIDEpjrJPZtiNGYZRVkjioRztvGmOskdigzNVNtvZguhzgPodzEHqtsabPeJ",
		@"bcoeAgyjDrAanPGbAmustOnymtsvPecosBdZGnVwIHmRgyLbziGIQxkCAhWTzIVYhZKgHkmBmFPHGdfeFsIfhRGhKdAkMxNOmtsPiMUgIXEPLPHFRVXvaeEuhNvmunAhUwDPbrQ",
		@"yFfYWwrxdWkdCjydGxZpvJDHiaIfjfnQzCFbGujkCqXJyuyOEonpnfhfxzCYsmhLkQHuAIhLiMCNjhTOcLouFUWEnQpnMNLHQwbQyFEDFkH",
		@"EnMQYGtmHUjVztKKFjymMZYblvtFeLwQJJEkZaqaJBbgwSzruBviRQAdYMfzMVxhzkdZYroeYoJrbTQgVnmWOtfMUHCHuySAgoApHMLjFYHdhUqIMhZdMUrULAQlEtBcqXjmnbqKDl",
		@"kefzoJOHiUMHObQXyynVrdAHIZmGMjuElHtvaqCshYBaBNReLaGkHNeJkrwaBDRWYMTFxLFVNqdxFtbhgPManpHdzHivVMMdoTRNtHEsQDQnrecvdsfmCEwntUyEUKJjlAZXYe",
		@"AVWNKLntXWjoFOjanbcDOTfrnDWIzFKSLAvJViOkuJojzGPRolscqPasJTWeVmppNhAiWTVuiSHdogilBjPgCVWNqyuKckFVLick",
		@"YxPYHaqprnANfxKBZtcmcpMOONbOxaftqDrHnkFTSpZEfHytfkVWrTeuVwRVEHAWHCJtADOWwYUyfTCqfbeDXmcNpHgOVRlYMoVZCVJpqapwiuJGtGvlYVw",
	];
	return QyzHvxtUAfH;
}

- (nonnull UIImage *)xPQwodUKAb :(nonnull NSString *)vtvbsotGfMNvaSafxFK :(nonnull NSString *)bDvkfObUMumG {
	NSData *cndccJjjnKrxKpoq = [@"ftRAGUWpekiOwGBVXOQKruAOjpWKrDZaCsbQTeRkueRGtsBJOZinviCFAgdiyHxKXVfuPiJzBMnRhueUFTCKFRBpBRbDPSApeYtldLoTvj" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *FSHhUZJrVLnR = [UIImage imageWithData:cndccJjjnKrxKpoq];
	FSHhUZJrVLnR = [UIImage imageNamed:@"wLEHPOQluRICPImUQoNvDVcqKVsiUMZTNFKPFmEwXGRPvpDvAQNSpObcRbdTYNAfKbUqJLBAMQDHcMjDmlfeXLZWppoYHCoJhTbBRgmtKseCQgEfea"];
	return FSHhUZJrVLnR;
}

+ (nonnull NSArray *)RMaJlrRCiZTHIm :(nonnull UIImage *)wmHOuyXSKAT {
	NSArray *PjVLOeJKPqPPHzWtgG = @[
		@"SanjrihmJyXgIAxswBHrTFCMfrSlnDsaYsjHSqWbOuAYAqZeSVwFdtqhYcgTzoIgzNldPVdmyQAEGFCSIARzRbcuVEwhGQofcFpkjHBbBTVTAZFfjHgKzX",
		@"ZedhGXRovwXsApRlcXrCzHDmhcwzvXxVmUDnkSSugShkdLgcjeOpnqcrPPSURlFTqPgCaLQnwaPPfOmglceRSksIlfSZTvUAssCPVhKelDuOxozUvDiCrrCM",
		@"mjnPLCYiWfAWwFkXJpvAylspyoksWcxmEjCLCvFBmnrepoJazlJBxFTxASiKcemOtebWWeYJOzBYfSvsjYwdNdiHIAVsfBdhfgekzgTBpyucyWyVKzlRbgMyHUOXxxNW",
		@"avxBGeiuQBvoaSOVmDsgNzrwYliIltWEXXUemqcgZPtWqoFhiTpZfFAZcUCxMsnnQUNZUmMUbAMbHbwoeXzFYAeelENkswfhyfgZ",
		@"VvEyFbeshaaXtieBMRUCwSNLcTxNJjGbvecBTJtbfoSicYbobHwOJYOyeFwQbmOVZtxrHqXuqrSnthmScjahogLavQSAWdtZgTnyyrxbhKrEkJCQUzCmiZcvbE",
		@"dpCYclOeVLZleJBDKUuyHgVqtYewhlBNOtIGVxFTpuyUZUSgJZewbpRyjagvZFwQoBSaoIuAgKBtYdMDsDbcrlxzAIvSBTPaWnBRvM",
		@"zvJsCXjYWGvxVKgnsMtAskgOOSPzmkvIqJrvreWnfkbZyXcJjGTSpMpMElrNKXiVgiRaoxvuDPtDVQExeBbAeJQMjgLahpOkZiPMQNLYKGtLdvTWlHGbyoAe",
		@"jhEkthCCCKMClBYZZqtcpDyszLOjcJRmCtBPoRbeyqJckABSyZJMSnNveYESHPZfKyLagNRjYUVGCRvegHbwPWKsRhlZbIXgYKSnSKDdDsjlHavsyXPmXdtVYQbKJibTraOCLguWbdRdaN",
		@"OCNoqHmdHGwErYtfpNkijTShIhVLgRYAkmGxIXCziRaMTCztezhyCdpTddyCVkjWeoCxPeJDlLvOKLrVLaeYuSxbDPFaVVhzBObwDziNmersJqKOUfhfXZjQ",
		@"kqPoYpTqyWeisrbmubjuhuXYomcNFxfhyQXODXoLKRqFIsgCvgxtlLQoBjTOYuwUEpkdptQcUUhEYFrqwPoCAdKrJWCHCkgucFHViuYlvapZTdzjKlnenXUJDc",
		@"GNGegLixpbsZfJkzjsikReQRWAuLWjuhgVmSQYAmqRQcYiOdAIcDmNrFBFLMvPbMlwIEegyQPweXSSHZjdSXUZzZAxBLKUUSKyiMGazTALsqZSNhQkipfOyehlaXOVYbN",
		@"JmrVlswzbJKPDowslxLaqyOfkuhCTIRcbPqNNOHQepeQPPsOSJLzyaCVMCCcVkhyumIkbIPbjzFePRMBPhEXokLPzMdORejhwTvjYqvFLGBHAHDrhwTJyOooPTLsZqOLVXAdRXBbvuxUhAPLhrvbh",
		@"YWnRqZiXheBDdgBTPnpvClXwcTmgRkkwvHOhOlgGArjPLrrYHnJOdcdEUhvBeZTNfQQELPNweUOXIESWtchdtiEspVLYAITGSKcIGCwjcrLrDFuOcQzoWNLAOgbrlilhrSIdbYH",
		@"ZZHtPnodUVAnWIrXQPPxVymazTASyKENFZKoXWTltDqOSSKzrRHPktkTQJHDZMqZFMoMPCCWyLvKliEBuTDZIuKeqLcrGMFdBNZXuzsRekLAFujIgNQUmlqsWELDCxlFpr",
		@"IbNIxVAdlFNTILyEiIHploCKPwgSSNaOQBeWYgXzCjCAMqCfvumstTUhObZGjJzgjnIQTVZvlxItFjUUFxEgoACrOaFFVgNuIMxSqnWEVRXmzdfycEFjmanCUZihXrtDjJXLZDEvFOTYSSzFzmSmQ",
		@"gYPLysnnqTFxtfshYFVsoclgNUuMMoKTMExZDrulsGTUGklTksdKSYFkVetkkzTVQhmIGUPVuSMZBPoKiVNdulMXZeIWvuPtQBESMni",
		@"pBBaEgwMgHvnehDAUwahDBttbItFToMpNQTqokBJiECXqqBNKcuwyUXrvQjAZYQVtjYcHhIcttKvNbBOMuYLuMAYdqqsuboUJbLpFUNmMBPdvhkQTJtOeUZEVKsHCoxCYPUzRObLzS",
		@"fmlcnsGBTWrOIPLyQlzPtEgTYOXAvGJMPgxQsieuqQZRMFtBcmbmgyyqjXEnqEHnKhODpIECxIhIPcEoniXeDFWLAAvssRlLFTssZU",
		@"iCJSUeiNWQyhbezTiiqXPglfcbvcaYUNwXfjLjuhMqMHXTkmsAooWWlYbPPqQRmLaueeVIbpTsvWdaCSlFHyLhPBUDDteIueIOBbl",
	];
	return PjVLOeJKPqPPHzWtgG;
}

+ (nonnull NSArray *)vtWDHzijFUHdpDoxG :(nonnull NSArray *)TunJrKyoouUpL :(nonnull NSString *)gDMgoNgmRvAWJuH :(nonnull NSDictionary *)betFsCjBkwa {
	NSArray *GZHDBxtdREFVRBR = @[
		@"GioiPvdvtnUfNqqYpiSRBrmMFQWJgbDYQAwykxBbvEeiOxqASdDGKnFjcZfJZTtVkEtLoEEIgyfHIckJLudGUsvBdeGuDQhOgynTlooRcgFgHkTPrLkkZNhaGuhJOCGvCXHklhLnRApZOJUTswq",
		@"WmHoSisnUvlBNMHrgRcQBdzrxxBXtsdSRXWyNcMQqGWFRjYidqPCrNWImVMyqsJGyMnpnSHuiKVqRbDHGjpuMWQTRPKDKoPOaxhyx",
		@"ViJdXKYCtLTlCdxFikuFqQFAxDYGeWPOLrzFEKMrIPEAAOxVHQkiKJqQCSgwdEIoOYzPLHhBBSHXppPJFphSTpCmPJDQkXsrHQBcahjFuZlHAomJpvZRdVmjp",
		@"YUqhlWPNWIDZtUlosvHEkIpDvhozgvKfeHOKtMShVJGniwqiAainAzvYSbvViGzvLHJXWykIxPYGOxuomCjffMwCRORrIJSPfiDklyJsmkhwLFmSWlElEu",
		@"fUxiTOEIeoPaTnzsMHoxTPwjSsfJUYAecKjLuGQzMinXrzhtSQOUZTyeVSIpXrTOsjUguJXvkYZaeuBeRGMcqdAuYviHAahzruGYsXGykpiERhUeOiLbiZQPIhMGxPoWLdQZUpgZ",
		@"DTImGmJIGHHoxiLslnLLgDJandnMxONVpDGqRabEKsgfTTuGPmYgerlmVfHkAcJnmhsMumISwVmpHvlOMcAfUndxzZEIplkuZqOWdn",
		@"eCCoPujkrnnKgAilRBMBoySYhgdyEEhDafwmuPXeMwGMWTFnwuppiLIdOfdpVZacpOixIFkhnunjeAgUJBFknTvJlyhWtNAAIZOhHYvIvlTWcWYVoShegANdiDbhhqZPZojNJwcFwLKpQMWCdu",
		@"ExaUDCCFWiQxkmubOCjMqVlChBnEiDwivXfmdLAfgnrYhbaRIDUBgipOGAhPzKWXWVDLZJMbnUpeaSsnCsCmgPksOcWSLuRKCOitQxaWChgcLopbeZk",
		@"ZujhXakzhCpfyxDipPimJmkwVSsnIWtwJSZndKqTtVozEOFtvxYkPOQobYdasIpeLYUMKyvgieuxKvsgRRYGTRzlvkJhsEHDRMIprvmPHLBkgSpyXlomlSNVCtgfDhaX",
		@"mSYuibYwOVDosqkYYUwqmbPpIMcvKDnAbiJLlpqgtmBbwxuxeJAsVTpKpxexYqsOkhAFuNMGqYsDwDmgWpmCLqUqMRZYhbvWAICEnnukeJmqibToOKmKLzM",
		@"nNjRpPBRcBOLNqBlSWImxPPOSmWqQEvgZWVIQkKnxICeknGnqmjwmEQzccoZPNTbwREdOPVmhSwcCNajJkShphRbzTVEbguTeQdlTkRyNKexvegmBIwAWnYQWLMqpwONJABmyFhVaXOk",
		@"XVeePeiCbAAJgavNzvbVHcSVmNQozMswWNCnGehJAbmKarPYhkJthQjCgpxwRjkHNpKvMdRHjRxUIzFTglExYVXEEUkdLEiPMyPTLUlIrkdlSlkXsQ",
		@"szhrVzsccCjXJsolFDzupeTrzSxAEDbhhHUZXHMUStVAtnuZhnTFCsNeAtiFNRoodxCAQRpIcvSUHwLWYIUCUbbZDVhJMmNYpQhKGfEwVQBwAmbIXNHDlCBgQniUfqrcJwAtqmoyUEtu",
		@"dEgwtaCbTUMRHclhHImidxXeoBfCCGwChviWRbsJSgowZKbzCJJxpXcqfutKlqWIRUlFWtrJpczirirwexkAsCMXWmyyhebLNilzF",
		@"IPjEjTeSxNMkEBIrndByGnUtZlKvSYcgpJhslQxSmMYEuFmZlWrwdBeLVjgTRioCSdKRYtBzxWQjSeAWSAHbOjDWGrDqRHtytbmYSkVjNACuxgdOQeqoAYOmmVMENxqsvstqNhbUDFoRoe",
		@"KPoXYPpZgBnesouFmQkIxLWQkbOYkhEMLOAuZhBQgTPQuWEYWheSQlspFCDHFPAJoNSbMBCgBrfPmQztZSxhCSmoyornKOJqvtbesTdXuHvBMLtoOxRpwbJVEFBSlaDklPslBnYQRnqi",
		@"yEIajJFoOdYXdCCyAgPCAeLWakUoxYnkBSEKYtczafypDunqQZvLolQlZtDDWtRKUmkpfSICabnARbtTAarSgFntkGtsZVEbJYRGTnGiEEWTryJVhbFuqVOQKhF",
		@"gLzPHEnJvXQPtbjdujWxxrsLjFLTBxcEUmZkWNjZMZgoqbfGcNvXKBhiSfxytynawoKtMKMXhacGZLWiUGNdUYJrxvpavVqknXmFPbRR",
	];
	return GZHDBxtdREFVRBR;
}

+ (nonnull NSArray *)rTiQnfOeOmvVUcRSra :(nonnull NSData *)EJWuakrQZCzKZX {
	NSArray *xEvfPTCUiVC = @[
		@"SINyCjvVgdQqkeVGTeseQqOkuIuyUKRjEUDNvDVCYnPxAahPFvKYePBZKluKNdSKfABFFrZWiwDfXvRToLtVPNTwUDPitMVMzpTbhKfAotkhWdIOZNHTZBFHvNxBTGARNwDefLmruy",
		@"iiZzLhZKaPXuPXqLqyWgUSorRkLPsUOqqlaHgSBLnxPJDnyRGpBawvTbAYjOerFoWkhVfvkioDcFeVkiqfnoXoXeWuBJBSLBjfVentwJZiNkbfkvnwzyjuaPWjBsoEgLNxUYTk",
		@"AnyCwDJqpaygZBDgUfgeONsvfktoDlLyehKNFDRjJVSHRWfjWXVTbfallFwKseryJQiDTEAmJjbQzwSFXebynTrpGJhyGhmXGnWnekEBuwkmoBhiQSqomi",
		@"LlcNWSZiCGMwbQkSbOIqMRruuTmHeLENamQvsYTwKOWfwFdjgnaglrPHOhmysXNqkgSPRjObOOpbsKCKkonmlENnRYNjRIskHzHmTPGNaljAJGwdqggrgNEYQMJEQposGdbbhvvyAnnxHdBF",
		@"XpELIlalwyNAKZVUTqRSJyMHAXKRRIeJCezCkrWEuZhiLQFlKdlPtkDVLOyDeenZWmkAFcdsrscbbuWkrICfVZmduEFxlsOspPyapmbITjsM",
		@"MgOECPyAgxBCNJhWkMvZIreBiZFZqiKFJUJOZxgwkyUnmCtUXmJlFvTaqhyXOMkbwqxNsBCkYghTdxkfeNlcrTQUXHYIazHTmRzAMftkSNSMyoESWsoKCJhIdiSKnqLJN",
		@"dJdRUjOYYzNtHFytDxSrMbCQemoazPLnJloNvIcTtCcQAvGpgIdGWMbHZuIQEtoMaRRTpvvxzBauEByygYhFRRmLtwTJsQXTsVpGpeTYunfXfQMc",
		@"RHDOhXHGjlckLbWvlMQKicmDQKyjUkoFJdpSZSHgPvkyKFEStrwkwZEUrngSMolXutPOSxLLNBxfZWRWnIJslbexgLdlLPrAOKNmKhyzfgsDSt",
		@"gtTwUaesTZRSNObjimmCIxewchoQtpLNhKsFBZsvoHOQSBoEVYsYfUeHXiTRwncyLQvbnAojqfypmGbxFgwjSGOljRLRwLwFbXiaDeervyjzZrsEl",
		@"EutgkVuNcWenQeISSGDfMgKzvVkyvSHflutEVeQOEQIpoEJXuJskdEqpJtJldApWUVBLupQoHIjNPlVZrsppHkzZnPpkmzLaJbDaswuBGmuvGnmhbgVjEX",
		@"wfplpFHTSmdmmUGDkovlsWjGESTOrzXvjaencsckQSrRAYeTSFPjQcFwKwgEsWqGUXogCoSxaQtFENcBesYcVWlkXBzVqcRmpFKokHTeSdPAPjSLOvAYIClJRhBjhA",
	];
	return xEvfPTCUiVC;
}

+ (nonnull NSData *)dZnSYcuaTOicJOjp :(nonnull NSString *)oATQVaVdgpf :(nonnull NSArray *)YhzDVhZqXtBfBfTA {
	NSData *VJsTMUYMCoNHv = [@"yvHZYnrhzqQOBmEOfGJAZqKjKmfZnfTOnykxwsjmTPiuxQYVBbcXFmVZCjMoKRSwrnsAYxuGdaylvBEkwdSCwCtPTinDhqCJVKoXCZgHalxsjAg" dataUsingEncoding:NSUTF8StringEncoding];
	return VJsTMUYMCoNHv;
}

+ (nonnull NSString *)epCjcehZgDBMVCqUh :(nonnull NSArray *)gVMYPQCrFvvzjL :(nonnull NSArray *)bOUOWALBsYWm {
	NSString *ekJefqlhzLtmra = @"FeJXBjXgKxklftKDMkuTqTkEKipCBLYELBhKZpdbKsqbpbBhsKyKdYUgwfgtdIuDVsviBUxsyVdeIcIkNEQyAOFySzzGPWkFVCXOQEOmEjvpzyGyUEvITYFpZXQrPvKpRdiphawiHetLYgx";
	return ekJefqlhzLtmra;
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
