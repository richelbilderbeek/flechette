#' Check if the \code{raket_params} is a list with all the required elements
#' @export
check_raket_params_list_elements <- function( # nolint indeed long function, which is fine for an internal function
  raket_params
) {
  argument_names <- c(
    "pbd_params",
    "pir_params",
    "sampling_method",
    "true_tree_filename",
    "pbd_sim_out_filename"
  )
  for (arg_name in argument_names) {
    if (!arg_name %in% names(raket_params)) {
      stop(
        "'", arg_name, "' must be an element of a 'raket_params'"
      )
    }
  }
}
