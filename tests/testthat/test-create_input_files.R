context("create_input_files")

test_that("use", {

  filenames <- create_input_files_general()
  testthat::expect_true(all(file.exists(filenames)))
  file.remove(filenames)
})
