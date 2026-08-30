import random


def main() -> None:
    value_range = range(0, 10)
    values = generate_random_values(value_range, 20)
    print_values(values)
    counting_sort(values, value_range)
    print_values(values)


def generate_random_values(value_range: range, n: int) -> list[int]:
    return [
        random.randrange(value_range.start, value_range.stop)
        for _ in range(n)
    ]


def print_values(values: list[int]) -> None:
    if is_sorted(values):
        print(f"{" ".join(map(str, values))} (sorted)")
    else:
        print(f"{" ".join(map(str, values))} (not sorted)")


def is_sorted(values: list[int]) -> bool:
    predicate = lambda i: values[i] <= values[i + 1]
    indexes = range(0, len(values) - 1)
    return all(map(predicate, indexes))


def counting_sort(values: list[int], value_range: range) -> None:
    counts = [0] * len(value_range)

    for value in values:
        counts[value - value_range.start] += 1

    i_values = 0

    for i_counts in range(len(counts)):
        for _ in range(counts[i_counts]):
            values[i_values] = i_counts + value_range.start
            i_values += 1


if __name__ == "__main__":
    main()

