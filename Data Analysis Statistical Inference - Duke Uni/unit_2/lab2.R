load(url("http://www.openintro.org/stat/data/kobe.RData"))
head(kobe)
kobe$basket[1:9]

kobe_streak <- calc_streak(kobe$basket)
barplot(table(kobe_streak))

boxplot(kobe_streak)

# simulate flipping a fair coin
outcomes <- c("heads", "tails")
sample(outcomes, size = 1, replace = TRUE)
sim_fair_coin <- sample(outcomes, size = 100, replace = TRUE)
sim_fair_coin
table(sim_fair_coin)

# simulate an unfair coin that only lands heads 20% of the time.
sim_unfair_coin <- sample(outcomes, size = 100, replace = TRUE, prob = c(0.2, 0.8))
table(sim_unfair_coin)

# Simulating an independant shooter
outcomes <- c("H", "M")
sim_basket <- sample(outcomes, size = 133, replace = TRUE, prob = c(0.45,0.55))
independant_streak = calc_streak(sim_basket)
sim_basket2 <- sample(outcomes, size = 133, replace = TRUE)
