import collections.abc
import unittest


def is_flatten(values):
    return all(not is_iterable(value) for value in values)


def is_iterable(x):
    return isinstance(x, collections.abc.Iterable)


def index_of(values, predicate):
    for index, value in enumerate(values):
        if predicate(value):
            return index
    return None


# 再帰版
def flatten(values):
    flatten_values = []

    for value in values:
        if is_iterable(value):
            flatten_values.extend(flatten(value))
        else:
            flatten_values.append(value)
    return flatten_values


# 再帰版 (1 要素ずつ処理する)
def flatten(values):
    def flatten(x):
        if x == []:
            return []
        if not is_iterable(x):
            return [x]
        return flatten(x[0]) + flatten(x[1:])
    return flatten(values)


# 非再帰版
def flatten(values):
    values = values.copy()

    while i := index_of(values, is_iterable):
        values[i : i + 1] = values[i]
    return values


class TestCase(unittest.TestCase):

    def test_is_flatten(self):
        self.assertEqual(True, is_flatten([]))
        self.assertEqual(True, is_flatten([1]))
        self.assertEqual(True, is_flatten([1, 2, 3]))
        self.assertEqual(False, is_flatten([[]]))

    def test_flatten(self):
        self.assertEqual([], flatten([]))
        self.assertEqual([1], flatten([1]))
        self.assertEqual([1, 2, 3, 4, 5], flatten([1, [2], [[3, 4], 5]]))


if __name__ == "__main__":
    unittest.main()

