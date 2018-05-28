#' Convert a data frame from short to long form
#' @param df a data frame
#' @export
to_long <- function(df = utils::read.csv("result.csv")) {
  start_col <- rkt_get_n_params() + 1
  tidyr::gather(df, "i", "nltt", start_col:ncol(df))
}
