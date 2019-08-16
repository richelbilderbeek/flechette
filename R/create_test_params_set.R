#' Create the parameter set used in testing
#' @return a list of which each element is a \code{raket_params}
#' @author Richel J.C. Bilderbeek
#' @export
create_test_params_set <- function() {

  pbd_paramses <- create_test_pbd_paramses() # nolint raket function

  raket_paramses <- list()
  for (index in seq_along(pbd_paramses)) {
    raket_params <- create_test_raket_params()
    raket_params$sampling_method <- "random"
    raket_params$pbd_params <- pbd_paramses[[index]]
    raket_paramses[[index]] <- raket_params
  }
  testit::assert(length(raket_paramses) == length(pbd_paramses))
  raket_paramses
}
