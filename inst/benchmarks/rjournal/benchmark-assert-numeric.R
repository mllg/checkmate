library(microbenchmark)
library(checkmate)
library(assertive)
library(assertthat)

bench = function(x, funs, repeats = 100) {
  force(x)
  microbenchmark(times = repeats,
    assertive = funs$assertive(x),
    assertthat = funs$assertthat(x),
    R = funs$R(x),
    qcheckmate = funs$qcheckmate(x),
    checkmate = funs$checkmate(x)
  )
}

################################################################################
### benchmark assert_numeric
################################################################################
tests = list(
  checkmate = function(x) { testNumeric(x, any.missing = FALSE, lower = 0) },
  qcheckmate = function(x) { qtest(x, "N[0,]") },
  R = function(x) { (is.numeric(x) && all(!is.na(x)) && all(x >= 0)) },
  assertthat = function(x) { see_if(is.numeric(x), all(!is.na(x)), all(x >= 0)) },
  assertive = function(x) { is_numeric(x) && all(is_not_na(x)) && all(is_greater_than(x, 0)) }
)

asserts = list(
  checkmate = function(x) { try(assertNumeric(x, any.missing = FALSE, lower = 0), silent = TRUE) },
  qcheckmate = function(x) { try(qassert(x, "N[0,]"), silent = TRUE) },
  R = function(x) { try(stopifnot(is.numeric(x), all(!is.na(x)), all(x >= 0)), silent = TRUE) },
  assertthat = function(x) { try(assert_that(is.numeric(x), all(!is.na(x)), all(x >= 0)), silent = TRUE) },
  assertive = function(x) { try({assert_is_numeric(x); assert_all_are_not_na(x); assert_all_are_greater_than_or_equal_to(x, 0)}, silent = TRUE) }
)

repeats = 100
results = list()
results$test_type_fail = bench("a", tests, repeats)
results$test_type_succ = bench(runif(1), tests, repeats)
results$test_long = bench(runif(1e6), tests, repeats)
results$test_stop_na = bench(replace(runif(1e6), 1, NA), tests, repeats)
results$assert_type_fail = bench("a", asserts, repeats)
results$assert_type_succ = bench(runif(1), asserts, repeats)
results$assert_long = bench(runif(1e6), asserts, repeats)
results$assert_stop_na = bench(replace(runif(1e6), 1, NA), asserts, repeats)
results$assert_negative = bench(replace(runif(1e6), floor(1e6 / 2), -1), asserts, 100)

saveRDS(results, file = "benchmark-assert-numeric.rds")
