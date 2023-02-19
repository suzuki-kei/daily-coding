require 'test/unit'
require 'caesar_cipher'

class TestCase < Test::Unit::TestCase

    def test_encode
        assert_equal('abc', encode('abc', 0))
        assert_equal('bcd', encode('abc', 1))
        assert_equal('cde', encode('abc', 2))
    end

    def test_decode
        assert_equal('abc', decode('abc', 0))
        assert_equal('abc', decode('bcd', 1))
        assert_equal('abc', decode('cde', 2))
    end

end

