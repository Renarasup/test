#ifndef VIMAGE_BASIC_IMAGE_TYPES_H
#define VIMAGE_BASIC_IMAGE_TYPES_H	
#include <vImage/vImage_Types.h>
#ifdef __cplusplus
extern "C" {
#endif
enum
{
    kvImage_PNG_FILTER_VALUE_NONE  = 0,
    kvImage_PNG_FILTER_VALUE_SUB   = 1,
    kvImage_PNG_FILTER_VALUE_UP    = 2,
    kvImage_PNG_FILTER_VALUE_AVG   = 3,
    kvImage_PNG_FILTER_VALUE_PAETH = 4
};
vImage_Error  vImagePNGDecompressionFilter( const vImage_Buffer *buffer, 
                                            vImagePixelCount    startScanline,
                                            vImagePixelCount    scanlineCount,
                                            uint32_t            bitsPerPixel,          
                                            uint32_t            filterMethodNumber, 
                                            uint32_t            filterType,         
                                            vImage_Flags        flags)  __OSX_AVAILABLE_STARTING( __MAC_10_4, __IPHONE_5_0 );
#ifdef __cplusplus
}
#endif
#endif
