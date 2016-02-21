expect_expectation_successful = function(expr) {
  res = with_reporter(ListReporter(), expr)
  expect_false(res$failed)
}

expect_expectation_failed = function(expr, pattern = NULL) {
  res = with_reporter(ListReporter(), force(expr))
  expect_true(res$failed)
  if (!is.null(pattern)) {
    msg = res$current_test_results[[1L]]$failure_msg
    expect_true(grepl(pattern, msg))
  }
}

expect_succ_all = function(part, x, ..., cc = as.character(substitute(part)), lc = convertCamelCase(cc)) {
  fun = match.fun(paste0("check", cc))
  expect_true(fun(x, ...))

  fun = match.fun(paste0("test", cc))
  expect_true(fun(x, ...))

  fun = match.fun(paste0("test_", lc))
  expect_true(fun(x, ...))

  fun = match.fun(paste0("assert", cc))
  expect_identical(fun(x, ...), x)

  fun = match.fun(paste0("assert_", lc))
  expect_identical(fun(x, ...), x)

  fun = match.fun(paste0("expect_", lc))
  expect_expectation_successful(fun(x, ...))

  invisible(TRUE)
}

expect_fail_all = function(part, x, ..., cc = as.character(substitute(part)), lc = convertCamelCase(cc)) {
  xn = deparse(substitute(x))

  fun = match.fun(paste0("check", cc))
  expect_true(testString(fun(x, ...), min.chars = 1L))

  fun = match.fun(paste0("test", cc))
  expect_false(fun(x, ...))

  fun = match.fun(paste0("test_", lc))
  expect_false(fun(x, ...))

  fun = match.fun(paste0("assert", cc))
  expect_error(fun(x, ..., .var.name = xn), xn)
  expect_error(fun(x, ...), "'x'")

  fun = match.fun(paste0("assert_", lc))
  expect_error(fun(x, ..., .var.name = xn), xn)
  expect_error(fun(x, ...), "'x'")

  fun = match.fun(paste0("expect_", lc))
  expect_expectation_failed(fun(x, ...), "x")
  expect_expectation_failed(fun(x, ..., label = xn), xn)

  invisible(TRUE)
}
