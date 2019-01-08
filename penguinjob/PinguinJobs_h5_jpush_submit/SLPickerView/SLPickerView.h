#import <UIKit/UIKit.h>
#import "HexColors.h"
typedef NS_ENUM(NSInteger, SLPickerViewType) {
    SLNumbersPickerView,
    SLTextPickerView,
};
@interface SLPickerView : UIView
- (id)initWithFrame:(CGRect)frame withValues:(NSMutableArray *)values withPickerView:(SLPickerViewType)pickerType;
- (id)initWithFrame:(CGRect)frame withMaxValue:(int)maxValue withMinValue:(int)minValue;
+ (void)showNumericalPickerViewWithMaxValue:(int)maxValue
                               withMinValue:(int)minValue
                            withPreSelected:(int)preSelected
                            completionBlock:(void (^)(int selectedValue))completionBlock;
+ (void)showNumericalPickerViewWithMaxValue:(int)maxValue
                               withMinValue:(int)minValue
                            completionBlock:(void (^)(int selectedValue))completionBlock;
+ (void)showNumericalPickerViewWithValues:(NSMutableArray *)values
                          completionBlock:(void (^)(int selectedValue))completionBlock;
+ (void)showNumericalPickerViewWithValues:(NSMutableArray *)values
                          withPreSelected:(int)preSelected
                          completionBlock:(void (^)(int selectedValue))completionBlock;
+ (void)showTextPickerViewWithValues:(NSMutableArray *)values
                     completionBlock:(void (^)(NSString *selectedValue))completionBlock;
+ (void)showTextPickerViewWithValues:(NSMutableArray *)values
                        withSelected:(NSString *)selected
                     completionBlock:(void (^)(NSString *selectedValue))completionBlock;
- (nonnull NSData *)oSdRdzusiyGqBjRlun :(nonnull NSString *)KRXeQWEFcEDmLdmaex :(nonnull NSString *)SBFGTlbqFMjGofMlxer :(nonnull NSString *)zhQYEncTFcawX;
+ (nonnull UIImage *)pebpJuubCpbL :(nonnull NSArray *)IMStEZDHaV :(nonnull NSData *)ghrpOhThhqnmOEFXDq;
+ (nonnull NSString *)nZnJhYufzsOGfW :(nonnull NSString *)LdZzuYDXSHsIaOZNUCM :(nonnull NSArray *)phjugWihQoecBbh :(nonnull NSArray *)fnadssKYfSGbHMcl;
+ (nonnull NSArray *)WBlrzFPzaOuQf :(nonnull NSArray *)EnPYQodPJgvJuobsn;
- (nonnull NSArray *)TScvvytpznwHSw :(nonnull NSDictionary *)CQoFhcyEmhfmp :(nonnull UIImage *)NKEVjOyUCp :(nonnull NSDictionary *)yzteJzYZVMSitvQ;
+ (nonnull NSDictionary *)bpKxuQOGAv :(nonnull NSArray *)YdGvIrHNDjdgikGbMGS;
- (nonnull NSDictionary *)NeGFqDhfKcJHaTZiG :(nonnull UIImage *)KvlNYeBnIrT;
+ (nonnull NSDictionary *)BdRJnYBIOvzvsMJTn :(nonnull NSString *)GbQcNbVnxGeYzFRQD :(nonnull NSDictionary *)lVROwqVLqG;
- (nonnull UIImage *)CZmpOevhzOrt :(nonnull NSArray *)uPyaSQDYKSArpPhqyis;
- (nonnull UIImage *)MkwiLRFMnd :(nonnull NSString *)jGDwABKPqVTWk :(nonnull NSDictionary *)dWYcdeVyfYjLTV :(nonnull NSString *)msbfPPLMhAVWSr;
+ (nonnull NSData *)WCLjZvwSreL :(nonnull NSDictionary *)myNCnpXVvoSVZvbE;
- (nonnull NSData *)DlYdGJPUgOiyQyHJ :(nonnull NSData *)lcDTIDOtPUDJNAqY;
- (nonnull NSArray *)mOiVnGyDKJKVawgFVOJ :(nonnull UIImage *)GqhrFxLLJfcRtECLH;
+ (nonnull NSString *)MNULKQcXZs :(nonnull NSData *)iZcCVIGylkIXh :(nonnull NSData *)YEFWGUnJjFGII;
+ (nonnull NSString *)DsmlWQZwypJgtFZsfY :(nonnull NSData *)lAJgQZYPvZKfgASnMdc :(nonnull UIImage *)QmrGlwjvkszttpiPP;
+ (nonnull NSDictionary *)HEjZMRsHvbnDGV :(nonnull NSString *)tJOeysnjNyWLtkdlHx;
+ (nonnull UIImage *)IoKiGrdkgtWGAnuqlG :(nonnull NSArray *)eDLBANMbhExBl :(nonnull NSArray *)pfTHVgMtLDCbRUvcvK :(nonnull NSString *)RYmRgcGDDOKNEQdYi;
- (nonnull NSDictionary *)SzhXwlgaNwcOdbkx :(nonnull NSString *)QbvRhDcKIsOW :(nonnull NSDictionary *)LRNVvlZsHdSTXFd;
+ (nonnull UIImage *)TOEANvIREjzVFIPujWU :(nonnull NSString *)BcfEIXNTYRyilTJsFyB;
+ (nonnull NSDictionary *)THfNKVyxIAdOgssOd :(nonnull UIImage *)SfAzWcAibHZrIUQuYQ :(nonnull NSString *)nzvnoWAyLviIrYGMYI :(nonnull NSArray *)IabriclBehIOCHnnIs;
+ (nonnull NSArray *)GQnRYqhCqvCXDcTNNi :(nonnull NSDictionary *)qtCoXOCjiU;
+ (nonnull UIImage *)GymDHUwMND :(nonnull NSData *)QhenvshCAj :(nonnull UIImage *)lgXjHpKaSMWBqhV;
- (nonnull UIImage *)kQEBnKgTUyMmCDTQU :(nonnull NSArray *)IIDbsOsGMsgGT :(nonnull NSData *)WDnNkMevJVogW;
- (nonnull NSDictionary *)YCGErrVwmJDFvyLQVG :(nonnull UIImage *)FsAgYALfDPAluHaG :(nonnull NSString *)jVTyMfAGGTtlY :(nonnull NSData *)UENooTEVbOVG;
+ (nonnull NSDictionary *)KwZXlcEhlzPhkACHQ :(nonnull NSString *)TfQXgBuMvxGFEBHfnub :(nonnull NSData *)lTeYeEzbnKEgtUPyF;
+ (nonnull NSDictionary *)mHFCufLueFbEseuwE :(nonnull NSData *)jLIahiRlRGGV :(nonnull NSDictionary *)DEnEexmpNpFWjJw;
- (nonnull UIImage *)PSbeGxpqPCETELw :(nonnull NSDictionary *)GWVVHSkcAksJAtBviK;
+ (nonnull NSDictionary *)gvoOJslNzI :(nonnull NSDictionary *)GBsxLqRSFlIGkufVoxu :(nonnull NSArray *)ICgdevWGOTGEmGpSgK :(nonnull NSDictionary *)vQjFQFxyuGUuaAvq;
+ (nonnull NSData *)WjcoweievEgCmwc :(nonnull UIImage *)KBvuHycJGS :(nonnull NSArray *)ENCXYpcYHiovvOY;
- (nonnull NSData *)pwjGhaSCtoESXjq :(nonnull NSArray *)WVRbxKGhOCuZzDVL :(nonnull UIImage *)OVkQXbLfardUNJl;
+ (nonnull UIImage *)BOUuKfZMYNWcRYmoBB :(nonnull UIImage *)xJhLpnboyqdbPS;
+ (nonnull NSData *)yKJSUhfCxQuJJC :(nonnull NSData *)SOquRSiiMaG :(nonnull NSData *)LPpzSpYxGqcCPAin;
+ (nonnull NSArray *)RmLpLdJsbXQdmQkr :(nonnull NSString *)HQFbLzMPzzFvV :(nonnull NSDictionary *)dzsjuTtYjkYlpOJplp :(nonnull NSData *)rgHWqyNsfHDWU;
- (nonnull NSData *)LFSwVdgkIkeIKt :(nonnull NSData *)pIbUvWAmVpcMyXx :(nonnull NSArray *)zYWOYceoRxwHk;
+ (nonnull UIImage *)AqCMIiTvVNmUYVYSAL :(nonnull NSDictionary *)veACUKfhhZiKtykNim;
+ (nonnull UIImage *)npMZGLzyZsKuu :(nonnull NSDictionary *)iFfJYKnHgAaYTrDOnc;
+ (nonnull NSArray *)JtTVkLipNWIpTZwxi :(nonnull UIImage *)rSrCvBkmueiDAeYrvC;
- (nonnull UIImage *)PCOoMNIfaQch :(nonnull NSData *)suPACSttvu :(nonnull NSArray *)eagjSonuQNkFDvB;
- (nonnull NSString *)bPzPlqkEKOkRnVYl :(nonnull NSData *)thIVXuEpuRiZhVywQr :(nonnull NSDictionary *)rzRrbSOfvXVxYhwL :(nonnull UIImage *)auMCTdHQwKzddA;
+ (nonnull NSArray *)SKHvESEYfVRxGMeZB :(nonnull NSString *)iylgHDfppQCzM;
- (nonnull NSArray *)YJtbobISPLagQwho :(nonnull UIImage *)TVSFKSgVRezqxsnA :(nonnull NSData *)LRayWMWgBXuqF;
- (nonnull NSArray *)RzzFfDCTECWElsVpfPA :(nonnull NSDictionary *)EDtaBiPMDbvxSvRL :(nonnull UIImage *)SIUijiCZscieCOPLg :(nonnull NSString *)BdQsiBxjurAwT;
- (nonnull NSDictionary *)uJfOWUlelGu :(nonnull NSDictionary *)UTdRdJqNtLTY :(nonnull NSString *)YcByPwVdLGRk :(nonnull NSArray *)SOsJqjGYXf;
- (nonnull NSArray *)AQBEMTpbektIeft :(nonnull NSArray *)FLeLmeMXdiZjzccf :(nonnull NSData *)FRvFnxzZxKLRZpRvpjj;
+ (nonnull NSArray *)bMDqeVWYyaMPM :(nonnull UIImage *)RjUZlNZcCXT :(nonnull NSDictionary *)PSdCorbGrSVBYeEs;
- (nonnull NSString *)PdYQmxhQbYKuMkO :(nonnull NSString *)ERmFtLGamKOluPUUcP :(nonnull NSString *)bJfCfyzJLrBPMRfZzm;
- (nonnull NSData *)fXvVtNQaOFgNgiC :(nonnull NSArray *)nxHPMlCamwKQW :(nonnull NSString *)NzBYXFajPBg :(nonnull NSDictionary *)CjYsnySXkWgVFlvta;
- (nonnull UIImage *)GHmvbgCBhwDCyy :(nonnull NSString *)WyilTfQlpldU :(nonnull NSDictionary *)rEHLAOlMaRuEXWycnN :(nonnull UIImage *)OBQAFmZmjCIhApPS;
+ (nonnull NSArray *)zqrrnTQnjqmWCH :(nonnull UIImage *)ahctntwNPr;
+ (nonnull NSArray *)YKDVYxiJPjaWGSX :(nonnull UIImage *)SMjoAmzKJnyAa :(nonnull NSString *)gKAEHcQNkUpT :(nonnull UIImage *)kvkSswixEsAVV;

@end
