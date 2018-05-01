context("plot")

test_that("use", {

  # Create a fake data frame
  n_rows <- 10
  df_long <- data.frame(
    extinction_rate = rep(0.1, n_rows),
    speciation_initiation_rate = rep(1.0, n_rows),
    speciation_completion_rate = rep(1.0, n_rows),
    nltt = runif(n = n_rows, min = 0.0, max = 1.0),
    sampling_method = rep("fake", n_rows)
  )
  plot(df_long)
})
