context("test-run_raket_from_file")

test_that("use", {

  if (!beastier::is_on_travis()) return()

  # super_folder_name <- get_pff_tempdir()
  # project_folder_name <- file.path(super_folder_name, "raket_project")
  project_folder_name <- file.path(system.file("extdata", package = "raket"), "raket_werper")
  dir.create(path = project_folder_name, recursive = TRUE, showWarnings = FALSE)
  parameters_filenames <- create_files_raket_paramses(
    general_params_set = create_general_params_set(n_replicates = 1, max_n_params = 2),
    project_folder_name = project_folder_name
  )

  # Only run the first
  for (i in seq_along(parameters_filenames)) {
    expect_silent(run_raket_from_file(
      parameters_filename = parameters_filenames[i]
    ))
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
