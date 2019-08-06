#' Create testing PBD parameter sets
#' @return a list of \code{pbd_params}
#' @export
create_test_pbd_paramses <- function() {

  pbd_paramses <- list()
  index <- 1

  for (extinction_rate in c(0.0, 0.1)) {
    for (speciation_rate in c(0.2, 0.4)) {
      for (completion_rate in c(0.1, 1, 1e6)) {
        pbd_params <- becosys::create_pbd_params(
          sirg = speciation_rate,
          siri = speciation_rate,
          scr = completion_rate,
          erg = extinction_rate,
          eri = extinction_rate
        )
        pbd_paramses[[index]] <- pbd_params
        index <- index + 1
      }
    }
  }
  pbd_paramses
}
