test_that("must return the expected number of parameter sets", {

  if (!beastier::is_on_travis()) return()

  n_replicates <- 2
  params_set <- create_general_params_set(
    n_replicates = n_replicates
  )
  expect_silent(
    check_raket_paramses(params_set)
  )
  expect_equal(
    length(params_set),
    n_replicates *
      length(rkt_get_ext_rates()) *
      length(rkt_get_spec_compl_rates()) *
      length(rkt_get_spec_init_rates())
  )
})

test_that("all filenames are Peregrine friendly", {

  if (!beastier::is_on_travis()) return()

  n_replicates <- 2
  params_set <- create_general_params_set(
    n_replicates = n_replicates
  )
  flat_params_set <- unlist(params_set)
  names <- names(flat_params_set)
  filename_indices <- which(grepl(pattern = "(filename|working_dir)", x = names))
  filenames <- flat_params_set[filename_indices]
  for (filename in filenames) {
    expect_true(beautier::is_one_na(filename) || peregrine::is_pff(filename))
  }
})

test_that("all less than 1000 taxa with 95% certainty", {

  if (!beastier::is_on_travis()) return()

  n_replicates <- 2
  params_set <- create_general_params_set(
    n_replicates = n_replicates
  )

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
