#import "IQActionSheetPickerView.h"
#import <QuartzCore/QuartzCore.h>
#import "IQActionSheetViewController.h"
#import "IQActionSheetToolbar.h"
@interface IQActionSheetPickerView ()<UIPickerViewDataSource,UIPickerViewDelegate>
{
    UIPickerView    *_pickerView;
    UIDatePicker    *_datePicker;
}
@property(nonatomic, strong) IQActionSheetViewController *actionSheetController;
@end
@implementation IQActionSheetPickerView
@synthesize actionSheetPickerStyle  = _actionSheetPickerStyle;
@synthesize titlesForComponents     = _titlesForComponents;
@synthesize widthsForComponents     = _widthsForComponents;
@synthesize isRangePickerView       = _isRangePickerView;
@synthesize delegate                = _delegate;
@synthesize date                    = _date;
-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
- (instancetype)initWithTitle:(NSString *)title delegate:(id<IQActionSheetPickerViewDelegate>)delegate
{
    CGRect rect = [[UIScreen mainScreen] bounds];
    rect.size.height = 216+44;
    self = [super initWithFrame:rect];
    if (self)
    {
        {
            _actionToolbar = [[IQActionSheetToolbar alloc] initWithFrame:CGRectMake(0, 0, rect.size.width, 44)];
            _actionToolbar.barStyle = UIBarStyleBlackTranslucent;
            _actionToolbar.cancelButton.target = self;
            _actionToolbar.cancelButton.action = @selector(pickerCancelClicked:);
            _actionToolbar.doneButton.target = self;
            _actionToolbar.doneButton.action = @selector(pickerDoneClicked:);
            _actionToolbar.titleButton.title = title;
            [self addSubview:_actionToolbar];
        }
        {
            _pickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_actionToolbar.frame) , CGRectGetWidth(_actionToolbar.frame), 216)];
            _pickerView.backgroundColor = [UIColor whiteColor];
            [_pickerView setShowsSelectionIndicator:YES];
            [_pickerView setDelegate:self];
            [_pickerView setDataSource:self];
            [self addSubview:_pickerView];
        }
        {
            _datePicker = [[UIDatePicker alloc] initWithFrame:_pickerView.frame];
            [_datePicker addTarget:self action:@selector(dateChanged:) forControlEvents:UIControlEventValueChanged];
            _datePicker.frame = _pickerView.frame;
            [_datePicker setDatePickerMode:UIDatePickerModeDate];
            [self addSubview:_datePicker];
        }
        {
            self.backgroundColor = [UIColor lightGrayColor];
            [self setFrame:CGRectMake(0, 0, CGRectGetWidth(_pickerView.frame), CGRectGetMaxY(_pickerView.frame))];
            [self setActionSheetPickerStyle:IQActionSheetPickerStyleTextPicker];
            self.autoresizingMask = UIViewAutoresizingFlexibleTopMargin|UIViewAutoresizingFlexibleWidth;
            _actionToolbar.autoresizingMask = UIViewAutoresizingFlexibleWidth;
            _pickerView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
            _datePicker.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        }
    }
    _delegate = delegate;
    return self;
}
-(void)setActionSheetPickerStyle:(IQActionSheetPickerStyle)actionSheetPickerStyle
{
    _actionSheetPickerStyle = actionSheetPickerStyle;
    switch (actionSheetPickerStyle) {
        case IQActionSheetPickerStyleTextPicker:
            [_pickerView setHidden:NO];
            [_datePicker setHidden:YES];
            break;
        case IQActionSheetPickerStyleDatePicker:
            [_pickerView setHidden:YES];
            [_datePicker setHidden:NO];
            [_datePicker setDatePickerMode:UIDatePickerModeDate];
            break;
        case IQActionSheetPickerStyleDateTimePicker:
            [_pickerView setHidden:YES];
            [_datePicker setHidden:NO];
            [_datePicker setDatePickerMode:UIDatePickerModeDateAndTime];
            break;
        case IQActionSheetPickerStyleTimePicker:
            [_pickerView setHidden:YES];
            [_datePicker setHidden:NO];
            [_datePicker setDatePickerMode:UIDatePickerModeTime];
            break;
        default:
            break;
    }
}
-(void)setPickerViewBackgroundColor:(UIColor *)pickerViewBackgroundColor{
  _pickerView.backgroundColor = pickerViewBackgroundColor;
}
#pragma mark - Done/Cancel
-(void)pickerCancelClicked:(UIBarButtonItem*)barButton
{
    if ([self.delegate respondsToSelector:@selector(actionSheetPickerViewWillCancel:)])
    {
        [self.delegate actionSheetPickerViewWillCancel:self];
    }
    [self dismissWithCompletion:^{
        if ([self.delegate respondsToSelector:@selector(actionSheetPickerViewDidCancel:)])
        {
            [self.delegate actionSheetPickerViewDidCancel:self];
        }
    }];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"position" object:nil];
}
-(void)pickerDoneClicked:(UIBarButtonItem*)barButton
{
    switch (_actionSheetPickerStyle)
    {
        case IQActionSheetPickerStyleTextPicker:
        {
            NSMutableArray *selectedTitles = [[NSMutableArray alloc] init];
            for (NSInteger component = 0; component<_pickerView.numberOfComponents; component++)
            {
                NSInteger row = [_pickerView selectedRowInComponent:component];
                if (row!= -1)
                {
                    [selectedTitles addObject:_titlesForComponents[component][row]];
                }
                else
                {
                    [selectedTitles addObject:[NSNull null]];
                }
            }
            [self setSelectedTitles:selectedTitles];
            if ([self.delegate respondsToSelector:@selector(actionSheetPickerView:didSelectTitles:)])
            {
                [self.delegate actionSheetPickerView:self didSelectTitles:selectedTitles];
            }
        }
            break;
        case IQActionSheetPickerStyleDatePicker:
        case IQActionSheetPickerStyleDateTimePicker:
        case IQActionSheetPickerStyleTimePicker:
        {
            [self setDate:_datePicker.date];
            [self setSelectedTitles:@[_datePicker.date]];
            if ([self.delegate respondsToSelector:@selector(actionSheetPickerView:didSelectDate:)])
            {
                [self.delegate actionSheetPickerView:self didSelectDate:_datePicker.date];
            }
        }
        default:
            break;
    }
    [self dismiss];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"position" object:nil];
}
#pragma mark - IQActionSheetPickerStyleDatePicker / IQActionSheetPickerStyleDateTimePicker / IQActionSheetPickerStyleTimePicker
-(void)dateChanged:(UIDatePicker*)datePicker
{
    [self sendActionsForControlEvents:UIControlEventValueChanged];
}
-(void) setDate:(NSDate *)date
{
    [self setDate:date animated:NO];
}
-(void)setDate:(NSDate *)date animated:(BOOL)animated
{
    _date = date;
    if (_date != nil)   [_datePicker setDate:_date animated:animated];
}
-(void)setMinimumDate:(NSDate *)minimumDate
{
    _minimumDate = minimumDate;
    _datePicker.minimumDate = minimumDate;
}
-(void)setMaximumDate:(NSDate *)maximumDate
{
    _maximumDate = maximumDate;
    _datePicker.maximumDate = maximumDate;
}
#pragma mark - IQActionSheetPickerStyleTextPicker
-(void)reloadComponent:(NSInteger)component
{
    [_pickerView reloadComponent:component];
}
-(void)reloadAllComponents
{
    [_pickerView reloadAllComponents];
}
-(void)setSelectedTitles:(NSArray *)selectedTitles
{
    [self setSelectedTitles:selectedTitles animated:NO];
}
-(NSArray *)selectedTitles
{
    if (_actionSheetPickerStyle == IQActionSheetPickerStyleTextPicker)
    {
        NSMutableArray *selectedTitles = [[NSMutableArray alloc] init];
        NSUInteger totalComponent = _pickerView.numberOfComponents;
        for (NSInteger component = 0; component<totalComponent; component++)
        {
            NSInteger selectedRow = [_pickerView selectedRowInComponent:component];
            if (selectedRow == -1)
            {
                [selectedTitles addObject:[NSNull null]];
            }
            else
            {
                NSArray *items = _titlesForComponents[component];
                if ([items count] > selectedRow)
                {
                    id selectTitle = items[selectedRow];
                    [selectedTitles addObject:selectTitle];
                }
                else
                {
                    [selectedTitles addObject:[NSNull null]];
                }
            }
        }
        return selectedTitles;
    }
    else
    {
        return nil;
    }
}
-(void)setSelectedTitles:(NSArray *)selectedTitles animated:(BOOL)animated
{
    if (_actionSheetPickerStyle == IQActionSheetPickerStyleTextPicker)
    {
        NSUInteger totalComponent = MIN(selectedTitles.count, _pickerView.numberOfComponents);
        for (NSInteger component = 0; component<totalComponent; component++)
        {
            NSArray *items = _titlesForComponents[component];
            id selectTitle = selectedTitles[component];
            if ([items containsObject:selectTitle])
            {
                NSUInteger rowIndex = [items indexOfObject:selectTitle];
                [_pickerView selectRow:rowIndex inComponent:component animated:animated];
            }
        }
    }
}
-(void)selectIndexes:(NSArray *)indexes animated:(BOOL)animated
{
    if (_actionSheetPickerStyle == IQActionSheetPickerStyleTextPicker)
    {
        NSUInteger totalComponent = MIN(indexes.count, _pickerView.numberOfComponents);
        for (NSInteger component = 0; component<totalComponent; component++)
        {
            NSArray *items = _titlesForComponents[component];
            NSUInteger selectIndex = [indexes[component] unsignedIntegerValue];
            if (selectIndex < items.count)
            {
                [_pickerView selectRow:selectIndex inComponent:component animated:animated];
            }
        }
    }
}
#pragma mark - UIPickerView delegate/dataSource
- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component
{
    if (_widthsForComponents)
    {
        CGFloat width = [_widthsForComponents[component] floatValue];
        if (width <= 0)
            return ((pickerView.bounds.size.width-20)-2*(_titlesForComponents.count-1))/_titlesForComponents.count;
        else
            return width;
    }
    else
    {
        return ((pickerView.bounds.size.width-20)-2*(_titlesForComponents.count-1))/_titlesForComponents.count;
    }
}
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return [_titlesForComponents count];
}
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return [_titlesForComponents[component] count];
}
-(UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view
{
    UILabel *labelText = [[UILabel alloc] init];
    if(self.pickerComponentsColor != nil) {
      labelText.textColor = self.pickerComponentsColor;
    }
    if(self.pickerComponentsFont == nil){
        labelText.font = [UIFont boldSystemFontOfSize:20.0];
    }else{
        labelText.font = self.pickerComponentsFont;
    }
    labelText.backgroundColor = [UIColor clearColor];
    [labelText setTextAlignment:NSTextAlignmentCenter];
    [labelText setText:_titlesForComponents[component][row]];
    return labelText;
}
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    if (_isRangePickerView && pickerView.numberOfComponents == 3)
    {
        if (component == 0)
        {
            [pickerView selectRow:MAX([pickerView selectedRowInComponent:2], row) inComponent:2 animated:YES];
        }
        else if (component == 2)
        {
            [pickerView selectRow:MIN([pickerView selectedRowInComponent:0], row) inComponent:0 animated:YES];
        }
    }
    [self sendActionsForControlEvents:UIControlEventValueChanged];
    if ([self.delegate respondsToSelector:@selector(actionSheetPickerView:didChangeRow:inComponent:)]) {
        [self.delegate actionSheetPickerView:self didChangeRow:row inComponent:component];
    }
}
#pragma mark - show/Hide
-(void)dismiss
{
    [_actionSheetController dismissWithCompletion:nil];
    _actionSheetController = nil;
}
-(void)dismissWithCompletion:(void (^)(void))completion
{
    [_actionSheetController dismissWithCompletion:completion];
    _actionSheetController = nil;
}
-(void)setDisableDismissOnTouchOutside:(BOOL)disableDismissOnTouchOutside
{
    _disableDismissOnTouchOutside = disableDismissOnTouchOutside;
    _actionSheetController.disableDismissOnTouchOutside = _disableDismissOnTouchOutside;
}
-(void)show
{
    [self showWithCompletion:nil];
}
-(void)showWithCompletion:(void (^)(void))completion
{
    [_pickerView reloadAllComponents];
    if (_actionSheetController == nil)
    {
        _actionSheetController = [[IQActionSheetViewController alloc] init];
        _actionSheetController.disableDismissOnTouchOutside = self.disableDismissOnTouchOutside;
        [_actionSheetController showPickerView:self completion:completion];
    }
}
@end
