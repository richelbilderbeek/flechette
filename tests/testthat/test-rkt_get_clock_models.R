context("rkt_get_clock_models")

test_that("use", {
  expect_true("strict" %in% rkt_get_clock_models())
  expect_true("RLN" %in% rkt_get_clock_models())
})
