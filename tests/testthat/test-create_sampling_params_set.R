context("create_sampling_params_set")

test_that("use", {

  skip("WIP")
  params_set <- create_sampling_params_set()
  testthat::expect_true(
    length(params_set) > 20
  )

})

test_that("sampling matters", {

  skip("WIP")
  if (!ribir::is_on_travis()) return()

  params_set <- create_sampling_params_set()
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
