from odf.opendocument import OpenDocumentText
from odf.text import H, P
import json

def jsonsß_to_odt(json_path, odt_path="flattened_scroll.odt", title="🌀 Scroll Export"):
    # Load JSON content
    with open(json_path, 'r', encoding='utf-8') as f:
        data = json.load(f)

    # Create the ODT document
    textdoc = OpenDocumentText()

    # Title
    textdoc.text.addElement(H(outlinelevel=1, text=title))

    # Ensure it's a list
    data = data if isinstance(data, list) else [data]

    # Iterate over entries
    for i, entry in enumerate(data):
        textdoc.text.addElement(H(outlinelevel=2, text=f"Entry {i + 1}"))
        for key, value in entry.items():
            para = P(text=f"{key}: {value}")
            textdoc.text.addElement(para)

    # Save
    textdoc.save(odt_path)
    print(f"🌀 ODT scroll saved as: {odt_path}")

# 🌀 Example Invocation
jsonsß_to_odt("🌀=>True⟿.jsonsß*(Structure:)🌀/teachlearn_mirror_iq_001-120.jsonsß")
