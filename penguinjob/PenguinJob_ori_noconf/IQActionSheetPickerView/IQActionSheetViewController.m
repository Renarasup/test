#import "IQActionSheetViewController.h"
#import "IQActionSheetPickerView.h"
@interface IQActionSheetViewController ()<UIApplicationDelegate, UIGestureRecognizerDelegate>
@property(nonatomic, readonly) UITapGestureRecognizer *tappedDismissGestureRecognizer;
@end
@implementation IQActionSheetViewController 
@synthesize tappedDismissGestureRecognizer = _tappedDismissGestureRecognizer;
-(void)loadView
{
    self.view = [[UIView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.view.backgroundColor = [UIColor clearColor];
}
-(void)viewDidLoad
{
    [super viewDidLoad];
    [self.view addGestureRecognizer:self.tappedDismissGestureRecognizer];
}
-(void)setDisableDismissOnTouchOutside:(BOOL)disableDismissOnTouchOutside
{
    _disableDismissOnTouchOutside = disableDismissOnTouchOutside;
    self.tappedDismissGestureRecognizer.enabled = !disableDismissOnTouchOutside;
}
-(UITapGestureRecognizer *)tappedDismissGestureRecognizer
{
    if (_tappedDismissGestureRecognizer == nil)
    {
        _tappedDismissGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTapFrom:)];
        _tappedDismissGestureRecognizer.delegate = self;
    }
    return _tappedDismissGestureRecognizer;
}
- (void) handleTapFrom: (UITapGestureRecognizer *)recognizer
{
    if (recognizer.state == UIGestureRecognizerStateEnded)
    {
        [self dismissWithCompletion:nil];
    }
}
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer
       shouldReceiveTouch:(UITouch *)touch
{
    if (CGRectContainsPoint([self.pickerView bounds], [touch locationInView:self.pickerView]))
      return NO;
    return YES;
}
-(void)showPickerView:(IQActionSheetPickerView*)pickerView completion:(void (^)(void))completion
{
    _pickerView = pickerView;
    UIViewController *topController = [[[UIApplication sharedApplication] keyWindow] rootViewController];
    while ([topController presentedViewController])	topController = [topController presentedViewController];
    [topController.view endEditing:YES];
    __block CGRect pickerViewFrame = pickerView.frame;
    {
        pickerViewFrame.origin.y = self.view.bounds.size.height;
        pickerView.frame = pickerViewFrame;
        [self.view addSubview:pickerView];
    }
    {
        self.view.frame = CGRectMake(0, 0, topController.view.bounds.size.width, topController.view.bounds.size.height);
        self.view.autoresizingMask = UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth;
        [topController addChildViewController: self];
        [topController.view addSubview: self.view];
        [self didMoveToParentViewController:topController];
    }
    [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionBeginFromCurrentState|7<<16 animations:^{
        self.view.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.5];
        pickerViewFrame.origin.y = self.view.bounds.size.height-pickerViewFrame.size.height;
        pickerView.frame = pickerViewFrame;
    } completion:^(BOOL finished) {
        if (completion) completion();
    }];
}
-(void)dismissWithCompletion:(void (^)(void))completion
{
    [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionBeginFromCurrentState|7<<16 animations:^{
        self.view.backgroundColor = [UIColor clearColor];
        CGRect pickerViewFrame = _pickerView.frame;
        pickerViewFrame.origin.y = self.view.bounds.size.height;
        _pickerView.frame = pickerViewFrame;
    } completion:^(BOOL finished) {
        [_pickerView removeFromSuperview];
        [self willMoveToParentViewController:nil];
        [self.view removeFromSuperview];
        [self removeFromParentViewController];
        if (completion) completion();
    }];
}
@end
