context("rkt_create_data_frame")

test_that("use", {
  n_files <- 3
  n_nltts <- 5
  df <- rkt_create_data_frame(
    n_files = n_files,
    n_nltts = n_nltts
  )
  testthat::expect_equal(nrow(df), n_files)
  testthat::expect_equal(ncol(df), rkt_get_n_params() + n_nltts)
})
