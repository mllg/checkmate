#' @section Check scalars:
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
#' @section Check vectors:
#' \itemize{
#'   \item{\code{\link{checkLogical}}}
#'   \item{\code{\link{checkNumeric}}}
#'   \item{\code{\link{checkDouble}}}
#'   \item{\code{\link{checkInteger}}}
#'   \item{\code{\link{checkIntegerish}}}
#'   \item{\code{\link{checkCharacter}}}
#'   \item{\code{\link{checkComplex}}}
#'   \item{\code{\link{checkFactor}}}
#'   \item{\code{\link{checkList}}}
#'   \item{\code{\link{checkPOSIXct}}}
#'   \item{\code{\link{checkVector}}}
#'   \item{\code{\link{checkAtomic}}}
#'   \item{\code{\link{checkAtomicVector}}}
#'   \item{\code{\link{checkRaw}}}
#' }
#'
#' @section Check attributes:
#' \itemize{
#'   \item{\code{\link{checkClass}}}
#'   \item{\code{\link{checkMultiClass}}}
#'   \item{\code{\link{checkNames}}}
#'   \item{\code{\link{checkNamed}}} (deprecated)
#' }
#'
#' @section Check compound types:
#' \itemize{
#'   \item{\code{\link{checkArray}}}
#'   \item{\code{\link{checkDataFrame}}}
#'   \item{\code{\link{checkMatrix}}}
#' }
#'
#' @section Check other built-in R types:
#' \itemize{
#'   \item{\code{\link{checkDate}}}
#'   \item{\code{\link{checkEnvironment}}}
#'   \item{\code{\link{checkFunction}}}
#'   \item{\code{\link{checkFormula}}}
#'   \item{\code{\link{checkNull}}}
#' }
#'
#' @section Check sets:
#' \itemize{
#'   \item{\code{\link{checkChoice}}}
#'   \item{\code{\link{checkSubset}}}
#'   \item{\code{\link{checkSetEqual}}}
#'   \item{\code{\link{checkDisjunct}}}
#' }
#'
#' @section File IO:
#' \itemize{
#'   \item{\code{\link{checkFileExists}}}
#'   \item{\code{\link{checkDirectoryExists}}}
#'   \item{\code{\link{checkPathForOutput}}}
#'   \item{\code{\link{checkAccess}}}
#' }
#'
#' @section Popular data types of third party packages:
#' \itemize{
#'   \item{\code{\link{checkDataTable}}}
#'   \item{\code{\link{checkR6}}}
#'   \item{\code{\link{checkTibble}}}
#' }
#'
#' @section Safe coercion to integer:
#' \itemize{
#'   \item{\code{\link{asCount}}}
#'   \item{\code{\link{asInt}}}
#'   \item{\code{\link{asInteger}}}
#' }
#'
#' @section Quick argument checks using a DSL:
#' \itemize{
#'   \item{\code{\link{qassert}}}
#'   \item{\code{\link{qassertr}}}
#' }
#'
#' @section Misc:
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


register_tinytest = function() {
  ns = getNamespace("checkmate")
  expectations = names(ns)[grepl("^expect_", names(ns))]
  tinytest::register_tinytest_extension("checkmate", expectations)
}

.onLoad = function(libpath, pkgname) {
  backports::import(pkgname)
  if ("tinytest" %in% loadedNamespaces())
    register_tinytest()
  setHook(packageEvent("tinytest", "onLoad"), function(...) register_tinytest(), action = "append")
}

.onUnload = function (libpath) {
  library.dynam.unload("checkmate", libpath) # nocov
}
