# read and subset data
eyeka = read.csv(file = "eYeka-creativity-survey-data-CSV.csv")
subset = eyeka[,c(7:14,22)]

# Rename columns to make things easier
names(subset) = c("time1", "time2", "time3", "time4", "time5", "time6", "time7", "time8", "motivation")

# Create a new variable summarizing the 8 variables "time".

subset$timespentcreativity = seq(from=0, to=0)

for (i in 1:nrow(subset)) {
        for (j in 1:8) {
                if ((subset[i,j] == 5)==TRUE){
                        subset$timespentcreativity[i] = "> 7 days"
                        }
                else if ((subset[i,j] == 4)==TRUE & (subset$timespentcreativity[i] == "> 7 days")==FALSE) {
                        subset$timespentcreativity[i] = "btw 3 and 7 days"
                        }
                else if ((subset[i,j] == 1 | subset[i,j] == 2 | subset[i,j] == 3)==TRUE & (subset$timespentcreativity[i] == "> 7 days")==FALSE & (subset$timespentcreativity[i] == "btw 3 and 7 days")==FALSE){
                        subset$timespentcreativity[i] = "btw 1 and 3 days"
                        }
                else if ((subset[i,j] == 0)==TRUE & (subset$timespentcreativity[i] == "> 7 days")==FALSE & (subset$timespentcreativity[i] == "btw 3 and 7 days")==FALSE & (subset$timespentcreativity[i] == "btw 1 and 3 days")==FALSE){
                        subset$timespentcreativity[i] = "none"
                        }
        }}
sum(subset$timespentcreativity == "> 7 days")
# [1] 348
sum(subset$timespentcreativity == "btw 3 and 7 days")
# 292
sum(subset$timespentcreativity == "btw 1 and 3 days")
# 1035
sum(subset$timespentcreativity == "none")
# 314

# Build the data set with 2 variables for Duke's project
creativity = subset[,9:10]
colnames(creativity)[1] = "fulfillment"

# Deal with NA values
sum(is.na(creativity$fulfillment)==TRUE) 
# There are 11 missing values so we can delete the rows with missing values
complete = complete.cases(creativity)
creative = creativity[complete,]
nrow(creativity) - nrow(creative) # 11

# Change output of the fulfillment variable
for (i in 1:nrow(creative)) {
        if ((creative$fulfillment[i] == 1)==TRUE){
                creative$fulfillment[i] = "not at all"
        }
        else if ((creative$fulfillment[i] == 2)==TRUE){
                creative$fulfillment[i] = "not f."
        }
        else if ((creative$fulfillment[i] == 3)==TRUE){
               creative$fulfillment[i] = "neutral"
        }
        else if ((creative$fulfillment[i] == 4)==TRUE){
                creative$fulfillment[i] = "fulfilled"
        }
        else if ((creative$fulfillment[i] == 5)==TRUE){
                creative$fulfillment[i] = "totally f."
        }
}

# Make variable as factor variables and define their levels
creative$timespentcreativity = factor(creative$timespentcreativity, levels = c("none","btw 1 and 3 days","btw 3 and 7 days", "> 7 days"))
creative$fulfillment = factor(creative$fulfillment, levels = c("not at all", "not f.", "neutral", "fulfilled", "totally f."))

datapage = creative[1:15,]
write.table(datapage, "C:/Users/steph_000.STEPHANIE/data_analysis_statistical_inference_duke/datapage.txt", row.names=FALSE, quote = FALSE)

# Explore data with graphics
par(mar=c(2,4,3,0))
mosaicplot(fulfillment ~ timespentcreativity, data = creative, main = "Relation between time spent on creativity and fulfillment", color = TRUE, xlab = "Levels of fulfillment", ylab = "Time spent on creativity", las = 1)

# Preparing summary statistics
table(creative$fulfillment, creative$timespentcreativity)/nrow(creative)
creatable = table(creative$fulfillment, creative$timespentcreativity)

# Check creatable
margin.table(creatable) # 1978. Ok

# summary statistics
tablecreate = round((addmargins(creatable, margin = 2)/rowSums(creatable))*100)
tablecreate2 = round((addmargins(creatable, margin = 2)/rowSums(creatable))*100)
tablecreate = as.character(tablecreate)
tablecreate = paste(tablecreate, "%")
attributes(tablecreate) = attributes(tablecreate2)
library(pander)
pandoc.table(tablecreate, style = "rmarkdown", "creativity and fulfillment", split.table = Inf, emphasize.rownames = FALSE)


# Testing a few things
chisq.test(creatable)
margin.table(creatable, 1)
prop.table(creatable)


library(gmodels)
CrossTable(creative$fulfillment, creative$timespentcreativity, prop.t=FALSE, prop.r=TRUE, prop.c=FALSE, chisq = FALSE, prop.chisq = FALSE, digits = 2)

chisq.test(creatable)

# inference
source("http://bit.ly/dasi_inference")
inference(y = creative$timespentcreativity, x = creative$fulfillment, est = "proportion", type = "ht", alternative = "greater", null = 0, method = "simulation")
