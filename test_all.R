library(methods)
library(devtools)
library(testthat)

if (interactive()) {
  load_all(".")
} else {
  library(checkmate)
}
test_dir("tests/testthat")
