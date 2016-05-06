# unzip file
zipfile <- "exdata-data-household_power_consumption.zip"
unzip(file, exdir="./household")

# Read the relevant data (only dates 2007-02-01 and 2007-02-02)
setwd("./household")
file <- "household_power_consumption.txt"
library(sqldf)
subset_data <- read.csv.sql(file, sql = "select * from file where Date in 
              ('1/2/2007', '2/2/2007')", header = TRUE, sep = ";")

# Convert the Date and Time variables to Date/Time classes in R 
date_time <- paste(as.Date(subset_data$Date), subset_data$Time)
subset_data$Datetime <- as.POSIXct(date_time)

# Create Plot 4
par(mfrow = c(2, 2))

## Top-left plot
plot(subset_data$Datetime, subset_data$Global_active_power, type="l", 
     ylab="Global Active Power", xlab="")

## Top-right plot
plot(subset_data$Datetime, subset_data$Voltage, type = "l", 
     xlab = "datetime", ylab = "Voltage")

## Bottom-left plot
plot(subset_data$Datetime, subset_data$Sub_metering_1, type="l",
     ylab="Energy sub metering", main="", xlab="")
lines(subset_data$Datetime, subset_data$Sub_metering_2, col="red")
lines(subset_data$Datetime, subset_data$Sub_metering_3, col="blue")
legend("topright", lwd = 1, col = c("black", "blue", "red"), 
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

## Bottom-right plot
plot(subset_data$Datetime, subset_data$Global_reactive_power, type="l",
     ylab="Global_reactive_power", main="", xlab="datetime")

# Copy Plot 4 to png file
dev.copy(png, file="plot4.png", height=480, width=480)
dev.off()