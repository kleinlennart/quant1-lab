"""Print a reveal.js deck to PDF with headless Chrome (CDP, CSS page size). Usage: print_pdf.py URL OUT.pdf"""
import base64, json, subprocess, sys, tempfile, time, urllib.request, websocket
url, out = sys.argv[1], sys.argv[2]
prof = tempfile.mkdtemp()
ch = subprocess.Popen(["/Applications/Google Chrome.app/Contents/MacOS/Google Chrome", "--headless=new", "--disable-gpu",
                       "--remote-debugging-port=9335", f"--user-data-dir={prof}", "about:blank"],
                      stdout=subprocess.DEVNULL, stderr=subprocess.DEVNULL)
try:
    for _ in range(50):
        try: tabs = json.load(urllib.request.urlopen("http://localhost:9335/json")); break
        except Exception: time.sleep(0.2)
    ws = websocket.create_connection([t for t in tabs if t["type"] == "page"][0]["webSocketDebuggerUrl"], timeout=120, suppress_origin=True)
    n = [0]
    def call(m, p=None):
        n[0] += 1; ws.send(json.dumps({"id": n[0], "method": m, "params": p or {}}))
        while True:
            r = json.loads(ws.recv())
            if r.get("id") == n[0]: return r
    call("Page.enable"); call("Page.navigate", {"url": url}); time.sleep(8)
    r = call("Page.printToPDF", {"printBackground": True, "preferCSSPageSize": True, "displayHeaderFooter": False})
    open(out, "wb").write(base64.b64decode(r["result"]["data"]))
finally:
    ch.terminate()
