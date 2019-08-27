test_that("use", {

  expect_silent(
    check_raket_paramses(
      create_test_params_set()
    )
  )
})

test_that("all filenames are Peregrine friendly", {

  params_set <- create_test_params_set()

  flat_params_set <- unlist(params_set)
  names <- names(flat_params_set)
  filename_indices <- which(
    grepl(pattern = "(filename|working_dir)", x = names)
  )
  filenames <- flat_params_set[filename_indices]
  for (filename in filenames) {
    expect_true(beautier::is_one_na(filename) || peregrine::is_pff(filename))
  }
})
