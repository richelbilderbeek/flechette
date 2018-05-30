#' Create the parameters for one experiment.
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
  beast2_rng_seed,
  site_model = "JC69",
  clock_model = "strict"
) {
  testit::assert(sirg >= 0.0)
  testit::assert(siri >= 0.0)
  testit::assert(scr >= 0.0)
  testit::assert(erg >= 0.0)
  testit::assert(eri >= 0.0)
  testit::assert(crown_age > 0.0)
  testit::assert(crown_age_sigma > 0.0)
  testit::assert(mutation_rate >= 0.0)
  testit::assert(sequence_length >= 0.0)
  testit::assert(sampling_method %in% raket::rkt_get_sampling_methods())
  testit::assert(site_model %in% raket::rkt_get_site_models())
  testit::assert(clock_model %in% raket::rkt_get_clock_models())

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
    beast2_rng_seed = beast2_rng_seed,
    site_model = site_model,
    clock_model = clock_model
  )
}
