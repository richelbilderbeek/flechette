context("create_output_file")

test_that("use", {

  output_filename <- tempfile()

  input_filenames <- create_input_files(
    mcmc_length = 2000,
    minimal_ess = 0
  )
  input_filename <- input_filenames[1]

  create_output_file(
    input_filename = input_filename,
    output_filename = output_filename
  )
  testthat::expect_true(file.exists(output_filename))

  out <- readRDS(output_filename)
  testthat::expect_true("parameters" %in% names(out))
  testthat::expect_true("incipient_tree" %in% names(out))
  testthat::expect_true("species_tree" %in% names(out))
  testthat::expect_true("alignment" %in% names(out))
  testthat::expect_true("trees" %in% names(out))
  testthat::expect_true("estimates" %in% names(out))

  file.remove(input_filenames)
  file.remove(output_filename)
})
