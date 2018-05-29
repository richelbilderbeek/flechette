#' Is this a viable parameter combination?
#' @param crown_age crown age
#' @param erg extinction rate of a good species
#' @param eri extinction rate of an incipient species
#' @param scr speciation completion rate
#' @param sirg speciation initiation rate of a good species
#' @param siri speciation initiation rate of an incipient species
#' @param quantile the quantile, a value from, and including, zero to one
#' @export
rkt_is_viable <- function(
  crown_age,
  erg,
  eri,
  scr,
  sirg,
  siri,
  quantile = 0.95
) {
  if (erg >= sirg) return(FALSE)
  if (eri >= siri) return(FALSE)
  sir <- max(sirg, siri)
  if (raket::pbd_numspec_quantile_checked(
      sir = sir,
      scr = scr,
      erg = erg,
      eri = eri,
      crown_age = crown_age,
      quantile = 0.95
    ) > 1000
  ) return(FALSE)
  TRUE
}
