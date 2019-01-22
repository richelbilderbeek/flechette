#' Create the parameters for one experiment.
#' Run one point of the experiment
#' @inheritParams default_params_doc
#' @author Richel J.C. Bilderbeek
#' @export
create_raket_params <- function(
  pbd_params,
  twinning_params = pirouette::create_twinning_params(),
  alignment_params,
  gen_model_select_params,
  best_model_select_params,
  inference_param,
  sampling_method
) {
  raket_params <- list(
    pbd_params = pbd_params,
    twinning_params = twinning_params,
    alignment_params = alignment_params,
    gen_model_select_params = gen_model_select_params,
    best_model_select_params = best_model_select_params,
    inference_param = inference_param,
    sampling_method = sampling_method
  )
  check_raket_params(raket_params)
  raket_params
}
