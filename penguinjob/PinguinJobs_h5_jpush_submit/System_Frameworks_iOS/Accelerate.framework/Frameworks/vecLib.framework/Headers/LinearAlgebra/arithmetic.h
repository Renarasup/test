#ifndef __LA_ARITHMETIC_HEADER__
#define __LA_ARITHMETIC_HEADER__
#if __has_feature(assume_nonnull)
_Pragma("clang assume_nonnull begin")
#else
#define __nullable
#define __nonnull
#endif
LA_FUNCTION LA_AVAILABILITY LA_RETURNS_RETAINED
la_object_t la_transpose(la_object_t matrix);
LA_FUNCTION LA_AVAILABILITY LA_RETURNS_RETAINED
la_object_t la_scale_with_float(la_object_t matrix, float scalar);
LA_FUNCTION LA_AVAILABILITY LA_RETURNS_RETAINED
la_object_t la_scale_with_double(la_object_t matrix, double scalar);
LA_FUNCTION LA_AVAILABILITY LA_RETURNS_RETAINED
la_object_t la_sum(la_object_t obj_left, la_object_t obj_right);
LA_FUNCTION LA_AVAILABILITY LA_RETURNS_RETAINED
la_object_t la_difference(la_object_t obj_left, la_object_t obj_right);
LA_FUNCTION LA_AVAILABILITY LA_RETURNS_RETAINED
la_object_t la_elementwise_product(la_object_t obj_left, la_object_t obj_right);
LA_FUNCTION LA_AVAILABILITY LA_RETURNS_RETAINED
la_object_t la_inner_product(la_object_t vector_left, la_object_t vector_right);
LA_FUNCTION LA_AVAILABILITY LA_RETURNS_RETAINED
la_object_t la_outer_product(la_object_t vector_left, la_object_t vector_right);
LA_FUNCTION LA_AVAILABILITY LA_RETURNS_RETAINED
la_object_t la_matrix_product(la_object_t matrix_left,
                              la_object_t matrix_right);
#if __has_feature(assume_nonnull)
_Pragma("clang assume_nonnull end")
#endif
#endif 
