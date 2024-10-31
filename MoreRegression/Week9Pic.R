# Load data sets
accel = read.csv("accel.csv")
netball = read.csv("netball_goals.csv")

View(accel)
View(netball)
View(prob)

# Netball
slrNetball = lm(goals_scored ~ shooting_accuracy, data = netball)
summary(slrNetball)

shoot = 0.62
vals = list(shooting_accuracy = shoot)
predict(slrNetball, newdata = vals, interval = "prediction")

# Accel - forwards build

fit.intercept = lm(acceleration ~ 1, data = accel)
fit.full = lm(acceleration ~ ., data = accel)
lst = list(lower=fit.intercept, upper=fit.full)

accelStep = step(fit.intercept, direction = "forward",scope = lst)
accelStep

summary(accelStep)

# Prob
prob = read.csv("prob_purch.csv")
buy = as.factor(prob$purchase)

fitLogi = glm(buy ~ age + income, family = "binomial", data= prob)
summary(fitLogi)

x = list(age = 30, income = 33500)
predict.glm(fitLogi, newdata = x, type = "response")
