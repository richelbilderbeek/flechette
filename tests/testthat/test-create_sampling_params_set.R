context("create_sampling_params_set")

test_that("must be a collection of multiple parameters", {

  skip("No sampling")
  if (!ribir::is_on_travis()) return()

  params_set <- create_sampling_params_set(max_n_params = 2)
  testthat::expect_true(
    length(params_set) > 20
  )
})

test_that("each parameter must have the right number of elements", {

  skip("No sampling")
  if (!ribir::is_on_travis()) return()

  params_set <- create_sampling_params_set()
  params <- params_set[[1]]
  testthat::expect_equal(
    rkt_get_n_params(), length(unlist(params))
  )
})

test_that("no high SRCs", {

  skip("No sampling")
  if (!ribir::is_on_travis()) return()

  for (params in create_sampling_params_set()) {
    testthat::expect_true(
      params$scr < 1000.0
    )
  }
})

test_that("sampling matters", {

  skip("No sampling")
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
