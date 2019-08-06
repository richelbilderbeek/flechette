context("rkt_get_experiment_types")

test_that("use", {

  expect_true("general" %in% rkt_get_experiment_types())
  expect_true("sampling" %in% rkt_get_experiment_types())
  expect_true("test" %in% rkt_get_experiment_types())

})
