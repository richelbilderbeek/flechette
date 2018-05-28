#' Create the set of parameters to use, for each of the
#' two experiment types
#' @param experiment_type type of experiment,
#'   must be either 'general' or 'sampling'
#' @param mcmc MCMC options,
#'   as created by \link[beautier]{create_mcmc}
#' @param sequence_length DNA alignment sequence length,
#'   in number of nucleotides
#' @param n_replicates number of replicates per biological parameter set
#' @param max_n_params the maximum number of parameters created. Set to a lower
#'   value in debugging 
#' @return a list of parameters
#' @export
create_params_set <- function(
  experiment_type,
  mcmc = beautier::create_mcmc(chain_length = 1111000, store_every = 1000),
  sequence_length = 15000,
  n_replicates = 1,
  max_n_params = Inf
) {
  if(!experiment_type %in%
    raket::rkt_get_experiment_types()
  ) {
    stop("'experiment_type' must be 'general' or 'sampling'")
  }
  if (experiment_type == "general") {
    create_general_params_set(
      mcmc = mcmc,
      sequence_length = sequence_length,
      n_replicates = n_replicates,
      max_n_params = max_n_params
    )
  } else {
    testit::assert(experiment_type == "sampling")
    create_sampling_params_set(
      mcmc = mcmc,
      sequence_length = sequence_length,
      n_replicates = n_replicates,
      max_n_params = max_n_params
    )
  }
}
