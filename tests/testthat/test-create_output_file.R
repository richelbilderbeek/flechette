context("create_output_file")

test_that("use", {

  output_filename <- tempfile()

  input_filenames <- create_input_files_general(
    mcmc = beautier::create_mcmc(chain_length = 3000, store_every = 1000),
    sequence_length = 10,
    folder_name = tempdir()
  )
  
  while (1) {
    # Only run an input file with low speciation rate
    input_filename <- sample(x = input_filenames, size = 1)
    testit::assert("sirg" %in% names(readRDS(input_filename)))
    testit::assert("siri" %in% names(readRDS(input_filename)))
    if (readRDS(input_filename)$sirg > 0.1) next
    if (readRDS(input_filename)$siri > 0.1) next
    break
  }

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
