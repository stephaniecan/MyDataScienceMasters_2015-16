# Question 1

library(ElemStatLearn)
data(vowel.train)
data(vowel.test) 
vowel.test$y <- as.factor(vowel.test$y)
vowel.train$y <- as.factor(vowel.train$y)
set.seed(33833)
library(caret)
RF <- train(y  ~ . , data=vowel.train, method="rf")
GBM <- train(y ~ . , data=vowel.train, method="gbm")
RFpred <- predict(RF, newdata = vowel.test)
GBMpred <- predict(GBM, newdata = vowel.test)