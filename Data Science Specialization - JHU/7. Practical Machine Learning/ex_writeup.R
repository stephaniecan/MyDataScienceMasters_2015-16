# download the training and test files
fileURL1 <- "https://d396qusza40orc.cloudfront.net/predmachlearn/pml-training.csv"
fileURL2 <- "https://d396qusza40orc.cloudfront.net/predmachlearn/pml-testing.csv"
download.file(fileURL1,destfile="C:/Users/steph_000.STEPHANIE/Courseradatascience/Practical machine learning/pml-training.csv")
download.file(fileURL2,destfile="C:/Users/steph_000.STEPHANIE/Courseradatascience/Practical machine learning/pml-testing.csv")

# read the files setting "NA", "" and "#DIV/0!" to be NA values. Leave the test set for the submission project
trainpml <- read.csv("pml-training.csv", na.strings = c("NA", "", "#DIV/0!"))
testpml <- read.csv("pml-testing.csv", na.strings = c("NA", "", "#DIV/0!"))

# Get and idea of the data. With over than 19 000 rows and 160 columns, the trainpml 
# data set is large enough to split the data between another training and testing set.
# We use the data splitting method with 60% of the data in the training set and 40% in the test set
nrow(trainpml) # [1] 19622
ncol(trainpml) # [1] 160

library(caret)
intrain <- createDataPartition(y = trainpml$classe, p=0.6, list=FALSE)
training <- trainpml[intrain,]
testing <- trainpml[-intrain,]

# Get an idea of the data.
View(training)
names(training)
summary(training)
str(training)

# We noticed that some columns have lots of NA value. We want to know if we have to remove these columns.
# For that, we check how many columns have NA values and how much NA values each of them have NA values
colSums(is.na(training))
11521/nrow(training) # [1] 0.9783458

# Columns have either no NA value or at least 97% NA values. We decide to remove the lattest from the dataframe 
# as they are of no use. We had 160 columns and we end up with only 60 columns (potential predictors)
# which gives us a more useable dataframe.
trainproc <- training[,colSums(is.na(training)) == 0]
ncol(trainproc) # [1] 60

# 59 potential predictors (excluding the "classe" column) is still too high for building a model
# We then delete the columns dealing with time data as they are of no use for predicting the class
names(trainproc) # We check the columns to choose which ones to keep or delete
trainproc <- trainproc[,c(2,8:60)]
ncol(trainproc) # [1] 54. We have now 53 potential predictors

# We check if there is any zero covariates we could remove
nsv <- nearZeroVar(trainproc,saveMetrics=TRUE)
nsv # none of the variables are zero covariates

# We check if there are some highly correlated variables that we can remove
# as they are of no relevant need

# We first convert integer columns as numeric in order to compute the correlation
# We keep "user_name" and "classe" as factor variables
for (i in 2:ncol(trainproc)) {
        if(class(trainproc[,i])=="integer"){
                trainproc[,i] <- as.numeric(trainproc[,i])
        }
}
sapply(trainproc, class) # check if all integer columns have been converted to numeric

# We calculate the correlation between the variables
findCorrelation(cor(trainproc[,-c(1,54)]), cutoff = 0.8, verbose = TRUE)
# [1] 10  1  9 36  8  2 34 21 25 18
# As findCorrelation returns a vector of integers corresponding to columns to 
# remove to reduce pair-wise correlations, we trust the function and remove the columns advised.
# The model accuracy will later tell us if we made a good choice.
# We remove the right columns (considering train[,-c(1,54)]) 
trainproc <- trainproc[,-c(11,2,10,37,9,3,35,22,26,19)]
ncol(trainproc) # [1] 44. We now have 44 potential predictors

# We choose first Random forest model as we have non-linear settings and it is a very performant model
# We remove user_name variable from the model
library(randomForest)
set.seed(33833)
modfit <- randomForest(x=trainproc[,2:43],y=trainproc$classe, importance = FALSE)
print(modfit)

modfit2 <- train(x=trainproc[,2:43],y=trainproc$classe, method="rf", importance = TRUE)

# Variable importance
varimp <- varImpPlot(modfit, sort = TRUE, n.var = 20, main = "Variables importance")
View(varimp)

# error rate and accuracy?
results <- data.frame(pred = predict(modfit, trainproc[,2:43]),
                      obs = trainproc$classe)
p <- ggplot(results, aes(x = pred, y = obs))
p <- p + geom_jitter(position = position_jitter(width = 0.25, height = 0.25))
p

results2 <- data.frame(pred = predict(modfit, testproc[,2:43]),
                       obs = testproc$classe)
p2 <- ggplot(results2, aes(x = pred, y = obs))
p2 <- p2 + geom_jitter(position = position_jitter(width = 0.25, height = 0.25))
p2

# test set
testproc <- testing[,colSums(is.na(testing)) == 0]
ncol(testproc)
testproc <- testproc[,c(2,8:60)]
ncol(testproc)
for (i in 2:ncol(testproc)) {
        if(class(testproc[,i])=="integer"){
                testproc[,i] <- as.numeric(testproc[,i])
        }
}
sapply(testproc, class)

testproc <- testproc[,-c(11,2,10,37,9,3,35,22,26,19)]
ncol(testproc) 

pred <- predict(modfit,testproc); 
table(pred,testproc$classe)
testproc$predRight <- pred==testproc$classe
testproc$pred <- results2$pred
testproc$obs <- results2$obs


summary(testproc$predRight)
#    Mode   FALSE    TRUE    NA's 
# logical      67    7779       0 

# 7779/(67+7779)
# [1] 0.9914606

library(ggplot2)
qplot(obs,pred,colour=predRight,data=testproc,main="newdata Predictions")


# submission
testset <- testpml[,colSums(is.na(testpml)) == 0]
ncol(testset)
testset <- testset[,c(2,8:60)]
ncol(testset)
for (i in 2:ncol(testset)) {
        if(class(testset[,i])=="integer"){
                testset[,i] <- as.numeric(testset[,i])
        }
}
sapply(testset, class)

testset <- testset[,-c(11,2,10,37,9,3,35,22,26,19)]
ncol(testset) 

predtest <- predict(modfit, testset)
predtest1 <- as.character(predtest)

pml_write_files = function(x){
        n = length(x)
        for(i in 1:n){
                filename = paste0("problem_id_",i,".txt")
                write.table(x[i],file=filename,quote=FALSE,row.names=FALSE,col.names=FALSE)
        }
}