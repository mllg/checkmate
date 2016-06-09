context("qtest")

xb = logical(10); xb[5] = NA
xi = integer(10); xi[5] = NA
xr = double(10); xr[5] = NA
xc = complex(10); xc[5] = NA
xl = as.list(1:10); xl[5] = list(NULL)
xm = matrix(1:9, 3); xm[2, 3] = NA
xd = data.frame(a=1:5, b=1:5); xd$b[3] = NA
xf = factor(letters[1:10]); xf[5] = NA
xe = new.env(); xe$foo = 1

expect_succ_all = function(x, rules) {
  xn = deparse(substitute(x))
  expect_true(qtest(x, rules),
    info = sprintf("rules: %s", paste(rules, collapse=",")), label = xn)
  expect_identical(qassert(x, rules), x,
    info = sprintf("rules: %s", paste(rules, collapse=",")), label = xn)
  expect_expectation_successful(qexpect(x, rules),
    info = sprintf("rules: %s", paste(rules, collapse=",")), label = xn)
}

expect_fail_all = function(x, rules, pattern = NULL) {
  xn = deparse(substitute(x))
  expect_false(qtest(x, rules),
    info = sprintf("rules: %s", paste0(rules, collapse=",")), label = xn)
  expect_error(qassert(x, rules), regex = pattern,
    info = sprintf("rules: %s", paste0(rules, collapse=",")), label = xn)
  expect_expectation_failed(qexpect(x, rules),
    info = sprintf("rules: %s", paste0(rules, collapse=",")), label = xn)
}

test_that("type and missingness", {
  expect_succ_all(xb, "b")
  expect_fail_all(xb, "B")
  expect_succ_all(xi, "i")
  expect_fail_all(xi, "I")
  expect_succ_all(xr, "r")
  expect_fail_all(xr, "R")
  expect_succ_all(xc, "c")
  expect_fail_all(xc, "C")
  expect_succ_all(xl, "l")
  expect_fail_all(xl, "L")
  expect_succ_all(xm, "m")
  expect_fail_all(xm, "M")
  expect_succ_all(xd, "d")
  expect_fail_all(xd, "D")
  expect_succ_all(xe, "e")
  expect_succ_all(xf, "f")

  expect_fail_all(xd, "b")
  expect_fail_all(xd, "i")
  expect_fail_all(xd, "r")
  expect_fail_all(xd, "c")
  expect_fail_all(xd, "l")
  expect_fail_all(xd, "m")
  expect_fail_all(xl, "e")
  expect_fail_all(xm, "r")
  expect_fail_all(xl, "d")
  expect_fail_all(xl, "f")

  expect_fail_all(xl, c("f", "n"), "One of")
  expect_error(qassert(1, "O"), "Unknown class identifier")
})

test_that("integerish", {
  expect_succ_all(xb, "x")
  expect_succ_all(xi, "x")
  expect_succ_all(xi, "x")
  expect_fail_all(xi, "X")
  expect_succ_all(xr, "x")
  expect_fail_all(xr, "X")
  expect_fail_all(1:3+.0001, "x")
  expect_fail_all(xd, "x")
})

test_that("length", {
  expect_succ_all(xb, "b+")
  expect_succ_all(xb, "b10")
  expect_succ_all(logical(1), "b+")
  expect_succ_all(logical(1), "b?")
  expect_succ_all(logical(1), "b1")
  expect_fail_all(xb, "b?")
  expect_fail_all(xb, "b5")
  expect_fail_all(xb, "b>=50")
  expect_succ_all(xb, "b<=50")
  expect_succ_all(xe, "e1")
  expect_fail_all(xe, "e>=2")
  expect_fail_all(xe, "f+")

  expect_error(qassert(1, "n9999999999999"), "handle length")
  expect_error(qassert(1, "n-1"), "negative length")
})

test_that("bounds", {
  xx = 1:3
  expect_succ_all(xx, "i+(0,4)")
  expect_succ_all(xx, "i+(0.9999,3.0001)")
  expect_succ_all(xx, "i+(0,1e2)")
  expect_succ_all(1, "n[0, 100]")

  expect_fail_all(xx, "i+[1,2)")
  expect_fail_all(xx, "i+[1,2]")
  expect_fail_all(xx, "i+[1,3)")
  expect_succ_all(xx, "i+[1,3]")

  expect_fail_all(xx, "i+(2,3]")
  expect_fail_all(xx, "i+[2,2]")
  expect_fail_all(xx, "i+(1,3)")
  expect_succ_all(xx, "i+[1,3]")

  expect_succ_all(xx, "i[1,)")
  expect_succ_all(xx, "i[,3]")
  expect_succ_all(Inf, "n(1,]")
  expect_succ_all(-Inf, "n[,1]")
  expect_succ_all(c(-Inf, 0, Inf), "n[,]")
  expect_fail_all(Inf, "n(1,)")
  expect_fail_all(-Inf, "n(,0]")
  expect_fail_all(c(-Inf, 0, Inf), "n(,]")
  expect_fail_all(c(-Inf, 0, Inf), "n(,)")

  xx = letters[1:3]
  expect_succ_all(xx, "s+[1,]")
  expect_succ_all(xx, "s+[1,1]")
  expect_fail_all(xx, "s+[2]")
  expect_fail_all(NA_character_, "s+[1]")
  expect_fail_all(NA, "s+[1]")

  xx = factor(letters[1:3])
  expect_succ_all(xx, "f+[1,]")
  expect_succ_all(xx, "f+[1,1]")
  expect_fail_all(xx, "f+[2]")
  expect_fail_all(NA_integer_, "f+[1]")
  expect_fail_all(NA_character_, "f+[1]")
  expect_fail_all(NA, "f+[1]")

  expect_succ_all(1, "n+()")
  expect_succ_all(1, "n+[]")
  expect_succ_all(Inf, "n+[]")
  expect_succ_all(Inf, "n+(]")
  expect_succ_all(-Inf, "n+[)")
  expect_fail_all(Inf, "n+()")
  expect_fail_all(Inf, "n+[)")
  expect_fail_all(-Inf, "n+(]")

  expect_error(qassert(iris, "d+[1]"), "Bound checks")
})

test_that("non-atomic types", {
  expect_succ_all(function() 1, "*")
  expect_fail_all(function() 1, "b")
  expect_succ_all(function() 1, "*")
  expect_succ_all(NULL, "0?")
  expect_fail_all(xi, "0")
  expect_fail_all(NULL, "0+")
  expect_succ_all(NULL, "00")
  expect_fail_all(xe, "b")
  expect_fail_all(xf, "b")
  expect_fail_all(as.symbol("x"), "n")
  expect_fail_all(xd, "a")
})

test_that("atomic types", {
  expect_succ_all(NULL, "a")
  expect_succ_all(xb, "a+")
  expect_fail_all(xb, "A+")
  expect_succ_all(xi, "a+")
  expect_fail_all(xi, "A+")
  expect_succ_all(xi, "n+")
  expect_fail_all(xi, "N+")
  expect_succ_all(xr, "n+")
  expect_fail_all(xr, "N+")
  expect_succ_all(xr, "a+")
  expect_fail_all(xr, "A+")
  expect_succ_all(xm, "a+")
  expect_fail_all(xm, "A+")
  expect_fail_all(xl, "a+")
  expect_fail_all(xl, "A+")
  expect_fail_all(xe, "a+")
  expect_succ_all(xf, "a+")

  expect_fail_all(NULL, "v")
  expect_succ_all(xb, "v+")
  expect_fail_all(xb, "V+")
  expect_succ_all(xi, "v+")
  expect_fail_all(xi, "V+")
  expect_succ_all(xr, "v+")
  expect_fail_all(xr, "V+")
  expect_succ_all(xm, "v+")
  expect_fail_all(xm, "V+")
  expect_fail_all(xl, "v+")
  expect_fail_all(xl, "V+")
  expect_fail_all(xe, "v+")
  expect_fail_all(xf, "V+")
})

test_that("optional chars", {
  expect_succ_all(TRUE, "b*")
  expect_succ_all(TRUE, "b=1")
  expect_succ_all(TRUE, "b>=0")
  expect_succ_all(TRUE, "b>0")
  expect_succ_all(TRUE, "b<2")
  expect_fail_all(TRUE, "b=2")
  expect_fail_all(TRUE, "b>=2")
  expect_fail_all(TRUE, "b>2")
  expect_fail_all(TRUE, "b<0")
})

test_that("malformated pattern", {
  expect_error(qassert(1, ""), "[Ee]mpty")
  # expect_warning(expect_error(qassert(1, "ä")), "locale")
  expect_error(qassert(1, "nn"), "length definition")
  expect_error(qassert(1, "n="), "length definition")
  expect_error(qassert(1, "n=="), "length definition")
  expect_error(qassert(1, "n==="), "length definition")
  expect_error(qassert(1, "n?1"), "bound definition")
  expect_error(qassert(1, "n>"))
  expect_error(qassert(1, "nö"))
  expect_error(qassert(1, "n\n"))
  expect_error(qassert(1, "n+a"), "opening")
  expect_error(qassert(1, "n+["), "bound")
  expect_error(qassert(1, "n+[1"), "lower")
  expect_error(qassert(1, "n+[x,]"), "lower")
  expect_error(qassert(1, "n+[,y]"), "upper")
  expect_error(qassert(1, "n*("), "bound definition")
  expect_error(qassert(1, "n*]"), "bound definition")
  expect_error(qassert(1, "n*(1)xx"), "Additional chars found")
  expect_error(qassert(1, TRUE), "be a string")
  expect_error(qassert(1, NA_character_), "not be NA")
  expect_error(qtest(1, TRUE), "be a string")
  expect_error(qtest(1, NA_character_), "not be NA")
})

test_that("we get some output", {
  expect_error(qassert(1, "b"), "logical")
  expect_error(qassert(1, "l"), "list")
  expect_error(qassert(1:2, "n?"), "length <=")
})

test_that("empty vectors", {
  expect_succ_all(integer(0), "i*")
  expect_succ_all(integer(0), "i*[0,0]")
  expect_succ_all(integer(0), "n[0,0]")
  expect_fail_all(integer(0), "r[0,0]")
  expect_fail_all(integer(0), "*+")
  expect_succ_all(TRUE, character(0))
})

test_that("logicals are not numeric", {
  expect_fail_all(TRUE, "i")
  expect_fail_all(TRUE, "I")
  expect_fail_all(TRUE, "n")
  expect_fail_all(TRUE, "N")
})

test_that("data frames are not lists", {
  expect_fail_all(iris, "l")
  expect_fail_all(iris, "L")
})

test_that("error messages are properly generated", {
  expect_error(qassert(1, "N22"), "== 22")
  expect_error(qassert(1:3, "N?"), "<= 1")
  expect_error(qassert(integer(0), "N+"), ">= 1")

  expect_error(qassert(1, "N[2,]"), ">= 2")
  expect_error(qassert(1, "N(2,]"), "> 2")
  expect_error(qassert(1, "N[,0]"), "<= 0")
  expect_error(qassert(1, "N[,0)"), "< 0")

  expect_error(qassert(Inf, "N[)"), "!= Inf")
  expect_error(qassert(-Inf, "N(]"), "!= -Inf")
})
