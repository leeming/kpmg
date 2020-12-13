def get_nested_values(obj, key):
    # Validate inputs
    if type(obj) is not dict:
        raise LookupError("obj expects a dict type")
    elif len(obj) == 0:
        raise LookupError("obj expects a non empty dict")
    elif not isinstance(key, str):
        raise TypeError("key expected to be a string")

    split_keys = key.split("/")
    return nested_filter_recurse(obj, split_keys)


def nested_filter_recurse(obj, keys):
    if len(keys) > 1:
        return nested_filter_recurse(obj[keys[0]], keys[1:])
    else:
        return obj[keys[0]]
