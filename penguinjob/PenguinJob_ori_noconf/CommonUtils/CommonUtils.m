#import "CommonUtils.h"
@implementation CommonUtils
@synthesize dbPath;
+(CommonUtils *)ShareInstance
{
    static CommonUtils * single=nil;
    @synchronized(self)
    {
        if(!single)
        {
            single = [[CommonUtils alloc] init];
        }
    }
    return single;
}
- (NSString *)getDBPath
{
    return self.dbPath;
}
+ (NSString *)getBaseURL
{
    return @"http://candyd.sgedu.site/PenguinJobs/";
}
+ (NSString *)getOneSignalID
{
    return @"5c523159-809b-452c-aca0-26a1014ae412";
}
+ (NSString *)getRateAppUrl
{
    return @"https://itunes.apple.com/in/app/ios-hdwallpaper/idsd912248?mt=8";
}
+ (NSString *)getMoreAppsUrl
{
    return @"https://itunes.apple.com/in/app/abcd-alphabet/id112421sd05386?mt=8";
}
+ (NSString *)getShareAppUrl
{
    return @"https://itunes.apple.com/in/app/ios-hdwallpaper/id112sd41291248?mt=8";
}
+ (NSString *)ChangeAppDevelopedBy
{
    return @"@Copyright 2018 PenguinJobs";
}
+(void)saveToUserDefaults:(NSString *)string :(NSString *)pref
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    if(userDefaults)
    {
        [userDefaults setObject:string forKey:pref];
        [userDefaults synchronize];
    }
}
+(NSString *)retriveFromUserDefaults:(NSString *)pref
{
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    NSString *value = nil;
    if(userDefault)
        value = [userDefault objectForKey:pref];
    return value;
}
+(NSString * ) urlEncoding : (NSString *) raw
{
	NSString *preparedString = [raw stringByReplacingOccurrencesOfString: @" " withString: @"%20"];
	preparedString = [preparedString stringByReplacingOccurrencesOfString: @"&" withString: @"%26"];
    preparedString = [preparedString stringByReplacingOccurrencesOfString:@"\"" withString:@"%22"];
	return preparedString ;
}
+(NSString * ) urlDecode : (NSString *) raw
{
	NSString *preparedString = [raw stringByReplacingOccurrencesOfString:  @"%20" withString: @" "];
	preparedString = [preparedString stringByReplacingOccurrencesOfString: @"%7B" withString: @"{"];
	preparedString = [preparedString stringByReplacingOccurrencesOfString: @"%2F" withString: @"/"];
	preparedString = [preparedString stringByReplacingOccurrencesOfString: @"%3A" withString: @":"];
	preparedString = [preparedString stringByReplacingOccurrencesOfString: @"%2C" withString: @","];
	preparedString = [preparedString stringByReplacingOccurrencesOfString: @"%7D" withString: @"}"];
	preparedString = [preparedString stringByReplacingOccurrencesOfString: @"%22" withString: @" "];
	preparedString = [preparedString stringByReplacingOccurrencesOfString: @"%0A" withString: @"\n"];
	preparedString = [preparedString stringByReplacingOccurrencesOfString: @"+" withString: @" "];
	preparedString = [preparedString stringByReplacingOccurrencesOfString: @"%5C" withString: @""];
	preparedString = [preparedString stringByReplacingOccurrencesOfString: @"%27" withString: @"'"];
	preparedString = [preparedString stringByReplacingOccurrencesOfString: @"%24" withString: @"$"];
	preparedString = [preparedString stringByReplacingOccurrencesOfString: @"%3F" withString: @"?"];
	preparedString = [preparedString stringByReplacingOccurrencesOfString: @"%3A" withString: @":"];
	preparedString = [preparedString stringByReplacingOccurrencesOfString: @"%2F" withString: @"/"];
	preparedString = [preparedString stringByReplacingOccurrencesOfString: @"%3F" withString: @"?"];
	preparedString = [preparedString stringByReplacingOccurrencesOfString: @"%3D" withString: @"="];
	preparedString = [preparedString stringByReplacingOccurrencesOfString: @"%26" withString: @"&"];
	preparedString = [preparedString stringByReplacingOccurrencesOfString: @"%3B" withString: @";"];
	preparedString = [preparedString stringByReplacingOccurrencesOfString: @"&amp;" withString: @"&"];
	preparedString = [preparedString stringByReplacingOccurrencesOfString: @"%28" withString: @"("];
	preparedString = [preparedString stringByReplacingOccurrencesOfString: @"%29" withString: @")"];
	preparedString = [preparedString stringByReplacingOccurrencesOfString: @"%2A" withString: @"*"];
	preparedString = [preparedString stringByReplacingOccurrencesOfString: @"%2B" withString: @"+"];
	preparedString = [preparedString stringByReplacingOccurrencesOfString: @"%2E" withString: @"."];
	preparedString = [preparedString stringByReplacingOccurrencesOfString: @"%2D" withString: @"-"];
	preparedString = [preparedString stringByReplacingOccurrencesOfString: @"%40" withString: @"@"];
	preparedString = [preparedString stringByReplacingOccurrencesOfString: @"%3C" withString: @"<"];
	preparedString = [preparedString stringByReplacingOccurrencesOfString: @"%C3" withString: @""];
	preparedString = [preparedString stringByReplacingOccurrencesOfString: @"%83" withString: @""];
	preparedString = [preparedString stringByReplacingOccurrencesOfString: @"%C2" withString: @""];
	preparedString = [preparedString stringByReplacingOccurrencesOfString: @"%A9" withString: @""];
	preparedString = [preparedString stringByReplacingOccurrencesOfString: @"%21" withString: @"!"];
	preparedString = [preparedString stringByReplacingOccurrencesOfString: @"%0D" withString: @" "];
	preparedString = [preparedString stringByReplacingOccurrencesOfString: @"%09" withString: @" "];
	preparedString = [preparedString stringByReplacingOccurrencesOfString: @"%3E" withString: @">"];
	preparedString = [preparedString stringByReplacingOccurrencesOfString: @"%7E" withString: @"~"];
    preparedString = [preparedString stringByReplacingOccurrencesOfString: @"%7C" withString: @"|"];
	preparedString = [preparedString stringByReplacingOccurrencesOfString: @"%5C" withString: @"\\"];
	preparedString = [preparedString stringByReplacingOccurrencesOfString: @"%5B" withString: @"["];
    preparedString = [preparedString stringByReplacingOccurrencesOfString:@"\"" withString:@"%22"];
	preparedString = [preparedString stringByReplacingOccurrencesOfString: @"%5D" withString: @"]"];
    NSString *singleQuote = @"'";
    preparedString = [preparedString stringByReplacingOccurrencesOfString:@"%E2%80%99" withString:singleQuote];
    preparedString = [preparedString stringByReplacingOccurrencesOfString:@"%E2%80%93" withString:@"-"];
    preparedString = [preparedString stringByReplacingOccurrencesOfString:@"%E2%80%9C" withString:@"\""];
    preparedString = [preparedString stringByReplacingOccurrencesOfString:@"%E2%80%9D" withString:@"\""];
  	preparedString = [preparedString stringByReplacingOccurrencesOfString: @"<strong>" withString: @""];
    preparedString = [preparedString stringByReplacingOccurrencesOfString: @"</strong>" withString: @""];
    preparedString = [preparedString stringByReplacingOccurrencesOfString: @"%A0" withString: @" "];
	return preparedString;
}
+ (BOOL)validateEmailWithString:(NSString *)check_email
{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:check_email];
}
+ (BOOL)isValidateDOB:(NSString *)dateOfBirth
{
    NSDateFormatter *format = [[NSDateFormatter alloc] init];
    [format setDateStyle:NSDateFormatterShortStyle];
    [format setDateFormat:@"dd/MM/yy"];
    NSDate *validateDOB = [format dateFromString:dateOfBirth];
    if (validateDOB != nil)
        return YES;
    else
        return NO;
}
+ (BOOL)validMobileNumber:(NSString*)number
{
    NSString *numberRegEx = @"[0-9]{10}";
    NSPredicate *numberTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", numberRegEx];
    if ([numberTest evaluateWithObject:number] == YES)
        return TRUE;
    else
        return FALSE;
}
+(NSString *)extractYoutubeIdFromLink:(NSString *)link
{
    NSString *regexString = @"((?<=(v|V)/)|(?<=be/)|(?<=(\\?|\\&)v=)|(?<=embed/))([\\w-]++)";
    NSRegularExpression *regExp = [NSRegularExpression regularExpressionWithPattern:regexString options:NSRegularExpressionCaseInsensitive error:nil];
    NSArray *array = [regExp matchesInString:link options:0 range:NSMakeRange(0,link.length)];
    if (array.count > 0) {
        NSTextCheckingResult *result = array.firstObject;
        return [link substringWithRange:result.range];
    }
    return nil;
}
+ (NSString *)InternetConnectionErrorMsg
{
    return @"No data found from web!";
}
+ (NSString *)ServerErrorMsg
{
   return @"No data found from web!";
}
+ (NSString *)UserLoginMessage
{
    return @"You need to Login first!";
}
@end
