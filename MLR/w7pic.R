dat = read.csv("multreg.csv") 
View(dat)

cor(dat[,1:5])

fit = lm(Price ~ PlotSize+FloorArea+Trees+Distance+Pool +PlotSize*FloorArea, data=dat)
summary(fit)

confint(fit)

# find out what the estimated house prices for each house in the dataset is.
predict()