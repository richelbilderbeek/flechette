context("create_output_file")

test_that("use", {

  output_filename <- tempfile()

  input_filenames <- create_input_files(
    mcmc = beautier::create_mcmc(chain_length = 2000)
  )
  # Only run the first input file
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

test_that("abuse", {

  testthat::expect_error(
    create_output_file(
      input_filename = "abs.ent",
      output_filename = "irrelevant"
    ),
    "'input_filename' must exist"
  )
})
