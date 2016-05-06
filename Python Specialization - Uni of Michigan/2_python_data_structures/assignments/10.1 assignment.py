# -*- coding: utf-8 -*-
"""
Created on Tue Dec 15 20:08:19 2015

@author: steph_000
"""

# Write a program to read through the mbox-short.txt and figure out 
# the distribution by hour of the day for each of the messages. You can 
# pull the hour out from the 'From ' line by finding the time and then 
# splitting the string a second time using a colon.
# From stephen.marquard@uct.ac.za Sat Jan  5 09:14:16 2008
# Once you have accumulated the counts for each hour, print out the counts, 
# sorted by hour as shown below.

name = raw_input("Enter file:")
handle = open(name)
hours = list()
counts = dict()
for line in handle:
    if not line.startswith('From '): continue
    colon = line.find(":")
    hours.append(line[colon - 2: colon])
for hour in hours:
    counts[hour] = counts.get(hour, 0) + 1
for k,v in sorted(counts.items()):
    print k,v