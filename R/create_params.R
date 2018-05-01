#' Create the parameters
#' Run one point of the experiment
#' @param sirg speciation rate of a good species,
#'   per lineage probability per time unit
#' @param siri speciation rate of an incipient species,
#'   per lineage probability per time unit
#' @param scr speciation completion rate (of
#'   incipient species),
#'   per lineage probability per time unit
#' @param erg extinction rate of a good species,
#'   per lineage probability per time unit
#' @param eri extinction rate of an incipient species,
#'   per lineage probability per time unit
#' @param crown_age crown age, in time units
#' @param crown_age_sigma the standard deviation of MRCA prior's
#'   distribution, in time units
#' @param sampling_method method how the incipient species representing a
#'   species is picked. Must be 'youngest', 'oldest' or 'random'
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
#' @author Richel J.C. Bilderbeek
#' @export
create_params <- function(
  sirg,
  siri,
  scr,
  erg,
  eri,
  crown_age,
  crown_age_sigma = 0.01,
  sampling_method,
  mutation_rate,
  sequence_length,
  mcmc,
  tree_sim_rng_seed,
  alignment_rng_seed,
  beast2_rng_seed
) {
  # TODO: Error checking

  list(
    sirg = sirg,
    siri = siri,
    scr = scr,
    erg = erg,
    eri = eri,
    crown_age = crown_age,
    crown_age_sigma = crown_age_sigma,
    sampling_method = sampling_method,
    mutation_rate = mutation_rate,
    sequence_length = sequence_length,
    mcmc = mcmc,
    tree_sim_rng_seed = tree_sim_rng_seed,
    alignment_rng_seed = alignment_rng_seed,
    beast2_rng_seed = beast2_rng_seed
  )
}
