# calculate how much of mortgage will be covered by ALTUM garancy fund
altumCoverage <- (newHousePrice * altumMaxGarancyPrc) %>% ifelse(. > altumMaxGarancy, altumMaxGarancy, .)

selfCoverage <- newHousePrice * minimalSelfPayFirstPaymentPrc

totalCoverage <- altumCoverage + selfCoverage

# check more than minimalSelfPayFirstPaymentPrc needs to be paid as first payment
if (totalCoverage/newHousePrice < minimalFirstPaymentPrc) {
  selfCoverage <- selfCoverage + (minimalFirstPaymentPrc - totalCoverage/newHousePrice) * newHousePrice
}

print(paste0('ALTUM will cover ', altumCoverage))
print(paste0('You will need to cover ', selfCoverage))



# Understand for how long should you pay your mortgage given your comfortable monthly payment plus the fact that we sell the house
potentialMortgagePayment <- potentialRentalPrice + ourPaymentPart
mortgageDealValue <- newHousePrice - selfCoverage
optimalDuration <- mortageLoanDurationYears
repeat {
  results <- mortgage(mortgageDealValue, interestRate*100, optimalDuration, T, F)
  if (max(aDFmonth$Monthly_Payment) < potentialMortgagePayment) {
    optimalDuration <- optimalDuration - 1 # if payment is too small then decrease loan duration by 1 year
  } else {
    print(paste0('Optimal loan duration is ', optimalDuration, ' with monthly payment ', max(aDFmonth$Monthly_Payment)))
    mortgage(mortgageDealValue, interestRate*100, optimalDuration, T, T)
    break
  }
}
# 15 years, 720mon payment


### If we sell our current flat then deal value is much lower, but the monthly payment will be smaller
potentialMortgagePayment <- ourPaymentPart
mortgageDealValue <- newHousePrice - selfCoverage - currentFlatPrice
optimalDuration <- mortageLoanDurationYears
repeat {
  results <- mortgage(mortgageDealValue, interestRate*100, optimalDuration, T, F)
  if (max(aDFmonth$Monthly_Payment) < potentialMortgagePayment) {
    optimalDuration <- optimalDuration - 1 # if payment is too small then decrease loan duration by 1 year
  } else {
    print(paste0('Optimal loan duration is ', optimalDuration, ' with monthly payment ', max(aDFmonth$Monthly_Payment)))
    mortgage(mortgageDealValue, interestRate*100, optimalDuration, T, T)
    break
  }
}
# 23 years, 303mon payment













