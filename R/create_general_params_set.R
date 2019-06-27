#' Creates the parameter set for the general exploration
#' @inheritParams default_params_doc
#' @return a list with each element a parameter combination
#' @export
#' @author Richel Bilderbeek
create_general_params_set <- function(
  project_folder_name = getwd(),
  crown_age = 15.0,
  max_n_params = Inf,
  mcmc_chain_length = 1111000,
  n_replicates = 1,
  sequence_length = 15000
) {
  # A data frame with all combinations
  bio_params_all <- expand.grid(
    sirg = rkt_get_spec_init_rates(),
    siri = rkt_get_spec_init_rates(),
    scr = rkt_get_spec_compl_rates(),
    erg = rkt_get_ext_rates(),
    eri = rkt_get_ext_rates()
  )
  # A data frame with all viable combinations
  bio_params <- bio_params_all[
    rkt_are_viable(
      crown_age = crown_age,
      ergs = bio_params_all$erg,
      eris = bio_params_all$eri,
      scrs = bio_params_all$scr,
      sirgs = bio_params_all$sirg,
      siris = bio_params_all$siri
    ),
  ]
  # A list of all viable combinations
  pbd_paramses <- list()

  for (i in seq(1, nrow(bio_params))) {
    erg <- bio_params$erg[i]
    eri <- bio_params$eri[i]
    scr <- bio_params$scr[i]
    sirg <- bio_params$sirg[i]
    siri <- bio_params$siri[i]
    pbd_params <- becosys::create_pbd_params(
      sirg = sirg,
      siri = siri,
      scr = scr,
      erg = erg,
      eri = eri
    )
    pbd_paramses[[i]] <- pbd_params
  }
  testit::assert(length(pbd_paramses) == nrow(bio_params))

  ##############################################################################
  # Create all experiments
  ##############################################################################
  # This experiments serves as a template for all others.
  # Of the others, the unique and PFF filenames and RNG seed need to be set
  #
  #
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
  gen_experiment <- pirouette::create_gen_experiment()
  gen_experiment$inference_model$tree_prior <- beautier::create_bd_tree_prior()
  cand_experiments <- pirouette::create_all_experiments(
    exclude_model = gen_experiment$inference_model
  )
  testit::assert(length(cand_experiments) >= 39)
  experiments <- c(list(gen_experiment), cand_experiments)
  testit::assert(length(experiments) == 1 + length(cand_experiments))

  # Set an MRCA prior in all experiments
  for (i in seq_along(experiments)) {
    experiments[[i]]$inference_model$mrca_prior <- beautier::create_mrca_prior(
      is_monophyletic = TRUE,
      mrca_distr = beautier::create_normal_distr(
        mean = crown_age,
        sigma = 0.0005
      )
    )
  }
  ##############################################################################
  # Create the pirouette parameters
  ##############################################################################
  # This pir_params serves as a template for all others.
  # Of the others, the unique and PFF filenames and RNG seed need to be set
  pir_params <- pirouette::create_pir_params(
    alignment_params = pirouette::create_alignment_params(
      root_sequence = pirouette::create_blocked_dna(
        length = sequence_length
      ),
      mutation_rate = 1.0 / crown_age
    ),
    twinning_params = pirouette::create_twinning_params(),
    experiments = experiments,
    error_measure_params = pirouette::create_error_measure_params()
  )

  ##############################################################################
  # Create 'params_set'
  ##############################################################################
  # 'params_set' is the set of all parameters this function creates
  # 'index' is the current index in that list
  #   ('index' must start at one, as the BEAST2 RNG seed must be at least one)
  params_set <- list()
  index <- 1

  # Biological parameters
  for (i in seq_along(pbd_paramses)) {
    pbd_params <- pbd_paramses[[i]]

    # Create an MCMC that runs longer if there is slower convergence
    increase_factor <- 1
    if (pbd_params$scr == 1.0) {
      increase_factor <- increase_factor * 2
    }
    if (pbd_params$sirg == 0.5) {
      increase_factor <- increase_factor * 2
    }
    if (pbd_params$siri == 0.5) {
      increase_factor <- increase_factor * 2
    }
    mcmc <- beautier::create_mcmc(
      chain_length = mcmc_chain_length * increase_factor,
      store_every = 1000 * increase_factor
    )

    # Replicates
    for (i in seq(1, n_replicates)) {
      if (index > max_n_params) next


      # Set the RNG seeds, use 'index' as it is unique
      pir_params$alignment_params$rng_seed <- index
      pir_params$twinning_params$rng_seed <- index
      for (i in seq_along(experiments)) {
        pir_params$experiments[[i]]$beast2_options$rng_seed <- index
      }
      # Set the MCMCs
      for (i in seq_along(experiments)) {
        pir_params$experiments[[i]]$inference_model$mcmc <- mcmc
      }

      # Set the filenames
      pir_params$alignment_params$fasta_filename <- file.path(
        project_folder_name, index, "pbd.fasta"
      )
      pir_params$twinning_params$twin_tree_filename <- file.path(
        project_folder_name, index, "pbd_twin.tree"
      )
      pir_params$twinning_params$twin_alignment_filename <- file.path(
        project_folder_name, index, "pbd_twin.fasta"
      )
      pir_params$twinning_params$twin_evidence_filename <- file.path(
        project_folder_name, index, "pbd_marg_lik_twin.csv"
      )
      pir_params$evidence_filename <- file.path(
        project_folder_name, index, "pbd_evidence.csv"
      )
      # First and generative experiment
      pir_params$experiments[[1]]$beast2_options$input_filename <-
        file.path(project_folder_name, index, "pbd_gen.xml")
      pir_params$experiments[[1]]$beast2_options$output_log_filename <-
        file.path(project_folder_name, index, "pbd_gen.log")
      pir_params$experiments[[1]]$beast2_options$output_trees_filenames <-
        file.path(project_folder_name, index, "pbd_gen.trees")
      pir_params$experiments[[1]]$beast2_options$output_state_filename <-
        file.path(project_folder_name, index, "pbd_gen.xml.state")
      pir_params$experiments[[1]]$beast2_options$beast2_working_dir <-
        peregrine::get_pff_tempdir()
      pir_params$experiments[[1]]$errors_filename <-
        file.path(project_folder_name, index, "pbd_errors.csv")
      for (i in seq_along(experiments)[-1]) {
        testit::assert(i > 1)
        pir_params$experiments[[i]]$beast2_options$input_filename <-
          file.path(project_folder_name, index, "bd_gen.xml")
        pir_params$experiments[[i]]$beast2_options$output_log_filename <-
          file.path(project_folder_name, index, "bd_gen.log")
        pir_params$experiments[[i]]$beast2_options$output_trees_filenames <-
          file.path(project_folder_name, index, "bd_gen.trees")
        pir_params$experiments[[i]]$beast2_options$output_state_filename <-
          file.path(project_folder_name, index, "bd_gen.xml.state")
        pir_params$experiments[[i]]$beast2_options$beast2_working_dir <-
          peregrine::get_pff_tempdir()
        pir_params$experiments[[i]]$errors_filename <-
          file.path(project_folder_name, index, "bd_errors.csv")
      }

      params <- create_raket_params(
        pbd_params = pbd_params,
        pir_params = pir_params,
        sampling_method = "random"
      )
      params_set[[index]] <- params
      index <- index + 1
    }
  }
  check_raket_paramses(raket_paramses = params_set)
  params_set
}
