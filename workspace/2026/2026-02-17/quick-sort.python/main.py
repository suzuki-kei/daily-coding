from dataclasses import dataclass
from random import randint
from typing import Callable
from typing import TypeAlias


@dataclass(frozen=True)
class PartitionResult:
    left_upper: int
    right_lower: int


Partition: TypeAlias = Callable[[list[int], int, int], PartitionResult]


def main() -> None:
    demonstration("partition 2-way", partition_2way)
    demonstration("partition 3-way", partition_3way)


def demonstration(label: str, partition: Partition) -> None:
    print(f"==== {label}")
    xs = generate_random_values(20)
    print_list(xs)
    quick_sort(xs, partition)
    print_list(xs)


def generate_random_values(n: int) -> list[int]:
    return [
        randint(10, 99)
        for _ in range(n)
    ]


def print_list(xs: list[int]) -> None:
    formatted = " ".join(map(str, xs))

    if is_sorted(xs):
        print(f"{formatted} (sorted)")
    else:
        print(f"{formatted} (not sorted)")


def is_sorted(xs: list[int]) -> bool:
    return all(a <= b for a, b in zip(xs, xs[1:]))


def quick_sort(xs: list[int], partition: Partition) -> None:
    if len(xs) <= 1:
        return

    quick_sort_range(xs, 0, len(xs) - 1, partition)


def quick_sort_range(xs: list[int], lower: int, upper: int, partition: Partition) -> None:
    if lower >= upper:
        return

    result = partition(xs, lower, upper)
    quick_sort_range(xs, lower, result.left_upper, partition)
    quick_sort_range(xs, result.right_lower, upper, partition)


def partition_2way(xs: list[int], lower: int, upper: int) -> PartitionResult:
    increment_index = lower
    decrement_index = upper
    pivot = xs[randint(lower, upper)]

    while increment_index <= decrement_index:
        while xs[increment_index] < pivot:
            increment_index += 1
        while xs[decrement_index] > pivot:
            decrement_index -= 1
        if increment_index <= decrement_index:
            swap(xs, increment_index, decrement_index)
            increment_index += 1
            decrement_index -= 1

    return PartitionResult(decrement_index, increment_index)


def partition_3way(xs: list[int], lower: int, upper: int) -> PartitionResult:
    less_end = lower
    increment_index = lower
    decrement_index = upper
    pivot = xs[randint(lower, upper)]

    while increment_index <= decrement_index:
        if xs[increment_index] < pivot:
            swap(xs, less_end, increment_index)
            less_end += 1
            increment_index += 1
        elif xs[increment_index] > pivot:
            swap(xs, increment_index, decrement_index)
            decrement_index -= 1
        else:
            increment_index += 1

    return PartitionResult(less_end - 1, increment_index)


def swap(xs: list[int], index1: int, index2: int) -> None:
    xs[index1], xs[index2] = xs[index2], xs[index1]


if __name__ == "__main__":
    main()

