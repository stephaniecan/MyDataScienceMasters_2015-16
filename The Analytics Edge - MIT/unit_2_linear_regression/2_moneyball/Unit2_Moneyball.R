# VIDEO 2

# Read in data
baseball = read.csv("baseball.csv")
str(baseball)

# Subset to only include moneyball years
moneyball = subset(baseball, Year < 2002)
str(moneyball)

# Compute Run Difference
moneyball$RD = moneyball$RS - moneyball$RA
str(moneyball)

# Scatterplot to check for linear relationship
plot(moneyball$RD, moneyball$W)

# Regression model to predict wins
WinsReg = lm(W ~ RD, data=moneyball)
summary(WinsReg)


# VIDEO 3

str(moneyball)

# Regression model to predict runs scored
RunsReg = lm(RS ~ OBP + SLG + BA, data=moneyball)
summary(RunsReg)

RunsReg = lm(RS ~ OBP + SLG, data=moneyball)
summary(RunsReg)

x= c(0.338, 0.391, 0.369, 0.313, 0.361)
y = c(0.540, 0.450, 0.374, 0.447, 0.500)
-804.63 + 2737.77 * x + 1584.91 * y
# [1] 976.5877 979.0476 798.3635 760.7468 976.1600

teamRank = c(1,2,3,3,4,4,4,4,5,5)
wins2012 = c(94,88,95,88,93,94,98,97,93,94)
wins2013 = c(97,97,92,93,92,96,94,96,92,90)
cor(teamRank,wins2012)
cor(teamRank,wins2013)

# Since one of the correlations is positive and the other is negative, 
# this means that there does not seem to be a pattern between regular 
# season wins and winning the playoffs. We wouldn't feel comfortable 
# making a bet for this year given this data!
