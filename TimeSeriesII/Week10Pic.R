# load libraries
library(forecast)
library(fpp3)
library(ggplot2)

# Assign TS data set to obj
#Quarterly production of woollen yarn in Australia: tonnes. Mar 1965 – Sep 1994.
woolTs = forecast::woolyrnq

# Apply window() to select data we want
# This is quaterly data, we want from Q1 of 1976 - Q4 of 1983
woolTsWind = window(woolTs, start=c(1976, 1), end =c(1983, 4))

# Print a Time Series dataset to the console
woolTsWind

# Apply autoplot()
autoplot(woolTsWind) # auto plots it
# custom
autoplot(woolTsWind) + ggtitle("Quaterly production of woollen yarn in Australia, 1970-1975") + ylab("kilos")

# TRANSFORMATIONS

#  BoxCox.lamba()
# if your time series needs a variance-stabilising transformation
lam = BoxCox.lambda(woolTsWind)
lam

# BoxCox()
# to stabilise the variance
woolTsWindStabil = BoxCox(woolTsWind, lambda = lam)
woolTsWindStabil

# nsdiffs()
# to check if your data needs to be differenced at a seasonal lag
# only neccessary if TS displayed seasonality
nsdiffs(woolTsWindStabil)

# ndiffs()
# to check that if your data needs to be differenced at lag 1 to remove a trend
# only neccessary if your TS has a trend (without seasonality)
ndiffs(woolTsWindStabil)

# diff()
woolTsWindStabilDiff =  diff(woolTsWindStabil, lag = 4)

# ndiffs()
# to check that your differenced data does not need any more transformation via differencing
ndiffs(woolTsWindStabilDiff)

# Acf()
Acf(woolTsWindStabilDiff) # alternatively, use ggAcf()

# Box.test()
# Ljung box test
Box.test(woolTsWindStabilDiff, type = "Ljung-Box", lag=4)

