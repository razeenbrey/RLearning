# Set working directory

setwd("C:\\Users\\razee\\OneDrive - University of Cape Town\\STA2020F\\Pictorials\\Week 3")

data = read.csv('oat_variety.csv')
View(data)

# Mean for golden rain
mean(data$yield[data$variety == 'Golden.rain'])

# Mean for marvelous
mean(data$yield[data$variety == 'Marvellous'])

# Mean for victory
mean(data$yield[data$variety == 'Victory'])

# Var for golden rain
var(data$yield[data$variety == 'Golden.rain'])

# Var for marvellous
var(data$yield[data$variety == 'Marvellous'])

# Var for victory
var(data$yield[data$variety == 'Victory'])


# Fit annova model
fit = aov(yield~plot + variety, data = data)
summary(fit)