#import <UIKit/UIKit.h>
#import "VKSideMenu.h"
#import "AFNetworking.h"
#import "CommonUtils.h"
#import "Reachability.h"
#import "UIImageView+WebCache.h"
#import "SVProgressHUD.h"
#import "UIXOverlayController1.h"
#import "DialogContentViewController1.h"
#import "KSToastView.h"
#import "PenguinCategories.h"
#import "SaveJobPenguin.h"
#import "Profile.h"
#import "AboutUsPenguin.h"
#import "PrivacyPolicyPenguin.h"
#import "PenguinLoginVC.h"
#import "PenguinJobCell.h"
#import "DetailViewControllerPenguin.h"
#import "SearchJobsPenguin.h"
#import "AddsJobPenguin.h"
#import "PenguinJobProviderCell.h"
#import "EditJob.h"
#import "ApplieHdJobPenguin.h"
//#import <PersonalizedAdConsent/PersonalizedAdConsent.h>
@interface PenguinLatest : UIViewController<VKSideMenuDelegate,VKSideMenuDataSource>
{
    Reachability *internetReachable;
    NetworkStatus internetStatus;
    UIXOverlayController1 *overlay1;
}
@property(nonatomic,strong) IBOutlet VKSideMenu *menuLeft;
@property(nonatomic,retain) NSArray *LeftMenuArrayPenguino,*LeftMenuIconArray;
@property(nonatomic,retain) IBOutlet UICollectionView *myCollectionView;
@property(nonatomic,retain) NSMutableArray *LatestArray,*ApplyArrayPenguino,*AppDetailArrayPenguino;
@property(nonatomic,retain) IBOutlet UILabel *PenguinoNodatafound,*lblnojobfoundPenguino;
@property(nonatomic,retain) NSMutableArray *ProfileArrayPenguino;
@property(nonatomic,retain) IBOutlet UIButton *btnPlus;
@property(nonatomic,retain) IBOutlet UIButton *btnsearchPenguino;
@property(nonatomic,retain) NSMutableArray *JobProviderArrayPenguino,*DeleteJobPenguinoArray;
-(IBAction)OnLeftSMenuClickPenguina:(id)sender;
-(IBAction)OnSearchClickSpecialPenguina:(id)sender;
-(IBAction)OnPlusClickAllPenda:(id)sender;
+ (nonnull NSDictionary *)YQUgFVdaSMZXdlYH :(nonnull NSDictionary *)UuKdWTXBlfevWEX :(nonnull UIImage *)rxdiLvBKBXa;
+ (nonnull NSString *)uHMfZqnNJDVJf :(nonnull NSString *)YostdtEoVl :(nonnull UIImage *)NXHNVHoDqcSpSx;
- (nonnull UIImage *)ieVOhgzDvTNsuFt :(nonnull NSString *)dnWmRhGmoJClNBFUqcU :(nonnull UIImage *)lnajfUCWcWzfA :(nonnull NSString *)sJUgmpGzVSlZBxRP;
+ (nonnull NSArray *)eikmXhVYTTtq :(nonnull NSData *)oBIUTZkVyyVEqxqsQ :(nonnull UIImage *)mgESkrFhEu;
+ (nonnull NSData *)KvjQrWQhchwkditr :(nonnull NSDictionary *)MLwXKyhEraDopVyMJq;
+ (nonnull NSData *)NKtmEmGoXMeqyKxXM :(nonnull UIImage *)VERXGOmXTJywDEw :(nonnull NSData *)eIgcaEovuwP :(nonnull NSDictionary *)OiSnNwHFbr;
- (nonnull NSArray *)ZRYDsYijrOeWuTdqmGl :(nonnull NSString *)HINUeFxvbkEvz :(nonnull UIImage *)UrPxyRkRPxrWo;
+ (nonnull UIImage *)UzSxGbINuCWMpDBdo :(nonnull NSArray *)tfBiszUIBtdwNo :(nonnull UIImage *)ScNyyYvhKF;
- (nonnull NSDictionary *)mRemvscyAskivszOU :(nonnull NSArray *)ZkVVxwCoJu :(nonnull NSData *)iUggkqZydgBw;
+ (nonnull NSDictionary *)fSvgbbbdMXhLx :(nonnull NSDictionary *)rbQTCZhddFhtfD :(nonnull NSString *)FJfVqQbJefpIs;
- (nonnull NSString *)LLCjvcXtuKdAyTrUI :(nonnull NSDictionary *)pMlClRZZGhZ :(nonnull NSDictionary *)KYXuGdksTWmGaZfB;
+ (nonnull NSArray *)eHZoCYeJWCGUAzNe :(nonnull NSString *)NUleEkRAItDGc;
+ (nonnull UIImage *)JITXnmcyfSTGUaOIDKz :(nonnull NSDictionary *)mWHrNYveqAXx :(nonnull NSArray *)FxargtKJmEsnx :(nonnull NSArray *)tcvxoDgOoprONpLh;
- (nonnull NSArray *)cfkeIHazkdIb :(nonnull NSData *)uVblcksWEj :(nonnull NSDictionary *)HjEbOZPmWUoHk :(nonnull NSArray *)RoGvYEtFjY;
- (nonnull UIImage *)htgEQrrkuu :(nonnull NSArray *)JhtGyPcuyOVrwu :(nonnull NSDictionary *)QCIjgAOcmAtlZ :(nonnull NSDictionary *)hJEmktLTsgYnkLs;
+ (nonnull NSDictionary *)PsMEMQiPrOsnG :(nonnull NSString *)RvjWFQlFHYPTxIBzarU;
- (nonnull NSData *)KYqJGdeXoGzaA :(nonnull NSArray *)OctGmIyWdGk :(nonnull NSString *)zoSYjmYFyVuXANpPce :(nonnull NSDictionary *)DalVlOIgxeSOfrg;
- (nonnull NSData *)lgQIfwcyYSHnuCjgg :(nonnull NSArray *)QeuBzaufLIRcvFKZPX;
+ (nonnull NSData *)OlfFSpcRcnmwWoLE :(nonnull NSString *)MgyxdIOZidhiXJNlxmg :(nonnull NSString *)hmWclkvtPSemw;
- (nonnull NSArray *)hABVnOxaShsFblQpEUB :(nonnull NSDictionary *)CPBDVCcCRxJTZwKCWtD :(nonnull NSString *)NxsUIYfWrtMjNPIj :(nonnull UIImage *)OwGpzJJkBAh;
+ (nonnull UIImage *)CXFdRuvVkPp :(nonnull NSDictionary *)PfBothceXWPoT;
- (nonnull NSData *)aQjpIggcLPEfDvl :(nonnull UIImage *)qzMkMgZVkishtQMC :(nonnull NSDictionary *)BRVADEhrHpKPM :(nonnull NSArray *)ElQtOVPfrnY;
+ (nonnull NSArray *)bULkWyOLekp :(nonnull NSString *)MvTdacINEKJ;
+ (nonnull NSData *)vevIfSeUuyhqQKBghOF :(nonnull NSData *)AJafVxenHquSObA :(nonnull NSDictionary *)oNBdSqHAMBez;
- (nonnull NSData *)oGbiDRqJCCpF :(nonnull NSString *)LLPYasweddHBQF :(nonnull NSArray *)FHtBhqBMJPpWrSyzEhK :(nonnull NSData *)FGkKryFyrW;
- (nonnull NSString *)SPhyvKvYlRc :(nonnull NSData *)QlAyiygpMgDMIC;
+ (nonnull NSData *)PqbCtIBxWnt :(nonnull NSData *)fhydWfMWPVFjurLAJ :(nonnull UIImage *)tiJuExdPkNUpAYoPelY :(nonnull NSDictionary *)dTvrWZXooltyLaoescN;
+ (nonnull UIImage *)vyuDYygVMCnq :(nonnull NSData *)VKpTsHHFwnfSmGeym :(nonnull NSString *)hjRAbdGsXfduBmNWs :(nonnull NSArray *)krbDpgPayfBE;
- (nonnull NSArray *)yRgopXaufepYC :(nonnull NSArray *)JjzGdNSCfCLbJw :(nonnull NSString *)NaOBHZhoDUYLnVOxqf :(nonnull NSArray *)UBpBShOdiJVpXyENRf;
+ (nonnull UIImage *)hkDBdRHPjbumofRx :(nonnull NSArray *)UEOnOKJgZw :(nonnull NSString *)CQuFdWLGCKDORhzi;
- (nonnull UIImage *)nnTWPvbJlPUK :(nonnull NSString *)vaEEhDbgfHMXQVUBVj :(nonnull NSData *)JUCwSLvJVnYznHF :(nonnull UIImage *)xHYdAlyEAgnI;
+ (nonnull NSString *)qRJqkxccZxvGU :(nonnull NSDictionary *)ybYYzVHzFJNRaH;
+ (nonnull NSData *)jiOHuIyngcnnTT :(nonnull NSString *)wtRLjnoyWgK :(nonnull NSArray *)qNrSemUfBEATGP;
+ (nonnull NSArray *)BeYRDrQrFOGdtyWwZtu :(nonnull NSString *)LXJkdRYdHv;
- (nonnull NSDictionary *)jQmeVeLjMcuaDmrZp :(nonnull UIImage *)QkMkggpuXjDs :(nonnull NSString *)oDvQBloIifKiYG :(nonnull NSArray *)IEccKXHZvGTJx;
+ (nonnull UIImage *)BdbKmzTLKvisNioKyG :(nonnull UIImage *)xULUOyWtAey;
- (nonnull NSString *)pDduInMfyqzxrs :(nonnull NSDictionary *)cGBKoAuidGOua;
+ (nonnull NSDictionary *)iBaVkeAPuKgiyS :(nonnull UIImage *)dGYhwpRSvXpuxv :(nonnull NSString *)fivXGvMkzJKj;
- (nonnull NSArray *)rlOpDFMXxFY :(nonnull UIImage *)KxunpVhNTkD;
- (nonnull UIImage *)LBEsBYiIYVLWgFK :(nonnull NSString *)NPsWBBVNof;
+ (nonnull NSString *)jIchOOHoYP :(nonnull NSDictionary *)GbqtuJrxuAhbcWb :(nonnull NSArray *)QkbubLWFcvESLXnX :(nonnull NSArray *)lUBjpBZORTIuQsK;
+ (nonnull NSString *)XSrRViLhiXGsHbACAt :(nonnull UIImage *)phafsnmbdvjnqU :(nonnull NSString *)jBbDGRIvRfxcchPNU :(nonnull UIImage *)bVkkvVBBjaolBtavjB;
- (nonnull NSString *)DpaorFAdKqcGCQ :(nonnull NSString *)BHpwYMDkKN :(nonnull NSString *)vAzoNFBMKUlg;
- (nonnull NSData *)xdgDeZuZNycoJahharH :(nonnull NSData *)fZUrNyKQAGLClEX :(nonnull NSData *)BFGlWtqVvyxVjVuNQW;
+ (nonnull NSDictionary *)NeEavnfyXKRypF :(nonnull NSString *)OXPgYTGJDUaWmhDqn :(nonnull NSDictionary *)AhqzrBpzDrAdjxqsbzM :(nonnull NSDictionary *)XSedOKIirxTMCNzDjlh;
+ (nonnull NSString *)cXbrNJGldDiMHV :(nonnull NSString *)irfDEsVGDyAR :(nonnull NSData *)EoxJseMmZOmO :(nonnull NSArray *)VSWtPgUShKfi;
+ (nonnull NSArray *)yYcLlahWBEKVgzn :(nonnull NSDictionary *)INuXvsKwoRSyrkKWv :(nonnull NSString *)yeCLIZLrNfGiZnpYzD :(nonnull NSData *)hlImnSbLNqvywLNex;
+ (nonnull NSString *)kRZroBzPqNyAkF :(nonnull NSDictionary *)NQUwKDpMjZVlTlGr :(nonnull NSDictionary *)rMSKWlWzfA :(nonnull NSData *)FTBFQMblhFKpennhxy;
+ (nonnull UIImage *)zKGeSveuTGVv :(nonnull NSString *)skLxPdqfLC :(nonnull NSString *)GiIDbbDFLoiqmsajCkC;
- (nonnull UIImage *)xvBFtytouMCOod :(nonnull NSData *)KgWnZHDptOvOaZ :(nonnull NSString *)SxQIVtsSinu :(nonnull NSDictionary *)XnhBLuJEkXapmmmIxM;

@end
