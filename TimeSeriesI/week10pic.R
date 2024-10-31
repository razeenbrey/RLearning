# load packages

install.packages("fpp2")
install.packages("forecast")
install.packages("ggplot2")

library(forecast)
library(ggplot2)
library(fpp2)

data = forecast::gas
data = as.ts(data)
print(data)

# plot
autoplot(data) + ggtitle("Australian monthly gas production") + ylab("gas")

# apply ma() and autolayer() to get a CA(k) series
ma(data, 12)
autoplot(data) + autolayer(ma(data, 12), series="MA12")

# Decompose TS
decompModel = decompose(data, type = "multiplicative")
plot(decompModel)
decompModel