#ifndef __QUADRATURE_PUBLIC_HEADER__
#define __QUADRATURE_PUBLIC_HEADER__
#ifdef __cplusplus
extern "C" {
#endif
typedef enum {
  QUADRATURE_SUCCESS                          =    0,
  QUADRATURE_ERROR                            =   -1,
  QUADRATURE_INVALID_ARG_ERROR                =   -2,
  QUADRATURE_ALLOC_ERROR                      =   -3,
  QUADRATURE_INTERNAL_ERROR                   =  -99,
  QUADRATURE_INTEGRATE_MAX_EVAL_ERROR         = -101,
  QUADRATURE_INTEGRATE_BAD_BEHAVIOUR_ERROR    = -102
} quadrature_status;
#include "Integration.h"
#ifdef __cplusplus
}
#endif
#endif 
