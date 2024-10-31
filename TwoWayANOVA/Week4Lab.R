insctData = read.csv("insects_data.csv")
view(insctData)

mean_meg_summer = mean(insctData$counts[insctData$species == "Megacrania" & insctData$season == "Summer"])
mean_meg_summer

mean_meg_autumn = mean(insctData$counts[insctData$species == "Megacrania" & insctData$season == "Autumn"])
mean_meg_autumn

mean_meg_winter = mean(insctData$counts[insctData$species == "Megacrania" & insctData$season == "Winter"])
mean_meg_winter

mean_meg_spring = mean(insctData$counts[insctData$species == "Megacrania" & insctData$season == "Spring"])
mean_meg_spring

mean_ext_summer = mean(insctData$counts[insctData$species == "Extatosoma" & insctData$season == "Summer"])
mean_ext_summer

mean_ext_autumn = mean(insctData$counts[insctData$species == "Extatosoma" & insctData$season == "Autumn"])
mean_ext_autumn

mean_ext_winter = mean(insctData$counts[insctData$species == "Extatosoma" & insctData$season == "Winter"])
mean_ext_winter

mean_ext_spring = mean(insctData$counts[insctData$species == "Extatosoma" & insctData$season == "Spring"])
mean_ext_spring

fit = aov(counts~species + season + species*season, data=insctData)
summary(fit)