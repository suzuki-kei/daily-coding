import random


def main():
    values = make_random_values(20)
    print(" ".join(map(str, values)))
    quick_sort(values)
    print(" ".join(map(str, values)))


def make_random_values(n):
    return [
        random.randint(10, 99)
        for _ in range(n)
    ]


def quick_sort(values):
    _quick_sort(values, 0, len(values) - 1)


def _quick_sort(values, lower, upper):
    lower_index = lower
    upper_index = upper
    pivot = values[(lower + upper) // 2]

    while lower_index <= upper_index:
        while values[lower_index] < pivot:
            lower_index += 1
        while pivot < values[upper_index]:
            upper_index -= 1
        if lower_index <= upper_index:
            values[lower_index], values[upper_index] = values[upper_index], values[lower_index]
            lower_index += 1
            upper_index -= 1

    if lower < upper_index:
        _quick_sort(values, lower, upper_index)
    if lower_index < upper:
        _quick_sort(values, lower_index, upper)


if __name__ == "__main__":
    main()

