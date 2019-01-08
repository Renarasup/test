#ifndef __SPARSE_TYPES_H
#define __SPARSE_TYPES_H
#pragma mark - Type defines -
#include <stdint.h>
#include <stdbool.h>
typedef struct sparse_m_float* sparse_matrix_float;
typedef struct sparse_m_double* sparse_matrix_double;
typedef uint64_t sparse_dimension;
typedef int64_t sparse_stride;
typedef int64_t sparse_index;
typedef enum {
    SPARSE_SUCCESS = 0,
    SPARSE_ILLEGAL_PARAMETER = -1000,
    SPARSE_CANNOT_SET_PROPERTY = -1001,
    SPARSE_SYSTEM_ERROR = -1002,
} sparse_status;
typedef enum {
    SPARSE_UPPER_TRIANGULAR = 1,
    SPARSE_LOWER_TRIANGULAR = 2,
    SPARSE_UPPER_SYMMETRIC = 4,
    SPARSE_LOWER_SYMMETRIC = 8,
} sparse_matrix_property;
typedef enum {
    SPARSE_NORM_ONE = 171,
    SPARSE_NORM_TWO = 173,
    SPARSE_NORM_INF = 175,
    SPARSE_NORM_R1 =  179
} sparse_norm;
#endif
