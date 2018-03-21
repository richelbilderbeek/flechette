#' Creates the parameter files in the article
#' Now every parameter setting has its own seed
#' @param mcmc_length number of states in the MCMC chain
#' @param minimal_ess minimal posterior Effect Sample Size
#' @return The filenames of all parameter files created
#' @export
#' @author Richel Bilderbeek
create_input_files <- function(
  mcmc_length = 1000000,
  minimal_ess = 200
) {
  filenames <- NULL
  index <- 0
  for (speciation_initiation_rate in c(0.2, 0.4)) {
    for (speciation_completion_rate in c(0.1, 0.3, 1.0, 1000000)) {
      for (extinction_rate in c(0.0, 0.1, 0.2)) {
        if (extinction_rate > speciation_initiation_rate) next
        for (sampling_method in c("youngest", "oldest")) {
          for (mutation_rate in c(0.05)) {
            for (sequence_length in c(1000, 10000)) {
              for (alignment_rng_seed in seq(1, 2)) {
                for (beast2_rnd_seed in seq(1, 2)) {
                  # Always use different trees
                  for (tree_sim_rng_seed in seq(index, index + 10)) {

                    filename <- paste0(index, ".RDa")
                    params <- create_params(
                      speciation_initiation_rate = speciation_initiation_rate,
                      speciation_completion_rate = speciation_completion_rate,
                      extinction_rate = extinction_rate,
                      crown_age = 15,
                      crown_age_sigma = 0.01,
                      sampling_method = sampling_method,
                      mutation_rate = mutation_rate,
                      sequence_length = sequence_length,
                      mcmc_length = mcmc_length,
                      minimal_ess = minimal_ess,
                      tree_sim_rng_seed = tree_sim_rng_seed,
                      alignment_rng_seed = alignment_rng_seed,
                      beast2_rnd_seed = beast2_rnd_seed
                    )
                    saveRDS(object = params, file = filename)
                    index <- index + 1
                    filenames <- c(filenames, filename)
                  }
                }
              }
            }
          }
        }
      }
    }
  }
  filenames
}
