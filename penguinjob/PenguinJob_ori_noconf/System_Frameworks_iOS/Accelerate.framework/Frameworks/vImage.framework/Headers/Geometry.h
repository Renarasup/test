#ifndef VIMAGE_GEOMETRY_H
#define VIMAGE_GEOMETRY_H
#include <vImage/vImage_Types.h>
#ifdef __cplusplus
extern "C" {
#endif
enum
{
    kRotate0DegreesClockwise = 0,
    kRotate90DegreesClockwise = 3,
    kRotate180DegreesClockwise = 2,
    kRotate270DegreesClockwise = 1,
    kRotate0DegreesCounterClockwise = 0,
    kRotate90DegreesCounterClockwise = 1,
    kRotate180DegreesCounterClockwise = 2,
    kRotate270DegreesCounterClockwise = 3
};
vImage_Error	vImageRotate_Planar8( const vImage_Buffer *src, const vImage_Buffer *dest, void *tempBuffer, float angleInRadians, Pixel_8 backColor, vImage_Flags flags ) VIMAGE_NON_NULL(1,2)    __OSX_AVAILABLE_STARTING( __MAC_10_3, __IPHONE_5_0 );
vImage_Error	vImageRotate_PlanarF( const vImage_Buffer *src, const vImage_Buffer *dest, void *tempBuffer, float angleInRadians, Pixel_F backColor, vImage_Flags flags ) VIMAGE_NON_NULL(1,2)    __OSX_AVAILABLE_STARTING( __MAC_10_3, __IPHONE_5_0 );
vImage_Error	vImageRotate_ARGB8888( const vImage_Buffer *src, const vImage_Buffer *dest, void *tempBuffer, float angleInRadians, const Pixel_8888 backColor, vImage_Flags flags ) VIMAGE_NON_NULL(1,2)    __OSX_AVAILABLE_STARTING( __MAC_10_3, __IPHONE_5_0 );
vImage_Error	vImageRotate_ARGB16U( const vImage_Buffer *src, const vImage_Buffer *dest, void *tempBuffer, float angleInRadians, const Pixel_ARGB_16U backColor, vImage_Flags flags ) VIMAGE_NON_NULL(1,2)    __OSX_AVAILABLE_STARTING( __MAC_10_9, __IPHONE_7_0 );
vImage_Error	vImageRotate_ARGB16S( const vImage_Buffer *src, const vImage_Buffer *dest, void *tempBuffer, float angleInRadians, const Pixel_ARGB_16S backColor, vImage_Flags flags ) VIMAGE_NON_NULL(1,2)    __OSX_AVAILABLE_STARTING( __MAC_10_9, __IPHONE_7_0 );
vImage_Error	vImageRotate_ARGBFFFF( const vImage_Buffer *src, const vImage_Buffer *dest, void *tempBuffer, float angleInRadians, const Pixel_FFFF backColor, vImage_Flags flags ) VIMAGE_NON_NULL(1,2)    __OSX_AVAILABLE_STARTING( __MAC_10_3, __IPHONE_5_0 );
vImage_Error	vImageScale_Planar8( const vImage_Buffer *src, const vImage_Buffer *dest, void *tempBuffer, vImage_Flags flags ) VIMAGE_NON_NULL(1,2)    __OSX_AVAILABLE_STARTING( __MAC_10_3, __IPHONE_5_0 );
vImage_Error	vImageScale_Planar16S( const vImage_Buffer *src, const vImage_Buffer *dest, void *tempBuffer, vImage_Flags flags ) VIMAGE_NON_NULL(1,2)    __OSX_AVAILABLE_STARTING( __MAC_10_10, __IPHONE_8_0 );
vImage_Error	vImageScale_Planar16U( const vImage_Buffer *src, const vImage_Buffer *dest, void *tempBuffer, vImage_Flags flags ) VIMAGE_NON_NULL(1,2)    __OSX_AVAILABLE_STARTING( __MAC_10_10, __IPHONE_8_0 );
vImage_Error	vImageScale_PlanarF( const vImage_Buffer *src, const vImage_Buffer *dest, void *tempBuffer, vImage_Flags flags ) VIMAGE_NON_NULL(1,2)    __OSX_AVAILABLE_STARTING( __MAC_10_3, __IPHONE_5_0 );
vImage_Error	vImageScale_ARGB8888( const vImage_Buffer *src, const vImage_Buffer *dest, void *tempBuffer, vImage_Flags flags ) VIMAGE_NON_NULL(1,2)    __OSX_AVAILABLE_STARTING( __MAC_10_3, __IPHONE_5_0 );
vImage_Error	vImageScale_ARGB16U( const vImage_Buffer *src, const vImage_Buffer *dest, void *tempBuffer, vImage_Flags flags ) VIMAGE_NON_NULL(1,2)    __OSX_AVAILABLE_STARTING( __MAC_10_9, __IPHONE_7_0 );
vImage_Error	vImageScale_ARGB16S( const vImage_Buffer *src, const vImage_Buffer *dest, void *tempBuffer, vImage_Flags flags ) VIMAGE_NON_NULL(1,2)    __OSX_AVAILABLE_STARTING( __MAC_10_9, __IPHONE_7_0 );
vImage_Error	vImageScale_ARGBFFFF( const vImage_Buffer *src, const vImage_Buffer *dest, void *tempBuffer, vImage_Flags flags ) VIMAGE_NON_NULL(1,2)    __OSX_AVAILABLE_STARTING( __MAC_10_3, __IPHONE_5_0 );
vImage_Error
vImageScale_CbCr8(
	const vImage_Buffer *src,
	const vImage_Buffer *dest,
	void *tempBuffer,
	vImage_Flags flags ) VIMAGE_NON_NULL(1,2)
    __OSX_AVAILABLE_STARTING( __MAC_10_12, __IPHONE_10_0 ) __WATCHOS_AVAILABLE(__WATCHOS_3_0) __TVOS_AVAILABLE(__TVOS_10_0);
vImage_Error
vImageScale_CbCr16U(
	const vImage_Buffer *src,
	const vImage_Buffer *dest,
	void *tempBuffer,
	vImage_Flags flags ) VIMAGE_NON_NULL(1,2)
    __OSX_AVAILABLE_STARTING( __MAC_10_12, __IPHONE_10_0 ) __WATCHOS_AVAILABLE(__WATCHOS_3_0) __TVOS_AVAILABLE(__TVOS_10_0);
vImage_Error
vImageScale_XRGB2101010W(
	const vImage_Buffer *src,
	const vImage_Buffer *dest,
	void *tempBuffer,
	vImage_Flags flags ) VIMAGE_NON_NULL(1,2)
    __OSX_AVAILABLE_STARTING( __MAC_10_12, __IPHONE_10_0 ) __WATCHOS_AVAILABLE(__WATCHOS_3_0) __TVOS_AVAILABLE(__TVOS_10_0);
vImage_Error	vImageAffineWarp_Planar8( const vImage_Buffer *src, const vImage_Buffer *dest, void *tempBuffer, const vImage_AffineTransform *transform, Pixel_8 backColor, vImage_Flags flags ) VIMAGE_NON_NULL(1,2,4) __OSX_AVAILABLE_STARTING( __MAC_10_3, __IPHONE_5_0 );
vImage_Error	vImageAffineWarp_PlanarF( const vImage_Buffer *src, const vImage_Buffer *dest, void *tempBuffer, const vImage_AffineTransform *transform, Pixel_F backColor, vImage_Flags flags ) VIMAGE_NON_NULL(1,2,4) __OSX_AVAILABLE_STARTING( __MAC_10_3, __IPHONE_5_0 );
vImage_Error	vImageAffineWarp_ARGB8888( const vImage_Buffer *src, const vImage_Buffer *dest, void *tempBuffer, const vImage_AffineTransform *transform, const Pixel_8888 backColor, vImage_Flags flags ) VIMAGE_NON_NULL(1,2,4) __OSX_AVAILABLE_STARTING( __MAC_10_3, __IPHONE_5_0 );
vImage_Error	vImageAffineWarp_ARGB16U( const vImage_Buffer *src, const vImage_Buffer *dest, void *tempBuffer, const vImage_AffineTransform *transform, const Pixel_ARGB_16U backColor, vImage_Flags flags ) VIMAGE_NON_NULL(1,2,4) __OSX_AVAILABLE_STARTING( __MAC_10_9, __IPHONE_7_0 );
vImage_Error	vImageAffineWarp_ARGB16S( const vImage_Buffer *src, const vImage_Buffer *dest, void *tempBuffer, const vImage_AffineTransform *transform, const Pixel_ARGB_16S backColor, vImage_Flags flags ) VIMAGE_NON_NULL(1,2,4) __OSX_AVAILABLE_STARTING( __MAC_10_9, __IPHONE_7_0 );
vImage_Error	vImageAffineWarp_ARGBFFFF( const vImage_Buffer *src, const vImage_Buffer *dest, void *tempBuffer, const vImage_AffineTransform *transform, const Pixel_FFFF backColor, vImage_Flags flags ) VIMAGE_NON_NULL(1,2,4) __OSX_AVAILABLE_STARTING( __MAC_10_3, __IPHONE_5_0 );
#if VIMAGE_AFFINETRANSFORM_DOUBLE_IS_AVAILABLE
    vImage_Error	vImageAffineWarpD_Planar8( const vImage_Buffer *src, const vImage_Buffer *dest, void *tempBuffer, const vImage_AffineTransform_Double *transform, Pixel_8 backColor, vImage_Flags flags ) VIMAGE_NON_NULL(1,2,4) __OSX_AVAILABLE_STARTING( __MAC_10_8, __IPHONE_6_0 );
    vImage_Error	vImageAffineWarpD_PlanarF( const vImage_Buffer *src, const vImage_Buffer *dest, void *tempBuffer, const vImage_AffineTransform_Double *transform, Pixel_F backColor, vImage_Flags flags ) VIMAGE_NON_NULL(1,2,4) __OSX_AVAILABLE_STARTING( __MAC_10_8, __IPHONE_6_0 );
    vImage_Error	vImageAffineWarpD_ARGB8888( const vImage_Buffer *src, const vImage_Buffer *dest, void *tempBuffer, const vImage_AffineTransform_Double *transform, const Pixel_8888 backColor, vImage_Flags flags ) VIMAGE_NON_NULL(1,2,4) __OSX_AVAILABLE_STARTING( __MAC_10_8, __IPHONE_6_0 );
    vImage_Error	vImageAffineWarpD_ARGB16U( const vImage_Buffer *src, const vImage_Buffer *dest, void *tempBuffer, const vImage_AffineTransform_Double *transform, const Pixel_ARGB_16U backColor, vImage_Flags flags ) VIMAGE_NON_NULL(1,2,4) __OSX_AVAILABLE_STARTING( __MAC_10_9, __IPHONE_7_0 );
    vImage_Error	vImageAffineWarpD_ARGB16S( const vImage_Buffer *src, const vImage_Buffer *dest, void *tempBuffer, const vImage_AffineTransform_Double *transform, const Pixel_ARGB_16S backColor, vImage_Flags flags ) VIMAGE_NON_NULL(1,2,4) __OSX_AVAILABLE_STARTING( __MAC_10_9, __IPHONE_7_0 );
    vImage_Error	vImageAffineWarpD_ARGBFFFF( const vImage_Buffer *src, const vImage_Buffer *dest, void *tempBuffer, const vImage_AffineTransform_Double *transform, const Pixel_FFFF backColor, vImage_Flags flags ) VIMAGE_NON_NULL(1,2,4) __OSX_AVAILABLE_STARTING( __MAC_10_8, __IPHONE_6_0 );
#endif
#if VIMAGE_CGAFFINETRANSFORM_IS_AVAILABLE
    vImage_Error	vImageAffineWarpCG_Planar8( const vImage_Buffer *src, const vImage_Buffer *dest, void *tempBuffer, const vImage_CGAffineTransform *transform, Pixel_8 backColor, vImage_Flags flags ) VIMAGE_NON_NULL(1,2,4) __OSX_AVAILABLE_STARTING( __MAC_10_8, __IPHONE_6_0 );
    vImage_Error	vImageAffineWarpCG_PlanarF( const vImage_Buffer *src, const vImage_Buffer *dest, void *tempBuffer, const vImage_CGAffineTransform *transform, Pixel_F backColor, vImage_Flags flags ) VIMAGE_NON_NULL(1,2,4) __OSX_AVAILABLE_STARTING( __MAC_10_8, __IPHONE_6_0 );
    vImage_Error	vImageAffineWarpCG_ARGB8888( const vImage_Buffer *src, const vImage_Buffer *dest, void *tempBuffer, const vImage_CGAffineTransform *transform, const Pixel_8888 backColor, vImage_Flags flags ) VIMAGE_NON_NULL(1,2,4) __OSX_AVAILABLE_STARTING( __MAC_10_8, __IPHONE_6_0 );
    vImage_Error	vImageAffineWarpCG_ARGB16U( const vImage_Buffer *src, const vImage_Buffer *dest, void *tempBuffer, const vImage_CGAffineTransform *transform, const Pixel_ARGB_16U backColor, vImage_Flags flags ) VIMAGE_NON_NULL(1,2,4) __OSX_AVAILABLE_STARTING( __MAC_10_9, __IPHONE_7_0 );
    vImage_Error	vImageAffineWarpCG_ARGB16S( const vImage_Buffer *src, const vImage_Buffer *dest, void *tempBuffer, const vImage_CGAffineTransform *transform, const Pixel_ARGB_16S backColor, vImage_Flags flags ) VIMAGE_NON_NULL(1,2,4) __OSX_AVAILABLE_STARTING( __MAC_10_9, __IPHONE_7_0 );
    vImage_Error	vImageAffineWarpCG_ARGBFFFF( const vImage_Buffer *src, const vImage_Buffer *dest, void *tempBuffer, const vImage_CGAffineTransform *transform, const Pixel_FFFF backColor, vImage_Flags flags ) VIMAGE_NON_NULL(1,2,4) __OSX_AVAILABLE_STARTING( __MAC_10_8, __IPHONE_6_0 );
#endif
vImage_Error	vImageHorizontalReflect_Planar8( const vImage_Buffer *src, const vImage_Buffer *dest, vImage_Flags flags ) VIMAGE_NON_NULL(1,2) __OSX_AVAILABLE_STARTING( __MAC_10_3, __IPHONE_5_0 );
vImage_Error	vImageHorizontalReflect_Planar16U( const vImage_Buffer *src, const vImage_Buffer *dest, vImage_Flags flags ) VIMAGE_NON_NULL(1,2) __OSX_AVAILABLE_STARTING( __MAC_10_9, __IPHONE_6_0 );    
vImage_Error	vImageHorizontalReflect_PlanarF( const vImage_Buffer *src, const vImage_Buffer *dest, vImage_Flags flags ) VIMAGE_NON_NULL(1,2) __OSX_AVAILABLE_STARTING( __MAC_10_3, __IPHONE_5_0 );
vImage_Error	vImageHorizontalReflect_ARGB8888( const vImage_Buffer *src, const vImage_Buffer *dest, vImage_Flags flags ) VIMAGE_NON_NULL(1,2) __OSX_AVAILABLE_STARTING( __MAC_10_3, __IPHONE_5_0 );
vImage_Error	vImageHorizontalReflect_ARGB16U( const vImage_Buffer *src, const vImage_Buffer *dest, vImage_Flags flags ) VIMAGE_NON_NULL(1,2) __OSX_AVAILABLE_STARTING( __MAC_10_9, __IPHONE_7_0 );
vImage_Error	vImageHorizontalReflect_ARGB16S( const vImage_Buffer *src, const vImage_Buffer *dest, vImage_Flags flags ) VIMAGE_NON_NULL(1,2) __OSX_AVAILABLE_STARTING( __MAC_10_9, __IPHONE_7_0 );
vImage_Error	vImageHorizontalReflect_ARGBFFFF( const vImage_Buffer *src, const vImage_Buffer *dest, vImage_Flags flags ) VIMAGE_NON_NULL(1,2) __OSX_AVAILABLE_STARTING( __MAC_10_3, __IPHONE_5_0 );
vImage_Error	vImageVerticalReflect_Planar8( const vImage_Buffer *src, const vImage_Buffer *dest, vImage_Flags flags ) VIMAGE_NON_NULL(1,2) __OSX_AVAILABLE_STARTING( __MAC_10_3, __IPHONE_5_0 );
vImage_Error	vImageVerticalReflect_Planar16U( const vImage_Buffer *src, const vImage_Buffer *dest, vImage_Flags flags ) VIMAGE_NON_NULL(1,2) __OSX_AVAILABLE_STARTING( __MAC_10_9, __IPHONE_6_0 );
vImage_Error	vImageVerticalReflect_PlanarF( const vImage_Buffer *src, const vImage_Buffer *dest, vImage_Flags flags ) VIMAGE_NON_NULL(1,2) __OSX_AVAILABLE_STARTING( __MAC_10_3, __IPHONE_5_0 );
vImage_Error	vImageVerticalReflect_ARGB8888( const vImage_Buffer *src, const vImage_Buffer *dest, vImage_Flags flags ) VIMAGE_NON_NULL(1,2) __OSX_AVAILABLE_STARTING( __MAC_10_3, __IPHONE_5_0 );
vImage_Error	vImageVerticalReflect_ARGB16U( const vImage_Buffer *src, const vImage_Buffer *dest, vImage_Flags flags ) VIMAGE_NON_NULL(1,2) __OSX_AVAILABLE_STARTING( __MAC_10_9, __IPHONE_7_0 );
vImage_Error	vImageVerticalReflect_ARGB16S( const vImage_Buffer *src, const vImage_Buffer *dest, vImage_Flags flags ) VIMAGE_NON_NULL(1,2) __OSX_AVAILABLE_STARTING( __MAC_10_9, __IPHONE_7_0 );
vImage_Error	vImageVerticalReflect_ARGBFFFF( const vImage_Buffer *src, const vImage_Buffer *dest, vImage_Flags flags ) VIMAGE_NON_NULL(1,2) __OSX_AVAILABLE_STARTING( __MAC_10_3, __IPHONE_5_0 );
vImage_Error	vImageRotate90_Planar8( const vImage_Buffer *src, const vImage_Buffer *dest, uint8_t rotationConstant, Pixel_8 backColor, vImage_Flags flags ) VIMAGE_NON_NULL(1,2) __OSX_AVAILABLE_STARTING( __MAC_10_3, __IPHONE_5_0 );
vImage_Error	vImageRotate90_Planar16U( const vImage_Buffer *src, const vImage_Buffer *dest, uint8_t rotationConstant, Pixel_16U backColor, vImage_Flags flags ) VIMAGE_NON_NULL(1,2) __OSX_AVAILABLE_STARTING( __MAC_10_9, __IPHONE_6_0 );
vImage_Error	vImageRotate90_PlanarF( const vImage_Buffer *src, const vImage_Buffer *dest, uint8_t rotationConstant, Pixel_F backColor, vImage_Flags flags ) VIMAGE_NON_NULL(1,2) __OSX_AVAILABLE_STARTING( __MAC_10_3, __IPHONE_5_0 );
vImage_Error	vImageRotate90_ARGB8888( const vImage_Buffer *src, const vImage_Buffer *dest, uint8_t rotationConstant, const Pixel_8888 backColor, vImage_Flags flags ) VIMAGE_NON_NULL(1,2,4) __OSX_AVAILABLE_STARTING( __MAC_10_3, __IPHONE_5_0 );
vImage_Error	vImageRotate90_ARGB16U( const vImage_Buffer *src, const vImage_Buffer *dest, uint8_t rotationConstant, const Pixel_ARGB_16U backColor, vImage_Flags flags ) VIMAGE_NON_NULL(1,2,4) __OSX_AVAILABLE_STARTING( __MAC_10_9, __IPHONE_7_0 );
vImage_Error	vImageRotate90_ARGB16S( const vImage_Buffer *src, const vImage_Buffer *dest, uint8_t rotationConstant, const Pixel_ARGB_16S backColor, vImage_Flags flags ) VIMAGE_NON_NULL(1,2,4) __OSX_AVAILABLE_STARTING( __MAC_10_9, __IPHONE_7_0 );
vImage_Error	vImageRotate90_ARGBFFFF( const vImage_Buffer *src, const vImage_Buffer *dest, uint8_t rotationConstant, const Pixel_FFFF backColor, vImage_Flags flags ) VIMAGE_NON_NULL(1,2,4) __OSX_AVAILABLE_STARTING( __MAC_10_3, __IPHONE_5_0 );
vImage_Error	vImageHorizontalShear_Planar8( const vImage_Buffer *src, const vImage_Buffer *dest, vImagePixelCount srcOffsetToROI_X, vImagePixelCount srcOffsetToROI_Y, float xTranslate, float shearSlope, ResamplingFilter filter, Pixel_8 backColor, vImage_Flags flags ) VIMAGE_NON_NULL(1,2) __OSX_AVAILABLE_STARTING( __MAC_10_3, __IPHONE_5_0 );
vImage_Error	vImageHorizontalShear_Planar16S( const vImage_Buffer *src, const vImage_Buffer *dest, vImagePixelCount srcOffsetToROI_X, vImagePixelCount srcOffsetToROI_Y, float xTranslate, float shearSlope, ResamplingFilter filter, Pixel_16S backColor, vImage_Flags flags ) VIMAGE_NON_NULL(1,2) __OSX_AVAILABLE_STARTING( __MAC_10_10, __IPHONE_8_0 );
vImage_Error	vImageHorizontalShear_Planar16U( const vImage_Buffer *src, const vImage_Buffer *dest, vImagePixelCount srcOffsetToROI_X, vImagePixelCount srcOffsetToROI_Y, float xTranslate, float shearSlope, ResamplingFilter filter, Pixel_16U backColor, vImage_Flags flags ) VIMAGE_NON_NULL(1,2) __OSX_AVAILABLE_STARTING( __MAC_10_10, __IPHONE_8_0 );
vImage_Error	vImageHorizontalShear_PlanarF( const vImage_Buffer *src, const vImage_Buffer *dest, vImagePixelCount srcOffsetToROI_X, vImagePixelCount srcOffsetToROI_Y, float xTranslate, float shearSlope, ResamplingFilter filter, Pixel_F backColor, vImage_Flags flags ) VIMAGE_NON_NULL(1,2) __OSX_AVAILABLE_STARTING( __MAC_10_3, __IPHONE_5_0 );
vImage_Error	vImageHorizontalShear_ARGB8888( const vImage_Buffer *src, const vImage_Buffer *dest, vImagePixelCount srcOffsetToROI_X, vImagePixelCount srcOffsetToROI_Y, float xTranslate, float shearSlope, ResamplingFilter filter, const Pixel_8888 backColor, vImage_Flags flags ) VIMAGE_NON_NULL(1,2) __OSX_AVAILABLE_STARTING( __MAC_10_3, __IPHONE_5_0 );
vImage_Error	vImageHorizontalShear_ARGB16U( const vImage_Buffer *src, const vImage_Buffer *dest, vImagePixelCount srcOffsetToROI_X, vImagePixelCount srcOffsetToROI_Y, float xTranslate, float shearSlope, ResamplingFilter filter, const Pixel_ARGB_16U backColor, vImage_Flags flags ) VIMAGE_NON_NULL(1,2) __OSX_AVAILABLE_STARTING( __MAC_10_9, __IPHONE_7_0 );
vImage_Error	vImageHorizontalShear_ARGB16S( const vImage_Buffer *src, const vImage_Buffer *dest, vImagePixelCount srcOffsetToROI_X, vImagePixelCount srcOffsetToROI_Y, float xTranslate, float shearSlope, ResamplingFilter filter, const Pixel_ARGB_16S backColor, vImage_Flags flags ) VIMAGE_NON_NULL(1,2) __OSX_AVAILABLE_STARTING( __MAC_10_9, __IPHONE_7_0 );
vImage_Error	vImageHorizontalShear_ARGBFFFF( const vImage_Buffer *src, const vImage_Buffer *dest, vImagePixelCount srcOffsetToROI_X, vImagePixelCount srcOffsetToROI_Y, float xTranslate, float shearSlope, ResamplingFilter filter, const Pixel_FFFF backColor, vImage_Flags flags ) VIMAGE_NON_NULL(1,2) __OSX_AVAILABLE_STARTING( __MAC_10_3, __IPHONE_5_0 );
vImage_Error	vImageVerticalShear_Planar8( const vImage_Buffer *src, const vImage_Buffer *dest, vImagePixelCount srcOffsetToROI_X, vImagePixelCount srcOffsetToROI_Y, float yTranslate, float shearSlope, ResamplingFilter filter, Pixel_8 backColor, vImage_Flags flags ) VIMAGE_NON_NULL(1,2) __OSX_AVAILABLE_STARTING( __MAC_10_3, __IPHONE_5_0 );
vImage_Error	vImageVerticalShear_Planar16S( const vImage_Buffer *src, const vImage_Buffer *dest, vImagePixelCount srcOffsetToROI_X, vImagePixelCount srcOffsetToROI_Y, float yTranslate, float shearSlope, ResamplingFilter filter, Pixel_16S backColor, vImage_Flags flags ) VIMAGE_NON_NULL(1,2) __OSX_AVAILABLE_STARTING( __MAC_10_10, __IPHONE_8_0 );
vImage_Error	vImageVerticalShear_Planar16U( const vImage_Buffer *src, const vImage_Buffer *dest, vImagePixelCount srcOffsetToROI_X, vImagePixelCount srcOffsetToROI_Y, float yTranslate, float shearSlope, ResamplingFilter filter, Pixel_16U backColor, vImage_Flags flags ) VIMAGE_NON_NULL(1,2) __OSX_AVAILABLE_STARTING( __MAC_10_10, __IPHONE_8_0 );
vImage_Error	vImageVerticalShear_PlanarF( const vImage_Buffer *src, const vImage_Buffer *dest, vImagePixelCount srcOffsetToROI_X, vImagePixelCount srcOffsetToROI_Y, float yTranslate, float shearSlope, ResamplingFilter filter, Pixel_F backColor, vImage_Flags flags ) VIMAGE_NON_NULL(1,2) __OSX_AVAILABLE_STARTING( __MAC_10_3, __IPHONE_5_0 );
vImage_Error	vImageVerticalShear_ARGB8888( const vImage_Buffer *src, const vImage_Buffer *dest, vImagePixelCount srcOffsetToROI_X, vImagePixelCount srcOffsetToROI_Y, float yTranslate, float shearSlope, ResamplingFilter filter,  const Pixel_8888 backColor, vImage_Flags flags ) VIMAGE_NON_NULL(1,2) __OSX_AVAILABLE_STARTING( __MAC_10_3, __IPHONE_5_0 );
vImage_Error	vImageVerticalShear_ARGB16U( const vImage_Buffer *src, const vImage_Buffer *dest, vImagePixelCount srcOffsetToROI_X, vImagePixelCount srcOffsetToROI_Y, float yTranslate, float shearSlope, ResamplingFilter filter,  const Pixel_ARGB_16U backColor, vImage_Flags flags ) VIMAGE_NON_NULL(1,2) __OSX_AVAILABLE_STARTING( __MAC_10_9, __IPHONE_7_0 );
vImage_Error	vImageVerticalShear_ARGB16S( const vImage_Buffer *src, const vImage_Buffer *dest, vImagePixelCount srcOffsetToROI_X, vImagePixelCount srcOffsetToROI_Y, float yTranslate, float shearSlope, ResamplingFilter filter,  const Pixel_ARGB_16S backColor, vImage_Flags flags ) VIMAGE_NON_NULL(1,2) __OSX_AVAILABLE_STARTING( __MAC_10_9, __IPHONE_7_0 );
vImage_Error	vImageVerticalShear_ARGBFFFF( const vImage_Buffer *src, const vImage_Buffer *dest, vImagePixelCount srcOffsetToROI_X, vImagePixelCount srcOffsetToROI_Y, float yTranslate, float shearSlope, ResamplingFilter filter, const Pixel_FFFF backColor, vImage_Flags flags ) VIMAGE_NON_NULL(1,2) __OSX_AVAILABLE_STARTING( __MAC_10_3, __IPHONE_5_0 );
vImage_Error	vImageHorizontalShearD_Planar8( const vImage_Buffer *src, const vImage_Buffer *dest, vImagePixelCount srcOffsetToROI_X, vImagePixelCount srcOffsetToROI_Y, double xTranslate, double shearSlope, ResamplingFilter filter, Pixel_8 backColor, vImage_Flags flags ) VIMAGE_NON_NULL(1,2) __OSX_AVAILABLE_STARTING( __MAC_10_8, __IPHONE_6_0 );
vImage_Error	vImageHorizontalShearD_PlanarF( const vImage_Buffer *src, const vImage_Buffer *dest, vImagePixelCount srcOffsetToROI_X, vImagePixelCount srcOffsetToROI_Y, double xTranslate, double shearSlope, ResamplingFilter filter, Pixel_F backColor, vImage_Flags flags ) VIMAGE_NON_NULL(1,2) __OSX_AVAILABLE_STARTING( __MAC_10_8, __IPHONE_6_0 );
vImage_Error	vImageHorizontalShearD_ARGB8888( const vImage_Buffer *src, const vImage_Buffer *dest, vImagePixelCount srcOffsetToROI_X, vImagePixelCount srcOffsetToROI_Y, double xTranslate, double shearSlope, ResamplingFilter filter, const Pixel_8888 backColor, vImage_Flags flags ) VIMAGE_NON_NULL(1,2) __OSX_AVAILABLE_STARTING( __MAC_10_8, __IPHONE_6_0 );
vImage_Error	vImageHorizontalShearD_ARGB16U( const vImage_Buffer *src, const vImage_Buffer *dest, vImagePixelCount srcOffsetToROI_X, vImagePixelCount srcOffsetToROI_Y, double xTranslate, double shearSlope, ResamplingFilter filter, const Pixel_ARGB_16U backColor, vImage_Flags flags ) VIMAGE_NON_NULL(1,2) __OSX_AVAILABLE_STARTING( __MAC_10_9, __IPHONE_7_0 );
vImage_Error	vImageHorizontalShearD_ARGB16S( const vImage_Buffer *src, const vImage_Buffer *dest, vImagePixelCount srcOffsetToROI_X, vImagePixelCount srcOffsetToROI_Y, double xTranslate, double shearSlope, ResamplingFilter filter, const Pixel_ARGB_16S backColor, vImage_Flags flags ) VIMAGE_NON_NULL(1,2) __OSX_AVAILABLE_STARTING( __MAC_10_9, __IPHONE_7_0 );
vImage_Error	vImageHorizontalShearD_ARGBFFFF( const vImage_Buffer *src, const vImage_Buffer *dest, vImagePixelCount srcOffsetToROI_X, vImagePixelCount srcOffsetToROI_Y, double xTranslate, double shearSlope, ResamplingFilter filter, const Pixel_FFFF backColor, vImage_Flags flags ) VIMAGE_NON_NULL(1,2) __OSX_AVAILABLE_STARTING( __MAC_10_8, __IPHONE_6_0 );
vImage_Error	vImageVerticalShearD_Planar8( const vImage_Buffer *src, const vImage_Buffer *dest, vImagePixelCount srcOffsetToROI_X, vImagePixelCount srcOffsetToROI_Y, double yTranslate, double shearSlope, ResamplingFilter filter, Pixel_8 backColor, vImage_Flags flags ) VIMAGE_NON_NULL(1,2) __OSX_AVAILABLE_STARTING( __MAC_10_8, __IPHONE_6_0 );
vImage_Error	vImageVerticalShearD_PlanarF( const vImage_Buffer *src, const vImage_Buffer *dest, vImagePixelCount srcOffsetToROI_X, vImagePixelCount srcOffsetToROI_Y, double yTranslate, double shearSlope, ResamplingFilter filter, Pixel_F backColor, vImage_Flags flags ) VIMAGE_NON_NULL(1,2) __OSX_AVAILABLE_STARTING( __MAC_10_8, __IPHONE_6_0 );
vImage_Error	vImageVerticalShearD_ARGB8888( const vImage_Buffer *src, const vImage_Buffer *dest, vImagePixelCount srcOffsetToROI_X, vImagePixelCount srcOffsetToROI_Y, double yTranslate, double shearSlope, ResamplingFilter filter,  const Pixel_8888 backColor, vImage_Flags flags ) VIMAGE_NON_NULL(1,2) __OSX_AVAILABLE_STARTING( __MAC_10_8, __IPHONE_6_0 );
vImage_Error	vImageVerticalShearD_ARGB16U( const vImage_Buffer *src, const vImage_Buffer *dest, vImagePixelCount srcOffsetToROI_X, vImagePixelCount srcOffsetToROI_Y, double yTranslate, double shearSlope, ResamplingFilter filter,  const Pixel_ARGB_16U backColor, vImage_Flags flags ) VIMAGE_NON_NULL(1,2) __OSX_AVAILABLE_STARTING( __MAC_10_9, __IPHONE_7_0 );
vImage_Error	vImageVerticalShearD_ARGB16S( const vImage_Buffer *src, const vImage_Buffer *dest, vImagePixelCount srcOffsetToROI_X, vImagePixelCount srcOffsetToROI_Y, double yTranslate, double shearSlope, ResamplingFilter filter,  const Pixel_ARGB_16S backColor, vImage_Flags flags ) VIMAGE_NON_NULL(1,2) __OSX_AVAILABLE_STARTING( __MAC_10_9, __IPHONE_7_0 );
vImage_Error	vImageVerticalShearD_ARGBFFFF( const vImage_Buffer *src, const vImage_Buffer *dest, vImagePixelCount srcOffsetToROI_X, vImagePixelCount srcOffsetToROI_Y, double yTranslate, double shearSlope, ResamplingFilter filter, const Pixel_FFFF backColor, vImage_Flags flags ) VIMAGE_NON_NULL(1,2) __OSX_AVAILABLE_STARTING( __MAC_10_8, __IPHONE_6_0 );
vImage_Error
vImageHorizontalShear_CbCr8(
	const vImage_Buffer *src,
	const vImage_Buffer *dest,
	vImagePixelCount srcOffsetToROI_X,
	vImagePixelCount srcOffsetToROI_Y,
	float xTranslate,
	float shearSlope,
	ResamplingFilter filter,
	const Pixel_88 backColor,
	vImage_Flags flags ) VIMAGE_NON_NULL(1,2)
    __OSX_AVAILABLE_STARTING( __MAC_10_12, __IPHONE_10_0 ) __WATCHOS_AVAILABLE(__WATCHOS_3_0) __TVOS_AVAILABLE(__TVOS_10_0);
vImage_Error
vImageHorizontalShear_CbCr16U(
	const vImage_Buffer *src,
	const vImage_Buffer *dest,
	vImagePixelCount srcOffsetToROI_X,
	vImagePixelCount srcOffsetToROI_Y,
	float xTranslate,
	float shearSlope,
	ResamplingFilter filter,
	const Pixel_16U16U backColor,
	vImage_Flags flags ) VIMAGE_NON_NULL(1,2)
    __OSX_AVAILABLE_STARTING( __MAC_10_12, __IPHONE_10_0 ) __WATCHOS_AVAILABLE(__WATCHOS_3_0) __TVOS_AVAILABLE(__TVOS_10_0);
vImage_Error
vImageVerticalShear_CbCr8(
	const vImage_Buffer *src,
	const vImage_Buffer *dest,
	vImagePixelCount srcOffsetToROI_X,
	vImagePixelCount srcOffsetToROI_Y,
	float yTranslate,
	float shearSlope,
	ResamplingFilter filter,
	const Pixel_88 backColor,
	vImage_Flags flags ) VIMAGE_NON_NULL(1,2)
    __OSX_AVAILABLE_STARTING( __MAC_10_12, __IPHONE_10_0 ) __WATCHOS_AVAILABLE(__WATCHOS_3_0) __TVOS_AVAILABLE(__TVOS_10_0);
vImage_Error
vImageVerticalShear_CbCr16U(
	const vImage_Buffer *src,
	const vImage_Buffer *dest,
	vImagePixelCount srcOffsetToROI_X,
	vImagePixelCount srcOffsetToROI_Y,
	float yTranslate,
	float shearSlope,
	ResamplingFilter filter,
	const Pixel_16U16U backColor,
	vImage_Flags flags ) VIMAGE_NON_NULL(1,2)
    __OSX_AVAILABLE_STARTING( __MAC_10_12, __IPHONE_10_0 ) __WATCHOS_AVAILABLE(__WATCHOS_3_0) __TVOS_AVAILABLE(__TVOS_10_0);
vImage_Error
vImageHorizontalShear_XRGB2101010W(
	const vImage_Buffer *src,
	const vImage_Buffer *dest,
	vImagePixelCount srcOffsetToROI_X,
	vImagePixelCount srcOffsetToROI_Y,
	float xTranslate,
	float shearSlope,
	ResamplingFilter filter,
	const Pixel_32U backColor,
	vImage_Flags flags ) VIMAGE_NON_NULL(1,2)
    __OSX_AVAILABLE_STARTING( __MAC_10_12, __IPHONE_10_0 ) __WATCHOS_AVAILABLE(__WATCHOS_3_0) __TVOS_AVAILABLE(__TVOS_10_0);
vImage_Error
vImageVerticalShear_XRGB2101010W(
	const vImage_Buffer *src,
	const vImage_Buffer *dest,
	vImagePixelCount srcOffsetToROI_X,
	vImagePixelCount srcOffsetToROI_Y,
	float yTranslate,
	float shearSlope,
	ResamplingFilter filter,
	const Pixel_32U backColor,
	vImage_Flags flags ) VIMAGE_NON_NULL(1,2)
    __OSX_AVAILABLE_STARTING( __MAC_10_12, __IPHONE_10_0 ) __WATCHOS_AVAILABLE(__WATCHOS_3_0) __TVOS_AVAILABLE(__TVOS_10_0);
ResamplingFilter	vImageNewResamplingFilter( float scale, vImage_Flags flags )    __OSX_AVAILABLE_STARTING( __MAC_10_3, __IPHONE_5_0 );
void			vImageDestroyResamplingFilter( ResamplingFilter filter )    __OSX_AVAILABLE_STARTING( __MAC_10_3, __IPHONE_5_0 );
vImage_Error	vImageNewResamplingFilterForFunctionUsingBuffer( ResamplingFilter filter, 
                                                        float scale, 
                                                        void (*kernelFunc)( const float *xArray, float *yArray, unsigned long count, void *userData ), 
                                                        float kernelWidth, 
                                                        void *userData,
                                                        vImage_Flags flags ) VIMAGE_NON_NULL(1) __OSX_AVAILABLE_STARTING( __MAC_10_3, __IPHONE_5_0 );
size_t		vImageGetResamplingFilterSize(  float scale, 
                                                void (*kernelFunc)( const float *xArray, float *yArray, unsigned long count, void *userData ),
                                                float kernelWidth, 
                                                vImage_Flags flags ) __OSX_AVAILABLE_STARTING( __MAC_10_3, __IPHONE_5_0 );
vImagePixelCount    vImageGetResamplingFilterExtent( ResamplingFilter filter, vImage_Flags flags )  VIMAGE_NON_NULL(1)  __OSX_AVAILABLE_STARTING( __MAC_10_9, __IPHONE_7_0 );
#ifdef __cplusplus
}
#endif
#endif
