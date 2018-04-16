#' Process an input file
#' @param input_filename name of the input file,
#'   as created by \code{\link{create_input_files}}
#' @param output_filename name of the output file
#' @author Richel J.C. Bilderbeek
#' @export
create_output_file <- function(
  input_filename = input_filename,
  output_filename = output_filename
) {
  if (!file.exists(input_filename)) {
    stop("'input_filename' must exist. File '", input_filename, "' not found")
  }
  out <- raket::run(parameters = readRDS(file = input_filename))
  saveRDS(object = out, file = output_filename)
}
