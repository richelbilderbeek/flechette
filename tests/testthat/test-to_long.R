context("to_long")

test_that("use", {

  n_files <- 3
  n_nltts <- 3 # Called X, X.1 and X.2

  for (experiment_type in c("general", "sampling")) {
    df <- rkt_create_data_frame(
      n_files = n_files,
      n_nltts = n_nltts,
      experiment_type = experiment_type
    )
    df_long <- to_long(df)
    testthat::expect_equal(nrow(df_long), n_files * n_nltts)
    # 15 params + 1 index + 1 measurement
    testthat::expect_equal(ncol(df_long), rkt_get_n_params() + 1 + 1)
  }
})

test_that("Can convert a data frame to long form, #5", {

  n_files <- rkt_get_max_n_rows()
  n_nltts <- 1000

  if (!ribir::is_on_travis()) {
    # Smaller on local computer
    n_files <- n_files / 10
    n_nltts <- n_nltts / 10
  }

  for (experiment_type in c("general", "sampling")) {

    df <- rkt_create_data_frame(
      n_files = n_files,
      n_nltts = n_nltts,
      experiment_type = experiment_type
    )

    df_long <- to_long(df)
    testthat::expect_equal(nrow(df_long), n_files * n_nltts)
    # 15 params + 1 index + 1 measurement
    testthat::expect_equal(ncol(df_long), rkt_get_n_params() + 1 + 1)

    rm(df)
    rm(df_long)
    # Manually call garbage collection, we need that memory directly
    gc()
  }
})
