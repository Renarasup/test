#ifndef VIMAGE_ALPHA_H
#define VIMAGE_ALPHA_H	
#include <vImage/vImage_Types.h>
#ifdef __cplusplus
extern "C" {
#endif
vImage_Error	vImageAlphaBlend_Planar8( const vImage_Buffer *srcTop, const vImage_Buffer *srcTopAlpha, const vImage_Buffer *srcBottom, const vImage_Buffer *srcBottomAlpha, const vImage_Buffer *alpha, const vImage_Buffer *dest, vImage_Flags flags )  VIMAGE_NON_NULL(1,2,3,4,5,6)  __OSX_AVAILABLE_STARTING( __MAC_10_3, __IPHONE_5_0 );
vImage_Error	vImageAlphaBlend_PlanarF( const vImage_Buffer *srcTop, const vImage_Buffer *srcTopAlpha, const vImage_Buffer *srcBottom, const vImage_Buffer *srcBottomAlpha, const vImage_Buffer *alpha, const vImage_Buffer *dest, vImage_Flags flags )  VIMAGE_NON_NULL(1,2,3,4,5,6)  __OSX_AVAILABLE_STARTING( __MAC_10_3, __IPHONE_5_0 );
vImage_Error	vImageAlphaBlend_ARGB8888( const vImage_Buffer *srcTop, const vImage_Buffer *srcBottom, const vImage_Buffer *dest, vImage_Flags flags ) VIMAGE_NON_NULL(1,2,3)   __OSX_AVAILABLE_STARTING( __MAC_10_3, __IPHONE_5_0 );
vImage_Error	vImageAlphaBlend_ARGBFFFF( const vImage_Buffer *srcTop, const vImage_Buffer *srcBottom, const vImage_Buffer *dest, vImage_Flags flags ) VIMAGE_NON_NULL(1,2,3)  __OSX_AVAILABLE_STARTING( __MAC_10_3, __IPHONE_5_0 );
vImage_Error	vImagePremultipliedAlphaBlend_Planar8( const vImage_Buffer *srcTop,
                                                      const vImage_Buffer *srcTopAlpha,
                                                      const vImage_Buffer *srcBottom,
                                                      const vImage_Buffer *dest,
                                                      vImage_Flags flags )
                                                      VIMAGE_NON_NULL(1,2,3,4)
                                                      __OSX_AVAILABLE_STARTING( __MAC_10_3, __IPHONE_5_0 );
vImage_Error	vImagePremultipliedAlphaBlend_PlanarF( const vImage_Buffer *srcTop,
                                                      const vImage_Buffer *srcTopAlpha,
                                                      const vImage_Buffer *srcBottom,
                                                      const vImage_Buffer *dest,
                                                      vImage_Flags flags )
                                                      VIMAGE_NON_NULL(1,2,3,4)
                                                      __OSX_AVAILABLE_STARTING( __MAC_10_3, __IPHONE_5_0 );
vImage_Error	vImagePremultipliedAlphaBlend_ARGB8888( const vImage_Buffer *srcTop, const vImage_Buffer *srcBottom, const vImage_Buffer *dest, vImage_Flags flags ) VIMAGE_NON_NULL(1,2,3)   __OSX_AVAILABLE_STARTING( __MAC_10_3, __IPHONE_5_0 );
vImage_Error	vImagePremultipliedAlphaBlend_BGRA8888( const vImage_Buffer *srcTop, const vImage_Buffer *srcBottom, const vImage_Buffer *dest, vImage_Flags flags ) VIMAGE_NON_NULL(1,2,3)   __OSX_AVAILABLE_STARTING( __MAC_10_6, __IPHONE_5_0 );
#define         vImagePremultipliedAlphaBlend_RGBA8888( _srcTop, _srcBottom, _dest, _flags )    vImagePremultipliedAlphaBlend_BGRA8888((_srcTop), (_srcBottom), (_dest), (_flags))
vImage_Error	vImagePremultipliedAlphaBlend_ARGBFFFF( const vImage_Buffer *srcTop, const vImage_Buffer *srcBottom, const vImage_Buffer *dest, vImage_Flags flags ) VIMAGE_NON_NULL(1,2,3)   __OSX_AVAILABLE_STARTING( __MAC_10_3, __IPHONE_5_0 );
vImage_Error	vImagePremultipliedAlphaBlend_BGRAFFFF( const vImage_Buffer *srcTop, const vImage_Buffer *srcBottom, const vImage_Buffer *dest, vImage_Flags flags ) VIMAGE_NON_NULL(1,2,3)   __OSX_AVAILABLE_STARTING( __MAC_10_6, __IPHONE_5_0 );
#define         vImagePremultipliedAlphaBlend_RGBAFFFF( _srcTop, _srcBottom, _dest, _flags )    vImagePremultipliedAlphaBlend_BGRAFFFF((_srcTop), (_srcBottom), (_dest), (_flags))
vImage_Error vImagePremultipliedAlphaBlendWithPermute_ARGB8888(const vImage_Buffer *srcTop,
                                                               const vImage_Buffer *srcBottom,
                                                               const vImage_Buffer *dest,
                                                               const uint8_t permuteMap[4],
                                                               bool makeDestAlphaOpaque,
                                                               vImage_Flags flags )
                                                               VIMAGE_NON_NULL(1,2,3,4)
                                                               __OSX_AVAILABLE_STARTING( __MAC_10_9, __IPHONE_7_0 );
vImage_Error vImagePremultipliedAlphaBlendWithPermute_RGBA8888(const vImage_Buffer *srcTop, const vImage_Buffer *srcBottom, const vImage_Buffer *dest, const uint8_t permuteMap[4], bool makeDestAlphaOpaque, vImage_Flags flags ) VIMAGE_NON_NULL(1,2,3,4) __OSX_AVAILABLE_STARTING( __MAC_10_9, __IPHONE_7_0 );
vImage_Error	vImagePremultipliedAlphaBlendMultiply_RGBA8888( const vImage_Buffer *srcTop, const vImage_Buffer *srcBottom, const vImage_Buffer *dest, vImage_Flags flags ) VIMAGE_NON_NULL(1,2,3) __OSX_AVAILABLE_STARTING( __MAC_10_11, __IPHONE_9_0 ) __WATCHOS_AVAILABLE(__WATCHOS_2_0);
vImage_Error	vImagePremultipliedAlphaBlendScreen_RGBA8888( const vImage_Buffer *srcTop, const vImage_Buffer *srcBottom, const vImage_Buffer *dest, vImage_Flags flags ) VIMAGE_NON_NULL(1,2,3) __OSX_AVAILABLE_STARTING( __MAC_10_11, __IPHONE_9_0 ) __WATCHOS_AVAILABLE(__WATCHOS_2_0);
vImage_Error	vImagePremultipliedAlphaBlendDarken_RGBA8888( const vImage_Buffer *srcTop, const vImage_Buffer *srcBottom, const vImage_Buffer *dest, vImage_Flags flags ) VIMAGE_NON_NULL(1,2,3) __OSX_AVAILABLE_STARTING( __MAC_10_11, __IPHONE_9_0 ) __WATCHOS_AVAILABLE(__WATCHOS_2_0);
vImage_Error	vImagePremultipliedAlphaBlendLighten_RGBA8888( const vImage_Buffer *srcTop, const vImage_Buffer *srcBottom, const vImage_Buffer *dest, vImage_Flags flags ) VIMAGE_NON_NULL(1,2,3) __OSX_AVAILABLE_STARTING( __MAC_10_11, __IPHONE_9_0 ) __WATCHOS_AVAILABLE(__WATCHOS_2_0);
vImage_Error	vImagePremultiplyData_Planar8( const vImage_Buffer *src, const vImage_Buffer *alpha, const vImage_Buffer *dest, vImage_Flags flags ) VIMAGE_NON_NULL(1,2,3)   __OSX_AVAILABLE_STARTING( __MAC_10_3, __IPHONE_5_0 );
vImage_Error	vImagePremultiplyData_PlanarF( const vImage_Buffer *src, const vImage_Buffer *alpha, const vImage_Buffer *dest, vImage_Flags flags ) VIMAGE_NON_NULL(1,2,3)   __OSX_AVAILABLE_STARTING( __MAC_10_3, __IPHONE_5_0 );
vImage_Error	vImagePremultiplyData_ARGB8888( const vImage_Buffer *src, const vImage_Buffer *dest, vImage_Flags flags ) VIMAGE_NON_NULL(1,2)   __OSX_AVAILABLE_STARTING( __MAC_10_3, __IPHONE_5_0 );
vImage_Error	vImagePremultiplyData_ARGBFFFF( const vImage_Buffer *src, const vImage_Buffer *dest, vImage_Flags flags ) VIMAGE_NON_NULL(1,2)   __OSX_AVAILABLE_STARTING( __MAC_10_3, __IPHONE_5_0 );
vImage_Error	vImagePremultiplyData_RGBA8888( const vImage_Buffer *src, const vImage_Buffer *dest, vImage_Flags flags ) VIMAGE_NON_NULL(1,2)   __OSX_AVAILABLE_STARTING( __MAC_10_4, __IPHONE_5_0 );
#define         vImagePremultiplyData_BGRA8888( _src, _dest, _flags )           vImagePremultiplyData_RGBA8888((_src), (_dest), (_flags))
vImage_Error	vImagePremultiplyData_RGBAFFFF( const vImage_Buffer *src, const vImage_Buffer *dest, vImage_Flags flags ) VIMAGE_NON_NULL(1,2)   __OSX_AVAILABLE_STARTING( __MAC_10_4, __IPHONE_5_0 );
#define         vImagePremultiplyData_BGRAFFFF( _src, _dest, _flags )           vImagePremultiplyData_RGBAFFFF((_src), (_dest), (_flags))
vImage_Error	vImagePremultiplyData_ARGB16U( const vImage_Buffer *src, const vImage_Buffer *dest, vImage_Flags flags ) VIMAGE_NON_NULL(1,2) __OSX_AVAILABLE_STARTING( __MAC_10_8, __IPHONE_6_0 );
vImage_Error	vImagePremultiplyData_RGBA16U( const vImage_Buffer *src, const vImage_Buffer *dest, vImage_Flags flags ) VIMAGE_NON_NULL(1,2) __OSX_AVAILABLE_STARTING( __MAC_10_8, __IPHONE_6_0 );
#define         vImagePremultiplyData_BGRA16U( _src, _dest, _flags )           vImagePremultiplyData_RGBA16U((_src), (_dest), (_flags))
vImage_Error    vImagePremultiplyData_ARGB16Q12( const vImage_Buffer *src, const vImage_Buffer *dest, vImage_Flags flags ) VIMAGE_NON_NULL(1,2) __OSX_AVAILABLE_STARTING( __MAC_10_9, __IPHONE_7_0 );
vImage_Error    vImagePremultiplyData_RGBA16Q12( const vImage_Buffer *src, const vImage_Buffer *dest, vImage_Flags flags ) VIMAGE_NON_NULL(1,2) __OSX_AVAILABLE_STARTING( __MAC_10_9, __IPHONE_7_0 );
vImage_Error	vImageUnpremultiplyData_Planar8( const vImage_Buffer *src, const vImage_Buffer *alpha, const vImage_Buffer *dest, vImage_Flags flags ) VIMAGE_NON_NULL(1,2,3)   __OSX_AVAILABLE_STARTING( __MAC_10_3, __IPHONE_5_0 );
vImage_Error	vImageUnpremultiplyData_PlanarF( const vImage_Buffer *src, const vImage_Buffer *alpha, const vImage_Buffer *dest, vImage_Flags flags ) VIMAGE_NON_NULL(1,2,3)    __OSX_AVAILABLE_STARTING( __MAC_10_3, __IPHONE_5_0 );
vImage_Error	vImageUnpremultiplyData_ARGB8888( const vImage_Buffer *src, const vImage_Buffer *dest, vImage_Flags flags ) VIMAGE_NON_NULL(1,2)    __OSX_AVAILABLE_STARTING( __MAC_10_3, __IPHONE_5_0 );
vImage_Error	vImageUnpremultiplyData_RGBA8888( const vImage_Buffer *src, const vImage_Buffer *dest, vImage_Flags flags ) VIMAGE_NON_NULL(1,2)    __OSX_AVAILABLE_STARTING( __MAC_10_4, __IPHONE_5_0 );
#define         vImageUnpremultiplyData_BGRA8888( _src, _dest, _flags )             vImageUnpremultiplyData_RGBA8888((_src), (_dest), (_flags))
vImage_Error	vImageUnpremultiplyData_ARGBFFFF( const vImage_Buffer *src, const vImage_Buffer *dest, vImage_Flags flags ) VIMAGE_NON_NULL(1,2)    __OSX_AVAILABLE_STARTING( __MAC_10_3, __IPHONE_5_0 );
vImage_Error	vImageUnpremultiplyData_RGBAFFFF( const vImage_Buffer *src, const vImage_Buffer *dest, vImage_Flags flags ) VIMAGE_NON_NULL(1,2)    __OSX_AVAILABLE_STARTING( __MAC_10_4, __IPHONE_5_0 );
#define         vImageUnpremultiplyData_BGRAFFFF( _src, _dest, _flags )             vImageUnpremultiplyData_RGBAFFFF((_src), (_dest), (_flags))
vImage_Error	vImageUnpremultiplyData_ARGB16U( const vImage_Buffer *src, const vImage_Buffer *dest, vImage_Flags flags ) VIMAGE_NON_NULL(1,2) __OSX_AVAILABLE_STARTING( __MAC_10_8, __IPHONE_6_0 );
vImage_Error	vImageUnpremultiplyData_RGBA16U( const vImage_Buffer *src, const vImage_Buffer *dest, vImage_Flags flags ) VIMAGE_NON_NULL(1,2) __OSX_AVAILABLE_STARTING( __MAC_10_8, __IPHONE_6_0 );
#define         vImageUnpremultiplyData_BGRA16U( _src, _dest, _flags )             vImageUnpremultiplyData_RGBA16U((_src), (_dest), (_flags))
vImage_Error    vImageUnpremultiplyData_ARGB16Q12( const vImage_Buffer *src, const vImage_Buffer *dest, vImage_Flags flags ) VIMAGE_NON_NULL(1,2) __OSX_AVAILABLE_STARTING( __MAC_10_9, __IPHONE_7_0 );
vImage_Error    vImageUnpremultiplyData_RGBA16Q12( const vImage_Buffer *src, const vImage_Buffer *dest, vImage_Flags flags ) VIMAGE_NON_NULL(1,2) __OSX_AVAILABLE_STARTING( __MAC_10_9, __IPHONE_7_0 );
vImage_Error	vImagePremultipliedConstAlphaBlend_Planar8( const vImage_Buffer *srcTop, Pixel_8 constAlpha, const vImage_Buffer *srcTopAlpha, const vImage_Buffer *srcBottom, const vImage_Buffer *dest, vImage_Flags flags ) VIMAGE_NON_NULL(1,3,4,5)    __OSX_AVAILABLE_STARTING( __MAC_10_4, __IPHONE_5_0 );
vImage_Error	vImagePremultipliedConstAlphaBlend_PlanarF( const vImage_Buffer *srcTop, Pixel_F constAlpha, const vImage_Buffer *srcTopAlpha, const vImage_Buffer *srcBottom, const vImage_Buffer *dest, vImage_Flags flags ) VIMAGE_NON_NULL(1,3,4,5)    __OSX_AVAILABLE_STARTING( __MAC_10_4, __IPHONE_5_0 );
vImage_Error	vImagePremultipliedConstAlphaBlend_ARGB8888( const vImage_Buffer *srcTop, Pixel_8 constAlpha, const vImage_Buffer *srcBottom, const vImage_Buffer *dest, vImage_Flags flags ) VIMAGE_NON_NULL(1,3,4)    __OSX_AVAILABLE_STARTING( __MAC_10_4, __IPHONE_5_0 );
vImage_Error	vImagePremultipliedConstAlphaBlend_ARGBFFFF( const vImage_Buffer *srcTop, Pixel_F constAlpha, const vImage_Buffer *srcBottom, const vImage_Buffer *dest, vImage_Flags flags ) VIMAGE_NON_NULL(1,3,4)    __OSX_AVAILABLE_STARTING( __MAC_10_4, __IPHONE_5_0 );
vImage_Error	vImageAlphaBlend_NonpremultipliedToPremultiplied_Planar8( const vImage_Buffer *srcTop, const vImage_Buffer *srcTopAlpha, const vImage_Buffer *srcBottom, const vImage_Buffer *dest, vImage_Flags flags ) VIMAGE_NON_NULL(1,2,3,4)    __OSX_AVAILABLE_STARTING( __MAC_10_4, __IPHONE_5_0 );
vImage_Error	vImageAlphaBlend_NonpremultipliedToPremultiplied_PlanarF( const vImage_Buffer *srcTop, const vImage_Buffer *srcTopAlpha, const vImage_Buffer *srcBottom, const vImage_Buffer *dest, vImage_Flags flags ) VIMAGE_NON_NULL(1,2,3,4)    __OSX_AVAILABLE_STARTING( __MAC_10_4, __IPHONE_5_0 );
vImage_Error	vImageAlphaBlend_NonpremultipliedToPremultiplied_ARGB8888( const vImage_Buffer *srcTop, const vImage_Buffer *srcBottom, const vImage_Buffer *dest, vImage_Flags flags ) VIMAGE_NON_NULL(1,2,3)    __OSX_AVAILABLE_STARTING( __MAC_10_4, __IPHONE_5_0 );
vImage_Error	vImageAlphaBlend_NonpremultipliedToPremultiplied_ARGBFFFF( const vImage_Buffer *srcTop, const vImage_Buffer *srcBottom, const vImage_Buffer *dest, vImage_Flags flags ) VIMAGE_NON_NULL(1,2,3)    __OSX_AVAILABLE_STARTING( __MAC_10_4, __IPHONE_5_0 );
vImage_Error vImageClipToAlpha_Planar8( const vImage_Buffer *src, const vImage_Buffer *alpha, const vImage_Buffer *dest, vImage_Flags flags ) VIMAGE_NON_NULL(1,2,3) __OSX_AVAILABLE_STARTING( __MAC_10_4, __IPHONE_5_0 );
vImage_Error vImageClipToAlpha_PlanarF( const vImage_Buffer *src,  const vImage_Buffer *alpha,  const vImage_Buffer *dest, vImage_Flags flags ) VIMAGE_NON_NULL(1,2,3) __OSX_AVAILABLE_STARTING( __MAC_10_4, __IPHONE_5_0 );
vImage_Error vImageClipToAlpha_ARGB8888( const vImage_Buffer *src, const vImage_Buffer *dest, vImage_Flags flags ) VIMAGE_NON_NULL(1,2) __OSX_AVAILABLE_STARTING( __MAC_10_4, __IPHONE_5_0 );
vImage_Error vImageClipToAlpha_ARGBFFFF( const vImage_Buffer *src, const vImage_Buffer *dest, vImage_Flags flags ) VIMAGE_NON_NULL(1,2) __OSX_AVAILABLE_STARTING( __MAC_10_4, __IPHONE_5_0 );
vImage_Error vImageClipToAlpha_RGBA8888( const vImage_Buffer *src, const vImage_Buffer *dest, vImage_Flags flags ) VIMAGE_NON_NULL(1,2) __OSX_AVAILABLE_STARTING( __MAC_10_8, __IPHONE_6_0 );
#define vImageClipToAlpha_BGRA8888(_src, _dest, _flags)   vImageClipToAlpha_RGBA8888((_src), (_dest), (_flags))
vImage_Error vImageClipToAlpha_RGBAFFFF( const vImage_Buffer *src, const vImage_Buffer *dest, vImage_Flags flags ) VIMAGE_NON_NULL(1,2) __OSX_AVAILABLE_STARTING( __MAC_10_8, __IPHONE_6_0 );
#define vImageClipToAlpha_BGRAFFFF(_src, _dest, _flags)   vImageClipToAlpha_RGBAFFFF((_src), (_dest), (_flags))
#ifdef __cplusplus
}
#endif
#endif 
