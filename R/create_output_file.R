#' Process an input file
#' @param input_filename name of the input file,
#'   as created by \code{\link{create_input_files_general}}
#' @param posterior_filesname name of the output file
#' @param verbose shows output if TRUE
#' @author Richel J.C. Bilderbeek
#' @export
create_posterior_files <- function(
  input_filename = input_filename,
  posterior_filesname = posterior_filesname,
  verbose = FALSE
) {
  if (!file.exists(input_filename)) {
    stop("'input_filename' must exist. File '", input_filename, "' not found")
  }
  out <- raket::rkt_run(
    parameters = utils::read.csv(file = input_filename),
    verbose = verbose
  )
  saveRDS(object = out, file = posterior_filesname)
}
