require 'kmp_search'
require 'test/unit'

class KmpSearchTestCase < Test::Unit::TestCase

    def test_create_lps_array
        assert_equal [], KmpSearch.create_lps_array('')
        assert_equal [0, 1, 2, 3], KmpSearch.create_lps_array('AAAA')
        assert_equal [0, 0, 1, 2], KmpSearch.create_lps_array('ABAB')
        assert_equal [0, 0, 1, 2, 3, 4], KmpSearch.create_lps_array('ababab')
        assert_equal [0, 0, 0, 0, 1, 2, 0], KmpSearch.create_lps_array('ABCDABD')
        assert_equal [0, 1, 0, 1, 2, 2, 2, 3], KmpSearch.create_lps_array('aacaaaac')
        assert_equal [0, 1, 2, 3, 4, 0, 1, 2, 3, 0, 1], KmpSearch.create_lps_array('AAAAABAAABA')
    end

    def test_kmp_search
        assert_equal  0, KmpSearch.kmp_search('', '')
        assert_equal  0, KmpSearch.kmp_search('a', '')
        assert_equal -1, KmpSearch.kmp_search('', 'a')

        assert_equal  0, KmpSearch.kmp_search('abcde', 'a')
        assert_equal  1, KmpSearch.kmp_search('abcde', 'b')
        assert_equal  2, KmpSearch.kmp_search('abcde', 'c')
        assert_equal  3, KmpSearch.kmp_search('abcde', 'd')
        assert_equal  4, KmpSearch.kmp_search('abcde', 'e')
        assert_equal -1, KmpSearch.kmp_search('abcde', 'f')

        assert_equal  0, KmpSearch.kmp_search('aaaaa', '')
        assert_equal  0, KmpSearch.kmp_search('aaaaa', 'a')
        assert_equal  0, KmpSearch.kmp_search('aaaaa', 'aa')
        assert_equal  0, KmpSearch.kmp_search('aaaaa', 'aaa')
        assert_equal  0, KmpSearch.kmp_search('aaaaa', 'aaaa')
        assert_equal  0, KmpSearch.kmp_search('aaaaa', 'aaaaa')
        assert_equal -1, KmpSearch.kmp_search('aaaaa', 'aaaaaa')
    end

end

