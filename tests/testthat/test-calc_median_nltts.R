context("calc_median_nltts")

test_that("use", {

  return()
  output_filename <- tempfile(fileext = ".csv")
  testthat::expect_false(file.exists(output_filename))
  calc_median_nltts(
    input_filenames = list.files(
      "/home/richel/flechette_data", full.names = TRUE
    ),
    output_filename = output_filename
  )
  testthat::expect_true(file.exists(output_filename))
})
