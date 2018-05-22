#' Creates the parameter files in the article for the general exploration
#' @param general_params_set the set of parameters,
#'   as created by \code{\link{create_general_params_set}}
#' @param folder_name name of the folder where all files are created
#' @return The filenames of all parameter files created
#' @export
#' @author Richel Bilderbeek
create_input_files_general <- function(
  general_params_set = create_general_params_set(),
  folder_name = getwd()
) {
  create_input_files_impl(
    params_set = general_params_set,
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
create_input_files_sampling <- function(
  sampling_params_set = create_sampling_params_set(),
  folder_name = getwd()
) {
  create_input_files_impl(
    params_set = sampling_params_set,
    folder_name = folder_name
  )
}

#' Creates the parameter files in the article for the general exploration
#' @param params_set the set of parameters,
#'   as created by \code{\link{create_general_params_set}}
#'   or \code{\link{create_sampling_params_set}}
#' @param folder_name name of the folder where all files are created
#' @return The filenames of all parameter files created
#' @author Richel Bilderbeek
create_input_files_impl <- function(
  params_set,
  folder_name
) {
  filenames <- NULL
  # Must start at one, as the BEAST2 RNG seed must be at least one.
  index <- 1
  n_files <- length(params_set)
  for (index in seq(1, n_files)) {
    filename <- file.path(folder_name, paste0(index, ".RDa"))
    params <- params_set[[index]]
    saveRDS(object = params, file = filename)
    index <- index + 1
    filenames <- c(filenames, filename)
  }
  filenames
}
