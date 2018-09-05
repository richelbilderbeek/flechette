context("rkt_create_data_frame")

test_that("use, general", {
  n_replicates <- 1
  n_nltts <- 5
  df <- rkt_create_data_frame(
    n_replicates = n_replicates,
    n_nltts = n_nltts,
    experiment_type = "general"
  )
  expect_equal(nrow(df), n_replicates * rkt_get_n_param_combos())
  expect_equal(ncol(df), rkt_get_n_params() + n_nltts)
  expect_true(is.numeric(df$sirg))
  expect_true(is.numeric(df$siri))
  expect_true(is.numeric(df$scr))
  expect_true(is.numeric(df$erg))
  expect_true(is.numeric(df$eri))
  expect_true(is.numeric(df$crown_age))
  expect_true(is.numeric(df$crown_age_sigma))
  expect_true(is.numeric(df$mutation_rate))
  expect_true(is.numeric(df$sequence_length))
  expect_true(is.numeric(df$mcmc.chain_length))
  expect_true(is.numeric(df$mcmc.store_every))
  expect_true(is.numeric(df$tree_sim_rng_seed))
  expect_true(is.numeric(df$alignment_rng_seed))
  expect_true(is.numeric(df$beast2_rng_seed))
})

test_that("use, sampling", {
  n_nltts <- 5
  max_n_params <- 2
  testit::assert(max_n_params %% 2 == 0)
  df <- rkt_create_data_frame(
    n_replicates = 1,
    n_nltts = n_nltts,
    experiment_type = "sampling",
    max_n_params = 2
  )
  testthat::expect_equal(nrow(df), max_n_params)
  testthat::expect_equal(ncol(df), rkt_get_n_params() + n_nltts)
})
