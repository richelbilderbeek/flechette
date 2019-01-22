#' Run one point of the experiment
#' @param parameters biological and methodological parameters,
#'   as created by \code{\link{create_raket_params}}
#' @param verbose set to TRUE for more (debug) output
#' @author Richel J.C. Bilderbeek
#' @export
rkt_run <- function(
  parameters,
  verbose = FALSE
) {
  if (!is.na(parameters$beast2_rng_seed) && !(parameters$beast2_rng_seed > 0)) {
    stop("'parameters$beast2_rng_seed' must be NA or non-zero positive")
  }
  testit::assert(beastier::is_beast2_installed())

  chain_length <- parameters$mcmc_chain_length
  store_every <- parameters$mcmc_store_every
  testit::assert(chain_length >= 1000)
  testit::assert(store_every >= 1000)

  set.seed(parameters$tree_sim_rng_seed)

  # Note: if speciation rates are zero, PBD::pbd_sim will last forever
  pbd_output <- becosys::pbd_sim_checked(
    erg = parameters$erg,
    eri = parameters$eri,
    scr = parameters$scr,
    sirg = parameters$sirg,
    siri = parameters$siri,
    crown_age = parameters$crown_age,
    add_shortest_and_longest = TRUE
  )

  true_phylogeny <- NA
  if (parameters$sampling_method == "shortest") {
    true_phylogeny <- pbd_output$stree_shortest
  } else if (parameters$sampling_method == "longest") {
    true_phylogeny <- pbd_output$stree_longest
  } else {
    testit::assert(parameters$sampling_method == "random")
    true_phylogeny <- pbd_output$stree_random
  }

  site_model <- NA
  if (parameters$site_model == "JC69") {
    site_model <- beautier::create_jc69_site_model()
  } else {
    testit::assert(parameters$site_model == "GTR")
    site_model <- beautier::create_gtr_site_model()
  }
  testit::assert(beautier::is_site_model(site_model))

  clock_model <- NA
  if (parameters$clock_model == "strict") {
    clock_model <- beautier::create_strict_clock_model()
  } else {
    testit::assert(parameters$clock_model == "RLN")
    clock_model <- beautier::create_rln_clock_model()
  }
  testit::assert(beautier::is_clock_model(clock_model))

  out <- pirouette::pir_run(
    phylogeny = true_phylogeny,
    sequence_length = NULL, # New interface
    root_sequence = pirouette::create_blocked_dna(
      length = parameters$sequence_length
    ),
    mutation_rate = parameters$mutation_rate,
    site_model = site_model,
    clock_model = clock_model,
    mcmc = beautier::create_mcmc(
      chain_length = chain_length,
      store_every = store_every
    )
    ,
    mrca_distr = beautier::create_normal_distr(
      mean = beautier::create_mean_param(value = parameters$crown_age),
      sigma = beautier::create_sigma_param(value = 0.01)
    ),
    alignment_rng_seed = parameters$alignment_rng_seed,
    beast2_rng_seed = parameters$beast2_rng_seed,
    verbose = verbose
  )
  out$parameters <- parameters
  out$incipient_tree <- pbd_output$igtree.extant
  out$species_tree <- true_phylogeny
  out
}
