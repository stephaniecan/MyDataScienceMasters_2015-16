# question 1
library(ElemStatLearn)
library(caret)
data(vowel.train)
data(vowel.test)
vowel.train$y <- as.factor(vowel.train$y)
vowel.test$y <- as.factor(vowel.test$y)

set.seed(33833)
modelrf <- train(y~.,method="rf", data=vowel.train)
modelgbm <- train(y~.,method="gbm", data=vowel.train)

predrf <- predict(modelrf,newdata=vowel.test)
predgbm <- predict(modelgbm,newdata=vowel.test)
# Get the accuracy for modelrf and modelgbm
rf_accuracy <- sum(predrf == vowel.test$y) / length(predrf)
gbm_accuracy <- sum(predgbm == vowel.test$y) / length(predgbm)
rf_accuracy
gbm_accuracy
# Get the last part of the answer
agree <- vowel.test[predrf == predgbm,]
predcomb <- predict(modelrf, agree)
combacc<- sum(predcomb == agree$y) / length(predcomb)

# Question 2
library(caret)
library(gbm)
set.seed(3433)
library(AppliedPredictiveModeling)
data(AlzheimerDisease)
adData = data.frame(diagnosis,predictors)
inTrain = createDataPartition(adData$diagnosis, p = 3/4)[[1]]
training = adData[ inTrain,]
testing = adData[-inTrain,]
set.seed(62433)
rf <- train(diagnosis ~ ., data = training, method="rf")
gbm <- train(diagnosis ~ ., data = training, method="gbm")
lda <- train(diagnosis ~ ., data = training, method="lda")

predrf <- predict(rf,testing)
predgbm <- predict(gbm,testing)
predlda <- predict(lda,testing)

predDF <- data.frame(predrf,predgbm,predlda,diagnosis=testing$diagnosis)
combModFit <- train(diagnosis ~.,method="rf",data=predDF)
combPred <- predict(combModFit,predDF)

rf_accuracy <- sum(predrf == testing$diagnosis) / length(predrf)
gbm_accuracy <- sum(predgbm == testing$diagnosis) / length(predgbm)
lda_accuracy <- sum(predlda == testing$diagnosis) / length(predlda)
all_accuracy <- sum(combPred == predDF$diagnosis) / length(combPred)
rf_accuracy; gbm_accuracy; lda_accuracy; all_accuracy;

# Question 3
set.seed(3523)
library(AppliedPredictiveModeling)
data(concrete)
inTrain = createDataPartition(concrete$CompressiveStrength, p = 3/4)[[1]]
training = concrete[ inTrain,]
testing = concrete[-inTrain,]

set.seed(233)
modelasso <- train(CompressiveStrength~., data = training, method= "lasso")
plot.enet(modelasso$finalModel, xvar = "penalty", use.color = TRUE)

# Question 4
url <- "https://d396qusza40orc.cloudfront.net/predmachlearn/gaData.csv"
download.file(url, destfile = "./gaData.csv")
library(lubridate)
library(forecast)
dat = read.csv("./gaData.csv")
training = dat[year(dat$date) < 2012,]
testing = dat[(year(dat$date)) > 2011,]
tstrain = ts(training$visitsTumblr)
tstest = ts(testing$visitsTumblr)
model <- bats(tstrain)
fcast <- forecast(model)
accuracy(fcast,testing$visitsTumblr)
# To finish
result <- c()
l <- length(fcast$lower)

for (i in 1:l){
        x <- testing$visitsTumblr[i]
        a <- fcast$lower[i] < x & x < fcast$upper[i]
        result <- c(result, a)
}

sum(result)/l * 100

# Question 5
set.seed(3523)
library(AppliedPredictiveModeling)
data(concrete)
inTrain = createDataPartition(concrete$CompressiveStrength, p = 3/4)[[1]]
training = concrete[ inTrain,]
testing = concrete[-inTrain,]

set.seed(325)
library(e1071)
modelsvm <- svm(CompressiveStrength ~ ., data = training)
pred <- predict(modelsvm, newdata = testing)
sqrt(mean(sum((pred-testing$CompressiveStrength)))^2)