#ifndef __VECTOROPS__
#define __VECTOROPS__
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
#if defined _AltiVecPIMLanguageExtensionsAreEnabled || defined __SSE__
extern int32_t 
vIsamax(
  int32_t        count,
  const vFloat   *x) __OSX_AVAILABLE_STARTING(__MAC_10_0, __IPHONE_NA);
extern int32_t 
vIsamin(
  int32_t        count,
  const vFloat   *x) __OSX_AVAILABLE_STARTING(__MAC_10_0, __IPHONE_NA);
extern int32_t 
vIsmax(
  int32_t        count,
  const vFloat   *x) __OSX_AVAILABLE_STARTING(__MAC_10_0, __IPHONE_NA);
extern int32_t 
vIsmin(
  int32_t        count,
  const vFloat   *x) __OSX_AVAILABLE_STARTING(__MAC_10_0, __IPHONE_NA);
extern float 
vSasum(
  int32_t        count,
  const vFloat   *x) __OSX_AVAILABLE_STARTING(__MAC_10_0, __IPHONE_NA);
extern float 
vSsum(
  int32_t        count,
  const vFloat   *x) __OSX_AVAILABLE_STARTING(__MAC_10_0, __IPHONE_NA);
extern void 
vSaxpy(
  int32_t        n,
  float          alpha,
  const vFloat   *x,
  vFloat         *y) __OSX_AVAILABLE_STARTING(__MAC_10_0, __IPHONE_NA);
extern void 
vScopy(
  int32_t        n,
  const vFloat   *x,
  vFloat         *y) __OSX_AVAILABLE_STARTING(__MAC_10_0, __IPHONE_NA);
extern float 
vSdot(
  int32_t        n,
  const vFloat   *x,
  const vFloat   *y) __OSX_AVAILABLE_STARTING(__MAC_10_0, __IPHONE_NA);
extern void 
vSnaxpy(
  int32_t        n,
  int32_t        m,
  const vFloat   *a,
  const vFloat   *x,
  vFloat         *y) __OSX_AVAILABLE_STARTING(__MAC_10_0, __IPHONE_NA);
extern void 
vSndot(
  int32_t        n,
  int32_t        m,
  float          *s,
  int32_t        isw,
  const vFloat   *x,
  const vFloat   *y) __OSX_AVAILABLE_STARTING(__MAC_10_0, __IPHONE_NA);
extern float 
vSnrm2(
  int32_t        count,
  const vFloat   *x) __OSX_AVAILABLE_STARTING(__MAC_10_0, __IPHONE_NA);
extern float 
vSnorm2(
  int32_t        count,
  const vFloat   *x) __OSX_AVAILABLE_STARTING(__MAC_10_0, __IPHONE_NA);
extern void 
vSrot(
  int32_t   n,
  vFloat    *x,
  vFloat    *y,
  float     c,
  float     s) __OSX_AVAILABLE_STARTING(__MAC_10_0, __IPHONE_NA);
extern void 
vSscal(
  int32_t   n,
  float     alpha,
  vFloat    *x) __OSX_AVAILABLE_STARTING(__MAC_10_0, __IPHONE_NA);
extern void 
vSswap(
  int32_t   n,
  vFloat    *x,
  vFloat    *y) __OSX_AVAILABLE_STARTING(__MAC_10_0, __IPHONE_NA);
extern void 
vSyax(
  int32_t        n,
  float          alpha,
  const vFloat   *x,
  vFloat         *y) __OSX_AVAILABLE_STARTING(__MAC_10_0, __IPHONE_NA);
extern void 
vSzaxpy(
  int32_t        n,
  float          alpha,
  const vFloat   *x,
  const vFloat   *y,
  vFloat         *z) __OSX_AVAILABLE_STARTING(__MAC_10_0, __IPHONE_NA);
extern void 
vSgemv(
  char           forma,
  int32_t        m,
  int32_t        n,
  float          alpha,
  const vFloat   *a,
  const vFloat   *x,
  float          beta,
  vFloat         *y) __OSX_AVAILABLE_STARTING(__MAC_10_0, __IPHONE_NA);
extern void 
vSgemx(
  int32_t        m,
  int32_t        n,
  float          alpha,
  const vFloat   *a,
  const vFloat   *x,
  vFloat         *y) __OSX_AVAILABLE_STARTING(__MAC_10_0, __IPHONE_NA);
extern void 
vSgemtx(
  int32_t        m,
  int32_t        n,
  float          alpha,
  const vFloat   *a,
  const vFloat   *x,
  vFloat         *y) __OSX_AVAILABLE_STARTING(__MAC_10_0, __IPHONE_NA);
extern void 
vSgeadd(
  int32_t        height,
  int32_t        width,
  const vFloat   *a,
  char           forma,
  const vFloat   *b,
  char           formb,
  vFloat         *c) __OSX_AVAILABLE_STARTING(__MAC_10_0, __IPHONE_NA);
extern void 
vSgesub(
  int32_t        height,
  int32_t        width,
  const vFloat   *a,
  char           forma,
  const vFloat   *b,
  char           formb,
  vFloat         *c) __OSX_AVAILABLE_STARTING(__MAC_10_0, __IPHONE_NA);
extern void 
vSgemul(
  int32_t        l,
  int32_t        m,
  int32_t        n,
  const vFloat   *a,
  char           forma,
  const vFloat   *b,
  char           formb,
  vFloat         *matrix) __OSX_AVAILABLE_STARTING(__MAC_10_0, __IPHONE_NA);
extern void 
vSgemm(
  int32_t        l,
  int32_t        m,
  int32_t        n,
  const vFloat   *a,
  char           forma,
  const vFloat   *b,
  char           formb,
  vFloat         *c,
  float          alpha,
  float          beta,
  vFloat         *matrix) __OSX_AVAILABLE_STARTING(__MAC_10_0, __IPHONE_NA);
extern void 
vSgetmi(
  int32_t   size,
  vFloat    *x) __OSX_AVAILABLE_STARTING(__MAC_10_0, __IPHONE_NA);
extern void 
vSgetmo(
  int32_t        height,
  int32_t        width,
  const vFloat   *x,
  vFloat         *y) __OSX_AVAILABLE_STARTING(__MAC_10_0, __IPHONE_NA);
extern void 
vSgevv(
  int32_t        l,
  int32_t        n,
  const vFloat   *A,
  const vFloat   *B,
  vFloat         *M) __OSX_AVAILABLE_STARTING(__MAC_10_0, __IPHONE_NA);
#endif	
#if __has_feature(assume_nonnull)
    _Pragma("clang assume_nonnull end")
#endif
#ifdef __cplusplus
}
#endif
#endif 
