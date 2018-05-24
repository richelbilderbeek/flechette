context("rkt_create_data_frame")

test_that("use, general", {
  n_replicates <- 1
  n_nltts <- 5
  df <- rkt_create_data_frame(
    n_replicates = n_replicates,
    n_nltts = n_nltts,
    experiment_type = "general"
  )
  testthat::expect_equal(nrow(df), n_replicates * rkt_get_n_param_combos())
  testthat::expect_equal(ncol(df), rkt_get_n_params() + n_nltts)
})

test_that("use, sampling", {
  n_nltts <- 5
  df <- rkt_create_data_frame(
    n_replicates = 1,
    n_nltts = n_nltts,
    experiment_type = "sampling"
  )
  testthat::expect_gte(nrow(df), 20)
  testthat::expect_equal(ncol(df), rkt_get_n_params() + n_nltts)
})
