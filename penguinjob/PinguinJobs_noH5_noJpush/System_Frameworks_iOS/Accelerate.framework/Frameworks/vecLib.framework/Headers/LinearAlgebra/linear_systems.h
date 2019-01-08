#ifndef __LA_LINEAR_SYSTEMS_HEADER__
#define __LA_LINEAR_SYSTEMS_HEADER__
#if __has_feature(assume_nonnull)
_Pragma("clang assume_nonnull begin")
#else
#define __nullable
#define __nonnull
#endif
LA_FUNCTION LA_AVAILABILITY LA_RETURNS_RETAINED
la_object_t la_solve(la_object_t matrix_system, la_object_t obj_rhs);
#if __has_feature(assume_nonnull)
_Pragma("clang assume_nonnull end")
#endif
#endif 
