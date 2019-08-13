test_that("use", {

  # Preparation
  raket_params <- create_test_raket_params()
  create_pbd_sim_out_file(raket_params)

  filename <- create_true_tree_file(raket_params)
  expect_equal(filename, raket_params$true_tree_filename)
  beautier::check_file_exists(raket_params$true_tree_filename)

  true_tree <- ape::read.tree(raket_params$true_tree_filename)
  expect_silent(beautier::check_phylogeny(true_tree))
})
