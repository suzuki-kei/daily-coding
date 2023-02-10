require 'test/unit'
require 'run_length_encoding'

class TestCase < Test::Unit::TestCase

    TEST_DATA_LISTS = [
        # [xs, runs, encoded_runs]
        [[],             [],                                   []],
        ['a'.chars,      ['a'.chars],                          [['a', 1]]],
        ['aa'.chars,     ['aa'.chars],                         [['a', 2]]],
        ['aaa'.chars,    ['aaa'.chars],                        [['a', 3]]],
        ['ab'.chars,     ['a'.chars, 'b'.chars],               [['a', 1], ['b', 1]]],
        ['abb'.chars,    ['a'.chars, 'bb'.chars],              [['a', 1], ['b', 2]]],
        ['aabccc'.chars, ['aa'.chars, 'b'.chars, 'ccc'.chars], [['a', 2], ['b', 1], ['c', 3]]],
    ]

    TEST_DATA_LISTS.each_with_index do |(xs, runs, encoded_runs), i|
        define_method("test_encode_decode_#{i}") do
            assert_equal(xs, decode(encode(xs)))
        end
    end

    TEST_DATA_LISTS.each_with_index do |(xs, runs, encoded_runs), i|
        define_method("test_encode_#{i}") do
            assert_equal(encoded_runs, encode(xs))
        end
    end

    TEST_DATA_LISTS.each_with_index do |(xs, runs, encoded_runs), i|
        define_method("test_decode_#{i}") do
            assert_equal(xs, decode(encoded_runs))
        end
    end

end

