#import <UIKit/UIKit.h>
@class IQActionSheetPickerView;
@interface IQActionSheetViewController : UIViewController
@property(nonnull, nonatomic, strong, readonly) IQActionSheetPickerView *pickerView;
@property(nonatomic, assign) BOOL disableDismissOnTouchOutside;
-(void)showPickerView:(nonnull IQActionSheetPickerView*)pickerView completion:(nullable void (^)(void))completion;
-(void)dismissWithCompletion:(nullable void (^)(void))completion;
@end
