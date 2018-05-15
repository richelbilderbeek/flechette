context("rkt_get_n_replicates")

test_that("must at least have 1 replicate", {
  testthat::expect_gte(
    rkt_get_n_replicates(), 1
  )
})

test_that("prerequisite", {
  expect_true(
    rkt_get_n_replicates() * rkt_get_n_param_combos()
    < rkt_get_max_n_rows()
  )
})
