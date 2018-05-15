context("rkt_get_n_params")

test_that("use", {
  testthat::expect_equal(rkt_get_n_params(), 15)
})
