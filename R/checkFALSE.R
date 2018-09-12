#' Check if an argument is FALSE
#'
#' @description
#' Simply checks if an argument is \code{FALSE}.
#'
#' @templateVar fn FALSE.
#' @template x
#' @template na.ok
#' @template checker
#' @export
#' @examples
#' testFALSE(FALSE)
#' testFALSE(TRUE)
checkFALSE = function(x, na.ok = FALSE) {
  qassert(na.ok, "B1")
  if (isFALSE(x) || (na.ok && length(x) == 1L && is.na(x)))
    return(TRUE)
  return("Must be FALSE")
}

#' @export
#' @rdname checkFALSE
check_false = checkFALSE

#' @export
#' @include makeAssertion.R
#' @template assert
#' @rdname checkFALSE
assertFALSE = makeAssertionFunction(checkFALSE, use.namespace = FALSE)

#' @export
#' @rdname checkFALSE
assert_false = assertFALSE

#' @export
#' @include makeTest.R
#' @rdname checkFALSE
testFALSE = makeTestFunction(checkFALSE)

#' @export
#' @rdname checkFALSE
test_false = testFALSE
