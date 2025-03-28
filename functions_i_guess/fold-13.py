def fold(data, scrollDepth=13, parent_key='', sep='__', current_depth=0):
    if current_depth > scrollDepth:
        return {parent_key: '::depth_limit_reached'}

    items = []
    if isinstance(data, dict):
        for k, v in data.items():
            new_key = f"{parent_key}{sep}{k}" if parent_key else k
            if isinstance(v, (dict, list)):
                items.extend(fold(v, scrollDepth, new_key, sep, current_depth + 1).items())
            else:
                items.append((new_key, v))
    elif isinstance(data, list):
        for i, item in enumerate(data):
            new_key = f"{parent_key}_{i}" if parent_key else str(i)
            items.extend(fold(item, scrollDepth, new_key, sep, current_depth + 1).items())
    else:
        items.append((parent_key, data))
    return dict(items)
