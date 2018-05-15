context("lintr")

test_that("must have a clean lint", {

  # From https://github.com/jimhester/lintr#testthat
  if (requireNamespace("lintr", quietly = TRUE)) {
    context("lints")
    test_that("Package Style", {
      lintr::expect_lint_free()
    })
  }

})
