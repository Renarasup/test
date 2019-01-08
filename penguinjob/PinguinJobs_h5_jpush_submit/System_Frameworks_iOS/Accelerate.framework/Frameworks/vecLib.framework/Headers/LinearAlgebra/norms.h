#ifndef __LA_NORMS_HEADER__
#define __LA_NORMS_HEADER__
#if __has_feature(assume_nonnull)
_Pragma("clang assume_nonnull begin")
#else
#define __nullable
#define __nonnull
#endif
#define LA_L1_NORM 1
#define LA_L2_NORM 2
#define LA_LINF_NORM 3
typedef unsigned long la_norm_t;
LA_FUNCTION LA_AVAILABILITY
float la_norm_as_float(la_object_t vector, la_norm_t vector_norm);
LA_FUNCTION LA_AVAILABILITY
double la_norm_as_double(la_object_t vector, la_norm_t vector_norm);
LA_FUNCTION LA_AVAILABILITY LA_RETURNS_RETAINED
la_object_t la_normalized_vector(la_object_t vector, la_norm_t vector_norm);
#if __has_feature(assume_nonnull)
_Pragma("clang assume_nonnull end")
#endif
#endif
