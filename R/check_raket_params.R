#' Check if the \code{raket_params} are valid raket parameters.
#'
#' Will \link{stop} if the \code{raket_params} are invalid,
#' else will do nothing
#' @inheritParams default_params_doc
#' @author Richel J.C. Bilderbeek
#' @export
check_raket_params <- function(
  raket_params
) {
  argument_names <- c(
    "pbd_params",
    "pir_params",
    "sampling_method"
  )
  for (arg_name in argument_names) {
    if (!arg_name %in% names(raket_params)) {
      stop(
        "'", arg_name, "' must be an element of a 'raket_params'"
      )
    }
  }

  becosys::check_pbd_params(raket_params$pbd_params)
  pirouette::check_pir_params(raket_params$pir_params)
  peregrine::check_pff_pir_params(raket_params$pir_params)
  check_sampling_method(raket_params$sampling_method)

  if (!beautier::has_mrca_prior(
      raket_params$pir_params$experiments[[1]]$inference_model
    )
  ) {
    "An inference model must have a valid MRCA prior"
  }
  pir_params <- raket_params$pir_params
  if (beautier::is_one_na(pir_params$twinning_params)) {
    stop("'twinning_params' must have a valid non-NA value")
  }

  first_experiment <- pir_params$experiments[[1]]
  first_mrca_prior <- first_experiment$inference_model$mrca_prior
  if (beautier::is_one_na(first_mrca_prior)) {
    stop("An inference model must have a valid MRCA prior that is not NA")
  }
  for (experiment in raket_params$pir_params$experiments) {
    mrca_prior <- experiment$inference_model$mrca_prior
    if (beautier::is_one_na(mrca_prior)) {
      stop("Must use an MRCA prior")
    }
    if (beautier::is_one_na(mrca_prior$mrca_distr)) {
      stop("Must use an MRCA prior with a distribution")
    }
    if (beautier::is_one_na(mrca_prior$mrca_distr$mean)) {
      stop("Must use an MRCA prior with a distribution that has a mean")
    }
    if (beautier::is_one_na(mrca_prior$mrca_distr$mean$value)) {
      stop(
        "Must use an MRCA prior with a distribution that has a mean with a value"
      )
    }
    if (length(mrca_prior$mrca_distr$mean$value) == 0) {
      stop(
        "Must use an MRCA prior with a distribution that has a mean with a value"
      )
    }
    if (mrca_prior$mrca_distr$mean$value <= 0.0) {
      stop(
        "Must use an MRCA prior with a distribution that has a mean ",
        "with a non-zero and positive value"
      )
    }
  }
}
