## Coursera Exploratory data analysis
## Course project 2
## Plot 1 

# 1. Read in the files
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# 2. Have total emissions from PM2.5 decreased in the United States 
# from 1999 to 2008? Using the base plotting system, make a plot showing 
# the total PM2.5 emission from all sources for each of the years 1999, 2002, 2005, 
#and 2008.
totalPM25 <- tapply(NEI$Emissions, NEI$year, sum)

png("plot1.png")

plot(names(totalPM25), totalPM25, type="l", xlab = "Year", ylab = expression 
    ("Total" ~ PM[2.5] ~"Emissions (tons)"), main = expression("Total US" ~ 
    PM[2.5] ~ "Emissions by Year"), col="red")
dev.off()