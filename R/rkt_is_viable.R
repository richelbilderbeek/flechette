#' Is this a viable parameter combination?
#' @inheritParams default_params_doc
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
  if (becosys::pbd_numspec_quantile_checked(
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
