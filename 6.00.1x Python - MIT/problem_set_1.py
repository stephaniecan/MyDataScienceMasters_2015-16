# MITx: 6.00.1x Introduction to Computer Science and Programming Using Python

# Problem set 1

# Problem 1
# Program that counts up the number of vowels contained in the string "s" of 
# lower case characters. "s" is defined by MIT staff

count = 0
vowels = 'aeiou'

for i in s:
    if i in vowels:
        count += 1

print 'Number of vowels: ', count

# Problem 2
# Program that prints the number of times the string 'bob' occurs in "s".
# "s" still being a string of lower case characters pre-defined by MIT staff

count = 0
start = 0
for i in s:
    if s.find('bob', start, start+3) != -1:
        count += 1
        start += 1
    else:
        start += 1
print 'Number of times bob occurs is: ', count

# MIT answer
numBobs = 0
for i in range(1, len(s)-1):
    if s[i-1:i+2] == 'bob':
        numBobs += 1
print 'Number of times bob occurs is:', numBobs

# Problem 3
# Program that prints the longest substring of s in which the letters occur
# in alphabetical order.

def alpha_order(string, e):
    '''
    string: string of lower case characters

    returns: True if two successive char occur in alphabetical order and False otherwise.
    '''
    if string[e] <= string[e+1]:
        return True
    else:
        return False

abc = ''
abc2 = ''
count = 0
count2 = 0

for i in range(0, len(s)-1):
    if alpha_order(s,i) == True:
        count += 1
        abc += s[i]
    elif alpha_order(s,i) == False:
        if count2 <= count:
            count2 = count + 1
            abc2 = abc + s[i]
            count = 0
            abc = ''
        elif count2 > count:
            count = 0
            abc = ''
            
if count2 <= count:
    count2 = count + 1
    abc2 = abc + s[len(s)-1]
elif count == len(s)-1:
    count2 = count +1
    abc2 = abc + s[len(s)-1]     
    
print 'Longest substring in alphabetical order is: ', abc2

# MIT answer (much shorter!!)

curString = s[0]
longest = s[0]
for i in range(1, len(s)):
    if s[i] >= curString[-1]:
        curString += s[i]
        if len(curString) > len(longest):
            longest = curString
    else:
        curString = s[i]
print 'Longest substring in alphabetical order is:', longest
        