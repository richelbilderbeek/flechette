context("create_raket_params")

test_that("use", {

  pbd_params <- becosys::create_pbd_params(
    sirg = 0.1,
    siri = 0.15,
    scr = 0.2,
    erg = 0.01,
    eri = 0.02
  )
  alignment_params <- pirouette::create_alignment_params(
    root_sequence = pirouette::create_blocked_dna(length = 32),
    mutation_rate = 0.12
  )

  crown_age <- 15
  crown_age_sigma <- 0.01
  sampling_method <- "shortest"
  mcmc <- beautier::create_mcmc(chain_length = 12300)
  tree_sim_rng_seed <- 314
  beast2_rng_seed <- 4242
  site_model <- "GTR"
  clock_model <- "RLN"

  parameters <- create_raket_params(
    pbd_params = pbd_params,
    alignment_params = alignment_params,
    crown_age = crown_age,
    crown_age_sigma = crown_age_sigma,
    sampling_method = sampling_method,
    mcmc = mcmc,
    tree_sim_rng_seed = tree_sim_rng_seed,
    beast2_rng_seed = beast2_rng_seed,
    site_model = site_model,
    clock_model = clock_model
  )

  expect_equal(pbd_params, parameters$pbd_params)
  expect_equal(alignment_params, parameters$alignment_params)

  expect_equal(crown_age, parameters$crown_age)
  expect_equal(crown_age_sigma, parameters$crown_age_sigma)
  expect_equal(sampling_method, as.character(parameters$sampling_method))
  expect_equal(mcmc$chain_length, parameters$mcmc_chain_length)
  expect_equal(mcmc$store_every, parameters$mcmc_store_every)
  expect_equal(tree_sim_rng_seed, parameters$tree_sim_rng_seed)
  expect_equal(beast2_rng_seed, parameters$beast2_rng_seed)
  expect_equal(site_model, as.character(parameters$site_model))
  expect_equal(clock_model, as.character(parameters$clock_model))
  expect_equal(rkt_get_n_params(), length(unlist(parameters)))
})
