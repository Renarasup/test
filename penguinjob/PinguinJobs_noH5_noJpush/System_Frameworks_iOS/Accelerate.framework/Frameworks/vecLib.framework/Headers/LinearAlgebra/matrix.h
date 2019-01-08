#ifndef __LA_MATRIX_HEADER__
#define __LA_MATRIX_HEADER__
#if __has_feature(assume_nonnull)
_Pragma("clang assume_nonnull begin")
#else
#define __nullable
#define __nonnull
#endif
#define LA_NO_HINT                       (0U)
#define LA_SHAPE_DIAGONAL                (1U << 0)
#define LA_SHAPE_LOWER_TRIANGULAR        (1U << 1)
#define LA_SHAPE_UPPER_TRIANGULAR        (1U << 2)
#define LA_FEATURE_SYMMETRIC             (1U << 16)
#define LA_FEATURE_POSITIVE_DEFINITE     (1U << 17)
#define LA_FEATURE_DIAGONALLY_DOMINANT   (1U << 18)
typedef unsigned long la_hint_t;
LA_FUNCTION LA_AVAILABILITY LA_RETURNS_RETAINED
la_object_t la_matrix_from_float_buffer(const float *buffer,
                                           la_count_t matrix_rows,
                                           la_count_t matrix_cols,
                                           la_count_t matrix_row_stride,
                                           la_hint_t matrix_hint,
                                           la_attribute_t attributes);
LA_FUNCTION LA_AVAILABILITY LA_RETURNS_RETAINED
la_object_t la_matrix_from_double_buffer(const double *buffer,
                                            la_count_t matrix_rows,
                                            la_count_t matrix_cols,
                                            la_count_t matrix_row_stride,
                                            la_hint_t matrix_hint,
                                            la_attribute_t attributes);
LA_FUNCTION LA_AVAILABILITY LA_RETURNS_RETAINED
la_object_t la_matrix_from_float_buffer_nocopy(float *buffer,
                                                  la_count_t matrix_rows,
                                                  la_count_t matrix_cols,
                                                  la_count_t matrix_row_stride,
                                                  la_hint_t matrix_hint,
                                                  __nullable la_deallocator_t deallocator,
                                                  la_attribute_t attributes);
LA_FUNCTION LA_AVAILABILITY LA_RETURNS_RETAINED
la_object_t la_matrix_from_double_buffer_nocopy(double *buffer,
                                                   la_count_t matrix_rows,
                                                   la_count_t matrix_cols,
                                                   la_count_t matrix_row_stride,
                                                   la_hint_t matrix_hint,
                                                   __nullable la_deallocator_t deallocator,
                                                   la_attribute_t attributes);
LA_FUNCTION LA_AVAILABILITY
la_status_t la_matrix_to_float_buffer(float *buffer,
                                            la_count_t buffer_row_stride,
                                            la_object_t matrix);
LA_FUNCTION LA_AVAILABILITY
la_status_t la_matrix_to_double_buffer(double *buffer,
                                             la_count_t buffer_row_stride,
                                             la_object_t matrix);
LA_FUNCTION LA_CONST LA_AVAILABILITY
la_count_t la_matrix_rows(la_object_t matrix);
LA_FUNCTION LA_CONST LA_AVAILABILITY
la_count_t la_matrix_cols(la_object_t matrix);
LA_FUNCTION LA_AVAILABILITY LA_RETURNS_RETAINED
la_object_t la_matrix_slice(la_object_t matrix,
                                 la_index_t matrix_first_row,
                                 la_index_t matrix_first_col,
                                 la_index_t matrix_row_stride,
                                 la_index_t matrix_col_stride,
                                 la_count_t slice_rows,
                                 la_count_t slice_cols);
LA_FUNCTION LA_AVAILABILITY LA_RETURNS_RETAINED
la_object_t la_identity_matrix(la_count_t matrix_size,
                                    la_scalar_type_t scalar_type,
                                    la_attribute_t attributes);
LA_FUNCTION LA_AVAILABILITY LA_RETURNS_RETAINED
la_object_t la_diagonal_matrix_from_vector(la_object_t vector,
                                            la_index_t matrix_diagonal);
LA_FUNCTION LA_AVAILABILITY LA_RETURNS_RETAINED
la_object_t la_vector_from_matrix_row(la_object_t matrix,
                                           la_count_t matrix_row);
LA_FUNCTION LA_AVAILABILITY LA_RETURNS_RETAINED
la_object_t la_vector_from_matrix_col(la_object_t matrix,
                                           la_count_t matrix_col);
LA_FUNCTION LA_AVAILABILITY LA_RETURNS_RETAINED
la_object_t la_vector_from_matrix_diagonal(la_object_t matrix,
                                              la_index_t matrix_diagonal);
#if __has_feature(assume_nonnull)
_Pragma("clang assume_nonnull end")
#endif
#endif 
