#' Create the general PBD parameter sets
#' @return a list of \code{pbd_params}
#' @export
create_general_pbd_paramses <- function() {

  pbd_paramses <- list()
  index <- 1
  for (extinction_rate in rkt_get_ext_rates()) {
    for (speciation_rate in rkt_get_spec_init_rates()) {
      for (completion_rate in rkt_get_spec_compl_rates()) {
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
