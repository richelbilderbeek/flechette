context("workflow")

test_that("Full workflow, general", {

  if (!ribir::is_on_travis()) return()

  chain_length <- 1100
  sampling_interval <- 100
  sequence_length <- 150

  ##############################################################################
  # 1.1 Create all `.RDa` input/parameter files to do a general mapping
  ##############################################################################
  input_filenames <- create_input_files_general(
    mcmc = beautier::create_mcmc(
      chain_length = chain_length, 
      store_every = sampling_interval
    ),
    sequence_length = sequence_length,
    folder_name = tempdir()
  )
  
  ##############################################################################
  # 2 Run simulation, store all info (such as all posterior phylogenies) as .RDa
  ##############################################################################
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
      output_filename = output_filenames[i]
    )
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
      output_filename = nltt_filenames[i]
    )
  }
  skip("WIP")
  
  
  ##############################################################################
  # 4. Merge all nLTT values into one `.csv` file
  ##############################################################################
  csv_filename <- tempfile()
  nltt_files_to_csv(
    input_filename = nltt_filenames,
    output_filename = csv_filename
  )
  
  testthat::expect_true(file.exists(csv_filename))
  df <- read.csv(file = csv_filename)
  testthat::expect_true(nrow(df) == 3)
  testthat::expect_true(ncol(df) > 1000)
  
  
})
