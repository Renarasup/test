#ifndef __VECLIBTYPES__
#define __VECLIBTYPES__
#include <Availability.h>
#if PRAGMA_ONCE
#pragma once
#endif
#pragma options align=power
#if defined(__ppc__) || defined(__ppc64__)
#if			defined _ALTIVEC_H \
		||	(defined __APPLE_CC__ && __APPLE_ALTIVEC__) \
		|| 	(!defined __GNUC__ && defined __VEC__)
	#define _AltiVecPIMLanguageExtensionsAreEnabled
#endif
#if defined _AltiVecPIMLanguageExtensionsAreEnabled
	typedef __vector unsigned char            vUInt8;
	typedef __vector signed char              vSInt8;
	typedef __vector unsigned short           vUInt16;
	typedef __vector signed short             vSInt16;
	typedef __vector unsigned int             vUInt32;
	typedef __vector signed int               vSInt32;
	typedef __vector float                    vFloat;
	typedef __vector bool int                 vBool32;
    #if defined(__GNUC__) && ! defined( __XLC__ )
        #if defined(__GNUC_MINOR__) && (((__GNUC__ == 3) && (__GNUC_MINOR__ <= 3)) || (__GNUC__ < 3))
        #else
            #define __VECLIBTYPES_VDOUBLE__ 1
            typedef double vDouble         __attribute__ ((__vector_size__ (16)));
        #endif
    #endif
#endif	
#elif defined(__i386__) || defined(__x86_64__)
#ifdef __SSE__
#if defined(__GNUC__)
#include <xmmintrin.h>
typedef float                   vFloat          __attribute__ ((__vector_size__ (16)));
#else 
#include <xmmintrin.h>
typedef __m128                          vFloat;
#endif 
#endif  
#ifdef __SSE2__
    #define __VECLIBTYPES_VDOUBLE__ 1
    #if defined(__GNUC__)
        #if defined(__GNUC_MINOR__) && (((__GNUC__ == 3) && (__GNUC_MINOR__ <= 3)) || (__GNUC__ < 3))
            #include <xmmintrin.h>
            typedef __m128i vUInt8;
            typedef __m128i vSInt8;
            typedef __m128i vUInt16;
            typedef __m128i vSInt16;
            typedef __m128i vUInt32;
            typedef __m128i vSInt32;
            typedef __m128i vBool32;
            typedef __m128i vUInt64;
            typedef __m128i vSInt64;
            typedef __m128d vDouble;
        #else 
            #include <emmintrin.h>
            typedef unsigned char           vUInt8          __attribute__ ((__vector_size__ (16)));
            typedef char                    vSInt8          __attribute__ ((__vector_size__ (16)));
            typedef unsigned short          vUInt16         __attribute__ ((__vector_size__ (16)));
            typedef short                   vSInt16         __attribute__ ((__vector_size__ (16)));
            typedef unsigned int            vUInt32         __attribute__ ((__vector_size__ (16)));
            typedef int                     vSInt32         __attribute__ ((__vector_size__ (16)));
            typedef unsigned int            vBool32         __attribute__ ((__vector_size__ (16)));
            typedef unsigned long long      vUInt64         __attribute__ ((__vector_size__ (16)));
            typedef long long               vSInt64         __attribute__ ((__vector_size__ (16)));
            typedef double                  vDouble         __attribute__ ((__vector_size__ (16)));
        #endif 
    #else 
        #include <emmintrin.h>
        typedef __m128i                         vUInt8;
        typedef __m128i                         vSInt8;
        typedef __m128i                         vUInt16;
        typedef __m128i                         vSInt16;
        typedef __m128i                         vUInt32;
        typedef __m128i                         vSInt32;
        typedef __m128i                         vBool32;
        typedef __m128i                         vUInt64;
        typedef __m128i                         vSInt64;
        typedef __m128d                         vDouble;
    #endif 
#endif  
#elif defined __arm__ && defined __ARM_NEON__
	#if !defined ARM_NEON_GCC_COMPATIBILITY  
		#define ARM_NEON_GCC_COMPATIBILITY
		#if \
			defined __ARM_NEON_H && \
			defined __GNUC__ && \
			! defined __clang__ && \
			! defined SQUELCH_VECLIB_WARNINGS_ABOUT_BROKEN_NEON_TYPES
			#warning "arm_neon.h was included without #define ARM_NEON_GCC_COMPATIBILITY.  Vector types defined in vecLibTypes.h, such as vUInt8, might not work with NEON intrinsics."
		#endif
	#endif	
	#include <arm_neon.h>
	typedef unsigned char  vUInt8  __attribute__((__vector_size__(16), __aligned__(16)));
	typedef signed char    vSInt8  __attribute__((__vector_size__(16), __aligned__(16)));
	typedef unsigned short vUInt16 __attribute__((__vector_size__(16), __aligned__(16)));
	typedef signed short   vSInt16 __attribute__((__vector_size__(16), __aligned__(16)));
	typedef unsigned int   vUInt32 __attribute__((__vector_size__(16), __aligned__(16)));
	typedef signed int     vSInt32 __attribute__((__vector_size__(16), __aligned__(16)));
	typedef float          vFloat  __attribute__((__vector_size__(16), __aligned__(16)));
	typedef double         vDouble __attribute__((__vector_size__(16), __aligned__(16)));
	typedef unsigned int   vBool32 __attribute__((__vector_size__(16), __aligned__(16)));
#else
	typedef unsigned char       vUInt8  __attribute__((__vector_size__(16)));
	typedef signed char         vSInt8  __attribute__((__vector_size__(16)));
	typedef unsigned short      vUInt16 __attribute__((__vector_size__(16)));
	typedef signed short        vSInt16 __attribute__((__vector_size__(16)));
	typedef unsigned int        vUInt32 __attribute__((__vector_size__(16)));
	typedef signed int          vSInt32 __attribute__((__vector_size__(16)));
    typedef long long           vSInt64 __attribute__((__vector_size__(16)));
    typedef unsigned long long  vUInt64 __attribute__((__vector_size__(16)));
	typedef float               vFloat  __attribute__((__vector_size__(16)));
	typedef double              vDouble __attribute__((__vector_size__(16)));
	typedef unsigned int        vBool32 __attribute__((__vector_size__(16)));
#endif
#pragma options align=reset
#endif 
