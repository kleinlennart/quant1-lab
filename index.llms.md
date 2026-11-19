# R for the lab exam

Introduction to Quantitative Methods · Sciences Po · Autumn 2026

## The lab exam

|  |  |
|----|----|
| Task | “Write R code to perform a series of analyses on a dataset and interpret the results” (syllabus) |
| When | Week 11, in class, at the normal lecture time; 2 hours |
| Weight | 30% of the course grade |
| Allowed | Any resources |

You get a dataset and run an analysis from start to finish: clean the variables, describe them, test associations, estimate models, and say in words what the results mean. The lab sessions prepare you for it, and Lab 6 (week 12) goes through the correction.

## What’s here

|  |  |
|----|----|
| [Slides](slides.llms.md) · [PDF](slides.pdf) | The recap session: how R reads code, every lab calculation with its output and an example interpretation, fixing errors, using AI |
| [Cheat sheet](cheatsheet.llms.md) | All the commands and sentence templates on one page, to keep open during the exam |
| [Mock lab exam](mock-exam.llms.md) | Practice tasks in the style of the labs, with solutions |
| [AI Setup](ai-setup.llms.md) | From chat to an agent in your project folder, with setup steps |

## The data

The slides and the mock exam use the two datasets from the labs. The site uses small extracts with only the lab variables, and the values are unchanged:

- [anes_lab.csv](data/anes_lab.csv): **ANES 2024**, US election survey, 5,521 respondents (Labs 1–3).
- [ess_lab.csv](data/ess_lab.csv): **European Social Survey round 11**, 39,514 respondents in 23 countries (Labs 4–5).
- [students.csv](data/students.csv): the student marks table from Lab 1.

In your own script, read the full files from Moodle instead, e.g. `read.csv("anes_timeseries_2024_csv_20250808.csv")` or `read.csv("ess.csv")`. The variable names are the same.

> **NOTE:**
>
> - American National Election Studies. *ANES 2024 Time Series Study*, version of 8 August 2025. [electionstudies.org](https://electionstudies.org)
> - European Social Survey European Research Infrastructure (ESS ERIC). *ESS round 11, integrated file, edition 4.2* (ESS11e04_2). Sikt, Norwegian Agency for Shared Services in Education and Research. [europeansocialsurvey.org](https://www.europeansocialsurvey.org). Licence: [CC BY-NC-SA 4.0](https://creativecommons.org/licenses/by-nc-sa/4.0/).
>
> The extracts on this site are adapted: they keep only the variables used in the labs.

Back to top
