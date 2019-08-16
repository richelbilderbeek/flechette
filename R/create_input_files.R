#' Creates the parameter files in the article for the general exploration
#' @param general_params_set the set of parameters,
#'   as created by \code{\link{create_general_params_set}}
#' @param project_folder_name name of the project folder.
#'   The name of this folder must be \code{raket_werper}.
#' @return The filenames of all parameter files created
#' @export create_input_files_general create_files_raket_paramses
#' @aliases create_input_files_general create_files_raket_paramses
#' @author Richel Bilderbeek
create_input_files_general <- create_files_raket_paramses <- function(
  raket_paramses = create_general_params_set()
) {
  create_input_files_impl( # nolint internal function
    raket_paramses = raket_paramses
  )
}

#' Creates the parameter files in the article for the general exploration
#' @param sampling_params_set the set of parameters,
#'   as created by \code{\link{create_sampling_params_set}}
#' @param folder_name name of the folder where all files are created
#' @return The filenames of all parameter files created
#' @export
#' @author Richel Bilderbeek
create_input_files_sampling <- function(
  sampling_params_set = create_sampling_params_set(),
  folder_name = getwd()
) {
  create_input_files_impl(
    raket_paramses = sampling_params_set,
    folder_name = folder_name
  )
}

#' Creates the parameter files in the article for the general exploration
#' @param sampling_params_set the set of parameters,
#'   as created by \code{\link{create_sampling_params_set}}
#' @param folder_name name of the folder where all files are created
#' @return The filenames of all parameter files created
#' @export
#' @author Richel Bilderbeek
create_input_files_test <- function(
  raket_paramses = create_test_params_set()
) {
  create_input_files_impl(raket_paramses)
}
#' Creates the parameter files in the article for the general exploration
#' @inheritParams default_params_doc
#' @param folder_name name of the folder where all files are created
#' @return The filenames of all parameter files created
#' @author Richel Bilderbeek
create_input_files_impl <- function(
  raket_paramses
) {
  check_raket_paramses(raket_paramses) # nolint raket function

  n_files <- length(raket_paramses)
  filenames <- rep(NA, n_files)
  for (index in seq(1, n_files)) {
    folder_name <- dirname(raket_paramses[[index]]$true_tree_filename)
    dir.create(file.path(folder_name), recursive = TRUE, showWarnings = FALSE)
    filename <- file.path(folder_name, "parameters.RDa")
    saveRDS(object = raket_paramses[[index]], file = filename)
    filenames[index] <- filename
    index <- index + 1
  }
  filenames
}
