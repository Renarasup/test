#ifndef VIMAGE_CONVOLUTION_H
#define VIMAGE_CONVOLUTION_H
#ifdef __cplusplus
extern "C" {
#endif
#include <vImage/vImage_Types.h>
vImage_Error vImageConvolve_Planar8( const vImage_Buffer *src, const vImage_Buffer *dest, void *tempBuffer, vImagePixelCount srcOffsetToROI_X, vImagePixelCount srcOffsetToROI_Y,  const int16_t *kernel, uint32_t kernel_height, uint32_t kernel_width, int32_t divisor, Pixel_8 backgroundColor, vImage_Flags flags ) VIMAGE_NON_NULL(1,2) __OSX_AVAILABLE_STARTING( __MAC_10_3, __IPHONE_5_0 );
vImage_Error vImageConvolve_PlanarF( const vImage_Buffer *src, const vImage_Buffer *dest, void *tempBuffer, vImagePixelCount srcOffsetToROI_X, vImagePixelCount srcOffsetToROI_Y,  const float *kernel, uint32_t kernel_height, uint32_t kernel_width, Pixel_F backgroundColor, vImage_Flags flags ) VIMAGE_NON_NULL(1,2) __OSX_AVAILABLE_STARTING( __MAC_10_3, __IPHONE_5_0 );
vImage_Error vImageConvolve_ARGB8888( const vImage_Buffer *src, const vImage_Buffer *dest, void *tempBuffer, vImagePixelCount srcOffsetToROI_X, vImagePixelCount srcOffsetToROI_Y,  const int16_t *kernel, uint32_t kernel_height, uint32_t kernel_width, int32_t divisor, const Pixel_8888 backgroundColor, vImage_Flags flags ) VIMAGE_NON_NULL(1,2) __OSX_AVAILABLE_STARTING( __MAC_10_3, __IPHONE_5_0 );
vImage_Error vImageConvolve_ARGBFFFF( const vImage_Buffer *src, const vImage_Buffer *dest, void *tempBuffer, vImagePixelCount srcOffsetToROI_X, vImagePixelCount srcOffsetToROI_Y,  const float *kernel, uint32_t kernel_height, uint32_t kernel_width, const Pixel_FFFF backgroundColor, vImage_Flags flags ) VIMAGE_NON_NULL(1,2) __OSX_AVAILABLE_STARTING( __MAC_10_3, __IPHONE_5_0 );
vImage_Error vImageConvolveWithBias_Planar8( const vImage_Buffer *src, const vImage_Buffer *dest, void *tempBuffer, vImagePixelCount srcOffsetToROI_X, vImagePixelCount srcOffsetToROI_Y,  const int16_t *kernel, uint32_t kernel_height, uint32_t kernel_width, int32_t divisor, int32_t bias, Pixel_8 backgroundColor, vImage_Flags flags ) VIMAGE_NON_NULL(1,2) __OSX_AVAILABLE_STARTING( __MAC_10_4, __IPHONE_5_0 );
vImage_Error vImageConvolveWithBias_PlanarF( const vImage_Buffer *src, const vImage_Buffer *dest, void *tempBuffer, vImagePixelCount srcOffsetToROI_X, vImagePixelCount srcOffsetToROI_Y,  const float *kernel, uint32_t kernel_height, uint32_t kernel_width, float bias, Pixel_F backgroundColor, vImage_Flags flags ) VIMAGE_NON_NULL(1,2) __OSX_AVAILABLE_STARTING( __MAC_10_4, __IPHONE_5_0 );
vImage_Error vImageConvolveWithBias_ARGB8888( const vImage_Buffer *src, const vImage_Buffer *dest, void *tempBuffer, vImagePixelCount srcOffsetToROI_X, vImagePixelCount srcOffsetToROI_Y,  const int16_t *kernel, uint32_t kernel_height, uint32_t kernel_width, int32_t divisor, int32_t bias, const Pixel_8888 backgroundColor, vImage_Flags flags ) VIMAGE_NON_NULL(1,2)    __OSX_AVAILABLE_STARTING( __MAC_10_4, __IPHONE_5_0 );
vImage_Error vImageConvolveWithBias_ARGBFFFF( const vImage_Buffer *src, const vImage_Buffer *dest, void *tempBuffer, vImagePixelCount srcOffsetToROI_X, vImagePixelCount srcOffsetToROI_Y,  const float *kernel, uint32_t kernel_height, uint32_t kernel_width, float bias,  const Pixel_FFFF backgroundColor, vImage_Flags flags ) VIMAGE_NON_NULL(1,2) __OSX_AVAILABLE_STARTING( __MAC_10_4, __IPHONE_5_0 );
vImage_Error vImageConvolveMultiKernel_ARGB8888(    const vImage_Buffer *src, 
                                                    const vImage_Buffer *dest, 
                                                    void *tempBuffer, 
                                                    vImagePixelCount srcOffsetToROI_X, 
                                                    vImagePixelCount srcOffsetToROI_Y,  
                                                    const int16_t *kernels[4], 		
                                                    uint32_t kernel_height, 
                                                    uint32_t kernel_width, 
                                                    const int32_t divisors[4], 
													const int32_t biases[4], 
                                                    const Pixel_8888 backgroundColor,
                                                    vImage_Flags flags ) VIMAGE_NON_NULL(1,2)    __OSX_AVAILABLE_STARTING( __MAC_10_4, __IPHONE_5_0 );
vImage_Error vImageConvolveMultiKernel_ARGBFFFF(    const vImage_Buffer *src, 
                                                    const vImage_Buffer *dest, 
                                                    void *tempBuffer, 
                                                    vImagePixelCount srcOffsetToROI_X, 
                                                    vImagePixelCount srcOffsetToROI_Y,  
                                                    const float *kernels[4], 
                                                    uint32_t kernel_height, 
                                                    uint32_t kernel_width, 
													const float biases[4], 
                                                    const Pixel_FFFF backgroundColor,
                                                    vImage_Flags flags ) VIMAGE_NON_NULL(1,2,6,9,10)    __OSX_AVAILABLE_STARTING( __MAC_10_4, __IPHONE_5_0 );
vImage_Error vImageRichardsonLucyDeConvolve_Planar8( const vImage_Buffer *src, const vImage_Buffer *dest, void *tempBuffer, vImagePixelCount srcOffsetToROI_X, vImagePixelCount srcOffsetToROI_Y, const int16_t *kernel, const int16_t *kernel2, uint32_t kernel_height, uint32_t kernel_width, uint32_t kernel_height2, uint32_t kernel_width2, int32_t divisor, int32_t divisor2, Pixel_8 backgroundColor, uint32_t iterationCount, vImage_Flags flags ) VIMAGE_NON_NULL(1,2)    __OSX_AVAILABLE_STARTING( __MAC_10_4, __IPHONE_5_0 );
vImage_Error vImageRichardsonLucyDeConvolve_PlanarF( const vImage_Buffer *src, const vImage_Buffer *dest, void *tempBuffer, vImagePixelCount srcOffsetToROI_X, vImagePixelCount srcOffsetToROI_Y, const float *kernel, const float *kernel2, uint32_t kernel_height, uint32_t kernel_width, uint32_t kernel_height2, uint32_t kernel_width2, Pixel_F backgroundColor,  uint32_t iterationCount, vImage_Flags flags ) VIMAGE_NON_NULL(1,2)    __OSX_AVAILABLE_STARTING( __MAC_10_4, __IPHONE_5_0 );
vImage_Error vImageRichardsonLucyDeConvolve_ARGB8888( const vImage_Buffer *src, const vImage_Buffer *dest, void *tempBuffer, vImagePixelCount srcOffsetToROI_X, vImagePixelCount srcOffsetToROI_Y, const int16_t *kernel, const int16_t *kernel2, uint32_t kernel_height, uint32_t kernel_width, uint32_t kernel_height2, uint32_t kernel_width2, int32_t divisor, int32_t divisor2, const Pixel_8888 backgroundColor,  uint32_t iterationCount, vImage_Flags flags ) VIMAGE_NON_NULL(1,2)    __OSX_AVAILABLE_STARTING( __MAC_10_4, __IPHONE_5_0 );
vImage_Error vImageRichardsonLucyDeConvolve_ARGBFFFF( const vImage_Buffer *src, const vImage_Buffer *dest, void *tempBuffer, vImagePixelCount srcOffsetToROI_X, vImagePixelCount srcOffsetToROI_Y, const float *kernel, const float *kernel2, uint32_t kernel_height, uint32_t kernel_width, uint32_t kernel_height2, uint32_t kernel_width2, const Pixel_FFFF backgroundColor,  uint32_t iterationCount, vImage_Flags flags ) VIMAGE_NON_NULL(1,2)    __OSX_AVAILABLE_STARTING( __MAC_10_4, __IPHONE_5_0 );
vImage_Error vImageBoxConvolve_Planar8( const vImage_Buffer *src, const vImage_Buffer *dest, void *tempBuffer, vImagePixelCount srcOffsetToROI_X, vImagePixelCount srcOffsetToROI_Y, uint32_t kernel_height, uint32_t kernel_width, Pixel_8 backgroundColor, vImage_Flags flags ) VIMAGE_NON_NULL(1,2)    __OSX_AVAILABLE_STARTING( __MAC_10_4, __IPHONE_5_0 );
vImage_Error vImageBoxConvolve_ARGB8888( const vImage_Buffer *src, const vImage_Buffer *dest, void *tempBuffer, vImagePixelCount srcOffsetToROI_X, vImagePixelCount srcOffsetToROI_Y, uint32_t kernel_height, uint32_t kernel_width, const Pixel_8888 backgroundColor, vImage_Flags flags ) VIMAGE_NON_NULL(1,2)    __OSX_AVAILABLE_STARTING( __MAC_10_4, __IPHONE_5_0 );
vImage_Error vImageTentConvolve_Planar8( const vImage_Buffer *src, const vImage_Buffer *dest, void *tempBuffer, vImagePixelCount srcOffsetToROI_X, vImagePixelCount srcOffsetToROI_Y, uint32_t kernel_height, uint32_t kernel_width, Pixel_8 backgroundColor, vImage_Flags flags ) VIMAGE_NON_NULL(1,2)    __OSX_AVAILABLE_STARTING( __MAC_10_4, __IPHONE_5_0 );
vImage_Error vImageTentConvolve_ARGB8888( const vImage_Buffer *src, const vImage_Buffer *dest, void *tempBuffer, vImagePixelCount srcOffsetToROI_X, vImagePixelCount srcOffsetToROI_Y, uint32_t kernel_height, uint32_t kernel_width, const Pixel_8888 backgroundColor, vImage_Flags flags ) VIMAGE_NON_NULL(1,2)    __OSX_AVAILABLE_STARTING( __MAC_10_4, __IPHONE_5_0 );
#ifdef __cplusplus
}
#endif
#endif
