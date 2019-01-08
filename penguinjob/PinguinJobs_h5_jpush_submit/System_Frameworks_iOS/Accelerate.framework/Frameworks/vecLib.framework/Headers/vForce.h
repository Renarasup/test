#ifndef __VFORCE_H
#define __VFORCE_H
#ifdef __cplusplus
	#include <ciso646>	
	#if	defined _LIBCPP_VERSION
		#include <complex>
	#else
		namespace std
		{
			template<class T> class complex;
			template<> class complex<float>;
			template<> class complex<double>;
		}
	#endif
	typedef std::complex<float> __float_complex_t;
	typedef std::complex<double> __double_complex_t;
#else
	typedef _Complex float __float_complex_t;
	typedef _Complex double __double_complex_t;
#endif
#include <math.h>
#ifdef __cplusplus
extern "C" {
#endif
#include <Availability.h>
#if !defined __has_feature
    #define __has_feature(f)    0
#endif
#if __has_feature(assume_nonnull)
    _Pragma("clang assume_nonnull begin")
#else
    #define __nullable
    #define __nonnull
#endif
void vvrecf (float * , const float * , const int * ) __OSX_AVAILABLE_STARTING(__MAC_10_4, __IPHONE_5_0); 
void vvrec (double * , const double * , const int * ) __OSX_AVAILABLE_STARTING(__MAC_10_4, __IPHONE_5_0); 
void vvdivf (float * , const float * , const float * , const int *  ) __OSX_AVAILABLE_STARTING(__MAC_10_4, __IPHONE_5_0); 
void vvdiv (double * , const double * , const double * , const int *  ) __OSX_AVAILABLE_STARTING(__MAC_10_4, __IPHONE_5_0); 
void vvsqrtf (float * , const float * , const int * ) __OSX_AVAILABLE_STARTING(__MAC_10_4, __IPHONE_5_0); 
void vvsqrt (double * , const double * , const int * ) __OSX_AVAILABLE_STARTING(__MAC_10_4, __IPHONE_5_0); 
void vvcbrtf (float * , const float * , const int * ) __OSX_AVAILABLE_STARTING(__MAC_10_10, __IPHONE_8_0);
void vvcbrt (double * , const double * , const int * ) __OSX_AVAILABLE_STARTING(__MAC_10_10, __IPHONE_8_0);
void vvrsqrtf (float * , const float * , const int * ) __OSX_AVAILABLE_STARTING(__MAC_10_4, __IPHONE_5_0); 
void vvrsqrt (double * , const double * , const int * ) __OSX_AVAILABLE_STARTING(__MAC_10_4, __IPHONE_5_0); 
void vvexpf (float * , const float * , const int * ) __OSX_AVAILABLE_STARTING(__MAC_10_4, __IPHONE_5_0); 
void vvexp (double * , const double * , const int * ) __OSX_AVAILABLE_STARTING(__MAC_10_4, __IPHONE_5_0); 
void vvexpm1f (float * , const float * , const int * ) __OSX_AVAILABLE_STARTING(__MAC_10_5, __IPHONE_5_0); 
void vvexpm1 (double * , const double * , const int * ) __OSX_AVAILABLE_STARTING(__MAC_10_7, __IPHONE_5_0); 
void vvlogf (float * , const float * , const int * ) __OSX_AVAILABLE_STARTING(__MAC_10_4, __IPHONE_5_0); 
void vvlog (double * , const double * , const int * ) __OSX_AVAILABLE_STARTING(__MAC_10_4, __IPHONE_5_0); 
void vvlog10f (float * , const float * , const int * ) __OSX_AVAILABLE_STARTING(__MAC_10_4, __IPHONE_5_0); 
void vvlog10 (double * , const double * , const int * ) __OSX_AVAILABLE_STARTING(__MAC_10_4, __IPHONE_5_0); 
void vvlog1pf (float * , const float * , const int * ) __OSX_AVAILABLE_STARTING(__MAC_10_5, __IPHONE_5_0); 
void vvlog1p (double * , const double * , const int * ) __OSX_AVAILABLE_STARTING(__MAC_10_7, __IPHONE_5_0);
void vvlogbf (float * , const float * , const int * ) __OSX_AVAILABLE_STARTING(__MAC_10_5, __IPHONE_5_0); 
void vvlogb (double * , const double * , const int * ) __OSX_AVAILABLE_STARTING(__MAC_10_7, __IPHONE_5_0);
void vvfabf (float * , const float * , const int * ) __OSX_AVAILABLE_BUT_DEPRECATED(__MAC_10_5, __MAC_10_7, __IPHONE_NA, __IPHONE_NA);
void vvfabsf (float * , const float * , const int * ) __OSX_AVAILABLE_STARTING(__MAC_10_7, __IPHONE_5_0); 
void vvfabs (double * , const double * , const int * ) __OSX_AVAILABLE_STARTING(__MAC_10_7, __IPHONE_5_0);
void vvpowf (float * , const float * , const float * , const int *  ) __OSX_AVAILABLE_STARTING(__MAC_10_4, __IPHONE_5_0); 
void vvpow (double * , const double * , const double * , const int *  ) __OSX_AVAILABLE_STARTING(__MAC_10_4, __IPHONE_5_0); 
void vvpowsf (float * , const float * , const float * , const int * ) __OSX_AVAILABLE_STARTING(__MAC_10_9, __IPHONE_6_0);
void vvpows (double * , const double * , const double * , const int * )__OSX_AVAILABLE_STARTING(__MAC_10_9, __IPHONE_6_0);
void vvsinf (float * , const float * , const int * ) __OSX_AVAILABLE_STARTING(__MAC_10_4, __IPHONE_5_0);
void vvsin (double * , const double * , const int * ) __OSX_AVAILABLE_STARTING(__MAC_10_4, __IPHONE_5_0);
void vvcosf (float * , const float * , const int * ) __OSX_AVAILABLE_STARTING(__MAC_10_4, __IPHONE_5_0);
void vvcos (double * , const double * , const int * ) __OSX_AVAILABLE_STARTING(__MAC_10_4, __IPHONE_5_0);
void vvtanf (float * , const float * , const int * ) __OSX_AVAILABLE_STARTING(__MAC_10_4, __IPHONE_5_0);
void vvtan (double * , const double * , const int * ) __OSX_AVAILABLE_STARTING(__MAC_10_4, __IPHONE_5_0);
void vvasinf (float * , const float * , const int * ) __OSX_AVAILABLE_STARTING(__MAC_10_4, __IPHONE_5_0);
void vvasin (double * , const double * , const int * ) __OSX_AVAILABLE_STARTING(__MAC_10_4, __IPHONE_5_0);
void vvacosf (float * , const float * , const int * ) __OSX_AVAILABLE_STARTING(__MAC_10_4, __IPHONE_5_0);
void vvacos (double * , const double * , const int * ) __OSX_AVAILABLE_STARTING(__MAC_10_4, __IPHONE_5_0);
void vvatanf (float * , const float * , const int * ) __OSX_AVAILABLE_STARTING(__MAC_10_4, __IPHONE_5_0);
void vvatan (double * , const double * , const int * ) __OSX_AVAILABLE_STARTING(__MAC_10_4, __IPHONE_5_0);
void vvatan2f (float * , const float * , const float * , const int * ) __OSX_AVAILABLE_STARTING(__MAC_10_4, __IPHONE_5_0);
void vvatan2 (double * , const double * , const double * , const int * ) __OSX_AVAILABLE_STARTING(__MAC_10_4, __IPHONE_5_0);
void vvsincosf (float * , float * , const float * , const int * ) __OSX_AVAILABLE_STARTING(__MAC_10_4, __IPHONE_5_0);
void vvsincos (double * , double * , const double * , const int * ) __OSX_AVAILABLE_STARTING(__MAC_10_4, __IPHONE_5_0);
void vvcosisinf (__float_complex_t * , const float * , const int * ) __OSX_AVAILABLE_STARTING(__MAC_10_4, __IPHONE_5_0);
void vvcosisin (__double_complex_t * , const double * , const int * ) __OSX_AVAILABLE_STARTING(__MAC_10_4, __IPHONE_5_0);
void vvsinhf (float * , const float * , const int * ) __OSX_AVAILABLE_STARTING(__MAC_10_4, __IPHONE_5_0);
void vvsinh (double * , const double * , const int * ) __OSX_AVAILABLE_STARTING(__MAC_10_4, __IPHONE_5_0);
void vvcoshf (float * , const float * , const int * ) __OSX_AVAILABLE_STARTING(__MAC_10_4, __IPHONE_5_0);
void vvcosh (double * , const double * , const int * ) __OSX_AVAILABLE_STARTING(__MAC_10_4, __IPHONE_5_0);
void vvtanhf (float * , const float * , const int * ) __OSX_AVAILABLE_STARTING(__MAC_10_4, __IPHONE_5_0);
void vvtanh (double * , const double * , const int * ) __OSX_AVAILABLE_STARTING(__MAC_10_4, __IPHONE_5_0);
void vvasinhf (float * , const float * , const int * ) __OSX_AVAILABLE_STARTING(__MAC_10_4, __IPHONE_5_0);
void vvasinh (double * , const double * , const int * ) __OSX_AVAILABLE_STARTING(__MAC_10_4, __IPHONE_5_0);
void vvacoshf (float * , const float * , const int * ) __OSX_AVAILABLE_STARTING(__MAC_10_4, __IPHONE_5_0);
void vvacosh (double * , const double * , const int * ) __OSX_AVAILABLE_STARTING(__MAC_10_4, __IPHONE_5_0);
void vvatanhf (float * , const float * , const int * ) __OSX_AVAILABLE_STARTING(__MAC_10_4, __IPHONE_5_0);
void vvatanh (double * , const double * , const int * ) __OSX_AVAILABLE_STARTING(__MAC_10_4, __IPHONE_5_0);
void vvintf (float * , const float * , const int * ) __OSX_AVAILABLE_STARTING(__MAC_10_4, __IPHONE_5_0);
void vvint (double * , const double * , const int * ) __OSX_AVAILABLE_STARTING(__MAC_10_4, __IPHONE_5_0);
void vvnintf (float * , const float * , const int * ) __OSX_AVAILABLE_STARTING(__MAC_10_4, __IPHONE_5_0);
void vvnint (double * , const double * , const int * ) __OSX_AVAILABLE_STARTING(__MAC_10_4, __IPHONE_5_0);
void vvceilf (float * , const float * , const int * ) __OSX_AVAILABLE_STARTING(__MAC_10_4, __IPHONE_5_0);
void vvceil (double * , const double * , const int * ) __OSX_AVAILABLE_STARTING(__MAC_10_4, __IPHONE_5_0);
void vvfloorf (float * , const float * , const int * ) __OSX_AVAILABLE_STARTING(__MAC_10_4, __IPHONE_5_0);
void vvfloor (double * , const double * , const int * ) __OSX_AVAILABLE_STARTING(__MAC_10_4, __IPHONE_5_0);
void vvfmodf (float * , const float * , const float * , const int * ) __OSX_AVAILABLE_STARTING(__MAC_10_5, __IPHONE_5_0);
void vvfmod (double * , const double * , const double * , const int * ) __OSX_AVAILABLE_STARTING(__MAC_10_7, __IPHONE_5_0);
void vvremainderf (float * , const float * , const float * , const int * ) __OSX_AVAILABLE_STARTING(__MAC_10_5, __IPHONE_5_0);
void vvremainder (double * , const double * , const double * , const int * ) __OSX_AVAILABLE_STARTING(__MAC_10_7, __IPHONE_5_0);
void vvcopysignf (float * , const float * , const float * , const int * ) __OSX_AVAILABLE_STARTING(__MAC_10_5, __IPHONE_5_0);
void vvcopysign (double * , const double * , const double * , const int * ) __OSX_AVAILABLE_STARTING(__MAC_10_7, __IPHONE_5_0);
void vvnextafterf (float * , const float * , const float * , const int * ) __OSX_AVAILABLE_STARTING(__MAC_10_5, __IPHONE_5_0);
void vvnextafter (double * , const double * , const double * , const int * ) __OSX_AVAILABLE_STARTING(__MAC_10_7, __IPHONE_5_0);
void vvlog2f (float * , const float * , const int * ) __OSX_AVAILABLE_STARTING(__MAC_10_7, __IPHONE_5_0); 
void vvlog2 (double * , const double * , const int * ) __OSX_AVAILABLE_STARTING(__MAC_10_7, __IPHONE_5_0); 
void vvexp2f (float * , const float * , const int * ) __OSX_AVAILABLE_STARTING(__MAC_10_7, __IPHONE_5_0); 
void vvexp2 (double * , const double * , const int * ) __OSX_AVAILABLE_STARTING(__MAC_10_7, __IPHONE_5_0); 
void vvsinpif (float * , const float * , const int * ) __OSX_AVAILABLE_STARTING(__MAC_10_7, __IPHONE_5_0); 
void vvsinpi (double * , const double * , const int * ) __OSX_AVAILABLE_STARTING(__MAC_10_7, __IPHONE_5_0); 
void vvcospif (float * , const float * , const int * ) __OSX_AVAILABLE_STARTING(__MAC_10_7, __IPHONE_5_0); 
void vvcospi (double * , const double * , const int * ) __OSX_AVAILABLE_STARTING(__MAC_10_7, __IPHONE_5_0); 
void vvtanpif (float * , const float * , const int * ) __OSX_AVAILABLE_STARTING(__MAC_10_7, __IPHONE_5_0); 
void vvtanpi (double * , const double * , const int * ) __OSX_AVAILABLE_STARTING(__MAC_10_7, __IPHONE_5_0); 
#if __has_feature(assume_nonnull)
    _Pragma("clang assume_nonnull end")
#endif
#ifdef __cplusplus
}
#endif
#endif 
