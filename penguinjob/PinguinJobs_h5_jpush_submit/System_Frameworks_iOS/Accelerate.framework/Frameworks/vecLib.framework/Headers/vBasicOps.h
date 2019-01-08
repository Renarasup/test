#ifndef __VBASICOPS__
#define __VBASICOPS__
#include <stdint.h>
#include "vecLibTypes.h"
#include <Availability.h>
#if PRAGMA_ONCE
#pragma once
#endif
#ifdef __cplusplus
extern "C" {
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
#if defined(__ppc__) || defined(__ppc64__) || defined(__i386__) || defined(__x86_64__)
#if defined _AltiVecPIMLanguageExtensionsAreEnabled || defined __SSE2__
#if defined __SSE2__
#if __has_feature(assume_nonnull)
    _Pragma("clang assume_nonnull end")
	#include <immintrin.h>
    _Pragma("clang assume_nonnull begin")
#else
	#include <immintrin.h>
#endif
#define __VBASICOPS_INLINE_ATTR__ __attribute__((__always_inline__, __nodebug__))
#endif 
extern vUInt8 
vU8Divide(
  vUInt8    vN,
  vUInt8    vD,
  vUInt8 * __nullable vRemainder)
    __OSX_AVAILABLE_STARTING(__MAC_10_0, __IPHONE_NA);
extern vSInt8 
vS8Divide(
  vSInt8    vN,
  vSInt8    vD,
  vSInt8 * __nullable vRemainder)
    __OSX_AVAILABLE_STARTING(__MAC_10_0, __IPHONE_NA);
extern vUInt16 
vU16Divide(
  vUInt16    vN,
  vUInt16    vD,
  vUInt16 * __nullable vRemainder)
    __OSX_AVAILABLE_STARTING(__MAC_10_0, __IPHONE_NA);
extern vSInt16 
vS16Divide(
  vSInt16    vN,
  vSInt16    vD,
  vSInt16 * __nullable vRemainder)
    __OSX_AVAILABLE_STARTING(__MAC_10_0, __IPHONE_NA);
extern vUInt32 
vU32Divide(
  vUInt32    vN,
  vUInt32    vD,
  vUInt32 * __nullable vRemainder)
    __OSX_AVAILABLE_STARTING(__MAC_10_0, __IPHONE_NA);
extern vSInt32 
vS32Divide(
  vSInt32    vN,
  vSInt32    vD,
  vSInt32 * __nullable vRemainder)
    __OSX_AVAILABLE_STARTING(__MAC_10_0, __IPHONE_NA);
extern vUInt32 
vU64Divide(
  vUInt32    vN,
  vUInt32    vD,
  vUInt32 * __nullable vRemainder)
    __OSX_AVAILABLE_STARTING(__MAC_10_0, __IPHONE_NA);
extern vSInt32 
vS64Divide(
  vSInt32    vN,
  vSInt32    vD,
  vSInt32 * __nullable vRemainder)
    __OSX_AVAILABLE_STARTING(__MAC_10_0, __IPHONE_NA);
extern vUInt32 
vU128Divide(
  vUInt32    vN,
  vUInt32    vD,
  vUInt32 * __nullable vRemainder)
    __OSX_AVAILABLE_STARTING(__MAC_10_0, __IPHONE_NA);
extern vSInt32 
vS128Divide(
  vSInt32    vN,
  vSInt32    vD,
  vSInt32 * __nullable vRemainder)
    __OSX_AVAILABLE_STARTING(__MAC_10_0, __IPHONE_NA);
extern vUInt8 
vU8HalfMultiply(
  vUInt8   vA,
  vUInt8   vB) __OSX_AVAILABLE_STARTING(__MAC_10_0, __IPHONE_NA);
extern vSInt8 
vS8HalfMultiply(
  vSInt8   vA,
  vSInt8   vB) __OSX_AVAILABLE_STARTING(__MAC_10_0, __IPHONE_NA);
#if defined __SSE2__
static __inline__ vUInt16 __VBASICOPS_INLINE_ATTR__
vU16HalfMultiply(
  vUInt16   __vbasicops_vA,
  vUInt16   __vbasicops_vB) { return _mm_mullo_epi16(__vbasicops_vA, __vbasicops_vB); }
#else 
extern vUInt16 
vU16HalfMultiply(
  vUInt16   vA,
  vUInt16   vB) __OSX_AVAILABLE_STARTING(__MAC_10_0, __IPHONE_NA);
#endif 
#if defined __SSE2__
static __inline__ vSInt16 __VBASICOPS_INLINE_ATTR__
vS16HalfMultiply(
  vSInt16   __vbasicops_vA,
  vSInt16   __vbasicops_vB) { return _mm_mullo_epi16(__vbasicops_vA, __vbasicops_vB); }
#else 
extern vSInt16 
vS16HalfMultiply(
  vSInt16   vA,
  vSInt16   vB) __OSX_AVAILABLE_STARTING(__MAC_10_0, __IPHONE_NA);
#endif 
extern vUInt32 
vU32HalfMultiply(
  vUInt32   vA,
  vUInt32   vB) __OSX_AVAILABLE_STARTING(__MAC_10_0, __IPHONE_NA);
extern vSInt32 
vS32HalfMultiply(
  vSInt32   vA,
  vSInt32   vB) __OSX_AVAILABLE_STARTING(__MAC_10_0, __IPHONE_NA);
#if defined (__SSE2__)
static __inline__ vUInt32 __VBASICOPS_INLINE_ATTR__
vU32FullMulEven(
  vUInt32   __vbasicops_vA,
  vUInt32   __vbasicops_vB)
{
    __vbasicops_vA = _mm_srli_epi64(__vbasicops_vA, 32);
    __vbasicops_vB = _mm_srli_epi64(__vbasicops_vB, 32);
    return _mm_mul_epu32(__vbasicops_vA, __vbasicops_vB);
}
#else 
extern vUInt32 
vU32FullMulEven(
  vUInt32   vA,
  vUInt32   vB) __OSX_AVAILABLE_STARTING(__MAC_10_0, __IPHONE_NA);
#endif 
#if defined __SSE2__
static __inline__ vUInt32 __VBASICOPS_INLINE_ATTR__
vU32FullMulOdd(
  vUInt32   __vbasicops_vA,
  vUInt32   __vbasicops_vB) { return _mm_mul_epu32(__vbasicops_vA, __vbasicops_vB); }
#else 
extern vUInt32 
vU32FullMulOdd(
  vUInt32   vA,
  vUInt32   vB) __OSX_AVAILABLE_STARTING(__MAC_10_0, __IPHONE_NA);
#endif 
extern vSInt32 
vS32FullMulEven(
  vSInt32   vA,
  vSInt32   vB) __OSX_AVAILABLE_STARTING(__MAC_10_0, __IPHONE_NA);
extern vSInt32 
vS32FullMulOdd(
  vSInt32   vA,
  vSInt32   vB) __OSX_AVAILABLE_STARTING(__MAC_10_0, __IPHONE_NA);
extern vUInt32 
vU64FullMulEven(
  vUInt32   vA,
  vUInt32   vB) __OSX_AVAILABLE_STARTING(__MAC_10_0, __IPHONE_NA);
extern vUInt32 
vU64FullMulOdd(
  vUInt32   vA,
  vUInt32   vB) __OSX_AVAILABLE_STARTING(__MAC_10_0, __IPHONE_NA);
extern vUInt32 
vU64HalfMultiply(
  vUInt32   vA,
  vUInt32   vB) __OSX_AVAILABLE_STARTING(__MAC_10_0, __IPHONE_NA);
extern vSInt32 
vS64HalfMultiply(
  vSInt32   vA,
  vSInt32   vB) __OSX_AVAILABLE_STARTING(__MAC_10_0, __IPHONE_NA);
extern vSInt32 
vS64FullMulEven(
  vSInt32   vA,
  vSInt32   vB) __OSX_AVAILABLE_STARTING(__MAC_10_0, __IPHONE_NA);
extern vSInt32 
vS64FullMulOdd(
  vSInt32   vA,
  vSInt32   vB) __OSX_AVAILABLE_STARTING(__MAC_10_0, __IPHONE_NA);
extern vUInt32 
vU128HalfMultiply(
  vUInt32   vA,
  vUInt32   vB) __OSX_AVAILABLE_STARTING(__MAC_10_0, __IPHONE_NA);
extern vSInt32 
vS128HalfMultiply(
  vSInt32   vA,
  vSInt32   vB) __OSX_AVAILABLE_STARTING(__MAC_10_0, __IPHONE_NA);
#if defined __SSE2__
static __inline__ vUInt32 __VBASICOPS_INLINE_ATTR__
vU64Sub(
  vUInt32   __vbasicops_vA,
  vUInt32   __vbasicops_vB) { return _mm_sub_epi64(__vbasicops_vA, __vbasicops_vB); }
#else
extern vUInt32 
vU64Sub(
  vUInt32   vA,
  vUInt32   vB) __OSX_AVAILABLE_STARTING(__MAC_10_0, __IPHONE_NA);
#endif
extern vUInt32 
vU64SubS(
  vUInt32   vA,
  vUInt32   vB) __OSX_AVAILABLE_STARTING(__MAC_10_0, __IPHONE_NA);
extern vUInt32 
vU128Sub(
  vUInt32   vA,
  vUInt32   vB) __OSX_AVAILABLE_STARTING(__MAC_10_0, __IPHONE_NA);
extern vUInt32 
vU128SubS(
  vUInt32   vA,
  vUInt32   vB) __OSX_AVAILABLE_STARTING(__MAC_10_0, __IPHONE_NA);
#if defined __SSE2__
static __inline__ vSInt32 __VBASICOPS_INLINE_ATTR__
vS64Sub(
  vSInt32   __vbasicops_vA,
  vSInt32   __vbasicops_vB) { return _mm_sub_epi64(__vbasicops_vA, __vbasicops_vB); }
#else
extern vSInt32 
vS64Sub(
  vSInt32   vA,
  vSInt32   vB) __OSX_AVAILABLE_STARTING(__MAC_10_0, __IPHONE_NA);
#endif
extern vSInt32 
vS128Sub(
  vSInt32   vA,
  vSInt32   vB) __OSX_AVAILABLE_STARTING(__MAC_10_0, __IPHONE_NA);
extern vSInt32 
vS64SubS(
  vSInt32   vA,
  vSInt32   vB) __OSX_AVAILABLE_STARTING(__MAC_10_0, __IPHONE_NA);
extern vSInt32 
vS128SubS(
  vSInt32   vA,
  vSInt32   vB) __OSX_AVAILABLE_STARTING(__MAC_10_0, __IPHONE_NA);
#if defined (__SSE2__)
static __inline__ vUInt32 __VBASICOPS_INLINE_ATTR__
vU64Add(
  vUInt32   __vbasicops_vA,
  vUInt32   __vbasicops_vB) { return _mm_add_epi64(__vbasicops_vA, __vbasicops_vB); }
#else
extern vUInt32
vU64Add(
  vUInt32   vA,
  vUInt32   vB) __OSX_AVAILABLE_STARTING(__MAC_10_0, __IPHONE_NA);
#endif
extern vUInt32 
vU64AddS(
  vUInt32   vA,
  vUInt32   vB) __OSX_AVAILABLE_STARTING(__MAC_10_0, __IPHONE_NA);
extern vUInt32 
vU128Add(
  vUInt32   vA,
  vUInt32   vB) __OSX_AVAILABLE_STARTING(__MAC_10_0, __IPHONE_NA);
extern vUInt32 
vU128AddS(
  vUInt32   vA,
  vUInt32   vB) __OSX_AVAILABLE_STARTING(__MAC_10_0, __IPHONE_NA);
#if defined __SSE2__
static __inline__ vSInt32 __VBASICOPS_INLINE_ATTR__
vS64Add(
  vSInt32   __vbasicops_vA,
  vSInt32   __vbasicops_vB) { return _mm_add_epi64(__vbasicops_vA, __vbasicops_vB); }
#else 
extern vSInt32 
vS64Add(
  vSInt32   vA,
  vSInt32   vB) __OSX_AVAILABLE_STARTING(__MAC_10_0, __IPHONE_NA);
#endif 
extern vSInt32 
vS64AddS(
  vSInt32   vA,
  vSInt32   vB) __OSX_AVAILABLE_STARTING(__MAC_10_0, __IPHONE_NA);
extern vSInt32 
vS128Add(
  vSInt32   vA,
  vSInt32   vB) __OSX_AVAILABLE_STARTING(__MAC_10_0, __IPHONE_NA);
extern vSInt32 
vS128AddS(
  vSInt32   vA,
  vSInt32   vB) __OSX_AVAILABLE_STARTING(__MAC_10_0, __IPHONE_NA);
extern vUInt32 
vU64Neg (
  vUInt32   vA) __OSX_AVAILABLE_STARTING(__MAC_10_0, __IPHONE_NA);
extern vSInt32 
vS64Neg (
  vSInt32   vA) __OSX_AVAILABLE_STARTING(__MAC_10_5, __IPHONE_NA);
extern vUInt32 
vU128Neg (
  vUInt32   vA) __OSX_AVAILABLE_STARTING(__MAC_10_5, __IPHONE_NA);
extern vSInt32 
vS128Neg (
  vSInt32   vA) __OSX_AVAILABLE_STARTING(__MAC_10_5, __IPHONE_NA);
#if defined (__SSE2__)
static __inline__ vUInt32 __VBASICOPS_INLINE_ATTR__
vLL64Shift(
  vUInt32   __vbasicops_vA,
  vUInt8    __vbasicops_vShiftFactor)
{
    return _mm_sll_epi64(__vbasicops_vA,
                         _mm_and_si128(__vbasicops_vShiftFactor, _mm_cvtsi32_si128( 0x3F )));
}
#else
extern vUInt32 
vLL64Shift(
  vUInt32   vA,
  vUInt8    vShiftFactor) __OSX_AVAILABLE_STARTING(__MAC_10_0, __IPHONE_NA);
#endif
extern vUInt32 
vA64Shift(
  vUInt32   vA,
  vUInt8    vShiftFactor) __OSX_AVAILABLE_STARTING(__MAC_10_0, __IPHONE_NA);
#if defined (__SSE2__)
static __inline__ vUInt32 __VBASICOPS_INLINE_ATTR__
vLR64Shift(
    vUInt32   __vbasicops_vA,
    vUInt8    __vbasicops_vShiftFactor)
{
    return _mm_srl_epi64(__vbasicops_vA,
                         _mm_and_si128(__vbasicops_vShiftFactor, _mm_cvtsi32_si128( 0x3F )));
}
#else
extern vUInt32 
vLR64Shift(
  vUInt32   vA,
  vUInt8    vShiftFactor) __OSX_AVAILABLE_STARTING(__MAC_10_0, __IPHONE_NA);
#endif
extern vUInt32 
vLL64Shift2(
  vUInt32   vA,
  vUInt8    vShiftFactor) __OSX_AVAILABLE_STARTING(__MAC_10_0, __IPHONE_NA);
extern vUInt32 
vA64Shift2(
  vUInt32   vA,
  vUInt8    vShiftFactor) __OSX_AVAILABLE_STARTING(__MAC_10_0, __IPHONE_NA);
extern vUInt32 
vLR64Shift2(
  vUInt32   vA,
  vUInt8    vShiftFactor) __OSX_AVAILABLE_STARTING(__MAC_10_0, __IPHONE_NA);
extern vUInt32 
vLL128Shift(
  vUInt32   vA,
  vUInt8    vShiftFactor) __OSX_AVAILABLE_STARTING(__MAC_10_5, __IPHONE_NA);
extern vUInt32 
vLR128Shift(
  vUInt32   vA,
  vUInt8    vShiftFactor) __OSX_AVAILABLE_STARTING(__MAC_10_5, __IPHONE_NA);
extern vUInt32 
vA128Shift(
  vUInt32   vA,
  vUInt8    vShiftFactor) __OSX_AVAILABLE_STARTING(__MAC_10_0, __IPHONE_NA);
extern vUInt32 
vL64Rotate(
  vUInt32   vA,
  vUInt8    vRotateFactor) __OSX_AVAILABLE_STARTING(__MAC_10_0, __IPHONE_NA);
extern vUInt32 
vR64Rotate(
  vUInt32   vA,
  vUInt8    vRotateFactor) __OSX_AVAILABLE_STARTING(__MAC_10_0, __IPHONE_NA);
extern vUInt32 
vL64Rotate2(
  vUInt32   vA,
  vUInt8    vRotateFactor) __OSX_AVAILABLE_STARTING(__MAC_10_0, __IPHONE_NA);
extern vUInt32 
vR64Rotate2(
  vUInt32   vA,
  vUInt8    vRotateFactor) __OSX_AVAILABLE_STARTING(__MAC_10_0, __IPHONE_NA);
extern vUInt32 
vL128Rotate(
  vUInt32   vA,
  vUInt8    vRotateFactor) __OSX_AVAILABLE_STARTING(__MAC_10_0, __IPHONE_NA);
extern vUInt32 
vR128Rotate(
  vUInt32   vA,
  vUInt8    vRotateFactor) __OSX_AVAILABLE_STARTING(__MAC_10_0, __IPHONE_NA);
#endif  
#endif  
#if __has_feature(assume_nonnull)
    _Pragma("clang assume_nonnull end")
#endif
#ifdef __cplusplus
}
#endif
#endif 
