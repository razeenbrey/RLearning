# load libraries
library(forecast)
library(fpp3)
library(ggplot2)

df = forecast::wineind
autoplot(df)
dt = window(df, start=c(1980, 1), end =c(1985, 12))

dt

# PLot
autoplot(dt) + ggtitle("Monthly Australian wine sales") + ylab(" bottles <= 1 litre")

# Question 5
lam = BoxCox.lambda(dt)
lam
# BoxCox()
# to stabilise the variance
dtStabil = BoxCox(dt, lambda = lam)
dtStabil
autoplot(dtStabil)


# Question 6
nsdiffs(dtStabil) # returns 1

# diff()
dtStabilDiff =  diff(dtStabil, lag = 12)

# ndiffs()
# to check that your differenced data does not need any more transformation via differencing
ndiffs(dtStabilDiff) # returns 0

# Question 7
Acf(dtStabilDiff)


# Question 8
# train end at 1984
# test full 1985
dtTrain = window(df, start=c(1980, 1), end =c(1984, 12))
dtTest = window(df, start=c(1985, 1), end =c(1985, 12))
dtTest

# Question 9
modSmp = snaive(dtTrain, h=12)
autoplot(dt) + autolayer(modSmp)
autoplot(dt) + autolayer(modSmp, PI=F)

# Question 10
checkresiduals(modSmp)
Box.test(dtStabilDiff, type = "Ljung-Box", lag=12)
