context("workflow")

test_that("Full workflow, general", {

  chain_length <- 11000
  sampling_interval <- 1000
  sequence_length <- 150

  if (!ribir::is_on_travis()) {
    # Shorter on local computer
    chain_length <- 1100
    sampling_interval <- 100
    sequence_length <- 150
  }

  input_filenames <- create_input_files_general(
    mcmc = beautier::create_mcmc(
      chain_length = chain_length, 
      store_every = sampling_interval
    ),
    sequence_length = sequence_length,
    folder_name = tempdir()
  )
  # Only run the first three input file
  set.seed(42)
  input_filenames <- sample(input_filenames, size = 3, replace = FALSE)
  
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
      output_filename = output_filenames[i],
      verbose = FALSE
    )
  }

})
