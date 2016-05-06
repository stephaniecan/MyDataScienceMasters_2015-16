# -*- coding: utf-8 -*-
"""
Created on Thu Dec 17 19:49:52 2015

@author: steph_000
"""

fname = raw_input('Enter file name: ')
fhand = open(fname)
file = fhand.read()
import re

words = re.findall('[0-9]+', file)

counts = 0
for word in words:
    word = int(word)
    counts = counts + word
print counts