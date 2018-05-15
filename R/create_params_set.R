#' Create the set of parameters to use, for each of the
#' two experiment types
#' @param experiment_type type of experiment,
#'   must be either 'general' or 'sampling' 
#' @export
create_params_set <- function(experiment_type) {
  testit::assert(experiment_type %in% rkt_get_experiment_types())
  if (experiment_type == "general") {
    create_general_params_set()
  } else {
    create_sampling_params_set()
  }
}
