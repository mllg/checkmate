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
  os.names = c("windows", "mac", "linux", "solaris")
  sys.names = c("windows", "darwin", "linux", "sunos")

  ok = match.arg(os, os.names, several.ok = TRUE)
  os = os.names[match(tolower(Sys.info()["sysname"]), sys.names)]

  if (os %nin% ok)
    return(sprintf("OS must be %s", collapse(ok, " or ")))
  return(TRUE)
}

#' @export
#' @include makeAssertion.r
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
#' @include makeTest.r
#' @rdname checkOS
testOS = makeTestFunction(checkOS)

#' @export
#' @rdname checkOS
test_os = testOS

#' @export
#' @include makeExpectation.r
#' @template expect
#' @rdname checkOS
expect_os = function(os, info = NULL, label = NULL) {
  res = checkOS(os)
  makeExpectation(os, res, info, label = label %??% "Operating System")
}
