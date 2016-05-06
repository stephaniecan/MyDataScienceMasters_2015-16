complete <- function(directory, id = 1:332) {
files_list <- list.files(directory, full.names=TRUE)
dat <- data.frame ()
for (i in id) {
dat <- rbind (dat, read.csv(files_list[i]))
}
complete_cases <- complete.cases(dat)
nobs <- sum(complete_cases)
cbind(id, nobs)
}