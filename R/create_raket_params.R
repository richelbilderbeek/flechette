#' Create the parameters for one experiment.
#' Run one point of the experiment
#' @inheritParams default_params_doc
#' @param crown_age crown age, in time units
#' @param crown_age_sigma the standard deviation of MRCA prior's
#'   distribution, in time units
#' @param sampling_method method how the incipient species representing a
#'   species is picked. Must be in \link{rkt_get_sampling_methods}.
#' @param mutation_rate per-nucleotide probability to mutate per time unit
#' @param sequence_length length of simulated DNA alignment,
#'   number of base pairs
#' @param mcmc MCMC options, as created by \link[beautier]{create_mcmc}
#' @param tree_sim_rng_seed RNG seed used in the creation of the true
#'   phylogenetic tree
#' @param alignment_rng_seed RNG seed used in the creation of the simulated
#'   alignment (from the true phylogenetic tree)
#' @param beast2_rng_seed RNG seed in the creation of the BEAST2 posterior
#'   (based on the alignment)
#' @param site_model site model assumed in the BEAST2 inference
#' @param clock_model clock model assumed in the BEAST2 inference
#' @author Richel J.C. Bilderbeek
#' @export
create_raket_params <- function(
  pbd_params,
  twinning_params = pirouette::create_twinning_params(),
  crown_age,
  crown_age_sigma = 0.01,
  sampling_method,
  mutation_rate,
  sequence_length,
  mcmc,
  tree_sim_rng_seed,
  alignment_rng_seed,
  beast2_rng_seed,
  site_model = "JC69",
  clock_model = "strict"
) {
  raket_params <- list(
    pbd_params = pbd_params,
    twinning_params = twinning_params,
    crown_age = crown_age,
    crown_age_sigma = crown_age_sigma,
    sampling_method = sampling_method,
    mutation_rate = mutation_rate,
    sequence_length = sequence_length,
    mcmc_chain_length = mcmc$chain_length,
    mcmc_store_every = mcmc$store_every,
    tree_sim_rng_seed = tree_sim_rng_seed,
    alignment_rng_seed = alignment_rng_seed,
    beast2_rng_seed = beast2_rng_seed,
    site_model = site_model,
    clock_model = clock_model
  )
  check_raket_params(raket_params)
  raket_params
}
