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

  skip("Sum of evidences deviates too much from one")
  raket_params <- create_test_raket_params()
  raket_params$sampling_method <- "random"
  expect_silent(run_raket(raket_params))
})


