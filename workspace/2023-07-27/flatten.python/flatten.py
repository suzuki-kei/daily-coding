import collections.abc


def flatten(values):
    flatten_values = []

    for value in values:
        if is_iterable(value):
            flatten_values.extend(flatten(value))
        else:
            flatten_values.append(value)
    return flatten_values


def is_iterable(x):
    return isinstance(x, collections.abc.Iterable)

