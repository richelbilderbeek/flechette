context("create_input_files")

test_that("files are created in right folder", {
  filenames <- create_input_files_general(folder_name = tempdir())
  testthat::expect_true(all(file.exists(filenames)))
})
