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
    "pbd_params", "twinning_params", "alignment_params"
  )
  for (arg_name in argument_names) {
    if (!arg_name %in% names(raket_params)) {
      stop(
        "'", arg_name, "' must be an element of a 'raket_params'"
      )
    }
  }

  becosys::check_pbd_params(raket_params$pbd_params)
  pirouette:::check_twinning_params(raket_params$twinning_params)
  pirouette:::check_alignment_params(raket_params$alignment_params) # nolint internal pirouette function, will be exported in pirouette v1.1
  testit::assert(raket_params$crown_age > 0.0)
  testit::assert(raket_params$crown_age_sigma > 0.0)
  testit::assert(
    raket_params$sampling_method %in% raket::rkt_get_sampling_methods()
  )
  testit::assert(raket_params$site_model %in% raket::rkt_get_site_models())
  testit::assert(raket_params$clock_model %in% raket::rkt_get_clock_models())
}
