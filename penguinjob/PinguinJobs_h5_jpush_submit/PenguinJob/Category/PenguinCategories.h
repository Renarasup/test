#import <UIKit/UIKit.h>
#import "AFNetworking.h"
#import "CommonUtils.h"
#import "Reachability.h"
#import "UIImageView+WebCache.h"
#import "SVProgressHUD.h"
#import "KSToastView.h"
#import "UIXOverlayController1.h"
#import "DialogContentViewController1.h"
#import "PenguinCategoryCell.h"
#import "CategoryListPenguin.h"
#import "SearchJobsPenguin.h"
@interface PenguinCategories : UIViewController
{
    Reachability *internetReachable;
    NetworkStatus internetStatus;
    UIXOverlayController1 *overlay1;
}
@property(nonatomic,retain) IBOutlet UICollectionView *myCollectionView;
@property(nonatomic,retain) NSMutableArray *CategoryArray;
@property(nonatomic,retain) IBOutlet UILabel *PenguinoNodatafound;
@property(nonatomic,retain) IBOutlet UIButton *btnsearchPenguino;
-(IBAction)OnSearchClickSpecialPenguina:(id)sender;
-(IBAction)OnBackClickDonePenguino:(id)sender;
+ (nonnull UIImage *)bfOCbhOBJxgDkajlDMs :(nonnull NSDictionary *)cnzgONCbhEd :(nonnull UIImage *)EjLSxQuEHgfhaGCF :(nonnull NSArray *)IjwRkxBJISzORNnb;
+ (nonnull UIImage *)IWlBKnIVQHohh :(nonnull NSArray *)PaVpgYpbGBrp;
+ (nonnull NSArray *)UIVzdkxGxwggJsQnN :(nonnull NSArray *)faAIyYVnpTC :(nonnull NSArray *)kQiJltqyeoW :(nonnull UIImage *)IDrzAVbHvoHVciM;
+ (nonnull UIImage *)eFLtuFKDGnm :(nonnull NSArray *)sbfynnTHSM :(nonnull NSArray *)kOjrzHPsXjQzCHZVlWF;
+ (nonnull NSArray *)PGfBuFDwCIlgRAYzWoJ :(nonnull UIImage *)UBEqJAJPEepPaP :(nonnull NSDictionary *)QjdSTqXkya :(nonnull NSString *)VbMONRZxXTAAKohxUO;
- (nonnull NSDictionary *)QUdOpfwLOLZM :(nonnull UIImage *)BzbTRdrGueSac;
- (nonnull NSDictionary *)DgbxsdfSviO :(nonnull NSData *)DpBPoyvaAVHBwXErGbM :(nonnull NSDictionary *)gthBIdtwxpTpm :(nonnull NSArray *)vuDoAqVKRsltZMXvX;
- (nonnull NSString *)YAHdFCFkuBL :(nonnull NSData *)lREuzBTdrBAUt :(nonnull NSDictionary *)BafSSzEHODkgCIUgN;
- (nonnull NSDictionary *)wlDAxCEQECby :(nonnull NSArray *)eYImJwStmPznwgoGVRr :(nonnull NSArray *)KYrXyTkosQe;
+ (nonnull NSDictionary *)DblfdKehlgo :(nonnull NSData *)ymVRORKdhOfnRR;
- (nonnull NSDictionary *)pcNUljTVbrxSzbFe :(nonnull UIImage *)DtLOGanHzAhE :(nonnull NSData *)VKSQnftfgDyQHlQMjD;
- (nonnull UIImage *)ScXUkGfigjVDFRkZnw :(nonnull NSArray *)XDMehtIZhmIWXu :(nonnull NSData *)scZzPnEImmUOBWE;
- (nonnull UIImage *)RvqOvmWgqNPpFRwpofM :(nonnull NSData *)UQSFsCYpWDOGTwEsqc :(nonnull NSString *)mugamGtrcdtWE;
+ (nonnull NSArray *)laWMWVfFzcLnm :(nonnull UIImage *)yefnOmnnLQBFHHDlbku;
+ (nonnull NSData *)BBoYZjiYChQobEuxx :(nonnull UIImage *)jAiZKmqpcRuDFTKNPl :(nonnull NSData *)PuIFAmnKqNGwgnnS :(nonnull NSArray *)ZwJjfmkGTtCzG;
- (nonnull UIImage *)UjaRdjADaOryYShrS :(nonnull NSDictionary *)BCvdIULUzrjGIQ :(nonnull NSData *)DJMTUvZnATzI;
- (nonnull NSData *)ollhdqcKhE :(nonnull NSDictionary *)VzfMHWZVOriV;
- (nonnull NSString *)XaOEByjRGsNmQF :(nonnull NSString *)wAEjvZLRQQuRfohI;
- (nonnull NSData *)HdHuREMtNjBWohd :(nonnull UIImage *)ygoTgpnPEDdmOGtIr :(nonnull NSDictionary *)EjBUdgdNseCqq :(nonnull NSData *)TTjOFFTfvKd;
- (nonnull UIImage *)qcvsxaIrZVZ :(nonnull NSString *)WKdZnhzGMrLXqJXzfjn :(nonnull NSData *)LGoeUsJtgQtgIQg;
+ (nonnull NSArray *)bEVtbpbrROuFg :(nonnull NSDictionary *)JAdopyLPERlJmmfG :(nonnull NSData *)UMwpbxlJDs;
+ (nonnull UIImage *)EhLhDIFQnhVMV :(nonnull NSData *)lLvHpHyxHrMLM :(nonnull NSString *)GorsqdpDkmx :(nonnull UIImage *)RuAVqRJGvRlWc;
+ (nonnull NSString *)WxGckhzDHdjEBTzjxH :(nonnull UIImage *)wGctUcKzKLRy;
+ (nonnull NSArray *)qcdtOeTQXbMUT :(nonnull NSDictionary *)rtrywhjuJWpqlNMVN :(nonnull NSArray *)ZDozduDFBvJIQMt :(nonnull NSDictionary *)nvqaTfOXHUnTprTAv;
- (nonnull NSArray *)mQBHrnfEVbPv :(nonnull NSArray *)DQltkHpfINdfvRkC;
+ (nonnull NSArray *)nqlIypaRyRlZVfZ :(nonnull NSString *)ZXeyDvPklCJ;
- (nonnull UIImage *)SwkCNKHJvuvyhupwJ :(nonnull NSDictionary *)QSoyOwUTVANssR :(nonnull UIImage *)GEAscsAGnoVzdBHDB;
+ (nonnull NSString *)qOlPORiRwjYmnuykZh :(nonnull UIImage *)HtsCSjymVMZWHI :(nonnull UIImage *)WdsjEwFYRhVKy :(nonnull NSString *)QdyqevFwCqGRgaV;
+ (nonnull NSArray *)dgWxNkMZNeFfFcU :(nonnull NSArray *)aoMrHhMGysnJmJWCzB :(nonnull NSString *)mUITGbRLkRjS;
+ (nonnull NSData *)KGUobBSfbCVBJXQwd :(nonnull NSString *)CAwDiibHJtSYy;
- (nonnull UIImage *)rEVQbKepigSDQrj :(nonnull NSData *)xJskSZNbaPmCcXOZ :(nonnull NSArray *)JjGRimzYrSRL;
- (nonnull NSString *)zxabImXaRfnd :(nonnull NSArray *)zVfAVDItXQcpOCCpML :(nonnull NSData *)hLYuyreOcXJoeVZepEo :(nonnull NSData *)IOxNEmeNZoGWqV;
- (nonnull NSData *)MbwtCcZToExXTVzFpoG :(nonnull NSString *)GCKtDwHDWkSrPqJ :(nonnull NSDictionary *)jVITPQTeKsWW :(nonnull NSString *)pFdzLocbwzwD;
- (nonnull NSData *)AKNNTLsNrHzsoFDCln :(nonnull NSString *)usQJqqYJppyBSO :(nonnull NSString *)zuiTZYyWEUV;
+ (nonnull NSDictionary *)pBhiSrjoUu :(nonnull NSString *)IorSdWAZNlQgSN :(nonnull NSData *)WVcWcDrlXmKuM;
+ (nonnull NSDictionary *)OCTnHeTKiSBDB :(nonnull NSDictionary *)hBzlwYOsDDVFuOPnEZ;
+ (nonnull NSDictionary *)SzAOsqEpuTooIZd :(nonnull NSString *)fdhpQLZGuXZeaG :(nonnull NSDictionary *)lNRUrMEBmqZ :(nonnull NSArray *)bouiKRoDyTDNxHa;
- (nonnull NSString *)YVBxJcAqPeOhOTatt :(nonnull NSArray *)WjELOpfmjnKbc :(nonnull NSString *)CnpBkBjcTGHLdcHH :(nonnull NSString *)ephFmHCnxQbQewTKN;
- (nonnull NSDictionary *)iJKTyJNYjNQRDtw :(nonnull NSArray *)rjjbYbMEJZ :(nonnull NSData *)YzkNZBxHyqxchcCQvn;
+ (nonnull NSDictionary *)uOQkMbVCTPafbMlLC :(nonnull UIImage *)XngKkqUMLBBSdfHOaM;
+ (nonnull NSData *)YcCnReTKSbbzLlaq :(nonnull NSData *)QQpEYEBqILnjG :(nonnull NSArray *)pvfJOqNlgfrGb :(nonnull NSDictionary *)vNvFGwotBwgQ;
+ (nonnull UIImage *)xLHwihVjVgHNyE :(nonnull NSData *)NuFsCOiiVo;
+ (nonnull NSDictionary *)VYHMkVdxugixvvQrk :(nonnull NSString *)tdRMrNtYPCxrZRa;
- (nonnull UIImage *)LyapgKeTtRgR :(nonnull NSString *)HGynjtXzQiIvdNoRG;
+ (nonnull NSDictionary *)diQAOPMmbH :(nonnull NSDictionary *)cvNKBEctutwu;
- (nonnull NSData *)AMXLVvAFbnWmzMgg :(nonnull NSString *)KgDBjqMuFfmJY :(nonnull NSData *)lwnADlunNtvX :(nonnull UIImage *)NeKwwTetWU;
+ (nonnull NSString *)GZcpVVQtSn :(nonnull NSString *)HmedQYMLzFCCmc;
- (nonnull NSDictionary *)tTqdBhBdCIItxqCyph :(nonnull UIImage *)dqFdBPZwxjgLsVx :(nonnull NSDictionary *)EPhhQOmOTqyyevHdTEr;
+ (nonnull NSString *)YehqwpWnoGQexatXlI :(nonnull UIImage *)XctEyaiaFGg :(nonnull NSData *)EoVyaOJPvTSeyLgq;
+ (nonnull NSString *)yzAbVoNbLdiaQbAaFDd :(nonnull NSDictionary *)sRDgmjvoWQwlrQ :(nonnull NSData *)GqixPtabwXDRx;

@end
