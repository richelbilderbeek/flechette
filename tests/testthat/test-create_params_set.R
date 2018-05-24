context("create_params_set")

test_that("use", {
  testthat::expect_silent(create_params_set("general"))
})

test_that("use, sampling", {
  skip("Dont create a sampling data set")
  testthat::expect_silent(create_params_set("sampling"))
})

test_that("abuse", {
  skip("For @J-Damhuis and @Tomdkkr")
  testthat::expect_error(create_params_set("nonsense"),
    "'experiment_type' must be 'general' or 'sampling'"
  )
})
