#' Check if the argument is a list of \code{raket_params}
#' @inheritParams default_params_doc
#' @author Richel J.C. Bilderbeek
#' @export
check_raket_paramses <- function(raket_paramses) {
  if (!is.list(raket_paramses)) {
    stop(
      "'raket_paramses' must be a list. \n",
      "Actual class type: ", class(raket_paramses), " \n",
      "Actual value: ", raket_paramses
    )
  }
  for (i in seq_along(raket_paramses)) {
    tryCatch(
      check_raket_params(raket_paramses[[i]]),
      error = function(e) {
        stop(
          "'raket_paramses' must be a list of 'raket_params'. \n",
          "Actual value of raket_paramses[[", i, "]]: ", raket_paramses[[i]]
        )
      }

    )
  }
}
