#' Create the file to store the results of a PBD sim
#' @return the filename
#' @inheritParams default_params_doc
#' @export
create_pbd_sim_out_file <- function(raket_params) {
  raket::check_raket_params(raket_params)

  # Simulate incipient species tree
  # Note: if speciation rates are zero, PBD::pbd_sim will last forever
  testit::assert(raket_params$pbd_params$sirg > 0.0)
  testit::assert(raket_params$pbd_params$siri > 0.0)
  set.seed(raket_params$tree_sim_rng_seed)
  first_experiment <- raket_params$pir_params$experiments[[1]]
  first_inference_model <- first_experiment$inference_model
  crown_age <- first_inference_model$mrca_prior$mrca_distr$mean$value

  pbd_sim_out <- becosys::bco_pbd_sim(
    pbd_params = raket_params$pbd_params,
    crown_age = crown_age,
    add_shortest_and_longest = TRUE
  )
  becosys::check_pbd_sim_out(pbd_sim_out)

  # Save the PBD sim output
  testit::assert("pbd_sim_out_filename" %in% names(raket_params))
  dir.create(
    dirname(raket_params$pbd_sim_out_filename),
    recursive = TRUE,
    showWarnings = FALSE
  )
  saveRDS(object = pbd_sim_out, file = raket_params$pbd_sim_out_filename)
  raket_params$pbd_sim_out_filename
}
