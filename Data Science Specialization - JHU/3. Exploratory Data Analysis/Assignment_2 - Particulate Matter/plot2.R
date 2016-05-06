## Coursera Exploratory data analysis
## Course project 2
## Plot 2

# 1. Read in the files
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# 2. Have total emissions from PM2.5 decreased in the Baltimore City, 
# Maryland (fips == "24510") from 1999 to 2008? Use the base plotting system 
# to make a plot answering this question.

# Subset data

baltimorecity <- subset (NEI, fips == "24510")
totalPM25 <- tapply(baltimorecity$Emissions, baltimorecity$year, sum)

# Make the plot
png("plot2.png")
plot(names(totalPM25), totalPM25, type = "l", xlab="Year", 
     ylab= expression("Total" ~ PM[2.5] ~ "Emissions (tons)"), 
     main=expression("Total Baltimore City" ~ PM[2.5] ~ "Emissions by Year"), 
     col = "purple")
dev.off() 