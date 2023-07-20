
def main():
    values = [1, [2], [[3, 4], 5]]
    flatten_values = flatten(values)
    print(f"is_flatten={is_flatten(flatten_values)}")
    print(f"flatten_values={flatten_values}")


def is_flatten(values):
    return all(not isinstance(value, list) for value in values)


def index_by_class(values, class_or_tuple):
    for index, value in enumerate(values):
        if isinstance(value, class_or_tuple):
            return index
    return None


def flatten(values):
    while i := index_by_class(values, list):
        values[i : i + 1] = values[i]
    return values


if __name__ == "__main__":
    main()

