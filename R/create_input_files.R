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
  general_params_set = create_general_params_set(),
  project_folder_name = getwd()
) {
  check_project_folder_name(project_folder_name = project_folder_name) # nolint internal function
  create_input_files_impl( # nolint internal function
    raket_paramses = general_params_set,
    folder_name = project_folder_name
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
  test_params_set = create_test_params_set(),
  folder_name = getwd()
) {
  create_input_files_impl(
    raket_paramses = test_params_set,
    folder_name = folder_name
  )
}
#' Creates the parameter files in the article for the general exploration
#' @inheritParams default_params_doc
#' @param folder_name name of the folder where all files are created
#' @return The filenames of all parameter files created
#' @author Richel Bilderbeek
create_input_files_impl <- function(
  raket_paramses,
  folder_name
) {
  check_raket_paramses(raket_paramses) # nolint raket function

  dir.create(
    file.path(folder_name, "data"),
    recursive = TRUE,
    showWarnings = FALSE
  )

  filenames <- NULL
  # Must start at one, as the BEAST2 RNG seed must be at least one.
  n_files <- length(raket_paramses)
  for (index in seq(1, n_files)) {
    dir.create(
      file.path(folder_name, "data", index),
      recursive = TRUE,
      showWarnings = FALSE
    )
    filename <- file.path(folder_name, "data", index, "parameters.RDa")
    saveRDS(object = raket_paramses[[index]], file = filename)
    index <- index + 1
    filenames <- c(filenames, filename)
  }
  filenames
}
