# part 1 - logistic regression
logreg = read.csv("logreg.csv")
View(logreg)

fit = glm(logreg$cases ~ logreg$sex + logreg$income, family = "binomial", data = logreg)
summary(fit)

# part 2 - model building

steps = read.csv("step.csv")
View(steps)

# convert medschl to factor var schlFact
schlFact = as.factor(steps$medschl)

fit.full = lm(steps$length ~ steps$age + steps$infect + steps$culture + steps$xray + steps$beds + schlFact + steps$region + steps$census + steps$nurses + steps$facs, data= steps)
summary(fit.full)

fit.empty = lm(steps$length ~ 1, data=steps)
step.model = step(fit.empty, direction="forward", scope=list(upper=fit.full, lower=fit.empty))
summary(step.model)