#' For each input file, calculate the median nLTT statistic.
#' Put these, with the parameters in a data frame
#' @param folder_name name of the folder that contains data files,
#'   as created by \code{\link{create_output_file}}
#' @param output_filename name of a comma-seperated file
#'   containing parameters and median nLTTs
#' @author Richel J.C. Bilderbeek
#' @export
calc_median_nltts <- function(
  folder_name,
  output_filename
) {
  input_filenames <- list.files(folder_name, full.names = TRUE)

  # Set up table
  input_filename <- input_filenames[1]
  data <- readRDS(input_filename)
  df <- data.frame(
    matrix(
      NA,
      nrow = length(input_filenames),
      ncol = length(data$parameters) + 1
    )
  )
  colnames(df) <- c(names(data$parameters), "median_nltt")

  # Fill the table
  for (i in seq_along(input_filenames)) {
    data <- readRDS(input_filenames[i])
    df[i, 1:length(data$parameters)] <- data$parameters
    df[i, length(data$parameters) + 1] <- median(
      nLTT::nltts_diff(data$species_tree, data$trees)
    )
  }

  utils::write.csv(x = df, file = output_filename)
}
