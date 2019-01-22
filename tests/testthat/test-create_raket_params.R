context("create_raket_params")

test_that("use", {

  pbd_params <- becosys::create_pbd_params(
    sirg = 0.1,
    siri = 0.15,
    scr = 0.2,
    erg = 0.01,
    eri = 0.02
  )
  crown_age <- 15
  crown_age_sigma <- 0.01
  sampling_method <- "shortest"
  mutation_rate <- 0.1
  sequence_length <- 123
  mcmc <- beautier::create_mcmc(chain_length = 12300)
  tree_sim_rng_seed <- 314
  alignment_rng_seed <- 271
  beast2_rng_seed <- 4242
  site_model <- "GTR"
  clock_model <- "RLN"

  parameters <- create_raket_params(
    pbd_params = pbd_params,
    crown_age = crown_age,
    crown_age_sigma = crown_age_sigma,
    sampling_method = sampling_method,
    mutation_rate = mutation_rate,
    sequence_length = sequence_length,
    mcmc = mcmc,
    tree_sim_rng_seed = tree_sim_rng_seed,
    alignment_rng_seed = alignment_rng_seed,
    beast2_rng_seed = beast2_rng_seed,
    site_model = site_model,
    clock_model = clock_model
  )

  expect_equal(pbd_params, parameters$pbd_params)
  expect_equal(crown_age, parameters$crown_age)
  expect_equal(crown_age_sigma, parameters$crown_age_sigma)
  expect_equal(sampling_method, as.character(parameters$sampling_method))
  expect_equal(mutation_rate, parameters$mutation_rate)
  expect_equal(sequence_length, parameters$sequence_length)
  expect_equal(mcmc$chain_length, parameters$mcmc_chain_length)
  expect_equal(mcmc$store_every, parameters$mcmc_store_every)
  expect_equal(tree_sim_rng_seed, parameters$tree_sim_rng_seed)
  expect_equal(alignment_rng_seed, parameters$alignment_rng_seed)
  expect_equal(beast2_rng_seed, parameters$beast2_rng_seed)
  expect_equal(site_model, as.character(parameters$site_model))
  expect_equal(clock_model, as.character(parameters$clock_model))
  expect_equal(rkt_get_n_params(), length(unlist(parameters)))
})
