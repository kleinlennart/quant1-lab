# Shared helpers for the interpretation sentences on the guide pages.
# Wording follows Prof. Bol's slides (L6 hypothesis testing, L8 regressions)
# and his official correction of the sample midterm.
# Pages load it with source("_common.R") in a hidden chunk.

# p-value as text: "p < 0.001" or "p = 0.032"
p_txt <- function(p) {
  if (p < 0.001) "p < 0.001" else paste("p =", format(round(p, 3), nsmall = 3))
}

# Significance in the course's levels (L6, L8): 0.01, 0.05, 0.10
sig_txt <- function(p) {
  if (p < 0.01) {
    "statistically significant at the 0.01 level"
  } else if (p < 0.05) {
    "statistically significant at the 0.05 level"
  } else if (p < 0.10) {
    "statistically significant at the 0.10 level"
  } else {
    "not statistically significant"
  }
}

# Strength labels for a correlation (L4; L8 s16): 0.10 / 0.30 / 0.50 / 0.75
r_label <- function(r) {
  a <- abs(r)
  if (a >= 0.75) {
    "very strong"
  } else if (a >= 0.50) {
    "strong"
  } else if (a >= 0.30) {
    "moderate"
  } else if (a >= 0.10) {
    "weak"
  } else {
    "negligible"
  }
}
r_dir <- function(r) if (r > 0) "positive" else "negative"

# Regression helpers: coefficient, its p-value, as number and as text
b <- function(m, term, d = 3) round(coef(m)[[term]], d)
pv <- function(m, term) summary(m)$coefficients[term, 4]
p <- function(m, term) p_txt(pv(m, term))
sig <- function(m, term) sig_txt(pv(m, term))
