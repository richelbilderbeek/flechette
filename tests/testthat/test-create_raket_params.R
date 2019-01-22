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
  gen_model_select_params <- list(
    pirouette::create_gen_model_select_param(
      alignment_params = alignment_params
    )
  )
  pirouette:::check_model_select_params(gen_model_select_params)

  best_model_select_params <- list(pirouette::create_best_model_select_param())
  pirouette:::check_model_select_params(best_model_select_params)

  crown_age <- 15
  crown_age_sigma <- 0.01
  sampling_method <- "shortest"
  mcmc <- beautier::create_mcmc(chain_length = 12300)
  tree_sim_rng_seed <- 314
  beast2_rng_seed <- 4242
  site_model <- "GTR"
  clock_model <- "RLN"

  raket_params <- create_raket_params(
    pbd_params = pbd_params,
    alignment_params = alignment_params,
    gen_model_select_params = gen_model_select_params,
    best_model_select_params = best_model_select_params,
    crown_age = crown_age,
    crown_age_sigma = crown_age_sigma,
    sampling_method = sampling_method,
    mcmc = mcmc,
    tree_sim_rng_seed = tree_sim_rng_seed,
    beast2_rng_seed = beast2_rng_seed,
    site_model = site_model,
    clock_model = clock_model
  )

  expect_equal(pbd_params, raket_params$pbd_params)
  expect_equal(alignment_params, raket_params$alignment_params)
  expect_equal(gen_model_select_params, raket_params$gen_model_select_params)
  expect_equal(best_model_select_params, raket_params$best_model_select_params)

  expect_equal(crown_age, raket_params$crown_age)
  expect_equal(crown_age_sigma, raket_params$crown_age_sigma)
  expect_equal(sampling_method, as.character(raket_params$sampling_method))
  expect_equal(mcmc$chain_length, raket_params$mcmc_chain_length)
  expect_equal(mcmc$store_every, raket_params$mcmc_store_every)
  expect_equal(tree_sim_rng_seed, raket_params$tree_sim_rng_seed)
  expect_equal(beast2_rng_seed, raket_params$beast2_rng_seed)
  expect_equal(site_model, as.character(raket_params$site_model))
  expect_equal(clock_model, as.character(raket_params$clock_model))
  expect_equal(rkt_get_n_params(), length(unlist(raket_params)))
})
