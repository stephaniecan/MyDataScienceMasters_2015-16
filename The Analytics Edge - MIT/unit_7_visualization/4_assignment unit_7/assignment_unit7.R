parole = read.csv("parole.csv")
str(parole)

parole$male = as.factor(parole$male)
parole$state = as.factor(parole$state)
parole$crime = as.factor(parole$crime)

# What fraction of parole violators are female?
table(parole$male,parole$violator)
14/(14+64)

# which crime is the most common in Kentucky?
plot(x = parole$state, y = parole$crime)

library(ggplot2)
ggplot(data = parole, aes(x = age)) + geom_histogram(binwidth = 5, color="blue")

# Create a separate histogram for each gender, top of each other
ggplot(data = parole, aes(x = age)) + geom_histogram(binwidth = 5) + facet_grid(male ~ .)
# Create a separate histogram for each gender, side by side
ggplot(data = parole, aes(x = age)) + geom_histogram(binwidth = 5) + facet_grid(.~male)

# produce a histogram where data points are colored by group
ggplot(data = parole, aes(x = age, fill = male)) + geom_histogram(binwidth = 5)

# Create our own color palette, colorblind-friendly palette
colorPalette = c("#000000", "#E69F00", "#56B4E9", "#009E73", "#F0E442", "#0072B2", "#D55E00", "#CC79A7")

ggplot(data = parole, aes(x = age, fill = male)) + geom_histogram(binwidth = 5) + scale_fill_manual(values=colorPalette)

# Tell ggplot not to stack the histograms and make the bars semi-transparent so we can see both colors 
ggplot(data = parole, aes(x = age, fill = male)) + geom_histogram(binwidth = 5, position="identity", alpha=0.5) + scale_fill_manual(values=colorPalette)

ggplot(data = parole, aes(x = time.served)) + geom_histogram(binwidth=1, color="blue")+ facet_grid(crime~.)
