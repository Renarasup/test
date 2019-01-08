#ifndef __SPARSE_BLAS_H
#define __SPARSE_BLAS_H
#ifdef __cplusplus
extern "C" {
#endif
#ifndef CBLAS_H
#include <vecLib/cblas.h>
#endif
#ifndef __SPARSE_TYPES_H
#include <vecLib/Sparse/Types.h>
#endif
#pragma mark - Level 1 Routines -
float sparse_inner_product_dense_float( sparse_dimension nz,
                                     const float * __restrict x,
                                     const sparse_index * __restrict indx,
                                     const float * __restrict y,
                                     sparse_stride incy );
double sparse_inner_product_dense_double( sparse_dimension nz,
                                       const double * __restrict x,
                                       const sparse_index * __restrict indx,
                                       const double * __restrict y,
                                       sparse_stride incy );
float sparse_inner_product_sparse_float( sparse_dimension nzx, sparse_dimension nzy,
                                      const float * __restrict x,
                                      const sparse_index * __restrict indx,
                                      const float * __restrict y,
                                      const sparse_index * __restrict indy );
double sparse_inner_product_sparse_double( sparse_dimension nzx, sparse_dimension nzy,
                                        const double * __restrict x,
                                        const sparse_index * __restrict indx,
                                        const double * __restrict y,
                                        const sparse_index * __restrict indy );
void sparse_vector_add_with_scale_dense_float( sparse_dimension nz, float alpha,
                                            const float * __restrict x,
                                            const sparse_index * __restrict indx,
                                            float * __restrict y,
                                            sparse_stride incy );
void sparse_vector_add_with_scale_dense_double( sparse_dimension nz, double alpha,
                                             const double * __restrict x,
                                             const sparse_index * __restrict indx,
                                             double * __restrict y,
                                             sparse_stride incy );
float sparse_vector_norm_float( sparse_dimension nz, const float * __restrict x,
                             const sparse_index * __restrict indx, sparse_norm norm );
double sparse_vector_norm_double( sparse_dimension nz, const double * __restrict x,
                               const sparse_index * __restrict indx, sparse_norm norm );
#pragma mark - Level 2 Routines -
sparse_status sparse_matrix_vector_product_dense_float( enum CBLAS_TRANSPOSE transa,
                                                  float alpha,
                                                  sparse_matrix_float A,
                                                  const float * __restrict x,
                                                  sparse_stride incx,
                                                  float * __restrict y,
                                                  sparse_stride incy );
sparse_status sparse_matrix_vector_product_dense_double( enum CBLAS_TRANSPOSE transa,
                                                   double alpha,
                                                   sparse_matrix_double A,
                                                   const double * __restrict x,
                                                   sparse_stride incx,
                                                   double * __restrict y,
                                                   sparse_stride incy );
sparse_status sparse_vector_triangular_solve_dense_float( enum CBLAS_TRANSPOSE transt,
                                              float alpha, sparse_matrix_float T,
                                              float * __restrict x,
                                              sparse_stride incx );
sparse_status sparse_vector_triangular_solve_dense_double( enum CBLAS_TRANSPOSE transt,
                                               double alpha,
                                               sparse_matrix_double T,
                                               double * __restrict x,
                                               sparse_stride incx );
sparse_status sparse_outer_product_dense_float( sparse_dimension M, sparse_dimension N,
                                    sparse_dimension nz, float alpha,
                                    const float * __restrict x, sparse_stride incx,
                                    const float * __restrict y,
                                    const sparse_index * __restrict indy,
                                    sparse_matrix_float * __restrict C);
sparse_status sparse_outer_product_dense_double( sparse_dimension M, sparse_dimension N,
                                     sparse_dimension nz, double alpha,
                                     const double * __restrict x,
                                     sparse_stride incx, const double * __restrict y,
                                     const sparse_index * __restrict indy,
                                     sparse_matrix_double * __restrict C);
sparse_status sparse_permute_rows_float( sparse_matrix_float A,
                             const sparse_index * __restrict perm );
sparse_status sparse_permute_rows_double( sparse_matrix_double A,
                              const sparse_index * __restrict perm );
sparse_status sparse_permute_cols_float( sparse_matrix_float A,
                             const sparse_index * __restrict perm );
sparse_status sparse_permute_cols_double( sparse_matrix_double A,
                              const sparse_index * __restrict perm );
float sparse_elementwise_norm_float( sparse_matrix_float A, sparse_norm norm );
double sparse_elementwise_norm_double( sparse_matrix_double A, sparse_norm norm );
float sparse_operator_norm_float( sparse_matrix_float A, sparse_norm norm );
double sparse_operator_norm_double( sparse_matrix_double A, sparse_norm norm );
float sparse_matrix_trace_float( sparse_matrix_float A, sparse_index offset );
double sparse_matrix_trace_double( sparse_matrix_double A, sparse_index offset );
#pragma mark - Level 3 Routines -
sparse_status sparse_matrix_product_dense_float( enum CBLAS_ORDER order,
                                           enum CBLAS_TRANSPOSE transa,
                                           sparse_dimension n, float alpha,
                                           sparse_matrix_float A,
                                           const float * __restrict B,
                                           sparse_dimension ldb,
                                           float * __restrict C,
                                           sparse_dimension ldc );
sparse_status sparse_matrix_product_dense_double( enum CBLAS_ORDER order,
                                            enum CBLAS_TRANSPOSE transa,
                                            sparse_dimension n, double alpha,
                                            sparse_matrix_double A,
                                            const double * __restrict B,
                                            sparse_dimension ldb,
                                            double * __restrict C,
                                            sparse_dimension ldc );
sparse_status sparse_matrix_product_sparse_float(enum CBLAS_ORDER order,
                                                 enum CBLAS_TRANSPOSE transa,
                                                 float alpha,
                                                 sparse_matrix_float A,
                                                 sparse_matrix_float B,
                                                 float * __restrict C,
                                                 sparse_dimension ldc );
sparse_status sparse_matrix_product_sparse_double(enum CBLAS_ORDER order,
                                                  enum CBLAS_TRANSPOSE transa,
                                                  double alpha,
                                                  sparse_matrix_double A,
                                                  sparse_matrix_double B,
                                                  double * __restrict C,
                                                  sparse_dimension ldc );
sparse_status sparse_matrix_triangular_solve_dense_float( enum CBLAS_ORDER order,
                                   enum CBLAS_TRANSPOSE transt,
                                   sparse_dimension nrhs, float alpha,
                                   sparse_matrix_float T,
                                   float * __restrict B, sparse_dimension ldb );
sparse_status sparse_matrix_triangular_solve_dense_double( enum CBLAS_ORDER order,
                                    enum CBLAS_TRANSPOSE transt,
                                    sparse_dimension nrhs, double alpha,
                                    sparse_matrix_double T,
                                    double * __restrict B, sparse_dimension ldb );
#pragma mark - Point Wise Sparse Matrix Routines -
sparse_matrix_float sparse_matrix_create_float( sparse_dimension M, sparse_dimension N );
sparse_matrix_double sparse_matrix_create_double( sparse_dimension M, sparse_dimension N );
sparse_status sparse_insert_entry_float( sparse_matrix_float A, float val,
                                   sparse_index i, sparse_index j );
sparse_status sparse_insert_entry_double( sparse_matrix_double A, double val,
                                    sparse_index i, sparse_index j );
sparse_status sparse_insert_entries_float( sparse_matrix_float A, sparse_dimension N,
                                     const float * __restrict val,
                                     const sparse_index * __restrict indx,
                                     const sparse_index * __restrict jndx );
sparse_status sparse_insert_entries_double( sparse_matrix_double A, sparse_dimension N,
                                      const double * __restrict val,
                                      const sparse_index * __restrict indx,
                                      const sparse_index * __restrict jndx );
sparse_status sparse_insert_col_float( sparse_matrix_float A, sparse_index j,
                                 sparse_dimension nz, const float * __restrict val,
                                 const sparse_index * __restrict indx );
sparse_status sparse_insert_col_double( sparse_matrix_double A, sparse_index j,
                                  sparse_dimension nz, const double * __restrict val,
                                  const sparse_index * __restrict indx );
sparse_status sparse_insert_row_float( sparse_matrix_float A, sparse_index i,
                                 sparse_dimension nz, const float * __restrict val,
                                 const sparse_index * __restrict jndx );
sparse_status sparse_insert_row_double( sparse_matrix_double A, sparse_index i,
                                  sparse_dimension nz, const double * __restrict val,
                                  const sparse_index * __restrict jndx );
sparse_status sparse_extract_sparse_row_float( sparse_matrix_float A, sparse_index row,
                                  sparse_index column_start, sparse_index *column_end,
                                  sparse_dimension nz, float * __restrict val,
                                  sparse_index * __restrict jndx );
sparse_status sparse_extract_sparse_row_double( sparse_matrix_double A, sparse_index row,
                                  sparse_index column_start, sparse_index *column_end,
                                  sparse_dimension nz, double * __restrict val,
                                  sparse_index * __restrict jndx );
sparse_status sparse_extract_sparse_column_float( sparse_matrix_float A,
                                            sparse_index column,
                                            sparse_index row_start,
                                            sparse_index *row_end,
                                            sparse_dimension nz,
                                            float * __restrict val,
                                            sparse_index * __restrict indx );
sparse_status sparse_extract_sparse_column_double( sparse_matrix_double A,
                                             sparse_index column,
                                             sparse_index row_start,
                                             sparse_index *row_end,
                                             sparse_dimension nz,
                                             double * __restrict val,
                                             sparse_index * __restrict indx );
#pragma mark - Block Wise Matrix Routines -
sparse_matrix_float sparse_matrix_block_create_float( sparse_dimension Mb,
                                                sparse_dimension Nb,
                                                sparse_dimension k,
                                                sparse_dimension l );
sparse_matrix_double sparse_matrix_block_create_double( sparse_dimension Mb,
                                                  sparse_dimension Nb,
                                                  sparse_dimension k,
                                                  sparse_dimension l );
sparse_matrix_float sparse_matrix_variable_block_create_float( sparse_dimension Mb,
                                                         sparse_dimension Nb,
                                                         const sparse_dimension *K,
                                                         const sparse_dimension *L );
sparse_matrix_double sparse_matrix_variable_block_create_double( sparse_dimension Mb,
                                                           sparse_dimension Nb,
                                                           const sparse_dimension *K,
                                                           const sparse_dimension *L );
sparse_status sparse_insert_block_float( sparse_matrix_float A,
                                   const float * __restrict val,
                                   sparse_dimension row_stride,
                                   sparse_dimension col_stride,
                                   sparse_index bi, sparse_index bj );
sparse_status sparse_insert_block_double( sparse_matrix_double A,
                                    const double * __restrict val,
                                    sparse_dimension row_stride,
                                    sparse_dimension col_stride,
                                    sparse_index bi, sparse_index bj );
sparse_status sparse_extract_block_float( sparse_matrix_float A, sparse_index bi,
                                    sparse_index bj, sparse_dimension row_stride,
                                    sparse_dimension col_stride,
                                    float * __restrict val );
sparse_status sparse_extract_block_double( sparse_matrix_double A, sparse_index bi,
                                     sparse_index bj, sparse_dimension row_stride,
                                     sparse_dimension col_stride,
                                     double * __restrict val );
long sparse_get_block_dimension_for_row( void *A, sparse_index i );
long sparse_get_block_dimension_for_col( void *A, sparse_index j );
#pragma mark - General Sparse Matrix Management Routines -
sparse_status sparse_commit( void *A );
long sparse_get_matrix_property( void *A, sparse_matrix_property pname );
sparse_status sparse_set_matrix_property( void *A, sparse_matrix_property pname );
sparse_dimension sparse_get_matrix_number_of_rows( void *A );
sparse_dimension sparse_get_matrix_number_of_columns( void *A );
long sparse_get_matrix_nonzero_count( void *A );
long sparse_get_matrix_nonzero_count_for_row( void *A, sparse_index i );
long sparse_get_matrix_nonzero_count_for_column( void *A, sparse_index j );
sparse_status sparse_matrix_destroy( void *A );
#pragma mark - Sparse Utilities -
long sparse_get_vector_nonzero_count_float( sparse_dimension N,
                                         const float * __restrict x,
                                         sparse_stride incx );
long sparse_get_vector_nonzero_count_double( sparse_dimension N,
                                          const double * __restrict x,
                                          sparse_stride incx );
long sparse_pack_vector_float( sparse_dimension N, sparse_dimension nz,
                                  const float * __restrict x,
                                  sparse_stride incx, float * __restrict y,
                                  sparse_index * __restrict indy );
long sparse_pack_vector_double( sparse_dimension N, sparse_dimension nz,
                                   const double * __restrict x,
                                   sparse_stride incx, double * __restrict y,
                                   sparse_index * __restrict indy );
void sparse_unpack_vector_float( sparse_dimension N, sparse_dimension nz, bool zero,
                               const float * __restrict x,
                               const sparse_index * __restrict indx,
                               float * __restrict y, sparse_stride incy );
void sparse_unpack_vector_double( sparse_dimension N, sparse_dimension nz, bool zero,
                                const double * __restrict x,
                                const sparse_index * __restrict indx,
                                double * __restrict y, sparse_stride incy );
#ifdef __cplusplus
}
#endif
#endif
