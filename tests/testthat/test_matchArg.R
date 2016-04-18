context("matchArg")

test_that("matchArg", {
  x = c("pearson", "kendall", "spearman")
  choices = x
  expect_equal(matchArg(x, choices), choices[1])
  expect_equal(matchArg(x, choices, several.ok = TRUE), choices)

  x = substr(x, 1, 1)
  expect_equal(matchArg(x[2], choices, several.ok = FALSE), choices[2])
  expect_equal(matchArg(x[c(1, 3)], choices, several.ok = TRUE), choices[c(1, 3)])

  expect_error(matchArg(1, 1:10), "character")
  expect_error(matchArg(1, letters), "character")
  expect_error(matchArg(letters, 1:10), "character")
  expect_error(matchArg(x[1:2], choices), "length")
  expect_error(matchArg(x[0], choices), "length 0")
})
