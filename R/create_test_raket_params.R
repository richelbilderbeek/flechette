#' Create a test \code{raket_params}
#'
#' @return a test \code{raket_params},
#'   as can be created by \link{create_raket_params}
#' @export
#' @author Richel J.C. Bilderbeek
create_test_raket_params <- function() {
  crown_age <- 15
  crown_age_sigma <- 0.01
  pbd_params <- becosys::create_pbd_params(
    sirg = 0.1,
    siri = 0.15,
    scr = 0.2,
    erg = 0.01,
    eri = 0.02
  )
  alignment_params <- pirouette::create_alignment_params(
    root_sequence = pirouette::create_blocked_dna(length = 32),
    mutation_rate = 0.12
  )
  gen_model_select_params <- list(
    pirouette::create_gen_model_select_param(
      alignment_params = alignment_params
    )
  )
  pirouette:::check_model_select_params(gen_model_select_params)

  best_model_select_params <- list(pirouette::create_best_model_select_param())
  pirouette:::check_model_select_params(best_model_select_params)

  inference_params <- pirouette::create_inference_params(
    mrca_prior = beautier::create_mrca_prior(
      alignment_id = "to be added by pir_run",
      taxa_names = c("to", "be", "added", "by", "pir_run"),
      is_monophyletic = TRUE,
      mrca_distr = beautier::create_normal_distr(
        mean = crown_age,
        sigma = crown_age_sigma
      )
    ),
    mcmc = beautier::create_mcmc(chain_length = 12300)
  )

  sampling_method <- "shortest"

  create_raket_params(
    pbd_params = pbd_params,
    alignment_params = alignment_params,
    gen_model_select_params = gen_model_select_params,
    best_model_select_params = best_model_select_params,
    inference_params = inference_params,
    sampling_method = sampling_method
  )
}
