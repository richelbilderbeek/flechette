context("create_params")

test_that("use", {

  speciation_initiation_rate <- 0.1
  speciation_completion_rate <- 0.2
  extinction_rate <- 0.01
  crown_age <- 15
  crown_age_sigma <- 0.01
  sampling_method <- "youngest"
  mutation_rate <- 0.1
  sequence_length <- 123
  mcmc_length <- 12300
  minimal_ess <- 234
  tree_sim_rng_seed <- 314
  alignment_rng_seed <- 271
  beast2_rnd_seed <- 4242

  parameters <- create_params(
    speciation_initiation_rate = speciation_initiation_rate,
    speciation_completion_rate = speciation_completion_rate,
    extinction_rate = extinction_rate,
    crown_age = crown_age,
    crown_age_sigma = crown_age_sigma,
    sampling_method = sampling_method,
    mutation_rate = mutation_rate,
    sequence_length = sequence_length,
    mcmc_length = mcmc_length,
    minimal_ess = minimal_ess,
    tree_sim_rng_seed = tree_sim_rng_seed,
    alignment_rng_seed = alignment_rng_seed,
    beast2_rnd_seed = beast2_rnd_seed
  )

  testthat::expect_equal(
    speciation_initiation_rate, parameters$speciation_initiation_rate
  )
  testthat::expect_equal(
    speciation_completion_rate, parameters$speciation_completion_rate
  )
  testthat::expect_equal(extinction_rate, parameters$extinction_rate)
  testthat::expect_equal(crown_age, parameters$crown_age)
  testthat::expect_equal(crown_age_sigma, parameters$crown_age_sigma)
  testthat::expect_equal(sampling_method, parameters$sampling_method)
  testthat::expect_equal(mutation_rate, parameters$mutation_rate)
  testthat::expect_equal(sequence_length, parameters$sequence_length)
  testthat::expect_equal(mcmc_length, parameters$mcmc_length)
  testthat::expect_equal(minimal_ess, parameters$minimal_ess)
  testthat::expect_equal(tree_sim_rng_seed, parameters$tree_sim_rng_seed)
  testthat::expect_equal(alignment_rng_seed, parameters$alignment_rng_seed)
  testthat::expect_equal(beast2_rnd_seed, parameters$beast2_rnd_seed)

})
