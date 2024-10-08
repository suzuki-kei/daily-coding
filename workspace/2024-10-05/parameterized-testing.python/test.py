import unittest

import parameterized


class TestCase(unittest.TestCase):

    @parameterized.expand([
        ( 3, 1, 2),
        ( 7, 3, 4),
        (11, 5, 6),
        (15, 7, 8),
    ])
    def test_add(self, expected, a, b):
        self.assertEqual(expected, a + b)


if __name__ == "__main__":
    unittest.main()

