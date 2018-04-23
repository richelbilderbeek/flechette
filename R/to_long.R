#' Convert a data frame from short to long form
#' @param df a data frame
#' @export
to_long <- function(df) {
  tidyr::gather(df, "i", "nltt", 14:ncol(df))
}