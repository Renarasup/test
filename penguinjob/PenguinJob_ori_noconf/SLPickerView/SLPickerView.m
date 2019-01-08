#import "SLPickerView.h"
@interface SLPickerView () <UIPickerViewDelegate, UIPickerViewDataSource>
@property (nonatomic, copy) void (^completionNumberBlock)(int);
@property (nonatomic, copy) void (^completionTextBlock)(NSString *);
@property (nonatomic, assign) int maxValue;
@property (nonatomic, assign) int minValue;
@property (nonatomic, strong) UIView *transparentView; 
@property (nonatomic, strong) UIPickerView *pickerView;
@property (nonatomic, strong) UIButton *doneButton;
@property (nonatomic, strong) UITapGestureRecognizer *tapGestureRecognizer;
@property (nonatomic, strong) NSMutableArray *valuesArray;
@property (nonatomic, assign) int valueSelected;
@property (nonatomic, strong) NSString *textSelected;
@property (nonatomic, assign) SLPickerViewType pickerType;
@end
@implementation SLPickerView
#pragma mark - Initialize methods
+ (void)showNumericalPickerViewWithMaxValue:(int)maxValue
                               withMinValue:(int)minValue
                            withPreSelected:(int)preSelected
                            completionBlock:(void (^)(int selectedValue))completionBlock
{
    SLPickerView *view = [[SLPickerView alloc] initWithFrame:[UIScreen mainScreen].bounds withMaxValue:maxValue withMinValue:minValue];
    view.completionNumberBlock = completionBlock;
    [view.pickerView selectRow:preSelected - minValue inComponent:0 animated:NO];
    [view show];
    [view showNumericalPicker];
}
+ (void)showNumericalPickerViewWithMaxValue:(int)maxValue withMinValue:(int)minValue completionBlock:(void (^)(int selectedValue))completionBlock
{
    SLPickerView *view = [[SLPickerView alloc] initWithFrame:[UIScreen mainScreen].bounds withMaxValue:maxValue withMinValue:minValue];
    view.completionNumberBlock = completionBlock;
    [view show];
    [view showNumericalPicker];
}
+ (void)showNumericalPickerViewWithValues:(NSMutableArray *)values completionBlock:(void (^)(int selectedValue))completionBlock
{
    SLPickerView *view = [[SLPickerView alloc] initWithFrame:[UIScreen mainScreen].bounds withValues:values withPickerView:SLNumbersPickerView];
    view.completionNumberBlock = completionBlock;
    [view show];
    [view showNumericalPicker];
}
+ (void)showNumericalPickerViewWithValues:(NSMutableArray *)values withPreSelected:(int)preSelected completionBlock:(void (^)(int selectedValue))completionBlock
{
    SLPickerView *view = [[SLPickerView alloc] initWithFrame:[UIScreen mainScreen].bounds withValues:values withPickerView:SLNumbersPickerView];
    view.completionNumberBlock = completionBlock;
    [view.pickerView selectRow:[values indexOfObject:@(preSelected)] inComponent:0 animated:NO];
    [view show];
    [view showNumericalPicker];
}
+ (void)showTextPickerViewWithValues:(NSMutableArray *)values completionBlock:(void (^)(NSString *selectedValue))completionBlock
{
    SLPickerView *view = [[SLPickerView alloc] initWithFrame:[UIScreen mainScreen].bounds withValues:values withPickerView:SLTextPickerView];
    view.completionTextBlock = completionBlock;
    [view show];
    [view showNumericalPicker];
}
+ (void)showTextPickerViewWithValues:(NSMutableArray *)values withSelected:(NSString *)selected completionBlock:(void (^)(NSString *selectedValue))completionBlock
{
    SLPickerView *view = [[SLPickerView alloc] initWithFrame:[UIScreen mainScreen].bounds withValues:values withPickerView:SLTextPickerView];
    view.completionTextBlock = completionBlock;
    [view.pickerView selectRow:[values indexOfObject:selected] inComponent:0 animated:NO];
    [view show];
    [view showNumericalPicker];
}
- (id)initWithFrame:(CGRect)frame withValues:(NSMutableArray *)values withPickerView:(SLPickerViewType)pickerType
{
    self = [self initWithFrame:frame];
    if (self) {
        self.pickerType = pickerType;
        self.valuesArray = values;
    }
    [_pickerView reloadAllComponents];
    return self;
}
- (id)initWithFrame:(CGRect)frame withMaxValue:(int)maxValue withMinValue:(int)minValue
{
    self = [self initWithFrame:frame];
    if (self) {
        self.pickerType = SLNumbersPickerView;
        self.maxValue = maxValue;
        self.minValue = minValue;
        self.valuesArray = [NSMutableArray array];
        for (int i = self.minValue; i <= self.maxValue; i++) {
            [self.valuesArray addObject:[NSNumber numberWithInt:i]];
        }
    }
    [_pickerView reloadAllComponents];
    return self;
}
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _transparentView = [[UIView alloc] initWithFrame:self.bounds];
        _transparentView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5];
        _transparentView.alpha = 0.0f;
        _transparentView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        [self addSubview:_transparentView];
        _tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissPicker)];
        [_transparentView addGestureRecognizer:_tapGestureRecognizer];
        _doneButton = [[UIButton alloc] initWithFrame:CGRectMake(0, self.bounds.size.height, self.bounds.size.width, 50)];
        _doneButton.backgroundColor = [UIColor colorWithHexString:@"#047EDE"];
        [_doneButton setTitle:NSLocalizedString(@"Done", @"") forState:UIControlStateNormal];
        [_doneButton addTarget:self action:@selector(dismissPicker) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_doneButton];
        _pickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, self.bounds.size.height + 40, self.bounds.size.width, 200)];
        _pickerView.delegate = self;
        _pickerView.dataSource = self;
        _pickerView.backgroundColor = [UIColor whiteColor];
        [self addSubview:_pickerView];
    }
    return self;
}
#pragma mark - Show and Dismiss methods for view
- (void)showNumericalPicker
{
    [UIView animateWithDuration:0.5
                     animations:^{
                         _transparentView.alpha = 0.5f;
                         _doneButton.frame = CGRectMake(0, self.bounds.size.height - _pickerView.frame.size.height - _doneButton.frame.size.height,
                                                        _doneButton.frame.size.width, _doneButton.frame.size.height);
                         _pickerView.frame = CGRectMake(0, self.bounds.size.height - _pickerView.frame.size.height,
                                                        _pickerView.frame.size.width, _pickerView.frame.size.height);
                     }];
}
- (void)show
{
    [[UIApplication sharedApplication].keyWindow addSubview:self];
}
- (void)dismissPicker
{
    if (self.pickerType == SLNumbersPickerView) {
        NSNumber *numberSelected = [self.valuesArray objectAtIndex:[_pickerView selectedRowInComponent:0]];
        self.valueSelected = [numberSelected intValue];
    } else {
        self.textSelected = [self.valuesArray objectAtIndex:[_pickerView selectedRowInComponent:0]];
    }
    [self dismiss];
}
- (void)dismiss
{
    [UIView animateWithDuration:0.5
                     animations:^{
                         _transparentView.alpha = 0.0f;
                         _doneButton.frame = CGRectMake(0, self.bounds.size.height, _doneButton.frame.size.width, _doneButton.frame.size.height);
                         _pickerView.frame = CGRectMake(0, self.bounds.size.height + 40, _pickerView.frame.size.width, _pickerView.frame.size.height);
                     } completion:^(BOOL finished) {
                         if (self.pickerType == SLNumbersPickerView) {
                             self.completionNumberBlock(self.valueSelected);
                         } else {
                             self.completionTextBlock(self.textSelected);
                         }
                         [self removeFromSuperview];
                     }];
}
#pragma mark - Picker view data source
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return self.valuesArray ? [self.valuesArray count] : 0;
}
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    if (self.valuesArray) {
        if (self.pickerType == SLTextPickerView) return [self.valuesArray objectAtIndex:row];
        NSNumber *numberRow = [self.valuesArray objectAtIndex:row];
        return [NSString stringWithFormat:@"%i", [numberRow intValue]];
    }
    return nil;
}
@end