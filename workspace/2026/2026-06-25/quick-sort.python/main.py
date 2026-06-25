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
    values = generate_random_values(20)
    print_list(values)
    quick_sort(values, partition)
    print_list(values)


def generate_random_values(n: int) -> list[int]:
    return [
        randint(10, 99)
        for _ in range(n)
    ]


def print_list(values: list[int]) -> None:
    formatted = " ".join(map(str, values))

    if is_sorted(values):
        print(f"{formatted} (sorted)")
    else:
        print(f"{formatted} (not sorted)")


def is_sorted(values: list[int]) -> bool:
    return all(
        values[i] <= values[i + 1]
        for i in range(len(values) - 1)
    )


def quick_sort(values: list[int], partition: Partition) -> None:
    quick_sort_range(values, 0, len(values) - 1, partition)


def quick_sort_range(values: list[int], lower: int, upper: int, partition: Partition) -> None:
    if lower >= upper:
        return

    result = partition(values, lower, upper)
    quick_sort_range(values, lower, result.left_upper, partition)
    quick_sort_range(values, result.right_lower, upper, partition)


def partition_2way(values: list[int], lower: int, upper: int) -> PartitionResult:
    increment_index = lower
    decrement_index = upper
    pivot = values[randint(lower, upper)]

    while increment_index <= decrement_index:
        while values[increment_index] < pivot:
            increment_index += 1
        while values[decrement_index] > pivot:
            decrement_index -= 1
        if increment_index <= decrement_index:
            swap(values, increment_index, decrement_index)
            increment_index += 1
            decrement_index -= 1

    return PartitionResult(
        left_upper=decrement_index,
        right_lower=increment_index,
    )


def partition_3way(values: list[int], lower: int, upper: int) -> PartitionResult:
    less_end = lower
    increment_index = lower
    decrement_index = upper
    pivot = values[randint(lower, upper)]

    while increment_index <= decrement_index:
        if values[increment_index] < pivot:
            swap(values, less_end, increment_index)
            less_end += 1
            increment_index += 1
        elif values[increment_index] > pivot:
            swap(values, increment_index, decrement_index)
            decrement_index -= 1
        else:
            increment_index += 1

    return PartitionResult(
        left_upper=less_end - 1,
        right_lower=increment_index,
    )


def swap(values: list[int], index1: int, index2: int) -> None:
    values[index1], values[index2] = values[index2], values[index1]


if __name__ == "__main__":
    main()

