# Covariate = feature

library(ISLR); library(caret); data(Wage)
inTrain <- createDataPartition(y=Wage$wage,
                               p=0.7, list=FALSE)
training <- Wage[inTrain,]
testing <- Wage[-inTrain,]

# Dummy variables
# The qualitative covariates (here Industrial & Information jobclasses) are difficult
# to use for predictions (set of characters)
# It is better to turn these covariates into quantitative variables
table(training$jobclass)
# dummyVars: outcome is wage, jobclass is the predictor variable,
# training set is where we are going to build the dummy variables
# We get two new variables (indicating Industrial & Information job class
# with quantitative variables 0 & 1)
dummies <- dummyVars(wage~jobclass, data=training)
head(predict(dummies,newdata=training))

# Remove zero covariates
# Some covariates have no variability so they won't be good predictors
# nearZeroVar (caret package)
# nzv (near zero variance variable): when a covariate has only one category (freqRatio near 0
# e.g. if the sex is male most of the time, then this covariate won't bring anything to the prediction).
# we can use "nzv" to throw away some covariates not useful (when nzv=TRUE)
nsv <- nearZeroVar(training, saveMetrics=TRUE)
nsv

# Spline basis (splines package)
# Curvy lines. bs function creates polinomial variables
# df : how many degrees for the polinomial function
library(splines)
bsBasis <- bs(training$age,df=3)
# Here we get 3 new variables. First column, variable corresponds to age value scaled for computation.
# 2nd is age squared, 3rd is age cube
bsBasis

# Fitting curves with splines
lm1 <- lm(wage ~ bsBasis, data = training)
plot(training$age,training$wage,pch=19,cex=0.5)
# Generates the curvy line
points(training$age,predict(lm1,newdata=training),col="red",pch=19,cex=0.5)

# Splines on the test set
predict(bsBasis,age=testing$age)
