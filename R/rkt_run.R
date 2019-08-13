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

  create_pbd_output_file(raket_params)

  beautier::check_file_exists(raket_params$pbd_sim_out_filename)
  pbd_output <- readRDS(raket_params$pbd_sim_out_filename)

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
