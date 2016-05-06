# VIDEO 4

# Read in data
wine = read.csv("wine.csv")
str(wine)
summary(wine)

# Linear Regression (one variable)
model1 = lm(Price ~ AGST, data=wine)
summary(model1)

# Coefficients:
# Estimate Std. Error t value Pr(>|t|)    
# (Intercept)  -3.4178     2.4935  -1.371 0.183710    
# AGST          0.6351     0.1509   4.208 0.000335

# Residual standard error: 0.4993 on 23 degrees of freedom
# Multiple R-squared:  0.435,	Adjusted R-squared:  0.4105 
# F-statistic: 17.71 on 1 and 23 DF,  p-value: 0.000335

# Beta 0 = -3.4178   
# Beta 1 = 0.6351
# R-squared (lecture) = 0.435
# Adjusted R-squared =  0.4105 ; It adjusts the R-squared value to account 
# for the number of independent variables used relative to the number of data 
# points. 
# Multiple R-squared will always increase if you add more independent variables
# but adjusted R-squared will decrease if you add an independent variable that doesn't
# help the model. You can then determine if you include the variable to the model or not.


# Sum of Squared Errors
model1$residuals # values of all residuals
SSE = sum(model1$residuals^2)
SSE

# Linear Regression (two variables)
model2 = lm(Price ~ AGST + HarvestRain, data=wine)
summary(model2)

# Sum of Squared Errors
SSE = sum(model2$residuals^2)
SSE

# Linear Regression (all variables)
model3 = lm(Price ~ AGST + HarvestRain + WinterRain + Age + FrancePop, data=wine)
summary(model3)

# Sum of Squared Errors
SSE = sum(model3$residuals^2)
SSE


# VIDEO 5

# Remove FrancePop
model4 = lm(Price ~ AGST + HarvestRain + WinterRain + Age, data=wine)
summary(model4)


# VIDEO 6

# Correlations
cor(wine$WinterRain, wine$Price)
cor(wine$Age, wine$FrancePop)
cor(wine)

# Remove Age and FrancePop
model5 = lm(Price ~ AGST + HarvestRain + WinterRain, data=wine)
summary(model5)


# VIDEO 7

# Read in test set
wineTest = read.csv("wine_test.csv")
str(wineTest)

# Make test set predictions
predictTest = predict(model4, newdata=wineTest)
predictTest

# Compute R-squared
SSE = sum((wineTest$Price - predictTest)^2)
SST = sum((wineTest$Price - mean(wine$Price))^2)
1 - SSE/SST

