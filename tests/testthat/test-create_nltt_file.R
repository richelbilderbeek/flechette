context("create_nltt_file")

test_that("abuse", {

  testthat::expect_error(  
    create_nltt_file(
      input_filename = "abs.ent",
      output_filename = tempfile()
    ),
    "'input_filename' must be the name of an existing file"
  )

})
