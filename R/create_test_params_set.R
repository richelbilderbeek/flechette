#' Create the parameter set used in testing
#' @return a list of which each element is a \code{raket_params}
#' @author Richel J.C. Bilderbeek
#' @export
create_test_params_set <- function() {

  pbd_paramses <- create_test_pbd_paramses()

  # pir_params
  gen_experiment <- pirouette::create_gen_experiment()
  cand_experiments <- pirouette::create_all_experiments(
    exclude_model = gen_experiment$inference_model
  )
  first_cand_beast2_options <- cand_experiments[[1]]$beast2_options
  for (index in seq_along(cand_experiments)) {
    cand_experiments[[index]]$beast2_options <- first_cand_beast2_options
  }
  experiments <- c(list(gen_experiment), cand_experiments)
  for (index in seq_along(experiments)) {
    experiments[[index]]$inference_model$mcmc <- beautier::create_mcmc(
      chain_length = 3000, store_every = 1000
    )
  }
  for (i in seq_along(experiments)) {
    experiments[[i]]$inference_model$mrca_prior <- beautier::create_mrca_prior(
      is_monophyletic = TRUE,
      mrca_distr = beautier::create_normal_distr(
        mean = 15,
        sigma = 0.0005
      )
    )
  }
  pir_params <- pirouette::create_pir_params(
    alignment_params = pirouette::create_test_alignment_params(),
    twinning_params = pirouette::create_twinning_params(),
    experiments = experiments
  )
  pir_params <- peregrine::to_pff_pir_params(pir_params)


  raket_paramses <- list()
  for (index in seq_along(pbd_paramses)) {
    pbd_params <- pbd_paramses[[index]]
    raket_params <- create_raket_params(
      pbd_params = pbd_params,
      pir_params = pir_params,
      sampling_method = "random"
    )

    raket_paramses[[index]] <- raket_params

  }

  testit::assert(length(raket_paramses) == length(pbd_paramses))
  raket_paramses
}
