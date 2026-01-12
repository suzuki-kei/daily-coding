import random


def main():
    values = generate_random_ascending_values(20)
    print(" ".join(map(str, values)))

    lower = values[0] - 1
    upper = values[-1] + 1

    for target in range(lower, upper + 1):
        index = binary_search(values, target)
        print(f"target={target}, index={index}")


def generate_random_ascending_values(n):
    values = []
    offset = 10

    for _ in range(n):
        value = random.randint(offset, offset + 5)
        values.append(value)
        offset = value + 1

    return values


def binary_search(values, target):
    return binary_search_range(values, 0, len(values) - 1, target)


def binary_search_range(values, lower, upper, target):
    center = (lower + upper) // 2

    if center < lower or upper < center:
        return -1
    if target < values[center]:
        return binary_search_range(values, lower, center - 1, target)
    if target > values[center]:
        return binary_search_range(values, center + 1, upper, target)
    return center


if __name__ == "__main__":
    main()

