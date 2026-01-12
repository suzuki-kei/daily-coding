require 'test/unit'
require 'run_length_encoding'

class TestCase < Test::Unit::TestCase

    TEST_DATA_LISTS = [
        # [xs, runs, encoded_runs]
        [''.chars,       [],                                   []],
        ['a'.chars,      ['a'.chars],                          [['a', 1]]],
        ['aa'.chars,     ['aa'.chars],                         [['a', 2]]],
        ['aaa'.chars,    ['aaa'.chars],                        [['a', 3]]],
        ['ab'.chars,     ['a'.chars, 'b'.chars],               [['a', 1], ['b', 1]]],
        ['aabccc'.chars, ['aa'.chars, 'b'.chars, 'ccc'.chars], [['a', 2], ['b', 1], ['c', 3]]],
    ]

    TEST_DATA_LISTS.each_with_index do |(xs, runs, encoded_runs), i|
        define_method("test_encode_decode_#{i + 1}") do
            assert_equal(xs, decode(encode(xs)))
        end
    end

    TEST_DATA_LISTS.each_with_index do |(xs, runs, encoded_runs), i|
        define_method("test_encode_#{i + 1}") do
            assert_equal(encoded_runs, encode(xs))
        end
    end

    TEST_DATA_LISTS.each_with_index do |(xs, runs, encoded_runs), i|
        define_method("test_runs_to_encoded_runs_#{i + 1}") do
            assert_equal(encoded_runs, runs_to_encoded_runs(runs))
        end
    end

    TEST_DATA_LISTS.each_with_index do |(xs, runs, encoded_runs), i|
        define_method("test_xs_to_runs_#{i + 1}") do
            assert_equal(runs, xs_to_runs(xs))
        end
    end

    TEST_DATA_LISTS.each_with_index do |(xs, runs, encoded_runs), i|
        define_method("test_decode_#{i + 1}") do
            assert_equal(xs, decode(encoded_runs))
        end
    end

    TEST_DATA_LISTS.each_with_index do |(xs, runs, encoded_runs), i|
        define_method("test_encoded_runs_to_runs_#{i + 1}") do
            assert_equal(runs, encoded_runs_to_runs(encoded_runs))
        end
    end

    TEST_DATA_LISTS.each_with_index do |(xs, runs, encoded_runs), i|
        define_method("test_runs_to_xs_#{i + 1}") do
            assert_equal(xs, runs_to_xs(runs))
        end
    end

end

