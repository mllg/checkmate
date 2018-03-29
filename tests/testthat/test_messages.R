context("generated messages")

test_that("No extra strings attached to generated error messages", {
  foo = function(XX) assertFlag(XX)
  x = try(foo(iris), silent = TRUE)
  expect_error(foo(iris), "^Assertion on 'XX'")
  expect_error(foo(iris), "not 'data.frame'\\.$")
})

test_that("Correct frame is reported by assertions", {
  f1a <- function(num) if(!is.numeric(num)) stop("Not numeric")
  f1b <- function(num) assert_numeric(num)
  f2a <- function(num) f1a(num)
  f2b <- function(num) f1b(num)
  ok.r = try(f2a(letters), silent = TRUE)
  ok.cm = try(f2b(letters), silent = TRUE)

  expect_true(grepl("f1a(num)", as.character(ok.r), fixed = TRUE))
  expect_true(grepl("f1b(num)", as.character(ok.cm), fixed = TRUE))
})
