import random


def main() -> None:
    values = selection_without_replacement(min_value = 10, max_value = 99, n = 20)
    print(" ".join(map(str, values)))


def selection_without_replacement(min_value: int, max_value: int, n: int) -> list[int]:
    values: list[int] = []

    for value in range(min_value, max_value + 1):
        numerator = n - len(values)
        denominator = max_value - value + 1

        if random.random() < numerator / denominator:
            values.append(value)

    return values


if __name__ == "__main__":
    main()

