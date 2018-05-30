context("to_long")

test_that("Use on general data set, #5", {

  n_replicates <- 1
  n_nltts <- 10

  df <- rkt_create_data_frame(
    n_replicates = n_replicates,
    n_nltts = n_nltts,
    experiment_type = "general"
  )
  df_long <- to_long(df)

  testthat::expect_equal(
    nrow(df_long),
    n_replicates * rkt_get_n_param_combos() * n_nltts
  )
  # 17 params + 1 index + 1 measurement
  testthat::expect_equal(ncol(df_long), rkt_get_n_params() + 1 + 1)
})

test_that("Use on sampling data set, #5", {

  n_replicates <- 1
  n_nltts <- 10
  max_n_params <- 2

  set.seed(42)
  df <- rkt_create_data_frame(
    n_replicates = n_replicates,
    n_nltts = n_nltts,
    experiment_type = "sampling",
    max_n_params = 2
  )
  df_long <- to_long(df)

  testthat::expect_equal(nrow(df_long), n_nltts * max_n_params)

  # 17 params + 1 index + 1 measurement
  testthat::expect_equal(ncol(df_long), rkt_get_n_params() + 1 + 1)
})
