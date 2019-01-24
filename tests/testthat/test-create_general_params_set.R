context("create_general_params_set")

test_that("must be a collection of multiple parameters", {

  params_set <- create_general_params_set()
  expect_equal(class(params_set), "list")
  testthat::expect_true(
    length(params_set) > 20
  )
})

test_that("all less than 1000 taxa with 95% certainty", {

  params_set <- create_general_params_set()

  for (params in params_set) {
    sir <- max(params$pbd_params$sirg, params$pbd_params$siri)
    n <- becosys::pbd_numspec_quantile_checked(
      sir = sir,
      scr = params$pbd_params$scr,
      erg = params$pbd_params$erg,
      eri = params$pbd_params$eri,
      crown_age = params$inference_params$mrca_prior$mrca_distr$mean$value,
      quantile = 0.95
    )
    testthat::expect_true(n < 1000)
  }
})
