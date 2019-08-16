test_that("use", {

  good_raket_params <- create_test_raket_params()
  expect_silent(check_raket_params(good_raket_params))

  # Check elements
  raket_params <- good_raket_params
  raket_params$pbd_params <- NULL
  expect_error(
    check_raket_params(raket_params),
    "'pbd_params' must be an element of a 'raket_params'"
  )

  raket_params <- good_raket_params
  raket_params$pir_params <- NULL
  expect_error(
    check_raket_params(raket_params),
    "'pir_params' must be an element of a 'raket_params'"
  )

  raket_params <- good_raket_params
  raket_params$sampling_method <- NULL
  expect_error(
    check_raket_params(raket_params),
    "'sampling_method' must be an element of a 'raket_params'"
  )

  raket_params <- good_raket_params
  raket_params$true_tree_filename <- NULL
  expect_error(
    check_raket_params(raket_params),
    "'true_tree_filename' must be an element of a 'raket_params'"
  )

  raket_params <- good_raket_params
  raket_params$pbd_sim_out_filename <- NULL
  expect_error(
    check_raket_params(raket_params),
    "'pbd_sim_out_filename' must be an element of a 'raket_params'"
  )


  # Check pbd_params
  # done by check_pbd_params

  # Check pir_params
  # Done by pirouette::check_pir_params and peregrine::check_pff_pir_params

  ##############################################################################
  # Filenames
  ##############################################################################
  good_raket_params <- create_test_raket_params()
  # PBD sim
  raket_params <- good_raket_params
  raket_params$pbd_sim_out_filename <- "nonsense"
  expect_error(
    check_raket_params(raket_params),
    "'raket_params\\$pbd_sim_out_filename' must be be '\\[folder_name\\]/pbd_sim_out.RDa'" # nolint indeed long
  )

  # True tree
  raket_params <- good_raket_params
  raket_params$true_tree_filename <- "nonsense"
  expect_error(
    check_raket_params(raket_params),
    "'raket_params\\$true_tree_filename' must be be '\\[folder_name\\]/pbd.newick'" # nolint indeed long
  )

  # True alignment
  # One may expect the error:
  #   "'raket_params\\$pir_params\\$alignment_params\\$fasta_filename' must be be '\\[folder_name\\]/pbd.fasta'" # nolint indeed long
  # but this is false, as the folder of the alignment is used to generate
  # all other errors
  raket_params <- good_raket_params
  raket_params$pir_params$alignment_params$fasta_filename <- "nonsense"
  expect_error(
    check_raket_params(raket_params),
    "'raket_params\\$pbd_sim_out_filename' must be be '\\[folder_name\\]/pbd_sim_out.RDa'" # nolint indeed long
  )
  # First experiment must be generative
  # (yes, to test this is hard to set up)
  raket_params <- good_raket_params
  raket_params$pir_params$experiments[[1]]$inference_conditions$model_type <- "candidate"
  raket_params$pir_params$experiments[[1]]$inference_conditions$run_if <- "best_candidate"
  raket_params$pir_params$experiments[[1]]$inference_conditions$do_measure_evidence <- TRUE
  raket_params$pir_params$experiments[[1]]$errors_filename <- raket_params$pir_params$experiments[[2]]$errors_filename
  raket_params$pir_params$experiments[[1]]$beast2_options <- raket_params$pir_params$experiments[[2]]$beast2_options
  expect_error(
    check_raket_params(raket_params),
    "raket_params\\$pir_params\\$experiments\\[\\[1\\]\\]\\$inference_conditions\\$model_type' must be be 'generative'" # nolint indeed long
  )
  # BEAST2 input filename
  raket_params <- good_raket_params
  raket_params$pir_params$experiments[[1]]$beast2_options$input_filename <- "nonsense"
  expect_error(
    check_raket_params(raket_params),
    "'raket_params\\$pir_params\\$experiments\\[\\[1\\]\\]\\$beast2_options\\$input_filename' must be be '\\[folder_name\\]/pbd_gen.xml'" # nolint indeed long
  )
  # BEAST2 output log filename
  raket_params <- good_raket_params
  raket_params$pir_params$experiments[[1]]$beast2_options$output_log_filename <- "nonsense"
  expect_error(
    check_raket_params(raket_params),
    "'raket_params\\$pir_params\\$experiments\\[\\[1\\]\\]\\$beast2_options\\$output_log_filename' must be be '\\[folder_name\\]/pbd_gen.log'" # nolint indeed long
  )
  # BEAST2 output trees filename
  raket_params <- good_raket_params
  raket_params$pir_params$experiments[[1]]$beast2_options$output_trees_filenames <- "nonsense"
  expect_error(
    check_raket_params(raket_params),
    "'raket_params\\$pir_params\\$experiments\\[\\[1\\]\\]\\$beast2_options\\$output_trees_filenames' must be be '\\[folder_name\\]/pbd_gen.trees'" # nolint indeed long
  )
  # BEAST2 output trees filename
  raket_params <- good_raket_params
  raket_params$pir_params$experiments[[1]]$beast2_options$output_state_filename <- "nonsense"
  expect_error(
    check_raket_params(raket_params),
    "'raket_params\\$pir_params\\$experiments\\[\\[1\\]\\]\\$beast2_options\\$output_state_filename' must be be '\\[folder_name\\]/pbd_gen.xml.state'" # nolint indeed long
  )
  for (i in seq(2, 3)) {
    # First experiment must be candidate
    # (yes, to test this is hard to set up)
    raket_params <- good_raket_params
    raket_params$pir_params$experiments[[i]]$inference_conditions$model_type <- "generative"
    raket_params$pir_params$experiments[[i]]$inference_conditions$run_if <- "always"
    raket_params$pir_params$experiments[[i]]$inference_conditions$do_measure_evidence <- FALSE
    raket_params$pir_params$experiments[[i]]$errors_filename <- raket_params$pir_params$experiments[[2]]$errors_filename
    raket_params$pir_params$experiments[[i]]$beast2_options <- raket_params$pir_params$experiments[[2]]$beast2_options
    expect_error(
      check_raket_params(raket_params),
      "Specifying more than one 'generative' model experiment is redundant"
    )
    # BEAST2 input file
    raket_params <- good_raket_params
    raket_params$pir_params$experiments[[i]]$beast2_options$input_filename <- "nonsense"
    expect_error(
      check_raket_params(raket_params)
    )
    # BEAST2 output log file
    raket_params <- good_raket_params
    raket_params$pir_params$experiments[[i]]$beast2_options$output_log_filename <- "nonsense"
    expect_error(
      check_raket_params(raket_params)
    )
    # BEAST2 ouput trees files
    raket_params <- good_raket_params
    raket_params$pir_params$experiments[[i]]$beast2_options$output_trees_filenames <- "nonsense"
    expect_error(
      check_raket_params(raket_params)
    )
    # BEAST2 input file
    raket_params <- good_raket_params
    raket_params$pir_params$experiments[[i]]$beast2_options$output_state_filename <- "nonsense"
    expect_error(
      check_raket_params(raket_params)
    )
    # Errors file
    raket_params <- good_raket_params
    raket_params$pir_params$experiments[[i]]$errors_filename <- "nonsense"
    expect_error(
      check_raket_params(raket_params)
    )
  }
  # Twinning params: tree
  raket_params <- good_raket_params
  raket_params$pir_params$twinning_params$twin_tree_filename <- "nonsense"
  expect_error(
    check_raket_params(raket_params)
  )
  # Twinning params: alignment
  raket_params <- good_raket_params
  raket_params$pir_params$twinning_params$twin_alignment_filename <- "nonsense"
  expect_error(
    check_raket_params(raket_params)
  )
  # Twinning params: evidence
  raket_params <- good_raket_params
  raket_params$pir_params$twinning_params$twin_evidence_filename <- "nonsense"
  expect_error(
    check_raket_params(raket_params)
  )
  # Evidence
  raket_params <- good_raket_params
  raket_params$pir_params$evidence_filename <- "nonsense"
  expect_error(
    check_raket_params(raket_params)
  )

  # Sampling method
  raket_params <- good_raket_params
  raket_params$sampling_method <- "nonsense"
  expect_error(
    check_raket_params(raket_params),
    "'sampling_method' must be a sampling method"
  )

  raket_params <- good_raket_params
  raket_params$sampling_method <- NA
  expect_error(
    check_raket_params(raket_params),
    "'sampling_method' must be a sampling method"
  )

  raket_params <- good_raket_params
  raket_params$true_tree_filename <- NA
  expect_error(
    check_raket_params(raket_params),
    "raket_params\\$true_tree_filename is not of class 'character'"
  )

  raket_params <- good_raket_params
  raket_params$true_tree_filename <- "/no_way.newick"
  expect_error(
    check_raket_params(raket_params),
    "'true_tree_filename' must be Peregrine-friendly"
  )


  raket_params <- good_raket_params
  raket_params$pbd_sim_out_filename <- NA
  expect_error(
    check_raket_params(raket_params),
    "raket_params\\$pbd_sim_out_filename is not of class 'character'"
  )

  raket_params <- good_raket_params
  raket_params$pbd_sim_out_filename <- "/no_way.RDa"
  expect_error(
    check_raket_params(raket_params),
    "'pbd_sim_out_filename' must be Peregrine-friendly"
  )

})
