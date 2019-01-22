context("rkt_run")

test_that("use", {

  if (!beastier::is_on_travis()) return()
  params <- create_raket_params(
    pbd_params = becosys::create_pbd_params(
      sirg = 1.0,
      siri = 1.0,
      scr = 1.0,
      erg = 0.1,
      eri = 0.1
    ),
    crown_age = 1.0,
    sampling_method = "shortest",
    mutation_rate = 0.1,
    sequence_length = 8,
    mcmc = beautier::create_mcmc(chain_length = 2000, store_every = 1000),
    tree_sim_rng_seed = 49,
    alignment_rng_seed = 49,
    beast2_rng_seed = 49
  )

  for (sampling_method in rkt_get_sampling_methods()) {
    out <- rkt_run(parameters = params)
    expect_true("parameters" %in% names(out))
    expect_true("incipient_tree" %in% names(out))
    expect_true("species_tree" %in% names(out))
    expect_true("alignment" %in% names(out))
    expect_true("trees" %in% names(out))
    expect_true("estimates" %in% names(out))
  }
})

test_that("abuse", {

  pbd_params <- becosys::create_pbd_params(
    sirg = 1.0,
    siri = 1.0,
    scr = 1.0,
    erg = 0.1,
    eri = 0.1
  )

  expect_error(
    raket::rkt_run(
      parameters = create_raket_params(
        pbd_params = pbd_params,
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
})
