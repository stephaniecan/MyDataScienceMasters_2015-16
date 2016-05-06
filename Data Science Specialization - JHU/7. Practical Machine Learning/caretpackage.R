# how to get the default arguments of a function
args(train.default)
args(trainControl)

library(caret); library(kernlab); data(spam)

# Data splitting: separate the dataset into training and test sets.
# it is splitted according to the type
# 75% of the data will go to the training set (p)
inTrain <- createDataPartition(y=spam$type,
                               p=0.75, list=FALSE)
training <- spam[inTrain,]
testing <- spam[-inTrain,]
dim(training)

# Data slicing with K-fold (Return training set)
# y = outcome you want to split on
# k number of folds to be created
# returnTrain : TRUE return the training set
folds <- createFolds(y=spam$type,k=10,list=TRUE,returnTrain=TRUE)
sapply(folds,length)

# 10 first elements of the first fold
folds[[1]][1:10]

# Data slicing with K-fold (Return test set)
# y = outcome you want to split on
# k number of folds to be created
# returnTrain : TRUE return the training set
folds <- createFolds(y=spam$type,k=10,list=TRUE,returnTrain=FALSE)
sapply(folds,length)

# 10 first elements of the first fold
folds[[1]][1:10]

# Data slicing: Resampling or bootscrapping
# you might get the same sample several times
folds <- createResample(y=spam$type,times=10,list=TRUE)
sapply(folds,length)

# 10 first elements of the first fold
folds[[1]][1:10]

# Data slicing: times slices
time <- 1:1000
folds <- createTimeSlices(y=time,initialWindow=20,horizon=10)
names(folds)
folds$train[[1]]
folds$test[[1]]

set.seed(1235) # A revoir
modelfit <- train(type ~.,data=training,method="glm")
modelfit

modelfit$finalModel

predictions <- predict(modelfit,newdata=testing)
predictions

# accuracy measures
confusionMatrix(predictions,testing$type) 

