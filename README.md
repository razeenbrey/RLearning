# RLearning
Data manipulation and analysis with R.

## Anova

```r
# Simple mean
mean(dat$datformean)

# Complex mean
mean(dat$datformean [dat$specific1 == "Specific1" & dat$specific2 == "Specific2"])

sd()
var()
```

<span style='color:#CC1963'>One Way Anova</span>

- Test equality of means of 3+ groups.

```r
fit = aov(y ~ x1 + x2, data=dat)
summary(fit)
```

<span style='color:#CC1963'>Two Way Anova (Blocking)</span>

- Testing 1 effect on a sample while beain aware of other factors.

```r
fit = aov(y ~ x + block, data=dat)
summary(fit)
```

<span style='color:#CC1963'>Two Way Anova (Interaction)</span>

- Replication within cells.

- 2 factors: owns levels, equally important.

- Investigate the interaction.

```r
fit = aov(y ~ fact1 + fact2 + fact1*fact2, data=dat)
summary(fit)
```

## Non-Parametrics

**Test for equality of medians**

<span style='color:#26A1F9'>Wilcoxon Signed Rank [paired = TRUE]</span>

- Compare 2 paired samples of quantitative by medians.

- To see if come from same population.

- Considering sign and rank.

```r
# greater / less / two.sided
# exact is true when no ties -> true p-val
# exact is false when ties -> approx. p-val
wilcox.test(x,y,alternative = 'greater', exact = FALSE, paired = TRUE)
```

<span style='color:#26A1F9'>Mann-Whitney [paired = FALSE]</span>

- Test whether 2 indpendant samples have same median.

```r
# Alternative is the alt hypothesis
wilcox.test(x,y,alternative = 'greater', exact = FALSE, paired = TRUE)
```

**Compare 3 or more populations**

<span style='color:#26A1F9'>Kruskal-Wallis</span>

- Compare medians of more than 2 indepedant samples of ordinal/quantitative.

```r
kruskal.test(y ~ x, data = my_data)
```

<span style='color:#26A1F9'>Friedman</span>

- Compare medians of 2+ samples of ordinal/quantitative data using matched/blocked samples.

```r
# group = treatment
# block = blocking
# dat = response
friedman.test(y = data$dat, groups = data$group, blocks = data$block)
```

**Relationship between 2 variables**

<span style='color:#26A1F9'>Spearman's Rank Correlation</span>

- Measure association btwn 2 samples of orginal/quantitative data.

```r
cor.test(x, y, method = "spearman", data = my_data)
```

## Regression

<span style='color:#27B78A'>Simple Linear Regression</span>

```r
# Simple Linear Regression

# Load data set
dat = read.csv("lectures.csv")
View(dat)

# remove number column
df = subset(dat, select=-num)
View(df)

# Scatter plot of data
# plot(x, y, main, xlab, ylab, col, pch)
# Where x is carat data, y is price data, xlab is label for x as “Carat” and ylab is label for y as “Price”. 


# Perform Simple Linear Regression
# lm(y ~ x)

fit = lm(df$marks ~ df$lectures)
summary(fit)
# Output
# Call:
#   lm(formula = df$marks ~ df$lectures)
# 
# Residuals:
#   Min      1Q  Median      3Q     Max 
# -11.590  -5.215  -0.240   4.348  11.335 
# 
# Coefficients:
#   Estimate Std. Error t value Pr(>|t|)    
# (Intercept)  -3.6851     5.0333  -0.732    0.474    
# df$lectures   1.8250     0.1418  12.869 1.62e-10 ***
#   ---
#   Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1
# 
# Residual standard error: 6.868 on 18 degrees of freedom
# Multiple R-squared:  0.902,    Adjusted R-squared:  0.8965 
# F-statistic: 165.6 on 1 and 18 DF,  p-value: 1.625e-10

# Confidence intervals for model

confint(fit)
# > confint(fit)
# 2.5 %   97.5 %
#   (Intercept) -14.259806 6.889518
# df$lectures   1.527061 2.122947

# Single Prediction
# Predict mark of student who attends 35 lectures

lectAtt = 35
predictVals = list(lectures = lectAtt)
predict(fit, newdata = predictVals, interval = "prediction")

# Predict over range
# xvars = data.frame(lectures = 10:48)
# predict(fit, newdata = xvars)
```

<span style='color:#27B78A'>Multiple Linear Regression</span>

```r
# Multiple Linear Regression

# Load Data set
dat = read.csv("fresh.csv")
View(dat)

# Correlation matrix of all variables
# the numbers are the column numbers of the numeric columns in the data set
# we are creating a sub-table of just the numerics and doing cor analysis
dat_numeric = dat[,c(1,2,3,6)]
cor(dat_numeric)

# demand fresh_price ads_expenditure competitor_price
# demand            1.0000000 -0.46922030       0.8759536       0.74094817
# fresh_price      -0.4692203  1.00000000      -0.4687930       0.07836681
# ads_expenditure   0.8759536 -0.46879301       1.0000000       0.60454000
# competitor_price  0.7409482  0.07836681       0.6045400       1.00000000

# Conduct MLR
# lm(y ~ x1 + ... + xn, data=dat)
# just add comp1*comp2 after xn for interactions

fit = lm(dat$demand ~ dat$fresh_price + dat$ads_expenditure + dat$competitor_price, data = dat)
summary(fit)
# Call:
#   lm(formula = dat$demand ~ dat$fresh_price + dat$ads_expenditure + 
#        dat$competitor_price, data = dat)
# 
# Residuals:
#   Min       1Q   Median       3Q      Max 
# -0.41065 -0.11562 -0.00984  0.13466  0.51361 
# 
# Coefficients:
#   Estimate Std. Error t value Pr(>|t|)    
# (Intercept)            7.5891     2.4450   3.104 0.004567 ** 
#   dat$fresh_price       -2.3577     0.6379  -3.696 0.001028 ** 
#   dat$ads_expenditure    0.5012     0.1259   3.981 0.000491 ***
#   dat$competitor_price   1.6122     0.2954   5.459 1.01e-05 ***
#   ---
#   Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1
# 
# Residual standard error: 0.2347 on 26 degrees of freedom
# Multiple R-squared:  0.8936,    Adjusted R-squared:  0.8813 
# F-statistic:  72.8 on 3 and 26 DF,  p-value: 8.883e-13


# confidence intervals

confint(fit)
# 2.5 %     97.5 %
#   (Intercept)           2.5632892 12.6149158
# dat$fresh_price      -3.6690418 -1.0464038
# dat$ads_expenditure   0.2424145  0.7598889
# dat$competitor_price  1.0051083  2.2193205

# Prediction
newdat = list(fresh_price=5, ads_expenditure=8, competitor_price=5.5)
predict(fit, newdata = newdat)

# Converting to factor
# the ones shown in analysis is the dummy variables
adsCampFact = as.factor(dat$ads_campaign)

# manual convert to factor
# size - 1 = small || 0 = big

size = ifelse(dat$size == "small", 1, 0)
```

<span style='color:#27B78A'>Logistic Regression</span>

```r
# Logistic Regression

dat = read.csv("orings.csv")
View(dat)

# Perform Logistic Regression
# glm(y ~ x, family = "binomial", data= dat)
fail = as.factor(dat$Failure)
fit = glm(fail ~ dat$Temperature, family = "binomial", data = dat)
summary(fit)

# Call:
#   glm(formula = dat$Failure ~ dat$Temperature, family = "binomial", 
#       data = dat)
# 
# Coefficients:
#   Estimate Std. Error z value Pr(>|z|)  
# (Intercept)     10.87535    5.70291   1.907   0.0565 .
# dat$Temperature -0.17132    0.08344  -2.053   0.0400 *
#   ---
#   Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1
# 
# (Dispersion parameter for binomial family taken to be 1)
# 
# Null deviance: 28.975  on 23  degrees of freedom
# Residual deviance: 23.030  on 22  degrees of freedom
# AIC: 27.03
# 
# Number of Fisher Scoring iterations: 4

# Obtain confidence intervals
confint.default(fit)
```

<span style='color:#27B78A'>Model Building</span>

```r
# Load data set
dat = read.csv("fresh.csv")
View(dat)

# model with just intercept
fit.intercept = lm(demand ~ 1, data= dat)

# full model with all variables
fit.full = lm(demand ~ ., data= dat)

# There are 3 kinds of selection
# Forward 
# Backward
# Step-wise

# -------------------------- Forward ---------------------------
# need to specify intercept model as lower and full as upper

# starts with intercept model (y ~ 1)
# adds independant var
# if AIC improves, its kept then repeat
# once added, cannot be removed

step(fit.intercept, direction = "forward", scope = list(lower=fit.intercept, upper=fit.full))

# -------------------------- Backward ---------------------------
# use full model as starting point

# starts with full
# removes independant var
# if AIC improves, its left out then repeat
# once removed, cannot be re-added

step(fit.full, direction = "backward")

# -------------------------- Backward ---------------------------
# same like forward, except direction is "both"

# starts with intercept, iteratively adds and removes independent vars and assesses change in AIC.

step(fit.intercept, direction="both", scope=list(lower=fit.intercept, upper = fit.full))
```

## Time Series
