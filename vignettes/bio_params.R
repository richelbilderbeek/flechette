## ----setup, include = FALSE----------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## ------------------------------------------------------------------------
df_all <- rkt_create_data_frame(
  n_replicates = 1,
  n_nltts = 1,
  experiment_type = "general"
)
df_bio <- dplyr::select(df_all, erg, eri, scr, sirg, crown_age)
df_bio <- dplyr::rename(df_bio, sir = sirg)
df_bio <- dplyr::distinct(df_bio)
names(df_bio)
df <- df_bio
df$mean_n_species <- PBD::pbd_numspec_mean_checked(df$erg, df$eri, df$scr, df$sir, df$crown_age)

