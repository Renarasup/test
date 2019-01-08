#ifndef CBLAS_H
#ifdef __cplusplus
extern "C" {
#endif
#ifndef CBLAS_ENUM_DEFINED_H
#define CBLAS_ENUM_DEFINED_H
enum CBLAS_ORDER {CblasRowMajor=101, CblasColMajor=102 };
enum CBLAS_TRANSPOSE {CblasNoTrans=111, CblasTrans=112, CblasConjTrans=113,
	AtlasConj=114};
enum CBLAS_UPLO  {CblasUpper=121, CblasLower=122};
enum CBLAS_DIAG  {CblasNonUnit=131, CblasUnit=132};
enum CBLAS_SIDE  {CblasLeft=141, CblasRight=142};
#endif  
#ifndef CBLAS_ENUM_ONLY
#define CBLAS_H
#define CBLAS_INDEX int
#include <stdint.h>
#if __has_include(<Availability.h>)
	#include <Availability.h>
#else 
	#define	__OSX_AVAILABLE_STARTING( x, y ) 
	#define	__OSX_AVAILABLE_BUT_DEPRECATED( x, y, z, w ) 
#endif 
int cblas_errprn(int __ierr, int __info, char *__form, ...) 
        __OSX_AVAILABLE_STARTING(__MAC_10_2,__IPHONE_4_0);
void cblas_xerbla(int __p, char *__rout, char *__form, ...) 
        __OSX_AVAILABLE_STARTING(__MAC_10_2,__IPHONE_4_0);
float  cblas_sdsdot(const int __N, const float __alpha, const float *__X,
        const int __incX, const float *__Y, const int __incY) 
        __OSX_AVAILABLE_STARTING(__MAC_10_2,__IPHONE_4_0);
double cblas_dsdot(const int __N, const float *__X, const int __incX,
        const float *__Y, const int __incY) 
        __OSX_AVAILABLE_STARTING(__MAC_10_2,__IPHONE_4_0);
float  cblas_sdot(const int __N, const float *__X, const int __incX,
        const float *__Y, const int __incY) 
        __OSX_AVAILABLE_STARTING(__MAC_10_2,__IPHONE_4_0);
double cblas_ddot(const int __N, const double *__X, const int __incX,
        const double *__Y, const int __incY) 
        __OSX_AVAILABLE_STARTING(__MAC_10_2,__IPHONE_4_0);
void   cblas_cdotu_sub(const int __N, const void *__X, const int __incX,
        const void *__Y, const int __incY, void *__dotu) 
        __OSX_AVAILABLE_STARTING(__MAC_10_2,__IPHONE_4_0);
void   cblas_cdotc_sub(const int __N, const void *__X, const int __incX,
        const void *__Y, const int __incY, void *__dotc) 
        __OSX_AVAILABLE_STARTING(__MAC_10_2,__IPHONE_4_0);
void   cblas_zdotu_sub(const int __N, const void *__X, const int __incX,
        const void *__Y, const int __incY, void *__dotu) 
        __OSX_AVAILABLE_STARTING(__MAC_10_2,__IPHONE_4_0);
void   cblas_zdotc_sub(const int __N, const void *__X, const int __incX,
        const void *__Y, const int __incY, void *__dotc) 
        __OSX_AVAILABLE_STARTING(__MAC_10_2,__IPHONE_4_0);
float  cblas_snrm2(const int __N, const float *__X, const int __incX) 
        __OSX_AVAILABLE_STARTING(__MAC_10_2,__IPHONE_4_0);
float  cblas_sasum(const int __N, const float *__X, const int __incX) 
        __OSX_AVAILABLE_STARTING(__MAC_10_2,__IPHONE_4_0);
double cblas_dnrm2(const int __N, const double *__X, const int __incX) 
        __OSX_AVAILABLE_STARTING(__MAC_10_2,__IPHONE_4_0);
double cblas_dasum(const int __N, const double *__X, const int __incX) 
        __OSX_AVAILABLE_STARTING(__MAC_10_2,__IPHONE_4_0);
float  cblas_scnrm2(const int __N, const void *__X, const int __incX) 
        __OSX_AVAILABLE_STARTING(__MAC_10_2,__IPHONE_4_0);
float  cblas_scasum(const int __N, const void *__X, const int __incX) 
        __OSX_AVAILABLE_STARTING(__MAC_10_2,__IPHONE_4_0);
double cblas_dznrm2(const int __N, const void *__X, const int __incX) 
        __OSX_AVAILABLE_STARTING(__MAC_10_2,__IPHONE_4_0);
double cblas_dzasum(const int __N, const void *__X, const int __incX) 
        __OSX_AVAILABLE_STARTING(__MAC_10_2,__IPHONE_4_0);
CBLAS_INDEX cblas_isamax(const int __N, const float *__X, const int __incX) 
        __OSX_AVAILABLE_STARTING(__MAC_10_2,__IPHONE_4_0);
CBLAS_INDEX cblas_idamax(const int __N, const double *__X, const int __incX) 
        __OSX_AVAILABLE_STARTING(__MAC_10_2,__IPHONE_4_0);
CBLAS_INDEX cblas_icamax(const int __N, const void *__X, const int __incX) 
        __OSX_AVAILABLE_STARTING(__MAC_10_2,__IPHONE_4_0);
CBLAS_INDEX cblas_izamax(const int __N, const void *__X, const int __incX) 
        __OSX_AVAILABLE_STARTING(__MAC_10_2,__IPHONE_4_0);
void cblas_sswap(const int __N, float *__X, const int __incX, float *__Y,
        const int __incY) __OSX_AVAILABLE_STARTING(__MAC_10_2,__IPHONE_4_0);
void cblas_scopy(const int __N, const float *__X, const int __incX, float *__Y,
        const int __incY) __OSX_AVAILABLE_STARTING(__MAC_10_2,__IPHONE_4_0);
void cblas_saxpy(const int __N, const float __alpha, const float *__X,
        const int __incX, float *__Y, const int __incY) 
        __OSX_AVAILABLE_STARTING(__MAC_10_2,__IPHONE_4_0);
void catlas_saxpby(const int __N, const float __alpha, const float *__X,
        const int __incX, const float __beta, float *__Y, const int __incY) 
        __OSX_AVAILABLE_STARTING(__MAC_10_2,__IPHONE_4_0);
void catlas_sset(const int __N, const float __alpha, float *__X,
        const int __incX) __OSX_AVAILABLE_STARTING(__MAC_10_2,__IPHONE_4_0);
void cblas_dswap(const int __N, double *__X, const int __incX, double *__Y,
        const int __incY) __OSX_AVAILABLE_STARTING(__MAC_10_2,__IPHONE_4_0);
void cblas_dcopy(const int __N, const double *__X, const int __incX,
        double *__Y, const int __incY) __OSX_AVAILABLE_STARTING(__MAC_10_2,
        __IPHONE_4_0);
void cblas_daxpy(const int __N, const double __alpha, const double *__X,
        const int __incX, double *__Y, const int __incY) 
        __OSX_AVAILABLE_STARTING(__MAC_10_2,__IPHONE_4_0);
void catlas_daxpby(const int __N, const double __alpha, const double *__X,
        const int __incX, const double __beta, double *__Y, const int __incY) 
        __OSX_AVAILABLE_STARTING(__MAC_10_2,__IPHONE_4_0);
void catlas_dset(const int __N, const double __alpha, double *__X,
        const int __incX) __OSX_AVAILABLE_STARTING(__MAC_10_2,__IPHONE_4_0);
void cblas_cswap(const int __N, void *__X, const int __incX, void *__Y,
        const int __incY) __OSX_AVAILABLE_STARTING(__MAC_10_2,__IPHONE_4_0);
void cblas_ccopy(const int __N, const void *__X, const int __incX, void *__Y,
        const int __incY) __OSX_AVAILABLE_STARTING(__MAC_10_2,__IPHONE_4_0);
void cblas_caxpy(const int __N, const void *__alpha, const void *__X,
        const int __incX, void *__Y, const int __incY) 
        __OSX_AVAILABLE_STARTING(__MAC_10_2,__IPHONE_4_0);
void catlas_caxpby(const int __N, const void *__alpha, const void *__X,
        const int __incX, const void *__beta, void *__Y, const int __incY) 
        __OSX_AVAILABLE_STARTING(__MAC_10_2,__IPHONE_4_0);
void catlas_cset(const int __N, const void *__alpha, void *__X,
        const int __incX) __OSX_AVAILABLE_STARTING(__MAC_10_2,__IPHONE_4_0);
void cblas_zswap(const int __N, void *__X, const int __incX, void *__Y,
        const int __incY) __OSX_AVAILABLE_STARTING(__MAC_10_2,__IPHONE_4_0);
void cblas_zcopy(const int __N, const void *__X, const int __incX, void *__Y,
        const int __incY) __OSX_AVAILABLE_STARTING(__MAC_10_2,__IPHONE_4_0);
void cblas_zaxpy(const int __N, const void *__alpha, const void *__X,
        const int __incX, void *__Y, const int __incY) 
        __OSX_AVAILABLE_STARTING(__MAC_10_2,__IPHONE_4_0);
void catlas_zaxpby(const int __N, const void *__alpha, const void *__X,
        const int __incX, const void *__beta, void *__Y, const int __incY) 
        __OSX_AVAILABLE_STARTING(__MAC_10_2,__IPHONE_4_0);
void catlas_zset(const int __N, const void *__alpha, void *__X,
        const int __incX) __OSX_AVAILABLE_STARTING(__MAC_10_2,__IPHONE_4_0);
void cblas_srotg(float *__a, float *__b, float *__c, float *__s) 
        __OSX_AVAILABLE_STARTING(__MAC_10_2,__IPHONE_4_0);
void cblas_srotmg(float *__d1, float *__d2, float *__b1, const float __b2,
        float *__P) __OSX_AVAILABLE_STARTING(__MAC_10_2,__IPHONE_4_0);
void cblas_srot(const int __N, float *__X, const int __incX, float *__Y,
        const int __incY, const float __c, const float __s) 
        __OSX_AVAILABLE_STARTING(__MAC_10_2,__IPHONE_4_0);
void cblas_srotm(const int __N, float *__X, const int __incX, float *__Y,
        const int __incY, const float *__P) 
        __OSX_AVAILABLE_STARTING(__MAC_10_2,__IPHONE_4_0);
void cblas_drotg(double *__a, double *__b, double *__c, double *__s) 
        __OSX_AVAILABLE_STARTING(__MAC_10_2,__IPHONE_4_0);
void cblas_drotmg(double *__d1, double *__d2, double *__b1, const double __b2,
        double *__P) __OSX_AVAILABLE_STARTING(__MAC_10_2,__IPHONE_4_0);
void cblas_drot(const int __N, double *__X, const int __incX, double *__Y,
        const int __incY, const double __c, const double __s) 
        __OSX_AVAILABLE_STARTING(__MAC_10_2,__IPHONE_4_0);
void cblas_drotm(const int __N, double *__X, const int __incX, double *__Y,
        const int __incY, const double *__P) 
        __OSX_AVAILABLE_STARTING(__MAC_10_2,__IPHONE_4_0);
void cblas_sscal(const int __N, const float __alpha, float *__X,
        const int __incX) __OSX_AVAILABLE_STARTING(__MAC_10_2,__IPHONE_4_0);
void cblas_dscal(const int __N, const double __alpha, double *__X,
        const int __incX) __OSX_AVAILABLE_STARTING(__MAC_10_2,__IPHONE_4_0);
void cblas_cscal(const int __N, const void *__alpha, void *__X,
        const int __incX) __OSX_AVAILABLE_STARTING(__MAC_10_2,__IPHONE_4_0);
void cblas_zscal(const int __N, const void *__alpha, void *__X,
        const int __incX) __OSX_AVAILABLE_STARTING(__MAC_10_2,__IPHONE_4_0);
void cblas_csscal(const int __N, const float __alpha, void *__X,
        const int __incX) __OSX_AVAILABLE_STARTING(__MAC_10_2,__IPHONE_4_0);
void cblas_zdscal(const int __N, const double __alpha, void *__X,
        const int __incX) __OSX_AVAILABLE_STARTING(__MAC_10_2,__IPHONE_4_0);
void cblas_crotg(void *__a, void *__b, void *__c, void *__s) 
        __OSX_AVAILABLE_STARTING(__MAC_10_2,__IPHONE_4_0);
void cblas_zrotg(void *__a, void *__b, void *__c, void *__s) 
        __OSX_AVAILABLE_STARTING(__MAC_10_2,__IPHONE_4_0);
void cblas_csrot(const int __N, void *__X, const int __incX, void *__Y,
        const int __incY, const float __c, const float __s) 
        __OSX_AVAILABLE_STARTING(__MAC_10_2,__IPHONE_4_0);
void cblas_zdrot(const int __N, void *__X, const int __incX, void *__Y,
        const int __incY, const double __c, const double __s) 
        __OSX_AVAILABLE_STARTING(__MAC_10_2,__IPHONE_4_0);
void cblas_sgemv(const enum CBLAS_ORDER __Order,
        const enum CBLAS_TRANSPOSE __TransA, const int __M, const int __N,
        const float __alpha, const float *__A, const int __lda,
        const float *__X, const int __incX, const float __beta, float *__Y,
        const int __incY) __OSX_AVAILABLE_STARTING(__MAC_10_2,__IPHONE_4_0);
void cblas_sgbmv(const enum CBLAS_ORDER __Order,
        const enum CBLAS_TRANSPOSE __TransA, const int __M, const int __N,
        const int __KL, const int __KU, const float __alpha, const float *__A,
        const int __lda, const float *__X, const int __incX,
        const float __beta, float *__Y, const int __incY) 
        __OSX_AVAILABLE_STARTING(__MAC_10_2,__IPHONE_4_0);
void cblas_strmv(const enum CBLAS_ORDER __Order, const enum CBLAS_UPLO __Uplo,
        const enum CBLAS_TRANSPOSE __TransA, const enum CBLAS_DIAG __Diag,
        const int __N, const float *__A, const int __lda, float *__X,
        const int __incX) __OSX_AVAILABLE_STARTING(__MAC_10_2,__IPHONE_4_0);
void cblas_stbmv(const enum CBLAS_ORDER __Order, const enum CBLAS_UPLO __Uplo,
        const enum CBLAS_TRANSPOSE __TransA, const enum CBLAS_DIAG __Diag,
        const int __N, const int __K, const float *__A, const int __lda,
        float *__X, const int __incX) __OSX_AVAILABLE_STARTING(__MAC_10_2,
        __IPHONE_4_0);
void cblas_stpmv(const enum CBLAS_ORDER __Order, const enum CBLAS_UPLO __Uplo,
        const enum CBLAS_TRANSPOSE __TransA, const enum CBLAS_DIAG __Diag,
        const int __N, const float *__Ap, float *__X, const int __incX) 
        __OSX_AVAILABLE_STARTING(__MAC_10_2,__IPHONE_4_0);
void cblas_strsv(const enum CBLAS_ORDER __Order, const enum CBLAS_UPLO __Uplo,
        const enum CBLAS_TRANSPOSE __TransA, const enum CBLAS_DIAG __Diag,
        const int __N, const float *__A, const int __lda, float *__X,
        const int __incX) __OSX_AVAILABLE_STARTING(__MAC_10_2,__IPHONE_4_0);
void cblas_stbsv(const enum CBLAS_ORDER __Order, const enum CBLAS_UPLO __Uplo,
        const enum CBLAS_TRANSPOSE __TransA, const enum CBLAS_DIAG __Diag,
        const int __N, const int __K, const float *__A, const int __lda,
        float *__X, const int __incX) __OSX_AVAILABLE_STARTING(__MAC_10_2,
        __IPHONE_4_0);
void cblas_stpsv(const enum CBLAS_ORDER __Order, const enum CBLAS_UPLO __Uplo,
        const enum CBLAS_TRANSPOSE __TransA, const enum CBLAS_DIAG __Diag,
        const int __N, const float *__Ap, float *__X, const int __incX) 
        __OSX_AVAILABLE_STARTING(__MAC_10_2,__IPHONE_4_0);
void cblas_dgemv(const enum CBLAS_ORDER __Order,
        const enum CBLAS_TRANSPOSE __TransA, const int __M, const int __N,
        const double __alpha, const double *__A, const int __lda,
        const double *__X, const int __incX, const double __beta, double *__Y,
        const int __incY) __OSX_AVAILABLE_STARTING(__MAC_10_2,__IPHONE_4_0);
void cblas_dgbmv(const enum CBLAS_ORDER __Order,
        const enum CBLAS_TRANSPOSE __TransA, const int __M, const int __N,
        const int __KL, const int __KU, const double __alpha,
        const double *__A, const int __lda, const double *__X,
        const int __incX, const double __beta, double *__Y, const int __incY) 
        __OSX_AVAILABLE_STARTING(__MAC_10_2,__IPHONE_4_0);
void cblas_dtrmv(const enum CBLAS_ORDER __Order, const enum CBLAS_UPLO __Uplo,
        const enum CBLAS_TRANSPOSE __TransA, const enum CBLAS_DIAG __Diag,
        const int __N, const double *__A, const int __lda, double *__X,
        const int __incX) __OSX_AVAILABLE_STARTING(__MAC_10_2,__IPHONE_4_0);
void cblas_dtbmv(const enum CBLAS_ORDER __Order, const enum CBLAS_UPLO __Uplo,
        const enum CBLAS_TRANSPOSE __TransA, const enum CBLAS_DIAG __Diag,
        const int __N, const int __K, const double *__A, const int __lda,
        double *__X, const int __incX) __OSX_AVAILABLE_STARTING(__MAC_10_2,
        __IPHONE_4_0);
void cblas_dtpmv(const enum CBLAS_ORDER __Order, const enum CBLAS_UPLO __Uplo,
        const enum CBLAS_TRANSPOSE __TransA, const enum CBLAS_DIAG __Diag,
        const int __N, const double *__Ap, double *__X, const int __incX) 
        __OSX_AVAILABLE_STARTING(__MAC_10_2,__IPHONE_4_0);
void cblas_dtrsv(const enum CBLAS_ORDER __Order, const enum CBLAS_UPLO __Uplo,
        const enum CBLAS_TRANSPOSE __TransA, const enum CBLAS_DIAG __Diag,
        const int __N, const double *__A, const int __lda, double *__X,
        const int __incX) __OSX_AVAILABLE_STARTING(__MAC_10_2,__IPHONE_4_0);
void cblas_dtbsv(const enum CBLAS_ORDER __Order, const enum CBLAS_UPLO __Uplo,
        const enum CBLAS_TRANSPOSE __TransA, const enum CBLAS_DIAG __Diag,
        const int __N, const int __K, const double *__A, const int __lda,
        double *__X, const int __incX) __OSX_AVAILABLE_STARTING(__MAC_10_2,
        __IPHONE_4_0);
void cblas_dtpsv(const enum CBLAS_ORDER __Order, const enum CBLAS_UPLO __Uplo,
        const enum CBLAS_TRANSPOSE __TransA, const enum CBLAS_DIAG __Diag,
        const int __N, const double *__Ap, double *__X, const int __incX) 
        __OSX_AVAILABLE_STARTING(__MAC_10_2,__IPHONE_4_0);
void cblas_cgemv(const enum CBLAS_ORDER __Order,
        const enum CBLAS_TRANSPOSE __TransA, const int __M, const int __N,
        const void *__alpha, const void *__A, const int __lda, const void *__X,
        const int __incX, const void *__beta, void *__Y, const int __incY) 
        __OSX_AVAILABLE_STARTING(__MAC_10_2,__IPHONE_4_0);
void cblas_cgbmv(const enum CBLAS_ORDER __Order,
        const enum CBLAS_TRANSPOSE __TransA, const int __M, const int __N,
        const int __KL, const int __KU, const void *__alpha, const void *__A,
        const int __lda, const void *__X, const int __incX, const void *__beta,
        void *__Y, const int __incY) __OSX_AVAILABLE_STARTING(__MAC_10_2,
        __IPHONE_4_0);
void cblas_ctrmv(const enum CBLAS_ORDER __Order, const enum CBLAS_UPLO __Uplo,
        const enum CBLAS_TRANSPOSE __TransA, const enum CBLAS_DIAG __Diag,
        const int __N, const void *__A, const int __lda, void *__X,
        const int __incX) __OSX_AVAILABLE_STARTING(__MAC_10_2,__IPHONE_4_0);
void cblas_ctbmv(const enum CBLAS_ORDER __Order, const enum CBLAS_UPLO __Uplo,
        const enum CBLAS_TRANSPOSE __TransA, const enum CBLAS_DIAG __Diag,
        const int __N, const int __K, const void *__A, const int __lda,
        void *__X, const int __incX) __OSX_AVAILABLE_STARTING(__MAC_10_2,
        __IPHONE_4_0);
void cblas_ctpmv(const enum CBLAS_ORDER __Order, const enum CBLAS_UPLO __Uplo,
        const enum CBLAS_TRANSPOSE __TransA, const enum CBLAS_DIAG __Diag,
        const int __N, const void *__Ap, void *__X, const int __incX) 
        __OSX_AVAILABLE_STARTING(__MAC_10_2,__IPHONE_4_0);
void cblas_ctrsv(const enum CBLAS_ORDER __Order, const enum CBLAS_UPLO __Uplo,
        const enum CBLAS_TRANSPOSE __TransA, const enum CBLAS_DIAG __Diag,
        const int __N, const void *__A, const int __lda, void *__X,
        const int __incX) __OSX_AVAILABLE_STARTING(__MAC_10_2,__IPHONE_4_0);
void cblas_ctbsv(const enum CBLAS_ORDER __Order, const enum CBLAS_UPLO __Uplo,
        const enum CBLAS_TRANSPOSE __TransA, const enum CBLAS_DIAG __Diag,
        const int __N, const int __K, const void *__A, const int __lda,
        void *__X, const int __incX) __OSX_AVAILABLE_STARTING(__MAC_10_2,
        __IPHONE_4_0);
void cblas_ctpsv(const enum CBLAS_ORDER __Order, const enum CBLAS_UPLO __Uplo,
        const enum CBLAS_TRANSPOSE __TransA, const enum CBLAS_DIAG __Diag,
        const int __N, const void *__Ap, void *__X, const int __incX) 
        __OSX_AVAILABLE_STARTING(__MAC_10_2,__IPHONE_4_0);
void cblas_zgemv(const enum CBLAS_ORDER __Order,
        const enum CBLAS_TRANSPOSE __TransA, const int __M, const int __N,
        const void *__alpha, const void *__A, const int __lda, const void *__X,
        const int __incX, const void *__beta, void *__Y, const int __incY) 
        __OSX_AVAILABLE_STARTING(__MAC_10_2,__IPHONE_4_0);
void cblas_zgbmv(const enum CBLAS_ORDER __Order,
        const enum CBLAS_TRANSPOSE __TransA, const int __M, const int __N,
        const int __KL, const int __KU, const void *__alpha, const void *__A,
        const int __lda, const void *__X, const int __incX, const void *__beta,
        void *__Y, const int __incY) __OSX_AVAILABLE_STARTING(__MAC_10_2,
        __IPHONE_4_0);
void cblas_ztrmv(const enum CBLAS_ORDER __Order, const enum CBLAS_UPLO __Uplo,
        const enum CBLAS_TRANSPOSE __TransA, const enum CBLAS_DIAG __Diag,
        const int __N, const void *__A, const int __lda, void *__X,
        const int __incX) __OSX_AVAILABLE_STARTING(__MAC_10_2,__IPHONE_4_0);
void cblas_ztbmv(const enum CBLAS_ORDER __Order, const enum CBLAS_UPLO __Uplo,
        const enum CBLAS_TRANSPOSE __TransA, const enum CBLAS_DIAG __Diag,
        const int __N, const int __K, const void *__A, const int __lda,
        void *__X, const int __incX) __OSX_AVAILABLE_STARTING(__MAC_10_2,
        __IPHONE_4_0);
void cblas_ztpmv(const enum CBLAS_ORDER __Order, const enum CBLAS_UPLO __Uplo,
        const enum CBLAS_TRANSPOSE __TransA, const enum CBLAS_DIAG __Diag,
        const int __N, const void *__Ap, void *__X, const int __incX) 
        __OSX_AVAILABLE_STARTING(__MAC_10_2,__IPHONE_4_0);
void cblas_ztrsv(const enum CBLAS_ORDER __Order, const enum CBLAS_UPLO __Uplo,
        const enum CBLAS_TRANSPOSE __TransA, const enum CBLAS_DIAG __Diag,
        const int __N, const void *__A, const int __lda, void *__X,
        const int __incX) __OSX_AVAILABLE_STARTING(__MAC_10_2,__IPHONE_4_0);
void cblas_ztbsv(const enum CBLAS_ORDER __Order, const enum CBLAS_UPLO __Uplo,
        const enum CBLAS_TRANSPOSE __TransA, const enum CBLAS_DIAG __Diag,
        const int __N, const int __K, const void *__A, const int __lda,
        void *__X, const int __incX) __OSX_AVAILABLE_STARTING(__MAC_10_2,
        __IPHONE_4_0);
void cblas_ztpsv(const enum CBLAS_ORDER __Order, const enum CBLAS_UPLO __Uplo,
        const enum CBLAS_TRANSPOSE __TransA, const enum CBLAS_DIAG __Diag,
        const int __N, const void *__Ap, void *__X, const int __incX) 
        __OSX_AVAILABLE_STARTING(__MAC_10_2,__IPHONE_4_0);
void cblas_ssymv(const enum CBLAS_ORDER __Order, const enum CBLAS_UPLO __Uplo,
        const int __N, const float __alpha, const float *__A, const int __lda,
        const float *__X, const int __incX, const float __beta, float *__Y,
        const int __incY) __OSX_AVAILABLE_STARTING(__MAC_10_2,__IPHONE_4_0);
void cblas_ssbmv(const enum CBLAS_ORDER __Order, const enum CBLAS_UPLO __Uplo,
        const int __N, const int __K, const float __alpha, const float *__A,
        const int __lda, const float *__X, const int __incX,
        const float __beta, float *__Y, const int __incY) 
        __OSX_AVAILABLE_STARTING(__MAC_10_2,__IPHONE_4_0);
void cblas_sspmv(const enum CBLAS_ORDER __Order, const enum CBLAS_UPLO __Uplo,
        const int __N, const float __alpha, const float *__Ap,
        const float *__X, const int __incX, const float __beta, float *__Y,
        const int __incY) __OSX_AVAILABLE_STARTING(__MAC_10_2,__IPHONE_4_0);
void cblas_sger(const enum CBLAS_ORDER __Order, const int __M, const int __N,
        const float __alpha, const float *__X, const int __incX,
        const float *__Y, const int __incY, float *__A, const int __lda) 
        __OSX_AVAILABLE_STARTING(__MAC_10_2,__IPHONE_4_0);
void cblas_ssyr(const enum CBLAS_ORDER __Order, const enum CBLAS_UPLO __Uplo,
        const int __N, const float __alpha, const float *__X, const int __incX,
        float *__A, const int __lda) __OSX_AVAILABLE_STARTING(__MAC_10_2,
        __IPHONE_4_0);
void cblas_sspr(const enum CBLAS_ORDER __Order, const enum CBLAS_UPLO __Uplo,
        const int __N, const float __alpha, const float *__X, const int __incX,
        float *__Ap) __OSX_AVAILABLE_STARTING(__MAC_10_2,__IPHONE_4_0);
void cblas_ssyr2(const enum CBLAS_ORDER __Order, const enum CBLAS_UPLO __Uplo,
        const int __N, const float __alpha, const float *__X, const int __incX,
        const float *__Y, const int __incY, float *__A, const int __lda) 
        __OSX_AVAILABLE_STARTING(__MAC_10_2,__IPHONE_4_0);
void cblas_sspr2(const enum CBLAS_ORDER __Order, const enum CBLAS_UPLO __Uplo,
        const int __N, const float __alpha, const float *__X, const int __incX,
        const float *__Y, const int __incY, float *__A) 
        __OSX_AVAILABLE_STARTING(__MAC_10_2,__IPHONE_4_0);
void cblas_dsymv(const enum CBLAS_ORDER __Order, const enum CBLAS_UPLO __Uplo,
        const int __N, const double __alpha, const double *__A,
        const int __lda, const double *__X, const int __incX,
        const double __beta, double *__Y, const int __incY) 
        __OSX_AVAILABLE_STARTING(__MAC_10_2,__IPHONE_4_0);
void cblas_dsbmv(const enum CBLAS_ORDER __Order, const enum CBLAS_UPLO __Uplo,
        const int __N, const int __K, const double __alpha, const double *__A,
        const int __lda, const double *__X, const int __incX,
        const double __beta, double *__Y, const int __incY) 
        __OSX_AVAILABLE_STARTING(__MAC_10_2,__IPHONE_4_0);
void cblas_dspmv(const enum CBLAS_ORDER __Order, const enum CBLAS_UPLO __Uplo,
        const int __N, const double __alpha, const double *__Ap,
        const double *__X, const int __incX, const double __beta, double *__Y,
        const int __incY) __OSX_AVAILABLE_STARTING(__MAC_10_2,__IPHONE_4_0);
void cblas_dger(const enum CBLAS_ORDER __Order, const int __M, const int __N,
        const double __alpha, const double *__X, const int __incX,
        const double *__Y, const int __incY, double *__A, const int __lda) 
        __OSX_AVAILABLE_STARTING(__MAC_10_2,__IPHONE_4_0);
void cblas_dsyr(const enum CBLAS_ORDER __Order, const enum CBLAS_UPLO __Uplo,
        const int __N, const double __alpha, const double *__X,
        const int __incX, double *__A, const int __lda) 
        __OSX_AVAILABLE_STARTING(__MAC_10_2,__IPHONE_4_0);
void cblas_dspr(const enum CBLAS_ORDER __Order, const enum CBLAS_UPLO __Uplo,
        const int __N, const double __alpha, const double *__X,
        const int __incX, double *__Ap) __OSX_AVAILABLE_STARTING(__MAC_10_2,
        __IPHONE_4_0);
void cblas_dsyr2(const enum CBLAS_ORDER __Order, const enum CBLAS_UPLO __Uplo,
        const int __N, const double __alpha, const double *__X,
        const int __incX, const double *__Y, const int __incY, double *__A,
        const int __lda) __OSX_AVAILABLE_STARTING(__MAC_10_2,__IPHONE_4_0);
void cblas_dspr2(const enum CBLAS_ORDER __Order, const enum CBLAS_UPLO __Uplo,
        const int __N, const double __alpha, const double *__X,
        const int __incX, const double *__Y, const int __incY, double *__A) 
        __OSX_AVAILABLE_STARTING(__MAC_10_2,__IPHONE_4_0);
void cblas_chemv(const enum CBLAS_ORDER __Order, const enum CBLAS_UPLO __Uplo,
        const int __N, const void *__alpha, const void *__A, const int __lda,
        const void *__X, const int __incX, const void *__beta, void *__Y,
        const int __incY) __OSX_AVAILABLE_STARTING(__MAC_10_2,__IPHONE_4_0);
void cblas_chbmv(const enum CBLAS_ORDER __Order, const enum CBLAS_UPLO __Uplo,
        const int __N, const int __K, const void *__alpha, const void *__A,
        const int __lda, const void *__X, const int __incX, const void *__beta,
        void *__Y, const int __incY) __OSX_AVAILABLE_STARTING(__MAC_10_2,
        __IPHONE_4_0);
void cblas_chpmv(const enum CBLAS_ORDER __Order, const enum CBLAS_UPLO __Uplo,
        const int __N, const void *__alpha, const void *__Ap, const void *__X,
        const int __incX, const void *__beta, void *__Y, const int __incY) 
        __OSX_AVAILABLE_STARTING(__MAC_10_2,__IPHONE_4_0);
void cblas_cgeru(const enum CBLAS_ORDER __Order, const int __M, const int __N,
        const void *__alpha, const void *__X, const int __incX,
        const void *__Y, const int __incY, void *__A, const int __lda) 
        __OSX_AVAILABLE_STARTING(__MAC_10_2,__IPHONE_4_0);
void cblas_cgerc(const enum CBLAS_ORDER __Order, const int __M, const int __N,
        const void *__alpha, const void *__X, const int __incX,
        const void *__Y, const int __incY, void *__A, const int __lda) 
        __OSX_AVAILABLE_STARTING(__MAC_10_2,__IPHONE_4_0);
void cblas_cher(const enum CBLAS_ORDER __Order, const enum CBLAS_UPLO __Uplo,
        const int __N, const float __alpha, const void *__X, const int __incX,
        void *__A, const int __lda) __OSX_AVAILABLE_STARTING(__MAC_10_2,
        __IPHONE_4_0);
void cblas_chpr(const enum CBLAS_ORDER __Order, const enum CBLAS_UPLO __Uplo,
        const int __N, const float __alpha, const void *__X, const int __incX,
        void *__A) __OSX_AVAILABLE_STARTING(__MAC_10_2,__IPHONE_4_0);
void cblas_cher2(const enum CBLAS_ORDER __Order, const enum CBLAS_UPLO __Uplo,
        const int __N, const void *__alpha, const void *__X, const int __incX,
        const void *__Y, const int __incY, void *__A, const int __lda) 
        __OSX_AVAILABLE_STARTING(__MAC_10_2,__IPHONE_4_0);
void cblas_chpr2(const enum CBLAS_ORDER __Order, const enum CBLAS_UPLO __Uplo,
        const int __N, const void *__alpha, const void *__X, const int __incX,
        const void *__Y, const int __incY, void *__Ap) 
        __OSX_AVAILABLE_STARTING(__MAC_10_2,__IPHONE_4_0);
void cblas_zhemv(const enum CBLAS_ORDER __Order, const enum CBLAS_UPLO __Uplo,
        const int __N, const void *__alpha, const void *__A, const int __lda,
        const void *__X, const int __incX, const void *__beta, void *__Y,
        const int __incY) __OSX_AVAILABLE_STARTING(__MAC_10_2,__IPHONE_4_0);
void cblas_zhbmv(const enum CBLAS_ORDER __Order, const enum CBLAS_UPLO __Uplo,
        const int __N, const int __K, const void *__alpha, const void *__A,
        const int __lda, const void *__X, const int __incX, const void *__beta,
        void *__Y, const int __incY) __OSX_AVAILABLE_STARTING(__MAC_10_2,
        __IPHONE_4_0);
void cblas_zhpmv(const enum CBLAS_ORDER __Order, const enum CBLAS_UPLO __Uplo,
        const int __N, const void *__alpha, const void *__Ap, const void *__X,
        const int __incX, const void *__beta, void *__Y, const int __incY) 
        __OSX_AVAILABLE_STARTING(__MAC_10_2,__IPHONE_4_0);
void cblas_zgeru(const enum CBLAS_ORDER __Order, const int __M, const int __N,
        const void *__alpha, const void *__X, const int __incX,
        const void *__Y, const int __incY, void *__A, const int __lda) 
        __OSX_AVAILABLE_STARTING(__MAC_10_2,__IPHONE_4_0);
void cblas_zgerc(const enum CBLAS_ORDER __Order, const int __M, const int __N,
        const void *__alpha, const void *__X, const int __incX,
        const void *__Y, const int __incY, void *__A, const int __lda) 
        __OSX_AVAILABLE_STARTING(__MAC_10_2,__IPHONE_4_0);
void cblas_zher(const enum CBLAS_ORDER __Order, const enum CBLAS_UPLO __Uplo,
        const int __N, const double __alpha, const void *__X, const int __incX,
        void *__A, const int __lda) __OSX_AVAILABLE_STARTING(__MAC_10_2,
        __IPHONE_4_0);
void cblas_zhpr(const enum CBLAS_ORDER __Order, const enum CBLAS_UPLO __Uplo,
        const int __N, const double __alpha, const void *__X, const int __incX,
        void *__A) __OSX_AVAILABLE_STARTING(__MAC_10_2,__IPHONE_4_0);
void cblas_zher2(const enum CBLAS_ORDER __Order, const enum CBLAS_UPLO __Uplo,
        const int __N, const void *__alpha, const void *__X, const int __incX,
        const void *__Y, const int __incY, void *__A, const int __lda) 
        __OSX_AVAILABLE_STARTING(__MAC_10_2,__IPHONE_4_0);
void cblas_zhpr2(const enum CBLAS_ORDER __Order, const enum CBLAS_UPLO __Uplo,
        const int __N, const void *__alpha, const void *__X, const int __incX,
        const void *__Y, const int __incY, void *__Ap) 
        __OSX_AVAILABLE_STARTING(__MAC_10_2,__IPHONE_4_0);
void cblas_sgemm(const enum CBLAS_ORDER __Order,
        const enum CBLAS_TRANSPOSE __TransA,
        const enum CBLAS_TRANSPOSE __TransB, const int __M, const int __N,
        const int __K, const float __alpha, const float *__A, const int __lda,
        const float *__B, const int __ldb, const float __beta, float *__C,
        const int __ldc) __OSX_AVAILABLE_STARTING(__MAC_10_2,__IPHONE_4_0);
void cblas_ssymm(const enum CBLAS_ORDER __Order, const enum CBLAS_SIDE __Side,
        const enum CBLAS_UPLO __Uplo, const int __M, const int __N,
        const float __alpha, const float *__A, const int __lda,
        const float *__B, const int __ldb, const float __beta, float *__C,
        const int __ldc) __OSX_AVAILABLE_STARTING(__MAC_10_2,__IPHONE_4_0);
void cblas_ssyrk(const enum CBLAS_ORDER __Order, const enum CBLAS_UPLO __Uplo,
        const enum CBLAS_TRANSPOSE __Trans, const int __N, const int __K,
        const float __alpha, const float *__A, const int __lda,
        const float __beta, float *__C, const int __ldc) 
        __OSX_AVAILABLE_STARTING(__MAC_10_2,__IPHONE_4_0);
void cblas_ssyr2k(const enum CBLAS_ORDER __Order, const enum CBLAS_UPLO __Uplo,
        const enum CBLAS_TRANSPOSE __Trans, const int __N, const int __K,
        const float __alpha, const float *__A, const int __lda,
        const float *__B, const int __ldb, const float __beta, float *__C,
        const int __ldc) __OSX_AVAILABLE_STARTING(__MAC_10_2,__IPHONE_4_0);
void cblas_strmm(const enum CBLAS_ORDER __Order, const enum CBLAS_SIDE __Side,
        const enum CBLAS_UPLO __Uplo, const enum CBLAS_TRANSPOSE __TransA,
        const enum CBLAS_DIAG __Diag, const int __M, const int __N,
        const float __alpha, const float *__A, const int __lda, float *__B,
        const int __ldb) __OSX_AVAILABLE_STARTING(__MAC_10_2,__IPHONE_4_0);
void cblas_strsm(const enum CBLAS_ORDER __Order, const enum CBLAS_SIDE __Side,
        const enum CBLAS_UPLO __Uplo, const enum CBLAS_TRANSPOSE __TransA,
        const enum CBLAS_DIAG __Diag, const int __M, const int __N,
        const float __alpha, const float *__A, const int __lda, float *__B,
        const int __ldb) __OSX_AVAILABLE_STARTING(__MAC_10_2,__IPHONE_4_0);
void cblas_dgemm(const enum CBLAS_ORDER __Order,
        const enum CBLAS_TRANSPOSE __TransA,
        const enum CBLAS_TRANSPOSE __TransB, const int __M, const int __N,
        const int __K, const double __alpha, const double *__A,
        const int __lda, const double *__B, const int __ldb,
        const double __beta, double *__C, const int __ldc) 
        __OSX_AVAILABLE_STARTING(__MAC_10_2,__IPHONE_4_0);
void cblas_dsymm(const enum CBLAS_ORDER __Order, const enum CBLAS_SIDE __Side,
        const enum CBLAS_UPLO __Uplo, const int __M, const int __N,
        const double __alpha, const double *__A, const int __lda,
        const double *__B, const int __ldb, const double __beta, double *__C,
        const int __ldc) __OSX_AVAILABLE_STARTING(__MAC_10_2,__IPHONE_4_0);
void cblas_dsyrk(const enum CBLAS_ORDER __Order, const enum CBLAS_UPLO __Uplo,
        const enum CBLAS_TRANSPOSE __Trans, const int __N, const int __K,
        const double __alpha, const double *__A, const int __lda,
        const double __beta, double *__C, const int __ldc) 
        __OSX_AVAILABLE_STARTING(__MAC_10_2,__IPHONE_4_0);
void cblas_dsyr2k(const enum CBLAS_ORDER __Order, const enum CBLAS_UPLO __Uplo,
        const enum CBLAS_TRANSPOSE __Trans, const int __N, const int __K,
        const double __alpha, const double *__A, const int __lda,
        const double *__B, const int __ldb, const double __beta, double *__C,
        const int __ldc) __OSX_AVAILABLE_STARTING(__MAC_10_2,__IPHONE_4_0);
void cblas_dtrmm(const enum CBLAS_ORDER __Order, const enum CBLAS_SIDE __Side,
        const enum CBLAS_UPLO __Uplo, const enum CBLAS_TRANSPOSE __TransA,
        const enum CBLAS_DIAG __Diag, const int __M, const int __N,
        const double __alpha, const double *__A, const int __lda, double *__B,
        const int __ldb) __OSX_AVAILABLE_STARTING(__MAC_10_2,__IPHONE_4_0);
void cblas_dtrsm(const enum CBLAS_ORDER __Order, const enum CBLAS_SIDE __Side,
        const enum CBLAS_UPLO __Uplo, const enum CBLAS_TRANSPOSE __TransA,
        const enum CBLAS_DIAG __Diag, const int __M, const int __N,
        const double __alpha, const double *__A, const int __lda, double *__B,
        const int __ldb) __OSX_AVAILABLE_STARTING(__MAC_10_2,__IPHONE_4_0);
void cblas_cgemm(const enum CBLAS_ORDER __Order,
        const enum CBLAS_TRANSPOSE __TransA,
        const enum CBLAS_TRANSPOSE __TransB, const int __M, const int __N,
        const int __K, const void *__alpha, const void *__A, const int __lda,
        const void *__B, const int __ldb, const void *__beta, void *__C,
        const int __ldc) __OSX_AVAILABLE_STARTING(__MAC_10_2,__IPHONE_4_0);
void cblas_csymm(const enum CBLAS_ORDER __Order, const enum CBLAS_SIDE __Side,
        const enum CBLAS_UPLO __Uplo, const int __M, const int __N,
        const void *__alpha, const void *__A, const int __lda, const void *__B,
        const int __ldb, const void *__beta, void *__C, const int __ldc) 
        __OSX_AVAILABLE_STARTING(__MAC_10_2,__IPHONE_4_0);
void cblas_csyrk(const enum CBLAS_ORDER __Order, const enum CBLAS_UPLO __Uplo,
        const enum CBLAS_TRANSPOSE __Trans, const int __N, const int __K,
        const void *__alpha, const void *__A, const int __lda,
        const void *__beta, void *__C, const int __ldc) 
        __OSX_AVAILABLE_STARTING(__MAC_10_2,__IPHONE_4_0);
void cblas_csyr2k(const enum CBLAS_ORDER __Order, const enum CBLAS_UPLO __Uplo,
        const enum CBLAS_TRANSPOSE __Trans, const int __N, const int __K,
        const void *__alpha, const void *__A, const int __lda, const void *__B,
        const int __ldb, const void *__beta, void *__C, const int __ldc) 
        __OSX_AVAILABLE_STARTING(__MAC_10_2,__IPHONE_4_0);
void cblas_ctrmm(const enum CBLAS_ORDER __Order, const enum CBLAS_SIDE __Side,
        const enum CBLAS_UPLO __Uplo, const enum CBLAS_TRANSPOSE __TransA,
        const enum CBLAS_DIAG __Diag, const int __M, const int __N,
        const void *__alpha, const void *__A, const int __lda, void *__B,
        const int __ldb) __OSX_AVAILABLE_STARTING(__MAC_10_2,__IPHONE_4_0);
void cblas_ctrsm(const enum CBLAS_ORDER __Order, const enum CBLAS_SIDE __Side,
        const enum CBLAS_UPLO __Uplo, const enum CBLAS_TRANSPOSE __TransA,
        const enum CBLAS_DIAG __Diag, const int __M, const int __N,
        const void *__alpha, const void *__A, const int __lda, void *__B,
        const int __ldb) __OSX_AVAILABLE_STARTING(__MAC_10_2,__IPHONE_4_0);
void cblas_zgemm(const enum CBLAS_ORDER __Order,
        const enum CBLAS_TRANSPOSE __TransA,
        const enum CBLAS_TRANSPOSE __TransB, const int __M, const int __N,
        const int __K, const void *__alpha, const void *__A, const int __lda,
        const void *__B, const int __ldb, const void *__beta, void *__C,
        const int __ldc) __OSX_AVAILABLE_STARTING(__MAC_10_2,__IPHONE_4_0);
void cblas_zsymm(const enum CBLAS_ORDER __Order, const enum CBLAS_SIDE __Side,
        const enum CBLAS_UPLO __Uplo, const int __M, const int __N,
        const void *__alpha, const void *__A, const int __lda, const void *__B,
        const int __ldb, const void *__beta, void *__C, const int __ldc) 
        __OSX_AVAILABLE_STARTING(__MAC_10_2,__IPHONE_4_0);
void cblas_zsyrk(const enum CBLAS_ORDER __Order, const enum CBLAS_UPLO __Uplo,
        const enum CBLAS_TRANSPOSE __Trans, const int __N, const int __K,
        const void *__alpha, const void *__A, const int __lda,
        const void *__beta, void *__C, const int __ldc) 
        __OSX_AVAILABLE_STARTING(__MAC_10_2,__IPHONE_4_0);
void cblas_zsyr2k(const enum CBLAS_ORDER __Order, const enum CBLAS_UPLO __Uplo,
        const enum CBLAS_TRANSPOSE __Trans, const int __N, const int __K,
        const void *__alpha, const void *__A, const int __lda, const void *__B,
        const int __ldb, const void *__beta, void *__C, const int __ldc) 
        __OSX_AVAILABLE_STARTING(__MAC_10_2,__IPHONE_4_0);
void cblas_ztrmm(const enum CBLAS_ORDER __Order, const enum CBLAS_SIDE __Side,
        const enum CBLAS_UPLO __Uplo, const enum CBLAS_TRANSPOSE __TransA,
        const enum CBLAS_DIAG __Diag, const int __M, const int __N,
        const void *__alpha, const void *__A, const int __lda, void *__B,
        const int __ldb) __OSX_AVAILABLE_STARTING(__MAC_10_2,__IPHONE_4_0);
void cblas_ztrsm(const enum CBLAS_ORDER __Order, const enum CBLAS_SIDE __Side,
        const enum CBLAS_UPLO __Uplo, const enum CBLAS_TRANSPOSE __TransA,
        const enum CBLAS_DIAG __Diag, const int __M, const int __N,
        const void *__alpha, const void *__A, const int __lda, void *__B,
        const int __ldb) __OSX_AVAILABLE_STARTING(__MAC_10_2,__IPHONE_4_0);
void cblas_chemm(const enum CBLAS_ORDER __Order, const enum CBLAS_SIDE __Side,
        const enum CBLAS_UPLO __Uplo, const int __M, const int __N,
        const void *__alpha, const void *__A, const int __lda, const void *__B,
        const int __ldb, const void *__beta, void *__C, const int __ldc) 
        __OSX_AVAILABLE_STARTING(__MAC_10_2,__IPHONE_4_0);
void cblas_cherk(const enum CBLAS_ORDER __Order, const enum CBLAS_UPLO __Uplo,
        const enum CBLAS_TRANSPOSE __Trans, const int __N, const int __K,
        const float __alpha, const void *__A, const int __lda,
        const float __beta, void *__C, const int __ldc) 
        __OSX_AVAILABLE_STARTING(__MAC_10_2,__IPHONE_4_0);
void cblas_cher2k(const enum CBLAS_ORDER __Order, const enum CBLAS_UPLO __Uplo,
        const enum CBLAS_TRANSPOSE __Trans, const int __N, const int __K,
        const void *__alpha, const void *__A, const int __lda, const void *__B,
        const int __ldb, const float __beta, void *__C, const int __ldc) 
        __OSX_AVAILABLE_STARTING(__MAC_10_2,__IPHONE_4_0);
void cblas_zhemm(const enum CBLAS_ORDER __Order, const enum CBLAS_SIDE __Side,
        const enum CBLAS_UPLO __Uplo, const int __M, const int __N,
        const void *__alpha, const void *__A, const int __lda, const void *__B,
        const int __ldb, const void *__beta, void *__C, const int __ldc) 
        __OSX_AVAILABLE_STARTING(__MAC_10_2,__IPHONE_4_0);
void cblas_zherk(const enum CBLAS_ORDER __Order, const enum CBLAS_UPLO __Uplo,
        const enum CBLAS_TRANSPOSE __Trans, const int __N, const int __K,
        const double __alpha, const void *__A, const int __lda,
        const double __beta, void *__C, const int __ldc) 
        __OSX_AVAILABLE_STARTING(__MAC_10_2,__IPHONE_4_0);
void cblas_zher2k(const enum CBLAS_ORDER __Order, const enum CBLAS_UPLO __Uplo,
        const enum CBLAS_TRANSPOSE __Trans, const int __N, const int __K,
        const void *__alpha, const void *__A, const int __lda, const void *__B,
        const int __ldb, const double __beta, void *__C, const int __ldc) 
        __OSX_AVAILABLE_STARTING(__MAC_10_2,__IPHONE_4_0);
extern void appleblas_sgeadd(const enum CBLAS_ORDER __order,
        const enum CBLAS_TRANSPOSE __transA,
        const enum CBLAS_TRANSPOSE __transB, const int __m, const int __n,
        const float __alpha, const float *__A, const int __lda,
        const float __beta, const float *__B, const int __ldb, float *__C,
        const int __ldc) __OSX_AVAILABLE_STARTING(__MAC_10_10,__IPHONE_8_0);
extern void appleblas_dgeadd(const enum CBLAS_ORDER __order,
        const enum CBLAS_TRANSPOSE __transA,
        const enum CBLAS_TRANSPOSE __transB, const int __m, const int __n,
        const double __alpha, const double *__A, const int __lda,
        const double __beta, const double *__B, const int __ldb, double *__C,
        const int __ldc) __OSX_AVAILABLE_STARTING(__MAC_10_10,__IPHONE_8_0);
extern void ATLU_DestroyThreadMemory() 
        __OSX_AVAILABLE_BUT_DEPRECATED(__MAC_10_2, __MAC_10_9, __IPHONE_4_0,
        __IPHONE_7_0);
typedef void (*BLASParamErrorProc)(const char *funcName, const char *paramName,
                                   const int *paramPos,  const int *paramValue);
void SetBLASParamErrorProc(BLASParamErrorProc __ErrorProc) 
        __OSX_AVAILABLE_STARTING(__MAC_10_2,__IPHONE_4_0);
#endif 
#ifdef __cplusplus
}
#endif
#endif 
