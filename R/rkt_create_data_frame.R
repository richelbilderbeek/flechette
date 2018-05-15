#' Create a skeleton data frame for each data set
#' @param n_files number of parameter files
#' @param n_nltts number of nLTT statistics per file
#' @param experiment_type type of experiment,
#'   must be either 'general' or 'sampling' 
#' @export
rkt_create_data_frame <- function(
  n_files,
  n_nltts,
  experiment_type
) {
  testit::assert(experiment_type %in% c("general", "sampling"))

  sampling_options <- c("random")
  if (experiment_type == "sampling") {
    sampling_options <- c("shortest", "longest")
  }

  df_params <- data.frame(
    sirg = sample(rkt_get_spec_init_rates(), size = n_files, replace = TRUE),
    siri = sample(rkt_get_spec_init_rates(), size = n_files, replace = TRUE),
    scr = sample(rkt_get_spec_compl_rates(), size = n_files, replace = TRUE),
    erg = sample(rkt_get_ext_rates(), size = n_files, replace = TRUE),
    eri = sample(rkt_get_ext_rates(), size = n_files, replace = TRUE),
    crown_age = rep(15, n_files),
    crown_age_sigma = rep(0.01, n_files),
    sampling_method = rep(
      sampling_options,
      length.out = n_files
    ),
    mutation_rate = rep(66, n_files),
    sequence_length = rep(150, n_files),
    mcmc.chain_length = rep(4000, n_files),
    mcmc.store_every = rep(1000, n_files),
    tree_sim_rng_seed = seq(1, n_files),
    alignment_rng_seed = seq(1, n_files),
    beast2_rng_seed = seq(1, n_files)
  )
  df_nltts <- data.frame(
    matrix(
      data = stats::runif(n = n_files * n_nltts),
      nrow = n_files,
      ncol = n_nltts
    )
  )
  colnames(df_nltts) <- paste0("X.", seq(0, n_nltts - 1))
  colnames(df_nltts)[1] <- "X"
  df <- cbind(df_params, df_nltts)

  # Deallocate memory, these data frames can be very big
  rm(df_params)
  rm(df_nltts)
  gc()

  df
}
