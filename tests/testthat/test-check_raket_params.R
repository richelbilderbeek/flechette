context("test-check_raket_params")

test_that("use", {

  raket_params <- create_test_raket_params()
  expect_silent(
    check_raket_params(raket_params)
  )
})
