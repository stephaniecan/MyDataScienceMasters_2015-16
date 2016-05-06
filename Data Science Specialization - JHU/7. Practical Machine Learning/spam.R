library(kernlab)
data(spam)
head(spam)
View(spam)
colnames(spam)
plot(density(spam$your[spam$type=="nonspam"]),col="blue",main="spam or nonspam",xlab="frequency of 'your'")
lines(density(spam$your[spam$type=="spam"]),col="red")
abline(v=0.5,col="black")
prediction <- ifelse(spam$your > 0.5, "spam","nonspam")
table(prediction,spam$type)/length(spam$type)

dim(spam)[1]
dim(spam)[2]
smallspam <- spam[sample(dim(spam)[1],size=10),]
spamlabel <- (smallspam$type=="spam")*1+1
plot(smallspam$capitalAve,col=spamlabel)

rule1 <- function(x) {
  prediction <- rep(NA,length(x))
  prediction[x > 2.70] <- "spam"
  prediction[x < 2.40] <- "nonspam"
  prediction[(x >= 2.40 & x <= 2.45)] <- "spam"
  prediction[x> 2.45 & x <= 2.70] <- "nonspam"
  return(prediction)
}

table(rule1(smallspam$capitalAve),smallspam$type)

table(rule1(spam$capitalAve),spam$type)

sum(rule1(spam$capitalAve)==spam$type)