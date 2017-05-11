# runexec runs the script in a special environment,
# everything set in .Rprofile is ignored
# .libPaths("/home/lang/.R/library")

args = commandArgs(TRUE)
x = runif(1e7)

asserts = list(
  checkmate = function(x) { library(checkmate); try(assertNumeric(x, any.missing = FALSE, lower = 0), silent = TRUE) },
  qcheckmate = function(x) { library(checkmate); try(qassert(x, "N[0,]"), silent = TRUE) },
  R = function(x) { try(stopifnot(is.numeric(x), all(!is.na(x)), all(x >= 0)), silent = TRUE) },
  assertthat = function(x) { library(assertthat); try(assert_that(is.numeric(x), all(!is.na(x)), all(x >= 0)), silent = TRUE) },
  assertive = function(x) { library(assertive); try({assert_is_numeric(x); assert_all_are_not_na(x); assert_all_are_greater_than_or_equal_to(x, 0)}, silent = TRUE) },
  noop = function(x) { x }
)

fun = asserts[[args[1]]]
fun(x)

quit(status = 0, save = "no")
