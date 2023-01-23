import unittest
from run_length_encoding import encode, decode

TEST_DATA_TUPLES = [
    # [xs, runs, encoded_runs]
    [[],                             [],                                   []],
    [['a'],                          [['a']],                              [('a', 1)]],
    [['a', 'a'],                     [['a', 'a']],                         [('a', 2)]],
    [['a', 'a', 'a'],                [['a', 'a', 'a']],                    [('a', 3)]],
    [['a', 'b'],                     [['a'], ['b']],                       [('a', 1), ('b', 1)]],
    [['a', 'b', 'b'],                [['a'], ['b', 'b']],                  [('a', 1), ('b', 2)]],
    [['a', 'a', 'b', 'c', 'c', 'c'], [['a', 'a'], ['b'], ['c', 'c', 'c']], [('a', 2), ('b', 1), ('c', 3)]],
]

class RunLengthEncodingTestCase(unittest.TestCase):

    def test_encode_decode(self):
        for i, (xs, runs, encoded_runs) in enumerate(TEST_DATA_TUPLES):
            self.assertEqual(xs, decode(encode(xs)))

    def test_encode(self):
        for i, (xs, runs, encoded_runs) in enumerate(TEST_DATA_TUPLES):
            self.assertEqual(encoded_runs, encode(xs))

    def test_decode(self):
        for i, (xs, runs, encoded_runs) in enumerate(TEST_DATA_TUPLES):
            self.assertEqual(xs, decode(encoded_runs))

if __name__ == "__main__":
    unittest.main()

