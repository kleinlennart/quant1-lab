"""Rewrite local links in a PDF (file://… or relative) to absolute URLs on the published site.

Usage: fix_pdf_links.py IN.pdf OUT.pdf [BASE_URL]
BASE_URL defaults to the site's address. IN and OUT may be the same file.
"""

import sys

import pikepdf

src, dst = sys.argv[1], sys.argv[2]
base = sys.argv[3] if len(sys.argv) > 3 else "https://quant1.kleinbutsignificant.com/"
if not base.endswith("/"):
    base += "/"

pdf = pikepdf.open(src, allow_overwriting_input=True)
n = 0
for page in pdf.pages:
    for annot in page.get("/Annots", []) or []:
        a = annot.get("/A")
        if a is None or "/URI" not in a:
            continue
        uri = str(a.URI)
        if uri.startswith(("http://", "https://", "mailto:")):
            continue
        name = uri.rsplit("/", 1)[-1]  # file:///…/_site/ai-setup.html or ai-setup.html
        a.URI = pikepdf.String(base + name)
        n += 1
pdf.save(dst)
print(f"rewrote {n} link(s) to {base}")
