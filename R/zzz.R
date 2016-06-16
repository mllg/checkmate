#' @details
#'
#' \describe{
#'   \item{Homepage:}{\url{https://github.com/mllg/checkmate}}
#' }
#' @import backports
#' @importFrom utils head tail
#' @importFrom tools file_ext
"_PACKAGE"

.onUnload <- function (libpath) {
  library.dynam.unload("checkmate", libpath) # nocov
}

### Globals
.CHECKLISTTYPEFUNS = list(
  "logical" = is.logical,
  "integer" = is.integer,
  "integerish" = function(x) isIntegerish(x),
  "double" = is.double,
  "numeric" = is.numeric,
  "complex" = is.complex,
  "character" = is.character,
  "factor" = is.factor,
  "atomic" = is.atomic,
  "vector" = is.vector,
  "atomicvector" = function(x) !is.null(x) && is.atomic(x),
  "array" = is.array,
  "matrix" = is.matrix,
  "function" = is.function,
  "environment" = is.environment,
  "list" = is.list,
  "null" = is.null
)

.OS = c("windows", "mac", "linux", "solaris")[match(tolower(Sys.info()["sysname"]), c("windows", "darwin", "linux", "sunos"))]
