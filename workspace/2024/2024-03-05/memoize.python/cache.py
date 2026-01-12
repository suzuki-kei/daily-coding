
def memoize(target):

    def wrapper(*args, **kwargs):
        key = args + tuple(kwargs.items())

        if (value := cache.get(key)) is None:
            value = target(*args, **kwargs)
            cache[key] = value

        return value

    cache = {}
    return wrapper

