#' Create a skeleton data frame for each data set
#' @param n_replicates number of replicates
#' @param n_nltts number of nLTT statistics per file
#' @param experiment_type type of experiment,
#'   must be either 'general' or 'sampling' 
#' @export
rkt_create_data_frame <- function(
  n_replicates,
  n_nltts,
  experiment_type
) {
  testit::assert(experiment_type %in% rkt_get_experiment_types())
  if (experiment_type != "general") return (NULL) # temporary

  params_set <- create_general_params_set(n_replicates = n_replicates)
  n_rows <- length(params_set)

  df_params <- data.frame(
    sirg = rep(NA, n_rows),
    siri = rep(NA, n_rows),
    scr = rep(NA, n_rows),
    erg = rep(NA, n_rows),
    eri = rep(NA, n_rows),
    crown_age = rep(NA, n_rows),
    crown_age_sigma = rep(NA, n_rows),
    sampling_method = rep(NA, n_rows),
    mutation_rate = rep(NA, n_rows),
    sequence_length = rep(NA, n_rows),
    mcmc.chain_length = rep(NA, n_rows),
    mcmc.store_every = rep(NA, n_rows),
    tree_sim_rng_seed = seq(1, n_rows),
    alignment_rng_seed = seq(1, n_rows),
    beast2_rng_seed = seq(1, n_rows)
  )
  levels(df_params$sampling_method) <- c("random", "shortest", "longest")
  for (i in seq_along(params_set)) {
    df_params[i, 1:rkt_get_n_params()] <- unlist(params_set[[i]])
  }
  df_nltts <- data.frame(
    matrix(
      data = stats::runif(n = n_rows * n_nltts),
      nrow = n_rows,
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
