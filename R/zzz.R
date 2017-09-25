#' @description
#'
#' \describe{
#'   \item{Homepage:}{\url{https://github.com/mllg/checkmate}}
#'   \item{Bug Reports:}{\url{https://github.com/mllg/checkmate/issues}}
#' }
#'
#' @section Overview of implemented functions:
#'
#' Check scalars:
#' \itemize{
#'   \item{\code{\link{checkFlag}}}
#'   \item{\code{\link{checkCount}}}
#'   \item{\code{\link{checkNumber}}}
#'   \item{\code{\link{checkInt}}}
#'   \item{\code{\link{checkString}}}
#'   \item{\code{\link{checkScalar}}}
#'   \item{\code{\link{checkScalarNA}}}
#' }
#'
#' Check vectors:
#' \itemize{
#'   \item{\code{\link{checkLogical}}}
#'   \item{\code{\link{checkNumeric}}}
#'   \item{\code{\link{checkInteger}}}
#'   \item{\code{\link{checkIntegerish}}}
#'   \item{\code{\link{checkCharacter}}}
#'   \item{\code{\link{checkComplex}}}
#'   \item{\code{\link{checkFactor}}}
#'   \item{\code{\link{checkList}}}
#'   \item{\code{\link{checkVector}}}
#'   \item{\code{\link{checkAtomic}}}
#'   \item{\code{\link{checkAtomicVector}}}
#' }
#'
#' Check attributes:
#' \itemize{
#'   \item{\code{\link{checkClass}}}
#'   \item{\code{\link{checkNames}}}
#'   \item{\code{\link{checkNamed}}} (deprecated)
#' }
#'
#' Check compound types:
#' \itemize{
#'   \item{\code{\link{checkArray}}}
#'   \item{\code{\link{checkDataFrame}}}
#'   \item{\code{\link{checkMatrix}}}
#' }
#'
#' Check other built-in R types:
#' \itemize{
#'   \item{\code{\link{checkDate}}}
#'   \item{\code{\link{checkEnvironment}}}
#'   \item{\code{\link{checkFunction}}}
#'   \item{\code{\link{checkNull}}}
#' }
#'
#' Check sets:
#' \itemize{
#'   \item{\code{\link{checkChoice}}}
#'   \item{\code{\link{checkSubset}}}
#'   \item{\code{\link{checkSetEqual}}}
#' }
#'
#' File IO:
#' \itemize{
#'   \item{\code{\link{checkFileExists}}}
#'   \item{\code{\link{checkDirectoryExists}}}
#'   \item{\code{\link{checkPathForOutput}}}
#'   \item{\code{\link{checkAccess}}}
#' }
#'
#' Popular data types in external packages:
#' \itemize{
#'   \item{\code{\link{checkBit}}}
#'   \item{\code{\link{checkDataTable}}}
#'   \item{\code{\link{checkR6}}}
#'   \item{\code{\link{checkTibble}}}
#' }
#'
#' Safe coercion to integer:
#' \itemize{
#'   \item{\code{\link{asCount}}}
#'   \item{\code{\link{asInt}}}
#'   \item{\code{\link{asInteger}}}
#' }
#'
#' Quick argument checks using a DSL:
#' \itemize{
#'   \item{\code{\link{qassert}}}
#'   \item{\code{\link{qassertr}}}
#' }
#'
#' Misc:
#' \itemize{
#'   \item{\code{\link{checkOS}} (check operating system)}
#'   \item{\code{\link{assert}} (combine multiple checks into an assertion)}
#'   \item{\code{\link{anyMissing}}}
#'   \item{\code{\link{allMissing}}}
#'   \item{\code{\link{anyNaN}}}
#'   \item{\code{\link{wf}} (which.first and which.last)}
#' }
#'
#' @importFrom utils head tail packageVersion getFromNamespace
"_PACKAGE"

checkmate = new.env(parent = emptyenv())
checkmate$os = c("windows", "mac", "linux", "solaris")[match(tolower(Sys.info()["sysname"]), c("windows", "darwin", "linux", "sunos"))]
checkmate$listtypefuns = list2env(list(
  "logical"      = is.logical,
  "integer"      = is.integer,
  "integerish"   = isIntegerish,
  "double"       = is.double,
  "numeric"      = is.numeric,
  "complex"      = is.complex,
  "character"    = is.character,
  "factor"       = is.factor,
  "atomic"       = is.atomic,
  "vector"       = is.vector,
  "atomicvector" = function(x) !is.null(x) && is.atomic(x),
  "array"        = is.array,
  "matrix"       = is.matrix,
  "function"     = is.function,
  "environment"  = is.environment,
  "list"         = is.list,
  "null"         = is.null
))

.onLoad = function(libpath, pkgname) {
  backports::import(pkgname, "dir.exists")
}

.onUnload = function (libpath) {
  library.dynam.unload("checkmate", libpath) # nocov
}
