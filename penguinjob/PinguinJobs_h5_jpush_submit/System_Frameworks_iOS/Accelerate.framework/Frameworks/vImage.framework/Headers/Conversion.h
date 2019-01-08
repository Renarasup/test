#ifndef VIMAGE_CONVERSION_H
#define VIMAGE_CONVERSION_H
#include <vImage/vImage_Types.h>
#ifdef __cplusplus
extern "C" {
#endif
vImage_Error vImageClip_PlanarF(const vImage_Buffer* src, const vImage_Buffer* dest, Pixel_F maxFloat, Pixel_F minFloat, vImage_Flags flags)  VIMAGE_NON_NULL(1,2)   __OSX_AVAILABLE_STARTING( __MAC_10_3, __IPHONE_5_0 );
vImage_Error vImageConvert_Planar8toPlanarF(const vImage_Buffer *src, const vImage_Buffer *dest, Pixel_F maxFloat, Pixel_F minFloat, vImage_Flags flags) VIMAGE_NON_NULL(1,2)    __OSX_AVAILABLE_STARTING( __MAC_10_3, __IPHONE_5_0 );
vImage_Error vImageConvert_PlanarFtoPlanar8(const vImage_Buffer *src, const vImage_Buffer *dest, Pixel_F maxFloat, Pixel_F minFloat, vImage_Flags flags) VIMAGE_NON_NULL(1,2)    __OSX_AVAILABLE_STARTING( __MAC_10_3, __IPHONE_5_0 );
vImage_Error vImageConvert_PlanarFtoPlanar8_dithered(const vImage_Buffer *src, const vImage_Buffer *dest, Pixel_F maxFloat, Pixel_F minFloat, int dither, vImage_Flags flags) VIMAGE_NON_NULL(1,2)    __OSX_AVAILABLE_STARTING( __MAC_10_10, __IPHONE_8_0 );
vImage_Error vImageConvert_RGBFFFtoRGB888_dithered(const vImage_Buffer *src, const vImage_Buffer *dest, const Pixel_F maxFloat[3], const Pixel_F minFloat[3], int dither, vImage_Flags flags) VIMAGE_NON_NULL(1,2,3,4)    __OSX_AVAILABLE_STARTING( __MAC_10_10, __IPHONE_8_0 );
vImage_Error vImageConvert_ARGBFFFFtoARGB8888_dithered(const vImage_Buffer *src, const vImage_Buffer *dest, const Pixel_FFFF maxFloat, const Pixel_FFFF minFloat, int dither, const uint8_t permuteMap[4], vImage_Flags flags) VIMAGE_NON_NULL(1,2,3,4)    __OSX_AVAILABLE_STARTING( __MAC_10_10, __IPHONE_8_0 );
vImage_Error vImageConvert_Planar8toARGB8888(const vImage_Buffer *srcA, const vImage_Buffer *srcR, const vImage_Buffer *srcG, const vImage_Buffer *srcB, const vImage_Buffer *dest, vImage_Flags flags) VIMAGE_NON_NULL(1,2,3,4,5)    __OSX_AVAILABLE_STARTING( __MAC_10_3, __IPHONE_5_0 );
vImage_Error vImageConvert_PlanarFtoARGBFFFF(const vImage_Buffer *srcA, const vImage_Buffer *srcR, const vImage_Buffer *srcG, const vImage_Buffer *srcB, const vImage_Buffer *dest, vImage_Flags flags) VIMAGE_NON_NULL(1,2,3,4,5)    __OSX_AVAILABLE_STARTING( __MAC_10_3, __IPHONE_5_0 );
vImage_Error vImageConvert_ARGB8888toPlanar8(const vImage_Buffer *srcARGB, const vImage_Buffer *destA, const vImage_Buffer *destR, const vImage_Buffer *destG, const vImage_Buffer *destB, vImage_Flags flags) VIMAGE_NON_NULL(1,2,3,4,5)   __OSX_AVAILABLE_STARTING( __MAC_10_3, __IPHONE_5_0 );
#define vImageConvert_RGBA8888toPlanar8(_src, _red, _green, _blue, _alpha, _flags) \
    vImageConvert_ARGB8888toPlanar8((_src), (_red), (_green), (_blue), (_alpha), (_flags))
#define vImageConvert_BGRA8888toPlanar8(_src, _blue, _green, _red, _alpha, _flags) \
    vImageConvert_ARGB8888toPlanar8((_src), (_blue), (_green), (_red), (_alpha), (_flags))
vImage_Error vImageConvert_ARGBFFFFtoPlanarF(const vImage_Buffer *srcARGB, const vImage_Buffer *destA, const vImage_Buffer *destR, const vImage_Buffer *destG, const vImage_Buffer *destB, vImage_Flags flags) VIMAGE_NON_NULL(1,2,3,4,5) __OSX_AVAILABLE_STARTING( __MAC_10_3, __IPHONE_5_0 );
#define vImageConvert_RGBAFFFFtoPlanarF(_src, _red, _green, _blue, _alpha, _flags) \
    vImageConvert_ARGBFFFFtoPlanarF((_src), (_red), (_green), (_blue), (_alpha), (_flags))
#define vImageConvert_BGRAFFFFtoPlanarF(_src, _blue, _green, _red, _alpha, _flags) \
    vImageConvert_ARGBFFFFtoPlanarF((_src), (_blue), (_green), (_red), (_alpha), (_flags))
vImage_Error vImageConvert_ChunkyToPlanar8( const void *srcChannels[], const vImage_Buffer *destPlanarBuffers[], unsigned int channelCount, size_t srcStrideBytes, vImagePixelCount srcWidth, vImagePixelCount srcHeight, size_t srcRowBytes, vImage_Flags flags ) VIMAGE_NON_NULL(1,2)    __OSX_AVAILABLE_STARTING( __MAC_10_3, __IPHONE_5_0 );
vImage_Error vImageConvert_PlanarToChunky8( const vImage_Buffer *srcPlanarBuffers[], void *destChannels[], unsigned int channelCount, size_t destStrideBytes, vImagePixelCount destWidth, vImagePixelCount destHeight, size_t destRowBytes, vImage_Flags flags ) VIMAGE_NON_NULL(1,2)    __OSX_AVAILABLE_STARTING( __MAC_10_3, __IPHONE_5_0 );
vImage_Error vImageConvert_ChunkyToPlanarF( const void *srcChannels[], const vImage_Buffer *destPlanarBuffers[], unsigned int channelCount, size_t srcStrideBytes, vImagePixelCount srcWidth, vImagePixelCount srcHeight, size_t srcRowBytes, vImage_Flags flags ) VIMAGE_NON_NULL(1,2)    __OSX_AVAILABLE_STARTING( __MAC_10_3, __IPHONE_5_0 );
vImage_Error vImageConvert_PlanarToChunkyF( const vImage_Buffer *srcPlanarBuffers[], void *destChannels[], unsigned int channelCount, size_t destStrideBytes, vImagePixelCount destWidth, vImagePixelCount destHeight, size_t destRowBytes, vImage_Flags flags ) VIMAGE_NON_NULL(1,2)    __OSX_AVAILABLE_STARTING( __MAC_10_3, __IPHONE_5_0 );
vImage_Error vImageConvert_16SToF( const vImage_Buffer *src, const vImage_Buffer *dest, float offset, float scale, vImage_Flags flags ) VIMAGE_NON_NULL(1,2)    __OSX_AVAILABLE_STARTING( __MAC_10_3, __IPHONE_5_0 );
vImage_Error vImageConvert_16UToF( const vImage_Buffer *src, const vImage_Buffer *dest, float offset, float scale, vImage_Flags flags ) VIMAGE_NON_NULL(1,2)    __OSX_AVAILABLE_STARTING( __MAC_10_3, __IPHONE_5_0 );
vImage_Error vImageConvert_FTo16S( const vImage_Buffer *src, const vImage_Buffer *dest, float offset, float scale, vImage_Flags flags ) VIMAGE_NON_NULL(1,2)    __OSX_AVAILABLE_STARTING( __MAC_10_3, __IPHONE_5_0 );
vImage_Error vImageConvert_FTo16U( const vImage_Buffer *src, const vImage_Buffer *dest, float offset, float scale, vImage_Flags flags ) VIMAGE_NON_NULL(1,2)    __OSX_AVAILABLE_STARTING( __MAC_10_3, __IPHONE_5_0 );
vImage_Error vImageConvert_16Uto16F( const vImage_Buffer *src, const vImage_Buffer *dest, vImage_Flags flags )
    VIMAGE_NON_NULL(1,2)  __OSX_AVAILABLE_STARTING( __MAC_10_9, __IPHONE_7_0 );
vImage_Error vImageConvert_16Fto16U( const vImage_Buffer *src, const vImage_Buffer *dest, vImage_Flags flags )
    VIMAGE_NON_NULL(1,2)  __OSX_AVAILABLE_STARTING( __MAC_10_9, __IPHONE_7_0 );
vImage_Error vImageConvert_12UTo16U( const vImage_Buffer *src, const vImage_Buffer *dest, vImage_Flags flags ) VIMAGE_NON_NULL(1,2) __OSX_AVAILABLE_STARTING(__MAC_10_9, __IPHONE_7_0);
vImage_Error vImageConvert_16UTo12U( const vImage_Buffer *src, const vImage_Buffer *dest, vImage_Flags flags ) VIMAGE_NON_NULL(1,2) __OSX_AVAILABLE_STARTING(__MAC_10_9, __IPHONE_7_0);
vImage_Error vImageTableLookUp_ARGB8888(const vImage_Buffer *src, const vImage_Buffer *dest, const Pixel_8 alphaTable[256], const Pixel_8 redTable[256], const  Pixel_8 greenTable[256], const  Pixel_8 blueTable[256], vImage_Flags flags) VIMAGE_NON_NULL(1,2)    __OSX_AVAILABLE_STARTING( __MAC_10_3, __IPHONE_5_0 );
vImage_Error vImageTableLookUp_Planar8(const vImage_Buffer *src, const vImage_Buffer *dest, const Pixel_8 table[256], vImage_Flags flags)  VIMAGE_NON_NULL(1,2,3)   __OSX_AVAILABLE_STARTING( __MAC_10_3, __IPHONE_5_0 );
vImage_Error vImageOverwriteChannels_ARGB8888(	const vImage_Buffer *newSrc,       
                                                const vImage_Buffer *origSrc,      
                                                const vImage_Buffer *dest,      
                                                uint8_t copyMask,                
                                                vImage_Flags    flags ) VIMAGE_NON_NULL(1,2,3)		__OSX_AVAILABLE_STARTING( __MAC_10_4, __IPHONE_5_0 );
vImage_Error vImageOverwriteChannels_ARGBFFFF(	const vImage_Buffer *newSrc,       
                                                const vImage_Buffer *origSrc,      
                                                const vImage_Buffer *dest,      
                                                uint8_t copyMask,                
                                                vImage_Flags    flags ) VIMAGE_NON_NULL(1,2,3)		__OSX_AVAILABLE_STARTING( __MAC_10_4, __IPHONE_5_0 );
vImage_Error vImageOverwriteChannelsWithScalar_Planar8(	Pixel_8     scalar,
                                                        const vImage_Buffer *dest,      
                                                        vImage_Flags    flags ) VIMAGE_NON_NULL(2)		__OSX_AVAILABLE_STARTING( __MAC_10_4, __IPHONE_5_0 );
vImage_Error vImageOverwriteChannelsWithScalar_PlanarF( Pixel_F     scalar,
                                                        const vImage_Buffer *dest,      
                                                        vImage_Flags    flags ) VIMAGE_NON_NULL(2)		__OSX_AVAILABLE_STARTING( __MAC_10_4, __IPHONE_5_0 );
vImage_Error vImageOverwriteChannelsWithScalar_Planar16S(	Pixel_16S     scalar,
                                                        const vImage_Buffer *dest,      
                                                        vImage_Flags    flags ) VIMAGE_NON_NULL(2)		__OSX_AVAILABLE_STARTING( __MAC_10_10, __IPHONE_8_0 );
vImage_Error vImageOverwriteChannelsWithScalar_Planar16U(	Pixel_16U     scalar,
                                                             const vImage_Buffer *dest,      
                                                             vImage_Flags    flags ) VIMAGE_NON_NULL(2)		__OSX_AVAILABLE_STARTING( __MAC_10_10, __IPHONE_8_0 );
vImage_Error vImageExtractChannel_ARGB8888( const vImage_Buffer *src, const vImage_Buffer *dest, long channelIndex, vImage_Flags flags ) VIMAGE_NON_NULL(1,2) __OSX_AVAILABLE_STARTING( __MAC_10_10, __IPHONE_8_0 );
vImage_Error vImageExtractChannel_ARGB16U( const vImage_Buffer *src, const vImage_Buffer *dest, long channelIndex, vImage_Flags flags ) VIMAGE_NON_NULL(1,2) __OSX_AVAILABLE_STARTING( __MAC_10_10, __IPHONE_8_0 );
vImage_Error vImageExtractChannel_ARGBFFFF( const vImage_Buffer *src, const vImage_Buffer *dest, long channelIndex, vImage_Flags flags ) VIMAGE_NON_NULL(1,2) __OSX_AVAILABLE_STARTING( __MAC_10_10, __IPHONE_8_0 );
vImage_Error vImageBufferFill_ARGB8888( const vImage_Buffer *dest, const Pixel_8888 color, vImage_Flags flags ) VIMAGE_NON_NULL(1,2) __OSX_AVAILABLE_STARTING( __MAC_10_4, __IPHONE_5_0 );
vImage_Error vImageBufferFill_ARGB16U( const vImage_Buffer *dest, const Pixel_ARGB_16U color, vImage_Flags flags ) VIMAGE_NON_NULL(1,2) __OSX_AVAILABLE_STARTING( __MAC_10_9, __IPHONE_7_0 );
vImage_Error vImageBufferFill_ARGB16S( const vImage_Buffer *dest, const Pixel_ARGB_16S color, vImage_Flags flags ) VIMAGE_NON_NULL(1,2) __OSX_AVAILABLE_STARTING( __MAC_10_9, __IPHONE_7_0 );
vImage_Error vImageBufferFill_ARGBFFFF( const vImage_Buffer *dest, const Pixel_FFFF color, vImage_Flags flags ) VIMAGE_NON_NULL(1,2) __OSX_AVAILABLE_STARTING( __MAC_10_4, __IPHONE_5_0 );
vImage_Error
vImageBufferFill_CbCr8(
	const vImage_Buffer *dest,
	const Pixel_88 color,
	vImage_Flags flags ) VIMAGE_NON_NULL(1,2)
    __OSX_AVAILABLE_STARTING( __MAC_10_12, __IPHONE_10_0 ) __WATCHOS_AVAILABLE(__WATCHOS_3_0) __TVOS_AVAILABLE(__TVOS_10_0);
vImage_Error
vImageBufferFill_CbCr16U(
	const vImage_Buffer *dest,
	const Pixel_16U16U color,
	vImage_Flags flags ) VIMAGE_NON_NULL(1,2)
    __OSX_AVAILABLE_STARTING( __MAC_10_12, __IPHONE_10_0 ) __WATCHOS_AVAILABLE(__WATCHOS_3_0) __TVOS_AVAILABLE(__TVOS_10_0);
vImage_Error vImageOverwriteChannelsWithScalar_ARGB8888(	Pixel_8     scalar,
                                                                const vImage_Buffer *src,      
                                                                const vImage_Buffer *dest,      
                                                                uint8_t copyMask,                
                                                                vImage_Flags    flags ) VIMAGE_NON_NULL(2,3)		__OSX_AVAILABLE_STARTING( __MAC_10_4, __IPHONE_5_0 );
vImage_Error vImageOverwriteChannelsWithScalar_ARGBFFFF(	Pixel_F     scalar,
                                                                const vImage_Buffer *src,      
                                                                const vImage_Buffer *dest,      
                                                                uint8_t copyMask,                
                                                                vImage_Flags    flags ) VIMAGE_NON_NULL(2,3)		__OSX_AVAILABLE_STARTING( __MAC_10_4, __IPHONE_5_0 );
vImage_Error vImagePermuteChannels_ARGB8888(    const vImage_Buffer *src,
                                                const vImage_Buffer *dest,
                                                const uint8_t       permuteMap[4],
                                                vImage_Flags        flags )	VIMAGE_NON_NULL(1,2,3)	__OSX_AVAILABLE_STARTING( __MAC_10_4, __IPHONE_5_0 );
vImage_Error vImagePermuteChannels_ARGB16U(     const vImage_Buffer *src,
                                                const vImage_Buffer *dest,
                                                const uint8_t       permuteMap[4],
                                                vImage_Flags        flags )
    											VIMAGE_NON_NULL(1,2,3)
    											__OSX_AVAILABLE_STARTING( __MAC_10_9, __IPHONE_7_0 );
vImage_Error vImagePermuteChannels_ARGBFFFF(    const vImage_Buffer *src,
                                                const vImage_Buffer *dest,
                                                const uint8_t       permuteMap[4],
                                                vImage_Flags        flags )	VIMAGE_NON_NULL(1,2,3)		__OSX_AVAILABLE_STARTING( __MAC_10_4, __IPHONE_5_0 );
vImage_Error vImagePermuteChannelsWithMaskedInsert_ARGB8888(    const vImage_Buffer *src,
                                                                const vImage_Buffer *dest,
                                                                const uint8_t permuteMap[4],
                                                                uint8_t copyMask, 
                                                                const Pixel_8888 backgroundColor,
                                                                vImage_Flags flags ) VIMAGE_NON_NULL(1,2,3,5) __OSX_AVAILABLE_STARTING( __MAC_10_9, __IPHONE_7_0);
vImage_Error vImagePermuteChannelsWithMaskedInsert_ARGB16U(const vImage_Buffer *src,
                                                           const vImage_Buffer *dest,
                                                           const uint8_t permuteMap[4],
                                                           uint8_t copyMask,
                                                           const Pixel_ARGB_16U backgroundColor,
                                                           vImage_Flags flags ) VIMAGE_NON_NULL(1,2,3,5) __OSX_AVAILABLE_STARTING( __MAC_10_9, __IPHONE_7_0);
vImage_Error vImagePermuteChannelsWithMaskedInsert_ARGBFFFF(    const vImage_Buffer *src,
                                                                const vImage_Buffer *dest,
                                                                const uint8_t permuteMap[4],
                                                                uint8_t copyMask, 
                                                                const Pixel_FFFF backgroundColor,
                                                                vImage_Flags flags ) VIMAGE_NON_NULL(1,2,3,5) __OSX_AVAILABLE_STARTING( __MAC_10_9, __IPHONE_7_0);
vImage_Error    vImageConvert_ARGB8888toPlanarF(
    const vImage_Buffer *src,
    const vImage_Buffer *alpha,
    const vImage_Buffer *red,
    const vImage_Buffer *green,
    const vImage_Buffer *blue,
    const Pixel_FFFF maxFloat,
    const Pixel_FFFF minFloat,
    vImage_Flags flags ) __OSX_AVAILABLE_STARTING( __MAC_10_9, __IPHONE_7_0 );
vImage_Error    vImageConvert_ARGBFFFFtoPlanar8(
    const vImage_Buffer *src,
    const vImage_Buffer *alpha,
    const vImage_Buffer *red,
    const vImage_Buffer *green,
    const vImage_Buffer *blue,
    const Pixel_FFFF maxFloat,
    const Pixel_FFFF minFloat,
    vImage_Flags flags ) __OSX_AVAILABLE_STARTING( __MAC_10_9, __IPHONE_7_0 );
vImage_Error    vImageConvert_ARGBFFFFtoRGBFFF(
    const vImage_Buffer *src,
    const vImage_Buffer *dest,
    vImage_Flags flags ) __OSX_AVAILABLE_STARTING( __MAC_10_9, __IPHONE_7_0 );
vImage_Error    vImageConvert_RGBAFFFFtoRGBFFF(
    const vImage_Buffer *src,
    const vImage_Buffer *dest,
    vImage_Flags flags ) __OSX_AVAILABLE_STARTING( __MAC_10_9, __IPHONE_7_0 );
vImage_Error    vImageConvert_BGRAFFFFtoRGBFFF(
    const vImage_Buffer *src,
    const vImage_Buffer *dest,
    vImage_Flags flags ) __OSX_AVAILABLE_STARTING( __MAC_10_9, __IPHONE_7_0 );
vImage_Error
vImageConvert_RGBFFFtoARGBFFFF(
                               const vImage_Buffer* ,
                               const vImage_Buffer* ,
                               Pixel_F              ,
                               const vImage_Buffer* ,
                               bool                 ,  
                               vImage_Flags flags ) VIMAGE_NON_NULL(1,4) __OSX_AVAILABLE_STARTING( __MAC_10_9, __IPHONE_7_0 );
vImage_Error
vImageConvert_RGBFFFtoRGBAFFFF(
                               const vImage_Buffer* ,
                               const vImage_Buffer* ,
                               Pixel_F              ,
                               const vImage_Buffer* ,
                               bool                 ,  
                               vImage_Flags flags ) VIMAGE_NON_NULL(1,4) __OSX_AVAILABLE_STARTING( __MAC_10_9, __IPHONE_7_0 );
vImage_Error 
vImageConvert_RGBFFFtoBGRAFFFF(
    const vImage_Buffer* , 
    const vImage_Buffer* ,
    Pixel_F              ,
    const vImage_Buffer* ,
    bool                 ,  
    vImage_Flags flags ) VIMAGE_NON_NULL(1,4) __OSX_AVAILABLE_STARTING( __MAC_10_9, __IPHONE_7_0 );
#define vImageConvert_BGRFFFtoBGRAFFFF( _bgrSrc, _aSrc, _alpha, _bgraDest, _premultiply, _flags )   \
    vImageConvert_RGBFFFtoRGBAFFFF((_bgrSrc), (_aSrc), (_alpha), (_bgraDest), (_premultiply), (_flags) )
#define vImageConvert_BGRFFFtoRGBAFFFF( _bgrSrc, _aSrc, _alpha, _rgbaDest, _premultiply, _flags )   \
    vImageConvert_RGBFFFtoBGRAFFFF((_bgrSrc), (_aSrc), (_alpha), (_rgbaDest), (_premultiply), (_flags) )
vImage_Error    vImageConvert_ARGB1555toPlanar8( const vImage_Buffer *src, const vImage_Buffer *destA, const vImage_Buffer *destR, const vImage_Buffer *destG, const vImage_Buffer *destB, vImage_Flags flags )	VIMAGE_NON_NULL(1,2,3,4,5)  __OSX_AVAILABLE_STARTING( __MAC_10_4, __IPHONE_5_0 );
vImage_Error    vImageConvert_ARGB1555toARGB8888( const vImage_Buffer *src, const vImage_Buffer *dest, vImage_Flags flags ) VIMAGE_NON_NULL(1,2)  __OSX_AVAILABLE_STARTING( __MAC_10_4, __IPHONE_5_0 );
vImage_Error    vImageConvert_Planar8toARGB1555( const vImage_Buffer *srcA, const vImage_Buffer *srcR, const vImage_Buffer *srcG, const vImage_Buffer *srcB, const vImage_Buffer *dest, vImage_Flags flags )	VIMAGE_NON_NULL(1,2,3,4,5)  __OSX_AVAILABLE_STARTING( __MAC_10_4, __IPHONE_5_0 );
vImage_Error    vImageConvert_ARGB8888toARGB1555( const vImage_Buffer *src, const vImage_Buffer *dest, vImage_Flags flags ) VIMAGE_NON_NULL(1,2)  __OSX_AVAILABLE_STARTING( __MAC_10_4, __IPHONE_5_0 );
vImage_Error    vImageConvert_RGBA5551toRGBA8888( const vImage_Buffer *src, const vImage_Buffer *dest, vImage_Flags flags ) VIMAGE_NON_NULL(1,2)  __OSX_AVAILABLE_STARTING( __MAC_10_9, __IPHONE_7_0 );
#define         vImageConvert_BGRA5551toBGRA8888( _src, _dest, _flags)  vImageConvert_RGBA5551toRGBA8888( _src, _dest, _flags )
vImage_Error    vImageConvert_RGBA8888toRGBA5551( const vImage_Buffer *src, const vImage_Buffer *dest, vImage_Flags flags ) VIMAGE_NON_NULL(1,2)  __OSX_AVAILABLE_STARTING( __MAC_10_9, __IPHONE_7_0 );
#define         vImageConvert_BGRA8888toBGRA5551( _src, _dest, _flags)  vImageConvert_RGBA8888toRGBA5551( _src, _dest, _flags )
vImage_Error vImageConvert_ARGB8888toARGB1555_dithered(const vImage_Buffer *src, const vImage_Buffer *dest, void *tempBuffer, int dither, const vImage_Flags flags) VIMAGE_NON_NULL(1,2) __OSX_AVAILABLE_STARTING(__MAC_10_9, __IPHONE_7_0);
vImage_Error vImageConvert_RGBA8888toRGBA5551_dithered(const vImage_Buffer *src, const vImage_Buffer *dest, void *tempBuffer, int dither, const vImage_Flags flags) VIMAGE_NON_NULL(1,2) __OSX_AVAILABLE_STARTING(__MAC_10_9, __IPHONE_7_0);
#define      vImageConvert_BGRA8888toBGRA5551_dithered( _src, _dest, _tempBuffer, _dither, _flags)  vImageConvert_RGBA8888toRGBA5551_dithered( _src, _dest, _tempBuffer, _dither, _flags )
vImage_Error vImageConvert_RGB565toARGB8888(Pixel_8 alpha, const vImage_Buffer *src, const vImage_Buffer *dest, vImage_Flags flags) VIMAGE_NON_NULL(2,3) __OSX_AVAILABLE_STARTING(__MAC_10_4, __IPHONE_5_0);
vImage_Error vImageConvert_RGB565toRGBA8888(Pixel_8 alpha, const vImage_Buffer *src, const vImage_Buffer *dest, vImage_Flags flags) VIMAGE_NON_NULL(2,3) __OSX_AVAILABLE_STARTING(__MAC_10_9, __IPHONE_7_0);
vImage_Error vImageConvert_RGB565toBGRA8888(Pixel_8 alpha, const vImage_Buffer *src, const vImage_Buffer *dest, vImage_Flags flags) VIMAGE_NON_NULL(2,3) __OSX_AVAILABLE_STARTING(__MAC_10_9, __IPHONE_7_0);
vImage_Error vImageConvert_RGB565toRGB888( const vImage_Buffer *src, const vImage_Buffer *dest, vImage_Flags flags )  VIMAGE_NON_NULL(1,2) __OSX_AVAILABLE_STARTING(__MAC_10_10, __IPHONE_8_0);
vImage_Error vImageConvert_ARGB8888toRGB565(const vImage_Buffer *src, const vImage_Buffer *dest, vImage_Flags flags) VIMAGE_NON_NULL(1,2) __OSX_AVAILABLE_STARTING(__MAC_10_4, __IPHONE_5_0);
vImage_Error vImageConvert_RGBA8888toRGB565(const vImage_Buffer *src, const vImage_Buffer *dest, vImage_Flags flags) VIMAGE_NON_NULL(1,2) __OSX_AVAILABLE_STARTING(__MAC_10_9, __IPHONE_7_0);
vImage_Error vImageConvert_BGRA8888toRGB565(const vImage_Buffer *src, const vImage_Buffer *dest, vImage_Flags flags) VIMAGE_NON_NULL(1,2) __OSX_AVAILABLE_STARTING(__MAC_10_9, __IPHONE_7_0);
vImage_Error vImageConvert_RGB888toRGB565_dithered(const vImage_Buffer *src, const vImage_Buffer *dest, void *tempBuffer, int dither, const vImage_Flags flags) VIMAGE_NON_NULL(1,2) __OSX_AVAILABLE_STARTING(__MAC_10_9, __IPHONE_7_0);
vImage_Error vImageConvert_ARGB8888toRGB565_dithered(const vImage_Buffer *src, const vImage_Buffer *dest, void *tempBuffer, int dither, const vImage_Flags flags) VIMAGE_NON_NULL(1,2) __OSX_AVAILABLE_STARTING(__MAC_10_9, __IPHONE_7_0);
vImage_Error vImageConvert_RGBA8888toRGB565_dithered(const vImage_Buffer *src, const vImage_Buffer *dest, void *tempBuffer, int dither, const vImage_Flags flags) VIMAGE_NON_NULL(1,2) __OSX_AVAILABLE_STARTING(__MAC_10_9, __IPHONE_7_0);
vImage_Error vImageConvert_BGRA8888toRGB565_dithered(const vImage_Buffer *src, const vImage_Buffer *dest, void *tempBuffer, int dither, const vImage_Flags flags) VIMAGE_NON_NULL(1,2) __OSX_AVAILABLE_STARTING(__MAC_10_9, __IPHONE_7_0);
vImage_Error vImageConvert_RGB565toPlanar8(const vImage_Buffer *src, const vImage_Buffer *destR, const vImage_Buffer *destG, const vImage_Buffer *destB, vImage_Flags flags) VIMAGE_NON_NULL(1,2,3,4) __OSX_AVAILABLE_STARTING(__MAC_10_4, __IPHONE_5_0);
vImage_Error vImageConvert_Planar8toRGB565(const vImage_Buffer *srcR, const vImage_Buffer *srcG, const vImage_Buffer *srcB, const vImage_Buffer *dest, vImage_Flags flags) VIMAGE_NON_NULL(1,2,3,4) __OSX_AVAILABLE_STARTING(__MAC_10_4, __IPHONE_5_0);
vImage_Error vImageConvert_RGBA5551toRGB565( const vImage_Buffer *src, const vImage_Buffer *dest, vImage_Flags flags ) VIMAGE_NON_NULL(1,2) __OSX_AVAILABLE_STARTING(__MAC_10_10, __IPHONE_8_0);
vImage_Error vImageConvert_ARGB1555toRGB565( const vImage_Buffer *src, const vImage_Buffer *dest, vImage_Flags flags ) VIMAGE_NON_NULL(1,2) __OSX_AVAILABLE_STARTING(__MAC_10_10, __IPHONE_8_0);
vImage_Error vImageConvert_RGB565toRGBA5551( const vImage_Buffer *src, const vImage_Buffer *dest, int dither, vImage_Flags flags ) VIMAGE_NON_NULL(1,2) __OSX_AVAILABLE_STARTING(__MAC_10_10, __IPHONE_8_0);
vImage_Error vImageConvert_RGB565toARGB1555( const vImage_Buffer *src, const vImage_Buffer *dest, int dither, vImage_Flags flags ) VIMAGE_NON_NULL(1,2) __OSX_AVAILABLE_STARTING(__MAC_10_10, __IPHONE_8_0);
vImage_Error    vImageConvert_Planar16FtoPlanarF( const vImage_Buffer *src, const vImage_Buffer *dest, vImage_Flags flags ) VIMAGE_NON_NULL(1,2)  __OSX_AVAILABLE_STARTING( __MAC_10_4, __IPHONE_5_0 );
vImage_Error    vImageConvert_PlanarFtoPlanar16F( const vImage_Buffer *src, const vImage_Buffer *dest, vImage_Flags flags ) VIMAGE_NON_NULL(1,2)  __OSX_AVAILABLE_STARTING( __MAC_10_4, __IPHONE_5_0 );
vImage_Error
vImageConvert_Planar8toPlanar16F(
    const vImage_Buffer *src,
    const vImage_Buffer *dest,
    vImage_Flags flags ) VIMAGE_NON_NULL(1,2)  __OSX_AVAILABLE_STARTING( __MAC_10_9, __IPHONE_7_0 );
vImage_Error
vImageConvert_Planar16FtoPlanar8(
    const vImage_Buffer *src,
    const vImage_Buffer *dest,
    vImage_Flags flags ) VIMAGE_NON_NULL(1,2)  __OSX_AVAILABLE_STARTING( __MAC_10_9, __IPHONE_7_0 );
vImage_Error vImageConvert_16UToPlanar8( const vImage_Buffer *src, const vImage_Buffer *dest, vImage_Flags flags ) VIMAGE_NON_NULL(1,2)    __OSX_AVAILABLE_STARTING( __MAC_10_4, __IPHONE_5_0 );
vImage_Error vImageConvert_Planar8To16U( const vImage_Buffer *src, const vImage_Buffer *dest, vImage_Flags flags ) VIMAGE_NON_NULL(1,2)    __OSX_AVAILABLE_STARTING( __MAC_10_4, __IPHONE_5_0 );
 vImage_Error vImageConvert_RGB888toARGB8888(   const vImage_Buffer* , 
                                                const vImage_Buffer* , 
                                                Pixel_8 , 
                                                const vImage_Buffer* , 
                                                bool ,   
                                                vImage_Flags  ) VIMAGE_NON_NULL(1,4) __OSX_AVAILABLE_STARTING( __MAC_10_4, __IPHONE_5_0 );
vImage_Error vImageConvert_RGB888toRGBA8888(    const vImage_Buffer * , 
                                                const vImage_Buffer * , 
                                                Pixel_8 , 
                                                const vImage_Buffer * , 
                                                bool ,   
                                                vImage_Flags  ) VIMAGE_NON_NULL(1,4) __OSX_AVAILABLE_STARTING( __MAC_10_8, __IPHONE_6_0 );
vImage_Error vImageConvert_RGB888toBGRA8888(    const vImage_Buffer * ,
                                                const vImage_Buffer * , 
                                                Pixel_8 , 
                                                const vImage_Buffer * , 
                                                bool ,   
                                                vImage_Flags  ) VIMAGE_NON_NULL(1,4) __OSX_AVAILABLE_STARTING( __MAC_10_8, __IPHONE_6_0 );
#define vImageConvert_BGR888toBGRA8888( _bgrSrc, _aSrc, _alpha, _bgraDest, _premultiply, _flags )   vImageConvert_RGB888toRGBA8888((_bgrSrc), (_aSrc), (_alpha), (_bgraDest), (_premultiply), (_flags) ) 
#define vImageConvert_BGR888toRGBA8888( _bgrSrc, _aSrc, _alpha, _rgbaDest, _premultiply, _flags )   vImageConvert_RGB888toBGRA8888((_bgrSrc), (_aSrc), (_alpha), (_rgbaDest), (_premultiply), (_flags) ) 
vImage_Error vImageConvert_ARGB8888toRGB888(    const vImage_Buffer * , 
                                                const vImage_Buffer * , 
                                                vImage_Flags  ) VIMAGE_NON_NULL(1,2) __OSX_AVAILABLE_STARTING( __MAC_10_4, __IPHONE_5_0 );
vImage_Error vImageConvert_RGBA8888toRGB888(    const vImage_Buffer * , 
                                                const vImage_Buffer * , 
                                                vImage_Flags  ) VIMAGE_NON_NULL(1,2) __OSX_AVAILABLE_STARTING( __MAC_10_9, __IPHONE_6_0 );
vImage_Error vImageConvert_BGRA8888toRGB888(    const vImage_Buffer * ,
                                                const vImage_Buffer * , 
                                                vImage_Flags  ) VIMAGE_NON_NULL(1,2) __OSX_AVAILABLE_STARTING( __MAC_10_9, __IPHONE_6_0 );
#define vImageConvert_RGBA8888toBGR888( _rgbaSrc, _bgrDest, _flags )    vImageConvert_BGRA8888toRGB888((_rgbaSrc), (_bgrDest), (_flags))
#define vImageConvert_BGRA8888toBGR888( _bgraSrc, _bgrDest, _flags )    vImageConvert_RGBA8888toRGB888((_bgraSrc), (_bgrDest), (_flags))
vImage_Error  vImageFlatten_ARGB8888ToRGB888( 
                                                const vImage_Buffer * , 
                                                const vImage_Buffer * , 
                                                const Pixel_8888   ,    
                                                bool      ,
                                                vImage_Flags     
                                            ) VIMAGE_NON_NULL(1,2,3) __OSX_AVAILABLE_STARTING( __MAC_10_4, __IPHONE_5_0 );
vImage_Error  vImageFlatten_ARGBFFFFToRGBFFF( 
                                                const vImage_Buffer * , 
                                                const vImage_Buffer * , 
                                                const Pixel_FFFF   ,    
                                                bool      ,
                                                vImage_Flags     
                                            ) VIMAGE_NON_NULL(1,2,3) __OSX_AVAILABLE_STARTING( __MAC_10_4, __IPHONE_5_0 );
vImage_Error  vImageFlatten_RGBA8888ToRGB888( 
                                             const vImage_Buffer * , 
                                             const vImage_Buffer * , 
                                             const Pixel_8888   ,    
                                             bool      ,
                                             vImage_Flags     
                                             ) VIMAGE_NON_NULL(1,2,3) __OSX_AVAILABLE_STARTING( __MAC_10_8, __IPHONE_6_0 );
vImage_Error  vImageFlatten_RGBAFFFFToRGBFFF( 
                                             const vImage_Buffer * , 
                                             const vImage_Buffer * , 
                                             const Pixel_FFFF   ,    
                                             bool      ,
                                             vImage_Flags     
                                             ) VIMAGE_NON_NULL(1,2,3) __OSX_AVAILABLE_STARTING( __MAC_10_8, __IPHONE_6_0 );
vImage_Error  vImageFlatten_BGRA8888ToRGB888( 
                                             const vImage_Buffer * , 
                                             const vImage_Buffer * , 
                                             const Pixel_8888   ,    
                                             bool      ,
                                             vImage_Flags     
                                             ) VIMAGE_NON_NULL(1,2,3) __OSX_AVAILABLE_STARTING( __MAC_10_8, __IPHONE_6_0 );
vImage_Error  vImageFlatten_BGRAFFFFToRGBFFF( 
                                             const vImage_Buffer * , 
                                             const vImage_Buffer * , 
                                             const Pixel_FFFF   ,    
                                             bool      ,
                                             vImage_Flags     
                                             ) VIMAGE_NON_NULL(1,2,3) __OSX_AVAILABLE_STARTING( __MAC_10_8, __IPHONE_6_0 );
#define vImageFlatten_BGRA8888ToBGR888( _bgra8888Src, _bgr888Dest, _backgroundColor, _isImagePremultiplied, _flags )        \
        vImageFlatten_RGBA8888ToRGB888( (_bgra8888Src), (_bgr888Dest), (_backgroundColor), (_isImagePremultiplied), (_flags) )
#define vImageFlatten_RGBA8888ToBGR888( _rgba8888Src, _bgr888Dest, _backgroundColor, _isImagePremultiplied, _flags )        \
        vImageFlatten_BGRA8888ToRGB888( (_rgba8888Src), (_bgr888Dest), (_backgroundColor), (_isImagePremultiplied), (_flags) )
#define vImageFlatten_BGRAFFFFToBGRFFF( _bgraFFFFSrc, _bgrFFFDest, _backgroundColor, _isImagePremultiplied, _flags )        \
        vImageFlatten_RGBAFFFFToRGBFFF( (_bgraFFFFSrc), (_bgrFFFDest), (_backgroundColor), (_isImagePremultiplied), (_flags) )
#define vImageFlatten_RGBAFFFFToBGRFFF( _rgbaFFFFSrc, _bgrFFFDest, _backgroundColor, _isImagePremultiplied, _flags )        \
        vImageFlatten_BGRAFFFFToRGBFFF( (_rgbaFFFFSrc), (_bgrFFFDest), (_backgroundColor), (_isImagePremultiplied), (_flags) )
vImage_Error vImageConvert_Planar8toRGB888( const vImage_Buffer *planarRed, const vImage_Buffer *planarGreen, const vImage_Buffer *planarBlue, const vImage_Buffer *rgbDest, vImage_Flags flags ) VIMAGE_NON_NULL(1,2,3,4) __OSX_AVAILABLE_STARTING( __MAC_10_4, __IPHONE_5_0 );
vImage_Error vImageConvert_PlanarFtoRGBFFF( const vImage_Buffer *planarRed, const vImage_Buffer *planarGreen, const vImage_Buffer *planarBlue, const vImage_Buffer *rgbDest, vImage_Flags flags ) VIMAGE_NON_NULL(1,2,3,4) __OSX_AVAILABLE_STARTING( __MAC_10_4, __IPHONE_5_0 );
vImage_Error vImageConvert_RGB888toPlanar8( const vImage_Buffer *rgbSrc, const vImage_Buffer *redDest, const vImage_Buffer *greenDest, const vImage_Buffer *blueDest, vImage_Flags flags ) VIMAGE_NON_NULL(1,2,3,4) __OSX_AVAILABLE_STARTING( __MAC_10_4, __IPHONE_5_0 );
vImage_Error vImageConvert_RGBFFFtoPlanarF( const vImage_Buffer *rgbSrc, const vImage_Buffer *redDest, const vImage_Buffer *greenDest, const vImage_Buffer *blueDest, vImage_Flags flags ) VIMAGE_NON_NULL(1,2,3,4) __OSX_AVAILABLE_STARTING( __MAC_10_4, __IPHONE_5_0 ); 
vImage_Error	vImageSelectChannels_ARGB8888( const vImage_Buffer *newSrc,       
                                                const vImage_Buffer *origSrc,      
                                                const vImage_Buffer *dest,      
                                                uint8_t copyMask,                
                                                vImage_Flags    flags ) VIMAGE_NON_NULL(1,2,3) __OSX_AVAILABLE_STARTING( __MAC_10_5, __IPHONE_5_0 );
vImage_Error	vImageSelectChannels_ARGBFFFF( const vImage_Buffer *newSrc,       
                                                const vImage_Buffer *origSrc,      
                                                const vImage_Buffer *dest,      
                                                uint8_t copyMask,                
                                                vImage_Flags    flags ) VIMAGE_NON_NULL(1,2,3) __OSX_AVAILABLE_STARTING( __MAC_10_5, __IPHONE_5_0 );
vImage_Error vImageOverwriteChannelsWithPixel_ARGB8888( const Pixel_8888     the_pixel,
                                                        const vImage_Buffer *src,      
                                                        const vImage_Buffer *dest,      
                                                        uint8_t copyMask,                
                                                        vImage_Flags    flags ) VIMAGE_NON_NULL(2,3) __OSX_AVAILABLE_STARTING( __MAC_10_5, __IPHONE_5_0 );
vImage_Error vImageOverwriteChannelsWithPixel_ARGB16U( const Pixel_ARGB_16U     the_pixel,
                                                       const vImage_Buffer *src,      
                                                       const vImage_Buffer *dest,      
                                                       uint8_t copyMask,               
                                                       vImage_Flags    flags ) VIMAGE_NON_NULL(2,3) __OSX_AVAILABLE_STARTING( __MAC_10_9, __IPHONE_7_0 );
vImage_Error vImageOverwriteChannelsWithPixel_ARGBFFFF( const Pixel_FFFF     the_pixel,
                                                        const vImage_Buffer *src,      
                                                        const vImage_Buffer *dest,      
                                                        uint8_t copyMask,                
                                                        vImage_Flags    flags ) VIMAGE_NON_NULL(2,3) __OSX_AVAILABLE_STARTING( __MAC_10_5, __IPHONE_5_0 );
vImage_Error    vImageConvert_Planar8ToXRGB8888( Pixel_8 alpha, const vImage_Buffer *red, const vImage_Buffer *green, const vImage_Buffer *blue, const vImage_Buffer *dest, vImage_Flags flags ) VIMAGE_NON_NULL(2,3,4,5)    __OSX_AVAILABLE_STARTING( __MAC_10_6, __IPHONE_5_0 );
vImage_Error    vImageConvert_Planar8ToBGRX8888( const vImage_Buffer *blue, const vImage_Buffer *green, const vImage_Buffer *red, Pixel_8 alpha, const vImage_Buffer *dest, vImage_Flags flags ) VIMAGE_NON_NULL(1,2,3,5)    __OSX_AVAILABLE_STARTING( __MAC_10_6, __IPHONE_5_0 );
#define         vImageConvert_Planar8ToRGBX8888( _red, _green, _blue, _alpha, _dest, _flags )   vImageConvert_Planar8ToBGRX8888((_red), (_green), (_blue), (_alpha), (_dest), (_flags))
vImage_Error    vImageConvert_PlanarFToXRGBFFFF( Pixel_F alpha, const vImage_Buffer *red, const vImage_Buffer *green, const vImage_Buffer *blue, const vImage_Buffer *dest, vImage_Flags flags ) VIMAGE_NON_NULL(2,3,4,5)    __OSX_AVAILABLE_STARTING( __MAC_10_6, __IPHONE_5_0 );
vImage_Error    vImageConvert_PlanarFToBGRXFFFF( const vImage_Buffer *blue, const vImage_Buffer *green, const vImage_Buffer *red, Pixel_F alpha, const vImage_Buffer *dest, vImage_Flags flags ) VIMAGE_NON_NULL(1,2,3,5)    __OSX_AVAILABLE_STARTING( __MAC_10_6, __IPHONE_5_0 );
#define         vImageConvert_PlanarFToRGBXFFFF( _red, _green, _blue, _alpha, _dest, _flags )   vImageConvert_PlanarFToBGRXFFFF( (_red), (_green), (_blue), (_alpha), (_dest), (_flags))
vImage_Error vImageConvert_XRGB8888ToPlanar8(const vImage_Buffer *src,
                                             const vImage_Buffer *red,
                                             const vImage_Buffer *green,
                                             const vImage_Buffer *blue,
                                             vImage_Flags flags)
    VIMAGE_NON_NULL(1,2,3,4)
    __OSX_AVAILABLE_STARTING(__MAC_10_9, __IPHONE_7_0);
vImage_Error vImageConvert_BGRX8888ToPlanar8(const vImage_Buffer *src,
                                             const vImage_Buffer *blue,
                                             const vImage_Buffer *green,
                                             const vImage_Buffer *red,
                                             vImage_Flags flags)
    VIMAGE_NON_NULL(1,2,3,4)
    __OSX_AVAILABLE_STARTING(__MAC_10_9, __IPHONE_7_0);
#define vImageConvert_RGBX8888ToPlanar8(_src, _red, _green, _blue, _flags) \
    vImageConvert_BGRX8888ToPlanar8((_src), (_red), (_green), (_blue), (_flags))
vImage_Error vImageConvert_XRGBFFFFToPlanarF(const vImage_Buffer *src,
                                             const vImage_Buffer *red,
                                             const vImage_Buffer *green,
                                             const vImage_Buffer *blue,
                                             vImage_Flags flags)
    VIMAGE_NON_NULL(1,2,3,4)
    __OSX_AVAILABLE_STARTING(__MAC_10_9, __IPHONE_7_0);
vImage_Error vImageConvert_BGRXFFFFToPlanarF(const vImage_Buffer *src,
                                             const vImage_Buffer *blue,
                                             const vImage_Buffer *green,
                                             const vImage_Buffer *red,
                                             vImage_Flags flags)
    VIMAGE_NON_NULL(1,2,3,4)
    __OSX_AVAILABLE_STARTING(__MAC_10_9, __IPHONE_7_0);
#define vImageConvert_RGBXFFFFToPlanarF(_src, _red, _green, _blue, _flags) \
    vImageConvert_BGRXFFFFToPlanarF((_src), (_red), (_green), (_blue), (_flags))
vImage_Error    vImageConvert_Planar8ToARGBFFFF( const vImage_Buffer *alpha, const vImage_Buffer *red, const vImage_Buffer *green, const vImage_Buffer *blue, const vImage_Buffer *dest, const Pixel_FFFF maxFloat, const Pixel_FFFF minFloat, vImage_Flags flags ) VIMAGE_NON_NULL(1,2,3,4,5) __OSX_AVAILABLE_STARTING( __MAC_10_6, __IPHONE_5_0 );
vImage_Error    vImageConvert_Planar8ToXRGBFFFF( Pixel_F alpha, const vImage_Buffer *red, const vImage_Buffer *green, const vImage_Buffer *blue, const vImage_Buffer *dest, const Pixel_FFFF maxFloat, const Pixel_FFFF minFloat, vImage_Flags flags ) VIMAGE_NON_NULL(2,3,4,5) __OSX_AVAILABLE_STARTING( __MAC_10_6, __IPHONE_5_0 );
vImage_Error    vImageConvert_Planar8ToBGRXFFFF(const vImage_Buffer *blue, const vImage_Buffer *green, const vImage_Buffer *red, Pixel_F alpha, const vImage_Buffer *dest, const Pixel_FFFF maxFloat, const Pixel_FFFF minFloat, vImage_Flags flags ) VIMAGE_NON_NULL(1,2,3,5) __OSX_AVAILABLE_STARTING( __MAC_10_6, __IPHONE_5_0 );
#define         vImageConvert_Planar8ToRGBXFFFF(_red, _green, _blue, _alpha, _dest, _maxFloat, _minFloat, _flags)  vImageConvert_Planar8ToBGRXFFFF((_red), (_green), (_blue), (_alpha), (_dest), (_maxFloat), (_minFloat), (_flags))
vImage_Error    vImageConvert_PlanarFToARGB8888( const vImage_Buffer *alpha, const vImage_Buffer *red, const vImage_Buffer *green, const vImage_Buffer *blue, const vImage_Buffer *dest, const Pixel_FFFF maxFloat, const Pixel_FFFF minFloat, vImage_Flags flags ) VIMAGE_NON_NULL(1,2,3,4,5,6,7) __OSX_AVAILABLE_STARTING( __MAC_10_6, __IPHONE_5_0 );
vImage_Error    vImageConvert_PlanarFToXRGB8888( Pixel_8 alpha, const vImage_Buffer *red, const vImage_Buffer *green, const vImage_Buffer *blue, const vImage_Buffer *dest, const Pixel_FFFF maxFloat, const Pixel_FFFF minFloat, vImage_Flags flags ) VIMAGE_NON_NULL(2,3,4,5,6,7) __OSX_AVAILABLE_STARTING( __MAC_10_6, __IPHONE_5_0 );
vImage_Error    vImageConvert_PlanarFToBGRX8888( const vImage_Buffer *blue, const vImage_Buffer *green, const vImage_Buffer *red, Pixel_8 alpha, const vImage_Buffer *dest, const Pixel_FFFF maxFloat, const Pixel_FFFF minFloat, vImage_Flags flags ) VIMAGE_NON_NULL(1,2,3,5,6,7) __OSX_AVAILABLE_STARTING( __MAC_10_6, __IPHONE_5_0 );
#define         vImageConvert_PlanarFToRGBX8888( _red, _green, _blue, _alpha, _dest, _maxFloat, _minFloat, _flags )     vImageConvert_PlanarFToBGRX8888((_red), (_green), (_blue), (_alpha), (_dest), (_maxFloat), (_minFloat), (_flags))
vImage_Error vImageConvert_RGB16UtoARGB16U( const vImage_Buffer *rgbSrc, const vImage_Buffer *aSrc, Pixel_16U alpha, const vImage_Buffer *argbDest, bool premultiply, vImage_Flags flags ) VIMAGE_NON_NULL(1,4) __OSX_AVAILABLE_STARTING( __MAC_10_9, __IPHONE_7_0 );
vImage_Error vImageConvert_RGB16UtoRGBA16U( const vImage_Buffer *rgbSrc, const vImage_Buffer *aSrc, Pixel_16U alpha, const vImage_Buffer *rgbaDest, bool premultiply, vImage_Flags flags ) VIMAGE_NON_NULL(1,4) __OSX_AVAILABLE_STARTING( __MAC_10_9, __IPHONE_7_0 );
vImage_Error vImageConvert_RGB16UtoBGRA16U( const vImage_Buffer *rgbSrc, const vImage_Buffer *aSrc, Pixel_16U alpha, const vImage_Buffer *bgraDest, bool premultiply, vImage_Flags flags ) VIMAGE_NON_NULL(1,4) __OSX_AVAILABLE_STARTING( __MAC_10_9, __IPHONE_7_0 );
vImage_Error vImageConvert_ARGB16UtoRGB16U( const vImage_Buffer *argbSrc, const vImage_Buffer *rgbDest, vImage_Flags flags ) VIMAGE_NON_NULL(1,2) __OSX_AVAILABLE_STARTING( __MAC_10_9, __IPHONE_7_0 );
vImage_Error vImageConvert_RGBA16UtoRGB16U( const vImage_Buffer *rgbaSrc, const vImage_Buffer *rgbDest, vImage_Flags flags ) VIMAGE_NON_NULL(1,2) __OSX_AVAILABLE_STARTING( __MAC_10_9, __IPHONE_7_0 );
vImage_Error vImageConvert_BGRA16UtoRGB16U( const vImage_Buffer *bgraSrc, const vImage_Buffer *rgbDest, vImage_Flags flags ) VIMAGE_NON_NULL(1,2) __OSX_AVAILABLE_STARTING( __MAC_10_9, __IPHONE_7_0 );
vImage_Error vImageConvert_Planar16UtoARGB16U(const vImage_Buffer *aSrc, const vImage_Buffer *rSrc, const vImage_Buffer *gSrc, const vImage_Buffer *bSrc, const vImage_Buffer *argbDest, vImage_Flags flags) VIMAGE_NON_NULL(1,2,3,4,5) __OSX_AVAILABLE_STARTING( __MAC_10_9, __IPHONE_7_0 );
vImage_Error vImageConvert_ARGB16UtoPlanar16U(const vImage_Buffer *argbSrc, const vImage_Buffer *aDest, const vImage_Buffer *rDest, const vImage_Buffer *gDest, const vImage_Buffer *bDest, vImage_Flags flags) VIMAGE_NON_NULL(1,2,3,4,5) __OSX_AVAILABLE_STARTING( __MAC_10_9, __IPHONE_7_0 );
vImage_Error vImageConvert_Planar16UtoRGB16U( const vImage_Buffer *rSrc, const vImage_Buffer *gSrc, const vImage_Buffer *bSrc, const vImage_Buffer *rgbDest, vImage_Flags flags ) VIMAGE_NON_NULL(1,2,3,4) __OSX_AVAILABLE_STARTING( __MAC_10_9, __IPHONE_7_0 );
vImage_Error vImageConvert_RGB16UtoPlanar16U( const vImage_Buffer *rgbSrc, const vImage_Buffer *rDest, const vImage_Buffer *gDest, const vImage_Buffer *bDest, vImage_Flags flags ) VIMAGE_NON_NULL(1,2,3,4) __OSX_AVAILABLE_STARTING( __MAC_10_9, __IPHONE_7_0 );
vImage_Error vImageConvert_Planar16UtoPlanar8_dithered(const vImage_Buffer *src, const vImage_Buffer *dest, int dither, vImage_Flags flags) VIMAGE_NON_NULL(1,2)
__OSX_AVAILABLE_STARTING( __MAC_10_12, __IPHONE_10_0 ) __WATCHOS_AVAILABLE(__WATCHOS_3_0) __TVOS_AVAILABLE(__TVOS_10_0);
vImage_Error vImageConvert_RGB16UtoRGB888_dithered(const vImage_Buffer *src, const vImage_Buffer *dest, int dither, vImage_Flags flags) VIMAGE_NON_NULL(1,2) __OSX_AVAILABLE_STARTING( __MAC_10_12, __IPHONE_10_0 ) __WATCHOS_AVAILABLE(__WATCHOS_3_0) __TVOS_AVAILABLE(__TVOS_10_0);
vImage_Error vImageConvert_ARGB16UtoARGB8888_dithered(const vImage_Buffer *src, const vImage_Buffer *dest, int dither, const uint8_t permuteMap[4], vImage_Flags flags) VIMAGE_NON_NULL(1,2) __OSX_AVAILABLE_STARTING( __MAC_10_12, __IPHONE_10_0 ) __WATCHOS_AVAILABLE(__WATCHOS_3_0) __TVOS_AVAILABLE(__TVOS_10_0);
vImage_Error vImageConvert_ARGB16UToARGB8888(const vImage_Buffer *src, const vImage_Buffer *dest, const uint8_t permuteMap[4], uint8_t copyMask, const Pixel_8888 backgroundColor, vImage_Flags flags ) VIMAGE_NON_NULL(1,2,3,5) __OSX_AVAILABLE_STARTING( __MAC_10_9, __IPHONE_7_0 );
vImage_Error vImageConvert_ARGB8888ToARGB16U(const vImage_Buffer *src, const vImage_Buffer *dest, const uint8_t permuteMap[4], uint8_t copyMask, const Pixel_ARGB_16U backgroundColor, vImage_Flags flags ) VIMAGE_NON_NULL(1,2,3,5) __OSX_AVAILABLE_STARTING( __MAC_10_9, __IPHONE_7_0 );
vImage_Error vImageConvert_RGB16UToARGB8888(const vImage_Buffer *src, const vImage_Buffer *dest, const uint8_t permuteMap[4], uint8_t copyMask, const Pixel_8888 backgroundColor, vImage_Flags flags ) VIMAGE_NON_NULL(1,2,3,5) __OSX_AVAILABLE_STARTING( __MAC_10_9, __IPHONE_7_0 );
vImage_Error vImageConvert_ARGB8888ToRGB16U(const vImage_Buffer *src, const vImage_Buffer *dest, const uint8_t permuteMap[3], uint8_t copyMask, const Pixel_16U backgroundColor[3], vImage_Flags flags ) VIMAGE_NON_NULL(1,2,3,5) __OSX_AVAILABLE_STARTING( __MAC_10_9, __IPHONE_7_0 );
vImage_Error vImageByteSwap_Planar16U(const vImage_Buffer *src, const vImage_Buffer *dest, vImage_Flags flags) VIMAGE_NON_NULL(1,2) __OSX_AVAILABLE_STARTING( __MAC_10_9, __IPHONE_7_0 );
vImage_Error  vImageFlatten_ARGB8888(const vImage_Buffer *argbSrc, const vImage_Buffer *argbDst, const Pixel_8888 argbBackgroundColorPtr, bool isImagePremultiplied, vImage_Flags flags) VIMAGE_NON_NULL(1,2,3) __OSX_AVAILABLE_STARTING( __MAC_10_9, __IPHONE_7_0 );
vImage_Error  vImageFlatten_RGBA8888(const vImage_Buffer *rgbaSrc, const vImage_Buffer *rgbaDst, const Pixel_8888 rgbaBackgroundColorPtr, bool isImagePremultiplied, vImage_Flags flags) VIMAGE_NON_NULL(1,2,3) __OSX_AVAILABLE_STARTING( __MAC_10_9, __IPHONE_7_0 );
vImage_Error  vImageFlatten_ARGB16U(const vImage_Buffer *argbSrc, const vImage_Buffer *argbDst, const Pixel_ARGB_16U argbBackgroundColorPtr, bool isImagePremultiplied, vImage_Flags flags) VIMAGE_NON_NULL(1,2,3) __OSX_AVAILABLE_STARTING( __MAC_10_9, __IPHONE_7_0 );
vImage_Error  vImageFlatten_RGBA16U(const vImage_Buffer *rgbaSrc, const vImage_Buffer *rgbaDst, const Pixel_ARGB_16U rgbaBackgroundColorPtr, bool isImagePremultiplied, vImage_Flags flags) VIMAGE_NON_NULL(1,2,3) __OSX_AVAILABLE_STARTING( __MAC_10_9, __IPHONE_7_0 );
vImage_Error  vImageFlatten_ARGB16Q12(const vImage_Buffer *argbSrc, const vImage_Buffer *argbDst, const Pixel_ARGB_16S argbBackgroundColorPtr, bool isImagePremultiplied, vImage_Flags flags) VIMAGE_NON_NULL(1,2,3) __OSX_AVAILABLE_STARTING( __MAC_10_9, __IPHONE_7_0 );
vImage_Error  vImageFlatten_RGBA16Q12(const vImage_Buffer *argbSrc, const vImage_Buffer *argbDst, const Pixel_ARGB_16S argbBackgroundColorPtr, bool isImagePremultiplied, vImage_Flags flags) VIMAGE_NON_NULL(1,2,3) __OSX_AVAILABLE_STARTING( __MAC_10_9, __IPHONE_7_0 );
vImage_Error  vImageFlatten_ARGBFFFF(const vImage_Buffer *argbSrc, const vImage_Buffer *argbDst, const Pixel_FFFF argbBackgroundColorPtr, bool isImagePremultiplied, vImage_Flags flags) VIMAGE_NON_NULL(1,2,3) __OSX_AVAILABLE_STARTING( __MAC_10_9, __IPHONE_7_0 );
vImage_Error  vImageFlatten_RGBAFFFF(const vImage_Buffer *rgbaSrc, const vImage_Buffer *rgbaDst, const Pixel_FFFF rgbaBackgroundColorPtr, bool isImagePremultiplied, vImage_Flags flags) VIMAGE_NON_NULL(1,2,3) __OSX_AVAILABLE_STARTING( __MAC_10_9, __IPHONE_7_0 );
vImage_Error vImageConvert_Planar1toPlanar8(const vImage_Buffer *src, const vImage_Buffer *dest, const vImage_Flags flags) VIMAGE_NON_NULL(1,2) __OSX_AVAILABLE_STARTING(__MAC_10_9, __IPHONE_7_0);
vImage_Error vImageConvert_Planar2toPlanar8(const vImage_Buffer *src, const vImage_Buffer *dest, const vImage_Flags flags) VIMAGE_NON_NULL(1,2) __OSX_AVAILABLE_STARTING(__MAC_10_9, __IPHONE_7_0);
vImage_Error vImageConvert_Planar4toPlanar8(const vImage_Buffer *src, const vImage_Buffer *dest, const vImage_Flags flags) VIMAGE_NON_NULL(1,2) __OSX_AVAILABLE_STARTING(__MAC_10_9, __IPHONE_7_0);
vImage_Error vImageConvert_Indexed1toPlanar8(const vImage_Buffer *src, const vImage_Buffer *dest, const Pixel_8 colors[2], const vImage_Flags flags) VIMAGE_NON_NULL(1,2,3) __OSX_AVAILABLE_STARTING(__MAC_10_9, __IPHONE_7_0);
vImage_Error vImageConvert_Indexed2toPlanar8(const vImage_Buffer *src, const vImage_Buffer *dest, const Pixel_8 colors[4], const vImage_Flags flags) VIMAGE_NON_NULL(1,2,3) __OSX_AVAILABLE_STARTING(__MAC_10_9, __IPHONE_7_0);
vImage_Error vImageConvert_Indexed4toPlanar8(const vImage_Buffer *src, const vImage_Buffer *dest, const Pixel_8 colors[16], const vImage_Flags flags) VIMAGE_NON_NULL(1,2,3) __OSX_AVAILABLE_STARTING(__MAC_10_9, __IPHONE_7_0);
enum {
    kvImageConvert_DitherNone                   = 0,         
    kvImageConvert_DitherOrdered                = 1,         
    kvImageConvert_DitherOrderedReproducible    = 2,         
    kvImageConvert_DitherFloydSteinberg         = 3,         
    kvImageConvert_DitherAtkinson               = 4,         
    kvImageConvert_OrderedGaussianBlue          = 0,         
    kvImageConvert_OrderedUniformBlue           = (1<<28),   
    kvImageConvert_OrderedNoiseShapeMask        = (0xfU<<28) 
};
vImage_Error vImageConvert_Planar8toPlanar1(const vImage_Buffer *src, const vImage_Buffer *dest, void *tempBuffer, int dither, const vImage_Flags flags) VIMAGE_NON_NULL(1,2) __OSX_AVAILABLE_STARTING(__MAC_10_9, __IPHONE_7_0);
vImage_Error vImageConvert_Planar8toPlanar2(const vImage_Buffer *src, const vImage_Buffer *dest, void *tempBuffer, int dither, const vImage_Flags flags) VIMAGE_NON_NULL(1,2) __OSX_AVAILABLE_STARTING(__MAC_10_9, __IPHONE_7_0);
vImage_Error vImageConvert_Planar8toPlanar4(const vImage_Buffer *src, const vImage_Buffer *dest, void *tempBuffer, int dither, const vImage_Flags flags) VIMAGE_NON_NULL(1,2) __OSX_AVAILABLE_STARTING(__MAC_10_9, __IPHONE_7_0);
vImage_Error vImageConvert_Planar8toIndexed1(const vImage_Buffer *src, const vImage_Buffer *dest, void *tempBuffer, Pixel_8 colors[2], int dither, const vImage_Flags flags) VIMAGE_NON_NULL(1,2,4) __OSX_AVAILABLE_STARTING(__MAC_10_9, __IPHONE_7_0);
vImage_Error vImageConvert_Planar8toIndexed2(const vImage_Buffer *src, const vImage_Buffer *dest, void *tempBuffer, Pixel_8 colors[4], int dither, const vImage_Flags flags) VIMAGE_NON_NULL(1,2,4) __OSX_AVAILABLE_STARTING(__MAC_10_9, __IPHONE_7_0);
vImage_Error vImageConvert_Planar8toIndexed4(const vImage_Buffer *src, const vImage_Buffer *dest, void *tempBuffer, Pixel_8 colors[16], int dither, const vImage_Flags flags) VIMAGE_NON_NULL(1,2,4) __OSX_AVAILABLE_STARTING(__MAC_10_9, __IPHONE_7_0);
vImage_Error vImageConvert_8to16Q12(const vImage_Buffer *src, const vImage_Buffer *dest, vImage_Flags flags) VIMAGE_NON_NULL(1,2) __OSX_AVAILABLE_STARTING(__MAC_10_9, __IPHONE_7_0);
vImage_Error vImageConvert_RGB888toPlanar16Q12(const vImage_Buffer *src, const vImage_Buffer *red, const vImage_Buffer *green, const vImage_Buffer *blue, vImage_Flags flags) VIMAGE_NON_NULL(1,2,3,4) __OSX_AVAILABLE_STARTING(__MAC_10_9, __IPHONE_7_0);
vImage_Error vImageConvert_ARGB8888toPlanar16Q12(const vImage_Buffer *src, const vImage_Buffer *alpha, const vImage_Buffer *red, const vImage_Buffer *green, const vImage_Buffer *blue, vImage_Flags flags) VIMAGE_NON_NULL(1,2,3,4,5) __OSX_AVAILABLE_STARTING(__MAC_10_9, __IPHONE_7_0);
vImage_Error vImageConvert_16Q12to8(const vImage_Buffer *src, const vImage_Buffer *dest, vImage_Flags flags) VIMAGE_NON_NULL(1,2) __OSX_AVAILABLE_STARTING(__MAC_10_9, __IPHONE_7_0);
vImage_Error vImageConvert_Planar16Q12toRGB888(const vImage_Buffer *red, const vImage_Buffer *green, const vImage_Buffer *blue, const vImage_Buffer *dest, vImage_Flags flags) VIMAGE_NON_NULL(1,2,3,4) __OSX_AVAILABLE_STARTING(__MAC_10_9, __IPHONE_7_0);
vImage_Error vImageConvert_Planar16Q12toARGB8888(const vImage_Buffer *alpha, const vImage_Buffer *red, const vImage_Buffer *green, const vImage_Buffer *blue, const vImage_Buffer *dest, vImage_Flags flags) VIMAGE_NON_NULL(1,2,3,4,5) __OSX_AVAILABLE_STARTING(__MAC_10_9, __IPHONE_7_0);
vImage_Error vImageConvert_16Q12to16F(const vImage_Buffer *src, const vImage_Buffer *dest, vImage_Flags flags) VIMAGE_NON_NULL(1,2) __OSX_AVAILABLE_STARTING(__MAC_10_12, __IPHONE_10_0) __WATCHOS_AVAILABLE(__WATCHOS_3_0) __TVOS_AVAILABLE(__TVOS_10_0);
vImage_Error vImageConvert_Planar16Q12toRGB16F(const vImage_Buffer *red, const vImage_Buffer *green, const vImage_Buffer *blue, const vImage_Buffer *dest, vImage_Flags flags) VIMAGE_NON_NULL(1,2,3,4) __OSX_AVAILABLE_STARTING(__MAC_10_12, __IPHONE_10_0) __WATCHOS_AVAILABLE(__WATCHOS_3_0) __TVOS_AVAILABLE(__TVOS_10_0);
vImage_Error vImageConvert_Planar16Q12toARGB16F(const vImage_Buffer *alpha, const vImage_Buffer *red, const vImage_Buffer *green, const vImage_Buffer *blue, const vImage_Buffer *dest, vImage_Flags flags) VIMAGE_NON_NULL(1,2,3,4,5) __OSX_AVAILABLE_STARTING(__MAC_10_12, __IPHONE_10_0) __WATCHOS_AVAILABLE(__WATCHOS_3_0) __TVOS_AVAILABLE(__TVOS_10_0);
vImage_Error vImageConvert_16Fto16Q12(const vImage_Buffer *src, const vImage_Buffer *dest, vImage_Flags flags) VIMAGE_NON_NULL(1,2) __OSX_AVAILABLE_STARTING(__MAC_10_12, __IPHONE_10_0) __WATCHOS_AVAILABLE(__WATCHOS_3_0) __TVOS_AVAILABLE(__TVOS_10_0);
vImage_Error vImageConvert_16Q12toF(const vImage_Buffer *src, const vImage_Buffer *dest, vImage_Flags flags) VIMAGE_NON_NULL(1,2) __OSX_AVAILABLE_STARTING(__MAC_10_9, __IPHONE_7_0);
vImage_Error vImageConvert_Fto16Q12(const vImage_Buffer *src, const vImage_Buffer *dest, vImage_Flags flags) VIMAGE_NON_NULL(1,2) __OSX_AVAILABLE_STARTING(__MAC_10_9, __IPHONE_7_0);
vImage_Error vImageConvert_16Q12to16U(const vImage_Buffer *src, const vImage_Buffer *dest, vImage_Flags flags) VIMAGE_NON_NULL(1,2) __OSX_AVAILABLE_STARTING(__MAC_10_9, __IPHONE_7_0);
vImage_Error vImageConvert_16Uto16Q12(const vImage_Buffer *src, const vImage_Buffer *dest, vImage_Flags flags) VIMAGE_NON_NULL(1,2) __OSX_AVAILABLE_STARTING(__MAC_10_9, __IPHONE_7_0);
vImage_Error vImageConvert_YpCbCrToARGB_GenerateConversion(const vImage_YpCbCrToARGBMatrix *matrix, const vImage_YpCbCrPixelRange *pixelRange, vImage_YpCbCrToARGB *outInfo, vImageYpCbCrType inYpCbCrType, vImageARGBType outARGBType, vImage_Flags flags) VIMAGE_NON_NULL(1,2,3) __OSX_AVAILABLE_STARTING(__MAC_10_10, __IPHONE_8_0);
vImage_Error vImageConvert_ARGBToYpCbCr_GenerateConversion(const vImage_ARGBToYpCbCrMatrix *matrix, const vImage_YpCbCrPixelRange *pixelRange, vImage_ARGBToYpCbCr *outInfo, vImageARGBType inARGBType, vImageYpCbCrType outYpCbCrType, vImage_Flags flags) VIMAGE_NON_NULL(1,2,3) __OSX_AVAILABLE_STARTING(__MAC_10_10, __IPHONE_8_0);
vImage_Error vImageConvert_422YpCbYpCr8ToARGB8888(const vImage_Buffer *src, const vImage_Buffer *dest, const vImage_YpCbCrToARGB *info, const uint8_t permuteMap[4], const uint8_t alpha, vImage_Flags flags) VIMAGE_NON_NULL(1,2,3) __OSX_AVAILABLE_STARTING(__MAC_10_10, __IPHONE_8_0);
vImage_Error vImageConvert_ARGB8888To422YpCbYpCr8(const vImage_Buffer *src, const vImage_Buffer *dest, const vImage_ARGBToYpCbCr *info, const uint8_t permuteMap[4], vImage_Flags flags) VIMAGE_NON_NULL(1,2,3) __OSX_AVAILABLE_STARTING(__MAC_10_10, __IPHONE_8_0);
vImage_Error vImageConvert_422CbYpCrYp8ToARGB8888(const vImage_Buffer *src, const vImage_Buffer *dest, const vImage_YpCbCrToARGB *info, const uint8_t permuteMap[4], const uint8_t alpha, vImage_Flags flags) VIMAGE_NON_NULL(1,2,3) __OSX_AVAILABLE_STARTING(__MAC_10_10, __IPHONE_8_0);
vImage_Error vImageConvert_ARGB8888To422CbYpCrYp8(const vImage_Buffer *src, const vImage_Buffer *dest, const vImage_ARGBToYpCbCr *info, const uint8_t permuteMap[4], vImage_Flags flags) VIMAGE_NON_NULL(1,2,3) __OSX_AVAILABLE_STARTING(__MAC_10_10, __IPHONE_8_0);
vImage_Error vImageConvert_422CbYpCrYp8_AA8ToARGB8888(const vImage_Buffer *src, const vImage_Buffer *srcA, const vImage_Buffer *dest, const vImage_YpCbCrToARGB *info, const uint8_t permuteMap[4], vImage_Flags flags) VIMAGE_NON_NULL(1,2,3,4) __OSX_AVAILABLE_STARTING(__MAC_10_10, __IPHONE_8_0);
vImage_Error vImageConvert_ARGB8888To422CbYpCrYp8_AA8(const vImage_Buffer *src, const vImage_Buffer *dest, const vImage_Buffer *destA, const vImage_ARGBToYpCbCr *info, const uint8_t permuteMap[4], vImage_Flags flags) VIMAGE_NON_NULL(1,2,3,4) __OSX_AVAILABLE_STARTING(__MAC_10_10, __IPHONE_8_0);
vImage_Error vImageConvert_444AYpCbCr8ToARGB8888(const vImage_Buffer *src, const vImage_Buffer *dest, const vImage_YpCbCrToARGB *info, const uint8_t permuteMap[4], vImage_Flags flags) VIMAGE_NON_NULL(1,2,3) __OSX_AVAILABLE_STARTING(__MAC_10_10, __IPHONE_8_0);
vImage_Error vImageConvert_ARGB8888To444AYpCbCr8(const vImage_Buffer *src, const vImage_Buffer *dest, const vImage_ARGBToYpCbCr *info, const uint8_t permuteMap[4], vImage_Flags flags) VIMAGE_NON_NULL(1,2,3) __OSX_AVAILABLE_STARTING(__MAC_10_10, __IPHONE_8_0);
vImage_Error vImageConvert_444CbYpCrA8ToARGB8888(const vImage_Buffer *src, const vImage_Buffer *dest, const vImage_YpCbCrToARGB *info, const uint8_t permuteMap[4], vImage_Flags flags) VIMAGE_NON_NULL(1,2,3) __OSX_AVAILABLE_STARTING(__MAC_10_10, __IPHONE_8_0);
vImage_Error vImageConvert_ARGB8888To444CbYpCrA8(const vImage_Buffer *src, const vImage_Buffer *dest, const vImage_ARGBToYpCbCr *info, const uint8_t permuteMap[4], vImage_Flags flags) VIMAGE_NON_NULL(1,2,3) __OSX_AVAILABLE_STARTING(__MAC_10_10, __IPHONE_8_0);
vImage_Error vImageConvert_444CrYpCb8ToARGB8888(const vImage_Buffer *src, const vImage_Buffer *dest, const vImage_YpCbCrToARGB *info, const uint8_t permuteMap[4], const uint8_t alpha, vImage_Flags flags) VIMAGE_NON_NULL(1,2,3) __OSX_AVAILABLE_STARTING(__MAC_10_10, __IPHONE_8_0);
vImage_Error vImageConvert_ARGB8888To444CrYpCb8(const vImage_Buffer *src, const vImage_Buffer *dest, const vImage_ARGBToYpCbCr *info, const uint8_t permuteMap[4], vImage_Flags flags) VIMAGE_NON_NULL(1,2,3) __OSX_AVAILABLE_STARTING(__MAC_10_10, __IPHONE_8_0);
vImage_Error vImageConvert_420Yp8_Cb8_Cr8ToARGB8888(const vImage_Buffer *srcYp, const vImage_Buffer *srcCb, const vImage_Buffer *srcCr, const vImage_Buffer *dest, const vImage_YpCbCrToARGB *info, const uint8_t permuteMap[4], const uint8_t alpha, vImage_Flags flags) VIMAGE_NON_NULL(1,2,3,4,5) __OSX_AVAILABLE_STARTING(__MAC_10_10, __IPHONE_8_0);
vImage_Error vImageConvert_ARGB8888To420Yp8_Cb8_Cr8(const vImage_Buffer *src, const vImage_Buffer *destYp, const vImage_Buffer *destCb, const vImage_Buffer *destCr, const vImage_ARGBToYpCbCr *info, const uint8_t permuteMap[4], vImage_Flags flags) VIMAGE_NON_NULL(1,2,3,4,5) __OSX_AVAILABLE_STARTING(__MAC_10_10, __IPHONE_8_0);
vImage_Error vImageConvert_420Yp8_CbCr8ToARGB8888(const vImage_Buffer *srcYp, const vImage_Buffer *srcCbCr, const vImage_Buffer *dest, const vImage_YpCbCrToARGB *info, const uint8_t permuteMap[4], const uint8_t alpha, vImage_Flags flags) VIMAGE_NON_NULL(1,2,3,4) __OSX_AVAILABLE_STARTING(__MAC_10_10, __IPHONE_8_0);
vImage_Error vImageConvert_ARGB8888To420Yp8_CbCr8(const vImage_Buffer *src, const vImage_Buffer *destYp, const vImage_Buffer *destCbCr, const vImage_ARGBToYpCbCr *info, const uint8_t permuteMap[4], vImage_Flags flags) VIMAGE_NON_NULL(1,2,3,4) __OSX_AVAILABLE_STARTING(__MAC_10_10, __IPHONE_8_0);
vImage_Error vImageConvert_444AYpCbCr16ToARGB8888(const vImage_Buffer *src, const vImage_Buffer *dest, const vImage_YpCbCrToARGB *info, const uint8_t permuteMap[4], vImage_Flags flags) VIMAGE_NON_NULL(1,2,3) __OSX_AVAILABLE_STARTING(__MAC_10_10, __IPHONE_8_0);
vImage_Error vImageConvert_ARGB8888To444AYpCbCr16(const vImage_Buffer *src, const vImage_Buffer *dest, const vImage_ARGBToYpCbCr *info, const uint8_t permuteMap[4], vImage_Flags flags) VIMAGE_NON_NULL(1,2,3) __OSX_AVAILABLE_STARTING(__MAC_10_10, __IPHONE_8_0);
vImage_Error vImageConvert_444AYpCbCr16ToARGB16U(const vImage_Buffer *src, const vImage_Buffer *dest, const vImage_YpCbCrToARGB *info, const uint8_t permuteMap[4], vImage_Flags flags) VIMAGE_NON_NULL(1,2,3) __OSX_AVAILABLE_STARTING(__MAC_10_10, __IPHONE_8_0);
vImage_Error vImageConvert_ARGB16UTo444AYpCbCr16(const vImage_Buffer *src, const vImage_Buffer *dest, const vImage_ARGBToYpCbCr *info, const uint8_t permuteMap[4], vImage_Flags flags) VIMAGE_NON_NULL(1,2,3) __OSX_AVAILABLE_STARTING(__MAC_10_10, __IPHONE_8_0);
vImage_Error vImageConvert_444CrYpCb10ToARGB8888(const vImage_Buffer *src, const vImage_Buffer *dest, const vImage_YpCbCrToARGB *info, const uint8_t permuteMap[4], const uint8_t alpha, vImage_Flags flags) VIMAGE_NON_NULL(1,2,3) __OSX_AVAILABLE_STARTING(__MAC_10_10, __IPHONE_8_0);
vImage_Error vImageConvert_ARGB8888To444CrYpCb10(const vImage_Buffer *src, const vImage_Buffer *dest, const vImage_ARGBToYpCbCr *info, const uint8_t permuteMap[4], vImage_Flags flags) VIMAGE_NON_NULL(1,2,3) __OSX_AVAILABLE_STARTING(__MAC_10_10, __IPHONE_8_0);
vImage_Error vImageConvert_444CrYpCb10ToARGB16Q12(const vImage_Buffer *src, const vImage_Buffer *dest, const vImage_YpCbCrToARGB *info, const uint8_t permuteMap[4], const Pixel_16Q12 alpha, vImage_Flags flags) VIMAGE_NON_NULL(1,2,3) __OSX_AVAILABLE_STARTING(__MAC_10_10, __IPHONE_8_0);
vImage_Error vImageConvert_ARGB16Q12To444CrYpCb10(const vImage_Buffer *src, const vImage_Buffer *dest, const vImage_ARGBToYpCbCr *info, const uint8_t permuteMap[4], vImage_Flags flags) VIMAGE_NON_NULL(1,2,3) __OSX_AVAILABLE_STARTING(__MAC_10_10, __IPHONE_8_0);
vImage_Error vImageConvert_422CrYpCbYpCbYpCbYpCrYpCrYp10ToARGB8888(const vImage_Buffer *src, const vImage_Buffer *dest, const vImage_YpCbCrToARGB *info, const uint8_t permuteMap[4], const uint8_t alpha, vImage_Flags flags) VIMAGE_NON_NULL(1,2,3) __OSX_AVAILABLE_STARTING(__MAC_10_10, __IPHONE_8_0);
vImage_Error vImageConvert_ARGB8888To422CrYpCbYpCbYpCbYpCrYpCrYp10(const vImage_Buffer *src, const vImage_Buffer *dest, const vImage_ARGBToYpCbCr *info, const uint8_t permuteMap[4], vImage_Flags flags) VIMAGE_NON_NULL(1,2,3) __OSX_AVAILABLE_STARTING(__MAC_10_10, __IPHONE_8_0);
vImage_Error vImageConvert_422CrYpCbYpCbYpCbYpCrYpCrYp10ToARGB16Q12(const vImage_Buffer *src, const vImage_Buffer *dest, const vImage_YpCbCrToARGB *info, const uint8_t permuteMap[4], const Pixel_16Q12 alpha, vImage_Flags flags) VIMAGE_NON_NULL(1,2,3) __OSX_AVAILABLE_STARTING(__MAC_10_10, __IPHONE_8_0);
vImage_Error vImageConvert_ARGB16Q12To422CrYpCbYpCbYpCbYpCrYpCrYp10(const vImage_Buffer *src, const vImage_Buffer *dest, const vImage_ARGBToYpCbCr *info, const uint8_t permuteMap[4], vImage_Flags flags) VIMAGE_NON_NULL(1,2,3) __OSX_AVAILABLE_STARTING(__MAC_10_10, __IPHONE_8_0);
vImage_Error vImageConvert_422CbYpCrYp16ToARGB8888(const vImage_Buffer *src, const vImage_Buffer *dest, const vImage_YpCbCrToARGB *info, const uint8_t permuteMap[4], const uint8_t alpha, vImage_Flags flags) VIMAGE_NON_NULL(1,2,3) __OSX_AVAILABLE_STARTING(__MAC_10_10, __IPHONE_8_0);
vImage_Error vImageConvert_ARGB8888To422CbYpCrYp16(const vImage_Buffer *src, const vImage_Buffer *dest, const vImage_ARGBToYpCbCr *info, const uint8_t permuteMap[4], vImage_Flags flags) VIMAGE_NON_NULL(1,2,3) __OSX_AVAILABLE_STARTING(__MAC_10_10, __IPHONE_8_0);
vImage_Error vImageConvert_422CbYpCrYp16ToARGB16U(const vImage_Buffer *src, const vImage_Buffer *dest, const vImage_YpCbCrToARGB *info, const uint8_t permuteMap[4], const uint16_t alpha, vImage_Flags flags) VIMAGE_NON_NULL(1,2,3) __OSX_AVAILABLE_STARTING(__MAC_10_10, __IPHONE_8_0);
vImage_Error vImageConvert_ARGB16UTo422CbYpCrYp16(const vImage_Buffer *src, const vImage_Buffer *dest, const vImage_ARGBToYpCbCr *info, const uint8_t permuteMap[4], vImage_Flags flags) VIMAGE_NON_NULL(1,2,3) __OSX_AVAILABLE_STARTING(__MAC_10_10, __IPHONE_8_0);
vImage_Error vImageConvert_RGBA1010102ToARGB8888(const vImage_Buffer *src, const vImage_Buffer *dest, int32_t RGB101010RangeMin, int32_t RGB101010RangeMax, const uint8_t permuteMap[4], vImage_Flags flags) VIMAGE_NON_NULL(1,2) __OSX_AVAILABLE_STARTING(__MAC_10_10, __IPHONE_8_0);
vImage_Error vImageConvert_ARGB8888ToRGBA1010102(const vImage_Buffer *src, const vImage_Buffer *dest, int32_t RGB101010RangeMin, int32_t RGB101010RangeMax, const uint8_t permuteMap[4], vImage_Flags flags) VIMAGE_NON_NULL(1,2) __OSX_AVAILABLE_STARTING(__MAC_10_10, __IPHONE_8_0);
vImage_Error vImageConvert_RGBA1010102ToARGB16Q12(const vImage_Buffer *src, const vImage_Buffer *dest, int32_t RGB101010RangeMin, int32_t RGB101010RangeMax, const uint8_t permuteMap[4], vImage_Flags flags) VIMAGE_NON_NULL(1,2) __OSX_AVAILABLE_STARTING(__MAC_10_10, __IPHONE_8_0);
vImage_Error vImageConvert_ARGB16Q12ToRGBA1010102(const vImage_Buffer *src, const vImage_Buffer *dest, int32_t RGB101010RangeMin, int32_t RGB101010RangeMax, int32_t RGB101010Min, int32_t RGB101010Max, const uint8_t permuteMap[4], vImage_Flags flags) VIMAGE_NON_NULL(1,2) __OSX_AVAILABLE_STARTING(__MAC_10_10, __IPHONE_8_0);
vImage_Error vImageConvert_RGBA1010102ToARGB16U(const vImage_Buffer *src, const vImage_Buffer *dest, int32_t RGB101010RangeMin, int32_t RGB101010RangeMax, const uint8_t permuteMap[4], vImage_Flags flags) VIMAGE_NON_NULL(1,2) __OSX_AVAILABLE_STARTING(__MAC_10_10, __IPHONE_8_0);
vImage_Error vImageConvert_ARGB16UToRGBA1010102(const vImage_Buffer *src, const vImage_Buffer *dest, int32_t RGB101010RangeMin, int32_t RGB101010RangeMax, const uint8_t permuteMap[4], vImage_Flags flags) VIMAGE_NON_NULL(1,2) __OSX_AVAILABLE_STARTING(__MAC_10_10, __IPHONE_8_0);
vImage_Error vImagePermuteChannels_RGB888(const vImage_Buffer *src, const vImage_Buffer *dest, const uint8_t permuteMap[3], vImage_Flags flags) VIMAGE_NON_NULL(1,2) __OSX_AVAILABLE_STARTING(__MAC_10_10, __IPHONE_8_0);
vImage_Error vImageCopyBuffer(const vImage_Buffer *src, const vImage_Buffer *dest, size_t pixelSize, vImage_Flags flags ) VIMAGE_NON_NULL(1,2) __OSX_AVAILABLE_STARTING(__MAC_10_10, __IPHONE_8_0);
vImage_Error vImageConvert_XRGB2101010ToARGB8888(const vImage_Buffer *src, Pixel_8 alpha,
                                                 const vImage_Buffer *dest,
                                                 int32_t RGB101010RangeMin, int32_t RGB101010RangeMax,
                                                 const uint8_t permuteMap[4],
                                                 vImage_Flags flags)
VIMAGE_NON_NULL(1,3)
__OSX_AVAILABLE_STARTING(__MAC_10_12, __IPHONE_9_3) __WATCHOS_AVAILABLE(__WATCHOS_3_0) __TVOS_AVAILABLE(__TVOS_10_0);
vImage_Error vImageConvert_ARGB2101010ToARGB8888(const vImage_Buffer *src,
                                                 const vImage_Buffer *dest,
                                                 int32_t RGB101010RangeMin, int32_t RGB101010RangeMax,
                                                 const uint8_t permuteMap[4],
                                                 vImage_Flags flags)
VIMAGE_NON_NULL(1,2)
__OSX_AVAILABLE_STARTING(__MAC_10_12, __IPHONE_9_3) __WATCHOS_AVAILABLE(__WATCHOS_3_0) __TVOS_AVAILABLE(__TVOS_10_0);
vImage_Error vImageConvert_ARGB8888ToXRGB2101010(const vImage_Buffer *src,
                                                 const vImage_Buffer *dest,
                                                 int32_t RGB101010RangeMin, int32_t RGB101010RangeMax,
                                                 const uint8_t permuteMap[4],
                                                 vImage_Flags flags)
VIMAGE_NON_NULL(1,2)
__OSX_AVAILABLE_STARTING(__MAC_10_12, __IPHONE_9_3) __WATCHOS_AVAILABLE(__WATCHOS_3_0) __TVOS_AVAILABLE(__TVOS_10_0);
vImage_Error vImageConvert_ARGB8888ToARGB2101010(const vImage_Buffer *src,
                                                 const vImage_Buffer *dest,
                                                 int32_t RGB101010RangeMin, int32_t RGB101010RangeMax,
                                                 const uint8_t permuteMap[4],
                                                 vImage_Flags flags)
VIMAGE_NON_NULL(1,2)
__OSX_AVAILABLE_STARTING(__MAC_10_12, __IPHONE_9_3) __WATCHOS_AVAILABLE(__WATCHOS_3_0) __TVOS_AVAILABLE(__TVOS_10_0);
vImage_Error vImageConvert_XRGB2101010ToARGB16Q12(const vImage_Buffer *src, Pixel_16Q12 alpha,
                                                  const vImage_Buffer *dest,
                                                  int32_t RGB101010RangeMin, int32_t RGB101010RangeMax,
                                                  const uint8_t permuteMap[4],
                                                  vImage_Flags flags)
VIMAGE_NON_NULL(1,3)
__OSX_AVAILABLE_STARTING( __MAC_10_12, __IPHONE_9_3 ) __WATCHOS_AVAILABLE(__WATCHOS_3_0) __TVOS_AVAILABLE(__TVOS_10_0);
vImage_Error vImageConvert_ARGB2101010ToARGB16Q12(const vImage_Buffer *src,
                                                  const vImage_Buffer *dest,
                                                  int32_t RGB101010RangeMin, int32_t RGB101010RangeMax,
                                                  const uint8_t permuteMap[4],
                                                  vImage_Flags flags)
VIMAGE_NON_NULL(1,2)
__OSX_AVAILABLE_STARTING( __MAC_10_12, __IPHONE_9_3 ) __WATCHOS_AVAILABLE(__WATCHOS_3_0) __TVOS_AVAILABLE(__TVOS_10_0);
vImage_Error vImageConvert_ARGB16Q12ToXRGB2101010(const vImage_Buffer *src,
                                                  const vImage_Buffer *dest,
                                                  int32_t RGB101010RangeMin, int32_t RGB101010RangeMax,
                                                  int32_t RGB101010Min, int32_t RGB101010Max,
                                                  const uint8_t permuteMap[4],
                                                  vImage_Flags flags)
VIMAGE_NON_NULL(1,2)
__OSX_AVAILABLE_STARTING(__MAC_10_12, __IPHONE_9_3) __WATCHOS_AVAILABLE(__WATCHOS_3_0) __TVOS_AVAILABLE(__TVOS_10_0);
vImage_Error vImageConvert_ARGB16Q12ToARGB2101010(const vImage_Buffer *src,
                                                  const vImage_Buffer *dest,
                                                  int32_t RGB101010RangeMin, int32_t RGB101010RangeMax,
                                                  int32_t RGB101010Min, int32_t RGB101010Max,
                                                  const uint8_t permuteMap[4],
                                                  vImage_Flags flags)
VIMAGE_NON_NULL(1,2)
__OSX_AVAILABLE_STARTING(__MAC_10_12, __IPHONE_9_3) __WATCHOS_AVAILABLE(__WATCHOS_3_0) __TVOS_AVAILABLE(__TVOS_10_0);
vImage_Error vImageConvert_XRGB2101010ToARGB16U(const vImage_Buffer *src, uint16_t alpha,
                                                const vImage_Buffer *dest,
                                                int32_t RGB101010RangeMin, int32_t RGB101010RangeMax,
                                                const uint8_t permuteMap[4],
                                                vImage_Flags flags)
VIMAGE_NON_NULL(1,3)
__OSX_AVAILABLE_STARTING( __MAC_10_12, __IPHONE_9_3 ) __WATCHOS_AVAILABLE(__WATCHOS_3_0) __TVOS_AVAILABLE(__TVOS_10_0);
vImage_Error vImageConvert_ARGB2101010ToARGB16U(const vImage_Buffer *src,
                                                const vImage_Buffer *dest,
                                                int32_t RGB101010RangeMin, int32_t RGB101010RangeMax,
                                                const uint8_t permuteMap[4],
                                                vImage_Flags flags)
VIMAGE_NON_NULL(1,2)
__OSX_AVAILABLE_STARTING( __MAC_10_12, __IPHONE_9_3 ) __WATCHOS_AVAILABLE(__WATCHOS_3_0) __TVOS_AVAILABLE(__TVOS_10_0);
vImage_Error vImageConvert_ARGB16UToXRGB2101010(const vImage_Buffer *src,
                                                const vImage_Buffer *dest,
                                                int32_t RGB101010RangeMin, int32_t RGB101010RangeMax,
                                                const uint8_t permuteMap[4],
                                                vImage_Flags flags)
VIMAGE_NON_NULL(1,2)
__OSX_AVAILABLE_STARTING(__MAC_10_12, __IPHONE_9_3) __WATCHOS_AVAILABLE(__WATCHOS_3_0) __TVOS_AVAILABLE(__TVOS_10_0);
vImage_Error vImageConvert_ARGB16UToARGB2101010(const vImage_Buffer *src,
                                                const vImage_Buffer *dest,
                                                int32_t RGB101010RangeMin, int32_t RGB101010RangeMax,
                                                const uint8_t permuteMap[4],
                                                vImage_Flags flags)
VIMAGE_NON_NULL(1,2)
__OSX_AVAILABLE_STARTING(__MAC_10_12, __IPHONE_9_3) __WATCHOS_AVAILABLE(__WATCHOS_3_0) __TVOS_AVAILABLE(__TVOS_10_0);
vImage_Error vImageConvert_XRGB2101010ToARGBFFFF(const vImage_Buffer *src, Pixel_F alpha,
                                                 const vImage_Buffer *dest,
                                                 int32_t RGB101010RangeMin, int32_t RGB101010RangeMax,
                                                 const uint8_t permuteMap[4],
                                                 vImage_Flags flags)
VIMAGE_NON_NULL(1,3)
__OSX_AVAILABLE_STARTING( __MAC_10_12, __IPHONE_9_3 ) __WATCHOS_AVAILABLE(__WATCHOS_3_0) __TVOS_AVAILABLE(__TVOS_10_0);
vImage_Error vImageConvert_ARGB2101010ToARGBFFFF(const vImage_Buffer *src,
                                                 const vImage_Buffer *dest,
                                                 int32_t RGB101010RangeMin, int32_t RGB101010RangeMax,
                                                 const uint8_t permuteMap[4],
                                                 vImage_Flags flags)
VIMAGE_NON_NULL(1,2)
__OSX_AVAILABLE_STARTING( __MAC_10_12, __IPHONE_9_3 ) __WATCHOS_AVAILABLE(__WATCHOS_3_0) __TVOS_AVAILABLE(__TVOS_10_0);
vImage_Error vImageConvert_ARGBFFFFToXRGB2101010(const vImage_Buffer *src,
                                                 const vImage_Buffer *dest,
                                                 int32_t RGB101010RangeMin, int32_t RGB101010RangeMax,
                                                 const uint8_t permuteMap[4],
                                                 vImage_Flags flags)
VIMAGE_NON_NULL(1,2)
__OSX_AVAILABLE_STARTING(__MAC_10_12, __IPHONE_10_0) __WATCHOS_AVAILABLE(__WATCHOS_3_0) __TVOS_AVAILABLE(__TVOS_10_0);
vImage_Error vImageConvert_ARGBFFFFToARGB2101010(const vImage_Buffer *src,
                                                 const vImage_Buffer *dest,
                                                 int32_t RGB101010RangeMin, int32_t RGB101010RangeMax,
                                                 const uint8_t permuteMap[4],
                                                 vImage_Flags flags)
VIMAGE_NON_NULL(1,2)
__OSX_AVAILABLE_STARTING(__MAC_10_12, __IPHONE_10_0) __WATCHOS_AVAILABLE(__WATCHOS_3_0) __TVOS_AVAILABLE(__TVOS_10_0);
vImage_Error vImageConvert_XRGB2101010ToARGB16F(const vImage_Buffer *src, Pixel_F alpha,
                                                const vImage_Buffer *dest,
                                                int32_t RGB101010RangeMin, int32_t RGB101010RangeMax,
                                                const uint8_t permuteMap[4],
                                                vImage_Flags flags)
VIMAGE_NON_NULL(1,3)
__OSX_AVAILABLE_STARTING( __MAC_10_12, __IPHONE_9_3 ) __WATCHOS_AVAILABLE(__WATCHOS_3_0) __TVOS_AVAILABLE(__TVOS_10_0);
vImage_Error vImageConvert_ARGB2101010ToARGB16F(const vImage_Buffer *src,
                                                const vImage_Buffer *dest,
                                                int32_t RGB101010RangeMin, int32_t RGB101010RangeMax,
                                                const uint8_t permuteMap[4],
                                                vImage_Flags flags)
VIMAGE_NON_NULL(1,2)
__OSX_AVAILABLE_STARTING( __MAC_10_12, __IPHONE_9_3 ) __WATCHOS_AVAILABLE(__WATCHOS_3_0) __TVOS_AVAILABLE(__TVOS_10_0);
#ifdef __cplusplus
}
#endif
#endif
