#' Create the set of parameters for the experiment
#' to measure the effect of sampling
#' @inheritParams create_params_set
#' @export
create_sampling_params_set <- function(
  project_folder_name = file.path(peregrine::get_pff_tempdir(), "raket_werper"),
  n_replicates = 1
) {
  # Start from the general parameters set
  general_params_set <- raket::create_general_params_set(
    project_folder_name = project_folder_name,
    n_replicates = n_replicates
  )

  if (1) {
    crown_age <- general_params_set[[1]]$pir_params$experiments[[1]]$inference_model$mrca_prior$mrca_distr$mean$value # nolint yes, no Law of Demeter here
    testit::assert(crown_age >= 0.0)

    sampling_params_set <- list()
    index <- 1
    # Each tree will have a unique RNG seed
    tree_sim_rng_seed <- 3480
    for (params in general_params_set) {
      # Remove all SCR == Inf
      if (params$pbd_params$scr >= 1000.0) next
      while (1) {
        # First seed will be 3481
        tree_sim_rng_seed <- tree_sim_rng_seed + 1
        set.seed(tree_sim_rng_seed)
        out <- becosys::pbd_sim_checked(
          erg = params$pbd_params$erg,
          eri = params$pbd_params$eri,
          scr = params$pbd_params$scr,
          sirg = params$pbd_params$sirg,
          siri = params$pbd_params$siri,
          crown_age = crown_age
        )
        sum_youngest <- sum(out$stree_youngest$edge.length)
        sum_oldest <- sum(out$stree_oldest$edge.length)
        if (sum_youngest != sum_oldest) {
          # Found one!
          sampling_params_set[[index]] <- params
          sampling_params_set[[index + 1]] <- params
          sampling_params_set[[index]]$tree_sim_rng_seed <- tree_sim_rng_seed
          sampling_params_set[[index + 1]]$tree_sim_rng_seed <- 
            tree_sim_rng_seed
          sampling_params_set[[index]]$sampling_method <- "shortest"
          sampling_params_set[[index + 1]]$sampling_method <- "longest"
          index <- index + 2
          break() # nolint lintr wants 'break ()', RStudio wants like this. I prefer RStudio's
        }
      }
    }
    check_raket_paramses(raket_paramses = sampling_params_set) # nolint raket function
    sampling_params_set
  }
  general_params_set
}
