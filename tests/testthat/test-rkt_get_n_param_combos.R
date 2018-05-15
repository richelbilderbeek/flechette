context("rkt_get_n_param_combos")

test_that("use", {
  testthat::expect_gte(rkt_get_n_param_combos(), 10)
})
