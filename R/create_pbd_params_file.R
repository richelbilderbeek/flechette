#' Collect all PBD parameters of a \code{raket_werper} run and put these
#' in one \code{.csv} file called \code{results/pbd_params.csv}
#' @inheritParams default_params_doc
#' @return the name of the file created
#' @author Richel J.C. Bilderbeek
#' @export
create_pbd_params_file <- function(
  project_folder_name = get_raket_path("raket_werper")
) {
  df <- collect_pbd_params(project_folder_name) # nolint raket function
  filename <- file.path(project_folder_name, "results", "pbd_params.csv")
  dir.create(path = dirname(filename), showWarnings = FALSE, recursive = TRUE)
  write.csv(
    x = df,
    file = filename
  )
  filename
}
