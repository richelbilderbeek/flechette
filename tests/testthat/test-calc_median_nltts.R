context("calc_median_nltts")

test_that("use", {

  if (as.vector(Sys.info()["user"]) != "richel") return()
  output_filename <- tempfile(fileext = ".csv")
  testthat::expect_false(file.exists(output_filename))
  calc_median_nltts(
    folder_name = "/home/richel/raket_data",
    output_filename = output_filename
  )
  testthat::expect_true(file.exists(output_filename))
})
