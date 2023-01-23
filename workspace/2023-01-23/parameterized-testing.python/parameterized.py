import functools
import inspect
import unittest


def parameterized(tuples):
    def new_wrapper(wrapped, tuple):
        def wrapper(self):
            wrapped(self, *tuple)
        return wrapper

    def decorator(method):
        for i, tuple in enumerate(tuples):
            wrapper = new_wrapper(method, tuple)
            wrapper_name = f"{method.__name__}_{i + 1}"
            f_locals = inspect.currentframe().f_back.f_locals
            f_locals[wrapper_name] = wrapper

    return decorator


class TestCase(unittest.TestCase):

    @parameterized([
        # [expected, a, b]
        [ 3, 1, 2],
        [ 7, 3, 4],
        [11, 5, 6],
        [ 0, 7, 8],
    ])
    def test(self, expected, a, b):
        print([expected, a, b])
        self.assertEqual(expected, a + b)


if __name__ == "__main__":
    unittest.main()

