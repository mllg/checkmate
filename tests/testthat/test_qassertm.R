context("qassertm")

xb = logical(10)
xi = integer(10)
xr = double(10)

test_that("fail on any, report first", {
  # none
  expect_error(qassertm(), NA)
  # one
  expect_error(qassertm(xb="b"), NA)
  # many
  expect_error(qassertm(xb="l"),
               regexp = "'xb' .*'list', not 'logical'")

  expect_error(qassertm(xb="b", xi="i", xr="r"), NA)
  expect_error(qassertm(xb="b", xi="l", xr="r"),
               regexp = "'xi' .*'list', not 'integer'")
  expect_error(qassertm(xb="b", xi="i", xr="b"),
               regexp = "'xr' .*logical', not 'double'")

  # two wrong. only reports first
  expect_error(qassertm(xb="b", xi="l", xr="b"),
               regexp = "'xi' .*'list', not 'integer'")
})
