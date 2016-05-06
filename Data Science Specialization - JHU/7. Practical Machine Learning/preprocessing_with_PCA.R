# Sometimes, some variables are very close to each other, sometimes the same so
# it is better to leave out the ones we don't need

# Correlated predictors
library(caret); library(kernlab); data(spam)
inTrain <- createDataPartition(y=spam$type,
                               p=0.75, list=FALSE)
training <- spam[inTrain,]
testing <- spam[-inTrain,]
# leave out the 58th row (here the outcome)
# cor: calculate the correlation between the predictor variables
# abs: take the absolute value
# look for predictor variables that are very close to each other/correlated
M <- abs(cor(training[,-58]))
diag(M) <- 0
which(M > 0.8,arr.ind=T)
# See the correlated predictors
names(spam)[c(34,32)]
plot(spam[,34],spam[,32])

# Principal components in R - prcomp
smallSpam <- spam[,c(34,32)]
prComp <- prcomp(smallSpam)
plot(prComp$x[,1],prComp$x[,2])

# Rotation: how to sum up the PCA
# PC1: explains the most variability (sum the variables here)
#PC2 explains the second most...
prComp$rotation

# PCA on SPAM data
# PC1: more variation
typeColor <- ((spam$type=="spam")*1+1)
prComp <- prcomp(log10(spam[,-58]+1))
plot(prComp$x[,1],prComp$x[,2], col=typeColor,xlab="PC1",ylab="PC2")

# PCA with caret packages
# method pca. pcaComp=2: two PCA
library(caret)
preProc <- preProcess(log10(spam[,-58]+1),method="pca",pcaComp=2)
spamPC <- predict(preProc,log10(spam[,-58]+1))
plot(spamPC[,1],spamPC[,2],col=typeColor)

# Preprocessing with PCA for training set
preProc <- preProcess(log10(spam[,-58]+1),method="pca",pcaComp=2)
trainPC <- predict(preProc,log10(training[,-58]+1))
modelFit <- train(training$type ~ .,method="glm",data=trainPC)

# Preprocessing with PCA for test set
testPC <- predict(preProc,log10(testing[,-58]+1))
# confusionMatrix: get the accuracy (caret)
confusionMatrix(testing$type,predict(modelFit,testPC))

# Alternative preprocessing with PCA
modelfit <- train(training$type ~.,method="glm", preProcess="pca",data=training)
confusionMatrix(testing$type,predict(modelfit, testing))