#' Convert a data frame from short to long form
#' @param df a data frame
#' @export
to_long <- function(df = utils::read.csv("result.csv")) {
  first_nltt_col_index <- raket::rkt_get_n_params() + 1
  tidyr::gather(df, "i", "nltt", first_nltt_col_index:ncol(df))
}
