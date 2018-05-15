#' Get the number of rows each dataset must maximally have.
#' Together with \code{\link{rkt_get_max_n_cols}}, the size
#' of a data frame is determined. A data frame of such size is
#' tested to fit in memory twice.
#' @export
rkt_get_max_n_rows <- function() {
  20000
}
