# Part A
load(url("http://bit.ly/dasi_nc"))

gained_clean = na.omit(nc$gained)
length(nc$gained)
n = length(gained_clean)

# Bootstrapping

boot_means = rep(NA, 100)

for(i in 1:100){
        boot_sample = sample(gained_clean, n, replace = TRUE)
        boot_means[i] = mean(boot_sample)                       
}

hist(boot_means)

# Exercise: Estimate a 90% confidence interval using the percentile method for the average weight gained by mothers during pregnancy, explain briefly how you estimated the interval, and interpret this interval in context of the data.

(100*0.1)/2 # 5

bootmeans = boot_means[6:95]
length(bootmeans) # 90
bootmeans = sort(bootmeans)
bootmeans[1] # 29.38335
bootmeans[90] # 31.59301

# We are 90 % confident that mothers gain on average 29 to 32 pounds during pregnancy

source("http://bit.ly/dasi_inference")

# By default the function takes 10,000 bootstrap samples (instead of the 100 you've taken above), creates a bootstrap distribution, and calculates the confidence interval, using the percentile method.

inference(nc$gained, type = "ci", method = "simulation", conflevel = 0.90, est = "mean", boot_method = "perc")

# We can easily change the confidence level to 95% by changing the conflevel:

inference(nc$gained, type = "ci", method = "simulation", conflevel = 0.95, est = "mean", boot_method = "perc")

# We can easily use the standard error method by changing the boot_method:
        
inference(nc$gained, type = "ci", method = "simulation", conflevel = 0.95, est = "mean", boot_method = "se")

# Or create an interval for the median instead of the mean:
        
inference(nc$gained, type = "ci", method = "simulation", conflevel = 0.95, est = "median", boot_method = "se")

# nc$fage
inference(nc$fage, type = "ci", method = "simulation", conflevel = 0.95, est = "mean", boot_method = "se")

by(nc$weight, nc$habit, mean)

# Inference hypothesis
inference(y = nc$weight, x = nc$habit, est = "mean", type = "ht", null = 0, alternative = "twosided", method = "theoretical", order = c("smoker","nonsmoker"))

# Inference confidence interval
inference(y = nc$weight, x = nc$habit, est = "mean", type = "ci", method = "simulation", conflevel = 0.95, boot_method = "se")

plot(x = nc$mature, y = nc$mage)

min(nc$mage[which(nc$mature == "mature mom")]) # 35
max(nc$mage[which(nc$mature == "younger mom")]) # 34

# Part B
load(url("http://bit.ly/dasi_gss_ws_cl"))

summary(gss)
hist(gss$wordsum)
plot(gss$class)
plot(gss$class, gss$wordsum)

inference(y = gss$wordsum, x = gss$class, est = "mean", type = "ht", alternative = "greater", method = "theoretical")