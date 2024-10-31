install.packages("readxl")
library("readxl")

flight = read_xlsx("flight_times.xlsx") 
happy = read_xslx("happy_vids.xlsx")

View(flight)
View(happy)