#' Get the two types of experiments, which
#' are 'general' (to produce a general data set),
#' and 'sampling' (to investigate the worst-case
#' effect of sampling)
#' @export
rkt_get_experiment_types <- function() {
  c("general", "sampling")
}
