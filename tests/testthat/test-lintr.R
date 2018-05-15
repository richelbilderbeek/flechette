context("lintr")

test_that("Package Style", {

  # From https://github.com/jimhester/lintr#testthat
  lintr::expect_lint_free()

})
