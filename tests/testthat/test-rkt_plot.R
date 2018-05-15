context("rkt_plot")

test_that("use", {

  n_files <- rkt_get_max_n_rows()
  n_nltts <- 1000
  testit::assert(n_files <= rkt_get_max_n_rows()())
  testit::assert(rkt_get_n_params() + 1 + n_nltts <= rkt_get_max_n_cols())

  # Create a fake data frame
  df <- rkt_create_data_frame(
    n_files = n_files,
    n_nltts = n_nltts
  )
  df_long <- to_long(df)
  
  rm(df)
  gc()
  
  testthat::expect_silent(
    rkt_plot(df_long)
  )

  rm(df_long)
  gc()
})
