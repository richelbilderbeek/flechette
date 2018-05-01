#' Creates the parameter set for the general exploration
#' @param mcmc MCMC options, as created by \link[beautier]{create_mcmc}
#' @param sequence_length DNA alignment sequence length,
#'   in number of nucleotides
#' @param n_replicates number of replicates per biological parameter set
#' @return The filenames of all parameter files created
#' @export
#' @author Richel Bilderbeek
create_general_params_set <- function(
  mcmc = beautier::create_mcmc(chain_length = 1111000, store_every = 1000),
  sequence_length = 15000,
  n_replicates = 1
) {
  # Must start at one, as the BEAST2 RNG seed must be at least one.
  params_set <- list()
  index <- 1
  speciation_initiation_rates <- c(0.1, 0.5, 1.0)
  extinction_rates <- c(0.0, 0.1, 0.2, 0.4)
  for (i in seq(1, n_replicates)) {
    for (sirg in speciation_initiation_rates) {
      for (siri in speciation_initiation_rates) {
        for (scr in c(0.1, 0.3, 1.0, 1000000000)) {
          for (erg in extinction_rates) {
            for (eri in extinction_rates) {
              if (erg >= sirg) next
              if (eri >= siri) next
              if (siri - eri >= 0.8) next
              if (sirg - erg >= 0.8) next
              crown_age <- 15
              if (1 == 2) {
                if (pbd_expected_n_extant(
                  crown_age = crown_age,
                  scr = scr,
                  sirg = sirg,
                  siri = siri,
                  erg = erg,
                  eri = eri,
                  n_sims = 10
                ) > 1000) next
              }

              params <- create_params(
                sirg = sirg,
                siri = siri,
                scr = scr,
                erg = erg,
                eri = eri,
                crown_age = crown_age,
                crown_age_sigma = 0.0005,
                sampling_method = "random",
                mutation_rate = 1 / 15,
                sequence_length = sequence_length,
                mcmc = mcmc,
                tree_sim_rng_seed = index,
                alignment_rng_seed = index,
                beast2_rng_seed = index
              )
              params_set[[index]] <- params
              index <- index + 1
            }
          }
        }
      }
    }
  }
  params_set
}
