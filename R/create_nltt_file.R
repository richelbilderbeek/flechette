#' Measure the nLTT statistics from a BEAST2 run
#' @param input_filename input filename, 
#'    containing the BEAST2 run results, 
#'    as created by create_output_file
#' @param outpjut_filename output filename, 
#'    containing the nLTT values
#' @export
create_nltt_file <- function(
  input_filename,
  output_filename
) {
  if (!file.exists(input_filename)) {
    stop("'input_filename' must be the name of an existing file")
  }
  input <- readRDS(input_filename)
  output <- list(
    parameters = input$parameters,
    nltts = nLTT::nltts_diff(tree = data$species_tree, trees = data$trees)
  )
  saveRDS(object = output, file = output_filename)
}