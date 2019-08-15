test_that("use, shortest", {

  if (!beastier::is_on_travis()) return()

  raket_params <- create_test_raket_params()
  testit::assert(raket_params$sampling_method == "shortest")
  out <- run_raket(raket_params)
  expect_true("parameters" %in% names(out))
  expect_true("incipient_tree" %in% names(out))
  expect_true("species_tree" %in% names(out))
  expect_true("alignment" %in% names(out))
  expect_true("trees" %in% names(out))
  expect_true("estimates" %in% names(out))
})

test_that("use, random", {

  if (!beastier::is_on_travis()) return()

  raket_params <- create_test_raket_params()
  raket_params$sampling_method <- "random"
  expect_silent(run_raket(raket_params))
})

test_that("use, on CBS with too few taxa, should give proper error", {

  if (!beastier::is_on_travis()) return()

  raket_params <- create_test_raket_params()

  # Take the first candidate
  raket_params$pir_params$experiments <- raket_params$pir_params$experiments[2]
  testit::assert(
    raket_params$pir_params$experiments[[1]]$inference_conditions$model_type ==
    "candidate"
  )
  raket_params$pir_params$experiments[[1]]$inference_model$tree_prior <-
    create_cbs_tree_prior()
  testit::assert(
    raket_params$pir_params$experiments[[1]]$inference_model$tree_prior$name ==
    "coalescent_bayesian_skyline"
  )
  expect_error(
    run_raket(raket_params),
    "No experiments left after removing all experiments with a CBS tree prior"
  )
})
