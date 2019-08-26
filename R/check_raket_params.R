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
  # Check if the list elements are all present
  check_raket_params_list_elements(raket_params) # nolint raket function

  becosys::check_pbd_params(raket_params$pbd_params)
  pirouette::check_pir_params(raket_params$pir_params)
  peregrine::check_pff_pir_params(raket_params$pir_params)
  check_sampling_method(raket_params$sampling_method) # nolint raket function
  assertive::assert_is_a_string(raket_params$true_tree_filename)
  assertive::assert_is_a_string(raket_params$pbd_sim_out_filename)

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
        "Must use an MRCA prior with a distribution ",
        "that has a mean with a value"
      )
    }
    if (length(mrca_prior$mrca_distr$mean$value) == 0) {
      stop(
        "Must use an MRCA prior with a distribution ",
        "that has a mean with a value"
      )
    }
    if (mrca_prior$mrca_distr$mean$value <= 0.0) {
      stop(
        "Must use an MRCA prior with a distribution that has a mean ",
        "with a non-zero and positive value"
      )
    }
  }
  # First experiment must be generative
  gen_experiment <- raket_params$pir_params$experiments[[1]]
  if (gen_experiment$inference_conditions$model_type != "generative") { # nolint indeed long
    stop(
      "'raket_params$pir_params$experiments[[1]]$inference_conditions$model_type' must be be 'generative'. \n", # nolint indeed long
      "Actual value: '", gen_experiment$inference_conditions$model_type, "'\n"
    )
  }

  # Filenames
  check_raket_params_filenames(raket_params) # nolint raket function
}
