#' Creates the parameter set for the general exploration
#' @inheritParams default_params_doc
#' @return a list of which each element is a \code{raket_params}
#' @author Richel J.C. Bilderbeek
#' @export
create_general_params_set <- function(
  project_folder_name = file.path(peregrine::get_pff_tempdir(), "raket_werper"),
  n_replicates = 1
) {
  testit::assert(beautier::is_one_int(n_replicates))
  testit::assert(n_replicates >= 1)
  pbd_paramses <- create_general_pbd_paramses() # nolint raket function

  raket_paramses <- list()
  index <- 1
  for (pbd_params in pbd_paramses) {
    for (replicate in seq(1, n_replicates)) {
      folder_name <- file.path(project_folder_name, "data", index)
      raket_params <- create_test_raket_params(folder_name)
      raket_params$sampling_method <- "random"
      raket_params$pbd_params <- pbd_params
      raket_paramses[[index]] <- raket_params
      index <- index + 1
    }
  }
  testit::assert(length(raket_paramses) == length(pbd_paramses) * n_replicates)
  raket_paramses
}
