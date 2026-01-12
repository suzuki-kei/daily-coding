
def memoize(target_function):
    def wrapped_function(*args, **kwargs):
        key = args + tuple(kwargs.items())

        if key in cache:
            return cache[key]

        value = target_function(*args, **kwargs)
        cache[key] = value
        return value

    cache = {}
    return wrapped_function

