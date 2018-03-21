context("create_output_file")

test_that("use", {

  output_filename <- tempfile()

  input_filenames <- create_input_files(
    mcmc_length = 2000,
    minimal_ess = 0
  )
  input_filename = input_filenames[1]

  create_output_file(
    input_filename = input_filename,
    output_filename = output_filename
  )
  testthat::expect_true(file.exists(output_filename))
  file.remove(input_filenames)
  file.remove(output_filename)
})
