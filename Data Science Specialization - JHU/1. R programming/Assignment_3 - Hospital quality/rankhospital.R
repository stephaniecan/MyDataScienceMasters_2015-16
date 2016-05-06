rankhospital <- function(state, outcome, num = "best") {
  ## Read outcome data
  outcomedata <- read.csv("outcome-of-care-measures.csv", colClasses = "character")
  outcomedata[outcomedata=="Not Available"] <- NA
  outcomedata <- outcomedata[complete.cases(outcomedata[,c(11,17,23)]),]
  
  ## Check that state and outcome are valid
  if ((state %in% unique(unlist(outcomedata[,7], use.names = FALSE)))=="FALSE") {
    stop("invalid state") }
  if ((outcome %in% c("heart attack","heart failure","pneumonia"))=="FALSE") {
    stop("invalid outcome") }
  ## Return hospital name in that state with the given rank
  ## 30-day death rate
  
  suboutcome <- subset(outcomedata,outcomedata$State == state)
  
  while (outcome == "heart attack") {
    newoutcome <- suboutcome[order(as.numeric(suboutcome[,11]),suboutcome[,2]),]
    newoutcome$rank <- 1:nrow(newoutcome)
    newoutcome$rank <- as.numeric(newoutcome$rank)
    if (num=="best") {
      return(as.character(newoutcome[1,2]))
    }
    else if (num=="worst") {
      return(as.character(tail(newoutcome$Hospital.Name,n=1)))}
    else if (num %in% unique(unlist(newoutcome$rank, use.names = FALSE))=="FALSE") {
      return(NA) }
    else {
    lastoutcome <- subset(newoutcome,newoutcome$rank==num)
    return(as.character(lastoutcome$Hospital.Name)) }}
  while (outcome == "heart failure") {
    newoutcome <- suboutcome[order(as.numeric(suboutcome[,17]),suboutcome[,2]),]
    newoutcome$rank <- 1:nrow(newoutcome)
    newoutcome$rank <- as.numeric(newoutcome$rank)
    if (num=="best") {
      return(as.character(newoutcome[1,2]))
    }
    else if (num=="worst") {
      return(as.character(tail(newoutcome$Hospital.Name,n=1)))}
    else if (num %in% unique(unlist(newoutcome$rank, use.names = FALSE))=="FALSE") {
      return(NA) }
    else {
    lastoutcome <- subset(newoutcome,newoutcome$rank==num)
    return(as.character(lastoutcome$Hospital.Name)) }}
  while (outcome == "pneumonia") {
    newoutcome <- suboutcome[order(as.numeric(suboutcome[,23]),suboutcome[,2]),]
    newoutcome$rank <- 1:nrow(newoutcome)
    newoutcome$rank <- as.numeric(newoutcome$rank)
    if (num=="best") {
      return(as.character(newoutcome[1,2]))
    }
    else if (num=="worst") {
      return(as.character(tail(newoutcome$Hospital.Name,n=1)))}
    else if (num %in% unique(unlist(newoutcome$rank, use.names = FALSE))=="FALSE") {
      return(NA) }
    else {
    lastoutcome <- subset(newoutcome,newoutcome$rank==num)
    return(as.character(lastoutcome$Hospital.Name)) }
} }
