
def memoize(target):

    cache = {}

    def decorator(*args, **kwargs):
        key = args + tuple(kwargs.items())

        if key not in cache:
            cache[key] = target(*args, **kwargs)
        return cache[key]

    return decorator

