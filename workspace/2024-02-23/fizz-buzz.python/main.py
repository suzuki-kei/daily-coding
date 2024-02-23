import itertools


def main():
    print(" ".join(map(str, generate_fizz_buzz_values(100))))


def generate_fizz_buzz_values(n=None):
    tuples = zip(
        itertools.cycle([None] * 14 + ["FizzBuzz"]),
        itertools.cycle([None] *  4 + ["Buzz"]),
        itertools.cycle([None] *  2 + ["Fizz"]),
        itertools.count(1, 1))
    values = map(next_not_none, tuples)

    if n is None:
        yield from values
    else:
        yield from itertools.islice(values, n)


def next_not_none(iterable):
    is_none = lambda x: x is None
    return next(itertools.dropwhile(is_none, iterable))


if __name__ == "__main__":
    main()

