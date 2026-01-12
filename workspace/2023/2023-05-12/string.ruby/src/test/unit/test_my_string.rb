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
        assert_equal [], ''.lps
        assert_equal [0], 'a'.lps
        assert_equal [0, 1], 'aa'.lps
        assert_equal [0, 1, 2], 'aaa'.lps
        assert_equal [0, 0, 1, 2], 'abab'.lps
        assert_equal [0, 1, 0, 1, 2, 2, 2, 3, 4, 5], 'aacaaaacaa'.lps
    end

end

