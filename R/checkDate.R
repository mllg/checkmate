#' Check that an argument is a Date
#'
#' @description
#' Checks that an object is of class \code{\link[base]{Date}}.
#'
#'
#' @templateVar fn Atmoic
#' @template x
#' @param lower [\code{\link[base]{Date}}]\cr
#'  All dates in \code{x} must be after this date. Comparison is done via \code{\link[base]{Ops.Date}}.
#' @param upper [\code{\link[base]{Date}}]\cr
#'  All dates in \code{x} must be before this date. Comparison is done via \code{\link[base]{Ops.Date}}.
#' @template null.ok
#' @inheritParams checkVector
#' @template checker
#' @export
checkDate = function(x, lower = NULL, upper = NULL, any.missing = TRUE, all.missing = TRUE, len = NULL, min.len = NULL, max.len = NULL, unique = FALSE, null.ok = FALSE) {
  if (is.null(x)) {
    if (isTRUE(null.ok))
      return(TRUE)
    return("Must be of class 'Date', not 'NULL'")
  }
  if (!inherits(x, "Date"))
    return(sprintf("Must be of class 'Date'%s, not '%s'", if (isTRUE(null.ok)) " (or 'NULL')" else "", guessType(x)))
  checkInteger(as.integer(x), any.missing = any.missing, all.missing = all.missing, len = len, min.len = min.len, max.len = max.len, unique = unique) %and%
    checkDateBounds(x, lower, upper)
}

checkDateBounds = function(x, lower, upper) {
  if (!is.null(lower)) {
    lower = as.Date(lower, origin = "1970-01-01")
    if (length(lower) != 1L || is.na(lower))
      stop("Argument 'lower' must be a single (non-missing) date")
    if (any(x < lower))
      return(sprintf("Date must be >= %s", lower))
  }

  if (!is.null(upper)) {
    upper = as.Date(upper, origin = "1970-01-01")
    if (length(upper) != 1L || is.na(upper))
      stop("Argument 'upper' must be a single (non-missing) date")
    if (any(x > upper))
      return(sprintf("Date must be <= %s", upper))
  }
  return(TRUE)
}

#' @export
#' @rdname checkDate
check_date = checkDate

#' @export
#' @include makeAssertion.R
#' @template assert
#' @rdname checkDate
assertDate = makeAssertionFunction(checkDate)

#' @export
#' @rdname checkDate
assert_date = assertDate

#' @export
#' @include makeTest.R
#' @rdname checkDate
testDate = makeTestFunction(checkDate)

#' @export
#' @rdname checkDate
test_date = testDate

#' @export
#' @include makeExpectation.R
#' @template expect
#' @rdname checkDate
expect_date = makeExpectationFunction(checkDate)
