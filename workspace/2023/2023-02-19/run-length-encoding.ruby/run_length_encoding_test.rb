require 'test/unit'
require 'run_length_encoding'

class TestCase < Test::Unit::TestCase

    TEST_DATA_LIST = [
        # [xs, encoded_runs]
        [''.chars,       []],
        ['a'.chars,      [['a', 1]]],
        ['aa'.chars,     [['a', 2]]],
        ['ab'.chars,     [['a', 1], ['b', 1]]],
        ['aabccc'.chars, [['a', 2], ['b', 1], ['c', 3]]],
    ]

    TEST_DATA_LIST.each_with_index do |(xs, encoded_runs), i|
        define_method("test_encode_decode_#{i + 1}") do
            assert_equal(xs, decode(encode(xs)))
        end
    end

    TEST_DATA_LIST.each_with_index do |(xs, encoded_runs), i|
        define_method("test_encode_#{i + 1}") do
            assert_equal(encoded_runs, encode(xs))
        end
    end

    TEST_DATA_LIST.each_with_index do |(xs, encoded_runs), i|
        define_method("test_decode_#{i + 1}") do
            assert_equal(xs, decode(encoded_runs))
        end
    end

    def test_xs_to_runs
        assert_equal(
            [],
            xs_to_runs(''.chars))
        assert_equal(
            [['a', 'a'], ['b'], ['c', 'c', 'c']],
            xs_to_runs('aabccc'.chars))
    end

end

