# Import dataset

info = read.csv('Color_texture.csv')
str(info)

# Mean for red
mean(info$texture[info$Color == 'Red'])

# Var for red
var(info$texture[info$Color == 'Red'])

# Fit annova model
fit = aov(texture~Color + Area, data = info)
summary(fit)