## Coursera Exploratory data analysis
## Course project 2
## Plot 3

# 1. Read in the files
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# 2. Of the four types of sources indicated by the type 
# (point, nonpoint, onroad, nonroad) variable, which of 
# these four sources have seen decreases in emissions from 
# 1999-2008 for Baltimore City? Which have seen increases in 
# emissions from 1999-2008? Use the ggplot2 plotting system to 
# make a plot answer this question.

# Load library required
library(ggplot2)

# Subset and clean data

baltimorecity <- subset(NEI, fips == "24510")
totalPM25 <- tapply(baltimorecity$Emissions, baltimorecity$year, sum)

# Make the plot

png("plot3.png")

ggplot(baltimorecity,aes(factor(year),Emissions,fill=type)) +
      theme_bw() + geom_bar(stat="identity") + guides(fill=FALSE)+
      facet_grid(.~type,scales = "free",space="free") + 
      labs(x="year", y=expression("Total PM"[2.5]*" Emission (tons)")) + 
      labs(title=expression("Emissions PM"[2.5]*" Baltimore City 1999-2008 by Source Type"))

dev.off()
