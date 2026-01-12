require 'my_string'
require 'test/unit'

class MyStringTestCase < Test::Unit::TestCase

    def test_prefixes
        assert_equal [''], ''.prefixes
        assert_equal ['', 'a'], 'a'.prefixes
        assert_equal ['', 'a', 'ab'], 'ab'.prefixes
        assert_equal ['', 'a', 'ab', 'abc'], 'abc'.prefixes
        assert_equal ['', 'h', 'he', 'hel', 'hell', 'hello'], 'hello'.prefixes
    end

    def test_prefix?
        assert_equal true, ''.prefix?('')
        assert_equal true, 'abc'.prefix?('a')
        assert_equal true, 'abc'.prefix?('ab')
        assert_equal true, 'abc'.prefix?('abc')

        assert_equal false, ''.prefix?('a')
        assert_equal false, 'abc'.prefix?('b')
        assert_equal false, 'abc'.prefix?('abcd')
    end

    def test_proper_prefixes
        assert_equal [], ''.proper_prefixes
        assert_equal [''], 'a'.proper_prefixes
        assert_equal ['', 'a'], 'ab'.proper_prefixes
        assert_equal ['', 'a', 'ab'], 'abc'.proper_prefixes
        assert_equal ['', 'h', 'he', 'hel', 'hell'], 'hello'.proper_prefixes
    end

    def test_proper_prefix?
        assert_equal true, 'abc'.proper_prefix?('a')
        assert_equal true, 'abc'.proper_prefix?('ab')

        assert_equal false, ''.proper_prefix?('')
        assert_equal false, ''.proper_prefix?('a')
        assert_equal false, 'abc'.proper_prefix?('b')
        assert_equal false, 'abc'.proper_prefix?('abc')
        assert_equal false, 'abc'.proper_prefix?('abcd')
    end

    def test_suffixes
        assert_equal [''], ''.suffixes
        assert_equal ['', 'a'], 'a'.suffixes
        assert_equal ['', 'b', 'ab'], 'ab'.suffixes
        assert_equal ['', 'c', 'bc', 'abc'], 'abc'.suffixes
        assert_equal ['', 'o', 'lo', 'llo', 'ello', 'hello'], 'hello'.suffixes
    end

    def test_suffix?
        assert_equal true, ''.suffix?('')
        assert_equal true, 'abc'.suffix?('c')
        assert_equal true, 'abc'.suffix?('bc')
        assert_equal true, 'abc'.suffix?('abc')

        assert_equal false, ''.suffix?('a')
        assert_equal false, 'abc'.suffix?('b')
        assert_equal false, 'abc'.suffix?('xabc')
    end

    def test_proper_suffixes
        assert_equal [], ''.proper_suffixes
        assert_equal [''], 'a'.proper_suffixes
        assert_equal ['', 'b'], 'ab'.proper_suffixes
        assert_equal ['', 'c', 'bc'], 'abc'.proper_suffixes
        assert_equal ['', 'o', 'lo', 'llo', 'ello'], 'hello'.proper_suffixes
    end

    def test_proper_suffix?
        assert_equal true, 'abc'.proper_suffix?('c')
        assert_equal true, 'abc'.proper_suffix?('bc')

        assert_equal false, ''.proper_suffix?('')
        assert_equal false, ''.proper_suffix?('a')
        assert_equal false, 'abc'.proper_suffix?('b')
        assert_equal false, 'abc'.proper_suffix?('abc')
        assert_equal false, 'abc'.proper_suffix?('xabc')
    end

    def test_lps
        # ''
        assert_equal nil, ''.lps

        # 'AAAA'
        assert_equal '',    'A'.lps
        assert_equal 'A',   'AA'.lps
        assert_equal 'AA',  'AAA'.lps
        assert_equal 'AAA', 'AAAA'.lps

        # 'ABAB'
        assert_equal '',   'A'.lps
        assert_equal '',   'AB'.lps
        assert_equal 'A',  'ABA'.lps
        assert_equal 'AB', 'ABAB'.lps

        # 'ababab'
        assert_equal 'a',    'aba'.lps
        assert_equal 'ab',   'abab'.lps
        assert_equal 'aba',  'ababa'.lps
        assert_equal 'abab', 'ababab'.lps

        # 'ABCDABD'
        assert_equal '',   'ABCD'.lps
        assert_equal '',   'ABCD'.lps
        assert_equal 'A',  'ABCDA'.lps
        assert_equal 'AB', 'ABCDAB'.lps
        assert_equal '',   'ABCDABD'.lps

        # 'aacaaaac'
        assert_equal '',    'a'.lps
        assert_equal 'a',   'aa'.lps
        assert_equal '',    'aac'.lps
        assert_equal 'a',   'aaca'.lps
        assert_equal 'aa',  'aacaa'.lps
        assert_equal 'aa',  'aacaaa'.lps
        assert_equal 'aa',  'aacaaaa'.lps
        assert_equal 'aac', 'aacaaaac'.lps

        # 'AAAAABAAABA'
        assert_equal '',     'A'.lps
        assert_equal 'A',    'AA'.lps
        assert_equal 'AA',   'AAA'.lps
        assert_equal 'AAA',  'AAAA'.lps
        assert_equal 'AAAA', 'AAAAA'.lps
        assert_equal '',     'AAAAAB'.lps
        assert_equal 'A',    'AAAAABA'.lps
        assert_equal 'AA',   'AAAAABAA'.lps
        assert_equal 'AAA',  'AAAAABAAA'.lps
        assert_equal '',     'AAAAABAAAB'.lps
        assert_equal 'A',    'AAAAABAAABA'.lps
    end

    def test_lps_array
        assert_equal [], ''.lps_array
        assert_equal [0, 1, 2, 3], 'AAAA'.lps_array
        assert_equal [0, 0, 1, 2], 'ABAB'.lps_array
        assert_equal [0, 0, 1, 2, 3, 4], 'ababab'.lps_array
        assert_equal [0, 0, 0, 0, 1, 2, 0], 'ABCDABD'.lps_array
        assert_equal [0, 1, 0, 1, 2, 2, 2, 3], 'aacaaaac'.lps_array
        assert_equal [0, 1, 2, 3, 4, 0, 1, 2, 3, 0, 1], 'AAAAABAAABA'.lps_array
    end

end

