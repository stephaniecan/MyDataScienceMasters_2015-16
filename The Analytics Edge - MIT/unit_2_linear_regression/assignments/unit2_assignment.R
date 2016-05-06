# Climate change
climate <- read.csv("climate_change.csv")
str(climate)
training <- climate[which(climate$Year <= 2006),]
str(training); summary(training$Year)
test <- climate[which(climate$Year > 2006),]
str(test) ; summary(test$Year)

model1 <- lm(Temp ~ MEI + CO2 + CH4 + N2O + CFC.11 + CFC.12 + TSI + Aerosols, data=training)
summary(model1)

corvar <- data.frame(training$MEI, training$CO2, training$CH4, training$N2O, training$CFC.11, training$CFC.12, training$TSI, training$Aerosols)
correl <- cor(abs(corvar))
diag(correl) <- 0
correl

model2 <- lm(Temp ~ MEI + TSI + Aerosols + N2O, data = training)
summary(model2)

model3 <- step(model1)
summary(model3)

predictions <- predict(model3, newdata=test)

SSE = sum((predictions - test$Temp)^2)
SST = sum((mean(training$Temp) - test$Temp)^2)
R2 = 1 - SSE/SST
R2

# Assignment 2
training <- read.csv("pisa2009train.csv")
test <- read.csv("pisa2009test.csv")
str(training)
nrow(training)
tapply(training$readingScore, training$male, mean)

colSums(is.na(training))

training <- na.omit(training)
test <- na.omit(test)
str(training) ; str(test)

training$raceeth = relevel(training$raceeth, "White")
test$raceeth = relevel(test$raceeth, "White")

lmScore <- lm(readingScore ~ ., data = training)
summary(lmScore)

SSE = sum(lmScore$residuals^2)
RMSE = sqrt(SSE/nrow(training))
RMSE

predTest <- predict(lmScore, newdata = test)
SSEtest = sum((predTest - test$readingScore)^2)
RMSEtest = sqrt(mean((predTest-test$readingScore)^2))
SSEtest
RMSEtest

baseline = mean(training$readingScore)
baseline
SST = sum((baseline - test$readingScore)^2)
SST

R2test = 1 - SSEtest/SST
R2test

# Assignment 3
FluTrain = read.csv("FluTrain.csv")
str(FluTrain)
FluTrain[FluTrain$ILI==max(FluTrain$ILI),] # or which.max(FluTrain$ILI) or subset(FluTrain, ILI == max(ILI))
FluTrain[FluTrain$Queries==max(FluTrain$Queries),]

hist(FluTrain$ILI)
# Most of the ILI values are small, with a relatively small number of much larger values (in statistics, this sort of data is called "skew right"). 
# When handling a skewed dependent variable, it is often useful to predict the logarithm of the dependent 
# variable instead of the dependent variable itself -- this prevents the small number of unusually large or 
# small observations from having an undue influence on the sum of squared errors of predictive models.

plot(log(FluTrain$ILI), FluTrain$Queries)

FluTrend1 <- lm(log(ILI) ~ Queries, data = FluTrain)
summary(FluTrend1)
correlation <- cor(log(FluTrain$ILI),FluTrain$Queries)
correlation
# For a single variable linear regression model, there is a direct relationship between the R-squared 
# and the correlation between the independent and the dependent variables. 
# R-squared = Correlation^2

FluTest <- read.csv("FluTest.csv")
PredTest1 = exp(predict(FluTrend1, newdata=FluTest))
which(FluTest$Week == "2012-03-11 - 2012-03-17")
PredTest1[11]

# Relative error : (Observed ILI - Estimated ILI)/Observed ILI
(FluTest$ILI[11] - PredTest1[11])/ FluTest$ILI[11]
SSEtest = sum((PredTest1- FluTest$ILI)^2)
RMSEtest = sqrt(mean((PredTest1-FluTest$ILI)^2)) # or RMSE = sqrt(SSE / nrow(FluTest))
SSEtest
RMSEtest

library(zoo)
# lag = retard
ILILag2 = lag(zoo(FluTrain$ILI), -2, na.pad=TRUE)
FluTrain$ILILag2 = coredata(ILILag2)

# In these commands, the value of -2 passed to lag means to return 
# 2 observations before the current one; a positive value would have 
# returned future observations. The parameter na.pad=TRUE means to add 
# missing values for the first two weeks of our dataset, where we can't 
# compute the data from 2 weeks earlier.

sum(is.na(ILILag2))

plot(log(FluTrain$ILILag2), log(FluTrain$ILI))

FluTrend2 <- lm(log(ILI)  ~ Queries + log(ILILag2), data = FluTrain)
summary(FluTrend2)

# If the R^2 improves and the new variable is highly significant, there is no sign of overfitting

ILILag2 = lag(zoo(FluTest$ILI), -2, na.pad=TRUE)
FluTest$ILILag2 = coredata(ILILag2)
sum(is.na(FluTest))

nrow(FluTrain)
FluTest$ILILag2[c(1,2)] = FluTrain$ILI[c(416,417)]

PredTest2 = exp(predict(FluTrend2,newdata=FluTest))
SSE = sum((PredTest2-FluTest$ILI)^2)
RMSE = sqrt((SSE/nrow(FluTest)))
RMSE