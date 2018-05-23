#' Is this a viable parameter combination?
#' @param erg extinction rate of a good species
#' @param eri extinction rate of an incipient species
#' @param sirg speciation initiation rate of a good species
#' @param siri speciation initiation rate of an incipient species
#' @export
rkt_is_viable <- function(
  erg,
  eri,
  sirg,
  siri
) {
  if (erg >= sirg) return(FALSE)
  if (eri >= siri) return(FALSE)
  if (siri - eri >= 0.5) return(FALSE)
  if (sirg - erg >= 0.5) return(FALSE)
  TRUE
}
