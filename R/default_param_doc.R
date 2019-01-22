#' This function does nothing. It is intended to inherit is parameters'
#' documentation.
#' @param alignment_params parameters for creating an alignment,
#'   as can be created by \code{\link[pirouette]{create_alignment_params}}
#' @param best_model_select_params a parameter set to specify to
#'   pick the inference model with the highest evidene (also:
#'   marginal likelihood),
#'   as can be created by
#'   \code{\link[pirouette]{create_best_model_select_param}}
#' @param crown_age the crown age of the phylogeny
#' @param erg extinction rate of a good species
#' @param eri extinction rate of an incipient species
#' @param experiment_type type of experiment,
#'   must a member of \code{\link{rkt_get_experiment_types}}
#' @param gen_model_select_params a generative model selection parameter,
#'   which will select the generative model to be run in
#'   the Bayesian inference.
#'   Use \link[pirouette]{create_gen_model_select_param} to create
#'   this parameter set
#' @param inference_param the parameters used in all Bayesian inference,
#'   as created by \link[pirouette]{create_inference_param}
#' @param max_n_params the maximum number of parameters created. Set to a lower
#'   value in debugging
#' @param mcmc one mcmc object,
#'   as returned by \code{\link[beautier]{create_mcmc}}
#' @param mcmc_chain_length length of the MCMC chain, in
#'   number of states
#' @param n_replicates number of replicates per biological parameter set
#' @param pbd_params a PBD parameter set,
#'   as returned by \code{\link[becosys]{create_pbd_params}}
#' @param quantile the quantile, a value from, and including, zero to one
#' @param raket_params \code{raket} parameters for one experiment,
#'   as can be created by \code{\link{create_raket_params}}
#' @param sampling_method method how the incipient species representing a
#'   species is picked. Must be in \link{rkt_get_sampling_methods}.
#' @param scr speciation completion rate
#' @param sequence_length a DNA sequence length, in base pairs
#' @param sir speciation initiation rate of both
#'   a good species and an incipient species
#' @param sirg speciation initiation rate of a good species
#' @param siri speciation initiation rate of an incipient species
#' @param stem_age stem age. Set either the stem age or the crown age.
#' @param twinning_params parameters for creating a twin tree,
#'   as can be created by \code{\link[pirouette]{create_twinning_params}}
#' @param verbose if TRUE, additional information is displayed, that
#'   is potentially useful in debugging
#' @author Richel J.C. Bilderbeek
#' @note This is an internal function, so it should be marked with
#'   \code{@noRd}. This is not done, as this will disallow all
#'   functions to find the documentation parameters
default_params_doc <- function(
  alignment_params,
  best_model_select_params,
  crown_age,
  erg,
  eri,
  experiment_type,
  gen_model_select_params,
  inference_param,
  max_n_params,
  mcmc,
  mcmc_chain_length,
  n_replicates,
  pbd_params,
  quantile,
  raket_params,
  sampling_method,
  scr,
  sequence_length,
  sir,
  sirg,
  siri,
  stem_age,
  twinning_params,
  verbose
) {
  # Nothing
}
