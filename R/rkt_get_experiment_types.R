#' Get the types of experiments.
#'
#' These are:
#' \enumeration{
#'   \item general to produce a general data set
#'   \item sampling to investigate the worst-case effect of sampling
#'   \item test to produce a testing data set
#' }
#' @export
rkt_get_experiment_types <- function() {
  c("general", "sampling", "test")
}
