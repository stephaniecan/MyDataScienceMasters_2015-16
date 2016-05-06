data(iris); library(ggplot2)
names(iris)
table(iris$Species)

library(caret)
inTrain <- createDataPartition(y=iris$Species,p=0.7,list=FALSE)
training <- iris[inTrain,]
testing <- iris[-inTrain,]
dim(training); dim(testing)

# Iris petal widths/sepal width
qplot(Petal.Width,Sepal.Width,colour=Species,data=training)

modFit <- train(Species~., data=training, method="rpart")
print(modFit$finalModel)

# plot tree
plot(modFit$finalModel,uniform=TRUE, main="Classification Tree")
text(modFit$finalModel,use.n=TRUE, all=TRUE, cex=.8)

# prettier plot
library(rattle)
fancyRpartPlot(modFit$finalModel)

# predicting new values
predict(modFit,newdata=testing)