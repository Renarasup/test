#ifndef __VFP__
#define __VFP__
#if defined __SSE2__ || defined __ARM_NEON__
#include "vecLibTypes.h"
#include <stdint.h>
#include <Availability.h>
#ifdef __cplusplus
extern "C" {
#endif
#if defined __SSE4_1__
#include <immintrin.h>
#define __VFP_INLINE_ATTR__ __attribute__((__always_inline__, __nodebug__))
static __inline__ vFloat __VFP_INLINE_ATTR__  vceilf(vFloat __vfp_a) { return _mm_ceil_ps(__vfp_a); }
static __inline__ vFloat __VFP_INLINE_ATTR__ vfloorf(vFloat __vfp_a) { return _mm_floor_ps(__vfp_a); }
static __inline__ vFloat __VFP_INLINE_ATTR__ vtruncf(vFloat __vfp_a) { return _mm_round_ps(__vfp_a, _MM_FROUND_TRUNC); }
static __inline__ vFloat __VFP_INLINE_ATTR__  vnintf(vFloat __vfp_a) { return _mm_round_ps(__vfp_a, _MM_FROUND_NINT); }
#else
extern vFloat  vceilf(vFloat) __OSX_AVAILABLE_STARTING(__MAC_10_5, __IPHONE_6_0);
extern vFloat vfloorf(vFloat) __OSX_AVAILABLE_STARTING(__MAC_10_5, __IPHONE_6_0);
extern vFloat vtruncf(vFloat) __OSX_AVAILABLE_STARTING(__MAC_10_9, __IPHONE_6_0);
extern vFloat  vnintf(vFloat) __OSX_AVAILABLE_STARTING(__MAC_10_5, __IPHONE_6_0);
extern vFloat   vintf(vFloat) __OSX_AVAILABLE_STARTING(__MAC_10_5, __IPHONE_NA);
#endif
#if !defined __has_feature
    #define __has_feature(f)    0
#endif
#if __has_feature(assume_nonnull)
    _Pragma("clang assume_nonnull begin")
#else
    #define __nullable
    #define __nonnull
#endif
extern vFloat   vexpf(vFloat) __OSX_AVAILABLE_STARTING(__MAC_10_0, __IPHONE_6_0);
extern vFloat  vexp2f(vFloat) __OSX_AVAILABLE_STARTING(__MAC_10_9, __IPHONE_6_0);
extern vFloat vexpm1f(vFloat) __OSX_AVAILABLE_STARTING(__MAC_10_0, __IPHONE_6_0);
extern vFloat   vlogf(vFloat) __OSX_AVAILABLE_STARTING(__MAC_10_0, __IPHONE_6_0);
extern vFloat  vlog2f(vFloat) __OSX_AVAILABLE_STARTING(__MAC_10_9, __IPHONE_6_0);
extern vFloat vlog10f(vFloat) __OSX_AVAILABLE_STARTING(__MAC_10_5, __IPHONE_6_0);
extern vFloat vlog1pf(vFloat) __OSX_AVAILABLE_STARTING(__MAC_10_0, __IPHONE_6_0);
extern vFloat  vlogbf(vFloat) __OSX_AVAILABLE_STARTING(__MAC_10_0, __IPHONE_6_0);
extern vFloat vscalbf(vFloat, vSInt32) __OSX_AVAILABLE_STARTING(__MAC_10_0, __IPHONE_6_0);
extern vFloat  vpowf(vFloat, vFloat)  __OSX_AVAILABLE_STARTING(__MAC_10_0, __IPHONE_6_0);
extern vFloat vipowf(vFloat, vSInt32) __OSX_AVAILABLE_STARTING(__MAC_10_0, __IPHONE_6_0);
extern vFloat    vsinf(vFloat) __OSX_AVAILABLE_STARTING(__MAC_10_0, __IPHONE_6_0);
extern vFloat    vcosf(vFloat) __OSX_AVAILABLE_STARTING(__MAC_10_0, __IPHONE_6_0);
extern vFloat vsincosf(vFloat, vFloat *) __OSX_AVAILABLE_STARTING(__MAC_10_5, __IPHONE_6_0);
extern vFloat    vtanf(vFloat) __OSX_AVAILABLE_STARTING(__MAC_10_0, __IPHONE_6_0);
extern vFloat  vsinpif(vFloat) __OSX_AVAILABLE_STARTING(__MAC_10_9, __IPHONE_6_0);
extern vFloat  vcospif(vFloat) __OSX_AVAILABLE_STARTING(__MAC_10_9, __IPHONE_6_0);
extern vFloat  vtanpif(vFloat) __OSX_AVAILABLE_STARTING(__MAC_10_9, __IPHONE_6_0);
extern vFloat   vasinf(vFloat) __OSX_AVAILABLE_STARTING(__MAC_10_0, __IPHONE_6_0);
extern vFloat   vacosf(vFloat) __OSX_AVAILABLE_STARTING(__MAC_10_0, __IPHONE_6_0);
extern vFloat   vatanf(vFloat) __OSX_AVAILABLE_STARTING(__MAC_10_0, __IPHONE_6_0);
extern vFloat  vatan2f(vFloat, vFloat) __OSX_AVAILABLE_STARTING(__MAC_10_0, __IPHONE_6_0);
extern vFloat   vsinhf(vFloat) __OSX_AVAILABLE_STARTING(__MAC_10_0, __IPHONE_6_0);
extern vFloat   vcoshf(vFloat) __OSX_AVAILABLE_STARTING(__MAC_10_0, __IPHONE_6_0);
extern vFloat   vtanhf(vFloat) __OSX_AVAILABLE_STARTING(__MAC_10_0, __IPHONE_6_0);
extern vFloat  vasinhf(vFloat) __OSX_AVAILABLE_STARTING(__MAC_10_0, __IPHONE_6_0);
extern vFloat  vacoshf(vFloat) __OSX_AVAILABLE_STARTING(__MAC_10_0, __IPHONE_6_0);
extern vFloat  vatanhf(vFloat) __OSX_AVAILABLE_STARTING(__MAC_10_0, __IPHONE_6_0);
extern vFloat   vrecf(vFloat) __OSX_AVAILABLE_STARTING(__MAC_10_5, __IPHONE_6_0);
extern vFloat  vsqrtf(vFloat) __OSX_AVAILABLE_STARTING(__MAC_10_0, __IPHONE_6_0);
extern vFloat vrsqrtf(vFloat) __OSX_AVAILABLE_STARTING(__MAC_10_0, __IPHONE_6_0);
extern vFloat   vdivf(vFloat, vFloat) __OSX_AVAILABLE_STARTING(__MAC_10_0, __IPHONE_6_0);
extern vFloat      vfmodf(vFloat, vFloat) __OSX_AVAILABLE_STARTING(__MAC_10_0, __IPHONE_6_0);
extern vFloat vremainderf(vFloat, vFloat) __OSX_AVAILABLE_STARTING(__MAC_10_0, __IPHONE_6_0);
extern vFloat    vremquof(vFloat, vFloat, vUInt32 *) __OSX_AVAILABLE_STARTING(__MAC_10_0, __IPHONE_6_0);
extern vFloat       vfabsf(vFloat)         __OSX_AVAILABLE_STARTING(__MAC_10_9, __IPHONE_6_0);
extern vFloat   vcopysignf(vFloat, vFloat) __OSX_AVAILABLE_STARTING(__MAC_10_0, __IPHONE_6_0);
extern vUInt32   vsignbitf(vFloat)         __OSX_AVAILABLE_STARTING(__MAC_10_0, __IPHONE_6_0);
extern vFloat  vnextafterf(vFloat, vFloat) __OSX_AVAILABLE_STARTING(__MAC_10_0, __IPHONE_6_0);
extern vUInt32  vclassifyf(vFloat)         __OSX_AVAILABLE_STARTING(__MAC_10_0, __IPHONE_6_0);
extern vFloat        vfabf(vFloat)         __OSX_AVAILABLE_STARTING(__MAC_10_0, __IPHONE_NA);
extern vUInt32 vtablelookup(vSInt32, uint32_t *) __OSX_AVAILABLE_STARTING(__MAC_10_0, __IPHONE_6_0);
#if __has_feature(assume_nonnull)
    _Pragma("clang assume_nonnull end")
#endif
#ifdef __cplusplus
}
#endif
#endif 
#endif 
