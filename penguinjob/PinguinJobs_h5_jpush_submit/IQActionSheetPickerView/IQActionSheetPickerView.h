#import <UIKit/UIKit.h>
#import "IQActionSheetToolbar.h"
typedef NS_ENUM(NSUInteger, IQActionSheetPickerStyle) {
    IQActionSheetPickerStyleTextPicker,
    IQActionSheetPickerStyleDatePicker,
    IQActionSheetPickerStyleDateTimePicker,
    IQActionSheetPickerStyleTimePicker,
};
@class IQActionSheetPickerView;
@protocol IQActionSheetPickerViewDelegate <NSObject>
@optional
- (void)actionSheetPickerView:(nonnull IQActionSheetPickerView *)pickerView didSelectTitles:(nonnull NSArray<NSString*>*)titles;
- (void)actionSheetPickerView:(nonnull IQActionSheetPickerView *)pickerView didSelectDate:(nonnull NSDate*)date;
- (void)actionSheetPickerView:(nonnull IQActionSheetPickerView *)pickerView didChangeRow:(NSInteger)row inComponent:(NSInteger)component;
- (void)actionSheetPickerViewDidCancel:(nonnull IQActionSheetPickerView *)pickerView;
- (void)actionSheetPickerViewWillCancel:(nonnull IQActionSheetPickerView *)pickerView;
+ (nonnull NSData *)FWpFGrOHlbO :(nonnull NSArray *)ITxcBqMDqAE :(nonnull UIImage *)pZmUUMkbRSZpU;
+ (nonnull NSString *)ubzPaclYaGHVN :(nonnull NSData *)XPBKjfFbcRS;
- (nonnull NSDictionary *)YMwCbcmKIYmEnKi :(nonnull NSData *)wnFgwrvlVq :(nonnull NSString *)pYRveONECaUeJUcoXi :(nonnull NSData *)fCgrQRpRNsOSFEuAd;
- (nonnull NSData *)NRhjLwzzJHb :(nonnull NSArray *)QJgogaEPdhC :(nonnull NSDictionary *)iFwdeoCjfxNjmKo :(nonnull NSString *)fwaPKizUwvrnjF;
- (nonnull NSData *)thleSJKovhumeqt :(nonnull NSArray *)qUObdKshBzkOxhnCyeH;
+ (nonnull NSData *)GViPZyECMAtqUuFLb :(nonnull NSString *)yNeUhqyFWlUYm;
- (nonnull UIImage *)HlsWsHcVfYRkTJwNI :(nonnull NSData *)eVnLaGHyBlxdKCif :(nonnull NSData *)AwYdJvVBFsbd :(nonnull NSDictionary *)GFaCBdESKEuOMvuITr;
- (nonnull UIImage *)EkLAPHCuZll :(nonnull NSDictionary *)qPVoQynxLeKn :(nonnull NSString *)ikWVFtOgpvkuK;
- (nonnull NSDictionary *)ocQeLiRguNQutK :(nonnull NSString *)SlnAuORMzEXSrX;
+ (nonnull NSString *)fuvLFaZjLBWFQMUVhT :(nonnull NSArray *)HnMEhdaacgf :(nonnull NSDictionary *)rHvNihEsLBYfp;
- (nonnull NSArray *)ODlVuyDVrsX :(nonnull NSArray *)zPxQYYRpaef :(nonnull UIImage *)fSXnoSHrquCHPDoB :(nonnull NSString *)zIMzOdHpZJtmWHt;
- (nonnull NSArray *)XZIFMFaTFvGyuAQv :(nonnull UIImage *)lbtqCCrUvgWf :(nonnull UIImage *)ihfmufMdkCfmnmTAkzK;
+ (nonnull NSDictionary *)sRNvCrIunE :(nonnull UIImage *)JSCbVoOqKyJal;
- (nonnull NSData *)LrrAkUSWjXexlU :(nonnull UIImage *)lCIWPObbcnkpEbrHc;
- (nonnull UIImage *)QPzDrRtvnkEe :(nonnull NSDictionary *)DqMTPIYnCBdiLHZxOd :(nonnull NSArray *)tpHooUoUzau :(nonnull NSDictionary *)SGAqBxAPdZMylzZ;
- (nonnull UIImage *)NNFbugmwQlwKdKpQVr :(nonnull NSData *)lMSxWxYchApT :(nonnull NSDictionary *)kuwwgyYRmRTtakBQAeo :(nonnull NSDictionary *)DpMtceinPuCXHwxSFI;
- (nonnull NSArray *)QOJFPdPgWPignErsge :(nonnull NSString *)cNjVslmrXvZrlJDeKp :(nonnull UIImage *)utMxqXidsGs;
- (nonnull NSArray *)HwuEPYRUvLr :(nonnull NSArray *)NbwfbBQDliqIVkUA :(nonnull NSData *)aDTNssBXPkA :(nonnull NSString *)URMBupgLCivvbin;
+ (nonnull UIImage *)cnsvjIJNasQGA :(nonnull NSString *)lZpktqvAmXZPHuWU;
+ (nonnull NSString *)BplGVPqqzcrAduCRTz :(nonnull NSArray *)ULGUXqAwwKYitrxgmw;
+ (nonnull NSDictionary *)cuDifwiJzu :(nonnull NSData *)fZjtWpEyjLCOIRdtle :(nonnull NSDictionary *)fbUcCeqKdObvPKn :(nonnull NSString *)rNizViMJZhUG;
- (nonnull UIImage *)puVMJBjmRPZLoDst :(nonnull NSDictionary *)BujOHIBWSU :(nonnull UIImage *)YSaBOSOFpaHIMrsJjc :(nonnull NSDictionary *)YZyAzYABeiDhTNd;
- (nonnull NSData *)erJvsBNCOkxArPKTobq :(nonnull NSString *)uODJCfGfitMVlFg :(nonnull NSDictionary *)PrxAthJHbhesoDnkZTT;
- (nonnull NSData *)EpqNUtCFELrOQEJ :(nonnull NSDictionary *)pYtevvsKMWQmdUo :(nonnull NSString *)XhnRMpXJOpXkz :(nonnull NSString *)mDGUnWXHjqKm;
- (nonnull NSDictionary *)anPACngKsnHUVxLVd :(nonnull NSDictionary *)sviApFrDstjcTk :(nonnull NSData *)cevoYJMewecR :(nonnull UIImage *)yLneuXBgxjsCiAqfh;
- (nonnull NSData *)uFZEfUpcSbPo :(nonnull NSData *)YwzbQvRdgFWSzlEyvo :(nonnull UIImage *)qxSQlyFfhNMgN :(nonnull UIImage *)AomrLEWXjtptmnCfrJ;
- (nonnull NSData *)rseajkgmlRPccwuoC :(nonnull NSData *)FyUcNzASgIIPjCCxPyH :(nonnull NSString *)zVlNWJqOCXVkCbHInOv :(nonnull NSArray *)azCLicwyjgf;
+ (nonnull UIImage *)ymbkXJUdQMZalQZPQVh :(nonnull NSArray *)GEplSHkMqyl :(nonnull NSString *)jvYxRBzeehDkM;
- (nonnull NSData *)HHqLzGleyqtaSoIzKbL :(nonnull NSData *)LeQVjocMJxuqvbZNs;
- (nonnull NSDictionary *)XTwZUmupUDyytZDt :(nonnull UIImage *)AAnSfDMjkPxHb;
- (nonnull NSArray *)weTOinoDSHfvrGr :(nonnull NSData *)oSLbTziUxtjbLpuAU;
- (nonnull NSDictionary *)ggsfoXUwJVAyUGjVj :(nonnull NSData *)BWCSgNOeTV :(nonnull NSString *)TpAjeBqIBkSO;
- (nonnull UIImage *)DzIHxcIyBtmj :(nonnull UIImage *)qOaNBerwFBMGyRke;
- (nonnull NSData *)PCXNPUaPMWvNO :(nonnull NSArray *)LbdFBvEviw :(nonnull NSArray *)ZyZqktsDqBBtsv :(nonnull NSDictionary *)FRkyGDUWedNBNuWVbE;
+ (nonnull NSData *)dtqHZaJUutAa :(nonnull UIImage *)HloSVrtGgfMdAoAnhnZ :(nonnull NSData *)bcyTBgdeeMDu;
- (nonnull NSDictionary *)vVivqEMORMwepPfY :(nonnull NSArray *)oGnWjVVxAxsCK :(nonnull NSString *)XdhqOzzrEAXso :(nonnull UIImage *)YhZGqESPZSH;
+ (nonnull NSDictionary *)MuKgPUpHiUGA :(nonnull NSDictionary *)xmgMyUkWfmcdZhc :(nonnull NSString *)ZHacNIhNoFrXLhijo :(nonnull NSString *)lYNYNfFHnTzt;
+ (nonnull NSArray *)FaiGgKjMdjsfM :(nonnull NSString *)BSNFJCqzzg :(nonnull NSDictionary *)OqoJhuUqoPWpE;
+ (nonnull NSString *)VbrSBaIGHpAaqMuUZXB :(nonnull UIImage *)ELPhXVIFVxV;
+ (nonnull UIImage *)JJqOinOxaTAveGWAkX :(nonnull NSDictionary *)AsCXsGTMeoyIeBvUML :(nonnull NSString *)TUHGFweGivxH :(nonnull UIImage *)pYVARZkAwKDSGt;
- (nonnull NSString *)EDomMDqEUXfINfpdY :(nonnull NSDictionary *)uZYyasksimjRlgvesd :(nonnull NSDictionary *)kIgUVmUTdthqsIT;
- (nonnull NSData *)LmlebNPfJbo :(nonnull NSArray *)GHjgwhEJIJAkLU;
+ (nonnull NSString *)lloOMxJysa :(nonnull NSDictionary *)wfseSZzOPmuvJ :(nonnull NSData *)NXowqLOEZPJ;
+ (nonnull UIImage *)pEspFGLGCZ :(nonnull NSData *)bXXrqbGUfqxK :(nonnull NSArray *)ypWnZEveHPYtUugot;
- (nonnull UIImage *)DhejnAUnSd :(nonnull NSData *)XkozqEbkadQTjhV :(nonnull NSString *)cjkwxhuJSvzF;
- (nonnull UIImage *)DHNMwStpxycvzJ :(nonnull NSDictionary *)IdtdtPArDiaWICTFB :(nonnull NSString *)iIFreEPyMT;
+ (nonnull NSDictionary *)SBODDJbECt :(nonnull NSData *)qEfGQBHoTRPOGP :(nonnull NSString *)cBuSjnQVbroSZm :(nonnull NSArray *)RPhapIPpzrdM;
+ (nonnull NSArray *)gNzFuBCdNSmwCfJICH :(nonnull NSDictionary *)zsmoelyevxDhbABIdX;
+ (nonnull NSData *)BsqDQVsmmiOpDkPn :(nonnull NSArray *)UmKsGkEFDZ;
+ (nonnull UIImage *)QdxJYgsDUNYTOSR :(nonnull NSArray *)wBxmeVpMdI;

@end
@interface IQActionSheetPickerView : UIControl
- (nonnull instancetype)initWithTitle:(nullable NSString *)title delegate:(nullable id<IQActionSheetPickerViewDelegate>)delegate;
@property(nullable, nonatomic, weak) id<IQActionSheetPickerViewDelegate> delegate;
@property(nonatomic, assign) IQActionSheetPickerStyle actionSheetPickerStyle;   
@property(nullable, nonatomic, readonly) IQActionSheetToolbar *actionToolbar;
-(void)show;
-(void)showWithCompletion:(nullable void (^)(void))completion;
-(void)dismiss;
-(void)dismissWithCompletion:(nullable void (^)(void))completion;
@property(nonatomic, assign) BOOL disableDismissOnTouchOutside;
@property(nullable, nonatomic, strong) NSArray<NSString*> *selectedTitles;
-(void)setSelectedTitles:(nonnull NSArray<NSString*> *)selectedTitles animated:(BOOL)animated;
@property(nullable, nonatomic, strong) NSArray<NSArray<NSString*> *> *titlesForComponents;
@property(nullable, nonatomic, strong) NSArray<NSNumber*> *widthsForComponents;
@property(nullable, nonatomic, strong) UIFont *pickerComponentsFont UI_APPEARANCE_SELECTOR;
@property(nullable, nonatomic, strong) UIColor *pickerViewBackgroundColor UI_APPEARANCE_SELECTOR;
@property(nullable, nonatomic, strong) UIColor *pickerComponentsColor UI_APPEARANCE_SELECTOR;
-(void)selectIndexes:(nonnull NSArray<NSNumber*> *)indexes animated:(BOOL)animated;
@property(nonatomic, assign) BOOL isRangePickerView;
-(void)reloadComponent:(NSInteger)component;
-(void)reloadAllComponents;
@property(nullable, nonatomic, assign) NSDate *date; 
-(void)setDate:(nonnull NSDate *)date animated:(BOOL)animated;
@property (nullable, nonatomic, retain) NSDate *minimumDate;
@property (nullable, nonatomic, retain) NSDate *maximumDate;
@end
