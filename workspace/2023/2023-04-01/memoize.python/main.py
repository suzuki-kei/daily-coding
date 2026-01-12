from memoize import memoize


def main():
    for n in range(50):
        print(f"fibonacci({n}) = {fibonacci(n)}")


@memoize
def fibonacci(n):
    if n in (0, 1):
        return n
    return fibonacci(n - 1) + fibonacci(n - 2)


if __name__ == "__main__":
    main()

