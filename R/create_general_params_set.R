#' Creates the parameter set for the general exploration
#' @inheritParams default_params_doc
#' @export
#' @author Richel Bilderbeek
create_general_params_set <- function(
  crown_age = 15,
  max_n_params = Inf,
  mcmc = beautier::create_mcmc(chain_length = 1111000, store_every = 1000),
  n_replicates = 1,
  sequence_length = 15000
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
              if (!rkt_is_viable(
                  crown_age = crown_age,
                  erg = erg,
                  eri = eri,
                  scr = scr,
                  sirg = sirg,
                  siri = siri
                )
              ) next
              for (clock_model in rkt_get_clock_models()) {
                for (site_model in rkt_get_site_models()) {
                  if (index >= max_n_params) next
                  params <- create_params(
                    sirg = sirg,
                    siri = siri,
                    scr = scr,
                    erg = erg,
                    eri = eri,
                    crown_age = crown_age,
                    crown_age_sigma = 0.0005,
                    sampling_method = "random",
                    mutation_rate = 1.0 / crown_age,
                    sequence_length = sequence_length,
                    mcmc = mcmc,
                    tree_sim_rng_seed = index,
                    alignment_rng_seed = index,
                    beast2_rng_seed = index,
                    site_model = site_model,
                    clock_model = clock_model
                  )
                  params_set[[index]] <- params
                  index <- index + 1
                }
              }
            }
          }
        }
      }
    }
  }
  params_set
}
