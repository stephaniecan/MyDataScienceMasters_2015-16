corr <- function(directory, threshold = 0) {
  source("complete.R")
  compcases <- complete(directory)
  files <- list.files(directory, full.names = TRUE)
  finalcor <- vector(mode = "numeric", length = 0)
  
  for(i in 1:332) {
    comp <- compcases[i,]
    if (comp$nobs > threshold)
  {
    good <- complete.cases(read.csv(files[i]))
    data <- read.csv(files[i])
    data <- data[good,]
    finalcor <- c(finalcor,cor(data$sulfate, data$nitrate))
  }
  }
  finalcor
  }