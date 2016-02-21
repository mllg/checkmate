context("checkOS")

test_that("checkOS", {
  skip_on_os("windows")
  skip_on_os("solaris")
  skip_on_os("mac")
  expect_succ_all(OS, "linux", lc = "os")
  expect_string(checkOS("windows"), fixed = "windows")
})
