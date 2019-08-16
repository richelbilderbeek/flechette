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
  expect_true(
    !is.na(
      stringr::str_match(
        raket_params$pir_params$alignment_params$fasta_filename,
        "pbd\\.fasta$"
      )[1,1]
    )
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
