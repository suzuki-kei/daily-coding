import parameterized
import unittest


class TestCase(unittest.TestCase):

    @parameterized.expand({
        (1, 2): 3,
        (3, 4): 7,
        (5, 6): 11,
        (7, 8): 15,
    })
    def test_add(self, expected, a, b):
        self.assertEqual(expected, a + b)


if __name__ == "__main__":
    unittest.main()

