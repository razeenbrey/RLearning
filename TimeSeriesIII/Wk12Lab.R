# Load packages
library(forecast)
library(fpp2)
library(ggplot2)

# Assign wineind ts
# df -> monthly Australian wine sales
# Australian total wine sales by wine makers in bottles <= 1 litre. Jan 1980 – Aug 1994.
df = forecast::wineind
df

# Make window
# e wine sales from the start of 1980 to the end of 1987
dt = window(df, start=c(1980, 1), end =c(1987, 12))

# print original ts and plot
dt
autoplot(dt) + ggtitle("Australian total wine sales by wine makers") + ylab("bottles <= 1 litre")

# Split dt
# train -> end at the end of 1986
# test -> start in January of 1987 and end in December of 1987
dtTrain = window(dt, start = c(1980,1), end = c(1986,12))
dtTest = window(dt, start=c(1987,1), end = c(1987,12))
dtTrain
dtTest

# Fit 2 exp smoothing models
# mod1 -> capture only the underlying trend
# mod2 -> capture both the trend and the seasonality
# fh = 12 time periods
mod1 = holt(dtTrain, h=12)
mod2 = hw(dtTrain, h=12, seasonal = "multiplicative")

# Print
mod1[["model"]]
mod2[["model"]]
# Original data with forecasts overlaid
autoplot(dt) + autolayer(mod1)
autoplot(dt) + autolayer(mod2)
# Without prediction intervals
autoplot(dt) + autolayer(mod1, PI=F)
autoplot(dt) + autolayer(mod2, PI=F)

#  Check residuals
checkresiduals(mod1)
checkresiduals(mod2)

# Asses accuracy
accuracy(mod1)
accuracy(mod2)
