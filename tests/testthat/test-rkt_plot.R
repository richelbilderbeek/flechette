context("rkt_plot")

test_that("use", {

  # Create a fake data frame
  n_rows <- 10
  df_long <- data.frame(
    erg = rep(0.1, n_rows),
    eri = rep(0.1, n_rows),
    sirg = rep(1.0, n_rows),
    siri = rep(1.0, n_rows),
    scr = rep(1.0, n_rows),
    nltt = runif(n = n_rows, min = 0.0, max = 1.0),
    sampling_method = rep("random", n_rows)
  )
  testthat::expect_silent(
    rkt_plot(df_long)
  )
})
