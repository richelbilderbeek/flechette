context("to_long")

test_that("use", {

  n_files <- 3
  n_nltts <- 3 # Called X, X.1 and X.2
  df <- data.frame(
    sirg = stats::runif(n = n_files),
    siri = stats::runif(n = n_files),
    scr = stats::runif(n = n_files),
    erg = stats::runif(n = n_files),
    eri = stats::runif(n = n_files),
    crown_age = rep(15, n_files),
    crown_age_sigma = rep(0.01, n_files),
    sampling_method = c("youngest", "oldest", "random"),
    mutation_rate = rep(66, n_files),
    sequence_length = rep(150, n_files),
    mcmc.chain_length = 4000,
    mcmc.store_every = 1000,
    tree_sim_rng_seed = seq(1, n_files),
    alignment_rng_seed = seq(1, n_files),
    beast2_rng_seed = seq(1, n_files),
    X = stats::runif(n = n_files),
    X.1 = stats::runif(n = n_files),
    X.2 = stats::runif(n = n_files)
  )
  df_long <- to_long(df)
  testthat::expect_equal(nrow(df_long), 9)
  # 15 params + 1 index + 1 measurement
  testthat::expect_equal(ncol(df_long), 17)
})
