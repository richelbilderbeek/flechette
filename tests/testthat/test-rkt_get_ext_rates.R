context("rkt_get_ext_rates")

test_that("use", {
  expect_equal(rkt_get_ext_rates(), c(0.0, 0.1, 0.2, 0.4))
})
