from random import random
from typing import Optional


def main() -> None:
    values = selection_without_replacement(n = 20, min = 10, max = 99)
    print(" ".join(map(str, values)))

    target_range = range(values[0] - 1, values[len(values) - 1] + 1)

    for target in target_range:
        index = binary_search(values, target)
        print(f"target = {target}, index = {index}")


def selection_without_replacement(n: int, min: int, max: int) -> list[int]:
    xs: list[int] = []

    for x in range(min, max + 1):
        n_remaining = n - len(xs)
        n_candidates_remaining = max - x + 1
        selection_probability = n_remaining / n_candidates_remaining

        if random() < selection_probability:
            xs.append(x)

    return xs


def binary_search(
    values: list[int],
    target: int,
    first: Optional[int] = None,
    last: Optional[int] = None
) -> int:
    if first is None:
        first = 0

    if last is None:
        last = len(values) - 1

    if first > last:
        return -1

    center = (first + last) // 2

    if target == values[center]:
        return center

    if target < values[center]:
        return binary_search(values, target, first, center - 1)
    else:
        return binary_search(values, target, center + 1, last)


if __name__ == "__main__":
    main()

