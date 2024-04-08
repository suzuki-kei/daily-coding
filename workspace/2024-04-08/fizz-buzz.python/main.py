import functools
import itertools


def main():
    values = generate_fizz_buzz_values(100)
    print(" ".join(map(str, values)))


def generate_fizz_buzz_values(n=None):
    """
        FizzBuzz を生成する.

        Arguments
        ---------
        n: int|None
            生成する個数.
            None の場合は無限に生成する.

        Yields
        ------
        value: str
            生成した値.
    """
    tuples = zip(
        itertools.cycle([None] * 14 + ["FizzBuzz"]),
        itertools.cycle([None] *  4 + ["Buzz"]),
        itertools.cycle([None] *  2 + ["Fizz"]),
        itertools.count(1, 1))
    values = map(
        composite_functions(str, first_not_none),
        tuples)

    if n is None:
        yield from values
    else:
        yield from itertools.islice(values, n)


def composite_functions(*functions):
    """
        関数合成する.

        例えば, 以下は同じ結果となる:
            map(str, map(f, xs))
            map(composite_functions(str, f), xs)

        Arguments
        ---------
        functions: Iterable[callable]
            合成する関数.

        Returns
        -------
        callable
            functions を合成することで作成した関数.
    """
    reducer = lambda x, f: f(x)
    functions = tuple(reversed(functions))
    return lambda x: functools.reduce(reducer, functions, x)


def first_not_none(iterable):
    """
        最初の None ではない値を取得する.

        Arguments
        ---------
        iterable: Iterable[object]
            任意の値を含む Iterable.

        Returns
        -------
        value: object
            iterable に含まれる最初の None ではない値.
    """
    is_none = lambda x: x is None
    return next(itertools.dropwhile(is_none, iterable))


if __name__ == "__main__":
    main()

