pollutantmean <- function(directory, pollutant, id = 1:332) {
 files <- list.files(directory,full.names = TRUE)
 data <- data.frame()
 
 for(i in id) {
   data <- rbind(data, read.csv(files[i]))
 }
 
 if (pollutant == "sulfate") {
   mean <- mean(data$sulfate, na.rm=TRUE)
 }
 else {
   mean <- mean(data$nitrate, na.rm=TRUE)
 }
 print(mean)
}
