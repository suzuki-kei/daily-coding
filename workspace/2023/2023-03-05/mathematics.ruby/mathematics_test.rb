require 'test/unit'
require 'mathematics'

class TestCase < Test::Unit::TestCase

    [
        # [expected, xs]
        [0, []],
        [1, [1]],
        [2, [1, 2]],
        [3, [1, 2, 3]],
    ].each_with_index do |(expected, xs), index|
        define_method("test_count_#{index + 1}") do
            assert_equal(expected, count(xs))
        end
    end

    [
        # [expected, xs]
        [1, [1]],
        [1, [1, 2]],
        [1, [2, 1]],
        [1, [1, 2, 3]],
        [2, [2, 3, 4]],
        [3, [3, 4, 5]],
    ].each_with_index do |(expected, xs), index|
        define_method("test_minimum_#{index + 1}") do
            assert_equal(expected, minimum(xs))
        end
    end

    [
        # [expected, xs]
        [1, [1]],
        [2, [1, 2]],
        [2, [2, 1]],
        [3, [1, 2, 3]],
        [4, [2, 3, 4]],
        [5, [3, 4, 5]],
    ].each_with_index do |(expected, xs), index|
        define_method("test_maximum_#{index + 1}") do
            assert_equal(expected, maximum(xs))
        end
    end

    [
        # [expected, xs]
        [0, []],
        [1, [1]],
        [3, [1, 2]],
        [6, [1, 2, 3]],
        [10, [1, 2, 3, 4]],
        [15, [1, 2, 3, 4, 5]],
    ].each_with_index do |(expected, xs), index|
        define_method("test_sum_#{index + 1}") do
            assert_equal(expected, sum(xs))
        end
    end

    [
        # [expected, xs]
        [1, []],
        [1, [1]],
        [2, [1, 2]],
        [6, [1, 2, 3]],
        [24, [1, 2, 3, 4]],
        [120, [1, 2, 3, 4, 5]],
    ].each_with_index do |(expected, xs), index|
        define_method("test_product_#{index + 1}") do
            assert_equal(expected, product(xs))
        end
    end

    [
        # [expected, xs]
        [1.0, [1]],
        [1.5, [1, 2]],
        [2.0, [1, 2, 3]],
        [2.5, [1, 2, 3, 4]],
        [3.0, [1, 2, 3, 4, 5]],
    ].each_with_index do |(expected, xs), index|
        define_method("test_average_#{index + 1}") do
            assert_equal(expected, average(xs))
        end
    end

    [
        # [expected, xs]
        [ 0.0 / 1, [1]],
        [ 0.5 / 2, [1, 2]],
        [ 2.0 / 3, [1, 2, 3]],
        [ 5.0 / 4, [1, 2, 3, 4]],
        [10.0 / 5, [1, 2, 3, 4, 5]],
    ].each_with_index do |(expected, xs), index|
        define_method("test_variance_#{index + 1}") do
            assert_equal(expected, variance(xs))
        end
    end

    [
        # [expected, xs]
        [Math.sqrt( 0.0 / 1), [1]],
        [Math.sqrt( 0.5 / 2), [1, 2]],
        [Math.sqrt( 2.0 / 3), [1, 2, 3]],
        [Math.sqrt( 5.0 / 4), [1, 2, 3, 4]],
        [Math.sqrt(10.0 / 5), [1, 2, 3, 4, 5]],
    ].each_with_index do |(expected, xs), index|
        define_method("test_stddev_#{index + 1}") do
            assert_equal(expected, stddev(xs))
        end
    end

end

