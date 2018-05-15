#' Get the number of replicates per parameter combination.
#' This number is limited by multiple factors
#' @export
rkt_get_n_replicates <- function() {
  # 138 will use more than 3 Gb on Travis
  # 100 will crash BEAST2 on Travis
  # 50 is a nice number and being tested
  50
}
