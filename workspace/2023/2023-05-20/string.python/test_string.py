from parameterized import parameterized
import string
import unittest


class StringTestCase(unittest.TestCase):

    @parameterized([
        ([""], ""),
        (["", "a"], "a"),
        (["", "a", "ab"], "ab"),
        (["", "a", "ab", "abc"], "abc"),
    ])
    def test_prefixes(self, expected, text):
        self.assertEqual(expected, string.prefixes(text))

    @parameterized([
        ([], ""),
        ([""], "a"),
        (["", "a"], "ab"),
        (["", "a", "ab"], "abc"),
    ])
    def test_proper_prefixes(self, expected, text):
        self.assertEqual(expected, string.proper_prefixes(text))

    @parameterized([
        ([""], ""),
        (["", "a"], "a"),
        (["", "b", "ab"], "ab"),
        (["", "c", "bc", "abc"], "abc"),
    ])
    def test_suffixes(self, expected, text):
        self.assertEqual(expected, string.suffixes(text))

    @parameterized([
        ([], ""),
        ([""], "a"),
        (["", "b"], "ab"),
        (["", "c", "bc"], "abc"),
    ])
    def test_proper_suffixes(self, expected, text):
        self.assertEqual(expected, string.proper_suffixes(text))

    @parameterized([
        (None, ""),
        ("", "a"),
        ("a", "aa"),
        ("aa", "aaa"),
        ("", "ab"),
        ("ab", "abab"),
        ("abab", "ababab"),
        ("", "abc"),
        ("abc", "abcabc"),
        ("abcabc", "abcabcabc"),
    ])
    def test_lps(self, expected, text):
        self.assertEqual(expected, string.lps(text))

    @parameterized([
        ([], ""),
        ([0], "a"),
        ([0, 1], "aa"),
        ([0, 1, 2], "aaa"),
        ([0, 0], "ab"),
        ([0, 0, 1, 2], "abab"),
        ([0, 0, 1, 2, 3, 4], "ababab"),
        ([0, 0, 0], "abc"),
        ([0, 0, 0, 1, 2, 3], "abcabc"),
        ([0, 0, 0, 1, 2, 3, 4, 5, 6], "abcabcabc"),
    ])
    def test_lps_array(self, expected, text):
        self.assertEqual(expected, string.lps_array(text))


if __name__ == "__main__":
    unittest.main()

