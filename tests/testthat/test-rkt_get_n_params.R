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
    alignment_params = pirouette::create_alignment_params(
      root_sequence = pirouette::create_blocked_dna(length = 8),
      mutation_rate = 0.1
    ),
    crown_age = 15,
    crown_age_sigma = 0.01,
    sampling_method = "shortest",
    mcmc = beautier::create_mcmc(chain_length = 12300),
    tree_sim_rng_seed = 1,
    beast2_rng_seed = 3
  )

  expect_equal(rkt_get_n_params(), length(unlist(parameters)))
})
