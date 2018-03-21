context("run")

test_that("use", {

  out <- run(
    parameters = create_params(
      speciation_initiation_rate = 0.1,
      speciation_completion_rate = 0.2,
      extinction_rate = 0.01,
      crown_age = 15,
      sampling_method = "youngest",
      mutation_rate = 0.1,
      sequence_length = 100,
      mcmc_length = 2000,
      minimal_ess = 1,
      tree_sim_rng_seed = 42,
      alignment_rng_seed = 42,
      beast2_rnd_seed = 42
    )
  )
  testthat::expect_true("parameters" %in% names(out))
  testthat::expect_true("incipient_tree" %in% names(out))
  testthat::expect_true("species_tree" %in% names(out))
  testthat::expect_true("alignment" %in% names(out))
  testthat::expect_true("trees" %in% names(out))
  testthat::expect_true("estimates" %in% names(out))
})
