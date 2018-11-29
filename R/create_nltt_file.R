#' Measure the nLTT statistics from a BEAST2 run
#' @param input_filename input filename,
#'    containing the BEAST2 run results,
#'    as created by create_posterior_files
#' @param posterior_filesname output filename,
#'    containing the nLTT values
#' @param burn_in_fraction the proportion of values being removed,
#'   see \link[tracerer]{remove_burn_in}
#' @export
create_nltt_file <- function(
  input_filename,
  posterior_filesname,
  burn_in_fraction = 0.1
) {
  if (!file.exists(input_filename)) {
    stop("'input_filename' must be the name of an existing file")
  }
  input <- readRDS(input_filename)
  output <- list(
    parameters = input$parameters,
    nltts = tracerer::remove_burn_in(
      nLTT::nltts_diff(tree = input$species_tree, trees = input$trees),
      burn_in_fraction = burn_in_fraction
    )
  )
  saveRDS(object = output, file = posterior_filesname)
}
