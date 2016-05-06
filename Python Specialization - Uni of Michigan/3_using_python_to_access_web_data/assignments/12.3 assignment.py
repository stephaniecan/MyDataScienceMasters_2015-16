# Note - this code must run in Python 2.x and you must download
# http://www.pythonlearn.com/code/BeautifulSoup.py
# Into the same folder as this program

import urllib
from BeautifulSoup import *

url = raw_input('Enter URL: ')
count = raw_input('Enter count: ')
position = raw_input('Enter position: ')
position = int(position)
count = int(count)

# Retrieve all of the anchor tags
x = 0
while x < count:
    html = urllib.urlopen(url).read()
    soup = BeautifulSoup(html)
    tags = soup('a')
    tag = tags[position-1]
    name = tag.get('href', None)
    print name
    url = name
    x = x + 1
        
