context("checkOS")

test_that("checkOS", {
  expect_succ_all(OS, c("linux", "mac", "windows", "solaris"))
})
