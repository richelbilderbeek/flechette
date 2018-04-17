context("workflow")

test_that("Full workflow, general", {

  skip("WIP")
  chain_length <- 1000000
  sampling_interval <- 1000
  
  if (!ribir::is_on_travis()) {
    # Shorter on local computer
    chain_length <- 1100
    sampling_interval <- 100
  }

  input_filenames <- create_input_files_general(
    mcmc = beautier::create_mcmc(
      chain_length = chain_length, 
      store_every = sampling_interval
    ),
    folder_name = tempdir()
  )
  # Only run the first input file
  input_filenames <- input_filenames[1]
  out <- readRDS(input_filenames[1])

})
