library(ISLR); library(ggplot2); library(caret); 
data(Wage)
Wage <- subset(Wage,select=-c(logwage))
summary(Wage)

inTrain <- createDataPartition(y=Wage$wage,p=0.7, list=FALSE)
training <- Wage[inTrain,]; testing <- Wage[-inTrain,]
dim(training); dim(testing)

# Feature plot
featurePlot(x=training[,c("age","education","jobclass")], 
            y = training$wage,
            plot="pairs")

# plot age versus wage
qplot(age,wage,data=training)

# plot age versus wage colour by jobclass
# can explain outliers
qplot(age,wage,colour=jobclass,data=training)
# plot age versus wage colour by education
qplot(age,wage,colour=education,data=training)

# Fit a linear model
# 10 predictors instead of 3 written in the function because 2 levels of jobclass
# 4 levels of education
modFit <- train(wage ~ age + jobclass + education, 
                method="lm", data=training)
finMod <- modFit$finalModel
print(modFit)

# Diagnostics
plot(finMod,1,pch=19,cex=0.5,col="#00000010")

# Color by variables not used in the model
# fitted values versus real values
# we can see the outliers / identify potential trends
qplot(finMod$fitted,finMod$residuals, colour=race,data=training)

# plot by index
plot(finMod$residuals,pch=19)

# Predicted values versus real values in test set
# If the model fit perfectly the test set values, 
# we would have the values fitting a 45°C line
pred <- predict(modFit, testing)
# Here the year predictor might explain the outliers
qplot(wage,pred,colour=year,data=training)

# Fitting model with all covariates
# ~ . : all the variables in the data set
modFitAll <- train(wage~.,data=training,method="lm")
pred <- predict(modFitAll, testing)
qplot(wage,pred,data=testing)