#' Check file system access rights
#'
#' @templateVar fn Access
#' @template x
#' @param access [\code{character(1)}]\cr
#'  Single string containing possible characters \sQuote{r}, \sQuote{w} and \sQuote{x} to
#'  force a check for read, write or execute access rights, respectively.
#'  Write and executable rights are not checked on Windows.
#' @template checker
#' @family filesystem
#' @export
#' @examples
#' # Is R's home directory readable?
#' testAccess(R.home(), "r")
#'
#' # Is R's home directory writeable?
#' testAccess(R.home(), "w")
checkAccess = function(x, access = "") {
  qassert(access, "S1")
  if (nzchar(access)) {
    access = match(strsplit(access, "")[[1L]], c("r", "w", "x"))
    if (anyMissing(access) || anyDuplicated(access) > 0L)
      stop("Access pattern invalid, allowed are 'r', 'w' and 'x'")

    if (1L %in% access) {
      w = wf(file.access(x, 4L) != 0L)
      if (length(w) > 0L)
        return(sprintf("'%s' not readable", x[w]))
    }
    if (.Platform$OS.type != "windows") {
      if (2L %in% access) {
        w = wf(file.access(x, 2L) != 0L)
        if (length(w) > 0L)
          return(sprintf("'%s' not writeable", x[w]))
      }
      if (3L %in% access) {
        w = wf(file.access(x, 1L) != 0L)
        if (length(w) > 0L)
          return(sprintf("'%s' not executeable", x[w]))
      }
    }
  }
  return(TRUE)
}

#' @export
#' @rdname checkAccess
check_access = checkAccess

#' @export
#' @include makeAssertion.R
#' @template assert
#' @rdname checkAccess
assertAccess = makeAssertionFunction(checkAccess)

#' @export
#' @rdname checkAccess
assert_access = assertAccess

#' @export
#' @include makeTest.R
#' @rdname checkAccess
testAccess = makeTestFunction(checkAccess)

#' @export
#' @rdname checkAccess
test_access = testAccess

#' @export
#' @include makeExpectation.R
#' @template expect
#' @rdname checkAccess
expect_access = makeExpectationFunction(checkAccess)
