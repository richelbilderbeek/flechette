context("create_input_files")

test_that("files are created in right folder", {

  skip("Breaks build?")
  filenames <- create_input_files_general(folder_name = tempdir())
  testthat::expect_true(all(file.exists(filenames)))
})
