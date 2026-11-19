#!/bin/sh
# Render the site, refresh the slides PDF, and publish to GitHub Pages.
#
# Run from anywhere:  sh site/tools/publish.sh
set -e
cd "$(dirname "$0")/.."

rm -rf slides_cache   # publish from a full, fresh run of every chunk
quarto render

# Slides PDF: print the rendered slides, make their links absolute
uv run --no-project --with websocket-client python tools/print_pdf.py "file://$PWD/_site/slides.html?print-pdf" slides.pdf
uv run --no-project --with pikepdf python tools/fix_pdf_links.py slides.pdf slides.pdf
cp slides.pdf _site/slides.pdf

# Stop if a local path leaked into the output
if grep -rlE "/Users/|/private/" _site; then
  echo "Local paths found in the files above: not publishing." >&2
  exit 1
fi

quarto publish gh-pages --no-render "$@"
echo "Published: https://quant1.kleinbutsignificant.com/"
