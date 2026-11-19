# quant1-lab

Study guide, cheat sheet, mock exam and slides for the R lab exercise in *Introduction to Quantitative Methods* (Sciences Po, Autumn 2026). A Quarto website, published with GitHub Pages.

**Site:** https://quant1.kleinbutsignificant.com/

## Build

```sh
quarto preview          # live preview
quarto render           # build into _site/
```

R packages: dplyr, lmtest, car, margins, nnet, ggplot2, modelsummary, easystats, ragg, systemfonts, downlit, xml2.

## Publish

```sh
sh tools/publish.sh   # render, print slides.pdf, publish to GitHub Pages
git add -A            # then commit and push (publishing rewrites slides.pdf)
```

## Credits

- Data: American National Election Studies, *ANES 2024 Time Series Study*; European Social Survey, round 11 (CC BY-NC-SA 4.0). The files in `data/` are extracts with the lab variables only.
- RStudio figure on the slides: Wickham, Çetinkaya-Rundel & Grolemund, *R for Data Science* (2e), CC BY-NC-ND 3.0.
- Font: Source Sans 3 (Adobe), SIL Open Font License 1.1 (`fonts/OFL-LICENSE.md`).
- Interpretations follow the course's slides and its official sample-exam correction. This is a student-made study aid, not official course material.
