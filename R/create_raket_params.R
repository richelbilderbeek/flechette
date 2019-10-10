#' Create the parameters for one experiment.
#' Run one point of the experiment
#' @inheritParams default_params_doc
#' @author Richel J.C. Bilderbeek
#' @aliases create_raket_params create_params_raket
#' @export create_raket_params create_params_raket
create_raket_params <- create_params_raket <- function(
  pbd_params,
  pir_params,
  sampling_method,
  true_tree_filename = file.path(
    dirname(pir_params$alignment_params$fasta_filename), "pbd.newick"
  ),
  pbd_sim_out_filename = file.path(
    dirname(pir_params$alignment_params$fasta_filename), "pbd_sim_out.RDa"
  )
) {
  becosys::check_pbd_params(pbd_params)
  pirouette::check_pir_params(pir_params)
  check_sampling_method(sampling_method)
  assertive::assert_is_a_string(true_tree_filename)

  raket_params <- list(
    pbd_params = pbd_params,
    pir_params = pir_params,
    sampling_method = sampling_method,
    true_tree_filename = true_tree_filename,
    pbd_sim_out_filename = pbd_sim_out_filename
  )
  raket::check_raket_params(raket_params)
  raket_params
}
