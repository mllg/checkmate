context("checkChoice")

test_that("checkChoice", {
  myobj = 1
  expect_succ_all(Choice, myobj, 1:3)
  myobj = 0
  expect_fail_all(Choice, myobj, 1:3)

  expect_false(testChoice(character(0), letters))
  expect_false(testChoice(NULL, letters))
  expect_false(testChoice(1, NULL))
  expect_error(testChoice(list(1), as.list(iris)), "atomic")
  expect_false(testChoice(factor("a"), letters))
  expect_true(testChoice(factor("a"), factor(letters)))
  expect_true(testChoice(1., 1:2))

  expect_false(testChoice(NULL, NULL))
  expect_false(testChoice(NULL, letters, null.ok = FALSE))
  expect_true(checkChoice(NULL, letters, null.ok = TRUE))

  expect_true(testChoice(1L, 1:10))
  expect_false(testChoice("ab", letters))
  expect_false(testChoice(NA_integer_, 1:10))
  expect_false(testChoice(1:2, 1:10))

  expect_error(assertChoice(-1, 1:2), "element of")
  expect_error(assertChoice(1L, list()), "atomic")


  expect_true(grepl("atomic scalar", checkChoice(1:2, 1:10), fixed = TRUE))
  expect_true(grepl("types do not match", checkChoice(factor("a"), letters), fixed = TRUE))
  expect_true(grepl("'foo'", checkChoice("foo", letters), fixed = TRUE))
})


test_that("checkChoice / fastmatch", {
  skip_if_not_installed("fastmatch")
  x = "c"
  y = letters[1:5]

  res = testChoice(x, y)
  expect_true(res)
  expect_null(attr(y, ".match.hash"))

  res = testChoice(x, y, fmatch = TRUE)
  expect_true(res)
  expect_class(attr(y, ".match.hash"), "match.hash")
})

test_that("checkChoice / NAs (#158)", {
  expect_true(test_choice(NA_character_, NA))
  expect_true(test_choice(NA, NA_character_))
})
