context("rkt_get_n_param_combos")

test_that("must match general experiment", {

  skip("Not now")

  df <- rkt_create_data_frame(
    n_replicates = 1,
    n_nltts = 1,
    experiment_type = "general"
  )
  testthat::expect_equal(nrow(df), rkt_get_n_param_combos())
})
