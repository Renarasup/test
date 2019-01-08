#import "IQActionSheetToolbar.h"
#import "IQActionSheetTitleBarButtonItem.h"
NSString * const kIQActionSheetAttributesForNormalStateKey = @"kIQActionSheetAttributesForNormalStateKey";
NSString * const kIQActionSheetAttributesForHighlightedStateKey = @"kIQActionSheetAttributesForHighlightedStateKey";
@implementation IQActionSheetToolbar
+(void)initialize
{
    [super initialize];
    [[self appearance] setTintColor:nil];
    [[self appearance] setBarTintColor:nil];
    [[self appearance] setBackgroundImage:nil forToolbarPosition:UIBarPositionAny           barMetrics:UIBarMetricsDefault];
    [[self appearance] setBackgroundImage:nil forToolbarPosition:UIBarPositionBottom        barMetrics:UIBarMetricsDefault];
    [[self appearance] setBackgroundImage:nil forToolbarPosition:UIBarPositionTop           barMetrics:UIBarMetricsDefault];
    [[self appearance] setBackgroundImage:nil forToolbarPosition:UIBarPositionTopAttached   barMetrics:UIBarMetricsDefault];
    [[self appearance] setShadowImage:nil forToolbarPosition:UIBarPositionAny];
    [[self appearance] setShadowImage:nil forToolbarPosition:UIBarPositionBottom];
    [[self appearance] setShadowImage:nil forToolbarPosition:UIBarPositionTop];
    [[self appearance] setShadowImage:nil forToolbarPosition:UIBarPositionTopAttached];
    [[self appearance] setBackgroundColor:nil];
}
-(void)initialize
{
    [self sizeToFit];
    self.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    self.translucent = YES;
    [self setTintColor:[UIColor whiteColor]];
    _cancelButton = [[UIBarButtonItem alloc] initWithTitle:@"Cancel" style:UIBarButtonItemStylePlain target:nil action:nil];
    _titleButton =[[IQActionSheetTitleBarButtonItem alloc] initWithTitle:nil];
    _doneButton = [[UIBarButtonItem alloc] initWithTitle:@"     Done" style:UIBarButtonItemStylePlain target:nil action:nil];
    [self refreshToolbarItems];
}
-(void)refreshToolbarItems
{
    UIBarButtonItem *nilButton =[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    NSMutableArray *items = [[NSMutableArray alloc] init];
    if (self.cancelButton)
    {
        [items addObject:self.cancelButton];
    }
    if (self.titleButton)
    {
        [items addObject:nilButton];
        [items addObject:self.titleButton];
    }
    if (self.doneButton)
    {
        [items addObject:nilButton];
        [items addObject:self.doneButton];
    }
    if ([[NSProcessInfo processInfo] operatingSystemVersion].majorVersion < 11)
    {
        _titleButton.customView.frame = CGRectZero;
    }
    [self setItems:@[self.doneButton]];
}
-(void)setCancelButton:(UIBarButtonItem *)cancelButton
{
    _cancelButton = cancelButton;
    _cancelButton.accessibilityLabel = @"Action Sheet Cancel Button";
    [self refreshToolbarItems];
}
-(void)setTitleButton:(IQActionSheetTitleBarButtonItem *)titleButton
{
    _titleButton = titleButton;
    _titleButton.accessibilityLabel = @"Action Sheet Title Button";
    [self refreshToolbarItems];
}
-(void)setDoneButton:(UIBarButtonItem *)doneButton
{
    _doneButton = doneButton;
    _doneButton.accessibilityLabel = @"Action Sheet Done Button";
    [self refreshToolbarItems];
}
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        [self initialize];
    }
    return self;
}
- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self)
    {
        [self initialize];
    }
    return self;
}
-(CGSize)sizeThatFits:(CGSize)size
{
    CGSize sizeThatFit = [super sizeThatFits:size];
    sizeThatFit.height = 44;
    return sizeThatFit;
}
-(void)setTintColor:(UIColor *)tintColor
{
    [super setTintColor:tintColor];
    for (UIBarButtonItem *item in self.items)
    {
        [item setTintColor:tintColor];
    }
}
-(void)layoutSubviews
{
    [super layoutSubviews];
    if ([[NSProcessInfo processInfo] operatingSystemVersion].majorVersion < 11)
    {
        CGRect leftRect = CGRectNull;
        CGRect rightRect = CGRectNull;
        BOOL isTitleBarButtonFound = NO;
        NSArray *subviews = [self.subviews sortedArrayUsingComparator:^NSComparisonResult(UIView *view1, UIView *view2) {
            CGFloat x1 = CGRectGetMinX(view1.frame);
            CGFloat y1 = CGRectGetMinY(view1.frame);
            CGFloat x2 = CGRectGetMinX(view2.frame);
            CGFloat y2 = CGRectGetMinY(view2.frame);
            if (x1 < x2)  return NSOrderedAscending;
            else if (x1 > x2) return NSOrderedDescending;
            else if (y1 < y2)  return NSOrderedAscending;
            else if (y1 > y2) return NSOrderedDescending;
            else    return NSOrderedSame;
        }];
        for (UIView *barButtonItemView in subviews)
        {
            if (isTitleBarButtonFound == YES)
            {
                rightRect = barButtonItemView.frame;
                break;
            }
            else if ([barButtonItemView isMemberOfClass:[UIView class]])
            {
                isTitleBarButtonFound = YES;
            }
            else if ([barButtonItemView isKindOfClass:[UIControl class]])
            {
                leftRect = barButtonItemView.frame;
            }
        }
        CGFloat x = 16;
        if (CGRectIsNull(leftRect) == false)
        {
            x = CGRectGetMaxX(leftRect) + 16;
        }
        CGFloat width = CGRectGetWidth(self.frame) - 32 - (CGRectIsNull(leftRect)?0:CGRectGetMaxX(leftRect)) - (CGRectIsNull(rightRect)?0:CGRectGetWidth(self.frame)-CGRectGetMinX(rightRect));
        for (UIBarButtonItem *item in self.items)
        {
            if ([item isKindOfClass:[IQActionSheetTitleBarButtonItem class]])
            {
                CGRect titleRect = CGRectMake(x, 0, width, self.frame.size.height);
                item.customView.frame = titleRect;
                break;
            }
        }
    }
}
-(void)setCancelButtonAttributes:(NSDictionary *)cancelButtonAttributes{
    id attributesForCancelButtonNormalState = [cancelButtonAttributes objectForKey:kIQActionSheetAttributesForNormalStateKey];
    if (attributesForCancelButtonNormalState != nil && [attributesForCancelButtonNormalState isKindOfClass:[NSDictionary class]]) {
        [self.cancelButton setTitleTextAttributes:(NSDictionary *)attributesForCancelButtonNormalState forState:UIControlStateNormal];
    }
    id attributesForCancelButtonnHighlightedState = [cancelButtonAttributes objectForKey:  kIQActionSheetAttributesForHighlightedStateKey];
    if (attributesForCancelButtonnHighlightedState != nil && [attributesForCancelButtonnHighlightedState isKindOfClass:[NSDictionary class]]) {
        [self.cancelButton setTitleTextAttributes:(NSDictionary *)attributesForCancelButtonnHighlightedState forState:UIControlStateHighlighted];
    }
}
-(void)setDoneButtonAttributes:(NSDictionary *)doneButtonAttributes{
    id attributesForDoneButtonNormalState = [doneButtonAttributes objectForKey:kIQActionSheetAttributesForNormalStateKey];
    if (attributesForDoneButtonNormalState != nil && [attributesForDoneButtonNormalState isKindOfClass:[NSDictionary class]]) {
        [self.doneButton setTitleTextAttributes:(NSDictionary *)attributesForDoneButtonNormalState forState:UIControlStateNormal];
    }
    id attributesForDoneButtonnHighlightedState = [doneButtonAttributes objectForKey:  kIQActionSheetAttributesForHighlightedStateKey];
    if (attributesForDoneButtonnHighlightedState != nil && [attributesForDoneButtonnHighlightedState isKindOfClass:[NSDictionary class]]) {
        [self.doneButton setTitleTextAttributes:(NSDictionary *)attributesForDoneButtonnHighlightedState forState:UIControlStateHighlighted];
    }
}
@end
