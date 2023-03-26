from memoize import *


@memoize
def factorial(n):
    if n == 0:
        return 1
    return n * factorial(n - 1)


@memoize
def fibonacci(n):
    if n in (0, 1):
        return n
    return fibonacci(n - 1) + fibonacci(n - 2)


def main():
    print("==== factorials")
    for n in range(30):
        print(f"{factorial(n)}", end=" ")
    print()

    print("==== fibonacci numbers")
    for n in range(100):
        print(f"{fibonacci(n)}", end=" ")
    print()


if __name__ == "__main__":
    main()

