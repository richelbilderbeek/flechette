context("rkt_run")

test_that("use", {

  skip("Skip all tests")
  for (sampling_method in c("youngest", "oldest", "random")) {
    out <- rkt_run(
      parameters = create_params(
        sirg = 1.0,
        siri = 1.0,
        scr = 1.0,
        erg = 0.1,
        eri = 0.1,
        crown_age = 1.0,
        sampling_method = sampling_method,
        mutation_rate = 0.1,
        sequence_length = 10,
        mcmc = beautier::create_mcmc(chain_length = 2000, store_every = 1000),
        tree_sim_rng_seed = 49,
        alignment_rng_seed = 49,
        beast2_rng_seed = 49
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
    raket::rkt_run(
      parameters = create_params(
        sirg = 0.1,
        siri = 0.1,
        scr = 0.2,
        erg = 0.01,
        eri = 0.01,
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
    raket::rkt_run(
      parameters = create_params(
        sirg = 0.1,
        siri = 0.1,
        scr = 0.2,
        erg = 0.01,
        eri = 0.01,
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
    raket::rkt_run(
      parameters = create_params(
        sirg = 0.1,
        siri = 0.1,
        scr = 0.2,
        erg = 0.01,
        eri = 0.01,
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
