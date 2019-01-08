#ifndef __LA_OBJECT_HEADER__
#define __LA_OBJECT_HEADER__
#if __has_feature(assume_nonnull)
_Pragma("clang assume_nonnull begin")
#else
#define __nullable
#define __nonnull
#endif
#if OS_OBJECT_USE_OBJC
    OS_OBJECT_DECL(la_object);
#   define LA_RETURNS_RETAINED OS_OBJECT_RETURNS_RETAINED
#else
typedef struct la_s *la_object_t;
#   define LA_RETURNS_RETAINED
#endif
LA_FUNCTION LA_AVAILABILITY
la_object_t la_retain(la_object_t object);
#if OS_OBJECT_USE_OBJC
#   undef la_retain
#   define la_retain(object) [object retain]
#endif
LA_FUNCTION LA_AVAILABILITY
void la_release(la_object_t object);
#if OS_OBJECT_USE_OBJC
#   undef la_release
#   define la_release(object) [object release]
#endif
LA_FUNCTION LA_AVAILABILITY
void la_add_attributes(la_object_t object, la_attribute_t attributes);
LA_FUNCTION LA_AVAILABILITY
void la_remove_attributes(la_object_t object, la_attribute_t attributes);
LA_FUNCTION LA_AVAILABILITY
la_status_t la_status(la_object_t object);
#if __has_feature(assume_nonnull)
_Pragma("clang assume_nonnull end")
#endif
#endif 
