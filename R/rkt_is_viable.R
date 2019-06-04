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
  testit::assert(crown_age >= 0)
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

#' Are these viable parameter combinations?
#' @inheritParams default_params_doc
#' @export
rkt_are_viable <- function(
  crown_age,
  ergs,
  eris,
  scrs,
  sirgs,
  siris,
  quantile = 0.95
) {
  testit::assert(crown_age > 0.0)
  testit::assert(length(ergs) == length(eris))
  testit::assert(length(ergs) == length(scrs))
  testit::assert(length(ergs) == length(sirgs))
  testit::assert(length(ergs) == length(siris))
  n <- length(ergs)
  viables <- rep(NA, n)
  for (i in seq_along(ergs)) {
    viables[i] <- rkt_is_viable(
      crown_age = crown_age,
      erg = ergs[i],
      eri = eris[i],
      scr = scrs[i],
      sirg = sirgs[i],
      siri = siris[i],
      quantile = quantile
    )
  }
  viables
}
