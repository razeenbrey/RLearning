# Load packages
library(forecast)
library(fpp2)
library(ggplot2)

# Assign gas ts
# df -> Australian monthly gas production: 1956–1995.
df = forecast::gas
df

# Make window
# e wine sales from the start of 1970 to the end of 1989
df_gas = window(df, start=c(1970, 1), end =c(1989, 12))
df_gas

# Summary
summary(df_gas)

# plot
autoplot(df_gas) + ggtitle("Australian monthly gas production")

# smooth
dfma = ma(df_gas, 12)
dfma
autoplot(df_gas) + autolayer(dfma)

# train -  training set should end at the end of 1988
# test -  test set should start in January and end in December 1989
dfTrain = window(df, start=c(1970, 1), end =c(1988, 12))
dfTest = window(df, start=c(1989, 1), end =c(1989, 12))
dfTrain
dfTest

# fit exp smoothing
mod1 = holt(dfTrain, h=12)
mod2 = hw(dfTrain, h=12, seasonal = "multiplicative")

# Print
mod1[["model"]]
mod2[["model"]]

# summary
summary(mod1)
summary(mod2)

# plot
# Original data with forecasts overlaid
autoplot(df_gas) + autolayer(mod1)
autoplot(df_gas) + autolayer(mod2)
# Without prediction intervals
autoplot(df_gas) + autolayer(mod1, PI=F)
autoplot(df_gas) + autolayer(mod2, PI=F)

#  Check residuals
checkresiduals(mod1)
checkresiduals(mod2)

# Asses accuracy
accuracy(mod1)
accuracy(mod2)


