import collections.abc


def is_iterable(value):
    return isinstance(value, collections.abc.Iterable)


def index_of(values, predicate):
    for index, value in enumerate(values):
        if predicate(value):
            return index
    return -1


def flatten(values):
    flatten_values = []

    for value in values:
        if is_iterable(value):
            flatten_values.extend(flatten(value))
        else:
            flatten_values.append(value)
    return flatten_values


def flatten(values):
    if values == []:
        return []
    if is_iterable(values[0]):
        return values[0] + flatten(values[1:])
    else:
        return values[:1] + flatten(values[1:])


def flatten(values):
    def flatten_destructive(values):
        while (i := index_of(values, is_iterable)) != -1:
            values[i : i + 1] = values[i]
        return values

    return flatten_destructive(values.copy())

