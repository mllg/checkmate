expect_succ_all = function(part, x, ...) {
  part = as.character(substitute(part))

  fun = match.fun(paste0("check", part))
  expect_true(fun(x, ...))
  fun = match.fun(paste0("test", part))
  expect_true(fun(x, ...))
  fun = match.fun(paste0("assert", part))
  expect_true(fun(x, ...))
  fun = match.fun(paste0("expect", killCamel(part)))
  expect_true(is.expectation((fun(x, ...))))
  invisible(TRUE)
}

expect_fail_all = function(part, x, ...) {
  part = as.character(substitute(part))
  xn = deparse(substitute(x))

  fun = match.fun(paste0("check", part))
  expect_true(testString(fun(x, ...)))
  fun = match.fun(paste0("test", part))
  expect_false(fun(x, ...))
  fun = match.fun(paste0("assert", part))
  expect_error(fun(x, ..., .var.name = xn), xn)
  expect_error(fun(x, ...), "'x'")
  fun = match.fun(paste0("expect", killCamel(part)))
  expect_error(with_reporter(SilentReporter(), fun(x, ...)))
  invisible(TRUE)
}
