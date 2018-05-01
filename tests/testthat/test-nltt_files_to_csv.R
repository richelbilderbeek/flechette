context("nltt_files_to_csv")

test_that("abuse", {

  testthat::expect_error(
    nltt_files_to_csv(
      nltt_filenames = c(),
      csv_filename = tempfile()
    ),
    "'nltt_filenames' must have at least one filename"
  )
})
