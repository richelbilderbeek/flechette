context("rkt_create_data_frame")

test_that("use", {
  n_files <- 3
  n_nltts <- 5
  experiment_types <- c("general", "sampling")
  for (experiment_type in experiment_types) {
    df <- rkt_create_data_frame(
      n_files = n_files,
      n_nltts = n_nltts,
      experiment_type = experiment_type
    )
    testthat::expect_equal(nrow(df), n_files)
    testthat::expect_equal(ncol(df), rkt_get_n_params() + n_nltts)
  }
})
