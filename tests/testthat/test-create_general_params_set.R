test_that("must return the number of parameters", {

  n_replicates <- 2
  params_set <- create_general_params_set(
    n_replicates = n_replicates
  )
  expect_equal(class(params_set), "list")
  expect_equal(
    length(params_set),
    n_replicates *
      length(rkt_get_ext_rates()) *
      length(rkt_get_spec_compl_rates()) *
      length(rkt_get_spec_init_rates())
  )

  # all less than 1000 taxa with 95% certainty

  for (params in params_set) {
    crown_age <- params$pir_params$experiments[[1]]$inference_model$mrca_prior$mrca_distr$mean$value # nolint indeed a long line, sorry Demeter
    testit::assert(crown_age > 0.0)
    sir <- max(params$pbd_params$sirg, params$pbd_params$siri)
    n <- becosys::pbd_numspec_quantile_checked(
      sir = sir,
      scr = params$pbd_params$scr,
      erg = params$pbd_params$erg,
      eri = params$pbd_params$eri,
      crown_age = crown_age,
      quantile = 0.95
    )
    expect_true(n < 1000)
  }
})
