context("lintr")

test_that("must have a clean lint", {

  # If this fails, only run devtools::lint()
  problems <- devtools::lint()
  testthat::expect_true(length(problems) == 0)
})
