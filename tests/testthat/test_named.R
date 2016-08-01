context("matching names via .setequal/.equal/.in")


test_that(".in", {
  x = 1:3

  expect_true(testNumeric(x, names = .in(letters)))
  expect_true(testNumeric(x, names = .in(letters[1:3])))
  expect_true(testNumeric(x, names = .in(letters[1:2])))
  expect_true(testNumeric(x, names = .in(character(0))))

  names(x) = letters[1:3]
  expect_true(testNumeric(x, names = .in(letters)))
  expect_true(testNumeric(x, names = .in(letters[1:3])))
  expect_true(testNumeric(x, names = .in(letters[3:1])))
  expect_false(testNumeric(x, names = .in(letters[1:2])))
  expect_false(testNumeric(x, names = .in(character(0))))
  expect_error(testNumeric(x, names = .in(NULL)), "set of names")
  expect_error(testNumeric(x, names = .in(NA_character_)), "set of names")
})

test_that(".setequal", {
  x = 1:3
  expect_true(testNumeric(x, names = .setequal(character(0))))
  expect_false(testNumeric(x, names = .setequal(letters)))

  names(x) = letters[1:3]
  expect_true(testNumeric(x, names = .setequal(letters[1:3])))
  expect_true(testNumeric(x, names = .setequal(letters[3:1])))
  expect_false(testNumeric(x, names = .setequal(letters)))
  expect_false(testNumeric(x, names = .setequal(letters[1:2])))
  expect_false(testNumeric(x, names = .setequal(character(0))))
  expect_error(testNumeric(x, names = .setequal(NULL)), "set of names")
  expect_error(testNumeric(x, names = .setequal(NA_character_)), "set of names")
})

test_that(".equal", {
  x = 1:3
  expect_true(testNumeric(x, names = .equal(character(0))))
  expect_false(testNumeric(x, names = .equal(letters)))

  names(x) = letters[1:3]
  expect_true(testNumeric(x, names = .equal(letters[1:3])))
  expect_false(testNumeric(x, names = .equal(letters[3:1])))
  expect_false(testNumeric(x, names = .equal(letters)))
  expect_false(testNumeric(x, names = .equal(letters[1:2])))
  expect_false(testNumeric(x, names = .equal(character(0))))
  expect_error(testNumeric(x, names = .equal(NULL)), "vector of names")
  expect_error(testNumeric(x, names = .equal(NA_character_)), "vector of names")
})
