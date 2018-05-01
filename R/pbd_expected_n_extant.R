#' Get the median of the number of extant species from a PBD process.
#' @param crown_age the crown age
#' @param scr speciation completion rate
#' @param sirg speciation initiation rate of a good species
#' @param siri speciation initiation rate of an incipient species
#' @param erg extinction rate of a good species
#' @param eri extinction rate of an incipient species
#' @param n_sims number of PBD simulations to take the median of. The
#'   higher this number, the error on this calculation is decreased
#' @export
#' @author Richel J.C. Bilderbeek
pbd_expected_n_extant <- function(
  crown_age, 
  scr, 
  sirg, 
  siri, 
  erg, 
  eri,
  n_sims = 10
) { 
  # Add more stops later, hopefully by students :-)
  if (crown_age <= 0.0) {
    stop("'crown age' must be non-zero and positive")
  }
  testit::assert(scr >= 0.0)
  testit::assert(sirg >= 0.0)
  testit::assert(siri >= 0.0)
  testit::assert(erg >= 0.0)
  testit::assert(eri >= 0.0)
  testit::assert(n_sims >= 1)
  
  n_lineages <- rep(NA, n_sims)
  for (i in seq(1, n_sims)) {
    out <- PBD::pbd_sim(pars = c(sirg, scr, siri, erg, eri), age = crown_age, soc = 2)
    n_lineages[i] <- length(out$stree_random$tip.label)
  }
  stats::median(n_lineages)
}
