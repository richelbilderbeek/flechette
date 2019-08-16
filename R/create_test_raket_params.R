#' Create a test \code{raket_params}
#'
#' @inheritParams default_params_doc
#' @return a test \code{raket_params},
#'   as can be created by \link{create_raket_params}
#' @export
#' @author Richel J.C. Bilderbeek
create_test_raket_params <- function() {
  folder_name <- peregrine::get_pff_tempdir()
  crown_age <- 15.0
  crown_age_sigma <- 0.01
  pbd_params <- create_test_pbd_params() # nolint raket function
  twinning_params <- pirouette::create_twinning_params(
    twin_tree_filename = file.path(folder_name, "pbd_twin.newick"),
    twin_alignment_filename = file.path(folder_name, "pbd_twin.fasta"),
    twin_evidence_filename = file.path(folder_name, "pbd_marg_lik_twin.csv")
  )

  alignment_params <- pirouette::create_alignment_params(
    root_sequence = pirouette::create_blocked_dna(length = 32),
    mutation_rate = 0.12,
    fasta_filename = file.path(folder_name, "pbd.fasta")
  )
  ##############################################################################
  # Create all experiments
  ##############################################################################
  #
  # +-----+-----+------+-----+
  # |     |site |clock |tree |
  # |type |model|model |prior|
  # +-----+-----+------+-----+
  # |gen  |JC   |strict|BD   |
  # +-----+-----+------+-----+
  # |cand | .. all others .. |
  # +-----+-----+------+-----+
  #
  gen_experiment <- peregrine::create_test_pff_gen_experiment()
  gen_experiment$inference_model$site_model <-
    beautier::create_jc69_site_model()
  gen_experiment$inference_model$clock_model <-
    beautier::create_strict_clock_model()
  gen_experiment$inference_model$tree_prior <-
    beautier::create_yule_tree_prior()
  gen_experiment$inference_model$mcmc <- beautier::create_mcmc(
    chain_length = 2000, store_every = 1000
  )
  gen_experiment$beast2_options$input_filename <-
    file.path(folder_name, "pbd_gen.xml")
  gen_experiment$beast2_options$output_log_filename <-
    file.path(folder_name, "pbd_gen.log")
  gen_experiment$beast2_options$output_trees_filenames <-
    file.path(folder_name, "pbd_gen.trees")
  gen_experiment$beast2_options$output_state_filename <-
    file.path(folder_name, "pbd_gen.xml.state")
  gen_experiment$errors_filename <-
    file.path(folder_name, "pbd_nltts_gen.csv")

  first_mcmc <- gen_experiment$inference_model$mcmc
  peregrine::check_pff_experiment(gen_experiment)

  # Candidate experiments
  cand_experiments <- peregrine::create_all_pff_experiments(
    exclude_model = gen_experiment$inference_model
  )[1:2]
  cand_experiments[[1]]$inference_model$site_model <-
    beautier::create_jc69_site_model()
  cand_experiments[[1]]$inference_model$clock_model <-
    beautier::create_strict_clock_model()
  cand_experiments[[1]]$inference_model$tree_prior <-
    beautier::create_bd_tree_prior()
  cand_experiments[[1]]$beast2_options$input_filename <-
    file.path(folder_name, "pbd_best.xml")
  cand_experiments[[1]]$beast2_options$output_log_filename <-
    file.path(folder_name, "pbd_best.log")
  cand_experiments[[1]]$beast2_options$output_trees_filenames <-
    file.path(folder_name, "pbd_best.trees")
  cand_experiments[[1]]$beast2_options$output_state_filename <-
    file.path(folder_name, "pbd_best.xml.state")
  cand_experiments[[1]]$errors_filename <-
    file.path(folder_name, "pbd_nltts_best.csv")
  cand_experiments[[2]] <- cand_experiments[[1]]

  cand_experiments[[2]]$inference_model$site_model <-
    beautier::create_hky_site_model()
  cand_experiments[[2]]$inference_model$clock_model <-
    beautier::create_strict_clock_model()
  cand_experiments[[2]]$inference_model$tree_prior <-
    beautier::create_yule_tree_prior()

  for (i in seq_along(cand_experiments)) {
    cand_experiments[[i]]$beast2_options <- cand_experiments[[1]]$beast2_options
    cand_experiments[[i]]$inference_model$mcmc <- first_mcmc
  }
  peregrine::check_pff_experiments(cand_experiments)
  testit::assert(length(cand_experiments) >= 1)
  experiments <- c(list(gen_experiment), cand_experiments)
  testit::assert(length(experiments) == 1 + length(cand_experiments))

  # Set an MRCA prior in all experiments
  for (i in seq_along(experiments)) {
    experiments[[i]]$inference_model$mrca_prior <- beautier::create_mrca_prior(
      is_monophyletic = TRUE,
      mrca_distr = beautier::create_normal_distr(
        mean = crown_age,
        sigma = crown_age_sigma
      )
    )
  }
  peregrine::check_pff_experiments(experiments)

  error_measure_params <- pirouette::create_error_measure_params()
  sampling_method <- "shortest"

  raket_params <- create_raket_params(
    pbd_params = pbd_params,
    pir_params = pirouette::create_pir_params(
      twinning_params = twinning_params,
      alignment_params = alignment_params,
      experiments = experiments,
      error_measure_params = error_measure_params,
      evidence_filename = file.path(folder_name, "pbd_marg_lik.csv")
    ),
    sampling_method = sampling_method,
    true_tree_filename = file.path(folder_name, "pbd.newick"),
    pbd_sim_out_filename = file.path(folder_name, "pbd_sim_out.RDa")
  )

  check_raket_params(raket_params) # nolint raket function
  raket_params
}
