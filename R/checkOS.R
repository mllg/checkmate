#' Check the operating system
#'
#' @templateVar fn OS
#' @param os [\code{character(1)}]\cr
#'  Check the operating system to be in a set with possible elements \dQuote{windows},
#'  \dQuote{mac}, \dQuote{linux} and \dQuote{solaris}.
#' @template checker
#' @export
#' @examples
#' testOS("linux")
checkOS = function(os) {
  ok = match.arg(os, c("windows", "mac", "linux", "solaris"), several.ok = TRUE)
  if (checkmate$os %nin% ok)
    return(sprintf("OS must be %s", paste0(ok, collapse = " or ")))
  return(TRUE)
}

#' @export
#' @rdname checkOS
check_os = checkOS

#' @export
#' @include makeAssertion.R
#' @template assert
#' @rdname checkOS
assertOS = function(os, add = NULL, .var.name = NULL) {
  res = checkOS(os)
  makeAssertion(os, res, .var.name %??% "Operating System", add)
}

#' @export
#' @rdname checkOS
assert_os = assertOS

#' @export
#' @include makeTest.R
#' @rdname checkOS
testOS = makeTestFunction(checkOS)

#' @export
#' @rdname checkOS
test_os = testOS

#' @export
#' @include makeExpectation.R
#' @template expect
#' @rdname checkOS
expect_os = function(os, info = NULL, label = NULL) {
  res = checkOS(os)
  makeExpectation(checkmate$os, res, info, label = label %??% "Operating System")
}
