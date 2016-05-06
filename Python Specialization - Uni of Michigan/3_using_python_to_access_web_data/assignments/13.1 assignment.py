import urllib
import xml.etree.ElementTree as ET

while True:
    url = raw_input('Enter URL: ')
    if len(url) < 1 : break
    print 'Retrieving', url 
    xml = urllib.urlopen(url).read()
    input = ET.fromstring(xml)
    break

print 'Retrieved', len(xml), 'characters'
numbers = input.findall('.//comment')

count = 0
addup = 0
for number in numbers:
    add = number.find('count').text
    add = int(add)
    count = count + 1
    addup = addup + add
    
print 'Count:', count
print 'Sum:', addup
