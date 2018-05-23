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
  general_params_set <- raket::create_general_params_set(
    mcmc = mcmc,
    sequence_length = sequence_length,
    n_replicates = n_replicates
  )

  sampling_params_set <- list()
  index <- 1
  # Each tree will have a unique RNG seed
  tree_sim_rng_seed <- 1
  for (params in general_params_set) {
    # Remove all SCR == Inf
    if (params$scr >= 1000.0) next
    while (1) {
      tree_sim_rng_seed <- tree_sim_rng_seed + 1
      set.seed(tree_sim_rng_seed)
      out <- pbd_sim_checked(
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
        sampling_params_set[[index]]$sampling_method <- "youngest"
        sampling_params_set[[index + 1]]$sampling_method <- "oldest"
        index <- index + 2
        break ()
      }
    }
  }
  sampling_params_set
}
