require 'test/unit'
require 'mathematics'
require 'parameterized'

class MathematicsTestCase < Test::Unit::TestCase

    parameterized :count, {
        []        => 0,
        [1]       => 1,
        [1, 2]    => 2,
        [1, 2, 3] => 3,
    }

    parameterized :minimum, {
        []        => nil,
        [1]       => 1,
        [2, 1]    => 1,
        [2, 1, 3] => 1,
    }

    parameterized :maximum, {
        []        => nil,
        [1]       => 1,
        [2, 1]    => 2,
        [2, 1, 3] => 3,
    }

    parameterized :sum, {
        []        => 0,
        [1]       => 1,
        [1, 2]    => 3,
        [1, 2, 3] => 6,
    }

    parameterized :average, {
        [1]       => 1.0,
        [1, 2]    => 1.5,
        [1, 2, 3] => 2.0,
    }

    parameterized :variance, {
        [1]             =>  0.0 / 1,
        [1, 2]          =>  0.5 / 2,
        [1, 2, 3]       =>  2.0 / 3,
        [1, 2, 3, 4]    =>  5.0 / 4,
        [1, 2, 3, 4, 5] => 10.0 / 5,
    }

    parameterized :stddev, {
        [1]             => ( 0.0 / 1) ** 0.5,
        [1, 2]          => ( 0.5 / 2) ** 0.5,
        [1, 2, 3]       => ( 2.0 / 3) ** 0.5,
        [1, 2, 3, 4]    => ( 5.0 / 4) ** 0.5,
        [1, 2, 3, 4, 5] => (10.0 / 5) ** 0.5,
    }

end

