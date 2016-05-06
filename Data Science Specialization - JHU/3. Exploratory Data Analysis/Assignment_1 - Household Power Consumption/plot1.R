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
subset_data[, "Date"] <- as.Date(strptime(subset_data[, "Date"], format='%d/%m/%Y'))

# Create Plot 1
library(datasets)
hist(subset_data$Global_active_power, main="Global Active Power", 
    xlab="Global Active Power (kilowatts)", col="Red")

# Copy Plot 1 to png file
dev.copy(png, file="plot1.png", height=480, width=480)
dev.off()