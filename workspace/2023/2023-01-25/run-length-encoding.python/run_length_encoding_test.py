import unittest
from run_length_encoding import encode, decode
from parameterized_testing import parameterized


TEST_DATA_LISTS = [
    ([],                [],                         []),
    (list("a"),         [list("a")],                [("a", 1)]),
    (list("aa"),        [list("aa")],               [("a", 2)]),
    (list("aaa"),       [list("aaa")],              [("a", 3)]),
    (list("ab"),        [list("a"), list("b")],     [("a", 1), ("b", 1)]),
    (list("abb"),       [list("a"), list("bb")],    [("a", 1), ("b", 2)]),
    (list("aabccc"),    [list("aa"), list("b")],    [("a", 2), ("b", 1), ("c", 3)]),
]


class RunLengthEncodingTestCase(unittest.TestCase):

    @parameterized(TEST_DATA_LISTS)
    def test_encode_decode(self, xs, runs, encoded_runs):
        self.assertEqual(xs, decode(encode(xs)))

    @parameterized(TEST_DATA_LISTS)
    def test_encode(self, xs, runs, encoded_runs):
        self.assertEqual(encoded_runs, encode(xs))

    @parameterized(TEST_DATA_LISTS)
    def test_decode(self, xs, runs, encoded_runs):
        self.assertEqual(xs, decode(encoded_runs))


if __name__ == "__main__":
    unittest.main()

