context("create_input_files")

test_that("files are created in right folder", {

  # Put files in temporary folder
  super_folder_name <- peregrine::get_pff_tempdir()
  project_folder_name <- file.path(super_folder_name, "raket_werper")
  skip("Issue 40, Issue #40")
  filenames <- create_input_files_general(
    create_general_params_set(
      project_folder_name = project_folder_name,
      n_replicates = 1
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
