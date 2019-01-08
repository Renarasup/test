#import "NotificationService.h"
#import <OneSignal/OneSignal.h>
#import <SystemConfiguration/SystemConfiguration.h>
#import <UIKit/UIKit.h>
@interface NotificationService ()
{
    NSURLSessionDownloadTask *task;
}
@property (nonatomic, strong) void (^contentHandler)(UNNotificationContent *contentToDeliver);
@property (nonatomic, strong) UNNotificationRequest *receivedRequest;
@property (nonatomic, strong) UNMutableNotificationContent *bestAttemptContent;
@end
@implementation NotificationService
- (void)didReceiveNotificationRequest:(UNNotificationRequest *)request withContentHandler:(void (^)(UNNotificationContent * _Nonnull))contentHandler
{
    self.receivedRequest = request;
    self.contentHandler = contentHandler;
    self.bestAttemptContent = [request.content mutableCopy];
    [OneSignal didReceiveNotificationExtensionRequest:self.receivedRequest withMutableNotificationContent:self.bestAttemptContent];
    self.contentHandler(self.bestAttemptContent);
}
- (void)serviceExtensionTimeWillExpire
{
    [OneSignal serviceExtensionTimeWillExpireRequest:self.receivedRequest withMutableNotificationContent:self.bestAttemptContent];
    self.contentHandler(self.bestAttemptContent);
}
@end
