#' Creates the parameter set for the general exploration
#' @inheritParams default_params_doc
#' @return a list with each element a parameter combination
#' @export
#' @author Richel Bilderbeek
create_general_params_set <- function(
  crown_age = 15,
  max_n_params = Inf,
  mcmc_chain_length = 1111000,
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
                  increase_factor <- 1
                  if (scr == 1.0) {
                    increase_factor <- increase_factor * 2
                  }
                  if (sirg == 0.5) {
                    increase_factor <- increase_factor * 2
                  }
                  if (siri == 0.5) {
                    increase_factor <- increase_factor * 2
                  }
                  pbd_params <- becosys::create_pbd_params(
                    sirg = sirg,
                    siri = siri,
                    scr = scr,
                    erg = erg,
                    eri = eri
                  )
                  alignment_params <- pirouette::create_alignment_params(
                    root_sequence = pirouette::create_blocked_dna(
                      length = sequence_length
                    ),
                    mutation_rate = 1.0 / crown_age,
                    rng_seed = index
                  )
                  gen_model_select_params <- list(
                    pirouette::create_gen_model_select_param(
                      alignment_params = alignment_params,
                      tree_prior = beautier::create_bd_tree_prior()
                    )
                  )

                  params <- create_raket_params(
                    pbd_params = pbd_params,
                    alignment_params = alignment_params,
                    gen_model_select_params = gen_model_select_params,
                    crown_age = crown_age,
                    crown_age_sigma = 0.0005,
                    sampling_method = "random",
                    mcmc = beautier::create_mcmc(
                      chain_length = mcmc_chain_length * increase_factor,
                      store_every = 1000 * increase_factor
                    ),
                    tree_sim_rng_seed = index,
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
