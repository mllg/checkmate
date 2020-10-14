context("checkFile")

td = tempfile("checkFile")
dir.create(td, recursive=TRUE)
fn = file.path(td, "myfile.ext")
dn = file.path(td, "dir")
ff = file.path(td, "xxx")
file.create(fn)
dir.create(dn)

test_that("checkFile", {
  myobj = fn
  expect_succ_all(FileExists, myobj)
  myobj = ff
  expect_fail_all(FileExists, myobj)

  expect_false(testFileExists(character(0)))
  expect_false(testFileExists(NULL))
  expect_false(testFileExists(dn))

  expect_error(assertFileExists(character(0)), "provided")
  expect_error(assertFileExists(ff), "exist")
  expect_error(assertFileExists(dn))

  expect_succ_all(FileExists, fn, extension = "ext")
  expect_succ_all(FileExists, fn, extension = c("foo", "ext"))
  expect_fail_all(FileExists, fn, extension = "foo")
})

test_that("check_directory", {
  myobj = dn
  expect_succ_all(DirectoryExists, myobj)
  myobj = ff
  expect_fail_all(DirectoryExists, myobj)

  expect_false(testDirectoryExists(character(0)))
  expect_false(testDirectoryExists(fn))

  expect_error(assertDirectoryExists(character(0)), "provided")
  expect_error(assertDirectoryExists(ff), "exist")
  expect_error(assertDirectoryExists(fn))
})

test_that("check_access", {
  myobj = R.home()
  expect_succ_all(Access, myobj, "r")

  if (.Platform$OS.type != "windows") {
    Sys.chmod(fn, "0000")
    expect_true(testAccess(fn, ""))
    expect_false(testAccess(fn, "x"))
    if (Sys.info()["user"] == "root") {
      expect_true(testAccess(fn, "r"))
      expect_true(testAccess(fn, "w"))
    } else {
      expect_false(testAccess(fn, "r"))
      expect_false(testAccess(fn, "w"))
    }

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
  expect_succ_all(PathForOutput, myobj)
  myobj = fn
  expect_fail_all(PathForOutput, myobj)

  expect_false(testPathForOutput(character(0)))
  expect_false(testPathForOutput(NULL))

  expect_error(assertPathForOutput(character(0)), "path provided")
  expect_identical(assertPathForOutput(c("a", "b")), c("a", "b"))
  expect_identical(assertPathForOutput(ff), ff)
  expect_error(assertPathForOutput(fn), "exist")
  expect_identical(assertPathForOutput(fn, overwrite = TRUE), fn)
  expect_true(testPathForOutput(c(fn, ff, dn), overwrite = TRUE))
  expect_false(testPathForOutput(c(fn, ff, dn), overwrite = FALSE))

  expect_true(checkPathForOutput("a.txt", extension = "txt"))
  expect_error(assertPathForOutput("a.R", extension = "txt"), "extension")
})

test_that("#195", {
  x = tempfile(fileext = ".csv.gz")
  file.create(x)
  expect_true(test_file_exists(x, extension = ".gz"))
  expect_true(test_file_exists(x, extension = ".csv.gz"))
})
