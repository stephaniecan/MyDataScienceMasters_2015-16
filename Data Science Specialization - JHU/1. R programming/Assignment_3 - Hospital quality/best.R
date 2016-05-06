best <- function(state, outcome) {
  ## Read outcome data
  outcomedata <- read.csv("outcome-of-care-measures.csv", colClasses = "character")
  outcomedata[outcomedata=="Not Available"] <- NA
  outcomedata <- outcomedata[complete.cases(outcomedata[,c(11,17,23)]),]
  ## Check that state and outcome are valid
  
  if ((state %in% unique(unlist(outcomedata[,7], use.names = FALSE)))=="FALSE") {
    stop("invalid state") }
  if ((outcome %in% c("heart attack","heart failure","pneumonia"))=="FALSE") {
    stop("invalid outcome") }
  
  ## Return hospital name in that state with lowest 30-day death
  ## rate
  suboutcome <- subset(outcomedata,outcomedata$State == state)
  if (outcome == "heart attack") {
  newoutcome <- suboutcome[which.min(suboutcome[,11]),]
  newoutcome <- newoutcome[order(newoutcome$Hospital.Name),]
  return(as.character(newoutcome[1,2])) }
  if (outcome == "heart failure") {
    newoutcome <- suboutcome[which.min(suboutcome[,17]),]
    newoutcome <- newoutcome[order(newoutcome$Hospital.Name),]
    return(as.character(newoutcome[1,2])) }
  if (outcome == "pneumonia") {
    newoutcome <- suboutcome[which.min(suboutcome[,23]),]
    newoutcome <- newoutcome[order(newoutcome$Hospital.Name),]
    return(as.character(newoutcome[1,2])) }
}