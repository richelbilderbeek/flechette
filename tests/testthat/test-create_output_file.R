context("create_output_file")

test_that("use", {

  # Put files in temporary folder
  super_folder_name <- tempdir()
  project_folder_name <- file.path(super_folder_name, "raket_werper")
  # Do not warn if the folder already exists
  dir.create(path = project_folder_name, showWarnings = FALSE)

  output_filename <- tempfile()

  input_filenames <- create_input_files_general(
    general_params_set = create_general_params_set(
      mcmc_chain_length = 16000,
      sequence_length = 8
    ),
    project_folder_name = project_folder_name
  )

  while (1) {
    # Only run an input file with low speciation rate
    input_filename <- sample(x = input_filenames, size = 1)
    testit::assert("sirg" %in% names(utils::read.csv(input_filename)))
    testit::assert("siri" %in% names(utils::read.csv(input_filename)))
    lowest_sir <- min(rkt_get_spec_init_rates())
    if (utils::read.csv(input_filename)$sirg > lowest_sir) next
    if (utils::read.csv(input_filename)$siri > lowest_sir) next
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
