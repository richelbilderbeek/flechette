#' Creates the parameter files in the article for the general exploration
#' @param mcmc MCMC options, as created by \link[beautier]{create_mcmc}
#' @param sequence_length DNA alignment sequence length,
#'   in number of nucleotides
#' @param n_replicates number of replicates per biological parameter set
#' @param folder_name name of the folder where all files are created
#' @return The filenames of all parameter files created
#' @export
#' @author Richel Bilderbeek
create_input_files_general <- function(
  general_params_set = create_general_params_set(),
  folder_name = getwd()
) {
  filenames <- NULL
  # Must start at one, as the BEAST2 RNG seed must be at least one.
  index <- 1
  n_files <- length(general_params_set)
  for (index in seq(1, n_files)) {
    filename <- file.path(folder_name, paste0(index, ".RDa"))
    params <- general_params_set[[index]]
    saveRDS(object = params, file = filename)
    index <- index + 1
    filenames <- c(filenames, filename)
  }
  filenames
}
