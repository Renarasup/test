#import "IQActionSheetTitleBarButtonItem.h"
@implementation IQActionSheetTitleBarButtonItem
{
    UIView *_titleView;
    UIButton *_titleButton;
}
@synthesize titleFont = _titleFont;
-(nonnull instancetype)initWithTitle:(nullable NSString *)title
{
    self = [super init];
    if (self)
    {
        _titleView = [[UIView alloc] init];
        _titleView.backgroundColor = [UIColor clearColor];
        _titleButton = [UIButton buttonWithType:UIButtonTypeSystem];
        _titleButton.enabled = NO;
        _titleButton.titleLabel.numberOfLines = 3;
        [_titleButton setTitleColor:[UIColor colorWithRed:0.0 green:0.5 blue:1.0 alpha:1.0] forState:UIControlStateNormal];
        [_titleButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateDisabled];
        [_titleButton setBackgroundColor:[UIColor clearColor]];
        [_titleButton.titleLabel setTextAlignment:NSTextAlignmentCenter];
        [self setTitle:title];
        [self setTitleFont:[UIFont systemFontOfSize:13.0]];
        [_titleView addSubview:_titleButton];
        if ([[NSProcessInfo processInfo] operatingSystemVersion].majorVersion >= 11)
        {
            _titleView.translatesAutoresizingMaskIntoConstraints = NO;
            [_titleView setContentHuggingPriority:UILayoutPriorityDefaultLow-1 forAxis:UILayoutConstraintAxisVertical];
            [_titleView setContentHuggingPriority:UILayoutPriorityDefaultLow-1 forAxis:UILayoutConstraintAxisHorizontal];
            [_titleView setContentCompressionResistancePriority:UILayoutPriorityDefaultHigh-1 forAxis:UILayoutConstraintAxisVertical];
            [_titleView setContentCompressionResistancePriority:UILayoutPriorityDefaultHigh-1 forAxis:UILayoutConstraintAxisHorizontal];
            _titleButton.translatesAutoresizingMaskIntoConstraints = NO;
            [_titleButton setContentHuggingPriority:UILayoutPriorityDefaultLow-1 forAxis:UILayoutConstraintAxisVertical];
            [_titleButton setContentHuggingPriority:UILayoutPriorityDefaultLow-1 forAxis:UILayoutConstraintAxisHorizontal];
            [_titleButton setContentCompressionResistancePriority:UILayoutPriorityDefaultHigh-1 forAxis:UILayoutConstraintAxisVertical];
            [_titleButton setContentCompressionResistancePriority:UILayoutPriorityDefaultHigh-1 forAxis:UILayoutConstraintAxisHorizontal];
            NSLayoutConstraint *top = [NSLayoutConstraint constraintWithItem:_titleButton attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:_titleView attribute:NSLayoutAttributeTop multiplier:1 constant:0];
            NSLayoutConstraint *bottom = [NSLayoutConstraint constraintWithItem:_titleButton attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:_titleView attribute:NSLayoutAttributeBottom multiplier:1 constant:0];
            NSLayoutConstraint *leading = [NSLayoutConstraint constraintWithItem:_titleButton attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:_titleView attribute:NSLayoutAttributeLeading multiplier:1 constant:0];
            NSLayoutConstraint *trailing = [NSLayoutConstraint constraintWithItem:_titleButton attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:_titleView attribute:NSLayoutAttributeTrailing multiplier:1 constant:0];
            [_titleView addConstraints:@[top,bottom,leading,trailing]];
        }
        else
        {
            _titleView.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
            _titleButton.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
        }
        self.customView = _titleView;
    }
    return self;
}
-(void)setTitleFont:(UIFont *)titleFont
{
    _titleFont = titleFont;
    if (titleFont)
    {
        _titleButton.titleLabel.font = titleFont;
    }
    else
    {
        _titleButton.titleLabel.font = [UIFont systemFontOfSize:13];
    }
}
-(void)setTitleColor:(UIColor *)titleColor
{
    _titleColor = titleColor;
    if (titleColor)
    {
        [_titleButton setTitleColor:titleColor forState:UIControlStateDisabled];
    }
    else
    {
        [_titleButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateDisabled];
    }
}
-(void)setTitle:(NSString *)title
{
    [super setTitle:title];
    [_titleButton setTitle:title forState:UIControlStateNormal];
}
@end
