household <- read.table("household_power_consumption.txt", sep = ";", header=TRUE)
household <- household[which(household$Date=="1/2/2007" | household$Date=="2/2/2007"),]

# Plot 1
as.numeric.factor <- function(x) {as.numeric(levels(x))[x]}
household$Global_active_power <- as.numeric.factor(household$Global_active_power)
hist(household$Global_active_power, col="red", main="Global Active Power",xlab = "Global Active Power (kilowatts)")

# Plot 2
date_time <- paste(household$Date, household$Time)
date_time <- strptime(date_time, format = )
household$Datetime <- as.POSIXct(date_time)

