# Builds the data extracts the site uses, from the full lab files in the repo's data/ folder.
# Keeps the raw codes (including missing-value codes), so the cleaning steps work as in the labs.
# Run from site/ inside the exam-prep repo (full lab files in ../data/):  Rscript data/make_data.R

anes <- read.csv("../data/anes_timeseries_2024_csv_20250808.csv")
anes_vars <- c("V242065",   # voted in 2024
               "V242432",   # like-dislike Democratic Party, 0-10
               "V242435",   # like-dislike Trump, 0-10
               "V241551",   # gender
               "V241458x",  # age
               "V242439")   # satisfaction with democracy
write.csv(anes[, anes_vars], "data/anes_lab.csv", row.names = FALSE)

ess <- read.csv("../data/ess.csv")
ess_vars <- c("cntry", "gndr", "agea", "eduyrs", "lrscale", "hincfel", "trstplc",
              "stfdem", "vote", "polintr")   # the last three are for the mock exam
write.csv(ess[, ess_vars], "data/ess_lab.csv", row.names = FALSE)

# Lab 1: the students table from the Lab 1 instructions
students <- data.frame(
  name       = c("Richard", "Hao", "James", "Lisa", "Angela", "Andrea", "Tim"),
  mark_essay = c(57, 69, 76, 74, 78, 64, 52),
  mark_exam  = c(67, 64, 60, 54, 80, 56, 45),
  gender     = c("M", "M", "M", "F", "F", "F", "F")
)
write.csv(students, "data/students.csv", row.names = FALSE)
