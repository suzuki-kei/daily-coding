require 'test/unit'
require 'mathematics'
require 'parameterized'

class TestCase < Test::Unit::TestCase

    parameterized :count, [
        # [expected, xs]
        [0, []],
        [1, [1]],
        [2, [1, 2]],
        [3, [1, 2, 3]],
        [4, [1, 2, 3, 4]],
        [5, [1, 2, 3, 4, 5]],
    ]

    parameterized :minimum, [
        # [expected, xs]
        [1, [1]],
        [1, [1, 2]],
        [1, [1, 2, 3]],
        [1, [1, 2, 3, 4]],
        [1, [1, 2, 3, 4, 5]],
    ]

    parameterized :maximum, [
        # [expected, xs]
        [1, [1]],
        [2, [1, 2]],
        [3, [1, 2, 3]],
        [4, [1, 2, 3, 4]],
        [5, [1, 2, 3, 4, 5]],
    ]

    parameterized :sum, [
        # [expected, xs]
        [0, []],
        [1, [1]],
        [3, [1, 2]],
        [6, [1, 2, 3]],
        [10, [1, 2, 3, 4]],
        [15, [1, 2, 3, 4, 5]],
    ]

    parameterized :product, [
        # [expected, xs]
        [1, []],
        [1, [1]],
        [2, [1, 2]],
        [6, [1, 2, 3]],
        [24, [1, 2, 3, 4]],
        [120, [1, 2, 3, 4, 5]],
    ]

    parameterized :average, [
        # [expected, xs]
        [1.0, [1]],
        [1.5, [1, 2]],
        [2.0, [1, 2, 3]],
        [2.5, [1, 2, 3, 4]],
        [3.0, [1, 2, 3, 4, 5]],
    ]

    parameterized :variance, [
        # [expected, xs]
        [0.0 / 1, [1]],
        [0.5 / 2, [1, 2]],
        [2.0 / 3, [1, 2, 3]],
        [5.0 / 4, [1, 2, 3, 4]],
        [10.0 / 5, [1, 2, 3, 4, 5]],
    ]

    parameterized :stddev, [
        # [expected, xs]
        [Math.sqrt(0.0 / 1), [1]],
        [Math.sqrt(0.5 / 2), [1, 2]],
        [Math.sqrt(2.0 / 3), [1, 2, 3]],
        [Math.sqrt(5.0 / 4), [1, 2, 3, 4]],
        [Math.sqrt(10.0 / 5), [1, 2, 3, 4, 5]],
    ]

end

