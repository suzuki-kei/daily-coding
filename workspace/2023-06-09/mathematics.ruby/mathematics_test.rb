require 'test/unit'
require 'mathematics'

class TestCase < Test::Unit::TestCase

    def self.parameterized(target, xs_expected_map)
        xs_expected_map.each_with_index do |(xs, expected), index|
            define_method("test_#{target}_#{index + 1}") do
                actual = method(target).call(xs)
                assert_equal(expected, actual)
            end
        end
    end

    parameterized :count, {
        [] => 0,
        [1] => 1,
        [1, 2] => 2,
        [1, 2, 3] => 3,
    }

    parameterized :minimum, {
        [0] => 0,
        [0, 1] => 0,
        [2, 0, 1] => 0,
        [2, 0, 1, 3] => 0,
        [1, 2, 3] => 1,
        [2, 3, 4] => 2,
        [3, 4, 5] => 3,
    }

    parameterized :maximum, {
        [0] => 0,
        [0, 1] => 1,
        [2, 0, 1] => 2,
        [2, 0, 1, 3] => 3,
        [1, 2, 3] => 3,
        [2, 3, 4] => 4,
        [3, 4, 5] => 5,
    }

    parameterized :sum, {
        [] => 0,
        [0] => 0,
        [0, 1] => 1,
        [0, 1, 2] => 3,
        [0, 1, 2, 3] => 6,
    }

    parameterized :average, {
        [0] => 0,
        [1] => 1,
        [2] => 2,
        [0, 1] => 0.5,
        [0, 1, 2] => 1,
        [0, 1, 2, 3] => 1.5,
    }

    parameterized :variance, {
        [0] => 0.0 / 1,
        [1] => 0.0 / 1,
        [2] => 0.0 / 1,
        [1, 2] => 0.5 / 2,
        [1, 2, 3] => 2.0 / 3,
        [1, 2, 3, 4] => 5.0 / 4,
        [1, 2, 3, 4, 5] => 10.0 / 5,
    }

    parameterized :stddev, {
        [0] => Math.sqrt(0.0 / 1),
        [1] => Math.sqrt(0.0 / 1),
        [2] => Math.sqrt(0.0 / 1),
        [1, 2] => Math.sqrt(0.5 / 2),
        [1, 2, 3] => Math.sqrt(2.0 / 3),
        [1, 2, 3, 4] => Math.sqrt(5.0 / 4),
        [1, 2, 3, 4, 5] => Math.sqrt(10.0 / 5),
    }

end

