trainpml <- read.csv("pml-training.csv", na.strings = c("NA", "", "#DIV/0!"))
testpml <- read.csv("pml-testing.csv", na.strings = c("NA", "", "#DIV/0!"))
removeNA <- colSums(is.na(trainpml))
trainpml <- trainpml[,(removeNA) == 0]
trainpml <- trainpml[,c(8:60)]
library(caret)
for (i in 1:ncol(trainpml)) {
        if(class(trainpml[,i])=="integer"){
                trainpml[,i] <- as.numeric(trainpml[,i])
        }
}
findCorrelation(cor(trainpml[,-53]), cutoff = 0.8, verbose = FALSE)
# 10  1  9 36  8  2 21 34 25 45 31 33 18
trainpml <- trainpml[,-c(10,1,9,36,8,2,21,34,25,45,31,33,18)]
ncol(trainpml)
# 40 columns (39 covariates)
intrain <- createDataPartition(y = trainpml$classe, p=0.6, list=FALSE)
training <- trainpml[intrain,]
testing <- trainpml[-intrain,]
nrow(training); nrow(testing)

library(randomForest)
set.seed(33833)
modfit <- randomForest(x=training[,-40],y=training$classe, importance = TRUE)
print(modfit)

varimp <- varImpPlot(modfit, sort = TRUE, n.var = 10, main = "Variables importance")

trainsubset <- training[,grepl("yaw_belt|magnet_dumbbell_z|pitch_forearm|magnet_dumbbell_y|roll_forearm|magnet_belt_y|magnet_belt_z|magnet_dumbbell_x|roll_dumbbell|accel_dumbbell_y|classe", names(training))]
set.seed(33833)
modfit2 <- randomForest(x=trainsubset[,-11],y=training$classe, importance = TRUE)
print(modfit2)

traintest <- training[,grepl("yaw_belt|magnet_dumbbell_z|pitch_forearm|gyros_arm_y|roll_arm|magnet_dumbbell_y|magnet_belt_y|magnet_forearm_z|magnet_belt_x|gyros_belt_z|classe", names(training))]
set.seed(33833)
modfit3 <- randomForest(x=traintest[,-11],y=training$classe, importance = TRUE)
print(modfit3)

pred <- predict(modfit,testing)
table(pred,testing$classe)
testing$predRight <- pred==testing$classe
summary(testing$predRight)

pred3 <- predict(modfit3,testing)
table(pred3,testing$classe)
testing$predRight3 <- pred3==testing$classe
summary(testing$predRight3)
testset <- testpml[,colSums(is.na(testpml)) == 0]
testset <- testset[,c(8:60)]
for (i in 2:ncol(testset)) {
        if(class(testset[,i])=="integer"){
                testset[,i] <- as.numeric(testset[,i])
        }
}
testset <- testset[,-c(10,1,9,36,8,2,21,34,25,45,31,33,18)]
ncol(testset)
predtest <- predict(modfit, testset)
predtest <- as.character(predtest)
print(predtest)