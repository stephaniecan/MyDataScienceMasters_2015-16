outcome <- read.csv("outcome-of-care-measures.csv", colClasses = "character")
head(outcome)
ncol(outcome)
nrow(outcome)
outcome[, 11] <- as.numeric(outcome[, 11])
hist(outcome[, 11])

if (("FG" %in% unique(unlist(outcome[,7], use.names = FALSE)))=="FALSE") {
stop("invalid state") }
newoutcome <- outcome[which(outcome$State == "WA" & 
                                   min(outcome[,11])),]
print(newoutcome$Hospital.Name)

if (num=="best") {
  return(as.character(lastoutcome[1,2]))
}
else if (num=="worst") {
  return(as.character(tail(lastoutcome$Hospital.Name,n=1)))}

# tapply & aggregate same
tapply(outcomedata$rank, outcomedata$State, max, simplify = TRUE)