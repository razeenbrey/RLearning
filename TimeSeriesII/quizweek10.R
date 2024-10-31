library(forecast)
library(fpp3)
library(ggplot2)
library(fpp2)

ausair_ts = fpp2::ausair
ausair_ts
autoplot(ausair_ts) + ggtitle(" total annual air passengers of air carriers registered in Australia.") + ylab("millions")

summary(ausair_ts)

#transformations

lam = BoxCox.lambda(ausair_ts)
lam

ausair_stabalized_var_ts = BoxCox(ausair_ts, lambda = lam)
autoplot(ausair_stabalized_var_ts) + ggtitle(" total annual air passengers of air carriers registered in Australia.") + ylab("millions")

differenced_ts = diff(ausair_stabalized_var_ts, lag = 1)

ndiffs(differenced_ts)

autoplot(differenced_ts) + ggtitle(" total annual air passengers of air carriers registered in Australia.") + ylab("millions")

Acf(differenced_ts)

Box.test(differenced_ts, type = "Ljung-Box", lag = 4)

#forecasting

win_train = window(ausair_ts, start = c(1970,1), end = c(2006,1))
win_test = window(ausair_ts, start = c(2007), end = c(2016))

h <- 37

# Apply drift forecasting
modSmp = snaive(win_train, h=4)
autoplot(dt) + autolayer(modSmp)
autoplot(dt) + autolayer(modSmp, PI=F)

mod_simp <- rwf(win_train, h = h, drift = TRUE)

autoplot(ausair_ts) + autolayer(mod_simp)

autoplot(ausair_ts) + autolayer(mod_simp, PI = F)

checkresiduals(mod_simp)

accuracy(mod_simp,win_test)
accuracy(modSmp,win_test)

summary(mod_simp)
mod_simp

acf(differenced_ts, pl = FALSE)

