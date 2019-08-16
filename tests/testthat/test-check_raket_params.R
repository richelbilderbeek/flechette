context("test-check_raket_params")

test_that("use", {

  good_raket_params <- create_test_raket_params()
    expect_silent(
    check_raket_params(raket_params = good_raket_params)
  )

  pbd_params <- create_test_pbd_params()
  pir_params <- peregrine::create_test_pff_pir_params(
    twinning_params = peregrine::create_pff_twinning_params()
  )
  sampling_method <- rkt_get_sampling_methods()[3]

  expect_silent(
    create_raket_params(
      pbd_params = pbd_params,
      pir_params = pir_params,
      sampling_method = sampling_method
    )
  )

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
  raket_params <- create_test_raket_params()
  folder_name <- dirname(
    raket_params$pir_params$alignment_params$fasta_filename
  )
  # Sim
  expect_equal(
    file.path(folder_name, "pbd_sim_out.RDa"),
    raket_params$pbd_sim_out_filename
  )
  # True tree
  expect_equal(
    file.path(folder_name, "pbd.newick"),
    raket_params$true_tree_filename
  )
  # True alignment
  expect_equal(
    file.path(folder_name, "pbd.fasta"),
    raket_params$pir_params$alignment_params$fasta_filename
  )
  # True posterior, generative at index 1
  gen_experiment <- raket_params$pir_params$experiments[[1]]
  expect_equal(
    gen_experiment$inference_conditions$model_type,
    "generative"
  )
  expect_equal(
    file.path(folder_name, "pbd_gen.xml"),
    gen_experiment$beast2_options$input_filename,
  )
  expect_equal(
    file.path(folder_name, "pbd_gen.log"),
    gen_experiment$beast2_options$output_log_filename,
  )
  expect_equal(
    file.path(folder_name, "pbd_gen.trees"),
    gen_experiment$beast2_options$output_trees_filenames,
  )
  expect_equal(
    file.path(folder_name, "pbd_gen.xml.state"),
    gen_experiment$beast2_options$output_state_filename,
  )
  expect_equal(
    file.path(folder_name, "pbd_nltts_gen.csv"),
    gen_experiment$errors_filename
  )
  # Candidate experiments, at all but the first index
  cand_experiments <- raket_params$pir_params$experiments[-1]
  for (cand_experiment in cand_experiments) {
    expect_equal(
      cand_experiment$inference_conditions$model_type,
      "candidate"
    )
    expect_equal(
      file.path(folder_name, "pbd_best.xml"),
      cand_experiment$beast2_options$input_filename,
    )
    expect_equal(
      file.path(folder_name, "pbd_best.log"),
      cand_experiment$beast2_options$output_log_filename,
    )
    expect_equal(
      file.path(folder_name, "pbd_best.trees"),
      cand_experiment$beast2_options$output_trees_filenames,
    )
    expect_equal(
      file.path(folder_name, "pbd_best.xml.state"),
      cand_experiment$beast2_options$output_state_filename,
    )
    expect_equal(
      file.path(folder_name, "pbd_nltts_best.csv"),
      cand_experiment$errors_filename
    )
  }
  expect_equal(
    file.path(folder_name, "pbd_twin.newick"),
    raket_params$pir_params$twinning_params$twin_tree_filename
  )
  expect_equal(
    file.path(folder_name, "pbd_twin.fasta"),
    raket_params$pir_params$twinning_params$twin_alignment_filename
  )
  expect_equal(
    file.path(folder_name, "pbd_marg_lik_twin.csv"),
    raket_params$pir_params$twinning_params$twin_evidence_filename
  )
  expect_equal(
    file.path(folder_name, "pbd_marg_lik.csv"),
    raket_params$pir_params$evidence_filename
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
