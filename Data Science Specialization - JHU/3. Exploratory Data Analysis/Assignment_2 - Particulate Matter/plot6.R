## Coursera Exploratory data analysis
## Course project 2
## Plot 5

# 1. Read in the files
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# 2. Compare emissions from motor vehicle sources in Baltimore City 
# with emissions from motor vehicle sources in Los Angeles County, California 
# (fips == "06037"). Which city has seen greater changes over time in motor vehicle 
# emissions?

# Load required library
library(ggplot2)

# subset NEI data corresponding to vehicles
subset_vehicle <- grepl("vehicle", SCC$SCC.Level.Two, ignore.case=TRUE)
subset_SCC <- SCC[subset_vehicle,]$SCC
subset_NEI <- NEI[NEI$SCC %in% subset_SCC,]

# Subset NEI data corresponding to vehicles & cities
balti_vehicle_NEI <- subset_NEI[subset_NEI$fips=="24510",]
balti_vehicle_NEI$city <- "Baltimore City"

LA_vehicle_NEI <- subset_NEI[subset_NEI$fips=="06037",]
LA_vehicle_NEI$city <- "Los Angeles County"

# Combine the  subsets into a data frame
cities_NEI <- rbind(balti_vehicle_NEI,LA_vehicle_NEI)

png("plot6.png")

plot6 <- ggplot(cities_NEI, aes(x=factor(year), y=Emissions, fill=city)) +
  geom_bar(aes(fill=year),stat="identity") +
  facet_grid(scales="free", space="free", .~city) +
  guides(fill=FALSE) + theme_bw() +
  labs(x="year", y=expression("Total PM"[2.5]*" Emission (tons)")) + 
  labs(title=expression("PM"[2.5]*" Vehicle Source Emissions Baltimore & LA 1999-2008"))

print(plot6)

dev.off()