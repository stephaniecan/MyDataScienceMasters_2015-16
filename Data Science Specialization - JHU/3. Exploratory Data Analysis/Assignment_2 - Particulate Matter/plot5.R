## Coursera Exploratory data analysis
## Course project 2
## Plot 5

# 1. Read in the files
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# 2. How have emissions from motor vehicle sources 
# changed from 1999-2008 in Baltimore City?

# Load required library
library(ggplot2)

# subset NEI data corresponding to vehicles
subset_vehicle <- grepl("vehicle", SCC$SCC.Level.Two, ignore.case=TRUE)
subset_SCC <- SCC[subset_vehicle,]$SCC
subset_NEI <- NEI[NEI$SCC %in% subset_SCC,]

# Subset NEI data corresponding to vehicles & Baltimore City
balti_vehicle_NEI <- subset_NEI[subset_NEI$fips=="24510",]

png("plot5.png")

plot5 <- ggplot(balti_vehicle_NEI,aes(factor(year),Emissions)) +
  geom_bar(stat="identity",fill="orange",width=0.75) +
  theme_bw() +  guides(fill=FALSE) +
  labs(x="year", y=expression("Total PM"[2.5]*" Emission (tons)")) + 
  labs(title=expression("PM"[2.5]*" Vehicle Source Emissions in Baltimore 1999-2008"))

print(plot5)

dev.off()
