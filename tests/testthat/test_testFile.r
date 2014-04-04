context("checkFile")

td = tempfile()
dir.create(td, recursive=TRUE)
fn = file.path(td, "file")
dn = file.path(td, "dir")
ff = file.path(td, "xxx")
file.create(fn)
dir.create(dn)

test_that("checkFile", {
  expect_false(checkFile(character(0)))
  expect_error(checkFile(NULL))
  expect_false(checkFile(ff))
  expect_false(checkFile(dn))
  expect_true(checkFile(fn))

  expect_error(assertFile(character(0)), "provided")
  expect_error(assertFile(ff), "exist")
  expect_error(assertFile(dn), "directory")
  expect_true(assertFile(fn))
})

test_that("checkDirectory", {
  expect_false(checkDirectory(character(0)))
  expect_false(checkDirectory(ff))
  expect_false(checkDirectory(fn))
  expect_true(checkDirectory(dn))

  expect_error(assertDirectory(character(0)), "provided")
  expect_error(assertDirectory(ff), "exist")
  expect_error(assertDirectory(fn), "file")
  expect_true(assertDirectory(dn))
})

test_that("testAccess", {
  if (.Platform$OS.type != "windows") {
    Sys.chmod(fn, "0000")
    expect_true(isTRUE(testAccess(fn, "")))
    expect_false(isTRUE(testAccess(fn, "r")))
    expect_false(isTRUE(testAccess(fn, "w")))
    expect_false(isTRUE(testAccess(fn, "x")))
    Sys.chmod(fn, "0700")
    expect_true(isTRUE(testAccess(fn, "")))
    expect_true(isTRUE(testAccess(fn, "r")))
    expect_true(isTRUE(testAccess(fn, "w")))
    expect_true(isTRUE(testAccess(fn, "x")))
    Sys.chmod(fn, "0600")
    expect_true(isTRUE(testAccess(fn, "")))
    expect_true(isTRUE(testAccess(fn, "r")))
    expect_true(isTRUE(testAccess(fn, "rw")))
    expect_false(isTRUE(testAccess(fn, "rx")))
    expect_false(isTRUE(testAccess(fn, "wx")))
  }
})
