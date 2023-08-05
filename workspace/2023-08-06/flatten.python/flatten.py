import collections.abc


def is_iterable(x):
    return isinstance(x, collections.abc.Iterable)


def index_of(values, predicate):
    for i, value in enumerate(values):
        if predicate(value):
            return i
    return None


def flatten(values):
    while (i := index_of(values, is_iterable)) is not None:
        values[i : i + 1] = flatten(values[i])
    return values

