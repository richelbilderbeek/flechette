context("create_params")

test_that("use", {

  sirg <- 0.1
  siri <- 0.1
  scr <- 0.2
  erg <- 0.01
  eri <- 0.01
  crown_age <- 15
  crown_age_sigma <- 0.01
  sampling_method <- "youngest"
  mutation_rate <- 0.1
  sequence_length <- 123
  mcmc <- beautier::create_mcmc(chain_length = 12300)
  tree_sim_rng_seed <- 314
  alignment_rng_seed <- 271
  beast2_rng_seed <- 4242

  parameters <- create_params(
    sirg = sirg,
    siri = siri,
    scr = scr,
    erg = erg,
    eri = eri,
    crown_age = crown_age,
    crown_age_sigma = crown_age_sigma,
    sampling_method = sampling_method,
    mutation_rate = mutation_rate,
    sequence_length = sequence_length,
    mcmc = mcmc,
    tree_sim_rng_seed = tree_sim_rng_seed,
    alignment_rng_seed = alignment_rng_seed,
    beast2_rng_seed = beast2_rng_seed
  )

  testthat::expect_equal(sirg, parameters$sirg)
  testthat::expect_equal(siri, parameters$siri)
  testthat::expect_equal(scr, parameters$scr)
  testthat::expect_equal(erg, parameters$erg)
  testthat::expect_equal(eri, parameters$eri)
  testthat::expect_equal(crown_age, parameters$crown_age)
  testthat::expect_equal(crown_age_sigma, parameters$crown_age_sigma)
  testthat::expect_equal(sampling_method, parameters$sampling_method)
  testthat::expect_equal(mutation_rate, parameters$mutation_rate)
  testthat::expect_equal(sequence_length, parameters$sequence_length)
  testthat::expect_equal(mcmc, parameters$mcmc)
  testthat::expect_equal(tree_sim_rng_seed, parameters$tree_sim_rng_seed)
  testthat::expect_equal(alignment_rng_seed, parameters$alignment_rng_seed)
  testthat::expect_equal(beast2_rng_seed, parameters$beast2_rng_seed)

})
