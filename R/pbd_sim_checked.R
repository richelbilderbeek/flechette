#' Checked and safer version of PBD::pbd_sim
#' @param erg extinction rate of a good species
#' @param eri extinction rate of an incipient species
#' @param scr speciation completion rate
#' @param sirg speciation initiation rate of a good species
#' @param siri speciation initiation rate of an incipient species
#' @param stem_age stem age. Set either the stem age or the crown age.
#' @param crown_age crown age. Set either the stem age or the crown age.
#' @param max_n_taxa maximum number of taxa. If this value is exceeded,
#'   the simulation is aborted and removed.
pbd_sim_checked <- function(
  erg,
  eri,
  scr,
  sirg,
  siri,
  stem_age = NULL,
  crown_age = NULL,
  max_n_taxa = Inf
) {
  # TODO: use if and stop
  testit::assert(erg >= 0.0)
  testit::assert(eri >= 0.0)
  testit::assert(sirg >= 0.0)
  testit::assert(siri >= 0.0)
  testit::assert(scr >= 0.0)
  testit::assert(xor(is.null(crown_age), is.null(stem_age)))
  testit::assert(max_n_taxa >= 0.0)

  # age
  age <- stem_age
  if (is.null(age)) age <- crown_age
  testit::assert(!is.null(age))
  testit::assert(age > 0.0)

  # soc
  soc <- 1
  if (!is.null(crown_age)) soc <- 2
  testit::assert(!is.null(soc))
  testit::assert(soc == 1 || soc == 2)

  PBD::pbd_sim(
    pars = c(sirg, scr, siri, erg, eri),
    age = age,
    soc = soc,
    plotit = FALSE,
    limitsize = max_n_taxa
  )
}
