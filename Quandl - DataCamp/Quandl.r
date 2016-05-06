# The quantmod and Quandl package is ready for use:
library(quantmod) # to plot
library(Quandl) # to access data

# The Quandl package is able to return data in 4 very usable formats:
# data frame ("raw"),
# ts ("ts"),
# zoo ("zoo") and
# xts ("xts")

# Load the Facebook data with the help of Quandl
Facebook <- Quandl("GOOG/NASDAQ_FB",type= "xts")

# Plot the chart with the help of candleChart()
candleChart(Facebook) # or
chartSeries(Facebook)

# Search Quandl datasets using R 
Quandl.search(query = "Search Term", page = int, 
              source = "Specific source to search", 
              silent = TRUE|FALSE)
# query is the only mandatory argument and represents 
# the term you wish to search for on Quandl. page is 
# which page of search result you wish to return (default = 1), 
# and source lets you choose the specific source you wish to search for. 
# By putting silent to FALSE you see the first 3 results printed to 
# the console. If silent is set to TRUE it does not print anything to screen.
# What if you want to see all search results on the first page? You can 
# assign the result of the Quandl.search() function to a variable, and then 
# print this variable to find out about all search results.

# Look up the first 3 results for 'Bitcoin' within the Quandl database:
results <- Quandl.search(query = "Bitcoin", page = 1, 
                         silent = FALSE)

# Print out the results
str(results)

# Assign the data set with code BCHAIN/TOTBC
BitCoin <- Quandl("BCHAIN/TOTBC")

# The Quandl() function has two arguments start_date and end_date,
# that can be used to specify the time range of the data to load. 
# The format to specify the date is: yyyy-mm-dd.

# Assign to the variable Exchange
Exchange <- Quandl("BNP/USDEUR", start_date = "2013-01-01", end_date="2013-12-01")

# Quandl can transform your data before serving it. You can set the transformation argument to:
# "diff"
# "rdiff"
# "cumul", and
# "normalize".

# More info: https://www.quandl.com/help/api

# The result:
GDP_Change <- Quandl("FRED/CANRGDPR", transformation="rdiff")

# You don't always need every available data tick for your analysis.
# Sometimes having the data available on a daily or weekly base is 
# sufficient. By altering the collapse parameter you can easily indicate 
# the desired frequency. The available options are:
# none|daily|weekly|monthly| quarterly|annual
# Quandl returns the last observation for the given period. So, if you 
# collapse a daily dataset to "monthly", you will get a sample of the 
# original dataset where the observation for each month is the last data 
# point available for that month.

# The result:
eiaQuarterly <- Quandl("DOE/RWTC", collapse="quarterly")

# Assign to TruSo the first 5 observations of the crude oil prices
TruSo <- Quandl("DOE/RWTC", sort= "asc", rows=5)

# Print the result
TruSo

# You want to have the daily percent change in oil prices from January 2005 to March 2010, in ascending order.
Final =Quandl("DOE/RWTC", sort="asc", collapse="daily", start_date = "2005-01-01", end_date="2010-03-01", transformation="rdiff")
