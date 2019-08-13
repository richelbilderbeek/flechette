test_that("use", {

  skip("To be done")

  if (!beastier::is_on_travis()) return()

  raket_params <- create_test_raket_params()
  create_pbd_output_file(raket_params)
  beautier::check_file_exists(raket_params$pbd_sim_out_filename)

  pbd_output <- readRDS(raket_params$pbd_sim_out_filename)
  expect_true(becosys::is_pbd_sin_out(pbd_output))
})
