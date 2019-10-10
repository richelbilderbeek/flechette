#' Create the file for the true tree
#' @inheritParams default_params_doc
#' @export
create_true_tree_file <- function(raket_params) {
  raket::check_raket_params(raket_params)

  # Read the PBD sim output
  beautier::check_file_exists(raket_params$pbd_sim_out_filename)
  pbd_output <- readRDS(raket_params$pbd_sim_out_filename)

  # Obtain the desired phylogeny from the PBD sim output
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
  beautier::check_file_exists(true_tree_filename)
  true_tree_filename
}
