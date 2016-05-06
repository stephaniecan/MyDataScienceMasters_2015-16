# -*- coding: utf-8 -*-
"""
Created on Sun Dec 20 17:40:10 2015

@author: steph_000
"""

# The program prompts for a URL, read the JSON data from that URL using urllib 
# and then parse and extract the comment counts from the JSON data, compute the
# sum of the numbers in the file

import urllib
import json

while True:
    url = raw_input('Enter location: ')
    if len(url) < 1 : break
    print 'Retrieving', url
    uh = urllib.urlopen(url)
    data = uh.read()
    break

print 'Retrieved', len(data), 'characters'
info = json.loads(data)

count = 0
addup = 0
x = 0
for item in info["comments"]:
    add = info["comments"][x]["count"]
    count = count + 1
    addup = addup + add
    x = x + 1

print 'Count:', count
print 'Sum:', addup