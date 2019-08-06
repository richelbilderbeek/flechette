#' Get the types of experiments.
#'
#' These are:
#' \enumeration{
#'   \item general to produce a general data set
#'   \item sampling to produce a general data set
#'   \item test to produce a general data set
#' }
#' are ,
#' and 'sampling' (to investigate the worst-case
#' effect of sampling)
#' @export
rkt_get_experiment_types <- function() {
  c("general", "sampling", "test")
}
