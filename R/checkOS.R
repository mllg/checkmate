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
  ok = match.arg(os, os.names, several.ok = TRUE)

  if (getOS() %nin% ok)
    return(sprintf("OS must be %s", paste0(ok, collapse = " or ")))
  return(TRUE)
}

getOS = function() {
  os.names = c("windows", "mac", "linux", "solaris")
  sys.names = c("windows", "darwin", "linux", "sunos")
  os = os.names[match(tolower(Sys.info()["sysname"]), sys.names)]
}

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
  makeExpectation(getOS(), res, info, label = label %??% "Operating System")
}
