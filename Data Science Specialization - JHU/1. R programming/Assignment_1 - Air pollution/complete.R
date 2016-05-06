complete <- function(directory, id = 1:332) {
  file <- list.files(directory, full.names = TRUE)
  
  nobs <- numeric(0)
  for (i in id) {
    countna <- sum(complete.cases(read.csv(file[i])))
    nobs <- c(nobs,countna)
  }
  data <- data.frame(id,nobs)
  data
}
