#' Create a test \code{raket_params}
#'
#' @return a test \code{raket_params},
#'   as can be created by \link{create_raket_params}
#' @export
#' @author Richel J.C. Bilderbeek
create_test_raket_params <- function() {
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
      alignment_params = alignment_params,
      tree_prior = beautier::create_bd_tree_prior()
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

  create_raket_params(
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
}
