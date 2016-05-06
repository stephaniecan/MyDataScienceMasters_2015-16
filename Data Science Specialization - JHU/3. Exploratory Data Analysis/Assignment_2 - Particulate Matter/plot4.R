## Coursera Exploratory data analysis
## Course project 2
## Plot 4

# 1. Read in the files
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# 2. Across the United States, how have emissions 
# from coal combustion-related sources changed from 1999-2008?

# Load libraries required
 
library(ggplot2)

# Search for coal combustion-related sources and subset data

searched_comb <- grepl("comb", SCC$SCC.Level.One, ignore.case=TRUE)
searched_coal <- grepl("coal", SCC$SCC.Level.Four, ignore.case=TRUE) 
coal_comb <- (searched_comb & searched_coal)
subset_SCC <- SCC[coal_comb,]$SCC
subset_NEI <- NEI[NEI$SCC %in% subset_SCC,]

# Make the plot

png("plot4.png")

plot4 <- ggplot(subset_NEI,aes(factor(year),Emissions)) +
  geom_bar(stat="identity",fill="purple",width=0.75) +
  theme_bw() +  guides(fill=FALSE) +
  labs(x="year", y=expression("Total PM"[2.5]*" Emission (tons)")) + 
  labs(title=expression("PM"[2.5]*" Coal Combustion Source Emissions Across US - 1999-2008"))

print(plot4)

dev.off()
