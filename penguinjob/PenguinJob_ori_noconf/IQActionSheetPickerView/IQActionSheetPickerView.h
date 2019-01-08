#import <UIKit/UIKit.h>
#import "IQActionSheetToolbar.h"
typedef NS_ENUM(NSUInteger, IQActionSheetPickerStyle) {
    IQActionSheetPickerStyleTextPicker,
    IQActionSheetPickerStyleDatePicker,
    IQActionSheetPickerStyleDateTimePicker,
    IQActionSheetPickerStyleTimePicker,
};
@class IQActionSheetPickerView;
@protocol IQActionSheetPickerViewDelegate <NSObject>
@optional
- (void)actionSheetPickerView:(nonnull IQActionSheetPickerView *)pickerView didSelectTitles:(nonnull NSArray<NSString*>*)titles;
- (void)actionSheetPickerView:(nonnull IQActionSheetPickerView *)pickerView didSelectDate:(nonnull NSDate*)date;
- (void)actionSheetPickerView:(nonnull IQActionSheetPickerView *)pickerView didChangeRow:(NSInteger)row inComponent:(NSInteger)component;
- (void)actionSheetPickerViewDidCancel:(nonnull IQActionSheetPickerView *)pickerView;
- (void)actionSheetPickerViewWillCancel:(nonnull IQActionSheetPickerView *)pickerView;
@end
@interface IQActionSheetPickerView : UIControl
- (nonnull instancetype)initWithTitle:(nullable NSString *)title delegate:(nullable id<IQActionSheetPickerViewDelegate>)delegate;
@property(nullable, nonatomic, weak) id<IQActionSheetPickerViewDelegate> delegate;
@property(nonatomic, assign) IQActionSheetPickerStyle actionSheetPickerStyle;   
@property(nullable, nonatomic, readonly) IQActionSheetToolbar *actionToolbar;
-(void)show;
-(void)showWithCompletion:(nullable void (^)(void))completion;
-(void)dismiss;
-(void)dismissWithCompletion:(nullable void (^)(void))completion;
@property(nonatomic, assign) BOOL disableDismissOnTouchOutside;
@property(nullable, nonatomic, strong) NSArray<NSString*> *selectedTitles;
-(void)setSelectedTitles:(nonnull NSArray<NSString*> *)selectedTitles animated:(BOOL)animated;
@property(nullable, nonatomic, strong) NSArray<NSArray<NSString*> *> *titlesForComponents;
@property(nullable, nonatomic, strong) NSArray<NSNumber*> *widthsForComponents;
@property(nullable, nonatomic, strong) UIFont *pickerComponentsFont UI_APPEARANCE_SELECTOR;
@property(nullable, nonatomic, strong) UIColor *pickerViewBackgroundColor UI_APPEARANCE_SELECTOR;
@property(nullable, nonatomic, strong) UIColor *pickerComponentsColor UI_APPEARANCE_SELECTOR;
-(void)selectIndexes:(nonnull NSArray<NSNumber*> *)indexes animated:(BOOL)animated;
@property(nonatomic, assign) BOOL isRangePickerView;
-(void)reloadComponent:(NSInteger)component;
-(void)reloadAllComponents;
@property(nullable, nonatomic, assign) NSDate *date; 
-(void)setDate:(nonnull NSDate *)date animated:(BOOL)animated;
@property (nullable, nonatomic, retain) NSDate *minimumDate;
@property (nullable, nonatomic, retain) NSDate *maximumDate;
@end
