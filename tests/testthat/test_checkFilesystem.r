context("checkFile")

td = tempfile("checkFile")
dir.create(td, recursive=TRUE)
fn = file.path(td, "myfile")
dn = file.path(td, "dir")
ff = file.path(td, "xxx")
file.create(fn)
dir.create(dn)

test_that("check_file", {
  myobj = fn
  expect_succ(File, myobj)
  myobj = ff
  expect_fail(File, myobj)

  expect_false(testFile(character(0)))
  expect_false(testFile(NULL))
  expect_false(testFile(dn))

  expect_error(assertFile(character(0)), "provided")
  expect_error(assertFile(ff), "exist")
  expect_error(assertFile(dn))
})

test_that("check_directory", {
  myobj = dn
  expect_succ(Directory, myobj)
  myobj = ff
  expect_fail(Directory, myobj)

  expect_false(testDirectory(character(0)))
  expect_false(testDirectory(fn))

  expect_error(assertDirectory(character(0)), "provided")
  expect_error(assertDirectory(ff), "exist")
  expect_error(assertDirectory(fn))
})

test_that("check_access", {
  myobj = R.home()
  expect_succ(Access, myobj, "r")

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
  myobj = ff
  expect_succ(PathForOutput, myobj)
  myobj = fn
  expect_fail(PathForOutput, myobj)

  expect_false(testPathForOutput(character(0)))
  expect_false(testPathForOutput(NULL))

  expect_error(assertPathForOutput(character(0)), "path provided")
  expect_true(assertPathForOutput(c("a", "b")), "path")
  expect_true(assertPathForOutput(ff))
  expect_error(assertPathForOutput(fn), "exist")
  expect_true(assertPathForOutput(fn, overwrite = TRUE))
  expect_true(testPathForOutput(c(fn, ff, dn), overwrite = TRUE))
  expect_false(testPathForOutput(c(fn, ff, dn), overwrite = FALSE))
})
