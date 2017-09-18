context("checkOS")

test_that("checkOS", {
  expect_succ_all(OS, c("linux", "mac", "windows", "solaris"))
})

test_that("checkOS linux", {
  skip_on_os("windows")
  skip_on_os("solaris")
  skip_on_os("mac")
  expect_succ_all(OS, "linux", lc = "os")
  expect_error(assertOS("windows"), "windows")
})

test_that("checkOS mac", {
  skip_on_os("windows")
  skip_on_os("solaris")
  skip_on_os("linux")
  expect_succ_all(OS, "mac", lc = "os")
  expect_error(assertOS("windows"), "windows")
})

test_that("checkOS win", {
  skip_on_os("mac")
  skip_on_os("solaris")
  skip_on_os("linux")
  expect_succ_all(OS, "windows", lc = "os")
  expect_error(assertOS("mac"), "mac")
})
