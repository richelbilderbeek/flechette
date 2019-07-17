#' Run one point of the experiment
#' @inheritParams default_params_doc
#' @author Richel J.C. Bilderbeek
#' @aliases run_raket rkt_run
#' @export run_raket rkt_run
run_raket <- rkt_run <- function(
  raket_params
) {
  check_raket_params(raket_params) # nolint raket function
  testit::assert(beastier::is_beast2_installed())

  # Simulate incipient species tree
  # Note: if speciation rates are zero, PBD::pbd_sim will last forever
  testit::assert(raket_params$pbd_params$sirg > 0.0)
  testit::assert(raket_params$pbd_params$siri > 0.0)
  set.seed(raket_params$tree_sim_rng_seed)
  pbd_output <- becosys::bco_pbd_sim(
    pbd_params = raket_params$pbd_params,
    crown_age = raket_params$pir_params$experiments[[1]]$inference_model$mrca_prior$mrca_distr$mean$value # nolint sorry Demeter
  )

  # Get a species tree
  true_phylogeny <- NA
  if (raket_params$sampling_method == "shortest") {
    true_phylogeny <- pbd_output$stree_shortest
  } else if (raket_params$sampling_method == "longest") {
    true_phylogeny <- pbd_output$stree_longest
  } else {
    testit::assert(raket_params$sampling_method == "random")
    true_phylogeny <- pbd_output$stree_random
  }
  testit::assert(!is.na(true_phylogeny))

  # Let pirouette measure the error
  # The results are stored in the files specifief
  # at raket_params$pir_params$experiments[...]$beast2_options
  testit::assert("pir_params" %in% names(raket_params))
  pirouette::pir_run(
    phylogeny = true_phylogeny,
    pir_params = raket_params$pir_params

  )
}
