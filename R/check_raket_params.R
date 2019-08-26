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
    "sampling_method",
    "true_tree_filename",
    "pbd_sim_out_filename"
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
  check_sampling_method(raket_params$sampling_method) # nolint raket function
  assertive::assert_is_a_string(raket_params$true_tree_filename)
  assertive::assert_is_a_string(raket_params$pbd_sim_out_filename)

  if (!peregrine::is_pff(raket_params$true_tree_filename)) {
    stop(
      "'true_tree_filename' must be Peregrine-friendly. \n",
      "Actual value: ", raket_params$true_tree_filename
    )
  }
  if (!peregrine::is_pff(raket_params$pbd_sim_out_filename)) {
    stop(
      "'pbd_sim_out_filename' must be Peregrine-friendly. \n",
      "Actual value: ", raket_params$pbd_sim_out_filename
    )
  }

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

  # Filenames
  folder_name <- dirname(
    raket_params$pir_params$alignment_params$fasta_filename
  )
  # Sim
  if (raket_params$pbd_sim_out_filename != file.path(folder_name, "pbd_sim_out.RDa")) { # nolint indeed long
    stop(
      "'raket_params$pbd_sim_out_filename' must be be '[folder_name]/pbd_sim_out.RDa'. \n", # nolint indeed long
      "Actual value: '", raket_params$pbd_sim_out_filename, "'\n",
      "[folder_name]: '", folder_name, "'\n",
      "(folder name taken from raket_params$pir_params$alignment_params$fasta_filename)" # nolint indeed long
    )
  }
  # True tree
  if (raket_params$true_tree_filename != file.path(folder_name, "pbd.newick")) { # nolint indeed long
    stop(
      "'raket_params$true_tree_filename' must be be '[folder_name]/pbd.newick'. \n", # nolint indeed long
      "Actual value: '", raket_params$true_tree_filename, "'\n",
      "[folder_name]: '", folder_name, "'\n",
      "(folder name taken from raket_params$pir_params$alignment_params$fasta_filename)" # nolint indeed long
    )
  }
  # True alignment
  if (raket_params$pir_params$alignment_params$fasta_filename != file.path(folder_name, "pbd.fasta")) { # nolint indeed long
    stop(
      "'raket_params$pir_params$alignment_params$fasta_filename' must be be '[folder_name]/pbd.fasta'. \n", # nolint indeed long
      "Actual value: '", raket_params$pir_params$alignment_params$fasta_filename, "'\n", # nolint long line indeed
      "[folder_name]: '", folder_name, "'\n",
      "(folder name taken from raket_params$pir_params$alignment_params$fasta_filename)" # nolint indeed long
    )
  }

  # First experiment must be generative
  gen_experiment <- raket_params$pir_params$experiments[[1]]
  if (gen_experiment$inference_conditions$model_type != "generative") { # nolint indeed long
    stop(
      "'raket_params$pir_params$experiments[[1]]$inference_conditions$model_type' must be be 'generative'. \n", # nolint indeed long
      "Actual value: '", gen_experiment$inference_conditions$model_type, "'\n"
    )
  }

  # BEAST2 input filename
  if (raket_params$pir_params$experiments[[1]]$beast2_options$input_filename != file.path(folder_name, "pbd_gen.xml")) { # nolint indeed long
    stop(
      "'raket_params$pir_params$experiments[[1]]$beast2_options$input_filename' must be be '[folder_name]/pbd_gen.xml'. \n", # nolint indeed long
      "Actual value: '", raket_params$pir_params$experiments[[1]]$beast2_options$input_filename, "'\n", # nolint indeed long
      "[folder_name]: '", folder_name, "'\n",
      "(folder name taken from raket_params$pir_params$alignment_params$fasta_filename)" # nolint indeed long
    )
  }
  # BEAST2 output log filename
  if (raket_params$pir_params$experiments[[1]]$beast2_options$output_log_filename != file.path(folder_name, "pbd_gen.log")) { # nolint indeed long
    stop(
      "'raket_params$pir_params$experiments[[1]]$beast2_options$output_log_filename' must be be '[folder_name]/pbd_gen.log'. \n", # nolint indeed long
      "Actual value: '", raket_params$pir_params$experiments[[1]]$beast2_options$output_log_filename, "'\n", # nolint indeed long
      "[folder_name]: '", folder_name, "'\n",
      "(folder name taken from raket_params$pir_params$alignment_params$fasta_filename)" # nolint indeed long
    )
  }
  # BEAST2 output trees filenames
  if (raket_params$pir_params$experiments[[1]]$beast2_options$output_trees_filenames != file.path(folder_name, "pbd_gen.trees")) { # nolint indeed long
    stop(
      "'raket_params$pir_params$experiments[[1]]$beast2_options$output_trees_filenames' must be be '[folder_name]/pbd_gen.trees'. \n", # nolint indeed long
      "Actual value: '", raket_params$pir_params$experiments[[1]]$beast2_options$output_trees_filenames, "'\n", # nolint indeed long
      "[folder_name]: '", folder_name, "'\n",
      "(folder name taken from raket_params$pir_params$alignment_params$fasta_filename)" # nolint indeed long
    )
  }
  # BEAST2 output state filenames
  if (raket_params$pir_params$experiments[[1]]$beast2_options$output_state_filename != file.path(folder_name, "pbd_gen.xml.state")) { # nolint indeed long
    stop(
      "'raket_params$pir_params$experiments[[1]]$beast2_options$output_state_filename' must be be '[folder_name]/pbd_gen.xml.state'. \n", # nolint indeed long
      "Actual value: '", raket_params$pir_params$experiments[[1]]$beast2_options$output_state_filename, "'\n", # nolint indeed long
      "[folder_name]: '", folder_name, "'\n",
      "(folder name taken from raket_params$pir_params$alignment_params$fasta_filename)" # nolint indeed long
    )
  }
  # Lost inspiration for this grunt work ...
  cand_experiments <- raket_params$pir_params$experiments[-1]
  for (cand_experiment in cand_experiments) {
    testit::assert(
      cand_experiment$inference_conditions$model_type ==
      "candidate"
    )
    testit::assert(
      file.path(folder_name, "pbd_best.xml") ==
      cand_experiment$beast2_options$input_filename
    )
    testit::assert(
      file.path(folder_name, "pbd_best.log") ==
      cand_experiment$beast2_options$output_log_filename
    )
    testit::assert(
      file.path(folder_name, "pbd_best.trees") ==
      cand_experiment$beast2_options$output_trees_filenames
    )
    testit::assert(
      file.path(folder_name, "pbd_best.xml.state") ==
      cand_experiment$beast2_options$output_state_filename
    )
    testit::assert(
      file.path(folder_name, "pbd_nltts_best.csv") ==
      cand_experiment$errors_filename
    )
  }
  # Twinning
  testit::assert(
    file.path(folder_name, "pbd_twin.newick") ==
    raket_params$pir_params$twinning_params$twin_tree_filename
  )
  testit::assert(
    file.path(folder_name, "pbd_twin.fasta") ==
    raket_params$pir_params$twinning_params$twin_alignment_filename
  )
  testit::assert(
    file.path(folder_name, "pbd_marg_lik_twin.csv") ==
    raket_params$pir_params$twinning_params$twin_evidence_filename
  )
  testit::assert(
    file.path(folder_name, "pbd_marg_lik.csv") ==
    raket_params$pir_params$evidence_filename
  )
}
