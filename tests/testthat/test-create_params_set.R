context("create_params_set")

test_that("use", {
  if (!beastier::is_on_travis()) return()
  skip("Takes too long")
  system.time(create_params_set("general"))
  expect_silent(create_params_set("general"))
})

test_that("use, sampling", {
  if (!beastier::is_on_travis()) return()
  skip("Takes too long")
  expect_silent(
    create_params_set(experiment_type = "sampling", max_n_params = 2)
  )
})

test_that("abuse", {
  expect_error(create_params_set("nonsense"),
    "'experiment_type' must be in 'rkt_get_experiment_types()'"
  )
})
