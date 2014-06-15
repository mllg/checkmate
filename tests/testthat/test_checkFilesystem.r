context("checkFile")

td = tempfile("checkFile")
dir.create(td, recursive=TRUE)
fn = file.path(td, "myfile")
dn = file.path(td, "dir")
ff = file.path(td, "xxx")
file.create(fn)
dir.create(dn)

test_that("check_file", {
  expect_false(testFile(character(0)))
  expect_false(testFile(NULL))
  expect_false(testFile(ff))
  expect_false(testFile(dn))
  expect_true(testFile(fn))

  expect_error(assertFile(character(0)), "provided")
  expect_error(assertFile(ff), "exist")
  expect_error(assertFile(dn))
  expect_true(assertFile(fn))
})

test_that("check_directory", {
  expect_false(testDirectory(character(0)))
  expect_false(testDirectory(ff))
  expect_false(testDirectory(fn))
  expect_true(testDirectory(dn))

  expect_error(assertDirectory(character(0)), "provided")
  expect_error(assertDirectory(ff), "exist")
  expect_error(assertDirectory(fn))
  expect_true(assertDirectory(dn))
})

test_that("check_access", {
  expect_true(testAccess(R.home(), "r"))

  if (.Platform$OS.type != "windows") {
    Sys.chmod(fn, "0000")
    expect_true(testAccess(fn, ""))
    expect_false(testAccess(fn, "r"))
    expect_false(testAccess(fn, "w"))
    expect_false(testAccess(fn, "x"))
    Sys.chmod(fn, "0700")
    expect_true(testAccess(fn, ""))
    expect_true(testAccess(fn, "r"))
    expect_true(testAccess(fn, "w"))
    expect_true(testAccess(fn, "x"))
    Sys.chmod(fn, "0600")
    expect_true(testAccess(fn, ""))
    expect_true(testAccess(fn, "r"))
    expect_true(testAccess(fn, "rw"))
    expect_false(testAccess(fn, "rx"))
    expect_false(testAccess(fn, "wx"))

    expect_error(testAccess(fn, "a"))
    expect_error(testAccess(fn, "rrr"))
  }
})


test_that("check_path_for_output", {
  expect_false(testPathForOutput(character(0)))
  expect_false(testPathForOutput(NULL))
  expect_true(testPathForOutput(ff))
  expect_false(testPathForOutput(fn))

  expect_error(assertPathForOutput(character(0)), "path provided")
  expect_true(assertPathForOutput(c("a", "b")), "path")
  expect_true(assertPathForOutput(ff))
  expect_error(assertPathForOutput(fn), "exist")
})
