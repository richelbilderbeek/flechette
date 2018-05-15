#' Get the number of replicates per parameter combination.
#' This number is limited by multiple factors
#' @export
rkt_get_n_replicates <- function() {
  # 138 will use more than 3 Gb on Travis
  50
}
