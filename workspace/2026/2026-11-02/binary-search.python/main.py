from random import random
from typing import Optional


def main() -> None:
    values = selection_without_replacement(n = 20, begin = 10, end = 100)
    print(" ".join(map(str, values)))

    min_target = values[0] - 1
    max_target = values[-1] + 1

    for target in range(min_target, max_target + 1):
        index = binary_search(values, target)
        print(f"target = {target}, index = {index}")


def selection_without_replacement(n: int, begin: int, end: int) -> list[int]:
    values: list[int] = []

    for value in range(begin, end):
        n_remaining = n - len(values)
        n_candidates_remaining = end - value
        selection_probability = n_remaining / n_candidates_remaining

        if random() < selection_probability:
            values.append(value)

    return values


def binary_search(
    values: list[int],
    target: int,
    first: Optional[int] = None,
    last: Optional[int] = None,
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

