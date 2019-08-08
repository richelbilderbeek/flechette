context("test-run_raket_from_file")

test_that("use", {

  if (!beastier::is_on_travis()) return()

  super_folder_name <- peregrine::get_pff_tempdir()
  project_folder_name <- file.path(super_folder_name, "raket_werper")
  dir.create(path = project_folder_name, recursive = TRUE, showWarnings = FALSE)


  Rprof("~/profile.out")
  parameters_filenames <- create_files_raket_paramses(
    general_params_set = create_test_params_set(),
    project_folder_name = project_folder_name
  )
  Rprof(NULL); summaryRprof("~/profile.out")

  for (i in seq_along(parameters_filenames)) {
    print(parameters_filenames[i])
    expect_silent(
      run_raket_from_file(
        parameters_filename = parameters_filenames[i]
      )
    )
  }
})

test_that("abuse", {

  parameters_filename <- "neverland"
  expect_error(
    run_raket_from_file(
      parameters_filename = parameters_filename
    )
  )
})
