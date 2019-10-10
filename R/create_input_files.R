#' Creates the parameter files from the \code{raket_params}
#' @inheritParams default_params_doc
#' @param folder_name name of the folder where all files are created
#' @return The filenames of all parameter files created
#' @seealso
#' Use \link{create_input_files_test} to create the parameters file
#' for a test input set.
#' Use \link{create_input_files_general} to create the parameters file
#' for a general input set.
#' Use \link{create_input_files_sampling} to create the parameters file
#' for a sampling input set.
#' @author Richel Bilderbeek
create_input_files <- function(
  raket_paramses
) {
  raket::check_raket_paramses(raket_paramses)

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
  create_input_files(raket_paramses) # nolint internal function
}

#' Creates the parameter files in the article for the general exploration
#' @param sampling_params_set the set of parameters,
#'   as created by \code{\link{create_sampling_params_set}}
#' @param folder_name name of the folder where all files are created
#' @return The filenames of all parameter files created
#' @export
#' @author Richel Bilderbeek
create_input_files_sampling <- function(
  raket_paramses = create_sampling_params_set(
    project_folder_name = getwd()
  )
) {
  create_input_files(raket_paramses) # nolint internal function
}

#' Creates the parameter files in the article for the general exploration
#' @param sampling_params_set the set of parameters,
#'   as created by \code{\link{create_sampling_params_set}}
#' @param folder_name name of the folder where all files are created
#' @return The filenames of all parameter files created
#' @export
#' @author Richel Bilderbeek
create_input_files_test <- function(
  raket_paramses = create_test_params_set(project_folder_name = getwd())
) {
  create_input_files(raket_paramses) # nolint internal function
}
