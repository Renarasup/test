#ifndef __VDSP__
#define __VDSP__
#if PRAGMA_ONCE
    #pragma once
#endif
#if defined __i386__ && !defined __vDSP_TRANSLATE__
#include <vecLib/vDSP_translate.h>
#endif
#include <Availability.h>
#include <stdint.h>
#include <stdbool.h>
#ifdef __cplusplus
extern "C" {
#endif
#include <CoreFoundation/CFAvailability.h>
#define vDSP_ENUM   CF_ENUM
#if !defined __has_feature
    #define __has_feature(f)    0
#endif
#if __has_feature(assume_nonnull)
    _Pragma("clang assume_nonnull begin")
#else
    #define __nullable
    #define __nonnull
#endif
#pragma options align=power
#define vDSP_Version0   622
#define vDSP_Version1   20
typedef unsigned long vDSP_Length;
typedef long          vDSP_Stride;
typedef struct DSPComplex {
    float  real;
    float  imag;
} DSPComplex;
typedef struct DSPDoubleComplex {
    double real;
    double imag;
} DSPDoubleComplex;
typedef struct DSPSplitComplex {
    float  * __nonnull realp;
    float  * __nonnull imagp;
} DSPSplitComplex;
typedef struct DSPDoubleSplitComplex {
    double * __nonnull realp;
    double * __nonnull imagp;
} DSPDoubleSplitComplex;
typedef int FFTDirection;
typedef int FFTRadix;
enum {
    kFFTDirection_Forward         = +1,
    kFFTDirection_Inverse         = -1
};
enum {
    kFFTRadix2                    = 0,
    kFFTRadix3                    = 1,
    kFFTRadix5                    = 2
};
enum {
    vDSP_HALF_WINDOW              = 1,
    vDSP_HANN_DENORM              = 0,
    vDSP_HANN_NORM                = 2
};
typedef struct { uint8_t bytes[3]; } vDSP_uint24; 
typedef struct { uint8_t bytes[3]; } vDSP_int24;  
typedef struct OpaqueFFTSetup           *FFTSetup;
typedef struct OpaqueFFTSetupD          *FFTSetupD;
typedef struct vDSP_biquad_SetupStruct  *vDSP_biquad_Setup;
typedef struct vDSP_biquad_SetupStructD *vDSP_biquad_SetupD;
typedef struct vDSP_biquadm_SetupStruct  *vDSP_biquadm_Setup;
typedef struct vDSP_biquadm_SetupStructD *vDSP_biquadm_SetupD;
extern __nullable FFTSetup vDSP_create_fftsetup(
    vDSP_Length __Log2n,
    FFTRadix    __Radix)
        __OSX_AVAILABLE_STARTING(__MAC_10_0, __IPHONE_4_0);
extern void vDSP_destroy_fftsetup(__nullable FFTSetup __setup)
        __OSX_AVAILABLE_STARTING(__MAC_10_0, __IPHONE_4_0);
extern __nullable FFTSetupD vDSP_create_fftsetupD(
    vDSP_Length __Log2n,
    FFTRadix    __Radix)
        __OSX_AVAILABLE_STARTING(__MAC_10_2, __IPHONE_4_0);
extern void vDSP_destroy_fftsetupD(__nullable FFTSetupD __setup)
        __OSX_AVAILABLE_STARTING(__MAC_10_2, __IPHONE_4_0);
extern __nullable vDSP_biquad_Setup vDSP_biquad_CreateSetup(
    const double *__Coefficients,
    vDSP_Length   __M)
        __OSX_AVAILABLE_STARTING(__MAC_10_9, __IPHONE_6_0);
extern __nullable vDSP_biquad_SetupD vDSP_biquad_CreateSetupD(
    const double *__Coefficients,
    vDSP_Length   __M)
        __OSX_AVAILABLE_STARTING(__MAC_10_9, __IPHONE_6_0);
extern void vDSP_biquad_DestroySetup (
    __nullable vDSP_biquad_Setup __setup)
        __OSX_AVAILABLE_STARTING(__MAC_10_9, __IPHONE_6_0);
extern void vDSP_biquad_DestroySetupD(
    __nullable vDSP_biquad_SetupD __setup)
        __OSX_AVAILABLE_STARTING(__MAC_10_9, __IPHONE_6_0);
extern __nullable vDSP_biquadm_Setup vDSP_biquadm_CreateSetup(
    const double *__coeffs,
    vDSP_Length   __M,
    vDSP_Length   __N)
        __OSX_AVAILABLE_STARTING(__MAC_10_9, __IPHONE_7_0);
extern __nullable vDSP_biquadm_SetupD vDSP_biquadm_CreateSetupD(
    const double *__coeffs,
    vDSP_Length   __M,
    vDSP_Length   __N)
        __OSX_AVAILABLE_STARTING(__MAC_10_10, __IPHONE_8_0);
extern void vDSP_biquadm_DestroySetup(
    vDSP_biquadm_Setup __setup)
        __OSX_AVAILABLE_STARTING(__MAC_10_9, __IPHONE_7_0);
extern void vDSP_biquadm_DestroySetupD(
    vDSP_biquadm_SetupD __setup)
        __OSX_AVAILABLE_STARTING(__MAC_10_10, __IPHONE_8_0);
extern void vDSP_biquadm_CopyState(
    vDSP_biquadm_Setup                     __dest,
    const struct vDSP_biquadm_SetupStruct *__src)
        __OSX_AVAILABLE_STARTING(__MAC_10_9, __IPHONE_7_0);
extern void vDSP_biquadm_CopyStateD(
    vDSP_biquadm_SetupD                     __dest,
    const struct vDSP_biquadm_SetupStructD *__src)
        __OSX_AVAILABLE_STARTING(__MAC_10_10, __IPHONE_8_0);
extern void vDSP_biquadm_ResetState(vDSP_biquadm_Setup __setup)
        __OSX_AVAILABLE_STARTING(__MAC_10_9, __IPHONE_7_0);
extern void vDSP_biquadm_ResetStateD(vDSP_biquadm_SetupD __setup)
        __OSX_AVAILABLE_STARTING(__MAC_10_10, __IPHONE_8_0);
extern void vDSP_biquadm_SetCoefficientsDouble(
    vDSP_biquadm_Setup                  __setup,
    const double                       *__coeffs,
    vDSP_Length                         __start_sec,
    vDSP_Length                         __start_chn,
    vDSP_Length                         __nsec,
    vDSP_Length                         __nchn)
    __OSX_AVAILABLE_STARTING(__MAC_10_11, __IPHONE_9_0);
extern void vDSP_biquadm_SetTargetsDouble(
    vDSP_biquadm_Setup                  __setup,
    const double                       *__targets,
    float                               __interp_rate,
    float                               __interp_threshold,
    vDSP_Length                         __start_sec,
    vDSP_Length                         __start_chn,
    vDSP_Length                         __nsec,
    vDSP_Length                         __nchn)
    __OSX_AVAILABLE_STARTING(__MAC_10_11, __IPHONE_9_0);
extern void vDSP_biquadm_SetCoefficientsSingle(
    vDSP_biquadm_Setup                  __setup,
    const float                         *__coeffs,
    vDSP_Length                         __start_sec,
    vDSP_Length                         __start_chn,
    vDSP_Length                         __nsec,
    vDSP_Length                         __nchn)
    __OSX_AVAILABLE_STARTING(__MAC_10_11, __IPHONE_9_0);
extern void vDSP_biquadm_SetTargetsSingle(
    vDSP_biquadm_Setup                  __setup,
    const float                        *__targets,
    float                               __interp_rate,
    float                               __interp_threshold,
    vDSP_Length                         __start_sec,
    vDSP_Length                         __start_chn,
    vDSP_Length                         __nsec,
    vDSP_Length                         __nchn)
    __OSX_AVAILABLE_STARTING(__MAC_10_11, __IPHONE_9_0);
extern void vDSP_biquadm_SetActiveFilters(
    vDSP_biquadm_Setup                  __setup,
    const bool                         *__filter_states)
    __OSX_AVAILABLE_STARTING(__MAC_10_11, __IPHONE_9_0);
extern void vDSP_ctoz(
    const DSPComplex      *__C,
    vDSP_Stride            __IC,
    const DSPSplitComplex *__Z,
    vDSP_Stride            __IZ,
    vDSP_Length            __N)
        __OSX_AVAILABLE_STARTING(__MAC_10_0, __IPHONE_4_0);
extern void vDSP_ctozD(
    const DSPDoubleComplex      *__C,
    vDSP_Stride                  __IC,
    const DSPDoubleSplitComplex *__Z,
    vDSP_Stride                  __IZ,
    vDSP_Length                  __N)
        __OSX_AVAILABLE_STARTING(__MAC_10_2, __IPHONE_4_0);
extern void vDSP_ztoc(
    const DSPSplitComplex *__Z,
    vDSP_Stride            __IZ,
    DSPComplex            *__C,
    vDSP_Stride            __IC,
    vDSP_Length            __N)
        __OSX_AVAILABLE_STARTING(__MAC_10_0, __IPHONE_4_0);
extern void vDSP_ztocD(
    const DSPDoubleSplitComplex *__Z,
    vDSP_Stride                  __IZ,
    DSPDoubleComplex            *__C,
    vDSP_Stride                  __IC,
    vDSP_Length                  __N)
        __OSX_AVAILABLE_STARTING(__MAC_10_2, __IPHONE_4_0);
extern void vDSP_fft_zip(
    FFTSetup               __Setup,
    const DSPSplitComplex *__C,
    vDSP_Stride            __IC,
    vDSP_Length            __Log2N,
    FFTDirection           __Direction)
        __OSX_AVAILABLE_STARTING(__MAC_10_0, __IPHONE_4_0);
extern void vDSP_fft_zipD(
    FFTSetupD                    __Setup,
    const DSPDoubleSplitComplex *__C,
    vDSP_Stride                  __IC,
    vDSP_Length                  __Log2N,
    FFTDirection                 __Direction)
        __OSX_AVAILABLE_STARTING(__MAC_10_2, __IPHONE_4_0);
extern void vDSP_fft_zipt(
    FFTSetup               __Setup,
    const DSPSplitComplex *__C,
    vDSP_Stride            __IC,
    const DSPSplitComplex *__Buffer,
    vDSP_Length            __Log2N,
    FFTDirection           __Direction)
        __OSX_AVAILABLE_STARTING(__MAC_10_0, __IPHONE_4_0);
extern void vDSP_fft_ziptD(
    FFTSetupD                    __Setup,
    const DSPDoubleSplitComplex *__C,
    vDSP_Stride                  __IC,
    const DSPDoubleSplitComplex *__Buffer,
    vDSP_Length                  __Log2N,
    FFTDirection                 __Direction)
        __OSX_AVAILABLE_STARTING(__MAC_10_2, __IPHONE_4_0);
extern void vDSP_fft_zop(
    FFTSetup               __Setup,
    const DSPSplitComplex *__A,
    vDSP_Stride            __IA,
    const DSPSplitComplex *__C,
    vDSP_Stride            __IC,
    vDSP_Length            __Log2N,
    FFTDirection           __Direction)
        __OSX_AVAILABLE_STARTING(__MAC_10_0, __IPHONE_4_0);
extern void vDSP_fft_zopt(
    FFTSetup               __Setup,
    const DSPSplitComplex *__A,
    vDSP_Stride            __IA,
    const DSPSplitComplex *__C,
    vDSP_Stride            __IC,
    const DSPSplitComplex *__Buffer,
    vDSP_Length            __Log2N,
    FFTDirection           __Direction)
        __OSX_AVAILABLE_STARTING(__MAC_10_0, __IPHONE_4_0);
extern void vDSP_fft_zopD(
    FFTSetupD                    __Setup,
    const DSPDoubleSplitComplex *__A,
    vDSP_Stride                  __IA,
    const DSPDoubleSplitComplex *__C,
    vDSP_Stride                  __IC,
    vDSP_Length                  __Log2N,
    FFTDirection                 __Direction)
        __OSX_AVAILABLE_STARTING(__MAC_10_2, __IPHONE_4_0);
extern void vDSP_fft_zoptD(
    FFTSetupD                    __Setup,
    const DSPDoubleSplitComplex *__A,
    vDSP_Stride                  __IA,
    const DSPDoubleSplitComplex *__C,
    vDSP_Stride                  __IC,
    const DSPDoubleSplitComplex *__Buffer,
    vDSP_Length                  __Log2N,
    FFTDirection                 __Direction)
        __OSX_AVAILABLE_STARTING(__MAC_10_2, __IPHONE_4_0);
extern void vDSP_fft_zrip(
    FFTSetup               __Setup,
    const DSPSplitComplex *__C,
    vDSP_Stride            __IC,
    vDSP_Length            __Log2N,
    FFTDirection           __Direction)
        __OSX_AVAILABLE_STARTING(__MAC_10_0, __IPHONE_4_0);
extern void vDSP_fft_zripD(
    FFTSetupD                    __Setup,
    const DSPDoubleSplitComplex *__C,
    vDSP_Stride                  __IC,
    vDSP_Length                  __Log2N,
    FFTDirection                 __Direction)
        __OSX_AVAILABLE_STARTING(__MAC_10_2, __IPHONE_4_0);
extern void vDSP_fft_zript(
    FFTSetup               __Setup,
    const DSPSplitComplex *__C,
    vDSP_Stride            __IC,
    const DSPSplitComplex *__Buffer,
    vDSP_Length            __Log2N,
    FFTDirection           __Direction)
        __OSX_AVAILABLE_STARTING(__MAC_10_0, __IPHONE_4_0);
extern void vDSP_fft_zriptD(
    FFTSetupD                    __Setup,
    const DSPDoubleSplitComplex *__C,
    vDSP_Stride                  __IC,
    const DSPDoubleSplitComplex *__Buffer,
    vDSP_Length                  __Log2N,
    FFTDirection                 __Direction)
        __OSX_AVAILABLE_STARTING(__MAC_10_2, __IPHONE_4_0);
extern void vDSP_fft_zrop(
    FFTSetup               __Setup,
    const DSPSplitComplex *__A,
    vDSP_Stride            __IA,
    const DSPSplitComplex *__C,
    vDSP_Stride            __IC,
    vDSP_Length            __Log2N,
    FFTDirection           __Direction)
        __OSX_AVAILABLE_STARTING(__MAC_10_0, __IPHONE_4_0);
extern void vDSP_fft_zropD(
    FFTSetupD                    __Setup,
    const DSPDoubleSplitComplex *__A,
    vDSP_Stride                  __IA,
    const DSPDoubleSplitComplex *__C,
    vDSP_Stride                  __IC,
    vDSP_Length                  __Log2N,
    FFTDirection                 __Direction)
        __OSX_AVAILABLE_STARTING(__MAC_10_2, __IPHONE_4_0);
extern void vDSP_fft_zropt(
    FFTSetup               __Setup,
    const DSPSplitComplex *__A,
    vDSP_Stride            __IA,
    const DSPSplitComplex *__C,
    vDSP_Stride            __IC,
    const DSPSplitComplex *__Buffer,
    vDSP_Length            __Log2N,
    FFTDirection           __Direction)
        __OSX_AVAILABLE_STARTING(__MAC_10_0, __IPHONE_4_0);
extern void vDSP_fft_zroptD(
    FFTSetupD                    __Setup,
    const DSPDoubleSplitComplex *__A,
    vDSP_Stride                  __IA,
    const DSPDoubleSplitComplex *__C,
    vDSP_Stride                  __IC,
    const DSPDoubleSplitComplex *__Buffer,
    vDSP_Length                  __Log2N,
    FFTDirection                 __Direction)
        __OSX_AVAILABLE_STARTING(__MAC_10_2, __IPHONE_4_0);
extern void vDSP_fft2d_zip(
    FFTSetup               __Setup,
    const DSPSplitComplex *__C,
    vDSP_Stride            __IC0,
    vDSP_Stride            __IC1,
    vDSP_Length            __Log2N0,
    vDSP_Length            __Log2N1,
    FFTDirection           __Direction)
        __OSX_AVAILABLE_STARTING(__MAC_10_0, __IPHONE_4_0);
extern void vDSP_fft2d_zipD(
    FFTSetupD                    __Setup,
    const DSPDoubleSplitComplex *__C,
    vDSP_Stride                  __IC0,
    vDSP_Stride                  __IC1,
    vDSP_Length                  __Log2N0,
    vDSP_Length                  __Log2N1,
    FFTDirection                 __Direction)
        __OSX_AVAILABLE_STARTING(__MAC_10_2, __IPHONE_4_0);
extern void vDSP_fft2d_zipt(
    FFTSetup               __Setup,
    const DSPSplitComplex *__C,
    vDSP_Stride            __IC1,
    vDSP_Stride            __IC0,
    const DSPSplitComplex *__Buffer,
    vDSP_Length            __Log2N0,
    vDSP_Length            __Log2N1,
    FFTDirection           __Direction)
        __OSX_AVAILABLE_STARTING(__MAC_10_0, __IPHONE_4_0);
extern void vDSP_fft2d_ziptD(
    FFTSetupD                    __Setup,
    const DSPDoubleSplitComplex *__C,
    vDSP_Stride                  __IC0,
    vDSP_Stride                  __IC1,
    const DSPDoubleSplitComplex *__Buffer,
    vDSP_Length                  __Log2N0,
    vDSP_Length                  __Log2N1,
    FFTDirection                 __Direction)
        __OSX_AVAILABLE_STARTING(__MAC_10_2, __IPHONE_4_0);
extern void vDSP_fft2d_zop(
    FFTSetup               __Setup,
    const DSPSplitComplex *__A,
    vDSP_Stride            __IA0,
    vDSP_Stride            __IA1,
    const DSPSplitComplex *__C,
    vDSP_Stride            __IC0,
    vDSP_Stride            __IC1,
    vDSP_Length            __Log2N0,
    vDSP_Length            __Log2N1,
    FFTDirection           __Direction)
        __OSX_AVAILABLE_STARTING(__MAC_10_0, __IPHONE_4_0);
extern void vDSP_fft2d_zopD(
    FFTSetupD                    __Setup,
    const DSPDoubleSplitComplex *__A,
    vDSP_Stride                  __IA0,
    vDSP_Stride                  __IA1,
    const DSPDoubleSplitComplex *__C,
    vDSP_Stride                  __IC0,
    vDSP_Stride                  __IC1,
    vDSP_Length                  __Log2N0,
    vDSP_Length                  __Log2N1,
    FFTDirection                 __Direction)
        __OSX_AVAILABLE_STARTING(__MAC_10_2, __IPHONE_4_0);
extern void vDSP_fft2d_zopt(
    FFTSetup               __Setup,
    const DSPSplitComplex *__A,
    vDSP_Stride            __IA0,
    vDSP_Stride            __IA1,
    const DSPSplitComplex *__C,
    vDSP_Stride            __IC0,
    vDSP_Stride            __IC1,
    const DSPSplitComplex *__Buffer,
    vDSP_Length            __Log2N0,
    vDSP_Length            __Log2N1,
    FFTDirection           __Direction)
        __OSX_AVAILABLE_STARTING(__MAC_10_0, __IPHONE_4_0);
extern void vDSP_fft2d_zoptD(
    FFTSetupD                    __Setup,
    const DSPDoubleSplitComplex *__A,
    vDSP_Stride                  __IA0,
    vDSP_Stride                  __IA1,
    const DSPDoubleSplitComplex *__C,
    vDSP_Stride                  __IC0,
    vDSP_Stride                  __IC1,
    const DSPDoubleSplitComplex *__Buffer,
    vDSP_Length                  __Log2N0,
    vDSP_Length                  __Log2N1,
    FFTDirection                 __Direction)
        __OSX_AVAILABLE_STARTING(__MAC_10_2, __IPHONE_4_0);
extern void vDSP_fft2d_zrip(
    FFTSetup               __Setup,
    const DSPSplitComplex *__C,
    vDSP_Stride            __IC0,
    vDSP_Stride            __IC1,
    vDSP_Length            __Log2N0,
    vDSP_Length            __Log2N1,
    FFTDirection           __Direction)
        __OSX_AVAILABLE_STARTING(__MAC_10_0, __IPHONE_4_0);
extern void vDSP_fft2d_zripD(
    FFTSetupD                    __Setup,
    const DSPDoubleSplitComplex *__C,
    vDSP_Stride                  __IC0,
    vDSP_Stride                  __IC1,
    vDSP_Length                  __Log2N0,
    vDSP_Length                  __Log2N1,
    FFTDirection                 __flag)
        __OSX_AVAILABLE_STARTING(__MAC_10_2, __IPHONE_4_0);
extern void vDSP_fft2d_zript(
    FFTSetup               __Setup,
    const DSPSplitComplex *__C,
    vDSP_Stride            __IC0,
    vDSP_Stride            __IC1,
    const DSPSplitComplex *__Buffer,
    vDSP_Length            __Log2N0,
    vDSP_Length            __Log2N1,
    FFTDirection           __Direction)
        __OSX_AVAILABLE_STARTING(__MAC_10_0, __IPHONE_4_0);
extern void vDSP_fft2d_zriptD(
    FFTSetupD                    __Setup,
    const DSPDoubleSplitComplex *__C,
    vDSP_Stride                  __IC0,
    vDSP_Stride                  __IC1,
    const DSPDoubleSplitComplex *__Buffer,
    vDSP_Length                  __Log2N0,
    vDSP_Length                  __Log2N1,
    FFTDirection                 __flag)
        __OSX_AVAILABLE_STARTING(__MAC_10_2, __IPHONE_4_0);
extern void vDSP_fft2d_zrop(
    FFTSetup               __Setup,
    const DSPSplitComplex *__A,
    vDSP_Stride            __IA0,
    vDSP_Stride            __IA1,
    const DSPSplitComplex *__C,
    vDSP_Stride            __IC0,
    vDSP_Stride            __IC1,
    vDSP_Length            __Log2N0,
    vDSP_Length            __Log2N1,
    FFTDirection           __Direction)
        __OSX_AVAILABLE_STARTING(__MAC_10_0, __IPHONE_4_0);
extern void vDSP_fft2d_zropt(
    FFTSetup               __Setup,
    const DSPSplitComplex *__A,
    vDSP_Stride            __IA0,
    vDSP_Stride            __IA1,
    const DSPSplitComplex *__C,
    vDSP_Stride            __IC0,
    vDSP_Stride            __IC1,
    const DSPSplitComplex *__Buffer,
    vDSP_Length            __Log2N0,
    vDSP_Length            __Log2N1,
    FFTDirection           __Direction)
        __OSX_AVAILABLE_STARTING(__MAC_10_0, __IPHONE_4_0);
extern void vDSP_fft2d_zropD(
    FFTSetupD                    __Setup,
    const DSPDoubleSplitComplex *__A,
    vDSP_Stride                  __IA0,
    vDSP_Stride                  __IA1,
    const DSPDoubleSplitComplex *__C,
    vDSP_Stride                  __IC0,
    vDSP_Stride                  __IC1,
    vDSP_Length                  __Log2N0,
    vDSP_Length                  __Log2N1,
    FFTDirection                 __Direction)
        __OSX_AVAILABLE_STARTING(__MAC_10_2, __IPHONE_4_0);
extern void vDSP_fft2d_zroptD(
    FFTSetupD                    __Setup,
    const DSPDoubleSplitComplex *__A,
    vDSP_Stride                  __IA0,
    vDSP_Stride                  __IA1,
    const DSPDoubleSplitComplex *__C,
    vDSP_Stride                  __IC0,
    vDSP_Stride                  __IC1,
    const DSPDoubleSplitComplex *__Buffer,
    vDSP_Length                  __Log2N0,
    vDSP_Length                  __Log2N1,
    FFTDirection                 __Direction)
        __OSX_AVAILABLE_STARTING(__MAC_10_2, __IPHONE_4_0);
extern void vDSP_fftm_zip(
    FFTSetup               __Setup,
    const DSPSplitComplex *__C,
    vDSP_Stride            __IC,
    vDSP_Stride            __IM,
    vDSP_Length            __Log2N,
    vDSP_Length            __M,
    FFTDirection           __Direction)
        __OSX_AVAILABLE_STARTING(__MAC_10_2, __IPHONE_4_0);
extern void vDSP_fftm_zipD(
    FFTSetupD                    __Setup,
    const DSPDoubleSplitComplex *__C,
    vDSP_Stride                  __IC,
    vDSP_Stride                  __IM,
    vDSP_Length                  __Log2N,
    vDSP_Length                  __M,
    FFTDirection                 __Direction)
        __OSX_AVAILABLE_STARTING(__MAC_10_2, __IPHONE_4_0);
extern void vDSP_fftm_zipt(
    FFTSetup               __Setup,
    const DSPSplitComplex *__C,
    vDSP_Stride            __IC,
    vDSP_Stride            __IM,
    const DSPSplitComplex *__Buffer,
    vDSP_Length            __Log2N,
    vDSP_Length            __M,
    FFTDirection           __Direction)
        __OSX_AVAILABLE_STARTING(__MAC_10_2, __IPHONE_4_0);
extern void vDSP_fftm_ziptD(
    FFTSetupD                    __Setup,
    const DSPDoubleSplitComplex *__C,
    vDSP_Stride                  __IC,
    vDSP_Stride                  __IM,
    const DSPDoubleSplitComplex *__Buffer,
    vDSP_Length                  __Log2N,
    vDSP_Length                  __M,
    FFTDirection                 __Direction)
        __OSX_AVAILABLE_STARTING(__MAC_10_2, __IPHONE_4_0);
extern void vDSP_fftm_zop(
    FFTSetup               __Setup,
    const DSPSplitComplex *__A,
    vDSP_Stride            __IA,
    vDSP_Stride            __IMA,
    const DSPSplitComplex *__C,
    vDSP_Stride            __IC,
    vDSP_Stride            __IMC,
    vDSP_Length            __Log2N,
    vDSP_Length            __M,
    FFTDirection           __Direction)
        __OSX_AVAILABLE_STARTING(__MAC_10_2, __IPHONE_4_0);
extern void vDSP_fftm_zopD(
    FFTSetupD                    __Setup,
    const DSPDoubleSplitComplex *__A,
    vDSP_Stride                  __IA,
    vDSP_Stride                  __IMA,
    const DSPDoubleSplitComplex *__C,
    vDSP_Stride                  __IC,
    vDSP_Stride                  __IMC,
    vDSP_Length                  __Log2N,
    vDSP_Length                  __M,
    FFTDirection                 __Direction)
        __OSX_AVAILABLE_STARTING(__MAC_10_2, __IPHONE_4_0);
extern void vDSP_fftm_zopt(
    FFTSetup               __Setup,
    const DSPSplitComplex *__A,
    vDSP_Stride            __IA,
    vDSP_Stride            __IMA,
    const DSPSplitComplex *__C,
    vDSP_Stride            __IC,
    vDSP_Stride            __IMC,
    const DSPSplitComplex *__Buffer,
    vDSP_Length            __Log2N,
    vDSP_Length            __M,
    FFTDirection           __Direction)
        __OSX_AVAILABLE_STARTING(__MAC_10_2, __IPHONE_4_0);
extern void vDSP_fftm_zoptD(
    FFTSetupD                    __Setup,
    const DSPDoubleSplitComplex *__A,
    vDSP_Stride                  __IA,
    vDSP_Stride                  __IMA,
    const DSPDoubleSplitComplex *__C,
    vDSP_Stride                  __IC,
    vDSP_Stride                  __IMC,
    const DSPDoubleSplitComplex *__Buffer,
    vDSP_Length                  __Log2N,
    vDSP_Length                  __M,
    FFTDirection                 __Direction)
        __OSX_AVAILABLE_STARTING(__MAC_10_2, __IPHONE_4_0);
extern void vDSP_fftm_zrip(
    FFTSetup               __Setup,
    const DSPSplitComplex *__C,
    vDSP_Stride            __IC,
    vDSP_Stride            __IM,
    vDSP_Length            __Log2N,
    vDSP_Length            __M,
    FFTDirection           __Direction)
        __OSX_AVAILABLE_STARTING(__MAC_10_2, __IPHONE_4_0);
extern void vDSP_fftm_zripD(
    FFTSetupD                    __Setup,
    const DSPDoubleSplitComplex *__C,
    vDSP_Stride                  __IC,
    vDSP_Stride                  __IM,
    vDSP_Length                  __Log2N,
    vDSP_Length                  __M,
    FFTDirection                 __Direction)
        __OSX_AVAILABLE_STARTING(__MAC_10_2, __IPHONE_4_0);
extern void vDSP_fftm_zript(
    FFTSetup               __Setup,
    const DSPSplitComplex *__C,
    vDSP_Stride            __IC,
    vDSP_Stride            __IM,
    const DSPSplitComplex *__Buffer,
    vDSP_Length            __Log2N,
    vDSP_Length            __M,
    FFTDirection           __Direction)
        __OSX_AVAILABLE_STARTING(__MAC_10_2, __IPHONE_4_0);
extern void vDSP_fftm_zriptD(
    FFTSetupD                    __Setup,
    const DSPDoubleSplitComplex *__C,
    vDSP_Stride                  __IC,
    vDSP_Stride                  __IM,
    const DSPDoubleSplitComplex *__Buffer,
    vDSP_Length                  __Log2N,
    vDSP_Length                  __M,
    FFTDirection                 __Direction)
        __OSX_AVAILABLE_STARTING(__MAC_10_2, __IPHONE_4_0);
extern void vDSP_fftm_zrop(
    FFTSetup               __Setup,
    const DSPSplitComplex *__A,
    vDSP_Stride            __IA,
    vDSP_Stride            __IMA,
    const DSPSplitComplex *__C,
    vDSP_Stride            __IC,
    vDSP_Stride            __IMC,
    vDSP_Length            __Log2N,
    vDSP_Length            __M,
    FFTDirection           __Direction)
        __OSX_AVAILABLE_STARTING(__MAC_10_2, __IPHONE_4_0);
extern void vDSP_fftm_zropt(
    FFTSetup               __Setup,
    const DSPSplitComplex *__A,
    vDSP_Stride            __IA,
    vDSP_Stride            __IMA,
    const DSPSplitComplex *__C,
    vDSP_Stride            __IC,
    vDSP_Stride            __IMC,
    const DSPSplitComplex *__Buffer,
    vDSP_Length            __Log2N,
    vDSP_Length            __M,
    FFTDirection           __Direction)
        __OSX_AVAILABLE_STARTING(__MAC_10_2, __IPHONE_4_0);
extern void vDSP_fftm_zropD(
    FFTSetupD                    __Setup,
    const DSPDoubleSplitComplex *__A,
    vDSP_Stride                  __IA,
    vDSP_Stride                  __IMA,
    const DSPDoubleSplitComplex *__C,
    vDSP_Stride                  __IC,
    vDSP_Stride                  __IMC,
    vDSP_Length                  __Log2N,
    vDSP_Length                  __M,
    FFTDirection                 __Direction)
        __OSX_AVAILABLE_STARTING(__MAC_10_2, __IPHONE_4_0);
extern void vDSP_fftm_zroptD(
    FFTSetupD                    __Setup,
    const DSPDoubleSplitComplex *__A,
    vDSP_Stride                  __IA,
    vDSP_Stride                  __IMA,
    const DSPDoubleSplitComplex *__C,
    vDSP_Stride                  __IC,
    vDSP_Stride                  __IMC,
    const DSPDoubleSplitComplex *__Buffer,
    vDSP_Length                  __Log2N,
    vDSP_Length                  __M,
    FFTDirection                 __Direction)
        __OSX_AVAILABLE_STARTING(__MAC_10_2, __IPHONE_4_0);
extern void vDSP_fft3_zop(
    FFTSetup               __Setup,
    const DSPSplitComplex *__A,
    vDSP_Stride            __IA,
    const DSPSplitComplex *__C,
    vDSP_Stride            __IC,
    vDSP_Length            __Log2N,
    FFTDirection           __Direction)
        __OSX_AVAILABLE_BUT_DEPRECATED(__MAC_10_2, __MAC_10_11, __IPHONE_4_0, __IPHONE_9_0);
extern void vDSP_fft3_zopD(
    FFTSetupD                    __Setup,
    const DSPDoubleSplitComplex *__A,
    vDSP_Stride                  __IA,
    const DSPDoubleSplitComplex *__C,
    vDSP_Stride                  __IC,
    vDSP_Length                  __Log2N,
    FFTDirection                 __Direction)
        __OSX_AVAILABLE_BUT_DEPRECATED(__MAC_10_2, __MAC_10_11, __IPHONE_4_0, __IPHONE_9_0);
extern void vDSP_fft5_zop(
    FFTSetup               __Setup,
    const DSPSplitComplex *__A,
    vDSP_Stride            __IA,
    const DSPSplitComplex *__C,
    vDSP_Stride            __IC,
    vDSP_Length            __Log2N,
    FFTDirection           __Direction)
        __OSX_AVAILABLE_BUT_DEPRECATED(__MAC_10_2, __MAC_10_11, __IPHONE_4_0, __IPHONE_9_0);
extern void vDSP_fft5_zopD(
    FFTSetupD                    __Setup,
    const DSPDoubleSplitComplex *__A,
    vDSP_Stride                  __IA,
    const DSPDoubleSplitComplex *__C,
    vDSP_Stride                  __IC,
    vDSP_Length                  __Log2N,
    FFTDirection                 __Direction)
        __OSX_AVAILABLE_BUT_DEPRECATED(__MAC_10_2, __MAC_10_11, __IPHONE_4_0, __IPHONE_9_0);
extern void vDSP_biquad(
    const struct vDSP_biquad_SetupStruct *__Setup,
    float       *__Delay,
    const float *__X, vDSP_Stride __IX,
    float       *__Y, vDSP_Stride __IY,
    vDSP_Length  __N)
        __OSX_AVAILABLE_STARTING(__MAC_10_9, __IPHONE_6_0);
extern void vDSP_biquadD(
    const struct vDSP_biquad_SetupStructD *__Setup,
    double       *__Delay,
    const double *__X, vDSP_Stride __IX,
    double       *__Y, vDSP_Stride __IY,
    vDSP_Length   __N)
        __OSX_AVAILABLE_STARTING(__MAC_10_9, __IPHONE_6_0);
extern void vDSP_biquadm(
    vDSP_biquadm_Setup       __Setup,
    const float * __nonnull * __nonnull __X, vDSP_Stride __IX,
    float       * __nonnull * __nonnull __Y, vDSP_Stride __IY,
    vDSP_Length              __N)
        __OSX_AVAILABLE_STARTING(__MAC_10_9, __IPHONE_7_0);
extern void vDSP_biquadmD(
     vDSP_biquadm_SetupD       __Setup,
     const double * __nonnull * __nonnull __X, vDSP_Stride __IX,
     double       * __nonnull * __nonnull __Y, vDSP_Stride __IY,
     vDSP_Length               __N)
        __OSX_AVAILABLE_STARTING(__MAC_10_10, __IPHONE_8_0);
extern void vDSP_conv(
    const float *__A,  
    vDSP_Stride  __IA,
    const float *__F,  
    vDSP_Stride  __IF,
    float       *__C,  
    vDSP_Stride  __IC,
    vDSP_Length  __N,  
    vDSP_Length  __P)  
        __OSX_AVAILABLE_STARTING(__MAC_10_0, __IPHONE_4_0);
extern void vDSP_convD(
    const double *__A, 
    vDSP_Stride   __IA,
    const double *__F, 
    vDSP_Stride   __IF,
    double       *__C, 
    vDSP_Stride   __IC,
    vDSP_Length   __N, 
    vDSP_Length   __P) 
        __OSX_AVAILABLE_STARTING(__MAC_10_2, __IPHONE_4_0);
extern void vDSP_zconv(
    const DSPSplitComplex *__A,  
    vDSP_Stride            __IA,
    const DSPSplitComplex *__F,  
    vDSP_Stride            __IF,
    const DSPSplitComplex *__C,  
    vDSP_Stride            __IC,
    vDSP_Length            __N,  
    vDSP_Length            __P)  
        __OSX_AVAILABLE_STARTING(__MAC_10_0, __IPHONE_4_0);
extern void vDSP_zconvD(
    const DSPDoubleSplitComplex *__A,    
    vDSP_Stride                  __IA,
    const DSPDoubleSplitComplex *__F,    
    vDSP_Stride                  __IF,
    const DSPDoubleSplitComplex *__C,    
    vDSP_Stride                  __IC,
    vDSP_Length                  __N,    
    vDSP_Length                  __P)    
        __OSX_AVAILABLE_STARTING(__MAC_10_2, __IPHONE_4_0);
extern void vDSP_f3x3(
    const float *__A,
    vDSP_Length  __NR,
    vDSP_Length  __NC,
    const float *__F,
    float       *__C)
        __OSX_AVAILABLE_STARTING(__MAC_10_2, __IPHONE_4_0);
extern void vDSP_f3x3D(
    const double *__A,
    vDSP_Length   __NR,
    vDSP_Length   __NC,
    const double *__F,
    double       *__C)
        __OSX_AVAILABLE_STARTING(__MAC_10_2, __IPHONE_4_0);
extern void vDSP_f5x5(
    const float *__A,
    vDSP_Length  __NR,
    vDSP_Length  __NC,
    const float *__F,
    float       *__C)
        __OSX_AVAILABLE_STARTING(__MAC_10_2, __IPHONE_4_0);
extern void vDSP_f5x5D(
    const double *__A,
    vDSP_Length   __NR,
    vDSP_Length   __NC,
    const double *__F,
    double       *__C)
        __OSX_AVAILABLE_STARTING(__MAC_10_2, __IPHONE_4_0);
extern void vDSP_imgfir(
    const float *__A,  
    vDSP_Length  __NR, 
    vDSP_Length  __NC, 
    const float *__F,  
    float       *__C,  
    vDSP_Length  __P,  
    vDSP_Length  __Q)  
        __OSX_AVAILABLE_STARTING(__MAC_10_2, __IPHONE_4_0);
extern void vDSP_imgfirD(
    const double *__A,  
    vDSP_Length   __NR, 
    vDSP_Length   __NC, 
    const double *__F,  
    double       *__C,  
    vDSP_Length   __P,  
    vDSP_Length   __Q)  
        __OSX_AVAILABLE_STARTING(__MAC_10_2, __IPHONE_4_0);
extern void vDSP_mtrans(
    const float *__A,
    vDSP_Stride  __IA,
    float       *__C,
    vDSP_Stride  __IC,
    vDSP_Length  __M,
    vDSP_Length  __N)
        __OSX_AVAILABLE_STARTING(__MAC_10_2, __IPHONE_4_0);
extern void vDSP_mtransD(
    const double *__A,
    vDSP_Stride   __IA,
    double       *__C,
    vDSP_Stride   __IC,
    vDSP_Length   __M,
    vDSP_Length   __N)
            __OSX_AVAILABLE_STARTING(__MAC_10_2, __IPHONE_4_0);
extern void vDSP_mmul(
    const float *__A,
    vDSP_Stride  __IA,
    const float *__B,
    vDSP_Stride  __IB,
    float       *__C,
    vDSP_Stride  __IC,
    vDSP_Length  __M,
    vDSP_Length  __N,
    vDSP_Length  __P)
        __OSX_AVAILABLE_STARTING(__MAC_10_2, __IPHONE_4_0);
extern void vDSP_mmulD(
    const double *__A,
    vDSP_Stride   __IA,
    const double *__B,
    vDSP_Stride   __IB,
    double       *__C,
    vDSP_Stride   __IC,
    vDSP_Length   __M,
    vDSP_Length   __N,
    vDSP_Length   __P)
        __OSX_AVAILABLE_STARTING(__MAC_10_2, __IPHONE_4_0);
extern void vDSP_zmma(
    const DSPSplitComplex *__A,
    vDSP_Stride            __IA,
    const DSPSplitComplex *__B,
    vDSP_Stride            __IB,
    const DSPSplitComplex *__C,
    vDSP_Stride            __IC,
    const DSPSplitComplex *__D,
    vDSP_Stride            __ID,
    vDSP_Length            __M,
    vDSP_Length            __N,
    vDSP_Length            __P)
        __OSX_AVAILABLE_STARTING(__MAC_10_2, __IPHONE_4_0);
extern void vDSP_zmmaD(
    const DSPDoubleSplitComplex *__A,
    vDSP_Stride                  __IA,
    const DSPDoubleSplitComplex *__B,
    vDSP_Stride                  __IB,
    const DSPDoubleSplitComplex *__C,
    vDSP_Stride                  __IC,
    const DSPDoubleSplitComplex *__D,
    vDSP_Stride                  __ID,
    vDSP_Length                  __M,
    vDSP_Length                  __N,
    vDSP_Length                  __P)
        __OSX_AVAILABLE_STARTING(__MAC_10_2, __IPHONE_4_0);
extern void vDSP_zmms(
    const DSPSplitComplex *__A,
    vDSP_Stride            __IA,
    const DSPSplitComplex *__B,
    vDSP_Stride            __IB,
    const DSPSplitComplex *__C,
    vDSP_Stride            __IC,
    const DSPSplitComplex *__D,
    vDSP_Stride            __ID,
    vDSP_Length            __M,
    vDSP_Length            __N,
    vDSP_Length            __P)
        __OSX_AVAILABLE_STARTING(__MAC_10_2, __IPHONE_4_0);
extern void vDSP_zmmsD(
    const DSPDoubleSplitComplex *__A,
    vDSP_Stride                  __IA,
    const DSPDoubleSplitComplex *__B,
    vDSP_Stride                  __IB,
    const DSPDoubleSplitComplex *__C,
    vDSP_Stride                  __IC,
    const DSPDoubleSplitComplex *__D,
    vDSP_Stride                  __ID,
    vDSP_Length                  __M,
    vDSP_Length                  __N,
    vDSP_Length                  __P)
        __OSX_AVAILABLE_STARTING(__MAC_10_2, __IPHONE_4_0);
extern void vDSP_zvmmaa(
    const DSPSplitComplex *__A,
    vDSP_Stride            __IA,
    const DSPSplitComplex *__B,
    vDSP_Stride            __IB,
    const DSPSplitComplex *__C,
    vDSP_Stride            __IC,
    const DSPSplitComplex *__D,
    vDSP_Stride            __ID,
    const DSPSplitComplex *__E,
    vDSP_Stride            __IE,
    const DSPSplitComplex *__F,
    vDSP_Stride            __IF,
    vDSP_Length            __N)
        __OSX_AVAILABLE_STARTING(__MAC_10_9, __IPHONE_7_0);
extern void vDSP_zvmmaaD(
    const DSPDoubleSplitComplex *__A,
    vDSP_Stride                  __IA,
    const DSPDoubleSplitComplex *__B,
    vDSP_Stride                  __IB,
    const DSPDoubleSplitComplex *__C,
    vDSP_Stride                  __IC,
    const DSPDoubleSplitComplex *__D,
    vDSP_Stride                  __ID,
    const DSPDoubleSplitComplex *__E,
    vDSP_Stride                  __IE,
    const DSPDoubleSplitComplex *__F,
    vDSP_Stride                  __IF,
    vDSP_Length                  __N)
        __OSX_AVAILABLE_STARTING(__MAC_10_10, __IPHONE_8_0);
extern void vDSP_zmsm(
    const DSPSplitComplex *__A,
    vDSP_Stride            __IA,
    const DSPSplitComplex *__B,
    vDSP_Stride            __IB,
    const DSPSplitComplex *__C,
    vDSP_Stride            __IC,
    const DSPSplitComplex *__D,
    vDSP_Stride            __ID,
    vDSP_Length            __M,
    vDSP_Length            __N,
    vDSP_Length            __P)
        __OSX_AVAILABLE_STARTING(__MAC_10_2, __IPHONE_4_0);
extern void vDSP_zmsmD(
    const DSPDoubleSplitComplex *__A,
    vDSP_Stride                  __IA,
    const DSPDoubleSplitComplex *__B,
    vDSP_Stride                  __IB,
    const DSPDoubleSplitComplex *__C,
    vDSP_Stride                  __IC,
    const DSPDoubleSplitComplex *__D,
    vDSP_Stride                  __ID,
    vDSP_Length                  __M,
    vDSP_Length                  __N,
    vDSP_Length                  __P)
        __OSX_AVAILABLE_STARTING(__MAC_10_2, __IPHONE_4_0);
extern void vDSP_zmmul(
    const DSPSplitComplex *__A,
    vDSP_Stride            __IA,
    const DSPSplitComplex *__B,
    vDSP_Stride            __IB,
    const DSPSplitComplex *__C,
    vDSP_Stride            __IC,
    vDSP_Length            __M,
    vDSP_Length            __N,
    vDSP_Length            __P)
        __OSX_AVAILABLE_STARTING(__MAC_10_2, __IPHONE_4_0);
extern void vDSP_zmmulD(
    const DSPDoubleSplitComplex *__A,
    vDSP_Stride                  __IA,
    const DSPDoubleSplitComplex *__B,
    vDSP_Stride                  __IB,
    const DSPDoubleSplitComplex *__C,
    vDSP_Stride                  __IC,
    vDSP_Length                  __M,
    vDSP_Length                  __N,
    vDSP_Length                  __P)
        __OSX_AVAILABLE_STARTING(__MAC_10_2, __IPHONE_4_0);
extern void vDSP_vadd(
    const float *__A,
    vDSP_Stride  __IA,
    const float *__B,
    vDSP_Stride  __IB,
    float       *__C,
    vDSP_Stride  __IC,
    vDSP_Length  __N)
        __OSX_AVAILABLE_STARTING(__MAC_10_0, __IPHONE_4_0);
extern void vDSP_vaddD(
    const double *__A,
    vDSP_Stride   __IA,
    const double *__B,
    vDSP_Stride   __IB,
    double       *__C,
    vDSP_Stride   __IC,
    vDSP_Length   __N)
        __OSX_AVAILABLE_STARTING(__MAC_10_2, __IPHONE_4_0);
extern void vDSP_vaddi(
    const int   *__A,
    vDSP_Stride  __IA,
    const int   *__B,
    vDSP_Stride  __IB,
    int         *__C,
    vDSP_Stride  __IC,
    vDSP_Length  __N)
        __OSX_AVAILABLE_STARTING(__MAC_10_9, __IPHONE_7_0);
extern void vDSP_zvadd(
    const DSPSplitComplex *__A,
    vDSP_Stride            __IA,
    const DSPSplitComplex *__B,
    vDSP_Stride            __IB,
    const DSPSplitComplex *__C,
    vDSP_Stride            __IC,
    vDSP_Length            __N)
        __OSX_AVAILABLE_STARTING(__MAC_10_0, __IPHONE_4_0);
extern void vDSP_zvaddD(
    const DSPDoubleSplitComplex *__A,
    vDSP_Stride                  __IA,
    const DSPDoubleSplitComplex *__B,
    vDSP_Stride                  __IB,
    const DSPDoubleSplitComplex *__C,
    vDSP_Stride                  __IC,
    vDSP_Length                  __N)
        __OSX_AVAILABLE_STARTING(__MAC_10_2, __IPHONE_4_0);
extern void vDSP_zrvadd(
    const DSPSplitComplex *__A,
    vDSP_Stride            __IA,
    const float           *__B,
    vDSP_Stride            __IB,
    const DSPSplitComplex *__C,
    vDSP_Stride            __IC,
    vDSP_Length            __N)
        __OSX_AVAILABLE_STARTING(__MAC_10_0, __IPHONE_4_0);
extern void vDSP_zrvaddD(
    const DSPDoubleSplitComplex *__A,
    vDSP_Stride                  __IA,
    const double                *__B,
    vDSP_Stride                  __IB,
    const DSPDoubleSplitComplex *__C,
    vDSP_Stride                  __IC,
    vDSP_Length                  __N)
        __OSX_AVAILABLE_STARTING(__MAC_10_2, __IPHONE_4_0);
extern void vDSP_vsub(
    const float *__B,  
    vDSP_Stride  __IB,
    const float *__A,  
    vDSP_Stride  __IA,
    float       *__C,
    vDSP_Stride  __IC,
    vDSP_Length  __N)
        __OSX_AVAILABLE_STARTING(__MAC_10_0, __IPHONE_4_0);
extern void vDSP_vsubD(
    const double *__B, 
    vDSP_Stride   __IB,
    const double *__A, 
    vDSP_Stride   __IA,
    double       *__C,
    vDSP_Stride   __IC,
    vDSP_Length   __N)
        __OSX_AVAILABLE_STARTING(__MAC_10_2, __IPHONE_4_0);
extern void vDSP_zvsub(
    const DSPSplitComplex *__A,
    vDSP_Stride            __IA,
    const DSPSplitComplex *__B,
    vDSP_Stride            __IB,
    const DSPSplitComplex *__C,
    vDSP_Stride            __IC,
    vDSP_Length            __N)
        __OSX_AVAILABLE_STARTING(__MAC_10_0, __IPHONE_4_0);
extern void vDSP_zvsubD(
    const DSPDoubleSplitComplex *__A,
    vDSP_Stride                  __IA,
    const DSPDoubleSplitComplex *__B,
    vDSP_Stride                  __IB,
    const DSPDoubleSplitComplex *__C,
    vDSP_Stride                  __IC,
    vDSP_Length                  __N)
        __OSX_AVAILABLE_STARTING(__MAC_10_2, __IPHONE_4_0);
extern void vDSP_vmul(
    const float *__A,
    vDSP_Stride  __IA,
    const float *__B,
    vDSP_Stride  __IB,
    float       *__C,
    vDSP_Stride  __IC,
    vDSP_Length  __N)
        __OSX_AVAILABLE_STARTING(__MAC_10_0, __IPHONE_4_0);
extern void vDSP_vmulD(
    const double *__A,
    vDSP_Stride   __IA,
    const double *__B,
    vDSP_Stride   __IB,
    double       *__C,
    vDSP_Stride   __IC,
    vDSP_Length   __N)
        __OSX_AVAILABLE_STARTING(__MAC_10_2, __IPHONE_4_0);
extern void vDSP_zrvmul(
    const DSPSplitComplex *__A,
    vDSP_Stride            __IA,
    const float           *__B,
    vDSP_Stride            __IB,
    const DSPSplitComplex *__C,
    vDSP_Stride            __IC,
    vDSP_Length            __N)
        __OSX_AVAILABLE_STARTING(__MAC_10_0, __IPHONE_4_0);
extern void vDSP_zrvmulD(
    const DSPDoubleSplitComplex *__A,
    vDSP_Stride                  __IA,
    const double                *__B,
    vDSP_Stride                  __IB,
    const DSPDoubleSplitComplex *__C,
    vDSP_Stride                  __IC,
    vDSP_Length                  __N)
        __OSX_AVAILABLE_STARTING(__MAC_10_2, __IPHONE_4_0);
extern void vDSP_vdiv(
    const float *__B,  
    vDSP_Stride  __IB,
    const float *__A,  
    vDSP_Stride  __IA,
    float       *__C,
    vDSP_Stride  __IC,
    vDSP_Length  __N)
        __OSX_AVAILABLE_STARTING(__MAC_10_4, __IPHONE_4_0);
extern void vDSP_vdivD(
    const double *__B, 
    vDSP_Stride   __IB,
    const double *__A, 
    vDSP_Stride   __IA,
    double       *__C,
    vDSP_Stride   __IC,
    vDSP_Length   __N)
        __OSX_AVAILABLE_STARTING(__MAC_10_4, __IPHONE_4_0);
extern void vDSP_vdivi(
    const int   *__B,  
    vDSP_Stride  __IB,
    const int   *__A,  
    vDSP_Stride  __IA,
    int         *__C,
    vDSP_Stride  __IC,
    vDSP_Length  __N)
        __OSX_AVAILABLE_STARTING(__MAC_10_4, __IPHONE_4_0);
extern void vDSP_zvdiv(
    const DSPSplitComplex *__B,    
    vDSP_Stride            __IB,
    const DSPSplitComplex *__A,    
    vDSP_Stride            __IA,
    const DSPSplitComplex *__C,
    vDSP_Stride            __IC,
    vDSP_Length            __N)
        __OSX_AVAILABLE_STARTING(__MAC_10_4, __IPHONE_4_0);
extern void vDSP_zvdivD(
    const DSPDoubleSplitComplex *__B,  
    vDSP_Stride                  __IB,
    const DSPDoubleSplitComplex *__A,  
    vDSP_Stride                  __IA,
    const DSPDoubleSplitComplex *__C,
    vDSP_Stride                  __IC,
    vDSP_Length                  __N)
        __OSX_AVAILABLE_STARTING(__MAC_10_4, __IPHONE_4_0);
extern void vDSP_zrvdiv(
    const DSPSplitComplex *__A,
    vDSP_Stride            __IA,
    const float           *__B,
    vDSP_Stride            __IB,
    const DSPSplitComplex *__C,
    vDSP_Stride            __IC,
    vDSP_Length            __N)
        __OSX_AVAILABLE_STARTING(__MAC_10_4, __IPHONE_4_0);
extern void vDSP_zrvdivD(
    const DSPDoubleSplitComplex *__A,
    vDSP_Stride                  __IA,
    const double                *__B,
    vDSP_Stride                  __IB,
    const DSPDoubleSplitComplex *__C,
    vDSP_Stride                  __IC,
    vDSP_Length                  __N)
        __OSX_AVAILABLE_STARTING(__MAC_10_4, __IPHONE_4_0);
extern void vDSP_vsmul(
    const float *__A,
    vDSP_Stride  __IA,
    const float *__B,
    float       *__C,
    vDSP_Stride  __IC,
    vDSP_Length  __N)
        __OSX_AVAILABLE_STARTING(__MAC_10_0, __IPHONE_4_0);
extern void vDSP_vsmulD(
    const double *__A,
    vDSP_Stride   __IA,
    const double *__B,
    double       *__C,
    vDSP_Stride   __IC,
    vDSP_Length   __N)
        __OSX_AVAILABLE_STARTING(__MAC_10_2, __IPHONE_4_0);
extern void vDSP_vsq(
    const float *__A,
    vDSP_Stride  __IA,
    float       *__C,
    vDSP_Stride  __IC,
    vDSP_Length  __N)
        __OSX_AVAILABLE_STARTING(__MAC_10_0, __IPHONE_4_0);
extern void vDSP_vsqD(
    const double *__A,
    vDSP_Stride   __IA,
    double       *__C,
    vDSP_Stride   __IC,
    vDSP_Length   __N)
        __OSX_AVAILABLE_STARTING(__MAC_10_2, __IPHONE_4_0);
extern void vDSP_vssq(
    const float *__A,
    vDSP_Stride  __IA,
    float       *__C,
    vDSP_Stride  __IC,
    vDSP_Length  __N)
        __OSX_AVAILABLE_STARTING(__MAC_10_0, __IPHONE_4_0);
extern void vDSP_vssqD(
    const double *__A,
    vDSP_Stride   __IA,
    double       *__C,
    vDSP_Stride   __IC,
    vDSP_Length   __N)
        __OSX_AVAILABLE_STARTING(__MAC_10_2, __IPHONE_4_0);
extern void vDSP_distancesq(
    const float *__A,
    vDSP_Stride  __IA,
    const float *__B,
    vDSP_Stride  __IB,
    float       *__C,
    vDSP_Length  __N)
        __OSX_AVAILABLE_STARTING(__MAC_10_8, __IPHONE_5_0);
extern void vDSP_distancesqD(
    const double *__A,
    vDSP_Stride   __IA,
    const double *__B,
    vDSP_Stride   __IB,
    double       *__C,
    vDSP_Length   __N)
        __OSX_AVAILABLE_STARTING(__MAC_10_10, __IPHONE_8_0);
extern void vDSP_dotpr(
    const float *__A,
    vDSP_Stride  __IA,
    const float *__B,
    vDSP_Stride  __IB,
    float       *__C,
    vDSP_Length  __N)
        __OSX_AVAILABLE_STARTING(__MAC_10_0, __IPHONE_4_0);
extern void vDSP_dotprD(
    const double *__A,
    vDSP_Stride   __IA,
    const double *__B,
    vDSP_Stride   __IB,
    double       *__C,
    vDSP_Length   __N)
        __OSX_AVAILABLE_STARTING(__MAC_10_2, __IPHONE_4_0);
extern void vDSP_zdotpr(
    const DSPSplitComplex *__A,
    vDSP_Stride            __IA,
    const DSPSplitComplex *__B,
    vDSP_Stride            __IB,
    const DSPSplitComplex *__C,
    vDSP_Length            __N)
        __OSX_AVAILABLE_STARTING(__MAC_10_0, __IPHONE_4_0);
extern void vDSP_zdotprD(
    const DSPDoubleSplitComplex *__A,
    vDSP_Stride                  __IA,
    const DSPDoubleSplitComplex *__B,
    vDSP_Stride                  __IB,
    const DSPDoubleSplitComplex *__C,
    vDSP_Length                  __N)
        __OSX_AVAILABLE_STARTING(__MAC_10_2, __IPHONE_4_0);
extern void vDSP_zrdotpr(
    const DSPSplitComplex *__A,
    vDSP_Stride            __IA,
    const float           *__B,
    vDSP_Stride            __IB,
    const DSPSplitComplex *__C,
    vDSP_Length            __N)
        __OSX_AVAILABLE_STARTING(__MAC_10_0, __IPHONE_4_0);
extern void vDSP_zrdotprD(
    const DSPDoubleSplitComplex *__A,
    vDSP_Stride                  __IA,
    const double                *__B,
    vDSP_Stride                  __IB,
    const DSPDoubleSplitComplex *__C,
    vDSP_Length                  __N)
        __OSX_AVAILABLE_STARTING(__MAC_10_2, __IPHONE_4_0);
extern void vDSP_vam(
    const float *__A,
    vDSP_Stride  __IA,
    const float *__B,
    vDSP_Stride  __IB,
    const float *__C,
    vDSP_Stride  __IC,
    float       *__D,
    vDSP_Stride  __ID,
    vDSP_Length  __N)
        __OSX_AVAILABLE_STARTING(__MAC_10_0, __IPHONE_4_0);
extern void vDSP_vamD(
    const double *__A,
    vDSP_Stride   __IA,
    const double *__B,
    vDSP_Stride   __IB,
    const double *__C,
    vDSP_Stride   __IC,
    double       *__D,
    vDSP_Stride   __IDD,
    vDSP_Length   __N)
        __OSX_AVAILABLE_STARTING(__MAC_10_2, __IPHONE_4_0);
extern void vDSP_vma(
    const float *__A,
    vDSP_Stride  __IA,
    const float *__B,
    vDSP_Stride  __IB,
    const float *__C,
    vDSP_Stride  __IC,
    float       *__D,
    vDSP_Stride  __ID,
    vDSP_Length  __N)
        __OSX_AVAILABLE_STARTING(__MAC_10_4, __IPHONE_4_0);
extern void vDSP_vmaD(
    const double *__A,
    vDSP_Stride   __IA,
    const double *__B,
    vDSP_Stride   __IB,
    const double *__C,
    vDSP_Stride   __IC,
    double       *__D,
    vDSP_Stride   __ID,
    vDSP_Length   __N)
        __OSX_AVAILABLE_STARTING(__MAC_10_4, __IPHONE_4_0);
extern void vDSP_zvma(
    const DSPSplitComplex *__A,
    vDSP_Stride            __IA,
    const DSPSplitComplex *__B,
    vDSP_Stride            __IB,
    const DSPSplitComplex *__C,
    vDSP_Stride            __IC,
    const DSPSplitComplex *__D,
    vDSP_Stride            __ID,
    vDSP_Length            __N)
        __OSX_AVAILABLE_STARTING(__MAC_10_9, __IPHONE_7_0);
extern void vDSP_zvmaD(
    const DSPDoubleSplitComplex *__A,
    vDSP_Stride                  __IA,
    const DSPDoubleSplitComplex *__B,
    vDSP_Stride                  __IB,
    const DSPDoubleSplitComplex *__C,
    vDSP_Stride                  __IC,
    const DSPDoubleSplitComplex *__D,
    vDSP_Stride                  __ID,
    vDSP_Length                  __N)
        __OSX_AVAILABLE_STARTING(__MAC_10_10, __IPHONE_8_0);
extern void vDSP_zvmul(
    const DSPSplitComplex *__A,
    vDSP_Stride            __IA,
    const DSPSplitComplex *__B,
    vDSP_Stride            __IB,
    const DSPSplitComplex *__C,
    vDSP_Stride            __IC,
    vDSP_Length            __N,
    int                    __Conjugate)
        __OSX_AVAILABLE_STARTING(__MAC_10_0, __IPHONE_4_0);
extern void vDSP_zvmulD(
    const DSPDoubleSplitComplex *__A,
    vDSP_Stride                  __IA,
    const DSPDoubleSplitComplex *__B,
    vDSP_Stride                  __IB,
    const DSPDoubleSplitComplex *__C,
    vDSP_Stride                  __IC,
    vDSP_Length                  __N,
    int                          __Conjugate)
        __OSX_AVAILABLE_STARTING(__MAC_10_2, __IPHONE_4_0);
extern void vDSP_zidotpr(
    const DSPSplitComplex *__A,
    vDSP_Stride            __IA,
    const DSPSplitComplex *__B,
    vDSP_Stride            __IB,
    const DSPSplitComplex *__C,
    vDSP_Length            __N)
        __OSX_AVAILABLE_STARTING(__MAC_10_0, __IPHONE_4_0);
extern void vDSP_zidotprD(
    const DSPDoubleSplitComplex *__A,
    vDSP_Stride                  __IA,
    const DSPDoubleSplitComplex *__B,
    vDSP_Stride                  __IB,
    const DSPDoubleSplitComplex *__C,
    vDSP_Length                  __N)
        __OSX_AVAILABLE_STARTING(__MAC_10_2, __IPHONE_4_0);
extern void vDSP_zvcma(
    const DSPSplitComplex *__A,
    vDSP_Stride            __IA,
    const DSPSplitComplex *__B,
    vDSP_Stride            __IB,
    const DSPSplitComplex *__C,
    vDSP_Stride            __IC,
    const DSPSplitComplex *__D,
    vDSP_Stride            __ID,
    vDSP_Length            __N)
        __OSX_AVAILABLE_STARTING(__MAC_10_0, __IPHONE_4_0);
extern void vDSP_zvcmaD(
    const DSPDoubleSplitComplex *__A,
    vDSP_Stride                  __IA,
    const DSPDoubleSplitComplex *__B,
    vDSP_Stride                  __IB,
    const DSPDoubleSplitComplex *__C,
    vDSP_Stride                  __IC,
    const DSPDoubleSplitComplex *__D,
    vDSP_Stride                  __ID,
    vDSP_Length                  __N)
        __OSX_AVAILABLE_STARTING(__MAC_10_2, __IPHONE_4_0);
extern void vDSP_zrvsub(
    const DSPSplitComplex *__A,
    vDSP_Stride            __IA,
    const float           *__B,
    vDSP_Stride            __IB,
    const DSPSplitComplex *__C,
    vDSP_Stride            __IC,
    vDSP_Length            __N)
        __OSX_AVAILABLE_STARTING(__MAC_10_0, __IPHONE_4_0);
extern void vDSP_zrvsubD(
    const DSPDoubleSplitComplex *__A,
    vDSP_Stride                  __IA,
    const double                *__B,
    vDSP_Stride                  __IB,
    const DSPDoubleSplitComplex *__C,
    vDSP_Stride                  __IC,
    vDSP_Length                  __N)
        __OSX_AVAILABLE_STARTING(__MAC_10_2, __IPHONE_4_0);
extern void vDSP_vdpsp(
    const double *__A,
    vDSP_Stride   __IA,
    float        *__C,
    vDSP_Stride   __IC,
    vDSP_Length   __N)
        __OSX_AVAILABLE_STARTING(__MAC_10_4, __IPHONE_4_0);
extern void vDSP_vspdp(
    const float *__A,
    vDSP_Stride  __IA,
    double      *__C,
    vDSP_Stride  __IC,
    vDSP_Length  __N)
        __OSX_AVAILABLE_STARTING(__MAC_10_4, __IPHONE_4_0);
extern void vDSP_vabs(
    const float *__A,
    vDSP_Stride  __IA,
    float       *__C,
    vDSP_Stride  __IC,
    vDSP_Length  __N)
        __OSX_AVAILABLE_STARTING(__MAC_10_4, __IPHONE_4_0);
extern void vDSP_vabsD(
    const double *__A,
    vDSP_Stride   __IA,
    double       *__C,
    vDSP_Stride   __IC,
    vDSP_Length   __N)
        __OSX_AVAILABLE_STARTING(__MAC_10_4, __IPHONE_4_0);
extern void vDSP_vabsi(
    const int   *__A,
    vDSP_Stride  __IA,
    int         *__C,
    vDSP_Stride  __IC,
    vDSP_Length  __N)
        __OSX_AVAILABLE_STARTING(__MAC_10_4, __IPHONE_4_0);
extern void vDSP_zvabs(
    const DSPSplitComplex *__A,
    vDSP_Stride            __IA,
    float                 *__C,
    vDSP_Stride            __IC,
    vDSP_Length            __N)
        __OSX_AVAILABLE_STARTING(__MAC_10_4, __IPHONE_4_0);
extern void vDSP_zvabsD(
    const DSPDoubleSplitComplex *__A,
    vDSP_Stride                  __IA,
    double                      *__C,
    vDSP_Stride                  __IC,
    vDSP_Length                  __N)
        __OSX_AVAILABLE_STARTING(__MAC_10_4, __IPHONE_4_0);
extern void vDSP_veqvi(
    const int   *__A,
    vDSP_Stride  __IA,
    const int   *__B,
    vDSP_Stride  __IB,
    int         *__C,
    vDSP_Stride  __IC,
    vDSP_Length  __N)
        __OSX_AVAILABLE_STARTING(__MAC_10_4, __IPHONE_4_0);
extern void vDSP_vfill(
    const float *__A,
    float       *__C,
    vDSP_Stride  __IC,
    vDSP_Length  __N)
        __OSX_AVAILABLE_STARTING(__MAC_10_4, __IPHONE_4_0);
extern void vDSP_vfillD(
    const double *__A,
    double       *__C,
    vDSP_Stride   __IC,
    vDSP_Length   __N)
        __OSX_AVAILABLE_STARTING(__MAC_10_4, __IPHONE_4_0);
extern void vDSP_vfilli(
    const int   *__A,
    int         *__C,
    vDSP_Stride  __IC,
    vDSP_Length  __N)
        __OSX_AVAILABLE_STARTING(__MAC_10_4, __IPHONE_4_0);
extern void vDSP_zvfill(
    const DSPSplitComplex *__A,
    const DSPSplitComplex *__C,
    vDSP_Stride            __IC,
    vDSP_Length            __N)
        __OSX_AVAILABLE_STARTING(__MAC_10_4, __IPHONE_4_0);
extern void vDSP_zvfillD(
    const DSPDoubleSplitComplex *__A,
    const DSPDoubleSplitComplex *__C,
    vDSP_Stride                  __IC,
    vDSP_Length                  __N)
        __OSX_AVAILABLE_STARTING(__MAC_10_4, __IPHONE_4_0);
extern void vDSP_vsadd(
    const float *__A,
    vDSP_Stride  __IA,
    const float *__B,
    float       *__C,
    vDSP_Stride  __IC,
    vDSP_Length  __N)
        __OSX_AVAILABLE_STARTING(__MAC_10_4, __IPHONE_4_0);
extern void vDSP_vsaddD(
    const double *__A,
    vDSP_Stride   __IA,
    const double *__B,
    double       *__C,
    vDSP_Stride   __IC,
    vDSP_Length   __N)
        __OSX_AVAILABLE_STARTING(__MAC_10_4, __IPHONE_4_0);
extern void vDSP_vsaddi(
    const int   *__A,
    vDSP_Stride  __IA,
    const int   *__B,
    int         *__C,
    vDSP_Stride  __IC,
    vDSP_Length  __N)
        __OSX_AVAILABLE_STARTING(__MAC_10_4, __IPHONE_4_0);
extern void vDSP_vsdiv(
    const float *__A,
    vDSP_Stride  __IA,
    const float *__B,
    float       *__C,
    vDSP_Stride  __IC,
    vDSP_Length  __N)
        __OSX_AVAILABLE_STARTING(__MAC_10_4, __IPHONE_4_0);
extern void vDSP_vsdivD(
    const double *__A,
    vDSP_Stride   __IA,
    const double *__B,
    double       *__C,
    vDSP_Stride   __IC,
    vDSP_Length   __N)
        __OSX_AVAILABLE_STARTING(__MAC_10_4, __IPHONE_4_0);
extern void vDSP_vsdivi(
    const int   *__A,
    vDSP_Stride  __IA,
    const int   *__B,
    int         *__C,
    vDSP_Stride  __IC,
    vDSP_Length  __N)
        __OSX_AVAILABLE_STARTING(__MAC_10_4, __IPHONE_4_0);
extern void vDSP_zaspec(
    const DSPSplitComplex *__A,
    float                 *__C,
    vDSP_Length            __N)
        __OSX_AVAILABLE_STARTING(__MAC_10_4, __IPHONE_4_0);
extern void vDSP_zaspecD(
    const DSPDoubleSplitComplex *__A,
    double                      *__C,
    vDSP_Length                  __N)
        __OSX_AVAILABLE_STARTING(__MAC_10_4, __IPHONE_4_0);
extern void vDSP_blkman_window(
    float       *__C,
    vDSP_Length  __N,
    int          __Flag)
        __OSX_AVAILABLE_STARTING(__MAC_10_4, __IPHONE_4_0);
extern void vDSP_blkman_windowD(
    double      *__C,
    vDSP_Length  __N,
    int          __Flag)
        __OSX_AVAILABLE_STARTING(__MAC_10_4, __IPHONE_4_0);
extern void vDSP_zcoher(
    const float           *__A,
    const float           *__B,
    const DSPSplitComplex *__C,
    float                 *__D,
    vDSP_Length            __N)
        __OSX_AVAILABLE_STARTING(__MAC_10_4, __IPHONE_4_0);
extern void vDSP_zcoherD(
    const double                *__A,
    const double                *__B,
    const DSPDoubleSplitComplex *__C,
    double                      *__D,
    vDSP_Length                  __N)
        __OSX_AVAILABLE_STARTING(__MAC_10_4, __IPHONE_4_0);
extern void vDSP_desamp(
    const float *__A,   
    vDSP_Stride  __DF,  
    const float *__F,   
    float       *__C,   
    vDSP_Length  __N,   
    vDSP_Length  __P)   
        __OSX_AVAILABLE_STARTING(__MAC_10_4, __IPHONE_4_0);
extern void vDSP_desampD(
    const double *__A,  
    vDSP_Stride   __DF, 
    const double *__F,  
    double       *__C,  
    vDSP_Length   __N,  
    vDSP_Length   __P)  
        __OSX_AVAILABLE_STARTING(__MAC_10_4, __IPHONE_4_0);
extern void vDSP_zrdesamp(
    const DSPSplitComplex *__A,  
    vDSP_Stride            __DF, 
    const float           *__F,  
    const DSPSplitComplex *__C,  
    vDSP_Length            __N,  
    vDSP_Length            __P)  
        __OSX_AVAILABLE_STARTING(__MAC_10_4, __IPHONE_4_0);
extern void vDSP_zrdesampD(
    const DSPDoubleSplitComplex *__A,    
    vDSP_Stride                  __DF,   
    const double                *__F,    
    const DSPDoubleSplitComplex *__C,    
    vDSP_Length                  __N,    
    vDSP_Length                  __P)    
        __OSX_AVAILABLE_STARTING(__MAC_10_4, __IPHONE_4_0);
extern void vDSP_ztrans(
    const float           *__A,
    const DSPSplitComplex *__B,
    const DSPSplitComplex *__C,
    vDSP_Length            __N)
        __OSX_AVAILABLE_STARTING(__MAC_10_4, __IPHONE_4_0);
extern void vDSP_ztransD(
    const double                *__A,
    const DSPDoubleSplitComplex *__B,
    const DSPDoubleSplitComplex *__C,
    vDSP_Length                  __N)
        __OSX_AVAILABLE_STARTING(__MAC_10_4, __IPHONE_4_0);
extern void vDSP_zcspec(
    const DSPSplitComplex *__A,
    const DSPSplitComplex *__B,
    const DSPSplitComplex *__C,
    vDSP_Length            __N)
        __OSX_AVAILABLE_STARTING(__MAC_10_4, __IPHONE_4_0);
extern void vDSP_zcspecD(
    const DSPDoubleSplitComplex *__A,
    const DSPDoubleSplitComplex *__B,
    const DSPDoubleSplitComplex *__C,
    vDSP_Length                  __N)
        __OSX_AVAILABLE_STARTING(__MAC_10_4, __IPHONE_4_0);
extern void vDSP_zvcmul(
    const DSPSplitComplex *__A,
    vDSP_Stride            __IA,
    const DSPSplitComplex *__B,
    vDSP_Stride            __IB,
    const DSPSplitComplex *__C,
    vDSP_Stride            __IC,
    vDSP_Length            __N)
        __OSX_AVAILABLE_STARTING(__MAC_10_4, __IPHONE_4_0);
extern void vDSP_zvcmulD(
    const DSPDoubleSplitComplex *__A,
    vDSP_Stride                  __IA,
    const DSPDoubleSplitComplex *__B,
    vDSP_Stride                  __IB,
    const DSPDoubleSplitComplex *__C,
    vDSP_Stride                  __iC,
    vDSP_Length                  __N)
        __OSX_AVAILABLE_STARTING(__MAC_10_4, __IPHONE_4_0);
extern void vDSP_zvconj(
    const DSPSplitComplex *__A,
    vDSP_Stride            __IA,
    const DSPSplitComplex *__C,
    vDSP_Stride            __IC,
    vDSP_Length            __N)
        __OSX_AVAILABLE_STARTING(__MAC_10_4, __IPHONE_4_0);
extern void vDSP_zvconjD(
    const DSPDoubleSplitComplex *__A,
    vDSP_Stride                  __IA,
    const DSPDoubleSplitComplex *__C,
    vDSP_Stride                  __IC,
    vDSP_Length                  __N)
        __OSX_AVAILABLE_STARTING(__MAC_10_4, __IPHONE_4_0);
extern void vDSP_zvzsml(
    const DSPSplitComplex *__A,
    vDSP_Stride            __IA,
    const DSPSplitComplex *__B,
    const DSPSplitComplex *__C,
    vDSP_Stride            __IC,
    vDSP_Length            __N)
        __OSX_AVAILABLE_STARTING(__MAC_10_4, __IPHONE_4_0);
extern void vDSP_zvzsmlD(
    const DSPDoubleSplitComplex *__A,
    vDSP_Stride                  __IA,
    const DSPDoubleSplitComplex *__B,
    const DSPDoubleSplitComplex *__C,
    vDSP_Stride                  __IC,
    vDSP_Length                  __N)
        __OSX_AVAILABLE_STARTING(__MAC_10_4, __IPHONE_4_0);
extern void vDSP_zvmags(
    const DSPSplitComplex *__A,
    vDSP_Stride            __IA,
    float                 *__C,
    vDSP_Stride            __IC,
    vDSP_Length            __N)
        __OSX_AVAILABLE_STARTING(__MAC_10_4, __IPHONE_4_0);
extern void vDSP_zvmagsD(
    const DSPDoubleSplitComplex *__A,
    vDSP_Stride                  __IA,
    double                      *__C,
    vDSP_Stride                  __IC,
    vDSP_Length                  __N)
        __OSX_AVAILABLE_STARTING(__MAC_10_4, __IPHONE_4_0);
extern void vDSP_zvmgsa(
    const DSPSplitComplex *__A,
    vDSP_Stride            __IA,
    const float           *__B,
    vDSP_Stride            __IB,
    float                 *__C,
    vDSP_Stride            __IC,
    vDSP_Length            __N)
        __OSX_AVAILABLE_STARTING(__MAC_10_4, __IPHONE_4_0);
extern void vDSP_zvmgsaD(
    const DSPDoubleSplitComplex *__A,
    vDSP_Stride                  __IA,
    const double                *__B,
    vDSP_Stride                  __IB,
    double                      *__C,
    vDSP_Stride                  __IC,
    vDSP_Length                  __N)
        __OSX_AVAILABLE_STARTING(__MAC_10_4, __IPHONE_4_0);
extern void vDSP_zvmov(
    const DSPSplitComplex *__A,
    vDSP_Stride            __IA,
    const DSPSplitComplex *__C,
    vDSP_Stride            __IC,
    vDSP_Length            __N)
        __OSX_AVAILABLE_STARTING(__MAC_10_4, __IPHONE_4_0);
extern void vDSP_zvmovD(
    const DSPDoubleSplitComplex *__A,
    vDSP_Stride                  __IA,
    const DSPDoubleSplitComplex *__C,
    vDSP_Stride                  __IC,
    vDSP_Length                  __N)
        __OSX_AVAILABLE_STARTING(__MAC_10_4, __IPHONE_4_0);
extern void vDSP_zvneg(
    const DSPSplitComplex *__A,
    vDSP_Stride            __IA,
    const DSPSplitComplex *__C,
    vDSP_Stride            __IC,
    vDSP_Length            __N)
        __OSX_AVAILABLE_STARTING(__MAC_10_4, __IPHONE_4_0);
extern void vDSP_zvnegD(
    const DSPDoubleSplitComplex *__A,
    vDSP_Stride                  __IA,
    const DSPDoubleSplitComplex *__C,
    vDSP_Stride                  __IC,
    vDSP_Length                  __N)
        __OSX_AVAILABLE_STARTING(__MAC_10_4, __IPHONE_4_0);
extern void vDSP_zvphas(
    const DSPSplitComplex *__A,
    vDSP_Stride            __IA,
    float                 *__C,
    vDSP_Stride            __IC,
    vDSP_Length            __N)
        __OSX_AVAILABLE_STARTING(__MAC_10_4, __IPHONE_4_0);
extern void vDSP_zvphasD(
    const DSPDoubleSplitComplex *__A,
    vDSP_Stride                  __IA,
    double                      *__C,
    vDSP_Stride                  __IC,
    vDSP_Length                  __N)
        __OSX_AVAILABLE_STARTING(__MAC_10_4, __IPHONE_4_0);
extern void vDSP_zvsma(
    const DSPSplitComplex *__A,
    vDSP_Stride            __IA,
    const DSPSplitComplex *__B,
    const DSPSplitComplex *__C,
    vDSP_Stride            __IC,
    const DSPSplitComplex *__D,
    vDSP_Stride            __ID,
    vDSP_Length            __N)
        __OSX_AVAILABLE_STARTING(__MAC_10_4, __IPHONE_4_0);
extern void vDSP_zvsmaD(
    const DSPDoubleSplitComplex *__A,
    vDSP_Stride                  __IA,
    const DSPDoubleSplitComplex *__B,
    const DSPDoubleSplitComplex *__C,
    vDSP_Stride                  __IC,
    const DSPDoubleSplitComplex *__D,
    vDSP_Stride                  __ID,
    vDSP_Length                  __N)
        __OSX_AVAILABLE_STARTING(__MAC_10_4, __IPHONE_4_0);
extern void vDSP_deq22(
    const float *__A,
    vDSP_Stride  __IA,
    const float *__B,
    float       *__C,
    vDSP_Stride  __IC,
    vDSP_Length  __N)
        __OSX_AVAILABLE_STARTING(__MAC_10_4, __IPHONE_4_0);
extern void vDSP_deq22D(
    const double *__A,
    vDSP_Stride   __IA,
    const double *__B,
    double       *__C,
    vDSP_Stride   __IC,
    vDSP_Length   __N)
        __OSX_AVAILABLE_STARTING(__MAC_10_4, __IPHONE_4_0);
extern void vDSP_hamm_window(
    float       *__C,
    vDSP_Length  __N,
    int          __Flag)
        __OSX_AVAILABLE_STARTING(__MAC_10_4, __IPHONE_4_0);
extern void vDSP_hamm_windowD(
    double      *__C,
    vDSP_Length  __N,
    int          __Flag)
        __OSX_AVAILABLE_STARTING(__MAC_10_4, __IPHONE_4_0);
extern void vDSP_hann_window(
    float       *__C,
    vDSP_Length  __N,
    int          __Flag)
        __OSX_AVAILABLE_STARTING(__MAC_10_4, __IPHONE_4_0);
extern void vDSP_hann_windowD(
    double      *__C,
    vDSP_Length  __N,
    int          __Flag)
        __OSX_AVAILABLE_STARTING(__MAC_10_4, __IPHONE_4_0);
extern void vDSP_maxmgv(
    const float *__A,
    vDSP_Stride  __IA,
    float       *__C,
    vDSP_Length  __N)
        __OSX_AVAILABLE_STARTING(__MAC_10_4, __IPHONE_4_0);
extern void vDSP_maxmgvD(
    const double *__A,
    vDSP_Stride   __IA,
    double       *__C,
    vDSP_Length   __N)
        __OSX_AVAILABLE_STARTING(__MAC_10_4, __IPHONE_4_0);
extern void vDSP_maxmgvi(
    const float *__A,
    vDSP_Stride  __IA,
    float       *__C,
    vDSP_Length *__I,
    vDSP_Length  __N)
        __OSX_AVAILABLE_STARTING(__MAC_10_4, __IPHONE_4_0);
extern void vDSP_maxmgviD(
    const double *__A,
    vDSP_Stride   __IA,
    double       *__C,
    vDSP_Length  *__I,
    vDSP_Length   __N)
        __OSX_AVAILABLE_STARTING(__MAC_10_4, __IPHONE_4_0);
extern void vDSP_maxv(
    const float *__A,
    vDSP_Stride  __IA,
    float       *__C,
    vDSP_Length  __N)
        __OSX_AVAILABLE_STARTING(__MAC_10_4, __IPHONE_4_0);
extern void vDSP_maxvD(
    const double *__A,
    vDSP_Stride   __I,
    double       *__C,
    vDSP_Length   __N)
        __OSX_AVAILABLE_STARTING(__MAC_10_4, __IPHONE_4_0);
extern void vDSP_maxvi(
    const float *__A,
    vDSP_Stride  __IA,
    float       *__C,
    vDSP_Length *__I,
    vDSP_Length  __N)
        __OSX_AVAILABLE_STARTING(__MAC_10_4, __IPHONE_4_0);
extern void vDSP_maxviD(
    const double *__A,
    vDSP_Stride   __IA,
    double       *__C,
    vDSP_Length  *__I,
    vDSP_Length   __N)
        __OSX_AVAILABLE_STARTING(__MAC_10_4, __IPHONE_4_0);
extern void vDSP_meamgv(
    const float *__A,
    vDSP_Stride  __IA,
    float       *__C,
    vDSP_Length  __N)
        __OSX_AVAILABLE_STARTING(__MAC_10_4, __IPHONE_4_0);
extern void vDSP_meamgvD(
    const double *__A,
    vDSP_Stride   __IA,
    double       *__C,
    vDSP_Length   __N)
        __OSX_AVAILABLE_STARTING(__MAC_10_4, __IPHONE_4_0);
extern void vDSP_meanv(
    const float *__A,
    vDSP_Stride  __IA,
    float       *__C,
    vDSP_Length  __N)
        __OSX_AVAILABLE_STARTING(__MAC_10_4, __IPHONE_4_0);
extern void vDSP_meanvD(
    const double *__A,
    vDSP_Stride   __IA,
    double       *__C,
    vDSP_Length   __N)
        __OSX_AVAILABLE_STARTING(__MAC_10_4, __IPHONE_4_0);
extern void vDSP_measqv(
    const float *__A,
    vDSP_Stride  __IA,
    float       *__C,
    vDSP_Length  __N)
        __OSX_AVAILABLE_STARTING(__MAC_10_4, __IPHONE_4_0);
extern void vDSP_measqvD(
    const double *__A,
    vDSP_Stride   __I,
    double       *__C,
    vDSP_Length   __N)
        __OSX_AVAILABLE_STARTING(__MAC_10_4, __IPHONE_4_0);
extern void vDSP_minmgv(
    const float *__A,
    vDSP_Stride  __IA,
    float       *__C,
    vDSP_Length  __N)
        __OSX_AVAILABLE_STARTING(__MAC_10_4, __IPHONE_4_0);
extern void vDSP_minmgvD(
    const double *__A,
    vDSP_Stride   __IA,
    double       *__C,
    vDSP_Length   __N)
        __OSX_AVAILABLE_STARTING(__MAC_10_4, __IPHONE_4_0);
extern void vDSP_minmgvi(
    const float *__A,
    vDSP_Stride  __IA,
    float       *__C,
    vDSP_Length *__I,
    vDSP_Length  __N)
        __OSX_AVAILABLE_STARTING(__MAC_10_4, __IPHONE_4_0);
extern void vDSP_minmgviD(
    const double *__A,
    vDSP_Stride   __IA,
    double       *__C,
    vDSP_Length  *__I,
    vDSP_Length   __N)
        __OSX_AVAILABLE_STARTING(__MAC_10_4, __IPHONE_4_0);
extern void vDSP_minv(
    const float *__A,
    vDSP_Stride  __IA,
    float       *__C,
    vDSP_Length  __N)
        __OSX_AVAILABLE_STARTING(__MAC_10_4, __IPHONE_4_0);
extern void vDSP_minvD(
    const double *__A,
    vDSP_Stride   __IA,
    double       *__C,
    vDSP_Length   __N)
        __OSX_AVAILABLE_STARTING(__MAC_10_4, __IPHONE_4_0);
extern void vDSP_minvi(
    const float *__A,
    vDSP_Stride  __IA,
    float       *__C,
    vDSP_Length *__I,
    vDSP_Length  __N)
        __OSX_AVAILABLE_STARTING(__MAC_10_4, __IPHONE_4_0);
extern void vDSP_minviD(
    const double *__A,
    vDSP_Stride   __IA,
    double       *__C,
    vDSP_Length  *__I,
    vDSP_Length   __N)
        __OSX_AVAILABLE_STARTING(__MAC_10_4, __IPHONE_4_0);
extern void vDSP_mmov(
    const float *__A,
    float       *__C,
    vDSP_Length  __M,
    vDSP_Length  __N,
    vDSP_Length  __TA,
    vDSP_Length  __TC)
        __OSX_AVAILABLE_STARTING(__MAC_10_4, __IPHONE_4_0);
extern void vDSP_mmovD(
    const double *__A,
    double       *__C,
    vDSP_Length   __M,
    vDSP_Length   __N,
    vDSP_Length   __TA,
    vDSP_Length   __TC)
        __OSX_AVAILABLE_STARTING(__MAC_10_4, __IPHONE_4_0);
extern void vDSP_mvessq(
    const float *__A,
    vDSP_Stride  __IA,
    float       *__C,
    vDSP_Length  __N)
        __OSX_AVAILABLE_STARTING(__MAC_10_4, __IPHONE_4_0);
extern void vDSP_mvessqD(
    const double *__A,
    vDSP_Stride   __IA,
    double       *__C,
    vDSP_Length   __N)
        __OSX_AVAILABLE_STARTING(__MAC_10_4, __IPHONE_4_0);
extern void vDSP_nzcros(
    const float *__A,
    vDSP_Stride  __IA,
    vDSP_Length  __B,
    vDSP_Length *__C,
    vDSP_Length *__D,
    vDSP_Length  __N)
        __OSX_AVAILABLE_STARTING(__MAC_10_4, __IPHONE_4_0);
extern void vDSP_nzcrosD(
    const double *__A,
    vDSP_Stride   __IA,
    vDSP_Length   __B,
    vDSP_Length  *__C,
    vDSP_Length  *__D,
    vDSP_Length   __N)
        __OSX_AVAILABLE_STARTING(__MAC_10_4, __IPHONE_4_0);
extern void vDSP_polar(
    const float *__A,
    vDSP_Stride  __IA,
    float       *__C,
    vDSP_Stride  __IC,
    vDSP_Length  __N)
        __OSX_AVAILABLE_STARTING(__MAC_10_4, __IPHONE_4_0);
extern void vDSP_polarD(
    const double *__A,
    vDSP_Stride   __IA,
    double       *__C,
    vDSP_Stride   __IC,
    vDSP_Length   __N)
        __OSX_AVAILABLE_STARTING(__MAC_10_4, __IPHONE_4_0);
extern void vDSP_rect(
    const float *__A,
    vDSP_Stride  __IA,
    float       *__C,
    vDSP_Stride  __IC,
    vDSP_Length  __N)
        __OSX_AVAILABLE_STARTING(__MAC_10_4, __IPHONE_4_0);
extern void vDSP_rectD(
    const double *__A,
    vDSP_Stride   __IA,
    double       *__C,
    vDSP_Stride   __IC,
    vDSP_Length   __N)
        __OSX_AVAILABLE_STARTING(__MAC_10_4, __IPHONE_4_0);
extern void vDSP_rmsqv(
    const float *__A,
    vDSP_Stride  __IA,
    float       *__C,
    vDSP_Length  __N)
        __OSX_AVAILABLE_STARTING(__MAC_10_4, __IPHONE_4_0);
extern void vDSP_rmsqvD(
    const double *__A,
    vDSP_Stride   __IA,
    double       *__C,
    vDSP_Length   __N)
        __OSX_AVAILABLE_STARTING(__MAC_10_4, __IPHONE_4_0);
extern void vDSP_svdiv(
    const float *__A,
    const float *__B,
    vDSP_Stride  __IB,
    float       *__C,
    vDSP_Stride  __IC,
    vDSP_Length  __N)
        __OSX_AVAILABLE_STARTING(__MAC_10_4, __IPHONE_4_0);
extern void vDSP_svdivD(
    const double *__A,
    const double *__B,
    vDSP_Stride   __IB,
    double       *__C,
    vDSP_Stride   __IC,
    vDSP_Length   __N)
        __OSX_AVAILABLE_STARTING(__MAC_10_4, __IPHONE_4_0);
extern void vDSP_sve(
    const float *__A,
    vDSP_Stride  __I,
    float       *__C,
    vDSP_Length  __N)
        __OSX_AVAILABLE_STARTING(__MAC_10_4, __IPHONE_4_0);
extern void vDSP_sveD(
    const double *__A,
    vDSP_Stride   __I,
    double       *__C,
    vDSP_Length   __N)
        __OSX_AVAILABLE_STARTING(__MAC_10_4, __IPHONE_4_0);
extern void vDSP_svemg(
    const float *__A,
    vDSP_Stride  __IA,
    float       *__C,
    vDSP_Length  __N)
        __OSX_AVAILABLE_STARTING(__MAC_10_4, __IPHONE_4_0);
extern void vDSP_svemgD(
    const double *__A,
    vDSP_Stride   __IA,
    double       *__C,
    vDSP_Length   __N)
        __OSX_AVAILABLE_STARTING(__MAC_10_4, __IPHONE_4_0);
extern void vDSP_svesq(
    const float *__A,
    vDSP_Stride  __IA,
    float       *__C,
    vDSP_Length  __N)
        __OSX_AVAILABLE_STARTING(__MAC_10_4, __IPHONE_4_0);
extern void vDSP_svesqD(
    const double *__A,
    vDSP_Stride   __IA,
    double       *__C,
    vDSP_Length   __N)
        __OSX_AVAILABLE_STARTING(__MAC_10_4, __IPHONE_4_0);
extern void vDSP_sve_svesq(
    const float  *__A,
    vDSP_Stride   __IA,
    float        *__Sum,
    float        *__SumOfSquares,
    vDSP_Length   __N)
        __OSX_AVAILABLE_STARTING(__MAC_10_8, __IPHONE_6_0);
extern void vDSP_sve_svesqD(
    const double *__A,
    vDSP_Stride   __IA,
    double       *__Sum,
    double       *__SumOfSquares,
    vDSP_Length   __N)
        __OSX_AVAILABLE_STARTING(__MAC_10_8, __IPHONE_6_0);
#if (defined __IPHONE_OS_VERSION_MIN_REQUIRED && __IPHONE_OS_VERSION_MIN_REQUIRED < 90000) || \
     (defined __MAC_OS_X_VERSION_MIN_REQUIRED && __MAC_OS_X_VERSION_MIN_REQUIRED < 101100)
    extern void vDSP_normalize(
        const float  *__A,
        vDSP_Stride   __IA,
        float        *__C,
        vDSP_Stride   __IC,
        float        *__Mean,
        float        *__StandardDeviation,
        vDSP_Length   __N)
            __OSX_AVAILABLE_STARTING(__MAC_10_8, __IPHONE_6_0);
    extern void vDSP_normalizeD(
        const double *__A,
        vDSP_Stride   __IA,
        double       *__C,
        vDSP_Stride   __IC,
        double       *__Mean,
        double       *__StandardDeviation,
        vDSP_Length   __N)
            __OSX_AVAILABLE_STARTING(__MAC_10_8, __IPHONE_6_0);
#else
    extern void vDSP_normalize(
        const float       *__A,
        vDSP_Stride        __IA,
        float * __nullable __C,
        vDSP_Stride        __IC,
        float             *__Mean,
        float             *__StandardDeviation,
        vDSP_Length        __N)
            __OSX_AVAILABLE_STARTING(__MAC_10_8, __IPHONE_6_0);
    extern void vDSP_normalizeD(
        const double       *__A,
        vDSP_Stride         __IA,
        double * __nullable __C,
        vDSP_Stride         __IC,
        double             *__Mean,
        double             *__StandardDeviation,
        vDSP_Length         __N)
            __OSX_AVAILABLE_STARTING(__MAC_10_8, __IPHONE_6_0);
#endif
extern void vDSP_svs(
    const float *__A,
    vDSP_Stride  __IA,
    float       *__C,
    vDSP_Length  __N)
        __OSX_AVAILABLE_STARTING(__MAC_10_4, __IPHONE_4_0);
extern void vDSP_svsD(
    const double *__A,
    vDSP_Stride   __IA,
    double       *__C,
    vDSP_Length   __N)
        __OSX_AVAILABLE_STARTING(__MAC_10_4, __IPHONE_4_0);
extern void vDSP_vaam(
    const float *__A,
    vDSP_Stride  __IA,
    const float *__B,
    vDSP_Stride  __IB,
    const float *__C,
    vDSP_Stride  __IC,
    const float *__D,
    vDSP_Stride  __ID,
    float       *__E,
    vDSP_Stride  __IE,
    vDSP_Length  __N)
        __OSX_AVAILABLE_STARTING(__MAC_10_4, __IPHONE_4_0);
extern void vDSP_vaamD(
    const double *__A,
    vDSP_Stride   __IA,
    const double *__B,
    vDSP_Stride   __IB,
    const double *__C,
    vDSP_Stride   __IC,
    const double *__D,
    vDSP_Stride   __ID,
    double       *__E,
    vDSP_Stride   __IE,
    vDSP_Length   __N)
        __OSX_AVAILABLE_STARTING(__MAC_10_4, __IPHONE_4_0);
extern void vDSP_vasbm(
    const float *__A,
    vDSP_Stride  __IA,
    const float *__B,
    vDSP_Stride  __IB,
    const float *__C,
    vDSP_Stride  __IC,
    const float *__D,
    vDSP_Stride  __ID,
    float       *__E,
    vDSP_Stride  __IE,
    vDSP_Length  __N)
        __OSX_AVAILABLE_STARTING(__MAC_10_4, __IPHONE_4_0);
extern void vDSP_vasbmD(
    const double *__A,
    vDSP_Stride   __IA,
    const double *__B,
    vDSP_Stride   __IB,
    const double *__C,
    vDSP_Stride   __IC,
    const double *__D,
    vDSP_Stride   __ID,
    double       *__E,
    vDSP_Stride   __IE,
    vDSP_Length   __N)
        __OSX_AVAILABLE_STARTING(__MAC_10_4, __IPHONE_4_0);
extern void vDSP_vasm(
    const float *__A,
    vDSP_Stride  __IA,
    const float *__B,
    vDSP_Stride  __IB,
    const float *__C,
    float       *__D,
    vDSP_Stride  __ID,
    vDSP_Length  __N)
        __OSX_AVAILABLE_STARTING(__MAC_10_4, __IPHONE_4_0);
extern void vDSP_vasmD(
    const double *__A,
    vDSP_Stride   __IA,
    const double *__B,
    vDSP_Stride   __IB,
    const double *__C,
    double       *__D,
    vDSP_Stride   __ID,
    vDSP_Length   __N)
        __OSX_AVAILABLE_STARTING(__MAC_10_4, __IPHONE_4_0);
extern void vDSP_vavlin(
    const float *__A,
    vDSP_Stride  __IA,
    const float *__B,
    float       *__C,
    vDSP_Stride  __IC,
    vDSP_Length  __N)
        __OSX_AVAILABLE_STARTING(__MAC_10_4, __IPHONE_4_0);
extern void vDSP_vavlinD(
    const double *__A,
    vDSP_Stride   __IA,
    const double *__B,
    double       *__C,
    vDSP_Stride   __IC,
    vDSP_Length   __N)
        __OSX_AVAILABLE_STARTING(__MAC_10_4, __IPHONE_4_0);
extern void vDSP_vclip(
    const float *__A,
    vDSP_Stride  __IA,
    const float *__B,
    const float *__C,
    float       *__D,
    vDSP_Stride  __ID,
    vDSP_Length  __N)
        __OSX_AVAILABLE_STARTING(__MAC_10_4, __IPHONE_4_0);
extern void vDSP_vclipD(
    const double *__A,
    vDSP_Stride   __IA,
    const double *__B,
    const double *__C,
    double       *__D,
    vDSP_Stride   __ID,
    vDSP_Length   __N)
        __OSX_AVAILABLE_STARTING(__MAC_10_4, __IPHONE_4_0);
extern void vDSP_vclipc(
    const float *__A,
    vDSP_Stride  __IA,
    const float *__B,
    const float *__C,
    float       *__D,
    vDSP_Stride  __ID,
    vDSP_Length  __N,
    vDSP_Length *__NLow,
    vDSP_Length *__NHigh)
        __OSX_AVAILABLE_STARTING(__MAC_10_4, __IPHONE_4_0);
extern void vDSP_vclipcD(
    const double *__A,
    vDSP_Stride   __IA,
    const double *__B,
    const double *__C,
    double       *__D,
    vDSP_Stride   __ID,
    vDSP_Length   __N,
    vDSP_Length  *__NLow,
    vDSP_Length  *__NHigh)
        __OSX_AVAILABLE_STARTING(__MAC_10_4, __IPHONE_4_0);
extern void vDSP_vclr(
    float       *__C,
    vDSP_Stride  __IC,
    vDSP_Length  __N)
        __OSX_AVAILABLE_STARTING(__MAC_10_4, __IPHONE_4_0);
extern void vDSP_vclrD(
    double      *__C,
    vDSP_Stride  __IC,
    vDSP_Length  __N)
        __OSX_AVAILABLE_STARTING(__MAC_10_4, __IPHONE_4_0);
extern void vDSP_vcmprs(
    const float *__A,
    vDSP_Stride  __IA,
    const float *__B,
    vDSP_Stride  __IB,
    float       *__C,
    vDSP_Stride  __IC,
    vDSP_Length  __N)
        __OSX_AVAILABLE_STARTING(__MAC_10_4, __IPHONE_4_0);
extern void vDSP_vcmprsD(
    const double *__A,
    vDSP_Stride   __IA,
    const double *__B,
    vDSP_Stride   __IB,
    double       *__C,
    vDSP_Stride   __IC,
    vDSP_Length   __N)
        __OSX_AVAILABLE_STARTING(__MAC_10_4, __IPHONE_4_0);
extern void vDSP_vdbcon(
    const float *__A,
    vDSP_Stride  __IA,
    const float *__B,
    float       *__C,
    vDSP_Stride  __IC,
    vDSP_Length  __N,
    unsigned int __F)
        __OSX_AVAILABLE_STARTING(__MAC_10_4, __IPHONE_4_0);
extern void vDSP_vdbconD(
    const double *__A,
    vDSP_Stride   __IA,
    const double *__B,
    double       *__C,
    vDSP_Stride   __IC,
    vDSP_Length   __N,
    unsigned int  __F)
        __OSX_AVAILABLE_STARTING(__MAC_10_4, __IPHONE_4_0);
extern void vDSP_vdist(
    const float *__A,
    vDSP_Stride  __IA,
    const float *__B,
    vDSP_Stride  __IB,
    float       *__C,
    vDSP_Stride  __IC,
    vDSP_Length  __N)
        __OSX_AVAILABLE_STARTING(__MAC_10_4, __IPHONE_4_0);
extern void vDSP_vdistD(
    const double *__A,
    vDSP_Stride   __IA,
    const double *__B,
    vDSP_Stride   __IB,
    double       *__C,
    vDSP_Stride   __IC,
    vDSP_Length   __N)
        __OSX_AVAILABLE_STARTING(__MAC_10_4, __IPHONE_4_0);
extern void vDSP_venvlp(
    const float *__A,
    vDSP_Stride  __IA,
    const float *__B,
    vDSP_Stride  __IB,
    const float *__C,
    vDSP_Stride  __IC,
    float       *__D,
    vDSP_Stride  __ID,
    vDSP_Length  __N)
        __OSX_AVAILABLE_STARTING(__MAC_10_4, __IPHONE_4_0);
extern void vDSP_venvlpD(
    const double *__A,
    vDSP_Stride   __IA,
    const double *__B,
    vDSP_Stride   __IB,
    const double *__C,
    vDSP_Stride   __IC,
    double       *__D,
    vDSP_Stride   __ID,
    vDSP_Length   __N)
        __OSX_AVAILABLE_STARTING(__MAC_10_4, __IPHONE_4_0);
extern void vDSP_vfix8(
    const float *__A,
    vDSP_Stride  __IA,
    char        *__C,
    vDSP_Stride  __IC,
    vDSP_Length  __N)
        __OSX_AVAILABLE_STARTING(__MAC_10_4, __IPHONE_4_0);
extern void vDSP_vfix8D(
    const double *__A,
    vDSP_Stride   __IA,
    char         *__C,
    vDSP_Stride   __IC,
    vDSP_Length   __N)
        __OSX_AVAILABLE_STARTING(__MAC_10_4, __IPHONE_4_0);
extern void vDSP_vfix16(
    const float *__A,
    vDSP_Stride  __IA,
    short       *__C,
    vDSP_Stride  __IC,
    vDSP_Length  __N)
        __OSX_AVAILABLE_STARTING(__MAC_10_4, __IPHONE_4_0);
extern void vDSP_vfix16D(
    const double *__A,
    vDSP_Stride   __IA,
    short        *__C,
    vDSP_Stride   __IC,
    vDSP_Length   __N)
        __OSX_AVAILABLE_STARTING(__MAC_10_4, __IPHONE_4_0);
extern void vDSP_vfix32(
    const float *__A,
    vDSP_Stride  __IA,
    int         *__C,
    vDSP_Stride  __IC,
    vDSP_Length  __N)
        __OSX_AVAILABLE_STARTING(__MAC_10_4, __IPHONE_4_0);
extern void vDSP_vfix32D(
    const double *__A,
    vDSP_Stride   __IA,
    int          *__C,
    vDSP_Stride   __IC,
    vDSP_Length   __N)
        __OSX_AVAILABLE_STARTING(__MAC_10_4, __IPHONE_4_0);
extern void vDSP_vfixu8(
    const float   *__A,
    vDSP_Stride    __IA,
    unsigned char *__C,
    vDSP_Stride    __IC,
    vDSP_Length    __N)
        __OSX_AVAILABLE_STARTING(__MAC_10_4, __IPHONE_4_0);
extern void vDSP_vfixu8D(
    const double  *__A,
    vDSP_Stride    __IA,
    unsigned char *__C,
    vDSP_Stride    __IC,
    vDSP_Length    __N)
        __OSX_AVAILABLE_STARTING(__MAC_10_4, __IPHONE_4_0);
extern void vDSP_vfixu16(
    const float    *__A,
    vDSP_Stride     __IA,
    unsigned short *__C,
    vDSP_Stride     __IC,
    vDSP_Length     __N)
        __OSX_AVAILABLE_STARTING(__MAC_10_4, __IPHONE_4_0);
extern void vDSP_vfixu16D(
    const double   *__A,
    vDSP_Stride     __IA,
    unsigned short *__C,
    vDSP_Stride     __IC,
    vDSP_Length     __N)
        __OSX_AVAILABLE_STARTING(__MAC_10_4, __IPHONE_4_0);
extern void vDSP_vfixu32(
    const float  *__A,
    vDSP_Stride   __IA,
    unsigned int *__C,
    vDSP_Stride   __IC,
    vDSP_Length   __N)
        __OSX_AVAILABLE_STARTING(__MAC_10_4, __IPHONE_4_0);
extern void vDSP_vfixu32D(
    const double *__A,
    vDSP_Stride   __IA,
    unsigned int *__C,
    vDSP_Stride   __IC,
    vDSP_Length   __N)
        __OSX_AVAILABLE_STARTING(__MAC_10_4, __IPHONE_4_0);
extern void vDSP_vsmfixu24(
    const float *__A,
    vDSP_Stride  __IA,
    const float *__B,
    vDSP_uint24 *__C,
    vDSP_Stride  __IC,
    vDSP_Length  __N)
        __OSX_AVAILABLE_STARTING(__MAC_10_9, __IPHONE_7_0);
extern void vDSP_vsmfix24(
   const float *__A,
   vDSP_Stride  __IA,
   const float *__B,
   vDSP_int24  *__C,
   vDSP_Stride  __IC,
   vDSP_Length  __N)
        __OSX_AVAILABLE_STARTING(__MAC_10_9, __IPHONE_7_0);
extern void vDSP_vfltu24(
   const vDSP_uint24 *__A,
   vDSP_Stride        __IA,
   float             *__C,
   vDSP_Stride        __IC,
   vDSP_Length        __N)
        __OSX_AVAILABLE_STARTING(__MAC_10_9, __IPHONE_7_0);
extern void vDSP_vflt24(
  const vDSP_int24 *__A,
  vDSP_Stride       __IA,
  float            *__C,
  vDSP_Stride       __IC,
  vDSP_Length       __N)
        __OSX_AVAILABLE_STARTING(__MAC_10_9, __IPHONE_7_0);
extern void vDSP_vfltsmu24(
     const vDSP_uint24 *__A,
     vDSP_Stride        __IA,
     const float       *__B,
     float             *__C,
     vDSP_Stride        __IC,
     vDSP_Length        __N)
        __OSX_AVAILABLE_STARTING(__MAC_10_9, __IPHONE_7_0);
extern void vDSP_vfltsm24(
    const vDSP_int24 *__A,
    vDSP_Stride       __IA,
    const float      *__B,
    float            *__C,
    vDSP_Stride       __IC,
    vDSP_Length       __N)
        __OSX_AVAILABLE_STARTING(__MAC_10_9, __IPHONE_7_0);
extern void vDSP_vfixr8(
    const float *__A,
    vDSP_Stride  __IA,
    char        *__C,
    vDSP_Stride  __IC,
    vDSP_Length  __N)
        __OSX_AVAILABLE_STARTING(__MAC_10_4, __IPHONE_4_0);
extern void vDSP_vfixr8D(
    const double *__A,
    vDSP_Stride   __IA,
    char         *__C,
    vDSP_Stride   __IC,
    vDSP_Length   __N)
        __OSX_AVAILABLE_STARTING(__MAC_10_4, __IPHONE_4_0);
extern void vDSP_vfixr16(
    const float *__A,
    vDSP_Stride  __IA,
    short       *__C,
    vDSP_Stride  __IC,
    vDSP_Length  __N)
        __OSX_AVAILABLE_STARTING(__MAC_10_4, __IPHONE_4_0);
extern void vDSP_vfixr16D(
    const double *__A,
    vDSP_Stride   __IA,
    short        *__C,
    vDSP_Stride   __IC,
    vDSP_Length   __N)
        __OSX_AVAILABLE_STARTING(__MAC_10_4, __IPHONE_4_0);
extern void vDSP_vfixr32(
    const float *__A,
    vDSP_Stride  __IA,
    int         *__C,
    vDSP_Stride  __IC,
    vDSP_Length  __N)
        __OSX_AVAILABLE_STARTING(__MAC_10_4, __IPHONE_4_0);
extern void vDSP_vfixr32D(
    const double *__A,
    vDSP_Stride   __IA,
    int          *__C,
    vDSP_Stride   __IC,
    vDSP_Length   __N)
        __OSX_AVAILABLE_STARTING(__MAC_10_4, __IPHONE_4_0);
extern void vDSP_vfixru8(
    const float   *__A,
    vDSP_Stride    __IA,
    unsigned char *__C,
    vDSP_Stride    __IC,
    vDSP_Length    __N)
        __OSX_AVAILABLE_STARTING(__MAC_10_4, __IPHONE_4_0);
extern void vDSP_vfixru8D(
    const double  *__A,
    vDSP_Stride    __IA,
    unsigned char *__C,
    vDSP_Stride    __IC,
    vDSP_Length    __N)
        __OSX_AVAILABLE_STARTING(__MAC_10_4, __IPHONE_4_0);
extern void vDSP_vfixru16(
    const float    *__A,
    vDSP_Stride     __IA,
    unsigned short *__C,
    vDSP_Stride     __IC,
    vDSP_Length     __N)
        __OSX_AVAILABLE_STARTING(__MAC_10_4, __IPHONE_4_0);
extern void vDSP_vfixru16D(
    const double   *__A,
    vDSP_Stride     __IA,
    unsigned short *__C,
    vDSP_Stride     __IC,
    vDSP_Length     __N)
        __OSX_AVAILABLE_STARTING(__MAC_10_4, __IPHONE_4_0);
extern void vDSP_vfixru32(
    const float  *__A,
    vDSP_Stride   __IA,
    unsigned int *__C,
    vDSP_Stride   __IC,
    vDSP_Length   __N)
        __OSX_AVAILABLE_STARTING(__MAC_10_4, __IPHONE_4_0);
extern void vDSP_vfixru32D(
    const double *__A,
    vDSP_Stride   __IA,
    unsigned int *__C,
    vDSP_Stride   __IC,
    vDSP_Length   __N)
        __OSX_AVAILABLE_STARTING(__MAC_10_4, __IPHONE_4_0);
extern void vDSP_vflt8(
    const char  *__A,
    vDSP_Stride  __IA,
    float       *__C,
    vDSP_Stride  __IC,
    vDSP_Length  __N)
        __OSX_AVAILABLE_STARTING(__MAC_10_4, __IPHONE_4_0);
extern void vDSP_vflt8D(
    const char  *__A,
    vDSP_Stride  __IA,
    double      *__C,
    vDSP_Stride  __IC,
    vDSP_Length  __N)
        __OSX_AVAILABLE_STARTING(__MAC_10_4, __IPHONE_4_0);
extern void vDSP_vflt16(
    const short *__A,
    vDSP_Stride  __IA,
    float       *__C,
    vDSP_Stride  __IC,
    vDSP_Length  __N)
        __OSX_AVAILABLE_STARTING(__MAC_10_4, __IPHONE_4_0);
extern void vDSP_vflt16D(
    const short *__A,
    vDSP_Stride  __IA,
    double      *__C,
    vDSP_Stride  __IC,
    vDSP_Length  __N)
        __OSX_AVAILABLE_STARTING(__MAC_10_4, __IPHONE_4_0);
extern void vDSP_vflt32(
    const int   *__A,
    vDSP_Stride  __IA,
    float       *__C,
    vDSP_Stride  __IC,
    vDSP_Length  __N)
        __OSX_AVAILABLE_STARTING(__MAC_10_4, __IPHONE_4_0);
extern void vDSP_vflt32D(
    const int   *__A,
    vDSP_Stride  __IA,
    double      *__C,
    vDSP_Stride  __IC,
    vDSP_Length  __N)
        __OSX_AVAILABLE_STARTING(__MAC_10_4, __IPHONE_4_0);
extern void vDSP_vfltu8(
    const unsigned char *__A,
    vDSP_Stride          __IA,
    float               *__C,
    vDSP_Stride          __IC,
    vDSP_Length          __N)
        __OSX_AVAILABLE_STARTING(__MAC_10_4, __IPHONE_4_0);
extern void vDSP_vfltu8D(
    const unsigned char *__A,
    vDSP_Stride          __IA,
    double              *__C,
    vDSP_Stride          __IC,
    vDSP_Length          __N)
        __OSX_AVAILABLE_STARTING(__MAC_10_4, __IPHONE_4_0);
extern void vDSP_vfltu16(
    const unsigned short *__A,
    vDSP_Stride           __IA,
    float                *__C,
    vDSP_Stride           __IC,
    vDSP_Length           __N)
        __OSX_AVAILABLE_STARTING(__MAC_10_4, __IPHONE_4_0);
extern void vDSP_vfltu16D(
    const unsigned short *__A,
    vDSP_Stride           __IA,
    double               *__C,
    vDSP_Stride           __IC,
    vDSP_Length           __N)
        __OSX_AVAILABLE_STARTING(__MAC_10_4, __IPHONE_4_0);
extern void vDSP_vfltu32(
    const unsigned int *__A,
    vDSP_Stride         __IA,
    float              *__C,
    vDSP_Stride         __IC,
    vDSP_Length         __N)
        __OSX_AVAILABLE_STARTING(__MAC_10_4, __IPHONE_4_0);
extern void vDSP_vfltu32D(
    const unsigned int *__A,
    vDSP_Stride         __IA,
    double             *__C,
    vDSP_Stride         __IC,
    vDSP_Length         __N)
        __OSX_AVAILABLE_STARTING(__MAC_10_4, __IPHONE_4_0);
extern void vDSP_vfrac(
    const float *__A,
    vDSP_Stride  __IA,
    float       *__C,
    vDSP_Stride  __IC,
    vDSP_Length  __N)
        __OSX_AVAILABLE_STARTING(__MAC_10_4, __IPHONE_4_0);
extern void vDSP_vfracD(
    const double *__A,
    vDSP_Stride   __IA,
    double       *__C,
    vDSP_Stride   __IC,
    vDSP_Length   __N)
        __OSX_AVAILABLE_STARTING(__MAC_10_4, __IPHONE_4_0);
extern void vDSP_vgathr(
    const float       *__A,
    const vDSP_Length *__B,
    vDSP_Stride        __IB,
    float             *__C,
    vDSP_Stride        __IC,
    vDSP_Length        __N)
        __OSX_AVAILABLE_STARTING(__MAC_10_4, __IPHONE_4_0);
extern void vDSP_vgathrD(
    const double      *__A,
    const vDSP_Length *__B,
    vDSP_Stride        __IB,
    double            *__C,
    vDSP_Stride        __IC,
    vDSP_Length        __N)
        __OSX_AVAILABLE_STARTING(__MAC_10_4, __IPHONE_4_0);
extern void vDSP_vgathra(
    const float * __nonnull * __nonnull __A,
    vDSP_Stride                         __IA,
    float                              *__C,
    vDSP_Stride                         __IC,
    vDSP_Length                         __N)
        __OSX_AVAILABLE_STARTING(__MAC_10_4, __IPHONE_4_0);
extern void vDSP_vgathraD(
    const double * __nonnull * __nonnull __A,
    vDSP_Stride                          __IA,
    double                              *__C,
    vDSP_Stride                          __IC,
    vDSP_Length                          __N)
        __OSX_AVAILABLE_STARTING(__MAC_10_4, __IPHONE_4_0);
extern void vDSP_vgen(
    const float *__A,
    const float *__B,
    float       *__C,
    vDSP_Stride  __IC,
    vDSP_Length  __N)
        __OSX_AVAILABLE_STARTING(__MAC_10_4, __IPHONE_4_0);
extern void vDSP_vgenD(
    const double *__A,
    const double *__B,
    double       *__C,
    vDSP_Stride   __IC,
    vDSP_Length   __N)
        __OSX_AVAILABLE_STARTING(__MAC_10_4, __IPHONE_4_0);
extern void vDSP_vgenp(
    const float *__A,
    vDSP_Stride  __IA,
    const float *__B,
    vDSP_Stride  __IB,
    float       *__C,
    vDSP_Stride  __IC,
    vDSP_Length  __N,
    vDSP_Length  __M)  
        __OSX_AVAILABLE_STARTING(__MAC_10_4, __IPHONE_4_0);
extern void vDSP_vgenpD(
    const double *__A,
    vDSP_Stride   __IA,
    const double *__B,
    vDSP_Stride   __IB,
    double       *__C,
    vDSP_Stride   __IC,
    vDSP_Length   __N,
    vDSP_Length   __M)  
        __OSX_AVAILABLE_STARTING(__MAC_10_4, __IPHONE_4_0);
extern void vDSP_viclip(
    const float *__A,
    vDSP_Stride  __IA,
    const float *__B,
    const float *__C,
    float       *__D,
    vDSP_Stride  __ID,
    vDSP_Length  __N)
        __OSX_AVAILABLE_STARTING(__MAC_10_4, __IPHONE_4_0);
extern void vDSP_viclipD(
    const double *__A,
    vDSP_Stride   __IA,
    const double *__B,
    const double *__C,
    double       *__D,
    vDSP_Stride   __ID,
    vDSP_Length   __N)
        __OSX_AVAILABLE_STARTING(__MAC_10_4, __IPHONE_4_0);
extern void vDSP_vindex(
    const float *__A,
    const float *__B,
    vDSP_Stride  __IB,
    float       *__C,
    vDSP_Stride  __IC,
    vDSP_Length  __N)
        __OSX_AVAILABLE_STARTING(__MAC_10_4, __IPHONE_4_0);
extern void vDSP_vindexD(
    const double *__A,
    const double *__B,
    vDSP_Stride   __IB,
    double       *__C,
    vDSP_Stride   __IC,
    vDSP_Length   __N)
        __OSX_AVAILABLE_STARTING(__MAC_10_4, __IPHONE_4_0);
extern void vDSP_vintb(
    const float *__A,
    vDSP_Stride  __IA,
    const float *__B,
    vDSP_Stride  __IB,
    const float *__C,
    float       *__D,
    vDSP_Stride  __ID,
    vDSP_Length  __N)
        __OSX_AVAILABLE_STARTING(__MAC_10_4, __IPHONE_4_0);
extern void vDSP_vintbD(
    const double *__A,
    vDSP_Stride   __IA,
    const double *__B,
    vDSP_Stride   __IB,
    const double *__C,
    double       *__D,
    vDSP_Stride   __ID,
    vDSP_Length   __N)
        __OSX_AVAILABLE_STARTING(__MAC_10_4, __IPHONE_4_0);
extern void vDSP_vlim(
    const float *__A,
    vDSP_Stride  __IA,
    const float *__B,
    const float *__C,
    float       *__D,
    vDSP_Stride  __ID,
    vDSP_Length  __N)
        __OSX_AVAILABLE_STARTING(__MAC_10_4, __IPHONE_4_0);
extern void vDSP_vlimD(
    const double *__A,
    vDSP_Stride   __IA,
    const double *__B,
    const double *__C,
    double       *__D,
    vDSP_Stride   __ID,
    vDSP_Length   __N)
        __OSX_AVAILABLE_STARTING(__MAC_10_4, __IPHONE_4_0);
extern void vDSP_vlint(
    const float *__A,
    const float *__B,
    vDSP_Stride  __IB,
    float       *__C,
    vDSP_Stride  __IC,
    vDSP_Length  __N,
    vDSP_Length  __M)  
        __OSX_AVAILABLE_STARTING(__MAC_10_4, __IPHONE_4_0);
extern void vDSP_vlintD(
    const double *__A,
    const double *__B,
    vDSP_Stride   __IB,
    double       *__C,
    vDSP_Stride   __IC,
    vDSP_Length   __N,
    vDSP_Length   __M)  
        __OSX_AVAILABLE_STARTING(__MAC_10_4, __IPHONE_4_0);
extern void vDSP_vmax(
    const float *__A,
    vDSP_Stride  __IA,
    const float *__B,
    vDSP_Stride  __IB,
    float       *__C,
    vDSP_Stride  __IC,
    vDSP_Length  __N)
        __OSX_AVAILABLE_STARTING(__MAC_10_4, __IPHONE_4_0);
extern void vDSP_vmaxD(
    const double *__A,
    vDSP_Stride   __IA,
    const double *__B,
    vDSP_Stride   __IB,
    double       *__C,
    vDSP_Stride   __IC,
    vDSP_Length   __N)
        __OSX_AVAILABLE_STARTING(__MAC_10_4, __IPHONE_4_0);
extern void vDSP_vmaxmg(
    const float *__A,
    vDSP_Stride  __IA,
    const float *__B,
    vDSP_Stride  __IB,
    float       *__C,
    vDSP_Stride  __IC,
    vDSP_Length  __N)
        __OSX_AVAILABLE_STARTING(__MAC_10_4, __IPHONE_4_0);
extern void vDSP_vmaxmgD(
    const double *__A,
    vDSP_Stride   __IA,
    const double *__B,
    vDSP_Stride   __IB,
    double       *__C,
    vDSP_Stride   __IC,
    vDSP_Length   __N)
        __OSX_AVAILABLE_STARTING(__MAC_10_4, __IPHONE_4_0);
extern void vDSP_vswmax(
    const float *__A,
    vDSP_Stride  __IA,
    float       *__C,
    vDSP_Stride  __IC,
    vDSP_Length  __N,
    vDSP_Length  __WindowLength)
        __OSX_AVAILABLE_STARTING(__MAC_10_10, __IPHONE_8_0);
extern void vDSP_vswmaxD(
    const double *__A,
    vDSP_Stride   __IA,
    double       *__C,
    vDSP_Stride   __IC,
    vDSP_Length  __N,
    vDSP_Length  __WindowLength)
        __OSX_AVAILABLE_STARTING(__MAC_10_10, __IPHONE_8_0);
extern void vDSP_vmin(
    const float *__A,
    vDSP_Stride  __IA,
    const float *__B,
    vDSP_Stride  __IB,
    float       *__C,
    vDSP_Stride  __IC,
    vDSP_Length  __N)
        __OSX_AVAILABLE_STARTING(__MAC_10_4, __IPHONE_4_0);
extern void vDSP_vminD(
    const double *__A,
    vDSP_Stride   __IA,
    const double *__B,
    vDSP_Stride   __IB,
    double       *__C,
    vDSP_Stride   __IC,
    vDSP_Length   __N)
        __OSX_AVAILABLE_STARTING(__MAC_10_4, __IPHONE_4_0);
extern void vDSP_vminmg(
    const float *__A,
    vDSP_Stride  __IA,
    const float *__B,
    vDSP_Stride  __IB,
    float       *__C,
    vDSP_Stride  __IC,
    vDSP_Length  __N)
        __OSX_AVAILABLE_STARTING(__MAC_10_4, __IPHONE_4_0);
extern void vDSP_vminmgD(
    const double *__A,
    vDSP_Stride   __IA,
    const double *__B,
    vDSP_Stride   __IB,
    double       *__C,
    vDSP_Stride   __IC,
    vDSP_Length   __N)
        __OSX_AVAILABLE_STARTING(__MAC_10_4, __IPHONE_4_0);
extern void vDSP_vmma(
    const float *__A,
    vDSP_Stride  __IA,
    const float *__B,
    vDSP_Stride  __IB,
    const float *__C,
    vDSP_Stride  __IC,
    const float *__D,
    vDSP_Stride  __ID,
    float       *__E,
    vDSP_Stride  __IE,
    vDSP_Length  __N)
        __OSX_AVAILABLE_STARTING(__MAC_10_4, __IPHONE_4_0);
extern void vDSP_vmmaD(
    const double *__A,
    vDSP_Stride   __IA,
    const double *__B,
    vDSP_Stride   __IB,
    const double *__C,
    vDSP_Stride   __IC,
    const double *__D,
    vDSP_Stride   __ID,
    double       *__E,
    vDSP_Stride   __IE,
    vDSP_Length   __N)
        __OSX_AVAILABLE_STARTING(__MAC_10_4, __IPHONE_4_0);
extern void vDSP_vmmsb(
    const float *__A,
    vDSP_Stride  __IA,
    const float *__B,
    vDSP_Stride  __IB,
    const float *__C,
    vDSP_Stride  __IC,
    const float *__D,
    vDSP_Stride  __ID,
    float       *__E,
    vDSP_Stride  __IE,
    vDSP_Length  __N)
        __OSX_AVAILABLE_STARTING(__MAC_10_4, __IPHONE_4_0);
extern void vDSP_vmmsbD(
    const double *__A,
    vDSP_Stride   __IA,
    const double *__B,
    vDSP_Stride   __IB,
    const double *__C,
    vDSP_Stride   __IC,
    const double *__D,
    vDSP_Stride   __ID,
    double       *__E,
    vDSP_Stride   __IE,
    vDSP_Length   __N)
        __OSX_AVAILABLE_STARTING(__MAC_10_4, __IPHONE_4_0);
extern void vDSP_vmsa(
    const float *__A,
    vDSP_Stride  __IA,
    const float *__B,
    vDSP_Stride  __IB,
    const float *__C,
    float       *__D,
    vDSP_Stride  __ID,
    vDSP_Length  __N)
        __OSX_AVAILABLE_STARTING(__MAC_10_4, __IPHONE_4_0);
extern void vDSP_vmsaD(
    const double *__A,
    vDSP_Stride   __IA,
    const double *__B,
    vDSP_Stride   __IB,
    const double *__C,
    double       *__D,
    vDSP_Stride   __ID,
    vDSP_Length   __N)
        __OSX_AVAILABLE_STARTING(__MAC_10_4, __IPHONE_4_0);
extern void vDSP_vmsb(
    const float *__A,
    vDSP_Stride  __IA,
    const float *__B,
    vDSP_Stride  __IB,
    const float *__C,
    vDSP_Stride  __IC,
    float       *__D,
    vDSP_Stride  __ID,
    vDSP_Length  __N)
        __OSX_AVAILABLE_STARTING(__MAC_10_4, __IPHONE_4_0);
extern void vDSP_vmsbD(
    const double *__A,
    vDSP_Stride   __IA,
    const double *__B,
    vDSP_Stride   __IB,
    const double *__C,
    vDSP_Stride   __IC,
    double       *__D,
    vDSP_Stride   __ID,
    vDSP_Length   __N)
        __OSX_AVAILABLE_STARTING(__MAC_10_4, __IPHONE_4_0);
extern void vDSP_vnabs(
    const float *__A,
    vDSP_Stride  __IA,
    float       *__C,
    vDSP_Stride  __IC,
    vDSP_Length  __N)
        __OSX_AVAILABLE_STARTING(__MAC_10_4, __IPHONE_4_0);
extern void vDSP_vnabsD(
    const double *__A,
    vDSP_Stride   __IA,
    double       *__C,
    vDSP_Stride   __IC,
    vDSP_Length   __N)
        __OSX_AVAILABLE_STARTING(__MAC_10_4, __IPHONE_4_0);
extern void vDSP_vneg(
    const float *__A,
    vDSP_Stride  __IA,
    float       *__C,
    vDSP_Stride  __IC,
    vDSP_Length  __N)
        __OSX_AVAILABLE_STARTING(__MAC_10_4, __IPHONE_4_0);
extern void vDSP_vnegD(
    const double *__A,
    vDSP_Stride   __IA,
    double       *__C,
    vDSP_Stride   __IC,
    vDSP_Length   __N)
        __OSX_AVAILABLE_STARTING(__MAC_10_4, __IPHONE_4_0);
extern void vDSP_vpoly(
    const float *__A,
    vDSP_Stride  __IA,
    const float *__B,
    vDSP_Stride  __IB,
    float       *__C,
    vDSP_Stride  __IC,
    vDSP_Length  __N,
    vDSP_Length  __P)  
        __OSX_AVAILABLE_STARTING(__MAC_10_4, __IPHONE_4_0);
extern void vDSP_vpolyD(
    const double *__A,
    vDSP_Stride   __IA,
    const double *__B,
    vDSP_Stride   __IB,
    double       *__C,
    vDSP_Stride   __IC,
    vDSP_Length   __N,
    vDSP_Length   __P)  
        __OSX_AVAILABLE_STARTING(__MAC_10_4, __IPHONE_4_0);
extern void vDSP_vpythg(
    const float *__A,
    vDSP_Stride  __IA,
    const float *__B,
    vDSP_Stride  __IB,
    const float *__C,
    vDSP_Stride  __IC,
    const float *__D,
    vDSP_Stride  __ID,
    float       *__E,
    vDSP_Stride  __IE,
    vDSP_Length  __N)
        __OSX_AVAILABLE_STARTING(__MAC_10_4, __IPHONE_4_0);
extern void vDSP_vpythgD(
    const double *__A,
    vDSP_Stride   __IA,
    const double *__B,
    vDSP_Stride   __IB,
    const double *__C,
    vDSP_Stride   __IC,
    const double *__D,
    vDSP_Stride   __ID,
    double       *__E,
    vDSP_Stride   __IE,
    vDSP_Length   __N)
        __OSX_AVAILABLE_STARTING(__MAC_10_4, __IPHONE_4_0);
extern void vDSP_vqint(
    const float *__A,
    const float *__B,
    vDSP_Stride  __IB,
    float       *__C,
    vDSP_Stride  __IC,
    vDSP_Length  __N,
    vDSP_Length  __M)
        __OSX_AVAILABLE_STARTING(__MAC_10_4, __IPHONE_4_0);
extern void vDSP_vqintD(
    const double *__A,
    const double *__B,
    vDSP_Stride   __IB,
    double       *__C,
    vDSP_Stride   __IC,
    vDSP_Length   __N,
    vDSP_Length   __M)
        __OSX_AVAILABLE_STARTING(__MAC_10_4, __IPHONE_4_0);
extern void vDSP_vramp(
    const float *__A,
    const float *__B,
    float       *__C,
    vDSP_Stride  __IC,
    vDSP_Length  __N)
        __OSX_AVAILABLE_STARTING(__MAC_10_4, __IPHONE_4_0);
extern void vDSP_vrampD(
    const double *__A,
    const double *__B,
    double       *__C,
    vDSP_Stride   __IC,
    vDSP_Length   __N)
        __OSX_AVAILABLE_STARTING(__MAC_10_4, __IPHONE_4_0);
extern void vDSP_vrsum(
    const float *__A,
    vDSP_Stride  __IA,
    const float *__S,
    float       *__C,
    vDSP_Stride  __IC,
    vDSP_Length  __N)
        __OSX_AVAILABLE_STARTING(__MAC_10_4, __IPHONE_4_0);
extern void vDSP_vrsumD(
    const double *__A,
    vDSP_Stride   __IA,
    const double *__S,
    double       *__C,
    vDSP_Stride   __IC,
    vDSP_Length   __N)
        __OSX_AVAILABLE_STARTING(__MAC_10_4, __IPHONE_4_0);
extern void vDSP_vrvrs(
    float       *__C,
    vDSP_Stride  __IC,
    vDSP_Length  __N)
        __OSX_AVAILABLE_STARTING(__MAC_10_4, __IPHONE_4_0);
extern void vDSP_vrvrsD(
    double      *__C,
    vDSP_Stride  __IC,
    vDSP_Length  __N)
        __OSX_AVAILABLE_STARTING(__MAC_10_4, __IPHONE_4_0);
extern void vDSP_vsbm(
    const float *__A,
    vDSP_Stride  __IA,
    const float *__B,
    vDSP_Stride  __IB,
    const float *__C,
    vDSP_Stride  __IC,
    float       *__D,
    vDSP_Stride  __ID,
    vDSP_Length  __N)
        __OSX_AVAILABLE_STARTING(__MAC_10_4, __IPHONE_4_0);
extern void vDSP_vsbmD(
    const double *__A,
    vDSP_Stride   __IA,
    const double *__B,
    vDSP_Stride   __IB,
    const double *__C,
    vDSP_Stride   __IC,
    double       *__D,
    vDSP_Stride   __ID,
    vDSP_Length   __N)
        __OSX_AVAILABLE_STARTING(__MAC_10_4, __IPHONE_4_0);
extern void vDSP_vsbsbm(
    const float *__A,
    vDSP_Stride  __IA,
    const float *__B,
    vDSP_Stride  __IB,
    const float *__C,
    vDSP_Stride  __IC,
    const float *__D,
    vDSP_Stride  __ID,
    float       *__E,
    vDSP_Stride  __IE,
    vDSP_Length  __N)
        __OSX_AVAILABLE_STARTING(__MAC_10_4, __IPHONE_4_0);
extern void vDSP_vsbsbmD(
    const double *__A,
    vDSP_Stride   __IA,
    const double *__B,
    vDSP_Stride   __IB,
    const double *__C,
    vDSP_Stride   __IC,
    const double *__D,
    vDSP_Stride   __ID,
    double       *__E,
    vDSP_Stride   __IE,
    vDSP_Length   __N)
        __OSX_AVAILABLE_STARTING(__MAC_10_4, __IPHONE_4_0);
extern void vDSP_vsbsm(
    const float *__A,
    vDSP_Stride  __IA,
    const float *__B,
    vDSP_Stride  __IB,
    const float *__C,
    float       *__D,
    vDSP_Stride  __ID,
    vDSP_Length  __N)
        __OSX_AVAILABLE_STARTING(__MAC_10_4, __IPHONE_4_0);
extern void vDSP_vsbsmD(
    const double *__A,
    vDSP_Stride   __IA,
    const double *__B,
    vDSP_Stride   __IB,
    const double *__C,
    double       *__D,
    vDSP_Stride   __ID,
    vDSP_Length   __N)
        __OSX_AVAILABLE_STARTING(__MAC_10_4, __IPHONE_4_0);
extern void vDSP_vsimps(
    const float *__A,
    vDSP_Stride  __IA,
    const float *__B,
    float       *__C,
    vDSP_Stride  __IC,
    vDSP_Length  __N)
        __OSX_AVAILABLE_STARTING(__MAC_10_4, __IPHONE_4_0);
extern void vDSP_vsimpsD(
    const double *__A,
    vDSP_Stride   __IA,
    const double *__B,
    double       *__C,
    vDSP_Stride   __IC,
    vDSP_Length   __N)
        __OSX_AVAILABLE_STARTING(__MAC_10_4, __IPHONE_4_0);
extern void vDSP_vsma(
    const float *__A,
    vDSP_Stride  __IA,
    const float *__B,
    const float *__C,
    vDSP_Stride  __IC,
    float       *__D,
    vDSP_Stride  __ID,
    vDSP_Length  __N)
        __OSX_AVAILABLE_STARTING(__MAC_10_4, __IPHONE_4_0);
extern void vDSP_vsmaD(
    const double *__A,
    vDSP_Stride   __IA,
    const double *__B,
    const double *__C,
    vDSP_Stride   __IC,
    double       *__D,
    vDSP_Stride   __ID,
    vDSP_Length   __N)
        __OSX_AVAILABLE_STARTING(__MAC_10_4, __IPHONE_4_0);
extern void vDSP_vsmsa(
    const float *__A,
    vDSP_Stride  __IA,
    const float *__B,
    const float *__C,
    float       *__D,
    vDSP_Stride  __ID,
    vDSP_Length  __N)
        __OSX_AVAILABLE_STARTING(__MAC_10_4, __IPHONE_4_0);
extern void vDSP_vsmsaD(
    const double *__A,
    vDSP_Stride   __IA,
    const double *__B,
    const double *__C,
    double       *__D,
    vDSP_Stride   __ID,
    vDSP_Length   __N)
        __OSX_AVAILABLE_STARTING(__MAC_10_4, __IPHONE_4_0);
extern void vDSP_vsmsb(
    const float *__A,
    vDSP_Stride  __IA,
    const float *__B,
    const float *__C,
    vDSP_Stride  __IC,
    float       *__D,
    vDSP_Stride  __ID,
    vDSP_Length  __N)
        __OSX_AVAILABLE_STARTING(__MAC_10_4, __IPHONE_4_0);
extern void vDSP_vsmsbD(
    const double *__A,
    vDSP_Stride   __IA,
    const double *__B,
    const double *__C,
    vDSP_Stride   __IC,
    double       *__D,
    vDSP_Stride   __ID,
    vDSP_Length   __N)
        __OSX_AVAILABLE_STARTING(__MAC_10_4, __IPHONE_4_0);
extern void vDSP_vsmsma(
    const float *__A,
    vDSP_Stride  __IA,
    const float *__B,
    const float *__C,
    vDSP_Stride  __IC,
    const float *__D,
    float       *__E,
    vDSP_Stride  __IE,
    vDSP_Length  __N)
        __OSX_AVAILABLE_STARTING(__MAC_10_9, __IPHONE_6_0);
extern void vDSP_vsmsmaD(
    const double *__A,
    vDSP_Stride   __IA,
    const double *__B,
    const double *__C,
    vDSP_Stride   __IC,
    const double *__D,
    double       *__E,
    vDSP_Stride   __IE,
    vDSP_Length   __N)
        __OSX_AVAILABLE_STARTING(__MAC_10_10, __IPHONE_8_0);
extern void vDSP_vsort(
    float       *__C,
    vDSP_Length  __N,
    int          __Order)
        __OSX_AVAILABLE_STARTING(__MAC_10_4, __IPHONE_4_0);
extern void vDSP_vsortD(
    double      *__C,
    vDSP_Length  __N,
    int          __Order)
        __OSX_AVAILABLE_STARTING(__MAC_10_4, __IPHONE_4_0);
extern void vDSP_vsorti(
    const float *__C,
    vDSP_Length *__I,
    vDSP_Length * __nullable __Temporary,
    vDSP_Length  __N,
    int          __Order)
        __OSX_AVAILABLE_STARTING(__MAC_10_4, __IPHONE_4_0);
extern void vDSP_vsortiD(
    const double *__C,
    vDSP_Length  *__I,
    vDSP_Length  * __nullable __Temporary,
    vDSP_Length   __N,
    int           __Order)
        __OSX_AVAILABLE_STARTING(__MAC_10_4, __IPHONE_4_0);
extern void vDSP_vswap(
    float       *__A,
    vDSP_Stride  __IA,
    float       *__B,
    vDSP_Stride  __IB,
    vDSP_Length  __N)
        __OSX_AVAILABLE_STARTING(__MAC_10_4, __IPHONE_4_0);
extern void vDSP_vswapD(
    double      *__A,
    vDSP_Stride  __IA,
    double      *__B,
    vDSP_Stride  __IB,
    vDSP_Length  __N)
        __OSX_AVAILABLE_STARTING(__MAC_10_4, __IPHONE_4_0);
extern void vDSP_vswsum(
    const float *__A,
    vDSP_Stride  __IA,
    float       *__C,
    vDSP_Stride  __IC,
    vDSP_Length  __N,
    vDSP_Length  __P) 
        __OSX_AVAILABLE_STARTING(__MAC_10_4, __IPHONE_4_0);
extern void vDSP_vswsumD(
    const double *__A,
    vDSP_Stride   __IA,
    double       *__C,
    vDSP_Stride   __IC,
    vDSP_Length   __N,
    vDSP_Length   __P) 
        __OSX_AVAILABLE_STARTING(__MAC_10_4, __IPHONE_4_0);
extern void vDSP_vtabi(
    const float *__A,
    vDSP_Stride  __IA,
    const float *__S1,
    const float *__S2,
    const float *__C,
    vDSP_Length  __M,
    float       *__D,
    vDSP_Stride  __ID,
    vDSP_Length  __N)
        __OSX_AVAILABLE_STARTING(__MAC_10_4, __IPHONE_4_0);
extern void vDSP_vtabiD(
    const double *__A,
    vDSP_Stride   __IA,
    const double *__S1,
    const double *__S2,
    const double *__C,
    vDSP_Length   __M,
    double       *__D,
    vDSP_Stride   __ID,
    vDSP_Length   __N)
        __OSX_AVAILABLE_STARTING(__MAC_10_4, __IPHONE_4_0);
extern void vDSP_vthr(
    const float *__A,
    vDSP_Stride  __IA,
    const float *__B,
    float       *__C,
    vDSP_Stride  __IC,
    vDSP_Length  __N)
        __OSX_AVAILABLE_STARTING(__MAC_10_4, __IPHONE_4_0);
extern void vDSP_vthrD(
    const double *__A,
    vDSP_Stride   __IA,
    const double *__B,
    double       *__C,
    vDSP_Stride   __IC,
    vDSP_Length   __N)
        __OSX_AVAILABLE_STARTING(__MAC_10_4, __IPHONE_4_0);
extern void vDSP_vthres(
    const float *__A,
    vDSP_Stride  __IA,
    const float *__B,
    float       *__C,
    vDSP_Stride  __IC,
    vDSP_Length  __N)
        __OSX_AVAILABLE_STARTING(__MAC_10_4, __IPHONE_4_0);
extern void vDSP_vthresD(
    const double *__A,
    vDSP_Stride   __IA,
    const double *__B,
    double       *__C,
    vDSP_Stride   __IC,
    vDSP_Length   __N)
        __OSX_AVAILABLE_STARTING(__MAC_10_4, __IPHONE_4_0);
extern void vDSP_vthrsc(
    const float *__A,
    vDSP_Stride  __IA,
    const float *__B,
    const float *__C,
    float       *__D,
    vDSP_Stride  __ID,
    vDSP_Length  __N)
        __OSX_AVAILABLE_STARTING(__MAC_10_4, __IPHONE_4_0);
extern void vDSP_vthrscD(
    const double *__A,
    vDSP_Stride   __IA,
    const double *__B,
    const double *__C,
    double       *__D,
    vDSP_Stride   __ID,
    vDSP_Length   __N)
        __OSX_AVAILABLE_STARTING(__MAC_10_4, __IPHONE_4_0);
extern void vDSP_vtmerg(
    const float *__A,
    vDSP_Stride  __IA,
    const float *__B,
    vDSP_Stride  __IB,
    float       *__C,
    vDSP_Stride  __IC,
    vDSP_Length  __N)
        __OSX_AVAILABLE_STARTING(__MAC_10_4, __IPHONE_4_0);
extern void vDSP_vtmergD(
    const double *__A,
    vDSP_Stride   __IA,
    const double *__B,
    vDSP_Stride   __IB,
    double       *__C,
    vDSP_Stride   __IC,
    vDSP_Length   __N)
        __OSX_AVAILABLE_STARTING(__MAC_10_4, __IPHONE_4_0);
extern void vDSP_vtrapz(
    const float *__A,
    vDSP_Stride  __IA,
    const float *__B,
    float       *__C,
    vDSP_Stride  __IC,
    vDSP_Length  __N)
        __OSX_AVAILABLE_STARTING(__MAC_10_4, __IPHONE_4_0);
extern void vDSP_vtrapzD(
    const double *__A,
    vDSP_Stride   __IA,
    const double *__B,
    double       *__C,
    vDSP_Stride   __IC,
    vDSP_Length   __N)
        __OSX_AVAILABLE_STARTING(__MAC_10_4, __IPHONE_4_0);
extern void vDSP_wiener(
    vDSP_Length  __L,
    const float *__A,
    const float *__C,
    float       *__F,
    float       *__P,
    int          __Flag,
    int         *__Error)
        __OSX_AVAILABLE_STARTING(__MAC_10_4, __IPHONE_4_0);
extern void vDSP_wienerD(
    vDSP_Length   __L,
    const double *__A,
    const double *__C,
    double       *__F,
    double       *__P,
    int           __Flag,
    int          *__Error)
        __OSX_AVAILABLE_STARTING(__MAC_10_4, __IPHONE_4_0);
void vDSP_FFT16_copv(float *__Output, const float *__Input,
    FFTDirection __Direction)
        __OSX_AVAILABLE_STARTING(__MAC_10_6, __IPHONE_4_0);
void vDSP_FFT32_copv(float *__Output, const float *__Input,
    FFTDirection __Direction)
        __OSX_AVAILABLE_STARTING(__MAC_10_6, __IPHONE_4_0);
void vDSP_FFT16_zopv(
          float *__Or,       float *__Oi,
    const float *__Ir, const float *__Ii,
    FFTDirection __Direction)
        __OSX_AVAILABLE_STARTING(__MAC_10_6, __IPHONE_4_0);
void vDSP_FFT32_zopv(
          float *__Or,       float *__Oi,
    const float *__Ir, const float *__Ii,
    FFTDirection __Direction)
        __OSX_AVAILABLE_STARTING(__MAC_10_6, __IPHONE_4_0);
typedef struct vDSP_DFT_SetupStruct  *vDSP_DFT_Setup;
typedef struct vDSP_DFT_SetupStructD *vDSP_DFT_SetupD;
typedef vDSP_ENUM(int, vDSP_DFT_Direction)
    { vDSP_DFT_FORWARD = +1, vDSP_DFT_INVERSE = -1 };
__nullable vDSP_DFT_Setup vDSP_DFT_CreateSetup(
    __nullable vDSP_DFT_Setup __Previous,
    vDSP_Length               __Length)
        __OSX_AVAILABLE_STARTING(__MAC_10_6, __IPHONE_4_0);
__nullable vDSP_DFT_Setup vDSP_DFT_zop_CreateSetup(
    __nullable vDSP_DFT_Setup __Previous,
    vDSP_Length               __Length,
    vDSP_DFT_Direction        __Direction)
        __OSX_AVAILABLE_STARTING(__MAC_10_7, __IPHONE_4_0);
__nullable vDSP_DFT_SetupD vDSP_DFT_zop_CreateSetupD(
    __nullable vDSP_DFT_SetupD __Previous,
    vDSP_Length                __Length,
    vDSP_DFT_Direction         __Direction)
        __OSX_AVAILABLE_STARTING(__MAC_10_9, __IPHONE_7_0);
__nullable vDSP_DFT_Setup vDSP_DFT_zrop_CreateSetup(
    __nullable vDSP_DFT_Setup __Previous,
    vDSP_Length __Length, vDSP_DFT_Direction __Direction)
        __OSX_AVAILABLE_STARTING(__MAC_10_7, __IPHONE_4_0);
__nullable vDSP_DFT_SetupD vDSP_DFT_zrop_CreateSetupD(
    __nullable vDSP_DFT_SetupD __Previous,
    vDSP_Length __Length, vDSP_DFT_Direction __Direction)
        __OSX_AVAILABLE_STARTING(__MAC_10_9, __IPHONE_7_0);
void vDSP_DFT_DestroySetup(__nullable vDSP_DFT_Setup __Setup)
        __OSX_AVAILABLE_STARTING(__MAC_10_6, __IPHONE_4_0);
void vDSP_DFT_DestroySetupD(__nullable vDSP_DFT_SetupD __Setup)
        __OSX_AVAILABLE_STARTING(__MAC_10_9, __IPHONE_7_0);
void vDSP_DFT_zop(
    const struct vDSP_DFT_SetupStruct *__Setup,
    const float *__Ir, const float *__Ii, vDSP_Stride __Is,
          float *__Or,       float *__Oi, vDSP_Stride __Os,
    vDSP_DFT_Direction __Direction)
        __OSX_AVAILABLE_STARTING(__MAC_10_6, __IPHONE_4_0);
void vDSP_DFT_Execute(
    const struct vDSP_DFT_SetupStruct *__Setup,
    const float *__Ir,  const float *__Ii,
          float *__Or,        float *__Oi)
        __OSX_AVAILABLE_STARTING(__MAC_10_7, __IPHONE_4_0);
void vDSP_DFT_ExecuteD(
    const struct vDSP_DFT_SetupStructD *__Setup,
    const double *__Ir,  const double *__Ii,
          double *__Or,        double *__Oi)
        __OSX_AVAILABLE_STARTING(__MAC_10_9, __IPHONE_7_0);
typedef vDSP_ENUM(int, vDSP_DCT_Type)
{
    vDSP_DCT_II  = 2,
    vDSP_DCT_III = 3,
    vDSP_DCT_IV  = 4
};
__nullable vDSP_DFT_Setup vDSP_DCT_CreateSetup(
    __nullable vDSP_DFT_Setup __Previous,
    vDSP_Length               __Length,
    vDSP_DCT_Type             __Type)
        __OSX_AVAILABLE_STARTING(__MAC_10_9, __IPHONE_6_0);
void vDSP_DCT_Execute(
    const struct vDSP_DFT_SetupStruct *__Setup,
    const float                       *__Input,
    float                             *__Output)
        __OSX_AVAILABLE_STARTING(__MAC_10_9, __IPHONE_6_0);
void vDSP_dotpr2(
    const float *__A0, vDSP_Stride __IA0,
    const float *__A1, vDSP_Stride __IA1,
    const float *__B,  vDSP_Stride __IB,
    float       *__C0,
    float       *__C1,
    vDSP_Length  __N)
        __OSX_AVAILABLE_STARTING(__MAC_10_6, __IPHONE_4_0);
void vDSP_dotpr2D(
    const double *__A0, vDSP_Stride __IA0,
    const double *__A1, vDSP_Stride __IA1,
    const double *__B,  vDSP_Stride __IB,
    double       *__C0,
    double       *__C1,
    vDSP_Length   __N)
        __OSX_AVAILABLE_STARTING(__MAC_10_10, __IPHONE_8_0);
void vDSP_dotpr_s1_15(
    const short int *__A, vDSP_Stride __IA,
    const short int *__B, vDSP_Stride __IB,
    short int       *__C,
    vDSP_Length      __N)
        __OSX_AVAILABLE_STARTING(__MAC_10_6, __IPHONE_4_0);
void vDSP_dotpr2_s1_15(
    const short int *__A0, vDSP_Stride __IA0,
    const short int *__A1, vDSP_Stride __IA1,
    const short int *__B,  vDSP_Stride __IB,
    short int       *__C0,
    short int       *__C1,
    vDSP_Length      __N)
        __OSX_AVAILABLE_STARTING(__MAC_10_6, __IPHONE_4_0);
void vDSP_dotpr_s8_24(
    const int  *__A, vDSP_Stride __IA,
    const int  *__B, vDSP_Stride __IB,
    int        *__C,
    vDSP_Length __N)
        __OSX_AVAILABLE_STARTING(__MAC_10_6, __IPHONE_4_0);
void vDSP_dotpr2_s8_24(
    const int  *__A0, vDSP_Stride __IA0,
    const int  *__A1, vDSP_Stride __IA1,
    const int  *__B,  vDSP_Stride __IB,
    int        *__C0,
    int        *__C1,
    vDSP_Length __N)
        __OSX_AVAILABLE_STARTING(__MAC_10_6, __IPHONE_4_0);
void vDSP_vaddsub(
    const float *__I0, vDSP_Stride __I0S,
    const float *__I1, vDSP_Stride __I1S,
          float *__O0, vDSP_Stride __O0S,
          float *__O1, vDSP_Stride __O1S,
    vDSP_Length __N)
        __OSX_AVAILABLE_STARTING(__MAC_10_10, __IPHONE_8_0);
void vDSP_vaddsubD(
    const double *__I0, vDSP_Stride __I0S,
    const double *__I1, vDSP_Stride __I1S,
          double *__O0, vDSP_Stride __O0S,
          double *__O1, vDSP_Stride __O1S,
    vDSP_Length __N)
        __OSX_AVAILABLE_STARTING(__MAC_10_10, __IPHONE_8_0);
void vDSP_vrampmul(
    const float *__I, vDSP_Stride __IS,
    float *__Start,
    const float *__Step,
    float *__O, vDSP_Stride __OS,
    vDSP_Length __N)
        __OSX_AVAILABLE_STARTING(__MAC_10_6, __IPHONE_4_0);
void vDSP_vrampmulD(
    const double *__I, vDSP_Stride __IS,
    double *__Start,
    const double *__Step,
    double *__O, vDSP_Stride __OS,
    vDSP_Length __N)
        __OSX_AVAILABLE_STARTING(__MAC_10_10, __IPHONE_8_0);
void vDSP_vrampmuladd(
    const float *__I, vDSP_Stride __IS,
    float *__Start,
    const float *__Step,
    float *__O, vDSP_Stride __OS,
    vDSP_Length __N)
        __OSX_AVAILABLE_STARTING(__MAC_10_6, __IPHONE_4_0);
void vDSP_vrampmuladdD(
    const double *__I, vDSP_Stride __IS,
          double *__Start,
    const double *__Step,
          double *__O, vDSP_Stride __OS,
    vDSP_Length __N)
        __OSX_AVAILABLE_STARTING(__MAC_10_10, __IPHONE_8_0);
void vDSP_vrampmul2(
    const float *__I0, const float *__I1, vDSP_Stride __IS,
    float *__Start,
    const float *__Step,
    float *__O0, float *__O1, vDSP_Stride __OS,
    vDSP_Length __N)
        __OSX_AVAILABLE_STARTING(__MAC_10_6, __IPHONE_4_0);
void vDSP_vrampmul2D(
    const double *__I0, const double *__I1, vDSP_Stride __IS,
          double *__Start,
    const double *__Step,
          double *__O0, double *__O1, vDSP_Stride __OS,
    vDSP_Length __N)
        __OSX_AVAILABLE_STARTING(__MAC_10_10, __IPHONE_8_0);
void vDSP_vrampmuladd2(
    const float *__I0, const float *__I1, vDSP_Stride __IS,
    float *__Start,
    const float *__Step,
    float *__O0, float *__O1, vDSP_Stride __OS,
    vDSP_Length __N)
        __OSX_AVAILABLE_STARTING(__MAC_10_6, __IPHONE_4_0);
void vDSP_vrampmuladd2D(
    const double *__I0, const double *__I1, vDSP_Stride __IS,
    double *__Start,
    const double *__Step,
    double *__O0, double *__O1, vDSP_Stride __OS,
    vDSP_Length __N)
        __OSX_AVAILABLE_STARTING(__MAC_10_10, __IPHONE_8_0);
void vDSP_vrampmul_s1_15(
    const short int *__I, vDSP_Stride __IS,
    short int *__Start,
    const short int *__Step,
    short int *__O, vDSP_Stride __OS,
    vDSP_Length __N)
        __OSX_AVAILABLE_STARTING(__MAC_10_6, __IPHONE_4_0);
void vDSP_vrampmuladd_s1_15(
    const short int *__I, vDSP_Stride __IS,
    short int *__Start,
    const short int *__Step,
    short int *__O, vDSP_Stride __OS,
    vDSP_Length __N)
        __OSX_AVAILABLE_STARTING(__MAC_10_6, __IPHONE_4_0);
void vDSP_vrampmul2_s1_15(
    const short int *__I0, const short int *__I1, vDSP_Stride __IS,
    short int *__Start,
    const short int *__Step,
    short int *__O0, short int *__O1, vDSP_Stride __OS,
    vDSP_Length __N)
        __OSX_AVAILABLE_STARTING(__MAC_10_6, __IPHONE_4_0);
void vDSP_vrampmuladd2_s1_15(
    const short int *__I0, const short int *__I1, vDSP_Stride __IS,
    short int *__Start,
    const short int *__Step,
    short int *__O0, short int *__O1, vDSP_Stride __OS,
    vDSP_Length __N)
        __OSX_AVAILABLE_STARTING(__MAC_10_6, __IPHONE_4_0);
void vDSP_vrampmul_s8_24(
    const int *__I, vDSP_Stride __IS,
    int *__Start,
    const int *__Step,
    int *__O, vDSP_Stride __OS,
    vDSP_Length __N)
        __OSX_AVAILABLE_STARTING(__MAC_10_6, __IPHONE_4_0);
void vDSP_vrampmuladd_s8_24(
    const int *__I, vDSP_Stride __IS,
    int *__Start,
    const int *__Step,
    int *__O, vDSP_Stride __OS,
    vDSP_Length __N)
        __OSX_AVAILABLE_STARTING(__MAC_10_6, __IPHONE_4_0);
void vDSP_vrampmul2_s8_24(
    const int *__I0, const int *__I1, vDSP_Stride __IS,
    int *__Start,
    const int *__Step,
    int *__O0, int *__O1, vDSP_Stride __OS,
    vDSP_Length __N)
        __OSX_AVAILABLE_STARTING(__MAC_10_6, __IPHONE_4_0);
void vDSP_vrampmuladd2_s8_24(
    const int *__I0, const int *__I1, vDSP_Stride __IS,
    int *__Start,
    const int *__Step,
    int *__O0, int *__O1, vDSP_Stride __OS,
    vDSP_Length __N)
        __OSX_AVAILABLE_STARTING(__MAC_10_6, __IPHONE_4_0);
#if defined vDSP_DeprecateTranslations
extern FFTSetup create_fftsetup(
    vDSP_Length __Log2n,
    FFTRadix    __Radix)
        __OSX_AVAILABLE_BUT_DEPRECATED(__MAC_10_0, __MAC_10_11, __IPHONE_4_0, __IPHONE_NA);
extern void destroy_fftsetup(FFTSetup __setup)
        __OSX_AVAILABLE_BUT_DEPRECATED(__MAC_10_0, __MAC_10_11, __IPHONE_4_0, __IPHONE_NA);
extern void ctoz(
    const DSPComplex      *__C,
    vDSP_Stride            __IC,
    const DSPSplitComplex *__Z,
    vDSP_Stride            __IZ,
    vDSP_Length            __N)
        __OSX_AVAILABLE_BUT_DEPRECATED(__MAC_10_0, __MAC_10_11, __IPHONE_4_0, __IPHONE_NA);
extern void ztoc(
    const DSPSplitComplex *__Z,
    vDSP_Stride            __IZ,
    DSPComplex            *__C,
    vDSP_Stride            __IC,
    vDSP_Length            __N)
        __OSX_AVAILABLE_BUT_DEPRECATED(__MAC_10_0, __MAC_10_11, __IPHONE_4_0, __IPHONE_NA);
extern void fft_zip(
    FFTSetup               __Setup,
    const DSPSplitComplex *__C,
    vDSP_Stride            __IC,
    vDSP_Length            __Log2N,
    FFTDirection           __Direction)
        __OSX_AVAILABLE_BUT_DEPRECATED(__MAC_10_0, __MAC_10_11, __IPHONE_4_0, __IPHONE_NA);
extern void fft_zipt(
    FFTSetup               __Setup,
    const DSPSplitComplex *__C,
    vDSP_Stride            __IC,
    const DSPSplitComplex *__Buffer,
    vDSP_Length            __Log2N,
    FFTDirection           __Direction)
        __OSX_AVAILABLE_BUT_DEPRECATED(__MAC_10_0, __MAC_10_11, __IPHONE_4_0, __IPHONE_NA);
extern void fft_zop(
    FFTSetup               __Setup,
    const DSPSplitComplex *__A,
    vDSP_Stride            __IA,
    const DSPSplitComplex *__C,
    vDSP_Stride            __IC,
    vDSP_Length            __Log2N,
    FFTDirection           __Direction)
        __OSX_AVAILABLE_BUT_DEPRECATED(__MAC_10_0, __MAC_10_11, __IPHONE_4_0, __IPHONE_NA);
extern void fft_zopt(
    FFTSetup               __Setup,
    const DSPSplitComplex *__A,
    vDSP_Stride            __IA,
    const DSPSplitComplex *__C,
    vDSP_Stride            __IC,
    const DSPSplitComplex *__Buffer,
    vDSP_Length            __Log2N,
    FFTDirection           __Direction)
        __OSX_AVAILABLE_BUT_DEPRECATED(__MAC_10_0, __MAC_10_11, __IPHONE_4_0, __IPHONE_NA);
extern void fft_zrip(
    FFTSetup               __Setup,
    const DSPSplitComplex *__C,
    vDSP_Stride            __IC,
    vDSP_Length            __Log2N,
    FFTDirection           __Direction)
        __OSX_AVAILABLE_BUT_DEPRECATED(__MAC_10_0, __MAC_10_11, __IPHONE_4_0, __IPHONE_NA);
extern void fft_zript(
    FFTSetup               __Setup,
    const DSPSplitComplex *__C,
    vDSP_Stride            __IC,
    const DSPSplitComplex *__Buffer,
    vDSP_Length            __Log2N,
    FFTDirection           __Direction)
        __OSX_AVAILABLE_BUT_DEPRECATED(__MAC_10_0, __MAC_10_11, __IPHONE_4_0, __IPHONE_NA);
extern void fft_zrop(
    FFTSetup               __Setup,
    const DSPSplitComplex *__A,
    vDSP_Stride            __IA,
    const DSPSplitComplex *__C,
    vDSP_Stride            __IC,
    vDSP_Length            __Log2N,
    FFTDirection           __Direction)
        __OSX_AVAILABLE_BUT_DEPRECATED(__MAC_10_0, __MAC_10_11, __IPHONE_4_0, __IPHONE_NA);
extern void fft_zropt(
    FFTSetup               __Setup,
    const DSPSplitComplex *__A,
    vDSP_Stride            __IA,
    const DSPSplitComplex *__C,
    vDSP_Stride            __IC,
    const DSPSplitComplex *__Buffer,
    vDSP_Length            __Log2N,
    FFTDirection           __Direction)
        __OSX_AVAILABLE_BUT_DEPRECATED(__MAC_10_0, __MAC_10_11, __IPHONE_4_0, __IPHONE_NA);
extern void fft2d_zip(
    FFTSetup               __Setup,
    const DSPSplitComplex *__C,
    vDSP_Stride            __IC0,
    vDSP_Stride            __IC1,
    vDSP_Length            __Log2N0,
    vDSP_Length            __Log2N1,
    FFTDirection           __Direction)
        __OSX_AVAILABLE_BUT_DEPRECATED(__MAC_10_0, __MAC_10_11, __IPHONE_4_0, __IPHONE_NA);
extern void fft2d_zipt(
    FFTSetup               __Setup,
    const DSPSplitComplex *__C,
    vDSP_Stride            __IC1,
    vDSP_Stride            __IC0,
    const DSPSplitComplex *__Buffer,
    vDSP_Length            __Log2N0,
    vDSP_Length            __Log2N1,
    FFTDirection           __Direction)
        __OSX_AVAILABLE_BUT_DEPRECATED(__MAC_10_0, __MAC_10_11, __IPHONE_4_0, __IPHONE_NA);
extern void fft2d_zop(
    FFTSetup               __Setup,
    const DSPSplitComplex *__A,
    vDSP_Stride            __IA0,
    vDSP_Stride            __IA1,
    const DSPSplitComplex *__C,
    vDSP_Stride            __IC0,
    vDSP_Stride            __IC1,
    vDSP_Length            __Log2N0,
    vDSP_Length            __Log2N1,
    FFTDirection           __Direction)
        __OSX_AVAILABLE_BUT_DEPRECATED(__MAC_10_0, __MAC_10_11, __IPHONE_4_0, __IPHONE_NA);
extern void fft2d_zopt(
    FFTSetup               __Setup,
    const DSPSplitComplex *__A,
    vDSP_Stride            __IA0,
    vDSP_Stride            __IA1,
    const DSPSplitComplex *__C,
    vDSP_Stride            __IC0,
    vDSP_Stride            __IC1,
    const DSPSplitComplex *__Buffer,
    vDSP_Length            __Log2N0,
    vDSP_Length            __Log2N1,
    FFTDirection           __Direction)
        __OSX_AVAILABLE_BUT_DEPRECATED(__MAC_10_0, __MAC_10_11, __IPHONE_4_0, __IPHONE_NA);
extern void fft2d_zrip(
    FFTSetup               __Setup,
    const DSPSplitComplex *__C,
    vDSP_Stride            __IC0,
    vDSP_Stride            __IC1,
    vDSP_Length            __Log2N0,
    vDSP_Length            __Log2N1,
    FFTDirection           __Direction)
        __OSX_AVAILABLE_BUT_DEPRECATED(__MAC_10_0, __MAC_10_11, __IPHONE_4_0, __IPHONE_NA);
extern void fft2d_zript(
    FFTSetup               __Setup,
    const DSPSplitComplex *__C,
    vDSP_Stride            __IC0,
    vDSP_Stride            __IC1,
    const DSPSplitComplex *__Buffer,
    vDSP_Length            __Log2N0,
    vDSP_Length            __Log2N1,
    FFTDirection           __Direction)
        __OSX_AVAILABLE_BUT_DEPRECATED(__MAC_10_0, __MAC_10_11, __IPHONE_4_0, __IPHONE_NA);
extern void fft2d_zrop(
    FFTSetup               __Setup,
    const DSPSplitComplex *__A,
    vDSP_Stride            __IA0,
    vDSP_Stride            __IA1,
    const DSPSplitComplex *__C,
    vDSP_Stride            __IC0,
    vDSP_Stride            __IC1,
    vDSP_Length            __Log2N0,
    vDSP_Length            __Log2N1,
    FFTDirection           __Direction)
        __OSX_AVAILABLE_BUT_DEPRECATED(__MAC_10_0, __MAC_10_11, __IPHONE_4_0, __IPHONE_NA);
extern void fft2d_zropt(
    FFTSetup               __Setup,
    const DSPSplitComplex *__A,
    vDSP_Stride            __IA0,
    vDSP_Stride            __IA1,
    const DSPSplitComplex *__C,
    vDSP_Stride            __IC0,
    vDSP_Stride            __IC1,
    const DSPSplitComplex *__Buffer,
    vDSP_Length            __Log2N0,
    vDSP_Length            __Log2N1,
    FFTDirection           __Direction)
        __OSX_AVAILABLE_BUT_DEPRECATED(__MAC_10_0, __MAC_10_11, __IPHONE_4_0, __IPHONE_NA);
extern void fft3_zop(
    FFTSetup               __Setup,
    const DSPSplitComplex *__A,
    vDSP_Stride            __IA,
    const DSPSplitComplex *__C,
    vDSP_Stride            __IC,
    vDSP_Length            __Log2N,
    FFTDirection           __Direction)
        __OSX_AVAILABLE_BUT_DEPRECATED(__MAC_10_2, __MAC_10_11, __IPHONE_4_0, __IPHONE_9_0);
extern void fft5_zop(
    FFTSetup               __Setup,
    const DSPSplitComplex *__A,
    vDSP_Stride            __IA,
    const DSPSplitComplex *__C,
    vDSP_Stride            __IC,
    vDSP_Length            __Log2N,
    FFTDirection           __Direction)
        __OSX_AVAILABLE_BUT_DEPRECATED(__MAC_10_2, __MAC_10_11, __IPHONE_4_0, __IPHONE_9_0);
extern void fftm_zop(
    FFTSetup               __Setup,
    const DSPSplitComplex *__A,
    vDSP_Stride            __IA,
    vDSP_Stride            __IMA,
    const DSPSplitComplex *__C,
    vDSP_Stride            __IC,
    vDSP_Stride            __IMC,
    vDSP_Length            __Log2N,
    vDSP_Length            __M,
    FFTDirection           __Direction)
        __OSX_AVAILABLE_BUT_DEPRECATED(__MAC_10_2, __MAC_10_11, __IPHONE_4_0, __IPHONE_NA);
extern void fftm_zopt(
    FFTSetup               __Setup,
    const DSPSplitComplex *__A,
    vDSP_Stride            __IA,
    vDSP_Stride            __IMA,
    const DSPSplitComplex *__C,
    vDSP_Stride            __IC,
    vDSP_Stride            __IMC,
    const DSPSplitComplex *__Buffer,
    vDSP_Length            __Log2N,
    vDSP_Length            __M,
    FFTDirection           __Direction)
        __OSX_AVAILABLE_BUT_DEPRECATED(__MAC_10_2, __MAC_10_11, __IPHONE_4_0, __IPHONE_NA);
extern void fftm_zip(
    FFTSetup               __Setup,
    const DSPSplitComplex *__C,
    vDSP_Stride            __IC,
    vDSP_Stride            __IM,
    vDSP_Length            __Log2N,
    vDSP_Length            __M,
    FFTDirection           __Direction)
        __OSX_AVAILABLE_BUT_DEPRECATED(__MAC_10_2, __MAC_10_11, __IPHONE_4_0, __IPHONE_NA);
extern void fftm_zipt(
    FFTSetup               __Setup,
    const DSPSplitComplex *__C,
    vDSP_Stride            __IC,
    vDSP_Stride            __IM,
    const DSPSplitComplex *__Buffer,
    vDSP_Length            __Log2N,
    vDSP_Length            __M,
    FFTDirection           __Direction)
        __OSX_AVAILABLE_BUT_DEPRECATED(__MAC_10_2, __MAC_10_11, __IPHONE_4_0, __IPHONE_NA);
extern void fftm_zrop(
    FFTSetup               __Setup,
    const DSPSplitComplex *__A,
    vDSP_Stride            __IA,
    vDSP_Stride            __IMA,
    const DSPSplitComplex *__C,
    vDSP_Stride            __IC,
    vDSP_Stride            __IMC,
    vDSP_Length            __Log2N,
    vDSP_Length            __M,
    FFTDirection           __Direction)
        __OSX_AVAILABLE_BUT_DEPRECATED(__MAC_10_2, __MAC_10_11, __IPHONE_4_0, __IPHONE_NA);
extern void fftm_zropt(
    FFTSetup               __Setup,
    const DSPSplitComplex *__A,
    vDSP_Stride            __IA,
    vDSP_Stride            __IMA,
    const DSPSplitComplex *__C,
    vDSP_Stride            __IC,
    vDSP_Stride            __IMC,
    const DSPSplitComplex *__Buffer,
    vDSP_Length            __Log2N,
    vDSP_Length            __M,
    FFTDirection           __Direction)
        __OSX_AVAILABLE_BUT_DEPRECATED(__MAC_10_2, __MAC_10_11, __IPHONE_4_0, __IPHONE_NA);
extern void fftm_zrip(
    FFTSetup               __Setup,
    const DSPSplitComplex *__C,
    vDSP_Stride            __IC,
    vDSP_Stride            __IM,
    vDSP_Length            __Log2N,
    vDSP_Length            __M,
    FFTDirection           __Direction)
        __OSX_AVAILABLE_BUT_DEPRECATED(__MAC_10_2, __MAC_10_11, __IPHONE_4_0, __IPHONE_NA);
extern void fftm_zript(
    FFTSetup               __Setup,
    const DSPSplitComplex *__C,
    vDSP_Stride            __IC,
    vDSP_Stride            __IM,
    const DSPSplitComplex *__Buffer,
    vDSP_Length            __Log2N,
    vDSP_Length            __M,
    FFTDirection           __Direction)
        __OSX_AVAILABLE_BUT_DEPRECATED(__MAC_10_2, __MAC_10_11, __IPHONE_4_0, __IPHONE_NA);
extern void f3x3(
    const float *__A,
    vDSP_Length  __NR,
    vDSP_Length  __NC,
    const float *__F,
    float       *__C)
        __OSX_AVAILABLE_BUT_DEPRECATED(__MAC_10_2, __MAC_10_11, __IPHONE_4_0, __IPHONE_NA);
extern void f5x5(
    const float *__A,
    vDSP_Length  __NR,
    vDSP_Length  __NC,
    const float *__F,
    float       *__C)
        __OSX_AVAILABLE_BUT_DEPRECATED(__MAC_10_2, __MAC_10_11, __IPHONE_4_0, __IPHONE_NA);
extern void conv(
    const float *__A,  
    vDSP_Stride  __IA,
    const float *__F,  
    vDSP_Stride  __IF,
    float       *__C,  
    vDSP_Stride  __IC,
    vDSP_Length  __N,  
    vDSP_Length  __P)  
        __OSX_AVAILABLE_BUT_DEPRECATED(__MAC_10_0, __MAC_10_11, __IPHONE_4_0, __IPHONE_NA);
extern void dotpr(
    const float *__A,
    vDSP_Stride  __IA,
    const float *__B,
    vDSP_Stride  __IB,
    float       *__C,
    vDSP_Length  __N)
        __OSX_AVAILABLE_BUT_DEPRECATED(__MAC_10_0, __MAC_10_11, __IPHONE_4_0, __IPHONE_NA);
extern void imgfir(
    const float *__A,  
    vDSP_Length  __NR, 
    vDSP_Length  __NC, 
    const float *__F,  
    float       *__C,  
    vDSP_Length  __P,  
    vDSP_Length  __Q)  
        __OSX_AVAILABLE_BUT_DEPRECATED(__MAC_10_2, __MAC_10_11, __IPHONE_4_0, __IPHONE_NA);
extern void mtrans(
    const float *__A,
    vDSP_Stride  __IA,
    float       *__C,
    vDSP_Stride  __IC,
    vDSP_Length  __M,
    vDSP_Length  __N)
        __OSX_AVAILABLE_BUT_DEPRECATED(__MAC_10_2, __MAC_10_11, __IPHONE_4_0, __IPHONE_NA);
extern void mmul(
    const float *__A,
    vDSP_Stride  __IA,
    const float *__B,
    vDSP_Stride  __IB,
    float       *__C,
    vDSP_Stride  __IC,
    vDSP_Length  __M,
    vDSP_Length  __N,
    vDSP_Length  __P)
        __OSX_AVAILABLE_BUT_DEPRECATED(__MAC_10_2, __MAC_10_11, __IPHONE_4_0, __IPHONE_NA);
extern void vadd(
    const float *__A,
    vDSP_Stride  __IA,
    const float *__B,
    vDSP_Stride  __IB,
    float       *__C,
    vDSP_Stride  __IC,
    vDSP_Length  __N)
        __OSX_AVAILABLE_BUT_DEPRECATED(__MAC_10_0, __MAC_10_11, __IPHONE_4_0, __IPHONE_NA);
extern void vsub(
    const float *__B,  
    vDSP_Stride  __IB,
    const float *__A,  
    vDSP_Stride  __IA,
    float       *__C,
    vDSP_Stride  __IC,
    vDSP_Length  __N)
        __OSX_AVAILABLE_BUT_DEPRECATED(__MAC_10_0, __MAC_10_11, __IPHONE_4_0, __IPHONE_NA);
extern void vmul(
    const float *__A,
    vDSP_Stride  __IA,
    const float *__B,
    vDSP_Stride  __IB,
    float       *__C,
    vDSP_Stride  __IC,
    vDSP_Length  __N)
        __OSX_AVAILABLE_BUT_DEPRECATED(__MAC_10_0, __MAC_10_11, __IPHONE_4_0, __IPHONE_NA);
extern void vsmul(
    const float *__A,
    vDSP_Stride  __IA,
    const float *__B,
    float       *__C,
    vDSP_Stride  __IC,
    vDSP_Length  __N)
        __OSX_AVAILABLE_BUT_DEPRECATED(__MAC_10_0, __MAC_10_11, __IPHONE_4_0, __IPHONE_NA);
extern void vam(
    const float *__A,
    vDSP_Stride  __IA,
    const float *__B,
    vDSP_Stride  __IB,
    const float *__C,
    vDSP_Stride  __IC,
    float       *__D,
    vDSP_Stride  __ID,
    vDSP_Length  __N)
        __OSX_AVAILABLE_BUT_DEPRECATED(__MAC_10_0, __MAC_10_11, __IPHONE_4_0, __IPHONE_NA);
extern void vsq(
    const float *__A,
    vDSP_Stride  __IA,
    float       *__C,
    vDSP_Stride  __IC,
    vDSP_Length  __N)
        __OSX_AVAILABLE_BUT_DEPRECATED(__MAC_10_0, __MAC_10_11, __IPHONE_4_0, __IPHONE_NA);
extern void vssq(
    const float *__A,
    vDSP_Stride  __IA,
    float       *__C,
    vDSP_Stride  __IC,
    vDSP_Length  __N)
        __OSX_AVAILABLE_BUT_DEPRECATED(__MAC_10_0, __MAC_10_11, __IPHONE_4_0, __IPHONE_NA);
extern void zvadd(
    const DSPSplitComplex *__A,
    vDSP_Stride            __IA,
    const DSPSplitComplex *__B,
    vDSP_Stride            __IB,
    const DSPSplitComplex *__C,
    vDSP_Stride            __IC,
    vDSP_Length            __N)
        __OSX_AVAILABLE_BUT_DEPRECATED(__MAC_10_0, __MAC_10_11, __IPHONE_4_0, __IPHONE_NA);
extern void zvsub(
    const DSPSplitComplex *__A,
    vDSP_Stride            __IA,
    const DSPSplitComplex *__B,
    vDSP_Stride            __IB,
    const DSPSplitComplex *__C,
    vDSP_Stride            __IC,
    vDSP_Length            __N)
        __OSX_AVAILABLE_BUT_DEPRECATED(__MAC_10_0, __MAC_10_11, __IPHONE_4_0, __IPHONE_NA);
extern void zdotpr(
    const DSPSplitComplex *__A,
    vDSP_Stride            __IA,
    const DSPSplitComplex *__B,
    vDSP_Stride            __IB,
    const DSPSplitComplex *__C,
    vDSP_Length            __N)
        __OSX_AVAILABLE_BUT_DEPRECATED(__MAC_10_0, __MAC_10_11, __IPHONE_4_0, __IPHONE_NA);
extern void zconv(
    const DSPSplitComplex *__A,  
    vDSP_Stride            __IA,
    const DSPSplitComplex *__F,  
    vDSP_Stride            __IF,
    const DSPSplitComplex *__C,  
    vDSP_Stride            __IC,
    vDSP_Length            __N,  
    vDSP_Length            __P)  
        __OSX_AVAILABLE_BUT_DEPRECATED(__MAC_10_0, __MAC_10_11, __IPHONE_4_0, __IPHONE_NA);
extern void zvcma(
    const DSPSplitComplex *__A,
    vDSP_Stride            __IA,
    const DSPSplitComplex *__B,
    vDSP_Stride            __IB,
    const DSPSplitComplex *__C,
    vDSP_Stride            __IC,
    const DSPSplitComplex *__D,
    vDSP_Stride            __ID,
    vDSP_Length            __N)
        __OSX_AVAILABLE_BUT_DEPRECATED(__MAC_10_0, __MAC_10_11, __IPHONE_4_0, __IPHONE_NA);
extern void zvmul(
    const DSPSplitComplex *__A,
    vDSP_Stride            __IA,
    const DSPSplitComplex *__B,
    vDSP_Stride            __IB,
    const DSPSplitComplex *__C,
    vDSP_Stride            __IC,
    vDSP_Length            __N,
    int                    __Conjugate)
        __OSX_AVAILABLE_BUT_DEPRECATED(__MAC_10_0, __MAC_10_11, __IPHONE_4_0, __IPHONE_NA);
extern void zidotpr(
    const DSPSplitComplex *__A,
    vDSP_Stride            __IA,
    const DSPSplitComplex *__B,
    vDSP_Stride            __IB,
    const DSPSplitComplex *__C,
    vDSP_Length            __N)
        __OSX_AVAILABLE_BUT_DEPRECATED(__MAC_10_0, __MAC_10_11, __IPHONE_4_0, __IPHONE_NA);
extern void zmma(
    const DSPSplitComplex *__A,
    vDSP_Stride            __IA,
    const DSPSplitComplex *__B,
    vDSP_Stride            __IB,
    const DSPSplitComplex *__C,
    vDSP_Stride            __IC,
    const DSPSplitComplex *__D,
    vDSP_Stride            __ID,
    vDSP_Length            __M,
    vDSP_Length            __N,
    vDSP_Length            __P)
        __OSX_AVAILABLE_BUT_DEPRECATED(__MAC_10_2, __MAC_10_11, __IPHONE_4_0, __IPHONE_NA);
extern void zmms(
    const DSPSplitComplex *__A,
    vDSP_Stride            __IA,
    const DSPSplitComplex *__B,
    vDSP_Stride            __IB,
    const DSPSplitComplex *__C,
    vDSP_Stride            __IC,
    const DSPSplitComplex *__D,
    vDSP_Stride            __ID,
    vDSP_Length            __M,
    vDSP_Length            __N,
    vDSP_Length            __P)
        __OSX_AVAILABLE_BUT_DEPRECATED(__MAC_10_2, __MAC_10_11, __IPHONE_4_0, __IPHONE_NA);
extern void zmsm(
    const DSPSplitComplex *__A,
    vDSP_Stride            __IA,
    const DSPSplitComplex *__B,
    vDSP_Stride            __IB,
    const DSPSplitComplex *__C,
    vDSP_Stride            __IC,
    const DSPSplitComplex *__D,
    vDSP_Stride            __ID,
    vDSP_Length            __M,
    vDSP_Length            __N,
    vDSP_Length            __P)
        __OSX_AVAILABLE_BUT_DEPRECATED(__MAC_10_2, __MAC_10_11, __IPHONE_4_0, __IPHONE_NA);
extern void zmmul(
    const DSPSplitComplex *__A,
    vDSP_Stride            __IA,
    const DSPSplitComplex *__B,
    vDSP_Stride            __IB,
    const DSPSplitComplex *__C,
    vDSP_Stride            __IC,
    vDSP_Length            __M,
    vDSP_Length            __N,
    vDSP_Length            __P)
        __OSX_AVAILABLE_BUT_DEPRECATED(__MAC_10_2, __MAC_10_11, __IPHONE_4_0, __IPHONE_NA);
extern void zrvadd(
    const DSPSplitComplex *__A,
    vDSP_Stride            __IA,
    const float           *__B,
    vDSP_Stride            __IB,
    const DSPSplitComplex *__C,
    vDSP_Stride            __IC,
    vDSP_Length            __N)
        __OSX_AVAILABLE_BUT_DEPRECATED(__MAC_10_0, __MAC_10_11, __IPHONE_4_0, __IPHONE_NA);
extern void zrvmul(
    const DSPSplitComplex *__A,
    vDSP_Stride            __IA,
    const float           *__B,
    vDSP_Stride            __IB,
    const DSPSplitComplex *__C,
    vDSP_Stride            __IC,
    vDSP_Length            __N)
        __OSX_AVAILABLE_BUT_DEPRECATED(__MAC_10_0, __MAC_10_11, __IPHONE_4_0, __IPHONE_NA);
extern void zrvsub(
    const DSPSplitComplex *__A,
    vDSP_Stride            __IA,
    const float           *__B,
    vDSP_Stride            __IB,
    const DSPSplitComplex *__C,
    vDSP_Stride            __IC,
    vDSP_Length            __N)
        __OSX_AVAILABLE_BUT_DEPRECATED(__MAC_10_0, __MAC_10_11, __IPHONE_4_0, __IPHONE_NA);
extern void zrdotpr(
    const DSPSplitComplex *__A,
    vDSP_Stride            __IA,
    const float           *__B,
    vDSP_Stride            __IB,
    const DSPSplitComplex *__C,
    vDSP_Length            __N)
        __OSX_AVAILABLE_BUT_DEPRECATED(__MAC_10_0, __MAC_10_11, __IPHONE_4_0, __IPHONE_NA);
extern void fft_zipD(
    FFTSetupD                    __Setup,
    const DSPDoubleSplitComplex *__C,
    vDSP_Stride                  __IC,
    vDSP_Length                  __Log2N,
    FFTDirection                 __Direction)
        __OSX_AVAILABLE_BUT_DEPRECATED(__MAC_10_2, __MAC_10_11, __IPHONE_4_0, __IPHONE_NA);
extern void fft_ziptD(
    FFTSetupD                    __Setup,
    const DSPDoubleSplitComplex *__C,
    vDSP_Stride                  __IC,
    const DSPDoubleSplitComplex *__Buffer,
    vDSP_Length                  __Log2N,
    FFTDirection                 __Direction)
        __OSX_AVAILABLE_BUT_DEPRECATED(__MAC_10_2, __MAC_10_11, __IPHONE_4_0, __IPHONE_NA);
extern void fft_zopD(
    FFTSetupD                    __Setup,
    const DSPDoubleSplitComplex *__A,
    vDSP_Stride                  __IA,
    const DSPDoubleSplitComplex *__C,
    vDSP_Stride                  __IC,
    vDSP_Length                  __Log2N,
    FFTDirection                 __Direction)
        __OSX_AVAILABLE_BUT_DEPRECATED(__MAC_10_2, __MAC_10_11, __IPHONE_4_0, __IPHONE_NA);
extern void fft_zoptD(
    FFTSetupD                    __Setup,
    const DSPDoubleSplitComplex *__A,
    vDSP_Stride                  __IA,
    const DSPDoubleSplitComplex *__C,
    vDSP_Stride                  __IC,
    const DSPDoubleSplitComplex *__Buffer,
    vDSP_Length                  __Log2N,
    FFTDirection                 __Direction)
        __OSX_AVAILABLE_BUT_DEPRECATED(__MAC_10_2, __MAC_10_11, __IPHONE_4_0, __IPHONE_NA);
extern void fft_zripD(
    FFTSetupD                    __Setup,
    const DSPDoubleSplitComplex *__C,
    vDSP_Stride                  __IC,
    vDSP_Length                  __Log2N,
    FFTDirection                 __Direction)
        __OSX_AVAILABLE_BUT_DEPRECATED(__MAC_10_2, __MAC_10_11, __IPHONE_4_0, __IPHONE_NA);
extern void fft_zriptD(
    FFTSetupD                    __Setup,
    const DSPDoubleSplitComplex *__C,
    vDSP_Stride                  __IC,
    const DSPDoubleSplitComplex *__Buffer,
    vDSP_Length                  __Log2N,
    FFTDirection                 __Direction)
        __OSX_AVAILABLE_BUT_DEPRECATED(__MAC_10_2, __MAC_10_11, __IPHONE_4_0, __IPHONE_NA);
extern void fft_zropD(
    FFTSetupD                    __Setup,
    const DSPDoubleSplitComplex *__A,
    vDSP_Stride                  __IA,
    const DSPDoubleSplitComplex *__C,
    vDSP_Stride                  __IC,
    vDSP_Length                  __Log2N,
    FFTDirection                 __Direction)
        __OSX_AVAILABLE_BUT_DEPRECATED(__MAC_10_2, __MAC_10_11, __IPHONE_4_0, __IPHONE_NA);
extern void fft_zroptD(
    FFTSetupD                    __Setup,
    const DSPDoubleSplitComplex *__A,
    vDSP_Stride                  __IA,
    const DSPDoubleSplitComplex *__C,
    vDSP_Stride                  __IC,
    const DSPDoubleSplitComplex *__Buffer,
    vDSP_Length                  __Log2N,
    FFTDirection                 __Direction)
        __OSX_AVAILABLE_BUT_DEPRECATED(__MAC_10_2, __MAC_10_11, __IPHONE_4_0, __IPHONE_NA);
extern void fft2d_zipD(
    FFTSetupD                    __Setup,
    const DSPDoubleSplitComplex *__C,
    vDSP_Stride                  __IC0,
    vDSP_Stride                  __IC1,
    vDSP_Length                  __Log2N0,
    vDSP_Length                  __Log2N1,
    FFTDirection                 __Direction)
        __OSX_AVAILABLE_BUT_DEPRECATED(__MAC_10_2, __MAC_10_11, __IPHONE_4_0, __IPHONE_NA);
extern void fft2d_ziptD(
    FFTSetupD                    __Setup,
    const DSPDoubleSplitComplex *__C,
    vDSP_Stride                  __IC0,
    vDSP_Stride                  __IC1,
    const DSPDoubleSplitComplex *__Buffer,
    vDSP_Length                  __Log2N0,
    vDSP_Length                  __Log2N1,
    FFTDirection                 __Direction)
        __OSX_AVAILABLE_BUT_DEPRECATED(__MAC_10_2, __MAC_10_11, __IPHONE_4_0, __IPHONE_NA);
extern void fft2d_zopD(
    FFTSetupD                    __Setup,
    const DSPDoubleSplitComplex *__A,
    vDSP_Stride                  __IA0,
    vDSP_Stride                  __IA1,
    const DSPDoubleSplitComplex *__C,
    vDSP_Stride                  __IC0,
    vDSP_Stride                  __IC1,
    vDSP_Length                  __Log2N0,
    vDSP_Length                  __Log2N1,
    FFTDirection                 __Direction)
        __OSX_AVAILABLE_BUT_DEPRECATED(__MAC_10_2, __MAC_10_11, __IPHONE_4_0, __IPHONE_NA);
extern void fft2d_zoptD(
    FFTSetupD                    __Setup,
    const DSPDoubleSplitComplex *__A,
    vDSP_Stride                  __IA0,
    vDSP_Stride                  __IA1,
    const DSPDoubleSplitComplex *__C,
    vDSP_Stride                  __IC0,
    vDSP_Stride                  __IC1,
    const DSPDoubleSplitComplex *__Buffer,
    vDSP_Length                  __Log2N0,
    vDSP_Length                  __Log2N1,
    FFTDirection                 __Direction)
        __OSX_AVAILABLE_BUT_DEPRECATED(__MAC_10_2, __MAC_10_11, __IPHONE_4_0, __IPHONE_NA);
extern void fft2d_zripD(
    FFTSetupD                    __Setup,
    const DSPDoubleSplitComplex *__C,
    vDSP_Stride                  __IC0,
    vDSP_Stride                  __IC1,
    vDSP_Length                  __Log2N0,
    vDSP_Length                  __Log2N1,
    FFTDirection                 __flag)
        __OSX_AVAILABLE_BUT_DEPRECATED(__MAC_10_2, __MAC_10_11, __IPHONE_4_0, __IPHONE_NA);
extern void fft2d_zriptD(
    FFTSetupD                    __Setup,
    const DSPDoubleSplitComplex *__C,
    vDSP_Stride                  __IC0,
    vDSP_Stride                  __IC1,
    const DSPDoubleSplitComplex *__Buffer,
    vDSP_Length                  __Log2N0,
    vDSP_Length                  __Log2N1,
    FFTDirection                 __flag)
        __OSX_AVAILABLE_BUT_DEPRECATED(__MAC_10_2, __MAC_10_11, __IPHONE_4_0, __IPHONE_NA);
extern void fft2d_zropD(
    FFTSetupD                    __Setup,
    const DSPDoubleSplitComplex *__A,
    vDSP_Stride                  __IA0,
    vDSP_Stride                  __IA1,
    const DSPDoubleSplitComplex *__C,
    vDSP_Stride                  __IC0,
    vDSP_Stride                  __IC1,
    vDSP_Length                  __Log2N0,
    vDSP_Length                  __Log2N1,
    FFTDirection                 __Direction)
        __OSX_AVAILABLE_BUT_DEPRECATED(__MAC_10_2, __MAC_10_11, __IPHONE_4_0, __IPHONE_NA);
extern void fft2d_zroptD(
    FFTSetupD                    __Setup,
    const DSPDoubleSplitComplex *__A,
    vDSP_Stride                  __IA0,
    vDSP_Stride                  __IA1,
    const DSPDoubleSplitComplex *__C,
    vDSP_Stride                  __IC0,
    vDSP_Stride                  __IC1,
    const DSPDoubleSplitComplex *__Buffer,
    vDSP_Length                  __Log2N0,
    vDSP_Length                  __Log2N1,
    FFTDirection                 __Direction)
        __OSX_AVAILABLE_BUT_DEPRECATED(__MAC_10_2, __MAC_10_11, __IPHONE_4_0, __IPHONE_NA);
extern void fftm_zipD(
    FFTSetupD                    __Setup,
    const DSPDoubleSplitComplex *__C,
    vDSP_Stride                  __IC,
    vDSP_Stride                  __IM,
    vDSP_Length                  __Log2N,
    vDSP_Length                  __M,
    FFTDirection                 __Direction)
        __OSX_AVAILABLE_BUT_DEPRECATED(__MAC_10_2, __MAC_10_11, __IPHONE_4_0, __IPHONE_NA);
extern void fftm_ziptD(
    FFTSetupD                    __Setup,
    const DSPDoubleSplitComplex *__C,
    vDSP_Stride                  __IC,
    vDSP_Stride                  __IM,
    const DSPDoubleSplitComplex *__Buffer,
    vDSP_Length                  __Log2N,
    vDSP_Length                  __M,
    FFTDirection                 __Direction)
        __OSX_AVAILABLE_BUT_DEPRECATED(__MAC_10_2, __MAC_10_11, __IPHONE_4_0, __IPHONE_NA);
extern void fftm_zopD(
    FFTSetupD                    __Setup,
    const DSPDoubleSplitComplex *__A,
    vDSP_Stride                  __IA,
    vDSP_Stride                  __IMA,
    const DSPDoubleSplitComplex *__C,
    vDSP_Stride                  __IC,
    vDSP_Stride                  __IMC,
    vDSP_Length                  __Log2N,
    vDSP_Length                  __M,
    FFTDirection                 __Direction)
        __OSX_AVAILABLE_BUT_DEPRECATED(__MAC_10_2, __MAC_10_11, __IPHONE_4_0, __IPHONE_NA);
extern void fftm_zoptD(
    FFTSetupD                    __Setup,
    const DSPDoubleSplitComplex *__A,
    vDSP_Stride                  __IA,
    vDSP_Stride                  __IMA,
    const DSPDoubleSplitComplex *__C,
    vDSP_Stride                  __IC,
    vDSP_Stride                  __IMC,
    const DSPDoubleSplitComplex *__Buffer,
    vDSP_Length                  __Log2N,
    vDSP_Length                  __M,
    FFTDirection                 __Direction)
        __OSX_AVAILABLE_BUT_DEPRECATED(__MAC_10_2, __MAC_10_11, __IPHONE_4_0, __IPHONE_NA);
extern void fftm_zripD(
    FFTSetupD                    __Setup,
    const DSPDoubleSplitComplex *__C,
    vDSP_Stride                  __IC,
    vDSP_Stride                  __IM,
    vDSP_Length                  __Log2N,
    vDSP_Length                  __M,
    FFTDirection                 __Direction)
        __OSX_AVAILABLE_BUT_DEPRECATED(__MAC_10_2, __MAC_10_11, __IPHONE_4_0, __IPHONE_NA);
extern void fftm_zriptD(
    FFTSetupD                    __Setup,
    const DSPDoubleSplitComplex *__C,
    vDSP_Stride                  __IC,
    vDSP_Stride                  __IM,
    const DSPDoubleSplitComplex *__Buffer,
    vDSP_Length                  __Log2N,
    vDSP_Length                  __M,
    FFTDirection                 __Direction)
        __OSX_AVAILABLE_BUT_DEPRECATED(__MAC_10_2, __MAC_10_11, __IPHONE_4_0, __IPHONE_NA);
extern void fftm_zropD(
    FFTSetupD                    __Setup,
    const DSPDoubleSplitComplex *__A,
    vDSP_Stride                  __IA,
    vDSP_Stride                  __IMA,
    const DSPDoubleSplitComplex *__C,
    vDSP_Stride                  __IC,
    vDSP_Stride                  __IMC,
    vDSP_Length                  __Log2N,
    vDSP_Length                  __M,
    FFTDirection                 __Direction)
        __OSX_AVAILABLE_BUT_DEPRECATED(__MAC_10_2, __MAC_10_11, __IPHONE_4_0, __IPHONE_NA);
extern void fftm_zroptD(
    FFTSetupD                    __Setup,
    const DSPDoubleSplitComplex *__A,
    vDSP_Stride                  __IA,
    vDSP_Stride                  __IMA,
    const DSPDoubleSplitComplex *__C,
    vDSP_Stride                  __IC,
    vDSP_Stride                  __IMC,
    const DSPDoubleSplitComplex *__Buffer,
    vDSP_Length                  __Log2N,
    vDSP_Length                  __M,
    FFTDirection                 __Direction)
        __OSX_AVAILABLE_BUT_DEPRECATED(__MAC_10_2, __MAC_10_11, __IPHONE_4_0, __IPHONE_NA);
extern void fft3_zopD(
    FFTSetupD                    __Setup,
    const DSPDoubleSplitComplex *__A,
    vDSP_Stride                  __IA,
    const DSPDoubleSplitComplex *__C,
    vDSP_Stride                  __IC,
    vDSP_Length                  __Log2N,
    FFTDirection                 __Direction)
        __OSX_AVAILABLE_BUT_DEPRECATED(__MAC_10_2, __MAC_10_11, __IPHONE_4_0, __IPHONE_9_0);
extern void fft5_zopD(
    FFTSetupD                    __Setup,
    const DSPDoubleSplitComplex *__A,
    vDSP_Stride                  __IA,
    const DSPDoubleSplitComplex *__C,
    vDSP_Stride                  __IC,
    vDSP_Length                  __Log2N,
    FFTDirection                 __Direction)
        __OSX_AVAILABLE_BUT_DEPRECATED(__MAC_10_2, __MAC_10_11, __IPHONE_4_0, __IPHONE_9_0);
extern void ctozD(
    const DSPDoubleComplex      *__C,
    vDSP_Stride                  __IC,
    const DSPDoubleSplitComplex *__Z,
    vDSP_Stride                  __IZ,
    vDSP_Length                  __N)
        __OSX_AVAILABLE_BUT_DEPRECATED(__MAC_10_2, __MAC_10_11, __IPHONE_4_0, __IPHONE_NA);
extern void ztocD(
    const DSPDoubleSplitComplex *__Z,
    vDSP_Stride                  __IZ,
    DSPDoubleComplex            *__C,
    vDSP_Stride                  __IC,
    vDSP_Length                  __N)
        __OSX_AVAILABLE_BUT_DEPRECATED(__MAC_10_2, __MAC_10_11, __IPHONE_4_0, __IPHONE_NA);
extern void vsmulD(
    const double *__A,
    vDSP_Stride   __IA,
    const double *__B,
    double       *__C,
    vDSP_Stride   __IC,
    vDSP_Length   __N)
        __OSX_AVAILABLE_BUT_DEPRECATED(__MAC_10_2, __MAC_10_11, __IPHONE_4_0, __IPHONE_NA);
extern FFTSetupD create_fftsetupD(
    vDSP_Length __Log2n,
    FFTRadix    __Radix)
        __OSX_AVAILABLE_BUT_DEPRECATED(__MAC_10_2, __MAC_10_11, __IPHONE_4_0, __IPHONE_NA);
extern void destroy_fftsetupD(FFTSetupD __setup)
        __OSX_AVAILABLE_BUT_DEPRECATED(__MAC_10_2, __MAC_10_11, __IPHONE_4_0, __IPHONE_NA);
extern void f3x3D(
    const double *__A,
    vDSP_Length   __NR,
    vDSP_Length   __NC,
    const double *__F,
    double       *__C)
        __OSX_AVAILABLE_BUT_DEPRECATED(__MAC_10_2, __MAC_10_11, __IPHONE_4_0, __IPHONE_NA);
extern void f5x5D(
    const double *__A,
    vDSP_Length   __NR,
    vDSP_Length   __NC,
    const double *__F,
    double       *__C)
        __OSX_AVAILABLE_BUT_DEPRECATED(__MAC_10_2, __MAC_10_11, __IPHONE_4_0, __IPHONE_NA);
extern void convD(
    const double *__A, 
    vDSP_Stride   __IA,
    const double *__F, 
    vDSP_Stride   __IF,
    double       *__C, 
    vDSP_Stride   __IC,
    vDSP_Length   __N, 
    vDSP_Length   __P) 
        __OSX_AVAILABLE_BUT_DEPRECATED(__MAC_10_2, __MAC_10_11, __IPHONE_4_0, __IPHONE_NA);
extern void dotprD(
    const double *__A,
    vDSP_Stride   __IA,
    const double *__B,
    vDSP_Stride   __IB,
    double       *__C,
    vDSP_Length   __N)
        __OSX_AVAILABLE_BUT_DEPRECATED(__MAC_10_2, __MAC_10_11, __IPHONE_4_0, __IPHONE_NA);
extern void imgfirD(
    const double *__A,  
    vDSP_Length   __NR, 
    vDSP_Length   __NC, 
    const double *__F,  
    double       *__C,  
    vDSP_Length   __P,  
    vDSP_Length   __Q)  
        __OSX_AVAILABLE_BUT_DEPRECATED(__MAC_10_2, __MAC_10_11, __IPHONE_4_0, __IPHONE_NA);
extern void mtransD(
    const double *__A,
    vDSP_Stride   __IA,
    double       *__C,
    vDSP_Stride   __IC,
    vDSP_Length   __M,
    vDSP_Length   __N)
            __OSX_AVAILABLE_BUT_DEPRECATED(__MAC_10_2, __MAC_10_11, __IPHONE_4_0, __IPHONE_NA);
extern void mmulD(
    const double *__A,
    vDSP_Stride   __IA,
    const double *__B,
    vDSP_Stride   __IB,
    double       *__C,
    vDSP_Stride   __IC,
    vDSP_Length   __M,
    vDSP_Length   __N,
    vDSP_Length   __P)
        __OSX_AVAILABLE_BUT_DEPRECATED(__MAC_10_2, __MAC_10_11, __IPHONE_4_0, __IPHONE_NA);
extern void vaddD(
    const double *__A,
    vDSP_Stride   __IA,
    const double *__B,
    vDSP_Stride   __IB,
    double       *__C,
    vDSP_Stride   __IC,
    vDSP_Length   __N)
        __OSX_AVAILABLE_BUT_DEPRECATED(__MAC_10_2, __MAC_10_11, __IPHONE_4_0, __IPHONE_NA);
extern void vsubD(
    const double *__B, 
    vDSP_Stride   __IB,
    const double *__A, 
    vDSP_Stride   __IA,
    double       *__C,
    vDSP_Stride   __IC,
    vDSP_Length   __N)
        __OSX_AVAILABLE_BUT_DEPRECATED(__MAC_10_2, __MAC_10_11, __IPHONE_4_0, __IPHONE_NA);
extern void vmulD(
    const double *__A,
    vDSP_Stride   __IA,
    const double *__B,
    vDSP_Stride   __IB,
    double       *__C,
    vDSP_Stride   __IC,
    vDSP_Length   __N)
        __OSX_AVAILABLE_BUT_DEPRECATED(__MAC_10_2, __MAC_10_11, __IPHONE_4_0, __IPHONE_NA);
extern void vamD(
    const double *__A,
    vDSP_Stride   __IA,
    const double *__B,
    vDSP_Stride   __IB,
    const double *__C,
    vDSP_Stride   __IC,
    double       *__D,
    vDSP_Stride   __IDD,
    vDSP_Length   __N)
        __OSX_AVAILABLE_BUT_DEPRECATED(__MAC_10_2, __MAC_10_11, __IPHONE_4_0, __IPHONE_NA);
extern void vsqD(
    const double *__A,
    vDSP_Stride   __IA,
    double       *__C,
    vDSP_Stride   __IC,
    vDSP_Length   __N)
        __OSX_AVAILABLE_BUT_DEPRECATED(__MAC_10_2, __MAC_10_11, __IPHONE_4_0, __IPHONE_NA);
extern void vssqD(
    const double *__A,
    vDSP_Stride   __IA,
    double       *__C,
    vDSP_Stride   __IC,
    vDSP_Length   __N)
        __OSX_AVAILABLE_BUT_DEPRECATED(__MAC_10_2, __MAC_10_11, __IPHONE_4_0, __IPHONE_NA);
extern void zvaddD(
    const DSPDoubleSplitComplex *__A,
    vDSP_Stride                  __IA,
    const DSPDoubleSplitComplex *__B,
    vDSP_Stride                  __IB,
    const DSPDoubleSplitComplex *__C,
    vDSP_Stride                  __IC,
    vDSP_Length                  __N)
        __OSX_AVAILABLE_BUT_DEPRECATED(__MAC_10_2, __MAC_10_11, __IPHONE_4_0, __IPHONE_NA);
extern void zvsubD(
    const DSPDoubleSplitComplex *__A,
    vDSP_Stride                  __IA,
    const DSPDoubleSplitComplex *__B,
    vDSP_Stride                  __IB,
    const DSPDoubleSplitComplex *__C,
    vDSP_Stride                  __IC,
    vDSP_Length                  __N)
        __OSX_AVAILABLE_BUT_DEPRECATED(__MAC_10_2, __MAC_10_11, __IPHONE_4_0, __IPHONE_NA);
extern void zdotprD(
    const DSPDoubleSplitComplex *__A,
    vDSP_Stride                  __IA,
    const DSPDoubleSplitComplex *__B,
    vDSP_Stride                  __IB,
    const DSPDoubleSplitComplex *__C,
    vDSP_Length                  __N)
        __OSX_AVAILABLE_BUT_DEPRECATED(__MAC_10_2, __MAC_10_11, __IPHONE_4_0, __IPHONE_NA);
extern void zconvD(
    const DSPDoubleSplitComplex *__A,    
    vDSP_Stride                  __IA,
    const DSPDoubleSplitComplex *__F,    
    vDSP_Stride                  __IF,
    const DSPDoubleSplitComplex *__C,    
    vDSP_Stride                  __IC,
    vDSP_Length                  __N,    
    vDSP_Length                  __P)    
        __OSX_AVAILABLE_BUT_DEPRECATED(__MAC_10_2, __MAC_10_11, __IPHONE_4_0, __IPHONE_NA);
extern void zvcmaD(
    const DSPDoubleSplitComplex *__A,
    vDSP_Stride                  __IA,
    const DSPDoubleSplitComplex *__B,
    vDSP_Stride                  __IB,
    const DSPDoubleSplitComplex *__C,
    vDSP_Stride                  __IC,
    const DSPDoubleSplitComplex *__D,
    vDSP_Stride                  __ID,
    vDSP_Length                  __N)
        __OSX_AVAILABLE_BUT_DEPRECATED(__MAC_10_2, __MAC_10_11, __IPHONE_4_0, __IPHONE_NA);
extern void zvmulD(
    const DSPDoubleSplitComplex *__A,
    vDSP_Stride                  __IA,
    const DSPDoubleSplitComplex *__B,
    vDSP_Stride                  __IB,
    const DSPDoubleSplitComplex *__C,
    vDSP_Stride                  __IC,
    vDSP_Length                  __N,
    int                          __Conjugate)
        __OSX_AVAILABLE_BUT_DEPRECATED(__MAC_10_2, __MAC_10_11, __IPHONE_4_0, __IPHONE_NA);
extern void zidotprD(
    const DSPDoubleSplitComplex *__A,
    vDSP_Stride                  __IA,
    const DSPDoubleSplitComplex *__B,
    vDSP_Stride                  __IB,
    const DSPDoubleSplitComplex *__C,
    vDSP_Length                  __N)
        __OSX_AVAILABLE_BUT_DEPRECATED(__MAC_10_2, __MAC_10_11, __IPHONE_4_0, __IPHONE_NA);
extern void zmmaD(
    const DSPDoubleSplitComplex *__A,
    vDSP_Stride                  __IA,
    const DSPDoubleSplitComplex *__B,
    vDSP_Stride                  __IB,
    const DSPDoubleSplitComplex *__C,
    vDSP_Stride                  __IC,
    const DSPDoubleSplitComplex *__D,
    vDSP_Stride                  __ID,
    vDSP_Length                  __M,
    vDSP_Length                  __N,
    vDSP_Length                  __P)
        __OSX_AVAILABLE_BUT_DEPRECATED(__MAC_10_2, __MAC_10_11, __IPHONE_4_0, __IPHONE_NA);
extern void zmmsD(
    const DSPDoubleSplitComplex *__A,
    vDSP_Stride                  __IA,
    const DSPDoubleSplitComplex *__B,
    vDSP_Stride                  __IB,
    const DSPDoubleSplitComplex *__C,
    vDSP_Stride                  __IC,
    const DSPDoubleSplitComplex *__D,
    vDSP_Stride                  __ID,
    vDSP_Length                  __M,
    vDSP_Length                  __N,
    vDSP_Length                  __P)
        __OSX_AVAILABLE_BUT_DEPRECATED(__MAC_10_2, __MAC_10_11, __IPHONE_4_0, __IPHONE_NA);
extern void zmsmD(
    const DSPDoubleSplitComplex *__A,
    vDSP_Stride                  __IA,
    const DSPDoubleSplitComplex *__B,
    vDSP_Stride                  __IB,
    const DSPDoubleSplitComplex *__C,
    vDSP_Stride                  __IC,
    const DSPDoubleSplitComplex *__D,
    vDSP_Stride                  __ID,
    vDSP_Length                  __M,
    vDSP_Length                  __N,
    vDSP_Length                  __P)
        __OSX_AVAILABLE_BUT_DEPRECATED(__MAC_10_2, __MAC_10_11, __IPHONE_4_0, __IPHONE_NA);
extern void zmmulD(
    const DSPDoubleSplitComplex *__A,
    vDSP_Stride                  __IA,
    const DSPDoubleSplitComplex *__B,
    vDSP_Stride                  __IB,
    const DSPDoubleSplitComplex *__C,
    vDSP_Stride                  __IC,
    vDSP_Length                  __M,
    vDSP_Length                  __N,
    vDSP_Length                  __P)
        __OSX_AVAILABLE_BUT_DEPRECATED(__MAC_10_2, __MAC_10_11, __IPHONE_4_0, __IPHONE_NA);
extern void zrvaddD(
    const DSPDoubleSplitComplex *__A,
    vDSP_Stride                  __IA,
    const double                *__B,
    vDSP_Stride                  __IB,
    const DSPDoubleSplitComplex *__C,
    vDSP_Stride                  __IC,
    vDSP_Length                  __N)
        __OSX_AVAILABLE_BUT_DEPRECATED(__MAC_10_2, __MAC_10_11, __IPHONE_4_0, __IPHONE_NA);
extern void zrvmulD(
    const DSPDoubleSplitComplex *__A,
    vDSP_Stride                  __IA,
    const double                *__B,
    vDSP_Stride                  __IB,
    const DSPDoubleSplitComplex *__C,
    vDSP_Stride                  __IC,
    vDSP_Length                  __N)
        __OSX_AVAILABLE_BUT_DEPRECATED(__MAC_10_2, __MAC_10_11, __IPHONE_4_0, __IPHONE_NA);
extern void zrvsubD(
    const DSPDoubleSplitComplex *__A,
    vDSP_Stride                  __IA,
    const double                *__B,
    vDSP_Stride                  __IB,
    const DSPDoubleSplitComplex *__C,
    vDSP_Stride                  __IC,
    vDSP_Length                  __N)
        __OSX_AVAILABLE_BUT_DEPRECATED(__MAC_10_2, __MAC_10_11, __IPHONE_4_0, __IPHONE_NA);
extern void zrdotprD(
    const DSPDoubleSplitComplex *__A,
    vDSP_Stride                  __IA,
    const double                *__B,
    vDSP_Stride                  __IB,
    const DSPDoubleSplitComplex *__C,
    vDSP_Length                  __N)
        __OSX_AVAILABLE_BUT_DEPRECATED(__MAC_10_2, __MAC_10_11, __IPHONE_4_0, __IPHONE_NA);
#endif  
#ifndef USE_NON_APPLE_STANDARD_DATATYPES
#define USE_NON_APPLE_STANDARD_DATATYPES 1
#endif  
#if USE_NON_APPLE_STANDARD_DATATYPES
enum {
    FFT_FORWARD = kFFTDirection_Forward,
    FFT_INVERSE = kFFTDirection_Inverse
};
enum {
    FFT_RADIX2  = kFFTRadix2,
    FFT_RADIX3  = kFFTRadix3,
    FFT_RADIX5  = kFFTRadix5
};
typedef DSPComplex                      COMPLEX;
typedef DSPSplitComplex                 COMPLEX_SPLIT;
typedef DSPDoubleComplex                DOUBLE_COMPLEX;
typedef DSPDoubleSplitComplex           DOUBLE_COMPLEX_SPLIT;
#endif  
#pragma options align=reset
#if __has_feature(assume_nonnull)
    _Pragma("clang assume_nonnull end")
#endif
#ifdef __cplusplus
}
#endif
#endif 
