#ifndef __LA_VECTOR_HEADER__
#define __LA_VECTOR_HEADER__
#if __has_feature(assume_nonnull)
_Pragma("clang assume_nonnull begin")
#else
#define __nullable
#define __nonnull
#endif
#define la_vector_from_float_buffer(buffer, vector_length, buffer_stride, attributes) \
    la_matrix_from_float_buffer(buffer, vector_length, 1, buffer_stride, LA_NO_HINT, attributes)
#define la_vector_from_double_buffer(buffer, vector_length, buffer_stride, attributes) \
    la_matrix_from_double_buffer(buffer, vector_length, 1, buffer_stride, LA_NO_HINT, attributes)
#define la_vector_from_float_buffer_nocopy(buffer, vector_length, deallocator, attributes) \
    la_matrix_from_float_buffer_nocopy(buffer, vector_length, 1, 1, LA_NO_HINT, deallocator, attributes)
#define la_vector_from_double_buffer_nocopy(buffer, vector_length, deallocator, attributes) \
    la_matrix_from_double_buffer_nocopy(buffer, vector_length, 1, 1, LA_NO_HINT, deallocator, attributes)
LA_FUNCTION LA_AVAILABILITY
la_status_t la_vector_to_float_buffer(float *buffer,
                                            la_index_t buffer_stride,
                                            la_object_t vector);
LA_FUNCTION LA_AVAILABILITY
la_status_t la_vector_to_double_buffer(double *buffer,
                                             la_index_t buffer_stride,
                                             la_object_t vector);
LA_FUNCTION LA_CONST LA_AVAILABILITY
la_count_t la_vector_length(la_object_t vector);
LA_FUNCTION LA_AVAILABILITY LA_RETURNS_RETAINED
la_object_t la_vector_slice(la_object_t vector,
                               la_index_t vector_first,
                               la_index_t vector_stride,
                               la_count_t slice_length);
#define la_vector_reverse(vector) \
la_vector_slice(vector, la_vector_length(vector)-1, -1, la_vector_length(vector))
#if __has_feature(assume_nonnull)
_Pragma("clang assume_nonnull end")
#endif
#endif 
