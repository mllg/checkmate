#' @return Depending on the function prefix:
#'  If the check is successful, the functions return \code{TRUE}. If the check
#'  is not successful, \code{assert<%= fn %>}/\code{assert_<%= convertCamelCase(fn) %>}
#'  throws an error message, \code{test<%= fn %>}/\code{test_<%= convertCamelCase(fn) %>}
#'  returns \code{FALSE},
#'  and \code{check<%= fn %>} returns a string with the error message.
#'  The function \code{expect_<%= convertCamelCase(fn) %>} always returns an
#'  \code{\link[testthat]{expectation}}.
