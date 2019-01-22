context("test-check_raket_params")

test_that("use", {

  pbd_params <- becosys::create_pbd_params(
    sirg = 0.1,
    siri = 0.15,
    scr = 0.2,
    erg = 0.01,
    eri = 0.02
  )
  testit::assert(becosys::is_pbd_params(pbd_params))
  alignment_params <- pirouette::create_alignment_params(
    root_sequence = pirouette::create_blocked_dna(length = 8),
    mutation_rate = 0.1
  )
  gen_model_select_params <- list(
    pirouette::create_gen_model_select_param(
      alignment_params = alignment_params,
      tree_prior = beautier::create_bd_tree_prior()
    )
  )

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
    crown_age = crown_age,
    crown_age_sigma = crown_age_sigma,
    sampling_method = sampling_method,
    mcmc = mcmc,
    tree_sim_rng_seed = tree_sim_rng_seed,
    beast2_rng_seed = beast2_rng_seed,
    site_model = site_model,
    clock_model = clock_model
  )

  expect_silent(
    check_raket_params(raket_params)
  )
})
