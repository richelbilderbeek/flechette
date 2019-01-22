context("rkt_get_n_params")

test_that("rkt_get_n_params must match the number of parameter", {
  parameters <- create_raket_params(
    pbd_params = becosys::create_pbd_params(
      sirg = 0.1,
      siri = 0.1,
      scr = 0.2,
      erg = 0.01,
      eri = 0.01
    ),
    crown_age = 15,
    crown_age_sigma = 0.01,
    sampling_method = "shortest",
    mutation_rate = 0.1,
    sequence_length = 8,
    mcmc = beautier::create_mcmc(chain_length = 12300),
    tree_sim_rng_seed = 1,
    alignment_rng_seed = 2,
    beast2_rng_seed = 3
  )

  testthat::expect_equal(rkt_get_n_params(), length(unlist(parameters)))
})
