library(ISLR); library(ggplot2); library(caret)
data(Wage)
summary(Wage)

# get training/test sets
inTrain <- createDataPartition(y=Wage$wage,
                               p=0.7, list=FALSE)
training <- Wage[inTrain,]
testing <- Wage[-inTrain,]
dim(training)
dim(testing)

featurePlot(x=training[c("age","education","jobclass")],y=training$wage,plot="pairs")
qplot(age,wage,data=training)

# Qplot with color: show variation in the data
# understand why there is some outliers data
qplot(age,wage,colour=jobclass,data=training)

# Add regression smoothers (ggplot2 packages)
qq <- qplot(age,wage,colour=education,data=training)
qq + geom_smooth(method='lm',formula=y~x)

# cut2 function to making factors (Hmisc package)
# break up in different categories
# g = how many groups to break the dataset into
library(Hmisc)
cutWage <- cut2(training$wage,g=3)
table(cutWage)

# Boxplots with cut2
# see the trends more clearly. Here relation between wage groups and age
p1 <- qplot(cutWage,age,data=training,fill=cutWage,geom=c("boxplot"))
p1

# Boxplots with points overlayed
p2 <- qplot(cutWage,age,data=training,fill=cutWage,geom=c("boxplot","jitter"))

# get two plots on the same page
library(gridExtra)
grid.arrange(p1,p2,ncol=2)

# Tables to compare data
t1 <- table(cutWage,training$jobclass)
t1
# Tables to get the proportions in each group
# 1 for proportion in each row
# 2 for proportion in each column
prop.table(t1,1)
prop.table(t1,2)

# Density plots
qplot(wage, colour=education,data=training,geom="density")
