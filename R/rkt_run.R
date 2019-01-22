#' Run one point of the experiment
#' @param raket_params biological and methodological raket_params,
#'   as created by \code{\link{create_raket_params}}
#' @param verbose set to TRUE for more (debug) output
#' @author Richel J.C. Bilderbeek
#' @export
rkt_run <- function(
  raket_params,
  verbose = FALSE
) {
  check_raket_params(raket_params)
  testit::assert(beastier::is_beast2_installed())

  chain_length <- raket_params$mcmc_chain_length
  store_every <- raket_params$mcmc_store_every
  testit::assert(chain_length >= 1000)
  testit::assert(store_every >= 1000)

  set.seed(raket_params$tree_sim_rng_seed)

  # Note: if speciation rates are zero, PBD::pbd_sim will last forever
  pbd_output <- becosys::pbd_sim_checked(
    erg = raket_params$pbd_params$erg,
    eri = raket_params$pbd_params$eri,
    scr = raket_params$pbd_params$scr,
    sirg = raket_params$pbd_params$sirg,
    siri = raket_params$pbd_params$siri,
    crown_age = raket_params$crown_age,
    add_shortest_and_longest = TRUE
  )

  true_phylogeny <- NA
  if (raket_params$sampling_method == "shortest") {
    true_phylogeny <- pbd_output$stree_shortest
  } else if (raket_params$sampling_method == "longest") {
    true_phylogeny <- pbd_output$stree_longest
  } else {
    testit::assert(raket_params$sampling_method == "random")
    true_phylogeny <- pbd_output$stree_random
  }

  site_model <- NA
  if (raket_params$site_model == "JC69") {
    site_model <- beautier::create_jc69_site_model()
  } else {
    testit::assert(raket_params$site_model == "GTR")
    site_model <- beautier::create_gtr_site_model()
  }
  testit::assert(beautier::is_site_model(site_model))

  clock_model <- NA
  if (raket_params$clock_model == "strict") {
    clock_model <- beautier::create_strict_clock_model()
  } else {
    testit::assert(raket_params$clock_model == "RLN")
    clock_model <- beautier::create_rln_clock_model()
  }
  testit::assert(beautier::is_clock_model(clock_model))

  out <- pirouette::pir_run(
    phylogeny = true_phylogeny,
    alignment_params = raket_params$alignment_params,
    site_model = site_model,
    clock_model = clock_model,
    mcmc = beautier::create_mcmc(
      chain_length = chain_length,
      store_every = store_every
    )
    ,
    mrca_distr = beautier::create_normal_distr(
      mean = beautier::create_mean_param(value = raket_params$crown_age),
      sigma = beautier::create_sigma_param(value = 0.01)
    ),
    beast2_rng_seed = raket_params$beast2_rng_seed,
    verbose = verbose
  )
  out$raket_params <- raket_params
  out$incipient_tree <- pbd_output$igtree.extant
  out$species_tree <- true_phylogeny
  out
}
