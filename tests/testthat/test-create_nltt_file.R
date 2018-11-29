context("create_nltt_file")

test_that("abuse", {

  testthat::expect_error(
    create_nltt_file(
      input_filename = "abs.ent",
      posterior_filesname = tempfile()
    ),
    "'input_filename' must be the name of an existing file"
  )
})
