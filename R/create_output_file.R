#' Process an input file
#' @author Richel J.C. Bilderbeek
#' @export
create_output_file <- function(
  input_filename = input_filename,
  output_filename = output_filename
) {
  out <- run(parameters = readRDS(file = input_filename))
  saveRDS(object = out, file = output_filename)
}
