#' Create the set of parameters for the experiment
#' to measure the effect of sampling
#' @inheritParams create_params_set
#' @export
create_sampling_params_set <- function(
  mcmc = beautier::create_mcmc(chain_length = 1111000, store_every = 1000),
  sequence_length = 15000,
  n_replicates = 1
) {
  # Start from the general parameters set
  params_set <- create_general_params_set(
    mcmc = mcmc,
    sequence_length = sequence_length,
    n_replicates = n_replicates
  )
  # Remove all SCR == Inf
  params_set
}
