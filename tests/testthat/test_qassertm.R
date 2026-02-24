context("qassertm")

xb = logical(10)
xb2 = logical(10)
xi = integer(10)
xr = double(10)

test_that("qassertm: fail on any, report first", {
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

test_that("qassert_all", {
  # global
  expect_error(qassert_all('b',xb,xb2), NA)
  expect_error(qassert_all('n',xb,xb2),
               regexp="'xb' .*numeric', not 'logical'")
  expect_error(qassert_all('r',xr,xb),
               regexp="'xb' .*double', not 'logical'")

  # within function. reusing gobal names to test scope
  expect_error((function(xb,xb2) qassert_all("n"))(1,2), NA)
  expect_error((function(xb,xb2) qassert_all("n"))(1,TRUE),
               regexp="'xb2' .*numeric', not 'logical'")
  expect_error((function(xb,xb2) qassert_all("n"))(1),
               regexp='"xb2" is missing')
})
