test_that("use", {

  expect_silent(check_raket_paramses(create_test_params_set()))
})

test_that("should be simple", {

  test_params_set <- create_test_params_set()
  first_raket_params <- test_params_set[[1]]

  # Few experiments
  expect_true(
    length(first_raket_params$pir_params$experiments) <= 3
  )

  # Short MCMC
  first_experiment <- first_raket_params$pir_params$experiments[[1]]
  expect_true(
    first_experiment$inference_model$mcmc$chain_length < 1e4
  )

  # Sloppy model comparison
  expect_true(
    first_experiment$est_evidence_mcmc$epsilon > 1.0
  )
})

test_that("all filenames are Peregrine friendly", {

  params_set <- create_test_params_set()

  flat_params_set <- unlist(params_set)
  names <- names(flat_params_set)
  filename_indices <- which(
    grepl(pattern = "(filename|working_dir)", x = names)
  )
  filenames <- flat_params_set[filename_indices]
  for (filename in filenames) {
    expect_true(beautier::is_one_na(filename) || peregrine::is_pff(filename))
  }
})
