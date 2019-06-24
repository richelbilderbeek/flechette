#' Get the full path of a file in the \code{inst/extdata} folder
#' @inheritParams default_params_doc
#' @return the full path of the filename, if and only if
#'   the file is present. Will stop otherwise.
#' @author Richel J.C. Bilderbeek
#' @examples
#'   testit::assert(is.character(get_raket_path("parameters.RDa")))
#' @export
get_raket_path <- function(filename) {
  full <- system.file("extdata", filename, package = "raket")
  if (!file.exists(full)) {
    stop("'filename' must be the name of a file in 'inst/extdata'")
  }
  full
}
