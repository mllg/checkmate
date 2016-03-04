#' Check if an argument is a list
#'
#' @templateVar fn List
#' @template x
#' @inheritParams checkVector
#' @param ... [any]\cr
#'  Additional parameters used in a call of \code{\link{checkVector}}.
#' @param types [\code{character}]\cr
#'  Character vector of class names. Each list element must inherit
#'  from at least one of the provided types.
#'  The types \dQuote{logical}, \dQuote{integer}, \dQuote{integerish}, \dQuote{double},
#'  \dQuote{numeric}, \dQuote{complex}, \dQuote{character}, \dQuote{factor}, \dQuote{atomic}, \dQuote{vector}
#'  \dQuote{atomicvector}, \dQuote{array}, \dQuote{matrix}, \dQuote{list}, \dQuote{function},
#'  \dQuote{environment} and \dQuote{null} are supported.
#'  For other types \code{\link[base]{inherits}} is used as a fallback to check \code{x}'s inheritance.
#'  Defaults to \code{character(0)} (no check).
#' @template checker
#' @family basetypes
#' @export
#' @useDynLib checkmate c_check_list
#' @examples
#' testList(list())
#' testList(as.list(iris), types = c("numeric", "factor"))
checkList = function(x, types = character(0L), any.missing = TRUE, all.missing = TRUE, len = NULL, min.len = NULL, max.len = NULL, unique = FALSE, names = NULL) {
  .Call(c_check_list, x, any.missing, all.missing, len, min.len, max.len, unique, names) %and%
  checkListTypes(x, types)
}

checkListTypes = function(x, types = character(0L)) {
  if (length(types) == 0L)
    return(TRUE)
  qassert(types, "S")

  ind = seq_along(x)
  for (type in types) {
    f = switch(type,
      "logical" = is.logical,
      "integer" = is.integer,
      "integerish" = isIntegerish,
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
      "null" = is.null,
      function(x) inherits(x, type)
    )
    ind = ind[!vapply(x[ind], f, FUN.VALUE = NA, USE.NAMES = FALSE)]
    if (length(ind) == 0L)
      return(TRUE)
  }
  return(sprintf("May only contain the following types: %s", collapse(types)))
}

#' @export
#' @include makeAssertion.r
#' @template assert
#' @rdname checkList
assertList = makeAssertionFunction(checkList)

#' @export
#' @rdname checkList
assert_list = assertList

#' @export
#' @include makeTest.r
#' @rdname checkList
testList = makeTestFunction(checkList)

#' @export
#' @rdname checkList
test_list = testList

#' @export
#' @include makeExpectation.r
#' @template expect
#' @rdname checkList
expect_list = makeExpectationFunction(checkList)
