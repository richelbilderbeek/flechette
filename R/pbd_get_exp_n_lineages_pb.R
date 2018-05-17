#' Get the expected number of good and incipient lineages from a protracted
#' pure birth model
#' @param sirg The speciation initiation rate from a good species
#' @param scr The speciation completion rate
#' @param siri The speciation initiation rate from an incipient species
#' @param age The age
#' @param ng The number of good species at t=0
#' @param ni The number of incipient species at t=0
#' @export
#' @author Joris Damhuis
pbd_get_exp_n_lineages_pb <- function(
  sirg,
  scr,
  siri,
  age,
  ng,
  ni
) {
  if (sirg <= 0.0) {
    stop("'sirg' must be non-zero and positive")
  }
  if (scr < 0.0) {
    stop("'scr' must be non-zero and positive")
  }
  if (siri <= 0.0) {
    stop("'siri' must be non-zero and positive")
  }
  if (age <= 0.0) {
    stop("'age' must be non-zero and positive")
  }
  if (ng < 0.0) {
    stop("'ng' must be zero or positive")
  } else if (ng == 0.0) {
    if (ni < 0.0) {
      stop("'ni' must be zero or positive")
    } else if (ni == 0.0) {
      stop("One of 'ng' and 'ni' must be non-zero")
    }
  } else {
    if (ni < 0.0) {
      stop("'ni' must be zero or positive")
    } else if (ni > 0.0) {
      stop("Only one of 'ng' and 'ni' can be non-zero")
    }
  }

  a <- sqrt( ( (1 - (siri / scr)) ^ 2) + (4 * (sirg / scr)))

  if (ng > 0.0) {
    exp_ng <- (ng / (2 * a)) * ( (a + 1 - (siri / scr)) * exp(0.5 * (siri +
              (a - 1) * scr) * age) + (a - 1 + (siri / scr)) * exp(0.5 *
              (siri - (a + 1) * scr) * age))
    exp_ni <- (ng / a) * (sirg / scr) * (exp(0.5 * (siri + (a - 1) * scr) *
              age) - exp(0.5 * (siri - (a + 1) * scr) * age))
  } else {
    exp_ng <- (ni / (1 + (sirg / scr))) * (exp(sirg * age) - exp(- scr * age))
    exp_ni <- (ni / (1 + (scr / sirg))) * exp(sirg * age) +
              (ni / (1 + (sirg / scr))) * exp(- scr * age)
  }

  cat("Expected number of good lineages:", exp_ng, "|||",
      "Expected number of incipient lineages:", exp_ni)

}
