"""Format every ```{r} chunk of a .qmd with Air (stdin mode). Usage: air_qmd.py FILE.qmd [--check]"""
import re, subprocess, sys, os
path = sys.argv[1]; check = "--check" in sys.argv
src = open(path).read()
pat = re.compile(r'(^```\{r[^}]*\}\n)(.*?)(^```\s*$)', re.S | re.M)
stdin_path = os.path.join(os.path.dirname(os.path.abspath(path)), "_chunk.R")
changed = 0
def fmt(m):
    global changed
    head, body, tail = m.group(1), m.group(2), m.group(3)
    r = subprocess.run(["air", "format", "--stdin-file-path", stdin_path], input=body, capture_output=True, text=True)
    if r.returncode != 0:
        print("AIR ERROR in chunk:\n" + body + r.stderr, file=sys.stderr); return m.group(0)
    out = r.stdout if r.stdout.endswith("\n") else r.stdout + "\n"
    if out != body:
        changed += 1
        print("---- before\n" + body + "---- after\n" + out)
    return head + out + tail
new = pat.sub(fmt, src)
print(f"{changed} chunk(s) changed")
if not check and new != src:
    open(path, "w").write(new)
