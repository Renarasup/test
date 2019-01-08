#import <Foundation/Foundation.h>
#import <CommonCrypto/CommonDigest.h>
@interface CommonUtils : NSObject
@property(nonatomic,retain) NSString *dbPath;
+ (CommonUtils *)ShareInstance;
- (NSString *)getDBPath;
+ (NSString *)retriveFromUserDefaults:(NSString *)pref;
+ (NSString *)urlEncoding:(NSString *)raw;
+ (NSString *)urlDecode:(NSString *)raw;
+ (NSString *)getBaseURL;
+ (NSString *)getOneSignalID;
+ (NSString *)InternetConnectionErrorMsg;
+ (NSString *)ServerErrorMsg;
+ (NSString *)UserLoginMessage;
+ (NSString *)getRateAppUrl;
+ (NSString *)getMoreAppsUrl;
+ (NSString *)getShareAppUrl;
+ (NSString *)ChangeAppDevelopedBy;
+ (NSString *)extractYoutubeIdFromLink:(NSString *)link;
+ (BOOL)validateEmailWithString:(NSString*)check_email;
+ (BOOL)isValidateDOB:(NSString *)dateOfBirth;
+ (BOOL)validMobileNumber:(NSString*)number;
+ (void)saveToUserDefaults:(NSString *)string : (NSString *)pref;
@end
