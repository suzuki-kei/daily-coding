from memoize import *


@memoize
def fibonacci(n):
    if n in (0, 1):
        return n
    return fibonacci(n - 1) + fibonacci(n - 2)


def main():
    print("==== fibonacci numbers")
    for n in range(100):
        print(fibonacci(n), end=" ")
    print()


if __name__ == "__main__":
    main()

