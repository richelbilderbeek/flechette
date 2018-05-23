context("create_params_set")

test_that("use", {
  testthat::expect_silent(create_params_set("general"))

  if (!ribir::is_on_travis()) return()
  testthat::expect_silent(create_params_set("sampling"))
})

test_that("abuse", {
  skip("For @J-Damhuis and @Tomdkkr")
  testthat::expect_error(create_params_set("nonsense"),
    "'experiment_type' must be 'general' or 'sampling'"
  )
})


test_that("each params_set element must be the same", {
  skip("WIP @richelbilderbeek Issue 18")
  gps <- raket::create_general_params_set()
  sps <- raket::create_sampling_params_set()
  testit::assert(length(gps[[1]]) == length(sps[[1]]))
})
