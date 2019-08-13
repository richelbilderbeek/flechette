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
  first_experiment <- raket_params$pir_params$experiments[[1]]
  first_inference_model <- first_experiment$inference_model
  crown_age <- first_inference_model$mrca_prior$mrca_distr$mean$value

  pbd_output <- becosys::bco_pbd_sim(
    pbd_params = raket_params$pbd_params,
    crown_age = crown_age,
    add_shortest_and_longest = TRUE
  )
  becosys::check_pbd_sim_out(pbd_output)

  # Save the PBD sim output
  testit::assert("pbd_sim_out_filename" %in% names(raket_params))
  saveRDS(object = pbd_output, file = raket_params$pbd_sim_out_filename)


  # Get a species tree
  true_phylogeny <- NA
  if (raket_params$sampling_method == "shortest") {
    testit::assert("stree_shortest" %in% names(pbd_output))
    true_phylogeny <- pbd_output$stree_shortest
  } else if (raket_params$sampling_method == "longest") {
    testit::assert("stree_longest" %in% names(pbd_output))
    true_phylogeny <- pbd_output$stree_longest
  } else {
    testit::assert(raket_params$sampling_method == "random")
    testit::assert("stree_random" %in% names(pbd_output))
    true_phylogeny <- pbd_output$stree_random
  }
  beautier::check_phylogeny(true_phylogeny)

  # Save the (good) species tree
  true_tree_filename <- raket_params$true_tree_filename
  # Create the folder if needed, no warning when the folder is already present
  dir.create(
    path = dirname(true_tree_filename),
    recursive = TRUE,
    showWarnings = FALSE
  )
  testit::assert(peregrine::is_pff(true_tree_filename))
  testit::assert(beautier::is_phylo(true_phylogeny))
  ape::write.tree(
    phy = true_phylogeny,
    file = true_tree_filename
  )
  beautier::check_file_exists(true_tree_filename, "tree_filename")

  # Let pirouette measure the error
  # The results are stored in the files specifief
  # at raket_params$pir_params$experiments[...]$beast2_options
  testit::assert("pir_params" %in% names(raket_params))
  pirouette::pir_run(
    phylogeny = true_phylogeny,
    pir_params = raket_params$pir_params

  )
}
