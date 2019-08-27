test_that("must be a valid raket_paramses", {

  if (!beastier::is_on_travis()) return()

  expect_silent(
    check_raket_paramses(
      create_sampling_params_set(n_replicates = 2)
    )
  )
})

test_that("no high SRCs", {

  skip("Takes too long?")

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
      crown_age = params$pir_params$experiments[[1]]$inference_model$mrca_prior$mrca_distr$mean$value # nolint sorry Demeter
    )
    sum_youngest <- sum(out$stree_youngest$edge.length)
    sum_oldest <- sum(out$stree_oldest$edge.length)
    expect_true(sum_youngest != sum_oldest)
  }
})

test_that("all filenames are Peregrine friendly", {

  if (!beastier::is_on_travis()) return()

  params_set <- create_sampling_params_set(n_replicates = 2)

  flat_params_set <- unlist(params_set)
  names <- names(flat_params_set)
  filename_indices <- which(grepl(pattern = "(filename|working_dir)", x = names))
  filenames <- flat_params_set[filename_indices]
  for (filename in filenames) {
    expect_true(beautier::is_one_na(filename) || peregrine::is_pff(filename))
  }
})
