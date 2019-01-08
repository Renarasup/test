#import <UIKit/UIKit.h>
@interface IQActionSheetTitleBarButtonItem : UIBarButtonItem
@property(nullable, nonatomic, strong) UIFont *titleFont UI_APPEARANCE_SELECTOR;
@property(nullable, nonatomic, strong) UIColor *titleColor UI_APPEARANCE_SELECTOR;
-(nonnull instancetype)initWithTitle:(nullable NSString *)title NS_DESIGNATED_INITIALIZER;
-(nonnull instancetype)init NS_UNAVAILABLE;
-(nonnull instancetype)initWithCoder:(nullable NSCoder *)aDecoder NS_UNAVAILABLE;
+ (nonnull instancetype)new NS_UNAVAILABLE;
@end
