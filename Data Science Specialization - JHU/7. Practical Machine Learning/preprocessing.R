# you need to plot your data to check if there is some weird data/behavior
# Training and test must be processed in the same way
# test transformations will likely be imperfect

library(caret); library(kernlab); data(spam)

inTrain <- createDataPartition(y=spam$type,
                               p=0.75, list=FALSE)
training <- spam[inTrain,]
testing <- spam[-inTrain,]

# show the need for preprocess
hist(training$capitalAve,main="",xlab="ave. capital run length")
mean(training$capitalAve)
# highly variable
sd(training$capitalAve)

# Standardization (mean normalization) : reduces the variability seen previously
trainCapAve <- training$capitalAve
trainCapAveS <- (trainCapAve - mean(trainCapAve))/sd(trainCapAve)
# the mean will be around 0 and the standard deviation around 1
mean(trainCapAveS)
sd(trainCapAveS)

# Standardizing - test set
# IMPORTANT: use of training set mean and strandard deviation
testCapAve <- testing$capitalAve
testCapAveS <- (testCapAve - mean(trainCapAve))/sd(trainCapAve)
mean(testCapAveS)
sd(testCapAveS)

# Standardizing : preProcess function
# method=c("center","scale") does standardization
# training[,-58]: remove the last variable (58th) from the training set
preObj <- preProcess(training[,-58],method=c("center","scale"))
trainCapAveS <- predict(preObj, training[,58])$capitalAve
mean(trainCapAveS)
sd(trainCapAveS)

# Standardizing : preProcess function
# Applying it to the test set
testCapAveS <- predict(preObj, testing[,-58])$capitalAve
mean(testCapAveS)
sd(testCapAveS)

# Standardizing : preProcess argument in the train function
set.seed(32343)
modelFit <- train(type~.,data=training, preProcess=c("center","scale"), method="glm")
modelFit

# Standardizing - BoxCox transforms (set of tranformations that make continuous 
# data look normal if they didn't at first).
# It doesn't take care of all the problems
preObj <- preProcess(training[,-58],method=c("BoxCox"))
trainCapAveS <- predict(preObj, training[,-58])$capitalAve
par(mfrow=c(1,2)); hist(trainCapAveS); qqnorm(trainCapAveS)

# Missing data NA : standardizing with imputing data
# Prediction algorithms are built not to handle missing values
# they fail when there is missing data
set.seed(13343)
# Make some values NA to see how to handle missing values
# Generate some random values NA (rbinom...)
# training$capAve now have some random NA
training$capAve <- training$capitalAve
selectNA <- rbinom(dim(training)[1],size=1,prob=0.05)==1
training$capAve[selectNA] <- NA
#Impute and standardize
# knnImpute: look at the 10 nearest data vectors that you close to the ones 
# with NA and average the values missing and impute them at that position
preObj <- preProcess(training[,-58],method='knnImpute')
capAve <- predict(preObj, training[,-58])$capAve
# Standardize true values
library(RANN)
capAveTruth <- training$capitalAve
capAveTruth <- (capAveTruth-mean(capAveTruth))/sd(capAveTruth)
# Compare the values. If it is close to 0, then the computation worked very well
# as data are close
quantile(capAve - capAveTruth)
# Only for missing values
quantile((capAve - capAveTruth)[selectNA])
# Without missing values
quantile((capAve - capAveTruth)[!selectNA])