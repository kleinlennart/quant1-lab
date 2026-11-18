# Cheat sheet

Every recipe on one page, plus sentence templates for the interpretation, common errors and an exam checklist. Keep it open during the exam.

Replace `dataset`, `y`, `x`, `z` and `group` with your own names. The [slides](slides.llms.md) have worked examples with their output.

## Start

``` downlit
# install.packages(c("dplyr", "lmtest", "car", "margins", "nnet"))   # once per computer
library(dplyr); library(lmtest); library(car); library(margins); library(nnet)
getwd()                               # where R is looking
list.files()                          # is the data file there?
dataset <- read.csv("file.csv")       # read.csv2() if the columns are separated by ;
```

## Inspect

``` downlit
names(dataset); dim(dataset); str(dataset); head(dataset)
table(dataset$x, useNA = "ifany")     # every value with its count, including NA
summary(dataset$x)                    # a max of 99 or 999 is a missing-value code
sort(unique(dataset$x))
```

## Clean (always into a new variable, then check it)

``` downlit
# keep a valid range
dataset$x_clean <- ifelse(dataset$x >= 0 & dataset$x <= 10, dataset$x, NA)
# set special codes to missing
dataset$x_clean <- ifelse(dataset$x %in% c(77, 88, 99), NA, dataset$x)
# binary from codes
dataset$x_bin <- ifelse(dataset$x == 4, 1, ifelse(dataset$x %in% c(1, 2, 3), 0, NA))
# several categories, base R
dataset$x_cat <- NA
dataset$x_cat[dataset$x >= 0 & dataset$x <= 3] <- 1
dataset$x_cat[dataset$x >= 4 & dataset$x <= 6] <- 2
# several categories, dplyr
dataset <- dataset |> mutate(x_cat = case_when(x <= 3 ~ 1, x >= 4 & x <= 6 ~ 2, TRUE ~ NA_real_))
# categories with labels
dataset$x_f <- factor(dataset$x, levels = c(1, 2), labels = c("Man", "Woman"))
# one group only
dataset_fr <- subset(dataset, cntry == "FR")
# check
table(dataset$x, dataset$x_clean, useNA = "ifany")
```

## Describe one variable

``` downlit
table(dataset$x)                         # categorical: counts
prop.table(table(dataset$x)) * 100       # percentages
barplot(table(dataset$x))
mean(dataset$x, na.rm = TRUE); median(dataset$x, na.rm = TRUE); sd(dataset$x, na.rm = TRUE)
summary(dataset$x)
hist(dataset$x, breaks = seq(-0.5, 10.5, by = 1))   # one bar per value on a 0-10 scale
```

## Two variables

``` downlit
# categorical x categorical
tab <- table(dataset$x, dataset$y)
prop.table(tab, margin = 1) * 100        # row % (margin = 2: column %)
chisq.test(tab)
# continuous y by a binary group
aggregate(y ~ group, data = dataset, FUN = mean)
t.test(y ~ group, data = dataset)
boxplot(y ~ group, data = dataset)
# continuous x continuous
cor(dataset$x, dataset$y, use = "complete.obs")
cor.test(dataset$x, dataset$y)
plot(dataset$x, dataset$y)
```

## Models

``` downlit
# OLS (continuous y); factor() for categorical predictors; + factor(cntry) = country fixed effects
model <- lm(y ~ x1 + factor(x2) + x3 + factor(cntry), data = dataset)
summary(model); confint(model); nobs(model)
# diagnostics
plot(model$fitted.values, model$residuals); abline(h = 0)
bptest(model)                            # H0: homoskedasticity
vif(model)                               # multicollinearity
# logit (binary y)
logit <- glm(y ~ x1 + factor(x2) + x3, data = dataset, family = binomial)
summary(logit)
summary(margins(logit))                  # average marginal effects (changes in probability)
# multinomial logit (3+ categories); reference = first level
mlogit <- multinom(y ~ x1 + factor(x2) + x3, data = dataset, trace = FALSE)
round(coef(mlogit), 3)
# interaction
model_int <- lm(y ~ factor(z) * x + controls, data = dataset)
coef(model_int)[["x"]] + coef(model_int)[["factor(z)2:x"]]    # effect of x when z = 2
```

## Sentence templates

Wording from Prof. Bol’s slides and his correction of the sample midterm.

| Output | Write |
|----|----|
| Mean, median, SD | “Given that the mean and the median are very close, the distribution is approximately symmetric” (or: “positively/right-skewed, due to the value …, which makes the mean higher than the median”). “The standard deviation is …, which is relatively low/high compared to the mean. The spread of the distribution is thus small/large.” |
| Group means | “Men: …. Women: …. There is therefore no difference / a difference in the means, suggesting no association / an association between X and Y in this sample.” |
| [`cor()`](https://rdrr.io/r/stats/cor.html) | “There is a positive/negative, \[strength\] association between X and Y, so that the more X, the higher/lower Y.” Strength: \|r\| \< 0.10 negligible, 0.10 weak, 0.30 moderate, 0.50 strong, 0.75 very strong. |
| [`chisq.test()`](https://rdrr.io/r/stats/chisq.test.html) | “X² = …, df = …, p = …. The association is statistically significant at the 0.01 level, so we reject the null hypothesis of no association between A and B. The percentages show that …% of group 1 are …, against …% of group 2.” |
| [`t.test()`](https://rdrr.io/r/stats/t.test.html) | “The mean of Y is … in group 0 and … in group 1 (t = …, p = …). The difference is statistically significant at the 0.05 level, so we reject the null hypothesis that the means are not different.” |
| Significance | p \< 0.01, 0.05 or 0.10: “statistically significant at the 0.01 / 0.05 / 0.10 level”. Above 0.10: “not statistically significant”. |
| Stars | R’s [`summary()`](https://rdrr.io/r/base/summary.html): `***` \< 0.001, `**` \< 0.01, `*` \< 0.05, `.` \< 0.1. The course’s tables: `***` \< 0.01, `**` \< 0.05, `*` \< 0.10. Write the level in words. |
| [`lm()`](https://rdrr.io/r/stats/lm.html), continuous x | “When X increases by one unit, Y increases/decreases by b, net of the control variables (statistically significant at the … level).” |
| [`lm()`](https://rdrr.io/r/stats/lm.html), [`factor()`](https://rdrr.io/r/base/factor.html) dummy | “Y is b larger/smaller in \[category\] than in \[reference category\], net of the control variables.” |
| Constant | “The value of Y when all the independent variables are 0.” |
| R² | “The independent variables explain …% of the variance of Y.” |
| Fixed effects | “With country fixed effects, the estimates are within countries.” |
| [`glm()`](https://rdrr.io/r/stats/glm.html) coefficient | “The coefficient is positive/negative, so X increases/decreases the probability that Y = 1.” Only the sign can be interpreted. |
| Marginal effect | “When X increases by one unit, the probability that Y = 1 increases/decreases by AME × 100 percentage points.” |
| [`multinom()`](https://rdrr.io/pkg/nnet/man/multinom.html) | “Compared with \[reference category\], X increases/decreases the log-odds of \[category\] (b = …).” Only the sign can be interpreted. |
| Interaction | “The effect of X is b_x for \[reference group\] and b_x + b_interaction for \[other group\]. The interaction is (not) statistically significant, so Z moderates / we cannot conclude that Z moderates the effect of X.” |
| [`bptest()`](https://rdrr.io/pkg/lmtest/man/bptest.html) | “BP = …, p \< 0.01: we reject homoskedasticity, so there is heteroskedasticity. Fix: robust standard errors.” |
| [`vif()`](https://rdrr.io/pkg/car/man/vif.html) | “All VIFs are below 10, so multicollinearity is not a concern.” |

A statistically significant effect is not always strong: also give the size.

## Errors and fixes

| Message | Likely cause | Fix |
|----|----|----|
| `object 'x' not found` | spelling or capitals; you never ran the line that creates it | `names(dataset)`; run the script from the top |
| `could not find function "x"` | package not loaded | [`library(package)`](https://rdrr.io/r/base/library.html) |
| `there is no package called 'x'` | package not installed | `install.packages("x")` |
| `unexpected symbol`, `unexpected ')'` | a missing comma, quote or parenthesis | match every `(` and `"` |
| The result is `NA` | missing values in the calculation | `na.rm = TRUE`, or `use = "complete.obs"` for [`cor()`](https://rdrr.io/r/stats/cor.html) |
| One column after importing | wrong separator | the other one of [`read.csv()`](https://rdrr.io/r/utils/read.table.html) and [`read.csv2()`](https://rdrr.io/r/utils/read.table.html) |
| `replacement has 0 rows` | the variable on the right doesn’t exist (often after a wrong import) | `names(dataset)` |
| `grouping factor must have exactly 2 levels` | the [`t.test()`](https://rdrr.io/r/stats/t.test.html) group doesn’t have exactly two values | `table(dataset$group)`; check the recode |
| `Chi-squared approximation may be incorrect` | small expected counts | `chisq.test(tab)$expected` |
| `(… observations deleted due to missingness)` | not an error: rows with `NA` are left out | report N with `nobs(model)` |

## Before you hand in

- Did you load the right file, and do the numbers of rows and columns make sense?
- Did you check every variable you use and turn its missing-value codes into `NA`?
- Did you check every new variable with [`table()`](https://rdrr.io/r/base/table.html)?
- Are the categorical predictors in [`factor()`](https://rdrr.io/r/base/factor.html)?
- Did you use the right percentages (row or column)?
- Does each test match the types of the variables?
- Does every result have a sentence in words?
- Does the script run from top to bottom after *Session \> Restart R*?

Back to top
