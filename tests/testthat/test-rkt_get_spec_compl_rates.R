context("rkt_get_spec_compl_rates")

test_that("use", {
  expect_equal(
    rkt_get_spec_compl_rates(),
    c(0.1, 0.3, 1.0, 1000000000)
  )
})
