#ifndef __LA_BASE_HEADER__
#define __LA_BASE_HEADER__
#include <os/object.h>
#include <stddef.h>
#include <Availability.h>
#define LA_AVAILABILITY  __OSX_AVAILABLE_STARTING(__MAC_10_10,__IPHONE_8_0)
#define LA_NONNULL1      OS_NONNULL1
#define LA_NONNULL       OS_NONNULL_ALL
#define LA_EXPORT        OS_EXPORT
#define LA_NOTHROW       OS_NOTHROW
#define LA_FUNCTION      OS_EXPORT OS_NOTHROW
#define LA_CONST         OS_CONST
#define LA_DEFAULT_ATTRIBUTES           (0)
#define LA_ATTRIBUTE_ENABLE_LOGGING     (1U << 0)
typedef unsigned long la_attribute_t;
#define LA_SUCCESS                       (0)
#define LA_WARNING_POORLY_CONDITIONED    (1000)
#define LA_INTERNAL_ERROR                (-1000)
#define LA_INVALID_PARAMETER_ERROR       (-1001)
#define LA_DIMENSION_MISMATCH_ERROR      (-1002)
#define LA_PRECISION_MISMATCH_ERROR      (-1003)
#define LA_SINGULAR_ERROR                (-1004)
#define LA_SLICE_OUT_OF_BOUNDS_ERROR     (-1005)
typedef long la_status_t;
#define LA_SCALAR_TYPE_FLOAT  (0x8000)
#define LA_SCALAR_TYPE_DOUBLE (0x4000)
typedef unsigned int la_scalar_type_t;
typedef unsigned long la_count_t;
typedef long la_index_t;
typedef void (*la_deallocator_t)(void *ptr);
#endif 
