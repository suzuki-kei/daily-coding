import collections.abc


def flatten(values):
    flatten_values = []

    for value in values:
        if is_iterable(value):
            flatten_values.extend(flatten(value))
        else:
            flatten_values.append(value)
    return flatten_values


def flatten(values):
    def flatten(x):
        if x == []:
            return []
        if not is_iterable(x):
            return [x]
        return flatten(x[0]) + flatten(x[1:])
    return flatten(values)


def flatten(values):
    values = values.copy()

    while i := index_of(values, is_iterable):
        values[i : i + 1] = values[i]
    return values


def is_iterable(x):
    return isinstance(x, collections.abc.Iterable)


def index_of(values, predicate):
    for index, value in enumerate(values):
        if predicate(value):
            return index
    return None

