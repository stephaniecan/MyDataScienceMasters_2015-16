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

# Create Plot 2
plot(subset_data$Datetime, subset_data$Global_active_power, type="l", 
     ylab="Global Active Power (kilowatts)", xlab="")

# Copy Plot 2 to png file
dev.copy(png, file="plot2.png", height=480, width=480)
dev.off()