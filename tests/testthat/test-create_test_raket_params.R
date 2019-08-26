context("test-create_test_raket_params")

test_that("use", {
  expect_silent(
    check_raket_params(
      create_test_raket_params()
    )
  )
})
