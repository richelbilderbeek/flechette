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
#' @param add_shortest_and_longest Gives the output of the new samplemethods
#'   'shortest' and 'longest'.
#' @export
pbd_sim_checked <- function(
  erg,
  eri,
  scr,
  sirg,
  siri,
  stem_age = NULL,
  crown_age = NULL,
  max_n_taxa = Inf,
  add_shortest_and_longest = FALSE
) {
  PBD::pbd_sim_checked(
    erg = erg,
    eri = eri,
    scr = scr,
    sirg = sirg,
    siri = siri,
    stem_age = stem_age,
    crown_age = crown_age,
    max_n_taxa = max_n_taxa,
    add_shortest_and_longest = add_shortest_and_longest
  )
}
