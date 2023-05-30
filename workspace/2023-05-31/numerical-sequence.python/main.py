

def main():
    print_sequence("factorials", factorial, 1, 10)
    print_sequence("fibonacci numbers", fibonacci, 0, 20)
    print_sequence("fizz buzz values", fizz_buzz, 1, 100)


def print_sequence(description, f, min, max):
    print(f"{description}:")
    print(" ".join(map(str, map(f, range(min, max + 1)))))


def factorial(n):
    if n == 0:
        return 1
    return n * factorial(n - 1)


def fibonacci(n):
    if n == 0:
        return 0
    if n == 1:
        return 1
    return fibonacci(n - 1) + fibonacci(n - 2)


def fizz_buzz(n):
    if n % 15 == 0:
        return "FizzBuzz"
    if n % 5 == 0:
        return "Buzz"
    if n % 3 == 0:
        return "Fizz"
    return str(n)


if __name__ == "__main__":
    main()

