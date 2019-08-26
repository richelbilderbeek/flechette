#' Create the set of parameters to use, for each of the
#' two experiment types
#' @inheritParams default_params_doc
#' @return a list of parameters
#' @export
create_params_set <- function(
  project_folder_name = file.path(peregrine::get_pff_tempdir(), "raket_werper"),
  experiment_type,
  mcmc_chain_length = 1111000,
  sequence_length = 15000,
  n_replicates = 1,
  max_n_params = Inf
) {
  if (!experiment_type %in%
    raket::rkt_get_experiment_types()
  ) {
    stop("'experiment_type' must be in 'rkt_get_experiment_types()'")
  }
  if (experiment_type == "general") {
    create_general_params_set( # nolint raket function
      project_folder_name = project_folder_name,
      n_replicates = n_replicates
    )
  } else if (experiment_type == "sampling") {
    create_sampling_params_set( # nolint raket function
      project_folder_name = project_folder_name,
      n_replicates = n_replicates
    )
  } else {
    testit::assert(experiment_type == "test")
    create_test_params_set() # nolint raket function
  }
}
