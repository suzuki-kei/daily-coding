require 'test/unit'
require 'caesar_cipher'

class TestCase < Test::Unit::TestCase

    ENCODE_TEST_DATA_LIST = [
        # [expected, n, s]
        ["abcde", 0, "abcde"],
        ["bcdef", 1, "abcde"],
        ["cdefg", 2, "abcde"],
        ["Hello, World!", 0, "Hello, World!"],
        ["Ifmmp, Xpsme!", 1, "Hello, World!"],
        ["Jgnnq, Yqtnf!", 2, "Hello, World!"],
    ]
    ENCODE_TEST_DATA_LIST.each_with_index do |(expected, n, s), i|
        define_method("test_encode_#{i}") do
            assert_equal(expected, encode(n, s))
        end
    end

    DECODE_TEST_DATA_LIST = [
        # [expected, n, s]
        ["abcde", 0, "abcde"],
        ["abcde", 1, "bcdef"],
        ["abcde", 2, "cdefg"],
        ["Hello, World!", 0, "Hello, World!"],
        ["Hello, World!", 1, "Ifmmp, Xpsme!"],
        ["Hello, World!", 2, "Jgnnq, Yqtnf!"],
    ]
    DECODE_TEST_DATA_LIST.each_with_index do |(expected, n, s), i|
        define_method("test_decode_#{i}") do
            assert_equal(expected, decode(n, s))
        end
    end

end

