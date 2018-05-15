#' Create a skeleton data frame for each data set
#' @param n_files number of parameter files
#' @param n_nltts number of nLTT statistics per file
#' @export
rkt_create_data_frame <- function(
  n_files,
  n_nltts
) {
  #n_repeats <- rkt_get_max_n_rows() / 144
  length(create_general_params_set())
  
  df <- 
  df_params <- data.frame(
    sirg = stats::runif(n = n_files),
    siri = stats::runif(n = n_files),
    scr = stats::runif(n = n_files),
    erg = stats::runif(n = n_files),
    eri = stats::runif(n = n_files),
    crown_age = rep(15, n_files),
    crown_age_sigma = rep(0.01, n_files),
    sampling_method = rep(
      c("shortest", "longest", "random"),
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
