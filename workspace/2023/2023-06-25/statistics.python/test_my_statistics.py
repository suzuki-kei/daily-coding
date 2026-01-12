import inspect
import unittest
import statistics
import my_statistics


class MyStatistaicsTestCase(unittest.TestCase):

    @staticmethod
    def parameterized(tuples):

        def decorator(method):
            f_locals = inspect.currentframe().f_back.f_locals
            f_locals |= make_wrapper_map(method, tuples)

        def make_wrapper_map(method, tuples):
            return {
                wrapper.__name__: wrapper
                for wrapper in make_wrappers(method, tuples)
            }

        def make_wrappers(method, tuples):
            return [
                make_wrapper(method, tuple, index)
                for index, tuple in enumerate(tuples)
            ]

        def make_wrapper(method, tuple, index):
            wrapper = lambda self: method(self, *tuple)
            wrapper.__name__ = f"{method.__name__}_{index + 1}"
            return wrapper

        return decorator

    @parameterized([
        (0.0, [0]),
        (1.0, [1]),
        (1.5, [1, 2]),
        (2.0, [1, 2, 3]),
        (2.5, [1, 2, 3, 4]),
        (3.0, [1, 2, 3, 4, 5]),
    ])
    def test_mean(self, expected, values):
        self.assertEqual(expected, statistics.mean(values))
        self.assertEqual(expected, my_statistics.mean(values))

    @parameterized([
        (0.0, [0]),
        (1.0, [1]),
        (1.5, [1, 2]),
        (2.0, [1, 2, 3]),
        (2.5, [1, 2, 3, 4]),
        (3.0, [1, 2, 3, 4, 5]),
    ])
    def test_median(self, expected, values):
        self.assertEqual(expected, statistics.median(values))
        self.assertEqual(expected, my_statistics.median(values))


    @parameterized([
        (0, [0]),
        (0, [0, 0, 1]),
        (1, [0, 1, 1]),
        (1, [0, 1, 1, 2]),
    ])
    def test_mode(self, expected, values):
        self.assertEqual(expected, statistics.mode(values))
        self.assertEqual(expected, my_statistics.mode(values))


if __name__ == "__main__":
    unittest.main()

