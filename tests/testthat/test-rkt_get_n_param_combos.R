context("rkt_get_n_param_combos")

test_that("use", {
  expect_equal(rkt_get_n_param_combos(), 144)
})
