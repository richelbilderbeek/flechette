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
    sampling_method = c("shortest", "longest", "random"),
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

test_that("Can convert a data frame to long form, #5", {

  n_files <- rkt_get_max_n_rows()
  n_nltts <- 1000

  if (!ribir::is_on_travis()) {
    # Smaller on local computer
    n_files <- n_files / 10
    n_nltts <- n_nltts / 10
  }

  df_params <- data.frame(
    sirg = stats::runif(n = n_files),
    siri = stats::runif(n = n_files),
    scr = stats::runif(n = n_files),
    erg = stats::runif(n = n_files),
    eri = stats::runif(n = n_files),
    crown_age = rep(15, n_files),
    crown_age_sigma = rep(0.01, n_files),
    sampling_method = rep(
      c("shortest", "longest", "random"),
      length.out = n_files
    ),
    mutation_rate = rep(66, n_files),
    sequence_length = rep(150, n_files),
    mcmc.chain_length = rep(4000, n_files),
    mcmc.store_every = rep(1000, n_files),
    tree_sim_rng_seed = seq(1, n_files),
    alignment_rng_seed = seq(1, n_files),
    beast2_rng_seed = seq(1, n_files)
  )
  df_nltts <- data.frame(
    matrix(
      data = stats::runif(n = n_files * n_nltts),
      nrow = n_files,
      ncol = n_nltts
    )
  )
  colnames(df_nltts) <- paste0("X.", seq(0, n_nltts - 1))
  colnames(df_nltts)[1] <- "X"
  df <- cbind(df_params, df_nltts)
  rm(df_params)
  rm(df_nltts)
  gc()

  df_long <- to_long(df)
  testthat::expect_equal(nrow(df_long), n_files * n_nltts)
  # 15 params + 1 index + 1 measurement
  testthat::expect_equal(ncol(df_long), 17)

  rm(df)
  rm(df_long)
  # Manually call garbage collection, we need that memory directly
  gc()

})
