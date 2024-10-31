library("readxl")

calls = read_excel("calls.xlsx") 
cars = read_excel("Cars_data.xlsx")
goals = read_excel("Goals_data.xlsx") 

View(calls)
View(cars)
View(goals)

# Non- para
# Question 7 - Friedman
Q7 = friedman.test(y=goals$Goals, groups = goals$Player, blocks = goals$Kit)
Q7

# Question 8 -  Spierman Ranked
Q8 = cor.test(x=cars$Noise_level, y=cars$Max_speed, method = "spearman", data=cars)
Q8

# Regression

# Mean
# Calls
mean(calls$Calls)
# Execution
mean(calls$Executions)

# Variance
# Calls
var(calls$Calls)
# Execution
var(calls$Executions)

# SD
# Calls
sd(calls$Calls)
# Execution
sd(calls$Executions)

# Apply cor()
cor(y=calls$Executions, x=calls$Calls)

# Apply plot()
plot(x = calls$Calls, y=calls$Executions, )

# simple lin reg
fit = lm(calls$Calls ~ calls$Executions, data = calls)
fit

# summary()
summary(fit)

# anova()
anova(fit)

# confint()
confint(fit)