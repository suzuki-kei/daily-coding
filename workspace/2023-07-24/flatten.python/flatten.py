import collections.abc


def flatten(values):
    values = values.copy()

    while i := index_of(values, is_iterable):
        values[i : i + 1] = values[i]
    return values


def index_of(values, predicate):
    for index, value in enumerate(values):
        if predicate(value):
            return index
    return None


def is_iterable(x):
    return isinstance(x, collections.abc.Iterable)

