from itertools import count
from itertools import cycle
from itertools import dropwhile
from itertools import islice
from itertools import repeat
from typing import Iterable
from typing import Iterator
from typing import Optional
from typing import TypeVar

T = TypeVar("T")


def main() -> None:
    print(" ".join(generate_fizz_buzz_values(100)))


def generate_fizz_buzz_values(n: Optional[int] = None) -> Iterator[str]:
    tuples = zip(
        cycle([*repeat(None, 14), "FizzBuzz"]),
        cycle([*repeat(None,  4), "Buzz"]),
        cycle([*repeat(None,  2), "Fizz"]),
        map(str, count(1, 1)))
    values = map(first_not_none, tuples)
    sliced = islice(values, n)
    yield from sliced


def first_not_none(iterable: Iterable[Optional[T]]) -> T:
    is_none = lambda x: x is None
    dropped = dropwhile(is_none, iterable)
    x = next(dropped)
    assert x is not None
    return x


if __name__ == "__main__":
    main()

