#' Check if the \code{raket_params} are valid raket parameters.
#'
#' Will \link{stop} if the \code{raket_params} are invalid,
#' else will do nothing
#' @inheritParams default_params_doc
#' @author Richel J.C. Bilderbeek
#' @export
check_raket_params <- function(
  raket_params
) {
  argument_names <- c(
    "pbd_params", "twinning_params", "alignment_params",
    "gen_model_select_params", "best_model_select_params",
    "inference_params",
    "sampling_method"
  )
  for (arg_name in argument_names) {
    if (!arg_name %in% names(raket_params)) {
      stop(
        "'", arg_name, "' must be an element of a 'raket_params'"
      )
    }
  }

  becosys::check_pbd_params(raket_params$pbd_params)
  pirouette:::check_twinning_params(raket_params$twinning_params) # nolint internal pirouette function, will be exported in pirouette v1.1
  pirouette:::check_alignment_params(raket_params$alignment_params) # nolint internal pirouette function, will be exported in pirouette v1.1
  pirouette:::check_model_select_params(raket_params$gen_model_select_params) # nolint internal pirouette function, will be exported in pirouette v1.1
  pirouette:::check_model_select_params(raket_params$best_model_select_params) # nolint internal pirouette function, will be exported in pirouette v1.1
  pirouette:::check_inference_params(raket_params$inference_params) # nolint internal pirouette function, will be exported in pirouette v1.1
  testit::assert(
    raket_params$sampling_method %in% raket::rkt_get_sampling_methods()
  )
}
