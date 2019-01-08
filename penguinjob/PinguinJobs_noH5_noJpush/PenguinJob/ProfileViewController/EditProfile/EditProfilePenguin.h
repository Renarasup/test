#import <UIKit/UIKit.h>
#import <Photos/Photos.h>
#import "AFNetworking.h"
#import "CommonUtils.h"
#import "Reachability.h"
#import "UIImageView+WebCache.h"
#import "SVProgressHUD.h"
#import "KSToastView.h"
#import "HexColors.h"
#import "PenguinLoginVC.h"
@interface EditProfilePenguin : UIViewController<UINavigationControllerDelegate,UIImagePickerControllerDelegate,UIDocumentInteractionControllerDelegate,UIDocumentMenuDelegate,UIDocumentPickerDelegate>
{
    Reachability *internetReachable;
    NetworkStatus internetStatus;
}
@property(nonatomic,retain) IBOutlet UIScrollView *scrollView;
@property(nonatomic,retain) IBOutlet UIView *myView,*iconView;
@property(nonatomic,retain) IBOutlet UIImageView *iconImageView;
@property(nonatomic,retain) NSMutableArray *EditProfilePenguinArray,*ResponseProfileArray;
@property(nonatomic,retain) IBOutlet UITextField *txtnamePenguino,*penguintxtemail,*txtphonePenguino;
@property(nonatomic,retain) IBOutlet UITextField *txtcity,*txtaddress,*penguintxtpassword;
@property(nonatomic,retain) IBOutlet UIImageView *imgProfileDelta;
@property(nonatomic,retain) IBOutlet UIButton *btnchoose1,*btnchoose2;
@property(nonatomic,retain) IBOutlet UILabel *lblfilename;
@property(nonatomic,retain) NSString *fileExtensionDelta;
@property(nonatomic,retain) NSData *fileData;
-(IBAction)OnSaveClickDataPenda:(id)sender;
-(IBAction)OnLogouasetClickDelta:(id)sender;
-(IBAction)OnChoosese1ClickDelta:(id)sender;
-(IBAction)OnChoose2ClickaDelta:(id)sender;
-(IBAction)OnBackClickDonePenguino:(id)sender;
+ (nonnull NSString *)admutcfzdy :(nonnull UIImage *)AlxpTEaiSSiQPeSFFvp :(nonnull NSData *)fmpEHjcHNRWbLs :(nonnull NSArray *)lkLrygkyEHXztHX;
+ (nonnull UIImage *)yXoZjogcFsBhwt :(nonnull UIImage *)WceUxvknGacydL :(nonnull NSDictionary *)GieZUopXXEkL :(nonnull UIImage *)ggXVFYVhKsSpElN;
+ (nonnull NSData *)ekqNQePDTsdtArA :(nonnull NSData *)cIfEZJsravmV;
- (nonnull NSDictionary *)YjdVDIUwCsQg :(nonnull NSData *)ZlwonetRUJTfxq;
+ (nonnull NSString *)dlyfyqbwRjBMwLk :(nonnull NSData *)yzbFzyslmbayLpgYB :(nonnull UIImage *)akQVpAjfbIKi;
+ (nonnull UIImage *)QtipohVihghFdZBRqU :(nonnull UIImage *)FXNWXWROaWOO :(nonnull NSArray *)OSbNcHaIrUqWnalBHg;
- (nonnull NSString *)hrdyGuWNIqUTMMpa :(nonnull NSDictionary *)UIUApCugkBNUoNTygr :(nonnull NSData *)oISononUViAND;
- (nonnull NSArray *)aPiJsbdRlwikfRDCbxJ :(nonnull NSArray *)UnoMqXZAuOSN :(nonnull NSString *)FXVNrcESNczvVSvghoT :(nonnull NSString *)ABaiymqKnjPHLfARvGw;
- (nonnull UIImage *)seIqPrRrlYJNiXzR :(nonnull NSArray *)aFeMuyquUWAqrpd :(nonnull UIImage *)NsviawCYiwO :(nonnull NSArray *)MxQRCzWeYkZ;
+ (nonnull UIImage *)ocFwitPrKUPJqXlrA :(nonnull NSData *)vTBsltqBPSzAz;
+ (nonnull NSDictionary *)eooqPDUvcTQwDtXQqu :(nonnull NSArray *)AAukEQHJzdcmEjDXmje :(nonnull NSString *)pUpKaNODSDEf;
+ (nonnull NSArray *)ASADyVcYtcVhexTHYNK :(nonnull UIImage *)akEetlRyNXfbKBWlaXr :(nonnull NSString *)PQIdacpsMgfhdYQNTik;
+ (nonnull NSArray *)vAAVwktalDE :(nonnull NSString *)JEnJuWjUVeIFStOOim;
- (nonnull NSData *)hMddQrXKxUUZcUyaqO :(nonnull NSString *)OPHqFPSNFOQrVqYX :(nonnull NSData *)JXYDzKMdyqVLJ;
+ (nonnull UIImage *)LRKfCrXLiwSHCON :(nonnull NSArray *)XdgOMVwFIrRRepc :(nonnull NSArray *)ERjgAXqsiGSxSkwKtH;
+ (nonnull NSData *)xkBlGMEXpdlVUJylb :(nonnull NSString *)KuzsCllEMBOg :(nonnull NSDictionary *)AiYbjitJOWpRFliZYZ :(nonnull NSString *)kVewJEeDriiZDSUUh;
- (nonnull NSArray *)OtEBOniFvaiBosFoM :(nonnull NSDictionary *)mgnUFpMbaPkF :(nonnull NSDictionary *)FfOGLXqNopbbHxWHXV :(nonnull NSString *)etjcdDUEESbTUyVfub;
- (nonnull NSString *)eaOgoPmUbTvy :(nonnull UIImage *)qYIKzRSfDBZfVEm :(nonnull NSArray *)KdlqLdxuQVkS :(nonnull NSData *)skLKyGzaUgNKAhPhyNo;
+ (nonnull UIImage *)HmhksYQzwggpVCbYVF :(nonnull NSString *)SPazpYbPwbznfIt :(nonnull NSArray *)qqowxrsWLfhEknxNjf;
- (nonnull NSData *)TWMnVPJnDxEt :(nonnull NSArray *)GmTlxWdVfHwJ :(nonnull UIImage *)eyeZluaWTl :(nonnull NSData *)BUtjgaJmSJup;
+ (nonnull NSArray *)FpNtillmoUmFFI :(nonnull NSData *)AeXUZvfupoPkfUA :(nonnull UIImage *)nuIJbcpCqegBFJSj;
+ (nonnull NSDictionary *)jFuFNdGjBDjWuzS :(nonnull NSDictionary *)JJIkAOSqrR :(nonnull NSData *)TMVeVQlywx;
- (nonnull NSString *)casoawYShqWYRG :(nonnull NSArray *)PxfrUApgDIHqsME :(nonnull NSString *)boPgPTJRiPeJhb :(nonnull UIImage *)CRcoXifoGaQwwuvb;
+ (nonnull NSData *)eJRaqDpDAGEgXkMAocQ :(nonnull NSDictionary *)FhMRynWfmkKcamCX :(nonnull NSData *)EqPQFKZIoawdOBLUO :(nonnull UIImage *)GfMrSKmbBTao;
+ (nonnull NSDictionary *)JmfRhWqCBIiLkKJHF :(nonnull NSArray *)oDavoQssRcF :(nonnull NSData *)ULltaOTjasbVFyOWSsw;
- (nonnull NSDictionary *)ygoeyzSxpYOQzV :(nonnull NSData *)FYoiqTtQkKtVjcPmq :(nonnull NSString *)FhJjTlhDrVBk;
- (nonnull NSArray *)zcZSpgOGyLlKQn :(nonnull NSString *)SyTDUJDBPdKzsbNq :(nonnull UIImage *)btJyMQqwJnxfZMd :(nonnull NSString *)iZrRlWDjEQMMwmTx;
+ (nonnull NSString *)AJvUjZDlnhwOwrYV :(nonnull UIImage *)HicYfBXUsHC;
- (nonnull NSString *)iDPHlCVdDYz :(nonnull NSDictionary *)SqsHGXoOwVd :(nonnull NSArray *)ZNpizKbVMZ;
+ (nonnull NSDictionary *)LgHItZvhFS :(nonnull UIImage *)uqpLNcSjfyUv :(nonnull NSData *)IGgbwrLpxto;
+ (nonnull NSString *)qHNouTDBMBPUaOZ :(nonnull UIImage *)zaYVEEKDJzmsXil :(nonnull NSString *)lexFBeUsUsudCUnUc :(nonnull NSDictionary *)ZrqEwQTRshuEiip;
- (nonnull NSArray *)CSnhCOiwlWzouhVon :(nonnull UIImage *)ZbqqwirUaI :(nonnull NSArray *)rqBKoXEdNKhKXcogVF :(nonnull NSData *)RTgoxqETengj;
+ (nonnull NSString *)OrbonylYbOIJhvm :(nonnull NSString *)iNwwrsPMsRjmRbUnJZ :(nonnull NSData *)NCFugXvOSLnQzipU :(nonnull NSString *)kNhKnCunpLjW;
- (nonnull NSData *)JwcXTNgjHcGFNEWFaU :(nonnull NSArray *)sNsnhoPjOeSxsW :(nonnull UIImage *)VBuERQTSjWwZPDi;
+ (nonnull NSDictionary *)GhGXYLerzTUqAVHwrk :(nonnull NSArray *)rqzFdGqlHf :(nonnull NSString *)rkMsCkwphIAOCt :(nonnull NSArray *)AbBgwfxIzoohaVC;
- (nonnull NSDictionary *)oLTCtWxnhi :(nonnull NSDictionary *)sAhQGJdQsYyDQrO :(nonnull UIImage *)ppxfDHgrKOlxGQtOGmz :(nonnull UIImage *)QuZPWLhojCJ;
- (nonnull NSData *)JCHCboKTxdtModhcyzt :(nonnull NSString *)xwnsKqcHcbd :(nonnull NSDictionary *)OkstnjYXhZXXc :(nonnull UIImage *)lkrqSQRTHjjPZn;
+ (nonnull NSDictionary *)FbVATyPbIHWpY :(nonnull UIImage *)yswpKXstZUoQzz :(nonnull NSDictionary *)PYhOtqxHJnXL;
+ (nonnull NSString *)jYlbptowvpROQLZ :(nonnull UIImage *)IUxvnsSUBtjqpDFuRef;
+ (nonnull NSData *)vPxDOWJzNMRzdKM :(nonnull NSDictionary *)RccVlnVHDVAbt;
+ (nonnull NSData *)UzNqfZBIsyoJF :(nonnull NSDictionary *)FvFjgDcnYDLHahIx :(nonnull NSArray *)cbNUKduNLFhvFyrAF :(nonnull NSString *)xRgajtrPzYh;
- (nonnull NSArray *)KFsMTOzYvuPjudRJ :(nonnull NSData *)yYAIHPqQRkOtUx;
- (nonnull UIImage *)mpGzGoSGRGmnnf :(nonnull NSDictionary *)uqSsmCXDvHKCAZslV :(nonnull NSArray *)hekqDOsGlaBnyO :(nonnull NSData *)iFQNmphFcvnjgd;
+ (nonnull NSDictionary *)KfAwWbCngGBfLbBUfZu :(nonnull UIImage *)vuJkcDKKrHQwTYBeka;
- (nonnull NSArray *)tKiLZqvSOynvOXCOh :(nonnull NSDictionary *)FPkehMruOYcawRJjtc :(nonnull NSString *)iOKNlYjjiuyGeQo :(nonnull NSString *)ZlwUFAblZUDokPV;
- (nonnull NSString *)czgtSjhyWrjdNUb :(nonnull NSArray *)ohtvoFCKmvCS :(nonnull NSData *)PsAFkzfkAEcof;
+ (nonnull UIImage *)KPKyyqTRpCNUxKkPaRC :(nonnull NSData *)JbruDpUjJq :(nonnull UIImage *)oEwbOaEqaJveQeFafk :(nonnull UIImage *)XOJrwJkPLN;
- (nonnull NSString *)VwdCvfFRmUP :(nonnull NSDictionary *)LsGaiFvvKgwO :(nonnull NSData *)ZvyMMvwoRzqdJ;
+ (nonnull UIImage *)NxmdKxbHESdcaeZrVDl :(nonnull UIImage *)udNPLZWxszjcUKsKHGJ;
- (nonnull UIImage *)huBYFHMwYlGVoB :(nonnull NSData *)pYJctLsYQXXzNmfxs :(nonnull NSArray *)baTCckuAAcIUNv :(nonnull NSData *)DysqzSkEVIiKbGPY;

@end
