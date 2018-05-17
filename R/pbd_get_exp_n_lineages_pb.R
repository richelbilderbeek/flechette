#' Get the expected number of good and incipient lineages from a protracted 
#' pure birth model
#' @param sirg The speciation initiation rate from a good species
#' @param scr The speciation completion rate
#' @param siri The speciation initiation rate from an incipient species
#' @param age The age
#' @param Ng The number of good species at t=0
#' @param Ni The number of incipient species at t=0
#' @export
#' @author Joris Damhuis
pbd_get_exp_n_lineages_pb <- function(
  sirg,
  scr,
  siri,
  age,
  Ng,
  Ni
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
  if (Ng < 0.0) {
    stop("'Ng' must be zero or positive")
  } else if (Ng == 0.0) {
    if (Ni < 0.0) {
      stop("'Ni' must be zero or positive")
    } else if (Ni == 0.0) {
      stop("One of 'Ng' and 'Ni' must be non-zero")
    }
  } else {
    if (Ni < 0.0) {
      stop("'Ni' must be zero or positive")
    } else if (Ni > 0.0) {
      stop("Only one of 'Ng' and 'Ni' can be non-zero")
    }
  }
  
  A <- sqrt(((1-(siri/scr))^2)+(4*(sirg/scr)))
  
  if (Ng > 0.0) {
    exp_Ng <- (Ng/(2*A))*((A+1-(siri/scr))*exp(0.5*(siri+(A-1)*scr)*age)+(A-1+(siri/scr))*exp(0.5*(siri-(A+1)*scr)*age))
    exp_Ni <- (Ng/A)*(sirg/scr)*(exp(0.5*(siri+(A-1)*scr)*age)-exp(0.5*(siri-(A+1)*scr)*age))
  } else {
    exp_Ng <- (Ni/(1+(sirg/scr)))*(exp(sirg*age)-exp(-scr*age))
    exp_Ni <- (Ni/(1+(scr/sirg)))*exp(sirg*age)+(Ni/(1+(sirg/scr)))*exp(-scr*age)
  }
  
  cat("Expected number of good lineages:", exp_Ng, "|||", "Expected number of incipient lineages:", exp_Ni)
  
}