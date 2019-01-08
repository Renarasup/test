#ifndef __BNNS_HEADER__
#define __BNNS_HEADER__
#include <stddef.h>
#include <stdint.h>
#ifdef __cplusplus
extern "C" {
#endif
#if __has_include( <Availability.h> )
#include <Availability.h>
#else
#define __OSX_AVAILABLE(a)
#define __IOS_AVAILABLE(a)
#define __TVOS_AVAILABLE(a)
#define __WATCHOS_AVAILABLE(a)
#endif
#if __has_feature(assume_nonnull)
  _Pragma("clang assume_nonnull begin")
#else
#define _Null_unspecified
#define _Nullable
#define _Nonnull
#endif
typedef int (*BNNSAlloc)(void * _Nullable * _Nullable memptr, size_t alignment, size_t size);
typedef void (*BNNSFree)(void * _Null_unspecified ptr);
#pragma mark - Constants
typedef enum {
  BNNSDataTypeFloatBit            = 0x10000,
  BNNSDataTypeFloat16             = BNNSDataTypeFloatBit | 16,
  BNNSDataTypeFloat32             = BNNSDataTypeFloatBit | 32,
  BNNSDataTypeIntBit              = 0x20000,
  BNNSDataTypeInt8                = BNNSDataTypeIntBit | 8,
  BNNSDataTypeInt16               = BNNSDataTypeIntBit | 16,
  BNNSDataTypeInt32               = BNNSDataTypeIntBit | 32,
  BNNSDataTypeUIntBit             = 0x40000,
  BNNSDataTypeUInt8               = BNNSDataTypeUIntBit | 8,
  BNNSDataTypeUInt16              = BNNSDataTypeUIntBit | 16,
  BNNSDataTypeUInt32              = BNNSDataTypeUIntBit | 32,
  BNNSDataTypeIndexedBit          = 0x80000,
  BNNSDataTypeIndexed8            = BNNSDataTypeIndexedBit | 8,
} BNNSDataType;
typedef enum {
  BNNSPoolingFunctionMax          = 0,
  BNNSPoolingFunctionAverage      = 1,
} BNNSPoolingFunction;
typedef enum {
  BNNSActivationFunctionIdentity                        =  0,
  BNNSActivationFunctionRectifiedLinear                 =  1,
  BNNSActivationFunctionLeakyRectifiedLinear            =  2,
  BNNSActivationFunctionSigmoid                         =  3,
  BNNSActivationFunctionTanh                            =  4,
  BNNSActivationFunctionScaledTanh                      =  5,
  BNNSActivationFunctionAbs                             =  6,
  BNNSActivationFunctionLinear                          =  7,
  BNNSActivationFunctionClamp                           =  8,
  BNNSActivationFunctionIntegerLinearSaturate           =  9,
  BNNSActivationFunctionIntegerLinearSaturatePerChannel = 10,
  BNNSActivationFunctionSoftmax                         = 11,
} BNNSActivationFunction;
typedef enum {
  BNNSFlagsUseClientPtr                         = 0x0001,
} BNNSFlags;
#pragma mark - Data formats
typedef struct {
  size_t width;
  size_t height;
  size_t channels;
  size_t row_stride;
  size_t image_stride;
  BNNSDataType data_type;
  float        data_scale;
  float        data_bias;
} BNNSImageStackDescriptor;
typedef struct {
  size_t size;
  BNNSDataType data_type;
  float        data_scale;
  float        data_bias;
} BNNSVectorDescriptor;
#pragma mark - Layer parameters
typedef struct {
  const void * _Nullable  data;
  BNNSDataType            data_type;
  float                   data_scale;
  float                   data_bias;
  const float * _Nullable data_table;
} BNNSLayerData;
typedef struct {
  BNNSActivationFunction function;
  float alpha;
  float beta;
  int32_t iscale;
  int32_t ioffset;
  int32_t ishift;
  const int32_t * _Nullable iscale_per_channel;
  const int32_t * _Nullable ioffset_per_channel;
  const int32_t * _Nullable ishift_per_channel;
} BNNSActivation;
typedef struct {
  size_t x_stride;
  size_t y_stride;
  size_t x_padding;
  size_t y_padding;
  size_t k_width;
  size_t k_height;
  size_t in_channels;
  size_t out_channels;
  BNNSLayerData weights;
  BNNSLayerData bias;
  BNNSActivation activation;
} BNNSConvolutionLayerParameters;
typedef struct {
  size_t in_size;
  size_t out_size;
  BNNSLayerData weights;
  BNNSLayerData bias;
  BNNSActivation activation;
} BNNSFullyConnectedLayerParameters;
typedef struct {
  size_t x_stride;
  size_t y_stride;
  size_t x_padding;
  size_t y_padding;
  size_t k_width;
  size_t k_height;
  size_t in_channels;
  size_t out_channels;
  BNNSPoolingFunction pooling_function;
  BNNSLayerData bias;
  BNNSActivation activation;
} BNNSPoolingLayerParameters;
#pragma mark - Filter parameters
typedef struct {
  uint32_t flags;
  size_t n_threads;
  BNNSAlloc _Nullable alloc_memory;
  BNNSFree _Nullable free_memory;
} BNNSFilterParameters;
#pragma mark - Filter creation
typedef void * _Nullable BNNSFilter;
BNNSFilter BNNSFilterCreateConvolutionLayer(const BNNSImageStackDescriptor * in_desc,
                                            const BNNSImageStackDescriptor * out_desc,
                                            const BNNSConvolutionLayerParameters * layer_params,
                                            const BNNSFilterParameters * _Nullable filter_params)
__OSX_AVAILABLE(10.12) __IOS_AVAILABLE(10.0) __TVOS_AVAILABLE(10.0) __WATCHOS_AVAILABLE(3.0);
BNNSFilter BNNSFilterCreateFullyConnectedLayer(const BNNSVectorDescriptor * in_desc,
                                               const BNNSVectorDescriptor * out_desc,
                                               const BNNSFullyConnectedLayerParameters * layer_params,
                                               const BNNSFilterParameters * _Nullable filter_params)
__OSX_AVAILABLE(10.12) __IOS_AVAILABLE(10.0) __TVOS_AVAILABLE(10.0) __WATCHOS_AVAILABLE(3.0);
BNNSFilter BNNSFilterCreatePoolingLayer(const BNNSImageStackDescriptor * in_desc,
                                        const BNNSImageStackDescriptor * out_desc,
                                        const BNNSPoolingLayerParameters * layer_params,
                                        const BNNSFilterParameters * _Nullable filter_params)
__OSX_AVAILABLE(10.12) __IOS_AVAILABLE(10.0) __TVOS_AVAILABLE(10.0) __WATCHOS_AVAILABLE(3.0);
BNNSFilter BNNSFilterCreateVectorActivationLayer(const BNNSVectorDescriptor * in_desc,
                                                 const BNNSVectorDescriptor * out_desc,
                                                 const BNNSActivation * activation,
                                                 const BNNSFilterParameters * _Nullable filter_params)
__OSX_AVAILABLE(10.13) __IOS_AVAILABLE(11.0) __TVOS_AVAILABLE(11.0) __WATCHOS_AVAILABLE(4.0);
int BNNSFilterApply(BNNSFilter filter,const void * in,void * out)
__OSX_AVAILABLE(10.12) __IOS_AVAILABLE(10.0) __TVOS_AVAILABLE(10.0) __WATCHOS_AVAILABLE(3.0);
int BNNSFilterApplyBatch(BNNSFilter filter,size_t batch_size,const void * in,size_t in_stride,void * out,size_t out_stride)
__OSX_AVAILABLE(10.12) __IOS_AVAILABLE(10.0) __TVOS_AVAILABLE(10.0) __WATCHOS_AVAILABLE(3.0);
void BNNSFilterDestroy(BNNSFilter filter)
__OSX_AVAILABLE(10.12) __IOS_AVAILABLE(10.0) __TVOS_AVAILABLE(10.0) __WATCHOS_AVAILABLE(3.0);
#if !__has_include( <Availability.h> )
#undef __OSX_AVAILABLE
#undef __IOS_AVAILABLE
#undef __TVOS_AVAILABLE
#undef __WATCHOS_AVAILABLE
#endif
#if __has_feature(assume_nonnull)
  _Pragma("clang assume_nonnull end")
#else
#undef _Nullable
#undef _Null_unspecified
#undef _Nonnull
#endif
#ifdef __cplusplus
}
#endif
#endif 
