import random


def main():
    values = generate_random_values(20)
    print(" ".join(map(str, values)))
    quick_sort(values)
    print(" ".join(map(str, values)))


def generate_random_values(n):
    return [
        random.randint(10, 99)
        for _ in range(n)
    ]


def quick_sort(values):
    quick_sort_range(values, 0, len(values) - 1)


def quick_sort_range(values, lower, upper):
    lower_index = lower
    upper_index = upper
    pivot = values[(lower + upper) // 2]

    while lower_index <= upper_index:
        while values[lower_index] < pivot:
            lower_index += 1
        while values[upper_index] > pivot:
            upper_index -= 1
        if lower_index <= upper_index:
            values[lower_index], values[upper_index] = values[upper_index], values[lower_index]
            lower_index += 1
            upper_index -= 1

    if lower < upper_index:
        quick_sort_range(values, lower, upper_index)
    if lower_index < upper:
        quick_sort_range(values, lower_index, upper)


if __name__ == "__main__":
    main()

