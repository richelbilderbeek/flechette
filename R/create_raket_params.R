#' Create the parameters for one experiment.
#' Run one point of the experiment
#' @inheritParams default_params_doc
#' @author Richel J.C. Bilderbeek
#' @export
create_raket_params <- function(
  pbd_params,
  pir_params,
  sampling_method
) {
  becosys::check_pbd_params(pbd_params)
  pirouette::check_pir_params(pir_params)
  check_sampling_method(sampling_method)

  raket_params <- list(
    pbd_params = pbd_params,
    pir_params = pir_params,
    sampling_method = sampling_method
  )
  check_raket_params(raket_params) # nolint raket function
  raket_params
}
