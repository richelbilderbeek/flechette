#' Convert a data frame from short to long form
#' @param df a data frame
#' @export
to_long <- function(df = read.csv("results.csv")) {
  tidyr::gather(df, "i", "nltt", 16:ncol(df))
}
