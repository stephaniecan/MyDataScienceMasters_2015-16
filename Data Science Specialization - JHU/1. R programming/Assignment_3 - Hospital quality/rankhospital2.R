rankhospital <- function(state, outcome, num = "best") {
  ## Read outcome data
  read_data <- read.csv("outcome-of-care-measures.csv", sep = ",")
  
  ## Check that state and outcome are valid
  valid_state <- c("AL", "AK", "AZ", "AR", "CA", "CO", "CT", "DE", "FL", "GA", "HI", "ID", "IL", "IN", "IA", "KS", "KY", "LA", "ME", "MD", "MA", "MI", "MN", "MS", "MO", "MT", "NE", "NV", "NH", "NJ", "NM", "NY", "NC", "ND", "OH", "OK", "OR", "PA", "RI", "SC", "SD", "TN", "TX", "UT", "VT", "VA", "WA", "WV", "WI", "WY")
  valid_outcome <- c("heart attack", "heart failure", "pneumonia")
  if (!is.element(state, valid_state)) stop("invalid state")
  if (!is.element(outcome, valid_outcome)) stop("invalid outcome")
  
  ## Return hospital name in that state with the given rank
  ## 30-day death rate
  data <- read_data[read_data$State == state,]
  outcome_name <- NULL
  if (outcome == "heart attack") {
    outcome_name <- "Hospital.30.Day.Death..Mortality..Rates.from.Heart.Attack"
  } else if (outcome == "heart failure") {
    outcome_name <- "Hospital.30.Day.Death..Mortality..Rates.from.Heart.Failure"
  } else {
    outcome_name <- "Hospital.30.Day.Death..Mortality..Rates.from.Pneumonia"
  }
  order_data <- data[order(as.numeric(as.character(data[,outcome_name])), as.character(data[,"Hospital.Name"]),na.last = FALSE),]
  order_data <- order_data[!order_data[,outcome_name] == "Not Available",]
  if (num == "best") {
    return(best(state, outcome))
  } else if (num == "worst") {
    return(tail(as.character(order_data[,"Hospital.Name"]), n = 1))
  }
  return(as.character(order_data[,"Hospital.Name"][num]))
}