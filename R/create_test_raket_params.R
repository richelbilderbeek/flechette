#' Create a test \code{raket_params}
#'
#' @return a test \code{raket_params},
#'   as can be created by \link{create_raket_params}
#' @export
#' @author Richel J.C. Bilderbeek
create_test_raket_params <- function() {
  crown_age <- 15.0
  crown_age_sigma <- 0.01
  pbd_params <- create_test_pbd_params()
  twinning_params = peregrine::create_pff_twinning_params()
  alignment_params = peregrine::create_pff_alignment_params(
    root_sequence = pirouette::create_blocked_dna(length = 32),
    mutation_rate = 0.12
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
  gen_experiment <- peregrine::create_test_pff_gen_experiment()
  peregrine::check_pff_experiment(gen_experiment)
  cand_experiments <- peregrine::create_all_pff_experiments(
    exclude_model = gen_experiment$inference_model
  )[1:2]
  peregrine::check_pff_experiments(cand_experiments)
  testit::assert(length(cand_experiments) >= 1)
  experiments <- c(list(gen_experiment), cand_experiments)
  testit::assert(length(experiments) == 1 + length(cand_experiments))
  peregrine::check_pff_experiments(experiments)

  # Set an MRCA prior in all experiments
  for (i in seq_along(experiments)) {
    experiments[[i]]$inference_model$mrca_prior <- beautier::create_mrca_prior(
      is_monophyletic = TRUE,
      mrca_distr = beautier::create_normal_distr(
        mean = crown_age,
        sigma = crown_age_sigma
      )
    )
  }
  # Set a short MCMC in all experiments
  for (i in seq_along(experiments)) {
    experiments[[i]]$inference_model$mcmc <- beautier::create_mcmc(
      chain_length = 2000, store_every = 1000
    )
  }

  error_measure_params <- pirouette::create_error_measure_params()
  sampling_method <- "shortest"

  raket_params <- create_raket_params(
    pbd_params = pbd_params,
    pir_params = pirouette::create_pir_params(
      twinning_params = twinning_params,
      alignment_params = alignment_params,
      experiments = experiments,
      error_measure_params = error_measure_params,
      evidence_filename = peregrine::get_pff_tempfile(
        pattern = "evidence_", fileext = ".csv"
      )
    ),
    sampling_method = sampling_method
  )

  check_raket_params(raket_params)
  raket_params
}
