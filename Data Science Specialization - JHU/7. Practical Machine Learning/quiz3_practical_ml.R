# Question1

library(AppliedPredictiveModeling)
data(segmentationOriginal)
library(caret)

View(segmentationOriginal)

training <- subset(segmentationOriginal, grepl("^Train",Case), value=TRUE)
testing <- subset(segmentationOriginal, grepl("^Test",Case), value=TRUE)
dim(training); dim(testing)

set.seed(125)
modelfit <- train(Class~.,data=training,method="rpart")
modelfit

modelfit$finalModel

library(rattle)
fancyRpartPlot(modelfit$finalModel)

predict(modelfit,newdata)

# Question 3
olivefile <- load("olive.rda")
olive <- olivefile[,-1]
View(olive)
modFit <- train(Area ~., method="rpart",data=olive)
modFit
modFit$finalModel

predict(modFit$finalModel,newdata = as.data.frame(t(colMeans(olive))))

# Question 3
library(ElemStatLearn)
data(SAheart)
set.seed(8484)
train = sample(1:dim(SAheart)[1],size=dim(SAheart)[1]/2,replace=F)
trainSA = SAheart[train,]
testSA = SAheart[-train,]
View(SAheart)

set.seed(13234)
lrmodel <- glm(chd ~ age + alcohol + obesity + tobacco +
                 typea + ldl, data = trainSA, family = "binomial")

missClass <- function(values,prediction){sum(((prediction > 0.5)*1) != values)/length(values)}
predict_train <- predict(lrmodel, type="response")
predict_test <- predict(lrmodel, newdata=testSA, type="response")
missClass(trainSA$chd,predict_train)
missClass(testSA$chd,predict_test)

# Question 5
library(ElemStatLearn)
data(vowel.train)
data(vowel.test)
y <-factor(vowel.train$y)
y <-factor(vowel.test$y)

library(randomForest)
set.seed(33833)
modelf <- randomForest(y~.,method="rf", data=vowel.train,importance = FALSE)
modelf
var_imp <- varImp(modelf)
order(var_imp)

modeltest <- randomForest(y~.,method="rf", data=vowel.test,importance = FALSE)


var_test <- varImp(modeltest)
var_test
