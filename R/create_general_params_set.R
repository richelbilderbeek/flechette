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
  bio_params_all <- expand.grid(
    sirg = rkt_get_spec_init_rates(),
    siri = rkt_get_spec_init_rates(),
    scr = rkt_get_spec_compl_rates(),
    erg = rkt_get_ext_rates(),
    eri = rkt_get_ext_rates()
  )
  bio_params <- bio_params_all[
    rkt_are_viable(
      crown_age = crown_age,
      ergs = bio_params_all$erg,
      eris = bio_params_all$eri,
      scrs = bio_params_all$scr,
      sirgs = bio_params_all$sirg,
      siris = bio_params_all$siri
    ), ]

  # All shared variables, only the RNG seed needs to be set
  twinning_params <- create_twinning_params()
  alignment_params <- create_alignment_params(
    root_sequence = create_blocked_dna(
      length = sequence_length
    ),
    mutation_rate = 1.0 / crown_age
  )
  ##############################################################################
  # Create all experiments
  ##############################################################################
  #
  # +-----+-----+------+-----+
  # |     |site |clock |tree |
  # |type |model|model |prior|
  # +-----+-----+------+-----+
  # |gen  |JC   |strict|BD   |
  # +-----+-----+------+-----+
  # |cand | .. all others .. |
  # +-----+-----+------+-----+
  #
  gen_experiment <- pirouette::create_gen_experiment()
  gen_experiment$inference_model$tree_prior <- beautier::create_bd_tree_prior()
  cand_experiments <- pirouette::create_all_experiments(
    exclude_model = gen_experiment$inference_model
  )
  testit::assert(length(cand_experiments) >= 39)
  experiments <- c(list(gen_experiment), cand_experiments)
  testit::assert(length(experiments) == 1 + length(cand_experiments))

  # Set an MRCA prior in all experiments
  for (i in seq_along(experiments)) {
    experiments[[i]]$inference_model$mrca_prior <- beautier::create_mrca_prior(
      is_monophyletic = TRUE,
      mrca_distr = beautier::create_normal_distr(
        mean = crown_age,
        sigma = 0.0005
      )
    )
  }
  error_measure_params <- pirouette::create_error_measure_params()

  # Go through all rows of the biological parameters
  for (row_index in seq(1, nrow(bio_params))) {
    erg <- bio_params$erg[row_index]
    eri <- bio_params$eri[row_index]
    scr <- bio_params$scr[row_index]
    sirg <- bio_params$sirg[row_index]
    siri <- bio_params$siri[row_index]

    pbd_params <- becosys::create_pbd_params(
      sirg = sirg,
      siri = siri,
      scr = scr,
      erg = erg,
      eri = eri
    )

    # Let runs that converge slower run longer to achieve a high enough ESS
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
    for (i in seq(1, n_replicates)) {
      if (index >= max_n_params) next

      alignment_params$rng_seed <- index
      inference_params$rng_seed <- index
      inference_params$mcmc <- beautier::create_mcmc(
        chain_length = mcmc_chain_length * increase_factor,
        store_every = 1000 * increase_factor
      )
      params <- create_raket_params(
        pbd_params = pbd_params,
        pir_params = pirouette::create_pir_params(
          twinning_params = twinning_params,
          alignment_params = alignment_params,
          experiments = experiments,
          error_measure_params = error_measure_params
        ),
        sampling_method = "random"
      )
      params_set[[index]] <- params
      index <- index + 1
    }
  }
  params_set
}
