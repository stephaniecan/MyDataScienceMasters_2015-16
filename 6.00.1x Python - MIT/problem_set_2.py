# MITx: 6.00.1x Introduction to Computer Science and Programming Using Python

# Problem set 2

# Problem 1
# Write a program to calculate the credit card balance after one year if a 
# person only pays the minimum monthly payment required by the credit card 
# company each month.

# Monthly interest rate= (Annual interest rate) / 12.0
# Minimum monthly payment = (Minimum monthly payment rate) x (Previous balance)
# Monthly unpaid balance = (Previous balance) - (Minimum monthly payment)
# Updated balance each month = (Monthly unpaid balance) + (Monthly interest rate x Monthly unpaid balance)

balance = 4213 # variable to change
annualInterestRate = 0.2 # variable to change
monthlyPaymentRate = 0.04 # variable to change

totalpaid = 0

for i in range(1, 13):
    print 'Month:', i
    minimumMonthlyPayment = monthlyPaymentRate * balance
    print 'Minimum monthly payment: ', round(minimumMonthlyPayment, 2)
    totalpaid += minimumMonthlyPayment
    monthlyUnpaidBalance = balance - minimumMonthlyPayment
    monthlyInterestRate = annualInterestRate / 12.0
    balance = monthlyUnpaidBalance + monthlyInterestRate * monthlyUnpaidBalance
    print 'Remaining balance: ', round(balance, 2)

print 'Total paid: ', round(totalpaid, 2)
print 'Remaining balance: ', round(balance, 2)

# MIT correction

monthlyInterestRate = annualInterestRate/12
totalPaid = 0

for i in range(12):
    minPay = monthlyPaymentRate*balance
    monthlyUnpaid = balance - minPay
    balance = monthlyUnpaid + monthlyInterestRate*monthlyUnpaid
    totalPaid += minPay
    print "Month: "+str(i+1)
    print "Minimum monthly payment: "+str(round(minPay,2))
    print "Remaining balance: " + str(round(balance,2))
    

print "Total paid: "+str(round(totalPaid,2))
print "Remaining balance: "+str(round(balance,2))
      