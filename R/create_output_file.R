#' Process an input file
#' @param input_filename name of the input file,
#'   as created by \code{\link{create_input_files_general}}
#' @param output_filename name of the output file
#' @param verbose shows output if TRUE
#' @author Richel J.C. Bilderbeek
#' @export
create_output_file <- function(
  input_filename = input_filename,
  output_filename = output_filename,
  verbose = FALSE
) {
  if (!file.exists(input_filename)) {
    stop("'input_filename' must exist. File '", input_filename, "' not found")
  }
  out <- raket::rkt_run(
    parameters = readRDS(file = input_filename),
    verbose = verbose
  )
  saveRDS(object = out, file = output_filename)
}
