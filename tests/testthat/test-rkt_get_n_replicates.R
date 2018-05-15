context("rkt_get_n_replicates")

test_that("use", {
  expect_equal(
    rkt_get_n_replicates(), 138
  )
})

test_that("prerequisite", {
  expect_true(
    rkt_get_n_replicates() * rkt_get_n_param_combos()
    < rkt_get_max_n_rows()
  )
})
