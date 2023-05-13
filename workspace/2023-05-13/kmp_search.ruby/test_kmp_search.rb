require 'kmp_search'
require 'test/unit'

class KmpSearchTestCase < Test::Unit::TestCase

    def test_create_lps_array
        assert_equal [], create_lps_array('')

        assert_equal [0], create_lps_array('a')
        assert_equal [0, 1], create_lps_array('aa')
        assert_equal [0, 1, 2], create_lps_array('aaa')

        assert_equal [0, 0], create_lps_array('ab')
        assert_equal [0, 0, 1, 2], create_lps_array('abab')
        assert_equal [0, 0, 1, 2, 3, 4], create_lps_array('ababab')

        assert_equal [0, 0, 0], create_lps_array('abc')
        assert_equal [0, 0, 0, 1, 2, 3], create_lps_array('abcabc')
        assert_equal [0, 0, 0, 1, 2, 3, 4, 5, 6], create_lps_array('abcabcabc')
    end

    def test_kmp_search
        assert_equal 0, kmp_search('', '')
        assert_equal 0, kmp_search('aabbcc', '')
        assert_equal 0, kmp_search('aabbcc', 'a')
        assert_equal 0, kmp_search('aabbcc', 'aa')
        assert_equal 2, kmp_search('aabbcc', 'b')
        assert_equal 2, kmp_search('aabbcc', 'bb')
        assert_equal 4, kmp_search('aabbcc', 'c')
        assert_equal 4, kmp_search('aabbcc', 'cc')
        assert_equal -1, kmp_search('aabbcc', 'd')
    end

end

