# -*- coding: utf-8 -*-
"""
Created on Mon Dec 14 13:59:41 2015

@author: steph_000
"""

fname = raw_input("Enter file name: ")
fh = open(fname)
for line in fh:
    line = line.strip()
    print line.upper()

# Write a program that prompts for a file name, then opens that file and 
# reads through the file, looking for lines of the form:
# X-DSPAM-Confidence:    0.8475
# Count these lines and extract the floating point values from each of 
# the lines and compute the average of those values and produce an output 
# as shown below.
# Use the file name mbox-short.txt as the file name

fname = raw_input("Enter file name: ")
fh = open(fname)
count = 0
average = 0
for line in fh:
    if not line.startswith("X-DSPAM-Confidence:") : continue    
    count = count + 1
    fnb = line.find("0")
    average = average + float(line[fnb + 1:])

    
print "Average spam confidence:", average/count