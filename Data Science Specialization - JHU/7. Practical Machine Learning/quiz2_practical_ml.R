# Question 1
library(AppliedPredictiveModeling)
library(caret)
data(AlzheimerDisease)

adData = data.frame(diagnosis,predictors)
testIndex = createDataPartition(diagnosis, p = 0.50,list=FALSE)
training = adData[-testIndex,]
testing = adData[testIndex,]

adData = data.frame(diagnosis,predictors)
trainIndex = createDataPartition(diagnosis, p = 0.50,list=FALSE)
training = adData[trainIndex,]
testing = adData[-trainIndex,]

# Question 2
library(AppliedPredictiveModeling)
data(concrete)
library(caret)
set.seed(1000)
inTrain = createDataPartition(mixtures$CompressiveStrength, p = 3/4)[[1]]
training = mixtures[ inTrain,]
testing = mixtures[-inTrain,]

hist(x = training$Superplasticizer)

# Question 3
library(AppliedPredictiveModeling)
library(caret)
set.seed(3433)
data(AlzheimerDisease)
adData = data.frame(diagnosis,predictors)
inTrain = createDataPartition(adData$diagnosis, p = 3/4)[[1]]
training = adData[ inTrain,]
testing = adData[-inTrain,]

train_sub = subset(training[grepl("^IL",colnames(training))])
# Subset data where columns start by "IL"
subset_tr <- training[,grepl("^IL", names(training))]
View(subset_tr)
# thresh: cutoff for the cumulative percent of variance to be retained by PCA
preprop <- preProcess(subset_tr,method="pca",thresh=0.8)
preprop$rotation

# Question 4
library(AppliedPredictiveModeling)
library(caret)
set.seed(3433)
data(AlzheimerDisease)
adData = data.frame(diagnosis,predictors)
inTrain = createDataPartition(adData$diagnosis, p = 3/4)[[1]]
training = adData[ inTrain,]
testing = adData[-inTrain,]

newtrain = data.frame(train_sub,training$diagnosis)
test_sub = subset(testing[grepl("^IL",colnames(testing))])
newtest = data.frame(test_sub,testing$diagnosis)
predict1 = train(data = newtrain[,-13],method = "glm",newtrain$training.diagnosis~.)
confusionMatrix(data = testing$diagnosis, predict(predict1,testing))
# Accuracy : 0.6463  
preprop = preProcess(newtrain[,-13],method = "pca",thresh = 0.8)
preprop2 = predict(preprop, newtrain[,-13])
testpreprop2 = predict(preprop,newtest[,-13])
predict2 = train(newtrain$training.diagnosis~., method="glm",data=preprop2)
confusionMatrix(data=newtest$testing.diagnosis,predict(predict2,testpreprop2))
set.seed(1235)
train_set <- data.frame(training[,grepl("^IL", names(training))],training$diagnosis)
View(train_set)
preprop_PCA <- preProcess(train_set[,-13],method="pca",thresh=0.8)
predict_PCA <- predict(preprop_PCA,train_set[,-13])
model_PCA <- train(train_set$training.diagnosis~.,method="glm",data=predict_PCA)

set.seed(1235)
modelfit <- train(train_set$training.diagnosis~.,data=train_set,method="glm")

model_PCA
modelfit