context("AssertCollection")

test_that("Collection closure wors", {
  coll = makeAssertCollection()
  expect_is(coll, "AssertCollection")
  expect_output(print(coll), "Empty collection")
  expect_equal(coll$getMessages(), character(0L))
  expect_true(coll$isEmpty())
  coll$push("testing")
  expect_equal(coll$getMessages(), "testing")
  expect_false(coll$isEmpty())
  expect_output(print(coll), "Collection of 1 assertion")
  coll$push("foo")
  expect_output(print(coll), "Collection of 2 assertions")
  expect_equal(coll$getMessages(), c("testing", "foo"))
})

test_that("Reporter works", {
  coll = makeAssertCollection()
  expect_true(reportAssertions(coll))
  coll$push("foo")
  coll$push("bar")
  expect_error(reportAssertions(coll), "foo")
  expect_error(reportAssertions(coll), "bar")
})

test_that("asserts push to collection", {
  coll = makeAssertCollection()
  findme = "a"

  assertString(findme, add = coll)
  expect_true(coll$isEmpty())
  expect_true(reportAssertions(coll))

  assertNumeric(findme, add = coll)
  expect_false(coll$isEmpty())
  expect_error(reportAssertions(coll), "findme")
})
