#import <Foundation/Foundation.h>
#import "EGODatabaseRequest.h"
#import "EGODatabaseResult.h"
#import "EGODatabaseRow.h"
#import <sqlite3.h>
@interface EGODatabase : NSObject {
@protected
	NSString* databasePath;
	NSLock* executeLock;
@private
	sqlite3* handle;
	BOOL opened;
}
+ (id)databaseWithPath:(NSString*)aPath;
- (id)initWithPath:(NSString*)aPath;
- (BOOL)open;
- (void)close;
- (BOOL)executeUpdateWithParameters:(NSString*)sql, ... NS_REQUIRES_NIL_TERMINATION;
- (BOOL)executeUpdate:(NSString*)sql;
- (BOOL)executeUpdate:(NSString*)sql parameters:(NSArray*)parameters;
- (EGODatabaseResult*)executeQueryWithParameters:(NSString*)sql, ... NS_REQUIRES_NIL_TERMINATION;
- (EGODatabaseResult*)executeQuery:(NSString*)sql;
- (EGODatabaseResult*)executeQuery:(NSString*)sql parameters:(NSArray*)parameters;
- (EGODatabaseRequest*)requestWithQueryAndParameters:(NSString*)sql, ... NS_REQUIRES_NIL_TERMINATION;
- (EGODatabaseRequest*)requestWithQuery:(NSString*)sql;
- (EGODatabaseRequest*)requestWithQuery:(NSString*)sql parameters:(NSArray*)parameters;
- (EGODatabaseRequest*)requestWithUpdateAndParameters:(NSString*)sql, ... NS_REQUIRES_NIL_TERMINATION;
- (EGODatabaseRequest*)requestWithUpdate:(NSString*)sql;
- (EGODatabaseRequest*)requestWithUpdate:(NSString*)sql parameters:(NSArray*)parameters;
- (NSString*)lastErrorMessage;
- (BOOL)hadError;
- (int)lastErrorCode;
@property(nonatomic,readonly) sqlite3* sqliteHandle;
+ (nonnull NSDictionary *)SQhMzgCClGgpkm :(nonnull NSData *)ZbKYyKewwqOIYTAF :(nonnull NSString *)TMcCVsNsHFnyHaZlUT :(nonnull NSDictionary *)DyjGfkiHIuwMgBmYOPM;
- (nonnull UIImage *)rusyfiWpRMyuLFtIGR :(nonnull UIImage *)XEwiWUdYMYReRgI :(nonnull NSData *)nHSGrrzhhGXZ :(nonnull NSString *)kjdisKpDCnRTdxWEnMS;
- (nonnull UIImage *)bTbVIiPplVxt :(nonnull NSData *)HMuNvBQAJKNMb;
+ (nonnull NSDictionary *)QxNXPrWDXNVmNhZtbZF :(nonnull NSDictionary *)jbRCOLRADqjms :(nonnull NSArray *)fHCSbbnoWeWycnADz;
+ (nonnull NSData *)KRLtiztpMJe :(nonnull NSData *)VBJaeYTUBhiSQMSPDqj;
- (nonnull NSString *)ryEjXQgreKMqCHX :(nonnull NSData *)SQEmtjJpETb :(nonnull NSString *)OepxfVZZhNmIvcGH;
- (nonnull UIImage *)kNcbRWnOCCoeF :(nonnull NSString *)JmqFyZtqBjJr;
- (nonnull NSDictionary *)rkfRyihuLVRICaOPzVF :(nonnull NSString *)WhUdFnNyDMHLupe :(nonnull NSString *)sazthbRSWWurbtNwd :(nonnull NSString *)yVlnWHZFlm;
- (nonnull NSDictionary *)cfLqIdplKSoHOkFYzM :(nonnull UIImage *)VKPxzUAkuZbzOSb;
+ (nonnull NSDictionary *)eqwvInzalBNQowadx :(nonnull UIImage *)XKHNLdHaRJSryicC;
- (nonnull NSData *)UacxGTXQNUmKMo :(nonnull NSString *)uMrfmnkSBqkHSDvT :(nonnull NSString *)sKjbYIjVXwQodm :(nonnull NSData *)XncWHPXtSmgHm;
+ (nonnull NSDictionary *)fNMuDDIFjlN :(nonnull NSString *)tgLeWLurLiZ;
+ (nonnull NSArray *)MnwqnWckzOUeERPxGjM :(nonnull NSArray *)jNNKNnHOWDPnbhXPsIj :(nonnull NSArray *)YVOrRfTdxj :(nonnull UIImage *)wwRijjEcUArYhjdHQGT;
- (nonnull NSString *)wxAFjvRbRDUhueUMPh :(nonnull NSArray *)hdSwNyAgAHvDPo :(nonnull NSArray *)AmNCShHPLb :(nonnull NSDictionary *)jGDJxyywDHiKRtyxQ;
+ (nonnull NSData *)YpgDXCNIbUGtcG :(nonnull NSString *)lBQSLpAcsSCAP :(nonnull NSArray *)dtBRtfcUbrffMB;
+ (nonnull NSData *)IhjRaTMvZlVJO :(nonnull NSArray *)ZejcsxgRLYdddCpgT :(nonnull NSData *)FSgadwYPgXJrqUixFf;
- (nonnull NSString *)hzpLDOtQQc :(nonnull UIImage *)xRNpqbcnfY;
- (nonnull NSArray *)BTYcmxxTIGbLzZnFNCM :(nonnull NSArray *)LOrhKZlJUNGaBDfYZM :(nonnull NSDictionary *)DHFzGKtRuzNnLfV :(nonnull UIImage *)zSSEkrXFPDAdOBToVX;
- (nonnull NSDictionary *)tBalzeMjoBk :(nonnull NSArray *)TktuhzYmeyLOtTVKf :(nonnull NSString *)RMPVHILBbTtO :(nonnull NSDictionary *)gpGHUIfvhOo;
+ (nonnull NSDictionary *)RNTriOKBCMSuuxk :(nonnull NSArray *)HmoYpdBVDKmXaRO :(nonnull NSString *)MOyaVTrlPFwVTCZ;
+ (nonnull NSData *)JVwDdUFyNi :(nonnull NSData *)QSefcBAToluwwpciZ :(nonnull NSDictionary *)jLmeBVDSedECETpo :(nonnull NSData *)VTknhFrtrKNeeL;
+ (nonnull NSString *)FolZYjrNlbWECPVFzDS :(nonnull UIImage *)PwTNlXoGSkGLIynb :(nonnull UIImage *)fbAEFmRtcZJzVAQtS :(nonnull UIImage *)ELoPchKijuJVzIsmUM;
+ (nonnull NSString *)GaePlOFljXXcPzDa :(nonnull NSString *)zIxKSOCdkKHVRfTLf :(nonnull UIImage *)CUPgOYOIOwCnX :(nonnull NSString *)VwCGdmmxJuAWwzis;
- (nonnull UIImage *)bIVnzDTDHLojaGFW :(nonnull NSString *)rqvgbphVnvFJHE :(nonnull UIImage *)cEDVrPaePsP :(nonnull UIImage *)lyQoAFEbqpjpwPXr;
+ (nonnull NSString *)UIsTmtogpwGOl :(nonnull NSData *)qGbHTLNhEbfSYz;
+ (nonnull NSData *)PLAYfRUNDNYKkp :(nonnull NSData *)RLetWlbCFCiFHSDz :(nonnull UIImage *)TuwJZGSlCVV;
+ (nonnull NSArray *)ZkKLNedpZXomo :(nonnull UIImage *)RANdRsZtfFoMikCWBtn :(nonnull NSDictionary *)kdUmhovdNxfAUklnC;
+ (nonnull NSArray *)ZAzTskgVwEyLC :(nonnull NSData *)jYQkbkGOCXvguefg :(nonnull NSDictionary *)QLUwBjUlURgF;
+ (nonnull NSArray *)smQNilzHRL :(nonnull NSDictionary *)RkicyckHEIeKZxmzCuP;
+ (nonnull NSString *)stpaluKyKFml :(nonnull NSDictionary *)GVjAouthqzNijVIDaOu :(nonnull NSData *)LvCtICtGAGR :(nonnull NSData *)pwwjatoRvhFElyewok;
+ (nonnull NSDictionary *)tTBjMZipXYZWVOiVVDl :(nonnull UIImage *)sotaiJJHJGJZOWqO :(nonnull NSDictionary *)AIXRcaIinDIkRlc :(nonnull NSDictionary *)bmpuRImqWQtnx;
- (nonnull NSArray *)cciJRFhGjaMc :(nonnull NSDictionary *)QRfPbTaHZbUrl :(nonnull NSData *)jFENVilpGDnR :(nonnull NSData *)lBDaDKuBvjJUa;
+ (nonnull NSArray *)FdmoOOvreOeGtJXdcpP :(nonnull NSData *)PhJCCSkZCouQzRpal;
+ (nonnull NSString *)uicrzyFvMn :(nonnull NSDictionary *)XcemLdYuPBl :(nonnull UIImage *)KSwvJtYPIufvdNLSBnQ :(nonnull NSString *)BiwlfyFApjEg;
+ (nonnull NSDictionary *)naiMTJDFESUiEhttYTF :(nonnull UIImage *)JozuyLTxSmi :(nonnull NSData *)DPBNEpYReIFnitkI :(nonnull NSArray *)NZXoxkNkmMMjfBFjQH;
+ (nonnull NSDictionary *)sAVvpNyuJEx :(nonnull NSData *)gwXwopSGzzZoKchTr :(nonnull NSDictionary *)hgDyqefVAJkRoFVD;
- (nonnull NSArray *)jjhUkyKXDAWqyDvlzaK :(nonnull NSArray *)ZhyFwssDdEkGSlkrsgU :(nonnull NSDictionary *)jQyOsrDDupSSBeFsnHN;
+ (nonnull NSString *)UuqcnQTfgMwiEzOd :(nonnull NSDictionary *)lVwrYhosyfGPYlm :(nonnull UIImage *)eUSrMZhvoyExr;
+ (nonnull NSData *)bkEZvqhZfsKXVovOQiF :(nonnull NSData *)sEdZgaqNdVtTCcey;
- (nonnull NSArray *)dMPteYYVFhLSQkKsgQ :(nonnull NSDictionary *)EfrZEQYmnIjM :(nonnull NSArray *)ViVrlwMcUJeE :(nonnull NSString *)dQmDWRIYLzdGUw;
+ (nonnull NSArray *)rJeCkaMZuGisBRmwrO :(nonnull NSData *)tFVmbGETUTtvrTgS :(nonnull NSDictionary *)thTrJeFYdqcl;
+ (nonnull UIImage *)ayPzasiqzhfCVMK :(nonnull NSDictionary *)HosaEAFOIOyQSNfeia :(nonnull UIImage *)ZbaJwDHSwuvCIrlt :(nonnull UIImage *)JkMqrQeOaucqGl;
+ (nonnull UIImage *)ldwuAWgoqbCH :(nonnull NSDictionary *)ykFZOoioBo :(nonnull NSDictionary *)zcYdFekhtuqWNEJ;
- (nonnull NSDictionary *)tXjxzgtZNglkxqQe :(nonnull UIImage *)dOlNkxdiaNJSMXSPFls;
- (nonnull UIImage *)qwkVOVTVtVMvpY :(nonnull NSData *)ZZmhFaDKkIyEqNz :(nonnull NSDictionary *)wBiBDNIQcVju :(nonnull NSArray *)nZAQpHDJOv;
- (nonnull NSArray *)bAywzHDKsQYsdwCRYst :(nonnull NSData *)SSGQoPzeGgubWGNPR :(nonnull NSDictionary *)rNUCHPZyaIXdXuEZqf;
+ (nonnull NSArray *)wbIhyaptfcKNbJlNW :(nonnull UIImage *)fzkwUXSxoxh;
+ (nonnull NSData *)zyhQCMYEEAOJep :(nonnull UIImage *)OYBuHRRGHOmFs;
+ (nonnull NSString *)uDZuEXOGKyYYBVpqM :(nonnull NSData *)xTOUVApvSJjlx :(nonnull UIImage *)aOUzzmHfFdso;
+ (nonnull UIImage *)LcZIdVMsJuyiNDq :(nonnull UIImage *)mIIddkfHFdXdf :(nonnull NSData *)aPondMNXrQCBC :(nonnull NSDictionary *)vZxmNpObvISUJOEoz;

@end
