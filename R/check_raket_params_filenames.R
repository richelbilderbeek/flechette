#' Check is a \code{raket_params} hold Peregrine-friendly filenames
#' that follow the \code{raket} naming convention.
#' @noRd
check_raket_params_filenames <- function(raket_params) { # nolint indeed a long function name, which is fine for an internal function
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
  if (!peregrine::is_pff(
    raket_params$pir_params$experiments[[1]]$beast2_options$beast2_working_dir)
  ) {
    stop(
      "First experiments BEAST2 working directory must be Peregrine friendly"
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
    testit::assert(peregrine::is_pff(
      cand_experiment$beast2_options$beast2_working_dir)
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
