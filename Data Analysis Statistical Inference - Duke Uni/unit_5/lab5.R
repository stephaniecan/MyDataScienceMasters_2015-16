source("http://bit.ly/dasi_inference")

load(url("http://www.openintro.org/stat/data/atheism.RData"))

us12 <-subset(x = atheism, subset = nationality == "United States" & year == "2012")

inference(us12$response, est = "proportion", type = "ci", method = "theoretical", conflevel = 0.95, success = "atheist")

1.96*0.0069

n <- 1000
p <- seq(0, 1, 0.01)
me <- 2*sqrt(p*(1 - p)/n)
plot(me ~ p)

spain = subset(atheism, nationality== "Spain")

inference(y = spain$response, x = spain$year, est = "proportion", type = "ht", alternative = "twosided", method = "theoretical", null = 0, success = "atheist")

us = subset(atheism, nationality == "United States")

inference(y = us$response, x = us$year, est = "proportion", type = "ht", alternative = "twosided", method = "theoretical", null = 0, success = "atheist")

