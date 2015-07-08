## ----include=FALSE-------------------------------------------------------
library(checkmate)

## ------------------------------------------------------------------------
fact <- function(n, method = "stirling") {
  if (length(n) != 1)
    stop("Argument 'n' must have length 1")
  if (!is.numeric(n))
    stop("Argument 'n' must be numeric")
  if (is.na(n))
    stop("Argument 'n' may not be NA")
  if (is.double(n)) {
    if (is.nan(n))
      stop("Argument 'n' may not be NaN")
    if (is.infinite(n))
      stop("Argument 'n' must be finite")
    if (abs(n - round(n, 0)) > sqrt(.Machine$double.eps))
      stop("Argument 'n' must be an integerish value")
    n <- as.integer(n)
  }
  if (n < 0)
    stop("Argument 'n' must be >= 0")
  if (length(method) != 1)
    stop("Argument 'method' must have length 1")
  if (!is.character(method) || !method %in% c("stirling", "factorial"))
    stop("Argument 'method' must be either 'stirling' or 'factorial'")

  if (method == "factorial")
    factorial(n)
  else
    sqrt(2 * pi * n) * (n / exp(1))^n
}

## ------------------------------------------------------------------------
fact <- function(n, method = "stirling") {
  assertCount(n)
  assertChoice(method, c("stirling", "factorial"))

  if (method == "factorial")
    factorial(n)
  else
    sqrt(2 * pi * n) * (n / exp(1))^n
}

## ----eval=FALSE----------------------------------------------------------
#  library(testthat)
#  library(checkmate) # for extensions
#  test_check("checkmate")

## ----eval=FALSE----------------------------------------------------------
#  test_that("checkmate is a sweet extension", {
#      x = runif(100)
#      expect_numeric(x, len = 100, any.missing = FALSE, lower = 0, upper = 1)
#  })

## ------------------------------------------------------------------------
library(ggplot2)
library(microbenchmark)

x = runif(1000)
r = function(x) stopifnot(is.numeric(x) && length(x) == 1000 && all(!is.na(x) & x >= 0 & x <= 1))
cm = function(x) assertNumeric(x, len = 1000, any.missing = FALSE, lower = 0, upper = 1)
autoplot(microbenchmark(r(x), cm(x)))

