test_that("files are created in right folder", {

  # Put files in temporary folder
  super_folder_name <- tempdir()
  project_folder_name <- file.path(super_folder_name, "raket_werper")
  # Do not warn if the folder already exists
  dir.create(path = project_folder_name, showWarnings = FALSE)

  filenames <- create_input_files_test(
    test_params_set = create_test_params_set(),
    folder_name = project_folder_name
  )

  skip("Issue 42, Issue #42")
  first_parameters <- readRDS(filenames[1])
  expect_false(
    is.na(
      stringr::str_match(
        string = first_parameters$pbd_sim_out_filename,
        pattern = super_folder_name
      )
    )
  )

  # The folder structure created:
  # * raket_werper (the name of the GitHub containing the scripts)
  #   * scripts
  #   * data
  #   * figures

  # OK: Parameter filenames are a number with a .RDa
  expect_true(
    length(
      grep(
        pattern = "[[:digit:]]?\\.RDa$", filenames[1], perl = TRUE, value = TRUE
      )
    ) > 0
  )
  # OK: there is a data folder that is a subfolder of razzo_project'
  # Use ..? to indicate one or two back- or normal slashes
  expect_true(
    length(
      grep(
        pattern = "raket_werper..?data",
        filenames[1], perl = TRUE, value = TRUE
      )
    ) > 0
  )
})
