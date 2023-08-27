import collections.abc


def is_iterable(value):
    return isinstance(value, collections.abc.Iterable)


def index_of(values, predicate):
    for index, value in enumerate(values):
        if predicate(value):
            return index
    return None


def flatten(values):
    flatten_values = []

    for value in values:
        if is_iterable(value):
            flatten_values.extend(flatten(value))
        else:
            flatten_values.append(value)
    return flatten_values


def flatten(values):
    if len(values) == 0:
        return []
    if is_iterable(values[0]):
        return flatten(values[0]) + flatten(values[1:])
    else:
        return values[0:1] + flatten(values[1:])


def flatten(values):
    values = values.copy()

    while (index := index_of(values, is_iterable)) is not None:
        values[index : index + 1] = values[index]
    return values

