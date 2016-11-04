#' Check if an argument is TRUE
#'
#' @description
#' Simply checks if an argument is \code{TRUE}.
#'
#' @templateVar fn TRUE.
#' @template x
#' @template na.ok
#' @template checker
#' @export
#' @examples
#' testTRUE(TRUE)
#' testTRUE(FALSE)
checkTRUE = function(x, na.ok = FALSE) {
  qassert(na.ok, "B1")
  if (identical(x, TRUE) || (na.ok && length(x) == 1L && is.na(x)))
    return(TRUE)
  return("Must be TRUE")
}

#' @export
#' @rdname checkTRUE
check_true = checkTRUE

#' @export
#' @include makeAssertion.R
#' @template assert
#' @rdname checkTRUE
assertTRUE = makeAssertionFunction(checkTRUE)

#' @export
#' @rdname checkTRUE
assert_true = assertTRUE

#' @export
#' @include makeTest.R
#' @rdname checkTRUE
testTRUE = makeTestFunction(checkTRUE)

#' @export
#' @rdname checkTRUE
test_true = testTRUE
