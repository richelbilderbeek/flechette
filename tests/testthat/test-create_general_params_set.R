context("create_general_params_set")

test_that("must be a collection of multiple parameters", {
  params_set <- create_general_params_set()
  testthat::expect_true(
    length(params_set) > 20
  )
})

test_that("each parameter must have the right number of elements", {
  params_set <- create_general_params_set()
  params <- params_set[[1]]
  testthat::expect_equal(
    rkt_get_n_params(), length(unlist(params))
  )
})

test_that("all less than 1000 taxa with 95% certainty", {

  params_set <- create_general_params_set()
  for (params in params_set) {
    sir <- max(params$sirg, params$siri)
    n <- raket::pbd_numspec_quantile_checked(
      sir = sir,
      scr = params$scr,
      erg = params$erg,
      eri = params$eri,
      crown_age = params$crown_age,
      quantile = 0.95
    )
    if (n >= 1000) print(paste(n, sir))
    testthat::expect_true(n < 1000)
  }
})
