#' Get the number of columns each dataset must maximally have.
#' Together with \code{\link{rkt_get_max_n_rows}}, the size
#' of a data frame is determined. A data frame of such size is
#' tested to fit in memory twice.
#' @export
rkt_get_max_n_cols <- function() {
  1050
}
