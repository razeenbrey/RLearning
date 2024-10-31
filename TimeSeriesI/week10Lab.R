# Load packages
library(forecast)
library(ggplot2)
library(fpp2)

# Assign wineind data
dat = forecast::wineind
df2 = as.ts(dat)
print(df2)

# plot
autoplot(df2) + ggtitle("Australian total wine sales by wine makers in bottles") + ylab("bottles")

# apply ma() and autolayer() to get a CA(k) series
ma(df2, 12)
autoplot(df2) + autolayer(ma(df2, 12), series="MA12")

# Decompose TS
decompModel = decompose(df2, type = "multiplicative")
plot(decompModel)
decompModel
