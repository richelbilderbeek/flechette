#' This function does nothing. It is intended to inherit is parameters'
#' documentation.
#' @param crown_age the crown age of the phylogeny
#' @param experiment_type type of experiment,
#'   must a member of \code{\link{rkt_get_experiment_types}}
#' @param max_n_params the maximum number of parameters created. Set to a lower
#'   value in debugging
#' @param mcmc one mcmc object,
#'   as returned by \code{\link[beautier]{create_mcmc}}
#' @param n_replicates number of replicates per biological parameter set
#' @param sequence_length a DNA sequence length, in base pairs
#' @param verbose if TRUE, additional information is displayed, that
#'   is potentially useful in debugging
#' @author Richel J.C. Bilderbeek
#' @note This is an internal function, so it should be marked with
#'   \code{@noRd}. This is not done, as this will disallow all
#'   functions to find the documentation parameters
default_params_doc <- function(
  crown_age,
  experiment_type,
  max_n_params,
  mcmc,
  n_replicates,
  sequence_length,
  verbose
) {
  # Nothing
}
