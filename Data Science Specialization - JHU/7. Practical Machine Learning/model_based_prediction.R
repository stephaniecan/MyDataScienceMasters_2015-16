data(iris); library(ggplot2)
names(iris)

inTrain <- createDataPartition(y=iris$Species,
                               p=0.7, list=FALSE)
training <- iris[inTrain,]
testing <- iris[-inTrain,]
dim(training); dim(testing)

# build prediction
# method "nb" : Naive Bayes classification
# method "lda" : linear discriminant analysis
modlda = train(Species ~ .,data=training,method="lda")
modnb = train(Species ~ ., data=training,method="nb")

# comparison between linear discriminant analysis classification
# and Naive Bayes classification
plda = predict(modlda,testing); pnb = predict(modnb,testing)
table(plda,pnb)

# Comparison of results
equalPredictions = (plda==pnb)
qplot(Petal.Width,Sepal.Width,colour=equalPredictions,data=testing)