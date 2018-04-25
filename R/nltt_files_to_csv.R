#' Collect all nLTT values from \code{_nltts.RDa} files
#' @param nltt_filenames names of the \code{_nltts.RDa} files,
#'   as created by \code{create_nltt_file}
#' @param csv_filename name of the .csv file to be created
#' @export
#' @author Richel J.C. Bilderbeek
nltt_files_to_csv <- function(
  nltt_filenames,
  csv_filename
) {
  nrows <- length(nltt_filenames)
  if (nrows < 1) {
    stop("'nltt_filenames' must have at least one filename")
  }
  # First row
  first_filename <- nltt_filenames[1]
  testit::assert(file.exists(first_filename))
  first_file <- readRDS(first_filename)
  first_list <- c(first_file$parameters, first_file$nltts)
  first_vector <- unlist(first_list)
  ncols <- length(first_vector)
  df <- data.frame(matrix(nrow = nrows, ncol = ncols))
  colnames(df) <- names(first_vector)
  # Read data
  for (i in seq_along(nltt_filenames)) {
    filename <- nltt_filenames[i]
    testit::assert(file.exists(filename))
    file <- readRDS(filename)
    df[i, ] <- unlist(c(file$parameters, file$nltts))
  }
  # Save
  utils::write.csv(x = df, file = csv_filename, row.names = FALSE)
}