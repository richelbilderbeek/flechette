context("rkt_get_spec_init_rates")

test_that("use", {
  expect_equal(rkt_get_spec_init_rates(), c(0.1, 0.5, 1.0))
})
