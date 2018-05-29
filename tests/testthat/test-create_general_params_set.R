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
  if (!ribir::is_on_travis()) return()
  params_set <- create_general_params_set()
  for (params in params_set) {
    sir <- max(params$sirg, params$siri)
    testit::assert(
      PBD::pbd_numspec_quantile(
        pars = c(sir, 
      pbd_expected_n_extant(
        crown_age = params$crown_age,
        scr = params$scr,
        sirg = params$sirg,
        siri = params$siri,
        erg = params$erg,
        eri = params$eri,
        n_sims = 10
      ) < 1000
    )
  }
})

test_that("all less than 1000 taxa, pragmatic approach", {
  if (!ribir::is_on_travis()) return()
  params_set <- create_general_params_set()
  for (params in params_set) {
    testit::assert(
      pbd_expected_n_extant(
        crown_age = params$crown_age,
        scr = params$scr,
        sirg = params$sirg,
        siri = params$siri,
        erg = params$erg,
        eri = params$eri,
        n_sims = 10
      ) < 1000
    )
  }
})
