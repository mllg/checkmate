context("checkNames")

test_that("checkNames", {
  nn = letters[1:3]
  expect_succ_all(Names, nn)
  expect_fail_all(Names, nn, type = "unnamed")

  expect_true(testNames(character(0)))
  expect_false(testNames(NULL))
  expect_false(testNames(integer(0)))

  x = c("a", ".a")
  expect_true(testNames(x))
  expect_true(testNames(x, "unique"))
  expect_true(testNames(x, "strict"))

  expect_false(testNames(1))
  expect_false(testNames(NA_character_))
  expect_false(testNames(NA_integer_))
  expect_false(testNames(""))

  x = c("a", "a")
  expect_true(testNames(x))
  expect_false(testNames(x, "unique"))

  expect_true(testNames("x", type = "strict"))
  expect_true(testNames("..x", type = "strict"))
  expect_true(testNames("x_1", type = "strict"))
  expect_true(testNames("x.", type = "strict"))
  expect_false(testNames("1", type = "strict"))
  expect_false(testNames(".1", type = "strict"))
  expect_false(testNames("..1", type = "strict"))
  expect_false(testNames("x ", type = "strict"))
  expect_false(testNames("ä", type = "strict"))
  expect_error(assertNames(c("a", "a"), "unique"), "unique")

  x = c("a", "1")
  expect_error(assertNames(x, "strict"), "naming conventions")
})

test_that("argument 'type' is checked", {
  expect_error(checkNames("x", type = 1), "string")
  expect_error(checkNames("x", type = NA_character_), "missing")
})


test_that("checkNames / subset.of", {
  x = 1:3
  names(x) = letters[1:3]

  expect_true(testNames(names(x), subset.of = letters[1:3]))
  expect_true(testNames(names(x), subset.of = letters[3:1]))
  expect_true(testNames(names(x), subset.of = letters))
  expect_false(testNames(names(x), subset.of = letters[1:2]))
  expect_false(testNames(names(x), subset.of = character(0)))
  expect_false(testNames(NULL, subset.of = character(0)))
  expect_true(testNames(character(0), subset.of = character(0)))
  expect_true(testNames(character(0), subset.of = NULL))
})

test_that("checkNames / identical.to", {
  x = 1:3
  names(x) = letters[1:3]

  expect_true(testNames(names(x), identical.to = letters[1:3]))
  expect_false(testNames(names(x), identical.to = letters[3:1]))
  expect_false(testNames(names(x), identical.to = letters))
  expect_false(testNames(names(x), identical.to = letters[1:2]))
  expect_false(testNames(names(x), identical.to = character(0)))
  expect_false(testNames(NULL, identical.to = character(0)))
  expect_true(testNames(character(0), identical.to = character(0)))
  expect_true(testNames(character(0), identical.to = NULL))
  expect_false(testNames(NULL, identical.to = NULL))
})

test_that("checkNames / permutation.of", {
  x = 1:3
  names(x) = letters[1:3]

  expect_true(testNames(names(x), permutation.of = letters[1:3]))
  expect_true(testNames(names(x), permutation.of = letters[3:1]))
  expect_false(testNames(names(x), permutation.of = letters))
  expect_false(testNames(names(x), permutation.of = letters[1:2]))
  expect_false(testNames(names(x), permutation.of = character(0)))
  expect_false(testNames(NULL, permutation.of = character(0)))
  expect_true(testNames(character(0), permutation.of = character(0)))
  expect_true(testNames(character(0), permutation.of = NULL))
  expect_false(testNames(NULL, permutation.of = NULL))
})

test_that("checkNames / must.include", {
  x = 1:3
  names(x) = letters[1:3]

  expect_true(testNames(names(x), must.include = "a"))
  expect_true(testNames(names(x), must.include = letters[3:1]))
  expect_false(testNames(names(x), must.include = letters))
  expect_true(testNames(names(x), must.include = character(0)))
  expect_false(testNames(NULL, must.include = character(0)))
  expect_true(testNames(character(0), must.include = character(0)))
  expect_true(testNames(character(0), must.include = NULL))
})

test_that("checkNames / disjunct.from", {
  x = 1:3
  names(x) = letters[1:3]

  expect_true(testNames(names(x)))
  expect_true(testNames(names(x), disjunct.from = "d"))
  expect_false(testNames(names(x), disjunct.from = "b"))
})

test_that("checkNames / errors are useful", {
  foo = matrix(1:9)
  expect_error(
    assertNames(colnames(foo), permutation.of = letters),
    "colnames\\(foo\\)"
  )
  expect_error(
    assertNames(rownames(foo), permutation.of = letters),
    "rownames\\(foo\\)"
  )
})

test_that("checkNames / NULL (#120)", {
  expect_true(testNames(NULL, type = "unnamed"))
  expect_false(testNames(NULL, type = "named"))
})
