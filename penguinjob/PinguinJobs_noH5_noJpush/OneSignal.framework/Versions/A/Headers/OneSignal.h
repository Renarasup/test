#import <Foundation/Foundation.h>
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= 100000
#define XC8_AVAILABLE 1
#import <UserNotifications/UserNotifications.h>
#endif
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wstrict-prototypes"
#pragma clang diagnostic ignored "-Wnullability-completeness"
typedef NS_ENUM(NSUInteger, OSNotificationActionType)  {
    OSNotificationActionTypeOpened,
    OSNotificationActionTypeActionTaken
};
typedef NS_ENUM(NSUInteger, OSNotificationDisplayType) {
    OSNotificationDisplayTypeNone,
    OSNotificationDisplayTypeInAppAlert,
    OSNotificationDisplayTypeNotification
};
@interface OSNotificationAction : NSObject
@property(readonly)OSNotificationActionType type;
@property(readonly)NSString* actionID;
@end
@interface OSNotificationPayload : NSObject
@property(readonly)NSString* notificationID;
@property(readonly)NSString* templateID;
@property(readonly)NSString* templateName;
@property(readonly)BOOL contentAvailable;
@property(readonly)BOOL mutableContent;
@property(readonly)NSString* category;
@property(readonly)NSUInteger badge;
@property(readonly)NSInteger badgeIncrement;
@property(readonly)NSString* sound;
@property(readonly)NSString* title;
@property(readonly)NSString* subtitle;
@property(readonly)NSString* body;
@property(readonly)NSString* launchURL;
@property(readonly)NSDictionary* additionalData;
@property(readonly)NSDictionary* attachments;
@property(readonly)NSArray *actionButtons;
@property(readonly)NSDictionary *rawPayload;
@end
@interface OSNotification : NSObject
@property(readonly)OSNotificationPayload* payload;
@property(readonly)OSNotificationDisplayType displayType;
@property(readonly, getter=wasShown)BOOL shown;
@property(readonly, getter=wasAppInFocus)BOOL isAppInFocus;
@property(readonly, getter=isSilentNotification)BOOL silentNotification;
#if XC8_AVAILABLE
@property(readonly, getter=hasMutableContent)BOOL mutableContent;
#endif
- (NSString*)stringify;
@end
@interface OSNotificationOpenedResult : NSObject
@property(readonly)OSNotification* notification;
@property(readonly)OSNotificationAction *action;
- (NSString*)stringify;
@end;
typedef NS_ENUM(NSInteger, OSNotificationPermission) {
    OSNotificationPermissionNotDetermined = 0,
    OSNotificationPermissionDenied,
    OSNotificationPermissionAuthorized
};
@interface OSPermissionState : NSObject
@property (readonly, nonatomic) BOOL hasPrompted;
@property (readonly, nonatomic) OSNotificationPermission status;
- (NSDictionary*)toDictionary;
@end
@interface OSPermissionStateChanges : NSObject
@property (readonly) OSPermissionState* to;
@property (readonly) OSPermissionState* from;
- (NSDictionary*)toDictionary;
@end
@protocol OSPermissionObserver <NSObject>
- (void)onOSPermissionChanged:(OSPermissionStateChanges*)stateChanges;
@end
@interface OSSubscriptionState : NSObject
@property (readonly, nonatomic) BOOL subscribed; 
@property (readonly, nonatomic) BOOL userSubscriptionSetting; 
@property (readonly, nonatomic) NSString* userId;    
@property (readonly, nonatomic) NSString* pushToken; 
- (NSDictionary*)toDictionary;
@end
@interface OSEmailSubscriptionState : NSObject
@property (readonly, nonatomic) NSString* emailUserId; 
@property (readonly, nonatomic) NSString *emailAddress;
@property (readonly, nonatomic) BOOL subscribed;
- (NSDictionary*)toDictionary;
@end
@interface OSSubscriptionStateChanges : NSObject
@property (readonly) OSSubscriptionState* to;
@property (readonly) OSSubscriptionState* from;
- (NSDictionary*)toDictionary;
@end
@interface OSEmailSubscriptionStateChanges : NSObject
@property (readonly) OSEmailSubscriptionState* to;
@property (readonly) OSEmailSubscriptionState* from;
- (NSDictionary*)toDictionary;
@end
@protocol OSSubscriptionObserver <NSObject>
- (void)onOSSubscriptionChanged:(OSSubscriptionStateChanges*)stateChanges;
@end
@protocol OSEmailSubscriptionObserver <NSObject>
- (void)onOSEmailSubscriptionChanged:(OSEmailSubscriptionStateChanges*)stateChanges;
@end
@interface OSPermissionSubscriptionState : NSObject
@property (readonly) OSPermissionState* permissionStatus;
@property (readonly) OSSubscriptionState* subscriptionStatus;
@property (readonly) OSEmailSubscriptionState *emailSubscriptionStatus;
- (NSDictionary*)toDictionary;
@end
typedef void (^OSWebOpenURLResultBlock)(BOOL shouldOpen);
typedef void (^OSResultSuccessBlock)(NSDictionary* result);
typedef void (^OSFailureBlock)(NSError* error);
typedef void (^OSIdsAvailableBlock)(NSString* userId, NSString* pushToken);
typedef void (^OSHandleNotificationReceivedBlock)(OSNotification* notification);
typedef void (^OSHandleNotificationActionBlock)(OSNotificationOpenedResult * result);
extern NSString * const kOSSettingsKeyAutoPrompt;
extern NSString * const kOSSettingsKeyInAppAlerts;
extern NSString * const kOSSettingsKeyInAppLaunchURL;
extern NSString * const kOSSSettingsKeyPromptBeforeOpeningPushURL;
extern NSString * const kOSSettingsKeyInFocusDisplayOption;
@interface OneSignal : NSObject
extern NSString* const ONESIGNAL_VERSION;
typedef NS_ENUM(NSUInteger, ONE_S_LOG_LEVEL) {
    ONE_S_LL_NONE, ONE_S_LL_FATAL, ONE_S_LL_ERROR, ONE_S_LL_WARN, ONE_S_LL_INFO, ONE_S_LL_DEBUG, ONE_S_LL_VERBOSE
};
+ (id)initWithLaunchOptions:(NSDictionary*)launchOptions appId:(NSString*)appId;
+ (id)initWithLaunchOptions:(NSDictionary*)launchOptions appId:(NSString*)appId handleNotificationAction:(OSHandleNotificationActionBlock)actionCallback;
+ (id)initWithLaunchOptions:(NSDictionary*)launchOptions appId:(NSString*)appId handleNotificationAction:(OSHandleNotificationActionBlock)actionCallback settings:(NSDictionary*)settings;
+ (id)initWithLaunchOptions:(NSDictionary*)launchOptions appId:(NSString*)appId handleNotificationReceived:(OSHandleNotificationReceivedBlock)receivedCallback handleNotificationAction:(OSHandleNotificationActionBlock)actionCallback settings:(NSDictionary*)settings;
+ (void)consentGranted:(BOOL)granted;
+ (BOOL)requiresUserPrivacyConsent; 
+ (void)setRequiresUserPrivacyConsent:(BOOL)required; 
@property (class) OSNotificationDisplayType inFocusDisplayType;
+ (NSString*)app_id;
+ (NSString*)sdk_version_raw;
+ (NSString*)sdk_semantic_version;
+ (void)registerForPushNotifications __deprecated_msg("Please use promptForPushNotificationsWithUserResponse instead.");
+ (void)promptForPushNotificationsWithUserResponse:(void(^)(BOOL accepted))completionHandler;
+ (void)setLogLevel:(ONE_S_LOG_LEVEL)logLevel visualLevel:(ONE_S_LOG_LEVEL)visualLogLevel;
+ (void) onesignal_Log:(ONE_S_LOG_LEVEL)logLevel message:(NSString*)message;
+ (void)sendTag:(NSString*)key value:(NSString*)value onSuccess:(OSResultSuccessBlock)successBlock onFailure:(OSFailureBlock)failureBlock;
+ (void)sendTag:(NSString*)key value:(NSString*)value;
+ (void)sendTags:(NSDictionary*)keyValuePair onSuccess:(OSResultSuccessBlock)successBlock onFailure:(OSFailureBlock)failureBlock;
+ (void)sendTags:(NSDictionary*)keyValuePair;
+ (void)sendTagsWithJsonString:(NSString*)jsonString;
+ (void)getTags:(OSResultSuccessBlock)successBlock onFailure:(OSFailureBlock)failureBlock;
+ (void)getTags:(OSResultSuccessBlock)successBlock;
+ (void)deleteTag:(NSString*)key onSuccess:(OSResultSuccessBlock)successBlock onFailure:(OSFailureBlock)failureBlock;
+ (void)deleteTag:(NSString*)key;
+ (void)deleteTags:(NSArray*)keys onSuccess:(OSResultSuccessBlock)successBlock onFailure:(OSFailureBlock)failureBlock;
+ (void)deleteTags:(NSArray*)keys;
+ (void)deleteTagsWithJsonString:(NSString*)jsonString;
+ (void)syncHashedEmail:(NSString*)email __deprecated_msg("Please refer to our new Email methods/functionality such as setEmail(). This method will be removed in a future version of the OneSignal SDK");
+ (void)IdsAvailable:(OSIdsAvailableBlock)idsAvailableBlock __deprecated_msg("Please use getPermissionSubscriptionState or addSubscriptionObserver and addPermissionObserver instead.");
+ (OSPermissionSubscriptionState*)getPermissionSubscriptionState;
+ (void)addPermissionObserver:(NSObject<OSPermissionObserver>*)observer;
+ (void)removePermissionObserver:(NSObject<OSPermissionObserver>*)observer;
+ (void)addSubscriptionObserver:(NSObject<OSSubscriptionObserver>*)observer;
+ (void)removeSubscriptionObserver:(NSObject<OSSubscriptionObserver>*)observer;
+ (void)addEmailSubscriptionObserver:(NSObject<OSEmailSubscriptionObserver>*)observer;
+ (void)removeEmailSubscriptionObserver:(NSObject<OSEmailSubscriptionObserver>*)observer;
+ (void)setSubscription:(BOOL)enable;
+ (void)postNotification:(NSDictionary*)jsonData;
+ (void)postNotification:(NSDictionary*)jsonData onSuccess:(OSResultSuccessBlock)successBlock onFailure:(OSFailureBlock)failureBlock;
+ (void)postNotificationWithJsonString:(NSString*)jsonData onSuccess:(OSResultSuccessBlock)successBlock onFailure:(OSFailureBlock)failureBlock;
+ (NSString*)parseNSErrorAsJsonString:(NSError*)error;
+ (void)promptLocation;
+ (void)setLocationShared:(BOOL)enable;
+ (void)setMSDKType:(NSString*)type;
+ (UNMutableNotificationContent*)didReceiveNotificationExtensionRequest:(UNNotificationRequest*)request withMutableNotificationContent:(UNMutableNotificationContent*)replacementContent;
+ (UNMutableNotificationContent*)serviceExtensionTimeWillExpireRequest:(UNNotificationRequest*)request withMutableNotificationContent:(UNMutableNotificationContent*)replacementContent;
typedef void (^OSEmailFailureBlock)(NSError* error);
typedef void (^OSEmailSuccessBlock)();
+ (void)setEmail:(NSString * _Nonnull)email withEmailAuthHashToken:(NSString * _Nullable)hashToken withSuccess:(OSEmailSuccessBlock _Nullable)successBlock withFailure:(OSEmailFailureBlock _Nullable)failureBlock;
+ (void)setEmail:(NSString * _Nonnull)email withSuccess:(OSEmailSuccessBlock _Nullable)successBlock withFailure:(OSEmailFailureBlock _Nullable)failureBlock;
+ (void)logoutEmailWithSuccess:(OSEmailSuccessBlock _Nullable)successBlock withFailure:(OSEmailFailureBlock _Nullable)failureBlock;
+ (void)logoutEmail;
+ (void)setEmail:(NSString * _Nonnull)email;
+ (void)setEmail:(NSString * _Nonnull)email withEmailAuthHashToken:(NSString * _Nullable)hashToken;
@end
#pragma clang diagnostic pop
