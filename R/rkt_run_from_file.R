#' Run a 'raket' experiment from a filename
#' @inheritParams default_params_doc
#' @param parameters_filename name of a file that contains
#'   a \code{raket_params},
#'   as can be created by \link{create_raket_params}
#' @return nothing
#' @author Richel J.C. Bilderbeek
#' @export
rkt_run_from_file <- function(
  parameters_filename
) {
  if (!file.exists(parameters_filename)) {
    stop(
      "'parameters_filename' cannot be found. Value: ",
      parameters_filename
    )
  }
  raket_params <- readRDS(parameters_filename)
  raket::check_raket_params(raket_params)
  run_raket(
    raket_params = raket_params
  )
}
