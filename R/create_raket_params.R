#' Create the parameters for one experiment.
#' Run one point of the experiment
#' @inheritParams default_params_doc
#' @param crown_age crown age, in time units
#' @param crown_age_sigma the standard deviation of MRCA prior's
#'   distribution, in time units
#' @param sampling_method method how the incipient species representing a
#'   species is picked. Must be in \link{rkt_get_sampling_methods}.
#' @param mcmc MCMC options, as created by \link[beautier]{create_mcmc}
#' @param tree_sim_rng_seed RNG seed used in the creation of the true
#'   phylogenetic tree
#' @param beast2_rng_seed RNG seed in the creation of the BEAST2 posterior
#'   (based on the alignment)
#' @param site_model site model assumed in the BEAST2 inference
#' @param clock_model clock model assumed in the BEAST2 inference
#' @author Richel J.C. Bilderbeek
#' @export
create_raket_params <- function(
  pbd_params,
  twinning_params = pirouette::create_twinning_params(),
  alignment_params,
  gen_model_select_params,
  best_model_select_params,
  crown_age,
  crown_age_sigma = 0.01,
  sampling_method,
  mcmc,
  tree_sim_rng_seed,
  beast2_rng_seed,
  site_model = "JC69",
  clock_model = "strict"
) {
  raket_params <- list(
    pbd_params = pbd_params,
    twinning_params = twinning_params,
    alignment_params = alignment_params,
    gen_model_select_params = gen_model_select_params,
    best_model_select_params = best_model_select_params,
    crown_age = crown_age,
    crown_age_sigma = crown_age_sigma,
    sampling_method = sampling_method,
    mcmc_chain_length = mcmc$chain_length,
    mcmc_store_every = mcmc$store_every,
    tree_sim_rng_seed = tree_sim_rng_seed,
    beast2_rng_seed = beast2_rng_seed,
    site_model = site_model,
    clock_model = clock_model
  )
  check_raket_params(raket_params)
  raket_params
}
