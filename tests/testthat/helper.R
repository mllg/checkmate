expect_expectation_successful = function(expr, info = NULL, label = NULL) {
  res = tryCatch(expr, expectation = function(e) e)
  expect_is(res, "expectation_success", info = info, label = label)
}

expect_expectation_failed = function(expr, pattern = NULL, info = NULL, label = NULL) {
  x = tryCatch(expr, expectation = function(e) e)
  expect_is(x, "expectation_failure", info = info, label = label)
}

expect_succ_all = function(part, x, ..., cc = as.character(substitute(part)), lc = convertCamelCase(cc)) {
  xn = deparse(substitute(x))

  # check null.ok if it is in formals
  s = paste0("check", cc)
  fun = match.fun(s)
  if ("null.ok" %in% names(formals(fun))) {
    dots = list(...)
    dots["x"] = list(NULL)
    dots$null.ok = TRUE
    expect_true(do.call(fun, dots))
  }

  s = paste0("check", cc)
  fun = match.fun(s)
  expect_true(fun(x, ...), label = s)

  s = paste0("check_", lc)
  fun = match.fun(s)
  expect_true(fun(x, ...), label = s)

  s = paste0("test", cc)
  fun = match.fun(s)
  expect_true(fun(x, ...), info = s, label = xn)

  s = paste0("test_", lc)
  fun = match.fun(s)
  expect_true(fun(x, ...), info = s, label = xn)

  s = paste0("assert", cc)
  fun = match.fun(s)
  expect_identical(fun(x, ...), x, info = s, label = xn)

  s = paste0("assert_", lc)
  fun = match.fun(s)
  expect_identical(fun(x, ...), x, info = s, label = xn)

  s = paste0("expect_", lc)
  fun = match.fun(s)
  expect_expectation_successful(fun(x, ...), info = s, label = xn)

  invisible(TRUE)
}

expect_fail_all = function(part, x, ..., cc = as.character(substitute(part)), lc = convertCamelCase(cc)) {
  xn = deparse(substitute(x))

  # check null.ok if it is in formals
  s = paste0("check", cc)
  fun = match.fun(s)
  if ("null.ok" %in% names(formals(fun))) {
    dots = list(...)
    dots["x"] = list(NULL)
    dots$null.ok = FALSE
    expect_true(grepl("'NULL'", do.call(fun, dots), fixed = TRUE))
  }

  s = paste0("check", cc)
  fun = match.fun(s)
  res = fun(x, ...)
  expect_true(is.character(res) && nzchar(res), info = s, label = xn)

  s = paste0("test", cc)
  fun = match.fun(s)
  expect_false(fun(x, ...), info = s, label = xn)

  s = paste0("test_", lc)
  fun = match.fun(s)
  expect_false(fun(x, ...), info = s, label = xn)

  s = paste0("assert", cc)
  fun = match.fun(s)
  expect_error(fun(x, ..., .var.name = xn), xn, info = s, label = xn)
  expect_error(fun(x, ...), "'x'", info = s, label = xn)

  s = paste0("assert_", lc)
  fun = match.fun(s)
  expect_error(fun(x, ..., .var.name = xn), xn, info = s, label = xn)
  expect_error(fun(x, ...), "'x'", info = s, label = xn)

  s = paste0("expect_", lc)
  fun = match.fun(s)
  expect_expectation_failed(fun(x, ...), pattern = "x", info = s, label = xn)
  expect_expectation_failed(fun(x, ..., label = xn), pattern = xn, info = s, label = xn)

  invisible(TRUE)
}

vlapply = function (x, fun, ..., use.names = TRUE) {
    vapply(X = x, FUN = fun, ..., FUN.VALUE = NA, USE.NAMES = use.names)
}
