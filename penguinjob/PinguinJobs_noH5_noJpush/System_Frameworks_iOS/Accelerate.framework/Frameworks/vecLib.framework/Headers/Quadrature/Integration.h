#ifndef QUADRATURE_INTEGRATION_H
#define QUADRATURE_INTEGRATION_H
#include <stddef.h>
#if __has_include( <Availability.h> )
#include <Availability.h>
#else
#define __OSX_AVAILABLE(a)
#define __IOS_AVAILABLE(a)
#define __TVOS_AVAILABLE(a)
#define __WATCHOS_AVAILABLE(a)
#endif
#if __has_feature(assume_nonnull)
  _Pragma("clang assume_nonnull begin")
#else
#define _Null_unspecified
#define _Nullable
#endif
typedef void (*quadrature_function_array)(void * _Null_unspecified __arg, size_t __n, const double *__x, double *__y);
typedef enum {
  QUADRATURE_INTEGRATE_QNG,
  QUADRATURE_INTEGRATE_QAG,
  QUADRATURE_INTEGRATE_QAGS
} quadrature_integrator;
#define QUADRATURE_INTEGRATE_QAG_WORKSPACE_PER_INTERVAL 32
#define QUADRATURE_INTEGRATE_QAGS_WORKSPACE_PER_INTERVAL 152
typedef struct {
  quadrature_function_array fun;
  void * _Null_unspecified fun_arg;
} quadrature_integrate_function;
typedef struct {
  quadrature_integrator integrator;
  double abs_tolerance;
  double rel_tolerance;
  size_t qag_points_per_interval;
  size_t max_intervals;
} quadrature_integrate_options;
extern double quadrature_integrate(const quadrature_integrate_function * __f,
                                   double __a,
                                   double __b,
                                   const quadrature_integrate_options * options,
                                   quadrature_status * _Nullable status,
                                   double * _Nullable abs_error,
                                   size_t workspace_size,
                                   void * __restrict _Nullable workspace)
__OSX_AVAILABLE(10.12) __IOS_AVAILABLE(10.0) __TVOS_AVAILABLE(10.0) __WATCHOS_AVAILABLE(3.0);
#if !__has_include(<Availability.h>)
#undef __OSX_AVAILABLE
#undef __IOS_AVAILABLE
#undef __TVOS_AVAILABLE
#undef __WATCHOS_AVAILABLE
#endif
#if __has_feature(assume_nonnull)
  _Pragma("clang assume_nonnull end")
#else
#undef _Nullable
#undef _Null_unspecified
#endif
#endif 
