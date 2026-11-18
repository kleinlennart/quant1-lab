"""Rewrite file:// link URIs in a PDF to relative file names. Usage: fix_pdf_links.py IN.pdf OUT.pdf"""
import sys, pikepdf
src, dst = sys.argv[1], sys.argv[2]
pdf = pikepdf.open(src, allow_overwriting_input=True)
n = 0
for page in pdf.pages:
    for annot in page.get("/Annots", []) or []:
        a = annot.get("/A")
        if a is not None and "/URI" in a:
            uri = str(a.URI)
            if uri.startswith("file://"):
                a.URI = pikepdf.String(uri.rsplit("/", 1)[-1])
                n += 1
pdf.save(dst)
print(f"rewrote {n} link(s)")
