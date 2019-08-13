#' Create the set of parameters to use, for each of the
#' two experiment types
#' @inheritParams default_params_doc
#' @return a list of parameters
#' @export
create_params_set <- function(
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
      mcmc_chain_length = mcmc_chain_length,
      sequence_length = sequence_length,
      n_replicates = n_replicates,
      max_n_params = max_n_params
    )
  } else if (experiment_type == "sampling") {
    create_sampling_params_set( # nolint raket function
      mcmc_chain_length = mcmc_chain_length,
      sequence_length = sequence_length,
      n_replicates = n_replicates,
      max_n_params = max_n_params
    )
  } else {
    testit::assert(experiment_type == "test")
    create_test_params_set() # nolint raket function
  }
}
