context("create_sampling_params_set")

test_that("use", {

  if (!ribir::is_on_travis()) return()

  params_set <- create_sampling_params_set()
  testthat::expect_true(
    length(params_set) > 20
  )
})

test_that("no high SRCs", {

  if (!ribir::is_on_travis()) return()

  for (params in create_sampling_params_set()) {
    testthat::expect_true(
      params$scr < 1000.0
    )
  }
})

test_that("sampling matters", {

  if (!ribir::is_on_travis()) return()

  params_set <- create_sampling_params_set()
  for (params in params_set) {
    set.seed(params$tree_sim_rng_seed)
    out <- pbd_sim_checked(
      erg = params$erg,
      eri = params$eri,
      scr = params$scr,
      sirg = params$sirg,
      siri = params$siri,
      crown_age = params$crown_age
    )
    sum_youngest <- sum(out$stree_youngest$edge.length)
    sum_oldest <- sum(out$stree_oldest$edge.length)
    testthat::expect_true(sum_youngest != sum_oldest)
  }
})
