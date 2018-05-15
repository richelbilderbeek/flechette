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
  for (i in seq(1, n_replicates)) {
    for (sirg in rkt_get_spec_init_rates()) {
      for (siri in rkt_get_spec_init_rates()) {
        for (scr in rkt_get_spec_compl_rates()) {
          for (erg in rkt_get_ext_rates()) {
            for (eri in rkt_get_ext_rates()) {
              if (erg >= sirg) next
              if (eri >= siri) next
              if (siri - eri >= 0.4) next
              if (sirg - erg >= 0.4) next
              crown_age <- 15

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
