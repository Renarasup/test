#import <UIKit/UIKit.h>
#import "HexColors.h"
typedef NS_ENUM(NSInteger, SLPickerViewType) {
    SLNumbersPickerView,
    SLTextPickerView,
};
@interface SLPickerView : UIView
- (id)initWithFrame:(CGRect)frame withValues:(NSMutableArray *)values withPickerView:(SLPickerViewType)pickerType;
- (id)initWithFrame:(CGRect)frame withMaxValue:(int)maxValue withMinValue:(int)minValue;
+ (void)showNumericalPickerViewWithMaxValue:(int)maxValue
                               withMinValue:(int)minValue
                            withPreSelected:(int)preSelected
                            completionBlock:(void (^)(int selectedValue))completionBlock;
+ (void)showNumericalPickerViewWithMaxValue:(int)maxValue
                               withMinValue:(int)minValue
                            completionBlock:(void (^)(int selectedValue))completionBlock;
+ (void)showNumericalPickerViewWithValues:(NSMutableArray *)values
                          completionBlock:(void (^)(int selectedValue))completionBlock;
+ (void)showNumericalPickerViewWithValues:(NSMutableArray *)values
                          withPreSelected:(int)preSelected
                          completionBlock:(void (^)(int selectedValue))completionBlock;
+ (void)showTextPickerViewWithValues:(NSMutableArray *)values
                     completionBlock:(void (^)(NSString *selectedValue))completionBlock;
+ (void)showTextPickerViewWithValues:(NSMutableArray *)values
                        withSelected:(NSString *)selected
                     completionBlock:(void (^)(NSString *selectedValue))completionBlock;
@end
