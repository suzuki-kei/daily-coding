import my_itertools
import operator
import unittest


def take5(iterable):
    return [
        next(iterable)
        for _ in range(5)
    ]


class ItertoolsTestCase(unittest.TestCase):

    def test_count(self):
        self.assertEqual(
            [0, 1, 2, 3, 4],
            take5(my_itertools.count()))
        self.assertEqual(
            [1, 2, 3, 4, 5],
            take5(my_itertools.count(start=1)))
        self.assertEqual(
            [0, 2, 4, 6, 8],
            take5(my_itertools.count(step=2)))
        self.assertEqual(
            [2, 5, 8, 11, 14],
            take5(my_itertools.count(start=2, step=3)))

    def test_cycle(self):
        with self.assertRaises(StopIteration):
            next(my_itertools.cycle([]))
        self.assertEqual(
            [1, 1, 1, 1, 1],
            take5(my_itertools.cycle([1])))
        self.assertEqual(
            [1, 2, 1, 2, 1],
            take5(my_itertools.cycle([1, 2])))
        self.assertEqual(
            [1, 2, 3, 1, 2],
            take5(my_itertools.cycle([1, 2, 3])))

    def test_repeat(self):
        self.assertEqual(
            [1, 1, 1, 1, 1],
            take5(my_itertools.repeat(1)))
        self.assertEqual(
            [1, 1, 1, 1, 1],
            take5(my_itertools.repeat(1, 5)))
        with self.assertRaises(StopIteration):
            take5(my_itertools.repeat(1, 4))

    def test_accumulate(self):
        self.assertEqual(
            [],
            list(my_itertools.accumulate([])))
        self.assertEqual(
            [1],
            list(my_itertools.accumulate([1])))
        self.assertEqual(
            [1, 3],
            list(my_itertools.accumulate([1, 2])))
        self.assertEqual(
            [1, 3, 6, 10, 15],
            list(my_itertools.accumulate([1, 2, 3, 4, 5])))
        self.assertEqual(
            [0],
            list(my_itertools.accumulate([], initial=0)))
        self.assertEqual(
            [0, 1, 3, 6, 10, 15],
            list(my_itertools.accumulate([1, 2, 3, 4, 5], initial=0)))
        self.assertEqual(
            [1, 2, 6, 24, 120],
            list(my_itertools.accumulate([1, 2, 3, 4, 5], operator.mul)))

    def test_batched(self):
        ...  # TODO

    def test_chain(self):
        self.assertEqual(
            [],
            list(my_itertools.chain([])))
        self.assertEqual(
            [1],
            list(my_itertools.chain([1])))
        self.assertEqual(
            [1, 2],
            list(my_itertools.chain([1, 2])))
        self.assertEqual(
            [1, 2, 3],
            list(my_itertools.chain([1, 2, 3])))
        self.assertEqual(
            [1, 2, 3, 4, 5, 6],
            list(my_itertools.chain([1, 2], [3, 4], [5, 6])))
        self.assertEqual(
            [1, 2, 3, 4, 5, 6],
            list(my_itertools.chain([1, 2, 3], [4, 5, 6])))

    def test_compress(self):
        self.assertEqual(
            [],
            list(my_itertools.compress([], [])))
        self.assertEqual(
            [1],
            list(my_itertools.compress([1], [True])))
        self.assertEqual(
            [],
            list(my_itertools.compress([1], [False])))
        self.assertEqual(
            [1, 3, 5],
            list(my_itertools.compress([1, 2, 3, 4, 5], [True, False, True, False, True])))

    def test_dropwhile(self):
        self.assertEqual(
            [],
            list(my_itertools.dropwhile(operator.truth, [])))
        self.assertEqual(
            [1],
            list(my_itertools.dropwhile(operator.truth, [1])))
        self.assertEqual(
            [1, 2],
            list(my_itertools.dropwhile(operator.truth, [1, 2])))
        self.assertEqual(
            [1, 2, 3],
            list(my_itertools.dropwhile(operator.truth, [1, 2, 3])))
        self.assertEqual(
            [],
            list(my_itertools.dropwhile(lambda x: x <= 0, [1, 2, 3, 4, 5])))
        self.assertEqual(
            [1, 2, 3],
            list(my_itertools.dropwhile(lambda x: x <= 3, [1, 2, 3, 4, 5])))

    def test_filterfalse(self):
        is_even = lambda x: x % 2 == 0

        self.assertEqual(
            [],
            list(my_itertools.filterfalse(is_even, [])))
        self.assertEqual(
            [],
            list(my_itertools.filterfalse(is_even, [0])))
        self.assertEqual(
            [1],
            list(my_itertools.filterfalse(is_even, [1])))
        self.assertEqual(
            [1, 3, 5],
            list(my_itertools.filterfalse(is_even, [1, 2, 3, 4, 5])))


if __name__ == "__main__":
    unittest.main()

