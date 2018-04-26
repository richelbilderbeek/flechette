context("run")

test_that("use", {

  set.seed(42)
  for (sampling_method in c("youngest", "oldest", "random")) {
    out <- run(
      parameters = create_params(
        speciation_initiation_rate = 0.01,
        speciation_completion_rate = 0.02,
        extinction_rate = 0.001,
        crown_age = 15,
        sampling_method = sampling_method,
        mutation_rate = 0.1,
        sequence_length = 100,
        mcmc = beautier::create_mcmc(chain_length = 2000),
        tree_sim_rng_seed = 42,
        alignment_rng_seed = 42,
        beast2_rng_seed = 42
      )
    )
    testthat::expect_true("parameters" %in% names(out))
    testthat::expect_true("incipient_tree" %in% names(out))
    testthat::expect_true("species_tree" %in% names(out))
    testthat::expect_true("alignment" %in% names(out))
    testthat::expect_true("trees" %in% names(out))
    testthat::expect_true("estimates" %in% names(out))
  }
})

test_that("abuse", {

  testthat::expect_error(
    run(
      parameters = create_params(
        speciation_initiation_rate = 0.1,
        speciation_completion_rate = 0.2,
        extinction_rate = 0.01,
        crown_age = 15,
        sampling_method = "random",
        mutation_rate = 0.1,
        sequence_length = 100,
        mcmc = beautier::create_mcmc(chain_length = 2000),
        tree_sim_rng_seed = 42,
        alignment_rng_seed = 42,
        beast2_rng_seed = 0 # Error here
      )
    ),
    "'parameters\\$beast2_rng_seed' must be NA or non-zero positive"
  )

  testthat::expect_error(
    run(
      parameters = create_params(
        speciation_initiation_rate = 0.1,
        speciation_completion_rate = 0.2,
        extinction_rate = 0.01,
        crown_age = 15,
        sampling_method = "random",
        mutation_rate = 0.1,
        sequence_length = 100,
        mcmc = "nonsense", # Error here
        tree_sim_rng_seed = 42,
        alignment_rng_seed = 42,
        beast2_rng_seed = 42
      )
    ),
    "'parameters\\$mcmc' must be an MCMC as created by beautier::create_mcmc"
  )

  testthat::expect_error(
    run(
      parameters = create_params(
        speciation_initiation_rate = 0.1,
        speciation_completion_rate = 0.2,
        extinction_rate = 0.01,
        crown_age = 15,
        sampling_method = "random",
        mutation_rate = 0.1,
        sequence_length = 100,
        mcmc = beautier::create_mcmc(chain_length = 2000),
        tree_sim_rng_seed = 42,
        alignment_rng_seed = 42,
        beast2_rng_seed = 42
      ),
      beast_jar_path = "abs.ent"
    ),
    "'beast_jar_path' is invalid path to BEAST2"
  )
})
