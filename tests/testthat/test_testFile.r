context("isFile")

td = tempfile()
dir.create(td, recursive=TRUE)
fn = file.path(td, "file")
dn = file.path(td, "dir")
ff = file.path(td, "xxx")
file.create(fn)
dir.create(dn)

test_that("isFile", {
  expect_false(isFile(character(0)))
  expect_error(isFile(NULL))
  expect_false(isFile(ff))
  expect_false(isFile(dn))
  expect_true(isFile(fn))

  expect_error(assertFile(character(0)), "provided")
  expect_error(assertFile(ff), "exist")
  expect_error(assertFile(dn), "directory")
  expect_true(assertFile(fn))
})

test_that("isDirectory", {
  expect_false(isDirectory(character(0)))
  expect_false(isDirectory(ff))
  expect_false(isDirectory(fn))
  expect_true(isDirectory(dn))

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
