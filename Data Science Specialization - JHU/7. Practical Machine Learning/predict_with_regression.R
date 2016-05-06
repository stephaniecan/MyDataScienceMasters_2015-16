library(caret);data(faithful); set.seed(333)
inTrain <- createDataPartition(y=faithful$waiting, p=0.5, list=FALSE)
trainFaith <- faithful[inTrain,]; testFaith <- faithful[-inTrain,]
head(trainFaith)

plot(trainFaith$waiting,trainFaith$eruptions,pch=19,col="blue",xlab="Waiting",ylab="Duration")

# Fit a linear model
lm1 <- lm(eruptions ~ waiting, data = trainFaith)
summary(lm1)
plot(trainFaith$waiting,trainFaith$eruptions,pch=19,col="blue",xlab="waiting",ylab="duration")
# IMPORTANT: lmfit$fitted: gives the fitted values
lines(trainFaith$waiting,lm1$fitted,lwd=3)

# Predict a new value
# E.g. new value for waiting time = 80
# Here we don't use the error term because we don't know it
coef(lm1)[1] + coef(lm1)[2]*80
# Alternative
newdata <- data.frame(waiting=80)
predict(lm1,newdata)

# Plot predictinons - training and test
par(mfrow=c(1,2))
plot(trainFaith$waiting,trainFaith$eruptions,pch=19,col="blue",xlab="waiting",ylab="duration")
lines(trainFaith$waiting,predict(lm1),lwd=3)
plot(testFaith$waiting,testFaith$eruptions,pch=19,col="blue",xlab="waiting",ylab="duration")
# the linear line is what has been predicted for the training set
lines(testFaith$waiting,predict(lm1,newdata=testFaith),lwd=3)

# Get training set / test set errors

# Calculate RMSE on training (Root Mean Squarred error)
# It measures how close the fitted values are from the real values
sqrt(sum((lm1$fitted-trainFaith$eruptions)^2))
# Calculate RMSE on test (Root Mean Squarred error)
sqrt(sum((predict(lm1,newdata=testFaith)-testFaith$eruptions)^2))

# Prediction intervals

pred1 <- predict(lm1,newdata=testFaith, interval="prediction")
ord <- order(testFaith$waiting)
plot(testFaith$waiting,testFaith$eruptions,pch=19,col="blue")
matlines(testFaith$waiting[ord], pred1[ord,], type="l",col=c(1,2,2),lty = c(1,1,1),lwd=3)

# Same process with caret
modFit <- train(eruptions~waiting,data=trainFaith,method="lm")
summary(modFit$finalModel)