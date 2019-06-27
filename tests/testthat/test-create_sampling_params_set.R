context("create_sampling_params_set")

test_that("must be a collection of multiple parameters", {

  # Need an odd number here, as params come in pairs,
  # due to two sampling methods
  max_n_params <- 2
  params_set <- create_sampling_params_set(
    max_n_params = max_n_params
  )
  expect_equal(class(params_set), "list")
  expect_equal(max_n_params, length(params_set))
})

test_that("no high SRCs", {

  if (!beastier::is_on_travis()) return()

  params_set <- create_sampling_params_set(
    max_n_params = 2
  )
  for (params in params_set) {
    expect_true(params$pbd_params$scr < 1000.0)
  }
})

test_that("sampling matters", {

  if (!beastier::is_on_travis()) return()

  params_set <- create_sampling_params_set(max_n_params = 2)
  for (params in params_set) {
    set.seed(params$tree_sim_rng_seed)
    out <- becosys::pbd_sim_checked(
      erg = params$pbd_params$erg,
      eri = params$pbd_params$eri,
      scr = params$pbd_params$scr,
      sirg = params$pbd_params$sirg,
      siri = params$pbd_params$siri,
      crown_age = params$pir_params$experiments[[1]]$inference_model$mrca_prior$mrca_distr$mean$value
    )
    sum_youngest <- sum(out$stree_youngest$edge.length)
    sum_oldest <- sum(out$stree_oldest$edge.length)
    expect_true(sum_youngest != sum_oldest)
  }
})
