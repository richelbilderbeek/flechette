context("create_general_params_set")

test_that("use", {

  if (!ribir::is_on_travis()) return()

  params_set <- create_general_params_set()
  testthat::expect_true(
    length(params_set) > 20
  )
})
