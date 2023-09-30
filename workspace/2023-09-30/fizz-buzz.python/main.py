import itertools
import typing


def next_not_none(iterable):
    is_none = lambda x: x is None
    return next(itertools.dropwhile(is_none, iterable))


def generate_fizz_buzz_values(n=None):
    # 以下のようなタプルを生成するイテレータ.
    # (None, None, None, 1)
    # (None, None, None, 2)
    # (None, None, 'Fizz', 3)
    # ...
    tuples = zip(
        itertools.cycle([None] * 14 + ["FizzBuzz"]),
        itertools.cycle([None] *  4 + ["Buzz"]),
        itertools.cycle([None] *  2 + ["Fizz"]),
        itertools.count(1, 1))

    # FizzBuzz を生成するイテレータにするために,
    # 各タプルについて None ではない最初の要素に変換する.
    values = map(next_not_none, tuples)

    if n is None:
        yield from values
    else:
        yield from itertools.islice(values, n)


def main():
    for value in generate_fizz_buzz_values(100):
        print(value)


if __name__ == "__main__":
    main()

