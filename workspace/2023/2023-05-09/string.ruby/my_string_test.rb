require 'my_string'
require 'test/unit'

class MyStringTestCase < Test::Unit::TestCase

    def test_prefixes
        expected = ['', 'h', 'he', 'hel', 'hell', 'hello']
        actual   = 'hello'.prefixes.sort_by(&:size)
        assert_equal expected, actual
    end

    def test_prefix?
        assert_equal true,  ''.prefix?('')
        assert_equal true,  'hello'.prefix?('')
        assert_equal true,  'hello'.prefix?('h')
        assert_equal true,  'hello'.prefix?('he')
        assert_equal true,  'hello'.prefix?('hel')
        assert_equal true,  'hello'.prefix?('hell')
        assert_equal true,  'hello'.prefix?('hello')
        assert_equal false, 'hello'.prefix?('bye')
        assert_equal false, 'hello'.prefix?('hello!')
    end

    def test_proper_prefixes
        expected = ['', 'h', 'he', 'hel', 'hell']
        actual   = 'hello'.proper_prefixes.sort_by(&:size)
        assert_equal expected, actual
    end

    def test_proper_prefix?
        assert_equal false, ''.proper_prefix?('')
        assert_equal true,  'hello'.proper_prefix?('')
        assert_equal true,  'hello'.proper_prefix?('h')
        assert_equal true,  'hello'.proper_prefix?('he')
        assert_equal true,  'hello'.proper_prefix?('hel')
        assert_equal true,  'hello'.proper_prefix?('hell')
        assert_equal false, 'hello'.proper_prefix?('hello')
        assert_equal false, 'hello'.proper_prefix?('bye')
        assert_equal false, 'hello'.proper_prefix?('hello!')
    end

    def test_suffixes
        expected = ['', 'o', 'lo', 'llo', 'ello', 'hello']
        actual   = 'hello'.suffixes.sort_by(&:size)
        assert_equal expected, actual
    end

    def test_suffix?
        assert_equal true,  ''.suffix?('')
        assert_equal true,  'hello'.suffix?('')
        assert_equal true,  'hello'.suffix?('o')
        assert_equal true,  'hello'.suffix?('lo')
        assert_equal true,  'hello'.suffix?('llo')
        assert_equal true,  'hello'.suffix?('ello')
        assert_equal true,  'hello'.suffix?('hello')
        assert_equal false, 'hello'.suffix?('bye')
        assert_equal false, 'hello'.suffix?('hello!')
    end

    def test_proper_suffixes
        expected = ['', 'o', 'lo', 'llo', 'ello']
        actual   = 'hello'.proper_suffixes.sort_by(&:size)
        assert_equal expected, actual
    end

    def test_proper_suffix?
        assert_equal false, ''.proper_suffix?('')
        assert_equal true,  'hello'.proper_suffix?('')
        assert_equal true,  'hello'.proper_suffix?('o')
        assert_equal true,  'hello'.proper_suffix?('lo')
        assert_equal true,  'hello'.proper_suffix?('llo')
        assert_equal true,  'hello'.proper_suffix?('ello')
        assert_equal false, 'hello'.proper_suffix?('hello')
        assert_equal false, 'hello'.proper_suffix?('bye')
        assert_equal false, 'hello'.proper_suffix?('hello!')
    end

    def test_borders
        expected = ['', 'a', 'aba', 'ababa']
        actual   = 'ababa'.borders.sort_by(&:size)
        assert_equal expected, actual
    end

    def test_border?
        assert_equal true, ''.border?('')
        assert_equal true, 'ababa'.border?('')
        assert_equal true, 'ababa'.border?('a')
        assert_equal true, 'ababa'.border?('aba')
        assert_equal true, 'ababa'.border?('ababa')
        assert_equal false, 'ababa'.border?('ab')
        assert_equal false, 'ababa'.border?('abab')
    end

    def test_substring?
        assert_equal true,  ''.substring?('')
        assert_equal false, ''.substring?('a')
        assert_equal true,  'abcde'.substring?('a')
        assert_equal true,  'abcde'.substring?('ab')
        assert_equal true,  'abcde'.substring?('bcd')
        assert_equal true,  'abcde'.substring?('cde')
        assert_equal true,  'abcde'.substring?('de')
        assert_equal true,  'abcde'.substring?('e')
        assert_equal false, 'abcde'.substring?('f')
    end

    def test_superstring?
        assert_equal true,  ''.superstring_of?([''])
        assert_equal false, ''.superstring_of?(['a'])
        assert_equal true,  'bacon lettuce tomato'.superstring_of?(['bacon'])
        assert_equal true,  'bacon lettuce tomato'.superstring_of?(['bacon', 'lettuce'])
        assert_equal true,  'bacon lettuce tomato'.superstring_of?(['bacon', 'lettuce', 'tomato'])
        assert_equal false, 'bacon lettuce tomato'.superstring_of?(['bacon', 'lettuce', 'tomato', 'sandwich'])
    end

    def test_lps_array
        assert_equal [0, 1, 2, 3], 'AAAA'.lps_array
        assert_equal [0, 0, 1, 2], 'ABAB'.lps_array
        assert_equal [0, 0, 1, 2, 3, 4], 'ababab'.lps_array
        assert_equal [0, 0, 0, 0, 1, 2, 0], 'ABCDABD'.lps_array
        assert_equal [0, 1, 0, 1, 2, 2, 2, 3], 'aacaaaac'.lps_array
        assert_equal [0, 1, 2, 3, 4, 0, 1, 2, 3, 0, 1], 'AAAAABAAABA'.lps_array
    end

end

