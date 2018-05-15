context("rkt_get_experiment_types")

test_that("use", {

  testthat::expect_true(
    "general" %in% rkt_get_experiment_types()
  )
  testthat::expect_true(
    "sampling" %in% rkt_get_experiment_types()
  )

})
