require 'my_string'
require 'test/unit'

class MyStringTestCase < Test::Unit::TestCase

    def test_prefixes
        assert_equal [''], ''.prefixes
        assert_equal ['', 'a'], 'a'.prefixes
        assert_equal ['', 'a', 'ab'], 'ab'.prefixes
        assert_equal ['', 'a', 'ab', 'abc'], 'abc'.prefixes
    end

    def test_proper_prefixes
        assert_equal [], ''.proper_prefixes
        assert_equal [''], 'a'.proper_prefixes
        assert_equal ['', 'a'], 'ab'.proper_prefixes
        assert_equal ['', 'a', 'ab'], 'abc'.proper_prefixes
    end

    def test_suffixes
        assert_equal [''], ''.suffixes
        assert_equal ['', 'a'], 'a'.suffixes
        assert_equal ['', 'b', 'ab'], 'ab'.suffixes
        assert_equal ['', 'c', 'bc', 'abc'], 'abc'.suffixes
    end

    def test_proper_suffixes
        assert_equal [], ''.proper_suffixes
        assert_equal [''], 'a'.proper_suffixes
        assert_equal ['', 'b'], 'ab'.proper_suffixes
        assert_equal ['', 'c', 'bc'], 'abc'.proper_suffixes
    end

    def test_lps
        # 空文字列.
        assert_equal nil, ''.lps

        # 'a' の繰り返し.
        assert_equal '', 'a'.lps
        assert_equal 'a', 'aa'.lps
        assert_equal 'aa', 'aaa'.lps

        # 'ab' の繰り返し.
        assert_equal '', 'ab'.lps
        assert_equal 'ab', 'abab'.lps
        assert_equal 'abab', 'ababab'.lps

        # 'abc' の繰り返し.
        assert_equal '', 'abc'.lps
        assert_equal 'abc', 'abcabc'.lps
        assert_equal 'abcabc', 'abcabcabc'.lps

        # 異なる文字からなる文字列.
        assert_equal '', 'abcdef'.lps
    end

    def test_lps_array
        # 空文字列.
        assert_equal [], ''.lps_array

        # 'a' の繰り返し.
        assert_equal [0], 'a'.lps_array
        assert_equal [0, 1], 'aa'.lps_array
        assert_equal [0, 1, 2], 'aaa'.lps_array

        # 'ab' の繰り返し.
        assert_equal [0, 0], 'ab'.lps_array
        assert_equal [0, 0, 1, 2], 'abab'.lps_array
        assert_equal [0, 0, 1, 2, 3, 4], 'ababab'.lps_array

        # 'abc' の繰り返し.
        assert_equal [0, 0, 0], 'abc'.lps_array
        assert_equal [0, 0, 0, 1, 2, 3], 'abcabc'.lps_array
        assert_equal [0, 0, 0, 1, 2, 3, 4, 5, 6], 'abcabcabc'.lps_array

        # 異なる文字からなる文字列.
        assert_equal [0, 0, 0, 0, 0, 0], 'abcdef'.lps_array
    end

end

