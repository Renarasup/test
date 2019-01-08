#ifndef __LA_SPLAT_HEADER__
#define __LA_SPLAT_HEADER__
#if __has_feature(assume_nonnull)
_Pragma("clang assume_nonnull begin")
#else
#define __nullable
#define __nonnull
#endif
LA_FUNCTION LA_AVAILABILITY LA_RETURNS_RETAINED
la_object_t la_splat_from_float(float scalar_value,
                                la_attribute_t attributes);
LA_FUNCTION LA_AVAILABILITY LA_RETURNS_RETAINED
la_object_t la_splat_from_double(double scalar_value,
                                 la_attribute_t attributes);
LA_FUNCTION LA_AVAILABILITY LA_RETURNS_RETAINED
la_object_t la_splat_from_vector_element(la_object_t vector,
                                         la_index_t vector_index);
LA_FUNCTION LA_AVAILABILITY LA_RETURNS_RETAINED
la_object_t la_splat_from_matrix_element(la_object_t matrix,
                                         la_index_t matrix_row,
                                         la_index_t matrix_col);
LA_FUNCTION LA_AVAILABILITY LA_RETURNS_RETAINED
la_object_t la_vector_from_splat(la_object_t splat,
                                 la_count_t vector_length);
LA_FUNCTION LA_AVAILABILITY LA_RETURNS_RETAINED
la_object_t la_matrix_from_splat(la_object_t splat,
                                 la_count_t matrix_rows,
                                 la_count_t matrix_cols);
#if __has_feature(assume_nonnull)
_Pragma("clang assume_nonnull end")
#endif
#endif 
