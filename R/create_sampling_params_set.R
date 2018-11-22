#' Create the set of parameters for the experiment
#' to measure the effect of sampling
#' @inheritParams create_params_set
#' @export
create_sampling_params_set <- function(
  mcmc_chain_length = 1111000,
  sequence_length = 15000,
  n_replicates = 1,
  max_n_params = Inf
) {
  # Start from the general parameters set
  general_params_set <- raket::create_general_params_set(
    mcmc_chain_length = mcmc_chain_length,
    sequence_length = sequence_length,
    n_replicates = n_replicates,
    max_n_params = max_n_params
  )

  sampling_params_set <- list()
  index <- 1
  # Each tree will have a unique RNG seed
  tree_sim_rng_seed <- 3480
  for (params in general_params_set) {
    # Remove all SCR == Inf
    if (params$scr >= 1000.0) next
    while (index < max_n_params) {
      # First seed will be 3481
      tree_sim_rng_seed <- tree_sim_rng_seed + 1
      set.seed(tree_sim_rng_seed)
      out <- becosys::pbd_sim_checked(
        erg = params$erg,
        eri = params$eri,
        scr = params$scr,
        sirg = params$sirg,
        siri = params$siri,
        crown_age = params$crown_age
      )
      sum_youngest <- sum(out$stree_youngest$edge.length)
      sum_oldest <- sum(out$stree_oldest$edge.length)
      if (sum_youngest != sum_oldest) {
        # Found one!
        sampling_params_set[[index]] <- params
        sampling_params_set[[index + 1]] <- params
        sampling_params_set[[index]]$tree_sim_rng_seed <- tree_sim_rng_seed
        sampling_params_set[[index + 1]]$tree_sim_rng_seed <- tree_sim_rng_seed
        sampling_params_set[[index]]$sampling_method <- "shortest"
        sampling_params_set[[index + 1]]$sampling_method <- "longest"
        index <- index + 2
        break ()
      }
    }
  }
  sampling_params_set
}
