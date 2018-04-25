#' Creates the parameter files in the article for the general exploration
#' @param mcmc MCMC options, as created by \link[beautier]{create_mcmc}
#' @param sequence_length DNA alignment sequence length,
#'   in number of nucleotides
#' @param n_replicates number of replicates per biological parameter set
#' @param folder_name name of the folder where all files are created
#' @return The filenames of all parameter files created
#' @export
#' @author Richel Bilderbeek
create_input_files_general <- function(
  mcmc = beautier::create_mcmc(chain_length = 1111000, store_every = 1000),
  sequence_length = 15000,
  n_replicates = 1,
  folder_name = getwd()
) {
  filenames <- NULL
  # Must start at one, as the BEAST2 RNG seed must be at least one.
  index <- 1
  for (i in seq(1, n_replicates)) {
    for (speciation_initiation_rate in c(0.1, 0.5, 1.0)) {
      for (speciation_completion_rate in c(0.1, 0.3, 1.0, 1000000000)) {
        for (extinction_rate in c(0.0, 0.1, 0.2, 0.4)) {
          if (extinction_rate > speciation_initiation_rate) next
          if (speciation_initiation_rate - extinction_rate >= 0.8) next
          filename <- file.path(folder_name, paste0(index, ".RDa"))
          params <- create_params(
            speciation_initiation_rate = speciation_initiation_rate,
            speciation_completion_rate = speciation_completion_rate,
            extinction_rate = extinction_rate,
            crown_age = 15,
            crown_age_sigma = 0.0005,
            sampling_method = "random",
            mutation_rate = 1 / 15,
            sequence_length = sequence_length,
            mcmc = mcmc,
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
  }
  filenames
}
