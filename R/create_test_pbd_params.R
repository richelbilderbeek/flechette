#' Creates testing PBD params, using \link[becosys]{create_pbd_params}
#' with some parameters that are not that speciose
#' @inheritParams default_params_doc
#' @author Richèl J.C. Bilderbeek
#' @examples
#' library(testthat)
#'
#' pbd_params <- create_test_pbd_params()
#' expect_silent(becosys::check_pbd_params(pbd_params))
#' @export
create_test_pbd_params <- function(
  sirg = 0.1,
  siri = 0.15,
  scr = 0.2,
  erg = 0.01,
  eri = 0.02
) {
  becosys::create_pbd_params(
    erg = erg,
    eri = eri,
    scr = scr,
    sirg = sirg,
    siri = siri
  )
}
