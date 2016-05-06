rankall <- function(outcome, num = "best") {
  ## Read outcome data
  outcomedata <- read.csv("outcome-of-care-measures.csv", colClasses = "character")
  outcomedata[outcomedata=="Not Available"] <- NA
  outcomedata <- outcomedata[complete.cases(outcomedata[,c(11,17,23)]),]
  library(data.table)
  outcomedata <- as.data.table(outcomedata)
  
  ## Check that outcome are valid
  if ((outcome %in% c("heart attack","heart failure","pneumonia"))=="FALSE") {
    stop("invalid outcome") }
  
  ## For each state, find the hospital of the given rank
  while (outcome == "heart attack") {
  outcomedata[,rank:=rank(Hospital.30.Day.Death..Mortality..Rates.from.Heart.Attack,ties.method="first"),by=State]
    if (num=="best") {
      subdata <- outcomedata[which(outcomedata$rank==1),]
      data <- data.frame(hospital=c(subdata$Hospital.Name),state=c(subdata$State))
      return(data)
    }
    else if (num=="worst") {
      worst <- aggregate(outcomedata$rank ~ outcomedata$State, FUN= max)
      names(worst) <- c("State","rank")
      subdata <- merge(outcomedata, worst, by = c("State","rank"))
      data <- data.frame(hospital=c(subdata$Hospital.Name),state=c(subdata$State))
      return(data)}
    else if (num %in% unique(unlist(outcomedata$rank, use.names = FALSE))=="FALSE") {
      return(NA) }
    else {
    subdata <- outcomedata[which(outcomedata$rank==num),]
    data <- data.frame(hospital=c(subdata$Hospital.Name),state=c(subdata$State))
    return(data)
  }}
  while (outcome == "heart failure") {
  outcomedata[,rank:=rank(Hospital.30.Day.Death..Mortality..Rates.from.Heart.Failure,ties.method="first"),by=State]
    if (num=="best") {
      subdata <- outcomedata[which(outcomedata$rank==1),]
      data <- data.frame(hospital=c(subdata$Hospital.Name),state=c(subdata$State))
      return(data)
    }
    else if (num=="worst") {
      worst <- aggregate(outcomedata$rank ~ outcomedata$State, FUN= max)
      names(worst) <- c("State","rank")
      subdata <- merge(outcomedata, worst, by = c("State","rank"))
      data <- data.frame(hospital=c(subdata$Hospital.Name),state=c(subdata$State))
      return(data) }
    else if (num %in% unique(unlist(outcomedata$rank, use.names = FALSE))=="FALSE") {
      return(NA) }
    else {
      subdata <- outcomedata[which(outcomedata$rank==num),]
      data <- data.frame(hospital=c(subdata$Hospital.Name),state=c(subdata$State))
      return(data)
    }  }
  while (outcome == "pneumonia") {
  outcomedata[,rank:=rank(Hospital.30.Day.Death..Mortality..Rates.from.Pneumonia,ties.method="first"),by=State]
    if (num=="best") {
      subdata <- outcomedata[which(outcomedata$rank==1),]
      data <- data.frame(hospital=c(subdata$Hospital.Name),state=c(subdata$State))
      return(data)
    }
    else if (num=="worst") {
      worst <- aggregate(outcomedata$rank ~ outcomedata$State, FUN= max)
      names(worst) <- c("State","rank")
      subdata <- merge(outcomedata, worst, by = c("State","rank"))
      data <- data.frame(hospital=c(subdata$Hospital.Name),state=c(subdata$State))
      return(data)}
    else if (num %in% unique(unlist(outcomedata$rank, use.names = FALSE))=="FALSE") {
      return(NA) }
    else {
      subdata <- outcomedata[which(outcomedata$rank==num),]
      data <- data.frame(hospital=c(subdata$Hospital.Name),state=c(subdata$State))
      return(data)
    }  }
  ## Return a data frame with the hospital names and the
  ## (abbreviated) state name
}
