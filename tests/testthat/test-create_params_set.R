context("create_params_set")

test_that("use", {
  if (!beastier::is_on_travis()) return()
  expect_silent(create_params_set("general"))
})

test_that("use, sampling", {
  if (!beastier::is_on_travis()) return()
  expect_silent(
    create_params_set(experiment_type = "sampling", max_n_params = 2)
  )
})

test_that("abuse", {
  expect_error(create_params_set("nonsense"),
    "'experiment_type' must be 'general' or 'sampling'"
  )
})
