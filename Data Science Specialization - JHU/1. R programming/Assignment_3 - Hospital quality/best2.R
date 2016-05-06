best <- function(state, outcome) {
  ## Read outcome data
  read_data <- read.csv("outcome-of-care-measures.csv", sep = ",")
  
  ## Check that state and outcome are valid
  valid_state <- c("AL", "AK", "AZ", "AR", "CA", "CO", "CT", "DE", "FL", "GA", "HI", "ID", "IL", "IN", "IA", "KS", "KY", "LA", "ME", "MD", "MA", "MI", "MN", "MS", "MO", "MT", "NE", "NV", "NH", "NJ", "NM", "NY", "NC", "ND", "OH", "OK", "OR", "PA", "RI", "SC", "SD", "TN", "TX", "UT", "VT", "VA", "WA", "WV", "WI", "WY")
  valid_outcome <- c("heart attack", "heart failure", "pneumonia")
  if (!is.element(state, valid_state)) stop("invalid state")
  if (!is.element(outcome, valid_outcome)) stop("invalid outcome")
  
  ## Return hospital name in that state with lowest 30-day death
  ## rate
  data <- read_data[read_data$State == state,]
  outcome_name <- NULL
  if (outcome == "heart attack") {
    outcome_name <- "Hospital.30.Day.Death..Mortality..Rates.from.Heart.Attack"
  } else if (outcome == "heart failure") {
    outcome_name <- "Hospital.30.Day.Death..Mortality..Rates.from.Heart.Failure"
  } else {
    outcome_name <- "Hospital.30.Day.Death..Mortality..Rates.from.Pneumonia"
  }
  death_rate <- data[,outcome_name]
  death_rate <- death_rate[!death_rate == "Not Available"]
  death_rate <- as.numeric(as.character(death_rate))
  min_rate <- min(death_rate)
  best_hospital <- data[data[,outcome_name] == min_rate,]
  hospital_name <- sort(best_hospital[,"Hospital.Name"])
  return(as.character(hospital_name[1]))
}