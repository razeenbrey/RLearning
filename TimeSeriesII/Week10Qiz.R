# load libraries
library(forecast)
library(fpp3)
library(ggplot2)
library(fpp2)

dt = fpp2::ausair
dt

checkresiduals(dt)
autoplot(dt) + ggtitle(" total annual air passengers (in millions) of air carriers registered in Australia")

# ndiffs()
# to check that if your data needs to be differenced at lag 1 to remove a trend
# only neccessary if your TS has a trend (without seasonality)
ndiffs(dt)

# diff()
dtDiff =  diff(dt, lag = 12)

# ndiffs()
# to check that your differenced data does not need any more transformation via differencing
ndiffs(woolTsWindStabilDiff)

# Acf()
Acf(woolTsWindStabilDiff) # alternatively, use ggAcf()