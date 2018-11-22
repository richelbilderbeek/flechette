context("create_sampling_params_set")

test_that("must be a collection of multiple parameters", {

  # Need an odd number here, as params come in pairs
  # (due to two sampling methods)
  max_n_params <- 2
  params_set <- create_sampling_params_set(
    max_n_params = max_n_params
  )
  testthat::expect_equal(
    max_n_params,
    length(params_set)
  )
})

test_that("each parameter must have the right number of elements", {

  max_n_params <- 2
  params_set <- create_sampling_params_set(
    max_n_params = max_n_params
  )
  params <- params_set[[1]]
  testthat::expect_equal(
    rkt_get_n_params(), length(unlist(params))
  )
})

test_that("no high SRCs", {

  for (params in create_sampling_params_set(max_n_params = 2)) {
    testthat::expect_true(
      params$scr < 1000.0
    )
  }
})

test_that("sampling matters", {

  params_set <- create_sampling_params_set(max_n_params = 2)
  for (params in params_set) {
    set.seed(params$tree_sim_rng_seed)
    out <- becosys::pbd_sim_checked(
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
