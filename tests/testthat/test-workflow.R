context("workflow")

test_that("Full workflow, general", {

  skip("No full workflow")

  if (!beastier::is_on_travis()) return()
  super_folder_name <- peregrine::get_pff_tempdir()
  project_folder_name <- file.path(super_folder_name, "raket_werper")

  ##############################################################################
  # 2 Create all `.RDa` parameter files
  ##############################################################################

  parameter_filenames <- create_input_files_test(
    create_test_params_set(project_folder_name)
  )

  ##############################################################################
  # 2 Run simulation, store all info (such as all posterior phylogenies) as .RDa
  ##############################################################################

  for (parameter_filename in parameter_filenames) {
    rkt_run_from_file(parameter_filename)
  }

  ##############################################################################
  # 7. Collect the nLTT statistics
  ##############################################################################
  razzo::collect_nltt_stats(
    project_folder_name = project_folder_name
  )

  ##############################################################################
  # 10. Show figure 1
  ##############################################################################
  testthat::expect_silent(create_fig_1(df_long))
})
