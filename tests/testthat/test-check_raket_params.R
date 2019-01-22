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
  raket_params <- create_raket_params(
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

  expect_silent(
    check_raket_params(raket_params)
  )
})
