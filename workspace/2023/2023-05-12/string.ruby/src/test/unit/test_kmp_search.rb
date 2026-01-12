require 'kmp_search'
require 'test/unit'

class KmpSearchTestCase < Test::Unit::TestCase

    def test_lps
        assert_equal [], KmpSearch.lps('')
        assert_equal [0], KmpSearch.lps('a')
        assert_equal [0, 1], KmpSearch.lps('aa')
        assert_equal [0, 1, 2], KmpSearch.lps('aaa')
        assert_equal [0, 0, 1, 2], KmpSearch.lps('abab')
        assert_equal [0, 1, 0, 1, 2, 2, 2, 3, 4, 5], KmpSearch.lps('aacaaaacaa')
    end

    def test_kmp_search
        assert_equal 0, KmpSearch.kmp_search('', '')
        assert_equal 0, KmpSearch.kmp_search('a', 'a')
        assert_equal 0, KmpSearch.kmp_search('aabbcc', 'a')
        assert_equal 0, KmpSearch.kmp_search('aabbcc', 'aa')
        assert_equal 2, KmpSearch.kmp_search('aabbcc', 'b')
        assert_equal 2, KmpSearch.kmp_search('aabbcc', 'bb')
        assert_equal 4, KmpSearch.kmp_search('aabbcc', 'c')
        assert_equal 4, KmpSearch.kmp_search('aabbcc', 'cc')
        assert_equal -1, KmpSearch.kmp_search('aabbcc', 'd')
    end

end

