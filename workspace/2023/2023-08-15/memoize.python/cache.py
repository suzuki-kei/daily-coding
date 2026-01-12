
def memoize(target):
    def wrapper(*args, **kwargs):
        key = args + tuple(kwargs.items())

        if (value := cache.get(key)) is None:
            value = cache[key] = target(*args, **kwargs)
        return value

    cache = {}
    return wrapper

