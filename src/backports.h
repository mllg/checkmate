#include <R.h>
#include <Rinternals.h>

#ifndef LOGICAL_RO
#define LOGICAL_RO(x) ((const int *) LOGICAL(x))
#endif

#ifndef INTEGER_RO
#define INTEGER_RO(x) ((const int *) INTEGER(x))
#endif

#ifndef REAL_RO
#define REAL_RO(x) ((const double *) REAL(x))
#endif

#ifndef COMPLEX_RO
#define COMPLEX_RO(x) ((const Rcomplex *) COMPLEX(x))
#endif
