context("lintr")

test_that("Package Style", {

  # Don't test on Travis, let @lintr-bot do that
  if (beastier::is_on_travis()) return()

  # From https://github.com/jimhester/lintr#testthat
  lintr::expect_lint_free()

})
