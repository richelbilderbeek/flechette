#' Creates the parameter files in the article
#' Now every parameter setting has its own seed
#' @param mcmc_length number of states in the MCMC chain
#' @return The filenames of all parameter files created
#' @export
#' @author Richel Bilderbeek
create_input_files <- function(
  mcmc_length = 1000000
) {
  filenames <- NULL
  # Must start at one, as the BEAST2 RNG seed must be at least one.
  index <- 1
  for (speciation_initiation_rate in c(0.2, 0.4)) {
    for (speciation_completion_rate in c(0.1, 0.3, 1.0, 1000000000)) {
      for (extinction_rate in c(0.0, 0.1, 0.2)) {
        if (extinction_rate > speciation_initiation_rate) next
        sampling_method <- "youngest"
        if (index %% 2 == 1) sampling_method <- "oldest"

        filename <- paste0(index, ".RDa")
        params <- create_params(
          speciation_initiation_rate = speciation_initiation_rate,
          speciation_completion_rate = speciation_completion_rate,
          extinction_rate = extinction_rate,
          crown_age = 15,
          crown_age_sigma = 0.01,
          sampling_method = sampling_method,
          mutation_rate = 1000 / 15,
          sequence_length = 15000,
          mcmc_length = mcmc_length,
          tree_sim_rng_seed = index,
          alignment_rng_seed = index,
          beast2_rng_seed = index
        )
        saveRDS(object = params, file = filename)
        index <- index + 1
        filenames <- c(filenames, filename)
      }
    }
  }
  filenames
}
