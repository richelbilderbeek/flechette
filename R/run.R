#' Run one point of the experiment
#' @param parameters biological and methodological parameters,
#'   as created by \code{\link{create_params}}
#' @param beast_jar_path the path of beast.jar
#' @param verbose set to TRUE for more (debug) output
#' @author Richel J.C. Bilderbeek
#' @export
run <- function(
  parameters,
  beast_jar_path = beastier::get_default_beast2_jar_path(),
  verbose = FALSE
) {
  if (!is.na(parameters$beast2_rng_seed) && !(parameters$beast2_rng_seed > 0)) {
    stop("'parameters$beast2_rng_seed' must be NA or non-zero positive")
  }
  if (!beautier:::is_mcmc(parameters$mcmc)) {
    stop(
      "'parameters$mcmc' must be an MCMC as created by beautier::create_mcmc"
    )
  }
  if (!file.exists(beast_jar_path)) {
    stop("'beast_jar_path' is invalid path to BEAST2")
  }

  set.seed(parameters$tree_sim_rng_seed)

  # SCR: Specition Completion rate
  scr <- parameters$scr
  # SIR: Speciation Initation Rate (for Incipient or Good species)
  sirg <- parameters$sirg
  siri <- parameters$siri
  # ER: Extinction Rate (for Incipient or Good species)
  erg <- parameters$erg
  eri <- parameters$eri
  pbd_parameters <- c(
    sirg,
    scr,
    siri,
    erg,
    eri
  )

  # Note: if speciation rates are zero, PBD::pbd_sim will last forever
  pbd_output <- PBD::pbd_sim(
    pbd_parameters,
    age = parameters$crown_age,
    soc = 2, # crown
    plotit = FALSE
  )
  true_phylogeny <- NA
  if (parameters$sampling_method == "youngest") {
    true_phylogeny <- pbd_output$stree_youngest
  } else if (parameters$sampling_method == "oldest") {
    true_phylogeny <- pbd_output$stree_oldest
  } else {
    testit::assert(parameters$sampling_method == "random")
    true_phylogeny <- pbd_output$stree_random
  }
  out <- pirouette::run(
    phylogeny = true_phylogeny,
    sequence_length = parameters$sequence_length,
    mutation_rate = parameters$mutation_rate,
    mcmc = parameters$mcmc,
    mrca_distr = beautier::create_normal_distr(
      mean = beautier::create_mean_param(value = parameters$crown_age),
      sigma = beautier::create_sigma_param(value = 0.01)
    ),
    alignment_rng_seed = parameters$alignment_rng_seed,
    beast2_rng_seed = parameters$beast2_rng_seed,
    verbose = verbose,
    beast_jar_path = beast_jar_path
  )
  out$parameters <- parameters
  out$incipient_tree <- pbd_output$igtree.extant
  out$species_tree <- true_phylogeny
  out
}
