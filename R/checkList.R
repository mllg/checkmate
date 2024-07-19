#' Check if an argument is a list
#'
#' @note
#' Contrary to R's \code{\link[base]{is.list}}, objects of type \code{\link[base]{data.frame}}
#' and \code{\link[base]{pairlist}} are not recognized as list.
#'
#' Missingness is defined here as elements of the list being \code{NULL}, analogously to \code{\link{anyMissing}}.
#'
#' The test for uniqueness does differentiate between the different NA types which are built-in in R.
#' This is required to be consistent with \code{\link[base]{unique}} while checking
#' scalar missing values. Also see the example.
#'
#' @templateVar fn List
#' @template x
#' @inheritParams checkVector
#' @param types [\code{character}]\cr
#'  Character vector of class names. Each list element must inherit
#'  from at least one of the provided types.
#'  The types \dQuote{logical}, \dQuote{integer}, \dQuote{integerish}, \dQuote{double},
#'  \dQuote{numeric}, \dQuote{complex}, \dQuote{character}, \dQuote{factor}, \dQuote{atomic}, \dQuote{vector}
#'  \dQuote{atomicvector}, \dQuote{array}, \dQuote{matrix}, \dQuote{list}, \dQuote{function},
#'  \dQuote{environment} and \dQuote{null} are supported.
#'  For other types \code{\link[base]{inherits}} is used as a fallback to check \code{x}'s inheritance.
#'  Defaults to \code{character(0)} (no check).
#' @template null.ok
#' @template checker
#' @family basetypes
#' @export
#' @useDynLib checkmate c_check_list
#' @examples
#' testList(list())
#' testList(as.list(iris), types = c("numeric", "factor"))
#'
#' # Missingness
#' testList(list(1, NA), any.missing = FALSE)
#' testList(list(1, NULL), any.missing = FALSE)
#'
#' # Uniqueness differentiates between different NA types:
#' testList(list(NA, NA), unique = TRUE)
#' testList(list(NA, NA_real_), unique = TRUE)
checkList = function(x, types = character(0L), any.missing = TRUE, all.missing = TRUE, len = NULL, min.len = NULL, max.len = NULL, unique = FALSE, names = NULL, null.ok = FALSE) {
  .Call(c_check_list, x, any.missing, all.missing, len, min.len, max.len, unique, names, null.ok) %and%
    checkListTypes(x, types)
}

checkListTypes = function(x, types = character(0L)) {
  if (length(x) == 0L || length(types) == 0L)
    return(TRUE)
  qassert(types, "S")

  ind = seq_along(x)
  for (type in types) {
    f = checkmate$listtypefuns[[type]] %??% function(x) inherits(x, type)
    ind = ind[!vapply(x[ind], f, FUN.VALUE = NA, USE.NAMES = FALSE)]
    if (length(ind) == 0L)
      return(TRUE)
  }
  sprintf("May only contain the following types: {%s}, but element %i has type '%s'", paste0(types, collapse = ","), ind[1L], paste0(class(x[[ind[1L]]]), collapse = ","))
}

#' @export
#' @rdname checkList
check_list = checkList

#' @export
#' @include makeAssertion.R
#' @template assert
#' @rdname checkList
assertList = makeAssertionFunction(checkList, use.namespace = FALSE)

#' @export
#' @rdname checkList
assert_list = assertList

#' @export
#' @include makeTest.R
#' @rdname checkList
testList = makeTestFunction(checkList)

#' @export
#' @rdname checkList
test_list = testList

#' @export
#' @include makeExpectation.R
#' @template expect
#' @rdname checkList
expect_list = makeExpectationFunction(checkList, use.namespace = FALSE)
