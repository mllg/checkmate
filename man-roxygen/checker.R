#' @return Depending on the function prefix:
#'  If the check is successful, the functions 
#'  \code{assert<%= fn %>}/\code{assert_<%= convertCamelCase(fn) %>} return 
#'  \code{x} invisibly, whereas
#'  \code{check<%= fn %>}/\code{check_<%= convertCamelCase(fn) %>} and 
#'  \code{test<%= fn %>}/\code{test_<%= convertCamelCase(fn) %>} return 
#'  \code{TRUE}.
#'  If the check is not successful, 
#'  \code{assert<%= fn %>}/\code{assert_<%= convertCamelCase(fn) %>}
#'  throws an error message, 
#'  \code{test<%= fn %>}/\code{test_<%= convertCamelCase(fn) %>}
#'  returns \code{FALSE},
#'  and \code{check<%= fn %>}/\code{check_<%= convertCamelCase(fn) %>} 
#'  return a string with the error message.
#'  The function \code{expect_<%= convertCamelCase(fn) %>} always returns an
#'  \code{\link[testthat]{expectation}}.
