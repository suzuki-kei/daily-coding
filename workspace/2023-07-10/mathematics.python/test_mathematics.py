import unittest
import mathematics
from parameterized import parameterized


class MathematicsTestCase(unittest.TestCase):

    @parameterized([
        (0, []),
        (1, [1]),
        (2, [1, 2]),
        (3, [1, 2, 3]),
        (4, [1, 2, 3, 4]),
        (5, [1, 2, 3, 4, 5]),
    ])
    def test_count(self, expected, xs):
        self.assertEqual(expected, mathematics.count(xs))

    @parameterized([
        ( 0, []),
        ( 1, [1]),
        ( 3, [1, 2]),
        ( 6, [1, 2, 3]),
        (10, [1, 2, 3, 4]),
        (15, [1, 2, 3, 4, 5]),
    ])
    def test_sum(self, expected, xs):
        self.assertEqual(expected, mathematics.sum(xs))

    @parameterized([
        (5, [5]),
        (4, [4, 5]),
        (3, [4, 5, 3]),
        (2, [2, 4, 5, 3]),
        (1, [2, 4, 5, 3, 1]),
    ])
    def test_minimum(self, expected, xs):
        self.assertEqual(expected, mathematics.minimum(xs))

    @parameterized([
        (1, [1]),
        (2, [2, 1]),
        (3, [2, 1, 3]),
        (4, [4, 2, 1, 3]),
        (5, [4, 2, 1, 3, 5]),
    ])
    def test_maximum(self, expected, xs):
        self.assertEqual(expected, mathematics.maximum(xs))

    @parameterized([
        ( 0.0 / 1, [1]),
        ( 0.5 / 2, [1, 2]),
        ( 2.0 / 3, [1, 2, 3]),
        ( 5.0 / 4, [1, 2, 3, 4]),
        (10.0 / 5, [1, 2, 3, 4, 5]),
    ])
    def test_variance(self, expected, xs):
        self.assertEqual(expected, mathematics.variance(xs))

    @parameterized([
        (( 0.0 / 1) ** 0.5, [1]),
        (( 0.5 / 2) ** 0.5, [1, 2]),
        (( 2.0 / 3) ** 0.5, [1, 2, 3]),
        (( 5.0 / 4) ** 0.5, [1, 2, 3, 4]),
        ((10.0 / 5) ** 0.5, [1, 2, 3, 4, 5]),
    ])
    def test_stddev(self, expected, xs):
        self.assertEqual(expected, mathematics.stddev(xs))


if __name__ == "__main__":
    unittest.main()

