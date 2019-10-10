#' Collect the PBD parameters from a \code{raket} experiment
#' @inheritParams default_params_doc
#' @return a data frame the folder names and PBD parameters
#' @author Richel J.C. Bilderbeek
#' @export
collect_pbd_params <- function(
  project_folder_name
) {
  raket::check_project_folder_name(project_folder_name)
  param_filenames <- list.files(
    path = project_folder_name,
    pattern = "parameters\\.RDa$",
    full.names = TRUE,
    recursive = TRUE
  )
  # Folder names must be relative and always start with 'data/'
  folder_names <- stringr::str_match(
    string = dirname(param_filenames),
    pattern = "data/.*?$"
  )[, 1]

  first_param_filename <- param_filenames[1]
  first_raket_params <- readRDS(first_param_filename)
  first_raket_pbd_params <- first_raket_params$pbd_params

  df <- data.frame(folder = folder_names, stringsAsFactors = FALSE)
  df$erg <- NA
  df$eri <- NA
  df$scr <- NA
  df$sirg <- NA
  df$siri <- NA
  colnames(df) <- c("folder", names(first_raket_pbd_params))

  for (i in seq_along(param_filenames)) {
    filename <- param_filenames[i]
    raket_params <- readRDS(filename)
    raket::check_raket_params(raket_params)
    pbd_params <- raket_params$pbd_params
    df$erg[i] <- pbd_params$erg
    df$eri[i] <- pbd_params$eri
    df$scr[i] <- pbd_params$scr
    df$sirg[i] <- pbd_params$sirg
    df$siri[i] <- pbd_params$siri
  }
  df
}
