#ifndef _SPARSE_IMPLEMENTATION_TYPE
# error "_SPARSE_IMPLEMENTATION_TYPE must be defined prior to inclusion"
#endif 
#ifndef _SPARSE_VARIANT
# error "_SPARSE_VARIANT must be defined prior to inclusion"
#endif 
#if defined __cplusplus
extern "C" {
#endif
#if __has_feature(nullability)
#pragma clang assume_nonnull begin
#endif
__OSX_AVAILABLE(10.13) __IOS_AVAILABLE(11) __WATCHOS_AVAILABLE(4) __TVOS_AVAILABLE(11)
extern _SPARSE_VARIANT(SparseMatrix) _SPARSE_VARIANT(_SparseConvertFromCoordinate)
(int m, int n, long nBlock, uint8_t blockSize, SparseAttributes_t attributes, const int *row,
 const int *col, const _SPARSE_IMPLEMENTATION_TYPE *val, char *storage, int *workspace);
#if defined __SPARSE_TYPES_H
__OSX_AVAILABLE(10.13) __IOS_AVAILABLE(11) __WATCHOS_AVAILABLE(4) __TVOS_AVAILABLE(11)
  extern _SPARSE_VARIANT(SparseMatrix) _SPARSE_VARIANT(_SparseConvertFromOpaque)(_SPARSE_OLDSTYLE(sparse_matrix) matrix);
#endif 
__OSX_AVAILABLE(10.13) __IOS_AVAILABLE(11) __WATCHOS_AVAILABLE(4) __TVOS_AVAILABLE(11)
extern _SPARSE_VARIANT(SparseOpaqueFactorization) _SPARSE_VARIANT(_SparseNumericFactorSymmetric)
(SparseOpaqueSymbolicFactorization *symbolicFactor,
 const _SPARSE_VARIANT(SparseMatrix) *Matrix,
 const SparseNumericFactorOptions *options,
 void *factorStorage,
 void *workspace);
__OSX_AVAILABLE(10.13) __IOS_AVAILABLE(11) __WATCHOS_AVAILABLE(4) __TVOS_AVAILABLE(11)
extern _SPARSE_VARIANT(SparseOpaqueFactorization) _SPARSE_VARIANT(_SparseNumericFactorQR)
(SparseOpaqueSymbolicFactorization *symbolicFactor,
 const _SPARSE_VARIANT(SparseMatrix) *Matrix,
 const SparseNumericFactorOptions *options,
 void *factorStorage,
 void *workspace);
__OSX_AVAILABLE(10.13) __IOS_AVAILABLE(11) __WATCHOS_AVAILABLE(4) __TVOS_AVAILABLE(11)
extern _SPARSE_VARIANT(SparseOpaqueFactorization) _SPARSE_VARIANT(_SparseFactorSymmetric)
(SparseFactorization_t factorType,
 const _SPARSE_VARIANT(SparseMatrix) *Matrix,
 const SparseSymbolicFactorOptions *sfoptions,
 const SparseNumericFactorOptions *nfoptions);
__OSX_AVAILABLE(10.13) __IOS_AVAILABLE(11) __WATCHOS_AVAILABLE(4) __TVOS_AVAILABLE(11)
extern _SPARSE_VARIANT(SparseOpaqueFactorization) _SPARSE_VARIANT(_SparseFactorQR)
(SparseFactorization_t factorType,
 const _SPARSE_VARIANT(SparseMatrix) *Matrix,
 const SparseSymbolicFactorOptions *sfoptions,
 const SparseNumericFactorOptions *nfoptions);
__OSX_AVAILABLE(10.13) __IOS_AVAILABLE(11) __WATCHOS_AVAILABLE(4) __TVOS_AVAILABLE(11)
extern void _SPARSE_VARIANT(_SparseRefactorSymmetric)
(const _SPARSE_VARIANT(SparseMatrix) *Matrix,
 _SPARSE_VARIANT(SparseOpaqueFactorization) *Factorization,
 const SparseNumericFactorOptions *nfoptions,
 void *workspace);
__OSX_AVAILABLE(10.13) __IOS_AVAILABLE(11) __WATCHOS_AVAILABLE(4) __TVOS_AVAILABLE(11)
extern void _SPARSE_VARIANT(_SparseRefactorQR)
(const _SPARSE_VARIANT(SparseMatrix) *Matrix,
 _SPARSE_VARIANT(SparseOpaqueFactorization) *Factorization,
 const SparseNumericFactorOptions *nfoptions,
 void *workspace);
__OSX_AVAILABLE(10.13) __IOS_AVAILABLE(11) __WATCHOS_AVAILABLE(4) __TVOS_AVAILABLE(11)
extern void _SPARSE_VARIANT(_SparseMultiplySubfactor)
(const _SPARSE_VARIANT(SparseOpaqueSubfactor) *Subfactor,
 const _SPARSE_VARIANT(DenseMatrix) *_Nullable x,
 const _SPARSE_VARIANT(DenseMatrix) *y,
 char *workspace);
__OSX_AVAILABLE(10.13) __IOS_AVAILABLE(11) __WATCHOS_AVAILABLE(4) __TVOS_AVAILABLE(11)
extern void _SPARSE_VARIANT(_SparseSolveSubfactor)
(const _SPARSE_VARIANT(SparseOpaqueSubfactor) *Subfactor,
 const _SPARSE_VARIANT(DenseMatrix) *_Nullable b,
 const _SPARSE_VARIANT(DenseMatrix) *x,
 char *workspace);
__OSX_AVAILABLE(10.13) __IOS_AVAILABLE(11) __WATCHOS_AVAILABLE(4) __TVOS_AVAILABLE(11)
extern void _SPARSE_VARIANT(_SparseSolveOpaque)
(const _SPARSE_VARIANT(SparseOpaqueFactorization) *Factored,
 const _SPARSE_VARIANT(DenseMatrix) *_Nullable RHS,
 const _SPARSE_VARIANT(DenseMatrix) *Soln,
 void *workspace);
__OSX_AVAILABLE(10.13) __IOS_AVAILABLE(11) __WATCHOS_AVAILABLE(4) __TVOS_AVAILABLE(11)
extern void _SPARSE_VARIANT(_SparseDestroyOpaqueNumeric)(_SPARSE_VARIANT(SparseOpaqueFactorization) *toFree);
__OSX_AVAILABLE(10.13) __IOS_AVAILABLE(11) __WATCHOS_AVAILABLE(4) __TVOS_AVAILABLE(11)
extern void _SPARSE_VARIANT(_SparseRetainNumeric)
(_SPARSE_VARIANT(SparseOpaqueFactorization) *_Nonnull numericFactor);
__OSX_AVAILABLE(10.13) __IOS_AVAILABLE(11) __WATCHOS_AVAILABLE(4) __TVOS_AVAILABLE(11)
extern SparseNumericFactorOptions _SPARSE_VARIANT(_SparseGetOptionsFromNumericFactor)(_SPARSE_VARIANT(SparseOpaqueFactorization) *factor);
__OSX_AVAILABLE(10.13) __IOS_AVAILABLE(11) __WATCHOS_AVAILABLE(4) __TVOS_AVAILABLE(11)
extern void _SPARSE_VARIANT(_SparseGetWorkspaceRequired)
(SparseSubfactor_t Subfactor, _SPARSE_VARIANT(SparseOpaqueFactorization) Factor, size_t *workStatic,
 size_t *workPerRHS);
__OSX_AVAILABLE(10.13) __IOS_AVAILABLE(11) __WATCHOS_AVAILABLE(4) __TVOS_AVAILABLE(11)
extern size_t _SPARSE_VARIANT(_SparseGetIterativeStateSize)
(const SparseIterativeMethod *method, bool preconditioner, int m, int n, int nrhs);
__OSX_AVAILABLE(10.13) __IOS_AVAILABLE(11) __WATCHOS_AVAILABLE(4) __TVOS_AVAILABLE(11)
extern void _SPARSE_VARIANT(_SparseCGIterate)
(const SparseCGOptions *options,
 int iteration,
 char *state,
 const bool *converged,
 _SPARSE_VARIANT(DenseMatrix) *X,
 _SPARSE_VARIANT(DenseMatrix) *B,
 _SPARSE_VARIANT(DenseMatrix) *R,
 const _SPARSE_VARIANT(SparseOpaquePreconditioner) *_Nullable Preconditioner,
 void (^_Nonnull ApplyOperator)(bool accumulate, enum CBLAS_TRANSPOSE trans, _SPARSE_VARIANT(DenseMatrix), _SPARSE_VARIANT(DenseMatrix)));
__OSX_AVAILABLE(10.13) __IOS_AVAILABLE(11) __WATCHOS_AVAILABLE(4) __TVOS_AVAILABLE(11)
extern SparseIterativeStatus_t _SPARSE_VARIANT(_SparseCGSolve)
(const SparseCGOptions *options,
 _SPARSE_VARIANT(DenseMatrix) *X,
 _SPARSE_VARIANT(DenseMatrix) *B,
 void (^_Nonnull ApplyOperator)(bool accumulate, enum CBLAS_TRANSPOSE trans, _SPARSE_VARIANT(DenseMatrix), _SPARSE_VARIANT(DenseMatrix)),
 const _SPARSE_VARIANT(SparseOpaquePreconditioner) *_Nullable Preconditioner);
__OSX_AVAILABLE(10.13) __IOS_AVAILABLE(11) __WATCHOS_AVAILABLE(4) __TVOS_AVAILABLE(11)
extern void _SPARSE_VARIANT(_SparseGMRESIterate)
(const SparseGMRESOptions *options,
 int iteration,
 char *state,
 const bool *converged,
 _SPARSE_VARIANT(DenseMatrix) *X,
 _SPARSE_VARIANT(DenseMatrix) *B,
 _SPARSE_VARIANT(DenseMatrix) *R,
 const _SPARSE_VARIANT(SparseOpaquePreconditioner) *_Nullable Preconditioner,
 void (^_Nonnull ApplyOperator)(bool accumulate, enum CBLAS_TRANSPOSE trans, _SPARSE_VARIANT(DenseMatrix), _SPARSE_VARIANT(DenseMatrix)));
__OSX_AVAILABLE(10.13) __IOS_AVAILABLE(11) __WATCHOS_AVAILABLE(4) __TVOS_AVAILABLE(11)
extern SparseIterativeStatus_t _SPARSE_VARIANT(_SparseGMRESSolve)
(SparseGMRESOptions *options,
 _SPARSE_VARIANT(DenseMatrix) *X,
 _SPARSE_VARIANT(DenseMatrix) *B,
 void (^_Nonnull ApplyOperator)(bool accumulate, enum CBLAS_TRANSPOSE trans, _SPARSE_VARIANT(DenseMatrix), _SPARSE_VARIANT(DenseMatrix)),
 const _SPARSE_VARIANT(SparseOpaquePreconditioner) *_Nullable Preconditioner);
__OSX_AVAILABLE(10.13) __IOS_AVAILABLE(11) __WATCHOS_AVAILABLE(4) __TVOS_AVAILABLE(11)
extern void _SPARSE_VARIANT(_SparseLSMRIterate)
(const SparseLSMROptions *options,
 int iteration,
 char *state,
 const bool *converged,
 _SPARSE_VARIANT(DenseMatrix) *X,
 _SPARSE_VARIANT(DenseMatrix) *B,
 _SPARSE_VARIANT(DenseMatrix) *R,
 const _SPARSE_VARIANT(SparseOpaquePreconditioner) *_Nullable Preconditioner,
 void (^_Nonnull ApplyOperator)(bool accumulate, enum CBLAS_TRANSPOSE trans, _SPARSE_VARIANT(DenseMatrix), _SPARSE_VARIANT(DenseMatrix)));
__OSX_AVAILABLE(10.13) __IOS_AVAILABLE(11) __WATCHOS_AVAILABLE(4) __TVOS_AVAILABLE(11)
extern SparseIterativeStatus_t _SPARSE_VARIANT(_SparseLSMRSolve)
(SparseLSMROptions *options,
 _SPARSE_VARIANT(DenseMatrix) *X,
 _SPARSE_VARIANT(DenseMatrix) *B,
 void (^_Nonnull ApplyOperator)(bool accumulate, enum CBLAS_TRANSPOSE trans, _SPARSE_VARIANT(DenseMatrix), _SPARSE_VARIANT(DenseMatrix)),
 const _SPARSE_VARIANT(SparseOpaquePreconditioner) *_Nullable Preconditioner);
__OSX_AVAILABLE(10.13) __IOS_AVAILABLE(11) __WATCHOS_AVAILABLE(4) __TVOS_AVAILABLE(11)
extern _SPARSE_VARIANT(SparseOpaquePreconditioner) _SPARSE_VARIANT(_SparseCreatePreconditioner)
(SparsePreconditioner_t type,
 _SPARSE_VARIANT(SparseMatrix) *A);
__OSX_AVAILABLE(10.13) __IOS_AVAILABLE(11) __WATCHOS_AVAILABLE(4) __TVOS_AVAILABLE(11)
extern void _SPARSE_VARIANT(_SparseReleaseOpaquePreconditioner)
(_SPARSE_VARIANT(SparseOpaquePreconditioner) *toFree);
__OSX_AVAILABLE(10.13) __IOS_AVAILABLE(11) __WATCHOS_AVAILABLE(4) __TVOS_AVAILABLE(11)
extern void _SPARSE_VARIANT(_SparseSpMV)
(_SPARSE_IMPLEMENTATION_TYPE alpha,
 _SPARSE_VARIANT(SparseMatrix) A,
 _SPARSE_VARIANT(DenseMatrix) x,
 bool accumulate,
 _SPARSE_VARIANT(DenseMatrix) y);
#if __has_feature(nullability)
#pragma clang assume_nonnull end
#endif
#if defined __cplusplus
} 
#endif
static inline __attribute__((__const__))
_SPARSE_VARIANT(DenseMatrix) _SPARSE_VARIANT(_DenseMatrixFromVector)(_SPARSE_VARIANT(DenseVector) x) {
  return (_SPARSE_VARIANT(DenseMatrix)){
    .rowCount = x.count,
    .columnCount = 1,
    .columnStride = x.count,
    .data = x.data,
  };
}
static inline __attribute__((__const__))
_SPARSE_VARIANT(SparseOpaqueSubfactor) _SPARSE_VARIANT(_SparseInvalidSubfactor)() {
  return (_SPARSE_VARIANT(SparseOpaqueSubfactor)) {
    .contents = SparseSubfactorInvalid,
    .factor = {
      .symbolicFactorization = { .status = SparseInternalError },
      .status = SparseInternalError
    }
  };
}
static inline __attribute__((__const__))
_SPARSE_VARIANT(SparseOpaqueFactorization) _SPARSE_VARIANT(_SparseFailedFactor)(SparseStatus_t status) {
  return (_SPARSE_VARIANT(SparseOpaqueFactorization)) {
    .symbolicFactorization = { .status = status },
    .status = status
  };
}
static const _SPARSE_VARIANT(SparseMatrix) _SPARSE_VARIANT(_SparseNullMatrix) = {
  .structure = {
    .rowCount = -1,
    .columnCount = -1,
    .blockSize = 0,
  },
  .data = NULL
};
static inline
void _SPARSE_VARIANT(_SparseSubFactorGetDimn)(_SPARSE_VARIANT(SparseOpaqueSubfactor) Subfactor, int *_Nonnull m, int *_Nonnull n) {
  uint8_t blockSize = Subfactor.factor.symbolicFactorization.blockSize;
  *m = Subfactor.factor.symbolicFactorization.rowCount * blockSize;
  *n = Subfactor.factor.symbolicFactorization.columnCount * blockSize;
  if(*m < *n) {
    int temp = *m;
    *m = *n;
    *n = temp;
  }
  if(!(Subfactor.factor.symbolicFactorization.type == SparseFactorizationQR && Subfactor.contents == SparseSubfactorQ)) {
    *m = *n;
  }
  if(Subfactor.attributes.transpose) {
    int temp = *m;
    *m = *n;
    *n = temp;
  }
}
static inline SPARSE_PUBLIC_INTERFACE
_SPARSE_VARIANT(SparseMatrix) SparseConvertFromCoordinate(
    int rowCount, int columnCount, long blockCount, uint8_t blockSize, SparseAttributes_t attributes,
    const int *_Nonnull row, const int *_Nonnull column, const _SPARSE_IMPLEMENTATION_TYPE *_Nonnull data) {
  SparseSymbolicFactorOptions options = _SparseDefaultSymbolicFactorOptions;
  SPARSE_PARAMETER_CHECK(rowCount>=0, _SPARSE_VARIANT(_SparseNullMatrix),
                         "rowCount (%d) must be non-negative.\n", rowCount);
  SPARSE_PARAMETER_CHECK(columnCount>=0, _SPARSE_VARIANT(_SparseNullMatrix),
                         "columnCount (%d) must be non-negative.\n", columnCount);
  SPARSE_PARAMETER_CHECK(blockCount>=0, _SPARSE_VARIANT(_SparseNullMatrix),
                         "blockCount (%ld) must be non-negative.\n", blockCount);
  SPARSE_PARAMETER_CHECK(attributes.kind==SparseOrdinary || rowCount==columnCount,
                         _SPARSE_VARIANT(_SparseNullMatrix),
                         "attributes.kind must be SparseOrdinary if matrix is not square.\n");
  char *storage = (char *)malloc(28 + (columnCount+1)*sizeof(long) + blockCount*sizeof(int) +
                                 blockCount*blockSize*blockSize*sizeof(data[0]));
  SPARSE_PARAMETER_CHECK(storage, _SPARSE_VARIANT(_SparseNullMatrix),
                         "Failed to allocate storage for result.\n");
  int *workspace = (int *)malloc(rowCount*sizeof(int));
  if(!workspace) free(storage);
  SPARSE_PARAMETER_CHECK(workspace, _SPARSE_VARIANT(_SparseNullMatrix),
                         "Failed to allocate workspace of size %ld.\n", rowCount*sizeof(int));
  _SPARSE_VARIANT(SparseMatrix) result =  _SPARSE_VARIANT(_SparseConvertFromCoordinate)(rowCount, columnCount, blockCount, blockSize, attributes, row, column, data, storage, workspace);
  free(workspace);
  result.structure.attributes._allocatedBySparse = true;
  return result;
}
static inline SPARSE_PUBLIC_INTERFACE
_SPARSE_VARIANT(SparseMatrix) SparseConvertFromCoordinate(int rowCount,
    int columnCount, long blockCount, uint8_t blockSize, SparseAttributes_t attributes,
    const int *_Nonnull row, const int *_Nonnull column, const _SPARSE_IMPLEMENTATION_TYPE *_Nonnull data,
    void *_Nonnull storage, void *_Nonnull workspace) {
  SparseSymbolicFactorOptions options = _SparseDefaultSymbolicFactorOptions;
  SPARSE_PARAMETER_CHECK(rowCount>=0, _SPARSE_VARIANT(_SparseNullMatrix),
                         "rowCount (%d) must be non-negative.\n", rowCount);
  SPARSE_PARAMETER_CHECK(columnCount>=0, _SPARSE_VARIANT(_SparseNullMatrix),
                         "columnCount (%d) must be non-negative.\n", columnCount);
  SPARSE_PARAMETER_CHECK(blockCount>=0, _SPARSE_VARIANT(_SparseNullMatrix),
                         "blockCount (%ld) must be non-negative.\n", blockCount);
  SPARSE_PARAMETER_CHECK(attributes.kind==SparseOrdinary || rowCount==columnCount,
                         _SPARSE_VARIANT(_SparseNullMatrix),
                         "attributes.kind must be SparseOrdinary if matrix is not square.\n");
  return _SPARSE_VARIANT(_SparseConvertFromCoordinate)(rowCount, columnCount, blockCount, blockSize, attributes, row, column, data, (char*)storage, (int*)workspace);
}
#if defined __SPARSE_TYPES_H
static inline SPARSE_PUBLIC_INTERFACE
_SPARSE_VARIANT(SparseMatrix) SparseConvertFromOpaque(_Nonnull _SPARSE_OLDSTYLE(sparse_matrix) matrix) {
  return _SPARSE_VARIANT(_SparseConvertFromOpaque)(matrix);
}
#endif 
static inline SPARSE_PUBLIC_INTERFACE
void SparseMultiply(_SPARSE_IMPLEMENTATION_TYPE alpha, _SPARSE_VARIANT(SparseMatrix) A, _SPARSE_VARIANT(DenseMatrix) X, _SPARSE_VARIANT(DenseMatrix) Y) {
  SparseSymbolicFactorOptions options = _SparseDefaultSymbolicFactorOptions; 
  int Am = A.structure.blockSize * ((A.structure.attributes.transpose) ? A.structure.columnCount : A.structure.rowCount);
  int An = A.structure.blockSize * ((A.structure.attributes.transpose) ? A.structure.rowCount : A.structure.columnCount);
  SPARSE_CHECK_CONSISTENT_MAT_OUT_PLACE(Am, An, Y, X, , "matrix A");
  _SPARSE_VARIANT(_SparseSpMV)(alpha, A, X, false, Y);
}
static inline SPARSE_PUBLIC_INTERFACE
void SparseMultiply(_SPARSE_IMPLEMENTATION_TYPE alpha, _SPARSE_VARIANT(SparseMatrix) A, _SPARSE_VARIANT(DenseVector) x, _SPARSE_VARIANT(DenseVector) y) {
  SparseSymbolicFactorOptions options = _SparseDefaultSymbolicFactorOptions; 
  int m = A.structure.blockSize * ((A.structure.attributes.transpose) ? A.structure.columnCount : A.structure.rowCount);
  int n = A.structure.blockSize * ((A.structure.attributes.transpose) ? A.structure.rowCount : A.structure.columnCount);
  SPARSE_PARAMETER_CHECK(n == x.count, ,
                         "Matix dimensions (%dx%d) do not match x vector dimensions %dx%d\n",
                         m, n, x.count, 1);
  SPARSE_PARAMETER_CHECK(m == y.count, ,
                         "Matix dimensions (%dx%d) do not match y vector dimensions %dx%d\n",
                         m, n, y.count, 1);
  _SPARSE_VARIANT(_SparseSpMV)(alpha, A, _SPARSE_VARIANT(_DenseMatrixFromVector)(x),
                               false, _SPARSE_VARIANT(_DenseMatrixFromVector)(y));
}
static inline SPARSE_PUBLIC_INTERFACE
void SparseMultiply(_SPARSE_VARIANT(SparseMatrix) A, _SPARSE_VARIANT(DenseMatrix) X, _SPARSE_VARIANT(DenseMatrix) Y) {
  SparseMultiply(1, A, X, Y);
}
static inline SPARSE_PUBLIC_INTERFACE
void SparseMultiply(_SPARSE_VARIANT(SparseMatrix) A, _SPARSE_VARIANT(DenseVector) x, _SPARSE_VARIANT(DenseVector) y) {
  SparseMultiply(1, A, x, y);
}
static inline SPARSE_PUBLIC_INTERFACE
void SparseMultiplyAdd(_SPARSE_VARIANT(SparseMatrix) A, _SPARSE_VARIANT(DenseMatrix) X, _SPARSE_VARIANT(DenseMatrix) Y) {
  SparseMultiplyAdd(1, A, X, Y);
}
static inline SPARSE_PUBLIC_INTERFACE
void SparseMultiplyAdd(_SPARSE_IMPLEMENTATION_TYPE alpha, _SPARSE_VARIANT(SparseMatrix) A, _SPARSE_VARIANT(DenseMatrix) X, _SPARSE_VARIANT(DenseMatrix) Y) {
  SparseSymbolicFactorOptions options = _SparseDefaultSymbolicFactorOptions; 
  int Am = A.structure.blockSize * ((A.structure.attributes.transpose) ? A.structure.columnCount : A.structure.rowCount);
  int An = A.structure.blockSize * ((A.structure.attributes.transpose) ? A.structure.rowCount : A.structure.columnCount);
  SPARSE_CHECK_CONSISTENT_MAT_OUT_PLACE(Am, An, Y, X, , "matrix A");
  _SPARSE_VARIANT(_SparseSpMV)(alpha, A, X, true, Y);
}
static inline SPARSE_PUBLIC_INTERFACE
void SparseMultiplyAdd(_SPARSE_VARIANT(SparseMatrix) A, _SPARSE_VARIANT(DenseVector) x, _SPARSE_VARIANT(DenseVector) y) {
  SparseMultiplyAdd(1, A, x, y);
}
static inline SPARSE_PUBLIC_INTERFACE
void SparseMultiplyAdd(_SPARSE_IMPLEMENTATION_TYPE alpha, _SPARSE_VARIANT(SparseMatrix) A, _SPARSE_VARIANT(DenseVector) x, _SPARSE_VARIANT(DenseVector) y) {
  SparseSymbolicFactorOptions options = _SparseDefaultSymbolicFactorOptions; 
  int m = A.structure.blockSize * ((A.structure.attributes.transpose) ? A.structure.columnCount : A.structure.rowCount);
  int n = A.structure.blockSize * ((A.structure.attributes.transpose) ? A.structure.rowCount : A.structure.columnCount);
  SPARSE_PARAMETER_CHECK(n == x.count, ,
                         "Matix dimensions (%dx%d) do not match x vector dimensions %dx%d\n",
                         m, n, x.count, 1);
  SPARSE_PARAMETER_CHECK(m == y.count, ,
                         "Matix dimensions (%dx%d) do not match y vector dimensions %dx%d\n",
                         m, n, y.count, 1);
  _SPARSE_VARIANT(_SparseSpMV)(alpha, A, _SPARSE_VARIANT(_DenseMatrixFromVector)(x),
                               true, _SPARSE_VARIANT(_DenseMatrixFromVector)(y));
}
static inline SPARSE_PUBLIC_INTERFACE _SPARSE_VARIANT(SparseMatrix) SparseGetTranspose(_SPARSE_VARIANT(SparseMatrix) Matrix) {
  Matrix.structure.attributes.transpose = !Matrix.structure.attributes.transpose;
  return Matrix;
}
static inline SPARSE_PUBLIC_INTERFACE _SPARSE_VARIANT(SparseOpaqueFactorization) SparseGetTranspose(_SPARSE_VARIANT(SparseOpaqueFactorization) Factor) {
  Factor.attributes.transpose = !Factor.attributes.transpose;
  _SPARSE_VARIANT(_SparseRetainNumeric)(&Factor); 
  return Factor;
}
static inline SPARSE_PUBLIC_INTERFACE _SPARSE_VARIANT(SparseOpaqueSubfactor) SparseGetTranspose(_SPARSE_VARIANT(SparseOpaqueSubfactor) Subfactor) {
  Subfactor.attributes.transpose = !Subfactor.attributes.transpose;
  _SPARSE_VARIANT(_SparseRetainNumeric)(&Subfactor.factor); 
  return Subfactor;
}
static inline SPARSE_PUBLIC_INTERFACE
_SPARSE_VARIANT(SparseOpaqueFactorization) SparseFactor(SparseFactorization_t type,
    _SPARSE_VARIANT(SparseMatrix) Matrix) {
  return SparseFactor(type, Matrix, _SparseDefaultSymbolicFactorOptions,
                      _SPARSE_VARIANT(_SparseDefaultNumericFactorOptions));
}
static inline SPARSE_PUBLIC_INTERFACE
_SPARSE_VARIANT(SparseOpaqueFactorization) SparseFactor(SparseFactorization_t type,
    _SPARSE_VARIANT(SparseMatrix) Matrix, SparseSymbolicFactorOptions options,
    SparseNumericFactorOptions nfoptions) {
  SPARSE_CHECK_VALID_MATRIX_STRUCTURE(Matrix.structure, _SPARSE_VARIANT(_SparseFailedFactor)(SparseParameterError));
  switch(type) {
    case SparseFactorizationCholeskyAtA:
    case SparseFactorizationQR:
      return _SPARSE_VARIANT(_SparseFactorQR)(type, &Matrix, &options, &nfoptions);
    default:
      SPARSE_PARAMETER_CHECK(Matrix.structure.attributes.kind == SparseSymmetric,
                             _SPARSE_VARIANT(_SparseFailedFactor)(SparseParameterError),
                             "Cannot perform symmetric matrix factorization of non-square matrix.\n");
      return _SPARSE_VARIANT(_SparseFactorSymmetric)(type, &Matrix, &options, &nfoptions);
  }
}
static inline SPARSE_PUBLIC_INTERFACE
_SPARSE_VARIANT(SparseOpaqueFactorization) SparseFactor(SparseOpaqueSymbolicFactorization SymbolicFactor,
    _SPARSE_VARIANT(SparseMatrix) Matrix) {
  return SparseFactor(SymbolicFactor, Matrix, _SPARSE_VARIANT(_SparseDefaultNumericFactorOptions), NULL, NULL);
}
static inline SPARSE_PUBLIC_INTERFACE
_SPARSE_VARIANT(SparseOpaqueFactorization) SparseFactor(SparseOpaqueSymbolicFactorization SymbolicFactor,
    _SPARSE_VARIANT(SparseMatrix) Matrix, SparseNumericFactorOptions nfoptions) {
  return SparseFactor(SymbolicFactor, Matrix, nfoptions, NULL, NULL);
}
static inline SPARSE_PUBLIC_INTERFACE
_SPARSE_VARIANT(SparseOpaqueFactorization) SparseFactor(SparseOpaqueSymbolicFactorization symbolicFactor,
    _SPARSE_VARIANT(SparseMatrix) Matrix, SparseNumericFactorOptions nfoptions,
    void *_Nullable factorStorage, void *_Nullable workspace) {
  SparseSymbolicFactorOptions options = _SparseDefaultSymbolicFactorOptions;
  SPARSE_CHECK_VALID_SYMBOLIC_FACTOR(symbolicFactor,
                                     _SPARSE_VARIANT(_SparseFailedFactor)(SparseParameterError),
                                     "Bad symbolic factor.\n");
  options = _SparseGetOptionsFromSymbolicFactor(&symbolicFactor);
  SPARSE_CHECK_MATCH_SYMB_FACTOR(Matrix, symbolicFactor,
                                 _SPARSE_VARIANT(_SparseFailedFactor)(SparseParameterError));
  bool userFactorStorage = (factorStorage != NULL);
  bool userWorkspace     = (workspace != NULL);
  if(!userFactorStorage) {
    factorStorage = options.malloc(_SPARSE_VARIANT(symbolicFactor.factorSize));
    SPARSE_PARAMETER_CHECK(factorStorage != NULL,
                           _SPARSE_VARIANT(_SparseFailedFactor)(SparseInternalError),
                           "Failed to allocate factor storage of size %ld bytes.",
                           _SPARSE_VARIANT(symbolicFactor.factorSize));
  }
  if(!userWorkspace) {
    workspace = options.malloc(_SPARSE_VARIANT(symbolicFactor.workspaceSize));
    if(!workspace && !userFactorStorage) options.free(factorStorage);
    SPARSE_PARAMETER_CHECK(workspace != NULL,
                           _SPARSE_VARIANT(_SparseFailedFactor)(SparseInternalError),
                           "Failed to allocate workspace of size %ld bytes.",
                           _SPARSE_VARIANT(symbolicFactor.workspaceSize));
  }
  _SPARSE_VARIANT(SparseOpaqueFactorization) result;
  switch(symbolicFactor.type) {
    case SparseFactorizationCholeskyAtA:
    case SparseFactorizationQR:
      result = _SPARSE_VARIANT(_SparseNumericFactorQR)(&symbolicFactor, &Matrix, &nfoptions, factorStorage, workspace);
      break;
    default:
      result = _SPARSE_VARIANT(_SparseNumericFactorSymmetric)(&symbolicFactor, &Matrix, &nfoptions, factorStorage, workspace);
  }
  result.userFactorStorage = userFactorStorage; 
  if(!userWorkspace) options.free(workspace); 
  if(result.status < 0 && !userFactorStorage) options.free(factorStorage); 
  return result;
}
static inline SPARSE_PUBLIC_INTERFACE
void SparseSolve(_SPARSE_VARIANT(SparseOpaqueFactorization) Factored, _SPARSE_VARIANT(DenseMatrix) XB) {
  SparseSymbolicFactorOptions options = _SparseDefaultSymbolicFactorOptions; 
  SPARSE_CHECK_VALID_SYMBOLIC_FACTOR(Factored.symbolicFactorization, ,
                                    "Factored does not hold a completed matrix factorization.\n");
  options = _SparseGetOptionsFromSymbolicFactor(&Factored.symbolicFactorization);
  SPARSE_CHECK_VALID_NUMERIC_FACTOR(Factored, );
  SPARSE_CHECK_CONSISTENT_DS_MAT_IN_PLACE(Factored, XB, );
  int nrhs = (XB.attributes.transpose) ? XB.rowCount : XB.columnCount; 
  size_t lworkspace = Factored.solveWorkspaceRequiredStatic + nrhs*Factored.solveWorkspaceRequiredPerRHS;
  void *workspace = options.malloc(lworkspace);
  SPARSE_PARAMETER_CHECK(workspace, , "Failed to allocate workspace of size %ld for SparseSolve().\n", lworkspace);
  _SPARSE_VARIANT(_SparseSolveOpaque)(&Factored, NULL, &XB, workspace);
  options.free(workspace);
}
static inline SPARSE_PUBLIC_INTERFACE
void SparseSolve(_SPARSE_VARIANT(SparseOpaqueFactorization) Factored, _SPARSE_VARIANT(DenseMatrix) B, _SPARSE_VARIANT(DenseMatrix) X) {
  SparseSymbolicFactorOptions options = _SparseDefaultSymbolicFactorOptions; 
  SPARSE_CHECK_VALID_SYMBOLIC_FACTOR(Factored.symbolicFactorization, ,
                                     "Factored does not hold a completed matrix factorization.\n");
  options = _SparseGetOptionsFromSymbolicFactor(&Factored.symbolicFactorization);
  SPARSE_CHECK_VALID_NUMERIC_FACTOR(Factored, );
  SPARSE_CHECK_CONSISTENT_DS_MAT_OUT_PLACE(Factored, B, X, );
  int nrhs = (B.attributes.transpose) ? B.rowCount : B.columnCount; 
  size_t lworkspace = Factored.solveWorkspaceRequiredStatic + nrhs*Factored.solveWorkspaceRequiredPerRHS;
  void *workspace = options.malloc(lworkspace);
  SPARSE_PARAMETER_CHECK(workspace, ,
                         "Failed to allocate workspace of size %ld for SparseSolve().\n",
                         lworkspace);
  _SPARSE_VARIANT(_SparseSolveOpaque)(&Factored, &B, &X, workspace);
  options.free(workspace);
}
static inline SPARSE_PUBLIC_INTERFACE
void SparseSolve(_SPARSE_VARIANT(SparseOpaqueFactorization) Factored, _SPARSE_VARIANT(DenseMatrix) XB, void *_Nonnull workspace) {
  SparseSymbolicFactorOptions options = _SparseDefaultSymbolicFactorOptions; 
  SPARSE_CHECK_VALID_SYMBOLIC_FACTOR(Factored.symbolicFactorization, ,
                                     "Factored does not hold a completed matrix factorization.\n");
  options = _SparseGetOptionsFromSymbolicFactor(&Factored.symbolicFactorization);
  SPARSE_CHECK_VALID_NUMERIC_FACTOR(Factored, );
  SPARSE_CHECK_CONSISTENT_DS_MAT_IN_PLACE(Factored, XB, );
  _SPARSE_VARIANT(_SparseSolveOpaque)(&Factored, NULL, &XB, workspace);
}
static inline SPARSE_PUBLIC_INTERFACE
void SparseSolve(_SPARSE_VARIANT(SparseOpaqueFactorization) Factored, _SPARSE_VARIANT(DenseMatrix) B, _SPARSE_VARIANT(DenseMatrix) X, void *_Nonnull workspace) {
  SparseSymbolicFactorOptions options = _SparseDefaultSymbolicFactorOptions; 
  SPARSE_CHECK_VALID_SYMBOLIC_FACTOR(Factored.symbolicFactorization, ,
                                     "Factored does not hold a completed matrix factorization.\n");
  options = _SparseGetOptionsFromSymbolicFactor(&Factored.symbolicFactorization);
  SPARSE_CHECK_VALID_NUMERIC_FACTOR(Factored, );
  SPARSE_CHECK_CONSISTENT_DS_MAT_OUT_PLACE(Factored, B, X, );
  _SPARSE_VARIANT(_SparseSolveOpaque)(&Factored, &B, &X, workspace);
}
static inline SPARSE_PUBLIC_INTERFACE
void SparseSolve(_SPARSE_VARIANT(SparseOpaqueFactorization) Factored, _SPARSE_VARIANT(DenseVector) xb) {
  SparseSymbolicFactorOptions options = _SparseDefaultSymbolicFactorOptions; 
  SPARSE_CHECK_VALID_SYMBOLIC_FACTOR(Factored.symbolicFactorization, ,
                                     "Factored does not hold a completed matrix factorization.\n");
  options = _SparseGetOptionsFromSymbolicFactor(&Factored.symbolicFactorization);
  SPARSE_CHECK_VALID_NUMERIC_FACTOR(Factored, );
  SPARSE_CHECK_CONSISTENT_DS_VEC_IN_PLACE(Factored, xb, );
  _SPARSE_VARIANT(DenseMatrix) XB = _SPARSE_VARIANT(_DenseMatrixFromVector)(xb);
  size_t lworkspace = Factored.solveWorkspaceRequiredStatic + 1*Factored.solveWorkspaceRequiredPerRHS;
  void *workspace = options.malloc(lworkspace);
  SPARSE_PARAMETER_CHECK(workspace, , "Failed to allocate workspace of size %ld for SparseSolve().\n", lworkspace);
  _SPARSE_VARIANT(_SparseSolveOpaque)(&Factored, NULL, &XB, workspace);
  options.free(workspace);
}
static inline SPARSE_PUBLIC_INTERFACE
void SparseSolve(_SPARSE_VARIANT(SparseOpaqueFactorization) Factored, _SPARSE_VARIANT(DenseVector) b, _SPARSE_VARIANT(DenseVector) x) {
  SparseSymbolicFactorOptions options = _SparseDefaultSymbolicFactorOptions; 
  SPARSE_CHECK_VALID_SYMBOLIC_FACTOR(Factored.symbolicFactorization, ,
                                     "Factored does not hold a completed matrix factorization.\n");
  options = _SparseGetOptionsFromSymbolicFactor(&Factored.symbolicFactorization);
  SPARSE_CHECK_VALID_NUMERIC_FACTOR(Factored, );
  SPARSE_CHECK_CONSISTENT_DS_VEC_OUT_PLACE(Factored, b, x, );
  _SPARSE_VARIANT(DenseMatrix) B = _SPARSE_VARIANT(_DenseMatrixFromVector)(b);
  _SPARSE_VARIANT(DenseMatrix) X = _SPARSE_VARIANT(_DenseMatrixFromVector)(x);
  size_t lworkspace = Factored.solveWorkspaceRequiredStatic + 1*Factored.solveWorkspaceRequiredPerRHS;
  void *workspace = options.malloc(lworkspace);
  SPARSE_PARAMETER_CHECK(workspace, ,
                         "Failed to allocate workspace of size %ld for SparseSolve().\n",
                         lworkspace);
  _SPARSE_VARIANT(_SparseSolveOpaque)(&Factored, &B, &X, workspace);
  options.free(workspace);
}
static inline SPARSE_PUBLIC_INTERFACE
void SparseSolve(_SPARSE_VARIANT(SparseOpaqueFactorization) Factored, _SPARSE_VARIANT(DenseVector) xb, void *_Nonnull workspace) {
  SparseSymbolicFactorOptions options = _SparseDefaultSymbolicFactorOptions; 
  SPARSE_CHECK_VALID_SYMBOLIC_FACTOR(Factored.symbolicFactorization, ,
                                     "Factored does not hold a completed matrix factorization.\n");
  options = _SparseGetOptionsFromSymbolicFactor(&Factored.symbolicFactorization);
  SPARSE_CHECK_VALID_NUMERIC_FACTOR(Factored, );
  SPARSE_CHECK_CONSISTENT_DS_VEC_IN_PLACE(Factored, xb, );
  _SPARSE_VARIANT(DenseMatrix) XB = _SPARSE_VARIANT(_DenseMatrixFromVector)(xb);
  _SPARSE_VARIANT(_SparseSolveOpaque)(&Factored, NULL, &XB, workspace);
}
static inline SPARSE_PUBLIC_INTERFACE
void SparseSolve(_SPARSE_VARIANT(SparseOpaqueFactorization) Factored, _SPARSE_VARIANT(DenseVector) b, _SPARSE_VARIANT(DenseVector) x, void *_Nonnull workspace) {
  SparseSymbolicFactorOptions options = _SparseDefaultSymbolicFactorOptions; 
  SPARSE_CHECK_VALID_SYMBOLIC_FACTOR(Factored.symbolicFactorization, ,
                                     "Factored does not hold a completed matrix factorization.\n");
  options = _SparseGetOptionsFromSymbolicFactor(&Factored.symbolicFactorization);
  SPARSE_CHECK_VALID_NUMERIC_FACTOR(Factored, );
  SPARSE_CHECK_CONSISTENT_DS_VEC_OUT_PLACE(Factored, b, x, );
  _SPARSE_VARIANT(DenseMatrix) B = _SPARSE_VARIANT(_DenseMatrixFromVector)(b);
  _SPARSE_VARIANT(DenseMatrix) X = _SPARSE_VARIANT(_DenseMatrixFromVector)(x);
  _SPARSE_VARIANT(_SparseSolveOpaque)(&Factored, &B, &X, workspace);
}
static inline SPARSE_PUBLIC_INTERFACE
void SparseRefactor(_SPARSE_VARIANT(SparseMatrix) Matrix, _SPARSE_VARIANT(SparseOpaqueFactorization) *_Nonnull Factorization) {
  SparseSymbolicFactorOptions options = _SparseDefaultSymbolicFactorOptions; 
  SPARSE_CHECK_VALID_SYMBOLIC_FACTOR(Factorization->symbolicFactorization,
                                     ,
                                     "Factorization does not hold a completed matrix factorization.\n");
  SparseNumericFactorOptions nfoptions = _SPARSE_VARIANT(_SparseGetOptionsFromNumericFactor)(Factorization);
  SparseRefactor(Matrix, Factorization, nfoptions);
}
static inline SPARSE_PUBLIC_INTERFACE
void SparseRefactor(_SPARSE_VARIANT(SparseMatrix) Matrix, _SPARSE_VARIANT(SparseOpaqueFactorization) *_Nonnull Factorization, SparseNumericFactorOptions nfoptions) {
  SparseSymbolicFactorOptions options = _SparseDefaultSymbolicFactorOptions; 
  SPARSE_CHECK_VALID_SYMBOLIC_FACTOR(Factorization->symbolicFactorization,
                                     ,
                                     "Factorization does not hold a valid symbolic matrix factorization.\n");
  options = _SparseGetOptionsFromSymbolicFactor(&Factorization->symbolicFactorization);
  void *workspace = options.malloc(_SPARSE_VARIANT(Factorization->symbolicFactorization.workspaceSize));
  if(!workspace) Factorization->status = SparseInternalError;
  SPARSE_PARAMETER_CHECK(workspace,
                         ,
                         "Failed to allocate workspace of size %ld.",
                         _SPARSE_VARIANT(Factorization->symbolicFactorization.workspaceSize));
  SparseRefactor(Matrix, Factorization, nfoptions, workspace);
  options.free(workspace);
}
static inline SPARSE_PUBLIC_INTERFACE
void SparseRefactor(_SPARSE_VARIANT(SparseMatrix) Matrix, _SPARSE_VARIANT(SparseOpaqueFactorization) *_Nonnull Factored, void *_Nonnull workspace) {
  SparseSymbolicFactorOptions options = _SparseDefaultSymbolicFactorOptions; 
  SPARSE_CHECK_VALID_SYMBOLIC_FACTOR(Factored->symbolicFactorization,
                                     ,
                                     "Factored does not hold a completed matrix factorization.\n");
  SparseNumericFactorOptions nfoptions = _SPARSE_VARIANT(_SparseGetOptionsFromNumericFactor)(Factored);
  return SparseRefactor(Matrix, Factored, nfoptions, workspace);
}
static inline SPARSE_PUBLIC_INTERFACE
void SparseRefactor(_SPARSE_VARIANT(SparseMatrix) Matrix, _SPARSE_VARIANT(SparseOpaqueFactorization) *_Nonnull Factored, SparseNumericFactorOptions nfoptions, void *_Nonnull workspace) {
  SparseSymbolicFactorOptions options = _SparseDefaultSymbolicFactorOptions; 
  SPARSE_CHECK_MATCH_SYMB_FACTOR(Matrix, Factored->symbolicFactorization, );
  switch(Factored->symbolicFactorization.type) {
    case SparseFactorizationCholeskyAtA:
    case SparseFactorizationQR:
      _SPARSE_VARIANT(_SparseRefactorQR)(&Matrix, Factored, &nfoptions, workspace);
      break;
    default:
      _SPARSE_VARIANT(_SparseRefactorSymmetric)(&Matrix, Factored, &nfoptions, workspace);
  }
}
static inline SPARSE_PUBLIC_INTERFACE
_SPARSE_VARIANT(SparseOpaqueSubfactor) SparseCreateSubfactor(SparseSubfactor_t subfactor,
                                                        _SPARSE_VARIANT(SparseOpaqueFactorization) Factor) {
  SparseSymbolicFactorOptions options = _SparseDefaultSymbolicFactorOptions; 
  SPARSE_PARAMETER_CHECK(Factor.symbolicFactorization.status == SparseStatusOK &&
                         Factor.symbolicFactorization.factorization &&
                         Factor.status == SparseStatusOK &&
                         Factor.numericFactorization,
                         _SPARSE_VARIANT(_SparseInvalidSubfactor)(),
                         "Bad factor.\n");
  options = _SparseGetOptionsFromSymbolicFactor(&Factor.symbolicFactorization);
  SparseAttributes_t attributes = {
    .kind = SparseOrdinary,
    .transpose = false,
    .triangle = SparseLowerTriangle
  };
  SparseFactorization_t type = Factor.symbolicFactorization.type;
  switch(subfactor) {
    case SparseSubfactorP:
      break; 
    case SparseSubfactorL:
    case SparseSubfactorPLPS:
      attributes.kind = (subfactor==SparseSubfactorPLPS) ? SparseOrdinary : SparseTriangular;
      SPARSE_PARAMETER_CHECK(type == SparseFactorizationCholesky ||
                             type == SparseFactorizationLDLTUnpivoted ||
                             type == SparseFactorizationLDLTSBK ||
                             type == SparseFactorizationLDLTTPP,
                             _SPARSE_VARIANT(_SparseInvalidSubfactor)(),
                             "Subfactor Type only valid for Cholesky and LDL^T factorizations.\n");
      break;
    case SparseSubfactorS:
    case SparseSubfactorD:
      SPARSE_PARAMETER_CHECK(type == SparseFactorizationLDLTUnpivoted ||
                             type == SparseFactorizationLDLTSBK ||
                             type == SparseFactorizationLDLTTPP,
                             _SPARSE_VARIANT(_SparseInvalidSubfactor)(),
                             "Subfactor Type only valid for LDL^T factorizations.\n");
      break;
    case SparseSubfactorQ:
      SPARSE_PARAMETER_CHECK(type == SparseFactorizationQR,
                             _SPARSE_VARIANT(_SparseInvalidSubfactor)(),
                             "SparseSubfactorQ only valid for QR factorizations.\n");
      break;
    case SparseSubfactorR:
    case SparseSubfactorRP:
      attributes.kind = SparseTriangular;
      attributes.triangle = SparseUpperTriangle;
      SPARSE_PARAMETER_CHECK(type == SparseFactorizationQR ||
                             type == SparseFactorizationCholeskyAtA,
                             _SPARSE_VARIANT(_SparseInvalidSubfactor)(),
                             "Subfactor Type only valid for QR and CholeskyAtA factorizations.\n");
      break;
    default:
      SPARSE_PARAMETER_CHECK(false, _SPARSE_VARIANT(_SparseInvalidSubfactor)(), "Invalid subfactor type.");
  }
  _SPARSE_VARIANT(_SparseRetainNumeric)(&Factor); 
  size_t workspaceRequiredStatic, workspaceRequiredPerRHS;
  _SPARSE_VARIANT(_SparseGetWorkspaceRequired)(subfactor, Factor, &workspaceRequiredStatic, &workspaceRequiredPerRHS);
  return (_SPARSE_VARIANT(SparseOpaqueSubfactor)) {
    .attributes = attributes,
    .contents = subfactor,
    .factor = Factor,
    .workspaceRequiredStatic = workspaceRequiredStatic,
    .workspaceRequiredPerRHS = workspaceRequiredPerRHS
  };
}
static inline SPARSE_PUBLIC_INTERFACE
void SparseSolve(_SPARSE_VARIANT(SparseOpaqueSubfactor) Subfactor, _SPARSE_VARIANT(DenseMatrix) XB) {
  SparseSymbolicFactorOptions options = _SparseDefaultSymbolicFactorOptions; 
  SPARSE_PARAMETER_CHECK(Subfactor.contents != SparseSubfactorInvalid, ,
                         "Subfactor does not hold a valid factorization.\n");
  options = _SparseGetOptionsFromSymbolicFactor(&Subfactor.factor.symbolicFactorization);
  int m, n;
  _SPARSE_VARIANT(_SparseSubFactorGetDimn)(Subfactor, &m, &n);
  int XBCount = (XB.attributes.transpose) ? XB.rowCount : XB.columnCount;
  int XBsize  = (XB.attributes.transpose) ? XB.columnCount : XB.rowCount;
  SPARSE_PARAMETER_CHECK(XBCount > 0, , "XB must have non-zero dimension.\n");
  int maxmn = (m > n) ? m : n;
  SPARSE_PARAMETER_CHECK(XBsize == maxmn, ,
                         "XB dimension (%d) must match maximum subfactor dimension (%d).\n",
                         XBsize, maxmn);
  size_t lworkspace = Subfactor.workspaceRequiredStatic + XBCount*Subfactor.workspaceRequiredPerRHS;
  void *workspace = options.malloc(lworkspace);
  SPARSE_PARAMETER_CHECK(workspace, ,
                         "Failed to allocate workspace of size %ld.\n", lworkspace);
  _SPARSE_VARIANT(_SparseSolveSubfactor)(&Subfactor, NULL, &XB, (char*)workspace);
  options.free(workspace);
}
static inline SPARSE_PUBLIC_INTERFACE
void SparseSolve(_SPARSE_VARIANT(SparseOpaqueSubfactor) Subfactor, _SPARSE_VARIANT(DenseMatrix) B, _SPARSE_VARIANT(DenseMatrix) X) {
  SparseSymbolicFactorOptions options = _SparseDefaultSymbolicFactorOptions; 
  SPARSE_PARAMETER_CHECK(Subfactor.contents != SparseSubfactorInvalid, ,
                         "Subfactor does not hold a valid factorization.\n");
  options = _SparseGetOptionsFromSymbolicFactor(&Subfactor.factor.symbolicFactorization);
  int m, n;
  _SPARSE_VARIANT(_SparseSubFactorGetDimn)(Subfactor, &m, &n);
  SPARSE_CHECK_CONSISTENT_MAT_OUT_PLACE(m, n, B, X, , "subfactor dimension");
  int nrhs = (X.attributes.transpose) ? X.rowCount : X.columnCount;
  size_t lworkspace = Subfactor.workspaceRequiredStatic + nrhs*Subfactor.workspaceRequiredPerRHS;
  void *workspace = options.malloc(lworkspace);
  SPARSE_PARAMETER_CHECK(workspace, ,
                         "Failed to allocate workspace of size %ld.\n",
                         lworkspace);
  _SPARSE_VARIANT(_SparseSolveSubfactor)(&Subfactor, &B, &X, (char*)workspace);
  options.free(workspace);
}
static inline SPARSE_PUBLIC_INTERFACE
void SparseSolve(_SPARSE_VARIANT(SparseOpaqueSubfactor) Subfactor, _SPARSE_VARIANT(DenseMatrix) XB, void *_Nonnull workspace) {
  SparseSymbolicFactorOptions options = _SparseDefaultSymbolicFactorOptions; 
  SPARSE_PARAMETER_CHECK(Subfactor.contents != SparseSubfactorInvalid, ,
                         "Subfactor does not hold a valid factor subobject.\n");
  options = _SparseGetOptionsFromSymbolicFactor(&Subfactor.factor.symbolicFactorization);
  int m, n;
  _SPARSE_VARIANT(_SparseSubFactorGetDimn)(Subfactor, &m, &n);
  int XBCount = (XB.attributes.transpose) ? XB.rowCount : XB.columnCount;
  int XBsize  = (XB.attributes.transpose) ? XB.columnCount : XB.rowCount;
  SPARSE_PARAMETER_CHECK(XBCount > 0, , "XB must have non-zero dimension.\n");
  int maxmn = (m > n) ? m : n;
  SPARSE_PARAMETER_CHECK(XBsize == maxmn, ,
                         "XB dimension (%d) must match maximum subfactor dimension (%d).\n",
                         XBsize, maxmn);
  _SPARSE_VARIANT(_SparseSolveSubfactor)(&Subfactor, NULL, &XB, (char*)workspace);
}
static inline SPARSE_PUBLIC_INTERFACE
void SparseSolve(_SPARSE_VARIANT(SparseOpaqueSubfactor) Subfactor, _SPARSE_VARIANT(DenseMatrix) B, _SPARSE_VARIANT(DenseMatrix) X,
                 void *_Nonnull workspace) {
  SparseSymbolicFactorOptions options = _SparseDefaultSymbolicFactorOptions; 
  SPARSE_PARAMETER_CHECK(Subfactor.contents != SparseSubfactorInvalid, ,
                         "Subfactor does not hold a valid factor subobject.\n");
  options = _SparseGetOptionsFromSymbolicFactor(&Subfactor.factor.symbolicFactorization);
  int m, n;
  _SPARSE_VARIANT(_SparseSubFactorGetDimn)(Subfactor, &m, &n);
  SPARSE_CHECK_CONSISTENT_MAT_OUT_PLACE(m, n, B, X, , "subfactor dimension");
  _SPARSE_VARIANT(_SparseSolveSubfactor)(&Subfactor, &B, &X, (char*)workspace);
}
static inline SPARSE_PUBLIC_INTERFACE
void SparseSolve(_SPARSE_VARIANT(SparseOpaqueSubfactor) Subfactor, _SPARSE_VARIANT(DenseVector) XB) {
  _SPARSE_VARIANT(DenseMatrix) XBMatrix = _SPARSE_VARIANT(_DenseMatrixFromVector)(XB);
  SparseSolve(Subfactor, XBMatrix);
}
static inline SPARSE_PUBLIC_INTERFACE
void SparseSolve(_SPARSE_VARIANT(SparseOpaqueSubfactor) Subfactor, _SPARSE_VARIANT(DenseVector) B, _SPARSE_VARIANT(DenseVector) X) {
  _SPARSE_VARIANT(DenseMatrix) BMatrix = _SPARSE_VARIANT(_DenseMatrixFromVector)(B);
  _SPARSE_VARIANT(DenseMatrix) XMatrix = _SPARSE_VARIANT(_DenseMatrixFromVector)(X);
  SparseSolve(Subfactor, BMatrix, XMatrix);
}
static inline SPARSE_PUBLIC_INTERFACE
void SparseSolve(_SPARSE_VARIANT(SparseOpaqueSubfactor) Subfactor, _SPARSE_VARIANT(DenseVector) XB, void *_Nonnull workspace) {
  _SPARSE_VARIANT(DenseMatrix) XBMatrix = _SPARSE_VARIANT(_DenseMatrixFromVector)(XB);
  SparseSolve(Subfactor, XBMatrix, workspace);
}
static inline SPARSE_PUBLIC_INTERFACE
void SparseSolve(_SPARSE_VARIANT(SparseOpaqueSubfactor) Subfactor, _SPARSE_VARIANT(DenseVector) B, _SPARSE_VARIANT(DenseVector) X,
                 void *_Nonnull workspace) {
  _SPARSE_VARIANT(DenseMatrix) BMatrix = _SPARSE_VARIANT(_DenseMatrixFromVector)(B);
  _SPARSE_VARIANT(DenseMatrix) XMatrix = _SPARSE_VARIANT(_DenseMatrixFromVector)(X);
  SparseSolve(Subfactor, BMatrix, XMatrix, workspace);
}
static inline SPARSE_PUBLIC_INTERFACE
void SparseMultiply(_SPARSE_VARIANT(SparseOpaqueSubfactor) Subfactor, _SPARSE_VARIANT(DenseMatrix) XY) {
  SparseSymbolicFactorOptions options = _SparseDefaultSymbolicFactorOptions; 
  SPARSE_PARAMETER_CHECK(Subfactor.contents != SparseSubfactorInvalid, ,
                         "Subfactor does not hold a valid factor subobject.\n");
  options = _SparseGetOptionsFromSymbolicFactor(&Subfactor.factor.symbolicFactorization);
  int m, n;
  _SPARSE_VARIANT(_SparseSubFactorGetDimn)(Subfactor, &m, &n);
  int XYCount = (XY.attributes.transpose) ? XY.rowCount : XY.columnCount;
  int XYsize  = (XY.attributes.transpose) ? XY.columnCount : XY.rowCount;
  SPARSE_PARAMETER_CHECK(XYCount > 0, , "XY must have non-zero dimension.\n");
  int maxmn = (m > n) ? m : n;
  SPARSE_PARAMETER_CHECK(XYsize == maxmn, ,
                         "XY dimension (%d) must match maximum subfactor dimension (%d).\n",
                         XYsize, maxmn);
  size_t lworkspace = Subfactor.workspaceRequiredStatic + XYCount*Subfactor.workspaceRequiredPerRHS;
  void *workspace = options.malloc(lworkspace);
  SPARSE_PARAMETER_CHECK(workspace, ,
                         "Failed to allocate workspace of size %ld.\n", lworkspace);
  _SPARSE_VARIANT(_SparseMultiplySubfactor)(&Subfactor, NULL, &XY, (char*)workspace);
  options.free(workspace);
}
static inline SPARSE_PUBLIC_INTERFACE
void SparseMultiply(_SPARSE_VARIANT(SparseOpaqueSubfactor) Subfactor, _SPARSE_VARIANT(DenseMatrix) X, _SPARSE_VARIANT(DenseMatrix) Y) {
  SparseSymbolicFactorOptions options = _SparseDefaultSymbolicFactorOptions; 
  SPARSE_PARAMETER_CHECK(Subfactor.contents != SparseSubfactorInvalid, ,
                         "Subfactor does not hold a valid factor subobject.\n");
  options = _SparseGetOptionsFromSymbolicFactor(&Subfactor.factor.symbolicFactorization);
  int m, n;
  _SPARSE_VARIANT(_SparseSubFactorGetDimn)(Subfactor, &m, &n);
  SPARSE_CHECK_CONSISTENT_MAT_OUT_PLACE(n, m, X, Y, , "subfactor dimension");
  int nrhs = (Y.attributes.transpose) ? Y.rowCount : Y.columnCount;
  size_t lworkspace = Subfactor.workspaceRequiredStatic + nrhs*Subfactor.workspaceRequiredPerRHS;
  void *workspace = options.malloc(lworkspace);
  SPARSE_PARAMETER_CHECK(workspace, ,
                         "Failed to allocate workspace of size %ld.\n", lworkspace);
  _SPARSE_VARIANT(_SparseMultiplySubfactor)(&Subfactor, &X, &Y, (char*)workspace);
  options.free(workspace);
}
static inline SPARSE_PUBLIC_INTERFACE
void SparseMultiply(_SPARSE_VARIANT(SparseOpaqueSubfactor) Subfactor, _SPARSE_VARIANT(DenseMatrix) XY, void *_Nonnull workspace) {
  SparseSymbolicFactorOptions options = _SparseDefaultSymbolicFactorOptions; 
  SPARSE_PARAMETER_CHECK(Subfactor.contents != SparseSubfactorInvalid, ,
                         "Subfactor does not hold a valid factor subobject.\n");
  options = _SparseGetOptionsFromSymbolicFactor(&Subfactor.factor.symbolicFactorization);
  int m, n;
  _SPARSE_VARIANT(_SparseSubFactorGetDimn)(Subfactor, &m, &n);
  int XYCount = (XY.attributes.transpose) ? XY.rowCount : XY.columnCount;
  int XYsize  = (XY.attributes.transpose) ? XY.columnCount : XY.rowCount;
  SPARSE_PARAMETER_CHECK(XYCount > 0, , "XY must have non-zero dimension.\n");
  int maxmn = (m > n) ? m : n;
  SPARSE_PARAMETER_CHECK(XYsize == maxmn, ,
                         "XY dimension (%d) must match maximum subfactor dimension (%d).\n",
                         XYsize, maxmn);
  _SPARSE_VARIANT(_SparseMultiplySubfactor)(&Subfactor, NULL, &XY, (char*)workspace);
}
static inline SPARSE_PUBLIC_INTERFACE
void SparseMultiply(_SPARSE_VARIANT(SparseOpaqueSubfactor) Subfactor, _SPARSE_VARIANT(DenseMatrix) X, _SPARSE_VARIANT(DenseMatrix) Y, void *_Nonnull workspace) {
  SparseSymbolicFactorOptions options = _SparseDefaultSymbolicFactorOptions; 
  SPARSE_PARAMETER_CHECK(Subfactor.contents != SparseSubfactorInvalid, ,
                         "Subfactor does not hold a valid factor subobject.\n");
  options = _SparseGetOptionsFromSymbolicFactor(&Subfactor.factor.symbolicFactorization);
  int m, n;
  _SPARSE_VARIANT(_SparseSubFactorGetDimn)(Subfactor, &m, &n);
  SPARSE_CHECK_CONSISTENT_MAT_OUT_PLACE(m, n, Y, X, , "subfactor dimension");
  _SPARSE_VARIANT(_SparseMultiplySubfactor)(&Subfactor, &X, &Y, (char*)workspace);
}
static inline SPARSE_PUBLIC_INTERFACE
void SparseMultiply(_SPARSE_VARIANT(SparseOpaqueSubfactor) Subfactor, _SPARSE_VARIANT(DenseVector) XY) {
  _SPARSE_VARIANT(DenseMatrix) XYMatrix = _SPARSE_VARIANT(_DenseMatrixFromVector)(XY);
  SparseMultiply(Subfactor, XYMatrix);
}
static inline SPARSE_PUBLIC_INTERFACE
void SparseMultiply(_SPARSE_VARIANT(SparseOpaqueSubfactor) Subfactor,
                    _SPARSE_VARIANT(DenseVector) X, _SPARSE_VARIANT(DenseVector) Y) {
  _SPARSE_VARIANT(DenseMatrix) XMatrix = _SPARSE_VARIANT(_DenseMatrixFromVector)(X);
  _SPARSE_VARIANT(DenseMatrix) YMatrix = _SPARSE_VARIANT(_DenseMatrixFromVector)(Y);
  SparseMultiply(Subfactor, XMatrix, YMatrix);
}
static inline SPARSE_PUBLIC_INTERFACE
void SparseMultiply(_SPARSE_VARIANT(SparseOpaqueSubfactor) Subfactor, _SPARSE_VARIANT(DenseVector) XY, void *_Nonnull workspace) {
  _SPARSE_VARIANT(DenseMatrix) XYMatrix = _SPARSE_VARIANT(_DenseMatrixFromVector)(XY);
  SparseMultiply(Subfactor, XYMatrix, workspace);
}
static inline SPARSE_PUBLIC_INTERFACE
void SparseMultiply(_SPARSE_VARIANT(SparseOpaqueSubfactor) Subfactor,
                     _SPARSE_VARIANT(DenseVector) X, _SPARSE_VARIANT(DenseVector) Y,
                     void *_Nonnull workspace) {
  _SPARSE_VARIANT(DenseMatrix) XMatrix = _SPARSE_VARIANT(_DenseMatrixFromVector)(X);
  _SPARSE_VARIANT(DenseMatrix) YMatrix = _SPARSE_VARIANT(_DenseMatrixFromVector)(Y);
  SparseMultiply(Subfactor, XMatrix, YMatrix, workspace);
}
static inline SPARSE_PUBLIC_INTERFACE
_SPARSE_VARIANT(SparseOpaquePreconditioner) SparseCreatePreconditioner(
    SparsePreconditioner_t type, _SPARSE_VARIANT(SparseMatrix) A) {
  SparseIterativeMethod nullMethod = {};
  struct _SparseIterativeMethodBaseOptions options = nullMethod.options.base;
  int Am = A.structure.blockSize * ((A.structure.attributes.transpose) ? A.structure.columnCount : A.structure.rowCount);
  int An = A.structure.blockSize * ((A.structure.attributes.transpose) ? A.structure.rowCount : A.structure.columnCount);
  SPARSE_PARAMETER_CHECK(Am>0 && An>0,
                         (_SPARSE_VARIANT(SparseOpaquePreconditioner)) { .type = SparsePreconditionerNone },
                         "Bad matrix dimensions %dx%d\n", Am, An);
  return _SPARSE_VARIANT(_SparseCreatePreconditioner) (type, &A);
}
static inline SPARSE_PUBLIC_INTERFACE
SparseIterativeStatus_t SparseSolve(SparseIterativeMethod method, _SPARSE_VARIANT(SparseMatrix) A,
    _SPARSE_VARIANT(DenseMatrix) B, _SPARSE_VARIANT(DenseMatrix) X) {
  struct _SparseIterativeMethodBaseOptions options = method.options.base;
  int Am = A.structure.blockSize * ((A.structure.attributes.transpose) ? A.structure.columnCount : A.structure.rowCount);
  int An = A.structure.blockSize * ((A.structure.attributes.transpose) ? A.structure.rowCount : A.structure.columnCount);
  SPARSE_PARAMETER_CHECK(Am>0 && An>0, SparseIterativeParameterError,
                         "Bad matrix dimensions %dx%d\n", Am, An);
  int Xm = (X.attributes.transpose) ? X.columnCount : X.rowCount;
  int Xn = (X.attributes.transpose) ? X.rowCount : X.columnCount;
  int Bm = (B.attributes.transpose) ? B.columnCount : B.rowCount;
  int Bn = (B.attributes.transpose) ? B.rowCount : B.columnCount;
  SPARSE_PARAMETER_CHECK(Xn == Bn, SparseIterativeParameterError,
                         "Dimensions of X (%dx%d) and B (%dx%d) do not match.", Xm, Xn, Bm, Bn);
  SPARSE_PARAMETER_CHECK(Xm==An, SparseIterativeParameterError,
                         "Dimensions of A (%dx%d) and X (%dx%d) do not match.", Am, An, Xm, Xn);
  SPARSE_PARAMETER_CHECK(Bm==Am, SparseIterativeParameterError,
                         "Dimensions of A (%dx%d) and B (%dx%d) do not match.", Am, An, Bm, Bn);
  switch(method.method) {
    case _SparseMethodCG:
      SPARSE_PARAMETER_CHECK(Xm == Bm, SparseIterativeParameterError,
                             "Counts of X (%d) and B (%d) do not match.", Xm, Bm);
      return _SPARSE_VARIANT(_SparseCGSolve)(&method.options.cg, &X, &B,
        ^void(bool accumulate, enum CBLAS_TRANSPOSE trans, _SPARSE_VARIANT(DenseMatrix) X, _SPARSE_VARIANT(DenseMatrix) Y) {
          if(accumulate) SparseMultiplyAdd(A, X, Y);
          else           SparseMultiply(A, X, Y);
        }, NULL);
    case _SparseMethodGMRES:
      SPARSE_PARAMETER_CHECK(Xm == Bm, SparseIterativeParameterError,
                             "Counts of X (%d) and B (%d) do not match.", Xm, Bm);
      return _SPARSE_VARIANT(_SparseGMRESSolve)(&method.options.gmres, &X, &B,
        ^void(bool accumulate, enum CBLAS_TRANSPOSE trans, _SPARSE_VARIANT(DenseMatrix) X, _SPARSE_VARIANT(DenseMatrix) Y) {
          if(accumulate) SparseMultiplyAdd(A, X, Y);
          else           SparseMultiply(A, X, Y);        }, NULL);
    case _SparseMethodLSMR:
      return _SPARSE_VARIANT(_SparseLSMRSolve)(&method.options.lsmr, &X, &B,
        ^void(bool accumulate, enum CBLAS_TRANSPOSE trans, _SPARSE_VARIANT(DenseMatrix) X, _SPARSE_VARIANT(DenseMatrix) Y) {
          if(accumulate) {
            if(trans==CblasNoTrans) SparseMultiplyAdd(A, X, Y);
            else                    SparseMultiplyAdd(SparseGetTranspose(A), X, Y);
          } else {
            if(trans==CblasNoTrans) SparseMultiply(A, X, Y);
            else                    SparseMultiply(SparseGetTranspose(A), X, Y);
          }
        }, NULL);
    default:
      __builtin_unreachable(); 
  }
}
static inline SPARSE_PUBLIC_INTERFACE
SparseIterativeStatus_t SparseSolve(SparseIterativeMethod method, _SPARSE_VARIANT(SparseMatrix) A,
    _SPARSE_VARIANT(DenseVector) b, _SPARSE_VARIANT(DenseVector) x) {
  return SparseSolve(method, A, _SPARSE_VARIANT(_DenseMatrixFromVector)(b),
                     _SPARSE_VARIANT(_DenseMatrixFromVector)(x));
}
static inline SPARSE_PUBLIC_INTERFACE
SparseIterativeStatus_t SparseSolve(SparseIterativeMethod method,
    void (^_Nonnull ApplyOperator)(bool accumulate, enum CBLAS_TRANSPOSE trans, _SPARSE_VARIANT(DenseMatrix), _SPARSE_VARIANT(DenseMatrix)),
    _SPARSE_VARIANT(DenseMatrix) B, _SPARSE_VARIANT(DenseMatrix) X) {
  struct _SparseIterativeMethodBaseOptions options = method.options.base;
  int Xm = (X.attributes.transpose) ? X.columnCount : X.rowCount;
  int Xn = (X.attributes.transpose) ? X.rowCount : X.columnCount;
  int Bm = (B.attributes.transpose) ? B.columnCount : B.rowCount;
  int Bn = (B.attributes.transpose) ? B.rowCount : B.columnCount;
  SPARSE_PARAMETER_CHECK(Xm > 0 && Xn > 0, SparseIterativeParameterError,
                         "Bad dimensions for X (%dx%d)\n", Xm, Xn);
  SPARSE_PARAMETER_CHECK(Bm > 0 && Bn > 0, SparseIterativeParameterError,
                         "Bad dimensions for B (%dx%d)\n", Bm, Bn);
  SPARSE_PARAMETER_CHECK(Xn == Bn, SparseIterativeParameterError,
                         "Dimensions of X (%dx%d) and B (%dx%d) do not match.", Xm, Xn, Bm, Bn);
  switch(method.method) {
    case _SparseMethodCG:
      SPARSE_PARAMETER_CHECK(Xm == Bm, SparseIterativeParameterError,
                             "Dimensions of X (%dx%d) and B (%dx%d) do not match.", Xm, Xn, Bm, Bn);
      return _SPARSE_VARIANT(_SparseCGSolve)(&method.options.cg, &X, &B, ApplyOperator, NULL);
    case _SparseMethodGMRES:
      SPARSE_PARAMETER_CHECK(Xm == Bm, SparseIterativeParameterError,
                             "Dimensions of X (%dx%d) and B (%dx%d) do not match.", Xm, Xn, Bm, Bn);
      return _SPARSE_VARIANT(_SparseGMRESSolve)(&method.options.gmres, &X, &B, ApplyOperator, NULL);
    case _SparseMethodLSMR:
      return _SPARSE_VARIANT(_SparseLSMRSolve)(&method.options.lsmr, &X, &B, ApplyOperator, NULL);
    default:
      __builtin_unreachable(); 
  }
}
static inline SPARSE_PUBLIC_INTERFACE
SparseIterativeStatus_t SparseSolve(SparseIterativeMethod method,
    void (^_Nonnull ApplyOperator)(bool accumulate, enum CBLAS_TRANSPOSE trans,_SPARSE_VARIANT(DenseVector), _SPARSE_VARIANT(DenseVector)),
    _SPARSE_VARIANT(DenseVector) b, _SPARSE_VARIANT(DenseVector) x) {
  struct _SparseIterativeMethodBaseOptions options = method.options.base;
  int Xm = x.count;
  int Bm = b.count;
  SPARSE_PARAMETER_CHECK(Xm > 0, SparseIterativeParameterError,
                         "Bad dimension for x (%dx%d)\n", Xm, 1);
  SPARSE_PARAMETER_CHECK(Bm > 0, SparseIterativeParameterError,
                         "Bad dimensions for b (%dx%d)\n", Bm, 1);
  _SPARSE_VARIANT(DenseMatrix) X = _SPARSE_VARIANT(_DenseMatrixFromVector)(x);
  _SPARSE_VARIANT(DenseMatrix) B = _SPARSE_VARIANT(_DenseMatrixFromVector)(b);
  switch(method.method) {
    case _SparseMethodCG:
      SPARSE_PARAMETER_CHECK(Xm == Bm, SparseIterativeParameterError,
                             "Counts of X (%d) and B (%d) do not match.", Xm, Bm);
      return _SPARSE_VARIANT(_SparseCGSolve)(&method.options.cg, &X, &B,
        ^void(bool accumulate, enum CBLAS_TRANSPOSE trans, _SPARSE_VARIANT(DenseMatrix) X, _SPARSE_VARIANT(DenseMatrix) Y) {
         ApplyOperator(accumulate, trans,
           (_SPARSE_VARIANT(DenseVector)) { .count=X.rowCount, .data=X.data },
           (_SPARSE_VARIANT(DenseVector)) { .count=Y.rowCount, .data=Y.data }
           );
        }, NULL );
    case _SparseMethodGMRES:
      SPARSE_PARAMETER_CHECK(Xm == Bm, SparseIterativeParameterError,
                             "Counts of X (%d) and B (%d) do not match.", Xm, Bm);
      return _SPARSE_VARIANT(_SparseGMRESSolve)(&method.options.gmres, &X, &B,
        ^void(bool accumulate, enum CBLAS_TRANSPOSE trans, _SPARSE_VARIANT(DenseMatrix) X, _SPARSE_VARIANT(DenseMatrix) Y) {
          ApplyOperator(accumulate, trans,
            (_SPARSE_VARIANT(DenseVector)) { .count=X.rowCount, .data=X.data },
            (_SPARSE_VARIANT(DenseVector)) { .count=Y.rowCount, .data=Y.data }
            );
        }, NULL );
    case _SparseMethodLSMR:
      return _SPARSE_VARIANT(_SparseLSMRSolve)(&method.options.lsmr, &X, &B,
        ^void(bool accumulate, enum CBLAS_TRANSPOSE trans, _SPARSE_VARIANT(DenseMatrix) X, _SPARSE_VARIANT(DenseMatrix) Y) {
          ApplyOperator(accumulate, trans,
            (_SPARSE_VARIANT(DenseVector)) { .count=X.rowCount, .data=X.data },
            (_SPARSE_VARIANT(DenseVector)) { .count=Y.rowCount, .data=Y.data }
            );
        }, NULL );
    default:
      __builtin_unreachable(); 
  }
}
static inline SPARSE_PUBLIC_INTERFACE
SparseIterativeStatus_t SparseSolve(SparseIterativeMethod method, _SPARSE_VARIANT(SparseMatrix) A,
    _SPARSE_VARIANT(DenseMatrix) B, _SPARSE_VARIANT(DenseMatrix) X, SparsePreconditioner_t Preconditioner) {
  struct _SparseIterativeMethodBaseOptions options = method.options.base;
  int Am = A.structure.blockSize * ((A.structure.attributes.transpose) ? A.structure.columnCount : A.structure.rowCount);
  int An = A.structure.blockSize * ((A.structure.attributes.transpose) ? A.structure.rowCount : A.structure.columnCount);
  SPARSE_PARAMETER_CHECK(Am>0 && An>0, SparseIterativeParameterError,
                         "Bad matrix dimensions %dx%d\n", Am, An);
  int Xm = (X.attributes.transpose) ? X.columnCount : X.rowCount;
  int Xn = (X.attributes.transpose) ? X.rowCount : X.columnCount;
  int Bm = (B.attributes.transpose) ? B.columnCount : B.rowCount;
  int Bn = (B.attributes.transpose) ? B.rowCount : B.columnCount;
  SPARSE_PARAMETER_CHECK(Xn == Bn, SparseIterativeParameterError,
                         "Dimensions of X (%dx%d) and B (%dx%d) do not match.", Xm, Xn, Bm, Bn);
  SPARSE_PARAMETER_CHECK(Xm==An, SparseIterativeParameterError,
                         "Dimensions of A (%dx%d) and X (%dx%d) do not match.", Am, An, Xm, Xn);
  SPARSE_PARAMETER_CHECK(Bm==Am, SparseIterativeParameterError,
                         "Dimensions of A (%dx%d) and B (%dx%d) do not match.", Am, An, Bm, Bn);
  SPARSE_PARAMETER_CHECK(Preconditioner != SparsePreconditionerNone &&
                         Preconditioner != SparsePreconditionerUser, SparseIterativeParameterError,
                         "Invalid preconditioner type for this call: for no preconditioner, omit "
                         "the parameter. User-supplied preconditioners must supply apply() method.");
  _SPARSE_VARIANT(SparseOpaquePreconditioner) P =
    _SPARSE_VARIANT(_SparseCreatePreconditioner) (Preconditioner, &A);
  if(P.type == SparsePreconditionerNone) return SparseIterativeInternalError;
  SparseIterativeStatus_t result;
  switch(method.method) {
    case _SparseMethodCG:
      result = _SPARSE_VARIANT(_SparseCGSolve)(&method.options.cg, &X, &B,
        ^void(bool accumulate, enum CBLAS_TRANSPOSE trans, _SPARSE_VARIANT(DenseMatrix) X, _SPARSE_VARIANT(DenseMatrix) Y) {
          if(accumulate) SparseMultiplyAdd(A, X, Y);
          else           SparseMultiply(A, X, Y);
        }, &P);
      break;
    case _SparseMethodGMRES:
      result = _SPARSE_VARIANT(_SparseGMRESSolve)(&method.options.gmres, &X, &B,
        ^void(bool accumulate, enum CBLAS_TRANSPOSE trans, _SPARSE_VARIANT(DenseMatrix) X, _SPARSE_VARIANT(DenseMatrix) Y) {
          if(accumulate) SparseMultiplyAdd(A, X, Y);
          else           SparseMultiply(A, X, Y);
        }, &P);
      break;
    case _SparseMethodLSMR:
      result = _SPARSE_VARIANT(_SparseLSMRSolve)(&method.options.lsmr, &X, &B,
      ^void(bool accumulate, enum CBLAS_TRANSPOSE trans, _SPARSE_VARIANT(DenseMatrix) X, _SPARSE_VARIANT(DenseMatrix) Y) {
        if(accumulate) {
          if(trans==CblasNoTrans) SparseMultiplyAdd(A, X, Y);
          else                    SparseMultiplyAdd(SparseGetTranspose(A), X, Y);
        } else {
          if(trans==CblasNoTrans) SparseMultiply(A, X, Y);
          else                    SparseMultiply(SparseGetTranspose(A), X, Y);
        }
      }, &P);
      break;
    default:
      __builtin_unreachable(); 
  }
  _SPARSE_VARIANT(_SparseReleaseOpaquePreconditioner)(&P);
  return result;
}
static inline SPARSE_PUBLIC_INTERFACE
SparseIterativeStatus_t SparseSolve(SparseIterativeMethod method, _SPARSE_VARIANT(SparseMatrix) A,
    _SPARSE_VARIANT(DenseVector) b, _SPARSE_VARIANT(DenseVector) x,
    SparsePreconditioner_t Preconditioner) {
  return SparseSolve(method, A, _SPARSE_VARIANT(_DenseMatrixFromVector)(b),
                     _SPARSE_VARIANT(_DenseMatrixFromVector)(x));
}
static inline SPARSE_PUBLIC_INTERFACE
SparseIterativeStatus_t SparseSolve(SparseIterativeMethod method, _SPARSE_VARIANT(SparseMatrix) A,
    _SPARSE_VARIANT(DenseMatrix) B, _SPARSE_VARIANT(DenseMatrix) X,
    _SPARSE_VARIANT(SparseOpaquePreconditioner) Preconditioner) {
  struct _SparseIterativeMethodBaseOptions options = method.options.base;
  int Am = A.structure.blockSize * ((A.structure.attributes.transpose) ? A.structure.columnCount : A.structure.rowCount);
  int An = A.structure.blockSize * ((A.structure.attributes.transpose) ? A.structure.rowCount : A.structure.columnCount);
  SPARSE_PARAMETER_CHECK(Am>0 && An>0, SparseIterativeParameterError,
                         "Bad matrix dimensions %dx%d\n", Am, An);
  int Xm = (X.attributes.transpose) ? X.columnCount : X.rowCount;
  int Xn = (X.attributes.transpose) ? X.rowCount : X.columnCount;
  int Bm = (B.attributes.transpose) ? B.columnCount : B.rowCount;
  int Bn = (B.attributes.transpose) ? B.rowCount : B.columnCount;
  SPARSE_PARAMETER_CHECK(Xn == Bn, SparseIterativeParameterError,
                         "Dimensions of X (%dx%d) and B (%dx%d) do not match.", Xm, Xn, Bm, Bn);
  SPARSE_PARAMETER_CHECK(Xm==An, SparseIterativeParameterError,
                         "Dimensions of A (%dx%d) and X (%dx%d) do not match.", Am, An, Xm, Xn);
  SPARSE_PARAMETER_CHECK(Bm==Am, SparseIterativeParameterError,
                         "Dimensions of A (%dx%d) and B (%dx%d) do not match.", Am, An, Bm, Bn);
  switch(method.method) {
    case _SparseMethodCG:
      SPARSE_PARAMETER_CHECK(Xm == Bm, SparseIterativeParameterError,
                             "Counts of X (%d) and B (%d) do not match.", Xm, Bm);
      return _SPARSE_VARIANT(_SparseCGSolve)(&method.options.cg, &X, &B,
        ^void(bool accumulate, enum CBLAS_TRANSPOSE trans, _SPARSE_VARIANT(DenseMatrix) X, _SPARSE_VARIANT(DenseMatrix) Y) {
          if(accumulate) SparseMultiplyAdd(A, X, Y);
          else           SparseMultiply(A, X, Y);
        }, &Preconditioner);
    case _SparseMethodGMRES:
      SPARSE_PARAMETER_CHECK(Xm == Bm, SparseIterativeParameterError,
                             "Counts of X (%d) and B (%d) do not match.", Xm, Bm);
      return _SPARSE_VARIANT(_SparseGMRESSolve)(&method.options.gmres, &X, &B,
        ^void(bool accumulate, enum CBLAS_TRANSPOSE trans, _SPARSE_VARIANT(DenseMatrix) X, _SPARSE_VARIANT(DenseMatrix) Y) {
          if(accumulate) SparseMultiplyAdd(A, X, Y);
          else           SparseMultiply(A, X, Y);
        }, &Preconditioner);
    case _SparseMethodLSMR:
      return _SPARSE_VARIANT(_SparseLSMRSolve)(&method.options.lsmr, &X, &B,
        ^void(bool accumulate, enum CBLAS_TRANSPOSE trans, _SPARSE_VARIANT(DenseMatrix) X, _SPARSE_VARIANT(DenseMatrix) Y) {
          if(accumulate) {
            if(trans==CblasNoTrans) SparseMultiplyAdd(A, X, Y);
            else                    SparseMultiplyAdd(SparseGetTranspose(A), X, Y);
          } else {
            if(trans==CblasNoTrans) SparseMultiply(A, X, Y);
            else                    SparseMultiply(SparseGetTranspose(A), X, Y);
          }
        }, &Preconditioner);
    default:
      __builtin_unreachable(); 
  }
}
static inline SPARSE_PUBLIC_INTERFACE
SparseIterativeStatus_t SparseSolve(SparseIterativeMethod method, _SPARSE_VARIANT(SparseMatrix) A,
    _SPARSE_VARIANT(DenseVector) b, _SPARSE_VARIANT(DenseVector) x,
    _SPARSE_VARIANT(SparseOpaquePreconditioner) Preconditioner) {
  return SparseSolve(method, A, _SPARSE_VARIANT(_DenseMatrixFromVector)(b),
                     _SPARSE_VARIANT(_DenseMatrixFromVector)(x), Preconditioner);
}
static inline SPARSE_PUBLIC_INTERFACE
SparseIterativeStatus_t SparseSolve(SparseIterativeMethod method,
    void (^_Nonnull ApplyOperator)(bool accumulate, enum CBLAS_TRANSPOSE trans, _SPARSE_VARIANT(DenseMatrix), _SPARSE_VARIANT(DenseMatrix)) ,
    _SPARSE_VARIANT(DenseMatrix) B, _SPARSE_VARIANT(DenseMatrix) X,
    _SPARSE_VARIANT(SparseOpaquePreconditioner) Preconditioner) {
  struct _SparseIterativeMethodBaseOptions options = method.options.base;
  int Xm = (X.attributes.transpose) ? X.columnCount : X.rowCount;
  int Xn = (X.attributes.transpose) ? X.rowCount : X.columnCount;
  int Bm = (B.attributes.transpose) ? B.columnCount : B.rowCount;
  int Bn = (B.attributes.transpose) ? B.rowCount : B.columnCount;
  SPARSE_PARAMETER_CHECK(Xm > 0 && Xn > 0, SparseIterativeParameterError,
                         "Bad dimensions for X (%dx%d)\n", Xm, Xn);
  SPARSE_PARAMETER_CHECK(Bm > 0 && Bn > 0, SparseIterativeParameterError,
                         "Bad dimensions for B (%dx%d)\n", Bm, Bn);
  SPARSE_PARAMETER_CHECK(Xn == Bn, SparseIterativeParameterError,
                         "Dimensions of X (%dx%d) and B (%dx%d) do not match.", Xm, Xn, Bm, Bn);
  switch(method.method) {
    case _SparseMethodCG:
      SPARSE_PARAMETER_CHECK(Xm == Bm, SparseIterativeParameterError,
                             "Dimensions of X (%dx%d) and B (%dx%d) do not match.", Xm, Xn, Bm, Bn);
      return _SPARSE_VARIANT(_SparseCGSolve)(&method.options.cg, &X, &B, ApplyOperator, &Preconditioner);
    case _SparseMethodGMRES:
      SPARSE_PARAMETER_CHECK(Xm == Bm, SparseIterativeParameterError,
                             "Dimensions of X (%dx%d) and B (%dx%d) do not match.", Xm, Xn, Bm, Bn);
      return _SPARSE_VARIANT(_SparseGMRESSolve)(&method.options.gmres, &X, &B, ApplyOperator, &Preconditioner);
    case _SparseMethodLSMR:
      return _SPARSE_VARIANT(_SparseLSMRSolve)(&method.options.lsmr, &X, &B, ApplyOperator, &Preconditioner);
    default:
      __builtin_unreachable(); 
  }
}
static inline SPARSE_PUBLIC_INTERFACE
SparseIterativeStatus_t SparseSolve(SparseIterativeMethod method,
    void (^_Nonnull ApplyOperator)(bool accumulate, enum CBLAS_TRANSPOSE trans, _SPARSE_VARIANT(DenseVector), _SPARSE_VARIANT(DenseVector)),
    _SPARSE_VARIANT(DenseVector) b, _SPARSE_VARIANT(DenseVector) x,
    _SPARSE_VARIANT(SparseOpaquePreconditioner) Preconditioner) {
  struct _SparseIterativeMethodBaseOptions options = method.options.base;
  int Xm = x.count;
  int Bm = b.count;
  SPARSE_PARAMETER_CHECK(Xm > 0, SparseIterativeParameterError,
                         "Bad dimension for x (%dx%d)\n", Xm, 1);
  SPARSE_PARAMETER_CHECK(Bm > 0, SparseIterativeParameterError,
                         "Bad dimensions for b (%dx%d)\n", Bm, 1);
  _SPARSE_VARIANT(DenseMatrix) X = _SPARSE_VARIANT(_DenseMatrixFromVector)(x);
  _SPARSE_VARIANT(DenseMatrix) B = _SPARSE_VARIANT(_DenseMatrixFromVector)(b);
  switch(method.method) {
    case _SparseMethodCG:
      SPARSE_PARAMETER_CHECK(Xm == Bm, SparseIterativeParameterError,
                             "Counts of X (%d) and B (%d) do not match.", Xm, Bm);
      return _SPARSE_VARIANT(_SparseCGSolve)(&method.options.cg, &X, &B,
        ^void(bool accumulate, enum CBLAS_TRANSPOSE trans, _SPARSE_VARIANT(DenseMatrix) X, _SPARSE_VARIANT(DenseMatrix) Y) {
          ApplyOperator(accumulate, trans,
            (_SPARSE_VARIANT(DenseVector)) { .count=X.rowCount, .data=X.data },
            (_SPARSE_VARIANT(DenseVector)) { .count=Y.rowCount, .data=Y.data }
            );
        }, &Preconditioner );
    case _SparseMethodGMRES:
      SPARSE_PARAMETER_CHECK(Xm == Bm, SparseIterativeParameterError,
                             "Counts of X (%d) and B (%d) do not match.", Xm, Bm);
      return _SPARSE_VARIANT(_SparseGMRESSolve)(&method.options.gmres, &X, &B,
        ^void(bool accumulate, enum CBLAS_TRANSPOSE trans, _SPARSE_VARIANT(DenseMatrix) X, _SPARSE_VARIANT(DenseMatrix) Y) {
          ApplyOperator(accumulate, trans,
            (_SPARSE_VARIANT(DenseVector)) { .count=X.rowCount, .data=X.data },
            (_SPARSE_VARIANT(DenseVector)) { .count=Y.rowCount, .data=Y.data }
            );
          }, &Preconditioner );
    case _SparseMethodLSMR:
      return _SPARSE_VARIANT(_SparseLSMRSolve)(&method.options.lsmr, &X, &B,
        ^void(bool accumulate, enum CBLAS_TRANSPOSE trans, _SPARSE_VARIANT(DenseMatrix) X, _SPARSE_VARIANT(DenseMatrix) Y) {
          ApplyOperator(accumulate, trans,
            (_SPARSE_VARIANT(DenseVector)) { .count=X.rowCount, .data=X.data },
            (_SPARSE_VARIANT(DenseVector)) { .count=Y.rowCount, .data=Y.data }
            );
        }, &Preconditioner );
    default:
      __builtin_unreachable(); 
  }
}
static inline SPARSE_PUBLIC_INTERFACE
size_t _SPARSE_VARIANT(SparseGetStateSize)(SparseIterativeMethod method, bool preconditioner, int m, int n, int nrhs) {
  return _SPARSE_VARIANT(_SparseGetIterativeStateSize)(&method, preconditioner, m, n, nrhs);
}
static inline SPARSE_PUBLIC_INTERFACE
void SparseIterate(SparseIterativeMethod method, int iteration, const bool *_Nonnull converged, void *_Nonnull state,
    void (^_Nonnull ApplyOperator)(bool accumulate, enum CBLAS_TRANSPOSE trans, _SPARSE_VARIANT(DenseMatrix), _SPARSE_VARIANT(DenseMatrix)),
    _SPARSE_VARIANT(DenseMatrix) B, _SPARSE_VARIANT(DenseMatrix) R, _SPARSE_VARIANT(DenseMatrix) X,
    _SPARSE_VARIANT(SparseOpaquePreconditioner) Preconditioner) {
  struct _SparseIterativeMethodBaseOptions options = method.options.base;
  int Xm = (X.attributes.transpose) ? X.columnCount : X.rowCount;
  int Xn = (X.attributes.transpose) ? X.rowCount : X.columnCount;
  SPARSE_PARAMETER_CHECK(Xm>0 && Xn>0, , "Invalid size for X (%dx%d).", Xm, Xn);
  int Bm = (B.attributes.transpose) ? B.columnCount : B.rowCount;
  int Bn = (B.attributes.transpose) ? B.rowCount : B.columnCount;
  SPARSE_PARAMETER_CHECK(Bm>0 && Bn>0, , "Invalid size for B (%dx%d).", Bm, Bn);
  int Rm = (R.attributes.transpose) ? R.columnCount : R.rowCount;
  int Rn = (R.attributes.transpose) ? R.rowCount : R.columnCount;
  SPARSE_PARAMETER_CHECK(Rm>0 && Rn>0, , "Invalid size for R (%dx%d).", Rm, Rn);
  SPARSE_PARAMETER_CHECK(Xn==Bn && Bn==Rn, ,
                         "Sizes of X (%dx%d), B (%dx%d) and R (%dx%d) are inconsistent.", Xm, Xn, Bm, Bn, Rm, Bn);
  SPARSE_PARAMETER_CHECK(Rm>=Bm, ,
                         "Sizes of residual matrix R(%dx%d) must be at least as large as right-hand side B (%dx%d).",
                         Rm, Rn, Bm, Rn);
  switch(method.method) {
    case _SparseMethodCG:
      _SPARSE_VARIANT(_SparseCGIterate) (&method.options.cg, iteration, (char*)state, converged,
                                         &X, &B, &R, &Preconditioner, ApplyOperator);
      break;
    case _SparseMethodGMRES:
      _SPARSE_VARIANT(_SparseGMRESIterate) (&method.options.gmres, iteration, (char*)state, converged,
                                            &X, &B, &R, &Preconditioner, ApplyOperator);
      break;
    case _SparseMethodLSMR:
      _SPARSE_VARIANT(_SparseLSMRIterate) (&method.options.lsmr, iteration, (char*)state, converged,
                                           &X, &B, &R, &Preconditioner, ApplyOperator);
      break;
    default:
      __builtin_unreachable(); 
  }
}
static inline SPARSE_PUBLIC_INTERFACE
void SparseIterate(SparseIterativeMethod method, int iteration, const bool *_Nonnull converged, void *_Nonnull state,
    void (^_Nonnull ApplyOperator)(bool accumulate, enum CBLAS_TRANSPOSE trans, _SPARSE_VARIANT(DenseMatrix), _SPARSE_VARIANT(DenseMatrix)),
    _SPARSE_VARIANT(DenseMatrix) B, _SPARSE_VARIANT(DenseMatrix) R, _SPARSE_VARIANT(DenseMatrix) X) {
  struct _SparseIterativeMethodBaseOptions options = method.options.base;
  int Xm = (X.attributes.transpose) ? X.columnCount : X.rowCount;
  int Xn = (X.attributes.transpose) ? X.rowCount : X.columnCount;
  SPARSE_PARAMETER_CHECK(Xm>0 && Xn>0, , "Invalid size for X (%dx%d).", Xm, Xn);
  int Bm = (B.attributes.transpose) ? B.columnCount : B.rowCount;
  int Bn = (B.attributes.transpose) ? B.rowCount : B.columnCount;
  SPARSE_PARAMETER_CHECK(Bm>0 && Bn>0, , "Invalid size for B (%dx%d).", Bm, Bn);
  int Rm = (R.attributes.transpose) ? R.columnCount : R.rowCount;
  int Rn = (R.attributes.transpose) ? R.rowCount : R.columnCount;
  SPARSE_PARAMETER_CHECK(Rm>0 && Rn>0, , "Invalid size for R (%dx%d).", Rm, Rn);
  SPARSE_PARAMETER_CHECK(Xn==Bn && Bn==Rn, ,
                         "Sizes of X (%dx%d), B (%dx%d) and R (%dx%d) are inconsistent.", Xm, Xn, Bm, Bn, Rm, Bn);
  SPARSE_PARAMETER_CHECK(Rm>=Bm, ,
                         "Sizes of residual matrix R(%dx%d) must be at least as large as right-hand side B (%dx%d).",
                         Rm, Rn, Bm, Rn);
  switch(method.method) {
    case _SparseMethodCG:
      _SPARSE_VARIANT(_SparseCGIterate) (&method.options.cg, iteration, (char*)state, converged,
                                         &X, &B, &R, NULL, ApplyOperator);
      break;
    case _SparseMethodGMRES:
      _SPARSE_VARIANT(_SparseGMRESIterate) (&method.options.gmres, iteration, (char*)state, converged,
                                            &X, &B, &R, NULL, ApplyOperator);
      break;
    case _SparseMethodLSMR:
      _SPARSE_VARIANT(_SparseLSMRIterate) (&method.options.lsmr, iteration, (char*)state, converged,
                                           &X, &B, &R, NULL, ApplyOperator);
      break;
    default:
      __builtin_unreachable(); 
  }
}
static inline SPARSE_PUBLIC_INTERFACE
_SPARSE_VARIANT(SparseOpaqueFactorization) SparseRetain(_SPARSE_VARIANT(SparseOpaqueFactorization) NumericFactor) {
  SparseSymbolicFactorOptions options = _SparseDefaultSymbolicFactorOptions; 
  SPARSE_CHECK_VALID_SYMBOLIC_FACTOR(NumericFactor.symbolicFactorization,
                                     _SPARSE_VARIANT(_SparseFailedFactor)(SparseParameterError),
                                     "Can only retain valid numeric factorizations.\n")
  options = _SparseGetOptionsFromSymbolicFactor(&NumericFactor.symbolicFactorization);
  SPARSE_PARAMETER_CHECK(NumericFactor.status == SparseStatusOK && NumericFactor.numericFactorization,
                         _SPARSE_VARIANT(_SparseFailedFactor)(SparseParameterError),
                         "Can only retain valid numeric factorizations.\n");
  _SPARSE_VARIANT(_SparseRetainNumeric)(&NumericFactor);
  return NumericFactor;
}
static inline SPARSE_PUBLIC_INTERFACE
_SPARSE_VARIANT(SparseOpaqueSubfactor) SparseRetain(_SPARSE_VARIANT(SparseOpaqueSubfactor) Subfactor) {
  SparseSymbolicFactorOptions options = _SparseDefaultSymbolicFactorOptions; 
  SPARSE_PARAMETER_CHECK(Subfactor.factor.symbolicFactorization.status == SparseStatusOK &&
                         Subfactor.factor.symbolicFactorization.factorization,
                         _SPARSE_VARIANT(_SparseInvalidSubfactor)(), "Can only retain valid objects.\n");
  options = _SparseGetOptionsFromSymbolicFactor(&Subfactor.factor.symbolicFactorization);
  SPARSE_PARAMETER_CHECK(Subfactor.factor.status == SparseStatusOK && Subfactor.factor.numericFactorization,
                         _SPARSE_VARIANT(_SparseInvalidSubfactor)(), "Can only retain valid objects.\n");
  _SPARSE_VARIANT(_SparseRetainNumeric)(&Subfactor.factor);
  return Subfactor;
}
static inline SPARSE_PUBLIC_INTERFACE
void SparseCleanup(_SPARSE_VARIANT(SparseOpaqueFactorization) toFree) {
  if (toFree.status >= 0) _SPARSE_VARIANT(_SparseDestroyOpaqueNumeric)(&toFree);
}
static inline SPARSE_PUBLIC_INTERFACE
void SparseCleanup(_SPARSE_VARIANT(SparseOpaqueSubfactor) toFree) {
  if (toFree.factor.status >= 0) _SPARSE_VARIANT(_SparseDestroyOpaqueNumeric)(&toFree.factor);
}
static inline SPARSE_PUBLIC_INTERFACE
void SparseCleanup(_SPARSE_VARIANT(SparseMatrix) toFree) {
  SparseSymbolicFactorOptions options = _SparseDefaultSymbolicFactorOptions; 
  SPARSE_PARAMETER_CHECK(toFree.structure.attributes._allocatedBySparse == true, ,
                         "Attempting to call SparseCleanup on a matrix that was not allocated by the Sparse library.\n");
  free(toFree.structure.columnStarts);
}
static inline SPARSE_PUBLIC_INTERFACE
void SparseCleanup(_SPARSE_VARIANT(SparseOpaquePreconditioner) Preconditioner) {
  SparseIterativeMethod nullMethod = {};
  struct _SparseIterativeMethodBaseOptions options = nullMethod.options.base;
  SPARSE_PARAMETER_CHECK(Preconditioner.type!=SparsePreconditionerNone && Preconditioner.type!=SparsePreconditionerUser,
                         , "Cannot cleanup this kind of Preconditioner.");
  _SPARSE_VARIANT(_SparseReleaseOpaquePreconditioner) (&Preconditioner);
}
