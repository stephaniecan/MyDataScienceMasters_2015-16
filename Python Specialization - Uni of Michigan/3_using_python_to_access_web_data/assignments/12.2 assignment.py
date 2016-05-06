# Note - this code must run in Python 2.x and you must download
# http://www.pythonlearn.com/code/BeautifulSoup.py
# Into the same folder as this program

import urllib
from BeautifulSoup import *

url = raw_input('Enter - ')
html = urllib.urlopen(url).read()

soup = BeautifulSoup(html)

# Retrieve all of the span tags
tags = soup('span')
numbers = list()
counts = 0
addup = 0
for tag in tags:
    # Pull out the numbers and convert them to integers
    number = tag.contents[0]
    number = int(number)
    # Sum all the numbers
    counts = counts + 1
    addup = addup + number
print 'Count', counts
print 'Sum', addup

