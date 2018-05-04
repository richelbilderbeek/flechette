context("workflow")

test_that("Full workflow, general", {

  skip("Too long, also on Travis")

  n_parameters <- 15 # Just a given
  chain_length <- 4000
  sampling_interval <- 1000
  sequence_length <- 15
  testit::assert(sampling_interval >= 1000)
  n_samples <- 1 + (chain_length / sampling_interval)
  burn_in_fraction <- 0.40
  n_samples_to_remove <- burn_in_fraction * n_samples
  n_samples_no_burn_in <- n_samples - n_samples_to_remove

  ##############################################################################
  # 1.1 Create all `.RDa` input/parameter files to do a general mapping
  ##############################################################################
  input_filenames <- create_input_files_general(
    general_params_set = create_general_params_set(
      mcmc = beautier::create_mcmc(
        chain_length = chain_length,
        store_every = sampling_interval
      ),
      sequence_length = sequence_length
    ),
    folder_name = tempdir()
  )

  testit::assert(n_parameters == length(unlist(readRDS(input_filenames[1]))))

  ##############################################################################
  # 2 Run simulation, store all info (such as all posterior phylogenies) as .RDa
  ##############################################################################
  # Only run the first three input file, pick three easy ones
  set.seed(42)
  while (1) {
    input_filenames <- sample(input_filenames, size = 3, replace = FALSE)
    if (readRDS(input_filenames[1])$sirg > 0.1) next
    if (readRDS(input_filenames[1])$siri > 0.1) next
    if (readRDS(input_filenames[2])$sirg > 0.1) next
    if (readRDS(input_filenames[2])$siri > 0.1) next
    if (readRDS(input_filenames[3])$sirg > 0.1) next
    if (readRDS(input_filenames[3])$siri > 0.1) next
    break
  }

  # Name the output files
  output_filenames <- sub(
    x = input_filenames,
    pattern = ".RDa", replacement = "_out.RDa"
  )
  # Create the output files
  testit::assert(length(input_filenames) == length(output_filenames))
  for (i in seq_along(input_filenames)) {
    create_output_file(
      input_filename = input_filenames[i],
      output_filename = output_filenames[i]
    )
    testit::assert(length(readRDS(output_filenames[i])$trees) == n_samples)
  }

  ##############################################################################
  # 3. Extract nLTT values from output file, store parameters and nLTTs as .RDa
  ##############################################################################
  # Name the nLTT files
  nltt_filenames <- sub(
    x = input_filenames,
    pattern = ".RDa", replacement = "_nltt.RDa"
  )
  # Create the output files
  testit::assert(length(output_filenames) == length(nltt_filenames))
  for (i in seq_along(output_filenames)) {
    create_nltt_file(
      input_filename = output_filenames[i],
      output_filename = nltt_filenames[i],
      burn_in_fraction = burn_in_fraction
    )
    testit::assert(
      length(readRDS(nltt_filenames[i])$nltts) == n_samples_no_burn_in
    )
  }

  ##############################################################################
  # 4. Merge all nLTT values into one `.csv` file
  ##############################################################################
  csv_filename <- tempfile()
  nltt_files_to_csv(
    nltt_filenames = nltt_filenames,
    csv_filename = csv_filename
  )

  # Reading the .csv
  testthat::expect_true(file.exists(csv_filename))
  df <- read.csv(file = csv_filename)
  testthat::expect_true(nrow(df) == length(input_filenames))
  testthat::expect_true(ncol(df) == n_parameters + n_samples_no_burn_in)

  ##############################################################################
  # 5. After reading the `.csv` with `read.csv()`,
  #    convert data frame to tidy data in the long form
  ##############################################################################
  n_measurements <- n_samples_no_burn_in * length(input_filenames)
  df_long <- to_long(df)
  testthat::expect_true(nrow(df_long) == n_measurements)
  testthat::expect_true(ncol(df_long) == n_parameters + 2)

  ##############################################################################
  # 6. Plot the tidy data in long form as a violin plot,
  #    depends on sampling method
  ##############################################################################
  testthat::expect_silent(rkt_plot(df_long))
})
