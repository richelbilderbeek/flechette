context("test-check_raket_params")

test_that("use", {

  good_raket_params <- create_test_raket_params()
  expect_silent(
    check_raket_params(raket_params = good_raket_params)
  )

  pbd_params <- create_test_pbd_params()
  pir_params <- create_test_pff_pir_params()
  misc_params <- create_misc_params()

  expect_silent(
    create_raket_params(
      pbd_params = pbd_params,
      pir_params = pir_params,
      misc_params = misc_params
    )
  )

  # Check elements
  expect_error(
    check_raket_params(raket_params = list()),
    "'pbd_params' must be an element of a 'raket_params'"
  )

  expect_error(
    check_raket_params(raket_params = list(pbd_params = pbd_params)),
    "'pir_params' must be an element of a 'raket_params'"
  )

  expect_error(
    check_raket_params(raket_params = list(
      pbd_params = pbd_params, pir_params = pir_params)
    ),
    "'misc_params' must be an element of a 'raket_params'"
  )

  # Check pbd_params
  # done by check_pbd_params

  # Check pir_params
  # Mostly done by check_pir_params

  # Check for Peregrine-unfriendly filenames (hence 'puf')
  raket_params <- good_raket_params
  raket_params$pir_params$twinning_params$twin_tree_filename <- "/tmp/puf"
  expect_error(
    check_raket_params(raket_params),
    "Peregrine-unfriendly filename for '"
  )

  raket_params <- good_raket_params
  raket_params$pir_params$twinning_params$twin_alignment_filename <- "/tmp/puf"
  expect_error(
    check_raket_params(raket_params),
    "Peregrine-unfriendly filename for '"
  )

  raket_params <- good_raket_params
  raket_params$pir_params$twinning_params$twin_evidence_filename <- "/tmp/puf"
  expect_error(
    check_raket_params(raket_params),
    "Peregrine-unfriendly filename for '"
  )

  raket_params <- good_raket_params
  raket_params$pir_params$alignment_params$fasta_filename <- "/tmp/puf"
  expect_error(
    check_raket_params(raket_params),
    "Peregrine-unfriendly filename for '"
  )

  for (i in seq_along(pir_params$experiments)) {
    raket_params <- good_raket_params
    raket_params$pir_params$experiments[[i]]$beast2_options$input_filename <- "/tmp/puf"
    expect_error(
      check_raket_params(raket_params),
      "Peregrine-unfriendly filename for '"
    )

    raket_params <- good_raket_params
    raket_params$pir_params$experiments[[i]]$beast2_options$output_log_filename <- "/tmp/puf"
    expect_error(
      check_raket_params(raket_params),
      "Peregrine-unfriendly filename for '"
    )

    raket_params <- good_raket_params
    raket_params$pir_params$experiments[[i]]$beast2_options$output_trees_filenames <- "/tmp/puf"
    expect_error(
      check_raket_params(raket_params),
      "Peregrine-unfriendly filename for '"
    )

    raket_params <- good_raket_params
    raket_params$pir_params$experiments[[i]]$beast2_options$output_state_filename <- "/tmp/puf"
    expect_error(
      check_raket_params(raket_params),
      "Peregrine-unfriendly filename for '"
    )

    raket_params <- good_raket_params
    raket_params$pir_params$experiments[[i]]$beast2_options$beast2_working_dir <- "/tmp/puf"
    expect_error(
      check_raket_params(raket_params),
      "Peregrine-unfriendly filename for '"
    )

    raket_params <- good_raket_params
    raket_params$pir_params$experiments[[i]]$beast2_options$beast2_path <- "/tmp/puf"
    expect_error(
      check_raket_params(raket_params),
      "Peregrine-unfriendly filename for '"
    )
  }
  # Check misc_params
  raket_params <- good_raket_params
  raket_params$misc_params$tree_filename <- "/tmp/puf"
  expect_error(
    check_raket_params(raket_params),
    "Peregrine-unfriendly filename for '"
  )
})
