context("check_file")

td = tempfile()
dir.create(td, recursive=TRUE)
fn = file.path(td, "file")
dn = file.path(td, "dir")
ff = file.path(td, "xxx")
file.create(fn)
dir.create(dn)

test_that("check_file", {
  expect_false(test(character(0), "file"))
  expect_error(test(NULL, "file"))
  expect_false(test(ff, "file"))
  expect_false(test(dn, "file"))
  expect_true(test(fn, "file"))

  expect_error(assert(character(0), "file"), "provided")
  expect_error(assert(ff, "file"), "exist")
  expect_error(assert(dn, "file"), "directory")
  expect_true(assert(fn, "file"))
})

test_that("check_directory", {
  expect_false(test(character(0), "directory"))
  expect_false(test(ff, "directory"))
  expect_false(test(fn, "directory"))
  expect_true(test(dn, "directory"))

  expect_error(assert(character(0), "directory"), "provided")
  expect_error(assert(ff, "directory"), "exist")
  expect_error(assert(fn, "directory"), "file")
  expect_true(assert(dn, "directory"))
})

test_that("check_access", {
  expect_true(test(R.home(), "access", "r"))

  if (.Platform$OS.type != "windows") {
    Sys.chmod(fn, "0000")
    expect_true(test(fn, "access", ""))
    expect_false(test(fn, "access", "r"))
    expect_false(test(fn, "access", "w"))
    expect_false(test(fn, "access", "x"))
    Sys.chmod(fn, "0700")
    expect_true(test(fn, "access", ""))
    expect_true(test(fn, "access", "r"))
    expect_true(test(fn, "access", "w"))
    expect_true(test(fn, "access", "x"))
    Sys.chmod(fn, "0600")
    expect_true(test(fn, "access", ""))
    expect_true(test(fn, "access", "r"))
    expect_true(test(fn, "access", "rw"))
    expect_false(test(fn, "access", "rx"))
    expect_false(test(fn, "access", "wx"))

    expect_error(test(fn, "access", "a"))
    expect_error(test(fn, "access", "rrr"))
  }
})
