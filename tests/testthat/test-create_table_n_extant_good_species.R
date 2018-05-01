context("create_table_n_extant_good_species")

test_that("use", {

  skip("WIP")
  filenames <- create_input_files_general(
    general_params_set = create_general_params_set(),
    folder_name = tempdir()
  )
  testthat::expect_true(all(file.exists(filenames)))
  filenames <- sample(filenames, size = 3, replace = FALSE)

  df <- create_table_n_extant_good_species(filenames)
  testthat::expect_equal(length(filename), nrow(df))
})
