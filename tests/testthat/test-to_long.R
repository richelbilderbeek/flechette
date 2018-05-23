context("to_long")

test_that("use", {

  n_replicates <- 2
  n_nltts <- 3 # Called X, X.1 and X.2

  for (experiment_type in rkt_get_experiment_types()) {
    df <- rkt_create_data_frame(
      n_replicates = n_replicates,
      n_nltts = n_nltts,
      experiment_type = experiment_type
    )
    df_long <- to_long(df)
    if (experiment_type == "general") {
      testthat::expect_equal(
        nrow(df_long),
        n_replicates * rkt_get_n_param_combos() * n_nltts
      )
    } else {
      testthat::expect_gte(nrow(df_long), 20)
    }
    # 15 params + 1 index + 1 measurement
    testthat::expect_equal(ncol(df_long), rkt_get_n_params() + 1 + 1)
  }
})

test_that("Can convert a data frame to long form, #5", {

  n_replicates <- rkt_get_n_replicates()
  n_nltts <- 1000

  if (!ribir::is_on_travis()) {
    # Smaller on local computer
    n_replicates <- n_replicates / 10
    n_nltts <- n_nltts / 10
  } else {
    # Must dumb down, otherwise test takes too long
    n_replicates <- n_replicates / 10
    n_nltts <- n_nltts / 10
  }

  for (experiment_type in rkt_get_experiment_types()) {

    df <- rkt_create_data_frame(
      n_replicates = n_replicates,
      n_nltts = n_nltts,
      experiment_type = experiment_type
    )
    df_long <- to_long(df)

    if (experiment_type == "general") {
      testthat::expect_equal(
        nrow(df_long),
        n_replicates * rkt_get_n_param_combos() * n_nltts
      )
    } else {
      testthat::expect_gte(nrow(df_long), 20)
    }

    # 15 params + 1 index + 1 measurement
    testthat::expect_equal(ncol(df_long), rkt_get_n_params() + 1 + 1)

    rm(df)
    rm(df_long)
    # Manually call garbage collection, we need that memory directly
    gc()
  }
})
