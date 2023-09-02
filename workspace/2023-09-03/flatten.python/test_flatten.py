from flatten import flatten
import unittest


class FlattenTestCase(unittest.TestCase):

    def test_flatten(self):
        self.assertEqual([], flatten([]))
        self.assertEqual([1], flatten([1]))
        self.assertEqual([1], flatten([[1]]))
        self.assertEqual([1, 2], flatten([1, 2]))
        self.assertEqual([1, 2], flatten([[1], [2]]))
        self.assertEqual([1, 2, 3, 4, 5], flatten([1, [2], [[3, 4], 5]]))


if __name__ == "__main__":
    unittest.main()

