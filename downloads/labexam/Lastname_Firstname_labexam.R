# ------------------------------------------------------------
# QM1 lab exam
# Name:
# Date:
# ------------------------------------------------------------
# Rename this file: Lastname_Firstname_labexam.R
# Open labexam.Rproj first, so the paths below work.
# Before you hand in: Session > Restart R, then run everything.


# 0. Setup ---------------------------------------------------

library(lmtest)    # bptest()
library(car)       # vif()
library(margins)   # margins()
library(nnet)      # multinom()

dataset <- read.csv("data/ess.csv")   # or the file named in the task
dim(dataset)


# 1. Clean the variables -------------------------------------
# For each variable: inspect (table/summary), recode into a NEW variable,
# then check the new variable with table(..., useNA = "ifany").

# TODO


# 2. Describe ------------------------------------------------

# TODO

# Interpretation:


# 3. Bivariate tests (chi-square / t-test / correlation) -----

# TODO

# Interpretation:


# 4. Regression ----------------------------------------------

# TODO

# Interpretation:


# 5. Diagnostics ---------------------------------------------

# TODO

# Interpretation:


# 6. Logit / marginal effects / interactions -----------------

# TODO

# Interpretation:
