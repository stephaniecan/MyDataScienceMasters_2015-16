load(url("http://www.openintro.org/stat/data/mlb11.RData"))

# Plot the relationship between runs and at_bats, using at_bats as the explanatory variable. 
names(mlb11)
plot(runs ~ at_bats, data = mlb11)
cor(mlb11$runs, mlb11$at_bats)

plot_ss(x = mlb11$at_bats, y = mlb11$runs)
plot_ss(x = mlb11$at_bats, y = mlb11$runs, showSquares = TRUE)

m1 <- lm(runs ~ at_bats, data = mlb11)
summary(m1)

m2 <- lm(runs ~ homeruns, data = mlb11)
summary(m2)

plot(mlb11$runs ~ mlb11$at_bats)
abline(m1)

mlb11$runs[mlb11$at_bats == 5579] # 713
713 - (-2789.2429+0.6305*5579)

plot(m1$residuals ~ mlb11$at_bats)
abline(h = 0, lty = 3)  # adds a horizontal dashed line at y = 0

hist(m1$residuals)
qqnorm(m1$residuals)
qqline(m1$residuals)  # adds diagonal line to the normal prob plot

m3 <- lm(runs ~ hits, data = mlb11)
summary(m3)

m4 <- lm(runs ~ wins, data = mlb11)
summary(m4)

m5 <- lm(runs ~ bat_avg, data = mlb11)
summary(m5)

m6 <- lm(runs ~ new_obs, data = mlb11)
summary(m6)

m7 <- lm(runs ~ new_slug, data = mlb11)
summary(m7)

m8 <- lm(runs ~ new_onbase, data = mlb11)
summary(m8)
