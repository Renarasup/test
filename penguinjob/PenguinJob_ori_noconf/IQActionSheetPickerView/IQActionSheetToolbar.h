#import <UIKit/UIKit.h>
#import "IQActionSheetTitleBarButtonItem.h"
extern NSString * _Nonnull const kIQActionSheetAttributesForNormalStateKey;
extern NSString * _Nonnull const kIQActionSheetAttributesForHighlightedStateKey;
@interface IQActionSheetToolbar : UIToolbar <UIInputViewAudioFeedback>
@property(nullable, nonatomic, strong) UIBarButtonItem *cancelButton;
@property(nullable, nonatomic, strong) NSDictionary<NSString*,id> *cancelButtonAttributes UI_APPEARANCE_SELECTOR;
@property(nullable, nonatomic, strong) IQActionSheetTitleBarButtonItem *titleButton;
@property(nullable, nonatomic, strong) UIBarButtonItem *doneButton;
@property(nullable, nonatomic, strong) NSDictionary<NSString*,id> *doneButtonAttributes UI_APPEARANCE_SELECTOR;
@end
