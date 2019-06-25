#' Checks if the \code{sampling_method} is a valid
#' sampling method. See \link{rkt_get_sampling_methods}
#' for a vector of valid sampling methods
#' @inheritParams default_params_doc
#' @export
check_sampling_method <- function(sampling_method) {
  if (length(sampling_method) != 1) {
    stop(
      "'sampling_method' must be one sampling method. \n",
      "Actual value: ", sampling_method
    )
  }
  if (!sampling_method %in% rkt_get_sampling_methods()) {
    stop(
      "'sampling_method' must be a sampling method. \n",
      "Actual value: ", sampling_method
    )
  }
}
