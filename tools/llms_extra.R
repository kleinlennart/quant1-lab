# Post-render: add the slides' Markdown version and the Quarto sources
# to llms.txt (Quarto's llms-txt lists only the HTML pages).
# Runs after every render (set in _quarto.yml), safe to run twice.

out <- Sys.getenv("QUARTO_PROJECT_OUTPUT_DIR", "_site")
path <- file.path(out, "llms.txt")
if (file.exists(path)) {
  site <- "https://quant1.kleinbutsignificant.com/"
  heading <- "## Slides and Quarto sources"
  txt <- readLines(path, warn = FALSE)

  # drop the section if an earlier run added it
  start <- match(heading, txt)
  if (!is.na(start)) {
    txt <- txt[seq_len(start - 1)]
  }
  while (length(txt) > 0 && txt[length(txt)] == "") {
    txt <- txt[-length(txt)]
  }

  extra <- c(
    "",
    heading,
    "",
    paste0(
      "- [Slides as Markdown, with the R output](",
      site,
      "slides.md)"
    ),
    paste0("- [Slides, Quarto source](", site, "slides.qmd)"),
    paste0("- [Cheat sheet, Quarto source](", site, "cheatsheet.qmd)")
  )
  writeLines(c(txt, extra), path)
}
