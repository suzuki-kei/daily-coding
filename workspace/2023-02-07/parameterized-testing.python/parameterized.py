import inspect
import unittest


def parameterized(tuples):
    def new_wrapper(method, tuple, i):
        wrapper = lambda self: method(self, *tuple)
        wrapper.__name__ = f"{method.__name__}_{i}"
        return wrapper

    def decorator(method):
        for i, tuple in enumerate(tuples):
            wrapper = new_wrapper(method, tuple, i)
            f_locals = inspect.currentframe().f_back.f_locals
            f_locals[wrapper.__name__] = wrapper

    return decorator


class TestCase(unittest.TestCase):

    @parameterized([
        # (expected, a, b)
        ( 3, 1, 2),
        ( 7, 3, 4),
        (11, 5, 6),
        ( 0, 7, 8),
    ])
    def test(self, expected, a, b):
        self.assertEqual(expected, a + b)


if __name__ == "__main__":
    unittest.main()

