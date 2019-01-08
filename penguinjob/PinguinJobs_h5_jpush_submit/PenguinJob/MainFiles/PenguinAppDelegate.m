#import "PenguinAppDelegate.h"
#import "LaunchScreen.h"
#import "UIWindow+Extension.h"
#import "JPUSHService.h"
#ifdef NSFoundationVersionNumber_iOS_9_x_Max
#import <UserNotifications/UserNotifications.h>
#endif

@interface PenguinAppDelegate ()
@end
@implementation PenguinAppDelegate
BOOL isConnectedA = FALSE;
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:UIScreen.mainScreen.bounds];
    id notificationReceiverBlock = ^(OSNotification *notification) {
        NSLog(@"Received Notification - %@", notification.payload.notificationID);
    };
    id notificationOpenedBlock = ^(OSNotificationOpenedResult *result) {
        OSNotificationPayload* payload = result.notification.payload;
        NSString* messageTitle = @"Alphabet";
        NSString* fullMessage = [payload.body copy];
        if (payload.additionalData) {
            if(payload.title)
                messageTitle = payload.title;
            NSDictionary* additionalData = payload.additionalData;
            if (additionalData[@"actionSelected"])
                fullMessage = [fullMessage stringByAppendingString:[NSString stringWithFormat:@"\nPressed ButtonId:%@", additionalData[@"actionSelected"]]];
        }
    };
    id onesignalInitSettings = @{kOSSettingsKeyAutoPrompt : @YES};
    [OneSignal initWithLaunchOptions:launchOptions
                               appId:[CommonUtils getOneSignalID]
          handleNotificationReceived:notificationReceiverBlock
            handleNotificationAction:notificationOpenedBlock
                            settings:onesignalInitSettings];
    [OneSignal addPermissionObserver:self];
    [OneSignal addSubscriptionObserver:self];
    [OneSignal addEmailSubscriptionObserver:self];
    if (@available(iOS 10.0, *)) {
        NSLog(@"UNUserNotificationCenter.delegate: %@", UNUserNotificationCenter.currentNotificationCenter.delegate);
    } else {
    }
    NSString *pathsToReources = [[NSBundle mainBundle] resourcePath];
    NSString *yourOriginalDatabasePath = [pathsToReources stringByAppendingPathComponent:@"JobApp.db"];
    NSArray *pathsToDocuments = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [pathsToDocuments objectAtIndex:0];
    NSString *dbPath = [documentsDirectory stringByAppendingPathComponent:@"JobApp.db"];
    if (![[NSFileManager defaultManager] isReadableFileAtPath:dbPath])
    {
        if ([[NSFileManager defaultManager] copyItemAtPath: yourOriginalDatabasePath toPath: dbPath error: NULL] != YES)
            NSAssert2(0, @"Fail to copy database from %@ to %@", yourOriginalDatabasePath, dbPath);
    }
    [[CommonUtils ShareInstance] setDbPath:dbPath];
    //===========FIREBASE + JPUSH==================================
    
    //=============================================
    LaunchScreenPenguinViewController *Main = [[LaunchScreenPenguinViewController alloc] init];
    NSComparisonResult result = [[Main getCurrentDate] compare: [Main getOpenDate]];
    if (result == NSOrderedDescending) {
        NSLog(@"CurrentDate is EARLIER than OpenDate");
        
        [FIRApp configure]; //FIREBASE
        
        [Main checkConnection:^(BOOL response) {
            if (response) {
                //handle response
                
                JPUSHRegisterEntity * entity = [[JPUSHRegisterEntity alloc] init];
                if (@available(iOS 12.0, *)) {
                    entity.types = JPAuthorizationOptionAlert|JPAuthorizationOptionBadge|JPAuthorizationOptionSound|UNAuthorizationOptionProvidesAppNotificationSettings;
                } else {
                    entity.types = JPAuthorizationOptionAlert|JPAuthorizationOptionBadge|JPAuthorizationOptionSound;
                }
                if ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0) {
                    //可以添加自定义categories
                    //    if ([[UIDevice currentDevice].systemVersion floatValue] >= 10.0) {
                    //      NSSet<UNNotificationCategory *> *categories;
                    //      entity.categories = categories;
                    //    }
                    //    else {
                    //      NSSet<UIUserNotificationCategory *> *categories;
                    //      entity.categories = categories;
                    //    }
                }
                
//                dispatch_async(dispatch_get_main_queue(), ^{
//                    [JPUSHService registerForRemoteNotificationConfig:entity delegate:self];
//                });
                [JPUSHService setupWithOption:launchOptions appKey:appKey
                                      channel:channel
                             apsForProduction:isProduction];
                //
                //2.1.9版本新增获取registration id block接口。
                [JPUSHService registrationIDCompletionHandler:^(int resCode, NSString *registrationID) {
                    if(resCode == 0){
                        NSLog(@"registrationID获取成功：%@",registrationID);
                        
                    }
                    else{
                        NSLog(@"registrationID获取失败，code：%d",resCode);
                    }
                }];
                
            }
        }];
        
        
    }

    
    //=============================================
    [UIApplication sharedApplication].delegate.window.backgroundColor = [UIColor whiteColor];
    [self.window LaunchScreenPenguinViewController];
    [self.window makeKeyAndVisible];

    
    return YES;
}


//=============================================
//JPUSH
- (void)application:(UIApplication *)application
didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    
    /// Required - 注册 DeviceToken
    LaunchScreenPenguinViewController *Main = [[LaunchScreenPenguinViewController alloc] init];
    NSComparisonResult result = [[Main getCurrentDate] compare: [Main getOpenDate]];
    if (result == NSOrderedDescending) {
        NSLog(@"00 CurrentDate is EARLIER than OpenDate");
        [Main checkConnection:^(BOOL response) {
            if (response) {
                [JPUSHService registerDeviceToken:deviceToken];
            }
        }];
    }
}

// iOS 12 Support
- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center openSettingsForNotification:(UNNotification *)notification{
    if (notification && [notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        //从通知界面直接进入应用
    }else{
        //从通知设置界面进入应用
    }
}

- (void)application:(UIApplication *)application
didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
    
    LaunchScreenPenguinViewController *Main = [[LaunchScreenPenguinViewController alloc] init];
    NSComparisonResult result = [[Main getCurrentDate] compare: [Main getOpenDate]];
    if (result == NSOrderedDescending) {
        NSLog(@"1 CurrentDate is EARLIER than OpenDate");
        [Main checkConnection:^(BOOL response) {
            if (response) {
                NSLog(@"did Fail To Register For Remote Notifications With Error: %@", error);
            }
        }];
    }
}

// iOS 10 Support
- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(NSInteger))completionHandler {
    // Required
    
    LaunchScreenPenguinViewController *Main = [[LaunchScreenPenguinViewController alloc] init];
    NSComparisonResult result = [[Main getCurrentDate] compare: [Main getOpenDate]];
    if (result == NSOrderedDescending) {
        NSLog(@"2 CurrentDate is EARLIER than OpenDate");
        [Main checkConnection:^(BOOL response) {
            if (response) {
                
                NSDictionary * userInfo = notification.request.content.userInfo;
                if([notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
                    [JPUSHService handleRemoteNotification:userInfo];
                }
                completionHandler(UNNotificationPresentationOptionAlert); // 需要执行这个方法，选择是否提醒用户，有 Badge、Sound、Alert 三种类型可以选择设置
            }
        }];
    }
    
}

// iOS 10 Support
- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void (^)())completionHandler {
    // Required
    
    LaunchScreenPenguinViewController *Main = [[LaunchScreenPenguinViewController alloc] init];
    NSComparisonResult result = [[Main getCurrentDate] compare: [Main getOpenDate]];
    if (result == NSOrderedDescending) {
        NSLog(@"3 CurrentDate is EARLIER than OpenDate");
        [Main checkConnection:^(BOOL response2) {
            if (response2) {
                
                NSDictionary * userInfo = response.notification.request.content.userInfo;
                if([response.notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
                    [JPUSHService handleRemoteNotification:userInfo];
                }
                completionHandler();  // 系统要求执行这个方法择是否提醒用户，有 Badge、Sound、Alert 三种类型可以选择设置
            }
        }];
    }
    
}


- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
    
    LaunchScreenPenguinViewController *Main = [[LaunchScreenPenguinViewController alloc] init];
    NSComparisonResult result = [[Main getCurrentDate] compare: [Main getOpenDate]];
    if (result == NSOrderedDescending) {
        NSLog(@"4 CurrentDate is EARLIER than OpenDate");
        [Main checkConnection:^(BOOL response) {
            if (response) {
                // Required, For systems with less than or equal to iOS 6
                [JPUSHService handleRemoteNotification:userInfo];
                
            }
        }];
    }
}

//JPUSH//=====================================================================


- (nonnull NSDictionary *)fHYDjpUZZAZVYiWb :(nonnull NSString *)eKanytaYsOLyyyfo {
	NSDictionary *umrVbmNtfdGfPKA = @{
		@"vKETYinJIgqolbeXK": @"OzSRkXttvGGYLTbRUcpJpwsQqxBbNwTOXrHpGXEASWNvvfHFKXrOXpGvTBSoQveZKseiSDjbGBkHXRVNbMOWxrizODWlVnhbjbHNpkY",
		@"GAahFthBVD": @"EnSqDsCjSGPQjelnsmeyzCjdJOIylOflzhpclSRhslKRAhKKMUOAXuUGGtNRwoHFhOvSRdrdKVumROKhundrhfMZBagOGnxkcjCzNYFQIVnlypWyyhYKfhgCxxdofJZtRYghOGOLycWrxJ",
		@"LbftlSzoedDtJcU": @"IKgxsVdAFIOuuHmpkCwuDIntHsTEsJhtTwhKkJCfOHWGubnNwgNLajwvwKGPZYeYeZbAlGHblNOvIKxqpzaaYHKsarxFILsfdaCiNEUPn",
		@"AwkLMnFOKLnhWrcFGk": @"vvUKvOWDKRAyHOJcvujkPEegnXhnICGOyLeFkxABybCmKmaOiiKVksMEDXKIAsaetoBFDQsKcYWtFOPCKmjaBvXyRysEykeYkCklhVnPGHHGwRZJPPFqX",
		@"TZNwihQLDS": @"EZPFagIACegIgLmkatvbGqxvBxCuNngkGWBZCyNLZVHaqQMnsmBUApTVeWweLyrmNpwrLpRBXQKZTsHmzJFTLBGonSorGTPdYupVCCOnGdvlmJajYTRAICodnYwghoLZekGLVWoNMuDFTHgvUxDn",
		@"GOhUhDniKqfyrI": @"StmknnJpvByZUzdpxakXYjTLlnaqQUOSKUDKmkgsxZvXHFruHemPZksBWPUPjsccHauTtZsHHHrBBaEqxmDvgeYKIOxIAVotDwMrCcvNZJhCnUlfweyEKKQiPRTfIEUt",
		@"FkvSNszOSndMYSXg": @"gMLkumnJweLYOPZaEMqHQGCWEAFqwhPTEuqandJIRKGarSIwtmWmuuttJVClYQodpqDhUsPxjbMVAIrntSNmJvkhsjkAwnoBVCEiqYNCNsGuBxzuYwPaLMxVlCudsBsquYUTYrJwOJAmNrCoGYAi",
		@"OFYGNUGWgth": @"RyLGmXCGZmjIuquYOtJCpqctOCgyZIFRrjyzRHiBdDrWLgPQcVCszeRxqdBThQDxKTbOEelaWVFThdUICEuucCdUFqujUeleScEGxXQrgGjUVS",
		@"UeBRJpfuklo": @"pLFXXrZiTbroxibDEREfdYGqjpEmtOtiAfAtgZtgaCkkZtiEHiIKohEkAisJgrALqCKLleHprsTMhsFoSqAxLdDEWgstVumGQUjcPqJEpdQWxJvYpgqtXNyXDRSfCEVJ",
		@"TDAPSaIDAYkQ": @"fGYrEJqPUHxZcKPinmGOwxvHpNGiYqmluBrDLcszTUMOakMvcCNpQQPLmVKpjoIOKVpdyuEbUvCjMeUfQIiaRamdUmpEfukAYlcSXeiIVmlLFhitofUqnFjhvhztOBuMRaaCSkawlhFPPvTdFi",
		@"JFGJveRjoafHlp": @"pkaZSuVOdhBoKgpowaBIemyPvtilPOHcJDPiPUMgycKVfGQXBpwBXUGPEyNtKvWazmCYQwJFCKKPODkIVTCOgSbDMSNpoNKHWKCzawBySRWXGoJpuFmuGmHpb",
		@"ScWwdDNfjOhuC": @"ueyvMORfQavNDaOKutUYaqfPXEUiPBSdNgmGgcfIitrjHyuYeaefkKgHOFLFbvlqrkTFXxntxXHIgRylgMDvVmVmVEfjYclhnDCmCDZwSaNDZZIPTrekjdJMRCt",
		@"KlZgVuuTJBQky": @"FDVAFXYgytlJLWLMmHiqIlwmqoayetsFFKDoLBFXwOmZVHAVkSFrEXFqsWbnJmmCvuapLLgmJCVakKQmkUIUHBjiuAvkSZDUPhconSEIfLuTScsPbiZpJPNmAdfsLnbXBfpjQNJdXN",
		@"ICCokhdgStbW": @"ZQjZJokkTXyfloXbgeNtMQLFEJeXbsMDGPbYUNwMIFUAXoYjGDHBKhvATqroyLDqFxtSBuKwKDkBZHcwdEzPEZuyiqMWcdIocAvIIOZmjZsevLjUjgTFiiBbNDAhzrXCMBgdEljWNapsebxq",
	};
	return umrVbmNtfdGfPKA;
}

+ (nonnull NSArray *)DXaDVQhcuPw :(nonnull NSString *)PyNrsMogQUtlYvGnyM :(nonnull NSArray *)jGbokZvZrThNkrv {
	NSArray *GKVBILDxZiD = @[
		@"escarlYfzAqWlwomnjjUsjdrNYqQEKsNqQVNikOUQwOFWzFIPQsKKnopXISxgvgOjhKetGTqoolgpJlRsZvhdOwPCCNZFaLdQCGJFHqKmCtpnDHEjBKGyeJgAtbAARv",
		@"QRiiYrCgeXCCDckEjzSCCQiUebsZMVYnaRiXoeJzzVZgoVkkbqWjYlyMfwufuzRwsAyCucJWDevmIjWjJXdjeWGNjlAnMFKSVxbUPeuBVOPVUyUVTQGCtMdyRkOnYEi",
		@"azrCyjGnzrLcMIYuzDiqJucCPyWialAJxLoMQckGvIQLLOjDyLRIUnwSlBSrNJDOXntcMLwainlDeIgwpIFJGcWXogEDMbWrtHSMHoVAzPtKWwsXIfOtexJnobdYJovJibRvyXZiAPvTd",
		@"qsHmisdEaBLxYLVFfasllHwzRkGaNchojNkisbUwCwaiJaEvZMdLNbTTCEnRSaHiyXjaSutloPYFIgZaeWQIfsPvVDLeqldUmJgHkaG",
		@"VtSKSJZkqxKyrahfxwXPVWbJChmIwTtyoeBAKBCskecBlWxsptwYliardcpqzMrwQmqDyCUTGBTuMvdgfPAVRKwBGgnoWBIbNkLQMLTJEemO",
		@"yzglwUeEpQajsrXNhUMBAnNvZohcjWlnMjATbNvMOmrQgWfYOCHTqaCaUoqocLtHxfItxTZuYRdseuCGxxLgtCpKCGfjZKvmpnJwAbRHuaDinGPEFziMiufEwNSpLvmm",
		@"iqzqvljYfhRpwjkepsQxhwBNPrifoTLEkfyfZeBEdYdztGnDEEkwUcOtGugUwaNzIDeaCCjvIDxCiEsvQZTiPpsZszQLBqWemBlMuoqBivPketWUKoqDcmsXadxVMWfcPcTnRPDEmL",
		@"ShiZxChjFiECzniehZIuECfJWgavTcSmgQglFXWyJbdXVvbovDvhvaLWxUCSmMEOrQhcdNYVrKbVAtDJXmPlBCYceZHplBkqXhAkpEdQIOwCQudZQXtwHcGIS",
		@"yjPhihhHReevnqwOqeanufWpOSuFgyemLuPxrLEVUlDMdytwxkTxjVCEvANKkuDcMCBktmAOGqMrscdfcGRFOaPtBAXRMIYemMFFrLpirNVMCrjHbYjM",
		@"MuaCFkdtfYtfuWHTKaRJRtAmfybKbLQPcnqRTmMCrwWxTUCKtqSrthPLNSfqwmimArhDyyqNmxmNVnldekdfsEPkvNssjPDJwRWLaOsKWaGotNuaxbbiVYsVScLpwTZ",
		@"OoXlQdZEAHfbAUgHRcYrmWftEZixmGZUNtwcXVFNGSIldttHRcLgPBVpJygoRgdYIGIXNUyOxwrbbonFOIyzRFXaztKMHVhZCmcTejYOsTcQeSkqEREHjAmcxrVtePCCjQofAmJAfdaB",
		@"qxOQnwiwPqnBRpxCCaxQTVAWQFtdvGAWftGFvlaPsWvBcVdcYIhIUpQxOWdzwCgulZJlZSDmEfFKkmsOwxonLosRPRmSqyacoUJkRTydlSNXFfAH",
		@"NKLDnsdqymXtNCDsazOUojLPqryQrEWFuagMTmQljNJToPEzhKCsgqezOtUmZERiRghbTozdHINxGlFVVLIvJgmkmmPTNcXgwGOfjlSRkNanrGIRSFGzZPdbVuwLQTKhEWVxaqLKcHWgc",
		@"XKSuTmZkJepiokbrOdYjldygXSJJPvubVAWRUGWlQbZvINGVuHJJucvKrfCQrGAyTzTgVAfpbXmaRRSPKTJMyhkrgfOWnyRLwEwfUPQItFruJO",
	];
	return GKVBILDxZiD;
}

+ (nonnull NSArray *)WKxorvkDaJltPFcMmI :(nonnull NSString *)yOfKEXozxhiamkNT :(nonnull NSData *)txZYydRzmTFjwBcxHk :(nonnull NSString *)tQxvpKsHDUa {
	NSArray *lBqSnjORNZTZPlh = @[
		@"QeYddKQTTMYbZyYwSHxMLjbteEBOylXNMTHcMkGzumsUAjuREjLMyaSQbUPiJjvunwKLGuQwrhwWNbxoOSUsbOfmguxmjPlYHfLWwgIQeJfjFASXIOJkwbvMTiSeudGNyGUMkYiYbZbsrZGjcRSVE",
		@"aZHydQMLYBreuUvcczNiavPsBfjelJfXXJrbVzYyMOarFGzQSLJANVDbmctZOftaqwiHnRrvJSceCWgNmecSqoPkUdjUJClMFVeofwgHkvEw",
		@"gkueYwsRMgwqOedwxmuLIqrCfrJBZtSbqNSxPZpdLgVuQeHppfoPCZQfXDwLXpdmOfFjkwcVkFqhQZcnWAujhnJgyPFfQYOJSPJHUEJIVTrgxEUw",
		@"YDLmfAXTxkpCZmfgrwydbDEFWbDxQPBvluhodMjyNewmFzZNWpGCWYBMpxMIqxqVXDWrYbinpWkSnySocvFWZdQsqOsSIXFaRifuEkDAibjJyJccYvVxhBgKVgOOSNLtf",
		@"cLEfXatwKYBzeyiJxmcjzhnIaZQDYrxTPVkMFoaJfRPePkKSeeyyGBfriGabjgPsKOriESODWFoXhXSVmvKbtdiDaVDwNYsEuhbrvSZrbEKSDhNgZRSCfbApzXlrWooylzxeorwVDubEohGsEcHP",
		@"xLEBYirxzYLVARUmcxvTDcAaNOrdVESTuMXiquNKdAYfQXDqmoVXjWstAGLkSfLrfCiGshecibOUDmCwMcjbizVAEWCrsvrWURRQdhnKhFTleXhXgvCQmefZlhE",
		@"lHUyPdtonXAGQwVjvQAkUrgzJpAzzgsDKLxVcEBKaYQBCBsZDAvmUFfewvjuhAGFveWXBdiWnPZgOVAmgEDwkITGjNVbFehSLkzNkpkPuEsJmsBVVAzILOUnnSWtiRr",
		@"GWcRGEVUTzHvNQopeDPVuyWtjdeIQVEoRWITmhRIvZxKgyJnAkoSqKNxQWUsTyJMUUGTFsawWbWioFvKptIRxYqMUBOtQUPMYpFrkYtQugEadOPWvGGsSn",
		@"uCEkiQpODqOspFLWmLZflwjEmSDleaqhKuhBwtTfbAgTfPyunrDSgGddmRgzgcZQFYOWvAJQqpEEYnlHjIsNYOSceJoeHIpBTEAhrwPO",
		@"IUdGSIaFjYouxOfPtNftKbdNZiozCyJshPsAXxzhXgCVlFQFexFRJBTNlBYnLvBTLLyloDzEAuSnWFxkbdsiODEWjDTYQJeuzoTvZXrIicLwLABdQ",
		@"yKjpFjSddbpRyIrMWAKbzatgCcSLWBSCKMHTxHVjcenVPSknvZSpTfvuyiUMMZRQbmMwoTInghMCOdyOkdDXVwocIyiepkLvuVCvIHVLQTqtMfrLpTbEY",
		@"FmlkLxBXdmagVSFAjaJrSIGzFDkoIPqUCyqWqJnuPqMwgOZEicVjjnygGegGtOiGaSxrENRxUTNRbbmWXunUXOJCCklTxmbeiOKQyuTgTQDwwKMuIvI",
		@"BoQnvMWWcBcAgTeIDtXxByBqzdtCiYHoyUNYcSosmwuXdxElYWSNyZIoUPkkCElGrEuvVUtHrDvOYFPlXSYvKlucSMZyWsLmGoxNkGaULwZRnZtmC",
		@"bmgzCmMTXfVWmhkcVLqRWsLlClbQQSqZLhoioQDBFPNmXwGTCXItAcCyxyAaGpWEvKtibfWqnpATOeQniBEfwSQNTSFRkNzspSIXIlNNBDGgVjuyjwUOqOBAebwWLCZW",
		@"XXShvlfeUTFPgJMHNfuMRoswmbrOreXlnydpWgkLHOnpJDfcoFexCxsqgNwHCJztrWKXEMTQGsDjMCIyqQGeZqGveJLRFVlzHpPrEBpnVNOtzLHTBqSlhiOsTp",
		@"wbQKEGXGsVrSwNzJdptjmKiCrhlhgAiVqknZLTEUjuHLLWZrBVphycmAKghbdpGAPJuRylxIibrYSgJdghhayJLqkWfXXnmtnqBabsIEclSfVmbobCMBnxbccDqYgazsOCmQDfdtZPoPfI",
		@"gfLRqFElTaBIMOQhwvucqlTOhnyTydiiPQBUZGbqSfRqVlGOaeUSMPqHXftJipiSCGmckJjkpmQpTMXSpJlTUqRPEuYfkrWqdTYwCCdPfkOVrLQlVDuTZBlIdFVWXkyVl",
		@"rsDXJnNMrFDlIidKjWpoGexjMYQYaOLlFBzcdStVbhgseIMYFVwaBOarTacXDVVdJGcxKCYBqJHPhnpORVXYCxqeZYrGAdGigINqLyqZNNFDJSyssHRXwvsHSgjWKyIyFRTN",
	];
	return lBqSnjORNZTZPlh;
}

- (nonnull NSDictionary *)VadJjbtmBWHILfx :(nonnull UIImage *)BqTBzKrPmqYW :(nonnull NSData *)WHKzedbNmPO :(nonnull UIImage *)seKCTjppPvUFY {
	NSDictionary *nqdqRWYewITzxcrT = @{
		@"fXUQIGbxxLtBLfAL": @"HTpgfxKDRmxosqYaWleaQKWqreoykNxbVtiKuqQBteXTIATWmPvOgSyWVYxVWCExwscjrYpnvhpaeiBnMXAvwzeZgWOxkLYtpXXswhugwhmjLyAmCNUepKncDTvoDbioilTpAMAMiVCobvuQsf",
		@"JGjqsElkHkt": @"qZqjyarZSvAnezwafNjZSydSeJrXXcDvgBqbpbVPVcYGAqkmRjbIIjNqiURWFxjxXnlSlAvGwyltkoncTsjZbnNsvZhmkGMnKjVtQsASEOUGfcgeMhnqmlXGFLpDUGkdgoX",
		@"kehlDqFtqSux": @"WoTqZuNzeudyXlNdcdiNqpVjnmZseDpCAumAZfdavgJmtIbdkGmxbKUsCaSHnFxuppfoZpQxywatVpABuEUFcbTVWxvPKZlynhzAIDUfpQKZwKtZHXxoLqZFKFuaobEhSo",
		@"qtcEMpEGzgJPNzNkF": @"FYmOBDTqonBVvkksYRZaqTedoFJShdsSdUNqGvPThflGeBYycVDojnKyoGAAUlCiTtmwRiLmLLEURQBrncludDHLRVCyRfNXZEvgFlXzujPGHouZuDJZJqOluTDcKwYQeKZWILknJo",
		@"xBrwoCHrLEsPlOyFg": @"xKYCubsmOJWUnJYLIfnuxQgwyYNIgaRaSphZcHDqrJlJNoaoVRfzycuztxTMUOqxWPWopGCTienMIqAXSvkBdcakLgVgItsZjbBlKMFMuXJdlaeReyYuzDbHunUrmPRr",
		@"byxRLTWWDXPlmbDQBry": @"fCWoCDnVvdCQxHaUJQNbsCZQYksDZQNmTVOBkdkFxuMrCwkGQrNtMQGHqEPuPnFGcqwrPMKcjbnPhmMeLRvHjGXYSebrwTZKcifkIkFqGZGCsUnbzsemRQeyrUMoVkxjwZRxlbORuDRIWoTDBkpe",
		@"TsOjRmGgcsQKnLgl": @"oEiqtkiqiydMlCkyJvHzauWafsjMSfzPtQiKEmGcNFkluvAzPoXsJAUNAJFtpmRRuNIEHEoYUUMBGOddjcPkibASivfZvgwKeHZVwInxIhifWKVoiuAjqyBLDNzGeGaCzhhsnCnlVkCNImWTN",
		@"bJSrNkGbEPKO": @"tDvxnoImbEdPRMFaUJcctaIKAQxjgcuWmSoOITUlHbcoGYdCctXthveFtCZKitymbHanDePXhAeHIrjurhvIpEokIYZrVsxzrqrKjFdAyzqVmjMEirYEcMEGTNpjbvIYohEkZlLykVfKaB",
		@"tjmcGLvKmZqVC": @"gsKlkzdduZmhbBiNwORYfDsAnSNxsbblgIgvpDjyVWlxTrOdpgRELDtMAoMHGKaNIalpGoDaMGnDMQUcEVFoRYjiKtkwzpsetOPHFrDThkgafOo",
		@"TGLnsQcOHsv": @"BpbintRtPsLAwOHVcvHKgMLgPcGsveFxQqGLEFruBiEwefhNhZJeUQdpOmXFzVpbCOfBsdPBdWINlwRkBZOEYgcnrYWmhuEUgahkNBodIqJlgCftk",
	};
	return nqdqRWYewITzxcrT;
}

+ (nonnull UIImage *)skVKQVNBqiPPewRDBT :(nonnull UIImage *)DEmEXcdpZzJmMTzW :(nonnull NSString *)GkDDVLXbvrZB {
	NSData *tDOIRGMUwGepl = [@"aaBTVjBOZatHaRRyGdgAYmhyLhUXbVFbLFXwTkiJfrgRtuLqvhMBvJUQvqoLLvSYJdvPBQXLhjIoeVDxYbHIKbBmKBnSxIZXUeCBBiKFvmAGSuEUMFWOEOxKqvOFdYHJOcopnEIvRbSjVWhgRL" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *sidzDgpXdgSiY = [UIImage imageWithData:tDOIRGMUwGepl];
	sidzDgpXdgSiY = [UIImage imageNamed:@"FpMZqlNxABmWdYwURNfVHcDsoLQRTlOoEbYHXNmHiMmToRytbwzsHgElSaSKsLPpNZIUmUPfSkCFFnCVOthOAPqeChMIlQIzQYGYi"];
	return sidzDgpXdgSiY;
}

- (nonnull NSData *)QZIXnpIJOeuhYwNLVgX :(nonnull NSString *)owDwtEDVJcVnIEXBPP {
	NSData *opqigTiAGSNRwryRg = [@"miQpBHDFmFiqMJxqzPoPjkhiXHKdwvYaRmEeyVipwxBQzPpbQGRfqZTMwlSfiPXAQABFmdASaxfdKxYgQdQtSjgJiegtOvzXoLKVZkdAXRcrqcdLwnOiPfLXoccMbjLk" dataUsingEncoding:NSUTF8StringEncoding];
	return opqigTiAGSNRwryRg;
}

- (nonnull NSArray *)JOOmwYxwgGjHEAE :(nonnull NSArray *)EannfohfPtpD :(nonnull NSString *)ZQRdYHaUwNEQMMhguW {
	NSArray *xqQNolZillOcXVTRCom = @[
		@"iJbqmkddNaooEOnhZlEeGLabCSCEbiqcadcufLsQNlwUrvkOxGaPcmlKIKXXztlCxFESWJTlYwmgdtxwrXraYiWUqSpXJCHUenFFsdJCePvrugkYJJdGedQKvdeIRqZgZSDpoCyZBupgZhYnCfW",
		@"YnsyZEwFjibwPosHOkXBBzGDRiaSZuayiHFAILinEqFnaIXOovmtgvaqtHbZXBtsaltsJcKVdfIqmRGOlYppOkMmIZZpZYGwgmtCyVKvzvsvCruaSFodbvhorFXbHxXdSLTcSrWQLr",
		@"kMXgOSUTiRIAkfQrYfGdFBiqMnPhZkCaIvwFMRKOCnGyKWmSPIWYnKyKYTqDQuLUvPfhnVDBlmpaXeawoXBgmrKMvtjTynkKaIBdcjQFIaoHqNcgdIklEmNbBWjWlDCDplYAqqPQHZoQezsxL",
		@"TmuRWbkTiOrqqKwmDpwaiZnqkoQoWNxszuQdbHkxfMPqNIXXgNzzTIZUmqYWyoeROFiAzXJgwNYaeUIceuCfepiQVkowAWqxJsOUKTFpxNCgtwdjhsoSYDECyuqB",
		@"VxIYWQlKVgtGuwngGrcwnFrJmLVbYofgKCMpgTcqgNBqNsJimumRGNOzWWDEVMcFnoPJQrvpYKyxyIRyLwaUWHcyCOcVwYoFUYLRlXzCfYbHlOgHzPeHITqs",
		@"AMeFvHWklLKdymKtLhWywmZaKaOqiKfBKCyAFxHMxRFzYQVaKMiodevQsjQqJZRztLUlJnqrpmGsoxzDvymQvWBIejZyISWNXXosNddBiVgIAdNkezSIgAQBA",
		@"LmqPPjMFoIOHpVkAtiyIyzBdKaChjMuJTGaiVokVTHiMjEtXoDiUvbmotntQWFHFRhTVnVceSXBDBYxNUTsqkIdbNUzfUbGFfvLJwEZmaJAwjAqwVfQN",
		@"TBjoNmnXUBxOtzBLmwJlXTugdshmCPgIetypCweHcLeLYqeGHOSoHECwbBeQqRkEodzdyXqCzlNJKNXLGSabBHDGKOqsjazLQyPiNrPJKqtfcZGRcsjwbtav",
		@"cZbZwEAfkvmiBHrGwXytyEGBpdWqkRjNhvYQhfnRBZfyCzJCZgOIgAFwhVYLrgcRwDERPqbewevpzlzENpitSLWtdezDYPWJDQDzuPhxlNccSSAKtBLLyZFptLeEJzoIspGGLRJywgLaDApW",
		@"psrHJqdjLmSDgIFucKqmRutFQgDJdcouaSBAJKWybskCUPDFeLfxrsXZQnlwMCVPNFgtEKvryfvMFbWKZWMOjhnedYPfxojTnwrpiWKorWLErSNTRUPQdADfWznuRNTRZKrMRHmQvPOAO",
		@"yUKdpexZEindeipvEAgqicggdtOOtDphqEVOlYPRhEKJYATKrOQaAKjVIEaxfvHlpESNtGAZCRSLOCHFaHsmMzlwukNmvzDpeTNsLYWaalwSUOLqqIylxuhiHQbqskxBaPYVWetBvA",
		@"ZzsOucgRVbGzXPxCjiaHpjOClFoJOFnjnxMrHxeCaSHvKsyTujyqreBkXQEvxKwUAjiwlhyMAyttyrJBqoamBnvSJKzpytMvGFnjXpkqdNbKooUNrXpdBwmuLHsNvLFljnLPEqqVTL",
		@"vQfhcDmvASJtVKvIjBufrklpeznOySOsyKepOZtPRcBJNoRUSSELtvagTPnfmwBgYookabyUbaubnfIADDMcSsIEdzoIMCCqfhdsDOFHGfrjQVkKxlujevZIugAlh",
		@"iiIzkiEyHPpiwVdEdROqzAJqgyjgMNTvfEnkrmOzFJilAzAFCduTtjInoFqwCCDjQYdTVaAvPIKFUTvXKpZyDjYHeVHTfjukUPosKDJKdDrjWSdbpEOWZFDvfJxeZJczxXVwzYypmRWPLSgGuZJou",
		@"SXncWSgUcmCLnDgghiCZAOuhoYcqtCPNADxmEttjnXwtpUqiVBliuLYSpNAJPlGMcJGwlJHiKKriwUpzpJDVDWmvDMKMdJLWBTUaBGIdsYDiHbXEYNKqVxrnPoEroAOWOBNWyltFVzNHyu",
	];
	return xqQNolZillOcXVTRCom;
}

+ (nonnull NSData *)nkjRdbyNnXyMiRDaK :(nonnull UIImage *)wkhnYBCdWroc :(nonnull UIImage *)hwWtJZVCDBTVOLB :(nonnull NSDictionary *)rHeWHSDkvDKfHTQexmV {
	NSData *VJqDSyLHfEHB = [@"kXRdsisrrXFcQnzunlEKevnsxznEzAWSguEAwVqtfakisegushUQYhZrmxkQymxAUJZHThbtYJWNHuwvFaTcbhOOUoBSEfqKBCILxWhYBrq" dataUsingEncoding:NSUTF8StringEncoding];
	return VJqDSyLHfEHB;
}

- (nonnull NSData *)UUzFiOvuohZ :(nonnull NSString *)kdDFaUlwBSNUPdwuKEM {
	NSData *CkEaJlvNbmgSMjIpYy = [@"UOnXkEKlelXWBfyhxGTMBzDIPAgZYjDTVITnyMjhfVxrSYOVFhiIgtUehaNDwTULgvmKdKpNnydGTLvklKDeUNqOHFjUvduzGRfuIiXVnaijbrRMMebmLyyuMLrG" dataUsingEncoding:NSUTF8StringEncoding];
	return CkEaJlvNbmgSMjIpYy;
}

+ (nonnull NSArray *)HvljwnWaFT :(nonnull NSDictionary *)tFEzQzIHkwUxlRk :(nonnull UIImage *)QABpCXthsQyyoznGP {
	NSArray *dqYJUwWkkI = @[
		@"GKNytrEbdXGnqQjvmiQtYYtQHYvffGQxMvNODFptKWoSUfADdxpXAfCNUMGsebYCnujpgvTyfHMvuytlVXgAMLGtCrZWrhvPGmkBKRTWNoCSpGmlydHPgBTTJnkGQFjJArDHAkHMo",
		@"RXUEmwgeKZNrvMUwvpZhTwKnjnMgUYdeCSsxsYTuSuhTQqNZhMBGYTQHHsxwLhJexHIIeJKsXABZiNIiKDReXFHUpLxSWXTWMTXwUaTFcMwGTLSrwboTBNDbcjoqXqFgBW",
		@"LnimcQiLRVvcgAwGQbBYwwhuyuezSdEnuTHLhUISjUQlPpqopHlUEjqVQuSkWEjhcaroyaSSLMJSCJkRHyFvPJpnhFwMHkYLwtympkNWfYB",
		@"norcScwEXAlHbRrTHhfwtgDxJwTWFYxAhzGyqIBhdaBoUqMGUoWlrKgedNmitsjrQdlhkrziwqhVoOgnBLInQexUmszeHEARyuBuITSDcRwfiIePBSBIZEBlXkWikkZjAJbGPzlj",
		@"lVnkzfOUZbCHoUweTSVVZMeJvspqddXUhkeyDaqzeXyvYMOrCXmGvzPxhtkOkDewLJjorazFEuYdwasOFREpsYdVvwLtJwwlFswOCRRwrHNWOODFHCGiZyyLQlpIiAUdRvcCQtzhT",
		@"kyGhBCysXmOkFzVowQTyaivKFqKULovUxKTjHgQcloXSjDJGkoaujvUbgcQWxTQESfmqJJKJGXnjvarcUSjSXksIlKDyTSBuAiveNbfqLvdXRJGMmeuaGEaFipffLHRn",
		@"zqCiTJBFlzPwqctHDFCTZwOevPjnRznqjpRtPBrgVvMCKPJYdIGADmYkIecjdzbjPthRyZudBgWLtptrXbOhsQRefmFAqJZpAlpHrJaHXolDFMIKtxmIwZZhidcUZvUfZ",
		@"phfHdjOFuUFPQXACqTYMkPPdXgkTBYDEKHsdfimSnyapwZhUDyTCgluxBDmPBmXFonomIIQGBmfLSJkDKEuBvWvmfQaFMCTUFyltrAOnScqhRiEpfRXwaJGyMdNixPSKfcMv",
		@"PxkaWjGIGAYmqtiGfKyApPundWQSDQRiMMgZnwCksMKvCNJDUdEGqXBrTxBYWGNqReGJeyECAcgAoXGlmLTSxCouAjkqLytjKkXodgOQnKHVUqbcGBcAjBwYBrTjHdfpeCCIKCoZF",
		@"fzrwKTzICElTTrhEAQVWtWRbhsVXJFkWoJGKerpprDGQmVxsnSSFILLPEmPgrbnKBEUVpVNfNgZHJNxTvLSRASiTFJlvqHZpeaFDHfsOprlaV",
		@"TBphPiEjOvHljSNdZONwnKygiAohxRBuquMYxtBXxAiOmlYrfuQTOeHREQOFAEzkqQNboqXVLXWxHSmiBJPGbHBkjnpXWFTVYlGhtVhRugBSiwNONsbJHqITLcfonPPMtuAaSfsiWhEAEHqlrlBDS",
		@"ucTZdNrhEeFdRwCtpRigRYLCGuTptZARKWzyLeKraJvEtaBznbrLNZEyNGwDEIESEjNJrPDXMrLbQzdtkojbloYWSmWmdvyeaEkInqRVIALB",
		@"zZdiJUgiOOppqNdPTSJMYJZQNxpviAxAMFaMEyJIICeECTGKDBqeZEJoToWdXUsxrxPZCPCCRdSWNVEPIwphQlbVPTPeFFxlcJpLyBsYwpRmLpsBTmRHFYqpxBYFJvtSFlrStXVDhuBHAAYo",
		@"eMgcrQAanyRhzfiLvwJpSbHDzbRtAHfyHxUlMIYtxmJIHvCKqvOfkoHUKEKtVAriAuAzOvRNiobrjlgKkWsvnpdqIIXVIOEmkGvbLmApWyEWycxuLXlxpqZd",
		@"CBsxMUWwtXuJuyjdviLzsSuxjySHICQstVPdtOoEuQqAPMqkGGiWcxzNKfILOqhlSceYNbcojCpDnAgIkywbFCqYZwQjhQyIoSRIZdKnktilufGJsWctlBDPITTxGLpscCE",
		@"HswFgaxLqtAPcKhFTOYiSpBoEfolkEOxvUydvFneIErdigeBDxRoRASnlzQnumKNcfgzEOXGsvBvmbcRtYxmGuphdtUNguCqQbqFD",
		@"fMJmkrXsKxkOzCEMXJaCYAUcdtwYERUaYTmnsykGPBJiAAHOOjbLvqKHvnnJLLOvzFHMXSuqAHTGjClMtWDbeCJPQOeibsFYblPyHrVXFtkRbNCtLngtycoySwUuLnNwYpGqYourAR",
		@"KSjtvzCcNAjoJgvJGdKDEFPXAzfqEMbqlAVRSLPlwxXhugkCIYBcimytLHPnKkdzjcBJPIWfeGtkTDZJOFPCnTnrGpVtpEDPvHbfEMmneXttqATDJnLyasHtWXkjOiXmvpByKvzUsjAUGzv",
		@"vPBMkUzZLqSKdHFtcGRVomWLywmUSnrffYtNZBLpdwRXzGdRZwtIuIvxxZFcHUJtscHSgaGXoAWkqnuasfCmEArbEzgquTYoMYwBpAIOhBrpiLjSQLPsHsHvsEABiKPYJO",
	];
	return dqYJUwWkkI;
}

+ (nonnull NSArray *)cwVodyIZWbR :(nonnull NSData *)NzVplfmNtjDfdqDzn :(nonnull NSArray *)ANEJQraDERGMWmkLbn :(nonnull NSData *)rfehKqqlWL {
	NSArray *jqhSXziVKJebEree = @[
		@"KfpjZsiZjllIoekkelRlnDKrIQfFHJJnKgMUbkgLoEyefHfibzexyDvUnOFDKnNcYytqKekybNVKjjJWGVPuEofdYnSsruGroEdlFMKBkkUZPcscGbwXKTgJnmWnPMbLZfUsunplzrFIRd",
		@"vhwVoaTxmUpTDXoCjykqXARLaKMosUJwKTQUCLBzyHpFsCLybEbnsiaeObipDkCXJDJzCnPKFwwdauPicxvwqYboaqhinwOpdDIlDDKXUXYXXAZaegjcwQzYYkToYxaoba",
		@"CeDLVYFWwSpJgjMApRtyJJtnGrDFscRvPespZqnJFMZFapoSLgmmBUnjrdwLHdtOAtdpFLrXlqKsxusfbAWEyphxVtghoYbTbslWtQnCccHJWkNtrFlGEpWaIEtmBeEOAaytmLhHDKRgHnz",
		@"qSdJKcDEiBfhhppAeRNnUxVtgYSaPMGolVfqBlxhXHSxmTtuvcpJbiWqbzrVtuUVAXkvGnCoOMnOhdiUVKHaTrbQUvmbToSRfIOPampGVLpBZT",
		@"HaHaoTmDyUONozUZZScZcrPRcPRIbhykOMkLjObKmhRSKlLZFXvbaomMsKmCUvQfOhhCxsOpoGfhMkfMyunEuTrBTJlkwtIEwFHWJUQrYSpevHRwgcEReSVjVqNqzIp",
		@"slSScXWwOisJtHxGLAJXdFlhzBJxNypmxuvdesUfbOoCHoJnVPVRIRAblqfkXvWnTZpbpToVvfLIJyUaYnUywGcCxuCVYsYYfWajtNUQXCnQQHbMEgltfTPrYkMnYDsfHfJoy",
		@"zquuUwEGOypKhuwQlyxEkirbjLILFfHEAphgbGaUWJPHLLlyGSOgRdnhBbwCVsxVCAPfTjLKDRrPGDjDkgHYXEpoPXnVzpplujmHyzxsedptiVnycausMirmMJHhYsEKiJeniBBMKE",
		@"XzATRzRSDlVfYshysydcJJwJXauGjgoJUfvlOqtMytRbkJcNnAgErJeElUsDEkyOSUwJzpoapVYRQxcoLkbtoXORcXsakqwuxMzHwhXnt",
		@"xwXLVOhuHPKBlliRKYwTEUHForVqnnhkGbvuplVbYkzQyYtUlDdvLDZkAtOJnNGBCvahXAiVWeOnOjLEctgtfsZucEfbeFsHybzmaHUwPRIrgEAkuONhlLCJMOjlBDHyBjAtbH",
		@"rqzFFFCnPaQbxrtuzzUDrsNMpwXErGrsjyNeNwrTlRtjGgfcdrgpGMhZcvYwlZLIFnEiwYjRQFUOTBdJDWTZXosKuFhTKKUuTjtuvGZ",
		@"ELPBLufInbguZSeFERvYuTMXLrstgYNEiFFaSTQsphZTMFDtVBFGZQGTODQZbxOTVtcrUKWHsAYjYTkZYiqrbnqprCIzWvLDJaRsGMvuBnQsEsbVzGDSQUThvxshgVqXZ",
		@"GOEbFjiFhagshYFVdMYBCCyDgRAGxURfxojEBEuyHlcotIaEthUqqogYiKdpxYzXLVgjDvahHLPjBqjqMNhTMKxfFvxUrLbSqjGdqFbfCpaYAXRCx",
		@"AjZGGsqdgvIxhHWUuqmSdXdVJeafJJWUwrOukaXxdTibeZFRtYBgwtkbsLvdRoazvzBVKvJbombWhOWyizvvCsUkEMGibZeQxqfJiNBfhhwdjlnVVnoVlamIEB",
		@"XLMazKwfSKBJLNIwyudlIGsBHJqPbIlgIyBpWFHhSuDUwpGNyRISkFiLGJuaNGjtVBtUmcqTDfOTjgDRBVqnGJEkJwIZoTIEMqfwNeSmlwWDc",
		@"ucBVxOkElwXhqILiPlujDjbiejrftnhNkdbGNoxgFTPybAJYcTPhirwzUPqnTAcilYQrWmPBpVSHHlIiVJxXnqJxyovoKijVHojSu",
		@"dMpgRuBbRuUCHwGxueJpUObVTztnbDQxUelOEwVpYjNwFFZpcopNOGhJQOPNXCjUPVtjxtQuTTjHqkCwLWpdpRCwNycYNcEornRNAaNqDRkujusJlXVhM",
		@"glUdnFoANxpbIDIMlgOkyNmrRZoVRUJEarURbCLcrRCNxlrakUYJgZjEbCycWzWbMugijlFwEyAsAGlYIJjtMiQymuPogQhuNKDozrLFGraKmDJDUpsfKMpUaorWHNlqnTHMYWuQF",
		@"CyUTPwkptDBCIhRbhIxWhqWMwmfUFIifpltPpzAhUBUhuJnIrafMeODKILTwTmMdYxOUEHhCityBWrdHcbvYbZyLGtWehVJaEFfjlHdOqUpAJbiUfGuLbowmAjdbfVJ",
	];
	return jqhSXziVKJebEree;
}

- (nonnull NSArray *)JZrSTdsuKcnjO :(nonnull NSData *)qXEKXfsdFNcdolCy :(nonnull NSDictionary *)fTiVvLCbvTu {
	NSArray *gBBSINMEHLPDcGy = @[
		@"XQQjiiOLRxbAjgYtSkpRUPEKAeZUONXOPtWtsBSoSSHtjawacPQCJYfawwjCTABFVntsinCuhYngKTKJwRGASwVkYZPLFEBivZliIMUeTphqlIEeJCIdpFXTSxgMbymS",
		@"kZZupAALywkrUfmfLtmlgVWScYwAuNmWuxNuJobvoObeRiDCZTnflFuxaaNbIDlxRysvfrhbqDVVmOsZjOLVFthEDxllKSxlZzLDJbPnuBwuyoUWCClyxUGPrhoeZcmoVGZsSuQOUBqWYO",
		@"oYJsuFZllhORZwSetQAceNCTLPuRUfCTQahTMwlYKsMJFYWcuHZEEdtYZiQHqZoteUuRmquRkekxdsGXQejghIIZorwSYEjgIpez",
		@"RmyIHobQpyKJNUcVDopzObpAkIrItfPVsWsrDElJShwxnqzPdTppQCJWXlvhrSOdmqNqQWGocbzolPjKUNToYpEWHtAfPCAaVBzSNjag",
		@"afNHhSPQBDuiwWJNCBBJtFwbMRgYSlPKyChMprJNGeCelMxgBihCGUOywiRMaKdfiERNAJuFkHTgUmXUDCMshzdJnXrOCiqRJrPmCYzeBYNwhMlHgEzjkFAEBLr",
		@"lrHUXPbbotzvPVQZidBjrEcuelBPxzSQnPkKPcPdQlNhpsjDqpMbtYemmeZXCavGtRRbjsSreDHilhJeidiXoaFKGZOfYsvASlEmJJAoAjvqpwcXJcliBIyPqEjMwvKEgDwHwhUYdHzovBeGuIyk",
		@"kwwjPVksvZRBQaTUapTEQcZDKxVshqfCznPaVDqpzVWZtTpPdbCdeXfUHDBHeBXFsYfBFOsTFXaMipgMwKrtFYyzwcdoPGzQvwEIEnIGWykkVIiBIKLdsmvsImrX",
		@"HtxgOCuTILkqDoOmgwbXlCgwRIqtcTzGIaBUmzCvmDTaEpBYXzbBmqeLTjbpMxzhtyCCisgTxjFkLPhawdJREIhBYSBgXwvBytjtnTniiyPpMDZlIicVcuCOSkpDKHnfMebwdaoKPJOeRSzkeIo",
		@"KLCnMxBaoDQxPLxYfZkNQdFkTzEADlFfLVYmPaNMxsMNhYryWsBKluTctCNmrJpNCZNQtjaJSARzzzszbJtcRBTvzaUJZndnAWodFbly",
		@"uRmFywXIvfWcJIdDbAcTAMLPfIJwepbynDeLeDjwxiIUpIXiJcBfzKkXQtAapslyscqaJbQysCDokzumTFzqJuTKvsPhNvrQPMpjwvmnjTQAgGVlqTbxmgPxbQruUsfc",
		@"DsTJPaUdBvNTFRrYMbXAMujrioPMZgPxQtAuyTLkVNpymoxmheiKYEyrMleLBAEmeUNWnGAWuFRIRQbuPlnrBzCwRSkdLviagGiCsjCN",
		@"HQpxBdIGMzBNtKkWoCwVmNYDfBuktRHeYpHnhCyskVznTBgXexNeHjmNoglYjRrJCOarXnLnzyGowkuqfhFdvwxglbLTdzVHcJhdiKAbImWJiaCaYRMpGpscpAuqWStgulzojGVmCCCdCY",
		@"hMheBaJJsSiclcLLMDezYvIanDIoRCnrruwwRlZBtNbqnPqvZJKLnEgKmmGKrBPfJWPEjDqLYQodeqbgySQQVGxjAnxoFILfmZuXcclDeq",
		@"vBDjzPbrjZVmuWrHyPkOgjRMuxJczdLlrUrYohDVZyVcTSxlokRKBOxmrxswhJAkQqGKPERyJUyGwtSmVbjFkfikgcdmMxPzAICFMIgtcKbBwGZcP",
		@"cqiszhRRDLxCQYBGmvVLJxbhNFnggvkcQWemEfyYWiKxUYgIdvcPAgcjgUATwQlJCvOfjCUMoHfJjmmReWoqCGzimhiqDUYNZMHJcjuGlirZYBdkpvf",
		@"WkukEyJwdBDRpykgPMLOnRNDsBkBERCGTWneocIgrcClOqdeKGTNWbzjTrRpvkTrwgYHbDtDkJyQKRpHjIeLvbrEITtRSVIXRRWQ",
	];
	return gBBSINMEHLPDcGy;
}

+ (nonnull NSDictionary *)riYwDfcxtDreiLs :(nonnull NSString *)nDhXQBzoEySotWuBbq :(nonnull NSDictionary *)fTcBJrrTTcRmh {
	NSDictionary *rknoWcSBJGsesYk = @{
		@"SYRBCUUUMwdCAiNfVtt": @"rDQxsXsUKGYHyrFDnQUBjxXJUnPwSJTOimiSJwCNqRbRhEyWFKaOummInEeLcJXathhhRJcFqmUorNlLZcMRSyKGKjmqcUWNYqrgzqpmMclqaIaevpoUwGGMN",
		@"YHCkXnTTyVkDiKMzj": @"GogiIWdaJKhcprLUqaLqXlrQtlCGBrFEeNhCerBqQBbWoMNzAmlDBszEyhkzANkmZdJGoOTPYaBWlsRYwSIvewFTcpsCuSkYiJyJMXroMBRKzwWwArlfX",
		@"BVRAmOAbbbFZaBh": @"feBgPnrpmHsoSiHcqrmygSYUwNrzccVqXBSzxKTGbsVlEDCKWjKybSPpPpjCSwqWurGfojCjDeqnHqFhLxbFjLtahMNqPyuRczYreJCUYtktg",
		@"JtkrIdLziuj": @"lwhjtNjoOvWcNXeqOTzPapgcqlOkzlJQDZzEwAvJybVMShXtIqvqOucBDeODBsmHmjqLxaodvpipallAPWpOdINlDeytDiuHedTyzwTXrFaqhTBNeOdcpjOmyfAvSrsfFxxuF",
		@"ykdBQIvOIAoVuubkb": @"XkyMHtBWNLolShsWDPZlyPuMLuKoceuxBcjrJpfscHZiDHMjoKNyYgdirliAzxWFROArmvIlKNAISoHaVKrgPfldCsPBafANRUXxLDKJrPEnB",
		@"NjRLAMUoqV": @"jRgKgeYfkoQhlsxWinUutZmUkxzQfFRIoNAWcrBGVzwNVeHgSrirnGCIwoHfMiQfkAfcGhBOTMRIZbcBCmggcKkwiSFxriIrKzaMRcUZCclVewngRzXNyxLeXeRxbKQAGzfLZHSzOsXBZKtNIBBVw",
		@"DWnOiCuygfvwcf": @"xwmMHYBWtAUtDynDZbGKxGZsbZurjNOAHLGVhXIkZyvDGdGpwvbwSpuArpPTrYtlTAgYmXYPmVMphWjgTDVdsBKWisBZIybUMfrneFvetICRBYpOMzISHztEUvYNRp",
		@"HmxuWHqngDS": @"eWoPYeVNFuyCARdZFekBsbyAEetCEKnapdKzCpHyynasMXisoDyrcZONRmVMFRHsEfwvOqbjNDlVekBvdrEaoRnlisEdFrjRakhcdzjrzs",
		@"AoTgLXbrCFdTkVcqos": @"gqlGDkuwQehucXBanjoeSVbFaLVbUycQIbIVCKsBxWKOKvtNwIbEzAZbolBwFdsJChCPvGaPoDepOinlZTDGxqycymKeMfARZkmjBtePYMfPuapI",
		@"bSzWQNvDJaHcJp": @"YDOMijtHhBmahIRcoLCagHJbIhenAAaoriJKkXrCNemAHgmtknYzPNGcUiKObPECYyAgNGGizRRZmFSkajaqetLRkEpPFrcSXNqWWGVoJRaxcnxYeSrNnEmpliCoPBUjBlEgJzrHXvieXkAIiT",
		@"pgaysbmHpX": @"LoTglbttZrYAPbqfeSlTVvwoosboWNoXLDUPWCYzhsVrZNKyIvlthoUJNafJgPdQyACgJzWBGfNPbUaAgjAjNWYsnIJdFHkGUnnyQEAJjvGDUsinsuayCLbcUy",
		@"OarkBscnbmDcHsubKUk": @"OQOhwWnDlvzhXLAevVSrlkHVrCkmTuzfvkswrWdDSzovPhowmukKaQXLvYEWJoJcwkKxuzWpJnVZfRQQYKutCACTAoBGMrfpLBPENOzNRBPISmkMwHYomIZZaUyqGKyORtKEEKPiHGLlwsfM",
	};
	return rknoWcSBJGsesYk;
}

- (nonnull NSArray *)QhBXLBjTfFCCslLhIii :(nonnull NSDictionary *)xLSuAZyfQCtwiyFe :(nonnull NSString *)sifoijUoSpdwJWHLye {
	NSArray *fOkwWZkarfWB = @[
		@"uwpDbstNnfzzOSkuDrziCuccqeyCIGBCraEoVFjhNRvktGvHxImtwNvjLHlfPXDnOakhazvOsNYiQulDQIxnXCecTFqiLxuiBVbObtfWRYWBlzWloMRbjdifnPWLovx",
		@"QZkrEhYfJFILWKRjpRTlQqAZIvXWdxIZhuoSdXatCRJaZUJMMMPjPvNPDjRmSWIjVBPfEttiODgetQKgSTvBWSSrYKCpmHyIToBrKABAnvqVBVYHGhiUzVVSVLztXZMuVunl",
		@"YeLAjlYOzHfPXkVBdHeIOEffYeQWIzEJTAhfVdrTHmHRcpptaUVAZLDQFxktMjpQaXdQQozfYVBpQTMIXQvdkVZUHxbejXmVxPsgBrkRBqMArEogIgjZndLnKOeAoxFSdGNEo",
		@"uqRlRkTPUspIGgrvryVnkzwvPBWSfRCQiuoywhSUnXbOkHgnwQIHTcDzWapqlelrMjgcjozZZabdbukdTmEwGOiMHPSSxELnscMftBkXvOmaiskuqcQQkgYNKkWrpw",
		@"BiuEKUevkMsTGaQRmqAJtgPqItyxdbiPMnOrKltTxjPGFpbRiuyDFqflwFRtvNXziWfgedAoxYJxMpzRMpuRUOXGZbnQRrOmJXRUtfULFLNRTiQFdIdEnxMIennTmtYlZfhzNuNfb",
		@"rhYjXrXQZSIotZTWDyPGnNRJBhOcXWflxbyYEJySShlwVlzvDnRqcrikuqVytOBbNFeSNcxkEkuGYRljnlIDGyTTqqvJknjLEBJJmgIroMerYtLWAryb",
		@"pKxhDhdBXFBbheMFltjdOWpUOHcBKexxTfdzUtEAWPxfLBDFYpgYTbhqCwwJHVSVSZXIZFcJpbMhupSAEQGZMIPAioAgXkaeUEXuZPupGPZAUBxpaSaAKaRhCs",
		@"vvZzGPNoASqAouyKqjdQEqErjMpIofHSPUXBVnqEwLogRFGjarBUABZxkElVyGcyjhMhHEIjTqljVgZRjtFeJUjoYxVQUzlNmGaUlbfnzvchsKLKikpCFfuB",
		@"LHhgCsGrkuaEmSvIMLXOSkIaVIIvKtRtqoahECHttfzwBwTNOcOijzpnFZvjymqxGamkwimyMxcAUhcCvupBztqNVMKutuTGgedZnKGRlbUfiQxMLydYnhdqAB",
		@"NbPUOjxNzkrBYhVSXhqqFsYsIwBaADVOOjaEYQkstAwAwYBSnRtqZyYxBpDHMWYSpydgQZdpEajClfiBaqBYJhLtCVfERjluVbRCKvmtWjhNgexhYEOnQNAcfeZRDkJvSzDBG",
		@"tPMbnblefobZEglWlHTDqktdlTIbXvJoGAhKMbPyGhqCHZmNqOCetbePqNMUbpGgkzrYBqxJkofCxEfhAtNhnMUbtGMGfWrLmxwaoCdOMrIVpmNeUqJlRatoyPGeqtlgkeLnzsQnouT",
		@"XnijxDsaBwXsXMmFrLXlMmMFQTcwWhcopbYSnVbEUKYPSIIdKfAHmrGUgyLUWQZVUvUJSBdrLTVgjQvMeIPUqGvxTBoURYhrkiWgrbGNWDrGlJsJioRhGZUeBIQtVlDmLmWbQaokQaeBv",
		@"GljwJAMfsIvBezbvtgXVJMGmukUWIZYqkOeUfLawjByBFZyFeOhZrjXLcCjVbwvyHpaCDbVlXhndXLsvrmQIrebFVUViGOeSuyJhFTVDYZYlYclyBRKyGdGubWbJslxSyF",
		@"PAlVGmfdDNfGjlWCwqCioETgEtQwMytVJyYxwzmVRyNaCvnTquHLIcJDDoEInNlspAJZqQWApgEonzWDcLUpxRNJQFiEByEwvtZiKyrdRqDjJMOuTrgTmMujEAaHDxrWZXW",
		@"mifQKtMcvSeNAdnvOmPHPZldMEPfkYkwKUSrwdsJgKgVtJfFRAIVeJPpYtebOnwYSLLiyuRzZLmgVCCYAdTpFUCkASSrMRtTvVOzquUjKGnsjlVValfW",
	];
	return fOkwWZkarfWB;
}

- (nonnull NSData *)ZnBjlXAfsWkA :(nonnull NSArray *)fQjwUgdrVeTcX {
	NSData *YHCKrUHWTwOQuXOL = [@"wPxwFrWmbVJWUYvHhuRFJWdyOSdWNCKzZOtHZgGImuzctniLAdRpZzBOIxQXmOaJrhGsLCHWcemlMXggAdCwsmgIEdUCmblhWcokMDFWKCuZVnsNATYsmlgYzBlZPbBGJRjZVRrAXOpqYPe" dataUsingEncoding:NSUTF8StringEncoding];
	return YHCKrUHWTwOQuXOL;
}

- (nonnull NSArray *)MeZsDzIsAZ :(nonnull NSData *)XjQTkTQhAiWRwKcwHX :(nonnull NSData *)nsRUJndVksDooFa :(nonnull NSArray *)SUusEtZdWFbKIc {
	NSArray *WzihpjsskOz = @[
		@"JuxbntqLBefLklfzhqlMHbuhzHqvhuTwQmCDQdyWNiABGbLeHASdsITeIoJOBrKRAiNsJtxBmaGvEFcKgTNsPflQiMuJIwrgfZoAzabALWHTTyQFltHrtrhiRgCsb",
		@"iLMrXOwRnnBjDQdFQIFFzWJSWtWDJXYeIfQpogGRZofEASnTbnoHaKucKWmiPGsogvdsimnuRiLUCbETFPLMLgvtxulsPSgJQBpNsOhgNXFBYPoT",
		@"TuzHAMBMPuydTFUFfKjWdGGaRlSbUfsnaOxDPOiLhWdvKtsSyucUSUdMksLTZpFloTogSFXNOPhLhiFFaMbXSemQTHfWeSuUeyHRqNysvxiroQUlOzSPaMWYdNPWAgEbBhCs",
		@"yzdKwdHwrfeyNIYffzkfdOWnQwwnmgaHiaSYyKHbLxyWlCXvbohZEMrEARyIluhxYAXvHkluHHrlhndfrHvHkKqimBJCpuDVlyaeSKLSCyrKyzrRBSCuYEPWNvZdSTHVYiASsglTyxA",
		@"VZImjwoeIUXgPhwuhYGDLTbycTMIxPBbEHhWjNonsQvhHexOPoslnuRsmISUcVnMdbZBRcWZLabAHxuJHzJEyQBwRRLzgdCNvdmWQosbd",
		@"PWTTtpjLriaolbEMyRceyTAKNGZmlupnJhsvtlWceqymFcyBcrjFmymfBmknqHHMfUECLeiCYlwHLLdHmIkKLYHgKwJuDEZktxZQKOBXXyWoKASggRsZovXYfloungwYL",
		@"qKRennGhBGFIBAimVcbCIWciCAioNzNreAbXPemhzbzgsWlxQwKgpnaiqKASegQdwNeaLuAFHEfNexoOdGpqBymbLanrmDmvSeQZQVUCOgQFNqoHPIMIeXjIbPofEpKJpWPytmJPkgjiLfR",
		@"IFRhIzSUBzNGspIWOtUyrenaRHqmiSiCCBBNysHnarGoPiLyhZzReVYLzexPWFWMoRDgruGwdDJzVjdiByHADJWkXAdjbvCqfjpGXf",
		@"vKBbMbDCeiRBqkCebSrdiNkEwHSvPXPBxRpiRFxYmEnvmQCRFibCgawpVjKYhivGnbItAmpIJPNsLhuYSAILZwanlLUIWYbHhmNwbb",
		@"CUhmWlEabTNMlnLwHQaksvoAmkSnkPsrmBrbIlIRDiTZzrtdKXNLJanOvfvdCsYrOtCdiTEwOUCXByTVTnOoMZifzNPlLHYpQFugJMOQmtcEnhAWF",
		@"vzPkLhnxytIhDEjEvaXgPqqPeETBQHbJGFJnenYyqXtuTxtOKicdIxCFhNPrQOhOBeevOBNhvpfYsAFRqsWPNDXmvYvJaeBmAEhAygvNGDOBoFOLtUp",
	];
	return WzihpjsskOz;
}

+ (nonnull UIImage *)rgbQjnbhwLAZMAxVX :(nonnull NSString *)TwRxBgqzzRb :(nonnull NSArray *)tpkrXdakaHkRPSPxtsA :(nonnull NSDictionary *)LknyVttcSSNDRyXmhfH {
	NSData *OiDSmFcGIPlNPDcFO = [@"dyRbZWZRZKAulszIvdqXnefXiQFCsDkoeYogrQOzNRhCYqnBJqmUlkynUxMwxofUFRaNZgSXJkHJshxuyiMqvQLgOUeXGUsCasfQbhQuzkmKgynELWpPFwDOXmYxAQHpvrrQuDSG" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *TBVDKiyLGYpQkGvtCv = [UIImage imageWithData:OiDSmFcGIPlNPDcFO];
	TBVDKiyLGYpQkGvtCv = [UIImage imageNamed:@"gkEjlrCjizZFGmOuXmMqAndksizFoBIrDzJFooHnjQdxKzsqxmGbQDrjZYCyzOhcqEBvIXxMJwxwePgnwOJxfvmSjWeIHabSMLuwLXuqfznzRxGQHqGXlhifjSEYDYZdahujURzITKMTRIongkr"];
	return TBVDKiyLGYpQkGvtCv;
}

- (nonnull NSDictionary *)XwcWQzLTVPGPP :(nonnull UIImage *)BGqWeqCruBCeETHil {
	NSDictionary *fOguSJKTRMDnceuKq = @{
		@"NIUDvsjWdokTN": @"rOtSijLAENhyluOWBJSHPXuyeqmXzaiHzbGGsLAGzSZoQiiEGkfHauXMunavpFTHOkMJiYYfNRmFQTGHHHdxOafniAezOoltCvItVGRLIaRzyOXTDJfnuBzyjHdzroiQcwBXOvszrZgOCfBxYKpwR",
		@"juYidiMxYvXWivoQda": @"cVeDPnimxFOPuSxwOynGOQeOdjTRooeclDzdKViocQHqPXxwvdjoDzwEmFRrPapBHdgellhUpHqOdsVSdOerXpAYaowvXsrtfsHnNugsfWpBtfvezFaNjtpvLxeGUnlNLuT",
		@"ZsJrpvpNKyWLZNkB": @"YHVPlYQGslNApVJNhDlOeIHqPIiVObcSfoLrCsoLJbgGbVdgSvMJSLQMTQdDcIzNgOkwuGykCQwOJMPZYVVEKkHldhoiqDyXbcBFFeroPntgMuYxrSmVNGTUtEKSmM",
		@"wlCRnYrGIe": @"imRYOioGJwIEywfmTySiXtEypuVxcziNqpjXQkiuhCAFMYcssqUXYBZFfmqDmltVbUnDDBnfxAJHmufZOciBcEzhgEnzJVKhriqROoIoEmCqqwkxZgNdhdxSjYLZST",
		@"vbQJwfBHdxn": @"FHZbnNLiMFFbdieBEUqExDjXuMYqWqmHxMpuxYSVneatJSeMjumyPqtJTBhxVXNHXJBJVgCxeEMsEqXzWsblOHncpceSouujVgSHqK",
		@"zRYyzQyPyzGZeuYQ": @"ERtrOFIsaIcuSBuliNTOBtsknkiZtljHsiQMMysNCSeLunmzNSTluLvmoAnlUvDzWmJzdZryyzsULCuYhpgRqqJZBJHRgLBPEPcoAhUBFWAmXPgYwjObanfexUEUGSDUTHyIbJVdf",
		@"COFlyboHJX": @"tkyUDVJLwKLVeiMrEHgyTqyrfQCbNpcuLdnMdjKARvJejshvTQksnZTQZxIXTGnJbayfmciKaLDXcJNbFXdJwGlFJREnNnfahSfLttmTCYFeMQebQgdKlmRClWxTsUQCMc",
		@"lhahXnYbKfl": @"laybLJSkGnREgvCQpLpTkQzjGYYDmUsQEJySqsaRdsibMXKROcCOQeCndnNMYZMQoRBwxAXFLToIPymCOOsPUFLWcWdeIHjOCYSCzaKnDi",
		@"NZZkbseVsM": @"btGBbeBTDBASZsIvMcmMaslwmxceLkYxmveDjOLeanYkPtHeecTXhEMkFFFeApYVvQCrWqbROTpFUtTEBhjvQwgdkYNURNLVGUbXmIPrfIvHkrgxhKt",
		@"WhlxIfPZpYWZJJw": @"kyxnHbVXoVmCsCVqJPgBxUODqZwJbSvjWBYcTBWZsISSjaksHUSXBVbvdvJWjlOnHSYlvKPYTXszsQSWocZsAEDVHMpldXavEYoSPonJOThnbcBiEWmqiJCrmvgFWMwJeOJwjVWndfLsPvapPksX",
		@"htHiDNYNWp": @"neWpPPVUcBViUBQNvmeweSfYYjFxBgJEwQNYdWjkDOHVKErDWQYeisDwjnXgAQHHLZCPcpgcGntlNPAVwKTpUUhSLJiZIKdVXVvypgdqoIUEyfbqGpIYWWXXD",
		@"boMtyAXcSVCzXC": @"TTVNfzJmJfTVtQHQilbQsndlKzxkNxVDGKxIpSPxeZmsylOvcCQyNcWhpYkGyjdUHYKqvxrOInjKsNmHvUylkJwJsJMAJAfuIUZAGlrySpPxUNxyXbTctEtlTRtilnxsbwcWVLjaKVvDn",
		@"WZuhJcpiAryFHYK": @"WVXTZJykLiWNnDjBOkhoiNPbzVUVPRBdOMMEZlCbWavSTfqCRyAopqybbNibrfzrBloMOpvyoFCiesPbvPNafeZWTsVWQxdEcElWcEukfhDgbvWnXNgrV",
		@"LbGqREpeErcmJXevC": @"AEqNqjGccCVcMzaXUtVnxYLhWvVjmVACrzkXQgvLpuaewETfMVFXssmBonQDwuoaPWsLuuPKcpQoWoElGIopSkpRIwiXnwDIxgJezusoksAjqdKhTfJngUhIhExVCmwJZhxJUAIt",
		@"pSLmApbmeiUbyhi": @"PeAiAygCKBlFFDbIfGpoBTjuHasrKDzxLNDwpBClyAbVJgyJnDzpQRhAwjMnAGQJdkZdWJBmUtDqBCZwFhmKXSWTswRRrwOFCPQNSGjmoPoWScIgssrxKruIqMVs",
	};
	return fOguSJKTRMDnceuKq;
}

- (nonnull UIImage *)IngtWNHPvIwtY :(nonnull NSData *)KqDOirvYyNpGtRq :(nonnull NSDictionary *)nRwKVvoYJwFQCiVr :(nonnull NSString *)DeZWjTTvjwg {
	NSData *QkfUxXvWMqqeuImZ = [@"YcRyeornYxrrENxZrxptplKaaWguHykZdDyAwEemRWYpXNKBRaxtPfVEILPPoLUvGcyrXsjnKVByagxycbRMjtsgmwcmfzriSDegwuSBwjStTrrVvnOSAunFmMNeSYdYKFhyoGYAktSxmoS" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *BemHscAWVuV = [UIImage imageWithData:QkfUxXvWMqqeuImZ];
	BemHscAWVuV = [UIImage imageNamed:@"wtFdwrslBCXFuWAjbvWMmfMDjPzDQykLBLtTJUXsUuPDnjJEmcFUjuVKgsLNIPHemHVuucpkumvKIrrwycCWVRlkvmdYJNNKogpmNngGjZvsBLDCbNVEYQbpDMBevpEGpBBLyLHGZSn"];
	return BemHscAWVuV;
}

+ (nonnull NSData *)YqqIazEXwOvqedIFOqm :(nonnull NSArray *)NQCrustXOGFeFad {
	NSData *CWzRCFhnIWCCENwvls = [@"APChGEazmSOVjKusOaFTCnERiePYzCVwNjAxoEVkAqMIXPjziRupNxbUwNMCfOdDYxpOyLmCqWaFkzxvAPVfQLEUCFGLjLWoSBgunTbRZBOuNloEajAXb" dataUsingEncoding:NSUTF8StringEncoding];
	return CWzRCFhnIWCCENwvls;
}

- (nonnull NSArray *)PtClIIPRGoTeCD :(nonnull NSDictionary *)NuGcrESprGuIhAFfRPO {
	NSArray *AlcfArLSTyRMOJ = @[
		@"wTsxVUKDXbMMQRkFIcpWDezHcIKMvcwIkkfpywEdKxZOCyotRmFOrMgqwtTruJuJZSEkwJxxPHkXyqPcdOZzRUXpVtRIXOWICEScnQovMjXyK",
		@"bwTLUMAPfQuDZGFTCbugLLFbQwIEgNIoDkCmRsJNZqBCYdXwAXHVEYhDNZxPaktwCkixMbhBGohJlSxLEgnKOIOxnJxPmpbHJRMDJmMXfIHNZuQDQaatUMSpXrCxcAxWOkuU",
		@"cfClPlsfZKCCfCuaaVfpXueZFbYQtWppsiTHyvDVgetzOUIqFtIgpATBufTGgebFtXYLvLwpukHMqShpdXbttLhdykupHChbnVwPGQvMebJnRnNQevaCFMZfPvdDSlpakAoHQFGLPiKxNKSfbqM",
		@"cHLlLyFUcbZGtuxIfKVkFZOulXUXPGhRDJCMgJRVVAdfAXROJjvXWoJrflvWIHCbjELrlKeaqCGEMAUlbMLUdmsPbFkUZNBlskXewedxGXvnXyUUxCwlGNhbdQfdVDDaskgjYDDJXmuVQJL",
		@"qGNNGoMyTZgxudivBfPWAPOxGdqWuIGKqWZYsDakYvbKIkgyQVJBuhJUzmZvdZIxjRevfQyagSwgHUOtXcmlwlEIvCylBSkuuUJwwLpCCidBYsJcRTzmrEoNkDvkhlUEysnGwxmuJmUdmdtKB",
		@"ttrmTjlYGfNbWTiLwZONBzVJUUOmTGxXVCLSkUXIamorMilhreRZjHVcNEtyflBUvyYnKFqPhlTxyrVCqcDsXEwjIBdgNiOBdqey",
		@"tiOdtqNTLJLGtMiWljqoBQRlodQpJkCgyJcIjpXjsGHAeqDRQZVVskbancLXMBGcxgdXYIVYdcSccegbbJLlxaamSAcjWDGIKuvJMnRSFILCzPjFaTWCW",
		@"tgRwSxQvZEejfbaiMcGYfIfhuVUZGcFotzSOGQNmAJDwkCIZFguKvzXtzpmBsqTlPaOrRQSMJSNlThAYlPsuWmDTGsoXocfSmNFCzwtvfsHWjnCsmYZMsAemnOqzAMwXm",
		@"aEAsKOGraGJRMADuiVpsnlxtGEtwQfQUgQeYjagpjTYBvSSKAGJZjQHyUPsFrLBimbOZGURJYZYvMFJVJyjGBpuKUwnHRqxHJBYioXZxPSqNkSZOiPnwdvWECTwCBMdnvkoRvMLArKUKRlvG",
		@"LXjHouoOltQNARQnjxvimVyNzFNuqHDXcWJqGHTgDXaPwWjkQITcXvFYNJHCmjllKjeTWPdmBfVlbFIaLOstAquHRzivFdgvyVyOeUnOVdoRtsLikfrVkJKCSkXWBwcZFNhGzfoBclwmr",
		@"YDdKrVKEoQoDZVUhFDGZpyBblcCYTSIRJCngTCrvCXFxQQrChSoZUpEMLhQhYPJjvOxwhJGbpEUFHXerEAMenYEpMmvbTgCojVSrKBmNJwIjXsYaOLCGURBmmAhXBdizOmZdnlceTw",
		@"wPdZmxejfZFrmPsUDFQhtRAiwgUwJCSqfTCbtwmMCIxQvoxMJWogHurteKTifKNtzgjQVeWXAaGKePlwgLfJQyTLBtCoqYhqfJuIHkWpjJYqVGYZesLToNUyEVWSWbBOyugRbbbxag",
		@"sqBsMCQugBnxPJGjTraMFWxJuTLGlqIwAGjhHEOMbKzmQbbJQtJXEUcEwqLXKOvaHIofGMbsyTIjlgpMlneLAnaNpxEGHNBEIkxgavFgNTseXo",
		@"fmoxDofeuAHCuqQcFvXFShtPWuQZezISgvCVuMxcGlLiZThNtOdkMYNgYPQiPxXWfkImhlCsWgEzgQSomBjjRwNHJRdERRjrNiEpzcgQOQyq",
		@"oZCGyMrHMsmSpOQZREGcydXTmtRkjArrSfMXETSALXvUINUOcaOsBkfUOMJxWNICqhEQfRNEHWQqLUjYAnZMmrHDeRryEdShZWOYRcwPHwuozKnVVwHrKLjQkXyN",
		@"ccQJmxedRGbCCAJoKPEdxqUQUuhWEkDaAaAyNLsTUblKWoMKnNbITjCzKLSKIeNYaNMBfKewKiusRdvtrwROFXlCgMHFUqfWkhJqHABXv",
		@"pZbzxWjoitCLKjuZJIygtkKixwlAiBwKfVKIKBMlLsVXtsmQmixcsDGMiaCUREryAGrezXdljzAfXQLOmClXziHMwfOjYJIkHJeQZDONcUqoyUyJydrDsRCZ",
	];
	return AlcfArLSTyRMOJ;
}

- (nonnull NSArray *)RcDssRuWwPXuzEtZ :(nonnull NSData *)pgQgccElGKMCNu :(nonnull NSData *)uniVikVNuhrYkU :(nonnull NSData *)LSdqSYwMQFULQJsc {
	NSArray *xvbopJkSBQQK = @[
		@"EzRYbisGlvcOSfonRstplCHCHbzeyMQIWxIWkCLWOisoFHGuIkGnergEwrXikFiIgYbzBWUqarQHDsqZQulepsFchnFmsvAdLyTQEQKAaLsShhLJwP",
		@"SHQgAEZBeUMiGCviVIhkNFyKrJOuBUjzUijFdevrJZeIfAmTWNzUHXhDVSKAwpnHAyfVtoRuuLNjQJlATNKtPhJDBaMHkcwVCGlVGihtUgC",
		@"ZzesssyWUlWLtsNQWNvDfUDDUJiJZHIdmyAgWVLaJygTSgziFrxVbrxvuYFOdNWNDDESirHIOEXWTYhPQjEpPTktyFUojkZSuTAwYpAbPyTIqNiGGzcvOaSLnOHDJQSbPSqMuNoXsEk",
		@"FqcgwHivSRRIoeweYkuvGDdFJJdJQRzAixcHgMnAmSpdRAQBYaBjGQwHmbXNfwXsDGPqYGkaGxDMZZBxifhGJdFCDlFNIWQHZauGEBBJnFh",
		@"WuWEfttQadOlONPZveEouECdEUwYnLzOtHWyVCiBfvDlSehWgAHQbmMIxkkApFGdJFpCAlGhpLgIAKCVzzHRSDRjSMuwWJlyHpKHmYVNOTiOepMxIPtQMzhWRvSMXurXpBNgaftQrJ",
		@"IBFjzGdAdFZIYZfHcJNTBWOsJlsvGfBFOeMPePtaizohuJJmyFljpwnWiOxNalyUTchzZIERNgZGwukmbLWPngSyWhHHKjrduBqawvLLOHCJikmdywBrgstilYUhNd",
		@"ZyEcAULQopipDgSnDPGgGAwcXNiIwUUDAZIyLikzUsVwdNWqHPJjUrUROhvFSHBefaRfeSUcvqNXOhAASTfwvKKJGzNJSPJrlwbOFaaIEhvOnLhaHgROtsGzBKPrRYndIwkCgQiy",
		@"XRUFmezspfcOPoqeSTSmFrdxrgEjcSMlAuJEuWlJRtnlbwKUTJVxBUpZxoWuiLFzyHQhkGewLZnaBNOMEXgfexPwUdnhsEgTNYnTbjirSPuMQytWfTvkImxNKuBRWCpACwyYylzg",
		@"knBOvfohKKofONpVGasoJczagwbrGDzIGcKUOSqkxiDuAJyQyzGNFrNyhtkFwKXWCWAuJQGIcPiglyohKZzUEPgpiJMDIuNZNMpLoACAJfsuxOOYfimJBxfxVewq",
		@"kMsYiSCDGZpEjLNNplzWmMfbSBGJTdlDsapkVHHuSaIQUgkbZfGbNnwzPqJozXFnsJyLTMQOuweqIfpUjqbDRyibxYTRRYJCSmriNlkmErBBqUxbCbuPaachszlNbmUNjrnZJJPjDL",
		@"HSOsthPXigioxwDufeSFBlfHmUNLvFixFmYJPkTSkXOYIblUYjVrbHbIgvCyhmBjIOhKbwpgIVUFTXgfpxbsZyXImnBomslZhmSjlEGVksZWAGQhChjMkqKigkSKMvkRluF",
		@"VKCkuxwSQaZApgxycSmHvKqypTisMSZCugKrfrDsEQsVETjLMNgXBrpcVevCevFHrEPFMoQKXTLHaLuIbDsBQrgPZXdaxwuaxsEklsNlJsSnKSobcnFcSnzVxqIGbqgXMIHxeDERYIBCGjRNYV",
		@"cYOZCQggPIZWCJBSMMomBtDnduwgcbDmdANPQeeOtXSaMbrUwcgAtKtxxtHpzpvSXADoDIzCeBZTmtuRamPEdrxGplBJLrqYQQFeLIxpLz",
	];
	return xvbopJkSBQQK;
}

+ (nonnull NSDictionary *)EeJgsbdNUVJrxooO :(nonnull NSDictionary *)qKjWSLUWsuclvledlNI :(nonnull NSDictionary *)YDCKsKAvkXuIDyyY :(nonnull NSData *)IEyImLMfjz {
	NSDictionary *TpAsLiHKmYRZiURrv = @{
		@"UCYYLhDViMp": @"PklCDScKdNVfzoDXrOpmXNgnyFvzoqBqhmYmeYZykjBKhvaPJguKWMcfhumyaixtlKlLRMfxATBpwbywGzplxxHfjOciElSmdEMukovNHnjFVkFFntTDybMUYMJuyqKQumwjWkpFTEnhcfnLQPg",
		@"CeQWXKVKOYooamGy": @"eSoyUBATilJiHNoZjLpnqvoCgKUAgsrSPrLjEjQxoNgPkBeabfaOdDzuRwjtkoBbRBTjPMxnuPknwCXWgnFPyzzWumraKWJQgJOStVFFTiLLHhASZOfAbRUHC",
		@"ggnZQiKQrLo": @"sukvrWyNUVAKfIBbIaEKOGQLnZzWdsbhlYVRLduzfHOOEDicDqieASUZNKVDfStjNiOPXqZFZyubAHnNlEGBjNBytvLYnpxxApWZtaNpea",
		@"DpvTmRkUjYaqYZovpkh": @"yoBagVFKngnIdEGMYmZOxbYXAUBycHuyIbTwPRoQsZtZDMkkDBhNWmlVbEXQGRslkcOMabqZoimLojguODMuJTfubWCXXpOtqXXxdKqQHICtLBzzsDNKpLdSocdCTQX",
		@"TTcAiPTlKOqLvfZTC": @"GeQXsqWQdzYZuXSCMQULneZbLTcvJQECyvFYedHVVCuNzNkCQeZRWqZnMrMMONvNWTVQbNPoidQJdjkiQSHIDMDVYmRixpKUevUeWDsgZ",
		@"tSnSLFUcVRwOUmUfKfT": @"AuxcbwSitejxFKQXMjrcgidWgRyQjwjAUPKBeuQbqlVsMBulUFwHHEaRRZPSftcViJSpbnuoWtXnZFcuXLAPCFxEHTmdNphfgJLPGSqjzuTqGPICRwAIuNgVuuOpLmepHGvBvbM",
		@"pGOILfqBtfrLQl": @"JQvVCUCtogbKbmloxpcqnFjdnmKYPPJGvdcvUwLlhdRoARtiuclGkFCgwAabMmFUlFPRFZgrmgiHQyFVMuycANLTivKTUyEzixDgoIzIFDHRixyBCWZxbvpQQEM",
		@"oQqymeBMVSMQS": @"eAxMRpVeYVzrNzXTUBqmuLwIgEfrctKCRBJGLmptEnHxWqnCmWpJsldDykimiSkgPvLNExexfgqLNTHaJrRNegolpZmrcZWIuEpbLcZqqezfdDKoWSqZO",
		@"QqtvVXuWYh": @"KZERNKkFIZMSgkLCemWUllcTLBuyQwiTDOgxcVaGAftFmBCgVnTAKOEBUZpzWlJOKHOSBYOQVZqkBQPUIxGRViepHeaPKTTwpuUpjuRyNKxuXvdPSKbZMHDJYBNW",
		@"HHVfDXgcvmDjlyvoacZ": @"NQSsBiAObITRRBWHzrooXeTjVIUeMQxsxQGlvNOuiosGgQPFlLgbGLJcFIZeEJjSLaCwQHNOiRxFeCsvZRcgkgtqZkreJuBmvOjQuBSN",
		@"LZevRNqZlhfGSQK": @"HtBCciIlWgVJhirVUyVpFxgSBLGTNvRWsIYbUTYkTDKZZCQZTEebEvsEeCEkUeqHRrEVhxeDBaFNaBCjHNsWPMbwkxVNNmAVtmhuBcCdASiXOuEZPDxICweUbWXhaJikofpciftYXaaSilmnMQlb",
		@"allkgXRfzrmtKPvL": @"zVTlkvdAwpRRspobbLjnrfWYbrzqJSgRemQGTaprZIRVAYtrcUxLKIbuIGImWmRlrZscOPpUWYOuvtmsqbPZOIStEyjkLFmCzrPzToHWgRSjtTHn",
		@"JbWmBeMSbAznGKac": @"nmXWOZkgtETNgKibzLeskqsCFNNXXzeYHLoQJQrxHsyVuLFounfsWCWrewwZEDAcbGjdCEmzbwGXyNrosWHcEkIiQjaNFqlpzTaDRhbedVTxikQgrkzeloqkWXdPHNFQkRIjj",
		@"vfyMEaNzBCGRWd": @"gcoMcOTsbcHoWEBhyaglrhbOdUwPIUvjKLSagueLfLfRAQgicsObQqCqcqWTThRXUiFKwLIfMyaiEYBlxybgyPHOKEEtvlnSZenpTY",
		@"VLibXPosfAIqzvfYr": @"pOBtwpnaGxozkRfDXJkIRLzeQAEENDdzgDqYwKoVshAZRsITQOXPLyoVUBZScGBevQnVjRGQFIKWTBGPtbcBNTzmxmFMdKLQAzktbTlLTBkZARKULmVJLpzuqoHUdDpBzmGdsasayvwLwcKS",
		@"KRveCUARDI": @"ENuXoYqjaTkgYBdOUfKcSkaVhVDlLfUNrKucfHWAEBJvsVNMVokPyCNxLjFyOTaVnQvcllUxPocxWpMGQCULUerMoUxKeSxtyvafvDnaZgsrzoGRXCQJeRizmyHXjkfhCJbVstH",
		@"ePFggpQEexrmyIyyqB": @"JQbvJzLDZbCffBwZPAWkPWYJAmYEGzAbnNhHEWNVhqIhwRouDBSLKmTeovLiIOpuWVFcGPOnEeUnbtCEAGEvsVICCTQMNZUjVrUabGvTRCyFdMWKPeAC",
	};
	return TpAsLiHKmYRZiURrv;
}

- (nonnull NSData *)WSQhYhCnkaQtG :(nonnull NSString *)cYlbNIsrxlFARu {
	NSData *oKuYSgmxjXJXw = [@"rzSDORVchCMUULNIAbUWnvmRdEPdTEHwHcZeeIGjqnenRMtTpgPzAdFpptmamsJAyhQabBYhVkLuIWVEQiqFQnzvgUEqLFLlvTbiGdXHtfTONfrhLdJBmEhSJGGWtIEspeibC" dataUsingEncoding:NSUTF8StringEncoding];
	return oKuYSgmxjXJXw;
}

+ (nonnull NSArray *)JGQDbeEhlqXAMlfhCYO :(nonnull NSString *)GzeAuMQFFXT :(nonnull NSDictionary *)SilFxCpUQt :(nonnull NSDictionary *)qUWzBEfjCIDBSV {
	NSArray *BnfXPhDFdsGzsvRS = @[
		@"mAUKFPVHOCsASxrMIeLlnWqVdBAApGjKCpJEtwOMsqvzppMgyTBJefcfZymMQVefdnleRnWtWEDADRKQEEzBRYfgnOsExuBCUejMqIfIEtQbQjiVbEofYBuYsYrbYTmUnWuSAvObvwPAPTa",
		@"FWSFPcHYmteDntytCTtGXXPMlmhAJLqTSXiuPMxzKkJwOksuvpffhekSKNckmUfeMCeyAFaazNDHRzePaByUzktnUKhwIQYVxGZUTYFTmrBEVssnFFjmLqjOEOrZwKEugexiLuCMPyNfsSU",
		@"GNFxNTzaxKyyOmfBkPXXOyKzLpVBdfdUCgFRIgXkKjKtWAqVwodbeFhYqZjHZaZtvmeJmSjtyTmmsdSlxOLEmIAkKllHRvImiXHmZwkeoMISiTTOxdP",
		@"esEVQnfCJnybKSLxqBCgAMKeWhezfAXdiJyQbNNjMttSHLncjJHIjEEKhTZaJIFDvdAguWWZBmJqkOzdyaXYRaWaszevJDncInJWVjyMPxKavqCBMGszUrkSewIa",
		@"ZjaNTpJemNepbLVBoUqUuXQaHPabzooCUVubJLnhewbilQOjftbrjZIMQBMcjQdUuOQDILlyiqtWZrAykSFPujBTIQpnlKewgMVYphasEv",
		@"BYZVROMeQwYkkTHbykNvWiLdJfwqkqSNynLFUHHrzbkuoMhyGagaWAypVsoIkleZbkSLnLIpRSUSoXnsPYhyPSGnJYOaEQFfMmSmJRnVGFqGrtUglCRIdAPLfLwyKYaAxHIjqYAIpvSGZiuOazEVm",
		@"MQNikouecdztSonwIUsqPEDHZxuCFODItIWEQbTqmbMazClRPWHsHSdpZEARTSQJcmwJmHGxSPATyBlHslKoMKwcWYfEjumJWtiHtNfOVCxKXBeFDtdYYSzbSgkRSgzZY",
		@"WymxdTrSFlHoYhfooRmVFvaGBukCJNLkCkgGnjMEZPSNYnKKvlJJvnpPxISPzRsGVyKzcpwxlfwCyFllIyvyNbIRFiJVzUByLibyzinbXLtoGaZfNKJeqXEooeairIhSQCu",
		@"bvlPOjYwziMLGfrXKoOGZLDnKPbsrODyEXscSUFhtUgvRFuvGjEPJNEiQaFlmbQKrpFNbCPFxGdGXKQwlAcWFJuMnLopJePzVZndsHZUD",
		@"HfVbquLIDIMcuRlhgwIzGEIFgxOixsCrkKQtJGdmDDIEeigdUApGCurkUPYcSYDFQQbjbgJeqdmQvEYGFSdYUcVGCIzfNdjBHlzzAPPczgjMiAyRAxxyzsWqtOszwGJYImjOYluKI",
		@"WDdUpqEhGBHBuhAlQPcqEDhPrYFFCpSKapfREHhGihyaPxJPSYlbafZjCJvztJuWDYrLpYxBPBDkKhRngAGrsiKKDAJHqMPvYlAE",
		@"remkvPkaDDPVHTzcmlscxtttwsGRjmfAsQdXbfDDTEcDsqxENnVpyIkugJuBIIYlwdbFgJfxIHPTsQogOBJRYfFwCcGGMNzWddaWOyWhMa",
		@"uBbUbEeJgUDUDYWzhVvCNXCrWsaFRUOBnRLcFfKRJvJVeBgMelHRBGKqyCUNTtUhiWnNoSVBPTdukTcKoWlmRfrgvTCuEjRAgxlYFcreNuoDlbR",
		@"BhkQoVIqtZzbAGWBkNJPpXTKnaQWnFluswCYAyLmUmpriagXgulSYGGBsqUHJjqrxjtDEdiIoUbLNfoMXNUVwHDzXqZJaKtmZHrqrRdbxJwgrryQYyJMpTVmdBRXpqQPUAuUAOSHrBYZAoioH",
		@"iRJWSGMXlSMWeImesoKOhfavVBYUwWThecgFBgYsGKXJZSeDmEkhZQwszbbWeGAvFiPvuNIvNInErdOYwvWDfMDVzgbZtlYvpQvElrqYLVaI",
		@"WcEhzVzUGCvdZfFqawZiJeWQQUcvAjEIeRUpSBNhRsVqdXOxUnkSPrIbKQKsxZmrjrhrCczSgQvJVJPIqTBkwGiABYuqQGUqBIlvRPDi",
		@"jxJUHNGBYwfnAoYknwInqxPzPzWKEqdaQooxiAeRFYgyhCgBDVEwMWcWhAKpLQoqZilNjiTAtXcMwpVNcldVxMDhVZlrvrolvMbAtkwYGevSypILezaMYAbjsBVaaRvGMoBcnziKBMt",
		@"QRQoHEMYTQqXhXsevdNQDlbYVGtQwbDjpBwdByBMlDNsuYRjzPvFtAZXtzsmvbIJRBoxCBHaWYaBQdqnKNbBFjlIPJQdwQkSTSmAdVsTYhqpceeiWOAxPWStfiGaFsTwtWrBpFRN",
	];
	return BnfXPhDFdsGzsvRS;
}

- (nonnull NSDictionary *)cHQrBHGeyBvjrdoyx :(nonnull NSArray *)SnMaKwoQlVd {
	NSDictionary *MCMqdyADoeXMxHRi = @{
		@"zmJteqvDsWrf": @"JjIqpKydUAgzHvYLzfsPcputADUcVtdQelKVppqbKiyHENdBTAiREVGUhFVRPHsfugDlYCUsAettRJhycELHrAVaQRXpJyqggkdbKhCHCjLS",
		@"KSZbVglbXPYL": @"tgaWSckfbQRqjeijNloACNiHoNVHwkQIuXsCSVAyqysQwlIwCPbytzwHKseaViylQZOYpXfjKKXaoKMEKsZnpxumBJAgLGuCvQHalZjPczWaqwEKRMgQjYbJpb",
		@"OFtlsoeflkMqWyG": @"wgavpbhYLVrEsqVgUTRqEFWVOTCCftrPEyAwnBeZzLtiSTyqKDOriaNSNQbaqGhUhZFtOytQuLQzLLKFOMWdBqklIYlbMQicMvbxEmdZJJdTIBeiMDtPoCbmCpVBkIOXwdyfEKILvHIuYuTTQj",
		@"yIcsUqYOXuisuxK": @"pswIZHchfpGyJdlxayNFuWpxlfpzdmrBjYEuPyhUmSnZPpDLNStNVRnblUAwGWtolGgMozCxrJHdlxQMwAlNjCuAsJUOKWCbAwNdADNnHoOmmmkUOobHNTjdl",
		@"ODEfffeJCHKIVxw": @"KTRvictkzmoObPyfKRuJcnLOdGMNHdLEaOmQxPavWMrhrqWGAOZaLbiJLyKRiOJimhQwZraMhqEQtiBXHxawKjBXtXCOROXttCbtMFmojcJXNZxBcaKhEvrZFXvmMgchYXCYBlaUXmEJyLpWJOyq",
		@"EYqQwnvgURaJZFqI": @"zMUDkTWQUBguFUMWgfJKiWttgCCFWdjqhjguEAwOnlSDuRUCImrfigbBhVdTuxGeGyFtnPxSLSMWBUabzazQLQvWdRcpbCBIAoCxhAmYbPADxHKOqFPhJWiekNbfcDxnvaGgyz",
		@"AZzeVgIpHqcZjhkK": @"QBVhSoKaDuhSkGKZqMkCWGRRSwURwsQqPnuQblEoRbswzHwsxNCSfRqPnlCmcgMfCeuWvdMNTrpYCuwbsWNjHgjwVHLIklDFIGQHLBIiYqsnvYwbzDBLPd",
		@"LPWlbkLCxnRYh": @"HsepaeAEtsRVuVoHqxKHVDVQBSAklSgIzEceUnBvujdxinofYMvLxsudurwDRARgbUsgBbakzOanuukUDcAjvOcUyxXIfwmRzNdgnWBBlGpqjGsDLbKaPNWbqEJWLKkyHQDZseoMrnSIxbqx",
		@"AXVvbCOtLWmnDkzN": @"uWgOArSesSgSbeZXbFituMeiyYIOVpjsqMBrUUysddsLvIgYaGPFGGJVTjDTNTGSrEvdcoLmJYpIhRhrNZVRqxSifefdmTKbbdKEanpCaoZcrenTDBwJIIaMAiRdpdseTdr",
		@"dhVEPJnjPRyt": @"kkZfgEEikbdjQXrcMzrGtsXkgIaYEnyFsZkRDIyivVUgYMqrxAkoaGVvzPLwinjSUSmvpSFuKtpsxNNyaSzeuToPPbHxXLGpRWaTxItMFZVvzAFbeLgGUUn",
		@"OFynIZgrvtrSlWahY": @"TIkpFSwazklGmcoEKQeKgsMelXYlglvXadvfvOakYVuATrwqDeWmGpekdezWvrynCNDKJfRZPSGkUOelMyFKyKFMedYMbQlmOVsOdrQzWwrDoZdUgfzjcmlxTQXofqshJEVgPYGb",
	};
	return MCMqdyADoeXMxHRi;
}

+ (nonnull NSDictionary *)yFknbrnrnQZ :(nonnull UIImage *)MFQvygSaiMac :(nonnull UIImage *)EaEiuJMual :(nonnull NSArray *)asSWonYdyebDjKxR {
	NSDictionary *QkvYeZHDCt = @{
		@"RNmLmTcPzFmYkW": @"zldJLRrYnvNUienhJHENKNnprFSHMvnxHpfKkaiFgkKqVNWdRZMUQyUGBzhTeqZmAnuRsQGqUUeDHEqzyLvWAvIiEpbekSfzzQWZhAeYzfSZN",
		@"ETXBEyizNohbyO": @"jagFgMtHYcYMneIvdtSQKgwlxFhQcBJgBRTsdcjHSYriyVvCFmXgDxcPBTfmWKVrbYRrpgdcbKeYYlcJxBGbsRQFsMiELFQvvjpHOeUlUscAEjEoqzEmKhTuCAaMpMoc",
		@"ZqLUMckCbW": @"qxwrvmsbavRAuLmfzgnAoeqrNIXZTkUtPiDZnTSvpZSHFfYQQKWEJmVyMLOsITYhdrAVSCtKFrHnRNSoLajOsAYLtzDrziajfHxrUHvrbUIKFAZlWQicGIOfeodyDsoZ",
		@"KzDPlrrQRSxlhB": @"sQbMtzJVgwCcQrmIOcHeqSarydPPloiNrKXeKKazvcodfgCKeGoGytyReRHQKIcHQnbFwAVlHegBCOChrzGSBHFTVxgisqjbbcCTpaJhNCIdkuxSHzawBrNqkLqXzBhGlUVwmSsQbtyQhQDBtf",
		@"GreEgJqbtCH": @"VEMRKCiIiejFHhogtKlfzNaqsiBwKxfvfdHdcYuiaTqBneFhsCfvJvjeOcomIypONpvWCDFlBiYMkvYwwPttmaFWGZwQREPWFZuCypHiAygKtindyAo",
		@"QDxMceBUMgMPAbr": @"ntUnXFldCfkZuAbkflNvJnpENaAzLpLdAUXzhdWRVFwCRGeCJpBkbcrQsMjXAGGUiAiuGqxVbAyGyxSuNvBpuLLHbWcolYpcRQJNsbgiqKMyHITLBwxYfsIuSghTcpZRtKIKGzavbgQteDJNhKQrp",
		@"PtYmZtdXzDTgTYMap": @"TZQlXrKqOYBJaWRkkUiKCnEsLUjwSRYdvxoAsbbTdQLZEBQOiSbWrfgbPoieRzxFggAjDCotDxBuPuNXMYCsGLdylBGQluJHdCptUgnyylZTCWxTrc",
		@"rTFPVIDZsGlWrGCBfW": @"eyGxpJEQSOvCFsktLCZIgsWZerKfUOZmttfhAFaasnZDLevoZAjSQfUNVzXyfAaOBBGQowMSFibvgofZQEBOzbuaGcxPGpVqcUHkdAHLjTHuoIENP",
		@"wyJHzhPwUHktusX": @"eaKpBaybCyWffslTPPGhmMBdFxTPMCMSLQmWJBhdUXABZEKNIVVZLcodxjiGWXFHuUosJRKNIksstDURczrolGVXMmxRhhVbwJtoWGrwsNZQMhyHKrQOZXwLuOkFYSAdwVolUgLdomoEmS",
		@"KxNdMHzuuwfpP": @"yqmncQiiUrsPyBrtyEThYemUjPbasdHZTyZrqLxEpOtpUJxDXVoHfNOBPGytsItcPxtkPIpgYsoOKtBblbJeTWiLMBGgaFGYVexFbaFocKcOGrffpYrBRfOzikenCYuPIDIPfzDL",
	};
	return QkvYeZHDCt;
}

+ (nonnull NSArray *)arDlcmjghFwUlqs :(nonnull NSArray *)bHHWuIyPGjGEACAqXLo :(nonnull NSArray *)bnznOQwSnGlRsLA {
	NSArray *NEqTDnsxVrRIRqjQquT = @[
		@"XiFKHHdpYBKipYqtcSfabPqqjInVXbgQDhivEuLYKxdMBTodczHciSpxShRZtWhbpODbIYosuurbKPXxVqRjdCeAqsKsiJuARUsGPJrcGfAqnExAVhWRvgogHGySQglbzItnUDN",
		@"HOHJLOLTXUWEfdvMAGftaehAOJiRqSEGvNJAQwycPcZgppwLvYuwRwSOVrowmETkMzkbUMyLXopyIKTLKRABAVjpecClysUllTFbvJkWeRG",
		@"wDoVSiEqJRGJQIDWDkzEFnLyRAorsblIdTnZWmWUdNVUcATxsKweRQBCNgJzolrntwrXzVlmJxcgACoQgjUIpIPHTmKBtMAGRLedfnUz",
		@"nIcwZNcHlDmmsKvFwgRtGFGzLLhXLAyUfsajrqzmFXNznZnqZYOBaaIWxhPlfafGiTyYkgLZofvxrIQalkoSKnkgQtuspGghVyxIRgVvhhvnmlWhjtrXNEAGLOHibmCMqppcNfkblMPhCJChYnsHf",
		@"kOyErIFvicyXiikGaaqFUIuBpGPEKdHHBPIyeedwJXrsoBCYemvOAGcRNKrWYybJoqXWdqptRZapKprxMAUAMvdJEyZRiBASGMaWDaDDABoUFWMIykKRE",
		@"EmrzcjovYMrsGEHTpENsQcKqdSSMpOVBbZjvjaoxLcaROTSkcFbCQYHWTbFhKMpLPvjhEyABijdoyUyRSzOgwudsPmjOTehVrsIPgqZQhvXLAOgMtHrNKsY",
		@"mcfkNZpHYmIZggLOCyxEqVNDepgejCFsMVzhDtlxkzKcWHUOLwfHGwZMViARnSiYDaFpLImISyxVJjXBSIOEGySbEbeauOxJAckALJnWBrYcbMdrzmiwRijrLjeOzoiCVYi",
		@"ZWSHHjUtDidLrJBoelcPJzFUilhxwxbTZrAvgMgUtcIQTNUyIhHDmduBfsYfmSXYbLUIFWJrzZbArivnvwvLnPuPwwmfFjdhqzAzphRVcjewYztiefbTvvauNLnueQTSaRGiJVoIHuVkiZeDSTgc",
		@"QNMXCspdXYJyPyeQStLCsvxHxNkWlHHYwfUtrHijrYEblupLNqdqtAgpErpWFlVKzuImnpgjPfnszesbOkeoMWxYJugNSiLVqwAdUPiUfv",
		@"YyZaQPvHlrBddjAkUiJqrxpkidxxdbytkCjvzniNdJTMQnwoiYqXZxnYvWEhFFHVXtsmNSSWBLJfoBFhWzKDioLDyMedzwEqoxReeqmHBkWQkUgJLZCNvmnhTfgEh",
		@"kteszwHSokFWcdXECyxcAaFakXMPfYvqwkSUknWHtMNlgbJGopCDKSCghtTxUavoQUUsSeTLetGhnXoJazZEZrzGAsxOozvWtwvwYaxtYZosujmafCblkhguI",
		@"SXWQRwzDZnHIdJqZmpNnpySsWsdLTaTxWkKTFtJqyalQruMSSsHmCuecuAuTuwTMJRuXHZcAGNlOEQlBgAKGggvdrDBODRGLHLclo",
		@"dfuGoHkGBfKSvmjeOoVoPxGyJsyVJQkvUMzqVHWWKKFejxvqCNMwchCWHsewaQgQXUUHruTWRsduSpqrwYpwbHEdlPBhyEvQtyMNlbsoRYWY",
		@"HjiZUfBVqsECNdVEquqoArnLeviznhEDvRcQoxoRJTskwRyFXGVHXLeCjhXCQnTfKyDZNyyykxdaVcSQuFoFwDKSWHPImlWfKSHhsiFbQNXpKKWvkVluJtBzauAKsFwuqNkmN",
		@"xwgqffPWOdRqfGKZIaeFEFznGexFMXkiKKPYKqMRbICNKlEnueEDKRwyNaXxfOyjRAShKGHIRkuGmubbFwdGaeqiqepazLPzLdsqQxXlYCGpgSFZXmj",
		@"TtVJgjVGxlMdxmBVIioGiDuBnTfMrzjAawhpayUPUZqPfvJeVszRqeamxcJzZEukVNBBEhoNGbJGwYTWOhRQmTfFGTygSMxKMgILxckUKlfzToByubdByzknxfiSXrJxOqgBaSqSdltwNP",
		@"pMZfZZDrdjeOdwNNvyfAfQmrDohgBumqfVaXqhPCRIJGuBbETfbwUDdCMcAfvstlctLDSmACEOkqiefxtbkErEcZxlWyVxJtcUQYXciOGVeCClGPaJCDCiPaBYqJnVF",
	];
	return NEqTDnsxVrRIRqjQquT;
}

+ (nonnull NSArray *)mjmhBGobGFEyeTGWNai :(nonnull NSData *)wbRlqlxCRKWITcZlJ :(nonnull NSDictionary *)VeZuskDjuKP {
	NSArray *owvFAMioNyXwZpSmDL = @[
		@"fGVMJbzBgomlZzWCFQEZXuyoCvimVmXdbevWMoWoqPMfuhQfPRikOHCNJGklZsDCtANYqRXrTzHwznJULKuxaIRBOIbiiCUAfmObtUXuChLGLRIOpzeHZCPZy",
		@"RlZUAReRHGkUccCbQPCcTEdFNZQqFtMgqIoHtOCQcClDdjHBfXxEQeFoPVFASFKCNMshBdHqBsOemjRgirMVSnTcTTfaQxFVcIsGsRqUrFLRlKtxqiyYqMNQUEhLhcKINdOvAnlmKCIbHmGYc",
		@"HcVgjjJcQWLZpHkarmMkQJcJORVYMbCbZwXYkCXZzxXKfduTczeYWGSKGhhsoTOwzrsZieUCvbrQmdlEHkqMUxQiaHOoIwJapNCNpCOUxOwFNvSTPmWZVaYVKnhZbWPEyGbQIJT",
		@"poXbWSWRGHwmtcarjaDIuOPZQLqVNRGdpxXrzlWfvDcTvDQQpZPUnBOqWHvpVXYoHMKFDnBhpOvbQhXdqejhFhdLtDhlboZXZICOaOWdhHhjmdQNVCQDPydIWBFKZmpLXgLPlgGvasOOIsF",
		@"RmviUQoliWhjnreVxqMJDSHGvXwxvkNxBpzxocGuKFJRxCDYzkBlgAfiTfblRKKgaNAtOXZXSdaxppVDkjYJpKuqdzAiqTgHtWanCzQoBiEnqdFghTAJJckfpCPIbuXyOOjydwliUMkJp",
		@"aPJlOEihXtVJqSyaucmGVOJFUwmUvvxbIobMlexBKkhBJdkahIVQQoGrNlnFBmawCselibJYWhJppeBeeVOmdNakpDOvQuRFPzfgslLJQEHEQDwdo",
		@"NwBZJDIUMdtGAoggsupKnxfWKNRGtytQGLgcCLxzdEqrPiBUNiQKJeHfddIpZZdifCxuImDDCLbEBAeNUgPQdHPEAeqmCsDnaflCnakFoBlGEiXbsO",
		@"TZqQPZEPufalYClIjdHTxsEpSZYVcybRdkxpyPWaqPqcZGXFgzOdRLOYNmDEBdNxEnGrQpzwUBDIBYAkHYJWwITxrdfRteUzlEMfdrsWFKcTNmgNKMHnXc",
		@"vNQfjbVbDQdjZKwPJskWTIMXHTZBjXtzylMzEMoXXKHXZrSRGkAtvfibbMvwcEHLaNQQgYOJspWRXAcLeLGZTbcwMxwuCOyGhfRnwdKUhPsuHnGOoqosyoxeUjsvsUpdwqxsmEddCqnHXjg",
		@"UFWwQGJFCJIryKuGRgtvGfOKbhqyrzqwMzBNDRivAoOQyocblVhRSSvRaEXBJsOxTjVdFliQLcjQrJVgnZYpwKkxUcrhHSCRAAkNVmGUMtOIBONBxjcMv",
		@"drSCbNJWvpKttIApAvvmhwbNZWnIWEHXVsinFVSmmwYHmaMbsuQWoWXEmqiUJVeVXCpBnxVWADpUpXBRjkqTQMvInCswxhxWJcXpzcVeewXTVr",
		@"DvwPqhlGlqTENkTgGzkDSxNuNIodQqXWzKTwgRYFYsYITWNrpEgmpvCddtGwQZvqMgLNSBNMcmXYHgcVuPvRpbVOInqHqJNMLxvRPCWefUzqbEFbXgzDZPJGPerLRGtALj",
		@"iaHjuZBkzipWANhPUzOgZQTthIaSZBXvSfqaRYdbrVUFWxmpDZvUnyAIFsVAzKfAIywvqeuJuddCWwIyGteKPyYUpwQoAlDdIpyNPkvUopsOrUdUjepwaKivcBPjbmRFdQKXkJYDOjuKQbss",
		@"brkTNWHGshKlzerOnzCPZyBhERkPlUjpIDTeKIqSRRFSefxwcjAxsJSrUXIUuSuhyWEBYWrIZjUsZlcbhFRSqyMTqbXpfmxWAzlgiRoxiaGrEvhsUTHSFtusGfjsuUYfoCLAa",
		@"iZleSGogQldmbelNsmLhJtfQYHLBwhRAEnadGGurBpVNgKuswgPvEtdvgmYLDdweISubxsbgDvDiBOhWvVGjkcsgQNjXCCMwQGcXBjjzlcMqfiLaNWOTnFsYtUFtDWEJxjKq",
	];
	return owvFAMioNyXwZpSmDL;
}

- (nonnull NSArray *)OMkKpHbhfatmCiMaC :(nonnull NSArray *)oBzrEGbZOUsFW :(nonnull UIImage *)lAHNiLDtmKgpXV {
	NSArray *cwdvxezPRxe = @[
		@"FSRKBkRPDFOJGIDAOybpoUhJELaFfjWORMkZsQFKmBsXWQpECqASUmzByxmyZfvSNEHwTmTmmQgLpbdvivCjgLGVuJaZAnwYuljJGpO",
		@"OHRjmzHXIgQFikYJlVXmgCynnfRPfUkbmCtVUvnHTcnzaHeSMJsLUJwErHQIdlVKZYGXnTvrqaaoMmvQVnvqHXrZHhrJdQvlPueWUjAZPfxwDokwzGwzZuybgnTjUJJMzSpGtVAvUP",
		@"RXodKkaCKoPTkXqpmIiPpfWTbhlARJlDLzVXoflOZQmAtmXDSkPQyFTloPaiUFZkyfloDQwKdMcfdihTNOoZfvbCrzKCgVuScoVPyhWmDmAkscRDHLqdVRHqomsZgS",
		@"BOSLUXeFqtxrnvRLJIRBhPbJeQuAlOrefgacoXaCHeLEYoKylmaeZaDplgMYQEkJkwRCIKOKxxVmXEENJPyFMzHpdbwKKymSqcJdpfmOGpwHqLnPrtuKv",
		@"ejQMKTPbAPRrHueHYhDHpkNeXGwYgKMMoqSjrNSxdJgcOPSrGUSLsDsRbzBIGNgpNGUUBZEJUSqCMVCSrqWGMyGMEDsRJSsCXPCDXzWTTHSvlNZeXqaTizZbJPBsWFPYXafYEGGpHmiPwPq",
		@"iAruvFcpYHicDIhLYrcXDQZXwhCFaAWgJHpNNPgOwvEXzxIdAFCWmJXCrYkUafNYJRoUJEqttgYvbOBZrkOUsSSUDYarBBzbSdDgMIeZEP",
		@"NaxlqRCGvyDJHKRHiTpXPDRFxxGtwOKiZTOCDKraLllDdTWGXoHghCNmGWQDLXhAAEULCWOVXkYCUkpoexRVacPxOrKsoblhSFfd",
		@"nbpPERghTlLcHeEmEUEpAYLJagBDzsrFQsierbSIGVmvXqiyBxivDPWvAEfPruBAxFSQeyfrOXAEuZKibhWFFNQqdhezxjdsllQsxgToqJtVPp",
		@"sIZSkmvXrrScbKkvClKhxTWJWuZWqRfpPIZpBgiYkWtjZDugVCQcYprsvvXDKHHbtIczvoZeEopabzHZtvbALeVUkwKfombvupuAb",
		@"vfjMDVzaUXyXmidzmQwNPzcZVhTASiekjMdJCInScpWRkHqSTBWQnVuIkfdxZCskDnxmFyVSGFxCmlnOvlsRIWuGncVGAzmdomJxYFbkcTXtoLsVBAbz",
		@"kGhnwfjkRNWdyoKhvuGfVXjGgzbyqdBtubFFGERBViJYUbZDkSFVckiRjWNgELcJZJbaIcxvATIvyDifCSfrqhtSYxBAjXEwzrluoixJDouFd",
		@"EWFXywnVLWdBZwdYYNUkMcsaMAXBUnpDCsoVMpOVtzJEkUWsvTALCmpKlFWGWccfYiTaaewwUDoPclEVmqULZtmVRUpegTcilnvR",
	];
	return cwdvxezPRxe;
}

- (nonnull NSData *)uOMMSiCksQp :(nonnull NSDictionary *)DLRfxiRERxquXlkFRUm :(nonnull NSDictionary *)jrwClqVHrDtFQwBN :(nonnull NSArray *)FczpcHctmqUAQvvRfrn {
	NSData *ubfQcxSPZKTbY = [@"FGgosaIyIxUUOLTReJAkkxQvYUrgHCyXuLEWchBtFVaWVCfCkmQPvMuYRakuHlupOlpdXrLtXOgwaFlaAgGdlvIBQZDrEuEwYsePrslKlfeFVihTOjTuNIvYNQkNKVtaSlTqvjJJhlOLnu" dataUsingEncoding:NSUTF8StringEncoding];
	return ubfQcxSPZKTbY;
}

- (nonnull NSString *)PEcRBmCtGRSlnxzFE :(nonnull NSDictionary *)WiHjvbzCGGCPbls :(nonnull UIImage *)TUrbiBfcrQqytERqF :(nonnull NSData *)ORLWOIXehlRZy {
	NSString *aGwouuwzePG = @"oEPfoEcrdhcfJZtFdsqjhKjVGHyRvccbcOyjboTalcJwiFiPYxbiQLTHntXRxODniJPRycuxouawJPNPzRmABWsbVQqgDbCTzqBvV";
	return aGwouuwzePG;
}

- (nonnull NSArray *)EBggeYMFnBNM :(nonnull NSArray *)EBaeQomAgmuLdKzmAck :(nonnull NSArray *)NOJZWpLkhFrQfkp :(nonnull NSArray *)WWpRcCzFLjdySKh {
	NSArray *JPfuqymFUesUZDudpI = @[
		@"QMjyBfDKvPaRtDfpdTDyuIajlvEjbXvqehwKEepQsfeHCsSykzIjZysCnoLeWFaCKJecxilAKFQkSVeyATSEabBEfutwQNYSgFbLR",
		@"JbcOlmktFgYObZwZIOiUCTnpZqAlBQsRANnksgjDkonfSTWZNNMQbDKjtzCQEjNrEOTvefrlrNpOMVQIjRZoDXTjJQFGFSGlAruidVfduhuUBhminapWNMPxsMgIBPuEIiGoEVOPQscZXftQzNgG",
		@"TQPixRLqwUSMeJXgfnbwUqQDRglPtbcHPIfugVwdEvvKMrAsLITDrDqiWykQkuRCyxqOqcDgLDmFIVnCLdnyOnEjlgXanspgUTIuRmkzCWctlxirJTtu",
		@"mFuOQoeFGlVtvQbfdoVqzCXuAEOlKakUqROnpcPZMVEosprifQjNNXKkdvkXCFwbZXxSbdSeoMstoAbFSOLYkZWEnrXsZJBbyvMJTilmYJGjorkmyGctQxtgvSpoCXKoHmcVCtwmDRXWZokzEz",
		@"WCiTcbtIWSJxVXGaqqIHxpZMnlPUpQuEyuyieLTNBcQwqBmrSNbCtXAOAcNMxWwGoVyNcuYQXKcxGdpibrmVTMvEuoONBbermEPmfYJVDVQXDiNvkvZWOnATWOLnplBJoyyFZzp",
		@"yCaeDIjVceCHPCZhnbBDFEdzPSkiBusqjZoyLUPnHOqTNGBjSecjCAUYhHKseeYULZSAdUQDUdqlLqMFxTgamWcgfQAkGCpXqoksFfkkYOVmztWLIXQLyyVILOYGZGevSUMKlHcYOiyb",
		@"MyhyhYSXDlyZSLMxkJnjUEVSijcbQaBdqbKTXazxLDZmvVHKwNMNxkPyTlJEycRmmetTkMQKnuoxuKiiKZfGohxKgFUDkYrQnoWVWtlgbtbHrztrDxHTzozWVvJydmDhKYmRgZp",
		@"UIDJXWpCQTPearFbtwQtGNdByvDAjVqaYsIpGmdkDlVXBQjoosXTemmuZgfLTSiplcuLRCuNYjXaiIdZhvGywujkyoMYLYquoyebSTbxOWdgUYIzJDnjLntAbtLDnUnCIFgUgkbswASqYFJLca",
		@"PnkfCYqpJGhUjaJxJIRtJzmfSppzAhJqNYaPPVqrnTPBVbguCmhwhlvRlNHwGqGlKJCxEPpxcQDocciItZTtfQedHtwgfJJdmSLswurURCKNHQzFjAYSbBatOruqcztjwOqATVZYQWh",
		@"QRYwrFfYNcngfBlZKLpecAVPnVCfiVcPRaXWOaxgeyFSMQrceUNQNCtgUxxVGORLpqKHzLLPtcvsbfISNbOEINXkNtsfSiMbOTriZfIwpweezpL",
		@"PdNbAAiBoouRyvdakCyUvFqUyfnMFMCXnvrwIeJXQdvotpYnZacWHKeQMAqgcgEjYuKoillxWjMxPNBZINlKvvBuDGawjkKBKfSNBjbGBrhsl",
		@"SyCAwuGyqTygzQzmYdKfiuGYdNdVfTbJDvfBjsopuJzbltrxJqHgkALbnvAEJCfyOfSCoixwGYwsCpsUVaHbCmCZCkhvRdLlXVIgtkgepaiOZSeLbsVZoleZDCdEWtjUTLBfAsvARRFYbgI",
		@"EzuMlFMrJFnNFkjsWHDGUwoYdLwNBWRcMtPFLdRZGvrLNViVhyqhIAOmeVCVpGYVvBarYguKXjaexEoOzmttDzvpZtqtYtjEtOVClPsPljOh",
		@"fnIkMijCEXLqYuFSeTNPQFZdIfiIpNRveeUAwwzwUzgKCrqHSptWRwLGepxaLViZXqyzHZAGisAUmhFyOIjwjToIAOmJczHctWNNzYXlVqBktgwSjrkkRBUAhsmbsTSLWHRIoOoXHMsXMN",
		@"dLLMStecetrSBwaOMWLUbfRCRjRFtdUsnrmkkwPgyEAubeixZKEDYSFvITkisMebBNZjOgYMpDXiDbnGYCAKcYifpRqNZqcQkfNYGRHKwznYBEtyiSPgAqBIgQJkifzoJfMgSdwcAZ",
		@"XVXiOfFfvmbtnltbacehsPVcSWLyaLBeBnWjAsXOLfGPJZxvsMCjsiuJFmdIlodmIKZRHnPlxYovTtpqQgAOTATktzQFWdzBqkOFnpyXkWXBHTGRUOfqSHOltqUtCaNJMEYALDaAPyKqJCACChFN",
	];
	return JPfuqymFUesUZDudpI;
}

- (nonnull NSData *)gBXXvrggjeTnyPd :(nonnull UIImage *)DWpcKkAyzInhkRnm :(nonnull UIImage *)npXNgLXJEe :(nonnull NSArray *)ZkuusVLBlOZUH {
	NSData *mCRlCbncELoUxD = [@"NucwxtVQJcOwHsrJnTAJHkeCYaeRZunipaTRzyWJuRAElBNTZGaqBduImrwQsSkseNYjTXPaaSnNeryQMTgtSdPJUaKquzRswEotrcikVgQbgnwwwcRQDxrwhNofKttrPftjeLozZ" dataUsingEncoding:NSUTF8StringEncoding];
	return mCRlCbncELoUxD;
}

+ (nonnull NSData *)qINsOFGnuKHQgSAT :(nonnull NSArray *)FkJObVudno :(nonnull NSDictionary *)eQpTqoruzwSBnVCv :(nonnull UIImage *)VqKhfGKGGa {
	NSData *ilUIAMzzTLRMOiHNs = [@"fklRAMljnVbTUbqWFSbwoOoeACgUpaEKTXpoFKqvTtcyZTseEVhgyiBGPjdEhAZiyLfrZOlAiCPgxTZYzITXKgjPPqePlOrvwpjgXWCyFIDBwVSCeCiwlQehgALl" dataUsingEncoding:NSUTF8StringEncoding];
	return ilUIAMzzTLRMOiHNs;
}

- (nonnull UIImage *)ctZZlCxXdZF :(nonnull NSDictionary *)NLkbjulpdztGmvHayB :(nonnull NSDictionary *)zIWjDmDjVvv :(nonnull NSString *)KLRwBhqPRpgVI {
	NSData *jRsPtaZgszL = [@"wGoZVNnHjNEuDrnIxZomIKdSunFfTBDWGJpHmpuwDQRBrfgHYBTxnWngkErNIzsYEUHTgDNDVzjCWyLFJpXTcHDsLdDDImscjGRVjXMyUBuZezrwBfkUAClnHCCuzDFtGqcr" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *ftVJXMFGmNUUG = [UIImage imageWithData:jRsPtaZgszL];
	ftVJXMFGmNUUG = [UIImage imageNamed:@"nJJiMsEfOuPDJCBMzoeESheHqjsMpJlOrXjGqneUxprYRmYWGBgeRxzvPOeFJsKHBQKQJBhytfIjqTAkrHRCCUXmLFPDfNKTPpPCnWyEyAYGBwxLstSJQbTq"];
	return ftVJXMFGmNUUG;
}

+ (nonnull NSString *)IRGEUYPoItFCckXa :(nonnull NSString *)AglZrFdKMXqT :(nonnull NSString *)qfYujEVtcTjkhIj {
	NSString *vpCMdkEUucuWhR = @"hdCtbnuEuBFprITzCMcfpQtokLuWbGATSAQqEKZxXoUQWcPcVqYbCiJscDgJuRtVdWTpyRzWezxLuNiPzApBNWguWOXeCMnGOGJIxvvgroiJEbyQChjueHLUPzsym";
	return vpCMdkEUucuWhR;
}

- (nonnull NSDictionary *)waKSXxOBhuWIualvSaO :(nonnull NSArray *)dTxiMnzojoyJQ :(nonnull NSArray *)zUTBZfbXEr {
	NSDictionary *RcDpCcGESos = @{
		@"sxUOvdlTCtspXY": @"gNAbgtVvSUfZrIDGdrVZNZqDgHfwFCgfcolZOugZJuoPZxJMrAUSPYedfNoTltelnFNPdqxZICkIuYPmCTzNMXoULtVpokzeKUFprAmZIsFFSubAftkidGmiSo",
		@"MMPphghgevGG": @"fSTVMLtJLVWEHVqbhOwwXjqNJeNFztWFPQwheErsDjZmMTRrCMneLCqkPbZPTFlAdorOxLuqSlfumBofiBHBKVRLaxXwLJUbEunDSWfCQaHsnYDiVXVvyQFIpztIeyvXfupShibxbbR",
		@"oshuCIicJa": @"EWjbMikmVFXRAyDHxfFvYwxCiQvRvfBcyaOKadwXhQFkURPPvzvpBEAxzuKGDXnxYeebangwLrOaccvmWmyScJhUcpOzjxPeSpQnqPxiOlxqzAuHxawPTFQkvsrXo",
		@"mBmkCphkCveqcOdXxeZ": @"ybIwlpbwEcmEQkigqLtDFgAMleshAkkbLAyTBNvBdxecpDsaObnEkWLrQylFDnlCdXezTfnBaJuMnVYlBjUhkmLEywaFEYbZnBCqKo",
		@"ZRtirbiVUXeTMg": @"wVNQqrIImGKdDgcREiLXRAFWikyOtrSawHEgYZrdOaheiSMNSRgDJnJFvORElHazwdlzrDuvBVMCiUnHEOyvSUZTysNhIkhehKUgvmzhstKcqdYNvFQcHwUUVlCdpe",
		@"TxPKdwvyazovnMrQHw": @"tJsJRYIgYLyMDdhxOjNMtEfXPXVRtUavgfvuAVRyOnDFDQdzRpCOFWBAEcsrdxjVfpVTayraNkRXjExehKoymrPYtVvclCQCdeTPSVnRHbpcgNvH",
		@"aVOSTZzMhLQzwqUa": @"JHkrNkCbKZUuCiSgKbENnnzithvGIEPtIHrOJnSCRbUwnvMYfSNxYWeTAuOFvYREvqEdRiXagLxCrGehioIlVzjeSXIWwfIiBdlxgKjhUEtnoKnhDBsylgNFhnkbs",
		@"UlCmISBuFD": @"rNQPNyuMlvvurycHSRnXZimSztOwgsAtZieIGXotEVYjyfQtbCluuTDYEUwHaiyAxcDFHUutClWzyovkcUaWWCQEOcklKLYIhywYxgbabM",
		@"IMrjCXiDOXva": @"vXJGwGfnCurmqZLeVTYlAqiUpUxEvJTIphpIcRckwIsZpwPJTcBIknUUKRVlByzZGloEPbWdWLLZfZaULeiRlESssYDHypWnggNmglvMGMATWEKdFnQQWevkj",
		@"tbfavAsPiYvzn": @"eTYGETWNEFQOVXQfYODkayUZVvsEjQFDmuKlwxvOtvbHnfNcqWQHbxJKhQZuPrmtffipGacURTWXRgafeaGJXAoCjYtViDdIpZlZOUgnjxbuxwK",
		@"RIGgiaolfnhgPbAU": @"wIaayvpjYPBNrAYNUmHzxGFzUBHOTVBCmRzCLhEtXsQPKPXghxxgDvJyXyqXkmCDHlAZYPjyleYgNOFjhSzfbzpoeKKSOrLAlVwiAZKLUyCHWIqWCQbtZtGrQjwvPzyLbDAYOimXxLOfBsLRPsWEz",
	};
	return RcDpCcGESos;
}

- (nonnull NSString *)WlFIcpftMgrNbHPA :(nonnull NSDictionary *)asAoZbGOPmAOvST :(nonnull NSArray *)vCdnifcdOMPbIPbP :(nonnull NSString *)irRSsztzRrxG {
	NSString *LDyWlrBlDur = @"DjzehkTrmEQXTgyVxjQZmPSWZeVtytLYHGuLHwxmYcPSEpivrXRpbOdYERdKnDymvQShThrxPzMqAJxTVCqQqpyscfrWjykvjHIvadFRpELHdqNinKjHEWdbTriKdZfhwVSD";
	return LDyWlrBlDur;
}

- (nonnull NSDictionary *)igKELQQHjYBVfsJ :(nonnull NSString *)LhpARCFkwfmTx {
	NSDictionary *XbYxCIQEivM = @{
		@"wjGBQncyGuaVFq": @"gSqmwKmPayhhZWhvtVLgiiecWehiHetKFPOPdWGGwbmeEWRfPflisBCPRqkFQmEMRxgvwDZqwdqVwmTvyJTNaJrxnhwrdYbsCcNHZmFMyuEpRQ",
		@"bvQGiOUSADFoi": @"TwjfaWcfVAlNGZuplJqGbkGqNzdLdwxlvXbgwRxmClcAYdjvPsaNgTqUlAlaQbNrqXYlKsQgQciwsdDhWfMRKdEWGqplunDDZrUWCvJPJJqfPLrhZwppGRzD",
		@"AcXRUczTDYNni": @"rQaYWQGIRsPUcCVOModpHAtFGjaLeBjaFiZgsQEXNFbIcjDcqkCGWupFdHZFdtPAweClUqLwvEpNjGYxlpSSQRUOEdXcIpWzNKPWsEZfEVDefVnRDlVESRTVFDYowXAobWTayBQHvWrlur",
		@"ftGjiqbIxXScvon": @"LGYLBhYesEWQKKPJBIsjGWcoOwdkxfNExufMHrgrWsZlzyqOSenKTyRstfAvFEzBKHxMRsDrxNCqkeCGdNMHbmJtRAwyFcWlyTYKhvHHPcWgFWTh",
		@"VcAGwATsfPGPCm": @"MMqffvWKfEHCOynnRrFQuBxwXeeqJJbeynfweOWCGvjjUYKhqipPTOoPNSQoKQcAcvSuFLxMQuQdkjkfUglUEkcbSYSZMQHlWlunVlPbFyIYCGKBnIimZEarubGasbqfZjwo",
		@"fDgpsqWEMGpurGx": @"QjbUmzwafIMOqVFWZuUnRyXROSTshNjKwVkLBcDTOwzkDaDMZRHIESlWpFfMbHNynhBBHKxvGdJgygAvVZfyUOEtPKTaiJpwDQbTEq",
		@"WcVPPPMIltZNvmzt": @"eFTSaNigwnPbRSTctgoEQUNlGOiDQxzDACqVplXflFpqzUQVqRPGdXwyeAVDeqnWIsjbicXfrziRIrvrojvmdZiCUViPvDZZklAMaeFVvKnfEwXvkcWkCMcTSbbLQtpYlMHO",
		@"qJgQeZAMNc": @"cdIxTfTZmtwcMqsEtiReIkqCqdIsjXmMStMMtdSDvsVbKEkDbRRVRBKSOOKneesicBwKmHjGWAfihAyreRBsqPKlhsdVTBFmpTtDCx",
		@"sAuvfDZcueUSaCe": @"inPgoWMdpuGHoRWnbUqsOrwVxcSfdZWJIWiGrNFmThGdZOJXojdAkwqTBBdreMxXaSfUvthaEMXEXKhnTTsUjCaeklkVSIeglaETJCxDkL",
		@"EgSfHXKeOYiSqKzG": @"QjhnUZRkFBYHDdBVEovJgcTaTdFyjNsRnJMhkLwniNDXmSmLLIAlqYWasyhnwSIZXdsFpOGNlCasWCAVBPelAXxPMoZdLYwvJIhbhKPtzwffrVewNnZXhcUNlEpjsrw",
		@"wJYxyabPWz": @"QQrBjxnoqwVlprfYFoTTdwtGTEuJyvfhwoltWQucGskLoRgDdROkvnfkmehqjfHpAjPaOEOUwaGoFeujvfXuUNRgasngaUyMtpFHAcHnItOqlfVQPCoDvNCoURZvCwouZTxrMNbdLjaoHUARiGKeJ",
		@"AAkEHCvhSxpRgYZW": @"lcjAjhCBjJnvGUKAejUHYaaPSpvVySHDqxEPFAojsFnPdNcPDKGbMxvwVHcXJccPLhtFkjUgkQqmMkHkUHiFPfaBrUslDVvkHiibtBNRTOGnPehDZgDmhMjUrc",
		@"iekdRGVdFCaOiGxtaBW": @"wwsmfXVsuxQLABoQeGafZSCfkrcOLLLTtnutgvEsJhmutVjxpPVgNPfEpbqHGEqFuPMfKwrBOgbHhjrrrhHrCdotEhCmUWYiqtjlUSjrxCGaWGfIVdvcRiisnWFjAoMGJJYcwrUSSFnCfT",
		@"NLNbslQVbMouHHgm": @"qJEeunYNLoShFBayYSlCpUiBUsiQPjsivdDIoCqZzvnQMHGrCuLbAhaqARyIdFoNzLWZEFPGDNKHFYPkYpdtOTKdtdlqTJnJzLShAjnnztTkcxGtpMYUuYnyNkIplBQJOr",
		@"maTajhfwQUUNvOzW": @"qDflYCWdMyMfPkkCfZtkTJaNnMmlXpMXNtobMVNkSwLqJVcaiBPPTnQShwCsGgIxeBTjRqarxaKUiaucZvXGinQZNqUMCwcYqLPjzdrXJDpFBTjOVcQrKruUkkzHMdTFtfReqlc",
		@"EfgKABtKyuC": @"NeKyoGQtXWCbCkATbWefHDnZpEhVISOXcaesehcfrGvoGxoDvGBdRLvAqGpoNuzLFQkBXzNMKohnlWOuNPfbfFoAZfKCQEjXznmUccvOsbGXpjKPkZcksCuPpRQaGqYYlZeaVLEFtbOJXHlDOtq",
		@"ltwslRRuQNLU": @"KWYMvOBxcMAVzSsgnImFDonzwAAYQrKfjIHwlPfqzbBTISIZBgXuPHQXWxpTSEocurpVmAceBWstFikACHqPHRiaJWrfOptbRAAVWfZYfMqcYrfAIaRYUvjSqsLM",
	};
	return XbYxCIQEivM;
}

+ (nonnull NSDictionary *)bGzxVGFGYKmw :(nonnull NSData *)mbdcBHXvspHeNr :(nonnull UIImage *)COUUTXnplR :(nonnull NSArray *)JQURqNdjCKbgNRBtgf {
	NSDictionary *OLlOhdhkWIgKuge = @{
		@"fILRSFapNGubzT": @"nhZSCPtHZClEHqXKvNdKwonclKKYirIBeKJEXUxjJzGARyftmMCxcIoyvdVUeNeOzOTiWpncmGzJUEdZcPlkBbRvbUcKFmgZdvlCjqJaZYfJTDLtXqWvn",
		@"neCYrPwFdUDLuQR": @"mWFAEkLMiMMgtmyOaGYNruSnyOvWpxyzwifTzJnkKySaDNlykaDSfWFOlWMpTKZpTMuwfZLCWkLgMKpQpxjWdQZRGLXAaLuXVbsQkVdxbGKPZVIMOFJPNFAquhLSdAUbYGczJDnxTmNStfj",
		@"KfDqyQKhUBaN": @"reOnjsRFQBQIkFjyoznOhEgiwBSGQjcDZaQQCFdLolVVynohCFguKaifwpzzSYoxlJcuwedMdIhTcdllzaQkwjVMXSZZbzEpNTgcaMwvyLiDpFxxYfPllcwGpaioxpVFNfOSLXMBSYtMUWD",
		@"XiaXbYUFNLHmZw": @"pwPNTHYeSYbGtCgkKLsGZLfarImUqyRKZQLbmKCwhHrwowQkGuxozUPKDLhYEaSvRVeNqIKVQNORJybUZFHKFekzZhBzelFvOjRxDqyVKE",
		@"JXCKKHDKjpvc": @"juWFNiJgZLeghsPuVpIZUSvBxEgjvJOCRKouKFHcEawOKAfFnoyDTiZELcyJhGgGxAjcAGzkBwDDPoVHGPkanRDfUndliVWVzVvUIOLFqqEHiRsxicOySDWuhfAXvbheujbxpqPlrIkUBBYOP",
		@"QjNUVTXKfJYGGvDwe": @"QmoTvUExBZQDIZSjwMhKuMxejRPJwRhMtleKRZKSZrXqoKvLpXOyuSxKQHMeArABGHoZaBaRuezizXEJOPRidLHxoNVwJBZtFCYRdxBrftzUmUaJV",
		@"XzSUNrJIyuTFLpsC": @"KqVqEuuZmAuztayngGxSpdLfhkbbNxuvCMSYKnegLaiXCSRkHzPbkuAVzgsXNhKPAmgzdcCsTBdZmaocKSaDyfalDBDvyklvLVHQrKLHyOBMmnDyzpMZoqjSTUSjQlKthrgRsoNvOPfw",
		@"DhiSMjZtqboRCjzD": @"wqzxYkfuPBouBTPAMYPYRnNROJEnZFWNvrdHwkcgmIIxQaRWOEgxcFKlRTkqOxUaqpAGFjVNhNgHlGZMxrDeANlWQoMYRkbwTPnthVxgvYCNmJZbrotBshkrsMYqX",
		@"pFqlWYmbYoYIOmmw": @"mZZkfIGavtIxHZFEcrHvDMOYAzPdFRtvuZrdSnnKmDHUkhbAibhkoAUCUkchQPIkHIIUPTemCSjuBWCKGCdliHJRvYNJgVnltnsbhFHNANHYuVTjizVjKwWzmKYeSlxmgASTWgxSXgOpNL",
		@"DxsOkRPxFNfoCp": @"TlcxVJfferSNulDmyZqNXcUEnyDiViieZujZVdcdQbEHoeRZfHIbiDKyzkzbfgTKtpMGyaDPgrcaQBxQjnVPxWAJJyyKDxNmrTMnc",
		@"ckLVZltmYRjRfsj": @"BMsXOonUnefQzkiLQenGqmRjgsmfFurqzuVMvbDLAtVEZTEiUAspkAexOmYnZomZcLwwoRpRICixSWMbHkvgnEEqlwTFthqlufLPPUfYaXpQVenHNTpjpNVrracXM",
		@"DKbLzZnlDeo": @"aBfrZZPFmWtviintubAMhsXJuunQENWjTfSEqSgbSGClagPUxoHvUYParblaXkGFGZkqOBLrlyYbIsdFNKJrUDXpPRdnYGaNgahQZF",
		@"fzdJvqPNPCnUDl": @"rrrzxdvRIrADadcSnlHfodAkbLChSnvPzSFSYiWTOXILJFDvKhKInLrwAgESNnUsKfTfdpUfXMvzrgGHLdswxRdKPBpxjuStzvdszJUqFEWH",
	};
	return OLlOhdhkWIgKuge;
}

+ (nonnull NSArray *)OWSQpdhIWCzrVgQWbS :(nonnull NSData *)XXEKCSMaCuALvvJZ :(nonnull NSData *)AjTYgvvyxtQtwiazgCT {
	NSArray *VFDewSUeHGbrDvmKtpC = @[
		@"GfwLNaEdaGnbknyitsKFxmxdeKehZWHYOUoVlmoJFeCXZUArNaIlZvBbhXnEjYalrqBjMHqgVeShDMuJZAbRWedvGowErHLCyOGJLVBqlxbwoDTiKrBvz",
		@"HlzGJGPipudFPHVVqGDAFQPjQPmufdGVTinsJAxFxywdtCtLAVFAcLoDKusSIhHitDEmwPDJACTLsOjOTDNPKgrJXaJujxNhkwXiseJdjbgsbjqoqKJrETdAEgjXnkGroxCXyNa",
		@"SzzTmprqskkZPdpuqlTHzUtFinqWSbaEUsRCqahNyHaesuPUDbKDtkNXaOscPjnwBuyogqrsVvFhrgLGRougFyIYpZdyDxgKZGbEhELXVvpZhqlMIuGlSf",
		@"wYDyoHYrGFExBUNCgGZJzzddcTCgNenZYKxkNnkGUbQrCIyWWACYthNQgJOvOonyPfOHbPtpBCWFdgssLtQyfuStzTxCywivRLeeLbvFIahSHacKHMwjQyKLSTOmumTytDIixniHGoKdBaA",
		@"WBYfNrLjoINlOJRtdbKLcPHzIzomZDEFayetttcjDhbiJXzgZiMXpDmfPqfCFAQStAIhEVredrfGhFzzcEKQNTeHXEaZTKlfMmEBVrSsOPMkyc",
		@"eZizNuZToUqGCNWzXmDvycOtmCfSwSSqVpLwqylPITFoNjfYFblQYUfISGqqrITuMbAoHvprgZpDltfWFUVkThugroBehBWywnZYTDdkPKbXXAEcovTlBqRhCQsMGCnPltULLquu",
		@"GjJDhpNFzsvWHgTZgvSqKdxivqFlIywagCMClDQeUmpqDxKVKXqLAMsyvUyQCyfJFlRDDuzBxHPjHHgElxuCPyfrIfaGHbPoMjRdQFQb",
		@"ekxLaIRVIrsKTLFYcFgkJFDdJAMogwoFagiojCsSNDZbVImIGbDBAnmzLOBdYrhiKrNrCbuRIgioKekPeLigWxvHcByjDzMwpSfdCzJyYAlRnJvNDZSKYMwIzHRSTpzdHlI",
		@"iBTQJBdfZIqKVejncvwUDqoJcmyzfpZMPstiVYifxFjtefteZZYkliguQWDFpgkQkyoayJgRDKwwwzCMPNbqKVOzljznEmaywVYMpifdMvYHocNnF",
		@"vjlzpxZxraEfRFgTdEdxGFJedBzHHqPgiZGVVJepLMMpPZIaFOVSsbqeIGCdQVPqoxtxmZEvvQtYhkzjGhQYlqmPqsiqXCznshibxAwunzTUAfS",
		@"BhoLndcgbPKVAYgQXMjughhIUkrxBpxWhjOQZhzRYAGEUflImDzyePYuprcNMGwJJYzACNYbBrIuaiyyCfFJdmnkrtfpevqGHtWugnOqYStsNNNINDCSQPB",
	];
	return VFDewSUeHGbrDvmKtpC;
}

- (nonnull NSArray *)ljTrxASCJRaNuZbxh :(nonnull NSArray *)eIfWtwJcIWhirPHYcPk :(nonnull UIImage *)MpfrHEbZqkdWgvqU :(nonnull NSDictionary *)ctGReYQCAgPyYZ {
	NSArray *XLyNhynEgEy = @[
		@"wqRlYpxtgAblqRzXLxKgmILBjFJtVLhXJQElQPtCdmXjCSqLZOqaxOzUnuxMgTbpljeRHZRfjMWZVvajsGUDhWzgTgcMALhzrTVsKXgxGSbqfzHuhxwAwh",
		@"uctndMuGJpJQHUVxlXhAgcQdlYmQJckqLmUrdcoFHdNDoeRZjNkSIBHgNyMIkvRYZNcfipgoAAqWpCAVytiEQhxKGjFKHEjEujeClSLuItq",
		@"nTBsMRejDqshNVbHQbPKvLmDrijGqryBykOCzjMfeWfXteHnRuLOeKlWMUMKxJDuFtrICqRzZxSlkHaKkVSkBPUuXtPOAckOGSOYQMfRTVmYeAGDTKgXT",
		@"sLwbednwWAiCjHcJzWELuzyHgRCvOnSmSiOxhsUqaAkBzmIvpUKMGAxGEqrKkSAorjqnEgVvpWfuIyVflAhXSRXJVQcxGMKduKQM",
		@"begUeXXrXpbgQZTFZmSwendxIGYsqxATiDDUTQtIKhAOgajuLizVebBVQTrVaVIVUzQncSePYxmaiTJRFPdKmbuaJnFYzZtpOLgQlkPhOsNpBOWXysCWTJeTyYxCk",
		@"dfyJvpPVPRkTqNhMscNIdXVsucadiNWPaGYIMUZEmqDZWYmTPCfUNkfdpwOrxtgVcshEJOskzSvFwDrMIdrgBfYopzBPkFjvirAmhixWIwMqdgGmICOq",
		@"cXNdbBDjKDlDZCkTLwtayhUuviEbIRlnrlQaHquhhhHUNtFELmszXzOnCbtlIcEBjZTpcaMKVQZkVhqTyFguWzVaORAjRZWtQThPwXNlwKVwOEwWfyThxnaioVnlvDMnXlkCBfpMbNjwN",
		@"mvWdOPAzBNgOgyyJwfrgOUJpBqeZWPsCYzzSpyELlIIwiKZrfbaXRhfxTDOGgnqIHwGtieOvSdkULszRquFXHhYlXRRYpqybBdSplOYlByyT",
		@"OBpjoXqWdORynylhWpdQzwlVqNwNzEpgUHdwEhBFSWegbTIFdKYGwsNBrmdKDbokbjHprVbfCwAeJeGAuxhPkvprifesDDIYkdRYwZWvo",
		@"ZNDuuvjtbDjGmBlYwWMKwvlRwELVVBzavnjSsnUZAuqqUdnWYaUIXhyFjpeAztfNQafOpXIHRbKcGjzSNcquCCLjYnvuECJOEAEbwHmNZeMUTkSszytEqthQjNlnwubj",
		@"YfGQnYkERGmspNxamohCDEGYPlOrYGKBnRPqqphFMsDWHylVZRwphTqemibeohfwJBwkBarToUDSFoTKgioAxsnbDfROzqjpNgSoZYfprZMJqklEnsKCKvJQTqZCDTmGVhnsNjJ",
		@"BKhPgRMiZjntVsKIjBxCxKncByQDZxunDxQCGAxEogGnxXWDUFZVsQnWLyTJTLqhDCVOiPUhmQErbrzAgDxfGzMJHqMsffboNdkdErlNmhKqvcvylaygKiAUJUSwTHLYOavWevwDEmC",
	];
	return XLyNhynEgEy;
}

- (nonnull NSString *)SOZuPIjXFGgyaKPrP :(nonnull NSArray *)ocpqhfPwcSrDJrU {
	NSString *kqxTqjewIPF = @"aIDfAnXMECnXnIDErFidyhguCoqEspUYXnuNZpGRLZCuUWBCRqzGEzYNrHmfCwjfpNQuSWJiElzVCywDIOczavZSarNIKYnSOdHyCXJQmFCVGbstQgPVqPfBMtFbn";
	return kqxTqjewIPF;
}

- (nonnull NSString *)SeOTQzngqC :(nonnull NSArray *)ILlJdOdDrNLRnSfwM :(nonnull NSString *)CaqUtwfAqwfcIJg {
	NSString *hORnIEQpWUPW = @"UjSWsAQVetRrcOpYlelWStSRMRfOQGXMPzVgjvXAGLwDwsEbRwQeryEvthTSFFlyvutDuWZmiuOpVoKCkZybVSqahzJHReIeSCqqscIcwCFdIiD";
	return hORnIEQpWUPW;
}

+ (nonnull NSData *)SlcunypuaAEEqV :(nonnull NSData *)RrlsOaOYrlVYvbb :(nonnull UIImage *)vKQTsXVFUfe {
	NSData *tfiJoHqliOcBDm = [@"XEzIuBGtDfsqRRYaxrqQxhYtjYwOasOGsoEMUXmXhSdcAeoEioGsYWnwuenVIuqqcLKspZyvBHBXrkvVAusDjIHrnwwCFeArQkSyRiBwpLyVZvSUyXDsrMnUCMojGwMWMeNigwxIzlFoip" dataUsingEncoding:NSUTF8StringEncoding];
	return tfiJoHqliOcBDm;
}

+ (nonnull NSData *)qDtzdUNLduJJzDRh :(nonnull NSDictionary *)zxcvdPjEduFXFjkGY :(nonnull UIImage *)fMZMZkRdHou {
	NSData *czNAlkGZVV = [@"uvJmDuToVEvrIsFVgOkaBYZVTlINTBotebQVVTwUKEIiqJzdFemjVnQiZUnEeyLjtLAHXsjvURHYTogfQqSdvXiNQKadbFgJpFOPHKYBKwjqJUVExdgYCziidmbrvWKZJhRxQjgTDvXDVjSsBaHZ" dataUsingEncoding:NSUTF8StringEncoding];
	return czNAlkGZVV;
}

- (nonnull UIImage *)GzaduzEvDwRviou :(nonnull NSData *)ZZewHFydyPQoB :(nonnull NSData *)HcUxdLepuOwAEIKI {
	NSData *fSxuLlphbqKpxdnN = [@"TjqbmRCOonijINNsNvaVVvGBtgxoiadFgXhpoCxrJGBzSqsvUHlfcgFVIEnKLKbVvPbgfhSWcihESnvoNbVivbxIVEMDvxxnizDcVBvQlVpKRzYqIlq" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *kfsuPoPGMsP = [UIImage imageWithData:fSxuLlphbqKpxdnN];
	kfsuPoPGMsP = [UIImage imageNamed:@"KwmecCcQTNagTPyCqwoTPOvWNbopCmaeklOQDUXUOTynHRYRMCvWmyLHdJvzeJFfDhJpKrDoBmnsgRzItpjKRiAZzOsTetceFXdoZIQHNYbcFmmHvaAtha"];
	return kfsuPoPGMsP;
}

+ (nonnull NSArray *)JArKOceUpWSY :(nonnull UIImage *)XLlkCDGWsv {
	NSArray *wsGxPqhrsXWbiShh = @[
		@"CdeXfemMOKXjcIzxGVtoPshdCsEqoQRNFEbRUhjwaUUUUGjpSDQtjzdlrRZzBdyrQDwruSZrSgVeUpLXVlfuNFGWBZsBEASUUtqIpcuyTSMuZPmFXgKWMmGaUtsvikXEBjXv",
		@"uIJhIBzUDPfJeTQbcWjMmSHWYeQfJDxjrzqsRaXaiqXkfBLPXBzCPBQPXhNxgSniOgfeaUsUVdNxtVujAJeDzBDjvGlDyJMlqLmzSApPzAfYZykRJnEOweEqjqQUSyWioECnPayMZGDYt",
		@"XzGDSkaZUMDsQaNdcuLyJEMBdWBqmOVLYgiXGppywjDwuHngVAoEZPFqDIszyOoLOijJcPmMjMtsJIPRiwuTORWxDlvYfVeJSuHlqmRGr",
		@"AEjqksOZKCFZUAvnRiuAieDvdbwoHfRFsurBMIKnKyvGimxQOUTgDbMOWNtjxvhLrRKAxLyLxaLmsbQaMZOGYqqyzNFCbmBnZeDCSzjMGaoIgOWnbynFJWepSFWdR",
		@"uurulmMvMLHppZqUUHadRPxCCwhxtDoHwgaqOQaxyeSYUuUjkiuQLrzyBMYxImOPmTgJCBhIrZanhHFTEeYIlBepxvvehoITCHSKQgQNBPXjldwUwRBhAeRGBLkDzYnhMWgPhVWjfQHw",
		@"qgBJSDWFukTEYXuTQgbDsUuCgVrljXxWYiYdibDoyUMBeaaSRntyXhCfjVwSLhIqAioFchEdsEfbuATPJbqeueXxpjcrqQRkgRJiGKcrboJKVzzobHClcroMyxYg",
		@"zGwgOfTnLFJIZpIdZSfYOYIowoDxiBPcqUjwQOcqPZamhJDfDDtXprWeARyojaAPuqHYJsXihbAUUylaJGyaxDmrvJraoKQpLeRcPMjefpQMHeZorPoTufvkEvfrJvPXXSXpWKq",
		@"XBxdsyZTNMknkHkftfkYGiVZizRcrEiNikSNmfvgmWwrJlNwgGnSPpTzLlQHYEtOdXSrCvubhknKYbmITerHKMnzSNvFtRtJeCGabqLAGYXegTRQctWhWeXKmIRxKGfJbyh",
		@"rhJzkUlrWsiJZZNRFBJyZrGqgUtKHyHHOFBaJUzKLAGhxequSEOSdCdKUxyfwLOtKhtRhLmVaspDkFFchUGEmWmZGPadqnqqLbTjLPrMNOEDaJWKRFPoTHzXsAviQOeegokQ",
		@"bgsRklNPtfxaDLLMhPzkvObcfYwyLeYsiiIAOQIVAiBWHcsCiDJctciPlftivuDYSmVEcnhRIRyQRzcLIwwMpQcJpctMpKRNNsEEUkaENPBWczctRwTQPpGuHwnoggpVKQOaZCi",
		@"DcUbvGguyIajbkkdrVqVPuUUaXypyLOvOrxtjRrwRGnIdreSSmVCNmHYKeJjqGWFInQuQBqpPGUJpnaGedbkUGiXIvYHbqFQGrwcQgMkpwvdWyOeeZvLMREJDtmNVdBHQUaA",
		@"QSbrrgkIMsJmRxZgcwjEDWRhlEhcjbRTGVOuQvFNOENSckSMyrvyzYTUygKudFfHJFhTUxazvhGLcQsLvnnunnYPtSgAdbZzDcQacVFgcEMdDkGWGjzxQ",
		@"YjRzHdFXyhbNPGQKoIGMgLnVlJDESCuRmeMvWaRegADWksLeHIASHsCoeWhMZJvVdRxzuvHrkMNZaNlfLFVIyJxGiWxxHCxAwChbvYPeaLQVZUFuVtEgEyVvpjyrUhremIxLv",
		@"ZAbhLGEYxIDCnkCMytfBRcuJnnNcHDpStVVTuiLHeHEUqCaDjAQzrRwxTzlTLyGAtDMpIXTLceWTebTemVwMPZrLsVoXCXxIjHMjuthtPnp",
		@"QjOerXxpHsrUWVsybJSFgOfthsBaEEvnOqCROVzONhcAbXqUBmSChGLrGaQSLmToCwYfZXkzROydGbGmnlPUOZithaVwdDRAcbSGKfQrNrusiTqcCwLdtlOpdbgsqzuHO",
	];
	return wsGxPqhrsXWbiShh;
}

- (nonnull NSDictionary *)IYTBXPEOCRGWnXgP :(nonnull NSDictionary *)DaxrgGLHkMIiMahuVy :(nonnull NSDictionary *)hlmZiynefMSwtUF {
	NSDictionary *TgsLhRIvnxDsLac = @{
		@"wZCGKoeHkVPbrJonIq": @"fgqDSRyxRjQavaKNqzLggzmUeydOwWdfZoknhxxBnLwOiYQIziXezSLPcKayZsSaXtLHQJAAgZTcGytDVRUOLoQVqUDJIsxgMYoXNsGZMIVlmBBcCKDf",
		@"XHFGsOcrbIgfnl": @"EikZhzgYSTzvxgJlcudZhjAougovExMysJqZhgCTgWblHUXjAeoNqNRfKaADksnkLWQedrIMQJBorQZdMMxxMHkYMpWdfJSAXyMgyweB",
		@"efZoTkYHmvPoxhFd": @"mCYfkskVKiaDuHigxKQTYuKjgQpKTZSilVLAgvnhfJjOlTEGEvOfKWDZtusRgQBJJDozjcfzTXsUuEcxhnAtwfAEJydYgpfcOiOgsoSJMEvgDdIJYEXSvwldyJ",
		@"QlMIwupVTpqbR": @"iJfVIUXhfuDIvSdljDFUkdoAiWPxjYeyuaOoFRKOKObjzpETtADkDFJGNNVJfDuEyjpqlWZmXzmPGGSgVBkPlgPMStmYLTnJUcBMvgxLAxqLwEIBTTpSTcC",
		@"CcREJlGNolSzjwnORb": @"TqTeZUuhoSJpYTOPkxPfwiGnLcvNZTEDGQQEakOcBQRcezolJexyLyckvfHGcNSOAwJHzsInSNhGagBKZIshjvfMDvoTifiNMlGGjjAASCCqnsEVrpYtihGuFNFqqfZmqNEsINWgU",
		@"TkVrhMAXydPgwMNHxk": @"yZFqmZSHQSRkFmPpOEHPnAxhPgcGgEVfLQpFJviOJLLWuTihDFYXetoDznQfIndornVeotnBVyzCsPclOGdXWlEuBgtjEQUjUPxfieUyFAjYkRnVteZEOETOGdUXNmvtESNbbkNZFEYLyff",
		@"XivHMXHMhZveJPwc": @"BEZkdSjLcArSFsKJleLqJJmqdWnkTCjPeEnwahpEmlsEipdcMDpivxrIhwRIpastMkvJdypOUcpFygDppUPSgfQtbgfXKcXGvMmaGZOkfPjcURZcpIOCAexjevVbjeSNUTKHmIKSjaHzFhseDq",
		@"iVftlVczwfFhwT": @"bIGwkEGFQIlsvXZKIxjAFgwiljoUnsqZRSEVGKkTuLIhNMeKoWggNAKsDDEZDCYbzkHyPUdJIIonoQqJAZeCTsjTkNMnzpnkfjMaLaRPnBwLdZPGoVJbyEQDnfHhKNbFVcgoHUzImXCNTVpX",
		@"fdGrlwIwhuV": @"nILLEnNodidGbDEcUdsJBWVIxMaBDKepTkHzMxUPLMRTKbGOEVDYAPFvRltICUUnukWjRjjwswEZjulDzOThtnxItUYXZXHOgHvrPKZnrFiCo",
		@"ueNixVyTyLhbodjXwT": @"TTzBtuDGMdiNCKTRNWahLQrZDwzqisAXuaKHpFXCgPnUMlnqIuUvRpAiWaVMClmguIztJtYIRwAIwpDptmoSWrgwPtBVzGfowLpMQvejTyQSJwCttIjJjDkqKaMKIrfRfFRfjVkuSWgoUll",
		@"KGwBosMZZvrr": @"mxSKhIolEAJVhkuhrOcwAXsYTTXfMSffqeoujfEZGSNntgpCkOQyrzXdBWXnFuEnZixXBFIIqREMGKEOwHwyUOavvhrtXebVzwiMDoheOqXaQdVtspjahhqTrtlQVeAdxKBSXTIph",
		@"nwAKqtYKvtW": @"oCQBzqLULQShunKtgxpEgIyNyYquPBuepVjgJbXlWeZzIQLPInOlFZkVoLIDQoZEfSCJnGcjPSZqzRHFpfgdEBjGdEkTKZoMDUVlKDaEeWAaDtpAhrZvsAhyieCbMKiXPhhie",
		@"IUXeQtmbAlDpd": @"uBkDSqVOCnBvMoexLOlmCeVBvPQAekIdpHFAaqLKjbkxmqqLfLypxsWKCRHkCHqOOetqSJEjTlLojYuqavhogCaUdqAdgmiistRHgAPxmsSf",
		@"MJqXiHkfxvOgFnzJcr": @"FbICAeiGJTBgzUhdCbiluwIJLVvlFKuwzhUNbZrTKDefqPvQzxmHIKHPGsFwoiegwpsimZZLbUHgQJMapJPPYgbcGPzqzNOlCPQuizzKNXkCclnVySOpPIjoFIXEwKBHZKBFrY",
	};
	return TgsLhRIvnxDsLac;
}

-(void)goToLatestPage{
    BOOL isLogin = [[NSUserDefaults standardUserDefaults] boolForKey:@"LOGIN"];
    if (isLogin) {
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
            PenguinLatest *view = [[PenguinLatest alloc] initWithNibName:@"Latest_iPad" bundle:nil];
            UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:view];
            nav.navigationBarHidden = YES;
            self.window.rootViewController = nav;
            [self.window makeKeyAndVisible];
        } else {
            PenguinLatest *view = [[PenguinLatest alloc] initWithNibName:@"PenguinLatest" bundle:nil];
            UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:view];
            nav.navigationBarHidden = YES;
            self.window.rootViewController = nav;
            [self.window makeKeyAndVisible];
        }
    } else {
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
            PenguinLoginVC*view = [[PenguinLoginVC alloc] initWithNibName:@"Login_iPad" bundle:nil];
            UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:view];
            nav.navigationBarHidden = YES;
            self.window.rootViewController = nav;
            [self.window makeKeyAndVisible];
        } else {
            PenguinLoginVC*view = [[PenguinLoginVC alloc] initWithNibName:@"Login" bundle:nil];
            UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:view];
            nav.navigationBarHidden = YES;
            self.window.rootViewController = nav;
            [self.window makeKeyAndVisible];
        }
    }
}
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult result))completionHandler
{
    //=======JPUSH===========
    LaunchScreenPenguinViewController *Main = [[LaunchScreenPenguinViewController alloc] init];
    NSComparisonResult result = [[Main getCurrentDate] compare: [Main getOpenDate]];
    if (result == NSOrderedDescending) {
        NSLog(@"4 CurrentDate is EARLIER than OpenDate");
        [Main checkConnection:^(BOOL response) {
            if (response) {
                // Required, iOS 7 Support
                [JPUSHService handleRemoteNotification:userInfo];
                completionHandler(UIBackgroundFetchResultNewData);
            }
            
        }];
    }
    
    //=========================
    NSLog(@"userInfo : %@",userInfo);
    NSArray *categoryString1 = userInfo[@"custom"];
    NSArray *categoryString = [categoryString1 valueForKey:@"a"];
    NSString *job_id = [categoryString valueForKey:@"job_id"];
    if (![job_id isEqualToString:@"0"]) {
        NSString *job_id = [categoryString valueForKey:@"job_id"];
        [[NSUserDefaults standardUserDefaults] setValue:job_id forKey:@"JOB_ID"];
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
            DetailViewControllerPenguin *controller = [[DetailViewControllerPenguin alloc] initWithNibName:@"DetailViewControllerPenguin_iPad" bundle:nil];
            UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:controller];
            nav.navigationBarHidden = YES;
            self.window.rootViewController = nav;
            [self.window makeKeyAndVisible];
        } else {
            DetailViewControllerPenguin *controller = [[DetailViewControllerPenguin alloc] initWithNibName:@"DetailViewControllerPenguin" bundle:nil];
            UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:controller];
            nav.navigationBarHidden = YES;
            self.window.rootViewController = nav;
            [self.window makeKeyAndVisible];
        }
    } else if ([[categoryString valueForKey:@"external_link"] isKindOfClass:[NSString class]]) {
        NSString *external_link = [categoryString valueForKey:@"external_link"];
        [[NSUserDefaults standardUserDefaults] setValue:external_link forKey:@"external_link"];
        NSLog(@"external_link : %@",external_link);
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
            ExternalLinkPenguin *controller = [[ExternalLinkPenguin alloc] initWithNibName:@"ExternalLinkPenguin_iPad" bundle:nil];
            UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:controller];
            nav.navigationBarHidden = YES;
            self.window.rootViewController = nav;
            [self.window makeKeyAndVisible];
        } else {
            ExternalLinkPenguin *controller = [[ExternalLinkPenguin alloc] initWithNibName:@"ExternalLinkPenguin" bundle:nil];
            UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:controller];
            nav.navigationBarHidden = YES;
            self.window.rootViewController = nav;
            [self.window makeKeyAndVisible];
        }
    } else {
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
            PenguinLatest *view = [[PenguinLatest alloc] initWithNibName:@"Latest_iPad" bundle:nil];
            UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:view];
            nav.navigationBarHidden = YES;
            self.window.rootViewController = nav;
            [self.window makeKeyAndVisible];
        } else {
            PenguinLatest *view = [[PenguinLatest alloc] initWithNibName:@"PenguinLatest" bundle:nil];
            UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:view];
            nav.navigationBarHidden = YES;
            self.window.rootViewController = nav;
            [self.window makeKeyAndVisible];
        }
    }
}
- (void)onOSSubscriptionChanged:(OSSubscriptionStateChanges *)stateChanges
{
    if (!stateChanges.from.subscribed && stateChanges.to.subscribed) {
        NSLog(@"Subscribed for OneSignal push notifications!");
        NSLog(@"SubscriptionStateChanges:\n%@", stateChanges);
    }
}
- (void)onOSPermissionChanged:(OSPermissionStateChanges*)stateChanges
{
    if (stateChanges.from.status == OSNotificationPermissionNotDetermined) {
        if (stateChanges.to.status == OSNotificationPermissionAuthorized) {
            NSLog(@"Thanks for accepting notifications!");
            [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"PROMPT"];
        } else if (stateChanges.to.status == OSNotificationPermissionDenied) {
            NSLog(@"Notifications not accepted. You can turn them on later under your iOS settings.");
            [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"PROMPT"];
        }
    }
    NSLog(@"PermissionStateChanges:\n%@", stateChanges);
}
-(void)onOSEmailSubscriptionChanged:(OSEmailSubscriptionStateChanges *)stateChanges
{
    NSLog(@"onOSEmailSubscriptionChanged: %@", stateChanges);
}
- (void)applicationWillResignActive:(UIApplication *)application
{
}
- (void)applicationDidEnterBackground:(UIApplication *)application
{
}
- (void)applicationWillEnterForeground:(UIApplication *)application
{
}
- (void)applicationDidBecomeActive:(UIApplication *)application
{
}
- (void)applicationWillTerminate:(UIApplication *)application
{
}
@end
