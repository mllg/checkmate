expect_succ = function(part, x, ...) {
  part = as.character(substitute(part))

  fun = match.fun(paste0("check", part))
  expect_true(fun(x, ...))
  fun = match.fun(paste0("test", part))
  expect_true(fun(x, ...))
  fun = match.fun(paste0("assert", part))
  expect_true(fun(x, ...))
  invisible(TRUE)
}

expect_fail = function(part, x, ...) {
  part = as.character(substitute(part))
  xn = deparse(substitute(x))

  fun = match.fun(paste0("check", part))
  expect_true(testString(fun(x, ...)))
  fun = match.fun(paste0("test", part))
  expect_false(fun(x, ...))
  fun = match.fun(paste0("assert", part))
  expect_error(fun(x, ..., .var.name = xn), xn)
  expect_error(fun(x, ...), "'x'")
  invisible(TRUE)
}
