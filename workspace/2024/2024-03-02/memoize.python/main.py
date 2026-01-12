
def main():
    for i in range(100):
        print(f"fibonacci({i}) = {fibonacci(i)}") 


def memoize(target):
    def wrapper(*args, **kwargs):
        key = args + tuple(kwargs.items())
        value = cache.get(key)

        if (value := cache.get(key)) is None:
            value = target(*args, **kwargs)
            cache[key] = value
        return value

    cache = {}
    return wrapper


@memoize
def fibonacci(n):
    if n == 0:
        return 0
    if n == 1:
        return 1
    return fibonacci(n - 1) + fibonacci(n - 2)


if __name__ == "__main__":
    main()

