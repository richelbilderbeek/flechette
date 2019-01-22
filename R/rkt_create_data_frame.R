#' Create a skeleton data frame for each data set
#' @param n_replicates number of replicates
#' @param n_nltts number of nLTT statistics per file
#' @param experiment_type type of experiment,
#'   must be either 'general' or 'sampling'
#' @param max_n_params the maximum number of parameters created. Set to a lower
#'   value in debugging
#' @export
rkt_create_data_frame <- function(
  n_replicates,
  n_nltts,
  experiment_type,
  max_n_params = Inf
) {
  testit::assert(experiment_type %in%
    raket::rkt_get_experiment_types()
  )
  params_set <- NULL
  if (experiment_type == "general") {
    params_set <- raket::create_general_params_set(
      n_replicates = n_replicates,
      max_n_params = max_n_params
    )
  } else {
    testit::assert(experiment_type == "sampling")
    params_set <- raket::create_sampling_params_set(
      n_replicates = n_replicates,
      max_n_params = max_n_params
    )
  }
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
    mcmc_chain_length = rep(NA, n_rows),
    mcmc_store_every = rep(NA, n_rows),
    tree_sim_rng_seed = seq(1, n_rows),
    alignment_rng_seed = seq(1, n_rows),
    beast2_rng_seed = seq(1, n_rows),
    site_model = rep(NA, n_rows),
    clock_model = rep(NA, n_rows)
  )
  for (i in seq_along(params_set)) {
    # Conversion to string here
    df_params[i, 1:raket::rkt_get_n_params()] <- unlist(params_set[[i]])
  }
  df_params$sirg <- as.numeric(df_params$sirg)
  df_params$siri <- as.numeric(df_params$siri)
  df_params$scr <- as.numeric(df_params$scr)
  df_params$erg <- as.numeric(df_params$erg)
  df_params$eri <- as.numeric(df_params$eri)
  df_params$crown_age <- as.numeric(df_params$crown_age)
  df_params$crown_age_sigma <- as.numeric(df_params$crown_age_sigma)
  df_params$mutation_rate <- as.numeric(df_params$mutation_rate)
  df_params$sequence_length <- as.numeric(df_params$sequence_length)
  df_params$mcmc_chain_length <- as.numeric(df_params$mcmc_chain_length)
  df_params$mcmc_store_every <- as.numeric(df_params$mcmc_store_every)
  df_params$tree_sim_rng_seed <- as.numeric(df_params$tree_sim_rng_seed)
  df_params$alignment_rng_seed <- as.numeric(df_params$alignment_rng_seed)
  df_params$beast2_rng_seed <- as.numeric(df_params$beast2_rng_seed)
  levels(df_params$sampling_method) <- c(
    "random", "shortest", "longest", "oldest", "youngest"
  )
  df_params$sampling_method <- as.factor(df_params$sampling_method)
  df_params$site_model <- as.factor(df_params$site_model)
  df_params$clock_model <- as.factor(df_params$clock_model)
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
  testit::assert(is.factor(df$sampling_method))
  testit::assert(is.factor(df$site_model))
  testit::assert(is.factor(df$clock_model))

  # Deallocate memory, these data frames can be very big
  rm(df_params)
  rm(df_nltts)
  gc()

  df
}
