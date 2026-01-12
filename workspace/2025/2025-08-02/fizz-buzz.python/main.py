from typing import Any
from typing import Iterable
from typing import Iterator
from typing import Optional
import itertools


def main() -> None:
    print(" ".join(generate_fizz_buzz_values(100)))


def generate_fizz_buzz_values(n: Optional[int] = None) -> Iterator[str]:
    tuples = zip(
        itertools.cycle([None] * 14 + ["FizzBuzz"]),
        itertools.cycle([None] *  4 + ["Buzz"]),
        itertools.cycle([None] *  2 + ["Fizz"]),
        map(str, itertools.count(1, 1)))
    values = map(first_not_none, tuples)
    sliced = itertools.islice(values, n)
    yield from sliced


def first_not_none(iterable: Iterable[Any]) -> Any:
    is_none = lambda x: x is None
    dropped = itertools.dropwhile(is_none, iterable)
    return next(dropped)


if __name__ == "__main__":
    main()

