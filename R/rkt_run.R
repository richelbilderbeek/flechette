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

  # Create a PBD sim output file
  create_pbd_sim_out_file(raket_params)
  beautier::check_file_exists(raket_params$pbd_sim_out_filename)

  # Create a true tree file
  create_true_tree_file(raket_params)
  beautier::check_file_exists(raket_params$true_tree_filename)

  # Get the true tree
  beautier::check_file_exists(raket_params$true_tree_filename)
  true_phylogeny <- ape::read.tree(raket_params$true_tree_filename)
  beautier::check_phylogeny(true_phylogeny)

  # For phylogenies with 5 or less taxa, one cannot use the
  # Coalescent Bayesian Skyline.
  # Remove the pirouette experiments that use CBS
  if (ape::Ntip(true_phylogeny) < 6) {
    raket_params$pir_params$experiments <- razzo::remove_cbs_exps(
      raket_params$pir_params$experiments
    )
  }

  # Let pirouette measure the error
  # The results are stored in the files specified
  # at raket_params$pir_params$experiments[...]$beast2_options
  testit::assert("pir_params" %in% names(raket_params))
  pirouette::pir_run(
    phylogeny = true_phylogeny,
    pir_params = raket_params$pir_params

  )

  # Twin alignment must have as much mutations as the true alignment
  n_mutations_true <- pirouette::count_n_mutations(
    alignment = ape::read.FASTA(
      raket_params$pir_params$alignment_params$fasta_filename
    ),
    root_sequence = raket_params$pir_params$alignment_params$root_sequence
  )
  n_mutations_twin <- pirouette::count_n_mutations(
    alignment = ape::read.FASTA(
      raket_params$pir_params$twinning_params$twin_alignment_filename
    ),
    root_sequence = raket_params$pir_params$alignment_params$root_sequence
  )
  testit::assert(n_mutations_true == n_mutations_twin)

}
