context("checkPOSIXct")

test_that("checkPOSIXct", {
  origin = "1970-01-01"
  now = Sys.time()
  yesterday = now - 24 * 60 * 60
  tomorrow = now + 24 * 60 * 60
  now_est = as.POSIXct(as.numeric(now), tz = "EST", origin = origin)
  now_gmt = as.POSIXct(as.numeric(now), tz = "GMT", origin = origin)
  yesterday_gmt = as.POSIXct(as.numeric(now), tz = "GMT", origin = origin)
  tomorrow_gmt = as.POSIXct(as.numeric(now), tz = "GMT", origin = origin)

  expect_succ_all(POSIXct, now, lc = "posixct", cc = "POSIXct")
  expect_fail_all(POSIXct, 1, lc = "posixct", cc = "POSIXct")

  dates = c(yesterday, now, tomorrow, NA)
  expect_true(testPOSIXct(dates, min.len = 1, max.len = 10))
  expect_true(testPOSIXct(dates, len = 4))
  expect_true(testPOSIXct(dates, unique = TRUE))
  expect_true(testPOSIXct(dates, all.missing = FALSE))
  expect_true(testPOSIXct(dates, sorted = TRUE))
  expect_true(testPOSIXct(c(now, now), sorted = TRUE))
  expect_error(assertPOSIXct(c(dates, dates), unique = TRUE))
  expect_error(assertPOSIXct(dates, any.missing = FALSE), "missing")
  expect_error(assertPOSIXct(rev(dates), sorted = TRUE), "sorted")


  expect_true(testPOSIXct(dates, lower = yesterday))
  expect_true(checkPOSIXct(dates, upper = tomorrow))
  expect_error(assertPOSIXct(dates, lower = now), ">=")
  expect_error(assertPOSIXct(dates, upper = now), "<=")

  x = checkPOSIXct(dates, lower = now)
  expect_true(grepl("[0-9]{4}-[0-9]{2}-[0-9]{2}", x))

  x = checkPOSIXct(dates, upper = now)
  expect_true(grepl("[0-9]{4}-[0-9]{2}-[0-9]{2}", x))

  # timezone checks
  expect_error(assertPOSIXct(now_est, lower = yesterday), "Timezones")
  expect_error(assertPOSIXct(now_est, upper = tomorrow), "Timezones")
  expect_error(assertPOSIXct(now, lower = yesterday_gmt), "Timezones")
  expect_error(assertPOSIXct(now, upper = tomorrow_gmt), "Timezones")
  expect_error(assertPOSIXct(now_est, lower = yesterday_gmt), "Timezones")
  expect_error(assertPOSIXct(now_est, upper = tomorrow_gmt), "Timezones")
  expect_true(testPOSIXct(now_gmt, lower = yesterday_gmt, upper = tomorrow_gmt))
})
