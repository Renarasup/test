#ifndef SPARSE_SOLVE_HEADER
#define SPARSE_SOLVE_HEADER
#ifndef __has_include
# define __has_include(_) 0
#endif
#ifndef __has_feature
# define __has_feature(_) 0
#endif
#ifndef __has_attribute
# define __has_attribute(_) 0
#endif
#if __has_attribute(overloadable)
#define SPARSE_PUBLIC_INTERFACE __attribute__((overloadable))
#include <limits.h>
#include <stdint.h>
#include <stdbool.h>
#include <stdlib.h>
#if defined __VECLIB__ 
# define SPARSE_INCLUDED_VIA_ACCELERATE
#endif
#if __has_include(<Accelerate/Accelerate.h>)
# include <Accelerate/Accelerate.h>
#else
# include <cblas.h>
#endif
#if __has_include(<os/object.h>)
# include <os/object.h>
#else
# define OS_ENUM(_name, _type, ...) enum { __VA_ARGS__ }; typedef _type _name##_t
#endif
#if __has_include(<Availability.h>)
# include <Availability.h>
#else
# define __OSX_AVAILABLE(_) 
# define __IOS_AVAILABLE(_) 
# define __WATCHOS_AVAILABLE(_) 
# define __TVOS_AVAILABLE(_) 
#endif
#if __has_feature(nullability)
#pragma clang assume_nonnull begin
#endif
OS_ENUM(SparseKind, unsigned int,
  SparseOrdinary       = 0,
  SparseTriangular     = 1,
  SparseUnitTriangular = 2,
  SparseSymmetric      = 3,
);
OS_ENUM(SparseTriangle, unsigned char,
  SparseUpperTriangle = 0,
  SparseLowerTriangle = 1
);
typedef struct {
  bool            transpose: 1;
  SparseTriangle_t triangle: 1;
  SparseKind_t         kind: 2;
  unsigned int    _reserved: 11;
  bool   _allocatedBySparse: 1;
} SparseAttributes_t;
typedef struct {
  int rowCount;
  int columnCount;
  long *columnStarts;
  int *rowIndices;
  SparseAttributes_t attributes;
  uint8_t blockSize;
} SparseMatrixStructure;
typedef struct {
  SparseMatrixStructure structure;
  double *data;
} SparseMatrix_Double;
typedef struct {
  SparseMatrixStructure structure;
  float *data;
} SparseMatrix_Float;
static inline SPARSE_PUBLIC_INTERFACE
SparseMatrix_Double SparseConvertFromCoordinate(int rowCount, int columnCount,
  long blockCount, uint8_t blockSize, SparseAttributes_t attributes,
  const int *row, const int *column, const double *data)
__OSX_AVAILABLE(10.13) __IOS_AVAILABLE(11) __WATCHOS_AVAILABLE(4) __TVOS_AVAILABLE(11);
static inline SPARSE_PUBLIC_INTERFACE
SparseMatrix_Float SparseConvertFromCoordinate(int rowCount, int columnCount, long blockCount,
  uint8_t blockSize, SparseAttributes_t attributes, const int *row,
  const int *column, const float *data)
__OSX_AVAILABLE(10.13) __IOS_AVAILABLE(11) __WATCHOS_AVAILABLE(4) __TVOS_AVAILABLE(11);
static inline SPARSE_PUBLIC_INTERFACE
SparseMatrix_Double SparseConvertFromCoordinate(int rowCount, int columnCount, long blockCount,
  uint8_t blockSize, SparseAttributes_t attributes, const int *row,
  const int *column, const double *data, void *storage, void *workspace)
__OSX_AVAILABLE(10.13) __IOS_AVAILABLE(11) __WATCHOS_AVAILABLE(4) __TVOS_AVAILABLE(11);
static inline SPARSE_PUBLIC_INTERFACE
SparseMatrix_Float SparseConvertFromCoordinate(int rowCount, int columnCount, long blockCount,
  uint8_t blockSize, SparseAttributes_t attributes, const int *row,
  const int *column, const float *data, void *storage, void *workspace)
__OSX_AVAILABLE(10.13) __IOS_AVAILABLE(11) __WATCHOS_AVAILABLE(4) __TVOS_AVAILABLE(11);
#if defined __SPARSE_TYPES_H
static inline SPARSE_PUBLIC_INTERFACE
SparseMatrix_Double SparseConvertFromOpaque(sparse_matrix_double matrix)
__OSX_AVAILABLE(10.13) __IOS_AVAILABLE(11) __WATCHOS_AVAILABLE(4) __TVOS_AVAILABLE(11);
static inline SPARSE_PUBLIC_INTERFACE
SparseMatrix_Float SparseConvertFromOpaque(sparse_matrix_float matrix)
__OSX_AVAILABLE(10.13) __IOS_AVAILABLE(11) __WATCHOS_AVAILABLE(4) __TVOS_AVAILABLE(11);
#endif 
typedef struct {
  int count;
  double *data;
} DenseVector_Double;
typedef struct {
  int count;
  float *data;
} DenseVector_Float;
typedef struct {
  int rowCount;
  int columnCount;
  int columnStride;
  SparseAttributes_t attributes;
  double *data;
} DenseMatrix_Double;
typedef struct {
  int rowCount;
  int columnCount;
  int columnStride;
  SparseAttributes_t attributes;
  float *data;
} DenseMatrix_Float;
OS_ENUM(SparseStatus, int,
  SparseStatusOK            =  0,
  SparseFactorizationFailed = -1,
  SparseMatrixIsSingular    = -2,
  SparseInternalError       = -3,
  SparseParameterError      = -4,
  SparseStatusReleased      = -INT_MAX,
);
OS_ENUM(SparseFactorization, uint8_t,
  SparseFactorizationCholesky = 0,
  SparseFactorizationLDLT = 1,
  SparseFactorizationLDLTUnpivoted = 2,
  SparseFactorizationLDLTSBK = 3,
  SparseFactorizationLDLTTPP = 4,
  SparseFactorizationQR = 40,
  SparseFactorizationCholeskyAtA = 41
);
OS_ENUM(SparseControl, uint32_t,
  SparseDefaultControl = 0
);
OS_ENUM(SparseOrder, uint8_t,
  SparseOrderDefault = 0,
  SparseOrderUser = 1,
  SparseOrderAMD = 2,
  SparseOrderMetis = 3,
  SparseOrderCOLAMD = 4,
);
OS_ENUM(SparseScaling, uint8_t,
  SparseScalingDefault = 0,
  SparseScalingUser = 1,
  SparseScalingEquilibriationInf = 2,
);
typedef struct {
  SparseControl_t control;
  SparseOrder_t orderMethod;
  int * _Nullable order;
  int *_Nullable ignoreRowsAndColumns;
  void * _Nullable(* _Nonnull malloc)(size_t size);
  void (* _Nonnull free)(void * _Nullable pointer);
  void (* _Nullable reportError)(const char *message);
} SparseSymbolicFactorOptions;
typedef struct {
  SparseControl_t control;
  SparseScaling_t scalingMethod;
  void * _Nullable scaling;
  double pivotTolerance;
  double zeroTolerance;
} SparseNumericFactorOptions;
typedef struct {
  SparseStatus_t status;
  int rowCount;
  int columnCount;
  SparseAttributes_t attributes;
  uint8_t blockSize;
  SparseFactorization_t type;
  void *_Nullable factorization;
  size_t workspaceSize_Float;
  size_t workspaceSize_Double;
  size_t factorSize_Float;
  size_t factorSize_Double;
} SparseOpaqueSymbolicFactorization;
typedef struct {
  SparseStatus_t status;
  SparseAttributes_t attributes;
  SparseOpaqueSymbolicFactorization symbolicFactorization;
  bool userFactorStorage;
  void *_Nullable numericFactorization;
  size_t solveWorkspaceRequiredStatic;
  size_t solveWorkspaceRequiredPerRHS;
} SparseOpaqueFactorization_Double;
typedef struct {
  SparseStatus_t status;
  SparseAttributes_t attributes;
  SparseOpaqueSymbolicFactorization symbolicFactorization;
  bool userFactorStorage;
  void *_Nullable numericFactorization;
  size_t solveWorkspaceRequiredStatic;
  size_t solveWorkspaceRequiredPerRHS;
} SparseOpaqueFactorization_Float;
OS_ENUM(SparseSubfactor, uint8_t,
        SparseSubfactorInvalid = 0,
        SparseSubfactorP = 1,
        SparseSubfactorS = 2,
        SparseSubfactorL = 3,
        SparseSubfactorD = 4,
        SparseSubfactorPLPS = 5,
        SparseSubfactorQ = 6,
        SparseSubfactorR = 7,
        SparseSubfactorRP = 8
        );
typedef struct {
  SparseAttributes_t attributes;
  SparseSubfactor_t contents;
  SparseOpaqueFactorization_Double factor;
  size_t workspaceRequiredStatic;
  size_t workspaceRequiredPerRHS;
} SparseOpaqueSubfactor_Double;
typedef struct {
  SparseAttributes_t attributes;
  SparseSubfactor_t contents;
  SparseOpaqueFactorization_Float factor;
  size_t workspaceRequiredStatic;
  size_t workspaceRequiredPerRHS;
} SparseOpaqueSubfactor_Float;
static inline SPARSE_PUBLIC_INTERFACE
void SparseMultiply(SparseMatrix_Double A, DenseMatrix_Double X, DenseMatrix_Double Y)
__OSX_AVAILABLE(10.13) __IOS_AVAILABLE(11) __WATCHOS_AVAILABLE(4) __TVOS_AVAILABLE(11);
static inline SPARSE_PUBLIC_INTERFACE
void SparseMultiply(SparseMatrix_Float A, DenseMatrix_Float X, DenseMatrix_Float Y)
__OSX_AVAILABLE(10.13) __IOS_AVAILABLE(11) __WATCHOS_AVAILABLE(4) __TVOS_AVAILABLE(11);
static inline SPARSE_PUBLIC_INTERFACE
void SparseMultiply(double alpha, SparseMatrix_Double A, DenseMatrix_Double X, DenseMatrix_Double Y)
__OSX_AVAILABLE(10.13) __IOS_AVAILABLE(11) __WATCHOS_AVAILABLE(4) __TVOS_AVAILABLE(11);
static inline SPARSE_PUBLIC_INTERFACE
void SparseMultiply(float alpha, SparseMatrix_Float A, DenseMatrix_Float X, DenseMatrix_Float Y)
__OSX_AVAILABLE(10.13) __IOS_AVAILABLE(11) __WATCHOS_AVAILABLE(4) __TVOS_AVAILABLE(11);
static inline SPARSE_PUBLIC_INTERFACE
void SparseMultiply(SparseMatrix_Double A, DenseVector_Double x, DenseVector_Double y)
__OSX_AVAILABLE(10.13) __IOS_AVAILABLE(11) __WATCHOS_AVAILABLE(4) __TVOS_AVAILABLE(11);
static inline SPARSE_PUBLIC_INTERFACE
void SparseMultiply(SparseMatrix_Float A, DenseVector_Float x, DenseVector_Float y)
__OSX_AVAILABLE(10.13) __IOS_AVAILABLE(11) __WATCHOS_AVAILABLE(4) __TVOS_AVAILABLE(11);
static inline SPARSE_PUBLIC_INTERFACE
void SparseMultiply(double alpha, SparseMatrix_Double A, DenseVector_Double x, DenseVector_Double y)
__OSX_AVAILABLE(10.13) __IOS_AVAILABLE(11) __WATCHOS_AVAILABLE(4) __TVOS_AVAILABLE(11);
static inline SPARSE_PUBLIC_INTERFACE
void SparseMultiply(float alpha, SparseMatrix_Float A, DenseVector_Float x, DenseVector_Float y)
__OSX_AVAILABLE(10.13) __IOS_AVAILABLE(11) __WATCHOS_AVAILABLE(4) __TVOS_AVAILABLE(11);
static inline SPARSE_PUBLIC_INTERFACE
void SparseMultiplyAdd(SparseMatrix_Double A, DenseMatrix_Double X, DenseMatrix_Double Y)
__OSX_AVAILABLE(10.13) __IOS_AVAILABLE(11) __WATCHOS_AVAILABLE(4) __TVOS_AVAILABLE(11);
static inline SPARSE_PUBLIC_INTERFACE
void SparseMultiplyAdd(SparseMatrix_Float A, DenseMatrix_Float X, DenseMatrix_Float Y)
__OSX_AVAILABLE(10.13) __IOS_AVAILABLE(11) __WATCHOS_AVAILABLE(4) __TVOS_AVAILABLE(11);
static inline SPARSE_PUBLIC_INTERFACE
void SparseMultiplyAdd(double alpha, SparseMatrix_Double A, DenseMatrix_Double X, DenseMatrix_Double Y)
__OSX_AVAILABLE(10.13) __IOS_AVAILABLE(11) __WATCHOS_AVAILABLE(4) __TVOS_AVAILABLE(11);
static inline SPARSE_PUBLIC_INTERFACE
void SparseMultiplyAdd(float alpha, SparseMatrix_Float A, DenseMatrix_Float X, DenseMatrix_Float Y)
__OSX_AVAILABLE(10.13) __IOS_AVAILABLE(11) __WATCHOS_AVAILABLE(4) __TVOS_AVAILABLE(11);
static inline SPARSE_PUBLIC_INTERFACE
void SparseMultiplyAdd(SparseMatrix_Double A, DenseVector_Double x, DenseVector_Double y)
__OSX_AVAILABLE(10.13) __IOS_AVAILABLE(11) __WATCHOS_AVAILABLE(4) __TVOS_AVAILABLE(11);
static inline SPARSE_PUBLIC_INTERFACE
void SparseMultiplyAdd(SparseMatrix_Float A, DenseVector_Float x, DenseVector_Float y)
__OSX_AVAILABLE(10.13) __IOS_AVAILABLE(11) __WATCHOS_AVAILABLE(4) __TVOS_AVAILABLE(11);
static inline SPARSE_PUBLIC_INTERFACE
void SparseMultiplyAdd(double alpha, SparseMatrix_Double A, DenseVector_Double x, DenseVector_Double y)
__OSX_AVAILABLE(10.13) __IOS_AVAILABLE(11) __WATCHOS_AVAILABLE(4) __TVOS_AVAILABLE(11);
static inline SPARSE_PUBLIC_INTERFACE
void SparseMultiplyAdd(float alpha, SparseMatrix_Float A, DenseVector_Float x, DenseVector_Float y)
__OSX_AVAILABLE(10.13) __IOS_AVAILABLE(11) __WATCHOS_AVAILABLE(4) __TVOS_AVAILABLE(11);
static inline SPARSE_PUBLIC_INTERFACE __OSX_AVAILABLE(10.13) __IOS_AVAILABLE(11) __WATCHOS_AVAILABLE(4) __TVOS_AVAILABLE(11)
SparseMatrix_Double SparseGetTranspose(SparseMatrix_Double Matrix);
static inline SPARSE_PUBLIC_INTERFACE __OSX_AVAILABLE(10.13) __IOS_AVAILABLE(11) __WATCHOS_AVAILABLE(4) __TVOS_AVAILABLE(11)
SparseMatrix_Float SparseGetTranspose(SparseMatrix_Float Matrix);
static inline SPARSE_PUBLIC_INTERFACE __OSX_AVAILABLE(10.13) __IOS_AVAILABLE(11) __WATCHOS_AVAILABLE(4) __TVOS_AVAILABLE(11)
SparseOpaqueFactorization_Double SparseGetTranspose(SparseOpaqueFactorization_Double Factor);
static inline SPARSE_PUBLIC_INTERFACE __OSX_AVAILABLE(10.13) __IOS_AVAILABLE(11) __WATCHOS_AVAILABLE(4) __TVOS_AVAILABLE(11)
SparseOpaqueFactorization_Float SparseGetTranspose(SparseOpaqueFactorization_Float Factor);
static inline SPARSE_PUBLIC_INTERFACE __OSX_AVAILABLE(10.13) __IOS_AVAILABLE(11) __WATCHOS_AVAILABLE(4) __TVOS_AVAILABLE(11)
SparseOpaqueSubfactor_Double SparseGetTranspose(SparseOpaqueSubfactor_Double Subfactor);
static inline SPARSE_PUBLIC_INTERFACE __OSX_AVAILABLE(10.13) __IOS_AVAILABLE(11) __WATCHOS_AVAILABLE(4) __TVOS_AVAILABLE(11)
SparseOpaqueSubfactor_Float SparseGetTranspose(SparseOpaqueSubfactor_Float Subfactor);
static inline SPARSE_PUBLIC_INTERFACE __OSX_AVAILABLE(10.13) __IOS_AVAILABLE(11) __WATCHOS_AVAILABLE(4) __TVOS_AVAILABLE(11)
SparseOpaqueFactorization_Double SparseFactor(SparseFactorization_t type, SparseMatrix_Double Matrix);
static inline SPARSE_PUBLIC_INTERFACE __OSX_AVAILABLE(10.13) __IOS_AVAILABLE(11) __WATCHOS_AVAILABLE(4) __TVOS_AVAILABLE(11)
SparseOpaqueFactorization_Float SparseFactor(SparseFactorization_t type, SparseMatrix_Float Matrix);
static inline SPARSE_PUBLIC_INTERFACE __OSX_AVAILABLE(10.13) __IOS_AVAILABLE(11) __WATCHOS_AVAILABLE(4) __TVOS_AVAILABLE(11)
SparseOpaqueFactorization_Double SparseFactor(SparseFactorization_t type, SparseMatrix_Double Matrix, SparseSymbolicFactorOptions sfoptions, SparseNumericFactorOptions nfoptions);
static inline SPARSE_PUBLIC_INTERFACE __OSX_AVAILABLE(10.13) __IOS_AVAILABLE(11) __WATCHOS_AVAILABLE(4) __TVOS_AVAILABLE(11)
SparseOpaqueFactorization_Float SparseFactor(SparseFactorization_t type, SparseMatrix_Float Matrix, SparseSymbolicFactorOptions sfoptions, SparseNumericFactorOptions nfoptions);
static inline SPARSE_PUBLIC_INTERFACE __OSX_AVAILABLE(10.13) __IOS_AVAILABLE(11) __WATCHOS_AVAILABLE(4) __TVOS_AVAILABLE(11)
SparseOpaqueFactorization_Double SparseFactor(SparseOpaqueSymbolicFactorization SymbolicFactor, SparseMatrix_Double Matrix);
static inline SPARSE_PUBLIC_INTERFACE __OSX_AVAILABLE(10.13) __IOS_AVAILABLE(11) __WATCHOS_AVAILABLE(4) __TVOS_AVAILABLE(11)
SparseOpaqueFactorization_Float SparseFactor(SparseOpaqueSymbolicFactorization SymbolicFactor, SparseMatrix_Float Matrix);
static inline SPARSE_PUBLIC_INTERFACE __OSX_AVAILABLE(10.13) __IOS_AVAILABLE(11) __WATCHOS_AVAILABLE(4) __TVOS_AVAILABLE(11)
SparseOpaqueFactorization_Double SparseFactor(SparseOpaqueSymbolicFactorization SymbolicFactor, SparseMatrix_Double Matrix, SparseNumericFactorOptions nfoptions);
static inline SPARSE_PUBLIC_INTERFACE __OSX_AVAILABLE(10.13) __IOS_AVAILABLE(11) __WATCHOS_AVAILABLE(4) __TVOS_AVAILABLE(11)
SparseOpaqueFactorization_Float SparseFactor(SparseOpaqueSymbolicFactorization SymbolicFactor, SparseMatrix_Float Matrix, SparseNumericFactorOptions nfoptions);
static inline SPARSE_PUBLIC_INTERFACE __OSX_AVAILABLE(10.13) __IOS_AVAILABLE(11) __WATCHOS_AVAILABLE(4) __TVOS_AVAILABLE(11)
SparseOpaqueFactorization_Double SparseFactor(
  SparseOpaqueSymbolicFactorization SymbolicFactor, SparseMatrix_Double Matrix,
  SparseNumericFactorOptions nfoptions, void *_Nullable factorStorage,
  void *_Nullable workspace);
static inline SPARSE_PUBLIC_INTERFACE __OSX_AVAILABLE(10.13) __IOS_AVAILABLE(11) __WATCHOS_AVAILABLE(4) __TVOS_AVAILABLE(11)
SparseOpaqueFactorization_Float SparseFactor(
  SparseOpaqueSymbolicFactorization SymbolicFactor, SparseMatrix_Float Matrix,
  SparseNumericFactorOptions nfoptions, void *_Nullable factorStorage,
  void *_Nullable workspace);
static inline SPARSE_PUBLIC_INTERFACE __OSX_AVAILABLE(10.13) __IOS_AVAILABLE(11) __WATCHOS_AVAILABLE(4) __TVOS_AVAILABLE(11)
void SparseSolve(SparseOpaqueFactorization_Double Factored, DenseMatrix_Double XB);
static inline SPARSE_PUBLIC_INTERFACE __OSX_AVAILABLE(10.13) __IOS_AVAILABLE(11) __WATCHOS_AVAILABLE(4) __TVOS_AVAILABLE(11)
void SparseSolve(SparseOpaqueFactorization_Float Factored, DenseMatrix_Float XB);
static inline SPARSE_PUBLIC_INTERFACE __OSX_AVAILABLE(10.13) __IOS_AVAILABLE(11) __WATCHOS_AVAILABLE(4) __TVOS_AVAILABLE(11)
void SparseSolve(SparseOpaqueFactorization_Double Factored, DenseMatrix_Double B, DenseMatrix_Double X);
static inline SPARSE_PUBLIC_INTERFACE __OSX_AVAILABLE(10.13) __IOS_AVAILABLE(11) __WATCHOS_AVAILABLE(4) __TVOS_AVAILABLE(11)
void SparseSolve(SparseOpaqueFactorization_Float Factored, DenseMatrix_Float B, DenseMatrix_Float X);
static inline SPARSE_PUBLIC_INTERFACE __OSX_AVAILABLE(10.13) __IOS_AVAILABLE(11) __WATCHOS_AVAILABLE(4) __TVOS_AVAILABLE(11)
void SparseSolve(SparseOpaqueFactorization_Double Factored,
  DenseMatrix_Double XB, void *workspace);
static inline SPARSE_PUBLIC_INTERFACE __OSX_AVAILABLE(10.13) __IOS_AVAILABLE(11) __WATCHOS_AVAILABLE(4) __TVOS_AVAILABLE(11)
void SparseSolve(SparseOpaqueFactorization_Float Factored, DenseMatrix_Float XB,
  void *workspace);
static inline SPARSE_PUBLIC_INTERFACE __OSX_AVAILABLE(10.13) __IOS_AVAILABLE(11) __WATCHOS_AVAILABLE(4) __TVOS_AVAILABLE(11)
void SparseSolve(SparseOpaqueFactorization_Double Factored,
  DenseMatrix_Double X, DenseMatrix_Double B, void *workspace);
static inline SPARSE_PUBLIC_INTERFACE __OSX_AVAILABLE(10.13) __IOS_AVAILABLE(11) __WATCHOS_AVAILABLE(4) __TVOS_AVAILABLE(11)
void SparseSolve(SparseOpaqueFactorization_Float Factored, DenseMatrix_Float X,
  DenseMatrix_Float B, void *workspace);
static inline SPARSE_PUBLIC_INTERFACE __OSX_AVAILABLE(10.13) __IOS_AVAILABLE(11) __WATCHOS_AVAILABLE(4) __TVOS_AVAILABLE(11)
void SparseSolve(SparseOpaqueFactorization_Double Factored,
  DenseVector_Double xb);
static inline SPARSE_PUBLIC_INTERFACE __OSX_AVAILABLE(10.13) __IOS_AVAILABLE(11) __WATCHOS_AVAILABLE(4) __TVOS_AVAILABLE(11)
void SparseSolve(SparseOpaqueFactorization_Float Factored, DenseVector_Float xb);
static inline SPARSE_PUBLIC_INTERFACE __OSX_AVAILABLE(10.13) __IOS_AVAILABLE(11) __WATCHOS_AVAILABLE(4) __TVOS_AVAILABLE(11)
void SparseSolve(SparseOpaqueFactorization_Double Factored,
  DenseVector_Double b, DenseVector_Double x);
static inline SPARSE_PUBLIC_INTERFACE __OSX_AVAILABLE(10.13) __IOS_AVAILABLE(11) __WATCHOS_AVAILABLE(4) __TVOS_AVAILABLE(11)
void SparseSolve(SparseOpaqueFactorization_Float Factored, DenseVector_Float b,
  DenseVector_Float x);
static inline SPARSE_PUBLIC_INTERFACE __OSX_AVAILABLE(10.13) __IOS_AVAILABLE(11) __WATCHOS_AVAILABLE(4) __TVOS_AVAILABLE(11)
void SparseSolve(SparseOpaqueFactorization_Double Factored,
  DenseVector_Double xb, void *workspace);
static inline SPARSE_PUBLIC_INTERFACE __OSX_AVAILABLE(10.13) __IOS_AVAILABLE(11) __WATCHOS_AVAILABLE(4) __TVOS_AVAILABLE(11)
void SparseSolve(SparseOpaqueFactorization_Float Factored, DenseVector_Float xb,
                 void *workspace);
static inline SPARSE_PUBLIC_INTERFACE __OSX_AVAILABLE(10.13) __IOS_AVAILABLE(11) __WATCHOS_AVAILABLE(4) __TVOS_AVAILABLE(11)
void SparseSolve(SparseOpaqueFactorization_Double Factored,
  DenseVector_Double x, DenseVector_Double b, void *workspace);
static inline SPARSE_PUBLIC_INTERFACE __OSX_AVAILABLE(10.13) __IOS_AVAILABLE(11) __WATCHOS_AVAILABLE(4) __TVOS_AVAILABLE(11)
void SparseSolve(SparseOpaqueFactorization_Float Factored, DenseVector_Float x,
  DenseVector_Float b, void *workspace);
static inline SPARSE_PUBLIC_INTERFACE __OSX_AVAILABLE(10.13) __IOS_AVAILABLE(11) __WATCHOS_AVAILABLE(4) __TVOS_AVAILABLE(11)
SparseOpaqueSymbolicFactorization SparseFactor(SparseFactorization_t type,
  SparseMatrixStructure Matrix);
static inline SPARSE_PUBLIC_INTERFACE __OSX_AVAILABLE(10.13) __IOS_AVAILABLE(11) __WATCHOS_AVAILABLE(4) __TVOS_AVAILABLE(11)
SparseOpaqueSymbolicFactorization SparseFactor(SparseFactorization_t type,
  SparseMatrixStructure Matrix, SparseSymbolicFactorOptions sfoptions);
static inline SPARSE_PUBLIC_INTERFACE __OSX_AVAILABLE(10.13) __IOS_AVAILABLE(11) __WATCHOS_AVAILABLE(4) __TVOS_AVAILABLE(11)
void SparseRefactor(SparseMatrix_Double Matrix,
  SparseOpaqueFactorization_Double *Factorization);
static inline SPARSE_PUBLIC_INTERFACE __OSX_AVAILABLE(10.13) __IOS_AVAILABLE(11) __WATCHOS_AVAILABLE(4) __TVOS_AVAILABLE(11)
void SparseRefactor(SparseMatrix_Float Matrix,
  SparseOpaqueFactorization_Float *Factorization);
static inline SPARSE_PUBLIC_INTERFACE __OSX_AVAILABLE(10.13) __IOS_AVAILABLE(11) __WATCHOS_AVAILABLE(4) __TVOS_AVAILABLE(11)
void SparseRefactor(SparseMatrix_Double Matrix,
  SparseOpaqueFactorization_Double *Factorization,
  SparseNumericFactorOptions nfoptions);
static inline SPARSE_PUBLIC_INTERFACE __OSX_AVAILABLE(10.13) __IOS_AVAILABLE(11) __WATCHOS_AVAILABLE(4) __TVOS_AVAILABLE(11)
void SparseRefactor(SparseMatrix_Float Matrix,
  SparseOpaqueFactorization_Float *Factorization,
  SparseNumericFactorOptions nfoptions);
static inline SPARSE_PUBLIC_INTERFACE __OSX_AVAILABLE(10.13) __IOS_AVAILABLE(11) __WATCHOS_AVAILABLE(4) __TVOS_AVAILABLE(11)
void SparseRefactor(SparseMatrix_Double Matrix,
  SparseOpaqueFactorization_Double *Factorization, void *workspace);
static inline SPARSE_PUBLIC_INTERFACE __OSX_AVAILABLE(10.13) __IOS_AVAILABLE(11) __WATCHOS_AVAILABLE(4) __TVOS_AVAILABLE(11)
void SparseRefactor(SparseMatrix_Float Matrix,
  SparseOpaqueFactorization_Float *Factorization, void *workspace);
static inline SPARSE_PUBLIC_INTERFACE __OSX_AVAILABLE(10.13) __IOS_AVAILABLE(11) __WATCHOS_AVAILABLE(4) __TVOS_AVAILABLE(11)
void SparseRefactor(SparseMatrix_Double Matrix,
  SparseOpaqueFactorization_Double *Factorization,
  SparseNumericFactorOptions nfoptions, void *workspace);
static inline SPARSE_PUBLIC_INTERFACE __OSX_AVAILABLE(10.13) __IOS_AVAILABLE(11) __WATCHOS_AVAILABLE(4) __TVOS_AVAILABLE(11)
void SparseRefactor(SparseMatrix_Float Matrix,
  SparseOpaqueFactorization_Float *Factorization,
  SparseNumericFactorOptions nfoptions, void *workspace);
static inline SPARSE_PUBLIC_INTERFACE __OSX_AVAILABLE(10.13) __IOS_AVAILABLE(11) __WATCHOS_AVAILABLE(4) __TVOS_AVAILABLE(11)
SparseOpaqueSubfactor_Double SparseCreateSubfactor(SparseSubfactor_t subfactor,
  SparseOpaqueFactorization_Double Factor);
static inline SPARSE_PUBLIC_INTERFACE __OSX_AVAILABLE(10.13) __IOS_AVAILABLE(11) __WATCHOS_AVAILABLE(4) __TVOS_AVAILABLE(11)
SparseOpaqueSubfactor_Float SparseCreateSubfactor(SparseSubfactor_t subfactor,
  SparseOpaqueFactorization_Float Factor);
static inline SPARSE_PUBLIC_INTERFACE __OSX_AVAILABLE(10.13) __IOS_AVAILABLE(11) __WATCHOS_AVAILABLE(4) __TVOS_AVAILABLE(11)
void SparseSolve(SparseOpaqueSubfactor_Double Subfactor, DenseMatrix_Double XB);
static inline SPARSE_PUBLIC_INTERFACE __OSX_AVAILABLE(10.13) __IOS_AVAILABLE(11) __WATCHOS_AVAILABLE(4) __TVOS_AVAILABLE(11)
void SparseSolve(SparseOpaqueSubfactor_Float Subfactor, DenseMatrix_Float XB);
static inline SPARSE_PUBLIC_INTERFACE __OSX_AVAILABLE(10.13) __IOS_AVAILABLE(11) __WATCHOS_AVAILABLE(4) __TVOS_AVAILABLE(11)
void SparseSolve(SparseOpaqueSubfactor_Double Subfactor, DenseMatrix_Double B,
  DenseMatrix_Double X);
static inline SPARSE_PUBLIC_INTERFACE __OSX_AVAILABLE(10.13) __IOS_AVAILABLE(11) __WATCHOS_AVAILABLE(4) __TVOS_AVAILABLE(11)
void SparseSolve(SparseOpaqueSubfactor_Float Subfactor, DenseMatrix_Float B,
  DenseMatrix_Float X);
static inline SPARSE_PUBLIC_INTERFACE __OSX_AVAILABLE(10.13) __IOS_AVAILABLE(11) __WATCHOS_AVAILABLE(4) __TVOS_AVAILABLE(11)
void SparseSolve(SparseOpaqueSubfactor_Double Subfactor, DenseMatrix_Double XB,
  void *workspace);
static inline SPARSE_PUBLIC_INTERFACE __OSX_AVAILABLE(10.13) __IOS_AVAILABLE(11) __WATCHOS_AVAILABLE(4) __TVOS_AVAILABLE(11)
void SparseSolve(SparseOpaqueSubfactor_Float Subfactor, DenseMatrix_Float XB,
  void *workspace);
static inline SPARSE_PUBLIC_INTERFACE __OSX_AVAILABLE(10.13) __IOS_AVAILABLE(11) __WATCHOS_AVAILABLE(4) __TVOS_AVAILABLE(11)
void SparseSolve(SparseOpaqueSubfactor_Double Subfactor, DenseMatrix_Double B,
  DenseMatrix_Double X, void *workspace);
static inline SPARSE_PUBLIC_INTERFACE __OSX_AVAILABLE(10.13) __IOS_AVAILABLE(11) __WATCHOS_AVAILABLE(4) __TVOS_AVAILABLE(11)
void SparseSolve(SparseOpaqueSubfactor_Float Subfactor, DenseMatrix_Float B,
  DenseMatrix_Float X, void *workspace);
static inline SPARSE_PUBLIC_INTERFACE __OSX_AVAILABLE(10.13) __IOS_AVAILABLE(11) __WATCHOS_AVAILABLE(4) __TVOS_AVAILABLE(11)
void SparseSolve(SparseOpaqueSubfactor_Double Subfactor, DenseVector_Double xb);
static inline SPARSE_PUBLIC_INTERFACE __OSX_AVAILABLE(10.13) __IOS_AVAILABLE(11) __WATCHOS_AVAILABLE(4) __TVOS_AVAILABLE(11)
void SparseSolve(SparseOpaqueSubfactor_Float Subfactor, DenseVector_Float xb);
static inline SPARSE_PUBLIC_INTERFACE __OSX_AVAILABLE(10.13) __IOS_AVAILABLE(11) __WATCHOS_AVAILABLE(4) __TVOS_AVAILABLE(11)
void SparseSolve(SparseOpaqueSubfactor_Double Subfactor, DenseVector_Double b,
  DenseVector_Double x);
static inline SPARSE_PUBLIC_INTERFACE __OSX_AVAILABLE(10.13) __IOS_AVAILABLE(11) __WATCHOS_AVAILABLE(4) __TVOS_AVAILABLE(11)
void SparseSolve(SparseOpaqueSubfactor_Float Subfactor, DenseVector_Float b,
  DenseVector_Float x);
static inline SPARSE_PUBLIC_INTERFACE __OSX_AVAILABLE(10.13) __IOS_AVAILABLE(11) __WATCHOS_AVAILABLE(4) __TVOS_AVAILABLE(11)
void SparseSolve(SparseOpaqueSubfactor_Double Subfactor, DenseVector_Double xb,
  void *workspace);
static inline SPARSE_PUBLIC_INTERFACE __OSX_AVAILABLE(10.13) __IOS_AVAILABLE(11) __WATCHOS_AVAILABLE(4) __TVOS_AVAILABLE(11)
void SparseSolve(SparseOpaqueSubfactor_Double Subfactor, DenseVector_Double xb,
  void *workspace);
static inline SPARSE_PUBLIC_INTERFACE __OSX_AVAILABLE(10.13) __IOS_AVAILABLE(11) __WATCHOS_AVAILABLE(4) __TVOS_AVAILABLE(11)
void SparseSolve(SparseOpaqueSubfactor_Double Subfactor, DenseVector_Double b,
  DenseVector_Double x, void *workspace);
static inline SPARSE_PUBLIC_INTERFACE __OSX_AVAILABLE(10.13) __IOS_AVAILABLE(11) __WATCHOS_AVAILABLE(4) __TVOS_AVAILABLE(11)
void SparseSolve(SparseOpaqueSubfactor_Float Subfactor, DenseVector_Float b,
  DenseVector_Float x, void *workspace);
static inline SPARSE_PUBLIC_INTERFACE __OSX_AVAILABLE(10.13) __IOS_AVAILABLE(11) __WATCHOS_AVAILABLE(4) __TVOS_AVAILABLE(11)
void SparseMultiply(SparseOpaqueSubfactor_Double Subfactor, DenseMatrix_Double XY);
static inline SPARSE_PUBLIC_INTERFACE __OSX_AVAILABLE(10.13) __IOS_AVAILABLE(11) __WATCHOS_AVAILABLE(4) __TVOS_AVAILABLE(11)
void SparseMultiply(SparseOpaqueSubfactor_Float Subfactor, DenseMatrix_Float XY);
static inline SPARSE_PUBLIC_INTERFACE __OSX_AVAILABLE(10.13) __IOS_AVAILABLE(11) __WATCHOS_AVAILABLE(4) __TVOS_AVAILABLE(11)
void SparseMultiply(SparseOpaqueSubfactor_Double Subfactor, DenseMatrix_Double X,
  DenseMatrix_Double Y);
static inline SPARSE_PUBLIC_INTERFACE __OSX_AVAILABLE(10.13) __IOS_AVAILABLE(11) __WATCHOS_AVAILABLE(4) __TVOS_AVAILABLE(11)
void SparseMultiply(SparseOpaqueSubfactor_Float Subfactor, DenseMatrix_Float X,
  DenseMatrix_Float Y);
static inline SPARSE_PUBLIC_INTERFACE __OSX_AVAILABLE(10.13) __IOS_AVAILABLE(11) __WATCHOS_AVAILABLE(4) __TVOS_AVAILABLE(11)
void SparseMultiply(SparseOpaqueSubfactor_Double Subfactor, DenseMatrix_Double XY,
  void *workspace);
static inline SPARSE_PUBLIC_INTERFACE __OSX_AVAILABLE(10.13) __IOS_AVAILABLE(11) __WATCHOS_AVAILABLE(4) __TVOS_AVAILABLE(11)
void SparseMultiply(SparseOpaqueSubfactor_Float Subfactor, DenseMatrix_Float XY,
  void *workspace);
static inline SPARSE_PUBLIC_INTERFACE __OSX_AVAILABLE(10.13) __IOS_AVAILABLE(11) __WATCHOS_AVAILABLE(4) __TVOS_AVAILABLE(11)
void SparseMultiply(SparseOpaqueSubfactor_Double Subfactor, DenseMatrix_Double X,
  DenseMatrix_Double Y, void *workspace);
static inline SPARSE_PUBLIC_INTERFACE __OSX_AVAILABLE(10.13) __IOS_AVAILABLE(11) __WATCHOS_AVAILABLE(4) __TVOS_AVAILABLE(11)
void SparseMultiply(SparseOpaqueSubfactor_Float Subfactor, DenseMatrix_Float X,
  DenseMatrix_Float Y, void *workspace);
static inline SPARSE_PUBLIC_INTERFACE
void SparseMultiply(SparseOpaqueSubfactor_Double Subfactor, DenseVector_Double xy)
__OSX_AVAILABLE(10.13) __IOS_AVAILABLE(11) __WATCHOS_AVAILABLE(4) __TVOS_AVAILABLE(11);
static inline SPARSE_PUBLIC_INTERFACE
void SparseMultiply(SparseOpaqueSubfactor_Float Subfactor, DenseVector_Float xy)
__OSX_AVAILABLE(10.13) __IOS_AVAILABLE(11) __WATCHOS_AVAILABLE(4) __TVOS_AVAILABLE(11);
static inline SPARSE_PUBLIC_INTERFACE __OSX_AVAILABLE(10.13) __IOS_AVAILABLE(11) __WATCHOS_AVAILABLE(4) __TVOS_AVAILABLE(11)
void SparseMultiply(SparseOpaqueSubfactor_Double Subfactor, DenseVector_Double x,
  DenseVector_Double y);
static inline SPARSE_PUBLIC_INTERFACE __OSX_AVAILABLE(10.13) __IOS_AVAILABLE(11) __WATCHOS_AVAILABLE(4) __TVOS_AVAILABLE(11)
void SparseMultiply(SparseOpaqueSubfactor_Float Subfactor, DenseVector_Float x,
  DenseVector_Float y);
static inline SPARSE_PUBLIC_INTERFACE __OSX_AVAILABLE(10.13) __IOS_AVAILABLE(11) __WATCHOS_AVAILABLE(4) __TVOS_AVAILABLE(11)
void SparseMultiply(SparseOpaqueSubfactor_Double Subfactor, DenseVector_Double xy,
  void *workspace);
static inline SPARSE_PUBLIC_INTERFACE __OSX_AVAILABLE(10.13) __IOS_AVAILABLE(11) __WATCHOS_AVAILABLE(4) __TVOS_AVAILABLE(11)
void SparseMultiply(SparseOpaqueSubfactor_Float Subfactor, DenseVector_Float xy,
  void *workspace);
static inline SPARSE_PUBLIC_INTERFACE __OSX_AVAILABLE(10.13) __IOS_AVAILABLE(11) __WATCHOS_AVAILABLE(4) __TVOS_AVAILABLE(11)
void SparseMultiply(SparseOpaqueSubfactor_Double Subfactor, DenseVector_Double x,
  DenseVector_Double y, void *workspace);
static inline SPARSE_PUBLIC_INTERFACE __OSX_AVAILABLE(10.13) __IOS_AVAILABLE(11) __WATCHOS_AVAILABLE(4) __TVOS_AVAILABLE(11)
void SparseMultiply(SparseOpaqueSubfactor_Float Subfactor, DenseVector_Float x,
  DenseVector_Float y, void *workspace);
OS_ENUM(SparsePreconditioner, int,
  SparsePreconditionerNone = 0,
  SparsePreconditionerUser = 1,
  SparsePreconditionerDiagonal = 2,
  SparsePreconditionerDiagScaling = 3
);
typedef struct {
  SparsePreconditioner_t type;
  void *mem;
  void (*apply) (void*, enum CBLAS_TRANSPOSE trans, DenseMatrix_Double X, DenseMatrix_Double Y);
} SparseOpaquePreconditioner_Double;
typedef struct {
  SparsePreconditioner_t type;
  void *mem;
  void (*apply) (void*, enum CBLAS_TRANSPOSE trans, DenseMatrix_Float X, DenseMatrix_Float);
} SparseOpaquePreconditioner_Float;
static inline SPARSE_PUBLIC_INTERFACE __OSX_AVAILABLE(10.13) __IOS_AVAILABLE(11) __WATCHOS_AVAILABLE(4) __TVOS_AVAILABLE(11)
SparseOpaquePreconditioner_Double SparseCreatePreconditioner(
  SparsePreconditioner_t type, SparseMatrix_Double A);
static inline SPARSE_PUBLIC_INTERFACE __OSX_AVAILABLE(10.13) __IOS_AVAILABLE(11) __WATCHOS_AVAILABLE(4) __TVOS_AVAILABLE(11)
SparseOpaquePreconditioner_Float SparseCreatePreconditioner(
  SparsePreconditioner_t type, SparseMatrix_Float A);
OS_ENUM(SparseIterativeStatus, int,
  SparseIterativeConverged = 0,
  SparseIterativeMaxIterations = 1,
  SparseIterativeParameterError = -1,
  SparseIterativeIllConditioned = -2,
  SparseIterativeInternalError = -99,
);
struct _SparseIterativeMethodBaseOptions {
  void (* _Nullable reportError)(const char *message);
};
typedef struct {
  void (* _Nullable reportError)(const char *message);
  int maxIterations;
  double atol;
  double rtol;
  void (* _Nullable reportStatus)(const char *message);
} SparseCGOptions;
OS_ENUM(SparseGMRESVariant, uint8_t,
  SparseVariantDQGMRES = 0,
  SparseVariantGMRES = 1,
  SparseVariantFGMRES = 2
);
typedef struct {
  void (* _Nullable reportError)(const char *message);
  SparseGMRESVariant_t variant;
  int nvec;
  int maxIterations;
  double atol;
  double rtol;
  void (* _Nullable reportStatus)(const char *message);
} SparseGMRESOptions;
OS_ENUM(SparseLSMRConvergenceTest, int,
  SparseLSMRCTDefault = 0,
  SparseLSMRCTFongSaunders = 1,
);
typedef struct {
  void (* _Nullable reportError)(const char *message);
  double lambda;
  int nvec;
  SparseLSMRConvergenceTest_t convergenceTest;
  double atol;
  double rtol;
  double btol;
  double conditionLimit;
  int maxIterations;
  void (* _Nullable reportStatus)(const char *message);
} SparseLSMROptions;
typedef struct {
  int method;
  union {
    struct _SparseIterativeMethodBaseOptions base;
    SparseCGOptions cg;
    SparseGMRESOptions gmres;
    SparseLSMROptions lsmr;
    char padding[256]; 
  } options;
} SparseIterativeMethod;
static inline SPARSE_PUBLIC_INTERFACE __OSX_AVAILABLE(10.13) __IOS_AVAILABLE(11) __WATCHOS_AVAILABLE(4) __TVOS_AVAILABLE(11)
SparseIterativeMethod SparseConjugateGradient(void);
static inline SPARSE_PUBLIC_INTERFACE __OSX_AVAILABLE(10.13) __IOS_AVAILABLE(11) __WATCHOS_AVAILABLE(4) __TVOS_AVAILABLE(11)
SparseIterativeMethod SparseConjugateGradient(SparseCGOptions options);
static inline SPARSE_PUBLIC_INTERFACE __OSX_AVAILABLE(10.13) __IOS_AVAILABLE(11) __WATCHOS_AVAILABLE(4) __TVOS_AVAILABLE(11)
SparseIterativeMethod SparseGMRES(void);
static inline SPARSE_PUBLIC_INTERFACE __OSX_AVAILABLE(10.13) __IOS_AVAILABLE(11) __WATCHOS_AVAILABLE(4) __TVOS_AVAILABLE(11)
SparseIterativeMethod SparseGMRES(SparseGMRESOptions options);
static inline SPARSE_PUBLIC_INTERFACE __OSX_AVAILABLE(10.13) __IOS_AVAILABLE(11) __WATCHOS_AVAILABLE(4) __TVOS_AVAILABLE(11)
SparseIterativeMethod SparseLSMR(void);
static inline SPARSE_PUBLIC_INTERFACE __OSX_AVAILABLE(10.13) __IOS_AVAILABLE(11) __WATCHOS_AVAILABLE(4) __TVOS_AVAILABLE(11)
SparseIterativeMethod SparseLSMR(SparseLSMROptions options);
static inline SPARSE_PUBLIC_INTERFACE __OSX_AVAILABLE(10.13) __IOS_AVAILABLE(11) __WATCHOS_AVAILABLE(4) __TVOS_AVAILABLE(11)
SparseIterativeStatus_t SparseSolve(SparseIterativeMethod method,
  SparseMatrix_Double A, DenseMatrix_Double B, DenseMatrix_Double X);
static inline SPARSE_PUBLIC_INTERFACE __OSX_AVAILABLE(10.13) __IOS_AVAILABLE(11) __WATCHOS_AVAILABLE(4) __TVOS_AVAILABLE(11)
SparseIterativeStatus_t SparseSolve(SparseIterativeMethod method,
  SparseMatrix_Float A, DenseMatrix_Float B, DenseMatrix_Float X);
static inline SPARSE_PUBLIC_INTERFACE __OSX_AVAILABLE(10.13) __IOS_AVAILABLE(11) __WATCHOS_AVAILABLE(4) __TVOS_AVAILABLE(11)
SparseIterativeStatus_t SparseSolve(SparseIterativeMethod method,
  SparseMatrix_Double A, DenseVector_Double b, DenseVector_Double x);
static inline SPARSE_PUBLIC_INTERFACE __OSX_AVAILABLE(10.13) __IOS_AVAILABLE(11) __WATCHOS_AVAILABLE(4) __TVOS_AVAILABLE(11)
SparseIterativeStatus_t SparseSolve(SparseIterativeMethod method,
  SparseMatrix_Float A, DenseVector_Float b, DenseVector_Float x);
static inline SPARSE_PUBLIC_INTERFACE __OSX_AVAILABLE(10.13) __IOS_AVAILABLE(11) __WATCHOS_AVAILABLE(4) __TVOS_AVAILABLE(11)
SparseIterativeStatus_t SparseSolve(SparseIterativeMethod method,
  void (^_Nonnull ApplyOperator)(bool accumulate, enum CBLAS_TRANSPOSE trans,
    DenseMatrix_Double X, DenseMatrix_Double Y),
  DenseMatrix_Double B, DenseMatrix_Double X);
static inline SPARSE_PUBLIC_INTERFACE __OSX_AVAILABLE(10.13) __IOS_AVAILABLE(11) __WATCHOS_AVAILABLE(4) __TVOS_AVAILABLE(11)
SparseIterativeStatus_t SparseSolve(SparseIterativeMethod method,
  void (^_Nonnull ApplyOperator)(bool accumulate, enum CBLAS_TRANSPOSE trans,
    DenseMatrix_Float X, DenseMatrix_Float Y),
  DenseMatrix_Float B, DenseMatrix_Float X);
static inline SPARSE_PUBLIC_INTERFACE __OSX_AVAILABLE(10.13) __IOS_AVAILABLE(11) __WATCHOS_AVAILABLE(4) __TVOS_AVAILABLE(11)
SparseIterativeStatus_t SparseSolve(SparseIterativeMethod method,
  void (^_Nonnull ApplyOperator)(bool accumulate, enum CBLAS_TRANSPOSE trans,
    DenseVector_Double x, DenseVector_Double y),
  DenseVector_Double b, DenseVector_Double x);
static inline SPARSE_PUBLIC_INTERFACE __OSX_AVAILABLE(10.13) __IOS_AVAILABLE(11) __WATCHOS_AVAILABLE(4) __TVOS_AVAILABLE(11)
SparseIterativeStatus_t SparseSolve(SparseIterativeMethod method,
  void (^_Nonnull ApplyOperator)(bool accumulate, enum CBLAS_TRANSPOSE trans,
    DenseVector_Float x, DenseVector_Float y),
  DenseVector_Float b, DenseVector_Float x);
static inline SPARSE_PUBLIC_INTERFACE __OSX_AVAILABLE(10.13) __IOS_AVAILABLE(11) __WATCHOS_AVAILABLE(4) __TVOS_AVAILABLE(11)
SparseIterativeStatus_t SparseSolve(SparseIterativeMethod method,
  SparseMatrix_Double A, DenseMatrix_Double B, DenseMatrix_Double X,
  SparsePreconditioner_t Preconditioner);
static inline SPARSE_PUBLIC_INTERFACE __OSX_AVAILABLE(10.13) __IOS_AVAILABLE(11) __WATCHOS_AVAILABLE(4) __TVOS_AVAILABLE(11)
SparseIterativeStatus_t SparseSolve(SparseIterativeMethod method,
  SparseMatrix_Float A, DenseMatrix_Float B, DenseMatrix_Float X,
  SparsePreconditioner_t Preconditioner);
static inline SPARSE_PUBLIC_INTERFACE __OSX_AVAILABLE(10.13) __IOS_AVAILABLE(11) __WATCHOS_AVAILABLE(4) __TVOS_AVAILABLE(11)
SparseIterativeStatus_t SparseSolve(SparseIterativeMethod method,
  SparseMatrix_Double A, DenseVector_Double b, DenseVector_Double x,
  SparsePreconditioner_t Preconditioner);
static inline SPARSE_PUBLIC_INTERFACE __OSX_AVAILABLE(10.13) __IOS_AVAILABLE(11) __WATCHOS_AVAILABLE(4) __TVOS_AVAILABLE(11)
SparseIterativeStatus_t SparseSolve(SparseIterativeMethod method,
  SparseMatrix_Float A, DenseVector_Float b, DenseVector_Float x,
  SparsePreconditioner_t Preconditioner);
static inline SPARSE_PUBLIC_INTERFACE __OSX_AVAILABLE(10.13) __IOS_AVAILABLE(11) __WATCHOS_AVAILABLE(4) __TVOS_AVAILABLE(11)
SparseIterativeStatus_t SparseSolve(SparseIterativeMethod method,
  SparseMatrix_Double A, DenseMatrix_Double B, DenseMatrix_Double X,
  SparseOpaquePreconditioner_Double Preconditioner);
static inline SPARSE_PUBLIC_INTERFACE __OSX_AVAILABLE(10.13) __IOS_AVAILABLE(11) __WATCHOS_AVAILABLE(4) __TVOS_AVAILABLE(11)
SparseIterativeStatus_t SparseSolve(SparseIterativeMethod method,
  SparseMatrix_Float A, DenseMatrix_Float B, DenseMatrix_Float X,
  SparseOpaquePreconditioner_Float Preconditioner);
static inline SPARSE_PUBLIC_INTERFACE __OSX_AVAILABLE(10.13) __IOS_AVAILABLE(11) __WATCHOS_AVAILABLE(4) __TVOS_AVAILABLE(11)
SparseIterativeStatus_t SparseSolve(SparseIterativeMethod method,
  SparseMatrix_Double A, DenseVector_Double b, DenseVector_Double x,
  SparseOpaquePreconditioner_Double Preconditioner);
static inline SPARSE_PUBLIC_INTERFACE __OSX_AVAILABLE(10.13) __IOS_AVAILABLE(11) __WATCHOS_AVAILABLE(4) __TVOS_AVAILABLE(11)
SparseIterativeStatus_t SparseSolve(SparseIterativeMethod method,
  SparseMatrix_Float A, DenseVector_Float b, DenseVector_Float x,
  SparseOpaquePreconditioner_Float Preconditioner);
static inline SPARSE_PUBLIC_INTERFACE __OSX_AVAILABLE(10.13) __IOS_AVAILABLE(11) __WATCHOS_AVAILABLE(4) __TVOS_AVAILABLE(11)
SparseIterativeStatus_t SparseSolve(SparseIterativeMethod method,
  void (^_Nonnull ApplyOperator)(bool accumulate, enum CBLAS_TRANSPOSE trans,
    DenseMatrix_Double X, DenseMatrix_Double Y),
  DenseMatrix_Double B, DenseMatrix_Double X,
  SparseOpaquePreconditioner_Double Preconditioner);
static inline SPARSE_PUBLIC_INTERFACE __OSX_AVAILABLE(10.13) __IOS_AVAILABLE(11) __WATCHOS_AVAILABLE(4) __TVOS_AVAILABLE(11)
SparseIterativeStatus_t SparseSolve(SparseIterativeMethod method,
  void (^_Nonnull ApplyOperator)(bool accumulate, enum CBLAS_TRANSPOSE trans,
    DenseMatrix_Float X, DenseMatrix_Float Y),
  DenseMatrix_Float B, DenseMatrix_Float X,
  SparseOpaquePreconditioner_Float Preconditioner);
static inline SPARSE_PUBLIC_INTERFACE __OSX_AVAILABLE(10.13) __IOS_AVAILABLE(11) __WATCHOS_AVAILABLE(4) __TVOS_AVAILABLE(11)
SparseIterativeStatus_t SparseSolve(SparseIterativeMethod method,
  void (^_Nonnull ApplyOperator)(bool accumulate, enum CBLAS_TRANSPOSE trans,
    DenseVector_Double x, DenseVector_Double y),
  DenseVector_Double b, DenseVector_Double x,
  SparseOpaquePreconditioner_Double Preconditioner);
static inline SPARSE_PUBLIC_INTERFACE __OSX_AVAILABLE(10.13) __IOS_AVAILABLE(11) __WATCHOS_AVAILABLE(4) __TVOS_AVAILABLE(11)
SparseIterativeStatus_t SparseSolve(SparseIterativeMethod method,
  void (^_Nonnull ApplyOperator)(bool accumulate, enum CBLAS_TRANSPOSE trans,
    DenseVector_Float x, DenseVector_Float y),
  DenseVector_Float B, DenseVector_Float X,
  SparseOpaquePreconditioner_Float Preconditioner);
static inline SPARSE_PUBLIC_INTERFACE __OSX_AVAILABLE(10.13) __IOS_AVAILABLE(11) __WATCHOS_AVAILABLE(4) __TVOS_AVAILABLE(11)
size_t SparseGetStateSize_Double(SparseIterativeMethod method,
  bool preconditioner, int m, int n, int nrhs);
static inline SPARSE_PUBLIC_INTERFACE __OSX_AVAILABLE(10.13) __IOS_AVAILABLE(11) __WATCHOS_AVAILABLE(4) __TVOS_AVAILABLE(11)
size_t SparseGetStateSize_Float(SparseIterativeMethod method,
  bool preconditioner, int m, int n, int nrhs);
static inline SPARSE_PUBLIC_INTERFACE __OSX_AVAILABLE(10.13) __IOS_AVAILABLE(11) __WATCHOS_AVAILABLE(4) __TVOS_AVAILABLE(11)
void SparseIterate(SparseIterativeMethod method, int iteration,
  const bool *converged, void *state,
  void (^_Nonnull ApplyOperator)(bool accumulate, enum CBLAS_TRANSPOSE trans,
    DenseMatrix_Double X, DenseMatrix_Double Y),
  DenseMatrix_Double B, DenseMatrix_Double R, DenseMatrix_Double X,
  SparseOpaquePreconditioner_Double Preconditioner);
static inline SPARSE_PUBLIC_INTERFACE __OSX_AVAILABLE(10.13) __IOS_AVAILABLE(11) __WATCHOS_AVAILABLE(4) __TVOS_AVAILABLE(11)
void SparseIterate(SparseIterativeMethod method, int iteration,
  const bool *converged, void *state,
  void (^_Nonnull ApplyOperator)(bool accumulate, enum CBLAS_TRANSPOSE trans, DenseMatrix_Float X, DenseMatrix_Float Y),
  DenseMatrix_Float B, DenseMatrix_Float R, DenseMatrix_Float X,
  SparseOpaquePreconditioner_Float Preconditioner);
static inline SPARSE_PUBLIC_INTERFACE __OSX_AVAILABLE(10.13) __IOS_AVAILABLE(11) __WATCHOS_AVAILABLE(4) __TVOS_AVAILABLE(11)
void SparseIterate(SparseIterativeMethod method, int iteration,
  const bool *converged, void *state,
  void (^_Nonnull ApplyOperator)(bool accumulate, enum CBLAS_TRANSPOSE trans,
    DenseMatrix_Double X, DenseMatrix_Double Y),
  DenseMatrix_Double B, DenseMatrix_Double R, DenseMatrix_Double X);
static inline SPARSE_PUBLIC_INTERFACE __OSX_AVAILABLE(10.13) __IOS_AVAILABLE(11) __WATCHOS_AVAILABLE(4) __TVOS_AVAILABLE(11)
void SparseIterate(SparseIterativeMethod method, int iteration,
  const bool *converged, void *state,
  void (^_Nonnull ApplyOperator)(bool accumulate, enum CBLAS_TRANSPOSE trans,
    DenseMatrix_Float X, DenseMatrix_Float Y),
  DenseMatrix_Float B, DenseMatrix_Float R, DenseMatrix_Float X);
static inline SPARSE_PUBLIC_INTERFACE __OSX_AVAILABLE(10.13) __IOS_AVAILABLE(11) __WATCHOS_AVAILABLE(4) __TVOS_AVAILABLE(11)
SparseOpaqueSymbolicFactorization SparseRetain(
  SparseOpaqueSymbolicFactorization SymbolicFactor);
static inline SPARSE_PUBLIC_INTERFACE __OSX_AVAILABLE(10.13) __IOS_AVAILABLE(11) __WATCHOS_AVAILABLE(4) __TVOS_AVAILABLE(11)
SparseOpaqueFactorization_Double SparseRetain(
  SparseOpaqueFactorization_Double NumericFactor);
static inline SPARSE_PUBLIC_INTERFACE __OSX_AVAILABLE(10.13) __IOS_AVAILABLE(11) __WATCHOS_AVAILABLE(4) __TVOS_AVAILABLE(11)
SparseOpaqueFactorization_Float SparseRetain(
  SparseOpaqueFactorization_Float NumericFactor);
static inline SPARSE_PUBLIC_INTERFACE __OSX_AVAILABLE(10.13) __IOS_AVAILABLE(11) __WATCHOS_AVAILABLE(4) __TVOS_AVAILABLE(11)
SparseOpaqueSubfactor_Double SparseRetain(SparseOpaqueSubfactor_Double NumericFactor);
static inline SPARSE_PUBLIC_INTERFACE __OSX_AVAILABLE(10.13) __IOS_AVAILABLE(11) __WATCHOS_AVAILABLE(4) __TVOS_AVAILABLE(11)
SparseOpaqueSubfactor_Float SparseRetain(SparseOpaqueSubfactor_Float NumericFactor);
static inline SPARSE_PUBLIC_INTERFACE
void SparseCleanup(SparseOpaqueSymbolicFactorization Opaque)
__OSX_AVAILABLE(10.13) __IOS_AVAILABLE(11) __WATCHOS_AVAILABLE(4) __TVOS_AVAILABLE(11);
static inline SPARSE_PUBLIC_INTERFACE
void SparseCleanup(SparseOpaqueFactorization_Double Opaque)
__OSX_AVAILABLE(10.13) __IOS_AVAILABLE(11) __WATCHOS_AVAILABLE(4) __TVOS_AVAILABLE(11);
static inline SPARSE_PUBLIC_INTERFACE
void SparseCleanup(SparseOpaqueFactorization_Float Opaque)
__OSX_AVAILABLE(10.13) __IOS_AVAILABLE(11) __WATCHOS_AVAILABLE(4) __TVOS_AVAILABLE(11);
static inline SPARSE_PUBLIC_INTERFACE
void SparseCleanup(SparseOpaqueSubfactor_Double Opaque)
__OSX_AVAILABLE(10.13) __IOS_AVAILABLE(11) __WATCHOS_AVAILABLE(4) __TVOS_AVAILABLE(11);
static inline SPARSE_PUBLIC_INTERFACE
void SparseCleanup(SparseOpaqueSubfactor_Float Opaque)
__OSX_AVAILABLE(10.13) __IOS_AVAILABLE(11) __WATCHOS_AVAILABLE(4) __TVOS_AVAILABLE(11);
static inline SPARSE_PUBLIC_INTERFACE
void SparseCleanup(SparseMatrix_Double Matrix)
__OSX_AVAILABLE(10.13) __IOS_AVAILABLE(11) __WATCHOS_AVAILABLE(4) __TVOS_AVAILABLE(11);
static inline SPARSE_PUBLIC_INTERFACE
void SparseCleanup(SparseMatrix_Float Matrix)
__OSX_AVAILABLE(10.13) __IOS_AVAILABLE(11) __WATCHOS_AVAILABLE(4) __TVOS_AVAILABLE(11);
static inline SPARSE_PUBLIC_INTERFACE
void SparseCleanup(SparseOpaquePreconditioner_Double Opaque)
__OSX_AVAILABLE(10.13) __IOS_AVAILABLE(11) __WATCHOS_AVAILABLE(4) __TVOS_AVAILABLE(11);
static inline SPARSE_PUBLIC_INTERFACE
void SparseCleanup(SparseOpaquePreconditioner_Float Opaque)
__OSX_AVAILABLE(10.13) __IOS_AVAILABLE(11) __WATCHOS_AVAILABLE(4) __TVOS_AVAILABLE(11);
#if __has_feature(nullability)
# pragma clang assume_nonnull end
#endif
#if   __MAC_OS_X_VERSION_MIN_REQUIRED  >= __MAC_10_13   || \
      __IPHONE_OS_VERSION_MIN_REQUIRED >= __IPHONE_11_0 || \
      __WATCH_OS_VERSION_MIN_REQUIRED  >= __WATCHOS_4_0 || \
      __TV_OS_VERSION_MIN_REQUIRED     >= __TVOS_11_0
# if defined SPARSE_INCLUDED_VIA_ACCELERATE 
#  include <vecLib/Sparse/SolveImplementation.h>
# else 
#  include "SolveImplementation.h"
# endif
#endif
#endif 
#endif 
