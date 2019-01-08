#import "ExternaHeyNowlLinkdg.h"
@interface ExternaHeyNowlLinkdg ()
@end
@implementation ExternaHeyNowlLinkdg
@synthesize myWebView;
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self checkInternetConnection];
    if (internetStatus == 0)
    {
        [SVProgressHUD dismiss];
        [self Networkfailure];
    }
    else
    {
        [self startSpinner];
        NSString *external_link = [[NSUserDefaults standardUserDefaults] valueForKey:@"external_link"];
        NSURL *targetURL = [NSURL URLWithString:external_link];
        NSURLRequest *request = [NSURLRequest requestWithURL:targetURL];
        [myWebView loadRequest:request];
    }
}
-(void)webViewDidFinishLoad:(UIWebView *)webView
{
    [self startSpinner];
}
-(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    [KSToastView ks_showToast:[CommonUtils InternetConnectionErrorMsg] duration:5.0f];
    [self stopSpinner];
}
-(void)webViewDidStartLoad:(UIWebView *)webView
{
    [self stopSpinner];
}

-(void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
}
-(void)checkInternetConnection
{
    internetReachable = [Reachability reachabilityForInternetConnection];
    internetStatus = [internetReachable currentReachabilityStatus];
}
-(void)Networkfailure
{
    [KSToastView ks_showToast:[CommonUtils InternetConnectionErrorMsg] duration:5.0f];
    [SVProgressHUD dismiss];
    self.view.userInteractionEnabled = YES;
}
-(void)startSpinner
{
    [SVProgressHUD showWithStatus:@"Loading..."];
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
    [SVProgressHUD setDefaultAnimationType:SVProgressHUDAnimationTypeNative];
    self.view.userInteractionEnabled = NO;
}
-(void)stopSpinner
{
    [SVProgressHUD dismiss];
    self.view.userInteractionEnabled = YES;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
@end
