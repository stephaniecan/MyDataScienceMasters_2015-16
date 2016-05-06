data(iris); library(ggplot2); library(caret)

inTrain <- createDataPartition(y=iris$Species,p=0.7,list=FALSE)
training <- iris[inTrain,]
testing <- iris[-inTrain,]
dim(training); dim(testing)

# Random Forest
# method "rf" for random forest
# prox=TRUE : produces a little bit more useful infos in this case
modFit <- train(Species ~ ., data=training, method="rf", prox=TRUE)
modFit

# getting a single tree
# k=2 : get the second tree
# split var (outcome of this model) : which variable is splitted
# prediction : what prediction will be out of that particular split
getTree(modFit$finalModel,k=2)

# class "centers"
# as.data.frame : Function to check if an object is a data frame, 
# or coerce it if possible
# training[,c(3,4)] corresponds to Petal.Length & Petal.Width
irisP <- classCenter(training[,c(3,4)], training$Species,modFit$finalModel$prox)
irisP <- as.data.frame(irisP);
irisP$Species <- rownames(irisP)
p <- qplot(Petal.Width, Petal.Length,col=Species,data=training)
p + geom_point(aes(x=Petal.Width,y=Petal.Length,col=Species),
               size=5,shape=4,data=irisP)

# predicting new values
pred <- predict(modFit,testing)
testing$predRight <- pred==testing$Species
table(pred,testing$Species)

qplot(Petal.Width,Petal.Length,colour=predRight,
      data=testing,main="newdata Predictions")