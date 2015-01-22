context("qtest")

xb = logical(10); xb[5] = NA
xi = integer(10); xi[5] = NA
xr = double(10); xr[5] = NA
xc = complex(10); xc[5] = NA
xl = as.list(1:10); xl[5] = list(NULL)
xm = matrix(1:9, 3); xm[2, 3] = NA
xd = data.frame(a=1:5, b=1:5); xd$b[3] = NA
xe = new.env(); xe$foo = 1
xf = function(x) x

expect_succ = function(x, rules) {
  expect_true(qtest(x, rules),
    info=sprintf("vector %s, rules: %s", deparse(substitute(x)), paste(rules, collapse=",")))
  expect_true(qassert(x, rules),
    info=sprintf("vector %s, rules: %s", deparse(substitute(x)), paste(rules, collapse=",")))
}

expect_fail = function(x, rules) {
  expect_false(qtest(x, rules),
    info=sprintf("vector %s, rules: %s", deparse(substitute(x)), paste(rules, collapse=",")))
  expect_true(inherits(try(qassert(x, rules), silent=TRUE), "try-error"),
    info=sprintf("vector %s, rules: %s", deparse(substitute(x)), paste(rules, collapse=",")))
}

test_that("type and missingness", {
  expect_succ(xb, "b")
  expect_fail(xb, "B")
  expect_succ(xi, "i")
  expect_fail(xi, "I")
  expect_succ(xr, "r")
  expect_fail(xr, "R")
  expect_succ(xc, "c")
  expect_fail(xc, "C")
  expect_succ(xl, "l")
  expect_fail(xl, "L")
  expect_succ(xm, "m")
  expect_fail(xm, "M")
  expect_succ(xd, "d")
  expect_fail(xd, "D")
  expect_succ(xe, "e")
  expect_succ(xf, "f")

  expect_fail(xd, "b")
  expect_fail(xd, "i")
  expect_fail(xd, "r")
  expect_fail(xd, "c")
  expect_fail(xd, "l")
  expect_fail(xd, "m")
  expect_fail(xl, "e")
  expect_fail(xm, "r")
  expect_fail(xl, "d")
  expect_fail(xl, "f")
})

test_that("integerish", {
  expect_succ(xb, "x")
  expect_succ(xi, "x")
  expect_succ(xi, "x")
  expect_fail(xi, "X")
  expect_succ(xr, "x")
  expect_fail(xr, "X")
  expect_fail(1:3+.0001, "x")
  expect_fail(xd, "x")
})

test_that("length", {
  expect_succ(xb, "b+")
  expect_succ(xb, "b10")
  expect_succ(logical(1), "b+")
  expect_succ(logical(1), "b?")
  expect_succ(logical(1), "b1")
  expect_fail(xb, "b?")
  expect_fail(xb, "b5")
  expect_fail(xb, "b>=50")
  expect_succ(xb, "b<=50")
  expect_succ(xe, "e1")
  expect_fail(xe, "e>=2")
  expect_fail(xe, "f+")
})

test_that("bounds", {
  xx = 1:3
  expect_succ(xx, "i+[1,3]")
  expect_succ(xx, "i+(0,4)")
  expect_succ(xx, "i+(0.9999,3.0001)")
  expect_succ(xx, "i+(0,1e2)")
  expect_fail(xx, "i+(1,3]")
  expect_fail(xx, "i+[1,3)")
  expect_succ(1, "n[0, 100]")

  expect_succ(xx, "i[1,)")
  expect_succ(xx, "i[,3]")
  expect_succ(Inf, "n(1,]")
  expect_succ(-Inf, "n[,1]")
  expect_succ(c(-Inf, 0, Inf), "n[,]")
  expect_fail(Inf, "n(1,)")
  expect_fail(-Inf, "n(,0]")
  expect_fail(c(-Inf, 0, Inf), "n(,]")
  expect_fail(c(-Inf, 0, Inf), "n(,)")

  expect_succ(1, "n+()")
  expect_succ(1, "n+[]")
  expect_succ(Inf, "n+[]")
  expect_succ(Inf, "n+(]")
  expect_succ(-Inf, "n+[)")
  expect_fail(Inf, "n+()")
  expect_fail(Inf, "n+[)")
  expect_fail(-Inf, "n+(]")
})

test_that("non-atomic types", {
  expect_succ(function() 1, "*")
  expect_fail(function() 1, "b")
  expect_succ(function() 1, "*")
  expect_succ(NULL, "0?")
  expect_fail(xi, "0")
  expect_fail(NULL, "0+")
  expect_succ(NULL, "00")
  expect_fail(xe, "b")
  expect_fail(xf, "b")
  expect_fail(as.symbol("x"), "n")
  expect_fail(xd, "a")
})

test_that("atomic types", {
  expect_succ(NULL, "a")
  expect_succ(xb, "a+")
  expect_fail(xb, "A+")
  expect_succ(xi, "a+")
  expect_fail(xi, "A+")
  expect_succ(xi, "n+")
  expect_fail(xi, "N+")
  expect_succ(xr, "n+")
  expect_fail(xr, "N+")
  expect_succ(xr, "a+")
  expect_fail(xr, "A+")
  expect_succ(xm, "a+")
  expect_fail(xm, "A+")
  expect_fail(xl, "a+")
  expect_fail(xl, "A+")
  expect_fail(xe, "a+")
  expect_fail(xf, "a+")

  expect_fail(NULL, "v")
  expect_succ(xb, "v+")
  expect_fail(xb, "V+")
  expect_succ(xi, "v+")
  expect_fail(xi, "V+")
  expect_succ(xr, "v+")
  expect_fail(xr, "V+")
  expect_succ(xm, "v+")
  expect_fail(xm, "V+")
  expect_fail(xl, "v+")
  expect_fail(xl, "V+")
  expect_fail(xe, "v+")
  expect_fail(xf, "V+")
})

test_that("optional chars", {
  expect_succ(TRUE, "b*")
  expect_succ(TRUE, "b=1")
  expect_succ(TRUE, "b>=0")
  expect_succ(TRUE, "b>0")
  expect_succ(TRUE, "b<2")
  expect_fail(TRUE, "b=2")
  expect_fail(TRUE, "b>=2")
  expect_fail(TRUE, "b>2")
  expect_fail(TRUE, "b<0")
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
})

test_that("we get some output", {
  expect_error(qassert(1, "b"), "logical")
  expect_error(qassert(1, "l"), "list")
  expect_error(qassert(1:2, "n?"), "length <=")
})

test_that("empty vectors", {
  expect_succ(integer(0), "i*")
  expect_succ(integer(0), "i*[0,0]")
  expect_succ(integer(0), "n[0,0]")
  expect_fail(integer(0), "r[0,0]")
  expect_fail(integer(0), "*+")
})

test_that("logicals are not numeric", {
  expect_fail(TRUE, "i")
  expect_fail(TRUE, "I")
  expect_fail(TRUE, "n")
  expect_fail(TRUE, "N")
})
