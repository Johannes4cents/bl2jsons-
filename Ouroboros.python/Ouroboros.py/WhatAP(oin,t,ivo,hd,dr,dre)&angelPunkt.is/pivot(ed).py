import pandas as pd
import json

def flatten_json(nested_json, parent_key='', sep='__'):
    """Rekursives Flatten einer verschachtelten JSON-Struktur"""
    items = []
    for k, v in nested_json.items():
        new_key = f"{parent_key}{sep}{k}" if parent_key else k
        if isinstance(v, dict):
            items.extend(flatten_json(v, new_key, sep=sep).items())
        elif isinstance(v, list):
            for i, item in enumerate(v):
                items.extend(flatten_json({f"{new_key}_{i}": item}, '', sep=sep).items())
        else:
            items.append((new_key, v))
    return dict(items)

def json_to_pivot(file_path, output_file='output.xlsx'):
    with open(file_path, 'r', encoding='utf-8') as f:
        data = json.load(f)
    
    flat_data = [flatten_json(entry) for entry in data] if isinstance(data, list) else [flatten_json(data)]
    df = pd.DataFrame(flat_data)
    
    # Export to Excel
    df.to_excel(output_file, index=False)
    print(f"Pivot-ähnliche Tabelle gespeichert als {output_file}")

# Beispiel-Aufruf mit deiner Datei
json_to_pivot("/mnt/data/10-A-G-01.json")
